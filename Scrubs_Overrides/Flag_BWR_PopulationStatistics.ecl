//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Overrides.Flag_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Overrides,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Overrides.Flag_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* flag_file_id_field */,/* did_field */,/* file_id_field */,/* record_id_field */,/* override_flag_field */,/* in_dispute_flag_field */,/* consumer_statement_flag_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* ssn_field */,/* dob_field */,/* riskwise_uid_field */,/* user_added_field */,/* date_added_field */,/* known_missing_field */,/* user_changed_field */,/* date_changed_field */,/* lf_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
