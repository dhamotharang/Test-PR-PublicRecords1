//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_CA_San_Diego_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.Input_CA_San_Diego_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* FILE_NUMBER_field */,/* FILE_DATE_field */,/* PREV_FILE_NUMBER_field */,/* PREV_FILE_DATE_field */,/* FILING_TYPE_field */,/* BUSINESS_NAME_field */,/* prep_addr_line1_field */,/* prep_addr_line_last_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
