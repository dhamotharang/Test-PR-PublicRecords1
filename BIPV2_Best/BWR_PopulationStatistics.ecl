//This is the code to execute in a builder window
#workunit('name','BIPV2_Best.BWR_PopulationStatistics - Population Statistics - SALT V2.4 Gold');
IMPORT BIPV2_Best,SALT24;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_Best.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dt_first_seen_field */,/* dt_last_seen_field */,/* source_field */,/* company_name_field */,/* company_fein_field */,/* company_phone_field */,/* company_url_field */,/* company_prim_range_field */,/* company_predir_field */,/* company_prim_name_field */,/* company_addr_suffix_field */,/* company_postdir_field */,/* company_unit_desig_field */,/* company_sec_range_field */,/* company_p_city_name_field */,/* company_v_city_name_field */,/* company_st_field */,/* company_zip5_field */,/* company_zip4_field */,/* company_csz_field */,/* company_addr1_field */,/* company_address_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
