//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Build_Stock_Base.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT Scrubs_Corp2_Build_Stock_Base,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Build_Stock_Base.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* bdid_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* corp_key_field */,/* corp_vendor_field */,/* corp_vendor_county_field */,/* corp_vendor_subcode_field */,/* corp_state_origin_field */,/* corp_process_date_field */,/* corp_sos_charter_nbr_field */,/* stock_ticker_symbol_field */,/* stock_exchange_field */,/* stock_type_field */,/* stock_class_field */,/* stock_shares_issued_field */,/* stock_authorized_nbr_field */,/* stock_par_value_field */,/* stock_nbr_par_shares_field */,/* stock_change_ind_field */,/* stock_change_date_field */,/* stock_voting_rights_ind_field */,/* stock_convert_ind_field */,/* stock_convert_date_field */,/* stock_change_in_cap_field */,/* stock_tax_capital_field */,/* stock_total_capital_field */,/* stock_addl_info_field */,/* record_type_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
