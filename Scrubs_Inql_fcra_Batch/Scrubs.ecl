IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 225;
  EXPORT NumRulesFromFieldType := 225;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 64;
  EXPORT NumFieldsWithPossibleEdits := 64;
  EXPORT NumRulesWithPossibleEdits := 225;
  EXPORT Expanded_Layout := RECORD(Layout_FILE)
    UNSIGNED1 orig_datetime_stamp_Invalid;
    BOOLEAN orig_datetime_stamp_wouldClean;
    UNSIGNED1 orig_global_company_id_Invalid;
    BOOLEAN orig_global_company_id_wouldClean;
    UNSIGNED1 orig_company_id_Invalid;
    BOOLEAN orig_company_id_wouldClean;
    UNSIGNED1 orig_product_cd_Invalid;
    BOOLEAN orig_product_cd_wouldClean;
    UNSIGNED1 orig_method_Invalid;
    BOOLEAN orig_method_wouldClean;
    UNSIGNED1 orig_vertical_Invalid;
    BOOLEAN orig_vertical_wouldClean;
    UNSIGNED1 orig_function_name_Invalid;
    BOOLEAN orig_function_name_wouldClean;
    UNSIGNED1 orig_transaction_type_Invalid;
    BOOLEAN orig_transaction_type_wouldClean;
    UNSIGNED1 orig_login_history_id_Invalid;
    BOOLEAN orig_login_history_id_wouldClean;
    UNSIGNED1 orig_job_id_Invalid;
    BOOLEAN orig_job_id_wouldClean;
    UNSIGNED1 orig_sequence_number_Invalid;
    BOOLEAN orig_sequence_number_wouldClean;
    UNSIGNED1 orig_first_name_Invalid;
    BOOLEAN orig_first_name_wouldClean;
    UNSIGNED1 orig_middle_name_Invalid;
    BOOLEAN orig_middle_name_wouldClean;
    UNSIGNED1 orig_last_name_Invalid;
    BOOLEAN orig_last_name_wouldClean;
    UNSIGNED1 orig_ssn_Invalid;
    BOOLEAN orig_ssn_wouldClean;
    UNSIGNED1 orig_dob_Invalid;
    BOOLEAN orig_dob_wouldClean;
    UNSIGNED1 orig_dl_num_Invalid;
    BOOLEAN orig_dl_num_wouldClean;
    UNSIGNED1 orig_dl_state_Invalid;
    BOOLEAN orig_dl_state_wouldClean;
    UNSIGNED1 orig_address1_addressline1_Invalid;
    BOOLEAN orig_address1_addressline1_wouldClean;
    UNSIGNED1 orig_address1_addressline2_Invalid;
    BOOLEAN orig_address1_addressline2_wouldClean;
    UNSIGNED1 orig_address1_prim_range_Invalid;
    BOOLEAN orig_address1_prim_range_wouldClean;
    UNSIGNED1 orig_address1_predir_Invalid;
    BOOLEAN orig_address1_predir_wouldClean;
    UNSIGNED1 orig_address1_prim_name_Invalid;
    BOOLEAN orig_address1_prim_name_wouldClean;
    UNSIGNED1 orig_address1_suffix_Invalid;
    BOOLEAN orig_address1_suffix_wouldClean;
    UNSIGNED1 orig_address1_postdir_Invalid;
    BOOLEAN orig_address1_postdir_wouldClean;
    UNSIGNED1 orig_address1_unit_desig_Invalid;
    BOOLEAN orig_address1_unit_desig_wouldClean;
    UNSIGNED1 orig_address1_sec_range_Invalid;
    BOOLEAN orig_address1_sec_range_wouldClean;
    UNSIGNED1 orig_address1_city_Invalid;
    BOOLEAN orig_address1_city_wouldClean;
    UNSIGNED1 orig_address1_st_Invalid;
    BOOLEAN orig_address1_st_wouldClean;
    UNSIGNED1 orig_address1_z5_Invalid;
    BOOLEAN orig_address1_z5_wouldClean;
    UNSIGNED1 orig_address1_z4_Invalid;
    BOOLEAN orig_address1_z4_wouldClean;
    UNSIGNED1 orig_address2_addressline1_Invalid;
    BOOLEAN orig_address2_addressline1_wouldClean;
    UNSIGNED1 orig_address2_addressline2_Invalid;
    BOOLEAN orig_address2_addressline2_wouldClean;
    UNSIGNED1 orig_address2_prim_range_Invalid;
    BOOLEAN orig_address2_prim_range_wouldClean;
    UNSIGNED1 orig_address2_predir_Invalid;
    BOOLEAN orig_address2_predir_wouldClean;
    UNSIGNED1 orig_address2_prim_name_Invalid;
    BOOLEAN orig_address2_prim_name_wouldClean;
    UNSIGNED1 orig_address2_suffix_Invalid;
    BOOLEAN orig_address2_suffix_wouldClean;
    UNSIGNED1 orig_address2_postdir_Invalid;
    BOOLEAN orig_address2_postdir_wouldClean;
    UNSIGNED1 orig_address2_unit_desig_Invalid;
    BOOLEAN orig_address2_unit_desig_wouldClean;
    UNSIGNED1 orig_address2_sec_range_Invalid;
    BOOLEAN orig_address2_sec_range_wouldClean;
    UNSIGNED1 orig_address2_city_Invalid;
    BOOLEAN orig_address2_city_wouldClean;
    UNSIGNED1 orig_address2_st_Invalid;
    BOOLEAN orig_address2_st_wouldClean;
    UNSIGNED1 orig_address2_z5_Invalid;
    BOOLEAN orig_address2_z5_wouldClean;
    UNSIGNED1 orig_address2_z4_Invalid;
    BOOLEAN orig_address2_z4_wouldClean;
    UNSIGNED1 orig_bdid_Invalid;
    BOOLEAN orig_bdid_wouldClean;
    UNSIGNED1 orig_bdl_Invalid;
    BOOLEAN orig_bdl_wouldClean;
    UNSIGNED1 orig_did_Invalid;
    BOOLEAN orig_did_wouldClean;
    UNSIGNED1 orig_company_name_Invalid;
    BOOLEAN orig_company_name_wouldClean;
    UNSIGNED1 orig_fein_Invalid;
    BOOLEAN orig_fein_wouldClean;
    UNSIGNED1 orig_phone_Invalid;
    BOOLEAN orig_phone_wouldClean;
    UNSIGNED1 orig_work_phone_Invalid;
    BOOLEAN orig_work_phone_wouldClean;
    UNSIGNED1 orig_company_phone_Invalid;
    BOOLEAN orig_company_phone_wouldClean;
    UNSIGNED1 orig_reference_code_Invalid;
    BOOLEAN orig_reference_code_wouldClean;
    UNSIGNED1 orig_ip_address_initiated_Invalid;
    BOOLEAN orig_ip_address_initiated_wouldClean;
    UNSIGNED1 orig_ip_address_executed_Invalid;
    BOOLEAN orig_ip_address_executed_wouldClean;
    UNSIGNED1 orig_charter_number_Invalid;
    BOOLEAN orig_charter_number_wouldClean;
    UNSIGNED1 orig_ucc_original_filing_number_Invalid;
    BOOLEAN orig_ucc_original_filing_number_wouldClean;
    UNSIGNED1 orig_email_address_Invalid;
    BOOLEAN orig_email_address_wouldClean;
    UNSIGNED1 orig_domain_name_Invalid;
    BOOLEAN orig_domain_name_wouldClean;
    UNSIGNED1 orig_full_name_Invalid;
    BOOLEAN orig_full_name_wouldClean;
    UNSIGNED1 orig_dl_purpose_Invalid;
    BOOLEAN orig_dl_purpose_wouldClean;
    UNSIGNED1 orig_glb_purpose_Invalid;
    BOOLEAN orig_glb_purpose_wouldClean;
    UNSIGNED1 orig_fcra_purpose_Invalid;
    BOOLEAN orig_fcra_purpose_wouldClean;
    UNSIGNED1 orig_process_id_Invalid;
    BOOLEAN orig_process_id_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_FILE)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_FILE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_datetime_stamp_Invalid := Fields.InValid_orig_datetime_stamp((SALT39.StrType)le.orig_datetime_stamp);
    clean_orig_datetime_stamp := (TYPEOF(le.orig_datetime_stamp))Fields.Make_orig_datetime_stamp((SALT39.StrType)le.orig_datetime_stamp);
    clean_orig_datetime_stamp_Invalid := Fields.InValid_orig_datetime_stamp((SALT39.StrType)clean_orig_datetime_stamp);
    SELF.orig_datetime_stamp := IF(withOnfail, clean_orig_datetime_stamp, le.orig_datetime_stamp); // ONFAIL(CLEAN)
    SELF.orig_datetime_stamp_wouldClean := TRIM((SALT39.StrType)le.orig_datetime_stamp) <> TRIM((SALT39.StrType)clean_orig_datetime_stamp);
    SELF.orig_global_company_id_Invalid := Fields.InValid_orig_global_company_id((SALT39.StrType)le.orig_global_company_id);
    clean_orig_global_company_id := (TYPEOF(le.orig_global_company_id))Fields.Make_orig_global_company_id((SALT39.StrType)le.orig_global_company_id);
    clean_orig_global_company_id_Invalid := Fields.InValid_orig_global_company_id((SALT39.StrType)clean_orig_global_company_id);
    SELF.orig_global_company_id := IF(withOnfail, clean_orig_global_company_id, le.orig_global_company_id); // ONFAIL(CLEAN)
    SELF.orig_global_company_id_wouldClean := TRIM((SALT39.StrType)le.orig_global_company_id) <> TRIM((SALT39.StrType)clean_orig_global_company_id);
    SELF.orig_company_id_Invalid := Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id);
    clean_orig_company_id := (TYPEOF(le.orig_company_id))Fields.Make_orig_company_id((SALT39.StrType)le.orig_company_id);
    clean_orig_company_id_Invalid := Fields.InValid_orig_company_id((SALT39.StrType)clean_orig_company_id);
    SELF.orig_company_id := IF(withOnfail, clean_orig_company_id, le.orig_company_id); // ONFAIL(CLEAN)
    SELF.orig_company_id_wouldClean := TRIM((SALT39.StrType)le.orig_company_id) <> TRIM((SALT39.StrType)clean_orig_company_id);
    SELF.orig_product_cd_Invalid := Fields.InValid_orig_product_cd((SALT39.StrType)le.orig_product_cd);
    clean_orig_product_cd := (TYPEOF(le.orig_product_cd))Fields.Make_orig_product_cd((SALT39.StrType)le.orig_product_cd);
    clean_orig_product_cd_Invalid := Fields.InValid_orig_product_cd((SALT39.StrType)clean_orig_product_cd);
    SELF.orig_product_cd := IF(withOnfail, clean_orig_product_cd, le.orig_product_cd); // ONFAIL(CLEAN)
    SELF.orig_product_cd_wouldClean := TRIM((SALT39.StrType)le.orig_product_cd) <> TRIM((SALT39.StrType)clean_orig_product_cd);
    SELF.orig_method_Invalid := Fields.InValid_orig_method((SALT39.StrType)le.orig_method);
    clean_orig_method := (TYPEOF(le.orig_method))Fields.Make_orig_method((SALT39.StrType)le.orig_method);
    clean_orig_method_Invalid := Fields.InValid_orig_method((SALT39.StrType)clean_orig_method);
    SELF.orig_method := IF(withOnfail, clean_orig_method, le.orig_method); // ONFAIL(CLEAN)
    SELF.orig_method_wouldClean := TRIM((SALT39.StrType)le.orig_method) <> TRIM((SALT39.StrType)clean_orig_method);
    SELF.orig_vertical_Invalid := Fields.InValid_orig_vertical((SALT39.StrType)le.orig_vertical);
    clean_orig_vertical := (TYPEOF(le.orig_vertical))Fields.Make_orig_vertical((SALT39.StrType)le.orig_vertical);
    clean_orig_vertical_Invalid := Fields.InValid_orig_vertical((SALT39.StrType)clean_orig_vertical);
    SELF.orig_vertical := IF(withOnfail, clean_orig_vertical, le.orig_vertical); // ONFAIL(CLEAN)
    SELF.orig_vertical_wouldClean := TRIM((SALT39.StrType)le.orig_vertical) <> TRIM((SALT39.StrType)clean_orig_vertical);
    SELF.orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name := (TYPEOF(le.orig_function_name))Fields.Make_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)clean_orig_function_name);
    SELF.orig_function_name := IF(withOnfail, clean_orig_function_name, le.orig_function_name); // ONFAIL(CLEAN)
    SELF.orig_function_name_wouldClean := TRIM((SALT39.StrType)le.orig_function_name) <> TRIM((SALT39.StrType)clean_orig_function_name);
    SELF.orig_transaction_type_Invalid := Fields.InValid_orig_transaction_type((SALT39.StrType)le.orig_transaction_type);
    clean_orig_transaction_type := (TYPEOF(le.orig_transaction_type))Fields.Make_orig_transaction_type((SALT39.StrType)le.orig_transaction_type);
    clean_orig_transaction_type_Invalid := Fields.InValid_orig_transaction_type((SALT39.StrType)clean_orig_transaction_type);
    SELF.orig_transaction_type := IF(withOnfail, clean_orig_transaction_type, le.orig_transaction_type); // ONFAIL(CLEAN)
    SELF.orig_transaction_type_wouldClean := TRIM((SALT39.StrType)le.orig_transaction_type) <> TRIM((SALT39.StrType)clean_orig_transaction_type);
    SELF.orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    clean_orig_login_history_id := (TYPEOF(le.orig_login_history_id))Fields.Make_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    clean_orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)clean_orig_login_history_id);
    SELF.orig_login_history_id := IF(withOnfail, clean_orig_login_history_id, le.orig_login_history_id); // ONFAIL(CLEAN)
    SELF.orig_login_history_id_wouldClean := TRIM((SALT39.StrType)le.orig_login_history_id) <> TRIM((SALT39.StrType)clean_orig_login_history_id);
    SELF.orig_job_id_Invalid := Fields.InValid_orig_job_id((SALT39.StrType)le.orig_job_id);
    clean_orig_job_id := (TYPEOF(le.orig_job_id))Fields.Make_orig_job_id((SALT39.StrType)le.orig_job_id);
    clean_orig_job_id_Invalid := Fields.InValid_orig_job_id((SALT39.StrType)clean_orig_job_id);
    SELF.orig_job_id := IF(withOnfail, clean_orig_job_id, le.orig_job_id); // ONFAIL(CLEAN)
    SELF.orig_job_id_wouldClean := TRIM((SALT39.StrType)le.orig_job_id) <> TRIM((SALT39.StrType)clean_orig_job_id);
    SELF.orig_sequence_number_Invalid := Fields.InValid_orig_sequence_number((SALT39.StrType)le.orig_sequence_number);
    clean_orig_sequence_number := (TYPEOF(le.orig_sequence_number))Fields.Make_orig_sequence_number((SALT39.StrType)le.orig_sequence_number);
    clean_orig_sequence_number_Invalid := Fields.InValid_orig_sequence_number((SALT39.StrType)clean_orig_sequence_number);
    SELF.orig_sequence_number := IF(withOnfail, clean_orig_sequence_number, le.orig_sequence_number); // ONFAIL(CLEAN)
    SELF.orig_sequence_number_wouldClean := TRIM((SALT39.StrType)le.orig_sequence_number) <> TRIM((SALT39.StrType)clean_orig_sequence_number);
    SELF.orig_first_name_Invalid := Fields.InValid_orig_first_name((SALT39.StrType)le.orig_first_name);
    clean_orig_first_name := (TYPEOF(le.orig_first_name))Fields.Make_orig_first_name((SALT39.StrType)le.orig_first_name);
    clean_orig_first_name_Invalid := Fields.InValid_orig_first_name((SALT39.StrType)clean_orig_first_name);
    SELF.orig_first_name := IF(withOnfail, clean_orig_first_name, le.orig_first_name); // ONFAIL(CLEAN)
    SELF.orig_first_name_wouldClean := TRIM((SALT39.StrType)le.orig_first_name) <> TRIM((SALT39.StrType)clean_orig_first_name);
    SELF.orig_middle_name_Invalid := Fields.InValid_orig_middle_name((SALT39.StrType)le.orig_middle_name);
    clean_orig_middle_name := (TYPEOF(le.orig_middle_name))Fields.Make_orig_middle_name((SALT39.StrType)le.orig_middle_name);
    clean_orig_middle_name_Invalid := Fields.InValid_orig_middle_name((SALT39.StrType)clean_orig_middle_name);
    SELF.orig_middle_name := IF(withOnfail, clean_orig_middle_name, le.orig_middle_name); // ONFAIL(CLEAN)
    SELF.orig_middle_name_wouldClean := TRIM((SALT39.StrType)le.orig_middle_name) <> TRIM((SALT39.StrType)clean_orig_middle_name);
    SELF.orig_last_name_Invalid := Fields.InValid_orig_last_name((SALT39.StrType)le.orig_last_name);
    clean_orig_last_name := (TYPEOF(le.orig_last_name))Fields.Make_orig_last_name((SALT39.StrType)le.orig_last_name);
    clean_orig_last_name_Invalid := Fields.InValid_orig_last_name((SALT39.StrType)clean_orig_last_name);
    SELF.orig_last_name := IF(withOnfail, clean_orig_last_name, le.orig_last_name); // ONFAIL(CLEAN)
    SELF.orig_last_name_wouldClean := TRIM((SALT39.StrType)le.orig_last_name) <> TRIM((SALT39.StrType)clean_orig_last_name);
    SELF.orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn := (TYPEOF(le.orig_ssn))Fields.Make_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)clean_orig_ssn);
    SELF.orig_ssn := IF(withOnfail, clean_orig_ssn, le.orig_ssn); // ONFAIL(CLEAN)
    SELF.orig_ssn_wouldClean := TRIM((SALT39.StrType)le.orig_ssn) <> TRIM((SALT39.StrType)clean_orig_ssn);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob);
    clean_orig_dob := (TYPEOF(le.orig_dob))Fields.Make_orig_dob((SALT39.StrType)le.orig_dob);
    clean_orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)clean_orig_dob);
    SELF.orig_dob := IF(withOnfail, clean_orig_dob, le.orig_dob); // ONFAIL(CLEAN)
    SELF.orig_dob_wouldClean := TRIM((SALT39.StrType)le.orig_dob) <> TRIM((SALT39.StrType)clean_orig_dob);
    SELF.orig_dl_num_Invalid := Fields.InValid_orig_dl_num((SALT39.StrType)le.orig_dl_num);
    clean_orig_dl_num := (TYPEOF(le.orig_dl_num))Fields.Make_orig_dl_num((SALT39.StrType)le.orig_dl_num);
    clean_orig_dl_num_Invalid := Fields.InValid_orig_dl_num((SALT39.StrType)clean_orig_dl_num);
    SELF.orig_dl_num := IF(withOnfail, clean_orig_dl_num, le.orig_dl_num); // ONFAIL(CLEAN)
    SELF.orig_dl_num_wouldClean := TRIM((SALT39.StrType)le.orig_dl_num) <> TRIM((SALT39.StrType)clean_orig_dl_num);
    SELF.orig_dl_state_Invalid := Fields.InValid_orig_dl_state((SALT39.StrType)le.orig_dl_state);
    clean_orig_dl_state := (TYPEOF(le.orig_dl_state))Fields.Make_orig_dl_state((SALT39.StrType)le.orig_dl_state);
    clean_orig_dl_state_Invalid := Fields.InValid_orig_dl_state((SALT39.StrType)clean_orig_dl_state);
    SELF.orig_dl_state := IF(withOnfail, clean_orig_dl_state, le.orig_dl_state); // ONFAIL(CLEAN)
    SELF.orig_dl_state_wouldClean := TRIM((SALT39.StrType)le.orig_dl_state) <> TRIM((SALT39.StrType)clean_orig_dl_state);
    SELF.orig_address1_addressline1_Invalid := Fields.InValid_orig_address1_addressline1((SALT39.StrType)le.orig_address1_addressline1);
    clean_orig_address1_addressline1 := (TYPEOF(le.orig_address1_addressline1))Fields.Make_orig_address1_addressline1((SALT39.StrType)le.orig_address1_addressline1);
    clean_orig_address1_addressline1_Invalid := Fields.InValid_orig_address1_addressline1((SALT39.StrType)clean_orig_address1_addressline1);
    SELF.orig_address1_addressline1 := IF(withOnfail, clean_orig_address1_addressline1, le.orig_address1_addressline1); // ONFAIL(CLEAN)
    SELF.orig_address1_addressline1_wouldClean := TRIM((SALT39.StrType)le.orig_address1_addressline1) <> TRIM((SALT39.StrType)clean_orig_address1_addressline1);
    SELF.orig_address1_addressline2_Invalid := Fields.InValid_orig_address1_addressline2((SALT39.StrType)le.orig_address1_addressline2);
    clean_orig_address1_addressline2 := (TYPEOF(le.orig_address1_addressline2))Fields.Make_orig_address1_addressline2((SALT39.StrType)le.orig_address1_addressline2);
    clean_orig_address1_addressline2_Invalid := Fields.InValid_orig_address1_addressline2((SALT39.StrType)clean_orig_address1_addressline2);
    SELF.orig_address1_addressline2 := IF(withOnfail, clean_orig_address1_addressline2, le.orig_address1_addressline2); // ONFAIL(CLEAN)
    SELF.orig_address1_addressline2_wouldClean := TRIM((SALT39.StrType)le.orig_address1_addressline2) <> TRIM((SALT39.StrType)clean_orig_address1_addressline2);
    SELF.orig_address1_prim_range_Invalid := Fields.InValid_orig_address1_prim_range((SALT39.StrType)le.orig_address1_prim_range);
    clean_orig_address1_prim_range := (TYPEOF(le.orig_address1_prim_range))Fields.Make_orig_address1_prim_range((SALT39.StrType)le.orig_address1_prim_range);
    clean_orig_address1_prim_range_Invalid := Fields.InValid_orig_address1_prim_range((SALT39.StrType)clean_orig_address1_prim_range);
    SELF.orig_address1_prim_range := IF(withOnfail, clean_orig_address1_prim_range, le.orig_address1_prim_range); // ONFAIL(CLEAN)
    SELF.orig_address1_prim_range_wouldClean := TRIM((SALT39.StrType)le.orig_address1_prim_range) <> TRIM((SALT39.StrType)clean_orig_address1_prim_range);
    SELF.orig_address1_predir_Invalid := Fields.InValid_orig_address1_predir((SALT39.StrType)le.orig_address1_predir);
    clean_orig_address1_predir := (TYPEOF(le.orig_address1_predir))Fields.Make_orig_address1_predir((SALT39.StrType)le.orig_address1_predir);
    clean_orig_address1_predir_Invalid := Fields.InValid_orig_address1_predir((SALT39.StrType)clean_orig_address1_predir);
    SELF.orig_address1_predir := IF(withOnfail, clean_orig_address1_predir, le.orig_address1_predir); // ONFAIL(CLEAN)
    SELF.orig_address1_predir_wouldClean := TRIM((SALT39.StrType)le.orig_address1_predir) <> TRIM((SALT39.StrType)clean_orig_address1_predir);
    SELF.orig_address1_prim_name_Invalid := Fields.InValid_orig_address1_prim_name((SALT39.StrType)le.orig_address1_prim_name);
    clean_orig_address1_prim_name := (TYPEOF(le.orig_address1_prim_name))Fields.Make_orig_address1_prim_name((SALT39.StrType)le.orig_address1_prim_name);
    clean_orig_address1_prim_name_Invalid := Fields.InValid_orig_address1_prim_name((SALT39.StrType)clean_orig_address1_prim_name);
    SELF.orig_address1_prim_name := IF(withOnfail, clean_orig_address1_prim_name, le.orig_address1_prim_name); // ONFAIL(CLEAN)
    SELF.orig_address1_prim_name_wouldClean := TRIM((SALT39.StrType)le.orig_address1_prim_name) <> TRIM((SALT39.StrType)clean_orig_address1_prim_name);
    SELF.orig_address1_suffix_Invalid := Fields.InValid_orig_address1_suffix((SALT39.StrType)le.orig_address1_suffix);
    clean_orig_address1_suffix := (TYPEOF(le.orig_address1_suffix))Fields.Make_orig_address1_suffix((SALT39.StrType)le.orig_address1_suffix);
    clean_orig_address1_suffix_Invalid := Fields.InValid_orig_address1_suffix((SALT39.StrType)clean_orig_address1_suffix);
    SELF.orig_address1_suffix := IF(withOnfail, clean_orig_address1_suffix, le.orig_address1_suffix); // ONFAIL(CLEAN)
    SELF.orig_address1_suffix_wouldClean := TRIM((SALT39.StrType)le.orig_address1_suffix) <> TRIM((SALT39.StrType)clean_orig_address1_suffix);
    SELF.orig_address1_postdir_Invalid := Fields.InValid_orig_address1_postdir((SALT39.StrType)le.orig_address1_postdir);
    clean_orig_address1_postdir := (TYPEOF(le.orig_address1_postdir))Fields.Make_orig_address1_postdir((SALT39.StrType)le.orig_address1_postdir);
    clean_orig_address1_postdir_Invalid := Fields.InValid_orig_address1_postdir((SALT39.StrType)clean_orig_address1_postdir);
    SELF.orig_address1_postdir := IF(withOnfail, clean_orig_address1_postdir, le.orig_address1_postdir); // ONFAIL(CLEAN)
    SELF.orig_address1_postdir_wouldClean := TRIM((SALT39.StrType)le.orig_address1_postdir) <> TRIM((SALT39.StrType)clean_orig_address1_postdir);
    SELF.orig_address1_unit_desig_Invalid := Fields.InValid_orig_address1_unit_desig((SALT39.StrType)le.orig_address1_unit_desig);
    clean_orig_address1_unit_desig := (TYPEOF(le.orig_address1_unit_desig))Fields.Make_orig_address1_unit_desig((SALT39.StrType)le.orig_address1_unit_desig);
    clean_orig_address1_unit_desig_Invalid := Fields.InValid_orig_address1_unit_desig((SALT39.StrType)clean_orig_address1_unit_desig);
    SELF.orig_address1_unit_desig := IF(withOnfail, clean_orig_address1_unit_desig, le.orig_address1_unit_desig); // ONFAIL(CLEAN)
    SELF.orig_address1_unit_desig_wouldClean := TRIM((SALT39.StrType)le.orig_address1_unit_desig) <> TRIM((SALT39.StrType)clean_orig_address1_unit_desig);
    SELF.orig_address1_sec_range_Invalid := Fields.InValid_orig_address1_sec_range((SALT39.StrType)le.orig_address1_sec_range);
    clean_orig_address1_sec_range := (TYPEOF(le.orig_address1_sec_range))Fields.Make_orig_address1_sec_range((SALT39.StrType)le.orig_address1_sec_range);
    clean_orig_address1_sec_range_Invalid := Fields.InValid_orig_address1_sec_range((SALT39.StrType)clean_orig_address1_sec_range);
    SELF.orig_address1_sec_range := IF(withOnfail, clean_orig_address1_sec_range, le.orig_address1_sec_range); // ONFAIL(CLEAN)
    SELF.orig_address1_sec_range_wouldClean := TRIM((SALT39.StrType)le.orig_address1_sec_range) <> TRIM((SALT39.StrType)clean_orig_address1_sec_range);
    SELF.orig_address1_city_Invalid := Fields.InValid_orig_address1_city((SALT39.StrType)le.orig_address1_city);
    clean_orig_address1_city := (TYPEOF(le.orig_address1_city))Fields.Make_orig_address1_city((SALT39.StrType)le.orig_address1_city);
    clean_orig_address1_city_Invalid := Fields.InValid_orig_address1_city((SALT39.StrType)clean_orig_address1_city);
    SELF.orig_address1_city := IF(withOnfail, clean_orig_address1_city, le.orig_address1_city); // ONFAIL(CLEAN)
    SELF.orig_address1_city_wouldClean := TRIM((SALT39.StrType)le.orig_address1_city) <> TRIM((SALT39.StrType)clean_orig_address1_city);
    SELF.orig_address1_st_Invalid := Fields.InValid_orig_address1_st((SALT39.StrType)le.orig_address1_st);
    clean_orig_address1_st := (TYPEOF(le.orig_address1_st))Fields.Make_orig_address1_st((SALT39.StrType)le.orig_address1_st);
    clean_orig_address1_st_Invalid := Fields.InValid_orig_address1_st((SALT39.StrType)clean_orig_address1_st);
    SELF.orig_address1_st := IF(withOnfail, clean_orig_address1_st, le.orig_address1_st); // ONFAIL(CLEAN)
    SELF.orig_address1_st_wouldClean := TRIM((SALT39.StrType)le.orig_address1_st) <> TRIM((SALT39.StrType)clean_orig_address1_st);
    SELF.orig_address1_z5_Invalid := Fields.InValid_orig_address1_z5((SALT39.StrType)le.orig_address1_z5);
    clean_orig_address1_z5 := (TYPEOF(le.orig_address1_z5))Fields.Make_orig_address1_z5((SALT39.StrType)le.orig_address1_z5);
    clean_orig_address1_z5_Invalid := Fields.InValid_orig_address1_z5((SALT39.StrType)clean_orig_address1_z5);
    SELF.orig_address1_z5 := IF(withOnfail, clean_orig_address1_z5, le.orig_address1_z5); // ONFAIL(CLEAN)
    SELF.orig_address1_z5_wouldClean := TRIM((SALT39.StrType)le.orig_address1_z5) <> TRIM((SALT39.StrType)clean_orig_address1_z5);
    SELF.orig_address1_z4_Invalid := Fields.InValid_orig_address1_z4((SALT39.StrType)le.orig_address1_z4);
    clean_orig_address1_z4 := (TYPEOF(le.orig_address1_z4))Fields.Make_orig_address1_z4((SALT39.StrType)le.orig_address1_z4);
    clean_orig_address1_z4_Invalid := Fields.InValid_orig_address1_z4((SALT39.StrType)clean_orig_address1_z4);
    SELF.orig_address1_z4 := IF(withOnfail, clean_orig_address1_z4, le.orig_address1_z4); // ONFAIL(CLEAN)
    SELF.orig_address1_z4_wouldClean := TRIM((SALT39.StrType)le.orig_address1_z4) <> TRIM((SALT39.StrType)clean_orig_address1_z4);
    SELF.orig_address2_addressline1_Invalid := Fields.InValid_orig_address2_addressline1((SALT39.StrType)le.orig_address2_addressline1);
    clean_orig_address2_addressline1 := (TYPEOF(le.orig_address2_addressline1))Fields.Make_orig_address2_addressline1((SALT39.StrType)le.orig_address2_addressline1);
    clean_orig_address2_addressline1_Invalid := Fields.InValid_orig_address2_addressline1((SALT39.StrType)clean_orig_address2_addressline1);
    SELF.orig_address2_addressline1 := IF(withOnfail, clean_orig_address2_addressline1, le.orig_address2_addressline1); // ONFAIL(CLEAN)
    SELF.orig_address2_addressline1_wouldClean := TRIM((SALT39.StrType)le.orig_address2_addressline1) <> TRIM((SALT39.StrType)clean_orig_address2_addressline1);
    SELF.orig_address2_addressline2_Invalid := Fields.InValid_orig_address2_addressline2((SALT39.StrType)le.orig_address2_addressline2);
    clean_orig_address2_addressline2 := (TYPEOF(le.orig_address2_addressline2))Fields.Make_orig_address2_addressline2((SALT39.StrType)le.orig_address2_addressline2);
    clean_orig_address2_addressline2_Invalid := Fields.InValid_orig_address2_addressline2((SALT39.StrType)clean_orig_address2_addressline2);
    SELF.orig_address2_addressline2 := IF(withOnfail, clean_orig_address2_addressline2, le.orig_address2_addressline2); // ONFAIL(CLEAN)
    SELF.orig_address2_addressline2_wouldClean := TRIM((SALT39.StrType)le.orig_address2_addressline2) <> TRIM((SALT39.StrType)clean_orig_address2_addressline2);
    SELF.orig_address2_prim_range_Invalid := Fields.InValid_orig_address2_prim_range((SALT39.StrType)le.orig_address2_prim_range);
    clean_orig_address2_prim_range := (TYPEOF(le.orig_address2_prim_range))Fields.Make_orig_address2_prim_range((SALT39.StrType)le.orig_address2_prim_range);
    clean_orig_address2_prim_range_Invalid := Fields.InValid_orig_address2_prim_range((SALT39.StrType)clean_orig_address2_prim_range);
    SELF.orig_address2_prim_range := IF(withOnfail, clean_orig_address2_prim_range, le.orig_address2_prim_range); // ONFAIL(CLEAN)
    SELF.orig_address2_prim_range_wouldClean := TRIM((SALT39.StrType)le.orig_address2_prim_range) <> TRIM((SALT39.StrType)clean_orig_address2_prim_range);
    SELF.orig_address2_predir_Invalid := Fields.InValid_orig_address2_predir((SALT39.StrType)le.orig_address2_predir);
    clean_orig_address2_predir := (TYPEOF(le.orig_address2_predir))Fields.Make_orig_address2_predir((SALT39.StrType)le.orig_address2_predir);
    clean_orig_address2_predir_Invalid := Fields.InValid_orig_address2_predir((SALT39.StrType)clean_orig_address2_predir);
    SELF.orig_address2_predir := IF(withOnfail, clean_orig_address2_predir, le.orig_address2_predir); // ONFAIL(CLEAN)
    SELF.orig_address2_predir_wouldClean := TRIM((SALT39.StrType)le.orig_address2_predir) <> TRIM((SALT39.StrType)clean_orig_address2_predir);
    SELF.orig_address2_prim_name_Invalid := Fields.InValid_orig_address2_prim_name((SALT39.StrType)le.orig_address2_prim_name);
    clean_orig_address2_prim_name := (TYPEOF(le.orig_address2_prim_name))Fields.Make_orig_address2_prim_name((SALT39.StrType)le.orig_address2_prim_name);
    clean_orig_address2_prim_name_Invalid := Fields.InValid_orig_address2_prim_name((SALT39.StrType)clean_orig_address2_prim_name);
    SELF.orig_address2_prim_name := IF(withOnfail, clean_orig_address2_prim_name, le.orig_address2_prim_name); // ONFAIL(CLEAN)
    SELF.orig_address2_prim_name_wouldClean := TRIM((SALT39.StrType)le.orig_address2_prim_name) <> TRIM((SALT39.StrType)clean_orig_address2_prim_name);
    SELF.orig_address2_suffix_Invalid := Fields.InValid_orig_address2_suffix((SALT39.StrType)le.orig_address2_suffix);
    clean_orig_address2_suffix := (TYPEOF(le.orig_address2_suffix))Fields.Make_orig_address2_suffix((SALT39.StrType)le.orig_address2_suffix);
    clean_orig_address2_suffix_Invalid := Fields.InValid_orig_address2_suffix((SALT39.StrType)clean_orig_address2_suffix);
    SELF.orig_address2_suffix := IF(withOnfail, clean_orig_address2_suffix, le.orig_address2_suffix); // ONFAIL(CLEAN)
    SELF.orig_address2_suffix_wouldClean := TRIM((SALT39.StrType)le.orig_address2_suffix) <> TRIM((SALT39.StrType)clean_orig_address2_suffix);
    SELF.orig_address2_postdir_Invalid := Fields.InValid_orig_address2_postdir((SALT39.StrType)le.orig_address2_postdir);
    clean_orig_address2_postdir := (TYPEOF(le.orig_address2_postdir))Fields.Make_orig_address2_postdir((SALT39.StrType)le.orig_address2_postdir);
    clean_orig_address2_postdir_Invalid := Fields.InValid_orig_address2_postdir((SALT39.StrType)clean_orig_address2_postdir);
    SELF.orig_address2_postdir := IF(withOnfail, clean_orig_address2_postdir, le.orig_address2_postdir); // ONFAIL(CLEAN)
    SELF.orig_address2_postdir_wouldClean := TRIM((SALT39.StrType)le.orig_address2_postdir) <> TRIM((SALT39.StrType)clean_orig_address2_postdir);
    SELF.orig_address2_unit_desig_Invalid := Fields.InValid_orig_address2_unit_desig((SALT39.StrType)le.orig_address2_unit_desig);
    clean_orig_address2_unit_desig := (TYPEOF(le.orig_address2_unit_desig))Fields.Make_orig_address2_unit_desig((SALT39.StrType)le.orig_address2_unit_desig);
    clean_orig_address2_unit_desig_Invalid := Fields.InValid_orig_address2_unit_desig((SALT39.StrType)clean_orig_address2_unit_desig);
    SELF.orig_address2_unit_desig := IF(withOnfail, clean_orig_address2_unit_desig, le.orig_address2_unit_desig); // ONFAIL(CLEAN)
    SELF.orig_address2_unit_desig_wouldClean := TRIM((SALT39.StrType)le.orig_address2_unit_desig) <> TRIM((SALT39.StrType)clean_orig_address2_unit_desig);
    SELF.orig_address2_sec_range_Invalid := Fields.InValid_orig_address2_sec_range((SALT39.StrType)le.orig_address2_sec_range);
    clean_orig_address2_sec_range := (TYPEOF(le.orig_address2_sec_range))Fields.Make_orig_address2_sec_range((SALT39.StrType)le.orig_address2_sec_range);
    clean_orig_address2_sec_range_Invalid := Fields.InValid_orig_address2_sec_range((SALT39.StrType)clean_orig_address2_sec_range);
    SELF.orig_address2_sec_range := IF(withOnfail, clean_orig_address2_sec_range, le.orig_address2_sec_range); // ONFAIL(CLEAN)
    SELF.orig_address2_sec_range_wouldClean := TRIM((SALT39.StrType)le.orig_address2_sec_range) <> TRIM((SALT39.StrType)clean_orig_address2_sec_range);
    SELF.orig_address2_city_Invalid := Fields.InValid_orig_address2_city((SALT39.StrType)le.orig_address2_city);
    clean_orig_address2_city := (TYPEOF(le.orig_address2_city))Fields.Make_orig_address2_city((SALT39.StrType)le.orig_address2_city);
    clean_orig_address2_city_Invalid := Fields.InValid_orig_address2_city((SALT39.StrType)clean_orig_address2_city);
    SELF.orig_address2_city := IF(withOnfail, clean_orig_address2_city, le.orig_address2_city); // ONFAIL(CLEAN)
    SELF.orig_address2_city_wouldClean := TRIM((SALT39.StrType)le.orig_address2_city) <> TRIM((SALT39.StrType)clean_orig_address2_city);
    SELF.orig_address2_st_Invalid := Fields.InValid_orig_address2_st((SALT39.StrType)le.orig_address2_st);
    clean_orig_address2_st := (TYPEOF(le.orig_address2_st))Fields.Make_orig_address2_st((SALT39.StrType)le.orig_address2_st);
    clean_orig_address2_st_Invalid := Fields.InValid_orig_address2_st((SALT39.StrType)clean_orig_address2_st);
    SELF.orig_address2_st := IF(withOnfail, clean_orig_address2_st, le.orig_address2_st); // ONFAIL(CLEAN)
    SELF.orig_address2_st_wouldClean := TRIM((SALT39.StrType)le.orig_address2_st) <> TRIM((SALT39.StrType)clean_orig_address2_st);
    SELF.orig_address2_z5_Invalid := Fields.InValid_orig_address2_z5((SALT39.StrType)le.orig_address2_z5);
    clean_orig_address2_z5 := (TYPEOF(le.orig_address2_z5))Fields.Make_orig_address2_z5((SALT39.StrType)le.orig_address2_z5);
    clean_orig_address2_z5_Invalid := Fields.InValid_orig_address2_z5((SALT39.StrType)clean_orig_address2_z5);
    SELF.orig_address2_z5 := IF(withOnfail, clean_orig_address2_z5, le.orig_address2_z5); // ONFAIL(CLEAN)
    SELF.orig_address2_z5_wouldClean := TRIM((SALT39.StrType)le.orig_address2_z5) <> TRIM((SALT39.StrType)clean_orig_address2_z5);
    SELF.orig_address2_z4_Invalid := Fields.InValid_orig_address2_z4((SALT39.StrType)le.orig_address2_z4);
    clean_orig_address2_z4 := (TYPEOF(le.orig_address2_z4))Fields.Make_orig_address2_z4((SALT39.StrType)le.orig_address2_z4);
    clean_orig_address2_z4_Invalid := Fields.InValid_orig_address2_z4((SALT39.StrType)clean_orig_address2_z4);
    SELF.orig_address2_z4 := IF(withOnfail, clean_orig_address2_z4, le.orig_address2_z4); // ONFAIL(CLEAN)
    SELF.orig_address2_z4_wouldClean := TRIM((SALT39.StrType)le.orig_address2_z4) <> TRIM((SALT39.StrType)clean_orig_address2_z4);
    SELF.orig_bdid_Invalid := Fields.InValid_orig_bdid((SALT39.StrType)le.orig_bdid);
    clean_orig_bdid := (TYPEOF(le.orig_bdid))Fields.Make_orig_bdid((SALT39.StrType)le.orig_bdid);
    clean_orig_bdid_Invalid := Fields.InValid_orig_bdid((SALT39.StrType)clean_orig_bdid);
    SELF.orig_bdid := IF(withOnfail, clean_orig_bdid, le.orig_bdid); // ONFAIL(CLEAN)
    SELF.orig_bdid_wouldClean := TRIM((SALT39.StrType)le.orig_bdid) <> TRIM((SALT39.StrType)clean_orig_bdid);
    SELF.orig_bdl_Invalid := Fields.InValid_orig_bdl((SALT39.StrType)le.orig_bdl);
    clean_orig_bdl := (TYPEOF(le.orig_bdl))Fields.Make_orig_bdl((SALT39.StrType)le.orig_bdl);
    clean_orig_bdl_Invalid := Fields.InValid_orig_bdl((SALT39.StrType)clean_orig_bdl);
    SELF.orig_bdl := IF(withOnfail, clean_orig_bdl, le.orig_bdl); // ONFAIL(CLEAN)
    SELF.orig_bdl_wouldClean := TRIM((SALT39.StrType)le.orig_bdl) <> TRIM((SALT39.StrType)clean_orig_bdl);
    SELF.orig_did_Invalid := Fields.InValid_orig_did((SALT39.StrType)le.orig_did);
    clean_orig_did := (TYPEOF(le.orig_did))Fields.Make_orig_did((SALT39.StrType)le.orig_did);
    clean_orig_did_Invalid := Fields.InValid_orig_did((SALT39.StrType)clean_orig_did);
    SELF.orig_did := IF(withOnfail, clean_orig_did, le.orig_did); // ONFAIL(CLEAN)
    SELF.orig_did_wouldClean := TRIM((SALT39.StrType)le.orig_did) <> TRIM((SALT39.StrType)clean_orig_did);
    SELF.orig_company_name_Invalid := Fields.InValid_orig_company_name((SALT39.StrType)le.orig_company_name);
    clean_orig_company_name := (TYPEOF(le.orig_company_name))Fields.Make_orig_company_name((SALT39.StrType)le.orig_company_name);
    clean_orig_company_name_Invalid := Fields.InValid_orig_company_name((SALT39.StrType)clean_orig_company_name);
    SELF.orig_company_name := IF(withOnfail, clean_orig_company_name, le.orig_company_name); // ONFAIL(CLEAN)
    SELF.orig_company_name_wouldClean := TRIM((SALT39.StrType)le.orig_company_name) <> TRIM((SALT39.StrType)clean_orig_company_name);
    SELF.orig_fein_Invalid := Fields.InValid_orig_fein((SALT39.StrType)le.orig_fein);
    clean_orig_fein := (TYPEOF(le.orig_fein))Fields.Make_orig_fein((SALT39.StrType)le.orig_fein);
    clean_orig_fein_Invalid := Fields.InValid_orig_fein((SALT39.StrType)clean_orig_fein);
    SELF.orig_fein := IF(withOnfail, clean_orig_fein, le.orig_fein); // ONFAIL(CLEAN)
    SELF.orig_fein_wouldClean := TRIM((SALT39.StrType)le.orig_fein) <> TRIM((SALT39.StrType)clean_orig_fein);
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone := (TYPEOF(le.orig_phone))Fields.Make_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)clean_orig_phone);
    SELF.orig_phone := IF(withOnfail, clean_orig_phone, le.orig_phone); // ONFAIL(CLEAN)
    SELF.orig_phone_wouldClean := TRIM((SALT39.StrType)le.orig_phone) <> TRIM((SALT39.StrType)clean_orig_phone);
    SELF.orig_work_phone_Invalid := Fields.InValid_orig_work_phone((SALT39.StrType)le.orig_work_phone);
    clean_orig_work_phone := (TYPEOF(le.orig_work_phone))Fields.Make_orig_work_phone((SALT39.StrType)le.orig_work_phone);
    clean_orig_work_phone_Invalid := Fields.InValid_orig_work_phone((SALT39.StrType)clean_orig_work_phone);
    SELF.orig_work_phone := IF(withOnfail, clean_orig_work_phone, le.orig_work_phone); // ONFAIL(CLEAN)
    SELF.orig_work_phone_wouldClean := TRIM((SALT39.StrType)le.orig_work_phone) <> TRIM((SALT39.StrType)clean_orig_work_phone);
    SELF.orig_company_phone_Invalid := Fields.InValid_orig_company_phone((SALT39.StrType)le.orig_company_phone);
    clean_orig_company_phone := (TYPEOF(le.orig_company_phone))Fields.Make_orig_company_phone((SALT39.StrType)le.orig_company_phone);
    clean_orig_company_phone_Invalid := Fields.InValid_orig_company_phone((SALT39.StrType)clean_orig_company_phone);
    SELF.orig_company_phone := IF(withOnfail, clean_orig_company_phone, le.orig_company_phone); // ONFAIL(CLEAN)
    SELF.orig_company_phone_wouldClean := TRIM((SALT39.StrType)le.orig_company_phone) <> TRIM((SALT39.StrType)clean_orig_company_phone);
    SELF.orig_reference_code_Invalid := Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code);
    clean_orig_reference_code := (TYPEOF(le.orig_reference_code))Fields.Make_orig_reference_code((SALT39.StrType)le.orig_reference_code);
    clean_orig_reference_code_Invalid := Fields.InValid_orig_reference_code((SALT39.StrType)clean_orig_reference_code);
    SELF.orig_reference_code := IF(withOnfail, clean_orig_reference_code, le.orig_reference_code); // ONFAIL(CLEAN)
    SELF.orig_reference_code_wouldClean := TRIM((SALT39.StrType)le.orig_reference_code) <> TRIM((SALT39.StrType)clean_orig_reference_code);
    SELF.orig_ip_address_initiated_Invalid := Fields.InValid_orig_ip_address_initiated((SALT39.StrType)le.orig_ip_address_initiated);
    clean_orig_ip_address_initiated := (TYPEOF(le.orig_ip_address_initiated))Fields.Make_orig_ip_address_initiated((SALT39.StrType)le.orig_ip_address_initiated);
    clean_orig_ip_address_initiated_Invalid := Fields.InValid_orig_ip_address_initiated((SALT39.StrType)clean_orig_ip_address_initiated);
    SELF.orig_ip_address_initiated := IF(withOnfail, clean_orig_ip_address_initiated, le.orig_ip_address_initiated); // ONFAIL(CLEAN)
    SELF.orig_ip_address_initiated_wouldClean := TRIM((SALT39.StrType)le.orig_ip_address_initiated) <> TRIM((SALT39.StrType)clean_orig_ip_address_initiated);
    SELF.orig_ip_address_executed_Invalid := Fields.InValid_orig_ip_address_executed((SALT39.StrType)le.orig_ip_address_executed);
    clean_orig_ip_address_executed := (TYPEOF(le.orig_ip_address_executed))Fields.Make_orig_ip_address_executed((SALT39.StrType)le.orig_ip_address_executed);
    clean_orig_ip_address_executed_Invalid := Fields.InValid_orig_ip_address_executed((SALT39.StrType)clean_orig_ip_address_executed);
    SELF.orig_ip_address_executed := IF(withOnfail, clean_orig_ip_address_executed, le.orig_ip_address_executed); // ONFAIL(CLEAN)
    SELF.orig_ip_address_executed_wouldClean := TRIM((SALT39.StrType)le.orig_ip_address_executed) <> TRIM((SALT39.StrType)clean_orig_ip_address_executed);
    SELF.orig_charter_number_Invalid := Fields.InValid_orig_charter_number((SALT39.StrType)le.orig_charter_number);
    clean_orig_charter_number := (TYPEOF(le.orig_charter_number))Fields.Make_orig_charter_number((SALT39.StrType)le.orig_charter_number);
    clean_orig_charter_number_Invalid := Fields.InValid_orig_charter_number((SALT39.StrType)clean_orig_charter_number);
    SELF.orig_charter_number := IF(withOnfail, clean_orig_charter_number, le.orig_charter_number); // ONFAIL(CLEAN)
    SELF.orig_charter_number_wouldClean := TRIM((SALT39.StrType)le.orig_charter_number) <> TRIM((SALT39.StrType)clean_orig_charter_number);
    SELF.orig_ucc_original_filing_number_Invalid := Fields.InValid_orig_ucc_original_filing_number((SALT39.StrType)le.orig_ucc_original_filing_number);
    clean_orig_ucc_original_filing_number := (TYPEOF(le.orig_ucc_original_filing_number))Fields.Make_orig_ucc_original_filing_number((SALT39.StrType)le.orig_ucc_original_filing_number);
    clean_orig_ucc_original_filing_number_Invalid := Fields.InValid_orig_ucc_original_filing_number((SALT39.StrType)clean_orig_ucc_original_filing_number);
    SELF.orig_ucc_original_filing_number := IF(withOnfail, clean_orig_ucc_original_filing_number, le.orig_ucc_original_filing_number); // ONFAIL(CLEAN)
    SELF.orig_ucc_original_filing_number_wouldClean := TRIM((SALT39.StrType)le.orig_ucc_original_filing_number) <> TRIM((SALT39.StrType)clean_orig_ucc_original_filing_number);
    SELF.orig_email_address_Invalid := Fields.InValid_orig_email_address((SALT39.StrType)le.orig_email_address);
    clean_orig_email_address := (TYPEOF(le.orig_email_address))Fields.Make_orig_email_address((SALT39.StrType)le.orig_email_address);
    clean_orig_email_address_Invalid := Fields.InValid_orig_email_address((SALT39.StrType)clean_orig_email_address);
    SELF.orig_email_address := IF(withOnfail, clean_orig_email_address, le.orig_email_address); // ONFAIL(CLEAN)
    SELF.orig_email_address_wouldClean := TRIM((SALT39.StrType)le.orig_email_address) <> TRIM((SALT39.StrType)clean_orig_email_address);
    SELF.orig_domain_name_Invalid := Fields.InValid_orig_domain_name((SALT39.StrType)le.orig_domain_name);
    clean_orig_domain_name := (TYPEOF(le.orig_domain_name))Fields.Make_orig_domain_name((SALT39.StrType)le.orig_domain_name);
    clean_orig_domain_name_Invalid := Fields.InValid_orig_domain_name((SALT39.StrType)clean_orig_domain_name);
    SELF.orig_domain_name := IF(withOnfail, clean_orig_domain_name, le.orig_domain_name); // ONFAIL(CLEAN)
    SELF.orig_domain_name_wouldClean := TRIM((SALT39.StrType)le.orig_domain_name) <> TRIM((SALT39.StrType)clean_orig_domain_name);
    SELF.orig_full_name_Invalid := Fields.InValid_orig_full_name((SALT39.StrType)le.orig_full_name);
    clean_orig_full_name := (TYPEOF(le.orig_full_name))Fields.Make_orig_full_name((SALT39.StrType)le.orig_full_name);
    clean_orig_full_name_Invalid := Fields.InValid_orig_full_name((SALT39.StrType)clean_orig_full_name);
    SELF.orig_full_name := IF(withOnfail, clean_orig_full_name, le.orig_full_name); // ONFAIL(CLEAN)
    SELF.orig_full_name_wouldClean := TRIM((SALT39.StrType)le.orig_full_name) <> TRIM((SALT39.StrType)clean_orig_full_name);
    SELF.orig_dl_purpose_Invalid := Fields.InValid_orig_dl_purpose((SALT39.StrType)le.orig_dl_purpose);
    clean_orig_dl_purpose := (TYPEOF(le.orig_dl_purpose))Fields.Make_orig_dl_purpose((SALT39.StrType)le.orig_dl_purpose);
    clean_orig_dl_purpose_Invalid := Fields.InValid_orig_dl_purpose((SALT39.StrType)clean_orig_dl_purpose);
    SELF.orig_dl_purpose := IF(withOnfail, clean_orig_dl_purpose, le.orig_dl_purpose); // ONFAIL(CLEAN)
    SELF.orig_dl_purpose_wouldClean := TRIM((SALT39.StrType)le.orig_dl_purpose) <> TRIM((SALT39.StrType)clean_orig_dl_purpose);
    SELF.orig_glb_purpose_Invalid := Fields.InValid_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose);
    clean_orig_glb_purpose := (TYPEOF(le.orig_glb_purpose))Fields.Make_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose);
    clean_orig_glb_purpose_Invalid := Fields.InValid_orig_glb_purpose((SALT39.StrType)clean_orig_glb_purpose);
    SELF.orig_glb_purpose := IF(withOnfail, clean_orig_glb_purpose, le.orig_glb_purpose); // ONFAIL(CLEAN)
    SELF.orig_glb_purpose_wouldClean := TRIM((SALT39.StrType)le.orig_glb_purpose) <> TRIM((SALT39.StrType)clean_orig_glb_purpose);
    SELF.orig_fcra_purpose_Invalid := Fields.InValid_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose);
    clean_orig_fcra_purpose := (TYPEOF(le.orig_fcra_purpose))Fields.Make_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose);
    clean_orig_fcra_purpose_Invalid := Fields.InValid_orig_fcra_purpose((SALT39.StrType)clean_orig_fcra_purpose);
    SELF.orig_fcra_purpose := IF(withOnfail, clean_orig_fcra_purpose, le.orig_fcra_purpose); // ONFAIL(CLEAN)
    SELF.orig_fcra_purpose_wouldClean := TRIM((SALT39.StrType)le.orig_fcra_purpose) <> TRIM((SALT39.StrType)clean_orig_fcra_purpose);
    SELF.orig_process_id_Invalid := Fields.InValid_orig_process_id((SALT39.StrType)le.orig_process_id);
    clean_orig_process_id := (TYPEOF(le.orig_process_id))Fields.Make_orig_process_id((SALT39.StrType)le.orig_process_id);
    clean_orig_process_id_Invalid := Fields.InValid_orig_process_id((SALT39.StrType)clean_orig_process_id);
    SELF.orig_process_id := IF(withOnfail, clean_orig_process_id, le.orig_process_id); // ONFAIL(CLEAN)
    SELF.orig_process_id_wouldClean := TRIM((SALT39.StrType)le.orig_process_id) <> TRIM((SALT39.StrType)clean_orig_process_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_FILE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_datetime_stamp_Invalid << 0 ) + ( le.orig_global_company_id_Invalid << 2 ) + ( le.orig_company_id_Invalid << 4 ) + ( le.orig_product_cd_Invalid << 6 ) + ( le.orig_method_Invalid << 9 ) + ( le.orig_vertical_Invalid << 12 ) + ( le.orig_function_name_Invalid << 15 ) + ( le.orig_transaction_type_Invalid << 17 ) + ( le.orig_login_history_id_Invalid << 20 ) + ( le.orig_job_id_Invalid << 23 ) + ( le.orig_sequence_number_Invalid << 25 ) + ( le.orig_first_name_Invalid << 27 ) + ( le.orig_middle_name_Invalid << 29 ) + ( le.orig_last_name_Invalid << 31 ) + ( le.orig_ssn_Invalid << 33 ) + ( le.orig_dob_Invalid << 36 ) + ( le.orig_dl_num_Invalid << 39 ) + ( le.orig_dl_state_Invalid << 42 ) + ( le.orig_address1_addressline1_Invalid << 45 ) + ( le.orig_address1_addressline2_Invalid << 46 ) + ( le.orig_address1_prim_range_Invalid << 48 ) + ( le.orig_address1_predir_Invalid << 50 ) + ( le.orig_address1_prim_name_Invalid << 53 ) + ( le.orig_address1_suffix_Invalid << 54 ) + ( le.orig_address1_postdir_Invalid << 56 ) + ( le.orig_address1_unit_desig_Invalid << 58 ) + ( le.orig_address1_sec_range_Invalid << 60 ) + ( le.orig_address1_city_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.orig_address1_st_Invalid << 0 ) + ( le.orig_address1_z5_Invalid << 3 ) + ( le.orig_address1_z4_Invalid << 6 ) + ( le.orig_address2_addressline1_Invalid << 9 ) + ( le.orig_address2_addressline2_Invalid << 12 ) + ( le.orig_address2_prim_range_Invalid << 15 ) + ( le.orig_address2_predir_Invalid << 18 ) + ( le.orig_address2_prim_name_Invalid << 21 ) + ( le.orig_address2_suffix_Invalid << 24 ) + ( le.orig_address2_postdir_Invalid << 27 ) + ( le.orig_address2_unit_desig_Invalid << 30 ) + ( le.orig_address2_sec_range_Invalid << 33 ) + ( le.orig_address2_city_Invalid << 36 ) + ( le.orig_address2_st_Invalid << 39 ) + ( le.orig_address2_z5_Invalid << 42 ) + ( le.orig_address2_z4_Invalid << 45 ) + ( le.orig_bdid_Invalid << 48 ) + ( le.orig_bdl_Invalid << 51 ) + ( le.orig_did_Invalid << 54 ) + ( le.orig_company_name_Invalid << 57 ) + ( le.orig_fein_Invalid << 60 );
    SELF.ScrubsBits3 := ( le.orig_phone_Invalid << 0 ) + ( le.orig_work_phone_Invalid << 3 ) + ( le.orig_company_phone_Invalid << 6 ) + ( le.orig_reference_code_Invalid << 9 ) + ( le.orig_ip_address_initiated_Invalid << 12 ) + ( le.orig_ip_address_executed_Invalid << 15 ) + ( le.orig_charter_number_Invalid << 17 ) + ( le.orig_ucc_original_filing_number_Invalid << 20 ) + ( le.orig_email_address_Invalid << 23 ) + ( le.orig_domain_name_Invalid << 26 ) + ( le.orig_full_name_Invalid << 29 ) + ( le.orig_dl_purpose_Invalid << 32 ) + ( le.orig_glb_purpose_Invalid << 35 ) + ( le.orig_fcra_purpose_Invalid << 38 ) + ( le.orig_process_id_Invalid << 41 );
    SELF.ScrubsCleanBits1 := ( IF(le.orig_datetime_stamp_wouldClean, 1, 0) << 0 ) + ( IF(le.orig_global_company_id_wouldClean, 1, 0) << 1 ) + ( IF(le.orig_company_id_wouldClean, 1, 0) << 2 ) + ( IF(le.orig_product_cd_wouldClean, 1, 0) << 3 ) + ( IF(le.orig_method_wouldClean, 1, 0) << 4 ) + ( IF(le.orig_vertical_wouldClean, 1, 0) << 5 ) + ( IF(le.orig_function_name_wouldClean, 1, 0) << 6 ) + ( IF(le.orig_transaction_type_wouldClean, 1, 0) << 7 ) + ( IF(le.orig_login_history_id_wouldClean, 1, 0) << 8 ) + ( IF(le.orig_job_id_wouldClean, 1, 0) << 9 ) + ( IF(le.orig_sequence_number_wouldClean, 1, 0) << 10 ) + ( IF(le.orig_first_name_wouldClean, 1, 0) << 11 ) + ( IF(le.orig_middle_name_wouldClean, 1, 0) << 12 ) + ( IF(le.orig_last_name_wouldClean, 1, 0) << 13 ) + ( IF(le.orig_ssn_wouldClean, 1, 0) << 14 ) + ( IF(le.orig_dob_wouldClean, 1, 0) << 15 ) + ( IF(le.orig_dl_num_wouldClean, 1, 0) << 16 ) + ( IF(le.orig_dl_state_wouldClean, 1, 0) << 17 ) + ( IF(le.orig_address1_addressline1_wouldClean, 1, 0) << 18 ) + ( IF(le.orig_address1_addressline2_wouldClean, 1, 0) << 19 ) + ( IF(le.orig_address1_prim_range_wouldClean, 1, 0) << 20 ) + ( IF(le.orig_address1_predir_wouldClean, 1, 0) << 21 ) + ( IF(le.orig_address1_prim_name_wouldClean, 1, 0) << 22 ) + ( IF(le.orig_address1_suffix_wouldClean, 1, 0) << 23 ) + ( IF(le.orig_address1_postdir_wouldClean, 1, 0) << 24 ) + ( IF(le.orig_address1_unit_desig_wouldClean, 1, 0) << 25 ) + ( IF(le.orig_address1_sec_range_wouldClean, 1, 0) << 26 ) + ( IF(le.orig_address1_city_wouldClean, 1, 0) << 27 ) + ( IF(le.orig_address1_st_wouldClean, 1, 0) << 28 ) + ( IF(le.orig_address1_z5_wouldClean, 1, 0) << 29 ) + ( IF(le.orig_address1_z4_wouldClean, 1, 0) << 30 ) + ( IF(le.orig_address2_addressline1_wouldClean, 1, 0) << 31 ) + ( IF(le.orig_address2_addressline2_wouldClean, 1, 0) << 32 ) + ( IF(le.orig_address2_prim_range_wouldClean, 1, 0) << 33 ) + ( IF(le.orig_address2_predir_wouldClean, 1, 0) << 34 ) + ( IF(le.orig_address2_prim_name_wouldClean, 1, 0) << 35 ) + ( IF(le.orig_address2_suffix_wouldClean, 1, 0) << 36 ) + ( IF(le.orig_address2_postdir_wouldClean, 1, 0) << 37 ) + ( IF(le.orig_address2_unit_desig_wouldClean, 1, 0) << 38 ) + ( IF(le.orig_address2_sec_range_wouldClean, 1, 0) << 39 ) + ( IF(le.orig_address2_city_wouldClean, 1, 0) << 40 ) + ( IF(le.orig_address2_st_wouldClean, 1, 0) << 41 ) + ( IF(le.orig_address2_z5_wouldClean, 1, 0) << 42 ) + ( IF(le.orig_address2_z4_wouldClean, 1, 0) << 43 ) + ( IF(le.orig_bdid_wouldClean, 1, 0) << 44 ) + ( IF(le.orig_bdl_wouldClean, 1, 0) << 45 ) + ( IF(le.orig_did_wouldClean, 1, 0) << 46 ) + ( IF(le.orig_company_name_wouldClean, 1, 0) << 47 ) + ( IF(le.orig_fein_wouldClean, 1, 0) << 48 ) + ( IF(le.orig_phone_wouldClean, 1, 0) << 49 ) + ( IF(le.orig_work_phone_wouldClean, 1, 0) << 50 ) + ( IF(le.orig_company_phone_wouldClean, 1, 0) << 51 ) + ( IF(le.orig_reference_code_wouldClean, 1, 0) << 52 ) + ( IF(le.orig_ip_address_initiated_wouldClean, 1, 0) << 53 ) + ( IF(le.orig_ip_address_executed_wouldClean, 1, 0) << 54 ) + ( IF(le.orig_charter_number_wouldClean, 1, 0) << 55 ) + ( IF(le.orig_ucc_original_filing_number_wouldClean, 1, 0) << 56 ) + ( IF(le.orig_email_address_wouldClean, 1, 0) << 57 ) + ( IF(le.orig_domain_name_wouldClean, 1, 0) << 58 ) + ( IF(le.orig_full_name_wouldClean, 1, 0) << 59 ) + ( IF(le.orig_dl_purpose_wouldClean, 1, 0) << 60 ) + ( IF(le.orig_glb_purpose_wouldClean, 1, 0) << 61 ) + ( IF(le.orig_fcra_purpose_wouldClean, 1, 0) << 62 ) + ( IF(le.orig_process_id_wouldClean, 1, 0) << 63 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_FILE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_datetime_stamp_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_global_company_id_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_company_id_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.orig_product_cd_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.orig_method_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.orig_vertical_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.orig_function_name_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.orig_transaction_type_Invalid := (le.ScrubsBits1 >> 17) & 7;
    SELF.orig_login_history_id_Invalid := (le.ScrubsBits1 >> 20) & 7;
    SELF.orig_job_id_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.orig_sequence_number_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.orig_first_name_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.orig_middle_name_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.orig_last_name_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.orig_ssn_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.orig_dl_num_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.orig_dl_state_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.orig_address1_addressline1_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.orig_address1_addressline2_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.orig_address1_prim_range_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.orig_address1_predir_Invalid := (le.ScrubsBits1 >> 50) & 7;
    SELF.orig_address1_prim_name_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.orig_address1_suffix_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.orig_address1_postdir_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.orig_address1_unit_desig_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.orig_address1_sec_range_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.orig_address1_city_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.orig_address1_st_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.orig_address1_z5_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.orig_address1_z4_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.orig_address2_addressline1_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.orig_address2_addressline2_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.orig_address2_prim_range_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.orig_address2_predir_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.orig_address2_prim_name_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.orig_address2_suffix_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.orig_address2_postdir_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.orig_address2_unit_desig_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.orig_address2_sec_range_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.orig_address2_city_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.orig_address2_st_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.orig_address2_z5_Invalid := (le.ScrubsBits2 >> 42) & 7;
    SELF.orig_address2_z4_Invalid := (le.ScrubsBits2 >> 45) & 7;
    SELF.orig_bdid_Invalid := (le.ScrubsBits2 >> 48) & 7;
    SELF.orig_bdl_Invalid := (le.ScrubsBits2 >> 51) & 7;
    SELF.orig_did_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.orig_company_name_Invalid := (le.ScrubsBits2 >> 57) & 7;
    SELF.orig_fein_Invalid := (le.ScrubsBits2 >> 60) & 7;
    SELF.orig_phone_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.orig_work_phone_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.orig_company_phone_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.orig_reference_code_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.orig_ip_address_initiated_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.orig_ip_address_executed_Invalid := (le.ScrubsBits3 >> 15) & 3;
    SELF.orig_charter_number_Invalid := (le.ScrubsBits3 >> 17) & 7;
    SELF.orig_ucc_original_filing_number_Invalid := (le.ScrubsBits3 >> 20) & 7;
    SELF.orig_email_address_Invalid := (le.ScrubsBits3 >> 23) & 7;
    SELF.orig_domain_name_Invalid := (le.ScrubsBits3 >> 26) & 7;
    SELF.orig_full_name_Invalid := (le.ScrubsBits3 >> 29) & 7;
    SELF.orig_dl_purpose_Invalid := (le.ScrubsBits3 >> 32) & 7;
    SELF.orig_glb_purpose_Invalid := (le.ScrubsBits3 >> 35) & 7;
    SELF.orig_fcra_purpose_Invalid := (le.ScrubsBits3 >> 38) & 7;
    SELF.orig_process_id_Invalid := (le.ScrubsBits3 >> 41) & 3;
    SELF.orig_datetime_stamp_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.orig_global_company_id_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.orig_company_id_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.orig_product_cd_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.orig_method_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.orig_vertical_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.orig_function_name_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.orig_transaction_type_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.orig_login_history_id_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.orig_job_id_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.orig_sequence_number_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.orig_first_name_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.orig_middle_name_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.orig_last_name_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.orig_ssn_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.orig_dob_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.orig_dl_num_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.orig_dl_state_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.orig_address1_addressline1_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.orig_address1_addressline2_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.orig_address1_prim_range_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.orig_address1_predir_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.orig_address1_prim_name_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.orig_address1_suffix_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.orig_address1_postdir_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.orig_address1_unit_desig_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.orig_address1_sec_range_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.orig_address1_city_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.orig_address1_st_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.orig_address1_z5_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.orig_address1_z4_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.orig_address2_addressline1_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.orig_address2_addressline2_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.orig_address2_prim_range_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.orig_address2_predir_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.orig_address2_prim_name_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.orig_address2_suffix_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.orig_address2_postdir_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.orig_address2_unit_desig_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.orig_address2_sec_range_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.orig_address2_city_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.orig_address2_st_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.orig_address2_z5_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF.orig_address2_z4_wouldClean := le.ScrubsCleanBits1 >> 43;
    SELF.orig_bdid_wouldClean := le.ScrubsCleanBits1 >> 44;
    SELF.orig_bdl_wouldClean := le.ScrubsCleanBits1 >> 45;
    SELF.orig_did_wouldClean := le.ScrubsCleanBits1 >> 46;
    SELF.orig_company_name_wouldClean := le.ScrubsCleanBits1 >> 47;
    SELF.orig_fein_wouldClean := le.ScrubsCleanBits1 >> 48;
    SELF.orig_phone_wouldClean := le.ScrubsCleanBits1 >> 49;
    SELF.orig_work_phone_wouldClean := le.ScrubsCleanBits1 >> 50;
    SELF.orig_company_phone_wouldClean := le.ScrubsCleanBits1 >> 51;
    SELF.orig_reference_code_wouldClean := le.ScrubsCleanBits1 >> 52;
    SELF.orig_ip_address_initiated_wouldClean := le.ScrubsCleanBits1 >> 53;
    SELF.orig_ip_address_executed_wouldClean := le.ScrubsCleanBits1 >> 54;
    SELF.orig_charter_number_wouldClean := le.ScrubsCleanBits1 >> 55;
    SELF.orig_ucc_original_filing_number_wouldClean := le.ScrubsCleanBits1 >> 56;
    SELF.orig_email_address_wouldClean := le.ScrubsCleanBits1 >> 57;
    SELF.orig_domain_name_wouldClean := le.ScrubsCleanBits1 >> 58;
    SELF.orig_full_name_wouldClean := le.ScrubsCleanBits1 >> 59;
    SELF.orig_dl_purpose_wouldClean := le.ScrubsCleanBits1 >> 60;
    SELF.orig_glb_purpose_wouldClean := le.ScrubsCleanBits1 >> 61;
    SELF.orig_fcra_purpose_wouldClean := le.ScrubsCleanBits1 >> 62;
    SELF.orig_process_id_wouldClean := le.ScrubsCleanBits1 >> 63;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_datetime_stamp_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid=1);
    orig_datetime_stamp_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid=1 AND h.orig_datetime_stamp_wouldClean);
    orig_datetime_stamp_ALLOW_ErrorCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid=2);
    orig_datetime_stamp_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid=2 AND h.orig_datetime_stamp_wouldClean);
    orig_datetime_stamp_WORDS_ErrorCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid=3);
    orig_datetime_stamp_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid=3 AND h.orig_datetime_stamp_wouldClean);
    orig_datetime_stamp_Total_ErrorCount := COUNT(GROUP,h.orig_datetime_stamp_Invalid>0);
    orig_global_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_global_company_id_Invalid=1);
    orig_global_company_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_global_company_id_Invalid=1 AND h.orig_global_company_id_wouldClean);
    orig_global_company_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_global_company_id_Invalid=2);
    orig_global_company_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_global_company_id_Invalid=2 AND h.orig_global_company_id_wouldClean);
    orig_global_company_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_global_company_id_Invalid=3);
    orig_global_company_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_global_company_id_Invalid=3 AND h.orig_global_company_id_wouldClean);
    orig_global_company_id_Total_ErrorCount := COUNT(GROUP,h.orig_global_company_id_Invalid>0);
    orig_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=1);
    orig_company_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=1 AND h.orig_company_id_wouldClean);
    orig_company_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=2);
    orig_company_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=2 AND h.orig_company_id_wouldClean);
    orig_company_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=3);
    orig_company_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=3 AND h.orig_company_id_wouldClean);
    orig_company_id_Total_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid>0);
    orig_product_cd_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_product_cd_Invalid=1);
    orig_product_cd_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_product_cd_Invalid=1 AND h.orig_product_cd_wouldClean);
    orig_product_cd_ALLOW_ErrorCount := COUNT(GROUP,h.orig_product_cd_Invalid=2);
    orig_product_cd_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_product_cd_Invalid=2 AND h.orig_product_cd_wouldClean);
    orig_product_cd_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_product_cd_Invalid=3);
    orig_product_cd_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_product_cd_Invalid=3 AND h.orig_product_cd_wouldClean);
    orig_product_cd_WORDS_ErrorCount := COUNT(GROUP,h.orig_product_cd_Invalid=4);
    orig_product_cd_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_product_cd_Invalid=4 AND h.orig_product_cd_wouldClean);
    orig_product_cd_Total_ErrorCount := COUNT(GROUP,h.orig_product_cd_Invalid>0);
    orig_method_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_method_Invalid=1);
    orig_method_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_method_Invalid=1 AND h.orig_method_wouldClean);
    orig_method_ALLOW_ErrorCount := COUNT(GROUP,h.orig_method_Invalid=2);
    orig_method_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_method_Invalid=2 AND h.orig_method_wouldClean);
    orig_method_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_method_Invalid=3);
    orig_method_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_method_Invalid=3 AND h.orig_method_wouldClean);
    orig_method_WORDS_ErrorCount := COUNT(GROUP,h.orig_method_Invalid=4);
    orig_method_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_method_Invalid=4 AND h.orig_method_wouldClean);
    orig_method_Total_ErrorCount := COUNT(GROUP,h.orig_method_Invalid>0);
    orig_vertical_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_vertical_Invalid=1);
    orig_vertical_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_vertical_Invalid=1 AND h.orig_vertical_wouldClean);
    orig_vertical_ALLOW_ErrorCount := COUNT(GROUP,h.orig_vertical_Invalid=2);
    orig_vertical_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_vertical_Invalid=2 AND h.orig_vertical_wouldClean);
    orig_vertical_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_vertical_Invalid=3);
    orig_vertical_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_vertical_Invalid=3 AND h.orig_vertical_wouldClean);
    orig_vertical_WORDS_ErrorCount := COUNT(GROUP,h.orig_vertical_Invalid=4);
    orig_vertical_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_vertical_Invalid=4 AND h.orig_vertical_wouldClean);
    orig_vertical_Total_ErrorCount := COUNT(GROUP,h.orig_vertical_Invalid>0);
    orig_function_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=1);
    orig_function_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=1 AND h.orig_function_name_wouldClean);
    orig_function_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=2);
    orig_function_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=2 AND h.orig_function_name_wouldClean);
    orig_function_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=3);
    orig_function_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=3 AND h.orig_function_name_wouldClean);
    orig_function_name_Total_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid>0);
    orig_transaction_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=1);
    orig_transaction_type_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=1 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_ALLOW_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=2);
    orig_transaction_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=2 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=3);
    orig_transaction_type_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=3 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_WORDS_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=4);
    orig_transaction_type_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=4 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid>0);
    orig_login_history_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1);
    orig_login_history_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2);
    orig_login_history_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=3);
    orig_login_history_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=3 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=4);
    orig_login_history_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=4 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_Total_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid>0);
    orig_job_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_job_id_Invalid=1);
    orig_job_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_job_id_Invalid=1 AND h.orig_job_id_wouldClean);
    orig_job_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_job_id_Invalid=2);
    orig_job_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_job_id_Invalid=2 AND h.orig_job_id_wouldClean);
    orig_job_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_job_id_Invalid=3);
    orig_job_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_job_id_Invalid=3 AND h.orig_job_id_wouldClean);
    orig_job_id_Total_ErrorCount := COUNT(GROUP,h.orig_job_id_Invalid>0);
    orig_sequence_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_sequence_number_Invalid=1);
    orig_sequence_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_sequence_number_Invalid=1 AND h.orig_sequence_number_wouldClean);
    orig_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_sequence_number_Invalid=2);
    orig_sequence_number_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_sequence_number_Invalid=2 AND h.orig_sequence_number_wouldClean);
    orig_sequence_number_WORDS_ErrorCount := COUNT(GROUP,h.orig_sequence_number_Invalid=3);
    orig_sequence_number_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_sequence_number_Invalid=3 AND h.orig_sequence_number_wouldClean);
    orig_sequence_number_Total_ErrorCount := COUNT(GROUP,h.orig_sequence_number_Invalid>0);
    orig_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid=1);
    orig_first_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_first_name_Invalid=1 AND h.orig_first_name_wouldClean);
    orig_first_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid=2);
    orig_first_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_first_name_Invalid=2 AND h.orig_first_name_wouldClean);
    orig_first_name_Total_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid>0);
    orig_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid=1);
    orig_middle_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_middle_name_Invalid=1 AND h.orig_middle_name_wouldClean);
    orig_middle_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid=2);
    orig_middle_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_middle_name_Invalid=2 AND h.orig_middle_name_wouldClean);
    orig_middle_name_Total_ErrorCount := COUNT(GROUP,h.orig_middle_name_Invalid>0);
    orig_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=1);
    orig_last_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_last_name_Invalid=1 AND h.orig_last_name_wouldClean);
    orig_last_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=2);
    orig_last_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_last_name_Invalid=2 AND h.orig_last_name_wouldClean);
    orig_last_name_Total_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid>0);
    orig_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=1);
    orig_ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=1 AND h.orig_ssn_wouldClean);
    orig_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=2);
    orig_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=2 AND h.orig_ssn_wouldClean);
    orig_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=3);
    orig_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=3 AND h.orig_ssn_wouldClean);
    orig_ssn_WORDS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=4);
    orig_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=4 AND h.orig_ssn_wouldClean);
    orig_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid>0);
    orig_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=1 AND h.orig_dob_wouldClean);
    orig_dob_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=2 AND h.orig_dob_wouldClean);
    orig_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=3);
    orig_dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=3 AND h.orig_dob_wouldClean);
    orig_dob_WORDS_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=4);
    orig_dob_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=4 AND h.orig_dob_wouldClean);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_dl_num_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dl_num_Invalid=1);
    orig_dl_num_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dl_num_Invalid=1 AND h.orig_dl_num_wouldClean);
    orig_dl_num_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_num_Invalid=2);
    orig_dl_num_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dl_num_Invalid=2 AND h.orig_dl_num_wouldClean);
    orig_dl_num_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dl_num_Invalid=3);
    orig_dl_num_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dl_num_Invalid=3 AND h.orig_dl_num_wouldClean);
    orig_dl_num_WORDS_ErrorCount := COUNT(GROUP,h.orig_dl_num_Invalid=4);
    orig_dl_num_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dl_num_Invalid=4 AND h.orig_dl_num_wouldClean);
    orig_dl_num_Total_ErrorCount := COUNT(GROUP,h.orig_dl_num_Invalid>0);
    orig_dl_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dl_state_Invalid=1);
    orig_dl_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dl_state_Invalid=1 AND h.orig_dl_state_wouldClean);
    orig_dl_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_state_Invalid=2);
    orig_dl_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dl_state_Invalid=2 AND h.orig_dl_state_wouldClean);
    orig_dl_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dl_state_Invalid=3);
    orig_dl_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dl_state_Invalid=3 AND h.orig_dl_state_wouldClean);
    orig_dl_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_dl_state_Invalid=4);
    orig_dl_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dl_state_Invalid=4 AND h.orig_dl_state_wouldClean);
    orig_dl_state_Total_ErrorCount := COUNT(GROUP,h.orig_dl_state_Invalid>0);
    orig_address1_addressline1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_addressline1_Invalid=1);
    orig_address1_addressline1_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_addressline1_Invalid=1 AND h.orig_address1_addressline1_wouldClean);
    orig_address1_addressline2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_addressline2_Invalid=1);
    orig_address1_addressline2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_addressline2_Invalid=1 AND h.orig_address1_addressline2_wouldClean);
    orig_address1_addressline2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_addressline2_Invalid=2);
    orig_address1_addressline2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_addressline2_Invalid=2 AND h.orig_address1_addressline2_wouldClean);
    orig_address1_addressline2_Total_ErrorCount := COUNT(GROUP,h.orig_address1_addressline2_Invalid>0);
    orig_address1_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_prim_range_Invalid=1);
    orig_address1_prim_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_prim_range_Invalid=1 AND h.orig_address1_prim_range_wouldClean);
    orig_address1_prim_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_prim_range_Invalid=2);
    orig_address1_prim_range_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_prim_range_Invalid=2 AND h.orig_address1_prim_range_wouldClean);
    orig_address1_prim_range_Total_ErrorCount := COUNT(GROUP,h.orig_address1_prim_range_Invalid>0);
    orig_address1_predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_predir_Invalid=1);
    orig_address1_predir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_predir_Invalid=1 AND h.orig_address1_predir_wouldClean);
    orig_address1_predir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_predir_Invalid=2);
    orig_address1_predir_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_predir_Invalid=2 AND h.orig_address1_predir_wouldClean);
    orig_address1_predir_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address1_predir_Invalid=3);
    orig_address1_predir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address1_predir_Invalid=3 AND h.orig_address1_predir_wouldClean);
    orig_address1_predir_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_predir_Invalid=4);
    orig_address1_predir_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_predir_Invalid=4 AND h.orig_address1_predir_wouldClean);
    orig_address1_predir_Total_ErrorCount := COUNT(GROUP,h.orig_address1_predir_Invalid>0);
    orig_address1_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_prim_name_Invalid=1);
    orig_address1_prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_prim_name_Invalid=1 AND h.orig_address1_prim_name_wouldClean);
    orig_address1_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_suffix_Invalid=1);
    orig_address1_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_suffix_Invalid=1 AND h.orig_address1_suffix_wouldClean);
    orig_address1_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_suffix_Invalid=2);
    orig_address1_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_suffix_Invalid=2 AND h.orig_address1_suffix_wouldClean);
    orig_address1_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_address1_suffix_Invalid>0);
    orig_address1_postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_postdir_Invalid=1);
    orig_address1_postdir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_postdir_Invalid=1 AND h.orig_address1_postdir_wouldClean);
    orig_address1_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_postdir_Invalid=2);
    orig_address1_postdir_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_postdir_Invalid=2 AND h.orig_address1_postdir_wouldClean);
    orig_address1_postdir_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_postdir_Invalid=3);
    orig_address1_postdir_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_postdir_Invalid=3 AND h.orig_address1_postdir_wouldClean);
    orig_address1_postdir_Total_ErrorCount := COUNT(GROUP,h.orig_address1_postdir_Invalid>0);
    orig_address1_unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid=1);
    orig_address1_unit_desig_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid=1 AND h.orig_address1_unit_desig_wouldClean);
    orig_address1_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid=2);
    orig_address1_unit_desig_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid=2 AND h.orig_address1_unit_desig_wouldClean);
    orig_address1_unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid=3);
    orig_address1_unit_desig_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid=3 AND h.orig_address1_unit_desig_wouldClean);
    orig_address1_unit_desig_Total_ErrorCount := COUNT(GROUP,h.orig_address1_unit_desig_Invalid>0);
    orig_address1_sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid=1);
    orig_address1_sec_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid=1 AND h.orig_address1_sec_range_wouldClean);
    orig_address1_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid=2);
    orig_address1_sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid=2 AND h.orig_address1_sec_range_wouldClean);
    orig_address1_sec_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid=3);
    orig_address1_sec_range_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid=3 AND h.orig_address1_sec_range_wouldClean);
    orig_address1_sec_range_Total_ErrorCount := COUNT(GROUP,h.orig_address1_sec_range_Invalid>0);
    orig_address1_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_city_Invalid=1);
    orig_address1_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_city_Invalid=1 AND h.orig_address1_city_wouldClean);
    orig_address1_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_city_Invalid=2);
    orig_address1_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_city_Invalid=2 AND h.orig_address1_city_wouldClean);
    orig_address1_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_city_Invalid=3);
    orig_address1_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_city_Invalid=3 AND h.orig_address1_city_wouldClean);
    orig_address1_city_Total_ErrorCount := COUNT(GROUP,h.orig_address1_city_Invalid>0);
    orig_address1_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_st_Invalid=1);
    orig_address1_st_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_st_Invalid=1 AND h.orig_address1_st_wouldClean);
    orig_address1_st_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_st_Invalid=2);
    orig_address1_st_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_st_Invalid=2 AND h.orig_address1_st_wouldClean);
    orig_address1_st_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address1_st_Invalid=3);
    orig_address1_st_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address1_st_Invalid=3 AND h.orig_address1_st_wouldClean);
    orig_address1_st_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_st_Invalid=4);
    orig_address1_st_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_st_Invalid=4 AND h.orig_address1_st_wouldClean);
    orig_address1_st_Total_ErrorCount := COUNT(GROUP,h.orig_address1_st_Invalid>0);
    orig_address1_z5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_z5_Invalid=1);
    orig_address1_z5_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_z5_Invalid=1 AND h.orig_address1_z5_wouldClean);
    orig_address1_z5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_z5_Invalid=2);
    orig_address1_z5_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_z5_Invalid=2 AND h.orig_address1_z5_wouldClean);
    orig_address1_z5_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address1_z5_Invalid=3);
    orig_address1_z5_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address1_z5_Invalid=3 AND h.orig_address1_z5_wouldClean);
    orig_address1_z5_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_z5_Invalid=4);
    orig_address1_z5_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_z5_Invalid=4 AND h.orig_address1_z5_wouldClean);
    orig_address1_z5_Total_ErrorCount := COUNT(GROUP,h.orig_address1_z5_Invalid>0);
    orig_address1_z4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address1_z4_Invalid=1);
    orig_address1_z4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address1_z4_Invalid=1 AND h.orig_address1_z4_wouldClean);
    orig_address1_z4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address1_z4_Invalid=2);
    orig_address1_z4_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address1_z4_Invalid=2 AND h.orig_address1_z4_wouldClean);
    orig_address1_z4_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address1_z4_Invalid=3);
    orig_address1_z4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address1_z4_Invalid=3 AND h.orig_address1_z4_wouldClean);
    orig_address1_z4_WORDS_ErrorCount := COUNT(GROUP,h.orig_address1_z4_Invalid=4);
    orig_address1_z4_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address1_z4_Invalid=4 AND h.orig_address1_z4_wouldClean);
    orig_address1_z4_Total_ErrorCount := COUNT(GROUP,h.orig_address1_z4_Invalid>0);
    orig_address2_addressline1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=1);
    orig_address2_addressline1_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=1 AND h.orig_address2_addressline1_wouldClean);
    orig_address2_addressline1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=2);
    orig_address2_addressline1_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=2 AND h.orig_address2_addressline1_wouldClean);
    orig_address2_addressline1_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=3);
    orig_address2_addressline1_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=3 AND h.orig_address2_addressline1_wouldClean);
    orig_address2_addressline1_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=4);
    orig_address2_addressline1_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid=4 AND h.orig_address2_addressline1_wouldClean);
    orig_address2_addressline1_Total_ErrorCount := COUNT(GROUP,h.orig_address2_addressline1_Invalid>0);
    orig_address2_addressline2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=1);
    orig_address2_addressline2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=1 AND h.orig_address2_addressline2_wouldClean);
    orig_address2_addressline2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=2);
    orig_address2_addressline2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=2 AND h.orig_address2_addressline2_wouldClean);
    orig_address2_addressline2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=3);
    orig_address2_addressline2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=3 AND h.orig_address2_addressline2_wouldClean);
    orig_address2_addressline2_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=4);
    orig_address2_addressline2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid=4 AND h.orig_address2_addressline2_wouldClean);
    orig_address2_addressline2_Total_ErrorCount := COUNT(GROUP,h.orig_address2_addressline2_Invalid>0);
    orig_address2_prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=1);
    orig_address2_prim_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=1 AND h.orig_address2_prim_range_wouldClean);
    orig_address2_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=2);
    orig_address2_prim_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=2 AND h.orig_address2_prim_range_wouldClean);
    orig_address2_prim_range_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=3);
    orig_address2_prim_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=3 AND h.orig_address2_prim_range_wouldClean);
    orig_address2_prim_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=4);
    orig_address2_prim_range_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid=4 AND h.orig_address2_prim_range_wouldClean);
    orig_address2_prim_range_Total_ErrorCount := COUNT(GROUP,h.orig_address2_prim_range_Invalid>0);
    orig_address2_predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_predir_Invalid=1);
    orig_address2_predir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_predir_Invalid=1 AND h.orig_address2_predir_wouldClean);
    orig_address2_predir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_predir_Invalid=2);
    orig_address2_predir_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_predir_Invalid=2 AND h.orig_address2_predir_wouldClean);
    orig_address2_predir_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_predir_Invalid=3);
    orig_address2_predir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_predir_Invalid=3 AND h.orig_address2_predir_wouldClean);
    orig_address2_predir_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_predir_Invalid=4);
    orig_address2_predir_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_predir_Invalid=4 AND h.orig_address2_predir_wouldClean);
    orig_address2_predir_Total_ErrorCount := COUNT(GROUP,h.orig_address2_predir_Invalid>0);
    orig_address2_prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=1);
    orig_address2_prim_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=1 AND h.orig_address2_prim_name_wouldClean);
    orig_address2_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=2);
    orig_address2_prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=2 AND h.orig_address2_prim_name_wouldClean);
    orig_address2_prim_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=3);
    orig_address2_prim_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=3 AND h.orig_address2_prim_name_wouldClean);
    orig_address2_prim_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=4);
    orig_address2_prim_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid=4 AND h.orig_address2_prim_name_wouldClean);
    orig_address2_prim_name_Total_ErrorCount := COUNT(GROUP,h.orig_address2_prim_name_Invalid>0);
    orig_address2_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=1);
    orig_address2_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=1 AND h.orig_address2_suffix_wouldClean);
    orig_address2_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=2);
    orig_address2_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=2 AND h.orig_address2_suffix_wouldClean);
    orig_address2_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=3);
    orig_address2_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=3 AND h.orig_address2_suffix_wouldClean);
    orig_address2_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=4);
    orig_address2_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_suffix_Invalid=4 AND h.orig_address2_suffix_wouldClean);
    orig_address2_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_address2_suffix_Invalid>0);
    orig_address2_postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=1);
    orig_address2_postdir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=1 AND h.orig_address2_postdir_wouldClean);
    orig_address2_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=2);
    orig_address2_postdir_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=2 AND h.orig_address2_postdir_wouldClean);
    orig_address2_postdir_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=3);
    orig_address2_postdir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=3 AND h.orig_address2_postdir_wouldClean);
    orig_address2_postdir_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=4);
    orig_address2_postdir_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_postdir_Invalid=4 AND h.orig_address2_postdir_wouldClean);
    orig_address2_postdir_Total_ErrorCount := COUNT(GROUP,h.orig_address2_postdir_Invalid>0);
    orig_address2_unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=1);
    orig_address2_unit_desig_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=1 AND h.orig_address2_unit_desig_wouldClean);
    orig_address2_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=2);
    orig_address2_unit_desig_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=2 AND h.orig_address2_unit_desig_wouldClean);
    orig_address2_unit_desig_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=3);
    orig_address2_unit_desig_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=3 AND h.orig_address2_unit_desig_wouldClean);
    orig_address2_unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=4);
    orig_address2_unit_desig_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid=4 AND h.orig_address2_unit_desig_wouldClean);
    orig_address2_unit_desig_Total_ErrorCount := COUNT(GROUP,h.orig_address2_unit_desig_Invalid>0);
    orig_address2_sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=1);
    orig_address2_sec_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=1 AND h.orig_address2_sec_range_wouldClean);
    orig_address2_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=2);
    orig_address2_sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=2 AND h.orig_address2_sec_range_wouldClean);
    orig_address2_sec_range_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=3);
    orig_address2_sec_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=3 AND h.orig_address2_sec_range_wouldClean);
    orig_address2_sec_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=4);
    orig_address2_sec_range_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid=4 AND h.orig_address2_sec_range_wouldClean);
    orig_address2_sec_range_Total_ErrorCount := COUNT(GROUP,h.orig_address2_sec_range_Invalid>0);
    orig_address2_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_city_Invalid=1);
    orig_address2_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_city_Invalid=1 AND h.orig_address2_city_wouldClean);
    orig_address2_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_city_Invalid=2);
    orig_address2_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_city_Invalid=2 AND h.orig_address2_city_wouldClean);
    orig_address2_city_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_city_Invalid=3);
    orig_address2_city_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_city_Invalid=3 AND h.orig_address2_city_wouldClean);
    orig_address2_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_city_Invalid=4);
    orig_address2_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_city_Invalid=4 AND h.orig_address2_city_wouldClean);
    orig_address2_city_Total_ErrorCount := COUNT(GROUP,h.orig_address2_city_Invalid>0);
    orig_address2_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_st_Invalid=1);
    orig_address2_st_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_st_Invalid=1 AND h.orig_address2_st_wouldClean);
    orig_address2_st_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_st_Invalid=2);
    orig_address2_st_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_st_Invalid=2 AND h.orig_address2_st_wouldClean);
    orig_address2_st_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_st_Invalid=3);
    orig_address2_st_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_st_Invalid=3 AND h.orig_address2_st_wouldClean);
    orig_address2_st_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_st_Invalid=4);
    orig_address2_st_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_st_Invalid=4 AND h.orig_address2_st_wouldClean);
    orig_address2_st_Total_ErrorCount := COUNT(GROUP,h.orig_address2_st_Invalid>0);
    orig_address2_z5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_z5_Invalid=1);
    orig_address2_z5_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_z5_Invalid=1 AND h.orig_address2_z5_wouldClean);
    orig_address2_z5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_z5_Invalid=2);
    orig_address2_z5_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_z5_Invalid=2 AND h.orig_address2_z5_wouldClean);
    orig_address2_z5_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_z5_Invalid=3);
    orig_address2_z5_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_z5_Invalid=3 AND h.orig_address2_z5_wouldClean);
    orig_address2_z5_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_z5_Invalid=4);
    orig_address2_z5_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_z5_Invalid=4 AND h.orig_address2_z5_wouldClean);
    orig_address2_z5_Total_ErrorCount := COUNT(GROUP,h.orig_address2_z5_Invalid>0);
    orig_address2_z4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address2_z4_Invalid=1);
    orig_address2_z4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address2_z4_Invalid=1 AND h.orig_address2_z4_wouldClean);
    orig_address2_z4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address2_z4_Invalid=2);
    orig_address2_z4_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address2_z4_Invalid=2 AND h.orig_address2_z4_wouldClean);
    orig_address2_z4_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address2_z4_Invalid=3);
    orig_address2_z4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address2_z4_Invalid=3 AND h.orig_address2_z4_wouldClean);
    orig_address2_z4_WORDS_ErrorCount := COUNT(GROUP,h.orig_address2_z4_Invalid=4);
    orig_address2_z4_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address2_z4_Invalid=4 AND h.orig_address2_z4_wouldClean);
    orig_address2_z4_Total_ErrorCount := COUNT(GROUP,h.orig_address2_z4_Invalid>0);
    orig_bdid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_bdid_Invalid=1);
    orig_bdid_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_bdid_Invalid=1 AND h.orig_bdid_wouldClean);
    orig_bdid_ALLOW_ErrorCount := COUNT(GROUP,h.orig_bdid_Invalid=2);
    orig_bdid_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_bdid_Invalid=2 AND h.orig_bdid_wouldClean);
    orig_bdid_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_bdid_Invalid=3);
    orig_bdid_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_bdid_Invalid=3 AND h.orig_bdid_wouldClean);
    orig_bdid_WORDS_ErrorCount := COUNT(GROUP,h.orig_bdid_Invalid=4);
    orig_bdid_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_bdid_Invalid=4 AND h.orig_bdid_wouldClean);
    orig_bdid_Total_ErrorCount := COUNT(GROUP,h.orig_bdid_Invalid>0);
    orig_bdl_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_bdl_Invalid=1);
    orig_bdl_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_bdl_Invalid=1 AND h.orig_bdl_wouldClean);
    orig_bdl_ALLOW_ErrorCount := COUNT(GROUP,h.orig_bdl_Invalid=2);
    orig_bdl_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_bdl_Invalid=2 AND h.orig_bdl_wouldClean);
    orig_bdl_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_bdl_Invalid=3);
    orig_bdl_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_bdl_Invalid=3 AND h.orig_bdl_wouldClean);
    orig_bdl_WORDS_ErrorCount := COUNT(GROUP,h.orig_bdl_Invalid=4);
    orig_bdl_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_bdl_Invalid=4 AND h.orig_bdl_wouldClean);
    orig_bdl_Total_ErrorCount := COUNT(GROUP,h.orig_bdl_Invalid>0);
    orig_did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_did_Invalid=1);
    orig_did_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_did_Invalid=1 AND h.orig_did_wouldClean);
    orig_did_ALLOW_ErrorCount := COUNT(GROUP,h.orig_did_Invalid=2);
    orig_did_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_did_Invalid=2 AND h.orig_did_wouldClean);
    orig_did_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_did_Invalid=3);
    orig_did_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_did_Invalid=3 AND h.orig_did_wouldClean);
    orig_did_WORDS_ErrorCount := COUNT(GROUP,h.orig_did_Invalid=4);
    orig_did_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_did_Invalid=4 AND h.orig_did_wouldClean);
    orig_did_Total_ErrorCount := COUNT(GROUP,h.orig_did_Invalid>0);
    orig_company_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_company_name_Invalid=1);
    orig_company_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_company_name_Invalid=1 AND h.orig_company_name_wouldClean);
    orig_company_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_company_name_Invalid=2);
    orig_company_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_company_name_Invalid=2 AND h.orig_company_name_wouldClean);
    orig_company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_company_name_Invalid=3);
    orig_company_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_company_name_Invalid=3 AND h.orig_company_name_wouldClean);
    orig_company_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_company_name_Invalid=4);
    orig_company_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_company_name_Invalid=4 AND h.orig_company_name_wouldClean);
    orig_company_name_Total_ErrorCount := COUNT(GROUP,h.orig_company_name_Invalid>0);
    orig_fein_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fein_Invalid=1);
    orig_fein_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_fein_Invalid=1 AND h.orig_fein_wouldClean);
    orig_fein_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fein_Invalid=2);
    orig_fein_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fein_Invalid=2 AND h.orig_fein_wouldClean);
    orig_fein_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_fein_Invalid=3);
    orig_fein_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_fein_Invalid=3 AND h.orig_fein_wouldClean);
    orig_fein_WORDS_ErrorCount := COUNT(GROUP,h.orig_fein_Invalid=4);
    orig_fein_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fein_Invalid=4 AND h.orig_fein_wouldClean);
    orig_fein_Total_ErrorCount := COUNT(GROUP,h.orig_fein_Invalid>0);
    orig_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=1 AND h.orig_phone_wouldClean);
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=2 AND h.orig_phone_wouldClean);
    orig_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=3);
    orig_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=3 AND h.orig_phone_wouldClean);
    orig_phone_WORDS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=4);
    orig_phone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=4 AND h.orig_phone_wouldClean);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    orig_work_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_work_phone_Invalid=1);
    orig_work_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_work_phone_Invalid=1 AND h.orig_work_phone_wouldClean);
    orig_work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_work_phone_Invalid=2);
    orig_work_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_work_phone_Invalid=2 AND h.orig_work_phone_wouldClean);
    orig_work_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_work_phone_Invalid=3);
    orig_work_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_work_phone_Invalid=3 AND h.orig_work_phone_wouldClean);
    orig_work_phone_WORDS_ErrorCount := COUNT(GROUP,h.orig_work_phone_Invalid=4);
    orig_work_phone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_work_phone_Invalid=4 AND h.orig_work_phone_wouldClean);
    orig_work_phone_Total_ErrorCount := COUNT(GROUP,h.orig_work_phone_Invalid>0);
    orig_company_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_company_phone_Invalid=1);
    orig_company_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_company_phone_Invalid=1 AND h.orig_company_phone_wouldClean);
    orig_company_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_company_phone_Invalid=2);
    orig_company_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_company_phone_Invalid=2 AND h.orig_company_phone_wouldClean);
    orig_company_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_company_phone_Invalid=3);
    orig_company_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_company_phone_Invalid=3 AND h.orig_company_phone_wouldClean);
    orig_company_phone_WORDS_ErrorCount := COUNT(GROUP,h.orig_company_phone_Invalid=4);
    orig_company_phone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_company_phone_Invalid=4 AND h.orig_company_phone_wouldClean);
    orig_company_phone_Total_ErrorCount := COUNT(GROUP,h.orig_company_phone_Invalid>0);
    orig_reference_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=1);
    orig_reference_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=1 AND h.orig_reference_code_wouldClean);
    orig_reference_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=2);
    orig_reference_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=2 AND h.orig_reference_code_wouldClean);
    orig_reference_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=3);
    orig_reference_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=3 AND h.orig_reference_code_wouldClean);
    orig_reference_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=4);
    orig_reference_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=4 AND h.orig_reference_code_wouldClean);
    orig_reference_code_Total_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid>0);
    orig_ip_address_initiated_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=1);
    orig_ip_address_initiated_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=1 AND h.orig_ip_address_initiated_wouldClean);
    orig_ip_address_initiated_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=2);
    orig_ip_address_initiated_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=2 AND h.orig_ip_address_initiated_wouldClean);
    orig_ip_address_initiated_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=3);
    orig_ip_address_initiated_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=3 AND h.orig_ip_address_initiated_wouldClean);
    orig_ip_address_initiated_WORDS_ErrorCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=4);
    orig_ip_address_initiated_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid=4 AND h.orig_ip_address_initiated_wouldClean);
    orig_ip_address_initiated_Total_ErrorCount := COUNT(GROUP,h.orig_ip_address_initiated_Invalid>0);
    orig_ip_address_executed_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ip_address_executed_Invalid=1);
    orig_ip_address_executed_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_executed_Invalid=1 AND h.orig_ip_address_executed_wouldClean);
    orig_ip_address_executed_WORDS_ErrorCount := COUNT(GROUP,h.orig_ip_address_executed_Invalid=2);
    orig_ip_address_executed_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_executed_Invalid=2 AND h.orig_ip_address_executed_wouldClean);
    orig_ip_address_executed_Total_ErrorCount := COUNT(GROUP,h.orig_ip_address_executed_Invalid>0);
    orig_charter_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_charter_number_Invalid=1);
    orig_charter_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_charter_number_Invalid=1 AND h.orig_charter_number_wouldClean);
    orig_charter_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_charter_number_Invalid=2);
    orig_charter_number_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_charter_number_Invalid=2 AND h.orig_charter_number_wouldClean);
    orig_charter_number_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_charter_number_Invalid=3);
    orig_charter_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_charter_number_Invalid=3 AND h.orig_charter_number_wouldClean);
    orig_charter_number_WORDS_ErrorCount := COUNT(GROUP,h.orig_charter_number_Invalid=4);
    orig_charter_number_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_charter_number_Invalid=4 AND h.orig_charter_number_wouldClean);
    orig_charter_number_Total_ErrorCount := COUNT(GROUP,h.orig_charter_number_Invalid>0);
    orig_ucc_original_filing_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=1);
    orig_ucc_original_filing_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=1 AND h.orig_ucc_original_filing_number_wouldClean);
    orig_ucc_original_filing_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=2);
    orig_ucc_original_filing_number_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=2 AND h.orig_ucc_original_filing_number_wouldClean);
    orig_ucc_original_filing_number_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=3);
    orig_ucc_original_filing_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=3 AND h.orig_ucc_original_filing_number_wouldClean);
    orig_ucc_original_filing_number_WORDS_ErrorCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=4);
    orig_ucc_original_filing_number_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid=4 AND h.orig_ucc_original_filing_number_wouldClean);
    orig_ucc_original_filing_number_Total_ErrorCount := COUNT(GROUP,h.orig_ucc_original_filing_number_Invalid>0);
    orig_email_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_email_address_Invalid=1);
    orig_email_address_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_email_address_Invalid=1 AND h.orig_email_address_wouldClean);
    orig_email_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_email_address_Invalid=2);
    orig_email_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_email_address_Invalid=2 AND h.orig_email_address_wouldClean);
    orig_email_address_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_email_address_Invalid=3);
    orig_email_address_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_email_address_Invalid=3 AND h.orig_email_address_wouldClean);
    orig_email_address_WORDS_ErrorCount := COUNT(GROUP,h.orig_email_address_Invalid=4);
    orig_email_address_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_email_address_Invalid=4 AND h.orig_email_address_wouldClean);
    orig_email_address_Total_ErrorCount := COUNT(GROUP,h.orig_email_address_Invalid>0);
    orig_domain_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_domain_name_Invalid=1);
    orig_domain_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_domain_name_Invalid=1 AND h.orig_domain_name_wouldClean);
    orig_domain_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_domain_name_Invalid=2);
    orig_domain_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_domain_name_Invalid=2 AND h.orig_domain_name_wouldClean);
    orig_domain_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_domain_name_Invalid=3);
    orig_domain_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_domain_name_Invalid=3 AND h.orig_domain_name_wouldClean);
    orig_domain_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_domain_name_Invalid=4);
    orig_domain_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_domain_name_Invalid=4 AND h.orig_domain_name_wouldClean);
    orig_domain_name_Total_ErrorCount := COUNT(GROUP,h.orig_domain_name_Invalid>0);
    orig_full_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=1);
    orig_full_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=1 AND h.orig_full_name_wouldClean);
    orig_full_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=2);
    orig_full_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=2 AND h.orig_full_name_wouldClean);
    orig_full_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=3);
    orig_full_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=3 AND h.orig_full_name_wouldClean);
    orig_full_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=4);
    orig_full_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=4 AND h.orig_full_name_wouldClean);
    orig_full_name_Total_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid>0);
    orig_dl_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=1);
    orig_dl_purpose_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=1 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=2);
    orig_dl_purpose_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=2 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=3);
    orig_dl_purpose_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=3 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_WORDS_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=4);
    orig_dl_purpose_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=4 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid>0);
    orig_glb_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=1);
    orig_glb_purpose_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=1 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=2);
    orig_glb_purpose_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=2 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=3);
    orig_glb_purpose_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=3 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_WORDS_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=4);
    orig_glb_purpose_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=4 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid>0);
    orig_fcra_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=1);
    orig_fcra_purpose_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=1 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=2);
    orig_fcra_purpose_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=2 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=3);
    orig_fcra_purpose_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=3 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_WORDS_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=4);
    orig_fcra_purpose_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=4 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid>0);
    orig_process_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_process_id_Invalid=1);
    orig_process_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_process_id_Invalid=1 AND h.orig_process_id_wouldClean);
    orig_process_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_process_id_Invalid=2);
    orig_process_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_process_id_Invalid=2 AND h.orig_process_id_wouldClean);
    orig_process_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_process_id_Invalid=3);
    orig_process_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_process_id_Invalid=3 AND h.orig_process_id_wouldClean);
    orig_process_id_Total_ErrorCount := COUNT(GROUP,h.orig_process_id_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_datetime_stamp_Invalid > 0 OR h.orig_global_company_id_Invalid > 0 OR h.orig_company_id_Invalid > 0 OR h.orig_product_cd_Invalid > 0 OR h.orig_method_Invalid > 0 OR h.orig_vertical_Invalid > 0 OR h.orig_function_name_Invalid > 0 OR h.orig_transaction_type_Invalid > 0 OR h.orig_login_history_id_Invalid > 0 OR h.orig_job_id_Invalid > 0 OR h.orig_sequence_number_Invalid > 0 OR h.orig_first_name_Invalid > 0 OR h.orig_middle_name_Invalid > 0 OR h.orig_last_name_Invalid > 0 OR h.orig_ssn_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_dl_num_Invalid > 0 OR h.orig_dl_state_Invalid > 0 OR h.orig_address1_addressline1_Invalid > 0 OR h.orig_address1_addressline2_Invalid > 0 OR h.orig_address1_prim_range_Invalid > 0 OR h.orig_address1_predir_Invalid > 0 OR h.orig_address1_prim_name_Invalid > 0 OR h.orig_address1_suffix_Invalid > 0 OR h.orig_address1_postdir_Invalid > 0 OR h.orig_address1_unit_desig_Invalid > 0 OR h.orig_address1_sec_range_Invalid > 0 OR h.orig_address1_city_Invalid > 0 OR h.orig_address1_st_Invalid > 0 OR h.orig_address1_z5_Invalid > 0 OR h.orig_address1_z4_Invalid > 0 OR h.orig_address2_addressline1_Invalid > 0 OR h.orig_address2_addressline2_Invalid > 0 OR h.orig_address2_prim_range_Invalid > 0 OR h.orig_address2_predir_Invalid > 0 OR h.orig_address2_prim_name_Invalid > 0 OR h.orig_address2_suffix_Invalid > 0 OR h.orig_address2_postdir_Invalid > 0 OR h.orig_address2_unit_desig_Invalid > 0 OR h.orig_address2_sec_range_Invalid > 0 OR h.orig_address2_city_Invalid > 0 OR h.orig_address2_st_Invalid > 0 OR h.orig_address2_z5_Invalid > 0 OR h.orig_address2_z4_Invalid > 0 OR h.orig_bdid_Invalid > 0 OR h.orig_bdl_Invalid > 0 OR h.orig_did_Invalid > 0 OR h.orig_company_name_Invalid > 0 OR h.orig_fein_Invalid > 0 OR h.orig_phone_Invalid > 0 OR h.orig_work_phone_Invalid > 0 OR h.orig_company_phone_Invalid > 0 OR h.orig_reference_code_Invalid > 0 OR h.orig_ip_address_initiated_Invalid > 0 OR h.orig_ip_address_executed_Invalid > 0 OR h.orig_charter_number_Invalid > 0 OR h.orig_ucc_original_filing_number_Invalid > 0 OR h.orig_email_address_Invalid > 0 OR h.orig_domain_name_Invalid > 0 OR h.orig_full_name_Invalid > 0 OR h.orig_dl_purpose_Invalid > 0 OR h.orig_glb_purpose_Invalid > 0 OR h.orig_fcra_purpose_Invalid > 0 OR h.orig_process_id_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.orig_datetime_stamp_wouldClean OR h.orig_global_company_id_wouldClean OR h.orig_company_id_wouldClean OR h.orig_product_cd_wouldClean OR h.orig_method_wouldClean OR h.orig_vertical_wouldClean OR h.orig_function_name_wouldClean OR h.orig_transaction_type_wouldClean OR h.orig_login_history_id_wouldClean OR h.orig_job_id_wouldClean OR h.orig_sequence_number_wouldClean OR h.orig_first_name_wouldClean OR h.orig_middle_name_wouldClean OR h.orig_last_name_wouldClean OR h.orig_ssn_wouldClean OR h.orig_dob_wouldClean OR h.orig_dl_num_wouldClean OR h.orig_dl_state_wouldClean OR h.orig_address1_addressline1_wouldClean OR h.orig_address1_addressline2_wouldClean OR h.orig_address1_prim_range_wouldClean OR h.orig_address1_predir_wouldClean OR h.orig_address1_prim_name_wouldClean OR h.orig_address1_suffix_wouldClean OR h.orig_address1_postdir_wouldClean OR h.orig_address1_unit_desig_wouldClean OR h.orig_address1_sec_range_wouldClean OR h.orig_address1_city_wouldClean OR h.orig_address1_st_wouldClean OR h.orig_address1_z5_wouldClean OR h.orig_address1_z4_wouldClean OR h.orig_address2_addressline1_wouldClean OR h.orig_address2_addressline2_wouldClean OR h.orig_address2_prim_range_wouldClean OR h.orig_address2_predir_wouldClean OR h.orig_address2_prim_name_wouldClean OR h.orig_address2_suffix_wouldClean OR h.orig_address2_postdir_wouldClean OR h.orig_address2_unit_desig_wouldClean OR h.orig_address2_sec_range_wouldClean OR h.orig_address2_city_wouldClean OR h.orig_address2_st_wouldClean OR h.orig_address2_z5_wouldClean OR h.orig_address2_z4_wouldClean OR h.orig_bdid_wouldClean OR h.orig_bdl_wouldClean OR h.orig_did_wouldClean OR h.orig_company_name_wouldClean OR h.orig_fein_wouldClean OR h.orig_phone_wouldClean OR h.orig_work_phone_wouldClean OR h.orig_company_phone_wouldClean OR h.orig_reference_code_wouldClean OR h.orig_ip_address_initiated_wouldClean OR h.orig_ip_address_executed_wouldClean OR h.orig_charter_number_wouldClean OR h.orig_ucc_original_filing_number_wouldClean OR h.orig_email_address_wouldClean OR h.orig_domain_name_wouldClean OR h.orig_full_name_wouldClean OR h.orig_dl_purpose_wouldClean OR h.orig_glb_purpose_wouldClean OR h.orig_fcra_purpose_wouldClean OR h.orig_process_id_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_datetime_stamp_Total_ErrorCount > 0, 1, 0) + IF(le.orig_global_company_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_product_cd_Total_ErrorCount > 0, 1, 0) + IF(le.orig_method_Total_ErrorCount > 0, 1, 0) + IF(le.orig_vertical_Total_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_Total_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_job_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_sequence_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_num_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_addressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_addressline2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_prim_range_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_predir_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_postdir_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_st_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z5_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline1_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_range_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_predir_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_postdir_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_st_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z5_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_bdid_Total_ErrorCount > 0, 1, 0) + IF(le.orig_bdl_Total_ErrorCount > 0, 1, 0) + IF(le.orig_did_Total_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fein_Total_ErrorCount > 0, 1, 0) + IF(le.orig_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_work_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_company_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_executed_Total_ErrorCount > 0, 1, 0) + IF(le.orig_charter_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_email_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_domain_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_process_id_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_datetime_stamp_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_datetime_stamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_datetime_stamp_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_global_company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_global_company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_global_company_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_product_cd_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_product_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_product_cd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_product_cd_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_method_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_method_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_method_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_method_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_vertical_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_vertical_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_vertical_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_vertical_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_job_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_job_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_job_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_sequence_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_sequence_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_middle_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_last_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_num_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dl_num_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_num_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dl_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_addressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_addressline2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_addressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_prim_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_predir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_predir_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_postdir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_postdir_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_sec_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_sec_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_st_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_st_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z5_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address1_z4_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline1_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline1_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_addressline2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_predir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_predir_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_prim_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_postdir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_postdir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_postdir_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_sec_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_sec_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_sec_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_st_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_st_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z5_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address2_z4_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_bdid_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_bdid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_bdid_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_bdl_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_bdl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_bdl_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_bdl_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_did_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_did_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fein_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fein_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fein_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_fein_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_work_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_work_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_work_phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_company_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_company_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_company_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_company_phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_executed_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_executed_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_charter_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_charter_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_charter_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_charter_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_email_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_email_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_email_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_email_address_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_domain_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_domain_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_domain_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_domain_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_process_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_process_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_process_id_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.orig_datetime_stamp_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_datetime_stamp_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_datetime_stamp_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_global_company_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_global_company_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_global_company_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_product_cd_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_product_cd_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_product_cd_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_product_cd_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_method_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_method_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_method_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_method_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_vertical_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_vertical_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_vertical_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_vertical_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_job_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_job_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_job_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_sequence_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_sequence_number_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_sequence_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_first_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_first_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_middle_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_middle_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_last_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_last_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_num_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_num_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_num_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_num_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_addressline1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_addressline2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_addressline2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_prim_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_prim_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_predir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_predir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_predir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_predir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_postdir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_postdir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_postdir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_unit_desig_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_sec_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_sec_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_st_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_st_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_st_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z5_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z5_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z5_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z5_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address1_z4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline1_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline1_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline1_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_addressline2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_predir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_predir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_predir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_predir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_prim_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_postdir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_postdir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_postdir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_postdir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_unit_desig_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_sec_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_sec_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_sec_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_city_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_st_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_st_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_st_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z5_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z5_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z5_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z5_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address2_z4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdid_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdid_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdl_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdl_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdl_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bdl_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_did_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_did_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_did_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_did_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fein_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_fein_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fein_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fein_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_work_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_work_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_work_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_work_phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_initiated_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_executed_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_executed_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_charter_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_charter_number_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_charter_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_charter_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ucc_original_filing_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_address_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_address_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_address_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_domain_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_domain_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_domain_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_domain_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_process_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_process_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_process_id_WORDS_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_datetime_stamp_Invalid,le.orig_global_company_id_Invalid,le.orig_company_id_Invalid,le.orig_product_cd_Invalid,le.orig_method_Invalid,le.orig_vertical_Invalid,le.orig_function_name_Invalid,le.orig_transaction_type_Invalid,le.orig_login_history_id_Invalid,le.orig_job_id_Invalid,le.orig_sequence_number_Invalid,le.orig_first_name_Invalid,le.orig_middle_name_Invalid,le.orig_last_name_Invalid,le.orig_ssn_Invalid,le.orig_dob_Invalid,le.orig_dl_num_Invalid,le.orig_dl_state_Invalid,le.orig_address1_addressline1_Invalid,le.orig_address1_addressline2_Invalid,le.orig_address1_prim_range_Invalid,le.orig_address1_predir_Invalid,le.orig_address1_prim_name_Invalid,le.orig_address1_suffix_Invalid,le.orig_address1_postdir_Invalid,le.orig_address1_unit_desig_Invalid,le.orig_address1_sec_range_Invalid,le.orig_address1_city_Invalid,le.orig_address1_st_Invalid,le.orig_address1_z5_Invalid,le.orig_address1_z4_Invalid,le.orig_address2_addressline1_Invalid,le.orig_address2_addressline2_Invalid,le.orig_address2_prim_range_Invalid,le.orig_address2_predir_Invalid,le.orig_address2_prim_name_Invalid,le.orig_address2_suffix_Invalid,le.orig_address2_postdir_Invalid,le.orig_address2_unit_desig_Invalid,le.orig_address2_sec_range_Invalid,le.orig_address2_city_Invalid,le.orig_address2_st_Invalid,le.orig_address2_z5_Invalid,le.orig_address2_z4_Invalid,le.orig_bdid_Invalid,le.orig_bdl_Invalid,le.orig_did_Invalid,le.orig_company_name_Invalid,le.orig_fein_Invalid,le.orig_phone_Invalid,le.orig_work_phone_Invalid,le.orig_company_phone_Invalid,le.orig_reference_code_Invalid,le.orig_ip_address_initiated_Invalid,le.orig_ip_address_executed_Invalid,le.orig_charter_number_Invalid,le.orig_ucc_original_filing_number_Invalid,le.orig_email_address_Invalid,le.orig_domain_name_Invalid,le.orig_full_name_Invalid,le.orig_dl_purpose_Invalid,le.orig_glb_purpose_Invalid,le.orig_fcra_purpose_Invalid,le.orig_process_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_datetime_stamp(le.orig_datetime_stamp_Invalid),Fields.InvalidMessage_orig_global_company_id(le.orig_global_company_id_Invalid),Fields.InvalidMessage_orig_company_id(le.orig_company_id_Invalid),Fields.InvalidMessage_orig_product_cd(le.orig_product_cd_Invalid),Fields.InvalidMessage_orig_method(le.orig_method_Invalid),Fields.InvalidMessage_orig_vertical(le.orig_vertical_Invalid),Fields.InvalidMessage_orig_function_name(le.orig_function_name_Invalid),Fields.InvalidMessage_orig_transaction_type(le.orig_transaction_type_Invalid),Fields.InvalidMessage_orig_login_history_id(le.orig_login_history_id_Invalid),Fields.InvalidMessage_orig_job_id(le.orig_job_id_Invalid),Fields.InvalidMessage_orig_sequence_number(le.orig_sequence_number_Invalid),Fields.InvalidMessage_orig_first_name(le.orig_first_name_Invalid),Fields.InvalidMessage_orig_middle_name(le.orig_middle_name_Invalid),Fields.InvalidMessage_orig_last_name(le.orig_last_name_Invalid),Fields.InvalidMessage_orig_ssn(le.orig_ssn_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_dl_num(le.orig_dl_num_Invalid),Fields.InvalidMessage_orig_dl_state(le.orig_dl_state_Invalid),Fields.InvalidMessage_orig_address1_addressline1(le.orig_address1_addressline1_Invalid),Fields.InvalidMessage_orig_address1_addressline2(le.orig_address1_addressline2_Invalid),Fields.InvalidMessage_orig_address1_prim_range(le.orig_address1_prim_range_Invalid),Fields.InvalidMessage_orig_address1_predir(le.orig_address1_predir_Invalid),Fields.InvalidMessage_orig_address1_prim_name(le.orig_address1_prim_name_Invalid),Fields.InvalidMessage_orig_address1_suffix(le.orig_address1_suffix_Invalid),Fields.InvalidMessage_orig_address1_postdir(le.orig_address1_postdir_Invalid),Fields.InvalidMessage_orig_address1_unit_desig(le.orig_address1_unit_desig_Invalid),Fields.InvalidMessage_orig_address1_sec_range(le.orig_address1_sec_range_Invalid),Fields.InvalidMessage_orig_address1_city(le.orig_address1_city_Invalid),Fields.InvalidMessage_orig_address1_st(le.orig_address1_st_Invalid),Fields.InvalidMessage_orig_address1_z5(le.orig_address1_z5_Invalid),Fields.InvalidMessage_orig_address1_z4(le.orig_address1_z4_Invalid),Fields.InvalidMessage_orig_address2_addressline1(le.orig_address2_addressline1_Invalid),Fields.InvalidMessage_orig_address2_addressline2(le.orig_address2_addressline2_Invalid),Fields.InvalidMessage_orig_address2_prim_range(le.orig_address2_prim_range_Invalid),Fields.InvalidMessage_orig_address2_predir(le.orig_address2_predir_Invalid),Fields.InvalidMessage_orig_address2_prim_name(le.orig_address2_prim_name_Invalid),Fields.InvalidMessage_orig_address2_suffix(le.orig_address2_suffix_Invalid),Fields.InvalidMessage_orig_address2_postdir(le.orig_address2_postdir_Invalid),Fields.InvalidMessage_orig_address2_unit_desig(le.orig_address2_unit_desig_Invalid),Fields.InvalidMessage_orig_address2_sec_range(le.orig_address2_sec_range_Invalid),Fields.InvalidMessage_orig_address2_city(le.orig_address2_city_Invalid),Fields.InvalidMessage_orig_address2_st(le.orig_address2_st_Invalid),Fields.InvalidMessage_orig_address2_z5(le.orig_address2_z5_Invalid),Fields.InvalidMessage_orig_address2_z4(le.orig_address2_z4_Invalid),Fields.InvalidMessage_orig_bdid(le.orig_bdid_Invalid),Fields.InvalidMessage_orig_bdl(le.orig_bdl_Invalid),Fields.InvalidMessage_orig_did(le.orig_did_Invalid),Fields.InvalidMessage_orig_company_name(le.orig_company_name_Invalid),Fields.InvalidMessage_orig_fein(le.orig_fein_Invalid),Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_orig_work_phone(le.orig_work_phone_Invalid),Fields.InvalidMessage_orig_company_phone(le.orig_company_phone_Invalid),Fields.InvalidMessage_orig_reference_code(le.orig_reference_code_Invalid),Fields.InvalidMessage_orig_ip_address_initiated(le.orig_ip_address_initiated_Invalid),Fields.InvalidMessage_orig_ip_address_executed(le.orig_ip_address_executed_Invalid),Fields.InvalidMessage_orig_charter_number(le.orig_charter_number_Invalid),Fields.InvalidMessage_orig_ucc_original_filing_number(le.orig_ucc_original_filing_number_Invalid),Fields.InvalidMessage_orig_email_address(le.orig_email_address_Invalid),Fields.InvalidMessage_orig_domain_name(le.orig_domain_name_Invalid),Fields.InvalidMessage_orig_full_name(le.orig_full_name_Invalid),Fields.InvalidMessage_orig_dl_purpose(le.orig_dl_purpose_Invalid),Fields.InvalidMessage_orig_glb_purpose(le.orig_glb_purpose_Invalid),Fields.InvalidMessage_orig_fcra_purpose(le.orig_fcra_purpose_Invalid),Fields.InvalidMessage_orig_process_id(le.orig_process_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_datetime_stamp_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_global_company_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_company_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_product_cd_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_method_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_vertical_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_function_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_transaction_type_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_login_history_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_job_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_sequence_number_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_first_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_middle_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_last_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dl_num_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dl_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_addressline1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address1_addressline2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address1_prim_range_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_predir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address1_suffix_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_postdir_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_unit_desig_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_sec_range_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_city_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_st_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_z5_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address1_z4_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_addressline1_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_addressline2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_predir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_postdir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_city_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_st_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_z5_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address2_z4_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_bdid_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_bdl_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_did_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_company_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fein_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_work_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_company_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_reference_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ip_address_initiated_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ip_address_executed_Invalid,'LEFTTRIM','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_charter_number_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ucc_original_filing_number_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_email_address_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_domain_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_full_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dl_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_glb_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fcra_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_process_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.orig_datetime_stamp,(SALT39.StrType)le.orig_global_company_id,(SALT39.StrType)le.orig_company_id,(SALT39.StrType)le.orig_product_cd,(SALT39.StrType)le.orig_method,(SALT39.StrType)le.orig_vertical,(SALT39.StrType)le.orig_function_name,(SALT39.StrType)le.orig_transaction_type,(SALT39.StrType)le.orig_login_history_id,(SALT39.StrType)le.orig_job_id,(SALT39.StrType)le.orig_sequence_number,(SALT39.StrType)le.orig_first_name,(SALT39.StrType)le.orig_middle_name,(SALT39.StrType)le.orig_last_name,(SALT39.StrType)le.orig_ssn,(SALT39.StrType)le.orig_dob,(SALT39.StrType)le.orig_dl_num,(SALT39.StrType)le.orig_dl_state,(SALT39.StrType)le.orig_address1_addressline1,(SALT39.StrType)le.orig_address1_addressline2,(SALT39.StrType)le.orig_address1_prim_range,(SALT39.StrType)le.orig_address1_predir,(SALT39.StrType)le.orig_address1_prim_name,(SALT39.StrType)le.orig_address1_suffix,(SALT39.StrType)le.orig_address1_postdir,(SALT39.StrType)le.orig_address1_unit_desig,(SALT39.StrType)le.orig_address1_sec_range,(SALT39.StrType)le.orig_address1_city,(SALT39.StrType)le.orig_address1_st,(SALT39.StrType)le.orig_address1_z5,(SALT39.StrType)le.orig_address1_z4,(SALT39.StrType)le.orig_address2_addressline1,(SALT39.StrType)le.orig_address2_addressline2,(SALT39.StrType)le.orig_address2_prim_range,(SALT39.StrType)le.orig_address2_predir,(SALT39.StrType)le.orig_address2_prim_name,(SALT39.StrType)le.orig_address2_suffix,(SALT39.StrType)le.orig_address2_postdir,(SALT39.StrType)le.orig_address2_unit_desig,(SALT39.StrType)le.orig_address2_sec_range,(SALT39.StrType)le.orig_address2_city,(SALT39.StrType)le.orig_address2_st,(SALT39.StrType)le.orig_address2_z5,(SALT39.StrType)le.orig_address2_z4,(SALT39.StrType)le.orig_bdid,(SALT39.StrType)le.orig_bdl,(SALT39.StrType)le.orig_did,(SALT39.StrType)le.orig_company_name,(SALT39.StrType)le.orig_fein,(SALT39.StrType)le.orig_phone,(SALT39.StrType)le.orig_work_phone,(SALT39.StrType)le.orig_company_phone,(SALT39.StrType)le.orig_reference_code,(SALT39.StrType)le.orig_ip_address_initiated,(SALT39.StrType)le.orig_ip_address_executed,(SALT39.StrType)le.orig_charter_number,(SALT39.StrType)le.orig_ucc_original_filing_number,(SALT39.StrType)le.orig_email_address,(SALT39.StrType)le.orig_domain_name,(SALT39.StrType)le.orig_full_name,(SALT39.StrType)le.orig_dl_purpose,(SALT39.StrType)le.orig_glb_purpose,(SALT39.StrType)le.orig_fcra_purpose,(SALT39.StrType)le.orig_process_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,64,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_FILE) prevDS = DATASET([], Layout_FILE), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_datetime_stamp:orig_datetime_stamp:LEFTTRIM','orig_datetime_stamp:orig_datetime_stamp:ALLOW','orig_datetime_stamp:orig_datetime_stamp:WORDS'
          ,'orig_global_company_id:orig_global_company_id:LEFTTRIM','orig_global_company_id:orig_global_company_id:ALLOW','orig_global_company_id:orig_global_company_id:WORDS'
          ,'orig_company_id:orig_company_id:LEFTTRIM','orig_company_id:orig_company_id:ALLOW','orig_company_id:orig_company_id:WORDS'
          ,'orig_product_cd:orig_product_cd:LEFTTRIM','orig_product_cd:orig_product_cd:ALLOW','orig_product_cd:orig_product_cd:LENGTHS','orig_product_cd:orig_product_cd:WORDS'
          ,'orig_method:orig_method:LEFTTRIM','orig_method:orig_method:ALLOW','orig_method:orig_method:LENGTHS','orig_method:orig_method:WORDS'
          ,'orig_vertical:orig_vertical:LEFTTRIM','orig_vertical:orig_vertical:ALLOW','orig_vertical:orig_vertical:LENGTHS','orig_vertical:orig_vertical:WORDS'
          ,'orig_function_name:orig_function_name:LEFTTRIM','orig_function_name:orig_function_name:ALLOW','orig_function_name:orig_function_name:WORDS'
          ,'orig_transaction_type:orig_transaction_type:LEFTTRIM','orig_transaction_type:orig_transaction_type:ALLOW','orig_transaction_type:orig_transaction_type:LENGTHS','orig_transaction_type:orig_transaction_type:WORDS'
          ,'orig_login_history_id:orig_login_history_id:LEFTTRIM','orig_login_history_id:orig_login_history_id:ALLOW','orig_login_history_id:orig_login_history_id:LENGTHS','orig_login_history_id:orig_login_history_id:WORDS'
          ,'orig_job_id:orig_job_id:LEFTTRIM','orig_job_id:orig_job_id:ALLOW','orig_job_id:orig_job_id:WORDS'
          ,'orig_sequence_number:orig_sequence_number:LEFTTRIM','orig_sequence_number:orig_sequence_number:ALLOW','orig_sequence_number:orig_sequence_number:WORDS'
          ,'orig_first_name:orig_first_name:ALLOW','orig_first_name:orig_first_name:WORDS'
          ,'orig_middle_name:orig_middle_name:ALLOW','orig_middle_name:orig_middle_name:WORDS'
          ,'orig_last_name:orig_last_name:ALLOW','orig_last_name:orig_last_name:WORDS'
          ,'orig_ssn:orig_ssn:LEFTTRIM','orig_ssn:orig_ssn:ALLOW','orig_ssn:orig_ssn:LENGTHS','orig_ssn:orig_ssn:WORDS'
          ,'orig_dob:orig_dob:LEFTTRIM','orig_dob:orig_dob:ALLOW','orig_dob:orig_dob:LENGTHS','orig_dob:orig_dob:WORDS'
          ,'orig_dl_num:orig_dl_num:LEFTTRIM','orig_dl_num:orig_dl_num:ALLOW','orig_dl_num:orig_dl_num:LENGTHS','orig_dl_num:orig_dl_num:WORDS'
          ,'orig_dl_state:orig_dl_state:LEFTTRIM','orig_dl_state:orig_dl_state:ALLOW','orig_dl_state:orig_dl_state:LENGTHS','orig_dl_state:orig_dl_state:WORDS'
          ,'orig_address1_addressline1:orig_address1_addressline1:ALLOW'
          ,'orig_address1_addressline2:orig_address1_addressline2:LEFTTRIM','orig_address1_addressline2:orig_address1_addressline2:ALLOW'
          ,'orig_address1_prim_range:orig_address1_prim_range:ALLOW','orig_address1_prim_range:orig_address1_prim_range:WORDS'
          ,'orig_address1_predir:orig_address1_predir:LEFTTRIM','orig_address1_predir:orig_address1_predir:ALLOW','orig_address1_predir:orig_address1_predir:LENGTHS','orig_address1_predir:orig_address1_predir:WORDS'
          ,'orig_address1_prim_name:orig_address1_prim_name:ALLOW'
          ,'orig_address1_suffix:orig_address1_suffix:ALLOW','orig_address1_suffix:orig_address1_suffix:WORDS'
          ,'orig_address1_postdir:orig_address1_postdir:LEFTTRIM','orig_address1_postdir:orig_address1_postdir:ALLOW','orig_address1_postdir:orig_address1_postdir:WORDS'
          ,'orig_address1_unit_desig:orig_address1_unit_desig:LEFTTRIM','orig_address1_unit_desig:orig_address1_unit_desig:ALLOW','orig_address1_unit_desig:orig_address1_unit_desig:WORDS'
          ,'orig_address1_sec_range:orig_address1_sec_range:LEFTTRIM','orig_address1_sec_range:orig_address1_sec_range:ALLOW','orig_address1_sec_range:orig_address1_sec_range:WORDS'
          ,'orig_address1_city:orig_address1_city:LEFTTRIM','orig_address1_city:orig_address1_city:ALLOW','orig_address1_city:orig_address1_city:WORDS'
          ,'orig_address1_st:orig_address1_st:LEFTTRIM','orig_address1_st:orig_address1_st:ALLOW','orig_address1_st:orig_address1_st:LENGTHS','orig_address1_st:orig_address1_st:WORDS'
          ,'orig_address1_z5:orig_address1_z5:LEFTTRIM','orig_address1_z5:orig_address1_z5:ALLOW','orig_address1_z5:orig_address1_z5:LENGTHS','orig_address1_z5:orig_address1_z5:WORDS'
          ,'orig_address1_z4:orig_address1_z4:LEFTTRIM','orig_address1_z4:orig_address1_z4:ALLOW','orig_address1_z4:orig_address1_z4:LENGTHS','orig_address1_z4:orig_address1_z4:WORDS'
          ,'orig_address2_addressline1:orig_address2_addressline1:LEFTTRIM','orig_address2_addressline1:orig_address2_addressline1:ALLOW','orig_address2_addressline1:orig_address2_addressline1:LENGTHS','orig_address2_addressline1:orig_address2_addressline1:WORDS'
          ,'orig_address2_addressline2:orig_address2_addressline2:LEFTTRIM','orig_address2_addressline2:orig_address2_addressline2:ALLOW','orig_address2_addressline2:orig_address2_addressline2:LENGTHS','orig_address2_addressline2:orig_address2_addressline2:WORDS'
          ,'orig_address2_prim_range:orig_address2_prim_range:LEFTTRIM','orig_address2_prim_range:orig_address2_prim_range:ALLOW','orig_address2_prim_range:orig_address2_prim_range:LENGTHS','orig_address2_prim_range:orig_address2_prim_range:WORDS'
          ,'orig_address2_predir:orig_address2_predir:LEFTTRIM','orig_address2_predir:orig_address2_predir:ALLOW','orig_address2_predir:orig_address2_predir:LENGTHS','orig_address2_predir:orig_address2_predir:WORDS'
          ,'orig_address2_prim_name:orig_address2_prim_name:LEFTTRIM','orig_address2_prim_name:orig_address2_prim_name:ALLOW','orig_address2_prim_name:orig_address2_prim_name:LENGTHS','orig_address2_prim_name:orig_address2_prim_name:WORDS'
          ,'orig_address2_suffix:orig_address2_suffix:LEFTTRIM','orig_address2_suffix:orig_address2_suffix:ALLOW','orig_address2_suffix:orig_address2_suffix:LENGTHS','orig_address2_suffix:orig_address2_suffix:WORDS'
          ,'orig_address2_postdir:orig_address2_postdir:LEFTTRIM','orig_address2_postdir:orig_address2_postdir:ALLOW','orig_address2_postdir:orig_address2_postdir:LENGTHS','orig_address2_postdir:orig_address2_postdir:WORDS'
          ,'orig_address2_unit_desig:orig_address2_unit_desig:LEFTTRIM','orig_address2_unit_desig:orig_address2_unit_desig:ALLOW','orig_address2_unit_desig:orig_address2_unit_desig:LENGTHS','orig_address2_unit_desig:orig_address2_unit_desig:WORDS'
          ,'orig_address2_sec_range:orig_address2_sec_range:LEFTTRIM','orig_address2_sec_range:orig_address2_sec_range:ALLOW','orig_address2_sec_range:orig_address2_sec_range:LENGTHS','orig_address2_sec_range:orig_address2_sec_range:WORDS'
          ,'orig_address2_city:orig_address2_city:LEFTTRIM','orig_address2_city:orig_address2_city:ALLOW','orig_address2_city:orig_address2_city:LENGTHS','orig_address2_city:orig_address2_city:WORDS'
          ,'orig_address2_st:orig_address2_st:LEFTTRIM','orig_address2_st:orig_address2_st:ALLOW','orig_address2_st:orig_address2_st:LENGTHS','orig_address2_st:orig_address2_st:WORDS'
          ,'orig_address2_z5:orig_address2_z5:LEFTTRIM','orig_address2_z5:orig_address2_z5:ALLOW','orig_address2_z5:orig_address2_z5:LENGTHS','orig_address2_z5:orig_address2_z5:WORDS'
          ,'orig_address2_z4:orig_address2_z4:LEFTTRIM','orig_address2_z4:orig_address2_z4:ALLOW','orig_address2_z4:orig_address2_z4:LENGTHS','orig_address2_z4:orig_address2_z4:WORDS'
          ,'orig_bdid:orig_bdid:LEFTTRIM','orig_bdid:orig_bdid:ALLOW','orig_bdid:orig_bdid:LENGTHS','orig_bdid:orig_bdid:WORDS'
          ,'orig_bdl:orig_bdl:LEFTTRIM','orig_bdl:orig_bdl:ALLOW','orig_bdl:orig_bdl:LENGTHS','orig_bdl:orig_bdl:WORDS'
          ,'orig_did:orig_did:LEFTTRIM','orig_did:orig_did:ALLOW','orig_did:orig_did:LENGTHS','orig_did:orig_did:WORDS'
          ,'orig_company_name:orig_company_name:LEFTTRIM','orig_company_name:orig_company_name:ALLOW','orig_company_name:orig_company_name:LENGTHS','orig_company_name:orig_company_name:WORDS'
          ,'orig_fein:orig_fein:LEFTTRIM','orig_fein:orig_fein:ALLOW','orig_fein:orig_fein:LENGTHS','orig_fein:orig_fein:WORDS'
          ,'orig_phone:orig_phone:LEFTTRIM','orig_phone:orig_phone:ALLOW','orig_phone:orig_phone:LENGTHS','orig_phone:orig_phone:WORDS'
          ,'orig_work_phone:orig_work_phone:LEFTTRIM','orig_work_phone:orig_work_phone:ALLOW','orig_work_phone:orig_work_phone:LENGTHS','orig_work_phone:orig_work_phone:WORDS'
          ,'orig_company_phone:orig_company_phone:LEFTTRIM','orig_company_phone:orig_company_phone:ALLOW','orig_company_phone:orig_company_phone:LENGTHS','orig_company_phone:orig_company_phone:WORDS'
          ,'orig_reference_code:orig_reference_code:LEFTTRIM','orig_reference_code:orig_reference_code:ALLOW','orig_reference_code:orig_reference_code:LENGTHS','orig_reference_code:orig_reference_code:WORDS'
          ,'orig_ip_address_initiated:orig_ip_address_initiated:LEFTTRIM','orig_ip_address_initiated:orig_ip_address_initiated:ALLOW','orig_ip_address_initiated:orig_ip_address_initiated:LENGTHS','orig_ip_address_initiated:orig_ip_address_initiated:WORDS'
          ,'orig_ip_address_executed:orig_ip_address_executed:LEFTTRIM','orig_ip_address_executed:orig_ip_address_executed:WORDS'
          ,'orig_charter_number:orig_charter_number:LEFTTRIM','orig_charter_number:orig_charter_number:ALLOW','orig_charter_number:orig_charter_number:LENGTHS','orig_charter_number:orig_charter_number:WORDS'
          ,'orig_ucc_original_filing_number:orig_ucc_original_filing_number:LEFTTRIM','orig_ucc_original_filing_number:orig_ucc_original_filing_number:ALLOW','orig_ucc_original_filing_number:orig_ucc_original_filing_number:LENGTHS','orig_ucc_original_filing_number:orig_ucc_original_filing_number:WORDS'
          ,'orig_email_address:orig_email_address:LEFTTRIM','orig_email_address:orig_email_address:ALLOW','orig_email_address:orig_email_address:LENGTHS','orig_email_address:orig_email_address:WORDS'
          ,'orig_domain_name:orig_domain_name:LEFTTRIM','orig_domain_name:orig_domain_name:ALLOW','orig_domain_name:orig_domain_name:LENGTHS','orig_domain_name:orig_domain_name:WORDS'
          ,'orig_full_name:orig_full_name:LEFTTRIM','orig_full_name:orig_full_name:ALLOW','orig_full_name:orig_full_name:LENGTHS','orig_full_name:orig_full_name:WORDS'
          ,'orig_dl_purpose:orig_dl_purpose:LEFTTRIM','orig_dl_purpose:orig_dl_purpose:ALLOW','orig_dl_purpose:orig_dl_purpose:LENGTHS','orig_dl_purpose:orig_dl_purpose:WORDS'
          ,'orig_glb_purpose:orig_glb_purpose:LEFTTRIM','orig_glb_purpose:orig_glb_purpose:ALLOW','orig_glb_purpose:orig_glb_purpose:LENGTHS','orig_glb_purpose:orig_glb_purpose:WORDS'
          ,'orig_fcra_purpose:orig_fcra_purpose:LEFTTRIM','orig_fcra_purpose:orig_fcra_purpose:ALLOW','orig_fcra_purpose:orig_fcra_purpose:LENGTHS','orig_fcra_purpose:orig_fcra_purpose:WORDS'
          ,'orig_process_id:orig_process_id:LEFTTRIM','orig_process_id:orig_process_id:ALLOW','orig_process_id:orig_process_id:WORDS'
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
          ,Fields.InvalidMessage_orig_datetime_stamp(1),Fields.InvalidMessage_orig_datetime_stamp(2),Fields.InvalidMessage_orig_datetime_stamp(3)
          ,Fields.InvalidMessage_orig_global_company_id(1),Fields.InvalidMessage_orig_global_company_id(2),Fields.InvalidMessage_orig_global_company_id(3)
          ,Fields.InvalidMessage_orig_company_id(1),Fields.InvalidMessage_orig_company_id(2),Fields.InvalidMessage_orig_company_id(3)
          ,Fields.InvalidMessage_orig_product_cd(1),Fields.InvalidMessage_orig_product_cd(2),Fields.InvalidMessage_orig_product_cd(3),Fields.InvalidMessage_orig_product_cd(4)
          ,Fields.InvalidMessage_orig_method(1),Fields.InvalidMessage_orig_method(2),Fields.InvalidMessage_orig_method(3),Fields.InvalidMessage_orig_method(4)
          ,Fields.InvalidMessage_orig_vertical(1),Fields.InvalidMessage_orig_vertical(2),Fields.InvalidMessage_orig_vertical(3),Fields.InvalidMessage_orig_vertical(4)
          ,Fields.InvalidMessage_orig_function_name(1),Fields.InvalidMessage_orig_function_name(2),Fields.InvalidMessage_orig_function_name(3)
          ,Fields.InvalidMessage_orig_transaction_type(1),Fields.InvalidMessage_orig_transaction_type(2),Fields.InvalidMessage_orig_transaction_type(3),Fields.InvalidMessage_orig_transaction_type(4)
          ,Fields.InvalidMessage_orig_login_history_id(1),Fields.InvalidMessage_orig_login_history_id(2),Fields.InvalidMessage_orig_login_history_id(3),Fields.InvalidMessage_orig_login_history_id(4)
          ,Fields.InvalidMessage_orig_job_id(1),Fields.InvalidMessage_orig_job_id(2),Fields.InvalidMessage_orig_job_id(3)
          ,Fields.InvalidMessage_orig_sequence_number(1),Fields.InvalidMessage_orig_sequence_number(2),Fields.InvalidMessage_orig_sequence_number(3)
          ,Fields.InvalidMessage_orig_first_name(1),Fields.InvalidMessage_orig_first_name(2)
          ,Fields.InvalidMessage_orig_middle_name(1),Fields.InvalidMessage_orig_middle_name(2)
          ,Fields.InvalidMessage_orig_last_name(1),Fields.InvalidMessage_orig_last_name(2)
          ,Fields.InvalidMessage_orig_ssn(1),Fields.InvalidMessage_orig_ssn(2),Fields.InvalidMessage_orig_ssn(3),Fields.InvalidMessage_orig_ssn(4)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2),Fields.InvalidMessage_orig_dob(3),Fields.InvalidMessage_orig_dob(4)
          ,Fields.InvalidMessage_orig_dl_num(1),Fields.InvalidMessage_orig_dl_num(2),Fields.InvalidMessage_orig_dl_num(3),Fields.InvalidMessage_orig_dl_num(4)
          ,Fields.InvalidMessage_orig_dl_state(1),Fields.InvalidMessage_orig_dl_state(2),Fields.InvalidMessage_orig_dl_state(3),Fields.InvalidMessage_orig_dl_state(4)
          ,Fields.InvalidMessage_orig_address1_addressline1(1)
          ,Fields.InvalidMessage_orig_address1_addressline2(1),Fields.InvalidMessage_orig_address1_addressline2(2)
          ,Fields.InvalidMessage_orig_address1_prim_range(1),Fields.InvalidMessage_orig_address1_prim_range(2)
          ,Fields.InvalidMessage_orig_address1_predir(1),Fields.InvalidMessage_orig_address1_predir(2),Fields.InvalidMessage_orig_address1_predir(3),Fields.InvalidMessage_orig_address1_predir(4)
          ,Fields.InvalidMessage_orig_address1_prim_name(1)
          ,Fields.InvalidMessage_orig_address1_suffix(1),Fields.InvalidMessage_orig_address1_suffix(2)
          ,Fields.InvalidMessage_orig_address1_postdir(1),Fields.InvalidMessage_orig_address1_postdir(2),Fields.InvalidMessage_orig_address1_postdir(3)
          ,Fields.InvalidMessage_orig_address1_unit_desig(1),Fields.InvalidMessage_orig_address1_unit_desig(2),Fields.InvalidMessage_orig_address1_unit_desig(3)
          ,Fields.InvalidMessage_orig_address1_sec_range(1),Fields.InvalidMessage_orig_address1_sec_range(2),Fields.InvalidMessage_orig_address1_sec_range(3)
          ,Fields.InvalidMessage_orig_address1_city(1),Fields.InvalidMessage_orig_address1_city(2),Fields.InvalidMessage_orig_address1_city(3)
          ,Fields.InvalidMessage_orig_address1_st(1),Fields.InvalidMessage_orig_address1_st(2),Fields.InvalidMessage_orig_address1_st(3),Fields.InvalidMessage_orig_address1_st(4)
          ,Fields.InvalidMessage_orig_address1_z5(1),Fields.InvalidMessage_orig_address1_z5(2),Fields.InvalidMessage_orig_address1_z5(3),Fields.InvalidMessage_orig_address1_z5(4)
          ,Fields.InvalidMessage_orig_address1_z4(1),Fields.InvalidMessage_orig_address1_z4(2),Fields.InvalidMessage_orig_address1_z4(3),Fields.InvalidMessage_orig_address1_z4(4)
          ,Fields.InvalidMessage_orig_address2_addressline1(1),Fields.InvalidMessage_orig_address2_addressline1(2),Fields.InvalidMessage_orig_address2_addressline1(3),Fields.InvalidMessage_orig_address2_addressline1(4)
          ,Fields.InvalidMessage_orig_address2_addressline2(1),Fields.InvalidMessage_orig_address2_addressline2(2),Fields.InvalidMessage_orig_address2_addressline2(3),Fields.InvalidMessage_orig_address2_addressline2(4)
          ,Fields.InvalidMessage_orig_address2_prim_range(1),Fields.InvalidMessage_orig_address2_prim_range(2),Fields.InvalidMessage_orig_address2_prim_range(3),Fields.InvalidMessage_orig_address2_prim_range(4)
          ,Fields.InvalidMessage_orig_address2_predir(1),Fields.InvalidMessage_orig_address2_predir(2),Fields.InvalidMessage_orig_address2_predir(3),Fields.InvalidMessage_orig_address2_predir(4)
          ,Fields.InvalidMessage_orig_address2_prim_name(1),Fields.InvalidMessage_orig_address2_prim_name(2),Fields.InvalidMessage_orig_address2_prim_name(3),Fields.InvalidMessage_orig_address2_prim_name(4)
          ,Fields.InvalidMessage_orig_address2_suffix(1),Fields.InvalidMessage_orig_address2_suffix(2),Fields.InvalidMessage_orig_address2_suffix(3),Fields.InvalidMessage_orig_address2_suffix(4)
          ,Fields.InvalidMessage_orig_address2_postdir(1),Fields.InvalidMessage_orig_address2_postdir(2),Fields.InvalidMessage_orig_address2_postdir(3),Fields.InvalidMessage_orig_address2_postdir(4)
          ,Fields.InvalidMessage_orig_address2_unit_desig(1),Fields.InvalidMessage_orig_address2_unit_desig(2),Fields.InvalidMessage_orig_address2_unit_desig(3),Fields.InvalidMessage_orig_address2_unit_desig(4)
          ,Fields.InvalidMessage_orig_address2_sec_range(1),Fields.InvalidMessage_orig_address2_sec_range(2),Fields.InvalidMessage_orig_address2_sec_range(3),Fields.InvalidMessage_orig_address2_sec_range(4)
          ,Fields.InvalidMessage_orig_address2_city(1),Fields.InvalidMessage_orig_address2_city(2),Fields.InvalidMessage_orig_address2_city(3),Fields.InvalidMessage_orig_address2_city(4)
          ,Fields.InvalidMessage_orig_address2_st(1),Fields.InvalidMessage_orig_address2_st(2),Fields.InvalidMessage_orig_address2_st(3),Fields.InvalidMessage_orig_address2_st(4)
          ,Fields.InvalidMessage_orig_address2_z5(1),Fields.InvalidMessage_orig_address2_z5(2),Fields.InvalidMessage_orig_address2_z5(3),Fields.InvalidMessage_orig_address2_z5(4)
          ,Fields.InvalidMessage_orig_address2_z4(1),Fields.InvalidMessage_orig_address2_z4(2),Fields.InvalidMessage_orig_address2_z4(3),Fields.InvalidMessage_orig_address2_z4(4)
          ,Fields.InvalidMessage_orig_bdid(1),Fields.InvalidMessage_orig_bdid(2),Fields.InvalidMessage_orig_bdid(3),Fields.InvalidMessage_orig_bdid(4)
          ,Fields.InvalidMessage_orig_bdl(1),Fields.InvalidMessage_orig_bdl(2),Fields.InvalidMessage_orig_bdl(3),Fields.InvalidMessage_orig_bdl(4)
          ,Fields.InvalidMessage_orig_did(1),Fields.InvalidMessage_orig_did(2),Fields.InvalidMessage_orig_did(3),Fields.InvalidMessage_orig_did(4)
          ,Fields.InvalidMessage_orig_company_name(1),Fields.InvalidMessage_orig_company_name(2),Fields.InvalidMessage_orig_company_name(3),Fields.InvalidMessage_orig_company_name(4)
          ,Fields.InvalidMessage_orig_fein(1),Fields.InvalidMessage_orig_fein(2),Fields.InvalidMessage_orig_fein(3),Fields.InvalidMessage_orig_fein(4)
          ,Fields.InvalidMessage_orig_phone(1),Fields.InvalidMessage_orig_phone(2),Fields.InvalidMessage_orig_phone(3),Fields.InvalidMessage_orig_phone(4)
          ,Fields.InvalidMessage_orig_work_phone(1),Fields.InvalidMessage_orig_work_phone(2),Fields.InvalidMessage_orig_work_phone(3),Fields.InvalidMessage_orig_work_phone(4)
          ,Fields.InvalidMessage_orig_company_phone(1),Fields.InvalidMessage_orig_company_phone(2),Fields.InvalidMessage_orig_company_phone(3),Fields.InvalidMessage_orig_company_phone(4)
          ,Fields.InvalidMessage_orig_reference_code(1),Fields.InvalidMessage_orig_reference_code(2),Fields.InvalidMessage_orig_reference_code(3),Fields.InvalidMessage_orig_reference_code(4)
          ,Fields.InvalidMessage_orig_ip_address_initiated(1),Fields.InvalidMessage_orig_ip_address_initiated(2),Fields.InvalidMessage_orig_ip_address_initiated(3),Fields.InvalidMessage_orig_ip_address_initiated(4)
          ,Fields.InvalidMessage_orig_ip_address_executed(1),Fields.InvalidMessage_orig_ip_address_executed(2)
          ,Fields.InvalidMessage_orig_charter_number(1),Fields.InvalidMessage_orig_charter_number(2),Fields.InvalidMessage_orig_charter_number(3),Fields.InvalidMessage_orig_charter_number(4)
          ,Fields.InvalidMessage_orig_ucc_original_filing_number(1),Fields.InvalidMessage_orig_ucc_original_filing_number(2),Fields.InvalidMessage_orig_ucc_original_filing_number(3),Fields.InvalidMessage_orig_ucc_original_filing_number(4)
          ,Fields.InvalidMessage_orig_email_address(1),Fields.InvalidMessage_orig_email_address(2),Fields.InvalidMessage_orig_email_address(3),Fields.InvalidMessage_orig_email_address(4)
          ,Fields.InvalidMessage_orig_domain_name(1),Fields.InvalidMessage_orig_domain_name(2),Fields.InvalidMessage_orig_domain_name(3),Fields.InvalidMessage_orig_domain_name(4)
          ,Fields.InvalidMessage_orig_full_name(1),Fields.InvalidMessage_orig_full_name(2),Fields.InvalidMessage_orig_full_name(3),Fields.InvalidMessage_orig_full_name(4)
          ,Fields.InvalidMessage_orig_dl_purpose(1),Fields.InvalidMessage_orig_dl_purpose(2),Fields.InvalidMessage_orig_dl_purpose(3),Fields.InvalidMessage_orig_dl_purpose(4)
          ,Fields.InvalidMessage_orig_glb_purpose(1),Fields.InvalidMessage_orig_glb_purpose(2),Fields.InvalidMessage_orig_glb_purpose(3),Fields.InvalidMessage_orig_glb_purpose(4)
          ,Fields.InvalidMessage_orig_fcra_purpose(1),Fields.InvalidMessage_orig_fcra_purpose(2),Fields.InvalidMessage_orig_fcra_purpose(3),Fields.InvalidMessage_orig_fcra_purpose(4)
          ,Fields.InvalidMessage_orig_process_id(1),Fields.InvalidMessage_orig_process_id(2),Fields.InvalidMessage_orig_process_id(3)
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
          ,le.orig_datetime_stamp_LEFTTRIM_ErrorCount,le.orig_datetime_stamp_ALLOW_ErrorCount,le.orig_datetime_stamp_WORDS_ErrorCount
          ,le.orig_global_company_id_LEFTTRIM_ErrorCount,le.orig_global_company_id_ALLOW_ErrorCount,le.orig_global_company_id_WORDS_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_ALLOW_ErrorCount,le.orig_company_id_WORDS_ErrorCount
          ,le.orig_product_cd_LEFTTRIM_ErrorCount,le.orig_product_cd_ALLOW_ErrorCount,le.orig_product_cd_LENGTHS_ErrorCount,le.orig_product_cd_WORDS_ErrorCount
          ,le.orig_method_LEFTTRIM_ErrorCount,le.orig_method_ALLOW_ErrorCount,le.orig_method_LENGTHS_ErrorCount,le.orig_method_WORDS_ErrorCount
          ,le.orig_vertical_LEFTTRIM_ErrorCount,le.orig_vertical_ALLOW_ErrorCount,le.orig_vertical_LENGTHS_ErrorCount,le.orig_vertical_WORDS_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_transaction_type_LEFTTRIM_ErrorCount,le.orig_transaction_type_ALLOW_ErrorCount,le.orig_transaction_type_LENGTHS_ErrorCount,le.orig_transaction_type_WORDS_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_ALLOW_ErrorCount,le.orig_login_history_id_LENGTHS_ErrorCount,le.orig_login_history_id_WORDS_ErrorCount
          ,le.orig_job_id_LEFTTRIM_ErrorCount,le.orig_job_id_ALLOW_ErrorCount,le.orig_job_id_WORDS_ErrorCount
          ,le.orig_sequence_number_LEFTTRIM_ErrorCount,le.orig_sequence_number_ALLOW_ErrorCount,le.orig_sequence_number_WORDS_ErrorCount
          ,le.orig_first_name_ALLOW_ErrorCount,le.orig_first_name_WORDS_ErrorCount
          ,le.orig_middle_name_ALLOW_ErrorCount,le.orig_middle_name_WORDS_ErrorCount
          ,le.orig_last_name_ALLOW_ErrorCount,le.orig_last_name_WORDS_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_ALLOW_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_dl_num_LEFTTRIM_ErrorCount,le.orig_dl_num_ALLOW_ErrorCount,le.orig_dl_num_LENGTHS_ErrorCount,le.orig_dl_num_WORDS_ErrorCount
          ,le.orig_dl_state_LEFTTRIM_ErrorCount,le.orig_dl_state_ALLOW_ErrorCount,le.orig_dl_state_LENGTHS_ErrorCount,le.orig_dl_state_WORDS_ErrorCount
          ,le.orig_address1_addressline1_ALLOW_ErrorCount
          ,le.orig_address1_addressline2_LEFTTRIM_ErrorCount,le.orig_address1_addressline2_ALLOW_ErrorCount
          ,le.orig_address1_prim_range_ALLOW_ErrorCount,le.orig_address1_prim_range_WORDS_ErrorCount
          ,le.orig_address1_predir_LEFTTRIM_ErrorCount,le.orig_address1_predir_ALLOW_ErrorCount,le.orig_address1_predir_LENGTHS_ErrorCount,le.orig_address1_predir_WORDS_ErrorCount
          ,le.orig_address1_prim_name_ALLOW_ErrorCount
          ,le.orig_address1_suffix_ALLOW_ErrorCount,le.orig_address1_suffix_WORDS_ErrorCount
          ,le.orig_address1_postdir_LEFTTRIM_ErrorCount,le.orig_address1_postdir_ALLOW_ErrorCount,le.orig_address1_postdir_WORDS_ErrorCount
          ,le.orig_address1_unit_desig_LEFTTRIM_ErrorCount,le.orig_address1_unit_desig_ALLOW_ErrorCount,le.orig_address1_unit_desig_WORDS_ErrorCount
          ,le.orig_address1_sec_range_LEFTTRIM_ErrorCount,le.orig_address1_sec_range_ALLOW_ErrorCount,le.orig_address1_sec_range_WORDS_ErrorCount
          ,le.orig_address1_city_LEFTTRIM_ErrorCount,le.orig_address1_city_ALLOW_ErrorCount,le.orig_address1_city_WORDS_ErrorCount
          ,le.orig_address1_st_LEFTTRIM_ErrorCount,le.orig_address1_st_ALLOW_ErrorCount,le.orig_address1_st_LENGTHS_ErrorCount,le.orig_address1_st_WORDS_ErrorCount
          ,le.orig_address1_z5_LEFTTRIM_ErrorCount,le.orig_address1_z5_ALLOW_ErrorCount,le.orig_address1_z5_LENGTHS_ErrorCount,le.orig_address1_z5_WORDS_ErrorCount
          ,le.orig_address1_z4_LEFTTRIM_ErrorCount,le.orig_address1_z4_ALLOW_ErrorCount,le.orig_address1_z4_LENGTHS_ErrorCount,le.orig_address1_z4_WORDS_ErrorCount
          ,le.orig_address2_addressline1_LEFTTRIM_ErrorCount,le.orig_address2_addressline1_ALLOW_ErrorCount,le.orig_address2_addressline1_LENGTHS_ErrorCount,le.orig_address2_addressline1_WORDS_ErrorCount
          ,le.orig_address2_addressline2_LEFTTRIM_ErrorCount,le.orig_address2_addressline2_ALLOW_ErrorCount,le.orig_address2_addressline2_LENGTHS_ErrorCount,le.orig_address2_addressline2_WORDS_ErrorCount
          ,le.orig_address2_prim_range_LEFTTRIM_ErrorCount,le.orig_address2_prim_range_ALLOW_ErrorCount,le.orig_address2_prim_range_LENGTHS_ErrorCount,le.orig_address2_prim_range_WORDS_ErrorCount
          ,le.orig_address2_predir_LEFTTRIM_ErrorCount,le.orig_address2_predir_ALLOW_ErrorCount,le.orig_address2_predir_LENGTHS_ErrorCount,le.orig_address2_predir_WORDS_ErrorCount
          ,le.orig_address2_prim_name_LEFTTRIM_ErrorCount,le.orig_address2_prim_name_ALLOW_ErrorCount,le.orig_address2_prim_name_LENGTHS_ErrorCount,le.orig_address2_prim_name_WORDS_ErrorCount
          ,le.orig_address2_suffix_LEFTTRIM_ErrorCount,le.orig_address2_suffix_ALLOW_ErrorCount,le.orig_address2_suffix_LENGTHS_ErrorCount,le.orig_address2_suffix_WORDS_ErrorCount
          ,le.orig_address2_postdir_LEFTTRIM_ErrorCount,le.orig_address2_postdir_ALLOW_ErrorCount,le.orig_address2_postdir_LENGTHS_ErrorCount,le.orig_address2_postdir_WORDS_ErrorCount
          ,le.orig_address2_unit_desig_LEFTTRIM_ErrorCount,le.orig_address2_unit_desig_ALLOW_ErrorCount,le.orig_address2_unit_desig_LENGTHS_ErrorCount,le.orig_address2_unit_desig_WORDS_ErrorCount
          ,le.orig_address2_sec_range_LEFTTRIM_ErrorCount,le.orig_address2_sec_range_ALLOW_ErrorCount,le.orig_address2_sec_range_LENGTHS_ErrorCount,le.orig_address2_sec_range_WORDS_ErrorCount
          ,le.orig_address2_city_LEFTTRIM_ErrorCount,le.orig_address2_city_ALLOW_ErrorCount,le.orig_address2_city_LENGTHS_ErrorCount,le.orig_address2_city_WORDS_ErrorCount
          ,le.orig_address2_st_LEFTTRIM_ErrorCount,le.orig_address2_st_ALLOW_ErrorCount,le.orig_address2_st_LENGTHS_ErrorCount,le.orig_address2_st_WORDS_ErrorCount
          ,le.orig_address2_z5_LEFTTRIM_ErrorCount,le.orig_address2_z5_ALLOW_ErrorCount,le.orig_address2_z5_LENGTHS_ErrorCount,le.orig_address2_z5_WORDS_ErrorCount
          ,le.orig_address2_z4_LEFTTRIM_ErrorCount,le.orig_address2_z4_ALLOW_ErrorCount,le.orig_address2_z4_LENGTHS_ErrorCount,le.orig_address2_z4_WORDS_ErrorCount
          ,le.orig_bdid_LEFTTRIM_ErrorCount,le.orig_bdid_ALLOW_ErrorCount,le.orig_bdid_LENGTHS_ErrorCount,le.orig_bdid_WORDS_ErrorCount
          ,le.orig_bdl_LEFTTRIM_ErrorCount,le.orig_bdl_ALLOW_ErrorCount,le.orig_bdl_LENGTHS_ErrorCount,le.orig_bdl_WORDS_ErrorCount
          ,le.orig_did_LEFTTRIM_ErrorCount,le.orig_did_ALLOW_ErrorCount,le.orig_did_LENGTHS_ErrorCount,le.orig_did_WORDS_ErrorCount
          ,le.orig_company_name_LEFTTRIM_ErrorCount,le.orig_company_name_ALLOW_ErrorCount,le.orig_company_name_LENGTHS_ErrorCount,le.orig_company_name_WORDS_ErrorCount
          ,le.orig_fein_LEFTTRIM_ErrorCount,le.orig_fein_ALLOW_ErrorCount,le.orig_fein_LENGTHS_ErrorCount,le.orig_fein_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_work_phone_LEFTTRIM_ErrorCount,le.orig_work_phone_ALLOW_ErrorCount,le.orig_work_phone_LENGTHS_ErrorCount,le.orig_work_phone_WORDS_ErrorCount
          ,le.orig_company_phone_LEFTTRIM_ErrorCount,le.orig_company_phone_ALLOW_ErrorCount,le.orig_company_phone_LENGTHS_ErrorCount,le.orig_company_phone_WORDS_ErrorCount
          ,le.orig_reference_code_LEFTTRIM_ErrorCount,le.orig_reference_code_ALLOW_ErrorCount,le.orig_reference_code_LENGTHS_ErrorCount,le.orig_reference_code_WORDS_ErrorCount
          ,le.orig_ip_address_initiated_LEFTTRIM_ErrorCount,le.orig_ip_address_initiated_ALLOW_ErrorCount,le.orig_ip_address_initiated_LENGTHS_ErrorCount,le.orig_ip_address_initiated_WORDS_ErrorCount
          ,le.orig_ip_address_executed_LEFTTRIM_ErrorCount,le.orig_ip_address_executed_WORDS_ErrorCount
          ,le.orig_charter_number_LEFTTRIM_ErrorCount,le.orig_charter_number_ALLOW_ErrorCount,le.orig_charter_number_LENGTHS_ErrorCount,le.orig_charter_number_WORDS_ErrorCount
          ,le.orig_ucc_original_filing_number_LEFTTRIM_ErrorCount,le.orig_ucc_original_filing_number_ALLOW_ErrorCount,le.orig_ucc_original_filing_number_LENGTHS_ErrorCount,le.orig_ucc_original_filing_number_WORDS_ErrorCount
          ,le.orig_email_address_LEFTTRIM_ErrorCount,le.orig_email_address_ALLOW_ErrorCount,le.orig_email_address_LENGTHS_ErrorCount,le.orig_email_address_WORDS_ErrorCount
          ,le.orig_domain_name_LEFTTRIM_ErrorCount,le.orig_domain_name_ALLOW_ErrorCount,le.orig_domain_name_LENGTHS_ErrorCount,le.orig_domain_name_WORDS_ErrorCount
          ,le.orig_full_name_LEFTTRIM_ErrorCount,le.orig_full_name_ALLOW_ErrorCount,le.orig_full_name_LENGTHS_ErrorCount,le.orig_full_name_WORDS_ErrorCount
          ,le.orig_dl_purpose_LEFTTRIM_ErrorCount,le.orig_dl_purpose_ALLOW_ErrorCount,le.orig_dl_purpose_LENGTHS_ErrorCount,le.orig_dl_purpose_WORDS_ErrorCount
          ,le.orig_glb_purpose_LEFTTRIM_ErrorCount,le.orig_glb_purpose_ALLOW_ErrorCount,le.orig_glb_purpose_LENGTHS_ErrorCount,le.orig_glb_purpose_WORDS_ErrorCount
          ,le.orig_fcra_purpose_LEFTTRIM_ErrorCount,le.orig_fcra_purpose_ALLOW_ErrorCount,le.orig_fcra_purpose_LENGTHS_ErrorCount,le.orig_fcra_purpose_WORDS_ErrorCount
          ,le.orig_process_id_LEFTTRIM_ErrorCount,le.orig_process_id_ALLOW_ErrorCount,le.orig_process_id_WORDS_ErrorCount
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
          ,le.orig_datetime_stamp_LEFTTRIM_ErrorCount,le.orig_datetime_stamp_ALLOW_ErrorCount,le.orig_datetime_stamp_WORDS_ErrorCount
          ,le.orig_global_company_id_LEFTTRIM_ErrorCount,le.orig_global_company_id_ALLOW_ErrorCount,le.orig_global_company_id_WORDS_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_ALLOW_ErrorCount,le.orig_company_id_WORDS_ErrorCount
          ,le.orig_product_cd_LEFTTRIM_ErrorCount,le.orig_product_cd_ALLOW_ErrorCount,le.orig_product_cd_LENGTHS_ErrorCount,le.orig_product_cd_WORDS_ErrorCount
          ,le.orig_method_LEFTTRIM_ErrorCount,le.orig_method_ALLOW_ErrorCount,le.orig_method_LENGTHS_ErrorCount,le.orig_method_WORDS_ErrorCount
          ,le.orig_vertical_LEFTTRIM_ErrorCount,le.orig_vertical_ALLOW_ErrorCount,le.orig_vertical_LENGTHS_ErrorCount,le.orig_vertical_WORDS_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_transaction_type_LEFTTRIM_ErrorCount,le.orig_transaction_type_ALLOW_ErrorCount,le.orig_transaction_type_LENGTHS_ErrorCount,le.orig_transaction_type_WORDS_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_ALLOW_ErrorCount,le.orig_login_history_id_LENGTHS_ErrorCount,le.orig_login_history_id_WORDS_ErrorCount
          ,le.orig_job_id_LEFTTRIM_ErrorCount,le.orig_job_id_ALLOW_ErrorCount,le.orig_job_id_WORDS_ErrorCount
          ,le.orig_sequence_number_LEFTTRIM_ErrorCount,le.orig_sequence_number_ALLOW_ErrorCount,le.orig_sequence_number_WORDS_ErrorCount
          ,le.orig_first_name_ALLOW_ErrorCount,le.orig_first_name_WORDS_ErrorCount
          ,le.orig_middle_name_ALLOW_ErrorCount,le.orig_middle_name_WORDS_ErrorCount
          ,le.orig_last_name_ALLOW_ErrorCount,le.orig_last_name_WORDS_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_ALLOW_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_dl_num_LEFTTRIM_ErrorCount,le.orig_dl_num_ALLOW_ErrorCount,le.orig_dl_num_LENGTHS_ErrorCount,le.orig_dl_num_WORDS_ErrorCount
          ,le.orig_dl_state_LEFTTRIM_ErrorCount,le.orig_dl_state_ALLOW_ErrorCount,le.orig_dl_state_LENGTHS_ErrorCount,le.orig_dl_state_WORDS_ErrorCount
          ,le.orig_address1_addressline1_ALLOW_ErrorCount
          ,le.orig_address1_addressline2_LEFTTRIM_ErrorCount,le.orig_address1_addressline2_ALLOW_ErrorCount
          ,le.orig_address1_prim_range_ALLOW_ErrorCount,le.orig_address1_prim_range_WORDS_ErrorCount
          ,le.orig_address1_predir_LEFTTRIM_ErrorCount,le.orig_address1_predir_ALLOW_ErrorCount,le.orig_address1_predir_LENGTHS_ErrorCount,le.orig_address1_predir_WORDS_ErrorCount
          ,le.orig_address1_prim_name_ALLOW_ErrorCount
          ,le.orig_address1_suffix_ALLOW_ErrorCount,le.orig_address1_suffix_WORDS_ErrorCount
          ,le.orig_address1_postdir_LEFTTRIM_ErrorCount,le.orig_address1_postdir_ALLOW_ErrorCount,le.orig_address1_postdir_WORDS_ErrorCount
          ,le.orig_address1_unit_desig_LEFTTRIM_ErrorCount,le.orig_address1_unit_desig_ALLOW_ErrorCount,le.orig_address1_unit_desig_WORDS_ErrorCount
          ,le.orig_address1_sec_range_LEFTTRIM_ErrorCount,le.orig_address1_sec_range_ALLOW_ErrorCount,le.orig_address1_sec_range_WORDS_ErrorCount
          ,le.orig_address1_city_LEFTTRIM_ErrorCount,le.orig_address1_city_ALLOW_ErrorCount,le.orig_address1_city_WORDS_ErrorCount
          ,le.orig_address1_st_LEFTTRIM_ErrorCount,le.orig_address1_st_ALLOW_ErrorCount,le.orig_address1_st_LENGTHS_ErrorCount,le.orig_address1_st_WORDS_ErrorCount
          ,le.orig_address1_z5_LEFTTRIM_ErrorCount,le.orig_address1_z5_ALLOW_ErrorCount,le.orig_address1_z5_LENGTHS_ErrorCount,le.orig_address1_z5_WORDS_ErrorCount
          ,le.orig_address1_z4_LEFTTRIM_ErrorCount,le.orig_address1_z4_ALLOW_ErrorCount,le.orig_address1_z4_LENGTHS_ErrorCount,le.orig_address1_z4_WORDS_ErrorCount
          ,le.orig_address2_addressline1_LEFTTRIM_ErrorCount,le.orig_address2_addressline1_ALLOW_ErrorCount,le.orig_address2_addressline1_LENGTHS_ErrorCount,le.orig_address2_addressline1_WORDS_ErrorCount
          ,le.orig_address2_addressline2_LEFTTRIM_ErrorCount,le.orig_address2_addressline2_ALLOW_ErrorCount,le.orig_address2_addressline2_LENGTHS_ErrorCount,le.orig_address2_addressline2_WORDS_ErrorCount
          ,le.orig_address2_prim_range_LEFTTRIM_ErrorCount,le.orig_address2_prim_range_ALLOW_ErrorCount,le.orig_address2_prim_range_LENGTHS_ErrorCount,le.orig_address2_prim_range_WORDS_ErrorCount
          ,le.orig_address2_predir_LEFTTRIM_ErrorCount,le.orig_address2_predir_ALLOW_ErrorCount,le.orig_address2_predir_LENGTHS_ErrorCount,le.orig_address2_predir_WORDS_ErrorCount
          ,le.orig_address2_prim_name_LEFTTRIM_ErrorCount,le.orig_address2_prim_name_ALLOW_ErrorCount,le.orig_address2_prim_name_LENGTHS_ErrorCount,le.orig_address2_prim_name_WORDS_ErrorCount
          ,le.orig_address2_suffix_LEFTTRIM_ErrorCount,le.orig_address2_suffix_ALLOW_ErrorCount,le.orig_address2_suffix_LENGTHS_ErrorCount,le.orig_address2_suffix_WORDS_ErrorCount
          ,le.orig_address2_postdir_LEFTTRIM_ErrorCount,le.orig_address2_postdir_ALLOW_ErrorCount,le.orig_address2_postdir_LENGTHS_ErrorCount,le.orig_address2_postdir_WORDS_ErrorCount
          ,le.orig_address2_unit_desig_LEFTTRIM_ErrorCount,le.orig_address2_unit_desig_ALLOW_ErrorCount,le.orig_address2_unit_desig_LENGTHS_ErrorCount,le.orig_address2_unit_desig_WORDS_ErrorCount
          ,le.orig_address2_sec_range_LEFTTRIM_ErrorCount,le.orig_address2_sec_range_ALLOW_ErrorCount,le.orig_address2_sec_range_LENGTHS_ErrorCount,le.orig_address2_sec_range_WORDS_ErrorCount
          ,le.orig_address2_city_LEFTTRIM_ErrorCount,le.orig_address2_city_ALLOW_ErrorCount,le.orig_address2_city_LENGTHS_ErrorCount,le.orig_address2_city_WORDS_ErrorCount
          ,le.orig_address2_st_LEFTTRIM_ErrorCount,le.orig_address2_st_ALLOW_ErrorCount,le.orig_address2_st_LENGTHS_ErrorCount,le.orig_address2_st_WORDS_ErrorCount
          ,le.orig_address2_z5_LEFTTRIM_ErrorCount,le.orig_address2_z5_ALLOW_ErrorCount,le.orig_address2_z5_LENGTHS_ErrorCount,le.orig_address2_z5_WORDS_ErrorCount
          ,le.orig_address2_z4_LEFTTRIM_ErrorCount,le.orig_address2_z4_ALLOW_ErrorCount,le.orig_address2_z4_LENGTHS_ErrorCount,le.orig_address2_z4_WORDS_ErrorCount
          ,le.orig_bdid_LEFTTRIM_ErrorCount,le.orig_bdid_ALLOW_ErrorCount,le.orig_bdid_LENGTHS_ErrorCount,le.orig_bdid_WORDS_ErrorCount
          ,le.orig_bdl_LEFTTRIM_ErrorCount,le.orig_bdl_ALLOW_ErrorCount,le.orig_bdl_LENGTHS_ErrorCount,le.orig_bdl_WORDS_ErrorCount
          ,le.orig_did_LEFTTRIM_ErrorCount,le.orig_did_ALLOW_ErrorCount,le.orig_did_LENGTHS_ErrorCount,le.orig_did_WORDS_ErrorCount
          ,le.orig_company_name_LEFTTRIM_ErrorCount,le.orig_company_name_ALLOW_ErrorCount,le.orig_company_name_LENGTHS_ErrorCount,le.orig_company_name_WORDS_ErrorCount
          ,le.orig_fein_LEFTTRIM_ErrorCount,le.orig_fein_ALLOW_ErrorCount,le.orig_fein_LENGTHS_ErrorCount,le.orig_fein_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_work_phone_LEFTTRIM_ErrorCount,le.orig_work_phone_ALLOW_ErrorCount,le.orig_work_phone_LENGTHS_ErrorCount,le.orig_work_phone_WORDS_ErrorCount
          ,le.orig_company_phone_LEFTTRIM_ErrorCount,le.orig_company_phone_ALLOW_ErrorCount,le.orig_company_phone_LENGTHS_ErrorCount,le.orig_company_phone_WORDS_ErrorCount
          ,le.orig_reference_code_LEFTTRIM_ErrorCount,le.orig_reference_code_ALLOW_ErrorCount,le.orig_reference_code_LENGTHS_ErrorCount,le.orig_reference_code_WORDS_ErrorCount
          ,le.orig_ip_address_initiated_LEFTTRIM_ErrorCount,le.orig_ip_address_initiated_ALLOW_ErrorCount,le.orig_ip_address_initiated_LENGTHS_ErrorCount,le.orig_ip_address_initiated_WORDS_ErrorCount
          ,le.orig_ip_address_executed_LEFTTRIM_ErrorCount,le.orig_ip_address_executed_WORDS_ErrorCount
          ,le.orig_charter_number_LEFTTRIM_ErrorCount,le.orig_charter_number_ALLOW_ErrorCount,le.orig_charter_number_LENGTHS_ErrorCount,le.orig_charter_number_WORDS_ErrorCount
          ,le.orig_ucc_original_filing_number_LEFTTRIM_ErrorCount,le.orig_ucc_original_filing_number_ALLOW_ErrorCount,le.orig_ucc_original_filing_number_LENGTHS_ErrorCount,le.orig_ucc_original_filing_number_WORDS_ErrorCount
          ,le.orig_email_address_LEFTTRIM_ErrorCount,le.orig_email_address_ALLOW_ErrorCount,le.orig_email_address_LENGTHS_ErrorCount,le.orig_email_address_WORDS_ErrorCount
          ,le.orig_domain_name_LEFTTRIM_ErrorCount,le.orig_domain_name_ALLOW_ErrorCount,le.orig_domain_name_LENGTHS_ErrorCount,le.orig_domain_name_WORDS_ErrorCount
          ,le.orig_full_name_LEFTTRIM_ErrorCount,le.orig_full_name_ALLOW_ErrorCount,le.orig_full_name_LENGTHS_ErrorCount,le.orig_full_name_WORDS_ErrorCount
          ,le.orig_dl_purpose_LEFTTRIM_ErrorCount,le.orig_dl_purpose_ALLOW_ErrorCount,le.orig_dl_purpose_LENGTHS_ErrorCount,le.orig_dl_purpose_WORDS_ErrorCount
          ,le.orig_glb_purpose_LEFTTRIM_ErrorCount,le.orig_glb_purpose_ALLOW_ErrorCount,le.orig_glb_purpose_LENGTHS_ErrorCount,le.orig_glb_purpose_WORDS_ErrorCount
          ,le.orig_fcra_purpose_LEFTTRIM_ErrorCount,le.orig_fcra_purpose_ALLOW_ErrorCount,le.orig_fcra_purpose_LENGTHS_ErrorCount,le.orig_fcra_purpose_WORDS_ErrorCount
          ,le.orig_process_id_LEFTTRIM_ErrorCount,le.orig_process_id_ALLOW_ErrorCount,le.orig_process_id_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_FILE));
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
          ,'orig_datetime_stamp:' + getFieldTypeText(h.orig_datetime_stamp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_global_company_id:' + getFieldTypeText(h.orig_global_company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_id:' + getFieldTypeText(h.orig_company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_product_cd:' + getFieldTypeText(h.orig_product_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_method:' + getFieldTypeText(h.orig_method) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_vertical:' + getFieldTypeText(h.orig_vertical) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_function_name:' + getFieldTypeText(h.orig_function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_transaction_type:' + getFieldTypeText(h.orig_transaction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_login_history_id:' + getFieldTypeText(h.orig_login_history_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_job_id:' + getFieldTypeText(h.orig_job_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_sequence_number:' + getFieldTypeText(h.orig_sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_first_name:' + getFieldTypeText(h.orig_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_middle_name:' + getFieldTypeText(h.orig_middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_last_name:' + getFieldTypeText(h.orig_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_num:' + getFieldTypeText(h.orig_dl_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_state:' + getFieldTypeText(h.orig_dl_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_addressline1:' + getFieldTypeText(h.orig_address1_addressline1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_addressline2:' + getFieldTypeText(h.orig_address1_addressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_prim_range:' + getFieldTypeText(h.orig_address1_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_predir:' + getFieldTypeText(h.orig_address1_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_prim_name:' + getFieldTypeText(h.orig_address1_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_suffix:' + getFieldTypeText(h.orig_address1_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_postdir:' + getFieldTypeText(h.orig_address1_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_unit_desig:' + getFieldTypeText(h.orig_address1_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_sec_range:' + getFieldTypeText(h.orig_address1_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_city:' + getFieldTypeText(h.orig_address1_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_st:' + getFieldTypeText(h.orig_address1_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_z5:' + getFieldTypeText(h.orig_address1_z5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1_z4:' + getFieldTypeText(h.orig_address1_z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_addressline1:' + getFieldTypeText(h.orig_address2_addressline1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_addressline2:' + getFieldTypeText(h.orig_address2_addressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_prim_range:' + getFieldTypeText(h.orig_address2_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_predir:' + getFieldTypeText(h.orig_address2_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_prim_name:' + getFieldTypeText(h.orig_address2_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_suffix:' + getFieldTypeText(h.orig_address2_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_postdir:' + getFieldTypeText(h.orig_address2_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_unit_desig:' + getFieldTypeText(h.orig_address2_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_sec_range:' + getFieldTypeText(h.orig_address2_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_city:' + getFieldTypeText(h.orig_address2_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_st:' + getFieldTypeText(h.orig_address2_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_z5:' + getFieldTypeText(h.orig_address2_z5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2_z4:' + getFieldTypeText(h.orig_address2_z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_bdid:' + getFieldTypeText(h.orig_bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_bdl:' + getFieldTypeText(h.orig_bdl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_did:' + getFieldTypeText(h.orig_did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_name:' + getFieldTypeText(h.orig_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fein:' + getFieldTypeText(h.orig_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone:' + getFieldTypeText(h.orig_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_work_phone:' + getFieldTypeText(h.orig_work_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_phone:' + getFieldTypeText(h.orig_company_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_reference_code:' + getFieldTypeText(h.orig_reference_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ip_address_initiated:' + getFieldTypeText(h.orig_ip_address_initiated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ip_address_executed:' + getFieldTypeText(h.orig_ip_address_executed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_charter_number:' + getFieldTypeText(h.orig_charter_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ucc_original_filing_number:' + getFieldTypeText(h.orig_ucc_original_filing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_email_address:' + getFieldTypeText(h.orig_email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_domain_name:' + getFieldTypeText(h.orig_domain_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_full_name:' + getFieldTypeText(h.orig_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_purpose:' + getFieldTypeText(h.orig_dl_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_glb_purpose:' + getFieldTypeText(h.orig_glb_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fcra_purpose:' + getFieldTypeText(h.orig_fcra_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_process_id:' + getFieldTypeText(h.orig_process_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_datetime_stamp_cnt
          ,le.populated_orig_global_company_id_cnt
          ,le.populated_orig_company_id_cnt
          ,le.populated_orig_product_cd_cnt
          ,le.populated_orig_method_cnt
          ,le.populated_orig_vertical_cnt
          ,le.populated_orig_function_name_cnt
          ,le.populated_orig_transaction_type_cnt
          ,le.populated_orig_login_history_id_cnt
          ,le.populated_orig_job_id_cnt
          ,le.populated_orig_sequence_number_cnt
          ,le.populated_orig_first_name_cnt
          ,le.populated_orig_middle_name_cnt
          ,le.populated_orig_last_name_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_dl_num_cnt
          ,le.populated_orig_dl_state_cnt
          ,le.populated_orig_address1_addressline1_cnt
          ,le.populated_orig_address1_addressline2_cnt
          ,le.populated_orig_address1_prim_range_cnt
          ,le.populated_orig_address1_predir_cnt
          ,le.populated_orig_address1_prim_name_cnt
          ,le.populated_orig_address1_suffix_cnt
          ,le.populated_orig_address1_postdir_cnt
          ,le.populated_orig_address1_unit_desig_cnt
          ,le.populated_orig_address1_sec_range_cnt
          ,le.populated_orig_address1_city_cnt
          ,le.populated_orig_address1_st_cnt
          ,le.populated_orig_address1_z5_cnt
          ,le.populated_orig_address1_z4_cnt
          ,le.populated_orig_address2_addressline1_cnt
          ,le.populated_orig_address2_addressline2_cnt
          ,le.populated_orig_address2_prim_range_cnt
          ,le.populated_orig_address2_predir_cnt
          ,le.populated_orig_address2_prim_name_cnt
          ,le.populated_orig_address2_suffix_cnt
          ,le.populated_orig_address2_postdir_cnt
          ,le.populated_orig_address2_unit_desig_cnt
          ,le.populated_orig_address2_sec_range_cnt
          ,le.populated_orig_address2_city_cnt
          ,le.populated_orig_address2_st_cnt
          ,le.populated_orig_address2_z5_cnt
          ,le.populated_orig_address2_z4_cnt
          ,le.populated_orig_bdid_cnt
          ,le.populated_orig_bdl_cnt
          ,le.populated_orig_did_cnt
          ,le.populated_orig_company_name_cnt
          ,le.populated_orig_fein_cnt
          ,le.populated_orig_phone_cnt
          ,le.populated_orig_work_phone_cnt
          ,le.populated_orig_company_phone_cnt
          ,le.populated_orig_reference_code_cnt
          ,le.populated_orig_ip_address_initiated_cnt
          ,le.populated_orig_ip_address_executed_cnt
          ,le.populated_orig_charter_number_cnt
          ,le.populated_orig_ucc_original_filing_number_cnt
          ,le.populated_orig_email_address_cnt
          ,le.populated_orig_domain_name_cnt
          ,le.populated_orig_full_name_cnt
          ,le.populated_orig_dl_purpose_cnt
          ,le.populated_orig_glb_purpose_cnt
          ,le.populated_orig_fcra_purpose_cnt
          ,le.populated_orig_process_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_datetime_stamp_pcnt
          ,le.populated_orig_global_company_id_pcnt
          ,le.populated_orig_company_id_pcnt
          ,le.populated_orig_product_cd_pcnt
          ,le.populated_orig_method_pcnt
          ,le.populated_orig_vertical_pcnt
          ,le.populated_orig_function_name_pcnt
          ,le.populated_orig_transaction_type_pcnt
          ,le.populated_orig_login_history_id_pcnt
          ,le.populated_orig_job_id_pcnt
          ,le.populated_orig_sequence_number_pcnt
          ,le.populated_orig_first_name_pcnt
          ,le.populated_orig_middle_name_pcnt
          ,le.populated_orig_last_name_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_dl_num_pcnt
          ,le.populated_orig_dl_state_pcnt
          ,le.populated_orig_address1_addressline1_pcnt
          ,le.populated_orig_address1_addressline2_pcnt
          ,le.populated_orig_address1_prim_range_pcnt
          ,le.populated_orig_address1_predir_pcnt
          ,le.populated_orig_address1_prim_name_pcnt
          ,le.populated_orig_address1_suffix_pcnt
          ,le.populated_orig_address1_postdir_pcnt
          ,le.populated_orig_address1_unit_desig_pcnt
          ,le.populated_orig_address1_sec_range_pcnt
          ,le.populated_orig_address1_city_pcnt
          ,le.populated_orig_address1_st_pcnt
          ,le.populated_orig_address1_z5_pcnt
          ,le.populated_orig_address1_z4_pcnt
          ,le.populated_orig_address2_addressline1_pcnt
          ,le.populated_orig_address2_addressline2_pcnt
          ,le.populated_orig_address2_prim_range_pcnt
          ,le.populated_orig_address2_predir_pcnt
          ,le.populated_orig_address2_prim_name_pcnt
          ,le.populated_orig_address2_suffix_pcnt
          ,le.populated_orig_address2_postdir_pcnt
          ,le.populated_orig_address2_unit_desig_pcnt
          ,le.populated_orig_address2_sec_range_pcnt
          ,le.populated_orig_address2_city_pcnt
          ,le.populated_orig_address2_st_pcnt
          ,le.populated_orig_address2_z5_pcnt
          ,le.populated_orig_address2_z4_pcnt
          ,le.populated_orig_bdid_pcnt
          ,le.populated_orig_bdl_pcnt
          ,le.populated_orig_did_pcnt
          ,le.populated_orig_company_name_pcnt
          ,le.populated_orig_fein_pcnt
          ,le.populated_orig_phone_pcnt
          ,le.populated_orig_work_phone_pcnt
          ,le.populated_orig_company_phone_pcnt
          ,le.populated_orig_reference_code_pcnt
          ,le.populated_orig_ip_address_initiated_pcnt
          ,le.populated_orig_ip_address_executed_pcnt
          ,le.populated_orig_charter_number_pcnt
          ,le.populated_orig_ucc_original_filing_number_pcnt
          ,le.populated_orig_email_address_pcnt
          ,le.populated_orig_domain_name_pcnt
          ,le.populated_orig_full_name_pcnt
          ,le.populated_orig_dl_purpose_pcnt
          ,le.populated_orig_glb_purpose_pcnt
          ,le.populated_orig_fcra_purpose_pcnt
          ,le.populated_orig_process_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,64,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_FILE));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),64,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_FILE) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inql_fcra_Batch, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
