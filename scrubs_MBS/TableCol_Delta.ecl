IMPORT SALT39,STD;
EXPORT TableCol_Delta(DATASET(TableCol_Layout_TableCol)old_s, DATASET(TableCol_Layout_TableCol) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['table_column_id','table_name','column_name','is_column_value'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := TableCol_hygiene(old_s).Summary('Old') + TableCol_hygiene(new_s).Summary('New') + TableCol_hygiene(PROJECT(Differences(deleted), TRANSFORM(TableCol_Layout_TableCol, SELF := LEFT.old_rec))).Summary('Deletions') + TableCol_hygiene(PROJECT(Differences(added), TRANSFORM(TableCol_Layout_TableCol, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, TableCol_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
