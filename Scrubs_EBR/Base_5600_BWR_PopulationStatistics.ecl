//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_5600_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_5600_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* segment_code_field */,/* sequence_number_field */,/* sic_1_code_field */,/* sic_1_desc_field */,/* sic_2_code_field */,/* sic_2_desc_field */,/* sic_3_code_field */,/* sic_3_desc_field */,/* sic_4_code_field */,/* sic_4_desc_field */,/* yrs_in_bus_actual_field */,/* sales_actual_field */,/* empl_size_actual_field */,/* bus_type_code_field */,/* bus_type_desc_field */,/* owner_type_code_field */,/* owner_type_desc_field */,/* location_code_field */,/* location_desc_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
