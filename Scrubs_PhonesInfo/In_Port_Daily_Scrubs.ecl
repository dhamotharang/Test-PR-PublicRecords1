IMPORT ut,SALT31;
EXPORT In_Port_Daily_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(In_Port_Daily_Layout_PhonesInfo)
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 country_code_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 dial_type_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 service_type_Invalid;
    UNSIGNED1 routing_code_Invalid;
    UNSIGNED1 porting_dt_Invalid;
    UNSIGNED1 country_abbr_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(In_Port_Daily_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(In_Port_Daily_Layout_PhonesInfo) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.action_code_Invalid := In_Port_Daily_Fields.InValid_action_code((SALT31.StrType)le.action_code);
    SELF.country_code_Invalid := In_Port_Daily_Fields.InValid_country_code((SALT31.StrType)le.country_code);
    SELF.phone_Invalid := In_Port_Daily_Fields.InValid_phone((SALT31.StrType)le.phone);
    SELF.dial_type_Invalid := In_Port_Daily_Fields.InValid_dial_type((SALT31.StrType)le.dial_type);
    SELF.spid_Invalid := In_Port_Daily_Fields.InValid_spid((SALT31.StrType)le.spid);
    SELF.service_type_Invalid := In_Port_Daily_Fields.InValid_service_type((SALT31.StrType)le.service_type);
    SELF.routing_code_Invalid := In_Port_Daily_Fields.InValid_routing_code((SALT31.StrType)le.routing_code);
    SELF.porting_dt_Invalid := In_Port_Daily_Fields.InValid_porting_dt((SALT31.StrType)le.porting_dt);
    SELF.country_abbr_Invalid := In_Port_Daily_Fields.InValid_country_abbr((SALT31.StrType)le.country_abbr);
    SELF.filename_Invalid := In_Port_Daily_Fields.InValid_filename((SALT31.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.action_code_Invalid << 0 ) + ( le.country_code_Invalid << 1 ) + ( le.phone_Invalid << 2 ) + ( le.dial_type_Invalid << 3 ) + ( le.spid_Invalid << 4 ) + ( le.service_type_Invalid << 5 ) + ( le.routing_code_Invalid << 6 ) + ( le.porting_dt_Invalid << 7 ) + ( le.country_abbr_Invalid << 8 ) + ( le.filename_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,In_Port_Daily_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.country_code_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dial_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.service_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.routing_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.country_abbr_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    action_code_ALLOW_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    country_code_ALLOW_ErrorCount := COUNT(GROUP,h.country_code_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    dial_type_ALLOW_ErrorCount := COUNT(GROUP,h.dial_type_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    service_type_ALLOW_ErrorCount := COUNT(GROUP,h.service_type_Invalid=1);
    routing_code_ALLOW_ErrorCount := COUNT(GROUP,h.routing_code_Invalid=1);
    porting_dt_ALLOW_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    country_abbr_ALLOW_ErrorCount := COUNT(GROUP,h.country_abbr_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.action_code_Invalid,le.country_code_Invalid,le.phone_Invalid,le.dial_type_Invalid,le.spid_Invalid,le.service_type_Invalid,le.routing_code_Invalid,le.porting_dt_Invalid,le.country_abbr_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,In_Port_Daily_Fields.InvalidMessage_action_code(le.action_code_Invalid),In_Port_Daily_Fields.InvalidMessage_country_code(le.country_code_Invalid),In_Port_Daily_Fields.InvalidMessage_phone(le.phone_Invalid),In_Port_Daily_Fields.InvalidMessage_dial_type(le.dial_type_Invalid),In_Port_Daily_Fields.InvalidMessage_spid(le.spid_Invalid),In_Port_Daily_Fields.InvalidMessage_service_type(le.service_type_Invalid),In_Port_Daily_Fields.InvalidMessage_routing_code(le.routing_code_Invalid),In_Port_Daily_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),In_Port_Daily_Fields.InvalidMessage_country_abbr(le.country_abbr_Invalid),In_Port_Daily_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.action_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dial_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.service_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_abbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'action_code','country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_DCT','Invalid_Num','Invalid_TOS','Invalid_Num_Blank','Invalid_Port_Date','Invalid_ISO2','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.action_code,(SALT31.StrType)le.country_code,(SALT31.StrType)le.phone,(SALT31.StrType)le.dial_type,(SALT31.StrType)le.spid,(SALT31.StrType)le.service_type,(SALT31.StrType)le.routing_code,(SALT31.StrType)le.porting_dt,(SALT31.StrType)le.country_abbr,(SALT31.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'action_code:Invalid_Action_Code:ALLOW'
          ,'country_code:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'dial_type:Invalid_DCT:ALLOW'
          ,'spid:Invalid_Num:ALLOW'
          ,'service_type:Invalid_TOS:ALLOW'
          ,'routing_code:Invalid_Num_Blank:ALLOW'
          ,'porting_dt:Invalid_Port_Date:ALLOW'
          ,'country_abbr:Invalid_ISO2:ALLOW'
          ,'filename:Invalid_Filename:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,In_Port_Daily_Fields.InvalidMessage_action_code(1)
          ,In_Port_Daily_Fields.InvalidMessage_country_code(1)
          ,In_Port_Daily_Fields.InvalidMessage_phone(1)
          ,In_Port_Daily_Fields.InvalidMessage_dial_type(1)
          ,In_Port_Daily_Fields.InvalidMessage_spid(1)
          ,In_Port_Daily_Fields.InvalidMessage_service_type(1)
          ,In_Port_Daily_Fields.InvalidMessage_routing_code(1)
          ,In_Port_Daily_Fields.InvalidMessage_porting_dt(1)
          ,In_Port_Daily_Fields.InvalidMessage_country_abbr(1)
          ,In_Port_Daily_Fields.InvalidMessage_filename(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.action_code_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.service_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.action_code_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.service_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,10,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
