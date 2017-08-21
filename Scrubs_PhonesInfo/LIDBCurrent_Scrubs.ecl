IMPORT ut,SALT33;
EXPORT LIDBCurrent_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(LIDBCurrent_Layout_PhonesInfo)
    UNSIGNED1 reference_id_Invalid;
    UNSIGNED1 phone_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(LIDBCurrent_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(LIDBCurrent_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.reference_id_Invalid := LIDBCurrent_Fields.InValid_reference_id((SALT33.StrType)le.reference_id);
    SELF.phone_Invalid := LIDBCurrent_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),LIDBCurrent_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.reference_id_Invalid << 0 ) + ( le.phone_Invalid << 1 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,LIDBCurrent_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.reference_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    reference_id_ALLOW_ErrorCount := COUNT(GROUP,h.reference_id_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.reference_id_Invalid,le.phone_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,LIDBCurrent_Fields.InvalidMessage_reference_id(le.reference_id_Invalid),LIDBCurrent_Fields.InvalidMessage_phone(le.phone_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.reference_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'reference_id','phone','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_RefID','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.reference_id,(SALT33.StrType)le.phone,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,2,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'reference_id:Invalid_RefID:ALLOW'
          ,'phone:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,LIDBCurrent_Fields.InvalidMessage_reference_id(1)
          ,LIDBCurrent_Fields.InvalidMessage_phone(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.reference_id_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.reference_id_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,2,Into(LEFT,COUNTER));
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
