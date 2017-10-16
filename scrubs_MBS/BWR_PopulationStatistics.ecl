//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.BWR_PopulationStatistics - Population Statistics - SALT V3.7.0');
IMPORT Scrubs_MBS,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* gc_id_field */,/* product_id_field */,/* company_id_field */,/* status_field */,/* date_added_field */,/* user_added_field */,/* date_changed_field */,/* user_changed_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
