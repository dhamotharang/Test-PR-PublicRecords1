//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CrashCarrier.BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_CrashCarrier,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_CrashCarrier.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* carrier_id_field */,/* crash_id_field */,/* carrier_source_code_field */,/* carrier_name_field */,/* carrier_street_field */,/* carrier_city_field */,/* carrier_city_code_field */,/* carrier_state_field */,/* carrier_zip_code_field */,/* crash_colonia_field */,/* docket_number_field */,/* interstate_field */,/* no_id_flag_field */,/* state_number_field */,/* state_issuing_number_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
