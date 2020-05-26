//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LaborActions_EBSA.BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_LaborActions_EBSA,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_LaborActions_EBSA.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dart_id_field */,/* date_added_field */,/* date_updated_field */,/* website_field */,/* state_field */,/* casetype_field */,/* plan_ein_field */,/* plan_no_field */,/* plan_year_field */,/* plan_name_field */,/* plan_administrator_field */,/* admin_state_field */,/* admin_zip_code_field */,/* admin_zip_code4_field */,/* closing_reason_field */,/* closing_date_field */,/* penalty_amount_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
