//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.HHID_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.HHID_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* gc_id_field */,/* sub_account_id_field */,/* hh_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
