IMPORT SALT38,STD;
EXPORT Delta(DATASET(Layout_In_WY_MEDCERT)old_s, DATASET(Layout_In_WY_MEDCERT) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['append_process_date','orig_first_name','orig_middle_name','orig_last_name','mailing_street_addr_1','mailing_city_1','mailing_state_1','mailing_zip_code_1','phys_street_addr_2','phys_city_2','phys_state_2','phys_zip_code_2','orig_dl_number','orig_dob','orig_code_1','orig_code_2','orig_code_3','orig_code_4','orig_code_5','orig_code_6','orig_code_7','orig_code_8','orig_issue_date','orig_expire_date','med_cert_status','med_cert_type','med_cert_expire_date','name_suffix','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_WY_MEDCERT, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_WY_MEDCERT, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_WY_MEDCERT, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
