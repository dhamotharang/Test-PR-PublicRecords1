//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_POWID_Down.BWR_PopulationStatistics - Population Statistics - SALT V3.5.2');
IMPORT BIPV2_POWID_Down,SALT35;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_POWID_Down.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* orgid_field */,/* prim_range_field */,/* prim_name_field */,/* st_field */,/* zip_field */,/* csz_field */,/* v_city_name_field */,/* company_name_field */,/* addr1_field */,/* address_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
