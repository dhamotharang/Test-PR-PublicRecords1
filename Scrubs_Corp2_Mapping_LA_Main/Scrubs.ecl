IMPORT CORP2_MAPPING,SALT32,UT;
IMPORT Scrubs,Scrubs_Corp2_Mapping_LA_Main; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Main)
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
    UNSIGNED1 corp_status_date_Invalid;
    UNSIGNED1 corp_standing_Invalid;
    UNSIGNED1 corp_status_comment_Invalid;
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_inc_county_Invalid;
    UNSIGNED1 corp_inc_date_Invalid;
    UNSIGNED1 corp_term_exist_cd_Invalid;
    UNSIGNED1 corp_term_exist_exp_Invalid;
    UNSIGNED1 corp_term_exist_desc_Invalid;
    UNSIGNED1 corp_foreign_domestic_ind_Invalid;
    UNSIGNED1 corp_forgn_state_cd_Invalid;
    UNSIGNED1 corp_forgn_state_desc_Invalid;
    UNSIGNED1 corp_forgn_date_Invalid;
    UNSIGNED1 corp_orig_org_structure_cd_Invalid;
    UNSIGNED1 corp_for_profit_ind_Invalid;
    UNSIGNED1 corp_ra_effective_date_Invalid;
    UNSIGNED1 corp_ra_address_type_desc_Invalid;
    UNSIGNED1 corp_ra_address_line3_Invalid;
    UNSIGNED1 cont_filing_date_Invalid;
    UNSIGNED1 cont_filing_desc_Invalid;
    UNSIGNED1 cont_type_cd_Invalid;
    UNSIGNED1 cont_type_desc_Invalid;
    UNSIGNED1 corp_country_of_formation_Invalid;
    UNSIGNED1 corp_name_reservation_date_Invalid;
    UNSIGNED1 corp_name_reservation_expiration_date_Invalid;
    UNSIGNED1 corp_name_reservation_nbr_Invalid;
    UNSIGNED1 corp_name_status_date_Invalid;
    UNSIGNED1 corp_name_status_desc_Invalid;
    UNSIGNED1 corp_trademark_first_use_date_Invalid;
    UNSIGNED1 corp_trademark_first_use_date_in_state_Invalid;
    UNSIGNED1 corp_trademark_status_Invalid;
    UNSIGNED1 cont_country_Invalid;
    UNSIGNED1 recordorigin_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Main)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.Main) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT32.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT32.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen);
    SELF.corp_ra_dt_first_seen_Invalid := Fields.InValid_corp_ra_dt_first_seen((SALT32.StrType)le.corp_ra_dt_first_seen);
    SELF.corp_ra_dt_last_seen_Invalid := Fields.InValid_corp_ra_dt_last_seen((SALT32.StrType)le.corp_ra_dt_last_seen);
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT32.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT32.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT32.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT32.StrType)le.corp_process_date);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT32.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT32.StrType)le.corp_legal_name);
    SELF.corp_ln_name_type_cd_Invalid := Fields.InValid_corp_ln_name_type_cd((SALT32.StrType)le.corp_ln_name_type_cd,(SALT32.StrType)le.recordorigin);
    SELF.corp_ln_name_type_desc_Invalid := Fields.InValid_corp_ln_name_type_desc((SALT32.StrType)le.corp_ln_name_type_desc,(SALT32.StrType)le.recordorigin);
    SELF.corp_status_desc_Invalid := Fields.InValid_corp_status_desc((SALT32.StrType)le.corp_status_desc);
    SELF.corp_status_date_Invalid := Fields.InValid_corp_status_date((SALT32.StrType)le.corp_status_date);
    SELF.corp_standing_Invalid := Fields.InValid_corp_standing((SALT32.StrType)le.corp_standing);
    SELF.corp_status_comment_Invalid := Fields.InValid_corp_status_comment((SALT32.StrType)le.corp_status_comment);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT32.StrType)le.corp_inc_state);
    SELF.corp_inc_county_Invalid := Fields.InValid_corp_inc_county((SALT32.StrType)le.corp_inc_county);
    SELF.corp_inc_date_Invalid := Fields.InValid_corp_inc_date((SALT32.StrType)le.corp_inc_date);
    SELF.corp_term_exist_cd_Invalid := Fields.InValid_corp_term_exist_cd((SALT32.StrType)le.corp_term_exist_cd);
    SELF.corp_term_exist_exp_Invalid := Fields.InValid_corp_term_exist_exp((SALT32.StrType)le.corp_term_exist_exp);
    SELF.corp_term_exist_desc_Invalid := Fields.InValid_corp_term_exist_desc((SALT32.StrType)le.corp_term_exist_desc);
    SELF.corp_foreign_domestic_ind_Invalid := Fields.InValid_corp_foreign_domestic_ind((SALT32.StrType)le.corp_foreign_domestic_ind);
    SELF.corp_forgn_state_cd_Invalid := Fields.InValid_corp_forgn_state_cd((SALT32.StrType)le.corp_forgn_state_cd);
    SELF.corp_forgn_state_desc_Invalid := Fields.InValid_corp_forgn_state_desc((SALT32.StrType)le.corp_forgn_state_desc);
    SELF.corp_forgn_date_Invalid := Fields.InValid_corp_forgn_date((SALT32.StrType)le.corp_forgn_date);
    SELF.corp_orig_org_structure_cd_Invalid := Fields.InValid_corp_orig_org_structure_cd((SALT32.StrType)le.corp_orig_org_structure_cd);
    SELF.corp_for_profit_ind_Invalid := Fields.InValid_corp_for_profit_ind((SALT32.StrType)le.corp_for_profit_ind);
    SELF.corp_ra_effective_date_Invalid := Fields.InValid_corp_ra_effective_date((SALT32.StrType)le.corp_ra_effective_date);
    SELF.corp_ra_address_type_desc_Invalid := Fields.InValid_corp_ra_address_type_desc((SALT32.StrType)le.corp_ra_address_type_desc);
    SELF.corp_ra_address_line3_Invalid := Fields.InValid_corp_ra_address_line3((SALT32.StrType)le.corp_ra_address_line3);
    SELF.cont_filing_date_Invalid := Fields.InValid_cont_filing_date((SALT32.StrType)le.cont_filing_date);
    SELF.cont_filing_desc_Invalid := Fields.InValid_cont_filing_desc((SALT32.StrType)le.cont_filing_desc);
    SELF.cont_type_cd_Invalid := Fields.InValid_cont_type_cd((SALT32.StrType)le.cont_type_cd);
    SELF.cont_type_desc_Invalid := Fields.InValid_cont_type_desc((SALT32.StrType)le.cont_type_desc);
    SELF.corp_country_of_formation_Invalid := Fields.InValid_corp_country_of_formation((SALT32.StrType)le.corp_country_of_formation);
    SELF.corp_name_reservation_date_Invalid := Fields.InValid_corp_name_reservation_date((SALT32.StrType)le.corp_name_reservation_date);
    SELF.corp_name_reservation_expiration_date_Invalid := Fields.InValid_corp_name_reservation_expiration_date((SALT32.StrType)le.corp_name_reservation_expiration_date);
    SELF.corp_name_reservation_nbr_Invalid := Fields.InValid_corp_name_reservation_nbr((SALT32.StrType)le.corp_name_reservation_nbr);
    SELF.corp_name_status_date_Invalid := Fields.InValid_corp_name_status_date((SALT32.StrType)le.corp_name_status_date);
    SELF.corp_name_status_desc_Invalid := Fields.InValid_corp_name_status_desc((SALT32.StrType)le.corp_name_status_desc);
    SELF.corp_trademark_first_use_date_Invalid := Fields.InValid_corp_trademark_first_use_date((SALT32.StrType)le.corp_trademark_first_use_date);
    SELF.corp_trademark_first_use_date_in_state_Invalid := Fields.InValid_corp_trademark_first_use_date_in_state((SALT32.StrType)le.corp_trademark_first_use_date_in_state);
    SELF.corp_trademark_status_Invalid := Fields.InValid_corp_trademark_status((SALT32.StrType)le.corp_trademark_status);
    SELF.cont_country_Invalid := Fields.InValid_cont_country((SALT32.StrType)le.cont_country);
    SELF.recordorigin_Invalid := Fields.InValid_recordorigin((SALT32.StrType)le.recordorigin);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.Main);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_vendor_first_reported_Invalid << 0 ) + ( le.dt_vendor_last_reported_Invalid << 2 ) + ( le.dt_first_seen_Invalid << 4 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.corp_ra_dt_first_seen_Invalid << 8 ) + ( le.corp_ra_dt_last_seen_Invalid << 10 ) + ( le.corp_key_Invalid << 12 ) + ( le.corp_vendor_Invalid << 14 ) + ( le.corp_state_origin_Invalid << 15 ) + ( le.corp_process_date_Invalid << 16 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 18 ) + ( le.corp_legal_name_Invalid << 20 ) + ( le.corp_ln_name_type_cd_Invalid << 21 ) + ( le.corp_ln_name_type_desc_Invalid << 22 ) + ( le.corp_status_desc_Invalid << 23 ) + ( le.corp_status_date_Invalid << 24 ) + ( le.corp_standing_Invalid << 26 ) + ( le.corp_status_comment_Invalid << 27 ) + ( le.corp_inc_state_Invalid << 28 ) + ( le.corp_inc_county_Invalid << 29 ) + ( le.corp_inc_date_Invalid << 30 ) + ( le.corp_term_exist_cd_Invalid << 32 ) + ( le.corp_term_exist_exp_Invalid << 33 ) + ( le.corp_term_exist_desc_Invalid << 35 ) + ( le.corp_foreign_domestic_ind_Invalid << 36 ) + ( le.corp_forgn_state_cd_Invalid << 37 ) + ( le.corp_forgn_state_desc_Invalid << 38 ) + ( le.corp_forgn_date_Invalid << 39 ) + ( le.corp_orig_org_structure_cd_Invalid << 41 ) + ( le.corp_for_profit_ind_Invalid << 42 ) + ( le.corp_ra_effective_date_Invalid << 43 ) + ( le.corp_ra_address_type_desc_Invalid << 45 ) + ( le.corp_ra_address_line3_Invalid << 46 ) + ( le.cont_filing_date_Invalid << 47 ) + ( le.cont_filing_desc_Invalid << 49 ) + ( le.cont_type_cd_Invalid << 50 ) + ( le.cont_type_desc_Invalid << 51 ) + ( le.corp_country_of_formation_Invalid << 52 ) + ( le.corp_name_reservation_date_Invalid << 53 ) + ( le.corp_name_reservation_expiration_date_Invalid << 55 ) + ( le.corp_name_reservation_nbr_Invalid << 57 ) + ( le.corp_name_status_date_Invalid << 59 ) + ( le.corp_name_status_desc_Invalid << 61 ) + ( le.corp_trademark_first_use_date_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.corp_trademark_first_use_date_in_state_Invalid << 0 ) + ( le.corp_trademark_status_Invalid << 2 ) + ( le.cont_country_Invalid << 3 ) + ( le.recordorigin_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.Main);
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
    SELF.corp_status_date_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.corp_standing_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.corp_status_comment_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.corp_inc_county_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.corp_inc_date_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.corp_term_exist_cd_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.corp_term_exist_exp_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.corp_term_exist_desc_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.corp_foreign_domestic_ind_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.corp_forgn_state_cd_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.corp_forgn_state_desc_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.corp_forgn_date_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.corp_orig_org_structure_cd_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.corp_for_profit_ind_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.corp_ra_effective_date_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.corp_ra_address_type_desc_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.corp_ra_address_line3_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.cont_filing_date_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.cont_filing_desc_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.cont_type_cd_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.cont_type_desc_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.corp_country_of_formation_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.corp_name_reservation_date_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.corp_name_reservation_expiration_date_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.corp_name_reservation_nbr_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.corp_name_status_date_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.corp_name_status_desc_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.corp_trademark_first_use_date_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.corp_trademark_first_use_date_in_state_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.corp_trademark_status_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.cont_country_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.recordorigin_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT)) : independent;
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
    corp_ln_name_type_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_cd_Invalid=1);
    corp_ln_name_type_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_desc_Invalid=1);
    corp_status_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_desc_Invalid=1);
    corp_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=1);
    corp_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid=2);
    corp_status_date_Total_ErrorCount := COUNT(GROUP,h.corp_status_date_Invalid>0);
    corp_standing_ENUM_ErrorCount := COUNT(GROUP,h.corp_standing_Invalid=1);
    corp_status_comment_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_comment_Invalid=1);
    corp_inc_state_ENUM_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_inc_county_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_county_Invalid=1);
    corp_inc_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=1);
    corp_inc_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=2);
    corp_inc_date_Total_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid>0);
    corp_term_exist_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_term_exist_cd_Invalid=1);
    corp_term_exist_exp_ALLOW_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid=1);
    corp_term_exist_exp_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid=2);
    corp_term_exist_exp_Total_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid>0);
    corp_term_exist_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_term_exist_desc_Invalid=1);
    corp_foreign_domestic_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_foreign_domestic_ind_Invalid=1);
    corp_forgn_state_cd_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_state_cd_Invalid=1);
    corp_forgn_state_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_state_desc_Invalid=1);
    corp_forgn_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=1);
    corp_forgn_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=2);
    corp_forgn_date_Total_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid>0);
    corp_orig_org_structure_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_orig_org_structure_cd_Invalid=1);
    corp_for_profit_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_for_profit_ind_Invalid=1);
    corp_ra_effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_effective_date_Invalid=1);
    corp_ra_effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_effective_date_Invalid=2);
    corp_ra_effective_date_Total_ErrorCount := COUNT(GROUP,h.corp_ra_effective_date_Invalid>0);
    corp_ra_address_type_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_address_type_desc_Invalid=1);
    corp_ra_address_line3_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_address_line3_Invalid=1);
    cont_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid=1);
    cont_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid=2);
    cont_filing_date_Total_ErrorCount := COUNT(GROUP,h.cont_filing_date_Invalid>0);
    cont_filing_desc_ALLOW_ErrorCount := COUNT(GROUP,h.cont_filing_desc_Invalid=1);
    cont_type_cd_ENUM_ErrorCount := COUNT(GROUP,h.cont_type_cd_Invalid=1);
    cont_type_desc_ALLOW_ErrorCount := COUNT(GROUP,h.cont_type_desc_Invalid=1);
    corp_country_of_formation_ALLOW_ErrorCount := COUNT(GROUP,h.corp_country_of_formation_Invalid=1);
    corp_name_reservation_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_name_reservation_date_Invalid=1);
    corp_name_reservation_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_name_reservation_date_Invalid=2);
    corp_name_reservation_date_Total_ErrorCount := COUNT(GROUP,h.corp_name_reservation_date_Invalid>0);
    corp_name_reservation_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_name_reservation_expiration_date_Invalid=1);
    corp_name_reservation_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_name_reservation_expiration_date_Invalid=2);
    corp_name_reservation_expiration_date_Total_ErrorCount := COUNT(GROUP,h.corp_name_reservation_expiration_date_Invalid>0);
    corp_name_reservation_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_name_reservation_nbr_Invalid=1);
    corp_name_reservation_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.corp_name_reservation_nbr_Invalid=2);
    corp_name_reservation_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_name_reservation_nbr_Invalid>0);
    corp_name_status_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid=1);
    corp_name_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid=2);
    corp_name_status_date_Total_ErrorCount := COUNT(GROUP,h.corp_name_status_date_Invalid>0);
    corp_name_status_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_name_status_desc_Invalid=1);
    corp_trademark_first_use_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=1);
    corp_trademark_first_use_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=2);
    corp_trademark_first_use_date_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid>0);
    corp_trademark_first_use_date_in_state_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=1);
    corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=2);
    corp_trademark_first_use_date_in_state_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid>0);
    corp_trademark_status_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_status_Invalid=1);
    cont_country_ALLOW_ErrorCount := COUNT(GROUP,h.cont_country_Invalid=1);
    recordorigin_ENUM_ErrorCount := COUNT(GROUP,h.recordorigin_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r) : independent;;
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.corp_ra_dt_first_seen_Invalid,le.corp_ra_dt_last_seen_Invalid,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_legal_name_Invalid,le.corp_ln_name_type_cd_Invalid,le.corp_ln_name_type_desc_Invalid,le.corp_status_desc_Invalid,le.corp_status_date_Invalid,le.corp_standing_Invalid,le.corp_status_comment_Invalid,le.corp_inc_state_Invalid,le.corp_inc_county_Invalid,le.corp_inc_date_Invalid,le.corp_term_exist_cd_Invalid,le.corp_term_exist_exp_Invalid,le.corp_term_exist_desc_Invalid,le.corp_foreign_domestic_ind_Invalid,le.corp_forgn_state_cd_Invalid,le.corp_forgn_state_desc_Invalid,le.corp_forgn_date_Invalid,le.corp_orig_org_structure_cd_Invalid,le.corp_for_profit_ind_Invalid,le.corp_ra_effective_date_Invalid,le.corp_ra_address_type_desc_Invalid,le.corp_ra_address_line3_Invalid,le.cont_filing_date_Invalid,le.cont_filing_desc_Invalid,le.cont_type_cd_Invalid,le.cont_type_desc_Invalid,le.corp_country_of_formation_Invalid,le.corp_name_reservation_date_Invalid,le.corp_name_reservation_expiration_date_Invalid,le.corp_name_reservation_nbr_Invalid,le.corp_name_status_date_Invalid,le.corp_name_status_desc_Invalid,le.corp_trademark_first_use_date_Invalid,le.corp_trademark_first_use_date_in_state_Invalid,le.corp_trademark_status_Invalid,le.cont_country_Invalid,le.recordorigin_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_first_seen(le.corp_ra_dt_first_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_last_seen(le.corp_ra_dt_last_seen_Invalid),Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_corp_ln_name_type_cd(le.corp_ln_name_type_cd_Invalid),Fields.InvalidMessage_corp_ln_name_type_desc(le.corp_ln_name_type_desc_Invalid),Fields.InvalidMessage_corp_status_desc(le.corp_status_desc_Invalid),Fields.InvalidMessage_corp_status_date(le.corp_status_date_Invalid),Fields.InvalidMessage_corp_standing(le.corp_standing_Invalid),Fields.InvalidMessage_corp_status_comment(le.corp_status_comment_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_inc_county(le.corp_inc_county_Invalid),Fields.InvalidMessage_corp_inc_date(le.corp_inc_date_Invalid),Fields.InvalidMessage_corp_term_exist_cd(le.corp_term_exist_cd_Invalid),Fields.InvalidMessage_corp_term_exist_exp(le.corp_term_exist_exp_Invalid),Fields.InvalidMessage_corp_term_exist_desc(le.corp_term_exist_desc_Invalid),Fields.InvalidMessage_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind_Invalid),Fields.InvalidMessage_corp_forgn_state_cd(le.corp_forgn_state_cd_Invalid),Fields.InvalidMessage_corp_forgn_state_desc(le.corp_forgn_state_desc_Invalid),Fields.InvalidMessage_corp_forgn_date(le.corp_forgn_date_Invalid),Fields.InvalidMessage_corp_orig_org_structure_cd(le.corp_orig_org_structure_cd_Invalid),Fields.InvalidMessage_corp_for_profit_ind(le.corp_for_profit_ind_Invalid),Fields.InvalidMessage_corp_ra_effective_date(le.corp_ra_effective_date_Invalid),Fields.InvalidMessage_corp_ra_address_type_desc(le.corp_ra_address_type_desc_Invalid),Fields.InvalidMessage_corp_ra_address_line3(le.corp_ra_address_line3_Invalid),Fields.InvalidMessage_cont_filing_date(le.cont_filing_date_Invalid),Fields.InvalidMessage_cont_filing_desc(le.cont_filing_desc_Invalid),Fields.InvalidMessage_cont_type_cd(le.cont_type_cd_Invalid),Fields.InvalidMessage_cont_type_desc(le.cont_type_desc_Invalid),Fields.InvalidMessage_corp_country_of_formation(le.corp_country_of_formation_Invalid),Fields.InvalidMessage_corp_name_reservation_date(le.corp_name_reservation_date_Invalid),Fields.InvalidMessage_corp_name_reservation_expiration_date(le.corp_name_reservation_expiration_date_Invalid),Fields.InvalidMessage_corp_name_reservation_nbr(le.corp_name_reservation_nbr_Invalid),Fields.InvalidMessage_corp_name_status_date(le.corp_name_status_date_Invalid),Fields.InvalidMessage_corp_name_status_desc(le.corp_name_status_desc_Invalid),Fields.InvalidMessage_corp_trademark_first_use_date(le.corp_trademark_first_use_date_Invalid),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(le.corp_trademark_first_use_date_in_state_Invalid),Fields.InvalidMessage_corp_trademark_status(le.corp_trademark_status_Invalid),Fields.InvalidMessage_cont_country(le.cont_country_Invalid),Fields.InvalidMessage_recordorigin(le.recordorigin_Invalid),'UNKNOWN'));
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
          ,CHOOSE(le.corp_ln_name_type_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_ln_name_type_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_status_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_status_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_standing_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_status_comment_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_inc_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_inc_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_term_exist_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_term_exist_exp_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_term_exist_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_foreign_domestic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_forgn_state_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_forgn_state_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_forgn_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_orig_org_structure_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_for_profit_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_ra_effective_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_ra_address_type_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_ra_address_line3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cont_filing_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.cont_filing_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cont_type_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cont_type_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_country_of_formation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_name_reservation_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_name_reservation_expiration_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_name_reservation_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.corp_name_status_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_name_status_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_first_use_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_trademark_first_use_date_in_state_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_trademark_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cont_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recordorigin_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_status_desc','corp_status_date','corp_standing','corp_status_comment','corp_inc_state','corp_inc_county','corp_inc_date','corp_term_exist_cd','corp_term_exist_exp','corp_term_exist_desc','corp_foreign_domestic_ind','corp_forgn_state_cd','corp_forgn_state_desc','corp_forgn_date','corp_orig_org_structure_cd','corp_for_profit_ind','corp_ra_effective_date','corp_ra_address_type_desc','corp_ra_address_line3','cont_filing_date','cont_filing_desc','cont_type_cd','cont_type_desc','corp_country_of_formation','corp_name_reservation_date','corp_name_reservation_expiration_date','corp_name_reservation_nbr','corp_name_status_date','corp_name_status_desc','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_status','cont_country','recordorigin','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_mandatory','invalid_type_cd','invalid_type_desc','invalid_alphablank','invalid_date','invalid_Y_N','invalid_alphablankspec','invalid_state_origin','invalid_alphablank','invalid_date','invalid_term_exist_cd','invalid_future_date','invalid_alphablank','invalid_for_dom_ind','invalid_alphablank','invalid_alphablankspec','invalid_date','invalid_org_structure_cd','invalid_Y_N','invalid_future_date','invalid_alphablank','invalid_alphablank','invalid_date','invalid_alphablank','invalid_cont_type_cd','invalid_alphablank','invalid_alphablankspec','invalid_date','invalid_future_date','invalid_numblank','invalid_date','invalid_alphablank','invalid_date','invalid_date','invalid_alphablank','invalid_alphablankspec','invalid_recordorigin','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.dt_vendor_first_reported,(SALT32.StrType)le.dt_vendor_last_reported,(SALT32.StrType)le.dt_first_seen,(SALT32.StrType)le.dt_last_seen,(SALT32.StrType)le.corp_ra_dt_first_seen,(SALT32.StrType)le.corp_ra_dt_last_seen,(SALT32.StrType)le.corp_key,(SALT32.StrType)le.corp_vendor,(SALT32.StrType)le.corp_state_origin,(SALT32.StrType)le.corp_process_date,(SALT32.StrType)le.corp_orig_sos_charter_nbr,(SALT32.StrType)le.corp_legal_name,(SALT32.StrType)le.corp_ln_name_type_cd,(SALT32.StrType)le.corp_ln_name_type_desc,(SALT32.StrType)le.corp_status_desc,(SALT32.StrType)le.corp_status_date,(SALT32.StrType)le.corp_standing,(SALT32.StrType)le.corp_status_comment,(SALT32.StrType)le.corp_inc_state,(SALT32.StrType)le.corp_inc_county,(SALT32.StrType)le.corp_inc_date,(SALT32.StrType)le.corp_term_exist_cd,(SALT32.StrType)le.corp_term_exist_exp,(SALT32.StrType)le.corp_term_exist_desc,(SALT32.StrType)le.corp_foreign_domestic_ind,(SALT32.StrType)le.corp_forgn_state_cd,(SALT32.StrType)le.corp_forgn_state_desc,(SALT32.StrType)le.corp_forgn_date,(SALT32.StrType)le.corp_orig_org_structure_cd,(SALT32.StrType)le.corp_for_profit_ind,(SALT32.StrType)le.corp_ra_effective_date,(SALT32.StrType)le.corp_ra_address_type_desc,(SALT32.StrType)le.corp_ra_address_line3,(SALT32.StrType)le.cont_filing_date,(SALT32.StrType)le.cont_filing_desc,(SALT32.StrType)le.cont_type_cd,(SALT32.StrType)le.cont_type_desc,(SALT32.StrType)le.corp_country_of_formation,(SALT32.StrType)le.corp_name_reservation_date,(SALT32.StrType)le.corp_name_reservation_expiration_date,(SALT32.StrType)le.corp_name_reservation_nbr,(SALT32.StrType)le.corp_name_status_date,(SALT32.StrType)le.corp_name_status_desc,(SALT32.StrType)le.corp_trademark_first_use_date,(SALT32.StrType)le.corp_trademark_first_use_date_in_state,(SALT32.StrType)le.corp_trademark_status,(SALT32.StrType)le.cont_country,(SALT32.StrType)le.recordorigin,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,48,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
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
          ,'corp_orig_sos_charter_nbr:invalid_charter_nbr:ALLOW','corp_orig_sos_charter_nbr:invalid_charter_nbr:LENGTH'
          ,'corp_legal_name:invalid_mandatory:LENGTH'
          ,'corp_ln_name_type_cd:invalid_type_cd:CUSTOM'
          ,'corp_ln_name_type_desc:invalid_type_desc:CUSTOM'
          ,'corp_status_desc:invalid_alphablank:ALLOW'
          ,'corp_status_date:invalid_date:ALLOW','corp_status_date:invalid_date:CUSTOM'
          ,'corp_standing:invalid_Y_N:ENUM'
          ,'corp_status_comment:invalid_alphablankspec:ALLOW'
          ,'corp_inc_state:invalid_state_origin:ENUM'
          ,'corp_inc_county:invalid_alphablank:ALLOW'
          ,'corp_inc_date:invalid_date:ALLOW','corp_inc_date:invalid_date:CUSTOM'
          ,'corp_term_exist_cd:invalid_term_exist_cd:ENUM'
          ,'corp_term_exist_exp:invalid_future_date:ALLOW','corp_term_exist_exp:invalid_future_date:CUSTOM'
          ,'corp_term_exist_desc:invalid_alphablank:ALLOW'
          ,'corp_foreign_domestic_ind:invalid_for_dom_ind:ENUM'
          ,'corp_forgn_state_cd:invalid_alphablank:ALLOW'
          ,'corp_forgn_state_desc:invalid_alphablankspec:ALLOW'
          ,'corp_forgn_date:invalid_date:ALLOW','corp_forgn_date:invalid_date:CUSTOM'
          ,'corp_orig_org_structure_cd:invalid_org_structure_cd:CUSTOM'
          ,'corp_for_profit_ind:invalid_Y_N:ENUM'
          ,'corp_ra_effective_date:invalid_future_date:ALLOW','corp_ra_effective_date:invalid_future_date:CUSTOM'
          ,'corp_ra_address_type_desc:invalid_alphablank:ALLOW'
          ,'corp_ra_address_line3:invalid_alphablank:ALLOW'
          ,'cont_filing_date:invalid_date:ALLOW','cont_filing_date:invalid_date:CUSTOM'
          ,'cont_filing_desc:invalid_alphablank:ALLOW'
          ,'cont_type_cd:invalid_cont_type_cd:ENUM'
          ,'cont_type_desc:invalid_alphablank:ALLOW'
          ,'corp_country_of_formation:invalid_alphablankspec:ALLOW'
          ,'corp_name_reservation_date:invalid_date:ALLOW','corp_name_reservation_date:invalid_date:CUSTOM'
          ,'corp_name_reservation_expiration_date:invalid_future_date:ALLOW','corp_name_reservation_expiration_date:invalid_future_date:CUSTOM'
          ,'corp_name_reservation_nbr:invalid_numblank:ALLOW','corp_name_reservation_nbr:invalid_numblank:LENGTH'
          ,'corp_name_status_date:invalid_date:ALLOW','corp_name_status_date:invalid_date:CUSTOM'
          ,'corp_name_status_desc:invalid_alphablank:ALLOW'
          ,'corp_trademark_first_use_date:invalid_date:ALLOW','corp_trademark_first_use_date:invalid_date:CUSTOM'
          ,'corp_trademark_first_use_date_in_state:invalid_date:ALLOW','corp_trademark_first_use_date_in_state:invalid_date:CUSTOM'
          ,'corp_trademark_status:invalid_alphablank:ALLOW'
          ,'cont_country:invalid_alphablankspec:ALLOW'
          ,'recordorigin:invalid_recordorigin:ENUM','UNKNOWN');
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
          ,Fields.InvalidMessage_corp_status_date(1),Fields.InvalidMessage_corp_status_date(2)
          ,Fields.InvalidMessage_corp_standing(1)
          ,Fields.InvalidMessage_corp_status_comment(1)
          ,Fields.InvalidMessage_corp_inc_state(1)
          ,Fields.InvalidMessage_corp_inc_county(1)
          ,Fields.InvalidMessage_corp_inc_date(1),Fields.InvalidMessage_corp_inc_date(2)
          ,Fields.InvalidMessage_corp_term_exist_cd(1)
          ,Fields.InvalidMessage_corp_term_exist_exp(1),Fields.InvalidMessage_corp_term_exist_exp(2)
          ,Fields.InvalidMessage_corp_term_exist_desc(1)
          ,Fields.InvalidMessage_corp_foreign_domestic_ind(1)
          ,Fields.InvalidMessage_corp_forgn_state_cd(1)
          ,Fields.InvalidMessage_corp_forgn_state_desc(1)
          ,Fields.InvalidMessage_corp_forgn_date(1),Fields.InvalidMessage_corp_forgn_date(2)
          ,Fields.InvalidMessage_corp_orig_org_structure_cd(1)
          ,Fields.InvalidMessage_corp_for_profit_ind(1)
          ,Fields.InvalidMessage_corp_ra_effective_date(1),Fields.InvalidMessage_corp_ra_effective_date(2)
          ,Fields.InvalidMessage_corp_ra_address_type_desc(1)
          ,Fields.InvalidMessage_corp_ra_address_line3(1)
          ,Fields.InvalidMessage_cont_filing_date(1),Fields.InvalidMessage_cont_filing_date(2)
          ,Fields.InvalidMessage_cont_filing_desc(1)
          ,Fields.InvalidMessage_cont_type_cd(1)
          ,Fields.InvalidMessage_cont_type_desc(1)
          ,Fields.InvalidMessage_corp_country_of_formation(1)
          ,Fields.InvalidMessage_corp_name_reservation_date(1),Fields.InvalidMessage_corp_name_reservation_date(2)
          ,Fields.InvalidMessage_corp_name_reservation_expiration_date(1),Fields.InvalidMessage_corp_name_reservation_expiration_date(2)
          ,Fields.InvalidMessage_corp_name_reservation_nbr(1),Fields.InvalidMessage_corp_name_reservation_nbr(2)
          ,Fields.InvalidMessage_corp_name_status_date(1),Fields.InvalidMessage_corp_name_status_date(2)
          ,Fields.InvalidMessage_corp_name_status_desc(1)
          ,Fields.InvalidMessage_corp_trademark_first_use_date(1),Fields.InvalidMessage_corp_trademark_first_use_date(2)
          ,Fields.InvalidMessage_corp_trademark_first_use_date_in_state(1),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(2)
          ,Fields.InvalidMessage_corp_trademark_status(1)
          ,Fields.InvalidMessage_cont_country(1)
          ,Fields.InvalidMessage_recordorigin(1),'UNKNOWN');
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
          ,le.corp_ln_name_type_cd_CUSTOM_ErrorCount
          ,le.corp_ln_name_type_desc_CUSTOM_ErrorCount
          ,le.corp_status_desc_ALLOW_ErrorCount
          ,le.corp_status_date_ALLOW_ErrorCount,le.corp_status_date_CUSTOM_ErrorCount
          ,le.corp_standing_ENUM_ErrorCount
          ,le.corp_status_comment_ALLOW_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_inc_county_ALLOW_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount
          ,le.corp_term_exist_cd_ENUM_ErrorCount
          ,le.corp_term_exist_exp_ALLOW_ErrorCount,le.corp_term_exist_exp_CUSTOM_ErrorCount
          ,le.corp_term_exist_desc_ALLOW_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_forgn_state_cd_ALLOW_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount
          ,le.corp_orig_org_structure_cd_CUSTOM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_ra_effective_date_ALLOW_ErrorCount,le.corp_ra_effective_date_CUSTOM_ErrorCount
          ,le.corp_ra_address_type_desc_ALLOW_ErrorCount
          ,le.corp_ra_address_line3_ALLOW_ErrorCount
          ,le.cont_filing_date_ALLOW_ErrorCount,le.cont_filing_date_CUSTOM_ErrorCount
          ,le.cont_filing_desc_ALLOW_ErrorCount
          ,le.cont_type_cd_ENUM_ErrorCount
          ,le.cont_type_desc_ALLOW_ErrorCount
          ,le.corp_country_of_formation_ALLOW_ErrorCount
          ,le.corp_name_reservation_date_ALLOW_ErrorCount,le.corp_name_reservation_date_CUSTOM_ErrorCount
          ,le.corp_name_reservation_expiration_date_ALLOW_ErrorCount,le.corp_name_reservation_expiration_date_CUSTOM_ErrorCount
          ,le.corp_name_reservation_nbr_ALLOW_ErrorCount,le.corp_name_reservation_nbr_LENGTH_ErrorCount
          ,le.corp_name_status_date_ALLOW_ErrorCount,le.corp_name_status_date_CUSTOM_ErrorCount
          ,le.corp_name_status_desc_ALLOW_ErrorCount
          ,le.corp_trademark_first_use_date_ALLOW_ErrorCount,le.corp_trademark_first_use_date_CUSTOM_ErrorCount
          ,le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount,le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount
          ,le.corp_trademark_status_ALLOW_ErrorCount
          ,le.cont_country_ALLOW_ErrorCount
          ,le.recordorigin_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
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
          ,le.corp_ln_name_type_cd_CUSTOM_ErrorCount
          ,le.corp_ln_name_type_desc_CUSTOM_ErrorCount
          ,le.corp_status_desc_ALLOW_ErrorCount
          ,le.corp_status_date_ALLOW_ErrorCount,le.corp_status_date_CUSTOM_ErrorCount
          ,le.corp_standing_ENUM_ErrorCount
          ,le.corp_status_comment_ALLOW_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_inc_county_ALLOW_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount
          ,le.corp_term_exist_cd_ENUM_ErrorCount
          ,le.corp_term_exist_exp_ALLOW_ErrorCount,le.corp_term_exist_exp_CUSTOM_ErrorCount
          ,le.corp_term_exist_desc_ALLOW_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_forgn_state_cd_ALLOW_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount
          ,le.corp_orig_org_structure_cd_CUSTOM_ErrorCount
          ,le.corp_for_profit_ind_ENUM_ErrorCount
          ,le.corp_ra_effective_date_ALLOW_ErrorCount,le.corp_ra_effective_date_CUSTOM_ErrorCount
          ,le.corp_ra_address_type_desc_ALLOW_ErrorCount
          ,le.corp_ra_address_line3_ALLOW_ErrorCount
          ,le.cont_filing_date_ALLOW_ErrorCount,le.cont_filing_date_CUSTOM_ErrorCount
          ,le.cont_filing_desc_ALLOW_ErrorCount
          ,le.cont_type_cd_ENUM_ErrorCount
          ,le.cont_type_desc_ALLOW_ErrorCount
          ,le.corp_country_of_formation_ALLOW_ErrorCount
          ,le.corp_name_reservation_date_ALLOW_ErrorCount,le.corp_name_reservation_date_CUSTOM_ErrorCount
          ,le.corp_name_reservation_expiration_date_ALLOW_ErrorCount,le.corp_name_reservation_expiration_date_CUSTOM_ErrorCount
          ,le.corp_name_reservation_nbr_ALLOW_ErrorCount,le.corp_name_reservation_nbr_LENGTH_ErrorCount
          ,le.corp_name_status_date_ALLOW_ErrorCount,le.corp_name_status_date_CUSTOM_ErrorCount
          ,le.corp_name_status_desc_ALLOW_ErrorCount
          ,le.corp_trademark_first_use_date_ALLOW_ErrorCount,le.corp_trademark_first_use_date_CUSTOM_ErrorCount
          ,le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount,le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount
          ,le.corp_trademark_status_ALLOW_ErrorCount
          ,le.cont_country_ALLOW_ErrorCount
          ,le.recordorigin_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,69,Into(LEFT,COUNTER));
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
