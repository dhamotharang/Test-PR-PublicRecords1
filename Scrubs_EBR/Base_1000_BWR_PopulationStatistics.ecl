//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_1000_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_1000_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* current_dbt_field */,/* predicted_dbt_field */,/* orig_predicted_dbt_date_mmddyy_field */,/* average_industry_dbt_field */,/* average_all_industries_dbt_field */,/* low_balance_field */,/* high_balance_field */,/* current_account_balance_field */,/* high_credit_extended_field */,/* median_credit_extended_field */,/* payment_performance_field */,/* payment_trend_field */,/* industry_description_field */,/* predicted_dbt_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
