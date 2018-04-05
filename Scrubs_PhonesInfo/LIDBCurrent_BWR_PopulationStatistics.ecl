//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.LIDBCurrent_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.LIDBCurrent_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* reference_id_field */,/* phone_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
