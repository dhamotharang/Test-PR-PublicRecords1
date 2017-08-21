IMPORT SALT38,STD;
IMPORT Scrubs,Scrubs_Infutor_NARC; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 98;
  EXPORT NumRulesFromFieldType := 98;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 94;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Infutor_NARC)
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 orig_gender_Invalid;
    UNSIGNED1 orig_age_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_tot_males_Invalid;
    UNSIGNED1 orig_tot_females_Invalid;
    UNSIGNED1 orig_address_Invalid;
    UNSIGNED1 orig_house_Invalid;
    UNSIGNED1 orig_predir_Invalid;
    UNSIGNED1 orig_street_Invalid;
    UNSIGNED1 orig_strtype_Invalid;
    UNSIGNED1 orig_postdir_Invalid;
    UNSIGNED1 orig_apttype_Invalid;
    UNSIGNED1 orig_aptnbr_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_z4_Invalid;
    UNSIGNED1 orig_vacant_Invalid;
    UNSIGNED1 orig_time_zone_Invalid;
    UNSIGNED1 orig_lat_long_assignment_level_Invalid;
    UNSIGNED1 orig_telephonenumber_1_Invalid;
    UNSIGNED1 orig_validationflag_1_Invalid;
    UNSIGNED1 orig_validationdate_1_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_1_Invalid;
    UNSIGNED1 orig_telephonenumber_2_Invalid;
    UNSIGNED1 orig_validation_flag_2_Invalid;
    UNSIGNED1 orig_validation_date_2_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_2_Invalid;
    UNSIGNED1 orig_telephonenumber_3_Invalid;
    UNSIGNED1 orig_validationflag_3_Invalid;
    UNSIGNED1 orig_validationdate_3_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_3_Invalid;
    UNSIGNED1 orig_telephonenumber_4_Invalid;
    UNSIGNED1 orig_validationflag_4_Invalid;
    UNSIGNED1 orig_validationdate_4_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_4_Invalid;
    UNSIGNED1 orig_telephonenumber_5_Invalid;
    UNSIGNED1 orig_validationflag_5_Invalid;
    UNSIGNED1 orig_validationdate_5_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_5_Invalid;
    UNSIGNED1 orig_telephonenumber_6_Invalid;
    UNSIGNED1 orig_validationflag_6_Invalid;
    UNSIGNED1 orig_validationdate_6_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_6_Invalid;
    UNSIGNED1 orig_telephonenumber_7_Invalid;
    UNSIGNED1 orig_validationflag_7_Invalid;
    UNSIGNED1 orig_validationdate_7_Invalid;
    UNSIGNED1 orig_dma_tps_dnc_flag_7_Invalid;
    UNSIGNED1 orig_tot_phones_Invalid;
    UNSIGNED1 orig_length_of_residence_Invalid;
    UNSIGNED1 orig_homeowner_Invalid;
    UNSIGNED1 orig_estimatedincome_Invalid;
    UNSIGNED1 orig_dwelling_type_Invalid;
    UNSIGNED1 orig_married_Invalid;
    UNSIGNED1 orig_child_Invalid;
    UNSIGNED1 orig_nbrchild_Invalid;
    UNSIGNED1 orig_teencd_Invalid;
    UNSIGNED1 orig_percent_range_black_Invalid;
    UNSIGNED1 orig_percent_range_white_Invalid;
    UNSIGNED1 orig_percent_range_hispanic_Invalid;
    UNSIGNED1 orig_percent_range_asian_Invalid;
    UNSIGNED1 orig_percent_range_english_speaking_Invalid;
    UNSIGNED1 orig_percnt_range_spanish_speaking_Invalid;
    UNSIGNED1 orig_percent_range_asian_speaking_Invalid;
    UNSIGNED1 orig_percent_range_sfdu_Invalid;
    UNSIGNED1 orig_percent_range_mfdu_Invalid;
    UNSIGNED1 orig_mhv_Invalid;
    UNSIGNED1 orig_mor_Invalid;
    UNSIGNED1 orig_car_Invalid;
    UNSIGNED1 orig_medschl_Invalid;
    UNSIGNED1 orig_penetration_range_whitecollar_Invalid;
    UNSIGNED1 orig_penetration_range_bluecollar_Invalid;
    UNSIGNED1 orig_penetration_range_otheroccupation_Invalid;
    UNSIGNED1 orig_recdate_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_dob_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Infutor_NARC)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Base_Layout_Infutor_NARC) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_fname_Invalid := Base_Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname);
    SELF.orig_mname_Invalid := Base_Fields.InValid_orig_mname((SALT38.StrType)le.orig_mname);
    SELF.orig_lname_Invalid := Base_Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname);
    SELF.orig_suffix_Invalid := Base_Fields.InValid_orig_suffix((SALT38.StrType)le.orig_suffix);
    SELF.orig_gender_Invalid := Base_Fields.InValid_orig_gender((SALT38.StrType)le.orig_gender);
    SELF.orig_age_Invalid := Base_Fields.InValid_orig_age((SALT38.StrType)le.orig_age);
    SELF.orig_dob_Invalid := Base_Fields.InValid_orig_dob((SALT38.StrType)le.orig_dob);
    SELF.orig_tot_males_Invalid := Base_Fields.InValid_orig_tot_males((SALT38.StrType)le.orig_tot_males);
    SELF.orig_tot_females_Invalid := Base_Fields.InValid_orig_tot_females((SALT38.StrType)le.orig_tot_females);
    SELF.orig_address_Invalid := Base_Fields.InValid_orig_address((SALT38.StrType)le.orig_address);
    SELF.orig_house_Invalid := Base_Fields.InValid_orig_house((SALT38.StrType)le.orig_house);
    SELF.orig_predir_Invalid := Base_Fields.InValid_orig_predir((SALT38.StrType)le.orig_predir);
    SELF.orig_street_Invalid := Base_Fields.InValid_orig_street((SALT38.StrType)le.orig_street);
    SELF.orig_strtype_Invalid := Base_Fields.InValid_orig_strtype((SALT38.StrType)le.orig_strtype);
    SELF.orig_postdir_Invalid := Base_Fields.InValid_orig_postdir((SALT38.StrType)le.orig_postdir);
    SELF.orig_apttype_Invalid := Base_Fields.InValid_orig_apttype((SALT38.StrType)le.orig_apttype);
    SELF.orig_aptnbr_Invalid := Base_Fields.InValid_orig_aptnbr((SALT38.StrType)le.orig_aptnbr);
    SELF.orig_city_Invalid := Base_Fields.InValid_orig_city((SALT38.StrType)le.orig_city);
    SELF.orig_state_Invalid := Base_Fields.InValid_orig_state((SALT38.StrType)le.orig_state);
    SELF.orig_zip_Invalid := Base_Fields.InValid_orig_zip((SALT38.StrType)le.orig_zip);
    SELF.orig_z4_Invalid := Base_Fields.InValid_orig_z4((SALT38.StrType)le.orig_z4);
    SELF.orig_vacant_Invalid := Base_Fields.InValid_orig_vacant((SALT38.StrType)le.orig_vacant);
    SELF.orig_time_zone_Invalid := Base_Fields.InValid_orig_time_zone((SALT38.StrType)le.orig_time_zone);
    SELF.orig_lat_long_assignment_level_Invalid := Base_Fields.InValid_orig_lat_long_assignment_level((SALT38.StrType)le.orig_lat_long_assignment_level);
    SELF.orig_telephonenumber_1_Invalid := Base_Fields.InValid_orig_telephonenumber_1((SALT38.StrType)le.orig_telephonenumber_1);
    SELF.orig_validationflag_1_Invalid := Base_Fields.InValid_orig_validationflag_1((SALT38.StrType)le.orig_validationflag_1);
    SELF.orig_validationdate_1_Invalid := Base_Fields.InValid_orig_validationdate_1((SALT38.StrType)le.orig_validationdate_1);
    SELF.orig_dma_tps_dnc_flag_1_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_1((SALT38.StrType)le.orig_dma_tps_dnc_flag_1);
    SELF.orig_telephonenumber_2_Invalid := Base_Fields.InValid_orig_telephonenumber_2((SALT38.StrType)le.orig_telephonenumber_2);
    SELF.orig_validation_flag_2_Invalid := Base_Fields.InValid_orig_validation_flag_2((SALT38.StrType)le.orig_validation_flag_2);
    SELF.orig_validation_date_2_Invalid := Base_Fields.InValid_orig_validation_date_2((SALT38.StrType)le.orig_validation_date_2);
    SELF.orig_dma_tps_dnc_flag_2_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_2((SALT38.StrType)le.orig_dma_tps_dnc_flag_2);
    SELF.orig_telephonenumber_3_Invalid := Base_Fields.InValid_orig_telephonenumber_3((SALT38.StrType)le.orig_telephonenumber_3);
    SELF.orig_validationflag_3_Invalid := Base_Fields.InValid_orig_validationflag_3((SALT38.StrType)le.orig_validationflag_3);
    SELF.orig_validationdate_3_Invalid := Base_Fields.InValid_orig_validationdate_3((SALT38.StrType)le.orig_validationdate_3);
    SELF.orig_dma_tps_dnc_flag_3_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_3((SALT38.StrType)le.orig_dma_tps_dnc_flag_3);
    SELF.orig_telephonenumber_4_Invalid := Base_Fields.InValid_orig_telephonenumber_4((SALT38.StrType)le.orig_telephonenumber_4);
    SELF.orig_validationflag_4_Invalid := Base_Fields.InValid_orig_validationflag_4((SALT38.StrType)le.orig_validationflag_4);
    SELF.orig_validationdate_4_Invalid := Base_Fields.InValid_orig_validationdate_4((SALT38.StrType)le.orig_validationdate_4);
    SELF.orig_dma_tps_dnc_flag_4_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_4((SALT38.StrType)le.orig_dma_tps_dnc_flag_4);
    SELF.orig_telephonenumber_5_Invalid := Base_Fields.InValid_orig_telephonenumber_5((SALT38.StrType)le.orig_telephonenumber_5);
    SELF.orig_validationflag_5_Invalid := Base_Fields.InValid_orig_validationflag_5((SALT38.StrType)le.orig_validationflag_5);
    SELF.orig_validationdate_5_Invalid := Base_Fields.InValid_orig_validationdate_5((SALT38.StrType)le.orig_validationdate_5);
    SELF.orig_dma_tps_dnc_flag_5_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_5((SALT38.StrType)le.orig_dma_tps_dnc_flag_5);
    SELF.orig_telephonenumber_6_Invalid := Base_Fields.InValid_orig_telephonenumber_6((SALT38.StrType)le.orig_telephonenumber_6);
    SELF.orig_validationflag_6_Invalid := Base_Fields.InValid_orig_validationflag_6((SALT38.StrType)le.orig_validationflag_6);
    SELF.orig_validationdate_6_Invalid := Base_Fields.InValid_orig_validationdate_6((SALT38.StrType)le.orig_validationdate_6);
    SELF.orig_dma_tps_dnc_flag_6_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_6((SALT38.StrType)le.orig_dma_tps_dnc_flag_6);
    SELF.orig_telephonenumber_7_Invalid := Base_Fields.InValid_orig_telephonenumber_7((SALT38.StrType)le.orig_telephonenumber_7);
    SELF.orig_validationflag_7_Invalid := Base_Fields.InValid_orig_validationflag_7((SALT38.StrType)le.orig_validationflag_7);
    SELF.orig_validationdate_7_Invalid := Base_Fields.InValid_orig_validationdate_7((SALT38.StrType)le.orig_validationdate_7);
    SELF.orig_dma_tps_dnc_flag_7_Invalid := Base_Fields.InValid_orig_dma_tps_dnc_flag_7((SALT38.StrType)le.orig_dma_tps_dnc_flag_7);
    SELF.orig_tot_phones_Invalid := Base_Fields.InValid_orig_tot_phones((SALT38.StrType)le.orig_tot_phones);
    SELF.orig_length_of_residence_Invalid := Base_Fields.InValid_orig_length_of_residence((SALT38.StrType)le.orig_length_of_residence);
    SELF.orig_homeowner_Invalid := Base_Fields.InValid_orig_homeowner((SALT38.StrType)le.orig_homeowner);
    SELF.orig_estimatedincome_Invalid := Base_Fields.InValid_orig_estimatedincome((SALT38.StrType)le.orig_estimatedincome);
    SELF.orig_dwelling_type_Invalid := Base_Fields.InValid_orig_dwelling_type((SALT38.StrType)le.orig_dwelling_type);
    SELF.orig_married_Invalid := Base_Fields.InValid_orig_married((SALT38.StrType)le.orig_married);
    SELF.orig_child_Invalid := Base_Fields.InValid_orig_child((SALT38.StrType)le.orig_child);
    SELF.orig_nbrchild_Invalid := Base_Fields.InValid_orig_nbrchild((SALT38.StrType)le.orig_nbrchild);
    SELF.orig_teencd_Invalid := Base_Fields.InValid_orig_teencd((SALT38.StrType)le.orig_teencd);
    SELF.orig_percent_range_black_Invalid := Base_Fields.InValid_orig_percent_range_black((SALT38.StrType)le.orig_percent_range_black);
    SELF.orig_percent_range_white_Invalid := Base_Fields.InValid_orig_percent_range_white((SALT38.StrType)le.orig_percent_range_white);
    SELF.orig_percent_range_hispanic_Invalid := Base_Fields.InValid_orig_percent_range_hispanic((SALT38.StrType)le.orig_percent_range_hispanic);
    SELF.orig_percent_range_asian_Invalid := Base_Fields.InValid_orig_percent_range_asian((SALT38.StrType)le.orig_percent_range_asian);
    SELF.orig_percent_range_english_speaking_Invalid := Base_Fields.InValid_orig_percent_range_english_speaking((SALT38.StrType)le.orig_percent_range_english_speaking);
    SELF.orig_percnt_range_spanish_speaking_Invalid := Base_Fields.InValid_orig_percnt_range_spanish_speaking((SALT38.StrType)le.orig_percnt_range_spanish_speaking);
    SELF.orig_percent_range_asian_speaking_Invalid := Base_Fields.InValid_orig_percent_range_asian_speaking((SALT38.StrType)le.orig_percent_range_asian_speaking);
    SELF.orig_percent_range_sfdu_Invalid := Base_Fields.InValid_orig_percent_range_sfdu((SALT38.StrType)le.orig_percent_range_sfdu);
    SELF.orig_percent_range_mfdu_Invalid := Base_Fields.InValid_orig_percent_range_mfdu((SALT38.StrType)le.orig_percent_range_mfdu);
    SELF.orig_mhv_Invalid := Base_Fields.InValid_orig_mhv((SALT38.StrType)le.orig_mhv);
    SELF.orig_mor_Invalid := Base_Fields.InValid_orig_mor((SALT38.StrType)le.orig_mor);
    SELF.orig_car_Invalid := Base_Fields.InValid_orig_car((SALT38.StrType)le.orig_car);
    SELF.orig_medschl_Invalid := Base_Fields.InValid_orig_medschl((SALT38.StrType)le.orig_medschl);
    SELF.orig_penetration_range_whitecollar_Invalid := Base_Fields.InValid_orig_penetration_range_whitecollar((SALT38.StrType)le.orig_penetration_range_whitecollar);
    SELF.orig_penetration_range_bluecollar_Invalid := Base_Fields.InValid_orig_penetration_range_bluecollar((SALT38.StrType)le.orig_penetration_range_bluecollar);
    SELF.orig_penetration_range_otheroccupation_Invalid := Base_Fields.InValid_orig_penetration_range_otheroccupation((SALT38.StrType)le.orig_penetration_range_otheroccupation);
    SELF.orig_recdate_Invalid := Base_Fields.InValid_orig_recdate((SALT38.StrType)le.orig_recdate);
    SELF.name_suffix_Invalid := Base_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix);
    SELF.prim_range_Invalid := Base_Fields.InValid_prim_range((SALT38.StrType)le.prim_range);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT38.StrType)le.predir);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Base_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT38.StrType)le.postdir);
    SELF.unit_desig_Invalid := Base_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Base_Fields.InValid_sec_range((SALT38.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT38.StrType)le.clean_phone);
    SELF.clean_dob_Invalid := Base_Fields.InValid_clean_dob((SALT38.StrType)le.clean_dob);
    SELF.date_first_seen_Invalid := Base_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Base_Fields.InValid_date_vendor_first_reported((SALT38.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Base_Fields.InValid_date_vendor_last_reported((SALT38.StrType)le.date_vendor_last_reported);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Infutor_NARC);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_fname_Invalid << 0 ) + ( le.orig_mname_Invalid << 1 ) + ( le.orig_lname_Invalid << 2 ) + ( le.orig_suffix_Invalid << 3 ) + ( le.orig_gender_Invalid << 4 ) + ( le.orig_age_Invalid << 5 ) + ( le.orig_dob_Invalid << 6 ) + ( le.orig_tot_males_Invalid << 7 ) + ( le.orig_tot_females_Invalid << 8 ) + ( le.orig_address_Invalid << 9 ) + ( le.orig_house_Invalid << 10 ) + ( le.orig_predir_Invalid << 11 ) + ( le.orig_street_Invalid << 12 ) + ( le.orig_strtype_Invalid << 13 ) + ( le.orig_postdir_Invalid << 14 ) + ( le.orig_apttype_Invalid << 15 ) + ( le.orig_aptnbr_Invalid << 16 ) + ( le.orig_city_Invalid << 17 ) + ( le.orig_state_Invalid << 19 ) + ( le.orig_zip_Invalid << 20 ) + ( le.orig_z4_Invalid << 22 ) + ( le.orig_vacant_Invalid << 24 ) + ( le.orig_time_zone_Invalid << 25 ) + ( le.orig_lat_long_assignment_level_Invalid << 26 ) + ( le.orig_telephonenumber_1_Invalid << 27 ) + ( le.orig_validationflag_1_Invalid << 28 ) + ( le.orig_validationdate_1_Invalid << 29 ) + ( le.orig_dma_tps_dnc_flag_1_Invalid << 30 ) + ( le.orig_telephonenumber_2_Invalid << 31 ) + ( le.orig_validation_flag_2_Invalid << 32 ) + ( le.orig_validation_date_2_Invalid << 33 ) + ( le.orig_dma_tps_dnc_flag_2_Invalid << 34 ) + ( le.orig_telephonenumber_3_Invalid << 35 ) + ( le.orig_validationflag_3_Invalid << 36 ) + ( le.orig_validationdate_3_Invalid << 37 ) + ( le.orig_dma_tps_dnc_flag_3_Invalid << 38 ) + ( le.orig_telephonenumber_4_Invalid << 39 ) + ( le.orig_validationflag_4_Invalid << 40 ) + ( le.orig_validationdate_4_Invalid << 41 ) + ( le.orig_dma_tps_dnc_flag_4_Invalid << 42 ) + ( le.orig_telephonenumber_5_Invalid << 43 ) + ( le.orig_validationflag_5_Invalid << 44 ) + ( le.orig_validationdate_5_Invalid << 45 ) + ( le.orig_dma_tps_dnc_flag_5_Invalid << 46 ) + ( le.orig_telephonenumber_6_Invalid << 47 ) + ( le.orig_validationflag_6_Invalid << 48 ) + ( le.orig_validationdate_6_Invalid << 49 ) + ( le.orig_dma_tps_dnc_flag_6_Invalid << 50 ) + ( le.orig_telephonenumber_7_Invalid << 51 ) + ( le.orig_validationflag_7_Invalid << 52 ) + ( le.orig_validationdate_7_Invalid << 53 ) + ( le.orig_dma_tps_dnc_flag_7_Invalid << 54 ) + ( le.orig_tot_phones_Invalid << 55 ) + ( le.orig_length_of_residence_Invalid << 56 ) + ( le.orig_homeowner_Invalid << 57 ) + ( le.orig_estimatedincome_Invalid << 58 ) + ( le.orig_dwelling_type_Invalid << 59 ) + ( le.orig_married_Invalid << 60 ) + ( le.orig_child_Invalid << 61 ) + ( le.orig_nbrchild_Invalid << 62 ) + ( le.orig_teencd_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.orig_percent_range_black_Invalid << 0 ) + ( le.orig_percent_range_white_Invalid << 1 ) + ( le.orig_percent_range_hispanic_Invalid << 2 ) + ( le.orig_percent_range_asian_Invalid << 3 ) + ( le.orig_percent_range_english_speaking_Invalid << 4 ) + ( le.orig_percnt_range_spanish_speaking_Invalid << 5 ) + ( le.orig_percent_range_asian_speaking_Invalid << 6 ) + ( le.orig_percent_range_sfdu_Invalid << 7 ) + ( le.orig_percent_range_mfdu_Invalid << 8 ) + ( le.orig_mhv_Invalid << 9 ) + ( le.orig_mor_Invalid << 10 ) + ( le.orig_car_Invalid << 11 ) + ( le.orig_medschl_Invalid << 12 ) + ( le.orig_penetration_range_whitecollar_Invalid << 13 ) + ( le.orig_penetration_range_bluecollar_Invalid << 14 ) + ( le.orig_penetration_range_otheroccupation_Invalid << 15 ) + ( le.orig_recdate_Invalid << 16 ) + ( le.name_suffix_Invalid << 17 ) + ( le.prim_range_Invalid << 18 ) + ( le.predir_Invalid << 19 ) + ( le.prim_name_Invalid << 20 ) + ( le.addr_suffix_Invalid << 21 ) + ( le.postdir_Invalid << 22 ) + ( le.unit_desig_Invalid << 23 ) + ( le.sec_range_Invalid << 24 ) + ( le.p_city_name_Invalid << 25 ) + ( le.v_city_name_Invalid << 26 ) + ( le.clean_phone_Invalid << 27 ) + ( le.clean_dob_Invalid << 28 ) + ( le.date_first_seen_Invalid << 29 ) + ( le.date_last_seen_Invalid << 30 ) + ( le.date_vendor_first_reported_Invalid << 31 ) + ( le.date_vendor_last_reported_Invalid << 32 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Infutor_NARC);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_suffix_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_gender_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_age_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.orig_tot_males_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_tot_females_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_address_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_house_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_predir_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_street_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_strtype_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_postdir_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_apttype_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_aptnbr_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.orig_z4_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.orig_vacant_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.orig_time_zone_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.orig_lat_long_assignment_level_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.orig_telephonenumber_1_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.orig_validationflag_1_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.orig_validationdate_1_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.orig_dma_tps_dnc_flag_1_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.orig_telephonenumber_2_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.orig_validation_flag_2_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.orig_validation_date_2_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.orig_dma_tps_dnc_flag_2_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.orig_telephonenumber_3_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.orig_validationflag_3_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.orig_validationdate_3_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.orig_dma_tps_dnc_flag_3_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.orig_telephonenumber_4_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.orig_validationflag_4_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.orig_validationdate_4_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.orig_dma_tps_dnc_flag_4_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.orig_telephonenumber_5_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.orig_validationflag_5_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.orig_validationdate_5_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.orig_dma_tps_dnc_flag_5_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.orig_telephonenumber_6_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.orig_validationflag_6_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.orig_validationdate_6_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.orig_dma_tps_dnc_flag_6_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.orig_telephonenumber_7_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.orig_validationflag_7_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.orig_validationdate_7_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.orig_dma_tps_dnc_flag_7_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.orig_tot_phones_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.orig_length_of_residence_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.orig_homeowner_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.orig_estimatedincome_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.orig_dwelling_type_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.orig_married_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.orig_child_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.orig_nbrchild_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.orig_teencd_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.orig_percent_range_black_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.orig_percent_range_white_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.orig_percent_range_hispanic_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.orig_percent_range_asian_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.orig_percent_range_english_speaking_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.orig_percnt_range_spanish_speaking_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.orig_percent_range_asian_speaking_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.orig_percent_range_sfdu_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.orig_percent_range_mfdu_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.orig_mhv_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.orig_mor_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.orig_car_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.orig_medschl_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.orig_penetration_range_whitecollar_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.orig_penetration_range_bluecollar_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.orig_penetration_range_otheroccupation_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.orig_recdate_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.clean_dob_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_suffix_ENUM_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    orig_gender_ENUM_ErrorCount := COUNT(GROUP,h.orig_gender_Invalid=1);
    orig_age_ALLOW_ErrorCount := COUNT(GROUP,h.orig_age_Invalid=1);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_tot_males_ALLOW_ErrorCount := COUNT(GROUP,h.orig_tot_males_Invalid=1);
    orig_tot_females_ALLOW_ErrorCount := COUNT(GROUP,h.orig_tot_females_Invalid=1);
    orig_address_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_Invalid=1);
    orig_house_ALLOW_ErrorCount := COUNT(GROUP,h.orig_house_Invalid=1);
    orig_predir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=1);
    orig_street_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_Invalid=1);
    orig_strtype_ALLOW_ErrorCount := COUNT(GROUP,h.orig_strtype_Invalid=1);
    orig_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=1);
    orig_apttype_ALLOW_ErrorCount := COUNT(GROUP,h.orig_apttype_Invalid=1);
    orig_aptnbr_ALLOW_ErrorCount := COUNT(GROUP,h.orig_aptnbr_Invalid=1);
    orig_city_QUOTES_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=3);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_z4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_z4_Invalid=1);
    orig_z4_LENGTH_ErrorCount := COUNT(GROUP,h.orig_z4_Invalid=2);
    orig_z4_Total_ErrorCount := COUNT(GROUP,h.orig_z4_Invalid>0);
    orig_vacant_ENUM_ErrorCount := COUNT(GROUP,h.orig_vacant_Invalid=1);
    orig_time_zone_ENUM_ErrorCount := COUNT(GROUP,h.orig_time_zone_Invalid=1);
    orig_lat_long_assignment_level_ENUM_ErrorCount := COUNT(GROUP,h.orig_lat_long_assignment_level_Invalid=1);
    orig_telephonenumber_1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_1_Invalid=1);
    orig_validationflag_1_ENUM_ErrorCount := COUNT(GROUP,h.orig_validationflag_1_Invalid=1);
    orig_validationdate_1_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validationdate_1_Invalid=1);
    orig_dma_tps_dnc_flag_1_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_1_Invalid=1);
    orig_telephonenumber_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_2_Invalid=1);
    orig_validation_flag_2_ENUM_ErrorCount := COUNT(GROUP,h.orig_validation_flag_2_Invalid=1);
    orig_validation_date_2_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validation_date_2_Invalid=1);
    orig_dma_tps_dnc_flag_2_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_2_Invalid=1);
    orig_telephonenumber_3_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_3_Invalid=1);
    orig_validationflag_3_ENUM_ErrorCount := COUNT(GROUP,h.orig_validationflag_3_Invalid=1);
    orig_validationdate_3_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validationdate_3_Invalid=1);
    orig_dma_tps_dnc_flag_3_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_3_Invalid=1);
    orig_telephonenumber_4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_4_Invalid=1);
    orig_validationflag_4_ENUM_ErrorCount := COUNT(GROUP,h.orig_validationflag_4_Invalid=1);
    orig_validationdate_4_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validationdate_4_Invalid=1);
    orig_dma_tps_dnc_flag_4_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_4_Invalid=1);
    orig_telephonenumber_5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_5_Invalid=1);
    orig_validationflag_5_ENUM_ErrorCount := COUNT(GROUP,h.orig_validationflag_5_Invalid=1);
    orig_validationdate_5_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validationdate_5_Invalid=1);
    orig_dma_tps_dnc_flag_5_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_5_Invalid=1);
    orig_telephonenumber_6_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_6_Invalid=1);
    orig_validationflag_6_ENUM_ErrorCount := COUNT(GROUP,h.orig_validationflag_6_Invalid=1);
    orig_validationdate_6_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validationdate_6_Invalid=1);
    orig_dma_tps_dnc_flag_6_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_6_Invalid=1);
    orig_telephonenumber_7_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephonenumber_7_Invalid=1);
    orig_validationflag_7_ENUM_ErrorCount := COUNT(GROUP,h.orig_validationflag_7_Invalid=1);
    orig_validationdate_7_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_validationdate_7_Invalid=1);
    orig_dma_tps_dnc_flag_7_ENUM_ErrorCount := COUNT(GROUP,h.orig_dma_tps_dnc_flag_7_Invalid=1);
    orig_tot_phones_ALLOW_ErrorCount := COUNT(GROUP,h.orig_tot_phones_Invalid=1);
    orig_length_of_residence_ALLOW_ErrorCount := COUNT(GROUP,h.orig_length_of_residence_Invalid=1);
    orig_homeowner_ENUM_ErrorCount := COUNT(GROUP,h.orig_homeowner_Invalid=1);
    orig_estimatedincome_ENUM_ErrorCount := COUNT(GROUP,h.orig_estimatedincome_Invalid=1);
    orig_dwelling_type_ENUM_ErrorCount := COUNT(GROUP,h.orig_dwelling_type_Invalid=1);
    orig_married_ENUM_ErrorCount := COUNT(GROUP,h.orig_married_Invalid=1);
    orig_child_ENUM_ErrorCount := COUNT(GROUP,h.orig_child_Invalid=1);
    orig_nbrchild_ENUM_ErrorCount := COUNT(GROUP,h.orig_nbrchild_Invalid=1);
    orig_teencd_ENUM_ErrorCount := COUNT(GROUP,h.orig_teencd_Invalid=1);
    orig_percent_range_black_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_black_Invalid=1);
    orig_percent_range_white_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_white_Invalid=1);
    orig_percent_range_hispanic_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_hispanic_Invalid=1);
    orig_percent_range_asian_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_asian_Invalid=1);
    orig_percent_range_english_speaking_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_english_speaking_Invalid=1);
    orig_percnt_range_spanish_speaking_ENUM_ErrorCount := COUNT(GROUP,h.orig_percnt_range_spanish_speaking_Invalid=1);
    orig_percent_range_asian_speaking_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_asian_speaking_Invalid=1);
    orig_percent_range_sfdu_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_sfdu_Invalid=1);
    orig_percent_range_mfdu_ENUM_ErrorCount := COUNT(GROUP,h.orig_percent_range_mfdu_Invalid=1);
    orig_mhv_ENUM_ErrorCount := COUNT(GROUP,h.orig_mhv_Invalid=1);
    orig_mor_ENUM_ErrorCount := COUNT(GROUP,h.orig_mor_Invalid=1);
    orig_car_ENUM_ErrorCount := COUNT(GROUP,h.orig_car_Invalid=1);
    orig_medschl_ALLOW_ErrorCount := COUNT(GROUP,h.orig_medschl_Invalid=1);
    orig_penetration_range_whitecollar_ENUM_ErrorCount := COUNT(GROUP,h.orig_penetration_range_whitecollar_Invalid=1);
    orig_penetration_range_bluecollar_ENUM_ErrorCount := COUNT(GROUP,h.orig_penetration_range_bluecollar_Invalid=1);
    orig_penetration_range_otheroccupation_ENUM_ErrorCount := COUNT(GROUP,h.orig_penetration_range_otheroccupation_Invalid=1);
    orig_recdate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_recdate_Invalid=1);
    name_suffix_ENUM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_fname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_suffix_Invalid > 0 OR h.orig_gender_Invalid > 0 OR h.orig_age_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_tot_males_Invalid > 0 OR h.orig_tot_females_Invalid > 0 OR h.orig_address_Invalid > 0 OR h.orig_house_Invalid > 0 OR h.orig_predir_Invalid > 0 OR h.orig_street_Invalid > 0 OR h.orig_strtype_Invalid > 0 OR h.orig_postdir_Invalid > 0 OR h.orig_apttype_Invalid > 0 OR h.orig_aptnbr_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.orig_z4_Invalid > 0 OR h.orig_vacant_Invalid > 0 OR h.orig_time_zone_Invalid > 0 OR h.orig_lat_long_assignment_level_Invalid > 0 OR h.orig_telephonenumber_1_Invalid > 0 OR h.orig_validationflag_1_Invalid > 0 OR h.orig_validationdate_1_Invalid > 0 OR h.orig_dma_tps_dnc_flag_1_Invalid > 0 OR h.orig_telephonenumber_2_Invalid > 0 OR h.orig_validation_flag_2_Invalid > 0 OR h.orig_validation_date_2_Invalid > 0 OR h.orig_dma_tps_dnc_flag_2_Invalid > 0 OR h.orig_telephonenumber_3_Invalid > 0 OR h.orig_validationflag_3_Invalid > 0 OR h.orig_validationdate_3_Invalid > 0 OR h.orig_dma_tps_dnc_flag_3_Invalid > 0 OR h.orig_telephonenumber_4_Invalid > 0 OR h.orig_validationflag_4_Invalid > 0 OR h.orig_validationdate_4_Invalid > 0 OR h.orig_dma_tps_dnc_flag_4_Invalid > 0 OR h.orig_telephonenumber_5_Invalid > 0 OR h.orig_validationflag_5_Invalid > 0 OR h.orig_validationdate_5_Invalid > 0 OR h.orig_dma_tps_dnc_flag_5_Invalid > 0 OR h.orig_telephonenumber_6_Invalid > 0 OR h.orig_validationflag_6_Invalid > 0 OR h.orig_validationdate_6_Invalid > 0 OR h.orig_dma_tps_dnc_flag_6_Invalid > 0 OR h.orig_telephonenumber_7_Invalid > 0 OR h.orig_validationflag_7_Invalid > 0 OR h.orig_validationdate_7_Invalid > 0 OR h.orig_dma_tps_dnc_flag_7_Invalid > 0 OR h.orig_tot_phones_Invalid > 0 OR h.orig_length_of_residence_Invalid > 0 OR h.orig_homeowner_Invalid > 0 OR h.orig_estimatedincome_Invalid > 0 OR h.orig_dwelling_type_Invalid > 0 OR h.orig_married_Invalid > 0 OR h.orig_child_Invalid > 0 OR h.orig_nbrchild_Invalid > 0 OR h.orig_teencd_Invalid > 0 OR h.orig_percent_range_black_Invalid > 0 OR h.orig_percent_range_white_Invalid > 0 OR h.orig_percent_range_hispanic_Invalid > 0 OR h.orig_percent_range_asian_Invalid > 0 OR h.orig_percent_range_english_speaking_Invalid > 0 OR h.orig_percnt_range_spanish_speaking_Invalid > 0 OR h.orig_percent_range_asian_speaking_Invalid > 0 OR h.orig_percent_range_sfdu_Invalid > 0 OR h.orig_percent_range_mfdu_Invalid > 0 OR h.orig_mhv_Invalid > 0 OR h.orig_mor_Invalid > 0 OR h.orig_car_Invalid > 0 OR h.orig_medschl_Invalid > 0 OR h.orig_penetration_range_whitecollar_Invalid > 0 OR h.orig_penetration_range_bluecollar_Invalid > 0 OR h.orig_penetration_range_otheroccupation_Invalid > 0 OR h.orig_recdate_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.clean_phone_Invalid > 0 OR h.clean_dob_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_tot_males_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_tot_females_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_house_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_strtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_apttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_aptnbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_Total_ErrorCount > 0, 1, 0) + IF(le.orig_z4_Total_ErrorCount > 0, 1, 0) + IF(le.orig_vacant_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_time_zone_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_lat_long_assignment_level_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_1_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_1_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validation_flag_2_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validation_date_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_2_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_3_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_3_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_4_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_4_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_5_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_5_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_6_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_6_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_7_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_7_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_tot_phones_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_length_of_residence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_homeowner_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_estimatedincome_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_dwelling_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_married_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_child_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_nbrchild_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_teencd_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_black_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_white_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_hispanic_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_asian_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_english_speaking_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percnt_range_spanish_speaking_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_asian_speaking_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_sfdu_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_mfdu_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_mhv_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_mor_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_car_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_medschl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_penetration_range_whitecollar_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_penetration_range_bluecollar_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_penetration_range_otheroccupation_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_recdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_tot_males_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_tot_females_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_house_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_strtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_apttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_aptnbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_QUOTES_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_z4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_z4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.orig_vacant_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_time_zone_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_lat_long_assignment_level_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_1_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_1_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validation_flag_2_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validation_date_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_2_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_3_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_3_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_4_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_4_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_5_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_5_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_6_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_6_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_telephonenumber_7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_validationflag_7_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_validationdate_7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dma_tps_dnc_flag_7_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_tot_phones_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_length_of_residence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_homeowner_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_estimatedincome_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_dwelling_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_married_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_child_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_nbrchild_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_teencd_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_black_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_white_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_hispanic_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_asian_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_english_speaking_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percnt_range_spanish_speaking_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_asian_speaking_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_sfdu_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_percent_range_mfdu_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_mhv_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_mor_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_car_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_medschl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_penetration_range_whitecollar_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_penetration_range_bluecollar_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_penetration_range_otheroccupation_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_recdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_suffix_Invalid,le.orig_gender_Invalid,le.orig_age_Invalid,le.orig_dob_Invalid,le.orig_tot_males_Invalid,le.orig_tot_females_Invalid,le.orig_address_Invalid,le.orig_house_Invalid,le.orig_predir_Invalid,le.orig_street_Invalid,le.orig_strtype_Invalid,le.orig_postdir_Invalid,le.orig_apttype_Invalid,le.orig_aptnbr_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_z4_Invalid,le.orig_vacant_Invalid,le.orig_time_zone_Invalid,le.orig_lat_long_assignment_level_Invalid,le.orig_telephonenumber_1_Invalid,le.orig_validationflag_1_Invalid,le.orig_validationdate_1_Invalid,le.orig_dma_tps_dnc_flag_1_Invalid,le.orig_telephonenumber_2_Invalid,le.orig_validation_flag_2_Invalid,le.orig_validation_date_2_Invalid,le.orig_dma_tps_dnc_flag_2_Invalid,le.orig_telephonenumber_3_Invalid,le.orig_validationflag_3_Invalid,le.orig_validationdate_3_Invalid,le.orig_dma_tps_dnc_flag_3_Invalid,le.orig_telephonenumber_4_Invalid,le.orig_validationflag_4_Invalid,le.orig_validationdate_4_Invalid,le.orig_dma_tps_dnc_flag_4_Invalid,le.orig_telephonenumber_5_Invalid,le.orig_validationflag_5_Invalid,le.orig_validationdate_5_Invalid,le.orig_dma_tps_dnc_flag_5_Invalid,le.orig_telephonenumber_6_Invalid,le.orig_validationflag_6_Invalid,le.orig_validationdate_6_Invalid,le.orig_dma_tps_dnc_flag_6_Invalid,le.orig_telephonenumber_7_Invalid,le.orig_validationflag_7_Invalid,le.orig_validationdate_7_Invalid,le.orig_dma_tps_dnc_flag_7_Invalid,le.orig_tot_phones_Invalid,le.orig_length_of_residence_Invalid,le.orig_homeowner_Invalid,le.orig_estimatedincome_Invalid,le.orig_dwelling_type_Invalid,le.orig_married_Invalid,le.orig_child_Invalid,le.orig_nbrchild_Invalid,le.orig_teencd_Invalid,le.orig_percent_range_black_Invalid,le.orig_percent_range_white_Invalid,le.orig_percent_range_hispanic_Invalid,le.orig_percent_range_asian_Invalid,le.orig_percent_range_english_speaking_Invalid,le.orig_percnt_range_spanish_speaking_Invalid,le.orig_percent_range_asian_speaking_Invalid,le.orig_percent_range_sfdu_Invalid,le.orig_percent_range_mfdu_Invalid,le.orig_mhv_Invalid,le.orig_mor_Invalid,le.orig_car_Invalid,le.orig_medschl_Invalid,le.orig_penetration_range_whitecollar_Invalid,le.orig_penetration_range_bluecollar_Invalid,le.orig_penetration_range_otheroccupation_Invalid,le.orig_recdate_Invalid,le.name_suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.clean_phone_Invalid,le.clean_dob_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Base_Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Base_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Base_Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),Base_Fields.InvalidMessage_orig_gender(le.orig_gender_Invalid),Base_Fields.InvalidMessage_orig_age(le.orig_age_Invalid),Base_Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Base_Fields.InvalidMessage_orig_tot_males(le.orig_tot_males_Invalid),Base_Fields.InvalidMessage_orig_tot_females(le.orig_tot_females_Invalid),Base_Fields.InvalidMessage_orig_address(le.orig_address_Invalid),Base_Fields.InvalidMessage_orig_house(le.orig_house_Invalid),Base_Fields.InvalidMessage_orig_predir(le.orig_predir_Invalid),Base_Fields.InvalidMessage_orig_street(le.orig_street_Invalid),Base_Fields.InvalidMessage_orig_strtype(le.orig_strtype_Invalid),Base_Fields.InvalidMessage_orig_postdir(le.orig_postdir_Invalid),Base_Fields.InvalidMessage_orig_apttype(le.orig_apttype_Invalid),Base_Fields.InvalidMessage_orig_aptnbr(le.orig_aptnbr_Invalid),Base_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Base_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Base_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Base_Fields.InvalidMessage_orig_z4(le.orig_z4_Invalid),Base_Fields.InvalidMessage_orig_vacant(le.orig_vacant_Invalid),Base_Fields.InvalidMessage_orig_time_zone(le.orig_time_zone_Invalid),Base_Fields.InvalidMessage_orig_lat_long_assignment_level(le.orig_lat_long_assignment_level_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_1(le.orig_telephonenumber_1_Invalid),Base_Fields.InvalidMessage_orig_validationflag_1(le.orig_validationflag_1_Invalid),Base_Fields.InvalidMessage_orig_validationdate_1(le.orig_validationdate_1_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_1(le.orig_dma_tps_dnc_flag_1_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_2(le.orig_telephonenumber_2_Invalid),Base_Fields.InvalidMessage_orig_validation_flag_2(le.orig_validation_flag_2_Invalid),Base_Fields.InvalidMessage_orig_validation_date_2(le.orig_validation_date_2_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_2(le.orig_dma_tps_dnc_flag_2_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_3(le.orig_telephonenumber_3_Invalid),Base_Fields.InvalidMessage_orig_validationflag_3(le.orig_validationflag_3_Invalid),Base_Fields.InvalidMessage_orig_validationdate_3(le.orig_validationdate_3_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_3(le.orig_dma_tps_dnc_flag_3_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_4(le.orig_telephonenumber_4_Invalid),Base_Fields.InvalidMessage_orig_validationflag_4(le.orig_validationflag_4_Invalid),Base_Fields.InvalidMessage_orig_validationdate_4(le.orig_validationdate_4_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_4(le.orig_dma_tps_dnc_flag_4_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_5(le.orig_telephonenumber_5_Invalid),Base_Fields.InvalidMessage_orig_validationflag_5(le.orig_validationflag_5_Invalid),Base_Fields.InvalidMessage_orig_validationdate_5(le.orig_validationdate_5_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_5(le.orig_dma_tps_dnc_flag_5_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_6(le.orig_telephonenumber_6_Invalid),Base_Fields.InvalidMessage_orig_validationflag_6(le.orig_validationflag_6_Invalid),Base_Fields.InvalidMessage_orig_validationdate_6(le.orig_validationdate_6_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_6(le.orig_dma_tps_dnc_flag_6_Invalid),Base_Fields.InvalidMessage_orig_telephonenumber_7(le.orig_telephonenumber_7_Invalid),Base_Fields.InvalidMessage_orig_validationflag_7(le.orig_validationflag_7_Invalid),Base_Fields.InvalidMessage_orig_validationdate_7(le.orig_validationdate_7_Invalid),Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_7(le.orig_dma_tps_dnc_flag_7_Invalid),Base_Fields.InvalidMessage_orig_tot_phones(le.orig_tot_phones_Invalid),Base_Fields.InvalidMessage_orig_length_of_residence(le.orig_length_of_residence_Invalid),Base_Fields.InvalidMessage_orig_homeowner(le.orig_homeowner_Invalid),Base_Fields.InvalidMessage_orig_estimatedincome(le.orig_estimatedincome_Invalid),Base_Fields.InvalidMessage_orig_dwelling_type(le.orig_dwelling_type_Invalid),Base_Fields.InvalidMessage_orig_married(le.orig_married_Invalid),Base_Fields.InvalidMessage_orig_child(le.orig_child_Invalid),Base_Fields.InvalidMessage_orig_nbrchild(le.orig_nbrchild_Invalid),Base_Fields.InvalidMessage_orig_teencd(le.orig_teencd_Invalid),Base_Fields.InvalidMessage_orig_percent_range_black(le.orig_percent_range_black_Invalid),Base_Fields.InvalidMessage_orig_percent_range_white(le.orig_percent_range_white_Invalid),Base_Fields.InvalidMessage_orig_percent_range_hispanic(le.orig_percent_range_hispanic_Invalid),Base_Fields.InvalidMessage_orig_percent_range_asian(le.orig_percent_range_asian_Invalid),Base_Fields.InvalidMessage_orig_percent_range_english_speaking(le.orig_percent_range_english_speaking_Invalid),Base_Fields.InvalidMessage_orig_percnt_range_spanish_speaking(le.orig_percnt_range_spanish_speaking_Invalid),Base_Fields.InvalidMessage_orig_percent_range_asian_speaking(le.orig_percent_range_asian_speaking_Invalid),Base_Fields.InvalidMessage_orig_percent_range_sfdu(le.orig_percent_range_sfdu_Invalid),Base_Fields.InvalidMessage_orig_percent_range_mfdu(le.orig_percent_range_mfdu_Invalid),Base_Fields.InvalidMessage_orig_mhv(le.orig_mhv_Invalid),Base_Fields.InvalidMessage_orig_mor(le.orig_mor_Invalid),Base_Fields.InvalidMessage_orig_car(le.orig_car_Invalid),Base_Fields.InvalidMessage_orig_medschl(le.orig_medschl_Invalid),Base_Fields.InvalidMessage_orig_penetration_range_whitecollar(le.orig_penetration_range_whitecollar_Invalid),Base_Fields.InvalidMessage_orig_penetration_range_bluecollar(le.orig_penetration_range_bluecollar_Invalid),Base_Fields.InvalidMessage_orig_penetration_range_otheroccupation(le.orig_penetration_range_otheroccupation_Invalid),Base_Fields.InvalidMessage_orig_recdate(le.orig_recdate_Invalid),Base_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Base_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Base_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_clean_dob(le.clean_dob_Invalid),Base_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_tot_males_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_tot_females_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_house_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_street_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_strtype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_apttype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_aptnbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'QUOTES','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_z4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_vacant_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_time_zone_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_lat_long_assignment_level_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validationflag_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validationdate_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validation_flag_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validation_date_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validationflag_3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validationdate_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validationflag_4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validationdate_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validationflag_5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validationdate_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validationflag_6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validationdate_6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_telephonenumber_7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_validationflag_7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_validationdate_7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dma_tps_dnc_flag_7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_tot_phones_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_length_of_residence_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_homeowner_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_estimatedincome_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_dwelling_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_married_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_child_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_nbrchild_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_teencd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_black_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_white_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_hispanic_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_asian_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_english_speaking_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percnt_range_spanish_speaking_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_asian_speaking_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_sfdu_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_percent_range_mfdu_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_mhv_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_mor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_car_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_medschl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_penetration_range_whitecollar_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_penetration_range_bluecollar_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_penetration_range_otheroccupation_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_recdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_tot_males','orig_tot_females','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_state','orig_zip','orig_z4','orig_vacant','orig_time_zone','orig_lat_long_assignment_level','orig_telephonenumber_1','orig_validationflag_1','orig_validationdate_1','orig_dma_tps_dnc_flag_1','orig_telephonenumber_2','orig_validation_flag_2','orig_validation_date_2','orig_dma_tps_dnc_flag_2','orig_telephonenumber_3','orig_validationflag_3','orig_validationdate_3','orig_dma_tps_dnc_flag_3','orig_telephonenumber_4','orig_validationflag_4','orig_validationdate_4','orig_dma_tps_dnc_flag_4','orig_telephonenumber_5','orig_validationflag_5','orig_validationdate_5','orig_dma_tps_dnc_flag_5','orig_telephonenumber_6','orig_validationflag_6','orig_validationdate_6','orig_dma_tps_dnc_flag_6','orig_telephonenumber_7','orig_validationflag_7','orig_validationdate_7','orig_dma_tps_dnc_flag_7','orig_tot_phones','orig_length_of_residence','orig_homeowner','orig_estimatedincome','orig_dwelling_type','orig_married','orig_child','orig_nbrchild','orig_teencd','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_medschl','orig_penetration_range_whitecollar','orig_penetration_range_bluecollar','orig_penetration_range_otheroccupation','orig_recdate','name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','clean_phone','clean_dob','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alpha','invalid_alpha','invalid_alpha','invalid_suffix','invalid_gender','invalid_total_nbr','invalid_date','invalid_total_nbr','invalid_total_nbr','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_county_name','invalid_state_abbr','invalid_zip','invalid_zip4','invalid_indicator','invalid_time_zone','invalid_assignment_lvl','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_telephone','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_residence_len','invalid_homeowner','invalid_mhv','invalid_dwelling_type','invalid_indicator','invalid_indicator','invalid_child_num','invalid_indicator','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_mhv','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_residence_len','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_date','invalid_suffix','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_csz','invalid_csz','invalid_nums','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.orig_fname,(SALT38.StrType)le.orig_mname,(SALT38.StrType)le.orig_lname,(SALT38.StrType)le.orig_suffix,(SALT38.StrType)le.orig_gender,(SALT38.StrType)le.orig_age,(SALT38.StrType)le.orig_dob,(SALT38.StrType)le.orig_tot_males,(SALT38.StrType)le.orig_tot_females,(SALT38.StrType)le.orig_address,(SALT38.StrType)le.orig_house,(SALT38.StrType)le.orig_predir,(SALT38.StrType)le.orig_street,(SALT38.StrType)le.orig_strtype,(SALT38.StrType)le.orig_postdir,(SALT38.StrType)le.orig_apttype,(SALT38.StrType)le.orig_aptnbr,(SALT38.StrType)le.orig_city,(SALT38.StrType)le.orig_state,(SALT38.StrType)le.orig_zip,(SALT38.StrType)le.orig_z4,(SALT38.StrType)le.orig_vacant,(SALT38.StrType)le.orig_time_zone,(SALT38.StrType)le.orig_lat_long_assignment_level,(SALT38.StrType)le.orig_telephonenumber_1,(SALT38.StrType)le.orig_validationflag_1,(SALT38.StrType)le.orig_validationdate_1,(SALT38.StrType)le.orig_dma_tps_dnc_flag_1,(SALT38.StrType)le.orig_telephonenumber_2,(SALT38.StrType)le.orig_validation_flag_2,(SALT38.StrType)le.orig_validation_date_2,(SALT38.StrType)le.orig_dma_tps_dnc_flag_2,(SALT38.StrType)le.orig_telephonenumber_3,(SALT38.StrType)le.orig_validationflag_3,(SALT38.StrType)le.orig_validationdate_3,(SALT38.StrType)le.orig_dma_tps_dnc_flag_3,(SALT38.StrType)le.orig_telephonenumber_4,(SALT38.StrType)le.orig_validationflag_4,(SALT38.StrType)le.orig_validationdate_4,(SALT38.StrType)le.orig_dma_tps_dnc_flag_4,(SALT38.StrType)le.orig_telephonenumber_5,(SALT38.StrType)le.orig_validationflag_5,(SALT38.StrType)le.orig_validationdate_5,(SALT38.StrType)le.orig_dma_tps_dnc_flag_5,(SALT38.StrType)le.orig_telephonenumber_6,(SALT38.StrType)le.orig_validationflag_6,(SALT38.StrType)le.orig_validationdate_6,(SALT38.StrType)le.orig_dma_tps_dnc_flag_6,(SALT38.StrType)le.orig_telephonenumber_7,(SALT38.StrType)le.orig_validationflag_7,(SALT38.StrType)le.orig_validationdate_7,(SALT38.StrType)le.orig_dma_tps_dnc_flag_7,(SALT38.StrType)le.orig_tot_phones,(SALT38.StrType)le.orig_length_of_residence,(SALT38.StrType)le.orig_homeowner,(SALT38.StrType)le.orig_estimatedincome,(SALT38.StrType)le.orig_dwelling_type,(SALT38.StrType)le.orig_married,(SALT38.StrType)le.orig_child,(SALT38.StrType)le.orig_nbrchild,(SALT38.StrType)le.orig_teencd,(SALT38.StrType)le.orig_percent_range_black,(SALT38.StrType)le.orig_percent_range_white,(SALT38.StrType)le.orig_percent_range_hispanic,(SALT38.StrType)le.orig_percent_range_asian,(SALT38.StrType)le.orig_percent_range_english_speaking,(SALT38.StrType)le.orig_percnt_range_spanish_speaking,(SALT38.StrType)le.orig_percent_range_asian_speaking,(SALT38.StrType)le.orig_percent_range_sfdu,(SALT38.StrType)le.orig_percent_range_mfdu,(SALT38.StrType)le.orig_mhv,(SALT38.StrType)le.orig_mor,(SALT38.StrType)le.orig_car,(SALT38.StrType)le.orig_medschl,(SALT38.StrType)le.orig_penetration_range_whitecollar,(SALT38.StrType)le.orig_penetration_range_bluecollar,(SALT38.StrType)le.orig_penetration_range_otheroccupation,(SALT38.StrType)le.orig_recdate,(SALT38.StrType)le.name_suffix,(SALT38.StrType)le.prim_range,(SALT38.StrType)le.predir,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.addr_suffix,(SALT38.StrType)le.postdir,(SALT38.StrType)le.unit_desig,(SALT38.StrType)le.sec_range,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.clean_phone,(SALT38.StrType)le.clean_dob,(SALT38.StrType)le.date_first_seen,(SALT38.StrType)le.date_last_seen,(SALT38.StrType)le.date_vendor_first_reported,(SALT38.StrType)le.date_vendor_last_reported,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,94,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Infutor_NARC) prevDS = DATASET([], Base_Layout_Infutor_NARC), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_fname:invalid_alpha:ALLOW'
          ,'orig_mname:invalid_alpha:ALLOW'
          ,'orig_lname:invalid_alpha:ALLOW'
          ,'orig_suffix:invalid_suffix:ENUM'
          ,'orig_gender:invalid_gender:ENUM'
          ,'orig_age:invalid_total_nbr:ALLOW'
          ,'orig_dob:invalid_date:CUSTOM'
          ,'orig_tot_males:invalid_total_nbr:ALLOW'
          ,'orig_tot_females:invalid_total_nbr:ALLOW'
          ,'orig_address:invalid_address:ALLOW'
          ,'orig_house:invalid_address:ALLOW'
          ,'orig_predir:invalid_address:ALLOW'
          ,'orig_street:invalid_address:ALLOW'
          ,'orig_strtype:invalid_address:ALLOW'
          ,'orig_postdir:invalid_address:ALLOW'
          ,'orig_apttype:invalid_address:ALLOW'
          ,'orig_aptnbr:invalid_address:ALLOW'
          ,'orig_city:invalid_county_name:QUOTES','orig_city:invalid_county_name:ALLOW','orig_city:invalid_county_name:WORDS'
          ,'orig_state:invalid_state_abbr:CUSTOM'
          ,'orig_zip:invalid_zip:ALLOW','orig_zip:invalid_zip:LENGTH'
          ,'orig_z4:invalid_zip4:ALLOW','orig_z4:invalid_zip4:LENGTH'
          ,'orig_vacant:invalid_indicator:ENUM'
          ,'orig_time_zone:invalid_time_zone:ENUM'
          ,'orig_lat_long_assignment_level:invalid_assignment_lvl:ENUM'
          ,'orig_telephonenumber_1:invalid_telephone:ALLOW'
          ,'orig_validationflag_1:invalid_validation_flag:ENUM'
          ,'orig_validationdate_1:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_1:invalid_indicator:ENUM'
          ,'orig_telephonenumber_2:invalid_telephone:ALLOW'
          ,'orig_validation_flag_2:invalid_validation_flag:ENUM'
          ,'orig_validation_date_2:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_2:invalid_indicator:ENUM'
          ,'orig_telephonenumber_3:invalid_telephone:ALLOW'
          ,'orig_validationflag_3:invalid_validation_flag:ENUM'
          ,'orig_validationdate_3:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_3:invalid_indicator:ENUM'
          ,'orig_telephonenumber_4:invalid_telephone:ALLOW'
          ,'orig_validationflag_4:invalid_validation_flag:ENUM'
          ,'orig_validationdate_4:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_4:invalid_indicator:ENUM'
          ,'orig_telephonenumber_5:invalid_telephone:ALLOW'
          ,'orig_validationflag_5:invalid_validation_flag:ENUM'
          ,'orig_validationdate_5:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_5:invalid_indicator:ENUM'
          ,'orig_telephonenumber_6:invalid_telephone:ALLOW'
          ,'orig_validationflag_6:invalid_validation_flag:ENUM'
          ,'orig_validationdate_6:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_6:invalid_indicator:ENUM'
          ,'orig_telephonenumber_7:invalid_telephone:ALLOW'
          ,'orig_validationflag_7:invalid_validation_flag:ENUM'
          ,'orig_validationdate_7:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_7:invalid_indicator:ENUM'
          ,'orig_tot_phones:invalid_nums:ALLOW'
          ,'orig_length_of_residence:invalid_residence_len:ALLOW'
          ,'orig_homeowner:invalid_homeowner:ENUM'
          ,'orig_estimatedincome:invalid_mhv:ENUM'
          ,'orig_dwelling_type:invalid_dwelling_type:ENUM'
          ,'orig_married:invalid_indicator:ENUM'
          ,'orig_child:invalid_indicator:ENUM'
          ,'orig_nbrchild:invalid_child_num:ENUM'
          ,'orig_teencd:invalid_indicator:ENUM'
          ,'orig_percent_range_black:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_white:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_hispanic:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_asian:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_english_speaking:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percnt_range_spanish_speaking:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_asian_speaking:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_sfdu:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_percent_range_mfdu:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_mhv:invalid_mhv:ENUM'
          ,'orig_mor:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_car:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_medschl:invalid_residence_len:ALLOW'
          ,'orig_penetration_range_whitecollar:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_penetration_range_bluecollar:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_penetration_range_otheroccupation:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_recdate:invalid_date:CUSTOM'
          ,'name_suffix:invalid_suffix:ENUM'
          ,'prim_range:invalid_address:ALLOW'
          ,'predir:invalid_address:ALLOW'
          ,'prim_name:invalid_address:ALLOW'
          ,'addr_suffix:invalid_address:ALLOW'
          ,'postdir:invalid_address:ALLOW'
          ,'unit_desig:invalid_address:ALLOW'
          ,'sec_range:invalid_address:ALLOW'
          ,'p_city_name:invalid_csz:ALLOW'
          ,'v_city_name:invalid_csz:ALLOW'
          ,'clean_phone:invalid_nums:ALLOW'
          ,'clean_dob:invalid_date:CUSTOM'
          ,'date_first_seen:invalid_date:CUSTOM'
          ,'date_last_seen:invalid_date:CUSTOM'
          ,'date_vendor_first_reported:invalid_date:CUSTOM'
          ,'date_vendor_last_reported:invalid_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_orig_fname(1)
          ,Base_Fields.InvalidMessage_orig_mname(1)
          ,Base_Fields.InvalidMessage_orig_lname(1)
          ,Base_Fields.InvalidMessage_orig_suffix(1)
          ,Base_Fields.InvalidMessage_orig_gender(1)
          ,Base_Fields.InvalidMessage_orig_age(1)
          ,Base_Fields.InvalidMessage_orig_dob(1)
          ,Base_Fields.InvalidMessage_orig_tot_males(1)
          ,Base_Fields.InvalidMessage_orig_tot_females(1)
          ,Base_Fields.InvalidMessage_orig_address(1)
          ,Base_Fields.InvalidMessage_orig_house(1)
          ,Base_Fields.InvalidMessage_orig_predir(1)
          ,Base_Fields.InvalidMessage_orig_street(1)
          ,Base_Fields.InvalidMessage_orig_strtype(1)
          ,Base_Fields.InvalidMessage_orig_postdir(1)
          ,Base_Fields.InvalidMessage_orig_apttype(1)
          ,Base_Fields.InvalidMessage_orig_aptnbr(1)
          ,Base_Fields.InvalidMessage_orig_city(1),Base_Fields.InvalidMessage_orig_city(2),Base_Fields.InvalidMessage_orig_city(3)
          ,Base_Fields.InvalidMessage_orig_state(1)
          ,Base_Fields.InvalidMessage_orig_zip(1),Base_Fields.InvalidMessage_orig_zip(2)
          ,Base_Fields.InvalidMessage_orig_z4(1),Base_Fields.InvalidMessage_orig_z4(2)
          ,Base_Fields.InvalidMessage_orig_vacant(1)
          ,Base_Fields.InvalidMessage_orig_time_zone(1)
          ,Base_Fields.InvalidMessage_orig_lat_long_assignment_level(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_1(1)
          ,Base_Fields.InvalidMessage_orig_validationflag_1(1)
          ,Base_Fields.InvalidMessage_orig_validationdate_1(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_1(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_2(1)
          ,Base_Fields.InvalidMessage_orig_validation_flag_2(1)
          ,Base_Fields.InvalidMessage_orig_validation_date_2(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_2(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_3(1)
          ,Base_Fields.InvalidMessage_orig_validationflag_3(1)
          ,Base_Fields.InvalidMessage_orig_validationdate_3(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_3(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_4(1)
          ,Base_Fields.InvalidMessage_orig_validationflag_4(1)
          ,Base_Fields.InvalidMessage_orig_validationdate_4(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_4(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_5(1)
          ,Base_Fields.InvalidMessage_orig_validationflag_5(1)
          ,Base_Fields.InvalidMessage_orig_validationdate_5(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_5(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_6(1)
          ,Base_Fields.InvalidMessage_orig_validationflag_6(1)
          ,Base_Fields.InvalidMessage_orig_validationdate_6(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_6(1)
          ,Base_Fields.InvalidMessage_orig_telephonenumber_7(1)
          ,Base_Fields.InvalidMessage_orig_validationflag_7(1)
          ,Base_Fields.InvalidMessage_orig_validationdate_7(1)
          ,Base_Fields.InvalidMessage_orig_dma_tps_dnc_flag_7(1)
          ,Base_Fields.InvalidMessage_orig_tot_phones(1)
          ,Base_Fields.InvalidMessage_orig_length_of_residence(1)
          ,Base_Fields.InvalidMessage_orig_homeowner(1)
          ,Base_Fields.InvalidMessage_orig_estimatedincome(1)
          ,Base_Fields.InvalidMessage_orig_dwelling_type(1)
          ,Base_Fields.InvalidMessage_orig_married(1)
          ,Base_Fields.InvalidMessage_orig_child(1)
          ,Base_Fields.InvalidMessage_orig_nbrchild(1)
          ,Base_Fields.InvalidMessage_orig_teencd(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_black(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_white(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_hispanic(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_asian(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_english_speaking(1)
          ,Base_Fields.InvalidMessage_orig_percnt_range_spanish_speaking(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_asian_speaking(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_sfdu(1)
          ,Base_Fields.InvalidMessage_orig_percent_range_mfdu(1)
          ,Base_Fields.InvalidMessage_orig_mhv(1)
          ,Base_Fields.InvalidMessage_orig_mor(1)
          ,Base_Fields.InvalidMessage_orig_car(1)
          ,Base_Fields.InvalidMessage_orig_medschl(1)
          ,Base_Fields.InvalidMessage_orig_penetration_range_whitecollar(1)
          ,Base_Fields.InvalidMessage_orig_penetration_range_bluecollar(1)
          ,Base_Fields.InvalidMessage_orig_penetration_range_otheroccupation(1)
          ,Base_Fields.InvalidMessage_orig_recdate(1)
          ,Base_Fields.InvalidMessage_name_suffix(1)
          ,Base_Fields.InvalidMessage_prim_range(1)
          ,Base_Fields.InvalidMessage_predir(1)
          ,Base_Fields.InvalidMessage_prim_name(1)
          ,Base_Fields.InvalidMessage_addr_suffix(1)
          ,Base_Fields.InvalidMessage_postdir(1)
          ,Base_Fields.InvalidMessage_unit_desig(1)
          ,Base_Fields.InvalidMessage_sec_range(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_clean_dob(1)
          ,Base_Fields.InvalidMessage_date_first_seen(1)
          ,Base_Fields.InvalidMessage_date_last_seen(1)
          ,Base_Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_date_vendor_last_reported(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_fname_ALLOW_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount
          ,le.orig_suffix_ENUM_ErrorCount
          ,le.orig_gender_ENUM_ErrorCount
          ,le.orig_age_ALLOW_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_tot_males_ALLOW_ErrorCount
          ,le.orig_tot_females_ALLOW_ErrorCount
          ,le.orig_address_ALLOW_ErrorCount
          ,le.orig_house_ALLOW_ErrorCount
          ,le.orig_predir_ALLOW_ErrorCount
          ,le.orig_street_ALLOW_ErrorCount
          ,le.orig_strtype_ALLOW_ErrorCount
          ,le.orig_postdir_ALLOW_ErrorCount
          ,le.orig_apttype_ALLOW_ErrorCount
          ,le.orig_aptnbr_ALLOW_ErrorCount
          ,le.orig_city_QUOTES_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_z4_ALLOW_ErrorCount,le.orig_z4_LENGTH_ErrorCount
          ,le.orig_vacant_ENUM_ErrorCount
          ,le.orig_time_zone_ENUM_ErrorCount
          ,le.orig_lat_long_assignment_level_ENUM_ErrorCount
          ,le.orig_telephonenumber_1_ALLOW_ErrorCount
          ,le.orig_validationflag_1_ENUM_ErrorCount
          ,le.orig_validationdate_1_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_1_ENUM_ErrorCount
          ,le.orig_telephonenumber_2_ALLOW_ErrorCount
          ,le.orig_validation_flag_2_ENUM_ErrorCount
          ,le.orig_validation_date_2_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_2_ENUM_ErrorCount
          ,le.orig_telephonenumber_3_ALLOW_ErrorCount
          ,le.orig_validationflag_3_ENUM_ErrorCount
          ,le.orig_validationdate_3_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_3_ENUM_ErrorCount
          ,le.orig_telephonenumber_4_ALLOW_ErrorCount
          ,le.orig_validationflag_4_ENUM_ErrorCount
          ,le.orig_validationdate_4_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_4_ENUM_ErrorCount
          ,le.orig_telephonenumber_5_ALLOW_ErrorCount
          ,le.orig_validationflag_5_ENUM_ErrorCount
          ,le.orig_validationdate_5_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_5_ENUM_ErrorCount
          ,le.orig_telephonenumber_6_ALLOW_ErrorCount
          ,le.orig_validationflag_6_ENUM_ErrorCount
          ,le.orig_validationdate_6_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_6_ENUM_ErrorCount
          ,le.orig_telephonenumber_7_ALLOW_ErrorCount
          ,le.orig_validationflag_7_ENUM_ErrorCount
          ,le.orig_validationdate_7_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_7_ENUM_ErrorCount
          ,le.orig_tot_phones_ALLOW_ErrorCount
          ,le.orig_length_of_residence_ALLOW_ErrorCount
          ,le.orig_homeowner_ENUM_ErrorCount
          ,le.orig_estimatedincome_ENUM_ErrorCount
          ,le.orig_dwelling_type_ENUM_ErrorCount
          ,le.orig_married_ENUM_ErrorCount
          ,le.orig_child_ENUM_ErrorCount
          ,le.orig_nbrchild_ENUM_ErrorCount
          ,le.orig_teencd_ENUM_ErrorCount
          ,le.orig_percent_range_black_ENUM_ErrorCount
          ,le.orig_percent_range_white_ENUM_ErrorCount
          ,le.orig_percent_range_hispanic_ENUM_ErrorCount
          ,le.orig_percent_range_asian_ENUM_ErrorCount
          ,le.orig_percent_range_english_speaking_ENUM_ErrorCount
          ,le.orig_percnt_range_spanish_speaking_ENUM_ErrorCount
          ,le.orig_percent_range_asian_speaking_ENUM_ErrorCount
          ,le.orig_percent_range_sfdu_ENUM_ErrorCount
          ,le.orig_percent_range_mfdu_ENUM_ErrorCount
          ,le.orig_mhv_ENUM_ErrorCount
          ,le.orig_mor_ENUM_ErrorCount
          ,le.orig_car_ENUM_ErrorCount
          ,le.orig_medschl_ALLOW_ErrorCount
          ,le.orig_penetration_range_whitecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_bluecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_otheroccupation_ENUM_ErrorCount
          ,le.orig_recdate_CUSTOM_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.clean_phone_ALLOW_ErrorCount
          ,le.clean_dob_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.orig_fname_ALLOW_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount
          ,le.orig_suffix_ENUM_ErrorCount
          ,le.orig_gender_ENUM_ErrorCount
          ,le.orig_age_ALLOW_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_tot_males_ALLOW_ErrorCount
          ,le.orig_tot_females_ALLOW_ErrorCount
          ,le.orig_address_ALLOW_ErrorCount
          ,le.orig_house_ALLOW_ErrorCount
          ,le.orig_predir_ALLOW_ErrorCount
          ,le.orig_street_ALLOW_ErrorCount
          ,le.orig_strtype_ALLOW_ErrorCount
          ,le.orig_postdir_ALLOW_ErrorCount
          ,le.orig_apttype_ALLOW_ErrorCount
          ,le.orig_aptnbr_ALLOW_ErrorCount
          ,le.orig_city_QUOTES_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_z4_ALLOW_ErrorCount,le.orig_z4_LENGTH_ErrorCount
          ,le.orig_vacant_ENUM_ErrorCount
          ,le.orig_time_zone_ENUM_ErrorCount
          ,le.orig_lat_long_assignment_level_ENUM_ErrorCount
          ,le.orig_telephonenumber_1_ALLOW_ErrorCount
          ,le.orig_validationflag_1_ENUM_ErrorCount
          ,le.orig_validationdate_1_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_1_ENUM_ErrorCount
          ,le.orig_telephonenumber_2_ALLOW_ErrorCount
          ,le.orig_validation_flag_2_ENUM_ErrorCount
          ,le.orig_validation_date_2_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_2_ENUM_ErrorCount
          ,le.orig_telephonenumber_3_ALLOW_ErrorCount
          ,le.orig_validationflag_3_ENUM_ErrorCount
          ,le.orig_validationdate_3_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_3_ENUM_ErrorCount
          ,le.orig_telephonenumber_4_ALLOW_ErrorCount
          ,le.orig_validationflag_4_ENUM_ErrorCount
          ,le.orig_validationdate_4_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_4_ENUM_ErrorCount
          ,le.orig_telephonenumber_5_ALLOW_ErrorCount
          ,le.orig_validationflag_5_ENUM_ErrorCount
          ,le.orig_validationdate_5_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_5_ENUM_ErrorCount
          ,le.orig_telephonenumber_6_ALLOW_ErrorCount
          ,le.orig_validationflag_6_ENUM_ErrorCount
          ,le.orig_validationdate_6_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_6_ENUM_ErrorCount
          ,le.orig_telephonenumber_7_ALLOW_ErrorCount
          ,le.orig_validationflag_7_ENUM_ErrorCount
          ,le.orig_validationdate_7_CUSTOM_ErrorCount
          ,le.orig_dma_tps_dnc_flag_7_ENUM_ErrorCount
          ,le.orig_tot_phones_ALLOW_ErrorCount
          ,le.orig_length_of_residence_ALLOW_ErrorCount
          ,le.orig_homeowner_ENUM_ErrorCount
          ,le.orig_estimatedincome_ENUM_ErrorCount
          ,le.orig_dwelling_type_ENUM_ErrorCount
          ,le.orig_married_ENUM_ErrorCount
          ,le.orig_child_ENUM_ErrorCount
          ,le.orig_nbrchild_ENUM_ErrorCount
          ,le.orig_teencd_ENUM_ErrorCount
          ,le.orig_percent_range_black_ENUM_ErrorCount
          ,le.orig_percent_range_white_ENUM_ErrorCount
          ,le.orig_percent_range_hispanic_ENUM_ErrorCount
          ,le.orig_percent_range_asian_ENUM_ErrorCount
          ,le.orig_percent_range_english_speaking_ENUM_ErrorCount
          ,le.orig_percnt_range_spanish_speaking_ENUM_ErrorCount
          ,le.orig_percent_range_asian_speaking_ENUM_ErrorCount
          ,le.orig_percent_range_sfdu_ENUM_ErrorCount
          ,le.orig_percent_range_mfdu_ENUM_ErrorCount
          ,le.orig_mhv_ENUM_ErrorCount
          ,le.orig_mor_ENUM_ErrorCount
          ,le.orig_car_ENUM_ErrorCount
          ,le.orig_medschl_ALLOW_ErrorCount
          ,le.orig_penetration_range_whitecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_bluecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_otheroccupation_ENUM_ErrorCount
          ,le.orig_recdate_CUSTOM_ErrorCount
          ,le.name_suffix_ENUM_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.clean_phone_ALLOW_ErrorCount
          ,le.clean_dob_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Infutor_NARC));
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
          ,'orig_hhid:' + getFieldTypeText(h.orig_hhid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pid:' + getFieldTypeText(h.orig_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_suffix:' + getFieldTypeText(h.orig_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_gender:' + getFieldTypeText(h.orig_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_age:' + getFieldTypeText(h.orig_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_hhnbr:' + getFieldTypeText(h.orig_hhnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_tot_males:' + getFieldTypeText(h.orig_tot_males) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_tot_females:' + getFieldTypeText(h.orig_tot_females) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_addrid:' + getFieldTypeText(h.orig_addrid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_house:' + getFieldTypeText(h.orig_house) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_predir:' + getFieldTypeText(h.orig_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street:' + getFieldTypeText(h.orig_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_strtype:' + getFieldTypeText(h.orig_strtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_postdir:' + getFieldTypeText(h.orig_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_apttype:' + getFieldTypeText(h.orig_apttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_aptnbr:' + getFieldTypeText(h.orig_aptnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_z4:' + getFieldTypeText(h.orig_z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dpc:' + getFieldTypeText(h.orig_dpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_z4type:' + getFieldTypeText(h.orig_z4type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_crte:' + getFieldTypeText(h.orig_crte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dpv:' + getFieldTypeText(h.orig_dpv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_vacant:' + getFieldTypeText(h.orig_vacant) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_msa:' + getFieldTypeText(h.orig_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_cbsa:' + getFieldTypeText(h.orig_cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_county_code:' + getFieldTypeText(h.orig_county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_time_zone:' + getFieldTypeText(h.orig_time_zone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_daylight_savings:' + getFieldTypeText(h.orig_daylight_savings) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lat_long_assignment_level:' + getFieldTypeText(h.orig_lat_long_assignment_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_latitude:' + getFieldTypeText(h.orig_latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_longitude:' + getFieldTypeText(h.orig_longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_1:' + getFieldTypeText(h.orig_telephonenumber_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationflag_1:' + getFieldTypeText(h.orig_validationflag_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationdate_1:' + getFieldTypeText(h.orig_validationdate_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_1:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_2:' + getFieldTypeText(h.orig_telephonenumber_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validation_flag_2:' + getFieldTypeText(h.orig_validation_flag_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validation_date_2:' + getFieldTypeText(h.orig_validation_date_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_2:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_3:' + getFieldTypeText(h.orig_telephonenumber_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationflag_3:' + getFieldTypeText(h.orig_validationflag_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationdate_3:' + getFieldTypeText(h.orig_validationdate_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_3:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_4:' + getFieldTypeText(h.orig_telephonenumber_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationflag_4:' + getFieldTypeText(h.orig_validationflag_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationdate_4:' + getFieldTypeText(h.orig_validationdate_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_4:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_5:' + getFieldTypeText(h.orig_telephonenumber_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationflag_5:' + getFieldTypeText(h.orig_validationflag_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationdate_5:' + getFieldTypeText(h.orig_validationdate_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_5:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_6:' + getFieldTypeText(h.orig_telephonenumber_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationflag_6:' + getFieldTypeText(h.orig_validationflag_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationdate_6:' + getFieldTypeText(h.orig_validationdate_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_6:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephonenumber_7:' + getFieldTypeText(h.orig_telephonenumber_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationflag_7:' + getFieldTypeText(h.orig_validationflag_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_validationdate_7:' + getFieldTypeText(h.orig_validationdate_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_7:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_tot_phones:' + getFieldTypeText(h.orig_tot_phones) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_length_of_residence:' + getFieldTypeText(h.orig_length_of_residence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_homeowner:' + getFieldTypeText(h.orig_homeowner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_estimatedincome:' + getFieldTypeText(h.orig_estimatedincome) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dwelling_type:' + getFieldTypeText(h.orig_dwelling_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_married:' + getFieldTypeText(h.orig_married) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_child:' + getFieldTypeText(h.orig_child) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_nbrchild:' + getFieldTypeText(h.orig_nbrchild) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_teencd:' + getFieldTypeText(h.orig_teencd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_black:' + getFieldTypeText(h.orig_percent_range_black) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_white:' + getFieldTypeText(h.orig_percent_range_white) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_hispanic:' + getFieldTypeText(h.orig_percent_range_hispanic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_asian:' + getFieldTypeText(h.orig_percent_range_asian) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_english_speaking:' + getFieldTypeText(h.orig_percent_range_english_speaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percnt_range_spanish_speaking:' + getFieldTypeText(h.orig_percnt_range_spanish_speaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_asian_speaking:' + getFieldTypeText(h.orig_percent_range_asian_speaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_sfdu:' + getFieldTypeText(h.orig_percent_range_sfdu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_mfdu:' + getFieldTypeText(h.orig_percent_range_mfdu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mhv:' + getFieldTypeText(h.orig_mhv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mor:' + getFieldTypeText(h.orig_mor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_car:' + getFieldTypeText(h.orig_car) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_medschl:' + getFieldTypeText(h.orig_medschl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_penetration_range_whitecollar:' + getFieldTypeText(h.orig_penetration_range_whitecollar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_penetration_range_bluecollar:' + getFieldTypeText(h.orig_penetration_range_bluecollar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_penetration_range_otheroccupation:' + getFieldTypeText(h.orig_penetration_range_otheroccupation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_demolevel:' + getFieldTypeText(h.orig_demolevel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_recdate:' + getFieldTypeText(h.orig_recdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_st:' + getFieldTypeText(h.fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dob:' + getFieldTypeText(h.clean_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src:' + getFieldTypeText(h.src) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Lexhhid:' + getFieldTypeText(h.Lexhhid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_hhid_cnt
          ,le.populated_orig_pid_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_suffix_cnt
          ,le.populated_orig_gender_cnt
          ,le.populated_orig_age_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_hhnbr_cnt
          ,le.populated_orig_tot_males_cnt
          ,le.populated_orig_tot_females_cnt
          ,le.populated_orig_addrid_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_house_cnt
          ,le.populated_orig_predir_cnt
          ,le.populated_orig_street_cnt
          ,le.populated_orig_strtype_cnt
          ,le.populated_orig_postdir_cnt
          ,le.populated_orig_apttype_cnt
          ,le.populated_orig_aptnbr_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_z4_cnt
          ,le.populated_orig_dpc_cnt
          ,le.populated_orig_z4type_cnt
          ,le.populated_orig_crte_cnt
          ,le.populated_orig_dpv_cnt
          ,le.populated_orig_vacant_cnt
          ,le.populated_orig_msa_cnt
          ,le.populated_orig_cbsa_cnt
          ,le.populated_orig_county_code_cnt
          ,le.populated_orig_time_zone_cnt
          ,le.populated_orig_daylight_savings_cnt
          ,le.populated_orig_lat_long_assignment_level_cnt
          ,le.populated_orig_latitude_cnt
          ,le.populated_orig_longitude_cnt
          ,le.populated_orig_telephonenumber_1_cnt
          ,le.populated_orig_validationflag_1_cnt
          ,le.populated_orig_validationdate_1_cnt
          ,le.populated_orig_dma_tps_dnc_flag_1_cnt
          ,le.populated_orig_telephonenumber_2_cnt
          ,le.populated_orig_validation_flag_2_cnt
          ,le.populated_orig_validation_date_2_cnt
          ,le.populated_orig_dma_tps_dnc_flag_2_cnt
          ,le.populated_orig_telephonenumber_3_cnt
          ,le.populated_orig_validationflag_3_cnt
          ,le.populated_orig_validationdate_3_cnt
          ,le.populated_orig_dma_tps_dnc_flag_3_cnt
          ,le.populated_orig_telephonenumber_4_cnt
          ,le.populated_orig_validationflag_4_cnt
          ,le.populated_orig_validationdate_4_cnt
          ,le.populated_orig_dma_tps_dnc_flag_4_cnt
          ,le.populated_orig_telephonenumber_5_cnt
          ,le.populated_orig_validationflag_5_cnt
          ,le.populated_orig_validationdate_5_cnt
          ,le.populated_orig_dma_tps_dnc_flag_5_cnt
          ,le.populated_orig_telephonenumber_6_cnt
          ,le.populated_orig_validationflag_6_cnt
          ,le.populated_orig_validationdate_6_cnt
          ,le.populated_orig_dma_tps_dnc_flag_6_cnt
          ,le.populated_orig_telephonenumber_7_cnt
          ,le.populated_orig_validationflag_7_cnt
          ,le.populated_orig_validationdate_7_cnt
          ,le.populated_orig_dma_tps_dnc_flag_7_cnt
          ,le.populated_orig_tot_phones_cnt
          ,le.populated_orig_length_of_residence_cnt
          ,le.populated_orig_homeowner_cnt
          ,le.populated_orig_estimatedincome_cnt
          ,le.populated_orig_dwelling_type_cnt
          ,le.populated_orig_married_cnt
          ,le.populated_orig_child_cnt
          ,le.populated_orig_nbrchild_cnt
          ,le.populated_orig_teencd_cnt
          ,le.populated_orig_percent_range_black_cnt
          ,le.populated_orig_percent_range_white_cnt
          ,le.populated_orig_percent_range_hispanic_cnt
          ,le.populated_orig_percent_range_asian_cnt
          ,le.populated_orig_percent_range_english_speaking_cnt
          ,le.populated_orig_percnt_range_spanish_speaking_cnt
          ,le.populated_orig_percent_range_asian_speaking_cnt
          ,le.populated_orig_percent_range_sfdu_cnt
          ,le.populated_orig_percent_range_mfdu_cnt
          ,le.populated_orig_mhv_cnt
          ,le.populated_orig_mor_cnt
          ,le.populated_orig_car_cnt
          ,le.populated_orig_medschl_cnt
          ,le.populated_orig_penetration_range_whitecollar_cnt
          ,le.populated_orig_penetration_range_bluecollar_cnt
          ,le.populated_orig_penetration_range_otheroccupation_cnt
          ,le.populated_orig_demolevel_cnt
          ,le.populated_orig_recdate_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
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
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_clean_dob_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
          ,le.populated_src_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_Lexhhid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_hhid_pcnt
          ,le.populated_orig_pid_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_suffix_pcnt
          ,le.populated_orig_gender_pcnt
          ,le.populated_orig_age_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_hhnbr_pcnt
          ,le.populated_orig_tot_males_pcnt
          ,le.populated_orig_tot_females_pcnt
          ,le.populated_orig_addrid_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_house_pcnt
          ,le.populated_orig_predir_pcnt
          ,le.populated_orig_street_pcnt
          ,le.populated_orig_strtype_pcnt
          ,le.populated_orig_postdir_pcnt
          ,le.populated_orig_apttype_pcnt
          ,le.populated_orig_aptnbr_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_z4_pcnt
          ,le.populated_orig_dpc_pcnt
          ,le.populated_orig_z4type_pcnt
          ,le.populated_orig_crte_pcnt
          ,le.populated_orig_dpv_pcnt
          ,le.populated_orig_vacant_pcnt
          ,le.populated_orig_msa_pcnt
          ,le.populated_orig_cbsa_pcnt
          ,le.populated_orig_county_code_pcnt
          ,le.populated_orig_time_zone_pcnt
          ,le.populated_orig_daylight_savings_pcnt
          ,le.populated_orig_lat_long_assignment_level_pcnt
          ,le.populated_orig_latitude_pcnt
          ,le.populated_orig_longitude_pcnt
          ,le.populated_orig_telephonenumber_1_pcnt
          ,le.populated_orig_validationflag_1_pcnt
          ,le.populated_orig_validationdate_1_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_1_pcnt
          ,le.populated_orig_telephonenumber_2_pcnt
          ,le.populated_orig_validation_flag_2_pcnt
          ,le.populated_orig_validation_date_2_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_2_pcnt
          ,le.populated_orig_telephonenumber_3_pcnt
          ,le.populated_orig_validationflag_3_pcnt
          ,le.populated_orig_validationdate_3_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_3_pcnt
          ,le.populated_orig_telephonenumber_4_pcnt
          ,le.populated_orig_validationflag_4_pcnt
          ,le.populated_orig_validationdate_4_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_4_pcnt
          ,le.populated_orig_telephonenumber_5_pcnt
          ,le.populated_orig_validationflag_5_pcnt
          ,le.populated_orig_validationdate_5_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_5_pcnt
          ,le.populated_orig_telephonenumber_6_pcnt
          ,le.populated_orig_validationflag_6_pcnt
          ,le.populated_orig_validationdate_6_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_6_pcnt
          ,le.populated_orig_telephonenumber_7_pcnt
          ,le.populated_orig_validationflag_7_pcnt
          ,le.populated_orig_validationdate_7_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_7_pcnt
          ,le.populated_orig_tot_phones_pcnt
          ,le.populated_orig_length_of_residence_pcnt
          ,le.populated_orig_homeowner_pcnt
          ,le.populated_orig_estimatedincome_pcnt
          ,le.populated_orig_dwelling_type_pcnt
          ,le.populated_orig_married_pcnt
          ,le.populated_orig_child_pcnt
          ,le.populated_orig_nbrchild_pcnt
          ,le.populated_orig_teencd_pcnt
          ,le.populated_orig_percent_range_black_pcnt
          ,le.populated_orig_percent_range_white_pcnt
          ,le.populated_orig_percent_range_hispanic_pcnt
          ,le.populated_orig_percent_range_asian_pcnt
          ,le.populated_orig_percent_range_english_speaking_pcnt
          ,le.populated_orig_percnt_range_spanish_speaking_pcnt
          ,le.populated_orig_percent_range_asian_speaking_pcnt
          ,le.populated_orig_percent_range_sfdu_pcnt
          ,le.populated_orig_percent_range_mfdu_pcnt
          ,le.populated_orig_mhv_pcnt
          ,le.populated_orig_mor_pcnt
          ,le.populated_orig_car_pcnt
          ,le.populated_orig_medschl_pcnt
          ,le.populated_orig_penetration_range_whitecollar_pcnt
          ,le.populated_orig_penetration_range_bluecollar_pcnt
          ,le.populated_orig_penetration_range_otheroccupation_pcnt
          ,le.populated_orig_demolevel_pcnt
          ,le.populated_orig_recdate_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
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
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_clean_dob_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_src_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_Lexhhid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,137,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Infutor_NARC));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),137,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_Infutor_NARC) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Infutor_NARC, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
