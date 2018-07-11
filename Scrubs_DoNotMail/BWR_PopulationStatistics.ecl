//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DoNotMail.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_DoNotMail,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DoNotMail.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* name_score_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dpbc_field */,/* chk_digit_field */,/* rec_type_field */,/* ace_fips_st_field */,/* fips_county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_match_field */,/* err_stat_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
