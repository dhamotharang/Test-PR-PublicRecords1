IMPORT SALT37;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Base_Layout_Prof_License)
    UNSIGNED1 prolic_key_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 profession_or_board_Invalid;
    UNSIGNED1 license_type_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 orig_license_number_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 previous_license_number_Invalid;
    UNSIGNED1 previous_license_type_Invalid;
    UNSIGNED1 name_order_Invalid;
    UNSIGNED1 former_name_order_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_st_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 business_flag_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 sex_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 issue_date_Invalid;
    UNSIGNED1 expiration_date_Invalid;
    UNSIGNED1 last_renewal_date_Invalid;
    UNSIGNED1 license_obtained_by_Invalid;
    UNSIGNED1 board_action_indicator_Invalid;
    UNSIGNED1 source_st_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 action_record_type_Invalid;
    UNSIGNED1 action_complaint_violation_cds_Invalid;
    UNSIGNED1 action_complaint_violation_dt_Invalid;
    UNSIGNED1 action_case_number_Invalid;
    UNSIGNED1 action_effective_dt_Invalid;
    UNSIGNED1 action_cds_Invalid;
    UNSIGNED1 action_final_order_no_Invalid;
    UNSIGNED1 action_status_Invalid;
    UNSIGNED1 action_posting_status_dt_Invalid;
    UNSIGNED1 additional_name_addr_type_Invalid;
    UNSIGNED1 additional_name_order_Invalid;
    UNSIGNED1 additional_orig_city_Invalid;
    UNSIGNED1 additional_orig_st_Invalid;
    UNSIGNED1 additional_orig_zip_Invalid;
    UNSIGNED1 additional_phone_Invalid;
    UNSIGNED1 misc_occupation_Invalid;
    UNSIGNED1 misc_practice_hours_Invalid;
    UNSIGNED1 misc_practice_type_Invalid;
    UNSIGNED1 misc_fax_Invalid;
    UNSIGNED1 misc_web_site_Invalid;
    UNSIGNED1 misc_other_id_Invalid;
    UNSIGNED1 misc_other_id_type_Invalid;
    UNSIGNED1 education_continuing_education_Invalid;
    UNSIGNED1 education_1_dates_attended_Invalid;
    UNSIGNED1 education_1_curriculum_Invalid;
    UNSIGNED1 education_1_degree_Invalid;
    UNSIGNED1 education_2_dates_attended_Invalid;
    UNSIGNED1 education_2_curriculum_Invalid;
    UNSIGNED1 education_2_degree_Invalid;
    UNSIGNED1 education_3_dates_attended_Invalid;
    UNSIGNED1 education_3_curriculum_Invalid;
    UNSIGNED1 education_3_degree_Invalid;
    UNSIGNED1 personal_pob_cd_Invalid;
    UNSIGNED1 personal_pob_desc_Invalid;
    UNSIGNED1 personal_race_cd_Invalid;
    UNSIGNED1 personal_race_desc_Invalid;
    UNSIGNED1 status_status_cds_Invalid;
    UNSIGNED1 status_effective_dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Prof_License)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Base_Layout_Prof_License) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.prolic_key_Invalid := Base_Fields.InValid_prolic_key((SALT37.StrType)le.prolic_key);
    SELF.date_first_seen_Invalid := Base_Fields.InValid_date_first_seen((SALT37.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_Fields.InValid_date_last_seen((SALT37.StrType)le.date_last_seen);
    SELF.profession_or_board_Invalid := Base_Fields.InValid_profession_or_board((SALT37.StrType)le.profession_or_board);
    SELF.license_type_Invalid := Base_Fields.InValid_license_type((SALT37.StrType)le.license_type);
    SELF.status_Invalid := Base_Fields.InValid_status((SALT37.StrType)le.status);
    SELF.orig_license_number_Invalid := Base_Fields.InValid_orig_license_number((SALT37.StrType)le.orig_license_number);
    SELF.license_number_Invalid := Base_Fields.InValid_license_number((SALT37.StrType)le.license_number);
    SELF.previous_license_number_Invalid := Base_Fields.InValid_previous_license_number((SALT37.StrType)le.previous_license_number);
    SELF.previous_license_type_Invalid := Base_Fields.InValid_previous_license_type((SALT37.StrType)le.previous_license_type);
    SELF.name_order_Invalid := Base_Fields.InValid_name_order((SALT37.StrType)le.name_order);
    SELF.former_name_order_Invalid := Base_Fields.InValid_former_name_order((SALT37.StrType)le.former_name_order);
    SELF.orig_city_Invalid := Base_Fields.InValid_orig_city((SALT37.StrType)le.orig_city);
    SELF.orig_st_Invalid := Base_Fields.InValid_orig_st((SALT37.StrType)le.orig_st);
    SELF.orig_zip_Invalid := Base_Fields.InValid_orig_zip((SALT37.StrType)le.orig_zip);
    SELF.business_flag_Invalid := Base_Fields.InValid_business_flag((SALT37.StrType)le.business_flag);
    SELF.phone_Invalid := Base_Fields.InValid_phone((SALT37.StrType)le.phone);
    SELF.sex_Invalid := Base_Fields.InValid_sex((SALT37.StrType)le.sex);
    SELF.dob_Invalid := Base_Fields.InValid_dob((SALT37.StrType)le.dob);
    SELF.issue_date_Invalid := Base_Fields.InValid_issue_date((SALT37.StrType)le.issue_date);
    SELF.expiration_date_Invalid := Base_Fields.InValid_expiration_date((SALT37.StrType)le.expiration_date);
    SELF.last_renewal_date_Invalid := Base_Fields.InValid_last_renewal_date((SALT37.StrType)le.last_renewal_date);
    SELF.license_obtained_by_Invalid := Base_Fields.InValid_license_obtained_by((SALT37.StrType)le.license_obtained_by);
    SELF.board_action_indicator_Invalid := Base_Fields.InValid_board_action_indicator((SALT37.StrType)le.board_action_indicator);
    SELF.source_st_Invalid := Base_Fields.InValid_source_st((SALT37.StrType)le.source_st);
    SELF.vendor_Invalid := Base_Fields.InValid_vendor((SALT37.StrType)le.vendor);
    SELF.action_record_type_Invalid := Base_Fields.InValid_action_record_type((SALT37.StrType)le.action_record_type);
    SELF.action_complaint_violation_cds_Invalid := Base_Fields.InValid_action_complaint_violation_cds((SALT37.StrType)le.action_complaint_violation_cds);
    SELF.action_complaint_violation_dt_Invalid := Base_Fields.InValid_action_complaint_violation_dt((SALT37.StrType)le.action_complaint_violation_dt);
    SELF.action_case_number_Invalid := Base_Fields.InValid_action_case_number((SALT37.StrType)le.action_case_number);
    SELF.action_effective_dt_Invalid := Base_Fields.InValid_action_effective_dt((SALT37.StrType)le.action_effective_dt);
    SELF.action_cds_Invalid := Base_Fields.InValid_action_cds((SALT37.StrType)le.action_cds);
    SELF.action_final_order_no_Invalid := Base_Fields.InValid_action_final_order_no((SALT37.StrType)le.action_final_order_no);
    SELF.action_status_Invalid := Base_Fields.InValid_action_status((SALT37.StrType)le.action_status);
    SELF.action_posting_status_dt_Invalid := Base_Fields.InValid_action_posting_status_dt((SALT37.StrType)le.action_posting_status_dt);
    SELF.additional_name_addr_type_Invalid := Base_Fields.InValid_additional_name_addr_type((SALT37.StrType)le.additional_name_addr_type);
    SELF.additional_name_order_Invalid := Base_Fields.InValid_additional_name_order((SALT37.StrType)le.additional_name_order);
    SELF.additional_orig_city_Invalid := Base_Fields.InValid_additional_orig_city((SALT37.StrType)le.additional_orig_city);
    SELF.additional_orig_st_Invalid := Base_Fields.InValid_additional_orig_st((SALT37.StrType)le.additional_orig_st);
    SELF.additional_orig_zip_Invalid := Base_Fields.InValid_additional_orig_zip((SALT37.StrType)le.additional_orig_zip);
    SELF.additional_phone_Invalid := Base_Fields.InValid_additional_phone((SALT37.StrType)le.additional_phone);
    SELF.misc_occupation_Invalid := Base_Fields.InValid_misc_occupation((SALT37.StrType)le.misc_occupation);
    SELF.misc_practice_hours_Invalid := Base_Fields.InValid_misc_practice_hours((SALT37.StrType)le.misc_practice_hours);
    SELF.misc_practice_type_Invalid := Base_Fields.InValid_misc_practice_type((SALT37.StrType)le.misc_practice_type);
    SELF.misc_fax_Invalid := Base_Fields.InValid_misc_fax((SALT37.StrType)le.misc_fax);
    SELF.misc_web_site_Invalid := Base_Fields.InValid_misc_web_site((SALT37.StrType)le.misc_web_site);
    SELF.misc_other_id_Invalid := Base_Fields.InValid_misc_other_id((SALT37.StrType)le.misc_other_id);
    SELF.misc_other_id_type_Invalid := Base_Fields.InValid_misc_other_id_type((SALT37.StrType)le.misc_other_id_type);
    SELF.education_continuing_education_Invalid := Base_Fields.InValid_education_continuing_education((SALT37.StrType)le.education_continuing_education);
    SELF.education_1_dates_attended_Invalid := Base_Fields.InValid_education_1_dates_attended((SALT37.StrType)le.education_1_dates_attended);
    SELF.education_1_curriculum_Invalid := Base_Fields.InValid_education_1_curriculum((SALT37.StrType)le.education_1_curriculum);
    SELF.education_1_degree_Invalid := Base_Fields.InValid_education_1_degree((SALT37.StrType)le.education_1_degree);
    SELF.education_2_dates_attended_Invalid := Base_Fields.InValid_education_2_dates_attended((SALT37.StrType)le.education_2_dates_attended);
    SELF.education_2_curriculum_Invalid := Base_Fields.InValid_education_2_curriculum((SALT37.StrType)le.education_2_curriculum);
    SELF.education_2_degree_Invalid := Base_Fields.InValid_education_2_degree((SALT37.StrType)le.education_2_degree);
    SELF.education_3_dates_attended_Invalid := Base_Fields.InValid_education_3_dates_attended((SALT37.StrType)le.education_3_dates_attended);
    SELF.education_3_curriculum_Invalid := Base_Fields.InValid_education_3_curriculum((SALT37.StrType)le.education_3_curriculum);
    SELF.education_3_degree_Invalid := Base_Fields.InValid_education_3_degree((SALT37.StrType)le.education_3_degree);
    SELF.personal_pob_cd_Invalid := Base_Fields.InValid_personal_pob_cd((SALT37.StrType)le.personal_pob_cd);
    SELF.personal_pob_desc_Invalid := Base_Fields.InValid_personal_pob_desc((SALT37.StrType)le.personal_pob_desc);
    SELF.personal_race_cd_Invalid := Base_Fields.InValid_personal_race_cd((SALT37.StrType)le.personal_race_cd);
    SELF.personal_race_desc_Invalid := Base_Fields.InValid_personal_race_desc((SALT37.StrType)le.personal_race_desc);
    SELF.status_status_cds_Invalid := Base_Fields.InValid_status_status_cds((SALT37.StrType)le.status_status_cds);
    SELF.status_effective_dt_Invalid := Base_Fields.InValid_status_effective_dt((SALT37.StrType)le.status_effective_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Prof_License);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.prolic_key_Invalid << 0 ) + ( le.date_first_seen_Invalid << 2 ) + ( le.date_last_seen_Invalid << 4 ) + ( le.profession_or_board_Invalid << 6 ) + ( le.license_type_Invalid << 8 ) + ( le.status_Invalid << 10 ) + ( le.orig_license_number_Invalid << 12 ) + ( le.license_number_Invalid << 14 ) + ( le.previous_license_number_Invalid << 16 ) + ( le.previous_license_type_Invalid << 17 ) + ( le.name_order_Invalid << 19 ) + ( le.former_name_order_Invalid << 20 ) + ( le.orig_city_Invalid << 21 ) + ( le.orig_st_Invalid << 23 ) + ( le.orig_zip_Invalid << 25 ) + ( le.business_flag_Invalid << 27 ) + ( le.phone_Invalid << 29 ) + ( le.sex_Invalid << 31 ) + ( le.dob_Invalid << 32 ) + ( le.issue_date_Invalid << 34 ) + ( le.expiration_date_Invalid << 36 ) + ( le.last_renewal_date_Invalid << 38 ) + ( le.license_obtained_by_Invalid << 40 ) + ( le.board_action_indicator_Invalid << 42 ) + ( le.source_st_Invalid << 44 ) + ( le.vendor_Invalid << 46 ) + ( le.action_record_type_Invalid << 48 ) + ( le.action_complaint_violation_cds_Invalid << 49 ) + ( le.action_complaint_violation_dt_Invalid << 50 ) + ( le.action_case_number_Invalid << 52 ) + ( le.action_effective_dt_Invalid << 54 ) + ( le.action_cds_Invalid << 56 ) + ( le.action_final_order_no_Invalid << 58 ) + ( le.action_status_Invalid << 59 ) + ( le.action_posting_status_dt_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.additional_name_addr_type_Invalid << 0 ) + ( le.additional_name_order_Invalid << 2 ) + ( le.additional_orig_city_Invalid << 3 ) + ( le.additional_orig_st_Invalid << 5 ) + ( le.additional_orig_zip_Invalid << 7 ) + ( le.additional_phone_Invalid << 9 ) + ( le.misc_occupation_Invalid << 11 ) + ( le.misc_practice_hours_Invalid << 13 ) + ( le.misc_practice_type_Invalid << 15 ) + ( le.misc_fax_Invalid << 17 ) + ( le.misc_web_site_Invalid << 19 ) + ( le.misc_other_id_Invalid << 21 ) + ( le.misc_other_id_type_Invalid << 22 ) + ( le.education_continuing_education_Invalid << 24 ) + ( le.education_1_dates_attended_Invalid << 26 ) + ( le.education_1_curriculum_Invalid << 28 ) + ( le.education_1_degree_Invalid << 30 ) + ( le.education_2_dates_attended_Invalid << 32 ) + ( le.education_2_curriculum_Invalid << 34 ) + ( le.education_2_degree_Invalid << 36 ) + ( le.education_3_dates_attended_Invalid << 38 ) + ( le.education_3_curriculum_Invalid << 40 ) + ( le.education_3_degree_Invalid << 42 ) + ( le.personal_pob_cd_Invalid << 44 ) + ( le.personal_pob_desc_Invalid << 46 ) + ( le.personal_race_cd_Invalid << 48 ) + ( le.personal_race_desc_Invalid << 50 ) + ( le.status_status_cds_Invalid << 51 ) + ( le.status_effective_dt_Invalid << 52 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Prof_License);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.prolic_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.profession_or_board_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.license_type_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.status_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.orig_license_number_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.previous_license_number_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.previous_license_type_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.name_order_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.former_name_order_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.orig_st_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.business_flag_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.sex_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.issue_date_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.last_renewal_date_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.license_obtained_by_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.board_action_indicator_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.source_st_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.action_record_type_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.action_complaint_violation_cds_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.action_complaint_violation_dt_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.action_case_number_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.action_effective_dt_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.action_cds_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.action_final_order_no_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.action_status_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.action_posting_status_dt_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.additional_name_addr_type_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.additional_name_order_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.additional_orig_city_Invalid := (le.ScrubsBits2 >> 3) & 3;
    SELF.additional_orig_st_Invalid := (le.ScrubsBits2 >> 5) & 3;
    SELF.additional_orig_zip_Invalid := (le.ScrubsBits2 >> 7) & 3;
    SELF.additional_phone_Invalid := (le.ScrubsBits2 >> 9) & 3;
    SELF.misc_occupation_Invalid := (le.ScrubsBits2 >> 11) & 3;
    SELF.misc_practice_hours_Invalid := (le.ScrubsBits2 >> 13) & 3;
    SELF.misc_practice_type_Invalid := (le.ScrubsBits2 >> 15) & 3;
    SELF.misc_fax_Invalid := (le.ScrubsBits2 >> 17) & 3;
    SELF.misc_web_site_Invalid := (le.ScrubsBits2 >> 19) & 3;
    SELF.misc_other_id_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.misc_other_id_type_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.education_continuing_education_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.education_1_dates_attended_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.education_1_curriculum_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.education_1_degree_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.education_2_dates_attended_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.education_2_curriculum_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.education_2_degree_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.education_3_dates_attended_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.education_3_curriculum_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.education_3_degree_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.personal_pob_cd_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.personal_pob_desc_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.personal_race_cd_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.personal_race_desc_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.status_status_cds_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.status_effective_dt_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    prolic_key_ALLOW_ErrorCount := COUNT(GROUP,h.prolic_key_Invalid=1);
    prolic_key_CUSTOM_ErrorCount := COUNT(GROUP,h.prolic_key_Invalid=2);
    prolic_key_Total_ErrorCount := COUNT(GROUP,h.prolic_key_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=3);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=3);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    profession_or_board_ALLOW_ErrorCount := COUNT(GROUP,h.profession_or_board_Invalid=1);
    profession_or_board_CUSTOM_ErrorCount := COUNT(GROUP,h.profession_or_board_Invalid=2);
    profession_or_board_Total_ErrorCount := COUNT(GROUP,h.profession_or_board_Invalid>0);
    license_type_ALLOW_ErrorCount := COUNT(GROUP,h.license_type_Invalid=1);
    license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.license_type_Invalid=2);
    license_type_Total_ErrorCount := COUNT(GROUP,h.license_type_Invalid>0);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    status_CUSTOM_ErrorCount := COUNT(GROUP,h.status_Invalid=2);
    status_Total_ErrorCount := COUNT(GROUP,h.status_Invalid>0);
    orig_license_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_license_number_Invalid=1);
    orig_license_number_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_license_number_Invalid=2);
    orig_license_number_Total_ErrorCount := COUNT(GROUP,h.orig_license_number_Invalid>0);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_number_CUSTOM_ErrorCount := COUNT(GROUP,h.license_number_Invalid=2);
    license_number_Total_ErrorCount := COUNT(GROUP,h.license_number_Invalid>0);
    previous_license_number_ALLOW_ErrorCount := COUNT(GROUP,h.previous_license_number_Invalid=1);
    previous_license_type_ALLOW_ErrorCount := COUNT(GROUP,h.previous_license_type_Invalid=1);
    previous_license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.previous_license_type_Invalid=2);
    previous_license_type_Total_ErrorCount := COUNT(GROUP,h.previous_license_type_Invalid>0);
    name_order_ALLOW_ErrorCount := COUNT(GROUP,h.name_order_Invalid=1);
    former_name_order_ALLOW_ErrorCount := COUNT(GROUP,h.former_name_order_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_st_CAPS_ErrorCount := COUNT(GROUP,h.orig_st_Invalid=1);
    orig_st_ALLOW_ErrorCount := COUNT(GROUP,h.orig_st_Invalid=2);
    orig_st_Total_ErrorCount := COUNT(GROUP,h.orig_st_Invalid>0);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    business_flag_CAPS_ErrorCount := COUNT(GROUP,h.business_flag_Invalid=1);
    business_flag_ENUM_ErrorCount := COUNT(GROUP,h.business_flag_Invalid=2);
    business_flag_Total_ErrorCount := COUNT(GROUP,h.business_flag_Invalid>0);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    sex_ENUM_ErrorCount := COUNT(GROUP,h.sex_Invalid=1);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=3);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=1);
    issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=2);
    issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=3);
    issue_date_Total_ErrorCount := COUNT(GROUP,h.issue_date_Invalid>0);
    expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=2);
    expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=3);
    expiration_date_Total_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid>0);
    last_renewal_date_ALLOW_ErrorCount := COUNT(GROUP,h.last_renewal_date_Invalid=1);
    last_renewal_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_renewal_date_Invalid=2);
    last_renewal_date_Total_ErrorCount := COUNT(GROUP,h.last_renewal_date_Invalid>0);
    license_obtained_by_ALLOW_ErrorCount := COUNT(GROUP,h.license_obtained_by_Invalid=1);
    license_obtained_by_CUSTOM_ErrorCount := COUNT(GROUP,h.license_obtained_by_Invalid=2);
    license_obtained_by_Total_ErrorCount := COUNT(GROUP,h.license_obtained_by_Invalid>0);
    board_action_indicator_CAPS_ErrorCount := COUNT(GROUP,h.board_action_indicator_Invalid=1);
    board_action_indicator_ENUM_ErrorCount := COUNT(GROUP,h.board_action_indicator_Invalid=2);
    board_action_indicator_Total_ErrorCount := COUNT(GROUP,h.board_action_indicator_Invalid>0);
    source_st_CAPS_ErrorCount := COUNT(GROUP,h.source_st_Invalid=1);
    source_st_ALLOW_ErrorCount := COUNT(GROUP,h.source_st_Invalid=2);
    source_st_Total_ErrorCount := COUNT(GROUP,h.source_st_Invalid>0);
    vendor_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    vendor_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_Invalid=2);
    vendor_Total_ErrorCount := COUNT(GROUP,h.vendor_Invalid>0);
    action_record_type_CUSTOM_ErrorCount := COUNT(GROUP,h.action_record_type_Invalid=1);
    action_complaint_violation_cds_CUSTOM_ErrorCount := COUNT(GROUP,h.action_complaint_violation_cds_Invalid=1);
    action_complaint_violation_dt_ALLOW_ErrorCount := COUNT(GROUP,h.action_complaint_violation_dt_Invalid=1);
    action_complaint_violation_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.action_complaint_violation_dt_Invalid=2);
    action_complaint_violation_dt_Total_ErrorCount := COUNT(GROUP,h.action_complaint_violation_dt_Invalid>0);
    action_case_number_ALLOW_ErrorCount := COUNT(GROUP,h.action_case_number_Invalid=1);
    action_case_number_CUSTOM_ErrorCount := COUNT(GROUP,h.action_case_number_Invalid=2);
    action_case_number_Total_ErrorCount := COUNT(GROUP,h.action_case_number_Invalid>0);
    action_effective_dt_ALLOW_ErrorCount := COUNT(GROUP,h.action_effective_dt_Invalid=1);
    action_effective_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.action_effective_dt_Invalid=2);
    action_effective_dt_Total_ErrorCount := COUNT(GROUP,h.action_effective_dt_Invalid>0);
    action_cds_CAPS_ErrorCount := COUNT(GROUP,h.action_cds_Invalid=1);
    action_cds_ALLOW_ErrorCount := COUNT(GROUP,h.action_cds_Invalid=2);
    action_cds_Total_ErrorCount := COUNT(GROUP,h.action_cds_Invalid>0);
    action_final_order_no_CUSTOM_ErrorCount := COUNT(GROUP,h.action_final_order_no_Invalid=1);
    action_status_ALLOW_ErrorCount := COUNT(GROUP,h.action_status_Invalid=1);
    action_status_CUSTOM_ErrorCount := COUNT(GROUP,h.action_status_Invalid=2);
    action_status_Total_ErrorCount := COUNT(GROUP,h.action_status_Invalid>0);
    action_posting_status_dt_ALLOW_ErrorCount := COUNT(GROUP,h.action_posting_status_dt_Invalid=1);
    action_posting_status_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.action_posting_status_dt_Invalid=2);
    action_posting_status_dt_Total_ErrorCount := COUNT(GROUP,h.action_posting_status_dt_Invalid>0);
    additional_name_addr_type_ALLOW_ErrorCount := COUNT(GROUP,h.additional_name_addr_type_Invalid=1);
    additional_name_addr_type_CUSTOM_ErrorCount := COUNT(GROUP,h.additional_name_addr_type_Invalid=2);
    additional_name_addr_type_Total_ErrorCount := COUNT(GROUP,h.additional_name_addr_type_Invalid>0);
    additional_name_order_ALLOW_ErrorCount := COUNT(GROUP,h.additional_name_order_Invalid=1);
    additional_orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.additional_orig_city_Invalid=1);
    additional_orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.additional_orig_city_Invalid=2);
    additional_orig_city_Total_ErrorCount := COUNT(GROUP,h.additional_orig_city_Invalid>0);
    additional_orig_st_CAPS_ErrorCount := COUNT(GROUP,h.additional_orig_st_Invalid=1);
    additional_orig_st_ALLOW_ErrorCount := COUNT(GROUP,h.additional_orig_st_Invalid=2);
    additional_orig_st_Total_ErrorCount := COUNT(GROUP,h.additional_orig_st_Invalid>0);
    additional_orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.additional_orig_zip_Invalid=1);
    additional_orig_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.additional_orig_zip_Invalid=2);
    additional_orig_zip_Total_ErrorCount := COUNT(GROUP,h.additional_orig_zip_Invalid>0);
    additional_phone_ALLOW_ErrorCount := COUNT(GROUP,h.additional_phone_Invalid=1);
    additional_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.additional_phone_Invalid=2);
    additional_phone_LENGTH_ErrorCount := COUNT(GROUP,h.additional_phone_Invalid=3);
    additional_phone_Total_ErrorCount := COUNT(GROUP,h.additional_phone_Invalid>0);
    misc_occupation_ALLOW_ErrorCount := COUNT(GROUP,h.misc_occupation_Invalid=1);
    misc_occupation_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_occupation_Invalid=2);
    misc_occupation_Total_ErrorCount := COUNT(GROUP,h.misc_occupation_Invalid>0);
    misc_practice_hours_ALLOW_ErrorCount := COUNT(GROUP,h.misc_practice_hours_Invalid=1);
    misc_practice_hours_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_practice_hours_Invalid=2);
    misc_practice_hours_Total_ErrorCount := COUNT(GROUP,h.misc_practice_hours_Invalid>0);
    misc_practice_type_ALLOW_ErrorCount := COUNT(GROUP,h.misc_practice_type_Invalid=1);
    misc_practice_type_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_practice_type_Invalid=2);
    misc_practice_type_Total_ErrorCount := COUNT(GROUP,h.misc_practice_type_Invalid>0);
    misc_fax_ALLOW_ErrorCount := COUNT(GROUP,h.misc_fax_Invalid=1);
    misc_fax_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_fax_Invalid=2);
    misc_fax_LENGTH_ErrorCount := COUNT(GROUP,h.misc_fax_Invalid=3);
    misc_fax_Total_ErrorCount := COUNT(GROUP,h.misc_fax_Invalid>0);
    misc_web_site_ALLOW_ErrorCount := COUNT(GROUP,h.misc_web_site_Invalid=1);
    misc_web_site_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_web_site_Invalid=2);
    misc_web_site_Total_ErrorCount := COUNT(GROUP,h.misc_web_site_Invalid>0);
    misc_other_id_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_other_id_Invalid=1);
    misc_other_id_type_ALLOW_ErrorCount := COUNT(GROUP,h.misc_other_id_type_Invalid=1);
    misc_other_id_type_CUSTOM_ErrorCount := COUNT(GROUP,h.misc_other_id_type_Invalid=2);
    misc_other_id_type_Total_ErrorCount := COUNT(GROUP,h.misc_other_id_type_Invalid>0);
    education_continuing_education_ALLOW_ErrorCount := COUNT(GROUP,h.education_continuing_education_Invalid=1);
    education_continuing_education_CUSTOM_ErrorCount := COUNT(GROUP,h.education_continuing_education_Invalid=2);
    education_continuing_education_Total_ErrorCount := COUNT(GROUP,h.education_continuing_education_Invalid>0);
    education_1_dates_attended_ALLOW_ErrorCount := COUNT(GROUP,h.education_1_dates_attended_Invalid=1);
    education_1_dates_attended_CUSTOM_ErrorCount := COUNT(GROUP,h.education_1_dates_attended_Invalid=2);
    education_1_dates_attended_Total_ErrorCount := COUNT(GROUP,h.education_1_dates_attended_Invalid>0);
    education_1_curriculum_ALLOW_ErrorCount := COUNT(GROUP,h.education_1_curriculum_Invalid=1);
    education_1_curriculum_CUSTOM_ErrorCount := COUNT(GROUP,h.education_1_curriculum_Invalid=2);
    education_1_curriculum_Total_ErrorCount := COUNT(GROUP,h.education_1_curriculum_Invalid>0);
    education_1_degree_ALLOW_ErrorCount := COUNT(GROUP,h.education_1_degree_Invalid=1);
    education_1_degree_CUSTOM_ErrorCount := COUNT(GROUP,h.education_1_degree_Invalid=2);
    education_1_degree_Total_ErrorCount := COUNT(GROUP,h.education_1_degree_Invalid>0);
    education_2_dates_attended_ALLOW_ErrorCount := COUNT(GROUP,h.education_2_dates_attended_Invalid=1);
    education_2_dates_attended_CUSTOM_ErrorCount := COUNT(GROUP,h.education_2_dates_attended_Invalid=2);
    education_2_dates_attended_Total_ErrorCount := COUNT(GROUP,h.education_2_dates_attended_Invalid>0);
    education_2_curriculum_ALLOW_ErrorCount := COUNT(GROUP,h.education_2_curriculum_Invalid=1);
    education_2_curriculum_CUSTOM_ErrorCount := COUNT(GROUP,h.education_2_curriculum_Invalid=2);
    education_2_curriculum_Total_ErrorCount := COUNT(GROUP,h.education_2_curriculum_Invalid>0);
    education_2_degree_ALLOW_ErrorCount := COUNT(GROUP,h.education_2_degree_Invalid=1);
    education_2_degree_CUSTOM_ErrorCount := COUNT(GROUP,h.education_2_degree_Invalid=2);
    education_2_degree_Total_ErrorCount := COUNT(GROUP,h.education_2_degree_Invalid>0);
    education_3_dates_attended_ALLOW_ErrorCount := COUNT(GROUP,h.education_3_dates_attended_Invalid=1);
    education_3_dates_attended_CUSTOM_ErrorCount := COUNT(GROUP,h.education_3_dates_attended_Invalid=2);
    education_3_dates_attended_Total_ErrorCount := COUNT(GROUP,h.education_3_dates_attended_Invalid>0);
    education_3_curriculum_ALLOW_ErrorCount := COUNT(GROUP,h.education_3_curriculum_Invalid=1);
    education_3_curriculum_CUSTOM_ErrorCount := COUNT(GROUP,h.education_3_curriculum_Invalid=2);
    education_3_curriculum_Total_ErrorCount := COUNT(GROUP,h.education_3_curriculum_Invalid>0);
    education_3_degree_ALLOW_ErrorCount := COUNT(GROUP,h.education_3_degree_Invalid=1);
    education_3_degree_CUSTOM_ErrorCount := COUNT(GROUP,h.education_3_degree_Invalid=2);
    education_3_degree_Total_ErrorCount := COUNT(GROUP,h.education_3_degree_Invalid>0);
    personal_pob_cd_CAPS_ErrorCount := COUNT(GROUP,h.personal_pob_cd_Invalid=1);
    personal_pob_cd_ALLOW_ErrorCount := COUNT(GROUP,h.personal_pob_cd_Invalid=2);
    personal_pob_cd_Total_ErrorCount := COUNT(GROUP,h.personal_pob_cd_Invalid>0);
    personal_pob_desc_ALLOW_ErrorCount := COUNT(GROUP,h.personal_pob_desc_Invalid=1);
    personal_pob_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.personal_pob_desc_Invalid=2);
    personal_pob_desc_Total_ErrorCount := COUNT(GROUP,h.personal_pob_desc_Invalid>0);
    personal_race_cd_CAPS_ErrorCount := COUNT(GROUP,h.personal_race_cd_Invalid=1);
    personal_race_cd_ALLOW_ErrorCount := COUNT(GROUP,h.personal_race_cd_Invalid=2);
    personal_race_cd_Total_ErrorCount := COUNT(GROUP,h.personal_race_cd_Invalid>0);
    personal_race_desc_ALLOW_ErrorCount := COUNT(GROUP,h.personal_race_desc_Invalid=1);
    status_status_cds_ALLOW_ErrorCount := COUNT(GROUP,h.status_status_cds_Invalid=1);
    status_effective_dt_ALLOW_ErrorCount := COUNT(GROUP,h.status_effective_dt_Invalid=1);
    status_effective_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.status_effective_dt_Invalid=2);
    status_effective_dt_Total_ErrorCount := COUNT(GROUP,h.status_effective_dt_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.prolic_key_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.profession_or_board_Invalid,le.license_type_Invalid,le.status_Invalid,le.orig_license_number_Invalid,le.license_number_Invalid,le.previous_license_number_Invalid,le.previous_license_type_Invalid,le.name_order_Invalid,le.former_name_order_Invalid,le.orig_city_Invalid,le.orig_st_Invalid,le.orig_zip_Invalid,le.business_flag_Invalid,le.phone_Invalid,le.sex_Invalid,le.dob_Invalid,le.issue_date_Invalid,le.expiration_date_Invalid,le.last_renewal_date_Invalid,le.license_obtained_by_Invalid,le.board_action_indicator_Invalid,le.source_st_Invalid,le.vendor_Invalid,le.action_record_type_Invalid,le.action_complaint_violation_cds_Invalid,le.action_complaint_violation_dt_Invalid,le.action_case_number_Invalid,le.action_effective_dt_Invalid,le.action_cds_Invalid,le.action_final_order_no_Invalid,le.action_status_Invalid,le.action_posting_status_dt_Invalid,le.additional_name_addr_type_Invalid,le.additional_name_order_Invalid,le.additional_orig_city_Invalid,le.additional_orig_st_Invalid,le.additional_orig_zip_Invalid,le.additional_phone_Invalid,le.misc_occupation_Invalid,le.misc_practice_hours_Invalid,le.misc_practice_type_Invalid,le.misc_fax_Invalid,le.misc_web_site_Invalid,le.misc_other_id_Invalid,le.misc_other_id_type_Invalid,le.education_continuing_education_Invalid,le.education_1_dates_attended_Invalid,le.education_1_curriculum_Invalid,le.education_1_degree_Invalid,le.education_2_dates_attended_Invalid,le.education_2_curriculum_Invalid,le.education_2_degree_Invalid,le.education_3_dates_attended_Invalid,le.education_3_curriculum_Invalid,le.education_3_degree_Invalid,le.personal_pob_cd_Invalid,le.personal_pob_desc_Invalid,le.personal_race_cd_Invalid,le.personal_race_desc_Invalid,le.status_status_cds_Invalid,le.status_effective_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_prolic_key(le.prolic_key_Invalid),Base_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_Fields.InvalidMessage_profession_or_board(le.profession_or_board_Invalid),Base_Fields.InvalidMessage_license_type(le.license_type_Invalid),Base_Fields.InvalidMessage_status(le.status_Invalid),Base_Fields.InvalidMessage_orig_license_number(le.orig_license_number_Invalid),Base_Fields.InvalidMessage_license_number(le.license_number_Invalid),Base_Fields.InvalidMessage_previous_license_number(le.previous_license_number_Invalid),Base_Fields.InvalidMessage_previous_license_type(le.previous_license_type_Invalid),Base_Fields.InvalidMessage_name_order(le.name_order_Invalid),Base_Fields.InvalidMessage_former_name_order(le.former_name_order_Invalid),Base_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Base_Fields.InvalidMessage_orig_st(le.orig_st_Invalid),Base_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Base_Fields.InvalidMessage_business_flag(le.business_flag_Invalid),Base_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Fields.InvalidMessage_sex(le.sex_Invalid),Base_Fields.InvalidMessage_dob(le.dob_Invalid),Base_Fields.InvalidMessage_issue_date(le.issue_date_Invalid),Base_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),Base_Fields.InvalidMessage_last_renewal_date(le.last_renewal_date_Invalid),Base_Fields.InvalidMessage_license_obtained_by(le.license_obtained_by_Invalid),Base_Fields.InvalidMessage_board_action_indicator(le.board_action_indicator_Invalid),Base_Fields.InvalidMessage_source_st(le.source_st_Invalid),Base_Fields.InvalidMessage_vendor(le.vendor_Invalid),Base_Fields.InvalidMessage_action_record_type(le.action_record_type_Invalid),Base_Fields.InvalidMessage_action_complaint_violation_cds(le.action_complaint_violation_cds_Invalid),Base_Fields.InvalidMessage_action_complaint_violation_dt(le.action_complaint_violation_dt_Invalid),Base_Fields.InvalidMessage_action_case_number(le.action_case_number_Invalid),Base_Fields.InvalidMessage_action_effective_dt(le.action_effective_dt_Invalid),Base_Fields.InvalidMessage_action_cds(le.action_cds_Invalid),Base_Fields.InvalidMessage_action_final_order_no(le.action_final_order_no_Invalid),Base_Fields.InvalidMessage_action_status(le.action_status_Invalid),Base_Fields.InvalidMessage_action_posting_status_dt(le.action_posting_status_dt_Invalid),Base_Fields.InvalidMessage_additional_name_addr_type(le.additional_name_addr_type_Invalid),Base_Fields.InvalidMessage_additional_name_order(le.additional_name_order_Invalid),Base_Fields.InvalidMessage_additional_orig_city(le.additional_orig_city_Invalid),Base_Fields.InvalidMessage_additional_orig_st(le.additional_orig_st_Invalid),Base_Fields.InvalidMessage_additional_orig_zip(le.additional_orig_zip_Invalid),Base_Fields.InvalidMessage_additional_phone(le.additional_phone_Invalid),Base_Fields.InvalidMessage_misc_occupation(le.misc_occupation_Invalid),Base_Fields.InvalidMessage_misc_practice_hours(le.misc_practice_hours_Invalid),Base_Fields.InvalidMessage_misc_practice_type(le.misc_practice_type_Invalid),Base_Fields.InvalidMessage_misc_fax(le.misc_fax_Invalid),Base_Fields.InvalidMessage_misc_web_site(le.misc_web_site_Invalid),Base_Fields.InvalidMessage_misc_other_id(le.misc_other_id_Invalid),Base_Fields.InvalidMessage_misc_other_id_type(le.misc_other_id_type_Invalid),Base_Fields.InvalidMessage_education_continuing_education(le.education_continuing_education_Invalid),Base_Fields.InvalidMessage_education_1_dates_attended(le.education_1_dates_attended_Invalid),Base_Fields.InvalidMessage_education_1_curriculum(le.education_1_curriculum_Invalid),Base_Fields.InvalidMessage_education_1_degree(le.education_1_degree_Invalid),Base_Fields.InvalidMessage_education_2_dates_attended(le.education_2_dates_attended_Invalid),Base_Fields.InvalidMessage_education_2_curriculum(le.education_2_curriculum_Invalid),Base_Fields.InvalidMessage_education_2_degree(le.education_2_degree_Invalid),Base_Fields.InvalidMessage_education_3_dates_attended(le.education_3_dates_attended_Invalid),Base_Fields.InvalidMessage_education_3_curriculum(le.education_3_curriculum_Invalid),Base_Fields.InvalidMessage_education_3_degree(le.education_3_degree_Invalid),Base_Fields.InvalidMessage_personal_pob_cd(le.personal_pob_cd_Invalid),Base_Fields.InvalidMessage_personal_pob_desc(le.personal_pob_desc_Invalid),Base_Fields.InvalidMessage_personal_race_cd(le.personal_race_cd_Invalid),Base_Fields.InvalidMessage_personal_race_desc(le.personal_race_desc_Invalid),Base_Fields.InvalidMessage_status_status_cds(le.status_status_cds_Invalid),Base_Fields.InvalidMessage_status_effective_dt(le.status_effective_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.prolic_key_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.profession_or_board_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_license_number_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.previous_license_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.previous_license_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.former_name_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_flag_Invalid,'CAPS','ENUM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.issue_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_renewal_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_obtained_by_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.board_action_indicator_Invalid,'CAPS','ENUM','UNKNOWN')
          ,CHOOSE(le.source_st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_record_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_complaint_violation_cds_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_complaint_violation_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_case_number_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_effective_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_cds_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.action_final_order_no_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_status_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_posting_status_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.additional_name_addr_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.additional_name_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.additional_orig_city_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.additional_orig_st_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.additional_orig_zip_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.additional_phone_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.misc_occupation_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.misc_practice_hours_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.misc_practice_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.misc_fax_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.misc_web_site_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.misc_other_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.misc_other_id_type_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_continuing_education_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_1_dates_attended_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_1_curriculum_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_1_degree_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_2_dates_attended_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_2_curriculum_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_2_degree_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_3_dates_attended_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_3_curriculum_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.education_3_degree_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.personal_pob_cd_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.personal_pob_desc_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.personal_race_cd_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.personal_race_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_status_cds_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_effective_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'prolic_key','date_first_seen','date_last_seen','profession_or_board','license_type','status','orig_license_number','license_number','previous_license_number','previous_license_type','name_order','former_name_order','orig_city','orig_st','orig_zip','business_flag','phone','sex','dob','issue_date','expiration_date','last_renewal_date','license_obtained_by','board_action_indicator','source_st','vendor','action_record_type','action_complaint_violation_cds','action_complaint_violation_dt','action_case_number','action_effective_dt','action_cds','action_final_order_no','action_status','action_posting_status_dt','additional_name_addr_type','additional_name_order','additional_orig_city','additional_orig_st','additional_orig_zip','additional_phone','misc_occupation','misc_practice_hours','misc_practice_type','misc_fax','misc_web_site','misc_other_id','misc_other_id_type','education_continuing_education','education_1_dates_attended','education_1_curriculum','education_1_degree','education_2_dates_attended','education_2_curriculum','education_2_degree','education_3_dates_attended','education_3_curriculum','education_3_degree','personal_pob_cd','personal_pob_desc','personal_race_cd','personal_race_desc','status_status_cds','status_effective_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_prolic_key','invalid_068pastdate','invalid_068pastdate','invalid_profession_or_board','invalid_license_type','invalid_status','invalid_prolic_key','invalid_prolic_key','invalid_numeric','invalid_license_type','invalid_name_order','invalid_name_order','invalid_orig_city','invalid_alpha','invalid_orig_zip','invalid_yn','invalid_phone','invalid_sex','invalid_0468pastdate','invalid_0468date','invalid_0468date','invalid_past_date','invalid_license_obtained_by','invalid_yn','invalid_alpha','invalid_vendor','invalid_nonprintable','invalid_nonprintable','invalid_past_date','invalid_action_case_number','invalid_past_date','invalid_alpha','invalid_nonprintable','invalid_action_status','invalid_past_date','invalid_additional_name_addr_type','invalid_name_order','invalid_orig_city','invalid_alpha','invalid_orig_zip','invalid_additional_phone','invalid_misc_occupation','invalid_misc_practice_hours','invalid_misc_practice_type','invalid_additional_phone','invalid_misc_web_site','invalid_nonprintable','invalid_misc_other_id_type','invalid_education_continuing_education','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','invalid_education_dates_attended','invalid_education_curriculum','invalid_education_degree','invalid_alpha','personal_pob_desc','invalid_alphanumeric','invalid_alphaspaceslash','invalid_alphanumerichyphen','invalid_past_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.prolic_key,(SALT37.StrType)le.date_first_seen,(SALT37.StrType)le.date_last_seen,(SALT37.StrType)le.profession_or_board,(SALT37.StrType)le.license_type,(SALT37.StrType)le.status,(SALT37.StrType)le.orig_license_number,(SALT37.StrType)le.license_number,(SALT37.StrType)le.previous_license_number,(SALT37.StrType)le.previous_license_type,(SALT37.StrType)le.name_order,(SALT37.StrType)le.former_name_order,(SALT37.StrType)le.orig_city,(SALT37.StrType)le.orig_st,(SALT37.StrType)le.orig_zip,(SALT37.StrType)le.business_flag,(SALT37.StrType)le.phone,(SALT37.StrType)le.sex,(SALT37.StrType)le.dob,(SALT37.StrType)le.issue_date,(SALT37.StrType)le.expiration_date,(SALT37.StrType)le.last_renewal_date,(SALT37.StrType)le.license_obtained_by,(SALT37.StrType)le.board_action_indicator,(SALT37.StrType)le.source_st,(SALT37.StrType)le.vendor,(SALT37.StrType)le.action_record_type,(SALT37.StrType)le.action_complaint_violation_cds,(SALT37.StrType)le.action_complaint_violation_dt,(SALT37.StrType)le.action_case_number,(SALT37.StrType)le.action_effective_dt,(SALT37.StrType)le.action_cds,(SALT37.StrType)le.action_final_order_no,(SALT37.StrType)le.action_status,(SALT37.StrType)le.action_posting_status_dt,(SALT37.StrType)le.additional_name_addr_type,(SALT37.StrType)le.additional_name_order,(SALT37.StrType)le.additional_orig_city,(SALT37.StrType)le.additional_orig_st,(SALT37.StrType)le.additional_orig_zip,(SALT37.StrType)le.additional_phone,(SALT37.StrType)le.misc_occupation,(SALT37.StrType)le.misc_practice_hours,(SALT37.StrType)le.misc_practice_type,(SALT37.StrType)le.misc_fax,(SALT37.StrType)le.misc_web_site,(SALT37.StrType)le.misc_other_id,(SALT37.StrType)le.misc_other_id_type,(SALT37.StrType)le.education_continuing_education,(SALT37.StrType)le.education_1_dates_attended,(SALT37.StrType)le.education_1_curriculum,(SALT37.StrType)le.education_1_degree,(SALT37.StrType)le.education_2_dates_attended,(SALT37.StrType)le.education_2_curriculum,(SALT37.StrType)le.education_2_degree,(SALT37.StrType)le.education_3_dates_attended,(SALT37.StrType)le.education_3_curriculum,(SALT37.StrType)le.education_3_degree,(SALT37.StrType)le.personal_pob_cd,(SALT37.StrType)le.personal_pob_desc,(SALT37.StrType)le.personal_race_cd,(SALT37.StrType)le.personal_race_desc,(SALT37.StrType)le.status_status_cds,(SALT37.StrType)le.status_effective_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,64,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'prolic_key:invalid_prolic_key:ALLOW','prolic_key:invalid_prolic_key:CUSTOM'
          ,'date_first_seen:invalid_068pastdate:ALLOW','date_first_seen:invalid_068pastdate:CUSTOM','date_first_seen:invalid_068pastdate:LENGTH'
          ,'date_last_seen:invalid_068pastdate:ALLOW','date_last_seen:invalid_068pastdate:CUSTOM','date_last_seen:invalid_068pastdate:LENGTH'
          ,'profession_or_board:invalid_profession_or_board:ALLOW','profession_or_board:invalid_profession_or_board:CUSTOM'
          ,'license_type:invalid_license_type:ALLOW','license_type:invalid_license_type:CUSTOM'
          ,'status:invalid_status:ALLOW','status:invalid_status:CUSTOM'
          ,'orig_license_number:invalid_prolic_key:ALLOW','orig_license_number:invalid_prolic_key:CUSTOM'
          ,'license_number:invalid_prolic_key:ALLOW','license_number:invalid_prolic_key:CUSTOM'
          ,'previous_license_number:invalid_numeric:ALLOW'
          ,'previous_license_type:invalid_license_type:ALLOW','previous_license_type:invalid_license_type:CUSTOM'
          ,'name_order:invalid_name_order:ALLOW'
          ,'former_name_order:invalid_name_order:ALLOW'
          ,'orig_city:invalid_orig_city:ALLOW','orig_city:invalid_orig_city:CUSTOM'
          ,'orig_st:invalid_alpha:CAPS','orig_st:invalid_alpha:ALLOW'
          ,'orig_zip:invalid_orig_zip:ALLOW','orig_zip:invalid_orig_zip:CUSTOM'
          ,'business_flag:invalid_yn:CAPS','business_flag:invalid_yn:ENUM'
          ,'phone:invalid_phone:ALLOW','phone:invalid_phone:CUSTOM'
          ,'sex:invalid_sex:ENUM'
          ,'dob:invalid_0468pastdate:ALLOW','dob:invalid_0468pastdate:CUSTOM','dob:invalid_0468pastdate:LENGTH'
          ,'issue_date:invalid_0468date:ALLOW','issue_date:invalid_0468date:CUSTOM','issue_date:invalid_0468date:LENGTH'
          ,'expiration_date:invalid_0468date:ALLOW','expiration_date:invalid_0468date:CUSTOM','expiration_date:invalid_0468date:LENGTH'
          ,'last_renewal_date:invalid_past_date:ALLOW','last_renewal_date:invalid_past_date:CUSTOM'
          ,'license_obtained_by:invalid_license_obtained_by:ALLOW','license_obtained_by:invalid_license_obtained_by:CUSTOM'
          ,'board_action_indicator:invalid_yn:CAPS','board_action_indicator:invalid_yn:ENUM'
          ,'source_st:invalid_alpha:CAPS','source_st:invalid_alpha:ALLOW'
          ,'vendor:invalid_vendor:ALLOW','vendor:invalid_vendor:CUSTOM'
          ,'action_record_type:invalid_nonprintable:CUSTOM'
          ,'action_complaint_violation_cds:invalid_nonprintable:CUSTOM'
          ,'action_complaint_violation_dt:invalid_past_date:ALLOW','action_complaint_violation_dt:invalid_past_date:CUSTOM'
          ,'action_case_number:invalid_action_case_number:ALLOW','action_case_number:invalid_action_case_number:CUSTOM'
          ,'action_effective_dt:invalid_past_date:ALLOW','action_effective_dt:invalid_past_date:CUSTOM'
          ,'action_cds:invalid_alpha:CAPS','action_cds:invalid_alpha:ALLOW'
          ,'action_final_order_no:invalid_nonprintable:CUSTOM'
          ,'action_status:invalid_action_status:ALLOW','action_status:invalid_action_status:CUSTOM'
          ,'action_posting_status_dt:invalid_past_date:ALLOW','action_posting_status_dt:invalid_past_date:CUSTOM'
          ,'additional_name_addr_type:invalid_additional_name_addr_type:ALLOW','additional_name_addr_type:invalid_additional_name_addr_type:CUSTOM'
          ,'additional_name_order:invalid_name_order:ALLOW'
          ,'additional_orig_city:invalid_orig_city:ALLOW','additional_orig_city:invalid_orig_city:CUSTOM'
          ,'additional_orig_st:invalid_alpha:CAPS','additional_orig_st:invalid_alpha:ALLOW'
          ,'additional_orig_zip:invalid_orig_zip:ALLOW','additional_orig_zip:invalid_orig_zip:CUSTOM'
          ,'additional_phone:invalid_additional_phone:ALLOW','additional_phone:invalid_additional_phone:CUSTOM','additional_phone:invalid_additional_phone:LENGTH'
          ,'misc_occupation:invalid_misc_occupation:ALLOW','misc_occupation:invalid_misc_occupation:CUSTOM'
          ,'misc_practice_hours:invalid_misc_practice_hours:ALLOW','misc_practice_hours:invalid_misc_practice_hours:CUSTOM'
          ,'misc_practice_type:invalid_misc_practice_type:ALLOW','misc_practice_type:invalid_misc_practice_type:CUSTOM'
          ,'misc_fax:invalid_additional_phone:ALLOW','misc_fax:invalid_additional_phone:CUSTOM','misc_fax:invalid_additional_phone:LENGTH'
          ,'misc_web_site:invalid_misc_web_site:ALLOW','misc_web_site:invalid_misc_web_site:CUSTOM'
          ,'misc_other_id:invalid_nonprintable:CUSTOM'
          ,'misc_other_id_type:invalid_misc_other_id_type:ALLOW','misc_other_id_type:invalid_misc_other_id_type:CUSTOM'
          ,'education_continuing_education:invalid_education_continuing_education:ALLOW','education_continuing_education:invalid_education_continuing_education:CUSTOM'
          ,'education_1_dates_attended:invalid_education_dates_attended:ALLOW','education_1_dates_attended:invalid_education_dates_attended:CUSTOM'
          ,'education_1_curriculum:invalid_education_curriculum:ALLOW','education_1_curriculum:invalid_education_curriculum:CUSTOM'
          ,'education_1_degree:invalid_education_degree:ALLOW','education_1_degree:invalid_education_degree:CUSTOM'
          ,'education_2_dates_attended:invalid_education_dates_attended:ALLOW','education_2_dates_attended:invalid_education_dates_attended:CUSTOM'
          ,'education_2_curriculum:invalid_education_curriculum:ALLOW','education_2_curriculum:invalid_education_curriculum:CUSTOM'
          ,'education_2_degree:invalid_education_degree:ALLOW','education_2_degree:invalid_education_degree:CUSTOM'
          ,'education_3_dates_attended:invalid_education_dates_attended:ALLOW','education_3_dates_attended:invalid_education_dates_attended:CUSTOM'
          ,'education_3_curriculum:invalid_education_curriculum:ALLOW','education_3_curriculum:invalid_education_curriculum:CUSTOM'
          ,'education_3_degree:invalid_education_degree:ALLOW','education_3_degree:invalid_education_degree:CUSTOM'
          ,'personal_pob_cd:invalid_alpha:CAPS','personal_pob_cd:invalid_alpha:ALLOW'
          ,'personal_pob_desc:personal_pob_desc:ALLOW','personal_pob_desc:personal_pob_desc:CUSTOM'
          ,'personal_race_cd:invalid_alphanumeric:CAPS','personal_race_cd:invalid_alphanumeric:ALLOW'
          ,'personal_race_desc:invalid_alphaspaceslash:ALLOW'
          ,'status_status_cds:invalid_alphanumerichyphen:ALLOW'
          ,'status_effective_dt:invalid_past_date:ALLOW','status_effective_dt:invalid_past_date:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_prolic_key(1),Base_Fields.InvalidMessage_prolic_key(2)
          ,Base_Fields.InvalidMessage_date_first_seen(1),Base_Fields.InvalidMessage_date_first_seen(2),Base_Fields.InvalidMessage_date_first_seen(3)
          ,Base_Fields.InvalidMessage_date_last_seen(1),Base_Fields.InvalidMessage_date_last_seen(2),Base_Fields.InvalidMessage_date_last_seen(3)
          ,Base_Fields.InvalidMessage_profession_or_board(1),Base_Fields.InvalidMessage_profession_or_board(2)
          ,Base_Fields.InvalidMessage_license_type(1),Base_Fields.InvalidMessage_license_type(2)
          ,Base_Fields.InvalidMessage_status(1),Base_Fields.InvalidMessage_status(2)
          ,Base_Fields.InvalidMessage_orig_license_number(1),Base_Fields.InvalidMessage_orig_license_number(2)
          ,Base_Fields.InvalidMessage_license_number(1),Base_Fields.InvalidMessage_license_number(2)
          ,Base_Fields.InvalidMessage_previous_license_number(1)
          ,Base_Fields.InvalidMessage_previous_license_type(1),Base_Fields.InvalidMessage_previous_license_type(2)
          ,Base_Fields.InvalidMessage_name_order(1)
          ,Base_Fields.InvalidMessage_former_name_order(1)
          ,Base_Fields.InvalidMessage_orig_city(1),Base_Fields.InvalidMessage_orig_city(2)
          ,Base_Fields.InvalidMessage_orig_st(1),Base_Fields.InvalidMessage_orig_st(2)
          ,Base_Fields.InvalidMessage_orig_zip(1),Base_Fields.InvalidMessage_orig_zip(2)
          ,Base_Fields.InvalidMessage_business_flag(1),Base_Fields.InvalidMessage_business_flag(2)
          ,Base_Fields.InvalidMessage_phone(1),Base_Fields.InvalidMessage_phone(2)
          ,Base_Fields.InvalidMessage_sex(1)
          ,Base_Fields.InvalidMessage_dob(1),Base_Fields.InvalidMessage_dob(2),Base_Fields.InvalidMessage_dob(3)
          ,Base_Fields.InvalidMessage_issue_date(1),Base_Fields.InvalidMessage_issue_date(2),Base_Fields.InvalidMessage_issue_date(3)
          ,Base_Fields.InvalidMessage_expiration_date(1),Base_Fields.InvalidMessage_expiration_date(2),Base_Fields.InvalidMessage_expiration_date(3)
          ,Base_Fields.InvalidMessage_last_renewal_date(1),Base_Fields.InvalidMessage_last_renewal_date(2)
          ,Base_Fields.InvalidMessage_license_obtained_by(1),Base_Fields.InvalidMessage_license_obtained_by(2)
          ,Base_Fields.InvalidMessage_board_action_indicator(1),Base_Fields.InvalidMessage_board_action_indicator(2)
          ,Base_Fields.InvalidMessage_source_st(1),Base_Fields.InvalidMessage_source_st(2)
          ,Base_Fields.InvalidMessage_vendor(1),Base_Fields.InvalidMessage_vendor(2)
          ,Base_Fields.InvalidMessage_action_record_type(1)
          ,Base_Fields.InvalidMessage_action_complaint_violation_cds(1)
          ,Base_Fields.InvalidMessage_action_complaint_violation_dt(1),Base_Fields.InvalidMessage_action_complaint_violation_dt(2)
          ,Base_Fields.InvalidMessage_action_case_number(1),Base_Fields.InvalidMessage_action_case_number(2)
          ,Base_Fields.InvalidMessage_action_effective_dt(1),Base_Fields.InvalidMessage_action_effective_dt(2)
          ,Base_Fields.InvalidMessage_action_cds(1),Base_Fields.InvalidMessage_action_cds(2)
          ,Base_Fields.InvalidMessage_action_final_order_no(1)
          ,Base_Fields.InvalidMessage_action_status(1),Base_Fields.InvalidMessage_action_status(2)
          ,Base_Fields.InvalidMessage_action_posting_status_dt(1),Base_Fields.InvalidMessage_action_posting_status_dt(2)
          ,Base_Fields.InvalidMessage_additional_name_addr_type(1),Base_Fields.InvalidMessage_additional_name_addr_type(2)
          ,Base_Fields.InvalidMessage_additional_name_order(1)
          ,Base_Fields.InvalidMessage_additional_orig_city(1),Base_Fields.InvalidMessage_additional_orig_city(2)
          ,Base_Fields.InvalidMessage_additional_orig_st(1),Base_Fields.InvalidMessage_additional_orig_st(2)
          ,Base_Fields.InvalidMessage_additional_orig_zip(1),Base_Fields.InvalidMessage_additional_orig_zip(2)
          ,Base_Fields.InvalidMessage_additional_phone(1),Base_Fields.InvalidMessage_additional_phone(2),Base_Fields.InvalidMessage_additional_phone(3)
          ,Base_Fields.InvalidMessage_misc_occupation(1),Base_Fields.InvalidMessage_misc_occupation(2)
          ,Base_Fields.InvalidMessage_misc_practice_hours(1),Base_Fields.InvalidMessage_misc_practice_hours(2)
          ,Base_Fields.InvalidMessage_misc_practice_type(1),Base_Fields.InvalidMessage_misc_practice_type(2)
          ,Base_Fields.InvalidMessage_misc_fax(1),Base_Fields.InvalidMessage_misc_fax(2),Base_Fields.InvalidMessage_misc_fax(3)
          ,Base_Fields.InvalidMessage_misc_web_site(1),Base_Fields.InvalidMessage_misc_web_site(2)
          ,Base_Fields.InvalidMessage_misc_other_id(1)
          ,Base_Fields.InvalidMessage_misc_other_id_type(1),Base_Fields.InvalidMessage_misc_other_id_type(2)
          ,Base_Fields.InvalidMessage_education_continuing_education(1),Base_Fields.InvalidMessage_education_continuing_education(2)
          ,Base_Fields.InvalidMessage_education_1_dates_attended(1),Base_Fields.InvalidMessage_education_1_dates_attended(2)
          ,Base_Fields.InvalidMessage_education_1_curriculum(1),Base_Fields.InvalidMessage_education_1_curriculum(2)
          ,Base_Fields.InvalidMessage_education_1_degree(1),Base_Fields.InvalidMessage_education_1_degree(2)
          ,Base_Fields.InvalidMessage_education_2_dates_attended(1),Base_Fields.InvalidMessage_education_2_dates_attended(2)
          ,Base_Fields.InvalidMessage_education_2_curriculum(1),Base_Fields.InvalidMessage_education_2_curriculum(2)
          ,Base_Fields.InvalidMessage_education_2_degree(1),Base_Fields.InvalidMessage_education_2_degree(2)
          ,Base_Fields.InvalidMessage_education_3_dates_attended(1),Base_Fields.InvalidMessage_education_3_dates_attended(2)
          ,Base_Fields.InvalidMessage_education_3_curriculum(1),Base_Fields.InvalidMessage_education_3_curriculum(2)
          ,Base_Fields.InvalidMessage_education_3_degree(1),Base_Fields.InvalidMessage_education_3_degree(2)
          ,Base_Fields.InvalidMessage_personal_pob_cd(1),Base_Fields.InvalidMessage_personal_pob_cd(2)
          ,Base_Fields.InvalidMessage_personal_pob_desc(1),Base_Fields.InvalidMessage_personal_pob_desc(2)
          ,Base_Fields.InvalidMessage_personal_race_cd(1),Base_Fields.InvalidMessage_personal_race_cd(2)
          ,Base_Fields.InvalidMessage_personal_race_desc(1)
          ,Base_Fields.InvalidMessage_status_status_cds(1)
          ,Base_Fields.InvalidMessage_status_effective_dt(1),Base_Fields.InvalidMessage_status_effective_dt(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.prolic_key_ALLOW_ErrorCount,le.prolic_key_CUSTOM_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_CUSTOM_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_CUSTOM_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.profession_or_board_ALLOW_ErrorCount,le.profession_or_board_CUSTOM_ErrorCount
          ,le.license_type_ALLOW_ErrorCount,le.license_type_CUSTOM_ErrorCount
          ,le.status_ALLOW_ErrorCount,le.status_CUSTOM_ErrorCount
          ,le.orig_license_number_ALLOW_ErrorCount,le.orig_license_number_CUSTOM_ErrorCount
          ,le.license_number_ALLOW_ErrorCount,le.license_number_CUSTOM_ErrorCount
          ,le.previous_license_number_ALLOW_ErrorCount
          ,le.previous_license_type_ALLOW_ErrorCount,le.previous_license_type_CUSTOM_ErrorCount
          ,le.name_order_ALLOW_ErrorCount
          ,le.former_name_order_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_st_CAPS_ErrorCount,le.orig_st_ALLOW_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_CUSTOM_ErrorCount
          ,le.business_flag_CAPS_ErrorCount,le.business_flag_ENUM_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_CUSTOM_ErrorCount
          ,le.sex_ENUM_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.issue_date_ALLOW_ErrorCount,le.issue_date_CUSTOM_ErrorCount,le.issue_date_LENGTH_ErrorCount
          ,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_CUSTOM_ErrorCount,le.expiration_date_LENGTH_ErrorCount
          ,le.last_renewal_date_ALLOW_ErrorCount,le.last_renewal_date_CUSTOM_ErrorCount
          ,le.license_obtained_by_ALLOW_ErrorCount,le.license_obtained_by_CUSTOM_ErrorCount
          ,le.board_action_indicator_CAPS_ErrorCount,le.board_action_indicator_ENUM_ErrorCount
          ,le.source_st_CAPS_ErrorCount,le.source_st_ALLOW_ErrorCount
          ,le.vendor_ALLOW_ErrorCount,le.vendor_CUSTOM_ErrorCount
          ,le.action_record_type_CUSTOM_ErrorCount
          ,le.action_complaint_violation_cds_CUSTOM_ErrorCount
          ,le.action_complaint_violation_dt_ALLOW_ErrorCount,le.action_complaint_violation_dt_CUSTOM_ErrorCount
          ,le.action_case_number_ALLOW_ErrorCount,le.action_case_number_CUSTOM_ErrorCount
          ,le.action_effective_dt_ALLOW_ErrorCount,le.action_effective_dt_CUSTOM_ErrorCount
          ,le.action_cds_CAPS_ErrorCount,le.action_cds_ALLOW_ErrorCount
          ,le.action_final_order_no_CUSTOM_ErrorCount
          ,le.action_status_ALLOW_ErrorCount,le.action_status_CUSTOM_ErrorCount
          ,le.action_posting_status_dt_ALLOW_ErrorCount,le.action_posting_status_dt_CUSTOM_ErrorCount
          ,le.additional_name_addr_type_ALLOW_ErrorCount,le.additional_name_addr_type_CUSTOM_ErrorCount
          ,le.additional_name_order_ALLOW_ErrorCount
          ,le.additional_orig_city_ALLOW_ErrorCount,le.additional_orig_city_CUSTOM_ErrorCount
          ,le.additional_orig_st_CAPS_ErrorCount,le.additional_orig_st_ALLOW_ErrorCount
          ,le.additional_orig_zip_ALLOW_ErrorCount,le.additional_orig_zip_CUSTOM_ErrorCount
          ,le.additional_phone_ALLOW_ErrorCount,le.additional_phone_CUSTOM_ErrorCount,le.additional_phone_LENGTH_ErrorCount
          ,le.misc_occupation_ALLOW_ErrorCount,le.misc_occupation_CUSTOM_ErrorCount
          ,le.misc_practice_hours_ALLOW_ErrorCount,le.misc_practice_hours_CUSTOM_ErrorCount
          ,le.misc_practice_type_ALLOW_ErrorCount,le.misc_practice_type_CUSTOM_ErrorCount
          ,le.misc_fax_ALLOW_ErrorCount,le.misc_fax_CUSTOM_ErrorCount,le.misc_fax_LENGTH_ErrorCount
          ,le.misc_web_site_ALLOW_ErrorCount,le.misc_web_site_CUSTOM_ErrorCount
          ,le.misc_other_id_CUSTOM_ErrorCount
          ,le.misc_other_id_type_ALLOW_ErrorCount,le.misc_other_id_type_CUSTOM_ErrorCount
          ,le.education_continuing_education_ALLOW_ErrorCount,le.education_continuing_education_CUSTOM_ErrorCount
          ,le.education_1_dates_attended_ALLOW_ErrorCount,le.education_1_dates_attended_CUSTOM_ErrorCount
          ,le.education_1_curriculum_ALLOW_ErrorCount,le.education_1_curriculum_CUSTOM_ErrorCount
          ,le.education_1_degree_ALLOW_ErrorCount,le.education_1_degree_CUSTOM_ErrorCount
          ,le.education_2_dates_attended_ALLOW_ErrorCount,le.education_2_dates_attended_CUSTOM_ErrorCount
          ,le.education_2_curriculum_ALLOW_ErrorCount,le.education_2_curriculum_CUSTOM_ErrorCount
          ,le.education_2_degree_ALLOW_ErrorCount,le.education_2_degree_CUSTOM_ErrorCount
          ,le.education_3_dates_attended_ALLOW_ErrorCount,le.education_3_dates_attended_CUSTOM_ErrorCount
          ,le.education_3_curriculum_ALLOW_ErrorCount,le.education_3_curriculum_CUSTOM_ErrorCount
          ,le.education_3_degree_ALLOW_ErrorCount,le.education_3_degree_CUSTOM_ErrorCount
          ,le.personal_pob_cd_CAPS_ErrorCount,le.personal_pob_cd_ALLOW_ErrorCount
          ,le.personal_pob_desc_ALLOW_ErrorCount,le.personal_pob_desc_CUSTOM_ErrorCount
          ,le.personal_race_cd_CAPS_ErrorCount,le.personal_race_cd_ALLOW_ErrorCount
          ,le.personal_race_desc_ALLOW_ErrorCount
          ,le.status_status_cds_ALLOW_ErrorCount
          ,le.status_effective_dt_ALLOW_ErrorCount,le.status_effective_dt_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.prolic_key_ALLOW_ErrorCount,le.prolic_key_CUSTOM_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_CUSTOM_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_CUSTOM_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.profession_or_board_ALLOW_ErrorCount,le.profession_or_board_CUSTOM_ErrorCount
          ,le.license_type_ALLOW_ErrorCount,le.license_type_CUSTOM_ErrorCount
          ,le.status_ALLOW_ErrorCount,le.status_CUSTOM_ErrorCount
          ,le.orig_license_number_ALLOW_ErrorCount,le.orig_license_number_CUSTOM_ErrorCount
          ,le.license_number_ALLOW_ErrorCount,le.license_number_CUSTOM_ErrorCount
          ,le.previous_license_number_ALLOW_ErrorCount
          ,le.previous_license_type_ALLOW_ErrorCount,le.previous_license_type_CUSTOM_ErrorCount
          ,le.name_order_ALLOW_ErrorCount
          ,le.former_name_order_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_st_CAPS_ErrorCount,le.orig_st_ALLOW_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_CUSTOM_ErrorCount
          ,le.business_flag_CAPS_ErrorCount,le.business_flag_ENUM_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_CUSTOM_ErrorCount
          ,le.sex_ENUM_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.issue_date_ALLOW_ErrorCount,le.issue_date_CUSTOM_ErrorCount,le.issue_date_LENGTH_ErrorCount
          ,le.expiration_date_ALLOW_ErrorCount,le.expiration_date_CUSTOM_ErrorCount,le.expiration_date_LENGTH_ErrorCount
          ,le.last_renewal_date_ALLOW_ErrorCount,le.last_renewal_date_CUSTOM_ErrorCount
          ,le.license_obtained_by_ALLOW_ErrorCount,le.license_obtained_by_CUSTOM_ErrorCount
          ,le.board_action_indicator_CAPS_ErrorCount,le.board_action_indicator_ENUM_ErrorCount
          ,le.source_st_CAPS_ErrorCount,le.source_st_ALLOW_ErrorCount
          ,le.vendor_ALLOW_ErrorCount,le.vendor_CUSTOM_ErrorCount
          ,le.action_record_type_CUSTOM_ErrorCount
          ,le.action_complaint_violation_cds_CUSTOM_ErrorCount
          ,le.action_complaint_violation_dt_ALLOW_ErrorCount,le.action_complaint_violation_dt_CUSTOM_ErrorCount
          ,le.action_case_number_ALLOW_ErrorCount,le.action_case_number_CUSTOM_ErrorCount
          ,le.action_effective_dt_ALLOW_ErrorCount,le.action_effective_dt_CUSTOM_ErrorCount
          ,le.action_cds_CAPS_ErrorCount,le.action_cds_ALLOW_ErrorCount
          ,le.action_final_order_no_CUSTOM_ErrorCount
          ,le.action_status_ALLOW_ErrorCount,le.action_status_CUSTOM_ErrorCount
          ,le.action_posting_status_dt_ALLOW_ErrorCount,le.action_posting_status_dt_CUSTOM_ErrorCount
          ,le.additional_name_addr_type_ALLOW_ErrorCount,le.additional_name_addr_type_CUSTOM_ErrorCount
          ,le.additional_name_order_ALLOW_ErrorCount
          ,le.additional_orig_city_ALLOW_ErrorCount,le.additional_orig_city_CUSTOM_ErrorCount
          ,le.additional_orig_st_CAPS_ErrorCount,le.additional_orig_st_ALLOW_ErrorCount
          ,le.additional_orig_zip_ALLOW_ErrorCount,le.additional_orig_zip_CUSTOM_ErrorCount
          ,le.additional_phone_ALLOW_ErrorCount,le.additional_phone_CUSTOM_ErrorCount,le.additional_phone_LENGTH_ErrorCount
          ,le.misc_occupation_ALLOW_ErrorCount,le.misc_occupation_CUSTOM_ErrorCount
          ,le.misc_practice_hours_ALLOW_ErrorCount,le.misc_practice_hours_CUSTOM_ErrorCount
          ,le.misc_practice_type_ALLOW_ErrorCount,le.misc_practice_type_CUSTOM_ErrorCount
          ,le.misc_fax_ALLOW_ErrorCount,le.misc_fax_CUSTOM_ErrorCount,le.misc_fax_LENGTH_ErrorCount
          ,le.misc_web_site_ALLOW_ErrorCount,le.misc_web_site_CUSTOM_ErrorCount
          ,le.misc_other_id_CUSTOM_ErrorCount
          ,le.misc_other_id_type_ALLOW_ErrorCount,le.misc_other_id_type_CUSTOM_ErrorCount
          ,le.education_continuing_education_ALLOW_ErrorCount,le.education_continuing_education_CUSTOM_ErrorCount
          ,le.education_1_dates_attended_ALLOW_ErrorCount,le.education_1_dates_attended_CUSTOM_ErrorCount
          ,le.education_1_curriculum_ALLOW_ErrorCount,le.education_1_curriculum_CUSTOM_ErrorCount
          ,le.education_1_degree_ALLOW_ErrorCount,le.education_1_degree_CUSTOM_ErrorCount
          ,le.education_2_dates_attended_ALLOW_ErrorCount,le.education_2_dates_attended_CUSTOM_ErrorCount
          ,le.education_2_curriculum_ALLOW_ErrorCount,le.education_2_curriculum_CUSTOM_ErrorCount
          ,le.education_2_degree_ALLOW_ErrorCount,le.education_2_degree_CUSTOM_ErrorCount
          ,le.education_3_dates_attended_ALLOW_ErrorCount,le.education_3_dates_attended_CUSTOM_ErrorCount
          ,le.education_3_curriculum_ALLOW_ErrorCount,le.education_3_curriculum_CUSTOM_ErrorCount
          ,le.education_3_degree_ALLOW_ErrorCount,le.education_3_degree_CUSTOM_ErrorCount
          ,le.personal_pob_cd_CAPS_ErrorCount,le.personal_pob_cd_ALLOW_ErrorCount
          ,le.personal_pob_desc_ALLOW_ErrorCount,le.personal_pob_desc_CUSTOM_ErrorCount
          ,le.personal_race_cd_CAPS_ErrorCount,le.personal_race_cd_ALLOW_ErrorCount
          ,le.personal_race_desc_ALLOW_ErrorCount
          ,le.status_status_cds_ALLOW_ErrorCount
          ,le.status_effective_dt_ALLOW_ErrorCount,le.status_effective_dt_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,124,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
