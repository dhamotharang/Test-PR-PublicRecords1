IMPORT bankruptcyv3,ut,bankruptcyv2_services;
EXPORT fn_rollup_phones(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip())) in_records
  ) := FUNCTION
  // SLIM DOWN TO REQUIRED FIELDS. ROLLUP ON BDID/DID OR IF NOT AVAILABLE
  // ROLLUP ON NAME.
  temp_phones_slim :=
    PROJECT(
      in_records,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_phone_ext,
        SELF.debtor_type_1 := LEFT.debtor_type[1],
        SELF.timezone:='',
        SELF.HasCriminalConviction:=FALSE,
        SELF.IsSexualOffender:=FALSE,
        SELF := LEFT));
        
  ut.getTimeZone(temp_phones_slim,phone,timezone,temp_phones_w_tzone)
  // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PHONE FOR EACH PARTY
  temp_phones_dedup :=
    DEDUP(SORT(temp_phones_w_tzone, RECORD),
      RECORD,EXCEPT date_last_seen, RIGHT);
  // SAVE THE MOST RECENT PHONES FOR EACH PARTY
  temp_phones_keep :=
    SORT(
      temp_phones_dedup,
      tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id,-date_last_seen);
  // ROLL UP THE PHONES FOR EACH PARTY KEY
  temp_phones_roll :=
    ROLLUP(
      GROUP(temp_phones_keep,tmsid,debtor_type_1,bdid,did,ssn,app_ssn,tax_id,app_tax_id),
      GROUP,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_phone_roll,
        SELF.phones := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv2_services.layouts.layout_phone),bankruptcyv2_services.layouts.PHONES_PER_PARTY),
        SELF := LEFT));
  RETURN temp_phones_roll;
END;
    
