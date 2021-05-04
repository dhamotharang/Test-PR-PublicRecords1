//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.PhonesTransactionMain_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.PhonesTransactionMain_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* phone_field */,/* source_field */,/* transaction_code_field */,/* transaction_start_dt_field */,/* transaction_start_time_field */,/* transaction_end_dt_field */,/* transaction_end_time_field */,/* transaction_count_field */,/* vendor_first_reported_dt_field */,/* vendor_first_reported_time_field */,/* vendor_last_reported_dt_field */,/* vendor_last_reported_time_field */,/* country_code_field */,/* country_abbr_field */,/* routing_code_field */,/* dial_type_field */,/* spid_field */,/* carrier_name_field */,/* phone_swap_field */,/* ocn_field */,/* global_sid_field */,/* record_sid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
