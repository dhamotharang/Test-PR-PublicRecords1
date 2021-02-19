//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.DeactRaw2_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.DeactRaw2_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* msisdn_field */,/* timestamp_field */,/* changeid_field */,/* operatorid_field */,/* msisdneid_field */,/* msisdnnew_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
