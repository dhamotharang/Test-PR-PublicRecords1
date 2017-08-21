IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_DOC_Offenses_Dev_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Moxie_DOC_Offenses_Dev_Layout_crim)
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
EXPORT FromNone(DATASET(Moxie_DOC_Offenses_Dev_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.offender_key_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offender_key((SALT33.StrType)le.offender_key);
    SELF.source_file_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_source_file((SALT33.StrType)le.source_file);
    SELF.orig_state_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_orig_state((SALT33.StrType)le.orig_state);
    SELF.offense_key_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offense_key((SALT33.StrType)le.offense_key);
    SELF.off_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_off_date((SALT33.StrType)le.off_date);
    SELF.arr_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_arr_date((SALT33.StrType)le.arr_date);
    SELF.total_num_of_offenses_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_total_num_of_offenses((SALT33.StrType)le.total_num_of_offenses);
    SELF.num_of_counts_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_num_of_counts((SALT33.StrType)le.num_of_counts);
    SELF.off_typ_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_off_typ((SALT33.StrType)le.off_typ);
    SELF.off_lev_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_off_lev((SALT33.StrType)le.off_lev,(SALT33.StrType)le.vendor);
    SELF.arr_disp_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_arr_disp_date((SALT33.StrType)le.arr_disp_date);
    SELF.ct_disp_dt_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_ct_disp_dt((SALT33.StrType)le.ct_disp_dt);
    SELF.cty_conv_cd_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_cty_conv_cd((SALT33.StrType)le.cty_conv_cd);
    SELF.stc_dt_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_stc_dt((SALT33.StrType)le.stc_dt);
    SELF.convict_dt_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_convict_dt((SALT33.StrType)le.convict_dt);
    SELF.fcra_conviction_flag_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_conviction_flag((SALT33.StrType)le.fcra_conviction_flag);
    SELF.fcra_traffic_flag_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_traffic_flag((SALT33.StrType)le.fcra_traffic_flag);
    SELF.fcra_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date);
    SELF.fcra_date_type_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type);
    SELF.conviction_override_date_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date);
    SELF.conviction_override_date_type_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type);
    SELF.offense_persistent_id_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offense_persistent_id((SALT33.StrType)le.offense_persistent_id);
    SELF.offense_category_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_offense_category((SALT33.StrType)le.offense_category);
    SELF.hyg_classification_code_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_hyg_classification_code((SALT33.StrType)le.hyg_classification_code);
    SELF.old_ln_offense_score_Invalid := Moxie_DOC_Offenses_Dev_Fields.InValid_old_ln_offense_score((SALT33.StrType)le.old_ln_offense_score);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Moxie_DOC_Offenses_Dev_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.offender_key_Invalid << 1 ) + ( le.source_file_Invalid << 2 ) + ( le.orig_state_Invalid << 3 ) + ( le.offense_key_Invalid << 4 ) + ( le.off_date_Invalid << 5 ) + ( le.arr_date_Invalid << 6 ) + ( le.total_num_of_offenses_Invalid << 7 ) + ( le.num_of_counts_Invalid << 8 ) + ( le.off_typ_Invalid << 9 ) + ( le.off_lev_Invalid << 10 ) + ( le.arr_disp_date_Invalid << 11 ) + ( le.ct_disp_dt_Invalid << 12 ) + ( le.cty_conv_cd_Invalid << 13 ) + ( le.stc_dt_Invalid << 14 ) + ( le.convict_dt_Invalid << 15 ) + ( le.fcra_conviction_flag_Invalid << 16 ) + ( le.fcra_traffic_flag_Invalid << 17 ) + ( le.fcra_date_Invalid << 18 ) + ( le.fcra_date_type_Invalid << 19 ) + ( le.conviction_override_date_Invalid << 20 ) + ( le.conviction_override_date_type_Invalid << 21 ) + ( le.offense_persistent_id_Invalid << 22 ) + ( le.offense_category_Invalid << 23 ) + ( le.hyg_classification_code_Invalid << 24 ) + ( le.old_ln_offense_score_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    offender_key_LENGTH_ErrorCount := COUNT(GROUP,h.offender_key_Invalid=1);
    source_file_LENGTH_ErrorCount := COUNT(GROUP,h.source_file_Invalid=1);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    offense_key_LENGTH_ErrorCount := COUNT(GROUP,h.offense_key_Invalid=1);
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
  END;
  EXPORT SummaryStats := TABLE(h,r,vendor,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.offender_key_Invalid,le.source_file_Invalid,le.orig_state_Invalid,le.offense_key_Invalid,le.off_date_Invalid,le.arr_date_Invalid,le.total_num_of_offenses_Invalid,le.num_of_counts_Invalid,le.off_typ_Invalid,le.off_lev_Invalid,le.arr_disp_date_Invalid,le.ct_disp_dt_Invalid,le.cty_conv_cd_Invalid,le.stc_dt_Invalid,le.convict_dt_Invalid,le.fcra_conviction_flag_Invalid,le.fcra_traffic_flag_Invalid,le.fcra_date_Invalid,le.fcra_date_type_Invalid,le.conviction_override_date_Invalid,le.conviction_override_date_type_Invalid,le.offense_persistent_id_Invalid,le.offense_category_Invalid,le.hyg_classification_code_Invalid,le.old_ln_offense_score_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_process_date(le.process_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offender_key(le.offender_key_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_source_file(le.source_file_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_key(le.offense_key_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_date(le.off_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_arr_date(le.arr_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_total_num_of_offenses(le.total_num_of_offenses_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_num_of_counts(le.num_of_counts_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_typ(le.off_typ_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_off_lev(le.off_lev_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_arr_disp_date(le.arr_disp_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_ct_disp_dt(le.ct_disp_dt_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_cty_conv_cd(le.cty_conv_cd_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_stc_dt(le.stc_dt_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_convict_dt(le.convict_dt_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_conviction_flag(le.fcra_conviction_flag_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_traffic_flag(le.fcra_traffic_flag_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_date(le.fcra_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_fcra_date_type(le.fcra_date_type_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_conviction_override_date(le.conviction_override_date_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_conviction_override_date_type(le.conviction_override_date_type_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_persistent_id(le.offense_persistent_id_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_offense_category(le.offense_category_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_hyg_classification_code(le.hyg_classification_code_Invalid),Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_old_ln_offense_score(le.old_ln_offense_score_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.source_file_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_key_Invalid,'LENGTH','UNKNOWN')
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
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.offender_key,(SALT33.StrType)le.source_file,(SALT33.StrType)le.orig_state,(SALT33.StrType)le.offense_key,(SALT33.StrType)le.off_date,(SALT33.StrType)le.arr_date,(SALT33.StrType)le.total_num_of_offenses,(SALT33.StrType)le.num_of_counts,(SALT33.StrType)le.off_typ,(SALT33.StrType)le.off_lev,(SALT33.StrType)le.arr_disp_date,(SALT33.StrType)le.ct_disp_dt,(SALT33.StrType)le.cty_conv_cd,(SALT33.StrType)le.stc_dt,(SALT33.StrType)le.convict_dt,(SALT33.StrType)le.fcra_conviction_flag,(SALT33.StrType)le.fcra_traffic_flag,(SALT33.StrType)le.fcra_date,(SALT33.StrType)le.fcra_date_type,(SALT33.StrType)le.conviction_override_date,(SALT33.StrType)le.conviction_override_date_type,(SALT33.StrType)le.offense_persistent_id,(SALT33.StrType)le.offense_category,(SALT33.StrType)le.hyg_classification_code,(SALT33.StrType)le.old_ln_offense_score,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,26,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:Invalid_Current_Date:CUSTOM'
          ,'offender_key:Non_Blank:LENGTH'
          ,'source_file:Non_Blank:LENGTH'
          ,'orig_state:Invalid_Char:ALLOW'
          ,'offense_key:Non_Blank:LENGTH'
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
          ,'old_ln_offense_score:Invalid_OffenseScore:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
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
          ,Moxie_DOC_Offenses_Dev_Fields.InvalidMessage_old_ln_offense_score(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.source_file_LENGTH_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.offense_key_LENGTH_ErrorCount
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
          ,le.old_ln_offense_score_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.source_file_LENGTH_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.offense_key_LENGTH_ErrorCount
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
          ,le.old_ln_offense_score_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,26,Into(LEFT,COUNTER));
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
