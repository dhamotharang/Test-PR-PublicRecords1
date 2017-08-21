IMPORT ut,SALT33;
EXPORT iConectivMain_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(iConectivMain_Layout_PhonesInfo)
    UNSIGNED1 country_code_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 dial_type_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 service_type_Invalid;
    UNSIGNED1 routing_code_Invalid;
    UNSIGNED1 porting_dt_Invalid;
    UNSIGNED1 country_abbr_Invalid;
    UNSIGNED1 filename_Invalid;
    UNSIGNED1 file_dt_time_Invalid;
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 port_start_dt_Invalid;
    UNSIGNED1 port_end_dt_Invalid;
    UNSIGNED1 remove_port_dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(iConectivMain_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(iConectivMain_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.country_code_Invalid := iConectivMain_Fields.InValid_country_code((SALT33.StrType)le.country_code);
    SELF.phone_Invalid := iConectivMain_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF.dial_type_Invalid := iConectivMain_Fields.InValid_dial_type((SALT33.StrType)le.dial_type);
    SELF.spid_Invalid := iConectivMain_Fields.InValid_spid((SALT33.StrType)le.spid);
    SELF.service_type_Invalid := iConectivMain_Fields.InValid_service_type((SALT33.StrType)le.service_type);
    SELF.routing_code_Invalid := iConectivMain_Fields.InValid_routing_code((SALT33.StrType)le.routing_code);
    SELF.porting_dt_Invalid := iConectivMain_Fields.InValid_porting_dt((SALT33.StrType)le.porting_dt);
    SELF.country_abbr_Invalid := iConectivMain_Fields.InValid_country_abbr((SALT33.StrType)le.country_abbr);
    SELF.filename_Invalid := iConectivMain_Fields.InValid_filename((SALT33.StrType)le.filename);
    SELF.file_dt_time_Invalid := iConectivMain_Fields.InValid_file_dt_time((SALT33.StrType)le.file_dt_time);
    SELF.vendor_first_reported_dt_Invalid := iConectivMain_Fields.InValid_vendor_first_reported_dt((SALT33.StrType)le.vendor_first_reported_dt);
    SELF.vendor_last_reported_dt_Invalid := iConectivMain_Fields.InValid_vendor_last_reported_dt((SALT33.StrType)le.vendor_last_reported_dt);
    SELF.port_start_dt_Invalid := iConectivMain_Fields.InValid_port_start_dt((SALT33.StrType)le.port_start_dt);
    SELF.port_end_dt_Invalid := iConectivMain_Fields.InValid_port_end_dt((SALT33.StrType)le.port_end_dt);
    SELF.remove_port_dt_Invalid := iConectivMain_Fields.InValid_remove_port_dt((SALT33.StrType)le.remove_port_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),iConectivMain_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.country_code_Invalid << 0 ) + ( le.phone_Invalid << 1 ) + ( le.dial_type_Invalid << 2 ) + ( le.spid_Invalid << 3 ) + ( le.service_type_Invalid << 4 ) + ( le.routing_code_Invalid << 5 ) + ( le.porting_dt_Invalid << 6 ) + ( le.country_abbr_Invalid << 7 ) + ( le.filename_Invalid << 8 ) + ( le.file_dt_time_Invalid << 9 ) + ( le.vendor_first_reported_dt_Invalid << 10 ) + ( le.vendor_last_reported_dt_Invalid << 11 ) + ( le.port_start_dt_Invalid << 12 ) + ( le.port_end_dt_Invalid << 13 ) + ( le.remove_port_dt_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,iConectivMain_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.country_code_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dial_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.service_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.routing_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.country_abbr_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.file_dt_time_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.port_start_dt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.port_end_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.remove_port_dt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    country_code_ALLOW_ErrorCount := COUNT(GROUP,h.country_code_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    dial_type_ALLOW_ErrorCount := COUNT(GROUP,h.dial_type_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    service_type_ALLOW_ErrorCount := COUNT(GROUP,h.service_type_Invalid=1);
    routing_code_ALLOW_ErrorCount := COUNT(GROUP,h.routing_code_Invalid=1);
    porting_dt_ALLOW_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    country_abbr_ALLOW_ErrorCount := COUNT(GROUP,h.country_abbr_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    file_dt_time_ALLOW_ErrorCount := COUNT(GROUP,h.file_dt_time_Invalid=1);
    vendor_first_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_last_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    port_start_dt_ALLOW_ErrorCount := COUNT(GROUP,h.port_start_dt_Invalid=1);
    port_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.port_end_dt_Invalid=1);
    remove_port_dt_ALLOW_ErrorCount := COUNT(GROUP,h.remove_port_dt_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.country_code_Invalid,le.phone_Invalid,le.dial_type_Invalid,le.spid_Invalid,le.service_type_Invalid,le.routing_code_Invalid,le.porting_dt_Invalid,le.country_abbr_Invalid,le.filename_Invalid,le.file_dt_time_Invalid,le.vendor_first_reported_dt_Invalid,le.vendor_last_reported_dt_Invalid,le.port_start_dt_Invalid,le.port_end_dt_Invalid,le.remove_port_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,iConectivMain_Fields.InvalidMessage_country_code(le.country_code_Invalid),iConectivMain_Fields.InvalidMessage_phone(le.phone_Invalid),iConectivMain_Fields.InvalidMessage_dial_type(le.dial_type_Invalid),iConectivMain_Fields.InvalidMessage_spid(le.spid_Invalid),iConectivMain_Fields.InvalidMessage_service_type(le.service_type_Invalid),iConectivMain_Fields.InvalidMessage_routing_code(le.routing_code_Invalid),iConectivMain_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),iConectivMain_Fields.InvalidMessage_country_abbr(le.country_abbr_Invalid),iConectivMain_Fields.InvalidMessage_filename(le.filename_Invalid),iConectivMain_Fields.InvalidMessage_file_dt_time(le.file_dt_time_Invalid),iConectivMain_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),iConectivMain_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),iConectivMain_Fields.InvalidMessage_port_start_dt(le.port_start_dt_Invalid),iConectivMain_Fields.InvalidMessage_port_end_dt(le.port_end_dt_Invalid),iConectivMain_Fields.InvalidMessage_remove_port_dt(le.remove_port_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dial_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.service_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_abbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_dt_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.port_start_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.port_end_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.remove_port_dt_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename','file_dt_time','vendor_first_reported_dt','vendor_last_reported_dt','port_start_dt','port_end_dt','remove_port_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_DCT','Invalid_Num','Invalid_TOS','Invalid_Num_Blank','Invalid_Port_Date','Invalid_ISO2','Invalid_Filename','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.country_code,(SALT33.StrType)le.phone,(SALT33.StrType)le.dial_type,(SALT33.StrType)le.spid,(SALT33.StrType)le.service_type,(SALT33.StrType)le.routing_code,(SALT33.StrType)le.porting_dt,(SALT33.StrType)le.country_abbr,(SALT33.StrType)le.filename,(SALT33.StrType)le.file_dt_time,(SALT33.StrType)le.vendor_first_reported_dt,(SALT33.StrType)le.vendor_last_reported_dt,(SALT33.StrType)le.port_start_dt,(SALT33.StrType)le.port_end_dt,(SALT33.StrType)le.remove_port_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,15,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'country_code:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'dial_type:Invalid_DCT:ALLOW'
          ,'spid:Invalid_Num:ALLOW'
          ,'service_type:Invalid_TOS:ALLOW'
          ,'routing_code:Invalid_Num_Blank:ALLOW'
          ,'porting_dt:Invalid_Port_Date:ALLOW'
          ,'country_abbr:Invalid_ISO2:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'file_dt_time:Invalid_Num:ALLOW'
          ,'vendor_first_reported_dt:Invalid_Num:ALLOW'
          ,'vendor_last_reported_dt:Invalid_Num:ALLOW'
          ,'port_start_dt:Invalid_Num:ALLOW'
          ,'port_end_dt:Invalid_Num:ALLOW'
          ,'remove_port_dt:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,iConectivMain_Fields.InvalidMessage_country_code(1)
          ,iConectivMain_Fields.InvalidMessage_phone(1)
          ,iConectivMain_Fields.InvalidMessage_dial_type(1)
          ,iConectivMain_Fields.InvalidMessage_spid(1)
          ,iConectivMain_Fields.InvalidMessage_service_type(1)
          ,iConectivMain_Fields.InvalidMessage_routing_code(1)
          ,iConectivMain_Fields.InvalidMessage_porting_dt(1)
          ,iConectivMain_Fields.InvalidMessage_country_abbr(1)
          ,iConectivMain_Fields.InvalidMessage_filename(1)
          ,iConectivMain_Fields.InvalidMessage_file_dt_time(1)
          ,iConectivMain_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,iConectivMain_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,iConectivMain_Fields.InvalidMessage_port_start_dt(1)
          ,iConectivMain_Fields.InvalidMessage_port_end_dt(1)
          ,iConectivMain_Fields.InvalidMessage_remove_port_dt(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.country_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.service_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.file_dt_time_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.port_start_dt_ALLOW_ErrorCount
          ,le.port_end_dt_ALLOW_ErrorCount
          ,le.remove_port_dt_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.country_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.service_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.file_dt_time_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.port_start_dt_ALLOW_ErrorCount
          ,le.port_end_dt_ALLOW_ErrorCount
          ,le.remove_port_dt_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,15,Into(LEFT,COUNTER));
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
