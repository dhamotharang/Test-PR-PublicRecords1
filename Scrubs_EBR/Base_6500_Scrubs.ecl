IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_6500_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 34;
  EXPORT NumRulesFromFieldType := 34;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 33;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_6500_Layout_EBR)
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
    UNSIGNED1 sequence_number_Invalid;
    UNSIGNED1 bus_cat_code_Invalid;
    UNSIGNED1 bus_cat_desc_Invalid;
    UNSIGNED1 orig_date_reported_ymd_Invalid;
    UNSIGNED1 orig_date_last_sale_ym_Invalid;
    UNSIGNED1 payment_terms_Invalid;
    UNSIGNED1 high_credit_mask_Invalid;
    UNSIGNED1 recent_high_credit_Invalid;
    UNSIGNED1 acct_bal_mask_Invalid;
    UNSIGNED1 masked_acct_bal_Invalid;
    UNSIGNED1 current_pct_Invalid;
    UNSIGNED1 dbt_01_30_pct_Invalid;
    UNSIGNED1 dbt_31_60_pct_Invalid;
    UNSIGNED1 dbt_61_90_pct_Invalid;
    UNSIGNED1 dbt_91_plus_pct_Invalid;
    UNSIGNED1 comment_code_Invalid;
    UNSIGNED1 comment_desc_Invalid;
    UNSIGNED1 date_reported_Invalid;
    UNSIGNED1 date_last_sale_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_6500_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_6500_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_6500_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_6500_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_6500_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_6500_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_6500_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_6500_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_6500_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_6500_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_6500_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_6500_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_6500_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_6500_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_6500_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.segment_code_Invalid := Base_6500_Fields.InValid_segment_code((SALT311.StrType)le.segment_code);
    SELF.sequence_number_Invalid := Base_6500_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number);
    SELF.bus_cat_code_Invalid := Base_6500_Fields.InValid_bus_cat_code((SALT311.StrType)le.bus_cat_code);
    SELF.bus_cat_desc_Invalid := Base_6500_Fields.InValid_bus_cat_desc((SALT311.StrType)le.bus_cat_desc);
    SELF.orig_date_reported_ymd_Invalid := Base_6500_Fields.InValid_orig_date_reported_ymd((SALT311.StrType)le.orig_date_reported_ymd);
    SELF.orig_date_last_sale_ym_Invalid := Base_6500_Fields.InValid_orig_date_last_sale_ym((SALT311.StrType)le.orig_date_last_sale_ym);
    SELF.payment_terms_Invalid := Base_6500_Fields.InValid_payment_terms((SALT311.StrType)le.payment_terms);
    SELF.high_credit_mask_Invalid := Base_6500_Fields.InValid_high_credit_mask((SALT311.StrType)le.high_credit_mask);
    SELF.recent_high_credit_Invalid := Base_6500_Fields.InValid_recent_high_credit((SALT311.StrType)le.recent_high_credit);
    SELF.acct_bal_mask_Invalid := Base_6500_Fields.InValid_acct_bal_mask((SALT311.StrType)le.acct_bal_mask);
    SELF.masked_acct_bal_Invalid := Base_6500_Fields.InValid_masked_acct_bal((SALT311.StrType)le.masked_acct_bal);
    SELF.current_pct_Invalid := Base_6500_Fields.InValid_current_pct((SALT311.StrType)le.current_pct);
    SELF.dbt_01_30_pct_Invalid := Base_6500_Fields.InValid_dbt_01_30_pct((SALT311.StrType)le.dbt_01_30_pct);
    SELF.dbt_31_60_pct_Invalid := Base_6500_Fields.InValid_dbt_31_60_pct((SALT311.StrType)le.dbt_31_60_pct);
    SELF.dbt_61_90_pct_Invalid := Base_6500_Fields.InValid_dbt_61_90_pct((SALT311.StrType)le.dbt_61_90_pct);
    SELF.dbt_91_plus_pct_Invalid := Base_6500_Fields.InValid_dbt_91_plus_pct((SALT311.StrType)le.dbt_91_plus_pct);
    SELF.comment_code_Invalid := Base_6500_Fields.InValid_comment_code((SALT311.StrType)le.comment_code);
    SELF.comment_desc_Invalid := Base_6500_Fields.InValid_comment_desc((SALT311.StrType)le.comment_desc);
    SELF.date_reported_Invalid := Base_6500_Fields.InValid_date_reported((SALT311.StrType)le.date_reported);
    SELF.date_last_sale_Invalid := Base_6500_Fields.InValid_date_last_sale((SALT311.StrType)le.date_last_sale);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_6500_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.segment_code_Invalid << 14 ) + ( le.sequence_number_Invalid << 15 ) + ( le.bus_cat_code_Invalid << 16 ) + ( le.bus_cat_desc_Invalid << 17 ) + ( le.orig_date_reported_ymd_Invalid << 18 ) + ( le.orig_date_last_sale_ym_Invalid << 19 ) + ( le.payment_terms_Invalid << 20 ) + ( le.high_credit_mask_Invalid << 21 ) + ( le.recent_high_credit_Invalid << 22 ) + ( le.acct_bal_mask_Invalid << 23 ) + ( le.masked_acct_bal_Invalid << 24 ) + ( le.current_pct_Invalid << 25 ) + ( le.dbt_01_30_pct_Invalid << 26 ) + ( le.dbt_31_60_pct_Invalid << 27 ) + ( le.dbt_61_90_pct_Invalid << 28 ) + ( le.dbt_91_plus_pct_Invalid << 29 ) + ( le.comment_code_Invalid << 30 ) + ( le.comment_desc_Invalid << 31 ) + ( le.date_reported_Invalid << 32 ) + ( le.date_last_sale_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_6500_Layout_EBR);
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
    SELF.sequence_number_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.bus_cat_code_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.bus_cat_desc_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.orig_date_reported_ymd_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_date_last_sale_ym_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.payment_terms_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.high_credit_mask_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.recent_high_credit_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.acct_bal_mask_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.masked_acct_bal_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.current_pct_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dbt_01_30_pct_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.dbt_31_60_pct_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.dbt_61_90_pct_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.dbt_91_plus_pct_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.comment_code_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.comment_desc_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.date_reported_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.date_last_sale_Invalid := (le.ScrubsBits1 >> 33) & 1;
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
    sequence_number_CUSTOM_ErrorCount := COUNT(GROUP,h.sequence_number_Invalid=1);
    bus_cat_code_ENUM_ErrorCount := COUNT(GROUP,h.bus_cat_code_Invalid=1);
    bus_cat_desc_ENUM_ErrorCount := COUNT(GROUP,h.bus_cat_desc_Invalid=1);
    orig_date_reported_ymd_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_date_reported_ymd_Invalid=1);
    orig_date_last_sale_ym_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_date_last_sale_ym_Invalid=1);
    payment_terms_ENUM_ErrorCount := COUNT(GROUP,h.payment_terms_Invalid=1);
    high_credit_mask_ENUM_ErrorCount := COUNT(GROUP,h.high_credit_mask_Invalid=1);
    recent_high_credit_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_high_credit_Invalid=1);
    acct_bal_mask_ENUM_ErrorCount := COUNT(GROUP,h.acct_bal_mask_Invalid=1);
    masked_acct_bal_CUSTOM_ErrorCount := COUNT(GROUP,h.masked_acct_bal_Invalid=1);
    current_pct_CUSTOM_ErrorCount := COUNT(GROUP,h.current_pct_Invalid=1);
    dbt_01_30_pct_CUSTOM_ErrorCount := COUNT(GROUP,h.dbt_01_30_pct_Invalid=1);
    dbt_31_60_pct_CUSTOM_ErrorCount := COUNT(GROUP,h.dbt_31_60_pct_Invalid=1);
    dbt_61_90_pct_CUSTOM_ErrorCount := COUNT(GROUP,h.dbt_61_90_pct_Invalid=1);
    dbt_91_plus_pct_CUSTOM_ErrorCount := COUNT(GROUP,h.dbt_91_plus_pct_Invalid=1);
    comment_code_ENUM_ErrorCount := COUNT(GROUP,h.comment_code_Invalid=1);
    comment_desc_ENUM_ErrorCount := COUNT(GROUP,h.comment_desc_Invalid=1);
    date_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_reported_Invalid=1);
    date_last_sale_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_sale_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.segment_code_Invalid > 0 OR h.sequence_number_Invalid > 0 OR h.bus_cat_code_Invalid > 0 OR h.bus_cat_desc_Invalid > 0 OR h.orig_date_reported_ymd_Invalid > 0 OR h.orig_date_last_sale_ym_Invalid > 0 OR h.payment_terms_Invalid > 0 OR h.high_credit_mask_Invalid > 0 OR h.recent_high_credit_Invalid > 0 OR h.acct_bal_mask_Invalid > 0 OR h.masked_acct_bal_Invalid > 0 OR h.current_pct_Invalid > 0 OR h.dbt_01_30_pct_Invalid > 0 OR h.dbt_31_60_pct_Invalid > 0 OR h.dbt_61_90_pct_Invalid > 0 OR h.dbt_91_plus_pct_Invalid > 0 OR h.comment_code_Invalid > 0 OR h.comment_desc_Invalid > 0 OR h.date_reported_Invalid > 0 OR h.date_last_sale_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_cat_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.bus_cat_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_date_reported_ymd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_date_last_sale_ym_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.payment_terms_ENUM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.acct_bal_mask_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_acct_bal_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_01_30_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_31_60_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_61_90_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_91_plus_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.comment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.comment_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_sale_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bus_cat_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.bus_cat_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_date_reported_ymd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_date_last_sale_ym_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.payment_terms_ENUM_ErrorCount > 0, 1, 0) + IF(le.high_credit_mask_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.acct_bal_mask_ENUM_ErrorCount > 0, 1, 0) + IF(le.masked_acct_bal_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_01_30_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_31_60_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_61_90_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_91_plus_pct_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.comment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.comment_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_sale_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.segment_code_Invalid,le.sequence_number_Invalid,le.bus_cat_code_Invalid,le.bus_cat_desc_Invalid,le.orig_date_reported_ymd_Invalid,le.orig_date_last_sale_ym_Invalid,le.payment_terms_Invalid,le.high_credit_mask_Invalid,le.recent_high_credit_Invalid,le.acct_bal_mask_Invalid,le.masked_acct_bal_Invalid,le.current_pct_Invalid,le.dbt_01_30_pct_Invalid,le.dbt_31_60_pct_Invalid,le.dbt_61_90_pct_Invalid,le.dbt_91_plus_pct_Invalid,le.comment_code_Invalid,le.comment_desc_Invalid,le.date_reported_Invalid,le.date_last_sale_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_6500_Fields.InvalidMessage_powid(le.powid_Invalid),Base_6500_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_6500_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_6500_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_6500_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_6500_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_6500_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_6500_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_6500_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_6500_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_6500_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_6500_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_6500_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_6500_Fields.InvalidMessage_segment_code(le.segment_code_Invalid),Base_6500_Fields.InvalidMessage_sequence_number(le.sequence_number_Invalid),Base_6500_Fields.InvalidMessage_bus_cat_code(le.bus_cat_code_Invalid),Base_6500_Fields.InvalidMessage_bus_cat_desc(le.bus_cat_desc_Invalid),Base_6500_Fields.InvalidMessage_orig_date_reported_ymd(le.orig_date_reported_ymd_Invalid),Base_6500_Fields.InvalidMessage_orig_date_last_sale_ym(le.orig_date_last_sale_ym_Invalid),Base_6500_Fields.InvalidMessage_payment_terms(le.payment_terms_Invalid),Base_6500_Fields.InvalidMessage_high_credit_mask(le.high_credit_mask_Invalid),Base_6500_Fields.InvalidMessage_recent_high_credit(le.recent_high_credit_Invalid),Base_6500_Fields.InvalidMessage_acct_bal_mask(le.acct_bal_mask_Invalid),Base_6500_Fields.InvalidMessage_masked_acct_bal(le.masked_acct_bal_Invalid),Base_6500_Fields.InvalidMessage_current_pct(le.current_pct_Invalid),Base_6500_Fields.InvalidMessage_dbt_01_30_pct(le.dbt_01_30_pct_Invalid),Base_6500_Fields.InvalidMessage_dbt_31_60_pct(le.dbt_31_60_pct_Invalid),Base_6500_Fields.InvalidMessage_dbt_61_90_pct(le.dbt_61_90_pct_Invalid),Base_6500_Fields.InvalidMessage_dbt_91_plus_pct(le.dbt_91_plus_pct_Invalid),Base_6500_Fields.InvalidMessage_comment_code(le.comment_code_Invalid),Base_6500_Fields.InvalidMessage_comment_desc(le.comment_desc_Invalid),Base_6500_Fields.InvalidMessage_date_reported(le.date_reported_Invalid),Base_6500_Fields.InvalidMessage_date_last_sale(le.date_last_sale_Invalid),'UNKNOWN'));
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
          ,CHOOSE(le.sequence_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bus_cat_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.bus_cat_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_date_reported_ymd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_date_last_sale_ym_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.payment_terms_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.high_credit_mask_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recent_high_credit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.acct_bal_mask_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.masked_acct_bal_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_pct_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbt_01_30_pct_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbt_31_60_pct_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbt_61_90_pct_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbt_91_plus_pct_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.comment_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.comment_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_sale_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','bus_cat_code','bus_cat_desc','orig_date_reported_ymd','orig_date_last_sale_ym','payment_terms','high_credit_mask','recent_high_credit','acct_bal_mask','masked_acct_bal','current_pct','dbt_01_30_pct','dbt_31_60_pct','dbt_61_90_pct','dbt_91_plus_pct','comment_code','comment_desc','date_reported','date_last_sale','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_cat_code','invalid_cat_desc','invalid_dt_mmddyy','invalid_dt_yymm','invalid_terms','invalid_mask','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_comment_code','invalid_comment_desc','invalid_pastdate','invalid_dt_ccyymm','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.segment_code,(SALT311.StrType)le.sequence_number,(SALT311.StrType)le.bus_cat_code,(SALT311.StrType)le.bus_cat_desc,(SALT311.StrType)le.orig_date_reported_ymd,(SALT311.StrType)le.orig_date_last_sale_ym,(SALT311.StrType)le.payment_terms,(SALT311.StrType)le.high_credit_mask,(SALT311.StrType)le.recent_high_credit,(SALT311.StrType)le.acct_bal_mask,(SALT311.StrType)le.masked_acct_bal,(SALT311.StrType)le.current_pct,(SALT311.StrType)le.dbt_01_30_pct,(SALT311.StrType)le.dbt_31_60_pct,(SALT311.StrType)le.dbt_61_90_pct,(SALT311.StrType)le.dbt_91_plus_pct,(SALT311.StrType)le.comment_code,(SALT311.StrType)le.comment_desc,(SALT311.StrType)le.date_reported,(SALT311.StrType)le.date_last_sale,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,33,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_6500_Layout_EBR) prevDS = DATASET([], Base_6500_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
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
          ,'sequence_number:invalid_numeric_or_allzeros:CUSTOM'
          ,'bus_cat_code:invalid_cat_code:ENUM'
          ,'bus_cat_desc:invalid_cat_desc:ENUM'
          ,'orig_date_reported_ymd:invalid_dt_mmddyy:CUSTOM'
          ,'orig_date_last_sale_ym:invalid_dt_yymm:CUSTOM'
          ,'payment_terms:invalid_terms:ENUM'
          ,'high_credit_mask:invalid_mask:ENUM'
          ,'recent_high_credit:invalid_numeric_or_allzeros:CUSTOM'
          ,'acct_bal_mask:invalid_mask:ENUM'
          ,'masked_acct_bal:invalid_numeric_or_allzeros:CUSTOM'
          ,'current_pct:invalid_numeric_or_allzeros:CUSTOM'
          ,'dbt_01_30_pct:invalid_numeric_or_allzeros:CUSTOM'
          ,'dbt_31_60_pct:invalid_numeric_or_allzeros:CUSTOM'
          ,'dbt_61_90_pct:invalid_numeric_or_allzeros:CUSTOM'
          ,'dbt_91_plus_pct:invalid_numeric_or_allzeros:CUSTOM'
          ,'comment_code:invalid_comment_code:ENUM'
          ,'comment_desc:invalid_comment_desc:ENUM'
          ,'date_reported:invalid_pastdate:CUSTOM'
          ,'date_last_sale:invalid_dt_ccyymm:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_6500_Fields.InvalidMessage_powid(1)
          ,Base_6500_Fields.InvalidMessage_proxid(1)
          ,Base_6500_Fields.InvalidMessage_seleid(1)
          ,Base_6500_Fields.InvalidMessage_orgid(1)
          ,Base_6500_Fields.InvalidMessage_ultid(1)
          ,Base_6500_Fields.InvalidMessage_bdid(1)
          ,Base_6500_Fields.InvalidMessage_date_first_seen(1)
          ,Base_6500_Fields.InvalidMessage_date_last_seen(1)
          ,Base_6500_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_6500_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_6500_Fields.InvalidMessage_record_type(1)
          ,Base_6500_Fields.InvalidMessage_process_date(1)
          ,Base_6500_Fields.InvalidMessage_file_number(1),Base_6500_Fields.InvalidMessage_file_number(2)
          ,Base_6500_Fields.InvalidMessage_segment_code(1)
          ,Base_6500_Fields.InvalidMessage_sequence_number(1)
          ,Base_6500_Fields.InvalidMessage_bus_cat_code(1)
          ,Base_6500_Fields.InvalidMessage_bus_cat_desc(1)
          ,Base_6500_Fields.InvalidMessage_orig_date_reported_ymd(1)
          ,Base_6500_Fields.InvalidMessage_orig_date_last_sale_ym(1)
          ,Base_6500_Fields.InvalidMessage_payment_terms(1)
          ,Base_6500_Fields.InvalidMessage_high_credit_mask(1)
          ,Base_6500_Fields.InvalidMessage_recent_high_credit(1)
          ,Base_6500_Fields.InvalidMessage_acct_bal_mask(1)
          ,Base_6500_Fields.InvalidMessage_masked_acct_bal(1)
          ,Base_6500_Fields.InvalidMessage_current_pct(1)
          ,Base_6500_Fields.InvalidMessage_dbt_01_30_pct(1)
          ,Base_6500_Fields.InvalidMessage_dbt_31_60_pct(1)
          ,Base_6500_Fields.InvalidMessage_dbt_61_90_pct(1)
          ,Base_6500_Fields.InvalidMessage_dbt_91_plus_pct(1)
          ,Base_6500_Fields.InvalidMessage_comment_code(1)
          ,Base_6500_Fields.InvalidMessage_comment_desc(1)
          ,Base_6500_Fields.InvalidMessage_date_reported(1)
          ,Base_6500_Fields.InvalidMessage_date_last_sale(1)
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
          ,le.sequence_number_CUSTOM_ErrorCount
          ,le.bus_cat_code_ENUM_ErrorCount
          ,le.bus_cat_desc_ENUM_ErrorCount
          ,le.orig_date_reported_ymd_CUSTOM_ErrorCount
          ,le.orig_date_last_sale_ym_CUSTOM_ErrorCount
          ,le.payment_terms_ENUM_ErrorCount
          ,le.high_credit_mask_ENUM_ErrorCount
          ,le.recent_high_credit_CUSTOM_ErrorCount
          ,le.acct_bal_mask_ENUM_ErrorCount
          ,le.masked_acct_bal_CUSTOM_ErrorCount
          ,le.current_pct_CUSTOM_ErrorCount
          ,le.dbt_01_30_pct_CUSTOM_ErrorCount
          ,le.dbt_31_60_pct_CUSTOM_ErrorCount
          ,le.dbt_61_90_pct_CUSTOM_ErrorCount
          ,le.dbt_91_plus_pct_CUSTOM_ErrorCount
          ,le.comment_code_ENUM_ErrorCount
          ,le.comment_desc_ENUM_ErrorCount
          ,le.date_reported_CUSTOM_ErrorCount
          ,le.date_last_sale_CUSTOM_ErrorCount
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
          ,le.sequence_number_CUSTOM_ErrorCount
          ,le.bus_cat_code_ENUM_ErrorCount
          ,le.bus_cat_desc_ENUM_ErrorCount
          ,le.orig_date_reported_ymd_CUSTOM_ErrorCount
          ,le.orig_date_last_sale_ym_CUSTOM_ErrorCount
          ,le.payment_terms_ENUM_ErrorCount
          ,le.high_credit_mask_ENUM_ErrorCount
          ,le.recent_high_credit_CUSTOM_ErrorCount
          ,le.acct_bal_mask_ENUM_ErrorCount
          ,le.masked_acct_bal_CUSTOM_ErrorCount
          ,le.current_pct_CUSTOM_ErrorCount
          ,le.dbt_01_30_pct_CUSTOM_ErrorCount
          ,le.dbt_31_60_pct_CUSTOM_ErrorCount
          ,le.dbt_61_90_pct_CUSTOM_ErrorCount
          ,le.dbt_91_plus_pct_CUSTOM_ErrorCount
          ,le.comment_code_ENUM_ErrorCount
          ,le.comment_desc_ENUM_ErrorCount
          ,le.date_reported_CUSTOM_ErrorCount
          ,le.date_last_sale_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_6500_hygiene(PROJECT(h, Base_6500_Layout_EBR));
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
          ,'sequence_number:' + getFieldTypeText(h.sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bus_cat_code:' + getFieldTypeText(h.bus_cat_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bus_cat_desc:' + getFieldTypeText(h.bus_cat_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_date_reported_ymd:' + getFieldTypeText(h.orig_date_reported_ymd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_date_last_sale_ym:' + getFieldTypeText(h.orig_date_last_sale_ym) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'payment_terms:' + getFieldTypeText(h.payment_terms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_credit_mask:' + getFieldTypeText(h.high_credit_mask) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_high_credit:' + getFieldTypeText(h.recent_high_credit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'acct_bal_mask:' + getFieldTypeText(h.acct_bal_mask) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'masked_acct_bal:' + getFieldTypeText(h.masked_acct_bal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_pct:' + getFieldTypeText(h.current_pct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbt_01_30_pct:' + getFieldTypeText(h.dbt_01_30_pct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbt_31_60_pct:' + getFieldTypeText(h.dbt_31_60_pct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbt_61_90_pct:' + getFieldTypeText(h.dbt_61_90_pct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbt_91_plus_pct:' + getFieldTypeText(h.dbt_91_plus_pct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comment_code:' + getFieldTypeText(h.comment_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comment_desc:' + getFieldTypeText(h.comment_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_reported:' + getFieldTypeText(h.date_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_sale:' + getFieldTypeText(h.date_last_sale) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
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
          ,le.populated_sequence_number_cnt
          ,le.populated_bus_cat_code_cnt
          ,le.populated_bus_cat_desc_cnt
          ,le.populated_orig_date_reported_ymd_cnt
          ,le.populated_orig_date_last_sale_ym_cnt
          ,le.populated_payment_terms_cnt
          ,le.populated_high_credit_mask_cnt
          ,le.populated_recent_high_credit_cnt
          ,le.populated_acct_bal_mask_cnt
          ,le.populated_masked_acct_bal_cnt
          ,le.populated_current_pct_cnt
          ,le.populated_dbt_01_30_pct_cnt
          ,le.populated_dbt_31_60_pct_cnt
          ,le.populated_dbt_61_90_pct_cnt
          ,le.populated_dbt_91_plus_pct_cnt
          ,le.populated_comment_code_cnt
          ,le.populated_comment_desc_cnt
          ,le.populated_date_reported_cnt
          ,le.populated_date_last_sale_cnt,0);
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
          ,le.populated_sequence_number_pcnt
          ,le.populated_bus_cat_code_pcnt
          ,le.populated_bus_cat_desc_pcnt
          ,le.populated_orig_date_reported_ymd_pcnt
          ,le.populated_orig_date_last_sale_ym_pcnt
          ,le.populated_payment_terms_pcnt
          ,le.populated_high_credit_mask_pcnt
          ,le.populated_recent_high_credit_pcnt
          ,le.populated_acct_bal_mask_pcnt
          ,le.populated_masked_acct_bal_pcnt
          ,le.populated_current_pct_pcnt
          ,le.populated_dbt_01_30_pct_pcnt
          ,le.populated_dbt_31_60_pct_pcnt
          ,le.populated_dbt_61_90_pct_pcnt
          ,le.populated_dbt_91_plus_pct_pcnt
          ,le.populated_comment_code_pcnt
          ,le.populated_comment_desc_pcnt
          ,le.populated_date_reported_pcnt
          ,le.populated_date_last_sale_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,33,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_6500_Delta(prevDS, PROJECT(h, Base_6500_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),33,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_6500_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_6500_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
