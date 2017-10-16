IMPORT SALT37;
EXPORT TableCol_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(TableCol_Layout_TableCol)
    UNSIGNED1 table_column_id_Invalid;
    UNSIGNED1 table_name_Invalid;
    UNSIGNED1 column_name_Invalid;
    UNSIGNED1 is_column_value_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(TableCol_Layout_TableCol)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(TableCol_Layout_TableCol) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.table_column_id_Invalid := TableCol_Fields.InValid_table_column_id((SALT37.StrType)le.table_column_id);
    SELF.table_name_Invalid := TableCol_Fields.InValid_table_name((SALT37.StrType)le.table_name);
    SELF.column_name_Invalid := TableCol_Fields.InValid_column_name((SALT37.StrType)le.column_name);
    SELF.is_column_value_Invalid := TableCol_Fields.InValid_is_column_value((SALT37.StrType)le.is_column_value);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),TableCol_Layout_TableCol);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.table_column_id_Invalid << 0 ) + ( le.table_name_Invalid << 1 ) + ( le.column_name_Invalid << 2 ) + ( le.is_column_value_Invalid << 3 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,TableCol_Layout_TableCol);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.table_column_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.table_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.column_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.is_column_value_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    table_column_id_ALLOW_ErrorCount := COUNT(GROUP,h.table_column_id_Invalid=1);
    table_name_ALLOW_ErrorCount := COUNT(GROUP,h.table_name_Invalid=1);
    column_name_ALLOW_ErrorCount := COUNT(GROUP,h.column_name_Invalid=1);
    is_column_value_ALLOW_ErrorCount := COUNT(GROUP,h.is_column_value_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.table_column_id_Invalid,le.table_name_Invalid,le.column_name_Invalid,le.is_column_value_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,TableCol_Fields.InvalidMessage_table_column_id(le.table_column_id_Invalid),TableCol_Fields.InvalidMessage_table_name(le.table_name_Invalid),TableCol_Fields.InvalidMessage_column_name(le.column_name_Invalid),TableCol_Fields.InvalidMessage_is_column_value(le.is_column_value_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.table_column_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.table_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.column_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_column_value_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'table_column_id','table_name','column_name','is_column_value','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.table_column_id,(SALT37.StrType)le.table_name,(SALT37.StrType)le.column_name,(SALT37.StrType)le.is_column_value,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'table_column_id:invalid_numeric:ALLOW'
          ,'table_name:invalid_alphanumeric:ALLOW'
          ,'column_name:invalid_alphanumeric:ALLOW'
          ,'is_column_value:invalid_numeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,TableCol_Fields.InvalidMessage_table_column_id(1)
          ,TableCol_Fields.InvalidMessage_table_name(1)
          ,TableCol_Fields.InvalidMessage_column_name(1)
          ,TableCol_Fields.InvalidMessage_is_column_value(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.table_name_ALLOW_ErrorCount
          ,le.column_name_ALLOW_ErrorCount
          ,le.is_column_value_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.table_name_ALLOW_ErrorCount
          ,le.column_name_ALLOW_ErrorCount
          ,le.is_column_value_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
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
