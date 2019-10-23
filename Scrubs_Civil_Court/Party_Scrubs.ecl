IMPORT SALT39,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Party_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 19;
  EXPORT NumRulesFromFieldType := 19;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 18;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Party_Layout_Civil_Court)
    UNSIGNED1 dt_first_reported_Invalid;
    UNSIGNED1 dt_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 case_key_Invalid;
    UNSIGNED1 parent_case_key_Invalid;
    UNSIGNED1 court_code_Invalid;
    UNSIGNED1 case_number_Invalid;
    UNSIGNED1 case_type_code_Invalid;
    UNSIGNED1 ruled_for_against_code_Invalid;
    UNSIGNED1 entity_1_Invalid;
    UNSIGNED1 entity_nm_format_1_Invalid;
    UNSIGNED1 entity_type_code_1_orig_Invalid;
    UNSIGNED1 entity_type_code_1_master_Invalid;
    UNSIGNED1 entity_seq_num_1_Invalid;
    UNSIGNED1 atty_seq_num_1_Invalid;
    UNSIGNED1 entity_1_dob_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Party_Layout_Civil_Court)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Party_Layout_Civil_Court) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_reported_Invalid := Party_Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := Party_Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported);
    SELF.process_date_Invalid := Party_Fields.InValid_process_date((SALT39.StrType)le.process_date);
    SELF.vendor_Invalid := Party_Fields.InValid_vendor((SALT39.StrType)le.vendor);
    SELF.state_origin_Invalid := Party_Fields.InValid_state_origin((SALT39.StrType)le.state_origin);
    SELF.case_key_Invalid := Party_Fields.InValid_case_key((SALT39.StrType)le.case_key);
    SELF.parent_case_key_Invalid := Party_Fields.InValid_parent_case_key((SALT39.StrType)le.parent_case_key);
    SELF.court_code_Invalid := Party_Fields.InValid_court_code((SALT39.StrType)le.court_code);
    SELF.case_number_Invalid := Party_Fields.InValid_case_number((SALT39.StrType)le.case_number);
    SELF.case_type_code_Invalid := Party_Fields.InValid_case_type_code((SALT39.StrType)le.case_type_code);
    SELF.ruled_for_against_code_Invalid := Party_Fields.InValid_ruled_for_against_code((SALT39.StrType)le.ruled_for_against_code);
    SELF.entity_1_Invalid := Party_Fields.InValid_entity_1((SALT39.StrType)le.entity_1);
    SELF.entity_nm_format_1_Invalid := Party_Fields.InValid_entity_nm_format_1((SALT39.StrType)le.entity_nm_format_1);
    SELF.entity_type_code_1_orig_Invalid := Party_Fields.InValid_entity_type_code_1_orig((SALT39.StrType)le.entity_type_code_1_orig);
    SELF.entity_type_code_1_master_Invalid := Party_Fields.InValid_entity_type_code_1_master((SALT39.StrType)le.entity_type_code_1_master);
    SELF.entity_seq_num_1_Invalid := Party_Fields.InValid_entity_seq_num_1((SALT39.StrType)le.entity_seq_num_1);
    SELF.atty_seq_num_1_Invalid := Party_Fields.InValid_atty_seq_num_1((SALT39.StrType)le.atty_seq_num_1);
    SELF.entity_1_dob_Invalid := Party_Fields.InValid_entity_1_dob((SALT39.StrType)le.entity_1_dob);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Party_Layout_Civil_Court);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_reported_Invalid << 0 ) + ( le.dt_last_reported_Invalid << 1 ) + ( le.process_date_Invalid << 2 ) + ( le.vendor_Invalid << 3 ) + ( le.state_origin_Invalid << 4 ) + ( le.case_key_Invalid << 5 ) + ( le.parent_case_key_Invalid << 6 ) + ( le.court_code_Invalid << 7 ) + ( le.case_number_Invalid << 8 ) + ( le.case_type_code_Invalid << 9 ) + ( le.ruled_for_against_code_Invalid << 10 ) + ( le.entity_1_Invalid << 11 ) + ( le.entity_nm_format_1_Invalid << 12 ) + ( le.entity_type_code_1_orig_Invalid << 13 ) + ( le.entity_type_code_1_master_Invalid << 14 ) + ( le.entity_seq_num_1_Invalid << 16 ) + ( le.atty_seq_num_1_Invalid << 17 ) + ( le.entity_1_dob_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Party_Layout_Civil_Court);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.case_key_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.parent_case_key_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.court_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.case_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.case_type_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ruled_for_against_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.entity_1_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.entity_nm_format_1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.entity_type_code_1_orig_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.entity_type_code_1_master_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.entity_seq_num_1_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.atty_seq_num_1_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.entity_1_dob_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_reported_Invalid=1);
    dt_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    vendor_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    case_key_ALLOW_ErrorCount := COUNT(GROUP,h.case_key_Invalid=1);
    parent_case_key_ALLOW_ErrorCount := COUNT(GROUP,h.parent_case_key_Invalid=1);
    court_code_ALLOW_ErrorCount := COUNT(GROUP,h.court_code_Invalid=1);
    case_number_ALLOW_ErrorCount := COUNT(GROUP,h.case_number_Invalid=1);
    case_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.case_type_code_Invalid=1);
    ruled_for_against_code_ENUM_ErrorCount := COUNT(GROUP,h.ruled_for_against_code_Invalid=1);
    entity_1_ALLOW_ErrorCount := COUNT(GROUP,h.entity_1_Invalid=1);
    entity_nm_format_1_ENUM_ErrorCount := COUNT(GROUP,h.entity_nm_format_1_Invalid=1);
    entity_type_code_1_orig_ALLOW_ErrorCount := COUNT(GROUP,h.entity_type_code_1_orig_Invalid=1);
    entity_type_code_1_master_ALLOW_ErrorCount := COUNT(GROUP,h.entity_type_code_1_master_Invalid=1);
    entity_type_code_1_master_LENGTHS_ErrorCount := COUNT(GROUP,h.entity_type_code_1_master_Invalid=2);
    entity_type_code_1_master_Total_ErrorCount := COUNT(GROUP,h.entity_type_code_1_master_Invalid>0);
    entity_seq_num_1_ALLOW_ErrorCount := COUNT(GROUP,h.entity_seq_num_1_Invalid=1);
    atty_seq_num_1_ALLOW_ErrorCount := COUNT(GROUP,h.atty_seq_num_1_Invalid=1);
    entity_1_dob_ALLOW_ErrorCount := COUNT(GROUP,h.entity_1_dob_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_reported_Invalid > 0 OR h.dt_last_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.vendor_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.case_key_Invalid > 0 OR h.parent_case_key_Invalid > 0 OR h.court_code_Invalid > 0 OR h.case_number_Invalid > 0 OR h.case_type_code_Invalid > 0 OR h.ruled_for_against_code_Invalid > 0 OR h.entity_1_Invalid > 0 OR h.entity_nm_format_1_Invalid > 0 OR h.entity_type_code_1_orig_Invalid > 0 OR h.entity_type_code_1_master_Invalid > 0 OR h.entity_seq_num_1_Invalid > 0 OR h.atty_seq_num_1_Invalid > 0 OR h.entity_1_dob_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parent_case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.court_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ruled_for_against_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.entity_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_nm_format_1_ENUM_ErrorCount > 0, 1, 0) + IF(le.entity_type_code_1_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_type_code_1_master_Total_ErrorCount > 0, 1, 0) + IF(le.entity_seq_num_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.atty_seq_num_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_1_dob_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parent_case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.court_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ruled_for_against_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.entity_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_nm_format_1_ENUM_ErrorCount > 0, 1, 0) + IF(le.entity_type_code_1_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_type_code_1_master_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_type_code_1_master_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.entity_seq_num_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.atty_seq_num_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_1_dob_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_reported_Invalid,le.dt_last_reported_Invalid,le.process_date_Invalid,le.vendor_Invalid,le.state_origin_Invalid,le.case_key_Invalid,le.parent_case_key_Invalid,le.court_code_Invalid,le.case_number_Invalid,le.case_type_code_Invalid,le.ruled_for_against_code_Invalid,le.entity_1_Invalid,le.entity_nm_format_1_Invalid,le.entity_type_code_1_orig_Invalid,le.entity_type_code_1_master_Invalid,le.entity_seq_num_1_Invalid,le.atty_seq_num_1_Invalid,le.entity_1_dob_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Party_Fields.InvalidMessage_dt_first_reported(le.dt_first_reported_Invalid),Party_Fields.InvalidMessage_dt_last_reported(le.dt_last_reported_Invalid),Party_Fields.InvalidMessage_process_date(le.process_date_Invalid),Party_Fields.InvalidMessage_vendor(le.vendor_Invalid),Party_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Party_Fields.InvalidMessage_case_key(le.case_key_Invalid),Party_Fields.InvalidMessage_parent_case_key(le.parent_case_key_Invalid),Party_Fields.InvalidMessage_court_code(le.court_code_Invalid),Party_Fields.InvalidMessage_case_number(le.case_number_Invalid),Party_Fields.InvalidMessage_case_type_code(le.case_type_code_Invalid),Party_Fields.InvalidMessage_ruled_for_against_code(le.ruled_for_against_code_Invalid),Party_Fields.InvalidMessage_entity_1(le.entity_1_Invalid),Party_Fields.InvalidMessage_entity_nm_format_1(le.entity_nm_format_1_Invalid),Party_Fields.InvalidMessage_entity_type_code_1_orig(le.entity_type_code_1_orig_Invalid),Party_Fields.InvalidMessage_entity_type_code_1_master(le.entity_type_code_1_master_Invalid),Party_Fields.InvalidMessage_entity_seq_num_1(le.entity_seq_num_1_Invalid),Party_Fields.InvalidMessage_atty_seq_num_1(le.atty_seq_num_1_Invalid),Party_Fields.InvalidMessage_entity_1_dob(le.entity_1_dob_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parent_case_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.court_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_type_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ruled_for_against_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.entity_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entity_nm_format_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.entity_type_code_1_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entity_type_code_1_master_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.entity_seq_num_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.atty_seq_num_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entity_1_dob_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','case_key','parent_case_key','court_code','case_number','case_type_code','ruled_for_against_code','entity_1','entity_nm_format_1','entity_type_code_1_orig','entity_type_code_1_master','entity_seq_num_1','atty_seq_num_1','entity_1_dob','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Letter','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_RuledAgainstCode','Invalid_Char','Invalid_EntityNMFormat','Invalid_Char','Invalid_Entity1TypeCode','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.dt_first_reported,(SALT39.StrType)le.dt_last_reported,(SALT39.StrType)le.process_date,(SALT39.StrType)le.vendor,(SALT39.StrType)le.state_origin,(SALT39.StrType)le.case_key,(SALT39.StrType)le.parent_case_key,(SALT39.StrType)le.court_code,(SALT39.StrType)le.case_number,(SALT39.StrType)le.case_type_code,(SALT39.StrType)le.ruled_for_against_code,(SALT39.StrType)le.entity_1,(SALT39.StrType)le.entity_nm_format_1,(SALT39.StrType)le.entity_type_code_1_orig,(SALT39.StrType)le.entity_type_code_1_master,(SALT39.StrType)le.entity_seq_num_1,(SALT39.StrType)le.atty_seq_num_1,(SALT39.StrType)le.entity_1_dob,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Party_Layout_Civil_Court) prevDS = DATASET([], Party_Layout_Civil_Court), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_reported:Invalid_Date:CUSTOM'
          ,'dt_last_reported:Invalid_Date:CUSTOM'
          ,'process_date:Invalid_Date:CUSTOM'
          ,'vendor:Invalid_Num:ALLOW'
          ,'state_origin:Invalid_Letter:ALLOW'
          ,'case_key:Invalid_Char:ALLOW'
          ,'parent_case_key:Invalid_Char:ALLOW'
          ,'court_code:Invalid_Char:ALLOW'
          ,'case_number:Invalid_Char:ALLOW'
          ,'case_type_code:Invalid_Char:ALLOW'
          ,'ruled_for_against_code:Invalid_RuledAgainstCode:ENUM'
          ,'entity_1:Invalid_Char:ALLOW'
          ,'entity_nm_format_1:Invalid_EntityNMFormat:ENUM'
          ,'entity_type_code_1_orig:Invalid_Char:ALLOW'
          ,'entity_type_code_1_master:Invalid_Entity1TypeCode:ALLOW','entity_type_code_1_master:Invalid_Entity1TypeCode:LENGTHS'
          ,'entity_seq_num_1:Invalid_Num:ALLOW'
          ,'atty_seq_num_1:Invalid_Num:ALLOW'
          ,'entity_1_dob:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Party_Fields.InvalidMessage_dt_first_reported(1)
          ,Party_Fields.InvalidMessage_dt_last_reported(1)
          ,Party_Fields.InvalidMessage_process_date(1)
          ,Party_Fields.InvalidMessage_vendor(1)
          ,Party_Fields.InvalidMessage_state_origin(1)
          ,Party_Fields.InvalidMessage_case_key(1)
          ,Party_Fields.InvalidMessage_parent_case_key(1)
          ,Party_Fields.InvalidMessage_court_code(1)
          ,Party_Fields.InvalidMessage_case_number(1)
          ,Party_Fields.InvalidMessage_case_type_code(1)
          ,Party_Fields.InvalidMessage_ruled_for_against_code(1)
          ,Party_Fields.InvalidMessage_entity_1(1)
          ,Party_Fields.InvalidMessage_entity_nm_format_1(1)
          ,Party_Fields.InvalidMessage_entity_type_code_1_orig(1)
          ,Party_Fields.InvalidMessage_entity_type_code_1_master(1),Party_Fields.InvalidMessage_entity_type_code_1_master(2)
          ,Party_Fields.InvalidMessage_entity_seq_num_1(1)
          ,Party_Fields.InvalidMessage_atty_seq_num_1(1)
          ,Party_Fields.InvalidMessage_entity_1_dob(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.case_key_ALLOW_ErrorCount
          ,le.parent_case_key_ALLOW_ErrorCount
          ,le.court_code_ALLOW_ErrorCount
          ,le.case_number_ALLOW_ErrorCount
          ,le.case_type_code_ALLOW_ErrorCount
          ,le.ruled_for_against_code_ENUM_ErrorCount
          ,le.entity_1_ALLOW_ErrorCount
          ,le.entity_nm_format_1_ENUM_ErrorCount
          ,le.entity_type_code_1_orig_ALLOW_ErrorCount
          ,le.entity_type_code_1_master_ALLOW_ErrorCount,le.entity_type_code_1_master_LENGTHS_ErrorCount
          ,le.entity_seq_num_1_ALLOW_ErrorCount
          ,le.atty_seq_num_1_ALLOW_ErrorCount
          ,le.entity_1_dob_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.case_key_ALLOW_ErrorCount
          ,le.parent_case_key_ALLOW_ErrorCount
          ,le.court_code_ALLOW_ErrorCount
          ,le.case_number_ALLOW_ErrorCount
          ,le.case_type_code_ALLOW_ErrorCount
          ,le.ruled_for_against_code_ENUM_ErrorCount
          ,le.entity_1_ALLOW_ErrorCount
          ,le.entity_nm_format_1_ENUM_ErrorCount
          ,le.entity_type_code_1_orig_ALLOW_ErrorCount
          ,le.entity_type_code_1_master_ALLOW_ErrorCount,le.entity_type_code_1_master_LENGTHS_ErrorCount
          ,le.entity_seq_num_1_ALLOW_ErrorCount
          ,le.atty_seq_num_1_ALLOW_ErrorCount
          ,le.entity_1_dob_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Party_hygiene(PROJECT(h, Party_Layout_Civil_Court));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_reported:' + getFieldTypeText(h.dt_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_reported:' + getFieldTypeText(h.dt_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_file:' + getFieldTypeText(h.source_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_key:' + getFieldTypeText(h.case_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parent_case_key:' + getFieldTypeText(h.parent_case_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_code:' + getFieldTypeText(h.court_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court:' + getFieldTypeText(h.court) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_number:' + getFieldTypeText(h.case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_type_code:' + getFieldTypeText(h.case_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_type:' + getFieldTypeText(h.case_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_title:' + getFieldTypeText(h.case_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ruled_for_against_code:' + getFieldTypeText(h.ruled_for_against_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ruled_for_against:' + getFieldTypeText(h.ruled_for_against) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_1:' + getFieldTypeText(h.entity_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_nm_format_1:' + getFieldTypeText(h.entity_nm_format_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_code_1_orig:' + getFieldTypeText(h.entity_type_code_1_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_description_1_orig:' + getFieldTypeText(h.entity_type_description_1_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_code_1_master:' + getFieldTypeText(h.entity_type_code_1_master) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_seq_num_1:' + getFieldTypeText(h.entity_seq_num_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atty_seq_num_1:' + getFieldTypeText(h.atty_seq_num_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_1_address_1:' + getFieldTypeText(h.entity_1_address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_1_address_2:' + getFieldTypeText(h.entity_1_address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_1_address_3:' + getFieldTypeText(h.entity_1_address_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_1_address_4:' + getFieldTypeText(h.entity_1_address_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_1_dob:' + getFieldTypeText(h.entity_1_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_entity_2:' + getFieldTypeText(h.primary_entity_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_nm_format_2:' + getFieldTypeText(h.entity_nm_format_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_code_2_orig:' + getFieldTypeText(h.entity_type_code_2_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_description_2_orig:' + getFieldTypeText(h.entity_type_description_2_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_code_2_master:' + getFieldTypeText(h.entity_type_code_2_master) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_seq_num_2:' + getFieldTypeText(h.entity_seq_num_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atty_seq_num_2:' + getFieldTypeText(h.atty_seq_num_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_2_address_1:' + getFieldTypeText(h.entity_2_address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_2_address_2:' + getFieldTypeText(h.entity_2_address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_2_address_3:' + getFieldTypeText(h.entity_2_address_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_2_address_4:' + getFieldTypeText(h.entity_2_address_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_2_dob:' + getFieldTypeText(h.entity_2_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range1:' + getFieldTypeText(h.prim_range1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir1:' + getFieldTypeText(h.predir1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name1:' + getFieldTypeText(h.prim_name1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix1:' + getFieldTypeText(h.addr_suffix1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir1:' + getFieldTypeText(h.postdir1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig1:' + getFieldTypeText(h.unit_desig1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range1:' + getFieldTypeText(h.sec_range1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name1:' + getFieldTypeText(h.p_city_name1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name1:' + getFieldTypeText(h.v_city_name1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st1:' + getFieldTypeText(h.st1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip1:' + getFieldTypeText(h.zip1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip41:' + getFieldTypeText(h.zip41) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart1:' + getFieldTypeText(h.cart1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz1:' + getFieldTypeText(h.cr_sort_sz1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot1:' + getFieldTypeText(h.lot1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order1:' + getFieldTypeText(h.lot_order1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc1:' + getFieldTypeText(h.dpbc1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit1:' + getFieldTypeText(h.chk_digit1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type1:' + getFieldTypeText(h.rec_type1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st1:' + getFieldTypeText(h.ace_fips_st1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_county1:' + getFieldTypeText(h.ace_fips_county1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat1:' + getFieldTypeText(h.geo_lat1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long1:' + getFieldTypeText(h.geo_long1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa1:' + getFieldTypeText(h.msa1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk1:' + getFieldTypeText(h.geo_blk1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match1:' + getFieldTypeText(h.geo_match1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat1:' + getFieldTypeText(h.err_stat1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range2:' + getFieldTypeText(h.prim_range2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir2:' + getFieldTypeText(h.predir2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name2:' + getFieldTypeText(h.prim_name2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix2:' + getFieldTypeText(h.addr_suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir2:' + getFieldTypeText(h.postdir2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig2:' + getFieldTypeText(h.unit_desig2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range2:' + getFieldTypeText(h.sec_range2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name2:' + getFieldTypeText(h.p_city_name2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name2:' + getFieldTypeText(h.v_city_name2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st2:' + getFieldTypeText(h.st2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip2:' + getFieldTypeText(h.zip2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip42:' + getFieldTypeText(h.zip42) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart2:' + getFieldTypeText(h.cart2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz2:' + getFieldTypeText(h.cr_sort_sz2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot2:' + getFieldTypeText(h.lot2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order2:' + getFieldTypeText(h.lot_order2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc2:' + getFieldTypeText(h.dpbc2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit2:' + getFieldTypeText(h.chk_digit2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type2:' + getFieldTypeText(h.rec_type2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st2:' + getFieldTypeText(h.ace_fips_st2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_county2:' + getFieldTypeText(h.ace_fips_county2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat2:' + getFieldTypeText(h.geo_lat2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long2:' + getFieldTypeText(h.geo_long2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa2:' + getFieldTypeText(h.msa2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk2:' + getFieldTypeText(h.geo_blk2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match2:' + getFieldTypeText(h.geo_match2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat2:' + getFieldTypeText(h.err_stat2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_title1:' + getFieldTypeText(h.e1_title1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_fname1:' + getFieldTypeText(h.e1_fname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_mname1:' + getFieldTypeText(h.e1_mname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_lname1:' + getFieldTypeText(h.e1_lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_suffix1:' + getFieldTypeText(h.e1_suffix1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_pname1_score:' + getFieldTypeText(h.e1_pname1_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_cname1:' + getFieldTypeText(h.e1_cname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_title2:' + getFieldTypeText(h.e1_title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_fname2:' + getFieldTypeText(h.e1_fname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_mname2:' + getFieldTypeText(h.e1_mname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_lname2:' + getFieldTypeText(h.e1_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_suffix2:' + getFieldTypeText(h.e1_suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_pname2_score:' + getFieldTypeText(h.e1_pname2_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_cname2:' + getFieldTypeText(h.e1_cname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_title3:' + getFieldTypeText(h.e1_title3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_fname3:' + getFieldTypeText(h.e1_fname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_mname3:' + getFieldTypeText(h.e1_mname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_lname3:' + getFieldTypeText(h.e1_lname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_suffix3:' + getFieldTypeText(h.e1_suffix3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_pname3_score:' + getFieldTypeText(h.e1_pname3_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_cname3:' + getFieldTypeText(h.e1_cname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_title4:' + getFieldTypeText(h.e1_title4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_fname4:' + getFieldTypeText(h.e1_fname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_mname4:' + getFieldTypeText(h.e1_mname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_lname4:' + getFieldTypeText(h.e1_lname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_suffix4:' + getFieldTypeText(h.e1_suffix4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_pname4_score:' + getFieldTypeText(h.e1_pname4_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_cname4:' + getFieldTypeText(h.e1_cname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_title5:' + getFieldTypeText(h.e1_title5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_fname5:' + getFieldTypeText(h.e1_fname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_mname5:' + getFieldTypeText(h.e1_mname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_lname5:' + getFieldTypeText(h.e1_lname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_suffix5:' + getFieldTypeText(h.e1_suffix5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_pname5_score:' + getFieldTypeText(h.e1_pname5_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e1_cname5:' + getFieldTypeText(h.e1_cname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_title1:' + getFieldTypeText(h.e2_title1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_fname1:' + getFieldTypeText(h.e2_fname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_mname1:' + getFieldTypeText(h.e2_mname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_lname1:' + getFieldTypeText(h.e2_lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_suffix1:' + getFieldTypeText(h.e2_suffix1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_pname1_score:' + getFieldTypeText(h.e2_pname1_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_cname1:' + getFieldTypeText(h.e2_cname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_title2:' + getFieldTypeText(h.e2_title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_fname2:' + getFieldTypeText(h.e2_fname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_mname2:' + getFieldTypeText(h.e2_mname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_lname2:' + getFieldTypeText(h.e2_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_suffix2:' + getFieldTypeText(h.e2_suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_pname2_score:' + getFieldTypeText(h.e2_pname2_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_cname2:' + getFieldTypeText(h.e2_cname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_title3:' + getFieldTypeText(h.e2_title3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_fname3:' + getFieldTypeText(h.e2_fname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_mname3:' + getFieldTypeText(h.e2_mname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_lname3:' + getFieldTypeText(h.e2_lname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_suffix3:' + getFieldTypeText(h.e2_suffix3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_pname3_score:' + getFieldTypeText(h.e2_pname3_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_cname3:' + getFieldTypeText(h.e2_cname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_title4:' + getFieldTypeText(h.e2_title4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_fname4:' + getFieldTypeText(h.e2_fname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_mname4:' + getFieldTypeText(h.e2_mname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_lname4:' + getFieldTypeText(h.e2_lname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_suffix4:' + getFieldTypeText(h.e2_suffix4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_pname4_score:' + getFieldTypeText(h.e2_pname4_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_cname4:' + getFieldTypeText(h.e2_cname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_title5:' + getFieldTypeText(h.e2_title5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_fname5:' + getFieldTypeText(h.e2_fname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_mname5:' + getFieldTypeText(h.e2_mname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_lname5:' + getFieldTypeText(h.e2_lname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_suffix5:' + getFieldTypeText(h.e2_suffix5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_pname5_score:' + getFieldTypeText(h.e2_pname5_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e2_cname5:' + getFieldTypeText(h.e2_cname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_title1:' + getFieldTypeText(h.v1_title1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_fname1:' + getFieldTypeText(h.v1_fname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_mname1:' + getFieldTypeText(h.v1_mname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_lname1:' + getFieldTypeText(h.v1_lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_suffix1:' + getFieldTypeText(h.v1_suffix1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_pname1_score:' + getFieldTypeText(h.v1_pname1_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_cname1:' + getFieldTypeText(h.v1_cname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_title2:' + getFieldTypeText(h.v1_title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_fname2:' + getFieldTypeText(h.v1_fname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_mname2:' + getFieldTypeText(h.v1_mname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_lname2:' + getFieldTypeText(h.v1_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_suffix2:' + getFieldTypeText(h.v1_suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_pname2_score:' + getFieldTypeText(h.v1_pname2_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_cname2:' + getFieldTypeText(h.v1_cname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_title3:' + getFieldTypeText(h.v1_title3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_fname3:' + getFieldTypeText(h.v1_fname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_mname3:' + getFieldTypeText(h.v1_mname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_lname3:' + getFieldTypeText(h.v1_lname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_suffix3:' + getFieldTypeText(h.v1_suffix3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_pname3_score:' + getFieldTypeText(h.v1_pname3_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_cname3:' + getFieldTypeText(h.v1_cname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_title4:' + getFieldTypeText(h.v1_title4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_fname4:' + getFieldTypeText(h.v1_fname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_mname4:' + getFieldTypeText(h.v1_mname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_lname4:' + getFieldTypeText(h.v1_lname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_suffix4:' + getFieldTypeText(h.v1_suffix4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_pname4_score:' + getFieldTypeText(h.v1_pname4_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_cname4:' + getFieldTypeText(h.v1_cname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_title5:' + getFieldTypeText(h.v1_title5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_fname5:' + getFieldTypeText(h.v1_fname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_mname5:' + getFieldTypeText(h.v1_mname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_lname5:' + getFieldTypeText(h.v1_lname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_suffix5:' + getFieldTypeText(h.v1_suffix5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_pname5_score:' + getFieldTypeText(h.v1_pname5_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v1_cname5:' + getFieldTypeText(h.v1_cname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_title1:' + getFieldTypeText(h.v2_title1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_fname1:' + getFieldTypeText(h.v2_fname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_mname1:' + getFieldTypeText(h.v2_mname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_lname1:' + getFieldTypeText(h.v2_lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_suffix1:' + getFieldTypeText(h.v2_suffix1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_pname1_score:' + getFieldTypeText(h.v2_pname1_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_cname1:' + getFieldTypeText(h.v2_cname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_title2:' + getFieldTypeText(h.v2_title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_fname2:' + getFieldTypeText(h.v2_fname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_mname2:' + getFieldTypeText(h.v2_mname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_lname2:' + getFieldTypeText(h.v2_lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_suffix2:' + getFieldTypeText(h.v2_suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_pname2_score:' + getFieldTypeText(h.v2_pname2_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_cname2:' + getFieldTypeText(h.v2_cname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_title3:' + getFieldTypeText(h.v2_title3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_fname3:' + getFieldTypeText(h.v2_fname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_mname3:' + getFieldTypeText(h.v2_mname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_lname3:' + getFieldTypeText(h.v2_lname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_suffix3:' + getFieldTypeText(h.v2_suffix3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_pname3_score:' + getFieldTypeText(h.v2_pname3_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_cname3:' + getFieldTypeText(h.v2_cname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_title4:' + getFieldTypeText(h.v2_title4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_fname4:' + getFieldTypeText(h.v2_fname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_mname4:' + getFieldTypeText(h.v2_mname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_lname4:' + getFieldTypeText(h.v2_lname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_suffix4:' + getFieldTypeText(h.v2_suffix4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_pname4_score:' + getFieldTypeText(h.v2_pname4_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_cname4:' + getFieldTypeText(h.v2_cname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_title5:' + getFieldTypeText(h.v2_title5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_fname5:' + getFieldTypeText(h.v2_fname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_mname5:' + getFieldTypeText(h.v2_mname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_lname5:' + getFieldTypeText(h.v2_lname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_suffix5:' + getFieldTypeText(h.v2_suffix5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_pname5_score:' + getFieldTypeText(h.v2_pname5_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v2_cname5:' + getFieldTypeText(h.v2_cname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_reported_cnt
          ,le.populated_dt_last_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_vendor_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_source_file_cnt
          ,le.populated_case_key_cnt
          ,le.populated_parent_case_key_cnt
          ,le.populated_court_code_cnt
          ,le.populated_court_cnt
          ,le.populated_case_number_cnt
          ,le.populated_case_type_code_cnt
          ,le.populated_case_type_cnt
          ,le.populated_case_title_cnt
          ,le.populated_ruled_for_against_code_cnt
          ,le.populated_ruled_for_against_cnt
          ,le.populated_entity_1_cnt
          ,le.populated_entity_nm_format_1_cnt
          ,le.populated_entity_type_code_1_orig_cnt
          ,le.populated_entity_type_description_1_orig_cnt
          ,le.populated_entity_type_code_1_master_cnt
          ,le.populated_entity_seq_num_1_cnt
          ,le.populated_atty_seq_num_1_cnt
          ,le.populated_entity_1_address_1_cnt
          ,le.populated_entity_1_address_2_cnt
          ,le.populated_entity_1_address_3_cnt
          ,le.populated_entity_1_address_4_cnt
          ,le.populated_entity_1_dob_cnt
          ,le.populated_primary_entity_2_cnt
          ,le.populated_entity_nm_format_2_cnt
          ,le.populated_entity_type_code_2_orig_cnt
          ,le.populated_entity_type_description_2_orig_cnt
          ,le.populated_entity_type_code_2_master_cnt
          ,le.populated_entity_seq_num_2_cnt
          ,le.populated_atty_seq_num_2_cnt
          ,le.populated_entity_2_address_1_cnt
          ,le.populated_entity_2_address_2_cnt
          ,le.populated_entity_2_address_3_cnt
          ,le.populated_entity_2_address_4_cnt
          ,le.populated_entity_2_dob_cnt
          ,le.populated_prim_range1_cnt
          ,le.populated_predir1_cnt
          ,le.populated_prim_name1_cnt
          ,le.populated_addr_suffix1_cnt
          ,le.populated_postdir1_cnt
          ,le.populated_unit_desig1_cnt
          ,le.populated_sec_range1_cnt
          ,le.populated_p_city_name1_cnt
          ,le.populated_v_city_name1_cnt
          ,le.populated_st1_cnt
          ,le.populated_zip1_cnt
          ,le.populated_zip41_cnt
          ,le.populated_cart1_cnt
          ,le.populated_cr_sort_sz1_cnt
          ,le.populated_lot1_cnt
          ,le.populated_lot_order1_cnt
          ,le.populated_dpbc1_cnt
          ,le.populated_chk_digit1_cnt
          ,le.populated_rec_type1_cnt
          ,le.populated_ace_fips_st1_cnt
          ,le.populated_ace_fips_county1_cnt
          ,le.populated_geo_lat1_cnt
          ,le.populated_geo_long1_cnt
          ,le.populated_msa1_cnt
          ,le.populated_geo_blk1_cnt
          ,le.populated_geo_match1_cnt
          ,le.populated_err_stat1_cnt
          ,le.populated_prim_range2_cnt
          ,le.populated_predir2_cnt
          ,le.populated_prim_name2_cnt
          ,le.populated_addr_suffix2_cnt
          ,le.populated_postdir2_cnt
          ,le.populated_unit_desig2_cnt
          ,le.populated_sec_range2_cnt
          ,le.populated_p_city_name2_cnt
          ,le.populated_v_city_name2_cnt
          ,le.populated_st2_cnt
          ,le.populated_zip2_cnt
          ,le.populated_zip42_cnt
          ,le.populated_cart2_cnt
          ,le.populated_cr_sort_sz2_cnt
          ,le.populated_lot2_cnt
          ,le.populated_lot_order2_cnt
          ,le.populated_dpbc2_cnt
          ,le.populated_chk_digit2_cnt
          ,le.populated_rec_type2_cnt
          ,le.populated_ace_fips_st2_cnt
          ,le.populated_ace_fips_county2_cnt
          ,le.populated_geo_lat2_cnt
          ,le.populated_geo_long2_cnt
          ,le.populated_msa2_cnt
          ,le.populated_geo_blk2_cnt
          ,le.populated_geo_match2_cnt
          ,le.populated_err_stat2_cnt
          ,le.populated_e1_title1_cnt
          ,le.populated_e1_fname1_cnt
          ,le.populated_e1_mname1_cnt
          ,le.populated_e1_lname1_cnt
          ,le.populated_e1_suffix1_cnt
          ,le.populated_e1_pname1_score_cnt
          ,le.populated_e1_cname1_cnt
          ,le.populated_e1_title2_cnt
          ,le.populated_e1_fname2_cnt
          ,le.populated_e1_mname2_cnt
          ,le.populated_e1_lname2_cnt
          ,le.populated_e1_suffix2_cnt
          ,le.populated_e1_pname2_score_cnt
          ,le.populated_e1_cname2_cnt
          ,le.populated_e1_title3_cnt
          ,le.populated_e1_fname3_cnt
          ,le.populated_e1_mname3_cnt
          ,le.populated_e1_lname3_cnt
          ,le.populated_e1_suffix3_cnt
          ,le.populated_e1_pname3_score_cnt
          ,le.populated_e1_cname3_cnt
          ,le.populated_e1_title4_cnt
          ,le.populated_e1_fname4_cnt
          ,le.populated_e1_mname4_cnt
          ,le.populated_e1_lname4_cnt
          ,le.populated_e1_suffix4_cnt
          ,le.populated_e1_pname4_score_cnt
          ,le.populated_e1_cname4_cnt
          ,le.populated_e1_title5_cnt
          ,le.populated_e1_fname5_cnt
          ,le.populated_e1_mname5_cnt
          ,le.populated_e1_lname5_cnt
          ,le.populated_e1_suffix5_cnt
          ,le.populated_e1_pname5_score_cnt
          ,le.populated_e1_cname5_cnt
          ,le.populated_e2_title1_cnt
          ,le.populated_e2_fname1_cnt
          ,le.populated_e2_mname1_cnt
          ,le.populated_e2_lname1_cnt
          ,le.populated_e2_suffix1_cnt
          ,le.populated_e2_pname1_score_cnt
          ,le.populated_e2_cname1_cnt
          ,le.populated_e2_title2_cnt
          ,le.populated_e2_fname2_cnt
          ,le.populated_e2_mname2_cnt
          ,le.populated_e2_lname2_cnt
          ,le.populated_e2_suffix2_cnt
          ,le.populated_e2_pname2_score_cnt
          ,le.populated_e2_cname2_cnt
          ,le.populated_e2_title3_cnt
          ,le.populated_e2_fname3_cnt
          ,le.populated_e2_mname3_cnt
          ,le.populated_e2_lname3_cnt
          ,le.populated_e2_suffix3_cnt
          ,le.populated_e2_pname3_score_cnt
          ,le.populated_e2_cname3_cnt
          ,le.populated_e2_title4_cnt
          ,le.populated_e2_fname4_cnt
          ,le.populated_e2_mname4_cnt
          ,le.populated_e2_lname4_cnt
          ,le.populated_e2_suffix4_cnt
          ,le.populated_e2_pname4_score_cnt
          ,le.populated_e2_cname4_cnt
          ,le.populated_e2_title5_cnt
          ,le.populated_e2_fname5_cnt
          ,le.populated_e2_mname5_cnt
          ,le.populated_e2_lname5_cnt
          ,le.populated_e2_suffix5_cnt
          ,le.populated_e2_pname5_score_cnt
          ,le.populated_e2_cname5_cnt
          ,le.populated_v1_title1_cnt
          ,le.populated_v1_fname1_cnt
          ,le.populated_v1_mname1_cnt
          ,le.populated_v1_lname1_cnt
          ,le.populated_v1_suffix1_cnt
          ,le.populated_v1_pname1_score_cnt
          ,le.populated_v1_cname1_cnt
          ,le.populated_v1_title2_cnt
          ,le.populated_v1_fname2_cnt
          ,le.populated_v1_mname2_cnt
          ,le.populated_v1_lname2_cnt
          ,le.populated_v1_suffix2_cnt
          ,le.populated_v1_pname2_score_cnt
          ,le.populated_v1_cname2_cnt
          ,le.populated_v1_title3_cnt
          ,le.populated_v1_fname3_cnt
          ,le.populated_v1_mname3_cnt
          ,le.populated_v1_lname3_cnt
          ,le.populated_v1_suffix3_cnt
          ,le.populated_v1_pname3_score_cnt
          ,le.populated_v1_cname3_cnt
          ,le.populated_v1_title4_cnt
          ,le.populated_v1_fname4_cnt
          ,le.populated_v1_mname4_cnt
          ,le.populated_v1_lname4_cnt
          ,le.populated_v1_suffix4_cnt
          ,le.populated_v1_pname4_score_cnt
          ,le.populated_v1_cname4_cnt
          ,le.populated_v1_title5_cnt
          ,le.populated_v1_fname5_cnt
          ,le.populated_v1_mname5_cnt
          ,le.populated_v1_lname5_cnt
          ,le.populated_v1_suffix5_cnt
          ,le.populated_v1_pname5_score_cnt
          ,le.populated_v1_cname5_cnt
          ,le.populated_v2_title1_cnt
          ,le.populated_v2_fname1_cnt
          ,le.populated_v2_mname1_cnt
          ,le.populated_v2_lname1_cnt
          ,le.populated_v2_suffix1_cnt
          ,le.populated_v2_pname1_score_cnt
          ,le.populated_v2_cname1_cnt
          ,le.populated_v2_title2_cnt
          ,le.populated_v2_fname2_cnt
          ,le.populated_v2_mname2_cnt
          ,le.populated_v2_lname2_cnt
          ,le.populated_v2_suffix2_cnt
          ,le.populated_v2_pname2_score_cnt
          ,le.populated_v2_cname2_cnt
          ,le.populated_v2_title3_cnt
          ,le.populated_v2_fname3_cnt
          ,le.populated_v2_mname3_cnt
          ,le.populated_v2_lname3_cnt
          ,le.populated_v2_suffix3_cnt
          ,le.populated_v2_pname3_score_cnt
          ,le.populated_v2_cname3_cnt
          ,le.populated_v2_title4_cnt
          ,le.populated_v2_fname4_cnt
          ,le.populated_v2_mname4_cnt
          ,le.populated_v2_lname4_cnt
          ,le.populated_v2_suffix4_cnt
          ,le.populated_v2_pname4_score_cnt
          ,le.populated_v2_cname4_cnt
          ,le.populated_v2_title5_cnt
          ,le.populated_v2_fname5_cnt
          ,le.populated_v2_mname5_cnt
          ,le.populated_v2_lname5_cnt
          ,le.populated_v2_suffix5_cnt
          ,le.populated_v2_pname5_score_cnt
          ,le.populated_v2_cname5_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_reported_pcnt
          ,le.populated_dt_last_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_source_file_pcnt
          ,le.populated_case_key_pcnt
          ,le.populated_parent_case_key_pcnt
          ,le.populated_court_code_pcnt
          ,le.populated_court_pcnt
          ,le.populated_case_number_pcnt
          ,le.populated_case_type_code_pcnt
          ,le.populated_case_type_pcnt
          ,le.populated_case_title_pcnt
          ,le.populated_ruled_for_against_code_pcnt
          ,le.populated_ruled_for_against_pcnt
          ,le.populated_entity_1_pcnt
          ,le.populated_entity_nm_format_1_pcnt
          ,le.populated_entity_type_code_1_orig_pcnt
          ,le.populated_entity_type_description_1_orig_pcnt
          ,le.populated_entity_type_code_1_master_pcnt
          ,le.populated_entity_seq_num_1_pcnt
          ,le.populated_atty_seq_num_1_pcnt
          ,le.populated_entity_1_address_1_pcnt
          ,le.populated_entity_1_address_2_pcnt
          ,le.populated_entity_1_address_3_pcnt
          ,le.populated_entity_1_address_4_pcnt
          ,le.populated_entity_1_dob_pcnt
          ,le.populated_primary_entity_2_pcnt
          ,le.populated_entity_nm_format_2_pcnt
          ,le.populated_entity_type_code_2_orig_pcnt
          ,le.populated_entity_type_description_2_orig_pcnt
          ,le.populated_entity_type_code_2_master_pcnt
          ,le.populated_entity_seq_num_2_pcnt
          ,le.populated_atty_seq_num_2_pcnt
          ,le.populated_entity_2_address_1_pcnt
          ,le.populated_entity_2_address_2_pcnt
          ,le.populated_entity_2_address_3_pcnt
          ,le.populated_entity_2_address_4_pcnt
          ,le.populated_entity_2_dob_pcnt
          ,le.populated_prim_range1_pcnt
          ,le.populated_predir1_pcnt
          ,le.populated_prim_name1_pcnt
          ,le.populated_addr_suffix1_pcnt
          ,le.populated_postdir1_pcnt
          ,le.populated_unit_desig1_pcnt
          ,le.populated_sec_range1_pcnt
          ,le.populated_p_city_name1_pcnt
          ,le.populated_v_city_name1_pcnt
          ,le.populated_st1_pcnt
          ,le.populated_zip1_pcnt
          ,le.populated_zip41_pcnt
          ,le.populated_cart1_pcnt
          ,le.populated_cr_sort_sz1_pcnt
          ,le.populated_lot1_pcnt
          ,le.populated_lot_order1_pcnt
          ,le.populated_dpbc1_pcnt
          ,le.populated_chk_digit1_pcnt
          ,le.populated_rec_type1_pcnt
          ,le.populated_ace_fips_st1_pcnt
          ,le.populated_ace_fips_county1_pcnt
          ,le.populated_geo_lat1_pcnt
          ,le.populated_geo_long1_pcnt
          ,le.populated_msa1_pcnt
          ,le.populated_geo_blk1_pcnt
          ,le.populated_geo_match1_pcnt
          ,le.populated_err_stat1_pcnt
          ,le.populated_prim_range2_pcnt
          ,le.populated_predir2_pcnt
          ,le.populated_prim_name2_pcnt
          ,le.populated_addr_suffix2_pcnt
          ,le.populated_postdir2_pcnt
          ,le.populated_unit_desig2_pcnt
          ,le.populated_sec_range2_pcnt
          ,le.populated_p_city_name2_pcnt
          ,le.populated_v_city_name2_pcnt
          ,le.populated_st2_pcnt
          ,le.populated_zip2_pcnt
          ,le.populated_zip42_pcnt
          ,le.populated_cart2_pcnt
          ,le.populated_cr_sort_sz2_pcnt
          ,le.populated_lot2_pcnt
          ,le.populated_lot_order2_pcnt
          ,le.populated_dpbc2_pcnt
          ,le.populated_chk_digit2_pcnt
          ,le.populated_rec_type2_pcnt
          ,le.populated_ace_fips_st2_pcnt
          ,le.populated_ace_fips_county2_pcnt
          ,le.populated_geo_lat2_pcnt
          ,le.populated_geo_long2_pcnt
          ,le.populated_msa2_pcnt
          ,le.populated_geo_blk2_pcnt
          ,le.populated_geo_match2_pcnt
          ,le.populated_err_stat2_pcnt
          ,le.populated_e1_title1_pcnt
          ,le.populated_e1_fname1_pcnt
          ,le.populated_e1_mname1_pcnt
          ,le.populated_e1_lname1_pcnt
          ,le.populated_e1_suffix1_pcnt
          ,le.populated_e1_pname1_score_pcnt
          ,le.populated_e1_cname1_pcnt
          ,le.populated_e1_title2_pcnt
          ,le.populated_e1_fname2_pcnt
          ,le.populated_e1_mname2_pcnt
          ,le.populated_e1_lname2_pcnt
          ,le.populated_e1_suffix2_pcnt
          ,le.populated_e1_pname2_score_pcnt
          ,le.populated_e1_cname2_pcnt
          ,le.populated_e1_title3_pcnt
          ,le.populated_e1_fname3_pcnt
          ,le.populated_e1_mname3_pcnt
          ,le.populated_e1_lname3_pcnt
          ,le.populated_e1_suffix3_pcnt
          ,le.populated_e1_pname3_score_pcnt
          ,le.populated_e1_cname3_pcnt
          ,le.populated_e1_title4_pcnt
          ,le.populated_e1_fname4_pcnt
          ,le.populated_e1_mname4_pcnt
          ,le.populated_e1_lname4_pcnt
          ,le.populated_e1_suffix4_pcnt
          ,le.populated_e1_pname4_score_pcnt
          ,le.populated_e1_cname4_pcnt
          ,le.populated_e1_title5_pcnt
          ,le.populated_e1_fname5_pcnt
          ,le.populated_e1_mname5_pcnt
          ,le.populated_e1_lname5_pcnt
          ,le.populated_e1_suffix5_pcnt
          ,le.populated_e1_pname5_score_pcnt
          ,le.populated_e1_cname5_pcnt
          ,le.populated_e2_title1_pcnt
          ,le.populated_e2_fname1_pcnt
          ,le.populated_e2_mname1_pcnt
          ,le.populated_e2_lname1_pcnt
          ,le.populated_e2_suffix1_pcnt
          ,le.populated_e2_pname1_score_pcnt
          ,le.populated_e2_cname1_pcnt
          ,le.populated_e2_title2_pcnt
          ,le.populated_e2_fname2_pcnt
          ,le.populated_e2_mname2_pcnt
          ,le.populated_e2_lname2_pcnt
          ,le.populated_e2_suffix2_pcnt
          ,le.populated_e2_pname2_score_pcnt
          ,le.populated_e2_cname2_pcnt
          ,le.populated_e2_title3_pcnt
          ,le.populated_e2_fname3_pcnt
          ,le.populated_e2_mname3_pcnt
          ,le.populated_e2_lname3_pcnt
          ,le.populated_e2_suffix3_pcnt
          ,le.populated_e2_pname3_score_pcnt
          ,le.populated_e2_cname3_pcnt
          ,le.populated_e2_title4_pcnt
          ,le.populated_e2_fname4_pcnt
          ,le.populated_e2_mname4_pcnt
          ,le.populated_e2_lname4_pcnt
          ,le.populated_e2_suffix4_pcnt
          ,le.populated_e2_pname4_score_pcnt
          ,le.populated_e2_cname4_pcnt
          ,le.populated_e2_title5_pcnt
          ,le.populated_e2_fname5_pcnt
          ,le.populated_e2_mname5_pcnt
          ,le.populated_e2_lname5_pcnt
          ,le.populated_e2_suffix5_pcnt
          ,le.populated_e2_pname5_score_pcnt
          ,le.populated_e2_cname5_pcnt
          ,le.populated_v1_title1_pcnt
          ,le.populated_v1_fname1_pcnt
          ,le.populated_v1_mname1_pcnt
          ,le.populated_v1_lname1_pcnt
          ,le.populated_v1_suffix1_pcnt
          ,le.populated_v1_pname1_score_pcnt
          ,le.populated_v1_cname1_pcnt
          ,le.populated_v1_title2_pcnt
          ,le.populated_v1_fname2_pcnt
          ,le.populated_v1_mname2_pcnt
          ,le.populated_v1_lname2_pcnt
          ,le.populated_v1_suffix2_pcnt
          ,le.populated_v1_pname2_score_pcnt
          ,le.populated_v1_cname2_pcnt
          ,le.populated_v1_title3_pcnt
          ,le.populated_v1_fname3_pcnt
          ,le.populated_v1_mname3_pcnt
          ,le.populated_v1_lname3_pcnt
          ,le.populated_v1_suffix3_pcnt
          ,le.populated_v1_pname3_score_pcnt
          ,le.populated_v1_cname3_pcnt
          ,le.populated_v1_title4_pcnt
          ,le.populated_v1_fname4_pcnt
          ,le.populated_v1_mname4_pcnt
          ,le.populated_v1_lname4_pcnt
          ,le.populated_v1_suffix4_pcnt
          ,le.populated_v1_pname4_score_pcnt
          ,le.populated_v1_cname4_pcnt
          ,le.populated_v1_title5_pcnt
          ,le.populated_v1_fname5_pcnt
          ,le.populated_v1_mname5_pcnt
          ,le.populated_v1_lname5_pcnt
          ,le.populated_v1_suffix5_pcnt
          ,le.populated_v1_pname5_score_pcnt
          ,le.populated_v1_cname5_pcnt
          ,le.populated_v2_title1_pcnt
          ,le.populated_v2_fname1_pcnt
          ,le.populated_v2_mname1_pcnt
          ,le.populated_v2_lname1_pcnt
          ,le.populated_v2_suffix1_pcnt
          ,le.populated_v2_pname1_score_pcnt
          ,le.populated_v2_cname1_pcnt
          ,le.populated_v2_title2_pcnt
          ,le.populated_v2_fname2_pcnt
          ,le.populated_v2_mname2_pcnt
          ,le.populated_v2_lname2_pcnt
          ,le.populated_v2_suffix2_pcnt
          ,le.populated_v2_pname2_score_pcnt
          ,le.populated_v2_cname2_pcnt
          ,le.populated_v2_title3_pcnt
          ,le.populated_v2_fname3_pcnt
          ,le.populated_v2_mname3_pcnt
          ,le.populated_v2_lname3_pcnt
          ,le.populated_v2_suffix3_pcnt
          ,le.populated_v2_pname3_score_pcnt
          ,le.populated_v2_cname3_pcnt
          ,le.populated_v2_title4_pcnt
          ,le.populated_v2_fname4_pcnt
          ,le.populated_v2_mname4_pcnt
          ,le.populated_v2_lname4_pcnt
          ,le.populated_v2_suffix4_pcnt
          ,le.populated_v2_pname4_score_pcnt
          ,le.populated_v2_cname4_pcnt
          ,le.populated_v2_title5_pcnt
          ,le.populated_v2_fname5_pcnt
          ,le.populated_v2_mname5_pcnt
          ,le.populated_v2_lname5_pcnt
          ,le.populated_v2_suffix5_pcnt
          ,le.populated_v2_pname5_score_pcnt
          ,le.populated_v2_cname5_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,234,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Party_Delta(prevDS, PROJECT(h, Party_Layout_Civil_Court));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),234,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Party_Layout_Civil_Court) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Civil_Court, Party_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
