//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_AVM.BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_AVM,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_AVM.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* seq_field */,/* ln_fares_id_field */,/* unformatted_apn_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* lat_field */,/* long_field */,/* geo_blk_field */,/* fips_code_field */,/* land_use_code_field */,/* sales_price_field */,/* sales_price_code_field */,/* recording_date_field */,/* assessed_value_year_field */,/* assessed_total_value_field */,/* market_total_value_field */,/* lot_size_field */,/* building_area_field */,/* year_built_field */,/* no_of_stories_field */,/* no_of_rooms_field */,/* no_of_bedrooms_field */,/* no_of_baths_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
