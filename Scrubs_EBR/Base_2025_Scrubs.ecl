IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_2025_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 25;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_2025_Layout_EBR)
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
    UNSIGNED1 quarter_Invalid;
    UNSIGNED1 quarter_yy_Invalid;
    UNSIGNED1 debt_Invalid;
    UNSIGNED1 account_balance_mask_Invalid;
    UNSIGNED1 account_balance_Invalid;
    UNSIGNED1 current_balance_percent_Invalid;
    UNSIGNED1 debt_01_30_percent_Invalid;
    UNSIGNED1 debt_31_60_percent_Invalid;
    UNSIGNED1 debt_61_90_percent_Invalid;
    UNSIGNED1 debt_91_plus_percent_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_2025_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_2025_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_2025_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_2025_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_2025_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_2025_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_2025_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_2025_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_2025_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_2025_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_2025_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_2025_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_2025_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_2025_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_2025_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.segment_code_Invalid := Base_2025_Fields.InValid_segment_code((SALT311.StrType)le.segment_code);
    SELF.sequence_number_Invalid := Base_2025_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number);
    SELF.quarter_Invalid := Base_2025_Fields.InValid_quarter((SALT311.StrType)le.quarter);
    SELF.quarter_yy_Invalid := Base_2025_Fields.InValid_quarter_yy((SALT311.StrType)le.quarter_yy);
    SELF.debt_Invalid := Base_2025_Fields.InValid_debt((SALT311.StrType)le.debt);
    SELF.account_balance_mask_Invalid := Base_2025_Fields.InValid_account_balance_mask((SALT311.StrType)le.account_balance_mask);
    SELF.account_balance_Invalid := Base_2025_Fields.InValid_account_balance((SALT311.StrType)le.account_balance);
    SELF.current_balance_percent_Invalid := Base_2025_Fields.InValid_current_balance_percent((SALT311.StrType)le.current_balance_percent);
    SELF.debt_01_30_percent_Invalid := Base_2025_Fields.InValid_debt_01_30_percent((SALT311.StrType)le.debt_01_30_percent);
    SELF.debt_31_60_percent_Invalid := Base_2025_Fields.InValid_debt_31_60_percent((SALT311.StrType)le.debt_31_60_percent);
    SELF.debt_61_90_percent_Invalid := Base_2025_Fields.InValid_debt_61_90_percent((SALT311.StrType)le.debt_61_90_percent);
    SELF.debt_91_plus_percent_Invalid := Base_2025_Fields.InValid_debt_91_plus_percent((SALT311.StrType)le.debt_91_plus_percent);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_2025_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.segment_code_Invalid << 14 ) + ( le.sequence_number_Invalid << 15 ) + ( le.quarter_Invalid << 16 ) + ( le.quarter_yy_Invalid << 17 ) + ( le.debt_Invalid << 18 ) + ( le.account_balance_mask_Invalid << 19 ) + ( le.account_balance_Invalid << 20 ) + ( le.current_balance_percent_Invalid << 21 ) + ( le.debt_01_30_percent_Invalid << 22 ) + ( le.debt_31_60_percent_Invalid << 23 ) + ( le.debt_61_90_percent_Invalid << 24 ) + ( le.debt_91_plus_percent_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_2025_Layout_EBR);
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
    SELF.quarter_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.quarter_yy_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.debt_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.account_balance_mask_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.account_balance_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.current_balance_percent_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.debt_01_30_percent_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.debt_31_60_percent_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.debt_61_90_percent_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.debt_91_plus_percent_Invalid := (le.ScrubsBits1 >> 25) & 1;
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
    quarter_ENUM_ErrorCount := COUNT(GROUP,h.quarter_Invalid=1);
    quarter_yy_CUSTOM_ErrorCount := COUNT(GROUP,h.quarter_yy_Invalid=1);
    debt_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_Invalid=1);
    account_balance_mask_ENUM_ErrorCount := COUNT(GROUP,h.account_balance_mask_Invalid=1);
    account_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.account_balance_Invalid=1);
    current_balance_percent_CUSTOM_ErrorCount := COUNT(GROUP,h.current_balance_percent_Invalid=1);
    debt_01_30_percent_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_01_30_percent_Invalid=1);
    debt_31_60_percent_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_31_60_percent_Invalid=1);
    debt_61_90_percent_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_61_90_percent_Invalid=1);
    debt_91_plus_percent_CUSTOM_ErrorCount := COUNT(GROUP,h.debt_91_plus_percent_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.segment_code_Invalid > 0 OR h.sequence_number_Invalid > 0 OR h.quarter_Invalid > 0 OR h.quarter_yy_Invalid > 0 OR h.debt_Invalid > 0 OR h.account_balance_mask_Invalid > 0 OR h.account_balance_Invalid > 0 OR h.current_balance_percent_Invalid > 0 OR h.debt_01_30_percent_Invalid > 0 OR h.debt_31_60_percent_Invalid > 0 OR h.debt_61_90_percent_Invalid > 0 OR h.debt_91_plus_percent_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_ENUM_ErrorCount > 0, 1, 0) + IF(le.quarter_yy_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask_ENUM_ErrorCount > 0, 1, 0) + IF(le.account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_ENUM_ErrorCount > 0, 1, 0) + IF(le.quarter_yy_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_balance_mask_ENUM_ErrorCount > 0, 1, 0) + IF(le.account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_balance_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_01_30_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_31_60_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_61_90_percent_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.debt_91_plus_percent_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.segment_code_Invalid,le.sequence_number_Invalid,le.quarter_Invalid,le.quarter_yy_Invalid,le.debt_Invalid,le.account_balance_mask_Invalid,le.account_balance_Invalid,le.current_balance_percent_Invalid,le.debt_01_30_percent_Invalid,le.debt_31_60_percent_Invalid,le.debt_61_90_percent_Invalid,le.debt_91_plus_percent_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_2025_Fields.InvalidMessage_powid(le.powid_Invalid),Base_2025_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_2025_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_2025_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_2025_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_2025_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_2025_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_2025_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_2025_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_2025_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_2025_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_2025_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_2025_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_2025_Fields.InvalidMessage_segment_code(le.segment_code_Invalid),Base_2025_Fields.InvalidMessage_sequence_number(le.sequence_number_Invalid),Base_2025_Fields.InvalidMessage_quarter(le.quarter_Invalid),Base_2025_Fields.InvalidMessage_quarter_yy(le.quarter_yy_Invalid),Base_2025_Fields.InvalidMessage_debt(le.debt_Invalid),Base_2025_Fields.InvalidMessage_account_balance_mask(le.account_balance_mask_Invalid),Base_2025_Fields.InvalidMessage_account_balance(le.account_balance_Invalid),Base_2025_Fields.InvalidMessage_current_balance_percent(le.current_balance_percent_Invalid),Base_2025_Fields.InvalidMessage_debt_01_30_percent(le.debt_01_30_percent_Invalid),Base_2025_Fields.InvalidMessage_debt_31_60_percent(le.debt_31_60_percent_Invalid),Base_2025_Fields.InvalidMessage_debt_61_90_percent(le.debt_61_90_percent_Invalid),Base_2025_Fields.InvalidMessage_debt_91_plus_percent(le.debt_91_plus_percent_Invalid),'UNKNOWN'));
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
          ,CHOOSE(le.quarter_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.quarter_yy_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_balance_mask_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.account_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_balance_percent_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_01_30_percent_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_31_60_percent_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_61_90_percent_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.debt_91_plus_percent_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','quarter','quarter_yy','debt','account_balance_mask','account_balance','current_balance_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_quarter','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_mask','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','invalid_numeric_or_allzeros','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.segment_code,(SALT311.StrType)le.sequence_number,(SALT311.StrType)le.quarter,(SALT311.StrType)le.quarter_yy,(SALT311.StrType)le.debt,(SALT311.StrType)le.account_balance_mask,(SALT311.StrType)le.account_balance,(SALT311.StrType)le.current_balance_percent,(SALT311.StrType)le.debt_01_30_percent,(SALT311.StrType)le.debt_31_60_percent,(SALT311.StrType)le.debt_61_90_percent,(SALT311.StrType)le.debt_91_plus_percent,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,25,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_2025_Layout_EBR) prevDS = DATASET([], Base_2025_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
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
          ,'quarter:invalid_quarter:ENUM'
          ,'quarter_yy:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt:invalid_numeric_or_allzeros:CUSTOM'
          ,'account_balance_mask:invalid_mask:ENUM'
          ,'account_balance:invalid_numeric_or_allzeros:CUSTOM'
          ,'current_balance_percent:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_01_30_percent:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_31_60_percent:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_61_90_percent:invalid_numeric_or_allzeros:CUSTOM'
          ,'debt_91_plus_percent:invalid_numeric_or_allzeros:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_2025_Fields.InvalidMessage_powid(1)
          ,Base_2025_Fields.InvalidMessage_proxid(1)
          ,Base_2025_Fields.InvalidMessage_seleid(1)
          ,Base_2025_Fields.InvalidMessage_orgid(1)
          ,Base_2025_Fields.InvalidMessage_ultid(1)
          ,Base_2025_Fields.InvalidMessage_bdid(1)
          ,Base_2025_Fields.InvalidMessage_date_first_seen(1)
          ,Base_2025_Fields.InvalidMessage_date_last_seen(1)
          ,Base_2025_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_2025_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_2025_Fields.InvalidMessage_record_type(1)
          ,Base_2025_Fields.InvalidMessage_process_date(1)
          ,Base_2025_Fields.InvalidMessage_file_number(1),Base_2025_Fields.InvalidMessage_file_number(2)
          ,Base_2025_Fields.InvalidMessage_segment_code(1)
          ,Base_2025_Fields.InvalidMessage_sequence_number(1)
          ,Base_2025_Fields.InvalidMessage_quarter(1)
          ,Base_2025_Fields.InvalidMessage_quarter_yy(1)
          ,Base_2025_Fields.InvalidMessage_debt(1)
          ,Base_2025_Fields.InvalidMessage_account_balance_mask(1)
          ,Base_2025_Fields.InvalidMessage_account_balance(1)
          ,Base_2025_Fields.InvalidMessage_current_balance_percent(1)
          ,Base_2025_Fields.InvalidMessage_debt_01_30_percent(1)
          ,Base_2025_Fields.InvalidMessage_debt_31_60_percent(1)
          ,Base_2025_Fields.InvalidMessage_debt_61_90_percent(1)
          ,Base_2025_Fields.InvalidMessage_debt_91_plus_percent(1)
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
          ,le.quarter_ENUM_ErrorCount
          ,le.quarter_yy_CUSTOM_ErrorCount
          ,le.debt_CUSTOM_ErrorCount
          ,le.account_balance_mask_ENUM_ErrorCount
          ,le.account_balance_CUSTOM_ErrorCount
          ,le.current_balance_percent_CUSTOM_ErrorCount
          ,le.debt_01_30_percent_CUSTOM_ErrorCount
          ,le.debt_31_60_percent_CUSTOM_ErrorCount
          ,le.debt_61_90_percent_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent_CUSTOM_ErrorCount
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
          ,le.quarter_ENUM_ErrorCount
          ,le.quarter_yy_CUSTOM_ErrorCount
          ,le.debt_CUSTOM_ErrorCount
          ,le.account_balance_mask_ENUM_ErrorCount
          ,le.account_balance_CUSTOM_ErrorCount
          ,le.current_balance_percent_CUSTOM_ErrorCount
          ,le.debt_01_30_percent_CUSTOM_ErrorCount
          ,le.debt_31_60_percent_CUSTOM_ErrorCount
          ,le.debt_61_90_percent_CUSTOM_ErrorCount
          ,le.debt_91_plus_percent_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_2025_hygiene(PROJECT(h, Base_2025_Layout_EBR));
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
          ,'quarter:' + getFieldTypeText(h.quarter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'quarter_yy:' + getFieldTypeText(h.quarter_yy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt:' + getFieldTypeText(h.debt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance_mask:' + getFieldTypeText(h.account_balance_mask) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_balance:' + getFieldTypeText(h.account_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_balance_percent:' + getFieldTypeText(h.current_balance_percent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_01_30_percent:' + getFieldTypeText(h.debt_01_30_percent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_31_60_percent:' + getFieldTypeText(h.debt_31_60_percent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_61_90_percent:' + getFieldTypeText(h.debt_61_90_percent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'debt_91_plus_percent:' + getFieldTypeText(h.debt_91_plus_percent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
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
          ,le.populated_quarter_cnt
          ,le.populated_quarter_yy_cnt
          ,le.populated_debt_cnt
          ,le.populated_account_balance_mask_cnt
          ,le.populated_account_balance_cnt
          ,le.populated_current_balance_percent_cnt
          ,le.populated_debt_01_30_percent_cnt
          ,le.populated_debt_31_60_percent_cnt
          ,le.populated_debt_61_90_percent_cnt
          ,le.populated_debt_91_plus_percent_cnt,0);
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
          ,le.populated_quarter_pcnt
          ,le.populated_quarter_yy_pcnt
          ,le.populated_debt_pcnt
          ,le.populated_account_balance_mask_pcnt
          ,le.populated_account_balance_pcnt
          ,le.populated_current_balance_percent_pcnt
          ,le.populated_debt_01_30_percent_pcnt
          ,le.populated_debt_31_60_percent_pcnt
          ,le.populated_debt_61_90_percent_pcnt
          ,le.populated_debt_91_plus_percent_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,25,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_2025_Delta(prevDS, PROJECT(h, Base_2025_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),25,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_2025_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_2025_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
