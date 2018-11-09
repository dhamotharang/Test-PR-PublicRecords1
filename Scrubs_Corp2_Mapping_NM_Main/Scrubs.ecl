IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 33;
  EXPORT NumRulesFromFieldType := 33;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 22;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_NM)
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 corp_ra_dt_first_seen_Invalid;
    UNSIGNED1 corp_ra_dt_last_seen_Invalid;
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_orig_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 corp_ln_name_type_cd_Invalid;
    UNSIGNED1 corp_ln_name_type_desc_Invalid;
    UNSIGNED1 corp_status_desc_Invalid;
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_inc_date_Invalid;
    UNSIGNED1 corp_foreign_domestic_ind_Invalid;
    UNSIGNED1 corp_forgn_date_Invalid;
    UNSIGNED1 corp_orig_org_structure_desc_Invalid;
    UNSIGNED1 corp_for_profit_ind_Invalid;
    UNSIGNED1 recordorigin_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_NM)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_NM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen);
    SELF.corp_ra_dt_first_seen_Invalid := Fields.InValid_corp_ra_dt_first_seen((SALT38.StrType)le.corp_ra_dt_first_seen);
    SELF.corp_ra_dt_last_seen_Invalid := Fields.InValid_corp_ra_dt_last_seen((SALT38.StrType)le.corp_ra_dt_last_seen);
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT38.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT38.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT38.StrType)le.corp_legal_name);
    SELF.corp_ln_name_type_cd_Invalid := Fields.InValid_corp_ln_name_type_cd((SALT38.StrType)le.corp_ln_name_type_cd);
    SELF.corp_ln_name_type_desc_Invalid := Fields.InValid_corp_ln_name_type_desc((SALT38.StrType)le.corp_ln_name_type_desc);
    SELF.corp_status_desc_Invalid := Fields.InValid_corp_status_desc((SALT38.StrType)le.corp_status_desc);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT38.StrType)le.corp_inc_state);
    SELF.corp_inc_date_Invalid := Fields.InValid_corp_inc_date((SALT38.StrType)le.corp_inc_date);
    SELF.corp_foreign_domestic_ind_Invalid := Fields.InValid_corp_foreign_domestic_ind((SALT38.StrType)le.corp_foreign_domestic_ind);
    SELF.corp_forgn_date_Invalid := Fields.InValid_corp_forgn_date((SALT38.StrType)le.corp_forgn_date);
    SELF.corp_orig_org_structure_desc_Invalid := Fields.InValid_corp_orig_org_structure_desc((SALT38.StrType)le.corp_orig_org_structure_desc);
    SELF.corp_for_profit_ind_Invalid := Fields.InValid_corp_for_profit_ind((SALT38.StrType)le.corp_for_profit_ind);
    SELF.recordorigin_Invalid := Fields.InValid_recordorigin((SALT38.StrType)le.recordorigin);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_NM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_vendor_first_reported_Invalid << 0 ) + ( le.dt_vendor_last_reported_Invalid << 2 ) + ( le.dt_first_seen_Invalid << 4 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.corp_ra_dt_first_seen_Invalid << 8 ) + ( le.corp_ra_dt_last_seen_Invalid << 10 ) + ( le.corp_key_Invalid << 12 ) + ( le.corp_vendor_Invalid << 14 ) + ( le.corp_state_origin_Invalid << 15 ) + ( le.corp_process_date_Invalid << 16 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 18 ) + ( le.corp_legal_name_Invalid << 20 ) + ( le.corp_ln_name_type_cd_Invalid << 21 ) + ( le.corp_ln_name_type_desc_Invalid << 22 ) + ( le.corp_status_desc_Invalid << 23 ) + ( le.corp_inc_state_Invalid << 24 ) + ( le.corp_inc_date_Invalid << 25 ) + ( le.corp_foreign_domestic_ind_Invalid << 27 ) + ( le.corp_forgn_date_Invalid << 28 ) + ( le.corp_orig_org_structure_desc_Invalid << 30 ) + ( le.corp_for_profit_ind_Invalid << 31 ) + ( le.recordorigin_Invalid << 32 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_NM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.corp_ra_dt_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.corp_ra_dt_last_seen_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.corp_orig_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.corp_ln_name_type_cd_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.corp_ln_name_type_desc_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.corp_status_desc_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.corp_inc_date_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.corp_foreign_domestic_ind_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.corp_forgn_date_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.corp_orig_org_structure_desc_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.corp_for_profit_ind_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.recordorigin_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    corp_ra_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=1);
    corp_ra_dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=2);
    corp_ra_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid>0);
    corp_ra_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=1);
    corp_ra_dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=2);
    corp_ra_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid>0);
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_orig_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=1);
    corp_orig_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=2);
    corp_orig_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid>0);
    corp_legal_name_LENGTH_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    corp_ln_name_type_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_cd_Invalid=1);
    corp_ln_name_type_desc_ENUM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_desc_Invalid=1);
    corp_status_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_desc_Invalid=1);
    corp_inc_state_ENUM_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_inc_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=1);
    corp_inc_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=2);
    corp_inc_date_Total_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid>0);
    corp_foreign_domestic_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_foreign_domestic_ind_Invalid=1);
    corp_forgn_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=1);
    corp_forgn_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=2);
    corp_forgn_date_Total_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid>0);
    corp_orig_org_structure_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_orig_org_structure_desc_Invalid=1);
    corp_for_profit_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_for_profit_ind_Invalid=1);
    recordorigin_ENUM_ErrorCount := COUNT(GROUP,h.recordorigin_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.corp_ra_dt_first_seen_Invalid > 0 OR h.corp_ra_dt_last_seen_Invalid > 0 OR h.corp_key_Invalid > 0 OR h.corp_vendor_Invalid > 0 OR h.corp_state_origin_Invalid > 0 OR h.corp_process_date_Invalid > 0 OR h.corp_orig_sos_charter_nbr_Invalid > 0 OR h.corp_legal_name_Invalid > 0 OR h.corp_ln_name_type_cd_Invalid > 0 OR h.corp_ln_name_type_desc_Invalid > 0 OR h.corp_status_desc_Invalid > 0 OR h.corp_inc_state_Invalid > 0 OR h.corp_inc_date_Invalid > 0 OR h.corp_foreign_domestic_ind_Invalid > 0 OR h.corp_forgn_date_Invalid > 0 OR h.corp_orig_org_structure_desc_Invalid > 0 OR h.corp_for_profit_ind_Invalid > 0 OR h.recordorigin_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.corp_key_Total_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_orig_sos_charter_nbr_Total_ErrorCount > 0, 1, 0) + IF(le.corp_legal_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_ln_name_type_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_ln_name_type_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_status_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_inc_state_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_foreign_domestic_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_orig_org_structure_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_for_profit_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.recordorigin_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_key_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_legal_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.corp_ln_name_type_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_ln_name_type_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_status_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_inc_state_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_foreign_domestic_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_orig_org_structure_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_for_profit_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.recordorigin_ENUM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.corp_ra_dt_first_seen_Invalid,le.corp_ra_dt_last_seen_Invalid,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_legal_name_Invalid,le.corp_ln_name_type_cd_Invalid,le.corp_ln_name_type_desc_Invalid,le.corp_status_desc_Invalid,le.corp_inc_state_Invalid,le.corp_inc_date_Invalid,le.corp_foreign_domestic_ind_Invalid,le.corp_forgn_date_Invalid,le.corp_orig_org_structure_desc_Invalid,le.corp_for_profit_ind_Invalid,le.recordorigin_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_first_seen(le.corp_ra_dt_first_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_last_seen(le.corp_ra_dt_last_seen_Invalid),Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_corp_ln_name_type_cd(le.corp_ln_name_type_cd_Invalid),Fields.InvalidMessage_corp_ln_name_type_desc(le.corp_ln_name_type_desc_Invalid),Fields.InvalidMessage_corp_status_desc(le.corp_status_desc_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_inc_date(le.corp_inc_date_Invalid),Fields.InvalidMessage_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind_Invalid),Fields.InvalidMessage_corp_forgn_date(le.corp_forgn_date_Invalid),Fields.InvalidMessage_corp_orig_org_structure_desc(le.corp_orig_org_structure_desc_Invalid),Fields.InvalidMessage_corp_for_profit_ind(le.corp_for_profit_ind_Invalid),Fields.InvalidMessage_recordorigin(le.recordorigin_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_first_seen_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_last_seen_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_orig_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ln_name_type_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_ln_name_type_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_status_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_inc_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_foreign_domestic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_forgn_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_orig_org_structure_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_for_profit_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recordorigin_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_status_desc','corp_inc_state','corp_inc_date','corp_foreign_domestic_ind','corp_forgn_date','corp_orig_org_structure_desc','corp_for_profit_ind','recordorigin','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter','invalid_mandatory','invalid_name_type_code','invalid_name_type_desc','invalid_status_desc','invalid_state_origin','invalid_date','invalid_forgn_dom_code','invalid_date','invalid_org_desc','invalid_flag_code','invalid_recordorigin','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.dt_first_seen,(SALT38.StrType)le.dt_last_seen,(SALT38.StrType)le.corp_ra_dt_first_seen,(SALT38.StrType)le.corp_ra_dt_last_seen,(SALT38.StrType)le.corp_key,(SALT38.StrType)le.corp_vendor,(SALT38.StrType)le.corp_state_origin,(SALT38.StrType)le.corp_process_date,(SALT38.StrType)le.corp_orig_sos_charter_nbr,(SALT38.StrType)le.corp_legal_name,(SALT38.StrType)le.corp_ln_name_type_cd,(SALT38.StrType)le.corp_ln_name_type_desc,(SALT38.StrType)le.corp_status_desc,(SALT38.StrType)le.corp_inc_state,(SALT38.StrType)le.corp_inc_date,(SALT38.StrType)le.corp_foreign_domestic_ind,(SALT38.StrType)le.corp_forgn_date,(SALT38.StrType)le.corp_orig_org_structure_desc,(SALT38.StrType)le.corp_for_profit_ind,(SALT38.StrType)le.recordorigin,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_NM) prevDS = DATASET([], Layout_In_NM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_vendor_first_reported:invalid_date:ALLOW','dt_vendor_first_reported:invalid_date:CUSTOM'
          ,'dt_vendor_last_reported:invalid_date:ALLOW','dt_vendor_last_reported:invalid_date:CUSTOM'
          ,'dt_first_seen:invalid_date:ALLOW','dt_first_seen:invalid_date:CUSTOM'
          ,'dt_last_seen:invalid_date:ALLOW','dt_last_seen:invalid_date:CUSTOM'
          ,'corp_ra_dt_first_seen:invalid_date:ALLOW','corp_ra_dt_first_seen:invalid_date:CUSTOM'
          ,'corp_ra_dt_last_seen:invalid_date:ALLOW','corp_ra_dt_last_seen:invalid_date:CUSTOM'
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM'
          ,'corp_orig_sos_charter_nbr:invalid_charter:ALLOW','corp_orig_sos_charter_nbr:invalid_charter:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'corp_ln_name_type_cd:invalid_name_type_code:ENUM'
          ,'corp_ln_name_type_desc:invalid_name_type_desc:ENUM'
          ,'corp_status_desc:invalid_status_desc:ALLOW'
          ,'corp_inc_state:invalid_state_origin:ENUM'
          ,'corp_inc_date:invalid_date:ALLOW','corp_inc_date:invalid_date:CUSTOM'
          ,'corp_foreign_domestic_ind:invalid_forgn_dom_code:ENUM'
          ,'corp_forgn_date:invalid_date:ALLOW','corp_forgn_date:invalid_date:CUSTOM'
          ,'corp_orig_org_structure_desc:invalid_org_desc:ALLOW'
          ,'corp_for_profit_ind:invalid_flag_code:ENUM'
          ,'recordorigin:invalid_recordorigin:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2)
          ,Fields.InvalidMessage_corp_ra_dt_first_seen(1),Fields.InvalidMessage_corp_ra_dt_first_seen(2)
          ,Fields.InvalidMessage_corp_ra_dt_last_seen(1),Fields.InvalidMessage_corp_ra_dt_last_seen(2)
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2)
          ,Fields.InvalidMessage_corp_orig_sos_charter_nbr(1),Fields.InvalidMessage_corp_orig_sos_charter_nbr(2)
          ,Fields.InvalidMessage_corp_legal_name(1)
          ,Fields.InvalidMessage_corp_ln_name_type_cd(1)
          ,Fields.InvalidMessage_corp_ln_name_type_desc(1)
          ,Fields.InvalidMessage_corp_status_desc(1)
          ,Fields.InvalidMessage_corp_inc_state(1)
          ,Fields.InvalidMessage_corp_inc_date(1),Fields.InvalidMessage_corp_inc_date(2)
          ,Fields.InvalidMessage_corp_foreign_domestic_ind(1)
          ,Fields.InvalidMessage_corp_forgn_date(1),Fields.InvalidMessage_corp_forgn_date(2)
          ,Fields.InvalidMessage_corp_orig_org_structure_desc(1)
          ,Fields.InvalidMessage_corp_for_profit_ind(1)
          ,Fields.InvalidMessage_recordorigin(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_ln_name_type_cd_ENUM_ErrorCount
          ,le.corp_ln_name_type_desc_ENUM_ErrorCount
          ,le.corp_status_desc_ALLOW_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount
          ,le.corp_orig_org_structure_desc_ALLOW_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.recordorigin_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_ln_name_type_cd_ENUM_ErrorCount
          ,le.corp_ln_name_type_desc_ENUM_ErrorCount
          ,le.corp_status_desc_ALLOW_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount
          ,le.corp_orig_org_structure_desc_ALLOW_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.recordorigin_ENUM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_In_NM));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_dt_first_seen:' + getFieldTypeText(h.corp_ra_dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_dt_last_seen:' + getFieldTypeText(h.corp_ra_dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_key:' + getFieldTypeText(h.corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_supp_key:' + getFieldTypeText(h.corp_supp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor:' + getFieldTypeText(h.corp_vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor_county:' + getFieldTypeText(h.corp_vendor_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor_subcode:' + getFieldTypeText(h.corp_vendor_subcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_state_origin:' + getFieldTypeText(h.corp_state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_process_date:' + getFieldTypeText(h.corp_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_orig_sos_charter_nbr:' + getFieldTypeText(h.corp_orig_sos_charter_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_legal_name:' + getFieldTypeText(h.corp_legal_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ln_name_type_cd:' + getFieldTypeText(h.corp_ln_name_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ln_name_type_desc:' + getFieldTypeText(h.corp_ln_name_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_supp_nbr:' + getFieldTypeText(h.corp_supp_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_comment:' + getFieldTypeText(h.corp_name_comment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address1_type_cd:' + getFieldTypeText(h.corp_address1_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address1_type_desc:' + getFieldTypeText(h.corp_address1_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address1_line1:' + getFieldTypeText(h.corp_address1_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address1_line2:' + getFieldTypeText(h.corp_address1_line2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address1_line3:' + getFieldTypeText(h.corp_address1_line3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address1_effective_date:' + getFieldTypeText(h.corp_address1_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address2_type_cd:' + getFieldTypeText(h.corp_address2_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address2_type_desc:' + getFieldTypeText(h.corp_address2_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address2_line1:' + getFieldTypeText(h.corp_address2_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address2_line2:' + getFieldTypeText(h.corp_address2_line2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address2_line3:' + getFieldTypeText(h.corp_address2_line3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address2_effective_date:' + getFieldTypeText(h.corp_address2_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_phone_number:' + getFieldTypeText(h.corp_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_phone_number_type_cd:' + getFieldTypeText(h.corp_phone_number_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_phone_number_type_desc:' + getFieldTypeText(h.corp_phone_number_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_fax_nbr:' + getFieldTypeText(h.corp_fax_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_email_address:' + getFieldTypeText(h.corp_email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_web_address:' + getFieldTypeText(h.corp_web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_filing_reference_nbr:' + getFieldTypeText(h.corp_filing_reference_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_filing_date:' + getFieldTypeText(h.corp_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_filing_cd:' + getFieldTypeText(h.corp_filing_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_filing_desc:' + getFieldTypeText(h.corp_filing_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_status_cd:' + getFieldTypeText(h.corp_status_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_status_desc:' + getFieldTypeText(h.corp_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_status_date:' + getFieldTypeText(h.corp_status_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_standing:' + getFieldTypeText(h.corp_standing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_status_comment:' + getFieldTypeText(h.corp_status_comment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ticker_symbol:' + getFieldTypeText(h.corp_ticker_symbol) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_stock_exchange:' + getFieldTypeText(h.corp_stock_exchange) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_inc_state:' + getFieldTypeText(h.corp_inc_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_inc_county:' + getFieldTypeText(h.corp_inc_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_inc_date:' + getFieldTypeText(h.corp_inc_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_anniversary_month:' + getFieldTypeText(h.corp_anniversary_month) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_fed_tax_id:' + getFieldTypeText(h.corp_fed_tax_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_state_tax_id:' + getFieldTypeText(h.corp_state_tax_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_term_exist_cd:' + getFieldTypeText(h.corp_term_exist_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_term_exist_exp:' + getFieldTypeText(h.corp_term_exist_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_term_exist_desc:' + getFieldTypeText(h.corp_term_exist_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_foreign_domestic_ind:' + getFieldTypeText(h.corp_foreign_domestic_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_state_cd:' + getFieldTypeText(h.corp_forgn_state_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_state_desc:' + getFieldTypeText(h.corp_forgn_state_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_sos_charter_nbr:' + getFieldTypeText(h.corp_forgn_sos_charter_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_date:' + getFieldTypeText(h.corp_forgn_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_fed_tax_id:' + getFieldTypeText(h.corp_forgn_fed_tax_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_state_tax_id:' + getFieldTypeText(h.corp_forgn_state_tax_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_term_exist_cd:' + getFieldTypeText(h.corp_forgn_term_exist_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_term_exist_exp:' + getFieldTypeText(h.corp_forgn_term_exist_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_term_exist_desc:' + getFieldTypeText(h.corp_forgn_term_exist_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_orig_org_structure_cd:' + getFieldTypeText(h.corp_orig_org_structure_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_orig_org_structure_desc:' + getFieldTypeText(h.corp_orig_org_structure_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_for_profit_ind:' + getFieldTypeText(h.corp_for_profit_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_public_or_private_ind:' + getFieldTypeText(h.corp_public_or_private_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_sic_code:' + getFieldTypeText(h.corp_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_naic_code:' + getFieldTypeText(h.corp_naic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_orig_bus_type_cd:' + getFieldTypeText(h.corp_orig_bus_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_orig_bus_type_desc:' + getFieldTypeText(h.corp_orig_bus_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_entity_desc:' + getFieldTypeText(h.corp_entity_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_certificate_nbr:' + getFieldTypeText(h.corp_certificate_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_internal_nbr:' + getFieldTypeText(h.corp_internal_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_previous_nbr:' + getFieldTypeText(h.corp_previous_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_microfilm_nbr:' + getFieldTypeText(h.corp_microfilm_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_amendments_filed:' + getFieldTypeText(h.corp_amendments_filed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_acts:' + getFieldTypeText(h.corp_acts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_partnership_ind:' + getFieldTypeText(h.corp_partnership_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_mfg_ind:' + getFieldTypeText(h.corp_mfg_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_addl_info:' + getFieldTypeText(h.corp_addl_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_taxes:' + getFieldTypeText(h.corp_taxes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_franchise_taxes:' + getFieldTypeText(h.corp_franchise_taxes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_tax_program_cd:' + getFieldTypeText(h.corp_tax_program_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_tax_program_desc:' + getFieldTypeText(h.corp_tax_program_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_full_name:' + getFieldTypeText(h.corp_ra_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_fname:' + getFieldTypeText(h.corp_ra_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_mname:' + getFieldTypeText(h.corp_ra_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_lname:' + getFieldTypeText(h.corp_ra_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_title_cd:' + getFieldTypeText(h.corp_ra_title_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_title_desc:' + getFieldTypeText(h.corp_ra_title_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_fein:' + getFieldTypeText(h.corp_ra_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_ssn:' + getFieldTypeText(h.corp_ra_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_dob:' + getFieldTypeText(h.corp_ra_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_effective_date:' + getFieldTypeText(h.corp_ra_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_resign_date:' + getFieldTypeText(h.corp_ra_resign_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_no_comp:' + getFieldTypeText(h.corp_ra_no_comp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_no_comp_igs:' + getFieldTypeText(h.corp_ra_no_comp_igs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_addl_info:' + getFieldTypeText(h.corp_ra_addl_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_address_type_cd:' + getFieldTypeText(h.corp_ra_address_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_address_type_desc:' + getFieldTypeText(h.corp_ra_address_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_address_line1:' + getFieldTypeText(h.corp_ra_address_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_address_line2:' + getFieldTypeText(h.corp_ra_address_line2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_address_line3:' + getFieldTypeText(h.corp_ra_address_line3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_phone_number:' + getFieldTypeText(h.corp_ra_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_phone_number_type_cd:' + getFieldTypeText(h.corp_ra_phone_number_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_phone_number_type_desc:' + getFieldTypeText(h.corp_ra_phone_number_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_fax_nbr:' + getFieldTypeText(h.corp_ra_fax_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_email_address:' + getFieldTypeText(h.corp_ra_email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_web_address:' + getFieldTypeText(h.corp_ra_web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_prep_addr1_line1:' + getFieldTypeText(h.corp_prep_addr1_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_prep_addr1_last_line:' + getFieldTypeText(h.corp_prep_addr1_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_prep_addr2_line1:' + getFieldTypeText(h.corp_prep_addr2_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_prep_addr2_last_line:' + getFieldTypeText(h.corp_prep_addr2_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ra_prep_addr_line1:' + getFieldTypeText(h.ra_prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ra_prep_addr_last_line:' + getFieldTypeText(h.ra_prep_addr_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_filing_reference_nbr:' + getFieldTypeText(h.cont_filing_reference_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_filing_date:' + getFieldTypeText(h.cont_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_filing_cd:' + getFieldTypeText(h.cont_filing_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_filing_desc:' + getFieldTypeText(h.cont_filing_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_type_cd:' + getFieldTypeText(h.cont_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_type_desc:' + getFieldTypeText(h.cont_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_full_name:' + getFieldTypeText(h.cont_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_fname:' + getFieldTypeText(h.cont_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_mname:' + getFieldTypeText(h.cont_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_lname:' + getFieldTypeText(h.cont_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_title1_desc:' + getFieldTypeText(h.cont_title1_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_title2_desc:' + getFieldTypeText(h.cont_title2_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_title3_desc:' + getFieldTypeText(h.cont_title3_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_title4_desc:' + getFieldTypeText(h.cont_title4_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_title5_desc:' + getFieldTypeText(h.cont_title5_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_fein:' + getFieldTypeText(h.cont_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_ssn:' + getFieldTypeText(h.cont_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_dob:' + getFieldTypeText(h.cont_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_status_cd:' + getFieldTypeText(h.cont_status_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_status_desc:' + getFieldTypeText(h.cont_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_effective_date:' + getFieldTypeText(h.cont_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_effective_cd:' + getFieldTypeText(h.cont_effective_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_effective_desc:' + getFieldTypeText(h.cont_effective_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_addl_info:' + getFieldTypeText(h.cont_addl_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_type_cd:' + getFieldTypeText(h.cont_address_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_type_desc:' + getFieldTypeText(h.cont_address_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_line1:' + getFieldTypeText(h.cont_address_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_line2:' + getFieldTypeText(h.cont_address_line2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_line3:' + getFieldTypeText(h.cont_address_line3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_effective_date:' + getFieldTypeText(h.cont_address_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_address_county:' + getFieldTypeText(h.cont_address_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_phone_number:' + getFieldTypeText(h.cont_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_phone_number_type_cd:' + getFieldTypeText(h.cont_phone_number_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_phone_number_type_desc:' + getFieldTypeText(h.cont_phone_number_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_fax_nbr:' + getFieldTypeText(h.cont_fax_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_email_address:' + getFieldTypeText(h.cont_email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_web_address:' + getFieldTypeText(h.cont_web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_acres:' + getFieldTypeText(h.corp_acres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action:' + getFieldTypeText(h.corp_action) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action_date:' + getFieldTypeText(h.corp_action_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action_employment_security_approval_date:' + getFieldTypeText(h.corp_action_employment_security_approval_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action_pending_cd:' + getFieldTypeText(h.corp_action_pending_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action_pending_desc:' + getFieldTypeText(h.corp_action_pending_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action_statement_of_intent_date:' + getFieldTypeText(h.corp_action_statement_of_intent_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_action_tax_dept_approval_date:' + getFieldTypeText(h.corp_action_tax_dept_approval_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_acts2:' + getFieldTypeText(h.corp_acts2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_acts3:' + getFieldTypeText(h.corp_acts3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_additional_principals:' + getFieldTypeText(h.corp_additional_principals) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_address_office_type:' + getFieldTypeText(h.corp_address_office_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_commercial:' + getFieldTypeText(h.corp_agent_commercial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_country:' + getFieldTypeText(h.corp_agent_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_county:' + getFieldTypeText(h.corp_agent_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_status_cd:' + getFieldTypeText(h.corp_agent_status_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_status_desc:' + getFieldTypeText(h.corp_agent_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_id:' + getFieldTypeText(h.corp_agent_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agent_assign_date:' + getFieldTypeText(h.corp_agent_assign_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_agriculture_flag:' + getFieldTypeText(h.corp_agriculture_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_authorized_partners:' + getFieldTypeText(h.corp_authorized_partners) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_comment:' + getFieldTypeText(h.corp_comment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_consent_flag_for_protected_name:' + getFieldTypeText(h.corp_consent_flag_for_protected_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_converted:' + getFieldTypeText(h.corp_converted) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_converted_from:' + getFieldTypeText(h.corp_converted_from) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_country_of_formation:' + getFieldTypeText(h.corp_country_of_formation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_date_of_organization_meeting:' + getFieldTypeText(h.corp_date_of_organization_meeting) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_delayed_effective_date:' + getFieldTypeText(h.corp_delayed_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_directors_from_to:' + getFieldTypeText(h.corp_directors_from_to) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_dissolved_date:' + getFieldTypeText(h.corp_dissolved_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_farm_exemptions:' + getFieldTypeText(h.corp_farm_exemptions) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_farm_qual_date:' + getFieldTypeText(h.corp_farm_qual_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_farm_status_cd:' + getFieldTypeText(h.corp_farm_status_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_farm_status_desc:' + getFieldTypeText(h.corp_farm_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_fiscal_year_month:' + getFieldTypeText(h.corp_fiscal_year_month) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_foreign_fiduciary_capacity_in_state:' + getFieldTypeText(h.corp_foreign_fiduciary_capacity_in_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_governing_statute:' + getFieldTypeText(h.corp_governing_statute) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_has_members:' + getFieldTypeText(h.corp_has_members) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_has_vested_managers:' + getFieldTypeText(h.corp_has_vested_managers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_home_incorporated_county:' + getFieldTypeText(h.corp_home_incorporated_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_home_state_name:' + getFieldTypeText(h.corp_home_state_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_is_professional:' + getFieldTypeText(h.corp_is_professional) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_is_non_profit_irs_approved:' + getFieldTypeText(h.corp_is_non_profit_irs_approved) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_last_renewal_date:' + getFieldTypeText(h.corp_last_renewal_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_last_renewal_year:' + getFieldTypeText(h.corp_last_renewal_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_license_type:' + getFieldTypeText(h.corp_license_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_llc_managed_desc:' + getFieldTypeText(h.corp_llc_managed_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_llc_managed_ind:' + getFieldTypeText(h.corp_llc_managed_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_management_desc:' + getFieldTypeText(h.corp_management_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_management_type:' + getFieldTypeText(h.corp_management_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_manager_managed:' + getFieldTypeText(h.corp_manager_managed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merged_corporation_id:' + getFieldTypeText(h.corp_merged_corporation_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merged_fein:' + getFieldTypeText(h.corp_merged_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_allowed_flag:' + getFieldTypeText(h.corp_merger_allowed_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_date:' + getFieldTypeText(h.corp_merger_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_desc:' + getFieldTypeText(h.corp_merger_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_effective_date:' + getFieldTypeText(h.corp_merger_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_id:' + getFieldTypeText(h.corp_merger_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_indicator:' + getFieldTypeText(h.corp_merger_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_name:' + getFieldTypeText(h.corp_merger_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_type_converted_to_cd:' + getFieldTypeText(h.corp_merger_type_converted_to_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_merger_type_converted_to_desc:' + getFieldTypeText(h.corp_merger_type_converted_to_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_naics_desc:' + getFieldTypeText(h.corp_naics_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_effective_date:' + getFieldTypeText(h.corp_name_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_reservation_date:' + getFieldTypeText(h.corp_name_reservation_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_reservation_desc:' + getFieldTypeText(h.corp_name_reservation_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_reservation_expiration_date:' + getFieldTypeText(h.corp_name_reservation_expiration_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_reservation_nbr:' + getFieldTypeText(h.corp_name_reservation_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_reservation_type:' + getFieldTypeText(h.corp_name_reservation_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_status_cd:' + getFieldTypeText(h.corp_name_status_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_status_date:' + getFieldTypeText(h.corp_name_status_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_name_status_desc:' + getFieldTypeText(h.corp_name_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_non_profit_irs_approved_purpose:' + getFieldTypeText(h.corp_non_profit_irs_approved_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_non_profit_solicit_donations:' + getFieldTypeText(h.corp_non_profit_solicit_donations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_nbr_of_amendments:' + getFieldTypeText(h.corp_nbr_of_amendments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_nbr_of_initial_llc_members:' + getFieldTypeText(h.corp_nbr_of_initial_llc_members) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_nbr_of_partners:' + getFieldTypeText(h.corp_nbr_of_partners) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_operating_agreement:' + getFieldTypeText(h.corp_operating_agreement) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_opt_in_llc_act_desc:' + getFieldTypeText(h.corp_opt_in_llc_act_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_opt_in_llc_act_ind:' + getFieldTypeText(h.corp_opt_in_llc_act_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_organizational_comments:' + getFieldTypeText(h.corp_organizational_comments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_partner_contributions_total:' + getFieldTypeText(h.corp_partner_contributions_total) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_partner_terms:' + getFieldTypeText(h.corp_partner_terms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_percentage_voters_required_to_approve_amendments:' + getFieldTypeText(h.corp_percentage_voters_required_to_approve_amendments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_profession:' + getFieldTypeText(h.corp_profession) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_province:' + getFieldTypeText(h.corp_province) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_public_mutual_corporation:' + getFieldTypeText(h.corp_public_mutual_corporation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_purpose:' + getFieldTypeText(h.corp_purpose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ra_required_flag:' + getFieldTypeText(h.corp_ra_required_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_registered_counties:' + getFieldTypeText(h.corp_registered_counties) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_regulated_ind:' + getFieldTypeText(h.corp_regulated_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_renewal_date:' + getFieldTypeText(h.corp_renewal_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_standing_other:' + getFieldTypeText(h.corp_standing_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_survivor_corporation_id:' + getFieldTypeText(h.corp_survivor_corporation_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_tax_base:' + getFieldTypeText(h.corp_tax_base) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_tax_standing:' + getFieldTypeText(h.corp_tax_standing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_termination_cd:' + getFieldTypeText(h.corp_termination_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_termination_desc:' + getFieldTypeText(h.corp_termination_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_termination_date:' + getFieldTypeText(h.corp_termination_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_business_mark_type:' + getFieldTypeText(h.corp_trademark_business_mark_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_cancelled_date:' + getFieldTypeText(h.corp_trademark_cancelled_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc1:' + getFieldTypeText(h.corp_trademark_class_desc1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc2:' + getFieldTypeText(h.corp_trademark_class_desc2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc3:' + getFieldTypeText(h.corp_trademark_class_desc3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc4:' + getFieldTypeText(h.corp_trademark_class_desc4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc5:' + getFieldTypeText(h.corp_trademark_class_desc5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc6:' + getFieldTypeText(h.corp_trademark_class_desc6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_classification_nbr:' + getFieldTypeText(h.corp_trademark_classification_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_disclaimer1:' + getFieldTypeText(h.corp_trademark_disclaimer1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_disclaimer2:' + getFieldTypeText(h.corp_trademark_disclaimer2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_expiration_date:' + getFieldTypeText(h.corp_trademark_expiration_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_filing_date:' + getFieldTypeText(h.corp_trademark_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_first_use_date:' + getFieldTypeText(h.corp_trademark_first_use_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_first_use_date_in_state:' + getFieldTypeText(h.corp_trademark_first_use_date_in_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_keywords:' + getFieldTypeText(h.corp_trademark_keywords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_logo:' + getFieldTypeText(h.corp_trademark_logo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_name_expiration_date:' + getFieldTypeText(h.corp_trademark_name_expiration_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_nbr:' + getFieldTypeText(h.corp_trademark_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_renewal_date:' + getFieldTypeText(h.corp_trademark_renewal_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_status:' + getFieldTypeText(h.corp_trademark_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_used_1:' + getFieldTypeText(h.corp_trademark_used_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_used_2:' + getFieldTypeText(h.corp_trademark_used_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_used_3:' + getFieldTypeText(h.corp_trademark_used_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_owner_percentage:' + getFieldTypeText(h.cont_owner_percentage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_country:' + getFieldTypeText(h.cont_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_country_mailing:' + getFieldTypeText(h.cont_country_mailing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_nondislosure:' + getFieldTypeText(h.cont_nondislosure) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_prep_addr_line1:' + getFieldTypeText(h.cont_prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_prep_addr_last_line:' + getFieldTypeText(h.cont_prep_addr_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recordorigin:' + getFieldTypeText(h.recordorigin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_corp_ra_dt_first_seen_cnt
          ,le.populated_corp_ra_dt_last_seen_cnt
          ,le.populated_corp_key_cnt
          ,le.populated_corp_supp_key_cnt
          ,le.populated_corp_vendor_cnt
          ,le.populated_corp_vendor_county_cnt
          ,le.populated_corp_vendor_subcode_cnt
          ,le.populated_corp_state_origin_cnt
          ,le.populated_corp_process_date_cnt
          ,le.populated_corp_orig_sos_charter_nbr_cnt
          ,le.populated_corp_legal_name_cnt
          ,le.populated_corp_ln_name_type_cd_cnt
          ,le.populated_corp_ln_name_type_desc_cnt
          ,le.populated_corp_supp_nbr_cnt
          ,le.populated_corp_name_comment_cnt
          ,le.populated_corp_address1_type_cd_cnt
          ,le.populated_corp_address1_type_desc_cnt
          ,le.populated_corp_address1_line1_cnt
          ,le.populated_corp_address1_line2_cnt
          ,le.populated_corp_address1_line3_cnt
          ,le.populated_corp_address1_effective_date_cnt
          ,le.populated_corp_address2_type_cd_cnt
          ,le.populated_corp_address2_type_desc_cnt
          ,le.populated_corp_address2_line1_cnt
          ,le.populated_corp_address2_line2_cnt
          ,le.populated_corp_address2_line3_cnt
          ,le.populated_corp_address2_effective_date_cnt
          ,le.populated_corp_phone_number_cnt
          ,le.populated_corp_phone_number_type_cd_cnt
          ,le.populated_corp_phone_number_type_desc_cnt
          ,le.populated_corp_fax_nbr_cnt
          ,le.populated_corp_email_address_cnt
          ,le.populated_corp_web_address_cnt
          ,le.populated_corp_filing_reference_nbr_cnt
          ,le.populated_corp_filing_date_cnt
          ,le.populated_corp_filing_cd_cnt
          ,le.populated_corp_filing_desc_cnt
          ,le.populated_corp_status_cd_cnt
          ,le.populated_corp_status_desc_cnt
          ,le.populated_corp_status_date_cnt
          ,le.populated_corp_standing_cnt
          ,le.populated_corp_status_comment_cnt
          ,le.populated_corp_ticker_symbol_cnt
          ,le.populated_corp_stock_exchange_cnt
          ,le.populated_corp_inc_state_cnt
          ,le.populated_corp_inc_county_cnt
          ,le.populated_corp_inc_date_cnt
          ,le.populated_corp_anniversary_month_cnt
          ,le.populated_corp_fed_tax_id_cnt
          ,le.populated_corp_state_tax_id_cnt
          ,le.populated_corp_term_exist_cd_cnt
          ,le.populated_corp_term_exist_exp_cnt
          ,le.populated_corp_term_exist_desc_cnt
          ,le.populated_corp_foreign_domestic_ind_cnt
          ,le.populated_corp_forgn_state_cd_cnt
          ,le.populated_corp_forgn_state_desc_cnt
          ,le.populated_corp_forgn_sos_charter_nbr_cnt
          ,le.populated_corp_forgn_date_cnt
          ,le.populated_corp_forgn_fed_tax_id_cnt
          ,le.populated_corp_forgn_state_tax_id_cnt
          ,le.populated_corp_forgn_term_exist_cd_cnt
          ,le.populated_corp_forgn_term_exist_exp_cnt
          ,le.populated_corp_forgn_term_exist_desc_cnt
          ,le.populated_corp_orig_org_structure_cd_cnt
          ,le.populated_corp_orig_org_structure_desc_cnt
          ,le.populated_corp_for_profit_ind_cnt
          ,le.populated_corp_public_or_private_ind_cnt
          ,le.populated_corp_sic_code_cnt
          ,le.populated_corp_naic_code_cnt
          ,le.populated_corp_orig_bus_type_cd_cnt
          ,le.populated_corp_orig_bus_type_desc_cnt
          ,le.populated_corp_entity_desc_cnt
          ,le.populated_corp_certificate_nbr_cnt
          ,le.populated_corp_internal_nbr_cnt
          ,le.populated_corp_previous_nbr_cnt
          ,le.populated_corp_microfilm_nbr_cnt
          ,le.populated_corp_amendments_filed_cnt
          ,le.populated_corp_acts_cnt
          ,le.populated_corp_partnership_ind_cnt
          ,le.populated_corp_mfg_ind_cnt
          ,le.populated_corp_addl_info_cnt
          ,le.populated_corp_taxes_cnt
          ,le.populated_corp_franchise_taxes_cnt
          ,le.populated_corp_tax_program_cd_cnt
          ,le.populated_corp_tax_program_desc_cnt
          ,le.populated_corp_ra_full_name_cnt
          ,le.populated_corp_ra_fname_cnt
          ,le.populated_corp_ra_mname_cnt
          ,le.populated_corp_ra_lname_cnt
          ,le.populated_corp_ra_title_cd_cnt
          ,le.populated_corp_ra_title_desc_cnt
          ,le.populated_corp_ra_fein_cnt
          ,le.populated_corp_ra_ssn_cnt
          ,le.populated_corp_ra_dob_cnt
          ,le.populated_corp_ra_effective_date_cnt
          ,le.populated_corp_ra_resign_date_cnt
          ,le.populated_corp_ra_no_comp_cnt
          ,le.populated_corp_ra_no_comp_igs_cnt
          ,le.populated_corp_ra_addl_info_cnt
          ,le.populated_corp_ra_address_type_cd_cnt
          ,le.populated_corp_ra_address_type_desc_cnt
          ,le.populated_corp_ra_address_line1_cnt
          ,le.populated_corp_ra_address_line2_cnt
          ,le.populated_corp_ra_address_line3_cnt
          ,le.populated_corp_ra_phone_number_cnt
          ,le.populated_corp_ra_phone_number_type_cd_cnt
          ,le.populated_corp_ra_phone_number_type_desc_cnt
          ,le.populated_corp_ra_fax_nbr_cnt
          ,le.populated_corp_ra_email_address_cnt
          ,le.populated_corp_ra_web_address_cnt
          ,le.populated_corp_prep_addr1_line1_cnt
          ,le.populated_corp_prep_addr1_last_line_cnt
          ,le.populated_corp_prep_addr2_line1_cnt
          ,le.populated_corp_prep_addr2_last_line_cnt
          ,le.populated_ra_prep_addr_line1_cnt
          ,le.populated_ra_prep_addr_last_line_cnt
          ,le.populated_cont_filing_reference_nbr_cnt
          ,le.populated_cont_filing_date_cnt
          ,le.populated_cont_filing_cd_cnt
          ,le.populated_cont_filing_desc_cnt
          ,le.populated_cont_type_cd_cnt
          ,le.populated_cont_type_desc_cnt
          ,le.populated_cont_full_name_cnt
          ,le.populated_cont_fname_cnt
          ,le.populated_cont_mname_cnt
          ,le.populated_cont_lname_cnt
          ,le.populated_cont_title1_desc_cnt
          ,le.populated_cont_title2_desc_cnt
          ,le.populated_cont_title3_desc_cnt
          ,le.populated_cont_title4_desc_cnt
          ,le.populated_cont_title5_desc_cnt
          ,le.populated_cont_fein_cnt
          ,le.populated_cont_ssn_cnt
          ,le.populated_cont_dob_cnt
          ,le.populated_cont_status_cd_cnt
          ,le.populated_cont_status_desc_cnt
          ,le.populated_cont_effective_date_cnt
          ,le.populated_cont_effective_cd_cnt
          ,le.populated_cont_effective_desc_cnt
          ,le.populated_cont_addl_info_cnt
          ,le.populated_cont_address_type_cd_cnt
          ,le.populated_cont_address_type_desc_cnt
          ,le.populated_cont_address_line1_cnt
          ,le.populated_cont_address_line2_cnt
          ,le.populated_cont_address_line3_cnt
          ,le.populated_cont_address_effective_date_cnt
          ,le.populated_cont_address_county_cnt
          ,le.populated_cont_phone_number_cnt
          ,le.populated_cont_phone_number_type_cd_cnt
          ,le.populated_cont_phone_number_type_desc_cnt
          ,le.populated_cont_fax_nbr_cnt
          ,le.populated_cont_email_address_cnt
          ,le.populated_cont_web_address_cnt
          ,le.populated_corp_acres_cnt
          ,le.populated_corp_action_cnt
          ,le.populated_corp_action_date_cnt
          ,le.populated_corp_action_employment_security_approval_date_cnt
          ,le.populated_corp_action_pending_cd_cnt
          ,le.populated_corp_action_pending_desc_cnt
          ,le.populated_corp_action_statement_of_intent_date_cnt
          ,le.populated_corp_action_tax_dept_approval_date_cnt
          ,le.populated_corp_acts2_cnt
          ,le.populated_corp_acts3_cnt
          ,le.populated_corp_additional_principals_cnt
          ,le.populated_corp_address_office_type_cnt
          ,le.populated_corp_agent_commercial_cnt
          ,le.populated_corp_agent_country_cnt
          ,le.populated_corp_agent_county_cnt
          ,le.populated_corp_agent_status_cd_cnt
          ,le.populated_corp_agent_status_desc_cnt
          ,le.populated_corp_agent_id_cnt
          ,le.populated_corp_agent_assign_date_cnt
          ,le.populated_corp_agriculture_flag_cnt
          ,le.populated_corp_authorized_partners_cnt
          ,le.populated_corp_comment_cnt
          ,le.populated_corp_consent_flag_for_protected_name_cnt
          ,le.populated_corp_converted_cnt
          ,le.populated_corp_converted_from_cnt
          ,le.populated_corp_country_of_formation_cnt
          ,le.populated_corp_date_of_organization_meeting_cnt
          ,le.populated_corp_delayed_effective_date_cnt
          ,le.populated_corp_directors_from_to_cnt
          ,le.populated_corp_dissolved_date_cnt
          ,le.populated_corp_farm_exemptions_cnt
          ,le.populated_corp_farm_qual_date_cnt
          ,le.populated_corp_farm_status_cd_cnt
          ,le.populated_corp_farm_status_desc_cnt
          ,le.populated_corp_fiscal_year_month_cnt
          ,le.populated_corp_foreign_fiduciary_capacity_in_state_cnt
          ,le.populated_corp_governing_statute_cnt
          ,le.populated_corp_has_members_cnt
          ,le.populated_corp_has_vested_managers_cnt
          ,le.populated_corp_home_incorporated_county_cnt
          ,le.populated_corp_home_state_name_cnt
          ,le.populated_corp_is_professional_cnt
          ,le.populated_corp_is_non_profit_irs_approved_cnt
          ,le.populated_corp_last_renewal_date_cnt
          ,le.populated_corp_last_renewal_year_cnt
          ,le.populated_corp_license_type_cnt
          ,le.populated_corp_llc_managed_desc_cnt
          ,le.populated_corp_llc_managed_ind_cnt
          ,le.populated_corp_management_desc_cnt
          ,le.populated_corp_management_type_cnt
          ,le.populated_corp_manager_managed_cnt
          ,le.populated_corp_merged_corporation_id_cnt
          ,le.populated_corp_merged_fein_cnt
          ,le.populated_corp_merger_allowed_flag_cnt
          ,le.populated_corp_merger_date_cnt
          ,le.populated_corp_merger_desc_cnt
          ,le.populated_corp_merger_effective_date_cnt
          ,le.populated_corp_merger_id_cnt
          ,le.populated_corp_merger_indicator_cnt
          ,le.populated_corp_merger_name_cnt
          ,le.populated_corp_merger_type_converted_to_cd_cnt
          ,le.populated_corp_merger_type_converted_to_desc_cnt
          ,le.populated_corp_naics_desc_cnt
          ,le.populated_corp_name_effective_date_cnt
          ,le.populated_corp_name_reservation_date_cnt
          ,le.populated_corp_name_reservation_desc_cnt
          ,le.populated_corp_name_reservation_expiration_date_cnt
          ,le.populated_corp_name_reservation_nbr_cnt
          ,le.populated_corp_name_reservation_type_cnt
          ,le.populated_corp_name_status_cd_cnt
          ,le.populated_corp_name_status_date_cnt
          ,le.populated_corp_name_status_desc_cnt
          ,le.populated_corp_non_profit_irs_approved_purpose_cnt
          ,le.populated_corp_non_profit_solicit_donations_cnt
          ,le.populated_corp_nbr_of_amendments_cnt
          ,le.populated_corp_nbr_of_initial_llc_members_cnt
          ,le.populated_corp_nbr_of_partners_cnt
          ,le.populated_corp_operating_agreement_cnt
          ,le.populated_corp_opt_in_llc_act_desc_cnt
          ,le.populated_corp_opt_in_llc_act_ind_cnt
          ,le.populated_corp_organizational_comments_cnt
          ,le.populated_corp_partner_contributions_total_cnt
          ,le.populated_corp_partner_terms_cnt
          ,le.populated_corp_percentage_voters_required_to_approve_amendments_cnt
          ,le.populated_corp_profession_cnt
          ,le.populated_corp_province_cnt
          ,le.populated_corp_public_mutual_corporation_cnt
          ,le.populated_corp_purpose_cnt
          ,le.populated_corp_ra_required_flag_cnt
          ,le.populated_corp_registered_counties_cnt
          ,le.populated_corp_regulated_ind_cnt
          ,le.populated_corp_renewal_date_cnt
          ,le.populated_corp_standing_other_cnt
          ,le.populated_corp_survivor_corporation_id_cnt
          ,le.populated_corp_tax_base_cnt
          ,le.populated_corp_tax_standing_cnt
          ,le.populated_corp_termination_cd_cnt
          ,le.populated_corp_termination_desc_cnt
          ,le.populated_corp_termination_date_cnt
          ,le.populated_corp_trademark_business_mark_type_cnt
          ,le.populated_corp_trademark_cancelled_date_cnt
          ,le.populated_corp_trademark_class_desc1_cnt
          ,le.populated_corp_trademark_class_desc2_cnt
          ,le.populated_corp_trademark_class_desc3_cnt
          ,le.populated_corp_trademark_class_desc4_cnt
          ,le.populated_corp_trademark_class_desc5_cnt
          ,le.populated_corp_trademark_class_desc6_cnt
          ,le.populated_corp_trademark_classification_nbr_cnt
          ,le.populated_corp_trademark_disclaimer1_cnt
          ,le.populated_corp_trademark_disclaimer2_cnt
          ,le.populated_corp_trademark_expiration_date_cnt
          ,le.populated_corp_trademark_filing_date_cnt
          ,le.populated_corp_trademark_first_use_date_cnt
          ,le.populated_corp_trademark_first_use_date_in_state_cnt
          ,le.populated_corp_trademark_keywords_cnt
          ,le.populated_corp_trademark_logo_cnt
          ,le.populated_corp_trademark_name_expiration_date_cnt
          ,le.populated_corp_trademark_nbr_cnt
          ,le.populated_corp_trademark_renewal_date_cnt
          ,le.populated_corp_trademark_status_cnt
          ,le.populated_corp_trademark_used_1_cnt
          ,le.populated_corp_trademark_used_2_cnt
          ,le.populated_corp_trademark_used_3_cnt
          ,le.populated_cont_owner_percentage_cnt
          ,le.populated_cont_country_cnt
          ,le.populated_cont_country_mailing_cnt
          ,le.populated_cont_nondislosure_cnt
          ,le.populated_cont_prep_addr_line1_cnt
          ,le.populated_cont_prep_addr_last_line_cnt
          ,le.populated_recordorigin_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_corp_ra_dt_first_seen_pcnt
          ,le.populated_corp_ra_dt_last_seen_pcnt
          ,le.populated_corp_key_pcnt
          ,le.populated_corp_supp_key_pcnt
          ,le.populated_corp_vendor_pcnt
          ,le.populated_corp_vendor_county_pcnt
          ,le.populated_corp_vendor_subcode_pcnt
          ,le.populated_corp_state_origin_pcnt
          ,le.populated_corp_process_date_pcnt
          ,le.populated_corp_orig_sos_charter_nbr_pcnt
          ,le.populated_corp_legal_name_pcnt
          ,le.populated_corp_ln_name_type_cd_pcnt
          ,le.populated_corp_ln_name_type_desc_pcnt
          ,le.populated_corp_supp_nbr_pcnt
          ,le.populated_corp_name_comment_pcnt
          ,le.populated_corp_address1_type_cd_pcnt
          ,le.populated_corp_address1_type_desc_pcnt
          ,le.populated_corp_address1_line1_pcnt
          ,le.populated_corp_address1_line2_pcnt
          ,le.populated_corp_address1_line3_pcnt
          ,le.populated_corp_address1_effective_date_pcnt
          ,le.populated_corp_address2_type_cd_pcnt
          ,le.populated_corp_address2_type_desc_pcnt
          ,le.populated_corp_address2_line1_pcnt
          ,le.populated_corp_address2_line2_pcnt
          ,le.populated_corp_address2_line3_pcnt
          ,le.populated_corp_address2_effective_date_pcnt
          ,le.populated_corp_phone_number_pcnt
          ,le.populated_corp_phone_number_type_cd_pcnt
          ,le.populated_corp_phone_number_type_desc_pcnt
          ,le.populated_corp_fax_nbr_pcnt
          ,le.populated_corp_email_address_pcnt
          ,le.populated_corp_web_address_pcnt
          ,le.populated_corp_filing_reference_nbr_pcnt
          ,le.populated_corp_filing_date_pcnt
          ,le.populated_corp_filing_cd_pcnt
          ,le.populated_corp_filing_desc_pcnt
          ,le.populated_corp_status_cd_pcnt
          ,le.populated_corp_status_desc_pcnt
          ,le.populated_corp_status_date_pcnt
          ,le.populated_corp_standing_pcnt
          ,le.populated_corp_status_comment_pcnt
          ,le.populated_corp_ticker_symbol_pcnt
          ,le.populated_corp_stock_exchange_pcnt
          ,le.populated_corp_inc_state_pcnt
          ,le.populated_corp_inc_county_pcnt
          ,le.populated_corp_inc_date_pcnt
          ,le.populated_corp_anniversary_month_pcnt
          ,le.populated_corp_fed_tax_id_pcnt
          ,le.populated_corp_state_tax_id_pcnt
          ,le.populated_corp_term_exist_cd_pcnt
          ,le.populated_corp_term_exist_exp_pcnt
          ,le.populated_corp_term_exist_desc_pcnt
          ,le.populated_corp_foreign_domestic_ind_pcnt
          ,le.populated_corp_forgn_state_cd_pcnt
          ,le.populated_corp_forgn_state_desc_pcnt
          ,le.populated_corp_forgn_sos_charter_nbr_pcnt
          ,le.populated_corp_forgn_date_pcnt
          ,le.populated_corp_forgn_fed_tax_id_pcnt
          ,le.populated_corp_forgn_state_tax_id_pcnt
          ,le.populated_corp_forgn_term_exist_cd_pcnt
          ,le.populated_corp_forgn_term_exist_exp_pcnt
          ,le.populated_corp_forgn_term_exist_desc_pcnt
          ,le.populated_corp_orig_org_structure_cd_pcnt
          ,le.populated_corp_orig_org_structure_desc_pcnt
          ,le.populated_corp_for_profit_ind_pcnt
          ,le.populated_corp_public_or_private_ind_pcnt
          ,le.populated_corp_sic_code_pcnt
          ,le.populated_corp_naic_code_pcnt
          ,le.populated_corp_orig_bus_type_cd_pcnt
          ,le.populated_corp_orig_bus_type_desc_pcnt
          ,le.populated_corp_entity_desc_pcnt
          ,le.populated_corp_certificate_nbr_pcnt
          ,le.populated_corp_internal_nbr_pcnt
          ,le.populated_corp_previous_nbr_pcnt
          ,le.populated_corp_microfilm_nbr_pcnt
          ,le.populated_corp_amendments_filed_pcnt
          ,le.populated_corp_acts_pcnt
          ,le.populated_corp_partnership_ind_pcnt
          ,le.populated_corp_mfg_ind_pcnt
          ,le.populated_corp_addl_info_pcnt
          ,le.populated_corp_taxes_pcnt
          ,le.populated_corp_franchise_taxes_pcnt
          ,le.populated_corp_tax_program_cd_pcnt
          ,le.populated_corp_tax_program_desc_pcnt
          ,le.populated_corp_ra_full_name_pcnt
          ,le.populated_corp_ra_fname_pcnt
          ,le.populated_corp_ra_mname_pcnt
          ,le.populated_corp_ra_lname_pcnt
          ,le.populated_corp_ra_title_cd_pcnt
          ,le.populated_corp_ra_title_desc_pcnt
          ,le.populated_corp_ra_fein_pcnt
          ,le.populated_corp_ra_ssn_pcnt
          ,le.populated_corp_ra_dob_pcnt
          ,le.populated_corp_ra_effective_date_pcnt
          ,le.populated_corp_ra_resign_date_pcnt
          ,le.populated_corp_ra_no_comp_pcnt
          ,le.populated_corp_ra_no_comp_igs_pcnt
          ,le.populated_corp_ra_addl_info_pcnt
          ,le.populated_corp_ra_address_type_cd_pcnt
          ,le.populated_corp_ra_address_type_desc_pcnt
          ,le.populated_corp_ra_address_line1_pcnt
          ,le.populated_corp_ra_address_line2_pcnt
          ,le.populated_corp_ra_address_line3_pcnt
          ,le.populated_corp_ra_phone_number_pcnt
          ,le.populated_corp_ra_phone_number_type_cd_pcnt
          ,le.populated_corp_ra_phone_number_type_desc_pcnt
          ,le.populated_corp_ra_fax_nbr_pcnt
          ,le.populated_corp_ra_email_address_pcnt
          ,le.populated_corp_ra_web_address_pcnt
          ,le.populated_corp_prep_addr1_line1_pcnt
          ,le.populated_corp_prep_addr1_last_line_pcnt
          ,le.populated_corp_prep_addr2_line1_pcnt
          ,le.populated_corp_prep_addr2_last_line_pcnt
          ,le.populated_ra_prep_addr_line1_pcnt
          ,le.populated_ra_prep_addr_last_line_pcnt
          ,le.populated_cont_filing_reference_nbr_pcnt
          ,le.populated_cont_filing_date_pcnt
          ,le.populated_cont_filing_cd_pcnt
          ,le.populated_cont_filing_desc_pcnt
          ,le.populated_cont_type_cd_pcnt
          ,le.populated_cont_type_desc_pcnt
          ,le.populated_cont_full_name_pcnt
          ,le.populated_cont_fname_pcnt
          ,le.populated_cont_mname_pcnt
          ,le.populated_cont_lname_pcnt
          ,le.populated_cont_title1_desc_pcnt
          ,le.populated_cont_title2_desc_pcnt
          ,le.populated_cont_title3_desc_pcnt
          ,le.populated_cont_title4_desc_pcnt
          ,le.populated_cont_title5_desc_pcnt
          ,le.populated_cont_fein_pcnt
          ,le.populated_cont_ssn_pcnt
          ,le.populated_cont_dob_pcnt
          ,le.populated_cont_status_cd_pcnt
          ,le.populated_cont_status_desc_pcnt
          ,le.populated_cont_effective_date_pcnt
          ,le.populated_cont_effective_cd_pcnt
          ,le.populated_cont_effective_desc_pcnt
          ,le.populated_cont_addl_info_pcnt
          ,le.populated_cont_address_type_cd_pcnt
          ,le.populated_cont_address_type_desc_pcnt
          ,le.populated_cont_address_line1_pcnt
          ,le.populated_cont_address_line2_pcnt
          ,le.populated_cont_address_line3_pcnt
          ,le.populated_cont_address_effective_date_pcnt
          ,le.populated_cont_address_county_pcnt
          ,le.populated_cont_phone_number_pcnt
          ,le.populated_cont_phone_number_type_cd_pcnt
          ,le.populated_cont_phone_number_type_desc_pcnt
          ,le.populated_cont_fax_nbr_pcnt
          ,le.populated_cont_email_address_pcnt
          ,le.populated_cont_web_address_pcnt
          ,le.populated_corp_acres_pcnt
          ,le.populated_corp_action_pcnt
          ,le.populated_corp_action_date_pcnt
          ,le.populated_corp_action_employment_security_approval_date_pcnt
          ,le.populated_corp_action_pending_cd_pcnt
          ,le.populated_corp_action_pending_desc_pcnt
          ,le.populated_corp_action_statement_of_intent_date_pcnt
          ,le.populated_corp_action_tax_dept_approval_date_pcnt
          ,le.populated_corp_acts2_pcnt
          ,le.populated_corp_acts3_pcnt
          ,le.populated_corp_additional_principals_pcnt
          ,le.populated_corp_address_office_type_pcnt
          ,le.populated_corp_agent_commercial_pcnt
          ,le.populated_corp_agent_country_pcnt
          ,le.populated_corp_agent_county_pcnt
          ,le.populated_corp_agent_status_cd_pcnt
          ,le.populated_corp_agent_status_desc_pcnt
          ,le.populated_corp_agent_id_pcnt
          ,le.populated_corp_agent_assign_date_pcnt
          ,le.populated_corp_agriculture_flag_pcnt
          ,le.populated_corp_authorized_partners_pcnt
          ,le.populated_corp_comment_pcnt
          ,le.populated_corp_consent_flag_for_protected_name_pcnt
          ,le.populated_corp_converted_pcnt
          ,le.populated_corp_converted_from_pcnt
          ,le.populated_corp_country_of_formation_pcnt
          ,le.populated_corp_date_of_organization_meeting_pcnt
          ,le.populated_corp_delayed_effective_date_pcnt
          ,le.populated_corp_directors_from_to_pcnt
          ,le.populated_corp_dissolved_date_pcnt
          ,le.populated_corp_farm_exemptions_pcnt
          ,le.populated_corp_farm_qual_date_pcnt
          ,le.populated_corp_farm_status_cd_pcnt
          ,le.populated_corp_farm_status_desc_pcnt
          ,le.populated_corp_fiscal_year_month_pcnt
          ,le.populated_corp_foreign_fiduciary_capacity_in_state_pcnt
          ,le.populated_corp_governing_statute_pcnt
          ,le.populated_corp_has_members_pcnt
          ,le.populated_corp_has_vested_managers_pcnt
          ,le.populated_corp_home_incorporated_county_pcnt
          ,le.populated_corp_home_state_name_pcnt
          ,le.populated_corp_is_professional_pcnt
          ,le.populated_corp_is_non_profit_irs_approved_pcnt
          ,le.populated_corp_last_renewal_date_pcnt
          ,le.populated_corp_last_renewal_year_pcnt
          ,le.populated_corp_license_type_pcnt
          ,le.populated_corp_llc_managed_desc_pcnt
          ,le.populated_corp_llc_managed_ind_pcnt
          ,le.populated_corp_management_desc_pcnt
          ,le.populated_corp_management_type_pcnt
          ,le.populated_corp_manager_managed_pcnt
          ,le.populated_corp_merged_corporation_id_pcnt
          ,le.populated_corp_merged_fein_pcnt
          ,le.populated_corp_merger_allowed_flag_pcnt
          ,le.populated_corp_merger_date_pcnt
          ,le.populated_corp_merger_desc_pcnt
          ,le.populated_corp_merger_effective_date_pcnt
          ,le.populated_corp_merger_id_pcnt
          ,le.populated_corp_merger_indicator_pcnt
          ,le.populated_corp_merger_name_pcnt
          ,le.populated_corp_merger_type_converted_to_cd_pcnt
          ,le.populated_corp_merger_type_converted_to_desc_pcnt
          ,le.populated_corp_naics_desc_pcnt
          ,le.populated_corp_name_effective_date_pcnt
          ,le.populated_corp_name_reservation_date_pcnt
          ,le.populated_corp_name_reservation_desc_pcnt
          ,le.populated_corp_name_reservation_expiration_date_pcnt
          ,le.populated_corp_name_reservation_nbr_pcnt
          ,le.populated_corp_name_reservation_type_pcnt
          ,le.populated_corp_name_status_cd_pcnt
          ,le.populated_corp_name_status_date_pcnt
          ,le.populated_corp_name_status_desc_pcnt
          ,le.populated_corp_non_profit_irs_approved_purpose_pcnt
          ,le.populated_corp_non_profit_solicit_donations_pcnt
          ,le.populated_corp_nbr_of_amendments_pcnt
          ,le.populated_corp_nbr_of_initial_llc_members_pcnt
          ,le.populated_corp_nbr_of_partners_pcnt
          ,le.populated_corp_operating_agreement_pcnt
          ,le.populated_corp_opt_in_llc_act_desc_pcnt
          ,le.populated_corp_opt_in_llc_act_ind_pcnt
          ,le.populated_corp_organizational_comments_pcnt
          ,le.populated_corp_partner_contributions_total_pcnt
          ,le.populated_corp_partner_terms_pcnt
          ,le.populated_corp_percentage_voters_required_to_approve_amendments_pcnt
          ,le.populated_corp_profession_pcnt
          ,le.populated_corp_province_pcnt
          ,le.populated_corp_public_mutual_corporation_pcnt
          ,le.populated_corp_purpose_pcnt
          ,le.populated_corp_ra_required_flag_pcnt
          ,le.populated_corp_registered_counties_pcnt
          ,le.populated_corp_regulated_ind_pcnt
          ,le.populated_corp_renewal_date_pcnt
          ,le.populated_corp_standing_other_pcnt
          ,le.populated_corp_survivor_corporation_id_pcnt
          ,le.populated_corp_tax_base_pcnt
          ,le.populated_corp_tax_standing_pcnt
          ,le.populated_corp_termination_cd_pcnt
          ,le.populated_corp_termination_desc_pcnt
          ,le.populated_corp_termination_date_pcnt
          ,le.populated_corp_trademark_business_mark_type_pcnt
          ,le.populated_corp_trademark_cancelled_date_pcnt
          ,le.populated_corp_trademark_class_desc1_pcnt
          ,le.populated_corp_trademark_class_desc2_pcnt
          ,le.populated_corp_trademark_class_desc3_pcnt
          ,le.populated_corp_trademark_class_desc4_pcnt
          ,le.populated_corp_trademark_class_desc5_pcnt
          ,le.populated_corp_trademark_class_desc6_pcnt
          ,le.populated_corp_trademark_classification_nbr_pcnt
          ,le.populated_corp_trademark_disclaimer1_pcnt
          ,le.populated_corp_trademark_disclaimer2_pcnt
          ,le.populated_corp_trademark_expiration_date_pcnt
          ,le.populated_corp_trademark_filing_date_pcnt
          ,le.populated_corp_trademark_first_use_date_pcnt
          ,le.populated_corp_trademark_first_use_date_in_state_pcnt
          ,le.populated_corp_trademark_keywords_pcnt
          ,le.populated_corp_trademark_logo_pcnt
          ,le.populated_corp_trademark_name_expiration_date_pcnt
          ,le.populated_corp_trademark_nbr_pcnt
          ,le.populated_corp_trademark_renewal_date_pcnt
          ,le.populated_corp_trademark_status_pcnt
          ,le.populated_corp_trademark_used_1_pcnt
          ,le.populated_corp_trademark_used_2_pcnt
          ,le.populated_corp_trademark_used_3_pcnt
          ,le.populated_cont_owner_percentage_pcnt
          ,le.populated_cont_country_pcnt
          ,le.populated_cont_country_mailing_pcnt
          ,le.populated_cont_nondislosure_pcnt
          ,le.populated_cont_prep_addr_line1_pcnt
          ,le.populated_cont_prep_addr_last_line_pcnt
          ,le.populated_recordorigin_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,287,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_NM));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),287,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_NM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Corp2_Mapping_NM_Main, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
