IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_FILE)old_s, DATASET(Layout_FILE) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['orig_end_user_id','orig_loginid','orig_billing_code','orig_transaction_id','orig_transaction_type','orig_neighbors','orig_relatives','orig_associates','orig_property','orig_company_id','orig_reference_code','orig_fname','orig_mname','orig_lname','orig_address','orig_city','orig_state','orig_zip','orig_zip4','orig_phone','orig_ssn','orig_free','orig_record_count','orig_price','orig_bankruptcy','orig_transaction_code','orig_dateadded','orig_full_name','orig_billingdate','orig_business_name','orig_pricing_error_code','orig_dl_purpose','orig_result_format','orig_dob','orig_unique_id','orig_dls','orig_mvs','orig_function_name','orig_response_time','orig_data_source','orig_glb_purpose','orig_report_options','orig_unused','orig_login_history_id','orig_aseid','orig_years','orig_ip_address','orig_source_code','orig_retail_price','inquiry_type','lex_id','reprice_batch_number','user_changed','date_changed','fcra_purpose','orig_address_2','orig_city_2','orig_state_2','orig_zip_2','orig_zip4_2','orig_jobid','orig_acctno','orig_end_user_name','orig_end_user_address_1','orig_end_user_address_2','orig_end_user_city','orig_end_user_state','orig_end_user_zip'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_FILE, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_FILE, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_fcra_Accurint, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
