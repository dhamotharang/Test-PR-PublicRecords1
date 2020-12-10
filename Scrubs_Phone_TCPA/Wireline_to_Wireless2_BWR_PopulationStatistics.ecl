//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Phone_TCPA.Wireline_to_Wireless2_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_Phone_TCPA,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Phone_TCPA.Wireline_to_Wireless2_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* cellphone_field */,/* end_range_field */,/* lf_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
