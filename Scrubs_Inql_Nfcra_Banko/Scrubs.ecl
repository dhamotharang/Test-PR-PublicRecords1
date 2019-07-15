IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 80;
  EXPORT NumRulesFromFieldType := 80;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 40;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 orig_transaction_id_Invalid;
    UNSIGNED1 orig_function_name_Invalid;
    UNSIGNED1 orig_company_id_Invalid;
    UNSIGNED1 orig_login_id_Invalid;
    UNSIGNED1 orig_billing_code_Invalid;
    UNSIGNED1 orig_record_count_Invalid;
    UNSIGNED1 orig_fcra_purpose_Invalid;
    UNSIGNED1 orig_glb_purpose_Invalid;
    UNSIGNED1 orig_dppa_purpose_Invalid;
    UNSIGNED1 orig_ip_address_Invalid;
    UNSIGNED1 orig_reference_code_Invalid;
    UNSIGNED1 orig_login_history_id_Invalid;
    UNSIGNED1 orig_date_added_Invalid;
    UNSIGNED1 orig_price_Invalid;
    UNSIGNED1 orig_pricing_error_code_Invalid;
    UNSIGNED1 orig_free_Invalid;
    UNSIGNED1 orig_business_name_Invalid;
    UNSIGNED1 orig_name_first_Invalid;
    UNSIGNED1 orig_name_last_Invalid;
    UNSIGNED1 orig_ssn_Invalid;
    UNSIGNED1 orig_case_number_Invalid;
    UNSIGNED1 orig_address_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_phone_Invalid;
    UNSIGNED1 orig_tmsid_Invalid;
    UNSIGNED1 orig_unique_id_Invalid;
    UNSIGNED1 orig_out_tmsid_Invalid;
    UNSIGNED1 orig_out_business_name_Invalid;
    UNSIGNED1 orig_out_first_name_Invalid;
    UNSIGNED1 orig_out_last_name_Invalid;
    UNSIGNED1 orig_out_ssn_Invalid;
    UNSIGNED1 orig_out_address_Invalid;
    UNSIGNED1 orig_out_city_Invalid;
    UNSIGNED1 orig_out_state_Invalid;
    UNSIGNED1 orig_out_zip_Invalid;
    UNSIGNED1 orig_out_case_number_Invalid;
    UNSIGNED1 orig_transaction_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_transaction_id_Invalid := Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id);
    SELF.orig_function_name_Invalid := Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name);
    SELF.orig_company_id_Invalid := Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id);
    SELF.orig_login_id_Invalid := Fields.InValid_orig_login_id((SALT39.StrType)le.orig_login_id);
    SELF.orig_billing_code_Invalid := Fields.InValid_orig_billing_code((SALT39.StrType)le.orig_billing_code);
    SELF.orig_record_count_Invalid := Fields.InValid_orig_record_count((SALT39.StrType)le.orig_record_count);
    SELF.orig_fcra_purpose_Invalid := Fields.InValid_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose);
    SELF.orig_glb_purpose_Invalid := Fields.InValid_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose);
    SELF.orig_dppa_purpose_Invalid := Fields.InValid_orig_dppa_purpose((SALT39.StrType)le.orig_dppa_purpose);
    SELF.orig_ip_address_Invalid := Fields.InValid_orig_ip_address((SALT39.StrType)le.orig_ip_address);
    SELF.orig_reference_code_Invalid := Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code);
    SELF.orig_login_history_id_Invalid := Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id);
    SELF.orig_date_added_Invalid := Fields.InValid_orig_date_added((SALT39.StrType)le.orig_date_added);
    SELF.orig_price_Invalid := Fields.InValid_orig_price((SALT39.StrType)le.orig_price);
    SELF.orig_pricing_error_code_Invalid := Fields.InValid_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code);
    SELF.orig_free_Invalid := Fields.InValid_orig_free((SALT39.StrType)le.orig_free);
    SELF.orig_business_name_Invalid := Fields.InValid_orig_business_name((SALT39.StrType)le.orig_business_name);
    SELF.orig_name_first_Invalid := Fields.InValid_orig_name_first((SALT39.StrType)le.orig_name_first);
    SELF.orig_name_last_Invalid := Fields.InValid_orig_name_last((SALT39.StrType)le.orig_name_last);
    SELF.orig_ssn_Invalid := Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn);
    SELF.orig_case_number_Invalid := Fields.InValid_orig_case_number((SALT39.StrType)le.orig_case_number);
    SELF.orig_address_Invalid := Fields.InValid_orig_address((SALT39.StrType)le.orig_address);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT39.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT39.StrType)le.orig_state);
    SELF.orig_zip_Invalid := Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob);
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone);
    SELF.orig_tmsid_Invalid := Fields.InValid_orig_tmsid((SALT39.StrType)le.orig_tmsid);
    SELF.orig_unique_id_Invalid := Fields.InValid_orig_unique_id((SALT39.StrType)le.orig_unique_id);
    SELF.orig_out_tmsid_Invalid := Fields.InValid_orig_out_tmsid((SALT39.StrType)le.orig_out_tmsid);
    SELF.orig_out_business_name_Invalid := Fields.InValid_orig_out_business_name((SALT39.StrType)le.orig_out_business_name);
    SELF.orig_out_first_name_Invalid := Fields.InValid_orig_out_first_name((SALT39.StrType)le.orig_out_first_name);
    SELF.orig_out_last_name_Invalid := Fields.InValid_orig_out_last_name((SALT39.StrType)le.orig_out_last_name);
    SELF.orig_out_ssn_Invalid := Fields.InValid_orig_out_ssn((SALT39.StrType)le.orig_out_ssn);
    SELF.orig_out_address_Invalid := Fields.InValid_orig_out_address((SALT39.StrType)le.orig_out_address);
    SELF.orig_out_city_Invalid := Fields.InValid_orig_out_city((SALT39.StrType)le.orig_out_city);
    SELF.orig_out_state_Invalid := Fields.InValid_orig_out_state((SALT39.StrType)le.orig_out_state);
    SELF.orig_out_zip_Invalid := Fields.InValid_orig_out_zip((SALT39.StrType)le.orig_out_zip);
    SELF.orig_out_case_number_Invalid := Fields.InValid_orig_out_case_number((SALT39.StrType)le.orig_out_case_number);
    SELF.orig_transaction_type_Invalid := Fields.InValid_orig_transaction_type((SALT39.StrType)le.orig_transaction_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_transaction_id_Invalid << 0 ) + ( le.orig_function_name_Invalid << 2 ) + ( le.orig_company_id_Invalid << 4 ) + ( le.orig_login_id_Invalid << 6 ) + ( le.orig_billing_code_Invalid << 8 ) + ( le.orig_record_count_Invalid << 10 ) + ( le.orig_fcra_purpose_Invalid << 12 ) + ( le.orig_glb_purpose_Invalid << 14 ) + ( le.orig_dppa_purpose_Invalid << 16 ) + ( le.orig_ip_address_Invalid << 18 ) + ( le.orig_reference_code_Invalid << 20 ) + ( le.orig_login_history_id_Invalid << 22 ) + ( le.orig_date_added_Invalid << 24 ) + ( le.orig_price_Invalid << 26 ) + ( le.orig_pricing_error_code_Invalid << 28 ) + ( le.orig_free_Invalid << 30 ) + ( le.orig_business_name_Invalid << 32 ) + ( le.orig_name_first_Invalid << 34 ) + ( le.orig_name_last_Invalid << 36 ) + ( le.orig_ssn_Invalid << 38 ) + ( le.orig_case_number_Invalid << 40 ) + ( le.orig_address_Invalid << 42 ) + ( le.orig_city_Invalid << 44 ) + ( le.orig_state_Invalid << 46 ) + ( le.orig_zip_Invalid << 48 ) + ( le.orig_dob_Invalid << 50 ) + ( le.orig_phone_Invalid << 52 ) + ( le.orig_tmsid_Invalid << 54 ) + ( le.orig_unique_id_Invalid << 56 ) + ( le.orig_out_tmsid_Invalid << 58 ) + ( le.orig_out_business_name_Invalid << 60 ) + ( le.orig_out_first_name_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.orig_out_last_name_Invalid << 0 ) + ( le.orig_out_ssn_Invalid << 2 ) + ( le.orig_out_address_Invalid << 4 ) + ( le.orig_out_city_Invalid << 6 ) + ( le.orig_out_state_Invalid << 8 ) + ( le.orig_out_zip_Invalid << 10 ) + ( le.orig_out_case_number_Invalid << 12 ) + ( le.orig_transaction_type_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_function_name_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_company_id_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.orig_login_id_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_billing_code_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.orig_record_count_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.orig_fcra_purpose_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.orig_glb_purpose_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.orig_dppa_purpose_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_ip_address_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.orig_reference_code_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.orig_login_history_id_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.orig_date_added_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.orig_price_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.orig_pricing_error_code_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.orig_free_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.orig_business_name_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.orig_name_first_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.orig_name_last_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.orig_ssn_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.orig_case_number_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.orig_address_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.orig_phone_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.orig_tmsid_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.orig_unique_id_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.orig_out_tmsid_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.orig_out_business_name_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.orig_out_first_name_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.orig_out_last_name_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.orig_out_ssn_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.orig_out_address_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.orig_out_city_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.orig_out_state_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.orig_out_zip_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.orig_out_case_number_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.orig_transaction_type_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_transaction_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=1);
    orig_transaction_id_QUOTES_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid=2);
    orig_transaction_id_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_id_Invalid>0);
    orig_function_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=1);
    orig_function_name_QUOTES_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid=2);
    orig_function_name_Total_ErrorCount := COUNT(GROUP,h.orig_function_name_Invalid>0);
    orig_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=1);
    orig_company_id_QUOTES_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid=2);
    orig_company_id_Total_ErrorCount := COUNT(GROUP,h.orig_company_id_Invalid>0);
    orig_login_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_login_id_Invalid=1);
    orig_login_id_QUOTES_ErrorCount := COUNT(GROUP,h.orig_login_id_Invalid=2);
    orig_login_id_Total_ErrorCount := COUNT(GROUP,h.orig_login_id_Invalid>0);
    orig_billing_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=1);
    orig_billing_code_QUOTES_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid=2);
    orig_billing_code_Total_ErrorCount := COUNT(GROUP,h.orig_billing_code_Invalid>0);
    orig_record_count_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=1);
    orig_record_count_QUOTES_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid=2);
    orig_record_count_Total_ErrorCount := COUNT(GROUP,h.orig_record_count_Invalid>0);
    orig_fcra_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=1);
    orig_fcra_purpose_QUOTES_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid=2);
    orig_fcra_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_fcra_purpose_Invalid>0);
    orig_glb_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=1);
    orig_glb_purpose_QUOTES_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid=2);
    orig_glb_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_glb_purpose_Invalid>0);
    orig_dppa_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dppa_purpose_Invalid=1);
    orig_dppa_purpose_QUOTES_ErrorCount := COUNT(GROUP,h.orig_dppa_purpose_Invalid=2);
    orig_dppa_purpose_Total_ErrorCount := COUNT(GROUP,h.orig_dppa_purpose_Invalid>0);
    orig_ip_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid=1);
    orig_ip_address_QUOTES_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid=2);
    orig_ip_address_Total_ErrorCount := COUNT(GROUP,h.orig_ip_address_Invalid>0);
    orig_reference_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=1);
    orig_reference_code_QUOTES_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid=2);
    orig_reference_code_Total_ErrorCount := COUNT(GROUP,h.orig_reference_code_Invalid>0);
    orig_login_history_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=1);
    orig_login_history_id_QUOTES_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid=2);
    orig_login_history_id_Total_ErrorCount := COUNT(GROUP,h.orig_login_history_id_Invalid>0);
    orig_date_added_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid=1);
    orig_date_added_QUOTES_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid=2);
    orig_date_added_Total_ErrorCount := COUNT(GROUP,h.orig_date_added_Invalid>0);
    orig_price_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=1);
    orig_price_QUOTES_ErrorCount := COUNT(GROUP,h.orig_price_Invalid=2);
    orig_price_Total_ErrorCount := COUNT(GROUP,h.orig_price_Invalid>0);
    orig_pricing_error_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=1);
    orig_pricing_error_code_QUOTES_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid=2);
    orig_pricing_error_code_Total_ErrorCount := COUNT(GROUP,h.orig_pricing_error_code_Invalid>0);
    orig_free_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=1);
    orig_free_QUOTES_ErrorCount := COUNT(GROUP,h.orig_free_Invalid=2);
    orig_free_Total_ErrorCount := COUNT(GROUP,h.orig_free_Invalid>0);
    orig_business_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=1);
    orig_business_name_QUOTES_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid=2);
    orig_business_name_Total_ErrorCount := COUNT(GROUP,h.orig_business_name_Invalid>0);
    orig_name_first_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_name_first_Invalid=1);
    orig_name_first_QUOTES_ErrorCount := COUNT(GROUP,h.orig_name_first_Invalid=2);
    orig_name_first_Total_ErrorCount := COUNT(GROUP,h.orig_name_first_Invalid>0);
    orig_name_last_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_name_last_Invalid=1);
    orig_name_last_QUOTES_ErrorCount := COUNT(GROUP,h.orig_name_last_Invalid=2);
    orig_name_last_Total_ErrorCount := COUNT(GROUP,h.orig_name_last_Invalid>0);
    orig_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=1);
    orig_ssn_QUOTES_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid=2);
    orig_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_ssn_Invalid>0);
    orig_case_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid=1);
    orig_case_number_QUOTES_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid=2);
    orig_case_number_Total_ErrorCount := COUNT(GROUP,h.orig_case_number_Invalid>0);
    orig_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=1);
    orig_address_QUOTES_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=2);
    orig_address_Total_ErrorCount := COUNT(GROUP,h.orig_address_Invalid>0);
    orig_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_QUOTES_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_QUOTES_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_QUOTES_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_QUOTES_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_QUOTES_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    orig_tmsid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_tmsid_Invalid=1);
    orig_tmsid_QUOTES_ErrorCount := COUNT(GROUP,h.orig_tmsid_Invalid=2);
    orig_tmsid_Total_ErrorCount := COUNT(GROUP,h.orig_tmsid_Invalid>0);
    orig_unique_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=1);
    orig_unique_id_QUOTES_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid=2);
    orig_unique_id_Total_ErrorCount := COUNT(GROUP,h.orig_unique_id_Invalid>0);
    orig_out_tmsid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_tmsid_Invalid=1);
    orig_out_tmsid_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_tmsid_Invalid=2);
    orig_out_tmsid_Total_ErrorCount := COUNT(GROUP,h.orig_out_tmsid_Invalid>0);
    orig_out_business_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_business_name_Invalid=1);
    orig_out_business_name_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_business_name_Invalid=2);
    orig_out_business_name_Total_ErrorCount := COUNT(GROUP,h.orig_out_business_name_Invalid>0);
    orig_out_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_first_name_Invalid=1);
    orig_out_first_name_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_first_name_Invalid=2);
    orig_out_first_name_Total_ErrorCount := COUNT(GROUP,h.orig_out_first_name_Invalid>0);
    orig_out_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_last_name_Invalid=1);
    orig_out_last_name_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_last_name_Invalid=2);
    orig_out_last_name_Total_ErrorCount := COUNT(GROUP,h.orig_out_last_name_Invalid>0);
    orig_out_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_ssn_Invalid=1);
    orig_out_ssn_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_ssn_Invalid=2);
    orig_out_ssn_Total_ErrorCount := COUNT(GROUP,h.orig_out_ssn_Invalid>0);
    orig_out_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_address_Invalid=1);
    orig_out_address_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_address_Invalid=2);
    orig_out_address_Total_ErrorCount := COUNT(GROUP,h.orig_out_address_Invalid>0);
    orig_out_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_city_Invalid=1);
    orig_out_city_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_city_Invalid=2);
    orig_out_city_Total_ErrorCount := COUNT(GROUP,h.orig_out_city_Invalid>0);
    orig_out_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_state_Invalid=1);
    orig_out_state_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_state_Invalid=2);
    orig_out_state_Total_ErrorCount := COUNT(GROUP,h.orig_out_state_Invalid>0);
    orig_out_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_zip_Invalid=1);
    orig_out_zip_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_zip_Invalid=2);
    orig_out_zip_Total_ErrorCount := COUNT(GROUP,h.orig_out_zip_Invalid>0);
    orig_out_case_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_out_case_number_Invalid=1);
    orig_out_case_number_QUOTES_ErrorCount := COUNT(GROUP,h.orig_out_case_number_Invalid=2);
    orig_out_case_number_Total_ErrorCount := COUNT(GROUP,h.orig_out_case_number_Invalid>0);
    orig_transaction_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=1);
    orig_transaction_type_QUOTES_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid=2);
    orig_transaction_type_Total_ErrorCount := COUNT(GROUP,h.orig_transaction_type_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_transaction_id_Invalid > 0 OR h.orig_function_name_Invalid > 0 OR h.orig_company_id_Invalid > 0 OR h.orig_login_id_Invalid > 0 OR h.orig_billing_code_Invalid > 0 OR h.orig_record_count_Invalid > 0 OR h.orig_fcra_purpose_Invalid > 0 OR h.orig_glb_purpose_Invalid > 0 OR h.orig_dppa_purpose_Invalid > 0 OR h.orig_ip_address_Invalid > 0 OR h.orig_reference_code_Invalid > 0 OR h.orig_login_history_id_Invalid > 0 OR h.orig_date_added_Invalid > 0 OR h.orig_price_Invalid > 0 OR h.orig_pricing_error_code_Invalid > 0 OR h.orig_free_Invalid > 0 OR h.orig_business_name_Invalid > 0 OR h.orig_name_first_Invalid > 0 OR h.orig_name_last_Invalid > 0 OR h.orig_ssn_Invalid > 0 OR h.orig_case_number_Invalid > 0 OR h.orig_address_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_phone_Invalid > 0 OR h.orig_tmsid_Invalid > 0 OR h.orig_unique_id_Invalid > 0 OR h.orig_out_tmsid_Invalid > 0 OR h.orig_out_business_name_Invalid > 0 OR h.orig_out_first_name_Invalid > 0 OR h.orig_out_last_name_Invalid > 0 OR h.orig_out_ssn_Invalid > 0 OR h.orig_out_address_Invalid > 0 OR h.orig_out_city_Invalid > 0 OR h.orig_out_state_Invalid > 0 OR h.orig_out_zip_Invalid > 0 OR h.orig_out_case_number_Invalid > 0 OR h.orig_transaction_type_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_transaction_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_login_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_purpose_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_Total_ErrorCount > 0, 1, 0) + IF(le.orig_price_Total_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_Total_ErrorCount > 0, 1, 0) + IF(le.orig_free_Total_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_name_first_Total_ErrorCount > 0, 1, 0) + IF(le.orig_name_last_Total_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_case_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_dob_Total_ErrorCount > 0, 1, 0) + IF(le.orig_phone_Total_ErrorCount > 0, 1, 0) + IF(le.orig_tmsid_Total_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_tmsid_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_business_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_first_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_last_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_address_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_out_case_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_transaction_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_id_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_function_name_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_company_id_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_login_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_login_id_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_billing_code_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_record_count_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fcra_purpose_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_glb_purpose_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_purpose_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dppa_purpose_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ip_address_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_reference_code_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_login_history_id_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_date_added_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_price_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_price_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_pricing_error_code_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_free_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_free_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_business_name_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_name_first_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_name_first_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_name_last_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_name_last_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_ssn_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_case_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_case_number_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_city_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_state_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_dob_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_phone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_phone_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_tmsid_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_tmsid_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_unique_id_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_tmsid_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_tmsid_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_business_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_business_name_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_first_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_first_name_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_last_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_last_name_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_ssn_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_ssn_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_address_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_address_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_city_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_state_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_zip_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_out_case_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_out_case_number_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_transaction_type_QUOTES_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_transaction_id_Invalid,le.orig_function_name_Invalid,le.orig_company_id_Invalid,le.orig_login_id_Invalid,le.orig_billing_code_Invalid,le.orig_record_count_Invalid,le.orig_fcra_purpose_Invalid,le.orig_glb_purpose_Invalid,le.orig_dppa_purpose_Invalid,le.orig_ip_address_Invalid,le.orig_reference_code_Invalid,le.orig_login_history_id_Invalid,le.orig_date_added_Invalid,le.orig_price_Invalid,le.orig_pricing_error_code_Invalid,le.orig_free_Invalid,le.orig_business_name_Invalid,le.orig_name_first_Invalid,le.orig_name_last_Invalid,le.orig_ssn_Invalid,le.orig_case_number_Invalid,le.orig_address_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_dob_Invalid,le.orig_phone_Invalid,le.orig_tmsid_Invalid,le.orig_unique_id_Invalid,le.orig_out_tmsid_Invalid,le.orig_out_business_name_Invalid,le.orig_out_first_name_Invalid,le.orig_out_last_name_Invalid,le.orig_out_ssn_Invalid,le.orig_out_address_Invalid,le.orig_out_city_Invalid,le.orig_out_state_Invalid,le.orig_out_zip_Invalid,le.orig_out_case_number_Invalid,le.orig_transaction_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_transaction_id(le.orig_transaction_id_Invalid),Fields.InvalidMessage_orig_function_name(le.orig_function_name_Invalid),Fields.InvalidMessage_orig_company_id(le.orig_company_id_Invalid),Fields.InvalidMessage_orig_login_id(le.orig_login_id_Invalid),Fields.InvalidMessage_orig_billing_code(le.orig_billing_code_Invalid),Fields.InvalidMessage_orig_record_count(le.orig_record_count_Invalid),Fields.InvalidMessage_orig_fcra_purpose(le.orig_fcra_purpose_Invalid),Fields.InvalidMessage_orig_glb_purpose(le.orig_glb_purpose_Invalid),Fields.InvalidMessage_orig_dppa_purpose(le.orig_dppa_purpose_Invalid),Fields.InvalidMessage_orig_ip_address(le.orig_ip_address_Invalid),Fields.InvalidMessage_orig_reference_code(le.orig_reference_code_Invalid),Fields.InvalidMessage_orig_login_history_id(le.orig_login_history_id_Invalid),Fields.InvalidMessage_orig_date_added(le.orig_date_added_Invalid),Fields.InvalidMessage_orig_price(le.orig_price_Invalid),Fields.InvalidMessage_orig_pricing_error_code(le.orig_pricing_error_code_Invalid),Fields.InvalidMessage_orig_free(le.orig_free_Invalid),Fields.InvalidMessage_orig_business_name(le.orig_business_name_Invalid),Fields.InvalidMessage_orig_name_first(le.orig_name_first_Invalid),Fields.InvalidMessage_orig_name_last(le.orig_name_last_Invalid),Fields.InvalidMessage_orig_ssn(le.orig_ssn_Invalid),Fields.InvalidMessage_orig_case_number(le.orig_case_number_Invalid),Fields.InvalidMessage_orig_address(le.orig_address_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_orig_tmsid(le.orig_tmsid_Invalid),Fields.InvalidMessage_orig_unique_id(le.orig_unique_id_Invalid),Fields.InvalidMessage_orig_out_tmsid(le.orig_out_tmsid_Invalid),Fields.InvalidMessage_orig_out_business_name(le.orig_out_business_name_Invalid),Fields.InvalidMessage_orig_out_first_name(le.orig_out_first_name_Invalid),Fields.InvalidMessage_orig_out_last_name(le.orig_out_last_name_Invalid),Fields.InvalidMessage_orig_out_ssn(le.orig_out_ssn_Invalid),Fields.InvalidMessage_orig_out_address(le.orig_out_address_Invalid),Fields.InvalidMessage_orig_out_city(le.orig_out_city_Invalid),Fields.InvalidMessage_orig_out_state(le.orig_out_state_Invalid),Fields.InvalidMessage_orig_out_zip(le.orig_out_zip_Invalid),Fields.InvalidMessage_orig_out_case_number(le.orig_out_case_number_Invalid),Fields.InvalidMessage_orig_transaction_type(le.orig_transaction_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_transaction_id_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_function_name_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_company_id_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_login_id_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_billing_code_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_record_count_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_fcra_purpose_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_glb_purpose_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_dppa_purpose_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_ip_address_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_reference_code_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_login_history_id_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_date_added_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_price_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_pricing_error_code_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_free_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_business_name_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_name_first_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_name_last_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_ssn_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_case_number_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_address_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_phone_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_tmsid_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_unique_id_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_tmsid_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_business_name_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_first_name_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_last_name_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_ssn_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_address_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_city_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_state_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_zip_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_out_case_number_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.orig_transaction_type_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_transaction_id','orig_function_name','orig_company_id','orig_login_id','orig_billing_code','orig_record_count','orig_fcra_purpose','orig_glb_purpose','orig_dppa_purpose','orig_ip_address','orig_reference_code','orig_login_history_id','orig_date_added','orig_price','orig_pricing_error_code','orig_free','orig_business_name','orig_name_first','orig_name_last','orig_ssn','orig_case_number','orig_address','orig_city','orig_state','orig_zip','orig_dob','orig_phone','orig_tmsid','orig_unique_id','orig_out_tmsid','orig_out_business_name','orig_out_first_name','orig_out_last_name','orig_out_ssn','orig_out_address','orig_out_city','orig_out_state','orig_out_zip','orig_out_case_number','orig_transaction_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.orig_transaction_id,(SALT39.StrType)le.orig_function_name,(SALT39.StrType)le.orig_company_id,(SALT39.StrType)le.orig_login_id,(SALT39.StrType)le.orig_billing_code,(SALT39.StrType)le.orig_record_count,(SALT39.StrType)le.orig_fcra_purpose,(SALT39.StrType)le.orig_glb_purpose,(SALT39.StrType)le.orig_dppa_purpose,(SALT39.StrType)le.orig_ip_address,(SALT39.StrType)le.orig_reference_code,(SALT39.StrType)le.orig_login_history_id,(SALT39.StrType)le.orig_date_added,(SALT39.StrType)le.orig_price,(SALT39.StrType)le.orig_pricing_error_code,(SALT39.StrType)le.orig_free,(SALT39.StrType)le.orig_business_name,(SALT39.StrType)le.orig_name_first,(SALT39.StrType)le.orig_name_last,(SALT39.StrType)le.orig_ssn,(SALT39.StrType)le.orig_case_number,(SALT39.StrType)le.orig_address,(SALT39.StrType)le.orig_city,(SALT39.StrType)le.orig_state,(SALT39.StrType)le.orig_zip,(SALT39.StrType)le.orig_dob,(SALT39.StrType)le.orig_phone,(SALT39.StrType)le.orig_tmsid,(SALT39.StrType)le.orig_unique_id,(SALT39.StrType)le.orig_out_tmsid,(SALT39.StrType)le.orig_out_business_name,(SALT39.StrType)le.orig_out_first_name,(SALT39.StrType)le.orig_out_last_name,(SALT39.StrType)le.orig_out_ssn,(SALT39.StrType)le.orig_out_address,(SALT39.StrType)le.orig_out_city,(SALT39.StrType)le.orig_out_state,(SALT39.StrType)le.orig_out_zip,(SALT39.StrType)le.orig_out_case_number,(SALT39.StrType)le.orig_transaction_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,40,Into(LEFT,COUNTER));
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
          ,'orig_transaction_id:DEFAULT:LEFTTRIM','orig_transaction_id:DEFAULT:QUOTES'
          ,'orig_function_name:DEFAULT:LEFTTRIM','orig_function_name:DEFAULT:QUOTES'
          ,'orig_company_id:DEFAULT:LEFTTRIM','orig_company_id:DEFAULT:QUOTES'
          ,'orig_login_id:DEFAULT:LEFTTRIM','orig_login_id:DEFAULT:QUOTES'
          ,'orig_billing_code:DEFAULT:LEFTTRIM','orig_billing_code:DEFAULT:QUOTES'
          ,'orig_record_count:DEFAULT:LEFTTRIM','orig_record_count:DEFAULT:QUOTES'
          ,'orig_fcra_purpose:DEFAULT:LEFTTRIM','orig_fcra_purpose:DEFAULT:QUOTES'
          ,'orig_glb_purpose:DEFAULT:LEFTTRIM','orig_glb_purpose:DEFAULT:QUOTES'
          ,'orig_dppa_purpose:DEFAULT:LEFTTRIM','orig_dppa_purpose:DEFAULT:QUOTES'
          ,'orig_ip_address:DEFAULT:LEFTTRIM','orig_ip_address:DEFAULT:QUOTES'
          ,'orig_reference_code:DEFAULT:LEFTTRIM','orig_reference_code:DEFAULT:QUOTES'
          ,'orig_login_history_id:DEFAULT:LEFTTRIM','orig_login_history_id:DEFAULT:QUOTES'
          ,'orig_date_added:DEFAULT:LEFTTRIM','orig_date_added:DEFAULT:QUOTES'
          ,'orig_price:DEFAULT:LEFTTRIM','orig_price:DEFAULT:QUOTES'
          ,'orig_pricing_error_code:DEFAULT:LEFTTRIM','orig_pricing_error_code:DEFAULT:QUOTES'
          ,'orig_free:DEFAULT:LEFTTRIM','orig_free:DEFAULT:QUOTES'
          ,'orig_business_name:DEFAULT:LEFTTRIM','orig_business_name:DEFAULT:QUOTES'
          ,'orig_name_first:DEFAULT:LEFTTRIM','orig_name_first:DEFAULT:QUOTES'
          ,'orig_name_last:DEFAULT:LEFTTRIM','orig_name_last:DEFAULT:QUOTES'
          ,'orig_ssn:DEFAULT:LEFTTRIM','orig_ssn:DEFAULT:QUOTES'
          ,'orig_case_number:DEFAULT:LEFTTRIM','orig_case_number:DEFAULT:QUOTES'
          ,'orig_address:DEFAULT:LEFTTRIM','orig_address:DEFAULT:QUOTES'
          ,'orig_city:DEFAULT:LEFTTRIM','orig_city:DEFAULT:QUOTES'
          ,'orig_state:DEFAULT:LEFTTRIM','orig_state:DEFAULT:QUOTES'
          ,'orig_zip:DEFAULT:LEFTTRIM','orig_zip:DEFAULT:QUOTES'
          ,'orig_dob:DEFAULT:LEFTTRIM','orig_dob:DEFAULT:QUOTES'
          ,'orig_phone:DEFAULT:LEFTTRIM','orig_phone:DEFAULT:QUOTES'
          ,'orig_tmsid:DEFAULT:LEFTTRIM','orig_tmsid:DEFAULT:QUOTES'
          ,'orig_unique_id:DEFAULT:LEFTTRIM','orig_unique_id:DEFAULT:QUOTES'
          ,'orig_out_tmsid:DEFAULT:LEFTTRIM','orig_out_tmsid:DEFAULT:QUOTES'
          ,'orig_out_business_name:DEFAULT:LEFTTRIM','orig_out_business_name:DEFAULT:QUOTES'
          ,'orig_out_first_name:DEFAULT:LEFTTRIM','orig_out_first_name:DEFAULT:QUOTES'
          ,'orig_out_last_name:DEFAULT:LEFTTRIM','orig_out_last_name:DEFAULT:QUOTES'
          ,'orig_out_ssn:DEFAULT:LEFTTRIM','orig_out_ssn:DEFAULT:QUOTES'
          ,'orig_out_address:DEFAULT:LEFTTRIM','orig_out_address:DEFAULT:QUOTES'
          ,'orig_out_city:DEFAULT:LEFTTRIM','orig_out_city:DEFAULT:QUOTES'
          ,'orig_out_state:DEFAULT:LEFTTRIM','orig_out_state:DEFAULT:QUOTES'
          ,'orig_out_zip:DEFAULT:LEFTTRIM','orig_out_zip:DEFAULT:QUOTES'
          ,'orig_out_case_number:DEFAULT:LEFTTRIM','orig_out_case_number:DEFAULT:QUOTES'
          ,'orig_transaction_type:DEFAULT:LEFTTRIM','orig_transaction_type:DEFAULT:QUOTES'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_orig_transaction_id(1),Fields.InvalidMessage_orig_transaction_id(2)
          ,Fields.InvalidMessage_orig_function_name(1),Fields.InvalidMessage_orig_function_name(2)
          ,Fields.InvalidMessage_orig_company_id(1),Fields.InvalidMessage_orig_company_id(2)
          ,Fields.InvalidMessage_orig_login_id(1),Fields.InvalidMessage_orig_login_id(2)
          ,Fields.InvalidMessage_orig_billing_code(1),Fields.InvalidMessage_orig_billing_code(2)
          ,Fields.InvalidMessage_orig_record_count(1),Fields.InvalidMessage_orig_record_count(2)
          ,Fields.InvalidMessage_orig_fcra_purpose(1),Fields.InvalidMessage_orig_fcra_purpose(2)
          ,Fields.InvalidMessage_orig_glb_purpose(1),Fields.InvalidMessage_orig_glb_purpose(2)
          ,Fields.InvalidMessage_orig_dppa_purpose(1),Fields.InvalidMessage_orig_dppa_purpose(2)
          ,Fields.InvalidMessage_orig_ip_address(1),Fields.InvalidMessage_orig_ip_address(2)
          ,Fields.InvalidMessage_orig_reference_code(1),Fields.InvalidMessage_orig_reference_code(2)
          ,Fields.InvalidMessage_orig_login_history_id(1),Fields.InvalidMessage_orig_login_history_id(2)
          ,Fields.InvalidMessage_orig_date_added(1),Fields.InvalidMessage_orig_date_added(2)
          ,Fields.InvalidMessage_orig_price(1),Fields.InvalidMessage_orig_price(2)
          ,Fields.InvalidMessage_orig_pricing_error_code(1),Fields.InvalidMessage_orig_pricing_error_code(2)
          ,Fields.InvalidMessage_orig_free(1),Fields.InvalidMessage_orig_free(2)
          ,Fields.InvalidMessage_orig_business_name(1),Fields.InvalidMessage_orig_business_name(2)
          ,Fields.InvalidMessage_orig_name_first(1),Fields.InvalidMessage_orig_name_first(2)
          ,Fields.InvalidMessage_orig_name_last(1),Fields.InvalidMessage_orig_name_last(2)
          ,Fields.InvalidMessage_orig_ssn(1),Fields.InvalidMessage_orig_ssn(2)
          ,Fields.InvalidMessage_orig_case_number(1),Fields.InvalidMessage_orig_case_number(2)
          ,Fields.InvalidMessage_orig_address(1),Fields.InvalidMessage_orig_address(2)
          ,Fields.InvalidMessage_orig_city(1),Fields.InvalidMessage_orig_city(2)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2)
          ,Fields.InvalidMessage_orig_zip(1),Fields.InvalidMessage_orig_zip(2)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2)
          ,Fields.InvalidMessage_orig_phone(1),Fields.InvalidMessage_orig_phone(2)
          ,Fields.InvalidMessage_orig_tmsid(1),Fields.InvalidMessage_orig_tmsid(2)
          ,Fields.InvalidMessage_orig_unique_id(1),Fields.InvalidMessage_orig_unique_id(2)
          ,Fields.InvalidMessage_orig_out_tmsid(1),Fields.InvalidMessage_orig_out_tmsid(2)
          ,Fields.InvalidMessage_orig_out_business_name(1),Fields.InvalidMessage_orig_out_business_name(2)
          ,Fields.InvalidMessage_orig_out_first_name(1),Fields.InvalidMessage_orig_out_first_name(2)
          ,Fields.InvalidMessage_orig_out_last_name(1),Fields.InvalidMessage_orig_out_last_name(2)
          ,Fields.InvalidMessage_orig_out_ssn(1),Fields.InvalidMessage_orig_out_ssn(2)
          ,Fields.InvalidMessage_orig_out_address(1),Fields.InvalidMessage_orig_out_address(2)
          ,Fields.InvalidMessage_orig_out_city(1),Fields.InvalidMessage_orig_out_city(2)
          ,Fields.InvalidMessage_orig_out_state(1),Fields.InvalidMessage_orig_out_state(2)
          ,Fields.InvalidMessage_orig_out_zip(1),Fields.InvalidMessage_orig_out_zip(2)
          ,Fields.InvalidMessage_orig_out_case_number(1),Fields.InvalidMessage_orig_out_case_number(2)
          ,Fields.InvalidMessage_orig_transaction_type(1),Fields.InvalidMessage_orig_transaction_type(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_transaction_id_LEFTTRIM_ErrorCount,le.orig_transaction_id_QUOTES_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_QUOTES_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_QUOTES_ErrorCount
          ,le.orig_login_id_LEFTTRIM_ErrorCount,le.orig_login_id_QUOTES_ErrorCount
          ,le.orig_billing_code_LEFTTRIM_ErrorCount,le.orig_billing_code_QUOTES_ErrorCount
          ,le.orig_record_count_LEFTTRIM_ErrorCount,le.orig_record_count_QUOTES_ErrorCount
          ,le.orig_fcra_purpose_LEFTTRIM_ErrorCount,le.orig_fcra_purpose_QUOTES_ErrorCount
          ,le.orig_glb_purpose_LEFTTRIM_ErrorCount,le.orig_glb_purpose_QUOTES_ErrorCount
          ,le.orig_dppa_purpose_LEFTTRIM_ErrorCount,le.orig_dppa_purpose_QUOTES_ErrorCount
          ,le.orig_ip_address_LEFTTRIM_ErrorCount,le.orig_ip_address_QUOTES_ErrorCount
          ,le.orig_reference_code_LEFTTRIM_ErrorCount,le.orig_reference_code_QUOTES_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_QUOTES_ErrorCount
          ,le.orig_date_added_LEFTTRIM_ErrorCount,le.orig_date_added_QUOTES_ErrorCount
          ,le.orig_price_LEFTTRIM_ErrorCount,le.orig_price_QUOTES_ErrorCount
          ,le.orig_pricing_error_code_LEFTTRIM_ErrorCount,le.orig_pricing_error_code_QUOTES_ErrorCount
          ,le.orig_free_LEFTTRIM_ErrorCount,le.orig_free_QUOTES_ErrorCount
          ,le.orig_business_name_LEFTTRIM_ErrorCount,le.orig_business_name_QUOTES_ErrorCount
          ,le.orig_name_first_LEFTTRIM_ErrorCount,le.orig_name_first_QUOTES_ErrorCount
          ,le.orig_name_last_LEFTTRIM_ErrorCount,le.orig_name_last_QUOTES_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_QUOTES_ErrorCount
          ,le.orig_case_number_LEFTTRIM_ErrorCount,le.orig_case_number_QUOTES_ErrorCount
          ,le.orig_address_LEFTTRIM_ErrorCount,le.orig_address_QUOTES_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_QUOTES_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_QUOTES_ErrorCount
          ,le.orig_zip_LEFTTRIM_ErrorCount,le.orig_zip_QUOTES_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_QUOTES_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_QUOTES_ErrorCount
          ,le.orig_tmsid_LEFTTRIM_ErrorCount,le.orig_tmsid_QUOTES_ErrorCount
          ,le.orig_unique_id_LEFTTRIM_ErrorCount,le.orig_unique_id_QUOTES_ErrorCount
          ,le.orig_out_tmsid_LEFTTRIM_ErrorCount,le.orig_out_tmsid_QUOTES_ErrorCount
          ,le.orig_out_business_name_LEFTTRIM_ErrorCount,le.orig_out_business_name_QUOTES_ErrorCount
          ,le.orig_out_first_name_LEFTTRIM_ErrorCount,le.orig_out_first_name_QUOTES_ErrorCount
          ,le.orig_out_last_name_LEFTTRIM_ErrorCount,le.orig_out_last_name_QUOTES_ErrorCount
          ,le.orig_out_ssn_LEFTTRIM_ErrorCount,le.orig_out_ssn_QUOTES_ErrorCount
          ,le.orig_out_address_LEFTTRIM_ErrorCount,le.orig_out_address_QUOTES_ErrorCount
          ,le.orig_out_city_LEFTTRIM_ErrorCount,le.orig_out_city_QUOTES_ErrorCount
          ,le.orig_out_state_LEFTTRIM_ErrorCount,le.orig_out_state_QUOTES_ErrorCount
          ,le.orig_out_zip_LEFTTRIM_ErrorCount,le.orig_out_zip_QUOTES_ErrorCount
          ,le.orig_out_case_number_LEFTTRIM_ErrorCount,le.orig_out_case_number_QUOTES_ErrorCount
          ,le.orig_transaction_type_LEFTTRIM_ErrorCount,le.orig_transaction_type_QUOTES_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.orig_transaction_id_LEFTTRIM_ErrorCount,le.orig_transaction_id_QUOTES_ErrorCount
          ,le.orig_function_name_LEFTTRIM_ErrorCount,le.orig_function_name_QUOTES_ErrorCount
          ,le.orig_company_id_LEFTTRIM_ErrorCount,le.orig_company_id_QUOTES_ErrorCount
          ,le.orig_login_id_LEFTTRIM_ErrorCount,le.orig_login_id_QUOTES_ErrorCount
          ,le.orig_billing_code_LEFTTRIM_ErrorCount,le.orig_billing_code_QUOTES_ErrorCount
          ,le.orig_record_count_LEFTTRIM_ErrorCount,le.orig_record_count_QUOTES_ErrorCount
          ,le.orig_fcra_purpose_LEFTTRIM_ErrorCount,le.orig_fcra_purpose_QUOTES_ErrorCount
          ,le.orig_glb_purpose_LEFTTRIM_ErrorCount,le.orig_glb_purpose_QUOTES_ErrorCount
          ,le.orig_dppa_purpose_LEFTTRIM_ErrorCount,le.orig_dppa_purpose_QUOTES_ErrorCount
          ,le.orig_ip_address_LEFTTRIM_ErrorCount,le.orig_ip_address_QUOTES_ErrorCount
          ,le.orig_reference_code_LEFTTRIM_ErrorCount,le.orig_reference_code_QUOTES_ErrorCount
          ,le.orig_login_history_id_LEFTTRIM_ErrorCount,le.orig_login_history_id_QUOTES_ErrorCount
          ,le.orig_date_added_LEFTTRIM_ErrorCount,le.orig_date_added_QUOTES_ErrorCount
          ,le.orig_price_LEFTTRIM_ErrorCount,le.orig_price_QUOTES_ErrorCount
          ,le.orig_pricing_error_code_LEFTTRIM_ErrorCount,le.orig_pricing_error_code_QUOTES_ErrorCount
          ,le.orig_free_LEFTTRIM_ErrorCount,le.orig_free_QUOTES_ErrorCount
          ,le.orig_business_name_LEFTTRIM_ErrorCount,le.orig_business_name_QUOTES_ErrorCount
          ,le.orig_name_first_LEFTTRIM_ErrorCount,le.orig_name_first_QUOTES_ErrorCount
          ,le.orig_name_last_LEFTTRIM_ErrorCount,le.orig_name_last_QUOTES_ErrorCount
          ,le.orig_ssn_LEFTTRIM_ErrorCount,le.orig_ssn_QUOTES_ErrorCount
          ,le.orig_case_number_LEFTTRIM_ErrorCount,le.orig_case_number_QUOTES_ErrorCount
          ,le.orig_address_LEFTTRIM_ErrorCount,le.orig_address_QUOTES_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_QUOTES_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_QUOTES_ErrorCount
          ,le.orig_zip_LEFTTRIM_ErrorCount,le.orig_zip_QUOTES_ErrorCount
          ,le.orig_dob_LEFTTRIM_ErrorCount,le.orig_dob_QUOTES_ErrorCount
          ,le.orig_phone_LEFTTRIM_ErrorCount,le.orig_phone_QUOTES_ErrorCount
          ,le.orig_tmsid_LEFTTRIM_ErrorCount,le.orig_tmsid_QUOTES_ErrorCount
          ,le.orig_unique_id_LEFTTRIM_ErrorCount,le.orig_unique_id_QUOTES_ErrorCount
          ,le.orig_out_tmsid_LEFTTRIM_ErrorCount,le.orig_out_tmsid_QUOTES_ErrorCount
          ,le.orig_out_business_name_LEFTTRIM_ErrorCount,le.orig_out_business_name_QUOTES_ErrorCount
          ,le.orig_out_first_name_LEFTTRIM_ErrorCount,le.orig_out_first_name_QUOTES_ErrorCount
          ,le.orig_out_last_name_LEFTTRIM_ErrorCount,le.orig_out_last_name_QUOTES_ErrorCount
          ,le.orig_out_ssn_LEFTTRIM_ErrorCount,le.orig_out_ssn_QUOTES_ErrorCount
          ,le.orig_out_address_LEFTTRIM_ErrorCount,le.orig_out_address_QUOTES_ErrorCount
          ,le.orig_out_city_LEFTTRIM_ErrorCount,le.orig_out_city_QUOTES_ErrorCount
          ,le.orig_out_state_LEFTTRIM_ErrorCount,le.orig_out_state_QUOTES_ErrorCount
          ,le.orig_out_zip_LEFTTRIM_ErrorCount,le.orig_out_zip_QUOTES_ErrorCount
          ,le.orig_out_case_number_LEFTTRIM_ErrorCount,le.orig_out_case_number_QUOTES_ErrorCount
          ,le.orig_transaction_type_LEFTTRIM_ErrorCount,le.orig_transaction_type_QUOTES_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
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
          ,'orig_transaction_id:' + getFieldTypeText(h.orig_transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_function_name:' + getFieldTypeText(h.orig_function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_id:' + getFieldTypeText(h.orig_company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_login_id:' + getFieldTypeText(h.orig_login_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_billing_code:' + getFieldTypeText(h.orig_billing_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_record_count:' + getFieldTypeText(h.orig_record_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fcra_purpose:' + getFieldTypeText(h.orig_fcra_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_glb_purpose:' + getFieldTypeText(h.orig_glb_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dppa_purpose:' + getFieldTypeText(h.orig_dppa_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ip_address:' + getFieldTypeText(h.orig_ip_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_reference_code:' + getFieldTypeText(h.orig_reference_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_login_history_id:' + getFieldTypeText(h.orig_login_history_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_date_added:' + getFieldTypeText(h.orig_date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_price:' + getFieldTypeText(h.orig_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pricing_error_code:' + getFieldTypeText(h.orig_pricing_error_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_free:' + getFieldTypeText(h.orig_free) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_business_name:' + getFieldTypeText(h.orig_business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_first:' + getFieldTypeText(h.orig_name_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_last:' + getFieldTypeText(h.orig_name_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_case_number:' + getFieldTypeText(h.orig_case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone:' + getFieldTypeText(h.orig_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_tmsid:' + getFieldTypeText(h.orig_tmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unique_id:' + getFieldTypeText(h.orig_unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_tmsid:' + getFieldTypeText(h.orig_out_tmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_business_name:' + getFieldTypeText(h.orig_out_business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_first_name:' + getFieldTypeText(h.orig_out_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_last_name:' + getFieldTypeText(h.orig_out_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_ssn:' + getFieldTypeText(h.orig_out_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_address:' + getFieldTypeText(h.orig_out_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_city:' + getFieldTypeText(h.orig_out_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_state:' + getFieldTypeText(h.orig_out_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_zip:' + getFieldTypeText(h.orig_out_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_out_case_number:' + getFieldTypeText(h.orig_out_case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_transaction_type:' + getFieldTypeText(h.orig_transaction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_transaction_id_cnt
          ,le.populated_orig_function_name_cnt
          ,le.populated_orig_company_id_cnt
          ,le.populated_orig_login_id_cnt
          ,le.populated_orig_billing_code_cnt
          ,le.populated_orig_record_count_cnt
          ,le.populated_orig_fcra_purpose_cnt
          ,le.populated_orig_glb_purpose_cnt
          ,le.populated_orig_dppa_purpose_cnt
          ,le.populated_orig_ip_address_cnt
          ,le.populated_orig_reference_code_cnt
          ,le.populated_orig_login_history_id_cnt
          ,le.populated_orig_date_added_cnt
          ,le.populated_orig_price_cnt
          ,le.populated_orig_pricing_error_code_cnt
          ,le.populated_orig_free_cnt
          ,le.populated_orig_business_name_cnt
          ,le.populated_orig_name_first_cnt
          ,le.populated_orig_name_last_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_case_number_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_phone_cnt
          ,le.populated_orig_tmsid_cnt
          ,le.populated_orig_unique_id_cnt
          ,le.populated_orig_out_tmsid_cnt
          ,le.populated_orig_out_business_name_cnt
          ,le.populated_orig_out_first_name_cnt
          ,le.populated_orig_out_last_name_cnt
          ,le.populated_orig_out_ssn_cnt
          ,le.populated_orig_out_address_cnt
          ,le.populated_orig_out_city_cnt
          ,le.populated_orig_out_state_cnt
          ,le.populated_orig_out_zip_cnt
          ,le.populated_orig_out_case_number_cnt
          ,le.populated_orig_transaction_type_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_transaction_id_pcnt
          ,le.populated_orig_function_name_pcnt
          ,le.populated_orig_company_id_pcnt
          ,le.populated_orig_login_id_pcnt
          ,le.populated_orig_billing_code_pcnt
          ,le.populated_orig_record_count_pcnt
          ,le.populated_orig_fcra_purpose_pcnt
          ,le.populated_orig_glb_purpose_pcnt
          ,le.populated_orig_dppa_purpose_pcnt
          ,le.populated_orig_ip_address_pcnt
          ,le.populated_orig_reference_code_pcnt
          ,le.populated_orig_login_history_id_pcnt
          ,le.populated_orig_date_added_pcnt
          ,le.populated_orig_price_pcnt
          ,le.populated_orig_pricing_error_code_pcnt
          ,le.populated_orig_free_pcnt
          ,le.populated_orig_business_name_pcnt
          ,le.populated_orig_name_first_pcnt
          ,le.populated_orig_name_last_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_case_number_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_phone_pcnt
          ,le.populated_orig_tmsid_pcnt
          ,le.populated_orig_unique_id_pcnt
          ,le.populated_orig_out_tmsid_pcnt
          ,le.populated_orig_out_business_name_pcnt
          ,le.populated_orig_out_first_name_pcnt
          ,le.populated_orig_out_last_name_pcnt
          ,le.populated_orig_out_ssn_pcnt
          ,le.populated_orig_out_address_pcnt
          ,le.populated_orig_out_city_pcnt
          ,le.populated_orig_out_state_pcnt
          ,le.populated_orig_out_zip_pcnt
          ,le.populated_orig_out_case_number_pcnt
          ,le.populated_orig_transaction_type_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,40,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),40,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
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
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inql_Nfcra_Banko, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
