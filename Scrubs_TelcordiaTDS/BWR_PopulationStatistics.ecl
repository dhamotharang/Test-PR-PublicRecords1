//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_TelcordiaTDS.BWR_PopulationStatistics - Population Statistics - SALT V3.11.0');
IMPORT Scrubs_TelcordiaTDS,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_TelcordiaTDS.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* npa_field */,/* nxx_field */,/* tb_field */,/* state_field */,/* timezone_field */,/* coctype_field */,/* ssc_field */,/* wireless_ind_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
