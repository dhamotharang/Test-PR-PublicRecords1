IMPORT bankruptcyv3_services,ut;
EXPORT fn_rollup_debtor_phones(
  DATASET(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records) :=
    FUNCTION
      // SLIM DOWN TO REQUIRED FIELDS. ROLLUP ON BDID/DID OR IF NOT AVAILABLE
      // ROLLUP ON NAME.
      temp_phones_slim :=
        PROJECT(
          in_records,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_phone_ext,
            SELF.debtor_type_1 := LEFT.debtor_type[1],
            SELF := LEFT,SELF.timezone :=''));
      ut.getTimeZone(temp_phones_slim,phone,timezone,temp_phones_w_tzone)
      
      // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PHONE FOR EACH PARTY
      temp_phones_dedup :=
        DEDUP(
          SORT(
            temp_phones_w_tzone,
            RECORD,EXCEPT bdid,did,ssn,app_ssn,tax_id,app_tax_id),
          RECORD,EXCEPT bdid,did,ssn,app_ssn,tax_id,app_tax_id,date_last_seen,
          RIGHT);
      // SAVE THE MOST RECENT PHONES FOR EACH PARTY
      temp_phones_keep :=
        SORT(
          temp_phones_dedup,
          tmsid,defendantID,debtor_type_1,-date_last_seen);
      // ROLL UP THE PHONES FOR EACH PARTY KEY
      temp_phones_roll :=
        ROLLUP(
          GROUP(temp_phones_keep,tmsid,defendantID,debtor_type_1),
          GROUP,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_phone_roll,
            SELF.phones := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_phone),
                                   bankruptcyv3_services.consts.PHONES_PER_PARTY),
            SELF := LEFT));
      RETURN
        temp_phones_roll;
    END;
    
