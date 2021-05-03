//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.Lerg1ConRaw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.Lerg1ConRaw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* ocn_field */,/* ocn_name_field */,/* ocn_state_field */,/* contact_function_field */,/* contact_phone_field */,/* contact_information_field */,/* filler_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
