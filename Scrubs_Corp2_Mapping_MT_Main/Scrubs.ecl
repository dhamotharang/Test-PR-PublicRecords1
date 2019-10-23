IMPORT SALT38,STD,corp2_mapping;
IMPORT Scrubs,Scrubs_Corp2_Mapping_MT_Main; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 62;
  EXPORT NumRulesFromFieldType := 62;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 34;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(corp2_mapping.LayoutsCommon.Main)
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 corp_ra_dt_first_seen_Invalid;
    UNSIGNED1 corp_ra_dt_last_seen_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_orig_sos_charter_nbr_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_inc_state_Invalid;
    UNSIGNED1 corp_legal_name_Invalid;
    UNSIGNED1 corp_ln_name_type_cd_Invalid;
    UNSIGNED1 corp_filing_date_Invalid;
    UNSIGNED1 corp_inc_date_Invalid;
    UNSIGNED1 corp_forgn_date_Invalid;
    UNSIGNED1 corp_foreign_domestic_ind_Invalid;
    UNSIGNED1 corp_forgn_state_desc_Invalid;
    UNSIGNED1 corp_trademark_class_desc1_Invalid;
    UNSIGNED1 corp_trademark_class_desc2_Invalid;
    UNSIGNED1 corp_trademark_class_desc3_Invalid;
    UNSIGNED1 corp_trademark_class_desc4_Invalid;
    UNSIGNED1 corp_trademark_class_desc5_Invalid;
    UNSIGNED1 corp_trademark_class_desc6_Invalid;
    UNSIGNED1 corp_term_exist_cd_Invalid;
    UNSIGNED1 corp_term_exist_exp_Invalid;
    UNSIGNED1 corp_status_desc_Invalid;
    UNSIGNED1 corp_status_comment_Invalid;
    UNSIGNED1 corp_trademark_first_use_date_Invalid;
    UNSIGNED1 corp_trademark_first_use_date_in_state_Invalid;
    UNSIGNED1 corp_trademark_renewal_date_Invalid;
    UNSIGNED1 cont_title1_desc_Invalid;
    UNSIGNED1 recordorigin_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(corp2_mapping.LayoutsCommon.Main)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(corp2_mapping.LayoutsCommon.Main) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen);
    SELF.corp_ra_dt_first_seen_Invalid := Fields.InValid_corp_ra_dt_first_seen((SALT38.StrType)le.corp_ra_dt_first_seen);
    SELF.corp_ra_dt_last_seen_Invalid := Fields.InValid_corp_ra_dt_last_seen((SALT38.StrType)le.corp_ra_dt_last_seen);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date);
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT38.StrType)le.corp_key);
    SELF.corp_orig_sos_charter_nbr_Invalid := Fields.InValid_corp_orig_sos_charter_nbr((SALT38.StrType)le.corp_orig_sos_charter_nbr);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin);
    SELF.corp_inc_state_Invalid := Fields.InValid_corp_inc_state((SALT38.StrType)le.corp_inc_state);
    SELF.corp_legal_name_Invalid := Fields.InValid_corp_legal_name((SALT38.StrType)le.corp_legal_name);
    SELF.corp_ln_name_type_cd_Invalid := Fields.InValid_corp_ln_name_type_cd((SALT38.StrType)le.corp_ln_name_type_cd,(SALT38.StrType)le.recordOrigin);
    SELF.corp_filing_date_Invalid := Fields.InValid_corp_filing_date((SALT38.StrType)le.corp_filing_date);
    SELF.corp_inc_date_Invalid := Fields.InValid_corp_inc_date((SALT38.StrType)le.corp_inc_date);
    SELF.corp_forgn_date_Invalid := Fields.InValid_corp_forgn_date((SALT38.StrType)le.corp_forgn_date);
    SELF.corp_foreign_domestic_ind_Invalid := Fields.InValid_corp_foreign_domestic_ind((SALT38.StrType)le.corp_foreign_domestic_ind);
    SELF.corp_forgn_state_desc_Invalid := Fields.InValid_corp_forgn_state_desc((SALT38.StrType)le.corp_forgn_state_desc);
    SELF.corp_trademark_class_desc1_Invalid := Fields.InValid_corp_trademark_class_desc1((SALT38.StrType)le.corp_trademark_class_desc1);
    SELF.corp_trademark_class_desc2_Invalid := Fields.InValid_corp_trademark_class_desc2((SALT38.StrType)le.corp_trademark_class_desc2);
    SELF.corp_trademark_class_desc3_Invalid := Fields.InValid_corp_trademark_class_desc3((SALT38.StrType)le.corp_trademark_class_desc3);
    SELF.corp_trademark_class_desc4_Invalid := Fields.InValid_corp_trademark_class_desc4((SALT38.StrType)le.corp_trademark_class_desc4);
    SELF.corp_trademark_class_desc5_Invalid := Fields.InValid_corp_trademark_class_desc5((SALT38.StrType)le.corp_trademark_class_desc5);
    SELF.corp_trademark_class_desc6_Invalid := Fields.InValid_corp_trademark_class_desc6((SALT38.StrType)le.corp_trademark_class_desc6);
    SELF.corp_term_exist_cd_Invalid := Fields.InValid_corp_term_exist_cd((SALT38.StrType)le.corp_term_exist_cd);
    SELF.corp_term_exist_exp_Invalid := Fields.InValid_corp_term_exist_exp((SALT38.StrType)le.corp_term_exist_exp);
    SELF.corp_status_desc_Invalid := Fields.InValid_corp_status_desc((SALT38.StrType)le.corp_status_desc);
    SELF.corp_status_comment_Invalid := Fields.InValid_corp_status_comment((SALT38.StrType)le.corp_status_comment);
    SELF.corp_trademark_first_use_date_Invalid := Fields.InValid_corp_trademark_first_use_date((SALT38.StrType)le.corp_trademark_first_use_date);
    SELF.corp_trademark_first_use_date_in_state_Invalid := Fields.InValid_corp_trademark_first_use_date_in_state((SALT38.StrType)le.corp_trademark_first_use_date_in_state);
    SELF.corp_trademark_renewal_date_Invalid := Fields.InValid_corp_trademark_renewal_date((SALT38.StrType)le.corp_trademark_renewal_date);
    SELF.cont_title1_desc_Invalid := Fields.InValid_cont_title1_desc((SALT38.StrType)le.cont_title1_desc);
    SELF.recordorigin_Invalid := Fields.InValid_recordorigin((SALT38.StrType)le.recordorigin);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),corp2_mapping.LayoutsCommon.Main);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_vendor_first_reported_Invalid << 0 ) + ( le.dt_vendor_last_reported_Invalid << 2 ) + ( le.dt_first_seen_Invalid << 4 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.corp_ra_dt_first_seen_Invalid << 8 ) + ( le.corp_ra_dt_last_seen_Invalid << 10 ) + ( le.corp_process_date_Invalid << 12 ) + ( le.corp_key_Invalid << 14 ) + ( le.corp_orig_sos_charter_nbr_Invalid << 16 ) + ( le.corp_vendor_Invalid << 18 ) + ( le.corp_state_origin_Invalid << 19 ) + ( le.corp_inc_state_Invalid << 20 ) + ( le.corp_legal_name_Invalid << 21 ) + ( le.corp_ln_name_type_cd_Invalid << 22 ) + ( le.corp_filing_date_Invalid << 23 ) + ( le.corp_inc_date_Invalid << 25 ) + ( le.corp_forgn_date_Invalid << 27 ) + ( le.corp_foreign_domestic_ind_Invalid << 29 ) + ( le.corp_forgn_state_desc_Invalid << 30 ) + ( le.corp_trademark_class_desc1_Invalid << 31 ) + ( le.corp_trademark_class_desc2_Invalid << 32 ) + ( le.corp_trademark_class_desc3_Invalid << 33 ) + ( le.corp_trademark_class_desc4_Invalid << 34 ) + ( le.corp_trademark_class_desc5_Invalid << 35 ) + ( le.corp_trademark_class_desc6_Invalid << 36 ) + ( le.corp_term_exist_cd_Invalid << 37 ) + ( le.corp_term_exist_exp_Invalid << 38 ) + ( le.corp_status_desc_Invalid << 39 ) + ( le.corp_status_comment_Invalid << 40 ) + ( le.corp_trademark_first_use_date_Invalid << 41 ) + ( le.corp_trademark_first_use_date_in_state_Invalid << 43 ) + ( le.corp_trademark_renewal_date_Invalid << 45 ) + ( le.cont_title1_desc_Invalid << 47 ) + ( le.recordorigin_Invalid << 48 );
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
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.corp_orig_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.corp_inc_state_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.corp_legal_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.corp_ln_name_type_cd_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.corp_filing_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.corp_inc_date_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.corp_forgn_date_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.corp_foreign_domestic_ind_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.corp_forgn_state_desc_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.corp_trademark_class_desc1_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.corp_trademark_class_desc2_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.corp_trademark_class_desc3_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.corp_trademark_class_desc4_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.corp_trademark_class_desc5_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.corp_trademark_class_desc6_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.corp_term_exist_cd_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.corp_term_exist_exp_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.corp_status_desc_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.corp_status_comment_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.corp_trademark_first_use_date_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.corp_trademark_first_use_date_in_state_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.corp_trademark_renewal_date_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.cont_title1_desc_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.recordorigin_Invalid := (le.ScrubsBits1 >> 48) & 1;
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
    dt_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    corp_ra_dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=1);
    corp_ra_dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=2);
    corp_ra_dt_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid=3);
    corp_ra_dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_first_seen_Invalid>0);
    corp_ra_dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=1);
    corp_ra_dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=2);
    corp_ra_dt_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid=3);
    corp_ra_dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.corp_ra_dt_last_seen_Invalid>0);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=3);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_orig_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=1);
    corp_orig_sos_charter_nbr_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid=2);
    corp_orig_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_orig_sos_charter_nbr_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_inc_state_ENUM_ErrorCount := COUNT(GROUP,h.corp_inc_state_Invalid=1);
    corp_legal_name_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_legal_name_Invalid=1);
    corp_ln_name_type_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_ln_name_type_cd_Invalid=1);
    corp_filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid=1);
    corp_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid=2);
    corp_filing_date_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid=3);
    corp_filing_date_Total_ErrorCount := COUNT(GROUP,h.corp_filing_date_Invalid>0);
    corp_inc_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=1);
    corp_inc_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=2);
    corp_inc_date_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid=3);
    corp_inc_date_Total_ErrorCount := COUNT(GROUP,h.corp_inc_date_Invalid>0);
    corp_forgn_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=1);
    corp_forgn_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=2);
    corp_forgn_date_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid=3);
    corp_forgn_date_Total_ErrorCount := COUNT(GROUP,h.corp_forgn_date_Invalid>0);
    corp_foreign_domestic_ind_ENUM_ErrorCount := COUNT(GROUP,h.corp_foreign_domestic_ind_Invalid=1);
    corp_forgn_state_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_forgn_state_desc_Invalid=1);
    corp_trademark_class_desc1_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_class_desc1_Invalid=1);
    corp_trademark_class_desc2_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_class_desc2_Invalid=1);
    corp_trademark_class_desc3_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_class_desc3_Invalid=1);
    corp_trademark_class_desc4_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_class_desc4_Invalid=1);
    corp_trademark_class_desc5_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_class_desc5_Invalid=1);
    corp_trademark_class_desc6_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_class_desc6_Invalid=1);
    corp_term_exist_cd_ENUM_ErrorCount := COUNT(GROUP,h.corp_term_exist_cd_Invalid=1);
    corp_term_exist_exp_ALLOW_ErrorCount := COUNT(GROUP,h.corp_term_exist_exp_Invalid=1);
    corp_status_desc_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_desc_Invalid=1);
    corp_status_comment_ALLOW_ErrorCount := COUNT(GROUP,h.corp_status_comment_Invalid=1);
    corp_trademark_first_use_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=1);
    corp_trademark_first_use_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=2);
    corp_trademark_first_use_date_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid=3);
    corp_trademark_first_use_date_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_Invalid>0);
    corp_trademark_first_use_date_in_state_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=1);
    corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=2);
    corp_trademark_first_use_date_in_state_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid=3);
    corp_trademark_first_use_date_in_state_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_first_use_date_in_state_Invalid>0);
    corp_trademark_renewal_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_trademark_renewal_date_Invalid=1);
    corp_trademark_renewal_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_trademark_renewal_date_Invalid=2);
    corp_trademark_renewal_date_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_trademark_renewal_date_Invalid=3);
    corp_trademark_renewal_date_Total_ErrorCount := COUNT(GROUP,h.corp_trademark_renewal_date_Invalid>0);
    cont_title1_desc_ALLOW_ErrorCount := COUNT(GROUP,h.cont_title1_desc_Invalid=1);
    recordorigin_ALLOW_ErrorCount := COUNT(GROUP,h.recordorigin_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.corp_ra_dt_first_seen_Invalid > 0 OR h.corp_ra_dt_last_seen_Invalid > 0 OR h.corp_process_date_Invalid > 0 OR h.corp_key_Invalid > 0 OR h.corp_orig_sos_charter_nbr_Invalid > 0 OR h.corp_vendor_Invalid > 0 OR h.corp_state_origin_Invalid > 0 OR h.corp_inc_state_Invalid > 0 OR h.corp_legal_name_Invalid > 0 OR h.corp_ln_name_type_cd_Invalid > 0 OR h.corp_filing_date_Invalid > 0 OR h.corp_inc_date_Invalid > 0 OR h.corp_forgn_date_Invalid > 0 OR h.corp_foreign_domestic_ind_Invalid > 0 OR h.corp_forgn_state_desc_Invalid > 0 OR h.corp_trademark_class_desc1_Invalid > 0 OR h.corp_trademark_class_desc2_Invalid > 0 OR h.corp_trademark_class_desc3_Invalid > 0 OR h.corp_trademark_class_desc4_Invalid > 0 OR h.corp_trademark_class_desc5_Invalid > 0 OR h.corp_trademark_class_desc6_Invalid > 0 OR h.corp_term_exist_cd_Invalid > 0 OR h.corp_term_exist_exp_Invalid > 0 OR h.corp_status_desc_Invalid > 0 OR h.corp_status_comment_Invalid > 0 OR h.corp_trademark_first_use_date_Invalid > 0 OR h.corp_trademark_first_use_date_in_state_Invalid > 0 OR h.corp_trademark_renewal_date_Invalid > 0 OR h.cont_title1_desc_Invalid > 0 OR h.recordorigin_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_key_Total_ErrorCount > 0, 1, 0) + IF(le.corp_orig_sos_charter_nbr_Total_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_inc_state_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_legal_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_ln_name_type_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_filing_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_foreign_domestic_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_state_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_term_exist_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_term_exist_exp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_status_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_status_comment_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_in_state_Total_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_renewal_date_Total_ErrorCount > 0, 1, 0) + IF(le.cont_title1_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recordorigin_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_ra_dt_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_orig_sos_charter_nbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_inc_state_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_legal_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_ln_name_type_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_filing_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_filing_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_inc_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_foreign_domestic_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_forgn_state_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_class_desc6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_term_exist_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_term_exist_exp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_status_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_status_comment_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_first_use_date_in_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_renewal_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_renewal_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_trademark_renewal_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cont_title1_desc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recordorigin_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.corp_ra_dt_first_seen_Invalid,le.corp_ra_dt_last_seen_Invalid,le.corp_process_date_Invalid,le.corp_key_Invalid,le.corp_orig_sos_charter_nbr_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_inc_state_Invalid,le.corp_legal_name_Invalid,le.corp_ln_name_type_cd_Invalid,le.corp_filing_date_Invalid,le.corp_inc_date_Invalid,le.corp_forgn_date_Invalid,le.corp_foreign_domestic_ind_Invalid,le.corp_forgn_state_desc_Invalid,le.corp_trademark_class_desc1_Invalid,le.corp_trademark_class_desc2_Invalid,le.corp_trademark_class_desc3_Invalid,le.corp_trademark_class_desc4_Invalid,le.corp_trademark_class_desc5_Invalid,le.corp_trademark_class_desc6_Invalid,le.corp_term_exist_cd_Invalid,le.corp_term_exist_exp_Invalid,le.corp_status_desc_Invalid,le.corp_status_comment_Invalid,le.corp_trademark_first_use_date_Invalid,le.corp_trademark_first_use_date_in_state_Invalid,le.corp_trademark_renewal_date_Invalid,le.cont_title1_desc_Invalid,le.recordorigin_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_first_seen(le.corp_ra_dt_first_seen_Invalid),Fields.InvalidMessage_corp_ra_dt_last_seen(le.corp_ra_dt_last_seen_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_inc_state(le.corp_inc_state_Invalid),Fields.InvalidMessage_corp_legal_name(le.corp_legal_name_Invalid),Fields.InvalidMessage_corp_ln_name_type_cd(le.corp_ln_name_type_cd_Invalid),Fields.InvalidMessage_corp_filing_date(le.corp_filing_date_Invalid),Fields.InvalidMessage_corp_inc_date(le.corp_inc_date_Invalid),Fields.InvalidMessage_corp_forgn_date(le.corp_forgn_date_Invalid),Fields.InvalidMessage_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind_Invalid),Fields.InvalidMessage_corp_forgn_state_desc(le.corp_forgn_state_desc_Invalid),Fields.InvalidMessage_corp_trademark_class_desc1(le.corp_trademark_class_desc1_Invalid),Fields.InvalidMessage_corp_trademark_class_desc2(le.corp_trademark_class_desc2_Invalid),Fields.InvalidMessage_corp_trademark_class_desc3(le.corp_trademark_class_desc3_Invalid),Fields.InvalidMessage_corp_trademark_class_desc4(le.corp_trademark_class_desc4_Invalid),Fields.InvalidMessage_corp_trademark_class_desc5(le.corp_trademark_class_desc5_Invalid),Fields.InvalidMessage_corp_trademark_class_desc6(le.corp_trademark_class_desc6_Invalid),Fields.InvalidMessage_corp_term_exist_cd(le.corp_term_exist_cd_Invalid),Fields.InvalidMessage_corp_term_exist_exp(le.corp_term_exist_exp_Invalid),Fields.InvalidMessage_corp_status_desc(le.corp_status_desc_Invalid),Fields.InvalidMessage_corp_status_comment(le.corp_status_comment_Invalid),Fields.InvalidMessage_corp_trademark_first_use_date(le.corp_trademark_first_use_date_Invalid),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(le.corp_trademark_first_use_date_in_state_Invalid),Fields.InvalidMessage_corp_trademark_renewal_date(le.corp_trademark_renewal_date_Invalid),Fields.InvalidMessage_cont_title1_desc(le.cont_title1_desc_Invalid),Fields.InvalidMessage_recordorigin(le.recordorigin_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_ra_dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_orig_sos_charter_nbr_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_inc_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_legal_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_ln_name_type_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_filing_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_inc_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_forgn_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_foreign_domestic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_forgn_state_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_class_desc1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_class_desc2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_class_desc3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_class_desc4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_class_desc5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_class_desc6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_term_exist_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_term_exist_exp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_status_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_status_comment_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.corp_trademark_first_use_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_trademark_first_use_date_in_state_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_trademark_renewal_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cont_title1_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recordorigin_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_inc_state','corp_legal_name','corp_ln_name_type_cd','corp_filing_date','corp_inc_date','corp_forgn_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_trademark_class_desc1','corp_trademark_class_desc2','corp_trademark_class_desc3','corp_trademark_class_desc4','corp_trademark_class_desc5','corp_trademark_class_desc6','corp_term_exist_cd','corp_term_exist_exp','corp_status_desc','corp_status_comment','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_renewal_date','cont_title1_desc','recordorigin','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_corp_key','invalid_charter_nbr','invalid_corp_vendor','invalid_state_origin','invalid_state_origin','invalid_mandatory','invalid_name_type_cd','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_forgn_dom_code','invalid_characters','invalid_characters_ext','invalid_characters_ext','invalid_characters_ext','invalid_characters_ext','invalid_characters_ext','invalid_characters_ext','invalid_term_cd','invalid_term_exp','invalid_characters','invalid_characters','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_characters_ext','invalid_recordorigin','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.dt_first_seen,(SALT38.StrType)le.dt_last_seen,(SALT38.StrType)le.corp_ra_dt_first_seen,(SALT38.StrType)le.corp_ra_dt_last_seen,(SALT38.StrType)le.corp_process_date,(SALT38.StrType)le.corp_key,(SALT38.StrType)le.corp_orig_sos_charter_nbr,(SALT38.StrType)le.corp_vendor,(SALT38.StrType)le.corp_state_origin,(SALT38.StrType)le.corp_inc_state,(SALT38.StrType)le.corp_legal_name,(SALT38.StrType)le.corp_ln_name_type_cd,(SALT38.StrType)le.corp_filing_date,(SALT38.StrType)le.corp_inc_date,(SALT38.StrType)le.corp_forgn_date,(SALT38.StrType)le.corp_foreign_domestic_ind,(SALT38.StrType)le.corp_forgn_state_desc,(SALT38.StrType)le.corp_trademark_class_desc1,(SALT38.StrType)le.corp_trademark_class_desc2,(SALT38.StrType)le.corp_trademark_class_desc3,(SALT38.StrType)le.corp_trademark_class_desc4,(SALT38.StrType)le.corp_trademark_class_desc5,(SALT38.StrType)le.corp_trademark_class_desc6,(SALT38.StrType)le.corp_term_exist_cd,(SALT38.StrType)le.corp_term_exist_exp,(SALT38.StrType)le.corp_status_desc,(SALT38.StrType)le.corp_status_comment,(SALT38.StrType)le.corp_trademark_first_use_date,(SALT38.StrType)le.corp_trademark_first_use_date_in_state,(SALT38.StrType)le.corp_trademark_renewal_date,(SALT38.StrType)le.cont_title1_desc,(SALT38.StrType)le.recordorigin,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,34,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(corp2_mapping.LayoutsCommon.Main) prevDS = DATASET([], corp2_mapping.LayoutsCommon.Main), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_vendor_first_reported:invalid_date:ALLOW','dt_vendor_first_reported:invalid_date:CUSTOM','dt_vendor_first_reported:invalid_date:LENGTHS'
          ,'dt_vendor_last_reported:invalid_date:ALLOW','dt_vendor_last_reported:invalid_date:CUSTOM','dt_vendor_last_reported:invalid_date:LENGTHS'
          ,'dt_first_seen:invalid_date:ALLOW','dt_first_seen:invalid_date:CUSTOM','dt_first_seen:invalid_date:LENGTHS'
          ,'dt_last_seen:invalid_date:ALLOW','dt_last_seen:invalid_date:CUSTOM','dt_last_seen:invalid_date:LENGTHS'
          ,'corp_ra_dt_first_seen:invalid_date:ALLOW','corp_ra_dt_first_seen:invalid_date:CUSTOM','corp_ra_dt_first_seen:invalid_date:LENGTHS'
          ,'corp_ra_dt_last_seen:invalid_date:ALLOW','corp_ra_dt_last_seen:invalid_date:CUSTOM','corp_ra_dt_last_seen:invalid_date:LENGTHS'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM','corp_process_date:invalid_date:LENGTHS'
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTHS'
          ,'corp_orig_sos_charter_nbr:invalid_charter_nbr:ALLOW','corp_orig_sos_charter_nbr:invalid_charter_nbr:LENGTHS'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_inc_state:invalid_state_origin:ENUM'
          ,'corp_legal_name:invalid_mandatory:LENGTHS'
          ,'corp_ln_name_type_cd:invalid_name_type_cd:CUSTOM'
          ,'corp_filing_date:invalid_optional_date:ALLOW','corp_filing_date:invalid_optional_date:CUSTOM','corp_filing_date:invalid_optional_date:LENGTHS'
          ,'corp_inc_date:invalid_optional_date:ALLOW','corp_inc_date:invalid_optional_date:CUSTOM','corp_inc_date:invalid_optional_date:LENGTHS'
          ,'corp_forgn_date:invalid_optional_date:ALLOW','corp_forgn_date:invalid_optional_date:CUSTOM','corp_forgn_date:invalid_optional_date:LENGTHS'
          ,'corp_foreign_domestic_ind:invalid_forgn_dom_code:ENUM'
          ,'corp_forgn_state_desc:invalid_characters:ALLOW'
          ,'corp_trademark_class_desc1:invalid_characters_ext:ALLOW'
          ,'corp_trademark_class_desc2:invalid_characters_ext:ALLOW'
          ,'corp_trademark_class_desc3:invalid_characters_ext:ALLOW'
          ,'corp_trademark_class_desc4:invalid_characters_ext:ALLOW'
          ,'corp_trademark_class_desc5:invalid_characters_ext:ALLOW'
          ,'corp_trademark_class_desc6:invalid_characters_ext:ALLOW'
          ,'corp_term_exist_cd:invalid_term_cd:ENUM'
          ,'corp_term_exist_exp:invalid_term_exp:ALLOW'
          ,'corp_status_desc:invalid_characters:ALLOW'
          ,'corp_status_comment:invalid_characters:ALLOW'
          ,'corp_trademark_first_use_date:invalid_optional_date:ALLOW','corp_trademark_first_use_date:invalid_optional_date:CUSTOM','corp_trademark_first_use_date:invalid_optional_date:LENGTHS'
          ,'corp_trademark_first_use_date_in_state:invalid_optional_date:ALLOW','corp_trademark_first_use_date_in_state:invalid_optional_date:CUSTOM','corp_trademark_first_use_date_in_state:invalid_optional_date:LENGTHS'
          ,'corp_trademark_renewal_date:invalid_optional_date:ALLOW','corp_trademark_renewal_date:invalid_optional_date:CUSTOM','corp_trademark_renewal_date:invalid_optional_date:LENGTHS'
          ,'cont_title1_desc:invalid_characters_ext:ALLOW'
          ,'recordorigin:invalid_recordorigin:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_ra_dt_first_seen(1),Fields.InvalidMessage_corp_ra_dt_first_seen(2),Fields.InvalidMessage_corp_ra_dt_first_seen(3)
          ,Fields.InvalidMessage_corp_ra_dt_last_seen(1),Fields.InvalidMessage_corp_ra_dt_last_seen(2),Fields.InvalidMessage_corp_ra_dt_last_seen(3)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2),Fields.InvalidMessage_corp_process_date(3)
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_orig_sos_charter_nbr(1),Fields.InvalidMessage_corp_orig_sos_charter_nbr(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_inc_state(1)
          ,Fields.InvalidMessage_corp_legal_name(1)
          ,Fields.InvalidMessage_corp_ln_name_type_cd(1)
          ,Fields.InvalidMessage_corp_filing_date(1),Fields.InvalidMessage_corp_filing_date(2),Fields.InvalidMessage_corp_filing_date(3)
          ,Fields.InvalidMessage_corp_inc_date(1),Fields.InvalidMessage_corp_inc_date(2),Fields.InvalidMessage_corp_inc_date(3)
          ,Fields.InvalidMessage_corp_forgn_date(1),Fields.InvalidMessage_corp_forgn_date(2),Fields.InvalidMessage_corp_forgn_date(3)
          ,Fields.InvalidMessage_corp_foreign_domestic_ind(1)
          ,Fields.InvalidMessage_corp_forgn_state_desc(1)
          ,Fields.InvalidMessage_corp_trademark_class_desc1(1)
          ,Fields.InvalidMessage_corp_trademark_class_desc2(1)
          ,Fields.InvalidMessage_corp_trademark_class_desc3(1)
          ,Fields.InvalidMessage_corp_trademark_class_desc4(1)
          ,Fields.InvalidMessage_corp_trademark_class_desc5(1)
          ,Fields.InvalidMessage_corp_trademark_class_desc6(1)
          ,Fields.InvalidMessage_corp_term_exist_cd(1)
          ,Fields.InvalidMessage_corp_term_exist_exp(1)
          ,Fields.InvalidMessage_corp_status_desc(1)
          ,Fields.InvalidMessage_corp_status_comment(1)
          ,Fields.InvalidMessage_corp_trademark_first_use_date(1),Fields.InvalidMessage_corp_trademark_first_use_date(2),Fields.InvalidMessage_corp_trademark_first_use_date(3)
          ,Fields.InvalidMessage_corp_trademark_first_use_date_in_state(1),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(2),Fields.InvalidMessage_corp_trademark_first_use_date_in_state(3)
          ,Fields.InvalidMessage_corp_trademark_renewal_date(1),Fields.InvalidMessage_corp_trademark_renewal_date(2),Fields.InvalidMessage_corp_trademark_renewal_date(3)
          ,Fields.InvalidMessage_cont_title1_desc(1)
          ,Fields.InvalidMessage_recordorigin(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTHS_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTHS_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTHS_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTHS_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTHS_ErrorCount
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTHS_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTHS_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_legal_name_LENGTHS_ErrorCount
          ,le.corp_ln_name_type_cd_CUSTOM_ErrorCount
          ,le.corp_filing_date_ALLOW_ErrorCount,le.corp_filing_date_CUSTOM_ErrorCount,le.corp_filing_date_LENGTHS_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTHS_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount,le.corp_forgn_date_LENGTHS_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc1_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc2_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc3_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc4_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc5_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc6_ALLOW_ErrorCount
          ,le.corp_term_exist_cd_ENUM_ErrorCount
          ,le.corp_term_exist_exp_ALLOW_ErrorCount
          ,le.corp_status_desc_ALLOW_ErrorCount
          ,le.corp_status_comment_ALLOW_ErrorCount
          ,le.corp_trademark_first_use_date_ALLOW_ErrorCount,le.corp_trademark_first_use_date_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_LENGTHS_ErrorCount
          ,le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount,le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_in_state_LENGTHS_ErrorCount
          ,le.corp_trademark_renewal_date_ALLOW_ErrorCount,le.corp_trademark_renewal_date_CUSTOM_ErrorCount,le.corp_trademark_renewal_date_LENGTHS_ErrorCount
          ,le.cont_title1_desc_ALLOW_ErrorCount
          ,le.recordorigin_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTHS_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTHS_ErrorCount
          ,le.corp_ra_dt_first_seen_ALLOW_ErrorCount,le.corp_ra_dt_first_seen_CUSTOM_ErrorCount,le.corp_ra_dt_first_seen_LENGTHS_ErrorCount
          ,le.corp_ra_dt_last_seen_ALLOW_ErrorCount,le.corp_ra_dt_last_seen_CUSTOM_ErrorCount,le.corp_ra_dt_last_seen_LENGTHS_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount,le.corp_process_date_LENGTHS_ErrorCount
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTHS_ErrorCount
          ,le.corp_orig_sos_charter_nbr_ALLOW_ErrorCount,le.corp_orig_sos_charter_nbr_LENGTHS_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_inc_state_ENUM_ErrorCount
          ,le.corp_legal_name_LENGTHS_ErrorCount
          ,le.corp_ln_name_type_cd_CUSTOM_ErrorCount
          ,le.corp_filing_date_ALLOW_ErrorCount,le.corp_filing_date_CUSTOM_ErrorCount,le.corp_filing_date_LENGTHS_ErrorCount
          ,le.corp_inc_date_ALLOW_ErrorCount,le.corp_inc_date_CUSTOM_ErrorCount,le.corp_inc_date_LENGTHS_ErrorCount
          ,le.corp_forgn_date_ALLOW_ErrorCount,le.corp_forgn_date_CUSTOM_ErrorCount,le.corp_forgn_date_LENGTHS_ErrorCount
          ,le.corp_foreign_domestic_ind_ENUM_ErrorCount
          ,le.corp_forgn_state_desc_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc1_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc2_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc3_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc4_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc5_ALLOW_ErrorCount
          ,le.corp_trademark_class_desc6_ALLOW_ErrorCount
          ,le.corp_term_exist_cd_ENUM_ErrorCount
          ,le.corp_term_exist_exp_ALLOW_ErrorCount
          ,le.corp_status_desc_ALLOW_ErrorCount
          ,le.corp_status_comment_ALLOW_ErrorCount
          ,le.corp_trademark_first_use_date_ALLOW_ErrorCount,le.corp_trademark_first_use_date_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_LENGTHS_ErrorCount
          ,le.corp_trademark_first_use_date_in_state_ALLOW_ErrorCount,le.corp_trademark_first_use_date_in_state_CUSTOM_ErrorCount,le.corp_trademark_first_use_date_in_state_LENGTHS_ErrorCount
          ,le.corp_trademark_renewal_date_ALLOW_ErrorCount,le.corp_trademark_renewal_date_CUSTOM_ErrorCount,le.corp_trademark_renewal_date_LENGTHS_ErrorCount
          ,le.cont_title1_desc_ALLOW_ErrorCount
          ,le.recordorigin_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, corp2_mapping.LayoutsCommon.Main));
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
          ,'corp_process_date:' + getFieldTypeText(h.corp_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_key:' + getFieldTypeText(h.corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_orig_sos_charter_nbr:' + getFieldTypeText(h.corp_orig_sos_charter_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor:' + getFieldTypeText(h.corp_vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_state_origin:' + getFieldTypeText(h.corp_state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_inc_state:' + getFieldTypeText(h.corp_inc_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_legal_name:' + getFieldTypeText(h.corp_legal_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_ln_name_type_cd:' + getFieldTypeText(h.corp_ln_name_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_filing_date:' + getFieldTypeText(h.corp_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_inc_date:' + getFieldTypeText(h.corp_inc_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_date:' + getFieldTypeText(h.corp_forgn_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_foreign_domestic_ind:' + getFieldTypeText(h.corp_foreign_domestic_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_forgn_state_desc:' + getFieldTypeText(h.corp_forgn_state_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc1:' + getFieldTypeText(h.corp_trademark_class_desc1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc2:' + getFieldTypeText(h.corp_trademark_class_desc2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc3:' + getFieldTypeText(h.corp_trademark_class_desc3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc4:' + getFieldTypeText(h.corp_trademark_class_desc4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc5:' + getFieldTypeText(h.corp_trademark_class_desc5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_class_desc6:' + getFieldTypeText(h.corp_trademark_class_desc6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_term_exist_cd:' + getFieldTypeText(h.corp_term_exist_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_term_exist_exp:' + getFieldTypeText(h.corp_term_exist_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_status_desc:' + getFieldTypeText(h.corp_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_status_comment:' + getFieldTypeText(h.corp_status_comment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_first_use_date:' + getFieldTypeText(h.corp_trademark_first_use_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_first_use_date_in_state:' + getFieldTypeText(h.corp_trademark_first_use_date_in_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_trademark_renewal_date:' + getFieldTypeText(h.corp_trademark_renewal_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cont_title1_desc:' + getFieldTypeText(h.cont_title1_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recordorigin:' + getFieldTypeText(h.recordorigin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_corp_ra_dt_first_seen_cnt
          ,le.populated_corp_ra_dt_last_seen_cnt
          ,le.populated_corp_process_date_cnt
          ,le.populated_corp_key_cnt
          ,le.populated_corp_orig_sos_charter_nbr_cnt
          ,le.populated_corp_vendor_cnt
          ,le.populated_corp_state_origin_cnt
          ,le.populated_corp_inc_state_cnt
          ,le.populated_corp_legal_name_cnt
          ,le.populated_corp_ln_name_type_cd_cnt
          ,le.populated_corp_filing_date_cnt
          ,le.populated_corp_inc_date_cnt
          ,le.populated_corp_forgn_date_cnt
          ,le.populated_corp_foreign_domestic_ind_cnt
          ,le.populated_corp_forgn_state_desc_cnt
          ,le.populated_corp_trademark_class_desc1_cnt
          ,le.populated_corp_trademark_class_desc2_cnt
          ,le.populated_corp_trademark_class_desc3_cnt
          ,le.populated_corp_trademark_class_desc4_cnt
          ,le.populated_corp_trademark_class_desc5_cnt
          ,le.populated_corp_trademark_class_desc6_cnt
          ,le.populated_corp_term_exist_cd_cnt
          ,le.populated_corp_term_exist_exp_cnt
          ,le.populated_corp_status_desc_cnt
          ,le.populated_corp_status_comment_cnt
          ,le.populated_corp_trademark_first_use_date_cnt
          ,le.populated_corp_trademark_first_use_date_in_state_cnt
          ,le.populated_corp_trademark_renewal_date_cnt
          ,le.populated_cont_title1_desc_cnt
          ,le.populated_recordorigin_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_corp_ra_dt_first_seen_pcnt
          ,le.populated_corp_ra_dt_last_seen_pcnt
          ,le.populated_corp_process_date_pcnt
          ,le.populated_corp_key_pcnt
          ,le.populated_corp_orig_sos_charter_nbr_pcnt
          ,le.populated_corp_vendor_pcnt
          ,le.populated_corp_state_origin_pcnt
          ,le.populated_corp_inc_state_pcnt
          ,le.populated_corp_legal_name_pcnt
          ,le.populated_corp_ln_name_type_cd_pcnt
          ,le.populated_corp_filing_date_pcnt
          ,le.populated_corp_inc_date_pcnt
          ,le.populated_corp_forgn_date_pcnt
          ,le.populated_corp_foreign_domestic_ind_pcnt
          ,le.populated_corp_forgn_state_desc_pcnt
          ,le.populated_corp_trademark_class_desc1_pcnt
          ,le.populated_corp_trademark_class_desc2_pcnt
          ,le.populated_corp_trademark_class_desc3_pcnt
          ,le.populated_corp_trademark_class_desc4_pcnt
          ,le.populated_corp_trademark_class_desc5_pcnt
          ,le.populated_corp_trademark_class_desc6_pcnt
          ,le.populated_corp_term_exist_cd_pcnt
          ,le.populated_corp_term_exist_exp_pcnt
          ,le.populated_corp_status_desc_pcnt
          ,le.populated_corp_status_comment_pcnt
          ,le.populated_corp_trademark_first_use_date_pcnt
          ,le.populated_corp_trademark_first_use_date_in_state_pcnt
          ,le.populated_corp_trademark_renewal_date_pcnt
          ,le.populated_cont_title1_desc_pcnt
          ,le.populated_recordorigin_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,34,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, corp2_mapping.LayoutsCommon.Main));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),34,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(corp2_mapping.LayoutsCommon.Main) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Corp2_Mapping_MT_Main, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

