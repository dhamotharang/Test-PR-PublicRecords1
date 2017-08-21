IMPORT ut,SALT33;
EXPORT DeactRaw_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(DeactRaw_Layout_PhonesInfo)
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DeactRaw_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DeactRaw_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.action_code_Invalid := DeactRaw_Fields.InValid_action_code((SALT33.StrType)le.action_code);
    SELF.timestamp_Invalid := DeactRaw_Fields.InValid_timestamp((SALT33.StrType)le.timestamp);
    SELF.phone_Invalid := DeactRaw_Fields.InValid_phone((SALT33.StrType)le.phone);
    SELF.phone_swap_Invalid := DeactRaw_Fields.InValid_phone_swap((SALT33.StrType)le.phone_swap);
    SELF.filename_Invalid := DeactRaw_Fields.InValid_filename((SALT33.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DeactRaw_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.action_code_Invalid << 0 ) + ( le.timestamp_Invalid << 1 ) + ( le.phone_Invalid << 2 ) + ( le.phone_swap_Invalid << 3 ) + ( le.filename_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DeactRaw_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    action_code_ENUM_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    timestamp_ALLOW_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.action_code_Invalid,le.timestamp_Invalid,le.phone_Invalid,le.phone_swap_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DeactRaw_Fields.InvalidMessage_action_code(le.action_code_Invalid),DeactRaw_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),DeactRaw_Fields.InvalidMessage_phone(le.phone_Invalid),DeactRaw_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),DeactRaw_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.action_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.timestamp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'action_code','timestamp','phone','phone_swap','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_Num_Blank','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.action_code,(SALT33.StrType)le.timestamp,(SALT33.StrType)le.phone,(SALT33.StrType)le.phone_swap,(SALT33.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'action_code:Invalid_Action_Code:ENUM'
          ,'timestamp:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'phone_swap:Invalid_Num_Blank:ALLOW'
          ,'filename:Invalid_Filename:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DeactRaw_Fields.InvalidMessage_action_code(1)
          ,DeactRaw_Fields.InvalidMessage_timestamp(1)
          ,DeactRaw_Fields.InvalidMessage_phone(1)
          ,DeactRaw_Fields.InvalidMessage_phone_swap(1)
          ,DeactRaw_Fields.InvalidMessage_filename(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.action_code_ENUM_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.action_code_ENUM_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
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
