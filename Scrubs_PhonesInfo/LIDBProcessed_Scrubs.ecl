IMPORT ut,SALT33;
EXPORT LIDBProcessed_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(LIDBProcessed_Layout_PhonesInfo)
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
    SELF.reference_id_Invalid := LIDBProcessed_Fields.InValid_reference_id((SALT33.StrType)le.reference_id);
    SELF.dt_first_reported_Invalid := LIDBProcessed_Fields.InValid_dt_first_reported((SALT33.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := LIDBProcessed_Fields.InValid_dt_last_reported((SALT33.StrType)le.dt_last_reported);
    SELF.phone_Invalid := LIDBProcessed_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF.reply_code_Invalid := LIDBProcessed_Fields.InValid_reply_code((SALT33.StrType)le.reply_code);
    SELF.local_routing_number_Invalid := LIDBProcessed_Fields.InValid_local_routing_number((SALT33.StrType)le.local_routing_number);
    SELF.account_owner_Invalid := LIDBProcessed_Fields.InValid_account_owner((SALT33.StrType)le.account_owner);
    SELF.carrier_name_Invalid := LIDBProcessed_Fields.InValid_carrier_name((SALT33.StrType)le.carrier_name);
    SELF.carrier_category_Invalid := LIDBProcessed_Fields.InValid_carrier_category((SALT33.StrType)le.carrier_category);
    SELF.serv_Invalid := LIDBProcessed_Fields.InValid_serv((SALT33.StrType)le.serv);
    SELF.line_Invalid := LIDBProcessed_Fields.InValid_line((SALT33.StrType)le.line);
    SELF.spid_Invalid := LIDBProcessed_Fields.InValid_spid((SALT33.StrType)le.spid);
    SELF.operator_fullname_Invalid := LIDBProcessed_Fields.InValid_operator_fullname((SALT33.StrType)le.operator_fullname);
    SELF.activation_dt_Invalid := LIDBProcessed_Fields.InValid_activation_dt((SALT33.StrType)le.activation_dt);
    SELF.number_in_service_Invalid := LIDBProcessed_Fields.InValid_number_in_service((SALT33.StrType)le.number_in_service);
    SELF.high_risk_indicator_Invalid := LIDBProcessed_Fields.InValid_high_risk_indicator((SALT33.StrType)le.high_risk_indicator);
    SELF.prepaid_Invalid := LIDBProcessed_Fields.InValid_prepaid((SALT33.StrType)le.prepaid);
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
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
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
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.reference_id,(SALT33.StrType)le.dt_first_reported,(SALT33.StrType)le.dt_last_reported,(SALT33.StrType)le.phone,(SALT33.StrType)le.reply_code,(SALT33.StrType)le.local_routing_number,(SALT33.StrType)le.account_owner,(SALT33.StrType)le.carrier_name,(SALT33.StrType)le.carrier_category,(SALT33.StrType)le.serv,(SALT33.StrType)le.line,(SALT33.StrType)le.spid,(SALT33.StrType)le.operator_fullname,(SALT33.StrType)le.activation_dt,(SALT33.StrType)le.number_in_service,(SALT33.StrType)le.high_risk_indicator,(SALT33.StrType)le.prepaid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
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
          ,'prepaid:Invalid_Binary:ALLOW','UNKNOWN');
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
          ,LIDBProcessed_Fields.InvalidMessage_prepaid(1),'UNKNOWN');
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
          ,le.prepaid_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
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
          ,le.prepaid_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,17,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
