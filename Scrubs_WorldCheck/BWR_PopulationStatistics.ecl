//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_WorldCheck.BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_WorldCheck,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_WorldCheck.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* uid_field */,/* key_field */,/* name_orig_field */,/* name_type_field */,/* last_name_field */,/* first_name_field */,/* category_field */,/* title_field */,/* sub_category_field */,/* position_field */,/* age_field */,/* date_of_birth_field */,/* places_of_birth_field */,/* date_of_death_field */,/* passports_field */,/* social_security_number_field */,/* location_field */,/* countries_field */,/* e_i_ind_field */,/* keywords_field */,/* entered_field */,/* updated_field */,/* editor_field */,/* age_as_of_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
