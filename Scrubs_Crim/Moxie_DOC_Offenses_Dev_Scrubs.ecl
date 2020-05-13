IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_DOC_Offenses_Dev_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 26;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Moxie_DOC_Offenses_Dev_Layout_crim)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 offender_key_Invalid;
    UNSIGNED1 source_file_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 offense_key_Invalid;
    UNSIGNED1 off_date_Invalid;
    UNSIGNED1 arr_date_Invalid;
    UNSIGNED1 total_num_of_offenses_Invalid;
    UNSIGNED1 num_of_counts_Invalid;
    UNSIGNED1 off_typ_Invalid;
    UNSIGNED1 off_lev_Invalid;
    UNSIGNED1 arr_disp_date_Invalid;
    UNSIGNED1 ct_disp_dt_Invalid;
    UNSIGNED1 cty_conv_cd_Invalid;
    UNSIGNED1 stc_dt_Invalid;
    UNSIGNED1 convict_dt_Invalid;
    UNSIGNED1 fcra_conviction_flag_Invalid;
    UNSIGNED1 fcra_traffic_flag_Invalid;
    UNSIGNED1 fcra_date_Invalid;
    UNSIGNED1 fcra_date_type_Invalid;
    UNSIGNED1 conviction_override_date_Invalid;
    UNSIGNED1 conviction_override_date_type_Invalid;
    UNSIGNED1 offense_persistent_id_Invalid;
    UNSIGNED1 offense_category_Invalid;
    UNSIGNED1 hyg_classification_code_Invalid;
    UNSIGNED1 old_ln_offense_score_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Moxie_DOC_Offenses_Dev_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Moxie_DOC_Offenses_Dev_Layout_crim)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'process_date:Invalid_Current_Date:CUSTOM'
          ,'offender_key:Non_Blank:LENGTHS'
          ,'source_file:Non_Blank:LENGTHS'
          ,'orig_state:Invalid_Char:ALLOW'
          ,'offense_key:Non_Blank:LENGTHS'
          ,'off_date:Invalid_Current_Date:CUSTOM'
          ,'arr_date:Invalid_Current_Date:CUSTOM'
          ,'total_num_of_offenses:Invalid_Num:ALLOW'
          ,'num_of_counts:Invalid_Num:ALLOW'
          ,'off_typ:Invalid_Off_Typ:ENUM'
          ,'off_lev:Invalid_OffLev:CUSTOM'
          ,'arr_disp_date:Invalid_Current_Date:CUSTOM'
          ,'ct_disp_dt:Invalid_Current_Date:CUSTOM'
          ,'cty_conv_cd:Invalid_CtyConvCd:ENUM'
          ,'stc_dt:Invalid_Future_Date:CUSTOM'
          ,'convict_dt:Invalid_Current_Date:CUSTOM'
          ,'fcra_conviction_flag:Invalid_FCRAConFlag:ENUM'
          ,'fcra_traffic_flag:Invalid_FCRATrafficFlag:ALLOW'
          ,'fcra_date:Invalid_Current_Date:CUSTOM'
          ,'fcra_date_type:Invalid_FCRADateFlag:ENUM'
          ,'conviction_override_date:Invalid_Future_Date:CUSTOM'
          ,'conviction_override_date_type:Invalid_ConOverDateFlag:ENUM'
          ,'offense_persistent_id:Invalid_Num:ALLOW'
          ,'offense_category:Invalid_Num:ALLOW'
          ,'hyg_classification_code:Invalid_Char:ALLOW'
          ,'old_ln_offense_score:Invalid_OffenseScore:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_process_date(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offender_key(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_source_file(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_orig_state(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_key(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_date(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_arr_date(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_total_num_of_offenses(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_num_of_counts(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_typ(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_lev(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_arr_disp_date(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_ct_disp_dt(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_cty_conv_cd(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_stc_dt(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_convict_dt(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_conviction_flag(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_traffic_flag(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_date(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_date_type(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_conviction_override_date(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_conviction_override_date_type(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_persistent_id(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_category(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_hyg_classification_code(1)
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_old_ln_offense_score(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Moxie_DOC_Offenses_Dev_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.offender_key_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offender_key((SALT311.StrType)le.offender_key);
    SELF.source_file_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_source_file((SALT311.StrType)le.source_file);
    SELF.orig_state_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_orig_state((SALT311.StrType)le.orig_state);
    SELF.offense_key_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offense_key((SALT311.StrType)le.offense_key);
    SELF.off_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_off_date((SALT311.StrType)le.off_date);
    SELF.arr_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_arr_date((SALT311.StrType)le.arr_date);
    SELF.total_num_of_offenses_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_total_num_of_offenses((SALT311.StrType)le.total_num_of_offenses);
    SELF.num_of_counts_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_num_of_counts((SALT311.StrType)le.num_of_counts);
    SELF.off_typ_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_off_typ((SALT311.StrType)le.off_typ);
    SELF.off_lev_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_off_lev((SALT311.StrType)le.off_lev);
    SELF.arr_disp_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_date((SALT311.StrType)le.arr_disp_date);
    SELF.ct_disp_dt_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_ct_disp_dt((SALT311.StrType)le.ct_disp_dt);
    SELF.cty_conv_cd_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_cty_conv_cd((SALT311.StrType)le.cty_conv_cd);
    SELF.stc_dt_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_stc_dt((SALT311.StrType)le.stc_dt);
    SELF.convict_dt_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_convict_dt((SALT311.StrType)le.convict_dt);
    SELF.fcra_conviction_flag_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_conviction_flag((SALT311.StrType)le.fcra_conviction_flag);
    SELF.fcra_traffic_flag_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_traffic_flag((SALT311.StrType)le.fcra_traffic_flag);
    SELF.fcra_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_date((SALT311.StrType)le.fcra_date);
    SELF.fcra_date_type_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_date_type((SALT311.StrType)le.fcra_date_type);
    SELF.conviction_override_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_conviction_override_date((SALT311.StrType)le.conviction_override_date);
    SELF.conviction_override_date_type_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_conviction_override_date_type((SALT311.StrType)le.conviction_override_date_type);
    SELF.offense_persistent_id_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offense_persistent_id((SALT311.StrType)le.offense_persistent_id);
    SELF.offense_category_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offense_category((SALT311.StrType)le.offense_category);
    SELF.hyg_classification_code_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_hyg_classification_code((SALT311.StrType)le.hyg_classification_code);
    SELF.old_ln_offense_score_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_old_ln_offense_score((SALT311.StrType)le.old_ln_offense_score);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Moxie_DOC_Offenses_Dev_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.offender_key_Invalid << 1 ) + ( le.source_file_Invalid << 2 ) + ( le.orig_state_Invalid << 3 ) + ( le.offense_key_Invalid << 4 ) + ( le.off_date_Invalid << 5 ) + ( le.arr_date_Invalid << 6 ) + ( le.total_num_of_offenses_Invalid << 7 ) + ( le.num_of_counts_Invalid << 8 ) + ( le.off_typ_Invalid << 9 ) + ( le.off_lev_Invalid << 10 ) + ( le.arr_disp_date_Invalid << 11 ) + ( le.ct_disp_dt_Invalid << 12 ) + ( le.cty_conv_cd_Invalid << 13 ) + ( le.stc_dt_Invalid << 14 ) + ( le.convict_dt_Invalid << 15 ) + ( le.fcra_conviction_flag_Invalid << 16 ) + ( le.fcra_traffic_flag_Invalid << 17 ) + ( le.fcra_date_Invalid << 18 ) + ( le.fcra_date_type_Invalid << 19 ) + ( le.conviction_override_date_Invalid << 20 ) + ( le.conviction_override_date_type_Invalid << 21 ) + ( le.offense_persistent_id_Invalid << 22 ) + ( le.offense_category_Invalid << 23 ) + ( le.hyg_classification_code_Invalid << 24 ) + ( le.old_ln_offense_score_Invalid << 25 );
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
  EXPORT Infile := PROJECT(h,Moxie_DOC_Offenses_Dev_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.offender_key_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.source_file_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.offense_key_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.off_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.arr_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.total_num_of_offenses_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.num_of_counts_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.off_typ_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.off_lev_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.arr_disp_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.ct_disp_dt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.cty_conv_cd_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.stc_dt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.convict_dt_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fcra_conviction_flag_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.fcra_traffic_flag_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.fcra_date_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.fcra_date_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.conviction_override_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.conviction_override_date_type_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.offense_persistent_id_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.offense_category_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.hyg_classification_code_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.old_ln_offense_score_Invalid := (le.ScrubsBits1 >> 25) & 1;
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
    source_file_LENGTHS_ErrorCount := COUNT(GROUP,h.source_file_Invalid=1);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    offense_key_LENGTHS_ErrorCount := COUNT(GROUP,h.offense_key_Invalid=1);
    off_date_CUSTOM_ErrorCount := COUNT(GROUP,h.off_date_Invalid=1);
    arr_date_CUSTOM_ErrorCount := COUNT(GROUP,h.arr_date_Invalid=1);
    total_num_of_offenses_ALLOW_ErrorCount := COUNT(GROUP,h.total_num_of_offenses_Invalid=1);
    num_of_counts_ALLOW_ErrorCount := COUNT(GROUP,h.num_of_counts_Invalid=1);
    off_typ_ENUM_ErrorCount := COUNT(GROUP,h.off_typ_Invalid=1);
    off_lev_CUSTOM_ErrorCount := COUNT(GROUP,h.off_lev_Invalid=1);
    arr_disp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.arr_disp_date_Invalid=1);
    ct_disp_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ct_disp_dt_Invalid=1);
    cty_conv_cd_ENUM_ErrorCount := COUNT(GROUP,h.cty_conv_cd_Invalid=1);
    stc_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.stc_dt_Invalid=1);
    convict_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.convict_dt_Invalid=1);
    fcra_conviction_flag_ENUM_ErrorCount := COUNT(GROUP,h.fcra_conviction_flag_Invalid=1);
    fcra_traffic_flag_ALLOW_ErrorCount := COUNT(GROUP,h.fcra_traffic_flag_Invalid=1);
    fcra_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fcra_date_Invalid=1);
    fcra_date_type_ENUM_ErrorCount := COUNT(GROUP,h.fcra_date_type_Invalid=1);
    conviction_override_date_CUSTOM_ErrorCount := COUNT(GROUP,h.conviction_override_date_Invalid=1);
    conviction_override_date_type_ENUM_ErrorCount := COUNT(GROUP,h.conviction_override_date_type_Invalid=1);
    offense_persistent_id_ALLOW_ErrorCount := COUNT(GROUP,h.offense_persistent_id_Invalid=1);
    offense_category_ALLOW_ErrorCount := COUNT(GROUP,h.offense_category_Invalid=1);
    hyg_classification_code_ALLOW_ErrorCount := COUNT(GROUP,h.hyg_classification_code_Invalid=1);
    old_ln_offense_score_ENUM_ErrorCount := COUNT(GROUP,h.old_ln_offense_score_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.offender_key_Invalid > 0 OR h.source_file_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.offense_key_Invalid > 0 OR h.off_date_Invalid > 0 OR h.arr_date_Invalid > 0 OR h.total_num_of_offenses_Invalid > 0 OR h.num_of_counts_Invalid > 0 OR h.off_typ_Invalid > 0 OR h.off_lev_Invalid > 0 OR h.arr_disp_date_Invalid > 0 OR h.ct_disp_dt_Invalid > 0 OR h.cty_conv_cd_Invalid > 0 OR h.stc_dt_Invalid > 0 OR h.convict_dt_Invalid > 0 OR h.fcra_conviction_flag_Invalid > 0 OR h.fcra_traffic_flag_Invalid > 0 OR h.fcra_date_Invalid > 0 OR h.fcra_date_type_Invalid > 0 OR h.conviction_override_date_Invalid > 0 OR h.conviction_override_date_type_Invalid > 0 OR h.offense_persistent_id_Invalid > 0 OR h.offense_category_Invalid > 0 OR h.hyg_classification_code_Invalid > 0 OR h.old_ln_offense_score_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.offender_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_file_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.offense_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.off_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_num_of_offenses_ALLOW_ErrorCount > 0, 1, 0) + IF(le.num_of_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.off_typ_ENUM_ErrorCount > 0, 1, 0) + IF(le.off_lev_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_disp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ct_disp_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cty_conv_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.stc_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.convict_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_conviction_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fcra_traffic_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fcra_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.offense_persistent_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.offense_category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hyg_classification_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.old_ln_offense_score_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.offender_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_file_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.offense_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.off_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_num_of_offenses_ALLOW_ErrorCount > 0, 1, 0) + IF(le.num_of_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.off_typ_ENUM_ErrorCount > 0, 1, 0) + IF(le.off_lev_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arr_disp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ct_disp_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cty_conv_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.stc_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.convict_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_conviction_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fcra_traffic_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fcra_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcra_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.conviction_override_date_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.offense_persistent_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.offense_category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hyg_classification_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.old_ln_offense_score_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.offender_key_Invalid,le.source_file_Invalid,le.orig_state_Invalid,le.offense_key_Invalid,le.off_date_Invalid,le.arr_date_Invalid,le.total_num_of_offenses_Invalid,le.num_of_counts_Invalid,le.off_typ_Invalid,le.off_lev_Invalid,le.arr_disp_date_Invalid,le.ct_disp_dt_Invalid,le.cty_conv_cd_Invalid,le.stc_dt_Invalid,le.convict_dt_Invalid,le.fcra_conviction_flag_Invalid,le.fcra_traffic_flag_Invalid,le.fcra_date_Invalid,le.fcra_date_type_Invalid,le.conviction_override_date_Invalid,le.conviction_override_date_type_Invalid,le.offense_persistent_id_Invalid,le.offense_category_Invalid,le.hyg_classification_code_Invalid,le.old_ln_offense_score_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_process_date(le.process_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offender_key(le.offender_key_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_source_file(le.source_file_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_key(le.offense_key_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_date(le.off_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_arr_date(le.arr_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_total_num_of_offenses(le.total_num_of_offenses_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_num_of_counts(le.num_of_counts_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_typ(le.off_typ_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_lev(le.off_lev_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_arr_disp_date(le.arr_disp_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_ct_disp_dt(le.ct_disp_dt_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_cty_conv_cd(le.cty_conv_cd_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_stc_dt(le.stc_dt_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_convict_dt(le.convict_dt_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_conviction_flag(le.fcra_conviction_flag_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_traffic_flag(le.fcra_traffic_flag_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_date(le.fcra_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_date_type(le.fcra_date_type_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_conviction_override_date(le.conviction_override_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_conviction_override_date_type(le.conviction_override_date_type_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_persistent_id(le.offense_persistent_id_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_category(le.offense_category_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_hyg_classification_code(le.hyg_classification_code_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_old_ln_offense_score(le.old_ln_offense_score_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_key_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.source_file_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_key_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.off_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.arr_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_num_of_offenses_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.num_of_counts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.off_typ_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.off_lev_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.arr_disp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ct_disp_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cty_conv_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.stc_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.convict_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcra_conviction_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fcra_traffic_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fcra_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcra_date_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.offense_persistent_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_category_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hyg_classification_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.old_ln_offense_score_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','offender_key','source_file','orig_state','offense_key','off_date','arr_date','total_num_of_offenses','num_of_counts','off_typ','off_lev','arr_disp_date','ct_disp_dt','cty_conv_cd','stc_dt','convict_dt','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_persistent_id','offense_category','hyg_classification_code','old_ln_offense_score','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Current_Date','Non_Blank','Non_Blank','Invalid_Char','Non_Blank','Invalid_Current_Date','Invalid_Current_Date','Invalid_Num','Invalid_Num','Invalid_Off_Typ','Invalid_OffLev','Invalid_Current_Date','Invalid_Current_Date','Invalid_CtyConvCd','Invalid_Future_Date','Invalid_Current_Date','Invalid_FCRAConFlag','Invalid_FCRATrafficFlag','Invalid_Current_Date','Invalid_FCRADateFlag','Invalid_Future_Date','Invalid_ConOverDateFlag','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_OffenseScore','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.offender_key,(SALT311.StrType)le.source_file,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.offense_key,(SALT311.StrType)le.off_date,(SALT311.StrType)le.arr_date,(SALT311.StrType)le.total_num_of_offenses,(SALT311.StrType)le.num_of_counts,(SALT311.StrType)le.off_typ,(SALT311.StrType)le.off_lev,(SALT311.StrType)le.arr_disp_date,(SALT311.StrType)le.ct_disp_dt,(SALT311.StrType)le.cty_conv_cd,(SALT311.StrType)le.stc_dt,(SALT311.StrType)le.convict_dt,(SALT311.StrType)le.fcra_conviction_flag,(SALT311.StrType)le.fcra_traffic_flag,(SALT311.StrType)le.fcra_date,(SALT311.StrType)le.fcra_date_type,(SALT311.StrType)le.conviction_override_date,(SALT311.StrType)le.conviction_override_date_type,(SALT311.StrType)le.offense_persistent_id,(SALT311.StrType)le.offense_category,(SALT311.StrType)le.hyg_classification_code,(SALT311.StrType)le.old_ln_offense_score,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,26,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Moxie_DOC_Offenses_Dev_Layout_crim) prevDS = DATASET([], Moxie_DOC_Offenses_Dev_Layout_crim)):= FUNCTION
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
          ,le.source_file_LENGTHS_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.offense_key_LENGTHS_ErrorCount
          ,le.off_date_CUSTOM_ErrorCount
          ,le.arr_date_CUSTOM_ErrorCount
          ,le.total_num_of_offenses_ALLOW_ErrorCount
          ,le.num_of_counts_ALLOW_ErrorCount
          ,le.off_typ_ENUM_ErrorCount
          ,le.off_lev_CUSTOM_ErrorCount
          ,le.arr_disp_date_CUSTOM_ErrorCount
          ,le.ct_disp_dt_CUSTOM_ErrorCount
          ,le.cty_conv_cd_ENUM_ErrorCount
          ,le.stc_dt_CUSTOM_ErrorCount
          ,le.convict_dt_CUSTOM_ErrorCount
          ,le.fcra_conviction_flag_ENUM_ErrorCount
          ,le.fcra_traffic_flag_ALLOW_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.fcra_date_type_ENUM_ErrorCount
          ,le.conviction_override_date_CUSTOM_ErrorCount
          ,le.conviction_override_date_type_ENUM_ErrorCount
          ,le.offense_persistent_id_ALLOW_ErrorCount
          ,le.offense_category_ALLOW_ErrorCount
          ,le.hyg_classification_code_ALLOW_ErrorCount
          ,le.old_ln_offense_score_ENUM_ErrorCount
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
          ,le.source_file_LENGTHS_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.offense_key_LENGTHS_ErrorCount
          ,le.off_date_CUSTOM_ErrorCount
          ,le.arr_date_CUSTOM_ErrorCount
          ,le.total_num_of_offenses_ALLOW_ErrorCount
          ,le.num_of_counts_ALLOW_ErrorCount
          ,le.off_typ_ENUM_ErrorCount
          ,le.off_lev_CUSTOM_ErrorCount
          ,le.arr_disp_date_CUSTOM_ErrorCount
          ,le.ct_disp_dt_CUSTOM_ErrorCount
          ,le.cty_conv_cd_ENUM_ErrorCount
          ,le.stc_dt_CUSTOM_ErrorCount
          ,le.convict_dt_CUSTOM_ErrorCount
          ,le.fcra_conviction_flag_ENUM_ErrorCount
          ,le.fcra_traffic_flag_ALLOW_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.fcra_date_type_ENUM_ErrorCount
          ,le.conviction_override_date_CUSTOM_ErrorCount
          ,le.conviction_override_date_type_ENUM_ErrorCount
          ,le.offense_persistent_id_ALLOW_ErrorCount
          ,le.offense_category_ALLOW_ErrorCount
          ,le.hyg_classification_code_ALLOW_ErrorCount
          ,le.old_ln_offense_score_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Moxie_DOC_Offenses_Dev_hygiene(PROJECT(h, Moxie_DOC_Offenses_Dev_Layout_crim));
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
          ,'county_of_origin:' + getFieldTypeText(h.county_of_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_file:' + getFieldTypeText(h.source_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_type:' + getFieldTypeText(h.data_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_key:' + getFieldTypeText(h.offense_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_date:' + getFieldTypeText(h.off_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_date:' + getFieldTypeText(h.arr_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_num:' + getFieldTypeText(h.case_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_num_of_offenses:' + getFieldTypeText(h.total_num_of_offenses) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'num_of_counts:' + getFieldTypeText(h.num_of_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_code:' + getFieldTypeText(h.off_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chg:' + getFieldTypeText(h.chg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chg_typ_flg:' + getFieldTypeText(h.chg_typ_flg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_of_record:' + getFieldTypeText(h.off_of_record) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_desc_1:' + getFieldTypeText(h.off_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_desc_2:' + getFieldTypeText(h.off_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'add_off_cd:' + getFieldTypeText(h.add_off_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'add_off_desc:' + getFieldTypeText(h.add_off_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_typ:' + getFieldTypeText(h.off_typ) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'off_lev:' + getFieldTypeText(h.off_lev) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_date:' + getFieldTypeText(h.arr_disp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_cd:' + getFieldTypeText(h.arr_disp_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_desc_1:' + getFieldTypeText(h.arr_disp_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_desc_2:' + getFieldTypeText(h.arr_disp_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arr_disp_desc_3:' + getFieldTypeText(h.arr_disp_desc_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_cd:' + getFieldTypeText(h.court_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_desc:' + getFieldTypeText(h.court_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_dist:' + getFieldTypeText(h.ct_dist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_fnl_plea_cd:' + getFieldTypeText(h.ct_fnl_plea_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_fnl_plea:' + getFieldTypeText(h.ct_fnl_plea) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_off_code:' + getFieldTypeText(h.ct_off_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_chg:' + getFieldTypeText(h.ct_chg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_chg_typ_flg:' + getFieldTypeText(h.ct_chg_typ_flg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_off_desc_1:' + getFieldTypeText(h.ct_off_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_off_desc_2:' + getFieldTypeText(h.ct_off_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_addl_desc_cd:' + getFieldTypeText(h.ct_addl_desc_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_off_lev:' + getFieldTypeText(h.ct_off_lev) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_disp_dt:' + getFieldTypeText(h.ct_disp_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_disp_cd:' + getFieldTypeText(h.ct_disp_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_disp_desc_1:' + getFieldTypeText(h.ct_disp_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ct_disp_desc_2:' + getFieldTypeText(h.ct_disp_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cty_conv_cd:' + getFieldTypeText(h.cty_conv_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cty_conv:' + getFieldTypeText(h.cty_conv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adj_wthd:' + getFieldTypeText(h.adj_wthd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_dt:' + getFieldTypeText(h.stc_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_cd:' + getFieldTypeText(h.stc_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_comp:' + getFieldTypeText(h.stc_comp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_desc_1:' + getFieldTypeText(h.stc_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_desc_2:' + getFieldTypeText(h.stc_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_desc_3:' + getFieldTypeText(h.stc_desc_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_desc_4:' + getFieldTypeText(h.stc_desc_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_lgth:' + getFieldTypeText(h.stc_lgth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stc_lgth_desc:' + getFieldTypeText(h.stc_lgth_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inc_adm_dt:' + getFieldTypeText(h.inc_adm_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'min_term:' + getFieldTypeText(h.min_term) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'min_term_desc:' + getFieldTypeText(h.min_term_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'max_term:' + getFieldTypeText(h.max_term) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'max_term_desc:' + getFieldTypeText(h.max_term_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parole:' + getFieldTypeText(h.parole) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probation:' + getFieldTypeText(h.probation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensetown:' + getFieldTypeText(h.offensetown) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'convict_dt:' + getFieldTypeText(h.convict_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_county:' + getFieldTypeText(h.court_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_offense_key:' + getFieldTypeText(h.fcra_offense_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_conviction_flag:' + getFieldTypeText(h.fcra_conviction_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_traffic_flag:' + getFieldTypeText(h.fcra_traffic_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_date:' + getFieldTypeText(h.fcra_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcra_date_type:' + getFieldTypeText(h.fcra_date_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conviction_override_date:' + getFieldTypeText(h.conviction_override_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conviction_override_date_type:' + getFieldTypeText(h.conviction_override_date_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_score:' + getFieldTypeText(h.offense_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_persistent_id:' + getFieldTypeText(h.offense_persistent_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offense_category:' + getFieldTypeText(h.offense_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hyg_classification_code:' + getFieldTypeText(h.hyg_classification_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'old_ln_offense_score:' + getFieldTypeText(h.old_ln_offense_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_offender_key_cnt
          ,le.populated_vendor_cnt
          ,le.populated_county_of_origin_cnt
          ,le.populated_source_file_cnt
          ,le.populated_data_type_cnt
          ,le.populated_record_type_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_offense_key_cnt
          ,le.populated_off_date_cnt
          ,le.populated_arr_date_cnt
          ,le.populated_case_num_cnt
          ,le.populated_total_num_of_offenses_cnt
          ,le.populated_num_of_counts_cnt
          ,le.populated_off_code_cnt
          ,le.populated_chg_cnt
          ,le.populated_chg_typ_flg_cnt
          ,le.populated_off_of_record_cnt
          ,le.populated_off_desc_1_cnt
          ,le.populated_off_desc_2_cnt
          ,le.populated_add_off_cd_cnt
          ,le.populated_add_off_desc_cnt
          ,le.populated_off_typ_cnt
          ,le.populated_off_lev_cnt
          ,le.populated_arr_disp_date_cnt
          ,le.populated_arr_disp_cd_cnt
          ,le.populated_arr_disp_desc_1_cnt
          ,le.populated_arr_disp_desc_2_cnt
          ,le.populated_arr_disp_desc_3_cnt
          ,le.populated_court_cd_cnt
          ,le.populated_court_desc_cnt
          ,le.populated_ct_dist_cnt
          ,le.populated_ct_fnl_plea_cd_cnt
          ,le.populated_ct_fnl_plea_cnt
          ,le.populated_ct_off_code_cnt
          ,le.populated_ct_chg_cnt
          ,le.populated_ct_chg_typ_flg_cnt
          ,le.populated_ct_off_desc_1_cnt
          ,le.populated_ct_off_desc_2_cnt
          ,le.populated_ct_addl_desc_cd_cnt
          ,le.populated_ct_off_lev_cnt
          ,le.populated_ct_disp_dt_cnt
          ,le.populated_ct_disp_cd_cnt
          ,le.populated_ct_disp_desc_1_cnt
          ,le.populated_ct_disp_desc_2_cnt
          ,le.populated_cty_conv_cd_cnt
          ,le.populated_cty_conv_cnt
          ,le.populated_adj_wthd_cnt
          ,le.populated_stc_dt_cnt
          ,le.populated_stc_cd_cnt
          ,le.populated_stc_comp_cnt
          ,le.populated_stc_desc_1_cnt
          ,le.populated_stc_desc_2_cnt
          ,le.populated_stc_desc_3_cnt
          ,le.populated_stc_desc_4_cnt
          ,le.populated_stc_lgth_cnt
          ,le.populated_stc_lgth_desc_cnt
          ,le.populated_inc_adm_dt_cnt
          ,le.populated_min_term_cnt
          ,le.populated_min_term_desc_cnt
          ,le.populated_max_term_cnt
          ,le.populated_max_term_desc_cnt
          ,le.populated_parole_cnt
          ,le.populated_probation_cnt
          ,le.populated_offensetown_cnt
          ,le.populated_convict_dt_cnt
          ,le.populated_court_county_cnt
          ,le.populated_fcra_offense_key_cnt
          ,le.populated_fcra_conviction_flag_cnt
          ,le.populated_fcra_traffic_flag_cnt
          ,le.populated_fcra_date_cnt
          ,le.populated_fcra_date_type_cnt
          ,le.populated_conviction_override_date_cnt
          ,le.populated_conviction_override_date_type_cnt
          ,le.populated_offense_score_cnt
          ,le.populated_offense_persistent_id_cnt
          ,le.populated_offense_category_cnt
          ,le.populated_hyg_classification_code_cnt
          ,le.populated_old_ln_offense_score_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_offender_key_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_county_of_origin_pcnt
          ,le.populated_source_file_pcnt
          ,le.populated_data_type_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_offense_key_pcnt
          ,le.populated_off_date_pcnt
          ,le.populated_arr_date_pcnt
          ,le.populated_case_num_pcnt
          ,le.populated_total_num_of_offenses_pcnt
          ,le.populated_num_of_counts_pcnt
          ,le.populated_off_code_pcnt
          ,le.populated_chg_pcnt
          ,le.populated_chg_typ_flg_pcnt
          ,le.populated_off_of_record_pcnt
          ,le.populated_off_desc_1_pcnt
          ,le.populated_off_desc_2_pcnt
          ,le.populated_add_off_cd_pcnt
          ,le.populated_add_off_desc_pcnt
          ,le.populated_off_typ_pcnt
          ,le.populated_off_lev_pcnt
          ,le.populated_arr_disp_date_pcnt
          ,le.populated_arr_disp_cd_pcnt
          ,le.populated_arr_disp_desc_1_pcnt
          ,le.populated_arr_disp_desc_2_pcnt
          ,le.populated_arr_disp_desc_3_pcnt
          ,le.populated_court_cd_pcnt
          ,le.populated_court_desc_pcnt
          ,le.populated_ct_dist_pcnt
          ,le.populated_ct_fnl_plea_cd_pcnt
          ,le.populated_ct_fnl_plea_pcnt
          ,le.populated_ct_off_code_pcnt
          ,le.populated_ct_chg_pcnt
          ,le.populated_ct_chg_typ_flg_pcnt
          ,le.populated_ct_off_desc_1_pcnt
          ,le.populated_ct_off_desc_2_pcnt
          ,le.populated_ct_addl_desc_cd_pcnt
          ,le.populated_ct_off_lev_pcnt
          ,le.populated_ct_disp_dt_pcnt
          ,le.populated_ct_disp_cd_pcnt
          ,le.populated_ct_disp_desc_1_pcnt
          ,le.populated_ct_disp_desc_2_pcnt
          ,le.populated_cty_conv_cd_pcnt
          ,le.populated_cty_conv_pcnt
          ,le.populated_adj_wthd_pcnt
          ,le.populated_stc_dt_pcnt
          ,le.populated_stc_cd_pcnt
          ,le.populated_stc_comp_pcnt
          ,le.populated_stc_desc_1_pcnt
          ,le.populated_stc_desc_2_pcnt
          ,le.populated_stc_desc_3_pcnt
          ,le.populated_stc_desc_4_pcnt
          ,le.populated_stc_lgth_pcnt
          ,le.populated_stc_lgth_desc_pcnt
          ,le.populated_inc_adm_dt_pcnt
          ,le.populated_min_term_pcnt
          ,le.populated_min_term_desc_pcnt
          ,le.populated_max_term_pcnt
          ,le.populated_max_term_desc_pcnt
          ,le.populated_parole_pcnt
          ,le.populated_probation_pcnt
          ,le.populated_offensetown_pcnt
          ,le.populated_convict_dt_pcnt
          ,le.populated_court_county_pcnt
          ,le.populated_fcra_offense_key_pcnt
          ,le.populated_fcra_conviction_flag_pcnt
          ,le.populated_fcra_traffic_flag_pcnt
          ,le.populated_fcra_date_pcnt
          ,le.populated_fcra_date_type_pcnt
          ,le.populated_conviction_override_date_pcnt
          ,le.populated_conviction_override_date_type_pcnt
          ,le.populated_offense_score_pcnt
          ,le.populated_offense_persistent_id_pcnt
          ,le.populated_offense_category_pcnt
          ,le.populated_hyg_classification_code_pcnt
          ,le.populated_old_ln_offense_score_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,79,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Moxie_DOC_Offenses_Dev_Delta(prevDS, PROJECT(h, Moxie_DOC_Offenses_Dev_Layout_crim));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),79,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Moxie_DOC_Offenses_Dev_Layout_crim) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Crim, Moxie_DOC_Offenses_Dev_Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor');
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
