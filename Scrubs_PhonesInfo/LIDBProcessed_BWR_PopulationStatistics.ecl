﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.LIDBProcessed_BWR_PopulationStatistics - Population Statistics - SALT V3.10.1');
IMPORT Scrubs_PhonesInfo,SALT310;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.LIDBProcessed_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* reference_id_field */,/* dt_first_reported_field */,/* dt_last_reported_field */,/* phone_field */,/* reply_code_field */,/* local_routing_number_field */,/* account_owner_field */,/* carrier_name_field */,/* carrier_category_field */,/* local_area_transport_area_field */,/* point_code_field */,/* serv_field */,/* line_field */,/* spid_field */,/* operator_fullname_field */,/* activation_dt_field */,/* number_in_service_field */,/* high_risk_indicator_field */,/* prepaid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
