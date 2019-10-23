//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Txbus.Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.1');
IMPORT Scrubs_Txbus,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Txbus.Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* taxpayer_number_field */,/* outlet_number_field */,/* taxpayer_name_field */,/* taxpayer_address_field */,/* taxpayer_city_field */,/* taxpayer_state_field */,/* taxpayer_zipcode_field */,/* taxpayer_county_code_field */,/* taxpayer_phone_field */,/* taxpayer_org_type_field */,/* outlet_name_field */,/* outlet_address_field */,/* outlet_city_field */,/* outlet_state_field */,/* outlet_zipcode_field */,/* outlet_county_code_field */,/* outlet_phone_field */,/* outlet_naics_code_field */,/* outlet_city_limits_indicator_field */,/* outlet_permit_issue_date_field */,/* outlet_first_sales_date_field */,/* crlf_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
