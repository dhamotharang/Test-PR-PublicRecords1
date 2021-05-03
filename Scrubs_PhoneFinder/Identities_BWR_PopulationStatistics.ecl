//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFinder.Identities_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhoneFinder,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhoneFinder.Identities_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* transaction_id_field */,/* sequence_number_field */,/* lexid_field */,/* full_name_field */,/* full_address_field */,/* city_field */,/* state_field */,/* zip_field */,/* verified_carrier_field */,/* date_added_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
