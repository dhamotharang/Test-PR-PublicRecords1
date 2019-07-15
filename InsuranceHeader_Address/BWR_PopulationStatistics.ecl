//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Address.BWR_PopulationStatistics - Population Statistics - SALT V3.11.3');
IMPORT InsuranceHeader_Address,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  InsuranceHeader_Address.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* DID_field */,/* src_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* prim_range_field */,/* prim_range_alpha_field */,/* prim_range_num_field */,/* prim_range_fract_field */,/* predir_field */,/* prim_name_field */,/* prim_name_num_field */,/* prim_name_alpha_field */,/* addr_suffix_field */,/* addr_ind_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* sec_range_alpha_field */,/* sec_range_num_field */,/* city_field */,/* st_field */,/* zip_field */,/* rec_cnt_field */,/* src_cnt_field */,/* addr_field */,/* locale_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
