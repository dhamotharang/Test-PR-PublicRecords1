IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_1000_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 27;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_1000_Layout_EBR)
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
    UNSIGNED1 current_dbt_Invalid;
    UNSIGNED1 predicted_dbt_Invalid;
    UNSIGNED1 orig_predicted_dbt_date_mmddyy_Invalid;
    UNSIGNED1 average_industry_dbt_Invalid;
    UNSIGNED1 average_all_industries_dbt_Invalid;
    UNSIGNED1 low_balance_Invalid;
    UNSIGNED1 high_balance_Invalid;
    UNSIGNED1 current_account_balance_Invalid;
    UNSIGNED1 high_credit_extended_Invalid;
    UNSIGNED1 median_credit_extended_Invalid;
    UNSIGNED1 payment_performance_Invalid;
    UNSIGNED1 payment_trend_Invalid;
    UNSIGNED1 industry_description_Invalid;
    UNSIGNED1 predicted_dbt_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_1000_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_1000_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_1000_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_1000_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_1000_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_1000_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_1000_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_1000_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_1000_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_1000_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_1000_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_1000_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_1000_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_1000_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_1000_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.current_dbt_Invalid := Base_1000_Fields.InValid_current_dbt((SALT311.StrType)le.current_dbt);
    SELF.predicted_dbt_Invalid := Base_1000_Fields.InValid_predicted_dbt((SALT311.StrType)le.predicted_dbt);
    SELF.orig_predicted_dbt_date_mmddyy_Invalid := Base_1000_Fields.InValid_orig_predicted_dbt_date_mmddyy((SALT311.StrType)le.orig_predicted_dbt_date_mmddyy);
    SELF.average_industry_dbt_Invalid := Base_1000_Fields.InValid_average_industry_dbt((SALT311.StrType)le.average_industry_dbt);
    SELF.average_all_industries_dbt_Invalid := Base_1000_Fields.InValid_average_all_industries_dbt((SALT311.StrType)le.average_all_industries_dbt);
    SELF.low_balance_Invalid := Base_1000_Fields.InValid_low_balance((SALT311.StrType)le.low_balance);
    SELF.high_balance_Invalid := Base_1000_Fields.InValid_high_balance((SALT311.StrType)le.high_balance);
    SELF.current_account_balance_Invalid := Base_1000_Fields.InValid_current_account_balance((SALT311.StrType)le.current_account_balance);
    SELF.high_credit_extended_Invalid := Base_1000_Fields.InValid_high_credit_extended((SALT311.StrType)le.high_credit_extended);
    SELF.median_credit_extended_Invalid := Base_1000_Fields.InValid_median_credit_extended((SALT311.StrType)le.median_credit_extended);
    SELF.payment_performance_Invalid := Base_1000_Fields.InValid_payment_performance((SALT311.StrType)le.payment_performance);
    SELF.payment_trend_Invalid := Base_1000_Fields.InValid_payment_trend((SALT311.StrType)le.payment_trend);
    SELF.industry_description_Invalid := Base_1000_Fields.InValid_industry_description((SALT311.StrType)le.industry_description);
    SELF.predicted_dbt_date_Invalid := Base_1000_Fields.InValid_predicted_dbt_date((SALT311.StrType)le.predicted_dbt_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_1000_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.current_dbt_Invalid << 14 ) + ( le.predicted_dbt_Invalid << 15 ) + ( le.orig_predicted_dbt_date_mmddyy_Invalid << 16 ) + ( le.average_industry_dbt_Invalid << 17 ) + ( le.average_all_industries_dbt_Invalid << 18 ) + ( le.low_balance_Invalid << 19 ) + ( le.high_balance_Invalid << 20 ) + ( le.current_account_balance_Invalid << 21 ) + ( le.high_credit_extended_Invalid << 22 ) + ( le.median_credit_extended_Invalid << 23 ) + ( le.payment_performance_Invalid << 24 ) + ( le.payment_trend_Invalid << 25 ) + ( le.industry_description_Invalid << 26 ) + ( le.predicted_dbt_date_Invalid << 27 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_1000_Layout_EBR);
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
    SELF.current_dbt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.predicted_dbt_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_predicted_dbt_date_mmddyy_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.average_industry_dbt_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.average_all_industries_dbt_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.low_balance_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.high_balance_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.current_account_balance_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.high_credit_extended_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.median_credit_extended_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.payment_performance_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.payment_trend_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.industry_description_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.predicted_dbt_date_Invalid := (le.ScrubsBits1 >> 27) & 1;
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
    current_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.current_dbt_Invalid=1);
    predicted_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.predicted_dbt_Invalid=1);
    orig_predicted_dbt_date_mmddyy_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_predicted_dbt_date_mmddyy_Invalid=1);
    average_industry_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.average_industry_dbt_Invalid=1);
    average_all_industries_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.average_all_industries_dbt_Invalid=1);
    low_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.low_balance_Invalid=1);
    high_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.high_balance_Invalid=1);
    current_account_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.current_account_balance_Invalid=1);
    high_credit_extended_CUSTOM_ErrorCount := COUNT(GROUP,h.high_credit_extended_Invalid=1);
    median_credit_extended_CUSTOM_ErrorCount := COUNT(GROUP,h.median_credit_extended_Invalid=1);
    payment_performance_ENUM_ErrorCount := COUNT(GROUP,h.payment_performance_Invalid=1);
    payment_trend_ENUM_ErrorCount := COUNT(GROUP,h.payment_trend_Invalid=1);
    industry_description_LENGTHS_ErrorCount := COUNT(GROUP,h.industry_description_Invalid=1);
    predicted_dbt_date_CUSTOM_ErrorCount := COUNT(GROUP,h.predicted_dbt_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.current_dbt_Invalid > 0 OR h.predicted_dbt_Invalid > 0 OR h.orig_predicted_dbt_date_mmddyy_Invalid > 0 OR h.average_industry_dbt_Invalid > 0 OR h.average_all_industries_dbt_Invalid > 0 OR h.low_balance_Invalid > 0 OR h.high_balance_Invalid > 0 OR h.current_account_balance_Invalid > 0 OR h.high_credit_extended_Invalid > 0 OR h.median_credit_extended_Invalid > 0 OR h.payment_performance_Invalid > 0 OR h.payment_trend_Invalid > 0 OR h.industry_description_Invalid > 0 OR h.predicted_dbt_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.current_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predicted_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_predicted_dbt_date_mmddyy_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.average_industry_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.average_all_industries_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.low_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_extended_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.median_credit_extended_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.payment_performance_ENUM_ErrorCount > 0, 1, 0) + IF(le.payment_trend_ENUM_ErrorCount > 0, 1, 0) + IF(le.industry_description_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.predicted_dbt_date_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.current_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predicted_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_predicted_dbt_date_mmddyy_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.average_industry_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.average_all_industries_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.low_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.high_credit_extended_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.median_credit_extended_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.payment_performance_ENUM_ErrorCount > 0, 1, 0) + IF(le.payment_trend_ENUM_ErrorCount > 0, 1, 0) + IF(le.industry_description_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.predicted_dbt_date_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.current_dbt_Invalid,le.predicted_dbt_Invalid,le.orig_predicted_dbt_date_mmddyy_Invalid,le.average_industry_dbt_Invalid,le.average_all_industries_dbt_Invalid,le.low_balance_Invalid,le.high_balance_Invalid,le.current_account_balance_Invalid,le.high_credit_extended_Invalid,le.median_credit_extended_Invalid,le.payment_performance_Invalid,le.payment_trend_Invalid,le.industry_description_Invalid,le.predicted_dbt_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_1000_Fields.InvalidMessage_powid(le.powid_Invalid),Base_1000_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_1000_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_1000_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_1000_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_1000_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_1000_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_1000_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_1000_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_1000_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_1000_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_1000_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_1000_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_1000_Fields.InvalidMessage_current_dbt(le.current_dbt_Invalid),Base_1000_Fields.InvalidMessage_predicted_dbt(le.predicted_dbt_Invalid),Base_1000_Fields.InvalidMessage_orig_predicted_dbt_date_mmddyy(le.orig_predicted_dbt_date_mmddyy_Invalid),Base_1000_Fields.InvalidMessage_average_industry_dbt(le.average_industry_dbt_Invalid),Base_1000_Fields.InvalidMessage_average_all_industries_dbt(le.average_all_industries_dbt_Invalid),Base_1000_Fields.InvalidMessage_low_balance(le.low_balance_Invalid),Base_1000_Fields.InvalidMessage_high_balance(le.high_balance_Invalid),Base_1000_Fields.InvalidMessage_current_account_balance(le.current_account_balance_Invalid),Base_1000_Fields.InvalidMessage_high_credit_extended(le.high_credit_extended_Invalid),Base_1000_Fields.InvalidMessage_median_credit_extended(le.median_credit_extended_Invalid),Base_1000_Fields.InvalidMessage_payment_performance(le.payment_performance_Invalid),Base_1000_Fields.InvalidMessage_payment_trend(le.payment_trend_Invalid),Base_1000_Fields.InvalidMessage_industry_description(le.industry_description_Invalid),Base_1000_Fields.InvalidMessage_predicted_dbt_date(le.predicted_dbt_date_Invalid),'UNKNOWN'));
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
          ,CHOOSE(le.current_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predicted_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_predicted_dbt_date_mmddyy_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.average_industry_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.average_all_industries_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.low_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.high_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_account_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.high_credit_extended_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.median_credit_extended_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.payment_performance_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.payment_trend_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.industry_description_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.predicted_dbt_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','current_dbt','predicted_dbt','orig_predicted_dbt_date_mmddyy','average_industry_dbt','average_all_industries_dbt','low_balance','high_balance','current_account_balance','high_credit_extended','median_credit_extended','payment_performance','payment_trend','industry_description','predicted_dbt_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_numeric','invalid_numeric','invalid_mmddyy_Date','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_payment_performance','invalid_payment_trend','invalid_mandatory','invalid_generaldate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.current_dbt,(SALT311.StrType)le.predicted_dbt,(SALT311.StrType)le.orig_predicted_dbt_date_mmddyy,(SALT311.StrType)le.average_industry_dbt,(SALT311.StrType)le.average_all_industries_dbt,(SALT311.StrType)le.low_balance,(SALT311.StrType)le.high_balance,(SALT311.StrType)le.current_account_balance,(SALT311.StrType)le.high_credit_extended,(SALT311.StrType)le.median_credit_extended,(SALT311.StrType)le.payment_performance,(SALT311.StrType)le.payment_trend,(SALT311.StrType)le.industry_description,(SALT311.StrType)le.predicted_dbt_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,27,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_1000_Layout_EBR) prevDS = DATASET([], Base_1000_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
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
          ,'current_dbt:invalid_numeric:CUSTOM'
          ,'predicted_dbt:invalid_numeric:CUSTOM'
          ,'orig_predicted_dbt_date_mmddyy:invalid_mmddyy_Date:CUSTOM'
          ,'average_industry_dbt:invalid_numeric:CUSTOM'
          ,'average_all_industries_dbt:invalid_numeric:CUSTOM'
          ,'low_balance:invalid_numeric:CUSTOM'
          ,'high_balance:invalid_numeric:CUSTOM'
          ,'current_account_balance:invalid_numeric:CUSTOM'
          ,'high_credit_extended:invalid_numeric:CUSTOM'
          ,'median_credit_extended:invalid_numeric:CUSTOM'
          ,'payment_performance:invalid_payment_performance:ENUM'
          ,'payment_trend:invalid_payment_trend:ENUM'
          ,'industry_description:invalid_mandatory:LENGTHS'
          ,'predicted_dbt_date:invalid_generaldate:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_1000_Fields.InvalidMessage_powid(1)
          ,Base_1000_Fields.InvalidMessage_proxid(1)
          ,Base_1000_Fields.InvalidMessage_seleid(1)
          ,Base_1000_Fields.InvalidMessage_orgid(1)
          ,Base_1000_Fields.InvalidMessage_ultid(1)
          ,Base_1000_Fields.InvalidMessage_bdid(1)
          ,Base_1000_Fields.InvalidMessage_date_first_seen(1)
          ,Base_1000_Fields.InvalidMessage_date_last_seen(1)
          ,Base_1000_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_1000_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_1000_Fields.InvalidMessage_record_type(1)
          ,Base_1000_Fields.InvalidMessage_process_date(1)
          ,Base_1000_Fields.InvalidMessage_file_number(1),Base_1000_Fields.InvalidMessage_file_number(2)
          ,Base_1000_Fields.InvalidMessage_current_dbt(1)
          ,Base_1000_Fields.InvalidMessage_predicted_dbt(1)
          ,Base_1000_Fields.InvalidMessage_orig_predicted_dbt_date_mmddyy(1)
          ,Base_1000_Fields.InvalidMessage_average_industry_dbt(1)
          ,Base_1000_Fields.InvalidMessage_average_all_industries_dbt(1)
          ,Base_1000_Fields.InvalidMessage_low_balance(1)
          ,Base_1000_Fields.InvalidMessage_high_balance(1)
          ,Base_1000_Fields.InvalidMessage_current_account_balance(1)
          ,Base_1000_Fields.InvalidMessage_high_credit_extended(1)
          ,Base_1000_Fields.InvalidMessage_median_credit_extended(1)
          ,Base_1000_Fields.InvalidMessage_payment_performance(1)
          ,Base_1000_Fields.InvalidMessage_payment_trend(1)
          ,Base_1000_Fields.InvalidMessage_industry_description(1)
          ,Base_1000_Fields.InvalidMessage_predicted_dbt_date(1)
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
          ,le.current_dbt_CUSTOM_ErrorCount
          ,le.predicted_dbt_CUSTOM_ErrorCount
          ,le.orig_predicted_dbt_date_mmddyy_CUSTOM_ErrorCount
          ,le.average_industry_dbt_CUSTOM_ErrorCount
          ,le.average_all_industries_dbt_CUSTOM_ErrorCount
          ,le.low_balance_CUSTOM_ErrorCount
          ,le.high_balance_CUSTOM_ErrorCount
          ,le.current_account_balance_CUSTOM_ErrorCount
          ,le.high_credit_extended_CUSTOM_ErrorCount
          ,le.median_credit_extended_CUSTOM_ErrorCount
          ,le.payment_performance_ENUM_ErrorCount
          ,le.payment_trend_ENUM_ErrorCount
          ,le.industry_description_LENGTHS_ErrorCount
          ,le.predicted_dbt_date_CUSTOM_ErrorCount
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
          ,le.current_dbt_CUSTOM_ErrorCount
          ,le.predicted_dbt_CUSTOM_ErrorCount
          ,le.orig_predicted_dbt_date_mmddyy_CUSTOM_ErrorCount
          ,le.average_industry_dbt_CUSTOM_ErrorCount
          ,le.average_all_industries_dbt_CUSTOM_ErrorCount
          ,le.low_balance_CUSTOM_ErrorCount
          ,le.high_balance_CUSTOM_ErrorCount
          ,le.current_account_balance_CUSTOM_ErrorCount
          ,le.high_credit_extended_CUSTOM_ErrorCount
          ,le.median_credit_extended_CUSTOM_ErrorCount
          ,le.payment_performance_ENUM_ErrorCount
          ,le.payment_trend_ENUM_ErrorCount
          ,le.industry_description_LENGTHS_ErrorCount
          ,le.predicted_dbt_date_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_1000_hygiene(PROJECT(h, Base_1000_Layout_EBR));
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
          ,'current_dbt:' + getFieldTypeText(h.current_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predicted_dbt:' + getFieldTypeText(h.predicted_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_predicted_dbt_date_mmddyy:' + getFieldTypeText(h.orig_predicted_dbt_date_mmddyy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'average_industry_dbt:' + getFieldTypeText(h.average_industry_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'average_all_industries_dbt:' + getFieldTypeText(h.average_all_industries_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'low_balance:' + getFieldTypeText(h.low_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_balance:' + getFieldTypeText(h.high_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_account_balance:' + getFieldTypeText(h.current_account_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_credit_extended:' + getFieldTypeText(h.high_credit_extended) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'median_credit_extended:' + getFieldTypeText(h.median_credit_extended) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'payment_performance:' + getFieldTypeText(h.payment_performance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'payment_trend:' + getFieldTypeText(h.payment_trend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry_description:' + getFieldTypeText(h.industry_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predicted_dbt_date:' + getFieldTypeText(h.predicted_dbt_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
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
          ,le.populated_current_dbt_cnt
          ,le.populated_predicted_dbt_cnt
          ,le.populated_orig_predicted_dbt_date_mmddyy_cnt
          ,le.populated_average_industry_dbt_cnt
          ,le.populated_average_all_industries_dbt_cnt
          ,le.populated_low_balance_cnt
          ,le.populated_high_balance_cnt
          ,le.populated_current_account_balance_cnt
          ,le.populated_high_credit_extended_cnt
          ,le.populated_median_credit_extended_cnt
          ,le.populated_payment_performance_cnt
          ,le.populated_payment_trend_cnt
          ,le.populated_industry_description_cnt
          ,le.populated_predicted_dbt_date_cnt,0);
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
          ,le.populated_current_dbt_pcnt
          ,le.populated_predicted_dbt_pcnt
          ,le.populated_orig_predicted_dbt_date_mmddyy_pcnt
          ,le.populated_average_industry_dbt_pcnt
          ,le.populated_average_all_industries_dbt_pcnt
          ,le.populated_low_balance_pcnt
          ,le.populated_high_balance_pcnt
          ,le.populated_current_account_balance_pcnt
          ,le.populated_high_credit_extended_pcnt
          ,le.populated_median_credit_extended_pcnt
          ,le.populated_payment_performance_pcnt
          ,le.populated_payment_trend_pcnt
          ,le.populated_industry_description_pcnt
          ,le.populated_predicted_dbt_date_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,27,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_1000_Delta(prevDS, PROJECT(h, Base_1000_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),27,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_1000_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_1000_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
