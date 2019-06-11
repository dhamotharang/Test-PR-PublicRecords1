IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_0010_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 29;
  EXPORT NumRulesFromFieldType := 29;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_0010_Layout_EBR)
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
    UNSIGNED1 orig_extract_date_mdy_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 business_desc_Invalid;
    UNSIGNED1 extract_date_Invalid;
    UNSIGNED1 file_estab_date_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_last_line_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 clean_address_prim_name_Invalid;
    UNSIGNED1 clean_address_p_city_name_Invalid;
    UNSIGNED1 clean_address_v_city_name_Invalid;
    UNSIGNED1 clean_address_st_Invalid;
    UNSIGNED1 clean_address_zip_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_0010_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_0010_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_0010_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_0010_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_0010_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_0010_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_0010_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_0010_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_0010_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_0010_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_0010_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_0010_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_0010_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_0010_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_0010_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.orig_extract_date_mdy_Invalid := Base_0010_Fields.InValid_orig_extract_date_mdy((SALT311.StrType)le.orig_extract_date_mdy);
    SELF.company_name_Invalid := Base_0010_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.phone_number_Invalid := Base_0010_Fields.InValid_phone_number((SALT311.StrType)le.phone_number);
    SELF.sic_code_Invalid := Base_0010_Fields.InValid_sic_code((SALT311.StrType)le.sic_code);
    SELF.business_desc_Invalid := Base_0010_Fields.InValid_business_desc((SALT311.StrType)le.business_desc);
    SELF.extract_date_Invalid := Base_0010_Fields.InValid_extract_date((SALT311.StrType)le.extract_date);
    SELF.file_estab_date_Invalid := Base_0010_Fields.InValid_file_estab_date((SALT311.StrType)le.file_estab_date);
    SELF.prep_addr_line1_Invalid := Base_0010_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1);
    SELF.prep_addr_last_line_Invalid := Base_0010_Fields.InValid_prep_addr_last_line((SALT311.StrType)le.prep_addr_last_line);
    SELF.source_rec_id_Invalid := Base_0010_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id);
    SELF.clean_address_prim_name_Invalid := Base_0010_Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name);
    SELF.clean_address_p_city_name_Invalid := Base_0010_Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name);
    SELF.clean_address_v_city_name_Invalid := Base_0010_Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name);
    SELF.clean_address_st_Invalid := Base_0010_Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st);
    SELF.clean_address_zip_Invalid := Base_0010_Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_0010_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.orig_extract_date_mdy_Invalid << 14 ) + ( le.company_name_Invalid << 15 ) + ( le.phone_number_Invalid << 16 ) + ( le.sic_code_Invalid << 17 ) + ( le.business_desc_Invalid << 18 ) + ( le.extract_date_Invalid << 19 ) + ( le.file_estab_date_Invalid << 20 ) + ( le.prep_addr_line1_Invalid << 21 ) + ( le.prep_addr_last_line_Invalid << 22 ) + ( le.source_rec_id_Invalid << 23 ) + ( le.clean_address_prim_name_Invalid << 24 ) + ( le.clean_address_p_city_name_Invalid << 25 ) + ( le.clean_address_v_city_name_Invalid << 26 ) + ( le.clean_address_st_Invalid << 27 ) + ( le.clean_address_zip_Invalid << 28 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_0010_Layout_EBR);
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
    SELF.orig_extract_date_mdy_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.business_desc_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.extract_date_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.file_estab_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.prep_addr_last_line_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.clean_address_prim_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.clean_address_p_city_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.clean_address_v_city_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.clean_address_st_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.clean_address_zip_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
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
    orig_extract_date_mdy_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_extract_date_mdy_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    phone_number_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    business_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.business_desc_Invalid=1);
    extract_date_CUSTOM_ErrorCount := COUNT(GROUP,h.extract_date_Invalid=1);
    file_estab_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_estab_date_Invalid=1);
    prep_addr_line1_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_last_line_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_last_line_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    clean_address_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_prim_name_Invalid=1);
    clean_address_p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_p_city_name_Invalid=1);
    clean_address_v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_v_city_name_Invalid=1);
    clean_address_st_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_st_Invalid=1);
    clean_address_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_zip_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.orig_extract_date_mdy_Invalid > 0 OR h.company_name_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.business_desc_Invalid > 0 OR h.extract_date_Invalid > 0 OR h.file_estab_date_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_last_line_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.clean_address_prim_name_Invalid > 0 OR h.clean_address_p_city_name_Invalid > 0 OR h.clean_address_v_city_name_Invalid > 0 OR h.clean_address_st_Invalid > 0 OR h.clean_address_zip_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.orig_extract_date_mdy_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.extract_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_estab_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_last_line_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_extract_date_mdy_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.extract_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_estab_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_last_line_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.orig_extract_date_mdy_Invalid,le.company_name_Invalid,le.phone_number_Invalid,le.sic_code_Invalid,le.business_desc_Invalid,le.extract_date_Invalid,le.file_estab_date_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_last_line_Invalid,le.source_rec_id_Invalid,le.clean_address_prim_name_Invalid,le.clean_address_p_city_name_Invalid,le.clean_address_v_city_name_Invalid,le.clean_address_st_Invalid,le.clean_address_zip_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_0010_Fields.InvalidMessage_powid(le.powid_Invalid),Base_0010_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_0010_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_0010_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_0010_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_0010_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_0010_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_0010_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_0010_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_0010_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_0010_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_0010_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_0010_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_0010_Fields.InvalidMessage_orig_extract_date_mdy(le.orig_extract_date_mdy_Invalid),Base_0010_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_0010_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Base_0010_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Base_0010_Fields.InvalidMessage_business_desc(le.business_desc_Invalid),Base_0010_Fields.InvalidMessage_extract_date(le.extract_date_Invalid),Base_0010_Fields.InvalidMessage_file_estab_date(le.file_estab_date_Invalid),Base_0010_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_0010_Fields.InvalidMessage_prep_addr_last_line(le.prep_addr_last_line_Invalid),Base_0010_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),Base_0010_Fields.InvalidMessage_clean_address_prim_name(le.clean_address_prim_name_Invalid),Base_0010_Fields.InvalidMessage_clean_address_p_city_name(le.clean_address_p_city_name_Invalid),Base_0010_Fields.InvalidMessage_clean_address_v_city_name(le.clean_address_v_city_name_Invalid),Base_0010_Fields.InvalidMessage_clean_address_st(le.clean_address_st_Invalid),Base_0010_Fields.InvalidMessage_clean_address_zip(le.clean_address_zip_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_extract_date_mdy_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.extract_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_estab_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_last_line_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_zip_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','orig_extract_date_mdy','company_name','phone_number','sic_code','business_desc','extract_date','file_estab_date','prep_addr_line1','prep_addr_last_line','source_rec_id','clean_address_prim_name','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_bdid','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_pastdate_slashes','invalid_mandatory','invalid_phone','invalid_sic','invalid_mandatory','invalid_pastdate','invalid_ccyymm','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.orig_extract_date_mdy,(SALT311.StrType)le.company_name,(SALT311.StrType)le.phone_number,(SALT311.StrType)le.sic_code,(SALT311.StrType)le.business_desc,(SALT311.StrType)le.extract_date,(SALT311.StrType)le.file_estab_date,(SALT311.StrType)le.prep_addr_line1,(SALT311.StrType)le.prep_addr_last_line,(SALT311.StrType)le.source_rec_id,(SALT311.StrType)le.clean_address_prim_name,(SALT311.StrType)le.clean_address_p_city_name,(SALT311.StrType)le.clean_address_v_city_name,(SALT311.StrType)le.clean_address_st,(SALT311.StrType)le.clean_address_zip,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_0010_Layout_EBR) prevDS = DATASET([], Base_0010_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:invalid_mandatory:CUSTOM'
          ,'proxid:invalid_mandatory:CUSTOM'
          ,'seleid:invalid_mandatory:CUSTOM'
          ,'orgid:invalid_mandatory:CUSTOM'
          ,'ultid:invalid_mandatory:CUSTOM'
          ,'bdid:invalid_bdid:CUSTOM'
          ,'date_first_seen:invalid_dt_first_seen:CUSTOM'
          ,'date_last_seen:invalid_pastdate:CUSTOM'
          ,'process_date_first_seen:invalid_pastdate:CUSTOM'
          ,'process_date_last_seen:invalid_pastdate:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'process_date:invalid_pastdate:CUSTOM'
          ,'file_number:invalid_file_number:ALLOW','file_number:invalid_file_number:LENGTHS'
          ,'orig_extract_date_mdy:invalid_pastdate_slashes:CUSTOM'
          ,'company_name:invalid_mandatory:CUSTOM'
          ,'phone_number:invalid_phone:CUSTOM'
          ,'sic_code:invalid_sic:CUSTOM'
          ,'business_desc:invalid_mandatory:CUSTOM'
          ,'extract_date:invalid_pastdate:CUSTOM'
          ,'file_estab_date:invalid_ccyymm:CUSTOM'
          ,'prep_addr_line1:invalid_mandatory:CUSTOM'
          ,'prep_addr_last_line:invalid_mandatory:CUSTOM'
          ,'source_rec_id:invalid_numeric:CUSTOM'
          ,'clean_address_prim_name:invalid_mandatory:CUSTOM'
          ,'clean_address_p_city_name:invalid_mandatory:CUSTOM'
          ,'clean_address_v_city_name:invalid_mandatory:CUSTOM'
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
          ,Base_0010_Fields.InvalidMessage_powid(1)
          ,Base_0010_Fields.InvalidMessage_proxid(1)
          ,Base_0010_Fields.InvalidMessage_seleid(1)
          ,Base_0010_Fields.InvalidMessage_orgid(1)
          ,Base_0010_Fields.InvalidMessage_ultid(1)
          ,Base_0010_Fields.InvalidMessage_bdid(1)
          ,Base_0010_Fields.InvalidMessage_date_first_seen(1)
          ,Base_0010_Fields.InvalidMessage_date_last_seen(1)
          ,Base_0010_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_0010_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_0010_Fields.InvalidMessage_record_type(1)
          ,Base_0010_Fields.InvalidMessage_process_date(1)
          ,Base_0010_Fields.InvalidMessage_file_number(1),Base_0010_Fields.InvalidMessage_file_number(2)
          ,Base_0010_Fields.InvalidMessage_orig_extract_date_mdy(1)
          ,Base_0010_Fields.InvalidMessage_company_name(1)
          ,Base_0010_Fields.InvalidMessage_phone_number(1)
          ,Base_0010_Fields.InvalidMessage_sic_code(1)
          ,Base_0010_Fields.InvalidMessage_business_desc(1)
          ,Base_0010_Fields.InvalidMessage_extract_date(1)
          ,Base_0010_Fields.InvalidMessage_file_estab_date(1)
          ,Base_0010_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_0010_Fields.InvalidMessage_prep_addr_last_line(1)
          ,Base_0010_Fields.InvalidMessage_source_rec_id(1)
          ,Base_0010_Fields.InvalidMessage_clean_address_prim_name(1)
          ,Base_0010_Fields.InvalidMessage_clean_address_p_city_name(1)
          ,Base_0010_Fields.InvalidMessage_clean_address_v_city_name(1)
          ,Base_0010_Fields.InvalidMessage_clean_address_st(1)
          ,Base_0010_Fields.InvalidMessage_clean_address_zip(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.powid_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.orig_extract_date_mdy_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.phone_number_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.business_desc_CUSTOM_ErrorCount
          ,le.extract_date_CUSTOM_ErrorCount
          ,le.file_estab_date_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_last_line_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.clean_address_prim_name_CUSTOM_ErrorCount
          ,le.clean_address_p_city_name_CUSTOM_ErrorCount
          ,le.clean_address_v_city_name_CUSTOM_ErrorCount
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
          ,le.powid_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.orig_extract_date_mdy_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.phone_number_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.business_desc_CUSTOM_ErrorCount
          ,le.extract_date_CUSTOM_ErrorCount
          ,le.file_estab_date_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_last_line_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.clean_address_prim_name_CUSTOM_ErrorCount
          ,le.clean_address_p_city_name_CUSTOM_ErrorCount
          ,le.clean_address_v_city_name_CUSTOM_ErrorCount
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
    mod_hygiene := Base_0010_hygiene(PROJECT(h, Base_0010_Layout_EBR));
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
          ,'orig_extract_date_mdy:' + getFieldTypeText(h.orig_extract_date_mdy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_desc:' + getFieldTypeText(h.business_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extract_date:' + getFieldTypeText(h.extract_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_estab_date:' + getFieldTypeText(h.file_estab_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_last_line:' + getFieldTypeText(h.prep_addr_last_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_prim_name:' + getFieldTypeText(h.clean_address_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,le.populated_orig_extract_date_mdy_cnt
          ,le.populated_company_name_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_business_desc_cnt
          ,le.populated_extract_date_cnt
          ,le.populated_file_estab_date_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_last_line_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_clean_address_prim_name_cnt
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
          ,le.populated_orig_extract_date_mdy_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_business_desc_pcnt
          ,le.populated_extract_date_pcnt
          ,le.populated_file_estab_date_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_last_line_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_clean_address_prim_name_pcnt
          ,le.populated_clean_address_p_city_name_pcnt
          ,le.populated_clean_address_v_city_name_pcnt
          ,le.populated_clean_address_st_pcnt
          ,le.populated_clean_address_zip_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,28,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_0010_Delta(prevDS, PROJECT(h, Base_0010_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),28,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_0010_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_0010_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
