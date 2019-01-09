//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_6500_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_6500_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* segment_code_field */,/* sequence_number_field */,/* bus_cat_code_field */,/* bus_cat_desc_field */,/* orig_date_reported_ymd_field */,/* orig_date_last_sale_ym_field */,/* payment_terms_field */,/* high_credit_mask_field */,/* recent_high_credit_field */,/* acct_bal_mask_field */,/* masked_acct_bal_field */,/* current_pct_field */,/* dbt_01_30_pct_field */,/* dbt_31_60_pct_field */,/* dbt_61_90_pct_field */,/* dbt_91_plus_pct_field */,/* comment_code_field */,/* comment_desc_field */,/* date_reported_field */,/* date_last_sale_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
