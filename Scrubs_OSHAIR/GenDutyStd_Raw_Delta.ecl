IMPORT SALT311,STD;
EXPORT GenDutyStd_Raw_Delta(DATASET(GenDutyStd_Raw_Layout)old_s, DATASET(GenDutyStd_Raw_Layout) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['activity_nr','citation_id','line_nr'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := GenDutyStd_Raw_hygiene(old_s).Summary('Old') + GenDutyStd_Raw_hygiene(new_s).Summary('New') + GenDutyStd_Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(GenDutyStd_Raw_Layout, SELF := LEFT.old_rec))).Summary('Deletions') + GenDutyStd_Raw_hygiene(PROJECT(Differences(added), TRANSFORM(GenDutyStd_Raw_Layout, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, GenDutyStd_Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
