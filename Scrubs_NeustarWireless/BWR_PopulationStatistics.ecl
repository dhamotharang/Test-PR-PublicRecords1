﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_NeustarWireless.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_NeustarWireless,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_NeustarWireless.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* phone_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* salutation_field */,/* suffix_field */,/* gender_field */,/* dob_field */,/* house_field */,/* pre_dir_field */,/* street_field */,/* street_type_field */,/* post_dir_field */,/* apt_type_field */,/* apt_nbr_field */,/* zip_field */,/* plus4_field */,/* dpc_field */,/* z4_type_field */,/* crte_field */,/* city_field */,/* state_field */,/* dpvcmra_field */,/* dpvconf_field */,/* fips_state_field */,/* fips_county_field */,/* census_tract_field */,/* census_block_group_field */,/* cbsa_field */,/* match_code_field */,/* latitude_field */,/* longitude_field */,/* email_field */,/* filler1_field */,/* filler2_field */,/* verified_field */,/* activity_status_field */,/* prepaid_field */,/* cord_cutter_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
