IMPORT ut,SALT32;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Raw_Layout_Infutor_NARC)
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 orig_gender_Invalid;
    UNSIGNED1 orig_age_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_hhnbr_Invalid;
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
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_z4_Invalid;
    UNSIGNED1 orig_vacant_Invalid;
    UNSIGNED1 orig_time_zone_Invalid;
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
    UNSIGNED1 orig_penetration_range_whitecollar_Invalid;
    UNSIGNED1 orig_penetration_range_bluecollar_Invalid;
    UNSIGNED1 orig_penetration_range_otheroccupation_Invalid;
    UNSIGNED1 orig_recdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Raw_Layout_Infutor_NARC)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Raw_Layout_Infutor_NARC) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_fname_Invalid := Raw_Fields.InValid_orig_fname((SALT32.StrType)le.orig_fname);
    SELF.orig_mname_Invalid := Raw_Fields.InValid_orig_mname((SALT32.StrType)le.orig_mname);
    SELF.orig_lname_Invalid := Raw_Fields.InValid_orig_lname((SALT32.StrType)le.orig_lname);
    SELF.orig_suffix_Invalid := Raw_Fields.InValid_orig_suffix((SALT32.StrType)le.orig_suffix);
    SELF.orig_gender_Invalid := Raw_Fields.InValid_orig_gender((SALT32.StrType)le.orig_gender);
    SELF.orig_age_Invalid := Raw_Fields.InValid_orig_age((SALT32.StrType)le.orig_age);
    SELF.orig_dob_Invalid := Raw_Fields.InValid_orig_dob((SALT32.StrType)le.orig_dob);
    SELF.orig_hhnbr_Invalid := Raw_Fields.InValid_orig_hhnbr((SALT32.StrType)le.orig_hhnbr);
    SELF.orig_tot_males_Invalid := Raw_Fields.InValid_orig_tot_males((SALT32.StrType)le.orig_tot_males);
    SELF.orig_tot_females_Invalid := Raw_Fields.InValid_orig_tot_females((SALT32.StrType)le.orig_tot_females);
    SELF.orig_address_Invalid := Raw_Fields.InValid_orig_address((SALT32.StrType)le.orig_address);
    SELF.orig_house_Invalid := Raw_Fields.InValid_orig_house((SALT32.StrType)le.orig_house);
    SELF.orig_predir_Invalid := Raw_Fields.InValid_orig_predir((SALT32.StrType)le.orig_predir);
    SELF.orig_street_Invalid := Raw_Fields.InValid_orig_street((SALT32.StrType)le.orig_street);
    SELF.orig_strtype_Invalid := Raw_Fields.InValid_orig_strtype((SALT32.StrType)le.orig_strtype);
    SELF.orig_postdir_Invalid := Raw_Fields.InValid_orig_postdir((SALT32.StrType)le.orig_postdir);
    SELF.orig_apttype_Invalid := Raw_Fields.InValid_orig_apttype((SALT32.StrType)le.orig_apttype);
    SELF.orig_aptnbr_Invalid := Raw_Fields.InValid_orig_aptnbr((SALT32.StrType)le.orig_aptnbr);
    SELF.orig_city_Invalid := Raw_Fields.InValid_orig_city((SALT32.StrType)le.orig_city);
    SELF.orig_zip_Invalid := Raw_Fields.InValid_orig_zip((SALT32.StrType)le.orig_zip);
    SELF.orig_z4_Invalid := Raw_Fields.InValid_orig_z4((SALT32.StrType)le.orig_z4);
    SELF.orig_vacant_Invalid := Raw_Fields.InValid_orig_vacant((SALT32.StrType)le.orig_vacant);
    SELF.orig_time_zone_Invalid := Raw_Fields.InValid_orig_time_zone((SALT32.StrType)le.orig_time_zone);
    SELF.orig_telephonenumber_1_Invalid := Raw_Fields.InValid_orig_telephonenumber_1((SALT32.StrType)le.orig_telephonenumber_1);
    SELF.orig_validationflag_1_Invalid := Raw_Fields.InValid_orig_validationflag_1((SALT32.StrType)le.orig_validationflag_1);
    SELF.orig_validationdate_1_Invalid := Raw_Fields.InValid_orig_validationdate_1((SALT32.StrType)le.orig_validationdate_1);
    SELF.orig_dma_tps_dnc_flag_1_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_1((SALT32.StrType)le.orig_dma_tps_dnc_flag_1);
    SELF.orig_telephonenumber_2_Invalid := Raw_Fields.InValid_orig_telephonenumber_2((SALT32.StrType)le.orig_telephonenumber_2);
    SELF.orig_validation_flag_2_Invalid := Raw_Fields.InValid_orig_validation_flag_2((SALT32.StrType)le.orig_validation_flag_2);
    SELF.orig_validation_date_2_Invalid := Raw_Fields.InValid_orig_validation_date_2((SALT32.StrType)le.orig_validation_date_2);
    SELF.orig_dma_tps_dnc_flag_2_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_2((SALT32.StrType)le.orig_dma_tps_dnc_flag_2);
    SELF.orig_telephonenumber_3_Invalid := Raw_Fields.InValid_orig_telephonenumber_3((SALT32.StrType)le.orig_telephonenumber_3);
    SELF.orig_validationflag_3_Invalid := Raw_Fields.InValid_orig_validationflag_3((SALT32.StrType)le.orig_validationflag_3);
    SELF.orig_validationdate_3_Invalid := Raw_Fields.InValid_orig_validationdate_3((SALT32.StrType)le.orig_validationdate_3);
    SELF.orig_dma_tps_dnc_flag_3_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_3((SALT32.StrType)le.orig_dma_tps_dnc_flag_3);
    SELF.orig_telephonenumber_4_Invalid := Raw_Fields.InValid_orig_telephonenumber_4((SALT32.StrType)le.orig_telephonenumber_4);
    SELF.orig_validationflag_4_Invalid := Raw_Fields.InValid_orig_validationflag_4((SALT32.StrType)le.orig_validationflag_4);
    SELF.orig_validationdate_4_Invalid := Raw_Fields.InValid_orig_validationdate_4((SALT32.StrType)le.orig_validationdate_4);
    SELF.orig_dma_tps_dnc_flag_4_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_4((SALT32.StrType)le.orig_dma_tps_dnc_flag_4);
    SELF.orig_telephonenumber_5_Invalid := Raw_Fields.InValid_orig_telephonenumber_5((SALT32.StrType)le.orig_telephonenumber_5);
    SELF.orig_validationflag_5_Invalid := Raw_Fields.InValid_orig_validationflag_5((SALT32.StrType)le.orig_validationflag_5);
    SELF.orig_validationdate_5_Invalid := Raw_Fields.InValid_orig_validationdate_5((SALT32.StrType)le.orig_validationdate_5);
    SELF.orig_dma_tps_dnc_flag_5_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_5((SALT32.StrType)le.orig_dma_tps_dnc_flag_5);
    SELF.orig_telephonenumber_6_Invalid := Raw_Fields.InValid_orig_telephonenumber_6((SALT32.StrType)le.orig_telephonenumber_6);
    SELF.orig_validationflag_6_Invalid := Raw_Fields.InValid_orig_validationflag_6((SALT32.StrType)le.orig_validationflag_6);
    SELF.orig_validationdate_6_Invalid := Raw_Fields.InValid_orig_validationdate_6((SALT32.StrType)le.orig_validationdate_6);
    SELF.orig_dma_tps_dnc_flag_6_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_6((SALT32.StrType)le.orig_dma_tps_dnc_flag_6);
    SELF.orig_telephonenumber_7_Invalid := Raw_Fields.InValid_orig_telephonenumber_7((SALT32.StrType)le.orig_telephonenumber_7);
    SELF.orig_validationflag_7_Invalid := Raw_Fields.InValid_orig_validationflag_7((SALT32.StrType)le.orig_validationflag_7);
    SELF.orig_validationdate_7_Invalid := Raw_Fields.InValid_orig_validationdate_7((SALT32.StrType)le.orig_validationdate_7);
    SELF.orig_dma_tps_dnc_flag_7_Invalid := Raw_Fields.InValid_orig_dma_tps_dnc_flag_7((SALT32.StrType)le.orig_dma_tps_dnc_flag_7);
    SELF.orig_tot_phones_Invalid := Raw_Fields.InValid_orig_tot_phones((SALT32.StrType)le.orig_tot_phones);
    SELF.orig_length_of_residence_Invalid := Raw_Fields.InValid_orig_length_of_residence((SALT32.StrType)le.orig_length_of_residence);
    SELF.orig_homeowner_Invalid := Raw_Fields.InValid_orig_homeowner((SALT32.StrType)le.orig_homeowner);
    SELF.orig_estimatedincome_Invalid := Raw_Fields.InValid_orig_estimatedincome((SALT32.StrType)le.orig_estimatedincome);
    SELF.orig_dwelling_type_Invalid := Raw_Fields.InValid_orig_dwelling_type((SALT32.StrType)le.orig_dwelling_type);
    SELF.orig_married_Invalid := Raw_Fields.InValid_orig_married((SALT32.StrType)le.orig_married);
    SELF.orig_child_Invalid := Raw_Fields.InValid_orig_child((SALT32.StrType)le.orig_child);
    SELF.orig_nbrchild_Invalid := Raw_Fields.InValid_orig_nbrchild((SALT32.StrType)le.orig_nbrchild);
    SELF.orig_teencd_Invalid := Raw_Fields.InValid_orig_teencd((SALT32.StrType)le.orig_teencd);
    SELF.orig_percent_range_black_Invalid := Raw_Fields.InValid_orig_percent_range_black((SALT32.StrType)le.orig_percent_range_black);
    SELF.orig_percent_range_white_Invalid := Raw_Fields.InValid_orig_percent_range_white((SALT32.StrType)le.orig_percent_range_white);
    SELF.orig_percent_range_hispanic_Invalid := Raw_Fields.InValid_orig_percent_range_hispanic((SALT32.StrType)le.orig_percent_range_hispanic);
    SELF.orig_percent_range_asian_Invalid := Raw_Fields.InValid_orig_percent_range_asian((SALT32.StrType)le.orig_percent_range_asian);
    SELF.orig_percent_range_english_speaking_Invalid := Raw_Fields.InValid_orig_percent_range_english_speaking((SALT32.StrType)le.orig_percent_range_english_speaking);
    SELF.orig_percnt_range_spanish_speaking_Invalid := Raw_Fields.InValid_orig_percnt_range_spanish_speaking((SALT32.StrType)le.orig_percnt_range_spanish_speaking);
    SELF.orig_percent_range_asian_speaking_Invalid := Raw_Fields.InValid_orig_percent_range_asian_speaking((SALT32.StrType)le.orig_percent_range_asian_speaking);
    SELF.orig_percent_range_sfdu_Invalid := Raw_Fields.InValid_orig_percent_range_sfdu((SALT32.StrType)le.orig_percent_range_sfdu);
    SELF.orig_percent_range_mfdu_Invalid := Raw_Fields.InValid_orig_percent_range_mfdu((SALT32.StrType)le.orig_percent_range_mfdu);
    SELF.orig_mhv_Invalid := Raw_Fields.InValid_orig_mhv((SALT32.StrType)le.orig_mhv);
    SELF.orig_mor_Invalid := Raw_Fields.InValid_orig_mor((SALT32.StrType)le.orig_mor);
    SELF.orig_car_Invalid := Raw_Fields.InValid_orig_car((SALT32.StrType)le.orig_car);
    SELF.orig_penetration_range_whitecollar_Invalid := Raw_Fields.InValid_orig_penetration_range_whitecollar((SALT32.StrType)le.orig_penetration_range_whitecollar);
    SELF.orig_penetration_range_bluecollar_Invalid := Raw_Fields.InValid_orig_penetration_range_bluecollar((SALT32.StrType)le.orig_penetration_range_bluecollar);
    SELF.orig_penetration_range_otheroccupation_Invalid := Raw_Fields.InValid_orig_penetration_range_otheroccupation((SALT32.StrType)le.orig_penetration_range_otheroccupation);
    SELF.orig_recdate_Invalid := Raw_Fields.InValid_orig_recdate((SALT32.StrType)le.orig_recdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Raw_Layout_Infutor_NARC);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_fname_Invalid << 0 ) + ( le.orig_mname_Invalid << 2 ) + ( le.orig_lname_Invalid << 4 ) + ( le.orig_suffix_Invalid << 6 ) + ( le.orig_gender_Invalid << 8 ) + ( le.orig_age_Invalid << 9 ) + ( le.orig_dob_Invalid << 10 ) + ( le.orig_hhnbr_Invalid << 11 ) + ( le.orig_tot_males_Invalid << 12 ) + ( le.orig_tot_females_Invalid << 13 ) + ( le.orig_address_Invalid << 14 ) + ( le.orig_house_Invalid << 15 ) + ( le.orig_predir_Invalid << 16 ) + ( le.orig_street_Invalid << 17 ) + ( le.orig_strtype_Invalid << 18 ) + ( le.orig_postdir_Invalid << 19 ) + ( le.orig_apttype_Invalid << 20 ) + ( le.orig_aptnbr_Invalid << 21 ) + ( le.orig_city_Invalid << 22 ) + ( le.orig_zip_Invalid << 24 ) + ( le.orig_z4_Invalid << 26 ) + ( le.orig_vacant_Invalid << 28 ) + ( le.orig_time_zone_Invalid << 29 ) + ( le.orig_telephonenumber_1_Invalid << 30 ) + ( le.orig_validationflag_1_Invalid << 31 ) + ( le.orig_validationdate_1_Invalid << 32 ) + ( le.orig_dma_tps_dnc_flag_1_Invalid << 33 ) + ( le.orig_telephonenumber_2_Invalid << 34 ) + ( le.orig_validation_flag_2_Invalid << 35 ) + ( le.orig_validation_date_2_Invalid << 36 ) + ( le.orig_dma_tps_dnc_flag_2_Invalid << 37 ) + ( le.orig_telephonenumber_3_Invalid << 38 ) + ( le.orig_validationflag_3_Invalid << 39 ) + ( le.orig_validationdate_3_Invalid << 40 ) + ( le.orig_dma_tps_dnc_flag_3_Invalid << 41 ) + ( le.orig_telephonenumber_4_Invalid << 42 ) + ( le.orig_validationflag_4_Invalid << 43 ) + ( le.orig_validationdate_4_Invalid << 44 ) + ( le.orig_dma_tps_dnc_flag_4_Invalid << 45 ) + ( le.orig_telephonenumber_5_Invalid << 46 ) + ( le.orig_validationflag_5_Invalid << 47 ) + ( le.orig_validationdate_5_Invalid << 48 ) + ( le.orig_dma_tps_dnc_flag_5_Invalid << 49 ) + ( le.orig_telephonenumber_6_Invalid << 50 ) + ( le.orig_validationflag_6_Invalid << 51 ) + ( le.orig_validationdate_6_Invalid << 52 ) + ( le.orig_dma_tps_dnc_flag_6_Invalid << 53 ) + ( le.orig_telephonenumber_7_Invalid << 54 ) + ( le.orig_validationflag_7_Invalid << 55 ) + ( le.orig_validationdate_7_Invalid << 56 ) + ( le.orig_dma_tps_dnc_flag_7_Invalid << 57 ) + ( le.orig_tot_phones_Invalid << 58 ) + ( le.orig_length_of_residence_Invalid << 59 ) + ( le.orig_homeowner_Invalid << 60 ) + ( le.orig_estimatedincome_Invalid << 61 ) + ( le.orig_dwelling_type_Invalid << 62 ) + ( le.orig_married_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.orig_child_Invalid << 0 ) + ( le.orig_nbrchild_Invalid << 1 ) + ( le.orig_teencd_Invalid << 2 ) + ( le.orig_percent_range_black_Invalid << 3 ) + ( le.orig_percent_range_white_Invalid << 4 ) + ( le.orig_percent_range_hispanic_Invalid << 5 ) + ( le.orig_percent_range_asian_Invalid << 6 ) + ( le.orig_percent_range_english_speaking_Invalid << 7 ) + ( le.orig_percnt_range_spanish_speaking_Invalid << 8 ) + ( le.orig_percent_range_asian_speaking_Invalid << 9 ) + ( le.orig_percent_range_sfdu_Invalid << 10 ) + ( le.orig_percent_range_mfdu_Invalid << 11 ) + ( le.orig_mhv_Invalid << 12 ) + ( le.orig_mor_Invalid << 13 ) + ( le.orig_car_Invalid << 14 ) + ( le.orig_penetration_range_whitecollar_Invalid << 15 ) + ( le.orig_penetration_range_bluecollar_Invalid << 16 ) + ( le.orig_penetration_range_otheroccupation_Invalid << 17 ) + ( le.orig_recdate_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Raw_Layout_Infutor_NARC);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.orig_suffix_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_gender_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_age_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_hhnbr_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_tot_males_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_tot_females_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_address_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_house_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_predir_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orig_street_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.orig_strtype_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_postdir_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.orig_apttype_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.orig_aptnbr_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.orig_z4_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.orig_vacant_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.orig_time_zone_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.orig_telephonenumber_1_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.orig_validationflag_1_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.orig_validationdate_1_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.orig_dma_tps_dnc_flag_1_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.orig_telephonenumber_2_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.orig_validation_flag_2_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.orig_validation_date_2_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.orig_dma_tps_dnc_flag_2_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.orig_telephonenumber_3_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.orig_validationflag_3_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.orig_validationdate_3_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.orig_dma_tps_dnc_flag_3_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.orig_telephonenumber_4_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.orig_validationflag_4_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.orig_validationdate_4_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.orig_dma_tps_dnc_flag_4_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.orig_telephonenumber_5_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.orig_validationflag_5_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.orig_validationdate_5_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.orig_dma_tps_dnc_flag_5_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.orig_telephonenumber_6_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.orig_validationflag_6_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.orig_validationdate_6_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.orig_dma_tps_dnc_flag_6_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.orig_telephonenumber_7_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.orig_validationflag_7_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.orig_validationdate_7_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.orig_dma_tps_dnc_flag_7_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.orig_tot_phones_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.orig_length_of_residence_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.orig_homeowner_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.orig_estimatedincome_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.orig_dwelling_type_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.orig_married_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.orig_child_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.orig_nbrchild_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.orig_teencd_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.orig_percent_range_black_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.orig_percent_range_white_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.orig_percent_range_hispanic_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.orig_percent_range_asian_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.orig_percent_range_english_speaking_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.orig_percnt_range_spanish_speaking_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.orig_percent_range_asian_speaking_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.orig_percent_range_sfdu_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.orig_percent_range_mfdu_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.orig_mhv_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.orig_mor_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.orig_car_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.orig_penetration_range_whitecollar_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.orig_penetration_range_bluecollar_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.orig_penetration_range_otheroccupation_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.orig_recdate_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    orig_suffix_ENUM_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=2);
    orig_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid>0);
    orig_gender_ENUM_ErrorCount := COUNT(GROUP,h.orig_gender_Invalid=1);
    orig_age_ALLOW_ErrorCount := COUNT(GROUP,h.orig_age_Invalid=1);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_hhnbr_ALLOW_ErrorCount := COUNT(GROUP,h.orig_hhnbr_Invalid=1);
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
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_z4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_z4_Invalid=1);
    orig_z4_LENGTH_ErrorCount := COUNT(GROUP,h.orig_z4_Invalid=2);
    orig_z4_Total_ErrorCount := COUNT(GROUP,h.orig_z4_Invalid>0);
    orig_vacant_ENUM_ErrorCount := COUNT(GROUP,h.orig_vacant_Invalid=1);
    orig_time_zone_ENUM_ErrorCount := COUNT(GROUP,h.orig_time_zone_Invalid=1);
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
    orig_penetration_range_whitecollar_ENUM_ErrorCount := COUNT(GROUP,h.orig_penetration_range_whitecollar_Invalid=1);
    orig_penetration_range_bluecollar_ENUM_ErrorCount := COUNT(GROUP,h.orig_penetration_range_bluecollar_Invalid=1);
    orig_penetration_range_otheroccupation_ENUM_ErrorCount := COUNT(GROUP,h.orig_penetration_range_otheroccupation_Invalid=1);
    orig_recdate_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_recdate_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_suffix_Invalid,le.orig_gender_Invalid,le.orig_age_Invalid,le.orig_dob_Invalid,le.orig_hhnbr_Invalid,le.orig_tot_males_Invalid,le.orig_tot_females_Invalid,le.orig_address_Invalid,le.orig_house_Invalid,le.orig_predir_Invalid,le.orig_street_Invalid,le.orig_strtype_Invalid,le.orig_postdir_Invalid,le.orig_apttype_Invalid,le.orig_aptnbr_Invalid,le.orig_city_Invalid,le.orig_zip_Invalid,le.orig_z4_Invalid,le.orig_vacant_Invalid,le.orig_time_zone_Invalid,le.orig_telephonenumber_1_Invalid,le.orig_validationflag_1_Invalid,le.orig_validationdate_1_Invalid,le.orig_dma_tps_dnc_flag_1_Invalid,le.orig_telephonenumber_2_Invalid,le.orig_validation_flag_2_Invalid,le.orig_validation_date_2_Invalid,le.orig_dma_tps_dnc_flag_2_Invalid,le.orig_telephonenumber_3_Invalid,le.orig_validationflag_3_Invalid,le.orig_validationdate_3_Invalid,le.orig_dma_tps_dnc_flag_3_Invalid,le.orig_telephonenumber_4_Invalid,le.orig_validationflag_4_Invalid,le.orig_validationdate_4_Invalid,le.orig_dma_tps_dnc_flag_4_Invalid,le.orig_telephonenumber_5_Invalid,le.orig_validationflag_5_Invalid,le.orig_validationdate_5_Invalid,le.orig_dma_tps_dnc_flag_5_Invalid,le.orig_telephonenumber_6_Invalid,le.orig_validationflag_6_Invalid,le.orig_validationdate_6_Invalid,le.orig_dma_tps_dnc_flag_6_Invalid,le.orig_telephonenumber_7_Invalid,le.orig_validationflag_7_Invalid,le.orig_validationdate_7_Invalid,le.orig_dma_tps_dnc_flag_7_Invalid,le.orig_tot_phones_Invalid,le.orig_length_of_residence_Invalid,le.orig_homeowner_Invalid,le.orig_estimatedincome_Invalid,le.orig_dwelling_type_Invalid,le.orig_married_Invalid,le.orig_child_Invalid,le.orig_nbrchild_Invalid,le.orig_teencd_Invalid,le.orig_percent_range_black_Invalid,le.orig_percent_range_white_Invalid,le.orig_percent_range_hispanic_Invalid,le.orig_percent_range_asian_Invalid,le.orig_percent_range_english_speaking_Invalid,le.orig_percnt_range_spanish_speaking_Invalid,le.orig_percent_range_asian_speaking_Invalid,le.orig_percent_range_sfdu_Invalid,le.orig_percent_range_mfdu_Invalid,le.orig_mhv_Invalid,le.orig_mor_Invalid,le.orig_car_Invalid,le.orig_penetration_range_whitecollar_Invalid,le.orig_penetration_range_bluecollar_Invalid,le.orig_penetration_range_otheroccupation_Invalid,le.orig_recdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Raw_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Raw_Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Raw_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Raw_Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),Raw_Fields.InvalidMessage_orig_gender(le.orig_gender_Invalid),Raw_Fields.InvalidMessage_orig_age(le.orig_age_Invalid),Raw_Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Raw_Fields.InvalidMessage_orig_hhnbr(le.orig_hhnbr_Invalid),Raw_Fields.InvalidMessage_orig_tot_males(le.orig_tot_males_Invalid),Raw_Fields.InvalidMessage_orig_tot_females(le.orig_tot_females_Invalid),Raw_Fields.InvalidMessage_orig_address(le.orig_address_Invalid),Raw_Fields.InvalidMessage_orig_house(le.orig_house_Invalid),Raw_Fields.InvalidMessage_orig_predir(le.orig_predir_Invalid),Raw_Fields.InvalidMessage_orig_street(le.orig_street_Invalid),Raw_Fields.InvalidMessage_orig_strtype(le.orig_strtype_Invalid),Raw_Fields.InvalidMessage_orig_postdir(le.orig_postdir_Invalid),Raw_Fields.InvalidMessage_orig_apttype(le.orig_apttype_Invalid),Raw_Fields.InvalidMessage_orig_aptnbr(le.orig_aptnbr_Invalid),Raw_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Raw_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Raw_Fields.InvalidMessage_orig_z4(le.orig_z4_Invalid),Raw_Fields.InvalidMessage_orig_vacant(le.orig_vacant_Invalid),Raw_Fields.InvalidMessage_orig_time_zone(le.orig_time_zone_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_1(le.orig_telephonenumber_1_Invalid),Raw_Fields.InvalidMessage_orig_validationflag_1(le.orig_validationflag_1_Invalid),Raw_Fields.InvalidMessage_orig_validationdate_1(le.orig_validationdate_1_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_1(le.orig_dma_tps_dnc_flag_1_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_2(le.orig_telephonenumber_2_Invalid),Raw_Fields.InvalidMessage_orig_validation_flag_2(le.orig_validation_flag_2_Invalid),Raw_Fields.InvalidMessage_orig_validation_date_2(le.orig_validation_date_2_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_2(le.orig_dma_tps_dnc_flag_2_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_3(le.orig_telephonenumber_3_Invalid),Raw_Fields.InvalidMessage_orig_validationflag_3(le.orig_validationflag_3_Invalid),Raw_Fields.InvalidMessage_orig_validationdate_3(le.orig_validationdate_3_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_3(le.orig_dma_tps_dnc_flag_3_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_4(le.orig_telephonenumber_4_Invalid),Raw_Fields.InvalidMessage_orig_validationflag_4(le.orig_validationflag_4_Invalid),Raw_Fields.InvalidMessage_orig_validationdate_4(le.orig_validationdate_4_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_4(le.orig_dma_tps_dnc_flag_4_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_5(le.orig_telephonenumber_5_Invalid),Raw_Fields.InvalidMessage_orig_validationflag_5(le.orig_validationflag_5_Invalid),Raw_Fields.InvalidMessage_orig_validationdate_5(le.orig_validationdate_5_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_5(le.orig_dma_tps_dnc_flag_5_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_6(le.orig_telephonenumber_6_Invalid),Raw_Fields.InvalidMessage_orig_validationflag_6(le.orig_validationflag_6_Invalid),Raw_Fields.InvalidMessage_orig_validationdate_6(le.orig_validationdate_6_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_6(le.orig_dma_tps_dnc_flag_6_Invalid),Raw_Fields.InvalidMessage_orig_telephonenumber_7(le.orig_telephonenumber_7_Invalid),Raw_Fields.InvalidMessage_orig_validationflag_7(le.orig_validationflag_7_Invalid),Raw_Fields.InvalidMessage_orig_validationdate_7(le.orig_validationdate_7_Invalid),Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_7(le.orig_dma_tps_dnc_flag_7_Invalid),Raw_Fields.InvalidMessage_orig_tot_phones(le.orig_tot_phones_Invalid),Raw_Fields.InvalidMessage_orig_length_of_residence(le.orig_length_of_residence_Invalid),Raw_Fields.InvalidMessage_orig_homeowner(le.orig_homeowner_Invalid),Raw_Fields.InvalidMessage_orig_estimatedincome(le.orig_estimatedincome_Invalid),Raw_Fields.InvalidMessage_orig_dwelling_type(le.orig_dwelling_type_Invalid),Raw_Fields.InvalidMessage_orig_married(le.orig_married_Invalid),Raw_Fields.InvalidMessage_orig_child(le.orig_child_Invalid),Raw_Fields.InvalidMessage_orig_nbrchild(le.orig_nbrchild_Invalid),Raw_Fields.InvalidMessage_orig_teencd(le.orig_teencd_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_black(le.orig_percent_range_black_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_white(le.orig_percent_range_white_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_hispanic(le.orig_percent_range_hispanic_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_asian(le.orig_percent_range_asian_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_english_speaking(le.orig_percent_range_english_speaking_Invalid),Raw_Fields.InvalidMessage_orig_percnt_range_spanish_speaking(le.orig_percnt_range_spanish_speaking_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_asian_speaking(le.orig_percent_range_asian_speaking_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_sfdu(le.orig_percent_range_sfdu_Invalid),Raw_Fields.InvalidMessage_orig_percent_range_mfdu(le.orig_percent_range_mfdu_Invalid),Raw_Fields.InvalidMessage_orig_mhv(le.orig_mhv_Invalid),Raw_Fields.InvalidMessage_orig_mor(le.orig_mor_Invalid),Raw_Fields.InvalidMessage_orig_car(le.orig_car_Invalid),Raw_Fields.InvalidMessage_orig_penetration_range_whitecollar(le.orig_penetration_range_whitecollar_Invalid),Raw_Fields.InvalidMessage_orig_penetration_range_bluecollar(le.orig_penetration_range_bluecollar_Invalid),Raw_Fields.InvalidMessage_orig_penetration_range_otheroccupation(le.orig_penetration_range_otheroccupation_Invalid),Raw_Fields.InvalidMessage_orig_recdate(le.orig_recdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'ALLOW','ENUM','UNKNOWN')
          ,CHOOSE(le.orig_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_hhnbr_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_z4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_vacant_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_time_zone_Invalid,'ENUM','UNKNOWN')
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
          ,CHOOSE(le.orig_penetration_range_whitecollar_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_penetration_range_bluecollar_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_penetration_range_otheroccupation_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_recdate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_hhnbr','orig_tot_males','orig_tot_females','orig_address','orig_house','orig_predir','orig_street','orig_strtype','orig_postdir','orig_apttype','orig_aptnbr','orig_city','orig_zip','orig_z4','orig_vacant','orig_time_zone','orig_telephonenumber_1','orig_validationflag_1','orig_validationdate_1','orig_dma_tps_dnc_flag_1','orig_telephonenumber_2','orig_validation_flag_2','orig_validation_date_2','orig_dma_tps_dnc_flag_2','orig_telephonenumber_3','orig_validationflag_3','orig_validationdate_3','orig_dma_tps_dnc_flag_3','orig_telephonenumber_4','orig_validationflag_4','orig_validationdate_4','orig_dma_tps_dnc_flag_4','orig_telephonenumber_5','orig_validationflag_5','orig_validationdate_5','orig_dma_tps_dnc_flag_5','orig_telephonenumber_6','orig_validationflag_6','orig_validationdate_6','orig_dma_tps_dnc_flag_6','orig_telephonenumber_7','orig_validationflag_7','orig_validationdate_7','orig_dma_tps_dnc_flag_7','orig_tot_phones','orig_length_of_residence','orig_homeowner','orig_estimatedincome','orig_dwelling_type','orig_married','orig_child','orig_nbrchild','orig_teencd','orig_percent_range_black','orig_percent_range_white','orig_percent_range_hispanic','orig_percent_range_asian','orig_percent_range_english_speaking','orig_percnt_range_spanish_speaking','orig_percent_range_asian_speaking','orig_percent_range_sfdu','orig_percent_range_mfdu','orig_mhv','orig_mor','orig_car','orig_penetration_range_whitecollar','orig_penetration_range_bluecollar','orig_penetration_range_otheroccupation','orig_recdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alpha','invalid_alpha','invalid_alpha','invalid_suffix','invalid_gender','invalid_nums','invalid_date','invalid_nums','invalid_nums','invalid_nums','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_county_name','invalid_zip','invalid_zip4','invalid_indicator','invalid_time_zone','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_validation_flag','invalid_date','invalid_indicator','invalid_nums','invalid_residence_len','invalid_homeowner','invalid_mhv','invalid_dwelling_type','invalid_indicator','invalid_indicator','invalid_child_num','invalid_indicator','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_mhv','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_penetration_percentage_ranges','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.orig_fname,(SALT32.StrType)le.orig_mname,(SALT32.StrType)le.orig_lname,(SALT32.StrType)le.orig_suffix,(SALT32.StrType)le.orig_gender,(SALT32.StrType)le.orig_age,(SALT32.StrType)le.orig_dob,(SALT32.StrType)le.orig_hhnbr,(SALT32.StrType)le.orig_tot_males,(SALT32.StrType)le.orig_tot_females,(SALT32.StrType)le.orig_address,(SALT32.StrType)le.orig_house,(SALT32.StrType)le.orig_predir,(SALT32.StrType)le.orig_street,(SALT32.StrType)le.orig_strtype,(SALT32.StrType)le.orig_postdir,(SALT32.StrType)le.orig_apttype,(SALT32.StrType)le.orig_aptnbr,(SALT32.StrType)le.orig_city,(SALT32.StrType)le.orig_zip,(SALT32.StrType)le.orig_z4,(SALT32.StrType)le.orig_vacant,(SALT32.StrType)le.orig_time_zone,(SALT32.StrType)le.orig_telephonenumber_1,(SALT32.StrType)le.orig_validationflag_1,(SALT32.StrType)le.orig_validationdate_1,(SALT32.StrType)le.orig_dma_tps_dnc_flag_1,(SALT32.StrType)le.orig_telephonenumber_2,(SALT32.StrType)le.orig_validation_flag_2,(SALT32.StrType)le.orig_validation_date_2,(SALT32.StrType)le.orig_dma_tps_dnc_flag_2,(SALT32.StrType)le.orig_telephonenumber_3,(SALT32.StrType)le.orig_validationflag_3,(SALT32.StrType)le.orig_validationdate_3,(SALT32.StrType)le.orig_dma_tps_dnc_flag_3,(SALT32.StrType)le.orig_telephonenumber_4,(SALT32.StrType)le.orig_validationflag_4,(SALT32.StrType)le.orig_validationdate_4,(SALT32.StrType)le.orig_dma_tps_dnc_flag_4,(SALT32.StrType)le.orig_telephonenumber_5,(SALT32.StrType)le.orig_validationflag_5,(SALT32.StrType)le.orig_validationdate_5,(SALT32.StrType)le.orig_dma_tps_dnc_flag_5,(SALT32.StrType)le.orig_telephonenumber_6,(SALT32.StrType)le.orig_validationflag_6,(SALT32.StrType)le.orig_validationdate_6,(SALT32.StrType)le.orig_dma_tps_dnc_flag_6,(SALT32.StrType)le.orig_telephonenumber_7,(SALT32.StrType)le.orig_validationflag_7,(SALT32.StrType)le.orig_validationdate_7,(SALT32.StrType)le.orig_dma_tps_dnc_flag_7,(SALT32.StrType)le.orig_tot_phones,(SALT32.StrType)le.orig_length_of_residence,(SALT32.StrType)le.orig_homeowner,(SALT32.StrType)le.orig_estimatedincome,(SALT32.StrType)le.orig_dwelling_type,(SALT32.StrType)le.orig_married,(SALT32.StrType)le.orig_child,(SALT32.StrType)le.orig_nbrchild,(SALT32.StrType)le.orig_teencd,(SALT32.StrType)le.orig_percent_range_black,(SALT32.StrType)le.orig_percent_range_white,(SALT32.StrType)le.orig_percent_range_hispanic,(SALT32.StrType)le.orig_percent_range_asian,(SALT32.StrType)le.orig_percent_range_english_speaking,(SALT32.StrType)le.orig_percnt_range_spanish_speaking,(SALT32.StrType)le.orig_percent_range_asian_speaking,(SALT32.StrType)le.orig_percent_range_sfdu,(SALT32.StrType)le.orig_percent_range_mfdu,(SALT32.StrType)le.orig_mhv,(SALT32.StrType)le.orig_mor,(SALT32.StrType)le.orig_car,(SALT32.StrType)le.orig_penetration_range_whitecollar,(SALT32.StrType)le.orig_penetration_range_bluecollar,(SALT32.StrType)le.orig_penetration_range_otheroccupation,(SALT32.StrType)le.orig_recdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,76,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_fname:invalid_alpha:ALLOW','orig_fname:invalid_alpha:LENGTH'
          ,'orig_mname:invalid_alpha:ALLOW','orig_mname:invalid_alpha:LENGTH'
          ,'orig_lname:invalid_alpha:ALLOW','orig_lname:invalid_alpha:LENGTH'
          ,'orig_suffix:invalid_suffix:ALLOW','orig_suffix:invalid_suffix:ENUM'
          ,'orig_gender:invalid_gender:ENUM'
          ,'orig_age:invalid_nums:ALLOW'
          ,'orig_dob:invalid_date:CUSTOM'
          ,'orig_hhnbr:invalid_nums:ALLOW'
          ,'orig_tot_males:invalid_nums:ALLOW'
          ,'orig_tot_females:invalid_nums:ALLOW'
          ,'orig_address:invalid_address:ALLOW'
          ,'orig_house:invalid_address:ALLOW'
          ,'orig_predir:invalid_address:ALLOW'
          ,'orig_street:invalid_address:ALLOW'
          ,'orig_strtype:invalid_address:ALLOW'
          ,'orig_postdir:invalid_address:ALLOW'
          ,'orig_apttype:invalid_address:ALLOW'
          ,'orig_aptnbr:invalid_address:ALLOW'
          ,'orig_city:invalid_county_name:ALLOW','orig_city:invalid_county_name:WORDS'
          ,'orig_zip:invalid_zip:ALLOW','orig_zip:invalid_zip:LENGTH'
          ,'orig_z4:invalid_zip4:ALLOW','orig_z4:invalid_zip4:LENGTH'
          ,'orig_vacant:invalid_indicator:ENUM'
          ,'orig_time_zone:invalid_time_zone:ENUM'
          ,'orig_telephonenumber_1:invalid_nums:ALLOW'
          ,'orig_validationflag_1:invalid_validation_flag:ENUM'
          ,'orig_validationdate_1:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_1:invalid_indicator:ENUM'
          ,'orig_telephonenumber_2:invalid_nums:ALLOW'
          ,'orig_validation_flag_2:invalid_validation_flag:ENUM'
          ,'orig_validation_date_2:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_2:invalid_indicator:ENUM'
          ,'orig_telephonenumber_3:invalid_nums:ALLOW'
          ,'orig_validationflag_3:invalid_validation_flag:ENUM'
          ,'orig_validationdate_3:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_3:invalid_indicator:ENUM'
          ,'orig_telephonenumber_4:invalid_nums:ALLOW'
          ,'orig_validationflag_4:invalid_validation_flag:ENUM'
          ,'orig_validationdate_4:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_4:invalid_indicator:ENUM'
          ,'orig_telephonenumber_5:invalid_nums:ALLOW'
          ,'orig_validationflag_5:invalid_validation_flag:ENUM'
          ,'orig_validationdate_5:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_5:invalid_indicator:ENUM'
          ,'orig_telephonenumber_6:invalid_nums:ALLOW'
          ,'orig_validationflag_6:invalid_validation_flag:ENUM'
          ,'orig_validationdate_6:invalid_date:CUSTOM'
          ,'orig_dma_tps_dnc_flag_6:invalid_indicator:ENUM'
          ,'orig_telephonenumber_7:invalid_nums:ALLOW'
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
          ,'orig_penetration_range_whitecollar:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_penetration_range_bluecollar:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_penetration_range_otheroccupation:invalid_penetration_percentage_ranges:ENUM'
          ,'orig_recdate:invalid_date:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Raw_Fields.InvalidMessage_orig_fname(1),Raw_Fields.InvalidMessage_orig_fname(2)
          ,Raw_Fields.InvalidMessage_orig_mname(1),Raw_Fields.InvalidMessage_orig_mname(2)
          ,Raw_Fields.InvalidMessage_orig_lname(1),Raw_Fields.InvalidMessage_orig_lname(2)
          ,Raw_Fields.InvalidMessage_orig_suffix(1),Raw_Fields.InvalidMessage_orig_suffix(2)
          ,Raw_Fields.InvalidMessage_orig_gender(1)
          ,Raw_Fields.InvalidMessage_orig_age(1)
          ,Raw_Fields.InvalidMessage_orig_dob(1)
          ,Raw_Fields.InvalidMessage_orig_hhnbr(1)
          ,Raw_Fields.InvalidMessage_orig_tot_males(1)
          ,Raw_Fields.InvalidMessage_orig_tot_females(1)
          ,Raw_Fields.InvalidMessage_orig_address(1)
          ,Raw_Fields.InvalidMessage_orig_house(1)
          ,Raw_Fields.InvalidMessage_orig_predir(1)
          ,Raw_Fields.InvalidMessage_orig_street(1)
          ,Raw_Fields.InvalidMessage_orig_strtype(1)
          ,Raw_Fields.InvalidMessage_orig_postdir(1)
          ,Raw_Fields.InvalidMessage_orig_apttype(1)
          ,Raw_Fields.InvalidMessage_orig_aptnbr(1)
          ,Raw_Fields.InvalidMessage_orig_city(1),Raw_Fields.InvalidMessage_orig_city(2)
          ,Raw_Fields.InvalidMessage_orig_zip(1),Raw_Fields.InvalidMessage_orig_zip(2)
          ,Raw_Fields.InvalidMessage_orig_z4(1),Raw_Fields.InvalidMessage_orig_z4(2)
          ,Raw_Fields.InvalidMessage_orig_vacant(1)
          ,Raw_Fields.InvalidMessage_orig_time_zone(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_1(1)
          ,Raw_Fields.InvalidMessage_orig_validationflag_1(1)
          ,Raw_Fields.InvalidMessage_orig_validationdate_1(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_1(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_2(1)
          ,Raw_Fields.InvalidMessage_orig_validation_flag_2(1)
          ,Raw_Fields.InvalidMessage_orig_validation_date_2(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_2(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_3(1)
          ,Raw_Fields.InvalidMessage_orig_validationflag_3(1)
          ,Raw_Fields.InvalidMessage_orig_validationdate_3(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_3(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_4(1)
          ,Raw_Fields.InvalidMessage_orig_validationflag_4(1)
          ,Raw_Fields.InvalidMessage_orig_validationdate_4(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_4(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_5(1)
          ,Raw_Fields.InvalidMessage_orig_validationflag_5(1)
          ,Raw_Fields.InvalidMessage_orig_validationdate_5(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_5(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_6(1)
          ,Raw_Fields.InvalidMessage_orig_validationflag_6(1)
          ,Raw_Fields.InvalidMessage_orig_validationdate_6(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_6(1)
          ,Raw_Fields.InvalidMessage_orig_telephonenumber_7(1)
          ,Raw_Fields.InvalidMessage_orig_validationflag_7(1)
          ,Raw_Fields.InvalidMessage_orig_validationdate_7(1)
          ,Raw_Fields.InvalidMessage_orig_dma_tps_dnc_flag_7(1)
          ,Raw_Fields.InvalidMessage_orig_tot_phones(1)
          ,Raw_Fields.InvalidMessage_orig_length_of_residence(1)
          ,Raw_Fields.InvalidMessage_orig_homeowner(1)
          ,Raw_Fields.InvalidMessage_orig_estimatedincome(1)
          ,Raw_Fields.InvalidMessage_orig_dwelling_type(1)
          ,Raw_Fields.InvalidMessage_orig_married(1)
          ,Raw_Fields.InvalidMessage_orig_child(1)
          ,Raw_Fields.InvalidMessage_orig_nbrchild(1)
          ,Raw_Fields.InvalidMessage_orig_teencd(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_black(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_white(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_hispanic(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_asian(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_english_speaking(1)
          ,Raw_Fields.InvalidMessage_orig_percnt_range_spanish_speaking(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_asian_speaking(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_sfdu(1)
          ,Raw_Fields.InvalidMessage_orig_percent_range_mfdu(1)
          ,Raw_Fields.InvalidMessage_orig_mhv(1)
          ,Raw_Fields.InvalidMessage_orig_mor(1)
          ,Raw_Fields.InvalidMessage_orig_car(1)
          ,Raw_Fields.InvalidMessage_orig_penetration_range_whitecollar(1)
          ,Raw_Fields.InvalidMessage_orig_penetration_range_bluecollar(1)
          ,Raw_Fields.InvalidMessage_orig_penetration_range_otheroccupation(1)
          ,Raw_Fields.InvalidMessage_orig_recdate(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_ENUM_ErrorCount
          ,le.orig_gender_ENUM_ErrorCount
          ,le.orig_age_ALLOW_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_hhnbr_ALLOW_ErrorCount
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
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_z4_ALLOW_ErrorCount,le.orig_z4_LENGTH_ErrorCount
          ,le.orig_vacant_ENUM_ErrorCount
          ,le.orig_time_zone_ENUM_ErrorCount
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
          ,le.orig_penetration_range_whitecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_bluecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_otheroccupation_ENUM_ErrorCount
          ,le.orig_recdate_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_ENUM_ErrorCount
          ,le.orig_gender_ENUM_ErrorCount
          ,le.orig_age_ALLOW_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_hhnbr_ALLOW_ErrorCount
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
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_z4_ALLOW_ErrorCount,le.orig_z4_LENGTH_ErrorCount
          ,le.orig_vacant_ENUM_ErrorCount
          ,le.orig_time_zone_ENUM_ErrorCount
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
          ,le.orig_penetration_range_whitecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_bluecollar_ENUM_ErrorCount
          ,le.orig_penetration_range_otheroccupation_ENUM_ErrorCount
          ,le.orig_recdate_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,83,Into(LEFT,COUNTER));
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
