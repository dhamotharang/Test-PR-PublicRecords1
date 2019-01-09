IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_5000_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 44;
  EXPORT NumRulesFromFieldType := 44;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 43;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_5000_Layout_EBR)
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 process_date_first_seen_Invalid;
    UNSIGNED1 process_date_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 file_number_Invalid;
    UNSIGNED1 segment_code_Invalid;
    UNSIGNED1 sequence_number_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 street_address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_code_Invalid;
    UNSIGNED1 state_desc_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 telephone_Invalid;
    UNSIGNED1 relationship_code_Invalid;
    UNSIGNED1 relationship_desc_Invalid;
    UNSIGNED1 bal_range_code_Invalid;
    UNSIGNED1 acct_bal_range_code_Invalid;
    UNSIGNED1 nbr_fig_in_bal_Invalid;
    UNSIGNED1 acct_bal_total_Invalid;
    UNSIGNED1 acct_rating_code_Invalid;
    UNSIGNED1 date_acct_opened_ymd_Invalid;
    UNSIGNED1 date_acct_closed_ymd_Invalid;
    UNSIGNED1 name_addr_key_Invalid;
    UNSIGNED1 append_rawaid_Invalid;
    UNSIGNED1 append_aceaid_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_last_line_Invalid;
    UNSIGNED1 clean_address_predir_Invalid;
    UNSIGNED1 clean_address_prim_name_Invalid;
    UNSIGNED1 clean_address_postdir_Invalid;
    UNSIGNED1 clean_address_p_city_name_Invalid;
    UNSIGNED1 clean_address_v_city_name_Invalid;
    UNSIGNED1 clean_address_st_Invalid;
    UNSIGNED1 clean_address_zip_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_5000_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_5000_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_5000_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_5000_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_5000_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_5000_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_5000_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_5000_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_5000_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_5000_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_5000_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_5000_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_5000_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_5000_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_5000_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.segment_code_Invalid := Base_5000_Fields.InValid_segment_code((SALT311.StrType)le.segment_code);
    SELF.sequence_number_Invalid := Base_5000_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number);
    SELF.name_Invalid := Base_5000_Fields.InValid_name((SALT311.StrType)le.name);
    SELF.street_address_Invalid := Base_5000_Fields.InValid_street_address((SALT311.StrType)le.street_address);
    SELF.city_Invalid := Base_5000_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_code_Invalid := Base_5000_Fields.InValid_state_code((SALT311.StrType)le.state_code);
    SELF.state_desc_Invalid := Base_5000_Fields.InValid_state_desc((SALT311.StrType)le.state_desc);
    SELF.zip_code_Invalid := Base_5000_Fields.InValid_zip_code((SALT311.StrType)le.zip_code);
    SELF.telephone_Invalid := Base_5000_Fields.InValid_telephone((SALT311.StrType)le.telephone);
    SELF.relationship_code_Invalid := Base_5000_Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code);
    SELF.relationship_desc_Invalid := Base_5000_Fields.InValid_relationship_desc((SALT311.StrType)le.relationship_desc);
    SELF.bal_range_code_Invalid := Base_5000_Fields.InValid_bal_range_code((SALT311.StrType)le.bal_range_code);
    SELF.acct_bal_range_code_Invalid := Base_5000_Fields.InValid_acct_bal_range_code((SALT311.StrType)le.acct_bal_range_code);
    SELF.nbr_fig_in_bal_Invalid := Base_5000_Fields.InValid_nbr_fig_in_bal((SALT311.StrType)le.nbr_fig_in_bal);
    SELF.acct_bal_total_Invalid := Base_5000_Fields.InValid_acct_bal_total((SALT311.StrType)le.acct_bal_total);
    SELF.acct_rating_code_Invalid := Base_5000_Fields.InValid_acct_rating_code((SALT311.StrType)le.acct_rating_code);
    SELF.date_acct_opened_ymd_Invalid := Base_5000_Fields.InValid_date_acct_opened_ymd((SALT311.StrType)le.date_acct_opened_ymd);
    SELF.date_acct_closed_ymd_Invalid := Base_5000_Fields.InValid_date_acct_closed_ymd((SALT311.StrType)le.date_acct_closed_ymd);
    SELF.name_addr_key_Invalid := Base_5000_Fields.InValid_name_addr_key((SALT311.StrType)le.name_addr_key);
    SELF.append_rawaid_Invalid := Base_5000_Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid);
    SELF.append_aceaid_Invalid := Base_5000_Fields.InValid_append_aceaid((SALT311.StrType)le.append_aceaid);
    SELF.prep_addr_line1_Invalid := Base_5000_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1);
    SELF.prep_addr_last_line_Invalid := Base_5000_Fields.InValid_prep_addr_last_line((SALT311.StrType)le.prep_addr_last_line);
    SELF.clean_address_predir_Invalid := Base_5000_Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address_predir);
    SELF.clean_address_prim_name_Invalid := Base_5000_Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name);
    SELF.clean_address_postdir_Invalid := Base_5000_Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address_postdir);
    SELF.clean_address_p_city_name_Invalid := Base_5000_Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name);
    SELF.clean_address_v_city_name_Invalid := Base_5000_Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name);
    SELF.clean_address_st_Invalid := Base_5000_Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st);
    SELF.clean_address_zip_Invalid := Base_5000_Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_5000_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.segment_code_Invalid << 14 ) + ( le.sequence_number_Invalid << 15 ) + ( le.name_Invalid << 16 ) + ( le.street_address_Invalid << 17 ) + ( le.city_Invalid << 18 ) + ( le.state_code_Invalid << 19 ) + ( le.state_desc_Invalid << 20 ) + ( le.zip_code_Invalid << 21 ) + ( le.telephone_Invalid << 22 ) + ( le.relationship_code_Invalid << 23 ) + ( le.relationship_desc_Invalid << 24 ) + ( le.bal_range_code_Invalid << 25 ) + ( le.acct_bal_range_code_Invalid << 26 ) + ( le.nbr_fig_in_bal_Invalid << 27 ) + ( le.acct_bal_total_Invalid << 28 ) + ( le.acct_rating_code_Invalid << 29 ) + ( le.date_acct_opened_ymd_Invalid << 30 ) + ( le.date_acct_closed_ymd_Invalid << 31 ) + ( le.name_addr_key_Invalid << 32 ) + ( le.append_rawaid_Invalid << 33 ) + ( le.append_aceaid_Invalid << 34 ) + ( le.prep_addr_line1_Invalid << 35 ) + ( le.prep_addr_last_line_Invalid << 36 ) + ( le.clean_address_predir_Invalid << 37 ) + ( le.clean_address_prim_name_Invalid << 38 ) + ( le.clean_address_postdir_Invalid << 39 ) + ( le.clean_address_p_city_name_Invalid << 40 ) + ( le.clean_address_v_city_name_Invalid << 41 ) + ( le.clean_address_st_Invalid << 42 ) + ( le.clean_address_zip_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_5000_Layout_EBR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.powid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.process_date_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.process_date_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.file_number_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.segment_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.sequence_number_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.name_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.street_address_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.state_code_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.state_desc_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.relationship_code_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.relationship_desc_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.bal_range_code_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.acct_bal_range_code_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.nbr_fig_in_bal_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.acct_bal_total_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.acct_rating_code_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.date_acct_opened_ymd_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.date_acct_closed_ymd_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.name_addr_key_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.append_rawaid_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.append_aceaid_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.prep_addr_last_line_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.clean_address_predir_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_address_prim_name_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.clean_address_postdir_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.clean_address_p_city_name_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.clean_address_v_city_name_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.clean_address_st_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.clean_address_zip_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    powid_LENGTHS_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_LENGTHS_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_LENGTHS_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_LENGTHS_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_LENGTHS_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    process_date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_first_seen_Invalid=1);
    process_date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_last_seen_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    file_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_number_Invalid=1);
    file_number_LENGTHS_ErrorCount := COUNT(GROUP,h.file_number_Invalid=2);
    file_number_Total_ErrorCount := COUNT(GROUP,h.file_number_Invalid>0);
    segment_code_ENUM_ErrorCount := COUNT(GROUP,h.segment_code_Invalid=1);
    sequence_number_CUSTOM_ErrorCount := COUNT(GROUP,h.sequence_number_Invalid=1);
    name_LENGTHS_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    street_address_LENGTHS_ErrorCount := COUNT(GROUP,h.street_address_Invalid=1);
    city_LENGTHS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_code_CUSTOM_ErrorCount := COUNT(GROUP,h.state_code_Invalid=1);
    state_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.state_desc_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    telephone_CUSTOM_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    relationship_code_CUSTOM_ErrorCount := COUNT(GROUP,h.relationship_code_Invalid=1);
    relationship_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.relationship_desc_Invalid=1);
    bal_range_code_ENUM_ErrorCount := COUNT(GROUP,h.bal_range_code_Invalid=1);
    acct_bal_range_code_ENUM_ErrorCount := COUNT(GROUP,h.acct_bal_range_code_Invalid=1);
    nbr_fig_in_bal_CUSTOM_ErrorCount := COUNT(GROUP,h.nbr_fig_in_bal_Invalid=1);
    acct_bal_total_ALLOW_ErrorCount := COUNT(GROUP,h.acct_bal_total_Invalid=1);
    acct_rating_code_ENUM_ErrorCount := COUNT(GROUP,h.acct_rating_code_Invalid=1);
    date_acct_opened_ymd_CUSTOM_ErrorCount := COUNT(GROUP,h.date_acct_opened_ymd_Invalid=1);
    date_acct_closed_ymd_CUSTOM_ErrorCount := COUNT(GROUP,h.date_acct_closed_ymd_Invalid=1);
    name_addr_key_CUSTOM_ErrorCount := COUNT(GROUP,h.name_addr_key_Invalid=1);
    append_rawaid_CUSTOM_ErrorCount := COUNT(GROUP,h.append_rawaid_Invalid=1);
    append_aceaid_CUSTOM_ErrorCount := COUNT(GROUP,h.append_aceaid_Invalid=1);
    prep_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_last_line_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_last_line_Invalid=1);
    clean_address_predir_ENUM_ErrorCount := COUNT(GROUP,h.clean_address_predir_Invalid=1);
    clean_address_prim_name_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_address_prim_name_Invalid=1);
    clean_address_postdir_ENUM_ErrorCount := COUNT(GROUP,h.clean_address_postdir_Invalid=1);
    clean_address_p_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_address_p_city_name_Invalid=1);
    clean_address_v_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_address_v_city_name_Invalid=1);
    clean_address_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_st_Invalid=1);
    clean_address_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_zip_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.segment_code_Invalid > 0 OR h.sequence_number_Invalid > 0 OR h.name_Invalid > 0 OR h.street_address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_code_Invalid > 0 OR h.state_desc_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.telephone_Invalid > 0 OR h.relationship_code_Invalid > 0 OR h.relationship_desc_Invalid > 0 OR h.bal_range_code_Invalid > 0 OR h.acct_bal_range_code_Invalid > 0 OR h.nbr_fig_in_bal_Invalid > 0 OR h.acct_bal_total_Invalid > 0 OR h.acct_rating_code_Invalid > 0 OR h.date_acct_opened_ymd_Invalid > 0 OR h.date_acct_closed_ymd_Invalid > 0 OR h.name_addr_key_Invalid > 0 OR h.append_rawaid_Invalid > 0 OR h.append_aceaid_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_last_line_Invalid > 0 OR h.clean_address_predir_Invalid > 0 OR h.clean_address_prim_name_Invalid > 0 OR h.clean_address_postdir_Invalid > 0 OR h.clean_address_p_city_name_Invalid > 0 OR h.clean_address_v_city_name_Invalid > 0 OR h.clean_address_st_Invalid > 0 OR h.clean_address_zip_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.street_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telephone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bal_range_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.acct_bal_range_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.nbr_fig_in_bal_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.acct_bal_total_ALLOW_ErrorCount > 0, 1, 0) + IF(le.acct_rating_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_acct_opened_ymd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_acct_closed_ymd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_addr_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.append_rawaid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.append_aceaid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_last_line_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.street_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telephone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bal_range_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.acct_bal_range_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.nbr_fig_in_bal_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.acct_bal_total_ALLOW_ErrorCount > 0, 1, 0) + IF(le.acct_rating_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_acct_opened_ymd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_acct_closed_ymd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_addr_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.append_rawaid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.append_aceaid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_last_line_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.segment_code_Invalid,le.sequence_number_Invalid,le.name_Invalid,le.street_address_Invalid,le.city_Invalid,le.state_code_Invalid,le.state_desc_Invalid,le.zip_code_Invalid,le.telephone_Invalid,le.relationship_code_Invalid,le.relationship_desc_Invalid,le.bal_range_code_Invalid,le.acct_bal_range_code_Invalid,le.nbr_fig_in_bal_Invalid,le.acct_bal_total_Invalid,le.acct_rating_code_Invalid,le.date_acct_opened_ymd_Invalid,le.date_acct_closed_ymd_Invalid,le.name_addr_key_Invalid,le.append_rawaid_Invalid,le.append_aceaid_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_last_line_Invalid,le.clean_address_predir_Invalid,le.clean_address_prim_name_Invalid,le.clean_address_postdir_Invalid,le.clean_address_p_city_name_Invalid,le.clean_address_v_city_name_Invalid,le.clean_address_st_Invalid,le.clean_address_zip_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_5000_Fields.InvalidMessage_powid(le.powid_Invalid),Base_5000_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_5000_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_5000_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_5000_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_5000_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_5000_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_5000_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_5000_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_5000_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_5000_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_5000_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_5000_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_5000_Fields.InvalidMessage_segment_code(le.segment_code_Invalid),Base_5000_Fields.InvalidMessage_sequence_number(le.sequence_number_Invalid),Base_5000_Fields.InvalidMessage_name(le.name_Invalid),Base_5000_Fields.InvalidMessage_street_address(le.street_address_Invalid),Base_5000_Fields.InvalidMessage_city(le.city_Invalid),Base_5000_Fields.InvalidMessage_state_code(le.state_code_Invalid),Base_5000_Fields.InvalidMessage_state_desc(le.state_desc_Invalid),Base_5000_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Base_5000_Fields.InvalidMessage_telephone(le.telephone_Invalid),Base_5000_Fields.InvalidMessage_relationship_code(le.relationship_code_Invalid),Base_5000_Fields.InvalidMessage_relationship_desc(le.relationship_desc_Invalid),Base_5000_Fields.InvalidMessage_bal_range_code(le.bal_range_code_Invalid),Base_5000_Fields.InvalidMessage_acct_bal_range_code(le.acct_bal_range_code_Invalid),Base_5000_Fields.InvalidMessage_nbr_fig_in_bal(le.nbr_fig_in_bal_Invalid),Base_5000_Fields.InvalidMessage_acct_bal_total(le.acct_bal_total_Invalid),Base_5000_Fields.InvalidMessage_acct_rating_code(le.acct_rating_code_Invalid),Base_5000_Fields.InvalidMessage_date_acct_opened_ymd(le.date_acct_opened_ymd_Invalid),Base_5000_Fields.InvalidMessage_date_acct_closed_ymd(le.date_acct_closed_ymd_Invalid),Base_5000_Fields.InvalidMessage_name_addr_key(le.name_addr_key_Invalid),Base_5000_Fields.InvalidMessage_append_rawaid(le.append_rawaid_Invalid),Base_5000_Fields.InvalidMessage_append_aceaid(le.append_aceaid_Invalid),Base_5000_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_5000_Fields.InvalidMessage_prep_addr_last_line(le.prep_addr_last_line_Invalid),Base_5000_Fields.InvalidMessage_clean_address_predir(le.clean_address_predir_Invalid),Base_5000_Fields.InvalidMessage_clean_address_prim_name(le.clean_address_prim_name_Invalid),Base_5000_Fields.InvalidMessage_clean_address_postdir(le.clean_address_postdir_Invalid),Base_5000_Fields.InvalidMessage_clean_address_p_city_name(le.clean_address_p_city_name_Invalid),Base_5000_Fields.InvalidMessage_clean_address_v_city_name(le.clean_address_v_city_name_Invalid),Base_5000_Fields.InvalidMessage_clean_address_st(le.clean_address_st_Invalid),Base_5000_Fields.InvalidMessage_clean_address_zip(le.clean_address_zip_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.powid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.segment_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sequence_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.street_address_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.relationship_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.relationship_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bal_range_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.acct_bal_range_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.nbr_fig_in_bal_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.acct_bal_total_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.acct_rating_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_acct_opened_ymd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_acct_closed_ymd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_addr_key_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.append_rawaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.append_aceaid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr_last_line_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_address_predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_address_prim_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_address_postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_address_p_city_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_address_v_city_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_address_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_zip_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','name','street_address','city','state_code','state_desc','zip_code','telephone','relationship_code','relationship_desc','bal_range_code','acct_bal_range_code','nbr_fig_in_bal','acct_bal_total','acct_rating_code','date_acct_opened_ymd','date_acct_closed_ymd','name_addr_key','append_rawaid','append_aceaid','prep_addr_line1','prep_addr_last_line','clean_address_predir','clean_address_prim_name','clean_address_postdir','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_state_desc','invalid_zip5','invalid_phone','invalid_relationship_code','invalid_relationship_desc','invalid_bal_range_code','invalid_acct_bal_range_code','invalid_numeric','invalid_acct_bal','invalid_acct_rating_code','invalid_dt_mmddyy','invalid_dt_mmddyy','invalid_numeric','invalid_numeric','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.segment_code,(SALT311.StrType)le.sequence_number,(SALT311.StrType)le.name,(SALT311.StrType)le.street_address,(SALT311.StrType)le.city,(SALT311.StrType)le.state_code,(SALT311.StrType)le.state_desc,(SALT311.StrType)le.zip_code,(SALT311.StrType)le.telephone,(SALT311.StrType)le.relationship_code,(SALT311.StrType)le.relationship_desc,(SALT311.StrType)le.bal_range_code,(SALT311.StrType)le.acct_bal_range_code,(SALT311.StrType)le.nbr_fig_in_bal,(SALT311.StrType)le.acct_bal_total,(SALT311.StrType)le.acct_rating_code,(SALT311.StrType)le.date_acct_opened_ymd,(SALT311.StrType)le.date_acct_closed_ymd,(SALT311.StrType)le.name_addr_key,(SALT311.StrType)le.append_rawaid,(SALT311.StrType)le.append_aceaid,(SALT311.StrType)le.prep_addr_line1,(SALT311.StrType)le.prep_addr_last_line,(SALT311.StrType)le.clean_address_predir,(SALT311.StrType)le.clean_address_prim_name,(SALT311.StrType)le.clean_address_postdir,(SALT311.StrType)le.clean_address_p_city_name,(SALT311.StrType)le.clean_address_v_city_name,(SALT311.StrType)le.clean_address_st,(SALT311.StrType)le.clean_address_zip,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,43,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_5000_Layout_EBR) prevDS = DATASET([], Base_5000_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:invalid_mandatory:LENGTHS'
          ,'proxid:invalid_mandatory:LENGTHS'
          ,'seleid:invalid_mandatory:LENGTHS'
          ,'orgid:invalid_mandatory:LENGTHS'
          ,'ultid:invalid_mandatory:LENGTHS'
          ,'bdid:invalid_numeric:CUSTOM'
          ,'date_first_seen:invalid_dt_first_seen:CUSTOM'
          ,'date_last_seen:invalid_pastdate:CUSTOM'
          ,'process_date_first_seen:invalid_pastdate:CUSTOM'
          ,'process_date_last_seen:invalid_pastdate:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'process_date:invalid_pastdate:CUSTOM'
          ,'file_number:invalid_file_number:ALLOW','file_number:invalid_file_number:LENGTHS'
          ,'segment_code:invalid_segment:ENUM'
          ,'sequence_number:invalid_numeric_or_allzeros:CUSTOM'
          ,'name:invalid_mandatory:LENGTHS'
          ,'street_address:invalid_mandatory:LENGTHS'
          ,'city:invalid_mandatory:LENGTHS'
          ,'state_code:invalid_state:CUSTOM'
          ,'state_desc:invalid_state_desc:CUSTOM'
          ,'zip_code:invalid_zip5:CUSTOM'
          ,'telephone:invalid_phone:CUSTOM'
          ,'relationship_code:invalid_relationship_code:CUSTOM'
          ,'relationship_desc:invalid_relationship_desc:CUSTOM'
          ,'bal_range_code:invalid_bal_range_code:ENUM'
          ,'acct_bal_range_code:invalid_acct_bal_range_code:ENUM'
          ,'nbr_fig_in_bal:invalid_numeric:CUSTOM'
          ,'acct_bal_total:invalid_acct_bal:ALLOW'
          ,'acct_rating_code:invalid_acct_rating_code:ENUM'
          ,'date_acct_opened_ymd:invalid_dt_mmddyy:CUSTOM'
          ,'date_acct_closed_ymd:invalid_dt_mmddyy:CUSTOM'
          ,'name_addr_key:invalid_numeric:CUSTOM'
          ,'append_rawaid:invalid_numeric:CUSTOM'
          ,'append_aceaid:invalid_numeric:CUSTOM'
          ,'prep_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_addr_last_line:invalid_mandatory:LENGTHS'
          ,'clean_address_predir:invalid_direction:ENUM'
          ,'clean_address_prim_name:invalid_mandatory:LENGTHS'
          ,'clean_address_postdir:invalid_direction:ENUM'
          ,'clean_address_p_city_name:invalid_mandatory:LENGTHS'
          ,'clean_address_v_city_name:invalid_mandatory:LENGTHS'
          ,'clean_address_st:invalid_state:CUSTOM'
          ,'clean_address_zip:invalid_zip5:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_5000_Fields.InvalidMessage_powid(1)
          ,Base_5000_Fields.InvalidMessage_proxid(1)
          ,Base_5000_Fields.InvalidMessage_seleid(1)
          ,Base_5000_Fields.InvalidMessage_orgid(1)
          ,Base_5000_Fields.InvalidMessage_ultid(1)
          ,Base_5000_Fields.InvalidMessage_bdid(1)
          ,Base_5000_Fields.InvalidMessage_date_first_seen(1)
          ,Base_5000_Fields.InvalidMessage_date_last_seen(1)
          ,Base_5000_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_5000_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_5000_Fields.InvalidMessage_record_type(1)
          ,Base_5000_Fields.InvalidMessage_process_date(1)
          ,Base_5000_Fields.InvalidMessage_file_number(1),Base_5000_Fields.InvalidMessage_file_number(2)
          ,Base_5000_Fields.InvalidMessage_segment_code(1)
          ,Base_5000_Fields.InvalidMessage_sequence_number(1)
          ,Base_5000_Fields.InvalidMessage_name(1)
          ,Base_5000_Fields.InvalidMessage_street_address(1)
          ,Base_5000_Fields.InvalidMessage_city(1)
          ,Base_5000_Fields.InvalidMessage_state_code(1)
          ,Base_5000_Fields.InvalidMessage_state_desc(1)
          ,Base_5000_Fields.InvalidMessage_zip_code(1)
          ,Base_5000_Fields.InvalidMessage_telephone(1)
          ,Base_5000_Fields.InvalidMessage_relationship_code(1)
          ,Base_5000_Fields.InvalidMessage_relationship_desc(1)
          ,Base_5000_Fields.InvalidMessage_bal_range_code(1)
          ,Base_5000_Fields.InvalidMessage_acct_bal_range_code(1)
          ,Base_5000_Fields.InvalidMessage_nbr_fig_in_bal(1)
          ,Base_5000_Fields.InvalidMessage_acct_bal_total(1)
          ,Base_5000_Fields.InvalidMessage_acct_rating_code(1)
          ,Base_5000_Fields.InvalidMessage_date_acct_opened_ymd(1)
          ,Base_5000_Fields.InvalidMessage_date_acct_closed_ymd(1)
          ,Base_5000_Fields.InvalidMessage_name_addr_key(1)
          ,Base_5000_Fields.InvalidMessage_append_rawaid(1)
          ,Base_5000_Fields.InvalidMessage_append_aceaid(1)
          ,Base_5000_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_5000_Fields.InvalidMessage_prep_addr_last_line(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_predir(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_prim_name(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_postdir(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_p_city_name(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_v_city_name(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_st(1)
          ,Base_5000_Fields.InvalidMessage_clean_address_zip(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.segment_code_ENUM_ErrorCount
          ,le.sequence_number_CUSTOM_ErrorCount
          ,le.name_LENGTHS_ErrorCount
          ,le.street_address_LENGTHS_ErrorCount
          ,le.city_LENGTHS_ErrorCount
          ,le.state_code_CUSTOM_ErrorCount
          ,le.state_desc_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.telephone_CUSTOM_ErrorCount
          ,le.relationship_code_CUSTOM_ErrorCount
          ,le.relationship_desc_CUSTOM_ErrorCount
          ,le.bal_range_code_ENUM_ErrorCount
          ,le.acct_bal_range_code_ENUM_ErrorCount
          ,le.nbr_fig_in_bal_CUSTOM_ErrorCount
          ,le.acct_bal_total_ALLOW_ErrorCount
          ,le.acct_rating_code_ENUM_ErrorCount
          ,le.date_acct_opened_ymd_CUSTOM_ErrorCount
          ,le.date_acct_closed_ymd_CUSTOM_ErrorCount
          ,le.name_addr_key_CUSTOM_ErrorCount
          ,le.append_rawaid_CUSTOM_ErrorCount
          ,le.append_aceaid_CUSTOM_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_last_line_LENGTHS_ErrorCount
          ,le.clean_address_predir_ENUM_ErrorCount
          ,le.clean_address_prim_name_LENGTHS_ErrorCount
          ,le.clean_address_postdir_ENUM_ErrorCount
          ,le.clean_address_p_city_name_LENGTHS_ErrorCount
          ,le.clean_address_v_city_name_LENGTHS_ErrorCount
          ,le.clean_address_st_CUSTOM_ErrorCount
          ,le.clean_address_zip_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.segment_code_ENUM_ErrorCount
          ,le.sequence_number_CUSTOM_ErrorCount
          ,le.name_LENGTHS_ErrorCount
          ,le.street_address_LENGTHS_ErrorCount
          ,le.city_LENGTHS_ErrorCount
          ,le.state_code_CUSTOM_ErrorCount
          ,le.state_desc_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.telephone_CUSTOM_ErrorCount
          ,le.relationship_code_CUSTOM_ErrorCount
          ,le.relationship_desc_CUSTOM_ErrorCount
          ,le.bal_range_code_ENUM_ErrorCount
          ,le.acct_bal_range_code_ENUM_ErrorCount
          ,le.nbr_fig_in_bal_CUSTOM_ErrorCount
          ,le.acct_bal_total_ALLOW_ErrorCount
          ,le.acct_rating_code_ENUM_ErrorCount
          ,le.date_acct_opened_ymd_CUSTOM_ErrorCount
          ,le.date_acct_closed_ymd_CUSTOM_ErrorCount
          ,le.name_addr_key_CUSTOM_ErrorCount
          ,le.append_rawaid_CUSTOM_ErrorCount
          ,le.append_aceaid_CUSTOM_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_last_line_LENGTHS_ErrorCount
          ,le.clean_address_predir_ENUM_ErrorCount
          ,le.clean_address_prim_name_LENGTHS_ErrorCount
          ,le.clean_address_postdir_ENUM_ErrorCount
          ,le.clean_address_p_city_name_LENGTHS_ErrorCount
          ,le.clean_address_v_city_name_LENGTHS_ErrorCount
          ,le.clean_address_st_CUSTOM_ErrorCount
          ,le.clean_address_zip_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_5000_hygiene(PROJECT(h, Base_5000_Layout_EBR));
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
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date_first_seen:' + getFieldTypeText(h.process_date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date_last_seen:' + getFieldTypeText(h.process_date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_number:' + getFieldTypeText(h.file_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'segment_code:' + getFieldTypeText(h.segment_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sequence_number:' + getFieldTypeText(h.sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name:' + getFieldTypeText(h.name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_address:' + getFieldTypeText(h.street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_code:' + getFieldTypeText(h.state_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_desc:' + getFieldTypeText(h.state_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone:' + getFieldTypeText(h.telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_code:' + getFieldTypeText(h.relationship_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_desc:' + getFieldTypeText(h.relationship_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bal_range_code:' + getFieldTypeText(h.bal_range_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'acct_bal_range_code:' + getFieldTypeText(h.acct_bal_range_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nbr_fig_in_bal:' + getFieldTypeText(h.nbr_fig_in_bal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'acct_bal_total:' + getFieldTypeText(h.acct_bal_total) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'acct_rating_code:' + getFieldTypeText(h.acct_rating_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_acct_opened_ymd:' + getFieldTypeText(h.date_acct_opened_ymd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_acct_closed_ymd:' + getFieldTypeText(h.date_acct_closed_ymd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_addr_key:' + getFieldTypeText(h.name_addr_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_rawaid:' + getFieldTypeText(h.append_rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_aceaid:' + getFieldTypeText(h.append_aceaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_last_line:' + getFieldTypeText(h.prep_addr_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_predir:' + getFieldTypeText(h.clean_address_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_prim_name:' + getFieldTypeText(h.clean_address_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_postdir:' + getFieldTypeText(h.clean_address_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_p_city_name:' + getFieldTypeText(h.clean_address_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_v_city_name:' + getFieldTypeText(h.clean_address_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_st:' + getFieldTypeText(h.clean_address_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_zip:' + getFieldTypeText(h.clean_address_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_powid_cnt
          ,le.populated_proxid_cnt
          ,le.populated_seleid_cnt
          ,le.populated_orgid_cnt
          ,le.populated_ultid_cnt
          ,le.populated_bdid_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_process_date_first_seen_cnt
          ,le.populated_process_date_last_seen_cnt
          ,le.populated_record_type_cnt
          ,le.populated_process_date_cnt
          ,le.populated_file_number_cnt
          ,le.populated_segment_code_cnt
          ,le.populated_sequence_number_cnt
          ,le.populated_name_cnt
          ,le.populated_street_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_code_cnt
          ,le.populated_state_desc_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_telephone_cnt
          ,le.populated_relationship_code_cnt
          ,le.populated_relationship_desc_cnt
          ,le.populated_bal_range_code_cnt
          ,le.populated_acct_bal_range_code_cnt
          ,le.populated_nbr_fig_in_bal_cnt
          ,le.populated_acct_bal_total_cnt
          ,le.populated_acct_rating_code_cnt
          ,le.populated_date_acct_opened_ymd_cnt
          ,le.populated_date_acct_closed_ymd_cnt
          ,le.populated_name_addr_key_cnt
          ,le.populated_append_rawaid_cnt
          ,le.populated_append_aceaid_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_last_line_cnt
          ,le.populated_clean_address_predir_cnt
          ,le.populated_clean_address_prim_name_cnt
          ,le.populated_clean_address_postdir_cnt
          ,le.populated_clean_address_p_city_name_cnt
          ,le.populated_clean_address_v_city_name_cnt
          ,le.populated_clean_address_st_cnt
          ,le.populated_clean_address_zip_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_powid_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_process_date_first_seen_pcnt
          ,le.populated_process_date_last_seen_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_file_number_pcnt
          ,le.populated_segment_code_pcnt
          ,le.populated_sequence_number_pcnt
          ,le.populated_name_pcnt
          ,le.populated_street_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_code_pcnt
          ,le.populated_state_desc_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_telephone_pcnt
          ,le.populated_relationship_code_pcnt
          ,le.populated_relationship_desc_pcnt
          ,le.populated_bal_range_code_pcnt
          ,le.populated_acct_bal_range_code_pcnt
          ,le.populated_nbr_fig_in_bal_pcnt
          ,le.populated_acct_bal_total_pcnt
          ,le.populated_acct_rating_code_pcnt
          ,le.populated_date_acct_opened_ymd_pcnt
          ,le.populated_date_acct_closed_ymd_pcnt
          ,le.populated_name_addr_key_pcnt
          ,le.populated_append_rawaid_pcnt
          ,le.populated_append_aceaid_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_last_line_pcnt
          ,le.populated_clean_address_predir_pcnt
          ,le.populated_clean_address_prim_name_pcnt
          ,le.populated_clean_address_postdir_pcnt
          ,le.populated_clean_address_p_city_name_pcnt
          ,le.populated_clean_address_v_city_name_pcnt
          ,le.populated_clean_address_st_pcnt
          ,le.populated_clean_address_zip_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,43,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_5000_Delta(prevDS, PROJECT(h, Base_5000_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),43,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_5000_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_5000_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
