//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Calbus.raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Calbus,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Calbus.raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* district_branch_field */,/* account_number_field */,/* sub_account_number_field */,/* district_field */,/* account_type_field */,/* firm_name_field */,/* owner_name_field */,/* business_street_field */,/* business_city_field */,/* business_state_field */,/* business_zip_5_field */,/* business_zip_plus_4_field */,/* business_country_name_field */,/* start_date_field */,/* ownership_code_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
