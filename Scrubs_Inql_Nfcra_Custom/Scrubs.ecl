IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 153;
  EXPORT NumRulesFromFieldType := 153;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 49;
  EXPORT NumFieldsWithPossibleEdits := 49;
  EXPORT NumRulesWithPossibleEdits := 153;
  EXPORT Expanded_Layout := RECORD(Layout_FILE)
    UNSIGNED1 orig_end_user_id_Invalid;
    BOOLEAN orig_end_user_id_wouldClean;
    UNSIGNED1 orig_loginid_Invalid;
    BOOLEAN orig_loginid_wouldClean;
    UNSIGNED1 orig_billing_code_Invalid;
    BOOLEAN orig_billing_code_wouldClean;
    UNSIGNED1 orig_transaction_id_Invalid;
    BOOLEAN orig_transaction_id_wouldClean;
    UNSIGNED1 orig_transaction_type_Invalid;
    BOOLEAN orig_transaction_type_wouldClean;
    UNSIGNED1 orig_neighbors_Invalid;
    BOOLEAN orig_neighbors_wouldClean;
    UNSIGNED1 orig_relatives_Invalid;
    BOOLEAN orig_relatives_wouldClean;
    UNSIGNED1 orig_associates_Invalid;
    BOOLEAN orig_associates_wouldClean;
    UNSIGNED1 orig_property_Invalid;
    BOOLEAN orig_property_wouldClean;
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
    UNSIGNED1 orig_phone_Invalid;
    BOOLEAN orig_phone_wouldClean;
    UNSIGNED1 orig_ssn_Invalid;
    BOOLEAN orig_ssn_wouldClean;
    UNSIGNED1 orig_free_Invalid;
    BOOLEAN orig_free_wouldClean;
    UNSIGNED1 orig_record_count_Invalid;
    BOOLEAN orig_record_count_wouldClean;
    UNSIGNED1 orig_price_Invalid;
    BOOLEAN orig_price_wouldClean;
    UNSIGNED1 orig_bankruptcy_Invalid;
    BOOLEAN orig_bankruptcy_wouldClean;
    UNSIGNED1 orig_transaction_code_Invalid;
    BOOLEAN orig_transaction_code_wouldClean;
    UNSIGNED1 orig_dateadded_Invalid;
    BOOLEAN orig_dateadded_wouldClean;
    UNSIGNED1 orig_full_name_Invalid;
    BOOLEAN orig_full_name_wouldClean;
    UNSIGNED1 orig_billingdate_Invalid;
    BOOLEAN orig_billingdate_wouldClean;
    UNSIGNED1 orig_business_name_Invalid;
    BOOLEAN orig_business_name_wouldClean;
    UNSIGNED1 orig_pricing_error_code_Invalid;
    BOOLEAN orig_pricing_error_code_wouldClean;
    UNSIGNED1 orig_dl_purpose_Invalid;
    BOOLEAN orig_dl_purpose_wouldClean;
    UNSIGNED1 orig_result_format_Invalid;
    BOOLEAN orig_result_format_wouldClean;
    UNSIGNED1 orig_dob_Invalid;
    BOOLEAN orig_dob_wouldClean;
    UNSIGNED1 orig_unique_id_Invalid;
    BOOLEAN orig_unique_id_wouldClean;
    UNSIGNED1 orig_dls_Invalid;
    BOOLEAN orig_dls_wouldClean;
    UNSIGNED1 orig_mvs_Invalid;
    BOOLEAN orig_mvs_wouldClean;
    UNSIGNED1 orig_function_name_Invalid;
    BOOLEAN orig_function_name_wouldClean;
    UNSIGNED1 orig_response_time_Invalid;
    BOOLEAN orig_response_time_wouldClean;
    UNSIGNED1 orig_data_source_Invalid;
    BOOLEAN orig_data_source_wouldClean;
    UNSIGNED1 orig_glb_purpose_Invalid;
    BOOLEAN orig_glb_purpose_wouldClean;
    UNSIGNED1 orig_report_options_Invalid;
    BOOLEAN orig_report_options_wouldClean;
    UNSIGNED1 orig_unused_Invalid;
    BOOLEAN orig_unused_wouldClean;
    UNSIGNED1 orig_login_history_id_Invalid;
    BOOLEAN orig_login_history_id_wouldClean;
    UNSIGNED1 orig_aseid_Invalid;
    BOOLEAN orig_aseid_wouldClean;
    UNSIGNED1 orig_years_Invalid;
    BOOLEAN orig_years_wouldClean;
    UNSIGNED1 orig_ip_address_Invalid;
    BOOLEAN orig_ip_address_wouldClean;
    UNSIGNED1 orig_source_code_Invalid;
    BOOLEAN orig_source_code_wouldClean;
    UNSIGNED1 orig_retail_price_Invalid;
    BOOLEAN orig_retail_price_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_FILE)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_FILE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_end_user_id_Invalid := Fields.InValid_orig_end_user_id((SALT39.StrType)le.orig_end_user_id);
    clean_orig_end_user_id := (TYPEOF(le.orig_end_user_id))Fields.Make_orig_end_user_id((SALT39.StrType)le.orig_end_user_id);
    clean_orig_end_user_id_Invalid := Fields.InValid_orig_end_user_id((SALT39.StrType)clean_orig_end_user_id);
    SELF.orig_end_user_id := IF(withOnfail, clean_orig_end_user_id, le.orig_end_user_id); // ONFAIL(CLEAN)
    SELF.orig_end_user_id_wouldClean := TRIM((SALT39.StrType)le.orig_end_user_id) <> TRIM((SALT39.StrType)clean_orig_end_user_id);
    SELF.orig_loginid_Invalid := Fields.InValid_orig_loginid((SALT39.StrType)le.orig_loginid);
    clean_orig_loginid := (TYPEOF(le.orig_loginid))Fields.Make_orig_loginid((SALT39.StrType)le.orig_loginid);
    clean_orig_loginid_Invalid := Fields.InValid_orig_loginid((SALT39.StrType)clean_orig_loginid);
    SELF.orig_loginid := IF(withOnfail, clean_orig_loginid, le.orig_loginid); // ONFAIL(CLEAN)
    SELF.orig_loginid_wouldClean := TRIM((SALT39.StrType)le.orig_loginid) <> TRIM((SALT39.StrType)clean_orig_loginid);
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
    SELF.orig_transaction_type_Invalid := Fields.InValid_orig_transaction_type((SALT39.StrType)le.orig_transaction_type);
    clean_orig_transaction_type := (TYPEOF(le.orig_transaction_type))Fields.Make_orig_transaction_type((SALT39.StrType)le.orig_transaction_type);
    clean_orig_transaction_type_Invalid := Fields.InValid_orig_transaction_type((SALT39.StrType)clean_orig_transaction_type);
    SELF.orig_transaction_type := IF(withOnfail, clean_orig_transaction_type, le.orig_transaction_type); // ONFAIL(CLEAN)
    SELF.orig_transaction_type_wouldClean := TRIM((SALT39.StrType)le.orig_transaction_type) <> TRIM((SALT39.StrType)clean_orig_transaction_type);
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
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone := (TYPEOF(le.orig_phone))Fields.Make_orig_phone((SALT39.StrType)le.orig_phone);
    clean_orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)clean_orig_phone);
    SELF.orig_phone := IF(withOnfail, clean_orig_phone, le.orig_phone); // ONFAIL(CLEAN)
    SELF.orig_phone_wouldClean := TRIM((SALT39.StrType)le.orig_phone) <> TRIM((SALT39.StrType)clean_orig_phone);
    SELF.orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn := (TYPEOF(le.orig_ssn))Fields.Make_orig_ssn((SALT39.StrType)le.orig_ssn);
    clean_orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)clean_orig_ssn);
    SELF.orig_ssn := IF(withOnfail, clean_orig_ssn, le.orig_ssn); // ONFAIL(CLEAN)
    SELF.orig_ssn_wouldClean := TRIM((SALT39.StrType)le.orig_ssn) <> TRIM((SALT39.StrType)clean_orig_ssn);
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
    SELF.orig_bankruptcy_Invalid := Fields.InValid_orig_bankruptcy((SALT39.StrType)le.orig_bankruptcy);
    clean_orig_bankruptcy := (TYPEOF(le.orig_bankruptcy))Fields.Make_orig_bankruptcy((SALT39.StrType)le.orig_bankruptcy);
    clean_orig_bankruptcy_Invalid := Fields.InValid_orig_bankruptcy((SALT39.StrType)clean_orig_bankruptcy);
    SELF.orig_bankruptcy := IF(withOnfail, clean_orig_bankruptcy, le.orig_bankruptcy); // ONFAIL(CLEAN)
    SELF.orig_bankruptcy_wouldClean := TRIM((SALT39.StrType)le.orig_bankruptcy) <> TRIM((SALT39.StrType)clean_orig_bankruptcy);
    SELF.orig_transaction_code_Invalid := Fields.InValid_orig_transaction_code((SALT39.StrType)le.orig_transaction_code);
    clean_orig_transaction_code := (TYPEOF(le.orig_transaction_code))Fields.Make_orig_transaction_code((SALT39.StrType)le.orig_transaction_code);
    clean_orig_transaction_code_Invalid := Fields.InValid_orig_transaction_code((SALT39.StrType)clean_orig_transaction_code);
    SELF.orig_transaction_code := IF(withOnfail, clean_orig_transaction_code, le.orig_transaction_code); // ONFAIL(CLEAN)
    SELF.orig_transaction_code_wouldClean := TRIM((SALT39.StrType)le.orig_transaction_code) <> TRIM((SALT39.StrType)clean_orig_transaction_code);
    SELF.orig_dateadded_Invalid := Fields.InValid_orig_dateadded((SALT39.StrType)le.orig_dateadded);
    clean_orig_dateadded := (TYPEOF(le.orig_dateadded))Fields.Make_orig_dateadded((SALT39.StrType)le.orig_dateadded);
    clean_orig_dateadded_Invalid := Fields.InValid_orig_dateadded((SALT39.StrType)clean_orig_dateadded);
    SELF.orig_dateadded := IF(withOnfail, clean_orig_dateadded, le.orig_dateadded); // ONFAIL(CLEAN)
    SELF.orig_dateadded_wouldClean := TRIM((SALT39.StrType)le.orig_dateadded) <> TRIM((SALT39.StrType)clean_orig_dateadded);
    SELF.orig_full_name_Invalid := Fields.InValid_orig_full_name((SALT39.StrType)le.orig_full_name);
    clean_orig_full_name := (TYPEOF(le.orig_full_name))Fields.Make_orig_full_name((SALT39.StrType)le.orig_full_name);
    clean_orig_full_name_Invalid := Fields.InValid_orig_full_name((SALT39.StrType)clean_orig_full_name);
    SELF.orig_full_name := IF(withOnfail, clean_orig_full_name, le.orig_full_name); // ONFAIL(CLEAN)
    SELF.orig_full_name_wouldClean := TRIM((SALT39.StrType)le.orig_full_name) <> TRIM((SALT39.StrType)clean_orig_full_name);
    SELF.orig_billingdate_Invalid := Fields.InValid_orig_billingdate((SALT39.StrType)le.orig_billingdate);
    clean_orig_billingdate := (TYPEOF(le.orig_billingdate))Fields.Make_orig_billingdate((SALT39.StrType)le.orig_billingdate);
    clean_orig_billingdate_Invalid := Fields.InValid_orig_billingdate((SALT39.StrType)clean_orig_billingdate);
    SELF.orig_billingdate := IF(withOnfail, clean_orig_billingdate, le.orig_billingdate); // ONFAIL(CLEAN)
    SELF.orig_billingdate_wouldClean := TRIM((SALT39.StrType)le.orig_billingdate) <> TRIM((SALT39.StrType)clean_orig_billingdate);
    SELF.orig_business_name_Invalid := Fields.InValid_orig_business_name((SALT39.StrType)le.orig_business_name);
    clean_orig_business_name := (TYPEOF(le.orig_business_name))Fields.Make_orig_business_name((SALT39.StrType)le.orig_business_name);
    clean_orig_business_name_Invalid := Fields.InValid_orig_business_name((SALT39.StrType)clean_orig_business_name);
    SELF.orig_business_name := IF(withOnfail, clean_orig_business_name, le.orig_business_name); // ONFAIL(CLEAN)
    SELF.orig_business_name_wouldClean := TRIM((SALT39.StrType)le.orig_business_name) <> TRIM((SALT39.StrType)clean_orig_business_name);
    SELF.orig_pricing_error_code_Invalid := Fields.InValid_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code);
    clean_orig_pricing_error_code := (TYPEOF(le.orig_pricing_error_code))Fields.Make_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code);
    clean_orig_pricing_error_code_Invalid := Fields.InValid_orig_pricing_error_code((SALT39.StrType)clean_orig_pricing_error_code);
    SELF.orig_pricing_error_code := IF(withOnfail, clean_orig_pricing_error_code, le.orig_pricing_error_code); // ONFAIL(CLEAN)
    SELF.orig_pricing_error_code_wouldClean := TRIM((SALT39.StrType)le.orig_pricing_error_code) <> TRIM((SALT39.StrType)clean_orig_pricing_error_code);
    SELF.orig_dl_purpose_Invalid := Fields.InValid_orig_dl_purpose((SALT39.StrType)le.orig_dl_purpose);
    clean_orig_dl_purpose := (TYPEOF(le.orig_dl_purpose))Fields.Make_orig_dl_purpose((SALT39.StrType)le.orig_dl_purpose);
    clean_orig_dl_purpose_Invalid := Fields.InValid_orig_dl_purpose((SALT39.StrType)clean_orig_dl_purpose);
    SELF.orig_dl_purpose := IF(withOnfail, clean_orig_dl_purpose, le.orig_dl_purpose); // ONFAIL(CLEAN)
    SELF.orig_dl_purpose_wouldClean := TRIM((SALT39.StrType)le.orig_dl_purpose) <> TRIM((SALT39.StrType)clean_orig_dl_purpose);
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
    SELF.orig_unique_id_Invalid := Fields.InValid_orig_unique_id((SALT39.StrType)le.orig_unique_id);
    clean_orig_unique_id := (TYPEOF(le.orig_unique_id))Fields.Make_orig_unique_id((SALT39.StrType)le.orig_unique_id);
    clean_orig_unique_id_Invalid := Fields.InValid_orig_unique_id((SALT39.StrType)clean_orig_unique_id);
    SELF.orig_unique_id := IF(withOnfail, clean_orig_unique_id, le.orig_unique_id); // ONFAIL(CLEAN)
    SELF.orig_unique_id_wouldClean := TRIM((SALT39.StrType)le.orig_unique_id) <> TRIM((SALT39.StrType)clean_orig_unique_id);
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
    SELF.orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name := (TYPEOF(le.orig_function_name))Fields.Make_orig_function_name((SALT39.StrType)le.orig_function_name);
    clean_orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)clean_orig_function_name);
    SELF.orig_function_name := IF(withOnfail, clean_orig_function_name, le.orig_function_name); // ONFAIL(CLEAN)
    SELF.orig_function_name_wouldClean := TRIM((SALT39.StrType)le.orig_function_name) <> TRIM((SALT39.StrType)clean_orig_function_name);
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
    SELF.orig_glb_purpose_Invalid := Fields.InValid_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose);
    clean_orig_glb_purpose := (TYPEOF(le.orig_glb_purpose))Fields.Make_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose);
    clean_orig_glb_purpose_Invalid := Fields.InValid_orig_glb_purpose((SALT39.StrType)clean_orig_glb_purpose);
    SELF.orig_glb_purpose := IF(withOnfail, clean_orig_glb_purpose, le.orig_glb_purpose); // ONFAIL(CLEAN)
    SELF.orig_glb_purpose_wouldClean := TRIM((SALT39.StrType)le.orig_glb_purpose) <> TRIM((SALT39.StrType)clean_orig_glb_purpose);
    SELF.orig_report_options_Invalid := Fields.InValid_orig_report_options((SALT39.StrType)le.orig_report_options);
    clean_orig_report_options := (TYPEOF(le.orig_report_options))Fields.Make_orig_report_options((SALT39.StrType)le.orig_report_options);
    clean_orig_report_options_Invalid := Fields.InValid_orig_report_options((SALT39.StrType)clean_orig_report_options);
    SELF.orig_report_options := IF(withOnfail, clean_orig_report_options, le.orig_report_options); // ONFAIL(CLEAN)
    SELF.orig_report_options_wouldClean := TRIM((SALT39.StrType)le.orig_report_options) <> TRIM((SALT39.StrType)clean_orig_report_options);
    SELF.orig_unused_Invalid := Fields.InValid_orig_unused((SALT39.StrType)le.orig_unused);
    clean_orig_unused := (TYPEOF(le.orig_unused))Fields.Make_orig_unused((SALT39.StrType)le.orig_unused);
    clean_orig_unused_Invalid := Fields.InValid_orig_unused((SALT39.StrType)clean_orig_unused);
    SELF.orig_unused := IF(withOnfail, clean_orig_unused, le.orig_unused); // ONFAIL(CLEAN)
    SELF.orig_unused_wouldClean := TRIM((SALT39.StrType)le.orig_unused) <> TRIM((SALT39.StrType)clean_orig_unused);
    SELF.orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    clean_orig_login_history_id := (TYPEOF(le.orig_login_history_id))Fields.Make_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    clean_orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)clean_orig_login_history_id);
    SELF.orig_login_history_id := IF(withOnfail, clean_orig_login_history_id, le.orig_login_history_id); // ONFAIL(CLEAN)
    SELF.orig_login_history_id_wouldClean := TRIM((SALT39.StrType)le.orig_login_history_id) <> TRIM((SALT39.StrType)clean_orig_login_history_id);
    SELF.orig_aseid_Invalid := Fields.InValid_orig_aseid((SALT39.StrType)le.orig_aseid);
    clean_orig_aseid := (TYPEOF(le.orig_aseid))Fields.Make_orig_aseid((SALT39.StrType)le.orig_aseid);
    clean_orig_aseid_Invalid := Fields.InValid_orig_aseid((SALT39.StrType)clean_orig_aseid);
    SELF.orig_aseid := IF(withOnfail, clean_orig_aseid, le.orig_aseid); // ONFAIL(CLEAN)
    SELF.orig_aseid_wouldClean := TRIM((SALT39.StrType)le.orig_aseid) <> TRIM((SALT39.StrType)clean_orig_aseid);
    SELF.orig_years_Invalid := Fields.InValid_orig_years((SALT39.StrType)le.orig_years);
    clean_orig_years := (TYPEOF(le.orig_years))Fields.Make_orig_years((SALT39.StrType)le.orig_years);
    clean_orig_years_Invalid := Fields.InValid_orig_years((SALT39.StrType)clean_orig_years);
    SELF.orig_years := IF(withOnfail, clean_orig_years, le.orig_years); // ONFAIL(CLEAN)
    SELF.orig_years_wouldClean := TRIM((SALT39.StrType)le.orig_years) <> TRIM((SALT39.StrType)clean_orig_years);
    SELF.orig_ip_address_Invalid := Fields.InValid_orig_ip_address((SALT39.StrType)le.orig_ip_address);
    clean_orig_ip_address := (TYPEOF(le.orig_ip_address))Fields.Make_orig_ip_address((SALT39.StrType)le.orig_ip_address);
    clean_orig_ip_address_Invalid := Fields.InValid_orig_ip_address((SALT39.StrType)clean_orig_ip_address);
    SELF.orig_ip_address := IF(withOnfail, clean_orig_ip_address, le.orig_ip_address); // ONFAIL(CLEAN)
    SELF.orig_ip_address_wouldClean := TRIM((SALT39.StrType)le.orig_ip_address) <> TRIM((SALT39.StrType)clean_orig_ip_address);
    SELF.orig_source_code_Invalid := Fields.InValid_orig_source_code((SALT39.StrType)le.orig_source_code);
    clean_orig_source_code := (TYPEOF(le.orig_source_code))Fields.Make_orig_source_code((SALT39.StrType)le.orig_source_code);
    clean_orig_source_code_Invalid := Fields.InValid_orig_source_code((SALT39.StrType)clean_orig_source_code);
    SELF.orig_source_code := IF(withOnfail, clean_orig_source_code, le.orig_source_code); // ONFAIL(CLEAN)
    SELF.orig_source_code_wouldClean := TRIM((SALT39.StrType)le.orig_source_code) <> TRIM((SALT39.StrType)clean_orig_source_code);
    SELF.orig_retail_price_Invalid := Fields.InValid_orig_retail_price((SALT39.StrType)le.orig_retail_price);
    clean_orig_retail_price := (TYPEOF(le.orig_retail_price))Fields.Make_orig_retail_price((SALT39.StrType)le.orig_retail_price);
    clean_orig_retail_price_Invalid := Fields.InValid_orig_retail_price((SALT39.StrType)clean_orig_retail_price);
    SELF.orig_retail_price := IF(withOnfail, clean_orig_retail_price, le.orig_retail_price); // ONFAIL(CLEAN)
    SELF.orig_retail_price_wouldClean := TRIM((SALT39.StrType)le.orig_retail_price) <> TRIM((SALT39.StrType)clean_orig_retail_price);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_FILE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_end_user_id_Invalid << 0 ) + ( le.orig_loginid_Invalid << 1 ) + ( le.orig_billing_code_Invalid << 3 ) + ( le.orig_transaction_id_Invalid << 5 ) + ( le.orig_transaction_type_Invalid << 7 ) + ( le.orig_neighbors_Invalid << 10 ) + ( le.orig_relatives_Invalid << 13 ) + ( le.orig_associates_Invalid << 16 ) + ( le.orig_property_Invalid << 19 ) + ( le.orig_company_id_Invalid << 22 ) + ( le.orig_reference_code_Invalid << 25 ) + ( le.orig_fname_Invalid << 26 ) + ( le.orig_mname_Invalid << 28 ) + ( le.orig_lname_Invalid << 30 ) + ( le.orig_address_Invalid << 32 ) + ( le.orig_city_Invalid << 33 ) + ( le.orig_state_Invalid << 35 ) + ( le.orig_zip_Invalid << 37 ) + ( le.orig_zip4_Invalid << 39 ) + ( le.orig_phone_Invalid << 41 ) + ( le.orig_ssn_Invalid << 44 ) + ( le.orig_free_Invalid << 47 ) + ( le.orig_record_count_Invalid << 50 ) + ( le.orig_price_Invalid << 52 ) + ( le.orig_bankruptcy_Invalid << 54 ) + ( le.orig_transaction_code_Invalid << 57 ) + ( le.orig_dateadded_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.orig_full_name_Invalid << 0 ) + ( le.orig_billingdate_Invalid << 2 ) + ( le.orig_business_name_Invalid << 5 ) + ( le.orig_pricing_error_code_Invalid << 7 ) + ( le.orig_dl_purpose_Invalid << 10 ) + ( le.orig_result_format_Invalid << 13 ) + ( le.orig_dob_Invalid << 16 ) + ( le.orig_unique_id_Invalid << 19 ) + ( le.orig_dls_Invalid << 21 ) + ( le.orig_mvs_Invalid << 24 ) + ( le.orig_function_name_Invalid << 27 ) + ( le.orig_response_time_Invalid << 29 ) + ( le.orig_data_source_Invalid << 31 ) + ( le.orig_glb_purpose_Invalid << 34 ) + ( le.orig_report_options_Invalid << 37 ) + ( le.orig_unused_Invalid << 39 ) + ( le.orig_login_history_id_Invalid << 42 ) + ( le.orig_aseid_Invalid << 45 ) + ( le.orig_years_Invalid << 48 ) + ( le.orig_ip_address_Invalid << 51 ) + ( le.orig_source_code_Invalid << 53 ) + ( le.orig_retail_price_Invalid << 56 );
    SELF.ScrubsCleanBits1 := ( IF(le.orig_end_user_id_wouldClean, 1, 0) << 0 ) + ( IF(le.orig_loginid_wouldClean, 1, 0) << 1 ) + ( IF(le.orig_billing_code_wouldClean, 1, 0) << 2 ) + ( IF(le.orig_transaction_id_wouldClean, 1, 0) << 3 ) + ( IF(le.orig_transaction_type_wouldClean, 1, 0) << 4 ) + ( IF(le.orig_neighbors_wouldClean, 1, 0) << 5 ) + ( IF(le.orig_relatives_wouldClean, 1, 0) << 6 ) + ( IF(le.orig_associates_wouldClean, 1, 0) << 7 ) + ( IF(le.orig_property_wouldClean, 1, 0) << 8 ) + ( IF(le.orig_company_id_wouldClean, 1, 0) << 9 ) + ( IF(le.orig_reference_code_wouldClean, 1, 0) << 10 ) + ( IF(le.orig_fname_wouldClean, 1, 0) << 11 ) + ( IF(le.orig_mname_wouldClean, 1, 0) << 12 ) + ( IF(le.orig_lname_wouldClean, 1, 0) << 13 ) + ( IF(le.orig_address_wouldClean, 1, 0) << 14 ) + ( IF(le.orig_city_wouldClean, 1, 0) << 15 ) + ( IF(le.orig_state_wouldClean, 1, 0) << 16 ) + ( IF(le.orig_zip_wouldClean, 1, 0) << 17 ) + ( IF(le.orig_zip4_wouldClean, 1, 0) << 18 ) + ( IF(le.orig_phone_wouldClean, 1, 0) << 19 ) + ( IF(le.orig_ssn_wouldClean, 1, 0) << 20 ) + ( IF(le.orig_free_wouldClean, 1, 0) << 21 ) + ( IF(le.orig_record_count_wouldClean, 1, 0) << 22 ) + ( IF(le.orig_price_wouldClean, 1, 0) << 23 ) + ( IF(le.orig_bankruptcy_wouldClean, 1, 0) << 24 ) + ( IF(le.orig_transaction_code_wouldClean, 1, 0) << 25 ) + ( IF(le.orig_dateadded_wouldClean, 1, 0) << 26 ) + ( IF(le.orig_full_name_wouldClean, 1, 0) << 27 ) + ( IF(le.orig_billingdate_wouldClean, 1, 0) << 28 ) + ( IF(le.orig_business_name_wouldClean, 1, 0) << 29 ) + ( IF(le.orig_pricing_error_code_wouldClean, 1, 0) << 30 ) + ( IF(le.orig_dl_purpose_wouldClean, 1, 0) << 31 ) + ( IF(le.orig_result_format_wouldClean, 1, 0) << 32 ) + ( IF(le.orig_dob_wouldClean, 1, 0) << 33 ) + ( IF(le.orig_unique_id_wouldClean, 1, 0) << 34 ) + ( IF(le.orig_dls_wouldClean, 1, 0) << 35 ) + ( IF(le.orig_mvs_wouldClean, 1, 0) << 36 ) + ( IF(le.orig_function_name_wouldClean, 1, 0) << 37 ) + ( IF(le.orig_response_time_wouldClean, 1, 0) << 38 ) + ( IF(le.orig_data_source_wouldClean, 1, 0) << 39 ) + ( IF(le.orig_glb_purpose_wouldClean, 1, 0) << 40 ) + ( IF(le.orig_report_options_wouldClean, 1, 0) << 41 ) + ( IF(le.orig_unused_wouldClean, 1, 0) << 42 ) + ( IF(le.orig_login_history_id_wouldClean, 1, 0) << 43 ) + ( IF(le.orig_aseid_wouldClean, 1, 0) << 44 ) + ( IF(le.orig_years_wouldClean, 1, 0) << 45 ) + ( IF(le.orig_ip_address_wouldClean, 1, 0) << 46 ) + ( IF(le.orig_source_code_wouldClean, 1, 0) << 47 ) + ( IF(le.orig_retail_price_wouldClean, 1, 0) << 48 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_FILE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_end_user_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_loginid_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.orig_billing_code_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.orig_transaction_id_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.orig_transaction_type_Invalid := (le.ScrubsBits1 >> 7) & 7;
    SELF.orig_neighbors_Invalid := (le.ScrubsBits1 >> 10) & 7;
    SELF.orig_relatives_Invalid := (le.ScrubsBits1 >> 13) & 7;
    SELF.orig_associates_Invalid := (le.ScrubsBits1 >> 16) & 7;
    SELF.orig_property_Invalid := (le.ScrubsBits1 >> 19) & 7;
    SELF.orig_company_id_Invalid := (le.ScrubsBits1 >> 22) & 7;
    SELF.orig_reference_code_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.orig_address_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.orig_phone_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.orig_ssn_Invalid := (le.ScrubsBits1 >> 44) & 7;
    SELF.orig_free_Invalid := (le.ScrubsBits1 >> 47) & 7;
    SELF.orig_record_count_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.orig_price_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.orig_bankruptcy_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.orig_transaction_code_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.orig_dateadded_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.orig_full_name_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.orig_billingdate_Invalid := (le.ScrubsBits2 >> 2) & 7;
    SELF.orig_business_name_Invalid := (le.ScrubsBits2 >> 5) & 3;
    SELF.orig_pricing_error_code_Invalid := (le.ScrubsBits2 >> 7) & 7;
    SELF.orig_dl_purpose_Invalid := (le.ScrubsBits2 >> 10) & 7;
    SELF.orig_result_format_Invalid := (le.ScrubsBits2 >> 13) & 7;
    SELF.orig_dob_Invalid := (le.ScrubsBits2 >> 16) & 7;
    SELF.orig_unique_id_Invalid := (le.ScrubsBits2 >> 19) & 3;
    SELF.orig_dls_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.orig_mvs_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.orig_function_name_Invalid := (le.ScrubsBits2 >> 27) & 3;
    SELF.orig_response_time_Invalid := (le.ScrubsBits2 >> 29) & 3;
    SELF.orig_data_source_Invalid := (le.ScrubsBits2 >> 31) & 7;
    SELF.orig_glb_purpose_Invalid := (le.ScrubsBits2 >> 34) & 7;
    SELF.orig_report_options_Invalid := (le.ScrubsBits2 >> 37) & 3;
    SELF.orig_unused_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.orig_login_history_id_Invalid := (le.ScrubsBits2 >> 42) & 7;
    SELF.orig_aseid_Invalid := (le.ScrubsBits2 >> 45) & 7;
    SELF.orig_years_Invalid := (le.ScrubsBits2 >> 48) & 7;
    SELF.orig_ip_address_Invalid := (le.ScrubsBits2 >> 51) & 3;
    SELF.orig_source_code_Invalid := (le.ScrubsBits2 >> 53) & 7;
    SELF.orig_retail_price_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.orig_end_user_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.orig_loginid_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.orig_billing_code_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.orig_transaction_id_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.orig_transaction_type_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.orig_neighbors_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.orig_relatives_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.orig_associates_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.orig_property_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.orig_company_id_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.orig_reference_code_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.orig_fname_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.orig_mname_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.orig_lname_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.orig_address_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.orig_city_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.orig_state_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.orig_zip_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.orig_zip4_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.orig_phone_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.orig_ssn_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.orig_free_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.orig_record_count_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.orig_price_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.orig_bankruptcy_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.orig_transaction_code_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.orig_dateadded_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.orig_full_name_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.orig_billingdate_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.orig_business_name_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.orig_pricing_error_code_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.orig_dl_purpose_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.orig_result_format_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.orig_dob_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.orig_unique_id_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.orig_dls_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.orig_mvs_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.orig_function_name_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.orig_response_time_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.orig_data_source_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.orig_glb_purpose_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.orig_report_options_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.orig_unused_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF.orig_login_history_id_wouldClean := le.ScrubsCleanBits1 >> 43;
    SELF.orig_aseid_wouldClean := le.ScrubsCleanBits1 >> 44;
    SELF.orig_years_wouldClean := le.ScrubsCleanBits1 >> 45;
    SELF.orig_ip_address_wouldClean := le.ScrubsCleanBits1 >> 46;
    SELF.orig_source_code_wouldClean := le.ScrubsCleanBits1 >> 47;
    SELF.orig_retail_price_wouldClean := le.ScrubsCleanBits1 >> 48;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_end_user_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_end_user_id_Invalid=1);
    orig_end_user_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_end_user_id_Invalid=1 AND h.orig_end_user_id_wouldClean);
    orig_loginid_ALLOW_ErrorCount := COUNT(GROUP,h.orig_loginid_Invalid=1);
    orig_loginid_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_loginid_Invalid=1 AND h.orig_loginid_wouldClean);
    orig_loginid_WORDS_ErrorCount := COUNT(GROUP,h.orig_loginid_Invalid=2);
    orig_loginid_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_loginid_Invalid=2 AND h.orig_loginid_wouldClean);
    orig_loginid_Total_ErrorCount := COUNT(GROUP,h.orig_loginid_Invalid>0);
    orig_billing_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=1);
    orig_billing_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_billing_code_Invalid=1 AND h.orig_billing_code_wouldClean);
    orig_billing_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=2);
    orig_billing_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_billing_code_Invalid=2 AND h.orig_billing_code_wouldClean);
    orig_billing_code_Total_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid>0);
    orig_transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1);
    orig_transaction_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2);
    orig_transaction_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2 AND h.orig_transaction_id_wouldClean);
    orig_transaction_id_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid>0);
    orig_transaction_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=1);
    orig_transaction_type_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=1 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_ALLOW_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=2);
    orig_transaction_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=2 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=3);
    orig_transaction_type_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=3 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_WORDS_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=4);
    orig_transaction_type_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_type_Invalid=4 AND h.orig_transaction_type_wouldClean);
    orig_transaction_type_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid>0);
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
    orig_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=1);
    orig_company_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=1 AND h.orig_company_id_wouldClean);
    orig_company_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=2);
    orig_company_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=2 AND h.orig_company_id_wouldClean);
    orig_company_id_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=3);
    orig_company_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=3 AND h.orig_company_id_wouldClean);
    orig_company_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=4);
    orig_company_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_company_id_Invalid=4 AND h.orig_company_id_wouldClean);
    orig_company_id_Total_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid>0);
    orig_reference_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=1);
    orig_reference_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_reference_code_Invalid=1 AND h.orig_reference_code_wouldClean);
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
    orig_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=1);
    orig_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address_Invalid=1 AND h.orig_address_wouldClean);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=1 AND h.orig_city_wouldClean);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=2 AND h.orig_city_wouldClean);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=1 AND h.orig_state_wouldClean);
    orig_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=2 AND h.orig_state_wouldClean);
    orig_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=3);
    orig_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=3 AND h.orig_state_wouldClean);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=1 AND h.orig_zip_wouldClean);
    orig_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=2 AND h.orig_zip_wouldClean);
    orig_zip_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=3);
    orig_zip_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip_Invalid=3 AND h.orig_zip_wouldClean);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_zip4_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zip4_Invalid=1 AND h.orig_zip4_wouldClean);
    orig_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=2);
    orig_zip4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_zip4_Invalid=2 AND h.orig_zip4_wouldClean);
    orig_zip4_WORDS_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=3);
    orig_zip4_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zip4_Invalid=3 AND h.orig_zip4_wouldClean);
    orig_zip4_Total_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid>0);
    orig_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=1 AND h.orig_phone_wouldClean);
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=2 AND h.orig_phone_wouldClean);
    orig_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=3);
    orig_phone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=3 AND h.orig_phone_wouldClean);
    orig_phone_WORDS_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=4);
    orig_phone_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_phone_Invalid=4 AND h.orig_phone_wouldClean);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    orig_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=1);
    orig_ssn_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=1 AND h.orig_ssn_wouldClean);
    orig_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=2);
    orig_ssn_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=2 AND h.orig_ssn_wouldClean);
    orig_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=3);
    orig_ssn_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=3 AND h.orig_ssn_wouldClean);
    orig_ssn_WORDS_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=4);
    orig_ssn_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ssn_Invalid=4 AND h.orig_ssn_wouldClean);
    orig_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid>0);
    orig_free_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=1);
    orig_free_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=1 AND h.orig_free_wouldClean);
    orig_free_ALLOW_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=2);
    orig_free_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=2 AND h.orig_free_wouldClean);
    orig_free_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=3);
    orig_free_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=3 AND h.orig_free_wouldClean);
    orig_free_WORDS_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=4);
    orig_free_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_free_Invalid=4 AND h.orig_free_wouldClean);
    orig_free_Total_ErrorCount := COUNT(GROUP,h.orig_free_Invalid>0);
    orig_record_count_ALLOW_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=1);
    orig_record_count_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_record_count_Invalid=1 AND h.orig_record_count_wouldClean);
    orig_record_count_WORDS_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=2);
    orig_record_count_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_record_count_Invalid=2 AND h.orig_record_count_wouldClean);
    orig_record_count_Total_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid>0);
    orig_price_ALLOW_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=1);
    orig_price_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_price_Invalid=1 AND h.orig_price_wouldClean);
    orig_price_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=2);
    orig_price_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_price_Invalid=2 AND h.orig_price_wouldClean);
    orig_price_WORDS_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=3);
    orig_price_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_price_Invalid=3 AND h.orig_price_wouldClean);
    orig_price_Total_ErrorCount := COUNT(GROUP,h.orig_price_Invalid>0);
    orig_bankruptcy_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=1);
    orig_bankruptcy_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=1 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_ALLOW_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=2);
    orig_bankruptcy_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=2 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=3);
    orig_bankruptcy_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=3 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_WORDS_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=4);
    orig_bankruptcy_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_bankruptcy_Invalid=4 AND h.orig_bankruptcy_wouldClean);
    orig_bankruptcy_Total_ErrorCount := COUNT(GROUP,h.orig_bankruptcy_Invalid>0);
    orig_transaction_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_transaction_code_Invalid=1);
    orig_transaction_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_transaction_code_Invalid=1 AND h.orig_transaction_code_wouldClean);
    orig_transaction_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_transaction_code_Invalid=2);
    orig_transaction_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_transaction_code_Invalid=2 AND h.orig_transaction_code_wouldClean);
    orig_transaction_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_transaction_code_Invalid=3);
    orig_transaction_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_code_Invalid=3 AND h.orig_transaction_code_wouldClean);
    orig_transaction_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_transaction_code_Invalid=4);
    orig_transaction_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_transaction_code_Invalid=4 AND h.orig_transaction_code_wouldClean);
    orig_transaction_code_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_code_Invalid>0);
    orig_dateadded_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=1);
    orig_dateadded_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=1 AND h.orig_dateadded_wouldClean);
    orig_dateadded_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=2);
    orig_dateadded_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=2 AND h.orig_dateadded_wouldClean);
    orig_dateadded_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=3);
    orig_dateadded_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=3 AND h.orig_dateadded_wouldClean);
    orig_dateadded_WORDS_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid=4);
    orig_dateadded_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dateadded_Invalid=4 AND h.orig_dateadded_wouldClean);
    orig_dateadded_Total_ErrorCount := COUNT(GROUP,h.orig_dateadded_Invalid>0);
    orig_full_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=1);
    orig_full_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=1 AND h.orig_full_name_wouldClean);
    orig_full_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid=2);
    orig_full_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_full_name_Invalid=2 AND h.orig_full_name_wouldClean);
    orig_full_name_Total_ErrorCount := COUNT(GROUP,h.orig_full_name_Invalid>0);
    orig_billingdate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_billingdate_Invalid=1);
    orig_billingdate_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_billingdate_Invalid=1 AND h.orig_billingdate_wouldClean);
    orig_billingdate_ALLOW_ErrorCount := COUNT(GROUP,h.orig_billingdate_Invalid=2);
    orig_billingdate_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_billingdate_Invalid=2 AND h.orig_billingdate_wouldClean);
    orig_billingdate_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_billingdate_Invalid=3);
    orig_billingdate_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_billingdate_Invalid=3 AND h.orig_billingdate_wouldClean);
    orig_billingdate_WORDS_ErrorCount := COUNT(GROUP,h.orig_billingdate_Invalid=4);
    orig_billingdate_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_billingdate_Invalid=4 AND h.orig_billingdate_wouldClean);
    orig_billingdate_Total_ErrorCount := COUNT(GROUP,h.orig_billingdate_Invalid>0);
    orig_business_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=1);
    orig_business_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_business_name_Invalid=1 AND h.orig_business_name_wouldClean);
    orig_business_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=2);
    orig_business_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_business_name_Invalid=2 AND h.orig_business_name_wouldClean);
    orig_business_name_Total_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid>0);
    orig_pricing_error_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=1);
    orig_pricing_error_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=1 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=2);
    orig_pricing_error_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=2 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=3);
    orig_pricing_error_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=3 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=4);
    orig_pricing_error_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=4 AND h.orig_pricing_error_code_wouldClean);
    orig_pricing_error_code_Total_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid>0);
    orig_dl_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=1);
    orig_dl_purpose_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=1 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=2);
    orig_dl_purpose_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=2 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=3);
    orig_dl_purpose_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=3 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_WORDS_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=4);
    orig_dl_purpose_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_dl_purpose_Invalid=4 AND h.orig_dl_purpose_wouldClean);
    orig_dl_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_dl_purpose_Invalid>0);
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
    orig_unique_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=1);
    orig_unique_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_unique_id_Invalid=1 AND h.orig_unique_id_wouldClean);
    orig_unique_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=2);
    orig_unique_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_unique_id_Invalid=2 AND h.orig_unique_id_wouldClean);
    orig_unique_id_Total_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid>0);
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
    orig_function_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=1);
    orig_function_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=1 AND h.orig_function_name_wouldClean);
    orig_function_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=2);
    orig_function_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_function_name_Invalid=2 AND h.orig_function_name_wouldClean);
    orig_function_name_Total_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid>0);
    orig_response_time_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=1);
    orig_response_time_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=1 AND h.orig_response_time_wouldClean);
    orig_response_time_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=2);
    orig_response_time_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=2 AND h.orig_response_time_wouldClean);
    orig_response_time_WORDS_ErrorCount := COUNT(GROUP,h.orig_response_time_Invalid=3);
    orig_response_time_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_response_time_Invalid=3 AND h.orig_response_time_wouldClean);
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
    orig_glb_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=1);
    orig_glb_purpose_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=1 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=2);
    orig_glb_purpose_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=2 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=3);
    orig_glb_purpose_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=3 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_WORDS_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=4);
    orig_glb_purpose_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=4 AND h.orig_glb_purpose_wouldClean);
    orig_glb_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid>0);
    orig_report_options_ALLOW_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid=1);
    orig_report_options_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_report_options_Invalid=1 AND h.orig_report_options_wouldClean);
    orig_report_options_WORDS_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid=2);
    orig_report_options_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_report_options_Invalid=2 AND h.orig_report_options_wouldClean);
    orig_report_options_Total_ErrorCount := COUNT(GROUP,h.orig_report_options_Invalid>0);
    orig_unused_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_unused_Invalid=1);
    orig_unused_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_unused_Invalid=1 AND h.orig_unused_wouldClean);
    orig_unused_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unused_Invalid=2);
    orig_unused_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_unused_Invalid=2 AND h.orig_unused_wouldClean);
    orig_unused_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_unused_Invalid=3);
    orig_unused_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_unused_Invalid=3 AND h.orig_unused_wouldClean);
    orig_unused_WORDS_ErrorCount := COUNT(GROUP,h.orig_unused_Invalid=4);
    orig_unused_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_unused_Invalid=4 AND h.orig_unused_wouldClean);
    orig_unused_Total_ErrorCount := COUNT(GROUP,h.orig_unused_Invalid>0);
    orig_login_history_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1);
    orig_login_history_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_ALLOW_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2);
    orig_login_history_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=3);
    orig_login_history_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=3 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_WORDS_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=4);
    orig_login_history_id_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_login_history_id_Invalid=4 AND h.orig_login_history_id_wouldClean);
    orig_login_history_id_Total_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid>0);
    orig_aseid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_aseid_Invalid=1);
    orig_aseid_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_aseid_Invalid=1 AND h.orig_aseid_wouldClean);
    orig_aseid_ALLOW_ErrorCount := COUNT(GROUP,h.orig_aseid_Invalid=2);
    orig_aseid_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_aseid_Invalid=2 AND h.orig_aseid_wouldClean);
    orig_aseid_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_aseid_Invalid=3);
    orig_aseid_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_aseid_Invalid=3 AND h.orig_aseid_wouldClean);
    orig_aseid_WORDS_ErrorCount := COUNT(GROUP,h.orig_aseid_Invalid=4);
    orig_aseid_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_aseid_Invalid=4 AND h.orig_aseid_wouldClean);
    orig_aseid_Total_ErrorCount := COUNT(GROUP,h.orig_aseid_Invalid>0);
    orig_years_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=1);
    orig_years_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=1 AND h.orig_years_wouldClean);
    orig_years_ALLOW_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=2);
    orig_years_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=2 AND h.orig_years_wouldClean);
    orig_years_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=3);
    orig_years_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=3 AND h.orig_years_wouldClean);
    orig_years_WORDS_ErrorCount := COUNT(GROUP,h.orig_years_Invalid=4);
    orig_years_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_years_Invalid=4 AND h.orig_years_wouldClean);
    orig_years_Total_ErrorCount := COUNT(GROUP,h.orig_years_Invalid>0);
    orig_ip_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid=1);
    orig_ip_address_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_Invalid=1 AND h.orig_ip_address_wouldClean);
    orig_ip_address_WORDS_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid=2);
    orig_ip_address_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_ip_address_Invalid=2 AND h.orig_ip_address_wouldClean);
    orig_ip_address_Total_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid>0);
    orig_source_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_source_code_Invalid=1);
    orig_source_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_source_code_Invalid=1 AND h.orig_source_code_wouldClean);
    orig_source_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_source_code_Invalid=2);
    orig_source_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_source_code_Invalid=2 AND h.orig_source_code_wouldClean);
    orig_source_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_source_code_Invalid=3);
    orig_source_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_source_code_Invalid=3 AND h.orig_source_code_wouldClean);
    orig_source_code_WORDS_ErrorCount := COUNT(GROUP,h.orig_source_code_Invalid=4);
    orig_source_code_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_source_code_Invalid=4 AND h.orig_source_code_wouldClean);
    orig_source_code_Total_ErrorCount := COUNT(GROUP,h.orig_source_code_Invalid>0);
    orig_retail_price_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid=1);
    orig_retail_price_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_retail_price_Invalid=1 AND h.orig_retail_price_wouldClean);
    orig_retail_price_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid=2);
    orig_retail_price_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_retail_price_Invalid=2 AND h.orig_retail_price_wouldClean);
    orig_retail_price_WORDS_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid=3);
    orig_retail_price_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_retail_price_Invalid=3 AND h.orig_retail_price_wouldClean);
    orig_retail_price_Total_ErrorCount := COUNT(GROUP,h.orig_retail_price_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_end_user_id_Invalid > 0 OR h.orig_loginid_Invalid > 0 OR h.orig_billing_code_Invalid > 0 OR h.orig_transaction_id_Invalid > 0 OR h.orig_transaction_type_Invalid > 0 OR h.orig_neighbors_Invalid > 0 OR h.orig_relatives_Invalid > 0 OR h.orig_associates_Invalid > 0 OR h.orig_property_Invalid > 0 OR h.orig_company_id_Invalid > 0 OR h.orig_reference_code_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_address_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.orig_phone_Invalid > 0 OR h.orig_ssn_Invalid > 0 OR h.orig_free_Invalid > 0 OR h.orig_record_count_Invalid > 0 OR h.orig_price_Invalid > 0 OR h.orig_bankruptcy_Invalid > 0 OR h.orig_transaction_code_Invalid > 0 OR h.orig_dateadded_Invalid > 0 OR h.orig_full_name_Invalid > 0 OR h.orig_billingdate_Invalid > 0 OR h.orig_business_name_Invalid > 0 OR h.orig_pricing_error_code_Invalid > 0 OR h.orig_dl_purpose_Invalid > 0 OR h.orig_result_format_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_unique_id_Invalid > 0 OR h.orig_dls_Invalid > 0 OR h.orig_mvs_Invalid > 0 OR h.orig_function_name_Invalid > 0 OR h.orig_response_time_Invalid > 0 OR h.orig_data_source_Invalid > 0 OR h.orig_glb_purpose_Invalid > 0 OR h.orig_report_options_Invalid > 0 OR h.orig_unused_Invalid > 0 OR h.orig_login_history_id_Invalid > 0 OR h.orig_aseid_Invalid > 0 OR h.orig_years_Invalid > 0 OR h.orig_ip_address_Invalid > 0 OR h.orig_source_code_Invalid > 0 OR h.orig_retail_price_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.orig_end_user_id_wouldClean OR h.orig_loginid_wouldClean OR h.orig_billing_code_wouldClean OR h.orig_transaction_id_wouldClean OR h.orig_transaction_type_wouldClean OR h.orig_neighbors_wouldClean OR h.orig_relatives_wouldClean OR h.orig_associates_wouldClean OR h.orig_property_wouldClean OR h.orig_company_id_wouldClean OR h.orig_reference_code_wouldClean OR h.orig_fname_wouldClean OR h.orig_mname_wouldClean OR h.orig_lname_wouldClean OR h.orig_address_wouldClean OR h.orig_city_wouldClean OR h.orig_state_wouldClean OR h.orig_zip_wouldClean OR h.orig_zip4_wouldClean OR h.orig_phone_wouldClean OR h.orig_ssn_wouldClean OR h.orig_free_wouldClean OR h.orig_record_count_wouldClean OR h.orig_price_wouldClean OR h.orig_bankruptcy_wouldClean OR h.orig_transaction_code_wouldClean OR h.orig_dateadded_wouldClean OR h.orig_full_name_wouldClean OR h.orig_billingdate_wouldClean OR h.orig_business_name_wouldClean OR h.orig_pricing_error_code_wouldClean OR h.orig_dl_purpose_wouldClean OR h.orig_result_format_wouldClean OR h.orig_dob_wouldClean OR h.orig_unique_id_wouldClean OR h.orig_dls_wouldClean OR h.orig_mvs_wouldClean OR h.orig_function_name_wouldClean OR h.orig_response_time_wouldClean OR h.orig_data_source_wouldClean OR h.orig_glb_purpose_wouldClean OR h.orig_report_options_wouldClean OR h.orig_unused_wouldClean OR h.orig_login_history_id_wouldClean OR h.orig_aseid_wouldClean OR h.orig_years_wouldClean OR h.orig_ip_address_wouldClean OR h.orig_source_code_wouldClean OR h.orig_retail_price_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_end_user_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_loginid_Total_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_Total_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_Total_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_Total_ErrorCount > 0, 1, 0) + IF(le.orig_associates_Total_ErrorCount > 0, 1, 0) + IF(le.orig_property_Total_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_lname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_free_Total_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_Total_ErrorCount > 0, 1, 0) + IF(le.orig_price_Total_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_Total_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_Total_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_billingdate_Total_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_Total_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dls_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_Total_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_Total_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_Total_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_Total_ErrorCount > 0, 1, 0) + IF(le.orig_unused_Total_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_aseid_Total_ErrorCount > 0, 1, 0) + IF(le.orig_years_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_source_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_end_user_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_loginid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_loginid_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_neighbors_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_relatives_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_associates_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_associates_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_associates_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_associates_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_property_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_property_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_property_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_property_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_phone_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_free_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_free_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_free_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_free_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_price_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_price_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_bankruptcy_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dateadded_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_full_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_billingdate_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_billingdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_billingdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_billingdate_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dl_purpose_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_result_format_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dob_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_dls_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dls_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dls_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_dls_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_mvs_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_response_time_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_data_source_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_report_options_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_unused_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_unused_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unused_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_unused_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_aseid_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_aseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_aseid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_aseid_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_years_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_years_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_years_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_years_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_source_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_source_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_source_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_retail_price_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.orig_end_user_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_loginid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_loginid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billing_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_billing_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_type_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_neighbors_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_relatives_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_associates_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_property_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_company_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_reference_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zip4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_phone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ssn_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_free_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_record_count_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_record_count_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_price_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_price_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_price_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_bankruptcy_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_transaction_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dateadded_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_full_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingdate_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingdate_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingdate_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_billingdate_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_business_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_pricing_error_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dl_purpose_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_result_format_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dob_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_unique_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_unique_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_dls_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mvs_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_function_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_response_time_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_data_source_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_glb_purpose_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_report_options_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_report_options_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_unused_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_unused_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_unused_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_unused_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_login_history_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_aseid_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_aseid_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_aseid_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_aseid_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_years_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_ip_address_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_source_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_source_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_source_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_source_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_retail_price_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_retail_price_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_retail_price_WORDS_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_end_user_id_Invalid,le.orig_loginid_Invalid,le.orig_billing_code_Invalid,le.orig_transaction_id_Invalid,le.orig_transaction_type_Invalid,le.orig_neighbors_Invalid,le.orig_relatives_Invalid,le.orig_associates_Invalid,le.orig_property_Invalid,le.orig_company_id_Invalid,le.orig_reference_code_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_address_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_zip4_Invalid,le.orig_phone_Invalid,le.orig_ssn_Invalid,le.orig_free_Invalid,le.orig_record_count_Invalid,le.orig_price_Invalid,le.orig_bankruptcy_Invalid,le.orig_transaction_code_Invalid,le.orig_dateadded_Invalid,le.orig_full_name_Invalid,le.orig_billingdate_Invalid,le.orig_business_name_Invalid,le.orig_pricing_error_code_Invalid,le.orig_dl_purpose_Invalid,le.orig_result_format_Invalid,le.orig_dob_Invalid,le.orig_unique_id_Invalid,le.orig_dls_Invalid,le.orig_mvs_Invalid,le.orig_function_name_Invalid,le.orig_response_time_Invalid,le.orig_data_source_Invalid,le.orig_glb_purpose_Invalid,le.orig_report_options_Invalid,le.orig_unused_Invalid,le.orig_login_history_id_Invalid,le.orig_aseid_Invalid,le.orig_years_Invalid,le.orig_ip_address_Invalid,le.orig_source_code_Invalid,le.orig_retail_price_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_end_user_id(le.orig_end_user_id_Invalid),Fields.InvalidMessage_orig_loginid(le.orig_loginid_Invalid),Fields.InvalidMessage_orig_billing_code(le.orig_billing_code_Invalid),Fields.InvalidMessage_orig_transaction_id(le.orig_transaction_id_Invalid),Fields.InvalidMessage_orig_transaction_type(le.orig_transaction_type_Invalid),Fields.InvalidMessage_orig_neighbors(le.orig_neighbors_Invalid),Fields.InvalidMessage_orig_relatives(le.orig_relatives_Invalid),Fields.InvalidMessage_orig_associates(le.orig_associates_Invalid),Fields.InvalidMessage_orig_property(le.orig_property_Invalid),Fields.InvalidMessage_orig_company_id(le.orig_company_id_Invalid),Fields.InvalidMessage_orig_reference_code(le.orig_reference_code_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_address(le.orig_address_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_orig_ssn(le.orig_ssn_Invalid),Fields.InvalidMessage_orig_free(le.orig_free_Invalid),Fields.InvalidMessage_orig_record_count(le.orig_record_count_Invalid),Fields.InvalidMessage_orig_price(le.orig_price_Invalid),Fields.InvalidMessage_orig_bankruptcy(le.orig_bankruptcy_Invalid),Fields.InvalidMessage_orig_transaction_code(le.orig_transaction_code_Invalid),Fields.InvalidMessage_orig_dateadded(le.orig_dateadded_Invalid),Fields.InvalidMessage_orig_full_name(le.orig_full_name_Invalid),Fields.InvalidMessage_orig_billingdate(le.orig_billingdate_Invalid),Fields.InvalidMessage_orig_business_name(le.orig_business_name_Invalid),Fields.InvalidMessage_orig_pricing_error_code(le.orig_pricing_error_code_Invalid),Fields.InvalidMessage_orig_dl_purpose(le.orig_dl_purpose_Invalid),Fields.InvalidMessage_orig_result_format(le.orig_result_format_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_unique_id(le.orig_unique_id_Invalid),Fields.InvalidMessage_orig_dls(le.orig_dls_Invalid),Fields.InvalidMessage_orig_mvs(le.orig_mvs_Invalid),Fields.InvalidMessage_orig_function_name(le.orig_function_name_Invalid),Fields.InvalidMessage_orig_response_time(le.orig_response_time_Invalid),Fields.InvalidMessage_orig_data_source(le.orig_data_source_Invalid),Fields.InvalidMessage_orig_glb_purpose(le.orig_glb_purpose_Invalid),Fields.InvalidMessage_orig_report_options(le.orig_report_options_Invalid),Fields.InvalidMessage_orig_unused(le.orig_unused_Invalid),Fields.InvalidMessage_orig_login_history_id(le.orig_login_history_id_Invalid),Fields.InvalidMessage_orig_aseid(le.orig_aseid_Invalid),Fields.InvalidMessage_orig_years(le.orig_years_Invalid),Fields.InvalidMessage_orig_ip_address(le.orig_ip_address_Invalid),Fields.InvalidMessage_orig_source_code(le.orig_source_code_Invalid),Fields.InvalidMessage_orig_retail_price(le.orig_retail_price_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_end_user_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_loginid_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_billing_code_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_transaction_id_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_transaction_type_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_neighbors_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_relatives_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_associates_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_property_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_company_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_reference_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_free_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_record_count_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_price_Invalid,'ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_bankruptcy_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_transaction_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dateadded_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_full_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_billingdate_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_business_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_pricing_error_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dl_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_result_format_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_unique_id_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_dls_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mvs_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_function_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_response_time_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_data_source_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_glb_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_report_options_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_unused_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_login_history_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_aseid_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_years_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_ip_address_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_source_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_retail_price_Invalid,'LEFTTRIM','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.orig_end_user_id,(SALT39.StrType)le.orig_loginid,(SALT39.StrType)le.orig_billing_code,(SALT39.StrType)le.orig_transaction_id,(SALT39.StrType)le.orig_transaction_type,(SALT39.StrType)le.orig_neighbors,(SALT39.StrType)le.orig_relatives,(SALT39.StrType)le.orig_associates,(SALT39.StrType)le.orig_property,(SALT39.StrType)le.orig_company_id,(SALT39.StrType)le.orig_reference_code,(SALT39.StrType)le.orig_fname,(SALT39.StrType)le.orig_mname,(SALT39.StrType)le.orig_lname,(SALT39.StrType)le.orig_address,(SALT39.StrType)le.orig_city,(SALT39.StrType)le.orig_state,(SALT39.StrType)le.orig_zip,(SALT39.StrType)le.orig_zip4,(SALT39.StrType)le.orig_phone,(SALT39.StrType)le.orig_ssn,(SALT39.StrType)le.orig_free,(SALT39.StrType)le.orig_record_count,(SALT39.StrType)le.orig_price,(SALT39.StrType)le.orig_bankruptcy,(SALT39.StrType)le.orig_transaction_code,(SALT39.StrType)le.orig_dateadded,(SALT39.StrType)le.orig_full_name,(SALT39.StrType)le.orig_billingdate,(SALT39.StrType)le.orig_business_name,(SALT39.StrType)le.orig_pricing_error_code,(SALT39.StrType)le.orig_dl_purpose,(SALT39.StrType)le.orig_result_format,(SALT39.StrType)le.orig_dob,(SALT39.StrType)le.orig_unique_id,(SALT39.StrType)le.orig_dls,(SALT39.StrType)le.orig_mvs,(SALT39.StrType)le.orig_function_name,(SALT39.StrType)le.orig_response_time,(SALT39.StrType)le.orig_data_source,(SALT39.StrType)le.orig_glb_purpose,(SALT39.StrType)le.orig_report_options,(SALT39.StrType)le.orig_unused,(SALT39.StrType)le.orig_login_history_id,(SALT39.StrType)le.orig_aseid,(SALT39.StrType)le.orig_years,(SALT39.StrType)le.orig_ip_address,(SALT39.StrType)le.orig_source_code,(SALT39.StrType)le.orig_retail_price,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,49,Into(LEFT,COUNTER));
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
          ,'orig_end_user_id:orig_end_user_id:ALLOW'
          ,'orig_loginid:orig_loginid:ALLOW','orig_loginid:orig_loginid:WORDS'
          ,'orig_billing_code:orig_billing_code:ALLOW','orig_billing_code:orig_billing_code:WORDS'
          ,'orig_transaction_id:orig_transaction_id:ALLOW','orig_transaction_id:orig_transaction_id:WORDS'
          ,'orig_transaction_type:orig_transaction_type:LEFTTRIM','orig_transaction_type:orig_transaction_type:ALLOW','orig_transaction_type:orig_transaction_type:LENGTHS','orig_transaction_type:orig_transaction_type:WORDS'
          ,'orig_neighbors:orig_neighbors:LEFTTRIM','orig_neighbors:orig_neighbors:ALLOW','orig_neighbors:orig_neighbors:LENGTHS','orig_neighbors:orig_neighbors:WORDS'
          ,'orig_relatives:orig_relatives:LEFTTRIM','orig_relatives:orig_relatives:ALLOW','orig_relatives:orig_relatives:LENGTHS','orig_relatives:orig_relatives:WORDS'
          ,'orig_associates:orig_associates:LEFTTRIM','orig_associates:orig_associates:ALLOW','orig_associates:orig_associates:LENGTHS','orig_associates:orig_associates:WORDS'
          ,'orig_property:orig_property:LEFTTRIM','orig_property:orig_property:ALLOW','orig_property:orig_property:LENGTHS','orig_property:orig_property:WORDS'
          ,'orig_company_id:orig_company_id:LEFTTRIM','orig_company_id:orig_company_id:ALLOW','orig_company_id:orig_company_id:LENGTHS','orig_company_id:orig_company_id:WORDS'
          ,'orig_reference_code:orig_reference_code:ALLOW'
          ,'orig_fname:orig_fname:ALLOW','orig_fname:orig_fname:WORDS'
          ,'orig_mname:orig_mname:ALLOW','orig_mname:orig_mname:WORDS'
          ,'orig_lname:orig_lname:ALLOW','orig_lname:orig_lname:WORDS'
          ,'orig_address:orig_address:ALLOW'
          ,'orig_city:orig_city:ALLOW','orig_city:orig_city:WORDS'
          ,'orig_state:orig_state:ALLOW','orig_state:orig_state:LENGTHS','orig_state:orig_state:WORDS'
          ,'orig_zip:orig_zip:ALLOW','orig_zip:orig_zip:LENGTHS','orig_zip:orig_zip:WORDS'
          ,'orig_zip4:orig_zip4:ALLOW','orig_zip4:orig_zip4:LENGTHS','orig_zip4:orig_zip4:WORDS'
          ,'orig_phone:orig_phone:LEFTTRIM','orig_phone:orig_phone:ALLOW','orig_phone:orig_phone:LENGTHS','orig_phone:orig_phone:WORDS'
          ,'orig_ssn:orig_ssn:LEFTTRIM','orig_ssn:orig_ssn:ALLOW','orig_ssn:orig_ssn:LENGTHS','orig_ssn:orig_ssn:WORDS'
          ,'orig_free:orig_free:LEFTTRIM','orig_free:orig_free:ALLOW','orig_free:orig_free:LENGTHS','orig_free:orig_free:WORDS'
          ,'orig_record_count:orig_record_count:ALLOW','orig_record_count:orig_record_count:WORDS'
          ,'orig_price:orig_price:ALLOW','orig_price:orig_price:LENGTHS','orig_price:orig_price:WORDS'
          ,'orig_bankruptcy:orig_bankruptcy:LEFTTRIM','orig_bankruptcy:orig_bankruptcy:ALLOW','orig_bankruptcy:orig_bankruptcy:LENGTHS','orig_bankruptcy:orig_bankruptcy:WORDS'
          ,'orig_transaction_code:orig_transaction_code:LEFTTRIM','orig_transaction_code:orig_transaction_code:ALLOW','orig_transaction_code:orig_transaction_code:LENGTHS','orig_transaction_code:orig_transaction_code:WORDS'
          ,'orig_dateadded:orig_dateadded:LEFTTRIM','orig_dateadded:orig_dateadded:ALLOW','orig_dateadded:orig_dateadded:LENGTHS','orig_dateadded:orig_dateadded:WORDS'
          ,'orig_full_name:orig_full_name:ALLOW','orig_full_name:orig_full_name:WORDS'
          ,'orig_billingdate:orig_billingdate:LEFTTRIM','orig_billingdate:orig_billingdate:ALLOW','orig_billingdate:orig_billingdate:LENGTHS','orig_billingdate:orig_billingdate:WORDS'
          ,'orig_business_name:orig_business_name:ALLOW','orig_business_name:orig_business_name:WORDS'
          ,'orig_pricing_error_code:orig_pricing_error_code:LEFTTRIM','orig_pricing_error_code:orig_pricing_error_code:ALLOW','orig_pricing_error_code:orig_pricing_error_code:LENGTHS','orig_pricing_error_code:orig_pricing_error_code:WORDS'
          ,'orig_dl_purpose:orig_dl_purpose:LEFTTRIM','orig_dl_purpose:orig_dl_purpose:ALLOW','orig_dl_purpose:orig_dl_purpose:LENGTHS','orig_dl_purpose:orig_dl_purpose:WORDS'
          ,'orig_result_format:orig_result_format:LEFTTRIM','orig_result_format:orig_result_format:ALLOW','orig_result_format:orig_result_format:LENGTHS','orig_result_format:orig_result_format:WORDS'
          ,'orig_dob:orig_dob:LEFTTRIM','orig_dob:orig_dob:ALLOW','orig_dob:orig_dob:LENGTHS','orig_dob:orig_dob:WORDS'
          ,'orig_unique_id:orig_unique_id:ALLOW','orig_unique_id:orig_unique_id:WORDS'
          ,'orig_dls:orig_dls:LEFTTRIM','orig_dls:orig_dls:ALLOW','orig_dls:orig_dls:LENGTHS','orig_dls:orig_dls:WORDS'
          ,'orig_mvs:orig_mvs:LEFTTRIM','orig_mvs:orig_mvs:ALLOW','orig_mvs:orig_mvs:LENGTHS','orig_mvs:orig_mvs:WORDS'
          ,'orig_function_name:orig_function_name:ALLOW','orig_function_name:orig_function_name:WORDS'
          ,'orig_response_time:orig_response_time:LEFTTRIM','orig_response_time:orig_response_time:LENGTHS','orig_response_time:orig_response_time:WORDS'
          ,'orig_data_source:orig_data_source:LEFTTRIM','orig_data_source:orig_data_source:ALLOW','orig_data_source:orig_data_source:LENGTHS','orig_data_source:orig_data_source:WORDS'
          ,'orig_glb_purpose:orig_glb_purpose:LEFTTRIM','orig_glb_purpose:orig_glb_purpose:ALLOW','orig_glb_purpose:orig_glb_purpose:LENGTHS','orig_glb_purpose:orig_glb_purpose:WORDS'
          ,'orig_report_options:orig_report_options:ALLOW','orig_report_options:orig_report_options:WORDS'
          ,'orig_unused:orig_unused:LEFTTRIM','orig_unused:orig_unused:ALLOW','orig_unused:orig_unused:LENGTHS','orig_unused:orig_unused:WORDS'
          ,'orig_login_history_id:orig_login_history_id:LEFTTRIM','orig_login_history_id:orig_login_history_id:ALLOW','orig_login_history_id:orig_login_history_id:LENGTHS','orig_login_history_id:orig_login_history_id:WORDS'
          ,'orig_aseid:orig_aseid:LEFTTRIM','orig_aseid:orig_aseid:ALLOW','orig_aseid:orig_aseid:LENGTHS','orig_aseid:orig_aseid:WORDS'
          ,'orig_years:orig_years:LEFTTRIM','orig_years:orig_years:ALLOW','orig_years:orig_years:LENGTHS','orig_years:orig_years:WORDS'
          ,'orig_ip_address:orig_ip_address:ALLOW','orig_ip_address:orig_ip_address:WORDS'
          ,'orig_source_code:orig_source_code:LEFTTRIM','orig_source_code:orig_source_code:ALLOW','orig_source_code:orig_source_code:LENGTHS','orig_source_code:orig_source_code:WORDS'
          ,'orig_retail_price:orig_retail_price:LEFTTRIM','orig_retail_price:orig_retail_price:LENGTHS','orig_retail_price:orig_retail_price:WORDS'
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
          ,Fields.InvalidMessage_orig_end_user_id(1)
          ,Fields.InvalidMessage_orig_loginid(1),Fields.InvalidMessage_orig_loginid(2)
          ,Fields.InvalidMessage_orig_billing_code(1),Fields.InvalidMessage_orig_billing_code(2)
          ,Fields.InvalidMessage_orig_transaction_id(1),Fields.InvalidMessage_orig_transaction_id(2)
          ,Fields.InvalidMessage_orig_transaction_type(1),Fields.InvalidMessage_orig_transaction_type(2),Fields.InvalidMessage_orig_transaction_type(3),Fields.InvalidMessage_orig_transaction_type(4)
          ,Fields.InvalidMessage_orig_neighbors(1),Fields.InvalidMessage_orig_neighbors(2),Fields.InvalidMessage_orig_neighbors(3),Fields.InvalidMessage_orig_neighbors(4)
          ,Fields.InvalidMessage_orig_relatives(1),Fields.InvalidMessage_orig_relatives(2),Fields.InvalidMessage_orig_relatives(3),Fields.InvalidMessage_orig_relatives(4)
          ,Fields.InvalidMessage_orig_associates(1),Fields.InvalidMessage_orig_associates(2),Fields.InvalidMessage_orig_associates(3),Fields.InvalidMessage_orig_associates(4)
          ,Fields.InvalidMessage_orig_property(1),Fields.InvalidMessage_orig_property(2),Fields.InvalidMessage_orig_property(3),Fields.InvalidMessage_orig_property(4)
          ,Fields.InvalidMessage_orig_company_id(1),Fields.InvalidMessage_orig_company_id(2),Fields.InvalidMessage_orig_company_id(3),Fields.InvalidMessage_orig_company_id(4)
          ,Fields.InvalidMessage_orig_reference_code(1)
          ,Fields.InvalidMessage_orig_fname(1),Fields.InvalidMessage_orig_fname(2)
          ,Fields.InvalidMessage_orig_mname(1),Fields.InvalidMessage_orig_mname(2)
          ,Fields.InvalidMessage_orig_lname(1),Fields.InvalidMessage_orig_lname(2)
          ,Fields.InvalidMessage_orig_address(1)
          ,Fields.InvalidMessage_orig_city(1),Fields.InvalidMessage_orig_city(2)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2),Fields.InvalidMessage_orig_state(3)
          ,Fields.InvalidMessage_orig_zip(1),Fields.InvalidMessage_orig_zip(2),Fields.InvalidMessage_orig_zip(3)
          ,Fields.InvalidMessage_orig_zip4(1),Fields.InvalidMessage_orig_zip4(2),Fields.InvalidMessage_orig_zip4(3)
          ,Fields.InvalidMessage_orig_phone(1),Fields.InvalidMessage_orig_phone(2),Fields.InvalidMessage_orig_phone(3),Fields.InvalidMessage_orig_phone(4)
          ,Fields.InvalidMessage_orig_ssn(1),Fields.InvalidMessage_orig_ssn(2),Fields.InvalidMessage_orig_ssn(3),Fields.InvalidMessage_orig_ssn(4)
          ,Fields.InvalidMessage_orig_free(1),Fields.InvalidMessage_orig_free(2),Fields.InvalidMessage_orig_free(3),Fields.InvalidMessage_orig_free(4)
          ,Fields.InvalidMessage_orig_record_count(1),Fields.InvalidMessage_orig_record_count(2)
          ,Fields.InvalidMessage_orig_price(1),Fields.InvalidMessage_orig_price(2),Fields.InvalidMessage_orig_price(3)
          ,Fields.InvalidMessage_orig_bankruptcy(1),Fields.InvalidMessage_orig_bankruptcy(2),Fields.InvalidMessage_orig_bankruptcy(3),Fields.InvalidMessage_orig_bankruptcy(4)
          ,Fields.InvalidMessage_orig_transaction_code(1),Fields.InvalidMessage_orig_transaction_code(2),Fields.InvalidMessage_orig_transaction_code(3),Fields.InvalidMessage_orig_transaction_code(4)
          ,Fields.InvalidMessage_orig_dateadded(1),Fields.InvalidMessage_orig_dateadded(2),Fields.InvalidMessage_orig_dateadded(3),Fields.InvalidMessage_orig_dateadded(4)
          ,Fields.InvalidMessage_orig_full_name(1),Fields.InvalidMessage_orig_full_name(2)
          ,Fields.InvalidMessage_orig_billingdate(1),Fields.InvalidMessage_orig_billingdate(2),Fields.InvalidMessage_orig_billingdate(3),Fields.InvalidMessage_orig_billingdate(4)
          ,Fields.InvalidMessage_orig_business_name(1),Fields.InvalidMessage_orig_business_name(2)
          ,Fields.InvalidMessage_orig_pricing_error_code(1),Fields.InvalidMessage_orig_pricing_error_code(2),Fields.InvalidMessage_orig_pricing_error_code(3),Fields.InvalidMessage_orig_pricing_error_code(4)
          ,Fields.InvalidMessage_orig_dl_purpose(1),Fields.InvalidMessage_orig_dl_purpose(2),Fields.InvalidMessage_orig_dl_purpose(3),Fields.InvalidMessage_orig_dl_purpose(4)
          ,Fields.InvalidMessage_orig_result_format(1),Fields.InvalidMessage_orig_result_format(2),Fields.InvalidMessage_orig_result_format(3),Fields.InvalidMessage_orig_result_format(4)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2),Fields.InvalidMessage_orig_dob(3),Fields.InvalidMessage_orig_dob(4)
          ,Fields.InvalidMessage_orig_unique_id(1),Fields.InvalidMessage_orig_unique_id(2)
          ,Fields.InvalidMessage_orig_dls(1),Fields.InvalidMessage_orig_dls(2),Fields.InvalidMessage_orig_dls(3),Fields.InvalidMessage_orig_dls(4)
          ,Fields.InvalidMessage_orig_mvs(1),Fields.InvalidMessage_orig_mvs(2),Fields.InvalidMessage_orig_mvs(3),Fields.InvalidMessage_orig_mvs(4)
          ,Fields.InvalidMessage_orig_function_name(1),Fields.InvalidMessage_orig_function_name(2)
          ,Fields.InvalidMessage_orig_response_time(1),Fields.InvalidMessage_orig_response_time(2),Fields.InvalidMessage_orig_response_time(3)
          ,Fields.InvalidMessage_orig_data_source(1),Fields.InvalidMessage_orig_data_source(2),Fields.InvalidMessage_orig_data_source(3),Fields.InvalidMessage_orig_data_source(4)
          ,Fields.InvalidMessage_orig_glb_purpose(1),Fields.InvalidMessage_orig_glb_purpose(2),Fields.InvalidMessage_orig_glb_purpose(3),Fields.InvalidMessage_orig_glb_purpose(4)
          ,Fields.InvalidMessage_orig_report_options(1),Fields.InvalidMessage_orig_report_options(2)
          ,Fields.InvalidMessage_orig_unused(1),Fields.InvalidMessage_orig_unused(2),Fields.InvalidMessage_orig_unused(3),Fields.InvalidMessage_orig_unused(4)
          ,Fields.InvalidMessage_orig_login_history_id(1),Fields.InvalidMessage_orig_login_history_id(2),Fields.InvalidMessage_orig_login_history_id(3),Fields.InvalidMessage_orig_login_history_id(4)
          ,Fields.InvalidMessage_orig_aseid(1),Fields.InvalidMessage_orig_aseid(2),Fields.InvalidMessage_orig_aseid(3),Fields.InvalidMessage_orig_aseid(4)
          ,Fields.InvalidMessage_orig_years(1),Fields.InvalidMessage_orig_years(2),Fields.InvalidMessage_orig_years(3),Fields.InvalidMessage_orig_years(4)
          ,Fields.InvalidMessage_orig_ip_address(1),Fields.InvalidMessage_orig_ip_address(2)
          ,Fields.InvalidMessage_orig_source_code(1),Fields.InvalidMessage_orig_source_code(2),Fields.InvalidMessage_orig_source_code(3),Fields.InvalidMessage_orig_source_code(4)
          ,Fields.InvalidMessage_orig_retail_price(1),Fields.InvalidMessage_orig_retail_price(2),Fields.InvalidMessage_orig_retail_price(3)
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
          ,le.orig_end_user_id_ALLOW_ErrorCount
          ,le.orig_loginid_ALLOW_ErrorCount,le.orig_loginid_WORDS_ErrorCount
          ,le.orig_billing_code_ALLOW_ErrorCount,le.orig_billing_code_WORDS_ErrorCount
          ,le.orig_transaction_id_ALLOW_ErrorCount,le.orig_transaction_id_WORDS_ErrorCount
          ,le.orig_transaction_type_LEFTTRIM_ErrorCount,le.orig_transaction_type_ALLOW_ErrorCount,le.orig_transaction_type_LENGTHS_ErrorCount,le.orig_transaction_type_WORDS_ErrorCount
          ,le.orig_neighbors_LEFTTRIM_ErrorCount,le.orig_neighbors_ALLOW_ErrorCount,le.orig_neighbors_LENGTHS_ErrorCount,le.orig_neighbors_WORDS_ErrorCount
          ,le.orig_relatives_LEFTTRIM_ErrorCount,le.orig_relatives_ALLOW_ErrorCount,le.orig_relatives_LENGTHS_ErrorCount,le.orig_relatives_WORDS_ErrorCount
          ,le.orig_associates_LEFTTRIM_ErrorCount,le.orig_associates_ALLOW_ErrorCount,le.orig_associates_LENGTHS_ErrorCount,le.orig_associates_WORDS_ErrorCount
          ,le.orig_property_LEFTTRIM_ErrorCount,le.orig_property_ALLOW_ErrorCount,le.orig_property_LENGTHS_ErrorCount,le.orig_property_WORDS_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_ALLOW_ErrorCount,le.orig_company_id_LENGTHS_ErrorCount,le.orig_company_id_WORDS_ErrorCount
          ,le.orig_reference_code_ALLOW_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_address_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTHS_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_LENGTHS_ErrorCount,le.orig_zip4_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_free_LEFTTRIM_ErrorCount,le.orig_free_ALLOW_ErrorCount,le.orig_free_LENGTHS_ErrorCount,le.orig_free_WORDS_ErrorCount
          ,le.orig_record_count_ALLOW_ErrorCount,le.orig_record_count_WORDS_ErrorCount
          ,le.orig_price_ALLOW_ErrorCount,le.orig_price_LENGTHS_ErrorCount,le.orig_price_WORDS_ErrorCount
          ,le.orig_bankruptcy_LEFTTRIM_ErrorCount,le.orig_bankruptcy_ALLOW_ErrorCount,le.orig_bankruptcy_LENGTHS_ErrorCount,le.orig_bankruptcy_WORDS_ErrorCount
          ,le.orig_transaction_code_LEFTTRIM_ErrorCount,le.orig_transaction_code_ALLOW_ErrorCount,le.orig_transaction_code_LENGTHS_ErrorCount,le.orig_transaction_code_WORDS_ErrorCount
          ,le.orig_dateadded_LEFTTRIM_ErrorCount,le.orig_dateadded_ALLOW_ErrorCount,le.orig_dateadded_LENGTHS_ErrorCount,le.orig_dateadded_WORDS_ErrorCount
          ,le.orig_full_name_ALLOW_ErrorCount,le.orig_full_name_WORDS_ErrorCount
          ,le.orig_billingdate_LEFTTRIM_ErrorCount,le.orig_billingdate_ALLOW_ErrorCount,le.orig_billingdate_LENGTHS_ErrorCount,le.orig_billingdate_WORDS_ErrorCount
          ,le.orig_business_name_ALLOW_ErrorCount,le.orig_business_name_WORDS_ErrorCount
          ,le.orig_pricing_error_code_LEFTTRIM_ErrorCount,le.orig_pricing_error_code_ALLOW_ErrorCount,le.orig_pricing_error_code_LENGTHS_ErrorCount,le.orig_pricing_error_code_WORDS_ErrorCount
          ,le.orig_dl_purpose_LEFTTRIM_ErrorCount,le.orig_dl_purpose_ALLOW_ErrorCount,le.orig_dl_purpose_LENGTHS_ErrorCount,le.orig_dl_purpose_WORDS_ErrorCount
          ,le.orig_result_format_LEFTTRIM_ErrorCount,le.orig_result_format_ALLOW_ErrorCount,le.orig_result_format_LENGTHS_ErrorCount,le.orig_result_format_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_ALLOW_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_unique_id_ALLOW_ErrorCount,le.orig_unique_id_WORDS_ErrorCount
          ,le.orig_dls_LEFTTRIM_ErrorCount,le.orig_dls_ALLOW_ErrorCount,le.orig_dls_LENGTHS_ErrorCount,le.orig_dls_WORDS_ErrorCount
          ,le.orig_mvs_LEFTTRIM_ErrorCount,le.orig_mvs_ALLOW_ErrorCount,le.orig_mvs_LENGTHS_ErrorCount,le.orig_mvs_WORDS_ErrorCount
          ,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_response_time_LEFTTRIM_ErrorCount,le.orig_response_time_LENGTHS_ErrorCount,le.orig_response_time_WORDS_ErrorCount
          ,le.orig_data_source_LEFTTRIM_ErrorCount,le.orig_data_source_ALLOW_ErrorCount,le.orig_data_source_LENGTHS_ErrorCount,le.orig_data_source_WORDS_ErrorCount
          ,le.orig_glb_purpose_LEFTTRIM_ErrorCount,le.orig_glb_purpose_ALLOW_ErrorCount,le.orig_glb_purpose_LENGTHS_ErrorCount,le.orig_glb_purpose_WORDS_ErrorCount
          ,le.orig_report_options_ALLOW_ErrorCount,le.orig_report_options_WORDS_ErrorCount
          ,le.orig_unused_LEFTTRIM_ErrorCount,le.orig_unused_ALLOW_ErrorCount,le.orig_unused_LENGTHS_ErrorCount,le.orig_unused_WORDS_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_ALLOW_ErrorCount,le.orig_login_history_id_LENGTHS_ErrorCount,le.orig_login_history_id_WORDS_ErrorCount
          ,le.orig_aseid_LEFTTRIM_ErrorCount,le.orig_aseid_ALLOW_ErrorCount,le.orig_aseid_LENGTHS_ErrorCount,le.orig_aseid_WORDS_ErrorCount
          ,le.orig_years_LEFTTRIM_ErrorCount,le.orig_years_ALLOW_ErrorCount,le.orig_years_LENGTHS_ErrorCount,le.orig_years_WORDS_ErrorCount
          ,le.orig_ip_address_ALLOW_ErrorCount,le.orig_ip_address_WORDS_ErrorCount
          ,le.orig_source_code_LEFTTRIM_ErrorCount,le.orig_source_code_ALLOW_ErrorCount,le.orig_source_code_LENGTHS_ErrorCount,le.orig_source_code_WORDS_ErrorCount
          ,le.orig_retail_price_LEFTTRIM_ErrorCount,le.orig_retail_price_LENGTHS_ErrorCount,le.orig_retail_price_WORDS_ErrorCount
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
          ,le.orig_end_user_id_ALLOW_ErrorCount
          ,le.orig_loginid_ALLOW_ErrorCount,le.orig_loginid_WORDS_ErrorCount
          ,le.orig_billing_code_ALLOW_ErrorCount,le.orig_billing_code_WORDS_ErrorCount
          ,le.orig_transaction_id_ALLOW_ErrorCount,le.orig_transaction_id_WORDS_ErrorCount
          ,le.orig_transaction_type_LEFTTRIM_ErrorCount,le.orig_transaction_type_ALLOW_ErrorCount,le.orig_transaction_type_LENGTHS_ErrorCount,le.orig_transaction_type_WORDS_ErrorCount
          ,le.orig_neighbors_LEFTTRIM_ErrorCount,le.orig_neighbors_ALLOW_ErrorCount,le.orig_neighbors_LENGTHS_ErrorCount,le.orig_neighbors_WORDS_ErrorCount
          ,le.orig_relatives_LEFTTRIM_ErrorCount,le.orig_relatives_ALLOW_ErrorCount,le.orig_relatives_LENGTHS_ErrorCount,le.orig_relatives_WORDS_ErrorCount
          ,le.orig_associates_LEFTTRIM_ErrorCount,le.orig_associates_ALLOW_ErrorCount,le.orig_associates_LENGTHS_ErrorCount,le.orig_associates_WORDS_ErrorCount
          ,le.orig_property_LEFTTRIM_ErrorCount,le.orig_property_ALLOW_ErrorCount,le.orig_property_LENGTHS_ErrorCount,le.orig_property_WORDS_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_ALLOW_ErrorCount,le.orig_company_id_LENGTHS_ErrorCount,le.orig_company_id_WORDS_ErrorCount
          ,le.orig_reference_code_ALLOW_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_address_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTHS_ErrorCount,le.orig_zip_WORDS_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_LENGTHS_ErrorCount,le.orig_zip4_WORDS_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTHS_ErrorCount,le.orig_phone_WORDS_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_ALLOW_ErrorCount,le.orig_ssn_LENGTHS_ErrorCount,le.orig_ssn_WORDS_ErrorCount
          ,le.orig_free_LEFTTRIM_ErrorCount,le.orig_free_ALLOW_ErrorCount,le.orig_free_LENGTHS_ErrorCount,le.orig_free_WORDS_ErrorCount
          ,le.orig_record_count_ALLOW_ErrorCount,le.orig_record_count_WORDS_ErrorCount
          ,le.orig_price_ALLOW_ErrorCount,le.orig_price_LENGTHS_ErrorCount,le.orig_price_WORDS_ErrorCount
          ,le.orig_bankruptcy_LEFTTRIM_ErrorCount,le.orig_bankruptcy_ALLOW_ErrorCount,le.orig_bankruptcy_LENGTHS_ErrorCount,le.orig_bankruptcy_WORDS_ErrorCount
          ,le.orig_transaction_code_LEFTTRIM_ErrorCount,le.orig_transaction_code_ALLOW_ErrorCount,le.orig_transaction_code_LENGTHS_ErrorCount,le.orig_transaction_code_WORDS_ErrorCount
          ,le.orig_dateadded_LEFTTRIM_ErrorCount,le.orig_dateadded_ALLOW_ErrorCount,le.orig_dateadded_LENGTHS_ErrorCount,le.orig_dateadded_WORDS_ErrorCount
          ,le.orig_full_name_ALLOW_ErrorCount,le.orig_full_name_WORDS_ErrorCount
          ,le.orig_billingdate_LEFTTRIM_ErrorCount,le.orig_billingdate_ALLOW_ErrorCount,le.orig_billingdate_LENGTHS_ErrorCount,le.orig_billingdate_WORDS_ErrorCount
          ,le.orig_business_name_ALLOW_ErrorCount,le.orig_business_name_WORDS_ErrorCount
          ,le.orig_pricing_error_code_LEFTTRIM_ErrorCount,le.orig_pricing_error_code_ALLOW_ErrorCount,le.orig_pricing_error_code_LENGTHS_ErrorCount,le.orig_pricing_error_code_WORDS_ErrorCount
          ,le.orig_dl_purpose_LEFTTRIM_ErrorCount,le.orig_dl_purpose_ALLOW_ErrorCount,le.orig_dl_purpose_LENGTHS_ErrorCount,le.orig_dl_purpose_WORDS_ErrorCount
          ,le.orig_result_format_LEFTTRIM_ErrorCount,le.orig_result_format_ALLOW_ErrorCount,le.orig_result_format_LENGTHS_ErrorCount,le.orig_result_format_WORDS_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_ALLOW_ErrorCount,le.orig_dob_LENGTHS_ErrorCount,le.orig_dob_WORDS_ErrorCount
          ,le.orig_unique_id_ALLOW_ErrorCount,le.orig_unique_id_WORDS_ErrorCount
          ,le.orig_dls_LEFTTRIM_ErrorCount,le.orig_dls_ALLOW_ErrorCount,le.orig_dls_LENGTHS_ErrorCount,le.orig_dls_WORDS_ErrorCount
          ,le.orig_mvs_LEFTTRIM_ErrorCount,le.orig_mvs_ALLOW_ErrorCount,le.orig_mvs_LENGTHS_ErrorCount,le.orig_mvs_WORDS_ErrorCount
          ,le.orig_function_name_ALLOW_ErrorCount,le.orig_function_name_WORDS_ErrorCount
          ,le.orig_response_time_LEFTTRIM_ErrorCount,le.orig_response_time_LENGTHS_ErrorCount,le.orig_response_time_WORDS_ErrorCount
          ,le.orig_data_source_LEFTTRIM_ErrorCount,le.orig_data_source_ALLOW_ErrorCount,le.orig_data_source_LENGTHS_ErrorCount,le.orig_data_source_WORDS_ErrorCount
          ,le.orig_glb_purpose_LEFTTRIM_ErrorCount,le.orig_glb_purpose_ALLOW_ErrorCount,le.orig_glb_purpose_LENGTHS_ErrorCount,le.orig_glb_purpose_WORDS_ErrorCount
          ,le.orig_report_options_ALLOW_ErrorCount,le.orig_report_options_WORDS_ErrorCount
          ,le.orig_unused_LEFTTRIM_ErrorCount,le.orig_unused_ALLOW_ErrorCount,le.orig_unused_LENGTHS_ErrorCount,le.orig_unused_WORDS_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_ALLOW_ErrorCount,le.orig_login_history_id_LENGTHS_ErrorCount,le.orig_login_history_id_WORDS_ErrorCount
          ,le.orig_aseid_LEFTTRIM_ErrorCount,le.orig_aseid_ALLOW_ErrorCount,le.orig_aseid_LENGTHS_ErrorCount,le.orig_aseid_WORDS_ErrorCount
          ,le.orig_years_LEFTTRIM_ErrorCount,le.orig_years_ALLOW_ErrorCount,le.orig_years_LENGTHS_ErrorCount,le.orig_years_WORDS_ErrorCount
          ,le.orig_ip_address_ALLOW_ErrorCount,le.orig_ip_address_WORDS_ErrorCount
          ,le.orig_source_code_LEFTTRIM_ErrorCount,le.orig_source_code_ALLOW_ErrorCount,le.orig_source_code_LENGTHS_ErrorCount,le.orig_source_code_WORDS_ErrorCount
          ,le.orig_retail_price_LEFTTRIM_ErrorCount,le.orig_retail_price_LENGTHS_ErrorCount,le.orig_retail_price_WORDS_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
          ,'orig_end_user_id:' + getFieldTypeText(h.orig_end_user_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_loginid:' + getFieldTypeText(h.orig_loginid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_billing_code:' + getFieldTypeText(h.orig_billing_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_transaction_id:' + getFieldTypeText(h.orig_transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_transaction_type:' + getFieldTypeText(h.orig_transaction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_neighbors:' + getFieldTypeText(h.orig_neighbors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_relatives:' + getFieldTypeText(h.orig_relatives) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_associates:' + getFieldTypeText(h.orig_associates) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_property:' + getFieldTypeText(h.orig_property) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_id:' + getFieldTypeText(h.orig_company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_reference_code:' + getFieldTypeText(h.orig_reference_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone:' + getFieldTypeText(h.orig_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_free:' + getFieldTypeText(h.orig_free) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_record_count:' + getFieldTypeText(h.orig_record_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_price:' + getFieldTypeText(h.orig_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_bankruptcy:' + getFieldTypeText(h.orig_bankruptcy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_transaction_code:' + getFieldTypeText(h.orig_transaction_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dateadded:' + getFieldTypeText(h.orig_dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_full_name:' + getFieldTypeText(h.orig_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_billingdate:' + getFieldTypeText(h.orig_billingdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_business_name:' + getFieldTypeText(h.orig_business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pricing_error_code:' + getFieldTypeText(h.orig_pricing_error_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_purpose:' + getFieldTypeText(h.orig_dl_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_result_format:' + getFieldTypeText(h.orig_result_format) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unique_id:' + getFieldTypeText(h.orig_unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dls:' + getFieldTypeText(h.orig_dls) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mvs:' + getFieldTypeText(h.orig_mvs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_function_name:' + getFieldTypeText(h.orig_function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_response_time:' + getFieldTypeText(h.orig_response_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_data_source:' + getFieldTypeText(h.orig_data_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_glb_purpose:' + getFieldTypeText(h.orig_glb_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_report_options:' + getFieldTypeText(h.orig_report_options) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unused:' + getFieldTypeText(h.orig_unused) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_login_history_id:' + getFieldTypeText(h.orig_login_history_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_aseid:' + getFieldTypeText(h.orig_aseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_years:' + getFieldTypeText(h.orig_years) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ip_address:' + getFieldTypeText(h.orig_ip_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_source_code:' + getFieldTypeText(h.orig_source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_retail_price:' + getFieldTypeText(h.orig_retail_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_end_user_id_cnt
          ,le.populated_orig_loginid_cnt
          ,le.populated_orig_billing_code_cnt
          ,le.populated_orig_transaction_id_cnt
          ,le.populated_orig_transaction_type_cnt
          ,le.populated_orig_neighbors_cnt
          ,le.populated_orig_relatives_cnt
          ,le.populated_orig_associates_cnt
          ,le.populated_orig_property_cnt
          ,le.populated_orig_company_id_cnt
          ,le.populated_orig_reference_code_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_phone_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_free_cnt
          ,le.populated_orig_record_count_cnt
          ,le.populated_orig_price_cnt
          ,le.populated_orig_bankruptcy_cnt
          ,le.populated_orig_transaction_code_cnt
          ,le.populated_orig_dateadded_cnt
          ,le.populated_orig_full_name_cnt
          ,le.populated_orig_billingdate_cnt
          ,le.populated_orig_business_name_cnt
          ,le.populated_orig_pricing_error_code_cnt
          ,le.populated_orig_dl_purpose_cnt
          ,le.populated_orig_result_format_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_unique_id_cnt
          ,le.populated_orig_dls_cnt
          ,le.populated_orig_mvs_cnt
          ,le.populated_orig_function_name_cnt
          ,le.populated_orig_response_time_cnt
          ,le.populated_orig_data_source_cnt
          ,le.populated_orig_glb_purpose_cnt
          ,le.populated_orig_report_options_cnt
          ,le.populated_orig_unused_cnt
          ,le.populated_orig_login_history_id_cnt
          ,le.populated_orig_aseid_cnt
          ,le.populated_orig_years_cnt
          ,le.populated_orig_ip_address_cnt
          ,le.populated_orig_source_code_cnt
          ,le.populated_orig_retail_price_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_end_user_id_pcnt
          ,le.populated_orig_loginid_pcnt
          ,le.populated_orig_billing_code_pcnt
          ,le.populated_orig_transaction_id_pcnt
          ,le.populated_orig_transaction_type_pcnt
          ,le.populated_orig_neighbors_pcnt
          ,le.populated_orig_relatives_pcnt
          ,le.populated_orig_associates_pcnt
          ,le.populated_orig_property_pcnt
          ,le.populated_orig_company_id_pcnt
          ,le.populated_orig_reference_code_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_phone_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_free_pcnt
          ,le.populated_orig_record_count_pcnt
          ,le.populated_orig_price_pcnt
          ,le.populated_orig_bankruptcy_pcnt
          ,le.populated_orig_transaction_code_pcnt
          ,le.populated_orig_dateadded_pcnt
          ,le.populated_orig_full_name_pcnt
          ,le.populated_orig_billingdate_pcnt
          ,le.populated_orig_business_name_pcnt
          ,le.populated_orig_pricing_error_code_pcnt
          ,le.populated_orig_dl_purpose_pcnt
          ,le.populated_orig_result_format_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_unique_id_pcnt
          ,le.populated_orig_dls_pcnt
          ,le.populated_orig_mvs_pcnt
          ,le.populated_orig_function_name_pcnt
          ,le.populated_orig_response_time_pcnt
          ,le.populated_orig_data_source_pcnt
          ,le.populated_orig_glb_purpose_pcnt
          ,le.populated_orig_report_options_pcnt
          ,le.populated_orig_unused_pcnt
          ,le.populated_orig_login_history_id_pcnt
          ,le.populated_orig_aseid_pcnt
          ,le.populated_orig_years_pcnt
          ,le.populated_orig_ip_address_pcnt
          ,le.populated_orig_source_code_pcnt
          ,le.populated_orig_retail_price_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,49,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),49,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
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
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inql_Nfcra_Custom, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
