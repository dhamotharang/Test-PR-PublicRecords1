IMPORT SALT39,STD;
EXPORT HHID_Delta(DATASET(HHID_Layout_HHID)old_s, DATASET(HHID_Layout_HHID) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['gc_id','sub_account_id','hh_id'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := HHID_hygiene(old_s).Summary('Old') + HHID_hygiene(new_s).Summary('New') + HHID_hygiene(PROJECT(Differences(deleted), TRANSFORM(HHID_Layout_HHID, SELF := LEFT.old_rec))).Summary('Deletions') + HHID_hygiene(PROJECT(Differences(added), TRANSFORM(HHID_Layout_HHID, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, HHID_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
