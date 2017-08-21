IMPORT ut,SALT31;
EXPORT AD_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(AD_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 address_line_1_Invalid;
    UNSIGNED1 address_line_2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_or_ca_postal_code_Invalid;
    UNSIGNED1 postal_code_Invalid;
    UNSIGNED1 country_code_Invalid;
    UNSIGNED1 primary_address_indicator_Invalid;
    UNSIGNED1 address_classification_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(AD_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(AD_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := AD_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := AD_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := AD_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := AD_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number);
    SELF.address_line_1_Invalid := AD_Fields.InValid_address_line_1((SALT31.StrType)le.address_line_1);
    SELF.address_line_2_Invalid := AD_Fields.InValid_address_line_2((SALT31.StrType)le.address_line_2);
    SELF.city_Invalid := AD_Fields.InValid_city((SALT31.StrType)le.city);
    SELF.state_Invalid := AD_Fields.InValid_state((SALT31.StrType)le.state);
    SELF.zip_code_or_ca_postal_code_Invalid := AD_Fields.InValid_zip_code_or_ca_postal_code((SALT31.StrType)le.zip_code_or_ca_postal_code);
    SELF.postal_code_Invalid := AD_Fields.InValid_postal_code((SALT31.StrType)le.postal_code);
    SELF.country_code_Invalid := AD_Fields.InValid_country_code((SALT31.StrType)le.country_code);
    SELF.primary_address_indicator_Invalid := AD_Fields.InValid_primary_address_indicator((SALT31.StrType)le.primary_address_indicator);
    SELF.address_classification_Invalid := AD_Fields.InValid_address_classification((SALT31.StrType)le.address_classification);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.address_line_1_Invalid << 7 ) + ( le.address_line_2_Invalid << 9 ) + ( le.city_Invalid << 10 ) + ( le.state_Invalid << 11 ) + ( le.zip_code_or_ca_postal_code_Invalid << 12 ) + ( le.postal_code_Invalid << 13 ) + ( le.country_code_Invalid << 14 ) + ( le.primary_address_indicator_Invalid << 15 ) + ( le.address_classification_Invalid << 16 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,AD_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.address_line_1_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.address_line_2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip_code_or_ca_postal_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.postal_code_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.country_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.primary_address_indicator_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.address_classification_Invalid := (le.ScrubsBits1 >> 16) & 1;
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
    address_line_1_ALLOW_ErrorCount := COUNT(GROUP,h.address_line_1_Invalid=1);
    address_line_1_LENGTH_ErrorCount := COUNT(GROUP,h.address_line_1_Invalid=2);
    address_line_1_Total_ErrorCount := COUNT(GROUP,h.address_line_1_Invalid>0);
    address_line_2_ALLOW_ErrorCount := COUNT(GROUP,h.address_line_2_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_or_ca_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.zip_code_or_ca_postal_code_Invalid=1);
    postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.postal_code_Invalid=1);
    country_code_ALLOW_ErrorCount := COUNT(GROUP,h.country_code_Invalid=1);
    primary_address_indicator_ENUM_ErrorCount := COUNT(GROUP,h.primary_address_indicator_Invalid=1);
    address_classification_ENUM_ErrorCount := COUNT(GROUP,h.address_classification_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.address_line_1_Invalid,le.address_line_2_Invalid,le.city_Invalid,le.state_Invalid,le.zip_code_or_ca_postal_code_Invalid,le.postal_code_Invalid,le.country_code_Invalid,le.primary_address_indicator_Invalid,le.address_classification_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,AD_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),AD_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),AD_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),AD_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),AD_Fields.InvalidMessage_address_line_1(le.address_line_1_Invalid),AD_Fields.InvalidMessage_address_line_2(le.address_line_2_Invalid),AD_Fields.InvalidMessage_city(le.city_Invalid),AD_Fields.InvalidMessage_state(le.state_Invalid),AD_Fields.InvalidMessage_zip_code_or_ca_postal_code(le.zip_code_or_ca_postal_code_Invalid),AD_Fields.InvalidMessage_postal_code(le.postal_code_Invalid),AD_Fields.InvalidMessage_country_code(le.country_code_Invalid),AD_Fields.InvalidMessage_primary_address_indicator(le.primary_address_indicator_Invalid),AD_Fields.InvalidMessage_address_classification(le.address_classification_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_line_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_line_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_code_or_ca_postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_address_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.address_classification_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','address_line_1','address_line_2','city','state','zip_code_or_ca_postal_code','postal_code','country_code','primary_address_indicator','address_classification','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_number','invalid_address_line_1','invalid_address_line_2','invalid_city','invalid_state','invalid_zip_code_or_ca_postal_code','invalid_postal_code','invalid_country_code','invalid_primary_address_indicator','invalid_address_classification','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.parent_sequence_number,(SALT31.StrType)le.account_base_number,(SALT31.StrType)le.address_line_1,(SALT31.StrType)le.address_line_2,(SALT31.StrType)le.city,(SALT31.StrType)le.state,(SALT31.StrType)le.zip_code_or_ca_postal_code,(SALT31.StrType)le.postal_code,(SALT31.StrType)le.country_code,(SALT31.StrType)le.primary_address_indicator,(SALT31.StrType)le.address_classification,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
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
          ,'address_line_1:invalid_address_line_1:ALLOW','address_line_1:invalid_address_line_1:LENGTH'
          ,'address_line_2:invalid_address_line_2:ALLOW'
          ,'city:invalid_city:ALLOW'
          ,'state:invalid_state:ALLOW'
          ,'zip_code_or_ca_postal_code:invalid_zip_code_or_ca_postal_code:ALLOW'
          ,'postal_code:invalid_postal_code:ALLOW'
          ,'country_code:invalid_country_code:ALLOW'
          ,'primary_address_indicator:invalid_primary_address_indicator:ENUM'
          ,'address_classification:invalid_address_classification:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,AD_Fields.InvalidMessage_segment_identifier(1)
          ,AD_Fields.InvalidMessage_file_sequence_number(1),AD_Fields.InvalidMessage_file_sequence_number(2)
          ,AD_Fields.InvalidMessage_parent_sequence_number(1),AD_Fields.InvalidMessage_parent_sequence_number(2)
          ,AD_Fields.InvalidMessage_account_base_number(1),AD_Fields.InvalidMessage_account_base_number(2)
          ,AD_Fields.InvalidMessage_address_line_1(1),AD_Fields.InvalidMessage_address_line_1(2)
          ,AD_Fields.InvalidMessage_address_line_2(1)
          ,AD_Fields.InvalidMessage_city(1)
          ,AD_Fields.InvalidMessage_state(1)
          ,AD_Fields.InvalidMessage_zip_code_or_ca_postal_code(1)
          ,AD_Fields.InvalidMessage_postal_code(1)
          ,AD_Fields.InvalidMessage_country_code(1)
          ,AD_Fields.InvalidMessage_primary_address_indicator(1)
          ,AD_Fields.InvalidMessage_address_classification(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.address_line_1_ALLOW_ErrorCount,le.address_line_1_LENGTH_ErrorCount
          ,le.address_line_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_code_or_ca_postal_code_ALLOW_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.primary_address_indicator_ENUM_ErrorCount
          ,le.address_classification_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.address_line_1_ALLOW_ErrorCount,le.address_line_1_LENGTH_ErrorCount
          ,le.address_line_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_code_or_ca_postal_code_ALLOW_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.primary_address_indicator_ENUM_ErrorCount
          ,le.address_classification_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,17,Into(LEFT,COUNTER));
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
