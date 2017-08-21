IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_NV; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_NV)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 lst_name_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 dln_Invalid;
    UNSIGNED1 perm_cd_1_Invalid;
    UNSIGNED1 perm_cd_2_Invalid;
    UNSIGNED1 perm_cd_3_Invalid;
    UNSIGNED1 perm_cd_4_Invalid;
    UNSIGNED1 eff_dt_Invalid;
    UNSIGNED1 m_addr_Invalid;
    UNSIGNED1 m_city_Invalid;
    UNSIGNED1 m_state_Invalid;
    UNSIGNED1 m_zip_Invalid;
    UNSIGNED1 p_city_Invalid;
    UNSIGNED1 p_state_Invalid;
    UNSIGNED1 p_zip_Invalid;
    UNSIGNED1 clean_name_last_Invalid;
    UNSIGNED1 clean_m_predir_Invalid;
    UNSIGNED1 clean_m_postdir_Invalid;
    UNSIGNED1 clean_m_p_city_name_Invalid;
    UNSIGNED1 clean_m_v_city_name_Invalid;
    UNSIGNED1 clean_m_st_Invalid;
    UNSIGNED1 clean_m_zip_Invalid;
    UNSIGNED1 clean_m_zip4_Invalid;
    UNSIGNED1 clean_m_cart_Invalid;
    UNSIGNED1 clean_m_cr_sort_sz_Invalid;
    UNSIGNED1 clean_m_lot_Invalid;
    UNSIGNED1 clean_m_lot_order_Invalid;
    UNSIGNED1 clean_m_dpbc_Invalid;
    UNSIGNED1 clean_m_chk_digit_Invalid;
    UNSIGNED1 clean_m_record_type_Invalid;
    UNSIGNED1 clean_m_ace_fips_st_Invalid;
    UNSIGNED1 clean_m_fipscounty_Invalid;
    UNSIGNED1 clean_m_geo_lat_Invalid;
    UNSIGNED1 clean_m_geo_long_Invalid;
    UNSIGNED1 clean_m_msa_Invalid;
    UNSIGNED1 clean_m_geo_blk_Invalid;
    UNSIGNED1 clean_m_geo_match_Invalid;
    UNSIGNED1 clean_m_err_stat_Invalid;
    UNSIGNED1 clean_p_predir_Invalid;
    UNSIGNED1 clean_p_postdir_Invalid;
    UNSIGNED1 clean_p_p_city_name_Invalid;
    UNSIGNED1 clean_p_v_city_name_Invalid;
    UNSIGNED1 clean_p_st_Invalid;
    UNSIGNED1 clean_p_zip_Invalid;
    UNSIGNED1 clean_p_zip4_Invalid;
    UNSIGNED1 clean_p_cart_Invalid;
    UNSIGNED1 clean_p_cr_sort_sz_Invalid;
    UNSIGNED1 clean_p_lot_Invalid;
    UNSIGNED1 clean_p_lot_order_Invalid;
    UNSIGNED1 clean_p_dpbc_Invalid;
    UNSIGNED1 clean_p_chk_digit_Invalid;
    UNSIGNED1 clean_p_record_type_Invalid;
    UNSIGNED1 clean_p_ace_fips_st_Invalid;
    UNSIGNED1 clean_p_fipscounty_Invalid;
    UNSIGNED1 clean_p_geo_lat_Invalid;
    UNSIGNED1 clean_p_geo_long_Invalid;
    UNSIGNED1 clean_p_msa_Invalid;
    UNSIGNED1 clean_p_geo_blk_Invalid;
    UNSIGNED1 clean_p_geo_match_Invalid;
    UNSIGNED1 clean_p_err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_NV)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_In_NV) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT35.StrType)le.append_process_date);
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT35.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT35.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT35.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT35.StrType)le.dt_vendor_last_reported);
    SELF.lst_name_Invalid := Fields.InValid_lst_name((SALT35.StrType)le.lst_name,(SALT35.StrType)le.fst_name,(SALT35.StrType)le.mid_name);
    SELF.dob_Invalid := Fields.InValid_dob((SALT35.StrType)le.dob);
    SELF.dln_Invalid := Fields.InValid_dln((SALT35.StrType)le.dln);
    SELF.perm_cd_1_Invalid := Fields.InValid_perm_cd_1((SALT35.StrType)le.perm_cd_1);
    SELF.perm_cd_2_Invalid := Fields.InValid_perm_cd_2((SALT35.StrType)le.perm_cd_2);
    SELF.perm_cd_3_Invalid := Fields.InValid_perm_cd_3((SALT35.StrType)le.perm_cd_3);
    SELF.perm_cd_4_Invalid := Fields.InValid_perm_cd_4((SALT35.StrType)le.perm_cd_4);
    SELF.eff_dt_Invalid := Fields.InValid_eff_dt((SALT35.StrType)le.eff_dt);
    SELF.m_addr_Invalid := Fields.InValid_m_addr((SALT35.StrType)le.m_addr);
    SELF.m_city_Invalid := Fields.InValid_m_city((SALT35.StrType)le.m_city);
    SELF.m_state_Invalid := Fields.InValid_m_state((SALT35.StrType)le.m_state);
    SELF.m_zip_Invalid := Fields.InValid_m_zip((SALT35.StrType)le.m_zip);
    SELF.p_city_Invalid := Fields.InValid_p_city((SALT35.StrType)le.p_city);
    SELF.p_state_Invalid := Fields.InValid_p_state((SALT35.StrType)le.p_state);
    SELF.p_zip_Invalid := Fields.InValid_p_zip((SALT35.StrType)le.p_zip);
    SELF.clean_name_last_Invalid := Fields.InValid_clean_name_last((SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_first,(SALT35.StrType)le.clean_name_middle);
    SELF.clean_m_predir_Invalid := Fields.InValid_clean_m_predir((SALT35.StrType)le.clean_m_predir);
    SELF.clean_m_postdir_Invalid := Fields.InValid_clean_m_postdir((SALT35.StrType)le.clean_m_postdir);
    SELF.clean_m_p_city_name_Invalid := Fields.InValid_clean_m_p_city_name((SALT35.StrType)le.clean_m_p_city_name);
    SELF.clean_m_v_city_name_Invalid := Fields.InValid_clean_m_v_city_name((SALT35.StrType)le.clean_m_v_city_name);
    SELF.clean_m_st_Invalid := Fields.InValid_clean_m_st((SALT35.StrType)le.clean_m_st);
    SELF.clean_m_zip_Invalid := Fields.InValid_clean_m_zip((SALT35.StrType)le.clean_m_zip);
    SELF.clean_m_zip4_Invalid := Fields.InValid_clean_m_zip4((SALT35.StrType)le.clean_m_zip4);
    SELF.clean_m_cart_Invalid := Fields.InValid_clean_m_cart((SALT35.StrType)le.clean_m_cart);
    SELF.clean_m_cr_sort_sz_Invalid := Fields.InValid_clean_m_cr_sort_sz((SALT35.StrType)le.clean_m_cr_sort_sz);
    SELF.clean_m_lot_Invalid := Fields.InValid_clean_m_lot((SALT35.StrType)le.clean_m_lot);
    SELF.clean_m_lot_order_Invalid := Fields.InValid_clean_m_lot_order((SALT35.StrType)le.clean_m_lot_order);
    SELF.clean_m_dpbc_Invalid := Fields.InValid_clean_m_dpbc((SALT35.StrType)le.clean_m_dpbc);
    SELF.clean_m_chk_digit_Invalid := Fields.InValid_clean_m_chk_digit((SALT35.StrType)le.clean_m_chk_digit);
    SELF.clean_m_record_type_Invalid := Fields.InValid_clean_m_record_type((SALT35.StrType)le.clean_m_record_type);
    SELF.clean_m_ace_fips_st_Invalid := Fields.InValid_clean_m_ace_fips_st((SALT35.StrType)le.clean_m_ace_fips_st);
    SELF.clean_m_fipscounty_Invalid := Fields.InValid_clean_m_fipscounty((SALT35.StrType)le.clean_m_fipscounty);
    SELF.clean_m_geo_lat_Invalid := Fields.InValid_clean_m_geo_lat((SALT35.StrType)le.clean_m_geo_lat);
    SELF.clean_m_geo_long_Invalid := Fields.InValid_clean_m_geo_long((SALT35.StrType)le.clean_m_geo_long);
    SELF.clean_m_msa_Invalid := Fields.InValid_clean_m_msa((SALT35.StrType)le.clean_m_msa);
    SELF.clean_m_geo_blk_Invalid := Fields.InValid_clean_m_geo_blk((SALT35.StrType)le.clean_m_geo_blk);
    SELF.clean_m_geo_match_Invalid := Fields.InValid_clean_m_geo_match((SALT35.StrType)le.clean_m_geo_match);
    SELF.clean_m_err_stat_Invalid := Fields.InValid_clean_m_err_stat((SALT35.StrType)le.clean_m_err_stat);
    SELF.clean_p_predir_Invalid := Fields.InValid_clean_p_predir((SALT35.StrType)le.clean_p_predir);
    SELF.clean_p_postdir_Invalid := Fields.InValid_clean_p_postdir((SALT35.StrType)le.clean_p_postdir);
    SELF.clean_p_p_city_name_Invalid := Fields.InValid_clean_p_p_city_name((SALT35.StrType)le.clean_p_p_city_name);
    SELF.clean_p_v_city_name_Invalid := Fields.InValid_clean_p_v_city_name((SALT35.StrType)le.clean_p_v_city_name);
    SELF.clean_p_st_Invalid := Fields.InValid_clean_p_st((SALT35.StrType)le.clean_p_st);
    SELF.clean_p_zip_Invalid := Fields.InValid_clean_p_zip((SALT35.StrType)le.clean_p_zip);
    SELF.clean_p_zip4_Invalid := Fields.InValid_clean_p_zip4((SALT35.StrType)le.clean_p_zip4);
    SELF.clean_p_cart_Invalid := Fields.InValid_clean_p_cart((SALT35.StrType)le.clean_p_cart);
    SELF.clean_p_cr_sort_sz_Invalid := Fields.InValid_clean_p_cr_sort_sz((SALT35.StrType)le.clean_p_cr_sort_sz);
    SELF.clean_p_lot_Invalid := Fields.InValid_clean_p_lot((SALT35.StrType)le.clean_p_lot);
    SELF.clean_p_lot_order_Invalid := Fields.InValid_clean_p_lot_order((SALT35.StrType)le.clean_p_lot_order);
    SELF.clean_p_dpbc_Invalid := Fields.InValid_clean_p_dpbc((SALT35.StrType)le.clean_p_dpbc);
    SELF.clean_p_chk_digit_Invalid := Fields.InValid_clean_p_chk_digit((SALT35.StrType)le.clean_p_chk_digit);
    SELF.clean_p_record_type_Invalid := Fields.InValid_clean_p_record_type((SALT35.StrType)le.clean_p_record_type);
    SELF.clean_p_ace_fips_st_Invalid := Fields.InValid_clean_p_ace_fips_st((SALT35.StrType)le.clean_p_ace_fips_st);
    SELF.clean_p_fipscounty_Invalid := Fields.InValid_clean_p_fipscounty((SALT35.StrType)le.clean_p_fipscounty);
    SELF.clean_p_geo_lat_Invalid := Fields.InValid_clean_p_geo_lat((SALT35.StrType)le.clean_p_geo_lat);
    SELF.clean_p_geo_long_Invalid := Fields.InValid_clean_p_geo_long((SALT35.StrType)le.clean_p_geo_long);
    SELF.clean_p_msa_Invalid := Fields.InValid_clean_p_msa((SALT35.StrType)le.clean_p_msa);
    SELF.clean_p_geo_blk_Invalid := Fields.InValid_clean_p_geo_blk((SALT35.StrType)le.clean_p_geo_blk);
    SELF.clean_p_geo_match_Invalid := Fields.InValid_clean_p_geo_match((SALT35.StrType)le.clean_p_geo_match);
    SELF.clean_p_err_stat_Invalid := Fields.InValid_clean_p_err_stat((SALT35.StrType)le.clean_p_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_NV);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.dt_first_seen_Invalid << 2 ) + ( le.dt_last_seen_Invalid << 4 ) + ( le.dt_vendor_first_reported_Invalid << 6 ) + ( le.dt_vendor_last_reported_Invalid << 8 ) + ( le.lst_name_Invalid << 10 ) + ( le.dob_Invalid << 11 ) + ( le.dln_Invalid << 13 ) + ( le.perm_cd_1_Invalid << 15 ) + ( le.perm_cd_2_Invalid << 16 ) + ( le.perm_cd_3_Invalid << 17 ) + ( le.perm_cd_4_Invalid << 18 ) + ( le.eff_dt_Invalid << 19 ) + ( le.m_addr_Invalid << 21 ) + ( le.m_city_Invalid << 22 ) + ( le.m_state_Invalid << 23 ) + ( le.m_zip_Invalid << 24 ) + ( le.p_city_Invalid << 26 ) + ( le.p_state_Invalid << 27 ) + ( le.p_zip_Invalid << 28 ) + ( le.clean_name_last_Invalid << 30 ) + ( le.clean_m_predir_Invalid << 32 ) + ( le.clean_m_postdir_Invalid << 33 ) + ( le.clean_m_p_city_name_Invalid << 34 ) + ( le.clean_m_v_city_name_Invalid << 35 ) + ( le.clean_m_st_Invalid << 36 ) + ( le.clean_m_zip_Invalid << 37 ) + ( le.clean_m_zip4_Invalid << 39 ) + ( le.clean_m_cart_Invalid << 41 ) + ( le.clean_m_cr_sort_sz_Invalid << 43 ) + ( le.clean_m_lot_Invalid << 44 ) + ( le.clean_m_lot_order_Invalid << 46 ) + ( le.clean_m_dpbc_Invalid << 48 ) + ( le.clean_m_chk_digit_Invalid << 50 ) + ( le.clean_m_record_type_Invalid << 52 ) + ( le.clean_m_ace_fips_st_Invalid << 54 ) + ( le.clean_m_fipscounty_Invalid << 56 ) + ( le.clean_m_geo_lat_Invalid << 58 ) + ( le.clean_m_geo_long_Invalid << 59 ) + ( le.clean_m_msa_Invalid << 60 ) + ( le.clean_m_geo_blk_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.clean_m_geo_match_Invalid << 0 ) + ( le.clean_m_err_stat_Invalid << 2 ) + ( le.clean_p_predir_Invalid << 4 ) + ( le.clean_p_postdir_Invalid << 5 ) + ( le.clean_p_p_city_name_Invalid << 6 ) + ( le.clean_p_v_city_name_Invalid << 7 ) + ( le.clean_p_st_Invalid << 8 ) + ( le.clean_p_zip_Invalid << 9 ) + ( le.clean_p_zip4_Invalid << 11 ) + ( le.clean_p_cart_Invalid << 13 ) + ( le.clean_p_cr_sort_sz_Invalid << 15 ) + ( le.clean_p_lot_Invalid << 16 ) + ( le.clean_p_lot_order_Invalid << 18 ) + ( le.clean_p_dpbc_Invalid << 20 ) + ( le.clean_p_chk_digit_Invalid << 22 ) + ( le.clean_p_record_type_Invalid << 24 ) + ( le.clean_p_ace_fips_st_Invalid << 26 ) + ( le.clean_p_fipscounty_Invalid << 28 ) + ( le.clean_p_geo_lat_Invalid << 30 ) + ( le.clean_p_geo_long_Invalid << 31 ) + ( le.clean_p_msa_Invalid << 32 ) + ( le.clean_p_geo_blk_Invalid << 34 ) + ( le.clean_p_geo_match_Invalid << 36 ) + ( le.clean_p_err_stat_Invalid << 38 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_NV);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.lst_name_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dln_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.perm_cd_1_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.perm_cd_2_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.perm_cd_3_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.perm_cd_4_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.eff_dt_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.m_addr_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.m_city_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.m_state_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.m_zip_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.p_city_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.p_state_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.p_zip_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.clean_name_last_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.clean_m_predir_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.clean_m_postdir_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.clean_m_p_city_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.clean_m_v_city_name_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.clean_m_st_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.clean_m_zip_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.clean_m_zip4_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.clean_m_cart_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.clean_m_cr_sort_sz_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.clean_m_lot_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.clean_m_lot_order_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.clean_m_dpbc_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.clean_m_chk_digit_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.clean_m_record_type_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.clean_m_ace_fips_st_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.clean_m_fipscounty_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.clean_m_geo_lat_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.clean_m_geo_long_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.clean_m_msa_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.clean_m_geo_blk_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.clean_m_geo_match_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.clean_m_err_stat_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.clean_p_predir_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.clean_p_postdir_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.clean_p_p_city_name_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.clean_p_v_city_name_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.clean_p_st_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.clean_p_zip_Invalid := (le.ScrubsBits2 >> 9) & 3;
    SELF.clean_p_zip4_Invalid := (le.ScrubsBits2 >> 11) & 3;
    SELF.clean_p_cart_Invalid := (le.ScrubsBits2 >> 13) & 3;
    SELF.clean_p_cr_sort_sz_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.clean_p_lot_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.clean_p_lot_order_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.clean_p_dpbc_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.clean_p_chk_digit_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.clean_p_record_type_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.clean_p_ace_fips_st_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.clean_p_fipscounty_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.clean_p_geo_lat_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.clean_p_geo_long_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.clean_p_msa_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.clean_p_geo_blk_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.clean_p_geo_match_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.clean_p_err_stat_Invalid := (le.ScrubsBits2 >> 38) & 3;
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
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    lst_name_CUSTOM_ErrorCount := COUNT(GROUP,h.lst_name_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    dln_ALLOW_ErrorCount := COUNT(GROUP,h.dln_Invalid=1);
    dln_LENGTH_ErrorCount := COUNT(GROUP,h.dln_Invalid=2);
    dln_Total_ErrorCount := COUNT(GROUP,h.dln_Invalid>0);
    perm_cd_1_CUSTOM_ErrorCount := COUNT(GROUP,h.perm_cd_1_Invalid=1);
    perm_cd_2_CUSTOM_ErrorCount := COUNT(GROUP,h.perm_cd_2_Invalid=1);
    perm_cd_3_CUSTOM_ErrorCount := COUNT(GROUP,h.perm_cd_3_Invalid=1);
    perm_cd_4_CUSTOM_ErrorCount := COUNT(GROUP,h.perm_cd_4_Invalid=1);
    eff_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.eff_dt_Invalid=1);
    eff_dt_LENGTH_ErrorCount := COUNT(GROUP,h.eff_dt_Invalid=2);
    eff_dt_Total_ErrorCount := COUNT(GROUP,h.eff_dt_Invalid>0);
    m_addr_LENGTH_ErrorCount := COUNT(GROUP,h.m_addr_Invalid=1);
    m_city_ALLOW_ErrorCount := COUNT(GROUP,h.m_city_Invalid=1);
    m_state_CUSTOM_ErrorCount := COUNT(GROUP,h.m_state_Invalid=1);
    m_zip_ALLOW_ErrorCount := COUNT(GROUP,h.m_zip_Invalid=1);
    m_zip_LENGTH_ErrorCount := COUNT(GROUP,h.m_zip_Invalid=2);
    m_zip_Total_ErrorCount := COUNT(GROUP,h.m_zip_Invalid>0);
    p_city_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_Invalid=1);
    p_state_CUSTOM_ErrorCount := COUNT(GROUP,h.p_state_Invalid=1);
    p_zip_ALLOW_ErrorCount := COUNT(GROUP,h.p_zip_Invalid=1);
    p_zip_LENGTH_ErrorCount := COUNT(GROUP,h.p_zip_Invalid=2);
    p_zip_Total_ErrorCount := COUNT(GROUP,h.p_zip_Invalid>0);
    clean_name_last_CAPS_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=1);
    clean_name_last_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=2);
    clean_name_last_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=3);
    clean_name_last_Total_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid>0);
    clean_m_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_predir_Invalid=1);
    clean_m_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_postdir_Invalid=1);
    clean_m_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_p_city_name_Invalid=1);
    clean_m_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_v_city_name_Invalid=1);
    clean_m_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_m_st_Invalid=1);
    clean_m_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_zip_Invalid=1);
    clean_m_zip_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_zip_Invalid=2);
    clean_m_zip_Total_ErrorCount := COUNT(GROUP,h.clean_m_zip_Invalid>0);
    clean_m_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_zip4_Invalid=1);
    clean_m_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_zip4_Invalid=2);
    clean_m_zip4_Total_ErrorCount := COUNT(GROUP,h.clean_m_zip4_Invalid>0);
    clean_m_cart_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_cart_Invalid=1);
    clean_m_cart_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_cart_Invalid=2);
    clean_m_cart_Total_ErrorCount := COUNT(GROUP,h.clean_m_cart_Invalid>0);
    clean_m_cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.clean_m_cr_sort_sz_Invalid=1);
    clean_m_lot_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_lot_Invalid=1);
    clean_m_lot_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_lot_Invalid=2);
    clean_m_lot_Total_ErrorCount := COUNT(GROUP,h.clean_m_lot_Invalid>0);
    clean_m_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_lot_order_Invalid=1);
    clean_m_lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_lot_order_Invalid=2);
    clean_m_lot_order_Total_ErrorCount := COUNT(GROUP,h.clean_m_lot_order_Invalid>0);
    clean_m_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_dpbc_Invalid=1);
    clean_m_dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_dpbc_Invalid=2);
    clean_m_dpbc_Total_ErrorCount := COUNT(GROUP,h.clean_m_dpbc_Invalid>0);
    clean_m_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_chk_digit_Invalid=1);
    clean_m_chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_chk_digit_Invalid=2);
    clean_m_chk_digit_Total_ErrorCount := COUNT(GROUP,h.clean_m_chk_digit_Invalid>0);
    clean_m_record_type_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_m_record_type_Invalid=1);
    clean_m_record_type_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_record_type_Invalid=2);
    clean_m_record_type_Total_ErrorCount := COUNT(GROUP,h.clean_m_record_type_Invalid>0);
    clean_m_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_ace_fips_st_Invalid=1);
    clean_m_ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_ace_fips_st_Invalid=2);
    clean_m_ace_fips_st_Total_ErrorCount := COUNT(GROUP,h.clean_m_ace_fips_st_Invalid>0);
    clean_m_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_fipscounty_Invalid=1);
    clean_m_fipscounty_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_fipscounty_Invalid=2);
    clean_m_fipscounty_Total_ErrorCount := COUNT(GROUP,h.clean_m_fipscounty_Invalid>0);
    clean_m_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_geo_lat_Invalid=1);
    clean_m_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_geo_long_Invalid=1);
    clean_m_msa_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_msa_Invalid=1);
    clean_m_msa_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_msa_Invalid=2);
    clean_m_msa_Total_ErrorCount := COUNT(GROUP,h.clean_m_msa_Invalid>0);
    clean_m_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_geo_blk_Invalid=1);
    clean_m_geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_geo_blk_Invalid=2);
    clean_m_geo_blk_Total_ErrorCount := COUNT(GROUP,h.clean_m_geo_blk_Invalid>0);
    clean_m_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_geo_match_Invalid=1);
    clean_m_geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_geo_match_Invalid=2);
    clean_m_geo_match_Total_ErrorCount := COUNT(GROUP,h.clean_m_geo_match_Invalid>0);
    clean_m_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_m_err_stat_Invalid=1);
    clean_m_err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.clean_m_err_stat_Invalid=2);
    clean_m_err_stat_Total_ErrorCount := COUNT(GROUP,h.clean_m_err_stat_Invalid>0);
    clean_p_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_predir_Invalid=1);
    clean_p_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_postdir_Invalid=1);
    clean_p_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_p_city_name_Invalid=1);
    clean_p_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_v_city_name_Invalid=1);
    clean_p_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_p_st_Invalid=1);
    clean_p_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_zip_Invalid=1);
    clean_p_zip_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_zip_Invalid=2);
    clean_p_zip_Total_ErrorCount := COUNT(GROUP,h.clean_p_zip_Invalid>0);
    clean_p_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_zip4_Invalid=1);
    clean_p_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_zip4_Invalid=2);
    clean_p_zip4_Total_ErrorCount := COUNT(GROUP,h.clean_p_zip4_Invalid>0);
    clean_p_cart_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_cart_Invalid=1);
    clean_p_cart_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_cart_Invalid=2);
    clean_p_cart_Total_ErrorCount := COUNT(GROUP,h.clean_p_cart_Invalid>0);
    clean_p_cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.clean_p_cr_sort_sz_Invalid=1);
    clean_p_lot_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_lot_Invalid=1);
    clean_p_lot_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_lot_Invalid=2);
    clean_p_lot_Total_ErrorCount := COUNT(GROUP,h.clean_p_lot_Invalid>0);
    clean_p_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_lot_order_Invalid=1);
    clean_p_lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_lot_order_Invalid=2);
    clean_p_lot_order_Total_ErrorCount := COUNT(GROUP,h.clean_p_lot_order_Invalid>0);
    clean_p_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_dpbc_Invalid=1);
    clean_p_dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_dpbc_Invalid=2);
    clean_p_dpbc_Total_ErrorCount := COUNT(GROUP,h.clean_p_dpbc_Invalid>0);
    clean_p_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_chk_digit_Invalid=1);
    clean_p_chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_chk_digit_Invalid=2);
    clean_p_chk_digit_Total_ErrorCount := COUNT(GROUP,h.clean_p_chk_digit_Invalid>0);
    clean_p_record_type_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_p_record_type_Invalid=1);
    clean_p_record_type_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_record_type_Invalid=2);
    clean_p_record_type_Total_ErrorCount := COUNT(GROUP,h.clean_p_record_type_Invalid>0);
    clean_p_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_ace_fips_st_Invalid=1);
    clean_p_ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_ace_fips_st_Invalid=2);
    clean_p_ace_fips_st_Total_ErrorCount := COUNT(GROUP,h.clean_p_ace_fips_st_Invalid>0);
    clean_p_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_fipscounty_Invalid=1);
    clean_p_fipscounty_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_fipscounty_Invalid=2);
    clean_p_fipscounty_Total_ErrorCount := COUNT(GROUP,h.clean_p_fipscounty_Invalid>0);
    clean_p_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_geo_lat_Invalid=1);
    clean_p_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_geo_long_Invalid=1);
    clean_p_msa_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_msa_Invalid=1);
    clean_p_msa_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_msa_Invalid=2);
    clean_p_msa_Total_ErrorCount := COUNT(GROUP,h.clean_p_msa_Invalid>0);
    clean_p_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_geo_blk_Invalid=1);
    clean_p_geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_geo_blk_Invalid=2);
    clean_p_geo_blk_Total_ErrorCount := COUNT(GROUP,h.clean_p_geo_blk_Invalid>0);
    clean_p_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_geo_match_Invalid=1);
    clean_p_geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_geo_match_Invalid=2);
    clean_p_geo_match_Total_ErrorCount := COUNT(GROUP,h.clean_p_geo_match_Invalid>0);
    clean_p_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_err_stat_Invalid=1);
    clean_p_err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.clean_p_err_stat_Invalid=2);
    clean_p_err_stat_Total_ErrorCount := COUNT(GROUP,h.clean_p_err_stat_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.lst_name_Invalid,le.dob_Invalid,le.dln_Invalid,le.perm_cd_1_Invalid,le.perm_cd_2_Invalid,le.perm_cd_3_Invalid,le.perm_cd_4_Invalid,le.eff_dt_Invalid,le.m_addr_Invalid,le.m_city_Invalid,le.m_state_Invalid,le.m_zip_Invalid,le.p_city_Invalid,le.p_state_Invalid,le.p_zip_Invalid,le.clean_name_last_Invalid,le.clean_m_predir_Invalid,le.clean_m_postdir_Invalid,le.clean_m_p_city_name_Invalid,le.clean_m_v_city_name_Invalid,le.clean_m_st_Invalid,le.clean_m_zip_Invalid,le.clean_m_zip4_Invalid,le.clean_m_cart_Invalid,le.clean_m_cr_sort_sz_Invalid,le.clean_m_lot_Invalid,le.clean_m_lot_order_Invalid,le.clean_m_dpbc_Invalid,le.clean_m_chk_digit_Invalid,le.clean_m_record_type_Invalid,le.clean_m_ace_fips_st_Invalid,le.clean_m_fipscounty_Invalid,le.clean_m_geo_lat_Invalid,le.clean_m_geo_long_Invalid,le.clean_m_msa_Invalid,le.clean_m_geo_blk_Invalid,le.clean_m_geo_match_Invalid,le.clean_m_err_stat_Invalid,le.clean_p_predir_Invalid,le.clean_p_postdir_Invalid,le.clean_p_p_city_name_Invalid,le.clean_p_v_city_name_Invalid,le.clean_p_st_Invalid,le.clean_p_zip_Invalid,le.clean_p_zip4_Invalid,le.clean_p_cart_Invalid,le.clean_p_cr_sort_sz_Invalid,le.clean_p_lot_Invalid,le.clean_p_lot_order_Invalid,le.clean_p_dpbc_Invalid,le.clean_p_chk_digit_Invalid,le.clean_p_record_type_Invalid,le.clean_p_ace_fips_st_Invalid,le.clean_p_fipscounty_Invalid,le.clean_p_geo_lat_Invalid,le.clean_p_geo_long_Invalid,le.clean_p_msa_Invalid,le.clean_p_geo_blk_Invalid,le.clean_p_geo_match_Invalid,le.clean_p_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_lst_name(le.lst_name_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_dln(le.dln_Invalid),Fields.InvalidMessage_perm_cd_1(le.perm_cd_1_Invalid),Fields.InvalidMessage_perm_cd_2(le.perm_cd_2_Invalid),Fields.InvalidMessage_perm_cd_3(le.perm_cd_3_Invalid),Fields.InvalidMessage_perm_cd_4(le.perm_cd_4_Invalid),Fields.InvalidMessage_eff_dt(le.eff_dt_Invalid),Fields.InvalidMessage_m_addr(le.m_addr_Invalid),Fields.InvalidMessage_m_city(le.m_city_Invalid),Fields.InvalidMessage_m_state(le.m_state_Invalid),Fields.InvalidMessage_m_zip(le.m_zip_Invalid),Fields.InvalidMessage_p_city(le.p_city_Invalid),Fields.InvalidMessage_p_state(le.p_state_Invalid),Fields.InvalidMessage_p_zip(le.p_zip_Invalid),Fields.InvalidMessage_clean_name_last(le.clean_name_last_Invalid),Fields.InvalidMessage_clean_m_predir(le.clean_m_predir_Invalid),Fields.InvalidMessage_clean_m_postdir(le.clean_m_postdir_Invalid),Fields.InvalidMessage_clean_m_p_city_name(le.clean_m_p_city_name_Invalid),Fields.InvalidMessage_clean_m_v_city_name(le.clean_m_v_city_name_Invalid),Fields.InvalidMessage_clean_m_st(le.clean_m_st_Invalid),Fields.InvalidMessage_clean_m_zip(le.clean_m_zip_Invalid),Fields.InvalidMessage_clean_m_zip4(le.clean_m_zip4_Invalid),Fields.InvalidMessage_clean_m_cart(le.clean_m_cart_Invalid),Fields.InvalidMessage_clean_m_cr_sort_sz(le.clean_m_cr_sort_sz_Invalid),Fields.InvalidMessage_clean_m_lot(le.clean_m_lot_Invalid),Fields.InvalidMessage_clean_m_lot_order(le.clean_m_lot_order_Invalid),Fields.InvalidMessage_clean_m_dpbc(le.clean_m_dpbc_Invalid),Fields.InvalidMessage_clean_m_chk_digit(le.clean_m_chk_digit_Invalid),Fields.InvalidMessage_clean_m_record_type(le.clean_m_record_type_Invalid),Fields.InvalidMessage_clean_m_ace_fips_st(le.clean_m_ace_fips_st_Invalid),Fields.InvalidMessage_clean_m_fipscounty(le.clean_m_fipscounty_Invalid),Fields.InvalidMessage_clean_m_geo_lat(le.clean_m_geo_lat_Invalid),Fields.InvalidMessage_clean_m_geo_long(le.clean_m_geo_long_Invalid),Fields.InvalidMessage_clean_m_msa(le.clean_m_msa_Invalid),Fields.InvalidMessage_clean_m_geo_blk(le.clean_m_geo_blk_Invalid),Fields.InvalidMessage_clean_m_geo_match(le.clean_m_geo_match_Invalid),Fields.InvalidMessage_clean_m_err_stat(le.clean_m_err_stat_Invalid),Fields.InvalidMessage_clean_p_predir(le.clean_p_predir_Invalid),Fields.InvalidMessage_clean_p_postdir(le.clean_p_postdir_Invalid),Fields.InvalidMessage_clean_p_p_city_name(le.clean_p_p_city_name_Invalid),Fields.InvalidMessage_clean_p_v_city_name(le.clean_p_v_city_name_Invalid),Fields.InvalidMessage_clean_p_st(le.clean_p_st_Invalid),Fields.InvalidMessage_clean_p_zip(le.clean_p_zip_Invalid),Fields.InvalidMessage_clean_p_zip4(le.clean_p_zip4_Invalid),Fields.InvalidMessage_clean_p_cart(le.clean_p_cart_Invalid),Fields.InvalidMessage_clean_p_cr_sort_sz(le.clean_p_cr_sort_sz_Invalid),Fields.InvalidMessage_clean_p_lot(le.clean_p_lot_Invalid),Fields.InvalidMessage_clean_p_lot_order(le.clean_p_lot_order_Invalid),Fields.InvalidMessage_clean_p_dpbc(le.clean_p_dpbc_Invalid),Fields.InvalidMessage_clean_p_chk_digit(le.clean_p_chk_digit_Invalid),Fields.InvalidMessage_clean_p_record_type(le.clean_p_record_type_Invalid),Fields.InvalidMessage_clean_p_ace_fips_st(le.clean_p_ace_fips_st_Invalid),Fields.InvalidMessage_clean_p_fipscounty(le.clean_p_fipscounty_Invalid),Fields.InvalidMessage_clean_p_geo_lat(le.clean_p_geo_lat_Invalid),Fields.InvalidMessage_clean_p_geo_long(le.clean_p_geo_long_Invalid),Fields.InvalidMessage_clean_p_msa(le.clean_p_msa_Invalid),Fields.InvalidMessage_clean_p_geo_blk(le.clean_p_geo_blk_Invalid),Fields.InvalidMessage_clean_p_geo_match(le.clean_p_geo_match_Invalid),Fields.InvalidMessage_clean_p_err_stat(le.clean_p_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.lst_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dln_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.perm_cd_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.perm_cd_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.perm_cd_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.perm_cd_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eff_dt_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.m_addr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.m_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.m_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_last_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_m_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_m_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_m_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_m_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_m_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_m_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_m_lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_record_type_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_ace_fips_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_fipscounty_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_m_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_m_msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_m_err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_p_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_p_lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_record_type_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_ace_fips_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_fipscounty_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_p_err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','lst_name','dob','dln','perm_cd_1','perm_cd_2','perm_cd_3','perm_cd_4','eff_dt','m_addr','m_city','m_state','m_zip','p_city','p_state','p_zip','clean_name_last','clean_m_predir','clean_m_postdir','clean_m_p_city_name','clean_m_v_city_name','clean_m_st','clean_m_zip','clean_m_zip4','clean_m_cart','clean_m_cr_sort_sz','clean_m_lot','clean_m_lot_order','clean_m_dpbc','clean_m_chk_digit','clean_m_record_type','clean_m_ace_fips_st','clean_m_fipscounty','clean_m_geo_lat','clean_m_geo_long','clean_m_msa','clean_m_geo_blk','clean_m_geo_match','clean_m_err_stat','clean_p_predir','clean_p_postdir','clean_p_p_city_name','clean_p_v_city_name','clean_p_st','clean_p_zip','clean_p_zip4','clean_p_cart','clean_p_cr_sort_sz','clean_p_lot','clean_p_lot_order','clean_p_dpbc','clean_p_chk_digit','clean_p_record_type','clean_p_ace_fips_st','clean_p_fipscounty','clean_p_geo_lat','clean_p_geo_long','clean_p_msa','clean_p_geo_blk','clean_p_geo_match','clean_p_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_6pastdate','invalid_6pastdate','invalid_6pastdate','invalid_6pastdate','invalid_name','invalid_8pastdate','invalid_dln','invalid_perm_cd','invalid_perm_cd','invalid_perm_cd','invalid_perm_cd','invalid_8pastdate','invalid_mandatory','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_clean_name','invalid_direction','invalid_direction','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_direction','invalid_direction','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.append_process_date,(SALT35.StrType)le.dt_first_seen,(SALT35.StrType)le.dt_last_seen,(SALT35.StrType)le.dt_vendor_first_reported,(SALT35.StrType)le.dt_vendor_last_reported,(SALT35.StrType)le.lst_name,(SALT35.StrType)le.dob,(SALT35.StrType)le.dln,(SALT35.StrType)le.perm_cd_1,(SALT35.StrType)le.perm_cd_2,(SALT35.StrType)le.perm_cd_3,(SALT35.StrType)le.perm_cd_4,(SALT35.StrType)le.eff_dt,(SALT35.StrType)le.m_addr,(SALT35.StrType)le.m_city,(SALT35.StrType)le.m_state,(SALT35.StrType)le.m_zip,(SALT35.StrType)le.p_city,(SALT35.StrType)le.p_state,(SALT35.StrType)le.p_zip,(SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_m_predir,(SALT35.StrType)le.clean_m_postdir,(SALT35.StrType)le.clean_m_p_city_name,(SALT35.StrType)le.clean_m_v_city_name,(SALT35.StrType)le.clean_m_st,(SALT35.StrType)le.clean_m_zip,(SALT35.StrType)le.clean_m_zip4,(SALT35.StrType)le.clean_m_cart,(SALT35.StrType)le.clean_m_cr_sort_sz,(SALT35.StrType)le.clean_m_lot,(SALT35.StrType)le.clean_m_lot_order,(SALT35.StrType)le.clean_m_dpbc,(SALT35.StrType)le.clean_m_chk_digit,(SALT35.StrType)le.clean_m_record_type,(SALT35.StrType)le.clean_m_ace_fips_st,(SALT35.StrType)le.clean_m_fipscounty,(SALT35.StrType)le.clean_m_geo_lat,(SALT35.StrType)le.clean_m_geo_long,(SALT35.StrType)le.clean_m_msa,(SALT35.StrType)le.clean_m_geo_blk,(SALT35.StrType)le.clean_m_geo_match,(SALT35.StrType)le.clean_m_err_stat,(SALT35.StrType)le.clean_p_predir,(SALT35.StrType)le.clean_p_postdir,(SALT35.StrType)le.clean_p_p_city_name,(SALT35.StrType)le.clean_p_v_city_name,(SALT35.StrType)le.clean_p_st,(SALT35.StrType)le.clean_p_zip,(SALT35.StrType)le.clean_p_zip4,(SALT35.StrType)le.clean_p_cart,(SALT35.StrType)le.clean_p_cr_sort_sz,(SALT35.StrType)le.clean_p_lot,(SALT35.StrType)le.clean_p_lot_order,(SALT35.StrType)le.clean_p_dpbc,(SALT35.StrType)le.clean_p_chk_digit,(SALT35.StrType)le.clean_p_record_type,(SALT35.StrType)le.clean_p_ace_fips_st,(SALT35.StrType)le.clean_p_fipscounty,(SALT35.StrType)le.clean_p_geo_lat,(SALT35.StrType)le.clean_p_geo_long,(SALT35.StrType)le.clean_p_msa,(SALT35.StrType)le.clean_p_geo_blk,(SALT35.StrType)le.clean_p_geo_match,(SALT35.StrType)le.clean_p_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,65,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_8pastdate:CUSTOM','append_process_date:invalid_8pastdate:LENGTH'
          ,'dt_first_seen:invalid_6pastdate:ALLOW','dt_first_seen:invalid_6pastdate:CUSTOM','dt_first_seen:invalid_6pastdate:LENGTH'
          ,'dt_last_seen:invalid_6pastdate:ALLOW','dt_last_seen:invalid_6pastdate:CUSTOM','dt_last_seen:invalid_6pastdate:LENGTH'
          ,'dt_vendor_first_reported:invalid_6pastdate:ALLOW','dt_vendor_first_reported:invalid_6pastdate:CUSTOM','dt_vendor_first_reported:invalid_6pastdate:LENGTH'
          ,'dt_vendor_last_reported:invalid_6pastdate:ALLOW','dt_vendor_last_reported:invalid_6pastdate:CUSTOM','dt_vendor_last_reported:invalid_6pastdate:LENGTH'
          ,'lst_name:invalid_name:CUSTOM'
          ,'dob:invalid_8pastdate:CUSTOM','dob:invalid_8pastdate:LENGTH'
          ,'dln:invalid_dln:ALLOW','dln:invalid_dln:LENGTH'
          ,'perm_cd_1:invalid_perm_cd:CUSTOM'
          ,'perm_cd_2:invalid_perm_cd:CUSTOM'
          ,'perm_cd_3:invalid_perm_cd:CUSTOM'
          ,'perm_cd_4:invalid_perm_cd:CUSTOM'
          ,'eff_dt:invalid_8pastdate:CUSTOM','eff_dt:invalid_8pastdate:LENGTH'
          ,'m_addr:invalid_mandatory:LENGTH'
          ,'m_city:invalid_alpha_num_specials:ALLOW'
          ,'m_state:invalid_state:CUSTOM'
          ,'m_zip:invalid_zip5:ALLOW','m_zip:invalid_zip5:LENGTH'
          ,'p_city:invalid_alpha_num_specials:ALLOW'
          ,'p_state:invalid_state:CUSTOM'
          ,'p_zip:invalid_zip5:ALLOW','p_zip:invalid_zip5:LENGTH'
          ,'clean_name_last:invalid_clean_name:CAPS','clean_name_last:invalid_clean_name:ALLOW','clean_name_last:invalid_clean_name:CUSTOM'
          ,'clean_m_predir:invalid_direction:ALLOW'
          ,'clean_m_postdir:invalid_direction:ALLOW'
          ,'clean_m_p_city_name:invalid_alpha_num_specials:ALLOW'
          ,'clean_m_v_city_name:invalid_alpha_num_specials:ALLOW'
          ,'clean_m_st:invalid_state:CUSTOM'
          ,'clean_m_zip:invalid_zip5:ALLOW','clean_m_zip:invalid_zip5:LENGTH'
          ,'clean_m_zip4:invalid_zip4:ALLOW','clean_m_zip4:invalid_zip4:LENGTH'
          ,'clean_m_cart:invalid_cart:ALLOW','clean_m_cart:invalid_cart:LENGTH'
          ,'clean_m_cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'clean_m_lot:invalid_lot:ALLOW','clean_m_lot:invalid_lot:LENGTH'
          ,'clean_m_lot_order:invalid_lot_order:ALLOW','clean_m_lot_order:invalid_lot_order:LENGTH'
          ,'clean_m_dpbc:invalid_dpbc:ALLOW','clean_m_dpbc:invalid_dpbc:LENGTH'
          ,'clean_m_chk_digit:invalid_chk_digit:ALLOW','clean_m_chk_digit:invalid_chk_digit:LENGTH'
          ,'clean_m_record_type:invalid_record_type:CUSTOM','clean_m_record_type:invalid_record_type:LENGTH'
          ,'clean_m_ace_fips_st:invalid_ace_fips_st:ALLOW','clean_m_ace_fips_st:invalid_ace_fips_st:LENGTH'
          ,'clean_m_fipscounty:invalid_fipscounty:ALLOW','clean_m_fipscounty:invalid_fipscounty:LENGTH'
          ,'clean_m_geo_lat:invalid_geo:ALLOW'
          ,'clean_m_geo_long:invalid_geo:ALLOW'
          ,'clean_m_msa:invalid_msa:ALLOW','clean_m_msa:invalid_msa:LENGTH'
          ,'clean_m_geo_blk:invalid_geo_blk:ALLOW','clean_m_geo_blk:invalid_geo_blk:LENGTH'
          ,'clean_m_geo_match:invalid_geo_match:ALLOW','clean_m_geo_match:invalid_geo_match:LENGTH'
          ,'clean_m_err_stat:invalid_err_stat:ALLOW','clean_m_err_stat:invalid_err_stat:LENGTH'
          ,'clean_p_predir:invalid_direction:ALLOW'
          ,'clean_p_postdir:invalid_direction:ALLOW'
          ,'clean_p_p_city_name:invalid_alpha_num_specials:ALLOW'
          ,'clean_p_v_city_name:invalid_alpha_num_specials:ALLOW'
          ,'clean_p_st:invalid_state:CUSTOM'
          ,'clean_p_zip:invalid_zip5:ALLOW','clean_p_zip:invalid_zip5:LENGTH'
          ,'clean_p_zip4:invalid_zip4:ALLOW','clean_p_zip4:invalid_zip4:LENGTH'
          ,'clean_p_cart:invalid_cart:ALLOW','clean_p_cart:invalid_cart:LENGTH'
          ,'clean_p_cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'clean_p_lot:invalid_lot:ALLOW','clean_p_lot:invalid_lot:LENGTH'
          ,'clean_p_lot_order:invalid_lot_order:ALLOW','clean_p_lot_order:invalid_lot_order:LENGTH'
          ,'clean_p_dpbc:invalid_dpbc:ALLOW','clean_p_dpbc:invalid_dpbc:LENGTH'
          ,'clean_p_chk_digit:invalid_chk_digit:ALLOW','clean_p_chk_digit:invalid_chk_digit:LENGTH'
          ,'clean_p_record_type:invalid_record_type:CUSTOM','clean_p_record_type:invalid_record_type:LENGTH'
          ,'clean_p_ace_fips_st:invalid_ace_fips_st:ALLOW','clean_p_ace_fips_st:invalid_ace_fips_st:LENGTH'
          ,'clean_p_fipscounty:invalid_fipscounty:ALLOW','clean_p_fipscounty:invalid_fipscounty:LENGTH'
          ,'clean_p_geo_lat:invalid_geo:ALLOW'
          ,'clean_p_geo_long:invalid_geo:ALLOW'
          ,'clean_p_msa:invalid_msa:ALLOW','clean_p_msa:invalid_msa:LENGTH'
          ,'clean_p_geo_blk:invalid_geo_blk:ALLOW','clean_p_geo_blk:invalid_geo_blk:LENGTH'
          ,'clean_p_geo_match:invalid_geo_match:ALLOW','clean_p_geo_match:invalid_geo_match:LENGTH'
          ,'clean_p_err_stat:invalid_err_stat:ALLOW','clean_p_err_stat:invalid_err_stat:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1),Fields.InvalidMessage_append_process_date(2)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3)
          ,Fields.InvalidMessage_lst_name(1)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_dln(1),Fields.InvalidMessage_dln(2)
          ,Fields.InvalidMessage_perm_cd_1(1)
          ,Fields.InvalidMessage_perm_cd_2(1)
          ,Fields.InvalidMessage_perm_cd_3(1)
          ,Fields.InvalidMessage_perm_cd_4(1)
          ,Fields.InvalidMessage_eff_dt(1),Fields.InvalidMessage_eff_dt(2)
          ,Fields.InvalidMessage_m_addr(1)
          ,Fields.InvalidMessage_m_city(1)
          ,Fields.InvalidMessage_m_state(1)
          ,Fields.InvalidMessage_m_zip(1),Fields.InvalidMessage_m_zip(2)
          ,Fields.InvalidMessage_p_city(1)
          ,Fields.InvalidMessage_p_state(1)
          ,Fields.InvalidMessage_p_zip(1),Fields.InvalidMessage_p_zip(2)
          ,Fields.InvalidMessage_clean_name_last(1),Fields.InvalidMessage_clean_name_last(2),Fields.InvalidMessage_clean_name_last(3)
          ,Fields.InvalidMessage_clean_m_predir(1)
          ,Fields.InvalidMessage_clean_m_postdir(1)
          ,Fields.InvalidMessage_clean_m_p_city_name(1)
          ,Fields.InvalidMessage_clean_m_v_city_name(1)
          ,Fields.InvalidMessage_clean_m_st(1)
          ,Fields.InvalidMessage_clean_m_zip(1),Fields.InvalidMessage_clean_m_zip(2)
          ,Fields.InvalidMessage_clean_m_zip4(1),Fields.InvalidMessage_clean_m_zip4(2)
          ,Fields.InvalidMessage_clean_m_cart(1),Fields.InvalidMessage_clean_m_cart(2)
          ,Fields.InvalidMessage_clean_m_cr_sort_sz(1)
          ,Fields.InvalidMessage_clean_m_lot(1),Fields.InvalidMessage_clean_m_lot(2)
          ,Fields.InvalidMessage_clean_m_lot_order(1),Fields.InvalidMessage_clean_m_lot_order(2)
          ,Fields.InvalidMessage_clean_m_dpbc(1),Fields.InvalidMessage_clean_m_dpbc(2)
          ,Fields.InvalidMessage_clean_m_chk_digit(1),Fields.InvalidMessage_clean_m_chk_digit(2)
          ,Fields.InvalidMessage_clean_m_record_type(1),Fields.InvalidMessage_clean_m_record_type(2)
          ,Fields.InvalidMessage_clean_m_ace_fips_st(1),Fields.InvalidMessage_clean_m_ace_fips_st(2)
          ,Fields.InvalidMessage_clean_m_fipscounty(1),Fields.InvalidMessage_clean_m_fipscounty(2)
          ,Fields.InvalidMessage_clean_m_geo_lat(1)
          ,Fields.InvalidMessage_clean_m_geo_long(1)
          ,Fields.InvalidMessage_clean_m_msa(1),Fields.InvalidMessage_clean_m_msa(2)
          ,Fields.InvalidMessage_clean_m_geo_blk(1),Fields.InvalidMessage_clean_m_geo_blk(2)
          ,Fields.InvalidMessage_clean_m_geo_match(1),Fields.InvalidMessage_clean_m_geo_match(2)
          ,Fields.InvalidMessage_clean_m_err_stat(1),Fields.InvalidMessage_clean_m_err_stat(2)
          ,Fields.InvalidMessage_clean_p_predir(1)
          ,Fields.InvalidMessage_clean_p_postdir(1)
          ,Fields.InvalidMessage_clean_p_p_city_name(1)
          ,Fields.InvalidMessage_clean_p_v_city_name(1)
          ,Fields.InvalidMessage_clean_p_st(1)
          ,Fields.InvalidMessage_clean_p_zip(1),Fields.InvalidMessage_clean_p_zip(2)
          ,Fields.InvalidMessage_clean_p_zip4(1),Fields.InvalidMessage_clean_p_zip4(2)
          ,Fields.InvalidMessage_clean_p_cart(1),Fields.InvalidMessage_clean_p_cart(2)
          ,Fields.InvalidMessage_clean_p_cr_sort_sz(1)
          ,Fields.InvalidMessage_clean_p_lot(1),Fields.InvalidMessage_clean_p_lot(2)
          ,Fields.InvalidMessage_clean_p_lot_order(1),Fields.InvalidMessage_clean_p_lot_order(2)
          ,Fields.InvalidMessage_clean_p_dpbc(1),Fields.InvalidMessage_clean_p_dpbc(2)
          ,Fields.InvalidMessage_clean_p_chk_digit(1),Fields.InvalidMessage_clean_p_chk_digit(2)
          ,Fields.InvalidMessage_clean_p_record_type(1),Fields.InvalidMessage_clean_p_record_type(2)
          ,Fields.InvalidMessage_clean_p_ace_fips_st(1),Fields.InvalidMessage_clean_p_ace_fips_st(2)
          ,Fields.InvalidMessage_clean_p_fipscounty(1),Fields.InvalidMessage_clean_p_fipscounty(2)
          ,Fields.InvalidMessage_clean_p_geo_lat(1)
          ,Fields.InvalidMessage_clean_p_geo_long(1)
          ,Fields.InvalidMessage_clean_p_msa(1),Fields.InvalidMessage_clean_p_msa(2)
          ,Fields.InvalidMessage_clean_p_geo_blk(1),Fields.InvalidMessage_clean_p_geo_blk(2)
          ,Fields.InvalidMessage_clean_p_geo_match(1),Fields.InvalidMessage_clean_p_geo_match(2)
          ,Fields.InvalidMessage_clean_p_err_stat(1),Fields.InvalidMessage_clean_p_err_stat(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.lst_name_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.dln_ALLOW_ErrorCount,le.dln_LENGTH_ErrorCount
          ,le.perm_cd_1_CUSTOM_ErrorCount
          ,le.perm_cd_2_CUSTOM_ErrorCount
          ,le.perm_cd_3_CUSTOM_ErrorCount
          ,le.perm_cd_4_CUSTOM_ErrorCount
          ,le.eff_dt_CUSTOM_ErrorCount,le.eff_dt_LENGTH_ErrorCount
          ,le.m_addr_LENGTH_ErrorCount
          ,le.m_city_ALLOW_ErrorCount
          ,le.m_state_CUSTOM_ErrorCount
          ,le.m_zip_ALLOW_ErrorCount,le.m_zip_LENGTH_ErrorCount
          ,le.p_city_ALLOW_ErrorCount
          ,le.p_state_CUSTOM_ErrorCount
          ,le.p_zip_ALLOW_ErrorCount,le.p_zip_LENGTH_ErrorCount
          ,le.clean_name_last_CAPS_ErrorCount,le.clean_name_last_ALLOW_ErrorCount,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_m_predir_ALLOW_ErrorCount
          ,le.clean_m_postdir_ALLOW_ErrorCount
          ,le.clean_m_p_city_name_ALLOW_ErrorCount
          ,le.clean_m_v_city_name_ALLOW_ErrorCount
          ,le.clean_m_st_CUSTOM_ErrorCount
          ,le.clean_m_zip_ALLOW_ErrorCount,le.clean_m_zip_LENGTH_ErrorCount
          ,le.clean_m_zip4_ALLOW_ErrorCount,le.clean_m_zip4_LENGTH_ErrorCount
          ,le.clean_m_cart_ALLOW_ErrorCount,le.clean_m_cart_LENGTH_ErrorCount
          ,le.clean_m_cr_sort_sz_ENUM_ErrorCount
          ,le.clean_m_lot_ALLOW_ErrorCount,le.clean_m_lot_LENGTH_ErrorCount
          ,le.clean_m_lot_order_ALLOW_ErrorCount,le.clean_m_lot_order_LENGTH_ErrorCount
          ,le.clean_m_dpbc_ALLOW_ErrorCount,le.clean_m_dpbc_LENGTH_ErrorCount
          ,le.clean_m_chk_digit_ALLOW_ErrorCount,le.clean_m_chk_digit_LENGTH_ErrorCount
          ,le.clean_m_record_type_CUSTOM_ErrorCount,le.clean_m_record_type_LENGTH_ErrorCount
          ,le.clean_m_ace_fips_st_ALLOW_ErrorCount,le.clean_m_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_m_fipscounty_ALLOW_ErrorCount,le.clean_m_fipscounty_LENGTH_ErrorCount
          ,le.clean_m_geo_lat_ALLOW_ErrorCount
          ,le.clean_m_geo_long_ALLOW_ErrorCount
          ,le.clean_m_msa_ALLOW_ErrorCount,le.clean_m_msa_LENGTH_ErrorCount
          ,le.clean_m_geo_blk_ALLOW_ErrorCount,le.clean_m_geo_blk_LENGTH_ErrorCount
          ,le.clean_m_geo_match_ALLOW_ErrorCount,le.clean_m_geo_match_LENGTH_ErrorCount
          ,le.clean_m_err_stat_ALLOW_ErrorCount,le.clean_m_err_stat_LENGTH_ErrorCount
          ,le.clean_p_predir_ALLOW_ErrorCount
          ,le.clean_p_postdir_ALLOW_ErrorCount
          ,le.clean_p_p_city_name_ALLOW_ErrorCount
          ,le.clean_p_v_city_name_ALLOW_ErrorCount
          ,le.clean_p_st_CUSTOM_ErrorCount
          ,le.clean_p_zip_ALLOW_ErrorCount,le.clean_p_zip_LENGTH_ErrorCount
          ,le.clean_p_zip4_ALLOW_ErrorCount,le.clean_p_zip4_LENGTH_ErrorCount
          ,le.clean_p_cart_ALLOW_ErrorCount,le.clean_p_cart_LENGTH_ErrorCount
          ,le.clean_p_cr_sort_sz_ENUM_ErrorCount
          ,le.clean_p_lot_ALLOW_ErrorCount,le.clean_p_lot_LENGTH_ErrorCount
          ,le.clean_p_lot_order_ALLOW_ErrorCount,le.clean_p_lot_order_LENGTH_ErrorCount
          ,le.clean_p_dpbc_ALLOW_ErrorCount,le.clean_p_dpbc_LENGTH_ErrorCount
          ,le.clean_p_chk_digit_ALLOW_ErrorCount,le.clean_p_chk_digit_LENGTH_ErrorCount
          ,le.clean_p_record_type_CUSTOM_ErrorCount,le.clean_p_record_type_LENGTH_ErrorCount
          ,le.clean_p_ace_fips_st_ALLOW_ErrorCount,le.clean_p_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_p_fipscounty_ALLOW_ErrorCount,le.clean_p_fipscounty_LENGTH_ErrorCount
          ,le.clean_p_geo_lat_ALLOW_ErrorCount
          ,le.clean_p_geo_long_ALLOW_ErrorCount
          ,le.clean_p_msa_ALLOW_ErrorCount,le.clean_p_msa_LENGTH_ErrorCount
          ,le.clean_p_geo_blk_ALLOW_ErrorCount,le.clean_p_geo_blk_LENGTH_ErrorCount
          ,le.clean_p_geo_match_ALLOW_ErrorCount,le.clean_p_geo_match_LENGTH_ErrorCount
          ,le.clean_p_err_stat_ALLOW_ErrorCount,le.clean_p_err_stat_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_CUSTOM_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_CUSTOM_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_CUSTOM_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_CUSTOM_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount
          ,le.lst_name_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.dln_ALLOW_ErrorCount,le.dln_LENGTH_ErrorCount
          ,le.perm_cd_1_CUSTOM_ErrorCount
          ,le.perm_cd_2_CUSTOM_ErrorCount
          ,le.perm_cd_3_CUSTOM_ErrorCount
          ,le.perm_cd_4_CUSTOM_ErrorCount
          ,le.eff_dt_CUSTOM_ErrorCount,le.eff_dt_LENGTH_ErrorCount
          ,le.m_addr_LENGTH_ErrorCount
          ,le.m_city_ALLOW_ErrorCount
          ,le.m_state_CUSTOM_ErrorCount
          ,le.m_zip_ALLOW_ErrorCount,le.m_zip_LENGTH_ErrorCount
          ,le.p_city_ALLOW_ErrorCount
          ,le.p_state_CUSTOM_ErrorCount
          ,le.p_zip_ALLOW_ErrorCount,le.p_zip_LENGTH_ErrorCount
          ,le.clean_name_last_CAPS_ErrorCount,le.clean_name_last_ALLOW_ErrorCount,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_m_predir_ALLOW_ErrorCount
          ,le.clean_m_postdir_ALLOW_ErrorCount
          ,le.clean_m_p_city_name_ALLOW_ErrorCount
          ,le.clean_m_v_city_name_ALLOW_ErrorCount
          ,le.clean_m_st_CUSTOM_ErrorCount
          ,le.clean_m_zip_ALLOW_ErrorCount,le.clean_m_zip_LENGTH_ErrorCount
          ,le.clean_m_zip4_ALLOW_ErrorCount,le.clean_m_zip4_LENGTH_ErrorCount
          ,le.clean_m_cart_ALLOW_ErrorCount,le.clean_m_cart_LENGTH_ErrorCount
          ,le.clean_m_cr_sort_sz_ENUM_ErrorCount
          ,le.clean_m_lot_ALLOW_ErrorCount,le.clean_m_lot_LENGTH_ErrorCount
          ,le.clean_m_lot_order_ALLOW_ErrorCount,le.clean_m_lot_order_LENGTH_ErrorCount
          ,le.clean_m_dpbc_ALLOW_ErrorCount,le.clean_m_dpbc_LENGTH_ErrorCount
          ,le.clean_m_chk_digit_ALLOW_ErrorCount,le.clean_m_chk_digit_LENGTH_ErrorCount
          ,le.clean_m_record_type_CUSTOM_ErrorCount,le.clean_m_record_type_LENGTH_ErrorCount
          ,le.clean_m_ace_fips_st_ALLOW_ErrorCount,le.clean_m_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_m_fipscounty_ALLOW_ErrorCount,le.clean_m_fipscounty_LENGTH_ErrorCount
          ,le.clean_m_geo_lat_ALLOW_ErrorCount
          ,le.clean_m_geo_long_ALLOW_ErrorCount
          ,le.clean_m_msa_ALLOW_ErrorCount,le.clean_m_msa_LENGTH_ErrorCount
          ,le.clean_m_geo_blk_ALLOW_ErrorCount,le.clean_m_geo_blk_LENGTH_ErrorCount
          ,le.clean_m_geo_match_ALLOW_ErrorCount,le.clean_m_geo_match_LENGTH_ErrorCount
          ,le.clean_m_err_stat_ALLOW_ErrorCount,le.clean_m_err_stat_LENGTH_ErrorCount
          ,le.clean_p_predir_ALLOW_ErrorCount
          ,le.clean_p_postdir_ALLOW_ErrorCount
          ,le.clean_p_p_city_name_ALLOW_ErrorCount
          ,le.clean_p_v_city_name_ALLOW_ErrorCount
          ,le.clean_p_st_CUSTOM_ErrorCount
          ,le.clean_p_zip_ALLOW_ErrorCount,le.clean_p_zip_LENGTH_ErrorCount
          ,le.clean_p_zip4_ALLOW_ErrorCount,le.clean_p_zip4_LENGTH_ErrorCount
          ,le.clean_p_cart_ALLOW_ErrorCount,le.clean_p_cart_LENGTH_ErrorCount
          ,le.clean_p_cr_sort_sz_ENUM_ErrorCount
          ,le.clean_p_lot_ALLOW_ErrorCount,le.clean_p_lot_LENGTH_ErrorCount
          ,le.clean_p_lot_order_ALLOW_ErrorCount,le.clean_p_lot_order_LENGTH_ErrorCount
          ,le.clean_p_dpbc_ALLOW_ErrorCount,le.clean_p_dpbc_LENGTH_ErrorCount
          ,le.clean_p_chk_digit_ALLOW_ErrorCount,le.clean_p_chk_digit_LENGTH_ErrorCount
          ,le.clean_p_record_type_CUSTOM_ErrorCount,le.clean_p_record_type_LENGTH_ErrorCount
          ,le.clean_p_ace_fips_st_ALLOW_ErrorCount,le.clean_p_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_p_fipscounty_ALLOW_ErrorCount,le.clean_p_fipscounty_LENGTH_ErrorCount
          ,le.clean_p_geo_lat_ALLOW_ErrorCount
          ,le.clean_p_geo_long_ALLOW_ErrorCount
          ,le.clean_p_msa_ALLOW_ErrorCount,le.clean_p_msa_LENGTH_ErrorCount
          ,le.clean_p_geo_blk_ALLOW_ErrorCount,le.clean_p_geo_blk_LENGTH_ErrorCount
          ,le.clean_p_geo_match_ALLOW_ErrorCount,le.clean_p_geo_match_LENGTH_ErrorCount
          ,le.clean_p_err_stat_ALLOW_ErrorCount,le.clean_p_err_stat_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,109,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT35.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT35.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
