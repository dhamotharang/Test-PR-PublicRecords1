IMPORT ut,SALT31;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT AH_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(AH_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 previous_member_id_Invalid;
    UNSIGNED1 previous_account_number_Invalid;
    UNSIGNED1 previous_account_type_Invalid;
    UNSIGNED1 type_of_conversion_maintenance_Invalid;
    UNSIGNED1 date_account_converted_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(AH_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(AH_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := AH_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := AH_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := AH_Fields.InValid_parent_sequence_number((SALT31.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := AH_Fields.InValid_account_base_number((SALT31.StrType)le.account_base_number);
    SELF.previous_member_id_Invalid := AH_Fields.InValid_previous_member_id((SALT31.StrType)le.previous_member_id);
    SELF.previous_account_number_Invalid := AH_Fields.InValid_previous_account_number((SALT31.StrType)le.previous_account_number);
    SELF.previous_account_type_Invalid := AH_Fields.InValid_previous_account_type((SALT31.StrType)le.previous_account_type);
    SELF.type_of_conversion_maintenance_Invalid := AH_Fields.InValid_type_of_conversion_maintenance((SALT31.StrType)le.type_of_conversion_maintenance);
    SELF.date_account_converted_Invalid := AH_Fields.InValid_date_account_converted((SALT31.StrType)le.date_account_converted);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.previous_member_id_Invalid << 7 ) + ( le.previous_account_number_Invalid << 8 ) + ( le.previous_account_type_Invalid << 9 ) + ( le.type_of_conversion_maintenance_Invalid << 10 ) + ( le.date_account_converted_Invalid << 11 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,AH_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.previous_member_id_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.previous_account_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.previous_account_type_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.type_of_conversion_maintenance_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.date_account_converted_Invalid := (le.ScrubsBits1 >> 11) & 3;
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
    previous_member_id_ALLOW_ErrorCount := COUNT(GROUP,h.previous_member_id_Invalid=1);
    previous_account_number_ALLOW_ErrorCount := COUNT(GROUP,h.previous_account_number_Invalid=1);
    previous_account_type_ALLOW_ErrorCount := COUNT(GROUP,h.previous_account_type_Invalid=1);
    type_of_conversion_maintenance_ENUM_ErrorCount := COUNT(GROUP,h.type_of_conversion_maintenance_Invalid=1);
    date_account_converted_ALLOW_ErrorCount := COUNT(GROUP,h.date_account_converted_Invalid=1);
    date_account_converted_CUSTOM_ErrorCount := COUNT(GROUP,h.date_account_converted_Invalid=2);
    date_account_converted_LENGTH_ErrorCount := COUNT(GROUP,h.date_account_converted_Invalid=3);
    date_account_converted_Total_ErrorCount := COUNT(GROUP,h.date_account_converted_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.previous_member_id_Invalid,le.previous_account_number_Invalid,le.previous_account_type_Invalid,le.type_of_conversion_maintenance_Invalid,le.date_account_converted_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,AH_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),AH_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),AH_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),AH_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),AH_Fields.InvalidMessage_previous_member_id(le.previous_member_id_Invalid),AH_Fields.InvalidMessage_previous_account_number(le.previous_account_number_Invalid),AH_Fields.InvalidMessage_previous_account_type(le.previous_account_type_Invalid),AH_Fields.InvalidMessage_type_of_conversion_maintenance(le.type_of_conversion_maintenance_Invalid),AH_Fields.InvalidMessage_date_account_converted(le.date_account_converted_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.previous_member_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.previous_account_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.previous_account_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.type_of_conversion_maintenance_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_account_converted_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','previous_member_id','previous_account_number','previous_account_type','type_of_conversion_maintenance','date_account_converted','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_previous_member_id','invalid_previous_account_number','invalid_previous_account_number','invalid_type_of_conversion_maintenance','invalid_date_account_converted','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.parent_sequence_number,(SALT31.StrType)le.account_base_number,(SALT31.StrType)le.previous_member_id,(SALT31.StrType)le.previous_account_number,(SALT31.StrType)le.previous_account_type,(SALT31.StrType)le.type_of_conversion_maintenance,(SALT31.StrType)le.date_account_converted,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
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
          ,'previous_member_id:invalid_previous_member_id:ALLOW'
          ,'previous_account_number:invalid_previous_account_number:ALLOW'
          ,'previous_account_type:invalid_previous_account_number:ALLOW'
          ,'type_of_conversion_maintenance:invalid_type_of_conversion_maintenance:ENUM'
          ,'date_account_converted:invalid_date_account_converted:ALLOW','date_account_converted:invalid_date_account_converted:CUSTOM','date_account_converted:invalid_date_account_converted:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,AH_Fields.InvalidMessage_segment_identifier(1)
          ,AH_Fields.InvalidMessage_file_sequence_number(1),AH_Fields.InvalidMessage_file_sequence_number(2)
          ,AH_Fields.InvalidMessage_parent_sequence_number(1),AH_Fields.InvalidMessage_parent_sequence_number(2)
          ,AH_Fields.InvalidMessage_account_base_number(1),AH_Fields.InvalidMessage_account_base_number(2)
          ,AH_Fields.InvalidMessage_previous_member_id(1)
          ,AH_Fields.InvalidMessage_previous_account_number(1)
          ,AH_Fields.InvalidMessage_previous_account_type(1)
          ,AH_Fields.InvalidMessage_type_of_conversion_maintenance(1)
          ,AH_Fields.InvalidMessage_date_account_converted(1),AH_Fields.InvalidMessage_date_account_converted(2),AH_Fields.InvalidMessage_date_account_converted(3),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.previous_member_id_ALLOW_ErrorCount
          ,le.previous_account_number_ALLOW_ErrorCount
          ,le.previous_account_type_ALLOW_ErrorCount
          ,le.type_of_conversion_maintenance_ENUM_ErrorCount
          ,le.date_account_converted_ALLOW_ErrorCount,le.date_account_converted_CUSTOM_ErrorCount,le.date_account_converted_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTH_ErrorCount
          ,le.previous_member_id_ALLOW_ErrorCount
          ,le.previous_account_number_ALLOW_ErrorCount
          ,le.previous_account_type_ALLOW_ErrorCount
          ,le.type_of_conversion_maintenance_ENUM_ErrorCount
          ,le.date_account_converted_ALLOW_ErrorCount,le.date_account_converted_CUSTOM_ErrorCount,le.date_account_converted_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
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
