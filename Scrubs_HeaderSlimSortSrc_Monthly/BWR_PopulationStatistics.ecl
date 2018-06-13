//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_HeaderSlimSortSrc_Monthly.BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_HeaderSlimSortSrc_Monthly,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_HeaderSlimSortSrc_Monthly.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* src_field */,/* did_field */,/* fname_field */,/* lname_field */,/* prim_range_field */,/* prim_name_field */,/* zip_field */,/* mname_field */,/* sec_range_field */,/* name_suffix_field */,/* ssn_field */,/* dob_field */,/* dids_with_this_nm_addr_field */,/* suffix_cnt_with_this_nm_addr_field */,/* sec_range_cnt_with_this_nm_addr_field */,/* ssn_cnt_with_this_nm_addr_field */,/* dob_cnt_with_this_nm_addr_field */,/* mname_cnt_with_this_nm_addr_field */,/* dids_with_this_nm_ssn_field */,/* dob_cnt_with_this_nm_ssn_field */,/* dids_with_this_nm_dob_field */,/* zip_cnt_with_this_nm_dob_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
