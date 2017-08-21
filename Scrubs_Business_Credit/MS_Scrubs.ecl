IMPORT ut,SALT33;
EXPORT MS_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(MS_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 name_of_value_Invalid;
    UNSIGNED1 value_string_Invalid;
    UNSIGNED1 privacy_indicator_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MS_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(MS_Layout_Business_Credit) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.segment_identifier_Invalid := MS_Fields.InValid_segment_identifier((SALT33.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := MS_Fields.InValid_file_sequence_number((SALT33.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := MS_Fields.InValid_parent_sequence_number((SALT33.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := MS_Fields.InValid_account_base_number((SALT33.StrType)le.account_base_number);
    SELF.name_of_value_Invalid := MS_Fields.InValid_name_of_value((SALT33.StrType)le.name_of_value);
    SELF.value_string_Invalid := MS_Fields.InValid_value_string((SALT33.StrType)le.value_string);
    SELF.privacy_indicator_Invalid := MS_Fields.InValid_privacy_indicator((SALT33.StrType)le.privacy_indicator);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),MS_Layout_Business_Credit);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.name_of_value_Invalid << 7 ) + ( le.value_string_Invalid << 9 ) + ( le.privacy_indicator_Invalid << 11 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MS_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.name_of_value_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.value_string_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.privacy_indicator_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    segment_identifier_ENUM_ErrorCount := COUNT(GROUP,h.segment_identifier_Invalid=1);
    file_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=1);
    file_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=2);
    file_sequence_number_Total_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid>0);
    parent_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=1);
    parent_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=2);
    parent_sequence_number_Total_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid>0);
    account_base_number_ALLOW_ErrorCount := COUNT(GROUP,h.account_base_number_Invalid=1);
    account_base_number_LENGTH_ErrorCount := COUNT(GROUP,h.account_base_number_Invalid=2);
    account_base_number_Total_ErrorCount := COUNT(GROUP,h.account_base_number_Invalid>0);
    name_of_value_ALLOW_ErrorCount := COUNT(GROUP,h.name_of_value_Invalid=1);
    name_of_value_LENGTH_ErrorCount := COUNT(GROUP,h.name_of_value_Invalid=2);
    name_of_value_Total_ErrorCount := COUNT(GROUP,h.name_of_value_Invalid>0);
    value_string_ALLOW_ErrorCount := COUNT(GROUP,h.value_string_Invalid=1);
    value_string_LENGTH_ErrorCount := COUNT(GROUP,h.value_string_Invalid=2);
    value_string_Total_ErrorCount := COUNT(GROUP,h.value_string_Invalid>0);
    privacy_indicator_ENUM_ErrorCount := COUNT(GROUP,h.privacy_indicator_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.name_of_value_Invalid,le.value_string_Invalid,le.privacy_indicator_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MS_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),MS_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),MS_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),MS_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),MS_Fields.InvalidMessage_name_of_value(le.name_of_value_Invalid),MS_Fields.InvalidMessage_value_string(le.value_string_Invalid),MS_Fields.InvalidMessage_privacy_indicator(le.privacy_indicator_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_of_value_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.value_string_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.privacy_indicator_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','name_of_value','value_string','privacy_indicator','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_name_of_value','invalid_valuenum','invalid_privacy_indicator','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.segment_identifier,(SALT33.StrType)le.file_sequence_number,(SALT33.StrType)le.parent_sequence_number,(SALT33.StrType)le.account_base_number,(SALT33.StrType)le.name_of_value,(SALT33.StrType)le.value_string,(SALT33.StrType)le.privacy_indicator,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'segment_identifier:invalid_segment_identifier:ENUM'
          ,'file_sequence_number:invalid_file_sequence_number:ALLOW','file_sequence_number:invalid_file_sequence_number:LENGTH'
          ,'parent_sequence_number:invalid_parent_sequence_number:ALLOW','parent_sequence_number:invalid_parent_sequence_number:LENGTH'
          ,'account_base_number:invalid_account_base_ab_number:ALLOW','account_base_number:invalid_account_base_ab_number:LENGTH'
          ,'name_of_value:invalid_name_of_value:ALLOW','name_of_value:invalid_name_of_value:LENGTH'
          ,'value_string:invalid_valuenum:ALLOW','value_string:invalid_valuenum:LENGTH'
          ,'privacy_indicator:invalid_privacy_indicator:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MS_Fields.InvalidMessage_segment_identifier(1)
          ,MS_Fields.InvalidMessage_file_sequence_number(1),MS_Fields.InvalidMessage_file_sequence_number(2)
          ,MS_Fields.InvalidMessage_parent_sequence_number(1),MS_Fields.InvalidMessage_parent_sequence_number(2)
          ,MS_Fields.InvalidMessage_account_base_number(1),MS_Fields.InvalidMessage_account_base_number(2)
          ,MS_Fields.InvalidMessage_name_of_value(1),MS_Fields.InvalidMessage_name_of_value(2)
          ,MS_Fields.InvalidMessage_value_string(1),MS_Fields.InvalidMessage_value_string(2)
          ,MS_Fields.InvalidMessage_privacy_indicator(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.name_of_value_ALLOW_ErrorCount,le.name_of_value_LENGTH_ErrorCount
          ,le.value_string_ALLOW_ErrorCount,le.value_string_LENGTH_ErrorCount
          ,le.privacy_indicator_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.name_of_value_ALLOW_ErrorCount,le.name_of_value_LENGTH_ErrorCount
          ,le.value_string_ALLOW_ErrorCount,le.value_string_LENGTH_ErrorCount
          ,le.privacy_indicator_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,12,Into(LEFT,COUNTER));
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
