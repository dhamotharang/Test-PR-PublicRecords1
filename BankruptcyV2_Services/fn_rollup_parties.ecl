IMPORT bankruptcyv3,CriminalRecords_Services, bankruptcyv2_services;
EXPORT fn_rollup_parties(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyv3_search_full_bip())) in_records,
  STRING6 in_ssn_mask,
  BOOLEAN includeCriminalIndicators=FALSE
  ) := FUNCTION
  // SLIM DOWN TO REQUIRED FIELDS. PROVIDE A KEY TO MATCH PARTIES
  // TO INSIDE THEDATA.
  temp_parties_slim :=
    PROJECT(
      in_records,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_party_ext,
        SELF.debtor_type_1 := LEFT.debtor_type[1];
        SELF := LEFT,
        SELF := []));
  // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PARTY FOR EACH TMSID
  temp_parties_dedup :=
    DEDUP(SORT(temp_parties_slim,RECORD),
      RECORD,EXCEPT date_last_seen,RIGHT);
  // JOIN TO THE ROLLED UP ADDRESSES
  temp_parties_add_addresses :=
    JOIN(
      temp_parties_dedup,
      bankruptcyv2_services.fn_rollup_addresses(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
      LEFT.did = RIGHT.did AND
      LEFT.bdid = RIGHT.bdid AND
      LEFT.app_ssn = RIGHT.app_ssn AND
      LEFT.ssn = RIGHT.ssn AND
      LEFT.app_tax_id = RIGHT.app_tax_id AND
      LEFT.tax_id = RIGHT.tax_id,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.addresses := RIGHT.addresses,
        SELF := LEFT),
      LEFT OUTER);
  // JOIN TO THE ROLLED UP NAMES
  temp_parties_add_names :=
    JOIN(
      temp_parties_add_addresses,
      bankruptcyv2_services.fn_rollup_names(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
      LEFT.did = RIGHT.did AND
      LEFT.bdid = RIGHT.bdid AND
      LEFT.app_ssn = RIGHT.app_ssn AND
      LEFT.ssn = RIGHT.ssn AND
      LEFT.app_tax_id = RIGHT.app_tax_id AND
      LEFT.tax_id = RIGHT.tax_id,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.names := RIGHT.names,
        SELF := LEFT),
      LEFT OUTER);
  // JOIN TO THE ROLLED UP PHONES
  temp_parties_add_phones :=
    JOIN(
      temp_parties_add_names,
      bankruptcyv2_services.fn_rollup_phones(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
      LEFT.did = RIGHT.did AND
      LEFT.bdid = RIGHT.bdid AND
      LEFT.app_ssn = RIGHT.app_ssn AND
      LEFT.ssn = RIGHT.ssn AND
      LEFT.app_tax_id = RIGHT.app_tax_id AND
      LEFT.tax_id = RIGHT.tax_id,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.phones := RIGHT.phones,
        SELF := LEFT),
      LEFT OUTER);
  //JOIN to the ROLLED UP EMAILS
  temp_parties_add_emails :=
    JOIN(
      temp_parties_add_phones,
      bankruptcyv2_services.fn_rollup_emails(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
      LEFT.did = RIGHT.did AND
      LEFT.bdid = RIGHT.bdid AND
      LEFT.app_ssn = RIGHT.app_ssn AND
      LEFT.ssn = RIGHT.ssn AND
      LEFT.app_tax_id = RIGHT.app_tax_id AND
      LEFT.tax_id = RIGHT.tax_id,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.emails := RIGHT.emails,
        SELF := LEFT),
      LEFT OUTER);
  // SAVE THE MOST RECENT PARTIES FOR EACH TMSID
  temp_parties_keep :=
    SORT(
      temp_parties_add_emails,
      tmsid,names[1].debtor_type,-date_last_seen);
      
  tmp_parties_masked := fn_mask_ssns(temp_parties_keep, in_ssn_mask);
  
  // ADD CRIM INDICATORS
  recsIn := PROJECT(tmp_parties_masked,TRANSFORM({bankruptcyv2_services.layouts.layout_party_ext,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
  tmp_parties := PROJECT(IF(includeCriminalIndicators,recsOut,recsIn),bankruptcyv2_services.layouts.layout_party_ext);

  // ROLL UP THE PARTIES FOR EACH TMSID
  temp_parties_roll := ROLLUP(
    GROUP(tmp_parties,tmsid),
    GROUP,
    TRANSFORM(
      bankruptcyv2_services.layouts.layout_party_roll,
      SELF.parties := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv2_services.layouts.layout_party),bankruptcyv2_services.layouts.PARTIES_PER_ROLLUP),
      SELF := LEFT));
  RETURN temp_parties_roll;
END;
