IMPORT SALT311,STD;
EXPORT Base_2015_Delta(DATASET(Base_2015_Layout_EBR)old_s, DATASET(Base_2015_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','trade_count1','debt1','high_credit_mask1','recent_high_credit1','account_balance_mask1','masked_account_balance1','current_balance_percent1','debt_01_30_percent1','debt_31_60_percent1','debt_61_90_percent1','debt_91_plus_percent1','trade_count2','debt2','high_credit_mask2','recent_high_credit2','account_balance_mask2','masked_account_balance2','current_balance_percent2','debt_01_30_percent2','debt_31_60_percent2','debt_61_90_percent2','debt_91_plus_percent2','trade_count3','debt3','high_credit_mask3','recent_high_credit3','account_balance_mask3','masked_account_balance3','current_balance_percent3','debt_01_30_percent3','debt_31_60_percent3','debt_61_90_percent3','debt_91_plus_percent3','highest_credit_median','orig_account_balance_regular_tradelines','orig_account_balance_new','orig_account_balance_combined','aged_trades_count','account_balance_regular_tradelines','account_balance_new','account_balance_combined'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_2015_hygiene(old_s).Summary('Old') + Base_2015_hygiene(new_s).Summary('New') + Base_2015_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_2015_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_2015_hygiene(PROJECT(Differences(added), TRANSFORM(Base_2015_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_2015_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
