IMPORT SALT37;
EXPORT HHID_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(HHID_Layout_HHID)
    UNSIGNED1 gc_id_Invalid;
    UNSIGNED1 sub_account_id_Invalid;
    UNSIGNED1 hh_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(HHID_Layout_HHID)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(HHID_Layout_HHID) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.gc_id_Invalid := HHID_Fields.InValid_gc_id((SALT37.StrType)le.gc_id);
    SELF.sub_account_id_Invalid := HHID_Fields.InValid_sub_account_id((SALT37.StrType)le.sub_account_id);
    SELF.hh_id_Invalid := HHID_Fields.InValid_hh_id((SALT37.StrType)le.hh_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),HHID_Layout_HHID);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.gc_id_Invalid << 0 ) + ( le.sub_account_id_Invalid << 1 ) + ( le.hh_id_Invalid << 2 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,HHID_Layout_HHID);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.gc_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.sub_account_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.hh_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    gc_id_ALLOW_ErrorCount := COUNT(GROUP,h.gc_id_Invalid=1);
    sub_account_id_ALLOW_ErrorCount := COUNT(GROUP,h.sub_account_id_Invalid=1);
    hh_id_ALLOW_ErrorCount := COUNT(GROUP,h.hh_id_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.gc_id_Invalid,le.sub_account_id_Invalid,le.hh_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,HHID_Fields.InvalidMessage_gc_id(le.gc_id_Invalid),HHID_Fields.InvalidMessage_sub_account_id(le.sub_account_id_Invalid),HHID_Fields.InvalidMessage_hh_id(le.hh_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.gc_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sub_account_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hh_id_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'gc_id','sub_account_id','hh_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_alphanumeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.gc_id,(SALT37.StrType)le.sub_account_id,(SALT37.StrType)le.hh_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,3,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'gc_id:invalid_numeric:ALLOW'
          ,'sub_account_id:invalid_alphanumeric:ALLOW'
          ,'hh_id:invalid_numeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,HHID_Fields.InvalidMessage_gc_id(1)
          ,HHID_Fields.InvalidMessage_sub_account_id(1)
          ,HHID_Fields.InvalidMessage_hh_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.gc_id_ALLOW_ErrorCount
          ,le.sub_account_id_ALLOW_ErrorCount
          ,le.hh_id_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.gc_id_ALLOW_ErrorCount
          ,le.sub_account_id_ALLOW_ErrorCount
          ,le.hh_id_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,3,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
