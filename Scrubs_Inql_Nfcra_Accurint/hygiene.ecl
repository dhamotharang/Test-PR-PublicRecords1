IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_FILE) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_end_user_id_cnt := COUNT(GROUP,h.orig_end_user_id <> (TYPEOF(h.orig_end_user_id))'');
    populated_orig_end_user_id_pcnt := AVE(GROUP,IF(h.orig_end_user_id = (TYPEOF(h.orig_end_user_id))'',0,100));
    maxlength_orig_end_user_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_id)));
    avelength_orig_end_user_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_id)),h.orig_end_user_id<>(typeof(h.orig_end_user_id))'');
    populated_orig_loginid_cnt := COUNT(GROUP,h.orig_loginid <> (TYPEOF(h.orig_loginid))'');
    populated_orig_loginid_pcnt := AVE(GROUP,IF(h.orig_loginid = (TYPEOF(h.orig_loginid))'',0,100));
    maxlength_orig_loginid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_loginid)));
    avelength_orig_loginid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_loginid)),h.orig_loginid<>(typeof(h.orig_loginid))'');
    populated_orig_billing_code_cnt := COUNT(GROUP,h.orig_billing_code <> (TYPEOF(h.orig_billing_code))'');
    populated_orig_billing_code_pcnt := AVE(GROUP,IF(h.orig_billing_code = (TYPEOF(h.orig_billing_code))'',0,100));
    maxlength_orig_billing_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billing_code)));
    avelength_orig_billing_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billing_code)),h.orig_billing_code<>(typeof(h.orig_billing_code))'');
    populated_orig_transaction_id_cnt := COUNT(GROUP,h.orig_transaction_id <> (TYPEOF(h.orig_transaction_id))'');
    populated_orig_transaction_id_pcnt := AVE(GROUP,IF(h.orig_transaction_id = (TYPEOF(h.orig_transaction_id))'',0,100));
    maxlength_orig_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_id)));
    avelength_orig_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_id)),h.orig_transaction_id<>(typeof(h.orig_transaction_id))'');
    populated_orig_transaction_type_cnt := COUNT(GROUP,h.orig_transaction_type <> (TYPEOF(h.orig_transaction_type))'');
    populated_orig_transaction_type_pcnt := AVE(GROUP,IF(h.orig_transaction_type = (TYPEOF(h.orig_transaction_type))'',0,100));
    maxlength_orig_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_type)));
    avelength_orig_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_type)),h.orig_transaction_type<>(typeof(h.orig_transaction_type))'');
    populated_orig_neighbors_cnt := COUNT(GROUP,h.orig_neighbors <> (TYPEOF(h.orig_neighbors))'');
    populated_orig_neighbors_pcnt := AVE(GROUP,IF(h.orig_neighbors = (TYPEOF(h.orig_neighbors))'',0,100));
    maxlength_orig_neighbors := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_neighbors)));
    avelength_orig_neighbors := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_neighbors)),h.orig_neighbors<>(typeof(h.orig_neighbors))'');
    populated_orig_relatives_cnt := COUNT(GROUP,h.orig_relatives <> (TYPEOF(h.orig_relatives))'');
    populated_orig_relatives_pcnt := AVE(GROUP,IF(h.orig_relatives = (TYPEOF(h.orig_relatives))'',0,100));
    maxlength_orig_relatives := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_relatives)));
    avelength_orig_relatives := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_relatives)),h.orig_relatives<>(typeof(h.orig_relatives))'');
    populated_orig_associates_cnt := COUNT(GROUP,h.orig_associates <> (TYPEOF(h.orig_associates))'');
    populated_orig_associates_pcnt := AVE(GROUP,IF(h.orig_associates = (TYPEOF(h.orig_associates))'',0,100));
    maxlength_orig_associates := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_associates)));
    avelength_orig_associates := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_associates)),h.orig_associates<>(typeof(h.orig_associates))'');
    populated_orig_property_cnt := COUNT(GROUP,h.orig_property <> (TYPEOF(h.orig_property))'');
    populated_orig_property_pcnt := AVE(GROUP,IF(h.orig_property = (TYPEOF(h.orig_property))'',0,100));
    maxlength_orig_property := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_property)));
    avelength_orig_property := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_property)),h.orig_property<>(typeof(h.orig_property))'');
    populated_orig_company_id_cnt := COUNT(GROUP,h.orig_company_id <> (TYPEOF(h.orig_company_id))'');
    populated_orig_company_id_pcnt := AVE(GROUP,IF(h.orig_company_id = (TYPEOF(h.orig_company_id))'',0,100));
    maxlength_orig_company_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_id)));
    avelength_orig_company_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_company_id)),h.orig_company_id<>(typeof(h.orig_company_id))'');
    populated_orig_reference_code_cnt := COUNT(GROUP,h.orig_reference_code <> (TYPEOF(h.orig_reference_code))'');
    populated_orig_reference_code_pcnt := AVE(GROUP,IF(h.orig_reference_code = (TYPEOF(h.orig_reference_code))'',0,100));
    maxlength_orig_reference_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_reference_code)));
    avelength_orig_reference_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_reference_code)),h.orig_reference_code<>(typeof(h.orig_reference_code))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
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
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_free_cnt := COUNT(GROUP,h.orig_free <> (TYPEOF(h.orig_free))'');
    populated_orig_free_pcnt := AVE(GROUP,IF(h.orig_free = (TYPEOF(h.orig_free))'',0,100));
    maxlength_orig_free := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_free)));
    avelength_orig_free := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_free)),h.orig_free<>(typeof(h.orig_free))'');
    populated_orig_record_count_cnt := COUNT(GROUP,h.orig_record_count <> (TYPEOF(h.orig_record_count))'');
    populated_orig_record_count_pcnt := AVE(GROUP,IF(h.orig_record_count = (TYPEOF(h.orig_record_count))'',0,100));
    maxlength_orig_record_count := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_record_count)));
    avelength_orig_record_count := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_record_count)),h.orig_record_count<>(typeof(h.orig_record_count))'');
    populated_orig_price_cnt := COUNT(GROUP,h.orig_price <> (TYPEOF(h.orig_price))'');
    populated_orig_price_pcnt := AVE(GROUP,IF(h.orig_price = (TYPEOF(h.orig_price))'',0,100));
    maxlength_orig_price := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_price)));
    avelength_orig_price := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_price)),h.orig_price<>(typeof(h.orig_price))'');
    populated_orig_bankruptcy_cnt := COUNT(GROUP,h.orig_bankruptcy <> (TYPEOF(h.orig_bankruptcy))'');
    populated_orig_bankruptcy_pcnt := AVE(GROUP,IF(h.orig_bankruptcy = (TYPEOF(h.orig_bankruptcy))'',0,100));
    maxlength_orig_bankruptcy := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bankruptcy)));
    avelength_orig_bankruptcy := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bankruptcy)),h.orig_bankruptcy<>(typeof(h.orig_bankruptcy))'');
    populated_orig_transaction_code_cnt := COUNT(GROUP,h.orig_transaction_code <> (TYPEOF(h.orig_transaction_code))'');
    populated_orig_transaction_code_pcnt := AVE(GROUP,IF(h.orig_transaction_code = (TYPEOF(h.orig_transaction_code))'',0,100));
    maxlength_orig_transaction_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_code)));
    avelength_orig_transaction_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_code)),h.orig_transaction_code<>(typeof(h.orig_transaction_code))'');
    populated_orig_dateadded_cnt := COUNT(GROUP,h.orig_dateadded <> (TYPEOF(h.orig_dateadded))'');
    populated_orig_dateadded_pcnt := AVE(GROUP,IF(h.orig_dateadded = (TYPEOF(h.orig_dateadded))'',0,100));
    maxlength_orig_dateadded := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dateadded)));
    avelength_orig_dateadded := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dateadded)),h.orig_dateadded<>(typeof(h.orig_dateadded))'');
    populated_orig_full_name_cnt := COUNT(GROUP,h.orig_full_name <> (TYPEOF(h.orig_full_name))'');
    populated_orig_full_name_pcnt := AVE(GROUP,IF(h.orig_full_name = (TYPEOF(h.orig_full_name))'',0,100));
    maxlength_orig_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_full_name)));
    avelength_orig_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_full_name)),h.orig_full_name<>(typeof(h.orig_full_name))'');
    populated_orig_billingdate_cnt := COUNT(GROUP,h.orig_billingdate <> (TYPEOF(h.orig_billingdate))'');
    populated_orig_billingdate_pcnt := AVE(GROUP,IF(h.orig_billingdate = (TYPEOF(h.orig_billingdate))'',0,100));
    maxlength_orig_billingdate := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billingdate)));
    avelength_orig_billingdate := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billingdate)),h.orig_billingdate<>(typeof(h.orig_billingdate))'');
    populated_orig_business_name_cnt := COUNT(GROUP,h.orig_business_name <> (TYPEOF(h.orig_business_name))'');
    populated_orig_business_name_pcnt := AVE(GROUP,IF(h.orig_business_name = (TYPEOF(h.orig_business_name))'',0,100));
    maxlength_orig_business_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name)));
    avelength_orig_business_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name)),h.orig_business_name<>(typeof(h.orig_business_name))'');
    populated_orig_pricing_error_code_cnt := COUNT(GROUP,h.orig_pricing_error_code <> (TYPEOF(h.orig_pricing_error_code))'');
    populated_orig_pricing_error_code_pcnt := AVE(GROUP,IF(h.orig_pricing_error_code = (TYPEOF(h.orig_pricing_error_code))'',0,100));
    maxlength_orig_pricing_error_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_pricing_error_code)));
    avelength_orig_pricing_error_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_pricing_error_code)),h.orig_pricing_error_code<>(typeof(h.orig_pricing_error_code))'');
    populated_orig_dl_purpose_cnt := COUNT(GROUP,h.orig_dl_purpose <> (TYPEOF(h.orig_dl_purpose))'');
    populated_orig_dl_purpose_pcnt := AVE(GROUP,IF(h.orig_dl_purpose = (TYPEOF(h.orig_dl_purpose))'',0,100));
    maxlength_orig_dl_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_purpose)));
    avelength_orig_dl_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_purpose)),h.orig_dl_purpose<>(typeof(h.orig_dl_purpose))'');
    populated_orig_result_format_cnt := COUNT(GROUP,h.orig_result_format <> (TYPEOF(h.orig_result_format))'');
    populated_orig_result_format_pcnt := AVE(GROUP,IF(h.orig_result_format = (TYPEOF(h.orig_result_format))'',0,100));
    maxlength_orig_result_format := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_result_format)));
    avelength_orig_result_format := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_result_format)),h.orig_result_format<>(typeof(h.orig_result_format))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_unique_id_cnt := COUNT(GROUP,h.orig_unique_id <> (TYPEOF(h.orig_unique_id))'');
    populated_orig_unique_id_pcnt := AVE(GROUP,IF(h.orig_unique_id = (TYPEOF(h.orig_unique_id))'',0,100));
    maxlength_orig_unique_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unique_id)));
    avelength_orig_unique_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unique_id)),h.orig_unique_id<>(typeof(h.orig_unique_id))'');
    populated_orig_dls_cnt := COUNT(GROUP,h.orig_dls <> (TYPEOF(h.orig_dls))'');
    populated_orig_dls_pcnt := AVE(GROUP,IF(h.orig_dls = (TYPEOF(h.orig_dls))'',0,100));
    maxlength_orig_dls := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dls)));
    avelength_orig_dls := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dls)),h.orig_dls<>(typeof(h.orig_dls))'');
    populated_orig_mvs_cnt := COUNT(GROUP,h.orig_mvs <> (TYPEOF(h.orig_mvs))'');
    populated_orig_mvs_pcnt := AVE(GROUP,IF(h.orig_mvs = (TYPEOF(h.orig_mvs))'',0,100));
    maxlength_orig_mvs := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mvs)));
    avelength_orig_mvs := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mvs)),h.orig_mvs<>(typeof(h.orig_mvs))'');
    populated_orig_function_name_cnt := COUNT(GROUP,h.orig_function_name <> (TYPEOF(h.orig_function_name))'');
    populated_orig_function_name_pcnt := AVE(GROUP,IF(h.orig_function_name = (TYPEOF(h.orig_function_name))'',0,100));
    maxlength_orig_function_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)));
    avelength_orig_function_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)),h.orig_function_name<>(typeof(h.orig_function_name))'');
    populated_orig_response_time_cnt := COUNT(GROUP,h.orig_response_time <> (TYPEOF(h.orig_response_time))'');
    populated_orig_response_time_pcnt := AVE(GROUP,IF(h.orig_response_time = (TYPEOF(h.orig_response_time))'',0,100));
    maxlength_orig_response_time := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_response_time)));
    avelength_orig_response_time := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_response_time)),h.orig_response_time<>(typeof(h.orig_response_time))'');
    populated_orig_data_source_cnt := COUNT(GROUP,h.orig_data_source <> (TYPEOF(h.orig_data_source))'');
    populated_orig_data_source_pcnt := AVE(GROUP,IF(h.orig_data_source = (TYPEOF(h.orig_data_source))'',0,100));
    maxlength_orig_data_source := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_data_source)));
    avelength_orig_data_source := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_data_source)),h.orig_data_source<>(typeof(h.orig_data_source))'');
    populated_orig_glb_purpose_cnt := COUNT(GROUP,h.orig_glb_purpose <> (TYPEOF(h.orig_glb_purpose))'');
    populated_orig_glb_purpose_pcnt := AVE(GROUP,IF(h.orig_glb_purpose = (TYPEOF(h.orig_glb_purpose))'',0,100));
    maxlength_orig_glb_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb_purpose)));
    avelength_orig_glb_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb_purpose)),h.orig_glb_purpose<>(typeof(h.orig_glb_purpose))'');
    populated_orig_report_options_cnt := COUNT(GROUP,h.orig_report_options <> (TYPEOF(h.orig_report_options))'');
    populated_orig_report_options_pcnt := AVE(GROUP,IF(h.orig_report_options = (TYPEOF(h.orig_report_options))'',0,100));
    maxlength_orig_report_options := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_report_options)));
    avelength_orig_report_options := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_report_options)),h.orig_report_options<>(typeof(h.orig_report_options))'');
    populated_orig_unused_cnt := COUNT(GROUP,h.orig_unused <> (TYPEOF(h.orig_unused))'');
    populated_orig_unused_pcnt := AVE(GROUP,IF(h.orig_unused = (TYPEOF(h.orig_unused))'',0,100));
    maxlength_orig_unused := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unused)));
    avelength_orig_unused := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unused)),h.orig_unused<>(typeof(h.orig_unused))'');
    populated_orig_login_history_id_cnt := COUNT(GROUP,h.orig_login_history_id <> (TYPEOF(h.orig_login_history_id))'');
    populated_orig_login_history_id_pcnt := AVE(GROUP,IF(h.orig_login_history_id = (TYPEOF(h.orig_login_history_id))'',0,100));
    maxlength_orig_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)));
    avelength_orig_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)),h.orig_login_history_id<>(typeof(h.orig_login_history_id))'');
    populated_orig_aseid_cnt := COUNT(GROUP,h.orig_aseid <> (TYPEOF(h.orig_aseid))'');
    populated_orig_aseid_pcnt := AVE(GROUP,IF(h.orig_aseid = (TYPEOF(h.orig_aseid))'',0,100));
    maxlength_orig_aseid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_aseid)));
    avelength_orig_aseid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_aseid)),h.orig_aseid<>(typeof(h.orig_aseid))'');
    populated_orig_years_cnt := COUNT(GROUP,h.orig_years <> (TYPEOF(h.orig_years))'');
    populated_orig_years_pcnt := AVE(GROUP,IF(h.orig_years = (TYPEOF(h.orig_years))'',0,100));
    maxlength_orig_years := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_years)));
    avelength_orig_years := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_years)),h.orig_years<>(typeof(h.orig_years))'');
    populated_orig_ip_address_cnt := COUNT(GROUP,h.orig_ip_address <> (TYPEOF(h.orig_ip_address))'');
    populated_orig_ip_address_pcnt := AVE(GROUP,IF(h.orig_ip_address = (TYPEOF(h.orig_ip_address))'',0,100));
    maxlength_orig_ip_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address)));
    avelength_orig_ip_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address)),h.orig_ip_address<>(typeof(h.orig_ip_address))'');
    populated_orig_source_code_cnt := COUNT(GROUP,h.orig_source_code <> (TYPEOF(h.orig_source_code))'');
    populated_orig_source_code_pcnt := AVE(GROUP,IF(h.orig_source_code = (TYPEOF(h.orig_source_code))'',0,100));
    maxlength_orig_source_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_source_code)));
    avelength_orig_source_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_source_code)),h.orig_source_code<>(typeof(h.orig_source_code))'');
    populated_orig_retail_price_cnt := COUNT(GROUP,h.orig_retail_price <> (TYPEOF(h.orig_retail_price))'');
    populated_orig_retail_price_pcnt := AVE(GROUP,IF(h.orig_retail_price = (TYPEOF(h.orig_retail_price))'',0,100));
    maxlength_orig_retail_price := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_retail_price)));
    avelength_orig_retail_price := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_retail_price)),h.orig_retail_price<>(typeof(h.orig_retail_price))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_end_user_id_pcnt *   0.00 / 100 + T.Populated_orig_loginid_pcnt *   0.00 / 100 + T.Populated_orig_billing_code_pcnt *   0.00 / 100 + T.Populated_orig_transaction_id_pcnt *   0.00 / 100 + T.Populated_orig_transaction_type_pcnt *   0.00 / 100 + T.Populated_orig_neighbors_pcnt *   0.00 / 100 + T.Populated_orig_relatives_pcnt *   0.00 / 100 + T.Populated_orig_associates_pcnt *   0.00 / 100 + T.Populated_orig_property_pcnt *   0.00 / 100 + T.Populated_orig_company_id_pcnt *   0.00 / 100 + T.Populated_orig_reference_code_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_free_pcnt *   0.00 / 100 + T.Populated_orig_record_count_pcnt *   0.00 / 100 + T.Populated_orig_price_pcnt *   0.00 / 100 + T.Populated_orig_bankruptcy_pcnt *   0.00 / 100 + T.Populated_orig_transaction_code_pcnt *   0.00 / 100 + T.Populated_orig_dateadded_pcnt *   0.00 / 100 + T.Populated_orig_full_name_pcnt *   0.00 / 100 + T.Populated_orig_billingdate_pcnt *   0.00 / 100 + T.Populated_orig_business_name_pcnt *   0.00 / 100 + T.Populated_orig_pricing_error_code_pcnt *   0.00 / 100 + T.Populated_orig_dl_purpose_pcnt *   0.00 / 100 + T.Populated_orig_result_format_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_unique_id_pcnt *   0.00 / 100 + T.Populated_orig_dls_pcnt *   0.00 / 100 + T.Populated_orig_mvs_pcnt *   0.00 / 100 + T.Populated_orig_function_name_pcnt *   0.00 / 100 + T.Populated_orig_response_time_pcnt *   0.00 / 100 + T.Populated_orig_data_source_pcnt *   0.00 / 100 + T.Populated_orig_glb_purpose_pcnt *   0.00 / 100 + T.Populated_orig_report_options_pcnt *   0.00 / 100 + T.Populated_orig_unused_pcnt *   0.00 / 100 + T.Populated_orig_login_history_id_pcnt *   0.00 / 100 + T.Populated_orig_aseid_pcnt *   0.00 / 100 + T.Populated_orig_years_pcnt *   0.00 / 100 + T.Populated_orig_ip_address_pcnt *   0.00 / 100 + T.Populated_orig_source_code_pcnt *   0.00 / 100 + T.Populated_orig_retail_price_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_end_user_id_pcnt,le.populated_orig_loginid_pcnt,le.populated_orig_billing_code_pcnt,le.populated_orig_transaction_id_pcnt,le.populated_orig_transaction_type_pcnt,le.populated_orig_neighbors_pcnt,le.populated_orig_relatives_pcnt,le.populated_orig_associates_pcnt,le.populated_orig_property_pcnt,le.populated_orig_company_id_pcnt,le.populated_orig_reference_code_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_address_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_free_pcnt,le.populated_orig_record_count_pcnt,le.populated_orig_price_pcnt,le.populated_orig_bankruptcy_pcnt,le.populated_orig_transaction_code_pcnt,le.populated_orig_dateadded_pcnt,le.populated_orig_full_name_pcnt,le.populated_orig_billingdate_pcnt,le.populated_orig_business_name_pcnt,le.populated_orig_pricing_error_code_pcnt,le.populated_orig_dl_purpose_pcnt,le.populated_orig_result_format_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_unique_id_pcnt,le.populated_orig_dls_pcnt,le.populated_orig_mvs_pcnt,le.populated_orig_function_name_pcnt,le.populated_orig_response_time_pcnt,le.populated_orig_data_source_pcnt,le.populated_orig_glb_purpose_pcnt,le.populated_orig_report_options_pcnt,le.populated_orig_unused_pcnt,le.populated_orig_login_history_id_pcnt,le.populated_orig_aseid_pcnt,le.populated_orig_years_pcnt,le.populated_orig_ip_address_pcnt,le.populated_orig_source_code_pcnt,le.populated_orig_retail_price_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_end_user_id,le.maxlength_orig_loginid,le.maxlength_orig_billing_code,le.maxlength_orig_transaction_id,le.maxlength_orig_transaction_type,le.maxlength_orig_neighbors,le.maxlength_orig_relatives,le.maxlength_orig_associates,le.maxlength_orig_property,le.maxlength_orig_company_id,le.maxlength_orig_reference_code,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_address,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_zip4,le.maxlength_orig_phone,le.maxlength_orig_ssn,le.maxlength_orig_free,le.maxlength_orig_record_count,le.maxlength_orig_price,le.maxlength_orig_bankruptcy,le.maxlength_orig_transaction_code,le.maxlength_orig_dateadded,le.maxlength_orig_full_name,le.maxlength_orig_billingdate,le.maxlength_orig_business_name,le.maxlength_orig_pricing_error_code,le.maxlength_orig_dl_purpose,le.maxlength_orig_result_format,le.maxlength_orig_dob,le.maxlength_orig_unique_id,le.maxlength_orig_dls,le.maxlength_orig_mvs,le.maxlength_orig_function_name,le.maxlength_orig_response_time,le.maxlength_orig_data_source,le.maxlength_orig_glb_purpose,le.maxlength_orig_report_options,le.maxlength_orig_unused,le.maxlength_orig_login_history_id,le.maxlength_orig_aseid,le.maxlength_orig_years,le.maxlength_orig_ip_address,le.maxlength_orig_source_code,le.maxlength_orig_retail_price);
  SELF.avelength := CHOOSE(C,le.avelength_orig_end_user_id,le.avelength_orig_loginid,le.avelength_orig_billing_code,le.avelength_orig_transaction_id,le.avelength_orig_transaction_type,le.avelength_orig_neighbors,le.avelength_orig_relatives,le.avelength_orig_associates,le.avelength_orig_property,le.avelength_orig_company_id,le.avelength_orig_reference_code,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_address,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_zip4,le.avelength_orig_phone,le.avelength_orig_ssn,le.avelength_orig_free,le.avelength_orig_record_count,le.avelength_orig_price,le.avelength_orig_bankruptcy,le.avelength_orig_transaction_code,le.avelength_orig_dateadded,le.avelength_orig_full_name,le.avelength_orig_billingdate,le.avelength_orig_business_name,le.avelength_orig_pricing_error_code,le.avelength_orig_dl_purpose,le.avelength_orig_result_format,le.avelength_orig_dob,le.avelength_orig_unique_id,le.avelength_orig_dls,le.avelength_orig_mvs,le.avelength_orig_function_name,le.avelength_orig_response_time,le.avelength_orig_data_source,le.avelength_orig_glb_purpose,le.avelength_orig_report_options,le.avelength_orig_unused,le.avelength_orig_login_history_id,le.avelength_orig_aseid,le.avelength_orig_years,le.avelength_orig_ip_address,le.avelength_orig_source_code,le.avelength_orig_retail_price);
END;
EXPORT invSummary := NORMALIZE(summary0, 49, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.orig_end_user_id),TRIM((SALT39.StrType)le.orig_loginid),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_transaction_type),TRIM((SALT39.StrType)le.orig_neighbors),TRIM((SALT39.StrType)le.orig_relatives),TRIM((SALT39.StrType)le.orig_associates),TRIM((SALT39.StrType)le.orig_property),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_bankruptcy),TRIM((SALT39.StrType)le.orig_transaction_code),TRIM((SALT39.StrType)le.orig_dateadded),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_billingdate),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_dl_purpose),TRIM((SALT39.StrType)le.orig_result_format),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_dls),TRIM((SALT39.StrType)le.orig_mvs),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_response_time),TRIM((SALT39.StrType)le.orig_data_source),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_report_options),TRIM((SALT39.StrType)le.orig_unused),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_aseid),TRIM((SALT39.StrType)le.orig_years),TRIM((SALT39.StrType)le.orig_ip_address),TRIM((SALT39.StrType)le.orig_source_code),TRIM((SALT39.StrType)le.orig_retail_price)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,49,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 49);
  SELF.FldNo2 := 1 + (C % 49);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.orig_end_user_id),TRIM((SALT39.StrType)le.orig_loginid),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_transaction_type),TRIM((SALT39.StrType)le.orig_neighbors),TRIM((SALT39.StrType)le.orig_relatives),TRIM((SALT39.StrType)le.orig_associates),TRIM((SALT39.StrType)le.orig_property),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_bankruptcy),TRIM((SALT39.StrType)le.orig_transaction_code),TRIM((SALT39.StrType)le.orig_dateadded),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_billingdate),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_dl_purpose),TRIM((SALT39.StrType)le.orig_result_format),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_dls),TRIM((SALT39.StrType)le.orig_mvs),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_response_time),TRIM((SALT39.StrType)le.orig_data_source),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_report_options),TRIM((SALT39.StrType)le.orig_unused),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_aseid),TRIM((SALT39.StrType)le.orig_years),TRIM((SALT39.StrType)le.orig_ip_address),TRIM((SALT39.StrType)le.orig_source_code),TRIM((SALT39.StrType)le.orig_retail_price)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.orig_end_user_id),TRIM((SALT39.StrType)le.orig_loginid),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_transaction_type),TRIM((SALT39.StrType)le.orig_neighbors),TRIM((SALT39.StrType)le.orig_relatives),TRIM((SALT39.StrType)le.orig_associates),TRIM((SALT39.StrType)le.orig_property),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_bankruptcy),TRIM((SALT39.StrType)le.orig_transaction_code),TRIM((SALT39.StrType)le.orig_dateadded),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_billingdate),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_dl_purpose),TRIM((SALT39.StrType)le.orig_result_format),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_dls),TRIM((SALT39.StrType)le.orig_mvs),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_response_time),TRIM((SALT39.StrType)le.orig_data_source),TRIM((SALT39.StrType)le.orig_glb_purpose),TRIM((SALT39.StrType)le.orig_report_options),TRIM((SALT39.StrType)le.orig_unused),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_aseid),TRIM((SALT39.StrType)le.orig_years),TRIM((SALT39.StrType)le.orig_ip_address),TRIM((SALT39.StrType)le.orig_source_code),TRIM((SALT39.StrType)le.orig_retail_price)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),49*49,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_end_user_id'}
      ,{2,'orig_loginid'}
      ,{3,'orig_billing_code'}
      ,{4,'orig_transaction_id'}
      ,{5,'orig_transaction_type'}
      ,{6,'orig_neighbors'}
      ,{7,'orig_relatives'}
      ,{8,'orig_associates'}
      ,{9,'orig_property'}
      ,{10,'orig_company_id'}
      ,{11,'orig_reference_code'}
      ,{12,'orig_fname'}
      ,{13,'orig_mname'}
      ,{14,'orig_lname'}
      ,{15,'orig_address'}
      ,{16,'orig_city'}
      ,{17,'orig_state'}
      ,{18,'orig_zip'}
      ,{19,'orig_zip4'}
      ,{20,'orig_phone'}
      ,{21,'orig_ssn'}
      ,{22,'orig_free'}
      ,{23,'orig_record_count'}
      ,{24,'orig_price'}
      ,{25,'orig_bankruptcy'}
      ,{26,'orig_transaction_code'}
      ,{27,'orig_dateadded'}
      ,{28,'orig_full_name'}
      ,{29,'orig_billingdate'}
      ,{30,'orig_business_name'}
      ,{31,'orig_pricing_error_code'}
      ,{32,'orig_dl_purpose'}
      ,{33,'orig_result_format'}
      ,{34,'orig_dob'}
      ,{35,'orig_unique_id'}
      ,{36,'orig_dls'}
      ,{37,'orig_mvs'}
      ,{38,'orig_function_name'}
      ,{39,'orig_response_time'}
      ,{40,'orig_data_source'}
      ,{41,'orig_glb_purpose'}
      ,{42,'orig_report_options'}
      ,{43,'orig_unused'}
      ,{44,'orig_login_history_id'}
      ,{45,'orig_aseid'}
      ,{46,'orig_years'}
      ,{47,'orig_ip_address'}
      ,{48,'orig_source_code'}
      ,{49,'orig_retail_price'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_end_user_id((SALT39.StrType)le.orig_end_user_id),
    Fields.InValid_orig_loginid((SALT39.StrType)le.orig_loginid),
    Fields.InValid_orig_billing_code((SALT39.StrType)le.orig_billing_code),
    Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id),
    Fields.InValid_orig_transaction_type((SALT39.StrType)le.orig_transaction_type),
    Fields.InValid_orig_neighbors((SALT39.StrType)le.orig_neighbors),
    Fields.InValid_orig_relatives((SALT39.StrType)le.orig_relatives),
    Fields.InValid_orig_associates((SALT39.StrType)le.orig_associates),
    Fields.InValid_orig_property((SALT39.StrType)le.orig_property),
    Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id),
    Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code),
    Fields.InValid_orig_fname((SALT39.StrType)le.orig_fname),
    Fields.InValid_orig_mname((SALT39.StrType)le.orig_mname),
    Fields.InValid_orig_lname((SALT39.StrType)le.orig_lname),
    Fields.InValid_orig_address((SALT39.StrType)le.orig_address),
    Fields.InValid_orig_city((SALT39.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT39.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip),
    Fields.InValid_orig_zip4((SALT39.StrType)le.orig_zip4),
    Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone),
    Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn),
    Fields.InValid_orig_free((SALT39.StrType)le.orig_free),
    Fields.InValid_orig_record_count((SALT39.StrType)le.orig_record_count),
    Fields.InValid_orig_price((SALT39.StrType)le.orig_price),
    Fields.InValid_orig_bankruptcy((SALT39.StrType)le.orig_bankruptcy),
    Fields.InValid_orig_transaction_code((SALT39.StrType)le.orig_transaction_code),
    Fields.InValid_orig_dateadded((SALT39.StrType)le.orig_dateadded),
    Fields.InValid_orig_full_name((SALT39.StrType)le.orig_full_name),
    Fields.InValid_orig_billingdate((SALT39.StrType)le.orig_billingdate),
    Fields.InValid_orig_business_name((SALT39.StrType)le.orig_business_name),
    Fields.InValid_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code),
    Fields.InValid_orig_dl_purpose((SALT39.StrType)le.orig_dl_purpose),
    Fields.InValid_orig_result_format((SALT39.StrType)le.orig_result_format),
    Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob),
    Fields.InValid_orig_unique_id((SALT39.StrType)le.orig_unique_id),
    Fields.InValid_orig_dls((SALT39.StrType)le.orig_dls),
    Fields.InValid_orig_mvs((SALT39.StrType)le.orig_mvs),
    Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name),
    Fields.InValid_orig_response_time((SALT39.StrType)le.orig_response_time),
    Fields.InValid_orig_data_source((SALT39.StrType)le.orig_data_source),
    Fields.InValid_orig_glb_purpose((SALT39.StrType)le.orig_glb_purpose),
    Fields.InValid_orig_report_options((SALT39.StrType)le.orig_report_options),
    Fields.InValid_orig_unused((SALT39.StrType)le.orig_unused),
    Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id),
    Fields.InValid_orig_aseid((SALT39.StrType)le.orig_aseid),
    Fields.InValid_orig_years((SALT39.StrType)le.orig_years),
    Fields.InValid_orig_ip_address((SALT39.StrType)le.orig_ip_address),
    Fields.InValid_orig_source_code((SALT39.StrType)le.orig_source_code),
    Fields.InValid_orig_retail_price((SALT39.StrType)le.orig_retail_price),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,49,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_end_user_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_loginid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_billing_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_transaction_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_neighbors(TotalErrors.ErrorNum),Fields.InValidMessage_orig_relatives(TotalErrors.ErrorNum),Fields.InValidMessage_orig_associates(TotalErrors.ErrorNum),Fields.InValidMessage_orig_property(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_reference_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_free(TotalErrors.ErrorNum),Fields.InValidMessage_orig_record_count(TotalErrors.ErrorNum),Fields.InValidMessage_orig_price(TotalErrors.ErrorNum),Fields.InValidMessage_orig_bankruptcy(TotalErrors.ErrorNum),Fields.InValidMessage_orig_transaction_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dateadded(TotalErrors.ErrorNum),Fields.InValidMessage_orig_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_billingdate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_business_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pricing_error_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_result_format(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_unique_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dls(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mvs(TotalErrors.ErrorNum),Fields.InValidMessage_orig_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_response_time(TotalErrors.ErrorNum),Fields.InValidMessage_orig_data_source(TotalErrors.ErrorNum),Fields.InValidMessage_orig_glb_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_report_options(TotalErrors.ErrorNum),Fields.InValidMessage_orig_unused(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_aseid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_years(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_retail_price(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nfcra_Accurint, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
