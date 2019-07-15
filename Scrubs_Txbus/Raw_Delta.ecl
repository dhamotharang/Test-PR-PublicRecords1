IMPORT SALT311,STD;
EXPORT Raw_Delta(DATASET(Raw_Layout_Txbus)old_s, DATASET(Raw_Layout_Txbus) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['taxpayer_number','outlet_number','taxpayer_name','taxpayer_address','taxpayer_city','taxpayer_state','taxpayer_zipcode','taxpayer_county_code','taxpayer_phone','taxpayer_org_type','outlet_name','outlet_address','outlet_city','outlet_state','outlet_zipcode','outlet_county_code','outlet_phone','outlet_naics_code','outlet_city_limits_indicator','outlet_permit_issue_date','outlet_first_sales_date','crlf'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Raw_hygiene(old_s).Summary('Old') + Raw_hygiene(new_s).Summary('New') + Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(Raw_Layout_Txbus, SELF := LEFT.old_rec))).Summary('Deletions') + Raw_hygiene(PROJECT(Differences(added), TRANSFORM(Raw_Layout_Txbus, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Txbus, Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
