IMPORT SALT39,STD;
EXPORT LIDBProcessed_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 17;
  EXPORT NumRulesFromFieldType := 17;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(LIDBProcessed_Layout_PhonesInfo)
    UNSIGNED1 reference_id_Invalid;
    UNSIGNED1 dt_first_reported_Invalid;
    UNSIGNED1 dt_last_reported_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 reply_code_Invalid;
    UNSIGNED1 local_routing_number_Invalid;
    UNSIGNED1 account_owner_Invalid;
    UNSIGNED1 carrier_name_Invalid;
    UNSIGNED1 carrier_category_Invalid;
    UNSIGNED1 serv_Invalid;
    UNSIGNED1 line_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 operator_fullname_Invalid;
    UNSIGNED1 activation_dt_Invalid;
    UNSIGNED1 number_in_service_Invalid;
    UNSIGNED1 high_risk_indicator_Invalid;
    UNSIGNED1 prepaid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(LIDBProcessed_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(LIDBProcessed_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.reference_id_Invalid := LIDBProcessed_Fields.InValid_reference_id((SALT39.StrType)le.reference_id);
    SELF.dt_first_reported_Invalid := LIDBProcessed_Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := LIDBProcessed_Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported);
    SELF.phone_Invalid := LIDBProcessed_Fields.InValid_phone((SALT39.StrType)le.phone);
    SELF.reply_code_Invalid := LIDBProcessed_Fields.InValid_reply_code((SALT39.StrType)le.reply_code);
    SELF.local_routing_number_Invalid := LIDBProcessed_Fields.InValid_local_routing_number((SALT39.StrType)le.local_routing_number);
    SELF.account_owner_Invalid := LIDBProcessed_Fields.InValid_account_owner((SALT39.StrType)le.account_owner);
    SELF.carrier_name_Invalid := LIDBProcessed_Fields.InValid_carrier_name((SALT39.StrType)le.carrier_name);
    SELF.carrier_category_Invalid := LIDBProcessed_Fields.InValid_carrier_category((SALT39.StrType)le.carrier_category);
    SELF.serv_Invalid := LIDBProcessed_Fields.InValid_serv((SALT39.StrType)le.serv);
    SELF.line_Invalid := LIDBProcessed_Fields.InValid_line((SALT39.StrType)le.line);
    SELF.spid_Invalid := LIDBProcessed_Fields.InValid_spid((SALT39.StrType)le.spid);
    SELF.operator_fullname_Invalid := LIDBProcessed_Fields.InValid_operator_fullname((SALT39.StrType)le.operator_fullname);
    SELF.activation_dt_Invalid := LIDBProcessed_Fields.InValid_activation_dt((SALT39.StrType)le.activation_dt);
    SELF.number_in_service_Invalid := LIDBProcessed_Fields.InValid_number_in_service((SALT39.StrType)le.number_in_service);
    SELF.high_risk_indicator_Invalid := LIDBProcessed_Fields.InValid_high_risk_indicator((SALT39.StrType)le.high_risk_indicator);
    SELF.prepaid_Invalid := LIDBProcessed_Fields.InValid_prepaid((SALT39.StrType)le.prepaid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),LIDBProcessed_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.reference_id_Invalid << 0 ) + ( le.dt_first_reported_Invalid << 1 ) + ( le.dt_last_reported_Invalid << 2 ) + ( le.phone_Invalid << 3 ) + ( le.reply_code_Invalid << 4 ) + ( le.local_routing_number_Invalid << 5 ) + ( le.account_owner_Invalid << 6 ) + ( le.carrier_name_Invalid << 7 ) + ( le.carrier_category_Invalid << 8 ) + ( le.serv_Invalid << 9 ) + ( le.line_Invalid << 10 ) + ( le.spid_Invalid << 11 ) + ( le.operator_fullname_Invalid << 12 ) + ( le.activation_dt_Invalid << 13 ) + ( le.number_in_service_Invalid << 14 ) + ( le.high_risk_indicator_Invalid << 15 ) + ( le.prepaid_Invalid << 16 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,LIDBProcessed_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.reference_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_first_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_last_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.reply_code_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.local_routing_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.account_owner_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.carrier_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.carrier_category_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.serv_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.line_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.operator_fullname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.activation_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.number_in_service_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.high_risk_indicator_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.prepaid_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    reference_id_ALLOW_ErrorCount := COUNT(GROUP,h.reference_id_Invalid=1);
    dt_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_reported_Invalid=1);
    dt_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_reported_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    reply_code_ALLOW_ErrorCount := COUNT(GROUP,h.reply_code_Invalid=1);
    local_routing_number_ALLOW_ErrorCount := COUNT(GROUP,h.local_routing_number_Invalid=1);
    account_owner_ALLOW_ErrorCount := COUNT(GROUP,h.account_owner_Invalid=1);
    carrier_name_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid=1);
    carrier_category_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_category_Invalid=1);
    serv_ALLOW_ErrorCount := COUNT(GROUP,h.serv_Invalid=1);
    line_ALLOW_ErrorCount := COUNT(GROUP,h.line_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    operator_fullname_ALLOW_ErrorCount := COUNT(GROUP,h.operator_fullname_Invalid=1);
    activation_dt_ALLOW_ErrorCount := COUNT(GROUP,h.activation_dt_Invalid=1);
    number_in_service_ENUM_ErrorCount := COUNT(GROUP,h.number_in_service_Invalid=1);
    high_risk_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.high_risk_indicator_Invalid=1);
    prepaid_ALLOW_ErrorCount := COUNT(GROUP,h.prepaid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.reference_id_Invalid > 0 OR h.dt_first_reported_Invalid > 0 OR h.dt_last_reported_Invalid > 0 OR h.phone_Invalid > 0 OR h.reply_code_Invalid > 0 OR h.local_routing_number_Invalid > 0 OR h.account_owner_Invalid > 0 OR h.carrier_name_Invalid > 0 OR h.carrier_category_Invalid > 0 OR h.serv_Invalid > 0 OR h.line_Invalid > 0 OR h.spid_Invalid > 0 OR h.operator_fullname_Invalid > 0 OR h.activation_dt_Invalid > 0 OR h.number_in_service_Invalid > 0 OR h.high_risk_indicator_Invalid > 0 OR h.prepaid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.reference_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reply_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.local_routing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.account_owner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operator_fullname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.activation_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.number_in_service_ENUM_ErrorCount > 0, 1, 0) + IF(le.high_risk_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepaid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.reference_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reply_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.local_routing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.account_owner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operator_fullname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.activation_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.number_in_service_ENUM_ErrorCount > 0, 1, 0) + IF(le.high_risk_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepaid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.reference_id_Invalid,le.dt_first_reported_Invalid,le.dt_last_reported_Invalid,le.phone_Invalid,le.reply_code_Invalid,le.local_routing_number_Invalid,le.account_owner_Invalid,le.carrier_name_Invalid,le.carrier_category_Invalid,le.serv_Invalid,le.line_Invalid,le.spid_Invalid,le.operator_fullname_Invalid,le.activation_dt_Invalid,le.number_in_service_Invalid,le.high_risk_indicator_Invalid,le.prepaid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,LIDBProcessed_Fields.InvalidMessage_reference_id(le.reference_id_Invalid),LIDBProcessed_Fields.InvalidMessage_dt_first_reported(le.dt_first_reported_Invalid),LIDBProcessed_Fields.InvalidMessage_dt_last_reported(le.dt_last_reported_Invalid),LIDBProcessed_Fields.InvalidMessage_phone(le.phone_Invalid),LIDBProcessed_Fields.InvalidMessage_reply_code(le.reply_code_Invalid),LIDBProcessed_Fields.InvalidMessage_local_routing_number(le.local_routing_number_Invalid),LIDBProcessed_Fields.InvalidMessage_account_owner(le.account_owner_Invalid),LIDBProcessed_Fields.InvalidMessage_carrier_name(le.carrier_name_Invalid),LIDBProcessed_Fields.InvalidMessage_carrier_category(le.carrier_category_Invalid),LIDBProcessed_Fields.InvalidMessage_serv(le.serv_Invalid),LIDBProcessed_Fields.InvalidMessage_line(le.line_Invalid),LIDBProcessed_Fields.InvalidMessage_spid(le.spid_Invalid),LIDBProcessed_Fields.InvalidMessage_operator_fullname(le.operator_fullname_Invalid),LIDBProcessed_Fields.InvalidMessage_activation_dt(le.activation_dt_Invalid),LIDBProcessed_Fields.InvalidMessage_number_in_service(le.number_in_service_Invalid),LIDBProcessed_Fields.InvalidMessage_high_risk_indicator(le.high_risk_indicator_Invalid),LIDBProcessed_Fields.InvalidMessage_prepaid(le.prepaid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.reference_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reply_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.local_routing_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.account_owner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_category_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.serv_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.line_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.operator_fullname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.activation_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.number_in_service_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.high_risk_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prepaid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'reference_id','dt_first_reported','dt_last_reported','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','serv','line','spid','operator_fullname','activation_dt','number_in_service','high_risk_indicator','prepaid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_RefID','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_AccOwn','Invalid_Char','Invalid_Char','Invalid_Line_Serv','Invalid_Line_Serv','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num_In_Service','Invalid_Binary','Invalid_Binary','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.reference_id,(SALT39.StrType)le.dt_first_reported,(SALT39.StrType)le.dt_last_reported,(SALT39.StrType)le.phone,(SALT39.StrType)le.reply_code,(SALT39.StrType)le.local_routing_number,(SALT39.StrType)le.account_owner,(SALT39.StrType)le.carrier_name,(SALT39.StrType)le.carrier_category,(SALT39.StrType)le.serv,(SALT39.StrType)le.line,(SALT39.StrType)le.spid,(SALT39.StrType)le.operator_fullname,(SALT39.StrType)le.activation_dt,(SALT39.StrType)le.number_in_service,(SALT39.StrType)le.high_risk_indicator,(SALT39.StrType)le.prepaid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(LIDBProcessed_Layout_PhonesInfo) prevDS = DATASET([], LIDBProcessed_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'reference_id:Invalid_RefID:ALLOW'
          ,'dt_first_reported:Invalid_Num:ALLOW'
          ,'dt_last_reported:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'reply_code:Invalid_Num:ALLOW'
          ,'local_routing_number:Invalid_Num:ALLOW'
          ,'account_owner:Invalid_AccOwn:ALLOW'
          ,'carrier_name:Invalid_Char:ALLOW'
          ,'carrier_category:Invalid_Char:ALLOW'
          ,'serv:Invalid_Line_Serv:ALLOW'
          ,'line:Invalid_Line_Serv:ALLOW'
          ,'spid:Invalid_Num:ALLOW'
          ,'operator_fullname:Invalid_Char:ALLOW'
          ,'activation_dt:Invalid_Num:ALLOW'
          ,'number_in_service:Invalid_Num_In_Service:ENUM'
          ,'high_risk_indicator:Invalid_Binary:ALLOW'
          ,'prepaid:Invalid_Binary:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,LIDBProcessed_Fields.InvalidMessage_reference_id(1)
          ,LIDBProcessed_Fields.InvalidMessage_dt_first_reported(1)
          ,LIDBProcessed_Fields.InvalidMessage_dt_last_reported(1)
          ,LIDBProcessed_Fields.InvalidMessage_phone(1)
          ,LIDBProcessed_Fields.InvalidMessage_reply_code(1)
          ,LIDBProcessed_Fields.InvalidMessage_local_routing_number(1)
          ,LIDBProcessed_Fields.InvalidMessage_account_owner(1)
          ,LIDBProcessed_Fields.InvalidMessage_carrier_name(1)
          ,LIDBProcessed_Fields.InvalidMessage_carrier_category(1)
          ,LIDBProcessed_Fields.InvalidMessage_serv(1)
          ,LIDBProcessed_Fields.InvalidMessage_line(1)
          ,LIDBProcessed_Fields.InvalidMessage_spid(1)
          ,LIDBProcessed_Fields.InvalidMessage_operator_fullname(1)
          ,LIDBProcessed_Fields.InvalidMessage_activation_dt(1)
          ,LIDBProcessed_Fields.InvalidMessage_number_in_service(1)
          ,LIDBProcessed_Fields.InvalidMessage_high_risk_indicator(1)
          ,LIDBProcessed_Fields.InvalidMessage_prepaid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.reference_id_ALLOW_ErrorCount
          ,le.dt_first_reported_ALLOW_ErrorCount
          ,le.dt_last_reported_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_name_ALLOW_ErrorCount
          ,le.carrier_category_ALLOW_ErrorCount
          ,le.serv_ALLOW_ErrorCount
          ,le.line_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.operator_fullname_ALLOW_ErrorCount
          ,le.activation_dt_ALLOW_ErrorCount
          ,le.number_in_service_ENUM_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.reference_id_ALLOW_ErrorCount
          ,le.dt_first_reported_ALLOW_ErrorCount
          ,le.dt_last_reported_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.reply_code_ALLOW_ErrorCount
          ,le.local_routing_number_ALLOW_ErrorCount
          ,le.account_owner_ALLOW_ErrorCount
          ,le.carrier_name_ALLOW_ErrorCount
          ,le.carrier_category_ALLOW_ErrorCount
          ,le.serv_ALLOW_ErrorCount
          ,le.line_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.operator_fullname_ALLOW_ErrorCount
          ,le.activation_dt_ALLOW_ErrorCount
          ,le.number_in_service_ENUM_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := LIDBProcessed_hygiene(PROJECT(h, LIDBProcessed_Layout_PhonesInfo));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'reference_id:' + getFieldTypeText(h.reference_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_reported:' + getFieldTypeText(h.dt_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_reported:' + getFieldTypeText(h.dt_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'activation_dt:' + getFieldTypeText(h.activation_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_in_service:' + getFieldTypeText(h.number_in_service) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_risk_indicator:' + getFieldTypeText(h.high_risk_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepaid:' + getFieldTypeText(h.prepaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_reference_id_cnt
          ,le.populated_dt_first_reported_cnt
          ,le.populated_dt_last_reported_cnt
          ,le.populated_phone_cnt
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
          ,le.populated_activation_dt_cnt
          ,le.populated_number_in_service_cnt
          ,le.populated_high_risk_indicator_cnt
          ,le.populated_prepaid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_reference_id_pcnt
          ,le.populated_dt_first_reported_pcnt
          ,le.populated_dt_last_reported_pcnt
          ,le.populated_phone_pcnt
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
          ,le.populated_activation_dt_pcnt
          ,le.populated_number_in_service_pcnt
          ,le.populated_high_risk_indicator_pcnt
          ,le.populated_prepaid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,19,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := LIDBProcessed_Delta(prevDS, PROJECT(h, LIDBProcessed_Layout_PhonesInfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),19,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(LIDBProcessed_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, LIDBProcessed_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
