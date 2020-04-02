IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 37;
  EXPORT NumRulesFromFieldType := 37;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 37;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Frandx)
    UNSIGNED1 ace_aid_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 brand_name_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_secondary_phone_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 franchisee_id_Invalid;
    UNSIGNED1 fruns_Invalid;
    UNSIGNED1 f_units_Invalid;
    UNSIGNED1 industry_Invalid;
    UNSIGNED1 industry_type_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_extension_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 relationship_code_Invalid;
    UNSIGNED1 relationship_code_exp_Invalid;
    UNSIGNED1 secondary_phone_Invalid;
    UNSIGNED1 sector_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 unit_flag_Invalid;
    UNSIGNED1 unit_flag_exp_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 zip_code4_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Frandx)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_Frandx) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ace_aid_Invalid := Base_Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid);
    SELF.address1_Invalid := Base_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.brand_name_Invalid := Base_Fields.InValid_brand_name((SALT311.StrType)le.brand_name);
    SELF.chk_digit_Invalid := Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.city_Invalid := Base_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone);
    SELF.clean_secondary_phone_Invalid := Base_Fields.InValid_clean_secondary_phone((SALT311.StrType)le.clean_secondary_phone);
    SELF.company_name_Invalid := Base_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.err_stat_Invalid := Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF.fips_county_Invalid := Base_Fields.InValid_fips_county((SALT311.StrType)le.fips_county);
    SELF.fips_state_Invalid := Base_Fields.InValid_fips_state((SALT311.StrType)le.fips_state);
    SELF.franchisee_id_Invalid := Base_Fields.InValid_franchisee_id((SALT311.StrType)le.franchisee_id);
    SELF.fruns_Invalid := Base_Fields.InValid_fruns((SALT311.StrType)le.fruns);
    SELF.f_units_Invalid := Base_Fields.InValid_f_units((SALT311.StrType)le.f_units);
    SELF.industry_Invalid := Base_Fields.InValid_industry((SALT311.StrType)le.industry);
    SELF.industry_type_Invalid := Base_Fields.InValid_industry_type((SALT311.StrType)le.industry_type);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.phone_Invalid := Base_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.phone_extension_Invalid := Base_Fields.InValid_phone_extension((SALT311.StrType)le.phone_extension);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.record_id_Invalid := Base_Fields.InValid_record_id((SALT311.StrType)le.record_id);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.relationship_code_Invalid := Base_Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code);
    SELF.relationship_code_exp_Invalid := Base_Fields.InValid_relationship_code_exp((SALT311.StrType)le.relationship_code_exp);
    SELF.secondary_phone_Invalid := Base_Fields.InValid_secondary_phone((SALT311.StrType)le.secondary_phone);
    SELF.sector_Invalid := Base_Fields.InValid_sector((SALT311.StrType)le.sector);
    SELF.sic_code_Invalid := Base_Fields.InValid_sic_code((SALT311.StrType)le.sic_code);
    SELF.state_Invalid := Base_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.unit_flag_Invalid := Base_Fields.InValid_unit_flag((SALT311.StrType)le.unit_flag);
    SELF.unit_flag_exp_Invalid := Base_Fields.InValid_unit_flag_exp((SALT311.StrType)le.unit_flag_exp);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.zip_code_Invalid := Base_Fields.InValid_zip_code((SALT311.StrType)le.zip_code);
    SELF.zip_code4_Invalid := Base_Fields.InValid_zip_code4((SALT311.StrType)le.zip_code4);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Frandx);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ace_aid_Invalid << 0 ) + ( le.address1_Invalid << 1 ) + ( le.brand_name_Invalid << 2 ) + ( le.chk_digit_Invalid << 3 ) + ( le.city_Invalid << 4 ) + ( le.clean_phone_Invalid << 5 ) + ( le.clean_secondary_phone_Invalid << 6 ) + ( le.company_name_Invalid << 7 ) + ( le.dt_first_seen_Invalid << 8 ) + ( le.dt_last_seen_Invalid << 9 ) + ( le.dt_vendor_first_reported_Invalid << 10 ) + ( le.dt_vendor_last_reported_Invalid << 11 ) + ( le.err_stat_Invalid << 12 ) + ( le.fips_county_Invalid << 13 ) + ( le.fips_state_Invalid << 14 ) + ( le.franchisee_id_Invalid << 15 ) + ( le.fruns_Invalid << 16 ) + ( le.f_units_Invalid << 17 ) + ( le.industry_Invalid << 18 ) + ( le.industry_type_Invalid << 19 ) + ( le.p_city_name_Invalid << 20 ) + ( le.phone_Invalid << 21 ) + ( le.phone_extension_Invalid << 22 ) + ( le.prim_name_Invalid << 23 ) + ( le.record_id_Invalid << 24 ) + ( le.record_type_Invalid << 25 ) + ( le.relationship_code_Invalid << 26 ) + ( le.relationship_code_exp_Invalid << 27 ) + ( le.secondary_phone_Invalid << 28 ) + ( le.sector_Invalid << 29 ) + ( le.sic_code_Invalid << 30 ) + ( le.state_Invalid << 31 ) + ( le.unit_flag_Invalid << 32 ) + ( le.unit_flag_exp_Invalid << 33 ) + ( le.v_city_name_Invalid << 34 ) + ( le.zip_code_Invalid << 35 ) + ( le.zip_code4_Invalid << 36 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Frandx);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ace_aid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.brand_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.clean_secondary_phone_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.franchisee_id_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fruns_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.f_units_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.industry_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.industry_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.phone_extension_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.relationship_code_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.relationship_code_exp_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.secondary_phone_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.sector_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.unit_flag_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.unit_flag_exp_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.zip_code4_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ace_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_aid_Invalid=1);
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    brand_name_CUSTOM_ErrorCount := COUNT(GROUP,h.brand_name_Invalid=1);
    chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    clean_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_secondary_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_secondary_phone_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    franchisee_id_CUSTOM_ErrorCount := COUNT(GROUP,h.franchisee_id_Invalid=1);
    fruns_CUSTOM_ErrorCount := COUNT(GROUP,h.fruns_Invalid=1);
    f_units_CUSTOM_ErrorCount := COUNT(GROUP,h.f_units_Invalid=1);
    industry_CUSTOM_ErrorCount := COUNT(GROUP,h.industry_Invalid=1);
    industry_type_ENUM_ErrorCount := COUNT(GROUP,h.industry_type_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_extension_ALLOW_ErrorCount := COUNT(GROUP,h.phone_extension_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    record_id_CUSTOM_ErrorCount := COUNT(GROUP,h.record_id_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    relationship_code_ENUM_ErrorCount := COUNT(GROUP,h.relationship_code_Invalid=1);
    relationship_code_exp_ENUM_ErrorCount := COUNT(GROUP,h.relationship_code_exp_Invalid=1);
    secondary_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.secondary_phone_Invalid=1);
    sector_CUSTOM_ErrorCount := COUNT(GROUP,h.sector_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    unit_flag_ENUM_ErrorCount := COUNT(GROUP,h.unit_flag_Invalid=1);
    unit_flag_exp_ENUM_ErrorCount := COUNT(GROUP,h.unit_flag_exp_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    zip_code4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code4_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ace_aid_Invalid > 0 OR h.address1_Invalid > 0 OR h.brand_name_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.city_Invalid > 0 OR h.clean_phone_Invalid > 0 OR h.clean_secondary_phone_Invalid > 0 OR h.company_name_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.fips_state_Invalid > 0 OR h.franchisee_id_Invalid > 0 OR h.fruns_Invalid > 0 OR h.f_units_Invalid > 0 OR h.industry_Invalid > 0 OR h.industry_type_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_extension_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.record_id_Invalid > 0 OR h.record_type_Invalid > 0 OR h.relationship_code_Invalid > 0 OR h.relationship_code_exp_Invalid > 0 OR h.secondary_phone_Invalid > 0 OR h.sector_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.state_Invalid > 0 OR h.unit_flag_Invalid > 0 OR h.unit_flag_exp_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.zip_code4_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.brand_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.franchisee_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fruns_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.f_units_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_exp_ENUM_ErrorCount > 0, 1, 0) + IF(le.secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sector_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_exp_ENUM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code4_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.brand_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.franchisee_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fruns_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.f_units_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_exp_ENUM_ErrorCount > 0, 1, 0) + IF(le.secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sector_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_exp_ENUM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code4_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ace_aid_Invalid,le.address1_Invalid,le.brand_name_Invalid,le.chk_digit_Invalid,le.city_Invalid,le.clean_phone_Invalid,le.clean_secondary_phone_Invalid,le.company_name_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.err_stat_Invalid,le.fips_county_Invalid,le.fips_state_Invalid,le.franchisee_id_Invalid,le.fruns_Invalid,le.f_units_Invalid,le.industry_Invalid,le.industry_type_Invalid,le.p_city_name_Invalid,le.phone_Invalid,le.phone_extension_Invalid,le.prim_name_Invalid,le.record_id_Invalid,le.record_type_Invalid,le.relationship_code_Invalid,le.relationship_code_exp_Invalid,le.secondary_phone_Invalid,le.sector_Invalid,le.sic_code_Invalid,le.state_Invalid,le.unit_flag_Invalid,le.unit_flag_exp_Invalid,le.v_city_name_Invalid,le.zip_code_Invalid,le.zip_code4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_ace_aid(le.ace_aid_Invalid),Base_Fields.InvalidMessage_address1(le.address1_Invalid),Base_Fields.InvalidMessage_brand_name(le.brand_name_Invalid),Base_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Base_Fields.InvalidMessage_city(le.city_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_clean_secondary_phone(le.clean_secondary_phone_Invalid),Base_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Base_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Base_Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Base_Fields.InvalidMessage_franchisee_id(le.franchisee_id_Invalid),Base_Fields.InvalidMessage_fruns(le.fruns_Invalid),Base_Fields.InvalidMessage_f_units(le.f_units_Invalid),Base_Fields.InvalidMessage_industry(le.industry_Invalid),Base_Fields.InvalidMessage_industry_type(le.industry_type_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Fields.InvalidMessage_phone_extension(le.phone_extension_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_record_id(le.record_id_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_relationship_code(le.relationship_code_Invalid),Base_Fields.InvalidMessage_relationship_code_exp(le.relationship_code_exp_Invalid),Base_Fields.InvalidMessage_secondary_phone(le.secondary_phone_Invalid),Base_Fields.InvalidMessage_sector(le.sector_Invalid),Base_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Base_Fields.InvalidMessage_state(le.state_Invalid),Base_Fields.InvalidMessage_unit_flag(le.unit_flag_Invalid),Base_Fields.InvalidMessage_unit_flag_exp(le.unit_flag_exp_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Base_Fields.InvalidMessage_zip_code4(le.zip_code4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ace_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.brand_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_secondary_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.franchisee_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fruns_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.f_units_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.relationship_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.relationship_code_exp_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.secondary_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sector_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unit_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.unit_flag_exp_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code4_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ace_aid','address1','brand_name','chk_digit','city','clean_phone','clean_secondary_phone','company_name','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','err_stat','fips_county','fips_state','franchisee_id','fruns','f_units','industry','industry_type','p_city_name','phone','phone_extension','prim_name','record_id','record_type','relationship_code','relationship_code_exp','secondary_phone','sector','sic_code','state','unit_flag','unit_flag_exp','v_city_name','zip_code','zip_code4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_ace_aid','invalid_alpha','invalid_alpha','invalid_chk_digit','invalid_alpha','invalid_phone','invalid_secondary_phone','invalid_company_name','invalid_date','invalid_date','invalid_date','invalid_date','invalid_err_stat','invalid_fips_county','invalid_fips_state','invalid_franchisee_id','invalid_fruns','invalid_nonempty_number','invalid_alpha','invalid_industry_type','invalid_alpha','invalid_phone','invalid_numeric','invalid_alpha','invalid_nonempty_number','invalid_record_type','invalid_relationship_code','invalid_relationship_code_exp','invalid_secondary_phone','invalid_alpha','invalid_sic_code','invalid_state','invalid_unit_flag','invalid_unit_flag_exp','invalid_alpha','invalid_zip_code','invalid_zip_code4','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ace_aid,(SALT311.StrType)le.address1,(SALT311.StrType)le.brand_name,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.city,(SALT311.StrType)le.clean_phone,(SALT311.StrType)le.clean_secondary_phone,(SALT311.StrType)le.company_name,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.fips_county,(SALT311.StrType)le.fips_state,(SALT311.StrType)le.franchisee_id,(SALT311.StrType)le.fruns,(SALT311.StrType)le.f_units,(SALT311.StrType)le.industry,(SALT311.StrType)le.industry_type,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.phone,(SALT311.StrType)le.phone_extension,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.record_id,(SALT311.StrType)le.record_type,(SALT311.StrType)le.relationship_code,(SALT311.StrType)le.relationship_code_exp,(SALT311.StrType)le.secondary_phone,(SALT311.StrType)le.sector,(SALT311.StrType)le.sic_code,(SALT311.StrType)le.state,(SALT311.StrType)le.unit_flag,(SALT311.StrType)le.unit_flag_exp,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.zip_code,(SALT311.StrType)le.zip_code4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,37,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Frandx) prevDS = DATASET([], Base_Layout_Frandx), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ace_aid:invalid_ace_aid:CUSTOM'
          ,'address1:invalid_alpha:CUSTOM'
          ,'brand_name:invalid_alpha:CUSTOM'
          ,'chk_digit:invalid_chk_digit:CUSTOM'
          ,'city:invalid_alpha:CUSTOM'
          ,'clean_phone:invalid_phone:CUSTOM'
          ,'clean_secondary_phone:invalid_secondary_phone:CUSTOM'
          ,'company_name:invalid_company_name:CUSTOM'
          ,'dt_first_seen:invalid_date:CUSTOM'
          ,'dt_last_seen:invalid_date:CUSTOM'
          ,'dt_vendor_first_reported:invalid_date:CUSTOM'
          ,'dt_vendor_last_reported:invalid_date:CUSTOM'
          ,'err_stat:invalid_err_stat:ALLOW'
          ,'fips_county:invalid_fips_county:CUSTOM'
          ,'fips_state:invalid_fips_state:CUSTOM'
          ,'franchisee_id:invalid_franchisee_id:CUSTOM'
          ,'fruns:invalid_fruns:CUSTOM'
          ,'f_units:invalid_nonempty_number:CUSTOM'
          ,'industry:invalid_alpha:CUSTOM'
          ,'industry_type:invalid_industry_type:ENUM'
          ,'p_city_name:invalid_alpha:CUSTOM'
          ,'phone:invalid_phone:CUSTOM'
          ,'phone_extension:invalid_numeric:ALLOW'
          ,'prim_name:invalid_alpha:CUSTOM'
          ,'record_id:invalid_nonempty_number:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'relationship_code:invalid_relationship_code:ENUM'
          ,'relationship_code_exp:invalid_relationship_code_exp:ENUM'
          ,'secondary_phone:invalid_secondary_phone:CUSTOM'
          ,'sector:invalid_alpha:CUSTOM'
          ,'sic_code:invalid_sic_code:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'unit_flag:invalid_unit_flag:ENUM'
          ,'unit_flag_exp:invalid_unit_flag_exp:ENUM'
          ,'v_city_name:invalid_alpha:CUSTOM'
          ,'zip_code:invalid_zip_code:CUSTOM'
          ,'zip_code4:invalid_zip_code4:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_ace_aid(1)
          ,Base_Fields.InvalidMessage_address1(1)
          ,Base_Fields.InvalidMessage_brand_name(1)
          ,Base_Fields.InvalidMessage_chk_digit(1)
          ,Base_Fields.InvalidMessage_city(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_clean_secondary_phone(1)
          ,Base_Fields.InvalidMessage_company_name(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_err_stat(1)
          ,Base_Fields.InvalidMessage_fips_county(1)
          ,Base_Fields.InvalidMessage_fips_state(1)
          ,Base_Fields.InvalidMessage_franchisee_id(1)
          ,Base_Fields.InvalidMessage_fruns(1)
          ,Base_Fields.InvalidMessage_f_units(1)
          ,Base_Fields.InvalidMessage_industry(1)
          ,Base_Fields.InvalidMessage_industry_type(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_phone(1)
          ,Base_Fields.InvalidMessage_phone_extension(1)
          ,Base_Fields.InvalidMessage_prim_name(1)
          ,Base_Fields.InvalidMessage_record_id(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_relationship_code(1)
          ,Base_Fields.InvalidMessage_relationship_code_exp(1)
          ,Base_Fields.InvalidMessage_secondary_phone(1)
          ,Base_Fields.InvalidMessage_sector(1)
          ,Base_Fields.InvalidMessage_sic_code(1)
          ,Base_Fields.InvalidMessage_state(1)
          ,Base_Fields.InvalidMessage_unit_flag(1)
          ,Base_Fields.InvalidMessage_unit_flag_exp(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_zip_code(1)
          ,Base_Fields.InvalidMessage_zip_code4(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.brand_name_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.clean_secondary_phone_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.franchisee_id_CUSTOM_ErrorCount
          ,le.fruns_CUSTOM_ErrorCount
          ,le.f_units_CUSTOM_ErrorCount
          ,le.industry_CUSTOM_ErrorCount
          ,le.industry_type_ENUM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.relationship_code_ENUM_ErrorCount
          ,le.relationship_code_exp_ENUM_ErrorCount
          ,le.secondary_phone_CUSTOM_ErrorCount
          ,le.sector_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.unit_flag_ENUM_ErrorCount
          ,le.unit_flag_exp_ENUM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_code4_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.brand_name_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.clean_secondary_phone_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.franchisee_id_CUSTOM_ErrorCount
          ,le.fruns_CUSTOM_ErrorCount
          ,le.f_units_CUSTOM_ErrorCount
          ,le.industry_CUSTOM_ErrorCount
          ,le.industry_type_ENUM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.relationship_code_ENUM_ErrorCount
          ,le.relationship_code_exp_ENUM_ErrorCount
          ,le.secondary_phone_CUSTOM_ErrorCount
          ,le.sector_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.unit_flag_ENUM_ErrorCount
          ,le.unit_flag_exp_ENUM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_code4_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Frandx));
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
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_name:' + getFieldTypeText(h.brand_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_secondary_phone:' + getFieldTypeText(h.clean_secondary_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'franchisee_id:' + getFieldTypeText(h.franchisee_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fruns:' + getFieldTypeText(h.fruns) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'f_units:' + getFieldTypeText(h.f_units) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry:' + getFieldTypeText(h.industry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry_type:' + getFieldTypeText(h.industry_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_extension:' + getFieldTypeText(h.phone_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_id:' + getFieldTypeText(h.record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_code:' + getFieldTypeText(h.relationship_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_code_exp:' + getFieldTypeText(h.relationship_code_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'secondary_phone:' + getFieldTypeText(h.secondary_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sector:' + getFieldTypeText(h.sector) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_flag:' + getFieldTypeText(h.unit_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_flag_exp:' + getFieldTypeText(h.unit_flag_exp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code4:' + getFieldTypeText(h.zip_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ace_aid_cnt
          ,le.populated_address1_cnt
          ,le.populated_brand_name_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_city_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_clean_secondary_phone_cnt
          ,le.populated_company_name_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_franchisee_id_cnt
          ,le.populated_fruns_cnt
          ,le.populated_f_units_cnt
          ,le.populated_industry_cnt
          ,le.populated_industry_type_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_phone_cnt
          ,le.populated_phone_extension_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_record_id_cnt
          ,le.populated_record_type_cnt
          ,le.populated_relationship_code_cnt
          ,le.populated_relationship_code_exp_cnt
          ,le.populated_secondary_phone_cnt
          ,le.populated_sector_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_state_cnt
          ,le.populated_unit_flag_cnt
          ,le.populated_unit_flag_exp_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_zip_code4_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ace_aid_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_brand_name_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_city_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_clean_secondary_phone_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_franchisee_id_pcnt
          ,le.populated_fruns_pcnt
          ,le.populated_f_units_pcnt
          ,le.populated_industry_pcnt
          ,le.populated_industry_type_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phone_extension_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_record_id_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_relationship_code_pcnt
          ,le.populated_relationship_code_exp_pcnt
          ,le.populated_secondary_phone_pcnt
          ,le.populated_sector_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_state_pcnt
          ,le.populated_unit_flag_pcnt
          ,le.populated_unit_flag_exp_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_zip_code4_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,37,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Frandx));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),37,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_Frandx) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Frandx, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
