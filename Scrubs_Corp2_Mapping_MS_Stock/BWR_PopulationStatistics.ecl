//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_MS_Stock.BWR_PopulationStatistics - Population Statistics - SALT V3.4.3');
IMPORT Scrubs_Corp2_Mapping_MS_Stock,SALT34;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_MS_Stock.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* corp_key_field */,/* stock_class_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
