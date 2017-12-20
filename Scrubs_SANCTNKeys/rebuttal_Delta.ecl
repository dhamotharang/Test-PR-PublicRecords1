IMPORT SALT38,STD;
EXPORT rebuttal_Delta(DATASET(rebuttal_Layout_SANCTNKeys)old_s, DATASET(rebuttal_Layout_SANCTNKeys) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['batch_number','incident_number','party_number','record_type','order_number','party_text'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := rebuttal_hygiene(old_s).Summary('Old') + rebuttal_hygiene(new_s).Summary('New') + rebuttal_hygiene(PROJECT(Differences(deleted), TRANSFORM(rebuttal_Layout_SANCTNKeys, SELF := LEFT.old_rec))).Summary('Deletions') + rebuttal_hygiene(PROJECT(Differences(added), TRANSFORM(rebuttal_Layout_SANCTNKeys, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, rebuttal_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
