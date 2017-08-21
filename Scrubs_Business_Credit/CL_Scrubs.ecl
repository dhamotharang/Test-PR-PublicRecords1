IMPORT ut,SALT31;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT CL_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(CL_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 collateral_indicator_Invalid;
    UNSIGNED1 type_of_collateral_secured_for_this_account_Invalid;
    UNSIGNED1 collateral_description_Invalid;
    UNSIGNED1 ucc_filing_number_Invalid;
    UNSIGNED1 ucc_filing_type_Invalid;
    UNSIGNED1 ucc_filing_date_Invalid;
    UNSIGNED1 ucc_filing_expiration_date_Invalid;
    UNSIGNED1 ucc_filing_jurisdiction_Invalid;
    UNSIGNED1 ucc_filing_description_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CL_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(CL_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := CL_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := CL_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := CL_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := CL_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number);
    SELF.collateral_indicator_Invalid := CL_Fields.InValid_collateral_indicator((SALT31.StrType)le.collateral_indicator);
    SELF.type_of_collateral_secured_for_this_account_Invalid := CL_Fields.InValid_type_of_collateral_secured_for_this_account((SALT31.StrType)le.type_of_collateral_secured_for_this_account);
    SELF.collateral_description_Invalid := CL_Fields.InValid_collateral_description((SALT31.StrType)le.collateral_description);
    SELF.ucc_filing_number_Invalid := CL_Fields.InValid_ucc_filing_number((SALT31.StrType)le.ucc_filing_number);
    SELF.ucc_filing_type_Invalid := CL_Fields.InValid_ucc_filing_type((SALT31.StrType)le.ucc_filing_type);
    SELF.ucc_filing_date_Invalid := CL_Fields.InValid_ucc_filing_date((SALT31.StrType)le.ucc_filing_date);
    SELF.ucc_filing_expiration_date_Invalid := CL_Fields.InValid_ucc_filing_expiration_date((SALT31.StrType)le.ucc_filing_expiration_date);
    SELF.ucc_filing_jurisdiction_Invalid := CL_Fields.InValid_ucc_filing_jurisdiction((SALT31.StrType)le.ucc_filing_jurisdiction);
    SELF.ucc_filing_description_Invalid := CL_Fields.InValid_ucc_filing_description((SALT31.StrType)le.ucc_filing_description);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.collateral_indicator_Invalid << 7 ) + ( le.type_of_collateral_secured_for_this_account_Invalid << 8 ) + ( le.collateral_description_Invalid << 9 ) + ( le.ucc_filing_number_Invalid << 10 ) + ( le.ucc_filing_type_Invalid << 11 ) + ( le.ucc_filing_date_Invalid << 12 ) + ( le.ucc_filing_expiration_date_Invalid << 14 ) + ( le.ucc_filing_jurisdiction_Invalid << 16 ) + ( le.ucc_filing_description_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,CL_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.collateral_indicator_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.type_of_collateral_secured_for_this_account_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.collateral_description_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ucc_filing_number_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ucc_filing_type_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.ucc_filing_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.ucc_filing_expiration_date_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.ucc_filing_jurisdiction_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.ucc_filing_description_Invalid := (le.ScrubsBits1 >> 17) & 1;
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
    collateral_indicator_ENUM_ErrorCount := COUNT(GROUP,h.collateral_indicator_Invalid=1);
    type_of_collateral_secured_for_this_account_ENUM_ErrorCount := COUNT(GROUP,h.type_of_collateral_secured_for_this_account_Invalid=1);
    collateral_description_ALLOW_ErrorCount := COUNT(GROUP,h.collateral_description_Invalid=1);
    ucc_filing_number_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_filing_number_Invalid=1);
    ucc_filing_type_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_filing_type_Invalid=1);
    ucc_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_filing_date_Invalid=1);
    ucc_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.ucc_filing_date_Invalid=2);
    ucc_filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.ucc_filing_date_Invalid=3);
    ucc_filing_date_Total_ErrorCount := COUNT(GROUP,h.ucc_filing_date_Invalid>0);
    ucc_filing_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_filing_expiration_date_Invalid=1);
    ucc_filing_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.ucc_filing_expiration_date_Invalid=2);
    ucc_filing_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.ucc_filing_expiration_date_Invalid=3);
    ucc_filing_expiration_date_Total_ErrorCount := COUNT(GROUP,h.ucc_filing_expiration_date_Invalid>0);
    ucc_filing_jurisdiction_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_filing_jurisdiction_Invalid=1);
    ucc_filing_description_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_filing_description_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.collateral_indicator_Invalid,le.type_of_collateral_secured_for_this_account_Invalid,le.collateral_description_Invalid,le.ucc_filing_number_Invalid,le.ucc_filing_type_Invalid,le.ucc_filing_date_Invalid,le.ucc_filing_expiration_date_Invalid,le.ucc_filing_jurisdiction_Invalid,le.ucc_filing_description_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CL_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),CL_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),CL_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),CL_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),CL_Fields.InvalidMessage_collateral_indicator(le.collateral_indicator_Invalid),CL_Fields.InvalidMessage_type_of_collateral_secured_for_this_account(le.type_of_collateral_secured_for_this_account_Invalid),CL_Fields.InvalidMessage_collateral_description(le.collateral_description_Invalid),CL_Fields.InvalidMessage_ucc_filing_number(le.ucc_filing_number_Invalid),CL_Fields.InvalidMessage_ucc_filing_type(le.ucc_filing_type_Invalid),CL_Fields.InvalidMessage_ucc_filing_date(le.ucc_filing_date_Invalid),CL_Fields.InvalidMessage_ucc_filing_expiration_date(le.ucc_filing_expiration_date_Invalid),CL_Fields.InvalidMessage_ucc_filing_jurisdiction(le.ucc_filing_jurisdiction_Invalid),CL_Fields.InvalidMessage_ucc_filing_description(le.ucc_filing_description_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.collateral_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.type_of_collateral_secured_for_this_account_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.collateral_description_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ucc_filing_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ucc_filing_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ucc_filing_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ucc_filing_expiration_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ucc_filing_jurisdiction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ucc_filing_description_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','collateral_indicator','type_of_collateral_secured_for_this_account','collateral_description','ucc_filing_number','ucc_filing_type','ucc_filing_date','ucc_filing_expiration_date','ucc_filing_jurisdiction','ucc_filing_description','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_collateral_indicator','invalid_type_of_collateral','invalid_collateral_description','invalid_ucc_filing_number','invalid_ucc_filing_type','invalid_ucc_filing_date','invalid_ucc_filing_expiration_date','invalid_ucc_filing_jurisdiction','invalid_ucc_filing_description','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.parent_sequence_number,(SALT31.StrType)le.account_base_number,(SALT31.StrType)le.collateral_indicator,(SALT31.StrType)le.type_of_collateral_secured_for_this_account,(SALT31.StrType)le.collateral_description,(SALT31.StrType)le.ucc_filing_number,(SALT31.StrType)le.ucc_filing_type,(SALT31.StrType)le.ucc_filing_date,(SALT31.StrType)le.ucc_filing_expiration_date,(SALT31.StrType)le.ucc_filing_jurisdiction,(SALT31.StrType)le.ucc_filing_description,'***SALTBUG***');
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
          ,'account_base_number:invalid_account_base_ab_number:ALLOW','account_base_number:invalid_account_base_ab_number:LENGTH'
          ,'collateral_indicator:invalid_collateral_indicator:ENUM'
          ,'type_of_collateral_secured_for_this_account:invalid_type_of_collateral:ENUM'
          ,'collateral_description:invalid_collateral_description:ALLOW'
          ,'ucc_filing_number:invalid_ucc_filing_number:ALLOW'
          ,'ucc_filing_type:invalid_ucc_filing_type:ALLOW'
          ,'ucc_filing_date:invalid_ucc_filing_date:ALLOW','ucc_filing_date:invalid_ucc_filing_date:CUSTOM','ucc_filing_date:invalid_ucc_filing_date:LENGTH'
          ,'ucc_filing_expiration_date:invalid_ucc_filing_expiration_date:ALLOW','ucc_filing_expiration_date:invalid_ucc_filing_expiration_date:CUSTOM','ucc_filing_expiration_date:invalid_ucc_filing_expiration_date:LENGTH'
          ,'ucc_filing_jurisdiction:invalid_ucc_filing_jurisdiction:ALLOW'
          ,'ucc_filing_description:invalid_ucc_filing_description:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,CL_Fields.InvalidMessage_segment_identifier(1)
          ,CL_Fields.InvalidMessage_file_sequence_number(1),CL_Fields.InvalidMessage_file_sequence_number(2)
          ,CL_Fields.InvalidMessage_parent_sequence_number(1),CL_Fields.InvalidMessage_parent_sequence_number(2)
          ,CL_Fields.InvalidMessage_account_base_number(1),CL_Fields.InvalidMessage_account_base_number(2)
          ,CL_Fields.InvalidMessage_collateral_indicator(1)
          ,CL_Fields.InvalidMessage_type_of_collateral_secured_for_this_account(1)
          ,CL_Fields.InvalidMessage_collateral_description(1)
          ,CL_Fields.InvalidMessage_ucc_filing_number(1)
          ,CL_Fields.InvalidMessage_ucc_filing_type(1)
          ,CL_Fields.InvalidMessage_ucc_filing_date(1),CL_Fields.InvalidMessage_ucc_filing_date(2),CL_Fields.InvalidMessage_ucc_filing_date(3)
          ,CL_Fields.InvalidMessage_ucc_filing_expiration_date(1),CL_Fields.InvalidMessage_ucc_filing_expiration_date(2),CL_Fields.InvalidMessage_ucc_filing_expiration_date(3)
          ,CL_Fields.InvalidMessage_ucc_filing_jurisdiction(1)
          ,CL_Fields.InvalidMessage_ucc_filing_description(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.collateral_indicator_ENUM_ErrorCount
          ,le.type_of_collateral_secured_for_this_account_ENUM_ErrorCount
          ,le.collateral_description_ALLOW_ErrorCount
          ,le.ucc_filing_number_ALLOW_ErrorCount
          ,le.ucc_filing_type_ALLOW_ErrorCount
          ,le.ucc_filing_date_ALLOW_ErrorCount,le.ucc_filing_date_CUSTOM_ErrorCount,le.ucc_filing_date_LENGTH_ErrorCount
          ,le.ucc_filing_expiration_date_ALLOW_ErrorCount,le.ucc_filing_expiration_date_CUSTOM_ErrorCount,le.ucc_filing_expiration_date_LENGTH_ErrorCount
          ,le.ucc_filing_jurisdiction_ALLOW_ErrorCount
          ,le.ucc_filing_description_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.collateral_indicator_ENUM_ErrorCount
          ,le.type_of_collateral_secured_for_this_account_ENUM_ErrorCount
          ,le.collateral_description_ALLOW_ErrorCount
          ,le.ucc_filing_number_ALLOW_ErrorCount
          ,le.ucc_filing_type_ALLOW_ErrorCount
          ,le.ucc_filing_date_ALLOW_ErrorCount,le.ucc_filing_date_CUSTOM_ErrorCount,le.ucc_filing_date_LENGTH_ErrorCount
          ,le.ucc_filing_expiration_date_ALLOW_ErrorCount,le.ucc_filing_expiration_date_CUSTOM_ErrorCount,le.ucc_filing_expiration_date_LENGTH_ErrorCount
          ,le.ucc_filing_jurisdiction_ALLOW_ErrorCount
          ,le.ucc_filing_description_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,20,Into(LEFT,COUNTER));
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
