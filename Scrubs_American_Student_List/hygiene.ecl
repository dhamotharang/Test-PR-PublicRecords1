IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_American_Student_List) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_key_cnt := COUNT(GROUP,h.key <> (TYPEOF(h.key))'');
    populated_key_pcnt := AVE(GROUP,IF(h.key = (TYPEOF(h.key))'',0,100));
    maxlength_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.key)));
    avelength_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.key)),h.key<>(typeof(h.key))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_cnt := COUNT(GROUP,h.date_vendor_first_reported <> (TYPEOF(h.date_vendor_first_reported))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_cnt := COUNT(GROUP,h.date_vendor_last_reported <> (TYPEOF(h.date_vendor_last_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_historical_flag_cnt := COUNT(GROUP,h.historical_flag <> (TYPEOF(h.historical_flag))'');
    populated_historical_flag_pcnt := AVE(GROUP,IF(h.historical_flag = (TYPEOF(h.historical_flag))'',0,100));
    maxlength_historical_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.historical_flag)));
    avelength_historical_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.historical_flag)),h.historical_flag<>(typeof(h.historical_flag))'');
    populated_full_name_cnt := COUNT(GROUP,h.full_name <> (TYPEOF(h.full_name))'');
    populated_full_name_pcnt := AVE(GROUP,IF(h.full_name = (TYPEOF(h.full_name))'',0,100));
    maxlength_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)));
    avelength_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_name)),h.full_name<>(typeof(h.full_name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_address_1_cnt := COUNT(GROUP,h.address_1 <> (TYPEOF(h.address_1))'');
    populated_address_1_pcnt := AVE(GROUP,IF(h.address_1 = (TYPEOF(h.address_1))'',0,100));
    maxlength_address_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_1)));
    avelength_address_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_1)),h.address_1<>(typeof(h.address_1))'');
    populated_address_2_cnt := COUNT(GROUP,h.address_2 <> (TYPEOF(h.address_2))'');
    populated_address_2_pcnt := AVE(GROUP,IF(h.address_2 = (TYPEOF(h.address_2))'',0,100));
    maxlength_address_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_2)));
    avelength_address_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_2)),h.address_2<>(typeof(h.address_2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip_4_cnt := COUNT(GROUP,h.zip_4 <> (TYPEOF(h.zip_4))'');
    populated_zip_4_pcnt := AVE(GROUP,IF(h.zip_4 = (TYPEOF(h.zip_4))'',0,100));
    maxlength_zip_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_4)));
    avelength_zip_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_4)),h.zip_4<>(typeof(h.zip_4))'');
    populated_crrt_code_cnt := COUNT(GROUP,h.crrt_code <> (TYPEOF(h.crrt_code))'');
    populated_crrt_code_pcnt := AVE(GROUP,IF(h.crrt_code = (TYPEOF(h.crrt_code))'',0,100));
    maxlength_crrt_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crrt_code)));
    avelength_crrt_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crrt_code)),h.crrt_code<>(typeof(h.crrt_code))'');
    populated_delivery_point_barcode_cnt := COUNT(GROUP,h.delivery_point_barcode <> (TYPEOF(h.delivery_point_barcode))'');
    populated_delivery_point_barcode_pcnt := AVE(GROUP,IF(h.delivery_point_barcode = (TYPEOF(h.delivery_point_barcode))'',0,100));
    maxlength_delivery_point_barcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.delivery_point_barcode)));
    avelength_delivery_point_barcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.delivery_point_barcode)),h.delivery_point_barcode<>(typeof(h.delivery_point_barcode))'');
    populated_zip4_check_digit_cnt := COUNT(GROUP,h.zip4_check_digit <> (TYPEOF(h.zip4_check_digit))'');
    populated_zip4_check_digit_pcnt := AVE(GROUP,IF(h.zip4_check_digit = (TYPEOF(h.zip4_check_digit))'',0,100));
    maxlength_zip4_check_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4_check_digit)));
    avelength_zip4_check_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4_check_digit)),h.zip4_check_digit<>(typeof(h.zip4_check_digit))'');
    populated_address_type_code_cnt := COUNT(GROUP,h.address_type_code <> (TYPEOF(h.address_type_code))'');
    populated_address_type_code_pcnt := AVE(GROUP,IF(h.address_type_code = (TYPEOF(h.address_type_code))'',0,100));
    maxlength_address_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type_code)));
    avelength_address_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type_code)),h.address_type_code<>(typeof(h.address_type_code))'');
    populated_address_type_cnt := COUNT(GROUP,h.address_type <> (TYPEOF(h.address_type))'');
    populated_address_type_pcnt := AVE(GROUP,IF(h.address_type = (TYPEOF(h.address_type))'',0,100));
    maxlength_address_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type)));
    avelength_address_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type)),h.address_type<>(typeof(h.address_type))'');
    populated_county_number_cnt := COUNT(GROUP,h.county_number <> (TYPEOF(h.county_number))'');
    populated_county_number_pcnt := AVE(GROUP,IF(h.county_number = (TYPEOF(h.county_number))'',0,100));
    maxlength_county_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_number)));
    avelength_county_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_number)),h.county_number<>(typeof(h.county_number))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_gender_code_cnt := COUNT(GROUP,h.gender_code <> (TYPEOF(h.gender_code))'');
    populated_gender_code_pcnt := AVE(GROUP,IF(h.gender_code = (TYPEOF(h.gender_code))'',0,100));
    maxlength_gender_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender_code)));
    avelength_gender_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender_code)),h.gender_code<>(typeof(h.gender_code))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_age_cnt := COUNT(GROUP,h.age <> (TYPEOF(h.age))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_birth_date_cnt := COUNT(GROUP,h.birth_date <> (TYPEOF(h.birth_date))'');
    populated_birth_date_pcnt := AVE(GROUP,IF(h.birth_date = (TYPEOF(h.birth_date))'',0,100));
    maxlength_birth_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.birth_date)));
    avelength_birth_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.birth_date)),h.birth_date<>(typeof(h.birth_date))'');
    populated_dob_formatted_cnt := COUNT(GROUP,h.dob_formatted <> (TYPEOF(h.dob_formatted))'');
    populated_dob_formatted_pcnt := AVE(GROUP,IF(h.dob_formatted = (TYPEOF(h.dob_formatted))'',0,100));
    maxlength_dob_formatted := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_formatted)));
    avelength_dob_formatted := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_formatted)),h.dob_formatted<>(typeof(h.dob_formatted))'');
    populated_telephone_cnt := COUNT(GROUP,h.telephone <> (TYPEOF(h.telephone))'');
    populated_telephone_pcnt := AVE(GROUP,IF(h.telephone = (TYPEOF(h.telephone))'',0,100));
    maxlength_telephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)));
    avelength_telephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)),h.telephone<>(typeof(h.telephone))'');
    populated_class_cnt := COUNT(GROUP,h.class <> (TYPEOF(h.class))'');
    populated_class_pcnt := AVE(GROUP,IF(h.class = (TYPEOF(h.class))'',0,100));
    maxlength_class := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.class)));
    avelength_class := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.class)),h.class<>(typeof(h.class))'');
    populated_college_class_cnt := COUNT(GROUP,h.college_class <> (TYPEOF(h.college_class))'');
    populated_college_class_pcnt := AVE(GROUP,IF(h.college_class = (TYPEOF(h.college_class))'',0,100));
    maxlength_college_class := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_class)));
    avelength_college_class := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_class)),h.college_class<>(typeof(h.college_class))'');
    populated_college_name_cnt := COUNT(GROUP,h.college_name <> (TYPEOF(h.college_name))'');
    populated_college_name_pcnt := AVE(GROUP,IF(h.college_name = (TYPEOF(h.college_name))'',0,100));
    maxlength_college_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_name)));
    avelength_college_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_name)),h.college_name<>(typeof(h.college_name))'');
    populated_ln_college_name_cnt := COUNT(GROUP,h.ln_college_name <> (TYPEOF(h.ln_college_name))'');
    populated_ln_college_name_pcnt := AVE(GROUP,IF(h.ln_college_name = (TYPEOF(h.ln_college_name))'',0,100));
    maxlength_ln_college_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_college_name)));
    avelength_ln_college_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_college_name)),h.ln_college_name<>(typeof(h.ln_college_name))'');
    populated_college_major_cnt := COUNT(GROUP,h.college_major <> (TYPEOF(h.college_major))'');
    populated_college_major_pcnt := AVE(GROUP,IF(h.college_major = (TYPEOF(h.college_major))'',0,100));
    maxlength_college_major := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_major)));
    avelength_college_major := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_major)),h.college_major<>(typeof(h.college_major))'');
    populated_new_college_major_cnt := COUNT(GROUP,h.new_college_major <> (TYPEOF(h.new_college_major))'');
    populated_new_college_major_pcnt := AVE(GROUP,IF(h.new_college_major = (TYPEOF(h.new_college_major))'',0,100));
    maxlength_new_college_major := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_college_major)));
    avelength_new_college_major := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_college_major)),h.new_college_major<>(typeof(h.new_college_major))'');
    populated_college_code_cnt := COUNT(GROUP,h.college_code <> (TYPEOF(h.college_code))'');
    populated_college_code_pcnt := AVE(GROUP,IF(h.college_code = (TYPEOF(h.college_code))'',0,100));
    maxlength_college_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_code)));
    avelength_college_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_code)),h.college_code<>(typeof(h.college_code))'');
    populated_college_code_exploded_cnt := COUNT(GROUP,h.college_code_exploded <> (TYPEOF(h.college_code_exploded))'');
    populated_college_code_exploded_pcnt := AVE(GROUP,IF(h.college_code_exploded = (TYPEOF(h.college_code_exploded))'',0,100));
    maxlength_college_code_exploded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_code_exploded)));
    avelength_college_code_exploded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_code_exploded)),h.college_code_exploded<>(typeof(h.college_code_exploded))'');
    populated_college_type_cnt := COUNT(GROUP,h.college_type <> (TYPEOF(h.college_type))'');
    populated_college_type_pcnt := AVE(GROUP,IF(h.college_type = (TYPEOF(h.college_type))'',0,100));
    maxlength_college_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_type)));
    avelength_college_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_type)),h.college_type<>(typeof(h.college_type))'');
    populated_college_type_exploded_cnt := COUNT(GROUP,h.college_type_exploded <> (TYPEOF(h.college_type_exploded))'');
    populated_college_type_exploded_pcnt := AVE(GROUP,IF(h.college_type_exploded = (TYPEOF(h.college_type_exploded))'',0,100));
    maxlength_college_type_exploded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_type_exploded)));
    avelength_college_type_exploded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college_type_exploded)),h.college_type_exploded<>(typeof(h.college_type_exploded))'');
    populated_head_of_household_first_name_cnt := COUNT(GROUP,h.head_of_household_first_name <> (TYPEOF(h.head_of_household_first_name))'');
    populated_head_of_household_first_name_pcnt := AVE(GROUP,IF(h.head_of_household_first_name = (TYPEOF(h.head_of_household_first_name))'',0,100));
    maxlength_head_of_household_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.head_of_household_first_name)));
    avelength_head_of_household_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.head_of_household_first_name)),h.head_of_household_first_name<>(typeof(h.head_of_household_first_name))'');
    populated_head_of_household_gender_code_cnt := COUNT(GROUP,h.head_of_household_gender_code <> (TYPEOF(h.head_of_household_gender_code))'');
    populated_head_of_household_gender_code_pcnt := AVE(GROUP,IF(h.head_of_household_gender_code = (TYPEOF(h.head_of_household_gender_code))'',0,100));
    maxlength_head_of_household_gender_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.head_of_household_gender_code)));
    avelength_head_of_household_gender_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.head_of_household_gender_code)),h.head_of_household_gender_code<>(typeof(h.head_of_household_gender_code))'');
    populated_head_of_household_gender_cnt := COUNT(GROUP,h.head_of_household_gender <> (TYPEOF(h.head_of_household_gender))'');
    populated_head_of_household_gender_pcnt := AVE(GROUP,IF(h.head_of_household_gender = (TYPEOF(h.head_of_household_gender))'',0,100));
    maxlength_head_of_household_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.head_of_household_gender)));
    avelength_head_of_household_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.head_of_household_gender)),h.head_of_household_gender<>(typeof(h.head_of_household_gender))'');
    populated_income_level_code_cnt := COUNT(GROUP,h.income_level_code <> (TYPEOF(h.income_level_code))'');
    populated_income_level_code_pcnt := AVE(GROUP,IF(h.income_level_code = (TYPEOF(h.income_level_code))'',0,100));
    maxlength_income_level_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_level_code)));
    avelength_income_level_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_level_code)),h.income_level_code<>(typeof(h.income_level_code))'');
    populated_income_level_cnt := COUNT(GROUP,h.income_level <> (TYPEOF(h.income_level))'');
    populated_income_level_pcnt := AVE(GROUP,IF(h.income_level = (TYPEOF(h.income_level))'',0,100));
    maxlength_income_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_level)));
    avelength_income_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_level)),h.income_level<>(typeof(h.income_level))'');
    populated_new_income_level_code_cnt := COUNT(GROUP,h.new_income_level_code <> (TYPEOF(h.new_income_level_code))'');
    populated_new_income_level_code_pcnt := AVE(GROUP,IF(h.new_income_level_code = (TYPEOF(h.new_income_level_code))'',0,100));
    maxlength_new_income_level_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_income_level_code)));
    avelength_new_income_level_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_income_level_code)),h.new_income_level_code<>(typeof(h.new_income_level_code))'');
    populated_new_income_level_cnt := COUNT(GROUP,h.new_income_level <> (TYPEOF(h.new_income_level))'');
    populated_new_income_level_pcnt := AVE(GROUP,IF(h.new_income_level = (TYPEOF(h.new_income_level))'',0,100));
    maxlength_new_income_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_income_level)));
    avelength_new_income_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_income_level)),h.new_income_level<>(typeof(h.new_income_level))'');
    populated_file_type_cnt := COUNT(GROUP,h.file_type <> (TYPEOF(h.file_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
    populated_tier_cnt := COUNT(GROUP,h.tier <> (TYPEOF(h.tier))'');
    populated_tier_pcnt := AVE(GROUP,IF(h.tier = (TYPEOF(h.tier))'',0,100));
    maxlength_tier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier)));
    avelength_tier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier)),h.tier<>(typeof(h.tier))'');
    populated_school_size_code_cnt := COUNT(GROUP,h.school_size_code <> (TYPEOF(h.school_size_code))'');
    populated_school_size_code_pcnt := AVE(GROUP,IF(h.school_size_code = (TYPEOF(h.school_size_code))'',0,100));
    maxlength_school_size_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_size_code)));
    avelength_school_size_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_size_code)),h.school_size_code<>(typeof(h.school_size_code))'');
    populated_competitive_code_cnt := COUNT(GROUP,h.competitive_code <> (TYPEOF(h.competitive_code))'');
    populated_competitive_code_pcnt := AVE(GROUP,IF(h.competitive_code = (TYPEOF(h.competitive_code))'',0,100));
    maxlength_competitive_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.competitive_code)));
    avelength_competitive_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.competitive_code)),h.competitive_code<>(typeof(h.competitive_code))'');
    populated_tuition_code_cnt := COUNT(GROUP,h.tuition_code <> (TYPEOF(h.tuition_code))'');
    populated_tuition_code_pcnt := AVE(GROUP,IF(h.tuition_code = (TYPEOF(h.tuition_code))'',0,100));
    maxlength_tuition_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tuition_code)));
    avelength_tuition_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tuition_code)),h.tuition_code<>(typeof(h.tuition_code))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_z5_cnt := COUNT(GROUP,h.z5 <> (TYPEOF(h.z5))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_tier2_cnt := COUNT(GROUP,h.tier2 <> (TYPEOF(h.tier2))'');
    populated_tier2_pcnt := AVE(GROUP,IF(h.tier2 = (TYPEOF(h.tier2))'',0,100));
    maxlength_tier2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier2)));
    avelength_tier2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier2)),h.tier2<>(typeof(h.tier2))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_key_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_historical_flag_pcnt *   0.00 / 100 + T.Populated_full_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_address_1_pcnt *   0.00 / 100 + T.Populated_address_2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip_4_pcnt *   0.00 / 100 + T.Populated_crrt_code_pcnt *   0.00 / 100 + T.Populated_delivery_point_barcode_pcnt *   0.00 / 100 + T.Populated_zip4_check_digit_pcnt *   0.00 / 100 + T.Populated_address_type_code_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_county_number_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_gender_code_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_birth_date_pcnt *   0.00 / 100 + T.Populated_dob_formatted_pcnt *   0.00 / 100 + T.Populated_telephone_pcnt *   0.00 / 100 + T.Populated_class_pcnt *   0.00 / 100 + T.Populated_college_class_pcnt *   0.00 / 100 + T.Populated_college_name_pcnt *   0.00 / 100 + T.Populated_ln_college_name_pcnt *   0.00 / 100 + T.Populated_college_major_pcnt *   0.00 / 100 + T.Populated_new_college_major_pcnt *   0.00 / 100 + T.Populated_college_code_pcnt *   0.00 / 100 + T.Populated_college_code_exploded_pcnt *   0.00 / 100 + T.Populated_college_type_pcnt *   0.00 / 100 + T.Populated_college_type_exploded_pcnt *   0.00 / 100 + T.Populated_head_of_household_first_name_pcnt *   0.00 / 100 + T.Populated_head_of_household_gender_code_pcnt *   0.00 / 100 + T.Populated_head_of_household_gender_pcnt *   0.00 / 100 + T.Populated_income_level_code_pcnt *   0.00 / 100 + T.Populated_income_level_pcnt *   0.00 / 100 + T.Populated_new_income_level_code_pcnt *   0.00 / 100 + T.Populated_new_income_level_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100 + T.Populated_tier_pcnt *   0.00 / 100 + T.Populated_school_size_code_pcnt *   0.00 / 100 + T.Populated_competitive_code_pcnt *   0.00 / 100 + T.Populated_tuition_code_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_tier2_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'key','ssn','did','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','historical_flag','full_name','first_name','last_name','address_1','address_2','city','state','zip','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type_code','address_type','county_number','county_name','gender_code','gender','age','birth_date','dob_formatted','telephone','class','college_class','college_name','ln_college_name','college_major','new_college_major','college_code','college_code_exploded','college_type','college_type_exploded','head_of_household_first_name','head_of_household_gender_code','head_of_household_gender','income_level_code','income_level','new_income_level_code','new_income_level','file_type','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','county','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','tier2','source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_key_pcnt,le.populated_ssn_pcnt,le.populated_did_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_historical_flag_pcnt,le.populated_full_name_pcnt,le.populated_first_name_pcnt,le.populated_last_name_pcnt,le.populated_address_1_pcnt,le.populated_address_2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip_4_pcnt,le.populated_crrt_code_pcnt,le.populated_delivery_point_barcode_pcnt,le.populated_zip4_check_digit_pcnt,le.populated_address_type_code_pcnt,le.populated_address_type_pcnt,le.populated_county_number_pcnt,le.populated_county_name_pcnt,le.populated_gender_code_pcnt,le.populated_gender_pcnt,le.populated_age_pcnt,le.populated_birth_date_pcnt,le.populated_dob_formatted_pcnt,le.populated_telephone_pcnt,le.populated_class_pcnt,le.populated_college_class_pcnt,le.populated_college_name_pcnt,le.populated_ln_college_name_pcnt,le.populated_college_major_pcnt,le.populated_new_college_major_pcnt,le.populated_college_code_pcnt,le.populated_college_code_exploded_pcnt,le.populated_college_type_pcnt,le.populated_college_type_exploded_pcnt,le.populated_head_of_household_first_name_pcnt,le.populated_head_of_household_gender_code_pcnt,le.populated_head_of_household_gender_pcnt,le.populated_income_level_code_pcnt,le.populated_income_level_pcnt,le.populated_new_income_level_code_pcnt,le.populated_new_income_level_pcnt,le.populated_file_type_pcnt,le.populated_tier_pcnt,le.populated_school_size_code_pcnt,le.populated_competitive_code_pcnt,le.populated_tuition_code_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_rawaid_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_z5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_ace_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_tier2_pcnt,le.populated_source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_key,le.maxlength_ssn,le.maxlength_did,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_historical_flag,le.maxlength_full_name,le.maxlength_first_name,le.maxlength_last_name,le.maxlength_address_1,le.maxlength_address_2,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_zip_4,le.maxlength_crrt_code,le.maxlength_delivery_point_barcode,le.maxlength_zip4_check_digit,le.maxlength_address_type_code,le.maxlength_address_type,le.maxlength_county_number,le.maxlength_county_name,le.maxlength_gender_code,le.maxlength_gender,le.maxlength_age,le.maxlength_birth_date,le.maxlength_dob_formatted,le.maxlength_telephone,le.maxlength_class,le.maxlength_college_class,le.maxlength_college_name,le.maxlength_ln_college_name,le.maxlength_college_major,le.maxlength_new_college_major,le.maxlength_college_code,le.maxlength_college_code_exploded,le.maxlength_college_type,le.maxlength_college_type_exploded,le.maxlength_head_of_household_first_name,le.maxlength_head_of_household_gender_code,le.maxlength_head_of_household_gender,le.maxlength_income_level_code,le.maxlength_income_level,le.maxlength_new_income_level_code,le.maxlength_new_income_level,le.maxlength_file_type,le.maxlength_tier,le.maxlength_school_size_code,le.maxlength_competitive_code,le.maxlength_tuition_code,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_rawaid,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_z5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_ace_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_tier2,le.maxlength_source);
  SELF.avelength := CHOOSE(C,le.avelength_key,le.avelength_ssn,le.avelength_did,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_historical_flag,le.avelength_full_name,le.avelength_first_name,le.avelength_last_name,le.avelength_address_1,le.avelength_address_2,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_zip_4,le.avelength_crrt_code,le.avelength_delivery_point_barcode,le.avelength_zip4_check_digit,le.avelength_address_type_code,le.avelength_address_type,le.avelength_county_number,le.avelength_county_name,le.avelength_gender_code,le.avelength_gender,le.avelength_age,le.avelength_birth_date,le.avelength_dob_formatted,le.avelength_telephone,le.avelength_class,le.avelength_college_class,le.avelength_college_name,le.avelength_ln_college_name,le.avelength_college_major,le.avelength_new_college_major,le.avelength_college_code,le.avelength_college_code_exploded,le.avelength_college_type,le.avelength_college_type_exploded,le.avelength_head_of_household_first_name,le.avelength_head_of_household_gender_code,le.avelength_head_of_household_gender,le.avelength_income_level_code,le.avelength_income_level,le.avelength_new_income_level_code,le.avelength_new_income_level,le.avelength_file_type,le.avelength_tier,le.avelength_school_size_code,le.avelength_competitive_code,le.avelength_tuition_code,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_rawaid,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_z5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_ace_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_tier2,le.avelength_source);
END;
EXPORT invSummary := NORMALIZE(summary0, 90, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.key <> 0,TRIM((SALT311.StrType)le.key), ''),TRIM((SALT311.StrType)le.ssn),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.historical_flag),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip_4),TRIM((SALT311.StrType)le.crrt_code),TRIM((SALT311.StrType)le.delivery_point_barcode),TRIM((SALT311.StrType)le.zip4_check_digit),TRIM((SALT311.StrType)le.address_type_code),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.county_number),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.gender_code),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.birth_date),TRIM((SALT311.StrType)le.dob_formatted),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.class),TRIM((SALT311.StrType)le.college_class),TRIM((SALT311.StrType)le.college_name),TRIM((SALT311.StrType)le.ln_college_name),TRIM((SALT311.StrType)le.college_major),TRIM((SALT311.StrType)le.new_college_major),TRIM((SALT311.StrType)le.college_code),TRIM((SALT311.StrType)le.college_code_exploded),TRIM((SALT311.StrType)le.college_type),TRIM((SALT311.StrType)le.college_type_exploded),TRIM((SALT311.StrType)le.head_of_household_first_name),TRIM((SALT311.StrType)le.head_of_household_gender_code),TRIM((SALT311.StrType)le.head_of_household_gender),TRIM((SALT311.StrType)le.income_level_code),TRIM((SALT311.StrType)le.income_level),TRIM((SALT311.StrType)le.new_income_level_code),TRIM((SALT311.StrType)le.new_income_level),TRIM((SALT311.StrType)le.file_type),TRIM((SALT311.StrType)le.tier),TRIM((SALT311.StrType)le.school_size_code),TRIM((SALT311.StrType)le.competitive_code),TRIM((SALT311.StrType)le.tuition_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.tier2),TRIM((SALT311.StrType)le.source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,90,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 90);
  SELF.FldNo2 := 1 + (C % 90);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.key <> 0,TRIM((SALT311.StrType)le.key), ''),TRIM((SALT311.StrType)le.ssn),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.historical_flag),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip_4),TRIM((SALT311.StrType)le.crrt_code),TRIM((SALT311.StrType)le.delivery_point_barcode),TRIM((SALT311.StrType)le.zip4_check_digit),TRIM((SALT311.StrType)le.address_type_code),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.county_number),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.gender_code),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.birth_date),TRIM((SALT311.StrType)le.dob_formatted),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.class),TRIM((SALT311.StrType)le.college_class),TRIM((SALT311.StrType)le.college_name),TRIM((SALT311.StrType)le.ln_college_name),TRIM((SALT311.StrType)le.college_major),TRIM((SALT311.StrType)le.new_college_major),TRIM((SALT311.StrType)le.college_code),TRIM((SALT311.StrType)le.college_code_exploded),TRIM((SALT311.StrType)le.college_type),TRIM((SALT311.StrType)le.college_type_exploded),TRIM((SALT311.StrType)le.head_of_household_first_name),TRIM((SALT311.StrType)le.head_of_household_gender_code),TRIM((SALT311.StrType)le.head_of_household_gender),TRIM((SALT311.StrType)le.income_level_code),TRIM((SALT311.StrType)le.income_level),TRIM((SALT311.StrType)le.new_income_level_code),TRIM((SALT311.StrType)le.new_income_level),TRIM((SALT311.StrType)le.file_type),TRIM((SALT311.StrType)le.tier),TRIM((SALT311.StrType)le.school_size_code),TRIM((SALT311.StrType)le.competitive_code),TRIM((SALT311.StrType)le.tuition_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.tier2),TRIM((SALT311.StrType)le.source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.key <> 0,TRIM((SALT311.StrType)le.key), ''),TRIM((SALT311.StrType)le.ssn),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.historical_flag),TRIM((SALT311.StrType)le.full_name),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip_4),TRIM((SALT311.StrType)le.crrt_code),TRIM((SALT311.StrType)le.delivery_point_barcode),TRIM((SALT311.StrType)le.zip4_check_digit),TRIM((SALT311.StrType)le.address_type_code),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.county_number),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.gender_code),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.age),TRIM((SALT311.StrType)le.birth_date),TRIM((SALT311.StrType)le.dob_formatted),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.class),TRIM((SALT311.StrType)le.college_class),TRIM((SALT311.StrType)le.college_name),TRIM((SALT311.StrType)le.ln_college_name),TRIM((SALT311.StrType)le.college_major),TRIM((SALT311.StrType)le.new_college_major),TRIM((SALT311.StrType)le.college_code),TRIM((SALT311.StrType)le.college_code_exploded),TRIM((SALT311.StrType)le.college_type),TRIM((SALT311.StrType)le.college_type_exploded),TRIM((SALT311.StrType)le.head_of_household_first_name),TRIM((SALT311.StrType)le.head_of_household_gender_code),TRIM((SALT311.StrType)le.head_of_household_gender),TRIM((SALT311.StrType)le.income_level_code),TRIM((SALT311.StrType)le.income_level),TRIM((SALT311.StrType)le.new_income_level_code),TRIM((SALT311.StrType)le.new_income_level),TRIM((SALT311.StrType)le.file_type),TRIM((SALT311.StrType)le.tier),TRIM((SALT311.StrType)le.school_size_code),TRIM((SALT311.StrType)le.competitive_code),TRIM((SALT311.StrType)le.tuition_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.tier2),TRIM((SALT311.StrType)le.source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),90*90,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'key'}
      ,{2,'ssn'}
      ,{3,'did'}
      ,{4,'process_date'}
      ,{5,'date_first_seen'}
      ,{6,'date_last_seen'}
      ,{7,'date_vendor_first_reported'}
      ,{8,'date_vendor_last_reported'}
      ,{9,'historical_flag'}
      ,{10,'full_name'}
      ,{11,'first_name'}
      ,{12,'last_name'}
      ,{13,'address_1'}
      ,{14,'address_2'}
      ,{15,'city'}
      ,{16,'state'}
      ,{17,'zip'}
      ,{18,'zip_4'}
      ,{19,'crrt_code'}
      ,{20,'delivery_point_barcode'}
      ,{21,'zip4_check_digit'}
      ,{22,'address_type_code'}
      ,{23,'address_type'}
      ,{24,'county_number'}
      ,{25,'county_name'}
      ,{26,'gender_code'}
      ,{27,'gender'}
      ,{28,'age'}
      ,{29,'birth_date'}
      ,{30,'dob_formatted'}
      ,{31,'telephone'}
      ,{32,'class'}
      ,{33,'college_class'}
      ,{34,'college_name'}
      ,{35,'ln_college_name'}
      ,{36,'college_major'}
      ,{37,'new_college_major'}
      ,{38,'college_code'}
      ,{39,'college_code_exploded'}
      ,{40,'college_type'}
      ,{41,'college_type_exploded'}
      ,{42,'head_of_household_first_name'}
      ,{43,'head_of_household_gender_code'}
      ,{44,'head_of_household_gender'}
      ,{45,'income_level_code'}
      ,{46,'income_level'}
      ,{47,'new_income_level_code'}
      ,{48,'new_income_level'}
      ,{49,'file_type'}
      ,{50,'tier'}
      ,{51,'school_size_code'}
      ,{52,'competitive_code'}
      ,{53,'tuition_code'}
      ,{54,'title'}
      ,{55,'fname'}
      ,{56,'mname'}
      ,{57,'lname'}
      ,{58,'name_suffix'}
      ,{59,'name_score'}
      ,{60,'rawaid'}
      ,{61,'prim_range'}
      ,{62,'predir'}
      ,{63,'prim_name'}
      ,{64,'addr_suffix'}
      ,{65,'postdir'}
      ,{66,'unit_desig'}
      ,{67,'sec_range'}
      ,{68,'p_city_name'}
      ,{69,'v_city_name'}
      ,{70,'st'}
      ,{71,'z5'}
      ,{72,'zip4'}
      ,{73,'cart'}
      ,{74,'cr_sort_sz'}
      ,{75,'lot'}
      ,{76,'lot_order'}
      ,{77,'dpbc'}
      ,{78,'chk_digit'}
      ,{79,'rec_type'}
      ,{80,'county'}
      ,{81,'ace_fips_st'}
      ,{82,'fips_county'}
      ,{83,'geo_lat'}
      ,{84,'geo_long'}
      ,{85,'msa'}
      ,{86,'geo_blk'}
      ,{87,'geo_match'}
      ,{88,'err_stat'}
      ,{89,'tier2'}
      ,{90,'source'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_key((SALT311.StrType)le.key),
    Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_historical_flag((SALT311.StrType)le.historical_flag),
    Fields.InValid_full_name((SALT311.StrType)le.full_name),
    Fields.InValid_first_name((SALT311.StrType)le.first_name),
    Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Fields.InValid_address_1((SALT311.StrType)le.address_1),
    Fields.InValid_address_2((SALT311.StrType)le.address_2),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip_4((SALT311.StrType)le.zip_4),
    Fields.InValid_crrt_code((SALT311.StrType)le.crrt_code),
    Fields.InValid_delivery_point_barcode((SALT311.StrType)le.delivery_point_barcode),
    Fields.InValid_zip4_check_digit((SALT311.StrType)le.zip4_check_digit),
    Fields.InValid_address_type_code((SALT311.StrType)le.address_type_code),
    Fields.InValid_address_type((SALT311.StrType)le.address_type),
    Fields.InValid_county_number((SALT311.StrType)le.county_number),
    Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Fields.InValid_gender_code((SALT311.StrType)le.gender_code),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_age((SALT311.StrType)le.age),
    Fields.InValid_birth_date((SALT311.StrType)le.birth_date),
    Fields.InValid_dob_formatted((SALT311.StrType)le.dob_formatted),
    Fields.InValid_telephone((SALT311.StrType)le.telephone),
    Fields.InValid_class((SALT311.StrType)le.class),
    Fields.InValid_college_class((SALT311.StrType)le.college_class),
    Fields.InValid_college_name((SALT311.StrType)le.college_name),
    Fields.InValid_ln_college_name((SALT311.StrType)le.ln_college_name),
    Fields.InValid_college_major((SALT311.StrType)le.college_major),
    Fields.InValid_new_college_major((SALT311.StrType)le.new_college_major),
    Fields.InValid_college_code((SALT311.StrType)le.college_code),
    Fields.InValid_college_code_exploded((SALT311.StrType)le.college_code_exploded),
    Fields.InValid_college_type((SALT311.StrType)le.college_type),
    Fields.InValid_college_type_exploded((SALT311.StrType)le.college_type_exploded),
    Fields.InValid_head_of_household_first_name((SALT311.StrType)le.head_of_household_first_name),
    Fields.InValid_head_of_household_gender_code((SALT311.StrType)le.head_of_household_gender_code),
    Fields.InValid_head_of_household_gender((SALT311.StrType)le.head_of_household_gender),
    Fields.InValid_income_level_code((SALT311.StrType)le.income_level_code),
    Fields.InValid_income_level((SALT311.StrType)le.income_level),
    Fields.InValid_new_income_level_code((SALT311.StrType)le.new_income_level_code),
    Fields.InValid_new_income_level((SALT311.StrType)le.new_income_level),
    Fields.InValid_file_type((SALT311.StrType)le.file_type),
    Fields.InValid_tier((SALT311.StrType)le.tier),
    Fields.InValid_school_size_code((SALT311.StrType)le.school_size_code),
    Fields.InValid_competitive_code((SALT311.StrType)le.competitive_code),
    Fields.InValid_tuition_code((SALT311.StrType)le.tuition_code),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_z5((SALT311.StrType)le.z5),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_tier2((SALT311.StrType)le.tier2),
    Fields.InValid_source((SALT311.StrType)le.source),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,90,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_nums','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','Unknown','invalid_alpha','invalid_alpha','invalid_alpha','invalid_address','invalid_address','invalid_alpha','Unknown','invalid_zip','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_address_type','invalid_nums','invalid_county_name','invalid_gender_code','invalid_gender','invalid_nums','invalid_nums','invalid_date','invalid_nums','Unknown','invalid_college_class','Unknown','Unknown','Unknown','Unknown','invalid_college_code','invalid_code_code_exploded','invalid_college_type','invalid_college_type_exploded','Unknown','invalid_gender_code','invalid_gender','invalid_income_lvl_code','Unknown','invalid_new_income_lvl_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_suffix','Unknown','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_csz','invalid_csz','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_key(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_historical_flag(TotalErrors.ErrorNum),Fields.InValidMessage_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip_4(TotalErrors.ErrorNum),Fields.InValidMessage_crrt_code(TotalErrors.ErrorNum),Fields.InValidMessage_delivery_point_barcode(TotalErrors.ErrorNum),Fields.InValidMessage_zip4_check_digit(TotalErrors.ErrorNum),Fields.InValidMessage_address_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_address_type(TotalErrors.ErrorNum),Fields.InValidMessage_county_number(TotalErrors.ErrorNum),Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_gender_code(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_birth_date(TotalErrors.ErrorNum),Fields.InValidMessage_dob_formatted(TotalErrors.ErrorNum),Fields.InValidMessage_telephone(TotalErrors.ErrorNum),Fields.InValidMessage_class(TotalErrors.ErrorNum),Fields.InValidMessage_college_class(TotalErrors.ErrorNum),Fields.InValidMessage_college_name(TotalErrors.ErrorNum),Fields.InValidMessage_ln_college_name(TotalErrors.ErrorNum),Fields.InValidMessage_college_major(TotalErrors.ErrorNum),Fields.InValidMessage_new_college_major(TotalErrors.ErrorNum),Fields.InValidMessage_college_code(TotalErrors.ErrorNum),Fields.InValidMessage_college_code_exploded(TotalErrors.ErrorNum),Fields.InValidMessage_college_type(TotalErrors.ErrorNum),Fields.InValidMessage_college_type_exploded(TotalErrors.ErrorNum),Fields.InValidMessage_head_of_household_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_head_of_household_gender_code(TotalErrors.ErrorNum),Fields.InValidMessage_head_of_household_gender(TotalErrors.ErrorNum),Fields.InValidMessage_income_level_code(TotalErrors.ErrorNum),Fields.InValidMessage_income_level(TotalErrors.ErrorNum),Fields.InValidMessage_new_income_level_code(TotalErrors.ErrorNum),Fields.InValidMessage_new_income_level(TotalErrors.ErrorNum),Fields.InValidMessage_file_type(TotalErrors.ErrorNum),Fields.InValidMessage_tier(TotalErrors.ErrorNum),Fields.InValidMessage_school_size_code(TotalErrors.ErrorNum),Fields.InValidMessage_competitive_code(TotalErrors.ErrorNum),Fields.InValidMessage_tuition_code(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_z5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_tier2(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_American_Student_List, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
