IMPORT SALT311,STD;
EXPORT IndFlag_Delta(DATASET(IndFlag_Layout_Overrides)old_s, DATASET(IndFlag_Layout_Overrides) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['Key_Ind','flag_file_id'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := IndFlag_hygiene(old_s).Summary('Old',Glob) + IndFlag_hygiene(new_s).Summary('New',Glob) + IndFlag_hygiene(PROJECT(Differences(deleted), TRANSFORM(IndFlag_Layout_Overrides, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + IndFlag_hygiene(PROJECT(Differences(added), TRANSFORM(IndFlag_Layout_Overrides, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Overrides, IndFlag_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
