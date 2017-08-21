IMPORT ut,SALT33;
EXPORT input_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(input_Layout_Experian_Phones)
    UNSIGNED1 encrypted_experian_pin_Invalid;
    UNSIGNED1 phone_1_digits_Invalid;
    UNSIGNED1 phone_1_type_Invalid;
    UNSIGNED1 phone_1_source_Invalid;
    UNSIGNED1 phone_1_last_updt_Invalid;
    UNSIGNED1 phone_2_digits_Invalid;
    UNSIGNED1 phone_2_type_Invalid;
    UNSIGNED1 phone_2_source_Invalid;
    UNSIGNED1 phone_2_last_updt_Invalid;
    UNSIGNED1 phone_3_digits_Invalid;
    UNSIGNED1 phone_3_type_Invalid;
    UNSIGNED1 phone_3_source_Invalid;
    UNSIGNED1 phone_3_last_updt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(input_Layout_Experian_Phones)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(input_Layout_Experian_Phones) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.encrypted_experian_pin_Invalid := input_Fields.InValid_encrypted_experian_pin((SALT33.StrType)le.encrypted_experian_pin);
    SELF.phone_1_digits_Invalid := input_Fields.InValid_phone_1_digits((SALT33.StrType)le.phone_1_digits);
    SELF.phone_1_type_Invalid := input_Fields.InValid_phone_1_type((SALT33.StrType)le.phone_1_type);
    SELF.phone_1_source_Invalid := input_Fields.InValid_phone_1_source((SALT33.StrType)le.phone_1_source);
    SELF.phone_1_last_updt_Invalid := input_Fields.InValid_phone_1_last_updt((SALT33.StrType)le.phone_1_last_updt);
    SELF.phone_2_digits_Invalid := input_Fields.InValid_phone_2_digits((SALT33.StrType)le.phone_2_digits);
    SELF.phone_2_type_Invalid := input_Fields.InValid_phone_2_type((SALT33.StrType)le.phone_2_type);
    SELF.phone_2_source_Invalid := input_Fields.InValid_phone_2_source((SALT33.StrType)le.phone_2_source);
    SELF.phone_2_last_updt_Invalid := input_Fields.InValid_phone_2_last_updt((SALT33.StrType)le.phone_2_last_updt);
    SELF.phone_3_digits_Invalid := input_Fields.InValid_phone_3_digits((SALT33.StrType)le.phone_3_digits);
    SELF.phone_3_type_Invalid := input_Fields.InValid_phone_3_type((SALT33.StrType)le.phone_3_type);
    SELF.phone_3_source_Invalid := input_Fields.InValid_phone_3_source((SALT33.StrType)le.phone_3_source);
    SELF.phone_3_last_updt_Invalid := input_Fields.InValid_phone_3_last_updt((SALT33.StrType)le.phone_3_last_updt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),input_Layout_Experian_Phones);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.encrypted_experian_pin_Invalid << 0 ) + ( le.phone_1_digits_Invalid << 1 ) + ( le.phone_1_type_Invalid << 2 ) + ( le.phone_1_source_Invalid << 3 ) + ( le.phone_1_last_updt_Invalid << 4 ) + ( le.phone_2_digits_Invalid << 5 ) + ( le.phone_2_type_Invalid << 6 ) + ( le.phone_2_source_Invalid << 7 ) + ( le.phone_2_last_updt_Invalid << 8 ) + ( le.phone_3_digits_Invalid << 9 ) + ( le.phone_3_type_Invalid << 10 ) + ( le.phone_3_source_Invalid << 11 ) + ( le.phone_3_last_updt_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,input_Layout_Experian_Phones);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.encrypted_experian_pin_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_1_digits_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_1_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.phone_1_source_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.phone_1_last_updt_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phone_2_digits_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.phone_2_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.phone_2_source_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_2_last_updt_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.phone_3_digits_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.phone_3_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.phone_3_source_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.phone_3_last_updt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    encrypted_experian_pin_ALLOW_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=1);
    phone_1_digits_ALLOW_ErrorCount := COUNT(GROUP,h.phone_1_digits_Invalid=1);
    phone_1_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_1_type_Invalid=1);
    phone_1_source_ENUM_ErrorCount := COUNT(GROUP,h.phone_1_source_Invalid=1);
    phone_1_last_updt_ALLOW_ErrorCount := COUNT(GROUP,h.phone_1_last_updt_Invalid=1);
    phone_2_digits_ALLOW_ErrorCount := COUNT(GROUP,h.phone_2_digits_Invalid=1);
    phone_2_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_2_type_Invalid=1);
    phone_2_source_ENUM_ErrorCount := COUNT(GROUP,h.phone_2_source_Invalid=1);
    phone_2_last_updt_ALLOW_ErrorCount := COUNT(GROUP,h.phone_2_last_updt_Invalid=1);
    phone_3_digits_ALLOW_ErrorCount := COUNT(GROUP,h.phone_3_digits_Invalid=1);
    phone_3_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_3_type_Invalid=1);
    phone_3_source_ENUM_ErrorCount := COUNT(GROUP,h.phone_3_source_Invalid=1);
    phone_3_last_updt_ALLOW_ErrorCount := COUNT(GROUP,h.phone_3_last_updt_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.encrypted_experian_pin_Invalid,le.phone_1_digits_Invalid,le.phone_1_type_Invalid,le.phone_1_source_Invalid,le.phone_1_last_updt_Invalid,le.phone_2_digits_Invalid,le.phone_2_type_Invalid,le.phone_2_source_Invalid,le.phone_2_last_updt_Invalid,le.phone_3_digits_Invalid,le.phone_3_type_Invalid,le.phone_3_source_Invalid,le.phone_3_last_updt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,input_Fields.InvalidMessage_encrypted_experian_pin(le.encrypted_experian_pin_Invalid),input_Fields.InvalidMessage_phone_1_digits(le.phone_1_digits_Invalid),input_Fields.InvalidMessage_phone_1_type(le.phone_1_type_Invalid),input_Fields.InvalidMessage_phone_1_source(le.phone_1_source_Invalid),input_Fields.InvalidMessage_phone_1_last_updt(le.phone_1_last_updt_Invalid),input_Fields.InvalidMessage_phone_2_digits(le.phone_2_digits_Invalid),input_Fields.InvalidMessage_phone_2_type(le.phone_2_type_Invalid),input_Fields.InvalidMessage_phone_2_source(le.phone_2_source_Invalid),input_Fields.InvalidMessage_phone_2_last_updt(le.phone_2_last_updt_Invalid),input_Fields.InvalidMessage_phone_3_digits(le.phone_3_digits_Invalid),input_Fields.InvalidMessage_phone_3_type(le.phone_3_type_Invalid),input_Fields.InvalidMessage_phone_3_source(le.phone_3_source_Invalid),input_Fields.InvalidMessage_phone_3_last_updt(le.phone_3_last_updt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.encrypted_experian_pin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_1_digits_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_1_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_1_source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_1_last_updt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_2_digits_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_2_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_2_source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_2_last_updt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_3_digits_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_3_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_3_source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_3_last_updt_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'encrypted_experian_pin','phone_1_digits','phone_1_type','phone_1_source','phone_1_last_updt','phone_2_digits','phone_2_type','phone_2_source','phone_2_last_updt','phone_3_digits','phone_3_type','phone_3_source','phone_3_last_updt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Pin','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','Invalid_Num','Invalid_Type','Invalid_Source','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.encrypted_experian_pin,(SALT33.StrType)le.phone_1_digits,(SALT33.StrType)le.phone_1_type,(SALT33.StrType)le.phone_1_source,(SALT33.StrType)le.phone_1_last_updt,(SALT33.StrType)le.phone_2_digits,(SALT33.StrType)le.phone_2_type,(SALT33.StrType)le.phone_2_source,(SALT33.StrType)le.phone_2_last_updt,(SALT33.StrType)le.phone_3_digits,(SALT33.StrType)le.phone_3_type,(SALT33.StrType)le.phone_3_source,(SALT33.StrType)le.phone_3_last_updt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'encrypted_experian_pin:Invalid_Pin:ALLOW'
          ,'phone_1_digits:Invalid_Num:ALLOW'
          ,'phone_1_type:Invalid_Type:ENUM'
          ,'phone_1_source:Invalid_Source:ENUM'
          ,'phone_1_last_updt:Invalid_Num:ALLOW'
          ,'phone_2_digits:Invalid_Num:ALLOW'
          ,'phone_2_type:Invalid_Type:ENUM'
          ,'phone_2_source:Invalid_Source:ENUM'
          ,'phone_2_last_updt:Invalid_Num:ALLOW'
          ,'phone_3_digits:Invalid_Num:ALLOW'
          ,'phone_3_type:Invalid_Type:ENUM'
          ,'phone_3_source:Invalid_Source:ENUM'
          ,'phone_3_last_updt:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,input_Fields.InvalidMessage_encrypted_experian_pin(1)
          ,input_Fields.InvalidMessage_phone_1_digits(1)
          ,input_Fields.InvalidMessage_phone_1_type(1)
          ,input_Fields.InvalidMessage_phone_1_source(1)
          ,input_Fields.InvalidMessage_phone_1_last_updt(1)
          ,input_Fields.InvalidMessage_phone_2_digits(1)
          ,input_Fields.InvalidMessage_phone_2_type(1)
          ,input_Fields.InvalidMessage_phone_2_source(1)
          ,input_Fields.InvalidMessage_phone_2_last_updt(1)
          ,input_Fields.InvalidMessage_phone_3_digits(1)
          ,input_Fields.InvalidMessage_phone_3_type(1)
          ,input_Fields.InvalidMessage_phone_3_source(1)
          ,input_Fields.InvalidMessage_phone_3_last_updt(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.encrypted_experian_pin_ALLOW_ErrorCount
          ,le.phone_1_digits_ALLOW_ErrorCount
          ,le.phone_1_type_ENUM_ErrorCount
          ,le.phone_1_source_ENUM_ErrorCount
          ,le.phone_1_last_updt_ALLOW_ErrorCount
          ,le.phone_2_digits_ALLOW_ErrorCount
          ,le.phone_2_type_ENUM_ErrorCount
          ,le.phone_2_source_ENUM_ErrorCount
          ,le.phone_2_last_updt_ALLOW_ErrorCount
          ,le.phone_3_digits_ALLOW_ErrorCount
          ,le.phone_3_type_ENUM_ErrorCount
          ,le.phone_3_source_ENUM_ErrorCount
          ,le.phone_3_last_updt_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.encrypted_experian_pin_ALLOW_ErrorCount
          ,le.phone_1_digits_ALLOW_ErrorCount
          ,le.phone_1_type_ENUM_ErrorCount
          ,le.phone_1_source_ENUM_ErrorCount
          ,le.phone_1_last_updt_ALLOW_ErrorCount
          ,le.phone_2_digits_ALLOW_ErrorCount
          ,le.phone_2_type_ENUM_ErrorCount
          ,le.phone_2_source_ENUM_ErrorCount
          ,le.phone_2_last_updt_ALLOW_ErrorCount
          ,le.phone_3_digits_ALLOW_ErrorCount
          ,le.phone_3_type_ENUM_ErrorCount
          ,le.phone_3_source_ENUM_ErrorCount
          ,le.phone_3_last_updt_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,13,Into(LEFT,COUNTER));
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
