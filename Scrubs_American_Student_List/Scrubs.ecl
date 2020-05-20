IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 44;
  EXPORT NumRulesFromFieldType := 44;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 41;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_American_Student_List)
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 full_name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 address_1_Invalid;
    UNSIGNED1 address_2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 address_type_Invalid;
    UNSIGNED1 county_number_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 gender_code_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 birth_date_Invalid;
    UNSIGNED1 dob_formatted_Invalid;
    UNSIGNED1 telephone_Invalid;
    UNSIGNED1 college_class_Invalid;
    UNSIGNED1 college_code_Invalid;
    UNSIGNED1 college_code_exploded_Invalid;
    UNSIGNED1 college_type_Invalid;
    UNSIGNED1 college_type_exploded_Invalid;
    UNSIGNED1 head_of_household_gender_code_Invalid;
    UNSIGNED1 head_of_household_gender_Invalid;
    UNSIGNED1 income_level_code_Invalid;
    UNSIGNED1 new_income_level_code_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_American_Student_List)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_American_Student_List)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'ssn:invalid_nums:ALLOW'
          ,'process_date:invalid_date:CUSTOM'
          ,'date_first_seen:invalid_date:CUSTOM'
          ,'date_last_seen:invalid_date:CUSTOM'
          ,'date_vendor_first_reported:invalid_date:CUSTOM'
          ,'date_vendor_last_reported:invalid_date:CUSTOM'
          ,'full_name:invalid_alpha:ALLOW'
          ,'first_name:invalid_alpha:ALLOW'
          ,'last_name:invalid_alpha:ALLOW'
          ,'address_1:invalid_address:ALLOW'
          ,'address_2:invalid_address:ALLOW'
          ,'city:invalid_alpha:ALLOW'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTHS'
          ,'address_type:invalid_address_type:ENUM'
          ,'county_number:invalid_nums:ALLOW'
          ,'county_name:invalid_county_name:ALLOW','county_name:invalid_county_name:WORDS'
          ,'gender_code:invalid_gender_code:ENUM'
          ,'gender:invalid_gender:ENUM'
          ,'age:invalid_nums:ALLOW'
          ,'birth_date:invalid_nums:ALLOW'
          ,'dob_formatted:invalid_date:CUSTOM'
          ,'telephone:invalid_nums:ALLOW'
          ,'college_class:invalid_college_class:ENUM'
          ,'college_code:invalid_college_code:ENUM'
          ,'college_code_exploded:invalid_code_code_exploded:ENUM'
          ,'college_type:invalid_college_type:ENUM'
          ,'college_type_exploded:invalid_college_type_exploded:ENUM'
          ,'head_of_household_gender_code:invalid_gender_code:ENUM'
          ,'head_of_household_gender:invalid_gender:ENUM'
          ,'income_level_code:invalid_income_lvl_code:ENUM'
          ,'new_income_level_code:invalid_new_income_lvl_code:ENUM'
          ,'name_suffix:invalid_suffix:ALLOW','name_suffix:invalid_suffix:ENUM'
          ,'prim_range:invalid_address:ALLOW'
          ,'predir:invalid_address:ALLOW'
          ,'prim_name:invalid_address:ALLOW'
          ,'addr_suffix:invalid_address:ALLOW'
          ,'postdir:invalid_address:ALLOW'
          ,'unit_desig:invalid_address:ALLOW'
          ,'sec_range:invalid_address:ALLOW'
          ,'p_city_name:invalid_csz:ALLOW'
          ,'v_city_name:invalid_csz:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_ssn(1)
          ,Fields.InvalidMessage_process_date(1)
          ,Fields.InvalidMessage_date_first_seen(1)
          ,Fields.InvalidMessage_date_last_seen(1)
          ,Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Fields.InvalidMessage_full_name(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_address_1(1)
          ,Fields.InvalidMessage_address_2(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_address_type(1)
          ,Fields.InvalidMessage_county_number(1)
          ,Fields.InvalidMessage_county_name(1),Fields.InvalidMessage_county_name(2)
          ,Fields.InvalidMessage_gender_code(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_age(1)
          ,Fields.InvalidMessage_birth_date(1)
          ,Fields.InvalidMessage_dob_formatted(1)
          ,Fields.InvalidMessage_telephone(1)
          ,Fields.InvalidMessage_college_class(1)
          ,Fields.InvalidMessage_college_code(1)
          ,Fields.InvalidMessage_college_code_exploded(1)
          ,Fields.InvalidMessage_college_type(1)
          ,Fields.InvalidMessage_college_type_exploded(1)
          ,Fields.InvalidMessage_head_of_household_gender_code(1)
          ,Fields.InvalidMessage_head_of_household_gender(1)
          ,Fields.InvalidMessage_income_level_code(1)
          ,Fields.InvalidMessage_new_income_level_code(1)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_American_Student_List) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    SELF.full_name_Invalid := Fields.InValid_full_name((SALT311.StrType)le.full_name);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT311.StrType)le.last_name);
    SELF.address_1_Invalid := Fields.InValid_address_1((SALT311.StrType)le.address_1);
    SELF.address_2_Invalid := Fields.InValid_address_2((SALT311.StrType)le.address_2);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.address_type_Invalid := Fields.InValid_address_type((SALT311.StrType)le.address_type);
    SELF.county_number_Invalid := Fields.InValid_county_number((SALT311.StrType)le.county_number);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.gender_code_Invalid := Fields.InValid_gender_code((SALT311.StrType)le.gender_code);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.age_Invalid := Fields.InValid_age((SALT311.StrType)le.age);
    SELF.birth_date_Invalid := Fields.InValid_birth_date((SALT311.StrType)le.birth_date);
    SELF.dob_formatted_Invalid := Fields.InValid_dob_formatted((SALT311.StrType)le.dob_formatted);
    SELF.telephone_Invalid := Fields.InValid_telephone((SALT311.StrType)le.telephone);
    SELF.college_class_Invalid := Fields.InValid_college_class((SALT311.StrType)le.college_class);
    SELF.college_code_Invalid := Fields.InValid_college_code((SALT311.StrType)le.college_code);
    SELF.college_code_exploded_Invalid := Fields.InValid_college_code_exploded((SALT311.StrType)le.college_code_exploded);
    SELF.college_type_Invalid := Fields.InValid_college_type((SALT311.StrType)le.college_type);
    SELF.college_type_exploded_Invalid := Fields.InValid_college_type_exploded((SALT311.StrType)le.college_type_exploded);
    SELF.head_of_household_gender_code_Invalid := Fields.InValid_head_of_household_gender_code((SALT311.StrType)le.head_of_household_gender_code);
    SELF.head_of_household_gender_Invalid := Fields.InValid_head_of_household_gender((SALT311.StrType)le.head_of_household_gender);
    SELF.income_level_code_Invalid := Fields.InValid_income_level_code((SALT311.StrType)le.income_level_code);
    SELF.new_income_level_code_Invalid := Fields.InValid_new_income_level_code((SALT311.StrType)le.new_income_level_code);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_American_Student_List);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ssn_Invalid << 0 ) + ( le.process_date_Invalid << 1 ) + ( le.date_first_seen_Invalid << 2 ) + ( le.date_last_seen_Invalid << 3 ) + ( le.date_vendor_first_reported_Invalid << 4 ) + ( le.date_vendor_last_reported_Invalid << 5 ) + ( le.full_name_Invalid << 6 ) + ( le.first_name_Invalid << 7 ) + ( le.last_name_Invalid << 8 ) + ( le.address_1_Invalid << 9 ) + ( le.address_2_Invalid << 10 ) + ( le.city_Invalid << 11 ) + ( le.zip_Invalid << 12 ) + ( le.address_type_Invalid << 14 ) + ( le.county_number_Invalid << 15 ) + ( le.county_name_Invalid << 16 ) + ( le.gender_code_Invalid << 18 ) + ( le.gender_Invalid << 19 ) + ( le.age_Invalid << 20 ) + ( le.birth_date_Invalid << 21 ) + ( le.dob_formatted_Invalid << 22 ) + ( le.telephone_Invalid << 23 ) + ( le.college_class_Invalid << 24 ) + ( le.college_code_Invalid << 25 ) + ( le.college_code_exploded_Invalid << 26 ) + ( le.college_type_Invalid << 27 ) + ( le.college_type_exploded_Invalid << 28 ) + ( le.head_of_household_gender_code_Invalid << 29 ) + ( le.head_of_household_gender_Invalid << 30 ) + ( le.income_level_code_Invalid << 31 ) + ( le.new_income_level_code_Invalid << 32 ) + ( le.name_suffix_Invalid << 33 ) + ( le.prim_range_Invalid << 35 ) + ( le.predir_Invalid << 36 ) + ( le.prim_name_Invalid << 37 ) + ( le.addr_suffix_Invalid << 38 ) + ( le.postdir_Invalid << 39 ) + ( le.unit_desig_Invalid << 40 ) + ( le.sec_range_Invalid << 41 ) + ( le.p_city_name_Invalid << 42 ) + ( le.v_city_name_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_American_Student_List);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.full_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.address_1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.address_2_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.address_type_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.county_number_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.gender_code_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.birth_date_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.dob_formatted_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.college_class_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.college_code_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.college_code_exploded_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.college_type_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.college_type_exploded_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.head_of_household_gender_code_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.head_of_household_gender_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.income_level_code_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.new_income_level_code_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    full_name_ALLOW_ErrorCount := COUNT(GROUP,h.full_name_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    address_1_ALLOW_ErrorCount := COUNT(GROUP,h.address_1_Invalid=1);
    address_2_ALLOW_ErrorCount := COUNT(GROUP,h.address_2_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    address_type_ENUM_ErrorCount := COUNT(GROUP,h.address_type_Invalid=1);
    county_number_ALLOW_ErrorCount := COUNT(GROUP,h.county_number_Invalid=1);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    county_name_WORDS_ErrorCount := COUNT(GROUP,h.county_name_Invalid=2);
    county_name_Total_ErrorCount := COUNT(GROUP,h.county_name_Invalid>0);
    gender_code_ENUM_ErrorCount := COUNT(GROUP,h.gender_code_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    birth_date_ALLOW_ErrorCount := COUNT(GROUP,h.birth_date_Invalid=1);
    dob_formatted_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_formatted_Invalid=1);
    telephone_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    college_class_ENUM_ErrorCount := COUNT(GROUP,h.college_class_Invalid=1);
    college_code_ENUM_ErrorCount := COUNT(GROUP,h.college_code_Invalid=1);
    college_code_exploded_ENUM_ErrorCount := COUNT(GROUP,h.college_code_exploded_Invalid=1);
    college_type_ENUM_ErrorCount := COUNT(GROUP,h.college_type_Invalid=1);
    college_type_exploded_ENUM_ErrorCount := COUNT(GROUP,h.college_type_exploded_Invalid=1);
    head_of_household_gender_code_ENUM_ErrorCount := COUNT(GROUP,h.head_of_household_gender_code_Invalid=1);
    head_of_household_gender_ENUM_ErrorCount := COUNT(GROUP,h.head_of_household_gender_Invalid=1);
    income_level_code_ENUM_ErrorCount := COUNT(GROUP,h.income_level_code_Invalid=1);
    new_income_level_code_ENUM_ErrorCount := COUNT(GROUP,h.new_income_level_code_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ENUM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ssn_Invalid > 0 OR h.process_date_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.full_name_Invalid > 0 OR h.first_name_Invalid > 0 OR h.last_name_Invalid > 0 OR h.address_1_Invalid > 0 OR h.address_2_Invalid > 0 OR h.city_Invalid > 0 OR h.zip_Invalid > 0 OR h.address_type_Invalid > 0 OR h.county_number_Invalid > 0 OR h.county_name_Invalid > 0 OR h.gender_code_Invalid > 0 OR h.gender_Invalid > 0 OR h.age_Invalid > 0 OR h.birth_date_Invalid > 0 OR h.dob_formatted_Invalid > 0 OR h.telephone_Invalid > 0 OR h.college_class_Invalid > 0 OR h.college_code_Invalid > 0 OR h.college_code_exploded_Invalid > 0 OR h.college_type_Invalid > 0 OR h.college_type_exploded_Invalid > 0 OR h.head_of_household_gender_code_Invalid > 0 OR h.head_of_household_gender_Invalid > 0 OR h.income_level_code_Invalid > 0 OR h.new_income_level_code_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.address_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_Total_ErrorCount > 0, 1, 0) + IF(le.gender_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.birth_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_formatted_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_code_exploded_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_type_exploded_ENUM_ErrorCount > 0, 1, 0) + IF(le.head_of_household_gender_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.head_of_household_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.income_level_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.new_income_level_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.address_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.gender_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.birth_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_formatted_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_code_exploded_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_type_exploded_ENUM_ErrorCount > 0, 1, 0) + IF(le.head_of_household_gender_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.head_of_household_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.income_level_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.new_income_level_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ssn_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.full_name_Invalid,le.first_name_Invalid,le.last_name_Invalid,le.address_1_Invalid,le.address_2_Invalid,le.city_Invalid,le.zip_Invalid,le.address_type_Invalid,le.county_number_Invalid,le.county_name_Invalid,le.gender_code_Invalid,le.gender_Invalid,le.age_Invalid,le.birth_date_Invalid,le.dob_formatted_Invalid,le.telephone_Invalid,le.college_class_Invalid,le.college_code_Invalid,le.college_code_exploded_Invalid,le.college_type_Invalid,le.college_type_exploded_Invalid,le.head_of_household_gender_code_Invalid,le.head_of_household_gender_Invalid,le.income_level_code_Invalid,le.new_income_level_code_Invalid,le.name_suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_full_name(le.full_name_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_address_1(le.address_1_Invalid),Fields.InvalidMessage_address_2(le.address_2_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_address_type(le.address_type_Invalid),Fields.InvalidMessage_county_number(le.county_number_Invalid),Fields.InvalidMessage_county_name(le.county_name_Invalid),Fields.InvalidMessage_gender_code(le.gender_code_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_age(le.age_Invalid),Fields.InvalidMessage_birth_date(le.birth_date_Invalid),Fields.InvalidMessage_dob_formatted(le.dob_formatted_Invalid),Fields.InvalidMessage_telephone(le.telephone_Invalid),Fields.InvalidMessage_college_class(le.college_class_Invalid),Fields.InvalidMessage_college_code(le.college_code_Invalid),Fields.InvalidMessage_college_code_exploded(le.college_code_exploded_Invalid),Fields.InvalidMessage_college_type(le.college_type_Invalid),Fields.InvalidMessage_college_type_exploded(le.college_type_exploded_Invalid),Fields.InvalidMessage_head_of_household_gender_code(le.head_of_household_gender_code_Invalid),Fields.InvalidMessage_head_of_household_gender(le.head_of_household_gender_Invalid),Fields.InvalidMessage_income_level_code(le.income_level_code_Invalid),Fields.InvalidMessage_new_income_level_code(le.new_income_level_code_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.full_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.address_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.county_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.birth_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_formatted_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.college_class_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.college_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.college_code_exploded_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.college_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.college_type_exploded_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.head_of_household_gender_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.head_of_household_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.income_level_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.new_income_level_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','ENUM','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ssn','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','full_name','first_name','last_name','address_1','address_2','city','zip','address_type','county_number','county_name','gender_code','gender','age','birth_date','dob_formatted','telephone','college_class','college_code','college_code_exploded','college_type','college_type_exploded','head_of_household_gender_code','head_of_household_gender','income_level_code','new_income_level_code','name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_nums','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_alpha','invalid_alpha','invalid_alpha','invalid_address','invalid_address','invalid_alpha','invalid_zip','invalid_address_type','invalid_nums','invalid_county_name','invalid_gender_code','invalid_gender','invalid_nums','invalid_nums','invalid_date','invalid_nums','invalid_college_class','invalid_college_code','invalid_code_code_exploded','invalid_college_type','invalid_college_type_exploded','invalid_gender_code','invalid_gender','invalid_income_lvl_code','invalid_new_income_lvl_code','invalid_suffix','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_csz','invalid_csz','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ssn,(SALT311.StrType)le.process_date,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.date_vendor_first_reported,(SALT311.StrType)le.date_vendor_last_reported,(SALT311.StrType)le.full_name,(SALT311.StrType)le.first_name,(SALT311.StrType)le.last_name,(SALT311.StrType)le.address_1,(SALT311.StrType)le.address_2,(SALT311.StrType)le.city,(SALT311.StrType)le.zip,(SALT311.StrType)le.address_type,(SALT311.StrType)le.county_number,(SALT311.StrType)le.county_name,(SALT311.StrType)le.gender_code,(SALT311.StrType)le.gender,(SALT311.StrType)le.age,(SALT311.StrType)le.birth_date,(SALT311.StrType)le.dob_formatted,(SALT311.StrType)le.telephone,(SALT311.StrType)le.college_class,(SALT311.StrType)le.college_code,(SALT311.StrType)le.college_code_exploded,(SALT311.StrType)le.college_type,(SALT311.StrType)le.college_type_exploded,(SALT311.StrType)le.head_of_household_gender_code,(SALT311.StrType)le.head_of_household_gender,(SALT311.StrType)le.income_level_code,(SALT311.StrType)le.new_income_level_code,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_American_Student_List) prevDS = DATASET([], Layout_American_Student_List), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.ssn_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.full_name_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount
          ,le.address_1_ALLOW_ErrorCount
          ,le.address_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.address_type_ENUM_ErrorCount
          ,le.county_number_ALLOW_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.gender_code_ENUM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.birth_date_ALLOW_ErrorCount
          ,le.dob_formatted_CUSTOM_ErrorCount
          ,le.telephone_ALLOW_ErrorCount
          ,le.college_class_ENUM_ErrorCount
          ,le.college_code_ENUM_ErrorCount
          ,le.college_code_exploded_ENUM_ErrorCount
          ,le.college_type_ENUM_ErrorCount
          ,le.college_type_exploded_ENUM_ErrorCount
          ,le.head_of_household_gender_code_ENUM_ErrorCount
          ,le.head_of_household_gender_ENUM_ErrorCount
          ,le.income_level_code_ENUM_ErrorCount
          ,le.new_income_level_code_ENUM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_ENUM_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ssn_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.full_name_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount
          ,le.address_1_ALLOW_ErrorCount
          ,le.address_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.address_type_ENUM_ErrorCount
          ,le.county_number_ALLOW_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.gender_code_ENUM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.birth_date_ALLOW_ErrorCount
          ,le.dob_formatted_CUSTOM_ErrorCount
          ,le.telephone_ALLOW_ErrorCount
          ,le.college_class_ENUM_ErrorCount
          ,le.college_code_ENUM_ErrorCount
          ,le.college_code_exploded_ENUM_ErrorCount
          ,le.college_type_ENUM_ErrorCount
          ,le.college_type_exploded_ENUM_ErrorCount
          ,le.head_of_household_gender_code_ENUM_ErrorCount
          ,le.head_of_household_gender_ENUM_ErrorCount
          ,le.income_level_code_ENUM_ErrorCount
          ,le.new_income_level_code_ENUM_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_ENUM_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_American_Student_List));
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
          ,'key:' + getFieldTypeText(h.key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'historical_flag:' + getFieldTypeText(h.historical_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_name:' + getFieldTypeText(h.full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_1:' + getFieldTypeText(h.address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_2:' + getFieldTypeText(h.address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_4:' + getFieldTypeText(h.zip_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crrt_code:' + getFieldTypeText(h.crrt_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delivery_point_barcode:' + getFieldTypeText(h.delivery_point_barcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4_check_digit:' + getFieldTypeText(h.zip4_check_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type_code:' + getFieldTypeText(h.address_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type:' + getFieldTypeText(h.address_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_number:' + getFieldTypeText(h.county_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender_code:' + getFieldTypeText(h.gender_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age:' + getFieldTypeText(h.age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'birth_date:' + getFieldTypeText(h.birth_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob_formatted:' + getFieldTypeText(h.dob_formatted) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone:' + getFieldTypeText(h.telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'class:' + getFieldTypeText(h.class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_class:' + getFieldTypeText(h.college_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_name:' + getFieldTypeText(h.college_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_college_name:' + getFieldTypeText(h.ln_college_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_major:' + getFieldTypeText(h.college_major) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_college_major:' + getFieldTypeText(h.new_college_major) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_code:' + getFieldTypeText(h.college_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_code_exploded:' + getFieldTypeText(h.college_code_exploded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_type:' + getFieldTypeText(h.college_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_type_exploded:' + getFieldTypeText(h.college_type_exploded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_of_household_first_name:' + getFieldTypeText(h.head_of_household_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_of_household_gender_code:' + getFieldTypeText(h.head_of_household_gender_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_of_household_gender:' + getFieldTypeText(h.head_of_household_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'income_level_code:' + getFieldTypeText(h.income_level_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'income_level:' + getFieldTypeText(h.income_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_income_level_code:' + getFieldTypeText(h.new_income_level_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_income_level:' + getFieldTypeText(h.new_income_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_type:' + getFieldTypeText(h.file_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tier:' + getFieldTypeText(h.tier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'school_size_code:' + getFieldTypeText(h.school_size_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'competitive_code:' + getFieldTypeText(h.competitive_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tuition_code:' + getFieldTypeText(h.tuition_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'z5:' + getFieldTypeText(h.z5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tier2:' + getFieldTypeText(h.tier2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_key_cnt
          ,le.populated_ssn_cnt
          ,le.populated_did_cnt
          ,le.populated_process_date_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_historical_flag_cnt
          ,le.populated_full_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_last_name_cnt
          ,le.populated_address_1_cnt
          ,le.populated_address_2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip_4_cnt
          ,le.populated_crrt_code_cnt
          ,le.populated_delivery_point_barcode_cnt
          ,le.populated_zip4_check_digit_cnt
          ,le.populated_address_type_code_cnt
          ,le.populated_address_type_cnt
          ,le.populated_county_number_cnt
          ,le.populated_county_name_cnt
          ,le.populated_gender_code_cnt
          ,le.populated_gender_cnt
          ,le.populated_age_cnt
          ,le.populated_birth_date_cnt
          ,le.populated_dob_formatted_cnt
          ,le.populated_telephone_cnt
          ,le.populated_class_cnt
          ,le.populated_college_class_cnt
          ,le.populated_college_name_cnt
          ,le.populated_ln_college_name_cnt
          ,le.populated_college_major_cnt
          ,le.populated_new_college_major_cnt
          ,le.populated_college_code_cnt
          ,le.populated_college_code_exploded_cnt
          ,le.populated_college_type_cnt
          ,le.populated_college_type_exploded_cnt
          ,le.populated_head_of_household_first_name_cnt
          ,le.populated_head_of_household_gender_code_cnt
          ,le.populated_head_of_household_gender_cnt
          ,le.populated_income_level_code_cnt
          ,le.populated_income_level_cnt
          ,le.populated_new_income_level_code_cnt
          ,le.populated_new_income_level_cnt
          ,le.populated_file_type_cnt
          ,le.populated_tier_cnt
          ,le.populated_school_size_code_cnt
          ,le.populated_competitive_code_cnt
          ,le.populated_tuition_code_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_rawaid_cnt
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
          ,le.populated_z5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_tier2_cnt
          ,le.populated_source_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_key_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_did_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_historical_flag_pcnt
          ,le.populated_full_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_address_1_pcnt
          ,le.populated_address_2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip_4_pcnt
          ,le.populated_crrt_code_pcnt
          ,le.populated_delivery_point_barcode_pcnt
          ,le.populated_zip4_check_digit_pcnt
          ,le.populated_address_type_code_pcnt
          ,le.populated_address_type_pcnt
          ,le.populated_county_number_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_gender_code_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_age_pcnt
          ,le.populated_birth_date_pcnt
          ,le.populated_dob_formatted_pcnt
          ,le.populated_telephone_pcnt
          ,le.populated_class_pcnt
          ,le.populated_college_class_pcnt
          ,le.populated_college_name_pcnt
          ,le.populated_ln_college_name_pcnt
          ,le.populated_college_major_pcnt
          ,le.populated_new_college_major_pcnt
          ,le.populated_college_code_pcnt
          ,le.populated_college_code_exploded_pcnt
          ,le.populated_college_type_pcnt
          ,le.populated_college_type_exploded_pcnt
          ,le.populated_head_of_household_first_name_pcnt
          ,le.populated_head_of_household_gender_code_pcnt
          ,le.populated_head_of_household_gender_pcnt
          ,le.populated_income_level_code_pcnt
          ,le.populated_income_level_pcnt
          ,le.populated_new_income_level_code_pcnt
          ,le.populated_new_income_level_pcnt
          ,le.populated_file_type_pcnt
          ,le.populated_tier_pcnt
          ,le.populated_school_size_code_pcnt
          ,le.populated_competitive_code_pcnt
          ,le.populated_tuition_code_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_rawaid_pcnt
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
          ,le.populated_z5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_tier2_pcnt
          ,le.populated_source_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,90,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_American_Student_List));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),90,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_American_Student_List) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_American_Student_List, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
