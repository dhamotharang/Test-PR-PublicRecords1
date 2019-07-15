//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_6000_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_6000_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* segment_code_field */,/* sequence_number_field */,/* bus_code_field */,/* bus_desc_field */,/* inq_mm_field */,/* inq_yy_field */,/* inq_count_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
