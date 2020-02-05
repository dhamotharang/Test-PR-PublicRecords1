IMPORT SALT38,STD;
EXPORT Medians_Delta(DATASET(Medians_Layout_AVM)old_s, DATASET(Medians_Layout_AVM) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['history_date','fips_geo_12','median_valuation','history_history_date','history_median_valuation'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Medians_hygiene(old_s).Summary('Old') + Medians_hygiene(new_s).Summary('New') + Medians_hygiene(PROJECT(Differences(deleted), TRANSFORM(Medians_Layout_AVM, SELF := LEFT.old_rec))).Summary('Deletions') + Medians_hygiene(PROJECT(Differences(added), TRANSFORM(Medians_Layout_AVM, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AVM, Medians_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
