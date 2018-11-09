//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.DeactRaw_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_PhonesInfo,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.DeactRaw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* action_code_field */,/* timestamp_field */,/* phone_field */,/* phone_swap_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
