//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Business_Credit.BS_BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_Business_Credit,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Business_Credit.BS_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* segment_identifier_field */,/* file_sequence_number_field */,/* parent_sequence_number_field */,/* account_base_number_field */,/* business_name_field */,/* web_address_field */,/* guarantor_owner_indicator_field */,/* relationship_to_business_indicator_field */,/* percent_of_liability_field */,/* percent_of_ownership_if_owner_principal_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
