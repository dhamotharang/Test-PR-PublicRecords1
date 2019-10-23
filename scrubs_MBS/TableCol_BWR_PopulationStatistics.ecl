//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.TableCol_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.TableCol_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* table_column_id_field */,/* table_name_field */,/* column_name_field */,/* is_column_value_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
