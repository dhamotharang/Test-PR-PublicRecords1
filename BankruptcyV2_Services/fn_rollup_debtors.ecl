IMPORT bankruptcyv3, suppress, CriminalRecords_Services, bankruptcyv2_services;
EXPORT fn_rollup_debtors(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyV3_search_full_bip())) in_records,
  STRING6 in_ssn_mask,
  BOOLEAN includeCriminalIndicators=FALSE) :=
FUNCTION
  // ID DEBTORS THAT ARE BIZ/PEOPLE.
  temp_exists_people := table(DEDUP(SORT(in_records,tmsid,debtor_type),tmsid,debtor_type[1]),{tmsid,debtor_type,did,bdid,app_ssn,ssn,app_tax_id,tax_id});
  // SLIM DOWN TO REQUIRED FIELDS. PROVIDE A KEY TO MATCH PARTIES
  // TO INSIDE THEDATA.
  temp_parties_slim :=
    JOIN(
      in_records,
      temp_exists_people,
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type[1] = RIGHT.debtor_type[1],
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_party_ext,
        SELF.debtor_type_1 := RIGHT.debtor_type[1],
        SELF.did := RIGHT.did,
        SELF.bdid := RIGHT.bdid,
        SELF.app_ssn := RIGHT.app_ssn,
        SELF.ssn := RIGHT.ssn,
        SELF.app_tax_id := RIGHT.app_tax_id,
        SELF.tax_id := RIGHT.tax_id,
        SELF := LEFT,
        SELF := []));
  // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PARTY FOR EACH TMSID
  temp_parties_dedup :=
    DEDUP(
      SORT(
        temp_parties_slim,
        RECORD),
      RECORD,EXCEPT date_last_seen,
      RIGHT);
  // JOIN TO THE ROLLED UP ADDRESSES
  temp_parties_add_addresses :=
    JOIN(
      temp_parties_dedup,
      bankruptcyv2_services.fn_rollup_debtor_addresses(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.addresses := RIGHT.addresses,
        SELF := LEFT),
      LEFT OUTER);
  // JOIN TO THE ROLLED UP NAMES
  temp_parties_add_names :=
    JOIN(
      temp_parties_add_addresses,
      bankruptcyv2_services.fn_rollup_debtor_names(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.names := RIGHT.names,
        SELF := LEFT),
      LEFT OUTER);
  // JOIN TO THE ROLLED UP PHONES
  temp_parties_add_phones :=
    JOIN(
      temp_parties_add_names,
      bankruptcyv2_services.fn_rollup_debtor_phones(in_records),
      LEFT.tmsid = RIGHT.tmsid AND
      LEFT.debtor_type_1 = RIGHT.debtor_type_1,
      TRANSFORM(
        RECORDOF(temp_parties_dedup),
        SELF.phones := RIGHT.phones,
        SELF := LEFT),
      LEFT OUTER);
  // SAVE THE MOST RECENT PARTIES FOR EACH TMSID
  temp_parties_keep :=
    SORT(
      temp_parties_add_phones,
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
      SELF.parties := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv2_services.layouts.layout_party),BankruptcyV2_Services.layouts.PARTIES_PER_ROLLUP),
      SELF := LEFT));
  RETURN
    temp_parties_roll;
END;
