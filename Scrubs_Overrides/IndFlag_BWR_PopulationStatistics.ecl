//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Overrides.IndFlag_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Overrides,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Overrides.IndFlag_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*Key_Ind Field*/,/* Key_Ind_field */,/* flag_file_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
