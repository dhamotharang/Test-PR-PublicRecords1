//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Civil_Court.Activity_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_Civil_Court,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Civil_Court.Activity_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dt_first_reported_field */,/* dt_last_reported_field */,/* process_date_field */,/* vendor_field */,/* state_origin_field */,/* source_file_field */,/* case_key_field */,/* court_code_field */,/* court_field */,/* case_number_field */,/* event_date_field */,/* event_type_code_field */,/* event_type_description_1_field */,/* event_type_description_2_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
