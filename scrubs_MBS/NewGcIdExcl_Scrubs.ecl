IMPORT SALT37;
EXPORT NewGcIdExcl_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(NewGcIdExcl_Layout_NewGcIdExcl)
    UNSIGNED1 fdn_file_gc_exclusion_id_Invalid;
    UNSIGNED1 fdn_file_info_id_Invalid;
    UNSIGNED1 exclusion_id_Invalid;
    UNSIGNED1 exclusion_id_type_Invalid;
    UNSIGNED1 status_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(NewGcIdExcl_Layout_NewGcIdExcl)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(NewGcIdExcl_Layout_NewGcIdExcl) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fdn_file_gc_exclusion_id_Invalid := NewGcIdExcl_Fields.InValid_fdn_file_gc_exclusion_id((SALT37.StrType)le.fdn_file_gc_exclusion_id);
    SELF.fdn_file_info_id_Invalid := NewGcIdExcl_Fields.InValid_fdn_file_info_id((SALT37.StrType)le.fdn_file_info_id);
    SELF.exclusion_id_Invalid := NewGcIdExcl_Fields.InValid_exclusion_id((SALT37.StrType)le.exclusion_id);
    SELF.exclusion_id_type_Invalid := NewGcIdExcl_Fields.InValid_exclusion_id_type((SALT37.StrType)le.exclusion_id_type);
    SELF.status_Invalid := NewGcIdExcl_Fields.InValid_status((SALT37.StrType)le.status);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),NewGcIdExcl_Layout_NewGcIdExcl);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fdn_file_gc_exclusion_id_Invalid << 0 ) + ( le.fdn_file_info_id_Invalid << 1 ) + ( le.exclusion_id_Invalid << 2 ) + ( le.exclusion_id_type_Invalid << 3 ) + ( le.status_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,NewGcIdExcl_Layout_NewGcIdExcl);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fdn_file_gc_exclusion_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fdn_file_info_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.exclusion_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.exclusion_id_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fdn_file_gc_exclusion_id_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_file_gc_exclusion_id_Invalid=1);
    fdn_file_info_id_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_file_info_id_Invalid=1);
    exclusion_id_ALLOW_ErrorCount := COUNT(GROUP,h.exclusion_id_Invalid=1);
    exclusion_id_type_ALLOW_ErrorCount := COUNT(GROUP,h.exclusion_id_type_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.fdn_file_gc_exclusion_id_Invalid,le.fdn_file_info_id_Invalid,le.exclusion_id_Invalid,le.exclusion_id_type_Invalid,le.status_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,NewGcIdExcl_Fields.InvalidMessage_fdn_file_gc_exclusion_id(le.fdn_file_gc_exclusion_id_Invalid),NewGcIdExcl_Fields.InvalidMessage_fdn_file_info_id(le.fdn_file_info_id_Invalid),NewGcIdExcl_Fields.InvalidMessage_exclusion_id(le.exclusion_id_Invalid),NewGcIdExcl_Fields.InvalidMessage_exclusion_id_type(le.exclusion_id_type_Invalid),NewGcIdExcl_Fields.InvalidMessage_status(le.status_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fdn_file_gc_exclusion_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fdn_file_info_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exclusion_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exclusion_id_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fdn_file_gc_exclusion_id','fdn_file_info_id','exclusion_id','exclusion_id_type','status','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.fdn_file_gc_exclusion_id,(SALT37.StrType)le.fdn_file_info_id,(SALT37.StrType)le.exclusion_id,(SALT37.StrType)le.exclusion_id_type,(SALT37.StrType)le.status,'***SALTBUG***');
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
          ,'fdn_file_gc_exclusion_id:invalid_numeric:ALLOW'
          ,'fdn_file_info_id:invalid_numeric:ALLOW'
          ,'exclusion_id:invalid_numeric:ALLOW'
          ,'exclusion_id_type:invalid_alphanumeric:ALLOW'
          ,'status:invalid_numeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,NewGcIdExcl_Fields.InvalidMessage_fdn_file_gc_exclusion_id(1)
          ,NewGcIdExcl_Fields.InvalidMessage_fdn_file_info_id(1)
          ,NewGcIdExcl_Fields.InvalidMessage_exclusion_id(1)
          ,NewGcIdExcl_Fields.InvalidMessage_exclusion_id_type(1)
          ,NewGcIdExcl_Fields.InvalidMessage_status(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fdn_file_gc_exclusion_id_ALLOW_ErrorCount
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.exclusion_id_ALLOW_ErrorCount
          ,le.exclusion_id_type_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.fdn_file_gc_exclusion_id_ALLOW_ErrorCount
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.exclusion_id_ALLOW_ErrorCount
          ,le.exclusion_id_type_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
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
