IMPORT SALT39,STD;
EXPORT CCID_Delta(DATASET(CCID_Layout_CCID)old_s, DATASET(CCID_Layout_CCID) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['cc_id','gc_id','account_id'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := CCID_hygiene(old_s).Summary('Old') + CCID_hygiene(new_s).Summary('New') + CCID_hygiene(PROJECT(Differences(deleted), TRANSFORM(CCID_Layout_CCID, SELF := LEFT.old_rec))).Summary('Deletions') + CCID_hygiene(PROJECT(Differences(added), TRANSFORM(CCID_Layout_CCID, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, CCID_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
