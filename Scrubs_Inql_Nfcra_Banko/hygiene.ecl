IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_transaction_id_cnt := COUNT(GROUP,h.orig_transaction_id <> (TYPEOF(h.orig_transaction_id))'');
    populated_orig_transaction_id_pcnt := AVE(GROUP,IF(h.orig_transaction_id = (TYPEOF(h.orig_transaction_id))'',0,100));
    maxlength_orig_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_id)));
    avelength_orig_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_id)),h.orig_transaction_id<>(typeof(h.orig_transaction_id))'');
    populated_orig_function_name_cnt := COUNT(GROUP,h.orig_function_name <> (TYPEOF(h.orig_function_name))'');
    populated_orig_function_name_pcnt := AVE(GROUP,IF(h.orig_function_name = (TYPEOF(h.orig_function_name))'',0,100));
    maxlength_orig_function_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)));
    avelength_orig_function_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)),h.orig_function_name<>(typeof(h.orig_function_name))'');
    populated_orig_company_id_cnt := COUNT(GROUP,h.orig_company_id <> (TYPEOF(h.orig_company_id))'');
    populated_orig_company_id_pcnt := AVE(GROUP,IF(h.orig_company_id = (TYPEOF(h.orig_company_id))'',0,100));
    maxlength_orig_company_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_id)));
    avelength_orig_company_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_id)),h.orig_company_id<>(typeof(h.orig_company_id))'');
    populated_orig_login_id_cnt := COUNT(GROUP,h.orig_login_id <> (TYPEOF(h.orig_login_id))'');
    populated_orig_login_id_pcnt := AVE(GROUP,IF(h.orig_login_id = (TYPEOF(h.orig_login_id))'',0,100));
    maxlength_orig_login_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_id)));
    avelength_orig_login_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_id)),h.orig_login_id<>(typeof(h.orig_login_id))'');
    populated_orig_billing_code_cnt := COUNT(GROUP,h.orig_billing_code <> (TYPEOF(h.orig_billing_code))'');
    populated_orig_billing_code_pcnt := AVE(GROUP,IF(h.orig_billing_code = (TYPEOF(h.orig_billing_code))'',0,100));
    maxlength_orig_billing_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billing_code)));
    avelength_orig_billing_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billing_code)),h.orig_billing_code<>(typeof(h.orig_billing_code))'');
    populated_orig_record_count_cnt := COUNT(GROUP,h.orig_record_count <> (TYPEOF(h.orig_record_count))'');
    populated_orig_record_count_pcnt := AVE(GROUP,IF(h.orig_record_count = (TYPEOF(h.orig_record_count))'',0,100));
    maxlength_orig_record_count := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_record_count)));
    avelength_orig_record_count := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_record_count)),h.orig_record_count<>(typeof(h.orig_record_count))'');
    populated_orig_fcra_purpose_cnt := COUNT(GROUP,h.orig_fcra_purpose <> (TYPEOF(h.orig_fcra_purpose))'');
    populated_orig_fcra_purpose_pcnt := AVE(GROUP,IF(h.orig_fcra_purpose = (TYPEOF(h.orig_fcra_purpose))'',0,100));
    maxlength_orig_fcra_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra_purpose)));
    avelength_orig_fcra_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra_purpose)),h.orig_fcra_purpose<>(typeof(h.orig_fcra_purpose))'');
    populated_orig_glb_purpose_cnt := COUNT(GROUP,h.orig_glb_purpose <> (TYPEOF(h.orig_glb_purpose))'');
    populated_orig_glb_purpose_pcnt := AVE(GROUP,IF(h.orig_glb_purpose = (TYPEOF(h.orig_glb_purpose))'',0,100));
    maxlength_orig_glb_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb_purpose)));
    avelength_orig_glb_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb_purpose)),h.orig_glb_purpose<>(typeof(h.orig_glb_purpose))'');
    populated_orig_dppa_purpose_cnt := COUNT(GROUP,h.orig_dppa_purpose <> (TYPEOF(h.orig_dppa_purpose))'');
    populated_orig_dppa_purpose_pcnt := AVE(GROUP,IF(h.orig_dppa_purpose = (TYPEOF(h.orig_dppa_purpose))'',0,100));
    maxlength_orig_dppa_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dppa_purpose)));
    avelength_orig_dppa_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dppa_purpose)),h.orig_dppa_purpose<>(typeof(h.orig_dppa_purpose))'');
    populated_orig_ip_address_cnt := COUNT(GROUP,h.orig_ip_address <> (TYPEOF(h.orig_ip_address))'');
    populated_orig_ip_address_pcnt := AVE(GROUP,IF(h.orig_ip_address = (TYPEOF(h.orig_ip_address))'',0,100));
    maxlength_orig_ip_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address)));
    avelength_orig_ip_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address)),h.orig_ip_address<>(typeof(h.orig_ip_address))'');
    populated_orig_reference_code_cnt := COUNT(GROUP,h.orig_reference_code <> (TYPEOF(h.orig_reference_code))'');
    populated_orig_reference_code_pcnt := AVE(GROUP,IF(h.orig_reference_code = (TYPEOF(h.orig_reference_code))'',0,100));
    maxlength_orig_reference_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_reference_code)));
    avelength_orig_reference_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_reference_code)),h.orig_reference_code<>(typeof(h.orig_reference_code))'');
    populated_orig_login_history_id_cnt := COUNT(GROUP,h.orig_login_history_id <> (TYPEOF(h.orig_login_history_id))'');
    populated_orig_login_history_id_pcnt := AVE(GROUP,IF(h.orig_login_history_id = (TYPEOF(h.orig_login_history_id))'',0,100));
    maxlength_orig_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)));
    avelength_orig_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)),h.orig_login_history_id<>(typeof(h.orig_login_history_id))'');
    populated_orig_date_added_cnt := COUNT(GROUP,h.orig_date_added <> (TYPEOF(h.orig_date_added))'');
    populated_orig_date_added_pcnt := AVE(GROUP,IF(h.orig_date_added = (TYPEOF(h.orig_date_added))'',0,100));
    maxlength_orig_date_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_date_added)));
    avelength_orig_date_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_date_added)),h.orig_date_added<>(typeof(h.orig_date_added))'');
    populated_orig_price_cnt := COUNT(GROUP,h.orig_price <> (TYPEOF(h.orig_price))'');
    populated_orig_price_pcnt := AVE(GROUP,IF(h.orig_price = (TYPEOF(h.orig_price))'',0,100));
    maxlength_orig_price := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_price)));
    avelength_orig_price := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_price)),h.orig_price<>(typeof(h.orig_price))'');
    populated_orig_pricing_error_code_cnt := COUNT(GROUP,h.orig_pricing_error_code <> (TYPEOF(h.orig_pricing_error_code))'');
    populated_orig_pricing_error_code_pcnt := AVE(GROUP,IF(h.orig_pricing_error_code = (TYPEOF(h.orig_pricing_error_code))'',0,100));
    maxlength_orig_pricing_error_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_pricing_error_code)));
    avelength_orig_pricing_error_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_pricing_error_code)),h.orig_pricing_error_code<>(typeof(h.orig_pricing_error_code))'');
    populated_orig_free_cnt := COUNT(GROUP,h.orig_free <> (TYPEOF(h.orig_free))'');
    populated_orig_free_pcnt := AVE(GROUP,IF(h.orig_free = (TYPEOF(h.orig_free))'',0,100));
    maxlength_orig_free := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_free)));
    avelength_orig_free := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_free)),h.orig_free<>(typeof(h.orig_free))'');
    populated_orig_business_name_cnt := COUNT(GROUP,h.orig_business_name <> (TYPEOF(h.orig_business_name))'');
    populated_orig_business_name_pcnt := AVE(GROUP,IF(h.orig_business_name = (TYPEOF(h.orig_business_name))'',0,100));
    maxlength_orig_business_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name)));
    avelength_orig_business_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name)),h.orig_business_name<>(typeof(h.orig_business_name))'');
    populated_orig_name_first_cnt := COUNT(GROUP,h.orig_name_first <> (TYPEOF(h.orig_name_first))'');
    populated_orig_name_first_pcnt := AVE(GROUP,IF(h.orig_name_first = (TYPEOF(h.orig_name_first))'',0,100));
    maxlength_orig_name_first := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_first)));
    avelength_orig_name_first := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_first)),h.orig_name_first<>(typeof(h.orig_name_first))'');
    populated_orig_name_last_cnt := COUNT(GROUP,h.orig_name_last <> (TYPEOF(h.orig_name_last))'');
    populated_orig_name_last_pcnt := AVE(GROUP,IF(h.orig_name_last = (TYPEOF(h.orig_name_last))'',0,100));
    maxlength_orig_name_last := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_last)));
    avelength_orig_name_last := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_last)),h.orig_name_last<>(typeof(h.orig_name_last))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_case_number_cnt := COUNT(GROUP,h.orig_case_number <> (TYPEOF(h.orig_case_number))'');
    populated_orig_case_number_pcnt := AVE(GROUP,IF(h.orig_case_number = (TYPEOF(h.orig_case_number))'',0,100));
    maxlength_orig_case_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_case_number)));
    avelength_orig_case_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_case_number)),h.orig_case_number<>(typeof(h.orig_case_number))'');
    populated_orig_address_cnt := COUNT(GROUP,h.orig_address <> (TYPEOF(h.orig_address))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_tmsid_cnt := COUNT(GROUP,h.orig_tmsid <> (TYPEOF(h.orig_tmsid))'');
    populated_orig_tmsid_pcnt := AVE(GROUP,IF(h.orig_tmsid = (TYPEOF(h.orig_tmsid))'',0,100));
    maxlength_orig_tmsid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_tmsid)));
    avelength_orig_tmsid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_tmsid)),h.orig_tmsid<>(typeof(h.orig_tmsid))'');
    populated_orig_unique_id_cnt := COUNT(GROUP,h.orig_unique_id <> (TYPEOF(h.orig_unique_id))'');
    populated_orig_unique_id_pcnt := AVE(GROUP,IF(h.orig_unique_id = (TYPEOF(h.orig_unique_id))'',0,100));
    maxlength_orig_unique_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unique_id)));
    avelength_orig_unique_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unique_id)),h.orig_unique_id<>(typeof(h.orig_unique_id))'');
    populated_orig_out_tmsid_cnt := COUNT(GROUP,h.orig_out_tmsid <> (TYPEOF(h.orig_out_tmsid))'');
    populated_orig_out_tmsid_pcnt := AVE(GROUP,IF(h.orig_out_tmsid = (TYPEOF(h.orig_out_tmsid))'',0,100));
    maxlength_orig_out_tmsid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_tmsid)));
    avelength_orig_out_tmsid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_tmsid)),h.orig_out_tmsid<>(typeof(h.orig_out_tmsid))'');
    populated_orig_out_business_name_cnt := COUNT(GROUP,h.orig_out_business_name <> (TYPEOF(h.orig_out_business_name))'');
    populated_orig_out_business_name_pcnt := AVE(GROUP,IF(h.orig_out_business_name = (TYPEOF(h.orig_out_business_name))'',0,100));
    maxlength_orig_out_business_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_business_name)));
    avelength_orig_out_business_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_business_name)),h.orig_out_business_name<>(typeof(h.orig_out_business_name))'');
    populated_orig_out_first_name_cnt := COUNT(GROUP,h.orig_out_first_name <> (TYPEOF(h.orig_out_first_name))'');
    populated_orig_out_first_name_pcnt := AVE(GROUP,IF(h.orig_out_first_name = (TYPEOF(h.orig_out_first_name))'',0,100));
    maxlength_orig_out_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_first_name)));
    avelength_orig_out_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_first_name)),h.orig_out_first_name<>(typeof(h.orig_out_first_name))'');
    populated_orig_out_last_name_cnt := COUNT(GROUP,h.orig_out_last_name <> (TYPEOF(h.orig_out_last_name))'');
    populated_orig_out_last_name_pcnt := AVE(GROUP,IF(h.orig_out_last_name = (TYPEOF(h.orig_out_last_name))'',0,100));
    maxlength_orig_out_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_last_name)));
    avelength_orig_out_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_last_name)),h.orig_out_last_name<>(typeof(h.orig_out_last_name))'');
    populated_orig_out_ssn_cnt := COUNT(GROUP,h.orig_out_ssn <> (TYPEOF(h.orig_out_ssn))'');
    populated_orig_out_ssn_pcnt := AVE(GROUP,IF(h.orig_out_ssn = (TYPEOF(h.orig_out_ssn))'',0,100));
    maxlength_orig_out_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_ssn)));
    avelength_orig_out_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_ssn)),h.orig_out_ssn<>(typeof(h.orig_out_ssn))'');
    populated_orig_out_address_cnt := COUNT(GROUP,h.orig_out_address <> (TYPEOF(h.orig_out_address))'');
    populated_orig_out_address_pcnt := AVE(GROUP,IF(h.orig_out_address = (TYPEOF(h.orig_out_address))'',0,100));
    maxlength_orig_out_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_address)));
    avelength_orig_out_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_address)),h.orig_out_address<>(typeof(h.orig_out_address))'');
    populated_orig_out_city_cnt := COUNT(GROUP,h.orig_out_city <> (TYPEOF(h.orig_out_city))'');
    populated_orig_out_city_pcnt := AVE(GROUP,IF(h.orig_out_city = (TYPEOF(h.orig_out_city))'',0,100));
    maxlength_orig_out_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_city)));
    avelength_orig_out_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_city)),h.orig_out_city<>(typeof(h.orig_out_city))'');
    populated_orig_out_state_cnt := COUNT(GROUP,h.orig_out_state <> (TYPEOF(h.orig_out_state))'');
    populated_orig_out_state_pcnt := AVE(GROUP,IF(h.orig_out_state = (TYPEOF(h.orig_out_state))'',0,100));
    maxlength_orig_out_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_state)));
    avelength_orig_out_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_state)),h.orig_out_state<>(typeof(h.orig_out_state))'');
    populated_orig_out_zip_cnt := COUNT(GROUP,h.orig_out_zip <> (TYPEOF(h.orig_out_zip))'');
    populated_orig_out_zip_pcnt := AVE(GROUP,IF(h.orig_out_zip = (TYPEOF(h.orig_out_zip))'',0,100));
    maxlength_orig_out_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_zip)));
    avelength_orig_out_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_zip)),h.orig_out_zip<>(typeof(h.orig_out_zip))'');
    populated_orig_out_case_number_cnt := COUNT(GROUP,h.orig_out_case_number <> (TYPEOF(h.orig_out_case_number))'');
    populated_orig_out_case_number_pcnt := AVE(GROUP,IF(h.orig_out_case_number = (TYPEOF(h.orig_out_case_number))'',0,100));
    maxlength_orig_out_case_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_case_number)));
    avelength_orig_out_case_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_out_case_number)),h.orig_out_case_number<>(typeof(h.orig_out_case_number))'');
    populated_orig_transaction_type_cnt := COUNT(GROUP,h.orig_transaction_type <> (TYPEOF(h.orig_transaction_type))'');
    populated_orig_transaction_type_pcnt := AVE(GROUP,IF(h.orig_transaction_type = (TYPEOF(h.orig_transaction_type))'',0,100));
    maxlength_orig_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_type)));
    avelength_orig_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_type)),h.orig_transaction_type<>(typeof(h.orig_transaction_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_transaction_id_pcnt *   0.00 / 100 + T.Populated_orig_function_name_pcnt *   0.00 / 100 + T.Populated_orig_company_id_pcnt *   0.00 / 100 + T.Populated_orig_login_id_pcnt *   0.00 / 100 + T.Populated_orig_billing_code_pcnt *   0.00 / 100 + T.Populated_orig_record_count_pcnt *   0.00 / 100 + T.Populated_orig_fcra_purpose_pcnt *   0.00 / 100 + T.Populated_orig_glb_purpose_pcnt *   0.00 / 100 + T.Populated_orig_dppa_purpose_pcnt *   0.00 / 100 + T.Populated_orig_ip_address_pcnt *   0.00 / 100 + T.Populated_orig_reference_code_pcnt *   0.00 / 100 + T.Populated_orig_login_history_id_pcnt *   0.00 / 100 + T.Populated_orig_date_added_pcnt *   0.00 / 100 + T.Populated_orig_price_pcnt *   0.00 / 100 + T.Populated_orig_pricing_error_code_pcnt *   0.00 / 100 + T.Populated_orig_free_pcnt *   0.00 / 100 + T.Populated_orig_business_name_pcnt *   0.00 / 100 + T.Populated_orig_name_first_pcnt *   0.00 / 100 + T.Populated_orig_name_last_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_case_number_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_tmsid_pcnt *   0.00 / 100 + T.Populated_orig_unique_id_pcnt *   0.00 / 100 + T.Populated_orig_out_tmsid_pcnt *   0.00 / 100 + T.Populated_orig_out_business_name_pcnt *   0.00 / 100 + T.Populated_orig_out_first_name_pcnt *   0.00 / 100 + T.Populated_orig_out_last_name_pcnt *   0.00 / 100 + T.Populated_orig_out_ssn_pcnt *   0.00 / 100 + T.Populated_orig_out_address_pcnt *   0.00 / 100 + T.Populated_orig_out_city_pcnt *   0.00 / 100 + T.Populated_orig_out_state_pcnt *   0.00 / 100 + T.Populated_orig_out_zip_pcnt *   0.00 / 100 + T.Populated_orig_out_case_number_pcnt *   0.00 / 100 + T.Populated_orig_transaction_type_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orig_transaction_id','orig_function_name','orig_company_id','orig_login_id','orig_billing_code','orig_record_count','orig_fcra_purpose','orig_glb_purpose','orig_dppa_purpose','orig_ip_address','orig_reference_code','orig_login_history_id','orig_date_added','orig_price','orig_pricing_error_code','orig_free','orig_business_name','orig_name_first','orig_name_last','orig_ssn','orig_case_number','orig_address','orig_city','orig_state','orig_zip','orig_dob','orig_phone','orig_tmsid','orig_unique_id','orig_out_tmsid','orig_out_business_name','orig_out_first_name','orig_out_last_name','orig_out_ssn','orig_out_address','orig_out_city','orig_out_state','orig_out_zip','orig_out_case_number','orig_transaction_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_transaction_id_pcnt,le.populated_orig_function_name_pcnt,le.populated_orig_company_id_pcnt,le.populated_orig_login_id_pcnt,le.populated_orig_billing_code_pcnt,le.populated_orig_record_count_pcnt,le.populated_orig_fcra_purpose_pcnt,le.populated_orig_glb_purpose_pcnt,le.populated_orig_dppa_purpose_pcnt,le.populated_orig_ip_address_pcnt,le.populated_orig_reference_code_pcnt,le.populated_orig_login_history_id_pcnt,le.populated_orig_date_added_pcnt,le.populated_orig_price_pcnt,le.populated_orig_pricing_error_code_pcnt,le.populated_orig_free_pcnt,le.populated_orig_business_name_pcnt,le.populated_orig_name_first_pcnt,le.populated_orig_name_last_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_case_number_pcnt,le.populated_orig_address_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_tmsid_pcnt,le.populated_orig_unique_id_pcnt,le.populated_orig_out_tmsid_pcnt,le.populated_orig_out_business_name_pcnt,le.populated_orig_out_first_name_pcnt,le.populated_orig_out_last_name_pcnt,le.populated_orig_out_ssn_pcnt,le.populated_orig_out_address_pcnt,le.populated_orig_out_city_pcnt,le.populated_orig_out_state_pcnt,le.populated_orig_out_zip_pcnt,le.populated_orig_out_case_number_pcnt,le.populated_orig_transaction_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_transaction_id,le.maxlength_orig_function_name,le.maxlength_orig_company_id,le.maxlength_orig_login_id,le.maxlength_orig_billing_code,le.maxlength_orig_record_count,le.maxlength_orig_fcra_purpose,le.maxlength_orig_glb_purpose,le.maxlength_orig_dppa_purpose,le.maxlength_orig_ip_address,le.maxlength_orig_reference_code,le.maxlength_orig_login_history_id,le.maxlength_orig_date_added,le.maxlength_orig_price,le.maxlength_orig_pricing_error_code,le.maxlength_orig_free,le.maxlength_orig_business_name,le.maxlength_orig_name_first,le.maxlength_orig_name_last,le.maxlength_orig_ssn,le.maxlength_orig_case_number,le.maxlength_orig_address,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_dob,le.maxlength_orig_phone,le.maxlength_orig_tmsid,le.maxlength_orig_unique_id,le.maxlength_orig_out_tmsid,le.maxlength_orig_out_business_name,le.maxlength_orig_out_first_name,le.maxlength_orig_out_last_name,le.maxlength_orig_out_ssn,le.maxlength_orig_out_address,le.maxlength_orig_out_city,le.maxlength_orig_out_state,le.maxlength_orig_out_zip,le.maxlength_orig_out_case_number,le.maxlength_orig_transaction_type);
  SELF.avelength := CHOOSE(C,le.avelength_orig_transaction_id,le.avelength_orig_function_name,le.avelength_orig_company_id,le.avelength_orig_login_id,le.avelength_orig_billing_code,le.avelength_orig_record_count,le.avelength_orig_fcra_purpose,le.avelength_orig_glb_purpose,le.avelength_orig_dppa_purpose,le.avelength_orig_ip_address,le.avelength_orig_reference_code,le.avelength_orig_login_history_id,le.avelength_orig_date_added,le.avelength_orig_price,le.avelength_orig_pricing_error_code,le.avelength_orig_free,le.avelength_orig_business_name,le.avelength_orig_name_first,le.avelength_orig_name_last,le.avelength_orig_ssn,le.avelength_orig_case_number,le.avelength_orig_address,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_dob,le.avelength_orig_phone,le.avelength_orig_tmsid,le.avelength_orig_unique_id,le.avelength_orig_out_tmsid,le.avelength_orig_out_business_name,le.avelength_orig_out_first_name,le.avelength_orig_out_last_name,le.avelength_orig_out_ssn,le.avelength_orig_out_address,le.avelength_orig_out_city,le.avelength_orig_out_state,le.avelength_orig_out_zip,le.avelength_orig_out_case_number,le.avelength_orig_transaction_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 40, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_login_id),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_dppa_purpose),TRIM((SALT39.StrType)le.orig_ip_address),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_date_added),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_name_first),TRIM((SALT39.StrType)le.orig_name_last),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_case_number),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_tmsid),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_out_tmsid),TRIM((SALT39.StrType)le.orig_out_business_name),TRIM((SALT39.StrType)le.orig_out_first_name),TRIM((SALT39.StrType)le.orig_out_last_name),TRIM((SALT39.StrType)le.orig_out_ssn),TRIM((SALT39.StrType)le.orig_out_address),TRIM((SALT39.StrType)le.orig_out_city),TRIM((SALT39.StrType)le.orig_out_state),TRIM((SALT39.StrType)le.orig_out_zip),TRIM((SALT39.StrType)le.orig_out_case_number),TRIM((SALT39.StrType)le.orig_transaction_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_login_id),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_dppa_purpose),TRIM((SALT39.StrType)le.orig_ip_address),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_date_added),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_name_first),TRIM((SALT39.StrType)le.orig_name_last),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_case_number),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_tmsid),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_out_tmsid),TRIM((SALT39.StrType)le.orig_out_business_name),TRIM((SALT39.StrType)le.orig_out_first_name),TRIM((SALT39.StrType)le.orig_out_last_name),TRIM((SALT39.StrType)le.orig_out_ssn),TRIM((SALT39.StrType)le.orig_out_address),TRIM((SALT39.StrType)le.orig_out_city),TRIM((SALT39.StrType)le.orig_out_state),TRIM((SALT39.StrType)le.orig_out_zip),TRIM((SALT39.StrType)le.orig_out_case_number),TRIM((SALT39.StrType)le.orig_transaction_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_login_id),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_dppa_purpose),TRIM((SALT39.StrType)le.orig_ip_address),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_date_added),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_name_first),TRIM((SALT39.StrType)le.orig_name_last),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_case_number),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_tmsid),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_out_tmsid),TRIM((SALT39.StrType)le.orig_out_business_name),TRIM((SALT39.StrType)le.orig_out_first_name),TRIM((SALT39.StrType)le.orig_out_last_name),TRIM((SALT39.StrType)le.orig_out_ssn),TRIM((SALT39.StrType)le.orig_out_address),TRIM((SALT39.StrType)le.orig_out_city),TRIM((SALT39.StrType)le.orig_out_state),TRIM((SALT39.StrType)le.orig_out_zip),TRIM((SALT39.StrType)le.orig_out_case_number),TRIM((SALT39.StrType)le.orig_transaction_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_transaction_id'}
      ,{2,'orig_function_name'}
      ,{3,'orig_company_id'}
      ,{4,'orig_login_id'}
      ,{5,'orig_billing_code'}
      ,{6,'orig_record_count'}
      ,{7,'orig_fcra_purpose'}
      ,{8,'orig_glb_purpose'}
      ,{9,'orig_dppa_purpose'}
      ,{10,'orig_ip_address'}
      ,{11,'orig_reference_code'}
      ,{12,'orig_login_history_id'}
      ,{13,'orig_date_added'}
      ,{14,'orig_price'}
      ,{15,'orig_pricing_error_code'}
      ,{16,'orig_free'}
      ,{17,'orig_business_name'}
      ,{18,'orig_name_first'}
      ,{19,'orig_name_last'}
      ,{20,'orig_ssn'}
      ,{21,'orig_case_number'}
      ,{22,'orig_address'}
      ,{23,'orig_city'}
      ,{24,'orig_state'}
      ,{25,'orig_zip'}
      ,{26,'orig_dob'}
      ,{27,'orig_phone'}
      ,{28,'orig_tmsid'}
      ,{29,'orig_unique_id'}
      ,{30,'orig_out_tmsid'}
      ,{31,'orig_out_business_name'}
      ,{32,'orig_out_first_name'}
      ,{33,'orig_out_last_name'}
      ,{34,'orig_out_ssn'}
      ,{35,'orig_out_address'}
      ,{36,'orig_out_city'}
      ,{37,'orig_out_state'}
      ,{38,'orig_out_zip'}
      ,{39,'orig_out_case_number'}
      ,{40,'orig_transaction_type'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id),
    Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name),
    Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id),
    Fields.InValid_orig_login_id((SALT39.StrType)le.orig_login_id),
    Fields.InValid_orig_billing_code((SALT39.StrType)le.orig_billing_code),
    Fields.InValid_orig_record_count((SALT39.StrType)le.orig_record_count),
    Fields.InValid_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose),
    Fields.InValid_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose),
    Fields.InValid_orig_dppa_purpose((SALT39.StrType)le.orig_dppa_purpose),
    Fields.InValid_orig_ip_address((SALT39.StrType)le.orig_ip_address),
    Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code),
    Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id),
    Fields.InValid_orig_date_added((SALT39.StrType)le.orig_date_added),
    Fields.InValid_orig_price((SALT39.StrType)le.orig_price),
    Fields.InValid_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code),
    Fields.InValid_orig_free((SALT39.StrType)le.orig_free),
    Fields.InValid_orig_business_name((SALT39.StrType)le.orig_business_name),
    Fields.InValid_orig_name_first((SALT39.StrType)le.orig_name_first),
    Fields.InValid_orig_name_last((SALT39.StrType)le.orig_name_last),
    Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn),
    Fields.InValid_orig_case_number((SALT39.StrType)le.orig_case_number),
    Fields.InValid_orig_address((SALT39.StrType)le.orig_address),
    Fields.InValid_orig_city((SALT39.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT39.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip),
    Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob),
    Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone),
    Fields.InValid_orig_tmsid((SALT39.StrType)le.orig_tmsid),
    Fields.InValid_orig_unique_id((SALT39.StrType)le.orig_unique_id),
    Fields.InValid_orig_out_tmsid((SALT39.StrType)le.orig_out_tmsid),
    Fields.InValid_orig_out_business_name((SALT39.StrType)le.orig_out_business_name),
    Fields.InValid_orig_out_first_name((SALT39.StrType)le.orig_out_first_name),
    Fields.InValid_orig_out_last_name((SALT39.StrType)le.orig_out_last_name),
    Fields.InValid_orig_out_ssn((SALT39.StrType)le.orig_out_ssn),
    Fields.InValid_orig_out_address((SALT39.StrType)le.orig_out_address),
    Fields.InValid_orig_out_city((SALT39.StrType)le.orig_out_city),
    Fields.InValid_orig_out_state((SALT39.StrType)le.orig_out_state),
    Fields.InValid_orig_out_zip((SALT39.StrType)le.orig_out_zip),
    Fields.InValid_orig_out_case_number((SALT39.StrType)le.orig_out_case_number),
    Fields.InValid_orig_transaction_type((SALT39.StrType)le.orig_transaction_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,40,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_billing_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_record_count(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fcra_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_glb_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dppa_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_reference_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_orig_price(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pricing_error_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_free(TotalErrors.ErrorNum),Fields.InValidMessage_orig_business_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_tmsid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_unique_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_tmsid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_business_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_out_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_transaction_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nfcra_Banko, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
