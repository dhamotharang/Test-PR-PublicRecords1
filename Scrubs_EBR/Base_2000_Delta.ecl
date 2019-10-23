IMPORT SALT311,STD;
EXPORT Base_2000_Delta(DATASET(Base_2000_Layout_EBR)old_s, DATASET(Base_2000_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','payment_indicator','business_category_code','business_category_description','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','account_balance_mask','masked_account_balance','current_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent','new_trade_flag','trade_type_code','trade_type_desc','date_reported','date_last_sale'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_2000_hygiene(old_s).Summary('Old') + Base_2000_hygiene(new_s).Summary('New') + Base_2000_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_2000_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_2000_hygiene(PROJECT(Differences(added), TRANSFORM(Base_2000_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_2000_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
