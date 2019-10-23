IMPORT SALT38,STD;
IMPORT Scrubs_DL_MO_MEDCERT; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 86;
  EXPORT NumRulesFromFieldType := 86;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 86;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_MO_MEDCERT)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 unique_key_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 mailing_address1_Invalid;
    UNSIGNED1 mailing_city_Invalid;
    UNSIGNED1 mailing_state_Invalid;
    UNSIGNED1 mailing_zip_Invalid;
    UNSIGNED1 height_Invalid;
    UNSIGNED1 eye_color_Invalid;
    UNSIGNED1 operator_status_Invalid;
    UNSIGNED1 commercial_status_Invalid;
    UNSIGNED1 sch_bus_status_Invalid;
    UNSIGNED1 pending_act_code_Invalid;
    UNSIGNED1 must_test_ind_Invalid;
    UNSIGNED1 deceased_ind_Invalid;
    UNSIGNED1 prev_cdl_class_Invalid;
    UNSIGNED1 cdl_ptr_Invalid;
    UNSIGNED1 pdps_ptr_Invalid;
    UNSIGNED1 mvr_privacy_code_Invalid;
    UNSIGNED1 brc_status_date_Invalid;
    UNSIGNED1 lic_iss_code_Invalid;
    UNSIGNED1 license_class_Invalid;
    UNSIGNED1 lic_exp_date_Invalid;
    UNSIGNED1 lic_seq_number_Invalid;
    UNSIGNED1 lic_surrender_to_Invalid;
    UNSIGNED1 license_endorsements_Invalid;
    UNSIGNED1 license_restrictions_Invalid;
    UNSIGNED1 license_trans_type_Invalid;
    UNSIGNED1 lic_print_date_Invalid;
    UNSIGNED1 permit_iss_code_Invalid;
    UNSIGNED1 permit_class_Invalid;
    UNSIGNED1 permit_exp_date_Invalid;
    UNSIGNED1 permit_seq_number_Invalid;
    UNSIGNED1 permit_endorse_codes_Invalid;
    UNSIGNED1 permit_restric_codes_Invalid;
    UNSIGNED1 permit_trans_type_Invalid;
    UNSIGNED1 permit_print_date_Invalid;
    UNSIGNED1 non_driver_code_Invalid;
    UNSIGNED1 non_driver_exp_date_Invalid;
    UNSIGNED1 non_driver_seq_num_Invalid;
    UNSIGNED1 non_driver_trans_type_Invalid;
    UNSIGNED1 non_driver_print_date_Invalid;
    UNSIGNED1 action_surrender_date_Invalid;
    UNSIGNED1 action_counts_Invalid;
    UNSIGNED1 driv_priv_counts_Invalid;
    UNSIGNED1 conv_counts_Invalid;
    UNSIGNED1 accidents_counts_Invalid;
    UNSIGNED1 aka_counts_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 cln_zip5_Invalid;
    UNSIGNED1 cln_zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dpbc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 previous_dl_number_Invalid;
    UNSIGNED1 previous_st_Invalid;
    UNSIGNED1 old_dl_number_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_MO_MEDCERT)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_In_MO_MEDCERT) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT38.StrType)le.process_date);
    SELF.unique_key_Invalid := Fields.InValid_unique_key((SALT38.StrType)le.unique_key);
    SELF.license_number_Invalid := Fields.InValid_license_number((SALT38.StrType)le.license_number);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT38.StrType)le.last_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.middle_name);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT38.StrType)le.first_name,(SALT38.StrType)le.middle_name,(SALT38.StrType)le.last_name);
    SELF.middle_name_Invalid := Fields.InValid_middle_name((SALT38.StrType)le.middle_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.last_name);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT38.StrType)le.date_of_birth);
    SELF.gender_Invalid := Fields.InValid_gender((SALT38.StrType)le.gender);
    SELF.address_Invalid := Fields.InValid_address((SALT38.StrType)le.address);
    SELF.city_Invalid := Fields.InValid_city((SALT38.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT38.StrType)le.state);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT38.StrType)le.zip5);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.mailing_address1_Invalid := Fields.InValid_mailing_address1((SALT38.StrType)le.mailing_address1);
    SELF.mailing_city_Invalid := Fields.InValid_mailing_city((SALT38.StrType)le.mailing_city);
    SELF.mailing_state_Invalid := Fields.InValid_mailing_state((SALT38.StrType)le.mailing_state);
    SELF.mailing_zip_Invalid := Fields.InValid_mailing_zip((SALT38.StrType)le.mailing_zip);
    SELF.height_Invalid := Fields.InValid_height((SALT38.StrType)le.height);
    SELF.eye_color_Invalid := Fields.InValid_eye_color((SALT38.StrType)le.eye_color);
    SELF.operator_status_Invalid := Fields.InValid_operator_status((SALT38.StrType)le.operator_status);
    SELF.commercial_status_Invalid := Fields.InValid_commercial_status((SALT38.StrType)le.commercial_status);
    SELF.sch_bus_status_Invalid := Fields.InValid_sch_bus_status((SALT38.StrType)le.sch_bus_status);
    SELF.pending_act_code_Invalid := Fields.InValid_pending_act_code((SALT38.StrType)le.pending_act_code);
    SELF.must_test_ind_Invalid := Fields.InValid_must_test_ind((SALT38.StrType)le.must_test_ind);
    SELF.deceased_ind_Invalid := Fields.InValid_deceased_ind((SALT38.StrType)le.deceased_ind);
    SELF.prev_cdl_class_Invalid := Fields.InValid_prev_cdl_class((SALT38.StrType)le.prev_cdl_class);
    SELF.cdl_ptr_Invalid := Fields.InValid_cdl_ptr((SALT38.StrType)le.cdl_ptr);
    SELF.pdps_ptr_Invalid := Fields.InValid_pdps_ptr((SALT38.StrType)le.pdps_ptr);
    SELF.mvr_privacy_code_Invalid := Fields.InValid_mvr_privacy_code((SALT38.StrType)le.mvr_privacy_code);
    SELF.brc_status_date_Invalid := Fields.InValid_brc_status_date((SALT38.StrType)le.brc_status_date);
    SELF.lic_iss_code_Invalid := Fields.InValid_lic_iss_code((SALT38.StrType)le.lic_iss_code);
    SELF.license_class_Invalid := Fields.InValid_license_class((SALT38.StrType)le.license_class);
    SELF.lic_exp_date_Invalid := Fields.InValid_lic_exp_date((SALT38.StrType)le.lic_exp_date);
    SELF.lic_seq_number_Invalid := Fields.InValid_lic_seq_number((SALT38.StrType)le.lic_seq_number);
    SELF.lic_surrender_to_Invalid := Fields.InValid_lic_surrender_to((SALT38.StrType)le.lic_surrender_to);
    SELF.license_endorsements_Invalid := Fields.InValid_license_endorsements((SALT38.StrType)le.license_endorsements);
    SELF.license_restrictions_Invalid := Fields.InValid_license_restrictions((SALT38.StrType)le.license_restrictions);
    SELF.license_trans_type_Invalid := Fields.InValid_license_trans_type((SALT38.StrType)le.license_trans_type);
    SELF.lic_print_date_Invalid := Fields.InValid_lic_print_date((SALT38.StrType)le.lic_print_date);
    SELF.permit_iss_code_Invalid := Fields.InValid_permit_iss_code((SALT38.StrType)le.permit_iss_code);
    SELF.permit_class_Invalid := Fields.InValid_permit_class((SALT38.StrType)le.permit_class);
    SELF.permit_exp_date_Invalid := Fields.InValid_permit_exp_date((SALT38.StrType)le.permit_exp_date);
    SELF.permit_seq_number_Invalid := Fields.InValid_permit_seq_number((SALT38.StrType)le.permit_seq_number);
    SELF.permit_endorse_codes_Invalid := Fields.InValid_permit_endorse_codes((SALT38.StrType)le.permit_endorse_codes);
    SELF.permit_restric_codes_Invalid := Fields.InValid_permit_restric_codes((SALT38.StrType)le.permit_restric_codes);
    SELF.permit_trans_type_Invalid := Fields.InValid_permit_trans_type((SALT38.StrType)le.permit_trans_type);
    SELF.permit_print_date_Invalid := Fields.InValid_permit_print_date((SALT38.StrType)le.permit_print_date);
    SELF.non_driver_code_Invalid := Fields.InValid_non_driver_code((SALT38.StrType)le.non_driver_code);
    SELF.non_driver_exp_date_Invalid := Fields.InValid_non_driver_exp_date((SALT38.StrType)le.non_driver_exp_date);
    SELF.non_driver_seq_num_Invalid := Fields.InValid_non_driver_seq_num((SALT38.StrType)le.non_driver_seq_num);
    SELF.non_driver_trans_type_Invalid := Fields.InValid_non_driver_trans_type((SALT38.StrType)le.non_driver_trans_type);
    SELF.non_driver_print_date_Invalid := Fields.InValid_non_driver_print_date((SALT38.StrType)le.non_driver_print_date);
    SELF.action_surrender_date_Invalid := Fields.InValid_action_surrender_date((SALT38.StrType)le.action_surrender_date);
    SELF.action_counts_Invalid := Fields.InValid_action_counts((SALT38.StrType)le.action_counts);
    SELF.driv_priv_counts_Invalid := Fields.InValid_driv_priv_counts((SALT38.StrType)le.driv_priv_counts);
    SELF.conv_counts_Invalid := Fields.InValid_conv_counts((SALT38.StrType)le.conv_counts);
    SELF.accidents_counts_Invalid := Fields.InValid_accidents_counts((SALT38.StrType)le.accidents_counts);
    SELF.aka_counts_Invalid := Fields.InValid_aka_counts((SALT38.StrType)le.aka_counts);
    SELF.title_Invalid := Fields.InValid_title((SALT38.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.lname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname);
    SELF.predir_Invalid := Fields.InValid_predir((SALT38.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT38.StrType)le.postdir);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT38.StrType)le.st);
    SELF.cln_zip5_Invalid := Fields.InValid_cln_zip5((SALT38.StrType)le.cln_zip5);
    SELF.cln_zip4_Invalid := Fields.InValid_cln_zip4((SALT38.StrType)le.cln_zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT38.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT38.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT38.StrType)le.lot_order);
    SELF.dpbc_Invalid := Fields.InValid_dpbc((SALT38.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit);
    SELF.ace_fips_st_Invalid := Fields.InValid_ace_fips_st((SALT38.StrType)le.ace_fips_st);
    SELF.county_Invalid := Fields.InValid_county((SALT38.StrType)le.county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT38.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT38.StrType)le.msa);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT38.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT38.StrType)le.err_stat);
    SELF.previous_dl_number_Invalid := Fields.InValid_previous_dl_number((SALT38.StrType)le.previous_dl_number);
    SELF.previous_st_Invalid := Fields.InValid_previous_st((SALT38.StrType)le.previous_st);
    SELF.old_dl_number_Invalid := Fields.InValid_old_dl_number((SALT38.StrType)le.old_dl_number);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_MO_MEDCERT);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.unique_key_Invalid << 1 ) + ( le.license_number_Invalid << 2 ) + ( le.last_name_Invalid << 3 ) + ( le.first_name_Invalid << 4 ) + ( le.middle_name_Invalid << 5 ) + ( le.date_of_birth_Invalid << 6 ) + ( le.gender_Invalid << 7 ) + ( le.address_Invalid << 8 ) + ( le.city_Invalid << 9 ) + ( le.state_Invalid << 10 ) + ( le.zip5_Invalid << 11 ) + ( le.zip4_Invalid << 12 ) + ( le.mailing_address1_Invalid << 13 ) + ( le.mailing_city_Invalid << 14 ) + ( le.mailing_state_Invalid << 15 ) + ( le.mailing_zip_Invalid << 16 ) + ( le.height_Invalid << 17 ) + ( le.eye_color_Invalid << 18 ) + ( le.operator_status_Invalid << 19 ) + ( le.commercial_status_Invalid << 20 ) + ( le.sch_bus_status_Invalid << 21 ) + ( le.pending_act_code_Invalid << 22 ) + ( le.must_test_ind_Invalid << 23 ) + ( le.deceased_ind_Invalid << 24 ) + ( le.prev_cdl_class_Invalid << 25 ) + ( le.cdl_ptr_Invalid << 26 ) + ( le.pdps_ptr_Invalid << 27 ) + ( le.mvr_privacy_code_Invalid << 28 ) + ( le.brc_status_date_Invalid << 29 ) + ( le.lic_iss_code_Invalid << 30 ) + ( le.license_class_Invalid << 31 ) + ( le.lic_exp_date_Invalid << 32 ) + ( le.lic_seq_number_Invalid << 33 ) + ( le.lic_surrender_to_Invalid << 34 ) + ( le.license_endorsements_Invalid << 35 ) + ( le.license_restrictions_Invalid << 36 ) + ( le.license_trans_type_Invalid << 37 ) + ( le.lic_print_date_Invalid << 38 ) + ( le.permit_iss_code_Invalid << 39 ) + ( le.permit_class_Invalid << 40 ) + ( le.permit_exp_date_Invalid << 41 ) + ( le.permit_seq_number_Invalid << 42 ) + ( le.permit_endorse_codes_Invalid << 43 ) + ( le.permit_restric_codes_Invalid << 44 ) + ( le.permit_trans_type_Invalid << 45 ) + ( le.permit_print_date_Invalid << 46 ) + ( le.non_driver_code_Invalid << 47 ) + ( le.non_driver_exp_date_Invalid << 48 ) + ( le.non_driver_seq_num_Invalid << 49 ) + ( le.non_driver_trans_type_Invalid << 50 ) + ( le.non_driver_print_date_Invalid << 51 ) + ( le.action_surrender_date_Invalid << 52 ) + ( le.action_counts_Invalid << 53 ) + ( le.driv_priv_counts_Invalid << 54 ) + ( le.conv_counts_Invalid << 55 ) + ( le.accidents_counts_Invalid << 56 ) + ( le.aka_counts_Invalid << 57 ) + ( le.title_Invalid << 58 ) + ( le.fname_Invalid << 59 ) + ( le.mname_Invalid << 60 ) + ( le.lname_Invalid << 61 ) + ( le.predir_Invalid << 62 ) + ( le.prim_name_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.postdir_Invalid << 0 ) + ( le.p_city_name_Invalid << 1 ) + ( le.v_city_name_Invalid << 2 ) + ( le.st_Invalid << 3 ) + ( le.cln_zip5_Invalid << 4 ) + ( le.cln_zip4_Invalid << 5 ) + ( le.cart_Invalid << 6 ) + ( le.cr_sort_sz_Invalid << 7 ) + ( le.lot_Invalid << 8 ) + ( le.lot_order_Invalid << 9 ) + ( le.dpbc_Invalid << 10 ) + ( le.chk_digit_Invalid << 11 ) + ( le.ace_fips_st_Invalid << 12 ) + ( le.county_Invalid << 13 ) + ( le.geo_lat_Invalid << 14 ) + ( le.geo_long_Invalid << 15 ) + ( le.msa_Invalid << 16 ) + ( le.geo_match_Invalid << 17 ) + ( le.err_stat_Invalid << 18 ) + ( le.previous_dl_number_Invalid << 19 ) + ( le.previous_st_Invalid << 20 ) + ( le.old_dl_number_Invalid << 21 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_MO_MEDCERT);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.unique_key_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.mailing_address1_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.mailing_city_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mailing_state_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mailing_zip_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.height_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.eye_color_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.operator_status_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.commercial_status_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.sch_bus_status_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.pending_act_code_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.must_test_ind_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.deceased_ind_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.prev_cdl_class_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.cdl_ptr_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.pdps_ptr_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.mvr_privacy_code_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.brc_status_date_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.lic_iss_code_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.license_class_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.lic_exp_date_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.lic_seq_number_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.lic_surrender_to_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.license_endorsements_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.license_restrictions_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.license_trans_type_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.lic_print_date_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.permit_iss_code_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.permit_class_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.permit_exp_date_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.permit_seq_number_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.permit_endorse_codes_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.permit_restric_codes_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.permit_trans_type_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.permit_print_date_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.non_driver_code_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.non_driver_exp_date_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.non_driver_seq_num_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.non_driver_trans_type_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.non_driver_print_date_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.action_surrender_date_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.action_counts_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.driv_priv_counts_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.conv_counts_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.accidents_counts_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.aka_counts_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.st_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.cln_zip5_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.cln_zip4_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.county_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.previous_dl_number_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.previous_st_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.old_dl_number_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    unique_key_CUSTOM_ErrorCount := COUNT(GROUP,h.unique_key_Invalid=1);
    license_number_CUSTOM_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    middle_name_CUSTOM_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    date_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    address_CUSTOM_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip5_CUSTOM_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    mailing_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_address1_Invalid=1);
    mailing_city_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_city_Invalid=1);
    mailing_state_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_state_Invalid=1);
    mailing_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_zip_Invalid=1);
    height_ALLOW_ErrorCount := COUNT(GROUP,h.height_Invalid=1);
    eye_color_ALLOW_ErrorCount := COUNT(GROUP,h.eye_color_Invalid=1);
    operator_status_ALLOW_ErrorCount := COUNT(GROUP,h.operator_status_Invalid=1);
    commercial_status_ALLOW_ErrorCount := COUNT(GROUP,h.commercial_status_Invalid=1);
    sch_bus_status_ALLOW_ErrorCount := COUNT(GROUP,h.sch_bus_status_Invalid=1);
    pending_act_code_ALLOW_ErrorCount := COUNT(GROUP,h.pending_act_code_Invalid=1);
    must_test_ind_ALLOW_ErrorCount := COUNT(GROUP,h.must_test_ind_Invalid=1);
    deceased_ind_ALLOW_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=1);
    prev_cdl_class_ALLOW_ErrorCount := COUNT(GROUP,h.prev_cdl_class_Invalid=1);
    cdl_ptr_ALLOW_ErrorCount := COUNT(GROUP,h.cdl_ptr_Invalid=1);
    pdps_ptr_ALLOW_ErrorCount := COUNT(GROUP,h.pdps_ptr_Invalid=1);
    mvr_privacy_code_ALLOW_ErrorCount := COUNT(GROUP,h.mvr_privacy_code_Invalid=1);
    brc_status_date_CUSTOM_ErrorCount := COUNT(GROUP,h.brc_status_date_Invalid=1);
    lic_iss_code_ALLOW_ErrorCount := COUNT(GROUP,h.lic_iss_code_Invalid=1);
    license_class_ALLOW_ErrorCount := COUNT(GROUP,h.license_class_Invalid=1);
    lic_exp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.lic_exp_date_Invalid=1);
    lic_seq_number_ALLOW_ErrorCount := COUNT(GROUP,h.lic_seq_number_Invalid=1);
    lic_surrender_to_CUSTOM_ErrorCount := COUNT(GROUP,h.lic_surrender_to_Invalid=1);
    license_endorsements_ALLOW_ErrorCount := COUNT(GROUP,h.license_endorsements_Invalid=1);
    license_restrictions_ALLOW_ErrorCount := COUNT(GROUP,h.license_restrictions_Invalid=1);
    license_trans_type_CUSTOM_ErrorCount := COUNT(GROUP,h.license_trans_type_Invalid=1);
    lic_print_date_CUSTOM_ErrorCount := COUNT(GROUP,h.lic_print_date_Invalid=1);
    permit_iss_code_ALLOW_ErrorCount := COUNT(GROUP,h.permit_iss_code_Invalid=1);
    permit_class_ALLOW_ErrorCount := COUNT(GROUP,h.permit_class_Invalid=1);
    permit_exp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.permit_exp_date_Invalid=1);
    permit_seq_number_ALLOW_ErrorCount := COUNT(GROUP,h.permit_seq_number_Invalid=1);
    permit_endorse_codes_ALLOW_ErrorCount := COUNT(GROUP,h.permit_endorse_codes_Invalid=1);
    permit_restric_codes_ALLOW_ErrorCount := COUNT(GROUP,h.permit_restric_codes_Invalid=1);
    permit_trans_type_ALLOW_ErrorCount := COUNT(GROUP,h.permit_trans_type_Invalid=1);
    permit_print_date_CUSTOM_ErrorCount := COUNT(GROUP,h.permit_print_date_Invalid=1);
    non_driver_code_ALLOW_ErrorCount := COUNT(GROUP,h.non_driver_code_Invalid=1);
    non_driver_exp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.non_driver_exp_date_Invalid=1);
    non_driver_seq_num_ALLOW_ErrorCount := COUNT(GROUP,h.non_driver_seq_num_Invalid=1);
    non_driver_trans_type_ALLOW_ErrorCount := COUNT(GROUP,h.non_driver_trans_type_Invalid=1);
    non_driver_print_date_CUSTOM_ErrorCount := COUNT(GROUP,h.non_driver_print_date_Invalid=1);
    action_surrender_date_CUSTOM_ErrorCount := COUNT(GROUP,h.action_surrender_date_Invalid=1);
    action_counts_CUSTOM_ErrorCount := COUNT(GROUP,h.action_counts_Invalid=1);
    driv_priv_counts_ALLOW_ErrorCount := COUNT(GROUP,h.driv_priv_counts_Invalid=1);
    conv_counts_CUSTOM_ErrorCount := COUNT(GROUP,h.conv_counts_Invalid=1);
    accidents_counts_ALLOW_ErrorCount := COUNT(GROUP,h.accidents_counts_Invalid=1);
    aka_counts_ALLOW_ErrorCount := COUNT(GROUP,h.aka_counts_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_CUSTOM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    cln_zip5_CUSTOM_ErrorCount := COUNT(GROUP,h.cln_zip5_Invalid=1);
    cln_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.cln_zip4_Invalid=1);
    cart_CUSTOM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_CUSTOM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dpbc_CUSTOM_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    ace_fips_st_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    county_CUSTOM_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    previous_dl_number_ALLOW_ErrorCount := COUNT(GROUP,h.previous_dl_number_Invalid=1);
    previous_st_CUSTOM_ErrorCount := COUNT(GROUP,h.previous_st_Invalid=1);
    old_dl_number_CUSTOM_ErrorCount := COUNT(GROUP,h.old_dl_number_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.unique_key_Invalid > 0 OR h.license_number_Invalid > 0 OR h.last_name_Invalid > 0 OR h.first_name_Invalid > 0 OR h.middle_name_Invalid > 0 OR h.date_of_birth_Invalid > 0 OR h.gender_Invalid > 0 OR h.address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip5_Invalid > 0 OR h.zip4_Invalid > 0 OR h.mailing_address1_Invalid > 0 OR h.mailing_city_Invalid > 0 OR h.mailing_state_Invalid > 0 OR h.mailing_zip_Invalid > 0 OR h.height_Invalid > 0 OR h.eye_color_Invalid > 0 OR h.operator_status_Invalid > 0 OR h.commercial_status_Invalid > 0 OR h.sch_bus_status_Invalid > 0 OR h.pending_act_code_Invalid > 0 OR h.must_test_ind_Invalid > 0 OR h.deceased_ind_Invalid > 0 OR h.prev_cdl_class_Invalid > 0 OR h.cdl_ptr_Invalid > 0 OR h.pdps_ptr_Invalid > 0 OR h.mvr_privacy_code_Invalid > 0 OR h.brc_status_date_Invalid > 0 OR h.lic_iss_code_Invalid > 0 OR h.license_class_Invalid > 0 OR h.lic_exp_date_Invalid > 0 OR h.lic_seq_number_Invalid > 0 OR h.lic_surrender_to_Invalid > 0 OR h.license_endorsements_Invalid > 0 OR h.license_restrictions_Invalid > 0 OR h.license_trans_type_Invalid > 0 OR h.lic_print_date_Invalid > 0 OR h.permit_iss_code_Invalid > 0 OR h.permit_class_Invalid > 0 OR h.permit_exp_date_Invalid > 0 OR h.permit_seq_number_Invalid > 0 OR h.permit_endorse_codes_Invalid > 0 OR h.permit_restric_codes_Invalid > 0 OR h.permit_trans_type_Invalid > 0 OR h.permit_print_date_Invalid > 0 OR h.non_driver_code_Invalid > 0 OR h.non_driver_exp_date_Invalid > 0 OR h.non_driver_seq_num_Invalid > 0 OR h.non_driver_trans_type_Invalid > 0 OR h.non_driver_print_date_Invalid > 0 OR h.action_surrender_date_Invalid > 0 OR h.action_counts_Invalid > 0 OR h.driv_priv_counts_Invalid > 0 OR h.conv_counts_Invalid > 0 OR h.accidents_counts_Invalid > 0 OR h.aka_counts_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.postdir_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.cln_zip5_Invalid > 0 OR h.cln_zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.previous_dl_number_Invalid > 0 OR h.previous_st_Invalid > 0 OR h.old_dl_number_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unique_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.middle_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.height_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eye_color_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operator_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commercial_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sch_bus_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pending_act_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.must_test_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prev_cdl_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cdl_ptr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pdps_ptr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mvr_privacy_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brc_status_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lic_iss_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lic_exp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lic_seq_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lic_surrender_to_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_endorsements_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_restrictions_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_trans_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lic_print_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.permit_iss_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_exp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.permit_seq_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_endorse_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_restric_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_trans_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_print_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_driver_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.non_driver_exp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_driver_seq_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.non_driver_trans_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.non_driver_print_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_surrender_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_counts_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.driv_priv_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.conv_counts_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.accidents_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aka_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.previous_dl_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.previous_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.old_dl_number_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unique_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.middle_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.height_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eye_color_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operator_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commercial_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sch_bus_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pending_act_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.must_test_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prev_cdl_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cdl_ptr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pdps_ptr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mvr_privacy_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brc_status_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lic_iss_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lic_exp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lic_seq_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lic_surrender_to_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_endorsements_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_restrictions_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_trans_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lic_print_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.permit_iss_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_exp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.permit_seq_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_endorse_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_restric_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_trans_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.permit_print_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_driver_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.non_driver_exp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_driver_seq_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.non_driver_trans_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.non_driver_print_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_surrender_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_counts_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.driv_priv_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.conv_counts_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.accidents_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aka_counts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dpbc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.previous_dl_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.previous_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.old_dl_number_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.unique_key_Invalid,le.license_number_Invalid,le.last_name_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.date_of_birth_Invalid,le.gender_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.mailing_address1_Invalid,le.mailing_city_Invalid,le.mailing_state_Invalid,le.mailing_zip_Invalid,le.height_Invalid,le.eye_color_Invalid,le.operator_status_Invalid,le.commercial_status_Invalid,le.sch_bus_status_Invalid,le.pending_act_code_Invalid,le.must_test_ind_Invalid,le.deceased_ind_Invalid,le.prev_cdl_class_Invalid,le.cdl_ptr_Invalid,le.pdps_ptr_Invalid,le.mvr_privacy_code_Invalid,le.brc_status_date_Invalid,le.lic_iss_code_Invalid,le.license_class_Invalid,le.lic_exp_date_Invalid,le.lic_seq_number_Invalid,le.lic_surrender_to_Invalid,le.license_endorsements_Invalid,le.license_restrictions_Invalid,le.license_trans_type_Invalid,le.lic_print_date_Invalid,le.permit_iss_code_Invalid,le.permit_class_Invalid,le.permit_exp_date_Invalid,le.permit_seq_number_Invalid,le.permit_endorse_codes_Invalid,le.permit_restric_codes_Invalid,le.permit_trans_type_Invalid,le.permit_print_date_Invalid,le.non_driver_code_Invalid,le.non_driver_exp_date_Invalid,le.non_driver_seq_num_Invalid,le.non_driver_trans_type_Invalid,le.non_driver_print_date_Invalid,le.action_surrender_date_Invalid,le.action_counts_Invalid,le.driv_priv_counts_Invalid,le.conv_counts_Invalid,le.accidents_counts_Invalid,le.aka_counts_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.cln_zip5_Invalid,le.cln_zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.previous_dl_number_Invalid,le.previous_st_Invalid,le.old_dl_number_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_unique_key(le.unique_key_Invalid),Fields.InvalidMessage_license_number(le.license_number_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_address(le.address_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_mailing_address1(le.mailing_address1_Invalid),Fields.InvalidMessage_mailing_city(le.mailing_city_Invalid),Fields.InvalidMessage_mailing_state(le.mailing_state_Invalid),Fields.InvalidMessage_mailing_zip(le.mailing_zip_Invalid),Fields.InvalidMessage_height(le.height_Invalid),Fields.InvalidMessage_eye_color(le.eye_color_Invalid),Fields.InvalidMessage_operator_status(le.operator_status_Invalid),Fields.InvalidMessage_commercial_status(le.commercial_status_Invalid),Fields.InvalidMessage_sch_bus_status(le.sch_bus_status_Invalid),Fields.InvalidMessage_pending_act_code(le.pending_act_code_Invalid),Fields.InvalidMessage_must_test_ind(le.must_test_ind_Invalid),Fields.InvalidMessage_deceased_ind(le.deceased_ind_Invalid),Fields.InvalidMessage_prev_cdl_class(le.prev_cdl_class_Invalid),Fields.InvalidMessage_cdl_ptr(le.cdl_ptr_Invalid),Fields.InvalidMessage_pdps_ptr(le.pdps_ptr_Invalid),Fields.InvalidMessage_mvr_privacy_code(le.mvr_privacy_code_Invalid),Fields.InvalidMessage_brc_status_date(le.brc_status_date_Invalid),Fields.InvalidMessage_lic_iss_code(le.lic_iss_code_Invalid),Fields.InvalidMessage_license_class(le.license_class_Invalid),Fields.InvalidMessage_lic_exp_date(le.lic_exp_date_Invalid),Fields.InvalidMessage_lic_seq_number(le.lic_seq_number_Invalid),Fields.InvalidMessage_lic_surrender_to(le.lic_surrender_to_Invalid),Fields.InvalidMessage_license_endorsements(le.license_endorsements_Invalid),Fields.InvalidMessage_license_restrictions(le.license_restrictions_Invalid),Fields.InvalidMessage_license_trans_type(le.license_trans_type_Invalid),Fields.InvalidMessage_lic_print_date(le.lic_print_date_Invalid),Fields.InvalidMessage_permit_iss_code(le.permit_iss_code_Invalid),Fields.InvalidMessage_permit_class(le.permit_class_Invalid),Fields.InvalidMessage_permit_exp_date(le.permit_exp_date_Invalid),Fields.InvalidMessage_permit_seq_number(le.permit_seq_number_Invalid),Fields.InvalidMessage_permit_endorse_codes(le.permit_endorse_codes_Invalid),Fields.InvalidMessage_permit_restric_codes(le.permit_restric_codes_Invalid),Fields.InvalidMessage_permit_trans_type(le.permit_trans_type_Invalid),Fields.InvalidMessage_permit_print_date(le.permit_print_date_Invalid),Fields.InvalidMessage_non_driver_code(le.non_driver_code_Invalid),Fields.InvalidMessage_non_driver_exp_date(le.non_driver_exp_date_Invalid),Fields.InvalidMessage_non_driver_seq_num(le.non_driver_seq_num_Invalid),Fields.InvalidMessage_non_driver_trans_type(le.non_driver_trans_type_Invalid),Fields.InvalidMessage_non_driver_print_date(le.non_driver_print_date_Invalid),Fields.InvalidMessage_action_surrender_date(le.action_surrender_date_Invalid),Fields.InvalidMessage_action_counts(le.action_counts_Invalid),Fields.InvalidMessage_driv_priv_counts(le.driv_priv_counts_Invalid),Fields.InvalidMessage_conv_counts(le.conv_counts_Invalid),Fields.InvalidMessage_accidents_counts(le.accidents_counts_Invalid),Fields.InvalidMessage_aka_counts(le.aka_counts_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_cln_zip5(le.cln_zip5_Invalid),Fields.InvalidMessage_cln_zip4(le.cln_zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_previous_dl_number(le.previous_dl_number_Invalid),Fields.InvalidMessage_previous_st(le.previous_st_Invalid),Fields.InvalidMessage_old_dl_number(le.old_dl_number_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unique_key_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.height_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eye_color_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.operator_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.commercial_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sch_bus_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pending_act_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.must_test_ind_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deceased_ind_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_cdl_class_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cdl_ptr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pdps_ptr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mvr_privacy_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.brc_status_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lic_iss_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_class_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lic_exp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lic_seq_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lic_surrender_to_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_endorsements_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_restrictions_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_trans_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lic_print_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.permit_iss_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.permit_class_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.permit_exp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.permit_seq_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.permit_endorse_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.permit_restric_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.permit_trans_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.permit_print_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.non_driver_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.non_driver_exp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.non_driver_seq_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.non_driver_trans_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.non_driver_print_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_surrender_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_counts_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.driv_priv_counts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.conv_counts_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.accidents_counts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aka_counts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_zip5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.previous_dl_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.previous_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.old_dl_number_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','unique_key','license_number','last_name','first_name','middle_name','date_of_birth','gender','address','city','state','zip5','zip4','mailing_address1','mailing_city','mailing_state','mailing_zip','height','eye_color','operator_status','commercial_status','sch_bus_status','pending_act_code','must_test_ind','deceased_ind','prev_cdl_class','cdl_ptr','pdps_ptr','mvr_privacy_code','brc_status_date','lic_iss_code','license_class','lic_exp_date','lic_seq_number','lic_surrender_to','license_endorsements','license_restrictions','license_trans_type','lic_print_date','permit_iss_code','permit_class','permit_exp_date','permit_seq_number','permit_endorse_codes','permit_restric_codes','permit_trans_type','permit_print_date','non_driver_code','non_driver_exp_date','non_driver_seq_num','non_driver_trans_type','non_driver_print_date','action_surrender_date','action_counts','driv_priv_counts','conv_counts','accidents_counts','aka_counts','title','fname','mname','lname','predir','prim_name','postdir','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','ace_fips_st','county','geo_lat','geo_long','msa','geo_match','err_stat','previous_dl_number','previous_st','old_dl_number','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_Past_Date','invalid_Alpha_Numeric','invalid_Alpha_Numeric','invalid_last_name','invalid_first_name','invalid_mid_name','invalid_Past_Date','invalid_gender','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_mandatory','invalid_mandatory','invalid_state','invalid_mailing_zip','invalid_Num','invalid_eye_color','invalid_operator_status','invalid_commercial_status','invalid_sch_bus_status','invalid_pending_act_code','invalid_must_test_ind','invalid_deceased_ind','invalid_prev_cdl_class','invalid_cdl_ptr','invalid_pdps_ptr','invalid_mvr_privacy_code','invalid_Past_Date','invalid_lic_iss_code','invalid_license_class','invalid_general_Date','invalid_Num','invalid_state','invalid_license_endorsements','invalid_license_restrictions','invalid_license_trans_type','invalid_general_Date','invalid_permit_iss_code','invalid_permit_class','invalid_general_Date','invalid_Num','invalid_permit_endorse_codes','invalid_permit_restric_codes','invalid_permit_trans_type','invalid_Past_Date','invalid_non_driver_code','invalid_general_Date','invalid_Num','invalid_non_driver_trans_type','invalid_general_Date','invalid_Past_Date','invalid_action_counts','invalid_driv_priv_counts','invalid_conv_counts','invalid_accidents_counts','invalid_aka_counts','invalid_title','invalid_fname','invalid_mname','invalid_lname','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_match','invalid_err_stat','invalid_Hyphen_Alpha_Numeric','invalid_state','invalid_Alpha_Numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.process_date,(SALT38.StrType)le.unique_key,(SALT38.StrType)le.license_number,(SALT38.StrType)le.last_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.middle_name,(SALT38.StrType)le.date_of_birth,(SALT38.StrType)le.gender,(SALT38.StrType)le.address,(SALT38.StrType)le.city,(SALT38.StrType)le.state,(SALT38.StrType)le.zip5,(SALT38.StrType)le.zip4,(SALT38.StrType)le.mailing_address1,(SALT38.StrType)le.mailing_city,(SALT38.StrType)le.mailing_state,(SALT38.StrType)le.mailing_zip,(SALT38.StrType)le.height,(SALT38.StrType)le.eye_color,(SALT38.StrType)le.operator_status,(SALT38.StrType)le.commercial_status,(SALT38.StrType)le.sch_bus_status,(SALT38.StrType)le.pending_act_code,(SALT38.StrType)le.must_test_ind,(SALT38.StrType)le.deceased_ind,(SALT38.StrType)le.prev_cdl_class,(SALT38.StrType)le.cdl_ptr,(SALT38.StrType)le.pdps_ptr,(SALT38.StrType)le.mvr_privacy_code,(SALT38.StrType)le.brc_status_date,(SALT38.StrType)le.lic_iss_code,(SALT38.StrType)le.license_class,(SALT38.StrType)le.lic_exp_date,(SALT38.StrType)le.lic_seq_number,(SALT38.StrType)le.lic_surrender_to,(SALT38.StrType)le.license_endorsements,(SALT38.StrType)le.license_restrictions,(SALT38.StrType)le.license_trans_type,(SALT38.StrType)le.lic_print_date,(SALT38.StrType)le.permit_iss_code,(SALT38.StrType)le.permit_class,(SALT38.StrType)le.permit_exp_date,(SALT38.StrType)le.permit_seq_number,(SALT38.StrType)le.permit_endorse_codes,(SALT38.StrType)le.permit_restric_codes,(SALT38.StrType)le.permit_trans_type,(SALT38.StrType)le.permit_print_date,(SALT38.StrType)le.non_driver_code,(SALT38.StrType)le.non_driver_exp_date,(SALT38.StrType)le.non_driver_seq_num,(SALT38.StrType)le.non_driver_trans_type,(SALT38.StrType)le.non_driver_print_date,(SALT38.StrType)le.action_surrender_date,(SALT38.StrType)le.action_counts,(SALT38.StrType)le.driv_priv_counts,(SALT38.StrType)le.conv_counts,(SALT38.StrType)le.accidents_counts,(SALT38.StrType)le.aka_counts,(SALT38.StrType)le.title,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname,(SALT38.StrType)le.predir,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.postdir,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.st,(SALT38.StrType)le.cln_zip5,(SALT38.StrType)le.cln_zip4,(SALT38.StrType)le.cart,(SALT38.StrType)le.cr_sort_sz,(SALT38.StrType)le.lot,(SALT38.StrType)le.lot_order,(SALT38.StrType)le.dpbc,(SALT38.StrType)le.chk_digit,(SALT38.StrType)le.ace_fips_st,(SALT38.StrType)le.county,(SALT38.StrType)le.geo_lat,(SALT38.StrType)le.geo_long,(SALT38.StrType)le.msa,(SALT38.StrType)le.geo_match,(SALT38.StrType)le.err_stat,(SALT38.StrType)le.previous_dl_number,(SALT38.StrType)le.previous_st,(SALT38.StrType)le.old_dl_number,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,86,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_MO_MEDCERT) prevDS = DATASET([], Layout_In_MO_MEDCERT), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_Past_Date:CUSTOM'
          ,'unique_key:invalid_Alpha_Numeric:CUSTOM'
          ,'license_number:invalid_Alpha_Numeric:CUSTOM'
          ,'last_name:invalid_last_name:CUSTOM'
          ,'first_name:invalid_first_name:CUSTOM'
          ,'middle_name:invalid_mid_name:CUSTOM'
          ,'date_of_birth:invalid_Past_Date:CUSTOM'
          ,'gender:invalid_gender:ALLOW'
          ,'address:invalid_mandatory:CUSTOM'
          ,'city:invalid_mandatory:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'zip5:invalid_zip:CUSTOM'
          ,'zip4:invalid_zip4:CUSTOM'
          ,'mailing_address1:invalid_mandatory:CUSTOM'
          ,'mailing_city:invalid_mandatory:CUSTOM'
          ,'mailing_state:invalid_state:CUSTOM'
          ,'mailing_zip:invalid_mailing_zip:CUSTOM'
          ,'height:invalid_Num:ALLOW'
          ,'eye_color:invalid_eye_color:ALLOW'
          ,'operator_status:invalid_operator_status:ALLOW'
          ,'commercial_status:invalid_commercial_status:ALLOW'
          ,'sch_bus_status:invalid_sch_bus_status:ALLOW'
          ,'pending_act_code:invalid_pending_act_code:ALLOW'
          ,'must_test_ind:invalid_must_test_ind:ALLOW'
          ,'deceased_ind:invalid_deceased_ind:ALLOW'
          ,'prev_cdl_class:invalid_prev_cdl_class:ALLOW'
          ,'cdl_ptr:invalid_cdl_ptr:ALLOW'
          ,'pdps_ptr:invalid_pdps_ptr:ALLOW'
          ,'mvr_privacy_code:invalid_mvr_privacy_code:ALLOW'
          ,'brc_status_date:invalid_Past_Date:CUSTOM'
          ,'lic_iss_code:invalid_lic_iss_code:ALLOW'
          ,'license_class:invalid_license_class:ALLOW'
          ,'lic_exp_date:invalid_general_Date:CUSTOM'
          ,'lic_seq_number:invalid_Num:ALLOW'
          ,'lic_surrender_to:invalid_state:CUSTOM'
          ,'license_endorsements:invalid_license_endorsements:ALLOW'
          ,'license_restrictions:invalid_license_restrictions:ALLOW'
          ,'license_trans_type:invalid_license_trans_type:CUSTOM'
          ,'lic_print_date:invalid_general_Date:CUSTOM'
          ,'permit_iss_code:invalid_permit_iss_code:ALLOW'
          ,'permit_class:invalid_permit_class:ALLOW'
          ,'permit_exp_date:invalid_general_Date:CUSTOM'
          ,'permit_seq_number:invalid_Num:ALLOW'
          ,'permit_endorse_codes:invalid_permit_endorse_codes:ALLOW'
          ,'permit_restric_codes:invalid_permit_restric_codes:ALLOW'
          ,'permit_trans_type:invalid_permit_trans_type:ALLOW'
          ,'permit_print_date:invalid_Past_Date:CUSTOM'
          ,'non_driver_code:invalid_non_driver_code:ALLOW'
          ,'non_driver_exp_date:invalid_general_Date:CUSTOM'
          ,'non_driver_seq_num:invalid_Num:ALLOW'
          ,'non_driver_trans_type:invalid_non_driver_trans_type:ALLOW'
          ,'non_driver_print_date:invalid_general_Date:CUSTOM'
          ,'action_surrender_date:invalid_Past_Date:CUSTOM'
          ,'action_counts:invalid_action_counts:CUSTOM'
          ,'driv_priv_counts:invalid_driv_priv_counts:ALLOW'
          ,'conv_counts:invalid_conv_counts:CUSTOM'
          ,'accidents_counts:invalid_accidents_counts:ALLOW'
          ,'aka_counts:invalid_aka_counts:ALLOW'
          ,'title:invalid_title:ALLOW'
          ,'fname:invalid_fname:CUSTOM'
          ,'mname:invalid_mname:CUSTOM'
          ,'lname:invalid_lname:CUSTOM'
          ,'predir:invalid_direction:ALLOW'
          ,'prim_name:invalid_mandatory:CUSTOM'
          ,'postdir:invalid_direction:ALLOW'
          ,'p_city_name:invalid_mandatory:CUSTOM'
          ,'v_city_name:invalid_mandatory:CUSTOM'
          ,'st:invalid_state:CUSTOM'
          ,'cln_zip5:invalid_zip:CUSTOM'
          ,'cln_zip4:invalid_zip4:CUSTOM'
          ,'cart:invalid_cart:CUSTOM'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot:invalid_lot:CUSTOM'
          ,'lot_order:invalid_lot_order:ENUM'
          ,'dpbc:invalid_dpbc:CUSTOM'
          ,'chk_digit:invalid_chk_digit:CUSTOM'
          ,'ace_fips_st:invalid_fips_state:CUSTOM'
          ,'county:invalid_fips_county:CUSTOM'
          ,'geo_lat:invalid_geo:CUSTOM'
          ,'geo_long:invalid_geo:CUSTOM'
          ,'msa:invalid_msa:CUSTOM'
          ,'geo_match:invalid_geo_match:CUSTOM'
          ,'err_stat:invalid_err_stat:CUSTOM'
          ,'previous_dl_number:invalid_Hyphen_Alpha_Numeric:ALLOW'
          ,'previous_st:invalid_state:CUSTOM'
          ,'old_dl_number:invalid_Alpha_Numeric:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1)
          ,Fields.InvalidMessage_unique_key(1)
          ,Fields.InvalidMessage_license_number(1)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_middle_name(1)
          ,Fields.InvalidMessage_date_of_birth(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_address(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_zip5(1)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_mailing_address1(1)
          ,Fields.InvalidMessage_mailing_city(1)
          ,Fields.InvalidMessage_mailing_state(1)
          ,Fields.InvalidMessage_mailing_zip(1)
          ,Fields.InvalidMessage_height(1)
          ,Fields.InvalidMessage_eye_color(1)
          ,Fields.InvalidMessage_operator_status(1)
          ,Fields.InvalidMessage_commercial_status(1)
          ,Fields.InvalidMessage_sch_bus_status(1)
          ,Fields.InvalidMessage_pending_act_code(1)
          ,Fields.InvalidMessage_must_test_ind(1)
          ,Fields.InvalidMessage_deceased_ind(1)
          ,Fields.InvalidMessage_prev_cdl_class(1)
          ,Fields.InvalidMessage_cdl_ptr(1)
          ,Fields.InvalidMessage_pdps_ptr(1)
          ,Fields.InvalidMessage_mvr_privacy_code(1)
          ,Fields.InvalidMessage_brc_status_date(1)
          ,Fields.InvalidMessage_lic_iss_code(1)
          ,Fields.InvalidMessage_license_class(1)
          ,Fields.InvalidMessage_lic_exp_date(1)
          ,Fields.InvalidMessage_lic_seq_number(1)
          ,Fields.InvalidMessage_lic_surrender_to(1)
          ,Fields.InvalidMessage_license_endorsements(1)
          ,Fields.InvalidMessage_license_restrictions(1)
          ,Fields.InvalidMessage_license_trans_type(1)
          ,Fields.InvalidMessage_lic_print_date(1)
          ,Fields.InvalidMessage_permit_iss_code(1)
          ,Fields.InvalidMessage_permit_class(1)
          ,Fields.InvalidMessage_permit_exp_date(1)
          ,Fields.InvalidMessage_permit_seq_number(1)
          ,Fields.InvalidMessage_permit_endorse_codes(1)
          ,Fields.InvalidMessage_permit_restric_codes(1)
          ,Fields.InvalidMessage_permit_trans_type(1)
          ,Fields.InvalidMessage_permit_print_date(1)
          ,Fields.InvalidMessage_non_driver_code(1)
          ,Fields.InvalidMessage_non_driver_exp_date(1)
          ,Fields.InvalidMessage_non_driver_seq_num(1)
          ,Fields.InvalidMessage_non_driver_trans_type(1)
          ,Fields.InvalidMessage_non_driver_print_date(1)
          ,Fields.InvalidMessage_action_surrender_date(1)
          ,Fields.InvalidMessage_action_counts(1)
          ,Fields.InvalidMessage_driv_priv_counts(1)
          ,Fields.InvalidMessage_conv_counts(1)
          ,Fields.InvalidMessage_accidents_counts(1)
          ,Fields.InvalidMessage_aka_counts(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_st(1)
          ,Fields.InvalidMessage_cln_zip5(1)
          ,Fields.InvalidMessage_cln_zip4(1)
          ,Fields.InvalidMessage_cart(1)
          ,Fields.InvalidMessage_cr_sort_sz(1)
          ,Fields.InvalidMessage_lot(1)
          ,Fields.InvalidMessage_lot_order(1)
          ,Fields.InvalidMessage_dpbc(1)
          ,Fields.InvalidMessage_chk_digit(1)
          ,Fields.InvalidMessage_ace_fips_st(1)
          ,Fields.InvalidMessage_county(1)
          ,Fields.InvalidMessage_geo_lat(1)
          ,Fields.InvalidMessage_geo_long(1)
          ,Fields.InvalidMessage_msa(1)
          ,Fields.InvalidMessage_geo_match(1)
          ,Fields.InvalidMessage_err_stat(1)
          ,Fields.InvalidMessage_previous_dl_number(1)
          ,Fields.InvalidMessage_previous_st(1)
          ,Fields.InvalidMessage_old_dl_number(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.unique_key_CUSTOM_ErrorCount
          ,le.license_number_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.middle_name_CUSTOM_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip5_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.mailing_address1_CUSTOM_ErrorCount
          ,le.mailing_city_CUSTOM_ErrorCount
          ,le.mailing_state_CUSTOM_ErrorCount
          ,le.mailing_zip_CUSTOM_ErrorCount
          ,le.height_ALLOW_ErrorCount
          ,le.eye_color_ALLOW_ErrorCount
          ,le.operator_status_ALLOW_ErrorCount
          ,le.commercial_status_ALLOW_ErrorCount
          ,le.sch_bus_status_ALLOW_ErrorCount
          ,le.pending_act_code_ALLOW_ErrorCount
          ,le.must_test_ind_ALLOW_ErrorCount
          ,le.deceased_ind_ALLOW_ErrorCount
          ,le.prev_cdl_class_ALLOW_ErrorCount
          ,le.cdl_ptr_ALLOW_ErrorCount
          ,le.pdps_ptr_ALLOW_ErrorCount
          ,le.mvr_privacy_code_ALLOW_ErrorCount
          ,le.brc_status_date_CUSTOM_ErrorCount
          ,le.lic_iss_code_ALLOW_ErrorCount
          ,le.license_class_ALLOW_ErrorCount
          ,le.lic_exp_date_CUSTOM_ErrorCount
          ,le.lic_seq_number_ALLOW_ErrorCount
          ,le.lic_surrender_to_CUSTOM_ErrorCount
          ,le.license_endorsements_ALLOW_ErrorCount
          ,le.license_restrictions_ALLOW_ErrorCount
          ,le.license_trans_type_CUSTOM_ErrorCount
          ,le.lic_print_date_CUSTOM_ErrorCount
          ,le.permit_iss_code_ALLOW_ErrorCount
          ,le.permit_class_ALLOW_ErrorCount
          ,le.permit_exp_date_CUSTOM_ErrorCount
          ,le.permit_seq_number_ALLOW_ErrorCount
          ,le.permit_endorse_codes_ALLOW_ErrorCount
          ,le.permit_restric_codes_ALLOW_ErrorCount
          ,le.permit_trans_type_ALLOW_ErrorCount
          ,le.permit_print_date_CUSTOM_ErrorCount
          ,le.non_driver_code_ALLOW_ErrorCount
          ,le.non_driver_exp_date_CUSTOM_ErrorCount
          ,le.non_driver_seq_num_ALLOW_ErrorCount
          ,le.non_driver_trans_type_ALLOW_ErrorCount
          ,le.non_driver_print_date_CUSTOM_ErrorCount
          ,le.action_surrender_date_CUSTOM_ErrorCount
          ,le.action_counts_CUSTOM_ErrorCount
          ,le.driv_priv_counts_ALLOW_ErrorCount
          ,le.conv_counts_CUSTOM_ErrorCount
          ,le.accidents_counts_ALLOW_ErrorCount
          ,le.aka_counts_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.cln_zip5_CUSTOM_ErrorCount
          ,le.cln_zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dpbc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.ace_fips_st_CUSTOM_ErrorCount
          ,le.county_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.previous_dl_number_ALLOW_ErrorCount
          ,le.previous_st_CUSTOM_ErrorCount
          ,le.old_dl_number_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.unique_key_CUSTOM_ErrorCount
          ,le.license_number_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.middle_name_CUSTOM_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip5_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.mailing_address1_CUSTOM_ErrorCount
          ,le.mailing_city_CUSTOM_ErrorCount
          ,le.mailing_state_CUSTOM_ErrorCount
          ,le.mailing_zip_CUSTOM_ErrorCount
          ,le.height_ALLOW_ErrorCount
          ,le.eye_color_ALLOW_ErrorCount
          ,le.operator_status_ALLOW_ErrorCount
          ,le.commercial_status_ALLOW_ErrorCount
          ,le.sch_bus_status_ALLOW_ErrorCount
          ,le.pending_act_code_ALLOW_ErrorCount
          ,le.must_test_ind_ALLOW_ErrorCount
          ,le.deceased_ind_ALLOW_ErrorCount
          ,le.prev_cdl_class_ALLOW_ErrorCount
          ,le.cdl_ptr_ALLOW_ErrorCount
          ,le.pdps_ptr_ALLOW_ErrorCount
          ,le.mvr_privacy_code_ALLOW_ErrorCount
          ,le.brc_status_date_CUSTOM_ErrorCount
          ,le.lic_iss_code_ALLOW_ErrorCount
          ,le.license_class_ALLOW_ErrorCount
          ,le.lic_exp_date_CUSTOM_ErrorCount
          ,le.lic_seq_number_ALLOW_ErrorCount
          ,le.lic_surrender_to_CUSTOM_ErrorCount
          ,le.license_endorsements_ALLOW_ErrorCount
          ,le.license_restrictions_ALLOW_ErrorCount
          ,le.license_trans_type_CUSTOM_ErrorCount
          ,le.lic_print_date_CUSTOM_ErrorCount
          ,le.permit_iss_code_ALLOW_ErrorCount
          ,le.permit_class_ALLOW_ErrorCount
          ,le.permit_exp_date_CUSTOM_ErrorCount
          ,le.permit_seq_number_ALLOW_ErrorCount
          ,le.permit_endorse_codes_ALLOW_ErrorCount
          ,le.permit_restric_codes_ALLOW_ErrorCount
          ,le.permit_trans_type_ALLOW_ErrorCount
          ,le.permit_print_date_CUSTOM_ErrorCount
          ,le.non_driver_code_ALLOW_ErrorCount
          ,le.non_driver_exp_date_CUSTOM_ErrorCount
          ,le.non_driver_seq_num_ALLOW_ErrorCount
          ,le.non_driver_trans_type_ALLOW_ErrorCount
          ,le.non_driver_print_date_CUSTOM_ErrorCount
          ,le.action_surrender_date_CUSTOM_ErrorCount
          ,le.action_counts_CUSTOM_ErrorCount
          ,le.driv_priv_counts_ALLOW_ErrorCount
          ,le.conv_counts_CUSTOM_ErrorCount
          ,le.accidents_counts_ALLOW_ErrorCount
          ,le.aka_counts_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.cln_zip5_CUSTOM_ErrorCount
          ,le.cln_zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dpbc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.ace_fips_st_CUSTOM_ErrorCount
          ,le.county_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.previous_dl_number_ALLOW_ErrorCount
          ,le.previous_st_CUSTOM_ErrorCount
          ,le.old_dl_number_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_MO_MEDCERT));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unique_key:' + getFieldTypeText(h.unique_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_number:' + getFieldTypeText(h.license_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_name:' + getFieldTypeText(h.middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_birth:' + getFieldTypeText(h.date_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_address1:' + getFieldTypeText(h.mailing_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_address2:' + getFieldTypeText(h.mailing_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_city:' + getFieldTypeText(h.mailing_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_state:' + getFieldTypeText(h.mailing_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_zip:' + getFieldTypeText(h.mailing_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'height:' + getFieldTypeText(h.height) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eye_color:' + getFieldTypeText(h.eye_color) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'operator_status:' + getFieldTypeText(h.operator_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commercial_status:' + getFieldTypeText(h.commercial_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_bus_status:' + getFieldTypeText(h.sch_bus_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pending_act_code:' + getFieldTypeText(h.pending_act_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'must_test_ind:' + getFieldTypeText(h.must_test_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deceased_ind:' + getFieldTypeText(h.deceased_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prev_cdl_class:' + getFieldTypeText(h.prev_cdl_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cdl_ptr:' + getFieldTypeText(h.cdl_ptr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pdps_ptr:' + getFieldTypeText(h.pdps_ptr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mvr_privacy_code:' + getFieldTypeText(h.mvr_privacy_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brc_status_code:' + getFieldTypeText(h.brc_status_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brc_status_date:' + getFieldTypeText(h.brc_status_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lic_iss_code:' + getFieldTypeText(h.lic_iss_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_class:' + getFieldTypeText(h.license_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lic_exp_date:' + getFieldTypeText(h.lic_exp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lic_seq_number:' + getFieldTypeText(h.lic_seq_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lic_surrender_to:' + getFieldTypeText(h.lic_surrender_to) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_out_of_st_dl_num:' + getFieldTypeText(h.new_out_of_st_dl_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_endorsements:' + getFieldTypeText(h.license_endorsements) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_restrictions:' + getFieldTypeText(h.license_restrictions) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_trans_type:' + getFieldTypeText(h.license_trans_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lic_print_date:' + getFieldTypeText(h.lic_print_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_iss_code:' + getFieldTypeText(h.permit_iss_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_class:' + getFieldTypeText(h.permit_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_exp_date:' + getFieldTypeText(h.permit_exp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_seq_number:' + getFieldTypeText(h.permit_seq_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_endorse_codes:' + getFieldTypeText(h.permit_endorse_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_restric_codes:' + getFieldTypeText(h.permit_restric_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_trans_type:' + getFieldTypeText(h.permit_trans_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permit_print_date:' + getFieldTypeText(h.permit_print_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_driver_code:' + getFieldTypeText(h.non_driver_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_driver_exp_date:' + getFieldTypeText(h.non_driver_exp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_driver_seq_num:' + getFieldTypeText(h.non_driver_seq_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_driver_trans_type:' + getFieldTypeText(h.non_driver_trans_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_driver_print_date:' + getFieldTypeText(h.non_driver_print_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_surrender_date:' + getFieldTypeText(h.action_surrender_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_counts:' + getFieldTypeText(h.action_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'driv_priv_counts:' + getFieldTypeText(h.driv_priv_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conv_counts:' + getFieldTypeText(h.conv_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'accidents_counts:' + getFieldTypeText(h.accidents_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aka_counts:' + getFieldTypeText(h.aka_counts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleaning_score:' + getFieldTypeText(h.cleaning_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_zip5:' + getFieldTypeText(h.cln_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_zip4:' + getFieldTypeText(h.cln_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'previous_dl_number:' + getFieldTypeText(h.previous_dl_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'previous_st:' + getFieldTypeText(h.previous_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'old_dl_number:' + getFieldTypeText(h.old_dl_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_unique_key_cnt
          ,le.populated_license_number_cnt
          ,le.populated_last_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_name_cnt
          ,le.populated_suffix_cnt
          ,le.populated_date_of_birth_cnt
          ,le.populated_gender_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_mailing_address1_cnt
          ,le.populated_mailing_address2_cnt
          ,le.populated_mailing_city_cnt
          ,le.populated_mailing_state_cnt
          ,le.populated_mailing_zip_cnt
          ,le.populated_height_cnt
          ,le.populated_eye_color_cnt
          ,le.populated_operator_status_cnt
          ,le.populated_commercial_status_cnt
          ,le.populated_sch_bus_status_cnt
          ,le.populated_pending_act_code_cnt
          ,le.populated_must_test_ind_cnt
          ,le.populated_deceased_ind_cnt
          ,le.populated_prev_cdl_class_cnt
          ,le.populated_cdl_ptr_cnt
          ,le.populated_pdps_ptr_cnt
          ,le.populated_mvr_privacy_code_cnt
          ,le.populated_brc_status_code_cnt
          ,le.populated_brc_status_date_cnt
          ,le.populated_lic_iss_code_cnt
          ,le.populated_license_class_cnt
          ,le.populated_lic_exp_date_cnt
          ,le.populated_lic_seq_number_cnt
          ,le.populated_lic_surrender_to_cnt
          ,le.populated_new_out_of_st_dl_num_cnt
          ,le.populated_license_endorsements_cnt
          ,le.populated_license_restrictions_cnt
          ,le.populated_license_trans_type_cnt
          ,le.populated_lic_print_date_cnt
          ,le.populated_permit_iss_code_cnt
          ,le.populated_permit_class_cnt
          ,le.populated_permit_exp_date_cnt
          ,le.populated_permit_seq_number_cnt
          ,le.populated_permit_endorse_codes_cnt
          ,le.populated_permit_restric_codes_cnt
          ,le.populated_permit_trans_type_cnt
          ,le.populated_permit_print_date_cnt
          ,le.populated_non_driver_code_cnt
          ,le.populated_non_driver_exp_date_cnt
          ,le.populated_non_driver_seq_num_cnt
          ,le.populated_non_driver_trans_type_cnt
          ,le.populated_non_driver_print_date_cnt
          ,le.populated_action_surrender_date_cnt
          ,le.populated_action_counts_cnt
          ,le.populated_driv_priv_counts_cnt
          ,le.populated_conv_counts_cnt
          ,le.populated_accidents_counts_cnt
          ,le.populated_aka_counts_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_cleaning_score_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_cln_zip5_cnt
          ,le.populated_cln_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_previous_dl_number_cnt
          ,le.populated_previous_st_cnt
          ,le.populated_old_dl_number_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_unique_key_pcnt
          ,le.populated_license_number_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_name_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_date_of_birth_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_mailing_address1_pcnt
          ,le.populated_mailing_address2_pcnt
          ,le.populated_mailing_city_pcnt
          ,le.populated_mailing_state_pcnt
          ,le.populated_mailing_zip_pcnt
          ,le.populated_height_pcnt
          ,le.populated_eye_color_pcnt
          ,le.populated_operator_status_pcnt
          ,le.populated_commercial_status_pcnt
          ,le.populated_sch_bus_status_pcnt
          ,le.populated_pending_act_code_pcnt
          ,le.populated_must_test_ind_pcnt
          ,le.populated_deceased_ind_pcnt
          ,le.populated_prev_cdl_class_pcnt
          ,le.populated_cdl_ptr_pcnt
          ,le.populated_pdps_ptr_pcnt
          ,le.populated_mvr_privacy_code_pcnt
          ,le.populated_brc_status_code_pcnt
          ,le.populated_brc_status_date_pcnt
          ,le.populated_lic_iss_code_pcnt
          ,le.populated_license_class_pcnt
          ,le.populated_lic_exp_date_pcnt
          ,le.populated_lic_seq_number_pcnt
          ,le.populated_lic_surrender_to_pcnt
          ,le.populated_new_out_of_st_dl_num_pcnt
          ,le.populated_license_endorsements_pcnt
          ,le.populated_license_restrictions_pcnt
          ,le.populated_license_trans_type_pcnt
          ,le.populated_lic_print_date_pcnt
          ,le.populated_permit_iss_code_pcnt
          ,le.populated_permit_class_pcnt
          ,le.populated_permit_exp_date_pcnt
          ,le.populated_permit_seq_number_pcnt
          ,le.populated_permit_endorse_codes_pcnt
          ,le.populated_permit_restric_codes_pcnt
          ,le.populated_permit_trans_type_pcnt
          ,le.populated_permit_print_date_pcnt
          ,le.populated_non_driver_code_pcnt
          ,le.populated_non_driver_exp_date_pcnt
          ,le.populated_non_driver_seq_num_pcnt
          ,le.populated_non_driver_trans_type_pcnt
          ,le.populated_non_driver_print_date_pcnt
          ,le.populated_action_surrender_date_pcnt
          ,le.populated_action_counts_pcnt
          ,le.populated_driv_priv_counts_pcnt
          ,le.populated_conv_counts_pcnt
          ,le.populated_accidents_counts_pcnt
          ,le.populated_aka_counts_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_cleaning_score_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_cln_zip5_pcnt
          ,le.populated_cln_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_previous_dl_number_pcnt
          ,le.populated_previous_st_pcnt
          ,le.populated_old_dl_number_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,98,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_MO_MEDCERT));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),98,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_MO_MEDCERT) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_MO_MEDCERT, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
