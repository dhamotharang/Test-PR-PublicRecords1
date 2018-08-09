IMPORT SALT311,STD;
EXPORT raw_Delta(DATASET(raw_Layout_Calbus)old_s, DATASET(raw_Layout_Calbus) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['district_branch','account_number','sub_account_number','district','account_type','firm_name','owner_name','business_street','business_city','business_state','business_zip_5','business_zip_plus_4','business_country_name','start_date','ownership_code'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := raw_hygiene(old_s).Summary('Old') + raw_hygiene(new_s).Summary('New') + raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(raw_Layout_Calbus, SELF := LEFT.old_rec))).Summary('Deletions') + raw_hygiene(PROJECT(Differences(added), TRANSFORM(raw_Layout_Calbus, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Calbus, raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
