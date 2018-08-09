//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.ColValDesc_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.ColValDesc_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* column_value_desc_id_field */,/* table_column_id_field */,/* desc_value_field */,/* status_field */,/* description_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
