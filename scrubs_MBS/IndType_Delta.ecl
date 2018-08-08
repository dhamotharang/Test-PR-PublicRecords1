IMPORT SALT39,STD;
EXPORT IndType_Delta(DATASET(IndType_Layout_IndType)old_s, DATASET(IndType_Layout_IndType) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ind_type','description','status','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := IndType_hygiene(old_s).Summary('Old') + IndType_hygiene(new_s).Summary('New') + IndType_hygiene(PROJECT(Differences(deleted), TRANSFORM(IndType_Layout_IndType, SELF := LEFT.old_rec))).Summary('Deletions') + IndType_hygiene(PROJECT(Differences(added), TRANSFORM(IndType_Layout_IndType, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, IndType_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
