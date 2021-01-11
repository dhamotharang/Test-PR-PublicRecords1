IMPORT bankruptcyv3, Data_Services, dx_Banko;

EXPORT fn_rollup_dockets(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full())) in_records, BOOLEAN isFCRA,
      STRING8 lower_entered_date, STRING8 upper_entered_date) :=
    FUNCTION

      // key containing docket info
      UNSIGNED1 env := IF(isFCRA, Data_Services.data_env.iFCRA, Data_Services.data_env.iNonFCRA);
      k_dock := dx_Banko.Key_Banko_courtcode_casenumber(env);

      // filter range of entereddate values
      EnteredDateFilter() := MACRO
        (RIGHT.entereddate[1..8] >= lower_entered_date OR lower_entered_date = '')
        AND
        (RIGHT.entereddate[1..8] <= upper_entered_date OR upper_entered_date = '')
      ENDMACRO;

      clean_docket_text(STRING5000 doc_txt) :=
        regexreplace('&AMP;',
                    // regexreplace('( *)',
                    TRIM(doc_txt, LEFT, RIGHT),
                    // ' '),
                    '&');

      temp_docket_evts :=
        JOIN(
          in_records,
          k_dock,
          LEFT.tmsid[3..7] = RIGHT.court_code AND LEFT.tmsid[8..] = RIGHT.casekey
          AND EnteredDateFilter(),
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_docket_ext,
            SELF.DocketText := clean_docket_text(RIGHT.DocketText);
            SELF := RIGHT,
            SELF := LEFT));

      /* Added AttachmentURL to the sort to prevent the dedup from selecting a docket item without
         an attachment URL when one with an attachment exists. Items without an attachment URL usually
         have an entrynumber of -1, but not always. */

      temp_docket_dedup :=
        DEDUP(
          SORT(
            temp_docket_evts(DocketText != ''),
            tmsid, FiledDate, entrynumber, -AttachmentURL, DocketText),
          tmsid, FiledDate, entrynumber, DocketText);
      temp_docket_keep :=
          SORT(
            temp_docket_dedup,
            tmsid, FiledDate, pacer_entereddate, (UNSIGNED) EntryNumber, DocketText);
      temp_docket_roll :=
        ROLLUP(
          GROUP(temp_docket_keep, tmsid),
          GROUP,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_docket_roll,
            SELF.dockets := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_docket),
                                     bankruptcyv3_services.consts.DOCKETS_PER_ROLLUP),
            SELF := LEFT));

      // output(temp_docket_evts, named('temp_docket_evts'));
      // output(temp_docket_dedup, named('temp_docket_dedup'));

      RETURN
        temp_docket_roll;
    END;
