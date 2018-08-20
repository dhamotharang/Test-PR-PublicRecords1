//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.BWR_PopulationStatistics - Population Statistics - SALT V3.7.1');
IMPORT Scrubs_FBNV2,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* name1_field */,/* name2_field */,/* date_filed_field */,/* file_number_field */,/* prep_addr1_line1_field */,/* prep_addr1_line_last_field */,/* prep_addr2_line1_field */,/* prep_addr2_line_last_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
