IMPORT SALT311,STD;
EXPORT Input_Delta(DATASET(Input_Layout_IA_SalesTax)old_s, DATASET(Input_Layout_IA_SalesTax) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['permit_nbr','issue_date','owner_name','business_name','city_mailing_address','mailing_address','state_mailing_address','mailing_zip_code','location_address','city_of_location','state_of_location','location_zip_code'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_hygiene(old_s).Summary('Old') + Input_hygiene(new_s).Summary('New') + Input_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_Layout_IA_SalesTax, SELF := LEFT.old_rec))).Summary('Deletions') + Input_hygiene(PROJECT(Differences(added), TRANSFORM(Input_Layout_IA_SalesTax, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IA_SalesTax, Input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
