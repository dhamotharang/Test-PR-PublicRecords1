IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_DOC_Punishment_Dev_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Moxie_DOC_Punishment_Dev_Layout_crim)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 offender_key_Invalid;
    UNSIGNED1 event_dt_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 punishment_type_Invalid;
    UNSIGNED1 sent_date_Invalid;
    UNSIGNED1 sent_length_Invalid;
    UNSIGNED1 latest_adm_dt_Invalid;
    UNSIGNED1 sch_rel_dt_Invalid;
    UNSIGNED1 act_rel_dt_Invalid;
    UNSIGNED1 ctl_rel_dt_Invalid;
    UNSIGNED1 presump_par_rel_dt_Invalid;
    UNSIGNED1 mutl_part_pgm_dt_Invalid;
    UNSIGNED1 par_status_dt_Invalid;
    UNSIGNED1 par_st_dt_Invalid;
    UNSIGNED1 par_sch_end_dt_Invalid;
    UNSIGNED1 par_act_end_dt_Invalid;
    UNSIGNED1 par_cty_cd_Invalid;
    UNSIGNED1 tdcjid_admit_date_Invalid;
    UNSIGNED1 recv_dept_date_Invalid;
    UNSIGNED1 casepull_date_Invalid;
    UNSIGNED1 pro_st_dt_Invalid;
    UNSIGNED1 pro_end_dt_Invalid;
    UNSIGNED1 conviction_override_date_Invalid;
    UNSIGNED1 conviction_override_date_type_Invalid;
    UNSIGNED1 punishment_persistent_id_Invalid;
    UNSIGNED1 fcra_date_Invalid;
    UNSIGNED1 fcra_date_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Moxie_DOC_Punishment_Dev_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Moxie_DOC_Punishment_Dev_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.offender_key_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_offender_key((SALT33.StrType)le.offender_key);
    SELF.event_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_event_dt((SALT33.StrType)le.event_dt);
    SELF.vendor_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_vendor((SALT33.StrType)le.vendor);
    SELF.orig_state_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_orig_state((SALT33.StrType)le.orig_state);
    SELF.punishment_type_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_punishment_type((SALT33.StrType)le.punishment_type);
    SELF.sent_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_sent_date((SALT33.StrType)le.sent_date);
    SELF.sent_length_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_sent_length((SALT33.StrType)le.sent_length);
    SELF.latest_adm_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_latest_adm_dt((SALT33.StrType)le.latest_adm_dt);
    SELF.sch_rel_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_sch_rel_dt((SALT33.StrType)le.sch_rel_dt);
    SELF.act_rel_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_act_rel_dt((SALT33.StrType)le.act_rel_dt);
    SELF.ctl_rel_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_ctl_rel_dt((SALT33.StrType)le.ctl_rel_dt);
    SELF.presump_par_rel_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_presump_par_rel_dt((SALT33.StrType)le.presump_par_rel_dt);
    SELF.mutl_part_pgm_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_mutl_part_pgm_dt((SALT33.StrType)le.mutl_part_pgm_dt);
    SELF.par_status_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_par_status_dt((SALT33.StrType)le.par_status_dt);
    SELF.par_st_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_par_st_dt((SALT33.StrType)le.par_st_dt);
    SELF.par_sch_end_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_par_sch_end_dt((SALT33.StrType)le.par_sch_end_dt);
    SELF.par_act_end_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_par_act_end_dt((SALT33.StrType)le.par_act_end_dt);
    SELF.par_cty_cd_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_par_cty_cd((SALT33.StrType)le.par_cty_cd);
    SELF.tdcjid_admit_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_tdcjid_admit_date((SALT33.StrType)le.tdcjid_admit_date);
    SELF.recv_dept_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_recv_dept_date((SALT33.StrType)le.recv_dept_date);
    SELF.casepull_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_casepull_date((SALT33.StrType)le.casepull_date);
    SELF.pro_st_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_pro_st_dt((SALT33.StrType)le.pro_st_dt);
    SELF.pro_end_dt_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_pro_end_dt((SALT33.StrType)le.pro_end_dt);
    SELF.conviction_override_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date);
    SELF.conviction_override_date_type_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type);
    SELF.punishment_persistent_id_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_punishment_persistent_id((SALT33.StrType)le.punishment_persistent_id);
    SELF.fcra_date_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date);
    SELF.fcra_date_type_Invalid := Moxie_DOC_Punishment_Dev_Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Moxie_DOC_Punishment_Dev_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.offender_key_Invalid << 1 ) + ( le.event_dt_Invalid << 2 ) + ( le.vendor_Invalid << 3 ) + ( le.orig_state_Invalid << 4 ) + ( le.punishment_type_Invalid << 5 ) + ( le.sent_date_Invalid << 6 ) + ( le.sent_length_Invalid << 7 ) + ( le.latest_adm_dt_Invalid << 8 ) + ( le.sch_rel_dt_Invalid << 9 ) + ( le.act_rel_dt_Invalid << 10 ) + ( le.ctl_rel_dt_Invalid << 11 ) + ( le.presump_par_rel_dt_Invalid << 12 ) + ( le.mutl_part_pgm_dt_Invalid << 13 ) + ( le.par_status_dt_Invalid << 14 ) + ( le.par_st_dt_Invalid << 15 ) + ( le.par_sch_end_dt_Invalid << 16 ) + ( le.par_act_end_dt_Invalid << 17 ) + ( le.par_cty_cd_Invalid << 18 ) + ( le.tdcjid_admit_date_Invalid << 19 ) + ( le.recv_dept_date_Invalid << 20 ) + ( le.casepull_date_Invalid << 21 ) + ( le.pro_st_dt_Invalid << 22 ) + ( le.pro_end_dt_Invalid << 23 ) + ( le.conviction_override_date_Invalid << 24 ) + ( le.conviction_override_date_type_Invalid << 25 ) + ( le.punishment_persistent_id_Invalid << 26 ) + ( le.fcra_date_Invalid << 27 ) + ( le.fcra_date_type_Invalid << 28 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Moxie_DOC_Punishment_Dev_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.offender_key_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.event_dt_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.punishment_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.sent_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.sent_length_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.latest_adm_dt_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sch_rel_dt_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.act_rel_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ctl_rel_dt_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.presump_par_rel_dt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.mutl_part_pgm_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.par_status_dt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.par_st_dt_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.par_sch_end_dt_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.par_act_end_dt_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.par_cty_cd_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.tdcjid_admit_date_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.recv_dept_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.casepull_date_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.pro_st_dt_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.pro_end_dt_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.conviction_override_date_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.conviction_override_date_type_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.punishment_persistent_id_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.fcra_date_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.fcra_date_type_Invalid := (le.ScrubsBits1 >> 28) & 1;
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
    event_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.event_dt_Invalid=1);
    vendor_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    punishment_type_ENUM_ErrorCount := COUNT(GROUP,h.punishment_type_Invalid=1);
    sent_date_CUSTOM_ErrorCount := COUNT(GROUP,h.sent_date_Invalid=1);
    sent_length_ALLOW_ErrorCount := COUNT(GROUP,h.sent_length_Invalid=1);
    latest_adm_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.latest_adm_dt_Invalid=1);
    sch_rel_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.sch_rel_dt_Invalid=1);
    act_rel_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.act_rel_dt_Invalid=1);
    ctl_rel_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ctl_rel_dt_Invalid=1);
    presump_par_rel_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.presump_par_rel_dt_Invalid=1);
    mutl_part_pgm_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.mutl_part_pgm_dt_Invalid=1);
    par_status_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.par_status_dt_Invalid=1);
    par_st_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.par_st_dt_Invalid=1);
    par_sch_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.par_sch_end_dt_Invalid=1);
    par_act_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.par_act_end_dt_Invalid=1);
    par_cty_cd_ALLOW_ErrorCount := COUNT(GROUP,h.par_cty_cd_Invalid=1);
    tdcjid_admit_date_CUSTOM_ErrorCount := COUNT(GROUP,h.tdcjid_admit_date_Invalid=1);
    recv_dept_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recv_dept_date_Invalid=1);
    casepull_date_CUSTOM_ErrorCount := COUNT(GROUP,h.casepull_date_Invalid=1);
    pro_st_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.pro_st_dt_Invalid=1);
    pro_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.pro_end_dt_Invalid=1);
    conviction_override_date_CUSTOM_ErrorCount := COUNT(GROUP,h.conviction_override_date_Invalid=1);
    conviction_override_date_type_ENUM_ErrorCount := COUNT(GROUP,h.conviction_override_date_type_Invalid=1);
    punishment_persistent_id_ALLOW_ErrorCount := COUNT(GROUP,h.punishment_persistent_id_Invalid=1);
    fcra_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fcra_date_Invalid=1);
    fcra_date_type_ENUM_ErrorCount := COUNT(GROUP,h.fcra_date_type_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.offender_key_Invalid,le.event_dt_Invalid,le.vendor_Invalid,le.orig_state_Invalid,le.punishment_type_Invalid,le.sent_date_Invalid,le.sent_length_Invalid,le.latest_adm_dt_Invalid,le.sch_rel_dt_Invalid,le.act_rel_dt_Invalid,le.ctl_rel_dt_Invalid,le.presump_par_rel_dt_Invalid,le.mutl_part_pgm_dt_Invalid,le.par_status_dt_Invalid,le.par_st_dt_Invalid,le.par_sch_end_dt_Invalid,le.par_act_end_dt_Invalid,le.par_cty_cd_Invalid,le.tdcjid_admit_date_Invalid,le.recv_dept_date_Invalid,le.casepull_date_Invalid,le.pro_st_dt_Invalid,le.pro_end_dt_Invalid,le.conviction_override_date_Invalid,le.conviction_override_date_type_Invalid,le.punishment_persistent_id_Invalid,le.fcra_date_Invalid,le.fcra_date_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_process_date(le.process_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_offender_key(le.offender_key_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_event_dt(le.event_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_vendor(le.vendor_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_punishment_type(le.punishment_type_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_sent_date(le.sent_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_sent_length(le.sent_length_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_latest_adm_dt(le.latest_adm_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_sch_rel_dt(le.sch_rel_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_act_rel_dt(le.act_rel_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_ctl_rel_dt(le.ctl_rel_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_presump_par_rel_dt(le.presump_par_rel_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_mutl_part_pgm_dt(le.mutl_part_pgm_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_status_dt(le.par_status_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_st_dt(le.par_st_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_sch_end_dt(le.par_sch_end_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_act_end_dt(le.par_act_end_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_cty_cd(le.par_cty_cd_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_tdcjid_admit_date(le.tdcjid_admit_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_recv_dept_date(le.recv_dept_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_casepull_date(le.casepull_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_pro_st_dt(le.pro_st_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_pro_end_dt(le.pro_end_dt_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_conviction_override_date(le.conviction_override_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_conviction_override_date_type(le.conviction_override_date_type_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_punishment_persistent_id(le.punishment_persistent_id_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_fcra_date(le.fcra_date_Invalid),Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_fcra_date_type(le.fcra_date_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.event_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.punishment_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sent_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sent_length_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.latest_adm_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sch_rel_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.act_rel_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ctl_rel_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.presump_par_rel_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mutl_part_pgm_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.par_status_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.par_st_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.par_sch_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.par_act_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.par_cty_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tdcjid_admit_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.recv_dept_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.casepull_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pro_st_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pro_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.conviction_override_date_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.punishment_persistent_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fcra_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcra_date_type_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','offender_key','event_dt','vendor','orig_state','punishment_type','sent_date','sent_length','latest_adm_dt','sch_rel_dt','act_rel_dt','ctl_rel_dt','presump_par_rel_dt','mutl_part_pgm_dt','par_status_dt','par_st_dt','par_sch_end_dt','par_act_end_dt','par_cty_cd','tdcjid_admit_date','recv_dept_date','casepull_date','pro_st_dt','pro_end_dt','conviction_override_date','conviction_override_date_type','punishment_persistent_id','fcra_date','fcra_date_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Current_Date','Non_Blank','Invalid_Future_Date','Non_Blank','Invalid_Char','Invalid_Punishment_Type','Invalid_Current_Date','Invalid_Num','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Invalid_Current_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_ConOverDateFlag','Invalid_Num','Invalid_Current_Date','Invalid_FCRADateFlag','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.offender_key,(SALT33.StrType)le.event_dt,(SALT33.StrType)le.vendor,(SALT33.StrType)le.orig_state,(SALT33.StrType)le.punishment_type,(SALT33.StrType)le.sent_date,(SALT33.StrType)le.sent_length,(SALT33.StrType)le.latest_adm_dt,(SALT33.StrType)le.sch_rel_dt,(SALT33.StrType)le.act_rel_dt,(SALT33.StrType)le.ctl_rel_dt,(SALT33.StrType)le.presump_par_rel_dt,(SALT33.StrType)le.mutl_part_pgm_dt,(SALT33.StrType)le.par_status_dt,(SALT33.StrType)le.par_st_dt,(SALT33.StrType)le.par_sch_end_dt,(SALT33.StrType)le.par_act_end_dt,(SALT33.StrType)le.par_cty_cd,(SALT33.StrType)le.tdcjid_admit_date,(SALT33.StrType)le.recv_dept_date,(SALT33.StrType)le.casepull_date,(SALT33.StrType)le.pro_st_dt,(SALT33.StrType)le.pro_end_dt,(SALT33.StrType)le.conviction_override_date,(SALT33.StrType)le.conviction_override_date_type,(SALT33.StrType)le.punishment_persistent_id,(SALT33.StrType)le.fcra_date,(SALT33.StrType)le.fcra_date_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,29,Into(LEFT,COUNTER));
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
          ,'event_dt:Invalid_Future_Date:CUSTOM'
          ,'vendor:Non_Blank:LENGTH'
          ,'orig_state:Invalid_Char:ALLOW'
          ,'punishment_type:Invalid_Punishment_Type:ENUM'
          ,'sent_date:Invalid_Current_Date:CUSTOM'
          ,'sent_length:Invalid_Num:ALLOW'
          ,'latest_adm_dt:Invalid_Future_Date:CUSTOM'
          ,'sch_rel_dt:Invalid_Future_Date:CUSTOM'
          ,'act_rel_dt:Invalid_Future_Date:CUSTOM'
          ,'ctl_rel_dt:Invalid_Future_Date:CUSTOM'
          ,'presump_par_rel_dt:Invalid_Future_Date:CUSTOM'
          ,'mutl_part_pgm_dt:Invalid_Current_Date:CUSTOM'
          ,'par_status_dt:Invalid_Current_Date:CUSTOM'
          ,'par_st_dt:Invalid_Future_Date:CUSTOM'
          ,'par_sch_end_dt:Invalid_Future_Date:CUSTOM'
          ,'par_act_end_dt:Invalid_Future_Date:CUSTOM'
          ,'par_cty_cd:Invalid_Num:ALLOW'
          ,'tdcjid_admit_date:Invalid_Current_Date:CUSTOM'
          ,'recv_dept_date:Invalid_Current_Date:CUSTOM'
          ,'casepull_date:Invalid_Current_Date:CUSTOM'
          ,'pro_st_dt:Invalid_Future_Date:CUSTOM'
          ,'pro_end_dt:Invalid_Future_Date:CUSTOM'
          ,'conviction_override_date:Invalid_Future_Date:CUSTOM'
          ,'conviction_override_date_type:Invalid_ConOverDateFlag:ENUM'
          ,'punishment_persistent_id:Invalid_Num:ALLOW'
          ,'fcra_date:Invalid_Current_Date:CUSTOM'
          ,'fcra_date_type:Invalid_FCRADateFlag:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_process_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_offender_key(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_event_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_vendor(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_orig_state(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_punishment_type(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_sent_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_sent_length(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_latest_adm_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_sch_rel_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_act_rel_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_ctl_rel_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_presump_par_rel_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_mutl_part_pgm_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_status_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_st_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_sch_end_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_act_end_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_par_cty_cd(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_tdcjid_admit_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_recv_dept_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_casepull_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_pro_st_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_pro_end_dt(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_conviction_override_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_conviction_override_date_type(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_punishment_persistent_id(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_fcra_date(1)
          ,Moxie_DOC_Punishment_Dev_Fields.InvalidMessage_fcra_date_type(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.event_dt_CUSTOM_ErrorCount
          ,le.vendor_LENGTH_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.punishment_type_ENUM_ErrorCount
          ,le.sent_date_CUSTOM_ErrorCount
          ,le.sent_length_ALLOW_ErrorCount
          ,le.latest_adm_dt_CUSTOM_ErrorCount
          ,le.sch_rel_dt_CUSTOM_ErrorCount
          ,le.act_rel_dt_CUSTOM_ErrorCount
          ,le.ctl_rel_dt_CUSTOM_ErrorCount
          ,le.presump_par_rel_dt_CUSTOM_ErrorCount
          ,le.mutl_part_pgm_dt_CUSTOM_ErrorCount
          ,le.par_status_dt_CUSTOM_ErrorCount
          ,le.par_st_dt_CUSTOM_ErrorCount
          ,le.par_sch_end_dt_CUSTOM_ErrorCount
          ,le.par_act_end_dt_CUSTOM_ErrorCount
          ,le.par_cty_cd_ALLOW_ErrorCount
          ,le.tdcjid_admit_date_CUSTOM_ErrorCount
          ,le.recv_dept_date_CUSTOM_ErrorCount
          ,le.casepull_date_CUSTOM_ErrorCount
          ,le.pro_st_dt_CUSTOM_ErrorCount
          ,le.pro_end_dt_CUSTOM_ErrorCount
          ,le.conviction_override_date_CUSTOM_ErrorCount
          ,le.conviction_override_date_type_ENUM_ErrorCount
          ,le.punishment_persistent_id_ALLOW_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.fcra_date_type_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.event_dt_CUSTOM_ErrorCount
          ,le.vendor_LENGTH_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount
          ,le.punishment_type_ENUM_ErrorCount
          ,le.sent_date_CUSTOM_ErrorCount
          ,le.sent_length_ALLOW_ErrorCount
          ,le.latest_adm_dt_CUSTOM_ErrorCount
          ,le.sch_rel_dt_CUSTOM_ErrorCount
          ,le.act_rel_dt_CUSTOM_ErrorCount
          ,le.ctl_rel_dt_CUSTOM_ErrorCount
          ,le.presump_par_rel_dt_CUSTOM_ErrorCount
          ,le.mutl_part_pgm_dt_CUSTOM_ErrorCount
          ,le.par_status_dt_CUSTOM_ErrorCount
          ,le.par_st_dt_CUSTOM_ErrorCount
          ,le.par_sch_end_dt_CUSTOM_ErrorCount
          ,le.par_act_end_dt_CUSTOM_ErrorCount
          ,le.par_cty_cd_ALLOW_ErrorCount
          ,le.tdcjid_admit_date_CUSTOM_ErrorCount
          ,le.recv_dept_date_CUSTOM_ErrorCount
          ,le.casepull_date_CUSTOM_ErrorCount
          ,le.pro_st_dt_CUSTOM_ErrorCount
          ,le.pro_end_dt_CUSTOM_ErrorCount
          ,le.conviction_override_date_CUSTOM_ErrorCount
          ,le.conviction_override_date_type_ENUM_ErrorCount
          ,le.punishment_persistent_id_ALLOW_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.fcra_date_type_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,29,Into(LEFT,COUNTER));
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
