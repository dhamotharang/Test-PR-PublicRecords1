IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_File)old_s, DATASET(Layout_File) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['orig_transaction_id','orig_function_name','orig_company_id','orig_login_id','orig_billing_code','orig_record_count','orig_fcra_purpose','orig_glb_purpose','orig_dppa_purpose','orig_ip_address','orig_reference_code','orig_login_history_id','orig_date_added','orig_price','orig_pricing_error_code','orig_free','orig_business_name','orig_name_first','orig_name_last','orig_ssn','orig_case_number','orig_address','orig_city','orig_state','orig_zip','orig_dob','orig_phone','orig_tmsid','orig_unique_id','orig_out_tmsid','orig_out_business_name','orig_out_first_name','orig_out_last_name','orig_out_ssn','orig_out_address','orig_out_city','orig_out_state','orig_out_zip','orig_out_case_number','orig_transaction_type'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_File, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_File, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nfcra_Banko, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
