//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IA_SalesTax.Input_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_IA_SalesTax,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_IA_SalesTax.Input_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* permit_nbr_field */,/* issue_date_field */,/* owner_name_field */,/* business_name_field */,/* city_mailing_address_field */,/* mailing_address_field */,/* state_mailing_address_field */,/* mailing_zip_code_field */,/* location_address_field */,/* city_of_location_field */,/* state_of_location_field */,/* location_zip_code_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
