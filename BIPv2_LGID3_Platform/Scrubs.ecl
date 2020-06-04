IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_LGID3)
    UNSIGNED1 nodes_below_st_Invalid;
    UNSIGNED1 company_name_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LGID3)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_LGID3) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.nodes_below_st_Invalid := Fields.InValid_nodes_below_st((SALT30.StrType)le.nodes_below_st);
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT30.StrType)le.company_name);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.nodes_below_st_Invalid << 0 ) + ( le.company_name_Invalid << 1 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_LGID3);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.nodes_below_st_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.rcid=RIGHT.rcid AND (LEFT.nodes_below_st_Invalid <> RIGHT.nodes_below_st_Invalid OR LEFT.company_name_Invalid <> RIGHT.company_name_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source;
    TotalCnt := COUNT(GROUP); // Number of records in total
    nodes_below_st_ENUM_ErrorCount := COUNT(GROUP,h.nodes_below_st_Invalid=1);
    company_name_LENGTH_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.nodes_below_st_Invalid,le.company_name_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_nodes_below_st(le.nodes_below_st_Invalid),Fields.InvalidMessage_company_name(le.company_name_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.nodes_below_st_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'nodes_below_st','company_name','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'not_hrchy_parent','Noblanks','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.nodes_below_st,(SALT30.StrType)le.company_name,'***SALTBUG***');
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
          ,'nodes_below_st:not_hrchy_parent:ENUM'
          ,'company_name:Noblanks:LENGTH','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.nodes_below_st_ENUM_ErrorCount
          ,le.company_name_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.nodes_below_st_ENUM_ErrorCount
          ,le.company_name_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,2,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF.ErrorMessage := ri.ErrorMessage;
   SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
