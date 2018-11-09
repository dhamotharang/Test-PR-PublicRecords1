//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.DeactMain_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_PhonesInfo,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.DeactMain_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* vendor_first_reported_dt_field */,/* vendor_last_reported_dt_field */,/* action_code_field */,/* timestamp_field */,/* phone_field */,/* phone_swap_field */,/* filename_field */,/* carrier_name_field */,/* filedate_field */,/* swap_start_dt_field */,/* swap_end_dt_field */,/* deact_code_field */,/* deact_start_dt_field */,/* deact_end_dt_field */,/* react_start_dt_field */,/* react_end_dt_field */,/* is_react_field */,/* is_deact_field */,/* porting_dt_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
