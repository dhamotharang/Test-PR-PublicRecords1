//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','LocationId_xLink.BWR_PopulationStatistics - Population Statistics - SALT V3.7.0');
IMPORT LocationId_xLink,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  LocationId_xLink.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* zip5_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
