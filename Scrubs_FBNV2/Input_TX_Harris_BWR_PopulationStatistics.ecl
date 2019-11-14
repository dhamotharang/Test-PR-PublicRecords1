//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_TX_Harris_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.Input_TX_Harris_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* FILE_NUMBER_field */,/* DATE_FILED_field */,/* NAME1_field */,/* NAME2_field */,/* prep_addr1_line1_field */,/* prep_addr1_line_last_field */,/* prep_addr2_line1_field */,/* prep_addr2_line_last_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
