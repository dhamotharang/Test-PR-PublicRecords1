IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 279;
  EXPORT NumRulesFromFieldType := 279;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 79;
  EXPORT NumFieldsWithPossibleEdits := 79;
  EXPORT NumRulesWithPossibleEdits := 279;
  EXPORT Expanded_Layout := RECORD(Layout_FILE)
    UNSIGNED1 orig_login_id_Invalid;
    BOOLEAN orig_login_id_wouldClean;
    UNSIGNED1 orig_billing_code_Invalid;
    BOOLEAN orig_billing_code_wouldClean;
    UNSIGNED1 orig_transaction_id_Invalid;
    BOOLEAN orig_transaction_id_wouldClean;
    UNSIGNED1 orig_function_name_Invalid;
    BOOLEAN orig_function_name_wouldClean;
    UNSIGNED1 orig_company_id_Invalid;
    BOOLEAN orig_company_id_wouldClean;
    UNSIGNED1 orig_reference_code_Invalid;
    BOOLEAN orig_reference_code_wouldClean;
    UNSIGNED1 orig_fname_Invalid;
    BOOLEAN orig_fname_wouldClean;
    UNSIGNED1 orig_mname_Invalid;
    BOOLEAN orig_mname_wouldClean;
    UNSIGNED1 orig_lname_Invalid;
    BOOLEAN orig_lname_wouldClean;
    UNSIGNED1 orig_name_suffix_Invalid;
    BOOLEAN orig_name_suffix_wouldClean;
    UNSIGNED1 orig_fname_2_Invalid;
    BOOLEAN orig_fname_2_wouldClean;
    UNSIGNED1 orig_mname_2_Invalid;
    BOOLEAN orig_mname_2_wouldClean;
    UNSIGNED1 orig_lname_2_Invalid;
    BOOLEAN orig_lname_2_wouldClean;
    UNSIGNED1 orig_name_suffix_2_Invalid;
    BOOLEAN orig_name_suffix_2_wouldClean;
    UNSIGNED1 orig_address_Invalid;
    BOOLEAN orig_address_wouldClean;
    UNSIGNED1 orig_city_Invalid;
    BOOLEAN orig_city_wouldClean;
    UNSIGNED1 orig_state_Invalid;
    BOOLEAN orig_state_wouldClean;
    UNSIGNED1 orig_zip_Invalid;
    BOOLEAN orig_zip_wouldClean;
    UNSIGNED1 orig_zip4_Invalid;
    BOOLEAN orig_zip4_wouldClean;
    UNSIGNED1 orig_address_2_Invalid;
    BOOLEAN orig_address_2_wouldClean;
    UNSIGNED1 orig_city_2_Invalid;
    BOOLEAN orig_city_2_wouldClean;
    UNSIGNED1 orig_state_2_Invalid;
    BOOLEAN orig_state_2_wouldClean;
    UNSIGNED1 orig_zip_2_Invalid;
    BOOLEAN orig_zip_2_wouldClean;
    UNSIGNED1 orig_zip4_2_Invalid;
    BOOLEAN orig_zip4_2_wouldClean;
    UNSIGNED1 orig_clean_address_Invalid;
    BOOLEAN orig_clean_address_wouldClean;
    UNSIGNED1 orig_clean_city_Invalid;
    BOOLEAN orig_clean_city_wouldClean;
    UNSIGNED1 orig_clean_state_Invalid;
    BOOLEAN orig_clean_state_wouldClean;
    UNSIGNED1 orig_clean_zip_Invalid;
    BOOLEAN orig_clean_zip_wouldClean;
    UNSIGNED1 orig_clean_zip4_Invalid;
    BOOLEAN orig_clean_zip4_wouldClean;
    UNSIGNED1 orig_phone_Invalid;
    BOOLEAN orig_phone_wouldClean;
    UNSIGNED1 orig_homephone_Invalid;
    BOOLEAN orig_homephone_wouldClean;
    UNSIGNED1 orig_homephone_2_Invalid;
    BOOLEAN orig_homephone_2_wouldClean;
    UNSIGNED1 orig_workphone_Invalid;
    BOOLEAN orig_workphone_wouldClean;
    UNSIGNED1 orig_workphone_2_Invalid;
    BOOLEAN orig_workphone_2_wouldClean;
    UNSIGNED1 orig_ssn_Invalid;
    BOOLEAN orig_ssn_wouldClean;
    UNSIGNED1 orig_ssn_2_Invalid;
    BOOLEAN orig_ssn_2_wouldClean;
    UNSIGNED1 orig_free_Invalid;
    BOOLEAN orig_free_wouldClean;
    UNSIGNED1 orig_record_count_Invalid;
    BOOLEAN orig_record_count_wouldClean;
    UNSIGNED1 orig_price_Invalid;
    BOOLEAN orig_price_wouldClean;
    UNSIGNED1 orig_revenue_Invalid;
    BOOLEAN orig_revenue_wouldClean;
    UNSIGNED1 orig_full_name_Invalid;
    BOOLEAN orig_full_name_wouldClean;
    UNSIGNED1 orig_business_name_Invalid;
    BOOLEAN orig_business_name_wouldClean;
    UNSIGNED1 orig_business_name_2_Invalid;
    BOOLEAN orig_business_name_2_wouldClean;
    UNSIGNED1 orig_years_Invalid;
    BOOLEAN orig_years_wouldClean;
    UNSIGNED1 orig_pricing_error_code_Invalid;
    BOOLEAN orig_pricing_error_code_wouldClean;
    UNSIGNED1 orig_fcra_purpose_Invalid;
    BOOLEAN orig_fcra_purpose_wouldClean;
    UNSIGNED1 orig_result_format_Invalid;
    BOOLEAN orig_result_format_wouldClean;
    UNSIGNED1 orig_dob_Invalid;
    BOOLEAN orig_dob_wouldClean;
    UNSIGNED1 orig_dob_2_Invalid;
    BOOLEAN orig_dob_2_wouldClean;
    UNSIGNED1 orig_unique_id_Invalid;
    BOOLEAN orig_unique_id_wouldClean;
    UNSIGNED1 orig_response_time_Invalid;
    BOOLEAN orig_response_time_wouldClean;
    UNSIGNED1 orig_data_source_Invalid;
    BOOLEAN orig_data_source_wouldClean;
    UNSIGNED1 orig_report_options_Invalid;
    BOOLEAN orig_report_options_wouldClean;
    UNSIGNED1 orig_end_user_name_Invalid;
    BOOLEAN orig_end_user_name_wouldClean;
    UNSIGNED1 orig_end_user_address_1_Invalid;
    BOOLEAN orig_end_user_address_1_wouldClean;
    UNSIGNED1 orig_end_user_address_2_Invalid;
    BOOLEAN orig_end_user_address_2_wouldClean;
    UNSIGNED1 orig_end_user_city_Invalid;
    BOOLEAN orig_end_user_city_wouldClean;
    UNSIGNED1 orig_end_user_state_Invalid;
    BOOLEAN orig_end_user_state_wouldClean;
    UNSIGNED1 orig_end_user_zip_Invalid;
    BOOLEAN orig_end_user_zip_wouldClean;
    UNSIGNED1 orig_login_history_id_Invalid;
    BOOLEAN orig_login_history_id_wouldClean;
    UNSIGNED1 orig_employment_state_Invalid;
    BOOLEAN orig_employment_state_wouldClean;
    UNSIGNED1 orig_end_user_industry_class_Invalid;
    BOOLEAN orig_end_user_industry_class_wouldClean;
    UNSIGNED1 orig_function_specific_data_Invalid;
    BOOLEAN orig_function_specific_data_wouldClean;
    UNSIGNED1 orig_date_added_Invalid;
    BOOLEAN orig_date_added_wouldClean;
    UNSIGNED1 orig_retail_price_Invalid;
    BOOLEAN orig_retail_price_wouldClean;
    UNSIGNED1 orig_country_code_Invalid;
    BOOLEAN orig_country_code_wouldClean;
    UNSIGNED1 orig_email_Invalid;
    BOOLEAN orig_email_wouldClean;
    UNSIGNED1 orig_email_2_Invalid;
    BOOLEAN orig_email_2_wouldClean;
    UNSIGNED1 orig_dl_number_Invalid;
    BOOLEAN orig_dl_number_wouldClean;
    UNSIGNED1 orig_dl_number_2_Invalid;
    BOOLEAN orig_dl_number_2_wouldClean;
    UNSIGNED1 orig_sub_id_Invalid;
    BOOLEAN orig_sub_id_wouldClean;
    UNSIGNED1 orig_neighbors_Invalid;
    BOOLEAN orig_neighbors_wouldClean;
    UNSIGNED1 orig_relatives_Invalid;
    BOOLEAN orig_relatives_wouldClean;
    UNSIGNED1 orig_associates_Invalid;
    BOOLEAN orig_associates_wouldClean;
    UNSIGNED1 orig_property_Invalid;
    BOOLEAN orig_property_wouldClean;
    UNSIGNED1 orig_bankruptcy_Invalid;
    BOOLEAN orig_bankruptcy_wouldClean;
    UNSIGNED1 orig_dls_Invalid;
    BOOLEAN orig_dls_wouldClean;
    UNSIGNED1 orig_mvs_Invalid;
    BOOLEAN orig_mvs_wouldClean;
    UNSIGNED1 orig_ip_address_Invalid;
    BOOLEAN orig_ip_address_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_FILE)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsCleanBits1;
    UNSIGNED8 ScrubsCleanBits2;
  END;
EXPORT FromNone(DATASET(Layout_FILE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_login_id_Invalid := Fields.InValid_orig_login_id((SALT39.StrType)le.orig_login_id);
    clean_orig_login_id := (TYPEOF(le.orig_login_id))Fields.Make_orig_login_id((SALT39.StrType)le.orig_login_id);
    clean_orig_login_id_Invalid := Fields.InValid_orig_login_id((SALT39.StrType)clean_orig_login_id);
    SELF.orig_login_id := IF(withOnfail, clean_orig_login_id, le.orig_login_id); // ONFAIL(CLEAN)
    SELF.orig_login_id_wouldClean := TRIM((SALT39.StrType)le.orig_login_id) <> TRIM((SALT39.StrType)clean_orig_login_id);
    SELF.orig_billing_code_Invalid := Fields.InValid_orig_billing_code((SALT39.StrType)le.orig_billing_code);
    clean_orig_billing_code := (TYPEOF(le.orig_billing_code))Fields.Make_orig_billing_code((SALT39.StrType)le.orig_billing_code);
    clean_orig_billing_code_Invalid := Fields.InValid_orig_billing_code((SALT39.StrType)clean_orig_billing_code);
    SELF.orig_billing_code := IF(withOnfail, clean_orig_billing_code, le.orig_billing_code); // ONFAIL(CLEAN)
    SELF.orig_billing_code_wouldClean := TRIM((SALT39.StrType)le.orig_billing_code) <> TRIM((SALT39.StrType)clean_orig_billing_code);
    SELF.orig_transaction_id_Invalid := Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id);
    clean_orig_transaction_id := (TYPEOF(le.orig_transaction_id))Fields.Make_orig_transaction_id((SALT39.StrType)le.orig_transaction_id);
    clean_orig_transaction_id_Invalid := Fields.InValid_orig_transaction_id((SALT39.StrType)clean_orig_transaction_id);
    SELF.orig_transaction_id := IF(withOnfail, clean_orig_transaction_id, le.orig_transaction_id); // ONFAIL(CLEAN)
    SELF.orig_transaction_id_wouldClean := TRIM((SALT39.StrType)le.orig_transaction_id) <> TRIM((SALT39.StrType)clean_orig_transaction_id);
    SELF.orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name := (TYPEOF(le.orig_function_name))Fields.Make_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)clean_orig_function_name);
    SELF.orig_function_name := IF(withOnfail, clean_orig_function_name, le.orig_function_name); // ONFAIL(CLEAN)
    SELF.orig_function_name_wouldClean := TRIM((SALT39.StrType)le.orig_function_name) <> TRIM((SALT39.StrType)clean_orig_function_name);
    SELF.orig_company_id_Invalid := Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id);
    clean_orig_company_id := (TYPEOF(le.orig_company_id))Fields.Make_orig_company_id((SALT39.StrType)le.orig_company_id);
    clean_orig_company_id_Invalid := Fields.InValid_orig_company_id((SALT39.StrType)clean_orig_company_id);
    SELF.orig_company_id := IF(withOnfail, clean_orig_company_id, le.orig_company_id); // ONFAIL(CLEAN)
    SELF.orig_company_id_wouldClean := TRIM((SALT39.StrType)le.orig_company_id) <> TRIM((SALT39.StrType)clean_orig_company_id);
    SELF.orig_reference_code_Invalid := Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code);
    clean_orig_reference_code := (TYPEOF(le.orig_reference_code))Fields.Make_orig_reference_code((SALT39.StrType)le.orig_reference_code);
    clean_orig_reference_code_Invalid := Fields.InValid_orig_reference_code((SALT39.StrType)clean_orig_reference_code);
    SELF.orig_reference_code := IF(withOnfail, clean_orig_reference_code, le.orig_reference_code); // ONFAIL(CLEAN)
    SELF.orig_reference_code_wouldClean := TRIM((SALT39.StrType)le.orig_reference_code) <> TRIM((SALT39.StrType)clean_orig_reference_code);
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT39.StrType)le.orig_fname);
    clean_orig_fname := (TYPEOF(le.orig_fname))Fields.Make_orig_fname((SALT39.StrType)le.orig_fname);
    clean_orig_fname_Invalid := Fields.InValid_orig_fname((SALT39.StrType)clean_orig_fname);
    SELF.orig_fname := IF(withOnfail, clean_orig_fname, le.orig_fname); // ONFAIL(CLEAN)
    SELF.orig_fname_wouldClean := TRIM((SALT39.StrType)le.orig_fname) <> TRIM((SALT39.StrType)clean_orig_fname);
    SELF.orig_mname_Invalid := Fields.InValid_orig_mname((SALT39.StrType)le.orig_mname);
    clean_orig_mname := (TYPEOF(le.orig_mname))Fields.Make_orig_mname((SALT39.StrType)le.orig_mname);
    clean_orig_mname_Invalid := Fields.InValid_orig_mname((SALT39.StrType)clean_orig_mname);
    SELF.orig_mname := IF(withOnfail, clean_orig_mname, le.orig_mname); // ONFAIL(CLEAN)
    SELF.orig_mname_wouldClean := TRIM((SALT39.StrType)le.orig_mname) <> TRIM((SALT39.StrType)clean_orig_mname);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT39.StrType)le.orig_lname);
    clean_orig_lname := (TYPEOF(le.orig_lname))Fields.Make_orig_lname((SALT39.StrType)le.orig_lname);
    clean_orig_lname_Invalid := Fields.InValid_orig_lname((SALT39.StrType)clean_orig_lname);
    SELF.orig_lname := IF(withOnfail, clean_orig_lname, le.orig_lname); // ONFAIL(CLEAN)
    SELF.orig_lname_wouldClean := TRIM((SALT39.StrType)le.orig_lname) <> TRIM((SALT39.StrType)clean_orig_lname);
    SELF.orig_name_suffix_Invalid := Fields.InValid_orig_name_suffix((SALT39.StrType)le.orig_name_suffix);
    clean_orig_name_suffix := (TYPEOF(le.orig_name_suffix))Fields.Make_orig_name_suffix((SALT39.StrType)le.orig_name_suffix);
    clean_orig_name_suffix_Invalid := Fields.InValid_orig_name_suffix((SALT39.StrType)clean_orig_name_suffix);
    SELF.orig_name_suffix := IF(withOnfail, clean_orig_name_suffix, le.orig_name_suffix); // ONFAIL(CLEAN)
    SELF.orig_name_suffix_wouldClean := TRIM((SALT39.StrType)le.orig_name_suffix) <> TRIM((SALT39.StrType)clean_orig_name_suffix);
    SELF.orig_fname_2_Invalid := Fields.InValid_orig_fname_2((SALT39.StrType)le.orig_fname_2);
    clean_orig_fname_2 := (TYPEOF(le.orig_fname_2))Fields.Make_orig_fname_2((SALT39.StrType)le.orig_fname_2);
    clean_orig_fname_2_Invalid := Fields.InValid_orig_fname_2((SALT39.StrType)clean_orig_fname_2);
    SELF.orig_fname_2 := IF(withOnfail, clean_orig_fname_2, le.orig_fname_2); // ONFAIL(CLEAN)
    SELF.orig_fname_2_wouldClean := TRIM((SALT39.StrType)le.orig_fname_2) <> TRIM((SALT39.StrType)clean_orig_fname_2);
    SELF.orig_mname_2_Invalid := Fields.InValid_orig_mname_2((SALT39.StrType)le.orig_mname_2);
    clean_orig_mname_2 := (TYPEOF(le.orig_mname_2))Fields.Make_orig_mname_2((SALT39.StrType)le.orig_mname_2);
    clean_orig_mname_2_Invalid := Fields.InValid_orig_mname_2((SALT39.StrType)clean_orig_mname_2);
    SELF.orig_mname_2 := IF(withOnfail, clean_orig_mname_2, le.orig_mname_2); // ONFAIL(CLEAN)
    SELF.orig_mname_2_wouldClean := TRIM((SALT39.StrType)le.orig_mname_2) <> TRIM((SALT39.StrType)clean_orig_mname_2);
    SELF.orig_lname_2_Invalid := Fields.InValid_orig_lname_2((SALT39.StrType)le.orig_lname_2);
    clean_orig_lname_2 := (TYPEOF(le.orig_lname_2))Fields.Make_orig_lname_2((SALT39.StrType)le.orig_lname_2);
    clean_orig_lname_2_Invalid := Fields.InValid_orig_lname_2((SALT39.StrType)clean_orig_lname_2);
    SELF.orig_lname_2 := IF(withOnfail, clean_orig_lname_2, le.orig_lname_2); // ONFAIL(CLEAN)
    SELF.orig_lname_2_wouldClean := TRIM((SALT39.StrType)le.orig_lname_2) <> TRIM((SALT39.StrType)clean_orig_lname_2);
    SELF.orig_name_suffix_2_Invalid := Fields.InValid_orig_name_suffix_2((SALT39.StrType)le.orig_name_suffix_2);
    clean_orig_name_suffix_2 := (TYPEOF(le.orig_name_suffix_2))Fields.Make_orig_name_suffix_2((SALT39.StrType)le.orig_name_suffix_2);
    clean_orig_name_suffix_2_Invalid := Fields.InValid_orig_name_suffix_2((SALT39.StrType)clean_orig_name_suffix_2);
    SELF.orig_name_suffix_2 := IF(withOnfail, clean_orig_name_suffix_2, le.orig_name_suffix_2); // ONFAIL(CLEAN)
    SELF.orig_name_suffix_2_wouldClean := TRIM((SALT39.StrType)le.orig_name_suffix_2) <> TRIM((SALT39.StrType)clean_orig_name_suffix_2);
    SELF.orig_address_Invalid := Fields.InValid_orig_address((SALT39.StrType)le.orig_address);
    clean_orig_address := (TYPEOF(le.orig_address))Fields.Make_orig_address((SALT39.StrType)le.orig_address);
    clean_orig_address_Invalid := Fields.InValid_orig_address((SALT39.StrType)clean_orig_address);
    SELF.orig_address := IF(withOnfail, clean_orig_address, le.orig_address); // ONFAIL(CLEAN)
    SELF.orig_address_wouldClean := TRIM((SALT39.StrType)le.orig_address) <> TRIM((SALT39.StrType)clean_orig_address);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT39.StrType)le.orig_city);
    clean_orig_city := (TYPEOF(le.orig_city))Fields.Make_orig_city((SALT39.StrType)le.orig_city);
    clean_orig_city_Invalid := Fields.InValid_orig_city((SALT39.StrType)clean_orig_city);
    SELF.orig_city := IF(withOnfail, clean_orig_city, le.orig_city); // ONFAIL(CLEAN)
    SELF.orig_city_wouldClean := TRIM((SALT39.StrType)le.orig_city) <> TRIM((SALT39.StrType)clean_orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT39.StrType)le.orig_state);
    clean_orig_state := (TYPEOF(le.orig_state))Fields.Make_orig_state((SALT39.StrType)le.orig_state);
    clean_orig_state_Invalid := Fields.InValid_orig_state((SALT39.StrType)clean_orig_state);
    SELF.orig_state := IF(withOnfail, clean_orig_state, le.orig_state); // ONFAIL(CLEAN)
    SELF.orig_state_wouldClean := TRIM((SALT39.StrType)le.orig_state) <> TRIM((SALT39.StrType)clean_orig_state);
    SELF.orig_zip_Invalid := Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip);
    clean_orig_zip := (TYPEOF(le.orig_zip))Fields.Make_orig_zip((SALT39.StrType)le.orig_zip);
    clean_orig_zip_Invalid := Fields.InValid_orig_zip((SALT39.StrType)clean_orig_zip);
    SELF.orig_zip := IF(withOnfail, clean_orig_zip, le.orig_zip); // ONFAIL(CLEAN)
    SELF.orig_zip_wouldClean := TRIM((SALT39.StrType)le.orig_zip) <> TRIM((SALT39.StrType)clean_orig_zip);
    SELF.orig_zip4_Invalid := Fields.InValid_orig_zip4((SALT39.StrType)le.orig_zip4);
    clean_orig_zip4 := (TYPEOF(le.orig_zip4))Fields.Make_orig_zip4((SALT39.StrType)le.orig_zip4);
    clean_orig_zip4_Invalid := Fields.InValid_orig_zip4((SALT39.StrType)clean_orig_zip4);
    SELF.orig_zip4 := IF(withOnfail, clean_orig_zip4, le.orig_zip4); // ONFAIL(CLEAN)
    SELF.orig_zip4_wouldClean := TRIM((SALT39.StrType)le.orig_zip4) <> TRIM((SALT39.StrType)clean_orig_zip4);
    SELF.orig_address_2_Invalid := Fields.InValid_orig_address_2((SALT39.StrType)le.orig_address_2);
    clean_orig_address_2 := (TYPEOF(le.orig_address_2))Fields.Make_orig_address_2((SALT39.StrType)le.orig_address_2);
    clean_orig_address_2_Invalid := Fields.InValid_orig_address_2((SALT39.StrType)clean_orig_address_2);
    SELF.orig_address_2 := IF(withOnfail, clean_orig_address_2, le.orig_address_2); // ONFAIL(CLEAN)
    SELF.orig_address_2_wouldClean := TRIM((SALT39.StrType)le.orig_address_2) <> TRIM((SALT39.StrType)clean_orig_address_2);
    SELF.orig_city_2_Invalid := Fields.InValid_orig_city_2((SALT39.StrType)le.orig_city_2);
    clean_orig_city_2 := (TYPEOF(le.orig_city_2))Fields.Make_orig_city_2((SALT39.StrType)le.orig_city_2);
    clean_orig_city_2_Invalid := Fields.InValid_orig_city_2((SALT39.StrType)clean_orig_city_2);
    SELF.orig_city_2 := IF(withOnfail, clean_orig_city_2, le.orig_city_2); // ONFAIL(CLEAN)
    SELF.orig_city_2_wouldClean := TRIM((SALT39.StrType)le.orig_city_2) <> TRIM((SALT39.StrType)clean_orig_city_2);
    SELF.orig_state_2_Invalid := Fields.InValid_orig_state_2((SALT39.StrType)le.orig_state_2);
    clean_orig_state_2 := (TYPEOF(le.orig_state_2))Fields.Make_orig_state_2((SALT39.StrType)le.orig_state_2);
    clean_orig_state_2_Invalid := Fields.InValid_orig_state_2((SALT39.StrType)clean_orig_state_2);
    SELF.orig_state_2 := IF(withOnfail, clean_orig_state_2, le.orig_state_2); // ONFAIL(CLEAN)
    SELF.orig_state_2_wouldClean := TRIM((SALT39.StrType)le.orig_state_2) <> TRIM((SALT39.StrType)clean_orig_state_2);
    SELF.orig_zip_2_Invalid := Fields.InValid_orig_zip_2((SALT39.StrType)le.orig_zip_2);
    clean_orig_zip_2 := (TYPEOF(le.orig_zip_2))Fields.Make_orig_zip_2((SALT39.StrType)le.orig_zip_2);
    clean_orig_zip_2_Invalid := Fields.InValid_orig_zip_2((SALT39.StrType)clean_orig_zip_2);
    SELF.orig_zip_2 := IF(withOnfail, clean_orig_zip_2, le.orig_zip_2); // ONFAIL(CLEAN)
    SELF.orig_zip_2_wouldClean := TRIM((SALT39.StrType)le.orig_zip_2) <> TRIM((SALT39.StrType)clean_orig_zip_2);
    SELF.orig_zip4_2_Invalid := Fields.InValid_orig_zip4_2((SALT39.StrType)le.orig_zip4_2);
    clean_orig_zip4_2 := (TYPEOF(le.orig_zip4_2))Fields.Make_orig_zip4_2((SALT39.StrType)le.orig_zip4_2);
    clean_orig_zip4_2_Invalid := Fields.InValid_orig_zip4_2((SALT39.StrType)clean_orig_zip4_2);
    SELF.orig_zip4_2 := IF(withOnfail, clean_orig_zip4_2, le.orig_zip4_2); // ONFAIL(CLEAN)
    SELF.orig_zip4_2_wouldClean := TRIM((SALT39.StrType)le.orig_zip4_2) <> TRIM((SALT39.StrType)clean_orig_zip4_2);
    SELF.orig_clean_address_Invalid := Fields.InValid_orig_clean_address((SALT39.StrType)le.orig_clean_address);
    clean_orig_clean_address := (TYPEOF(le.orig_clean_address))Fields.Make_orig_clean_address((SALT39.StrType)le.orig_clean_address);
    clean_orig_clean_address_Invalid := Fields.InValid_orig_clean_address((SALT39.StrType)clean_orig_clean_address);
    SELF.orig_clean_address := IF(withOnfail, clean_orig_clean_address, le.orig_clean_address); // ONFAIL(CLEAN)
    SELF.orig_clean_address_wouldClean := TRIM((SALT39.StrType)le.orig_clean_address) <> TRIM((SALT39.StrType)clean_orig_clean_address);
    SELF.orig_clean_city_Invalid := Fields.InValid_orig_clean_city((SALT39.StrType)le.orig_clean_city);
    clean_orig_clean_city := (TYPEOF(le.orig_clean_city))Fields.Make_orig_clean_city((SALT39.StrType)le.orig_clean_city);
    clean_orig_clean_city_Invalid := Fields.InValid_orig_clean_city((SALT39.StrType)clean_orig_clean_city);
    SELF.orig_clean_city := IF(withOnfail, clean_orig_clean_city, le.orig_clean_city); // ONFAIL(CLEAN)
    SELF.orig_clean_city_wouldClean := TRIM((SALT39.StrType)le.orig_clean_city) <> TRIM((SALT39.StrType)clean_orig_clean_city);
    SELF.orig_clean_state_Invalid := Fields.InValid_orig_clean_state((SALT39.StrType)le.orig_clean_state);
    clean_orig_clean_state := (TYPEOF(le.orig_clean_state))Fields.Make_orig_clean_state((SALT39.StrType)le.orig_clean_state);
    clean_orig_clean_state_Invalid := Fields.InValid_orig_clean_state((SALT39.StrType)clean_orig_clean_state);
    SELF.orig_clean_state := IF(withOnfail, clean_orig_clean_state, le.orig_clean_state); // ONFAIL(CLEAN)
    SELF.orig_clean_state_wouldClean := TRIM((SALT39.StrType)le.orig_clean_state) <> TRIM((SALT39.StrType)clean_orig_clean_state);
    SELF.orig_clean_zip_Invalid := Fields.InValid_orig_clean_zip((SALT39.StrType)le.orig_clean_zip);
    clean_orig_clean_zip := (TYPEOF(le.orig_clean_zip))Fields.Make_orig_clean_zip((SALT39.StrType)le.orig_clean_zip);
    clean_orig_clean_zip_Invalid := Fields.InValid_orig_clean_zip((SALT39.StrType)clean_orig_clean_zip);
    SELF.orig_clean_zip := IF(withOnfail, clean_orig_clean_zip, le.orig_clean_zip); // ONFAIL(CLEAN)
    SELF.orig_clean_zip_wouldClean := TRIM((SALT39.StrType)le.orig_clean_zip) <> TRIM((SALT39.StrType)clean_orig_clean_zip);
    SELF.orig_clean_zip4_Invalid := Fields.InValid_orig_clean_zip4((SALT39.StrType)le.orig_clean_zip4);
    clean_orig_clean_zip4 := (TYPEOF(le.orig_clean_zip4))Fields.Make_orig_clean_zip4((SALT39.StrType)le.orig_clean_zip4);
    clean_orig_clean_zip4_Invalid := Fields.InValid_orig_clean_zip4((SALT39.StrType)clean_orig_clean_zip4);
    SELF.orig_clean_zip4 := IF(withOnfail, clean_orig_clean_zip4, le.orig_clean_zip4); // ONFAIL(CLEAN)
    SELF.orig_clean_zip4_wouldClean := TRIM((SALT39.StrType)le.orig_clean_zip4) <> TRIM((SALT39.StrType)clean_orig_clean_zip4);
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone := (TYPEOF(le.orig_phone))Fields.Make_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)clean_orig_phone);
    SELF.orig_phone := IF(withOnfail, clean_orig_phone, le.orig_phone); // ONFAIL(CLEAN)
    SELF.orig_phone_wouldClean := TRIM((SALT39.StrType)le.orig_phone) <> TRIM((SALT39.StrType)clean_orig_phone);
    SELF.orig_homephone_Invalid := Fields.InValid_orig_homephone((SALT39.StrType)le.orig_homephone);
    clean_orig_homephone := (TYPEOF(le.orig_homephone))Fields.Make_orig_homephone((SALT39.StrType)le.orig_homephone);
    clean_orig_homephone_Invalid := Fields.InValid_orig_homephone((SALT39.StrType)clean_orig_homephone);
    SELF.orig_homephone := IF(withOnfail, clean_orig_homephone, le.orig_homephone); // ONFAIL(CLEAN)
    SELF.orig_homephone_wouldClean := TRIM((SALT39.StrType)le.orig_homephone) <> TRIM((SALT39.StrType)clean_orig_homephone);
    SELF.orig_homephone_2_Invalid := Fields.InValid_orig_homephone_2((SALT39.StrType)le.orig_homephone_2);
    clean_orig_homephone_2 := (TYPEOF(le.orig_homephone_2))Fields.Make_orig_homephone_2((SALT39.StrType)le.orig_homephone_2);
    clean_orig_homephone_2_Invalid := Fields.InValid_orig_homephone_2((SALT39.StrType)clean_orig_homephone_2);
    SELF.orig_homephone_2 := IF(withOnfail, clean_orig_homephone_2, le.orig_homephone_2); // ONFAIL(CLEAN)
    SELF.orig_homephone_2_wouldClean := TRIM((SALT39.StrType)le.orig_homephone_2) <> TRIM((SALT39.StrType)clean_orig_homephone_2);
    SELF.orig_workphone_Invalid := Fields.InValid_orig_workphone((SALT39.StrType)le.orig_workphone);
    clean_orig_workphone := (TYPEOF(le.orig_workphone))Fields.Make_orig_workphone((SALT39.StrType)le.orig_workphone);
    clean_orig_workphone_Invalid := Fields.InValid_orig_workphone((SALT39.StrType)clean_orig_workphone);
    SELF.orig_workphone := IF(withOnfail, clean_orig_workphone, le.orig_workphone); // ONFAIL(CLEAN)
    SELF.orig_workphone_wouldClean := TRIM((SALT39.StrType)le.orig_workphone) <> TRIM((SALT39.StrType)clean_orig_workphone);
    SELF.orig_workphone_2_Invalid := Fields.InValid_orig_workphone_2((SALT39.StrType)le.orig_workphone_2);
    clean_orig_workphone_2 := (TYPEOF(le.orig_workphone_2))Fields.Make_orig_workphone_2((SALT39.StrType)le.orig_workphone_2);
    clean_orig_workphone_2_Invalid := Fields.InValid_orig_workphone_2((SALT39.StrType)clean_orig_workphone_2);
    SELF.orig_workphone_2 := IF(withOnfail, clean_orig_workphone_2, le.orig_workphone_2); // ONFAIL(CLEAN)
    SELF.orig_workphone_2_wouldClean := TRIM((SALT39.StrType)le.orig_workphone_2) <> TRIM((SALT39.StrType)clean_orig_workphone_2);
    SELF.orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn := (TYPEOF(le.orig_ssn))Fields.Make_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)clean_orig_ssn);
    SELF.orig_ssn := IF(withOnfail, clean_orig_ssn, le.orig_ssn); // ONFAIL(CLEAN)
    SELF.orig_ssn_wouldClean := TRIM((SALT39.StrType)le.orig_ssn) <> TRIM((SALT39.StrType)clean_orig_ssn);
    SELF.orig_ssn_2_Invalid := Fields.InValid_orig_ssn_2((SALT39.StrType)le.orig_ssn_2);
    clean_orig_ssn_2 := (TYPEOF(le.orig_ssn_2))Fields.Make_orig_ssn_2((SALT39.StrType)le.orig_ssn_2);
    clean_orig_ssn_2_Invalid := Fields.InValid_orig_ssn_2((SALT39.StrType)clean_orig_ssn_2);
    SELF.orig_ssn_2 := IF(withOnfail, clean_orig_ssn_2, le.orig_ssn_2); // ONFAIL(CLEAN)
    SELF.orig_ssn_2_wouldClean := TRIM((SALT39.StrType)le.orig_ssn_2) <> TRIM((SALT39.StrType)clean_orig_ssn_2);
    SELF.orig_free_Invalid := Fields.InValid_orig_free((SALT39.StrType)le.orig_free);
    clean_orig_free := (TYPEOF(le.orig_free))Fields.Make_orig_free((SALT39.StrType)le.orig_free);
    clean_orig_free_Invalid := Fields.InValid_orig_free((SALT39.StrType)clean_orig_free);
    SELF.orig_free := IF(withOnfail, clean_orig_free, le.orig_free); // ONFAIL(CLEAN)
    SELF.orig_free_wouldClean := TRIM((SALT39.StrType)le.orig_free) <> TRIM((SALT39.StrType)clean_orig_free);
    SELF.orig_record_count_Invalid := Fields.InValid_orig_record_count((SALT39.StrType)le.orig_record_count);
    clean_orig_record_count := (TYPEOF(le.orig_record_count))Fields.Make_orig_record_count((SALT39.StrType)le.orig_record_count);
    clean_orig_record_count_Invalid := Fields.InValid_orig_record_count((SALT39.StrType)clean_orig_record_count);
    SELF.orig_record_count := IF(withOnfail, clean_orig_record_count, le.orig_record_count); // ONFAIL(CLEAN)
    SELF.orig_record_count_wouldClean := TRIM((SALT39.StrType)le.orig_record_count) <> TRIM((SALT39.StrType)clean_orig_record_count);
    SELF.orig_price_Invalid := Fields.InValid_orig_price((SALT39.StrType)le.orig_price);
    clean_orig_price := (TYPEOF(le.orig_price))Fields.Make_orig_price((SALT39.StrType)le.orig_price);
    clean_orig_price_Invalid := Fields.InValid_orig_price((SALT39.StrType)clean_orig_price);
    SELF.orig_price := IF(withOnfail, clean_orig_price, le.orig_price); // ONFAIL(CLEAN)
    SELF.orig_price_wouldClean := TRIM((SALT39.StrType)le.orig_price) <> TRIM((SALT39.StrType)clean_orig_price);
    SELF.orig_revenue_Invalid := Fields.InValid_orig_revenue((SALT39.StrType)le.orig_revenue);
    clean_orig_revenue := (TYPEOF(le.orig_revenue))Fields.Make_orig_revenue((SALT39.StrType)le.orig_revenue);
    clean_orig_revenue_Invalid := Fields.InValid_orig_revenue((SALT39.StrType)clean_orig_revenue);
    SELF.orig_revenue := IF(withOnfail, clean_orig_revenue, le.orig_revenue); // ONFAIL(CLEAN)
    SELF.orig_revenue_wouldClean := TRIM((SALT39.StrType)le.orig_revenue) <> TRIM((SALT39.StrType)clean_orig_revenue);
    SELF.orig_full_name_Invalid := Fields.InValid_orig_full_name((SALT39.StrType)le.orig_full_name);
    clean_orig_full_name := (TYPEOF(le.orig_full_name))Fields.Make_orig_full_name((SALT39.StrType)le.orig_full_name);
    clean_orig_full_name_Invalid := Fields.InValid_orig_full_name((SALT39.StrType)clean_orig_full_name);
    SELF.orig_full_name := IF(withOnfail, clean_orig_full_name, le.orig_full_name); // ONFAIL(CLEAN)
    SELF.orig_full_name_wouldClean := TRIM((SALT39.StrType)le.orig_full_name) <> TRIM((SALT39.StrType)clean_orig_full_name);
    SELF.orig_business_name_Invalid := Fields.InValid_orig_business_name((SALT39.StrType)le.orig_business_name);
    clean_orig_business_name := (TYPEOF(le.orig_business_name))Fields.Make_orig_business_name((SALT39.StrType)le.orig_business_name);
    clean_orig_business_name_Invalid := Fields.InValid_orig_business_name((SALT39.StrType)clean_orig_business_name);
    SELF.orig_business_name := IF(withOnfail, clean_orig_business_name, le.orig_business_name); // ONFAIL(CLEAN)
    SELF.orig_business_name_wouldClean := TRIM((SALT39.StrType)le.orig_business_name) <> TRIM((SALT39.StrType)clean_orig_business_name);
    SELF.orig_business_name_2_Invalid := Fields.InValid_orig_business_name_2((SALT39.StrType)le.orig_business_name_2);
    clean_orig_business_name_2 := (TYPEOF(le.orig_business_name_2))Fields.Make_orig_business_name_2((SALT39.StrType)le.orig_business_name_2);
    clean_orig_business_name_2_Invalid := Fields.InValid_orig_business_name_2((SALT39.StrType)clean_orig_business_name_2);
    SELF.orig_business_name_2 := IF(withOnfail, clean_orig_business_name_2, le.orig_business_name_2); // ONFAIL(CLEAN)
    SELF.orig_business_name_2_wouldClean := TRIM((SALT39.StrType)le.orig_business_name_2) <> TRIM((SALT39.StrType)clean_orig_business_name_2);
    SELF.orig_years_Invalid := Fields.InValid_orig_years((SALT39.StrType)le.orig_years);
    clean_orig_years := (TYPEOF(le.orig_years))Fields.Make_orig_years((SALT39.StrType)le.orig_years);
    clean_orig_years_Invalid := Fields.InValid_orig_years((SALT39.StrType)clean_orig_years);
    SELF.orig_years := IF(withOnfail, clean_orig_years, le.orig_years); // ONFAIL(CLEAN)
    SELF.orig_years_wouldClean := TRIM((SALT39.StrType)le.orig_years) <> TRIM((SALT39.StrType)clean_orig_years);
    SELF.orig_pricing_error_code_Invalid := Fields.InValid_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code);
    clean_orig_pricing_error_code := (TYPEOF(le.orig_pricing_error_code))Fields.Make_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code);
    clean_orig_pricing_error_code_Invalid := Fields.InValid_orig_pricing_error_code((SALT39.StrType)clean_orig_pricing_error_code);
    SELF.orig_pricing_error_code := IF(withOnfail, clean_orig_pricing_error_code, le.orig_pricing_error_code); // ONFAIL(CLEAN)
    SELF.orig_pricing_error_code_wouldClean := TRIM((SALT39.StrType)le.orig_pricing_error_code) <> TRIM((SALT39.StrType)clean_orig_pricing_error_code);
    SELF.orig_fcra_purpose_Invalid := Fields.InValid_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose);
    clean_orig_fcra_purpose := (TYPEOF(le.orig_fcra_purpose))Fields.Make_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose);
    clean_orig_fcra_purpose_Invalid := Fields.InValid_orig_fcra_purpose((SALT39.StrType)clean_orig_fcra_purpose);
    SELF.orig_fcra_purpose := IF(withOnfail, clean_orig_fcra_purpose, le.orig_fcra_purpose); // ONFAIL(CLEAN)
    SELF.orig_fcra_purpose_wouldClean := TRIM((SALT39.StrType)le.orig_fcra_purpose) <> TRIM((SALT39.StrType)clean_orig_fcra_purpose);
    SELF.orig_result_format_Invalid := Fields.InValid_orig_result_format((SALT39.StrType)le.orig_result_format);
    clean_orig_result_format := (TYPEOF(le.orig_result_format))Fields.Make_orig_result_format((SALT39.StrType)le.orig_result_format);
    clean_orig_result_format_Invalid := Fields.InValid_orig_result_format((SALT39.StrType)clean_orig_result_format);
    SELF.orig_result_format := IF(withOnfail, clean_orig_result_format, le.orig_result_format); // ONFAIL(CLEAN)
    SELF.orig_result_format_wouldClean := TRIM((SALT39.StrType)le.orig_result_format) <> TRIM((SALT39.StrType)clean_orig_result_format);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob);
    clean_orig_dob := (TYPEOF(le.orig_dob))Fields.Make_orig_dob((SALT39.StrType)le.orig_dob);
    clean_orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)clean_orig_dob);
    SELF.orig_dob := IF(withOnfail, clean_orig_dob, le.orig_dob); // ONFAIL(CLEAN)
    SELF.orig_dob_wouldClean := TRIM((SALT39.StrType)le.orig_dob) <> TRIM((SALT39.StrType)clean_orig_dob);
    SELF.orig_dob_2_Invalid := Fields.InValid_orig_dob_2((SALT39.StrType)le.orig_dob_2);
    clean_orig_dob_2 := (TYPEOF(le.orig_dob_2))Fields.Make_orig_dob_2((SALT39.StrType)le.orig_dob_2);
    clean_orig_dob_2_Invalid := Fields.InValid_orig_dob_2((SALT39.StrType)clean_orig_dob_2);
    SELF.orig_dob_2 := IF(withOnfail, clean_orig_dob_2, le.orig_dob_2); // ONFAIL(CLEAN)
    SELF.orig_dob_2_wouldClean := TRIM((SALT39.StrType)le.orig_dob_2) <> TRIM((SALT39.StrType)clean_orig_dob_2);
    SELF.orig_unique_id_Invalid := Fields.InValid_orig_unique_id((SALT39.StrType)le.orig_unique_id);
    clean_orig_unique_id := (TYPEOF(le.orig_unique_id))Fields.Make_orig_unique_id((SALT39.StrType)le.orig_unique_id);
    clean_orig_unique_id_Invalid := Fields.InValid_orig_unique_id((SALT39.StrType)clean_orig_unique_id);
    SELF.orig_unique_id := IF(withOnfail, clean_orig_unique_id, le.orig_unique_id); // ONFAIL(CLEAN)
    SELF.orig_unique_id_wouldClean := TRIM((SALT39.StrType)le.orig_unique_id) <> TRIM((SALT39.StrType)clean_orig_unique_id);
    SELF.orig_response_time_Invalid := Fields.InValid_orig_response_time((SALT39.StrType)le.orig_response_time);
    clean_orig_response_time := (TYPEOF(le.orig_response_time))Fields.Make_orig_response_time((SALT39.StrType)le.orig_response_time);
    clean_orig_response_time_Invalid := Fields.InValid_orig_response_time((SALT39.StrType)clean_orig_response_time);
    SELF.orig_response_time := IF(withOnfail, clean_orig_response_time, le.orig_response_time); // ONFAIL(CLEAN)
    SELF.orig_response_time_wouldClean := TRIM((SALT39.StrType)le.orig_response_time) <> TRIM((SALT39.StrType)clean_orig_response_time);
    SELF.orig_data_source_Invalid := Fields.InValid_orig_data_source((SALT39.StrType)le.orig_data_source);
    clean_orig_data_source := (TYPEOF(le.orig_data_source))Fields.Make_orig_data_source((SALT39.StrType)le.orig_data_source);
    clean_orig_data_source_Invalid := Fields.InValid_orig_data_source((SALT39.StrType)clean_orig_data_source);
    SELF.orig_data_source := IF(withOnfail, clean_orig_data_source, le.orig_data_source); // ONFAIL(CLEAN)
    SELF.orig_data_source_wouldClean := TRIM((SALT39.StrType)le.orig_data_source) <> TRIM((SALT39.StrType)clean_orig_data_source);
    SELF.orig_report_options_Invalid := Fields.InValid_orig_report_options((SALT39.StrType)le.orig_report_options);
    clean_orig_report_options := (TYPEOF(le.orig_report_options))Fields.Make_orig_report_options((SALT39.StrType)le.orig_report_options);
    clean_orig_report_options_Invalid := Fields.InValid_orig_report_options((SALT39.StrType)clean_orig_report_options);
    SELF.orig_report_options := IF(withOnfail, clean_orig_report_options, le.orig_report_options); // ONFAIL(CLEAN)
    SELF.orig_report_options_wouldClean := TRIM((SALT39.StrType)le.orig_report_options) <> TRIM((SALT39.StrType)clean_orig_report_options);
    SELF.orig_end_user_name_Invalid := Fields.InValid_orig_end_user_name((SALT39.StrType)le.orig_end_user_name);
    clean_orig_end_user_name := (TYPEOF(le.orig_end_user_name))Fields.Make_orig_end_user_name((SALT39.StrType)le.orig_end_user_name);
    clean_orig_end_user_name_Invalid := Fields.InValid_orig_end_user_name((SALT39.StrType)clean_orig_end_user_name);
    SELF.orig_end_user_name := IF(withOnfail, clean_orig_end_user_name, le.orig_end_user_name); // ONFAIL(CLEAN)
    SELF.orig_end_user_name_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_name) <> TRIM((SALT39.StrType)clean_orig_end_user_name);
    SELF.orig_end_user_address_1_Invalid := Fields.InValid_orig_end_user_address_1((SALT39.StrType)le.orig_end_user_address_1);
    clean_orig_end_user_address_1 := (TYPEOF(le.orig_end_user_address_1))Fields.Make_orig_end_user_address_1((SALT39.StrType)le.orig_end_user_address_1);
    clean_orig_end_user_address_1_Invalid := Fields.InValid_orig_end_user_address_1((SALT39.StrType)clean_orig_end_user_address_1);
    SELF.orig_end_user_address_1 := IF(withOnfail, clean_orig_end_user_address_1, le.orig_end_user_address_1); // ONFAIL(CLEAN)
    SELF.orig_end_user_address_1_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_address_1) <> TRIM((SALT39.StrType)clean_orig_end_user_address_1);
    SELF.orig_end_user_address_2_Invalid := Fields.InValid_orig_end_user_address_2((SALT39.StrType)le.orig_end_user_address_2);
    clean_orig_end_user_address_2 := (TYPEOF(le.orig_end_user_address_2))Fields.Make_orig_end_user_address_2((SALT39.StrType)le.orig_end_user_address_2);
    clean_orig_end_user_address_2_Invalid := Fields.InValid_orig_end_user_address_2((SALT39.StrType)clean_orig_end_user_address_2);
    SELF.orig_end_user_address_2 := IF(withOnfail, clean_orig_end_user_address_2, le.orig_end_user_address_2); // ONFAIL(CLEAN)
    SELF.orig_end_user_address_2_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_address_2) <> TRIM((SALT39.StrType)clean_orig_end_user_address_2);
    SELF.orig_end_user_city_Invalid := Fields.InValid_orig_end_user_city((SALT39.StrType)le.orig_end_user_city);
    clean_orig_end_user_city := (TYPEOF(le.orig_end_user_city))Fields.Make_orig_end_user_city((SALT39.StrType)le.orig_end_user_city);
    clean_orig_end_user_city_Invalid := Fields.InValid_orig_end_user_city((SALT39.StrType)clean_orig_end_user_city);
    SELF.orig_end_user_city := IF(withOnfail, clean_orig_end_user_city, le.orig_end_user_city); // ONFAIL(CLEAN)
    SELF.orig_end_user_city_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_city) <> TRIM((SALT39.StrType)clean_orig_end_user_city);
    SELF.orig_end_user_state_Invalid := Fields.InValid_orig_end_user_state((SALT39.StrType)le.orig_end_user_state);
    clean_orig_end_user_state := (TYPEOF(le.orig_end_user_state))Fields.Make_orig_end_user_state((SALT39.StrType)le.orig_end_user_state);
    clean_orig_end_user_state_Invalid := Fields.InValid_orig_end_user_state((SALT39.StrType)clean_orig_end_user_state);
    SELF.orig_end_user_state := IF(withOnfail, clean_orig_end_user_state, le.orig_end_user_state); // ONFAIL(CLEAN)
    SELF.orig_end_user_state_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_state) <> TRIM((SALT39.StrType)clean_orig_end_user_state);
    SELF.orig_end_user_zip_Invalid := Fields.InValid_orig_end_user_zip((SALT39.StrType)le.orig_end_user_zip);
    clean_orig_end_user_zip := (TYPEOF(le.orig_end_user_zip))Fields.Make_orig_end_user_zip((SALT39.StrType)le.orig_end_user_zip);
    clean_orig_end_user_zip_Invalid := Fields.InValid_orig_end_user_zip((SALT39.StrType)clean_orig_end_user_zip);
    SELF.orig_end_user_zip := IF(withOnfail, clean_orig_end_user_zip, le.orig_end_user_zip); // ONFAIL(CLEAN)
    SELF.orig_end_user_zip_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_zip) <> TRIM((SALT39.StrType)clean_orig_end_user_zip);
    SELF.orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    clean_orig_login_history_id := (TYPEOF(le.orig_login_history_id))Fields.Make_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    clean_orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)clean_orig_login_history_id);
    SELF.orig_login_history_id := IF(withOnfail, clean_orig_login_history_id, le.orig_login_history_id); // ONFAIL(CLEAN)
    SELF.orig_login_history_id_wouldClean := TRIM((SALT39.StrType)le.orig_login_history_id) <> TRIM((SALT39.StrType)clean_orig_login_history_id);
    SELF.orig_employment_state_Invalid := Fields.InValid_orig_employment_state((SALT39.StrType)le.orig_employment_state);
    clean_orig_employment_state := (TYPEOF(le.orig_employment_state))Fields.Make_orig_employment_state((SALT39.StrType)le.orig_employment_state);
    clean_orig_employment_state_Invalid := Fields.InValid_orig_employment_state((SALT39.StrType)clean_orig_employment_state);
    SELF.orig_employment_state := IF(withOnfail, clean_orig_employment_state, le.orig_employment_state); // ONFAIL(CLEAN)
    SELF.orig_employment_state_wouldClean := TRIM((SALT39.StrType)le.orig_employment_state) <> TRIM((SALT39.StrType)clean_orig_employment_state);
    SELF.orig_end_user_industry_class_Invalid := Fields.InValid_orig_end_user_industry_class((SALT39.StrType)le.orig_end_user_industry_class);
    clean_orig_end_user_industry_class := (TYPEOF(le.orig_end_user_industry_class))Fields.Make_orig_end_user_industry_class((SALT39.StrType)le.orig_end_user_industry_class);
    clean_orig_end_user_industry_class_Invalid := Fields.InValid_orig_end_user_industry_class((SALT39.StrType)clean_orig_end_user_industry_class);
    SELF.orig_end_user_industry_class := IF(withOnfail, clean_orig_end_user_industry_class, le.orig_end_user_industry_class); // ONFAIL(CLEAN)
    SELF.orig_end_user_industry_class_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_industry_class) <> TRIM((SALT39.StrType)clean_orig_end_user_industry_class);
    SELF.orig_function_specific_data_Invalid := Fields.InValid_orig_function_specific_data((SALT39.StrType)le.orig_function_specific_data);
    clean_orig_function_specific_data := (TYPEOF(le.orig_function_specific_data))Fields.Make_orig_function_specific_data((SALT39.StrType)le.orig_function_specific_data);
    clean_orig_function_specific_data_Invalid := Fields.InValid_orig_function_specific_data((SALT39.StrType)clean_orig_function_specific_data);
    SELF.orig_function_specific_data := IF(withOnfail, clean_orig_function_specific_data, le.orig_function_specific_data); // ONFAIL(CLEAN)
    SELF.orig_function_specific_data_wouldClean := TRIM((SALT39.StrType)le.orig_function_specific_data) <> TRIM((SALT39.StrType)clean_orig_function_specific_data);
    SELF.orig_date_added_Invalid := Fields.InValid_orig_date_added((SALT39.StrType)le.orig_date_added);
    clean_orig_date_added := (TYPEOF(le.orig_date_added))Fields.Make_orig_date_added((SALT39.StrType)le.orig_date_added);
    clean_orig_date_added_Invalid := Fields.InValid_orig_date_added((SALT39.StrType)clean_orig_date_added);
    SELF.orig_date_added := IF(withOnfail, clean_orig_date_added, le.orig_date_added); // ONFAIL(CLEAN)
    SELF.orig_date_added_wouldClean := TRIM((SALT39.StrType)le.orig_date_added) <> TRIM((SALT39.StrType)clean_orig_date_added);
    SELF.orig_retail_price_Invalid := Fields.InValid_orig_retail_price((SALT39.StrType)le.orig_retail_price);
    clean_orig_retail_price := (TYPEOF(le.orig_retail_price))Fields.Make_orig_retail_price((SALT39.StrType)le.orig_retail_price);
    clean_orig_retail_price_Invalid := Fields.InValid_orig_retail_price((SALT39.StrType)clean_orig_retail_price);
    SELF.orig_retail_price := IF(withOnfail, clean_orig_retail_price, le.orig_retail_price); // ONFAIL(CLEAN)
    SELF.orig_retail_price_wouldClean := TRIM((SALT39.StrType)le.orig_retail_price) <> TRIM((SALT39.StrType)clean_orig_retail_price);
    SELF.orig_country_code_Invalid := Fields.InValid_orig_country_code((SALT39.StrType)le.orig_country_code);
    clean_orig_country_code := (TYPEOF(le.orig_country_code))Fields.Make_orig_country_code((SALT39.StrType)le.orig_country_code);
    clean_orig_country_code_Invalid := Fields.InValid_orig_country_code((SALT39.StrType)clean_orig_country_code);
    SELF.orig_country_code := IF(withOnfail, clean_orig_country_code, le.orig_country_code); // ONFAIL(CLEAN)
    SELF.orig_country_code_wouldClean := TRIM((SALT39.StrType)le.orig_country_code) <> TRIM((SALT39.StrType)clean_orig_country_code);
    SELF.orig_email_Invalid := Fields.InValid_orig_email((SALT39.StrType)le.orig_email);
    clean_orig_email := (TYPEOF(le.orig_email))Fields.Make_orig_email((SALT39.StrType)le.orig_email);
    clean_orig_email_Invalid := Fields.InValid_orig_email((SALT39.StrType)clean_orig_email);
    SELF.orig_email := IF(withOnfail, clean_orig_email, le.orig_email); // ONFAIL(CLEAN)
    SELF.orig_email_wouldClean := TRIM((SALT39.StrType)le.orig_email) <> TRIM((SALT39.StrType)clean_orig_email);
    SELF.orig_email_2_Invalid := Fields.InValid_orig_email_2((SALT39.StrType)le.orig_email_2);
    clean_orig_email_2 := (TYPEOF(le.orig_email_2))Fields.Make_orig_email_2((SALT39.StrType)le.orig_email_2);
    clean_orig_email_2_Invalid := Fields.InValid_orig_email_2((SALT39.StrType)clean_orig_email_2);
    SELF.orig_email_2 := IF(withOnfail, clean_orig_email_2, le.orig_email_2); // ONFAIL(CLEAN)
    SELF.orig_email_2_wouldClean := TRIM((SALT39.StrType)le.orig_email_2) <> TRIM((SALT39.StrType)clean_orig_email_2);
    SELF.orig_dl_number_Invalid := Fields.InValid_orig_dl_number((SALT39.StrType)le.orig_dl_number);
    clean_orig_dl_number := (TYPEOF(le.orig_dl_number))Fields.Make_orig_dl_number((SALT39.StrType)le.orig_dl_number);
    clean_orig_dl_number_Invalid := Fields.InValid_orig_dl_number((SALT39.StrType)clean_orig_dl_number);
    SELF.orig_dl_number := IF(withOnfail, clean_orig_dl_number, le.orig_dl_number); // ONFAIL(CLEAN)
    SELF.orig_dl_number_wouldClean := TRIM((SALT39.StrType)le.orig_dl_number) <> TRIM((SALT39.StrType)clean_orig_dl_number);
    SELF.orig_dl_number_2_Invalid := Fields.InValid_orig_dl_number_2((SALT39.StrType)le.orig_dl_number_2);
    clean_orig_dl_number_2 := (TYPEOF(le.orig_dl_number_2))Fields.Make_orig_dl_number_2((SALT39.StrType)le.orig_dl_number_2);
    clean_orig_dl_number_2_Invalid := Fields.InValid_orig_dl_number_2((SALT39.StrType)clean_orig_dl_number_2);
    SELF.orig_dl_number_2 := IF(withOnfail, clean_orig_dl_number_2, le.orig_dl_number_2); // ONFAIL(CLEAN)
    SELF.orig_dl_number_2_wouldClean := TRIM((SALT39.StrType)le.orig_dl_number_2) <> TRIM((SALT39.StrType)clean_orig_dl_number_2);
    SELF.orig_sub_id_Invalid := Fields.InValid_orig_sub_id((SALT39.StrType)le.orig_sub_id);
    clean_orig_sub_id := (TYPEOF(le.orig_sub_id))Fields.Make_orig_sub_id((SALT39.StrType)le.orig_sub_id);
    clean_orig_sub_id_Invalid := Fields.InValid_orig_sub_id((SALT39.StrType)clean_orig_sub_id);
    SELF.orig_sub_id := IF(withOnfail, clean_orig_sub_id, le.orig_sub_id); // ONFAIL(CLEAN)
    SELF.orig_sub_id_wouldClean := TRIM((SALT39.StrType)le.orig_sub_id) <> TRIM((SALT39.StrType)clean_orig_sub_id);
    SELF.orig_neighbors_Invalid := Fields.InValid_orig_neighbors((SALT39.StrType)le.orig_neighbors);
    clean_orig_neighbors := (TYPEOF(le.orig_neighbors))Fields.Make_orig_neighbors((SALT39.StrType)le.orig_neighbors);
    clean_orig_neighbors_Invalid := Fields.InValid_orig_neighbors((SALT39.StrType)clean_orig_neighbors);
    SELF.orig_neighbors := IF(withOnfail, clean_orig_neighbors, le.orig_neighbors); // ONFAIL(CLEAN)
    SELF.orig_neighbors_wouldClean := TRIM((SALT39.StrType)le.orig_neighbors) <> TRIM((SALT39.StrType)clean_orig_neighbors);
    SELF.orig_relatives_Invalid := Fields.InValid_orig_relatives((SALT39.StrType)le.orig_relatives);
    clean_orig_relatives := (TYPEOF(le.orig_relatives))Fields.Make_orig_relatives((SALT39.StrType)le.orig_relatives);
    clean_orig_relatives_Invalid := Fields.InValid_orig_relatives((SALT39.StrType)clean_orig_relatives);
    SELF.orig_relatives := IF(withOnfail, clean_orig_relatives, le.orig_relatives); // ONFAIL(CLEAN)
    SELF.orig_relatives_wouldClean := TRIM((SALT39.StrType)le.orig_relatives) <> TRIM((SALT39.StrType)clean_orig_relatives);
    SELF.orig_associates_Invalid := Fields.InValid_orig_associates((SALT39.StrType)le.orig_associates);
    clean_orig_associates := (TYPEOF(le.orig_associates))Fields.Make_orig_associates((SALT39.StrType)le.orig_associates);
    clean_orig_associates_Invalid := Fields.InValid_orig_associates((SALT39.StrType)clean_orig_associates);
    SELF.orig_associates := IF(withOnfail, clean_orig_associates, le.orig_associates); // ONFAIL(CLEAN)
    SELF.orig_associates_wouldClean := TRIM((SALT39.StrType)le.orig_associates) <> TRIM((SALT39.StrType)clean_orig_associates);
    SELF.orig_property_Invalid := Fields.InValid_orig_property((SALT39.StrType)le.orig_property);
    clean_orig_property := (TYPEOF(le.orig_property))Fields.Make_orig_property((SALT39.StrType)le.orig_property);
    clean_orig_property_Invalid := Fields.InValid_orig_property((SALT39.StrType)clean_orig_property);
    SELF.orig_property := IF(withOnfail, clean_orig_property, le.orig_property); // ONFAIL(CLEAN)
    SELF.orig_property_wouldClean := TRIM((SALT39.StrType)le.orig_property) <> TRIM((SALT39.StrType)clean_orig_property);
    SELF.orig_bankruptcy_Invalid := Fields.InValid_orig_bankruptcy((SALT39.StrType)le.orig_bankruptcy);
    clean_orig_bankruptcy := (TYPEOF(le.orig_bankruptcy))Fields.Make_orig_bankruptcy((SALT39.StrType)le.orig_bankruptcy);
    clean_orig_bankruptcy_Invalid := Fields.InValid_orig_bankruptcy((SALT39.StrType)clean_orig_bankruptcy);
    SELF.orig_bankruptcy := IF(withOnfail, clean_orig_bankruptcy, le.orig_bankruptcy); // ONFAIL(CLEAN)
    SELF.orig_bankruptcy_wouldClean := TRIM((SALT39.StrType)le.orig_bankruptcy) <> TRIM((SALT39.StrType)clean_orig_bankruptcy);
    SELF.orig_dls_Invalid := Fields.InValid_orig_dls((SALT39.StrType)le.orig_dls);
    clean_orig_dls := (TYPEOF(le.orig_dls))Fields.Make_orig_dls((SALT39.StrType)le.orig_dls);
    clean_orig_dls_Invalid := Fields.InValid_orig_dls((SALT39.StrType)clean_orig_dls);
    SELF.orig_dls := IF(withOnfail, clean_orig_dls, le.orig_dls); // ONFAIL(CLEAN)
    SELF.orig_dls_wouldClean := TRIM((SALT39.StrType)le.orig_dls) <> TRIM((SALT39.StrType)clean_orig_dls);
    SELF.orig_mvs_Invalid := Fields.InValid_orig_mvs((SALT39.StrType)le.orig_mvs);
    clean_orig_mvs := (TYPEOF(le.orig_mvs))Fields.Make_orig_mvs((SALT39.StrType)le.orig_mvs);
    clean_orig_mvs_Invalid := Fields.InValid_orig_mvs((SALT39.StrType)clean_orig_mvs);
    SELF.orig_mvs := IF(withOnfail, clean_orig_mvs, le.orig_mvs); // ONFAIL(CLEAN)
    SELF.orig_mvs_wouldClean := TRIM((SALT39.StrType)le.orig_mvs) <> TRIM((SALT39.StrType)clean_orig_mvs);
    SELF.orig_ip_address_Invalid := Fields.InValid_orig_ip_address((SALT39.StrType)le.orig_ip_address);
    clean_orig_ip_address := (TYPEOF(le.orig_ip_address))Fields.Make_orig_ip_address((SALT39.StrType)le.orig_ip_address);
    clean_orig_ip_address_Invalid := Fields.InValid_orig_ip_address((SALT39.StrType)clean_orig_ip_address);
    SELF.orig_ip_address := IF(withOnfail, clean_orig_ip_address, le.orig_ip_address); // ONFAIL(CLEAN)
    SELF.orig_ip_address_wouldClean := TRIM((SALT39.StrType)le.orig_ip_address) <> TRIM((SALT39.StrType)clean_orig_ip_address);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_FILE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_login_id_Invalid << 0 ) + ( le.orig_billing_code_Invalid << 2 ) + ( le.orig_transaction_id_Invalid << 5 ) + ( le.orig_function_name_Invalid << 7 ) + ( le.orig_company_id_Invalid << 9 ) + ( le.orig_reference_code_Invalid << 11 ) + ( le.orig_fname_Invalid << 13 ) + ( le.orig_mname_Invalid << 15 ) + ( le.orig_lname_Invalid << 17 ) + ( le.orig_name_suffix_Invalid << 19 ) + ( le.orig_fname_2_Invalid << 22 ) + ( le.orig_mname_2_Invalid << 25 ) + ( le.orig_lname_2_Invalid << 28 ) + ( le.orig_name_suffix_2_Invalid << 31 ) + ( le.orig_address_Invalid << 34 ) + ( le.orig_city_Invalid << 36 ) + ( le.orig_state_Invalid << 38 ) + ( le.orig_zip_Invalid << 41 ) + ( le.orig_zip4_Invalid << 43 ) + ( le.orig_address_2_Invalid << 45 ) + ( le.orig_city_2_Invalid << 48 ) + ( le.orig_state_2_Invalid << 51 ) + ( le.orig_zip_2_Invalid << 54 ) + ( le.orig_zip4_2_Invalid << 57 ) + ( le.orig_clean_address_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.orig_clean_city_Invalid << 0 ) + ( le.orig_clean_state_Invalid << 3 ) + ( le.orig_clean_zip_Invalid << 6 ) + ( le.orig_clean_zip4_Invalid << 9 ) + ( le.orig_phone_Invalid << 12 ) + ( le.orig_homephone_Invalid << 15 ) + ( le.orig_homephone_2_Invalid << 18 ) + ( le.orig_workphone_Invalid << 21 ) + ( le.orig_workphone_2_Invalid << 24 ) + ( le.orig_ssn_Invalid << 27 ) + ( le.orig_ssn_2_Invalid << 30 ) + ( le.orig_free_Invalid << 33 ) + ( le.orig_record_count_Invalid << 36 ) + ( le.orig_price_Invalid << 39 ) + ( le.orig_revenue_Invalid << 41 ) + ( le.orig_full_name_Invalid << 44 ) + ( le.orig_business_name_Invalid << 46 ) + ( le.orig_business_name_2_Invalid << 49 ) + ( le.orig_years_Invalid << 52 ) + ( le.orig_pricing_error_code_Invalid << 55 ) + ( le.orig_fcra_purpose_Invalid << 58 ) + ( le.orig_result_format_Invalid << 61 );
    SELF.ScrubsBits3 := ( le.orig_dob_Invalid << 0 ) + ( le.orig_dob_2_Invalid << 3 ) + ( le.orig_unique_id_Invalid << 6 ) + ( le.orig_response_time_Invalid << 8 ) + ( le.orig_data_source_Invalid << 11 ) + ( le.orig_report_options_Invalid << 14 ) + ( le.orig_end_user_name_Invalid << 16 ) + ( le.orig_end_user_address_1_Invalid << 18 ) + ( le.orig_end_user_address_2_Invalid << 20 ) + ( le.orig_end_user_city_Invalid << 23 ) + ( le.orig_end_user_state_Invalid << 25 ) + ( le.orig_end_user_zip_Invalid << 28 ) + ( le.orig_login_history_id_Invalid << 30 ) + ( le.orig_employment_state_Invalid << 33 ) + ( le.orig_end_user_industry_class_Invalid << 36 ) + ( le.orig_function_specific_data_Invalid << 39 ) + ( le.orig_date_added_Invalid << 42 ) + ( le.orig_retail_price_Invalid << 45 ) + ( le.orig_country_code_Invalid << 47 ) + ( le.orig_email_Invalid << 50 ) + ( le.orig_email_2_Invalid << 52 ) + ( le.orig_dl_number_Invalid << 55 ) + ( le.orig_dl_number_2_Invalid << 57 ) + ( le.orig_sub_id_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.orig_neighbors_Invalid << 0 ) + ( le.orig_relatives_Invalid << 3 ) + ( le.orig_associates_Invalid << 6 ) + ( le.orig_property_Invalid << 9 ) + ( le.orig_bankruptcy_Invalid << 12 ) + ( le.orig_dls_Invalid << 15 ) + ( le.orig_mvs_Invalid << 18 ) + ( le.orig_ip_address_Invalid << 21 );
    SELF.ScrubsCleanBits1 := ( IF(le.orig_login_id_wouldClean, 1, 0) << 0 ) + ( IF(le.orig_billing_code_wouldClean, 1, 0) << 1 ) + ( IF(le.orig_transaction_id_wouldClean, 1, 0) << 2 ) + ( IF(le.orig_function_name_wouldClean, 1, 0) << 3 ) + ( IF(le.orig_company_id_wouldClean, 1, 0) << 4 ) + ( IF(le.orig_reference_code_wouldClean, 1, 0) << 5 ) + ( IF(le.orig_fname_wouldClean, 1, 0) << 6 ) + ( IF(le.orig_mname_wouldClean, 1, 0) << 7 ) + ( IF(le.orig_lname_wouldClean, 1, 0) << 8 ) + ( IF(le.orig_name_suffix_wouldClean, 1, 0) << 9 ) + ( IF(le.orig_fname_2_wouldClean, 1, 0) << 10 ) + ( IF(le.orig_mname_2_wouldClean, 1, 0) << 11 ) + ( IF(le.orig_lname_2_wouldClean, 1, 0) << 12 ) + ( IF(le.orig_name_suffix_2_wouldClean, 1, 0) << 13 ) + ( IF(le.orig_address_wouldClean, 1, 0) << 14 ) + ( IF(le.orig_city_wouldClean, 1, 0) << 15 ) + ( IF(le.orig_state_wouldClean, 1, 0) << 16 ) + ( IF(le.orig_zip_wouldClean, 1, 0) << 17 ) + ( IF(le.orig_zip4_wouldClean, 1, 0) << 18 ) + ( IF(le.orig_address_2_wouldClean, 1, 0) << 19 ) + ( IF(le.orig_city_2_wouldClean, 1, 0) << 20 ) + ( IF(le.orig_state_2_wouldClean, 1, 0) << 21 ) + ( IF(le.orig_zip_2_wouldClean, 1, 0) << 22 ) + ( IF(le.orig_zip4_2_wouldClean, 1, 0) << 23 ) + ( IF(le.orig_clean_address_wouldClean, 1, 0) << 24 ) + ( IF(le.orig_clean_city_wouldClean, 1, 0) << 25 ) + ( IF(le.orig_clean_state_wouldClean, 1, 0) << 26 ) + ( IF(le.orig_clean_zip_wouldClean, 1, 0) << 27 ) + ( IF(le.orig_clean_zip4_wouldClean, 1, 0) << 28 ) + ( IF(le.orig_phone_wouldClean, 1, 0) << 29 ) + ( IF(le.orig_homephone_wouldClean, 1, 0) << 30 ) + ( IF(le.orig_homephone_2_wouldClean, 1, 0) << 31 ) + ( IF(le.orig_workphone_wouldClean, 1, 0) << 32 ) + ( IF(le.orig_workphone_2_wouldClean, 1, 0) << 33 ) + ( IF(le.orig_ssn_wouldClean, 1, 0) << 34 ) + ( IF(le.orig_ssn_2_wouldClean, 1, 0) << 35 ) + ( IF(le.orig_free_wouldClean, 1, 0) << 36 ) + ( IF(le.orig_record_count_wouldClean, 1, 0) << 37 ) + ( IF(le.orig_price_wouldClean, 1, 0) << 38 ) + ( IF(le.orig_revenue_wouldClean, 1, 0) << 39 ) + ( IF(le.orig_full_name_wouldClean, 1, 0) << 40 ) + ( IF(le.orig_business_name_wouldClean, 1, 0) << 41 ) + ( IF(le.orig_business_name_2_wouldClean, 1, 0) << 42 ) + ( IF(le.orig_years_wouldClean, 1, 0) << 43 ) + ( IF(le.orig_pricing_error_code_wouldClean, 1, 0) << 44 ) + ( IF(le.orig_fcra_purpose_wouldClean, 1, 0) << 45 ) + ( IF(le.orig_result_format_wouldClean, 1, 0) << 46 ) + ( IF(le.orig_dob_wouldClean, 1, 0) << 47 ) + ( IF(le.orig_dob_2_wouldClean, 1, 0) << 48 ) + ( IF(le.orig_unique_id_wouldClean, 1, 0) << 49 ) + ( IF(le.orig_response_time_wouldClean, 1, 0) << 50 ) + ( IF(le.orig_data_source_wouldClean, 1, 0) << 51 ) + ( IF(le.orig_report_options_wouldClean, 1, 0) << 52 ) + ( IF(le.orig_end_user_name_wouldClean, 1, 0) << 53 ) + ( IF(le.orig_end_user_address_1_wouldClean, 1, 0) << 54 ) + ( IF(le.orig_end_user_address_2_wouldClean, 1, 0) << 55 ) + ( IF(le.orig_end_user_city_wouldClean, 1, 0) << 56 ) + ( IF(le.orig_end_user_state_wouldClean, 1, 0) << 57 ) + ( IF(le.orig_end_user_zip_wouldClean, 1, 0) << 58 ) + ( IF(le.orig_login_history_id_wouldClean, 1, 0) << 59 ) + ( IF(le.orig_employment_state_wouldClean, 1, 0) << 60 ) + ( IF(le.orig_end_user_industry_class_wouldClean, 1, 0) << 61 ) + ( IF(le.orig_function_specific_data_wouldClean, 1, 0) << 62 ) + ( IF(le.orig_date_added_wouldClean, 1, 0) << 63 );
    SELF.ScrubsCleanBits2 := ( IF(le.orig_retail_price_wouldClean, 1, 0) << 0 ) + ( IF(le.orig_country_code_wouldClean, 1, 0) << 1 ) + ( IF(le.orig_email_wouldClean, 1, 0) << 2 ) + ( IF(le.orig_email_2_wouldClean, 1, 0) << 3 ) + ( IF(le.orig_dl_number_wouldClean, 1, 0) << 4 ) + ( IF(le.orig_dl_number_2_wouldClean, 1, 0) << 5 ) + ( IF(le.orig_sub_id_wouldClean, 1, 0) << 6 ) + ( IF(le.orig_neighbors_wouldClean, 1, 0) << 7 ) + ( IF(le.orig_relatives_wouldClean, 1, 0) << 8 ) + ( IF(le.orig_associates_wouldClean, 1, 0) << 9 ) + ( IF(le.orig_property_wouldClean, 1, 0) << 10 ) + ( IF(le.orig_bankruptcy_wouldClean, 1, 0) << 11 ) + ( IF(le.orig_dls_wouldClean, 1, 0) << 12 ) + ( IF(le.orig_mvs_wouldClean, 1, 0) << 13 ) + ( IF(le.orig_ip_address_wouldClean, 1, 0) << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_FILE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_login_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_billing_code_Invalid := (le.ScrubsBits1 >> 2) & 7;
    SELF.orig_transaction_id_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.orig_function_name_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.orig_company_id_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.orig_reference_code_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.orig_name_suffix_Invalid := (le.ScrubsBits1 >> 19) & 7;
    SELF.orig_fname_2_Invalid := (le.ScrubsBits1 >> 22) & 7;
    SELF.orig_mname_2_Invalid := (le.ScrubsBits1 >> 25) & 7;
    SELF.orig_lname_2_Invalid := (le.ScrubsBits1 >> 28) & 7;
    SELF.orig_name_suffix_2_Invalid := (le.ScrubsBits1 >> 31) & 7;
    SELF.orig_address_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 38) & 7;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.orig_address_2_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.orig_city_2_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.orig_state_2_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.orig_zip_2_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.orig_zip4_2_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.orig_clean_address_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.orig_clean_city_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.orig_clean_state_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.orig_clean_zip_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.orig_clean_zip4_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.orig_phone_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.orig_homephone_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.orig_homephone_2_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.orig_workphone_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.orig_workphone_2_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.orig_ssn_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.orig_ssn_2_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.orig_free_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.orig_record_count_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.orig_price_Invalid := (le.ScrubsBits2 >> 39) & 3;
    SELF.orig_revenue_Invalid := (le.ScrubsBits2 >> 41) & 7;
    SELF.orig_full_name_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.orig_business_name_Invalid := (le.ScrubsBits2 >> 46) & 7;
    SELF.orig_business_name_2_Invalid := (le.ScrubsBits2 >> 49) & 7;
    SELF.orig_years_Invalid := (le.ScrubsBits2 >> 52) & 7;
    SELF.orig_pricing_error_code_Invalid := (le.ScrubsBits2 >> 55) & 7;
    SELF.orig_fcra_purpose_Invalid := (le.ScrubsBits2 >> 58) & 7;
    SELF.orig_result_format_Invalid := (le.ScrubsBits2 >> 61) & 7;
    SELF.orig_dob_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.orig_dob_2_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.orig_unique_id_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.orig_response_time_Invalid := (le.ScrubsBits3 >> 8) & 7;
    SELF.orig_data_source_Invalid := (le.ScrubsBits3 >> 11) & 7;
    SELF.orig_report_options_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.orig_end_user_name_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.orig_end_user_address_1_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.orig_end_user_address_2_Invalid := (le.ScrubsBits3 >> 20) & 7;
    SELF.orig_end_user_city_Invalid := (le.ScrubsBits3 >> 23) & 3;
    SELF.orig_end_user_state_Invalid := (le.ScrubsBits3 >> 25) & 7;
    SELF.orig_end_user_zip_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.orig_login_history_id_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.orig_employment_state_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.orig_end_user_industry_class_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.orig_function_specific_data_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.orig_date_added_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.orig_retail_price_Invalid := (le.ScrubsBits3 >> 45) & 3;
    SELF.orig_country_code_Invalid := (le.ScrubsBits3 >> 47) & 7;
    SELF.orig_email_Invalid := (le.ScrubsBits3 >> 50) & 3;
    SELF.orig_email_2_Invalid := (le.ScrubsBits3 >> 52) & 7;
    SELF.orig_dl_number_Invalid := (le.ScrubsBits3 >> 55) & 3;
    SELF.orig_dl_number_2_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.orig_sub_id_Invalid := (le.ScrubsBits3 >> 60) & 3;
    SELF.orig_neighbors_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.orig_relatives_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.orig_associates_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.orig_property_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.orig_bankruptcy_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.orig_dls_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.orig_mvs_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.orig_ip_address_Invalid := (le.ScrubsBits4 >> 21) & 3;
    SELF.orig_login_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.orig_billing_code_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.orig_transaction_id_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.orig_function_name_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.orig_company_id_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.orig_reference_code_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.orig_fname_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.orig_mname_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.orig_lname_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.orig_name_suffix_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.orig_fname_2_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.orig_mname_2_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.orig_lname_2_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.orig_name_suffix_2_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.orig_address_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.orig_city_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.orig_state_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.orig_zip_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.orig_zip4_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.orig_address_2_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.orig_city_2_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.orig_state_2_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.orig_zip_2_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.orig_zip4_2_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.orig_clean_address_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.orig_clean_city_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.orig_clean_state_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.orig_clean_zip_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.orig_clean_zip4_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.orig_phone_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.orig_homephone_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.orig_homephone_2_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.orig_workphone_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.orig_workphone_2_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.orig_ssn_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.orig_ssn_2_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.orig_free_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.orig_record_count_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.orig_price_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.orig_revenue_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.orig_full_name_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.orig_business_name_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.orig_business_name_2_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF.orig_years_wouldClean := le.ScrubsCleanBits1 >> 43;
    SELF.orig_pricing_error_code_wouldClean := le.ScrubsCleanBits1 >> 44;
    SELF.orig_fcra_purpose_wouldClean := le.ScrubsCleanBits1 >> 45;
    SELF.orig_result_format_wouldClean := le.ScrubsCleanBits1 >> 46;
    SELF.orig_dob_wouldClean := le.ScrubsCleanBits1 >> 47;
    SELF.orig_dob_2_wouldClean := le.ScrubsCleanBits1 >> 48;
    SELF.orig_unique_id_wouldClean := le.ScrubsCleanBits1 >> 49;
    SELF.orig_response_time_wouldClean := le.ScrubsCleanBits1 >> 50;
    SELF.orig_data_source_wouldClean := le.ScrubsCleanBits1 >> 51;
    SELF.orig_report_options_wouldClean := le.ScrubsCleanBits1 >> 52;
    SELF.orig_end_user_name_wouldClean := le.ScrubsCleanBits1 >> 53;
    SELF.orig_end_user_address_1_wouldClean := le.ScrubsCleanBits1 >> 54;
    SELF.orig_end_user_address_2_wouldClean := le.ScrubsCleanBits1 >> 55;
    SELF.orig_end_user_city_wouldClean := le.ScrubsCleanBits1 >> 56;
    SELF.orig_end_user_state_wouldClean := le.ScrubsCleanBits1 >> 57;
    SELF.orig_end_user_zip_wouldClean := le.ScrubsCleanBits1 >> 58;
    SELF.orig_login_history_id_wouldClean := le.ScrubsCleanBits1 >> 59;
    SELF.orig_employment_state_wouldClean := le.ScrubsCleanBits1 >> 60;
    SELF.orig_end_user_industry_class_wouldClean := le.ScrubsCleanBits1 >> 61;
    SELF.orig_function_specific_data_wouldClean := le.ScrubsCleanBits1 >> 62;
    SELF.orig_date_added_wouldClean := le.ScrubsCleanBits1 >> 63;
    SELF.orig_retail_price_wouldClean := le.ScrubsCleanBits2 >> 0;
    SELF.orig_country_code_wouldClean := le.ScrubsCleanBits2 >> 1;
    SELF.orig_email_wouldClean := le.ScrubsCleanBits2 >> 2;
    SELF.orig_email_2_wouldClean := le.ScrubsCleanBits2 >> 3;
    SELF.orig_dl_number_wouldClean := le.ScrubsCleanBits2 >> 4;
    SELF.orig_dl_number_2_wouldClean := le.ScrubsCleanBits2 >> 5;
    SELF.orig_sub_id_wouldClean := le.ScrubsCleanBits2 >> 6;
    SELF.orig_neighbors_wouldClean := le.ScrubsCleanBits2 >> 7;
    SELF.orig_relatives_wouldClean := le.ScrubsCleanBits2 >> 8;
    SELF.orig_associates_wouldClean := le.ScrubsCleanBits2 >> 9;
    SELF.orig_property_wouldClean := le.ScrubsCleanBits2 >> 10;
    SELF.orig_bankruptcy_wouldClean := le.ScrubsCleanBits2 >> 11;
    SELF.orig_dls_wouldClean := le.ScrubsCleanBits2 >> 12;
    SELF.orig_mvs_wouldClean := le.ScrubsCleanBits2 >> 13;
    SELF.orig_ip_address_wouldClean := le.ScrubsCleanBits2 >> 14;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_login_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_login_id_Invalid=1);
    orig_login_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_login_id_Invalid=1 AND h.orig_login_id_wouldClean);
    orig_login_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_login_id_Invalid=2);
    orig_login_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_login_id_Invalid=2 AND h.orig_login_id_wouldClean);
    orig_login_id_Total_ErrorCount := COUNT(GROUP,h.orig_login_id_Invalid>0);
    orig_billing_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=1);
    orig_billing_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_billing_code_Invalid=1 AND h.orig_billing_code_wouldClean);
    orig_billing_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=2);
    orig_billing_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_billing_code_Invalid=2 AND h.orig_billing_code_wouldClean);
    orig_billing_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=3);
    orig_billing_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_billing_code_Invalid=3 AND h.orig_billing_code_wouldClean);
    orig_billing_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=4);
    orig_billing_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_billing_code_Invalid=4 AND h.orig_billing_code_wouldClean);
    orig_billing_code_Total_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid>0);
    orig_transaction_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1);
    orig_transaction_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2);
    orig_transaction_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=3);
    orig_transaction_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=3 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid>0);
    orig_function_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=1);
    orig_function_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=1 AND h.orig_function_name_wouldClean);
    orig_function_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=2);
    orig_function_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=2 AND h.orig_function_name_wouldClean);
    orig_function_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=3);
    orig_function_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=3 AND h.orig_function_name_wouldClean);
    orig_function_name_Total_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid>0);
    orig_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=1);
    orig_company_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=1 AND h.orig_company_id_wouldClean);
    orig_company_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=2);
    orig_company_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=2 AND h.orig_company_id_wouldClean);
    orig_company_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=3);
    orig_company_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=3 AND h.orig_company_id_wouldClean);
    orig_company_id_Total_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid>0);
    orig_reference_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=1);
    orig_reference_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=1 AND h.orig_reference_code_wouldClean);
    orig_reference_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=2);
    orig_reference_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=2 AND h.orig_reference_code_wouldClean);
    orig_reference_code_Total_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid>0);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=1 AND h.orig_fname_wouldClean);
    orig_fname_WORDS_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=2 AND h.orig_fname_wouldClean);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=1 AND h.orig_mname_wouldClean);
    orig_mname_WORDS_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=2 AND h.orig_mname_wouldClean);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=1 AND h.orig_lname_wouldClean);
    orig_lname_WORDS_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=2 AND h.orig_lname_wouldClean);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid=1);
    orig_name_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_Invalid=1 AND h.orig_name_suffix_wouldClean);
    orig_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid=2);
    orig_name_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_Invalid=2 AND h.orig_name_suffix_wouldClean);
    orig_name_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid=3);
    orig_name_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_Invalid=3 AND h.orig_name_suffix_wouldClean);
    orig_name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid=4);
    orig_name_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_Invalid=4 AND h.orig_name_suffix_wouldClean);
    orig_name_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid>0);
    orig_fname_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fname_2_Invalid=1);
    orig_fname_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_fname_2_Invalid=1 AND h.orig_fname_2_wouldClean);
    orig_fname_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_2_Invalid=2);
    orig_fname_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fname_2_Invalid=2 AND h.orig_fname_2_wouldClean);
    orig_fname_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_fname_2_Invalid=3);
    orig_fname_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_fname_2_Invalid=3 AND h.orig_fname_2_wouldClean);
    orig_fname_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_fname_2_Invalid=4);
    orig_fname_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fname_2_Invalid=4 AND h.orig_fname_2_wouldClean);
    orig_fname_2_Total_ErrorCount := COUNT(GROUP,h.orig_fname_2_Invalid>0);
    orig_mname_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_mname_2_Invalid=1);
    orig_mname_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_mname_2_Invalid=1 AND h.orig_mname_2_wouldClean);
    orig_mname_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_2_Invalid=2);
    orig_mname_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_mname_2_Invalid=2 AND h.orig_mname_2_wouldClean);
    orig_mname_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_mname_2_Invalid=3);
    orig_mname_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_mname_2_Invalid=3 AND h.orig_mname_2_wouldClean);
    orig_mname_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_mname_2_Invalid=4);
    orig_mname_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_mname_2_Invalid=4 AND h.orig_mname_2_wouldClean);
    orig_mname_2_Total_ErrorCount := COUNT(GROUP,h.orig_mname_2_Invalid>0);
    orig_lname_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_lname_2_Invalid=1);
    orig_lname_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_lname_2_Invalid=1 AND h.orig_lname_2_wouldClean);
    orig_lname_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_2_Invalid=2);
    orig_lname_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_lname_2_Invalid=2 AND h.orig_lname_2_wouldClean);
    orig_lname_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_lname_2_Invalid=3);
    orig_lname_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_lname_2_Invalid=3 AND h.orig_lname_2_wouldClean);
    orig_lname_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_lname_2_Invalid=4);
    orig_lname_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_lname_2_Invalid=4 AND h.orig_lname_2_wouldClean);
    orig_lname_2_Total_ErrorCount := COUNT(GROUP,h.orig_lname_2_Invalid>0);
    orig_name_suffix_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=1);
    orig_name_suffix_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=1 AND h.orig_name_suffix_2_wouldClean);
    orig_name_suffix_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=2);
    orig_name_suffix_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=2 AND h.orig_name_suffix_2_wouldClean);
    orig_name_suffix_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=3);
    orig_name_suffix_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=3 AND h.orig_name_suffix_2_wouldClean);
    orig_name_suffix_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=4);
    orig_name_suffix_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid=4 AND h.orig_name_suffix_2_wouldClean);
    orig_name_suffix_2_Total_ErrorCount := COUNT(GROUP,h.orig_name_suffix_2_Invalid>0);
    orig_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=1);
    orig_address_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address_Invalid=1 AND h.orig_address_wouldClean);
    orig_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=2);
    orig_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address_Invalid=2 AND h.orig_address_wouldClean);
    orig_address_Total_ErrorCount := COUNT(GROUP,h.orig_address_Invalid>0);
    orig_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=1 AND h.orig_city_wouldClean);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=2 AND h.orig_city_wouldClean);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=3);
    orig_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=3 AND h.orig_city_wouldClean);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=1 AND h.orig_state_wouldClean);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=2 AND h.orig_state_wouldClean);
    orig_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=3);
    orig_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=3 AND h.orig_state_wouldClean);
    orig_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=4);
    orig_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=4 AND h.orig_state_wouldClean);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=1 AND h.orig_zip_wouldClean);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=2 AND h.orig_zip_wouldClean);
    orig_zip_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=3);
    orig_zip_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=3 AND h.orig_zip_wouldClean);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_zip4_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip4_Invalid=1 AND h.orig_zip4_wouldClean);
    orig_zip4_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=2);
    orig_zip4_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip4_Invalid=2 AND h.orig_zip4_wouldClean);
    orig_zip4_Total_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid>0);
    orig_address_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_2_Invalid=1);
    orig_address_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address_2_Invalid=1 AND h.orig_address_2_wouldClean);
    orig_address_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_2_Invalid=2);
    orig_address_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address_2_Invalid=2 AND h.orig_address_2_wouldClean);
    orig_address_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address_2_Invalid=3);
    orig_address_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address_2_Invalid=3 AND h.orig_address_2_wouldClean);
    orig_address_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_address_2_Invalid=4);
    orig_address_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address_2_Invalid=4 AND h.orig_address_2_wouldClean);
    orig_address_2_Total_ErrorCount := COUNT(GROUP,h.orig_address_2_Invalid>0);
    orig_city_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_city_2_Invalid=1);
    orig_city_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_city_2_Invalid=1 AND h.orig_city_2_wouldClean);
    orig_city_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_2_Invalid=2);
    orig_city_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_city_2_Invalid=2 AND h.orig_city_2_wouldClean);
    orig_city_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_city_2_Invalid=3);
    orig_city_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_city_2_Invalid=3 AND h.orig_city_2_wouldClean);
    orig_city_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_2_Invalid=4);
    orig_city_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_city_2_Invalid=4 AND h.orig_city_2_wouldClean);
    orig_city_2_Total_ErrorCount := COUNT(GROUP,h.orig_city_2_Invalid>0);
    orig_state_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_state_2_Invalid=1);
    orig_state_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_state_2_Invalid=1 AND h.orig_state_2_wouldClean);
    orig_state_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_2_Invalid=2);
    orig_state_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_state_2_Invalid=2 AND h.orig_state_2_wouldClean);
    orig_state_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_state_2_Invalid=3);
    orig_state_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_state_2_Invalid=3 AND h.orig_state_2_wouldClean);
    orig_state_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_state_2_Invalid=4);
    orig_state_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_state_2_Invalid=4 AND h.orig_state_2_wouldClean);
    orig_state_2_Total_ErrorCount := COUNT(GROUP,h.orig_state_2_Invalid>0);
    orig_zip_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zip_2_Invalid=1);
    orig_zip_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_zip_2_Invalid=1 AND h.orig_zip_2_wouldClean);
    orig_zip_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_2_Invalid=2);
    orig_zip_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip_2_Invalid=2 AND h.orig_zip_2_wouldClean);
    orig_zip_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip_2_Invalid=3);
    orig_zip_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_zip_2_Invalid=3 AND h.orig_zip_2_wouldClean);
    orig_zip_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip_2_Invalid=4);
    orig_zip_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip_2_Invalid=4 AND h.orig_zip_2_wouldClean);
    orig_zip_2_Total_ErrorCount := COUNT(GROUP,h.orig_zip_2_Invalid>0);
    orig_zip4_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zip4_2_Invalid=1);
    orig_zip4_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_zip4_2_Invalid=1 AND h.orig_zip4_2_wouldClean);
    orig_zip4_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_2_Invalid=2);
    orig_zip4_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip4_2_Invalid=2 AND h.orig_zip4_2_wouldClean);
    orig_zip4_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip4_2_Invalid=3);
    orig_zip4_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_zip4_2_Invalid=3 AND h.orig_zip4_2_wouldClean);
    orig_zip4_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip4_2_Invalid=4);
    orig_zip4_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip4_2_Invalid=4 AND h.orig_zip4_2_wouldClean);
    orig_zip4_2_Total_ErrorCount := COUNT(GROUP,h.orig_zip4_2_Invalid>0);
    orig_clean_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_clean_address_Invalid=1);
    orig_clean_address_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_clean_address_Invalid=1 AND h.orig_clean_address_wouldClean);
    orig_clean_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_clean_address_Invalid=2);
    orig_clean_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_clean_address_Invalid=2 AND h.orig_clean_address_wouldClean);
    orig_clean_address_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_clean_address_Invalid=3);
    orig_clean_address_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_clean_address_Invalid=3 AND h.orig_clean_address_wouldClean);
    orig_clean_address_WORDS_ErrorCount := COUNT(GROUP,h.orig_clean_address_Invalid=4);
    orig_clean_address_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_clean_address_Invalid=4 AND h.orig_clean_address_wouldClean);
    orig_clean_address_Total_ErrorCount := COUNT(GROUP,h.orig_clean_address_Invalid>0);
    orig_clean_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_clean_city_Invalid=1);
    orig_clean_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_clean_city_Invalid=1 AND h.orig_clean_city_wouldClean);
    orig_clean_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_clean_city_Invalid=2);
    orig_clean_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_clean_city_Invalid=2 AND h.orig_clean_city_wouldClean);
    orig_clean_city_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_clean_city_Invalid=3);
    orig_clean_city_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_clean_city_Invalid=3 AND h.orig_clean_city_wouldClean);
    orig_clean_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_clean_city_Invalid=4);
    orig_clean_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_clean_city_Invalid=4 AND h.orig_clean_city_wouldClean);
    orig_clean_city_Total_ErrorCount := COUNT(GROUP,h.orig_clean_city_Invalid>0);
    orig_clean_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_clean_state_Invalid=1);
    orig_clean_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_clean_state_Invalid=1 AND h.orig_clean_state_wouldClean);
    orig_clean_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_clean_state_Invalid=2);
    orig_clean_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_clean_state_Invalid=2 AND h.orig_clean_state_wouldClean);
    orig_clean_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_clean_state_Invalid=3);
    orig_clean_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_clean_state_Invalid=3 AND h.orig_clean_state_wouldClean);
    orig_clean_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_clean_state_Invalid=4);
    orig_clean_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_clean_state_Invalid=4 AND h.orig_clean_state_wouldClean);
    orig_clean_state_Total_ErrorCount := COUNT(GROUP,h.orig_clean_state_Invalid>0);
    orig_clean_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_clean_zip_Invalid=1);
    orig_clean_zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip_Invalid=1 AND h.orig_clean_zip_wouldClean);
    orig_clean_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_clean_zip_Invalid=2);
    orig_clean_zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip_Invalid=2 AND h.orig_clean_zip_wouldClean);
    orig_clean_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_clean_zip_Invalid=3);
    orig_clean_zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip_Invalid=3 AND h.orig_clean_zip_wouldClean);
    orig_clean_zip_WORDS_ErrorCount := COUNT(GROUP,h.orig_clean_zip_Invalid=4);
    orig_clean_zip_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip_Invalid=4 AND h.orig_clean_zip_wouldClean);
    orig_clean_zip_Total_ErrorCount := COUNT(GROUP,h.orig_clean_zip_Invalid>0);
    orig_clean_zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=1);
    orig_clean_zip4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=1 AND h.orig_clean_zip4_wouldClean);
    orig_clean_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=2);
    orig_clean_zip4_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=2 AND h.orig_clean_zip4_wouldClean);
    orig_clean_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=3);
    orig_clean_zip4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=3 AND h.orig_clean_zip4_wouldClean);
    orig_clean_zip4_WORDS_ErrorCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=4);
    orig_clean_zip4_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_clean_zip4_Invalid=4 AND h.orig_clean_zip4_wouldClean);
    orig_clean_zip4_Total_ErrorCount := COUNT(GROUP,h.orig_clean_zip4_Invalid>0);
    orig_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=1 AND h.orig_phone_wouldClean);
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=2 AND h.orig_phone_wouldClean);
    orig_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=3);
    orig_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=3 AND h.orig_phone_wouldClean);
    orig_phone_WORDS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=4);
    orig_phone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=4 AND h.orig_phone_wouldClean);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    orig_homephone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_homephone_Invalid=1);
    orig_homephone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_homephone_Invalid=1 AND h.orig_homephone_wouldClean);
    orig_homephone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_homephone_Invalid=2);
    orig_homephone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_homephone_Invalid=2 AND h.orig_homephone_wouldClean);
    orig_homephone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_homephone_Invalid=3);
    orig_homephone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_homephone_Invalid=3 AND h.orig_homephone_wouldClean);
    orig_homephone_WORDS_ErrorCount := COUNT(GROUP,h.orig_homephone_Invalid=4);
    orig_homephone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_homephone_Invalid=4 AND h.orig_homephone_wouldClean);
    orig_homephone_Total_ErrorCount := COUNT(GROUP,h.orig_homephone_Invalid>0);
    orig_homephone_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_homephone_2_Invalid=1);
    orig_homephone_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_homephone_2_Invalid=1 AND h.orig_homephone_2_wouldClean);
    orig_homephone_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_homephone_2_Invalid=2);
    orig_homephone_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_homephone_2_Invalid=2 AND h.orig_homephone_2_wouldClean);
    orig_homephone_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_homephone_2_Invalid=3);
    orig_homephone_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_homephone_2_Invalid=3 AND h.orig_homephone_2_wouldClean);
    orig_homephone_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_homephone_2_Invalid=4);
    orig_homephone_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_homephone_2_Invalid=4 AND h.orig_homephone_2_wouldClean);
    orig_homephone_2_Total_ErrorCount := COUNT(GROUP,h.orig_homephone_2_Invalid>0);
    orig_workphone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_workphone_Invalid=1);
    orig_workphone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_workphone_Invalid=1 AND h.orig_workphone_wouldClean);
    orig_workphone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_workphone_Invalid=2);
    orig_workphone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_workphone_Invalid=2 AND h.orig_workphone_wouldClean);
    orig_workphone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_workphone_Invalid=3);
    orig_workphone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_workphone_Invalid=3 AND h.orig_workphone_wouldClean);
    orig_workphone_WORDS_ErrorCount := COUNT(GROUP,h.orig_workphone_Invalid=4);
    orig_workphone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_workphone_Invalid=4 AND h.orig_workphone_wouldClean);
    orig_workphone_Total_ErrorCount := COUNT(GROUP,h.orig_workphone_Invalid>0);
    orig_workphone_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_workphone_2_Invalid=1);
    orig_workphone_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_workphone_2_Invalid=1 AND h.orig_workphone_2_wouldClean);
    orig_workphone_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_workphone_2_Invalid=2);
    orig_workphone_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_workphone_2_Invalid=2 AND h.orig_workphone_2_wouldClean);
    orig_workphone_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_workphone_2_Invalid=3);
    orig_workphone_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_workphone_2_Invalid=3 AND h.orig_workphone_2_wouldClean);
    orig_workphone_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_workphone_2_Invalid=4);
    orig_workphone_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_workphone_2_Invalid=4 AND h.orig_workphone_2_wouldClean);
    orig_workphone_2_Total_ErrorCount := COUNT(GROUP,h.orig_workphone_2_Invalid>0);
    orig_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=1);
    orig_ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=1 AND h.orig_ssn_wouldClean);
    orig_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=2);
    orig_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=2 AND h.orig_ssn_wouldClean);
    orig_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=3);
    orig_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=3 AND h.orig_ssn_wouldClean);
    orig_ssn_WORDS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=4);
    orig_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=4 AND h.orig_ssn_wouldClean);
    orig_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid>0);
    orig_ssn_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ssn_2_Invalid=1);
    orig_ssn_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ssn_2_Invalid=1 AND h.orig_ssn_2_wouldClean);
    orig_ssn_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ssn_2_Invalid=2);
    orig_ssn_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ssn_2_Invalid=2 AND h.orig_ssn_2_wouldClean);
    orig_ssn_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ssn_2_Invalid=3);
    orig_ssn_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_2_Invalid=3 AND h.orig_ssn_2_wouldClean);
    orig_ssn_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_ssn_2_Invalid=4);
    orig_ssn_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_2_Invalid=4 AND h.orig_ssn_2_wouldClean);
    orig_ssn_2_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_2_Invalid>0);
    orig_free_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=1);
    orig_free_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=1 AND h.orig_free_wouldClean);
    orig_free_ALLOW_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=2);
    orig_free_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=2 AND h.orig_free_wouldClean);
    orig_free_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=3);
    orig_free_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=3 AND h.orig_free_wouldClean);
    orig_free_WORDS_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=4);
    orig_free_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=4 AND h.orig_free_wouldClean);
    orig_free_Total_ErrorCount := COUNT(GROUP,h.orig_free_Invalid>0);
    orig_record_count_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=1);
    orig_record_count_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_record_count_Invalid=1 AND h.orig_record_count_wouldClean);
    orig_record_count_ALLOW_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=2);
    orig_record_count_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_record_count_Invalid=2 AND h.orig_record_count_wouldClean);
    orig_record_count_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=3);
    orig_record_count_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_record_count_Invalid=3 AND h.orig_record_count_wouldClean);
    orig_record_count_WORDS_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=4);
    orig_record_count_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_record_count_Invalid=4 AND h.orig_record_count_wouldClean);
    orig_record_count_Total_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid>0);
    orig_price_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=1);
    orig_price_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_price_Invalid=1 AND h.orig_price_wouldClean);
    orig_price_WORDS_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=2);
    orig_price_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_price_Invalid=2 AND h.orig_price_wouldClean);
    orig_price_Total_ErrorCount := COUNT(GROUP,h.orig_price_Invalid>0);
    orig_revenue_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_revenue_Invalid=1);
    orig_revenue_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_revenue_Invalid=1 AND h.orig_revenue_wouldClean);
    orig_revenue_ALLOW_ErrorCount := COUNT(GROUP,h.orig_revenue_Invalid=2);
    orig_revenue_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_revenue_Invalid=2 AND h.orig_revenue_wouldClean);
    orig_revenue_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_revenue_Invalid=3);
    orig_revenue_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_revenue_Invalid=3 AND h.orig_revenue_wouldClean);
    orig_revenue_WORDS_ErrorCount := COUNT(GROUP,h.orig_revenue_Invalid=4);
    orig_revenue_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_revenue_Invalid=4 AND h.orig_revenue_wouldClean);
    orig_revenue_Total_ErrorCount := COUNT(GROUP,h.orig_revenue_Invalid>0);
    orig_full_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=1);
    orig_full_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=1 AND h.orig_full_name_wouldClean);
    orig_full_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=2);
    orig_full_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=2 AND h.orig_full_name_wouldClean);
    orig_full_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=3);
    orig_full_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=3 AND h.orig_full_name_wouldClean);
    orig_full_name_Total_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid>0);
    orig_business_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=1);
    orig_business_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_business_name_Invalid=1 AND h.orig_business_name_wouldClean);
    orig_business_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=2);
    orig_business_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_business_name_Invalid=2 AND h.orig_business_name_wouldClean);
    orig_business_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=3);
    orig_business_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_business_name_Invalid=3 AND h.orig_business_name_wouldClean);
    orig_business_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=4);
    orig_business_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_business_name_Invalid=4 AND h.orig_business_name_wouldClean);
    orig_business_name_Total_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid>0);
    orig_business_name_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_business_name_2_Invalid=1);
    orig_business_name_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_business_name_2_Invalid=1 AND h.orig_business_name_2_wouldClean);
    orig_business_name_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_business_name_2_Invalid=2);
    orig_business_name_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_business_name_2_Invalid=2 AND h.orig_business_name_2_wouldClean);
    orig_business_name_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_business_name_2_Invalid=3);
    orig_business_name_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_business_name_2_Invalid=3 AND h.orig_business_name_2_wouldClean);
    orig_business_name_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_business_name_2_Invalid=4);
    orig_business_name_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_business_name_2_Invalid=4 AND h.orig_business_name_2_wouldClean);
    orig_business_name_2_Total_ErrorCount := COUNT(GROUP,h.orig_business_name_2_Invalid>0);
    orig_years_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=1);
    orig_years_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=1 AND h.orig_years_wouldClean);
    orig_years_ALLOW_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=2);
    orig_years_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=2 AND h.orig_years_wouldClean);
    orig_years_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=3);
    orig_years_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=3 AND h.orig_years_wouldClean);
    orig_years_WORDS_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=4);
    orig_years_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=4 AND h.orig_years_wouldClean);
    orig_years_Total_ErrorCount := COUNT(GROUP,h.orig_years_Invalid>0);
    orig_pricing_error_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=1);
    orig_pricing_error_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=1 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=2);
    orig_pricing_error_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=2 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=3);
    orig_pricing_error_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=3 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=4);
    orig_pricing_error_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=4 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_Total_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid>0);
    orig_fcra_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=1);
    orig_fcra_purpose_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=1 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=2);
    orig_fcra_purpose_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=2 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=3);
    orig_fcra_purpose_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=3 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_WORDS_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=4);
    orig_fcra_purpose_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=4 AND h.orig_fcra_purpose_wouldClean);
    orig_fcra_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid>0);
    orig_result_format_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_result_format_Invalid=1);
    orig_result_format_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_result_format_Invalid=1 AND h.orig_result_format_wouldClean);
    orig_result_format_ALLOW_ErrorCount := COUNT(GROUP,h.orig_result_format_Invalid=2);
    orig_result_format_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_result_format_Invalid=2 AND h.orig_result_format_wouldClean);
    orig_result_format_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_result_format_Invalid=3);
    orig_result_format_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_result_format_Invalid=3 AND h.orig_result_format_wouldClean);
    orig_result_format_WORDS_ErrorCount := COUNT(GROUP,h.orig_result_format_Invalid=4);
    orig_result_format_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_result_format_Invalid=4 AND h.orig_result_format_wouldClean);
    orig_result_format_Total_ErrorCount := COUNT(GROUP,h.orig_result_format_Invalid>0);
    orig_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=1 AND h.orig_dob_wouldClean);
    orig_dob_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=2 AND h.orig_dob_wouldClean);
    orig_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=3);
    orig_dob_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=3 AND h.orig_dob_wouldClean);
    orig_dob_WORDS_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=4);
    orig_dob_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dob_Invalid=4 AND h.orig_dob_wouldClean);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_dob_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dob_2_Invalid=1);
    orig_dob_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dob_2_Invalid=1 AND h.orig_dob_2_wouldClean);
    orig_dob_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dob_2_Invalid=2);
    orig_dob_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dob_2_Invalid=2 AND h.orig_dob_2_wouldClean);
    orig_dob_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dob_2_Invalid=3);
    orig_dob_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dob_2_Invalid=3 AND h.orig_dob_2_wouldClean);
    orig_dob_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_dob_2_Invalid=4);
    orig_dob_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dob_2_Invalid=4 AND h.orig_dob_2_wouldClean);
    orig_dob_2_Total_ErrorCount := COUNT(GROUP,h.orig_dob_2_Invalid>0);
    orig_unique_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=1);
    orig_unique_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_unique_id_Invalid=1 AND h.orig_unique_id_wouldClean);
    orig_unique_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=2);
    orig_unique_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_unique_id_Invalid=2 AND h.orig_unique_id_wouldClean);
    orig_unique_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=3);
    orig_unique_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_unique_id_Invalid=3 AND h.orig_unique_id_wouldClean);
    orig_unique_id_Total_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid>0);
    orig_response_time_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=1);
    orig_response_time_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=1 AND h.orig_response_time_wouldClean);
    orig_response_time_ALLOW_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=2);
    orig_response_time_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=2 AND h.orig_response_time_wouldClean);
    orig_response_time_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=3);
    orig_response_time_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=3 AND h.orig_response_time_wouldClean);
    orig_response_time_WORDS_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=4);
    orig_response_time_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=4 AND h.orig_response_time_wouldClean);
    orig_response_time_Total_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid>0);
    orig_data_source_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_data_source_Invalid=1);
    orig_data_source_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_data_source_Invalid=1 AND h.orig_data_source_wouldClean);
    orig_data_source_ALLOW_ErrorCount := COUNT(GROUP,h.orig_data_source_Invalid=2);
    orig_data_source_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_data_source_Invalid=2 AND h.orig_data_source_wouldClean);
    orig_data_source_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_data_source_Invalid=3);
    orig_data_source_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_data_source_Invalid=3 AND h.orig_data_source_wouldClean);
    orig_data_source_WORDS_ErrorCount := COUNT(GROUP,h.orig_data_source_Invalid=4);
    orig_data_source_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_data_source_Invalid=4 AND h.orig_data_source_wouldClean);
    orig_data_source_Total_ErrorCount := COUNT(GROUP,h.orig_data_source_Invalid>0);
    orig_report_options_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid=1);
    orig_report_options_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_report_options_Invalid=1 AND h.orig_report_options_wouldClean);
    orig_report_options_ALLOW_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid=2);
    orig_report_options_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_report_options_Invalid=2 AND h.orig_report_options_wouldClean);
    orig_report_options_WORDS_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid=3);
    orig_report_options_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_report_options_Invalid=3 AND h.orig_report_options_wouldClean);
    orig_report_options_Total_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid>0);
    orig_end_user_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_name_Invalid=1);
    orig_end_user_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_name_Invalid=1 AND h.orig_end_user_name_wouldClean);
    orig_end_user_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_name_Invalid=2);
    orig_end_user_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_name_Invalid=2 AND h.orig_end_user_name_wouldClean);
    orig_end_user_name_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_name_Invalid>0);
    orig_end_user_address_1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_address_1_Invalid=1);
    orig_end_user_address_1_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_address_1_Invalid=1 AND h.orig_end_user_address_1_wouldClean);
    orig_end_user_address_1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_address_1_Invalid=2);
    orig_end_user_address_1_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_address_1_Invalid=2 AND h.orig_end_user_address_1_wouldClean);
    orig_end_user_address_1_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_address_1_Invalid>0);
    orig_end_user_address_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=1);
    orig_end_user_address_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=1 AND h.orig_end_user_address_2_wouldClean);
    orig_end_user_address_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=2);
    orig_end_user_address_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=2 AND h.orig_end_user_address_2_wouldClean);
    orig_end_user_address_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=3);
    orig_end_user_address_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=3 AND h.orig_end_user_address_2_wouldClean);
    orig_end_user_address_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=4);
    orig_end_user_address_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid=4 AND h.orig_end_user_address_2_wouldClean);
    orig_end_user_address_2_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_address_2_Invalid>0);
    orig_end_user_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_city_Invalid=1);
    orig_end_user_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_city_Invalid=1 AND h.orig_end_user_city_wouldClean);
    orig_end_user_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_city_Invalid=2);
    orig_end_user_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_city_Invalid=2 AND h.orig_end_user_city_wouldClean);
    orig_end_user_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_end_user_city_Invalid=3);
    orig_end_user_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_city_Invalid=3 AND h.orig_end_user_city_wouldClean);
    orig_end_user_city_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_city_Invalid>0);
    orig_end_user_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_state_Invalid=1);
    orig_end_user_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_state_Invalid=1 AND h.orig_end_user_state_wouldClean);
    orig_end_user_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_state_Invalid=2);
    orig_end_user_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_state_Invalid=2 AND h.orig_end_user_state_wouldClean);
    orig_end_user_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_end_user_state_Invalid=3);
    orig_end_user_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_state_Invalid=3 AND h.orig_end_user_state_wouldClean);
    orig_end_user_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_end_user_state_Invalid=4);
    orig_end_user_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_state_Invalid=4 AND h.orig_end_user_state_wouldClean);
    orig_end_user_state_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_state_Invalid>0);
    orig_end_user_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_zip_Invalid=1);
    orig_end_user_zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_zip_Invalid=1 AND h.orig_end_user_zip_wouldClean);
    orig_end_user_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_zip_Invalid=2);
    orig_end_user_zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_zip_Invalid=2 AND h.orig_end_user_zip_wouldClean);
    orig_end_user_zip_WORDS_ErrorCount := COUNT(GROUP,h.orig_end_user_zip_Invalid=3);
    orig_end_user_zip_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_zip_Invalid=3 AND h.orig_end_user_zip_wouldClean);
    orig_end_user_zip_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_zip_Invalid>0);
    orig_login_history_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1);
    orig_login_history_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2);
    orig_login_history_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=3);
    orig_login_history_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=3 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=4);
    orig_login_history_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=4 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_Total_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid>0);
    orig_employment_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_employment_state_Invalid=1);
    orig_employment_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_employment_state_Invalid=1 AND h.orig_employment_state_wouldClean);
    orig_employment_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_employment_state_Invalid=2);
    orig_employment_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_employment_state_Invalid=2 AND h.orig_employment_state_wouldClean);
    orig_employment_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_employment_state_Invalid=3);
    orig_employment_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_employment_state_Invalid=3 AND h.orig_employment_state_wouldClean);
    orig_employment_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_employment_state_Invalid=4);
    orig_employment_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_employment_state_Invalid=4 AND h.orig_employment_state_wouldClean);
    orig_employment_state_Total_ErrorCount := COUNT(GROUP,h.orig_employment_state_Invalid>0);
    orig_end_user_industry_class_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=1);
    orig_end_user_industry_class_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=1 AND h.orig_end_user_industry_class_wouldClean);
    orig_end_user_industry_class_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=2);
    orig_end_user_industry_class_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=2 AND h.orig_end_user_industry_class_wouldClean);
    orig_end_user_industry_class_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=3);
    orig_end_user_industry_class_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=3 AND h.orig_end_user_industry_class_wouldClean);
    orig_end_user_industry_class_WORDS_ErrorCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=4);
    orig_end_user_industry_class_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid=4 AND h.orig_end_user_industry_class_wouldClean);
    orig_end_user_industry_class_Total_ErrorCount := COUNT(GROUP,h.orig_end_user_industry_class_Invalid>0);
    orig_function_specific_data_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=1);
    orig_function_specific_data_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=1 AND h.orig_function_specific_data_wouldClean);
    orig_function_specific_data_ALLOW_ErrorCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=2);
    orig_function_specific_data_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=2 AND h.orig_function_specific_data_wouldClean);
    orig_function_specific_data_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=3);
    orig_function_specific_data_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=3 AND h.orig_function_specific_data_wouldClean);
    orig_function_specific_data_WORDS_ErrorCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=4);
    orig_function_specific_data_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_function_specific_data_Invalid=4 AND h.orig_function_specific_data_wouldClean);
    orig_function_specific_data_Total_ErrorCount := COUNT(GROUP,h.orig_function_specific_data_Invalid>0);
    orig_date_added_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid=1);
    orig_date_added_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_date_added_Invalid=1 AND h.orig_date_added_wouldClean);
    orig_date_added_ALLOW_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid=2);
    orig_date_added_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_date_added_Invalid=2 AND h.orig_date_added_wouldClean);
    orig_date_added_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid=3);
    orig_date_added_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_date_added_Invalid=3 AND h.orig_date_added_wouldClean);
    orig_date_added_WORDS_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid=4);
    orig_date_added_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_date_added_Invalid=4 AND h.orig_date_added_wouldClean);
    orig_date_added_Total_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid>0);
    orig_retail_price_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid=1);
    orig_retail_price_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_retail_price_Invalid=1 AND h.orig_retail_price_wouldClean);
    orig_retail_price_WORDS_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid=2);
    orig_retail_price_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_retail_price_Invalid=2 AND h.orig_retail_price_wouldClean);
    orig_retail_price_Total_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid>0);
    orig_country_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_country_code_Invalid=1);
    orig_country_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_country_code_Invalid=1 AND h.orig_country_code_wouldClean);
    orig_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_country_code_Invalid=2);
    orig_country_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_country_code_Invalid=2 AND h.orig_country_code_wouldClean);
    orig_country_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_country_code_Invalid=3);
    orig_country_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_country_code_Invalid=3 AND h.orig_country_code_wouldClean);
    orig_country_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_country_code_Invalid=4);
    orig_country_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_country_code_Invalid=4 AND h.orig_country_code_wouldClean);
    orig_country_code_Total_ErrorCount := COUNT(GROUP,h.orig_country_code_Invalid>0);
    orig_email_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_email_Invalid=1);
    orig_email_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_email_Invalid=1 AND h.orig_email_wouldClean);
    orig_email_ALLOW_ErrorCount := COUNT(GROUP,h.orig_email_Invalid=2);
    orig_email_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_email_Invalid=2 AND h.orig_email_wouldClean);
    orig_email_WORDS_ErrorCount := COUNT(GROUP,h.orig_email_Invalid=3);
    orig_email_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_email_Invalid=3 AND h.orig_email_wouldClean);
    orig_email_Total_ErrorCount := COUNT(GROUP,h.orig_email_Invalid>0);
    orig_email_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_email_2_Invalid=1);
    orig_email_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_email_2_Invalid=1 AND h.orig_email_2_wouldClean);
    orig_email_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_email_2_Invalid=2);
    orig_email_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_email_2_Invalid=2 AND h.orig_email_2_wouldClean);
    orig_email_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_email_2_Invalid=3);
    orig_email_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_email_2_Invalid=3 AND h.orig_email_2_wouldClean);
    orig_email_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_email_2_Invalid=4);
    orig_email_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_email_2_Invalid=4 AND h.orig_email_2_wouldClean);
    orig_email_2_Total_ErrorCount := COUNT(GROUP,h.orig_email_2_Invalid>0);
    orig_dl_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=1);
    orig_dl_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_Invalid=1 AND h.orig_dl_number_wouldClean);
    orig_dl_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=2);
    orig_dl_number_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_Invalid=2 AND h.orig_dl_number_wouldClean);
    orig_dl_number_WORDS_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=3);
    orig_dl_number_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_Invalid=3 AND h.orig_dl_number_wouldClean);
    orig_dl_number_Total_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid>0);
    orig_dl_number_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=1);
    orig_dl_number_2_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=1 AND h.orig_dl_number_2_wouldClean);
    orig_dl_number_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=2);
    orig_dl_number_2_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=2 AND h.orig_dl_number_2_wouldClean);
    orig_dl_number_2_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=3);
    orig_dl_number_2_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=3 AND h.orig_dl_number_2_wouldClean);
    orig_dl_number_2_WORDS_ErrorCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=4);
    orig_dl_number_2_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dl_number_2_Invalid=4 AND h.orig_dl_number_2_wouldClean);
    orig_dl_number_2_Total_ErrorCount := COUNT(GROUP,h.orig_dl_number_2_Invalid>0);
    orig_sub_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_sub_id_Invalid=1);
    orig_sub_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_sub_id_Invalid=1 AND h.orig_sub_id_wouldClean);
    orig_sub_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_sub_id_Invalid=2);
    orig_sub_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_sub_id_Invalid=2 AND h.orig_sub_id_wouldClean);
    orig_sub_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_sub_id_Invalid=3);
    orig_sub_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_sub_id_Invalid=3 AND h.orig_sub_id_wouldClean);
    orig_sub_id_Total_ErrorCount := COUNT(GROUP,h.orig_sub_id_Invalid>0);
    orig_neighbors_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_neighbors_Invalid=1);
    orig_neighbors_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_neighbors_Invalid=1 AND h.orig_neighbors_wouldClean);
    orig_neighbors_ALLOW_ErrorCount := COUNT(GROUP,h.orig_neighbors_Invalid=2);
    orig_neighbors_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_neighbors_Invalid=2 AND h.orig_neighbors_wouldClean);
    orig_neighbors_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_neighbors_Invalid=3);
    orig_neighbors_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_neighbors_Invalid=3 AND h.orig_neighbors_wouldClean);
    orig_neighbors_WORDS_ErrorCount := COUNT(GROUP,h.orig_neighbors_Invalid=4);
    orig_neighbors_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_neighbors_Invalid=4 AND h.orig_neighbors_wouldClean);
    orig_neighbors_Total_ErrorCount := COUNT(GROUP,h.orig_neighbors_Invalid>0);
    orig_relatives_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_relatives_Invalid=1);
    orig_relatives_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_relatives_Invalid=1 AND h.orig_relatives_wouldClean);
    orig_relatives_ALLOW_ErrorCount := COUNT(GROUP,h.orig_relatives_Invalid=2);
    orig_relatives_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_relatives_Invalid=2 AND h.orig_relatives_wouldClean);
    orig_relatives_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_relatives_Invalid=3);
    orig_relatives_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_relatives_Invalid=3 AND h.orig_relatives_wouldClean);
    orig_relatives_WORDS_ErrorCount := COUNT(GROUP,h.orig_relatives_Invalid=4);
    orig_relatives_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_relatives_Invalid=4 AND h.orig_relatives_wouldClean);
    orig_relatives_Total_ErrorCount := COUNT(GROUP,h.orig_relatives_Invalid>0);
    orig_associates_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_associates_Invalid=1);
    orig_associates_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_associates_Invalid=1 AND h.orig_associates_wouldClean);
    orig_associates_ALLOW_ErrorCount := COUNT(GROUP,h.orig_associates_Invalid=2);
    orig_associates_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_associates_Invalid=2 AND h.orig_associates_wouldClean);
    orig_associates_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_associates_Invalid=3);
    orig_associates_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_associates_Invalid=3 AND h.orig_associates_wouldClean);
    orig_associates_WORDS_ErrorCount := COUNT(GROUP,h.orig_associates_Invalid=4);
    orig_associates_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_associates_Invalid=4 AND h.orig_associates_wouldClean);
    orig_associates_Total_ErrorCount := COUNT(GROUP,h.orig_associates_Invalid>0);
    orig_property_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_property_Invalid=1);
    orig_property_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_property_Invalid=1 AND h.orig_property_wouldClean);
    orig_property_ALLOW_ErrorCount := COUNT(GROUP,h.orig_property_Invalid=2);
    orig_property_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_property_Invalid=2 AND h.orig_property_wouldClean);
    orig_property_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_property_Invalid=3);
    orig_property_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_property_Invalid=3 AND h.orig_property_wouldClean);
    orig_property_WORDS_ErrorCount := COUNT(GROUP,h.orig_property_Invalid=4);
    orig_property_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_property_Invalid=4 AND h.orig_property_wouldClean);
    orig_property_Total_ErrorCount := COUNT(GROUP,h.orig_property_Invalid>0);
    orig_bankruptcy_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=1);
    orig_bankruptcy_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=1 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_ALLOW_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=2);
    orig_bankruptcy_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=2 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=3);
    orig_bankruptcy_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=3 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_WORDS_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=4);
    orig_bankruptcy_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=4 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_Total_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid>0);
    orig_dls_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dls_Invalid=1);
    orig_dls_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dls_Invalid=1 AND h.orig_dls_wouldClean);
    orig_dls_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dls_Invalid=2);
    orig_dls_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dls_Invalid=2 AND h.orig_dls_wouldClean);
    orig_dls_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dls_Invalid=3);
    orig_dls_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dls_Invalid=3 AND h.orig_dls_wouldClean);
    orig_dls_WORDS_ErrorCount := COUNT(GROUP,h.orig_dls_Invalid=4);
    orig_dls_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dls_Invalid=4 AND h.orig_dls_wouldClean);
    orig_dls_Total_ErrorCount := COUNT(GROUP,h.orig_dls_Invalid>0);
    orig_mvs_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_mvs_Invalid=1);
    orig_mvs_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_mvs_Invalid=1 AND h.orig_mvs_wouldClean);
    orig_mvs_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mvs_Invalid=2);
    orig_mvs_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_mvs_Invalid=2 AND h.orig_mvs_wouldClean);
    orig_mvs_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_mvs_Invalid=3);
    orig_mvs_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_mvs_Invalid=3 AND h.orig_mvs_wouldClean);
    orig_mvs_WORDS_ErrorCount := COUNT(GROUP,h.orig_mvs_Invalid=4);
    orig_mvs_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_mvs_Invalid=4 AND h.orig_mvs_wouldClean);
    orig_mvs_Total_ErrorCount := COUNT(GROUP,h.orig_mvs_Invalid>0);
    orig_ip_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid=1);
    orig_ip_address_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_Invalid=1 AND h.orig_ip_address_wouldClean);
    orig_ip_address_WORDS_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid=2);
    orig_ip_address_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_Invalid=2 AND h.orig_ip_address_wouldClean);
    orig_ip_address_Total_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_login_id_Invalid > 0 OR h.orig_billing_code_Invalid > 0 OR h.orig_transaction_id_Invalid > 0 OR h.orig_function_name_Invalid > 0 OR h.orig_company_id_Invalid > 0 OR h.orig_reference_code_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_name_suffix_Invalid > 0 OR h.orig_fname_2_Invalid > 0 OR h.orig_mname_2_Invalid > 0 OR h.orig_lname_2_Invalid > 0 OR h.orig_name_suffix_2_Invalid > 0 OR h.orig_address_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.orig_address_2_Invalid > 0 OR h.orig_city_2_Invalid > 0 OR h.orig_state_2_Invalid > 0 OR h.orig_zip_2_Invalid > 0 OR h.orig_zip4_2_Invalid > 0 OR h.orig_clean_address_Invalid > 0 OR h.orig_clean_city_Invalid > 0 OR h.orig_clean_state_Invalid > 0 OR h.orig_clean_zip_Invalid > 0 OR h.orig_clean_zip4_Invalid > 0 OR h.orig_phone_Invalid > 0 OR h.orig_homephone_Invalid > 0 OR h.orig_homephone_2_Invalid > 0 OR h.orig_workphone_Invalid > 0 OR h.orig_workphone_2_Invalid > 0 OR h.orig_ssn_Invalid > 0 OR h.orig_ssn_2_Invalid > 0 OR h.orig_free_Invalid > 0 OR h.orig_record_count_Invalid > 0 OR h.orig_price_Invalid > 0 OR h.orig_revenue_Invalid > 0 OR h.orig_full_name_Invalid > 0 OR h.orig_business_name_Invalid > 0 OR h.orig_business_name_2_Invalid > 0 OR h.orig_years_Invalid > 0 OR h.orig_pricing_error_code_Invalid > 0 OR h.orig_fcra_purpose_Invalid > 0 OR h.orig_result_format_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_dob_2_Invalid > 0 OR h.orig_unique_id_Invalid > 0 OR h.orig_response_time_Invalid > 0 OR h.orig_data_source_Invalid > 0 OR h.orig_report_options_Invalid > 0 OR h.orig_end_user_name_Invalid > 0 OR h.orig_end_user_address_1_Invalid > 0 OR h.orig_end_user_address_2_Invalid > 0 OR h.orig_end_user_city_Invalid > 0 OR h.orig_end_user_state_Invalid > 0 OR h.orig_end_user_zip_Invalid > 0 OR h.orig_login_history_id_Invalid > 0 OR h.orig_employment_state_Invalid > 0 OR h.orig_end_user_industry_class_Invalid > 0 OR h.orig_function_specific_data_Invalid > 0 OR h.orig_date_added_Invalid > 0 OR h.orig_retail_price_Invalid > 0 OR h.orig_country_code_Invalid > 0 OR h.orig_email_Invalid > 0 OR h.orig_email_2_Invalid > 0 OR h.orig_dl_number_Invalid > 0 OR h.orig_dl_number_2_Invalid > 0 OR h.orig_sub_id_Invalid > 0 OR h.orig_neighbors_Invalid > 0 OR h.orig_relatives_Invalid > 0 OR h.orig_associates_Invalid > 0 OR h.orig_property_Invalid > 0 OR h.orig_bankruptcy_Invalid > 0 OR h.orig_dls_Invalid > 0 OR h.orig_mvs_Invalid > 0 OR h.orig_ip_address_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.orig_login_id_wouldClean OR h.orig_billing_code_wouldClean OR h.orig_transaction_id_wouldClean OR h.orig_function_name_wouldClean OR h.orig_company_id_wouldClean OR h.orig_reference_code_wouldClean OR h.orig_fname_wouldClean OR h.orig_mname_wouldClean OR h.orig_lname_wouldClean OR h.orig_name_suffix_wouldClean OR h.orig_fname_2_wouldClean OR h.orig_mname_2_wouldClean OR h.orig_lname_2_wouldClean OR h.orig_name_suffix_2_wouldClean OR h.orig_address_wouldClean OR h.orig_city_wouldClean OR h.orig_state_wouldClean OR h.orig_zip_wouldClean OR h.orig_zip4_wouldClean OR h.orig_address_2_wouldClean OR h.orig_city_2_wouldClean OR h.orig_state_2_wouldClean OR h.orig_zip_2_wouldClean OR h.orig_zip4_2_wouldClean OR h.orig_clean_address_wouldClean OR h.orig_clean_city_wouldClean OR h.orig_clean_state_wouldClean OR h.orig_clean_zip_wouldClean OR h.orig_clean_zip4_wouldClean OR h.orig_phone_wouldClean OR h.orig_homephone_wouldClean OR h.orig_homephone_2_wouldClean OR h.orig_workphone_wouldClean OR h.orig_workphone_2_wouldClean OR h.orig_ssn_wouldClean OR h.orig_ssn_2_wouldClean OR h.orig_free_wouldClean OR h.orig_record_count_wouldClean OR h.orig_price_wouldClean OR h.orig_revenue_wouldClean OR h.orig_full_name_wouldClean OR h.orig_business_name_wouldClean OR h.orig_business_name_2_wouldClean OR h.orig_years_wouldClean OR h.orig_pricing_error_code_wouldClean OR h.orig_fcra_purpose_wouldClean OR h.orig_result_format_wouldClean OR h.orig_dob_wouldClean OR h.orig_dob_2_wouldClean OR h.orig_unique_id_wouldClean OR h.orig_response_time_wouldClean OR h.orig_data_source_wouldClean OR h.orig_report_options_wouldClean OR h.orig_end_user_name_wouldClean OR h.orig_end_user_address_1_wouldClean OR h.orig_end_user_address_2_wouldClean OR h.orig_end_user_city_wouldClean OR h.orig_end_user_state_wouldClean OR h.orig_end_user_zip_wouldClean OR h.orig_login_history_id_wouldClean OR h.orig_employment_state_wouldClean OR h.orig_end_user_industry_class_wouldClean OR h.orig_function_specific_data_wouldClean OR h.orig_date_added_wouldClean OR h.orig_retail_price_wouldClean OR h.orig_country_code_wouldClean OR h.orig_email_wouldClean OR h.orig_email_2_wouldClean OR h.orig_dl_number_wouldClean OR h.orig_dl_number_2_wouldClean OR h.orig_sub_id_wouldClean OR h.orig_neighbors_wouldClean OR h.orig_relatives_wouldClean OR h.orig_associates_wouldClean OR h.orig_property_wouldClean OR h.orig_bankruptcy_wouldClean OR h.orig_dls_wouldClean OR h.orig_mvs_wouldClean OR h.orig_ip_address_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_login_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_lname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fname_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mname_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_lname_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_city_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_clean_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_clean_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_clean_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_free_Total_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_Total_ErrorCount > 0, 1, 0) + IF(le.orig_price_Total_ErrorCount > 0, 1, 0) + IF(le.orig_revenue_Total_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_years_Total_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_Total_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_Total_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_1_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_employment_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_Total_ErrorCount > 0, 1, 0) + IF(le.orig_function_specific_data_Total_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_Total_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_Total_ErrorCount > 0, 1, 0) + IF(le.orig_country_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_email_Total_ErrorCount > 0, 1, 0) + IF(le.orig_email_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_2_Total_ErrorCount > 0, 1, 0) + IF(le.orig_sub_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_Total_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_Total_ErrorCount > 0, 1, 0) + IF(le.orig_associates_Total_ErrorCount > 0, 1, 0) + IF(le.orig_property_Total_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dls_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_login_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_login_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fname_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fname_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_fname_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_mname_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_lname_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_name_suffix_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_city_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_city_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_city_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_state_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_state_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zip_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_clean_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_clean_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_address_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_clean_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_clean_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_clean_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_clean_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_clean_zip4_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_homephone_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_workphone_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_free_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_free_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_free_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_free_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_price_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_price_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_revenue_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_revenue_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_revenue_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_revenue_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_years_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_years_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_years_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_years_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_1_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_address_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_employment_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_employment_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_employment_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_employment_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_function_specific_data_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_function_specific_data_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_function_specific_data_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_function_specific_data_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_country_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_country_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_country_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_country_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_email_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_email_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_email_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_email_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_email_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_email_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_2_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_sub_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_sub_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_sub_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_associates_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_associates_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_associates_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_associates_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_property_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_property_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_property_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_property_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dls_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dls_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dls_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dls_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.orig_login_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billing_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_billing_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_billing_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billing_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_name_suffix_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_address_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_address_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_address_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_city_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_clean_zip4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_homephone_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_workphone_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_record_count_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_record_count_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_record_count_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_record_count_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_price_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_price_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_revenue_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_revenue_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_revenue_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_revenue_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fcra_purpose_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_unique_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_unique_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_unique_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_report_options_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_report_options_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_report_options_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_address_1_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_address_1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_address_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_address_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_address_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_address_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_employment_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_employment_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_employment_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_employment_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_end_user_industry_class_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_specific_data_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_specific_data_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_specific_data_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_specific_data_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_date_added_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_date_added_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_date_added_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_date_added_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_retail_price_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_retail_price_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_country_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_country_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_country_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_country_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_email_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_2_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_2_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_number_2_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_sub_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_sub_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_sub_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_WORDS_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_login_id_Invalid,le.orig_billing_code_Invalid,le.orig_transaction_id_Invalid,le.orig_function_name_Invalid,le.orig_company_id_Invalid,le.orig_reference_code_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_name_suffix_Invalid,le.orig_fname_2_Invalid,le.orig_mname_2_Invalid,le.orig_lname_2_Invalid,le.orig_name_suffix_2_Invalid,le.orig_address_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_zip4_Invalid,le.orig_address_2_Invalid,le.orig_city_2_Invalid,le.orig_state_2_Invalid,le.orig_zip_2_Invalid,le.orig_zip4_2_Invalid,le.orig_clean_address_Invalid,le.orig_clean_city_Invalid,le.orig_clean_state_Invalid,le.orig_clean_zip_Invalid,le.orig_clean_zip4_Invalid,le.orig_phone_Invalid,le.orig_homephone_Invalid,le.orig_homephone_2_Invalid,le.orig_workphone_Invalid,le.orig_workphone_2_Invalid,le.orig_ssn_Invalid,le.orig_ssn_2_Invalid,le.orig_free_Invalid,le.orig_record_count_Invalid,le.orig_price_Invalid,le.orig_revenue_Invalid,le.orig_full_name_Invalid,le.orig_business_name_Invalid,le.orig_business_name_2_Invalid,le.orig_years_Invalid,le.orig_pricing_error_code_Invalid,le.orig_fcra_purpose_Invalid,le.orig_result_format_Invalid,le.orig_dob_Invalid,le.orig_dob_2_Invalid,le.orig_unique_id_Invalid,le.orig_response_time_Invalid,le.orig_data_source_Invalid,le.orig_report_options_Invalid,le.orig_end_user_name_Invalid,le.orig_end_user_address_1_Invalid,le.orig_end_user_address_2_Invalid,le.orig_end_user_city_Invalid,le.orig_end_user_state_Invalid,le.orig_end_user_zip_Invalid,le.orig_login_history_id_Invalid,le.orig_employment_state_Invalid,le.orig_end_user_industry_class_Invalid,le.orig_function_specific_data_Invalid,le.orig_date_added_Invalid,le.orig_retail_price_Invalid,le.orig_country_code_Invalid,le.orig_email_Invalid,le.orig_email_2_Invalid,le.orig_dl_number_Invalid,le.orig_dl_number_2_Invalid,le.orig_sub_id_Invalid,le.orig_neighbors_Invalid,le.orig_relatives_Invalid,le.orig_associates_Invalid,le.orig_property_Invalid,le.orig_bankruptcy_Invalid,le.orig_dls_Invalid,le.orig_mvs_Invalid,le.orig_ip_address_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_login_id(le.orig_login_id_Invalid),Fields.InvalidMessage_orig_billing_code(le.orig_billing_code_Invalid),Fields.InvalidMessage_orig_transaction_id(le.orig_transaction_id_Invalid),Fields.InvalidMessage_orig_function_name(le.orig_function_name_Invalid),Fields.InvalidMessage_orig_company_id(le.orig_company_id_Invalid),Fields.InvalidMessage_orig_reference_code(le.orig_reference_code_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_name_suffix(le.orig_name_suffix_Invalid),Fields.InvalidMessage_orig_fname_2(le.orig_fname_2_Invalid),Fields.InvalidMessage_orig_mname_2(le.orig_mname_2_Invalid),Fields.InvalidMessage_orig_lname_2(le.orig_lname_2_Invalid),Fields.InvalidMessage_orig_name_suffix_2(le.orig_name_suffix_2_Invalid),Fields.InvalidMessage_orig_address(le.orig_address_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),Fields.InvalidMessage_orig_address_2(le.orig_address_2_Invalid),Fields.InvalidMessage_orig_city_2(le.orig_city_2_Invalid),Fields.InvalidMessage_orig_state_2(le.orig_state_2_Invalid),Fields.InvalidMessage_orig_zip_2(le.orig_zip_2_Invalid),Fields.InvalidMessage_orig_zip4_2(le.orig_zip4_2_Invalid),Fields.InvalidMessage_orig_clean_address(le.orig_clean_address_Invalid),Fields.InvalidMessage_orig_clean_city(le.orig_clean_city_Invalid),Fields.InvalidMessage_orig_clean_state(le.orig_clean_state_Invalid),Fields.InvalidMessage_orig_clean_zip(le.orig_clean_zip_Invalid),Fields.InvalidMessage_orig_clean_zip4(le.orig_clean_zip4_Invalid),Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_orig_homephone(le.orig_homephone_Invalid),Fields.InvalidMessage_orig_homephone_2(le.orig_homephone_2_Invalid),Fields.InvalidMessage_orig_workphone(le.orig_workphone_Invalid),Fields.InvalidMessage_orig_workphone_2(le.orig_workphone_2_Invalid),Fields.InvalidMessage_orig_ssn(le.orig_ssn_Invalid),Fields.InvalidMessage_orig_ssn_2(le.orig_ssn_2_Invalid),Fields.InvalidMessage_orig_free(le.orig_free_Invalid),Fields.InvalidMessage_orig_record_count(le.orig_record_count_Invalid),Fields.InvalidMessage_orig_price(le.orig_price_Invalid),Fields.InvalidMessage_orig_revenue(le.orig_revenue_Invalid),Fields.InvalidMessage_orig_full_name(le.orig_full_name_Invalid),Fields.InvalidMessage_orig_business_name(le.orig_business_name_Invalid),Fields.InvalidMessage_orig_business_name_2(le.orig_business_name_2_Invalid),Fields.InvalidMessage_orig_years(le.orig_years_Invalid),Fields.InvalidMessage_orig_pricing_error_code(le.orig_pricing_error_code_Invalid),Fields.InvalidMessage_orig_fcra_purpose(le.orig_fcra_purpose_Invalid),Fields.InvalidMessage_orig_result_format(le.orig_result_format_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_dob_2(le.orig_dob_2_Invalid),Fields.InvalidMessage_orig_unique_id(le.orig_unique_id_Invalid),Fields.InvalidMessage_orig_response_time(le.orig_response_time_Invalid),Fields.InvalidMessage_orig_data_source(le.orig_data_source_Invalid),Fields.InvalidMessage_orig_report_options(le.orig_report_options_Invalid),Fields.InvalidMessage_orig_end_user_name(le.orig_end_user_name_Invalid),Fields.InvalidMessage_orig_end_user_address_1(le.orig_end_user_address_1_Invalid),Fields.InvalidMessage_orig_end_user_address_2(le.orig_end_user_address_2_Invalid),Fields.InvalidMessage_orig_end_user_city(le.orig_end_user_city_Invalid),Fields.InvalidMessage_orig_end_user_state(le.orig_end_user_state_Invalid),Fields.InvalidMessage_orig_end_user_zip(le.orig_end_user_zip_Invalid),Fields.InvalidMessage_orig_login_history_id(le.orig_login_history_id_Invalid),Fields.InvalidMessage_orig_employment_state(le.orig_employment_state_Invalid),Fields.InvalidMessage_orig_end_user_industry_class(le.orig_end_user_industry_class_Invalid),Fields.InvalidMessage_orig_function_specific_data(le.orig_function_specific_data_Invalid),Fields.InvalidMessage_orig_date_added(le.orig_date_added_Invalid),Fields.InvalidMessage_orig_retail_price(le.orig_retail_price_Invalid),Fields.InvalidMessage_orig_country_code(le.orig_country_code_Invalid),Fields.InvalidMessage_orig_email(le.orig_email_Invalid),Fields.InvalidMessage_orig_email_2(le.orig_email_2_Invalid),Fields.InvalidMessage_orig_dl_number(le.orig_dl_number_Invalid),Fields.InvalidMessage_orig_dl_number_2(le.orig_dl_number_2_Invalid),Fields.InvalidMessage_orig_sub_id(le.orig_sub_id_Invalid),Fields.InvalidMessage_orig_neighbors(le.orig_neighbors_Invalid),Fields.InvalidMessage_orig_relatives(le.orig_relatives_Invalid),Fields.InvalidMessage_orig_associates(le.orig_associates_Invalid),Fields.InvalidMessage_orig_property(le.orig_property_Invalid),Fields.InvalidMessage_orig_bankruptcy(le.orig_bankruptcy_Invalid),Fields.InvalidMessage_orig_dls(le.orig_dls_Invalid),Fields.InvalidMessage_orig_mvs(le.orig_mvs_Invalid),Fields.InvalidMessage_orig_ip_address(le.orig_ip_address_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_login_id_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_billing_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_transaction_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_function_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_company_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_reference_code_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fname_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mname_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_lname_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_name_suffix_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_city_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip4_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_clean_address_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_clean_city_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_clean_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_clean_zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_clean_zip4_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_homephone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_homephone_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_workphone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_workphone_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ssn_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_free_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_record_count_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_price_Invalid,'LEFTTRIM','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_revenue_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_full_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_business_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_business_name_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_years_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_pricing_error_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fcra_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_result_format_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dob_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_unique_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_response_time_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_data_source_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_report_options_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_end_user_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_end_user_address_1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_end_user_address_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_end_user_city_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_end_user_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_end_user_zip_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_login_history_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_employment_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_end_user_industry_class_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_function_specific_data_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_date_added_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_retail_price_Invalid,'LEFTTRIM','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_country_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_email_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_email_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dl_number_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dl_number_2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_sub_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_neighbors_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_relatives_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_associates_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_property_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_bankruptcy_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dls_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mvs_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ip_address_Invalid,'LEFTTRIM','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.orig_login_id,(SALT39.StrType)le.orig_billing_code,(SALT39.StrType)le.orig_transaction_id,(SALT39.StrType)le.orig_function_name,(SALT39.StrType)le.orig_company_id,(SALT39.StrType)le.orig_reference_code,(SALT39.StrType)le.orig_fname,(SALT39.StrType)le.orig_mname,(SALT39.StrType)le.orig_lname,(SALT39.StrType)le.orig_name_suffix,(SALT39.StrType)le.orig_fname_2,(SALT39.StrType)le.orig_mname_2,(SALT39.StrType)le.orig_lname_2,(SALT39.StrType)le.orig_name_suffix_2,(SALT39.StrType)le.orig_address,(SALT39.StrType)le.orig_city,(SALT39.StrType)le.orig_state,(SALT39.StrType)le.orig_zip,(SALT39.StrType)le.orig_zip4,(SALT39.StrType)le.orig_address_2,(SALT39.StrType)le.orig_city_2,(SALT39.StrType)le.orig_state_2,(SALT39.StrType)le.orig_zip_2,(SALT39.StrType)le.orig_zip4_2,(SALT39.StrType)le.orig_clean_address,(SALT39.StrType)le.orig_clean_city,(SALT39.StrType)le.orig_clean_state,(SALT39.StrType)le.orig_clean_zip,(SALT39.StrType)le.orig_clean_zip4,(SALT39.StrType)le.orig_phone,(SALT39.StrType)le.orig_homephone,(SALT39.StrType)le.orig_homephone_2,(SALT39.StrType)le.orig_workphone,(SALT39.StrType)le.orig_workphone_2,(SALT39.StrType)le.orig_ssn,(SALT39.StrType)le.orig_ssn_2,(SALT39.StrType)le.orig_free,(SALT39.StrType)le.orig_record_count,(SALT39.StrType)le.orig_price,(SALT39.StrType)le.orig_revenue,(SALT39.StrType)le.orig_full_name,(SALT39.StrType)le.orig_business_name,(SALT39.StrType)le.orig_business_name_2,(SALT39.StrType)le.orig_years,(SALT39.StrType)le.orig_pricing_error_code,(SALT39.StrType)le.orig_fcra_purpose,(SALT39.StrType)le.orig_result_format,(SALT39.StrType)le.orig_dob,(SALT39.StrType)le.orig_dob_2,(SALT39.StrType)le.orig_unique_id,(SALT39.StrType)le.orig_response_time,(SALT39.StrType)le.orig_data_source,(SALT39.StrType)le.orig_report_options,(SALT39.StrType)le.orig_end_user_name,(SALT39.StrType)le.orig_end_user_address_1,(SALT39.StrType)le.orig_end_user_address_2,(SALT39.StrType)le.orig_end_user_city,(SALT39.StrType)le.orig_end_user_state,(SALT39.StrType)le.orig_end_user_zip,(SALT39.StrType)le.orig_login_history_id,(SALT39.StrType)le.orig_employment_state,(SALT39.StrType)le.orig_end_user_industry_class,(SALT39.StrType)le.orig_function_specific_data,(SALT39.StrType)le.orig_date_added,(SALT39.StrType)le.orig_retail_price,(SALT39.StrType)le.orig_country_code,(SALT39.StrType)le.orig_email,(SALT39.StrType)le.orig_email_2,(SALT39.StrType)le.orig_dl_number,(SALT39.StrType)le.orig_dl_number_2,(SALT39.StrType)le.orig_sub_id,(SALT39.StrType)le.orig_neighbors,(SALT39.StrType)le.orig_relatives,(SALT39.StrType)le.orig_associates,(SALT39.StrType)le.orig_property,(SALT39.StrType)le.orig_bankruptcy,(SALT39.StrType)le.orig_dls,(SALT39.StrType)le.orig_mvs,(SALT39.StrType)le.orig_ip_address,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,79,Into(LEFT,COUNTER));
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
          ,'orig_login_id:orig_login_id:ALLOW','orig_login_id:orig_login_id:WORDS'
          ,'orig_billing_code:orig_billing_code:LEFTTRIM','orig_billing_code:orig_billing_code:ALLOW','orig_billing_code:orig_billing_code:LENGTHS','orig_billing_code:orig_billing_code:WORDS'
          ,'orig_transaction_id:orig_transaction_id:LEFTTRIM','orig_transaction_id:orig_transaction_id:ALLOW','orig_transaction_id:orig_transaction_id:WORDS'
          ,'orig_function_name:orig_function_name:LEFTTRIM','orig_function_name:orig_function_name:ALLOW','orig_function_name:orig_function_name:WORDS'
          ,'orig_company_id:orig_company_id:LEFTTRIM','orig_company_id:orig_company_id:ALLOW','orig_company_id:orig_company_id:WORDS'
          ,'orig_reference_code:orig_reference_code:ALLOW','orig_reference_code:orig_reference_code:WORDS'
          ,'orig_fname:orig_fname:ALLOW','orig_fname:orig_fname:WORDS'
          ,'orig_mname:orig_mname:ALLOW','orig_mname:orig_mname:WORDS'
          ,'orig_lname:orig_lname:ALLOW','orig_lname:orig_lname:WORDS'
          ,'orig_name_suffix:orig_name_suffix:LEFTTRIM','orig_name_suffix:orig_name_suffix:ALLOW','orig_name_suffix:orig_name_suffix:LENGTHS','orig_name_suffix:orig_name_suffix:WORDS'
          ,'orig_fname_2:orig_fname_2:LEFTTRIM','orig_fname_2:orig_fname_2:ALLOW','orig_fname_2:orig_fname_2:LENGTHS','orig_fname_2:orig_fname_2:WORDS'
          ,'orig_mname_2:orig_mname_2:LEFTTRIM','orig_mname_2:orig_mname_2:ALLOW','orig_mname_2:orig_mname_2:LENGTHS','orig_mname_2:orig_mname_2:WORDS'
          ,'orig_lname_2:orig_lname_2:LEFTTRIM','orig_lname_2:orig_lname_2:ALLOW','orig_lname_2:orig_lname_2:LENGTHS','orig_lname_2:orig_lname_2:WORDS'
          ,'orig_name_suffix_2:orig_name_suffix_2:LEFTTRIM','orig_name_suffix_2:orig_name_suffix_2:ALLOW','orig_name_suffix_2:orig_name_suffix_2:LENGTHS','orig_name_suffix_2:orig_name_suffix_2:WORDS'
          ,'orig_address:orig_address:LEFTTRIM','orig_address:orig_address:ALLOW'
          ,'orig_city:orig_city:LEFTTRIM','orig_city:orig_city:ALLOW','orig_city:orig_city:WORDS'
          ,'orig_state:orig_state:LEFTTRIM','orig_state:orig_state:ALLOW','orig_state:orig_state:LENGTHS','orig_state:orig_state:WORDS'
          ,'orig_zip:orig_zip:LEFTTRIM','orig_zip:orig_zip:ALLOW','orig_zip:orig_zip:WORDS'
          ,'orig_zip4:orig_zip4:ALLOW','orig_zip4:orig_zip4:WORDS'
          ,'orig_address_2:orig_address_2:LEFTTRIM','orig_address_2:orig_address_2:ALLOW','orig_address_2:orig_address_2:LENGTHS','orig_address_2:orig_address_2:WORDS'
          ,'orig_city_2:orig_city_2:LEFTTRIM','orig_city_2:orig_city_2:ALLOW','orig_city_2:orig_city_2:LENGTHS','orig_city_2:orig_city_2:WORDS'
          ,'orig_state_2:orig_state_2:LEFTTRIM','orig_state_2:orig_state_2:ALLOW','orig_state_2:orig_state_2:LENGTHS','orig_state_2:orig_state_2:WORDS'
          ,'orig_zip_2:orig_zip_2:LEFTTRIM','orig_zip_2:orig_zip_2:ALLOW','orig_zip_2:orig_zip_2:LENGTHS','orig_zip_2:orig_zip_2:WORDS'
          ,'orig_zip4_2:orig_zip4_2:LEFTTRIM','orig_zip4_2:orig_zip4_2:ALLOW','orig_zip4_2:orig_zip4_2:LENGTHS','orig_zip4_2:orig_zip4_2:WORDS'
          ,'orig_clean_address:orig_clean_address:LEFTTRIM','orig_clean_address:orig_clean_address:ALLOW','orig_clean_address:orig_clean_address:LENGTHS','orig_clean_address:orig_clean_address:WORDS'
          ,'orig_clean_city:orig_clean_city:LEFTTRIM','orig_clean_city:orig_clean_city:ALLOW','orig_clean_city:orig_clean_city:LENGTHS','orig_clean_city:orig_clean_city:WORDS'
          ,'orig_clean_state:orig_clean_state:LEFTTRIM','orig_clean_state:orig_clean_state:ALLOW','orig_clean_state:orig_clean_state:LENGTHS','orig_clean_state:orig_clean_state:WORDS'
          ,'orig_clean_zip:orig_clean_zip:LEFTTRIM','orig_clean_zip:orig_clean_zip:ALLOW','orig_clean_zip:orig_clean_zip:LENGTHS','orig_clean_zip:orig_clean_zip:WORDS'
          ,'orig_clean_zip4:orig_clean_zip4:LEFTTRIM','orig_clean_zip4:orig_clean_zip4:ALLOW','orig_clean_zip4:orig_clean_zip4:LENGTHS','orig_clean_zip4:orig_clean_zip4:WORDS'
          ,'orig_phone:orig_phone:LEFTTRIM','orig_phone:orig_phone:ALLOW','orig_phone:orig_phone:LENGTHS','orig_phone:orig_phone:WORDS'
          ,'orig_homephone:orig_homephone:LEFTTRIM','orig_homephone:orig_homephone:ALLOW','orig_homephone:orig_homephone:LENGTHS','orig_homephone:orig_homephone:WORDS'
          ,'orig_homephone_2:orig_homephone_2:LEFTTRIM','orig_homephone_2:orig_homephone_2:ALLOW','orig_homephone_2:orig_homephone_2:LENGTHS','orig_homephone_2:orig_homephone_2:WORDS'
          ,'orig_workphone:orig_workphone:LEFTTRIM','orig_workphone:orig_workphone:ALLOW','orig_workphone:orig_workphone:LENGTHS','orig_workphone:orig_workphone:WORDS'
          ,'orig_workphone_2:orig_workphone_2:LEFTTRIM','orig_workphone_2:orig_workphone_2:ALLOW','orig_workphone_2:orig_workphone_2:LENGTHS','orig_workphone_2:orig_workphone_2:WORDS'
          ,'orig_ssn:orig_ssn:LEFTTRIM','orig_ssn:orig_ssn:ALLOW','orig_ssn:orig_ssn:LENGTHS','orig_ssn:orig_ssn:WORDS'
          ,'orig_ssn_2:orig_ssn_2:LEFTTRIM','orig_ssn_2:orig_ssn_2:ALLOW','orig_ssn_2:orig_ssn_2:LENGTHS','orig_ssn_2:orig_ssn_2:WORDS'
          ,'orig_free:orig_free:LEFTTRIM','orig_free:orig_free:ALLOW','orig_free:orig_free:LENGTHS','orig_free:orig_free:WORDS'
          ,'orig_record_count:orig_record_count:LEFTTRIM','orig_record_count:orig_record_count:ALLOW','orig_record_count:orig_record_count:LENGTHS','orig_record_count:orig_record_count:WORDS'
          ,'orig_price:orig_price:LEFTTRIM','orig_price:orig_price:WORDS'
          ,'orig_revenue:orig_revenue:LEFTTRIM','orig_revenue:orig_revenue:ALLOW','orig_revenue:orig_revenue:LENGTHS','orig_revenue:orig_revenue:WORDS'
          ,'orig_full_name:orig_full_name:LEFTTRIM','orig_full_name:orig_full_name:ALLOW','orig_full_name:orig_full_name:WORDS'
          ,'orig_business_name:orig_business_name:LEFTTRIM','orig_business_name:orig_business_name:ALLOW','orig_business_name:orig_business_name:LENGTHS','orig_business_name:orig_business_name:WORDS'
          ,'orig_business_name_2:orig_business_name_2:LEFTTRIM','orig_business_name_2:orig_business_name_2:ALLOW','orig_business_name_2:orig_business_name_2:LENGTHS','orig_business_name_2:orig_business_name_2:WORDS'
          ,'orig_years:orig_years:LEFTTRIM','orig_years:orig_years:ALLOW','orig_years:orig_years:LENGTHS','orig_years:orig_years:WORDS'
          ,'orig_pricing_error_code:orig_pricing_error_code:LEFTTRIM','orig_pricing_error_code:orig_pricing_error_code:ALLOW','orig_pricing_error_code:orig_pricing_error_code:LENGTHS','orig_pricing_error_code:orig_pricing_error_code:WORDS'
          ,'orig_fcra_purpose:orig_fcra_purpose:LEFTTRIM','orig_fcra_purpose:orig_fcra_purpose:ALLOW','orig_fcra_purpose:orig_fcra_purpose:LENGTHS','orig_fcra_purpose:orig_fcra_purpose:WORDS'
          ,'orig_result_format:orig_result_format:LEFTTRIM','orig_result_format:orig_result_format:ALLOW','orig_result_format:orig_result_format:LENGTHS','orig_result_format:orig_result_format:WORDS'
          ,'orig_dob:orig_dob:LEFTTRIM','orig_dob:orig_dob:ALLOW','orig_dob:orig_dob:LENGTHS','orig_dob:orig_dob:WORDS'
          ,'orig_dob_2:orig_dob_2:LEFTTRIM','orig_dob_2:orig_dob_2:ALLOW','orig_dob_2:orig_dob_2:LENGTHS','orig_dob_2:orig_dob_2:WORDS'
          ,'orig_unique_id:orig_unique_id:LEFTTRIM','orig_unique_id:orig_unique_id:ALLOW','orig_unique_id:orig_unique_id:WORDS'
          ,'orig_response_time:orig_response_time:LEFTTRIM','orig_response_time:orig_response_time:ALLOW','orig_response_time:orig_response_time:LENGTHS','orig_response_time:orig_response_time:WORDS'
          ,'orig_data_source:orig_data_source:LEFTTRIM','orig_data_source:orig_data_source:ALLOW','orig_data_source:orig_data_source:LENGTHS','orig_data_source:orig_data_source:WORDS'
          ,'orig_report_options:orig_report_options:LEFTTRIM','orig_report_options:orig_report_options:ALLOW','orig_report_options:orig_report_options:WORDS'
          ,'orig_end_user_name:orig_end_user_name:LEFTTRIM','orig_end_user_name:orig_end_user_name:ALLOW'
          ,'orig_end_user_address_1:orig_end_user_address_1:LEFTTRIM','orig_end_user_address_1:orig_end_user_address_1:ALLOW'
          ,'orig_end_user_address_2:orig_end_user_address_2:LEFTTRIM','orig_end_user_address_2:orig_end_user_address_2:ALLOW','orig_end_user_address_2:orig_end_user_address_2:LENGTHS','orig_end_user_address_2:orig_end_user_address_2:WORDS'
          ,'orig_end_user_city:orig_end_user_city:LEFTTRIM','orig_end_user_city:orig_end_user_city:ALLOW','orig_end_user_city:orig_end_user_city:WORDS'
          ,'orig_end_user_state:orig_end_user_state:LEFTTRIM','orig_end_user_state:orig_end_user_state:ALLOW','orig_end_user_state:orig_end_user_state:LENGTHS','orig_end_user_state:orig_end_user_state:WORDS'
          ,'orig_end_user_zip:orig_end_user_zip:LEFTTRIM','orig_end_user_zip:orig_end_user_zip:ALLOW','orig_end_user_zip:orig_end_user_zip:WORDS'
          ,'orig_login_history_id:orig_login_history_id:LEFTTRIM','orig_login_history_id:orig_login_history_id:ALLOW','orig_login_history_id:orig_login_history_id:LENGTHS','orig_login_history_id:orig_login_history_id:WORDS'
          ,'orig_employment_state:orig_employment_state:LEFTTRIM','orig_employment_state:orig_employment_state:ALLOW','orig_employment_state:orig_employment_state:LENGTHS','orig_employment_state:orig_employment_state:WORDS'
          ,'orig_end_user_industry_class:orig_end_user_industry_class:LEFTTRIM','orig_end_user_industry_class:orig_end_user_industry_class:ALLOW','orig_end_user_industry_class:orig_end_user_industry_class:LENGTHS','orig_end_user_industry_class:orig_end_user_industry_class:WORDS'
          ,'orig_function_specific_data:orig_function_specific_data:LEFTTRIM','orig_function_specific_data:orig_function_specific_data:ALLOW','orig_function_specific_data:orig_function_specific_data:LENGTHS','orig_function_specific_data:orig_function_specific_data:WORDS'
          ,'orig_date_added:orig_date_added:LEFTTRIM','orig_date_added:orig_date_added:ALLOW','orig_date_added:orig_date_added:LENGTHS','orig_date_added:orig_date_added:WORDS'
          ,'orig_retail_price:orig_retail_price:LEFTTRIM','orig_retail_price:orig_retail_price:WORDS'
          ,'orig_country_code:orig_country_code:LEFTTRIM','orig_country_code:orig_country_code:ALLOW','orig_country_code:orig_country_code:LENGTHS','orig_country_code:orig_country_code:WORDS'
          ,'orig_email:orig_email:LEFTTRIM','orig_email:orig_email:ALLOW','orig_email:orig_email:WORDS'
          ,'orig_email_2:orig_email_2:LEFTTRIM','orig_email_2:orig_email_2:ALLOW','orig_email_2:orig_email_2:LENGTHS','orig_email_2:orig_email_2:WORDS'
          ,'orig_dl_number:orig_dl_number:LEFTTRIM','orig_dl_number:orig_dl_number:ALLOW','orig_dl_number:orig_dl_number:WORDS'
          ,'orig_dl_number_2:orig_dl_number_2:LEFTTRIM','orig_dl_number_2:orig_dl_number_2:ALLOW','orig_dl_number_2:orig_dl_number_2:LENGTHS','orig_dl_number_2:orig_dl_number_2:WORDS'
          ,'orig_sub_id:orig_sub_id:LEFTTRIM','orig_sub_id:orig_sub_id:ALLOW','orig_sub_id:orig_sub_id:WORDS'
          ,'orig_neighbors:orig_neighbors:LEFTTRIM','orig_neighbors:orig_neighbors:ALLOW','orig_neighbors:orig_neighbors:LENGTHS','orig_neighbors:orig_neighbors:WORDS'
          ,'orig_relatives:orig_relatives:LEFTTRIM','orig_relatives:orig_relatives:ALLOW','orig_relatives:orig_relatives:LENGTHS','orig_relatives:orig_relatives:WORDS'
          ,'orig_associates:orig_associates:LEFTTRIM','orig_associates:orig_associates:ALLOW','orig_associates:orig_associates:LENGTHS','orig_associates:orig_associates:WORDS'
          ,'orig_property:orig_property:LEFTTRIM','orig_property:orig_property:ALLOW','orig_property:orig_property:LENGTHS','orig_property:orig_property:WORDS'
          ,'orig_bankruptcy:orig_bankruptcy:LEFTTRIM','orig_bankruptcy:orig_bankruptcy:ALLOW','orig_bankruptcy:orig_bankruptcy:LENGTHS','orig_bankruptcy:orig_bankruptcy:WORDS'
          ,'orig_dls:orig_dls:LEFTTRIM','orig_dls:orig_dls:ALLOW','orig_dls:orig_dls:LENGTHS','orig_dls:orig_dls:WORDS'
          ,'orig_mvs:orig_mvs:LEFTTRIM','orig_mvs:orig_mvs:ALLOW','orig_mvs:orig_mvs:LENGTHS','orig_mvs:orig_mvs:WORDS'
          ,'orig_ip_address:orig_ip_address:LEFTTRIM','orig_ip_address:orig_ip_address:WORDS'
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
          ,Fields.InvalidMessage_orig_login_id(1),Fields.InvalidMessage_orig_login_id(2)
          ,Fields.InvalidMessage_orig_billing_code(1),Fields.InvalidMessage_orig_billing_code(2),Fields.InvalidMessage_orig_billing_code(3),Fields.InvalidMessage_orig_billing_code(4)
          ,Fields.InvalidMessage_orig_transaction_id(1),Fields.InvalidMessage_orig_transaction_id(2),Fields.InvalidMessage_orig_transaction_id(3)
          ,Fields.InvalidMessage_orig_function_name(1),Fields.InvalidMessage_orig_function_name(2),Fields.InvalidMessage_orig_function_name(3)
          ,Fields.InvalidMessage_orig_company_id(1),Fields.InvalidMessage_orig_company_id(2),Fields.InvalidMessage_orig_company_id(3)
          ,Fields.InvalidMessage_orig_reference_code(1),Fields.InvalidMessage_orig_reference_code(2)
          ,Fields.InvalidMessage_orig_fname(1),Fields.InvalidMessage_orig_fname(2)
          ,Fields.InvalidMessage_orig_mname(1),Fields.InvalidMessage_orig_mname(2)
          ,Fields.InvalidMessage_orig_lname(1),Fields.InvalidMessage_orig_lname(2)
          ,Fields.InvalidMessage_orig_name_suffix(1),Fields.InvalidMessage_orig_name_suffix(2),Fields.InvalidMessage_orig_name_suffix(3),Fields.InvalidMessage_orig_name_suffix(4)
          ,Fields.InvalidMessage_orig_fname_2(1),Fields.InvalidMessage_orig_fname_2(2),Fields.InvalidMessage_orig_fname_2(3),Fields.InvalidMessage_orig_fname_2(4)
          ,Fields.InvalidMessage_orig_mname_2(1),Fields.InvalidMessage_orig_mname_2(2),Fields.InvalidMessage_orig_mname_2(3),Fields.InvalidMessage_orig_mname_2(4)
          ,Fields.InvalidMessage_orig_lname_2(1),Fields.InvalidMessage_orig_lname_2(2),Fields.InvalidMessage_orig_lname_2(3),Fields.InvalidMessage_orig_lname_2(4)
          ,Fields.InvalidMessage_orig_name_suffix_2(1),Fields.InvalidMessage_orig_name_suffix_2(2),Fields.InvalidMessage_orig_name_suffix_2(3),Fields.InvalidMessage_orig_name_suffix_2(4)
          ,Fields.InvalidMessage_orig_address(1),Fields.InvalidMessage_orig_address(2)
          ,Fields.InvalidMessage_orig_city(1),Fields.InvalidMessage_orig_city(2),Fields.InvalidMessage_orig_city(3)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2),Fields.InvalidMessage_orig_state(3),Fields.InvalidMessage_orig_state(4)
          ,Fields.InvalidMessage_orig_zip(1),Fields.InvalidMessage_orig_zip(2),Fields.InvalidMessage_orig_zip(3)
          ,Fields.InvalidMessage_orig_zip4(1),Fields.InvalidMessage_orig_zip4(2)
          ,Fields.InvalidMessage_orig_address_2(1),Fields.InvalidMessage_orig_address_2(2),Fields.InvalidMessage_orig_address_2(3),Fields.InvalidMessage_orig_address_2(4)
          ,Fields.InvalidMessage_orig_city_2(1),Fields.InvalidMessage_orig_city_2(2),Fields.InvalidMessage_orig_city_2(3),Fields.InvalidMessage_orig_city_2(4)
          ,Fields.InvalidMessage_orig_state_2(1),Fields.InvalidMessage_orig_state_2(2),Fields.InvalidMessage_orig_state_2(3),Fields.InvalidMessage_orig_state_2(4)
          ,Fields.InvalidMessage_orig_zip_2(1),Fields.InvalidMessage_orig_zip_2(2),Fields.InvalidMessage_orig_zip_2(3),Fields.InvalidMessage_orig_zip_2(4)
          ,Fields.InvalidMessage_orig_zip4_2(1),Fields.InvalidMessage_orig_zip4_2(2),Fields.InvalidMessage_orig_zip4_2(3),Fields.InvalidMessage_orig_zip4_2(4)
          ,Fields.InvalidMessage_orig_clean_address(1),Fields.InvalidMessage_orig_clean_address(2),Fields.InvalidMessage_orig_clean_address(3),Fields.InvalidMessage_orig_clean_address(4)
          ,Fields.InvalidMessage_orig_clean_city(1),Fields.InvalidMessage_orig_clean_city(2),Fields.InvalidMessage_orig_clean_city(3),Fields.InvalidMessage_orig_clean_city(4)
          ,Fields.InvalidMessage_orig_clean_state(1),Fields.InvalidMessage_orig_clean_state(2),Fields.InvalidMessage_orig_clean_state(3),Fields.InvalidMessage_orig_clean_state(4)
          ,Fields.InvalidMessage_orig_clean_zip(1),Fields.InvalidMessage_orig_clean_zip(2),Fields.InvalidMessage_orig_clean_zip(3),Fields.InvalidMessage_orig_clean_zip(4)
          ,Fields.InvalidMessage_orig_clean_zip4(1),Fields.InvalidMessage_orig_clean_zip4(2),Fields.InvalidMessage_orig_clean_zip4(3),Fields.InvalidMessage_orig_clean_zip4(4)
          ,Fields.InvalidMessage_orig_phone(1),Fields.InvalidMessage_orig_phone(2),Fields.InvalidMessage_orig_phone(3),Fields.InvalidMessage_orig_phone(4)
          ,Fields.InvalidMessage_orig_homephone(1),Fields.InvalidMessage_orig_homephone(2),Fields.InvalidMessage_orig_homephone(3),Fields.InvalidMessage_orig_homephone(4)
          ,Fields.InvalidMessage_orig_homephone_2(1),Fields.InvalidMessage_orig_homephone_2(2),Fields.InvalidMessage_orig_homephone_2(3),Fields.InvalidMessage_orig_homephone_2(4)
          ,Fields.InvalidMessage_orig_workphone(1),Fields.InvalidMessage_orig_workphone(2),Fields.InvalidMessage_orig_workphone(3),Fields.InvalidMessage_orig_workphone(4)
          ,Fields.InvalidMessage_orig_workphone_2(1),Fields.InvalidMessage_orig_workphone_2(2),Fields.InvalidMessage_orig_workphone_2(3),Fields.InvalidMessage_orig_workphone_2(4)
          ,Fields.InvalidMessage_orig_ssn(1),Fields.InvalidMessage_orig_ssn(2),Fields.InvalidMessage_orig_ssn(3),Fields.InvalidMessage_orig_ssn(4)
          ,Fields.InvalidMessage_orig_ssn_2(1),Fields.InvalidMessage_orig_ssn_2(2),Fields.InvalidMessage_orig_ssn_2(3),Fields.InvalidMessage_orig_ssn_2(4)
          ,Fields.InvalidMessage_orig_free(1),Fields.InvalidMessage_orig_free(2),Fields.InvalidMessage_orig_free(3),Fields.InvalidMessage_orig_free(4)
          ,Fields.InvalidMessage_orig_record_count(1),Fields.InvalidMessage_orig_record_count(2),Fields.InvalidMessage_orig_record_count(3),Fields.InvalidMessage_orig_record_count(4)
          ,Fields.InvalidMessage_orig_price(1),Fields.InvalidMessage_orig_price(2)
          ,Fields.InvalidMessage_orig_revenue(1),Fields.InvalidMessage_orig_revenue(2),Fields.InvalidMessage_orig_revenue(3),Fields.InvalidMessage_orig_revenue(4)
          ,Fields.InvalidMessage_orig_full_name(1),Fields.InvalidMessage_orig_full_name(2),Fields.InvalidMessage_orig_full_name(3)
          ,Fields.InvalidMessage_orig_business_name(1),Fields.InvalidMessage_orig_business_name(2),Fields.InvalidMessage_orig_business_name(3),Fields.InvalidMessage_orig_business_name(4)
          ,Fields.InvalidMessage_orig_business_name_2(1),Fields.InvalidMessage_orig_business_name_2(2),Fields.InvalidMessage_orig_business_name_2(3),Fields.InvalidMessage_orig_business_name_2(4)
          ,Fields.InvalidMessage_orig_years(1),Fields.InvalidMessage_orig_years(2),Fields.InvalidMessage_orig_years(3),Fields.InvalidMessage_orig_years(4)
          ,Fields.InvalidMessage_orig_pricing_error_code(1),Fields.InvalidMessage_orig_pricing_error_code(2),Fields.InvalidMessage_orig_pricing_error_code(3),Fields.InvalidMessage_orig_pricing_error_code(4)
          ,Fields.InvalidMessage_orig_fcra_purpose(1),Fields.InvalidMessage_orig_fcra_purpose(2),Fields.InvalidMessage_orig_fcra_purpose(3),Fields.InvalidMessage_orig_fcra_purpose(4)
          ,Fields.InvalidMessage_orig_result_format(1),Fields.InvalidMessage_orig_result_format(2),Fields.InvalidMessage_orig_result_format(3),Fields.InvalidMessage_orig_result_format(4)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2),Fields.InvalidMessage_orig_dob(3),Fields.InvalidMessage_orig_dob(4)
          ,Fields.InvalidMessage_orig_dob_2(1),Fields.InvalidMessage_orig_dob_2(2),Fields.InvalidMessage_orig_dob_2(3),Fields.InvalidMessage_orig_dob_2(4)
          ,Fields.InvalidMessage_orig_unique_id(1),Fields.InvalidMessage_orig_unique_id(2),Fields.InvalidMessage_orig_unique_id(3)
          ,Fields.InvalidMessage_orig_response_time(1),Fields.InvalidMessage_orig_response_time(2),Fields.InvalidMessage_orig_response_time(3),Fields.InvalidMessage_orig_response_time(4)
          ,Fields.InvalidMessage_orig_data_source(1),Fields.InvalidMessage_orig_data_source(2),Fields.InvalidMessage_orig_data_source(3),Fields.InvalidMessage_orig_data_source(4)
          ,Fields.InvalidMessage_orig_report_options(1),Fields.InvalidMessage_orig_report_options(2),Fields.InvalidMessage_orig_report_options(3)
          ,Fields.InvalidMessage_orig_end_user_name(1),Fields.InvalidMessage_orig_end_user_name(2)
          ,Fields.InvalidMessage_orig_end_user_address_1(1),Fields.InvalidMessage_orig_end_user_address_1(2)
          ,Fields.InvalidMessage_orig_end_user_address_2(1),Fields.InvalidMessage_orig_end_user_address_2(2),Fields.InvalidMessage_orig_end_user_address_2(3),Fields.InvalidMessage_orig_end_user_address_2(4)
          ,Fields.InvalidMessage_orig_end_user_city(1),Fields.InvalidMessage_orig_end_user_city(2),Fields.InvalidMessage_orig_end_user_city(3)
          ,Fields.InvalidMessage_orig_end_user_state(1),Fields.InvalidMessage_orig_end_user_state(2),Fields.InvalidMessage_orig_end_user_state(3),Fields.InvalidMessage_orig_end_user_state(4)
          ,Fields.InvalidMessage_orig_end_user_zip(1),Fields.InvalidMessage_orig_end_user_zip(2),Fields.InvalidMessage_orig_end_user_zip(3)
          ,Fields.InvalidMessage_orig_login_history_id(1),Fields.InvalidMessage_orig_login_history_id(2),Fields.InvalidMessage_orig_login_history_id(3),Fields.InvalidMessage_orig_login_history_id(4)
          ,Fields.InvalidMessage_orig_employment_state(1),Fields.InvalidMessage_orig_employment_state(2),Fields.InvalidMessage_orig_employment_state(3),Fields.InvalidMessage_orig_employment_state(4)
          ,Fields.InvalidMessage_orig_end_user_industry_class(1),Fields.InvalidMessage_orig_end_user_industry_class(2),Fields.InvalidMessage_orig_end_user_industry_class(3),Fields.InvalidMessage_orig_end_user_industry_class(4)
          ,Fields.InvalidMessage_orig_function_specific_data(1),Fields.InvalidMessage_orig_function_specific_data(2),Fields.InvalidMessage_orig_function_specific_data(3),Fields.InvalidMessage_orig_function_specific_data(4)
          ,Fields.InvalidMessage_orig_date_added(1),Fields.InvalidMessage_orig_date_added(2),Fields.InvalidMessage_orig_date_added(3),Fields.InvalidMessage_orig_date_added(4)
          ,Fields.InvalidMessage_orig_retail_price(1),Fields.InvalidMessage_orig_retail_price(2)
          ,Fields.InvalidMessage_orig_country_code(1),Fields.InvalidMessage_orig_country_code(2),Fields.InvalidMessage_orig_country_code(3),Fields.InvalidMessage_orig_country_code(4)
          ,Fields.InvalidMessage_orig_email(1),Fields.InvalidMessage_orig_email(2),Fields.InvalidMessage_orig_email(3)
          ,Fields.InvalidMessage_orig_email_2(1),Fields.InvalidMessage_orig_email_2(2),Fields.InvalidMessage_orig_email_2(3),Fields.InvalidMessage_orig_email_2(4)
          ,Fields.InvalidMessage_orig_dl_number(1),Fields.InvalidMessage_orig_dl_number(2),Fields.InvalidMessage_orig_dl_number(3)
          ,Fields.InvalidMessage_orig_dl_number_2(1),Fields.InvalidMessage_orig_dl_number_2(2),Fields.InvalidMessage_orig_dl_number_2(3),Fields.InvalidMessage_orig_dl_number_2(4)
          ,Fields.InvalidMessage_orig_sub_id(1),Fields.InvalidMessage_orig_sub_id(2),Fields.InvalidMessage_orig_sub_id(3)
          ,Fields.InvalidMessage_orig_neighbors(1),Fields.InvalidMessage_orig_neighbors(2),Fields.InvalidMessage_orig_neighbors(3),Fields.InvalidMessage_orig_neighbors(4)
          ,Fields.InvalidMessage_orig_relatives(1),Fields.InvalidMessage_orig_relatives(2),Fields.InvalidMessage_orig_relatives(3),Fields.InvalidMessage_orig_relatives(4)
          ,Fields.InvalidMessage_orig_associates(1),Fields.InvalidMessage_orig_associates(2),Fields.InvalidMessage_orig_associates(3),Fields.InvalidMessage_orig_associates(4)
          ,Fields.InvalidMessage_orig_property(1),Fields.InvalidMessage_orig_property(2),Fields.InvalidMessage_orig_property(3),Fields.InvalidMessage_orig_property(4)
          ,Fields.InvalidMessage_orig_bankruptcy(1),Fields.InvalidMessage_orig_bankruptcy(2),Fields.InvalidMessage_orig_bankruptcy(3),Fields.InvalidMessage_orig_bankruptcy(4)
          ,Fields.InvalidMessage_orig_dls(1),Fields.InvalidMessage_orig_dls(2),Fields.InvalidMessage_orig_dls(3),Fields.InvalidMessage_orig_dls(4)
          ,Fields.InvalidMessage_orig_mvs(1),Fields.InvalidMessage_orig_mvs(2),Fields.InvalidMessage_orig_mvs(3),Fields.InvalidMessage_orig_mvs(4)
          ,Fields.InvalidMessage_orig_ip_address(1),Fields.InvalidMessage_orig_ip_address(2)
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
          ,le.orig_login_id_ALLOW_ErrorCount,le.orig_login_id_WORDS_ErrorCount
          ,le.orig_billing_code_LEFTTRIM_ErrorCount,le.orig_billing_code_ALLOW_ErrorCount,le.orig_billing_code_LENGTHS_ErrorCount,le.orig_billing_code_WORDS_ErrorCount
          ,le.orig_transaction_id_LEFTTRIM_ErrorCount,le.orig_transaction_id_ALLOW_ErrorCount,le.orig_transaction_id_WORDS_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_ALLOW_ErrorCount,le.orig_company_id_WORDS_ErrorCount
          ,le.orig_reference_code_ALLOW_ErrorCount,le.orig_reference_code_WORDS_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_name_suffix_LEFTTRIM_ErrorCount,le.orig_name_suffix_ALLOW_ErrorCount,le.orig_name_suffix_LENGTHS_ErrorCount,le.orig_name_suffix_WORDS_ErrorCount
          ,le.orig_fname_2_LEFTTRIM_ErrorCount,le.orig_fname_2_ALLOW_ErrorCount,le.orig_fname_2_LENGTHS_ErrorCount,le.orig_fname_2_WORDS_ErrorCount
          ,le.orig_mname_2_LEFTTRIM_ErrorCount,le.orig_mname_2_ALLOW_ErrorCount,le.orig_mname_2_LENGTHS_ErrorCount,le.orig_mname_2_WORDS_ErrorCount
          ,le.orig_lname_2_LEFTTRIM_ErrorCount,le.orig_lname_2_ALLOW_ErrorCount,le.orig_lname_2_LENGTHS_ErrorCount,le.orig_lname_2_WORDS_ErrorCount
          ,le.orig_name_suffix_2_LEFTTRIM_ErrorCount,le.orig_name_suffix_2_ALLOW_ErrorCount,le.orig_name_suffix_2_LENGTHS_ErrorCount,le.orig_name_suffix_2_WORDS_ErrorCount
          ,le.orig_address_LEFTTRIM_ErrorCount,le.orig_address_ALLOW_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zip_LEFTTRIM_ErrorCount,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_WORDS_ErrorCount
          ,le.orig_address_2_LEFTTRIM_ErrorCount,le.orig_address_2_ALLOW_ErrorCount,le.orig_address_2_LENGTHS_ErrorCount,le.orig_address_2_WORDS_ErrorCount
          ,le.orig_city_2_LEFTTRIM_ErrorCount,le.orig_city_2_ALLOW_ErrorCount,le.orig_city_2_LENGTHS_ErrorCount,le.orig_city_2_WORDS_ErrorCount
          ,le.orig_state_2_LEFTTRIM_ErrorCount,le.orig_state_2_ALLOW_ErrorCount,le.orig_state_2_LENGTHS_ErrorCount,le.orig_state_2_WORDS_ErrorCount
          ,le.orig_zip_2_LEFTTRIM_ErrorCount,le.orig_zip_2_ALLOW_ErrorCount,le.orig_zip_2_LENGTHS_ErrorCount,le.orig_zip_2_WORDS_ErrorCount
          ,le.orig_zip4_2_LEFTTRIM_ErrorCount,le.orig_zip4_2_ALLOW_ErrorCount,le.orig_zip4_2_LENGTHS_ErrorCount,le.orig_zip4_2_WORDS_ErrorCount
          ,le.orig_clean_address_LEFTTRIM_ErrorCount,le.orig_clean_address_ALLOW_ErrorCount,le.orig_clean_address_LENGTHS_ErrorCount,le.orig_clean_address_WORDS_ErrorCount
          ,le.orig_clean_city_LEFTTRIM_ErrorCount,le.orig_clean_city_ALLOW_ErrorCount,le.orig_clean_city_LENGTHS_ErrorCount,le.orig_clean_city_WORDS_ErrorCount
          ,le.orig_clean_state_LEFTTRIM_ErrorCount,le.orig_clean_state_ALLOW_ErrorCount,le.orig_clean_state_LENGTHS_ErrorCount,le.orig_clean_state_WORDS_ErrorCount
          ,le.orig_clean_zip_LEFTTRIM_ErrorCount,le.orig_clean_zip_ALLOW_ErrorCount,le.orig_clean_zip_LENGTHS_ErrorCount,le.orig_clean_zip_WORDS_ErrorCount
          ,le.orig_clean_zip4_LEFTTRIM_ErrorCount,le.orig_clean_zip4_ALLOW_ErrorCount,le.orig_clean_zip4_LENGTHS_ErrorCount,le.orig_clean_zip4_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_homephone_LEFTTRIM_ErrorCount,le.orig_homephone_ALLOW_ErrorCount,le.orig_homephone_LENGTHS_ErrorCount,le.orig_homephone_WORDS_ErrorCount
          ,le.orig_homephone_2_LEFTTRIM_ErrorCount,le.orig_homephone_2_ALLOW_ErrorCount,le.orig_homephone_2_LENGTHS_ErrorCount,le.orig_homephone_2_WORDS_ErrorCount
          ,le.orig_workphone_LEFTTRIM_ErrorCount,le.orig_workphone_ALLOW_ErrorCount,le.orig_workphone_LENGTHS_ErrorCount,le.orig_workphone_WORDS_ErrorCount
          ,le.orig_workphone_2_LEFTTRIM_ErrorCount,le.orig_workphone_2_ALLOW_ErrorCount,le.orig_workphone_2_LENGTHS_ErrorCount,le.orig_workphone_2_WORDS_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_ssn_2_LEFTTRIM_ErrorCount,le.orig_ssn_2_ALLOW_ErrorCount,le.orig_ssn_2_LENGTHS_ErrorCount,le.orig_ssn_2_WORDS_ErrorCount
          ,le.orig_free_LEFTTRIM_ErrorCount,le.orig_free_ALLOW_ErrorCount,le.orig_free_LENGTHS_ErrorCount,le.orig_free_WORDS_ErrorCount
          ,le.orig_record_count_LEFTTRIM_ErrorCount,le.orig_record_count_ALLOW_ErrorCount,le.orig_record_count_LENGTHS_ErrorCount,le.orig_record_count_WORDS_ErrorCount
          ,le.orig_price_LEFTTRIM_ErrorCount,le.orig_price_WORDS_ErrorCount
          ,le.orig_revenue_LEFTTRIM_ErrorCount,le.orig_revenue_ALLOW_ErrorCount,le.orig_revenue_LENGTHS_ErrorCount,le.orig_revenue_WORDS_ErrorCount
          ,le.orig_full_name_LEFTTRIM_ErrorCount,le.orig_full_name_ALLOW_ErrorCount,le.orig_full_name_WORDS_ErrorCount
          ,le.orig_business_name_LEFTTRIM_ErrorCount,le.orig_business_name_ALLOW_ErrorCount,le.orig_business_name_LENGTHS_ErrorCount,le.orig_business_name_WORDS_ErrorCount
          ,le.orig_business_name_2_LEFTTRIM_ErrorCount,le.orig_business_name_2_ALLOW_ErrorCount,le.orig_business_name_2_LENGTHS_ErrorCount,le.orig_business_name_2_WORDS_ErrorCount
          ,le.orig_years_LEFTTRIM_ErrorCount,le.orig_years_ALLOW_ErrorCount,le.orig_years_LENGTHS_ErrorCount,le.orig_years_WORDS_ErrorCount
          ,le.orig_pricing_error_code_LEFTTRIM_ErrorCount,le.orig_pricing_error_code_ALLOW_ErrorCount,le.orig_pricing_error_code_LENGTHS_ErrorCount,le.orig_pricing_error_code_WORDS_ErrorCount
          ,le.orig_fcra_purpose_LEFTTRIM_ErrorCount,le.orig_fcra_purpose_ALLOW_ErrorCount,le.orig_fcra_purpose_LENGTHS_ErrorCount,le.orig_fcra_purpose_WORDS_ErrorCount
          ,le.orig_result_format_LEFTTRIM_ErrorCount,le.orig_result_format_ALLOW_ErrorCount,le.orig_result_format_LENGTHS_ErrorCount,le.orig_result_format_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_ALLOW_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_dob_2_LEFTTRIM_ErrorCount,le.orig_dob_2_ALLOW_ErrorCount,le.orig_dob_2_LENGTHS_ErrorCount,le.orig_dob_2_WORDS_ErrorCount
          ,le.orig_unique_id_LEFTTRIM_ErrorCount,le.orig_unique_id_ALLOW_ErrorCount,le.orig_unique_id_WORDS_ErrorCount
          ,le.orig_response_time_LEFTTRIM_ErrorCount,le.orig_response_time_ALLOW_ErrorCount,le.orig_response_time_LENGTHS_ErrorCount,le.orig_response_time_WORDS_ErrorCount
          ,le.orig_data_source_LEFTTRIM_ErrorCount,le.orig_data_source_ALLOW_ErrorCount,le.orig_data_source_LENGTHS_ErrorCount,le.orig_data_source_WORDS_ErrorCount
          ,le.orig_report_options_LEFTTRIM_ErrorCount,le.orig_report_options_ALLOW_ErrorCount,le.orig_report_options_WORDS_ErrorCount
          ,le.orig_end_user_name_LEFTTRIM_ErrorCount,le.orig_end_user_name_ALLOW_ErrorCount
          ,le.orig_end_user_address_1_LEFTTRIM_ErrorCount,le.orig_end_user_address_1_ALLOW_ErrorCount
          ,le.orig_end_user_address_2_LEFTTRIM_ErrorCount,le.orig_end_user_address_2_ALLOW_ErrorCount,le.orig_end_user_address_2_LENGTHS_ErrorCount,le.orig_end_user_address_2_WORDS_ErrorCount
          ,le.orig_end_user_city_LEFTTRIM_ErrorCount,le.orig_end_user_city_ALLOW_ErrorCount,le.orig_end_user_city_WORDS_ErrorCount
          ,le.orig_end_user_state_LEFTTRIM_ErrorCount,le.orig_end_user_state_ALLOW_ErrorCount,le.orig_end_user_state_LENGTHS_ErrorCount,le.orig_end_user_state_WORDS_ErrorCount
          ,le.orig_end_user_zip_LEFTTRIM_ErrorCount,le.orig_end_user_zip_ALLOW_ErrorCount,le.orig_end_user_zip_WORDS_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_ALLOW_ErrorCount,le.orig_login_history_id_LENGTHS_ErrorCount,le.orig_login_history_id_WORDS_ErrorCount
          ,le.orig_employment_state_LEFTTRIM_ErrorCount,le.orig_employment_state_ALLOW_ErrorCount,le.orig_employment_state_LENGTHS_ErrorCount,le.orig_employment_state_WORDS_ErrorCount
          ,le.orig_end_user_industry_class_LEFTTRIM_ErrorCount,le.orig_end_user_industry_class_ALLOW_ErrorCount,le.orig_end_user_industry_class_LENGTHS_ErrorCount,le.orig_end_user_industry_class_WORDS_ErrorCount
          ,le.orig_function_specific_data_LEFTTRIM_ErrorCount,le.orig_function_specific_data_ALLOW_ErrorCount,le.orig_function_specific_data_LENGTHS_ErrorCount,le.orig_function_specific_data_WORDS_ErrorCount
          ,le.orig_date_added_LEFTTRIM_ErrorCount,le.orig_date_added_ALLOW_ErrorCount,le.orig_date_added_LENGTHS_ErrorCount,le.orig_date_added_WORDS_ErrorCount
          ,le.orig_retail_price_LEFTTRIM_ErrorCount,le.orig_retail_price_WORDS_ErrorCount
          ,le.orig_country_code_LEFTTRIM_ErrorCount,le.orig_country_code_ALLOW_ErrorCount,le.orig_country_code_LENGTHS_ErrorCount,le.orig_country_code_WORDS_ErrorCount
          ,le.orig_email_LEFTTRIM_ErrorCount,le.orig_email_ALLOW_ErrorCount,le.orig_email_WORDS_ErrorCount
          ,le.orig_email_2_LEFTTRIM_ErrorCount,le.orig_email_2_ALLOW_ErrorCount,le.orig_email_2_LENGTHS_ErrorCount,le.orig_email_2_WORDS_ErrorCount
          ,le.orig_dl_number_LEFTTRIM_ErrorCount,le.orig_dl_number_ALLOW_ErrorCount,le.orig_dl_number_WORDS_ErrorCount
          ,le.orig_dl_number_2_LEFTTRIM_ErrorCount,le.orig_dl_number_2_ALLOW_ErrorCount,le.orig_dl_number_2_LENGTHS_ErrorCount,le.orig_dl_number_2_WORDS_ErrorCount
          ,le.orig_sub_id_LEFTTRIM_ErrorCount,le.orig_sub_id_ALLOW_ErrorCount,le.orig_sub_id_WORDS_ErrorCount
          ,le.orig_neighbors_LEFTTRIM_ErrorCount,le.orig_neighbors_ALLOW_ErrorCount,le.orig_neighbors_LENGTHS_ErrorCount,le.orig_neighbors_WORDS_ErrorCount
          ,le.orig_relatives_LEFTTRIM_ErrorCount,le.orig_relatives_ALLOW_ErrorCount,le.orig_relatives_LENGTHS_ErrorCount,le.orig_relatives_WORDS_ErrorCount
          ,le.orig_associates_LEFTTRIM_ErrorCount,le.orig_associates_ALLOW_ErrorCount,le.orig_associates_LENGTHS_ErrorCount,le.orig_associates_WORDS_ErrorCount
          ,le.orig_property_LEFTTRIM_ErrorCount,le.orig_property_ALLOW_ErrorCount,le.orig_property_LENGTHS_ErrorCount,le.orig_property_WORDS_ErrorCount
          ,le.orig_bankruptcy_LEFTTRIM_ErrorCount,le.orig_bankruptcy_ALLOW_ErrorCount,le.orig_bankruptcy_LENGTHS_ErrorCount,le.orig_bankruptcy_WORDS_ErrorCount
          ,le.orig_dls_LEFTTRIM_ErrorCount,le.orig_dls_ALLOW_ErrorCount,le.orig_dls_LENGTHS_ErrorCount,le.orig_dls_WORDS_ErrorCount
          ,le.orig_mvs_LEFTTRIM_ErrorCount,le.orig_mvs_ALLOW_ErrorCount,le.orig_mvs_LENGTHS_ErrorCount,le.orig_mvs_WORDS_ErrorCount
          ,le.orig_ip_address_LEFTTRIM_ErrorCount,le.orig_ip_address_WORDS_ErrorCount
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
          ,le.orig_login_id_ALLOW_ErrorCount,le.orig_login_id_WORDS_ErrorCount
          ,le.orig_billing_code_LEFTTRIM_ErrorCount,le.orig_billing_code_ALLOW_ErrorCount,le.orig_billing_code_LENGTHS_ErrorCount,le.orig_billing_code_WORDS_ErrorCount
          ,le.orig_transaction_id_LEFTTRIM_ErrorCount,le.orig_transaction_id_ALLOW_ErrorCount,le.orig_transaction_id_WORDS_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_ALLOW_ErrorCount,le.orig_company_id_WORDS_ErrorCount
          ,le.orig_reference_code_ALLOW_ErrorCount,le.orig_reference_code_WORDS_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_name_suffix_LEFTTRIM_ErrorCount,le.orig_name_suffix_ALLOW_ErrorCount,le.orig_name_suffix_LENGTHS_ErrorCount,le.orig_name_suffix_WORDS_ErrorCount
          ,le.orig_fname_2_LEFTTRIM_ErrorCount,le.orig_fname_2_ALLOW_ErrorCount,le.orig_fname_2_LENGTHS_ErrorCount,le.orig_fname_2_WORDS_ErrorCount
          ,le.orig_mname_2_LEFTTRIM_ErrorCount,le.orig_mname_2_ALLOW_ErrorCount,le.orig_mname_2_LENGTHS_ErrorCount,le.orig_mname_2_WORDS_ErrorCount
          ,le.orig_lname_2_LEFTTRIM_ErrorCount,le.orig_lname_2_ALLOW_ErrorCount,le.orig_lname_2_LENGTHS_ErrorCount,le.orig_lname_2_WORDS_ErrorCount
          ,le.orig_name_suffix_2_LEFTTRIM_ErrorCount,le.orig_name_suffix_2_ALLOW_ErrorCount,le.orig_name_suffix_2_LENGTHS_ErrorCount,le.orig_name_suffix_2_WORDS_ErrorCount
          ,le.orig_address_LEFTTRIM_ErrorCount,le.orig_address_ALLOW_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zip_LEFTTRIM_ErrorCount,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_WORDS_ErrorCount
          ,le.orig_address_2_LEFTTRIM_ErrorCount,le.orig_address_2_ALLOW_ErrorCount,le.orig_address_2_LENGTHS_ErrorCount,le.orig_address_2_WORDS_ErrorCount
          ,le.orig_city_2_LEFTTRIM_ErrorCount,le.orig_city_2_ALLOW_ErrorCount,le.orig_city_2_LENGTHS_ErrorCount,le.orig_city_2_WORDS_ErrorCount
          ,le.orig_state_2_LEFTTRIM_ErrorCount,le.orig_state_2_ALLOW_ErrorCount,le.orig_state_2_LENGTHS_ErrorCount,le.orig_state_2_WORDS_ErrorCount
          ,le.orig_zip_2_LEFTTRIM_ErrorCount,le.orig_zip_2_ALLOW_ErrorCount,le.orig_zip_2_LENGTHS_ErrorCount,le.orig_zip_2_WORDS_ErrorCount
          ,le.orig_zip4_2_LEFTTRIM_ErrorCount,le.orig_zip4_2_ALLOW_ErrorCount,le.orig_zip4_2_LENGTHS_ErrorCount,le.orig_zip4_2_WORDS_ErrorCount
          ,le.orig_clean_address_LEFTTRIM_ErrorCount,le.orig_clean_address_ALLOW_ErrorCount,le.orig_clean_address_LENGTHS_ErrorCount,le.orig_clean_address_WORDS_ErrorCount
          ,le.orig_clean_city_LEFTTRIM_ErrorCount,le.orig_clean_city_ALLOW_ErrorCount,le.orig_clean_city_LENGTHS_ErrorCount,le.orig_clean_city_WORDS_ErrorCount
          ,le.orig_clean_state_LEFTTRIM_ErrorCount,le.orig_clean_state_ALLOW_ErrorCount,le.orig_clean_state_LENGTHS_ErrorCount,le.orig_clean_state_WORDS_ErrorCount
          ,le.orig_clean_zip_LEFTTRIM_ErrorCount,le.orig_clean_zip_ALLOW_ErrorCount,le.orig_clean_zip_LENGTHS_ErrorCount,le.orig_clean_zip_WORDS_ErrorCount
          ,le.orig_clean_zip4_LEFTTRIM_ErrorCount,le.orig_clean_zip4_ALLOW_ErrorCount,le.orig_clean_zip4_LENGTHS_ErrorCount,le.orig_clean_zip4_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_homephone_LEFTTRIM_ErrorCount,le.orig_homephone_ALLOW_ErrorCount,le.orig_homephone_LENGTHS_ErrorCount,le.orig_homephone_WORDS_ErrorCount
          ,le.orig_homephone_2_LEFTTRIM_ErrorCount,le.orig_homephone_2_ALLOW_ErrorCount,le.orig_homephone_2_LENGTHS_ErrorCount,le.orig_homephone_2_WORDS_ErrorCount
          ,le.orig_workphone_LEFTTRIM_ErrorCount,le.orig_workphone_ALLOW_ErrorCount,le.orig_workphone_LENGTHS_ErrorCount,le.orig_workphone_WORDS_ErrorCount
          ,le.orig_workphone_2_LEFTTRIM_ErrorCount,le.orig_workphone_2_ALLOW_ErrorCount,le.orig_workphone_2_LENGTHS_ErrorCount,le.orig_workphone_2_WORDS_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_ssn_2_LEFTTRIM_ErrorCount,le.orig_ssn_2_ALLOW_ErrorCount,le.orig_ssn_2_LENGTHS_ErrorCount,le.orig_ssn_2_WORDS_ErrorCount
          ,le.orig_free_LEFTTRIM_ErrorCount,le.orig_free_ALLOW_ErrorCount,le.orig_free_LENGTHS_ErrorCount,le.orig_free_WORDS_ErrorCount
          ,le.orig_record_count_LEFTTRIM_ErrorCount,le.orig_record_count_ALLOW_ErrorCount,le.orig_record_count_LENGTHS_ErrorCount,le.orig_record_count_WORDS_ErrorCount
          ,le.orig_price_LEFTTRIM_ErrorCount,le.orig_price_WORDS_ErrorCount
          ,le.orig_revenue_LEFTTRIM_ErrorCount,le.orig_revenue_ALLOW_ErrorCount,le.orig_revenue_LENGTHS_ErrorCount,le.orig_revenue_WORDS_ErrorCount
          ,le.orig_full_name_LEFTTRIM_ErrorCount,le.orig_full_name_ALLOW_ErrorCount,le.orig_full_name_WORDS_ErrorCount
          ,le.orig_business_name_LEFTTRIM_ErrorCount,le.orig_business_name_ALLOW_ErrorCount,le.orig_business_name_LENGTHS_ErrorCount,le.orig_business_name_WORDS_ErrorCount
          ,le.orig_business_name_2_LEFTTRIM_ErrorCount,le.orig_business_name_2_ALLOW_ErrorCount,le.orig_business_name_2_LENGTHS_ErrorCount,le.orig_business_name_2_WORDS_ErrorCount
          ,le.orig_years_LEFTTRIM_ErrorCount,le.orig_years_ALLOW_ErrorCount,le.orig_years_LENGTHS_ErrorCount,le.orig_years_WORDS_ErrorCount
          ,le.orig_pricing_error_code_LEFTTRIM_ErrorCount,le.orig_pricing_error_code_ALLOW_ErrorCount,le.orig_pricing_error_code_LENGTHS_ErrorCount,le.orig_pricing_error_code_WORDS_ErrorCount
          ,le.orig_fcra_purpose_LEFTTRIM_ErrorCount,le.orig_fcra_purpose_ALLOW_ErrorCount,le.orig_fcra_purpose_LENGTHS_ErrorCount,le.orig_fcra_purpose_WORDS_ErrorCount
          ,le.orig_result_format_LEFTTRIM_ErrorCount,le.orig_result_format_ALLOW_ErrorCount,le.orig_result_format_LENGTHS_ErrorCount,le.orig_result_format_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_ALLOW_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_dob_2_LEFTTRIM_ErrorCount,le.orig_dob_2_ALLOW_ErrorCount,le.orig_dob_2_LENGTHS_ErrorCount,le.orig_dob_2_WORDS_ErrorCount
          ,le.orig_unique_id_LEFTTRIM_ErrorCount,le.orig_unique_id_ALLOW_ErrorCount,le.orig_unique_id_WORDS_ErrorCount
          ,le.orig_response_time_LEFTTRIM_ErrorCount,le.orig_response_time_ALLOW_ErrorCount,le.orig_response_time_LENGTHS_ErrorCount,le.orig_response_time_WORDS_ErrorCount
          ,le.orig_data_source_LEFTTRIM_ErrorCount,le.orig_data_source_ALLOW_ErrorCount,le.orig_data_source_LENGTHS_ErrorCount,le.orig_data_source_WORDS_ErrorCount
          ,le.orig_report_options_LEFTTRIM_ErrorCount,le.orig_report_options_ALLOW_ErrorCount,le.orig_report_options_WORDS_ErrorCount
          ,le.orig_end_user_name_LEFTTRIM_ErrorCount,le.orig_end_user_name_ALLOW_ErrorCount
          ,le.orig_end_user_address_1_LEFTTRIM_ErrorCount,le.orig_end_user_address_1_ALLOW_ErrorCount
          ,le.orig_end_user_address_2_LEFTTRIM_ErrorCount,le.orig_end_user_address_2_ALLOW_ErrorCount,le.orig_end_user_address_2_LENGTHS_ErrorCount,le.orig_end_user_address_2_WORDS_ErrorCount
          ,le.orig_end_user_city_LEFTTRIM_ErrorCount,le.orig_end_user_city_ALLOW_ErrorCount,le.orig_end_user_city_WORDS_ErrorCount
          ,le.orig_end_user_state_LEFTTRIM_ErrorCount,le.orig_end_user_state_ALLOW_ErrorCount,le.orig_end_user_state_LENGTHS_ErrorCount,le.orig_end_user_state_WORDS_ErrorCount
          ,le.orig_end_user_zip_LEFTTRIM_ErrorCount,le.orig_end_user_zip_ALLOW_ErrorCount,le.orig_end_user_zip_WORDS_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_ALLOW_ErrorCount,le.orig_login_history_id_LENGTHS_ErrorCount,le.orig_login_history_id_WORDS_ErrorCount
          ,le.orig_employment_state_LEFTTRIM_ErrorCount,le.orig_employment_state_ALLOW_ErrorCount,le.orig_employment_state_LENGTHS_ErrorCount,le.orig_employment_state_WORDS_ErrorCount
          ,le.orig_end_user_industry_class_LEFTTRIM_ErrorCount,le.orig_end_user_industry_class_ALLOW_ErrorCount,le.orig_end_user_industry_class_LENGTHS_ErrorCount,le.orig_end_user_industry_class_WORDS_ErrorCount
          ,le.orig_function_specific_data_LEFTTRIM_ErrorCount,le.orig_function_specific_data_ALLOW_ErrorCount,le.orig_function_specific_data_LENGTHS_ErrorCount,le.orig_function_specific_data_WORDS_ErrorCount
          ,le.orig_date_added_LEFTTRIM_ErrorCount,le.orig_date_added_ALLOW_ErrorCount,le.orig_date_added_LENGTHS_ErrorCount,le.orig_date_added_WORDS_ErrorCount
          ,le.orig_retail_price_LEFTTRIM_ErrorCount,le.orig_retail_price_WORDS_ErrorCount
          ,le.orig_country_code_LEFTTRIM_ErrorCount,le.orig_country_code_ALLOW_ErrorCount,le.orig_country_code_LENGTHS_ErrorCount,le.orig_country_code_WORDS_ErrorCount
          ,le.orig_email_LEFTTRIM_ErrorCount,le.orig_email_ALLOW_ErrorCount,le.orig_email_WORDS_ErrorCount
          ,le.orig_email_2_LEFTTRIM_ErrorCount,le.orig_email_2_ALLOW_ErrorCount,le.orig_email_2_LENGTHS_ErrorCount,le.orig_email_2_WORDS_ErrorCount
          ,le.orig_dl_number_LEFTTRIM_ErrorCount,le.orig_dl_number_ALLOW_ErrorCount,le.orig_dl_number_WORDS_ErrorCount
          ,le.orig_dl_number_2_LEFTTRIM_ErrorCount,le.orig_dl_number_2_ALLOW_ErrorCount,le.orig_dl_number_2_LENGTHS_ErrorCount,le.orig_dl_number_2_WORDS_ErrorCount
          ,le.orig_sub_id_LEFTTRIM_ErrorCount,le.orig_sub_id_ALLOW_ErrorCount,le.orig_sub_id_WORDS_ErrorCount
          ,le.orig_neighbors_LEFTTRIM_ErrorCount,le.orig_neighbors_ALLOW_ErrorCount,le.orig_neighbors_LENGTHS_ErrorCount,le.orig_neighbors_WORDS_ErrorCount
          ,le.orig_relatives_LEFTTRIM_ErrorCount,le.orig_relatives_ALLOW_ErrorCount,le.orig_relatives_LENGTHS_ErrorCount,le.orig_relatives_WORDS_ErrorCount
          ,le.orig_associates_LEFTTRIM_ErrorCount,le.orig_associates_ALLOW_ErrorCount,le.orig_associates_LENGTHS_ErrorCount,le.orig_associates_WORDS_ErrorCount
          ,le.orig_property_LEFTTRIM_ErrorCount,le.orig_property_ALLOW_ErrorCount,le.orig_property_LENGTHS_ErrorCount,le.orig_property_WORDS_ErrorCount
          ,le.orig_bankruptcy_LEFTTRIM_ErrorCount,le.orig_bankruptcy_ALLOW_ErrorCount,le.orig_bankruptcy_LENGTHS_ErrorCount,le.orig_bankruptcy_WORDS_ErrorCount
          ,le.orig_dls_LEFTTRIM_ErrorCount,le.orig_dls_ALLOW_ErrorCount,le.orig_dls_LENGTHS_ErrorCount,le.orig_dls_WORDS_ErrorCount
          ,le.orig_mvs_LEFTTRIM_ErrorCount,le.orig_mvs_ALLOW_ErrorCount,le.orig_mvs_LENGTHS_ErrorCount,le.orig_mvs_WORDS_ErrorCount
          ,le.orig_ip_address_LEFTTRIM_ErrorCount,le.orig_ip_address_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
          ,'orig_login_id:' + getFieldTypeText(h.orig_login_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_billing_code:' + getFieldTypeText(h.orig_billing_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_transaction_id:' + getFieldTypeText(h.orig_transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_function_name:' + getFieldTypeText(h.orig_function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_id:' + getFieldTypeText(h.orig_company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_reference_code:' + getFieldTypeText(h.orig_reference_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_suffix:' + getFieldTypeText(h.orig_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname_2:' + getFieldTypeText(h.orig_fname_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname_2:' + getFieldTypeText(h.orig_mname_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname_2:' + getFieldTypeText(h.orig_lname_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_suffix_2:' + getFieldTypeText(h.orig_name_suffix_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address_2:' + getFieldTypeText(h.orig_address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city_2:' + getFieldTypeText(h.orig_city_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state_2:' + getFieldTypeText(h.orig_state_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip_2:' + getFieldTypeText(h.orig_zip_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4_2:' + getFieldTypeText(h.orig_zip4_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_clean_address:' + getFieldTypeText(h.orig_clean_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_clean_city:' + getFieldTypeText(h.orig_clean_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_clean_state:' + getFieldTypeText(h.orig_clean_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_clean_zip:' + getFieldTypeText(h.orig_clean_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_clean_zip4:' + getFieldTypeText(h.orig_clean_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone:' + getFieldTypeText(h.orig_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_homephone:' + getFieldTypeText(h.orig_homephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_homephone_2:' + getFieldTypeText(h.orig_homephone_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_workphone:' + getFieldTypeText(h.orig_workphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_workphone_2:' + getFieldTypeText(h.orig_workphone_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn_2:' + getFieldTypeText(h.orig_ssn_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_free:' + getFieldTypeText(h.orig_free) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_record_count:' + getFieldTypeText(h.orig_record_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_price:' + getFieldTypeText(h.orig_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_revenue:' + getFieldTypeText(h.orig_revenue) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_full_name:' + getFieldTypeText(h.orig_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_business_name:' + getFieldTypeText(h.orig_business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_business_name_2:' + getFieldTypeText(h.orig_business_name_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_years:' + getFieldTypeText(h.orig_years) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pricing_error_code:' + getFieldTypeText(h.orig_pricing_error_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fcra_purpose:' + getFieldTypeText(h.orig_fcra_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_result_format:' + getFieldTypeText(h.orig_result_format) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob_2:' + getFieldTypeText(h.orig_dob_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unique_id:' + getFieldTypeText(h.orig_unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_response_time:' + getFieldTypeText(h.orig_response_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_data_source:' + getFieldTypeText(h.orig_data_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_report_options:' + getFieldTypeText(h.orig_report_options) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_name:' + getFieldTypeText(h.orig_end_user_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_address_1:' + getFieldTypeText(h.orig_end_user_address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_address_2:' + getFieldTypeText(h.orig_end_user_address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_city:' + getFieldTypeText(h.orig_end_user_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_state:' + getFieldTypeText(h.orig_end_user_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_zip:' + getFieldTypeText(h.orig_end_user_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_login_history_id:' + getFieldTypeText(h.orig_login_history_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_employment_state:' + getFieldTypeText(h.orig_employment_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_end_user_industry_class:' + getFieldTypeText(h.orig_end_user_industry_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_function_specific_data:' + getFieldTypeText(h.orig_function_specific_data) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_date_added:' + getFieldTypeText(h.orig_date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_retail_price:' + getFieldTypeText(h.orig_retail_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_country_code:' + getFieldTypeText(h.orig_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_email:' + getFieldTypeText(h.orig_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_email_2:' + getFieldTypeText(h.orig_email_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_number:' + getFieldTypeText(h.orig_dl_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_number_2:' + getFieldTypeText(h.orig_dl_number_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_sub_id:' + getFieldTypeText(h.orig_sub_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_neighbors:' + getFieldTypeText(h.orig_neighbors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_relatives:' + getFieldTypeText(h.orig_relatives) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_associates:' + getFieldTypeText(h.orig_associates) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_property:' + getFieldTypeText(h.orig_property) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_bankruptcy:' + getFieldTypeText(h.orig_bankruptcy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dls:' + getFieldTypeText(h.orig_dls) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mvs:' + getFieldTypeText(h.orig_mvs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ip_address:' + getFieldTypeText(h.orig_ip_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_login_id_cnt
          ,le.populated_orig_billing_code_cnt
          ,le.populated_orig_transaction_id_cnt
          ,le.populated_orig_function_name_cnt
          ,le.populated_orig_company_id_cnt
          ,le.populated_orig_reference_code_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_name_suffix_cnt
          ,le.populated_orig_fname_2_cnt
          ,le.populated_orig_mname_2_cnt
          ,le.populated_orig_lname_2_cnt
          ,le.populated_orig_name_suffix_2_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_address_2_cnt
          ,le.populated_orig_city_2_cnt
          ,le.populated_orig_state_2_cnt
          ,le.populated_orig_zip_2_cnt
          ,le.populated_orig_zip4_2_cnt
          ,le.populated_orig_clean_address_cnt
          ,le.populated_orig_clean_city_cnt
          ,le.populated_orig_clean_state_cnt
          ,le.populated_orig_clean_zip_cnt
          ,le.populated_orig_clean_zip4_cnt
          ,le.populated_orig_phone_cnt
          ,le.populated_orig_homephone_cnt
          ,le.populated_orig_homephone_2_cnt
          ,le.populated_orig_workphone_cnt
          ,le.populated_orig_workphone_2_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_ssn_2_cnt
          ,le.populated_orig_free_cnt
          ,le.populated_orig_record_count_cnt
          ,le.populated_orig_price_cnt
          ,le.populated_orig_revenue_cnt
          ,le.populated_orig_full_name_cnt
          ,le.populated_orig_business_name_cnt
          ,le.populated_orig_business_name_2_cnt
          ,le.populated_orig_years_cnt
          ,le.populated_orig_pricing_error_code_cnt
          ,le.populated_orig_fcra_purpose_cnt
          ,le.populated_orig_result_format_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_dob_2_cnt
          ,le.populated_orig_unique_id_cnt
          ,le.populated_orig_response_time_cnt
          ,le.populated_orig_data_source_cnt
          ,le.populated_orig_report_options_cnt
          ,le.populated_orig_end_user_name_cnt
          ,le.populated_orig_end_user_address_1_cnt
          ,le.populated_orig_end_user_address_2_cnt
          ,le.populated_orig_end_user_city_cnt
          ,le.populated_orig_end_user_state_cnt
          ,le.populated_orig_end_user_zip_cnt
          ,le.populated_orig_login_history_id_cnt
          ,le.populated_orig_employment_state_cnt
          ,le.populated_orig_end_user_industry_class_cnt
          ,le.populated_orig_function_specific_data_cnt
          ,le.populated_orig_date_added_cnt
          ,le.populated_orig_retail_price_cnt
          ,le.populated_orig_country_code_cnt
          ,le.populated_orig_email_cnt
          ,le.populated_orig_email_2_cnt
          ,le.populated_orig_dl_number_cnt
          ,le.populated_orig_dl_number_2_cnt
          ,le.populated_orig_sub_id_cnt
          ,le.populated_orig_neighbors_cnt
          ,le.populated_orig_relatives_cnt
          ,le.populated_orig_associates_cnt
          ,le.populated_orig_property_cnt
          ,le.populated_orig_bankruptcy_cnt
          ,le.populated_orig_dls_cnt
          ,le.populated_orig_mvs_cnt
          ,le.populated_orig_ip_address_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_login_id_pcnt
          ,le.populated_orig_billing_code_pcnt
          ,le.populated_orig_transaction_id_pcnt
          ,le.populated_orig_function_name_pcnt
          ,le.populated_orig_company_id_pcnt
          ,le.populated_orig_reference_code_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_name_suffix_pcnt
          ,le.populated_orig_fname_2_pcnt
          ,le.populated_orig_mname_2_pcnt
          ,le.populated_orig_lname_2_pcnt
          ,le.populated_orig_name_suffix_2_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_address_2_pcnt
          ,le.populated_orig_city_2_pcnt
          ,le.populated_orig_state_2_pcnt
          ,le.populated_orig_zip_2_pcnt
          ,le.populated_orig_zip4_2_pcnt
          ,le.populated_orig_clean_address_pcnt
          ,le.populated_orig_clean_city_pcnt
          ,le.populated_orig_clean_state_pcnt
          ,le.populated_orig_clean_zip_pcnt
          ,le.populated_orig_clean_zip4_pcnt
          ,le.populated_orig_phone_pcnt
          ,le.populated_orig_homephone_pcnt
          ,le.populated_orig_homephone_2_pcnt
          ,le.populated_orig_workphone_pcnt
          ,le.populated_orig_workphone_2_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_ssn_2_pcnt
          ,le.populated_orig_free_pcnt
          ,le.populated_orig_record_count_pcnt
          ,le.populated_orig_price_pcnt
          ,le.populated_orig_revenue_pcnt
          ,le.populated_orig_full_name_pcnt
          ,le.populated_orig_business_name_pcnt
          ,le.populated_orig_business_name_2_pcnt
          ,le.populated_orig_years_pcnt
          ,le.populated_orig_pricing_error_code_pcnt
          ,le.populated_orig_fcra_purpose_pcnt
          ,le.populated_orig_result_format_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_dob_2_pcnt
          ,le.populated_orig_unique_id_pcnt
          ,le.populated_orig_response_time_pcnt
          ,le.populated_orig_data_source_pcnt
          ,le.populated_orig_report_options_pcnt
          ,le.populated_orig_end_user_name_pcnt
          ,le.populated_orig_end_user_address_1_pcnt
          ,le.populated_orig_end_user_address_2_pcnt
          ,le.populated_orig_end_user_city_pcnt
          ,le.populated_orig_end_user_state_pcnt
          ,le.populated_orig_end_user_zip_pcnt
          ,le.populated_orig_login_history_id_pcnt
          ,le.populated_orig_employment_state_pcnt
          ,le.populated_orig_end_user_industry_class_pcnt
          ,le.populated_orig_function_specific_data_pcnt
          ,le.populated_orig_date_added_pcnt
          ,le.populated_orig_retail_price_pcnt
          ,le.populated_orig_country_code_pcnt
          ,le.populated_orig_email_pcnt
          ,le.populated_orig_email_2_pcnt
          ,le.populated_orig_dl_number_pcnt
          ,le.populated_orig_dl_number_2_pcnt
          ,le.populated_orig_sub_id_pcnt
          ,le.populated_orig_neighbors_pcnt
          ,le.populated_orig_relatives_pcnt
          ,le.populated_orig_associates_pcnt
          ,le.populated_orig_property_pcnt
          ,le.populated_orig_bankruptcy_pcnt
          ,le.populated_orig_dls_pcnt
          ,le.populated_orig_mvs_pcnt
          ,le.populated_orig_ip_address_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,79,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),79,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
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
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inql_fcra_Riskwise, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
