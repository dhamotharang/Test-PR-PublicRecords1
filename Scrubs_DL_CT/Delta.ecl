IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_In_CT)old_s, DATASET(Layout_In_CT) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['append_process_date','credentialstate','credentialnumber','lastname','firstname','middleinitial','gender','height','eyecolor','date_birth','resiaddrstreet','residencycity','residencystate','residencyzip','mailaddrstreet','mailingcity','mailingstate','mailingzip','credentialtype','credential_class','endorsements','restrictions','expdate','lastissuerenewaldate','date_noncdl','originaldate_cdl','statusnoncdl','licensestatuscdl','originaldate_lp','originaldate_id','cancelstate','canceldate','cdlmedicertissuedate','cdlmedicertexpdate','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_CT, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_CT, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_CT, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
