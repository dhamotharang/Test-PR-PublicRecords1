//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Ares_SALT.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Ares_SALT,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Ares_SALT.MAC_PopulationStatistics(in_area,/*Reference Field*/, deleted ,fid,/* id_field */,/* resource_field */,/* source_field */,/* summary.type_field */,/* type_field */,/* value_field */,/* status_field */,/* useinaddress_field */,/* link_href_field */,/* link_rel_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
