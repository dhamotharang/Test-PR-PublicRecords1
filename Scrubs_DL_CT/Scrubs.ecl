IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_DL_CT; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_CT)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 orig_dlstate_Invalid;
    UNSIGNED1 orig_dlnumber_Invalid;
    UNSIGNED1 orig_name_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_sex_Invalid;
    UNSIGNED1 orig_height1_Invalid;
    UNSIGNED1 orig_height2_Invalid;
    UNSIGNED1 orig_eye_color_Invalid;
    UNSIGNED1 orig_mailaddress_Invalid;
    UNSIGNED1 orig_classification_Invalid;
    UNSIGNED1 orig_issue_date_Invalid;
    UNSIGNED1 orig_issue_date_dd_Invalid;
    UNSIGNED1 orig_expire_date_Invalid;
    UNSIGNED1 orig_expire_date_dd_Invalid;
    UNSIGNED1 orig_noncdlstatus_Invalid;
    UNSIGNED1 orig_cdlstatus_Invalid;
    UNSIGNED1 orig_restrictions_Invalid;
    UNSIGNED1 orig_origdate_Invalid;
    UNSIGNED1 orig_origcdldate_Invalid;
    UNSIGNED1 orig_cancelst_Invalid;
    UNSIGNED1 orig_canceldate_Invalid;
    UNSIGNED1 clean_name_last_Invalid;
    UNSIGNED1 clean_prim_range_Invalid;
    UNSIGNED1 clean_predir_Invalid;
    UNSIGNED1 clean_prim_name_Invalid;
    UNSIGNED1 clean_addr_suffix_Invalid;
    UNSIGNED1 clean_postdir_Invalid;
    UNSIGNED1 clean_unit_desig_Invalid;
    UNSIGNED1 clean_sec_range_Invalid;
    UNSIGNED1 clean_p_city_name_Invalid;
    UNSIGNED1 clean_v_city_name_Invalid;
    UNSIGNED1 clean_st_Invalid;
    UNSIGNED1 clean_zip_Invalid;
    UNSIGNED1 clean_zip4_Invalid;
    UNSIGNED1 clean_cart_Invalid;
    UNSIGNED1 clean_cr_sort_sz_Invalid;
    UNSIGNED1 clean_lot_Invalid;
    UNSIGNED1 clean_lot_order_Invalid;
    UNSIGNED1 clean_dpbc_Invalid;
    UNSIGNED1 clean_chk_digit_Invalid;
    UNSIGNED1 clean_record_type_Invalid;
    UNSIGNED1 clean_ace_fips_st_Invalid;
    UNSIGNED1 clean_fipscounty_Invalid;
    UNSIGNED1 clean_geo_lat_Invalid;
    UNSIGNED1 clean_geo_long_Invalid;
    UNSIGNED1 clean_msa_Invalid;
    UNSIGNED1 clean_geo_blk_Invalid;
    UNSIGNED1 clean_geo_match_Invalid;
    UNSIGNED1 clean_err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_CT)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_CT) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT34.StrType)le.append_process_date);
    SELF.orig_dlstate_Invalid := Fields.InValid_orig_dlstate((SALT34.StrType)le.orig_dlstate);
    SELF.orig_dlnumber_Invalid := Fields.InValid_orig_dlnumber((SALT34.StrType)le.orig_dlnumber);
    SELF.orig_name_Invalid := Fields.InValid_orig_name((SALT34.StrType)le.orig_name);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT34.StrType)le.orig_dob);
    SELF.orig_sex_Invalid := Fields.InValid_orig_sex((SALT34.StrType)le.orig_sex);
    SELF.orig_height1_Invalid := Fields.InValid_orig_height1((SALT34.StrType)le.orig_height1,(SALT34.StrType)le.orig_height2);
    SELF.orig_height2_Invalid := Fields.InValid_orig_height2((SALT34.StrType)le.orig_height2);
    SELF.orig_eye_color_Invalid := Fields.InValid_orig_eye_color((SALT34.StrType)le.orig_eye_color);
    SELF.orig_mailaddress_Invalid := Fields.InValid_orig_mailaddress((SALT34.StrType)le.orig_mailaddress);
    SELF.orig_classification_Invalid := Fields.InValid_orig_classification((SALT34.StrType)le.orig_classification);
    SELF.orig_issue_date_Invalid := Fields.InValid_orig_issue_date((SALT34.StrType)le.orig_issue_date,(SALT34.StrType)le.orig_issue_date_dd);
    SELF.orig_issue_date_dd_Invalid := Fields.InValid_orig_issue_date_dd((SALT34.StrType)le.orig_issue_date_dd);
    SELF.orig_expire_date_Invalid := Fields.InValid_orig_expire_date((SALT34.StrType)le.orig_expire_date,(SALT34.StrType)le.orig_expire_date_dd);
    SELF.orig_expire_date_dd_Invalid := Fields.InValid_orig_expire_date_dd((SALT34.StrType)le.orig_expire_date_dd);
    SELF.orig_noncdlstatus_Invalid := Fields.InValid_orig_noncdlstatus((SALT34.StrType)le.orig_noncdlstatus);
    SELF.orig_cdlstatus_Invalid := Fields.InValid_orig_cdlstatus((SALT34.StrType)le.orig_cdlstatus);
    SELF.orig_restrictions_Invalid := Fields.InValid_orig_restrictions((SALT34.StrType)le.orig_restrictions);
    SELF.orig_origdate_Invalid := Fields.InValid_orig_origdate((SALT34.StrType)le.orig_origdate);
    SELF.orig_origcdldate_Invalid := Fields.InValid_orig_origcdldate((SALT34.StrType)le.orig_origcdldate);
    SELF.orig_cancelst_Invalid := Fields.InValid_orig_cancelst((SALT34.StrType)le.orig_cancelst);
    SELF.orig_canceldate_Invalid := Fields.InValid_orig_canceldate((SALT34.StrType)le.orig_canceldate);
    SELF.clean_name_last_Invalid := Fields.InValid_clean_name_last((SALT34.StrType)le.clean_name_last,(SALT34.StrType)le.clean_name_first,(SALT34.StrType)le.clean_name_middle);
    SELF.clean_prim_range_Invalid := Fields.InValid_clean_prim_range((SALT34.StrType)le.clean_prim_range);
    SELF.clean_predir_Invalid := Fields.InValid_clean_predir((SALT34.StrType)le.clean_predir);
    SELF.clean_prim_name_Invalid := Fields.InValid_clean_prim_name((SALT34.StrType)le.clean_prim_name);
    SELF.clean_addr_suffix_Invalid := Fields.InValid_clean_addr_suffix((SALT34.StrType)le.clean_addr_suffix);
    SELF.clean_postdir_Invalid := Fields.InValid_clean_postdir((SALT34.StrType)le.clean_postdir);
    SELF.clean_unit_desig_Invalid := Fields.InValid_clean_unit_desig((SALT34.StrType)le.clean_unit_desig);
    SELF.clean_sec_range_Invalid := Fields.InValid_clean_sec_range((SALT34.StrType)le.clean_sec_range);
    SELF.clean_p_city_name_Invalid := Fields.InValid_clean_p_city_name((SALT34.StrType)le.clean_p_city_name);
    SELF.clean_v_city_name_Invalid := Fields.InValid_clean_v_city_name((SALT34.StrType)le.clean_v_city_name);
    SELF.clean_st_Invalid := Fields.InValid_clean_st((SALT34.StrType)le.clean_st);
    SELF.clean_zip_Invalid := Fields.InValid_clean_zip((SALT34.StrType)le.clean_zip);
    SELF.clean_zip4_Invalid := Fields.InValid_clean_zip4((SALT34.StrType)le.clean_zip4);
    SELF.clean_cart_Invalid := Fields.InValid_clean_cart((SALT34.StrType)le.clean_cart);
    SELF.clean_cr_sort_sz_Invalid := Fields.InValid_clean_cr_sort_sz((SALT34.StrType)le.clean_cr_sort_sz);
    SELF.clean_lot_Invalid := Fields.InValid_clean_lot((SALT34.StrType)le.clean_lot);
    SELF.clean_lot_order_Invalid := Fields.InValid_clean_lot_order((SALT34.StrType)le.clean_lot_order);
    SELF.clean_dpbc_Invalid := Fields.InValid_clean_dpbc((SALT34.StrType)le.clean_dpbc);
    SELF.clean_chk_digit_Invalid := Fields.InValid_clean_chk_digit((SALT34.StrType)le.clean_chk_digit);
    SELF.clean_record_type_Invalid := Fields.InValid_clean_record_type((SALT34.StrType)le.clean_record_type);
    SELF.clean_ace_fips_st_Invalid := Fields.InValid_clean_ace_fips_st((SALT34.StrType)le.clean_ace_fips_st);
    SELF.clean_fipscounty_Invalid := Fields.InValid_clean_fipscounty((SALT34.StrType)le.clean_fipscounty);
    SELF.clean_geo_lat_Invalid := Fields.InValid_clean_geo_lat((SALT34.StrType)le.clean_geo_lat);
    SELF.clean_geo_long_Invalid := Fields.InValid_clean_geo_long((SALT34.StrType)le.clean_geo_long);
    SELF.clean_msa_Invalid := Fields.InValid_clean_msa((SALT34.StrType)le.clean_msa);
    SELF.clean_geo_blk_Invalid := Fields.InValid_clean_geo_blk((SALT34.StrType)le.clean_geo_blk);
    SELF.clean_geo_match_Invalid := Fields.InValid_clean_geo_match((SALT34.StrType)le.clean_geo_match);
    SELF.clean_err_stat_Invalid := Fields.InValid_clean_err_stat((SALT34.StrType)le.clean_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_CT);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.orig_dlstate_Invalid << 2 ) + ( le.orig_dlnumber_Invalid << 3 ) + ( le.orig_name_Invalid << 5 ) + ( le.orig_dob_Invalid << 7 ) + ( le.orig_sex_Invalid << 9 ) + ( le.orig_height1_Invalid << 10 ) + ( le.orig_height2_Invalid << 11 ) + ( le.orig_eye_color_Invalid << 12 ) + ( le.orig_mailaddress_Invalid << 13 ) + ( le.orig_classification_Invalid << 15 ) + ( le.orig_issue_date_Invalid << 16 ) + ( le.orig_issue_date_dd_Invalid << 18 ) + ( le.orig_expire_date_Invalid << 19 ) + ( le.orig_expire_date_dd_Invalid << 21 ) + ( le.orig_noncdlstatus_Invalid << 22 ) + ( le.orig_cdlstatus_Invalid << 23 ) + ( le.orig_restrictions_Invalid << 24 ) + ( le.orig_origdate_Invalid << 25 ) + ( le.orig_origcdldate_Invalid << 27 ) + ( le.orig_cancelst_Invalid << 29 ) + ( le.orig_canceldate_Invalid << 31 ) + ( le.clean_name_last_Invalid << 33 ) + ( le.clean_prim_range_Invalid << 35 ) + ( le.clean_predir_Invalid << 36 ) + ( le.clean_prim_name_Invalid << 37 ) + ( le.clean_addr_suffix_Invalid << 38 ) + ( le.clean_postdir_Invalid << 39 ) + ( le.clean_unit_desig_Invalid << 40 ) + ( le.clean_sec_range_Invalid << 41 ) + ( le.clean_p_city_name_Invalid << 42 ) + ( le.clean_v_city_name_Invalid << 43 ) + ( le.clean_st_Invalid << 44 ) + ( le.clean_zip_Invalid << 45 ) + ( le.clean_zip4_Invalid << 46 ) + ( le.clean_cart_Invalid << 47 ) + ( le.clean_cr_sort_sz_Invalid << 48 ) + ( le.clean_lot_Invalid << 49 ) + ( le.clean_lot_order_Invalid << 50 ) + ( le.clean_dpbc_Invalid << 51 ) + ( le.clean_chk_digit_Invalid << 52 ) + ( le.clean_record_type_Invalid << 53 ) + ( le.clean_ace_fips_st_Invalid << 54 ) + ( le.clean_fipscounty_Invalid << 55 ) + ( le.clean_geo_lat_Invalid << 56 ) + ( le.clean_geo_long_Invalid << 57 ) + ( le.clean_msa_Invalid << 58 ) + ( le.clean_geo_blk_Invalid << 59 ) + ( le.clean_geo_match_Invalid << 60 ) + ( le.clean_err_stat_Invalid << 61 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_CT);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_dlstate_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_dlnumber_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.orig_name_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.orig_sex_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_height1_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_height2_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_eye_color_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_mailaddress_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.orig_classification_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_issue_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_issue_date_dd_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_expire_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.orig_expire_date_dd_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.orig_noncdlstatus_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.orig_cdlstatus_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.orig_restrictions_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.orig_origdate_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.orig_origcdldate_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.orig_cancelst_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.orig_canceldate_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.clean_name_last_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.clean_prim_range_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.clean_predir_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.clean_prim_name_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_addr_suffix_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.clean_postdir_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.clean_unit_desig_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.clean_sec_range_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.clean_p_city_name_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.clean_v_city_name_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.clean_st_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.clean_zip_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.clean_zip4_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.clean_cart_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.clean_cr_sort_sz_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.clean_lot_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.clean_lot_order_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.clean_dpbc_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_chk_digit_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_record_type_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.clean_ace_fips_st_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.clean_fipscounty_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.clean_geo_lat_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.clean_geo_long_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.clean_msa_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.clean_geo_blk_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.clean_geo_match_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.clean_err_stat_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    append_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=2);
    append_process_date_Total_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid>0);
    orig_dlstate_ENUM_ErrorCount := COUNT(GROUP,h.orig_dlstate_Invalid=1);
    orig_dlnumber_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dlnumber_Invalid=1);
    orig_dlnumber_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dlnumber_Invalid=2);
    orig_dlnumber_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dlnumber_Invalid=3);
    orig_dlnumber_Total_ErrorCount := COUNT(GROUP,h.orig_dlnumber_Invalid>0);
    orig_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=1);
    orig_name_LENGTH_ErrorCount := COUNT(GROUP,h.orig_name_Invalid=2);
    orig_name_Total_ErrorCount := COUNT(GROUP,h.orig_name_Invalid>0);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_sex_ENUM_ErrorCount := COUNT(GROUP,h.orig_sex_Invalid=1);
    orig_height1_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_height1_Invalid=1);
    orig_height2_ENUM_ErrorCount := COUNT(GROUP,h.orig_height2_Invalid=1);
    orig_eye_color_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_eye_color_Invalid=1);
    orig_mailaddress_CAPS_ErrorCount := COUNT(GROUP,h.orig_mailaddress_Invalid=1);
    orig_mailaddress_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mailaddress_Invalid=2);
    orig_mailaddress_Total_ErrorCount := COUNT(GROUP,h.orig_mailaddress_Invalid>0);
    orig_classification_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_classification_Invalid=1);
    orig_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid=1);
    orig_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid=2);
    orig_issue_date_Total_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid>0);
    orig_issue_date_dd_ENUM_ErrorCount := COUNT(GROUP,h.orig_issue_date_dd_Invalid=1);
    orig_expire_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid=1);
    orig_expire_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid=2);
    orig_expire_date_Total_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid>0);
    orig_expire_date_dd_ENUM_ErrorCount := COUNT(GROUP,h.orig_expire_date_dd_Invalid=1);
    orig_noncdlstatus_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_noncdlstatus_Invalid=1);
    orig_cdlstatus_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_cdlstatus_Invalid=1);
    orig_restrictions_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_restrictions_Invalid=1);
    orig_origdate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_origdate_Invalid=1);
    orig_origdate_LENGTH_ErrorCount := COUNT(GROUP,h.orig_origdate_Invalid=2);
    orig_origdate_Total_ErrorCount := COUNT(GROUP,h.orig_origdate_Invalid>0);
    orig_origcdldate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_origcdldate_Invalid=1);
    orig_origcdldate_LENGTH_ErrorCount := COUNT(GROUP,h.orig_origcdldate_Invalid=2);
    orig_origcdldate_Total_ErrorCount := COUNT(GROUP,h.orig_origcdldate_Invalid>0);
    orig_cancelst_ALLOW_ErrorCount := COUNT(GROUP,h.orig_cancelst_Invalid=1);
    orig_cancelst_LENGTH_ErrorCount := COUNT(GROUP,h.orig_cancelst_Invalid=2);
    orig_cancelst_Total_ErrorCount := COUNT(GROUP,h.orig_cancelst_Invalid>0);
    orig_canceldate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_canceldate_Invalid=1);
    orig_canceldate_LENGTH_ErrorCount := COUNT(GROUP,h.orig_canceldate_Invalid=2);
    orig_canceldate_Total_ErrorCount := COUNT(GROUP,h.orig_canceldate_Invalid>0);
    clean_name_last_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=1);
    clean_name_last_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=2);
    clean_name_last_Total_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid>0);
    clean_prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.clean_prim_range_Invalid=1);
    clean_predir_LENGTH_ErrorCount := COUNT(GROUP,h.clean_predir_Invalid=1);
    clean_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_prim_name_Invalid=1);
    clean_addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.clean_addr_suffix_Invalid=1);
    clean_postdir_LENGTH_ErrorCount := COUNT(GROUP,h.clean_postdir_Invalid=1);
    clean_unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.clean_unit_desig_Invalid=1);
    clean_sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.clean_sec_range_Invalid=1);
    clean_p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_city_name_Invalid=1);
    clean_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_v_city_name_Invalid=1);
    clean_st_LENGTH_ErrorCount := COUNT(GROUP,h.clean_st_Invalid=1);
    clean_zip_LENGTH_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid=1);
    clean_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid=1);
    clean_cart_LENGTH_ErrorCount := COUNT(GROUP,h.clean_cart_Invalid=1);
    clean_cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.clean_cr_sort_sz_Invalid=1);
    clean_lot_LENGTH_ErrorCount := COUNT(GROUP,h.clean_lot_Invalid=1);
    clean_lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.clean_lot_order_Invalid=1);
    clean_dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.clean_dpbc_Invalid=1);
    clean_chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.clean_chk_digit_Invalid=1);
    clean_record_type_LENGTH_ErrorCount := COUNT(GROUP,h.clean_record_type_Invalid=1);
    clean_ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.clean_ace_fips_st_Invalid=1);
    clean_fipscounty_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fipscounty_Invalid=1);
    clean_geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.clean_geo_lat_Invalid=1);
    clean_geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.clean_geo_long_Invalid=1);
    clean_msa_LENGTH_ErrorCount := COUNT(GROUP,h.clean_msa_Invalid=1);
    clean_geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.clean_geo_blk_Invalid=1);
    clean_geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.clean_geo_match_Invalid=1);
    clean_err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.clean_err_stat_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.orig_dlstate_Invalid,le.orig_dlnumber_Invalid,le.orig_name_Invalid,le.orig_dob_Invalid,le.orig_sex_Invalid,le.orig_height1_Invalid,le.orig_height2_Invalid,le.orig_eye_color_Invalid,le.orig_mailaddress_Invalid,le.orig_classification_Invalid,le.orig_issue_date_Invalid,le.orig_issue_date_dd_Invalid,le.orig_expire_date_Invalid,le.orig_expire_date_dd_Invalid,le.orig_noncdlstatus_Invalid,le.orig_cdlstatus_Invalid,le.orig_restrictions_Invalid,le.orig_origdate_Invalid,le.orig_origcdldate_Invalid,le.orig_cancelst_Invalid,le.orig_canceldate_Invalid,le.clean_name_last_Invalid,le.clean_prim_range_Invalid,le.clean_predir_Invalid,le.clean_prim_name_Invalid,le.clean_addr_suffix_Invalid,le.clean_postdir_Invalid,le.clean_unit_desig_Invalid,le.clean_sec_range_Invalid,le.clean_p_city_name_Invalid,le.clean_v_city_name_Invalid,le.clean_st_Invalid,le.clean_zip_Invalid,le.clean_zip4_Invalid,le.clean_cart_Invalid,le.clean_cr_sort_sz_Invalid,le.clean_lot_Invalid,le.clean_lot_order_Invalid,le.clean_dpbc_Invalid,le.clean_chk_digit_Invalid,le.clean_record_type_Invalid,le.clean_ace_fips_st_Invalid,le.clean_fipscounty_Invalid,le.clean_geo_lat_Invalid,le.clean_geo_long_Invalid,le.clean_msa_Invalid,le.clean_geo_blk_Invalid,le.clean_geo_match_Invalid,le.clean_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_orig_dlstate(le.orig_dlstate_Invalid),Fields.InvalidMessage_orig_dlnumber(le.orig_dlnumber_Invalid),Fields.InvalidMessage_orig_name(le.orig_name_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_sex(le.orig_sex_Invalid),Fields.InvalidMessage_orig_height1(le.orig_height1_Invalid),Fields.InvalidMessage_orig_height2(le.orig_height2_Invalid),Fields.InvalidMessage_orig_eye_color(le.orig_eye_color_Invalid),Fields.InvalidMessage_orig_mailaddress(le.orig_mailaddress_Invalid),Fields.InvalidMessage_orig_classification(le.orig_classification_Invalid),Fields.InvalidMessage_orig_issue_date(le.orig_issue_date_Invalid),Fields.InvalidMessage_orig_issue_date_dd(le.orig_issue_date_dd_Invalid),Fields.InvalidMessage_orig_expire_date(le.orig_expire_date_Invalid),Fields.InvalidMessage_orig_expire_date_dd(le.orig_expire_date_dd_Invalid),Fields.InvalidMessage_orig_noncdlstatus(le.orig_noncdlstatus_Invalid),Fields.InvalidMessage_orig_cdlstatus(le.orig_cdlstatus_Invalid),Fields.InvalidMessage_orig_restrictions(le.orig_restrictions_Invalid),Fields.InvalidMessage_orig_origdate(le.orig_origdate_Invalid),Fields.InvalidMessage_orig_origcdldate(le.orig_origcdldate_Invalid),Fields.InvalidMessage_orig_cancelst(le.orig_cancelst_Invalid),Fields.InvalidMessage_orig_canceldate(le.orig_canceldate_Invalid),Fields.InvalidMessage_clean_name_last(le.clean_name_last_Invalid),Fields.InvalidMessage_clean_prim_range(le.clean_prim_range_Invalid),Fields.InvalidMessage_clean_predir(le.clean_predir_Invalid),Fields.InvalidMessage_clean_prim_name(le.clean_prim_name_Invalid),Fields.InvalidMessage_clean_addr_suffix(le.clean_addr_suffix_Invalid),Fields.InvalidMessage_clean_postdir(le.clean_postdir_Invalid),Fields.InvalidMessage_clean_unit_desig(le.clean_unit_desig_Invalid),Fields.InvalidMessage_clean_sec_range(le.clean_sec_range_Invalid),Fields.InvalidMessage_clean_p_city_name(le.clean_p_city_name_Invalid),Fields.InvalidMessage_clean_v_city_name(le.clean_v_city_name_Invalid),Fields.InvalidMessage_clean_st(le.clean_st_Invalid),Fields.InvalidMessage_clean_zip(le.clean_zip_Invalid),Fields.InvalidMessage_clean_zip4(le.clean_zip4_Invalid),Fields.InvalidMessage_clean_cart(le.clean_cart_Invalid),Fields.InvalidMessage_clean_cr_sort_sz(le.clean_cr_sort_sz_Invalid),Fields.InvalidMessage_clean_lot(le.clean_lot_Invalid),Fields.InvalidMessage_clean_lot_order(le.clean_lot_order_Invalid),Fields.InvalidMessage_clean_dpbc(le.clean_dpbc_Invalid),Fields.InvalidMessage_clean_chk_digit(le.clean_chk_digit_Invalid),Fields.InvalidMessage_clean_record_type(le.clean_record_type_Invalid),Fields.InvalidMessage_clean_ace_fips_st(le.clean_ace_fips_st_Invalid),Fields.InvalidMessage_clean_fipscounty(le.clean_fipscounty_Invalid),Fields.InvalidMessage_clean_geo_lat(le.clean_geo_lat_Invalid),Fields.InvalidMessage_clean_geo_long(le.clean_geo_long_Invalid),Fields.InvalidMessage_clean_msa(le.clean_msa_Invalid),Fields.InvalidMessage_clean_geo_blk(le.clean_geo_blk_Invalid),Fields.InvalidMessage_clean_geo_match(le.clean_geo_match_Invalid),Fields.InvalidMessage_clean_err_stat(le.clean_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dlstate_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_dlnumber_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_height1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_height2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_eye_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_mailaddress_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_classification_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_issue_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_issue_date_dd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_expire_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_expire_date_dd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_noncdlstatus_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_cdlstatus_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_restrictions_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_origdate_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_origcdldate_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_cancelst_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_canceldate_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_last_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_prim_range_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_predir_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_addr_suffix_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_postdir_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_unit_desig_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_sec_range_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_v_city_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_st_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_zip_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_zip4_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_cart_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_cr_sort_sz_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_lot_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_lot_order_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_dpbc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_chk_digit_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_record_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_ace_fips_st_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_fipscounty_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_lat_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_long_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_msa_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_blk_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_match_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_err_stat_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','orig_dlstate','orig_dlnumber','orig_name','orig_dob','orig_sex','orig_height1','orig_height2','orig_eye_color','orig_mailaddress','orig_classification','orig_issue_date','orig_issue_date_dd','orig_expire_date','orig_expire_date_dd','orig_noncdlstatus','orig_cdlstatus','orig_restrictions','orig_origdate','orig_origcdldate','orig_cancelst','orig_canceldate','clean_name_last','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_orig_dlstate','invalid_orig_dlnumber','invalid_orig_name','invalid_8pastdate','invalid_orig_sex','invalid_orig_height','invalid_inches','invalid_orig_eye_color','invalid_wordbag','invalid_orig_classification','invalid_orig_issue_date','invalid_day','invalid_orig_expire_date','invalid_day','invalid_orig_status','invalid_orig_status','invalid_orig_restrictions','invalid_08pastdate','invalid_08pastdate','invalid_state','invalid_08pastdate','invalid_clean_name','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.append_process_date,(SALT34.StrType)le.orig_dlstate,(SALT34.StrType)le.orig_dlnumber,(SALT34.StrType)le.orig_name,(SALT34.StrType)le.orig_dob,(SALT34.StrType)le.orig_sex,(SALT34.StrType)le.orig_height1,(SALT34.StrType)le.orig_height2,(SALT34.StrType)le.orig_eye_color,(SALT34.StrType)le.orig_mailaddress,(SALT34.StrType)le.orig_classification,(SALT34.StrType)le.orig_issue_date,(SALT34.StrType)le.orig_issue_date_dd,(SALT34.StrType)le.orig_expire_date,(SALT34.StrType)le.orig_expire_date_dd,(SALT34.StrType)le.orig_noncdlstatus,(SALT34.StrType)le.orig_cdlstatus,(SALT34.StrType)le.orig_restrictions,(SALT34.StrType)le.orig_origdate,(SALT34.StrType)le.orig_origcdldate,(SALT34.StrType)le.orig_cancelst,(SALT34.StrType)le.orig_canceldate,(SALT34.StrType)le.clean_name_last,(SALT34.StrType)le.clean_prim_range,(SALT34.StrType)le.clean_predir,(SALT34.StrType)le.clean_prim_name,(SALT34.StrType)le.clean_addr_suffix,(SALT34.StrType)le.clean_postdir,(SALT34.StrType)le.clean_unit_desig,(SALT34.StrType)le.clean_sec_range,(SALT34.StrType)le.clean_p_city_name,(SALT34.StrType)le.clean_v_city_name,(SALT34.StrType)le.clean_st,(SALT34.StrType)le.clean_zip,(SALT34.StrType)le.clean_zip4,(SALT34.StrType)le.clean_cart,(SALT34.StrType)le.clean_cr_sort_sz,(SALT34.StrType)le.clean_lot,(SALT34.StrType)le.clean_lot_order,(SALT34.StrType)le.clean_dpbc,(SALT34.StrType)le.clean_chk_digit,(SALT34.StrType)le.clean_record_type,(SALT34.StrType)le.clean_ace_fips_st,(SALT34.StrType)le.clean_fipscounty,(SALT34.StrType)le.clean_geo_lat,(SALT34.StrType)le.clean_geo_long,(SALT34.StrType)le.clean_msa,(SALT34.StrType)le.clean_geo_blk,(SALT34.StrType)le.clean_geo_match,(SALT34.StrType)le.clean_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,50,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_8pastdate:CUSTOM','append_process_date:invalid_8pastdate:LENGTH'
          ,'orig_dlstate:invalid_orig_dlstate:ENUM'
          ,'orig_dlnumber:invalid_orig_dlnumber:ALLOW','orig_dlnumber:invalid_orig_dlnumber:CUSTOM','orig_dlnumber:invalid_orig_dlnumber:LENGTH'
          ,'orig_name:invalid_orig_name:ALLOW','orig_name:invalid_orig_name:LENGTH'
          ,'orig_dob:invalid_8pastdate:CUSTOM','orig_dob:invalid_8pastdate:LENGTH'
          ,'orig_sex:invalid_orig_sex:ENUM'
          ,'orig_height1:invalid_orig_height:CUSTOM'
          ,'orig_height2:invalid_inches:ENUM'
          ,'orig_eye_color:invalid_orig_eye_color:CUSTOM'
          ,'orig_mailaddress:invalid_wordbag:CAPS','orig_mailaddress:invalid_wordbag:ALLOW'
          ,'orig_classification:invalid_orig_classification:CUSTOM'
          ,'orig_issue_date:invalid_orig_issue_date:CUSTOM','orig_issue_date:invalid_orig_issue_date:LENGTH'
          ,'orig_issue_date_dd:invalid_day:ENUM'
          ,'orig_expire_date:invalid_orig_expire_date:CUSTOM','orig_expire_date:invalid_orig_expire_date:LENGTH'
          ,'orig_expire_date_dd:invalid_day:ENUM'
          ,'orig_noncdlstatus:invalid_orig_status:CUSTOM'
          ,'orig_cdlstatus:invalid_orig_status:CUSTOM'
          ,'orig_restrictions:invalid_orig_restrictions:CUSTOM'
          ,'orig_origdate:invalid_08pastdate:CUSTOM','orig_origdate:invalid_08pastdate:LENGTH'
          ,'orig_origcdldate:invalid_08pastdate:CUSTOM','orig_origcdldate:invalid_08pastdate:LENGTH'
          ,'orig_cancelst:invalid_state:ALLOW','orig_cancelst:invalid_state:LENGTH'
          ,'orig_canceldate:invalid_08pastdate:CUSTOM','orig_canceldate:invalid_08pastdate:LENGTH'
          ,'clean_name_last:invalid_clean_name:ALLOW','clean_name_last:invalid_clean_name:CUSTOM'
          ,'clean_prim_range:invalid_empty:LENGTH'
          ,'clean_predir:invalid_empty:LENGTH'
          ,'clean_prim_name:invalid_empty:LENGTH'
          ,'clean_addr_suffix:invalid_empty:LENGTH'
          ,'clean_postdir:invalid_empty:LENGTH'
          ,'clean_unit_desig:invalid_empty:LENGTH'
          ,'clean_sec_range:invalid_empty:LENGTH'
          ,'clean_p_city_name:invalid_empty:LENGTH'
          ,'clean_v_city_name:invalid_empty:LENGTH'
          ,'clean_st:invalid_empty:LENGTH'
          ,'clean_zip:invalid_empty:LENGTH'
          ,'clean_zip4:invalid_empty:LENGTH'
          ,'clean_cart:invalid_empty:LENGTH'
          ,'clean_cr_sort_sz:invalid_empty:LENGTH'
          ,'clean_lot:invalid_empty:LENGTH'
          ,'clean_lot_order:invalid_empty:LENGTH'
          ,'clean_dpbc:invalid_empty:LENGTH'
          ,'clean_chk_digit:invalid_empty:LENGTH'
          ,'clean_record_type:invalid_empty:LENGTH'
          ,'clean_ace_fips_st:invalid_empty:LENGTH'
          ,'clean_fipscounty:invalid_empty:LENGTH'
          ,'clean_geo_lat:invalid_empty:LENGTH'
          ,'clean_geo_long:invalid_empty:LENGTH'
          ,'clean_msa:invalid_empty:LENGTH'
          ,'clean_geo_blk:invalid_empty:LENGTH'
          ,'clean_geo_match:invalid_empty:LENGTH'
          ,'clean_err_stat:invalid_empty:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1),Fields.InvalidMessage_append_process_date(2)
          ,Fields.InvalidMessage_orig_dlstate(1)
          ,Fields.InvalidMessage_orig_dlnumber(1),Fields.InvalidMessage_orig_dlnumber(2),Fields.InvalidMessage_orig_dlnumber(3)
          ,Fields.InvalidMessage_orig_name(1),Fields.InvalidMessage_orig_name(2)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2)
          ,Fields.InvalidMessage_orig_sex(1)
          ,Fields.InvalidMessage_orig_height1(1)
          ,Fields.InvalidMessage_orig_height2(1)
          ,Fields.InvalidMessage_orig_eye_color(1)
          ,Fields.InvalidMessage_orig_mailaddress(1),Fields.InvalidMessage_orig_mailaddress(2)
          ,Fields.InvalidMessage_orig_classification(1)
          ,Fields.InvalidMessage_orig_issue_date(1),Fields.InvalidMessage_orig_issue_date(2)
          ,Fields.InvalidMessage_orig_issue_date_dd(1)
          ,Fields.InvalidMessage_orig_expire_date(1),Fields.InvalidMessage_orig_expire_date(2)
          ,Fields.InvalidMessage_orig_expire_date_dd(1)
          ,Fields.InvalidMessage_orig_noncdlstatus(1)
          ,Fields.InvalidMessage_orig_cdlstatus(1)
          ,Fields.InvalidMessage_orig_restrictions(1)
          ,Fields.InvalidMessage_orig_origdate(1),Fields.InvalidMessage_orig_origdate(2)
          ,Fields.InvalidMessage_orig_origcdldate(1),Fields.InvalidMessage_orig_origcdldate(2)
          ,Fields.InvalidMessage_orig_cancelst(1),Fields.InvalidMessage_orig_cancelst(2)
          ,Fields.InvalidMessage_orig_canceldate(1),Fields.InvalidMessage_orig_canceldate(2)
          ,Fields.InvalidMessage_clean_name_last(1),Fields.InvalidMessage_clean_name_last(2)
          ,Fields.InvalidMessage_clean_prim_range(1)
          ,Fields.InvalidMessage_clean_predir(1)
          ,Fields.InvalidMessage_clean_prim_name(1)
          ,Fields.InvalidMessage_clean_addr_suffix(1)
          ,Fields.InvalidMessage_clean_postdir(1)
          ,Fields.InvalidMessage_clean_unit_desig(1)
          ,Fields.InvalidMessage_clean_sec_range(1)
          ,Fields.InvalidMessage_clean_p_city_name(1)
          ,Fields.InvalidMessage_clean_v_city_name(1)
          ,Fields.InvalidMessage_clean_st(1)
          ,Fields.InvalidMessage_clean_zip(1)
          ,Fields.InvalidMessage_clean_zip4(1)
          ,Fields.InvalidMessage_clean_cart(1)
          ,Fields.InvalidMessage_clean_cr_sort_sz(1)
          ,Fields.InvalidMessage_clean_lot(1)
          ,Fields.InvalidMessage_clean_lot_order(1)
          ,Fields.InvalidMessage_clean_dpbc(1)
          ,Fields.InvalidMessage_clean_chk_digit(1)
          ,Fields.InvalidMessage_clean_record_type(1)
          ,Fields.InvalidMessage_clean_ace_fips_st(1)
          ,Fields.InvalidMessage_clean_fipscounty(1)
          ,Fields.InvalidMessage_clean_geo_lat(1)
          ,Fields.InvalidMessage_clean_geo_long(1)
          ,Fields.InvalidMessage_clean_msa(1)
          ,Fields.InvalidMessage_clean_geo_blk(1)
          ,Fields.InvalidMessage_clean_geo_match(1)
          ,Fields.InvalidMessage_clean_err_stat(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.orig_dlstate_ENUM_ErrorCount
          ,le.orig_dlnumber_ALLOW_ErrorCount,le.orig_dlnumber_CUSTOM_ErrorCount,le.orig_dlnumber_LENGTH_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount,le.orig_name_LENGTH_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_height1_CUSTOM_ErrorCount
          ,le.orig_height2_ENUM_ErrorCount
          ,le.orig_eye_color_CUSTOM_ErrorCount
          ,le.orig_mailaddress_CAPS_ErrorCount,le.orig_mailaddress_ALLOW_ErrorCount
          ,le.orig_classification_CUSTOM_ErrorCount
          ,le.orig_issue_date_CUSTOM_ErrorCount,le.orig_issue_date_LENGTH_ErrorCount
          ,le.orig_issue_date_dd_ENUM_ErrorCount
          ,le.orig_expire_date_CUSTOM_ErrorCount,le.orig_expire_date_LENGTH_ErrorCount
          ,le.orig_expire_date_dd_ENUM_ErrorCount
          ,le.orig_noncdlstatus_CUSTOM_ErrorCount
          ,le.orig_cdlstatus_CUSTOM_ErrorCount
          ,le.orig_restrictions_CUSTOM_ErrorCount
          ,le.orig_origdate_CUSTOM_ErrorCount,le.orig_origdate_LENGTH_ErrorCount
          ,le.orig_origcdldate_CUSTOM_ErrorCount,le.orig_origcdldate_LENGTH_ErrorCount
          ,le.orig_cancelst_ALLOW_ErrorCount,le.orig_cancelst_LENGTH_ErrorCount
          ,le.orig_canceldate_CUSTOM_ErrorCount,le.orig_canceldate_LENGTH_ErrorCount
          ,le.clean_name_last_ALLOW_ErrorCount,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_prim_range_LENGTH_ErrorCount
          ,le.clean_predir_LENGTH_ErrorCount
          ,le.clean_prim_name_LENGTH_ErrorCount
          ,le.clean_addr_suffix_LENGTH_ErrorCount
          ,le.clean_postdir_LENGTH_ErrorCount
          ,le.clean_unit_desig_LENGTH_ErrorCount
          ,le.clean_sec_range_LENGTH_ErrorCount
          ,le.clean_p_city_name_LENGTH_ErrorCount
          ,le.clean_v_city_name_LENGTH_ErrorCount
          ,le.clean_st_LENGTH_ErrorCount
          ,le.clean_zip_LENGTH_ErrorCount
          ,le.clean_zip4_LENGTH_ErrorCount
          ,le.clean_cart_LENGTH_ErrorCount
          ,le.clean_cr_sort_sz_LENGTH_ErrorCount
          ,le.clean_lot_LENGTH_ErrorCount
          ,le.clean_lot_order_LENGTH_ErrorCount
          ,le.clean_dpbc_LENGTH_ErrorCount
          ,le.clean_chk_digit_LENGTH_ErrorCount
          ,le.clean_record_type_LENGTH_ErrorCount
          ,le.clean_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_fipscounty_LENGTH_ErrorCount
          ,le.clean_geo_lat_LENGTH_ErrorCount
          ,le.clean_geo_long_LENGTH_ErrorCount
          ,le.clean_msa_LENGTH_ErrorCount
          ,le.clean_geo_blk_LENGTH_ErrorCount
          ,le.clean_geo_match_LENGTH_ErrorCount
          ,le.clean_err_stat_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.orig_dlstate_ENUM_ErrorCount
          ,le.orig_dlnumber_ALLOW_ErrorCount,le.orig_dlnumber_CUSTOM_ErrorCount,le.orig_dlnumber_LENGTH_ErrorCount
          ,le.orig_name_ALLOW_ErrorCount,le.orig_name_LENGTH_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_height1_CUSTOM_ErrorCount
          ,le.orig_height2_ENUM_ErrorCount
          ,le.orig_eye_color_CUSTOM_ErrorCount
          ,le.orig_mailaddress_CAPS_ErrorCount,le.orig_mailaddress_ALLOW_ErrorCount
          ,le.orig_classification_CUSTOM_ErrorCount
          ,le.orig_issue_date_CUSTOM_ErrorCount,le.orig_issue_date_LENGTH_ErrorCount
          ,le.orig_issue_date_dd_ENUM_ErrorCount
          ,le.orig_expire_date_CUSTOM_ErrorCount,le.orig_expire_date_LENGTH_ErrorCount
          ,le.orig_expire_date_dd_ENUM_ErrorCount
          ,le.orig_noncdlstatus_CUSTOM_ErrorCount
          ,le.orig_cdlstatus_CUSTOM_ErrorCount
          ,le.orig_restrictions_CUSTOM_ErrorCount
          ,le.orig_origdate_CUSTOM_ErrorCount,le.orig_origdate_LENGTH_ErrorCount
          ,le.orig_origcdldate_CUSTOM_ErrorCount,le.orig_origcdldate_LENGTH_ErrorCount
          ,le.orig_cancelst_ALLOW_ErrorCount,le.orig_cancelst_LENGTH_ErrorCount
          ,le.orig_canceldate_CUSTOM_ErrorCount,le.orig_canceldate_LENGTH_ErrorCount
          ,le.clean_name_last_ALLOW_ErrorCount,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_prim_range_LENGTH_ErrorCount
          ,le.clean_predir_LENGTH_ErrorCount
          ,le.clean_prim_name_LENGTH_ErrorCount
          ,le.clean_addr_suffix_LENGTH_ErrorCount
          ,le.clean_postdir_LENGTH_ErrorCount
          ,le.clean_unit_desig_LENGTH_ErrorCount
          ,le.clean_sec_range_LENGTH_ErrorCount
          ,le.clean_p_city_name_LENGTH_ErrorCount
          ,le.clean_v_city_name_LENGTH_ErrorCount
          ,le.clean_st_LENGTH_ErrorCount
          ,le.clean_zip_LENGTH_ErrorCount
          ,le.clean_zip4_LENGTH_ErrorCount
          ,le.clean_cart_LENGTH_ErrorCount
          ,le.clean_cr_sort_sz_LENGTH_ErrorCount
          ,le.clean_lot_LENGTH_ErrorCount
          ,le.clean_lot_order_LENGTH_ErrorCount
          ,le.clean_dpbc_LENGTH_ErrorCount
          ,le.clean_chk_digit_LENGTH_ErrorCount
          ,le.clean_record_type_LENGTH_ErrorCount
          ,le.clean_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_fipscounty_LENGTH_ErrorCount
          ,le.clean_geo_lat_LENGTH_ErrorCount
          ,le.clean_geo_long_LENGTH_ErrorCount
          ,le.clean_msa_LENGTH_ErrorCount
          ,le.clean_geo_blk_LENGTH_ErrorCount
          ,le.clean_geo_match_LENGTH_ErrorCount
          ,le.clean_err_stat_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,63,Into(LEFT,COUNTER));
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
