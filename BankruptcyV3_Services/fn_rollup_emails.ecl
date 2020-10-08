IMPORT bankruptcyv3_Services;
EXPORT fn_rollup_emails(
  DATASET(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records) :=
    FUNCTION
      // SLIM DOWN TO REQUIRED FIELDS. ROLLUP ON BDID/DID OR IF NOT AVAILABLE
      // ROLLUP ON NAME.
      temp_emails_slim :=
        PROJECT(
          in_records,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_email_ext,
            SELF.debtor_type_1 := LEFT.debtor_type[1],
            SELF := LEFT));
      // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE EMAIL FOR EACH PARTY
      temp_emails_dedup :=
        DEDUP(
          SORT(
            temp_emails_slim,
            RECORD),
          RECORD,EXCEPT date_last_seen,
          RIGHT);
      // SAVE THE MOST RECENT EMAILS FOR EACH PARTY
      temp_emails_keep :=
          SORT(
            temp_emails_dedup,
            tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id,-date_last_seen);
      // ROLL UP THE EMAILS FOR EACH PARTY KEY
      temp_emails_roll :=
        ROLLUP(
          GROUP(temp_emails_keep,tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id),
          GROUP,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_email_roll,
            SELF.emails := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_email),
                                  bankruptcyv3_services.consts.EMAILS_PER_PARTY),
            SELF := LEFT));
      RETURN
        temp_emails_roll;
    END;
    
