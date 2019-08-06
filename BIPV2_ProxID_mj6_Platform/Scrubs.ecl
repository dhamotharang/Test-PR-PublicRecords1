IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_DOT_Base)
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_DOT_Base)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_DOT_Base) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.st_Invalid := Fields.InValid_st((SALT30.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT30.StrType)le.zip);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.st_Invalid << 0 ) + ( le.zip_Invalid << 2 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_DOT_Base);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.st_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    st_CAPS_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,source,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.st_Invalid,le.zip_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'st','zip','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'alpha','number','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.st,(SALT30.StrType)le.zip,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,2,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source;
      SELF.ruledesc := CHOOSE(c
          ,'st:alpha:CAPS','st:alpha:ALLOW'
          ,'zip:number:ALLOW','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.st_CAPS_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,3,Into(LEFT,COUNTER));
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
