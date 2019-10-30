//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_CA_Ventura_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.Input_CA_Ventura_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* recorded_date_field */,/* business_name_field */,/* owner_name_field */,/* start_date_field */,/* abandondate_field */,/* file_number_field */,/* prep_bus_addr_line1_field */,/* prep_bus_addr_line_last_field */,/* prep_owner_addr_line1_field */,/* prep_owner_addr_line_last_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
