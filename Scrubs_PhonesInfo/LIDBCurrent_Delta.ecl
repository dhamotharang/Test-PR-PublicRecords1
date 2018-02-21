IMPORT SALT39,STD;
EXPORT LIDBCurrent_Delta(DATASET(LIDBCurrent_Layout_PhonesInfo)old_s, DATASET(LIDBCurrent_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['reference_id','phone'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := LIDBCurrent_hygiene(old_s).Summary('Old') + LIDBCurrent_hygiene(new_s).Summary('New') + LIDBCurrent_hygiene(PROJECT(Differences(deleted), TRANSFORM(LIDBCurrent_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + LIDBCurrent_hygiene(PROJECT(Differences(added), TRANSFORM(LIDBCurrent_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, LIDBCurrent_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
