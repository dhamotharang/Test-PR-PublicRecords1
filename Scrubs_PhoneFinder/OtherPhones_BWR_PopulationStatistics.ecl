//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFinder.OtherPhones_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhoneFinder,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhoneFinder.OtherPhones_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* transaction_id_field */,/* sequence_number_field */,/* phone_id_field */,/* phonenumber_field */,/* risk_indicator_field */,/* phone_type_field */,/* phone_status_field */,/* listing_name_field */,/* porting_code_field */,/* phone_forwarded_field */,/* verified_carrier_field */,/* date_added_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
