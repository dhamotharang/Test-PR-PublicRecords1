IMPORT SALT310,STD;
EXPORT DeactGHMain_Delta(DATASET(DeactGHMain_Layout_PhonesInfo)old_s, DATASET(DeactGHMain_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['groupid','vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','carrier_name','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','pk_carrier_name','days_apart'];
  EXPORT Differences := SALT310.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := DeactGHMain_hygiene(old_s).Summary('Old') + DeactGHMain_hygiene(new_s).Summary('New') + DeactGHMain_hygiene(PROJECT(Differences(deleted), TRANSFORM(DeactGHMain_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + DeactGHMain_hygiene(PROJECT(Differences(added), TRANSFORM(DeactGHMain_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT310.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT310.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, DeactGHMain_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
