//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.PortData_ValidateIn_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.PortData_ValidateIn_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* tid_field */,/* action_field */,/* actts_field */,/* digits_field */,/* spid_field */,/* altspid_field */,/* laltspid_field */,/* linetype_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
