IMPORT SALT311,STD;
EXPORT Input_Delta(DATASET(Input_Layout_Spoke)old_s, DATASET(Input_Layout_Spoke) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['first_name','last_name','job_title','company_name','validation_date','company_street_address','company_city','company_state','company_postal_code','company_phone_number','company_annual_revenue','company_business_description'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_hygiene(old_s).Summary('Old') + Input_hygiene(new_s).Summary('New') + Input_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_Layout_Spoke, SELF := LEFT.old_rec))).Summary('Deletions') + Input_hygiene(PROJECT(Differences(added), TRANSFORM(Input_Layout_Spoke, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Spoke, Input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
