IMPORT SALT37;
EXPORT ColValDesc_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(ColValDesc_Layout_ColValDesc)
    UNSIGNED1 column_value_desc_id_Invalid;
    UNSIGNED1 table_column_id_Invalid;
    UNSIGNED1 desc_value_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 description_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(ColValDesc_Layout_ColValDesc)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(ColValDesc_Layout_ColValDesc) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.column_value_desc_id_Invalid := ColValDesc_Fields.InValid_column_value_desc_id((SALT37.StrType)le.column_value_desc_id);
    SELF.table_column_id_Invalid := ColValDesc_Fields.InValid_table_column_id((SALT37.StrType)le.table_column_id);
    SELF.desc_value_Invalid := ColValDesc_Fields.InValid_desc_value((SALT37.StrType)le.desc_value);
    SELF.status_Invalid := ColValDesc_Fields.InValid_status((SALT37.StrType)le.status);
    SELF.description_Invalid := ColValDesc_Fields.InValid_description((SALT37.StrType)le.description);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),ColValDesc_Layout_ColValDesc);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.column_value_desc_id_Invalid << 0 ) + ( le.table_column_id_Invalid << 1 ) + ( le.desc_value_Invalid << 2 ) + ( le.status_Invalid << 3 ) + ( le.description_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,ColValDesc_Layout_ColValDesc);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.column_value_desc_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.table_column_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.desc_value_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.description_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    column_value_desc_id_ALLOW_ErrorCount := COUNT(GROUP,h.column_value_desc_id_Invalid=1);
    table_column_id_ALLOW_ErrorCount := COUNT(GROUP,h.table_column_id_Invalid=1);
    desc_value_ALLOW_ErrorCount := COUNT(GROUP,h.desc_value_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    description_ALLOW_ErrorCount := COUNT(GROUP,h.description_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.column_value_desc_id_Invalid,le.table_column_id_Invalid,le.desc_value_Invalid,le.status_Invalid,le.description_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,ColValDesc_Fields.InvalidMessage_column_value_desc_id(le.column_value_desc_id_Invalid),ColValDesc_Fields.InvalidMessage_table_column_id(le.table_column_id_Invalid),ColValDesc_Fields.InvalidMessage_desc_value(le.desc_value_Invalid),ColValDesc_Fields.InvalidMessage_status(le.status_Invalid),ColValDesc_Fields.InvalidMessage_description(le.description_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.column_value_desc_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.table_column_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.desc_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.description_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'column_value_desc_id','table_column_id','desc_value','status','description','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.column_value_desc_id,(SALT37.StrType)le.table_column_id,(SALT37.StrType)le.desc_value,(SALT37.StrType)le.status,(SALT37.StrType)le.description,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'column_value_desc_id:invalid_numeric:ALLOW'
          ,'table_column_id:invalid_numeric:ALLOW'
          ,'desc_value:invalid_alphanumeric:ALLOW'
          ,'status:invalid_numeric:ALLOW'
          ,'description:invalid_alphanumeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,ColValDesc_Fields.InvalidMessage_column_value_desc_id(1)
          ,ColValDesc_Fields.InvalidMessage_table_column_id(1)
          ,ColValDesc_Fields.InvalidMessage_desc_value(1)
          ,ColValDesc_Fields.InvalidMessage_status(1)
          ,ColValDesc_Fields.InvalidMessage_description(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.column_value_desc_id_ALLOW_ErrorCount
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.desc_value_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.column_value_desc_id_ALLOW_ErrorCount
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.desc_value_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,5,Into(LEFT,COUNTER));
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
