IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_WI; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_WI)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 orig_dl_number_Invalid;
    UNSIGNED1 orig_last_name_Invalid;
    UNSIGNED1 orig_sex_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_county_name_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_code_Invalid;
    UNSIGNED1 orig_opt_out_code_Invalid;
    UNSIGNED1 orig_license_counter_Invalid;
    UNSIGNED1 append_license_type_Invalid;
    UNSIGNED1 append_classes_Invalid;
    UNSIGNED1 append_endorsements_Invalid;
    UNSIGNED1 append_issue_date_Invalid;
    UNSIGNED1 append_expiration_date_Invalid;
    UNSIGNED1 clean_name_last_Invalid;
    UNSIGNED1 clean_name_score_Invalid;
    UNSIGNED1 clean_predir_Invalid;
    UNSIGNED1 clean_prim_name_Invalid;
    UNSIGNED1 clean_postdir_Invalid;
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
  EXPORT  Bitmap_Layout := RECORD(Layout_In_WI)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_WI) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT35.StrType)le.append_process_date);
    SELF.orig_dl_number_Invalid := Fields.InValid_orig_dl_number((SALT35.StrType)le.orig_dl_number);
    SELF.orig_last_name_Invalid := Fields.InValid_orig_last_name((SALT35.StrType)le.orig_last_name,(SALT35.StrType)le.orig_first_name,(SALT35.StrType)le.orig_middle_initial);
    SELF.orig_sex_Invalid := Fields.InValid_orig_sex((SALT35.StrType)le.orig_sex);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT35.StrType)le.orig_dob);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT35.StrType)le.orig_city);
    SELF.orig_address1_Invalid := Fields.InValid_orig_address1((SALT35.StrType)le.orig_address1);
    SELF.orig_county_name_Invalid := Fields.InValid_orig_county_name((SALT35.StrType)le.orig_county_name);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT35.StrType)le.orig_state);
    SELF.orig_zip_code_Invalid := Fields.InValid_orig_zip_code((SALT35.StrType)le.orig_zip_code);
    SELF.orig_opt_out_code_Invalid := Fields.InValid_orig_opt_out_code((SALT35.StrType)le.orig_opt_out_code);
    SELF.orig_license_counter_Invalid := Fields.InValid_orig_license_counter((SALT35.StrType)le.orig_license_counter);
    SELF.append_license_type_Invalid := Fields.InValid_append_license_type((SALT35.StrType)le.append_license_type);
    SELF.append_classes_Invalid := Fields.InValid_append_classes((SALT35.StrType)le.append_classes);
    SELF.append_endorsements_Invalid := Fields.InValid_append_endorsements((SALT35.StrType)le.append_endorsements);
    SELF.append_issue_date_Invalid := Fields.InValid_append_issue_date((SALT35.StrType)le.append_issue_date);
    SELF.append_expiration_date_Invalid := Fields.InValid_append_expiration_date((SALT35.StrType)le.append_expiration_date);
    SELF.clean_name_last_Invalid := Fields.InValid_clean_name_last((SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_first,(SALT35.StrType)le.clean_name_middle);
    SELF.clean_name_score_Invalid := Fields.InValid_clean_name_score((SALT35.StrType)le.clean_name_score);
    SELF.clean_predir_Invalid := Fields.InValid_clean_predir((SALT35.StrType)le.clean_predir);
    SELF.clean_prim_name_Invalid := Fields.InValid_clean_prim_name((SALT35.StrType)le.clean_prim_name);
    SELF.clean_postdir_Invalid := Fields.InValid_clean_postdir((SALT35.StrType)le.clean_postdir);
    SELF.clean_p_city_name_Invalid := Fields.InValid_clean_p_city_name((SALT35.StrType)le.clean_p_city_name);
    SELF.clean_v_city_name_Invalid := Fields.InValid_clean_v_city_name((SALT35.StrType)le.clean_v_city_name);
    SELF.clean_st_Invalid := Fields.InValid_clean_st((SALT35.StrType)le.clean_st);
    SELF.clean_zip_Invalid := Fields.InValid_clean_zip((SALT35.StrType)le.clean_zip);
    SELF.clean_zip4_Invalid := Fields.InValid_clean_zip4((SALT35.StrType)le.clean_zip4);
    SELF.clean_cart_Invalid := Fields.InValid_clean_cart((SALT35.StrType)le.clean_cart);
    SELF.clean_cr_sort_sz_Invalid := Fields.InValid_clean_cr_sort_sz((SALT35.StrType)le.clean_cr_sort_sz);
    SELF.clean_lot_Invalid := Fields.InValid_clean_lot((SALT35.StrType)le.clean_lot);
    SELF.clean_lot_order_Invalid := Fields.InValid_clean_lot_order((SALT35.StrType)le.clean_lot_order);
    SELF.clean_dpbc_Invalid := Fields.InValid_clean_dpbc((SALT35.StrType)le.clean_dpbc);
    SELF.clean_chk_digit_Invalid := Fields.InValid_clean_chk_digit((SALT35.StrType)le.clean_chk_digit);
    SELF.clean_record_type_Invalid := Fields.InValid_clean_record_type((SALT35.StrType)le.clean_record_type);
    SELF.clean_ace_fips_st_Invalid := Fields.InValid_clean_ace_fips_st((SALT35.StrType)le.clean_ace_fips_st);
    SELF.clean_fipscounty_Invalid := Fields.InValid_clean_fipscounty((SALT35.StrType)le.clean_fipscounty);
    SELF.clean_geo_lat_Invalid := Fields.InValid_clean_geo_lat((SALT35.StrType)le.clean_geo_lat);
    SELF.clean_geo_long_Invalid := Fields.InValid_clean_geo_long((SALT35.StrType)le.clean_geo_long);
    SELF.clean_msa_Invalid := Fields.InValid_clean_msa((SALT35.StrType)le.clean_msa);
    SELF.clean_geo_blk_Invalid := Fields.InValid_clean_geo_blk((SALT35.StrType)le.clean_geo_blk);
    SELF.clean_geo_match_Invalid := Fields.InValid_clean_geo_match((SALT35.StrType)le.clean_geo_match);
    SELF.clean_err_stat_Invalid := Fields.InValid_clean_err_stat((SALT35.StrType)le.clean_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_WI);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.orig_dl_number_Invalid << 2 ) + ( le.orig_last_name_Invalid << 4 ) + ( le.orig_sex_Invalid << 5 ) + ( le.orig_dob_Invalid << 6 ) + ( le.orig_city_Invalid << 8 ) + ( le.orig_address1_Invalid << 9 ) + ( le.orig_county_name_Invalid << 10 ) + ( le.orig_state_Invalid << 11 ) + ( le.orig_zip_code_Invalid << 12 ) + ( le.orig_opt_out_code_Invalid << 14 ) + ( le.orig_license_counter_Invalid << 15 ) + ( le.append_license_type_Invalid << 16 ) + ( le.append_classes_Invalid << 17 ) + ( le.append_endorsements_Invalid << 18 ) + ( le.append_issue_date_Invalid << 19 ) + ( le.append_expiration_date_Invalid << 21 ) + ( le.clean_name_last_Invalid << 23 ) + ( le.clean_name_score_Invalid << 24 ) + ( le.clean_predir_Invalid << 25 ) + ( le.clean_prim_name_Invalid << 26 ) + ( le.clean_postdir_Invalid << 27 ) + ( le.clean_p_city_name_Invalid << 28 ) + ( le.clean_v_city_name_Invalid << 29 ) + ( le.clean_st_Invalid << 30 ) + ( le.clean_zip_Invalid << 31 ) + ( le.clean_zip4_Invalid << 33 ) + ( le.clean_cart_Invalid << 35 ) + ( le.clean_cr_sort_sz_Invalid << 37 ) + ( le.clean_lot_Invalid << 38 ) + ( le.clean_lot_order_Invalid << 40 ) + ( le.clean_dpbc_Invalid << 42 ) + ( le.clean_chk_digit_Invalid << 44 ) + ( le.clean_record_type_Invalid << 46 ) + ( le.clean_ace_fips_st_Invalid << 47 ) + ( le.clean_fipscounty_Invalid << 49 ) + ( le.clean_geo_lat_Invalid << 51 ) + ( le.clean_geo_long_Invalid << 52 ) + ( le.clean_msa_Invalid << 53 ) + ( le.clean_geo_blk_Invalid << 55 ) + ( le.clean_geo_match_Invalid << 57 ) + ( le.clean_err_stat_Invalid << 59 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_WI);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_dl_number_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_last_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_sex_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_address1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_county_name_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_zip_code_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.orig_opt_out_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_license_counter_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.append_license_type_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.append_classes_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.append_endorsements_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.append_issue_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.append_expiration_date_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.clean_name_last_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.clean_name_score_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.clean_predir_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.clean_prim_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.clean_postdir_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.clean_p_city_name_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.clean_v_city_name_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.clean_st_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.clean_zip_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.clean_zip4_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.clean_cart_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.clean_cr_sort_sz_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_lot_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.clean_lot_order_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.clean_dpbc_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.clean_chk_digit_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.clean_record_type_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.clean_ace_fips_st_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.clean_fipscounty_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.clean_geo_lat_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_geo_long_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_msa_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.clean_geo_blk_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.clean_geo_match_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.clean_err_stat_Invalid := (le.ScrubsBits1 >> 59) & 3;
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
    orig_dl_number_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=1);
    orig_dl_number_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=2);
    orig_dl_number_Total_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid>0);
    orig_last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=1);
    orig_sex_ENUM_ErrorCount := COUNT(GROUP,h.orig_sex_Invalid=1);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_address1_LENGTH_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_county_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_county_name_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_code_Invalid=1);
    orig_zip_code_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_code_Invalid=2);
    orig_zip_code_Total_ErrorCount := COUNT(GROUP,h.orig_zip_code_Invalid>0);
    orig_opt_out_code_ENUM_ErrorCount := COUNT(GROUP,h.orig_opt_out_code_Invalid=1);
    orig_license_counter_ENUM_ErrorCount := COUNT(GROUP,h.orig_license_counter_Invalid=1);
    append_license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.append_license_type_Invalid=1);
    append_classes_CUSTOM_ErrorCount := COUNT(GROUP,h.append_classes_Invalid=1);
    append_endorsements_CUSTOM_ErrorCount := COUNT(GROUP,h.append_endorsements_Invalid=1);
    append_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_issue_date_Invalid=1);
    append_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.append_issue_date_Invalid=2);
    append_issue_date_Total_ErrorCount := COUNT(GROUP,h.append_issue_date_Invalid>0);
    append_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_expiration_date_Invalid=1);
    append_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.append_expiration_date_Invalid=2);
    append_expiration_date_Total_ErrorCount := COUNT(GROUP,h.append_expiration_date_Invalid>0);
    clean_name_last_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=1);
    clean_name_score_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_score_Invalid=1);
    clean_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_predir_Invalid=1);
    clean_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_prim_name_Invalid=1);
    clean_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_postdir_Invalid=1);
    clean_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_p_city_name_Invalid=1);
    clean_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_v_city_name_Invalid=1);
    clean_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_st_Invalid=1);
    clean_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid=1);
    clean_zip_LENGTH_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid=2);
    clean_zip_Total_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid>0);
    clean_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid=1);
    clean_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid=2);
    clean_zip4_Total_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid>0);
    clean_cart_ALLOW_ErrorCount := COUNT(GROUP,h.clean_cart_Invalid=1);
    clean_cart_LENGTH_ErrorCount := COUNT(GROUP,h.clean_cart_Invalid=2);
    clean_cart_Total_ErrorCount := COUNT(GROUP,h.clean_cart_Invalid>0);
    clean_cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.clean_cr_sort_sz_Invalid=1);
    clean_lot_ALLOW_ErrorCount := COUNT(GROUP,h.clean_lot_Invalid=1);
    clean_lot_LENGTH_ErrorCount := COUNT(GROUP,h.clean_lot_Invalid=2);
    clean_lot_Total_ErrorCount := COUNT(GROUP,h.clean_lot_Invalid>0);
    clean_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.clean_lot_order_Invalid=1);
    clean_lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.clean_lot_order_Invalid=2);
    clean_lot_order_Total_ErrorCount := COUNT(GROUP,h.clean_lot_order_Invalid>0);
    clean_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dpbc_Invalid=1);
    clean_dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.clean_dpbc_Invalid=2);
    clean_dpbc_Total_ErrorCount := COUNT(GROUP,h.clean_dpbc_Invalid>0);
    clean_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.clean_chk_digit_Invalid=1);
    clean_chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.clean_chk_digit_Invalid=2);
    clean_chk_digit_Total_ErrorCount := COUNT(GROUP,h.clean_chk_digit_Invalid>0);
    clean_record_type_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_record_type_Invalid=1);
    clean_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_ace_fips_st_Invalid=1);
    clean_ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.clean_ace_fips_st_Invalid=2);
    clean_ace_fips_st_Total_ErrorCount := COUNT(GROUP,h.clean_ace_fips_st_Invalid>0);
    clean_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fipscounty_Invalid=1);
    clean_fipscounty_LENGTH_ErrorCount := COUNT(GROUP,h.clean_fipscounty_Invalid=2);
    clean_fipscounty_Total_ErrorCount := COUNT(GROUP,h.clean_fipscounty_Invalid>0);
    clean_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_geo_lat_Invalid=1);
    clean_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.clean_geo_long_Invalid=1);
    clean_msa_ALLOW_ErrorCount := COUNT(GROUP,h.clean_msa_Invalid=1);
    clean_msa_LENGTH_ErrorCount := COUNT(GROUP,h.clean_msa_Invalid=2);
    clean_msa_Total_ErrorCount := COUNT(GROUP,h.clean_msa_Invalid>0);
    clean_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.clean_geo_blk_Invalid=1);
    clean_geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.clean_geo_blk_Invalid=2);
    clean_geo_blk_Total_ErrorCount := COUNT(GROUP,h.clean_geo_blk_Invalid>0);
    clean_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.clean_geo_match_Invalid=1);
    clean_geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.clean_geo_match_Invalid=2);
    clean_geo_match_Total_ErrorCount := COUNT(GROUP,h.clean_geo_match_Invalid>0);
    clean_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_err_stat_Invalid=1);
    clean_err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.clean_err_stat_Invalid=2);
    clean_err_stat_Total_ErrorCount := COUNT(GROUP,h.clean_err_stat_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.orig_dl_number_Invalid,le.orig_last_name_Invalid,le.orig_sex_Invalid,le.orig_dob_Invalid,le.orig_city_Invalid,le.orig_address1_Invalid,le.orig_county_name_Invalid,le.orig_state_Invalid,le.orig_zip_code_Invalid,le.orig_opt_out_code_Invalid,le.orig_license_counter_Invalid,le.append_license_type_Invalid,le.append_classes_Invalid,le.append_endorsements_Invalid,le.append_issue_date_Invalid,le.append_expiration_date_Invalid,le.clean_name_last_Invalid,le.clean_name_score_Invalid,le.clean_predir_Invalid,le.clean_prim_name_Invalid,le.clean_postdir_Invalid,le.clean_p_city_name_Invalid,le.clean_v_city_name_Invalid,le.clean_st_Invalid,le.clean_zip_Invalid,le.clean_zip4_Invalid,le.clean_cart_Invalid,le.clean_cr_sort_sz_Invalid,le.clean_lot_Invalid,le.clean_lot_order_Invalid,le.clean_dpbc_Invalid,le.clean_chk_digit_Invalid,le.clean_record_type_Invalid,le.clean_ace_fips_st_Invalid,le.clean_fipscounty_Invalid,le.clean_geo_lat_Invalid,le.clean_geo_long_Invalid,le.clean_msa_Invalid,le.clean_geo_blk_Invalid,le.clean_geo_match_Invalid,le.clean_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_orig_dl_number(le.orig_dl_number_Invalid),Fields.InvalidMessage_orig_last_name(le.orig_last_name_Invalid),Fields.InvalidMessage_orig_sex(le.orig_sex_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),Fields.InvalidMessage_orig_county_name(le.orig_county_name_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip_code(le.orig_zip_code_Invalid),Fields.InvalidMessage_orig_opt_out_code(le.orig_opt_out_code_Invalid),Fields.InvalidMessage_orig_license_counter(le.orig_license_counter_Invalid),Fields.InvalidMessage_append_license_type(le.append_license_type_Invalid),Fields.InvalidMessage_append_classes(le.append_classes_Invalid),Fields.InvalidMessage_append_endorsements(le.append_endorsements_Invalid),Fields.InvalidMessage_append_issue_date(le.append_issue_date_Invalid),Fields.InvalidMessage_append_expiration_date(le.append_expiration_date_Invalid),Fields.InvalidMessage_clean_name_last(le.clean_name_last_Invalid),Fields.InvalidMessage_clean_name_score(le.clean_name_score_Invalid),Fields.InvalidMessage_clean_predir(le.clean_predir_Invalid),Fields.InvalidMessage_clean_prim_name(le.clean_prim_name_Invalid),Fields.InvalidMessage_clean_postdir(le.clean_postdir_Invalid),Fields.InvalidMessage_clean_p_city_name(le.clean_p_city_name_Invalid),Fields.InvalidMessage_clean_v_city_name(le.clean_v_city_name_Invalid),Fields.InvalidMessage_clean_st(le.clean_st_Invalid),Fields.InvalidMessage_clean_zip(le.clean_zip_Invalid),Fields.InvalidMessage_clean_zip4(le.clean_zip4_Invalid),Fields.InvalidMessage_clean_cart(le.clean_cart_Invalid),Fields.InvalidMessage_clean_cr_sort_sz(le.clean_cr_sort_sz_Invalid),Fields.InvalidMessage_clean_lot(le.clean_lot_Invalid),Fields.InvalidMessage_clean_lot_order(le.clean_lot_order_Invalid),Fields.InvalidMessage_clean_dpbc(le.clean_dpbc_Invalid),Fields.InvalidMessage_clean_chk_digit(le.clean_chk_digit_Invalid),Fields.InvalidMessage_clean_record_type(le.clean_record_type_Invalid),Fields.InvalidMessage_clean_ace_fips_st(le.clean_ace_fips_st_Invalid),Fields.InvalidMessage_clean_fipscounty(le.clean_fipscounty_Invalid),Fields.InvalidMessage_clean_geo_lat(le.clean_geo_lat_Invalid),Fields.InvalidMessage_clean_geo_long(le.clean_geo_long_Invalid),Fields.InvalidMessage_clean_msa(le.clean_msa_Invalid),Fields.InvalidMessage_clean_geo_blk(le.clean_geo_blk_Invalid),Fields.InvalidMessage_clean_geo_match(le.clean_geo_match_Invalid),Fields.InvalidMessage_clean_err_stat(le.clean_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dl_number_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_county_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_opt_out_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_license_counter_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.append_license_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.append_classes_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.append_endorsements_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.append_issue_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.append_expiration_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_name_last_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_record_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_ace_fips_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_fipscounty_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','orig_dl_number','orig_last_name','orig_sex','orig_dob','orig_city','orig_address1','orig_county_name','orig_state','orig_zip_code','orig_opt_out_code','orig_license_counter','append_license_type','append_classes','append_endorsements','append_issue_date','append_expiration_date','clean_name_last','clean_name_score','clean_predir','clean_prim_name','clean_postdir','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_orig_dl_number','invalid_orig_name','invalid_orig_sex','invalid_8pastdate','invalid_alpha_blank','invalid_mandatory','invalid_alpha_num_specials','invalid_state','invalid_orig_zip_code','invalid_orig_opt_out_code','invalid_orig_license_counter','invalid_append_license_type','invalid_append_classes','invalid_append_endorsements','invalid_8pastdate','invalid_8generaldate','invalid_clean_name','invalid_numeric','invalid_direction','invalid_mandatory','invalid_direction','invalid_alpha_blank','invalid_alpha_blank','invalid_state','invalid_zip_code5','invalid_zip_code4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.append_process_date,(SALT35.StrType)le.orig_dl_number,(SALT35.StrType)le.orig_last_name,(SALT35.StrType)le.orig_sex,(SALT35.StrType)le.orig_dob,(SALT35.StrType)le.orig_city,(SALT35.StrType)le.orig_address1,(SALT35.StrType)le.orig_county_name,(SALT35.StrType)le.orig_state,(SALT35.StrType)le.orig_zip_code,(SALT35.StrType)le.orig_opt_out_code,(SALT35.StrType)le.orig_license_counter,(SALT35.StrType)le.append_license_type,(SALT35.StrType)le.append_classes,(SALT35.StrType)le.append_endorsements,(SALT35.StrType)le.append_issue_date,(SALT35.StrType)le.append_expiration_date,(SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_score,(SALT35.StrType)le.clean_predir,(SALT35.StrType)le.clean_prim_name,(SALT35.StrType)le.clean_postdir,(SALT35.StrType)le.clean_p_city_name,(SALT35.StrType)le.clean_v_city_name,(SALT35.StrType)le.clean_st,(SALT35.StrType)le.clean_zip,(SALT35.StrType)le.clean_zip4,(SALT35.StrType)le.clean_cart,(SALT35.StrType)le.clean_cr_sort_sz,(SALT35.StrType)le.clean_lot,(SALT35.StrType)le.clean_lot_order,(SALT35.StrType)le.clean_dpbc,(SALT35.StrType)le.clean_chk_digit,(SALT35.StrType)le.clean_record_type,(SALT35.StrType)le.clean_ace_fips_st,(SALT35.StrType)le.clean_fipscounty,(SALT35.StrType)le.clean_geo_lat,(SALT35.StrType)le.clean_geo_long,(SALT35.StrType)le.clean_msa,(SALT35.StrType)le.clean_geo_blk,(SALT35.StrType)le.clean_geo_match,(SALT35.StrType)le.clean_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,42,Into(LEFT,COUNTER));
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
          ,'orig_dl_number:invalid_orig_dl_number:CUSTOM','orig_dl_number:invalid_orig_dl_number:LENGTH'
          ,'orig_last_name:invalid_orig_name:CUSTOM'
          ,'orig_sex:invalid_orig_sex:ENUM'
          ,'orig_dob:invalid_8pastdate:CUSTOM','orig_dob:invalid_8pastdate:LENGTH'
          ,'orig_city:invalid_alpha_blank:ALLOW'
          ,'orig_address1:invalid_mandatory:LENGTH'
          ,'orig_county_name:invalid_alpha_num_specials:ALLOW'
          ,'orig_state:invalid_state:CUSTOM'
          ,'orig_zip_code:invalid_orig_zip_code:ALLOW','orig_zip_code:invalid_orig_zip_code:LENGTH'
          ,'orig_opt_out_code:invalid_orig_opt_out_code:ENUM'
          ,'orig_license_counter:invalid_orig_license_counter:ENUM'
          ,'append_license_type:invalid_append_license_type:CUSTOM'
          ,'append_classes:invalid_append_classes:CUSTOM'
          ,'append_endorsements:invalid_append_endorsements:CUSTOM'
          ,'append_issue_date:invalid_8pastdate:CUSTOM','append_issue_date:invalid_8pastdate:LENGTH'
          ,'append_expiration_date:invalid_8generaldate:CUSTOM','append_expiration_date:invalid_8generaldate:LENGTH'
          ,'clean_name_last:invalid_clean_name:CUSTOM'
          ,'clean_name_score:invalid_numeric:ALLOW'
          ,'clean_predir:invalid_direction:ALLOW'
          ,'clean_prim_name:invalid_mandatory:LENGTH'
          ,'clean_postdir:invalid_direction:ALLOW'
          ,'clean_p_city_name:invalid_alpha_blank:ALLOW'
          ,'clean_v_city_name:invalid_alpha_blank:ALLOW'
          ,'clean_st:invalid_state:CUSTOM'
          ,'clean_zip:invalid_zip_code5:ALLOW','clean_zip:invalid_zip_code5:LENGTH'
          ,'clean_zip4:invalid_zip_code4:ALLOW','clean_zip4:invalid_zip_code4:LENGTH'
          ,'clean_cart:invalid_cart:ALLOW','clean_cart:invalid_cart:LENGTH'
          ,'clean_cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'clean_lot:invalid_lot:ALLOW','clean_lot:invalid_lot:LENGTH'
          ,'clean_lot_order:invalid_lot_order:ALLOW','clean_lot_order:invalid_lot_order:LENGTH'
          ,'clean_dpbc:invalid_dpbc:ALLOW','clean_dpbc:invalid_dpbc:LENGTH'
          ,'clean_chk_digit:invalid_chk_digit:ALLOW','clean_chk_digit:invalid_chk_digit:LENGTH'
          ,'clean_record_type:invalid_record_type:CUSTOM'
          ,'clean_ace_fips_st:invalid_ace_fips_st:ALLOW','clean_ace_fips_st:invalid_ace_fips_st:LENGTH'
          ,'clean_fipscounty:invalid_fipscounty:ALLOW','clean_fipscounty:invalid_fipscounty:LENGTH'
          ,'clean_geo_lat:invalid_geo:ALLOW'
          ,'clean_geo_long:invalid_geo:ALLOW'
          ,'clean_msa:invalid_msa:ALLOW','clean_msa:invalid_msa:LENGTH'
          ,'clean_geo_blk:invalid_geo_blk:ALLOW','clean_geo_blk:invalid_geo_blk:LENGTH'
          ,'clean_geo_match:invalid_geo_match:ALLOW','clean_geo_match:invalid_geo_match:LENGTH'
          ,'clean_err_stat:invalid_err_stat:ALLOW','clean_err_stat:invalid_err_stat:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1),Fields.InvalidMessage_append_process_date(2)
          ,Fields.InvalidMessage_orig_dl_number(1),Fields.InvalidMessage_orig_dl_number(2)
          ,Fields.InvalidMessage_orig_last_name(1)
          ,Fields.InvalidMessage_orig_sex(1)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2)
          ,Fields.InvalidMessage_orig_city(1)
          ,Fields.InvalidMessage_orig_address1(1)
          ,Fields.InvalidMessage_orig_county_name(1)
          ,Fields.InvalidMessage_orig_state(1)
          ,Fields.InvalidMessage_orig_zip_code(1),Fields.InvalidMessage_orig_zip_code(2)
          ,Fields.InvalidMessage_orig_opt_out_code(1)
          ,Fields.InvalidMessage_orig_license_counter(1)
          ,Fields.InvalidMessage_append_license_type(1)
          ,Fields.InvalidMessage_append_classes(1)
          ,Fields.InvalidMessage_append_endorsements(1)
          ,Fields.InvalidMessage_append_issue_date(1),Fields.InvalidMessage_append_issue_date(2)
          ,Fields.InvalidMessage_append_expiration_date(1),Fields.InvalidMessage_append_expiration_date(2)
          ,Fields.InvalidMessage_clean_name_last(1)
          ,Fields.InvalidMessage_clean_name_score(1)
          ,Fields.InvalidMessage_clean_predir(1)
          ,Fields.InvalidMessage_clean_prim_name(1)
          ,Fields.InvalidMessage_clean_postdir(1)
          ,Fields.InvalidMessage_clean_p_city_name(1)
          ,Fields.InvalidMessage_clean_v_city_name(1)
          ,Fields.InvalidMessage_clean_st(1)
          ,Fields.InvalidMessage_clean_zip(1),Fields.InvalidMessage_clean_zip(2)
          ,Fields.InvalidMessage_clean_zip4(1),Fields.InvalidMessage_clean_zip4(2)
          ,Fields.InvalidMessage_clean_cart(1),Fields.InvalidMessage_clean_cart(2)
          ,Fields.InvalidMessage_clean_cr_sort_sz(1)
          ,Fields.InvalidMessage_clean_lot(1),Fields.InvalidMessage_clean_lot(2)
          ,Fields.InvalidMessage_clean_lot_order(1),Fields.InvalidMessage_clean_lot_order(2)
          ,Fields.InvalidMessage_clean_dpbc(1),Fields.InvalidMessage_clean_dpbc(2)
          ,Fields.InvalidMessage_clean_chk_digit(1),Fields.InvalidMessage_clean_chk_digit(2)
          ,Fields.InvalidMessage_clean_record_type(1)
          ,Fields.InvalidMessage_clean_ace_fips_st(1),Fields.InvalidMessage_clean_ace_fips_st(2)
          ,Fields.InvalidMessage_clean_fipscounty(1),Fields.InvalidMessage_clean_fipscounty(2)
          ,Fields.InvalidMessage_clean_geo_lat(1)
          ,Fields.InvalidMessage_clean_geo_long(1)
          ,Fields.InvalidMessage_clean_msa(1),Fields.InvalidMessage_clean_msa(2)
          ,Fields.InvalidMessage_clean_geo_blk(1),Fields.InvalidMessage_clean_geo_blk(2)
          ,Fields.InvalidMessage_clean_geo_match(1),Fields.InvalidMessage_clean_geo_match(2)
          ,Fields.InvalidMessage_clean_err_stat(1),Fields.InvalidMessage_clean_err_stat(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.orig_dl_number_CUSTOM_ErrorCount,le.orig_dl_number_LENGTH_ErrorCount
          ,le.orig_last_name_CUSTOM_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_address1_LENGTH_ErrorCount
          ,le.orig_county_name_ALLOW_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_code_ALLOW_ErrorCount,le.orig_zip_code_LENGTH_ErrorCount
          ,le.orig_opt_out_code_ENUM_ErrorCount
          ,le.orig_license_counter_ENUM_ErrorCount
          ,le.append_license_type_CUSTOM_ErrorCount
          ,le.append_classes_CUSTOM_ErrorCount
          ,le.append_endorsements_CUSTOM_ErrorCount
          ,le.append_issue_date_CUSTOM_ErrorCount,le.append_issue_date_LENGTH_ErrorCount
          ,le.append_expiration_date_CUSTOM_ErrorCount,le.append_expiration_date_LENGTH_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_name_score_ALLOW_ErrorCount
          ,le.clean_predir_ALLOW_ErrorCount
          ,le.clean_prim_name_LENGTH_ErrorCount
          ,le.clean_postdir_ALLOW_ErrorCount
          ,le.clean_p_city_name_ALLOW_ErrorCount
          ,le.clean_v_city_name_ALLOW_ErrorCount
          ,le.clean_st_CUSTOM_ErrorCount
          ,le.clean_zip_ALLOW_ErrorCount,le.clean_zip_LENGTH_ErrorCount
          ,le.clean_zip4_ALLOW_ErrorCount,le.clean_zip4_LENGTH_ErrorCount
          ,le.clean_cart_ALLOW_ErrorCount,le.clean_cart_LENGTH_ErrorCount
          ,le.clean_cr_sort_sz_ENUM_ErrorCount
          ,le.clean_lot_ALLOW_ErrorCount,le.clean_lot_LENGTH_ErrorCount
          ,le.clean_lot_order_ALLOW_ErrorCount,le.clean_lot_order_LENGTH_ErrorCount
          ,le.clean_dpbc_ALLOW_ErrorCount,le.clean_dpbc_LENGTH_ErrorCount
          ,le.clean_chk_digit_ALLOW_ErrorCount,le.clean_chk_digit_LENGTH_ErrorCount
          ,le.clean_record_type_CUSTOM_ErrorCount
          ,le.clean_ace_fips_st_ALLOW_ErrorCount,le.clean_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_fipscounty_ALLOW_ErrorCount,le.clean_fipscounty_LENGTH_ErrorCount
          ,le.clean_geo_lat_ALLOW_ErrorCount
          ,le.clean_geo_long_ALLOW_ErrorCount
          ,le.clean_msa_ALLOW_ErrorCount,le.clean_msa_LENGTH_ErrorCount
          ,le.clean_geo_blk_ALLOW_ErrorCount,le.clean_geo_blk_LENGTH_ErrorCount
          ,le.clean_geo_match_ALLOW_ErrorCount,le.clean_geo_match_LENGTH_ErrorCount
          ,le.clean_err_stat_ALLOW_ErrorCount,le.clean_err_stat_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.orig_dl_number_CUSTOM_ErrorCount,le.orig_dl_number_LENGTH_ErrorCount
          ,le.orig_last_name_CUSTOM_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_address1_LENGTH_ErrorCount
          ,le.orig_county_name_ALLOW_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_code_ALLOW_ErrorCount,le.orig_zip_code_LENGTH_ErrorCount
          ,le.orig_opt_out_code_ENUM_ErrorCount
          ,le.orig_license_counter_ENUM_ErrorCount
          ,le.append_license_type_CUSTOM_ErrorCount
          ,le.append_classes_CUSTOM_ErrorCount
          ,le.append_endorsements_CUSTOM_ErrorCount
          ,le.append_issue_date_CUSTOM_ErrorCount,le.append_issue_date_LENGTH_ErrorCount
          ,le.append_expiration_date_CUSTOM_ErrorCount,le.append_expiration_date_LENGTH_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_name_score_ALLOW_ErrorCount
          ,le.clean_predir_ALLOW_ErrorCount
          ,le.clean_prim_name_LENGTH_ErrorCount
          ,le.clean_postdir_ALLOW_ErrorCount
          ,le.clean_p_city_name_ALLOW_ErrorCount
          ,le.clean_v_city_name_ALLOW_ErrorCount
          ,le.clean_st_CUSTOM_ErrorCount
          ,le.clean_zip_ALLOW_ErrorCount,le.clean_zip_LENGTH_ErrorCount
          ,le.clean_zip4_ALLOW_ErrorCount,le.clean_zip4_LENGTH_ErrorCount
          ,le.clean_cart_ALLOW_ErrorCount,le.clean_cart_LENGTH_ErrorCount
          ,le.clean_cr_sort_sz_ENUM_ErrorCount
          ,le.clean_lot_ALLOW_ErrorCount,le.clean_lot_LENGTH_ErrorCount
          ,le.clean_lot_order_ALLOW_ErrorCount,le.clean_lot_order_LENGTH_ErrorCount
          ,le.clean_dpbc_ALLOW_ErrorCount,le.clean_dpbc_LENGTH_ErrorCount
          ,le.clean_chk_digit_ALLOW_ErrorCount,le.clean_chk_digit_LENGTH_ErrorCount
          ,le.clean_record_type_CUSTOM_ErrorCount
          ,le.clean_ace_fips_st_ALLOW_ErrorCount,le.clean_ace_fips_st_LENGTH_ErrorCount
          ,le.clean_fipscounty_ALLOW_ErrorCount,le.clean_fipscounty_LENGTH_ErrorCount
          ,le.clean_geo_lat_ALLOW_ErrorCount
          ,le.clean_geo_long_ALLOW_ErrorCount
          ,le.clean_msa_ALLOW_ErrorCount,le.clean_msa_LENGTH_ErrorCount
          ,le.clean_geo_blk_ALLOW_ErrorCount,le.clean_geo_blk_LENGTH_ErrorCount
          ,le.clean_geo_match_ALLOW_ErrorCount,le.clean_geo_match_LENGTH_ErrorCount
          ,le.clean_err_stat_ALLOW_ErrorCount,le.clean_err_stat_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,61,Into(LEFT,COUNTER));
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
