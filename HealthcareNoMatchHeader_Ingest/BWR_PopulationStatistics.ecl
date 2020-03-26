//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareNoMatchHeader_Ingest.BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT HealthCareNoMatchHeader_Ingest,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  HealthCareNoMatchHeader_Ingest.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*src Field*/,/* src_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* source_rid_field */,/* ssn_field */,/* dob_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* suffix_field */,/* home_phone_field */,/* gender_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* lexid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
