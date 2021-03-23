IMPORT SALT37;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_eCrash_MBSAgency)
    UNSIGNED1 agency_id_Invalid;
    UNSIGNED1 source_id_Invalid;
    UNSIGNED1 agency_state_abbr_Invalid;
    UNSIGNED1 agency_ori_Invalid;
    UNSIGNED1 allow_open_search_Invalid;
    UNSIGNED1 append_overwrite_flag_Invalid;
    UNSIGNED1 drivers_exchange_flag_Invalid;
    UNSIGNED1 source_start_date_Invalid;
    UNSIGNED1 source_end_date_Invalid;
    UNSIGNED1 source_termination_date_Invalid;
    UNSIGNED1 source_resale_allowed_Invalid;
    UNSIGNED1 source_auto_renew_Invalid;
    UNSIGNED1 source_allow_sale_of_component_data_Invalid;
    UNSIGNED1 source_allow_extract_of_vehicle_data_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_eCrash_MBSAgency)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_eCrash_MBSAgency) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.agency_id_Invalid := Fields.InValid_agency_id((SALT37.StrType)le.agency_id);
    SELF.source_id_Invalid := Fields.InValid_source_id((SALT37.StrType)le.source_id);
    SELF.agency_state_abbr_Invalid := Fields.InValid_agency_state_abbr((SALT37.StrType)le.agency_state_abbr);
    SELF.agency_ori_Invalid := Fields.InValid_agency_ori((SALT37.StrType)le.agency_ori);
    SELF.allow_open_search_Invalid := Fields.InValid_allow_open_search((SALT37.StrType)le.allow_open_search);
    SELF.append_overwrite_flag_Invalid := Fields.InValid_append_overwrite_flag((SALT37.StrType)le.append_overwrite_flag);
    SELF.drivers_exchange_flag_Invalid := Fields.InValid_drivers_exchange_flag((SALT37.StrType)le.drivers_exchange_flag);
    SELF.source_start_date_Invalid := Fields.InValid_source_start_date((SALT37.StrType)le.source_start_date);
    SELF.source_end_date_Invalid := Fields.InValid_source_end_date((SALT37.StrType)le.source_end_date);
    SELF.source_termination_date_Invalid := Fields.InValid_source_termination_date((SALT37.StrType)le.source_termination_date);
    SELF.source_resale_allowed_Invalid := Fields.InValid_source_resale_allowed((SALT37.StrType)le.source_resale_allowed);
    SELF.source_auto_renew_Invalid := Fields.InValid_source_auto_renew((SALT37.StrType)le.source_auto_renew);
    SELF.source_allow_sale_of_component_data_Invalid := Fields.InValid_source_allow_sale_of_component_data((SALT37.StrType)le.source_allow_sale_of_component_data);
    SELF.source_allow_extract_of_vehicle_data_Invalid := Fields.InValid_source_allow_extract_of_vehicle_data((SALT37.StrType)le.source_allow_extract_of_vehicle_data);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_eCrash_MBSAgency);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.agency_id_Invalid << 0 ) + ( le.source_id_Invalid << 2 ) + ( le.agency_state_abbr_Invalid << 4 ) + ( le.agency_ori_Invalid << 5 ) + ( le.allow_open_search_Invalid << 6 ) + ( le.append_overwrite_flag_Invalid << 8 ) + ( le.drivers_exchange_flag_Invalid << 10 ) + ( le.source_start_date_Invalid << 12 ) + ( le.source_end_date_Invalid << 14 ) + ( le.source_termination_date_Invalid << 16 ) + ( le.source_resale_allowed_Invalid << 18 ) + ( le.source_auto_renew_Invalid << 20 ) + ( le.source_allow_sale_of_component_data_Invalid << 22 ) + ( le.source_allow_extract_of_vehicle_data_Invalid << 24 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_eCrash_MBSAgency);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.agency_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.source_id_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.agency_state_abbr_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.agency_ori_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.allow_open_search_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.append_overwrite_flag_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.drivers_exchange_flag_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.source_start_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.source_end_date_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.source_termination_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.source_resale_allowed_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.source_auto_renew_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.source_allow_sale_of_component_data_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.source_allow_extract_of_vehicle_data_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    agency_id_ALLOW_ErrorCount := COUNT(GROUP,h.agency_id_Invalid=1);
    agency_id_LENGTH_ErrorCount := COUNT(GROUP,h.agency_id_Invalid=2);
    agency_id_Total_ErrorCount := COUNT(GROUP,h.agency_id_Invalid>0);
    source_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_id_Invalid=1);
    source_id_LENGTH_ErrorCount := COUNT(GROUP,h.source_id_Invalid=2);
    source_id_Total_ErrorCount := COUNT(GROUP,h.source_id_Invalid>0);
    agency_state_abbr_CUSTOM_ErrorCount := COUNT(GROUP,h.agency_state_abbr_Invalid=1);
    agency_ori_ALLOW_ErrorCount := COUNT(GROUP,h.agency_ori_Invalid=1);
    allow_open_search_ALLOW_ErrorCount := COUNT(GROUP,h.allow_open_search_Invalid=1);
    allow_open_search_LENGTH_ErrorCount := COUNT(GROUP,h.allow_open_search_Invalid=2);
    allow_open_search_Total_ErrorCount := COUNT(GROUP,h.allow_open_search_Invalid>0);
    append_overwrite_flag_ENUM_ErrorCount := COUNT(GROUP,h.append_overwrite_flag_Invalid=1);
    append_overwrite_flag_LENGTH_ErrorCount := COUNT(GROUP,h.append_overwrite_flag_Invalid=2);
    append_overwrite_flag_Total_ErrorCount := COUNT(GROUP,h.append_overwrite_flag_Invalid>0);
    drivers_exchange_flag_ALLOW_ErrorCount := COUNT(GROUP,h.drivers_exchange_flag_Invalid=1);
    drivers_exchange_flag_LENGTH_ErrorCount := COUNT(GROUP,h.drivers_exchange_flag_Invalid=2);
    drivers_exchange_flag_Total_ErrorCount := COUNT(GROUP,h.drivers_exchange_flag_Invalid>0);
    source_start_date_ALLOW_ErrorCount := COUNT(GROUP,h.source_start_date_Invalid=1);
    source_start_date_LENGTH_ErrorCount := COUNT(GROUP,h.source_start_date_Invalid=2);
    source_start_date_Total_ErrorCount := COUNT(GROUP,h.source_start_date_Invalid>0);
    source_end_date_ALLOW_ErrorCount := COUNT(GROUP,h.source_end_date_Invalid=1);
    source_end_date_LENGTH_ErrorCount := COUNT(GROUP,h.source_end_date_Invalid=2);
    source_end_date_Total_ErrorCount := COUNT(GROUP,h.source_end_date_Invalid>0);
    source_termination_date_ALLOW_ErrorCount := COUNT(GROUP,h.source_termination_date_Invalid=1);
    source_termination_date_LENGTH_ErrorCount := COUNT(GROUP,h.source_termination_date_Invalid=2);
    source_termination_date_Total_ErrorCount := COUNT(GROUP,h.source_termination_date_Invalid>0);
    source_resale_allowed_ALLOW_ErrorCount := COUNT(GROUP,h.source_resale_allowed_Invalid=1);
    source_resale_allowed_LENGTH_ErrorCount := COUNT(GROUP,h.source_resale_allowed_Invalid=2);
    source_resale_allowed_Total_ErrorCount := COUNT(GROUP,h.source_resale_allowed_Invalid>0);
    source_auto_renew_ALLOW_ErrorCount := COUNT(GROUP,h.source_auto_renew_Invalid=1);
    source_auto_renew_LENGTH_ErrorCount := COUNT(GROUP,h.source_auto_renew_Invalid=2);
    source_auto_renew_Total_ErrorCount := COUNT(GROUP,h.source_auto_renew_Invalid>0);
    source_allow_sale_of_component_data_ALLOW_ErrorCount := COUNT(GROUP,h.source_allow_sale_of_component_data_Invalid=1);
    source_allow_sale_of_component_data_LENGTH_ErrorCount := COUNT(GROUP,h.source_allow_sale_of_component_data_Invalid=2);
    source_allow_sale_of_component_data_Total_ErrorCount := COUNT(GROUP,h.source_allow_sale_of_component_data_Invalid>0);
    source_allow_extract_of_vehicle_data_ALLOW_ErrorCount := COUNT(GROUP,h.source_allow_extract_of_vehicle_data_Invalid=1);
    source_allow_extract_of_vehicle_data_LENGTH_ErrorCount := COUNT(GROUP,h.source_allow_extract_of_vehicle_data_Invalid=2);
    source_allow_extract_of_vehicle_data_Total_ErrorCount := COUNT(GROUP,h.source_allow_extract_of_vehicle_data_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.agency_id_Invalid,le.source_id_Invalid,le.agency_state_abbr_Invalid,le.agency_ori_Invalid,le.allow_open_search_Invalid,le.append_overwrite_flag_Invalid,le.drivers_exchange_flag_Invalid,le.source_start_date_Invalid,le.source_end_date_Invalid,le.source_termination_date_Invalid,le.source_resale_allowed_Invalid,le.source_auto_renew_Invalid,le.source_allow_sale_of_component_data_Invalid,le.source_allow_extract_of_vehicle_data_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_agency_id(le.agency_id_Invalid),Fields.InvalidMessage_source_id(le.source_id_Invalid),Fields.InvalidMessage_agency_state_abbr(le.agency_state_abbr_Invalid),Fields.InvalidMessage_agency_ori(le.agency_ori_Invalid),Fields.InvalidMessage_allow_open_search(le.allow_open_search_Invalid),Fields.InvalidMessage_append_overwrite_flag(le.append_overwrite_flag_Invalid),Fields.InvalidMessage_drivers_exchange_flag(le.drivers_exchange_flag_Invalid),Fields.InvalidMessage_source_start_date(le.source_start_date_Invalid),Fields.InvalidMessage_source_end_date(le.source_end_date_Invalid),Fields.InvalidMessage_source_termination_date(le.source_termination_date_Invalid),Fields.InvalidMessage_source_resale_allowed(le.source_resale_allowed_Invalid),Fields.InvalidMessage_source_auto_renew(le.source_auto_renew_Invalid),Fields.InvalidMessage_source_allow_sale_of_component_data(le.source_allow_sale_of_component_data_Invalid),Fields.InvalidMessage_source_allow_extract_of_vehicle_data(le.source_allow_extract_of_vehicle_data_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.agency_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.agency_state_abbr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.agency_ori_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.allow_open_search_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.append_overwrite_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.drivers_exchange_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_start_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_end_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_termination_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_resale_allowed_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_auto_renew_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_allow_sale_of_component_data_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_allow_extract_of_vehicle_data_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'agency_id','source_id','agency_state_abbr','agency_ori','allow_open_search','append_overwrite_flag','drivers_exchange_flag','source_start_date','source_end_date','source_termination_date','source_resale_allowed','source_auto_renew','source_allow_sale_of_component_data','source_allow_extract_of_vehicle_data','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_agency_id','invalid_source_id','invalid_agency_state_abbr','invalid_agency_ori','invalid_allow_open_search','invalid_append_overwrite_flag','invalid_drivers_exchange_flag','invalid_date','invalid_date','invalid_date_time','invalid_resale_allowed','invalid_auto_renew','invalid_Allow_Sale_Of_Component_Data','invalid_Allow_Extract_Of_Vehicle_Data','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.agency_id,(SALT37.StrType)le.source_id,(SALT37.StrType)le.agency_state_abbr,(SALT37.StrType)le.agency_ori,(SALT37.StrType)le.allow_open_search,(SALT37.StrType)le.append_overwrite_flag,(SALT37.StrType)le.drivers_exchange_flag,(SALT37.StrType)le.source_start_date,(SALT37.StrType)le.source_end_date,(SALT37.StrType)le.source_termination_date,(SALT37.StrType)le.source_resale_allowed,(SALT37.StrType)le.source_auto_renew,(SALT37.StrType)le.source_allow_sale_of_component_data,(SALT37.StrType)le.source_allow_extract_of_vehicle_data,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,14,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'agency_id:invalid_agency_id:ALLOW','agency_id:invalid_agency_id:LENGTH'
          ,'source_id:invalid_source_id:ALLOW','source_id:invalid_source_id:LENGTH'
          ,'agency_state_abbr:invalid_agency_state_abbr:CUSTOM'
          ,'agency_ori:invalid_agency_ori:ALLOW'
          ,'allow_open_search:invalid_allow_open_search:ALLOW','allow_open_search:invalid_allow_open_search:LENGTH'
          ,'append_overwrite_flag:invalid_append_overwrite_flag:ENUM','append_overwrite_flag:invalid_append_overwrite_flag:LENGTH'
          ,'drivers_exchange_flag:invalid_drivers_exchange_flag:ALLOW','drivers_exchange_flag:invalid_drivers_exchange_flag:LENGTH'
          ,'source_start_date:invalid_date:ALLOW','source_start_date:invalid_date:LENGTH'
          ,'source_end_date:invalid_date:ALLOW','source_end_date:invalid_date:LENGTH'
          ,'source_termination_date:invalid_date_time:ALLOW','source_termination_date:invalid_date_time:LENGTH'
          ,'source_resale_allowed:invalid_resale_allowed:ALLOW','source_resale_allowed:invalid_resale_allowed:LENGTH'
          ,'source_auto_renew:invalid_auto_renew:ALLOW','source_auto_renew:invalid_auto_renew:LENGTH'
          ,'source_allow_sale_of_component_data:invalid_Allow_Sale_Of_Component_Data:ALLOW','source_allow_sale_of_component_data:invalid_Allow_Sale_Of_Component_Data:LENGTH'
          ,'source_allow_extract_of_vehicle_data:invalid_Allow_Extract_Of_Vehicle_Data:ALLOW','source_allow_extract_of_vehicle_data:invalid_Allow_Extract_Of_Vehicle_Data:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_agency_id(1),Fields.InvalidMessage_agency_id(2)
          ,Fields.InvalidMessage_source_id(1),Fields.InvalidMessage_source_id(2)
          ,Fields.InvalidMessage_agency_state_abbr(1)
          ,Fields.InvalidMessage_agency_ori(1)
          ,Fields.InvalidMessage_allow_open_search(1),Fields.InvalidMessage_allow_open_search(2)
          ,Fields.InvalidMessage_append_overwrite_flag(1),Fields.InvalidMessage_append_overwrite_flag(2)
          ,Fields.InvalidMessage_drivers_exchange_flag(1),Fields.InvalidMessage_drivers_exchange_flag(2)
          ,Fields.InvalidMessage_source_start_date(1),Fields.InvalidMessage_source_start_date(2)
          ,Fields.InvalidMessage_source_end_date(1),Fields.InvalidMessage_source_end_date(2)
          ,Fields.InvalidMessage_source_termination_date(1),Fields.InvalidMessage_source_termination_date(2)
          ,Fields.InvalidMessage_source_resale_allowed(1),Fields.InvalidMessage_source_resale_allowed(2)
          ,Fields.InvalidMessage_source_auto_renew(1),Fields.InvalidMessage_source_auto_renew(2)
          ,Fields.InvalidMessage_source_allow_sale_of_component_data(1),Fields.InvalidMessage_source_allow_sale_of_component_data(2)
          ,Fields.InvalidMessage_source_allow_extract_of_vehicle_data(1),Fields.InvalidMessage_source_allow_extract_of_vehicle_data(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.agency_id_ALLOW_ErrorCount,le.agency_id_LENGTH_ErrorCount
          ,le.source_id_ALLOW_ErrorCount,le.source_id_LENGTH_ErrorCount
          ,le.agency_state_abbr_CUSTOM_ErrorCount
          ,le.agency_ori_ALLOW_ErrorCount
          ,le.allow_open_search_ALLOW_ErrorCount,le.allow_open_search_LENGTH_ErrorCount
          ,le.append_overwrite_flag_ENUM_ErrorCount,le.append_overwrite_flag_LENGTH_ErrorCount
          ,le.drivers_exchange_flag_ALLOW_ErrorCount,le.drivers_exchange_flag_LENGTH_ErrorCount
          ,le.source_start_date_ALLOW_ErrorCount,le.source_start_date_LENGTH_ErrorCount
          ,le.source_end_date_ALLOW_ErrorCount,le.source_end_date_LENGTH_ErrorCount
          ,le.source_termination_date_ALLOW_ErrorCount,le.source_termination_date_LENGTH_ErrorCount
          ,le.source_resale_allowed_ALLOW_ErrorCount,le.source_resale_allowed_LENGTH_ErrorCount
          ,le.source_auto_renew_ALLOW_ErrorCount,le.source_auto_renew_LENGTH_ErrorCount
          ,le.source_allow_sale_of_component_data_ALLOW_ErrorCount,le.source_allow_sale_of_component_data_LENGTH_ErrorCount
          ,le.source_allow_extract_of_vehicle_data_ALLOW_ErrorCount,le.source_allow_extract_of_vehicle_data_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.agency_id_ALLOW_ErrorCount,le.agency_id_LENGTH_ErrorCount
          ,le.source_id_ALLOW_ErrorCount,le.source_id_LENGTH_ErrorCount
          ,le.agency_state_abbr_CUSTOM_ErrorCount
          ,le.agency_ori_ALLOW_ErrorCount
          ,le.allow_open_search_ALLOW_ErrorCount,le.allow_open_search_LENGTH_ErrorCount
          ,le.append_overwrite_flag_ENUM_ErrorCount,le.append_overwrite_flag_LENGTH_ErrorCount
          ,le.drivers_exchange_flag_ALLOW_ErrorCount,le.drivers_exchange_flag_LENGTH_ErrorCount
          ,le.source_start_date_ALLOW_ErrorCount,le.source_start_date_LENGTH_ErrorCount
          ,le.source_end_date_ALLOW_ErrorCount,le.source_end_date_LENGTH_ErrorCount
          ,le.source_termination_date_ALLOW_ErrorCount,le.source_termination_date_LENGTH_ErrorCount
          ,le.source_resale_allowed_ALLOW_ErrorCount,le.source_resale_allowed_LENGTH_ErrorCount
          ,le.source_auto_renew_ALLOW_ErrorCount,le.source_auto_renew_LENGTH_ErrorCount
          ,le.source_allow_sale_of_component_data_ALLOW_ErrorCount,le.source_allow_sale_of_component_data_LENGTH_ErrorCount
          ,le.source_allow_extract_of_vehicle_data_ALLOW_ErrorCount,le.source_allow_extract_of_vehicle_data_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,26,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
