//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_CA_Orange_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.Input_CA_Orange_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* REGIS_NBR_field */,/* BUSINESS_NAME_field */,/* PHONE_NBR_field */,/* FILE_DATE_field */,/* FIRST_NAME_field */,/* MIDDLE_NAME_field */,/* LAST_NAME_COMPANY_field */,/* OWNER_ADDRESS_field */,/* prep_bus_addr_line1_field */,/* prep_bus_addr_line_last_field */,/* prep_owner_addr_line1_field */,/* prep_owner_addr_line_last_field */,/* cname_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
