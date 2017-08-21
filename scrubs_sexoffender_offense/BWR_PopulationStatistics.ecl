//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_sexoffender_offense.BWR_PopulationStatistics - Population Statistics - SALT V3.3.2');
IMPORT scrubs_sexoffender_offense,SALT33;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  scrubs_sexoffender_offense.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*orig_state_code Field*/,/* orig_state_field */,/* orig_state_code_field */,/* vendor_code_field */,/* source_file_field */,/* seisint_primary_key_field */,/* conviction_jurisdiction_field */,/* conviction_date_field */,/* court_field */,/* court_case_number_field */,/* offense_date_field */,/* offense_code_or_statute_field */,/* offense_description_field */,/* offense_description_2_field */,/* offense_category_field */,/* victim_minor_field */,/* victim_age_field */,/* victim_gender_field */,/* victim_relationship_field */,/* sentence_description_field */,/* sentence_description_2_field */,/* arrest_date_field */,/* arrest_warrant_field */,/* fcra_conviction_flag_field */,/* fcra_traffic_flag_field */,/* fcra_date_field */,/* fcra_date_type_field */,/* conviction_override_date_field */,/* conviction_override_date_type_field */,/* offense_score_field */,/* offense_persistent_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
