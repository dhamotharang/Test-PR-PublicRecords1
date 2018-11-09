//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.In_Port_Daily_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.In_Port_Daily_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* action_code_field */,/* country_code_field */,/* phone_field */,/* dial_type_field */,/* spid_field */,/* service_type_field */,/* routing_code_field */,/* porting_dt_field */,/* country_abbr_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
