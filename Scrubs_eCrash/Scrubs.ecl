IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_eCrash)
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 case_identifier_Invalid;
    UNSIGNED1 crash_date_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 death_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_eCrash)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_eCrash) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen);
    SELF.case_identifier_Invalid := Fields.InValid_case_identifier((SALT30.StrType)le.case_identifier);
    SELF.crash_date_Invalid := Fields.InValid_crash_date((SALT30.StrType)le.crash_date);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT30.StrType)le.last_name);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT30.StrType)le.first_name);
    SELF.middle_name_Invalid := Fields.InValid_middle_name((SALT30.StrType)le.middle_name);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT30.StrType)le.date_of_birth);
    SELF.death_date_Invalid := Fields.InValid_death_date((SALT30.StrType)le.death_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_vendor_first_reported_Invalid << 0 ) + ( le.date_vendor_last_reported_Invalid << 1 ) + ( le.dt_first_seen_Invalid << 2 ) + ( le.dt_last_seen_Invalid << 3 ) + ( le.case_identifier_Invalid << 4 ) + ( le.crash_date_Invalid << 6 ) + ( le.last_name_Invalid << 7 ) + ( le.first_name_Invalid << 9 ) + ( le.middle_name_Invalid << 11 ) + ( le.date_of_birth_Invalid << 13 ) + ( le.death_date_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_eCrash);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.case_identifier_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.crash_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.death_date_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.report_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    case_identifier_ALLOW_ErrorCount := COUNT(GROUP,h.case_identifier_Invalid=1);
    case_identifier_LENGTH_ErrorCount := COUNT(GROUP,h.case_identifier_Invalid=2);
    case_identifier_Total_ErrorCount := COUNT(GROUP,h.case_identifier_Invalid>0);
    crash_date_ALLOW_ErrorCount := COUNT(GROUP,h.crash_date_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_Invalid=2);
    last_name_Total_ErrorCount := COUNT(GROUP,h.last_name_Invalid>0);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=2);
    first_name_Total_ErrorCount := COUNT(GROUP,h.first_name_Invalid>0);
    middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    middle_name_LENGTH_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=2);
    middle_name_Total_ErrorCount := COUNT(GROUP,h.middle_name_Invalid>0);
    date_of_birth_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    death_date_ALLOW_ErrorCount := COUNT(GROUP,h.death_date_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,report_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.report_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.case_identifier_Invalid,le.crash_date_Invalid,le.last_name_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.date_of_birth_Invalid,le.death_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_case_identifier(le.case_identifier_Invalid),Fields.InvalidMessage_crash_date(le.crash_date_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_death_date(le.death_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_identifier_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.crash_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.death_date_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_vendor_first_reported','date_vendor_last_reported','dt_first_seen','dt_last_seen','case_identifier','crash_date','last_name','first_name','middle_name','date_of_birth','death_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_case','invalid_date','invalid_name','invalid_name','invalid_name','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.date_vendor_first_reported,(SALT30.StrType)le.date_vendor_last_reported,(SALT30.StrType)le.dt_first_seen,(SALT30.StrType)le.dt_last_seen,(SALT30.StrType)le.case_identifier,(SALT30.StrType)le.crash_date,(SALT30.StrType)le.last_name,(SALT30.StrType)le.first_name,(SALT30.StrType)le.middle_name,(SALT30.StrType)le.date_of_birth,(SALT30.StrType)le.death_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.report_code;
      SELF.ruledesc := CHOOSE(c
          ,'date_vendor_first_reported:invalid_date:ALLOW'
          ,'date_vendor_last_reported:invalid_date:ALLOW'
          ,'dt_first_seen:invalid_date:ALLOW'
          ,'dt_last_seen:invalid_date:ALLOW'
          ,'case_identifier:invalid_case:ALLOW','case_identifier:invalid_case:LENGTH'
          ,'crash_date:invalid_date:ALLOW'
          ,'last_name:invalid_name:ALLOW','last_name:invalid_name:LENGTH'
          ,'first_name:invalid_name:ALLOW','first_name:invalid_name:LENGTH'
          ,'middle_name:invalid_name:ALLOW','middle_name:invalid_name:LENGTH'
          ,'date_of_birth:invalid_date:ALLOW'
          ,'death_date:invalid_date:ALLOW','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.case_identifier_ALLOW_ErrorCount,le.case_identifier_LENGTH_ErrorCount
          ,le.crash_date_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount,le.middle_name_LENGTH_ErrorCount
          ,le.date_of_birth_ALLOW_ErrorCount
          ,le.death_date_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.case_identifier_ALLOW_ErrorCount,le.case_identifier_LENGTH_ErrorCount
          ,le.crash_date_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount,le.middle_name_LENGTH_ErrorCount
          ,le.date_of_birth_ALLOW_ErrorCount
          ,le.death_date_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,15,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
