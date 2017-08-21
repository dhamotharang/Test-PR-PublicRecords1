IMPORT ut,SALT34,corp2_mapping;
IMPORT Scrubs,Scrubs_Corp2_Mapping_NY_Main; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(corp2_mapping.LayoutsCommon.Main)
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
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_forgn_date_Invalid;
    UNSIGNED1 corp_filing_date_Invalid;
    UNSIGNED1 corp_inc_date_Invalid;
    UNSIGNED1 corp_term_exist_exp_Invalid;
    UNSIGNED1 corp_merger_date_Invalid;
    UNSIGNED1 corp_merger_effective_date_Invalid;
    UNSIGNED1 corp_name_status_date_Invalid;
    UNSIGNED1 corp_orig_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 corp_foreign_domestic_ind_Invalid;
    UNSIGNED1 corp_for_profit_ind_Invalid;
    UNSIGNED1 corp_ln_name_type_cd_Invalid;
    UNSIGNED1 corp_ln_name_type_desc_Invalid;
    UNSIGNED1 corp_status_desc_Invalid;
    UNSIGNED1 corp_forgn_state_desc_Invalid;
    UNSIGNED1 corp_merger_type_converted_to_cd_Invalid;
    UNSIGNED1 InternalField1_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(corp2_mapping.LayoutsCommon.Main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(corp2_mapping.LayoutsCommon.Main) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen);
    SELF.corp_ra_dt_first_seen_Invalid := Fields.InValid_corp_ra_dt_first_seen((SALT34.StrType)le.corp_ra_dt_first_seen);
    SELF.corp_ra_dt_last_seen_Invalid := Fields.InValid_corp_ra_dt_last_seen((SALT34.StrType)le.corp_ra_dt_last_seen);
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT34.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT34.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT34.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT34.StrType)le.corp_process_date);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT34.StrType)le.corp_inc_state);
    SELF.corp_forgn_date_Invalid := Fields.InValid_corp_forgn_date((SALT34.StrType)le.corp_forgn_date);
    SELF.corp_filing_date_Invalid := Fields.InValid_corp_filing_date((SALT34.StrType)le.corp_filing_date);
    SELF.corp_inc_date_Invalid := Fields.InValid_corp_inc_date((SALT34.StrType)le.corp_inc_date);
    SELF.corp_term_exist_exp_Invalid := Fields.InValid_corp_term_exist_exp((SALT34.StrType)le.corp_term_exist_exp);
    SELF.corp_merger_date_Invalid := Fields.InValid_corp_merger_date((SALT34.StrType)le.corp_merger_date);
    SELF.corp_merger_effective_date_Invalid := Fields.InValid_corp_merger_effective_date((SALT34.StrType)le.corp_merger_effective_date);
    SELF.corp_name_status_date_Invalid := Fields.InValid_corp_name_status_date((SALT34.StrType)le.corp_name_status_date);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT34.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT34.StrType)le.corp_legal_name);
    SELF.corp_foreign_domestic_ind_Invalid := Fields.InValid_corp_foreign_domestic_ind((SALT34.StrType)le.corp_foreign_domestic_ind);
    SELF.corp_for_profit_ind_Invalid := Fields.InValid_corp_for_profit_ind((SALT34.StrType)le.corp_for_profit_ind);
    SELF.corp_ln_name_type_cd_Invalid := Fields.InValid_corp_ln_name_type_cd((SALT34.StrType)le.corp_ln_name_type_cd);
    SELF.corp_ln_name_type_desc_Invalid := Fields.InValid_corp_ln_name_type_desc((SALT34.StrType)le.corp_ln_name_type_desc);
    SELF.corp_status_desc_Invalid := Fields.InValid_corp_status_desc((SALT34.StrType)le.corp_status_desc);
    SELF.corp_forgn_state_desc_Invalid := Fields.InValid_corp_forgn_state_desc((SALT34.StrType)le.corp_forgn_state_desc);
    SELF.corp_merger_type_converted_to_cd_Invalid := Fields.InValid_corp_merger_type_converted_to_cd((SALT34.StrType)le.corp_merger_type_converted_to_cd);
    SELF.InternalField1_Invalid := Fields.InValid_InternalField1((SALT34.StrType)le.InternalField1,(SALT34.StrType)le.corp_ln_name_type_cd);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),corp2_mapping.LayoutsCommon.Main);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_vendor_first_reported_Invalid << 0 ) + ( le.dt_vendor_last_reported_Invalid << 2 ) + ( le.dt_first_seen_Invalid << 4 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.corp_ra_dt_first_seen_Invalid << 8 ) + ( le.corp_ra_dt_last_seen_Invalid << 10 ) + ( le.corp_key_Invalid << 12 ) + ( le.corp_vendor_Invalid << 14 ) + ( le.corp_state_origin_Invalid << 15 ) + ( le.corp_process_date_Invalid << 16 ) + ( le.corp_inc_state_Invalid << 18 ) + ( le.corp_forgn_date_Invalid << 19 ) + ( le.corp_filing_date_Invalid << 21 ) + ( le.corp_inc_date_Invalid << 23 ) + ( le.corp_term_exist_exp_Invalid << 25 ) + ( le.corp_merger_date_Invalid << 27 ) + ( le.corp_merger_effective_date_Invalid << 29 ) + ( le.corp_name_status_date_Invalid << 31 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 33 ) + ( le.corp_legal_name_Invalid << 35 ) + ( le.corp_foreign_domestic_ind_Invalid << 36 ) + ( le.corp_for_profit_ind_Invalid << 37 ) + ( le.corp_ln_name_type_cd_Invalid << 38 ) + ( le.corp_ln_name_type_desc_Invalid << 39 ) + ( le.corp_status_desc_Invalid << 40 ) + ( le.corp_forgn_state_desc_Invalid << 41 ) + ( le.corp_merger_type_converted_to_cd_Invalid << 42 ) + ( le.InternalField1_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,corp2_mapping.LayoutsCommon.Main);
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
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.corp_forgn_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.corp_filing_date_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.corp_inc_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.corp_term_exist_exp_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.corp_merger_date_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.corp_merger_effective_date_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.corp_name_status_date_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.corp_orig_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.corp_foreign_domestic_ind_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.corp_for_profit_ind_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.corp_ln_name_type_cd_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.corp_ln_name_type_desc_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.corp_status_desc_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.corp_forgn_state_desc_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.corp_merger_type_converted_to_cd_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.InternalField1_Invalid := (le.ScrubsBits1 >> 43) & 1;
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
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    corp_ra_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=1);
    corp_ra_dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=2);
    corp_ra_dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=3);
    corp_ra_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid>0);
    corp_ra_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=1);
    corp_ra_dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=2);
    corp_ra_dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=3);
    corp_ra_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid>0);
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=3);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_inc_state_ENUM_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_forgn_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=1);
    corp_forgn_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=2);
    corp_forgn_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=3);
    corp_forgn_date_Total_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid>0);
    corp_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid=1);
    corp_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid=2);
    corp_filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid=3);
    corp_filing_date_Total_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid>0);
    corp_inc_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=1);
    corp_inc_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=2);
    corp_inc_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=3);
    corp_inc_date_Total_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid>0);
    corp_term_exist_exp_ALLOW_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid=1);
    corp_term_exist_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid=2);
    corp_term_exist_exp_LENGTH_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid=3);
    corp_term_exist_exp_Total_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid>0);
    corp_merger_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid=1);
    corp_merger_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid=2);
    corp_merger_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid=3);
    corp_merger_date_Total_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid>0);
    corp_merger_effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid=1);
    corp_merger_effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid=2);
    corp_merger_effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid=3);
    corp_merger_effective_date_Total_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid>0);
    corp_name_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid=1);
    corp_name_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid=2);
    corp_name_status_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid=3);
    corp_name_status_date_Total_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid>0);
    corp_orig_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=1);
    corp_orig_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=2);
    corp_orig_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid>0);
    corp_legal_name_LENGTH_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    corp_foreign_domestic_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_foreign_domestic_ind_Invalid=1);
    corp_for_profit_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_for_profit_ind_Invalid=1);
    corp_ln_name_type_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_cd_Invalid=1);
    corp_ln_name_type_desc_ENUM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_desc_Invalid=1);
    corp_status_desc_ENUM_ErrorCount := COUNT(GROUP,h.corp_status_desc_Invalid=1);
    corp_forgn_state_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_state_desc_Invalid=1);
    corp_merger_type_converted_to_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_merger_type_converted_to_cd_Invalid=1);
    InternalField1_CUSTOM_ErrorCount := COUNT(GROUP,h.InternalField1_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.corp_ra_dt_first_seen_Invalid,le.corp_ra_dt_last_seen_Invalid,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_inc_state_Invalid,le.corp_forgn_date_Invalid,le.corp_filing_date_Invalid,le.corp_inc_date_Invalid,le.corp_term_exist_exp_Invalid,le.corp_merger_date_Invalid,le.corp_merger_effective_date_Invalid,le.corp_name_status_date_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_legal_name_Invalid,le.corp_foreign_domestic_ind_Invalid,le.corp_for_profit_ind_Invalid,le.corp_ln_name_type_cd_Invalid,le.corp_ln_name_type_desc_Invalid,le.corp_status_desc_Invalid,le.corp_forgn_state_desc_Invalid,le.corp_merger_type_converted_to_cd_Invalid,le.InternalField1_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_first_seen(le.corp_ra_dt_first_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_last_seen(le.corp_ra_dt_last_seen_Invalid),Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_forgn_date(le.corp_forgn_date_Invalid),Fields.InvalidMessage_corp_filing_date(le.corp_filing_date_Invalid),Fields.InvalidMessage_corp_inc_date(le.corp_inc_date_Invalid),Fields.InvalidMessage_corp_term_exist_exp(le.corp_term_exist_exp_Invalid),Fields.InvalidMessage_corp_merger_date(le.corp_merger_date_Invalid),Fields.InvalidMessage_corp_merger_effective_date(le.corp_merger_effective_date_Invalid),Fields.InvalidMessage_corp_name_status_date(le.corp_name_status_date_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind_Invalid),Fields.InvalidMessage_corp_for_profit_ind(le.corp_for_profit_ind_Invalid),Fields.InvalidMessage_corp_ln_name_type_cd(le.corp_ln_name_type_cd_Invalid),Fields.InvalidMessage_corp_ln_name_type_desc(le.corp_ln_name_type_desc_Invalid),Fields.InvalidMessage_corp_status_desc(le.corp_status_desc_Invalid),Fields.InvalidMessage_corp_forgn_state_desc(le.corp_forgn_state_desc_Invalid),Fields.InvalidMessage_corp_merger_type_converted_to_cd(le.corp_merger_type_converted_to_cd_Invalid),Fields.InvalidMessage_InternalField1(le.InternalField1_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_forgn_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_filing_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_inc_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_term_exist_exp_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_merger_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_merger_effective_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_name_status_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_orig_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_foreign_domestic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_for_profit_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_ln_name_type_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_ln_name_type_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_status_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_forgn_state_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_merger_type_converted_to_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.InternalField1_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_inc_state','corp_forgn_date','corp_filing_date','corp_inc_date','corp_term_exist_exp','corp_merger_date','corp_merger_effective_date','corp_name_status_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_foreign_domestic_ind','corp_for_profit_ind','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_status_desc','corp_forgn_state_desc','corp_merger_type_converted_to_cd','InternalField1','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_state_origin','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_charter','invalid_mandatory','invalid_forgn_dom_code','invalid_for_profit_ind','invalid_name_type_cd','invalid_name_type_desc','invalid_corp_status_desc','invalid_alphablank','invalid_corp_merger_type_converted_to_cd','invalid_InternalField1','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.dt_vendor_first_reported,(SALT34.StrType)le.dt_vendor_last_reported,(SALT34.StrType)le.dt_first_seen,(SALT34.StrType)le.dt_last_seen,(SALT34.StrType)le.corp_ra_dt_first_seen,(SALT34.StrType)le.corp_ra_dt_last_seen,(SALT34.StrType)le.corp_key,(SALT34.StrType)le.corp_vendor,(SALT34.StrType)le.corp_state_origin,(SALT34.StrType)le.corp_process_date,(SALT34.StrType)le.corp_inc_state,(SALT34.StrType)le.corp_forgn_date,(SALT34.StrType)le.corp_filing_date,(SALT34.StrType)le.corp_inc_date,(SALT34.StrType)le.corp_term_exist_exp,(SALT34.StrType)le.corp_merger_date,(SALT34.StrType)le.corp_merger_effective_date,(SALT34.StrType)le.corp_name_status_date,(SALT34.StrType)le.corp_orig_sos_charter_nbr,(SALT34.StrType)le.corp_legal_name,(SALT34.StrType)le.corp_foreign_domestic_ind,(SALT34.StrType)le.corp_for_profit_ind,(SALT34.StrType)le.corp_ln_name_type_cd,(SALT34.StrType)le.corp_ln_name_type_desc,(SALT34.StrType)le.corp_status_desc,(SALT34.StrType)le.corp_forgn_state_desc,(SALT34.StrType)le.corp_merger_type_converted_to_cd,(SALT34.StrType)le.InternalField1,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_vendor_first_reported:invalid_date:ALLOW','dt_vendor_first_reported:invalid_date:CUSTOM','dt_vendor_first_reported:invalid_date:LENGTH'
          ,'dt_vendor_last_reported:invalid_date:ALLOW','dt_vendor_last_reported:invalid_date:CUSTOM','dt_vendor_last_reported:invalid_date:LENGTH'
          ,'dt_first_seen:invalid_date:ALLOW','dt_first_seen:invalid_date:CUSTOM','dt_first_seen:invalid_date:LENGTH'
          ,'dt_last_seen:invalid_date:ALLOW','dt_last_seen:invalid_date:CUSTOM','dt_last_seen:invalid_date:LENGTH'
          ,'corp_ra_dt_first_seen:invalid_date:ALLOW','corp_ra_dt_first_seen:invalid_date:CUSTOM','corp_ra_dt_first_seen:invalid_date:LENGTH'
          ,'corp_ra_dt_last_seen:invalid_date:ALLOW','corp_ra_dt_last_seen:invalid_date:CUSTOM','corp_ra_dt_last_seen:invalid_date:LENGTH'
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM','corp_process_date:invalid_date:LENGTH'
          ,'corp_inc_state:invalid_state_origin:ENUM'
          ,'corp_forgn_date:invalid_optional_date:ALLOW','corp_forgn_date:invalid_optional_date:CUSTOM','corp_forgn_date:invalid_optional_date:LENGTH'
          ,'corp_filing_date:invalid_optional_date:ALLOW','corp_filing_date:invalid_optional_date:CUSTOM','corp_filing_date:invalid_optional_date:LENGTH'
          ,'corp_inc_date:invalid_optional_date:ALLOW','corp_inc_date:invalid_optional_date:CUSTOM','corp_inc_date:invalid_optional_date:LENGTH'
          ,'corp_term_exist_exp:invalid_optional_date:ALLOW','corp_term_exist_exp:invalid_optional_date:CUSTOM','corp_term_exist_exp:invalid_optional_date:LENGTH'
          ,'corp_merger_date:invalid_optional_date:ALLOW','corp_merger_date:invalid_optional_date:CUSTOM','corp_merger_date:invalid_optional_date:LENGTH'
          ,'corp_merger_effective_date:invalid_optional_date:ALLOW','corp_merger_effective_date:invalid_optional_date:CUSTOM','corp_merger_effective_date:invalid_optional_date:LENGTH'
          ,'corp_name_status_date:invalid_optional_date:ALLOW','corp_name_status_date:invalid_optional_date:CUSTOM','corp_name_status_date:invalid_optional_date:LENGTH'
          ,'corp_orig_sos_charter_nbr:invalid_charter:ALLOW','corp_orig_sos_charter_nbr:invalid_charter:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'corp_foreign_domestic_ind:invalid_forgn_dom_code:ENUM'
          ,'corp_for_profit_ind:invalid_for_profit_ind:ENUM'
          ,'corp_ln_name_type_cd:invalid_name_type_cd:ENUM'
          ,'corp_ln_name_type_desc:invalid_name_type_desc:ENUM'
          ,'corp_status_desc:invalid_corp_status_desc:ENUM'
          ,'corp_forgn_state_desc:invalid_alphablank:ALLOW'
          ,'corp_merger_type_converted_to_cd:invalid_corp_merger_type_converted_to_cd:ENUM'
          ,'InternalField1:invalid_InternalField1:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_ra_dt_first_seen(1),Fields.InvalidMessage_corp_ra_dt_first_seen(2),Fields.InvalidMessage_corp_ra_dt_first_seen(3)
          ,Fields.InvalidMessage_corp_ra_dt_last_seen(1),Fields.InvalidMessage_corp_ra_dt_last_seen(2),Fields.InvalidMessage_corp_ra_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2),Fields.InvalidMessage_corp_process_date(3)
          ,Fields.InvalidMessage_corp_inc_state(1)
          ,Fields.InvalidMessage_corp_forgn_date(1),Fields.InvalidMessage_corp_forgn_date(2),Fields.InvalidMessage_corp_forgn_date(3)
          ,Fields.InvalidMessage_corp_filing_date(1),Fields.InvalidMessage_corp_filing_date(2),Fields.InvalidMessage_corp_filing_date(3)
          ,Fields.InvalidMessage_corp_inc_date(1),Fields.InvalidMessage_corp_inc_date(2),Fields.InvalidMessage_corp_inc_date(3)
          ,Fields.InvalidMessage_corp_term_exist_exp(1),Fields.InvalidMessage_corp_term_exist_exp(2),Fields.InvalidMessage_corp_term_exist_exp(3)
          ,Fields.InvalidMessage_corp_merger_date(1),Fields.InvalidMessage_corp_merger_date(2),Fields.InvalidMessage_corp_merger_date(3)
          ,Fields.InvalidMessage_corp_merger_effective_date(1),Fields.InvalidMessage_corp_merger_effective_date(2),Fields.InvalidMessage_corp_merger_effective_date(3)
          ,Fields.InvalidMessage_corp_name_status_date(1),Fields.InvalidMessage_corp_name_status_date(2),Fields.InvalidMessage_corp_name_status_date(3)
          ,Fields.InvalidMessage_corp_orig_sos_charter_nbr(1),Fields.InvalidMessage_corp_orig_sos_charter_nbr(2)
          ,Fields.InvalidMessage_corp_legal_name(1)
          ,Fields.InvalidMessage_corp_foreign_domestic_ind(1)
          ,Fields.InvalidMessage_corp_for_profit_ind(1)
          ,Fields.InvalidMessage_corp_ln_name_type_cd(1)
          ,Fields.InvalidMessage_corp_ln_name_type_desc(1)
          ,Fields.InvalidMessage_corp_status_desc(1)
          ,Fields.InvalidMessage_corp_forgn_state_desc(1)
          ,Fields.InvalidMessage_corp_merger_type_converted_to_cd(1)
          ,Fields.InvalidMessage_InternalField1(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTH_ErrorCount
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount,le.corp_forgn_date_LENGTH_ErrorCount
          ,le.corp_filing_date_ALLOW_ErrorCount,le.corp_filing_date_CUSTOM_ErrorCount,le.corp_filing_date_LENGTH_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTH_ErrorCount
          ,le.corp_term_exist_exp_ALLOW_ErrorCount,le.corp_term_exist_exp_CUSTOM_ErrorCount,le.corp_term_exist_exp_LENGTH_ErrorCount
          ,le.corp_merger_date_ALLOW_ErrorCount,le.corp_merger_date_CUSTOM_ErrorCount,le.corp_merger_date_LENGTH_ErrorCount
          ,le.corp_merger_effective_date_ALLOW_ErrorCount,le.corp_merger_effective_date_CUSTOM_ErrorCount,le.corp_merger_effective_date_LENGTH_ErrorCount
          ,le.corp_name_status_date_ALLOW_ErrorCount,le.corp_name_status_date_CUSTOM_ErrorCount,le.corp_name_status_date_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_ln_name_type_cd_ENUM_ErrorCount
          ,le.corp_ln_name_type_desc_ENUM_ErrorCount
          ,le.corp_status_desc_ENUM_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount
          ,le.corp_merger_type_converted_to_cd_ENUM_ErrorCount
          ,le.InternalField1_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTH_ErrorCount
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount,le.corp_forgn_date_LENGTH_ErrorCount
          ,le.corp_filing_date_ALLOW_ErrorCount,le.corp_filing_date_CUSTOM_ErrorCount,le.corp_filing_date_LENGTH_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTH_ErrorCount
          ,le.corp_term_exist_exp_ALLOW_ErrorCount,le.corp_term_exist_exp_CUSTOM_ErrorCount,le.corp_term_exist_exp_LENGTH_ErrorCount
          ,le.corp_merger_date_ALLOW_ErrorCount,le.corp_merger_date_CUSTOM_ErrorCount,le.corp_merger_date_LENGTH_ErrorCount
          ,le.corp_merger_effective_date_ALLOW_ErrorCount,le.corp_merger_effective_date_CUSTOM_ErrorCount,le.corp_merger_effective_date_LENGTH_ErrorCount
          ,le.corp_name_status_date_ALLOW_ErrorCount,le.corp_name_status_date_CUSTOM_ErrorCount,le.corp_name_status_date_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_ln_name_type_cd_ENUM_ErrorCount
          ,le.corp_ln_name_type_desc_ENUM_ErrorCount
          ,le.corp_status_desc_ENUM_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount
          ,le.corp_merger_type_converted_to_cd_ENUM_ErrorCount
          ,le.InternalField1_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,58,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
