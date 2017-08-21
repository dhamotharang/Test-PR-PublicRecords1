IMPORT ut,SALT33;
EXPORT incident_text_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(incident_text_Layout_SANCTN_NPKeys)
    UNSIGNED1 batch_Invalid;
    UNSIGNED1 dbcode_Invalid;
    UNSIGNED1 incident_num_Invalid;
    UNSIGNED1 seq_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(incident_text_Layout_SANCTN_NPKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(incident_text_Layout_SANCTN_NPKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_Invalid := incident_text_Fields.InValid_batch((SALT33.StrType)le.batch);
    SELF.dbcode_Invalid := incident_text_Fields.InValid_dbcode((SALT33.StrType)le.dbcode);
    SELF.incident_num_Invalid := incident_text_Fields.InValid_incident_num((SALT33.StrType)le.incident_num);
    SELF.seq_Invalid := incident_text_Fields.InValid_seq((SALT33.StrType)le.seq);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),incident_text_Layout_SANCTN_NPKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_Invalid << 0 ) + ( le.dbcode_Invalid << 2 ) + ( le.incident_num_Invalid << 3 ) + ( le.seq_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,incident_text_Layout_SANCTN_NPKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dbcode_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.incident_num_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.seq_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.dbcode;
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_ALLOW_ErrorCount := COUNT(GROUP,h.batch_Invalid=1);
    batch_LENGTH_ErrorCount := COUNT(GROUP,h.batch_Invalid=2);
    batch_Total_ErrorCount := COUNT(GROUP,h.batch_Invalid>0);
    dbcode_ENUM_ErrorCount := COUNT(GROUP,h.dbcode_Invalid=1);
    incident_num_ALLOW_ErrorCount := COUNT(GROUP,h.incident_num_Invalid=1);
    seq_ALLOW_ErrorCount := COUNT(GROUP,h.seq_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,dbcode,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.dbcode;
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_Invalid,le.dbcode_Invalid,le.incident_num_Invalid,le.seq_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,incident_text_Fields.InvalidMessage_batch(le.batch_Invalid),incident_text_Fields.InvalidMessage_dbcode(le.dbcode_Invalid),incident_text_Fields.InvalidMessage_incident_num(le.incident_num_Invalid),incident_text_Fields.InvalidMessage_seq(le.seq_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dbcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.incident_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seq_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch','dbcode','incident_num','seq','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.batch,(SALT33.StrType)le.dbcode,(SALT33.StrType)le.incident_num,(SALT33.StrType)le.seq,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.dbcode;
      SELF.ruledesc := CHOOSE(c
          ,'batch:Invalid_Batch:ALLOW','batch:Invalid_Batch:LENGTH'
          ,'dbcode:Invalid_DBCode:ENUM'
          ,'incident_num:Invalid_Num:ALLOW'
          ,'seq:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,incident_text_Fields.InvalidMessage_batch(1),incident_text_Fields.InvalidMessage_batch(2)
          ,incident_text_Fields.InvalidMessage_dbcode(1)
          ,incident_text_Fields.InvalidMessage_incident_num(1)
          ,incident_text_Fields.InvalidMessage_seq(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.seq_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.seq_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
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
