//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Certegy.raw_file_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_Certegy,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Certegy.raw_file_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dl_state_field */,/* dl_num_field */,/* ssn_field */,/* dl_issue_dte_field */,/* dl_expire_dte_field */,/* house_bldg_num_field */,/* street_suffix_field */,/* apt_num_field */,/* unit_desc_field */,/* street_post_dir_field */,/* street_pre_dir_field */,/* state_field */,/* zip_field */,/* zip4_field */,/* dob_field */,/* deceased_dte_field */,/* home_tel_area_field */,/* home_tel_num_field */,/* work_tel_area_field */,/* work_tel_num_field */,/* work_tel_ext_field */,/* upd_dte_time_field */,/* first_name_field */,/* mid_name_field */,/* last_name_field */,/* gen_delivery_field */,/* street_name_field */,/* city_field */,/* foreign_cntry_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
