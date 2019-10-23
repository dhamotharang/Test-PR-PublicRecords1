IMPORT SALT38,STD,Corp2_Mapping;
EXPORT Delta(DATASET(Corp2_Mapping.LayoutsCommon.Stock)old_s, DATASET(Corp2_Mapping.LayoutsCommon.Stock) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_ticker_symbol','stock_exchange','stock_type','stock_class','stock_shares_issued','stock_authorized_nbr','stock_par_value','stock_nbr_par_shares','stock_change_ind','stock_change_date','stock_voting_rights_ind','stock_convert_ind','stock_convert_date','stock_change_in_cap','stock_tax_capital','stock_total_capital','stock_addl_info','stock_stock_description','stock_stock_series','stock_non_par_value_flag','stock_additional_stock','stock_shares_proportion_to_ohio_for_foreign_license','stock_share_credits','stock_authorized_capital','stock_stock_paid_in_capital','stock_pay_higher_stock_fees','stock_actual_amt_invested_in_state','stock_share_exchange_during_merger','stock_date_stock_limit_approved','stock_number_of_shares_paid_for','stock_total_value_of_shares_paid_for','stock_sharesofbeneficialinterest','stock_beneficialsharevalue'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Corp2_Mapping.LayoutsCommon.Stock, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Corp2_Mapping.LayoutsCommon.Stock, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_MI_Stock, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
