IMPORT SALT38,STD;
EXPORT input_hygiene(dataset(input_layout_American_Student_List) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_address_1_cnt := COUNT(GROUP,h.address_1 <> (TYPEOF(h.address_1))'');
    populated_address_1_pcnt := AVE(GROUP,IF(h.address_1 = (TYPEOF(h.address_1))'',0,100));
    maxlength_address_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_1)));
    avelength_address_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_1)),h.address_1<>(typeof(h.address_1))'');
    populated_address_2_cnt := COUNT(GROUP,h.address_2 <> (TYPEOF(h.address_2))'');
    populated_address_2_pcnt := AVE(GROUP,IF(h.address_2 = (TYPEOF(h.address_2))'',0,100));
    maxlength_address_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_2)));
    avelength_address_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_2)),h.address_2<>(typeof(h.address_2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_z5_cnt := COUNT(GROUP,h.z5 <> (TYPEOF(h.z5))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_zip_4_cnt := COUNT(GROUP,h.zip_4 <> (TYPEOF(h.zip_4))'');
    populated_zip_4_pcnt := AVE(GROUP,IF(h.zip_4 = (TYPEOF(h.zip_4))'',0,100));
    maxlength_zip_4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_4)));
    avelength_zip_4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_4)),h.zip_4<>(typeof(h.zip_4))'');
    populated_crrt_code_cnt := COUNT(GROUP,h.crrt_code <> (TYPEOF(h.crrt_code))'');
    populated_crrt_code_pcnt := AVE(GROUP,IF(h.crrt_code = (TYPEOF(h.crrt_code))'',0,100));
    maxlength_crrt_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.crrt_code)));
    avelength_crrt_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.crrt_code)),h.crrt_code<>(typeof(h.crrt_code))'');
    populated_delivery_point_barcode_cnt := COUNT(GROUP,h.delivery_point_barcode <> (TYPEOF(h.delivery_point_barcode))'');
    populated_delivery_point_barcode_pcnt := AVE(GROUP,IF(h.delivery_point_barcode = (TYPEOF(h.delivery_point_barcode))'',0,100));
    maxlength_delivery_point_barcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.delivery_point_barcode)));
    avelength_delivery_point_barcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.delivery_point_barcode)),h.delivery_point_barcode<>(typeof(h.delivery_point_barcode))'');
    populated_zip4_check_digit_cnt := COUNT(GROUP,h.zip4_check_digit <> (TYPEOF(h.zip4_check_digit))'');
    populated_zip4_check_digit_pcnt := AVE(GROUP,IF(h.zip4_check_digit = (TYPEOF(h.zip4_check_digit))'',0,100));
    maxlength_zip4_check_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4_check_digit)));
    avelength_zip4_check_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4_check_digit)),h.zip4_check_digit<>(typeof(h.zip4_check_digit))'');
    populated_address_type_cnt := COUNT(GROUP,h.address_type <> (TYPEOF(h.address_type))'');
    populated_address_type_pcnt := AVE(GROUP,IF(h.address_type = (TYPEOF(h.address_type))'',0,100));
    maxlength_address_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_type)));
    avelength_address_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address_type)),h.address_type<>(typeof(h.address_type))'');
    populated_county_number_cnt := COUNT(GROUP,h.county_number <> (TYPEOF(h.county_number))'');
    populated_county_number_pcnt := AVE(GROUP,IF(h.county_number = (TYPEOF(h.county_number))'',0,100));
    maxlength_county_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_number)));
    avelength_county_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_number)),h.county_number<>(typeof(h.county_number))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_age_cnt := COUNT(GROUP,h.age <> (TYPEOF(h.age))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_birth_date_cnt := COUNT(GROUP,h.birth_date <> (TYPEOF(h.birth_date))'');
    populated_birth_date_pcnt := AVE(GROUP,IF(h.birth_date = (TYPEOF(h.birth_date))'',0,100));
    maxlength_birth_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.birth_date)));
    avelength_birth_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.birth_date)),h.birth_date<>(typeof(h.birth_date))'');
    populated_telephone_cnt := COUNT(GROUP,h.telephone <> (TYPEOF(h.telephone))'');
    populated_telephone_pcnt := AVE(GROUP,IF(h.telephone = (TYPEOF(h.telephone))'',0,100));
    maxlength_telephone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.telephone)));
    avelength_telephone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.telephone)),h.telephone<>(typeof(h.telephone))'');
    populated_class_cnt := COUNT(GROUP,h.class <> (TYPEOF(h.class))'');
    populated_class_pcnt := AVE(GROUP,IF(h.class = (TYPEOF(h.class))'',0,100));
    maxlength_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.class)));
    avelength_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.class)),h.class<>(typeof(h.class))'');
    populated_college_class_cnt := COUNT(GROUP,h.college_class <> (TYPEOF(h.college_class))'');
    populated_college_class_pcnt := AVE(GROUP,IF(h.college_class = (TYPEOF(h.college_class))'',0,100));
    maxlength_college_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_class)));
    avelength_college_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_class)),h.college_class<>(typeof(h.college_class))'');
    populated_college_name_cnt := COUNT(GROUP,h.college_name <> (TYPEOF(h.college_name))'');
    populated_college_name_pcnt := AVE(GROUP,IF(h.college_name = (TYPEOF(h.college_name))'',0,100));
    maxlength_college_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_name)));
    avelength_college_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_name)),h.college_name<>(typeof(h.college_name))'');
    populated_college_major_cnt := COUNT(GROUP,h.college_major <> (TYPEOF(h.college_major))'');
    populated_college_major_pcnt := AVE(GROUP,IF(h.college_major = (TYPEOF(h.college_major))'',0,100));
    maxlength_college_major := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_major)));
    avelength_college_major := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_major)),h.college_major<>(typeof(h.college_major))'');
    populated_college_code_cnt := COUNT(GROUP,h.college_code <> (TYPEOF(h.college_code))'');
    populated_college_code_pcnt := AVE(GROUP,IF(h.college_code = (TYPEOF(h.college_code))'',0,100));
    maxlength_college_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_code)));
    avelength_college_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_code)),h.college_code<>(typeof(h.college_code))'');
    populated_college_type_cnt := COUNT(GROUP,h.college_type <> (TYPEOF(h.college_type))'');
    populated_college_type_pcnt := AVE(GROUP,IF(h.college_type = (TYPEOF(h.college_type))'',0,100));
    maxlength_college_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_type)));
    avelength_college_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.college_type)),h.college_type<>(typeof(h.college_type))'');
    populated_head_of_household_first_name_cnt := COUNT(GROUP,h.head_of_household_first_name <> (TYPEOF(h.head_of_household_first_name))'');
    populated_head_of_household_first_name_pcnt := AVE(GROUP,IF(h.head_of_household_first_name = (TYPEOF(h.head_of_household_first_name))'',0,100));
    maxlength_head_of_household_first_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_of_household_first_name)));
    avelength_head_of_household_first_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_of_household_first_name)),h.head_of_household_first_name<>(typeof(h.head_of_household_first_name))'');
    populated_head_of_household_gender_cnt := COUNT(GROUP,h.head_of_household_gender <> (TYPEOF(h.head_of_household_gender))'');
    populated_head_of_household_gender_pcnt := AVE(GROUP,IF(h.head_of_household_gender = (TYPEOF(h.head_of_household_gender))'',0,100));
    maxlength_head_of_household_gender := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_of_household_gender)));
    avelength_head_of_household_gender := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.head_of_household_gender)),h.head_of_household_gender<>(typeof(h.head_of_household_gender))'');
    populated_income_level_cnt := COUNT(GROUP,h.income_level <> (TYPEOF(h.income_level))'');
    populated_income_level_pcnt := AVE(GROUP,IF(h.income_level = (TYPEOF(h.income_level))'',0,100));
    maxlength_income_level := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.income_level)));
    avelength_income_level := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.income_level)),h.income_level<>(typeof(h.income_level))'');
    populated_file_type_cnt := COUNT(GROUP,h.file_type <> (TYPEOF(h.file_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_address_1_pcnt *   0.00 / 100 + T.Populated_address_2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_zip_4_pcnt *   0.00 / 100 + T.Populated_crrt_code_pcnt *   0.00 / 100 + T.Populated_delivery_point_barcode_pcnt *   0.00 / 100 + T.Populated_zip4_check_digit_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_county_number_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_birth_date_pcnt *   0.00 / 100 + T.Populated_telephone_pcnt *   0.00 / 100 + T.Populated_class_pcnt *   0.00 / 100 + T.Populated_college_class_pcnt *   0.00 / 100 + T.Populated_college_name_pcnt *   0.00 / 100 + T.Populated_college_major_pcnt *   0.00 / 100 + T.Populated_college_code_pcnt *   0.00 / 100 + T.Populated_college_type_pcnt *   0.00 / 100 + T.Populated_head_of_household_first_name_pcnt *   0.00 / 100 + T.Populated_head_of_household_gender_pcnt *   0.00 / 100 + T.Populated_income_level_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'name','first_name','last_name','address_1','address_2','city','state','z5','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type','county_number','county_name','gender','age','birth_date','telephone','class','college_class','college_name','college_major','college_code','college_type','head_of_household_first_name','head_of_household_gender','income_level','file_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_name_pcnt,le.populated_first_name_pcnt,le.populated_last_name_pcnt,le.populated_address_1_pcnt,le.populated_address_2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_z5_pcnt,le.populated_zip_4_pcnt,le.populated_crrt_code_pcnt,le.populated_delivery_point_barcode_pcnt,le.populated_zip4_check_digit_pcnt,le.populated_address_type_pcnt,le.populated_county_number_pcnt,le.populated_county_name_pcnt,le.populated_gender_pcnt,le.populated_age_pcnt,le.populated_birth_date_pcnt,le.populated_telephone_pcnt,le.populated_class_pcnt,le.populated_college_class_pcnt,le.populated_college_name_pcnt,le.populated_college_major_pcnt,le.populated_college_code_pcnt,le.populated_college_type_pcnt,le.populated_head_of_household_first_name_pcnt,le.populated_head_of_household_gender_pcnt,le.populated_income_level_pcnt,le.populated_file_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_name,le.maxlength_first_name,le.maxlength_last_name,le.maxlength_address_1,le.maxlength_address_2,le.maxlength_city,le.maxlength_state,le.maxlength_z5,le.maxlength_zip_4,le.maxlength_crrt_code,le.maxlength_delivery_point_barcode,le.maxlength_zip4_check_digit,le.maxlength_address_type,le.maxlength_county_number,le.maxlength_county_name,le.maxlength_gender,le.maxlength_age,le.maxlength_birth_date,le.maxlength_telephone,le.maxlength_class,le.maxlength_college_class,le.maxlength_college_name,le.maxlength_college_major,le.maxlength_college_code,le.maxlength_college_type,le.maxlength_head_of_household_first_name,le.maxlength_head_of_household_gender,le.maxlength_income_level,le.maxlength_file_type);
  SELF.avelength := CHOOSE(C,le.avelength_name,le.avelength_first_name,le.avelength_last_name,le.avelength_address_1,le.avelength_address_2,le.avelength_city,le.avelength_state,le.avelength_z5,le.avelength_zip_4,le.avelength_crrt_code,le.avelength_delivery_point_barcode,le.avelength_zip4_check_digit,le.avelength_address_type,le.avelength_county_number,le.avelength_county_name,le.avelength_gender,le.avelength_age,le.avelength_birth_date,le.avelength_telephone,le.avelength_class,le.avelength_college_class,le.avelength_college_name,le.avelength_college_major,le.avelength_college_code,le.avelength_college_type,le.avelength_head_of_household_first_name,le.avelength_head_of_household_gender,le.avelength_income_level,le.avelength_file_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 29, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.name),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.address_1),TRIM((SALT38.StrType)le.address_2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.z5),TRIM((SALT38.StrType)le.zip_4),TRIM((SALT38.StrType)le.crrt_code),TRIM((SALT38.StrType)le.delivery_point_barcode),TRIM((SALT38.StrType)le.zip4_check_digit),TRIM((SALT38.StrType)le.address_type),TRIM((SALT38.StrType)le.county_number),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.gender),TRIM((SALT38.StrType)le.age),TRIM((SALT38.StrType)le.birth_date),TRIM((SALT38.StrType)le.telephone),TRIM((SALT38.StrType)le.class),TRIM((SALT38.StrType)le.college_class),TRIM((SALT38.StrType)le.college_name),TRIM((SALT38.StrType)le.college_major),TRIM((SALT38.StrType)le.college_code),TRIM((SALT38.StrType)le.college_type),TRIM((SALT38.StrType)le.head_of_household_first_name),TRIM((SALT38.StrType)le.head_of_household_gender),TRIM((SALT38.StrType)le.income_level),TRIM((SALT38.StrType)le.file_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,29,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 29);
  SELF.FldNo2 := 1 + (C % 29);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.name),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.address_1),TRIM((SALT38.StrType)le.address_2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.z5),TRIM((SALT38.StrType)le.zip_4),TRIM((SALT38.StrType)le.crrt_code),TRIM((SALT38.StrType)le.delivery_point_barcode),TRIM((SALT38.StrType)le.zip4_check_digit),TRIM((SALT38.StrType)le.address_type),TRIM((SALT38.StrType)le.county_number),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.gender),TRIM((SALT38.StrType)le.age),TRIM((SALT38.StrType)le.birth_date),TRIM((SALT38.StrType)le.telephone),TRIM((SALT38.StrType)le.class),TRIM((SALT38.StrType)le.college_class),TRIM((SALT38.StrType)le.college_name),TRIM((SALT38.StrType)le.college_major),TRIM((SALT38.StrType)le.college_code),TRIM((SALT38.StrType)le.college_type),TRIM((SALT38.StrType)le.head_of_household_first_name),TRIM((SALT38.StrType)le.head_of_household_gender),TRIM((SALT38.StrType)le.income_level),TRIM((SALT38.StrType)le.file_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.name),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.address_1),TRIM((SALT38.StrType)le.address_2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.z5),TRIM((SALT38.StrType)le.zip_4),TRIM((SALT38.StrType)le.crrt_code),TRIM((SALT38.StrType)le.delivery_point_barcode),TRIM((SALT38.StrType)le.zip4_check_digit),TRIM((SALT38.StrType)le.address_type),TRIM((SALT38.StrType)le.county_number),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.gender),TRIM((SALT38.StrType)le.age),TRIM((SALT38.StrType)le.birth_date),TRIM((SALT38.StrType)le.telephone),TRIM((SALT38.StrType)le.class),TRIM((SALT38.StrType)le.college_class),TRIM((SALT38.StrType)le.college_name),TRIM((SALT38.StrType)le.college_major),TRIM((SALT38.StrType)le.college_code),TRIM((SALT38.StrType)le.college_type),TRIM((SALT38.StrType)le.head_of_household_first_name),TRIM((SALT38.StrType)le.head_of_household_gender),TRIM((SALT38.StrType)le.income_level),TRIM((SALT38.StrType)le.file_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),29*29,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'name'}
      ,{2,'first_name'}
      ,{3,'last_name'}
      ,{4,'address_1'}
      ,{5,'address_2'}
      ,{6,'city'}
      ,{7,'state'}
      ,{8,'z5'}
      ,{9,'zip_4'}
      ,{10,'crrt_code'}
      ,{11,'delivery_point_barcode'}
      ,{12,'zip4_check_digit'}
      ,{13,'address_type'}
      ,{14,'county_number'}
      ,{15,'county_name'}
      ,{16,'gender'}
      ,{17,'age'}
      ,{18,'birth_date'}
      ,{19,'telephone'}
      ,{20,'class'}
      ,{21,'college_class'}
      ,{22,'college_name'}
      ,{23,'college_major'}
      ,{24,'college_code'}
      ,{25,'college_type'}
      ,{26,'head_of_household_first_name'}
      ,{27,'head_of_household_gender'}
      ,{28,'income_level'}
      ,{29,'file_type'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    input_Fields.InValid_name((SALT38.StrType)le.name),
    input_Fields.InValid_first_name((SALT38.StrType)le.first_name),
    input_Fields.InValid_last_name((SALT38.StrType)le.last_name),
    input_Fields.InValid_address_1((SALT38.StrType)le.address_1),
    input_Fields.InValid_address_2((SALT38.StrType)le.address_2),
    input_Fields.InValid_city((SALT38.StrType)le.city),
    input_Fields.InValid_state((SALT38.StrType)le.state),
    input_Fields.InValid_z5((SALT38.StrType)le.z5),
    input_Fields.InValid_zip_4((SALT38.StrType)le.zip_4),
    input_Fields.InValid_crrt_code((SALT38.StrType)le.crrt_code),
    input_Fields.InValid_delivery_point_barcode((SALT38.StrType)le.delivery_point_barcode),
    input_Fields.InValid_zip4_check_digit((SALT38.StrType)le.zip4_check_digit),
    input_Fields.InValid_address_type((SALT38.StrType)le.address_type),
    input_Fields.InValid_county_number((SALT38.StrType)le.county_number),
    input_Fields.InValid_county_name((SALT38.StrType)le.county_name),
    input_Fields.InValid_gender((SALT38.StrType)le.gender),
    input_Fields.InValid_age((SALT38.StrType)le.age),
    input_Fields.InValid_birth_date((SALT38.StrType)le.birth_date),
    input_Fields.InValid_telephone((SALT38.StrType)le.telephone),
    input_Fields.InValid_class((SALT38.StrType)le.class),
    input_Fields.InValid_college_class((SALT38.StrType)le.college_class),
    input_Fields.InValid_college_name((SALT38.StrType)le.college_name),
    input_Fields.InValid_college_major((SALT38.StrType)le.college_major),
    input_Fields.InValid_college_code((SALT38.StrType)le.college_code),
    input_Fields.InValid_college_type((SALT38.StrType)le.college_type),
    input_Fields.InValid_head_of_household_first_name((SALT38.StrType)le.head_of_household_first_name),
    input_Fields.InValid_head_of_household_gender((SALT38.StrType)le.head_of_household_gender),
    input_Fields.InValid_income_level((SALT38.StrType)le.income_level),
    input_Fields.InValid_file_type((SALT38.StrType)le.file_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,29,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alpha','invalid_alpha','invalid_alpha','invalid_address','invalid_address','invalid_alpha','Unknown','invalid_zip','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_nums','invalid_county_name','invalid_gender_code','invalid_nums','invalid_nums','invalid_nums','Unknown','invalid_college_class','Unknown','invalid_major','invalid_college_code','invalid_college_type','Unknown','invalid_gender_code','invalid_income_lvl_code','invalid_file_type');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,input_Fields.InValidMessage_name(TotalErrors.ErrorNum),input_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),input_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),input_Fields.InValidMessage_address_1(TotalErrors.ErrorNum),input_Fields.InValidMessage_address_2(TotalErrors.ErrorNum),input_Fields.InValidMessage_city(TotalErrors.ErrorNum),input_Fields.InValidMessage_state(TotalErrors.ErrorNum),input_Fields.InValidMessage_z5(TotalErrors.ErrorNum),input_Fields.InValidMessage_zip_4(TotalErrors.ErrorNum),input_Fields.InValidMessage_crrt_code(TotalErrors.ErrorNum),input_Fields.InValidMessage_delivery_point_barcode(TotalErrors.ErrorNum),input_Fields.InValidMessage_zip4_check_digit(TotalErrors.ErrorNum),input_Fields.InValidMessage_address_type(TotalErrors.ErrorNum),input_Fields.InValidMessage_county_number(TotalErrors.ErrorNum),input_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),input_Fields.InValidMessage_gender(TotalErrors.ErrorNum),input_Fields.InValidMessage_age(TotalErrors.ErrorNum),input_Fields.InValidMessage_birth_date(TotalErrors.ErrorNum),input_Fields.InValidMessage_telephone(TotalErrors.ErrorNum),input_Fields.InValidMessage_class(TotalErrors.ErrorNum),input_Fields.InValidMessage_college_class(TotalErrors.ErrorNum),input_Fields.InValidMessage_college_name(TotalErrors.ErrorNum),input_Fields.InValidMessage_college_major(TotalErrors.ErrorNum),input_Fields.InValidMessage_college_code(TotalErrors.ErrorNum),input_Fields.InValidMessage_college_type(TotalErrors.ErrorNum),input_Fields.InValidMessage_head_of_household_first_name(TotalErrors.ErrorNum),input_Fields.InValidMessage_head_of_household_gender(TotalErrors.ErrorNum),input_Fields.InValidMessage_income_level(TotalErrors.ErrorNum),input_Fields.InValidMessage_file_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_American_Student_List, input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
