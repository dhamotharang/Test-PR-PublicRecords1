IMPORT SALT39,STD;
EXPORT ColValDesc_Delta(DATASET(ColValDesc_Layout_ColValDesc)old_s, DATASET(ColValDesc_Layout_ColValDesc) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['column_value_desc_id','table_column_id','desc_value','status','description'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := ColValDesc_hygiene(old_s).Summary('Old') + ColValDesc_hygiene(new_s).Summary('New') + ColValDesc_hygiene(PROJECT(Differences(deleted), TRANSFORM(ColValDesc_Layout_ColValDesc, SELF := LEFT.old_rec))).Summary('Deletions') + ColValDesc_hygiene(PROJECT(Differences(added), TRANSFORM(ColValDesc_Layout_ColValDesc, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, ColValDesc_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
