IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Watercraft_Search) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source_code))'', MAX(GROUP,h.source_code));
    NumberOfRecords := COUNT(GROUP);
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
    populated_watercraft_key_cnt := COUNT(GROUP,h.watercraft_key <> (TYPEOF(h.watercraft_key))'');
    populated_watercraft_key_pcnt := AVE(GROUP,IF(h.watercraft_key = (TYPEOF(h.watercraft_key))'',0,100));
    maxlength_watercraft_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.watercraft_key)));
    avelength_watercraft_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.watercraft_key)),h.watercraft_key<>(typeof(h.watercraft_key))'');
    populated_sequence_key_cnt := COUNT(GROUP,h.sequence_key <> (TYPEOF(h.sequence_key))'');
    populated_sequence_key_pcnt := AVE(GROUP,IF(h.sequence_key = (TYPEOF(h.sequence_key))'',0,100));
    maxlength_sequence_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_key)));
    avelength_sequence_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_key)),h.sequence_key<>(typeof(h.sequence_key))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_dppa_flag_cnt := COUNT(GROUP,h.dppa_flag <> (TYPEOF(h.dppa_flag))'');
    populated_dppa_flag_pcnt := AVE(GROUP,IF(h.dppa_flag = (TYPEOF(h.dppa_flag))'',0,100));
    maxlength_dppa_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dppa_flag)));
    avelength_dppa_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dppa_flag)),h.dppa_flag<>(typeof(h.dppa_flag))'');
    populated_orig_name_cnt := COUNT(GROUP,h.orig_name <> (TYPEOF(h.orig_name))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_orig_name_type_code_cnt := COUNT(GROUP,h.orig_name_type_code <> (TYPEOF(h.orig_name_type_code))'');
    populated_orig_name_type_code_pcnt := AVE(GROUP,IF(h.orig_name_type_code = (TYPEOF(h.orig_name_type_code))'',0,100));
    maxlength_orig_name_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_type_code)));
    avelength_orig_name_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_type_code)),h.orig_name_type_code<>(typeof(h.orig_name_type_code))'');
    populated_orig_name_type_description_cnt := COUNT(GROUP,h.orig_name_type_description <> (TYPEOF(h.orig_name_type_description))'');
    populated_orig_name_type_description_pcnt := AVE(GROUP,IF(h.orig_name_type_description = (TYPEOF(h.orig_name_type_description))'',0,100));
    maxlength_orig_name_type_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_type_description)));
    avelength_orig_name_type_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_type_description)),h.orig_name_type_description<>(typeof(h.orig_name_type_description))'');
    populated_orig_name_first_cnt := COUNT(GROUP,h.orig_name_first <> (TYPEOF(h.orig_name_first))'');
    populated_orig_name_first_pcnt := AVE(GROUP,IF(h.orig_name_first = (TYPEOF(h.orig_name_first))'',0,100));
    maxlength_orig_name_first := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_first)));
    avelength_orig_name_first := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_first)),h.orig_name_first<>(typeof(h.orig_name_first))'');
    populated_orig_name_middle_cnt := COUNT(GROUP,h.orig_name_middle <> (TYPEOF(h.orig_name_middle))'');
    populated_orig_name_middle_pcnt := AVE(GROUP,IF(h.orig_name_middle = (TYPEOF(h.orig_name_middle))'',0,100));
    maxlength_orig_name_middle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_middle)));
    avelength_orig_name_middle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_middle)),h.orig_name_middle<>(typeof(h.orig_name_middle))'');
    populated_orig_name_last_cnt := COUNT(GROUP,h.orig_name_last <> (TYPEOF(h.orig_name_last))'');
    populated_orig_name_last_pcnt := AVE(GROUP,IF(h.orig_name_last = (TYPEOF(h.orig_name_last))'',0,100));
    maxlength_orig_name_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_last)));
    avelength_orig_name_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_last)),h.orig_name_last<>(typeof(h.orig_name_last))'');
    populated_orig_name_suffix_cnt := COUNT(GROUP,h.orig_name_suffix <> (TYPEOF(h.orig_name_suffix))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_orig_address_1_cnt := COUNT(GROUP,h.orig_address_1 <> (TYPEOF(h.orig_address_1))'');
    populated_orig_address_1_pcnt := AVE(GROUP,IF(h.orig_address_1 = (TYPEOF(h.orig_address_1))'',0,100));
    maxlength_orig_address_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_1)));
    avelength_orig_address_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_1)),h.orig_address_1<>(typeof(h.orig_address_1))'');
    populated_orig_address_2_cnt := COUNT(GROUP,h.orig_address_2 <> (TYPEOF(h.orig_address_2))'');
    populated_orig_address_2_pcnt := AVE(GROUP,IF(h.orig_address_2 = (TYPEOF(h.orig_address_2))'',0,100));
    maxlength_orig_address_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_2)));
    avelength_orig_address_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_2)),h.orig_address_2<>(typeof(h.orig_address_2))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_fips_cnt := COUNT(GROUP,h.orig_fips <> (TYPEOF(h.orig_fips))'');
    populated_orig_fips_pcnt := AVE(GROUP,IF(h.orig_fips = (TYPEOF(h.orig_fips))'',0,100));
    maxlength_orig_fips := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fips)));
    avelength_orig_fips := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fips)),h.orig_fips<>(typeof(h.orig_fips))'');
    populated_orig_province_cnt := COUNT(GROUP,h.orig_province <> (TYPEOF(h.orig_province))'');
    populated_orig_province_pcnt := AVE(GROUP,IF(h.orig_province = (TYPEOF(h.orig_province))'',0,100));
    maxlength_orig_province := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_province)));
    avelength_orig_province := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_province)),h.orig_province<>(typeof(h.orig_province))'');
    populated_orig_country_cnt := COUNT(GROUP,h.orig_country <> (TYPEOF(h.orig_country))'');
    populated_orig_country_pcnt := AVE(GROUP,IF(h.orig_country = (TYPEOF(h.orig_country))'',0,100));
    maxlength_orig_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_country)));
    avelength_orig_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_country)),h.orig_country<>(typeof(h.orig_country))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_fein_cnt := COUNT(GROUP,h.orig_fein <> (TYPEOF(h.orig_fein))'');
    populated_orig_fein_pcnt := AVE(GROUP,IF(h.orig_fein = (TYPEOF(h.orig_fein))'',0,100));
    maxlength_orig_fein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fein)));
    avelength_orig_fein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fein)),h.orig_fein<>(typeof(h.orig_fein))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_phone_1_cnt := COUNT(GROUP,h.phone_1 <> (TYPEOF(h.phone_1))'');
    populated_phone_1_pcnt := AVE(GROUP,IF(h.phone_1 = (TYPEOF(h.phone_1))'',0,100));
    maxlength_phone_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_1)));
    avelength_phone_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_1)),h.phone_1<>(typeof(h.phone_1))'');
    populated_phone_2_cnt := COUNT(GROUP,h.phone_2 <> (TYPEOF(h.phone_2))'');
    populated_phone_2_pcnt := AVE(GROUP,IF(h.phone_2 = (TYPEOF(h.phone_2))'',0,100));
    maxlength_phone_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_2)));
    avelength_phone_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_2)),h.phone_2<>(typeof(h.phone_2))'');
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
    populated_name_cleaning_score_cnt := COUNT(GROUP,h.name_cleaning_score <> (TYPEOF(h.name_cleaning_score))'');
    populated_name_cleaning_score_pcnt := AVE(GROUP,IF(h.name_cleaning_score = (TYPEOF(h.name_cleaning_score))'',0,100));
    maxlength_name_cleaning_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_cleaning_score)));
    avelength_name_cleaning_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_cleaning_score)),h.name_cleaning_score<>(typeof(h.name_cleaning_score))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
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
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
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
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
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
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_ace_fips_county_cnt := COUNT(GROUP,h.ace_fips_county <> (TYPEOF(h.ace_fips_county))'');
    populated_ace_fips_county_pcnt := AVE(GROUP,IF(h.ace_fips_county = (TYPEOF(h.ace_fips_county))'',0,100));
    maxlength_ace_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_county)));
    avelength_ace_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_county)),h.ace_fips_county<>(typeof(h.ace_fips_county))'');
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
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_fein_cnt := COUNT(GROUP,h.fein <> (TYPEOF(h.fein))'');
    populated_fein_pcnt := AVE(GROUP,IF(h.fein = (TYPEOF(h.fein))'',0,100));
    maxlength_fein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fein)));
    avelength_fein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fein)),h.fein<>(typeof(h.fein))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_history_flag_cnt := COUNT(GROUP,h.history_flag <> (TYPEOF(h.history_flag))'');
    populated_history_flag_pcnt := AVE(GROUP,IF(h.history_flag = (TYPEOF(h.history_flag))'',0,100));
    maxlength_history_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.history_flag)));
    avelength_history_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.history_flag)),h.history_flag<>(typeof(h.history_flag))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_reg_owner_name_2_cnt := COUNT(GROUP,h.reg_owner_name_2 <> (TYPEOF(h.reg_owner_name_2))'');
    populated_reg_owner_name_2_pcnt := AVE(GROUP,IF(h.reg_owner_name_2 = (TYPEOF(h.reg_owner_name_2))'',0,100));
    maxlength_reg_owner_name_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_owner_name_2)));
    avelength_reg_owner_name_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_owner_name_2)),h.reg_owner_name_2<>(typeof(h.reg_owner_name_2))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_watercraft_key_pcnt *   0.00 / 100 + T.Populated_sequence_key_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_dppa_flag_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_orig_name_type_code_pcnt *   0.00 / 100 + T.Populated_orig_name_type_description_pcnt *   0.00 / 100 + T.Populated_orig_name_first_pcnt *   0.00 / 100 + T.Populated_orig_name_middle_pcnt *   0.00 / 100 + T.Populated_orig_name_last_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_pcnt *   0.00 / 100 + T.Populated_orig_address_1_pcnt *   0.00 / 100 + T.Populated_orig_address_2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_fips_pcnt *   0.00 / 100 + T.Populated_orig_province_pcnt *   0.00 / 100 + T.Populated_orig_country_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_fein_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_phone_1_pcnt *   0.00 / 100 + T.Populated_phone_2_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_cleaning_score_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_ace_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_fein_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_history_flag_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_reg_owner_name_2_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING source_code1;
    STRING source_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_code1 := le.Source;
    SELF.source_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_watercraft_key_pcnt*ri.Populated_watercraft_key_pcnt *   0.00 / 10000 + le.Populated_sequence_key_pcnt*ri.Populated_sequence_key_pcnt *   0.00 / 10000 + le.Populated_state_origin_pcnt*ri.Populated_state_origin_pcnt *   0.00 / 10000 + le.Populated_source_code_pcnt*ri.Populated_source_code_pcnt *   0.00 / 10000 + le.Populated_dppa_flag_pcnt*ri.Populated_dppa_flag_pcnt *   0.00 / 10000 + le.Populated_orig_name_pcnt*ri.Populated_orig_name_pcnt *   0.00 / 10000 + le.Populated_orig_name_type_code_pcnt*ri.Populated_orig_name_type_code_pcnt *   0.00 / 10000 + le.Populated_orig_name_type_description_pcnt*ri.Populated_orig_name_type_description_pcnt *   0.00 / 10000 + le.Populated_orig_name_first_pcnt*ri.Populated_orig_name_first_pcnt *   0.00 / 10000 + le.Populated_orig_name_middle_pcnt*ri.Populated_orig_name_middle_pcnt *   0.00 / 10000 + le.Populated_orig_name_last_pcnt*ri.Populated_orig_name_last_pcnt *   0.00 / 10000 + le.Populated_orig_name_suffix_pcnt*ri.Populated_orig_name_suffix_pcnt *   0.00 / 10000 + le.Populated_orig_address_1_pcnt*ri.Populated_orig_address_1_pcnt *   0.00 / 10000 + le.Populated_orig_address_2_pcnt*ri.Populated_orig_address_2_pcnt *   0.00 / 10000 + le.Populated_orig_city_pcnt*ri.Populated_orig_city_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_zip_pcnt*ri.Populated_orig_zip_pcnt *   0.00 / 10000 + le.Populated_orig_fips_pcnt*ri.Populated_orig_fips_pcnt *   0.00 / 10000 + le.Populated_orig_province_pcnt*ri.Populated_orig_province_pcnt *   0.00 / 10000 + le.Populated_orig_country_pcnt*ri.Populated_orig_country_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_orig_ssn_pcnt*ri.Populated_orig_ssn_pcnt *   0.00 / 10000 + le.Populated_orig_fein_pcnt*ri.Populated_orig_fein_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_phone_1_pcnt*ri.Populated_phone_1_pcnt *   0.00 / 10000 + le.Populated_phone_2_pcnt*ri.Populated_phone_2_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_cleaning_score_pcnt*ri.Populated_name_cleaning_score_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_ace_fips_st_pcnt*ri.Populated_ace_fips_st_pcnt *   0.00 / 10000 + le.Populated_ace_fips_county_pcnt*ri.Populated_ace_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_fein_pcnt*ri.Populated_fein_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_history_flag_pcnt*ri.Populated_history_flag_pcnt *   0.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt *   0.00 / 10000 + le.Populated_reg_owner_name_2_pcnt*ri.Populated_reg_owner_name_2_pcnt *   0.00 / 10000 + le.Populated_persistent_record_id_pcnt*ri.Populated_persistent_record_id_pcnt *   0.00 / 10000 + le.Populated_source_rec_id_pcnt*ri.Populated_source_rec_id_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_seleid_pcnt*ri.Populated_seleid_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','watercraft_key','sequence_key','state_origin','source_code','dppa_flag','orig_name','orig_name_type_code','orig_name_type_description','orig_name_first','orig_name_middle','orig_name_last','orig_name_suffix','orig_address_1','orig_address_2','orig_city','orig_state','orig_zip','orig_fips','orig_province','orig_country','dob','orig_ssn','orig_fein','gender','phone_1','phone_2','title','fname','mname','lname','name_suffix','name_cleaning_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','fein','did','did_score','ssn','history_flag','rawaid','reg_owner_name_2','persistent_record_id','source_rec_id','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_watercraft_key_pcnt,le.populated_sequence_key_pcnt,le.populated_state_origin_pcnt,le.populated_source_code_pcnt,le.populated_dppa_flag_pcnt,le.populated_orig_name_pcnt,le.populated_orig_name_type_code_pcnt,le.populated_orig_name_type_description_pcnt,le.populated_orig_name_first_pcnt,le.populated_orig_name_middle_pcnt,le.populated_orig_name_last_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_orig_address_1_pcnt,le.populated_orig_address_2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_fips_pcnt,le.populated_orig_province_pcnt,le.populated_orig_country_pcnt,le.populated_dob_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_fein_pcnt,le.populated_gender_pcnt,le.populated_phone_1_pcnt,le.populated_phone_2_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_cleaning_score_pcnt,le.populated_company_name_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_county_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_ace_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_bdid_pcnt,le.populated_fein_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_ssn_pcnt,le.populated_history_flag_pcnt,le.populated_rawaid_pcnt,le.populated_reg_owner_name_2_pcnt,le.populated_persistent_record_id_pcnt,le.populated_source_rec_id_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_watercraft_key,le.maxlength_sequence_key,le.maxlength_state_origin,le.maxlength_source_code,le.maxlength_dppa_flag,le.maxlength_orig_name,le.maxlength_orig_name_type_code,le.maxlength_orig_name_type_description,le.maxlength_orig_name_first,le.maxlength_orig_name_middle,le.maxlength_orig_name_last,le.maxlength_orig_name_suffix,le.maxlength_orig_address_1,le.maxlength_orig_address_2,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_fips,le.maxlength_orig_province,le.maxlength_orig_country,le.maxlength_dob,le.maxlength_orig_ssn,le.maxlength_orig_fein,le.maxlength_gender,le.maxlength_phone_1,le.maxlength_phone_2,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_cleaning_score,le.maxlength_company_name,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_county,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_ace_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_bdid,le.maxlength_fein,le.maxlength_did,le.maxlength_did_score,le.maxlength_ssn,le.maxlength_history_flag,le.maxlength_rawaid,le.maxlength_reg_owner_name_2,le.maxlength_persistent_record_id,le.maxlength_source_rec_id,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_watercraft_key,le.avelength_sequence_key,le.avelength_state_origin,le.avelength_source_code,le.avelength_dppa_flag,le.avelength_orig_name,le.avelength_orig_name_type_code,le.avelength_orig_name_type_description,le.avelength_orig_name_first,le.avelength_orig_name_middle,le.avelength_orig_name_last,le.avelength_orig_name_suffix,le.avelength_orig_address_1,le.avelength_orig_address_2,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_fips,le.avelength_orig_province,le.avelength_orig_country,le.avelength_dob,le.avelength_orig_ssn,le.avelength_orig_fein,le.avelength_gender,le.avelength_phone_1,le.avelength_phone_2,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_cleaning_score,le.avelength_company_name,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_county,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_ace_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_bdid,le.avelength_fein,le.avelength_did,le.avelength_did_score,le.avelength_ssn,le.avelength_history_flag,le.avelength_rawaid,le.avelength_reg_owner_name_2,le.avelength_persistent_record_id,le.avelength_source_rec_id,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 95, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.watercraft_key),TRIM((SALT311.StrType)le.sequence_key),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.dppa_flag),TRIM((SALT311.StrType)le.orig_name),TRIM((SALT311.StrType)le.orig_name_type_code),TRIM((SALT311.StrType)le.orig_name_type_description),TRIM((SALT311.StrType)le.orig_name_first),TRIM((SALT311.StrType)le.orig_name_middle),TRIM((SALT311.StrType)le.orig_name_last),TRIM((SALT311.StrType)le.orig_name_suffix),TRIM((SALT311.StrType)le.orig_address_1),TRIM((SALT311.StrType)le.orig_address_2),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_fips),TRIM((SALT311.StrType)le.orig_province),TRIM((SALT311.StrType)le.orig_country),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_fein),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.phone_1),TRIM((SALT311.StrType)le.phone_2),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_cleaning_score),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.bdid),TRIM((SALT311.StrType)le.fein),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.did_score),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.history_flag),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.reg_owner_name_2),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,95,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 95);
  SELF.FldNo2 := 1 + (C % 95);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.watercraft_key),TRIM((SALT311.StrType)le.sequence_key),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.dppa_flag),TRIM((SALT311.StrType)le.orig_name),TRIM((SALT311.StrType)le.orig_name_type_code),TRIM((SALT311.StrType)le.orig_name_type_description),TRIM((SALT311.StrType)le.orig_name_first),TRIM((SALT311.StrType)le.orig_name_middle),TRIM((SALT311.StrType)le.orig_name_last),TRIM((SALT311.StrType)le.orig_name_suffix),TRIM((SALT311.StrType)le.orig_address_1),TRIM((SALT311.StrType)le.orig_address_2),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_fips),TRIM((SALT311.StrType)le.orig_province),TRIM((SALT311.StrType)le.orig_country),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_fein),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.phone_1),TRIM((SALT311.StrType)le.phone_2),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_cleaning_score),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.bdid),TRIM((SALT311.StrType)le.fein),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.did_score),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.history_flag),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.reg_owner_name_2),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.watercraft_key),TRIM((SALT311.StrType)le.sequence_key),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.dppa_flag),TRIM((SALT311.StrType)le.orig_name),TRIM((SALT311.StrType)le.orig_name_type_code),TRIM((SALT311.StrType)le.orig_name_type_description),TRIM((SALT311.StrType)le.orig_name_first),TRIM((SALT311.StrType)le.orig_name_middle),TRIM((SALT311.StrType)le.orig_name_last),TRIM((SALT311.StrType)le.orig_name_suffix),TRIM((SALT311.StrType)le.orig_address_1),TRIM((SALT311.StrType)le.orig_address_2),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.orig_fips),TRIM((SALT311.StrType)le.orig_province),TRIM((SALT311.StrType)le.orig_country),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.orig_ssn),TRIM((SALT311.StrType)le.orig_fein),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.phone_1),TRIM((SALT311.StrType)le.phone_2),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_cleaning_score),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.bdid),TRIM((SALT311.StrType)le.fein),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.did_score),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.history_flag),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),TRIM((SALT311.StrType)le.reg_owner_name_2),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),95*95,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'date_first_seen'}
      ,{2,'date_last_seen'}
      ,{3,'date_vendor_first_reported'}
      ,{4,'date_vendor_last_reported'}
      ,{5,'watercraft_key'}
      ,{6,'sequence_key'}
      ,{7,'state_origin'}
      ,{8,'source_code'}
      ,{9,'dppa_flag'}
      ,{10,'orig_name'}
      ,{11,'orig_name_type_code'}
      ,{12,'orig_name_type_description'}
      ,{13,'orig_name_first'}
      ,{14,'orig_name_middle'}
      ,{15,'orig_name_last'}
      ,{16,'orig_name_suffix'}
      ,{17,'orig_address_1'}
      ,{18,'orig_address_2'}
      ,{19,'orig_city'}
      ,{20,'orig_state'}
      ,{21,'orig_zip'}
      ,{22,'orig_fips'}
      ,{23,'orig_province'}
      ,{24,'orig_country'}
      ,{25,'dob'}
      ,{26,'orig_ssn'}
      ,{27,'orig_fein'}
      ,{28,'gender'}
      ,{29,'phone_1'}
      ,{30,'phone_2'}
      ,{31,'title'}
      ,{32,'fname'}
      ,{33,'mname'}
      ,{34,'lname'}
      ,{35,'name_suffix'}
      ,{36,'name_cleaning_score'}
      ,{37,'company_name'}
      ,{38,'prim_range'}
      ,{39,'predir'}
      ,{40,'prim_name'}
      ,{41,'suffix'}
      ,{42,'postdir'}
      ,{43,'unit_desig'}
      ,{44,'sec_range'}
      ,{45,'p_city_name'}
      ,{46,'v_city_name'}
      ,{47,'st'}
      ,{48,'zip5'}
      ,{49,'zip4'}
      ,{50,'county'}
      ,{51,'cart'}
      ,{52,'cr_sort_sz'}
      ,{53,'lot'}
      ,{54,'lot_order'}
      ,{55,'dpbc'}
      ,{56,'chk_digit'}
      ,{57,'rec_type'}
      ,{58,'ace_fips_st'}
      ,{59,'ace_fips_county'}
      ,{60,'geo_lat'}
      ,{61,'geo_long'}
      ,{62,'msa'}
      ,{63,'geo_blk'}
      ,{64,'geo_match'}
      ,{65,'err_stat'}
      ,{66,'bdid'}
      ,{67,'fein'}
      ,{68,'did'}
      ,{69,'did_score'}
      ,{70,'ssn'}
      ,{71,'history_flag'}
      ,{72,'rawaid'}
      ,{73,'reg_owner_name_2'}
      ,{74,'persistent_record_id'}
      ,{75,'source_rec_id'}
      ,{76,'dotscore'}
      ,{77,'dotweight'}
      ,{78,'empid'}
      ,{79,'empscore'}
      ,{80,'empweight'}
      ,{81,'powid'}
      ,{82,'powscore'}
      ,{83,'powweight'}
      ,{84,'proxid'}
      ,{85,'proxscore'}
      ,{86,'proxweight'}
      ,{87,'seleid'}
      ,{88,'selescore'}
      ,{89,'seleweight'}
      ,{90,'orgid'}
      ,{91,'orgscore'}
      ,{92,'orgweight'}
      ,{93,'ultid'}
      ,{94,'ultscore'}
      ,{95,'ultweight'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_code) source_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_watercraft_key((SALT311.StrType)le.watercraft_key),
    Fields.InValid_sequence_key((SALT311.StrType)le.sequence_key),
    Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Fields.InValid_dppa_flag((SALT311.StrType)le.dppa_flag),
    Fields.InValid_orig_name((SALT311.StrType)le.orig_name),
    Fields.InValid_orig_name_type_code((SALT311.StrType)le.orig_name_type_code),
    Fields.InValid_orig_name_type_description((SALT311.StrType)le.orig_name_type_description),
    Fields.InValid_orig_name_first((SALT311.StrType)le.orig_name_first),
    Fields.InValid_orig_name_middle((SALT311.StrType)le.orig_name_middle),
    Fields.InValid_orig_name_last((SALT311.StrType)le.orig_name_last),
    Fields.InValid_orig_name_suffix((SALT311.StrType)le.orig_name_suffix),
    Fields.InValid_orig_address_1((SALT311.StrType)le.orig_address_1),
    Fields.InValid_orig_address_2((SALT311.StrType)le.orig_address_2),
    Fields.InValid_orig_city((SALT311.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    Fields.InValid_orig_fips((SALT311.StrType)le.orig_fips),
    Fields.InValid_orig_province((SALT311.StrType)le.orig_province),
    Fields.InValid_orig_country((SALT311.StrType)le.orig_country),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_orig_ssn((SALT311.StrType)le.orig_ssn),
    Fields.InValid_orig_fein((SALT311.StrType)le.orig_fein),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_phone_1((SALT311.StrType)le.phone_1),
    Fields.InValid_phone_2((SALT311.StrType)le.phone_2),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_name_cleaning_score((SALT311.StrType)le.name_cleaning_score),
    Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip5((SALT311.StrType)le.zip5),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Fields.InValid_ace_fips_county((SALT311.StrType)le.ace_fips_county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Fields.InValid_fein((SALT311.StrType)le.fein),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Fields.InValid_history_flag((SALT311.StrType)le.history_flag),
    Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Fields.InValid_reg_owner_name_2((SALT311.StrType)le.reg_owner_name_2),
    Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id),
    Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Fields.InValid_empid((SALT311.StrType)le.empid),
    Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Fields.InValid_powid((SALT311.StrType)le.powid),
    Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_code := le.source_code;
END;
Errors := NORMALIZE(h,95,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_blank','Unknown','invalid_state','invalid_source_code','invalid_dppa_flag','Unknown','invalid_owner_type','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','invalid_phone','invalid_phone','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','invalid_company','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_state','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_fips','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_numeric','invalid_ssn_fein','invalid_numeric','Unknown','invalid_ssn_fein','invalid_history_flag','invalid_numeric','Unknown','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_key(TotalErrors.ErrorNum),Fields.InValidMessage_sequence_key(TotalErrors.ErrorNum),Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_dppa_flag(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fips(TotalErrors.ErrorNum),Fields.InValidMessage_orig_province(TotalErrors.ErrorNum),Fields.InValidMessage_orig_country(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fein(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_phone_1(TotalErrors.ErrorNum),Fields.InValidMessage_phone_2(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_cleaning_score(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_fein(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_history_flag(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_reg_owner_name_2(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Watercraft_Search, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
