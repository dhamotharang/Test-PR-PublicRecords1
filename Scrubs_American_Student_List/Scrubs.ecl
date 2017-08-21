IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_American_Student_List)
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
EXPORT FromNone(DATASET(Layout_American_Student_List) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT36.StrType)le.ssn);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT36.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT36.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT36.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT36.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT36.StrType)le.date_vendor_last_reported);
    SELF.full_name_Invalid := Fields.InValid_full_name((SALT36.StrType)le.full_name);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT36.StrType)le.first_name);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT36.StrType)le.last_name);
    SELF.address_1_Invalid := Fields.InValid_address_1((SALT36.StrType)le.address_1);
    SELF.address_2_Invalid := Fields.InValid_address_2((SALT36.StrType)le.address_2);
    SELF.city_Invalid := Fields.InValid_city((SALT36.StrType)le.city);
    SELF.zip_Invalid := Fields.InValid_zip((SALT36.StrType)le.zip);
    SELF.address_type_Invalid := Fields.InValid_address_type((SALT36.StrType)le.address_type);
    SELF.county_number_Invalid := Fields.InValid_county_number((SALT36.StrType)le.county_number);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT36.StrType)le.county_name);
    SELF.gender_code_Invalid := Fields.InValid_gender_code((SALT36.StrType)le.gender_code);
    SELF.gender_Invalid := Fields.InValid_gender((SALT36.StrType)le.gender);
    SELF.age_Invalid := Fields.InValid_age((SALT36.StrType)le.age);
    SELF.birth_date_Invalid := Fields.InValid_birth_date((SALT36.StrType)le.birth_date);
    SELF.dob_formatted_Invalid := Fields.InValid_dob_formatted((SALT36.StrType)le.dob_formatted);
    SELF.telephone_Invalid := Fields.InValid_telephone((SALT36.StrType)le.telephone);
    SELF.college_class_Invalid := Fields.InValid_college_class((SALT36.StrType)le.college_class);
    SELF.college_code_Invalid := Fields.InValid_college_code((SALT36.StrType)le.college_code);
    SELF.college_code_exploded_Invalid := Fields.InValid_college_code_exploded((SALT36.StrType)le.college_code_exploded);
    SELF.college_type_Invalid := Fields.InValid_college_type((SALT36.StrType)le.college_type);
    SELF.college_type_exploded_Invalid := Fields.InValid_college_type_exploded((SALT36.StrType)le.college_type_exploded);
    SELF.head_of_household_gender_code_Invalid := Fields.InValid_head_of_household_gender_code((SALT36.StrType)le.head_of_household_gender_code);
    SELF.head_of_household_gender_Invalid := Fields.InValid_head_of_household_gender((SALT36.StrType)le.head_of_household_gender);
    SELF.income_level_code_Invalid := Fields.InValid_income_level_code((SALT36.StrType)le.income_level_code);
    SELF.new_income_level_code_Invalid := Fields.InValid_new_income_level_code((SALT36.StrType)le.new_income_level_code);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT36.StrType)le.name_suffix);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT36.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT36.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT36.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT36.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT36.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT36.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT36.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT36.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT36.StrType)le.v_city_name);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_American_Student_List);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ssn_Invalid << 0 ) + ( le.process_date_Invalid << 1 ) + ( le.date_first_seen_Invalid << 2 ) + ( le.date_last_seen_Invalid << 3 ) + ( le.date_vendor_first_reported_Invalid << 4 ) + ( le.date_vendor_last_reported_Invalid << 5 ) + ( le.full_name_Invalid << 6 ) + ( le.first_name_Invalid << 8 ) + ( le.last_name_Invalid << 10 ) + ( le.address_1_Invalid << 12 ) + ( le.address_2_Invalid << 13 ) + ( le.city_Invalid << 14 ) + ( le.zip_Invalid << 16 ) + ( le.address_type_Invalid << 18 ) + ( le.county_number_Invalid << 19 ) + ( le.county_name_Invalid << 20 ) + ( le.gender_code_Invalid << 22 ) + ( le.gender_Invalid << 23 ) + ( le.age_Invalid << 24 ) + ( le.birth_date_Invalid << 25 ) + ( le.dob_formatted_Invalid << 26 ) + ( le.telephone_Invalid << 27 ) + ( le.college_class_Invalid << 28 ) + ( le.college_code_Invalid << 29 ) + ( le.college_code_exploded_Invalid << 30 ) + ( le.college_type_Invalid << 31 ) + ( le.college_type_exploded_Invalid << 32 ) + ( le.head_of_household_gender_code_Invalid << 33 ) + ( le.head_of_household_gender_Invalid << 34 ) + ( le.income_level_code_Invalid << 35 ) + ( le.new_income_level_code_Invalid << 36 ) + ( le.name_suffix_Invalid << 37 ) + ( le.prim_range_Invalid << 39 ) + ( le.predir_Invalid << 40 ) + ( le.prim_name_Invalid << 41 ) + ( le.addr_suffix_Invalid << 42 ) + ( le.postdir_Invalid << 43 ) + ( le.unit_desig_Invalid << 44 ) + ( le.sec_range_Invalid << 45 ) + ( le.p_city_name_Invalid << 46 ) + ( le.v_city_name_Invalid << 47 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
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
    SELF.full_name_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.address_1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.address_2_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.address_type_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.county_number_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.gender_code_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.birth_date_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dob_formatted_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.college_class_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.college_code_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.college_code_exploded_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.college_type_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.college_type_exploded_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.head_of_household_gender_code_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.head_of_household_gender_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.income_level_code_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.new_income_level_code_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 47) & 1;
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
    full_name_LENGTH_ErrorCount := COUNT(GROUP,h.full_name_Invalid=2);
    full_name_Total_ErrorCount := COUNT(GROUP,h.full_name_Invalid>0);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=2);
    first_name_Total_ErrorCount := COUNT(GROUP,h.first_name_Invalid>0);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_Invalid=2);
    last_name_Total_ErrorCount := COUNT(GROUP,h.last_name_Invalid>0);
    address_1_ALLOW_ErrorCount := COUNT(GROUP,h.address_1_Invalid=1);
    address_2_ALLOW_ErrorCount := COUNT(GROUP,h.address_2_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_LENGTH_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
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
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
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
          ,CHOOSE(le.full_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
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
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.ssn,(SALT36.StrType)le.process_date,(SALT36.StrType)le.date_first_seen,(SALT36.StrType)le.date_last_seen,(SALT36.StrType)le.date_vendor_first_reported,(SALT36.StrType)le.date_vendor_last_reported,(SALT36.StrType)le.full_name,(SALT36.StrType)le.first_name,(SALT36.StrType)le.last_name,(SALT36.StrType)le.address_1,(SALT36.StrType)le.address_2,(SALT36.StrType)le.city,(SALT36.StrType)le.zip,(SALT36.StrType)le.address_type,(SALT36.StrType)le.county_number,(SALT36.StrType)le.county_name,(SALT36.StrType)le.gender_code,(SALT36.StrType)le.gender,(SALT36.StrType)le.age,(SALT36.StrType)le.birth_date,(SALT36.StrType)le.dob_formatted,(SALT36.StrType)le.telephone,(SALT36.StrType)le.college_class,(SALT36.StrType)le.college_code,(SALT36.StrType)le.college_code_exploded,(SALT36.StrType)le.college_type,(SALT36.StrType)le.college_type_exploded,(SALT36.StrType)le.head_of_household_gender_code,(SALT36.StrType)le.head_of_household_gender,(SALT36.StrType)le.income_level_code,(SALT36.StrType)le.new_income_level_code,(SALT36.StrType)le.name_suffix,(SALT36.StrType)le.prim_range,(SALT36.StrType)le.predir,(SALT36.StrType)le.prim_name,(SALT36.StrType)le.addr_suffix,(SALT36.StrType)le.postdir,(SALT36.StrType)le.unit_desig,(SALT36.StrType)le.sec_range,(SALT36.StrType)le.p_city_name,(SALT36.StrType)le.v_city_name,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ssn:invalid_nums:ALLOW'
          ,'process_date:invalid_date:CUSTOM'
          ,'date_first_seen:invalid_date:CUSTOM'
          ,'date_last_seen:invalid_date:CUSTOM'
          ,'date_vendor_first_reported:invalid_date:CUSTOM'
          ,'date_vendor_last_reported:invalid_date:CUSTOM'
          ,'full_name:invalid_alpha:ALLOW','full_name:invalid_alpha:LENGTH'
          ,'first_name:invalid_alpha:ALLOW','first_name:invalid_alpha:LENGTH'
          ,'last_name:invalid_alpha:ALLOW','last_name:invalid_alpha:LENGTH'
          ,'address_1:invalid_address:ALLOW'
          ,'address_2:invalid_address:ALLOW'
          ,'city:invalid_alpha:ALLOW','city:invalid_alpha:LENGTH'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
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
          ,'v_city_name:invalid_csz:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ssn(1)
          ,Fields.InvalidMessage_process_date(1)
          ,Fields.InvalidMessage_date_first_seen(1)
          ,Fields.InvalidMessage_date_last_seen(1)
          ,Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Fields.InvalidMessage_full_name(1),Fields.InvalidMessage_full_name(2)
          ,Fields.InvalidMessage_first_name(1),Fields.InvalidMessage_first_name(2)
          ,Fields.InvalidMessage_last_name(1),Fields.InvalidMessage_last_name(2)
          ,Fields.InvalidMessage_address_1(1)
          ,Fields.InvalidMessage_address_2(1)
          ,Fields.InvalidMessage_city(1),Fields.InvalidMessage_city(2)
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
          ,Fields.InvalidMessage_v_city_name(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ssn_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.full_name_ALLOW_ErrorCount,le.full_name_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.address_1_ALLOW_ErrorCount
          ,le.address_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
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
          ,le.v_city_name_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ssn_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.full_name_ALLOW_ErrorCount,le.full_name_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.address_1_ALLOW_ErrorCount
          ,le.address_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
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
          ,le.v_city_name_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,48,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
