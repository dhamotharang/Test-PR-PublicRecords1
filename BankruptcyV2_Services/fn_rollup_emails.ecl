IMPORT bankruptcyv3,ut, bankruptcyv2_services;
EXPORT fn_rollup_emails(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip())) in_records) :=
FUNCTION
  // SLIM DOWN TO REQUIRED FIELDS. ROLLUP ON BDID/DID OR IF NOT AVAILABLE
  // ROLLUP ON NAME.
  temp_emails_slim := PROJECT(in_records, 
    TRANSFORM(bankruptcyv2_services.layouts.layout_email_ext,
      SELF.debtor_type_1 := LEFT.debtor_type[1],
      SELF.HasCriminalConviction:=FALSE,
      SELF.IsSexualOffender:=FALSE,
      SELF := LEFT
    ));
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
        bankruptcyv2_services.layouts.layout_email_roll,
        SELF.emails := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv2_services.layouts.layout_email),bankruptcyv2_services.layouts.EMAILS_PER_PARTY),
        SELF := LEFT));
  RETURN temp_emails_roll;
END;
    
