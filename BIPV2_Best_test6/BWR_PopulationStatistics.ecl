//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_test6.BWR_PopulationStatistics - Population Statistics - SALT V2.7 Beta 1');
IMPORT BIPV2_Best_test6,SALT27;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_Best_test6.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* company_url_field */,/* company_name_field */,/* company_fein_field */,/* company_phone_field */,/* address_field */,/* prim_name_field */,/* zip_field */,/* prim_range_field */,/* zip4_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* postdir_field */,/* fips_county_field */,/* predir_field */,/* unit_desig_field */,/* st_field */,/* fips_state_field */,/* addr_suffix_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* source_for_votes_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));

