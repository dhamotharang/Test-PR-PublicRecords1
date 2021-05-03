//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_OH.BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT Scrubs_DL_OH,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DL_OH.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* process_date_field */,/* key_number_field */,/* license_number_field */,/* license_class_field */,/* donor_flag_field */,/* hair_color_field */,/* eye_color_field */,/* weight_l_field */,/* height_feet_field */,/* height_inches_field */,/* sex_gender_field */,/* permanent_license_issue_date_field */,/* license_expiration_date_field */,/* restriction_codes_field */,/* endorsement_codes_field */,/* first_name_field */,/* middle_name_field */,/* last_name_field */,/* street_address_field */,/* city_field */,/* state_field */,/* zip_code_field */,/* county_number_field */,/* birth_date_field */,/* clean_name_prefix_field */,/* clean_fname_field */,/* clean_mname_field */,/* clean_lname_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
