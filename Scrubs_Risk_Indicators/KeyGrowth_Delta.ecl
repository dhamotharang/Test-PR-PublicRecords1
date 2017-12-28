IMPORT SALT38,STD;
EXPORT KeyGrowth_Delta(DATASET(KeyGrowth_Layout_Risk_Indicators)old_s, DATASET(KeyGrowth_Layout_Risk_Indicators) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dataset_name','file_type','version','wu','count_oldfile','count_newfile','count_deduped_combined','percent_change'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := KeyGrowth_hygiene(old_s).Summary('Old') + KeyGrowth_hygiene(new_s).Summary('New') + KeyGrowth_hygiene(PROJECT(Differences(deleted), TRANSFORM(KeyGrowth_Layout_Risk_Indicators, SELF := LEFT.old_rec))).Summary('Deletions') + KeyGrowth_hygiene(PROJECT(Differences(added), TRANSFORM(KeyGrowth_Layout_Risk_Indicators, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Risk_Indicators, KeyGrowth_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
