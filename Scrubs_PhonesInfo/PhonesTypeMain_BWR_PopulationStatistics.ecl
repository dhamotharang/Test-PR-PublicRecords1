//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.PhonesTypeMain_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.PhonesTypeMain_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* phone_field */,/* source_field */,/* vendor_first_reported_dt_field */,/* vendor_first_reported_time_field */,/* vendor_last_reported_dt_field */,/* vendor_last_reported_time_field */,/* reference_id_field */,/* reply_code_field */,/* local_routing_number_field */,/* account_owner_field */,/* carrier_name_field */,/* carrier_category_field */,/* local_area_transport_area_field */,/* point_code_field */,/* serv_field */,/* line_field */,/* spid_field */,/* operator_fullname_field */,/* high_risk_indicator_field */,/* prepaid_field */,/* global_sid_field */,/* record_sid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
