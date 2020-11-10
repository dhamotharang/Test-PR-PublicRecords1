IMPORT SALT311,STD;
EXPORT PhonesTypeMain_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 19;
  EXPORT NumRulesFromFieldType := 19;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 19;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(PhonesTypeMain_Layout_PhonesInfo)
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_first_reported_time_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_time_Invalid;
    UNSIGNED1 reference_id_Invalid;
    UNSIGNED1 reply_code_Invalid;
    UNSIGNED1 local_routing_number_Invalid;
    UNSIGNED1 account_owner_Invalid;
    UNSIGNED1 carrier_category_Invalid;
    UNSIGNED1 local_area_transport_area_Invalid;
    UNSIGNED1 serv_Invalid;
    UNSIGNED1 line_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 high_risk_indicator_Invalid;
    UNSIGNED1 prepaid_Invalid;
    UNSIGNED1 global_sid_Invalid;
    UNSIGNED1 record_sid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(PhonesTypeMain_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(PhonesTypeMain_Layout_PhonesInfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'phone:Invalid_Num:ALLOW'
          ,'source:Invalid_Src:ENUM'
          ,'vendor_first_reported_dt:Invalid_Num:ALLOW'
          ,'vendor_first_reported_time:Invalid_Num:ALLOW'
          ,'vendor_last_reported_dt:Invalid_Num:ALLOW'
          ,'vendor_last_reported_time:Invalid_Num:ALLOW'
          ,'reference_id:Invalid_AlphaNum:ALLOW'
          ,'reply_code:Invalid_Num:ALLOW'
          ,'local_routing_number:Invalid_Num:ALLOW'
          ,'account_owner:Invalid_AlphaNum:ALLOW'
          ,'carrier_category:Invalid_CharCat:ENUM'
          ,'local_area_transport_area:Invalid_Num:ALLOW'
          ,'serv:Invalid_Type:ALLOW'
          ,'line:Invalid_Type:ALLOW'
          ,'spid:Invalid_AlphaNum:ALLOW'
          ,'high_risk_indicator:Invalid_Indic:ALLOW'
          ,'prepaid:Invalid_Indic:ALLOW'
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
          ,PhonesTypeMain_Fields.InvalidMessage_phone(1)
          ,PhonesTypeMain_Fields.InvalidMessage_source(1)
          ,PhonesTypeMain_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,PhonesTypeMain_Fields.InvalidMessage_vendor_first_reported_time(1)
          ,PhonesTypeMain_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,PhonesTypeMain_Fields.InvalidMessage_vendor_last_reported_time(1)
          ,PhonesTypeMain_Fields.InvalidMessage_reference_id(1)
          ,PhonesTypeMain_Fields.InvalidMessage_reply_code(1)
          ,PhonesTypeMain_Fields.InvalidMessage_local_routing_number(1)
          ,PhonesTypeMain_Fields.InvalidMessage_account_owner(1)
          ,PhonesTypeMain_Fields.InvalidMessage_carrier_category(1)
          ,PhonesTypeMain_Fields.InvalidMessage_local_area_transport_area(1)
          ,PhonesTypeMain_Fields.InvalidMessage_serv(1)
          ,PhonesTypeMain_Fields.InvalidMessage_line(1)
          ,PhonesTypeMain_Fields.InvalidMessage_spid(1)
          ,PhonesTypeMain_Fields.InvalidMessage_high_risk_indicator(1)
          ,PhonesTypeMain_Fields.InvalidMessage_prepaid(1)
          ,PhonesTypeMain_Fields.InvalidMessage_global_sid(1)
          ,PhonesTypeMain_Fields.InvalidMessage_record_sid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(PhonesTypeMain_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.phone_Invalid := PhonesTypeMain_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.source_Invalid := PhonesTypeMain_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.vendor_first_reported_dt_Invalid := PhonesTypeMain_Fields.InValid_vendor_first_reported_dt((SALT311.StrType)le.vendor_first_reported_dt);
    SELF.vendor_first_reported_time_Invalid := PhonesTypeMain_Fields.InValid_vendor_first_reported_time((SALT311.StrType)le.vendor_first_reported_time);
    SELF.vendor_last_reported_dt_Invalid := PhonesTypeMain_Fields.InValid_vendor_last_reported_dt((SALT311.StrType)le.vendor_last_reported_dt);
    SELF.vendor_last_reported_time_Invalid := PhonesTypeMain_Fields.InValid_vendor_last_reported_time((SALT311.StrType)le.vendor_last_reported_time);
    SELF.reference_id_Invalid := PhonesTypeMain_Fields.InValid_reference_id((SALT311.StrType)le.reference_id);
    SELF.reply_code_Invalid := PhonesTypeMain_Fields.InValid_reply_code((SALT311.StrType)le.reply_code);
    SELF.local_routing_number_Invalid := PhonesTypeMain_Fields.InValid_local_routing_number((SALT311.StrType)le.local_routing_number);
    SELF.account_owner_Invalid := PhonesTypeMain_Fields.InValid_account_owner((SALT311.StrType)le.account_owner);
    SELF.carrier_category_Invalid := PhonesTypeMain_Fields.InValid_carrier_category((SALT311.StrType)le.carrier_category);
    SELF.local_area_transport_area_Invalid := PhonesTypeMain_Fields.InValid_local_area_transport_area((SALT311.StrType)le.local_area_transport_area);
    SELF.serv_Invalid := PhonesTypeMain_Fields.InValid_serv((SALT311.StrType)le.serv);
    SELF.line_Invalid := PhonesTypeMain_Fields.InValid_line((SALT311.StrType)le.line);
    SELF.spid_Invalid := PhonesTypeMain_Fields.InValid_spid((SALT311.StrType)le.spid);
    SELF.high_risk_indicator_Invalid := PhonesTypeMain_Fields.InValid_high_risk_indicator((SALT311.StrType)le.high_risk_indicator);
    SELF.prepaid_Invalid := PhonesTypeMain_Fields.InValid_prepaid((SALT311.StrType)le.prepaid);
    SELF.global_sid_Invalid := PhonesTypeMain_Fields.InValid_global_sid((SALT311.StrType)le.global_sid);
    SELF.record_sid_Invalid := PhonesTypeMain_Fields.InValid_record_sid((SALT311.StrType)le.record_sid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),PhonesTypeMain_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.phone_Invalid << 0 ) + ( le.source_Invalid << 1 ) + ( le.vendor_first_reported_dt_Invalid << 2 ) + ( le.vendor_first_reported_time_Invalid << 3 ) + ( le.vendor_last_reported_dt_Invalid << 4 ) + ( le.vendor_last_reported_time_Invalid << 5 ) + ( le.reference_id_Invalid << 6 ) + ( le.reply_code_Invalid << 7 ) + ( le.local_routing_number_Invalid << 8 ) + ( le.account_owner_Invalid << 9 ) + ( le.carrier_category_Invalid << 10 ) + ( le.local_area_transport_area_Invalid << 11 ) + ( le.serv_Invalid << 12 ) + ( le.line_Invalid << 13 ) + ( le.spid_Invalid << 14 ) + ( le.high_risk_indicator_Invalid << 15 ) + ( le.prepaid_Invalid << 16 ) + ( le.global_sid_Invalid << 17 ) + ( le.record_sid_Invalid << 18 );
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
  EXPORT Infile := PROJECT(h,PhonesTypeMain_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.phone_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.vendor_first_reported_time_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.vendor_last_reported_time_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.reference_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.reply_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.local_routing_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.account_owner_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.carrier_category_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.local_area_transport_area_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.serv_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.line_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.high_risk_indicator_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.prepaid_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.global_sid_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.record_sid_Invalid := (le.ScrubsBits1 >> 18) & 1;
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
    vendor_first_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_first_reported_time_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_time_Invalid=1);
    vendor_last_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    vendor_last_reported_time_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_time_Invalid=1);
    reference_id_ALLOW_ErrorCount := COUNT(GROUP,h.reference_id_Invalid=1);
    reply_code_ALLOW_ErrorCount := COUNT(GROUP,h.reply_code_Invalid=1);
    local_routing_number_ALLOW_ErrorCount := COUNT(GROUP,h.local_routing_number_Invalid=1);
    account_owner_ALLOW_ErrorCount := COUNT(GROUP,h.account_owner_Invalid=1);
    carrier_category_ENUM_ErrorCount := COUNT(GROUP,h.carrier_category_Invalid=1);
    local_area_transport_area_ALLOW_ErrorCount := COUNT(GROUP,h.local_area_transport_area_Invalid=1);
    serv_ALLOW_ErrorCount := COUNT(GROUP,h.serv_Invalid=1);
    line_ALLOW_ErrorCount := COUNT(GROUP,h.line_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    high_risk_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.high_risk_indicator_Invalid=1);
    prepaid_ALLOW_ErrorCount := COUNT(GROUP,h.prepaid_Invalid=1);
    global_sid_ALLOW_ErrorCount := COUNT(GROUP,h.global_sid_Invalid=1);
    record_sid_ALLOW_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.phone_Invalid > 0 OR h.source_Invalid > 0 OR h.vendor_first_reported_dt_Invalid > 0 OR h.vendor_first_reported_time_Invalid > 0 OR h.vendor_last_reported_dt_Invalid > 0 OR h.vendor_last_reported_time_Invalid > 0 OR h.reference_id_Invalid > 0 OR h.reply_code_Invalid > 0 OR h.local_routing_number_Invalid > 0 OR h.account_owner_Invalid > 0 OR h.carrier_category_Invalid > 0 OR h.local_area_transport_area_Invalid > 0 OR h.serv_Invalid > 0 OR h.line_Invalid > 0 OR h.spid_Invalid > 0 OR h.high_risk_indicator_Invalid > 0 OR h.prepaid_Invalid > 0 OR h.global_sid_Invalid > 0 OR h.record_sid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reply_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.local_routing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.account_owner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_category_ENUM_ErrorCount > 0, 1, 0) + IF(le.local_area_transport_area_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.high_risk_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reply_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.local_routing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.account_owner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_category_ENUM_ErrorCount > 0, 1, 0) + IF(le.local_area_transport_area_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.high_risk_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.phone_Invalid,le.source_Invalid,le.vendor_first_reported_dt_Invalid,le.vendor_first_reported_time_Invalid,le.vendor_last_reported_dt_Invalid,le.vendor_last_reported_time_Invalid,le.reference_id_Invalid,le.reply_code_Invalid,le.local_routing_number_Invalid,le.account_owner_Invalid,le.carrier_category_Invalid,le.local_area_transport_area_Invalid,le.serv_Invalid,le.line_Invalid,le.spid_Invalid,le.high_risk_indicator_Invalid,le.prepaid_Invalid,le.global_sid_Invalid,le.record_sid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,PhonesTypeMain_Fields.InvalidMessage_phone(le.phone_Invalid),PhonesTypeMain_Fields.InvalidMessage_source(le.source_Invalid),PhonesTypeMain_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),PhonesTypeMain_Fields.InvalidMessage_vendor_first_reported_time(le.vendor_first_reported_time_Invalid),PhonesTypeMain_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),PhonesTypeMain_Fields.InvalidMessage_vendor_last_reported_time(le.vendor_last_reported_time_Invalid),PhonesTypeMain_Fields.InvalidMessage_reference_id(le.reference_id_Invalid),PhonesTypeMain_Fields.InvalidMessage_reply_code(le.reply_code_Invalid),PhonesTypeMain_Fields.InvalidMessage_local_routing_number(le.local_routing_number_Invalid),PhonesTypeMain_Fields.InvalidMessage_account_owner(le.account_owner_Invalid),PhonesTypeMain_Fields.InvalidMessage_carrier_category(le.carrier_category_Invalid),PhonesTypeMain_Fields.InvalidMessage_local_area_transport_area(le.local_area_transport_area_Invalid),PhonesTypeMain_Fields.InvalidMessage_serv(le.serv_Invalid),PhonesTypeMain_Fields.InvalidMessage_line(le.line_Invalid),PhonesTypeMain_Fields.InvalidMessage_spid(le.spid_Invalid),PhonesTypeMain_Fields.InvalidMessage_high_risk_indicator(le.high_risk_indicator_Invalid),PhonesTypeMain_Fields.InvalidMessage_prepaid(le.prepaid_Invalid),PhonesTypeMain_Fields.InvalidMessage_global_sid(le.global_sid_Invalid),PhonesTypeMain_Fields.InvalidMessage_record_sid(le.record_sid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reference_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reply_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.local_routing_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.account_owner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_category_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.local_area_transport_area_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.serv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.line_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.high_risk_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prepaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.global_sid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_sid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'phone','source','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','reference_id','reply_code','local_routing_number','account_owner','carrier_category','local_area_transport_area','serv','line','spid','high_risk_indicator','prepaid','global_sid','record_sid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Src','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_AlphaNum','Invalid_Num','Invalid_Num','Invalid_AlphaNum','Invalid_CharCat','Invalid_Num','Invalid_Type','Invalid_Type','Invalid_AlphaNum','Invalid_Indic','Invalid_Indic','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.phone,(SALT311.StrType)le.source,(SALT311.StrType)le.vendor_first_reported_dt,(SALT311.StrType)le.vendor_first_reported_time,(SALT311.StrType)le.vendor_last_reported_dt,(SALT311.StrType)le.vendor_last_reported_time,(SALT311.StrType)le.reference_id,(SALT311.StrType)le.reply_code,(SALT311.StrType)le.local_routing_number,(SALT311.StrType)le.account_owner,(SALT311.StrType)le.carrier_category,(SALT311.StrType)le.local_area_transport_area,(SALT311.StrType)le.serv,(SALT311.StrType)le.line,(SALT311.StrType)le.spid,(SALT311.StrType)le.high_risk_indicator,(SALT311.StrType)le.prepaid,(SALT311.StrType)le.global_sid,(SALT311.StrType)le.record_sid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(PhonesTypeMain_Layout_PhonesInfo) prevDS = DATASET([], PhonesTypeMain_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
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
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_first_reported_time_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_time_ALLOW_ErrorCount
          ,le.reference_id_ALLOW_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_category_ENUM_ErrorCount
          ,le.local_area_transport_area_ALLOW_ErrorCount
          ,le.serv_ALLOW_ErrorCount
          ,le.line_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
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
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_first_reported_time_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_time_ALLOW_ErrorCount
          ,le.reference_id_ALLOW_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_category_ENUM_ErrorCount
          ,le.local_area_transport_area_ALLOW_ErrorCount
          ,le.serv_ALLOW_ErrorCount
          ,le.line_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
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
    mod_hygiene := PhonesTypeMain_hygiene(PROJECT(h, PhonesTypeMain_Layout_PhonesInfo));
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
          ,'vendor_first_reported_dt:' + getFieldTypeText(h.vendor_first_reported_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_first_reported_time:' + getFieldTypeText(h.vendor_first_reported_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_last_reported_dt:' + getFieldTypeText(h.vendor_last_reported_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_last_reported_time:' + getFieldTypeText(h.vendor_last_reported_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference_id:' + getFieldTypeText(h.reference_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reply_code:' + getFieldTypeText(h.reply_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'local_routing_number:' + getFieldTypeText(h.local_routing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_owner:' + getFieldTypeText(h.account_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_name:' + getFieldTypeText(h.carrier_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_category:' + getFieldTypeText(h.carrier_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'local_area_transport_area:' + getFieldTypeText(h.local_area_transport_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'point_code:' + getFieldTypeText(h.point_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'serv:' + getFieldTypeText(h.serv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'line:' + getFieldTypeText(h.line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spid:' + getFieldTypeText(h.spid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'operator_fullname:' + getFieldTypeText(h.operator_fullname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_risk_indicator:' + getFieldTypeText(h.high_risk_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepaid:' + getFieldTypeText(h.prepaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_phone_cnt
          ,le.populated_source_cnt
          ,le.populated_vendor_first_reported_dt_cnt
          ,le.populated_vendor_first_reported_time_cnt
          ,le.populated_vendor_last_reported_dt_cnt
          ,le.populated_vendor_last_reported_time_cnt
          ,le.populated_reference_id_cnt
          ,le.populated_reply_code_cnt
          ,le.populated_local_routing_number_cnt
          ,le.populated_account_owner_cnt
          ,le.populated_carrier_name_cnt
          ,le.populated_carrier_category_cnt
          ,le.populated_local_area_transport_area_cnt
          ,le.populated_point_code_cnt
          ,le.populated_serv_cnt
          ,le.populated_line_cnt
          ,le.populated_spid_cnt
          ,le.populated_operator_fullname_cnt
          ,le.populated_high_risk_indicator_cnt
          ,le.populated_prepaid_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_phone_pcnt
          ,le.populated_source_pcnt
          ,le.populated_vendor_first_reported_dt_pcnt
          ,le.populated_vendor_first_reported_time_pcnt
          ,le.populated_vendor_last_reported_dt_pcnt
          ,le.populated_vendor_last_reported_time_pcnt
          ,le.populated_reference_id_pcnt
          ,le.populated_reply_code_pcnt
          ,le.populated_local_routing_number_pcnt
          ,le.populated_account_owner_pcnt
          ,le.populated_carrier_name_pcnt
          ,le.populated_carrier_category_pcnt
          ,le.populated_local_area_transport_area_pcnt
          ,le.populated_point_code_pcnt
          ,le.populated_serv_pcnt
          ,le.populated_line_pcnt
          ,le.populated_spid_pcnt
          ,le.populated_operator_fullname_pcnt
          ,le.populated_high_risk_indicator_pcnt
          ,le.populated_prepaid_pcnt
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
 
    mod_Delta := PhonesTypeMain_Delta(prevDS, PROJECT(h, PhonesTypeMain_Layout_PhonesInfo));
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
 
EXPORT StandardStats(DATASET(PhonesTypeMain_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, PhonesTypeMain_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
