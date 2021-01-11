IMPORT bankruptcyv3_services;
EXPORT fn_rollup_debtors(
  DATASET(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records,
  STRING6 in_ssn_mask) :=
    FUNCTION
      // ID DEBTORS THAT ARE BIZ/PEOPLE.
      temp_exists_people := table(DEDUP(SORT(in_records,tmsid,defendantID,debtor_type, RECORD),tmsid,defendantID,debtor_type[1]),{tmsid,defendantId,debtor_type,did,bdid,app_ssn,ssn,app_tax_id,tax_id});
      // SLIM DOWN TO REQUIRED FIELDS. PROVIDE A KEY TO MATCH PARTIES
      // TO INSIDE THEDATA.
      temp_parties_slim :=
        JOIN(
          in_records,
          temp_exists_people,
          LEFT.tmsid = RIGHT.tmsid AND
          LEFT.debtor_type[1] = RIGHT.debtor_type[1] AND
          LEFT.defendantID = RIGHT.defendantID,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_party_ext,
            SELF.debtor_type_1 := RIGHT.debtor_type[1],
            SELF.did := RIGHT.did,
            SELF.bdid := RIGHT.bdid,
            SELF.app_ssn := RIGHT.app_ssn,
            SELF.ssn := RIGHT.ssn,
            SELF.app_tax_id := RIGHT.app_tax_id,
            SELF.tax_id := RIGHT.tax_id,
            SELF.person_filter_id := BankruptcyV3_Services.fn_calc_person_filter_id(RIGHT.did, RIGHT.bdid, RIGHT.ssn, RIGHT.tax_id, , , ,),
            SELF := LEFT,
            SELF := []));
      // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE PARTY FOR EACH TMSID
      temp_parties_dedup :=
        DEDUP(
          SORT(
            temp_parties_slim,
            tmsid,debtor_type_1,defendantID,did,bdid,app_ssn,ssn,app_tax_id,tax_id,debtor_type,-date_last_seen),
          tmsid,debtor_type_1,defendantID,did,bdid,app_ssn,ssn,app_tax_id,tax_id);
          
      // JOIN TO THE ROLLED UP ADDRESSES
      temp_parties_add_addresses :=
        JOIN(
          temp_parties_dedup,
          bankruptcyv3_services.fn_rollup_debtor_addresses(in_records),
          LEFT.tmsid = RIGHT.tmsid AND
          LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
          LEFT.defendantID = RIGHT.defendantID,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_party_ext,
            SELF.addresses := RIGHT.addresses,
            SELF := LEFT),
          LEFT OUTER);
      // JOIN TO THE ROLLED UP NAMES
      temp_parties_add_names :=
        JOIN(
          temp_parties_add_addresses,
          bankruptcyv3_services.fn_rollup_debtor_names(in_records),
          LEFT.tmsid = RIGHT.tmsid AND
          LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
          LEFT.defendantID = RIGHT.defendantID,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_party_ext,
            SELF.names := RIGHT.names,
            SELF := LEFT),
          LEFT OUTER);
      // JOIN TO THE ROLLED UP PHONES
      temp_parties_add_phones :=
        JOIN(
          temp_parties_add_names,
          bankruptcyv3_services.fn_rollup_debtor_phones(in_records),
          LEFT.tmsid = RIGHT.tmsid AND
          LEFT.debtor_type_1 = RIGHT.debtor_type_1 AND
          LEFT.defendantID = RIGHT.defendantID,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_party_ext,
            SELF.phones := RIGHT.phones,
            SELF := LEFT),
          LEFT OUTER);
      // SAVE THE MOST RECENT PARTIES FOR EACH TMSID
      temp_parties_keep :=
        SORT(
          temp_parties_add_phones,
          tmsid,names[1].debtor_type,-date_last_seen);

      tmp_parties_masked := fn_mask_ssns(temp_parties_keep, in_ssn_mask);

      // ROLL UP THE PARTIES FOR EACH TMSID
      temp_parties_roll := ROLLUP(
        GROUP(tmp_parties_masked,tmsid),
        GROUP,
        TRANSFORM(
          bankruptcyv3_services.layouts.layout_party_roll,
          SELF.parties := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_party),
                                  bankruptcyv3_services.consts.PARTIES_PER_ROLLUP),
          SELF := LEFT));
      RETURN
        temp_parties_roll;
    END;
