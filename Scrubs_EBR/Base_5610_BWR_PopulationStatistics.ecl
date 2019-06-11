//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_5610_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_5610_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* did_field */,/* ssn_field */,/* process_date_field */,/* file_number_field */,/* segment_code_field */,/* sequence_number_field */,/* officer_title_field */,/* officer_first_name_field */,/* officer_m_i_field */,/* officer_last_name_field */,/* clean_officer_name_title_field */,/* clean_officer_name_fname_field */,/* clean_officer_name_mname_field */,/* clean_officer_name_lname_field */,/* clean_officer_name_name_suffix_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
