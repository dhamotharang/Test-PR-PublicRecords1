IMPORT SALT311,STD;
EXPORT Input_Delta(DATASET(Input_Layout_IRS_Nonprofit)old_s, DATASET(Input_Layout_IRS_Nonprofit) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['employer_id_number','primary_name_of_organization','in_care_of_name','street_address','city','state','zip_code','group_exemption_number','subsection_code','affiliation_code','classification_code','ruling_date','deductibility_code','foundation_code','activity_codes','organization_code','exempt_org_status_code','tax_period','asset_code','income_code','filing_requirement_code_part1','filing_requirement_code_part2','accounting_period','asset_amount','income_amount','form_990_revenue_amount','national_taxonomy_exempt','sort_name'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_hygiene(old_s).Summary('Old') + Input_hygiene(new_s).Summary('New') + Input_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_Layout_IRS_Nonprofit, SELF := LEFT.old_rec))).Summary('Deletions') + Input_hygiene(PROJECT(Differences(added), TRANSFORM(Input_Layout_IRS_Nonprofit, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IRS_Nonprofit, Input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
