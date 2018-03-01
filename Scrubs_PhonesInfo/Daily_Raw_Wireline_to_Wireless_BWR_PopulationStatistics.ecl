//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* phone_field */,/* lf_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
