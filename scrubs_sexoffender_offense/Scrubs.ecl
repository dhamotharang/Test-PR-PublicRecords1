IMPORT ut,SALT33;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_sexoffender_offense)
    UNSIGNED1 conviction_date_Invalid;
    UNSIGNED1 offense_date_Invalid;
    UNSIGNED1 victim_age_Invalid;
    UNSIGNED1 arrest_date_Invalid;
    UNSIGNED1 conviction_override_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_sexoffender_offense)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_sexoffender_offense) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.conviction_date_Invalid := Fields.InValid_conviction_date((SALT33.StrType)le.conviction_date);
    SELF.offense_date_Invalid := Fields.InValid_offense_date((SALT33.StrType)le.offense_date);
    SELF.victim_age_Invalid := Fields.InValid_victim_age((SALT33.StrType)le.victim_age);
    SELF.arrest_date_Invalid := Fields.InValid_arrest_date((SALT33.StrType)le.arrest_date);
    SELF.conviction_override_date_Invalid := Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_sexoffender_offense);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.conviction_date_Invalid << 0 ) + ( le.offense_date_Invalid << 1 ) + ( le.victim_age_Invalid << 2 ) + ( le.arrest_date_Invalid << 3 ) + ( le.conviction_override_date_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_sexoffender_offense);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.conviction_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.offense_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.victim_age_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.arrest_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.conviction_override_date_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.orig_state_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    conviction_date_ALLOW_ErrorCount := COUNT(GROUP,h.conviction_date_Invalid=1);
    offense_date_ALLOW_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=1);
    victim_age_ALLOW_ErrorCount := COUNT(GROUP,h.victim_age_Invalid=1);
    arrest_date_ALLOW_ErrorCount := COUNT(GROUP,h.arrest_date_Invalid=1);
    conviction_override_date_ALLOW_ErrorCount := COUNT(GROUP,h.conviction_override_date_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,orig_state_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.orig_state_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.conviction_date_Invalid,le.offense_date_Invalid,le.victim_age_Invalid,le.arrest_date_Invalid,le.conviction_override_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_conviction_date(le.conviction_date_Invalid),Fields.InvalidMessage_offense_date(le.offense_date_Invalid),Fields.InvalidMessage_victim_age(le.victim_age_Invalid),Fields.InvalidMessage_arrest_date(le.arrest_date_Invalid),Fields.InvalidMessage_conviction_override_date(le.conviction_override_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.conviction_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.victim_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.arrest_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'conviction_date','offense_date','victim_age','arrest_date','conviction_override_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_age','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.conviction_date,(SALT33.StrType)le.offense_date,(SALT33.StrType)le.victim_age,(SALT33.StrType)le.arrest_date,(SALT33.StrType)le.conviction_override_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.orig_state_code;
      SELF.ruledesc := CHOOSE(c
          ,'conviction_date:invalid_date:ALLOW'
          ,'offense_date:invalid_date:ALLOW'
          ,'victim_age:invalid_age:ALLOW'
          ,'arrest_date:invalid_date:ALLOW'
          ,'conviction_override_date:invalid_date:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_conviction_date(1)
          ,Fields.InvalidMessage_offense_date(1)
          ,Fields.InvalidMessage_victim_age(1)
          ,Fields.InvalidMessage_arrest_date(1)
          ,Fields.InvalidMessage_conviction_override_date(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.conviction_date_ALLOW_ErrorCount
          ,le.offense_date_ALLOW_ErrorCount
          ,le.victim_age_ALLOW_ErrorCount
          ,le.arrest_date_ALLOW_ErrorCount
          ,le.conviction_override_date_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.conviction_date_ALLOW_ErrorCount
          ,le.offense_date_ALLOW_ErrorCount
          ,le.victim_age_ALLOW_ErrorCount
          ,le.arrest_date_ALLOW_ErrorCount
          ,le.conviction_override_date_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,5,Into(LEFT,COUNTER));
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
