//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PAW.Base_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_PAW,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PAW.Base_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* contact_id_field */,/* company_phone_field */,/* company_name_field */,/* active_phone_flag_field */,/* source_count_field */,/* source_field */,/* record_type_field */,/* record_sid_field */,/* global_sid_field */,/* GLB_field */,/* lname_field */,/* fname_field */,/* dt_last_seen_field */,/* dt_first_seen_field */,/* RawAid_field */,/* zip_field */,/* state_field */,/* bdid_field */,/* zip4_field */,/* geo_long_field */,/* geo_lat_field */,/* county_field */,/* company_zip_field */,/* company_state_field */,/* Company_RawAid_field */,/* company_zip4_field */,/* msa_field */,/* did_field */,/* ssn_field */,/* phone_field */,/* predir_field */,/* company_predir_field */,/* company_postdir_field */,/* postdir_field */,/* from_hdr_field */,/* dead_flag_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
