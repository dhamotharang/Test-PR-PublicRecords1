//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.LIDBReceived_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.LIDBReceived_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* reference_id_field */,/* phone_field */,/* reply_code_field */,/* local_routing_number_field */,/* account_owner_field */,/* carrier_name_field */,/* carrier_category_field */,/* local_area_transport_area_field */,/* point_code_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
