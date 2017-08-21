IMPORT ut,SALT31;
EXPORT BI_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(BI_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 classification_code_type_Invalid;
    UNSIGNED1 classification_code_Invalid;
    UNSIGNED1 primary_industry_code_indicator_Invalid;
    UNSIGNED1 privacy_indicator_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BI_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(BI_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := BI_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := BI_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := BI_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := BI_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number);
    SELF.classification_code_type_Invalid := BI_Fields.InValid_classification_code_type((SALT31.StrType)le.classification_code_type);
    SELF.classification_code_Invalid := BI_Fields.InValid_classification_code((SALT31.StrType)le.classification_code);
    SELF.primary_industry_code_indicator_Invalid := BI_Fields.InValid_primary_industry_code_indicator((SALT31.StrType)le.primary_industry_code_indicator);
    SELF.privacy_indicator_Invalid := BI_Fields.InValid_privacy_indicator((SALT31.StrType)le.privacy_indicator);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.classification_code_type_Invalid << 7 ) + ( le.classification_code_Invalid << 8 ) + ( le.primary_industry_code_indicator_Invalid << 10 ) + ( le.privacy_indicator_Invalid << 11 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,BI_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.classification_code_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.classification_code_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.primary_industry_code_indicator_Invalid := (le.ScrubsBits1 >> 10) & 1;
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
    classification_code_type_ENUM_ErrorCount := COUNT(GROUP,h.classification_code_type_Invalid=1);
    classification_code_ALLOW_ErrorCount := COUNT(GROUP,h.classification_code_Invalid=1);
    classification_code_LENGTH_ErrorCount := COUNT(GROUP,h.classification_code_Invalid=2);
    classification_code_Total_ErrorCount := COUNT(GROUP,h.classification_code_Invalid>0);
    primary_industry_code_indicator_ENUM_ErrorCount := COUNT(GROUP,h.primary_industry_code_indicator_Invalid=1);
    privacy_indicator_ENUM_ErrorCount := COUNT(GROUP,h.privacy_indicator_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.classification_code_type_Invalid,le.classification_code_Invalid,le.primary_industry_code_indicator_Invalid,le.privacy_indicator_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BI_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),BI_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),BI_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),BI_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),BI_Fields.InvalidMessage_classification_code_type(le.classification_code_type_Invalid),BI_Fields.InvalidMessage_classification_code(le.classification_code_Invalid),BI_Fields.InvalidMessage_primary_industry_code_indicator(le.primary_industry_code_indicator_Invalid),BI_Fields.InvalidMessage_privacy_indicator(le.privacy_indicator_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.classification_code_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.classification_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.primary_industry_code_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.privacy_indicator_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','classification_code_type','classification_code','primary_industry_code_indicator','privacy_indicator','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_classification_code_type','invalid_classification_code','invalid_primary_industry_code_indicator','invalid_privacy_indicator','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.parent_sequence_number,(SALT31.StrType)le.account_base_number,(SALT31.StrType)le.classification_code_type,(SALT31.StrType)le.classification_code,(SALT31.StrType)le.primary_industry_code_indicator,(SALT31.StrType)le.privacy_indicator,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'segment_identifier:invalid_segment_identifier:ENUM'
          ,'file_sequence_number:invalid_file_sequence_number:ALLOW','file_sequence_number:invalid_file_sequence_number:LENGTH'
          ,'parent_sequence_number:invalid_parent_sequence_number:ALLOW','parent_sequence_number:invalid_parent_sequence_number:LENGTH'
          ,'account_base_number:invalid_account_base_ab_number:ALLOW','account_base_number:invalid_account_base_ab_number:LENGTH'
          ,'classification_code_type:invalid_classification_code_type:ENUM'
          ,'classification_code:invalid_classification_code:ALLOW','classification_code:invalid_classification_code:LENGTH'
          ,'primary_industry_code_indicator:invalid_primary_industry_code_indicator:ENUM'
          ,'privacy_indicator:invalid_privacy_indicator:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,BI_Fields.InvalidMessage_segment_identifier(1)
          ,BI_Fields.InvalidMessage_file_sequence_number(1),BI_Fields.InvalidMessage_file_sequence_number(2)
          ,BI_Fields.InvalidMessage_parent_sequence_number(1),BI_Fields.InvalidMessage_parent_sequence_number(2)
          ,BI_Fields.InvalidMessage_account_base_number(1),BI_Fields.InvalidMessage_account_base_number(2)
          ,BI_Fields.InvalidMessage_classification_code_type(1)
          ,BI_Fields.InvalidMessage_classification_code(1),BI_Fields.InvalidMessage_classification_code(2)
          ,BI_Fields.InvalidMessage_primary_industry_code_indicator(1)
          ,BI_Fields.InvalidMessage_privacy_indicator(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.classification_code_type_ENUM_ErrorCount
          ,le.classification_code_ALLOW_ErrorCount,le.classification_code_LENGTH_ErrorCount
          ,le.primary_industry_code_indicator_ENUM_ErrorCount
          ,le.privacy_indicator_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.classification_code_type_ENUM_ErrorCount
          ,le.classification_code_ALLOW_ErrorCount,le.classification_code_LENGTH_ErrorCount
          ,le.primary_industry_code_indicator_ENUM_ErrorCount
          ,le.privacy_indicator_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,12,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
