IMPORT SALT39,STD;
EXPORT DeactMain2_Delta(DATASET(DeactMain2_Layout_Phonesinfo)old_s, DATASET(DeactMain2_Layout_Phonesinfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['groupid','vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','carrier_name','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','pk_carrier_name','days_apart'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := DeactMain2_hygiene(old_s).Summary('Old') + DeactMain2_hygiene(new_s).Summary('New') + DeactMain2_hygiene(PROJECT(Differences(deleted), TRANSFORM(DeactMain2_Layout_Phonesinfo, SELF := LEFT.old_rec))).Summary('Deletions') + DeactMain2_hygiene(PROJECT(Differences(added), TRANSFORM(DeactMain2_Layout_Phonesinfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phonesinfo, DeactMain2_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
