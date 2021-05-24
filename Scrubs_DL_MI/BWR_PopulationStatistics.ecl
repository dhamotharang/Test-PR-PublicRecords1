//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_MI.BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT Scrubs_DL_MI,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DL_MI.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* process_date_field */,/* code_field */,/* customer_dln_pid_field */,/* last_name_field */,/* first_name_field */,/* middle_name_field */,/* name_suffix_field */,/* street_address_field */,/* city_field */,/* state_field */,/* zipcode_field */,/* date_of_birth_field */,/* gender_field */,/* county_field */,/* dln_pid_indicator_field */,/* mailing_street_address_field */,/* mailing_city_field */,/* mailing_state_field */,/* mailing_zipcode_field */,/* blob_field */,/* clean_name_prefix_field */,/* clean_fname_field */,/* clean_mname_field */,/* clean_lname_field */,/* clean_name_suffix_field */,/* clean_name_score_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
