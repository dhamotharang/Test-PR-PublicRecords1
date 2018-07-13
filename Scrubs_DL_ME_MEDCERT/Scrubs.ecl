IMPORT SALT38,STD;
IMPORT Scrubs_DL_ME_MEDCERT,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 59;
  EXPORT NumRulesFromFieldType := 59;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 59;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_ME_MEDCERT)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_credential_type_Invalid;
    UNSIGNED1 orig_id_terminal_date_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mi_Invalid;
    UNSIGNED1 orig_street_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_sex_Invalid;
    UNSIGNED1 orig_height_Invalid;
    UNSIGNED1 orig_height2_Invalid;
    UNSIGNED1 orig_weight_Invalid;
    UNSIGNED1 orig_hair_Invalid;
    UNSIGNED1 orig_eyes_Invalid;
    UNSIGNED1 orig_dlexpiredate_Invalid;
    UNSIGNED1 orig_dlstat_Invalid;
    UNSIGNED1 orig_dlissuedate_Invalid;
    UNSIGNED1 orig_originalissuedate_Invalid;
    UNSIGNED1 orig_regstatfr_Invalid;
    UNSIGNED1 orig_regstatcr_Invalid;
    UNSIGNED1 orig_dlclass_Invalid;
    UNSIGNED1 orig_historynum_Invalid;
    UNSIGNED1 orig_restrictions_Invalid;
    UNSIGNED1 orig_endorsements_Invalid;
    UNSIGNED1 orig_endorsements2_Invalid;
    UNSIGNED1 orig_endorsements3_Invalid;
    UNSIGNED1 orig_endorsements4_Invalid;
    UNSIGNED1 orig_endorsements5_Invalid;
    UNSIGNED1 orig_endorsements6_Invalid;
    UNSIGNED1 orig_endorsements7_Invalid;
    UNSIGNED1 orig_endorsements8_Invalid;
    UNSIGNED1 orig_endorsements9_Invalid;
    UNSIGNED1 orig_endorsements10_Invalid;
    UNSIGNED1 orig_comm_driv_status_Invalid;
    UNSIGNED1 orig_organ_donor_Invalid;
    UNSIGNED1 clean_name_first_Invalid;
    UNSIGNED1 clean_name_middle_Invalid;
    UNSIGNED1 clean_name_last_Invalid;
    UNSIGNED1 clean_prim_name_Invalid;
    UNSIGNED1 clean_p_city_name_Invalid;
    UNSIGNED1 clean_v_city_name_Invalid;
    UNSIGNED1 clean_st_Invalid;
    UNSIGNED1 clean_zip_Invalid;
    UNSIGNED1 clean_zip4_Invalid;
    UNSIGNED1 clean_cart_Invalid;
    UNSIGNED1 clean_lot_Invalid;
    UNSIGNED1 clean_lot_order_Invalid;
    UNSIGNED1 clean_dpbc_Invalid;
    UNSIGNED1 clean_chk_digit_Invalid;
    UNSIGNED1 clean_ace_fips_st_Invalid;
    UNSIGNED1 clean_fipscounty_Invalid;
    UNSIGNED1 clean_geo_lat_Invalid;
    UNSIGNED1 clean_geo_long_Invalid;
    UNSIGNED1 clean_msa_Invalid;
    UNSIGNED1 clean_geo_match_Invalid;
    UNSIGNED1 clean_err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_ME_MEDCERT)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_ME_MEDCERT) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT38.StrType)le.append_process_date);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT38.StrType)le.orig_dob);
    SELF.orig_credential_type_Invalid := Fields.InValid_orig_credential_type((SALT38.StrType)le.orig_credential_type);
    SELF.orig_id_terminal_date_Invalid := Fields.InValid_orig_id_terminal_date((SALT38.StrType)le.orig_id_terminal_date);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname,(SALT38.StrType)le.orig_fname);
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname,(SALT38.StrType)le.orig_lname);
    SELF.orig_mi_Invalid := Fields.InValid_orig_mi((SALT38.StrType)le.orig_mi);
    SELF.orig_street_Invalid := Fields.InValid_orig_street((SALT38.StrType)le.orig_street);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT38.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT38.StrType)le.orig_state);
    SELF.orig_zip_Invalid := Fields.InValid_orig_zip((SALT38.StrType)le.orig_zip);
    SELF.orig_sex_Invalid := Fields.InValid_orig_sex((SALT38.StrType)le.orig_sex);
    SELF.orig_height_Invalid := Fields.InValid_orig_height((SALT38.StrType)le.orig_height);
    SELF.orig_height2_Invalid := Fields.InValid_orig_height2((SALT38.StrType)le.orig_height2);
    SELF.orig_weight_Invalid := Fields.InValid_orig_weight((SALT38.StrType)le.orig_weight);
    SELF.orig_hair_Invalid := Fields.InValid_orig_hair((SALT38.StrType)le.orig_hair);
    SELF.orig_eyes_Invalid := Fields.InValid_orig_eyes((SALT38.StrType)le.orig_eyes);
    SELF.orig_dlexpiredate_Invalid := Fields.InValid_orig_dlexpiredate((SALT38.StrType)le.orig_dlexpiredate);
    SELF.orig_dlstat_Invalid := Fields.InValid_orig_dlstat((SALT38.StrType)le.orig_dlstat);
    SELF.orig_dlissuedate_Invalid := Fields.InValid_orig_dlissuedate((SALT38.StrType)le.orig_dlissuedate);
    SELF.orig_originalissuedate_Invalid := Fields.InValid_orig_originalissuedate((SALT38.StrType)le.orig_originalissuedate);
    SELF.orig_regstatfr_Invalid := Fields.InValid_orig_regstatfr((SALT38.StrType)le.orig_regstatfr);
    SELF.orig_regstatcr_Invalid := Fields.InValid_orig_regstatcr((SALT38.StrType)le.orig_regstatcr);
    SELF.orig_dlclass_Invalid := Fields.InValid_orig_dlclass((SALT38.StrType)le.orig_dlclass);
    SELF.orig_historynum_Invalid := Fields.InValid_orig_historynum((SALT38.StrType)le.orig_historynum);
    SELF.orig_restrictions_Invalid := Fields.InValid_orig_restrictions((SALT38.StrType)le.orig_restrictions);
    SELF.orig_endorsements_Invalid := Fields.InValid_orig_endorsements((SALT38.StrType)le.orig_endorsements);
    SELF.orig_endorsements2_Invalid := Fields.InValid_orig_endorsements2((SALT38.StrType)le.orig_endorsements2);
    SELF.orig_endorsements3_Invalid := Fields.InValid_orig_endorsements3((SALT38.StrType)le.orig_endorsements3);
    SELF.orig_endorsements4_Invalid := Fields.InValid_orig_endorsements4((SALT38.StrType)le.orig_endorsements4);
    SELF.orig_endorsements5_Invalid := Fields.InValid_orig_endorsements5((SALT38.StrType)le.orig_endorsements5);
    SELF.orig_endorsements6_Invalid := Fields.InValid_orig_endorsements6((SALT38.StrType)le.orig_endorsements6);
    SELF.orig_endorsements7_Invalid := Fields.InValid_orig_endorsements7((SALT38.StrType)le.orig_endorsements7);
    SELF.orig_endorsements8_Invalid := Fields.InValid_orig_endorsements8((SALT38.StrType)le.orig_endorsements8);
    SELF.orig_endorsements9_Invalid := Fields.InValid_orig_endorsements9((SALT38.StrType)le.orig_endorsements9);
    SELF.orig_endorsements10_Invalid := Fields.InValid_orig_endorsements10((SALT38.StrType)le.orig_endorsements10);
    SELF.orig_comm_driv_status_Invalid := Fields.InValid_orig_comm_driv_status((SALT38.StrType)le.orig_comm_driv_status);
    SELF.orig_organ_donor_Invalid := Fields.InValid_orig_organ_donor((SALT38.StrType)le.orig_organ_donor);
    SELF.clean_name_first_Invalid := Fields.InValid_clean_name_first((SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.Clean_name_last);
    SELF.clean_name_middle_Invalid := Fields.InValid_clean_name_middle((SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.Clean_name_last);
    SELF.clean_name_last_Invalid := Fields.InValid_clean_name_last((SALT38.StrType)le.clean_name_last,(SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle);
    SELF.clean_prim_name_Invalid := Fields.InValid_clean_prim_name((SALT38.StrType)le.clean_prim_name);
    SELF.clean_p_city_name_Invalid := Fields.InValid_clean_p_city_name((SALT38.StrType)le.clean_p_city_name);
    SELF.clean_v_city_name_Invalid := Fields.InValid_clean_v_city_name((SALT38.StrType)le.clean_v_city_name);
    SELF.clean_st_Invalid := Fields.InValid_clean_st((SALT38.StrType)le.clean_st);
    SELF.clean_zip_Invalid := Fields.InValid_clean_zip((SALT38.StrType)le.clean_zip);
    SELF.clean_zip4_Invalid := Fields.InValid_clean_zip4((SALT38.StrType)le.clean_zip4);
    SELF.clean_cart_Invalid := Fields.InValid_clean_cart((SALT38.StrType)le.clean_cart);
    SELF.clean_lot_Invalid := Fields.InValid_clean_lot((SALT38.StrType)le.clean_lot);
    SELF.clean_lot_order_Invalid := Fields.InValid_clean_lot_order((SALT38.StrType)le.clean_lot_order);
    SELF.clean_dpbc_Invalid := Fields.InValid_clean_dpbc((SALT38.StrType)le.clean_dpbc);
    SELF.clean_chk_digit_Invalid := Fields.InValid_clean_chk_digit((SALT38.StrType)le.clean_chk_digit);
    SELF.clean_ace_fips_st_Invalid := Fields.InValid_clean_ace_fips_st((SALT38.StrType)le.clean_ace_fips_st);
    SELF.clean_fipscounty_Invalid := Fields.InValid_clean_fipscounty((SALT38.StrType)le.clean_fipscounty);
    SELF.clean_geo_lat_Invalid := Fields.InValid_clean_geo_lat((SALT38.StrType)le.clean_geo_lat);
    SELF.clean_geo_long_Invalid := Fields.InValid_clean_geo_long((SALT38.StrType)le.clean_geo_long);
    SELF.clean_msa_Invalid := Fields.InValid_clean_msa((SALT38.StrType)le.clean_msa);
    SELF.clean_geo_match_Invalid := Fields.InValid_clean_geo_match((SALT38.StrType)le.clean_geo_match);
    SELF.clean_err_stat_Invalid := Fields.InValid_clean_err_stat((SALT38.StrType)le.clean_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_ME_MEDCERT);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.orig_dob_Invalid << 1 ) + ( le.orig_credential_type_Invalid << 2 ) + ( le.orig_id_terminal_date_Invalid << 3 ) + ( le.orig_lname_Invalid << 4 ) + ( le.orig_fname_Invalid << 5 ) + ( le.orig_mi_Invalid << 6 ) + ( le.orig_street_Invalid << 7 ) + ( le.orig_city_Invalid << 8 ) + ( le.orig_state_Invalid << 9 ) + ( le.orig_zip_Invalid << 10 ) + ( le.orig_sex_Invalid << 11 ) + ( le.orig_height_Invalid << 12 ) + ( le.orig_height2_Invalid << 13 ) + ( le.orig_weight_Invalid << 14 ) + ( le.orig_hair_Invalid << 15 ) + ( le.orig_eyes_Invalid << 16 ) + ( le.orig_dlexpiredate_Invalid << 17 ) + ( le.orig_dlstat_Invalid << 18 ) + ( le.orig_dlissuedate_Invalid << 19 ) + ( le.orig_originalissuedate_Invalid << 20 ) + ( le.orig_regstatfr_Invalid << 21 ) + ( le.orig_regstatcr_Invalid << 22 ) + ( le.orig_dlclass_Invalid << 23 ) + ( le.orig_historynum_Invalid << 24 ) + ( le.orig_restrictions_Invalid << 25 ) + ( le.orig_endorsements_Invalid << 26 ) + ( le.orig_endorsements2_Invalid << 27 ) + ( le.orig_endorsements3_Invalid << 28 ) + ( le.orig_endorsements4_Invalid << 29 ) + ( le.orig_endorsements5_Invalid << 30 ) + ( le.orig_endorsements6_Invalid << 31 ) + ( le.orig_endorsements7_Invalid << 32 ) + ( le.orig_endorsements8_Invalid << 33 ) + ( le.orig_endorsements9_Invalid << 34 ) + ( le.orig_endorsements10_Invalid << 35 ) + ( le.orig_comm_driv_status_Invalid << 36 ) + ( le.orig_organ_donor_Invalid << 37 ) + ( le.clean_name_first_Invalid << 38 ) + ( le.clean_name_middle_Invalid << 39 ) + ( le.clean_name_last_Invalid << 40 ) + ( le.clean_prim_name_Invalid << 41 ) + ( le.clean_p_city_name_Invalid << 42 ) + ( le.clean_v_city_name_Invalid << 43 ) + ( le.clean_st_Invalid << 44 ) + ( le.clean_zip_Invalid << 45 ) + ( le.clean_zip4_Invalid << 46 ) + ( le.clean_cart_Invalid << 47 ) + ( le.clean_lot_Invalid << 48 ) + ( le.clean_lot_order_Invalid << 49 ) + ( le.clean_dpbc_Invalid << 50 ) + ( le.clean_chk_digit_Invalid << 51 ) + ( le.clean_ace_fips_st_Invalid << 52 ) + ( le.clean_fipscounty_Invalid << 53 ) + ( le.clean_geo_lat_Invalid << 54 ) + ( le.clean_geo_long_Invalid << 55 ) + ( le.clean_msa_Invalid << 56 ) + ( le.clean_geo_match_Invalid << 57 ) + ( le.clean_err_stat_Invalid << 58 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_ME_MEDCERT);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_credential_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_id_terminal_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_mi_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.orig_street_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_sex_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_height_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_height2_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_weight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_hair_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_eyes_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orig_dlexpiredate_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.orig_dlstat_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_dlissuedate_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.orig_originalissuedate_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.orig_regstatfr_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.orig_regstatcr_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.orig_dlclass_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.orig_historynum_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.orig_restrictions_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.orig_endorsements_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.orig_endorsements2_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.orig_endorsements3_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.orig_endorsements4_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.orig_endorsements5_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.orig_endorsements6_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.orig_endorsements7_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.orig_endorsements8_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.orig_endorsements9_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.orig_endorsements10_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.orig_comm_driv_status_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.orig_organ_donor_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_name_first_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.clean_name_middle_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.clean_name_last_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.clean_prim_name_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.clean_p_city_name_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.clean_v_city_name_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.clean_st_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.clean_zip_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.clean_zip4_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.clean_cart_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.clean_lot_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.clean_lot_order_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.clean_dpbc_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.clean_chk_digit_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_ace_fips_st_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_fipscounty_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.clean_geo_lat_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.clean_geo_long_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.clean_msa_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.clean_geo_match_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.clean_err_stat_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_credential_type_ALLOW_ErrorCount := COUNT(GROUP,h.orig_credential_type_Invalid=1);
    orig_id_terminal_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_id_terminal_date_Invalid=1);
    orig_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_mi_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_mi_Invalid=1);
    orig_street_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_street_Invalid=1);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_sex_ALLOW_ErrorCount := COUNT(GROUP,h.orig_sex_Invalid=1);
    orig_height_ALLOW_ErrorCount := COUNT(GROUP,h.orig_height_Invalid=1);
    orig_height2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_height2_Invalid=1);
    orig_weight_ALLOW_ErrorCount := COUNT(GROUP,h.orig_weight_Invalid=1);
    orig_hair_ALLOW_ErrorCount := COUNT(GROUP,h.orig_hair_Invalid=1);
    orig_eyes_ALLOW_ErrorCount := COUNT(GROUP,h.orig_eyes_Invalid=1);
    orig_dlexpiredate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dlexpiredate_Invalid=1);
    orig_dlstat_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dlstat_Invalid=1);
    orig_dlissuedate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dlissuedate_Invalid=1);
    orig_originalissuedate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_originalissuedate_Invalid=1);
    orig_regstatfr_ALLOW_ErrorCount := COUNT(GROUP,h.orig_regstatfr_Invalid=1);
    orig_regstatcr_ALLOW_ErrorCount := COUNT(GROUP,h.orig_regstatcr_Invalid=1);
    orig_dlclass_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dlclass_Invalid=1);
    orig_historynum_ALLOW_ErrorCount := COUNT(GROUP,h.orig_historynum_Invalid=1);
    orig_restrictions_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_restrictions_Invalid=1);
    orig_endorsements_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements_Invalid=1);
    orig_endorsements2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements2_Invalid=1);
    orig_endorsements3_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements3_Invalid=1);
    orig_endorsements4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements4_Invalid=1);
    orig_endorsements5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements5_Invalid=1);
    orig_endorsements6_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements6_Invalid=1);
    orig_endorsements7_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements7_Invalid=1);
    orig_endorsements8_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements8_Invalid=1);
    orig_endorsements9_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements9_Invalid=1);
    orig_endorsements10_ALLOW_ErrorCount := COUNT(GROUP,h.orig_endorsements10_Invalid=1);
    orig_comm_driv_status_ALLOW_ErrorCount := COUNT(GROUP,h.orig_comm_driv_status_Invalid=1);
    orig_organ_donor_ALLOW_ErrorCount := COUNT(GROUP,h.orig_organ_donor_Invalid=1);
    clean_name_first_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_first_Invalid=1);
    clean_name_middle_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_middle_Invalid=1);
    clean_name_last_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_last_Invalid=1);
    clean_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_prim_name_Invalid=1);
    clean_p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_p_city_name_Invalid=1);
    clean_v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_v_city_name_Invalid=1);
    clean_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_st_Invalid=1);
    clean_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_zip_Invalid=1);
    clean_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_zip4_Invalid=1);
    clean_cart_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_cart_Invalid=1);
    clean_lot_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_lot_Invalid=1);
    clean_lot_order_ENUM_ErrorCount := COUNT(GROUP,h.clean_lot_order_Invalid=1);
    clean_dpbc_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dpbc_Invalid=1);
    clean_chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_chk_digit_Invalid=1);
    clean_ace_fips_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_ace_fips_st_Invalid=1);
    clean_fipscounty_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_fipscounty_Invalid=1);
    clean_geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_geo_lat_Invalid=1);
    clean_geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_geo_long_Invalid=1);
    clean_msa_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_msa_Invalid=1);
    clean_geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_geo_match_Invalid=1);
    clean_err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_err_stat_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.append_process_date_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_credential_type_Invalid > 0 OR h.orig_id_terminal_date_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_mi_Invalid > 0 OR h.orig_street_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_sex_Invalid > 0 OR h.orig_height_Invalid > 0 OR h.orig_height2_Invalid > 0 OR h.orig_weight_Invalid > 0 OR h.orig_hair_Invalid > 0 OR h.orig_eyes_Invalid > 0 OR h.orig_dlexpiredate_Invalid > 0 OR h.orig_dlstat_Invalid > 0 OR h.orig_dlissuedate_Invalid > 0 OR h.orig_originalissuedate_Invalid > 0 OR h.orig_regstatfr_Invalid > 0 OR h.orig_regstatcr_Invalid > 0 OR h.orig_dlclass_Invalid > 0 OR h.orig_historynum_Invalid > 0 OR h.orig_restrictions_Invalid > 0 OR h.orig_endorsements_Invalid > 0 OR h.orig_endorsements2_Invalid > 0 OR h.orig_endorsements3_Invalid > 0 OR h.orig_endorsements4_Invalid > 0 OR h.orig_endorsements5_Invalid > 0 OR h.orig_endorsements6_Invalid > 0 OR h.orig_endorsements7_Invalid > 0 OR h.orig_endorsements8_Invalid > 0 OR h.orig_endorsements9_Invalid > 0 OR h.orig_endorsements10_Invalid > 0 OR h.orig_comm_driv_status_Invalid > 0 OR h.orig_organ_donor_Invalid > 0 OR h.clean_name_first_Invalid > 0 OR h.clean_name_middle_Invalid > 0 OR h.clean_name_last_Invalid > 0 OR h.clean_prim_name_Invalid > 0 OR h.clean_p_city_name_Invalid > 0 OR h.clean_v_city_name_Invalid > 0 OR h.clean_st_Invalid > 0 OR h.clean_zip_Invalid > 0 OR h.clean_zip4_Invalid > 0 OR h.clean_cart_Invalid > 0 OR h.clean_lot_Invalid > 0 OR h.clean_lot_order_Invalid > 0 OR h.clean_dpbc_Invalid > 0 OR h.clean_chk_digit_Invalid > 0 OR h.clean_ace_fips_st_Invalid > 0 OR h.clean_fipscounty_Invalid > 0 OR h.clean_geo_lat_Invalid > 0 OR h.clean_geo_long_Invalid > 0 OR h.clean_msa_Invalid > 0 OR h.clean_geo_match_Invalid > 0 OR h.clean_err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.append_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_credential_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_id_terminal_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_mi_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_sex_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_height_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_height2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_weight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_hair_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_eyes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dlexpiredate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dlstat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dlissuedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_originalissuedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_regstatfr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_regstatcr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dlclass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_historynum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_restrictions_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_comm_driv_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_organ_donor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_first_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_middle_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_fipscounty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_err_stat_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.append_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_credential_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_id_terminal_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_mi_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_sex_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_height_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_height2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_weight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_hair_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_eyes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dlexpiredate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dlstat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dlissuedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_originalissuedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_regstatfr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_regstatcr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dlclass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_historynum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_restrictions_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_endorsements10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_comm_driv_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_organ_donor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_first_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_middle_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_fipscounty_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_err_stat_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.orig_dob_Invalid,le.orig_credential_type_Invalid,le.orig_id_terminal_date_Invalid,le.orig_lname_Invalid,le.orig_fname_Invalid,le.orig_mi_Invalid,le.orig_street_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_sex_Invalid,le.orig_height_Invalid,le.orig_height2_Invalid,le.orig_weight_Invalid,le.orig_hair_Invalid,le.orig_eyes_Invalid,le.orig_dlexpiredate_Invalid,le.orig_dlstat_Invalid,le.orig_dlissuedate_Invalid,le.orig_originalissuedate_Invalid,le.orig_regstatfr_Invalid,le.orig_regstatcr_Invalid,le.orig_dlclass_Invalid,le.orig_historynum_Invalid,le.orig_restrictions_Invalid,le.orig_endorsements_Invalid,le.orig_endorsements2_Invalid,le.orig_endorsements3_Invalid,le.orig_endorsements4_Invalid,le.orig_endorsements5_Invalid,le.orig_endorsements6_Invalid,le.orig_endorsements7_Invalid,le.orig_endorsements8_Invalid,le.orig_endorsements9_Invalid,le.orig_endorsements10_Invalid,le.orig_comm_driv_status_Invalid,le.orig_organ_donor_Invalid,le.clean_name_first_Invalid,le.clean_name_middle_Invalid,le.clean_name_last_Invalid,le.clean_prim_name_Invalid,le.clean_p_city_name_Invalid,le.clean_v_city_name_Invalid,le.clean_st_Invalid,le.clean_zip_Invalid,le.clean_zip4_Invalid,le.clean_cart_Invalid,le.clean_lot_Invalid,le.clean_lot_order_Invalid,le.clean_dpbc_Invalid,le.clean_chk_digit_Invalid,le.clean_ace_fips_st_Invalid,le.clean_fipscounty_Invalid,le.clean_geo_lat_Invalid,le.clean_geo_long_Invalid,le.clean_msa_Invalid,le.clean_geo_match_Invalid,le.clean_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_credential_type(le.orig_credential_type_Invalid),Fields.InvalidMessage_orig_id_terminal_date(le.orig_id_terminal_date_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mi(le.orig_mi_Invalid),Fields.InvalidMessage_orig_street(le.orig_street_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_sex(le.orig_sex_Invalid),Fields.InvalidMessage_orig_height(le.orig_height_Invalid),Fields.InvalidMessage_orig_height2(le.orig_height2_Invalid),Fields.InvalidMessage_orig_weight(le.orig_weight_Invalid),Fields.InvalidMessage_orig_hair(le.orig_hair_Invalid),Fields.InvalidMessage_orig_eyes(le.orig_eyes_Invalid),Fields.InvalidMessage_orig_dlexpiredate(le.orig_dlexpiredate_Invalid),Fields.InvalidMessage_orig_dlstat(le.orig_dlstat_Invalid),Fields.InvalidMessage_orig_dlissuedate(le.orig_dlissuedate_Invalid),Fields.InvalidMessage_orig_originalissuedate(le.orig_originalissuedate_Invalid),Fields.InvalidMessage_orig_regstatfr(le.orig_regstatfr_Invalid),Fields.InvalidMessage_orig_regstatcr(le.orig_regstatcr_Invalid),Fields.InvalidMessage_orig_dlclass(le.orig_dlclass_Invalid),Fields.InvalidMessage_orig_historynum(le.orig_historynum_Invalid),Fields.InvalidMessage_orig_restrictions(le.orig_restrictions_Invalid),Fields.InvalidMessage_orig_endorsements(le.orig_endorsements_Invalid),Fields.InvalidMessage_orig_endorsements2(le.orig_endorsements2_Invalid),Fields.InvalidMessage_orig_endorsements3(le.orig_endorsements3_Invalid),Fields.InvalidMessage_orig_endorsements4(le.orig_endorsements4_Invalid),Fields.InvalidMessage_orig_endorsements5(le.orig_endorsements5_Invalid),Fields.InvalidMessage_orig_endorsements6(le.orig_endorsements6_Invalid),Fields.InvalidMessage_orig_endorsements7(le.orig_endorsements7_Invalid),Fields.InvalidMessage_orig_endorsements8(le.orig_endorsements8_Invalid),Fields.InvalidMessage_orig_endorsements9(le.orig_endorsements9_Invalid),Fields.InvalidMessage_orig_endorsements10(le.orig_endorsements10_Invalid),Fields.InvalidMessage_orig_comm_driv_status(le.orig_comm_driv_status_Invalid),Fields.InvalidMessage_orig_organ_donor(le.orig_organ_donor_Invalid),Fields.InvalidMessage_clean_name_first(le.clean_name_first_Invalid),Fields.InvalidMessage_clean_name_middle(le.clean_name_middle_Invalid),Fields.InvalidMessage_clean_name_last(le.clean_name_last_Invalid),Fields.InvalidMessage_clean_prim_name(le.clean_prim_name_Invalid),Fields.InvalidMessage_clean_p_city_name(le.clean_p_city_name_Invalid),Fields.InvalidMessage_clean_v_city_name(le.clean_v_city_name_Invalid),Fields.InvalidMessage_clean_st(le.clean_st_Invalid),Fields.InvalidMessage_clean_zip(le.clean_zip_Invalid),Fields.InvalidMessage_clean_zip4(le.clean_zip4_Invalid),Fields.InvalidMessage_clean_cart(le.clean_cart_Invalid),Fields.InvalidMessage_clean_lot(le.clean_lot_Invalid),Fields.InvalidMessage_clean_lot_order(le.clean_lot_order_Invalid),Fields.InvalidMessage_clean_dpbc(le.clean_dpbc_Invalid),Fields.InvalidMessage_clean_chk_digit(le.clean_chk_digit_Invalid),Fields.InvalidMessage_clean_ace_fips_st(le.clean_ace_fips_st_Invalid),Fields.InvalidMessage_clean_fipscounty(le.clean_fipscounty_Invalid),Fields.InvalidMessage_clean_geo_lat(le.clean_geo_lat_Invalid),Fields.InvalidMessage_clean_geo_long(le.clean_geo_long_Invalid),Fields.InvalidMessage_clean_msa(le.clean_msa_Invalid),Fields.InvalidMessage_clean_geo_match(le.clean_geo_match_Invalid),Fields.InvalidMessage_clean_err_stat(le.clean_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_credential_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_id_terminal_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_mi_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_street_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_sex_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_height_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_height2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_weight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_hair_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_eyes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_dlexpiredate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dlstat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_dlissuedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_originalissuedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_regstatfr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_regstatcr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_dlclass_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_historynum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_restrictions_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_endorsements_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements9_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_endorsements10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_comm_driv_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_organ_donor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_first_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_middle_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_last_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_dpbc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_ace_fips_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_fipscounty_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_err_stat_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','orig_dob','orig_credential_type','orig_id_terminal_date','orig_lname','orig_fname','orig_mi','orig_street','orig_city','orig_state','orig_zip','orig_sex','orig_height','orig_height2','orig_weight','orig_hair','orig_eyes','orig_dlexpiredate','orig_dlstat','orig_dlissuedate','orig_originalissuedate','orig_regstatfr','orig_regstatcr','orig_dlclass','orig_historynum','orig_restrictions','orig_endorsements','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_endorsements6','orig_endorsements7','orig_endorsements8','orig_endorsements9','orig_endorsements10','orig_comm_driv_status','orig_organ_donor','clean_name_first','clean_name_middle','clean_name_last','clean_prim_name','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_match','clean_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_process_date','invalid_Past_Date','invalid_orig_credential_type','invalid_Past_Date','invalid_orig_lname','invalid_orig_fname','invalid_Alpha','invalid_mandatory','invalid_mandatory','invalid_orig_state','invalid_orig_zip','invalid_orig_sex','invalid_Num','invalid_Num','invalid_Num','invalid_orig_hair','invalid_orig_eyes','invalid_General_Date','invalid_orig_dlstat','invalid_Past_Date','invalid_Past_Date','invalid_boolean','invalid_boolean','invalid_orig_dlclass','invalid_Num','invalid_Alpha_Numeric','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_comm_driv_status','invalid_boolean','invalid_clean_name_first','invalid_clean_name_middle','invalid_clean_name_last','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_orig_state','invalid_zip5','invalid_zip4','invalid_clean_cart','invalid_clean_lot','invalid_clean_lot_order','invalid_clean_dpbc','invalid_clean_chk_digit','invalid_clean_fips_state','invalid_clean_fips_county','invalid_clean_geo','invalid_clean_geo','invalid_clean_msa','invalid_clean_geo_match','invalid_clean_err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.append_process_date,(SALT38.StrType)le.orig_dob,(SALT38.StrType)le.orig_credential_type,(SALT38.StrType)le.orig_id_terminal_date,(SALT38.StrType)le.orig_lname,(SALT38.StrType)le.orig_fname,(SALT38.StrType)le.orig_mi,(SALT38.StrType)le.orig_street,(SALT38.StrType)le.orig_city,(SALT38.StrType)le.orig_state,(SALT38.StrType)le.orig_zip,(SALT38.StrType)le.orig_sex,(SALT38.StrType)le.orig_height,(SALT38.StrType)le.orig_height2,(SALT38.StrType)le.orig_weight,(SALT38.StrType)le.orig_hair,(SALT38.StrType)le.orig_eyes,(SALT38.StrType)le.orig_dlexpiredate,(SALT38.StrType)le.orig_dlstat,(SALT38.StrType)le.orig_dlissuedate,(SALT38.StrType)le.orig_originalissuedate,(SALT38.StrType)le.orig_regstatfr,(SALT38.StrType)le.orig_regstatcr,(SALT38.StrType)le.orig_dlclass,(SALT38.StrType)le.orig_historynum,(SALT38.StrType)le.orig_restrictions,(SALT38.StrType)le.orig_endorsements,(SALT38.StrType)le.orig_endorsements2,(SALT38.StrType)le.orig_endorsements3,(SALT38.StrType)le.orig_endorsements4,(SALT38.StrType)le.orig_endorsements5,(SALT38.StrType)le.orig_endorsements6,(SALT38.StrType)le.orig_endorsements7,(SALT38.StrType)le.orig_endorsements8,(SALT38.StrType)le.orig_endorsements9,(SALT38.StrType)le.orig_endorsements10,(SALT38.StrType)le.orig_comm_driv_status,(SALT38.StrType)le.orig_organ_donor,(SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.clean_name_last,(SALT38.StrType)le.clean_prim_name,(SALT38.StrType)le.clean_p_city_name,(SALT38.StrType)le.clean_v_city_name,(SALT38.StrType)le.clean_st,(SALT38.StrType)le.clean_zip,(SALT38.StrType)le.clean_zip4,(SALT38.StrType)le.clean_cart,(SALT38.StrType)le.clean_lot,(SALT38.StrType)le.clean_lot_order,(SALT38.StrType)le.clean_dpbc,(SALT38.StrType)le.clean_chk_digit,(SALT38.StrType)le.clean_ace_fips_st,(SALT38.StrType)le.clean_fipscounty,(SALT38.StrType)le.clean_geo_lat,(SALT38.StrType)le.clean_geo_long,(SALT38.StrType)le.clean_msa,(SALT38.StrType)le.clean_geo_match,(SALT38.StrType)le.clean_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,59,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_ME_MEDCERT) prevDS = DATASET([], Layout_In_ME_MEDCERT), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_process_date:CUSTOM'
          ,'orig_dob:invalid_Past_Date:CUSTOM'
          ,'orig_credential_type:invalid_orig_credential_type:ALLOW'
          ,'orig_id_terminal_date:invalid_Past_Date:CUSTOM'
          ,'orig_lname:invalid_orig_lname:CUSTOM'
          ,'orig_fname:invalid_orig_fname:CUSTOM'
          ,'orig_mi:invalid_Alpha:CUSTOM'
          ,'orig_street:invalid_mandatory:CUSTOM'
          ,'orig_city:invalid_mandatory:CUSTOM'
          ,'orig_state:invalid_orig_state:CUSTOM'
          ,'orig_zip:invalid_orig_zip:CUSTOM'
          ,'orig_sex:invalid_orig_sex:ALLOW'
          ,'orig_height:invalid_Num:ALLOW'
          ,'orig_height2:invalid_Num:ALLOW'
          ,'orig_weight:invalid_Num:ALLOW'
          ,'orig_hair:invalid_orig_hair:ALLOW'
          ,'orig_eyes:invalid_orig_eyes:ALLOW'
          ,'orig_dlexpiredate:invalid_General_Date:CUSTOM'
          ,'orig_dlstat:invalid_orig_dlstat:ALLOW'
          ,'orig_dlissuedate:invalid_Past_Date:CUSTOM'
          ,'orig_originalissuedate:invalid_Past_Date:CUSTOM'
          ,'orig_regstatfr:invalid_boolean:ALLOW'
          ,'orig_regstatcr:invalid_boolean:ALLOW'
          ,'orig_dlclass:invalid_orig_dlclass:ALLOW'
          ,'orig_historynum:invalid_Num:ALLOW'
          ,'orig_restrictions:invalid_Alpha_Numeric:CUSTOM'
          ,'orig_endorsements:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements2:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements3:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements4:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements5:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements6:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements7:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements8:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements9:invalid_orig_endorsements:ALLOW'
          ,'orig_endorsements10:invalid_orig_endorsements:ALLOW'
          ,'orig_comm_driv_status:invalid_orig_comm_driv_status:ALLOW'
          ,'orig_organ_donor:invalid_boolean:ALLOW'
          ,'clean_name_first:invalid_clean_name_first:CUSTOM'
          ,'clean_name_middle:invalid_clean_name_middle:CUSTOM'
          ,'clean_name_last:invalid_clean_name_last:CUSTOM'
          ,'clean_prim_name:invalid_mandatory:CUSTOM'
          ,'clean_p_city_name:invalid_mandatory:CUSTOM'
          ,'clean_v_city_name:invalid_mandatory:CUSTOM'
          ,'clean_st:invalid_orig_state:CUSTOM'
          ,'clean_zip:invalid_zip5:CUSTOM'
          ,'clean_zip4:invalid_zip4:CUSTOM'
          ,'clean_cart:invalid_clean_cart:CUSTOM'
          ,'clean_lot:invalid_clean_lot:CUSTOM'
          ,'clean_lot_order:invalid_clean_lot_order:ENUM'
          ,'clean_dpbc:invalid_clean_dpbc:CUSTOM'
          ,'clean_chk_digit:invalid_clean_chk_digit:CUSTOM'
          ,'clean_ace_fips_st:invalid_clean_fips_state:CUSTOM'
          ,'clean_fipscounty:invalid_clean_fips_county:CUSTOM'
          ,'clean_geo_lat:invalid_clean_geo:CUSTOM'
          ,'clean_geo_long:invalid_clean_geo:CUSTOM'
          ,'clean_msa:invalid_clean_msa:CUSTOM'
          ,'clean_geo_match:invalid_clean_geo_match:CUSTOM'
          ,'clean_err_stat:invalid_clean_err_stat:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1)
          ,Fields.InvalidMessage_orig_dob(1)
          ,Fields.InvalidMessage_orig_credential_type(1)
          ,Fields.InvalidMessage_orig_id_terminal_date(1)
          ,Fields.InvalidMessage_orig_lname(1)
          ,Fields.InvalidMessage_orig_fname(1)
          ,Fields.InvalidMessage_orig_mi(1)
          ,Fields.InvalidMessage_orig_street(1)
          ,Fields.InvalidMessage_orig_city(1)
          ,Fields.InvalidMessage_orig_state(1)
          ,Fields.InvalidMessage_orig_zip(1)
          ,Fields.InvalidMessage_orig_sex(1)
          ,Fields.InvalidMessage_orig_height(1)
          ,Fields.InvalidMessage_orig_height2(1)
          ,Fields.InvalidMessage_orig_weight(1)
          ,Fields.InvalidMessage_orig_hair(1)
          ,Fields.InvalidMessage_orig_eyes(1)
          ,Fields.InvalidMessage_orig_dlexpiredate(1)
          ,Fields.InvalidMessage_orig_dlstat(1)
          ,Fields.InvalidMessage_orig_dlissuedate(1)
          ,Fields.InvalidMessage_orig_originalissuedate(1)
          ,Fields.InvalidMessage_orig_regstatfr(1)
          ,Fields.InvalidMessage_orig_regstatcr(1)
          ,Fields.InvalidMessage_orig_dlclass(1)
          ,Fields.InvalidMessage_orig_historynum(1)
          ,Fields.InvalidMessage_orig_restrictions(1)
          ,Fields.InvalidMessage_orig_endorsements(1)
          ,Fields.InvalidMessage_orig_endorsements2(1)
          ,Fields.InvalidMessage_orig_endorsements3(1)
          ,Fields.InvalidMessage_orig_endorsements4(1)
          ,Fields.InvalidMessage_orig_endorsements5(1)
          ,Fields.InvalidMessage_orig_endorsements6(1)
          ,Fields.InvalidMessage_orig_endorsements7(1)
          ,Fields.InvalidMessage_orig_endorsements8(1)
          ,Fields.InvalidMessage_orig_endorsements9(1)
          ,Fields.InvalidMessage_orig_endorsements10(1)
          ,Fields.InvalidMessage_orig_comm_driv_status(1)
          ,Fields.InvalidMessage_orig_organ_donor(1)
          ,Fields.InvalidMessage_clean_name_first(1)
          ,Fields.InvalidMessage_clean_name_middle(1)
          ,Fields.InvalidMessage_clean_name_last(1)
          ,Fields.InvalidMessage_clean_prim_name(1)
          ,Fields.InvalidMessage_clean_p_city_name(1)
          ,Fields.InvalidMessage_clean_v_city_name(1)
          ,Fields.InvalidMessage_clean_st(1)
          ,Fields.InvalidMessage_clean_zip(1)
          ,Fields.InvalidMessage_clean_zip4(1)
          ,Fields.InvalidMessage_clean_cart(1)
          ,Fields.InvalidMessage_clean_lot(1)
          ,Fields.InvalidMessage_clean_lot_order(1)
          ,Fields.InvalidMessage_clean_dpbc(1)
          ,Fields.InvalidMessage_clean_chk_digit(1)
          ,Fields.InvalidMessage_clean_ace_fips_st(1)
          ,Fields.InvalidMessage_clean_fipscounty(1)
          ,Fields.InvalidMessage_clean_geo_lat(1)
          ,Fields.InvalidMessage_clean_geo_long(1)
          ,Fields.InvalidMessage_clean_msa(1)
          ,Fields.InvalidMessage_clean_geo_match(1)
          ,Fields.InvalidMessage_clean_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_credential_type_ALLOW_ErrorCount
          ,le.orig_id_terminal_date_CUSTOM_ErrorCount
          ,le.orig_lname_CUSTOM_ErrorCount
          ,le.orig_fname_CUSTOM_ErrorCount
          ,le.orig_mi_CUSTOM_ErrorCount
          ,le.orig_street_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_CUSTOM_ErrorCount
          ,le.orig_sex_ALLOW_ErrorCount
          ,le.orig_height_ALLOW_ErrorCount
          ,le.orig_height2_ALLOW_ErrorCount
          ,le.orig_weight_ALLOW_ErrorCount
          ,le.orig_hair_ALLOW_ErrorCount
          ,le.orig_eyes_ALLOW_ErrorCount
          ,le.orig_dlexpiredate_CUSTOM_ErrorCount
          ,le.orig_dlstat_ALLOW_ErrorCount
          ,le.orig_dlissuedate_CUSTOM_ErrorCount
          ,le.orig_originalissuedate_CUSTOM_ErrorCount
          ,le.orig_regstatfr_ALLOW_ErrorCount
          ,le.orig_regstatcr_ALLOW_ErrorCount
          ,le.orig_dlclass_ALLOW_ErrorCount
          ,le.orig_historynum_ALLOW_ErrorCount
          ,le.orig_restrictions_CUSTOM_ErrorCount
          ,le.orig_endorsements_ALLOW_ErrorCount
          ,le.orig_endorsements2_ALLOW_ErrorCount
          ,le.orig_endorsements3_ALLOW_ErrorCount
          ,le.orig_endorsements4_ALLOW_ErrorCount
          ,le.orig_endorsements5_ALLOW_ErrorCount
          ,le.orig_endorsements6_ALLOW_ErrorCount
          ,le.orig_endorsements7_ALLOW_ErrorCount
          ,le.orig_endorsements8_ALLOW_ErrorCount
          ,le.orig_endorsements9_ALLOW_ErrorCount
          ,le.orig_endorsements10_ALLOW_ErrorCount
          ,le.orig_comm_driv_status_ALLOW_ErrorCount
          ,le.orig_organ_donor_ALLOW_ErrorCount
          ,le.clean_name_first_CUSTOM_ErrorCount
          ,le.clean_name_middle_CUSTOM_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_prim_name_CUSTOM_ErrorCount
          ,le.clean_p_city_name_CUSTOM_ErrorCount
          ,le.clean_v_city_name_CUSTOM_ErrorCount
          ,le.clean_st_CUSTOM_ErrorCount
          ,le.clean_zip_CUSTOM_ErrorCount
          ,le.clean_zip4_CUSTOM_ErrorCount
          ,le.clean_cart_CUSTOM_ErrorCount
          ,le.clean_lot_CUSTOM_ErrorCount
          ,le.clean_lot_order_ENUM_ErrorCount
          ,le.clean_dpbc_CUSTOM_ErrorCount
          ,le.clean_chk_digit_CUSTOM_ErrorCount
          ,le.clean_ace_fips_st_CUSTOM_ErrorCount
          ,le.clean_fipscounty_CUSTOM_ErrorCount
          ,le.clean_geo_lat_CUSTOM_ErrorCount
          ,le.clean_geo_long_CUSTOM_ErrorCount
          ,le.clean_msa_CUSTOM_ErrorCount
          ,le.clean_geo_match_CUSTOM_ErrorCount
          ,le.clean_err_stat_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_credential_type_ALLOW_ErrorCount
          ,le.orig_id_terminal_date_CUSTOM_ErrorCount
          ,le.orig_lname_CUSTOM_ErrorCount
          ,le.orig_fname_CUSTOM_ErrorCount
          ,le.orig_mi_CUSTOM_ErrorCount
          ,le.orig_street_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_CUSTOM_ErrorCount
          ,le.orig_sex_ALLOW_ErrorCount
          ,le.orig_height_ALLOW_ErrorCount
          ,le.orig_height2_ALLOW_ErrorCount
          ,le.orig_weight_ALLOW_ErrorCount
          ,le.orig_hair_ALLOW_ErrorCount
          ,le.orig_eyes_ALLOW_ErrorCount
          ,le.orig_dlexpiredate_CUSTOM_ErrorCount
          ,le.orig_dlstat_ALLOW_ErrorCount
          ,le.orig_dlissuedate_CUSTOM_ErrorCount
          ,le.orig_originalissuedate_CUSTOM_ErrorCount
          ,le.orig_regstatfr_ALLOW_ErrorCount
          ,le.orig_regstatcr_ALLOW_ErrorCount
          ,le.orig_dlclass_ALLOW_ErrorCount
          ,le.orig_historynum_ALLOW_ErrorCount
          ,le.orig_restrictions_CUSTOM_ErrorCount
          ,le.orig_endorsements_ALLOW_ErrorCount
          ,le.orig_endorsements2_ALLOW_ErrorCount
          ,le.orig_endorsements3_ALLOW_ErrorCount
          ,le.orig_endorsements4_ALLOW_ErrorCount
          ,le.orig_endorsements5_ALLOW_ErrorCount
          ,le.orig_endorsements6_ALLOW_ErrorCount
          ,le.orig_endorsements7_ALLOW_ErrorCount
          ,le.orig_endorsements8_ALLOW_ErrorCount
          ,le.orig_endorsements9_ALLOW_ErrorCount
          ,le.orig_endorsements10_ALLOW_ErrorCount
          ,le.orig_comm_driv_status_ALLOW_ErrorCount
          ,le.orig_organ_donor_ALLOW_ErrorCount
          ,le.clean_name_first_CUSTOM_ErrorCount
          ,le.clean_name_middle_CUSTOM_ErrorCount
          ,le.clean_name_last_CUSTOM_ErrorCount
          ,le.clean_prim_name_CUSTOM_ErrorCount
          ,le.clean_p_city_name_CUSTOM_ErrorCount
          ,le.clean_v_city_name_CUSTOM_ErrorCount
          ,le.clean_st_CUSTOM_ErrorCount
          ,le.clean_zip_CUSTOM_ErrorCount
          ,le.clean_zip4_CUSTOM_ErrorCount
          ,le.clean_cart_CUSTOM_ErrorCount
          ,le.clean_lot_CUSTOM_ErrorCount
          ,le.clean_lot_order_ENUM_ErrorCount
          ,le.clean_dpbc_CUSTOM_ErrorCount
          ,le.clean_chk_digit_CUSTOM_ErrorCount
          ,le.clean_ace_fips_st_CUSTOM_ErrorCount
          ,le.clean_fipscounty_CUSTOM_ErrorCount
          ,le.clean_geo_lat_CUSTOM_ErrorCount
          ,le.clean_geo_long_CUSTOM_ErrorCount
          ,le.clean_msa_CUSTOM_ErrorCount
          ,le.clean_geo_match_CUSTOM_ErrorCount
          ,le.clean_err_stat_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_ME_MEDCERT));
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
          ,'append_process_date:' + getFieldTypeText(h.append_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_credential_type:' + getFieldTypeText(h.orig_credential_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_id_terminal_date:' + getFieldTypeText(h.orig_id_terminal_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mi:' + getFieldTypeText(h.orig_mi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_namesuf:' + getFieldTypeText(h.orig_namesuf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street:' + getFieldTypeText(h.orig_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_drivered:' + getFieldTypeText(h.orig_drivered) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_sex:' + getFieldTypeText(h.orig_sex) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_height:' + getFieldTypeText(h.orig_height) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_height2:' + getFieldTypeText(h.orig_height2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_weight:' + getFieldTypeText(h.orig_weight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_hair:' + getFieldTypeText(h.orig_hair) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_eyes:' + getFieldTypeText(h.orig_eyes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dlexpiredate:' + getFieldTypeText(h.orig_dlexpiredate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dlstat:' + getFieldTypeText(h.orig_dlstat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dlissuedate:' + getFieldTypeText(h.orig_dlissuedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_originalissuedate:' + getFieldTypeText(h.orig_originalissuedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_regstatfr:' + getFieldTypeText(h.orig_regstatfr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_regstatcr:' + getFieldTypeText(h.orig_regstatcr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dlclass:' + getFieldTypeText(h.orig_dlclass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_historynum:' + getFieldTypeText(h.orig_historynum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_disabledvet:' + getFieldTypeText(h.orig_disabledvet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_photo:' + getFieldTypeText(h.orig_photo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_habitualoffender:' + getFieldTypeText(h.orig_habitualoffender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_restrictions:' + getFieldTypeText(h.orig_restrictions) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements:' + getFieldTypeText(h.orig_endorsements) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements2:' + getFieldTypeText(h.orig_endorsements2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements3:' + getFieldTypeText(h.orig_endorsements3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements4:' + getFieldTypeText(h.orig_endorsements4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements5:' + getFieldTypeText(h.orig_endorsements5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements6:' + getFieldTypeText(h.orig_endorsements6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements7:' + getFieldTypeText(h.orig_endorsements7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements8:' + getFieldTypeText(h.orig_endorsements8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements9:' + getFieldTypeText(h.orig_endorsements9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements10:' + getFieldTypeText(h.orig_endorsements10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_endorsements11_20:' + getFieldTypeText(h.orig_endorsements11_20) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_comm_driv_status:' + getFieldTypeText(h.orig_comm_driv_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_disabled_vet_type:' + getFieldTypeText(h.orig_disabled_vet_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_organ_donor:' + getFieldTypeText(h.orig_organ_donor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_crlf:' + getFieldTypeText(h.orig_crlf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_prefix:' + getFieldTypeText(h.clean_name_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_first:' + getFieldTypeText(h.clean_name_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_middle:' + getFieldTypeText(h.clean_name_middle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_last:' + getFieldTypeText(h.clean_name_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_suffix:' + getFieldTypeText(h.clean_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_score:' + getFieldTypeText(h.clean_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_prim_range:' + getFieldTypeText(h.clean_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_predir:' + getFieldTypeText(h.clean_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_prim_name:' + getFieldTypeText(h.clean_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_addr_suffix:' + getFieldTypeText(h.clean_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_postdir:' + getFieldTypeText(h.clean_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_unit_desig:' + getFieldTypeText(h.clean_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_sec_range:' + getFieldTypeText(h.clean_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_p_city_name:' + getFieldTypeText(h.clean_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_v_city_name:' + getFieldTypeText(h.clean_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_st:' + getFieldTypeText(h.clean_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_zip:' + getFieldTypeText(h.clean_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_zip4:' + getFieldTypeText(h.clean_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_cart:' + getFieldTypeText(h.clean_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_cr_sort_sz:' + getFieldTypeText(h.clean_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_lot:' + getFieldTypeText(h.clean_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_lot_order:' + getFieldTypeText(h.clean_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dpbc:' + getFieldTypeText(h.clean_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_chk_digit:' + getFieldTypeText(h.clean_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_record_type:' + getFieldTypeText(h.clean_record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_ace_fips_st:' + getFieldTypeText(h.clean_ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_fipscounty:' + getFieldTypeText(h.clean_fipscounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_geo_lat:' + getFieldTypeText(h.clean_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_geo_long:' + getFieldTypeText(h.clean_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_msa:' + getFieldTypeText(h.clean_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_geo_blk:' + getFieldTypeText(h.clean_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_geo_match:' + getFieldTypeText(h.clean_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_err_stat:' + getFieldTypeText(h.clean_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_append_process_date_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_credential_type_cnt
          ,le.populated_orig_id_terminal_date_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mi_cnt
          ,le.populated_orig_namesuf_cnt
          ,le.populated_orig_street_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_drivered_cnt
          ,le.populated_orig_sex_cnt
          ,le.populated_orig_height_cnt
          ,le.populated_orig_height2_cnt
          ,le.populated_orig_weight_cnt
          ,le.populated_orig_hair_cnt
          ,le.populated_orig_eyes_cnt
          ,le.populated_orig_dlexpiredate_cnt
          ,le.populated_orig_dlstat_cnt
          ,le.populated_orig_dlissuedate_cnt
          ,le.populated_orig_originalissuedate_cnt
          ,le.populated_orig_regstatfr_cnt
          ,le.populated_orig_regstatcr_cnt
          ,le.populated_orig_dlclass_cnt
          ,le.populated_orig_historynum_cnt
          ,le.populated_orig_disabledvet_cnt
          ,le.populated_orig_photo_cnt
          ,le.populated_orig_habitualoffender_cnt
          ,le.populated_orig_restrictions_cnt
          ,le.populated_orig_endorsements_cnt
          ,le.populated_orig_endorsements2_cnt
          ,le.populated_orig_endorsements3_cnt
          ,le.populated_orig_endorsements4_cnt
          ,le.populated_orig_endorsements5_cnt
          ,le.populated_orig_endorsements6_cnt
          ,le.populated_orig_endorsements7_cnt
          ,le.populated_orig_endorsements8_cnt
          ,le.populated_orig_endorsements9_cnt
          ,le.populated_orig_endorsements10_cnt
          ,le.populated_orig_endorsements11_20_cnt
          ,le.populated_orig_comm_driv_status_cnt
          ,le.populated_orig_disabled_vet_type_cnt
          ,le.populated_orig_organ_donor_cnt
          ,le.populated_orig_crlf_cnt
          ,le.populated_clean_name_prefix_cnt
          ,le.populated_clean_name_first_cnt
          ,le.populated_clean_name_middle_cnt
          ,le.populated_clean_name_last_cnt
          ,le.populated_clean_name_suffix_cnt
          ,le.populated_clean_name_score_cnt
          ,le.populated_clean_prim_range_cnt
          ,le.populated_clean_predir_cnt
          ,le.populated_clean_prim_name_cnt
          ,le.populated_clean_addr_suffix_cnt
          ,le.populated_clean_postdir_cnt
          ,le.populated_clean_unit_desig_cnt
          ,le.populated_clean_sec_range_cnt
          ,le.populated_clean_p_city_name_cnt
          ,le.populated_clean_v_city_name_cnt
          ,le.populated_clean_st_cnt
          ,le.populated_clean_zip_cnt
          ,le.populated_clean_zip4_cnt
          ,le.populated_clean_cart_cnt
          ,le.populated_clean_cr_sort_sz_cnt
          ,le.populated_clean_lot_cnt
          ,le.populated_clean_lot_order_cnt
          ,le.populated_clean_dpbc_cnt
          ,le.populated_clean_chk_digit_cnt
          ,le.populated_clean_record_type_cnt
          ,le.populated_clean_ace_fips_st_cnt
          ,le.populated_clean_fipscounty_cnt
          ,le.populated_clean_geo_lat_cnt
          ,le.populated_clean_geo_long_cnt
          ,le.populated_clean_msa_cnt
          ,le.populated_clean_geo_blk_cnt
          ,le.populated_clean_geo_match_cnt
          ,le.populated_clean_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_append_process_date_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_credential_type_pcnt
          ,le.populated_orig_id_terminal_date_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mi_pcnt
          ,le.populated_orig_namesuf_pcnt
          ,le.populated_orig_street_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_drivered_pcnt
          ,le.populated_orig_sex_pcnt
          ,le.populated_orig_height_pcnt
          ,le.populated_orig_height2_pcnt
          ,le.populated_orig_weight_pcnt
          ,le.populated_orig_hair_pcnt
          ,le.populated_orig_eyes_pcnt
          ,le.populated_orig_dlexpiredate_pcnt
          ,le.populated_orig_dlstat_pcnt
          ,le.populated_orig_dlissuedate_pcnt
          ,le.populated_orig_originalissuedate_pcnt
          ,le.populated_orig_regstatfr_pcnt
          ,le.populated_orig_regstatcr_pcnt
          ,le.populated_orig_dlclass_pcnt
          ,le.populated_orig_historynum_pcnt
          ,le.populated_orig_disabledvet_pcnt
          ,le.populated_orig_photo_pcnt
          ,le.populated_orig_habitualoffender_pcnt
          ,le.populated_orig_restrictions_pcnt
          ,le.populated_orig_endorsements_pcnt
          ,le.populated_orig_endorsements2_pcnt
          ,le.populated_orig_endorsements3_pcnt
          ,le.populated_orig_endorsements4_pcnt
          ,le.populated_orig_endorsements5_pcnt
          ,le.populated_orig_endorsements6_pcnt
          ,le.populated_orig_endorsements7_pcnt
          ,le.populated_orig_endorsements8_pcnt
          ,le.populated_orig_endorsements9_pcnt
          ,le.populated_orig_endorsements10_pcnt
          ,le.populated_orig_endorsements11_20_pcnt
          ,le.populated_orig_comm_driv_status_pcnt
          ,le.populated_orig_disabled_vet_type_pcnt
          ,le.populated_orig_organ_donor_pcnt
          ,le.populated_orig_crlf_pcnt
          ,le.populated_clean_name_prefix_pcnt
          ,le.populated_clean_name_first_pcnt
          ,le.populated_clean_name_middle_pcnt
          ,le.populated_clean_name_last_pcnt
          ,le.populated_clean_name_suffix_pcnt
          ,le.populated_clean_name_score_pcnt
          ,le.populated_clean_prim_range_pcnt
          ,le.populated_clean_predir_pcnt
          ,le.populated_clean_prim_name_pcnt
          ,le.populated_clean_addr_suffix_pcnt
          ,le.populated_clean_postdir_pcnt
          ,le.populated_clean_unit_desig_pcnt
          ,le.populated_clean_sec_range_pcnt
          ,le.populated_clean_p_city_name_pcnt
          ,le.populated_clean_v_city_name_pcnt
          ,le.populated_clean_st_pcnt
          ,le.populated_clean_zip_pcnt
          ,le.populated_clean_zip4_pcnt
          ,le.populated_clean_cart_pcnt
          ,le.populated_clean_cr_sort_sz_pcnt
          ,le.populated_clean_lot_pcnt
          ,le.populated_clean_lot_order_pcnt
          ,le.populated_clean_dpbc_pcnt
          ,le.populated_clean_chk_digit_pcnt
          ,le.populated_clean_record_type_pcnt
          ,le.populated_clean_ace_fips_st_pcnt
          ,le.populated_clean_fipscounty_pcnt
          ,le.populated_clean_geo_lat_pcnt
          ,le.populated_clean_geo_long_pcnt
          ,le.populated_clean_msa_pcnt
          ,le.populated_clean_geo_blk_pcnt
          ,le.populated_clean_geo_match_pcnt
          ,le.populated_clean_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,79,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_ME_MEDCERT));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),79,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_ME_MEDCERT) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_ME_MEDCERT, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
