IMPORT SALT39,STD;
EXPORT MarketAppend_Delta(DATASET(MarketAppend_Layout_MarketAppend)old_s, DATASET(MarketAppend_Layout_MarketAppend) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['company_id','app_type','market','sub_market','vertical','main_country_code','bill_country_code'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := MarketAppend_hygiene(old_s).Summary('Old') + MarketAppend_hygiene(new_s).Summary('New') + MarketAppend_hygiene(PROJECT(Differences(deleted), TRANSFORM(MarketAppend_Layout_MarketAppend, SELF := LEFT.old_rec))).Summary('Deletions') + MarketAppend_hygiene(PROJECT(Differences(added), TRANSFORM(MarketAppend_Layout_MarketAppend, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, MarketAppend_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
