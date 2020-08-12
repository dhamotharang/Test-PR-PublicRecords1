/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, Email_Data, STD, UT;

layout_email_raw := RECORD(Email_Data.Layout_Email.Keys)
END;

layout_email_rawrec := RECORD(layout_email_raw)
  $.Layouts.InternalMetadata;
END;


EXPORT RawEmail := MODULE

  EXPORT layout_email_out := RECORD($.Layouts.Metadata)
    layout_email_raw;
  END;

  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
               $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
    todaysdate := (STRING8) STD.Date.Today();

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.EMAIL_DATA);
    all_flags := flag_file(file_id = FCRA.FILE_ID.EMAIL_DATA);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_email_data_ffid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_email_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.email_rec_key=0 OR LEFT.record_id = (STRING) RIGHT.email_rec_key);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.email_rec_key;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, email_data.Key_Did_FCRA,
                          KEYED(LEFT.did = RIGHT.did),
                          TRANSFORM(layout_email_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.email_rec_key>0 AND (STRING)RIGHT.email_rec_key IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.email_rec_key>0 AND (STRING)RIGHT.email_rec_key IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.email_rec_key,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxEmailPerDID));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
      );

    layout_email_rawrec xformStatements(layout_email_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.record_ids.RecId1 = RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_email_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.EMAIL_DATA);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeEmail,OUTPUT(suppressed_recs, NAMED('Email_Data_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeEmail,OUTPUT(override_recs, NAMED('Email_Data_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeEmail,OUTPUT(main_recs, NAMED('Email_Data_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeEmail,OUTPUT(recs_out, NAMED('Email_Data_recs')));

    RETURN SORT(recs_out, -date_last_seen, -date_first_seen, RECORD);
  END;

END;
