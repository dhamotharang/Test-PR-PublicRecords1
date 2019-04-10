//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT Watchdog_best,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Watchdog_best.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*src Field*/,/* pflag1_field */,/* pflag2_field */,/* pflag3_field */,/* src_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_last_reported_field */,/* dt_vendor_first_reported_field */,/* dt_nonglb_last_seen_field */,/* rec_type_field */,/* phone_field */,/* ssn_field */,/* dob_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* tnt_field */,/* valid_ssn_field */,/* jflag1_field */,/* jflag2_field */,/* jflag3_field */,/* rawaid_field */,/* dodgy_tracking_field */,/* address_ind_field */,/* name_ind_field */,/* persistent_record_id_field */,/* ssnum_field */,/* address_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
