IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_Court_Offenses_Dev_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Moxie_Court_Offenses_Dev_Layout_crim)
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
EXPORT FromNone(DATASET(Moxie_Court_Offenses_Dev_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.offender_key_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offender_key((SALT33.StrType)le.offender_key);
    SELF.vendor_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_vendor((SALT33.StrType)le.vendor);
    SELF.state_origin_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_state_origin((SALT33.StrType)le.state_origin);
    SELF.source_file_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_source_file((SALT33.StrType)le.source_file);
    SELF.off_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_off_date((SALT33.StrType)le.off_date);
    SELF.arr_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_arr_date((SALT33.StrType)le.arr_date);
    SELF.arr_off_lev_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_arr_off_lev((SALT33.StrType)le.arr_off_lev,(SALT33.StrType)le.vendor);
    SELF.arr_disp_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_arr_disp_date((SALT33.StrType)le.arr_disp_date);
    SELF.court_off_lev_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_court_off_lev((SALT33.StrType)le.court_off_lev,(SALT33.StrType)le.vendor);
    SELF.court_disp_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_court_disp_date((SALT33.StrType)le.court_disp_date);
    SELF.sent_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_sent_date((SALT33.StrType)le.sent_date);
    SELF.convict_dt_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_convict_dt((SALT33.StrType)le.convict_dt);
    SELF.court_dt_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_court_dt((SALT33.StrType)le.court_dt);
    SELF.fcra_conviction_flag_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_conviction_flag((SALT33.StrType)le.fcra_conviction_flag);
    SELF.fcra_traffic_flag_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_traffic_flag((SALT33.StrType)le.fcra_traffic_flag);
    SELF.fcra_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date);
    SELF.fcra_date_type_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type);
    SELF.conviction_override_date_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date);
    SELF.conviction_override_date_type_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type);
    SELF.offense_score_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offense_score((SALT33.StrType)le.offense_score);
    SELF.offense_persistent_id_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offense_persistent_id((SALT33.StrType)le.offense_persistent_id);
    SELF.offense_category_Invalid := Moxie_Court_Offenses_Dev_Fields.InValid_offense_category((SALT33.StrType)le.offense_category);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Moxie_Court_Offenses_Dev_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.offender_key_Invalid << 1 ) + ( le.vendor_Invalid << 2 ) + ( le.state_origin_Invalid << 3 ) + ( le.source_file_Invalid << 4 ) + ( le.off_date_Invalid << 5 ) + ( le.arr_date_Invalid << 6 ) + ( le.arr_off_lev_Invalid << 7 ) + ( le.arr_disp_date_Invalid << 8 ) + ( le.court_off_lev_Invalid << 9 ) + ( le.court_disp_date_Invalid << 10 ) + ( le.sent_date_Invalid << 11 ) + ( le.convict_dt_Invalid << 12 ) + ( le.court_dt_Invalid << 13 ) + ( le.fcra_conviction_flag_Invalid << 14 ) + ( le.fcra_traffic_flag_Invalid << 15 ) + ( le.fcra_date_Invalid << 16 ) + ( le.fcra_date_type_Invalid << 17 ) + ( le.conviction_override_date_Invalid << 18 ) + ( le.conviction_override_date_type_Invalid << 19 ) + ( le.offense_score_Invalid << 20 ) + ( le.offense_persistent_id_Invalid << 21 ) + ( le.offense_category_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    offender_key_LENGTH_ErrorCount := COUNT(GROUP,h.offender_key_Invalid=1);
    vendor_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    source_file_LENGTH_ErrorCount := COUNT(GROUP,h.source_file_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.offender_key_Invalid,le.vendor_Invalid,le.state_origin_Invalid,le.source_file_Invalid,le.off_date_Invalid,le.arr_date_Invalid,le.arr_off_lev_Invalid,le.arr_disp_date_Invalid,le.court_off_lev_Invalid,le.court_disp_date_Invalid,le.sent_date_Invalid,le.convict_dt_Invalid,le.court_dt_Invalid,le.fcra_conviction_flag_Invalid,le.fcra_traffic_flag_Invalid,le.fcra_date_Invalid,le.fcra_date_type_Invalid,le.conviction_override_date_Invalid,le.conviction_override_date_type_Invalid,le.offense_score_Invalid,le.offense_persistent_id_Invalid,le.offense_category_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_process_date(le.process_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offender_key(le.offender_key_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_vendor(le.vendor_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_source_file(le.source_file_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_off_date(le.off_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_date(le.arr_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_off_lev(le.arr_off_lev_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_arr_disp_date(le.arr_disp_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_off_lev(le.court_off_lev_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_disp_date(le.court_disp_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_sent_date(le.sent_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_convict_dt(le.convict_dt_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_court_dt(le.court_dt_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_conviction_flag(le.fcra_conviction_flag_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_traffic_flag(le.fcra_traffic_flag_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_date(le.fcra_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_fcra_date_type(le.fcra_date_type_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_conviction_override_date(le.conviction_override_date_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_conviction_override_date_type(le.conviction_override_date_type_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_score(le.offense_score_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_persistent_id(le.offense_persistent_id_Invalid),Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_category(le.offense_category_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_file_Invalid,'LENGTH','UNKNOWN')
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
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.offender_key,(SALT33.StrType)le.vendor,(SALT33.StrType)le.state_origin,(SALT33.StrType)le.source_file,(SALT33.StrType)le.off_date,(SALT33.StrType)le.arr_date,(SALT33.StrType)le.arr_off_lev,(SALT33.StrType)le.arr_disp_date,(SALT33.StrType)le.court_off_lev,(SALT33.StrType)le.court_disp_date,(SALT33.StrType)le.sent_date,(SALT33.StrType)le.convict_dt,(SALT33.StrType)le.court_dt,(SALT33.StrType)le.fcra_conviction_flag,(SALT33.StrType)le.fcra_traffic_flag,(SALT33.StrType)le.fcra_date,(SALT33.StrType)le.fcra_date_type,(SALT33.StrType)le.conviction_override_date,(SALT33.StrType)le.conviction_override_date_type,(SALT33.StrType)le.offense_score,(SALT33.StrType)le.offense_persistent_id,(SALT33.StrType)le.offense_category,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
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
          ,'vendor:Non_Blank:LENGTH'
          ,'state_origin:Invalid_Char:ALLOW'
          ,'source_file:Non_Blank:LENGTH'
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
          ,'offense_category:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
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
          ,Moxie_Court_Offenses_Dev_Fields.InvalidMessage_offense_category(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.vendor_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.source_file_LENGTH_ErrorCount
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
          ,le.offense_category_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.vendor_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.source_file_LENGTH_ErrorCount
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
          ,le.offense_category_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,23,Into(LEFT,COUNTER));
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
