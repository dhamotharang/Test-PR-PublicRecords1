//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_IL_AR.BWR_PopulationStatistics - Population Statistics - SALT V3.4.3');
IMPORT Scrubs_Corp2_Mapping_IL_AR,SALT34;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_IL_AR.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* corp_key_field */,/* corp_vendor_field */,/* corp_vendor_county_field */,/* corp_vendor_subcode_field */,/* corp_state_origin_field */,/* corp_process_date_field */,/* corp_sos_charter_nbr_field */,/* ar_year_field */,/* ar_mailed_dt_field */,/* ar_due_dt_field */,/* ar_filed_dt_field */,/* ar_report_dt_field */,/* ar_report_nbr_field */,/* ar_franchise_tax_paid_dt_field */,/* ar_delinquent_dt_field */,/* ar_tax_factor_field */,/* ar_tax_amount_paid_field */,/* ar_annual_report_cap_field */,/* ar_illinois_capital_field */,/* ar_roll_field */,/* ar_frame_field */,/* ar_extension_field */,/* ar_microfilm_nbr_field */,/* ar_comment_field */,/* ar_type_field */,/* ar_exempt_field */,/* ar_license_tax_amount_field */,/* ar_status_field */,/* ar_paid_date_field */,/* ar_prev_paid_date_field */,/* ar_prev_tax_factor_field */,/* ar_extension_date_field */,/* ar_report_mail_date_field */,/* ar_deliquent_report_mail_date_field */,/* ar_report_filed_date_field */,/* ar_year_and_month_due_field */,/* ar_amount_paid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
