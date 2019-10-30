//This is the code to execute in a builder window
#workunit('name','BIPV2_POWID_DOWN_Platform.BWR_PopulationStatistics - Population Statistics - SALT V2.7 Gold');
IMPORT BIPV2_POWID_DOWN_Platform,SALT27;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_POWID_DOWN_Platform.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* orgid_field */,/* prim_range_field */,/* prim_name_field */,/* st_field */,/* zip_field */,/* csz_field */,/* v_city_name_field */,/* company_name_field */,/* addr1_field */,/* address_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));

