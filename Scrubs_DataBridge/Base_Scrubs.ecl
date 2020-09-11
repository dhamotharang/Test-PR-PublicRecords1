IMPORT SALT311,STD;
IMPORT Scrubs_DataBridge; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 48;
  EXPORT NumRulesFromFieldType := 48;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 48;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_DataBridge)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 clean_company_name_Invalid;
    UNSIGNED1 clean_telephone_num_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code5_Invalid;
    UNSIGNED1 mail_score_Invalid;
    UNSIGNED1 name_gender_Invalid;
    UNSIGNED1 web_address_Invalid;
    UNSIGNED1 sic8_1_Invalid;
    UNSIGNED1 sic8_2_Invalid;
    UNSIGNED1 sic8_3_Invalid;
    UNSIGNED1 sic8_4_Invalid;
    UNSIGNED1 sic6_1_Invalid;
    UNSIGNED1 sic6_2_Invalid;
    UNSIGNED1 sic6_3_Invalid;
    UNSIGNED1 sic6_4_Invalid;
    UNSIGNED1 sic6_5_Invalid;
    UNSIGNED1 transaction_date_Invalid;
    UNSIGNED1 database_site_id_Invalid;
    UNSIGNED1 database_individual_id_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 email_present_flag_Invalid;
    UNSIGNED1 site_source1_Invalid;
    UNSIGNED1 site_source2_Invalid;
    UNSIGNED1 site_source3_Invalid;
    UNSIGNED1 site_source4_Invalid;
    UNSIGNED1 site_source5_Invalid;
    UNSIGNED1 site_source6_Invalid;
    UNSIGNED1 site_source7_Invalid;
    UNSIGNED1 site_source8_Invalid;
    UNSIGNED1 site_source9_Invalid;
    UNSIGNED1 site_source10_Invalid;
    UNSIGNED1 individual_source1_Invalid;
    UNSIGNED1 individual_source2_Invalid;
    UNSIGNED1 individual_source3_Invalid;
    UNSIGNED1 individual_source4_Invalid;
    UNSIGNED1 individual_source5_Invalid;
    UNSIGNED1 individual_source6_Invalid;
    UNSIGNED1 individual_source7_Invalid;
    UNSIGNED1 individual_source8_Invalid;
    UNSIGNED1 individual_source9_Invalid;
    UNSIGNED1 individual_source10_Invalid;
    UNSIGNED1 email_status_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_DataBridge)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_DataBridge) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.process_date_Invalid := Base_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.clean_company_name_Invalid := Base_Fields.InValid_clean_company_name((SALT311.StrType)le.clean_company_name);
    SELF.clean_telephone_num_Invalid := Base_Fields.InValid_clean_telephone_num((SALT311.StrType)le.clean_telephone_num);
    SELF.state_Invalid := Base_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_code5_Invalid := Base_Fields.InValid_zip_code5((SALT311.StrType)le.zip_code5);
    SELF.mail_score_Invalid := Base_Fields.InValid_mail_score((SALT311.StrType)le.mail_score);
    SELF.name_gender_Invalid := Base_Fields.InValid_name_gender((SALT311.StrType)le.name_gender);
    SELF.web_address_Invalid := Base_Fields.InValid_web_address((SALT311.StrType)le.web_address);
    SELF.sic8_1_Invalid := Base_Fields.InValid_sic8_1((SALT311.StrType)le.sic8_1);
    SELF.sic8_2_Invalid := Base_Fields.InValid_sic8_2((SALT311.StrType)le.sic8_2);
    SELF.sic8_3_Invalid := Base_Fields.InValid_sic8_3((SALT311.StrType)le.sic8_3);
    SELF.sic8_4_Invalid := Base_Fields.InValid_sic8_4((SALT311.StrType)le.sic8_4);
    SELF.sic6_1_Invalid := Base_Fields.InValid_sic6_1((SALT311.StrType)le.sic6_1);
    SELF.sic6_2_Invalid := Base_Fields.InValid_sic6_2((SALT311.StrType)le.sic6_2);
    SELF.sic6_3_Invalid := Base_Fields.InValid_sic6_3((SALT311.StrType)le.sic6_3);
    SELF.sic6_4_Invalid := Base_Fields.InValid_sic6_4((SALT311.StrType)le.sic6_4);
    SELF.sic6_5_Invalid := Base_Fields.InValid_sic6_5((SALT311.StrType)le.sic6_5);
    SELF.transaction_date_Invalid := Base_Fields.InValid_transaction_date((SALT311.StrType)le.transaction_date);
    SELF.database_site_id_Invalid := Base_Fields.InValid_database_site_id((SALT311.StrType)le.database_site_id);
    SELF.database_individual_id_Invalid := Base_Fields.InValid_database_individual_id((SALT311.StrType)le.database_individual_id);
    SELF.email_Invalid := Base_Fields.InValid_email((SALT311.StrType)le.email);
    SELF.email_present_flag_Invalid := Base_Fields.InValid_email_present_flag((SALT311.StrType)le.email_present_flag);
    SELF.site_source1_Invalid := Base_Fields.InValid_site_source1((SALT311.StrType)le.site_source1);
    SELF.site_source2_Invalid := Base_Fields.InValid_site_source2((SALT311.StrType)le.site_source2);
    SELF.site_source3_Invalid := Base_Fields.InValid_site_source3((SALT311.StrType)le.site_source3);
    SELF.site_source4_Invalid := Base_Fields.InValid_site_source4((SALT311.StrType)le.site_source4);
    SELF.site_source5_Invalid := Base_Fields.InValid_site_source5((SALT311.StrType)le.site_source5);
    SELF.site_source6_Invalid := Base_Fields.InValid_site_source6((SALT311.StrType)le.site_source6);
    SELF.site_source7_Invalid := Base_Fields.InValid_site_source7((SALT311.StrType)le.site_source7);
    SELF.site_source8_Invalid := Base_Fields.InValid_site_source8((SALT311.StrType)le.site_source8);
    SELF.site_source9_Invalid := Base_Fields.InValid_site_source9((SALT311.StrType)le.site_source9);
    SELF.site_source10_Invalid := Base_Fields.InValid_site_source10((SALT311.StrType)le.site_source10);
    SELF.individual_source1_Invalid := Base_Fields.InValid_individual_source1((SALT311.StrType)le.individual_source1);
    SELF.individual_source2_Invalid := Base_Fields.InValid_individual_source2((SALT311.StrType)le.individual_source2);
    SELF.individual_source3_Invalid := Base_Fields.InValid_individual_source3((SALT311.StrType)le.individual_source3);
    SELF.individual_source4_Invalid := Base_Fields.InValid_individual_source4((SALT311.StrType)le.individual_source4);
    SELF.individual_source5_Invalid := Base_Fields.InValid_individual_source5((SALT311.StrType)le.individual_source5);
    SELF.individual_source6_Invalid := Base_Fields.InValid_individual_source6((SALT311.StrType)le.individual_source6);
    SELF.individual_source7_Invalid := Base_Fields.InValid_individual_source7((SALT311.StrType)le.individual_source7);
    SELF.individual_source8_Invalid := Base_Fields.InValid_individual_source8((SALT311.StrType)le.individual_source8);
    SELF.individual_source9_Invalid := Base_Fields.InValid_individual_source9((SALT311.StrType)le.individual_source9);
    SELF.individual_source10_Invalid := Base_Fields.InValid_individual_source10((SALT311.StrType)le.individual_source10);
    SELF.email_status_Invalid := Base_Fields.InValid_email_status((SALT311.StrType)le.email_status);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_DataBridge);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.process_date_Invalid << 4 ) + ( le.record_type_Invalid << 5 ) + ( le.clean_company_name_Invalid << 6 ) + ( le.clean_telephone_num_Invalid << 7 ) + ( le.state_Invalid << 8 ) + ( le.zip_code5_Invalid << 9 ) + ( le.mail_score_Invalid << 10 ) + ( le.name_gender_Invalid << 11 ) + ( le.web_address_Invalid << 12 ) + ( le.sic8_1_Invalid << 13 ) + ( le.sic8_2_Invalid << 14 ) + ( le.sic8_3_Invalid << 15 ) + ( le.sic8_4_Invalid << 16 ) + ( le.sic6_1_Invalid << 17 ) + ( le.sic6_2_Invalid << 18 ) + ( le.sic6_3_Invalid << 19 ) + ( le.sic6_4_Invalid << 20 ) + ( le.sic6_5_Invalid << 21 ) + ( le.transaction_date_Invalid << 22 ) + ( le.database_site_id_Invalid << 23 ) + ( le.database_individual_id_Invalid << 24 ) + ( le.email_Invalid << 25 ) + ( le.email_present_flag_Invalid << 26 ) + ( le.site_source1_Invalid << 27 ) + ( le.site_source2_Invalid << 28 ) + ( le.site_source3_Invalid << 29 ) + ( le.site_source4_Invalid << 30 ) + ( le.site_source5_Invalid << 31 ) + ( le.site_source6_Invalid << 32 ) + ( le.site_source7_Invalid << 33 ) + ( le.site_source8_Invalid << 34 ) + ( le.site_source9_Invalid << 35 ) + ( le.site_source10_Invalid << 36 ) + ( le.individual_source1_Invalid << 37 ) + ( le.individual_source2_Invalid << 38 ) + ( le.individual_source3_Invalid << 39 ) + ( le.individual_source4_Invalid << 40 ) + ( le.individual_source5_Invalid << 41 ) + ( le.individual_source6_Invalid << 42 ) + ( le.individual_source7_Invalid << 43 ) + ( le.individual_source8_Invalid << 44 ) + ( le.individual_source9_Invalid << 45 ) + ( le.individual_source10_Invalid << 46 ) + ( le.email_status_Invalid << 47 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_DataBridge);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.clean_company_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.clean_telephone_num_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.zip_code5_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.mail_score_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.name_gender_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.web_address_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sic8_1_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.sic8_2_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.sic8_3_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.sic8_4_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sic6_1_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.sic6_2_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.sic6_3_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.sic6_4_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.sic6_5_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.transaction_date_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.database_site_id_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.database_individual_id_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.email_present_flag_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.site_source1_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.site_source2_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.site_source3_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.site_source4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.site_source5_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.site_source6_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.site_source7_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.site_source8_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.site_source9_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.site_source10_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.individual_source1_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.individual_source2_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.individual_source3_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.individual_source4_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.individual_source5_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.individual_source6_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.individual_source7_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.individual_source8_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.individual_source9_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.individual_source10_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.email_status_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    clean_company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=1);
    clean_telephone_num_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_telephone_num_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code5_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code5_Invalid=1);
    mail_score_ENUM_ErrorCount := COUNT(GROUP,h.mail_score_Invalid=1);
    name_gender_ENUM_ErrorCount := COUNT(GROUP,h.name_gender_Invalid=1);
    web_address_CUSTOM_ErrorCount := COUNT(GROUP,h.web_address_Invalid=1);
    sic8_1_CUSTOM_ErrorCount := COUNT(GROUP,h.sic8_1_Invalid=1);
    sic8_2_CUSTOM_ErrorCount := COUNT(GROUP,h.sic8_2_Invalid=1);
    sic8_3_CUSTOM_ErrorCount := COUNT(GROUP,h.sic8_3_Invalid=1);
    sic8_4_CUSTOM_ErrorCount := COUNT(GROUP,h.sic8_4_Invalid=1);
    sic6_1_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6_1_Invalid=1);
    sic6_2_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6_2_Invalid=1);
    sic6_3_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6_3_Invalid=1);
    sic6_4_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6_4_Invalid=1);
    sic6_5_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6_5_Invalid=1);
    transaction_date_CUSTOM_ErrorCount := COUNT(GROUP,h.transaction_date_Invalid=1);
    database_site_id_CUSTOM_ErrorCount := COUNT(GROUP,h.database_site_id_Invalid=1);
    database_individual_id_CUSTOM_ErrorCount := COUNT(GROUP,h.database_individual_id_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    email_present_flag_ENUM_ErrorCount := COUNT(GROUP,h.email_present_flag_Invalid=1);
    site_source1_ENUM_ErrorCount := COUNT(GROUP,h.site_source1_Invalid=1);
    site_source2_ENUM_ErrorCount := COUNT(GROUP,h.site_source2_Invalid=1);
    site_source3_ENUM_ErrorCount := COUNT(GROUP,h.site_source3_Invalid=1);
    site_source4_ENUM_ErrorCount := COUNT(GROUP,h.site_source4_Invalid=1);
    site_source5_ENUM_ErrorCount := COUNT(GROUP,h.site_source5_Invalid=1);
    site_source6_ENUM_ErrorCount := COUNT(GROUP,h.site_source6_Invalid=1);
    site_source7_ENUM_ErrorCount := COUNT(GROUP,h.site_source7_Invalid=1);
    site_source8_ENUM_ErrorCount := COUNT(GROUP,h.site_source8_Invalid=1);
    site_source9_ENUM_ErrorCount := COUNT(GROUP,h.site_source9_Invalid=1);
    site_source10_ENUM_ErrorCount := COUNT(GROUP,h.site_source10_Invalid=1);
    individual_source1_ENUM_ErrorCount := COUNT(GROUP,h.individual_source1_Invalid=1);
    individual_source2_ENUM_ErrorCount := COUNT(GROUP,h.individual_source2_Invalid=1);
    individual_source3_ENUM_ErrorCount := COUNT(GROUP,h.individual_source3_Invalid=1);
    individual_source4_ENUM_ErrorCount := COUNT(GROUP,h.individual_source4_Invalid=1);
    individual_source5_ENUM_ErrorCount := COUNT(GROUP,h.individual_source5_Invalid=1);
    individual_source6_ENUM_ErrorCount := COUNT(GROUP,h.individual_source6_Invalid=1);
    individual_source7_ENUM_ErrorCount := COUNT(GROUP,h.individual_source7_Invalid=1);
    individual_source8_ENUM_ErrorCount := COUNT(GROUP,h.individual_source8_Invalid=1);
    individual_source9_ENUM_ErrorCount := COUNT(GROUP,h.individual_source9_Invalid=1);
    individual_source10_ENUM_ErrorCount := COUNT(GROUP,h.individual_source10_Invalid=1);
    email_status_ENUM_ErrorCount := COUNT(GROUP,h.email_status_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.record_type_Invalid > 0 OR h.clean_company_name_Invalid > 0 OR h.clean_telephone_num_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_code5_Invalid > 0 OR h.mail_score_Invalid > 0 OR h.name_gender_Invalid > 0 OR h.web_address_Invalid > 0 OR h.sic8_1_Invalid > 0 OR h.sic8_2_Invalid > 0 OR h.sic8_3_Invalid > 0 OR h.sic8_4_Invalid > 0 OR h.sic6_1_Invalid > 0 OR h.sic6_2_Invalid > 0 OR h.sic6_3_Invalid > 0 OR h.sic6_4_Invalid > 0 OR h.sic6_5_Invalid > 0 OR h.transaction_date_Invalid > 0 OR h.database_site_id_Invalid > 0 OR h.database_individual_id_Invalid > 0 OR h.email_Invalid > 0 OR h.email_present_flag_Invalid > 0 OR h.site_source1_Invalid > 0 OR h.site_source2_Invalid > 0 OR h.site_source3_Invalid > 0 OR h.site_source4_Invalid > 0 OR h.site_source5_Invalid > 0 OR h.site_source6_Invalid > 0 OR h.site_source7_Invalid > 0 OR h.site_source8_Invalid > 0 OR h.site_source9_Invalid > 0 OR h.site_source10_Invalid > 0 OR h.individual_source1_Invalid > 0 OR h.individual_source2_Invalid > 0 OR h.individual_source3_Invalid > 0 OR h.individual_source4_Invalid > 0 OR h.individual_source5_Invalid > 0 OR h.individual_source6_Invalid > 0 OR h.individual_source7_Invalid > 0 OR h.individual_source8_Invalid > 0 OR h.individual_source9_Invalid > 0 OR h.individual_source10_Invalid > 0 OR h.email_status_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_telephone_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.web_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transaction_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.database_site_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.database_individual_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_present_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source1_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source2_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source3_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source4_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source5_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source6_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source7_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source8_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source9_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source10_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source1_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source2_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source3_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source4_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source5_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source6_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source7_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source8_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source9_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source10_ENUM_ErrorCount > 0, 1, 0) + IF(le.email_status_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_telephone_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_score_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.web_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic8_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic6_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.transaction_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.database_site_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.database_individual_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_present_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source1_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source2_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source3_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source4_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source5_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source6_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source7_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source8_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source9_ENUM_ErrorCount > 0, 1, 0) + IF(le.site_source10_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source1_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source2_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source3_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source4_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source5_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source6_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source7_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source8_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source9_ENUM_ErrorCount > 0, 1, 0) + IF(le.individual_source10_ENUM_ErrorCount > 0, 1, 0) + IF(le.email_status_ENUM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.clean_company_name_Invalid,le.clean_telephone_num_Invalid,le.state_Invalid,le.zip_code5_Invalid,le.mail_score_Invalid,le.name_gender_Invalid,le.web_address_Invalid,le.sic8_1_Invalid,le.sic8_2_Invalid,le.sic8_3_Invalid,le.sic8_4_Invalid,le.sic6_1_Invalid,le.sic6_2_Invalid,le.sic6_3_Invalid,le.sic6_4_Invalid,le.sic6_5_Invalid,le.transaction_date_Invalid,le.database_site_id_Invalid,le.database_individual_id_Invalid,le.email_Invalid,le.email_present_flag_Invalid,le.site_source1_Invalid,le.site_source2_Invalid,le.site_source3_Invalid,le.site_source4_Invalid,le.site_source5_Invalid,le.site_source6_Invalid,le.site_source7_Invalid,le.site_source8_Invalid,le.site_source9_Invalid,le.site_source10_Invalid,le.individual_source1_Invalid,le.individual_source2_Invalid,le.individual_source3_Invalid,le.individual_source4_Invalid,le.individual_source5_Invalid,le.individual_source6_Invalid,le.individual_source7_Invalid,le.individual_source8_Invalid,le.individual_source9_Invalid,le.individual_source10_Invalid,le.email_status_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_clean_company_name(le.clean_company_name_Invalid),Base_Fields.InvalidMessage_clean_telephone_num(le.clean_telephone_num_Invalid),Base_Fields.InvalidMessage_state(le.state_Invalid),Base_Fields.InvalidMessage_zip_code5(le.zip_code5_Invalid),Base_Fields.InvalidMessage_mail_score(le.mail_score_Invalid),Base_Fields.InvalidMessage_name_gender(le.name_gender_Invalid),Base_Fields.InvalidMessage_web_address(le.web_address_Invalid),Base_Fields.InvalidMessage_sic8_1(le.sic8_1_Invalid),Base_Fields.InvalidMessage_sic8_2(le.sic8_2_Invalid),Base_Fields.InvalidMessage_sic8_3(le.sic8_3_Invalid),Base_Fields.InvalidMessage_sic8_4(le.sic8_4_Invalid),Base_Fields.InvalidMessage_sic6_1(le.sic6_1_Invalid),Base_Fields.InvalidMessage_sic6_2(le.sic6_2_Invalid),Base_Fields.InvalidMessage_sic6_3(le.sic6_3_Invalid),Base_Fields.InvalidMessage_sic6_4(le.sic6_4_Invalid),Base_Fields.InvalidMessage_sic6_5(le.sic6_5_Invalid),Base_Fields.InvalidMessage_transaction_date(le.transaction_date_Invalid),Base_Fields.InvalidMessage_database_site_id(le.database_site_id_Invalid),Base_Fields.InvalidMessage_database_individual_id(le.database_individual_id_Invalid),Base_Fields.InvalidMessage_email(le.email_Invalid),Base_Fields.InvalidMessage_email_present_flag(le.email_present_flag_Invalid),Base_Fields.InvalidMessage_site_source1(le.site_source1_Invalid),Base_Fields.InvalidMessage_site_source2(le.site_source2_Invalid),Base_Fields.InvalidMessage_site_source3(le.site_source3_Invalid),Base_Fields.InvalidMessage_site_source4(le.site_source4_Invalid),Base_Fields.InvalidMessage_site_source5(le.site_source5_Invalid),Base_Fields.InvalidMessage_site_source6(le.site_source6_Invalid),Base_Fields.InvalidMessage_site_source7(le.site_source7_Invalid),Base_Fields.InvalidMessage_site_source8(le.site_source8_Invalid),Base_Fields.InvalidMessage_site_source9(le.site_source9_Invalid),Base_Fields.InvalidMessage_site_source10(le.site_source10_Invalid),Base_Fields.InvalidMessage_individual_source1(le.individual_source1_Invalid),Base_Fields.InvalidMessage_individual_source2(le.individual_source2_Invalid),Base_Fields.InvalidMessage_individual_source3(le.individual_source3_Invalid),Base_Fields.InvalidMessage_individual_source4(le.individual_source4_Invalid),Base_Fields.InvalidMessage_individual_source5(le.individual_source5_Invalid),Base_Fields.InvalidMessage_individual_source6(le.individual_source6_Invalid),Base_Fields.InvalidMessage_individual_source7(le.individual_source7_Invalid),Base_Fields.InvalidMessage_individual_source8(le.individual_source8_Invalid),Base_Fields.InvalidMessage_individual_source9(le.individual_source9_Invalid),Base_Fields.InvalidMessage_individual_source10(le.individual_source10_Invalid),Base_Fields.InvalidMessage_email_status(le.email_status_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_company_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_telephone_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_score_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.name_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.web_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic8_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic8_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic8_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic8_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.transaction_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.database_site_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.database_individual_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email_present_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.site_source10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.individual_source10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.email_status_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_telephone_num','state','zip_code5','mail_score','name_gender','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_generaldate','invalid_record_type','invalid_mandatory','invalid_phone','invalid_st','invalid_zip5','invalid_mail_score','invalid_gender_code','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_trans_date','invalid_numeric','invalid_numeric','invalid_email','invalid_email_present_flag','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_email_status','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.process_date,(SALT311.StrType)le.record_type,(SALT311.StrType)le.clean_company_name,(SALT311.StrType)le.clean_telephone_num,(SALT311.StrType)le.state,(SALT311.StrType)le.zip_code5,(SALT311.StrType)le.mail_score,(SALT311.StrType)le.name_gender,(SALT311.StrType)le.web_address,(SALT311.StrType)le.sic8_1,(SALT311.StrType)le.sic8_2,(SALT311.StrType)le.sic8_3,(SALT311.StrType)le.sic8_4,(SALT311.StrType)le.sic6_1,(SALT311.StrType)le.sic6_2,(SALT311.StrType)le.sic6_3,(SALT311.StrType)le.sic6_4,(SALT311.StrType)le.sic6_5,(SALT311.StrType)le.transaction_date,(SALT311.StrType)le.database_site_id,(SALT311.StrType)le.database_individual_id,(SALT311.StrType)le.email,(SALT311.StrType)le.email_present_flag,(SALT311.StrType)le.site_source1,(SALT311.StrType)le.site_source2,(SALT311.StrType)le.site_source3,(SALT311.StrType)le.site_source4,(SALT311.StrType)le.site_source5,(SALT311.StrType)le.site_source6,(SALT311.StrType)le.site_source7,(SALT311.StrType)le.site_source8,(SALT311.StrType)le.site_source9,(SALT311.StrType)le.site_source10,(SALT311.StrType)le.individual_source1,(SALT311.StrType)le.individual_source2,(SALT311.StrType)le.individual_source3,(SALT311.StrType)le.individual_source4,(SALT311.StrType)le.individual_source5,(SALT311.StrType)le.individual_source6,(SALT311.StrType)le.individual_source7,(SALT311.StrType)le.individual_source8,(SALT311.StrType)le.individual_source9,(SALT311.StrType)le.individual_source10,(SALT311.StrType)le.email_status,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,48,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_DataBridge) prevDS = DATASET([], Base_Layout_DataBridge), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:invalid_pastdate:CUSTOM'
          ,'dt_last_seen:invalid_pastdate:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate:CUSTOM'
          ,'process_date:invalid_generaldate:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'clean_company_name:invalid_mandatory:LENGTHS'
          ,'clean_telephone_num:invalid_phone:CUSTOM'
          ,'state:invalid_st:CUSTOM'
          ,'zip_code5:invalid_zip5:CUSTOM'
          ,'mail_score:invalid_mail_score:ENUM'
          ,'name_gender:invalid_gender_code:ENUM'
          ,'web_address:invalid_url:CUSTOM'
          ,'sic8_1:invalid_sic:CUSTOM'
          ,'sic8_2:invalid_sic:CUSTOM'
          ,'sic8_3:invalid_sic:CUSTOM'
          ,'sic8_4:invalid_sic:CUSTOM'
          ,'sic6_1:invalid_sic:CUSTOM'
          ,'sic6_2:invalid_sic:CUSTOM'
          ,'sic6_3:invalid_sic:CUSTOM'
          ,'sic6_4:invalid_sic:CUSTOM'
          ,'sic6_5:invalid_sic:CUSTOM'
          ,'transaction_date:invalid_trans_date:CUSTOM'
          ,'database_site_id:invalid_numeric:CUSTOM'
          ,'database_individual_id:invalid_numeric:CUSTOM'
          ,'email:invalid_email:ALLOW'
          ,'email_present_flag:invalid_email_present_flag:ENUM'
          ,'site_source1:invalid_source_code:ENUM'
          ,'site_source2:invalid_source_code:ENUM'
          ,'site_source3:invalid_source_code:ENUM'
          ,'site_source4:invalid_source_code:ENUM'
          ,'site_source5:invalid_source_code:ENUM'
          ,'site_source6:invalid_source_code:ENUM'
          ,'site_source7:invalid_source_code:ENUM'
          ,'site_source8:invalid_source_code:ENUM'
          ,'site_source9:invalid_source_code:ENUM'
          ,'site_source10:invalid_source_code:ENUM'
          ,'individual_source1:invalid_source_code:ENUM'
          ,'individual_source2:invalid_source_code:ENUM'
          ,'individual_source3:invalid_source_code:ENUM'
          ,'individual_source4:invalid_source_code:ENUM'
          ,'individual_source5:invalid_source_code:ENUM'
          ,'individual_source6:invalid_source_code:ENUM'
          ,'individual_source7:invalid_source_code:ENUM'
          ,'individual_source8:invalid_source_code:ENUM'
          ,'individual_source9:invalid_source_code:ENUM'
          ,'individual_source10:invalid_source_code:ENUM'
          ,'email_status:invalid_email_status:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_process_date(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_clean_company_name(1)
          ,Base_Fields.InvalidMessage_clean_telephone_num(1)
          ,Base_Fields.InvalidMessage_state(1)
          ,Base_Fields.InvalidMessage_zip_code5(1)
          ,Base_Fields.InvalidMessage_mail_score(1)
          ,Base_Fields.InvalidMessage_name_gender(1)
          ,Base_Fields.InvalidMessage_web_address(1)
          ,Base_Fields.InvalidMessage_sic8_1(1)
          ,Base_Fields.InvalidMessage_sic8_2(1)
          ,Base_Fields.InvalidMessage_sic8_3(1)
          ,Base_Fields.InvalidMessage_sic8_4(1)
          ,Base_Fields.InvalidMessage_sic6_1(1)
          ,Base_Fields.InvalidMessage_sic6_2(1)
          ,Base_Fields.InvalidMessage_sic6_3(1)
          ,Base_Fields.InvalidMessage_sic6_4(1)
          ,Base_Fields.InvalidMessage_sic6_5(1)
          ,Base_Fields.InvalidMessage_transaction_date(1)
          ,Base_Fields.InvalidMessage_database_site_id(1)
          ,Base_Fields.InvalidMessage_database_individual_id(1)
          ,Base_Fields.InvalidMessage_email(1)
          ,Base_Fields.InvalidMessage_email_present_flag(1)
          ,Base_Fields.InvalidMessage_site_source1(1)
          ,Base_Fields.InvalidMessage_site_source2(1)
          ,Base_Fields.InvalidMessage_site_source3(1)
          ,Base_Fields.InvalidMessage_site_source4(1)
          ,Base_Fields.InvalidMessage_site_source5(1)
          ,Base_Fields.InvalidMessage_site_source6(1)
          ,Base_Fields.InvalidMessage_site_source7(1)
          ,Base_Fields.InvalidMessage_site_source8(1)
          ,Base_Fields.InvalidMessage_site_source9(1)
          ,Base_Fields.InvalidMessage_site_source10(1)
          ,Base_Fields.InvalidMessage_individual_source1(1)
          ,Base_Fields.InvalidMessage_individual_source2(1)
          ,Base_Fields.InvalidMessage_individual_source3(1)
          ,Base_Fields.InvalidMessage_individual_source4(1)
          ,Base_Fields.InvalidMessage_individual_source5(1)
          ,Base_Fields.InvalidMessage_individual_source6(1)
          ,Base_Fields.InvalidMessage_individual_source7(1)
          ,Base_Fields.InvalidMessage_individual_source8(1)
          ,Base_Fields.InvalidMessage_individual_source9(1)
          ,Base_Fields.InvalidMessage_individual_source10(1)
          ,Base_Fields.InvalidMessage_email_status(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.clean_company_name_LENGTHS_ErrorCount
          ,le.clean_telephone_num_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code5_CUSTOM_ErrorCount
          ,le.mail_score_ENUM_ErrorCount
          ,le.name_gender_ENUM_ErrorCount
          ,le.web_address_CUSTOM_ErrorCount
          ,le.sic8_1_CUSTOM_ErrorCount
          ,le.sic8_2_CUSTOM_ErrorCount
          ,le.sic8_3_CUSTOM_ErrorCount
          ,le.sic8_4_CUSTOM_ErrorCount
          ,le.sic6_1_CUSTOM_ErrorCount
          ,le.sic6_2_CUSTOM_ErrorCount
          ,le.sic6_3_CUSTOM_ErrorCount
          ,le.sic6_4_CUSTOM_ErrorCount
          ,le.sic6_5_CUSTOM_ErrorCount
          ,le.transaction_date_CUSTOM_ErrorCount
          ,le.database_site_id_CUSTOM_ErrorCount
          ,le.database_individual_id_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.email_present_flag_ENUM_ErrorCount
          ,le.site_source1_ENUM_ErrorCount
          ,le.site_source2_ENUM_ErrorCount
          ,le.site_source3_ENUM_ErrorCount
          ,le.site_source4_ENUM_ErrorCount
          ,le.site_source5_ENUM_ErrorCount
          ,le.site_source6_ENUM_ErrorCount
          ,le.site_source7_ENUM_ErrorCount
          ,le.site_source8_ENUM_ErrorCount
          ,le.site_source9_ENUM_ErrorCount
          ,le.site_source10_ENUM_ErrorCount
          ,le.individual_source1_ENUM_ErrorCount
          ,le.individual_source2_ENUM_ErrorCount
          ,le.individual_source3_ENUM_ErrorCount
          ,le.individual_source4_ENUM_ErrorCount
          ,le.individual_source5_ENUM_ErrorCount
          ,le.individual_source6_ENUM_ErrorCount
          ,le.individual_source7_ENUM_ErrorCount
          ,le.individual_source8_ENUM_ErrorCount
          ,le.individual_source9_ENUM_ErrorCount
          ,le.individual_source10_ENUM_ErrorCount
          ,le.email_status_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.clean_company_name_LENGTHS_ErrorCount
          ,le.clean_telephone_num_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code5_CUSTOM_ErrorCount
          ,le.mail_score_ENUM_ErrorCount
          ,le.name_gender_ENUM_ErrorCount
          ,le.web_address_CUSTOM_ErrorCount
          ,le.sic8_1_CUSTOM_ErrorCount
          ,le.sic8_2_CUSTOM_ErrorCount
          ,le.sic8_3_CUSTOM_ErrorCount
          ,le.sic8_4_CUSTOM_ErrorCount
          ,le.sic6_1_CUSTOM_ErrorCount
          ,le.sic6_2_CUSTOM_ErrorCount
          ,le.sic6_3_CUSTOM_ErrorCount
          ,le.sic6_4_CUSTOM_ErrorCount
          ,le.sic6_5_CUSTOM_ErrorCount
          ,le.transaction_date_CUSTOM_ErrorCount
          ,le.database_site_id_CUSTOM_ErrorCount
          ,le.database_individual_id_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.email_present_flag_ENUM_ErrorCount
          ,le.site_source1_ENUM_ErrorCount
          ,le.site_source2_ENUM_ErrorCount
          ,le.site_source3_ENUM_ErrorCount
          ,le.site_source4_ENUM_ErrorCount
          ,le.site_source5_ENUM_ErrorCount
          ,le.site_source6_ENUM_ErrorCount
          ,le.site_source7_ENUM_ErrorCount
          ,le.site_source8_ENUM_ErrorCount
          ,le.site_source9_ENUM_ErrorCount
          ,le.site_source10_ENUM_ErrorCount
          ,le.individual_source1_ENUM_ErrorCount
          ,le.individual_source2_ENUM_ErrorCount
          ,le.individual_source3_ENUM_ErrorCount
          ,le.individual_source4_ENUM_ErrorCount
          ,le.individual_source5_ENUM_ErrorCount
          ,le.individual_source6_ENUM_ErrorCount
          ,le.individual_source7_ENUM_ErrorCount
          ,le.individual_source8_ENUM_ErrorCount
          ,le.individual_source9_ENUM_ErrorCount
          ,le.individual_source10_ENUM_ErrorCount
          ,le.email_status_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_DataBridge));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_company_name:' + getFieldTypeText(h.clean_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_telephone_num:' + getFieldTypeText(h.clean_telephone_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code5:' + getFieldTypeText(h.zip_code5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_score:' + getFieldTypeText(h.mail_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_gender:' + getFieldTypeText(h.name_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'web_address:' + getFieldTypeText(h.web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic8_1:' + getFieldTypeText(h.sic8_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic8_2:' + getFieldTypeText(h.sic8_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic8_3:' + getFieldTypeText(h.sic8_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic8_4:' + getFieldTypeText(h.sic8_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic6_1:' + getFieldTypeText(h.sic6_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic6_2:' + getFieldTypeText(h.sic6_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic6_3:' + getFieldTypeText(h.sic6_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic6_4:' + getFieldTypeText(h.sic6_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic6_5:' + getFieldTypeText(h.sic6_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_date:' + getFieldTypeText(h.transaction_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'database_site_id:' + getFieldTypeText(h.database_site_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'database_individual_id:' + getFieldTypeText(h.database_individual_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_present_flag:' + getFieldTypeText(h.email_present_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source1:' + getFieldTypeText(h.site_source1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source2:' + getFieldTypeText(h.site_source2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source3:' + getFieldTypeText(h.site_source3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source4:' + getFieldTypeText(h.site_source4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source5:' + getFieldTypeText(h.site_source5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source6:' + getFieldTypeText(h.site_source6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source7:' + getFieldTypeText(h.site_source7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source8:' + getFieldTypeText(h.site_source8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source9:' + getFieldTypeText(h.site_source9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_source10:' + getFieldTypeText(h.site_source10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source1:' + getFieldTypeText(h.individual_source1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source2:' + getFieldTypeText(h.individual_source2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source3:' + getFieldTypeText(h.individual_source3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source4:' + getFieldTypeText(h.individual_source4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source5:' + getFieldTypeText(h.individual_source5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source6:' + getFieldTypeText(h.individual_source6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source7:' + getFieldTypeText(h.individual_source7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source8:' + getFieldTypeText(h.individual_source8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source9:' + getFieldTypeText(h.individual_source9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'individual_source10:' + getFieldTypeText(h.individual_source10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_status:' + getFieldTypeText(h.email_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_record_type_cnt
          ,le.populated_clean_company_name_cnt
          ,le.populated_clean_telephone_num_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code5_cnt
          ,le.populated_mail_score_cnt
          ,le.populated_name_gender_cnt
          ,le.populated_web_address_cnt
          ,le.populated_sic8_1_cnt
          ,le.populated_sic8_2_cnt
          ,le.populated_sic8_3_cnt
          ,le.populated_sic8_4_cnt
          ,le.populated_sic6_1_cnt
          ,le.populated_sic6_2_cnt
          ,le.populated_sic6_3_cnt
          ,le.populated_sic6_4_cnt
          ,le.populated_sic6_5_cnt
          ,le.populated_transaction_date_cnt
          ,le.populated_database_site_id_cnt
          ,le.populated_database_individual_id_cnt
          ,le.populated_email_cnt
          ,le.populated_email_present_flag_cnt
          ,le.populated_site_source1_cnt
          ,le.populated_site_source2_cnt
          ,le.populated_site_source3_cnt
          ,le.populated_site_source4_cnt
          ,le.populated_site_source5_cnt
          ,le.populated_site_source6_cnt
          ,le.populated_site_source7_cnt
          ,le.populated_site_source8_cnt
          ,le.populated_site_source9_cnt
          ,le.populated_site_source10_cnt
          ,le.populated_individual_source1_cnt
          ,le.populated_individual_source2_cnt
          ,le.populated_individual_source3_cnt
          ,le.populated_individual_source4_cnt
          ,le.populated_individual_source5_cnt
          ,le.populated_individual_source6_cnt
          ,le.populated_individual_source7_cnt
          ,le.populated_individual_source8_cnt
          ,le.populated_individual_source9_cnt
          ,le.populated_individual_source10_cnt
          ,le.populated_email_status_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_clean_company_name_pcnt
          ,le.populated_clean_telephone_num_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code5_pcnt
          ,le.populated_mail_score_pcnt
          ,le.populated_name_gender_pcnt
          ,le.populated_web_address_pcnt
          ,le.populated_sic8_1_pcnt
          ,le.populated_sic8_2_pcnt
          ,le.populated_sic8_3_pcnt
          ,le.populated_sic8_4_pcnt
          ,le.populated_sic6_1_pcnt
          ,le.populated_sic6_2_pcnt
          ,le.populated_sic6_3_pcnt
          ,le.populated_sic6_4_pcnt
          ,le.populated_sic6_5_pcnt
          ,le.populated_transaction_date_pcnt
          ,le.populated_database_site_id_pcnt
          ,le.populated_database_individual_id_pcnt
          ,le.populated_email_pcnt
          ,le.populated_email_present_flag_pcnt
          ,le.populated_site_source1_pcnt
          ,le.populated_site_source2_pcnt
          ,le.populated_site_source3_pcnt
          ,le.populated_site_source4_pcnt
          ,le.populated_site_source5_pcnt
          ,le.populated_site_source6_pcnt
          ,le.populated_site_source7_pcnt
          ,le.populated_site_source8_pcnt
          ,le.populated_site_source9_pcnt
          ,le.populated_site_source10_pcnt
          ,le.populated_individual_source1_pcnt
          ,le.populated_individual_source2_pcnt
          ,le.populated_individual_source3_pcnt
          ,le.populated_individual_source4_pcnt
          ,le.populated_individual_source5_pcnt
          ,le.populated_individual_source6_pcnt
          ,le.populated_individual_source7_pcnt
          ,le.populated_individual_source8_pcnt
          ,le.populated_individual_source9_pcnt
          ,le.populated_individual_source10_pcnt
          ,le.populated_email_status_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,48,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_DataBridge));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),48,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_DataBridge) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DataBridge, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
