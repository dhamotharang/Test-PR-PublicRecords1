//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IRS_Nonprofit.Input_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_IRS_Nonprofit,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_IRS_Nonprofit.Input_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* employer_id_number_field */,/* primary_name_of_organization_field */,/* in_care_of_name_field */,/* street_address_field */,/* city_field */,/* state_field */,/* zip_code_field */,/* group_exemption_number_field */,/* subsection_code_field */,/* affiliation_code_field */,/* classification_code_field */,/* ruling_date_field */,/* deductibility_code_field */,/* foundation_code_field */,/* activity_codes_field */,/* organization_code_field */,/* exempt_org_status_code_field */,/* tax_period_field */,/* asset_code_field */,/* income_code_field */,/* filing_requirement_code_part1_field */,/* filing_requirement_code_part2_field */,/* accounting_period_field */,/* asset_amount_field */,/* income_amount_field */,/* form_990_revenue_amount_field */,/* national_taxonomy_exempt_field */,/* sort_name_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
