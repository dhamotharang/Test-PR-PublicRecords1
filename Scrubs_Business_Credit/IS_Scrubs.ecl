IMPORT ut,SALT31;
EXPORT IS_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(IS_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 original_fname_Invalid;
    UNSIGNED1 original_mname_Invalid;
    UNSIGNED1 original_lname_Invalid;
    UNSIGNED1 original_suffix_Invalid;
    UNSIGNED1 e_mail_address_Invalid;
    UNSIGNED1 guarantor_owner_indicator_Invalid;
    UNSIGNED1 relationship_to_business_indicator_Invalid;
    UNSIGNED1 business_title_Invalid;
    UNSIGNED1 percent_of_liability_Invalid;
    UNSIGNED1 percent_of_ownership_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(IS_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(IS_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := IS_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := IS_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := IS_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := IS_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number);
    SELF.original_fname_Invalid := IS_Fields.InValid_original_fname((SALT31.StrType)le.original_fname);
    SELF.original_mname_Invalid := IS_Fields.InValid_original_mname((SALT31.StrType)le.original_mname);
    SELF.original_lname_Invalid := IS_Fields.InValid_original_lname((SALT31.StrType)le.original_lname);
    SELF.original_suffix_Invalid := IS_Fields.InValid_original_suffix((SALT31.StrType)le.original_suffix);
    SELF.e_mail_address_Invalid := IS_Fields.InValid_e_mail_address((SALT31.StrType)le.e_mail_address);
    SELF.guarantor_owner_indicator_Invalid := IS_Fields.InValid_guarantor_owner_indicator((SALT31.StrType)le.guarantor_owner_indicator);
    SELF.relationship_to_business_indicator_Invalid := IS_Fields.InValid_relationship_to_business_indicator((SALT31.StrType)le.relationship_to_business_indicator);
    SELF.business_title_Invalid := IS_Fields.InValid_business_title((SALT31.StrType)le.business_title);
    SELF.percent_of_liability_Invalid := IS_Fields.InValid_percent_of_liability((SALT31.StrType)le.percent_of_liability);
    SELF.percent_of_ownership_Invalid := IS_Fields.InValid_percent_of_ownership((SALT31.StrType)le.percent_of_ownership);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.original_fname_Invalid << 7 ) + ( le.original_mname_Invalid << 9 ) + ( le.original_lname_Invalid << 10 ) + ( le.original_suffix_Invalid << 12 ) + ( le.e_mail_address_Invalid << 13 ) + ( le.guarantor_owner_indicator_Invalid << 14 ) + ( le.relationship_to_business_indicator_Invalid << 15 ) + ( le.business_title_Invalid << 16 ) + ( le.percent_of_liability_Invalid << 17 ) + ( le.percent_of_ownership_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,IS_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.original_fname_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.original_mname_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.original_lname_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.original_suffix_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.e_mail_address_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.guarantor_owner_indicator_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.relationship_to_business_indicator_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.business_title_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.percent_of_liability_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.percent_of_ownership_Invalid := (le.ScrubsBits1 >> 18) & 1;
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
    original_fname_ALLOW_ErrorCount := COUNT(GROUP,h.original_fname_Invalid=1);
    original_fname_LENGTH_ErrorCount := COUNT(GROUP,h.original_fname_Invalid=2);
    original_fname_Total_ErrorCount := COUNT(GROUP,h.original_fname_Invalid>0);
    original_mname_ALLOW_ErrorCount := COUNT(GROUP,h.original_mname_Invalid=1);
    original_lname_ALLOW_ErrorCount := COUNT(GROUP,h.original_lname_Invalid=1);
    original_lname_LENGTH_ErrorCount := COUNT(GROUP,h.original_lname_Invalid=2);
    original_lname_Total_ErrorCount := COUNT(GROUP,h.original_lname_Invalid>0);
    original_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.original_suffix_Invalid=1);
    e_mail_address_ALLOW_ErrorCount := COUNT(GROUP,h.e_mail_address_Invalid=1);
    guarantor_owner_indicator_ENUM_ErrorCount := COUNT(GROUP,h.guarantor_owner_indicator_Invalid=1);
    relationship_to_business_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.relationship_to_business_indicator_Invalid=1);
    business_title_ALLOW_ErrorCount := COUNT(GROUP,h.business_title_Invalid=1);
    percent_of_liability_ALLOW_ErrorCount := COUNT(GROUP,h.percent_of_liability_Invalid=1);
    percent_of_ownership_ALLOW_ErrorCount := COUNT(GROUP,h.percent_of_ownership_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.original_fname_Invalid,le.original_mname_Invalid,le.original_lname_Invalid,le.original_suffix_Invalid,le.e_mail_address_Invalid,le.guarantor_owner_indicator_Invalid,le.relationship_to_business_indicator_Invalid,le.business_title_Invalid,le.percent_of_liability_Invalid,le.percent_of_ownership_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,IS_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),IS_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),IS_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),IS_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),IS_Fields.InvalidMessage_original_fname(le.original_fname_Invalid),IS_Fields.InvalidMessage_original_mname(le.original_mname_Invalid),IS_Fields.InvalidMessage_original_lname(le.original_lname_Invalid),IS_Fields.InvalidMessage_original_suffix(le.original_suffix_Invalid),IS_Fields.InvalidMessage_e_mail_address(le.e_mail_address_Invalid),IS_Fields.InvalidMessage_guarantor_owner_indicator(le.guarantor_owner_indicator_Invalid),IS_Fields.InvalidMessage_relationship_to_business_indicator(le.relationship_to_business_indicator_Invalid),IS_Fields.InvalidMessage_business_title(le.business_title_Invalid),IS_Fields.InvalidMessage_percent_of_liability(le.percent_of_liability_Invalid),IS_Fields.InvalidMessage_percent_of_ownership(le.percent_of_ownership_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.original_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.original_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.original_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.e_mail_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.guarantor_owner_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.relationship_to_business_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.percent_of_liability_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.percent_of_ownership_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','original_fname','original_mname','original_lname','original_suffix','e_mail_address','guarantor_owner_indicator','relationship_to_business_indicator','business_title','percent_of_liability','percent_of_ownership','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_first_name','invalid_middle_name','invalid_last_name','invalid_suffix','invalid_e_mail_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_business_title','invalid_percent_of_liability','invalid_percent_of_ownership','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.parent_sequence_number,(SALT31.StrType)le.account_base_number,(SALT31.StrType)le.original_fname,(SALT31.StrType)le.original_mname,(SALT31.StrType)le.original_lname,(SALT31.StrType)le.original_suffix,(SALT31.StrType)le.e_mail_address,(SALT31.StrType)le.guarantor_owner_indicator,(SALT31.StrType)le.relationship_to_business_indicator,(SALT31.StrType)le.business_title,(SALT31.StrType)le.percent_of_liability,(SALT31.StrType)le.percent_of_ownership,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,14,Into(LEFT,COUNTER));
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
          ,'original_fname:invalid_first_name:ALLOW','original_fname:invalid_first_name:LENGTH'
          ,'original_mname:invalid_middle_name:ALLOW'
          ,'original_lname:invalid_last_name:ALLOW','original_lname:invalid_last_name:LENGTH'
          ,'original_suffix:invalid_suffix:ALLOW'
          ,'e_mail_address:invalid_e_mail_address:ALLOW'
          ,'guarantor_owner_indicator:invalid_guarantor_owner_indicator:ENUM'
          ,'relationship_to_business_indicator:invalid_relationship_to_business_indicator:ALLOW'
          ,'business_title:invalid_business_title:ALLOW'
          ,'percent_of_liability:invalid_percent_of_liability:ALLOW'
          ,'percent_of_ownership:invalid_percent_of_ownership:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,IS_Fields.InvalidMessage_segment_identifier(1)
          ,IS_Fields.InvalidMessage_file_sequence_number(1),IS_Fields.InvalidMessage_file_sequence_number(2)
          ,IS_Fields.InvalidMessage_parent_sequence_number(1),IS_Fields.InvalidMessage_parent_sequence_number(2)
          ,IS_Fields.InvalidMessage_account_base_number(1),IS_Fields.InvalidMessage_account_base_number(2)
          ,IS_Fields.InvalidMessage_original_fname(1),IS_Fields.InvalidMessage_original_fname(2)
          ,IS_Fields.InvalidMessage_original_mname(1)
          ,IS_Fields.InvalidMessage_original_lname(1),IS_Fields.InvalidMessage_original_lname(2)
          ,IS_Fields.InvalidMessage_original_suffix(1)
          ,IS_Fields.InvalidMessage_e_mail_address(1)
          ,IS_Fields.InvalidMessage_guarantor_owner_indicator(1)
          ,IS_Fields.InvalidMessage_relationship_to_business_indicator(1)
          ,IS_Fields.InvalidMessage_business_title(1)
          ,IS_Fields.InvalidMessage_percent_of_liability(1)
          ,IS_Fields.InvalidMessage_percent_of_ownership(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.original_fname_ALLOW_ErrorCount,le.original_fname_LENGTH_ErrorCount
          ,le.original_mname_ALLOW_ErrorCount
          ,le.original_lname_ALLOW_ErrorCount,le.original_lname_LENGTH_ErrorCount
          ,le.original_suffix_ALLOW_ErrorCount
          ,le.e_mail_address_ALLOW_ErrorCount
          ,le.guarantor_owner_indicator_ENUM_ErrorCount
          ,le.relationship_to_business_indicator_ALLOW_ErrorCount
          ,le.business_title_ALLOW_ErrorCount
          ,le.percent_of_liability_ALLOW_ErrorCount
          ,le.percent_of_ownership_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.original_fname_ALLOW_ErrorCount,le.original_fname_LENGTH_ErrorCount
          ,le.original_mname_ALLOW_ErrorCount
          ,le.original_lname_ALLOW_ErrorCount,le.original_lname_LENGTH_ErrorCount
          ,le.original_suffix_ALLOW_ErrorCount
          ,le.e_mail_address_ALLOW_ErrorCount
          ,le.guarantor_owner_indicator_ENUM_ErrorCount
          ,le.relationship_to_business_indicator_ALLOW_ErrorCount
          ,le.business_title_ALLOW_ErrorCount
          ,le.percent_of_liability_ALLOW_ErrorCount
          ,le.percent_of_ownership_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,19,Into(LEFT,COUNTER));
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
