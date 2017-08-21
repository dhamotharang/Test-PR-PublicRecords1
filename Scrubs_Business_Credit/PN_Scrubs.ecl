IMPORT ut,SALT31;
EXPORT PN_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(PN_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 area_code_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 phone_extension_Invalid;
    UNSIGNED1 primary_phone_indicator_Invalid;
    UNSIGNED1 published_unlisted_indicator_Invalid;
    UNSIGNED1 phone_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(PN_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(PN_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := PN_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := PN_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := PN_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := PN_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number);
    SELF.area_code_Invalid := PN_Fields.InValid_area_code((SALT31.StrType)le.area_code);
    SELF.phone_number_Invalid := PN_Fields.InValid_phone_number((SALT31.StrType)le.phone_number);
    SELF.phone_extension_Invalid := PN_Fields.InValid_phone_extension((SALT31.StrType)le.phone_extension);
    SELF.primary_phone_indicator_Invalid := PN_Fields.InValid_primary_phone_indicator((SALT31.StrType)le.primary_phone_indicator);
    SELF.published_unlisted_indicator_Invalid := PN_Fields.InValid_published_unlisted_indicator((SALT31.StrType)le.published_unlisted_indicator);
    SELF.phone_type_Invalid := PN_Fields.InValid_phone_type((SALT31.StrType)le.phone_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.area_code_Invalid << 7 ) + ( le.phone_number_Invalid << 8 ) + ( le.phone_extension_Invalid << 10 ) + ( le.primary_phone_indicator_Invalid << 11 ) + ( le.published_unlisted_indicator_Invalid << 12 ) + ( le.phone_type_Invalid << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,PN_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.area_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.phone_extension_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.primary_phone_indicator_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.published_unlisted_indicator_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 13) & 1;
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
    area_code_ALLOW_ErrorCount := COUNT(GROUP,h.area_code_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_LENGTH_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=2);
    phone_number_Total_ErrorCount := COUNT(GROUP,h.phone_number_Invalid>0);
    phone_extension_ALLOW_ErrorCount := COUNT(GROUP,h.phone_extension_Invalid=1);
    primary_phone_indicator_ENUM_ErrorCount := COUNT(GROUP,h.primary_phone_indicator_Invalid=1);
    published_unlisted_indicator_ENUM_ErrorCount := COUNT(GROUP,h.published_unlisted_indicator_Invalid=1);
    phone_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.area_code_Invalid,le.phone_number_Invalid,le.phone_extension_Invalid,le.primary_phone_indicator_Invalid,le.published_unlisted_indicator_Invalid,le.phone_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,PN_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),PN_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),PN_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),PN_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),PN_Fields.InvalidMessage_area_code(le.area_code_Invalid),PN_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),PN_Fields.InvalidMessage_phone_extension(le.phone_extension_Invalid),PN_Fields.InvalidMessage_primary_phone_indicator(le.primary_phone_indicator_Invalid),PN_Fields.InvalidMessage_published_unlisted_indicator(le.published_unlisted_indicator_Invalid),PN_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.area_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_phone_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.published_unlisted_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','area_code','phone_number','phone_extension','primary_phone_indicator','published_unlisted_indicator','phone_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_area_code','invalid_telephone_number','invalid_telephone_extension','invalid_primary_telephone_indicator','invalid_published_unlisted_indicator','invalid_phonetype','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.parent_sequence_number,(SALT31.StrType)le.account_base_number,(SALT31.StrType)le.area_code,(SALT31.StrType)le.phone_number,(SALT31.StrType)le.phone_extension,(SALT31.StrType)le.primary_phone_indicator,(SALT31.StrType)le.published_unlisted_indicator,(SALT31.StrType)le.phone_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
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
          ,'account_base_number:invalid_account_base_number:ALLOW','account_base_number:invalid_account_base_number:LENGTH'
          ,'area_code:invalid_area_code:ALLOW'
          ,'phone_number:invalid_telephone_number:ALLOW','phone_number:invalid_telephone_number:LENGTH'
          ,'phone_extension:invalid_telephone_extension:ALLOW'
          ,'primary_phone_indicator:invalid_primary_telephone_indicator:ENUM'
          ,'published_unlisted_indicator:invalid_published_unlisted_indicator:ENUM'
          ,'phone_type:invalid_phonetype:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,PN_Fields.InvalidMessage_segment_identifier(1)
          ,PN_Fields.InvalidMessage_file_sequence_number(1),PN_Fields.InvalidMessage_file_sequence_number(2)
          ,PN_Fields.InvalidMessage_parent_sequence_number(1),PN_Fields.InvalidMessage_parent_sequence_number(2)
          ,PN_Fields.InvalidMessage_account_base_number(1),PN_Fields.InvalidMessage_account_base_number(2)
          ,PN_Fields.InvalidMessage_area_code(1)
          ,PN_Fields.InvalidMessage_phone_number(1),PN_Fields.InvalidMessage_phone_number(2)
          ,PN_Fields.InvalidMessage_phone_extension(1)
          ,PN_Fields.InvalidMessage_primary_phone_indicator(1)
          ,PN_Fields.InvalidMessage_published_unlisted_indicator(1)
          ,PN_Fields.InvalidMessage_phone_type(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.area_code_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.primary_phone_indicator_ENUM_ErrorCount
          ,le.published_unlisted_indicator_ENUM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.area_code_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTH_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.primary_phone_indicator_ENUM_ErrorCount
          ,le.published_unlisted_indicator_ENUM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,14,Into(LEFT,COUNTER));
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
