//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Overrides.PCR_PII_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Overrides,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Overrides.PCR_PII_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* uid_field */,/* date_created_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* did_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* ssn_field */,/* dob_field */,/* predir_field */,/* prim_name_field */,/* prim_range_field */,/* suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* zip4_field */,/* address_field */,/* city_name_field */,/* st_field */,/* zip_field */,/* phone_field */,/* dl_number_field */,/* dl_state_field */,/* dispute_flag_field */,/* security_freeze_field */,/* security_freeze_pin_field */,/* security_alert_field */,/* negative_alert_field */,/* id_theft_flag_field */,/* insuff_inqry_data_field */,/* consumer_statement_flag_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
