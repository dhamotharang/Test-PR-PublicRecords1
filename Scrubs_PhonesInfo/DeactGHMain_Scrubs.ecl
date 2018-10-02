IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT DeactGHMain_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(DeactGHMain_Layout_Phonesinfo)
    UNSIGNED1 groupid_Invalid;
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 deact_code_Invalid;
    UNSIGNED1 deact_start_dt_Invalid;
    UNSIGNED1 deact_end_dt_Invalid;
    UNSIGNED1 react_start_dt_Invalid;
    UNSIGNED1 react_end_dt_Invalid;
    UNSIGNED1 is_react_Invalid;
    UNSIGNED1 is_deact_Invalid;
    UNSIGNED1 porting_dt_Invalid;
    UNSIGNED1 days_apart_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DeactGHMain_Layout_Phonesinfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DeactGHMain_Layout_Phonesinfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.groupid_Invalid := DeactGHMain_Fields.InValid_groupid((SALT36.StrType)le.groupid);
    SELF.vendor_first_reported_dt_Invalid := DeactGHMain_Fields.InValid_vendor_first_reported_dt((SALT36.StrType)le.vendor_first_reported_dt);
    SELF.vendor_last_reported_dt_Invalid := DeactGHMain_Fields.InValid_vendor_last_reported_dt((SALT36.StrType)le.vendor_last_reported_dt);
    SELF.timestamp_Invalid := DeactGHMain_Fields.InValid_timestamp((SALT36.StrType)le.timestamp);
    SELF.phone_Invalid := DeactGHMain_Fields.InValid_phone((SALT36.StrType)le.phone);
    SELF.phone_swap_Invalid := DeactGHMain_Fields.InValid_phone_swap((SALT36.StrType)le.phone_swap);
    SELF.filedate_Invalid := DeactGHMain_Fields.InValid_filedate((SALT36.StrType)le.filedate);
    SELF.deact_code_Invalid := DeactGHMain_Fields.InValid_deact_code((SALT36.StrType)le.deact_code);
    SELF.deact_start_dt_Invalid := DeactGHMain_Fields.InValid_deact_start_dt((SALT36.StrType)le.deact_start_dt);
    SELF.deact_end_dt_Invalid := DeactGHMain_Fields.InValid_deact_end_dt((SALT36.StrType)le.deact_end_dt);
    SELF.react_start_dt_Invalid := DeactGHMain_Fields.InValid_react_start_dt((SALT36.StrType)le.react_start_dt);
    SELF.react_end_dt_Invalid := DeactGHMain_Fields.InValid_react_end_dt((SALT36.StrType)le.react_end_dt);
    SELF.is_react_Invalid := DeactGHMain_Fields.InValid_is_react((SALT36.StrType)le.is_react);
    SELF.is_deact_Invalid := DeactGHMain_Fields.InValid_is_deact((SALT36.StrType)le.is_deact);
    SELF.porting_dt_Invalid := DeactGHMain_Fields.InValid_porting_dt((SALT36.StrType)le.porting_dt);
    SELF.days_apart_Invalid := DeactGHMain_Fields.InValid_days_apart((SALT36.StrType)le.days_apart);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DeactGHMain_Layout_Phonesinfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.groupid_Invalid << 0 ) + ( le.vendor_first_reported_dt_Invalid << 1 ) + ( le.vendor_last_reported_dt_Invalid << 2 ) + ( le.timestamp_Invalid << 3 ) + ( le.phone_Invalid << 4 ) + ( le.phone_swap_Invalid << 5 ) + ( le.filedate_Invalid << 6 ) + ( le.deact_code_Invalid << 7 ) + ( le.deact_start_dt_Invalid << 8 ) + ( le.deact_end_dt_Invalid << 9 ) + ( le.react_start_dt_Invalid << 10 ) + ( le.react_end_dt_Invalid << 11 ) + ( le.is_react_Invalid << 12 ) + ( le.is_deact_Invalid << 13 ) + ( le.porting_dt_Invalid << 14 ) + ( le.days_apart_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DeactGHMain_Layout_Phonesinfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.groupid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.deact_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.deact_start_dt_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.deact_end_dt_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.react_start_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.react_end_dt_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.is_react_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.is_deact_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.days_apart_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    groupid_ALLOW_ErrorCount := COUNT(GROUP,h.groupid_Invalid=1);
    vendor_first_reported_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_last_reported_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    timestamp_ALLOW_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    filedate_CUSTOM_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    deact_code_ENUM_ErrorCount := COUNT(GROUP,h.deact_code_Invalid=1);
    deact_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deact_start_dt_Invalid=1);
    deact_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deact_end_dt_Invalid=1);
    react_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.react_start_dt_Invalid=1);
    react_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.react_end_dt_Invalid=1);
    is_react_ENUM_ErrorCount := COUNT(GROUP,h.is_react_Invalid=1);
    is_deact_ENUM_ErrorCount := COUNT(GROUP,h.is_deact_Invalid=1);
    porting_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    days_apart_ALLOW_ErrorCount := COUNT(GROUP,h.days_apart_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.groupid_Invalid,le.vendor_first_reported_dt_Invalid,le.vendor_last_reported_dt_Invalid,le.timestamp_Invalid,le.phone_Invalid,le.phone_swap_Invalid,le.filedate_Invalid,le.deact_code_Invalid,le.deact_start_dt_Invalid,le.deact_end_dt_Invalid,le.react_start_dt_Invalid,le.react_end_dt_Invalid,le.is_react_Invalid,le.is_deact_Invalid,le.porting_dt_Invalid,le.days_apart_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DeactGHMain_Fields.InvalidMessage_groupid(le.groupid_Invalid),DeactGHMain_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),DeactGHMain_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),DeactGHMain_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),DeactGHMain_Fields.InvalidMessage_phone(le.phone_Invalid),DeactGHMain_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),DeactGHMain_Fields.InvalidMessage_filedate(le.filedate_Invalid),DeactGHMain_Fields.InvalidMessage_deact_code(le.deact_code_Invalid),DeactGHMain_Fields.InvalidMessage_deact_start_dt(le.deact_start_dt_Invalid),DeactGHMain_Fields.InvalidMessage_deact_end_dt(le.deact_end_dt_Invalid),DeactGHMain_Fields.InvalidMessage_react_start_dt(le.react_start_dt_Invalid),DeactGHMain_Fields.InvalidMessage_react_end_dt(le.react_end_dt_Invalid),DeactGHMain_Fields.InvalidMessage_is_react(le.is_react_Invalid),DeactGHMain_Fields.InvalidMessage_is_deact(le.is_deact_Invalid),DeactGHMain_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),DeactGHMain_Fields.InvalidMessage_days_apart(le.days_apart_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.groupid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.timestamp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deact_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.deact_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deact_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.react_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.react_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.is_react_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.is_deact_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.days_apart_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'groupid','vendor_first_reported_dt','vendor_last_reported_dt','timestamp','phone','phone_swap','filedate','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','days_apart','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_DeactCode','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_YN','Invalid_YN','Invalid_Date','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.groupid,(SALT36.StrType)le.vendor_first_reported_dt,(SALT36.StrType)le.vendor_last_reported_dt,(SALT36.StrType)le.timestamp,(SALT36.StrType)le.phone,(SALT36.StrType)le.phone_swap,(SALT36.StrType)le.filedate,(SALT36.StrType)le.deact_code,(SALT36.StrType)le.deact_start_dt,(SALT36.StrType)le.deact_end_dt,(SALT36.StrType)le.react_start_dt,(SALT36.StrType)le.react_end_dt,(SALT36.StrType)le.is_react,(SALT36.StrType)le.is_deact,(SALT36.StrType)le.porting_dt,(SALT36.StrType)le.days_apart,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,16,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'groupid:Invalid_Num:ALLOW'
          ,'vendor_first_reported_dt:Invalid_Date:CUSTOM'
          ,'vendor_last_reported_dt:Invalid_Date:CUSTOM'
          ,'timestamp:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'phone_swap:Invalid_Num:ALLOW'
          ,'filedate:Invalid_Date:CUSTOM'
          ,'deact_code:Invalid_DeactCode:ENUM'
          ,'deact_start_dt:Invalid_Date:CUSTOM'
          ,'deact_end_dt:Invalid_Date:CUSTOM'
          ,'react_start_dt:Invalid_Date:CUSTOM'
          ,'react_end_dt:Invalid_Date:CUSTOM'
          ,'is_react:Invalid_YN:ENUM'
          ,'is_deact:Invalid_YN:ENUM'
          ,'porting_dt:Invalid_Date:CUSTOM'
          ,'days_apart:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DeactGHMain_Fields.InvalidMessage_groupid(1)
          ,DeactGHMain_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_timestamp(1)
          ,DeactGHMain_Fields.InvalidMessage_phone(1)
          ,DeactGHMain_Fields.InvalidMessage_phone_swap(1)
          ,DeactGHMain_Fields.InvalidMessage_filedate(1)
          ,DeactGHMain_Fields.InvalidMessage_deact_code(1)
          ,DeactGHMain_Fields.InvalidMessage_deact_start_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_deact_end_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_react_start_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_react_end_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_is_react(1)
          ,DeactGHMain_Fields.InvalidMessage_is_deact(1)
          ,DeactGHMain_Fields.InvalidMessage_porting_dt(1)
          ,DeactGHMain_Fields.InvalidMessage_days_apart(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.groupid_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_last_reported_dt_CUSTOM_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filedate_CUSTOM_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_CUSTOM_ErrorCount
          ,le.deact_end_dt_CUSTOM_ErrorCount
          ,le.react_start_dt_CUSTOM_ErrorCount
          ,le.react_end_dt_CUSTOM_ErrorCount
          ,le.is_react_ENUM_ErrorCount
          ,le.is_deact_ENUM_ErrorCount
          ,le.porting_dt_CUSTOM_ErrorCount
          ,le.days_apart_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.groupid_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_last_reported_dt_CUSTOM_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filedate_CUSTOM_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_CUSTOM_ErrorCount
          ,le.deact_end_dt_CUSTOM_ErrorCount
          ,le.react_start_dt_CUSTOM_ErrorCount
          ,le.react_end_dt_CUSTOM_ErrorCount
          ,le.is_react_ENUM_ErrorCount
          ,le.is_deact_ENUM_ErrorCount
          ,le.porting_dt_CUSTOM_ErrorCount
          ,le.days_apart_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,16,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
