IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_FILE)old_s, DATASET(Layout_FILE) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_FILE, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_FILE, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_fcra_Batch, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
