IMPORT ut,SALT32,corp2_mapping;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Main)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_orig_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 corp_forgn_date_Invalid;
    UNSIGNED1 corp_inc_date_Invalid;
    UNSIGNED1 corp_merger_date_Invalid;
    UNSIGNED1 corp_merger_effective_date_Invalid;
    UNSIGNED1 corp_ra_dt_first_seen_Invalid;
    UNSIGNED1 corp_ra_dt_last_seen_Invalid;
    UNSIGNED1 corp_ra_resign_date_Invalid;
    UNSIGNED1 corp_status_date_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_for_profit_ind_Invalid;
    UNSIGNED1 corp_foreign_domestic_ind_Invalid;
    UNSIGNED1 corp_status_cd_Invalid;
    UNSIGNED1 corp_orig_org_structure_cd_Invalid;
    UNSIGNED1 corp_fed_tax_id_Invalid;
    UNSIGNED1 corp_forgn_state_desc_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.Main) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT32.StrType)le.corp_key);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT32.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT32.StrType)le.corp_legal_name);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT32.StrType)le.corp_process_date);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT32.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT32.StrType)le.dt_vendor_last_reported);
    SELF.corp_forgn_date_Invalid := Fields.InValid_corp_forgn_date((SALT32.StrType)le.corp_forgn_date);
    SELF.corp_inc_date_Invalid := Fields.InValid_corp_inc_date((SALT32.StrType)le.corp_inc_date);
    SELF.corp_merger_date_Invalid := Fields.InValid_corp_merger_date((SALT32.StrType)le.corp_merger_date);
    SELF.corp_merger_effective_date_Invalid := Fields.InValid_corp_merger_effective_date((SALT32.StrType)le.corp_merger_effective_date);
    SELF.corp_ra_dt_first_seen_Invalid := Fields.InValid_corp_ra_dt_first_seen((SALT32.StrType)le.corp_ra_dt_first_seen);
    SELF.corp_ra_dt_last_seen_Invalid := Fields.InValid_corp_ra_dt_last_seen((SALT32.StrType)le.corp_ra_dt_last_seen);
    SELF.corp_ra_resign_date_Invalid := Fields.InValid_corp_ra_resign_date((SALT32.StrType)le.corp_ra_resign_date);
    SELF.corp_status_date_Invalid := Fields.InValid_corp_status_date((SALT32.StrType)le.corp_status_date);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT32.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT32.StrType)le.corp_state_origin);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT32.StrType)le.corp_inc_state);
    SELF.corp_for_profit_ind_Invalid := Fields.InValid_corp_for_profit_ind((SALT32.StrType)le.corp_for_profit_ind);
    SELF.corp_foreign_domestic_ind_Invalid := Fields.InValid_corp_foreign_domestic_ind((SALT32.StrType)le.corp_foreign_domestic_ind);
    SELF.corp_status_cd_Invalid := Fields.InValid_corp_status_cd((SALT32.StrType)le.corp_status_cd);
    SELF.corp_orig_org_structure_cd_Invalid := Fields.InValid_corp_orig_org_structure_cd((SALT32.StrType)le.corp_orig_org_structure_cd);
    SELF.corp_fed_tax_id_Invalid := Fields.InValid_corp_fed_tax_id((SALT32.StrType)le.corp_fed_tax_id);
    SELF.corp_forgn_state_desc_Invalid := Fields.InValid_corp_forgn_state_desc((SALT32.StrType)le.corp_forgn_state_desc);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.Main);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 2 ) + ( le.corp_legal_name_Invalid << 4 ) + ( le.dt_first_seen_Invalid << 5 ) + ( le.dt_last_seen_Invalid << 7 ) + ( le.corp_process_date_Invalid << 9 ) + ( le.dt_vendor_first_reported_Invalid << 11 ) + ( le.dt_vendor_last_reported_Invalid << 13 ) + ( le.corp_forgn_date_Invalid << 15 ) + ( le.corp_inc_date_Invalid << 17 ) + ( le.corp_merger_date_Invalid << 19 ) + ( le.corp_merger_effective_date_Invalid << 21 ) + ( le.corp_ra_dt_first_seen_Invalid << 23 ) + ( le.corp_ra_dt_last_seen_Invalid << 25 ) + ( le.corp_ra_resign_date_Invalid << 27 ) + ( le.corp_status_date_Invalid << 29 ) + ( le.corp_vendor_Invalid << 31 ) + ( le.corp_state_origin_Invalid << 32 ) + ( le.corp_inc_state_Invalid << 33 ) + ( le.corp_for_profit_ind_Invalid << 34 ) + ( le.corp_foreign_domestic_ind_Invalid << 35 ) + ( le.corp_status_cd_Invalid << 36 ) + ( le.corp_orig_org_structure_cd_Invalid << 37 ) + ( le.corp_fed_tax_id_Invalid << 38 ) + ( le.corp_forgn_state_desc_Invalid << 40 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.Main);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_orig_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.corp_forgn_date_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.corp_inc_date_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.corp_merger_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.corp_merger_effective_date_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.corp_ra_dt_first_seen_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.corp_ra_dt_last_seen_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.corp_ra_resign_date_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.corp_status_date_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.corp_for_profit_ind_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.corp_foreign_domestic_ind_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.corp_status_cd_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.corp_orig_org_structure_cd_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.corp_fed_tax_id_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.corp_forgn_state_desc_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTH_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_orig_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=1);
    corp_orig_sos_charter_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=2);
    corp_orig_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid>0);
    corp_legal_name_LENGTH_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=3);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    corp_forgn_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=1);
    corp_forgn_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=2);
    corp_forgn_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=3);
    corp_forgn_date_Total_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid>0);
    corp_inc_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=1);
    corp_inc_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=2);
    corp_inc_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=3);
    corp_inc_date_Total_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid>0);
    corp_merger_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid=1);
    corp_merger_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid=2);
    corp_merger_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid=3);
    corp_merger_date_Total_ErrorCount := COUNT(GROUP,h.corp_merger_date_Invalid>0);
    corp_merger_effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid=1);
    corp_merger_effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid=2);
    corp_merger_effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid=3);
    corp_merger_effective_date_Total_ErrorCount := COUNT(GROUP,h.corp_merger_effective_date_Invalid>0);
    corp_ra_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=1);
    corp_ra_dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=2);
    corp_ra_dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=3);
    corp_ra_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid>0);
    corp_ra_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=1);
    corp_ra_dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=2);
    corp_ra_dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=3);
    corp_ra_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid>0);
    corp_ra_resign_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_resign_date_Invalid=1);
    corp_ra_resign_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_resign_date_Invalid=2);
    corp_ra_resign_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_ra_resign_date_Invalid=3);
    corp_ra_resign_date_Total_ErrorCount := COUNT(GROUP,h.corp_ra_resign_date_Invalid>0);
    corp_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=1);
    corp_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=2);
    corp_status_date_LENGTH_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=3);
    corp_status_date_Total_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_inc_state_ENUM_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_for_profit_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_for_profit_ind_Invalid=1);
    corp_foreign_domestic_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_foreign_domestic_ind_Invalid=1);
    corp_status_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_status_cd_Invalid=1);
    corp_orig_org_structure_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_orig_org_structure_cd_Invalid=1);
    corp_fed_tax_id_ALLOW_ErrorCount := COUNT(GROUP,h.corp_fed_tax_id_Invalid=1);
    corp_fed_tax_id_LENGTH_ErrorCount := COUNT(GROUP,h.corp_fed_tax_id_Invalid=2);
    corp_fed_tax_id_Total_ErrorCount := COUNT(GROUP,h.corp_fed_tax_id_Invalid>0);
    corp_forgn_state_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_state_desc_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_legal_name_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.corp_process_date_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.corp_forgn_date_Invalid,le.corp_inc_date_Invalid,le.corp_merger_date_Invalid,le.corp_merger_effective_date_Invalid,le.corp_ra_dt_first_seen_Invalid,le.corp_ra_dt_last_seen_Invalid,le.corp_ra_resign_date_Invalid,le.corp_status_date_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_inc_state_Invalid,le.corp_for_profit_ind_Invalid,le.corp_foreign_domestic_ind_Invalid,le.corp_status_cd_Invalid,le.corp_orig_org_structure_cd_Invalid,le.corp_fed_tax_id_Invalid,le.corp_forgn_state_desc_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_corp_forgn_date(le.corp_forgn_date_Invalid),Fields.InvalidMessage_corp_inc_date(le.corp_inc_date_Invalid),Fields.InvalidMessage_corp_merger_date(le.corp_merger_date_Invalid),Fields.InvalidMessage_corp_merger_effective_date(le.corp_merger_effective_date_Invalid),Fields.InvalidMessage_corp_ra_dt_first_seen(le.corp_ra_dt_first_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_last_seen(le.corp_ra_dt_last_seen_Invalid),Fields.InvalidMessage_corp_ra_resign_date(le.corp_ra_resign_date_Invalid),Fields.InvalidMessage_corp_status_date(le.corp_status_date_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_for_profit_ind(le.corp_for_profit_ind_Invalid),Fields.InvalidMessage_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind_Invalid),Fields.InvalidMessage_corp_status_cd(le.corp_status_cd_Invalid),Fields.InvalidMessage_corp_orig_org_structure_cd(le.corp_orig_org_structure_cd_Invalid),Fields.InvalidMessage_corp_fed_tax_id(le.corp_fed_tax_id_Invalid),Fields.InvalidMessage_corp_forgn_state_desc(le.corp_forgn_state_desc_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_orig_sos_charter_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_forgn_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_inc_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_merger_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_merger_effective_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_ra_resign_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_status_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_for_profit_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_foreign_domestic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_status_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_orig_org_structure_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_fed_tax_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_forgn_state_desc_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_orig_sos_charter_nbr','corp_legal_name','dt_first_seen','dt_last_seen','corp_process_date','dt_vendor_first_reported','dt_vendor_last_reported','corp_forgn_date','corp_inc_date','corp_merger_date','corp_merger_effective_date','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_ra_resign_date','corp_status_date','corp_vendor','corp_state_origin','corp_inc_state','corp_for_profit_ind','corp_foreign_domestic_ind','corp_status_cd','corp_orig_org_structure_cd','corp_fed_tax_id','corp_forgn_state_desc','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_charter','invalid_mandatory','invalid_date','invalid_date','invalid_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_corp_vendor','invalid_state_origin','invalid_state_origin','invalid_for_profit_ind','invalid_forgn_dom_code','invalid_corp_status_cd','invalid_corp_orig_org_structure_cd','invalid_fein','invalid_alphablank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.corp_key,(SALT32.StrType)le.corp_orig_sos_charter_nbr,(SALT32.StrType)le.corp_legal_name,(SALT32.StrType)le.dt_first_seen,(SALT32.StrType)le.dt_last_seen,(SALT32.StrType)le.corp_process_date,(SALT32.StrType)le.dt_vendor_first_reported,(SALT32.StrType)le.dt_vendor_last_reported,(SALT32.StrType)le.corp_forgn_date,(SALT32.StrType)le.corp_inc_date,(SALT32.StrType)le.corp_merger_date,(SALT32.StrType)le.corp_merger_effective_date,(SALT32.StrType)le.corp_ra_dt_first_seen,(SALT32.StrType)le.corp_ra_dt_last_seen,(SALT32.StrType)le.corp_ra_resign_date,(SALT32.StrType)le.corp_status_date,(SALT32.StrType)le.corp_vendor,(SALT32.StrType)le.corp_state_origin,(SALT32.StrType)le.corp_inc_state,(SALT32.StrType)le.corp_for_profit_ind,(SALT32.StrType)le.corp_foreign_domestic_ind,(SALT32.StrType)le.corp_status_cd,(SALT32.StrType)le.corp_orig_org_structure_cd,(SALT32.StrType)le.corp_fed_tax_id,(SALT32.StrType)le.corp_forgn_state_desc,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,25,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTH'
          ,'corp_orig_sos_charter_nbr:invalid_charter:ALLOW','corp_orig_sos_charter_nbr:invalid_charter:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'dt_first_seen:invalid_date:ALLOW','dt_first_seen:invalid_date:CUSTOM','dt_first_seen:invalid_date:LENGTH'
          ,'dt_last_seen:invalid_date:ALLOW','dt_last_seen:invalid_date:CUSTOM','dt_last_seen:invalid_date:LENGTH'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM','corp_process_date:invalid_date:LENGTH'
          ,'dt_vendor_first_reported:invalid_optional_date:ALLOW','dt_vendor_first_reported:invalid_optional_date:CUSTOM','dt_vendor_first_reported:invalid_optional_date:LENGTH'
          ,'dt_vendor_last_reported:invalid_optional_date:ALLOW','dt_vendor_last_reported:invalid_optional_date:CUSTOM','dt_vendor_last_reported:invalid_optional_date:LENGTH'
          ,'corp_forgn_date:invalid_optional_date:ALLOW','corp_forgn_date:invalid_optional_date:CUSTOM','corp_forgn_date:invalid_optional_date:LENGTH'
          ,'corp_inc_date:invalid_optional_date:ALLOW','corp_inc_date:invalid_optional_date:CUSTOM','corp_inc_date:invalid_optional_date:LENGTH'
          ,'corp_merger_date:invalid_optional_date:ALLOW','corp_merger_date:invalid_optional_date:CUSTOM','corp_merger_date:invalid_optional_date:LENGTH'
          ,'corp_merger_effective_date:invalid_optional_date:ALLOW','corp_merger_effective_date:invalid_optional_date:CUSTOM','corp_merger_effective_date:invalid_optional_date:LENGTH'
          ,'corp_ra_dt_first_seen:invalid_optional_date:ALLOW','corp_ra_dt_first_seen:invalid_optional_date:CUSTOM','corp_ra_dt_first_seen:invalid_optional_date:LENGTH'
          ,'corp_ra_dt_last_seen:invalid_optional_date:ALLOW','corp_ra_dt_last_seen:invalid_optional_date:CUSTOM','corp_ra_dt_last_seen:invalid_optional_date:LENGTH'
          ,'corp_ra_resign_date:invalid_optional_date:ALLOW','corp_ra_resign_date:invalid_optional_date:CUSTOM','corp_ra_resign_date:invalid_optional_date:LENGTH'
          ,'corp_status_date:invalid_optional_date:ALLOW','corp_status_date:invalid_optional_date:CUSTOM','corp_status_date:invalid_optional_date:LENGTH'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_inc_state:invalid_state_origin:ENUM'
          ,'corp_for_profit_ind:invalid_for_profit_ind:ENUM'
          ,'corp_foreign_domestic_ind:invalid_forgn_dom_code:ENUM'
          ,'corp_status_cd:invalid_corp_status_cd:ENUM'
          ,'corp_orig_org_structure_cd:invalid_corp_orig_org_structure_cd:ENUM'
          ,'corp_fed_tax_id:invalid_fein:ALLOW','corp_fed_tax_id:invalid_fein:LENGTH'
          ,'corp_forgn_state_desc:invalid_alphablank:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_orig_sos_charter_nbr(1),Fields.InvalidMessage_corp_orig_sos_charter_nbr(2)
          ,Fields.InvalidMessage_corp_legal_name(1)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2),Fields.InvalidMessage_corp_process_date(3)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_corp_forgn_date(1),Fields.InvalidMessage_corp_forgn_date(2),Fields.InvalidMessage_corp_forgn_date(3)
          ,Fields.InvalidMessage_corp_inc_date(1),Fields.InvalidMessage_corp_inc_date(2),Fields.InvalidMessage_corp_inc_date(3)
          ,Fields.InvalidMessage_corp_merger_date(1),Fields.InvalidMessage_corp_merger_date(2),Fields.InvalidMessage_corp_merger_date(3)
          ,Fields.InvalidMessage_corp_merger_effective_date(1),Fields.InvalidMessage_corp_merger_effective_date(2),Fields.InvalidMessage_corp_merger_effective_date(3)
          ,Fields.InvalidMessage_corp_ra_dt_first_seen(1),Fields.InvalidMessage_corp_ra_dt_first_seen(2),Fields.InvalidMessage_corp_ra_dt_first_seen(3)
          ,Fields.InvalidMessage_corp_ra_dt_last_seen(1),Fields.InvalidMessage_corp_ra_dt_last_seen(2),Fields.InvalidMessage_corp_ra_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_ra_resign_date(1),Fields.InvalidMessage_corp_ra_resign_date(2),Fields.InvalidMessage_corp_ra_resign_date(3)
          ,Fields.InvalidMessage_corp_status_date(1),Fields.InvalidMessage_corp_status_date(2),Fields.InvalidMessage_corp_status_date(3)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_inc_state(1)
          ,Fields.InvalidMessage_corp_for_profit_ind(1)
          ,Fields.InvalidMessage_corp_foreign_domestic_ind(1)
          ,Fields.InvalidMessage_corp_status_cd(1)
          ,Fields.InvalidMessage_corp_orig_org_structure_cd(1)
          ,Fields.InvalidMessage_corp_fed_tax_id(1),Fields.InvalidMessage_corp_fed_tax_id(2)
          ,Fields.InvalidMessage_corp_forgn_state_desc(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount,le.corp_forgn_date_LENGTH_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTH_ErrorCount
          ,le.corp_merger_date_ALLOW_ErrorCount,le.corp_merger_date_CUSTOM_ErrorCount,le.corp_merger_date_LENGTH_ErrorCount
          ,le.corp_merger_effective_date_ALLOW_ErrorCount,le.corp_merger_effective_date_CUSTOM_ErrorCount,le.corp_merger_effective_date_LENGTH_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTH_ErrorCount
          ,le.corp_ra_resign_date_ALLOW_ErrorCount,le.corp_ra_resign_date_CUSTOM_ErrorCount,le.corp_ra_resign_date_LENGTH_ErrorCount
          ,le.corp_status_date_ALLOW_ErrorCount,le.corp_status_date_CUSTOM_ErrorCount,le.corp_status_date_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_status_cd_ENUM_ErrorCount
          ,le.corp_orig_org_structure_cd_ENUM_ErrorCount
          ,le.corp_fed_tax_id_ALLOW_ErrorCount,le.corp_fed_tax_id_LENGTH_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTH_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTH_ErrorCount
          ,le.corp_legal_name_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount,le.corp_forgn_date_LENGTH_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTH_ErrorCount
          ,le.corp_merger_date_ALLOW_ErrorCount,le.corp_merger_date_CUSTOM_ErrorCount,le.corp_merger_date_LENGTH_ErrorCount
          ,le.corp_merger_effective_date_ALLOW_ErrorCount,le.corp_merger_effective_date_CUSTOM_ErrorCount,le.corp_merger_effective_date_LENGTH_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTH_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTH_ErrorCount
          ,le.corp_ra_resign_date_ALLOW_ErrorCount,le.corp_ra_resign_date_CUSTOM_ErrorCount,le.corp_ra_resign_date_LENGTH_ErrorCount
          ,le.corp_status_date_ALLOW_ErrorCount,le.corp_status_date_CUSTOM_ErrorCount,le.corp_status_date_LENGTH_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_status_cd_ENUM_ErrorCount
          ,le.corp_orig_org_structure_cd_ENUM_ErrorCount
          ,le.corp_fed_tax_id_ALLOW_ErrorCount,le.corp_fed_tax_id_LENGTH_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,54,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
