IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_FILE) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_login_id_cnt := COUNT(GROUP,h.orig_login_id <> (TYPEOF(h.orig_login_id))'');
    populated_orig_login_id_pcnt := AVE(GROUP,IF(h.orig_login_id = (TYPEOF(h.orig_login_id))'',0,100));
    maxlength_orig_login_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_id)));
    avelength_orig_login_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_id)),h.orig_login_id<>(typeof(h.orig_login_id))'');
    populated_orig_billing_code_cnt := COUNT(GROUP,h.orig_billing_code <> (TYPEOF(h.orig_billing_code))'');
    populated_orig_billing_code_pcnt := AVE(GROUP,IF(h.orig_billing_code = (TYPEOF(h.orig_billing_code))'',0,100));
    maxlength_orig_billing_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billing_code)));
    avelength_orig_billing_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billing_code)),h.orig_billing_code<>(typeof(h.orig_billing_code))'');
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
    populated_orig_name_suffix_cnt := COUNT(GROUP,h.orig_name_suffix <> (TYPEOF(h.orig_name_suffix))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_orig_fname_2_cnt := COUNT(GROUP,h.orig_fname_2 <> (TYPEOF(h.orig_fname_2))'');
    populated_orig_fname_2_pcnt := AVE(GROUP,IF(h.orig_fname_2 = (TYPEOF(h.orig_fname_2))'',0,100));
    maxlength_orig_fname_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname_2)));
    avelength_orig_fname_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname_2)),h.orig_fname_2<>(typeof(h.orig_fname_2))'');
    populated_orig_mname_2_cnt := COUNT(GROUP,h.orig_mname_2 <> (TYPEOF(h.orig_mname_2))'');
    populated_orig_mname_2_pcnt := AVE(GROUP,IF(h.orig_mname_2 = (TYPEOF(h.orig_mname_2))'',0,100));
    maxlength_orig_mname_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname_2)));
    avelength_orig_mname_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname_2)),h.orig_mname_2<>(typeof(h.orig_mname_2))'');
    populated_orig_lname_2_cnt := COUNT(GROUP,h.orig_lname_2 <> (TYPEOF(h.orig_lname_2))'');
    populated_orig_lname_2_pcnt := AVE(GROUP,IF(h.orig_lname_2 = (TYPEOF(h.orig_lname_2))'',0,100));
    maxlength_orig_lname_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname_2)));
    avelength_orig_lname_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname_2)),h.orig_lname_2<>(typeof(h.orig_lname_2))'');
    populated_orig_name_suffix_2_cnt := COUNT(GROUP,h.orig_name_suffix_2 <> (TYPEOF(h.orig_name_suffix_2))'');
    populated_orig_name_suffix_2_pcnt := AVE(GROUP,IF(h.orig_name_suffix_2 = (TYPEOF(h.orig_name_suffix_2))'',0,100));
    maxlength_orig_name_suffix_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_suffix_2)));
    avelength_orig_name_suffix_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_name_suffix_2)),h.orig_name_suffix_2<>(typeof(h.orig_name_suffix_2))'');
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
    populated_orig_address_2_cnt := COUNT(GROUP,h.orig_address_2 <> (TYPEOF(h.orig_address_2))'');
    populated_orig_address_2_pcnt := AVE(GROUP,IF(h.orig_address_2 = (TYPEOF(h.orig_address_2))'',0,100));
    maxlength_orig_address_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address_2)));
    avelength_orig_address_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address_2)),h.orig_address_2<>(typeof(h.orig_address_2))'');
    populated_orig_city_2_cnt := COUNT(GROUP,h.orig_city_2 <> (TYPEOF(h.orig_city_2))'');
    populated_orig_city_2_pcnt := AVE(GROUP,IF(h.orig_city_2 = (TYPEOF(h.orig_city_2))'',0,100));
    maxlength_orig_city_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city_2)));
    avelength_orig_city_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city_2)),h.orig_city_2<>(typeof(h.orig_city_2))'');
    populated_orig_state_2_cnt := COUNT(GROUP,h.orig_state_2 <> (TYPEOF(h.orig_state_2))'');
    populated_orig_state_2_pcnt := AVE(GROUP,IF(h.orig_state_2 = (TYPEOF(h.orig_state_2))'',0,100));
    maxlength_orig_state_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state_2)));
    avelength_orig_state_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state_2)),h.orig_state_2<>(typeof(h.orig_state_2))'');
    populated_orig_zip_2_cnt := COUNT(GROUP,h.orig_zip_2 <> (TYPEOF(h.orig_zip_2))'');
    populated_orig_zip_2_pcnt := AVE(GROUP,IF(h.orig_zip_2 = (TYPEOF(h.orig_zip_2))'',0,100));
    maxlength_orig_zip_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip_2)));
    avelength_orig_zip_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip_2)),h.orig_zip_2<>(typeof(h.orig_zip_2))'');
    populated_orig_zip4_2_cnt := COUNT(GROUP,h.orig_zip4_2 <> (TYPEOF(h.orig_zip4_2))'');
    populated_orig_zip4_2_pcnt := AVE(GROUP,IF(h.orig_zip4_2 = (TYPEOF(h.orig_zip4_2))'',0,100));
    maxlength_orig_zip4_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip4_2)));
    avelength_orig_zip4_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip4_2)),h.orig_zip4_2<>(typeof(h.orig_zip4_2))'');
    populated_orig_clean_address_cnt := COUNT(GROUP,h.orig_clean_address <> (TYPEOF(h.orig_clean_address))'');
    populated_orig_clean_address_pcnt := AVE(GROUP,IF(h.orig_clean_address = (TYPEOF(h.orig_clean_address))'',0,100));
    maxlength_orig_clean_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_address)));
    avelength_orig_clean_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_address)),h.orig_clean_address<>(typeof(h.orig_clean_address))'');
    populated_orig_clean_city_cnt := COUNT(GROUP,h.orig_clean_city <> (TYPEOF(h.orig_clean_city))'');
    populated_orig_clean_city_pcnt := AVE(GROUP,IF(h.orig_clean_city = (TYPEOF(h.orig_clean_city))'',0,100));
    maxlength_orig_clean_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_city)));
    avelength_orig_clean_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_city)),h.orig_clean_city<>(typeof(h.orig_clean_city))'');
    populated_orig_clean_state_cnt := COUNT(GROUP,h.orig_clean_state <> (TYPEOF(h.orig_clean_state))'');
    populated_orig_clean_state_pcnt := AVE(GROUP,IF(h.orig_clean_state = (TYPEOF(h.orig_clean_state))'',0,100));
    maxlength_orig_clean_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_state)));
    avelength_orig_clean_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_state)),h.orig_clean_state<>(typeof(h.orig_clean_state))'');
    populated_orig_clean_zip_cnt := COUNT(GROUP,h.orig_clean_zip <> (TYPEOF(h.orig_clean_zip))'');
    populated_orig_clean_zip_pcnt := AVE(GROUP,IF(h.orig_clean_zip = (TYPEOF(h.orig_clean_zip))'',0,100));
    maxlength_orig_clean_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_zip)));
    avelength_orig_clean_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_zip)),h.orig_clean_zip<>(typeof(h.orig_clean_zip))'');
    populated_orig_clean_zip4_cnt := COUNT(GROUP,h.orig_clean_zip4 <> (TYPEOF(h.orig_clean_zip4))'');
    populated_orig_clean_zip4_pcnt := AVE(GROUP,IF(h.orig_clean_zip4 = (TYPEOF(h.orig_clean_zip4))'',0,100));
    maxlength_orig_clean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_zip4)));
    avelength_orig_clean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_clean_zip4)),h.orig_clean_zip4<>(typeof(h.orig_clean_zip4))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_homephone_cnt := COUNT(GROUP,h.orig_homephone <> (TYPEOF(h.orig_homephone))'');
    populated_orig_homephone_pcnt := AVE(GROUP,IF(h.orig_homephone = (TYPEOF(h.orig_homephone))'',0,100));
    maxlength_orig_homephone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_homephone)));
    avelength_orig_homephone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_homephone)),h.orig_homephone<>(typeof(h.orig_homephone))'');
    populated_orig_homephone_2_cnt := COUNT(GROUP,h.orig_homephone_2 <> (TYPEOF(h.orig_homephone_2))'');
    populated_orig_homephone_2_pcnt := AVE(GROUP,IF(h.orig_homephone_2 = (TYPEOF(h.orig_homephone_2))'',0,100));
    maxlength_orig_homephone_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_homephone_2)));
    avelength_orig_homephone_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_homephone_2)),h.orig_homephone_2<>(typeof(h.orig_homephone_2))'');
    populated_orig_workphone_cnt := COUNT(GROUP,h.orig_workphone <> (TYPEOF(h.orig_workphone))'');
    populated_orig_workphone_pcnt := AVE(GROUP,IF(h.orig_workphone = (TYPEOF(h.orig_workphone))'',0,100));
    maxlength_orig_workphone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_workphone)));
    avelength_orig_workphone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_workphone)),h.orig_workphone<>(typeof(h.orig_workphone))'');
    populated_orig_workphone_2_cnt := COUNT(GROUP,h.orig_workphone_2 <> (TYPEOF(h.orig_workphone_2))'');
    populated_orig_workphone_2_pcnt := AVE(GROUP,IF(h.orig_workphone_2 = (TYPEOF(h.orig_workphone_2))'',0,100));
    maxlength_orig_workphone_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_workphone_2)));
    avelength_orig_workphone_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_workphone_2)),h.orig_workphone_2<>(typeof(h.orig_workphone_2))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_ssn_2_cnt := COUNT(GROUP,h.orig_ssn_2 <> (TYPEOF(h.orig_ssn_2))'');
    populated_orig_ssn_2_pcnt := AVE(GROUP,IF(h.orig_ssn_2 = (TYPEOF(h.orig_ssn_2))'',0,100));
    maxlength_orig_ssn_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn_2)));
    avelength_orig_ssn_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn_2)),h.orig_ssn_2<>(typeof(h.orig_ssn_2))'');
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
    populated_orig_revenue_cnt := COUNT(GROUP,h.orig_revenue <> (TYPEOF(h.orig_revenue))'');
    populated_orig_revenue_pcnt := AVE(GROUP,IF(h.orig_revenue = (TYPEOF(h.orig_revenue))'',0,100));
    maxlength_orig_revenue := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_revenue)));
    avelength_orig_revenue := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_revenue)),h.orig_revenue<>(typeof(h.orig_revenue))'');
    populated_orig_full_name_cnt := COUNT(GROUP,h.orig_full_name <> (TYPEOF(h.orig_full_name))'');
    populated_orig_full_name_pcnt := AVE(GROUP,IF(h.orig_full_name = (TYPEOF(h.orig_full_name))'',0,100));
    maxlength_orig_full_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_full_name)));
    avelength_orig_full_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_full_name)),h.orig_full_name<>(typeof(h.orig_full_name))'');
    populated_orig_business_name_cnt := COUNT(GROUP,h.orig_business_name <> (TYPEOF(h.orig_business_name))'');
    populated_orig_business_name_pcnt := AVE(GROUP,IF(h.orig_business_name = (TYPEOF(h.orig_business_name))'',0,100));
    maxlength_orig_business_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name)));
    avelength_orig_business_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name)),h.orig_business_name<>(typeof(h.orig_business_name))'');
    populated_orig_business_name_2_cnt := COUNT(GROUP,h.orig_business_name_2 <> (TYPEOF(h.orig_business_name_2))'');
    populated_orig_business_name_2_pcnt := AVE(GROUP,IF(h.orig_business_name_2 = (TYPEOF(h.orig_business_name_2))'',0,100));
    maxlength_orig_business_name_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name_2)));
    avelength_orig_business_name_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_business_name_2)),h.orig_business_name_2<>(typeof(h.orig_business_name_2))'');
    populated_orig_years_cnt := COUNT(GROUP,h.orig_years <> (TYPEOF(h.orig_years))'');
    populated_orig_years_pcnt := AVE(GROUP,IF(h.orig_years = (TYPEOF(h.orig_years))'',0,100));
    maxlength_orig_years := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_years)));
    avelength_orig_years := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_years)),h.orig_years<>(typeof(h.orig_years))'');
    populated_orig_pricing_error_code_cnt := COUNT(GROUP,h.orig_pricing_error_code <> (TYPEOF(h.orig_pricing_error_code))'');
    populated_orig_pricing_error_code_pcnt := AVE(GROUP,IF(h.orig_pricing_error_code = (TYPEOF(h.orig_pricing_error_code))'',0,100));
    maxlength_orig_pricing_error_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_pricing_error_code)));
    avelength_orig_pricing_error_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_pricing_error_code)),h.orig_pricing_error_code<>(typeof(h.orig_pricing_error_code))'');
    populated_orig_fcra_purpose_cnt := COUNT(GROUP,h.orig_fcra_purpose <> (TYPEOF(h.orig_fcra_purpose))'');
    populated_orig_fcra_purpose_pcnt := AVE(GROUP,IF(h.orig_fcra_purpose = (TYPEOF(h.orig_fcra_purpose))'',0,100));
    maxlength_orig_fcra_purpose := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra_purpose)));
    avelength_orig_fcra_purpose := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra_purpose)),h.orig_fcra_purpose<>(typeof(h.orig_fcra_purpose))'');
    populated_orig_result_format_cnt := COUNT(GROUP,h.orig_result_format <> (TYPEOF(h.orig_result_format))'');
    populated_orig_result_format_pcnt := AVE(GROUP,IF(h.orig_result_format = (TYPEOF(h.orig_result_format))'',0,100));
    maxlength_orig_result_format := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_result_format)));
    avelength_orig_result_format := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_result_format)),h.orig_result_format<>(typeof(h.orig_result_format))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_dob_2_cnt := COUNT(GROUP,h.orig_dob_2 <> (TYPEOF(h.orig_dob_2))'');
    populated_orig_dob_2_pcnt := AVE(GROUP,IF(h.orig_dob_2 = (TYPEOF(h.orig_dob_2))'',0,100));
    maxlength_orig_dob_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob_2)));
    avelength_orig_dob_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob_2)),h.orig_dob_2<>(typeof(h.orig_dob_2))'');
    populated_orig_unique_id_cnt := COUNT(GROUP,h.orig_unique_id <> (TYPEOF(h.orig_unique_id))'');
    populated_orig_unique_id_pcnt := AVE(GROUP,IF(h.orig_unique_id = (TYPEOF(h.orig_unique_id))'',0,100));
    maxlength_orig_unique_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unique_id)));
    avelength_orig_unique_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_unique_id)),h.orig_unique_id<>(typeof(h.orig_unique_id))'');
    populated_orig_response_time_cnt := COUNT(GROUP,h.orig_response_time <> (TYPEOF(h.orig_response_time))'');
    populated_orig_response_time_pcnt := AVE(GROUP,IF(h.orig_response_time = (TYPEOF(h.orig_response_time))'',0,100));
    maxlength_orig_response_time := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_response_time)));
    avelength_orig_response_time := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_response_time)),h.orig_response_time<>(typeof(h.orig_response_time))'');
    populated_orig_data_source_cnt := COUNT(GROUP,h.orig_data_source <> (TYPEOF(h.orig_data_source))'');
    populated_orig_data_source_pcnt := AVE(GROUP,IF(h.orig_data_source = (TYPEOF(h.orig_data_source))'',0,100));
    maxlength_orig_data_source := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_data_source)));
    avelength_orig_data_source := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_data_source)),h.orig_data_source<>(typeof(h.orig_data_source))'');
    populated_orig_report_options_cnt := COUNT(GROUP,h.orig_report_options <> (TYPEOF(h.orig_report_options))'');
    populated_orig_report_options_pcnt := AVE(GROUP,IF(h.orig_report_options = (TYPEOF(h.orig_report_options))'',0,100));
    maxlength_orig_report_options := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_report_options)));
    avelength_orig_report_options := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_report_options)),h.orig_report_options<>(typeof(h.orig_report_options))'');
    populated_orig_end_user_name_cnt := COUNT(GROUP,h.orig_end_user_name <> (TYPEOF(h.orig_end_user_name))'');
    populated_orig_end_user_name_pcnt := AVE(GROUP,IF(h.orig_end_user_name = (TYPEOF(h.orig_end_user_name))'',0,100));
    maxlength_orig_end_user_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_name)));
    avelength_orig_end_user_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_name)),h.orig_end_user_name<>(typeof(h.orig_end_user_name))'');
    populated_orig_end_user_address_1_cnt := COUNT(GROUP,h.orig_end_user_address_1 <> (TYPEOF(h.orig_end_user_address_1))'');
    populated_orig_end_user_address_1_pcnt := AVE(GROUP,IF(h.orig_end_user_address_1 = (TYPEOF(h.orig_end_user_address_1))'',0,100));
    maxlength_orig_end_user_address_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_address_1)));
    avelength_orig_end_user_address_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_address_1)),h.orig_end_user_address_1<>(typeof(h.orig_end_user_address_1))'');
    populated_orig_end_user_address_2_cnt := COUNT(GROUP,h.orig_end_user_address_2 <> (TYPEOF(h.orig_end_user_address_2))'');
    populated_orig_end_user_address_2_pcnt := AVE(GROUP,IF(h.orig_end_user_address_2 = (TYPEOF(h.orig_end_user_address_2))'',0,100));
    maxlength_orig_end_user_address_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_address_2)));
    avelength_orig_end_user_address_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_address_2)),h.orig_end_user_address_2<>(typeof(h.orig_end_user_address_2))'');
    populated_orig_end_user_city_cnt := COUNT(GROUP,h.orig_end_user_city <> (TYPEOF(h.orig_end_user_city))'');
    populated_orig_end_user_city_pcnt := AVE(GROUP,IF(h.orig_end_user_city = (TYPEOF(h.orig_end_user_city))'',0,100));
    maxlength_orig_end_user_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_city)));
    avelength_orig_end_user_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_city)),h.orig_end_user_city<>(typeof(h.orig_end_user_city))'');
    populated_orig_end_user_state_cnt := COUNT(GROUP,h.orig_end_user_state <> (TYPEOF(h.orig_end_user_state))'');
    populated_orig_end_user_state_pcnt := AVE(GROUP,IF(h.orig_end_user_state = (TYPEOF(h.orig_end_user_state))'',0,100));
    maxlength_orig_end_user_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_state)));
    avelength_orig_end_user_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_state)),h.orig_end_user_state<>(typeof(h.orig_end_user_state))'');
    populated_orig_end_user_zip_cnt := COUNT(GROUP,h.orig_end_user_zip <> (TYPEOF(h.orig_end_user_zip))'');
    populated_orig_end_user_zip_pcnt := AVE(GROUP,IF(h.orig_end_user_zip = (TYPEOF(h.orig_end_user_zip))'',0,100));
    maxlength_orig_end_user_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_zip)));
    avelength_orig_end_user_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_zip)),h.orig_end_user_zip<>(typeof(h.orig_end_user_zip))'');
    populated_orig_login_history_id_cnt := COUNT(GROUP,h.orig_login_history_id <> (TYPEOF(h.orig_login_history_id))'');
    populated_orig_login_history_id_pcnt := AVE(GROUP,IF(h.orig_login_history_id = (TYPEOF(h.orig_login_history_id))'',0,100));
    maxlength_orig_login_history_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)));
    avelength_orig_login_history_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_login_history_id)),h.orig_login_history_id<>(typeof(h.orig_login_history_id))'');
    populated_orig_employment_state_cnt := COUNT(GROUP,h.orig_employment_state <> (TYPEOF(h.orig_employment_state))'');
    populated_orig_employment_state_pcnt := AVE(GROUP,IF(h.orig_employment_state = (TYPEOF(h.orig_employment_state))'',0,100));
    maxlength_orig_employment_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_employment_state)));
    avelength_orig_employment_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_employment_state)),h.orig_employment_state<>(typeof(h.orig_employment_state))'');
    populated_orig_end_user_industry_class_cnt := COUNT(GROUP,h.orig_end_user_industry_class <> (TYPEOF(h.orig_end_user_industry_class))'');
    populated_orig_end_user_industry_class_pcnt := AVE(GROUP,IF(h.orig_end_user_industry_class = (TYPEOF(h.orig_end_user_industry_class))'',0,100));
    maxlength_orig_end_user_industry_class := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_industry_class)));
    avelength_orig_end_user_industry_class := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_end_user_industry_class)),h.orig_end_user_industry_class<>(typeof(h.orig_end_user_industry_class))'');
    populated_orig_function_specific_data_cnt := COUNT(GROUP,h.orig_function_specific_data <> (TYPEOF(h.orig_function_specific_data))'');
    populated_orig_function_specific_data_pcnt := AVE(GROUP,IF(h.orig_function_specific_data = (TYPEOF(h.orig_function_specific_data))'',0,100));
    maxlength_orig_function_specific_data := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_specific_data)));
    avelength_orig_function_specific_data := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_specific_data)),h.orig_function_specific_data<>(typeof(h.orig_function_specific_data))'');
    populated_orig_date_added_cnt := COUNT(GROUP,h.orig_date_added <> (TYPEOF(h.orig_date_added))'');
    populated_orig_date_added_pcnt := AVE(GROUP,IF(h.orig_date_added = (TYPEOF(h.orig_date_added))'',0,100));
    maxlength_orig_date_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_date_added)));
    avelength_orig_date_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_date_added)),h.orig_date_added<>(typeof(h.orig_date_added))'');
    populated_orig_retail_price_cnt := COUNT(GROUP,h.orig_retail_price <> (TYPEOF(h.orig_retail_price))'');
    populated_orig_retail_price_pcnt := AVE(GROUP,IF(h.orig_retail_price = (TYPEOF(h.orig_retail_price))'',0,100));
    maxlength_orig_retail_price := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_retail_price)));
    avelength_orig_retail_price := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_retail_price)),h.orig_retail_price<>(typeof(h.orig_retail_price))'');
    populated_orig_country_code_cnt := COUNT(GROUP,h.orig_country_code <> (TYPEOF(h.orig_country_code))'');
    populated_orig_country_code_pcnt := AVE(GROUP,IF(h.orig_country_code = (TYPEOF(h.orig_country_code))'',0,100));
    maxlength_orig_country_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_country_code)));
    avelength_orig_country_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_country_code)),h.orig_country_code<>(typeof(h.orig_country_code))'');
    populated_orig_email_cnt := COUNT(GROUP,h.orig_email <> (TYPEOF(h.orig_email))'');
    populated_orig_email_pcnt := AVE(GROUP,IF(h.orig_email = (TYPEOF(h.orig_email))'',0,100));
    maxlength_orig_email := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email)));
    avelength_orig_email := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email)),h.orig_email<>(typeof(h.orig_email))'');
    populated_orig_email_2_cnt := COUNT(GROUP,h.orig_email_2 <> (TYPEOF(h.orig_email_2))'');
    populated_orig_email_2_pcnt := AVE(GROUP,IF(h.orig_email_2 = (TYPEOF(h.orig_email_2))'',0,100));
    maxlength_orig_email_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email_2)));
    avelength_orig_email_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_email_2)),h.orig_email_2<>(typeof(h.orig_email_2))'');
    populated_orig_dl_number_cnt := COUNT(GROUP,h.orig_dl_number <> (TYPEOF(h.orig_dl_number))'');
    populated_orig_dl_number_pcnt := AVE(GROUP,IF(h.orig_dl_number = (TYPEOF(h.orig_dl_number))'',0,100));
    maxlength_orig_dl_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_number)));
    avelength_orig_dl_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_number)),h.orig_dl_number<>(typeof(h.orig_dl_number))'');
    populated_orig_dl_number_2_cnt := COUNT(GROUP,h.orig_dl_number_2 <> (TYPEOF(h.orig_dl_number_2))'');
    populated_orig_dl_number_2_pcnt := AVE(GROUP,IF(h.orig_dl_number_2 = (TYPEOF(h.orig_dl_number_2))'',0,100));
    maxlength_orig_dl_number_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_number_2)));
    avelength_orig_dl_number_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dl_number_2)),h.orig_dl_number_2<>(typeof(h.orig_dl_number_2))'');
    populated_orig_sub_id_cnt := COUNT(GROUP,h.orig_sub_id <> (TYPEOF(h.orig_sub_id))'');
    populated_orig_sub_id_pcnt := AVE(GROUP,IF(h.orig_sub_id = (TYPEOF(h.orig_sub_id))'',0,100));
    maxlength_orig_sub_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_sub_id)));
    avelength_orig_sub_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_sub_id)),h.orig_sub_id<>(typeof(h.orig_sub_id))'');
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
    populated_orig_bankruptcy_cnt := COUNT(GROUP,h.orig_bankruptcy <> (TYPEOF(h.orig_bankruptcy))'');
    populated_orig_bankruptcy_pcnt := AVE(GROUP,IF(h.orig_bankruptcy = (TYPEOF(h.orig_bankruptcy))'',0,100));
    maxlength_orig_bankruptcy := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bankruptcy)));
    avelength_orig_bankruptcy := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_bankruptcy)),h.orig_bankruptcy<>(typeof(h.orig_bankruptcy))'');
    populated_orig_dls_cnt := COUNT(GROUP,h.orig_dls <> (TYPEOF(h.orig_dls))'');
    populated_orig_dls_pcnt := AVE(GROUP,IF(h.orig_dls = (TYPEOF(h.orig_dls))'',0,100));
    maxlength_orig_dls := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dls)));
    avelength_orig_dls := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dls)),h.orig_dls<>(typeof(h.orig_dls))'');
    populated_orig_mvs_cnt := COUNT(GROUP,h.orig_mvs <> (TYPEOF(h.orig_mvs))'');
    populated_orig_mvs_pcnt := AVE(GROUP,IF(h.orig_mvs = (TYPEOF(h.orig_mvs))'',0,100));
    maxlength_orig_mvs := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mvs)));
    avelength_orig_mvs := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mvs)),h.orig_mvs<>(typeof(h.orig_mvs))'');
    populated_orig_ip_address_cnt := COUNT(GROUP,h.orig_ip_address <> (TYPEOF(h.orig_ip_address))'');
    populated_orig_ip_address_pcnt := AVE(GROUP,IF(h.orig_ip_address = (TYPEOF(h.orig_ip_address))'',0,100));
    maxlength_orig_ip_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address)));
    avelength_orig_ip_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ip_address)),h.orig_ip_address<>(typeof(h.orig_ip_address))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_login_id_pcnt *   0.00 / 100 + T.Populated_orig_billing_code_pcnt *   0.00 / 100 + T.Populated_orig_transaction_id_pcnt *   0.00 / 100 + T.Populated_orig_function_name_pcnt *   0.00 / 100 + T.Populated_orig_company_id_pcnt *   0.00 / 100 + T.Populated_orig_reference_code_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_pcnt *   0.00 / 100 + T.Populated_orig_fname_2_pcnt *   0.00 / 100 + T.Populated_orig_mname_2_pcnt *   0.00 / 100 + T.Populated_orig_lname_2_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_2_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_address_2_pcnt *   0.00 / 100 + T.Populated_orig_city_2_pcnt *   0.00 / 100 + T.Populated_orig_state_2_pcnt *   0.00 / 100 + T.Populated_orig_zip_2_pcnt *   0.00 / 100 + T.Populated_orig_zip4_2_pcnt *   0.00 / 100 + T.Populated_orig_clean_address_pcnt *   0.00 / 100 + T.Populated_orig_clean_city_pcnt *   0.00 / 100 + T.Populated_orig_clean_state_pcnt *   0.00 / 100 + T.Populated_orig_clean_zip_pcnt *   0.00 / 100 + T.Populated_orig_clean_zip4_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_homephone_pcnt *   0.00 / 100 + T.Populated_orig_homephone_2_pcnt *   0.00 / 100 + T.Populated_orig_workphone_pcnt *   0.00 / 100 + T.Populated_orig_workphone_2_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_ssn_2_pcnt *   0.00 / 100 + T.Populated_orig_free_pcnt *   0.00 / 100 + T.Populated_orig_record_count_pcnt *   0.00 / 100 + T.Populated_orig_price_pcnt *   0.00 / 100 + T.Populated_orig_revenue_pcnt *   0.00 / 100 + T.Populated_orig_full_name_pcnt *   0.00 / 100 + T.Populated_orig_business_name_pcnt *   0.00 / 100 + T.Populated_orig_business_name_2_pcnt *   0.00 / 100 + T.Populated_orig_years_pcnt *   0.00 / 100 + T.Populated_orig_pricing_error_code_pcnt *   0.00 / 100 + T.Populated_orig_fcra_purpose_pcnt *   0.00 / 100 + T.Populated_orig_result_format_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_dob_2_pcnt *   0.00 / 100 + T.Populated_orig_unique_id_pcnt *   0.00 / 100 + T.Populated_orig_response_time_pcnt *   0.00 / 100 + T.Populated_orig_data_source_pcnt *   0.00 / 100 + T.Populated_orig_report_options_pcnt *   0.00 / 100 + T.Populated_orig_end_user_name_pcnt *   0.00 / 100 + T.Populated_orig_end_user_address_1_pcnt *   0.00 / 100 + T.Populated_orig_end_user_address_2_pcnt *   0.00 / 100 + T.Populated_orig_end_user_city_pcnt *   0.00 / 100 + T.Populated_orig_end_user_state_pcnt *   0.00 / 100 + T.Populated_orig_end_user_zip_pcnt *   0.00 / 100 + T.Populated_orig_login_history_id_pcnt *   0.00 / 100 + T.Populated_orig_employment_state_pcnt *   0.00 / 100 + T.Populated_orig_end_user_industry_class_pcnt *   0.00 / 100 + T.Populated_orig_function_specific_data_pcnt *   0.00 / 100 + T.Populated_orig_date_added_pcnt *   0.00 / 100 + T.Populated_orig_retail_price_pcnt *   0.00 / 100 + T.Populated_orig_country_code_pcnt *   0.00 / 100 + T.Populated_orig_email_pcnt *   0.00 / 100 + T.Populated_orig_email_2_pcnt *   0.00 / 100 + T.Populated_orig_dl_number_pcnt *   0.00 / 100 + T.Populated_orig_dl_number_2_pcnt *   0.00 / 100 + T.Populated_orig_sub_id_pcnt *   0.00 / 100 + T.Populated_orig_neighbors_pcnt *   0.00 / 100 + T.Populated_orig_relatives_pcnt *   0.00 / 100 + T.Populated_orig_associates_pcnt *   0.00 / 100 + T.Populated_orig_property_pcnt *   0.00 / 100 + T.Populated_orig_bankruptcy_pcnt *   0.00 / 100 + T.Populated_orig_dls_pcnt *   0.00 / 100 + T.Populated_orig_mvs_pcnt *   0.00 / 100 + T.Populated_orig_ip_address_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_login_id_pcnt,le.populated_orig_billing_code_pcnt,le.populated_orig_transaction_id_pcnt,le.populated_orig_function_name_pcnt,le.populated_orig_company_id_pcnt,le.populated_orig_reference_code_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_orig_fname_2_pcnt,le.populated_orig_mname_2_pcnt,le.populated_orig_lname_2_pcnt,le.populated_orig_name_suffix_2_pcnt,le.populated_orig_address_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_address_2_pcnt,le.populated_orig_city_2_pcnt,le.populated_orig_state_2_pcnt,le.populated_orig_zip_2_pcnt,le.populated_orig_zip4_2_pcnt,le.populated_orig_clean_address_pcnt,le.populated_orig_clean_city_pcnt,le.populated_orig_clean_state_pcnt,le.populated_orig_clean_zip_pcnt,le.populated_orig_clean_zip4_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_homephone_pcnt,le.populated_orig_homephone_2_pcnt,le.populated_orig_workphone_pcnt,le.populated_orig_workphone_2_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_ssn_2_pcnt,le.populated_orig_free_pcnt,le.populated_orig_record_count_pcnt,le.populated_orig_price_pcnt,le.populated_orig_revenue_pcnt,le.populated_orig_full_name_pcnt,le.populated_orig_business_name_pcnt,le.populated_orig_business_name_2_pcnt,le.populated_orig_years_pcnt,le.populated_orig_pricing_error_code_pcnt,le.populated_orig_fcra_purpose_pcnt,le.populated_orig_result_format_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_dob_2_pcnt,le.populated_orig_unique_id_pcnt,le.populated_orig_response_time_pcnt,le.populated_orig_data_source_pcnt,le.populated_orig_report_options_pcnt,le.populated_orig_end_user_name_pcnt,le.populated_orig_end_user_address_1_pcnt,le.populated_orig_end_user_address_2_pcnt,le.populated_orig_end_user_city_pcnt,le.populated_orig_end_user_state_pcnt,le.populated_orig_end_user_zip_pcnt,le.populated_orig_login_history_id_pcnt,le.populated_orig_employment_state_pcnt,le.populated_orig_end_user_industry_class_pcnt,le.populated_orig_function_specific_data_pcnt,le.populated_orig_date_added_pcnt,le.populated_orig_retail_price_pcnt,le.populated_orig_country_code_pcnt,le.populated_orig_email_pcnt,le.populated_orig_email_2_pcnt,le.populated_orig_dl_number_pcnt,le.populated_orig_dl_number_2_pcnt,le.populated_orig_sub_id_pcnt,le.populated_orig_neighbors_pcnt,le.populated_orig_relatives_pcnt,le.populated_orig_associates_pcnt,le.populated_orig_property_pcnt,le.populated_orig_bankruptcy_pcnt,le.populated_orig_dls_pcnt,le.populated_orig_mvs_pcnt,le.populated_orig_ip_address_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_login_id,le.maxlength_orig_billing_code,le.maxlength_orig_transaction_id,le.maxlength_orig_function_name,le.maxlength_orig_company_id,le.maxlength_orig_reference_code,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_name_suffix,le.maxlength_orig_fname_2,le.maxlength_orig_mname_2,le.maxlength_orig_lname_2,le.maxlength_orig_name_suffix_2,le.maxlength_orig_address,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_zip4,le.maxlength_orig_address_2,le.maxlength_orig_city_2,le.maxlength_orig_state_2,le.maxlength_orig_zip_2,le.maxlength_orig_zip4_2,le.maxlength_orig_clean_address,le.maxlength_orig_clean_city,le.maxlength_orig_clean_state,le.maxlength_orig_clean_zip,le.maxlength_orig_clean_zip4,le.maxlength_orig_phone,le.maxlength_orig_homephone,le.maxlength_orig_homephone_2,le.maxlength_orig_workphone,le.maxlength_orig_workphone_2,le.maxlength_orig_ssn,le.maxlength_orig_ssn_2,le.maxlength_orig_free,le.maxlength_orig_record_count,le.maxlength_orig_price,le.maxlength_orig_revenue,le.maxlength_orig_full_name,le.maxlength_orig_business_name,le.maxlength_orig_business_name_2,le.maxlength_orig_years,le.maxlength_orig_pricing_error_code,le.maxlength_orig_fcra_purpose,le.maxlength_orig_result_format,le.maxlength_orig_dob,le.maxlength_orig_dob_2,le.maxlength_orig_unique_id,le.maxlength_orig_response_time,le.maxlength_orig_data_source,le.maxlength_orig_report_options,le.maxlength_orig_end_user_name,le.maxlength_orig_end_user_address_1,le.maxlength_orig_end_user_address_2,le.maxlength_orig_end_user_city,le.maxlength_orig_end_user_state,le.maxlength_orig_end_user_zip,le.maxlength_orig_login_history_id,le.maxlength_orig_employment_state,le.maxlength_orig_end_user_industry_class,le.maxlength_orig_function_specific_data,le.maxlength_orig_date_added,le.maxlength_orig_retail_price,le.maxlength_orig_country_code,le.maxlength_orig_email,le.maxlength_orig_email_2,le.maxlength_orig_dl_number,le.maxlength_orig_dl_number_2,le.maxlength_orig_sub_id,le.maxlength_orig_neighbors,le.maxlength_orig_relatives,le.maxlength_orig_associates,le.maxlength_orig_property,le.maxlength_orig_bankruptcy,le.maxlength_orig_dls,le.maxlength_orig_mvs,le.maxlength_orig_ip_address);
  SELF.avelength := CHOOSE(C,le.avelength_orig_login_id,le.avelength_orig_billing_code,le.avelength_orig_transaction_id,le.avelength_orig_function_name,le.avelength_orig_company_id,le.avelength_orig_reference_code,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_name_suffix,le.avelength_orig_fname_2,le.avelength_orig_mname_2,le.avelength_orig_lname_2,le.avelength_orig_name_suffix_2,le.avelength_orig_address,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_zip4,le.avelength_orig_address_2,le.avelength_orig_city_2,le.avelength_orig_state_2,le.avelength_orig_zip_2,le.avelength_orig_zip4_2,le.avelength_orig_clean_address,le.avelength_orig_clean_city,le.avelength_orig_clean_state,le.avelength_orig_clean_zip,le.avelength_orig_clean_zip4,le.avelength_orig_phone,le.avelength_orig_homephone,le.avelength_orig_homephone_2,le.avelength_orig_workphone,le.avelength_orig_workphone_2,le.avelength_orig_ssn,le.avelength_orig_ssn_2,le.avelength_orig_free,le.avelength_orig_record_count,le.avelength_orig_price,le.avelength_orig_revenue,le.avelength_orig_full_name,le.avelength_orig_business_name,le.avelength_orig_business_name_2,le.avelength_orig_years,le.avelength_orig_pricing_error_code,le.avelength_orig_fcra_purpose,le.avelength_orig_result_format,le.avelength_orig_dob,le.avelength_orig_dob_2,le.avelength_orig_unique_id,le.avelength_orig_response_time,le.avelength_orig_data_source,le.avelength_orig_report_options,le.avelength_orig_end_user_name,le.avelength_orig_end_user_address_1,le.avelength_orig_end_user_address_2,le.avelength_orig_end_user_city,le.avelength_orig_end_user_state,le.avelength_orig_end_user_zip,le.avelength_orig_login_history_id,le.avelength_orig_employment_state,le.avelength_orig_end_user_industry_class,le.avelength_orig_function_specific_data,le.avelength_orig_date_added,le.avelength_orig_retail_price,le.avelength_orig_country_code,le.avelength_orig_email,le.avelength_orig_email_2,le.avelength_orig_dl_number,le.avelength_orig_dl_number_2,le.avelength_orig_sub_id,le.avelength_orig_neighbors,le.avelength_orig_relatives,le.avelength_orig_associates,le.avelength_orig_property,le.avelength_orig_bankruptcy,le.avelength_orig_dls,le.avelength_orig_mvs,le.avelength_orig_ip_address);
END;
EXPORT invSummary := NORMALIZE(summary0, 79, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.orig_login_id),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_name_suffix),TRIM((SALT39.StrType)le.orig_fname_2),TRIM((SALT39.StrType)le.orig_mname_2),TRIM((SALT39.StrType)le.orig_lname_2),TRIM((SALT39.StrType)le.orig_name_suffix_2),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_address_2),TRIM((SALT39.StrType)le.orig_city_2),TRIM((SALT39.StrType)le.orig_state_2),TRIM((SALT39.StrType)le.orig_zip_2),TRIM((SALT39.StrType)le.orig_zip4_2),TRIM((SALT39.StrType)le.orig_clean_address),TRIM((SALT39.StrType)le.orig_clean_city),TRIM((SALT39.StrType)le.orig_clean_state),TRIM((SALT39.StrType)le.orig_clean_zip),TRIM((SALT39.StrType)le.orig_clean_zip4),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_homephone),TRIM((SALT39.StrType)le.orig_homephone_2),TRIM((SALT39.StrType)le.orig_workphone),TRIM((SALT39.StrType)le.orig_workphone_2),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_ssn_2),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_revenue),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_business_name_2),TRIM((SALT39.StrType)le.orig_years),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_result_format),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dob_2),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_response_time),TRIM((SALT39.StrType)le.orig_data_source),TRIM((SALT39.StrType)le.orig_report_options),TRIM((SALT39.StrType)le.orig_end_user_name),TRIM((SALT39.StrType)le.orig_end_user_address_1),TRIM((SALT39.StrType)le.orig_end_user_address_2),TRIM((SALT39.StrType)le.orig_end_user_city),TRIM((SALT39.StrType)le.orig_end_user_state),TRIM((SALT39.StrType)le.orig_end_user_zip),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_employment_state),TRIM((SALT39.StrType)le.orig_end_user_industry_class),TRIM((SALT39.StrType)le.orig_function_specific_data),TRIM((SALT39.StrType)le.orig_date_added),TRIM((SALT39.StrType)le.orig_retail_price),TRIM((SALT39.StrType)le.orig_country_code),TRIM((SALT39.StrType)le.orig_email),TRIM((SALT39.StrType)le.orig_email_2),TRIM((SALT39.StrType)le.orig_dl_number),TRIM((SALT39.StrType)le.orig_dl_number_2),TRIM((SALT39.StrType)le.orig_sub_id),TRIM((SALT39.StrType)le.orig_neighbors),TRIM((SALT39.StrType)le.orig_relatives),TRIM((SALT39.StrType)le.orig_associates),TRIM((SALT39.StrType)le.orig_property),TRIM((SALT39.StrType)le.orig_bankruptcy),TRIM((SALT39.StrType)le.orig_dls),TRIM((SALT39.StrType)le.orig_mvs),TRIM((SALT39.StrType)le.orig_ip_address)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,79,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 79);
  SELF.FldNo2 := 1 + (C % 79);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.orig_login_id),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_name_suffix),TRIM((SALT39.StrType)le.orig_fname_2),TRIM((SALT39.StrType)le.orig_mname_2),TRIM((SALT39.StrType)le.orig_lname_2),TRIM((SALT39.StrType)le.orig_name_suffix_2),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_address_2),TRIM((SALT39.StrType)le.orig_city_2),TRIM((SALT39.StrType)le.orig_state_2),TRIM((SALT39.StrType)le.orig_zip_2),TRIM((SALT39.StrType)le.orig_zip4_2),TRIM((SALT39.StrType)le.orig_clean_address),TRIM((SALT39.StrType)le.orig_clean_city),TRIM((SALT39.StrType)le.orig_clean_state),TRIM((SALT39.StrType)le.orig_clean_zip),TRIM((SALT39.StrType)le.orig_clean_zip4),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_homephone),TRIM((SALT39.StrType)le.orig_homephone_2),TRIM((SALT39.StrType)le.orig_workphone),TRIM((SALT39.StrType)le.orig_workphone_2),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_ssn_2),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_revenue),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_business_name_2),TRIM((SALT39.StrType)le.orig_years),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_result_format),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dob_2),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_response_time),TRIM((SALT39.StrType)le.orig_data_source),TRIM((SALT39.StrType)le.orig_report_options),TRIM((SALT39.StrType)le.orig_end_user_name),TRIM((SALT39.StrType)le.orig_end_user_address_1),TRIM((SALT39.StrType)le.orig_end_user_address_2),TRIM((SALT39.StrType)le.orig_end_user_city),TRIM((SALT39.StrType)le.orig_end_user_state),TRIM((SALT39.StrType)le.orig_end_user_zip),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_employment_state),TRIM((SALT39.StrType)le.orig_end_user_industry_class),TRIM((SALT39.StrType)le.orig_function_specific_data),TRIM((SALT39.StrType)le.orig_date_added),TRIM((SALT39.StrType)le.orig_retail_price),TRIM((SALT39.StrType)le.orig_country_code),TRIM((SALT39.StrType)le.orig_email),TRIM((SALT39.StrType)le.orig_email_2),TRIM((SALT39.StrType)le.orig_dl_number),TRIM((SALT39.StrType)le.orig_dl_number_2),TRIM((SALT39.StrType)le.orig_sub_id),TRIM((SALT39.StrType)le.orig_neighbors),TRIM((SALT39.StrType)le.orig_relatives),TRIM((SALT39.StrType)le.orig_associates),TRIM((SALT39.StrType)le.orig_property),TRIM((SALT39.StrType)le.orig_bankruptcy),TRIM((SALT39.StrType)le.orig_dls),TRIM((SALT39.StrType)le.orig_mvs),TRIM((SALT39.StrType)le.orig_ip_address)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.orig_login_id),TRIM((SALT39.StrType)le.orig_billing_code),TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_company_id),TRIM((SALT39.StrType)le.orig_reference_code),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_name_suffix),TRIM((SALT39.StrType)le.orig_fname_2),TRIM((SALT39.StrType)le.orig_mname_2),TRIM((SALT39.StrType)le.orig_lname_2),TRIM((SALT39.StrType)le.orig_name_suffix_2),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_zip4),TRIM((SALT39.StrType)le.orig_address_2),TRIM((SALT39.StrType)le.orig_city_2),TRIM((SALT39.StrType)le.orig_state_2),TRIM((SALT39.StrType)le.orig_zip_2),TRIM((SALT39.StrType)le.orig_zip4_2),TRIM((SALT39.StrType)le.orig_clean_address),TRIM((SALT39.StrType)le.orig_clean_city),TRIM((SALT39.StrType)le.orig_clean_state),TRIM((SALT39.StrType)le.orig_clean_zip),TRIM((SALT39.StrType)le.orig_clean_zip4),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_homephone),TRIM((SALT39.StrType)le.orig_homephone_2),TRIM((SALT39.StrType)le.orig_workphone),TRIM((SALT39.StrType)le.orig_workphone_2),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_ssn_2),TRIM((SALT39.StrType)le.orig_free),TRIM((SALT39.StrType)le.orig_record_count),TRIM((SALT39.StrType)le.orig_price),TRIM((SALT39.StrType)le.orig_revenue),TRIM((SALT39.StrType)le.orig_full_name),TRIM((SALT39.StrType)le.orig_business_name),TRIM((SALT39.StrType)le.orig_business_name_2),TRIM((SALT39.StrType)le.orig_years),TRIM((SALT39.StrType)le.orig_pricing_error_code),TRIM((SALT39.StrType)le.orig_fcra_purpose),TRIM((SALT39.StrType)le.orig_result_format),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dob_2),TRIM((SALT39.StrType)le.orig_unique_id),TRIM((SALT39.StrType)le.orig_response_time),TRIM((SALT39.StrType)le.orig_data_source),TRIM((SALT39.StrType)le.orig_report_options),TRIM((SALT39.StrType)le.orig_end_user_name),TRIM((SALT39.StrType)le.orig_end_user_address_1),TRIM((SALT39.StrType)le.orig_end_user_address_2),TRIM((SALT39.StrType)le.orig_end_user_city),TRIM((SALT39.StrType)le.orig_end_user_state),TRIM((SALT39.StrType)le.orig_end_user_zip),TRIM((SALT39.StrType)le.orig_login_history_id),TRIM((SALT39.StrType)le.orig_employment_state),TRIM((SALT39.StrType)le.orig_end_user_industry_class),TRIM((SALT39.StrType)le.orig_function_specific_data),TRIM((SALT39.StrType)le.orig_date_added),TRIM((SALT39.StrType)le.orig_retail_price),TRIM((SALT39.StrType)le.orig_country_code),TRIM((SALT39.StrType)le.orig_email),TRIM((SALT39.StrType)le.orig_email_2),TRIM((SALT39.StrType)le.orig_dl_number),TRIM((SALT39.StrType)le.orig_dl_number_2),TRIM((SALT39.StrType)le.orig_sub_id),TRIM((SALT39.StrType)le.orig_neighbors),TRIM((SALT39.StrType)le.orig_relatives),TRIM((SALT39.StrType)le.orig_associates),TRIM((SALT39.StrType)le.orig_property),TRIM((SALT39.StrType)le.orig_bankruptcy),TRIM((SALT39.StrType)le.orig_dls),TRIM((SALT39.StrType)le.orig_mvs),TRIM((SALT39.StrType)le.orig_ip_address)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),79*79,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_login_id'}
      ,{2,'orig_billing_code'}
      ,{3,'orig_transaction_id'}
      ,{4,'orig_function_name'}
      ,{5,'orig_company_id'}
      ,{6,'orig_reference_code'}
      ,{7,'orig_fname'}
      ,{8,'orig_mname'}
      ,{9,'orig_lname'}
      ,{10,'orig_name_suffix'}
      ,{11,'orig_fname_2'}
      ,{12,'orig_mname_2'}
      ,{13,'orig_lname_2'}
      ,{14,'orig_name_suffix_2'}
      ,{15,'orig_address'}
      ,{16,'orig_city'}
      ,{17,'orig_state'}
      ,{18,'orig_zip'}
      ,{19,'orig_zip4'}
      ,{20,'orig_address_2'}
      ,{21,'orig_city_2'}
      ,{22,'orig_state_2'}
      ,{23,'orig_zip_2'}
      ,{24,'orig_zip4_2'}
      ,{25,'orig_clean_address'}
      ,{26,'orig_clean_city'}
      ,{27,'orig_clean_state'}
      ,{28,'orig_clean_zip'}
      ,{29,'orig_clean_zip4'}
      ,{30,'orig_phone'}
      ,{31,'orig_homephone'}
      ,{32,'orig_homephone_2'}
      ,{33,'orig_workphone'}
      ,{34,'orig_workphone_2'}
      ,{35,'orig_ssn'}
      ,{36,'orig_ssn_2'}
      ,{37,'orig_free'}
      ,{38,'orig_record_count'}
      ,{39,'orig_price'}
      ,{40,'orig_revenue'}
      ,{41,'orig_full_name'}
      ,{42,'orig_business_name'}
      ,{43,'orig_business_name_2'}
      ,{44,'orig_years'}
      ,{45,'orig_pricing_error_code'}
      ,{46,'orig_fcra_purpose'}
      ,{47,'orig_result_format'}
      ,{48,'orig_dob'}
      ,{49,'orig_dob_2'}
      ,{50,'orig_unique_id'}
      ,{51,'orig_response_time'}
      ,{52,'orig_data_source'}
      ,{53,'orig_report_options'}
      ,{54,'orig_end_user_name'}
      ,{55,'orig_end_user_address_1'}
      ,{56,'orig_end_user_address_2'}
      ,{57,'orig_end_user_city'}
      ,{58,'orig_end_user_state'}
      ,{59,'orig_end_user_zip'}
      ,{60,'orig_login_history_id'}
      ,{61,'orig_employment_state'}
      ,{62,'orig_end_user_industry_class'}
      ,{63,'orig_function_specific_data'}
      ,{64,'orig_date_added'}
      ,{65,'orig_retail_price'}
      ,{66,'orig_country_code'}
      ,{67,'orig_email'}
      ,{68,'orig_email_2'}
      ,{69,'orig_dl_number'}
      ,{70,'orig_dl_number_2'}
      ,{71,'orig_sub_id'}
      ,{72,'orig_neighbors'}
      ,{73,'orig_relatives'}
      ,{74,'orig_associates'}
      ,{75,'orig_property'}
      ,{76,'orig_bankruptcy'}
      ,{77,'orig_dls'}
      ,{78,'orig_mvs'}
      ,{79,'orig_ip_address'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_login_id((SALT39.StrType)le.orig_login_id),
    Fields.InValid_orig_billing_code((SALT39.StrType)le.orig_billing_code),
    Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id),
    Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name),
    Fields.InValid_orig_company_id((SALT39.StrType)le.orig_company_id),
    Fields.InValid_orig_reference_code((SALT39.StrType)le.orig_reference_code),
    Fields.InValid_orig_fname((SALT39.StrType)le.orig_fname),
    Fields.InValid_orig_mname((SALT39.StrType)le.orig_mname),
    Fields.InValid_orig_lname((SALT39.StrType)le.orig_lname),
    Fields.InValid_orig_name_suffix((SALT39.StrType)le.orig_name_suffix),
    Fields.InValid_orig_fname_2((SALT39.StrType)le.orig_fname_2),
    Fields.InValid_orig_mname_2((SALT39.StrType)le.orig_mname_2),
    Fields.InValid_orig_lname_2((SALT39.StrType)le.orig_lname_2),
    Fields.InValid_orig_name_suffix_2((SALT39.StrType)le.orig_name_suffix_2),
    Fields.InValid_orig_address((SALT39.StrType)le.orig_address),
    Fields.InValid_orig_city((SALT39.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT39.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip),
    Fields.InValid_orig_zip4((SALT39.StrType)le.orig_zip4),
    Fields.InValid_orig_address_2((SALT39.StrType)le.orig_address_2),
    Fields.InValid_orig_city_2((SALT39.StrType)le.orig_city_2),
    Fields.InValid_orig_state_2((SALT39.StrType)le.orig_state_2),
    Fields.InValid_orig_zip_2((SALT39.StrType)le.orig_zip_2),
    Fields.InValid_orig_zip4_2((SALT39.StrType)le.orig_zip4_2),
    Fields.InValid_orig_clean_address((SALT39.StrType)le.orig_clean_address),
    Fields.InValid_orig_clean_city((SALT39.StrType)le.orig_clean_city),
    Fields.InValid_orig_clean_state((SALT39.StrType)le.orig_clean_state),
    Fields.InValid_orig_clean_zip((SALT39.StrType)le.orig_clean_zip),
    Fields.InValid_orig_clean_zip4((SALT39.StrType)le.orig_clean_zip4),
    Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone),
    Fields.InValid_orig_homephone((SALT39.StrType)le.orig_homephone),
    Fields.InValid_orig_homephone_2((SALT39.StrType)le.orig_homephone_2),
    Fields.InValid_orig_workphone((SALT39.StrType)le.orig_workphone),
    Fields.InValid_orig_workphone_2((SALT39.StrType)le.orig_workphone_2),
    Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn),
    Fields.InValid_orig_ssn_2((SALT39.StrType)le.orig_ssn_2),
    Fields.InValid_orig_free((SALT39.StrType)le.orig_free),
    Fields.InValid_orig_record_count((SALT39.StrType)le.orig_record_count),
    Fields.InValid_orig_price((SALT39.StrType)le.orig_price),
    Fields.InValid_orig_revenue((SALT39.StrType)le.orig_revenue),
    Fields.InValid_orig_full_name((SALT39.StrType)le.orig_full_name),
    Fields.InValid_orig_business_name((SALT39.StrType)le.orig_business_name),
    Fields.InValid_orig_business_name_2((SALT39.StrType)le.orig_business_name_2),
    Fields.InValid_orig_years((SALT39.StrType)le.orig_years),
    Fields.InValid_orig_pricing_error_code((SALT39.StrType)le.orig_pricing_error_code),
    Fields.InValid_orig_fcra_purpose((SALT39.StrType)le.orig_fcra_purpose),
    Fields.InValid_orig_result_format((SALT39.StrType)le.orig_result_format),
    Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob),
    Fields.InValid_orig_dob_2((SALT39.StrType)le.orig_dob_2),
    Fields.InValid_orig_unique_id((SALT39.StrType)le.orig_unique_id),
    Fields.InValid_orig_response_time((SALT39.StrType)le.orig_response_time),
    Fields.InValid_orig_data_source((SALT39.StrType)le.orig_data_source),
    Fields.InValid_orig_report_options((SALT39.StrType)le.orig_report_options),
    Fields.InValid_orig_end_user_name((SALT39.StrType)le.orig_end_user_name),
    Fields.InValid_orig_end_user_address_1((SALT39.StrType)le.orig_end_user_address_1),
    Fields.InValid_orig_end_user_address_2((SALT39.StrType)le.orig_end_user_address_2),
    Fields.InValid_orig_end_user_city((SALT39.StrType)le.orig_end_user_city),
    Fields.InValid_orig_end_user_state((SALT39.StrType)le.orig_end_user_state),
    Fields.InValid_orig_end_user_zip((SALT39.StrType)le.orig_end_user_zip),
    Fields.InValid_orig_login_history_id((SALT39.StrType)le.orig_login_history_id),
    Fields.InValid_orig_employment_state((SALT39.StrType)le.orig_employment_state),
    Fields.InValid_orig_end_user_industry_class((SALT39.StrType)le.orig_end_user_industry_class),
    Fields.InValid_orig_function_specific_data((SALT39.StrType)le.orig_function_specific_data),
    Fields.InValid_orig_date_added((SALT39.StrType)le.orig_date_added),
    Fields.InValid_orig_retail_price((SALT39.StrType)le.orig_retail_price),
    Fields.InValid_orig_country_code((SALT39.StrType)le.orig_country_code),
    Fields.InValid_orig_email((SALT39.StrType)le.orig_email),
    Fields.InValid_orig_email_2((SALT39.StrType)le.orig_email_2),
    Fields.InValid_orig_dl_number((SALT39.StrType)le.orig_dl_number),
    Fields.InValid_orig_dl_number_2((SALT39.StrType)le.orig_dl_number_2),
    Fields.InValid_orig_sub_id((SALT39.StrType)le.orig_sub_id),
    Fields.InValid_orig_neighbors((SALT39.StrType)le.orig_neighbors),
    Fields.InValid_orig_relatives((SALT39.StrType)le.orig_relatives),
    Fields.InValid_orig_associates((SALT39.StrType)le.orig_associates),
    Fields.InValid_orig_property((SALT39.StrType)le.orig_property),
    Fields.InValid_orig_bankruptcy((SALT39.StrType)le.orig_bankruptcy),
    Fields.InValid_orig_dls((SALT39.StrType)le.orig_dls),
    Fields.InValid_orig_mvs((SALT39.StrType)le.orig_mvs),
    Fields.InValid_orig_ip_address((SALT39.StrType)le.orig_ip_address),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,79,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_login_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_billing_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_reference_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_clean_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_clean_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_clean_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_clean_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_clean_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_homephone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_homephone_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_workphone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_workphone_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_free(TotalErrors.ErrorNum),Fields.InValidMessage_orig_record_count(TotalErrors.ErrorNum),Fields.InValidMessage_orig_price(TotalErrors.ErrorNum),Fields.InValidMessage_orig_revenue(TotalErrors.ErrorNum),Fields.InValidMessage_orig_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_business_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_business_name_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_years(TotalErrors.ErrorNum),Fields.InValidMessage_orig_pricing_error_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fcra_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_orig_result_format(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_unique_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_response_time(TotalErrors.ErrorNum),Fields.InValidMessage_orig_data_source(TotalErrors.ErrorNum),Fields.InValidMessage_orig_report_options(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_login_history_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_employment_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_end_user_industry_class(TotalErrors.ErrorNum),Fields.InValidMessage_orig_function_specific_data(TotalErrors.ErrorNum),Fields.InValidMessage_orig_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_orig_retail_price(TotalErrors.ErrorNum),Fields.InValidMessage_orig_country_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_number_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sub_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_neighbors(TotalErrors.ErrorNum),Fields.InValidMessage_orig_relatives(TotalErrors.ErrorNum),Fields.InValidMessage_orig_associates(TotalErrors.ErrorNum),Fields.InValidMessage_orig_property(TotalErrors.ErrorNum),Fields.InValidMessage_orig_bankruptcy(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dls(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mvs(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ip_address(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_fcra_Riskwise, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
