IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_In_MA)old_s, DATASET(Layout_In_MA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['pers_surrogate','filler1','license_licno','filler2','license_bdate_yyyymmdd','license_edate_yyyymmdd','license_lic_class','license_height','license_sex','license_last_name','license_first_name','license_middle_name','licmail_street1','licmail_street2','licmail_city','licmail_state','licmail_zip','licresi_street1','licresi_street2','licresi_city','licresi_state','licresi_zip','issue_date_yyyymmdd','license_status','clean_status','process_date'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_MA, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_MA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_MA, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
