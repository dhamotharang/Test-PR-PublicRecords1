//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Phone_TCPA.BaseFile2_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_Phone_TCPA,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Phone_TCPA.BaseFile2_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* num_field */,/* phone_field */,/* end_range_field */,/* expand_end_range_field */,/* expand_range_max_count_field */,/* expand_phone_field */,/* is_current_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* phone_type_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
