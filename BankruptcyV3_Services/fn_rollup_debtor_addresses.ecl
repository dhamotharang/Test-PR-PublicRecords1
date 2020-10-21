IMPORT bankruptcyv3_services;
EXPORT fn_rollup_debtor_addresses(
  DATASET(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers) in_records) :=
    FUNCTION
      // SLIM DOWN TO REQUIRED FIELDS. ROLLUP ON BDID/DID OR IF NOT AVAILABLE
      // ROLLUP ON NAME.
      temp_addresses_slim :=
        PROJECT(
          in_records,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_address_ext,
            SELF.debtor_type_1 := LEFT.debtor_type[1],
            SELF := LEFT));
      // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE ADDRESS FOR EACH PARTY
      temp_addresses_dedup :=
        DEDUP(
          SORT(
            temp_addresses_slim,
            RECORD,EXCEPT bdid,did,ssn,app_ssn,tax_id,app_tax_id),
          RECORD,EXCEPT bdid,did,ssn,app_ssn,tax_id,app_tax_id,date_last_seen,
          RIGHT);
      // SAVE THE MOST RECENT ADDRESSES FOR EACH PARTY
      temp_addresses_keep :=
        SORT(
          temp_addresses_dedup,
          tmsid,defendantID,debtor_type_1,-date_last_seen);
      // ROLL UP THE ADDRESSES FOR EACH PARTY KEY
      temp_addresses_roll :=
        ROLLUP(
          GROUP(temp_addresses_keep,tmsid,defendantID,debtor_type_1),
          GROUP,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_address_roll,
            SELF.addresses := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_address),
                                      bankruptcyv3_services.consts.ADDRESSES_PER_PARTY),
            SELF := LEFT));
      RETURN
        temp_addresses_roll;
    END;
    
