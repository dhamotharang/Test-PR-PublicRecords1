//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_VA_Stock.BWR_PopulationStatistics - Population Statistics - SALT V3.4.3');
IMPORT Scrubs_Corp2_Mapping_VA_Stock,SALT34;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_VA_Stock.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* corp_key_field */,/* corp_vendor_field */,/* corp_vendor_county_field */,/* corp_vendor_subcode_field */,/* corp_state_origin_field */,/* corp_process_date_field */,/* corp_sos_charter_nbr_field */,/* stock_ticker_symbol_field */,/* stock_exchange_field */,/* stock_type_field */,/* stock_class_field */,/* stock_shares_issued_field */,/* stock_authorized_nbr_field */,/* stock_par_value_field */,/* stock_nbr_par_shares_field */,/* stock_change_ind_field */,/* stock_change_date_field */,/* stock_voting_rights_ind_field */,/* stock_convert_ind_field */,/* stock_convert_date_field */,/* stock_change_in_cap_field */,/* stock_tax_capital_field */,/* stock_total_capital_field */,/* stock_addl_info_field */,/* stock_stock_description_field */,/* stock_stock_series_field */,/* stock_non_par_value_flag_field */,/* stock_additional_stock_field */,/* stock_shares_proportion_to_ohio_for_foreign_license_field */,/* stock_share_credits_field */,/* stock_authorized_capital_field */,/* stock_stock_paid_in_capital_field */,/* stock_pay_higher_stock_fees_field */,/* stock_actual_amt_invested_in_state_field */,/* stock_share_exchange_during_merger_field */,/* stock_date_stock_limit_approved_field */,/* stock_number_of_shares_paid_for_field */,/* stock_total_value_of_shares_paid_for_field */,/* stock_sharesofbeneficialinterest_field */,/* stock_beneficialsharevalue_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
