//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_2025_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_2025_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* segment_code_field */,/* sequence_number_field */,/* quarter_field */,/* quarter_yy_field */,/* debt_field */,/* account_balance_mask_field */,/* account_balance_field */,/* current_balance_percent_field */,/* debt_01_30_percent_field */,/* debt_31_60_percent_field */,/* debt_61_90_percent_field */,/* debt_91_plus_percent_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
