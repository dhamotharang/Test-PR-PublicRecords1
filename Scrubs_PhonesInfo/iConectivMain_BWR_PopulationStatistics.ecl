//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.iConectivMain_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.iConectivMain_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* country_code_field */,/* phone_field */,/* dial_type_field */,/* spid_field */,/* service_provider_field */,/* service_type_field */,/* routing_code_field */,/* porting_dt_field */,/* country_abbr_field */,/* filename_field */,/* file_dt_time_field */,/* vendor_first_reported_dt_field */,/* vendor_last_reported_dt_field */,/* port_start_dt_field */,/* port_end_dt_field */,/* remove_port_dt_field */,/* is_ported_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
