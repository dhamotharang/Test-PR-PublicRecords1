//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Equifax_Monthly.BWR_PopulationStatistics - Population Statistics - SALT V3.6.3');
IMPORT Scrubs_Equifax_Monthly,SALT36;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Equifax_Monthly.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* first_name_field */,/* middle_initial_field */,/* last_name_field */,/* suffix_field */,/* former_first_name_field */,/* former_middle_initial_field */,/* former_last_name_field */,/* former_suffix_field */,/* former_first_name2_field */,/* former_middle_initial2_field */,/* former_last_name2_field */,/* former_suffix2_field */,/* aka_first_name_field */,/* aka_middle_initial_field */,/* aka_last_name_field */,/* aka_suffix_field */,/* current_address_field */,/* current_city_field */,/* current_state_field */,/* current_zip_field */,/* current_address_date_reported_field */,/* former1_address_field */,/* former1_city_field */,/* former1_state_field */,/* former1_zip_field */,/* former1_address_date_reported_field */,/* former2_address_field */,/* former2_city_field */,/* former2_state_field */,/* former2_zip_field */,/* former2_address_date_reported_field */,/* blank1_field */,/* ssn_field */,/* cid_field */,/* ssn_confirmed_field */,/* blank2_field */,/* blank3_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
