IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_2015_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 56;
  EXPORT NumRulesFromFieldType := 56;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 55;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_2015_Layout_EBR)
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 process_date_first_seen_Invalid;
    UNSIGNED1 process_date_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 file_number_Invalid;
    UNSIGNED1 segment_code_Invalid;
    UNSIGNED1 trade_count1_Invalid;
    UNSIGNED1 debt1_Invalid;
    UNSIGNED1 high_credit_mask1_Invalid;
    UNSIGNED1 recent_high_credit1_Invalid;
    UNSIGNED1 account_balance_mask1_Invalid;
    UNSIGNED1 masked_account_balance1_Invalid;
    UNSIGNED1 current_balance_percent1_Invalid;
    UNSIGNED1 debt_01_30_percent1_Invalid;
    UNSIGNED1 debt_31_60_percent1_Invalid;
    UNSIGNED1 debt_61_90_percent1_Invalid;
    UNSIGNED1 debt_91_plus_percent1_Invalid;
    UNSIGNED1 trade_count2_Invalid;
    UNSIGNED1 debt2_Invalid;
    UNSIGNED1 high_credit_mask2_Invalid;
    UNSIGNED1 recent_high_credit2_Invalid;
    UNSIGNED1 account_balance_mask2_Invalid;
    UNSIGNED1 masked_account_balance2_Invalid;
    UNSIGNED1 current_balance_percent2_Invalid;
    UNSIGNED1 debt_01_30_percent2_Invalid;
    UNSIGNED1 debt_31_60_percent2_Invalid;
    UNSIGNED1 debt_61_90_percent2_Invalid;
    UNSIGNED1 debt_91_plus_percent2_Invalid;
    UNSIGNED1 trade_count3_Invalid;
    UNSIGNED1 debt3_Invalid;
    UNSIGNED1 high_credit_mask3_Invalid;
    UNSIGNED1 recent_high_credit3_Invalid;
    UNSIGNED1 account_balance_mask3_Invalid;
    UNSIGNED1 masked_account_balance3_Invalid;
    UNSIGNED1 current_balance_percent3_Invalid;
    UNSIGNED1 debt_01_30_percent3_Invalid;
    UNSIGNED1 debt_31_60_percent3_Invalid;
    UNSIGNED1 debt_61_90_percent3_Invalid;
    UNSIGNED1 debt_91_plus_percent3_Invalid;
    UNSIGNED1 highest_credit_median_Invalid;
    UNSIGNED1 orig_account_balance_regular_tradelines_Invalid;
    UNSIGNED1 orig_account_balance_new_Invalid;
    UNSIGNED1 orig_account_balance_combined_Invalid;
    UNSIGNED1 aged_trades_count_Invalid;
    UNSIGNED1 account_balance_regular_tradelines_Invalid;
    UNSIGNED1 account_balance_new_Invalid;
    UNSIGNED1 account_balance_combined_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_2015_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_2015_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_2015_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_2015_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_2015_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_2015_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_2015_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_2015_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_2015_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_2015_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_2015_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_2015_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_2015_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_2015_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_2015_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.segment_code_Invalid := Base_2015_Fields.InValid_segment_code((SALT311.StrType)le.segment_code);
    SELF.trade_count1_Invalid := Base_2015_Fields.InValid_trade_count1((SALT311.StrType)le.trade_count1);
    SELF.debt1_Invalid := Base_2015_Fields.InValid_debt1((SALT311.StrType)le.debt1);
    SELF.high_credit_mask1_Invalid := Base_2015_Fields.InValid_high_credit_mask1((SALT311.StrType)le.high_credit_mask1);
    SELF.recent_high_credit1_Invalid := Base_2015_Fields.InValid_recent_high_credit1((SALT311.StrType)le.recent_high_credit1);
    SELF.account_balance_mask1_Invalid := Base_2015_Fields.InValid_account_balance_mask1((SALT311.StrType)le.account_balance_mask1);
    SELF.masked_account_balance1_Invalid := Base_2015_Fields.InValid_masked_account_balance1((SALT311.StrType)le.masked_account_balance1);
    SELF.current_balance_percent1_Invalid := Base_2015_Fields.InValid_current_balance_percent1((SALT311.StrType)le.current_balance_percent1);
    SELF.debt_01_30_percent1_Invalid := Base_2015_Fields.InValid_debt_01_30_percent1((SALT311.StrType)le.debt_01_30_percent1);
    SELF.debt_31_60_percent1_Invalid := Base_2015_Fields.InValid_debt_31_60_percent1((SALT311.StrType)le.debt_31_60_percent1);
    SELF.debt_61_90_percent1_Invalid := Base_2015_Fields.InValid_debt_61_90_percent1((SALT311.StrType)le.debt_61_90_percent1);
    SELF.debt_91_plus_percent1_Invalid := Base_2015_Fields.InValid_debt_91_plus_percent1((SALT311.StrType)le.debt_91_plus_percent1);
    SELF.trade_count2_Invalid := Base_2015_Fields.InValid_trade_count2((SALT311.StrType)le.trade_count2);
    SELF.debt2_Invalid := Base_2015_Fields.InValid_debt2((SALT311.StrType)le.debt2);
    SELF.high_credit_mask2_Invalid := Base_2015_Fields.InValid_high_credit_mask2((SALT311.StrType)le.high_credit_mask2);
    SELF.recent_high_credit2_Invalid := Base_2015_Fields.InValid_recent_high_credit2((SALT311.StrType)le.recent_high_credit2);
    SELF.account_balance_mask2_Invalid := Base_2015_Fields.InValid_account_balance_mask2((SALT311.StrType)le.account_balance_mask2);
    SELF.masked_account_balance2_Invalid := Base_2015_Fields.InValid_masked_account_balance2((SALT311.StrType)le.masked_account_balance2);
    SELF.current_balance_percent2_Invalid := Base_2015_Fields.InValid_current_balance_percent2((SALT311.StrType)le.current_balance_percent2);
    SELF.debt_01_30_percent2_Invalid := Base_2015_Fields.InValid_debt_01_30_percent2((SALT311.StrType)le.debt_01_30_percent2);
    SELF.debt_31_60_percent2_Invalid := Base_2015_Fields.InValid_debt_31_60_percent2((SALT311.StrType)le.debt_31_60_percent2);
    SELF.debt_61_90_percent2_Invalid := Base_2015_Fields.InValid_debt_61_90_percent2((SALT311.StrType)le.debt_61_90_percent2);
    SELF.debt_91_plus_percent2_Invalid := Base_2015_Fields.InValid_debt_91_plus_percent2((SALT311.StrType)le.debt_91_plus_percent2);
    SELF.trade_count3_Invalid := Base_2015_Fields.InValid_trade_count3((SALT311.StrType)le.trade_count3);
    SELF.debt3_Invalid := Base_2015_Fields.InValid_debt3((SALT311.StrType)le.debt3);
    SELF.high_credit_mask3_Invalid := Base_2015_Fields.InValid_high_credit_mask3((SALT311.StrType)le.high_credit_mask3);
    SELF.recent_high_credit3_Invalid := Base_2015_Fields.InValid_recent_high_credit3((SALT311.StrType)le.recent_high_credit3);
    SELF.account_balance_mask3_Invalid := Base_2015_Fields.InValid_account_balance_mask3((SALT311.StrType)le.account_balance_mask3);
    SELF.masked_account_balance3_Invalid := Base_2015_Fields.InValid_masked_account_balance3((SALT311.StrType)le.masked_account_balance3);
    SELF.current_balance_percent3_Invalid := Base_2015_Fields.InValid_current_balance_percent3((SALT311.StrType)le.current_balance_percent3);
    SELF.debt_01_30_percent3_Invalid := Base_2015_Fields.InValid_debt_01_30_percent3((SALT311.StrType)le.debt_01_30_percent3);
    SELF.debt_31_60_percent3_Invalid := Base_2015_Fields.InValid_debt_31_60_percent3((SALT311.StrType)le.debt_31_60_percent3);
    SELF.debt_61_90_percent3_Invalid := Base_2015_Fields.InValid_debt_61_90_percent3((SALT311.StrType)le.debt_61_90_percent3);
    SELF.debt_91_plus_percent3_Invalid := Base_2015_Fields.InValid_debt_91_plus_percent3((SALT311.StrType)le.debt_91_plus_percent3);
    SELF.highest_credit_median_Invalid := Base_2015_Fields.InValid_highest_credit_median((SALT311.StrType)le.highest_credit_median);
    SELF.orig_account_balance_regular_tradelines_Invalid := Base_2015_Fields.InValid_orig_account_balance_regular_tradelines((SALT311.StrType)le.orig_account_balance_regular_tradelines);
    SELF.orig_account_balance_new_Invalid := Base_2015_Fields.InValid_orig_account_balance_new((SALT311.StrType)le.orig_account_balance_new);
    SELF.orig_account_balance_combined_Invalid := Base_2015_Fields.InValid_orig_account_balance_combined((SALT311.StrType)le.orig_account_balance_combined);
    SELF.aged_trades_count_Invalid := Base_2015_Fields.InValid_aged_trades_count((SALT311.StrType)le.aged_trades_count);
    SELF.account_balance_regular_tradelines_Invalid := Base_2015_Fields.InValid_account_balance_regular_tradelines((SALT311.StrType)le.account_balance_regular_tradelines);
    SELF.account_balance_new_Invalid := Base_2015_Fields.InValid_account_balance_new((SALT311.StrType)le.account_balance_new);
    SELF.account_balance_combined_Invalid := Base_2015_Fields.InValid_account_balance_combined((SALT311.StrType)le.account_balance_combined);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_2015_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.segment_code_Invalid << 14 ) + ( le.trade_count1_Invalid << 15 ) + ( le.debt1_Invalid << 16 ) + ( le.high_credit_mask1_Invalid << 17 ) + ( le.recent_high_credit1_Invalid << 18 ) + ( le.account_balance_mask1_Invalid << 19 ) + ( le.masked_account_balance1_Invalid << 20 ) + ( le.current_balance_percent1_Invalid << 21 ) + ( le.debt_01_30_percent1_Invalid << 22 ) + ( le.debt_31_60_percent1_Invalid << 23 ) + ( le.debt_61_90_percent1_Invalid << 24 ) + ( le.debt_91_plus_percent1_Invalid << 25 ) + ( le.trade_count2_Invalid << 26 ) + ( le.debt2_Invalid << 27 ) + ( le.high_credit_mask2_Invalid << 28 ) + ( le.recent_high_credit2_Invalid << 29 ) + ( le.account_balance_mask2_Invalid << 30 ) + ( le.masked_account_balance2_Invalid << 31 ) + ( le.current_balance_percent2_Invalid << 32 ) + ( le.debt_01_30_percent2_Invalid << 33 ) + ( le.debt_31_60_percent2_Invalid << 34 ) + ( le.debt_61_90_percent2_Invalid << 35 ) + ( le.debt_91_plus_percent2_Invalid << 36 ) + ( le.trade_count3_Invalid << 37 ) + ( le.debt3_Invalid << 38 ) + ( le.high_credit_mask3_Invalid << 39 ) + ( le.recent_high_credit3_Invalid << 40 ) + ( le.account_balance_mask3_Invalid << 41 ) + ( le.masked_account_balance3_Invalid << 42 ) + ( le.current_balance_percent3_Invalid << 43 ) + ( le.debt_01_30_percent3_Invalid << 44 ) + ( le.debt_31_60_percent3_Invalid << 45 ) + ( le.debt_61_90_percent3_Invalid << 46 ) + ( le.debt_91_plus_percent3_Invalid << 47 ) + ( le.highest_credit_median_Invalid << 48 ) + ( le.orig_account_balance_regular_tradelines_Invalid << 49 ) + ( le.orig_account_balance_new_Invalid << 50 ) + ( le.orig_account_balance_combined_Invalid << 51 ) + ( le.aged_trades_count_Invalid << 52 ) + ( le.account_balance_regular_tradelines_Invalid << 53 ) + ( le.account_balance_new_Invalid << 54 ) + ( le.account_balance_combined_Invalid << 55 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_2015_Layout_EBR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.powid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.process_date_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.process_date_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.file_number_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.segment_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.trade_count1_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.debt1_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.high_credit_mask1_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.recent_high_credit1_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.account_balance_mask1_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.masked_account_balance1_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.current_balance_percent1_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.debt_01_30_percent1_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.debt_31_60_percent1_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.debt_61_90_percent1_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.debt_91_plus_percent1_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.trade_count2_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.debt2_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.high_credit_mask2_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.recent_high_credit2_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.account_balance_mask2_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.masked_account_balance2_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.current_balance_percent2_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.debt_01_30_percent2_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.debt_31_60_percent2_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.debt_61_90_percent2_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.debt_91_plus_percent2_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.trade_count3_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.debt3_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.high_credit_mask3_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.recent_high_credit3_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.account_balance_mask3_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.masked_account_balance3_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.current_balance_percent3_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.debt_01_30_percent3_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.debt_31_60_percent3_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.debt_61_90_percent3_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.debt_91_plus_percent3_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.highest_credit_median_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.orig_account_balance_regular_tradelines_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.orig_account_balance_new_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.orig_account_balance_combined_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.aged_trades_count_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.account_balance_regular_tradelines_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.account_balance_new_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.account_balance_combined_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    powid_LENGTHS_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_LENGTHS_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_LENGTHS_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_LENGTHS_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_LENGTHS_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    process_date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_first_seen_Invalid=1);
    process_date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_last_seen_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    file_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_number_Invalid=1);
    file_number_LENGTHS_ErrorCount := COUNT(GROUP,h.file_number_Invalid=2);
    file_number_Total_ErrorCount := COUNT(GROUP,h.file_number_Invalid>0);
    segment_code_ENUM_ErrorCount := COUNT(GROUP,h.segment_code_Invalid=1);
    trade_count1_CUSTOM_ErrorCount := COUNT(GROUP,h.trade_count1_Invalid=1);
    debt1_CUSTOM_ErrorCount := COUNT(GROUP,h.debt1_Invalid=1);
    high_credit_mask1_ENUM_ErrorCount := COUNT(GROUP,h.high_credit_mask1_Invalid=1);
    recent_high_credit1_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_high_credit1_Invalid=1);
    account_balance_mask1_ENUM_ErrorCount := COUNT(GROUP,h.account_balance_mask1_Invalid=1);
    masked_account_balance1_CUSTOM_ErrorCount := COUNT(GROUP,h.masked_account_balance1_Invalid=1);
    current_balance_percent1_CUSTOM_ErrorCount := COUNT(GROUP,h.current_balance_percent1_Invalid=1);
    debt_01_30_percent1_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_01_30_percent1_Invalid=1);
    debt_31_60_percent1_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_31_60_percent1_Invalid=1);
    debt_61_90_percent1_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_61_90_percent1_Invalid=1);
    debt_91_plus_percent1_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_91_plus_percent1_Invalid=1);
    trade_count2_CUSTOM_ErrorCount := COUNT(GROUP,h.trade_count2_Invalid=1);
    debt2_CUSTOM_ErrorCount := COUNT(GROUP,h.debt2_Invalid=1);
    high_credit_mask2_ENUM_ErrorCount := COUNT(GROUP,h.high_credit_mask2_Invalid=1);
    recent_high_credit2_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_high_credit2_Invalid=1);
    account_balance_mask2_ENUM_ErrorCount := COUNT(GROUP,h.account_balance_mask2_Invalid=1);
    masked_account_balance2_CUSTOM_ErrorCount := COUNT(GROUP,h.masked_account_balance2_Invalid=1);
    current_balance_percent2_CUSTOM_ErrorCount := COUNT(GROUP,h.current_balance_percent2_Invalid=1);
    debt_01_30_percent2_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_01_30_percent2_Invalid=1);
    debt_31_60_percent2_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_31_60_percent2_Invalid=1);
    debt_61_90_percent2_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_61_90_percent2_Invalid=1);
    debt_91_plus_percent2_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_91_plus_percent2_Invalid=1);
    trade_count3_CUSTOM_ErrorCount := COUNT(GROUP,h.trade_count3_Invalid=1);
    debt3_CUSTOM_ErrorCount := COUNT(GROUP,h.debt3_Invalid=1);
    high_credit_mask3_ENUM_ErrorCount := COUNT(GROUP,h.high_credit_mask3_Invalid=1);
    recent_high_credit3_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_high_credit3_Invalid=1);
    account_balance_mask3_ENUM_ErrorCount := COUNT(GROUP,h.account_balance_mask3_Invalid=1);
    masked_account_balance3_CUSTOM_ErrorCount := COUNT(GROUP,h.masked_account_balance3_Invalid=1);
    current_balance_percent3_CUSTOM_ErrorCount := COUNT(GROUP,h.current_balance_percent3_Invalid=1);
    debt_01_30_percent3_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_01_30_percent3_Invalid=1);
    debt_31_60_percent3_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_31_60_percent3_Invalid=1);
    debt_61_90_percent3_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_61_90_percent3_Invalid=1);
    debt_91_plus_percent3_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_91_plus_percent3_Invalid=1);
    highest_credit_median_CUSTOM_ErrorCount := COUNT(GROUP,h.highest_credit_median_Invalid=1);
    orig_account_balance_regular_tradelines_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_account_balance_regular_tradelines_Invalid=1);
    orig_account_balance_new_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_account_balance_new_Invalid=1);
    orig_account_balance_combined_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_account_balance_combined_Invalid=1);
    aged_trades_count_CUSTOM_ErrorCount := COUNT(GROUP,h.aged_trades_count_Invalid=1);
    account_balance_regular_tradelines_CUSTOM_ErrorCount := COUNT(GROUP,h.account_balance_regular_tradelines_Invalid=1);
    account_balance_new_CUSTOM_ErrorCount := COUNT(GROUP,h.account_balance_new_Invalid=1);
    account_balance_combined_CUSTOM_ErrorCount := COUNT(GROUP,h.account_balance_combined_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.segment_code_Invalid > 0 OR h.trade_count1_Invalid > 0 OR h.debt1_Invalid > 0 OR h.high_credit_mask1_Invalid > 0 OR h.recent_high_credit1_Invalid > 0 OR h.account_balance_mask1_Invalid > 0 OR h.masked_account_balance1_Invalid > 0 OR h.current_balance_percent1_Invalid > 0 OR h.debt_01_30_percent1_Invalid > 0 OR h.debt_31_60_percent1_Invalid > 0 OR h.debt_61_90_percent1_Invalid > 0 OR h.debt_91_plus_percent1_Invalid > 0 OR h.trade_count2_Invalid > 0 OR h.debt2_Invalid > 0 OR h.high_credit_mask2_Invalid > 0 OR h.recent_high_credit2_Invalid > 0 OR h.account_balance_mask2_Invalid > 0 OR h.masked_account_balance2_Invalid > 0 OR h.current_balance_percent2_Invalid > 0 OR h.debt_01_30_percent2_Invalid > 0 OR h.debt_31_60_percent2_Invalid > 0 OR h.debt_61_90_percent2_Invalid > 0 OR h.debt_91_plus_percent2_Invalid > 0 OR h.trade_count3_Invalid > 0 OR h.debt3_Invalid > 0 OR h.high_credit_mask3_Invalid > 0 OR h.recent_high_credit3_Invalid > 0 OR h.account_balance_mask3_Invalid > 0 OR h.masked_account_balance3_Invalid > 0 OR h.current_balance_percent3_Invalid > 0 OR h.debt_01_30_percent3_Invalid > 0 OR h.debt_31_60_percent3_Invalid > 0 OR h.debt_61_90_percent3_Invalid > 0 OR h.debt_91_plus_percent3_Invalid > 0 OR h.highest_credit_median_Invalid > 0 OR h.orig_account_balance_regular_tradelines_Invalid > 0 OR h.orig_account_balance_new_Invalid > 0 OR h.orig_account_balance_combined_Invalid > 0 OR h.aged_trades_count_Invalid > 0 OR h.account_balance_regular_tradelines_Invalid > 0 OR h.account_balance_new_Invalid > 0 OR h.account_balance_combined_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.trade_count1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask1_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask1_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_account_balance1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.trade_count2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask2_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask2_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_account_balance2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.trade_count3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask3_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask3_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_account_balance3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.highest_credit_median_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_account_balance_regular_tradelines_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_account_balance_new_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_account_balance_combined_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.aged_trades_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_regular_tradelines_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_new_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_combined_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.trade_count1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask1_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask1_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_account_balance1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.trade_count2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask2_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask2_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_account_balance2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.trade_count3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask3_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask3_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_account_balance3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.highest_credit_median_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_account_balance_regular_tradelines_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_account_balance_new_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_account_balance_combined_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.aged_trades_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_regular_tradelines_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_new_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_combined_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.segment_code_Invalid,le.trade_count1_Invalid,le.debt1_Invalid,le.high_credit_mask1_Invalid,le.recent_high_credit1_Invalid,le.account_balance_mask1_Invalid,le.masked_account_balance1_Invalid,le.current_balance_percent1_Invalid,le.debt_01_30_percent1_Invalid,le.debt_31_60_percent1_Invalid,le.debt_61_90_percent1_Invalid,le.debt_91_plus_percent1_Invalid,le.trade_count2_Invalid,le.debt2_Invalid,le.high_credit_mask2_Invalid,le.recent_high_credit2_Invalid,le.account_balance_mask2_Invalid,le.masked_account_balance2_Invalid,le.current_balance_percent2_Invalid,le.debt_01_30_percent2_Invalid,le.debt_31_60_percent2_Invalid,le.debt_61_90_percent2_Invalid,le.debt_91_plus_percent2_Invalid,le.trade_count3_Invalid,le.debt3_Invalid,le.high_credit_mask3_Invalid,le.recent_high_credit3_Invalid,le.account_balance_mask3_Invalid,le.masked_account_balance3_Invalid,le.current_balance_percent3_Invalid,le.debt_01_30_percent3_Invalid,le.debt_31_60_percent3_Invalid,le.debt_61_90_percent3_Invalid,le.debt_91_plus_percent3_Invalid,le.highest_credit_median_Invalid,le.orig_account_balance_regular_tradelines_Invalid,le.orig_account_balance_new_Invalid,le.orig_account_balance_combined_Invalid,le.aged_trades_count_Invalid,le.account_balance_regular_tradelines_Invalid,le.account_balance_new_Invalid,le.account_balance_combined_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_2015_Fields.InvalidMessage_powid(le.powid_Invalid),Base_2015_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_2015_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_2015_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_2015_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_2015_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_2015_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_2015_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_2015_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_2015_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_2015_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_2015_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_2015_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_2015_Fields.InvalidMessage_segment_code(le.segment_code_Invalid),Base_2015_Fields.InvalidMessage_trade_count1(le.trade_count1_Invalid),Base_2015_Fields.InvalidMessage_debt1(le.debt1_Invalid),Base_2015_Fields.InvalidMessage_high_credit_mask1(le.high_credit_mask1_Invalid),Base_2015_Fields.InvalidMessage_recent_high_credit1(le.recent_high_credit1_Invalid),Base_2015_Fields.InvalidMessage_account_balance_mask1(le.account_balance_mask1_Invalid),Base_2015_Fields.InvalidMessage_masked_account_balance1(le.masked_account_balance1_Invalid),Base_2015_Fields.InvalidMessage_current_balance_percent1(le.current_balance_percent1_Invalid),Base_2015_Fields.InvalidMessage_debt_01_30_percent1(le.debt_01_30_percent1_Invalid),Base_2015_Fields.InvalidMessage_debt_31_60_percent1(le.debt_31_60_percent1_Invalid),Base_2015_Fields.InvalidMessage_debt_61_90_percent1(le.debt_61_90_percent1_Invalid),Base_2015_Fields.InvalidMessage_debt_91_plus_percent1(le.debt_91_plus_percent1_Invalid),Base_2015_Fields.InvalidMessage_trade_count2(le.trade_count2_Invalid),Base_2015_Fields.InvalidMessage_debt2(le.debt2_Invalid),Base_2015_Fields.InvalidMessage_high_credit_mask2(le.high_credit_mask2_Invalid),Base_2015_Fields.InvalidMessage_recent_high_credit2(le.recent_high_credit2_Invalid),Base_2015_Fields.InvalidMessage_account_balance_mask2(le.account_balance_mask2_Invalid),Base_2015_Fields.InvalidMessage_masked_account_balance2(le.masked_account_balance2_Invalid),Base_2015_Fields.InvalidMessage_current_balance_percent2(le.current_balance_percent2_Invalid),Base_2015_Fields.InvalidMessage_debt_01_30_percent2(le.debt_01_30_percent2_Invalid),Base_2015_Fields.InvalidMessage_debt_31_60_percent2(le.debt_31_60_percent2_Invalid),Base_2015_Fields.InvalidMessage_debt_61_90_percent2(le.debt_61_90_percent2_Invalid),Base_2015_Fields.InvalidMessage_debt_91_plus_percent2(le.debt_91_plus_percent2_Invalid),Base_2015_Fields.InvalidMessage_trade_count3(le.trade_count3_Invalid),Base_2015_Fields.InvalidMessage_debt3(le.debt3_Invalid),Base_2015_Fields.InvalidMessage_high_credit_mask3(le.high_credit_mask3_Invalid),Base_2015_Fields.InvalidMessage_recent_high_credit3(le.recent_high_credit3_Invalid),Base_2015_Fields.InvalidMessage_account_balance_mask3(le.account_balance_mask3_Invalid),Base_2015_Fields.InvalidMessage_masked_account_balance3(le.masked_account_balance3_Invalid),Base_2015_Fields.InvalidMessage_current_balance_percent3(le.current_balance_percent3_Invalid),Base_2015_Fields.InvalidMessage_debt_01_30_percent3(le.debt_01_30_percent3_Invalid),Base_2015_Fields.InvalidMessage_debt_31_60_percent3(le.debt_31_60_percent3_Invalid),Base_2015_Fields.InvalidMessage_debt_61_90_percent3(le.debt_61_90_percent3_Invalid),Base_2015_Fields.InvalidMessage_debt_91_plus_percent3(le.debt_91_plus_percent3_Invalid),Base_2015_Fields.InvalidMessage_highest_credit_median(le.highest_credit_median_Invalid),Base_2015_Fields.InvalidMessage_orig_account_balance_regular_tradelines(le.orig_account_balance_regular_tradelines_Invalid),Base_2015_Fields.InvalidMessage_orig_account_balance_new(le.orig_account_balance_new_Invalid),Base_2015_Fields.InvalidMessage_orig_account_balance_combined(le.orig_account_balance_combined_Invalid),Base_2015_Fields.InvalidMessage_aged_trades_count(le.aged_trades_count_Invalid),Base_2015_Fields.InvalidMessage_account_balance_regular_tradelines(le.account_balance_regular_tradelines_Invalid),Base_2015_Fields.InvalidMessage_account_balance_new(le.account_balance_new_Invalid),Base_2015_Fields.InvalidMessage_account_balance_combined(le.account_balance_combined_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.powid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.segment_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.trade_count1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.high_credit_mask1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recent_high_credit1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_mask1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.masked_account_balance1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_balance_percent1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_01_30_percent1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_31_60_percent1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_61_90_percent1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_91_plus_percent1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.trade_count2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.high_credit_mask2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recent_high_credit2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_mask2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.masked_account_balance2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_balance_percent2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_01_30_percent2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_31_60_percent2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_61_90_percent2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_91_plus_percent2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.trade_count3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.high_credit_mask3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recent_high_credit3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_mask3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.masked_account_balance3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_balance_percent3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_01_30_percent3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_31_60_percent3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_61_90_percent3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_91_plus_percent3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.highest_credit_median_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_account_balance_regular_tradelines_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_account_balance_new_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_account_balance_combined_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.aged_trades_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_regular_tradelines_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_new_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_combined_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','trade_count1','debt1','high_credit_mask1','recent_high_credit1','account_balance_mask1','masked_account_balance1','current_balance_percent1','debt_01_30_percent1','debt_31_60_percent1','debt_61_90_percent1','debt_91_plus_percent1','trade_count2','debt2','high_credit_mask2','recent_high_credit2','account_balance_mask2','masked_account_balance2','current_balance_percent2','debt_01_30_percent2','debt_31_60_percent2','debt_61_90_percent2','debt_91_plus_percent2','trade_count3','debt3','high_credit_mask3','recent_high_credit3','account_balance_mask3','masked_account_balance3','current_balance_percent3','debt_01_30_percent3','debt_31_60_percent3','debt_61_90_percent3','debt_91_plus_percent3','highest_credit_median','orig_account_balance_regular_tradelines','orig_account_balance_new','orig_account_balance_combined','aged_trades_count','account_balance_regular_tradelines','account_balance_new','account_balance_combined','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_account_balance','invalid_account_balance','invalid_account_balance','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.segment_code,(SALT311.StrType)le.trade_count1,(SALT311.StrType)le.debt1,(SALT311.StrType)le.high_credit_mask1,(SALT311.StrType)le.recent_high_credit1,(SALT311.StrType)le.account_balance_mask1,(SALT311.StrType)le.masked_account_balance1,(SALT311.StrType)le.current_balance_percent1,(SALT311.StrType)le.debt_01_30_percent1,(SALT311.StrType)le.debt_31_60_percent1,(SALT311.StrType)le.debt_61_90_percent1,(SALT311.StrType)le.debt_91_plus_percent1,(SALT311.StrType)le.trade_count2,(SALT311.StrType)le.debt2,(SALT311.StrType)le.high_credit_mask2,(SALT311.StrType)le.recent_high_credit2,(SALT311.StrType)le.account_balance_mask2,(SALT311.StrType)le.masked_account_balance2,(SALT311.StrType)le.current_balance_percent2,(SALT311.StrType)le.debt_01_30_percent2,(SALT311.StrType)le.debt_31_60_percent2,(SALT311.StrType)le.debt_61_90_percent2,(SALT311.StrType)le.debt_91_plus_percent2,(SALT311.StrType)le.trade_count3,(SALT311.StrType)le.debt3,(SALT311.StrType)le.high_credit_mask3,(SALT311.StrType)le.recent_high_credit3,(SALT311.StrType)le.account_balance_mask3,(SALT311.StrType)le.masked_account_balance3,(SALT311.StrType)le.current_balance_percent3,(SALT311.StrType)le.debt_01_30_percent3,(SALT311.StrType)le.debt_31_60_percent3,(SALT311.StrType)le.debt_61_90_percent3,(SALT311.StrType)le.debt_91_plus_percent3,(SALT311.StrType)le.highest_credit_median,(SALT311.StrType)le.orig_account_balance_regular_tradelines,(SALT311.StrType)le.orig_account_balance_new,(SALT311.StrType)le.orig_account_balance_combined,(SALT311.StrType)le.aged_trades_count,(SALT311.StrType)le.account_balance_regular_tradelines,(SALT311.StrType)le.account_balance_new,(SALT311.StrType)le.account_balance_combined,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,55,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_2015_Layout_EBR) prevDS = DATASET([], Base_2015_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:invalid_mandatory:LENGTHS'
          ,'proxid:invalid_mandatory:LENGTHS'
          ,'seleid:invalid_mandatory:LENGTHS'
          ,'orgid:invalid_mandatory:LENGTHS'
          ,'ultid:invalid_mandatory:LENGTHS'
          ,'bdid:invalid_numeric:CUSTOM'
          ,'date_first_seen:invalid_dt_first_seen:CUSTOM'
          ,'date_last_seen:invalid_pastdate:CUSTOM'
          ,'process_date_first_seen:invalid_pastdate:CUSTOM'
          ,'process_date_last_seen:invalid_pastdate:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'process_date:invalid_pastdate:CUSTOM'
          ,'file_number:invalid_file_number:ALLOW','file_number:invalid_file_number:LENGTHS'
          ,'segment_code:invalid_segment:ENUM'
          ,'trade_count1:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt1:invalid_numeric_or_allzeros:CUSTOM'
          ,'high_credit_mask1:invalid_mask:ENUM'
          ,'recent_high_credit1:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_mask1:invalid_mask:ENUM'
          ,'masked_account_balance1:invalid_numeric_or_allzeros:CUSTOM'
          ,'current_balance_percent1:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_01_30_percent1:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_31_60_percent1:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_61_90_percent1:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_91_plus_percent1:invalid_numeric_or_allzeros:CUSTOM'
          ,'trade_count2:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt2:invalid_numeric_or_allzeros:CUSTOM'
          ,'high_credit_mask2:invalid_mask:ENUM'
          ,'recent_high_credit2:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_mask2:invalid_mask:ENUM'
          ,'masked_account_balance2:invalid_numeric_or_allzeros:CUSTOM'
          ,'current_balance_percent2:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_01_30_percent2:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_31_60_percent2:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_61_90_percent2:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_91_plus_percent2:invalid_numeric_or_allzeros:CUSTOM'
          ,'trade_count3:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt3:invalid_numeric_or_allzeros:CUSTOM'
          ,'high_credit_mask3:invalid_mask:ENUM'
          ,'recent_high_credit3:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_mask3:invalid_mask:ENUM'
          ,'masked_account_balance3:invalid_numeric_or_allzeros:CUSTOM'
          ,'current_balance_percent3:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_01_30_percent3:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_31_60_percent3:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_61_90_percent3:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_91_plus_percent3:invalid_numeric_or_allzeros:CUSTOM'
          ,'highest_credit_median:invalid_numeric_or_allzeros:CUSTOM'
          ,'orig_account_balance_regular_tradelines:invalid_account_balance:CUSTOM'
          ,'orig_account_balance_new:invalid_account_balance:CUSTOM'
          ,'orig_account_balance_combined:invalid_account_balance:CUSTOM'
          ,'aged_trades_count:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_regular_tradelines:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_new:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_combined:invalid_numeric_or_allzeros:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_2015_Fields.InvalidMessage_powid(1)
          ,Base_2015_Fields.InvalidMessage_proxid(1)
          ,Base_2015_Fields.InvalidMessage_seleid(1)
          ,Base_2015_Fields.InvalidMessage_orgid(1)
          ,Base_2015_Fields.InvalidMessage_ultid(1)
          ,Base_2015_Fields.InvalidMessage_bdid(1)
          ,Base_2015_Fields.InvalidMessage_date_first_seen(1)
          ,Base_2015_Fields.InvalidMessage_date_last_seen(1)
          ,Base_2015_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_2015_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_2015_Fields.InvalidMessage_record_type(1)
          ,Base_2015_Fields.InvalidMessage_process_date(1)
          ,Base_2015_Fields.InvalidMessage_file_number(1),Base_2015_Fields.InvalidMessage_file_number(2)
          ,Base_2015_Fields.InvalidMessage_segment_code(1)
          ,Base_2015_Fields.InvalidMessage_trade_count1(1)
          ,Base_2015_Fields.InvalidMessage_debt1(1)
          ,Base_2015_Fields.InvalidMessage_high_credit_mask1(1)
          ,Base_2015_Fields.InvalidMessage_recent_high_credit1(1)
          ,Base_2015_Fields.InvalidMessage_account_balance_mask1(1)
          ,Base_2015_Fields.InvalidMessage_masked_account_balance1(1)
          ,Base_2015_Fields.InvalidMessage_current_balance_percent1(1)
          ,Base_2015_Fields.InvalidMessage_debt_01_30_percent1(1)
          ,Base_2015_Fields.InvalidMessage_debt_31_60_percent1(1)
          ,Base_2015_Fields.InvalidMessage_debt_61_90_percent1(1)
          ,Base_2015_Fields.InvalidMessage_debt_91_plus_percent1(1)
          ,Base_2015_Fields.InvalidMessage_trade_count2(1)
          ,Base_2015_Fields.InvalidMessage_debt2(1)
          ,Base_2015_Fields.InvalidMessage_high_credit_mask2(1)
          ,Base_2015_Fields.InvalidMessage_recent_high_credit2(1)
          ,Base_2015_Fields.InvalidMessage_account_balance_mask2(1)
          ,Base_2015_Fields.InvalidMessage_masked_account_balance2(1)
          ,Base_2015_Fields.InvalidMessage_current_balance_percent2(1)
          ,Base_2015_Fields.InvalidMessage_debt_01_30_percent2(1)
          ,Base_2015_Fields.InvalidMessage_debt_31_60_percent2(1)
          ,Base_2015_Fields.InvalidMessage_debt_61_90_percent2(1)
          ,Base_2015_Fields.InvalidMessage_debt_91_plus_percent2(1)
          ,Base_2015_Fields.InvalidMessage_trade_count3(1)
          ,Base_2015_Fields.InvalidMessage_debt3(1)
          ,Base_2015_Fields.InvalidMessage_high_credit_mask3(1)
          ,Base_2015_Fields.InvalidMessage_recent_high_credit3(1)
          ,Base_2015_Fields.InvalidMessage_account_balance_mask3(1)
          ,Base_2015_Fields.InvalidMessage_masked_account_balance3(1)
          ,Base_2015_Fields.InvalidMessage_current_balance_percent3(1)
          ,Base_2015_Fields.InvalidMessage_debt_01_30_percent3(1)
          ,Base_2015_Fields.InvalidMessage_debt_31_60_percent3(1)
          ,Base_2015_Fields.InvalidMessage_debt_61_90_percent3(1)
          ,Base_2015_Fields.InvalidMessage_debt_91_plus_percent3(1)
          ,Base_2015_Fields.InvalidMessage_highest_credit_median(1)
          ,Base_2015_Fields.InvalidMessage_orig_account_balance_regular_tradelines(1)
          ,Base_2015_Fields.InvalidMessage_orig_account_balance_new(1)
          ,Base_2015_Fields.InvalidMessage_orig_account_balance_combined(1)
          ,Base_2015_Fields.InvalidMessage_aged_trades_count(1)
          ,Base_2015_Fields.InvalidMessage_account_balance_regular_tradelines(1)
          ,Base_2015_Fields.InvalidMessage_account_balance_new(1)
          ,Base_2015_Fields.InvalidMessage_account_balance_combined(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.segment_code_ENUM_ErrorCount
          ,le.trade_count1_CUSTOM_ErrorCount
          ,le.debt1_CUSTOM_ErrorCount
          ,le.high_credit_mask1_ENUM_ErrorCount
          ,le.recent_high_credit1_CUSTOM_ErrorCount
          ,le.account_balance_mask1_ENUM_ErrorCount
          ,le.masked_account_balance1_CUSTOM_ErrorCount
          ,le.current_balance_percent1_CUSTOM_ErrorCount
          ,le.debt_01_30_percent1_CUSTOM_ErrorCount
          ,le.debt_31_60_percent1_CUSTOM_ErrorCount
          ,le.debt_61_90_percent1_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent1_CUSTOM_ErrorCount
          ,le.trade_count2_CUSTOM_ErrorCount
          ,le.debt2_CUSTOM_ErrorCount
          ,le.high_credit_mask2_ENUM_ErrorCount
          ,le.recent_high_credit2_CUSTOM_ErrorCount
          ,le.account_balance_mask2_ENUM_ErrorCount
          ,le.masked_account_balance2_CUSTOM_ErrorCount
          ,le.current_balance_percent2_CUSTOM_ErrorCount
          ,le.debt_01_30_percent2_CUSTOM_ErrorCount
          ,le.debt_31_60_percent2_CUSTOM_ErrorCount
          ,le.debt_61_90_percent2_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent2_CUSTOM_ErrorCount
          ,le.trade_count3_CUSTOM_ErrorCount
          ,le.debt3_CUSTOM_ErrorCount
          ,le.high_credit_mask3_ENUM_ErrorCount
          ,le.recent_high_credit3_CUSTOM_ErrorCount
          ,le.account_balance_mask3_ENUM_ErrorCount
          ,le.masked_account_balance3_CUSTOM_ErrorCount
          ,le.current_balance_percent3_CUSTOM_ErrorCount
          ,le.debt_01_30_percent3_CUSTOM_ErrorCount
          ,le.debt_31_60_percent3_CUSTOM_ErrorCount
          ,le.debt_61_90_percent3_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent3_CUSTOM_ErrorCount
          ,le.highest_credit_median_CUSTOM_ErrorCount
          ,le.orig_account_balance_regular_tradelines_CUSTOM_ErrorCount
          ,le.orig_account_balance_new_CUSTOM_ErrorCount
          ,le.orig_account_balance_combined_CUSTOM_ErrorCount
          ,le.aged_trades_count_CUSTOM_ErrorCount
          ,le.account_balance_regular_tradelines_CUSTOM_ErrorCount
          ,le.account_balance_new_CUSTOM_ErrorCount
          ,le.account_balance_combined_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.segment_code_ENUM_ErrorCount
          ,le.trade_count1_CUSTOM_ErrorCount
          ,le.debt1_CUSTOM_ErrorCount
          ,le.high_credit_mask1_ENUM_ErrorCount
          ,le.recent_high_credit1_CUSTOM_ErrorCount
          ,le.account_balance_mask1_ENUM_ErrorCount
          ,le.masked_account_balance1_CUSTOM_ErrorCount
          ,le.current_balance_percent1_CUSTOM_ErrorCount
          ,le.debt_01_30_percent1_CUSTOM_ErrorCount
          ,le.debt_31_60_percent1_CUSTOM_ErrorCount
          ,le.debt_61_90_percent1_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent1_CUSTOM_ErrorCount
          ,le.trade_count2_CUSTOM_ErrorCount
          ,le.debt2_CUSTOM_ErrorCount
          ,le.high_credit_mask2_ENUM_ErrorCount
          ,le.recent_high_credit2_CUSTOM_ErrorCount
          ,le.account_balance_mask2_ENUM_ErrorCount
          ,le.masked_account_balance2_CUSTOM_ErrorCount
          ,le.current_balance_percent2_CUSTOM_ErrorCount
          ,le.debt_01_30_percent2_CUSTOM_ErrorCount
          ,le.debt_31_60_percent2_CUSTOM_ErrorCount
          ,le.debt_61_90_percent2_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent2_CUSTOM_ErrorCount
          ,le.trade_count3_CUSTOM_ErrorCount
          ,le.debt3_CUSTOM_ErrorCount
          ,le.high_credit_mask3_ENUM_ErrorCount
          ,le.recent_high_credit3_CUSTOM_ErrorCount
          ,le.account_balance_mask3_ENUM_ErrorCount
          ,le.masked_account_balance3_CUSTOM_ErrorCount
          ,le.current_balance_percent3_CUSTOM_ErrorCount
          ,le.debt_01_30_percent3_CUSTOM_ErrorCount
          ,le.debt_31_60_percent3_CUSTOM_ErrorCount
          ,le.debt_61_90_percent3_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent3_CUSTOM_ErrorCount
          ,le.highest_credit_median_CUSTOM_ErrorCount
          ,le.orig_account_balance_regular_tradelines_CUSTOM_ErrorCount
          ,le.orig_account_balance_new_CUSTOM_ErrorCount
          ,le.orig_account_balance_combined_CUSTOM_ErrorCount
          ,le.aged_trades_count_CUSTOM_ErrorCount
          ,le.account_balance_regular_tradelines_CUSTOM_ErrorCount
          ,le.account_balance_new_CUSTOM_ErrorCount
          ,le.account_balance_combined_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_2015_hygiene(PROJECT(h, Base_2015_Layout_EBR));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date_first_seen:' + getFieldTypeText(h.process_date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date_last_seen:' + getFieldTypeText(h.process_date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_number:' + getFieldTypeText(h.file_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'segment_code:' + getFieldTypeText(h.segment_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trade_count1:' + getFieldTypeText(h.trade_count1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt1:' + getFieldTypeText(h.debt1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_credit_mask1:' + getFieldTypeText(h.high_credit_mask1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_high_credit1:' + getFieldTypeText(h.recent_high_credit1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_mask1:' + getFieldTypeText(h.account_balance_mask1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'masked_account_balance1:' + getFieldTypeText(h.masked_account_balance1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_balance_percent1:' + getFieldTypeText(h.current_balance_percent1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_01_30_percent1:' + getFieldTypeText(h.debt_01_30_percent1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_31_60_percent1:' + getFieldTypeText(h.debt_31_60_percent1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_61_90_percent1:' + getFieldTypeText(h.debt_61_90_percent1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_91_plus_percent1:' + getFieldTypeText(h.debt_91_plus_percent1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trade_count2:' + getFieldTypeText(h.trade_count2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt2:' + getFieldTypeText(h.debt2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_credit_mask2:' + getFieldTypeText(h.high_credit_mask2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_high_credit2:' + getFieldTypeText(h.recent_high_credit2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_mask2:' + getFieldTypeText(h.account_balance_mask2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'masked_account_balance2:' + getFieldTypeText(h.masked_account_balance2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_balance_percent2:' + getFieldTypeText(h.current_balance_percent2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_01_30_percent2:' + getFieldTypeText(h.debt_01_30_percent2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_31_60_percent2:' + getFieldTypeText(h.debt_31_60_percent2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_61_90_percent2:' + getFieldTypeText(h.debt_61_90_percent2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_91_plus_percent2:' + getFieldTypeText(h.debt_91_plus_percent2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trade_count3:' + getFieldTypeText(h.trade_count3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt3:' + getFieldTypeText(h.debt3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_credit_mask3:' + getFieldTypeText(h.high_credit_mask3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_high_credit3:' + getFieldTypeText(h.recent_high_credit3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_mask3:' + getFieldTypeText(h.account_balance_mask3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'masked_account_balance3:' + getFieldTypeText(h.masked_account_balance3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_balance_percent3:' + getFieldTypeText(h.current_balance_percent3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_01_30_percent3:' + getFieldTypeText(h.debt_01_30_percent3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_31_60_percent3:' + getFieldTypeText(h.debt_31_60_percent3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_61_90_percent3:' + getFieldTypeText(h.debt_61_90_percent3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_91_plus_percent3:' + getFieldTypeText(h.debt_91_plus_percent3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'highest_credit_median:' + getFieldTypeText(h.highest_credit_median) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_account_balance_regular_tradelines:' + getFieldTypeText(h.orig_account_balance_regular_tradelines) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_account_balance_new:' + getFieldTypeText(h.orig_account_balance_new) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_account_balance_combined:' + getFieldTypeText(h.orig_account_balance_combined) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aged_trades_count:' + getFieldTypeText(h.aged_trades_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_regular_tradelines:' + getFieldTypeText(h.account_balance_regular_tradelines) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_new:' + getFieldTypeText(h.account_balance_new) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_combined:' + getFieldTypeText(h.account_balance_combined) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_powid_cnt
          ,le.populated_proxid_cnt
          ,le.populated_seleid_cnt
          ,le.populated_orgid_cnt
          ,le.populated_ultid_cnt
          ,le.populated_bdid_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_process_date_first_seen_cnt
          ,le.populated_process_date_last_seen_cnt
          ,le.populated_record_type_cnt
          ,le.populated_process_date_cnt
          ,le.populated_file_number_cnt
          ,le.populated_segment_code_cnt
          ,le.populated_trade_count1_cnt
          ,le.populated_debt1_cnt
          ,le.populated_high_credit_mask1_cnt
          ,le.populated_recent_high_credit1_cnt
          ,le.populated_account_balance_mask1_cnt
          ,le.populated_masked_account_balance1_cnt
          ,le.populated_current_balance_percent1_cnt
          ,le.populated_debt_01_30_percent1_cnt
          ,le.populated_debt_31_60_percent1_cnt
          ,le.populated_debt_61_90_percent1_cnt
          ,le.populated_debt_91_plus_percent1_cnt
          ,le.populated_trade_count2_cnt
          ,le.populated_debt2_cnt
          ,le.populated_high_credit_mask2_cnt
          ,le.populated_recent_high_credit2_cnt
          ,le.populated_account_balance_mask2_cnt
          ,le.populated_masked_account_balance2_cnt
          ,le.populated_current_balance_percent2_cnt
          ,le.populated_debt_01_30_percent2_cnt
          ,le.populated_debt_31_60_percent2_cnt
          ,le.populated_debt_61_90_percent2_cnt
          ,le.populated_debt_91_plus_percent2_cnt
          ,le.populated_trade_count3_cnt
          ,le.populated_debt3_cnt
          ,le.populated_high_credit_mask3_cnt
          ,le.populated_recent_high_credit3_cnt
          ,le.populated_account_balance_mask3_cnt
          ,le.populated_masked_account_balance3_cnt
          ,le.populated_current_balance_percent3_cnt
          ,le.populated_debt_01_30_percent3_cnt
          ,le.populated_debt_31_60_percent3_cnt
          ,le.populated_debt_61_90_percent3_cnt
          ,le.populated_debt_91_plus_percent3_cnt
          ,le.populated_highest_credit_median_cnt
          ,le.populated_orig_account_balance_regular_tradelines_cnt
          ,le.populated_orig_account_balance_new_cnt
          ,le.populated_orig_account_balance_combined_cnt
          ,le.populated_aged_trades_count_cnt
          ,le.populated_account_balance_regular_tradelines_cnt
          ,le.populated_account_balance_new_cnt
          ,le.populated_account_balance_combined_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_powid_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_process_date_first_seen_pcnt
          ,le.populated_process_date_last_seen_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_file_number_pcnt
          ,le.populated_segment_code_pcnt
          ,le.populated_trade_count1_pcnt
          ,le.populated_debt1_pcnt
          ,le.populated_high_credit_mask1_pcnt
          ,le.populated_recent_high_credit1_pcnt
          ,le.populated_account_balance_mask1_pcnt
          ,le.populated_masked_account_balance1_pcnt
          ,le.populated_current_balance_percent1_pcnt
          ,le.populated_debt_01_30_percent1_pcnt
          ,le.populated_debt_31_60_percent1_pcnt
          ,le.populated_debt_61_90_percent1_pcnt
          ,le.populated_debt_91_plus_percent1_pcnt
          ,le.populated_trade_count2_pcnt
          ,le.populated_debt2_pcnt
          ,le.populated_high_credit_mask2_pcnt
          ,le.populated_recent_high_credit2_pcnt
          ,le.populated_account_balance_mask2_pcnt
          ,le.populated_masked_account_balance2_pcnt
          ,le.populated_current_balance_percent2_pcnt
          ,le.populated_debt_01_30_percent2_pcnt
          ,le.populated_debt_31_60_percent2_pcnt
          ,le.populated_debt_61_90_percent2_pcnt
          ,le.populated_debt_91_plus_percent2_pcnt
          ,le.populated_trade_count3_pcnt
          ,le.populated_debt3_pcnt
          ,le.populated_high_credit_mask3_pcnt
          ,le.populated_recent_high_credit3_pcnt
          ,le.populated_account_balance_mask3_pcnt
          ,le.populated_masked_account_balance3_pcnt
          ,le.populated_current_balance_percent3_pcnt
          ,le.populated_debt_01_30_percent3_pcnt
          ,le.populated_debt_31_60_percent3_pcnt
          ,le.populated_debt_61_90_percent3_pcnt
          ,le.populated_debt_91_plus_percent3_pcnt
          ,le.populated_highest_credit_median_pcnt
          ,le.populated_orig_account_balance_regular_tradelines_pcnt
          ,le.populated_orig_account_balance_new_pcnt
          ,le.populated_orig_account_balance_combined_pcnt
          ,le.populated_aged_trades_count_pcnt
          ,le.populated_account_balance_regular_tradelines_pcnt
          ,le.populated_account_balance_new_pcnt
          ,le.populated_account_balance_combined_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,55,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_2015_Delta(prevDS, PROJECT(h, Base_2015_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),55,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_2015_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_2015_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
