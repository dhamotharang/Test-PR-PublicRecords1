//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Build_AR_Base.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT Scrubs_Corp2_Build_AR_Base,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Build_AR_Base.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* bdid_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* corp_key_field */,/* corp_vendor_field */,/* corp_vendor_county_field */,/* corp_vendor_subcode_field */,/* corp_state_origin_field */,/* corp_process_date_field */,/* corp_sos_charter_nbr_field */,/* ar_year_field */,/* ar_mailed_dt_field */,/* ar_due_dt_field */,/* ar_filed_dt_field */,/* ar_report_dt_field */,/* ar_report_nbr_field */,/* ar_franchise_tax_paid_dt_field */,/* ar_delinquent_dt_field */,/* ar_tax_factor_field */,/* ar_tax_amount_paid_field */,/* ar_annual_report_cap_field */,/* ar_illinois_capital_field */,/* ar_roll_field */,/* ar_frame_field */,/* ar_extension_field */,/* ar_microfilm_nbr_field */,/* ar_comment_field */,/* ar_type_field */,/* record_type_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
