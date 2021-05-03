//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Spoke.Input_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_Spoke,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Spoke.Input_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* first_name_field */,/* last_name_field */,/* job_title_field */,/* company_name_field */,/* validation_date_field */,/* company_street_address_field */,/* company_city_field */,/* company_state_field */,/* company_postal_code_field */,/* company_phone_number_field */,/* company_annual_revenue_field */,/* company_business_description_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
