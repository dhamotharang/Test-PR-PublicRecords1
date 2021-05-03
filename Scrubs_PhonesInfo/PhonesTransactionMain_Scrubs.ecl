IMPORT SALT311,STD;
EXPORT PhonesTransactionMain_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 21;
  EXPORT NumRulesFromFieldType := 21;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 21;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(PhonesTransactionMain_Layout_PhonesInfo)
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 transaction_code_Invalid;
    UNSIGNED1 transaction_start_dt_Invalid;
    UNSIGNED1 transaction_start_time_Invalid;
    UNSIGNED1 transaction_end_dt_Invalid;
    UNSIGNED1 transaction_end_time_Invalid;
    UNSIGNED1 transaction_count_Invalid;
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_first_reported_time_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_time_Invalid;
    UNSIGNED1 country_code_Invalid;
    UNSIGNED1 country_abbr_Invalid;
    UNSIGNED1 routing_code_Invalid;
    UNSIGNED1 dial_type_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 ocn_Invalid;
    UNSIGNED1 global_sid_Invalid;
    UNSIGNED1 record_sid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(PhonesTransactionMain_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(PhonesTransactionMain_Layout_PhonesInfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'phone:Invalid_Num:ALLOW'
          ,'source:Invalid_Src:ENUM'
          ,'transaction_code:Invalid_TransCode:ENUM'
          ,'transaction_start_dt:Invalid_Num:ALLOW'
          ,'transaction_start_time:Invalid_Num:ALLOW'
          ,'transaction_end_dt:Invalid_Num:ALLOW'
          ,'transaction_end_time:Invalid_Num:ALLOW'
          ,'transaction_count:Invalid_Num:ALLOW'
          ,'vendor_first_reported_dt:Invalid_Num:ALLOW'
          ,'vendor_first_reported_time:Invalid_Num:ALLOW'
          ,'vendor_last_reported_dt:Invalid_Num:ALLOW'
          ,'vendor_last_reported_time:Invalid_Num:ALLOW'
          ,'country_code:Invalid_CountryCode:ENUM'
          ,'country_abbr:Invalid_CountryAbbr:ENUM'
          ,'routing_code:Invalid_Num:ALLOW'
          ,'dial_type:Invalid_DialTypeCode:ENUM'
          ,'spid:Invalid_AlphaNum:ALLOW'
          ,'phone_swap:Invalid_Num:ALLOW'
          ,'ocn:Invalid_AlphaNum:ALLOW'
          ,'global_sid:Invalid_Num:ALLOW'
          ,'record_sid:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,PhonesTransactionMain_Fields.InvalidMessage_phone(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_source(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_transaction_code(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_transaction_start_dt(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_transaction_start_time(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_transaction_end_dt(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_transaction_end_time(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_transaction_count(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_vendor_first_reported_time(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_vendor_last_reported_time(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_country_code(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_country_abbr(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_routing_code(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_dial_type(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_spid(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_phone_swap(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_ocn(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_global_sid(1)
          ,PhonesTransactionMain_Fields.InvalidMessage_record_sid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(PhonesTransactionMain_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.phone_Invalid := PhonesTransactionMain_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.source_Invalid := PhonesTransactionMain_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.transaction_code_Invalid := PhonesTransactionMain_Fields.InValid_transaction_code((SALT311.StrType)le.transaction_code);
    SELF.transaction_start_dt_Invalid := PhonesTransactionMain_Fields.InValid_transaction_start_dt((SALT311.StrType)le.transaction_start_dt);
    SELF.transaction_start_time_Invalid := PhonesTransactionMain_Fields.InValid_transaction_start_time((SALT311.StrType)le.transaction_start_time);
    SELF.transaction_end_dt_Invalid := PhonesTransactionMain_Fields.InValid_transaction_end_dt((SALT311.StrType)le.transaction_end_dt);
    SELF.transaction_end_time_Invalid := PhonesTransactionMain_Fields.InValid_transaction_end_time((SALT311.StrType)le.transaction_end_time);
    SELF.transaction_count_Invalid := PhonesTransactionMain_Fields.InValid_transaction_count((SALT311.StrType)le.transaction_count);
    SELF.vendor_first_reported_dt_Invalid := PhonesTransactionMain_Fields.InValid_vendor_first_reported_dt((SALT311.StrType)le.vendor_first_reported_dt);
    SELF.vendor_first_reported_time_Invalid := PhonesTransactionMain_Fields.InValid_vendor_first_reported_time((SALT311.StrType)le.vendor_first_reported_time);
    SELF.vendor_last_reported_dt_Invalid := PhonesTransactionMain_Fields.InValid_vendor_last_reported_dt((SALT311.StrType)le.vendor_last_reported_dt);
    SELF.vendor_last_reported_time_Invalid := PhonesTransactionMain_Fields.InValid_vendor_last_reported_time((SALT311.StrType)le.vendor_last_reported_time);
    SELF.country_code_Invalid := PhonesTransactionMain_Fields.InValid_country_code((SALT311.StrType)le.country_code);
    SELF.country_abbr_Invalid := PhonesTransactionMain_Fields.InValid_country_abbr((SALT311.StrType)le.country_abbr);
    SELF.routing_code_Invalid := PhonesTransactionMain_Fields.InValid_routing_code((SALT311.StrType)le.routing_code);
    SELF.dial_type_Invalid := PhonesTransactionMain_Fields.InValid_dial_type((SALT311.StrType)le.dial_type);
    SELF.spid_Invalid := PhonesTransactionMain_Fields.InValid_spid((SALT311.StrType)le.spid);
    SELF.phone_swap_Invalid := PhonesTransactionMain_Fields.InValid_phone_swap((SALT311.StrType)le.phone_swap);
    SELF.ocn_Invalid := PhonesTransactionMain_Fields.InValid_ocn((SALT311.StrType)le.ocn);
    SELF.global_sid_Invalid := PhonesTransactionMain_Fields.InValid_global_sid((SALT311.StrType)le.global_sid);
    SELF.record_sid_Invalid := PhonesTransactionMain_Fields.InValid_record_sid((SALT311.StrType)le.record_sid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),PhonesTransactionMain_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.phone_Invalid << 0 ) + ( le.source_Invalid << 1 ) + ( le.transaction_code_Invalid << 2 ) + ( le.transaction_start_dt_Invalid << 3 ) + ( le.transaction_start_time_Invalid << 4 ) + ( le.transaction_end_dt_Invalid << 5 ) + ( le.transaction_end_time_Invalid << 6 ) + ( le.transaction_count_Invalid << 7 ) + ( le.vendor_first_reported_dt_Invalid << 8 ) + ( le.vendor_first_reported_time_Invalid << 9 ) + ( le.vendor_last_reported_dt_Invalid << 10 ) + ( le.vendor_last_reported_time_Invalid << 11 ) + ( le.country_code_Invalid << 12 ) + ( le.country_abbr_Invalid << 13 ) + ( le.routing_code_Invalid << 14 ) + ( le.dial_type_Invalid << 15 ) + ( le.spid_Invalid << 16 ) + ( le.phone_swap_Invalid << 17 ) + ( le.ocn_Invalid << 18 ) + ( le.global_sid_Invalid << 19 ) + ( le.record_sid_Invalid << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,PhonesTransactionMain_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.phone_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.transaction_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.transaction_start_dt_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.transaction_start_time_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.transaction_end_dt_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.transaction_end_time_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.transaction_count_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.vendor_first_reported_time_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.vendor_last_reported_time_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.country_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.country_abbr_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.routing_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.dial_type_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ocn_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.global_sid_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.record_sid_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    source_ENUM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    transaction_code_ENUM_ErrorCount := COUNT(GROUP,h.transaction_code_Invalid=1);
    transaction_start_dt_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_start_dt_Invalid=1);
    transaction_start_time_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_start_time_Invalid=1);
    transaction_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_end_dt_Invalid=1);
    transaction_end_time_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_end_time_Invalid=1);
    transaction_count_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_count_Invalid=1);
    vendor_first_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_first_reported_time_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_time_Invalid=1);
    vendor_last_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    vendor_last_reported_time_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_time_Invalid=1);
    country_code_ENUM_ErrorCount := COUNT(GROUP,h.country_code_Invalid=1);
    country_abbr_ENUM_ErrorCount := COUNT(GROUP,h.country_abbr_Invalid=1);
    routing_code_ALLOW_ErrorCount := COUNT(GROUP,h.routing_code_Invalid=1);
    dial_type_ENUM_ErrorCount := COUNT(GROUP,h.dial_type_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    ocn_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_Invalid=1);
    global_sid_ALLOW_ErrorCount := COUNT(GROUP,h.global_sid_Invalid=1);
    record_sid_ALLOW_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.phone_Invalid > 0 OR h.source_Invalid > 0 OR h.transaction_code_Invalid > 0 OR h.transaction_start_dt_Invalid > 0 OR h.transaction_start_time_Invalid > 0 OR h.transaction_end_dt_Invalid > 0 OR h.transaction_end_time_Invalid > 0 OR h.transaction_count_Invalid > 0 OR h.vendor_first_reported_dt_Invalid > 0 OR h.vendor_first_reported_time_Invalid > 0 OR h.vendor_last_reported_dt_Invalid > 0 OR h.vendor_last_reported_time_Invalid > 0 OR h.country_code_Invalid > 0 OR h.country_abbr_Invalid > 0 OR h.routing_code_Invalid > 0 OR h.dial_type_Invalid > 0 OR h.spid_Invalid > 0 OR h.phone_swap_Invalid > 0 OR h.ocn_Invalid > 0 OR h.global_sid_Invalid > 0 OR h.record_sid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.transaction_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.transaction_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_start_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_end_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.country_abbr_ENUM_ErrorCount > 0, 1, 0) + IF(le.routing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dial_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.transaction_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.transaction_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_start_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_end_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.country_abbr_ENUM_ErrorCount > 0, 1, 0) + IF(le.routing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dial_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.phone_Invalid,le.source_Invalid,le.transaction_code_Invalid,le.transaction_start_dt_Invalid,le.transaction_start_time_Invalid,le.transaction_end_dt_Invalid,le.transaction_end_time_Invalid,le.transaction_count_Invalid,le.vendor_first_reported_dt_Invalid,le.vendor_first_reported_time_Invalid,le.vendor_last_reported_dt_Invalid,le.vendor_last_reported_time_Invalid,le.country_code_Invalid,le.country_abbr_Invalid,le.routing_code_Invalid,le.dial_type_Invalid,le.spid_Invalid,le.phone_swap_Invalid,le.ocn_Invalid,le.global_sid_Invalid,le.record_sid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,PhonesTransactionMain_Fields.InvalidMessage_phone(le.phone_Invalid),PhonesTransactionMain_Fields.InvalidMessage_source(le.source_Invalid),PhonesTransactionMain_Fields.InvalidMessage_transaction_code(le.transaction_code_Invalid),PhonesTransactionMain_Fields.InvalidMessage_transaction_start_dt(le.transaction_start_dt_Invalid),PhonesTransactionMain_Fields.InvalidMessage_transaction_start_time(le.transaction_start_time_Invalid),PhonesTransactionMain_Fields.InvalidMessage_transaction_end_dt(le.transaction_end_dt_Invalid),PhonesTransactionMain_Fields.InvalidMessage_transaction_end_time(le.transaction_end_time_Invalid),PhonesTransactionMain_Fields.InvalidMessage_transaction_count(le.transaction_count_Invalid),PhonesTransactionMain_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),PhonesTransactionMain_Fields.InvalidMessage_vendor_first_reported_time(le.vendor_first_reported_time_Invalid),PhonesTransactionMain_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),PhonesTransactionMain_Fields.InvalidMessage_vendor_last_reported_time(le.vendor_last_reported_time_Invalid),PhonesTransactionMain_Fields.InvalidMessage_country_code(le.country_code_Invalid),PhonesTransactionMain_Fields.InvalidMessage_country_abbr(le.country_abbr_Invalid),PhonesTransactionMain_Fields.InvalidMessage_routing_code(le.routing_code_Invalid),PhonesTransactionMain_Fields.InvalidMessage_dial_type(le.dial_type_Invalid),PhonesTransactionMain_Fields.InvalidMessage_spid(le.spid_Invalid),PhonesTransactionMain_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),PhonesTransactionMain_Fields.InvalidMessage_ocn(le.ocn_Invalid),PhonesTransactionMain_Fields.InvalidMessage_global_sid(le.global_sid_Invalid),PhonesTransactionMain_Fields.InvalidMessage_record_sid(le.record_sid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.transaction_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.transaction_start_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transaction_start_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transaction_end_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transaction_end_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transaction_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.country_abbr_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.routing_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dial_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.global_sid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_sid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'phone','source','transaction_code','transaction_start_dt','transaction_start_time','transaction_end_dt','transaction_end_time','transaction_count','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','country_code','country_abbr','routing_code','dial_type','spid','phone_swap','ocn','global_sid','record_sid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Src','Invalid_TransCode','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_CountryCode','Invalid_CountryAbbr','Invalid_Num','Invalid_DialTypeCode','Invalid_AlphaNum','Invalid_Num','Invalid_AlphaNum','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.phone,(SALT311.StrType)le.source,(SALT311.StrType)le.transaction_code,(SALT311.StrType)le.transaction_start_dt,(SALT311.StrType)le.transaction_start_time,(SALT311.StrType)le.transaction_end_dt,(SALT311.StrType)le.transaction_end_time,(SALT311.StrType)le.transaction_count,(SALT311.StrType)le.vendor_first_reported_dt,(SALT311.StrType)le.vendor_first_reported_time,(SALT311.StrType)le.vendor_last_reported_dt,(SALT311.StrType)le.vendor_last_reported_time,(SALT311.StrType)le.country_code,(SALT311.StrType)le.country_abbr,(SALT311.StrType)le.routing_code,(SALT311.StrType)le.dial_type,(SALT311.StrType)le.spid,(SALT311.StrType)le.phone_swap,(SALT311.StrType)le.ocn,(SALT311.StrType)le.global_sid,(SALT311.StrType)le.record_sid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,21,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(PhonesTransactionMain_Layout_PhonesInfo) prevDS = DATASET([], PhonesTransactionMain_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.phone_ALLOW_ErrorCount
          ,le.source_ENUM_ErrorCount
          ,le.transaction_code_ENUM_ErrorCount
          ,le.transaction_start_dt_ALLOW_ErrorCount
          ,le.transaction_start_time_ALLOW_ErrorCount
          ,le.transaction_end_dt_ALLOW_ErrorCount
          ,le.transaction_end_time_ALLOW_ErrorCount
          ,le.transaction_count_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_first_reported_time_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_time_ALLOW_ErrorCount
          ,le.country_code_ENUM_ErrorCount
          ,le.country_abbr_ENUM_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.dial_type_ENUM_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.ocn_ALLOW_ErrorCount
          ,le.global_sid_ALLOW_ErrorCount
          ,le.record_sid_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.phone_ALLOW_ErrorCount
          ,le.source_ENUM_ErrorCount
          ,le.transaction_code_ENUM_ErrorCount
          ,le.transaction_start_dt_ALLOW_ErrorCount
          ,le.transaction_start_time_ALLOW_ErrorCount
          ,le.transaction_end_dt_ALLOW_ErrorCount
          ,le.transaction_end_time_ALLOW_ErrorCount
          ,le.transaction_count_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_first_reported_time_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_time_ALLOW_ErrorCount
          ,le.country_code_ENUM_ErrorCount
          ,le.country_abbr_ENUM_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.dial_type_ENUM_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.ocn_ALLOW_ErrorCount
          ,le.global_sid_ALLOW_ErrorCount
          ,le.record_sid_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := PhonesTransactionMain_hygiene(PROJECT(h, PhonesTransactionMain_Layout_PhonesInfo));
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
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_code:' + getFieldTypeText(h.transaction_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_start_dt:' + getFieldTypeText(h.transaction_start_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_start_time:' + getFieldTypeText(h.transaction_start_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_end_dt:' + getFieldTypeText(h.transaction_end_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_end_time:' + getFieldTypeText(h.transaction_end_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_count:' + getFieldTypeText(h.transaction_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_first_reported_dt:' + getFieldTypeText(h.vendor_first_reported_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_first_reported_time:' + getFieldTypeText(h.vendor_first_reported_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_last_reported_dt:' + getFieldTypeText(h.vendor_last_reported_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_last_reported_time:' + getFieldTypeText(h.vendor_last_reported_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country_code:' + getFieldTypeText(h.country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country_abbr:' + getFieldTypeText(h.country_abbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'routing_code:' + getFieldTypeText(h.routing_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dial_type:' + getFieldTypeText(h.dial_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spid:' + getFieldTypeText(h.spid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_name:' + getFieldTypeText(h.carrier_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_swap:' + getFieldTypeText(h.phone_swap) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn:' + getFieldTypeText(h.ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_phone_cnt
          ,le.populated_source_cnt
          ,le.populated_transaction_code_cnt
          ,le.populated_transaction_start_dt_cnt
          ,le.populated_transaction_start_time_cnt
          ,le.populated_transaction_end_dt_cnt
          ,le.populated_transaction_end_time_cnt
          ,le.populated_transaction_count_cnt
          ,le.populated_vendor_first_reported_dt_cnt
          ,le.populated_vendor_first_reported_time_cnt
          ,le.populated_vendor_last_reported_dt_cnt
          ,le.populated_vendor_last_reported_time_cnt
          ,le.populated_country_code_cnt
          ,le.populated_country_abbr_cnt
          ,le.populated_routing_code_cnt
          ,le.populated_dial_type_cnt
          ,le.populated_spid_cnt
          ,le.populated_carrier_name_cnt
          ,le.populated_phone_swap_cnt
          ,le.populated_ocn_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_phone_pcnt
          ,le.populated_source_pcnt
          ,le.populated_transaction_code_pcnt
          ,le.populated_transaction_start_dt_pcnt
          ,le.populated_transaction_start_time_pcnt
          ,le.populated_transaction_end_dt_pcnt
          ,le.populated_transaction_end_time_pcnt
          ,le.populated_transaction_count_pcnt
          ,le.populated_vendor_first_reported_dt_pcnt
          ,le.populated_vendor_first_reported_time_pcnt
          ,le.populated_vendor_last_reported_dt_pcnt
          ,le.populated_vendor_last_reported_time_pcnt
          ,le.populated_country_code_pcnt
          ,le.populated_country_abbr_pcnt
          ,le.populated_routing_code_pcnt
          ,le.populated_dial_type_pcnt
          ,le.populated_spid_pcnt
          ,le.populated_carrier_name_pcnt
          ,le.populated_phone_swap_pcnt
          ,le.populated_ocn_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := PhonesTransactionMain_Delta(prevDS, PROJECT(h, PhonesTransactionMain_Layout_PhonesInfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(PhonesTransactionMain_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, PhonesTransactionMain_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
