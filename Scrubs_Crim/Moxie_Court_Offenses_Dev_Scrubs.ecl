IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_Court_Offenses_Dev_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 23;
  EXPORT NumRulesFromFieldType := 23;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 23;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Moxie_Court_Offenses_Dev_Layout_crim)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 offender_key_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 source_file_Invalid;
    UNSIGNED1 off_date_Invalid;
    UNSIGNED1 arr_date_Invalid;
    UNSIGNED1 arr_off_lev_Invalid;
    UNSIGNED1 arr_disp_date_Invalid;
    UNSIGNED1 court_off_lev_Invalid;
    UNSIGNED1 court_disp_date_Invalid;
    UNSIGNED1 sent_date_Invalid;
    UNSIGNED1 convict_dt_Invalid;
    UNSIGNED1 court_dt_Invalid;
    UNSIGNED1 fcra_conviction_flag_Invalid;
    UNSIGNED1 fcra_traffic_flag_Invalid;
    UNSIGNED1 fcra_date_Invalid;
    UNSIGNED1 fcra_date_type_Invalid;
    UNSIGNED1 conviction_override_date_Invalid;
    UNSIGNED1 conviction_override_date_type_Invalid;
    UNSIGNED1 offense_score_Invalid;
    UNSIGNED1 offense_persistent_id_Invalid;
    UNSIGNED1 offense_category_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Moxie_Court_Offenses_Dev_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Moxie_Court_Offenses_Dev_Layout_crim)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'process_date:Invalid_Current_Date:CUSTOM'
          ,'offender_key:Non_Blank:LENGTHS'
          ,'vendor:Non_Blank:LENGTHS'
          ,'state_origin:Invalid_Char:ALLOW'
          ,'source_file:Non_Blank:LENGTHS'
          ,'off_date:Invalid_Current_Date:CUSTOM'
          ,'arr_date:Invalid_Current_Date:CUSTOM'
          ,'arr_off_lev:Invalid_ArrOffLev:CUSTOM'
          ,'arr_disp_date:Invalid_Current_Date:CUSTOM'
          ,'court_off_lev:Invalid_CourtOffLev:CUSTOM'
          ,'court_disp_date:Invalid_Future_Date:CUSTOM'
          ,'sent_date:Invalid_Future_Date:CUSTOM'
          ,'convict_dt:Invalid_Current_Date:CUSTOM'
          ,'court_dt:Invalid_Future_Date:CUSTOM'
          ,'fcra_conviction_flag:Invalid_FCRAConFlag:ENUM'
          ,'fcra_traffic_flag:Invalid_FCRATrafficFlag:ENUM'
          ,'fcra_date:Invalid_Current_Date:CUSTOM'
          ,'fcra_date_type:Invalid_FCRADateFlag:ENUM'
          ,'conviction_override_date:Invalid_Future_Date:CUSTOM'
          ,'conviction_override_date_type:Invalid_ConOverDateFlag:ENUM'
          ,'offense_score:Invalid_OffenseScore:ENUM'
          ,'offense_persistent_id:Invalid_Num:ALLOW'
          ,'offense_category:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_process_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offender_key(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_vendor(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_state_origin(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_source_file(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_off_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_off_lev(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_disp_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_off_lev(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_disp_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_sent_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_convict_dt(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_dt(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_conviction_flag(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_traffic_flag(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_date_type(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_conviction_override_date(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_conviction_override_date_type(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_score(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_persistent_id(1)
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_category(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Moxie_Court_Offenses_Dev_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.offender_key_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offender_key((SALT311.StrType)le.offender_key);
    SELF.vendor_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_vendor((SALT311.StrType)le.vendor);
    SELF.state_origin_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_state_origin((SALT311.StrType)le.state_origin);
    SELF.source_file_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_source_file((SALT311.StrType)le.source_file);
    SELF.off_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_off_date((SALT311.StrType)le.off_date);
    SELF.arr_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_arr_date((SALT311.StrType)le.arr_date);
    SELF.arr_off_lev_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_lev((SALT311.StrType)le.arr_off_lev);
    SELF.arr_disp_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_arr_disp_date((SALT311.StrType)le.arr_disp_date);
    SELF.court_off_lev_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_court_off_lev((SALT311.StrType)le.court_off_lev);
    SELF.court_disp_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_court_disp_date((SALT311.StrType)le.court_disp_date);
    SELF.sent_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_sent_date((SALT311.StrType)le.sent_date);
    SELF.convict_dt_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_convict_dt((SALT311.StrType)le.convict_dt);
    SELF.court_dt_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_court_dt((SALT311.StrType)le.court_dt);
    SELF.fcra_conviction_flag_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_conviction_flag((SALT311.StrType)le.fcra_conviction_flag);
    SELF.fcra_traffic_flag_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_traffic_flag((SALT311.StrType)le.fcra_traffic_flag);
    SELF.fcra_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_date((SALT311.StrType)le.fcra_date);
    SELF.fcra_date_type_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_date_type((SALT311.StrType)le.fcra_date_type);
    SELF.conviction_override_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_conviction_override_date((SALT311.StrType)le.conviction_override_date);
    SELF.conviction_override_date_type_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_conviction_override_date_type((SALT311.StrType)le.conviction_override_date_type);
    SELF.offense_score_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offense_score((SALT311.StrType)le.offense_score);
    SELF.offense_persistent_id_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offense_persistent_id((SALT311.StrType)le.offense_persistent_id);
    SELF.offense_category_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offense_category((SALT311.StrType)le.offense_category);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Moxie_Court_Offenses_Dev_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.offender_key_Invalid << 1 ) + ( le.vendor_Invalid << 2 ) + ( le.state_origin_Invalid << 3 ) + ( le.source_file_Invalid << 4 ) + ( le.off_date_Invalid << 5 ) + ( le.arr_date_Invalid << 6 ) + ( le.arr_off_lev_Invalid << 7 ) + ( le.arr_disp_date_Invalid << 8 ) + ( le.court_off_lev_Invalid << 9 ) + ( le.court_disp_date_Invalid << 10 ) + ( le.sent_date_Invalid << 11 ) + ( le.convict_dt_Invalid << 12 ) + ( le.court_dt_Invalid << 13 ) + ( le.fcra_conviction_flag_Invalid << 14 ) + ( le.fcra_traffic_flag_Invalid << 15 ) + ( le.fcra_date_Invalid << 16 ) + ( le.fcra_date_type_Invalid << 17 ) + ( le.conviction_override_date_Invalid << 18 ) + ( le.conviction_override_date_type_Invalid << 19 ) + ( le.offense_score_Invalid << 20 ) + ( le.offense_persistent_id_Invalid << 21 ) + ( le.offense_category_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Moxie_Court_Offenses_Dev_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.offender_key_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.source_file_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.off_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.arr_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.arr_off_lev_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.arr_disp_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.court_off_lev_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.court_disp_date_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sent_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.convict_dt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.court_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.fcra_conviction_flag_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.fcra_traffic_flag_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fcra_date_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.fcra_date_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.conviction_override_date_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.conviction_override_date_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.offense_score_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.offense_persistent_id_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.offense_category_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.vendor) vendor := IF(Glob, '', h.vendor);
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    offender_key_LENGTHS_ErrorCount := COUNT(GROUP,h.offender_key_Invalid=1);
    vendor_LENGTHS_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    source_file_LENGTHS_ErrorCount := COUNT(GROUP,h.source_file_Invalid=1);
    off_date_CUSTOM_ErrorCount := COUNT(GROUP,h.off_date_Invalid=1);
    arr_date_CUSTOM_ErrorCount := COUNT(GROUP,h.arr_date_Invalid=1);
    arr_off_lev_CUSTOM_ErrorCount := COUNT(GROUP,h.arr_off_lev_Invalid=1);
    arr_disp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.arr_disp_date_Invalid=1);
    court_off_lev_CUSTOM_ErrorCount := COUNT(GROUP,h.court_off_lev_Invalid=1);
    court_disp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.court_disp_date_Invalid=1);
    sent_date_CUSTOM_ErrorCount := COUNT(GROUP,h.sent_date_Invalid=1);
    convict_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.convict_dt_Invalid=1);
    court_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.court_dt_Invalid=1);
    fcra_conviction_flag_ENUM_ErrorCount := COUNT(GROUP,h.fcra_conviction_flag_Invalid=1);
    fcra_traffic_flag_ENUM_ErrorCount := COUNT(GROUP,h.fcra_traffic_flag_Invalid=1);
    fcra_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fcra_date_Invalid=1);
    fcra_date_type_ENUM_ErrorCount := COUNT(GROUP,h.fcra_date_type_Invalid=1);
    conviction_override_date_CUSTOM_ErrorCount := COUNT(GROUP,h.conviction_override_date_Invalid=1);
    conviction_override_date_type_ENUM_ErrorCount := COUNT(GROUP,h.conviction_override_date_type_Invalid=1);
    offense_score_ENUM_ErrorCount := COUNT(GROUP,h.offense_score_Invalid=1);
    offense_persistent_id_ALLOW_ErrorCount := COUNT(GROUP,h.offense_persistent_id_Invalid=1);
    offense_category_ALLOW_ErrorCount := COUNT(GROUP,h.offense_category_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.offender_key_Invalid > 0 OR h.vendor_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.source_file_Invalid > 0 OR h.off_date_Invalid > 0 OR h.arr_date_Invalid > 0 OR h.arr_off_lev_Invalid > 0 OR h.arr_disp_date_Invalid > 0 OR h.court_off_lev_Invalid > 0 OR h.court_disp_date_Invalid > 0 OR h.sent_date_Invalid > 0 OR h.convict_dt_Invalid > 0 OR h.court_dt_Invalid > 0 OR h.fcra_conviction_flag_Invalid > 0 OR h.fcra_traffic_flag_Invalid > 0 OR h.fcra_date_Invalid > 0 OR h.fcra_date_type_Invalid > 0 OR h.conviction_override_date_Invalid > 0 OR h.conviction_override_date_type_Invalid > 0 OR h.offense_score_Invalid > 0 OR h.offense_persistent_id_Invalid > 0 OR h.offense_category_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.offender_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_file_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.off_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_off_lev_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_disp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.court_off_lev_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.court_disp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sent_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.convict_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.court_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_conviction_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fcra_traffic_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fcra_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.offense_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.offense_persistent_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.offense_category_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.offender_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_file_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.off_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_off_lev_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_disp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.court_off_lev_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.court_disp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sent_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.convict_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.court_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_conviction_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fcra_traffic_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fcra_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.offense_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.offense_persistent_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.offense_category_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.offender_key_Invalid,le.vendor_Invalid,le.state_origin_Invalid,le.source_file_Invalid,le.off_date_Invalid,le.arr_date_Invalid,le.arr_off_lev_Invalid,le.arr_disp_date_Invalid,le.court_off_lev_Invalid,le.court_disp_date_Invalid,le.sent_date_Invalid,le.convict_dt_Invalid,le.court_dt_Invalid,le.fcra_conviction_flag_Invalid,le.fcra_traffic_flag_Invalid,le.fcra_date_Invalid,le.fcra_date_type_Invalid,le.conviction_override_date_Invalid,le.conviction_override_date_type_Invalid,le.offense_score_Invalid,le.offense_persistent_id_Invalid,le.offense_category_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_process_date(le.process_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offender_key(le.offender_key_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_vendor(le.vendor_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_source_file(le.source_file_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_off_date(le.off_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_date(le.arr_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_off_lev(le.arr_off_lev_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_disp_date(le.arr_disp_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_off_lev(le.court_off_lev_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_disp_date(le.court_disp_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_sent_date(le.sent_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_convict_dt(le.convict_dt_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_dt(le.court_dt_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_conviction_flag(le.fcra_conviction_flag_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_traffic_flag(le.fcra_traffic_flag_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_date(le.fcra_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_date_type(le.fcra_date_type_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_conviction_override_date(le.conviction_override_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_conviction_override_date_type(le.conviction_override_date_type_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_score(le.offense_score_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_persistent_id(le.offense_persistent_id_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_category(le.offense_category_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_key_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_file_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.off_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.arr_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.arr_off_lev_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.arr_disp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.court_off_lev_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.court_disp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sent_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.convict_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.court_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcra_conviction_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fcra_traffic_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fcra_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcra_date_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.offense_score_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.offense_persistent_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_category_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','offender_key','vendor','state_origin','source_file','off_date','arr_date','arr_off_lev','arr_disp_date','court_off_lev','court_disp_date','sent_date','convict_dt','court_dt','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Current_Date','Non_Blank','Non_Blank','Invalid_Char','Non_Blank','Invalid_Current_Date','Invalid_Current_Date','Invalid_ArrOffLev','Invalid_Current_Date','Invalid_CourtOffLev','Invalid_Future_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Future_Date','Invalid_FCRAConFlag','Invalid_FCRATrafficFlag','Invalid_Current_Date','Invalid_FCRADateFlag','Invalid_Future_Date','Invalid_ConOverDateFlag','Invalid_OffenseScore','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.offender_key,(SALT311.StrType)le.vendor,(SALT311.StrType)le.state_origin,(SALT311.StrType)le.source_file,(SALT311.StrType)le.off_date,(SALT311.StrType)le.arr_date,(SALT311.StrType)le.arr_off_lev,(SALT311.StrType)le.arr_disp_date,(SALT311.StrType)le.court_off_lev,(SALT311.StrType)le.court_disp_date,(SALT311.StrType)le.sent_date,(SALT311.StrType)le.convict_dt,(SALT311.StrType)le.court_dt,(SALT311.StrType)le.fcra_conviction_flag,(SALT311.StrType)le.fcra_traffic_flag,(SALT311.StrType)le.fcra_date,(SALT311.StrType)le.fcra_date_type,(SALT311.StrType)le.conviction_override_date,(SALT311.StrType)le.conviction_override_date_type,(SALT311.StrType)le.offense_score,(SALT311.StrType)le.offense_persistent_id,(SALT311.StrType)le.offense_category,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Moxie_Court_Offenses_Dev_Layout_crim) prevDS = DATASET([], Moxie_Court_Offenses_Dev_Layout_crim)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTHS_ErrorCount
          ,le.vendor_LENGTHS_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.source_file_LENGTHS_ErrorCount
          ,le.off_date_CUSTOM_ErrorCount
          ,le.arr_date_CUSTOM_ErrorCount
          ,le.arr_off_lev_CUSTOM_ErrorCount
          ,le.arr_disp_date_CUSTOM_ErrorCount
          ,le.court_off_lev_CUSTOM_ErrorCount
          ,le.court_disp_date_CUSTOM_ErrorCount
          ,le.sent_date_CUSTOM_ErrorCount
          ,le.convict_dt_CUSTOM_ErrorCount
          ,le.court_dt_CUSTOM_ErrorCount
          ,le.fcra_conviction_flag_ENUM_ErrorCount
          ,le.fcra_traffic_flag_ENUM_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.fcra_date_type_ENUM_ErrorCount
          ,le.conviction_override_date_CUSTOM_ErrorCount
          ,le.conviction_override_date_type_ENUM_ErrorCount
          ,le.offense_score_ENUM_ErrorCount
          ,le.offense_persistent_id_ALLOW_ErrorCount
          ,le.offense_category_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTHS_ErrorCount
          ,le.vendor_LENGTHS_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.source_file_LENGTHS_ErrorCount
          ,le.off_date_CUSTOM_ErrorCount
          ,le.arr_date_CUSTOM_ErrorCount
          ,le.arr_off_lev_CUSTOM_ErrorCount
          ,le.arr_disp_date_CUSTOM_ErrorCount
          ,le.court_off_lev_CUSTOM_ErrorCount
          ,le.court_disp_date_CUSTOM_ErrorCount
          ,le.sent_date_CUSTOM_ErrorCount
          ,le.convict_dt_CUSTOM_ErrorCount
          ,le.court_dt_CUSTOM_ErrorCount
          ,le.fcra_conviction_flag_ENUM_ErrorCount
          ,le.fcra_traffic_flag_ENUM_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.fcra_date_type_ENUM_ErrorCount
          ,le.conviction_override_date_CUSTOM_ErrorCount
          ,le.conviction_override_date_type_ENUM_ErrorCount
          ,le.offense_score_ENUM_ErrorCount
          ,le.offense_persistent_id_ALLOW_ErrorCount
          ,le.offense_category_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Moxie_Court_Offenses_Dev_hygiene(PROJECT(h, Moxie_Court_Offenses_Dev_Layout_crim));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offender_key:' + getFieldTypeText(h.offender_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_file:' + getFieldTypeText(h.source_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_type:' + getFieldTypeText(h.data_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_comp:' + getFieldTypeText(h.off_comp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_delete_flag:' + getFieldTypeText(h.off_delete_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_date:' + getFieldTypeText(h.off_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_date:' + getFieldTypeText(h.arr_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'num_of_counts:' + getFieldTypeText(h.num_of_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'le_agency_cd:' + getFieldTypeText(h.le_agency_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'le_agency_desc:' + getFieldTypeText(h.le_agency_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'le_agency_case_number:' + getFieldTypeText(h.le_agency_case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'traffic_ticket_number:' + getFieldTypeText(h.traffic_ticket_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'traffic_dl_no:' + getFieldTypeText(h.traffic_dl_no) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'traffic_dl_st:' + getFieldTypeText(h.traffic_dl_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_code:' + getFieldTypeText(h.arr_off_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_desc_1:' + getFieldTypeText(h.arr_off_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_desc_2:' + getFieldTypeText(h.arr_off_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_type_cd:' + getFieldTypeText(h.arr_off_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_type_desc:' + getFieldTypeText(h.arr_off_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_lev:' + getFieldTypeText(h.arr_off_lev) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_statute:' + getFieldTypeText(h.arr_statute) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_statute_desc:' + getFieldTypeText(h.arr_statute_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_date:' + getFieldTypeText(h.arr_disp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_code:' + getFieldTypeText(h.arr_disp_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_desc_1:' + getFieldTypeText(h.arr_disp_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_desc_2:' + getFieldTypeText(h.arr_disp_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_refer_cd:' + getFieldTypeText(h.pros_refer_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_refer:' + getFieldTypeText(h.pros_refer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_assgn_cd:' + getFieldTypeText(h.pros_assgn_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_assgn:' + getFieldTypeText(h.pros_assgn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_chg_rej:' + getFieldTypeText(h.pros_chg_rej) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_off_code:' + getFieldTypeText(h.pros_off_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_off_desc_1:' + getFieldTypeText(h.pros_off_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_off_desc_2:' + getFieldTypeText(h.pros_off_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_off_type_cd:' + getFieldTypeText(h.pros_off_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_off_type_desc:' + getFieldTypeText(h.pros_off_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_off_lev:' + getFieldTypeText(h.pros_off_lev) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pros_act_filed:' + getFieldTypeText(h.pros_act_filed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_case_number:' + getFieldTypeText(h.court_case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_cd:' + getFieldTypeText(h.court_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_desc:' + getFieldTypeText(h.court_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_appeal_flag:' + getFieldTypeText(h.court_appeal_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_final_plea:' + getFieldTypeText(h.court_final_plea) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_code:' + getFieldTypeText(h.court_off_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_desc_1:' + getFieldTypeText(h.court_off_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_desc_2:' + getFieldTypeText(h.court_off_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_type_cd:' + getFieldTypeText(h.court_off_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_type_desc:' + getFieldTypeText(h.court_off_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_lev:' + getFieldTypeText(h.court_off_lev) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_statute:' + getFieldTypeText(h.court_statute) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_additional_statutes:' + getFieldTypeText(h.court_additional_statutes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_statute_desc:' + getFieldTypeText(h.court_statute_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_disp_date:' + getFieldTypeText(h.court_disp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_disp_code:' + getFieldTypeText(h.court_disp_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_disp_desc_1:' + getFieldTypeText(h.court_disp_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_disp_desc_2:' + getFieldTypeText(h.court_disp_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_date:' + getFieldTypeText(h.sent_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_jail:' + getFieldTypeText(h.sent_jail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_susp_time:' + getFieldTypeText(h.sent_susp_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_court_cost:' + getFieldTypeText(h.sent_court_cost) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_court_fine:' + getFieldTypeText(h.sent_court_fine) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_susp_court_fine:' + getFieldTypeText(h.sent_susp_court_fine) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_probation:' + getFieldTypeText(h.sent_probation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_addl_prov_code:' + getFieldTypeText(h.sent_addl_prov_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_addl_prov_desc_1:' + getFieldTypeText(h.sent_addl_prov_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_addl_prov_desc_2:' + getFieldTypeText(h.sent_addl_prov_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_consec:' + getFieldTypeText(h.sent_consec) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_agency_rec_cust_ori:' + getFieldTypeText(h.sent_agency_rec_cust_ori) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sent_agency_rec_cust:' + getFieldTypeText(h.sent_agency_rec_cust) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appeal_date:' + getFieldTypeText(h.appeal_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appeal_off_disp:' + getFieldTypeText(h.appeal_off_disp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appeal_final_decision:' + getFieldTypeText(h.appeal_final_decision) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'convict_dt:' + getFieldTypeText(h.convict_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_town:' + getFieldTypeText(h.offense_town) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cty_conv:' + getFieldTypeText(h.cty_conv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'restitution:' + getFieldTypeText(h.restitution) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'community_service:' + getFieldTypeText(h.community_service) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parole:' + getFieldTypeText(h.parole) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addl_sent_dates:' + getFieldTypeText(h.addl_sent_dates) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probation_desc2:' + getFieldTypeText(h.probation_desc2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_dt:' + getFieldTypeText(h.court_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_county:' + getFieldTypeText(h.court_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_off_lev_mapped:' + getFieldTypeText(h.arr_off_lev_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_off_lev_mapped:' + getFieldTypeText(h.court_off_lev_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_offense_key:' + getFieldTypeText(h.fcra_offense_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_conviction_flag:' + getFieldTypeText(h.fcra_conviction_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_traffic_flag:' + getFieldTypeText(h.fcra_traffic_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_date:' + getFieldTypeText(h.fcra_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_date_type:' + getFieldTypeText(h.fcra_date_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conviction_override_date:' + getFieldTypeText(h.conviction_override_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conviction_override_date_type:' + getFieldTypeText(h.conviction_override_date_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_score:' + getFieldTypeText(h.offense_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_persistent_id:' + getFieldTypeText(h.offense_persistent_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_category:' + getFieldTypeText(h.offense_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_offender_key_cnt
          ,le.populated_vendor_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_source_file_cnt
          ,le.populated_data_type_cnt
          ,le.populated_off_comp_cnt
          ,le.populated_off_delete_flag_cnt
          ,le.populated_off_date_cnt
          ,le.populated_arr_date_cnt
          ,le.populated_num_of_counts_cnt
          ,le.populated_le_agency_cd_cnt
          ,le.populated_le_agency_desc_cnt
          ,le.populated_le_agency_case_number_cnt
          ,le.populated_traffic_ticket_number_cnt
          ,le.populated_traffic_dl_no_cnt
          ,le.populated_traffic_dl_st_cnt
          ,le.populated_arr_off_code_cnt
          ,le.populated_arr_off_desc_1_cnt
          ,le.populated_arr_off_desc_2_cnt
          ,le.populated_arr_off_type_cd_cnt
          ,le.populated_arr_off_type_desc_cnt
          ,le.populated_arr_off_lev_cnt
          ,le.populated_arr_statute_cnt
          ,le.populated_arr_statute_desc_cnt
          ,le.populated_arr_disp_date_cnt
          ,le.populated_arr_disp_code_cnt
          ,le.populated_arr_disp_desc_1_cnt
          ,le.populated_arr_disp_desc_2_cnt
          ,le.populated_pros_refer_cd_cnt
          ,le.populated_pros_refer_cnt
          ,le.populated_pros_assgn_cd_cnt
          ,le.populated_pros_assgn_cnt
          ,le.populated_pros_chg_rej_cnt
          ,le.populated_pros_off_code_cnt
          ,le.populated_pros_off_desc_1_cnt
          ,le.populated_pros_off_desc_2_cnt
          ,le.populated_pros_off_type_cd_cnt
          ,le.populated_pros_off_type_desc_cnt
          ,le.populated_pros_off_lev_cnt
          ,le.populated_pros_act_filed_cnt
          ,le.populated_court_case_number_cnt
          ,le.populated_court_cd_cnt
          ,le.populated_court_desc_cnt
          ,le.populated_court_appeal_flag_cnt
          ,le.populated_court_final_plea_cnt
          ,le.populated_court_off_code_cnt
          ,le.populated_court_off_desc_1_cnt
          ,le.populated_court_off_desc_2_cnt
          ,le.populated_court_off_type_cd_cnt
          ,le.populated_court_off_type_desc_cnt
          ,le.populated_court_off_lev_cnt
          ,le.populated_court_statute_cnt
          ,le.populated_court_additional_statutes_cnt
          ,le.populated_court_statute_desc_cnt
          ,le.populated_court_disp_date_cnt
          ,le.populated_court_disp_code_cnt
          ,le.populated_court_disp_desc_1_cnt
          ,le.populated_court_disp_desc_2_cnt
          ,le.populated_sent_date_cnt
          ,le.populated_sent_jail_cnt
          ,le.populated_sent_susp_time_cnt
          ,le.populated_sent_court_cost_cnt
          ,le.populated_sent_court_fine_cnt
          ,le.populated_sent_susp_court_fine_cnt
          ,le.populated_sent_probation_cnt
          ,le.populated_sent_addl_prov_code_cnt
          ,le.populated_sent_addl_prov_desc_1_cnt
          ,le.populated_sent_addl_prov_desc_2_cnt
          ,le.populated_sent_consec_cnt
          ,le.populated_sent_agency_rec_cust_ori_cnt
          ,le.populated_sent_agency_rec_cust_cnt
          ,le.populated_appeal_date_cnt
          ,le.populated_appeal_off_disp_cnt
          ,le.populated_appeal_final_decision_cnt
          ,le.populated_convict_dt_cnt
          ,le.populated_offense_town_cnt
          ,le.populated_cty_conv_cnt
          ,le.populated_restitution_cnt
          ,le.populated_community_service_cnt
          ,le.populated_parole_cnt
          ,le.populated_addl_sent_dates_cnt
          ,le.populated_probation_desc2_cnt
          ,le.populated_court_dt_cnt
          ,le.populated_court_county_cnt
          ,le.populated_arr_off_lev_mapped_cnt
          ,le.populated_court_off_lev_mapped_cnt
          ,le.populated_fcra_offense_key_cnt
          ,le.populated_fcra_conviction_flag_cnt
          ,le.populated_fcra_traffic_flag_cnt
          ,le.populated_fcra_date_cnt
          ,le.populated_fcra_date_type_cnt
          ,le.populated_conviction_override_date_cnt
          ,le.populated_conviction_override_date_type_cnt
          ,le.populated_offense_score_cnt
          ,le.populated_offense_persistent_id_cnt
          ,le.populated_offense_category_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_offender_key_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_source_file_pcnt
          ,le.populated_data_type_pcnt
          ,le.populated_off_comp_pcnt
          ,le.populated_off_delete_flag_pcnt
          ,le.populated_off_date_pcnt
          ,le.populated_arr_date_pcnt
          ,le.populated_num_of_counts_pcnt
          ,le.populated_le_agency_cd_pcnt
          ,le.populated_le_agency_desc_pcnt
          ,le.populated_le_agency_case_number_pcnt
          ,le.populated_traffic_ticket_number_pcnt
          ,le.populated_traffic_dl_no_pcnt
          ,le.populated_traffic_dl_st_pcnt
          ,le.populated_arr_off_code_pcnt
          ,le.populated_arr_off_desc_1_pcnt
          ,le.populated_arr_off_desc_2_pcnt
          ,le.populated_arr_off_type_cd_pcnt
          ,le.populated_arr_off_type_desc_pcnt
          ,le.populated_arr_off_lev_pcnt
          ,le.populated_arr_statute_pcnt
          ,le.populated_arr_statute_desc_pcnt
          ,le.populated_arr_disp_date_pcnt
          ,le.populated_arr_disp_code_pcnt
          ,le.populated_arr_disp_desc_1_pcnt
          ,le.populated_arr_disp_desc_2_pcnt
          ,le.populated_pros_refer_cd_pcnt
          ,le.populated_pros_refer_pcnt
          ,le.populated_pros_assgn_cd_pcnt
          ,le.populated_pros_assgn_pcnt
          ,le.populated_pros_chg_rej_pcnt
          ,le.populated_pros_off_code_pcnt
          ,le.populated_pros_off_desc_1_pcnt
          ,le.populated_pros_off_desc_2_pcnt
          ,le.populated_pros_off_type_cd_pcnt
          ,le.populated_pros_off_type_desc_pcnt
          ,le.populated_pros_off_lev_pcnt
          ,le.populated_pros_act_filed_pcnt
          ,le.populated_court_case_number_pcnt
          ,le.populated_court_cd_pcnt
          ,le.populated_court_desc_pcnt
          ,le.populated_court_appeal_flag_pcnt
          ,le.populated_court_final_plea_pcnt
          ,le.populated_court_off_code_pcnt
          ,le.populated_court_off_desc_1_pcnt
          ,le.populated_court_off_desc_2_pcnt
          ,le.populated_court_off_type_cd_pcnt
          ,le.populated_court_off_type_desc_pcnt
          ,le.populated_court_off_lev_pcnt
          ,le.populated_court_statute_pcnt
          ,le.populated_court_additional_statutes_pcnt
          ,le.populated_court_statute_desc_pcnt
          ,le.populated_court_disp_date_pcnt
          ,le.populated_court_disp_code_pcnt
          ,le.populated_court_disp_desc_1_pcnt
          ,le.populated_court_disp_desc_2_pcnt
          ,le.populated_sent_date_pcnt
          ,le.populated_sent_jail_pcnt
          ,le.populated_sent_susp_time_pcnt
          ,le.populated_sent_court_cost_pcnt
          ,le.populated_sent_court_fine_pcnt
          ,le.populated_sent_susp_court_fine_pcnt
          ,le.populated_sent_probation_pcnt
          ,le.populated_sent_addl_prov_code_pcnt
          ,le.populated_sent_addl_prov_desc_1_pcnt
          ,le.populated_sent_addl_prov_desc_2_pcnt
          ,le.populated_sent_consec_pcnt
          ,le.populated_sent_agency_rec_cust_ori_pcnt
          ,le.populated_sent_agency_rec_cust_pcnt
          ,le.populated_appeal_date_pcnt
          ,le.populated_appeal_off_disp_pcnt
          ,le.populated_appeal_final_decision_pcnt
          ,le.populated_convict_dt_pcnt
          ,le.populated_offense_town_pcnt
          ,le.populated_cty_conv_pcnt
          ,le.populated_restitution_pcnt
          ,le.populated_community_service_pcnt
          ,le.populated_parole_pcnt
          ,le.populated_addl_sent_dates_pcnt
          ,le.populated_probation_desc2_pcnt
          ,le.populated_court_dt_pcnt
          ,le.populated_court_county_pcnt
          ,le.populated_arr_off_lev_mapped_pcnt
          ,le.populated_court_off_lev_mapped_pcnt
          ,le.populated_fcra_offense_key_pcnt
          ,le.populated_fcra_conviction_flag_pcnt
          ,le.populated_fcra_traffic_flag_pcnt
          ,le.populated_fcra_date_pcnt
          ,le.populated_fcra_date_type_pcnt
          ,le.populated_conviction_override_date_pcnt
          ,le.populated_conviction_override_date_type_pcnt
          ,le.populated_offense_score_pcnt
          ,le.populated_offense_persistent_id_pcnt
          ,le.populated_offense_category_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,97,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Moxie_Court_Offenses_Dev_Delta(prevDS, PROJECT(h, Moxie_Court_Offenses_Dev_Layout_crim));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),97,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Moxie_Court_Offenses_Dev_Layout_crim) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Crim, Moxie_Court_Offenses_Dev_Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, vendor, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
