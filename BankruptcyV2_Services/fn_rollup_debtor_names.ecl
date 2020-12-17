IMPORT bankruptcyv3,bankruptcyv2_services;
EXPORT fn_rollup_debtor_names(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyv3_search_full_bip())) in_records
  ) := 
FUNCTION
  // SLIM DOWN TO REQUIRED FIELDS. ROLLUP ON BDID/DID OR IF NOT AVAILABLE
  // ROLLUP ON NAME.
  temp_names_slim :=
    PROJECT(
      in_records,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_name_ext,
        SELF.debtor_type_1 := LEFT.debtor_type[1],
        SELF.HasCriminalConviction:=FALSE,
        SELF.IsSexualOffender:=FALSE,
        SELF := LEFT));
  // SAVE THE LATEST LAST SEEN DATE FOR EACH UNIQUE NAME FOR EACH PARTY
  temp_names_dedup :=
    DEDUP(
      SORT(
        temp_names_slim,
        RECORD),
      RECORD,EXCEPT date_last_seen,
      RIGHT);
  // SAVE THE MOST RECENT NAMES FOR EACH PARTY
  temp_names_keep :=
      SORT(
        temp_names_dedup,
        tmsid,debtor_type_1,debtor_type,-date_last_seen);
  // ROLL UP THE NAMES FOR EACH PARTY KEY
  temp_names_roll :=
    ROLLUP(
      GROUP(temp_names_keep,tmsid,debtor_type_1),
      GROUP,
      TRANSFORM(
        bankruptcyv2_services.layouts.layout_name_roll,
        SELF.names := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv2_services.layouts.layout_name),bankruptcyv2_services.layouts.NAMES_PER_PARTY),
        SELF := LEFT));
  RETURN
    temp_names_roll;
END;
    
