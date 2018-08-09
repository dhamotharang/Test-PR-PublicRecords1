IMPORT SALT38,STD,Corp2_Mapping;
EXPORT hygiene(dataset(Corp2_Mapping.LayoutsCommon.Stock) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_corp_key_cnt := COUNT(GROUP,h.corp_key <> (TYPEOF(h.corp_key))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_vendor_cnt := COUNT(GROUP,h.corp_vendor <> (TYPEOF(h.corp_vendor))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_vendor_county_cnt := COUNT(GROUP,h.corp_vendor_county <> (TYPEOF(h.corp_vendor_county))'');
    populated_corp_vendor_county_pcnt := AVE(GROUP,IF(h.corp_vendor_county = (TYPEOF(h.corp_vendor_county))'',0,100));
    maxlength_corp_vendor_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_county)));
    avelength_corp_vendor_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_county)),h.corp_vendor_county<>(typeof(h.corp_vendor_county))'');
    populated_corp_vendor_subcode_cnt := COUNT(GROUP,h.corp_vendor_subcode <> (TYPEOF(h.corp_vendor_subcode))'');
    populated_corp_vendor_subcode_pcnt := AVE(GROUP,IF(h.corp_vendor_subcode = (TYPEOF(h.corp_vendor_subcode))'',0,100));
    maxlength_corp_vendor_subcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_subcode)));
    avelength_corp_vendor_subcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_subcode)),h.corp_vendor_subcode<>(typeof(h.corp_vendor_subcode))'');
    populated_corp_state_origin_cnt := COUNT(GROUP,h.corp_state_origin <> (TYPEOF(h.corp_state_origin))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_cnt := COUNT(GROUP,h.corp_process_date <> (TYPEOF(h.corp_process_date))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_sos_charter_nbr_cnt := COUNT(GROUP,h.corp_sos_charter_nbr <> (TYPEOF(h.corp_sos_charter_nbr))'');
    populated_corp_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_sos_charter_nbr = (TYPEOF(h.corp_sos_charter_nbr))'',0,100));
    maxlength_corp_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_sos_charter_nbr)));
    avelength_corp_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_sos_charter_nbr)),h.corp_sos_charter_nbr<>(typeof(h.corp_sos_charter_nbr))'');
    populated_stock_ticker_symbol_cnt := COUNT(GROUP,h.stock_ticker_symbol <> (TYPEOF(h.stock_ticker_symbol))'');
    populated_stock_ticker_symbol_pcnt := AVE(GROUP,IF(h.stock_ticker_symbol = (TYPEOF(h.stock_ticker_symbol))'',0,100));
    maxlength_stock_ticker_symbol := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_ticker_symbol)));
    avelength_stock_ticker_symbol := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_ticker_symbol)),h.stock_ticker_symbol<>(typeof(h.stock_ticker_symbol))'');
    populated_stock_exchange_cnt := COUNT(GROUP,h.stock_exchange <> (TYPEOF(h.stock_exchange))'');
    populated_stock_exchange_pcnt := AVE(GROUP,IF(h.stock_exchange = (TYPEOF(h.stock_exchange))'',0,100));
    maxlength_stock_exchange := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_exchange)));
    avelength_stock_exchange := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_exchange)),h.stock_exchange<>(typeof(h.stock_exchange))'');
    populated_stock_type_cnt := COUNT(GROUP,h.stock_type <> (TYPEOF(h.stock_type))'');
    populated_stock_type_pcnt := AVE(GROUP,IF(h.stock_type = (TYPEOF(h.stock_type))'',0,100));
    maxlength_stock_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_type)));
    avelength_stock_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_type)),h.stock_type<>(typeof(h.stock_type))'');
    populated_stock_class_cnt := COUNT(GROUP,h.stock_class <> (TYPEOF(h.stock_class))'');
    populated_stock_class_pcnt := AVE(GROUP,IF(h.stock_class = (TYPEOF(h.stock_class))'',0,100));
    maxlength_stock_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_class)));
    avelength_stock_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_class)),h.stock_class<>(typeof(h.stock_class))'');
    populated_stock_shares_issued_cnt := COUNT(GROUP,h.stock_shares_issued <> (TYPEOF(h.stock_shares_issued))'');
    populated_stock_shares_issued_pcnt := AVE(GROUP,IF(h.stock_shares_issued = (TYPEOF(h.stock_shares_issued))'',0,100));
    maxlength_stock_shares_issued := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_shares_issued)));
    avelength_stock_shares_issued := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_shares_issued)),h.stock_shares_issued<>(typeof(h.stock_shares_issued))'');
    populated_stock_authorized_nbr_cnt := COUNT(GROUP,h.stock_authorized_nbr <> (TYPEOF(h.stock_authorized_nbr))'');
    populated_stock_authorized_nbr_pcnt := AVE(GROUP,IF(h.stock_authorized_nbr = (TYPEOF(h.stock_authorized_nbr))'',0,100));
    maxlength_stock_authorized_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_authorized_nbr)));
    avelength_stock_authorized_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_authorized_nbr)),h.stock_authorized_nbr<>(typeof(h.stock_authorized_nbr))'');
    populated_stock_par_value_cnt := COUNT(GROUP,h.stock_par_value <> (TYPEOF(h.stock_par_value))'');
    populated_stock_par_value_pcnt := AVE(GROUP,IF(h.stock_par_value = (TYPEOF(h.stock_par_value))'',0,100));
    maxlength_stock_par_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_par_value)));
    avelength_stock_par_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_par_value)),h.stock_par_value<>(typeof(h.stock_par_value))'');
    populated_stock_nbr_par_shares_cnt := COUNT(GROUP,h.stock_nbr_par_shares <> (TYPEOF(h.stock_nbr_par_shares))'');
    populated_stock_nbr_par_shares_pcnt := AVE(GROUP,IF(h.stock_nbr_par_shares = (TYPEOF(h.stock_nbr_par_shares))'',0,100));
    maxlength_stock_nbr_par_shares := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_nbr_par_shares)));
    avelength_stock_nbr_par_shares := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_nbr_par_shares)),h.stock_nbr_par_shares<>(typeof(h.stock_nbr_par_shares))'');
    populated_stock_change_ind_cnt := COUNT(GROUP,h.stock_change_ind <> (TYPEOF(h.stock_change_ind))'');
    populated_stock_change_ind_pcnt := AVE(GROUP,IF(h.stock_change_ind = (TYPEOF(h.stock_change_ind))'',0,100));
    maxlength_stock_change_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_change_ind)));
    avelength_stock_change_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_change_ind)),h.stock_change_ind<>(typeof(h.stock_change_ind))'');
    populated_stock_change_date_cnt := COUNT(GROUP,h.stock_change_date <> (TYPEOF(h.stock_change_date))'');
    populated_stock_change_date_pcnt := AVE(GROUP,IF(h.stock_change_date = (TYPEOF(h.stock_change_date))'',0,100));
    maxlength_stock_change_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_change_date)));
    avelength_stock_change_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_change_date)),h.stock_change_date<>(typeof(h.stock_change_date))'');
    populated_stock_voting_rights_ind_cnt := COUNT(GROUP,h.stock_voting_rights_ind <> (TYPEOF(h.stock_voting_rights_ind))'');
    populated_stock_voting_rights_ind_pcnt := AVE(GROUP,IF(h.stock_voting_rights_ind = (TYPEOF(h.stock_voting_rights_ind))'',0,100));
    maxlength_stock_voting_rights_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_voting_rights_ind)));
    avelength_stock_voting_rights_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_voting_rights_ind)),h.stock_voting_rights_ind<>(typeof(h.stock_voting_rights_ind))'');
    populated_stock_convert_ind_cnt := COUNT(GROUP,h.stock_convert_ind <> (TYPEOF(h.stock_convert_ind))'');
    populated_stock_convert_ind_pcnt := AVE(GROUP,IF(h.stock_convert_ind = (TYPEOF(h.stock_convert_ind))'',0,100));
    maxlength_stock_convert_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_convert_ind)));
    avelength_stock_convert_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_convert_ind)),h.stock_convert_ind<>(typeof(h.stock_convert_ind))'');
    populated_stock_convert_date_cnt := COUNT(GROUP,h.stock_convert_date <> (TYPEOF(h.stock_convert_date))'');
    populated_stock_convert_date_pcnt := AVE(GROUP,IF(h.stock_convert_date = (TYPEOF(h.stock_convert_date))'',0,100));
    maxlength_stock_convert_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_convert_date)));
    avelength_stock_convert_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_convert_date)),h.stock_convert_date<>(typeof(h.stock_convert_date))'');
    populated_stock_change_in_cap_cnt := COUNT(GROUP,h.stock_change_in_cap <> (TYPEOF(h.stock_change_in_cap))'');
    populated_stock_change_in_cap_pcnt := AVE(GROUP,IF(h.stock_change_in_cap = (TYPEOF(h.stock_change_in_cap))'',0,100));
    maxlength_stock_change_in_cap := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_change_in_cap)));
    avelength_stock_change_in_cap := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_change_in_cap)),h.stock_change_in_cap<>(typeof(h.stock_change_in_cap))'');
    populated_stock_tax_capital_cnt := COUNT(GROUP,h.stock_tax_capital <> (TYPEOF(h.stock_tax_capital))'');
    populated_stock_tax_capital_pcnt := AVE(GROUP,IF(h.stock_tax_capital = (TYPEOF(h.stock_tax_capital))'',0,100));
    maxlength_stock_tax_capital := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_tax_capital)));
    avelength_stock_tax_capital := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_tax_capital)),h.stock_tax_capital<>(typeof(h.stock_tax_capital))'');
    populated_stock_total_capital_cnt := COUNT(GROUP,h.stock_total_capital <> (TYPEOF(h.stock_total_capital))'');
    populated_stock_total_capital_pcnt := AVE(GROUP,IF(h.stock_total_capital = (TYPEOF(h.stock_total_capital))'',0,100));
    maxlength_stock_total_capital := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_total_capital)));
    avelength_stock_total_capital := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_total_capital)),h.stock_total_capital<>(typeof(h.stock_total_capital))'');
    populated_stock_addl_info_cnt := COUNT(GROUP,h.stock_addl_info <> (TYPEOF(h.stock_addl_info))'');
    populated_stock_addl_info_pcnt := AVE(GROUP,IF(h.stock_addl_info = (TYPEOF(h.stock_addl_info))'',0,100));
    maxlength_stock_addl_info := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_addl_info)));
    avelength_stock_addl_info := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_addl_info)),h.stock_addl_info<>(typeof(h.stock_addl_info))'');
    populated_stock_stock_description_cnt := COUNT(GROUP,h.stock_stock_description <> (TYPEOF(h.stock_stock_description))'');
    populated_stock_stock_description_pcnt := AVE(GROUP,IF(h.stock_stock_description = (TYPEOF(h.stock_stock_description))'',0,100));
    maxlength_stock_stock_description := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_stock_description)));
    avelength_stock_stock_description := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_stock_description)),h.stock_stock_description<>(typeof(h.stock_stock_description))'');
    populated_stock_stock_series_cnt := COUNT(GROUP,h.stock_stock_series <> (TYPEOF(h.stock_stock_series))'');
    populated_stock_stock_series_pcnt := AVE(GROUP,IF(h.stock_stock_series = (TYPEOF(h.stock_stock_series))'',0,100));
    maxlength_stock_stock_series := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_stock_series)));
    avelength_stock_stock_series := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_stock_series)),h.stock_stock_series<>(typeof(h.stock_stock_series))'');
    populated_stock_non_par_value_flag_cnt := COUNT(GROUP,h.stock_non_par_value_flag <> (TYPEOF(h.stock_non_par_value_flag))'');
    populated_stock_non_par_value_flag_pcnt := AVE(GROUP,IF(h.stock_non_par_value_flag = (TYPEOF(h.stock_non_par_value_flag))'',0,100));
    maxlength_stock_non_par_value_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_non_par_value_flag)));
    avelength_stock_non_par_value_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_non_par_value_flag)),h.stock_non_par_value_flag<>(typeof(h.stock_non_par_value_flag))'');
    populated_stock_additional_stock_cnt := COUNT(GROUP,h.stock_additional_stock <> (TYPEOF(h.stock_additional_stock))'');
    populated_stock_additional_stock_pcnt := AVE(GROUP,IF(h.stock_additional_stock = (TYPEOF(h.stock_additional_stock))'',0,100));
    maxlength_stock_additional_stock := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_additional_stock)));
    avelength_stock_additional_stock := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_additional_stock)),h.stock_additional_stock<>(typeof(h.stock_additional_stock))'');
    populated_stock_shares_proportion_to_ohio_for_foreign_license_cnt := COUNT(GROUP,h.stock_shares_proportion_to_ohio_for_foreign_license <> (TYPEOF(h.stock_shares_proportion_to_ohio_for_foreign_license))'');
    populated_stock_shares_proportion_to_ohio_for_foreign_license_pcnt := AVE(GROUP,IF(h.stock_shares_proportion_to_ohio_for_foreign_license = (TYPEOF(h.stock_shares_proportion_to_ohio_for_foreign_license))'',0,100));
    maxlength_stock_shares_proportion_to_ohio_for_foreign_license := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_shares_proportion_to_ohio_for_foreign_license)));
    avelength_stock_shares_proportion_to_ohio_for_foreign_license := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_shares_proportion_to_ohio_for_foreign_license)),h.stock_shares_proportion_to_ohio_for_foreign_license<>(typeof(h.stock_shares_proportion_to_ohio_for_foreign_license))'');
    populated_stock_share_credits_cnt := COUNT(GROUP,h.stock_share_credits <> (TYPEOF(h.stock_share_credits))'');
    populated_stock_share_credits_pcnt := AVE(GROUP,IF(h.stock_share_credits = (TYPEOF(h.stock_share_credits))'',0,100));
    maxlength_stock_share_credits := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_share_credits)));
    avelength_stock_share_credits := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_share_credits)),h.stock_share_credits<>(typeof(h.stock_share_credits))'');
    populated_stock_authorized_capital_cnt := COUNT(GROUP,h.stock_authorized_capital <> (TYPEOF(h.stock_authorized_capital))'');
    populated_stock_authorized_capital_pcnt := AVE(GROUP,IF(h.stock_authorized_capital = (TYPEOF(h.stock_authorized_capital))'',0,100));
    maxlength_stock_authorized_capital := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_authorized_capital)));
    avelength_stock_authorized_capital := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_authorized_capital)),h.stock_authorized_capital<>(typeof(h.stock_authorized_capital))'');
    populated_stock_stock_paid_in_capital_cnt := COUNT(GROUP,h.stock_stock_paid_in_capital <> (TYPEOF(h.stock_stock_paid_in_capital))'');
    populated_stock_stock_paid_in_capital_pcnt := AVE(GROUP,IF(h.stock_stock_paid_in_capital = (TYPEOF(h.stock_stock_paid_in_capital))'',0,100));
    maxlength_stock_stock_paid_in_capital := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_stock_paid_in_capital)));
    avelength_stock_stock_paid_in_capital := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_stock_paid_in_capital)),h.stock_stock_paid_in_capital<>(typeof(h.stock_stock_paid_in_capital))'');
    populated_stock_pay_higher_stock_fees_cnt := COUNT(GROUP,h.stock_pay_higher_stock_fees <> (TYPEOF(h.stock_pay_higher_stock_fees))'');
    populated_stock_pay_higher_stock_fees_pcnt := AVE(GROUP,IF(h.stock_pay_higher_stock_fees = (TYPEOF(h.stock_pay_higher_stock_fees))'',0,100));
    maxlength_stock_pay_higher_stock_fees := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_pay_higher_stock_fees)));
    avelength_stock_pay_higher_stock_fees := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_pay_higher_stock_fees)),h.stock_pay_higher_stock_fees<>(typeof(h.stock_pay_higher_stock_fees))'');
    populated_stock_actual_amt_invested_in_state_cnt := COUNT(GROUP,h.stock_actual_amt_invested_in_state <> (TYPEOF(h.stock_actual_amt_invested_in_state))'');
    populated_stock_actual_amt_invested_in_state_pcnt := AVE(GROUP,IF(h.stock_actual_amt_invested_in_state = (TYPEOF(h.stock_actual_amt_invested_in_state))'',0,100));
    maxlength_stock_actual_amt_invested_in_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_actual_amt_invested_in_state)));
    avelength_stock_actual_amt_invested_in_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_actual_amt_invested_in_state)),h.stock_actual_amt_invested_in_state<>(typeof(h.stock_actual_amt_invested_in_state))'');
    populated_stock_share_exchange_during_merger_cnt := COUNT(GROUP,h.stock_share_exchange_during_merger <> (TYPEOF(h.stock_share_exchange_during_merger))'');
    populated_stock_share_exchange_during_merger_pcnt := AVE(GROUP,IF(h.stock_share_exchange_during_merger = (TYPEOF(h.stock_share_exchange_during_merger))'',0,100));
    maxlength_stock_share_exchange_during_merger := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_share_exchange_during_merger)));
    avelength_stock_share_exchange_during_merger := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_share_exchange_during_merger)),h.stock_share_exchange_during_merger<>(typeof(h.stock_share_exchange_during_merger))'');
    populated_stock_date_stock_limit_approved_cnt := COUNT(GROUP,h.stock_date_stock_limit_approved <> (TYPEOF(h.stock_date_stock_limit_approved))'');
    populated_stock_date_stock_limit_approved_pcnt := AVE(GROUP,IF(h.stock_date_stock_limit_approved = (TYPEOF(h.stock_date_stock_limit_approved))'',0,100));
    maxlength_stock_date_stock_limit_approved := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_date_stock_limit_approved)));
    avelength_stock_date_stock_limit_approved := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_date_stock_limit_approved)),h.stock_date_stock_limit_approved<>(typeof(h.stock_date_stock_limit_approved))'');
    populated_stock_number_of_shares_paid_for_cnt := COUNT(GROUP,h.stock_number_of_shares_paid_for <> (TYPEOF(h.stock_number_of_shares_paid_for))'');
    populated_stock_number_of_shares_paid_for_pcnt := AVE(GROUP,IF(h.stock_number_of_shares_paid_for = (TYPEOF(h.stock_number_of_shares_paid_for))'',0,100));
    maxlength_stock_number_of_shares_paid_for := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_number_of_shares_paid_for)));
    avelength_stock_number_of_shares_paid_for := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_number_of_shares_paid_for)),h.stock_number_of_shares_paid_for<>(typeof(h.stock_number_of_shares_paid_for))'');
    populated_stock_total_value_of_shares_paid_for_cnt := COUNT(GROUP,h.stock_total_value_of_shares_paid_for <> (TYPEOF(h.stock_total_value_of_shares_paid_for))'');
    populated_stock_total_value_of_shares_paid_for_pcnt := AVE(GROUP,IF(h.stock_total_value_of_shares_paid_for = (TYPEOF(h.stock_total_value_of_shares_paid_for))'',0,100));
    maxlength_stock_total_value_of_shares_paid_for := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_total_value_of_shares_paid_for)));
    avelength_stock_total_value_of_shares_paid_for := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_total_value_of_shares_paid_for)),h.stock_total_value_of_shares_paid_for<>(typeof(h.stock_total_value_of_shares_paid_for))'');
    populated_stock_sharesofbeneficialinterest_cnt := COUNT(GROUP,h.stock_sharesofbeneficialinterest <> (TYPEOF(h.stock_sharesofbeneficialinterest))'');
    populated_stock_sharesofbeneficialinterest_pcnt := AVE(GROUP,IF(h.stock_sharesofbeneficialinterest = (TYPEOF(h.stock_sharesofbeneficialinterest))'',0,100));
    maxlength_stock_sharesofbeneficialinterest := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_sharesofbeneficialinterest)));
    avelength_stock_sharesofbeneficialinterest := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_sharesofbeneficialinterest)),h.stock_sharesofbeneficialinterest<>(typeof(h.stock_sharesofbeneficialinterest))'');
    populated_stock_beneficialsharevalue_cnt := COUNT(GROUP,h.stock_beneficialsharevalue <> (TYPEOF(h.stock_beneficialsharevalue))'');
    populated_stock_beneficialsharevalue_pcnt := AVE(GROUP,IF(h.stock_beneficialsharevalue = (TYPEOF(h.stock_beneficialsharevalue))'',0,100));
    maxlength_stock_beneficialsharevalue := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_beneficialsharevalue)));
    avelength_stock_beneficialsharevalue := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.stock_beneficialsharevalue)),h.stock_beneficialsharevalue<>(typeof(h.stock_beneficialsharevalue))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_stock_ticker_symbol_pcnt *   0.00 / 100 + T.Populated_stock_exchange_pcnt *   0.00 / 100 + T.Populated_stock_type_pcnt *   0.00 / 100 + T.Populated_stock_class_pcnt *   0.00 / 100 + T.Populated_stock_shares_issued_pcnt *   0.00 / 100 + T.Populated_stock_authorized_nbr_pcnt *   0.00 / 100 + T.Populated_stock_par_value_pcnt *   0.00 / 100 + T.Populated_stock_nbr_par_shares_pcnt *   0.00 / 100 + T.Populated_stock_change_ind_pcnt *   0.00 / 100 + T.Populated_stock_change_date_pcnt *   0.00 / 100 + T.Populated_stock_voting_rights_ind_pcnt *   0.00 / 100 + T.Populated_stock_convert_ind_pcnt *   0.00 / 100 + T.Populated_stock_convert_date_pcnt *   0.00 / 100 + T.Populated_stock_change_in_cap_pcnt *   0.00 / 100 + T.Populated_stock_tax_capital_pcnt *   0.00 / 100 + T.Populated_stock_total_capital_pcnt *   0.00 / 100 + T.Populated_stock_addl_info_pcnt *   0.00 / 100 + T.Populated_stock_stock_description_pcnt *   0.00 / 100 + T.Populated_stock_stock_series_pcnt *   0.00 / 100 + T.Populated_stock_non_par_value_flag_pcnt *   0.00 / 100 + T.Populated_stock_additional_stock_pcnt *   0.00 / 100 + T.Populated_stock_shares_proportion_to_ohio_for_foreign_license_pcnt *   0.00 / 100 + T.Populated_stock_share_credits_pcnt *   0.00 / 100 + T.Populated_stock_authorized_capital_pcnt *   0.00 / 100 + T.Populated_stock_stock_paid_in_capital_pcnt *   0.00 / 100 + T.Populated_stock_pay_higher_stock_fees_pcnt *   0.00 / 100 + T.Populated_stock_actual_amt_invested_in_state_pcnt *   0.00 / 100 + T.Populated_stock_share_exchange_during_merger_pcnt *   0.00 / 100 + T.Populated_stock_date_stock_limit_approved_pcnt *   0.00 / 100 + T.Populated_stock_number_of_shares_paid_for_pcnt *   0.00 / 100 + T.Populated_stock_total_value_of_shares_paid_for_pcnt *   0.00 / 100 + T.Populated_stock_sharesofbeneficialinterest_pcnt *   0.00 / 100 + T.Populated_stock_beneficialsharevalue_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_ticker_symbol','stock_exchange','stock_type','stock_class','stock_shares_issued','stock_authorized_nbr','stock_par_value','stock_nbr_par_shares','stock_change_ind','stock_change_date','stock_voting_rights_ind','stock_convert_ind','stock_convert_date','stock_change_in_cap','stock_tax_capital','stock_total_capital','stock_addl_info','stock_stock_description','stock_stock_series','stock_non_par_value_flag','stock_additional_stock','stock_shares_proportion_to_ohio_for_foreign_license','stock_share_credits','stock_authorized_capital','stock_stock_paid_in_capital','stock_pay_higher_stock_fees','stock_actual_amt_invested_in_state','stock_share_exchange_during_merger','stock_date_stock_limit_approved','stock_number_of_shares_paid_for','stock_total_value_of_shares_paid_for','stock_sharesofbeneficialinterest','stock_beneficialsharevalue');
  SELF.populated_pcnt := CHOOSE(C,le.populated_corp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_stock_ticker_symbol_pcnt,le.populated_stock_exchange_pcnt,le.populated_stock_type_pcnt,le.populated_stock_class_pcnt,le.populated_stock_shares_issued_pcnt,le.populated_stock_authorized_nbr_pcnt,le.populated_stock_par_value_pcnt,le.populated_stock_nbr_par_shares_pcnt,le.populated_stock_change_ind_pcnt,le.populated_stock_change_date_pcnt,le.populated_stock_voting_rights_ind_pcnt,le.populated_stock_convert_ind_pcnt,le.populated_stock_convert_date_pcnt,le.populated_stock_change_in_cap_pcnt,le.populated_stock_tax_capital_pcnt,le.populated_stock_total_capital_pcnt,le.populated_stock_addl_info_pcnt,le.populated_stock_stock_description_pcnt,le.populated_stock_stock_series_pcnt,le.populated_stock_non_par_value_flag_pcnt,le.populated_stock_additional_stock_pcnt,le.populated_stock_shares_proportion_to_ohio_for_foreign_license_pcnt,le.populated_stock_share_credits_pcnt,le.populated_stock_authorized_capital_pcnt,le.populated_stock_stock_paid_in_capital_pcnt,le.populated_stock_pay_higher_stock_fees_pcnt,le.populated_stock_actual_amt_invested_in_state_pcnt,le.populated_stock_share_exchange_during_merger_pcnt,le.populated_stock_date_stock_limit_approved_pcnt,le.populated_stock_number_of_shares_paid_for_pcnt,le.populated_stock_total_value_of_shares_paid_for_pcnt,le.populated_stock_sharesofbeneficialinterest_pcnt,le.populated_stock_beneficialsharevalue_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_corp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_sos_charter_nbr,le.maxlength_stock_ticker_symbol,le.maxlength_stock_exchange,le.maxlength_stock_type,le.maxlength_stock_class,le.maxlength_stock_shares_issued,le.maxlength_stock_authorized_nbr,le.maxlength_stock_par_value,le.maxlength_stock_nbr_par_shares,le.maxlength_stock_change_ind,le.maxlength_stock_change_date,le.maxlength_stock_voting_rights_ind,le.maxlength_stock_convert_ind,le.maxlength_stock_convert_date,le.maxlength_stock_change_in_cap,le.maxlength_stock_tax_capital,le.maxlength_stock_total_capital,le.maxlength_stock_addl_info,le.maxlength_stock_stock_description,le.maxlength_stock_stock_series,le.maxlength_stock_non_par_value_flag,le.maxlength_stock_additional_stock,le.maxlength_stock_shares_proportion_to_ohio_for_foreign_license,le.maxlength_stock_share_credits,le.maxlength_stock_authorized_capital,le.maxlength_stock_stock_paid_in_capital,le.maxlength_stock_pay_higher_stock_fees,le.maxlength_stock_actual_amt_invested_in_state,le.maxlength_stock_share_exchange_during_merger,le.maxlength_stock_date_stock_limit_approved,le.maxlength_stock_number_of_shares_paid_for,le.maxlength_stock_total_value_of_shares_paid_for,le.maxlength_stock_sharesofbeneficialinterest,le.maxlength_stock_beneficialsharevalue);
  SELF.avelength := CHOOSE(C,le.avelength_corp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_sos_charter_nbr,le.avelength_stock_ticker_symbol,le.avelength_stock_exchange,le.avelength_stock_type,le.avelength_stock_class,le.avelength_stock_shares_issued,le.avelength_stock_authorized_nbr,le.avelength_stock_par_value,le.avelength_stock_nbr_par_shares,le.avelength_stock_change_ind,le.avelength_stock_change_date,le.avelength_stock_voting_rights_ind,le.avelength_stock_convert_ind,le.avelength_stock_convert_date,le.avelength_stock_change_in_cap,le.avelength_stock_tax_capital,le.avelength_stock_total_capital,le.avelength_stock_addl_info,le.avelength_stock_stock_description,le.avelength_stock_stock_series,le.avelength_stock_non_par_value_flag,le.avelength_stock_additional_stock,le.avelength_stock_shares_proportion_to_ohio_for_foreign_license,le.avelength_stock_share_credits,le.avelength_stock_authorized_capital,le.avelength_stock_stock_paid_in_capital,le.avelength_stock_pay_higher_stock_fees,le.avelength_stock_actual_amt_invested_in_state,le.avelength_stock_share_exchange_during_merger,le.avelength_stock_date_stock_limit_approved,le.avelength_stock_number_of_shares_paid_for,le.avelength_stock_total_value_of_shares_paid_for,le.avelength_stock_sharesofbeneficialinterest,le.avelength_stock_beneficialsharevalue);
END;
EXPORT invSummary := NORMALIZE(summary0, 40, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_sos_charter_nbr),TRIM((SALT38.StrType)le.stock_ticker_symbol),TRIM((SALT38.StrType)le.stock_exchange),TRIM((SALT38.StrType)le.stock_type),TRIM((SALT38.StrType)le.stock_class),TRIM((SALT38.StrType)le.stock_shares_issued),TRIM((SALT38.StrType)le.stock_authorized_nbr),TRIM((SALT38.StrType)le.stock_par_value),TRIM((SALT38.StrType)le.stock_nbr_par_shares),TRIM((SALT38.StrType)le.stock_change_ind),TRIM((SALT38.StrType)le.stock_change_date),TRIM((SALT38.StrType)le.stock_voting_rights_ind),TRIM((SALT38.StrType)le.stock_convert_ind),TRIM((SALT38.StrType)le.stock_convert_date),TRIM((SALT38.StrType)le.stock_change_in_cap),TRIM((SALT38.StrType)le.stock_tax_capital),TRIM((SALT38.StrType)le.stock_total_capital),TRIM((SALT38.StrType)le.stock_addl_info),TRIM((SALT38.StrType)le.stock_stock_description),TRIM((SALT38.StrType)le.stock_stock_series),TRIM((SALT38.StrType)le.stock_non_par_value_flag),TRIM((SALT38.StrType)le.stock_additional_stock),IF (le.stock_shares_proportion_to_ohio_for_foreign_license <> 0,TRIM((SALT38.StrType)le.stock_shares_proportion_to_ohio_for_foreign_license), ''),IF (le.stock_share_credits <> 0,TRIM((SALT38.StrType)le.stock_share_credits), ''),IF (le.stock_authorized_capital <> 0,TRIM((SALT38.StrType)le.stock_authorized_capital), ''),IF (le.stock_stock_paid_in_capital <> 0,TRIM((SALT38.StrType)le.stock_stock_paid_in_capital), ''),TRIM((SALT38.StrType)le.stock_pay_higher_stock_fees),IF (le.stock_actual_amt_invested_in_state <> 0,TRIM((SALT38.StrType)le.stock_actual_amt_invested_in_state), ''),TRIM((SALT38.StrType)le.stock_share_exchange_during_merger),TRIM((SALT38.StrType)le.stock_date_stock_limit_approved),IF (le.stock_number_of_shares_paid_for <> 0,TRIM((SALT38.StrType)le.stock_number_of_shares_paid_for), ''),IF (le.stock_total_value_of_shares_paid_for <> 0,TRIM((SALT38.StrType)le.stock_total_value_of_shares_paid_for), ''),IF (le.stock_sharesofbeneficialinterest <> 0,TRIM((SALT38.StrType)le.stock_sharesofbeneficialinterest), ''),IF (le.stock_beneficialsharevalue <> 0,TRIM((SALT38.StrType)le.stock_beneficialsharevalue), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_sos_charter_nbr),TRIM((SALT38.StrType)le.stock_ticker_symbol),TRIM((SALT38.StrType)le.stock_exchange),TRIM((SALT38.StrType)le.stock_type),TRIM((SALT38.StrType)le.stock_class),TRIM((SALT38.StrType)le.stock_shares_issued),TRIM((SALT38.StrType)le.stock_authorized_nbr),TRIM((SALT38.StrType)le.stock_par_value),TRIM((SALT38.StrType)le.stock_nbr_par_shares),TRIM((SALT38.StrType)le.stock_change_ind),TRIM((SALT38.StrType)le.stock_change_date),TRIM((SALT38.StrType)le.stock_voting_rights_ind),TRIM((SALT38.StrType)le.stock_convert_ind),TRIM((SALT38.StrType)le.stock_convert_date),TRIM((SALT38.StrType)le.stock_change_in_cap),TRIM((SALT38.StrType)le.stock_tax_capital),TRIM((SALT38.StrType)le.stock_total_capital),TRIM((SALT38.StrType)le.stock_addl_info),TRIM((SALT38.StrType)le.stock_stock_description),TRIM((SALT38.StrType)le.stock_stock_series),TRIM((SALT38.StrType)le.stock_non_par_value_flag),TRIM((SALT38.StrType)le.stock_additional_stock),IF (le.stock_shares_proportion_to_ohio_for_foreign_license <> 0,TRIM((SALT38.StrType)le.stock_shares_proportion_to_ohio_for_foreign_license), ''),IF (le.stock_share_credits <> 0,TRIM((SALT38.StrType)le.stock_share_credits), ''),IF (le.stock_authorized_capital <> 0,TRIM((SALT38.StrType)le.stock_authorized_capital), ''),IF (le.stock_stock_paid_in_capital <> 0,TRIM((SALT38.StrType)le.stock_stock_paid_in_capital), ''),TRIM((SALT38.StrType)le.stock_pay_higher_stock_fees),IF (le.stock_actual_amt_invested_in_state <> 0,TRIM((SALT38.StrType)le.stock_actual_amt_invested_in_state), ''),TRIM((SALT38.StrType)le.stock_share_exchange_during_merger),TRIM((SALT38.StrType)le.stock_date_stock_limit_approved),IF (le.stock_number_of_shares_paid_for <> 0,TRIM((SALT38.StrType)le.stock_number_of_shares_paid_for), ''),IF (le.stock_total_value_of_shares_paid_for <> 0,TRIM((SALT38.StrType)le.stock_total_value_of_shares_paid_for), ''),IF (le.stock_sharesofbeneficialinterest <> 0,TRIM((SALT38.StrType)le.stock_sharesofbeneficialinterest), ''),IF (le.stock_beneficialsharevalue <> 0,TRIM((SALT38.StrType)le.stock_beneficialsharevalue), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_sos_charter_nbr),TRIM((SALT38.StrType)le.stock_ticker_symbol),TRIM((SALT38.StrType)le.stock_exchange),TRIM((SALT38.StrType)le.stock_type),TRIM((SALT38.StrType)le.stock_class),TRIM((SALT38.StrType)le.stock_shares_issued),TRIM((SALT38.StrType)le.stock_authorized_nbr),TRIM((SALT38.StrType)le.stock_par_value),TRIM((SALT38.StrType)le.stock_nbr_par_shares),TRIM((SALT38.StrType)le.stock_change_ind),TRIM((SALT38.StrType)le.stock_change_date),TRIM((SALT38.StrType)le.stock_voting_rights_ind),TRIM((SALT38.StrType)le.stock_convert_ind),TRIM((SALT38.StrType)le.stock_convert_date),TRIM((SALT38.StrType)le.stock_change_in_cap),TRIM((SALT38.StrType)le.stock_tax_capital),TRIM((SALT38.StrType)le.stock_total_capital),TRIM((SALT38.StrType)le.stock_addl_info),TRIM((SALT38.StrType)le.stock_stock_description),TRIM((SALT38.StrType)le.stock_stock_series),TRIM((SALT38.StrType)le.stock_non_par_value_flag),TRIM((SALT38.StrType)le.stock_additional_stock),IF (le.stock_shares_proportion_to_ohio_for_foreign_license <> 0,TRIM((SALT38.StrType)le.stock_shares_proportion_to_ohio_for_foreign_license), ''),IF (le.stock_share_credits <> 0,TRIM((SALT38.StrType)le.stock_share_credits), ''),IF (le.stock_authorized_capital <> 0,TRIM((SALT38.StrType)le.stock_authorized_capital), ''),IF (le.stock_stock_paid_in_capital <> 0,TRIM((SALT38.StrType)le.stock_stock_paid_in_capital), ''),TRIM((SALT38.StrType)le.stock_pay_higher_stock_fees),IF (le.stock_actual_amt_invested_in_state <> 0,TRIM((SALT38.StrType)le.stock_actual_amt_invested_in_state), ''),TRIM((SALT38.StrType)le.stock_share_exchange_during_merger),TRIM((SALT38.StrType)le.stock_date_stock_limit_approved),IF (le.stock_number_of_shares_paid_for <> 0,TRIM((SALT38.StrType)le.stock_number_of_shares_paid_for), ''),IF (le.stock_total_value_of_shares_paid_for <> 0,TRIM((SALT38.StrType)le.stock_total_value_of_shares_paid_for), ''),IF (le.stock_sharesofbeneficialinterest <> 0,TRIM((SALT38.StrType)le.stock_sharesofbeneficialinterest), ''),IF (le.stock_beneficialsharevalue <> 0,TRIM((SALT38.StrType)le.stock_beneficialsharevalue), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'corp_key'}
      ,{2,'corp_vendor'}
      ,{3,'corp_vendor_county'}
      ,{4,'corp_vendor_subcode'}
      ,{5,'corp_state_origin'}
      ,{6,'corp_process_date'}
      ,{7,'corp_sos_charter_nbr'}
      ,{8,'stock_ticker_symbol'}
      ,{9,'stock_exchange'}
      ,{10,'stock_type'}
      ,{11,'stock_class'}
      ,{12,'stock_shares_issued'}
      ,{13,'stock_authorized_nbr'}
      ,{14,'stock_par_value'}
      ,{15,'stock_nbr_par_shares'}
      ,{16,'stock_change_ind'}
      ,{17,'stock_change_date'}
      ,{18,'stock_voting_rights_ind'}
      ,{19,'stock_convert_ind'}
      ,{20,'stock_convert_date'}
      ,{21,'stock_change_in_cap'}
      ,{22,'stock_tax_capital'}
      ,{23,'stock_total_capital'}
      ,{24,'stock_addl_info'}
      ,{25,'stock_stock_description'}
      ,{26,'stock_stock_series'}
      ,{27,'stock_non_par_value_flag'}
      ,{28,'stock_additional_stock'}
      ,{29,'stock_shares_proportion_to_ohio_for_foreign_license'}
      ,{30,'stock_share_credits'}
      ,{31,'stock_authorized_capital'}
      ,{32,'stock_stock_paid_in_capital'}
      ,{33,'stock_pay_higher_stock_fees'}
      ,{34,'stock_actual_amt_invested_in_state'}
      ,{35,'stock_share_exchange_during_merger'}
      ,{36,'stock_date_stock_limit_approved'}
      ,{37,'stock_number_of_shares_paid_for'}
      ,{38,'stock_total_value_of_shares_paid_for'}
      ,{39,'stock_sharesofbeneficialinterest'}
      ,{40,'stock_beneficialsharevalue'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_corp_key((SALT38.StrType)le.corp_key),
    Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT38.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT38.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date),
    Fields.InValid_corp_sos_charter_nbr((SALT38.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_stock_ticker_symbol((SALT38.StrType)le.stock_ticker_symbol),
    Fields.InValid_stock_exchange((SALT38.StrType)le.stock_exchange),
    Fields.InValid_stock_type((SALT38.StrType)le.stock_type),
    Fields.InValid_stock_class((SALT38.StrType)le.stock_class),
    Fields.InValid_stock_shares_issued((SALT38.StrType)le.stock_shares_issued),
    Fields.InValid_stock_authorized_nbr((SALT38.StrType)le.stock_authorized_nbr),
    Fields.InValid_stock_par_value((SALT38.StrType)le.stock_par_value),
    Fields.InValid_stock_nbr_par_shares((SALT38.StrType)le.stock_nbr_par_shares),
    Fields.InValid_stock_change_ind((SALT38.StrType)le.stock_change_ind),
    Fields.InValid_stock_change_date((SALT38.StrType)le.stock_change_date),
    Fields.InValid_stock_voting_rights_ind((SALT38.StrType)le.stock_voting_rights_ind),
    Fields.InValid_stock_convert_ind((SALT38.StrType)le.stock_convert_ind),
    Fields.InValid_stock_convert_date((SALT38.StrType)le.stock_convert_date),
    Fields.InValid_stock_change_in_cap((SALT38.StrType)le.stock_change_in_cap),
    Fields.InValid_stock_tax_capital((SALT38.StrType)le.stock_tax_capital),
    Fields.InValid_stock_total_capital((SALT38.StrType)le.stock_total_capital),
    Fields.InValid_stock_addl_info((SALT38.StrType)le.stock_addl_info),
    Fields.InValid_stock_stock_description((SALT38.StrType)le.stock_stock_description),
    Fields.InValid_stock_stock_series((SALT38.StrType)le.stock_stock_series),
    Fields.InValid_stock_non_par_value_flag((SALT38.StrType)le.stock_non_par_value_flag),
    Fields.InValid_stock_additional_stock((SALT38.StrType)le.stock_additional_stock),
    Fields.InValid_stock_shares_proportion_to_ohio_for_foreign_license((SALT38.StrType)le.stock_shares_proportion_to_ohio_for_foreign_license),
    Fields.InValid_stock_share_credits((SALT38.StrType)le.stock_share_credits),
    Fields.InValid_stock_authorized_capital((SALT38.StrType)le.stock_authorized_capital),
    Fields.InValid_stock_stock_paid_in_capital((SALT38.StrType)le.stock_stock_paid_in_capital),
    Fields.InValid_stock_pay_higher_stock_fees((SALT38.StrType)le.stock_pay_higher_stock_fees),
    Fields.InValid_stock_actual_amt_invested_in_state((SALT38.StrType)le.stock_actual_amt_invested_in_state),
    Fields.InValid_stock_share_exchange_during_merger((SALT38.StrType)le.stock_share_exchange_during_merger),
    Fields.InValid_stock_date_stock_limit_approved((SALT38.StrType)le.stock_date_stock_limit_approved),
    Fields.InValid_stock_number_of_shares_paid_for((SALT38.StrType)le.stock_number_of_shares_paid_for),
    Fields.InValid_stock_total_value_of_shares_paid_for((SALT38.StrType)le.stock_total_value_of_shares_paid_for),
    Fields.InValid_stock_sharesofbeneficialinterest((SALT38.StrType)le.stock_sharesofbeneficialinterest),
    Fields.InValid_stock_beneficialsharevalue((SALT38.StrType)le.stock_beneficialsharevalue),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,40,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_corp_key','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','invalid_charter_nbr','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_stock_authorized_nbr','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_stock_ticker_symbol(TotalErrors.ErrorNum),Fields.InValidMessage_stock_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_stock_type(TotalErrors.ErrorNum),Fields.InValidMessage_stock_class(TotalErrors.ErrorNum),Fields.InValidMessage_stock_shares_issued(TotalErrors.ErrorNum),Fields.InValidMessage_stock_authorized_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_stock_par_value(TotalErrors.ErrorNum),Fields.InValidMessage_stock_nbr_par_shares(TotalErrors.ErrorNum),Fields.InValidMessage_stock_change_ind(TotalErrors.ErrorNum),Fields.InValidMessage_stock_change_date(TotalErrors.ErrorNum),Fields.InValidMessage_stock_voting_rights_ind(TotalErrors.ErrorNum),Fields.InValidMessage_stock_convert_ind(TotalErrors.ErrorNum),Fields.InValidMessage_stock_convert_date(TotalErrors.ErrorNum),Fields.InValidMessage_stock_change_in_cap(TotalErrors.ErrorNum),Fields.InValidMessage_stock_tax_capital(TotalErrors.ErrorNum),Fields.InValidMessage_stock_total_capital(TotalErrors.ErrorNum),Fields.InValidMessage_stock_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_stock_stock_description(TotalErrors.ErrorNum),Fields.InValidMessage_stock_stock_series(TotalErrors.ErrorNum),Fields.InValidMessage_stock_non_par_value_flag(TotalErrors.ErrorNum),Fields.InValidMessage_stock_additional_stock(TotalErrors.ErrorNum),Fields.InValidMessage_stock_shares_proportion_to_ohio_for_foreign_license(TotalErrors.ErrorNum),Fields.InValidMessage_stock_share_credits(TotalErrors.ErrorNum),Fields.InValidMessage_stock_authorized_capital(TotalErrors.ErrorNum),Fields.InValidMessage_stock_stock_paid_in_capital(TotalErrors.ErrorNum),Fields.InValidMessage_stock_pay_higher_stock_fees(TotalErrors.ErrorNum),Fields.InValidMessage_stock_actual_amt_invested_in_state(TotalErrors.ErrorNum),Fields.InValidMessage_stock_share_exchange_during_merger(TotalErrors.ErrorNum),Fields.InValidMessage_stock_date_stock_limit_approved(TotalErrors.ErrorNum),Fields.InValidMessage_stock_number_of_shares_paid_for(TotalErrors.ErrorNum),Fields.InValidMessage_stock_total_value_of_shares_paid_for(TotalErrors.ErrorNum),Fields.InValidMessage_stock_sharesofbeneficialinterest(TotalErrors.ErrorNum),Fields.InValidMessage_stock_beneficialsharevalue(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_MI_Stock, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
