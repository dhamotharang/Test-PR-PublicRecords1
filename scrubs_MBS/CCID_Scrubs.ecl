IMPORT SALT37;
EXPORT CCID_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(CCID_Layout_CCID)
    UNSIGNED1 cc_id_Invalid;
    UNSIGNED1 gc_id_Invalid;
    UNSIGNED1 account_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CCID_Layout_CCID)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(CCID_Layout_CCID) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.cc_id_Invalid := CCID_Fields.InValid_cc_id((SALT37.StrType)le.cc_id);
    SELF.gc_id_Invalid := CCID_Fields.InValid_gc_id((SALT37.StrType)le.gc_id);
    SELF.account_id_Invalid := CCID_Fields.InValid_account_id((SALT37.StrType)le.account_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),CCID_Layout_CCID);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.cc_id_Invalid << 0 ) + ( le.gc_id_Invalid << 1 ) + ( le.account_id_Invalid << 2 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,CCID_Layout_CCID);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.cc_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.gc_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.account_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    cc_id_ALLOW_ErrorCount := COUNT(GROUP,h.cc_id_Invalid=1);
    gc_id_ALLOW_ErrorCount := COUNT(GROUP,h.gc_id_Invalid=1);
    account_id_ALLOW_ErrorCount := COUNT(GROUP,h.account_id_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.cc_id_Invalid,le.gc_id_Invalid,le.account_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CCID_Fields.InvalidMessage_cc_id(le.cc_id_Invalid),CCID_Fields.InvalidMessage_gc_id(le.gc_id_Invalid),CCID_Fields.InvalidMessage_account_id(le.account_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.cc_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gc_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.account_id_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'cc_id','gc_id','account_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.cc_id,(SALT37.StrType)le.gc_id,(SALT37.StrType)le.account_id,'***SALTBUG***');
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
          ,'cc_id:invalid_numeric:ALLOW'
          ,'gc_id:invalid_numeric:ALLOW'
          ,'account_id:invalid_alphanumeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,CCID_Fields.InvalidMessage_cc_id(1)
          ,CCID_Fields.InvalidMessage_gc_id(1)
          ,CCID_Fields.InvalidMessage_account_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.cc_id_ALLOW_ErrorCount
          ,le.gc_id_ALLOW_ErrorCount
          ,le.account_id_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.cc_id_ALLOW_ErrorCount
          ,le.gc_id_ALLOW_ErrorCount
          ,le.account_id_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
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
