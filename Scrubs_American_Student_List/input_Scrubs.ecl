IMPORT SALT38,STD;
EXPORT input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 20;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(input_Layout_American_Student_List)
    UNSIGNED1 name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 address_1_Invalid;
    UNSIGNED1 address_2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 z5_Invalid;
    UNSIGNED1 county_number_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 birth_date_Invalid;
    UNSIGNED1 telephone_Invalid;
    UNSIGNED1 college_class_Invalid;
    UNSIGNED1 college_major_Invalid;
    UNSIGNED1 college_code_Invalid;
    UNSIGNED1 college_type_Invalid;
    UNSIGNED1 head_of_household_gender_Invalid;
    UNSIGNED1 income_level_Invalid;
    UNSIGNED1 file_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(input_Layout_American_Student_List)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(input_Layout_American_Student_List) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.name_Invalid := input_Fields.InValid_name((SALT38.StrType)le.name);
    SELF.first_name_Invalid := input_Fields.InValid_first_name((SALT38.StrType)le.first_name);
    SELF.last_name_Invalid := input_Fields.InValid_last_name((SALT38.StrType)le.last_name);
    SELF.address_1_Invalid := input_Fields.InValid_address_1((SALT38.StrType)le.address_1);
    SELF.address_2_Invalid := input_Fields.InValid_address_2((SALT38.StrType)le.address_2);
    SELF.city_Invalid := input_Fields.InValid_city((SALT38.StrType)le.city);
    SELF.z5_Invalid := input_Fields.InValid_z5((SALT38.StrType)le.z5);
    SELF.county_number_Invalid := input_Fields.InValid_county_number((SALT38.StrType)le.county_number);
    SELF.county_name_Invalid := input_Fields.InValid_county_name((SALT38.StrType)le.county_name);
    SELF.gender_Invalid := input_Fields.InValid_gender((SALT38.StrType)le.gender);
    SELF.age_Invalid := input_Fields.InValid_age((SALT38.StrType)le.age);
    SELF.birth_date_Invalid := input_Fields.InValid_birth_date((SALT38.StrType)le.birth_date);
    SELF.telephone_Invalid := input_Fields.InValid_telephone((SALT38.StrType)le.telephone);
    SELF.college_class_Invalid := input_Fields.InValid_college_class((SALT38.StrType)le.college_class);
    SELF.college_major_Invalid := input_Fields.InValid_college_major((SALT38.StrType)le.college_major);
    SELF.college_code_Invalid := input_Fields.InValid_college_code((SALT38.StrType)le.college_code);
    SELF.college_type_Invalid := input_Fields.InValid_college_type((SALT38.StrType)le.college_type);
    SELF.head_of_household_gender_Invalid := input_Fields.InValid_head_of_household_gender((SALT38.StrType)le.head_of_household_gender);
    SELF.income_level_Invalid := input_Fields.InValid_income_level((SALT38.StrType)le.income_level);
    SELF.file_type_Invalid := input_Fields.InValid_file_type((SALT38.StrType)le.file_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),input_Layout_American_Student_List);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.name_Invalid << 0 ) + ( le.first_name_Invalid << 2 ) + ( le.last_name_Invalid << 4 ) + ( le.address_1_Invalid << 6 ) + ( le.address_2_Invalid << 7 ) + ( le.city_Invalid << 8 ) + ( le.z5_Invalid << 10 ) + ( le.county_number_Invalid << 12 ) + ( le.county_name_Invalid << 13 ) + ( le.gender_Invalid << 15 ) + ( le.age_Invalid << 16 ) + ( le.birth_date_Invalid << 17 ) + ( le.telephone_Invalid << 18 ) + ( le.college_class_Invalid << 19 ) + ( le.college_major_Invalid << 20 ) + ( le.college_code_Invalid << 21 ) + ( le.college_type_Invalid << 22 ) + ( le.head_of_household_gender_Invalid << 23 ) + ( le.income_level_Invalid << 24 ) + ( le.file_type_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,input_Layout_American_Student_List);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.name_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.address_1_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.address_2_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.z5_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.county_number_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.birth_date_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.college_class_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.college_major_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.college_code_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.college_type_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.head_of_household_gender_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.income_level_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.file_type_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    name_ALLOW_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    name_LENGTH_ErrorCount := COUNT(GROUP,h.name_Invalid=2);
    name_Total_ErrorCount := COUNT(GROUP,h.name_Invalid>0);
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
    z5_ALLOW_ErrorCount := COUNT(GROUP,h.z5_Invalid=1);
    z5_LENGTH_ErrorCount := COUNT(GROUP,h.z5_Invalid=2);
    z5_Total_ErrorCount := COUNT(GROUP,h.z5_Invalid>0);
    county_number_ALLOW_ErrorCount := COUNT(GROUP,h.county_number_Invalid=1);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    county_name_WORDS_ErrorCount := COUNT(GROUP,h.county_name_Invalid=2);
    county_name_Total_ErrorCount := COUNT(GROUP,h.county_name_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    birth_date_ALLOW_ErrorCount := COUNT(GROUP,h.birth_date_Invalid=1);
    telephone_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    college_class_ENUM_ErrorCount := COUNT(GROUP,h.college_class_Invalid=1);
    college_major_ALLOW_ErrorCount := COUNT(GROUP,h.college_major_Invalid=1);
    college_code_ENUM_ErrorCount := COUNT(GROUP,h.college_code_Invalid=1);
    college_type_ENUM_ErrorCount := COUNT(GROUP,h.college_type_Invalid=1);
    head_of_household_gender_ENUM_ErrorCount := COUNT(GROUP,h.head_of_household_gender_Invalid=1);
    income_level_ENUM_ErrorCount := COUNT(GROUP,h.income_level_Invalid=1);
    file_type_ENUM_ErrorCount := COUNT(GROUP,h.file_type_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.name_Invalid > 0 OR h.first_name_Invalid > 0 OR h.last_name_Invalid > 0 OR h.address_1_Invalid > 0 OR h.address_2_Invalid > 0 OR h.city_Invalid > 0 OR h.z5_Invalid > 0 OR h.county_number_Invalid > 0 OR h.county_name_Invalid > 0 OR h.gender_Invalid > 0 OR h.age_Invalid > 0 OR h.birth_date_Invalid > 0 OR h.telephone_Invalid > 0 OR h.college_class_Invalid > 0 OR h.college_major_Invalid > 0 OR h.college_code_Invalid > 0 OR h.college_type_Invalid > 0 OR h.head_of_household_gender_Invalid > 0 OR h.income_level_Invalid > 0 OR h.file_type_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.name_Total_ErrorCount > 0, 1, 0) + IF(le.first_name_Total_ErrorCount > 0, 1, 0) + IF(le.last_name_Total_ErrorCount > 0, 1, 0) + IF(le.address_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.z5_Total_ErrorCount > 0, 1, 0) + IF(le.county_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_Total_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.birth_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_major_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.head_of_household_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.income_level_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_type_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_LENGTH_ErrorCount > 0, 1, 0) + IF(le.address_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_LENGTH_ErrorCount > 0, 1, 0) + IF(le.z5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.z5_LENGTH_ErrorCount > 0, 1, 0) + IF(le.county_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.birth_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_major_ALLOW_ErrorCount > 0, 1, 0) + IF(le.college_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.college_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.head_of_household_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.income_level_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_type_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.name_Invalid,le.first_name_Invalid,le.last_name_Invalid,le.address_1_Invalid,le.address_2_Invalid,le.city_Invalid,le.z5_Invalid,le.county_number_Invalid,le.county_name_Invalid,le.gender_Invalid,le.age_Invalid,le.birth_date_Invalid,le.telephone_Invalid,le.college_class_Invalid,le.college_major_Invalid,le.college_code_Invalid,le.college_type_Invalid,le.head_of_household_gender_Invalid,le.income_level_Invalid,le.file_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,input_Fields.InvalidMessage_name(le.name_Invalid),input_Fields.InvalidMessage_first_name(le.first_name_Invalid),input_Fields.InvalidMessage_last_name(le.last_name_Invalid),input_Fields.InvalidMessage_address_1(le.address_1_Invalid),input_Fields.InvalidMessage_address_2(le.address_2_Invalid),input_Fields.InvalidMessage_city(le.city_Invalid),input_Fields.InvalidMessage_z5(le.z5_Invalid),input_Fields.InvalidMessage_county_number(le.county_number_Invalid),input_Fields.InvalidMessage_county_name(le.county_name_Invalid),input_Fields.InvalidMessage_gender(le.gender_Invalid),input_Fields.InvalidMessage_age(le.age_Invalid),input_Fields.InvalidMessage_birth_date(le.birth_date_Invalid),input_Fields.InvalidMessage_telephone(le.telephone_Invalid),input_Fields.InvalidMessage_college_class(le.college_class_Invalid),input_Fields.InvalidMessage_college_major(le.college_major_Invalid),input_Fields.InvalidMessage_college_code(le.college_code_Invalid),input_Fields.InvalidMessage_college_type(le.college_type_Invalid),input_Fields.InvalidMessage_head_of_household_gender(le.head_of_household_gender_Invalid),input_Fields.InvalidMessage_income_level(le.income_level_Invalid),input_Fields.InvalidMessage_file_type(le.file_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.z5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.birth_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.college_class_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.college_major_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.college_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.college_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.head_of_household_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.income_level_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_type_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'name','first_name','last_name','address_1','address_2','city','z5','county_number','county_name','gender','age','birth_date','telephone','college_class','college_major','college_code','college_type','head_of_household_gender','income_level','file_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alpha','invalid_alpha','invalid_alpha','invalid_address','invalid_address','invalid_alpha','invalid_zip','invalid_nums','invalid_county_name','invalid_gender_code','invalid_nums','invalid_nums','invalid_nums','invalid_college_class','invalid_major','invalid_college_code','invalid_college_type','invalid_gender_code','invalid_income_lvl_code','invalid_file_type','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.last_name,(SALT38.StrType)le.address_1,(SALT38.StrType)le.address_2,(SALT38.StrType)le.city,(SALT38.StrType)le.z5,(SALT38.StrType)le.county_number,(SALT38.StrType)le.county_name,(SALT38.StrType)le.gender,(SALT38.StrType)le.age,(SALT38.StrType)le.birth_date,(SALT38.StrType)le.telephone,(SALT38.StrType)le.college_class,(SALT38.StrType)le.college_major,(SALT38.StrType)le.college_code,(SALT38.StrType)le.college_type,(SALT38.StrType)le.head_of_household_gender,(SALT38.StrType)le.income_level,(SALT38.StrType)le.file_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(input_Layout_American_Student_List) prevDS = DATASET([], input_Layout_American_Student_List), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'name:invalid_alpha:ALLOW','name:invalid_alpha:LENGTH'
          ,'first_name:invalid_alpha:ALLOW','first_name:invalid_alpha:LENGTH'
          ,'last_name:invalid_alpha:ALLOW','last_name:invalid_alpha:LENGTH'
          ,'address_1:invalid_address:ALLOW'
          ,'address_2:invalid_address:ALLOW'
          ,'city:invalid_alpha:ALLOW','city:invalid_alpha:LENGTH'
          ,'z5:invalid_zip:ALLOW','z5:invalid_zip:LENGTH'
          ,'county_number:invalid_nums:ALLOW'
          ,'county_name:invalid_county_name:ALLOW','county_name:invalid_county_name:WORDS'
          ,'gender:invalid_gender_code:ENUM'
          ,'age:invalid_nums:ALLOW'
          ,'birth_date:invalid_nums:ALLOW'
          ,'telephone:invalid_nums:ALLOW'
          ,'college_class:invalid_college_class:ENUM'
          ,'college_major:invalid_major:ALLOW'
          ,'college_code:invalid_college_code:ENUM'
          ,'college_type:invalid_college_type:ENUM'
          ,'head_of_household_gender:invalid_gender_code:ENUM'
          ,'income_level:invalid_income_lvl_code:ENUM'
          ,'file_type:invalid_file_type:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,input_Fields.InvalidMessage_name(1),input_Fields.InvalidMessage_name(2)
          ,input_Fields.InvalidMessage_first_name(1),input_Fields.InvalidMessage_first_name(2)
          ,input_Fields.InvalidMessage_last_name(1),input_Fields.InvalidMessage_last_name(2)
          ,input_Fields.InvalidMessage_address_1(1)
          ,input_Fields.InvalidMessage_address_2(1)
          ,input_Fields.InvalidMessage_city(1),input_Fields.InvalidMessage_city(2)
          ,input_Fields.InvalidMessage_z5(1),input_Fields.InvalidMessage_z5(2)
          ,input_Fields.InvalidMessage_county_number(1)
          ,input_Fields.InvalidMessage_county_name(1),input_Fields.InvalidMessage_county_name(2)
          ,input_Fields.InvalidMessage_gender(1)
          ,input_Fields.InvalidMessage_age(1)
          ,input_Fields.InvalidMessage_birth_date(1)
          ,input_Fields.InvalidMessage_telephone(1)
          ,input_Fields.InvalidMessage_college_class(1)
          ,input_Fields.InvalidMessage_college_major(1)
          ,input_Fields.InvalidMessage_college_code(1)
          ,input_Fields.InvalidMessage_college_type(1)
          ,input_Fields.InvalidMessage_head_of_household_gender(1)
          ,input_Fields.InvalidMessage_income_level(1)
          ,input_Fields.InvalidMessage_file_type(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.name_ALLOW_ErrorCount,le.name_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.address_1_ALLOW_ErrorCount
          ,le.address_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.z5_ALLOW_ErrorCount,le.z5_LENGTH_ErrorCount
          ,le.county_number_ALLOW_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.birth_date_ALLOW_ErrorCount
          ,le.telephone_ALLOW_ErrorCount
          ,le.college_class_ENUM_ErrorCount
          ,le.college_major_ALLOW_ErrorCount
          ,le.college_code_ENUM_ErrorCount
          ,le.college_type_ENUM_ErrorCount
          ,le.head_of_household_gender_ENUM_ErrorCount
          ,le.income_level_ENUM_ErrorCount
          ,le.file_type_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.name_ALLOW_ErrorCount,le.name_LENGTH_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.address_1_ALLOW_ErrorCount
          ,le.address_2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.z5_ALLOW_ErrorCount,le.z5_LENGTH_ErrorCount
          ,le.county_number_ALLOW_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.birth_date_ALLOW_ErrorCount
          ,le.telephone_ALLOW_ErrorCount
          ,le.college_class_ENUM_ErrorCount
          ,le.college_major_ALLOW_ErrorCount
          ,le.college_code_ENUM_ErrorCount
          ,le.college_type_ENUM_ErrorCount
          ,le.head_of_household_gender_ENUM_ErrorCount
          ,le.income_level_ENUM_ErrorCount
          ,le.file_type_ENUM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := input_hygiene(PROJECT(h, input_Layout_American_Student_List));
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
          ,'name:' + getFieldTypeText(h.name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_1:' + getFieldTypeText(h.address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_2:' + getFieldTypeText(h.address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z5:' + getFieldTypeText(h.z5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_4:' + getFieldTypeText(h.zip_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crrt_code:' + getFieldTypeText(h.crrt_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delivery_point_barcode:' + getFieldTypeText(h.delivery_point_barcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4_check_digit:' + getFieldTypeText(h.zip4_check_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type:' + getFieldTypeText(h.address_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_number:' + getFieldTypeText(h.county_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age:' + getFieldTypeText(h.age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'birth_date:' + getFieldTypeText(h.birth_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone:' + getFieldTypeText(h.telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'class:' + getFieldTypeText(h.class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_class:' + getFieldTypeText(h.college_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_name:' + getFieldTypeText(h.college_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_major:' + getFieldTypeText(h.college_major) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_code:' + getFieldTypeText(h.college_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'college_type:' + getFieldTypeText(h.college_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_of_household_first_name:' + getFieldTypeText(h.head_of_household_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'head_of_household_gender:' + getFieldTypeText(h.head_of_household_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'income_level:' + getFieldTypeText(h.income_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_type:' + getFieldTypeText(h.file_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_last_name_cnt
          ,le.populated_address_1_cnt
          ,le.populated_address_2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_z5_cnt
          ,le.populated_zip_4_cnt
          ,le.populated_crrt_code_cnt
          ,le.populated_delivery_point_barcode_cnt
          ,le.populated_zip4_check_digit_cnt
          ,le.populated_address_type_cnt
          ,le.populated_county_number_cnt
          ,le.populated_county_name_cnt
          ,le.populated_gender_cnt
          ,le.populated_age_cnt
          ,le.populated_birth_date_cnt
          ,le.populated_telephone_cnt
          ,le.populated_class_cnt
          ,le.populated_college_class_cnt
          ,le.populated_college_name_cnt
          ,le.populated_college_major_cnt
          ,le.populated_college_code_cnt
          ,le.populated_college_type_cnt
          ,le.populated_head_of_household_first_name_cnt
          ,le.populated_head_of_household_gender_cnt
          ,le.populated_income_level_cnt
          ,le.populated_file_type_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_address_1_pcnt
          ,le.populated_address_2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_z5_pcnt
          ,le.populated_zip_4_pcnt
          ,le.populated_crrt_code_pcnt
          ,le.populated_delivery_point_barcode_pcnt
          ,le.populated_zip4_check_digit_pcnt
          ,le.populated_address_type_pcnt
          ,le.populated_county_number_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_age_pcnt
          ,le.populated_birth_date_pcnt
          ,le.populated_telephone_pcnt
          ,le.populated_class_pcnt
          ,le.populated_college_class_pcnt
          ,le.populated_college_name_pcnt
          ,le.populated_college_major_pcnt
          ,le.populated_college_code_pcnt
          ,le.populated_college_type_pcnt
          ,le.populated_head_of_household_first_name_pcnt
          ,le.populated_head_of_household_gender_pcnt
          ,le.populated_income_level_pcnt
          ,le.populated_file_type_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,29,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := input_Delta(prevDS, PROJECT(h, input_Layout_American_Student_List));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),29,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(input_Layout_American_Student_List) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_American_Student_List, input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
