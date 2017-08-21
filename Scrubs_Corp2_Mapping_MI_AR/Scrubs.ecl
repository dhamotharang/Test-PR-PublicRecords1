IMPORT CORP2_MAPPING,SALT34;
IMPORT Scrubs,Scrubs_Corp2_Mapping_MI_AR; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.AR)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_sos_charter_nbr_Invalid;
    UNSIGNED1 ar_year_Invalid;
    UNSIGNED1 ar_due_dt_Invalid;
    UNSIGNED1 ar_filed_dt_Invalid;
    UNSIGNED1 ar_roll_Invalid;
    UNSIGNED1 ar_frame_Invalid;
    UNSIGNED1 ar_extension_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.AR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.AR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT34.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT34.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT34.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT34.StrType)le.corp_process_date);
    SELF.corp_sos_charter_nbr_Invalid := Fields.InValid_corp_sos_charter_nbr((SALT34.StrType)le.corp_sos_charter_nbr);
    SELF.ar_year_Invalid := Fields.InValid_ar_year((SALT34.StrType)le.ar_year);
    SELF.ar_due_dt_Invalid := Fields.InValid_ar_due_dt((SALT34.StrType)le.ar_due_dt);
    SELF.ar_filed_dt_Invalid := Fields.InValid_ar_filed_dt((SALT34.StrType)le.ar_filed_dt);
    SELF.ar_roll_Invalid := Fields.InValid_ar_roll((SALT34.StrType)le.ar_roll);
    SELF.ar_frame_Invalid := Fields.InValid_ar_frame((SALT34.StrType)le.ar_frame);
    SELF.ar_extension_Invalid := Fields.InValid_ar_extension((SALT34.StrType)le.ar_extension);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.AR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 2 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 4 ) + ( le.corp_sos_charter_nbr_Invalid << 6 ) + ( le.ar_year_Invalid << 8 ) + ( le.ar_due_dt_Invalid << 9 ) + ( le.ar_filed_dt_Invalid << 11 ) + ( le.ar_roll_Invalid << 13 ) + ( le.ar_frame_Invalid << 14 ) + ( le.ar_extension_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.AR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.corp_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.ar_year_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.ar_due_dt_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.ar_filed_dt_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.ar_roll_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.ar_frame_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.ar_extension_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT)) : independent;
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=1);
    corp_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=2);
    corp_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid>0);
    ar_year_ALLOW_ErrorCount := COUNT(GROUP,h.ar_year_Invalid=1);
    ar_due_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid=1);
    ar_due_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid=2);
    ar_due_dt_Total_ErrorCount := COUNT(GROUP,h.ar_due_dt_Invalid>0);
    ar_filed_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_filed_dt_Invalid=1);
    ar_filed_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_filed_dt_Invalid=2);
    ar_filed_dt_Total_ErrorCount := COUNT(GROUP,h.ar_filed_dt_Invalid>0);
    ar_roll_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_roll_Invalid=1);
    ar_frame_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_frame_Invalid=1);
    ar_extension_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_extension_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r) : independent;
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_sos_charter_nbr_Invalid,le.ar_year_Invalid,le.ar_due_dt_Invalid,le.ar_filed_dt_Invalid,le.ar_roll_Invalid,le.ar_frame_Invalid,le.ar_extension_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_sos_charter_nbr(le.corp_sos_charter_nbr_Invalid),Fields.InvalidMessage_ar_year(le.ar_year_Invalid),Fields.InvalidMessage_ar_due_dt(le.ar_due_dt_Invalid),Fields.InvalidMessage_ar_filed_dt(le.ar_filed_dt_Invalid),Fields.InvalidMessage_ar_roll(le.ar_roll_Invalid),Fields.InvalidMessage_ar_frame(le.ar_frame_Invalid),Fields.InvalidMessage_ar_extension(le.ar_extension_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ar_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_due_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.ar_filed_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.ar_roll_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ar_frame_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ar_extension_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_due_dt','ar_filed_dt','ar_roll','ar_frame','ar_extension','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_numeric','invalid_future_date','invalid_date','invalid_roll','invalid_frame','invalid_extension','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.corp_key,(SALT34.StrType)le.corp_vendor,(SALT34.StrType)le.corp_state_origin,(SALT34.StrType)le.corp_process_date,(SALT34.StrType)le.corp_sos_charter_nbr,(SALT34.StrType)le.ar_year,(SALT34.StrType)le.ar_due_dt,(SALT34.StrType)le.ar_filed_dt,(SALT34.StrType)le.ar_roll,(SALT34.StrType)le.ar_frame,(SALT34.StrType)le.ar_extension,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM'
          ,'corp_sos_charter_nbr:invalid_charter_nbr:ALLOW','corp_sos_charter_nbr:invalid_charter_nbr:LENGTH'
          ,'ar_year:invalid_numeric:ALLOW'
          ,'ar_due_dt:invalid_future_date:ALLOW','ar_due_dt:invalid_future_date:CUSTOM'
          ,'ar_filed_dt:invalid_date:ALLOW','ar_filed_dt:invalid_date:CUSTOM'
          ,'ar_roll:invalid_roll:CUSTOM'
          ,'ar_frame:invalid_frame:CUSTOM'
          ,'ar_extension:invalid_extension:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2)
          ,Fields.InvalidMessage_corp_sos_charter_nbr(1),Fields.InvalidMessage_corp_sos_charter_nbr(2)
          ,Fields.InvalidMessage_ar_year(1)
          ,Fields.InvalidMessage_ar_due_dt(1),Fields.InvalidMessage_ar_due_dt(2)
          ,Fields.InvalidMessage_ar_filed_dt(1),Fields.InvalidMessage_ar_filed_dt(2)
          ,Fields.InvalidMessage_ar_roll(1)
          ,Fields.InvalidMessage_ar_frame(1)
          ,Fields.InvalidMessage_ar_extension(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.ar_year_ALLOW_ErrorCount
          ,le.ar_due_dt_ALLOW_ErrorCount,le.ar_due_dt_CUSTOM_ErrorCount
          ,le.ar_filed_dt_ALLOW_ErrorCount,le.ar_filed_dt_CUSTOM_ErrorCount
          ,le.ar_roll_CUSTOM_ErrorCount
          ,le.ar_frame_CUSTOM_ErrorCount
          ,le.ar_extension_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTH_ErrorCount
          ,le.ar_year_ALLOW_ErrorCount
          ,le.ar_due_dt_ALLOW_ErrorCount,le.ar_due_dt_CUSTOM_ErrorCount
          ,le.ar_filed_dt_ALLOW_ErrorCount,le.ar_filed_dt_CUSTOM_ErrorCount
          ,le.ar_roll_CUSTOM_ErrorCount
          ,le.ar_frame_CUSTOM_ErrorCount
          ,le.ar_extension_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,16,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
