IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 226;
  EXPORT NumRulesFromFieldType := 226;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 88;
  EXPORT NumFieldsWithPossibleEdits := 88;
  EXPORT NumRulesWithPossibleEdits := 226;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 type_Invalid;
    BOOLEAN type_wouldClean;
    UNSIGNED1 confidence_Invalid;
    BOOLEAN confidence_wouldClean;
    UNSIGNED1 did1_Invalid;
    BOOLEAN did1_wouldClean;
    UNSIGNED1 did2_Invalid;
    BOOLEAN did2_wouldClean;
    UNSIGNED1 cohabit_score_Invalid;
    BOOLEAN cohabit_score_wouldClean;
    UNSIGNED1 cohabit_cnt_Invalid;
    BOOLEAN cohabit_cnt_wouldClean;
    UNSIGNED1 coapt_score_Invalid;
    BOOLEAN coapt_score_wouldClean;
    UNSIGNED1 coapt_cnt_Invalid;
    BOOLEAN coapt_cnt_wouldClean;
    UNSIGNED1 copobox_score_Invalid;
    BOOLEAN copobox_score_wouldClean;
    UNSIGNED1 copobox_cnt_Invalid;
    BOOLEAN copobox_cnt_wouldClean;
    UNSIGNED1 cossn_score_Invalid;
    BOOLEAN cossn_score_wouldClean;
    UNSIGNED1 cossn_cnt_Invalid;
    BOOLEAN cossn_cnt_wouldClean;
    UNSIGNED1 copolicy_score_Invalid;
    BOOLEAN copolicy_score_wouldClean;
    UNSIGNED1 copolicy_cnt_Invalid;
    BOOLEAN copolicy_cnt_wouldClean;
    UNSIGNED1 coclaim_score_Invalid;
    BOOLEAN coclaim_score_wouldClean;
    UNSIGNED1 coclaim_cnt_Invalid;
    BOOLEAN coclaim_cnt_wouldClean;
    UNSIGNED1 coproperty_score_Invalid;
    BOOLEAN coproperty_score_wouldClean;
    UNSIGNED1 coproperty_cnt_Invalid;
    BOOLEAN coproperty_cnt_wouldClean;
    UNSIGNED1 bcoproperty_score_Invalid;
    BOOLEAN bcoproperty_score_wouldClean;
    UNSIGNED1 bcoproperty_cnt_Invalid;
    BOOLEAN bcoproperty_cnt_wouldClean;
    UNSIGNED1 coforeclosure_score_Invalid;
    BOOLEAN coforeclosure_score_wouldClean;
    UNSIGNED1 coforeclosure_cnt_Invalid;
    BOOLEAN coforeclosure_cnt_wouldClean;
    UNSIGNED1 bcoforeclosure_score_Invalid;
    BOOLEAN bcoforeclosure_score_wouldClean;
    UNSIGNED1 bcoforeclosure_cnt_Invalid;
    BOOLEAN bcoforeclosure_cnt_wouldClean;
    UNSIGNED1 colien_score_Invalid;
    BOOLEAN colien_score_wouldClean;
    UNSIGNED1 colien_cnt_Invalid;
    BOOLEAN colien_cnt_wouldClean;
    UNSIGNED1 bcolien_score_Invalid;
    BOOLEAN bcolien_score_wouldClean;
    UNSIGNED1 bcolien_cnt_Invalid;
    BOOLEAN bcolien_cnt_wouldClean;
    UNSIGNED1 cobankruptcy_score_Invalid;
    BOOLEAN cobankruptcy_score_wouldClean;
    UNSIGNED1 cobankruptcy_cnt_Invalid;
    BOOLEAN cobankruptcy_cnt_wouldClean;
    UNSIGNED1 bcobankruptcy_score_Invalid;
    BOOLEAN bcobankruptcy_score_wouldClean;
    UNSIGNED1 bcobankruptcy_cnt_Invalid;
    BOOLEAN bcobankruptcy_cnt_wouldClean;
    UNSIGNED1 covehicle_score_Invalid;
    BOOLEAN covehicle_score_wouldClean;
    UNSIGNED1 covehicle_cnt_Invalid;
    BOOLEAN covehicle_cnt_wouldClean;
    UNSIGNED1 coexperian_score_Invalid;
    BOOLEAN coexperian_score_wouldClean;
    UNSIGNED1 coexperian_cnt_Invalid;
    BOOLEAN coexperian_cnt_wouldClean;
    UNSIGNED1 cotransunion_score_Invalid;
    BOOLEAN cotransunion_score_wouldClean;
    UNSIGNED1 cotransunion_cnt_Invalid;
    BOOLEAN cotransunion_cnt_wouldClean;
    UNSIGNED1 coenclarity_score_Invalid;
    BOOLEAN coenclarity_score_wouldClean;
    UNSIGNED1 coenclarity_cnt_Invalid;
    BOOLEAN coenclarity_cnt_wouldClean;
    UNSIGNED1 coecrash_score_Invalid;
    BOOLEAN coecrash_score_wouldClean;
    UNSIGNED1 coecrash_cnt_Invalid;
    BOOLEAN coecrash_cnt_wouldClean;
    UNSIGNED1 bcoecrash_score_Invalid;
    BOOLEAN bcoecrash_score_wouldClean;
    UNSIGNED1 bcoecrash_cnt_Invalid;
    BOOLEAN bcoecrash_cnt_wouldClean;
    UNSIGNED1 cowatercraft_score_Invalid;
    BOOLEAN cowatercraft_score_wouldClean;
    UNSIGNED1 cowatercraft_cnt_Invalid;
    BOOLEAN cowatercraft_cnt_wouldClean;
    UNSIGNED1 coaircraft_score_Invalid;
    BOOLEAN coaircraft_score_wouldClean;
    UNSIGNED1 coaircraft_cnt_Invalid;
    BOOLEAN coaircraft_cnt_wouldClean;
    UNSIGNED1 comarriagedivorce_score_Invalid;
    BOOLEAN comarriagedivorce_score_wouldClean;
    UNSIGNED1 comarriagedivorce_cnt_Invalid;
    BOOLEAN comarriagedivorce_cnt_wouldClean;
    UNSIGNED1 coucc_score_Invalid;
    BOOLEAN coucc_score_wouldClean;
    UNSIGNED1 coucc_cnt_Invalid;
    BOOLEAN coucc_cnt_wouldClean;
    UNSIGNED1 lname_score_Invalid;
    BOOLEAN lname_score_wouldClean;
    UNSIGNED1 phone_score_Invalid;
    BOOLEAN phone_score_wouldClean;
    UNSIGNED1 dl_nbr_score_Invalid;
    BOOLEAN dl_nbr_score_wouldClean;
    UNSIGNED1 total_cnt_Invalid;
    BOOLEAN total_cnt_wouldClean;
    UNSIGNED1 total_score_Invalid;
    BOOLEAN total_score_wouldClean;
    UNSIGNED1 cluster_Invalid;
    BOOLEAN cluster_wouldClean;
    UNSIGNED1 generation_Invalid;
    BOOLEAN generation_wouldClean;
    UNSIGNED1 gender_Invalid;
    BOOLEAN gender_wouldClean;
    UNSIGNED1 lname_cnt_Invalid;
    BOOLEAN lname_cnt_wouldClean;
    UNSIGNED1 rel_dt_first_seen_Invalid;
    BOOLEAN rel_dt_first_seen_wouldClean;
    UNSIGNED1 rel_dt_last_seen_Invalid;
    BOOLEAN rel_dt_last_seen_wouldClean;
    UNSIGNED1 overlap_months_Invalid;
    BOOLEAN overlap_months_wouldClean;
    UNSIGNED1 hdr_dt_first_seen_Invalid;
    BOOLEAN hdr_dt_first_seen_wouldClean;
    UNSIGNED1 hdr_dt_last_seen_Invalid;
    BOOLEAN hdr_dt_last_seen_wouldClean;
    UNSIGNED1 age_first_seen_Invalid;
    BOOLEAN age_first_seen_wouldClean;
    UNSIGNED1 isanylnamematch_Invalid;
    BOOLEAN isanylnamematch_wouldClean;
    UNSIGNED1 isanyphonematch_Invalid;
    BOOLEAN isanyphonematch_wouldClean;
    UNSIGNED1 isearlylnamematch_Invalid;
    BOOLEAN isearlylnamematch_wouldClean;
    UNSIGNED1 iscurrlnamematch_Invalid;
    BOOLEAN iscurrlnamematch_wouldClean;
    UNSIGNED1 ismixedlnamematch_Invalid;
    BOOLEAN ismixedlnamematch_wouldClean;
    UNSIGNED1 ssn1_Invalid;
    BOOLEAN ssn1_wouldClean;
    UNSIGNED1 ssn2_Invalid;
    BOOLEAN ssn2_wouldClean;
    UNSIGNED1 dob1_Invalid;
    BOOLEAN dob1_wouldClean;
    UNSIGNED1 dob2_Invalid;
    BOOLEAN dob2_wouldClean;
    UNSIGNED1 current_lname1_Invalid;
    BOOLEAN current_lname1_wouldClean;
    UNSIGNED1 current_lname2_Invalid;
    BOOLEAN current_lname2_wouldClean;
    UNSIGNED1 early_lname1_Invalid;
    BOOLEAN early_lname1_wouldClean;
    UNSIGNED1 early_lname2_Invalid;
    BOOLEAN early_lname2_wouldClean;
    UNSIGNED1 addr_ind1_Invalid;
    BOOLEAN addr_ind1_wouldClean;
    UNSIGNED1 addr_ind2_Invalid;
    BOOLEAN addr_ind2_wouldClean;
    UNSIGNED1 r2rdid_Invalid;
    BOOLEAN r2rdid_wouldClean;
    UNSIGNED1 r2cnt_Invalid;
    BOOLEAN r2cnt_wouldClean;
    UNSIGNED1 personal_Invalid;
    BOOLEAN personal_wouldClean;
    UNSIGNED1 business_Invalid;
    BOOLEAN business_wouldClean;
    UNSIGNED1 other_Invalid;
    BOOLEAN other_wouldClean;
    UNSIGNED1 title_Invalid;
    BOOLEAN title_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsCleanBits1;
    UNSIGNED8 ScrubsCleanBits2;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.type_Invalid := Fields.InValid_type((SALT39.StrType)le.type);
    clean_type := (TYPEOF(le.type))Fields.Make_type((SALT39.StrType)le.type);
    clean_type_Invalid := Fields.InValid_type((SALT39.StrType)clean_type);
    SELF.type := IF(withOnfail, clean_type, le.type); // ONFAIL(CLEAN)
    SELF.type_wouldClean := TRIM((SALT39.StrType)le.type) <> TRIM((SALT39.StrType)clean_type);
    SELF.confidence_Invalid := Fields.InValid_confidence((SALT39.StrType)le.confidence);
    clean_confidence := (TYPEOF(le.confidence))Fields.Make_confidence((SALT39.StrType)le.confidence);
    clean_confidence_Invalid := Fields.InValid_confidence((SALT39.StrType)clean_confidence);
    SELF.confidence := IF(withOnfail, clean_confidence, le.confidence); // ONFAIL(CLEAN)
    SELF.confidence_wouldClean := TRIM((SALT39.StrType)le.confidence) <> TRIM((SALT39.StrType)clean_confidence);
    SELF.did1_Invalid := Fields.InValid_did1((SALT39.StrType)le.did1);
    clean_did1 := (TYPEOF(le.did1))Fields.Make_did1((SALT39.StrType)le.did1);
    clean_did1_Invalid := Fields.InValid_did1((SALT39.StrType)clean_did1);
    SELF.did1 := IF(withOnfail, clean_did1, le.did1); // ONFAIL(CLEAN)
    SELF.did1_wouldClean := TRIM((SALT39.StrType)le.did1) <> TRIM((SALT39.StrType)clean_did1);
    SELF.did2_Invalid := Fields.InValid_did2((SALT39.StrType)le.did2);
    clean_did2 := (TYPEOF(le.did2))Fields.Make_did2((SALT39.StrType)le.did2);
    clean_did2_Invalid := Fields.InValid_did2((SALT39.StrType)clean_did2);
    SELF.did2 := IF(withOnfail, clean_did2, le.did2); // ONFAIL(CLEAN)
    SELF.did2_wouldClean := TRIM((SALT39.StrType)le.did2) <> TRIM((SALT39.StrType)clean_did2);
    SELF.cohabit_score_Invalid := Fields.InValid_cohabit_score((SALT39.StrType)le.cohabit_score);
    clean_cohabit_score := (TYPEOF(le.cohabit_score))Fields.Make_cohabit_score((SALT39.StrType)le.cohabit_score);
    clean_cohabit_score_Invalid := Fields.InValid_cohabit_score((SALT39.StrType)clean_cohabit_score);
    SELF.cohabit_score := IF(withOnfail, clean_cohabit_score, le.cohabit_score); // ONFAIL(CLEAN)
    SELF.cohabit_score_wouldClean := TRIM((SALT39.StrType)le.cohabit_score) <> TRIM((SALT39.StrType)clean_cohabit_score);
    SELF.cohabit_cnt_Invalid := Fields.InValid_cohabit_cnt((SALT39.StrType)le.cohabit_cnt);
    clean_cohabit_cnt := (TYPEOF(le.cohabit_cnt))Fields.Make_cohabit_cnt((SALT39.StrType)le.cohabit_cnt);
    clean_cohabit_cnt_Invalid := Fields.InValid_cohabit_cnt((SALT39.StrType)clean_cohabit_cnt);
    SELF.cohabit_cnt := IF(withOnfail, clean_cohabit_cnt, le.cohabit_cnt); // ONFAIL(CLEAN)
    SELF.cohabit_cnt_wouldClean := TRIM((SALT39.StrType)le.cohabit_cnt) <> TRIM((SALT39.StrType)clean_cohabit_cnt);
    SELF.coapt_score_Invalid := Fields.InValid_coapt_score((SALT39.StrType)le.coapt_score);
    clean_coapt_score := (TYPEOF(le.coapt_score))Fields.Make_coapt_score((SALT39.StrType)le.coapt_score);
    clean_coapt_score_Invalid := Fields.InValid_coapt_score((SALT39.StrType)clean_coapt_score);
    SELF.coapt_score := IF(withOnfail, clean_coapt_score, le.coapt_score); // ONFAIL(CLEAN)
    SELF.coapt_score_wouldClean := TRIM((SALT39.StrType)le.coapt_score) <> TRIM((SALT39.StrType)clean_coapt_score);
    SELF.coapt_cnt_Invalid := Fields.InValid_coapt_cnt((SALT39.StrType)le.coapt_cnt);
    clean_coapt_cnt := (TYPEOF(le.coapt_cnt))Fields.Make_coapt_cnt((SALT39.StrType)le.coapt_cnt);
    clean_coapt_cnt_Invalid := Fields.InValid_coapt_cnt((SALT39.StrType)clean_coapt_cnt);
    SELF.coapt_cnt := IF(withOnfail, clean_coapt_cnt, le.coapt_cnt); // ONFAIL(CLEAN)
    SELF.coapt_cnt_wouldClean := TRIM((SALT39.StrType)le.coapt_cnt) <> TRIM((SALT39.StrType)clean_coapt_cnt);
    SELF.copobox_score_Invalid := Fields.InValid_copobox_score((SALT39.StrType)le.copobox_score);
    clean_copobox_score := (TYPEOF(le.copobox_score))Fields.Make_copobox_score((SALT39.StrType)le.copobox_score);
    clean_copobox_score_Invalid := Fields.InValid_copobox_score((SALT39.StrType)clean_copobox_score);
    SELF.copobox_score := IF(withOnfail, clean_copobox_score, le.copobox_score); // ONFAIL(CLEAN)
    SELF.copobox_score_wouldClean := TRIM((SALT39.StrType)le.copobox_score) <> TRIM((SALT39.StrType)clean_copobox_score);
    SELF.copobox_cnt_Invalid := Fields.InValid_copobox_cnt((SALT39.StrType)le.copobox_cnt);
    clean_copobox_cnt := (TYPEOF(le.copobox_cnt))Fields.Make_copobox_cnt((SALT39.StrType)le.copobox_cnt);
    clean_copobox_cnt_Invalid := Fields.InValid_copobox_cnt((SALT39.StrType)clean_copobox_cnt);
    SELF.copobox_cnt := IF(withOnfail, clean_copobox_cnt, le.copobox_cnt); // ONFAIL(CLEAN)
    SELF.copobox_cnt_wouldClean := TRIM((SALT39.StrType)le.copobox_cnt) <> TRIM((SALT39.StrType)clean_copobox_cnt);
    SELF.cossn_score_Invalid := Fields.InValid_cossn_score((SALT39.StrType)le.cossn_score);
    clean_cossn_score := (TYPEOF(le.cossn_score))Fields.Make_cossn_score((SALT39.StrType)le.cossn_score);
    clean_cossn_score_Invalid := Fields.InValid_cossn_score((SALT39.StrType)clean_cossn_score);
    SELF.cossn_score := IF(withOnfail, clean_cossn_score, le.cossn_score); // ONFAIL(CLEAN)
    SELF.cossn_score_wouldClean := TRIM((SALT39.StrType)le.cossn_score) <> TRIM((SALT39.StrType)clean_cossn_score);
    SELF.cossn_cnt_Invalid := Fields.InValid_cossn_cnt((SALT39.StrType)le.cossn_cnt);
    clean_cossn_cnt := (TYPEOF(le.cossn_cnt))Fields.Make_cossn_cnt((SALT39.StrType)le.cossn_cnt);
    clean_cossn_cnt_Invalid := Fields.InValid_cossn_cnt((SALT39.StrType)clean_cossn_cnt);
    SELF.cossn_cnt := IF(withOnfail, clean_cossn_cnt, le.cossn_cnt); // ONFAIL(CLEAN)
    SELF.cossn_cnt_wouldClean := TRIM((SALT39.StrType)le.cossn_cnt) <> TRIM((SALT39.StrType)clean_cossn_cnt);
    SELF.copolicy_score_Invalid := Fields.InValid_copolicy_score((SALT39.StrType)le.copolicy_score);
    clean_copolicy_score := (TYPEOF(le.copolicy_score))Fields.Make_copolicy_score((SALT39.StrType)le.copolicy_score);
    clean_copolicy_score_Invalid := Fields.InValid_copolicy_score((SALT39.StrType)clean_copolicy_score);
    SELF.copolicy_score := IF(withOnfail, clean_copolicy_score, le.copolicy_score); // ONFAIL(CLEAN)
    SELF.copolicy_score_wouldClean := TRIM((SALT39.StrType)le.copolicy_score) <> TRIM((SALT39.StrType)clean_copolicy_score);
    SELF.copolicy_cnt_Invalid := Fields.InValid_copolicy_cnt((SALT39.StrType)le.copolicy_cnt);
    clean_copolicy_cnt := (TYPEOF(le.copolicy_cnt))Fields.Make_copolicy_cnt((SALT39.StrType)le.copolicy_cnt);
    clean_copolicy_cnt_Invalid := Fields.InValid_copolicy_cnt((SALT39.StrType)clean_copolicy_cnt);
    SELF.copolicy_cnt := IF(withOnfail, clean_copolicy_cnt, le.copolicy_cnt); // ONFAIL(CLEAN)
    SELF.copolicy_cnt_wouldClean := TRIM((SALT39.StrType)le.copolicy_cnt) <> TRIM((SALT39.StrType)clean_copolicy_cnt);
    SELF.coclaim_score_Invalid := Fields.InValid_coclaim_score((SALT39.StrType)le.coclaim_score);
    clean_coclaim_score := (TYPEOF(le.coclaim_score))Fields.Make_coclaim_score((SALT39.StrType)le.coclaim_score);
    clean_coclaim_score_Invalid := Fields.InValid_coclaim_score((SALT39.StrType)clean_coclaim_score);
    SELF.coclaim_score := IF(withOnfail, clean_coclaim_score, le.coclaim_score); // ONFAIL(CLEAN)
    SELF.coclaim_score_wouldClean := TRIM((SALT39.StrType)le.coclaim_score) <> TRIM((SALT39.StrType)clean_coclaim_score);
    SELF.coclaim_cnt_Invalid := Fields.InValid_coclaim_cnt((SALT39.StrType)le.coclaim_cnt);
    clean_coclaim_cnt := (TYPEOF(le.coclaim_cnt))Fields.Make_coclaim_cnt((SALT39.StrType)le.coclaim_cnt);
    clean_coclaim_cnt_Invalid := Fields.InValid_coclaim_cnt((SALT39.StrType)clean_coclaim_cnt);
    SELF.coclaim_cnt := IF(withOnfail, clean_coclaim_cnt, le.coclaim_cnt); // ONFAIL(CLEAN)
    SELF.coclaim_cnt_wouldClean := TRIM((SALT39.StrType)le.coclaim_cnt) <> TRIM((SALT39.StrType)clean_coclaim_cnt);
    SELF.coproperty_score_Invalid := Fields.InValid_coproperty_score((SALT39.StrType)le.coproperty_score);
    clean_coproperty_score := (TYPEOF(le.coproperty_score))Fields.Make_coproperty_score((SALT39.StrType)le.coproperty_score);
    clean_coproperty_score_Invalid := Fields.InValid_coproperty_score((SALT39.StrType)clean_coproperty_score);
    SELF.coproperty_score := IF(withOnfail, clean_coproperty_score, le.coproperty_score); // ONFAIL(CLEAN)
    SELF.coproperty_score_wouldClean := TRIM((SALT39.StrType)le.coproperty_score) <> TRIM((SALT39.StrType)clean_coproperty_score);
    SELF.coproperty_cnt_Invalid := Fields.InValid_coproperty_cnt((SALT39.StrType)le.coproperty_cnt);
    clean_coproperty_cnt := (TYPEOF(le.coproperty_cnt))Fields.Make_coproperty_cnt((SALT39.StrType)le.coproperty_cnt);
    clean_coproperty_cnt_Invalid := Fields.InValid_coproperty_cnt((SALT39.StrType)clean_coproperty_cnt);
    SELF.coproperty_cnt := IF(withOnfail, clean_coproperty_cnt, le.coproperty_cnt); // ONFAIL(CLEAN)
    SELF.coproperty_cnt_wouldClean := TRIM((SALT39.StrType)le.coproperty_cnt) <> TRIM((SALT39.StrType)clean_coproperty_cnt);
    SELF.bcoproperty_score_Invalid := Fields.InValid_bcoproperty_score((SALT39.StrType)le.bcoproperty_score);
    clean_bcoproperty_score := (TYPEOF(le.bcoproperty_score))Fields.Make_bcoproperty_score((SALT39.StrType)le.bcoproperty_score);
    clean_bcoproperty_score_Invalid := Fields.InValid_bcoproperty_score((SALT39.StrType)clean_bcoproperty_score);
    SELF.bcoproperty_score := IF(withOnfail, clean_bcoproperty_score, le.bcoproperty_score); // ONFAIL(CLEAN)
    SELF.bcoproperty_score_wouldClean := TRIM((SALT39.StrType)le.bcoproperty_score) <> TRIM((SALT39.StrType)clean_bcoproperty_score);
    SELF.bcoproperty_cnt_Invalid := Fields.InValid_bcoproperty_cnt((SALT39.StrType)le.bcoproperty_cnt);
    clean_bcoproperty_cnt := (TYPEOF(le.bcoproperty_cnt))Fields.Make_bcoproperty_cnt((SALT39.StrType)le.bcoproperty_cnt);
    clean_bcoproperty_cnt_Invalid := Fields.InValid_bcoproperty_cnt((SALT39.StrType)clean_bcoproperty_cnt);
    SELF.bcoproperty_cnt := IF(withOnfail, clean_bcoproperty_cnt, le.bcoproperty_cnt); // ONFAIL(CLEAN)
    SELF.bcoproperty_cnt_wouldClean := TRIM((SALT39.StrType)le.bcoproperty_cnt) <> TRIM((SALT39.StrType)clean_bcoproperty_cnt);
    SELF.coforeclosure_score_Invalid := Fields.InValid_coforeclosure_score((SALT39.StrType)le.coforeclosure_score);
    clean_coforeclosure_score := (TYPEOF(le.coforeclosure_score))Fields.Make_coforeclosure_score((SALT39.StrType)le.coforeclosure_score);
    clean_coforeclosure_score_Invalid := Fields.InValid_coforeclosure_score((SALT39.StrType)clean_coforeclosure_score);
    SELF.coforeclosure_score := IF(withOnfail, clean_coforeclosure_score, le.coforeclosure_score); // ONFAIL(CLEAN)
    SELF.coforeclosure_score_wouldClean := TRIM((SALT39.StrType)le.coforeclosure_score) <> TRIM((SALT39.StrType)clean_coforeclosure_score);
    SELF.coforeclosure_cnt_Invalid := Fields.InValid_coforeclosure_cnt((SALT39.StrType)le.coforeclosure_cnt);
    clean_coforeclosure_cnt := (TYPEOF(le.coforeclosure_cnt))Fields.Make_coforeclosure_cnt((SALT39.StrType)le.coforeclosure_cnt);
    clean_coforeclosure_cnt_Invalid := Fields.InValid_coforeclosure_cnt((SALT39.StrType)clean_coforeclosure_cnt);
    SELF.coforeclosure_cnt := IF(withOnfail, clean_coforeclosure_cnt, le.coforeclosure_cnt); // ONFAIL(CLEAN)
    SELF.coforeclosure_cnt_wouldClean := TRIM((SALT39.StrType)le.coforeclosure_cnt) <> TRIM((SALT39.StrType)clean_coforeclosure_cnt);
    SELF.bcoforeclosure_score_Invalid := Fields.InValid_bcoforeclosure_score((SALT39.StrType)le.bcoforeclosure_score);
    clean_bcoforeclosure_score := (TYPEOF(le.bcoforeclosure_score))Fields.Make_bcoforeclosure_score((SALT39.StrType)le.bcoforeclosure_score);
    clean_bcoforeclosure_score_Invalid := Fields.InValid_bcoforeclosure_score((SALT39.StrType)clean_bcoforeclosure_score);
    SELF.bcoforeclosure_score := IF(withOnfail, clean_bcoforeclosure_score, le.bcoforeclosure_score); // ONFAIL(CLEAN)
    SELF.bcoforeclosure_score_wouldClean := TRIM((SALT39.StrType)le.bcoforeclosure_score) <> TRIM((SALT39.StrType)clean_bcoforeclosure_score);
    SELF.bcoforeclosure_cnt_Invalid := Fields.InValid_bcoforeclosure_cnt((SALT39.StrType)le.bcoforeclosure_cnt);
    clean_bcoforeclosure_cnt := (TYPEOF(le.bcoforeclosure_cnt))Fields.Make_bcoforeclosure_cnt((SALT39.StrType)le.bcoforeclosure_cnt);
    clean_bcoforeclosure_cnt_Invalid := Fields.InValid_bcoforeclosure_cnt((SALT39.StrType)clean_bcoforeclosure_cnt);
    SELF.bcoforeclosure_cnt := IF(withOnfail, clean_bcoforeclosure_cnt, le.bcoforeclosure_cnt); // ONFAIL(CLEAN)
    SELF.bcoforeclosure_cnt_wouldClean := TRIM((SALT39.StrType)le.bcoforeclosure_cnt) <> TRIM((SALT39.StrType)clean_bcoforeclosure_cnt);
    SELF.colien_score_Invalid := Fields.InValid_colien_score((SALT39.StrType)le.colien_score);
    clean_colien_score := (TYPEOF(le.colien_score))Fields.Make_colien_score((SALT39.StrType)le.colien_score);
    clean_colien_score_Invalid := Fields.InValid_colien_score((SALT39.StrType)clean_colien_score);
    SELF.colien_score := IF(withOnfail, clean_colien_score, le.colien_score); // ONFAIL(CLEAN)
    SELF.colien_score_wouldClean := TRIM((SALT39.StrType)le.colien_score) <> TRIM((SALT39.StrType)clean_colien_score);
    SELF.colien_cnt_Invalid := Fields.InValid_colien_cnt((SALT39.StrType)le.colien_cnt);
    clean_colien_cnt := (TYPEOF(le.colien_cnt))Fields.Make_colien_cnt((SALT39.StrType)le.colien_cnt);
    clean_colien_cnt_Invalid := Fields.InValid_colien_cnt((SALT39.StrType)clean_colien_cnt);
    SELF.colien_cnt := IF(withOnfail, clean_colien_cnt, le.colien_cnt); // ONFAIL(CLEAN)
    SELF.colien_cnt_wouldClean := TRIM((SALT39.StrType)le.colien_cnt) <> TRIM((SALT39.StrType)clean_colien_cnt);
    SELF.bcolien_score_Invalid := Fields.InValid_bcolien_score((SALT39.StrType)le.bcolien_score);
    clean_bcolien_score := (TYPEOF(le.bcolien_score))Fields.Make_bcolien_score((SALT39.StrType)le.bcolien_score);
    clean_bcolien_score_Invalid := Fields.InValid_bcolien_score((SALT39.StrType)clean_bcolien_score);
    SELF.bcolien_score := IF(withOnfail, clean_bcolien_score, le.bcolien_score); // ONFAIL(CLEAN)
    SELF.bcolien_score_wouldClean := TRIM((SALT39.StrType)le.bcolien_score) <> TRIM((SALT39.StrType)clean_bcolien_score);
    SELF.bcolien_cnt_Invalid := Fields.InValid_bcolien_cnt((SALT39.StrType)le.bcolien_cnt);
    clean_bcolien_cnt := (TYPEOF(le.bcolien_cnt))Fields.Make_bcolien_cnt((SALT39.StrType)le.bcolien_cnt);
    clean_bcolien_cnt_Invalid := Fields.InValid_bcolien_cnt((SALT39.StrType)clean_bcolien_cnt);
    SELF.bcolien_cnt := IF(withOnfail, clean_bcolien_cnt, le.bcolien_cnt); // ONFAIL(CLEAN)
    SELF.bcolien_cnt_wouldClean := TRIM((SALT39.StrType)le.bcolien_cnt) <> TRIM((SALT39.StrType)clean_bcolien_cnt);
    SELF.cobankruptcy_score_Invalid := Fields.InValid_cobankruptcy_score((SALT39.StrType)le.cobankruptcy_score);
    clean_cobankruptcy_score := (TYPEOF(le.cobankruptcy_score))Fields.Make_cobankruptcy_score((SALT39.StrType)le.cobankruptcy_score);
    clean_cobankruptcy_score_Invalid := Fields.InValid_cobankruptcy_score((SALT39.StrType)clean_cobankruptcy_score);
    SELF.cobankruptcy_score := IF(withOnfail, clean_cobankruptcy_score, le.cobankruptcy_score); // ONFAIL(CLEAN)
    SELF.cobankruptcy_score_wouldClean := TRIM((SALT39.StrType)le.cobankruptcy_score) <> TRIM((SALT39.StrType)clean_cobankruptcy_score);
    SELF.cobankruptcy_cnt_Invalid := Fields.InValid_cobankruptcy_cnt((SALT39.StrType)le.cobankruptcy_cnt);
    clean_cobankruptcy_cnt := (TYPEOF(le.cobankruptcy_cnt))Fields.Make_cobankruptcy_cnt((SALT39.StrType)le.cobankruptcy_cnt);
    clean_cobankruptcy_cnt_Invalid := Fields.InValid_cobankruptcy_cnt((SALT39.StrType)clean_cobankruptcy_cnt);
    SELF.cobankruptcy_cnt := IF(withOnfail, clean_cobankruptcy_cnt, le.cobankruptcy_cnt); // ONFAIL(CLEAN)
    SELF.cobankruptcy_cnt_wouldClean := TRIM((SALT39.StrType)le.cobankruptcy_cnt) <> TRIM((SALT39.StrType)clean_cobankruptcy_cnt);
    SELF.bcobankruptcy_score_Invalid := Fields.InValid_bcobankruptcy_score((SALT39.StrType)le.bcobankruptcy_score);
    clean_bcobankruptcy_score := (TYPEOF(le.bcobankruptcy_score))Fields.Make_bcobankruptcy_score((SALT39.StrType)le.bcobankruptcy_score);
    clean_bcobankruptcy_score_Invalid := Fields.InValid_bcobankruptcy_score((SALT39.StrType)clean_bcobankruptcy_score);
    SELF.bcobankruptcy_score := IF(withOnfail, clean_bcobankruptcy_score, le.bcobankruptcy_score); // ONFAIL(CLEAN)
    SELF.bcobankruptcy_score_wouldClean := TRIM((SALT39.StrType)le.bcobankruptcy_score) <> TRIM((SALT39.StrType)clean_bcobankruptcy_score);
    SELF.bcobankruptcy_cnt_Invalid := Fields.InValid_bcobankruptcy_cnt((SALT39.StrType)le.bcobankruptcy_cnt);
    clean_bcobankruptcy_cnt := (TYPEOF(le.bcobankruptcy_cnt))Fields.Make_bcobankruptcy_cnt((SALT39.StrType)le.bcobankruptcy_cnt);
    clean_bcobankruptcy_cnt_Invalid := Fields.InValid_bcobankruptcy_cnt((SALT39.StrType)clean_bcobankruptcy_cnt);
    SELF.bcobankruptcy_cnt := IF(withOnfail, clean_bcobankruptcy_cnt, le.bcobankruptcy_cnt); // ONFAIL(CLEAN)
    SELF.bcobankruptcy_cnt_wouldClean := TRIM((SALT39.StrType)le.bcobankruptcy_cnt) <> TRIM((SALT39.StrType)clean_bcobankruptcy_cnt);
    SELF.covehicle_score_Invalid := Fields.InValid_covehicle_score((SALT39.StrType)le.covehicle_score);
    clean_covehicle_score := (TYPEOF(le.covehicle_score))Fields.Make_covehicle_score((SALT39.StrType)le.covehicle_score);
    clean_covehicle_score_Invalid := Fields.InValid_covehicle_score((SALT39.StrType)clean_covehicle_score);
    SELF.covehicle_score := IF(withOnfail, clean_covehicle_score, le.covehicle_score); // ONFAIL(CLEAN)
    SELF.covehicle_score_wouldClean := TRIM((SALT39.StrType)le.covehicle_score) <> TRIM((SALT39.StrType)clean_covehicle_score);
    SELF.covehicle_cnt_Invalid := Fields.InValid_covehicle_cnt((SALT39.StrType)le.covehicle_cnt);
    clean_covehicle_cnt := (TYPEOF(le.covehicle_cnt))Fields.Make_covehicle_cnt((SALT39.StrType)le.covehicle_cnt);
    clean_covehicle_cnt_Invalid := Fields.InValid_covehicle_cnt((SALT39.StrType)clean_covehicle_cnt);
    SELF.covehicle_cnt := IF(withOnfail, clean_covehicle_cnt, le.covehicle_cnt); // ONFAIL(CLEAN)
    SELF.covehicle_cnt_wouldClean := TRIM((SALT39.StrType)le.covehicle_cnt) <> TRIM((SALT39.StrType)clean_covehicle_cnt);
    SELF.coexperian_score_Invalid := Fields.InValid_coexperian_score((SALT39.StrType)le.coexperian_score);
    clean_coexperian_score := (TYPEOF(le.coexperian_score))Fields.Make_coexperian_score((SALT39.StrType)le.coexperian_score);
    clean_coexperian_score_Invalid := Fields.InValid_coexperian_score((SALT39.StrType)clean_coexperian_score);
    SELF.coexperian_score := IF(withOnfail, clean_coexperian_score, le.coexperian_score); // ONFAIL(CLEAN)
    SELF.coexperian_score_wouldClean := TRIM((SALT39.StrType)le.coexperian_score) <> TRIM((SALT39.StrType)clean_coexperian_score);
    SELF.coexperian_cnt_Invalid := Fields.InValid_coexperian_cnt((SALT39.StrType)le.coexperian_cnt);
    clean_coexperian_cnt := (TYPEOF(le.coexperian_cnt))Fields.Make_coexperian_cnt((SALT39.StrType)le.coexperian_cnt);
    clean_coexperian_cnt_Invalid := Fields.InValid_coexperian_cnt((SALT39.StrType)clean_coexperian_cnt);
    SELF.coexperian_cnt := IF(withOnfail, clean_coexperian_cnt, le.coexperian_cnt); // ONFAIL(CLEAN)
    SELF.coexperian_cnt_wouldClean := TRIM((SALT39.StrType)le.coexperian_cnt) <> TRIM((SALT39.StrType)clean_coexperian_cnt);
    SELF.cotransunion_score_Invalid := Fields.InValid_cotransunion_score((SALT39.StrType)le.cotransunion_score);
    clean_cotransunion_score := (TYPEOF(le.cotransunion_score))Fields.Make_cotransunion_score((SALT39.StrType)le.cotransunion_score);
    clean_cotransunion_score_Invalid := Fields.InValid_cotransunion_score((SALT39.StrType)clean_cotransunion_score);
    SELF.cotransunion_score := IF(withOnfail, clean_cotransunion_score, le.cotransunion_score); // ONFAIL(CLEAN)
    SELF.cotransunion_score_wouldClean := TRIM((SALT39.StrType)le.cotransunion_score) <> TRIM((SALT39.StrType)clean_cotransunion_score);
    SELF.cotransunion_cnt_Invalid := Fields.InValid_cotransunion_cnt((SALT39.StrType)le.cotransunion_cnt);
    clean_cotransunion_cnt := (TYPEOF(le.cotransunion_cnt))Fields.Make_cotransunion_cnt((SALT39.StrType)le.cotransunion_cnt);
    clean_cotransunion_cnt_Invalid := Fields.InValid_cotransunion_cnt((SALT39.StrType)clean_cotransunion_cnt);
    SELF.cotransunion_cnt := IF(withOnfail, clean_cotransunion_cnt, le.cotransunion_cnt); // ONFAIL(CLEAN)
    SELF.cotransunion_cnt_wouldClean := TRIM((SALT39.StrType)le.cotransunion_cnt) <> TRIM((SALT39.StrType)clean_cotransunion_cnt);
    SELF.coenclarity_score_Invalid := Fields.InValid_coenclarity_score((SALT39.StrType)le.coenclarity_score);
    clean_coenclarity_score := (TYPEOF(le.coenclarity_score))Fields.Make_coenclarity_score((SALT39.StrType)le.coenclarity_score);
    clean_coenclarity_score_Invalid := Fields.InValid_coenclarity_score((SALT39.StrType)clean_coenclarity_score);
    SELF.coenclarity_score := IF(withOnfail, clean_coenclarity_score, le.coenclarity_score); // ONFAIL(CLEAN)
    SELF.coenclarity_score_wouldClean := TRIM((SALT39.StrType)le.coenclarity_score) <> TRIM((SALT39.StrType)clean_coenclarity_score);
    SELF.coenclarity_cnt_Invalid := Fields.InValid_coenclarity_cnt((SALT39.StrType)le.coenclarity_cnt);
    clean_coenclarity_cnt := (TYPEOF(le.coenclarity_cnt))Fields.Make_coenclarity_cnt((SALT39.StrType)le.coenclarity_cnt);
    clean_coenclarity_cnt_Invalid := Fields.InValid_coenclarity_cnt((SALT39.StrType)clean_coenclarity_cnt);
    SELF.coenclarity_cnt := IF(withOnfail, clean_coenclarity_cnt, le.coenclarity_cnt); // ONFAIL(CLEAN)
    SELF.coenclarity_cnt_wouldClean := TRIM((SALT39.StrType)le.coenclarity_cnt) <> TRIM((SALT39.StrType)clean_coenclarity_cnt);
    SELF.coecrash_score_Invalid := Fields.InValid_coecrash_score((SALT39.StrType)le.coecrash_score);
    clean_coecrash_score := (TYPEOF(le.coecrash_score))Fields.Make_coecrash_score((SALT39.StrType)le.coecrash_score);
    clean_coecrash_score_Invalid := Fields.InValid_coecrash_score((SALT39.StrType)clean_coecrash_score);
    SELF.coecrash_score := IF(withOnfail, clean_coecrash_score, le.coecrash_score); // ONFAIL(CLEAN)
    SELF.coecrash_score_wouldClean := TRIM((SALT39.StrType)le.coecrash_score) <> TRIM((SALT39.StrType)clean_coecrash_score);
    SELF.coecrash_cnt_Invalid := Fields.InValid_coecrash_cnt((SALT39.StrType)le.coecrash_cnt);
    clean_coecrash_cnt := (TYPEOF(le.coecrash_cnt))Fields.Make_coecrash_cnt((SALT39.StrType)le.coecrash_cnt);
    clean_coecrash_cnt_Invalid := Fields.InValid_coecrash_cnt((SALT39.StrType)clean_coecrash_cnt);
    SELF.coecrash_cnt := IF(withOnfail, clean_coecrash_cnt, le.coecrash_cnt); // ONFAIL(CLEAN)
    SELF.coecrash_cnt_wouldClean := TRIM((SALT39.StrType)le.coecrash_cnt) <> TRIM((SALT39.StrType)clean_coecrash_cnt);
    SELF.bcoecrash_score_Invalid := Fields.InValid_bcoecrash_score((SALT39.StrType)le.bcoecrash_score);
    clean_bcoecrash_score := (TYPEOF(le.bcoecrash_score))Fields.Make_bcoecrash_score((SALT39.StrType)le.bcoecrash_score);
    clean_bcoecrash_score_Invalid := Fields.InValid_bcoecrash_score((SALT39.StrType)clean_bcoecrash_score);
    SELF.bcoecrash_score := IF(withOnfail, clean_bcoecrash_score, le.bcoecrash_score); // ONFAIL(CLEAN)
    SELF.bcoecrash_score_wouldClean := TRIM((SALT39.StrType)le.bcoecrash_score) <> TRIM((SALT39.StrType)clean_bcoecrash_score);
    SELF.bcoecrash_cnt_Invalid := Fields.InValid_bcoecrash_cnt((SALT39.StrType)le.bcoecrash_cnt);
    clean_bcoecrash_cnt := (TYPEOF(le.bcoecrash_cnt))Fields.Make_bcoecrash_cnt((SALT39.StrType)le.bcoecrash_cnt);
    clean_bcoecrash_cnt_Invalid := Fields.InValid_bcoecrash_cnt((SALT39.StrType)clean_bcoecrash_cnt);
    SELF.bcoecrash_cnt := IF(withOnfail, clean_bcoecrash_cnt, le.bcoecrash_cnt); // ONFAIL(CLEAN)
    SELF.bcoecrash_cnt_wouldClean := TRIM((SALT39.StrType)le.bcoecrash_cnt) <> TRIM((SALT39.StrType)clean_bcoecrash_cnt);
    SELF.cowatercraft_score_Invalid := Fields.InValid_cowatercraft_score((SALT39.StrType)le.cowatercraft_score);
    clean_cowatercraft_score := (TYPEOF(le.cowatercraft_score))Fields.Make_cowatercraft_score((SALT39.StrType)le.cowatercraft_score);
    clean_cowatercraft_score_Invalid := Fields.InValid_cowatercraft_score((SALT39.StrType)clean_cowatercraft_score);
    SELF.cowatercraft_score := IF(withOnfail, clean_cowatercraft_score, le.cowatercraft_score); // ONFAIL(CLEAN)
    SELF.cowatercraft_score_wouldClean := TRIM((SALT39.StrType)le.cowatercraft_score) <> TRIM((SALT39.StrType)clean_cowatercraft_score);
    SELF.cowatercraft_cnt_Invalid := Fields.InValid_cowatercraft_cnt((SALT39.StrType)le.cowatercraft_cnt);
    clean_cowatercraft_cnt := (TYPEOF(le.cowatercraft_cnt))Fields.Make_cowatercraft_cnt((SALT39.StrType)le.cowatercraft_cnt);
    clean_cowatercraft_cnt_Invalid := Fields.InValid_cowatercraft_cnt((SALT39.StrType)clean_cowatercraft_cnt);
    SELF.cowatercraft_cnt := IF(withOnfail, clean_cowatercraft_cnt, le.cowatercraft_cnt); // ONFAIL(CLEAN)
    SELF.cowatercraft_cnt_wouldClean := TRIM((SALT39.StrType)le.cowatercraft_cnt) <> TRIM((SALT39.StrType)clean_cowatercraft_cnt);
    SELF.coaircraft_score_Invalid := Fields.InValid_coaircraft_score((SALT39.StrType)le.coaircraft_score);
    clean_coaircraft_score := (TYPEOF(le.coaircraft_score))Fields.Make_coaircraft_score((SALT39.StrType)le.coaircraft_score);
    clean_coaircraft_score_Invalid := Fields.InValid_coaircraft_score((SALT39.StrType)clean_coaircraft_score);
    SELF.coaircraft_score := IF(withOnfail, clean_coaircraft_score, le.coaircraft_score); // ONFAIL(CLEAN)
    SELF.coaircraft_score_wouldClean := TRIM((SALT39.StrType)le.coaircraft_score) <> TRIM((SALT39.StrType)clean_coaircraft_score);
    SELF.coaircraft_cnt_Invalid := Fields.InValid_coaircraft_cnt((SALT39.StrType)le.coaircraft_cnt);
    clean_coaircraft_cnt := (TYPEOF(le.coaircraft_cnt))Fields.Make_coaircraft_cnt((SALT39.StrType)le.coaircraft_cnt);
    clean_coaircraft_cnt_Invalid := Fields.InValid_coaircraft_cnt((SALT39.StrType)clean_coaircraft_cnt);
    SELF.coaircraft_cnt := IF(withOnfail, clean_coaircraft_cnt, le.coaircraft_cnt); // ONFAIL(CLEAN)
    SELF.coaircraft_cnt_wouldClean := TRIM((SALT39.StrType)le.coaircraft_cnt) <> TRIM((SALT39.StrType)clean_coaircraft_cnt);
    SELF.comarriagedivorce_score_Invalid := Fields.InValid_comarriagedivorce_score((SALT39.StrType)le.comarriagedivorce_score);
    clean_comarriagedivorce_score := (TYPEOF(le.comarriagedivorce_score))Fields.Make_comarriagedivorce_score((SALT39.StrType)le.comarriagedivorce_score);
    clean_comarriagedivorce_score_Invalid := Fields.InValid_comarriagedivorce_score((SALT39.StrType)clean_comarriagedivorce_score);
    SELF.comarriagedivorce_score := IF(withOnfail, clean_comarriagedivorce_score, le.comarriagedivorce_score); // ONFAIL(CLEAN)
    SELF.comarriagedivorce_score_wouldClean := TRIM((SALT39.StrType)le.comarriagedivorce_score) <> TRIM((SALT39.StrType)clean_comarriagedivorce_score);
    SELF.comarriagedivorce_cnt_Invalid := Fields.InValid_comarriagedivorce_cnt((SALT39.StrType)le.comarriagedivorce_cnt);
    clean_comarriagedivorce_cnt := (TYPEOF(le.comarriagedivorce_cnt))Fields.Make_comarriagedivorce_cnt((SALT39.StrType)le.comarriagedivorce_cnt);
    clean_comarriagedivorce_cnt_Invalid := Fields.InValid_comarriagedivorce_cnt((SALT39.StrType)clean_comarriagedivorce_cnt);
    SELF.comarriagedivorce_cnt := IF(withOnfail, clean_comarriagedivorce_cnt, le.comarriagedivorce_cnt); // ONFAIL(CLEAN)
    SELF.comarriagedivorce_cnt_wouldClean := TRIM((SALT39.StrType)le.comarriagedivorce_cnt) <> TRIM((SALT39.StrType)clean_comarriagedivorce_cnt);
    SELF.coucc_score_Invalid := Fields.InValid_coucc_score((SALT39.StrType)le.coucc_score);
    clean_coucc_score := (TYPEOF(le.coucc_score))Fields.Make_coucc_score((SALT39.StrType)le.coucc_score);
    clean_coucc_score_Invalid := Fields.InValid_coucc_score((SALT39.StrType)clean_coucc_score);
    SELF.coucc_score := IF(withOnfail, clean_coucc_score, le.coucc_score); // ONFAIL(CLEAN)
    SELF.coucc_score_wouldClean := TRIM((SALT39.StrType)le.coucc_score) <> TRIM((SALT39.StrType)clean_coucc_score);
    SELF.coucc_cnt_Invalid := Fields.InValid_coucc_cnt((SALT39.StrType)le.coucc_cnt);
    clean_coucc_cnt := (TYPEOF(le.coucc_cnt))Fields.Make_coucc_cnt((SALT39.StrType)le.coucc_cnt);
    clean_coucc_cnt_Invalid := Fields.InValid_coucc_cnt((SALT39.StrType)clean_coucc_cnt);
    SELF.coucc_cnt := IF(withOnfail, clean_coucc_cnt, le.coucc_cnt); // ONFAIL(CLEAN)
    SELF.coucc_cnt_wouldClean := TRIM((SALT39.StrType)le.coucc_cnt) <> TRIM((SALT39.StrType)clean_coucc_cnt);
    SELF.lname_score_Invalid := Fields.InValid_lname_score((SALT39.StrType)le.lname_score);
    clean_lname_score := (TYPEOF(le.lname_score))Fields.Make_lname_score((SALT39.StrType)le.lname_score);
    clean_lname_score_Invalid := Fields.InValid_lname_score((SALT39.StrType)clean_lname_score);
    SELF.lname_score := IF(withOnfail, clean_lname_score, le.lname_score); // ONFAIL(CLEAN)
    SELF.lname_score_wouldClean := TRIM((SALT39.StrType)le.lname_score) <> TRIM((SALT39.StrType)clean_lname_score);
    SELF.phone_score_Invalid := Fields.InValid_phone_score((SALT39.StrType)le.phone_score);
    clean_phone_score := (TYPEOF(le.phone_score))Fields.Make_phone_score((SALT39.StrType)le.phone_score);
    clean_phone_score_Invalid := Fields.InValid_phone_score((SALT39.StrType)clean_phone_score);
    SELF.phone_score := IF(withOnfail, clean_phone_score, le.phone_score); // ONFAIL(CLEAN)
    SELF.phone_score_wouldClean := TRIM((SALT39.StrType)le.phone_score) <> TRIM((SALT39.StrType)clean_phone_score);
    SELF.dl_nbr_score_Invalid := Fields.InValid_dl_nbr_score((SALT39.StrType)le.dl_nbr_score);
    clean_dl_nbr_score := (TYPEOF(le.dl_nbr_score))Fields.Make_dl_nbr_score((SALT39.StrType)le.dl_nbr_score);
    clean_dl_nbr_score_Invalid := Fields.InValid_dl_nbr_score((SALT39.StrType)clean_dl_nbr_score);
    SELF.dl_nbr_score := IF(withOnfail, clean_dl_nbr_score, le.dl_nbr_score); // ONFAIL(CLEAN)
    SELF.dl_nbr_score_wouldClean := TRIM((SALT39.StrType)le.dl_nbr_score) <> TRIM((SALT39.StrType)clean_dl_nbr_score);
    SELF.total_cnt_Invalid := Fields.InValid_total_cnt((SALT39.StrType)le.total_cnt);
    clean_total_cnt := (TYPEOF(le.total_cnt))Fields.Make_total_cnt((SALT39.StrType)le.total_cnt);
    clean_total_cnt_Invalid := Fields.InValid_total_cnt((SALT39.StrType)clean_total_cnt);
    SELF.total_cnt := IF(withOnfail, clean_total_cnt, le.total_cnt); // ONFAIL(CLEAN)
    SELF.total_cnt_wouldClean := TRIM((SALT39.StrType)le.total_cnt) <> TRIM((SALT39.StrType)clean_total_cnt);
    SELF.total_score_Invalid := Fields.InValid_total_score((SALT39.StrType)le.total_score);
    clean_total_score := (TYPEOF(le.total_score))Fields.Make_total_score((SALT39.StrType)le.total_score);
    clean_total_score_Invalid := Fields.InValid_total_score((SALT39.StrType)clean_total_score);
    SELF.total_score := IF(withOnfail, clean_total_score, le.total_score); // ONFAIL(CLEAN)
    SELF.total_score_wouldClean := TRIM((SALT39.StrType)le.total_score) <> TRIM((SALT39.StrType)clean_total_score);
    SELF.cluster_Invalid := Fields.InValid_cluster((SALT39.StrType)le.cluster);
    clean_cluster := (TYPEOF(le.cluster))Fields.Make_cluster((SALT39.StrType)le.cluster);
    clean_cluster_Invalid := Fields.InValid_cluster((SALT39.StrType)clean_cluster);
    SELF.cluster := IF(withOnfail, clean_cluster, le.cluster); // ONFAIL(CLEAN)
    SELF.cluster_wouldClean := TRIM((SALT39.StrType)le.cluster) <> TRIM((SALT39.StrType)clean_cluster);
    SELF.generation_Invalid := Fields.InValid_generation((SALT39.StrType)le.generation);
    clean_generation := (TYPEOF(le.generation))Fields.Make_generation((SALT39.StrType)le.generation);
    clean_generation_Invalid := Fields.InValid_generation((SALT39.StrType)clean_generation);
    SELF.generation := IF(withOnfail, clean_generation, le.generation); // ONFAIL(CLEAN)
    SELF.generation_wouldClean := TRIM((SALT39.StrType)le.generation) <> TRIM((SALT39.StrType)clean_generation);
    SELF.gender_Invalid := Fields.InValid_gender((SALT39.StrType)le.gender);
    clean_gender := (TYPEOF(le.gender))Fields.Make_gender((SALT39.StrType)le.gender);
    clean_gender_Invalid := Fields.InValid_gender((SALT39.StrType)clean_gender);
    SELF.gender := IF(withOnfail, clean_gender, le.gender); // ONFAIL(CLEAN)
    SELF.gender_wouldClean := TRIM((SALT39.StrType)le.gender) <> TRIM((SALT39.StrType)clean_gender);
    SELF.lname_cnt_Invalid := Fields.InValid_lname_cnt((SALT39.StrType)le.lname_cnt);
    clean_lname_cnt := (TYPEOF(le.lname_cnt))Fields.Make_lname_cnt((SALT39.StrType)le.lname_cnt);
    clean_lname_cnt_Invalid := Fields.InValid_lname_cnt((SALT39.StrType)clean_lname_cnt);
    SELF.lname_cnt := IF(withOnfail, clean_lname_cnt, le.lname_cnt); // ONFAIL(CLEAN)
    SELF.lname_cnt_wouldClean := TRIM((SALT39.StrType)le.lname_cnt) <> TRIM((SALT39.StrType)clean_lname_cnt);
    SELF.rel_dt_first_seen_Invalid := Fields.InValid_rel_dt_first_seen((SALT39.StrType)le.rel_dt_first_seen);
    clean_rel_dt_first_seen := (TYPEOF(le.rel_dt_first_seen))Fields.Make_rel_dt_first_seen((SALT39.StrType)le.rel_dt_first_seen);
    clean_rel_dt_first_seen_Invalid := Fields.InValid_rel_dt_first_seen((SALT39.StrType)clean_rel_dt_first_seen);
    SELF.rel_dt_first_seen := IF(withOnfail, clean_rel_dt_first_seen, le.rel_dt_first_seen); // ONFAIL(CLEAN)
    SELF.rel_dt_first_seen_wouldClean := TRIM((SALT39.StrType)le.rel_dt_first_seen) <> TRIM((SALT39.StrType)clean_rel_dt_first_seen);
    SELF.rel_dt_last_seen_Invalid := Fields.InValid_rel_dt_last_seen((SALT39.StrType)le.rel_dt_last_seen);
    clean_rel_dt_last_seen := (TYPEOF(le.rel_dt_last_seen))Fields.Make_rel_dt_last_seen((SALT39.StrType)le.rel_dt_last_seen);
    clean_rel_dt_last_seen_Invalid := Fields.InValid_rel_dt_last_seen((SALT39.StrType)clean_rel_dt_last_seen);
    SELF.rel_dt_last_seen := IF(withOnfail, clean_rel_dt_last_seen, le.rel_dt_last_seen); // ONFAIL(CLEAN)
    SELF.rel_dt_last_seen_wouldClean := TRIM((SALT39.StrType)le.rel_dt_last_seen) <> TRIM((SALT39.StrType)clean_rel_dt_last_seen);
    SELF.overlap_months_Invalid := Fields.InValid_overlap_months((SALT39.StrType)le.overlap_months);
    clean_overlap_months := (TYPEOF(le.overlap_months))Fields.Make_overlap_months((SALT39.StrType)le.overlap_months);
    clean_overlap_months_Invalid := Fields.InValid_overlap_months((SALT39.StrType)clean_overlap_months);
    SELF.overlap_months := IF(withOnfail, clean_overlap_months, le.overlap_months); // ONFAIL(CLEAN)
    SELF.overlap_months_wouldClean := TRIM((SALT39.StrType)le.overlap_months) <> TRIM((SALT39.StrType)clean_overlap_months);
    SELF.hdr_dt_first_seen_Invalid := Fields.InValid_hdr_dt_first_seen((SALT39.StrType)le.hdr_dt_first_seen);
    clean_hdr_dt_first_seen := (TYPEOF(le.hdr_dt_first_seen))Fields.Make_hdr_dt_first_seen((SALT39.StrType)le.hdr_dt_first_seen);
    clean_hdr_dt_first_seen_Invalid := Fields.InValid_hdr_dt_first_seen((SALT39.StrType)clean_hdr_dt_first_seen);
    SELF.hdr_dt_first_seen := IF(withOnfail, clean_hdr_dt_first_seen, le.hdr_dt_first_seen); // ONFAIL(CLEAN)
    SELF.hdr_dt_first_seen_wouldClean := TRIM((SALT39.StrType)le.hdr_dt_first_seen) <> TRIM((SALT39.StrType)clean_hdr_dt_first_seen);
    SELF.hdr_dt_last_seen_Invalid := Fields.InValid_hdr_dt_last_seen((SALT39.StrType)le.hdr_dt_last_seen);
    clean_hdr_dt_last_seen := (TYPEOF(le.hdr_dt_last_seen))Fields.Make_hdr_dt_last_seen((SALT39.StrType)le.hdr_dt_last_seen);
    clean_hdr_dt_last_seen_Invalid := Fields.InValid_hdr_dt_last_seen((SALT39.StrType)clean_hdr_dt_last_seen);
    SELF.hdr_dt_last_seen := IF(withOnfail, clean_hdr_dt_last_seen, le.hdr_dt_last_seen); // ONFAIL(CLEAN)
    SELF.hdr_dt_last_seen_wouldClean := TRIM((SALT39.StrType)le.hdr_dt_last_seen) <> TRIM((SALT39.StrType)clean_hdr_dt_last_seen);
    SELF.age_first_seen_Invalid := Fields.InValid_age_first_seen((SALT39.StrType)le.age_first_seen);
    clean_age_first_seen := (TYPEOF(le.age_first_seen))Fields.Make_age_first_seen((SALT39.StrType)le.age_first_seen);
    clean_age_first_seen_Invalid := Fields.InValid_age_first_seen((SALT39.StrType)clean_age_first_seen);
    SELF.age_first_seen := IF(withOnfail, clean_age_first_seen, le.age_first_seen); // ONFAIL(CLEAN)
    SELF.age_first_seen_wouldClean := TRIM((SALT39.StrType)le.age_first_seen) <> TRIM((SALT39.StrType)clean_age_first_seen);
    SELF.isanylnamematch_Invalid := Fields.InValid_isanylnamematch((SALT39.StrType)le.isanylnamematch);
    clean_isanylnamematch := (TYPEOF(le.isanylnamematch))Fields.Make_isanylnamematch((SALT39.StrType)le.isanylnamematch);
    clean_isanylnamematch_Invalid := Fields.InValid_isanylnamematch((SALT39.StrType)clean_isanylnamematch);
    SELF.isanylnamematch := IF(withOnfail, clean_isanylnamematch, le.isanylnamematch); // ONFAIL(CLEAN)
    SELF.isanylnamematch_wouldClean := TRIM((SALT39.StrType)le.isanylnamematch) <> TRIM((SALT39.StrType)clean_isanylnamematch);
    SELF.isanyphonematch_Invalid := Fields.InValid_isanyphonematch((SALT39.StrType)le.isanyphonematch);
    clean_isanyphonematch := (TYPEOF(le.isanyphonematch))Fields.Make_isanyphonematch((SALT39.StrType)le.isanyphonematch);
    clean_isanyphonematch_Invalid := Fields.InValid_isanyphonematch((SALT39.StrType)clean_isanyphonematch);
    SELF.isanyphonematch := IF(withOnfail, clean_isanyphonematch, le.isanyphonematch); // ONFAIL(CLEAN)
    SELF.isanyphonematch_wouldClean := TRIM((SALT39.StrType)le.isanyphonematch) <> TRIM((SALT39.StrType)clean_isanyphonematch);
    SELF.isearlylnamematch_Invalid := Fields.InValid_isearlylnamematch((SALT39.StrType)le.isearlylnamematch);
    clean_isearlylnamematch := (TYPEOF(le.isearlylnamematch))Fields.Make_isearlylnamematch((SALT39.StrType)le.isearlylnamematch);
    clean_isearlylnamematch_Invalid := Fields.InValid_isearlylnamematch((SALT39.StrType)clean_isearlylnamematch);
    SELF.isearlylnamematch := IF(withOnfail, clean_isearlylnamematch, le.isearlylnamematch); // ONFAIL(CLEAN)
    SELF.isearlylnamematch_wouldClean := TRIM((SALT39.StrType)le.isearlylnamematch) <> TRIM((SALT39.StrType)clean_isearlylnamematch);
    SELF.iscurrlnamematch_Invalid := Fields.InValid_iscurrlnamematch((SALT39.StrType)le.iscurrlnamematch);
    clean_iscurrlnamematch := (TYPEOF(le.iscurrlnamematch))Fields.Make_iscurrlnamematch((SALT39.StrType)le.iscurrlnamematch);
    clean_iscurrlnamematch_Invalid := Fields.InValid_iscurrlnamematch((SALT39.StrType)clean_iscurrlnamematch);
    SELF.iscurrlnamematch := IF(withOnfail, clean_iscurrlnamematch, le.iscurrlnamematch); // ONFAIL(CLEAN)
    SELF.iscurrlnamematch_wouldClean := TRIM((SALT39.StrType)le.iscurrlnamematch) <> TRIM((SALT39.StrType)clean_iscurrlnamematch);
    SELF.ismixedlnamematch_Invalid := Fields.InValid_ismixedlnamematch((SALT39.StrType)le.ismixedlnamematch);
    clean_ismixedlnamematch := (TYPEOF(le.ismixedlnamematch))Fields.Make_ismixedlnamematch((SALT39.StrType)le.ismixedlnamematch);
    clean_ismixedlnamematch_Invalid := Fields.InValid_ismixedlnamematch((SALT39.StrType)clean_ismixedlnamematch);
    SELF.ismixedlnamematch := IF(withOnfail, clean_ismixedlnamematch, le.ismixedlnamematch); // ONFAIL(CLEAN)
    SELF.ismixedlnamematch_wouldClean := TRIM((SALT39.StrType)le.ismixedlnamematch) <> TRIM((SALT39.StrType)clean_ismixedlnamematch);
    SELF.ssn1_Invalid := Fields.InValid_ssn1((SALT39.StrType)le.ssn1);
    clean_ssn1 := (TYPEOF(le.ssn1))Fields.Make_ssn1((SALT39.StrType)le.ssn1);
    clean_ssn1_Invalid := Fields.InValid_ssn1((SALT39.StrType)clean_ssn1);
    SELF.ssn1 := IF(withOnfail, clean_ssn1, le.ssn1); // ONFAIL(CLEAN)
    SELF.ssn1_wouldClean := TRIM((SALT39.StrType)le.ssn1) <> TRIM((SALT39.StrType)clean_ssn1);
    SELF.ssn2_Invalid := Fields.InValid_ssn2((SALT39.StrType)le.ssn2);
    clean_ssn2 := (TYPEOF(le.ssn2))Fields.Make_ssn2((SALT39.StrType)le.ssn2);
    clean_ssn2_Invalid := Fields.InValid_ssn2((SALT39.StrType)clean_ssn2);
    SELF.ssn2 := IF(withOnfail, clean_ssn2, le.ssn2); // ONFAIL(CLEAN)
    SELF.ssn2_wouldClean := TRIM((SALT39.StrType)le.ssn2) <> TRIM((SALT39.StrType)clean_ssn2);
    SELF.dob1_Invalid := Fields.InValid_dob1((SALT39.StrType)le.dob1);
    clean_dob1 := (TYPEOF(le.dob1))Fields.Make_dob1((SALT39.StrType)le.dob1);
    clean_dob1_Invalid := Fields.InValid_dob1((SALT39.StrType)clean_dob1);
    SELF.dob1 := IF(withOnfail, clean_dob1, le.dob1); // ONFAIL(CLEAN)
    SELF.dob1_wouldClean := TRIM((SALT39.StrType)le.dob1) <> TRIM((SALT39.StrType)clean_dob1);
    SELF.dob2_Invalid := Fields.InValid_dob2((SALT39.StrType)le.dob2);
    clean_dob2 := (TYPEOF(le.dob2))Fields.Make_dob2((SALT39.StrType)le.dob2);
    clean_dob2_Invalid := Fields.InValid_dob2((SALT39.StrType)clean_dob2);
    SELF.dob2 := IF(withOnfail, clean_dob2, le.dob2); // ONFAIL(CLEAN)
    SELF.dob2_wouldClean := TRIM((SALT39.StrType)le.dob2) <> TRIM((SALT39.StrType)clean_dob2);
    SELF.current_lname1_Invalid := Fields.InValid_current_lname1((SALT39.StrType)le.current_lname1);
    clean_current_lname1 := (TYPEOF(le.current_lname1))Fields.Make_current_lname1((SALT39.StrType)le.current_lname1);
    clean_current_lname1_Invalid := Fields.InValid_current_lname1((SALT39.StrType)clean_current_lname1);
    SELF.current_lname1 := IF(withOnfail, clean_current_lname1, le.current_lname1); // ONFAIL(CLEAN)
    SELF.current_lname1_wouldClean := TRIM((SALT39.StrType)le.current_lname1) <> TRIM((SALT39.StrType)clean_current_lname1);
    SELF.current_lname2_Invalid := Fields.InValid_current_lname2((SALT39.StrType)le.current_lname2);
    clean_current_lname2 := (TYPEOF(le.current_lname2))Fields.Make_current_lname2((SALT39.StrType)le.current_lname2);
    clean_current_lname2_Invalid := Fields.InValid_current_lname2((SALT39.StrType)clean_current_lname2);
    SELF.current_lname2 := IF(withOnfail, clean_current_lname2, le.current_lname2); // ONFAIL(CLEAN)
    SELF.current_lname2_wouldClean := TRIM((SALT39.StrType)le.current_lname2) <> TRIM((SALT39.StrType)clean_current_lname2);
    SELF.early_lname1_Invalid := Fields.InValid_early_lname1((SALT39.StrType)le.early_lname1);
    clean_early_lname1 := (TYPEOF(le.early_lname1))Fields.Make_early_lname1((SALT39.StrType)le.early_lname1);
    clean_early_lname1_Invalid := Fields.InValid_early_lname1((SALT39.StrType)clean_early_lname1);
    SELF.early_lname1 := IF(withOnfail, clean_early_lname1, le.early_lname1); // ONFAIL(CLEAN)
    SELF.early_lname1_wouldClean := TRIM((SALT39.StrType)le.early_lname1) <> TRIM((SALT39.StrType)clean_early_lname1);
    SELF.early_lname2_Invalid := Fields.InValid_early_lname2((SALT39.StrType)le.early_lname2);
    clean_early_lname2 := (TYPEOF(le.early_lname2))Fields.Make_early_lname2((SALT39.StrType)le.early_lname2);
    clean_early_lname2_Invalid := Fields.InValid_early_lname2((SALT39.StrType)clean_early_lname2);
    SELF.early_lname2 := IF(withOnfail, clean_early_lname2, le.early_lname2); // ONFAIL(CLEAN)
    SELF.early_lname2_wouldClean := TRIM((SALT39.StrType)le.early_lname2) <> TRIM((SALT39.StrType)clean_early_lname2);
    SELF.addr_ind1_Invalid := Fields.InValid_addr_ind1((SALT39.StrType)le.addr_ind1);
    clean_addr_ind1 := (TYPEOF(le.addr_ind1))Fields.Make_addr_ind1((SALT39.StrType)le.addr_ind1);
    clean_addr_ind1_Invalid := Fields.InValid_addr_ind1((SALT39.StrType)clean_addr_ind1);
    SELF.addr_ind1 := IF(withOnfail, clean_addr_ind1, le.addr_ind1); // ONFAIL(CLEAN)
    SELF.addr_ind1_wouldClean := TRIM((SALT39.StrType)le.addr_ind1) <> TRIM((SALT39.StrType)clean_addr_ind1);
    SELF.addr_ind2_Invalid := Fields.InValid_addr_ind2((SALT39.StrType)le.addr_ind2);
    clean_addr_ind2 := (TYPEOF(le.addr_ind2))Fields.Make_addr_ind2((SALT39.StrType)le.addr_ind2);
    clean_addr_ind2_Invalid := Fields.InValid_addr_ind2((SALT39.StrType)clean_addr_ind2);
    SELF.addr_ind2 := IF(withOnfail, clean_addr_ind2, le.addr_ind2); // ONFAIL(CLEAN)
    SELF.addr_ind2_wouldClean := TRIM((SALT39.StrType)le.addr_ind2) <> TRIM((SALT39.StrType)clean_addr_ind2);
    SELF.r2rdid_Invalid := Fields.InValid_r2rdid((SALT39.StrType)le.r2rdid);
    clean_r2rdid := (TYPEOF(le.r2rdid))Fields.Make_r2rdid((SALT39.StrType)le.r2rdid);
    clean_r2rdid_Invalid := Fields.InValid_r2rdid((SALT39.StrType)clean_r2rdid);
    SELF.r2rdid := IF(withOnfail, clean_r2rdid, le.r2rdid); // ONFAIL(CLEAN)
    SELF.r2rdid_wouldClean := TRIM((SALT39.StrType)le.r2rdid) <> TRIM((SALT39.StrType)clean_r2rdid);
    SELF.r2cnt_Invalid := Fields.InValid_r2cnt((SALT39.StrType)le.r2cnt);
    clean_r2cnt := (TYPEOF(le.r2cnt))Fields.Make_r2cnt((SALT39.StrType)le.r2cnt);
    clean_r2cnt_Invalid := Fields.InValid_r2cnt((SALT39.StrType)clean_r2cnt);
    SELF.r2cnt := IF(withOnfail, clean_r2cnt, le.r2cnt); // ONFAIL(CLEAN)
    SELF.r2cnt_wouldClean := TRIM((SALT39.StrType)le.r2cnt) <> TRIM((SALT39.StrType)clean_r2cnt);
    SELF.personal_Invalid := Fields.InValid_personal((SALT39.StrType)le.personal);
    clean_personal := (TYPEOF(le.personal))Fields.Make_personal((SALT39.StrType)le.personal);
    clean_personal_Invalid := Fields.InValid_personal((SALT39.StrType)clean_personal);
    SELF.personal := IF(withOnfail, clean_personal, le.personal); // ONFAIL(CLEAN)
    SELF.personal_wouldClean := TRIM((SALT39.StrType)le.personal) <> TRIM((SALT39.StrType)clean_personal);
    SELF.business_Invalid := Fields.InValid_business((SALT39.StrType)le.business);
    clean_business := (TYPEOF(le.business))Fields.Make_business((SALT39.StrType)le.business);
    clean_business_Invalid := Fields.InValid_business((SALT39.StrType)clean_business);
    SELF.business := IF(withOnfail, clean_business, le.business); // ONFAIL(CLEAN)
    SELF.business_wouldClean := TRIM((SALT39.StrType)le.business) <> TRIM((SALT39.StrType)clean_business);
    SELF.other_Invalid := Fields.InValid_other((SALT39.StrType)le.other);
    clean_other := (TYPEOF(le.other))Fields.Make_other((SALT39.StrType)le.other);
    clean_other_Invalid := Fields.InValid_other((SALT39.StrType)clean_other);
    SELF.other := IF(withOnfail, clean_other, le.other); // ONFAIL(CLEAN)
    SELF.other_wouldClean := TRIM((SALT39.StrType)le.other) <> TRIM((SALT39.StrType)clean_other);
    SELF.title_Invalid := Fields.InValid_title((SALT39.StrType)le.title);
    clean_title := (TYPEOF(le.title))Fields.Make_title((SALT39.StrType)le.title);
    clean_title_Invalid := Fields.InValid_title((SALT39.StrType)clean_title);
    SELF.title := IF(withOnfail, clean_title, le.title); // ONFAIL(CLEAN)
    SELF.title_wouldClean := TRIM((SALT39.StrType)le.title) <> TRIM((SALT39.StrType)clean_title);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.type_Invalid << 0 ) + ( le.confidence_Invalid << 1 ) + ( le.did1_Invalid << 3 ) + ( le.did2_Invalid << 5 ) + ( le.cohabit_score_Invalid << 7 ) + ( le.cohabit_cnt_Invalid << 9 ) + ( le.coapt_score_Invalid << 11 ) + ( le.coapt_cnt_Invalid << 13 ) + ( le.copobox_score_Invalid << 15 ) + ( le.copobox_cnt_Invalid << 17 ) + ( le.cossn_score_Invalid << 19 ) + ( le.cossn_cnt_Invalid << 21 ) + ( le.copolicy_score_Invalid << 23 ) + ( le.copolicy_cnt_Invalid << 25 ) + ( le.coclaim_score_Invalid << 27 ) + ( le.coclaim_cnt_Invalid << 29 ) + ( le.coproperty_score_Invalid << 31 ) + ( le.coproperty_cnt_Invalid << 33 ) + ( le.bcoproperty_score_Invalid << 35 ) + ( le.bcoproperty_cnt_Invalid << 37 ) + ( le.coforeclosure_score_Invalid << 39 ) + ( le.coforeclosure_cnt_Invalid << 40 ) + ( le.bcoforeclosure_score_Invalid << 41 ) + ( le.bcoforeclosure_cnt_Invalid << 42 ) + ( le.colien_score_Invalid << 43 ) + ( le.colien_cnt_Invalid << 45 ) + ( le.bcolien_score_Invalid << 47 ) + ( le.bcolien_cnt_Invalid << 48 ) + ( le.cobankruptcy_score_Invalid << 49 ) + ( le.cobankruptcy_cnt_Invalid << 51 ) + ( le.bcobankruptcy_score_Invalid << 53 ) + ( le.bcobankruptcy_cnt_Invalid << 55 ) + ( le.covehicle_score_Invalid << 57 ) + ( le.covehicle_cnt_Invalid << 59 ) + ( le.coexperian_score_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.coexperian_cnt_Invalid << 0 ) + ( le.cotransunion_score_Invalid << 2 ) + ( le.cotransunion_cnt_Invalid << 4 ) + ( le.coenclarity_score_Invalid << 6 ) + ( le.coenclarity_cnt_Invalid << 8 ) + ( le.coecrash_score_Invalid << 10 ) + ( le.coecrash_cnt_Invalid << 12 ) + ( le.bcoecrash_score_Invalid << 14 ) + ( le.bcoecrash_cnt_Invalid << 16 ) + ( le.cowatercraft_score_Invalid << 18 ) + ( le.cowatercraft_cnt_Invalid << 20 ) + ( le.coaircraft_score_Invalid << 21 ) + ( le.coaircraft_cnt_Invalid << 22 ) + ( le.comarriagedivorce_score_Invalid << 23 ) + ( le.comarriagedivorce_cnt_Invalid << 24 ) + ( le.coucc_score_Invalid << 25 ) + ( le.coucc_cnt_Invalid << 27 ) + ( le.lname_score_Invalid << 29 ) + ( le.phone_score_Invalid << 31 ) + ( le.dl_nbr_score_Invalid << 33 ) + ( le.total_cnt_Invalid << 35 ) + ( le.total_score_Invalid << 37 ) + ( le.cluster_Invalid << 39 ) + ( le.generation_Invalid << 41 ) + ( le.gender_Invalid << 43 ) + ( le.lname_cnt_Invalid << 45 ) + ( le.rel_dt_first_seen_Invalid << 47 ) + ( le.rel_dt_last_seen_Invalid << 49 ) + ( le.overlap_months_Invalid << 51 ) + ( le.hdr_dt_first_seen_Invalid << 53 ) + ( le.hdr_dt_last_seen_Invalid << 55 ) + ( le.age_first_seen_Invalid << 57 ) + ( le.isanylnamematch_Invalid << 59 ) + ( le.isanyphonematch_Invalid << 61 );
    SELF.ScrubsBits3 := ( le.isearlylnamematch_Invalid << 0 ) + ( le.iscurrlnamematch_Invalid << 2 ) + ( le.ismixedlnamematch_Invalid << 4 ) + ( le.ssn1_Invalid << 6 ) + ( le.ssn2_Invalid << 8 ) + ( le.dob1_Invalid << 10 ) + ( le.dob2_Invalid << 12 ) + ( le.current_lname1_Invalid << 14 ) + ( le.current_lname2_Invalid << 16 ) + ( le.early_lname1_Invalid << 18 ) + ( le.early_lname2_Invalid << 20 ) + ( le.addr_ind1_Invalid << 22 ) + ( le.addr_ind2_Invalid << 24 ) + ( le.r2rdid_Invalid << 26 ) + ( le.r2cnt_Invalid << 28 ) + ( le.personal_Invalid << 30 ) + ( le.business_Invalid << 32 ) + ( le.other_Invalid << 34 ) + ( le.title_Invalid << 36 );
    SELF.ScrubsCleanBits1 := ( IF(le.type_wouldClean, 1, 0) << 0 ) + ( IF(le.confidence_wouldClean, 1, 0) << 1 ) + ( IF(le.did1_wouldClean, 1, 0) << 2 ) + ( IF(le.did2_wouldClean, 1, 0) << 3 ) + ( IF(le.cohabit_score_wouldClean, 1, 0) << 4 ) + ( IF(le.cohabit_cnt_wouldClean, 1, 0) << 5 ) + ( IF(le.coapt_score_wouldClean, 1, 0) << 6 ) + ( IF(le.coapt_cnt_wouldClean, 1, 0) << 7 ) + ( IF(le.copobox_score_wouldClean, 1, 0) << 8 ) + ( IF(le.copobox_cnt_wouldClean, 1, 0) << 9 ) + ( IF(le.cossn_score_wouldClean, 1, 0) << 10 ) + ( IF(le.cossn_cnt_wouldClean, 1, 0) << 11 ) + ( IF(le.copolicy_score_wouldClean, 1, 0) << 12 ) + ( IF(le.copolicy_cnt_wouldClean, 1, 0) << 13 ) + ( IF(le.coclaim_score_wouldClean, 1, 0) << 14 ) + ( IF(le.coclaim_cnt_wouldClean, 1, 0) << 15 ) + ( IF(le.coproperty_score_wouldClean, 1, 0) << 16 ) + ( IF(le.coproperty_cnt_wouldClean, 1, 0) << 17 ) + ( IF(le.bcoproperty_score_wouldClean, 1, 0) << 18 ) + ( IF(le.bcoproperty_cnt_wouldClean, 1, 0) << 19 ) + ( IF(le.coforeclosure_score_wouldClean, 1, 0) << 20 ) + ( IF(le.coforeclosure_cnt_wouldClean, 1, 0) << 21 ) + ( IF(le.bcoforeclosure_score_wouldClean, 1, 0) << 22 ) + ( IF(le.bcoforeclosure_cnt_wouldClean, 1, 0) << 23 ) + ( IF(le.colien_score_wouldClean, 1, 0) << 24 ) + ( IF(le.colien_cnt_wouldClean, 1, 0) << 25 ) + ( IF(le.bcolien_score_wouldClean, 1, 0) << 26 ) + ( IF(le.bcolien_cnt_wouldClean, 1, 0) << 27 ) + ( IF(le.cobankruptcy_score_wouldClean, 1, 0) << 28 ) + ( IF(le.cobankruptcy_cnt_wouldClean, 1, 0) << 29 ) + ( IF(le.bcobankruptcy_score_wouldClean, 1, 0) << 30 ) + ( IF(le.bcobankruptcy_cnt_wouldClean, 1, 0) << 31 ) + ( IF(le.covehicle_score_wouldClean, 1, 0) << 32 ) + ( IF(le.covehicle_cnt_wouldClean, 1, 0) << 33 ) + ( IF(le.coexperian_score_wouldClean, 1, 0) << 34 ) + ( IF(le.coexperian_cnt_wouldClean, 1, 0) << 35 ) + ( IF(le.cotransunion_score_wouldClean, 1, 0) << 36 ) + ( IF(le.cotransunion_cnt_wouldClean, 1, 0) << 37 ) + ( IF(le.coenclarity_score_wouldClean, 1, 0) << 38 ) + ( IF(le.coenclarity_cnt_wouldClean, 1, 0) << 39 ) + ( IF(le.coecrash_score_wouldClean, 1, 0) << 40 ) + ( IF(le.coecrash_cnt_wouldClean, 1, 0) << 41 ) + ( IF(le.bcoecrash_score_wouldClean, 1, 0) << 42 ) + ( IF(le.bcoecrash_cnt_wouldClean, 1, 0) << 43 ) + ( IF(le.cowatercraft_score_wouldClean, 1, 0) << 44 ) + ( IF(le.cowatercraft_cnt_wouldClean, 1, 0) << 45 ) + ( IF(le.coaircraft_score_wouldClean, 1, 0) << 46 ) + ( IF(le.coaircraft_cnt_wouldClean, 1, 0) << 47 ) + ( IF(le.comarriagedivorce_score_wouldClean, 1, 0) << 48 ) + ( IF(le.comarriagedivorce_cnt_wouldClean, 1, 0) << 49 ) + ( IF(le.coucc_score_wouldClean, 1, 0) << 50 ) + ( IF(le.coucc_cnt_wouldClean, 1, 0) << 51 ) + ( IF(le.lname_score_wouldClean, 1, 0) << 52 ) + ( IF(le.phone_score_wouldClean, 1, 0) << 53 ) + ( IF(le.dl_nbr_score_wouldClean, 1, 0) << 54 ) + ( IF(le.total_cnt_wouldClean, 1, 0) << 55 ) + ( IF(le.total_score_wouldClean, 1, 0) << 56 ) + ( IF(le.cluster_wouldClean, 1, 0) << 57 ) + ( IF(le.generation_wouldClean, 1, 0) << 58 ) + ( IF(le.gender_wouldClean, 1, 0) << 59 ) + ( IF(le.lname_cnt_wouldClean, 1, 0) << 60 ) + ( IF(le.rel_dt_first_seen_wouldClean, 1, 0) << 61 ) + ( IF(le.rel_dt_last_seen_wouldClean, 1, 0) << 62 ) + ( IF(le.overlap_months_wouldClean, 1, 0) << 63 );
    SELF.ScrubsCleanBits2 := ( IF(le.hdr_dt_first_seen_wouldClean, 1, 0) << 0 ) + ( IF(le.hdr_dt_last_seen_wouldClean, 1, 0) << 1 ) + ( IF(le.age_first_seen_wouldClean, 1, 0) << 2 ) + ( IF(le.isanylnamematch_wouldClean, 1, 0) << 3 ) + ( IF(le.isanyphonematch_wouldClean, 1, 0) << 4 ) + ( IF(le.isearlylnamematch_wouldClean, 1, 0) << 5 ) + ( IF(le.iscurrlnamematch_wouldClean, 1, 0) << 6 ) + ( IF(le.ismixedlnamematch_wouldClean, 1, 0) << 7 ) + ( IF(le.ssn1_wouldClean, 1, 0) << 8 ) + ( IF(le.ssn2_wouldClean, 1, 0) << 9 ) + ( IF(le.dob1_wouldClean, 1, 0) << 10 ) + ( IF(le.dob2_wouldClean, 1, 0) << 11 ) + ( IF(le.current_lname1_wouldClean, 1, 0) << 12 ) + ( IF(le.current_lname2_wouldClean, 1, 0) << 13 ) + ( IF(le.early_lname1_wouldClean, 1, 0) << 14 ) + ( IF(le.early_lname2_wouldClean, 1, 0) << 15 ) + ( IF(le.addr_ind1_wouldClean, 1, 0) << 16 ) + ( IF(le.addr_ind2_wouldClean, 1, 0) << 17 ) + ( IF(le.r2rdid_wouldClean, 1, 0) << 18 ) + ( IF(le.r2cnt_wouldClean, 1, 0) << 19 ) + ( IF(le.personal_wouldClean, 1, 0) << 20 ) + ( IF(le.business_wouldClean, 1, 0) << 21 ) + ( IF(le.other_wouldClean, 1, 0) << 22 ) + ( IF(le.title_wouldClean, 1, 0) << 23 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.type_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.confidence_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.did1_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.did2_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.cohabit_score_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.cohabit_cnt_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.coapt_score_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.coapt_cnt_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.copobox_score_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.copobox_cnt_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.cossn_score_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.cossn_cnt_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.copolicy_score_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.copolicy_cnt_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.coclaim_score_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.coclaim_cnt_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.coproperty_score_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.coproperty_cnt_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.bcoproperty_score_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.bcoproperty_cnt_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.coforeclosure_score_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.coforeclosure_cnt_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.bcoforeclosure_score_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.bcoforeclosure_cnt_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.colien_score_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.colien_cnt_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.bcolien_score_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.bcolien_cnt_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.cobankruptcy_score_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.cobankruptcy_cnt_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.bcobankruptcy_score_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.bcobankruptcy_cnt_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.covehicle_score_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.covehicle_cnt_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.coexperian_score_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.coexperian_cnt_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.cotransunion_score_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.cotransunion_cnt_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.coenclarity_score_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.coenclarity_cnt_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.coecrash_score_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.coecrash_cnt_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.bcoecrash_score_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.bcoecrash_cnt_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.cowatercraft_score_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.cowatercraft_cnt_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.coaircraft_score_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.coaircraft_cnt_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.comarriagedivorce_score_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.comarriagedivorce_cnt_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.coucc_score_Invalid := (le.ScrubsBits2 >> 25) & 3;
    SELF.coucc_cnt_Invalid := (le.ScrubsBits2 >> 27) & 3;
    SELF.lname_score_Invalid := (le.ScrubsBits2 >> 29) & 3;
    SELF.phone_score_Invalid := (le.ScrubsBits2 >> 31) & 3;
    SELF.dl_nbr_score_Invalid := (le.ScrubsBits2 >> 33) & 3;
    SELF.total_cnt_Invalid := (le.ScrubsBits2 >> 35) & 3;
    SELF.total_score_Invalid := (le.ScrubsBits2 >> 37) & 3;
    SELF.cluster_Invalid := (le.ScrubsBits2 >> 39) & 3;
    SELF.generation_Invalid := (le.ScrubsBits2 >> 41) & 3;
    SELF.gender_Invalid := (le.ScrubsBits2 >> 43) & 3;
    SELF.lname_cnt_Invalid := (le.ScrubsBits2 >> 45) & 3;
    SELF.rel_dt_first_seen_Invalid := (le.ScrubsBits2 >> 47) & 3;
    SELF.rel_dt_last_seen_Invalid := (le.ScrubsBits2 >> 49) & 3;
    SELF.overlap_months_Invalid := (le.ScrubsBits2 >> 51) & 3;
    SELF.hdr_dt_first_seen_Invalid := (le.ScrubsBits2 >> 53) & 3;
    SELF.hdr_dt_last_seen_Invalid := (le.ScrubsBits2 >> 55) & 3;
    SELF.age_first_seen_Invalid := (le.ScrubsBits2 >> 57) & 3;
    SELF.isanylnamematch_Invalid := (le.ScrubsBits2 >> 59) & 3;
    SELF.isanyphonematch_Invalid := (le.ScrubsBits2 >> 61) & 3;
    SELF.isearlylnamematch_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.iscurrlnamematch_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.ismixedlnamematch_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.ssn1_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.ssn2_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.dob1_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.dob2_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.current_lname1_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.current_lname2_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.early_lname1_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.early_lname2_Invalid := (le.ScrubsBits3 >> 20) & 3;
    SELF.addr_ind1_Invalid := (le.ScrubsBits3 >> 22) & 3;
    SELF.addr_ind2_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.r2rdid_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.r2cnt_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.personal_Invalid := (le.ScrubsBits3 >> 30) & 3;
    SELF.business_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.other_Invalid := (le.ScrubsBits3 >> 34) & 3;
    SELF.title_Invalid := (le.ScrubsBits3 >> 36) & 3;
    SELF.type_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.confidence_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.did1_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.did2_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.cohabit_score_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.cohabit_cnt_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.coapt_score_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.coapt_cnt_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.copobox_score_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.copobox_cnt_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.cossn_score_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.cossn_cnt_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.copolicy_score_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.copolicy_cnt_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.coclaim_score_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.coclaim_cnt_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.coproperty_score_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.coproperty_cnt_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.bcoproperty_score_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.bcoproperty_cnt_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.coforeclosure_score_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.coforeclosure_cnt_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.bcoforeclosure_score_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.bcoforeclosure_cnt_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.colien_score_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.colien_cnt_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.bcolien_score_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.bcolien_cnt_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.cobankruptcy_score_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.cobankruptcy_cnt_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.bcobankruptcy_score_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.bcobankruptcy_cnt_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.covehicle_score_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.covehicle_cnt_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.coexperian_score_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.coexperian_cnt_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.cotransunion_score_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.cotransunion_cnt_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.coenclarity_score_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.coenclarity_cnt_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.coecrash_score_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.coecrash_cnt_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.bcoecrash_score_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF.bcoecrash_cnt_wouldClean := le.ScrubsCleanBits1 >> 43;
    SELF.cowatercraft_score_wouldClean := le.ScrubsCleanBits1 >> 44;
    SELF.cowatercraft_cnt_wouldClean := le.ScrubsCleanBits1 >> 45;
    SELF.coaircraft_score_wouldClean := le.ScrubsCleanBits1 >> 46;
    SELF.coaircraft_cnt_wouldClean := le.ScrubsCleanBits1 >> 47;
    SELF.comarriagedivorce_score_wouldClean := le.ScrubsCleanBits1 >> 48;
    SELF.comarriagedivorce_cnt_wouldClean := le.ScrubsCleanBits1 >> 49;
    SELF.coucc_score_wouldClean := le.ScrubsCleanBits1 >> 50;
    SELF.coucc_cnt_wouldClean := le.ScrubsCleanBits1 >> 51;
    SELF.lname_score_wouldClean := le.ScrubsCleanBits1 >> 52;
    SELF.phone_score_wouldClean := le.ScrubsCleanBits1 >> 53;
    SELF.dl_nbr_score_wouldClean := le.ScrubsCleanBits1 >> 54;
    SELF.total_cnt_wouldClean := le.ScrubsCleanBits1 >> 55;
    SELF.total_score_wouldClean := le.ScrubsCleanBits1 >> 56;
    SELF.cluster_wouldClean := le.ScrubsCleanBits1 >> 57;
    SELF.generation_wouldClean := le.ScrubsCleanBits1 >> 58;
    SELF.gender_wouldClean := le.ScrubsCleanBits1 >> 59;
    SELF.lname_cnt_wouldClean := le.ScrubsCleanBits1 >> 60;
    SELF.rel_dt_first_seen_wouldClean := le.ScrubsCleanBits1 >> 61;
    SELF.rel_dt_last_seen_wouldClean := le.ScrubsCleanBits1 >> 62;
    SELF.overlap_months_wouldClean := le.ScrubsCleanBits1 >> 63;
    SELF.hdr_dt_first_seen_wouldClean := le.ScrubsCleanBits2 >> 0;
    SELF.hdr_dt_last_seen_wouldClean := le.ScrubsCleanBits2 >> 1;
    SELF.age_first_seen_wouldClean := le.ScrubsCleanBits2 >> 2;
    SELF.isanylnamematch_wouldClean := le.ScrubsCleanBits2 >> 3;
    SELF.isanyphonematch_wouldClean := le.ScrubsCleanBits2 >> 4;
    SELF.isearlylnamematch_wouldClean := le.ScrubsCleanBits2 >> 5;
    SELF.iscurrlnamematch_wouldClean := le.ScrubsCleanBits2 >> 6;
    SELF.ismixedlnamematch_wouldClean := le.ScrubsCleanBits2 >> 7;
    SELF.ssn1_wouldClean := le.ScrubsCleanBits2 >> 8;
    SELF.ssn2_wouldClean := le.ScrubsCleanBits2 >> 9;
    SELF.dob1_wouldClean := le.ScrubsCleanBits2 >> 10;
    SELF.dob2_wouldClean := le.ScrubsCleanBits2 >> 11;
    SELF.current_lname1_wouldClean := le.ScrubsCleanBits2 >> 12;
    SELF.current_lname2_wouldClean := le.ScrubsCleanBits2 >> 13;
    SELF.early_lname1_wouldClean := le.ScrubsCleanBits2 >> 14;
    SELF.early_lname2_wouldClean := le.ScrubsCleanBits2 >> 15;
    SELF.addr_ind1_wouldClean := le.ScrubsCleanBits2 >> 16;
    SELF.addr_ind2_wouldClean := le.ScrubsCleanBits2 >> 17;
    SELF.r2rdid_wouldClean := le.ScrubsCleanBits2 >> 18;
    SELF.r2cnt_wouldClean := le.ScrubsCleanBits2 >> 19;
    SELF.personal_wouldClean := le.ScrubsCleanBits2 >> 20;
    SELF.business_wouldClean := le.ScrubsCleanBits2 >> 21;
    SELF.other_wouldClean := le.ScrubsCleanBits2 >> 22;
    SELF.title_wouldClean := le.ScrubsCleanBits2 >> 23;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    type_ALLOW_ErrorCount := COUNT(GROUP,h.type_Invalid=1);
    type_ALLOW_WouldModifyCount := COUNT(GROUP,h.type_Invalid=1 AND h.type_wouldClean);
    confidence_ALLOW_ErrorCount := COUNT(GROUP,h.confidence_Invalid=1);
    confidence_ALLOW_WouldModifyCount := COUNT(GROUP,h.confidence_Invalid=1 AND h.confidence_wouldClean);
    confidence_WORDS_ErrorCount := COUNT(GROUP,h.confidence_Invalid=2);
    confidence_WORDS_WouldModifyCount := COUNT(GROUP,h.confidence_Invalid=2 AND h.confidence_wouldClean);
    confidence_Total_ErrorCount := COUNT(GROUP,h.confidence_Invalid>0);
    did1_ALLOW_ErrorCount := COUNT(GROUP,h.did1_Invalid=1);
    did1_ALLOW_WouldModifyCount := COUNT(GROUP,h.did1_Invalid=1 AND h.did1_wouldClean);
    did1_WORDS_ErrorCount := COUNT(GROUP,h.did1_Invalid=2);
    did1_WORDS_WouldModifyCount := COUNT(GROUP,h.did1_Invalid=2 AND h.did1_wouldClean);
    did1_Total_ErrorCount := COUNT(GROUP,h.did1_Invalid>0);
    did2_ALLOW_ErrorCount := COUNT(GROUP,h.did2_Invalid=1);
    did2_ALLOW_WouldModifyCount := COUNT(GROUP,h.did2_Invalid=1 AND h.did2_wouldClean);
    did2_WORDS_ErrorCount := COUNT(GROUP,h.did2_Invalid=2);
    did2_WORDS_WouldModifyCount := COUNT(GROUP,h.did2_Invalid=2 AND h.did2_wouldClean);
    did2_Total_ErrorCount := COUNT(GROUP,h.did2_Invalid>0);
    cohabit_score_ALLOW_ErrorCount := COUNT(GROUP,h.cohabit_score_Invalid=1);
    cohabit_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.cohabit_score_Invalid=1 AND h.cohabit_score_wouldClean);
    cohabit_score_WORDS_ErrorCount := COUNT(GROUP,h.cohabit_score_Invalid=2);
    cohabit_score_WORDS_WouldModifyCount := COUNT(GROUP,h.cohabit_score_Invalid=2 AND h.cohabit_score_wouldClean);
    cohabit_score_Total_ErrorCount := COUNT(GROUP,h.cohabit_score_Invalid>0);
    cohabit_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.cohabit_cnt_Invalid=1);
    cohabit_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.cohabit_cnt_Invalid=1 AND h.cohabit_cnt_wouldClean);
    cohabit_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.cohabit_cnt_Invalid=2);
    cohabit_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cohabit_cnt_Invalid=2 AND h.cohabit_cnt_wouldClean);
    cohabit_cnt_WORDS_ErrorCount := COUNT(GROUP,h.cohabit_cnt_Invalid=3);
    cohabit_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.cohabit_cnt_Invalid=3 AND h.cohabit_cnt_wouldClean);
    cohabit_cnt_Total_ErrorCount := COUNT(GROUP,h.cohabit_cnt_Invalid>0);
    coapt_score_ALLOW_ErrorCount := COUNT(GROUP,h.coapt_score_Invalid=1);
    coapt_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coapt_score_Invalid=1 AND h.coapt_score_wouldClean);
    coapt_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coapt_score_Invalid=2);
    coapt_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coapt_score_Invalid=2 AND h.coapt_score_wouldClean);
    coapt_score_WORDS_ErrorCount := COUNT(GROUP,h.coapt_score_Invalid=3);
    coapt_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coapt_score_Invalid=3 AND h.coapt_score_wouldClean);
    coapt_score_Total_ErrorCount := COUNT(GROUP,h.coapt_score_Invalid>0);
    coapt_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coapt_cnt_Invalid=1);
    coapt_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coapt_cnt_Invalid=1 AND h.coapt_cnt_wouldClean);
    coapt_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coapt_cnt_Invalid=2);
    coapt_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coapt_cnt_Invalid=2 AND h.coapt_cnt_wouldClean);
    coapt_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coapt_cnt_Invalid=3);
    coapt_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coapt_cnt_Invalid=3 AND h.coapt_cnt_wouldClean);
    coapt_cnt_Total_ErrorCount := COUNT(GROUP,h.coapt_cnt_Invalid>0);
    copobox_score_ALLOW_ErrorCount := COUNT(GROUP,h.copobox_score_Invalid=1);
    copobox_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.copobox_score_Invalid=1 AND h.copobox_score_wouldClean);
    copobox_score_LENGTHS_ErrorCount := COUNT(GROUP,h.copobox_score_Invalid=2);
    copobox_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.copobox_score_Invalid=2 AND h.copobox_score_wouldClean);
    copobox_score_WORDS_ErrorCount := COUNT(GROUP,h.copobox_score_Invalid=3);
    copobox_score_WORDS_WouldModifyCount := COUNT(GROUP,h.copobox_score_Invalid=3 AND h.copobox_score_wouldClean);
    copobox_score_Total_ErrorCount := COUNT(GROUP,h.copobox_score_Invalid>0);
    copobox_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.copobox_cnt_Invalid=1);
    copobox_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.copobox_cnt_Invalid=1 AND h.copobox_cnt_wouldClean);
    copobox_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.copobox_cnt_Invalid=2);
    copobox_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.copobox_cnt_Invalid=2 AND h.copobox_cnt_wouldClean);
    copobox_cnt_WORDS_ErrorCount := COUNT(GROUP,h.copobox_cnt_Invalid=3);
    copobox_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.copobox_cnt_Invalid=3 AND h.copobox_cnt_wouldClean);
    copobox_cnt_Total_ErrorCount := COUNT(GROUP,h.copobox_cnt_Invalid>0);
    cossn_score_ALLOW_ErrorCount := COUNT(GROUP,h.cossn_score_Invalid=1);
    cossn_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.cossn_score_Invalid=1 AND h.cossn_score_wouldClean);
    cossn_score_LENGTHS_ErrorCount := COUNT(GROUP,h.cossn_score_Invalid=2);
    cossn_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cossn_score_Invalid=2 AND h.cossn_score_wouldClean);
    cossn_score_WORDS_ErrorCount := COUNT(GROUP,h.cossn_score_Invalid=3);
    cossn_score_WORDS_WouldModifyCount := COUNT(GROUP,h.cossn_score_Invalid=3 AND h.cossn_score_wouldClean);
    cossn_score_Total_ErrorCount := COUNT(GROUP,h.cossn_score_Invalid>0);
    cossn_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.cossn_cnt_Invalid=1);
    cossn_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.cossn_cnt_Invalid=1 AND h.cossn_cnt_wouldClean);
    cossn_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.cossn_cnt_Invalid=2);
    cossn_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cossn_cnt_Invalid=2 AND h.cossn_cnt_wouldClean);
    cossn_cnt_WORDS_ErrorCount := COUNT(GROUP,h.cossn_cnt_Invalid=3);
    cossn_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.cossn_cnt_Invalid=3 AND h.cossn_cnt_wouldClean);
    cossn_cnt_Total_ErrorCount := COUNT(GROUP,h.cossn_cnt_Invalid>0);
    copolicy_score_ALLOW_ErrorCount := COUNT(GROUP,h.copolicy_score_Invalid=1);
    copolicy_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.copolicy_score_Invalid=1 AND h.copolicy_score_wouldClean);
    copolicy_score_LENGTHS_ErrorCount := COUNT(GROUP,h.copolicy_score_Invalid=2);
    copolicy_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.copolicy_score_Invalid=2 AND h.copolicy_score_wouldClean);
    copolicy_score_WORDS_ErrorCount := COUNT(GROUP,h.copolicy_score_Invalid=3);
    copolicy_score_WORDS_WouldModifyCount := COUNT(GROUP,h.copolicy_score_Invalid=3 AND h.copolicy_score_wouldClean);
    copolicy_score_Total_ErrorCount := COUNT(GROUP,h.copolicy_score_Invalid>0);
    copolicy_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.copolicy_cnt_Invalid=1);
    copolicy_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.copolicy_cnt_Invalid=1 AND h.copolicy_cnt_wouldClean);
    copolicy_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.copolicy_cnt_Invalid=2);
    copolicy_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.copolicy_cnt_Invalid=2 AND h.copolicy_cnt_wouldClean);
    copolicy_cnt_WORDS_ErrorCount := COUNT(GROUP,h.copolicy_cnt_Invalid=3);
    copolicy_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.copolicy_cnt_Invalid=3 AND h.copolicy_cnt_wouldClean);
    copolicy_cnt_Total_ErrorCount := COUNT(GROUP,h.copolicy_cnt_Invalid>0);
    coclaim_score_ALLOW_ErrorCount := COUNT(GROUP,h.coclaim_score_Invalid=1);
    coclaim_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coclaim_score_Invalid=1 AND h.coclaim_score_wouldClean);
    coclaim_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coclaim_score_Invalid=2);
    coclaim_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coclaim_score_Invalid=2 AND h.coclaim_score_wouldClean);
    coclaim_score_WORDS_ErrorCount := COUNT(GROUP,h.coclaim_score_Invalid=3);
    coclaim_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coclaim_score_Invalid=3 AND h.coclaim_score_wouldClean);
    coclaim_score_Total_ErrorCount := COUNT(GROUP,h.coclaim_score_Invalid>0);
    coclaim_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coclaim_cnt_Invalid=1);
    coclaim_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coclaim_cnt_Invalid=1 AND h.coclaim_cnt_wouldClean);
    coclaim_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coclaim_cnt_Invalid=2);
    coclaim_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coclaim_cnt_Invalid=2 AND h.coclaim_cnt_wouldClean);
    coclaim_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coclaim_cnt_Invalid=3);
    coclaim_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coclaim_cnt_Invalid=3 AND h.coclaim_cnt_wouldClean);
    coclaim_cnt_Total_ErrorCount := COUNT(GROUP,h.coclaim_cnt_Invalid>0);
    coproperty_score_ALLOW_ErrorCount := COUNT(GROUP,h.coproperty_score_Invalid=1);
    coproperty_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coproperty_score_Invalid=1 AND h.coproperty_score_wouldClean);
    coproperty_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coproperty_score_Invalid=2);
    coproperty_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coproperty_score_Invalid=2 AND h.coproperty_score_wouldClean);
    coproperty_score_WORDS_ErrorCount := COUNT(GROUP,h.coproperty_score_Invalid=3);
    coproperty_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coproperty_score_Invalid=3 AND h.coproperty_score_wouldClean);
    coproperty_score_Total_ErrorCount := COUNT(GROUP,h.coproperty_score_Invalid>0);
    coproperty_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coproperty_cnt_Invalid=1);
    coproperty_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coproperty_cnt_Invalid=1 AND h.coproperty_cnt_wouldClean);
    coproperty_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coproperty_cnt_Invalid=2);
    coproperty_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coproperty_cnt_Invalid=2 AND h.coproperty_cnt_wouldClean);
    coproperty_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coproperty_cnt_Invalid=3);
    coproperty_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coproperty_cnt_Invalid=3 AND h.coproperty_cnt_wouldClean);
    coproperty_cnt_Total_ErrorCount := COUNT(GROUP,h.coproperty_cnt_Invalid>0);
    bcoproperty_score_ALLOW_ErrorCount := COUNT(GROUP,h.bcoproperty_score_Invalid=1);
    bcoproperty_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcoproperty_score_Invalid=1 AND h.bcoproperty_score_wouldClean);
    bcoproperty_score_LENGTHS_ErrorCount := COUNT(GROUP,h.bcoproperty_score_Invalid=2);
    bcoproperty_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.bcoproperty_score_Invalid=2 AND h.bcoproperty_score_wouldClean);
    bcoproperty_score_WORDS_ErrorCount := COUNT(GROUP,h.bcoproperty_score_Invalid=3);
    bcoproperty_score_WORDS_WouldModifyCount := COUNT(GROUP,h.bcoproperty_score_Invalid=3 AND h.bcoproperty_score_wouldClean);
    bcoproperty_score_Total_ErrorCount := COUNT(GROUP,h.bcoproperty_score_Invalid>0);
    bcoproperty_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid=1);
    bcoproperty_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid=1 AND h.bcoproperty_cnt_wouldClean);
    bcoproperty_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid=2);
    bcoproperty_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid=2 AND h.bcoproperty_cnt_wouldClean);
    bcoproperty_cnt_WORDS_ErrorCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid=3);
    bcoproperty_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid=3 AND h.bcoproperty_cnt_wouldClean);
    bcoproperty_cnt_Total_ErrorCount := COUNT(GROUP,h.bcoproperty_cnt_Invalid>0);
    coforeclosure_score_ALLOW_ErrorCount := COUNT(GROUP,h.coforeclosure_score_Invalid=1);
    coforeclosure_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coforeclosure_score_Invalid=1 AND h.coforeclosure_score_wouldClean);
    coforeclosure_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coforeclosure_cnt_Invalid=1);
    coforeclosure_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coforeclosure_cnt_Invalid=1 AND h.coforeclosure_cnt_wouldClean);
    bcoforeclosure_score_ALLOW_ErrorCount := COUNT(GROUP,h.bcoforeclosure_score_Invalid=1);
    bcoforeclosure_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcoforeclosure_score_Invalid=1 AND h.bcoforeclosure_score_wouldClean);
    bcoforeclosure_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.bcoforeclosure_cnt_Invalid=1);
    bcoforeclosure_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcoforeclosure_cnt_Invalid=1 AND h.bcoforeclosure_cnt_wouldClean);
    colien_score_ALLOW_ErrorCount := COUNT(GROUP,h.colien_score_Invalid=1);
    colien_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.colien_score_Invalid=1 AND h.colien_score_wouldClean);
    colien_score_LENGTHS_ErrorCount := COUNT(GROUP,h.colien_score_Invalid=2);
    colien_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.colien_score_Invalid=2 AND h.colien_score_wouldClean);
    colien_score_WORDS_ErrorCount := COUNT(GROUP,h.colien_score_Invalid=3);
    colien_score_WORDS_WouldModifyCount := COUNT(GROUP,h.colien_score_Invalid=3 AND h.colien_score_wouldClean);
    colien_score_Total_ErrorCount := COUNT(GROUP,h.colien_score_Invalid>0);
    colien_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.colien_cnt_Invalid=1);
    colien_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.colien_cnt_Invalid=1 AND h.colien_cnt_wouldClean);
    colien_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.colien_cnt_Invalid=2);
    colien_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.colien_cnt_Invalid=2 AND h.colien_cnt_wouldClean);
    colien_cnt_WORDS_ErrorCount := COUNT(GROUP,h.colien_cnt_Invalid=3);
    colien_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.colien_cnt_Invalid=3 AND h.colien_cnt_wouldClean);
    colien_cnt_Total_ErrorCount := COUNT(GROUP,h.colien_cnt_Invalid>0);
    bcolien_score_ALLOW_ErrorCount := COUNT(GROUP,h.bcolien_score_Invalid=1);
    bcolien_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcolien_score_Invalid=1 AND h.bcolien_score_wouldClean);
    bcolien_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.bcolien_cnt_Invalid=1);
    bcolien_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcolien_cnt_Invalid=1 AND h.bcolien_cnt_wouldClean);
    cobankruptcy_score_ALLOW_ErrorCount := COUNT(GROUP,h.cobankruptcy_score_Invalid=1);
    cobankruptcy_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.cobankruptcy_score_Invalid=1 AND h.cobankruptcy_score_wouldClean);
    cobankruptcy_score_LENGTHS_ErrorCount := COUNT(GROUP,h.cobankruptcy_score_Invalid=2);
    cobankruptcy_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cobankruptcy_score_Invalid=2 AND h.cobankruptcy_score_wouldClean);
    cobankruptcy_score_WORDS_ErrorCount := COUNT(GROUP,h.cobankruptcy_score_Invalid=3);
    cobankruptcy_score_WORDS_WouldModifyCount := COUNT(GROUP,h.cobankruptcy_score_Invalid=3 AND h.cobankruptcy_score_wouldClean);
    cobankruptcy_score_Total_ErrorCount := COUNT(GROUP,h.cobankruptcy_score_Invalid>0);
    cobankruptcy_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid=1);
    cobankruptcy_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid=1 AND h.cobankruptcy_cnt_wouldClean);
    cobankruptcy_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid=2);
    cobankruptcy_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid=2 AND h.cobankruptcy_cnt_wouldClean);
    cobankruptcy_cnt_WORDS_ErrorCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid=3);
    cobankruptcy_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid=3 AND h.cobankruptcy_cnt_wouldClean);
    cobankruptcy_cnt_Total_ErrorCount := COUNT(GROUP,h.cobankruptcy_cnt_Invalid>0);
    bcobankruptcy_score_ALLOW_ErrorCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid=1);
    bcobankruptcy_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid=1 AND h.bcobankruptcy_score_wouldClean);
    bcobankruptcy_score_LENGTHS_ErrorCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid=2);
    bcobankruptcy_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid=2 AND h.bcobankruptcy_score_wouldClean);
    bcobankruptcy_score_WORDS_ErrorCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid=3);
    bcobankruptcy_score_WORDS_WouldModifyCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid=3 AND h.bcobankruptcy_score_wouldClean);
    bcobankruptcy_score_Total_ErrorCount := COUNT(GROUP,h.bcobankruptcy_score_Invalid>0);
    bcobankruptcy_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid=1);
    bcobankruptcy_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid=1 AND h.bcobankruptcy_cnt_wouldClean);
    bcobankruptcy_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid=2);
    bcobankruptcy_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid=2 AND h.bcobankruptcy_cnt_wouldClean);
    bcobankruptcy_cnt_WORDS_ErrorCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid=3);
    bcobankruptcy_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid=3 AND h.bcobankruptcy_cnt_wouldClean);
    bcobankruptcy_cnt_Total_ErrorCount := COUNT(GROUP,h.bcobankruptcy_cnt_Invalid>0);
    covehicle_score_ALLOW_ErrorCount := COUNT(GROUP,h.covehicle_score_Invalid=1);
    covehicle_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.covehicle_score_Invalid=1 AND h.covehicle_score_wouldClean);
    covehicle_score_LENGTHS_ErrorCount := COUNT(GROUP,h.covehicle_score_Invalid=2);
    covehicle_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.covehicle_score_Invalid=2 AND h.covehicle_score_wouldClean);
    covehicle_score_WORDS_ErrorCount := COUNT(GROUP,h.covehicle_score_Invalid=3);
    covehicle_score_WORDS_WouldModifyCount := COUNT(GROUP,h.covehicle_score_Invalid=3 AND h.covehicle_score_wouldClean);
    covehicle_score_Total_ErrorCount := COUNT(GROUP,h.covehicle_score_Invalid>0);
    covehicle_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.covehicle_cnt_Invalid=1);
    covehicle_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.covehicle_cnt_Invalid=1 AND h.covehicle_cnt_wouldClean);
    covehicle_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.covehicle_cnt_Invalid=2);
    covehicle_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.covehicle_cnt_Invalid=2 AND h.covehicle_cnt_wouldClean);
    covehicle_cnt_WORDS_ErrorCount := COUNT(GROUP,h.covehicle_cnt_Invalid=3);
    covehicle_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.covehicle_cnt_Invalid=3 AND h.covehicle_cnt_wouldClean);
    covehicle_cnt_Total_ErrorCount := COUNT(GROUP,h.covehicle_cnt_Invalid>0);
    coexperian_score_ALLOW_ErrorCount := COUNT(GROUP,h.coexperian_score_Invalid=1);
    coexperian_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coexperian_score_Invalid=1 AND h.coexperian_score_wouldClean);
    coexperian_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coexperian_score_Invalid=2);
    coexperian_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coexperian_score_Invalid=2 AND h.coexperian_score_wouldClean);
    coexperian_score_WORDS_ErrorCount := COUNT(GROUP,h.coexperian_score_Invalid=3);
    coexperian_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coexperian_score_Invalid=3 AND h.coexperian_score_wouldClean);
    coexperian_score_Total_ErrorCount := COUNT(GROUP,h.coexperian_score_Invalid>0);
    coexperian_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coexperian_cnt_Invalid=1);
    coexperian_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coexperian_cnt_Invalid=1 AND h.coexperian_cnt_wouldClean);
    coexperian_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coexperian_cnt_Invalid=2);
    coexperian_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coexperian_cnt_Invalid=2 AND h.coexperian_cnt_wouldClean);
    coexperian_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coexperian_cnt_Invalid=3);
    coexperian_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coexperian_cnt_Invalid=3 AND h.coexperian_cnt_wouldClean);
    coexperian_cnt_Total_ErrorCount := COUNT(GROUP,h.coexperian_cnt_Invalid>0);
    cotransunion_score_ALLOW_ErrorCount := COUNT(GROUP,h.cotransunion_score_Invalid=1);
    cotransunion_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.cotransunion_score_Invalid=1 AND h.cotransunion_score_wouldClean);
    cotransunion_score_LENGTHS_ErrorCount := COUNT(GROUP,h.cotransunion_score_Invalid=2);
    cotransunion_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cotransunion_score_Invalid=2 AND h.cotransunion_score_wouldClean);
    cotransunion_score_WORDS_ErrorCount := COUNT(GROUP,h.cotransunion_score_Invalid=3);
    cotransunion_score_WORDS_WouldModifyCount := COUNT(GROUP,h.cotransunion_score_Invalid=3 AND h.cotransunion_score_wouldClean);
    cotransunion_score_Total_ErrorCount := COUNT(GROUP,h.cotransunion_score_Invalid>0);
    cotransunion_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.cotransunion_cnt_Invalid=1);
    cotransunion_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.cotransunion_cnt_Invalid=1 AND h.cotransunion_cnt_wouldClean);
    cotransunion_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.cotransunion_cnt_Invalid=2);
    cotransunion_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cotransunion_cnt_Invalid=2 AND h.cotransunion_cnt_wouldClean);
    cotransunion_cnt_WORDS_ErrorCount := COUNT(GROUP,h.cotransunion_cnt_Invalid=3);
    cotransunion_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.cotransunion_cnt_Invalid=3 AND h.cotransunion_cnt_wouldClean);
    cotransunion_cnt_Total_ErrorCount := COUNT(GROUP,h.cotransunion_cnt_Invalid>0);
    coenclarity_score_ALLOW_ErrorCount := COUNT(GROUP,h.coenclarity_score_Invalid=1);
    coenclarity_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coenclarity_score_Invalid=1 AND h.coenclarity_score_wouldClean);
    coenclarity_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coenclarity_score_Invalid=2);
    coenclarity_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coenclarity_score_Invalid=2 AND h.coenclarity_score_wouldClean);
    coenclarity_score_WORDS_ErrorCount := COUNT(GROUP,h.coenclarity_score_Invalid=3);
    coenclarity_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coenclarity_score_Invalid=3 AND h.coenclarity_score_wouldClean);
    coenclarity_score_Total_ErrorCount := COUNT(GROUP,h.coenclarity_score_Invalid>0);
    coenclarity_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coenclarity_cnt_Invalid=1);
    coenclarity_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coenclarity_cnt_Invalid=1 AND h.coenclarity_cnt_wouldClean);
    coenclarity_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coenclarity_cnt_Invalid=2);
    coenclarity_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coenclarity_cnt_Invalid=2 AND h.coenclarity_cnt_wouldClean);
    coenclarity_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coenclarity_cnt_Invalid=3);
    coenclarity_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coenclarity_cnt_Invalid=3 AND h.coenclarity_cnt_wouldClean);
    coenclarity_cnt_Total_ErrorCount := COUNT(GROUP,h.coenclarity_cnt_Invalid>0);
    coecrash_score_ALLOW_ErrorCount := COUNT(GROUP,h.coecrash_score_Invalid=1);
    coecrash_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coecrash_score_Invalid=1 AND h.coecrash_score_wouldClean);
    coecrash_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coecrash_score_Invalid=2);
    coecrash_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coecrash_score_Invalid=2 AND h.coecrash_score_wouldClean);
    coecrash_score_WORDS_ErrorCount := COUNT(GROUP,h.coecrash_score_Invalid=3);
    coecrash_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coecrash_score_Invalid=3 AND h.coecrash_score_wouldClean);
    coecrash_score_Total_ErrorCount := COUNT(GROUP,h.coecrash_score_Invalid>0);
    coecrash_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coecrash_cnt_Invalid=1);
    coecrash_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coecrash_cnt_Invalid=1 AND h.coecrash_cnt_wouldClean);
    coecrash_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coecrash_cnt_Invalid=2);
    coecrash_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coecrash_cnt_Invalid=2 AND h.coecrash_cnt_wouldClean);
    coecrash_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coecrash_cnt_Invalid=3);
    coecrash_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coecrash_cnt_Invalid=3 AND h.coecrash_cnt_wouldClean);
    coecrash_cnt_Total_ErrorCount := COUNT(GROUP,h.coecrash_cnt_Invalid>0);
    bcoecrash_score_ALLOW_ErrorCount := COUNT(GROUP,h.bcoecrash_score_Invalid=1);
    bcoecrash_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcoecrash_score_Invalid=1 AND h.bcoecrash_score_wouldClean);
    bcoecrash_score_LENGTHS_ErrorCount := COUNT(GROUP,h.bcoecrash_score_Invalid=2);
    bcoecrash_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.bcoecrash_score_Invalid=2 AND h.bcoecrash_score_wouldClean);
    bcoecrash_score_WORDS_ErrorCount := COUNT(GROUP,h.bcoecrash_score_Invalid=3);
    bcoecrash_score_WORDS_WouldModifyCount := COUNT(GROUP,h.bcoecrash_score_Invalid=3 AND h.bcoecrash_score_wouldClean);
    bcoecrash_score_Total_ErrorCount := COUNT(GROUP,h.bcoecrash_score_Invalid>0);
    bcoecrash_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid=1);
    bcoecrash_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid=1 AND h.bcoecrash_cnt_wouldClean);
    bcoecrash_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid=2);
    bcoecrash_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid=2 AND h.bcoecrash_cnt_wouldClean);
    bcoecrash_cnt_WORDS_ErrorCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid=3);
    bcoecrash_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid=3 AND h.bcoecrash_cnt_wouldClean);
    bcoecrash_cnt_Total_ErrorCount := COUNT(GROUP,h.bcoecrash_cnt_Invalid>0);
    cowatercraft_score_ALLOW_ErrorCount := COUNT(GROUP,h.cowatercraft_score_Invalid=1);
    cowatercraft_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.cowatercraft_score_Invalid=1 AND h.cowatercraft_score_wouldClean);
    cowatercraft_score_LENGTHS_ErrorCount := COUNT(GROUP,h.cowatercraft_score_Invalid=2);
    cowatercraft_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cowatercraft_score_Invalid=2 AND h.cowatercraft_score_wouldClean);
    cowatercraft_score_WORDS_ErrorCount := COUNT(GROUP,h.cowatercraft_score_Invalid=3);
    cowatercraft_score_WORDS_WouldModifyCount := COUNT(GROUP,h.cowatercraft_score_Invalid=3 AND h.cowatercraft_score_wouldClean);
    cowatercraft_score_Total_ErrorCount := COUNT(GROUP,h.cowatercraft_score_Invalid>0);
    cowatercraft_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.cowatercraft_cnt_Invalid=1);
    cowatercraft_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.cowatercraft_cnt_Invalid=1 AND h.cowatercraft_cnt_wouldClean);
    coaircraft_score_ALLOW_ErrorCount := COUNT(GROUP,h.coaircraft_score_Invalid=1);
    coaircraft_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coaircraft_score_Invalid=1 AND h.coaircraft_score_wouldClean);
    coaircraft_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coaircraft_cnt_Invalid=1);
    coaircraft_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coaircraft_cnt_Invalid=1 AND h.coaircraft_cnt_wouldClean);
    comarriagedivorce_score_ALLOW_ErrorCount := COUNT(GROUP,h.comarriagedivorce_score_Invalid=1);
    comarriagedivorce_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.comarriagedivorce_score_Invalid=1 AND h.comarriagedivorce_score_wouldClean);
    comarriagedivorce_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.comarriagedivorce_cnt_Invalid=1);
    comarriagedivorce_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.comarriagedivorce_cnt_Invalid=1 AND h.comarriagedivorce_cnt_wouldClean);
    coucc_score_ALLOW_ErrorCount := COUNT(GROUP,h.coucc_score_Invalid=1);
    coucc_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.coucc_score_Invalid=1 AND h.coucc_score_wouldClean);
    coucc_score_LENGTHS_ErrorCount := COUNT(GROUP,h.coucc_score_Invalid=2);
    coucc_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coucc_score_Invalid=2 AND h.coucc_score_wouldClean);
    coucc_score_WORDS_ErrorCount := COUNT(GROUP,h.coucc_score_Invalid=3);
    coucc_score_WORDS_WouldModifyCount := COUNT(GROUP,h.coucc_score_Invalid=3 AND h.coucc_score_wouldClean);
    coucc_score_Total_ErrorCount := COUNT(GROUP,h.coucc_score_Invalid>0);
    coucc_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.coucc_cnt_Invalid=1);
    coucc_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.coucc_cnt_Invalid=1 AND h.coucc_cnt_wouldClean);
    coucc_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.coucc_cnt_Invalid=2);
    coucc_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.coucc_cnt_Invalid=2 AND h.coucc_cnt_wouldClean);
    coucc_cnt_WORDS_ErrorCount := COUNT(GROUP,h.coucc_cnt_Invalid=3);
    coucc_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.coucc_cnt_Invalid=3 AND h.coucc_cnt_wouldClean);
    coucc_cnt_Total_ErrorCount := COUNT(GROUP,h.coucc_cnt_Invalid>0);
    lname_score_ALLOW_ErrorCount := COUNT(GROUP,h.lname_score_Invalid=1);
    lname_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.lname_score_Invalid=1 AND h.lname_score_wouldClean);
    lname_score_LENGTHS_ErrorCount := COUNT(GROUP,h.lname_score_Invalid=2);
    lname_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lname_score_Invalid=2 AND h.lname_score_wouldClean);
    lname_score_WORDS_ErrorCount := COUNT(GROUP,h.lname_score_Invalid=3);
    lname_score_WORDS_WouldModifyCount := COUNT(GROUP,h.lname_score_Invalid=3 AND h.lname_score_wouldClean);
    lname_score_Total_ErrorCount := COUNT(GROUP,h.lname_score_Invalid>0);
    phone_score_ALLOW_ErrorCount := COUNT(GROUP,h.phone_score_Invalid=1);
    phone_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.phone_score_Invalid=1 AND h.phone_score_wouldClean);
    phone_score_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_score_Invalid=2);
    phone_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.phone_score_Invalid=2 AND h.phone_score_wouldClean);
    phone_score_WORDS_ErrorCount := COUNT(GROUP,h.phone_score_Invalid=3);
    phone_score_WORDS_WouldModifyCount := COUNT(GROUP,h.phone_score_Invalid=3 AND h.phone_score_wouldClean);
    phone_score_Total_ErrorCount := COUNT(GROUP,h.phone_score_Invalid>0);
    dl_nbr_score_ALLOW_ErrorCount := COUNT(GROUP,h.dl_nbr_score_Invalid=1);
    dl_nbr_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.dl_nbr_score_Invalid=1 AND h.dl_nbr_score_wouldClean);
    dl_nbr_score_WORDS_ErrorCount := COUNT(GROUP,h.dl_nbr_score_Invalid=2);
    dl_nbr_score_WORDS_WouldModifyCount := COUNT(GROUP,h.dl_nbr_score_Invalid=2 AND h.dl_nbr_score_wouldClean);
    dl_nbr_score_Total_ErrorCount := COUNT(GROUP,h.dl_nbr_score_Invalid>0);
    total_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.total_cnt_Invalid=1);
    total_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.total_cnt_Invalid=1 AND h.total_cnt_wouldClean);
    total_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.total_cnt_Invalid=2);
    total_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.total_cnt_Invalid=2 AND h.total_cnt_wouldClean);
    total_cnt_WORDS_ErrorCount := COUNT(GROUP,h.total_cnt_Invalid=3);
    total_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.total_cnt_Invalid=3 AND h.total_cnt_wouldClean);
    total_cnt_Total_ErrorCount := COUNT(GROUP,h.total_cnt_Invalid>0);
    total_score_ALLOW_ErrorCount := COUNT(GROUP,h.total_score_Invalid=1);
    total_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.total_score_Invalid=1 AND h.total_score_wouldClean);
    total_score_LENGTHS_ErrorCount := COUNT(GROUP,h.total_score_Invalid=2);
    total_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.total_score_Invalid=2 AND h.total_score_wouldClean);
    total_score_WORDS_ErrorCount := COUNT(GROUP,h.total_score_Invalid=3);
    total_score_WORDS_WouldModifyCount := COUNT(GROUP,h.total_score_Invalid=3 AND h.total_score_wouldClean);
    total_score_Total_ErrorCount := COUNT(GROUP,h.total_score_Invalid>0);
    cluster_ALLOW_ErrorCount := COUNT(GROUP,h.cluster_Invalid=1);
    cluster_ALLOW_WouldModifyCount := COUNT(GROUP,h.cluster_Invalid=1 AND h.cluster_wouldClean);
    cluster_LENGTHS_ErrorCount := COUNT(GROUP,h.cluster_Invalid=2);
    cluster_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cluster_Invalid=2 AND h.cluster_wouldClean);
    cluster_WORDS_ErrorCount := COUNT(GROUP,h.cluster_Invalid=3);
    cluster_WORDS_WouldModifyCount := COUNT(GROUP,h.cluster_Invalid=3 AND h.cluster_wouldClean);
    cluster_Total_ErrorCount := COUNT(GROUP,h.cluster_Invalid>0);
    generation_ALLOW_ErrorCount := COUNT(GROUP,h.generation_Invalid=1);
    generation_ALLOW_WouldModifyCount := COUNT(GROUP,h.generation_Invalid=1 AND h.generation_wouldClean);
    generation_LENGTHS_ErrorCount := COUNT(GROUP,h.generation_Invalid=2);
    generation_LENGTHS_WouldModifyCount := COUNT(GROUP,h.generation_Invalid=2 AND h.generation_wouldClean);
    generation_WORDS_ErrorCount := COUNT(GROUP,h.generation_Invalid=3);
    generation_WORDS_WouldModifyCount := COUNT(GROUP,h.generation_Invalid=3 AND h.generation_wouldClean);
    generation_Total_ErrorCount := COUNT(GROUP,h.generation_Invalid>0);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_ALLOW_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=1 AND h.gender_wouldClean);
    gender_LENGTHS_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_LENGTHS_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=2 AND h.gender_wouldClean);
    gender_WORDS_ErrorCount := COUNT(GROUP,h.gender_Invalid=3);
    gender_WORDS_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=3 AND h.gender_wouldClean);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    lname_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.lname_cnt_Invalid=1);
    lname_cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.lname_cnt_Invalid=1 AND h.lname_cnt_wouldClean);
    lname_cnt_LENGTHS_ErrorCount := COUNT(GROUP,h.lname_cnt_Invalid=2);
    lname_cnt_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lname_cnt_Invalid=2 AND h.lname_cnt_wouldClean);
    lname_cnt_WORDS_ErrorCount := COUNT(GROUP,h.lname_cnt_Invalid=3);
    lname_cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.lname_cnt_Invalid=3 AND h.lname_cnt_wouldClean);
    lname_cnt_Total_ErrorCount := COUNT(GROUP,h.lname_cnt_Invalid>0);
    rel_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid=1);
    rel_dt_first_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid=1 AND h.rel_dt_first_seen_wouldClean);
    rel_dt_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid=2);
    rel_dt_first_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid=2 AND h.rel_dt_first_seen_wouldClean);
    rel_dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid=3);
    rel_dt_first_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid=3 AND h.rel_dt_first_seen_wouldClean);
    rel_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.rel_dt_first_seen_Invalid>0);
    rel_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid=1);
    rel_dt_last_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid=1 AND h.rel_dt_last_seen_wouldClean);
    rel_dt_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid=2);
    rel_dt_last_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid=2 AND h.rel_dt_last_seen_wouldClean);
    rel_dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid=3);
    rel_dt_last_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid=3 AND h.rel_dt_last_seen_wouldClean);
    rel_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.rel_dt_last_seen_Invalid>0);
    overlap_months_ALLOW_ErrorCount := COUNT(GROUP,h.overlap_months_Invalid=1);
    overlap_months_ALLOW_WouldModifyCount := COUNT(GROUP,h.overlap_months_Invalid=1 AND h.overlap_months_wouldClean);
    overlap_months_WORDS_ErrorCount := COUNT(GROUP,h.overlap_months_Invalid=2);
    overlap_months_WORDS_WouldModifyCount := COUNT(GROUP,h.overlap_months_Invalid=2 AND h.overlap_months_wouldClean);
    overlap_months_Total_ErrorCount := COUNT(GROUP,h.overlap_months_Invalid>0);
    hdr_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid=1);
    hdr_dt_first_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid=1 AND h.hdr_dt_first_seen_wouldClean);
    hdr_dt_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid=2);
    hdr_dt_first_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid=2 AND h.hdr_dt_first_seen_wouldClean);
    hdr_dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid=3);
    hdr_dt_first_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid=3 AND h.hdr_dt_first_seen_wouldClean);
    hdr_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.hdr_dt_first_seen_Invalid>0);
    hdr_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid=1);
    hdr_dt_last_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid=1 AND h.hdr_dt_last_seen_wouldClean);
    hdr_dt_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid=2);
    hdr_dt_last_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid=2 AND h.hdr_dt_last_seen_wouldClean);
    hdr_dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid=3);
    hdr_dt_last_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid=3 AND h.hdr_dt_last_seen_wouldClean);
    hdr_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.hdr_dt_last_seen_Invalid>0);
    age_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.age_first_seen_Invalid=1);
    age_first_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.age_first_seen_Invalid=1 AND h.age_first_seen_wouldClean);
    age_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.age_first_seen_Invalid=2);
    age_first_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.age_first_seen_Invalid=2 AND h.age_first_seen_wouldClean);
    age_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.age_first_seen_Invalid=3);
    age_first_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.age_first_seen_Invalid=3 AND h.age_first_seen_wouldClean);
    age_first_seen_Total_ErrorCount := COUNT(GROUP,h.age_first_seen_Invalid>0);
    isanylnamematch_ALLOW_ErrorCount := COUNT(GROUP,h.isanylnamematch_Invalid=1);
    isanylnamematch_ALLOW_WouldModifyCount := COUNT(GROUP,h.isanylnamematch_Invalid=1 AND h.isanylnamematch_wouldClean);
    isanylnamematch_LENGTHS_ErrorCount := COUNT(GROUP,h.isanylnamematch_Invalid=2);
    isanylnamematch_LENGTHS_WouldModifyCount := COUNT(GROUP,h.isanylnamematch_Invalid=2 AND h.isanylnamematch_wouldClean);
    isanylnamematch_WORDS_ErrorCount := COUNT(GROUP,h.isanylnamematch_Invalid=3);
    isanylnamematch_WORDS_WouldModifyCount := COUNT(GROUP,h.isanylnamematch_Invalid=3 AND h.isanylnamematch_wouldClean);
    isanylnamematch_Total_ErrorCount := COUNT(GROUP,h.isanylnamematch_Invalid>0);
    isanyphonematch_ALLOW_ErrorCount := COUNT(GROUP,h.isanyphonematch_Invalid=1);
    isanyphonematch_ALLOW_WouldModifyCount := COUNT(GROUP,h.isanyphonematch_Invalid=1 AND h.isanyphonematch_wouldClean);
    isanyphonematch_LENGTHS_ErrorCount := COUNT(GROUP,h.isanyphonematch_Invalid=2);
    isanyphonematch_LENGTHS_WouldModifyCount := COUNT(GROUP,h.isanyphonematch_Invalid=2 AND h.isanyphonematch_wouldClean);
    isanyphonematch_WORDS_ErrorCount := COUNT(GROUP,h.isanyphonematch_Invalid=3);
    isanyphonematch_WORDS_WouldModifyCount := COUNT(GROUP,h.isanyphonematch_Invalid=3 AND h.isanyphonematch_wouldClean);
    isanyphonematch_Total_ErrorCount := COUNT(GROUP,h.isanyphonematch_Invalid>0);
    isearlylnamematch_ALLOW_ErrorCount := COUNT(GROUP,h.isearlylnamematch_Invalid=1);
    isearlylnamematch_ALLOW_WouldModifyCount := COUNT(GROUP,h.isearlylnamematch_Invalid=1 AND h.isearlylnamematch_wouldClean);
    isearlylnamematch_LENGTHS_ErrorCount := COUNT(GROUP,h.isearlylnamematch_Invalid=2);
    isearlylnamematch_LENGTHS_WouldModifyCount := COUNT(GROUP,h.isearlylnamematch_Invalid=2 AND h.isearlylnamematch_wouldClean);
    isearlylnamematch_WORDS_ErrorCount := COUNT(GROUP,h.isearlylnamematch_Invalid=3);
    isearlylnamematch_WORDS_WouldModifyCount := COUNT(GROUP,h.isearlylnamematch_Invalid=3 AND h.isearlylnamematch_wouldClean);
    isearlylnamematch_Total_ErrorCount := COUNT(GROUP,h.isearlylnamematch_Invalid>0);
    iscurrlnamematch_ALLOW_ErrorCount := COUNT(GROUP,h.iscurrlnamematch_Invalid=1);
    iscurrlnamematch_ALLOW_WouldModifyCount := COUNT(GROUP,h.iscurrlnamematch_Invalid=1 AND h.iscurrlnamematch_wouldClean);
    iscurrlnamematch_LENGTHS_ErrorCount := COUNT(GROUP,h.iscurrlnamematch_Invalid=2);
    iscurrlnamematch_LENGTHS_WouldModifyCount := COUNT(GROUP,h.iscurrlnamematch_Invalid=2 AND h.iscurrlnamematch_wouldClean);
    iscurrlnamematch_WORDS_ErrorCount := COUNT(GROUP,h.iscurrlnamematch_Invalid=3);
    iscurrlnamematch_WORDS_WouldModifyCount := COUNT(GROUP,h.iscurrlnamematch_Invalid=3 AND h.iscurrlnamematch_wouldClean);
    iscurrlnamematch_Total_ErrorCount := COUNT(GROUP,h.iscurrlnamematch_Invalid>0);
    ismixedlnamematch_ALLOW_ErrorCount := COUNT(GROUP,h.ismixedlnamematch_Invalid=1);
    ismixedlnamematch_ALLOW_WouldModifyCount := COUNT(GROUP,h.ismixedlnamematch_Invalid=1 AND h.ismixedlnamematch_wouldClean);
    ismixedlnamematch_LENGTHS_ErrorCount := COUNT(GROUP,h.ismixedlnamematch_Invalid=2);
    ismixedlnamematch_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ismixedlnamematch_Invalid=2 AND h.ismixedlnamematch_wouldClean);
    ismixedlnamematch_WORDS_ErrorCount := COUNT(GROUP,h.ismixedlnamematch_Invalid=3);
    ismixedlnamematch_WORDS_WouldModifyCount := COUNT(GROUP,h.ismixedlnamematch_Invalid=3 AND h.ismixedlnamematch_wouldClean);
    ismixedlnamematch_Total_ErrorCount := COUNT(GROUP,h.ismixedlnamematch_Invalid>0);
    ssn1_ALLOW_ErrorCount := COUNT(GROUP,h.ssn1_Invalid=1);
    ssn1_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn1_Invalid=1 AND h.ssn1_wouldClean);
    ssn1_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn1_Invalid=2);
    ssn1_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn1_Invalid=2 AND h.ssn1_wouldClean);
    ssn1_WORDS_ErrorCount := COUNT(GROUP,h.ssn1_Invalid=3);
    ssn1_WORDS_WouldModifyCount := COUNT(GROUP,h.ssn1_Invalid=3 AND h.ssn1_wouldClean);
    ssn1_Total_ErrorCount := COUNT(GROUP,h.ssn1_Invalid>0);
    ssn2_ALLOW_ErrorCount := COUNT(GROUP,h.ssn2_Invalid=1);
    ssn2_ALLOW_WouldModifyCount := COUNT(GROUP,h.ssn2_Invalid=1 AND h.ssn2_wouldClean);
    ssn2_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn2_Invalid=2);
    ssn2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.ssn2_Invalid=2 AND h.ssn2_wouldClean);
    ssn2_WORDS_ErrorCount := COUNT(GROUP,h.ssn2_Invalid=3);
    ssn2_WORDS_WouldModifyCount := COUNT(GROUP,h.ssn2_Invalid=3 AND h.ssn2_wouldClean);
    ssn2_Total_ErrorCount := COUNT(GROUP,h.ssn2_Invalid>0);
    dob1_ALLOW_ErrorCount := COUNT(GROUP,h.dob1_Invalid=1);
    dob1_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob1_Invalid=1 AND h.dob1_wouldClean);
    dob1_LENGTHS_ErrorCount := COUNT(GROUP,h.dob1_Invalid=2);
    dob1_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob1_Invalid=2 AND h.dob1_wouldClean);
    dob1_WORDS_ErrorCount := COUNT(GROUP,h.dob1_Invalid=3);
    dob1_WORDS_WouldModifyCount := COUNT(GROUP,h.dob1_Invalid=3 AND h.dob1_wouldClean);
    dob1_Total_ErrorCount := COUNT(GROUP,h.dob1_Invalid>0);
    dob2_ALLOW_ErrorCount := COUNT(GROUP,h.dob2_Invalid=1);
    dob2_ALLOW_WouldModifyCount := COUNT(GROUP,h.dob2_Invalid=1 AND h.dob2_wouldClean);
    dob2_LENGTHS_ErrorCount := COUNT(GROUP,h.dob2_Invalid=2);
    dob2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dob2_Invalid=2 AND h.dob2_wouldClean);
    dob2_WORDS_ErrorCount := COUNT(GROUP,h.dob2_Invalid=3);
    dob2_WORDS_WouldModifyCount := COUNT(GROUP,h.dob2_Invalid=3 AND h.dob2_wouldClean);
    dob2_Total_ErrorCount := COUNT(GROUP,h.dob2_Invalid>0);
    current_lname1_ALLOW_ErrorCount := COUNT(GROUP,h.current_lname1_Invalid=1);
    current_lname1_ALLOW_WouldModifyCount := COUNT(GROUP,h.current_lname1_Invalid=1 AND h.current_lname1_wouldClean);
    current_lname1_WORDS_ErrorCount := COUNT(GROUP,h.current_lname1_Invalid=2);
    current_lname1_WORDS_WouldModifyCount := COUNT(GROUP,h.current_lname1_Invalid=2 AND h.current_lname1_wouldClean);
    current_lname1_Total_ErrorCount := COUNT(GROUP,h.current_lname1_Invalid>0);
    current_lname2_ALLOW_ErrorCount := COUNT(GROUP,h.current_lname2_Invalid=1);
    current_lname2_ALLOW_WouldModifyCount := COUNT(GROUP,h.current_lname2_Invalid=1 AND h.current_lname2_wouldClean);
    current_lname2_WORDS_ErrorCount := COUNT(GROUP,h.current_lname2_Invalid=2);
    current_lname2_WORDS_WouldModifyCount := COUNT(GROUP,h.current_lname2_Invalid=2 AND h.current_lname2_wouldClean);
    current_lname2_Total_ErrorCount := COUNT(GROUP,h.current_lname2_Invalid>0);
    early_lname1_ALLOW_ErrorCount := COUNT(GROUP,h.early_lname1_Invalid=1);
    early_lname1_ALLOW_WouldModifyCount := COUNT(GROUP,h.early_lname1_Invalid=1 AND h.early_lname1_wouldClean);
    early_lname1_WORDS_ErrorCount := COUNT(GROUP,h.early_lname1_Invalid=2);
    early_lname1_WORDS_WouldModifyCount := COUNT(GROUP,h.early_lname1_Invalid=2 AND h.early_lname1_wouldClean);
    early_lname1_Total_ErrorCount := COUNT(GROUP,h.early_lname1_Invalid>0);
    early_lname2_ALLOW_ErrorCount := COUNT(GROUP,h.early_lname2_Invalid=1);
    early_lname2_ALLOW_WouldModifyCount := COUNT(GROUP,h.early_lname2_Invalid=1 AND h.early_lname2_wouldClean);
    early_lname2_WORDS_ErrorCount := COUNT(GROUP,h.early_lname2_Invalid=2);
    early_lname2_WORDS_WouldModifyCount := COUNT(GROUP,h.early_lname2_Invalid=2 AND h.early_lname2_wouldClean);
    early_lname2_Total_ErrorCount := COUNT(GROUP,h.early_lname2_Invalid>0);
    addr_ind1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_ind1_Invalid=1);
    addr_ind1_ALLOW_WouldModifyCount := COUNT(GROUP,h.addr_ind1_Invalid=1 AND h.addr_ind1_wouldClean);
    addr_ind1_WORDS_ErrorCount := COUNT(GROUP,h.addr_ind1_Invalid=2);
    addr_ind1_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_ind1_Invalid=2 AND h.addr_ind1_wouldClean);
    addr_ind1_Total_ErrorCount := COUNT(GROUP,h.addr_ind1_Invalid>0);
    addr_ind2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_ind2_Invalid=1);
    addr_ind2_ALLOW_WouldModifyCount := COUNT(GROUP,h.addr_ind2_Invalid=1 AND h.addr_ind2_wouldClean);
    addr_ind2_WORDS_ErrorCount := COUNT(GROUP,h.addr_ind2_Invalid=2);
    addr_ind2_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_ind2_Invalid=2 AND h.addr_ind2_wouldClean);
    addr_ind2_Total_ErrorCount := COUNT(GROUP,h.addr_ind2_Invalid>0);
    r2rdid_ALLOW_ErrorCount := COUNT(GROUP,h.r2rdid_Invalid=1);
    r2rdid_ALLOW_WouldModifyCount := COUNT(GROUP,h.r2rdid_Invalid=1 AND h.r2rdid_wouldClean);
    r2rdid_WORDS_ErrorCount := COUNT(GROUP,h.r2rdid_Invalid=2);
    r2rdid_WORDS_WouldModifyCount := COUNT(GROUP,h.r2rdid_Invalid=2 AND h.r2rdid_wouldClean);
    r2rdid_Total_ErrorCount := COUNT(GROUP,h.r2rdid_Invalid>0);
    r2cnt_ALLOW_ErrorCount := COUNT(GROUP,h.r2cnt_Invalid=1);
    r2cnt_ALLOW_WouldModifyCount := COUNT(GROUP,h.r2cnt_Invalid=1 AND h.r2cnt_wouldClean);
    r2cnt_WORDS_ErrorCount := COUNT(GROUP,h.r2cnt_Invalid=2);
    r2cnt_WORDS_WouldModifyCount := COUNT(GROUP,h.r2cnt_Invalid=2 AND h.r2cnt_wouldClean);
    r2cnt_Total_ErrorCount := COUNT(GROUP,h.r2cnt_Invalid>0);
    personal_ALLOW_ErrorCount := COUNT(GROUP,h.personal_Invalid=1);
    personal_ALLOW_WouldModifyCount := COUNT(GROUP,h.personal_Invalid=1 AND h.personal_wouldClean);
    personal_LENGTHS_ErrorCount := COUNT(GROUP,h.personal_Invalid=2);
    personal_LENGTHS_WouldModifyCount := COUNT(GROUP,h.personal_Invalid=2 AND h.personal_wouldClean);
    personal_WORDS_ErrorCount := COUNT(GROUP,h.personal_Invalid=3);
    personal_WORDS_WouldModifyCount := COUNT(GROUP,h.personal_Invalid=3 AND h.personal_wouldClean);
    personal_Total_ErrorCount := COUNT(GROUP,h.personal_Invalid>0);
    business_ALLOW_ErrorCount := COUNT(GROUP,h.business_Invalid=1);
    business_ALLOW_WouldModifyCount := COUNT(GROUP,h.business_Invalid=1 AND h.business_wouldClean);
    business_LENGTHS_ErrorCount := COUNT(GROUP,h.business_Invalid=2);
    business_LENGTHS_WouldModifyCount := COUNT(GROUP,h.business_Invalid=2 AND h.business_wouldClean);
    business_WORDS_ErrorCount := COUNT(GROUP,h.business_Invalid=3);
    business_WORDS_WouldModifyCount := COUNT(GROUP,h.business_Invalid=3 AND h.business_wouldClean);
    business_Total_ErrorCount := COUNT(GROUP,h.business_Invalid>0);
    other_ALLOW_ErrorCount := COUNT(GROUP,h.other_Invalid=1);
    other_ALLOW_WouldModifyCount := COUNT(GROUP,h.other_Invalid=1 AND h.other_wouldClean);
    other_LENGTHS_ErrorCount := COUNT(GROUP,h.other_Invalid=2);
    other_LENGTHS_WouldModifyCount := COUNT(GROUP,h.other_Invalid=2 AND h.other_wouldClean);
    other_WORDS_ErrorCount := COUNT(GROUP,h.other_Invalid=3);
    other_WORDS_WouldModifyCount := COUNT(GROUP,h.other_Invalid=3 AND h.other_wouldClean);
    other_Total_ErrorCount := COUNT(GROUP,h.other_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_WouldModifyCount := COUNT(GROUP,h.title_Invalid=1 AND h.title_wouldClean);
    title_LENGTHS_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_LENGTHS_WouldModifyCount := COUNT(GROUP,h.title_Invalid=2 AND h.title_wouldClean);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_WORDS_WouldModifyCount := COUNT(GROUP,h.title_Invalid=3 AND h.title_wouldClean);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.type_Invalid > 0 OR h.confidence_Invalid > 0 OR h.did1_Invalid > 0 OR h.did2_Invalid > 0 OR h.cohabit_score_Invalid > 0 OR h.cohabit_cnt_Invalid > 0 OR h.coapt_score_Invalid > 0 OR h.coapt_cnt_Invalid > 0 OR h.copobox_score_Invalid > 0 OR h.copobox_cnt_Invalid > 0 OR h.cossn_score_Invalid > 0 OR h.cossn_cnt_Invalid > 0 OR h.copolicy_score_Invalid > 0 OR h.copolicy_cnt_Invalid > 0 OR h.coclaim_score_Invalid > 0 OR h.coclaim_cnt_Invalid > 0 OR h.coproperty_score_Invalid > 0 OR h.coproperty_cnt_Invalid > 0 OR h.bcoproperty_score_Invalid > 0 OR h.bcoproperty_cnt_Invalid > 0 OR h.coforeclosure_score_Invalid > 0 OR h.coforeclosure_cnt_Invalid > 0 OR h.bcoforeclosure_score_Invalid > 0 OR h.bcoforeclosure_cnt_Invalid > 0 OR h.colien_score_Invalid > 0 OR h.colien_cnt_Invalid > 0 OR h.bcolien_score_Invalid > 0 OR h.bcolien_cnt_Invalid > 0 OR h.cobankruptcy_score_Invalid > 0 OR h.cobankruptcy_cnt_Invalid > 0 OR h.bcobankruptcy_score_Invalid > 0 OR h.bcobankruptcy_cnt_Invalid > 0 OR h.covehicle_score_Invalid > 0 OR h.covehicle_cnt_Invalid > 0 OR h.coexperian_score_Invalid > 0 OR h.coexperian_cnt_Invalid > 0 OR h.cotransunion_score_Invalid > 0 OR h.cotransunion_cnt_Invalid > 0 OR h.coenclarity_score_Invalid > 0 OR h.coenclarity_cnt_Invalid > 0 OR h.coecrash_score_Invalid > 0 OR h.coecrash_cnt_Invalid > 0 OR h.bcoecrash_score_Invalid > 0 OR h.bcoecrash_cnt_Invalid > 0 OR h.cowatercraft_score_Invalid > 0 OR h.cowatercraft_cnt_Invalid > 0 OR h.coaircraft_score_Invalid > 0 OR h.coaircraft_cnt_Invalid > 0 OR h.comarriagedivorce_score_Invalid > 0 OR h.comarriagedivorce_cnt_Invalid > 0 OR h.coucc_score_Invalid > 0 OR h.coucc_cnt_Invalid > 0 OR h.lname_score_Invalid > 0 OR h.phone_score_Invalid > 0 OR h.dl_nbr_score_Invalid > 0 OR h.total_cnt_Invalid > 0 OR h.total_score_Invalid > 0 OR h.cluster_Invalid > 0 OR h.generation_Invalid > 0 OR h.gender_Invalid > 0 OR h.lname_cnt_Invalid > 0 OR h.rel_dt_first_seen_Invalid > 0 OR h.rel_dt_last_seen_Invalid > 0 OR h.overlap_months_Invalid > 0 OR h.hdr_dt_first_seen_Invalid > 0 OR h.hdr_dt_last_seen_Invalid > 0 OR h.age_first_seen_Invalid > 0 OR h.isanylnamematch_Invalid > 0 OR h.isanyphonematch_Invalid > 0 OR h.isearlylnamematch_Invalid > 0 OR h.iscurrlnamematch_Invalid > 0 OR h.ismixedlnamematch_Invalid > 0 OR h.ssn1_Invalid > 0 OR h.ssn2_Invalid > 0 OR h.dob1_Invalid > 0 OR h.dob2_Invalid > 0 OR h.current_lname1_Invalid > 0 OR h.current_lname2_Invalid > 0 OR h.early_lname1_Invalid > 0 OR h.early_lname2_Invalid > 0 OR h.addr_ind1_Invalid > 0 OR h.addr_ind2_Invalid > 0 OR h.r2rdid_Invalid > 0 OR h.r2cnt_Invalid > 0 OR h.personal_Invalid > 0 OR h.business_Invalid > 0 OR h.other_Invalid > 0 OR h.title_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.type_wouldClean OR h.confidence_wouldClean OR h.did1_wouldClean OR h.did2_wouldClean OR h.cohabit_score_wouldClean OR h.cohabit_cnt_wouldClean OR h.coapt_score_wouldClean OR h.coapt_cnt_wouldClean OR h.copobox_score_wouldClean OR h.copobox_cnt_wouldClean OR h.cossn_score_wouldClean OR h.cossn_cnt_wouldClean OR h.copolicy_score_wouldClean OR h.copolicy_cnt_wouldClean OR h.coclaim_score_wouldClean OR h.coclaim_cnt_wouldClean OR h.coproperty_score_wouldClean OR h.coproperty_cnt_wouldClean OR h.bcoproperty_score_wouldClean OR h.bcoproperty_cnt_wouldClean OR h.coforeclosure_score_wouldClean OR h.coforeclosure_cnt_wouldClean OR h.bcoforeclosure_score_wouldClean OR h.bcoforeclosure_cnt_wouldClean OR h.colien_score_wouldClean OR h.colien_cnt_wouldClean OR h.bcolien_score_wouldClean OR h.bcolien_cnt_wouldClean OR h.cobankruptcy_score_wouldClean OR h.cobankruptcy_cnt_wouldClean OR h.bcobankruptcy_score_wouldClean OR h.bcobankruptcy_cnt_wouldClean OR h.covehicle_score_wouldClean OR h.covehicle_cnt_wouldClean OR h.coexperian_score_wouldClean OR h.coexperian_cnt_wouldClean OR h.cotransunion_score_wouldClean OR h.cotransunion_cnt_wouldClean OR h.coenclarity_score_wouldClean OR h.coenclarity_cnt_wouldClean OR h.coecrash_score_wouldClean OR h.coecrash_cnt_wouldClean OR h.bcoecrash_score_wouldClean OR h.bcoecrash_cnt_wouldClean OR h.cowatercraft_score_wouldClean OR h.cowatercraft_cnt_wouldClean OR h.coaircraft_score_wouldClean OR h.coaircraft_cnt_wouldClean OR h.comarriagedivorce_score_wouldClean OR h.comarriagedivorce_cnt_wouldClean OR h.coucc_score_wouldClean OR h.coucc_cnt_wouldClean OR h.lname_score_wouldClean OR h.phone_score_wouldClean OR h.dl_nbr_score_wouldClean OR h.total_cnt_wouldClean OR h.total_score_wouldClean OR h.cluster_wouldClean OR h.generation_wouldClean OR h.gender_wouldClean OR h.lname_cnt_wouldClean OR h.rel_dt_first_seen_wouldClean OR h.rel_dt_last_seen_wouldClean OR h.overlap_months_wouldClean OR h.hdr_dt_first_seen_wouldClean OR h.hdr_dt_last_seen_wouldClean OR h.age_first_seen_wouldClean OR h.isanylnamematch_wouldClean OR h.isanyphonematch_wouldClean OR h.isearlylnamematch_wouldClean OR h.iscurrlnamematch_wouldClean OR h.ismixedlnamematch_wouldClean OR h.ssn1_wouldClean OR h.ssn2_wouldClean OR h.dob1_wouldClean OR h.dob2_wouldClean OR h.current_lname1_wouldClean OR h.current_lname2_wouldClean OR h.early_lname1_wouldClean OR h.early_lname2_wouldClean OR h.addr_ind1_wouldClean OR h.addr_ind2_wouldClean OR h.r2rdid_wouldClean OR h.r2cnt_wouldClean OR h.personal_wouldClean OR h.business_wouldClean OR h.other_wouldClean OR h.title_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.confidence_Total_ErrorCount > 0, 1, 0) + IF(le.did1_Total_ErrorCount > 0, 1, 0) + IF(le.did2_Total_ErrorCount > 0, 1, 0) + IF(le.cohabit_score_Total_ErrorCount > 0, 1, 0) + IF(le.cohabit_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coapt_score_Total_ErrorCount > 0, 1, 0) + IF(le.coapt_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.copobox_score_Total_ErrorCount > 0, 1, 0) + IF(le.copobox_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.cossn_score_Total_ErrorCount > 0, 1, 0) + IF(le.cossn_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.copolicy_score_Total_ErrorCount > 0, 1, 0) + IF(le.copolicy_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coclaim_score_Total_ErrorCount > 0, 1, 0) + IF(le.coclaim_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coproperty_score_Total_ErrorCount > 0, 1, 0) + IF(le.coproperty_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_score_Total_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coforeclosure_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coforeclosure_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoforeclosure_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoforeclosure_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.colien_score_Total_ErrorCount > 0, 1, 0) + IF(le.colien_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.bcolien_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcolien_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_score_Total_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_score_Total_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.covehicle_score_Total_ErrorCount > 0, 1, 0) + IF(le.covehicle_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coexperian_score_Total_ErrorCount > 0, 1, 0) + IF(le.coexperian_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.cotransunion_score_Total_ErrorCount > 0, 1, 0) + IF(le.cotransunion_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coenclarity_score_Total_ErrorCount > 0, 1, 0) + IF(le.coenclarity_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.coecrash_score_Total_ErrorCount > 0, 1, 0) + IF(le.coecrash_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_score_Total_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.cowatercraft_score_Total_ErrorCount > 0, 1, 0) + IF(le.cowatercraft_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coaircraft_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coaircraft_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comarriagedivorce_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comarriagedivorce_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coucc_score_Total_ErrorCount > 0, 1, 0) + IF(le.coucc_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.lname_score_Total_ErrorCount > 0, 1, 0) + IF(le.phone_score_Total_ErrorCount > 0, 1, 0) + IF(le.dl_nbr_score_Total_ErrorCount > 0, 1, 0) + IF(le.total_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.total_score_Total_ErrorCount > 0, 1, 0) + IF(le.cluster_Total_ErrorCount > 0, 1, 0) + IF(le.generation_Total_ErrorCount > 0, 1, 0) + IF(le.gender_Total_ErrorCount > 0, 1, 0) + IF(le.lname_cnt_Total_ErrorCount > 0, 1, 0) + IF(le.rel_dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.rel_dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.overlap_months_Total_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.age_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.isanylnamematch_Total_ErrorCount > 0, 1, 0) + IF(le.isanyphonematch_Total_ErrorCount > 0, 1, 0) + IF(le.isearlylnamematch_Total_ErrorCount > 0, 1, 0) + IF(le.iscurrlnamematch_Total_ErrorCount > 0, 1, 0) + IF(le.ismixedlnamematch_Total_ErrorCount > 0, 1, 0) + IF(le.ssn1_Total_ErrorCount > 0, 1, 0) + IF(le.ssn2_Total_ErrorCount > 0, 1, 0) + IF(le.dob1_Total_ErrorCount > 0, 1, 0) + IF(le.dob2_Total_ErrorCount > 0, 1, 0) + IF(le.current_lname1_Total_ErrorCount > 0, 1, 0) + IF(le.current_lname2_Total_ErrorCount > 0, 1, 0) + IF(le.early_lname1_Total_ErrorCount > 0, 1, 0) + IF(le.early_lname2_Total_ErrorCount > 0, 1, 0) + IF(le.addr_ind1_Total_ErrorCount > 0, 1, 0) + IF(le.addr_ind2_Total_ErrorCount > 0, 1, 0) + IF(le.r2rdid_Total_ErrorCount > 0, 1, 0) + IF(le.r2cnt_Total_ErrorCount > 0, 1, 0) + IF(le.personal_Total_ErrorCount > 0, 1, 0) + IF(le.business_Total_ErrorCount > 0, 1, 0) + IF(le.other_Total_ErrorCount > 0, 1, 0) + IF(le.title_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.confidence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.confidence_WORDS_ErrorCount > 0, 1, 0) + IF(le.did1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did1_WORDS_ErrorCount > 0, 1, 0) + IF(le.did2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did2_WORDS_ErrorCount > 0, 1, 0) + IF(le.cohabit_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cohabit_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.cohabit_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cohabit_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cohabit_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coapt_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coapt_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coapt_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coapt_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coapt_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coapt_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.copobox_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.copobox_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.copobox_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.copobox_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.copobox_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.copobox_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.cossn_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cossn_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cossn_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.cossn_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cossn_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cossn_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.copolicy_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.copolicy_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.copolicy_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.copolicy_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.copolicy_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.copolicy_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coclaim_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coclaim_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coclaim_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coclaim_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coclaim_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coclaim_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coproperty_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coproperty_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coproperty_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coproperty_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coproperty_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coproperty_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bcoproperty_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coforeclosure_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coforeclosure_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoforeclosure_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoforeclosure_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.colien_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.colien_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.colien_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.colien_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.colien_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.colien_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcolien_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcolien_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.covehicle_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.covehicle_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.covehicle_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.covehicle_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.covehicle_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.covehicle_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coexperian_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coexperian_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coexperian_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coexperian_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coexperian_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coexperian_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.cotransunion_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cotransunion_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cotransunion_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.cotransunion_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cotransunion_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cotransunion_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coenclarity_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coenclarity_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coenclarity_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coenclarity_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coenclarity_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coenclarity_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.coecrash_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coecrash_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coecrash_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coecrash_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coecrash_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coecrash_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bcoecrash_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.cowatercraft_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cowatercraft_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cowatercraft_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.cowatercraft_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coaircraft_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coaircraft_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comarriagedivorce_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comarriagedivorce_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coucc_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coucc_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coucc_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.coucc_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coucc_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coucc_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.lname_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lname_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.phone_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phone_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.dl_nbr_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_nbr_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.total_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.total_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.cluster_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cluster_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cluster_WORDS_ErrorCount > 0, 1, 0) + IF(le.generation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.generation_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.generation_WORDS_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_WORDS_ErrorCount > 0, 1, 0) + IF(le.lname_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_cnt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lname_cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.rel_dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rel_dt_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rel_dt_first_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.rel_dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rel_dt_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rel_dt_last_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.overlap_months_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overlap_months_WORDS_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.age_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.age_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.age_first_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.isanylnamematch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.isanylnamematch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.isanylnamematch_WORDS_ErrorCount > 0, 1, 0) + IF(le.isanyphonematch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.isanyphonematch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.isanyphonematch_WORDS_ErrorCount > 0, 1, 0) + IF(le.isearlylnamematch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.isearlylnamematch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.isearlylnamematch_WORDS_ErrorCount > 0, 1, 0) + IF(le.iscurrlnamematch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.iscurrlnamematch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.iscurrlnamematch_WORDS_ErrorCount > 0, 1, 0) + IF(le.ismixedlnamematch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ismixedlnamematch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ismixedlnamematch_WORDS_ErrorCount > 0, 1, 0) + IF(le.ssn1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn1_WORDS_ErrorCount > 0, 1, 0) + IF(le.ssn2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn2_WORDS_ErrorCount > 0, 1, 0) + IF(le.dob1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob1_WORDS_ErrorCount > 0, 1, 0) + IF(le.dob2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob2_WORDS_ErrorCount > 0, 1, 0) + IF(le.current_lname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_lname1_WORDS_ErrorCount > 0, 1, 0) + IF(le.current_lname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_lname2_WORDS_ErrorCount > 0, 1, 0) + IF(le.early_lname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.early_lname1_WORDS_ErrorCount > 0, 1, 0) + IF(le.early_lname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.early_lname2_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_ind1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_ind1_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_ind2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_ind2_WORDS_ErrorCount > 0, 1, 0) + IF(le.r2rdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.r2rdid_WORDS_ErrorCount > 0, 1, 0) + IF(le.r2cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.r2cnt_WORDS_ErrorCount > 0, 1, 0) + IF(le.personal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.personal_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.personal_WORDS_ErrorCount > 0, 1, 0) + IF(le.business_ALLOW_ErrorCount > 0, 1, 0) + IF(le.business_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.business_WORDS_ErrorCount > 0, 1, 0) + IF(le.other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.other_WORDS_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.confidence_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.confidence_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.did1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.did1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.did2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.did2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cohabit_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cohabit_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cohabit_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cohabit_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cohabit_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coapt_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coapt_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coapt_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coapt_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coapt_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coapt_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.copobox_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.copobox_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.copobox_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.copobox_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.copobox_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.copobox_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cossn_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cossn_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cossn_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cossn_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cossn_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cossn_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.copolicy_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.copolicy_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.copolicy_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.copolicy_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.copolicy_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.copolicy_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coclaim_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coclaim_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coclaim_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coclaim_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coclaim_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coclaim_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coproperty_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coproperty_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coproperty_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coproperty_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coproperty_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coproperty_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcoproperty_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcoproperty_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.bcoproperty_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcoproperty_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcoproperty_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.bcoproperty_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coforeclosure_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coforeclosure_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcoforeclosure_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcoforeclosure_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.colien_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.colien_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.colien_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.colien_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.colien_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.colien_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcolien_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcolien_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cobankruptcy_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cobankruptcy_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cobankruptcy_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cobankruptcy_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcobankruptcy_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcobankruptcy_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.bcobankruptcy_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.bcobankruptcy_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.covehicle_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.covehicle_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.covehicle_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.covehicle_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.covehicle_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.covehicle_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coexperian_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coexperian_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coexperian_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coexperian_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coexperian_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coexperian_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cotransunion_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cotransunion_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cotransunion_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cotransunion_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cotransunion_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cotransunion_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coenclarity_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coenclarity_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coenclarity_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coenclarity_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coenclarity_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coenclarity_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coecrash_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coecrash_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coecrash_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coecrash_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coecrash_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coecrash_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcoecrash_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcoecrash_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.bcoecrash_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.bcoecrash_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.bcoecrash_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.bcoecrash_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cowatercraft_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cowatercraft_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cowatercraft_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cowatercraft_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coaircraft_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coaircraft_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.comarriagedivorce_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.comarriagedivorce_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coucc_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coucc_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coucc_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.coucc_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.coucc_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.coucc_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.lname_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lname_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lname_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.phone_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.phone_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.phone_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dl_nbr_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dl_nbr_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.total_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.total_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.total_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.total_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.total_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.total_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cluster_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cluster_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cluster_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.generation_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.generation_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.generation_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.gender_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.gender_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.gender_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.lname_cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lname_cnt_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lname_cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.rel_dt_first_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rel_dt_first_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.rel_dt_first_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.rel_dt_last_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rel_dt_last_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.rel_dt_last_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.overlap_months_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.overlap_months_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.hdr_dt_first_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.hdr_dt_last_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.age_first_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.age_first_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.age_first_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.isanylnamematch_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.isanylnamematch_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.isanylnamematch_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.isanyphonematch_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.isanyphonematch_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.isanyphonematch_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.isearlylnamematch_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.isearlylnamematch_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.isearlylnamematch_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.iscurrlnamematch_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.iscurrlnamematch_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.iscurrlnamematch_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ismixedlnamematch_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ismixedlnamematch_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ismixedlnamematch_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ssn1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn1_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ssn1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.ssn2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.ssn2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.ssn2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dob1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob1_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dob2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dob2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dob2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.current_lname1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.current_lname1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.current_lname2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.current_lname2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.early_lname1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.early_lname1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.early_lname2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.early_lname2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_ind1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.addr_ind1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_ind2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.addr_ind2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.r2rdid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.r2rdid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.r2cnt_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.r2cnt_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.personal_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.personal_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.personal_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.business_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.business_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.business_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.other_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.other_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.other_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.title_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.title_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.title_WORDS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.type_Invalid,le.confidence_Invalid,le.did1_Invalid,le.did2_Invalid,le.cohabit_score_Invalid,le.cohabit_cnt_Invalid,le.coapt_score_Invalid,le.coapt_cnt_Invalid,le.copobox_score_Invalid,le.copobox_cnt_Invalid,le.cossn_score_Invalid,le.cossn_cnt_Invalid,le.copolicy_score_Invalid,le.copolicy_cnt_Invalid,le.coclaim_score_Invalid,le.coclaim_cnt_Invalid,le.coproperty_score_Invalid,le.coproperty_cnt_Invalid,le.bcoproperty_score_Invalid,le.bcoproperty_cnt_Invalid,le.coforeclosure_score_Invalid,le.coforeclosure_cnt_Invalid,le.bcoforeclosure_score_Invalid,le.bcoforeclosure_cnt_Invalid,le.colien_score_Invalid,le.colien_cnt_Invalid,le.bcolien_score_Invalid,le.bcolien_cnt_Invalid,le.cobankruptcy_score_Invalid,le.cobankruptcy_cnt_Invalid,le.bcobankruptcy_score_Invalid,le.bcobankruptcy_cnt_Invalid,le.covehicle_score_Invalid,le.covehicle_cnt_Invalid,le.coexperian_score_Invalid,le.coexperian_cnt_Invalid,le.cotransunion_score_Invalid,le.cotransunion_cnt_Invalid,le.coenclarity_score_Invalid,le.coenclarity_cnt_Invalid,le.coecrash_score_Invalid,le.coecrash_cnt_Invalid,le.bcoecrash_score_Invalid,le.bcoecrash_cnt_Invalid,le.cowatercraft_score_Invalid,le.cowatercraft_cnt_Invalid,le.coaircraft_score_Invalid,le.coaircraft_cnt_Invalid,le.comarriagedivorce_score_Invalid,le.comarriagedivorce_cnt_Invalid,le.coucc_score_Invalid,le.coucc_cnt_Invalid,le.lname_score_Invalid,le.phone_score_Invalid,le.dl_nbr_score_Invalid,le.total_cnt_Invalid,le.total_score_Invalid,le.cluster_Invalid,le.generation_Invalid,le.gender_Invalid,le.lname_cnt_Invalid,le.rel_dt_first_seen_Invalid,le.rel_dt_last_seen_Invalid,le.overlap_months_Invalid,le.hdr_dt_first_seen_Invalid,le.hdr_dt_last_seen_Invalid,le.age_first_seen_Invalid,le.isanylnamematch_Invalid,le.isanyphonematch_Invalid,le.isearlylnamematch_Invalid,le.iscurrlnamematch_Invalid,le.ismixedlnamematch_Invalid,le.ssn1_Invalid,le.ssn2_Invalid,le.dob1_Invalid,le.dob2_Invalid,le.current_lname1_Invalid,le.current_lname2_Invalid,le.early_lname1_Invalid,le.early_lname2_Invalid,le.addr_ind1_Invalid,le.addr_ind2_Invalid,le.r2rdid_Invalid,le.r2cnt_Invalid,le.personal_Invalid,le.business_Invalid,le.other_Invalid,le.title_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_type(le.type_Invalid),Fields.InvalidMessage_confidence(le.confidence_Invalid),Fields.InvalidMessage_did1(le.did1_Invalid),Fields.InvalidMessage_did2(le.did2_Invalid),Fields.InvalidMessage_cohabit_score(le.cohabit_score_Invalid),Fields.InvalidMessage_cohabit_cnt(le.cohabit_cnt_Invalid),Fields.InvalidMessage_coapt_score(le.coapt_score_Invalid),Fields.InvalidMessage_coapt_cnt(le.coapt_cnt_Invalid),Fields.InvalidMessage_copobox_score(le.copobox_score_Invalid),Fields.InvalidMessage_copobox_cnt(le.copobox_cnt_Invalid),Fields.InvalidMessage_cossn_score(le.cossn_score_Invalid),Fields.InvalidMessage_cossn_cnt(le.cossn_cnt_Invalid),Fields.InvalidMessage_copolicy_score(le.copolicy_score_Invalid),Fields.InvalidMessage_copolicy_cnt(le.copolicy_cnt_Invalid),Fields.InvalidMessage_coclaim_score(le.coclaim_score_Invalid),Fields.InvalidMessage_coclaim_cnt(le.coclaim_cnt_Invalid),Fields.InvalidMessage_coproperty_score(le.coproperty_score_Invalid),Fields.InvalidMessage_coproperty_cnt(le.coproperty_cnt_Invalid),Fields.InvalidMessage_bcoproperty_score(le.bcoproperty_score_Invalid),Fields.InvalidMessage_bcoproperty_cnt(le.bcoproperty_cnt_Invalid),Fields.InvalidMessage_coforeclosure_score(le.coforeclosure_score_Invalid),Fields.InvalidMessage_coforeclosure_cnt(le.coforeclosure_cnt_Invalid),Fields.InvalidMessage_bcoforeclosure_score(le.bcoforeclosure_score_Invalid),Fields.InvalidMessage_bcoforeclosure_cnt(le.bcoforeclosure_cnt_Invalid),Fields.InvalidMessage_colien_score(le.colien_score_Invalid),Fields.InvalidMessage_colien_cnt(le.colien_cnt_Invalid),Fields.InvalidMessage_bcolien_score(le.bcolien_score_Invalid),Fields.InvalidMessage_bcolien_cnt(le.bcolien_cnt_Invalid),Fields.InvalidMessage_cobankruptcy_score(le.cobankruptcy_score_Invalid),Fields.InvalidMessage_cobankruptcy_cnt(le.cobankruptcy_cnt_Invalid),Fields.InvalidMessage_bcobankruptcy_score(le.bcobankruptcy_score_Invalid),Fields.InvalidMessage_bcobankruptcy_cnt(le.bcobankruptcy_cnt_Invalid),Fields.InvalidMessage_covehicle_score(le.covehicle_score_Invalid),Fields.InvalidMessage_covehicle_cnt(le.covehicle_cnt_Invalid),Fields.InvalidMessage_coexperian_score(le.coexperian_score_Invalid),Fields.InvalidMessage_coexperian_cnt(le.coexperian_cnt_Invalid),Fields.InvalidMessage_cotransunion_score(le.cotransunion_score_Invalid),Fields.InvalidMessage_cotransunion_cnt(le.cotransunion_cnt_Invalid),Fields.InvalidMessage_coenclarity_score(le.coenclarity_score_Invalid),Fields.InvalidMessage_coenclarity_cnt(le.coenclarity_cnt_Invalid),Fields.InvalidMessage_coecrash_score(le.coecrash_score_Invalid),Fields.InvalidMessage_coecrash_cnt(le.coecrash_cnt_Invalid),Fields.InvalidMessage_bcoecrash_score(le.bcoecrash_score_Invalid),Fields.InvalidMessage_bcoecrash_cnt(le.bcoecrash_cnt_Invalid),Fields.InvalidMessage_cowatercraft_score(le.cowatercraft_score_Invalid),Fields.InvalidMessage_cowatercraft_cnt(le.cowatercraft_cnt_Invalid),Fields.InvalidMessage_coaircraft_score(le.coaircraft_score_Invalid),Fields.InvalidMessage_coaircraft_cnt(le.coaircraft_cnt_Invalid),Fields.InvalidMessage_comarriagedivorce_score(le.comarriagedivorce_score_Invalid),Fields.InvalidMessage_comarriagedivorce_cnt(le.comarriagedivorce_cnt_Invalid),Fields.InvalidMessage_coucc_score(le.coucc_score_Invalid),Fields.InvalidMessage_coucc_cnt(le.coucc_cnt_Invalid),Fields.InvalidMessage_lname_score(le.lname_score_Invalid),Fields.InvalidMessage_phone_score(le.phone_score_Invalid),Fields.InvalidMessage_dl_nbr_score(le.dl_nbr_score_Invalid),Fields.InvalidMessage_total_cnt(le.total_cnt_Invalid),Fields.InvalidMessage_total_score(le.total_score_Invalid),Fields.InvalidMessage_cluster(le.cluster_Invalid),Fields.InvalidMessage_generation(le.generation_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_lname_cnt(le.lname_cnt_Invalid),Fields.InvalidMessage_rel_dt_first_seen(le.rel_dt_first_seen_Invalid),Fields.InvalidMessage_rel_dt_last_seen(le.rel_dt_last_seen_Invalid),Fields.InvalidMessage_overlap_months(le.overlap_months_Invalid),Fields.InvalidMessage_hdr_dt_first_seen(le.hdr_dt_first_seen_Invalid),Fields.InvalidMessage_hdr_dt_last_seen(le.hdr_dt_last_seen_Invalid),Fields.InvalidMessage_age_first_seen(le.age_first_seen_Invalid),Fields.InvalidMessage_isanylnamematch(le.isanylnamematch_Invalid),Fields.InvalidMessage_isanyphonematch(le.isanyphonematch_Invalid),Fields.InvalidMessage_isearlylnamematch(le.isearlylnamematch_Invalid),Fields.InvalidMessage_iscurrlnamematch(le.iscurrlnamematch_Invalid),Fields.InvalidMessage_ismixedlnamematch(le.ismixedlnamematch_Invalid),Fields.InvalidMessage_ssn1(le.ssn1_Invalid),Fields.InvalidMessage_ssn2(le.ssn2_Invalid),Fields.InvalidMessage_dob1(le.dob1_Invalid),Fields.InvalidMessage_dob2(le.dob2_Invalid),Fields.InvalidMessage_current_lname1(le.current_lname1_Invalid),Fields.InvalidMessage_current_lname2(le.current_lname2_Invalid),Fields.InvalidMessage_early_lname1(le.early_lname1_Invalid),Fields.InvalidMessage_early_lname2(le.early_lname2_Invalid),Fields.InvalidMessage_addr_ind1(le.addr_ind1_Invalid),Fields.InvalidMessage_addr_ind2(le.addr_ind2_Invalid),Fields.InvalidMessage_r2rdid(le.r2rdid_Invalid),Fields.InvalidMessage_r2cnt(le.r2cnt_Invalid),Fields.InvalidMessage_personal(le.personal_Invalid),Fields.InvalidMessage_business(le.business_Invalid),Fields.InvalidMessage_other(le.other_Invalid),Fields.InvalidMessage_title(le.title_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.confidence_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.did1_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.did2_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.cohabit_score_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.cohabit_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coapt_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coapt_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.copobox_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.copobox_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cossn_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cossn_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.copolicy_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.copolicy_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coclaim_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coclaim_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coproperty_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coproperty_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcoproperty_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcoproperty_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coforeclosure_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coforeclosure_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bcoforeclosure_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bcoforeclosure_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.colien_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.colien_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcolien_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bcolien_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cobankruptcy_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cobankruptcy_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcobankruptcy_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcobankruptcy_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.covehicle_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.covehicle_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coexperian_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coexperian_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cotransunion_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cotransunion_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coenclarity_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coenclarity_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coecrash_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coecrash_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcoecrash_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.bcoecrash_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cowatercraft_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cowatercraft_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coaircraft_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coaircraft_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comarriagedivorce_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comarriagedivorce_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coucc_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.coucc_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dl_nbr_score_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.total_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.total_score_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cluster_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.generation_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_cnt_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.rel_dt_first_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.rel_dt_last_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.overlap_months_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.hdr_dt_first_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.hdr_dt_last_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.age_first_seen_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.isanylnamematch_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.isanyphonematch_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.isearlylnamematch_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.iscurrlnamematch_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ismixedlnamematch_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn1_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn2_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dob1_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dob2_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.current_lname1_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.current_lname2_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.early_lname1_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.early_lname2_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_ind1_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_ind2_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.r2rdid_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.r2cnt_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.personal_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.business_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.other_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.type,(SALT39.StrType)le.confidence,(SALT39.StrType)le.did1,(SALT39.StrType)le.did2,(SALT39.StrType)le.cohabit_score,(SALT39.StrType)le.cohabit_cnt,(SALT39.StrType)le.coapt_score,(SALT39.StrType)le.coapt_cnt,(SALT39.StrType)le.copobox_score,(SALT39.StrType)le.copobox_cnt,(SALT39.StrType)le.cossn_score,(SALT39.StrType)le.cossn_cnt,(SALT39.StrType)le.copolicy_score,(SALT39.StrType)le.copolicy_cnt,(SALT39.StrType)le.coclaim_score,(SALT39.StrType)le.coclaim_cnt,(SALT39.StrType)le.coproperty_score,(SALT39.StrType)le.coproperty_cnt,(SALT39.StrType)le.bcoproperty_score,(SALT39.StrType)le.bcoproperty_cnt,(SALT39.StrType)le.coforeclosure_score,(SALT39.StrType)le.coforeclosure_cnt,(SALT39.StrType)le.bcoforeclosure_score,(SALT39.StrType)le.bcoforeclosure_cnt,(SALT39.StrType)le.colien_score,(SALT39.StrType)le.colien_cnt,(SALT39.StrType)le.bcolien_score,(SALT39.StrType)le.bcolien_cnt,(SALT39.StrType)le.cobankruptcy_score,(SALT39.StrType)le.cobankruptcy_cnt,(SALT39.StrType)le.bcobankruptcy_score,(SALT39.StrType)le.bcobankruptcy_cnt,(SALT39.StrType)le.covehicle_score,(SALT39.StrType)le.covehicle_cnt,(SALT39.StrType)le.coexperian_score,(SALT39.StrType)le.coexperian_cnt,(SALT39.StrType)le.cotransunion_score,(SALT39.StrType)le.cotransunion_cnt,(SALT39.StrType)le.coenclarity_score,(SALT39.StrType)le.coenclarity_cnt,(SALT39.StrType)le.coecrash_score,(SALT39.StrType)le.coecrash_cnt,(SALT39.StrType)le.bcoecrash_score,(SALT39.StrType)le.bcoecrash_cnt,(SALT39.StrType)le.cowatercraft_score,(SALT39.StrType)le.cowatercraft_cnt,(SALT39.StrType)le.coaircraft_score,(SALT39.StrType)le.coaircraft_cnt,(SALT39.StrType)le.comarriagedivorce_score,(SALT39.StrType)le.comarriagedivorce_cnt,(SALT39.StrType)le.coucc_score,(SALT39.StrType)le.coucc_cnt,(SALT39.StrType)le.lname_score,(SALT39.StrType)le.phone_score,(SALT39.StrType)le.dl_nbr_score,(SALT39.StrType)le.total_cnt,(SALT39.StrType)le.total_score,(SALT39.StrType)le.cluster,(SALT39.StrType)le.generation,(SALT39.StrType)le.gender,(SALT39.StrType)le.lname_cnt,(SALT39.StrType)le.rel_dt_first_seen,(SALT39.StrType)le.rel_dt_last_seen,(SALT39.StrType)le.overlap_months,(SALT39.StrType)le.hdr_dt_first_seen,(SALT39.StrType)le.hdr_dt_last_seen,(SALT39.StrType)le.age_first_seen,(SALT39.StrType)le.isanylnamematch,(SALT39.StrType)le.isanyphonematch,(SALT39.StrType)le.isearlylnamematch,(SALT39.StrType)le.iscurrlnamematch,(SALT39.StrType)le.ismixedlnamematch,(SALT39.StrType)le.ssn1,(SALT39.StrType)le.ssn2,(SALT39.StrType)le.dob1,(SALT39.StrType)le.dob2,(SALT39.StrType)le.current_lname1,(SALT39.StrType)le.current_lname2,(SALT39.StrType)le.early_lname1,(SALT39.StrType)le.early_lname2,(SALT39.StrType)le.addr_ind1,(SALT39.StrType)le.addr_ind2,(SALT39.StrType)le.r2rdid,(SALT39.StrType)le.r2cnt,(SALT39.StrType)le.personal,(SALT39.StrType)le.business,(SALT39.StrType)le.other,(SALT39.StrType)le.title,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,88,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_File) prevDS = DATASET([], Layout_File), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'type:type:ALLOW'
          ,'confidence:confidence:ALLOW','confidence:confidence:WORDS'
          ,'did1:did1:ALLOW','did1:did1:WORDS'
          ,'did2:did2:ALLOW','did2:did2:WORDS'
          ,'cohabit_score:cohabit_score:ALLOW','cohabit_score:cohabit_score:WORDS'
          ,'cohabit_cnt:cohabit_cnt:ALLOW','cohabit_cnt:cohabit_cnt:LENGTHS','cohabit_cnt:cohabit_cnt:WORDS'
          ,'coapt_score:coapt_score:ALLOW','coapt_score:coapt_score:LENGTHS','coapt_score:coapt_score:WORDS'
          ,'coapt_cnt:coapt_cnt:ALLOW','coapt_cnt:coapt_cnt:LENGTHS','coapt_cnt:coapt_cnt:WORDS'
          ,'copobox_score:copobox_score:ALLOW','copobox_score:copobox_score:LENGTHS','copobox_score:copobox_score:WORDS'
          ,'copobox_cnt:copobox_cnt:ALLOW','copobox_cnt:copobox_cnt:LENGTHS','copobox_cnt:copobox_cnt:WORDS'
          ,'cossn_score:cossn_score:ALLOW','cossn_score:cossn_score:LENGTHS','cossn_score:cossn_score:WORDS'
          ,'cossn_cnt:cossn_cnt:ALLOW','cossn_cnt:cossn_cnt:LENGTHS','cossn_cnt:cossn_cnt:WORDS'
          ,'copolicy_score:copolicy_score:ALLOW','copolicy_score:copolicy_score:LENGTHS','copolicy_score:copolicy_score:WORDS'
          ,'copolicy_cnt:copolicy_cnt:ALLOW','copolicy_cnt:copolicy_cnt:LENGTHS','copolicy_cnt:copolicy_cnt:WORDS'
          ,'coclaim_score:coclaim_score:ALLOW','coclaim_score:coclaim_score:LENGTHS','coclaim_score:coclaim_score:WORDS'
          ,'coclaim_cnt:coclaim_cnt:ALLOW','coclaim_cnt:coclaim_cnt:LENGTHS','coclaim_cnt:coclaim_cnt:WORDS'
          ,'coproperty_score:coproperty_score:ALLOW','coproperty_score:coproperty_score:LENGTHS','coproperty_score:coproperty_score:WORDS'
          ,'coproperty_cnt:coproperty_cnt:ALLOW','coproperty_cnt:coproperty_cnt:LENGTHS','coproperty_cnt:coproperty_cnt:WORDS'
          ,'bcoproperty_score:bcoproperty_score:ALLOW','bcoproperty_score:bcoproperty_score:LENGTHS','bcoproperty_score:bcoproperty_score:WORDS'
          ,'bcoproperty_cnt:bcoproperty_cnt:ALLOW','bcoproperty_cnt:bcoproperty_cnt:LENGTHS','bcoproperty_cnt:bcoproperty_cnt:WORDS'
          ,'coforeclosure_score:coforeclosure_score:ALLOW'
          ,'coforeclosure_cnt:coforeclosure_cnt:ALLOW'
          ,'bcoforeclosure_score:bcoforeclosure_score:ALLOW'
          ,'bcoforeclosure_cnt:bcoforeclosure_cnt:ALLOW'
          ,'colien_score:colien_score:ALLOW','colien_score:colien_score:LENGTHS','colien_score:colien_score:WORDS'
          ,'colien_cnt:colien_cnt:ALLOW','colien_cnt:colien_cnt:LENGTHS','colien_cnt:colien_cnt:WORDS'
          ,'bcolien_score:bcolien_score:ALLOW'
          ,'bcolien_cnt:bcolien_cnt:ALLOW'
          ,'cobankruptcy_score:cobankruptcy_score:ALLOW','cobankruptcy_score:cobankruptcy_score:LENGTHS','cobankruptcy_score:cobankruptcy_score:WORDS'
          ,'cobankruptcy_cnt:cobankruptcy_cnt:ALLOW','cobankruptcy_cnt:cobankruptcy_cnt:LENGTHS','cobankruptcy_cnt:cobankruptcy_cnt:WORDS'
          ,'bcobankruptcy_score:bcobankruptcy_score:ALLOW','bcobankruptcy_score:bcobankruptcy_score:LENGTHS','bcobankruptcy_score:bcobankruptcy_score:WORDS'
          ,'bcobankruptcy_cnt:bcobankruptcy_cnt:ALLOW','bcobankruptcy_cnt:bcobankruptcy_cnt:LENGTHS','bcobankruptcy_cnt:bcobankruptcy_cnt:WORDS'
          ,'covehicle_score:covehicle_score:ALLOW','covehicle_score:covehicle_score:LENGTHS','covehicle_score:covehicle_score:WORDS'
          ,'covehicle_cnt:covehicle_cnt:ALLOW','covehicle_cnt:covehicle_cnt:LENGTHS','covehicle_cnt:covehicle_cnt:WORDS'
          ,'coexperian_score:coexperian_score:ALLOW','coexperian_score:coexperian_score:LENGTHS','coexperian_score:coexperian_score:WORDS'
          ,'coexperian_cnt:coexperian_cnt:ALLOW','coexperian_cnt:coexperian_cnt:LENGTHS','coexperian_cnt:coexperian_cnt:WORDS'
          ,'cotransunion_score:cotransunion_score:ALLOW','cotransunion_score:cotransunion_score:LENGTHS','cotransunion_score:cotransunion_score:WORDS'
          ,'cotransunion_cnt:cotransunion_cnt:ALLOW','cotransunion_cnt:cotransunion_cnt:LENGTHS','cotransunion_cnt:cotransunion_cnt:WORDS'
          ,'coenclarity_score:coenclarity_score:ALLOW','coenclarity_score:coenclarity_score:LENGTHS','coenclarity_score:coenclarity_score:WORDS'
          ,'coenclarity_cnt:coenclarity_cnt:ALLOW','coenclarity_cnt:coenclarity_cnt:LENGTHS','coenclarity_cnt:coenclarity_cnt:WORDS'
          ,'coecrash_score:coecrash_score:ALLOW','coecrash_score:coecrash_score:LENGTHS','coecrash_score:coecrash_score:WORDS'
          ,'coecrash_cnt:coecrash_cnt:ALLOW','coecrash_cnt:coecrash_cnt:LENGTHS','coecrash_cnt:coecrash_cnt:WORDS'
          ,'bcoecrash_score:bcoecrash_score:ALLOW','bcoecrash_score:bcoecrash_score:LENGTHS','bcoecrash_score:bcoecrash_score:WORDS'
          ,'bcoecrash_cnt:bcoecrash_cnt:ALLOW','bcoecrash_cnt:bcoecrash_cnt:LENGTHS','bcoecrash_cnt:bcoecrash_cnt:WORDS'
          ,'cowatercraft_score:cowatercraft_score:ALLOW','cowatercraft_score:cowatercraft_score:LENGTHS','cowatercraft_score:cowatercraft_score:WORDS'
          ,'cowatercraft_cnt:cowatercraft_cnt:ALLOW'
          ,'coaircraft_score:coaircraft_score:ALLOW'
          ,'coaircraft_cnt:coaircraft_cnt:ALLOW'
          ,'comarriagedivorce_score:comarriagedivorce_score:ALLOW'
          ,'comarriagedivorce_cnt:comarriagedivorce_cnt:ALLOW'
          ,'coucc_score:coucc_score:ALLOW','coucc_score:coucc_score:LENGTHS','coucc_score:coucc_score:WORDS'
          ,'coucc_cnt:coucc_cnt:ALLOW','coucc_cnt:coucc_cnt:LENGTHS','coucc_cnt:coucc_cnt:WORDS'
          ,'lname_score:lname_score:ALLOW','lname_score:lname_score:LENGTHS','lname_score:lname_score:WORDS'
          ,'phone_score:phone_score:ALLOW','phone_score:phone_score:LENGTHS','phone_score:phone_score:WORDS'
          ,'dl_nbr_score:dl_nbr_score:ALLOW','dl_nbr_score:dl_nbr_score:WORDS'
          ,'total_cnt:total_cnt:ALLOW','total_cnt:total_cnt:LENGTHS','total_cnt:total_cnt:WORDS'
          ,'total_score:total_score:ALLOW','total_score:total_score:LENGTHS','total_score:total_score:WORDS'
          ,'cluster:cluster:ALLOW','cluster:cluster:LENGTHS','cluster:cluster:WORDS'
          ,'generation:generation:ALLOW','generation:generation:LENGTHS','generation:generation:WORDS'
          ,'gender:gender:ALLOW','gender:gender:LENGTHS','gender:gender:WORDS'
          ,'lname_cnt:lname_cnt:ALLOW','lname_cnt:lname_cnt:LENGTHS','lname_cnt:lname_cnt:WORDS'
          ,'rel_dt_first_seen:rel_dt_first_seen:ALLOW','rel_dt_first_seen:rel_dt_first_seen:LENGTHS','rel_dt_first_seen:rel_dt_first_seen:WORDS'
          ,'rel_dt_last_seen:rel_dt_last_seen:ALLOW','rel_dt_last_seen:rel_dt_last_seen:LENGTHS','rel_dt_last_seen:rel_dt_last_seen:WORDS'
          ,'overlap_months:overlap_months:ALLOW','overlap_months:overlap_months:WORDS'
          ,'hdr_dt_first_seen:hdr_dt_first_seen:ALLOW','hdr_dt_first_seen:hdr_dt_first_seen:LENGTHS','hdr_dt_first_seen:hdr_dt_first_seen:WORDS'
          ,'hdr_dt_last_seen:hdr_dt_last_seen:ALLOW','hdr_dt_last_seen:hdr_dt_last_seen:LENGTHS','hdr_dt_last_seen:hdr_dt_last_seen:WORDS'
          ,'age_first_seen:age_first_seen:ALLOW','age_first_seen:age_first_seen:LENGTHS','age_first_seen:age_first_seen:WORDS'
          ,'isanylnamematch:isanylnamematch:ALLOW','isanylnamematch:isanylnamematch:LENGTHS','isanylnamematch:isanylnamematch:WORDS'
          ,'isanyphonematch:isanyphonematch:ALLOW','isanyphonematch:isanyphonematch:LENGTHS','isanyphonematch:isanyphonematch:WORDS'
          ,'isearlylnamematch:isearlylnamematch:ALLOW','isearlylnamematch:isearlylnamematch:LENGTHS','isearlylnamematch:isearlylnamematch:WORDS'
          ,'iscurrlnamematch:iscurrlnamematch:ALLOW','iscurrlnamematch:iscurrlnamematch:LENGTHS','iscurrlnamematch:iscurrlnamematch:WORDS'
          ,'ismixedlnamematch:ismixedlnamematch:ALLOW','ismixedlnamematch:ismixedlnamematch:LENGTHS','ismixedlnamematch:ismixedlnamematch:WORDS'
          ,'ssn1:ssn1:ALLOW','ssn1:ssn1:LENGTHS','ssn1:ssn1:WORDS'
          ,'ssn2:ssn2:ALLOW','ssn2:ssn2:LENGTHS','ssn2:ssn2:WORDS'
          ,'dob1:dob1:ALLOW','dob1:dob1:LENGTHS','dob1:dob1:WORDS'
          ,'dob2:dob2:ALLOW','dob2:dob2:LENGTHS','dob2:dob2:WORDS'
          ,'current_lname1:current_lname1:ALLOW','current_lname1:current_lname1:WORDS'
          ,'current_lname2:current_lname2:ALLOW','current_lname2:current_lname2:WORDS'
          ,'early_lname1:early_lname1:ALLOW','early_lname1:early_lname1:WORDS'
          ,'early_lname2:early_lname2:ALLOW','early_lname2:early_lname2:WORDS'
          ,'addr_ind1:addr_ind1:ALLOW','addr_ind1:addr_ind1:WORDS'
          ,'addr_ind2:addr_ind2:ALLOW','addr_ind2:addr_ind2:WORDS'
          ,'r2rdid:r2rdid:ALLOW','r2rdid:r2rdid:WORDS'
          ,'r2cnt:r2cnt:ALLOW','r2cnt:r2cnt:WORDS'
          ,'personal:personal:ALLOW','personal:personal:LENGTHS','personal:personal:WORDS'
          ,'business:business:ALLOW','business:business:LENGTHS','business:business:WORDS'
          ,'other:other:ALLOW','other:other:LENGTHS','other:other:WORDS'
          ,'title:title:ALLOW','title:title:LENGTHS','title:title:WORDS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_type(1)
          ,Fields.InvalidMessage_confidence(1),Fields.InvalidMessage_confidence(2)
          ,Fields.InvalidMessage_did1(1),Fields.InvalidMessage_did1(2)
          ,Fields.InvalidMessage_did2(1),Fields.InvalidMessage_did2(2)
          ,Fields.InvalidMessage_cohabit_score(1),Fields.InvalidMessage_cohabit_score(2)
          ,Fields.InvalidMessage_cohabit_cnt(1),Fields.InvalidMessage_cohabit_cnt(2),Fields.InvalidMessage_cohabit_cnt(3)
          ,Fields.InvalidMessage_coapt_score(1),Fields.InvalidMessage_coapt_score(2),Fields.InvalidMessage_coapt_score(3)
          ,Fields.InvalidMessage_coapt_cnt(1),Fields.InvalidMessage_coapt_cnt(2),Fields.InvalidMessage_coapt_cnt(3)
          ,Fields.InvalidMessage_copobox_score(1),Fields.InvalidMessage_copobox_score(2),Fields.InvalidMessage_copobox_score(3)
          ,Fields.InvalidMessage_copobox_cnt(1),Fields.InvalidMessage_copobox_cnt(2),Fields.InvalidMessage_copobox_cnt(3)
          ,Fields.InvalidMessage_cossn_score(1),Fields.InvalidMessage_cossn_score(2),Fields.InvalidMessage_cossn_score(3)
          ,Fields.InvalidMessage_cossn_cnt(1),Fields.InvalidMessage_cossn_cnt(2),Fields.InvalidMessage_cossn_cnt(3)
          ,Fields.InvalidMessage_copolicy_score(1),Fields.InvalidMessage_copolicy_score(2),Fields.InvalidMessage_copolicy_score(3)
          ,Fields.InvalidMessage_copolicy_cnt(1),Fields.InvalidMessage_copolicy_cnt(2),Fields.InvalidMessage_copolicy_cnt(3)
          ,Fields.InvalidMessage_coclaim_score(1),Fields.InvalidMessage_coclaim_score(2),Fields.InvalidMessage_coclaim_score(3)
          ,Fields.InvalidMessage_coclaim_cnt(1),Fields.InvalidMessage_coclaim_cnt(2),Fields.InvalidMessage_coclaim_cnt(3)
          ,Fields.InvalidMessage_coproperty_score(1),Fields.InvalidMessage_coproperty_score(2),Fields.InvalidMessage_coproperty_score(3)
          ,Fields.InvalidMessage_coproperty_cnt(1),Fields.InvalidMessage_coproperty_cnt(2),Fields.InvalidMessage_coproperty_cnt(3)
          ,Fields.InvalidMessage_bcoproperty_score(1),Fields.InvalidMessage_bcoproperty_score(2),Fields.InvalidMessage_bcoproperty_score(3)
          ,Fields.InvalidMessage_bcoproperty_cnt(1),Fields.InvalidMessage_bcoproperty_cnt(2),Fields.InvalidMessage_bcoproperty_cnt(3)
          ,Fields.InvalidMessage_coforeclosure_score(1)
          ,Fields.InvalidMessage_coforeclosure_cnt(1)
          ,Fields.InvalidMessage_bcoforeclosure_score(1)
          ,Fields.InvalidMessage_bcoforeclosure_cnt(1)
          ,Fields.InvalidMessage_colien_score(1),Fields.InvalidMessage_colien_score(2),Fields.InvalidMessage_colien_score(3)
          ,Fields.InvalidMessage_colien_cnt(1),Fields.InvalidMessage_colien_cnt(2),Fields.InvalidMessage_colien_cnt(3)
          ,Fields.InvalidMessage_bcolien_score(1)
          ,Fields.InvalidMessage_bcolien_cnt(1)
          ,Fields.InvalidMessage_cobankruptcy_score(1),Fields.InvalidMessage_cobankruptcy_score(2),Fields.InvalidMessage_cobankruptcy_score(3)
          ,Fields.InvalidMessage_cobankruptcy_cnt(1),Fields.InvalidMessage_cobankruptcy_cnt(2),Fields.InvalidMessage_cobankruptcy_cnt(3)
          ,Fields.InvalidMessage_bcobankruptcy_score(1),Fields.InvalidMessage_bcobankruptcy_score(2),Fields.InvalidMessage_bcobankruptcy_score(3)
          ,Fields.InvalidMessage_bcobankruptcy_cnt(1),Fields.InvalidMessage_bcobankruptcy_cnt(2),Fields.InvalidMessage_bcobankruptcy_cnt(3)
          ,Fields.InvalidMessage_covehicle_score(1),Fields.InvalidMessage_covehicle_score(2),Fields.InvalidMessage_covehicle_score(3)
          ,Fields.InvalidMessage_covehicle_cnt(1),Fields.InvalidMessage_covehicle_cnt(2),Fields.InvalidMessage_covehicle_cnt(3)
          ,Fields.InvalidMessage_coexperian_score(1),Fields.InvalidMessage_coexperian_score(2),Fields.InvalidMessage_coexperian_score(3)
          ,Fields.InvalidMessage_coexperian_cnt(1),Fields.InvalidMessage_coexperian_cnt(2),Fields.InvalidMessage_coexperian_cnt(3)
          ,Fields.InvalidMessage_cotransunion_score(1),Fields.InvalidMessage_cotransunion_score(2),Fields.InvalidMessage_cotransunion_score(3)
          ,Fields.InvalidMessage_cotransunion_cnt(1),Fields.InvalidMessage_cotransunion_cnt(2),Fields.InvalidMessage_cotransunion_cnt(3)
          ,Fields.InvalidMessage_coenclarity_score(1),Fields.InvalidMessage_coenclarity_score(2),Fields.InvalidMessage_coenclarity_score(3)
          ,Fields.InvalidMessage_coenclarity_cnt(1),Fields.InvalidMessage_coenclarity_cnt(2),Fields.InvalidMessage_coenclarity_cnt(3)
          ,Fields.InvalidMessage_coecrash_score(1),Fields.InvalidMessage_coecrash_score(2),Fields.InvalidMessage_coecrash_score(3)
          ,Fields.InvalidMessage_coecrash_cnt(1),Fields.InvalidMessage_coecrash_cnt(2),Fields.InvalidMessage_coecrash_cnt(3)
          ,Fields.InvalidMessage_bcoecrash_score(1),Fields.InvalidMessage_bcoecrash_score(2),Fields.InvalidMessage_bcoecrash_score(3)
          ,Fields.InvalidMessage_bcoecrash_cnt(1),Fields.InvalidMessage_bcoecrash_cnt(2),Fields.InvalidMessage_bcoecrash_cnt(3)
          ,Fields.InvalidMessage_cowatercraft_score(1),Fields.InvalidMessage_cowatercraft_score(2),Fields.InvalidMessage_cowatercraft_score(3)
          ,Fields.InvalidMessage_cowatercraft_cnt(1)
          ,Fields.InvalidMessage_coaircraft_score(1)
          ,Fields.InvalidMessage_coaircraft_cnt(1)
          ,Fields.InvalidMessage_comarriagedivorce_score(1)
          ,Fields.InvalidMessage_comarriagedivorce_cnt(1)
          ,Fields.InvalidMessage_coucc_score(1),Fields.InvalidMessage_coucc_score(2),Fields.InvalidMessage_coucc_score(3)
          ,Fields.InvalidMessage_coucc_cnt(1),Fields.InvalidMessage_coucc_cnt(2),Fields.InvalidMessage_coucc_cnt(3)
          ,Fields.InvalidMessage_lname_score(1),Fields.InvalidMessage_lname_score(2),Fields.InvalidMessage_lname_score(3)
          ,Fields.InvalidMessage_phone_score(1),Fields.InvalidMessage_phone_score(2),Fields.InvalidMessage_phone_score(3)
          ,Fields.InvalidMessage_dl_nbr_score(1),Fields.InvalidMessage_dl_nbr_score(2)
          ,Fields.InvalidMessage_total_cnt(1),Fields.InvalidMessage_total_cnt(2),Fields.InvalidMessage_total_cnt(3)
          ,Fields.InvalidMessage_total_score(1),Fields.InvalidMessage_total_score(2),Fields.InvalidMessage_total_score(3)
          ,Fields.InvalidMessage_cluster(1),Fields.InvalidMessage_cluster(2),Fields.InvalidMessage_cluster(3)
          ,Fields.InvalidMessage_generation(1),Fields.InvalidMessage_generation(2),Fields.InvalidMessage_generation(3)
          ,Fields.InvalidMessage_gender(1),Fields.InvalidMessage_gender(2),Fields.InvalidMessage_gender(3)
          ,Fields.InvalidMessage_lname_cnt(1),Fields.InvalidMessage_lname_cnt(2),Fields.InvalidMessage_lname_cnt(3)
          ,Fields.InvalidMessage_rel_dt_first_seen(1),Fields.InvalidMessage_rel_dt_first_seen(2),Fields.InvalidMessage_rel_dt_first_seen(3)
          ,Fields.InvalidMessage_rel_dt_last_seen(1),Fields.InvalidMessage_rel_dt_last_seen(2),Fields.InvalidMessage_rel_dt_last_seen(3)
          ,Fields.InvalidMessage_overlap_months(1),Fields.InvalidMessage_overlap_months(2)
          ,Fields.InvalidMessage_hdr_dt_first_seen(1),Fields.InvalidMessage_hdr_dt_first_seen(2),Fields.InvalidMessage_hdr_dt_first_seen(3)
          ,Fields.InvalidMessage_hdr_dt_last_seen(1),Fields.InvalidMessage_hdr_dt_last_seen(2),Fields.InvalidMessage_hdr_dt_last_seen(3)
          ,Fields.InvalidMessage_age_first_seen(1),Fields.InvalidMessage_age_first_seen(2),Fields.InvalidMessage_age_first_seen(3)
          ,Fields.InvalidMessage_isanylnamematch(1),Fields.InvalidMessage_isanylnamematch(2),Fields.InvalidMessage_isanylnamematch(3)
          ,Fields.InvalidMessage_isanyphonematch(1),Fields.InvalidMessage_isanyphonematch(2),Fields.InvalidMessage_isanyphonematch(3)
          ,Fields.InvalidMessage_isearlylnamematch(1),Fields.InvalidMessage_isearlylnamematch(2),Fields.InvalidMessage_isearlylnamematch(3)
          ,Fields.InvalidMessage_iscurrlnamematch(1),Fields.InvalidMessage_iscurrlnamematch(2),Fields.InvalidMessage_iscurrlnamematch(3)
          ,Fields.InvalidMessage_ismixedlnamematch(1),Fields.InvalidMessage_ismixedlnamematch(2),Fields.InvalidMessage_ismixedlnamematch(3)
          ,Fields.InvalidMessage_ssn1(1),Fields.InvalidMessage_ssn1(2),Fields.InvalidMessage_ssn1(3)
          ,Fields.InvalidMessage_ssn2(1),Fields.InvalidMessage_ssn2(2),Fields.InvalidMessage_ssn2(3)
          ,Fields.InvalidMessage_dob1(1),Fields.InvalidMessage_dob1(2),Fields.InvalidMessage_dob1(3)
          ,Fields.InvalidMessage_dob2(1),Fields.InvalidMessage_dob2(2),Fields.InvalidMessage_dob2(3)
          ,Fields.InvalidMessage_current_lname1(1),Fields.InvalidMessage_current_lname1(2)
          ,Fields.InvalidMessage_current_lname2(1),Fields.InvalidMessage_current_lname2(2)
          ,Fields.InvalidMessage_early_lname1(1),Fields.InvalidMessage_early_lname1(2)
          ,Fields.InvalidMessage_early_lname2(1),Fields.InvalidMessage_early_lname2(2)
          ,Fields.InvalidMessage_addr_ind1(1),Fields.InvalidMessage_addr_ind1(2)
          ,Fields.InvalidMessage_addr_ind2(1),Fields.InvalidMessage_addr_ind2(2)
          ,Fields.InvalidMessage_r2rdid(1),Fields.InvalidMessage_r2rdid(2)
          ,Fields.InvalidMessage_r2cnt(1),Fields.InvalidMessage_r2cnt(2)
          ,Fields.InvalidMessage_personal(1),Fields.InvalidMessage_personal(2),Fields.InvalidMessage_personal(3)
          ,Fields.InvalidMessage_business(1),Fields.InvalidMessage_business(2),Fields.InvalidMessage_business(3)
          ,Fields.InvalidMessage_other(1),Fields.InvalidMessage_other(2),Fields.InvalidMessage_other(3)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2),Fields.InvalidMessage_title(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.type_ALLOW_ErrorCount
          ,le.confidence_ALLOW_ErrorCount,le.confidence_WORDS_ErrorCount
          ,le.did1_ALLOW_ErrorCount,le.did1_WORDS_ErrorCount
          ,le.did2_ALLOW_ErrorCount,le.did2_WORDS_ErrorCount
          ,le.cohabit_score_ALLOW_ErrorCount,le.cohabit_score_WORDS_ErrorCount
          ,le.cohabit_cnt_ALLOW_ErrorCount,le.cohabit_cnt_LENGTHS_ErrorCount,le.cohabit_cnt_WORDS_ErrorCount
          ,le.coapt_score_ALLOW_ErrorCount,le.coapt_score_LENGTHS_ErrorCount,le.coapt_score_WORDS_ErrorCount
          ,le.coapt_cnt_ALLOW_ErrorCount,le.coapt_cnt_LENGTHS_ErrorCount,le.coapt_cnt_WORDS_ErrorCount
          ,le.copobox_score_ALLOW_ErrorCount,le.copobox_score_LENGTHS_ErrorCount,le.copobox_score_WORDS_ErrorCount
          ,le.copobox_cnt_ALLOW_ErrorCount,le.copobox_cnt_LENGTHS_ErrorCount,le.copobox_cnt_WORDS_ErrorCount
          ,le.cossn_score_ALLOW_ErrorCount,le.cossn_score_LENGTHS_ErrorCount,le.cossn_score_WORDS_ErrorCount
          ,le.cossn_cnt_ALLOW_ErrorCount,le.cossn_cnt_LENGTHS_ErrorCount,le.cossn_cnt_WORDS_ErrorCount
          ,le.copolicy_score_ALLOW_ErrorCount,le.copolicy_score_LENGTHS_ErrorCount,le.copolicy_score_WORDS_ErrorCount
          ,le.copolicy_cnt_ALLOW_ErrorCount,le.copolicy_cnt_LENGTHS_ErrorCount,le.copolicy_cnt_WORDS_ErrorCount
          ,le.coclaim_score_ALLOW_ErrorCount,le.coclaim_score_LENGTHS_ErrorCount,le.coclaim_score_WORDS_ErrorCount
          ,le.coclaim_cnt_ALLOW_ErrorCount,le.coclaim_cnt_LENGTHS_ErrorCount,le.coclaim_cnt_WORDS_ErrorCount
          ,le.coproperty_score_ALLOW_ErrorCount,le.coproperty_score_LENGTHS_ErrorCount,le.coproperty_score_WORDS_ErrorCount
          ,le.coproperty_cnt_ALLOW_ErrorCount,le.coproperty_cnt_LENGTHS_ErrorCount,le.coproperty_cnt_WORDS_ErrorCount
          ,le.bcoproperty_score_ALLOW_ErrorCount,le.bcoproperty_score_LENGTHS_ErrorCount,le.bcoproperty_score_WORDS_ErrorCount
          ,le.bcoproperty_cnt_ALLOW_ErrorCount,le.bcoproperty_cnt_LENGTHS_ErrorCount,le.bcoproperty_cnt_WORDS_ErrorCount
          ,le.coforeclosure_score_ALLOW_ErrorCount
          ,le.coforeclosure_cnt_ALLOW_ErrorCount
          ,le.bcoforeclosure_score_ALLOW_ErrorCount
          ,le.bcoforeclosure_cnt_ALLOW_ErrorCount
          ,le.colien_score_ALLOW_ErrorCount,le.colien_score_LENGTHS_ErrorCount,le.colien_score_WORDS_ErrorCount
          ,le.colien_cnt_ALLOW_ErrorCount,le.colien_cnt_LENGTHS_ErrorCount,le.colien_cnt_WORDS_ErrorCount
          ,le.bcolien_score_ALLOW_ErrorCount
          ,le.bcolien_cnt_ALLOW_ErrorCount
          ,le.cobankruptcy_score_ALLOW_ErrorCount,le.cobankruptcy_score_LENGTHS_ErrorCount,le.cobankruptcy_score_WORDS_ErrorCount
          ,le.cobankruptcy_cnt_ALLOW_ErrorCount,le.cobankruptcy_cnt_LENGTHS_ErrorCount,le.cobankruptcy_cnt_WORDS_ErrorCount
          ,le.bcobankruptcy_score_ALLOW_ErrorCount,le.bcobankruptcy_score_LENGTHS_ErrorCount,le.bcobankruptcy_score_WORDS_ErrorCount
          ,le.bcobankruptcy_cnt_ALLOW_ErrorCount,le.bcobankruptcy_cnt_LENGTHS_ErrorCount,le.bcobankruptcy_cnt_WORDS_ErrorCount
          ,le.covehicle_score_ALLOW_ErrorCount,le.covehicle_score_LENGTHS_ErrorCount,le.covehicle_score_WORDS_ErrorCount
          ,le.covehicle_cnt_ALLOW_ErrorCount,le.covehicle_cnt_LENGTHS_ErrorCount,le.covehicle_cnt_WORDS_ErrorCount
          ,le.coexperian_score_ALLOW_ErrorCount,le.coexperian_score_LENGTHS_ErrorCount,le.coexperian_score_WORDS_ErrorCount
          ,le.coexperian_cnt_ALLOW_ErrorCount,le.coexperian_cnt_LENGTHS_ErrorCount,le.coexperian_cnt_WORDS_ErrorCount
          ,le.cotransunion_score_ALLOW_ErrorCount,le.cotransunion_score_LENGTHS_ErrorCount,le.cotransunion_score_WORDS_ErrorCount
          ,le.cotransunion_cnt_ALLOW_ErrorCount,le.cotransunion_cnt_LENGTHS_ErrorCount,le.cotransunion_cnt_WORDS_ErrorCount
          ,le.coenclarity_score_ALLOW_ErrorCount,le.coenclarity_score_LENGTHS_ErrorCount,le.coenclarity_score_WORDS_ErrorCount
          ,le.coenclarity_cnt_ALLOW_ErrorCount,le.coenclarity_cnt_LENGTHS_ErrorCount,le.coenclarity_cnt_WORDS_ErrorCount
          ,le.coecrash_score_ALLOW_ErrorCount,le.coecrash_score_LENGTHS_ErrorCount,le.coecrash_score_WORDS_ErrorCount
          ,le.coecrash_cnt_ALLOW_ErrorCount,le.coecrash_cnt_LENGTHS_ErrorCount,le.coecrash_cnt_WORDS_ErrorCount
          ,le.bcoecrash_score_ALLOW_ErrorCount,le.bcoecrash_score_LENGTHS_ErrorCount,le.bcoecrash_score_WORDS_ErrorCount
          ,le.bcoecrash_cnt_ALLOW_ErrorCount,le.bcoecrash_cnt_LENGTHS_ErrorCount,le.bcoecrash_cnt_WORDS_ErrorCount
          ,le.cowatercraft_score_ALLOW_ErrorCount,le.cowatercraft_score_LENGTHS_ErrorCount,le.cowatercraft_score_WORDS_ErrorCount
          ,le.cowatercraft_cnt_ALLOW_ErrorCount
          ,le.coaircraft_score_ALLOW_ErrorCount
          ,le.coaircraft_cnt_ALLOW_ErrorCount
          ,le.comarriagedivorce_score_ALLOW_ErrorCount
          ,le.comarriagedivorce_cnt_ALLOW_ErrorCount
          ,le.coucc_score_ALLOW_ErrorCount,le.coucc_score_LENGTHS_ErrorCount,le.coucc_score_WORDS_ErrorCount
          ,le.coucc_cnt_ALLOW_ErrorCount,le.coucc_cnt_LENGTHS_ErrorCount,le.coucc_cnt_WORDS_ErrorCount
          ,le.lname_score_ALLOW_ErrorCount,le.lname_score_LENGTHS_ErrorCount,le.lname_score_WORDS_ErrorCount
          ,le.phone_score_ALLOW_ErrorCount,le.phone_score_LENGTHS_ErrorCount,le.phone_score_WORDS_ErrorCount
          ,le.dl_nbr_score_ALLOW_ErrorCount,le.dl_nbr_score_WORDS_ErrorCount
          ,le.total_cnt_ALLOW_ErrorCount,le.total_cnt_LENGTHS_ErrorCount,le.total_cnt_WORDS_ErrorCount
          ,le.total_score_ALLOW_ErrorCount,le.total_score_LENGTHS_ErrorCount,le.total_score_WORDS_ErrorCount
          ,le.cluster_ALLOW_ErrorCount,le.cluster_LENGTHS_ErrorCount,le.cluster_WORDS_ErrorCount
          ,le.generation_ALLOW_ErrorCount,le.generation_LENGTHS_ErrorCount,le.generation_WORDS_ErrorCount
          ,le.gender_ALLOW_ErrorCount,le.gender_LENGTHS_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.lname_cnt_ALLOW_ErrorCount,le.lname_cnt_LENGTHS_ErrorCount,le.lname_cnt_WORDS_ErrorCount
          ,le.rel_dt_first_seen_ALLOW_ErrorCount,le.rel_dt_first_seen_LENGTHS_ErrorCount,le.rel_dt_first_seen_WORDS_ErrorCount
          ,le.rel_dt_last_seen_ALLOW_ErrorCount,le.rel_dt_last_seen_LENGTHS_ErrorCount,le.rel_dt_last_seen_WORDS_ErrorCount
          ,le.overlap_months_ALLOW_ErrorCount,le.overlap_months_WORDS_ErrorCount
          ,le.hdr_dt_first_seen_ALLOW_ErrorCount,le.hdr_dt_first_seen_LENGTHS_ErrorCount,le.hdr_dt_first_seen_WORDS_ErrorCount
          ,le.hdr_dt_last_seen_ALLOW_ErrorCount,le.hdr_dt_last_seen_LENGTHS_ErrorCount,le.hdr_dt_last_seen_WORDS_ErrorCount
          ,le.age_first_seen_ALLOW_ErrorCount,le.age_first_seen_LENGTHS_ErrorCount,le.age_first_seen_WORDS_ErrorCount
          ,le.isanylnamematch_ALLOW_ErrorCount,le.isanylnamematch_LENGTHS_ErrorCount,le.isanylnamematch_WORDS_ErrorCount
          ,le.isanyphonematch_ALLOW_ErrorCount,le.isanyphonematch_LENGTHS_ErrorCount,le.isanyphonematch_WORDS_ErrorCount
          ,le.isearlylnamematch_ALLOW_ErrorCount,le.isearlylnamematch_LENGTHS_ErrorCount,le.isearlylnamematch_WORDS_ErrorCount
          ,le.iscurrlnamematch_ALLOW_ErrorCount,le.iscurrlnamematch_LENGTHS_ErrorCount,le.iscurrlnamematch_WORDS_ErrorCount
          ,le.ismixedlnamematch_ALLOW_ErrorCount,le.ismixedlnamematch_LENGTHS_ErrorCount,le.ismixedlnamematch_WORDS_ErrorCount
          ,le.ssn1_ALLOW_ErrorCount,le.ssn1_LENGTHS_ErrorCount,le.ssn1_WORDS_ErrorCount
          ,le.ssn2_ALLOW_ErrorCount,le.ssn2_LENGTHS_ErrorCount,le.ssn2_WORDS_ErrorCount
          ,le.dob1_ALLOW_ErrorCount,le.dob1_LENGTHS_ErrorCount,le.dob1_WORDS_ErrorCount
          ,le.dob2_ALLOW_ErrorCount,le.dob2_LENGTHS_ErrorCount,le.dob2_WORDS_ErrorCount
          ,le.current_lname1_ALLOW_ErrorCount,le.current_lname1_WORDS_ErrorCount
          ,le.current_lname2_ALLOW_ErrorCount,le.current_lname2_WORDS_ErrorCount
          ,le.early_lname1_ALLOW_ErrorCount,le.early_lname1_WORDS_ErrorCount
          ,le.early_lname2_ALLOW_ErrorCount,le.early_lname2_WORDS_ErrorCount
          ,le.addr_ind1_ALLOW_ErrorCount,le.addr_ind1_WORDS_ErrorCount
          ,le.addr_ind2_ALLOW_ErrorCount,le.addr_ind2_WORDS_ErrorCount
          ,le.r2rdid_ALLOW_ErrorCount,le.r2rdid_WORDS_ErrorCount
          ,le.r2cnt_ALLOW_ErrorCount,le.r2cnt_WORDS_ErrorCount
          ,le.personal_ALLOW_ErrorCount,le.personal_LENGTHS_ErrorCount,le.personal_WORDS_ErrorCount
          ,le.business_ALLOW_ErrorCount,le.business_LENGTHS_ErrorCount,le.business_WORDS_ErrorCount
          ,le.other_ALLOW_ErrorCount,le.other_LENGTHS_ErrorCount,le.other_WORDS_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount,le.title_WORDS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.type_ALLOW_ErrorCount
          ,le.confidence_ALLOW_ErrorCount,le.confidence_WORDS_ErrorCount
          ,le.did1_ALLOW_ErrorCount,le.did1_WORDS_ErrorCount
          ,le.did2_ALLOW_ErrorCount,le.did2_WORDS_ErrorCount
          ,le.cohabit_score_ALLOW_ErrorCount,le.cohabit_score_WORDS_ErrorCount
          ,le.cohabit_cnt_ALLOW_ErrorCount,le.cohabit_cnt_LENGTHS_ErrorCount,le.cohabit_cnt_WORDS_ErrorCount
          ,le.coapt_score_ALLOW_ErrorCount,le.coapt_score_LENGTHS_ErrorCount,le.coapt_score_WORDS_ErrorCount
          ,le.coapt_cnt_ALLOW_ErrorCount,le.coapt_cnt_LENGTHS_ErrorCount,le.coapt_cnt_WORDS_ErrorCount
          ,le.copobox_score_ALLOW_ErrorCount,le.copobox_score_LENGTHS_ErrorCount,le.copobox_score_WORDS_ErrorCount
          ,le.copobox_cnt_ALLOW_ErrorCount,le.copobox_cnt_LENGTHS_ErrorCount,le.copobox_cnt_WORDS_ErrorCount
          ,le.cossn_score_ALLOW_ErrorCount,le.cossn_score_LENGTHS_ErrorCount,le.cossn_score_WORDS_ErrorCount
          ,le.cossn_cnt_ALLOW_ErrorCount,le.cossn_cnt_LENGTHS_ErrorCount,le.cossn_cnt_WORDS_ErrorCount
          ,le.copolicy_score_ALLOW_ErrorCount,le.copolicy_score_LENGTHS_ErrorCount,le.copolicy_score_WORDS_ErrorCount
          ,le.copolicy_cnt_ALLOW_ErrorCount,le.copolicy_cnt_LENGTHS_ErrorCount,le.copolicy_cnt_WORDS_ErrorCount
          ,le.coclaim_score_ALLOW_ErrorCount,le.coclaim_score_LENGTHS_ErrorCount,le.coclaim_score_WORDS_ErrorCount
          ,le.coclaim_cnt_ALLOW_ErrorCount,le.coclaim_cnt_LENGTHS_ErrorCount,le.coclaim_cnt_WORDS_ErrorCount
          ,le.coproperty_score_ALLOW_ErrorCount,le.coproperty_score_LENGTHS_ErrorCount,le.coproperty_score_WORDS_ErrorCount
          ,le.coproperty_cnt_ALLOW_ErrorCount,le.coproperty_cnt_LENGTHS_ErrorCount,le.coproperty_cnt_WORDS_ErrorCount
          ,le.bcoproperty_score_ALLOW_ErrorCount,le.bcoproperty_score_LENGTHS_ErrorCount,le.bcoproperty_score_WORDS_ErrorCount
          ,le.bcoproperty_cnt_ALLOW_ErrorCount,le.bcoproperty_cnt_LENGTHS_ErrorCount,le.bcoproperty_cnt_WORDS_ErrorCount
          ,le.coforeclosure_score_ALLOW_ErrorCount
          ,le.coforeclosure_cnt_ALLOW_ErrorCount
          ,le.bcoforeclosure_score_ALLOW_ErrorCount
          ,le.bcoforeclosure_cnt_ALLOW_ErrorCount
          ,le.colien_score_ALLOW_ErrorCount,le.colien_score_LENGTHS_ErrorCount,le.colien_score_WORDS_ErrorCount
          ,le.colien_cnt_ALLOW_ErrorCount,le.colien_cnt_LENGTHS_ErrorCount,le.colien_cnt_WORDS_ErrorCount
          ,le.bcolien_score_ALLOW_ErrorCount
          ,le.bcolien_cnt_ALLOW_ErrorCount
          ,le.cobankruptcy_score_ALLOW_ErrorCount,le.cobankruptcy_score_LENGTHS_ErrorCount,le.cobankruptcy_score_WORDS_ErrorCount
          ,le.cobankruptcy_cnt_ALLOW_ErrorCount,le.cobankruptcy_cnt_LENGTHS_ErrorCount,le.cobankruptcy_cnt_WORDS_ErrorCount
          ,le.bcobankruptcy_score_ALLOW_ErrorCount,le.bcobankruptcy_score_LENGTHS_ErrorCount,le.bcobankruptcy_score_WORDS_ErrorCount
          ,le.bcobankruptcy_cnt_ALLOW_ErrorCount,le.bcobankruptcy_cnt_LENGTHS_ErrorCount,le.bcobankruptcy_cnt_WORDS_ErrorCount
          ,le.covehicle_score_ALLOW_ErrorCount,le.covehicle_score_LENGTHS_ErrorCount,le.covehicle_score_WORDS_ErrorCount
          ,le.covehicle_cnt_ALLOW_ErrorCount,le.covehicle_cnt_LENGTHS_ErrorCount,le.covehicle_cnt_WORDS_ErrorCount
          ,le.coexperian_score_ALLOW_ErrorCount,le.coexperian_score_LENGTHS_ErrorCount,le.coexperian_score_WORDS_ErrorCount
          ,le.coexperian_cnt_ALLOW_ErrorCount,le.coexperian_cnt_LENGTHS_ErrorCount,le.coexperian_cnt_WORDS_ErrorCount
          ,le.cotransunion_score_ALLOW_ErrorCount,le.cotransunion_score_LENGTHS_ErrorCount,le.cotransunion_score_WORDS_ErrorCount
          ,le.cotransunion_cnt_ALLOW_ErrorCount,le.cotransunion_cnt_LENGTHS_ErrorCount,le.cotransunion_cnt_WORDS_ErrorCount
          ,le.coenclarity_score_ALLOW_ErrorCount,le.coenclarity_score_LENGTHS_ErrorCount,le.coenclarity_score_WORDS_ErrorCount
          ,le.coenclarity_cnt_ALLOW_ErrorCount,le.coenclarity_cnt_LENGTHS_ErrorCount,le.coenclarity_cnt_WORDS_ErrorCount
          ,le.coecrash_score_ALLOW_ErrorCount,le.coecrash_score_LENGTHS_ErrorCount,le.coecrash_score_WORDS_ErrorCount
          ,le.coecrash_cnt_ALLOW_ErrorCount,le.coecrash_cnt_LENGTHS_ErrorCount,le.coecrash_cnt_WORDS_ErrorCount
          ,le.bcoecrash_score_ALLOW_ErrorCount,le.bcoecrash_score_LENGTHS_ErrorCount,le.bcoecrash_score_WORDS_ErrorCount
          ,le.bcoecrash_cnt_ALLOW_ErrorCount,le.bcoecrash_cnt_LENGTHS_ErrorCount,le.bcoecrash_cnt_WORDS_ErrorCount
          ,le.cowatercraft_score_ALLOW_ErrorCount,le.cowatercraft_score_LENGTHS_ErrorCount,le.cowatercraft_score_WORDS_ErrorCount
          ,le.cowatercraft_cnt_ALLOW_ErrorCount
          ,le.coaircraft_score_ALLOW_ErrorCount
          ,le.coaircraft_cnt_ALLOW_ErrorCount
          ,le.comarriagedivorce_score_ALLOW_ErrorCount
          ,le.comarriagedivorce_cnt_ALLOW_ErrorCount
          ,le.coucc_score_ALLOW_ErrorCount,le.coucc_score_LENGTHS_ErrorCount,le.coucc_score_WORDS_ErrorCount
          ,le.coucc_cnt_ALLOW_ErrorCount,le.coucc_cnt_LENGTHS_ErrorCount,le.coucc_cnt_WORDS_ErrorCount
          ,le.lname_score_ALLOW_ErrorCount,le.lname_score_LENGTHS_ErrorCount,le.lname_score_WORDS_ErrorCount
          ,le.phone_score_ALLOW_ErrorCount,le.phone_score_LENGTHS_ErrorCount,le.phone_score_WORDS_ErrorCount
          ,le.dl_nbr_score_ALLOW_ErrorCount,le.dl_nbr_score_WORDS_ErrorCount
          ,le.total_cnt_ALLOW_ErrorCount,le.total_cnt_LENGTHS_ErrorCount,le.total_cnt_WORDS_ErrorCount
          ,le.total_score_ALLOW_ErrorCount,le.total_score_LENGTHS_ErrorCount,le.total_score_WORDS_ErrorCount
          ,le.cluster_ALLOW_ErrorCount,le.cluster_LENGTHS_ErrorCount,le.cluster_WORDS_ErrorCount
          ,le.generation_ALLOW_ErrorCount,le.generation_LENGTHS_ErrorCount,le.generation_WORDS_ErrorCount
          ,le.gender_ALLOW_ErrorCount,le.gender_LENGTHS_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.lname_cnt_ALLOW_ErrorCount,le.lname_cnt_LENGTHS_ErrorCount,le.lname_cnt_WORDS_ErrorCount
          ,le.rel_dt_first_seen_ALLOW_ErrorCount,le.rel_dt_first_seen_LENGTHS_ErrorCount,le.rel_dt_first_seen_WORDS_ErrorCount
          ,le.rel_dt_last_seen_ALLOW_ErrorCount,le.rel_dt_last_seen_LENGTHS_ErrorCount,le.rel_dt_last_seen_WORDS_ErrorCount
          ,le.overlap_months_ALLOW_ErrorCount,le.overlap_months_WORDS_ErrorCount
          ,le.hdr_dt_first_seen_ALLOW_ErrorCount,le.hdr_dt_first_seen_LENGTHS_ErrorCount,le.hdr_dt_first_seen_WORDS_ErrorCount
          ,le.hdr_dt_last_seen_ALLOW_ErrorCount,le.hdr_dt_last_seen_LENGTHS_ErrorCount,le.hdr_dt_last_seen_WORDS_ErrorCount
          ,le.age_first_seen_ALLOW_ErrorCount,le.age_first_seen_LENGTHS_ErrorCount,le.age_first_seen_WORDS_ErrorCount
          ,le.isanylnamematch_ALLOW_ErrorCount,le.isanylnamematch_LENGTHS_ErrorCount,le.isanylnamematch_WORDS_ErrorCount
          ,le.isanyphonematch_ALLOW_ErrorCount,le.isanyphonematch_LENGTHS_ErrorCount,le.isanyphonematch_WORDS_ErrorCount
          ,le.isearlylnamematch_ALLOW_ErrorCount,le.isearlylnamematch_LENGTHS_ErrorCount,le.isearlylnamematch_WORDS_ErrorCount
          ,le.iscurrlnamematch_ALLOW_ErrorCount,le.iscurrlnamematch_LENGTHS_ErrorCount,le.iscurrlnamematch_WORDS_ErrorCount
          ,le.ismixedlnamematch_ALLOW_ErrorCount,le.ismixedlnamematch_LENGTHS_ErrorCount,le.ismixedlnamematch_WORDS_ErrorCount
          ,le.ssn1_ALLOW_ErrorCount,le.ssn1_LENGTHS_ErrorCount,le.ssn1_WORDS_ErrorCount
          ,le.ssn2_ALLOW_ErrorCount,le.ssn2_LENGTHS_ErrorCount,le.ssn2_WORDS_ErrorCount
          ,le.dob1_ALLOW_ErrorCount,le.dob1_LENGTHS_ErrorCount,le.dob1_WORDS_ErrorCount
          ,le.dob2_ALLOW_ErrorCount,le.dob2_LENGTHS_ErrorCount,le.dob2_WORDS_ErrorCount
          ,le.current_lname1_ALLOW_ErrorCount,le.current_lname1_WORDS_ErrorCount
          ,le.current_lname2_ALLOW_ErrorCount,le.current_lname2_WORDS_ErrorCount
          ,le.early_lname1_ALLOW_ErrorCount,le.early_lname1_WORDS_ErrorCount
          ,le.early_lname2_ALLOW_ErrorCount,le.early_lname2_WORDS_ErrorCount
          ,le.addr_ind1_ALLOW_ErrorCount,le.addr_ind1_WORDS_ErrorCount
          ,le.addr_ind2_ALLOW_ErrorCount,le.addr_ind2_WORDS_ErrorCount
          ,le.r2rdid_ALLOW_ErrorCount,le.r2rdid_WORDS_ErrorCount
          ,le.r2cnt_ALLOW_ErrorCount,le.r2cnt_WORDS_ErrorCount
          ,le.personal_ALLOW_ErrorCount,le.personal_LENGTHS_ErrorCount,le.personal_WORDS_ErrorCount
          ,le.business_ALLOW_ErrorCount,le.business_LENGTHS_ErrorCount,le.business_WORDS_ErrorCount
          ,le.other_ALLOW_ErrorCount,le.other_LENGTHS_ErrorCount,le.other_WORDS_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount,le.title_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_File));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'type:' + getFieldTypeText(h.type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'confidence:' + getFieldTypeText(h.confidence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did1:' + getFieldTypeText(h.did1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did2:' + getFieldTypeText(h.did2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cohabit_score:' + getFieldTypeText(h.cohabit_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cohabit_cnt:' + getFieldTypeText(h.cohabit_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coapt_score:' + getFieldTypeText(h.coapt_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coapt_cnt:' + getFieldTypeText(h.coapt_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'copobox_score:' + getFieldTypeText(h.copobox_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'copobox_cnt:' + getFieldTypeText(h.copobox_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cossn_score:' + getFieldTypeText(h.cossn_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cossn_cnt:' + getFieldTypeText(h.cossn_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'copolicy_score:' + getFieldTypeText(h.copolicy_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'copolicy_cnt:' + getFieldTypeText(h.copolicy_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coclaim_score:' + getFieldTypeText(h.coclaim_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coclaim_cnt:' + getFieldTypeText(h.coclaim_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coproperty_score:' + getFieldTypeText(h.coproperty_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coproperty_cnt:' + getFieldTypeText(h.coproperty_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcoproperty_score:' + getFieldTypeText(h.bcoproperty_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcoproperty_cnt:' + getFieldTypeText(h.bcoproperty_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coforeclosure_score:' + getFieldTypeText(h.coforeclosure_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coforeclosure_cnt:' + getFieldTypeText(h.coforeclosure_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcoforeclosure_score:' + getFieldTypeText(h.bcoforeclosure_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcoforeclosure_cnt:' + getFieldTypeText(h.bcoforeclosure_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'colien_score:' + getFieldTypeText(h.colien_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'colien_cnt:' + getFieldTypeText(h.colien_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcolien_score:' + getFieldTypeText(h.bcolien_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcolien_cnt:' + getFieldTypeText(h.bcolien_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cobankruptcy_score:' + getFieldTypeText(h.cobankruptcy_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cobankruptcy_cnt:' + getFieldTypeText(h.cobankruptcy_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcobankruptcy_score:' + getFieldTypeText(h.bcobankruptcy_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcobankruptcy_cnt:' + getFieldTypeText(h.bcobankruptcy_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'covehicle_score:' + getFieldTypeText(h.covehicle_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'covehicle_cnt:' + getFieldTypeText(h.covehicle_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coexperian_score:' + getFieldTypeText(h.coexperian_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coexperian_cnt:' + getFieldTypeText(h.coexperian_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cotransunion_score:' + getFieldTypeText(h.cotransunion_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cotransunion_cnt:' + getFieldTypeText(h.cotransunion_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coenclarity_score:' + getFieldTypeText(h.coenclarity_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coenclarity_cnt:' + getFieldTypeText(h.coenclarity_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coecrash_score:' + getFieldTypeText(h.coecrash_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coecrash_cnt:' + getFieldTypeText(h.coecrash_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcoecrash_score:' + getFieldTypeText(h.bcoecrash_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bcoecrash_cnt:' + getFieldTypeText(h.bcoecrash_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cowatercraft_score:' + getFieldTypeText(h.cowatercraft_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cowatercraft_cnt:' + getFieldTypeText(h.cowatercraft_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coaircraft_score:' + getFieldTypeText(h.coaircraft_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coaircraft_cnt:' + getFieldTypeText(h.coaircraft_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comarriagedivorce_score:' + getFieldTypeText(h.comarriagedivorce_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comarriagedivorce_cnt:' + getFieldTypeText(h.comarriagedivorce_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coucc_score:' + getFieldTypeText(h.coucc_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coucc_cnt:' + getFieldTypeText(h.coucc_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname_score:' + getFieldTypeText(h.lname_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_score:' + getFieldTypeText(h.phone_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_nbr_score:' + getFieldTypeText(h.dl_nbr_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_cnt:' + getFieldTypeText(h.total_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_score:' + getFieldTypeText(h.total_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cluster:' + getFieldTypeText(h.cluster) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'generation:' + getFieldTypeText(h.generation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname_cnt:' + getFieldTypeText(h.lname_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rel_dt_first_seen:' + getFieldTypeText(h.rel_dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rel_dt_last_seen:' + getFieldTypeText(h.rel_dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'overlap_months:' + getFieldTypeText(h.overlap_months) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hdr_dt_first_seen:' + getFieldTypeText(h.hdr_dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hdr_dt_last_seen:' + getFieldTypeText(h.hdr_dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age_first_seen:' + getFieldTypeText(h.age_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'isanylnamematch:' + getFieldTypeText(h.isanylnamematch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'isanyphonematch:' + getFieldTypeText(h.isanyphonematch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'isearlylnamematch:' + getFieldTypeText(h.isearlylnamematch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'iscurrlnamematch:' + getFieldTypeText(h.iscurrlnamematch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ismixedlnamematch:' + getFieldTypeText(h.ismixedlnamematch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn1:' + getFieldTypeText(h.ssn1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn2:' + getFieldTypeText(h.ssn2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob1:' + getFieldTypeText(h.dob1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob2:' + getFieldTypeText(h.dob2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_lname1:' + getFieldTypeText(h.current_lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_lname2:' + getFieldTypeText(h.current_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'early_lname1:' + getFieldTypeText(h.early_lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'early_lname2:' + getFieldTypeText(h.early_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_ind1:' + getFieldTypeText(h.addr_ind1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_ind2:' + getFieldTypeText(h.addr_ind2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'r2rdid:' + getFieldTypeText(h.r2rdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'r2cnt:' + getFieldTypeText(h.r2cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'personal:' + getFieldTypeText(h.personal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business:' + getFieldTypeText(h.business) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other:' + getFieldTypeText(h.other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_type_cnt
          ,le.populated_confidence_cnt
          ,le.populated_did1_cnt
          ,le.populated_did2_cnt
          ,le.populated_cohabit_score_cnt
          ,le.populated_cohabit_cnt_cnt
          ,le.populated_coapt_score_cnt
          ,le.populated_coapt_cnt_cnt
          ,le.populated_copobox_score_cnt
          ,le.populated_copobox_cnt_cnt
          ,le.populated_cossn_score_cnt
          ,le.populated_cossn_cnt_cnt
          ,le.populated_copolicy_score_cnt
          ,le.populated_copolicy_cnt_cnt
          ,le.populated_coclaim_score_cnt
          ,le.populated_coclaim_cnt_cnt
          ,le.populated_coproperty_score_cnt
          ,le.populated_coproperty_cnt_cnt
          ,le.populated_bcoproperty_score_cnt
          ,le.populated_bcoproperty_cnt_cnt
          ,le.populated_coforeclosure_score_cnt
          ,le.populated_coforeclosure_cnt_cnt
          ,le.populated_bcoforeclosure_score_cnt
          ,le.populated_bcoforeclosure_cnt_cnt
          ,le.populated_colien_score_cnt
          ,le.populated_colien_cnt_cnt
          ,le.populated_bcolien_score_cnt
          ,le.populated_bcolien_cnt_cnt
          ,le.populated_cobankruptcy_score_cnt
          ,le.populated_cobankruptcy_cnt_cnt
          ,le.populated_bcobankruptcy_score_cnt
          ,le.populated_bcobankruptcy_cnt_cnt
          ,le.populated_covehicle_score_cnt
          ,le.populated_covehicle_cnt_cnt
          ,le.populated_coexperian_score_cnt
          ,le.populated_coexperian_cnt_cnt
          ,le.populated_cotransunion_score_cnt
          ,le.populated_cotransunion_cnt_cnt
          ,le.populated_coenclarity_score_cnt
          ,le.populated_coenclarity_cnt_cnt
          ,le.populated_coecrash_score_cnt
          ,le.populated_coecrash_cnt_cnt
          ,le.populated_bcoecrash_score_cnt
          ,le.populated_bcoecrash_cnt_cnt
          ,le.populated_cowatercraft_score_cnt
          ,le.populated_cowatercraft_cnt_cnt
          ,le.populated_coaircraft_score_cnt
          ,le.populated_coaircraft_cnt_cnt
          ,le.populated_comarriagedivorce_score_cnt
          ,le.populated_comarriagedivorce_cnt_cnt
          ,le.populated_coucc_score_cnt
          ,le.populated_coucc_cnt_cnt
          ,le.populated_lname_score_cnt
          ,le.populated_phone_score_cnt
          ,le.populated_dl_nbr_score_cnt
          ,le.populated_total_cnt_cnt
          ,le.populated_total_score_cnt
          ,le.populated_cluster_cnt
          ,le.populated_generation_cnt
          ,le.populated_gender_cnt
          ,le.populated_lname_cnt_cnt
          ,le.populated_rel_dt_first_seen_cnt
          ,le.populated_rel_dt_last_seen_cnt
          ,le.populated_overlap_months_cnt
          ,le.populated_hdr_dt_first_seen_cnt
          ,le.populated_hdr_dt_last_seen_cnt
          ,le.populated_age_first_seen_cnt
          ,le.populated_isanylnamematch_cnt
          ,le.populated_isanyphonematch_cnt
          ,le.populated_isearlylnamematch_cnt
          ,le.populated_iscurrlnamematch_cnt
          ,le.populated_ismixedlnamematch_cnt
          ,le.populated_ssn1_cnt
          ,le.populated_ssn2_cnt
          ,le.populated_dob1_cnt
          ,le.populated_dob2_cnt
          ,le.populated_current_lname1_cnt
          ,le.populated_current_lname2_cnt
          ,le.populated_early_lname1_cnt
          ,le.populated_early_lname2_cnt
          ,le.populated_addr_ind1_cnt
          ,le.populated_addr_ind2_cnt
          ,le.populated_r2rdid_cnt
          ,le.populated_r2cnt_cnt
          ,le.populated_personal_cnt
          ,le.populated_business_cnt
          ,le.populated_other_cnt
          ,le.populated_title_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_type_pcnt
          ,le.populated_confidence_pcnt
          ,le.populated_did1_pcnt
          ,le.populated_did2_pcnt
          ,le.populated_cohabit_score_pcnt
          ,le.populated_cohabit_cnt_pcnt
          ,le.populated_coapt_score_pcnt
          ,le.populated_coapt_cnt_pcnt
          ,le.populated_copobox_score_pcnt
          ,le.populated_copobox_cnt_pcnt
          ,le.populated_cossn_score_pcnt
          ,le.populated_cossn_cnt_pcnt
          ,le.populated_copolicy_score_pcnt
          ,le.populated_copolicy_cnt_pcnt
          ,le.populated_coclaim_score_pcnt
          ,le.populated_coclaim_cnt_pcnt
          ,le.populated_coproperty_score_pcnt
          ,le.populated_coproperty_cnt_pcnt
          ,le.populated_bcoproperty_score_pcnt
          ,le.populated_bcoproperty_cnt_pcnt
          ,le.populated_coforeclosure_score_pcnt
          ,le.populated_coforeclosure_cnt_pcnt
          ,le.populated_bcoforeclosure_score_pcnt
          ,le.populated_bcoforeclosure_cnt_pcnt
          ,le.populated_colien_score_pcnt
          ,le.populated_colien_cnt_pcnt
          ,le.populated_bcolien_score_pcnt
          ,le.populated_bcolien_cnt_pcnt
          ,le.populated_cobankruptcy_score_pcnt
          ,le.populated_cobankruptcy_cnt_pcnt
          ,le.populated_bcobankruptcy_score_pcnt
          ,le.populated_bcobankruptcy_cnt_pcnt
          ,le.populated_covehicle_score_pcnt
          ,le.populated_covehicle_cnt_pcnt
          ,le.populated_coexperian_score_pcnt
          ,le.populated_coexperian_cnt_pcnt
          ,le.populated_cotransunion_score_pcnt
          ,le.populated_cotransunion_cnt_pcnt
          ,le.populated_coenclarity_score_pcnt
          ,le.populated_coenclarity_cnt_pcnt
          ,le.populated_coecrash_score_pcnt
          ,le.populated_coecrash_cnt_pcnt
          ,le.populated_bcoecrash_score_pcnt
          ,le.populated_bcoecrash_cnt_pcnt
          ,le.populated_cowatercraft_score_pcnt
          ,le.populated_cowatercraft_cnt_pcnt
          ,le.populated_coaircraft_score_pcnt
          ,le.populated_coaircraft_cnt_pcnt
          ,le.populated_comarriagedivorce_score_pcnt
          ,le.populated_comarriagedivorce_cnt_pcnt
          ,le.populated_coucc_score_pcnt
          ,le.populated_coucc_cnt_pcnt
          ,le.populated_lname_score_pcnt
          ,le.populated_phone_score_pcnt
          ,le.populated_dl_nbr_score_pcnt
          ,le.populated_total_cnt_pcnt
          ,le.populated_total_score_pcnt
          ,le.populated_cluster_pcnt
          ,le.populated_generation_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_lname_cnt_pcnt
          ,le.populated_rel_dt_first_seen_pcnt
          ,le.populated_rel_dt_last_seen_pcnt
          ,le.populated_overlap_months_pcnt
          ,le.populated_hdr_dt_first_seen_pcnt
          ,le.populated_hdr_dt_last_seen_pcnt
          ,le.populated_age_first_seen_pcnt
          ,le.populated_isanylnamematch_pcnt
          ,le.populated_isanyphonematch_pcnt
          ,le.populated_isearlylnamematch_pcnt
          ,le.populated_iscurrlnamematch_pcnt
          ,le.populated_ismixedlnamematch_pcnt
          ,le.populated_ssn1_pcnt
          ,le.populated_ssn2_pcnt
          ,le.populated_dob1_pcnt
          ,le.populated_dob2_pcnt
          ,le.populated_current_lname1_pcnt
          ,le.populated_current_lname2_pcnt
          ,le.populated_early_lname1_pcnt
          ,le.populated_early_lname2_pcnt
          ,le.populated_addr_ind1_pcnt
          ,le.populated_addr_ind2_pcnt
          ,le.populated_r2rdid_pcnt
          ,le.populated_r2cnt_pcnt
          ,le.populated_personal_pcnt
          ,le.populated_business_pcnt
          ,le.populated_other_pcnt
          ,le.populated_title_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,88,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_File));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),88,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_File) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FileRelative_Monthly, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
