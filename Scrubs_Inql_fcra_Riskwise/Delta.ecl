IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_FILE)old_s, DATASET(Layout_FILE) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['orig_login_id','orig_billing_code','orig_transaction_id','orig_function_name','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_name_suffix','orig_fname_2','orig_mname_2','orig_lname_2','orig_name_suffix_2','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_clean_address','orig_clean_city','orig_clean_state','orig_clean_zip','orig_clean_zip4','orig_phone','orig_homephone','orig_homephone_2','orig_workphone','orig_workphone_2','orig_ssn','orig_ssn_2','orig_free','orig_record_count','orig_price','orig_revenue','orig_full_name','orig_business_name','orig_business_name_2','orig_years','orig_pricing_error_code','orig_fcra_purpose','orig_result_format','orig_dob','orig_dob_2','orig_unique_id','orig_response_time','orig_data_source','orig_report_options','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip','orig_login_history_id','orig_employment_state','orig_end_user_industry_class','orig_function_specific_data','orig_date_added','orig_retail_price','orig_country_code','orig_email','orig_email_2','orig_dl_number','orig_dl_number_2','orig_sub_id','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_bankruptcy','orig_dls','orig_mvs','orig_ip_address'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_FILE, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_FILE, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_fcra_Riskwise, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
