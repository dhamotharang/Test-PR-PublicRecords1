IMPORT SALT37;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_LocationId)
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip5_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LocationId)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_LocationId) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.st_Invalid := Fields.InValid_st((SALT37.StrType)le.st);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT37.StrType)le.zip5);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_LocationId);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.st_Invalid << 0 ) + ( le.zip5_Invalid << 2 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_LocationId);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.st_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rid=RIGHT.rid AND (LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip5_Invalid <> RIGHT.zip5_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTH_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.st_Invalid,le.zip5_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'st','zip5','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'alpha_st','zip5','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.st,(SALT37.StrType)le.zip5,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,2,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'st:alpha_st:ALLOW','st:alpha_st:LENGTH'
          ,'zip5:zip5:ALLOW','zip5:zip5:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip5(1),Fields.InvalidMessage_zip5(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,4,Into(LEFT,COUNTER));
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
