//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Codes.CodesV3_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_Codes,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Codes.CodesV3_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* file_name_field */,/* field_name_field */,/* field_name2_field */,/* code_field */,/* long_flag_field */,/* long_desc_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
