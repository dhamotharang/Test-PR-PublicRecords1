IMPORT SALT311,STD;
EXPORT RiskIndicators_Delta(DATASET(RiskIndicators_Layout_PhoneFinder)old_s, DATASET(RiskIndicators_Layout_PhoneFinder) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['transaction_id','phone_id','sequence_number','date_added','risk_indicator_id','risk_indicator_level','risk_indicator_text','risk_indicator_category','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := RiskIndicators_hygiene(old_s).Summary('Old') + RiskIndicators_hygiene(new_s).Summary('New') + RiskIndicators_hygiene(PROJECT(Differences(deleted), TRANSFORM(RiskIndicators_Layout_PhoneFinder, SELF := LEFT.old_rec))).Summary('Deletions') + RiskIndicators_hygiene(PROJECT(Differences(added), TRANSFORM(RiskIndicators_Layout_PhoneFinder, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, RiskIndicators_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
