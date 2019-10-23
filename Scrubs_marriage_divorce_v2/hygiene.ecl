IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Marriage_Divorce_V2_Profile) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_record_id_cnt := COUNT(GROUP,h.record_id <> (TYPEOF(h.record_id))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_filing_type_cnt := COUNT(GROUP,h.filing_type <> (TYPEOF(h.filing_type))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_filing_subtype_cnt := COUNT(GROUP,h.filing_subtype <> (TYPEOF(h.filing_subtype))'');
    populated_filing_subtype_pcnt := AVE(GROUP,IF(h.filing_subtype = (TYPEOF(h.filing_subtype))'',0,100));
    maxlength_filing_subtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_subtype)));
    avelength_filing_subtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_subtype)),h.filing_subtype<>(typeof(h.filing_subtype))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_source_file_cnt := COUNT(GROUP,h.source_file <> (TYPEOF(h.source_file))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_party1_type_cnt := COUNT(GROUP,h.party1_type <> (TYPEOF(h.party1_type))'');
    populated_party1_type_pcnt := AVE(GROUP,IF(h.party1_type = (TYPEOF(h.party1_type))'',0,100));
    maxlength_party1_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_type)));
    avelength_party1_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_type)),h.party1_type<>(typeof(h.party1_type))'');
    populated_party1_name_format_cnt := COUNT(GROUP,h.party1_name_format <> (TYPEOF(h.party1_name_format))'');
    populated_party1_name_format_pcnt := AVE(GROUP,IF(h.party1_name_format = (TYPEOF(h.party1_name_format))'',0,100));
    maxlength_party1_name_format := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_name_format)));
    avelength_party1_name_format := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_name_format)),h.party1_name_format<>(typeof(h.party1_name_format))'');
    populated_party1_name_cnt := COUNT(GROUP,h.party1_name <> (TYPEOF(h.party1_name))'');
    populated_party1_name_pcnt := AVE(GROUP,IF(h.party1_name = (TYPEOF(h.party1_name))'',0,100));
    maxlength_party1_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_name)));
    avelength_party1_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_name)),h.party1_name<>(typeof(h.party1_name))'');
    populated_party1_alias_cnt := COUNT(GROUP,h.party1_alias <> (TYPEOF(h.party1_alias))'');
    populated_party1_alias_pcnt := AVE(GROUP,IF(h.party1_alias = (TYPEOF(h.party1_alias))'',0,100));
    maxlength_party1_alias := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_alias)));
    avelength_party1_alias := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_alias)),h.party1_alias<>(typeof(h.party1_alias))'');
    populated_party1_dob_cnt := COUNT(GROUP,h.party1_dob <> (TYPEOF(h.party1_dob))'');
    populated_party1_dob_pcnt := AVE(GROUP,IF(h.party1_dob = (TYPEOF(h.party1_dob))'',0,100));
    maxlength_party1_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_dob)));
    avelength_party1_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_dob)),h.party1_dob<>(typeof(h.party1_dob))'');
    populated_party1_birth_state_cnt := COUNT(GROUP,h.party1_birth_state <> (TYPEOF(h.party1_birth_state))'');
    populated_party1_birth_state_pcnt := AVE(GROUP,IF(h.party1_birth_state = (TYPEOF(h.party1_birth_state))'',0,100));
    maxlength_party1_birth_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_birth_state)));
    avelength_party1_birth_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_birth_state)),h.party1_birth_state<>(typeof(h.party1_birth_state))'');
    populated_party1_age_cnt := COUNT(GROUP,h.party1_age <> (TYPEOF(h.party1_age))'');
    populated_party1_age_pcnt := AVE(GROUP,IF(h.party1_age = (TYPEOF(h.party1_age))'',0,100));
    maxlength_party1_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_age)));
    avelength_party1_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_age)),h.party1_age<>(typeof(h.party1_age))'');
    populated_party1_race_cnt := COUNT(GROUP,h.party1_race <> (TYPEOF(h.party1_race))'');
    populated_party1_race_pcnt := AVE(GROUP,IF(h.party1_race = (TYPEOF(h.party1_race))'',0,100));
    maxlength_party1_race := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_race)));
    avelength_party1_race := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_race)),h.party1_race<>(typeof(h.party1_race))'');
    populated_party1_addr1_cnt := COUNT(GROUP,h.party1_addr1 <> (TYPEOF(h.party1_addr1))'');
    populated_party1_addr1_pcnt := AVE(GROUP,IF(h.party1_addr1 = (TYPEOF(h.party1_addr1))'',0,100));
    maxlength_party1_addr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_addr1)));
    avelength_party1_addr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_addr1)),h.party1_addr1<>(typeof(h.party1_addr1))'');
    populated_party1_csz_cnt := COUNT(GROUP,h.party1_csz <> (TYPEOF(h.party1_csz))'');
    populated_party1_csz_pcnt := AVE(GROUP,IF(h.party1_csz = (TYPEOF(h.party1_csz))'',0,100));
    maxlength_party1_csz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_csz)));
    avelength_party1_csz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_csz)),h.party1_csz<>(typeof(h.party1_csz))'');
    populated_party1_county_cnt := COUNT(GROUP,h.party1_county <> (TYPEOF(h.party1_county))'');
    populated_party1_county_pcnt := AVE(GROUP,IF(h.party1_county = (TYPEOF(h.party1_county))'',0,100));
    maxlength_party1_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_county)));
    avelength_party1_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_county)),h.party1_county<>(typeof(h.party1_county))'');
    populated_party1_previous_marital_status_cnt := COUNT(GROUP,h.party1_previous_marital_status <> (TYPEOF(h.party1_previous_marital_status))'');
    populated_party1_previous_marital_status_pcnt := AVE(GROUP,IF(h.party1_previous_marital_status = (TYPEOF(h.party1_previous_marital_status))'',0,100));
    maxlength_party1_previous_marital_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_previous_marital_status)));
    avelength_party1_previous_marital_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_previous_marital_status)),h.party1_previous_marital_status<>(typeof(h.party1_previous_marital_status))'');
    populated_party1_how_marriage_ended_cnt := COUNT(GROUP,h.party1_how_marriage_ended <> (TYPEOF(h.party1_how_marriage_ended))'');
    populated_party1_how_marriage_ended_pcnt := AVE(GROUP,IF(h.party1_how_marriage_ended = (TYPEOF(h.party1_how_marriage_ended))'',0,100));
    maxlength_party1_how_marriage_ended := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_how_marriage_ended)));
    avelength_party1_how_marriage_ended := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_how_marriage_ended)),h.party1_how_marriage_ended<>(typeof(h.party1_how_marriage_ended))'');
    populated_party1_times_married_cnt := COUNT(GROUP,h.party1_times_married <> (TYPEOF(h.party1_times_married))'');
    populated_party1_times_married_pcnt := AVE(GROUP,IF(h.party1_times_married = (TYPEOF(h.party1_times_married))'',0,100));
    maxlength_party1_times_married := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_times_married)));
    avelength_party1_times_married := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_times_married)),h.party1_times_married<>(typeof(h.party1_times_married))'');
    populated_party1_last_marriage_end_dt_cnt := COUNT(GROUP,h.party1_last_marriage_end_dt <> (TYPEOF(h.party1_last_marriage_end_dt))'');
    populated_party1_last_marriage_end_dt_pcnt := AVE(GROUP,IF(h.party1_last_marriage_end_dt = (TYPEOF(h.party1_last_marriage_end_dt))'',0,100));
    maxlength_party1_last_marriage_end_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_last_marriage_end_dt)));
    avelength_party1_last_marriage_end_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party1_last_marriage_end_dt)),h.party1_last_marriage_end_dt<>(typeof(h.party1_last_marriage_end_dt))'');
    populated_party2_type_cnt := COUNT(GROUP,h.party2_type <> (TYPEOF(h.party2_type))'');
    populated_party2_type_pcnt := AVE(GROUP,IF(h.party2_type = (TYPEOF(h.party2_type))'',0,100));
    maxlength_party2_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_type)));
    avelength_party2_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_type)),h.party2_type<>(typeof(h.party2_type))'');
    populated_party2_name_format_cnt := COUNT(GROUP,h.party2_name_format <> (TYPEOF(h.party2_name_format))'');
    populated_party2_name_format_pcnt := AVE(GROUP,IF(h.party2_name_format = (TYPEOF(h.party2_name_format))'',0,100));
    maxlength_party2_name_format := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_name_format)));
    avelength_party2_name_format := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_name_format)),h.party2_name_format<>(typeof(h.party2_name_format))'');
    populated_party2_name_cnt := COUNT(GROUP,h.party2_name <> (TYPEOF(h.party2_name))'');
    populated_party2_name_pcnt := AVE(GROUP,IF(h.party2_name = (TYPEOF(h.party2_name))'',0,100));
    maxlength_party2_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_name)));
    avelength_party2_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_name)),h.party2_name<>(typeof(h.party2_name))'');
    populated_party2_alias_cnt := COUNT(GROUP,h.party2_alias <> (TYPEOF(h.party2_alias))'');
    populated_party2_alias_pcnt := AVE(GROUP,IF(h.party2_alias = (TYPEOF(h.party2_alias))'',0,100));
    maxlength_party2_alias := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_alias)));
    avelength_party2_alias := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_alias)),h.party2_alias<>(typeof(h.party2_alias))'');
    populated_party2_dob_cnt := COUNT(GROUP,h.party2_dob <> (TYPEOF(h.party2_dob))'');
    populated_party2_dob_pcnt := AVE(GROUP,IF(h.party2_dob = (TYPEOF(h.party2_dob))'',0,100));
    maxlength_party2_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_dob)));
    avelength_party2_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_dob)),h.party2_dob<>(typeof(h.party2_dob))'');
    populated_party2_birth_state_cnt := COUNT(GROUP,h.party2_birth_state <> (TYPEOF(h.party2_birth_state))'');
    populated_party2_birth_state_pcnt := AVE(GROUP,IF(h.party2_birth_state = (TYPEOF(h.party2_birth_state))'',0,100));
    maxlength_party2_birth_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_birth_state)));
    avelength_party2_birth_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_birth_state)),h.party2_birth_state<>(typeof(h.party2_birth_state))'');
    populated_party2_age_cnt := COUNT(GROUP,h.party2_age <> (TYPEOF(h.party2_age))'');
    populated_party2_age_pcnt := AVE(GROUP,IF(h.party2_age = (TYPEOF(h.party2_age))'',0,100));
    maxlength_party2_age := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_age)));
    avelength_party2_age := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_age)),h.party2_age<>(typeof(h.party2_age))'');
    populated_party2_race_cnt := COUNT(GROUP,h.party2_race <> (TYPEOF(h.party2_race))'');
    populated_party2_race_pcnt := AVE(GROUP,IF(h.party2_race = (TYPEOF(h.party2_race))'',0,100));
    maxlength_party2_race := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_race)));
    avelength_party2_race := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_race)),h.party2_race<>(typeof(h.party2_race))'');
    populated_party2_addr1_cnt := COUNT(GROUP,h.party2_addr1 <> (TYPEOF(h.party2_addr1))'');
    populated_party2_addr1_pcnt := AVE(GROUP,IF(h.party2_addr1 = (TYPEOF(h.party2_addr1))'',0,100));
    maxlength_party2_addr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_addr1)));
    avelength_party2_addr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_addr1)),h.party2_addr1<>(typeof(h.party2_addr1))'');
    populated_party2_csz_cnt := COUNT(GROUP,h.party2_csz <> (TYPEOF(h.party2_csz))'');
    populated_party2_csz_pcnt := AVE(GROUP,IF(h.party2_csz = (TYPEOF(h.party2_csz))'',0,100));
    maxlength_party2_csz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_csz)));
    avelength_party2_csz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_csz)),h.party2_csz<>(typeof(h.party2_csz))'');
    populated_party2_county_cnt := COUNT(GROUP,h.party2_county <> (TYPEOF(h.party2_county))'');
    populated_party2_county_pcnt := AVE(GROUP,IF(h.party2_county = (TYPEOF(h.party2_county))'',0,100));
    maxlength_party2_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_county)));
    avelength_party2_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_county)),h.party2_county<>(typeof(h.party2_county))'');
    populated_party2_previous_marital_status_cnt := COUNT(GROUP,h.party2_previous_marital_status <> (TYPEOF(h.party2_previous_marital_status))'');
    populated_party2_previous_marital_status_pcnt := AVE(GROUP,IF(h.party2_previous_marital_status = (TYPEOF(h.party2_previous_marital_status))'',0,100));
    maxlength_party2_previous_marital_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_previous_marital_status)));
    avelength_party2_previous_marital_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_previous_marital_status)),h.party2_previous_marital_status<>(typeof(h.party2_previous_marital_status))'');
    populated_party2_how_marriage_ended_cnt := COUNT(GROUP,h.party2_how_marriage_ended <> (TYPEOF(h.party2_how_marriage_ended))'');
    populated_party2_how_marriage_ended_pcnt := AVE(GROUP,IF(h.party2_how_marriage_ended = (TYPEOF(h.party2_how_marriage_ended))'',0,100));
    maxlength_party2_how_marriage_ended := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_how_marriage_ended)));
    avelength_party2_how_marriage_ended := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_how_marriage_ended)),h.party2_how_marriage_ended<>(typeof(h.party2_how_marriage_ended))'');
    populated_party2_times_married_cnt := COUNT(GROUP,h.party2_times_married <> (TYPEOF(h.party2_times_married))'');
    populated_party2_times_married_pcnt := AVE(GROUP,IF(h.party2_times_married = (TYPEOF(h.party2_times_married))'',0,100));
    maxlength_party2_times_married := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_times_married)));
    avelength_party2_times_married := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_times_married)),h.party2_times_married<>(typeof(h.party2_times_married))'');
    populated_party2_last_marriage_end_dt_cnt := COUNT(GROUP,h.party2_last_marriage_end_dt <> (TYPEOF(h.party2_last_marriage_end_dt))'');
    populated_party2_last_marriage_end_dt_pcnt := AVE(GROUP,IF(h.party2_last_marriage_end_dt = (TYPEOF(h.party2_last_marriage_end_dt))'',0,100));
    maxlength_party2_last_marriage_end_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_last_marriage_end_dt)));
    avelength_party2_last_marriage_end_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.party2_last_marriage_end_dt)),h.party2_last_marriage_end_dt<>(typeof(h.party2_last_marriage_end_dt))'');
    populated_number_of_children_cnt := COUNT(GROUP,h.number_of_children <> (TYPEOF(h.number_of_children))'');
    populated_number_of_children_pcnt := AVE(GROUP,IF(h.number_of_children = (TYPEOF(h.number_of_children))'',0,100));
    maxlength_number_of_children := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_children)));
    avelength_number_of_children := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_of_children)),h.number_of_children<>(typeof(h.number_of_children))'');
    populated_marriage_filing_dt_cnt := COUNT(GROUP,h.marriage_filing_dt <> (TYPEOF(h.marriage_filing_dt))'');
    populated_marriage_filing_dt_pcnt := AVE(GROUP,IF(h.marriage_filing_dt = (TYPEOF(h.marriage_filing_dt))'',0,100));
    maxlength_marriage_filing_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_filing_dt)));
    avelength_marriage_filing_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_filing_dt)),h.marriage_filing_dt<>(typeof(h.marriage_filing_dt))'');
    populated_marriage_dt_cnt := COUNT(GROUP,h.marriage_dt <> (TYPEOF(h.marriage_dt))'');
    populated_marriage_dt_pcnt := AVE(GROUP,IF(h.marriage_dt = (TYPEOF(h.marriage_dt))'',0,100));
    maxlength_marriage_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_dt)));
    avelength_marriage_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_dt)),h.marriage_dt<>(typeof(h.marriage_dt))'');
    populated_marriage_city_cnt := COUNT(GROUP,h.marriage_city <> (TYPEOF(h.marriage_city))'');
    populated_marriage_city_pcnt := AVE(GROUP,IF(h.marriage_city = (TYPEOF(h.marriage_city))'',0,100));
    maxlength_marriage_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_city)));
    avelength_marriage_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_city)),h.marriage_city<>(typeof(h.marriage_city))'');
    populated_marriage_county_cnt := COUNT(GROUP,h.marriage_county <> (TYPEOF(h.marriage_county))'');
    populated_marriage_county_pcnt := AVE(GROUP,IF(h.marriage_county = (TYPEOF(h.marriage_county))'',0,100));
    maxlength_marriage_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_county)));
    avelength_marriage_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_county)),h.marriage_county<>(typeof(h.marriage_county))'');
    populated_place_of_marriage_cnt := COUNT(GROUP,h.place_of_marriage <> (TYPEOF(h.place_of_marriage))'');
    populated_place_of_marriage_pcnt := AVE(GROUP,IF(h.place_of_marriage = (TYPEOF(h.place_of_marriage))'',0,100));
    maxlength_place_of_marriage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.place_of_marriage)));
    avelength_place_of_marriage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.place_of_marriage)),h.place_of_marriage<>(typeof(h.place_of_marriage))'');
    populated_type_of_ceremony_cnt := COUNT(GROUP,h.type_of_ceremony <> (TYPEOF(h.type_of_ceremony))'');
    populated_type_of_ceremony_pcnt := AVE(GROUP,IF(h.type_of_ceremony = (TYPEOF(h.type_of_ceremony))'',0,100));
    maxlength_type_of_ceremony := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_of_ceremony)));
    avelength_type_of_ceremony := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_of_ceremony)),h.type_of_ceremony<>(typeof(h.type_of_ceremony))'');
    populated_marriage_filing_number_cnt := COUNT(GROUP,h.marriage_filing_number <> (TYPEOF(h.marriage_filing_number))'');
    populated_marriage_filing_number_pcnt := AVE(GROUP,IF(h.marriage_filing_number = (TYPEOF(h.marriage_filing_number))'',0,100));
    maxlength_marriage_filing_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_filing_number)));
    avelength_marriage_filing_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_filing_number)),h.marriage_filing_number<>(typeof(h.marriage_filing_number))'');
    populated_marriage_docket_volume_cnt := COUNT(GROUP,h.marriage_docket_volume <> (TYPEOF(h.marriage_docket_volume))'');
    populated_marriage_docket_volume_pcnt := AVE(GROUP,IF(h.marriage_docket_volume = (TYPEOF(h.marriage_docket_volume))'',0,100));
    maxlength_marriage_docket_volume := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_docket_volume)));
    avelength_marriage_docket_volume := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_docket_volume)),h.marriage_docket_volume<>(typeof(h.marriage_docket_volume))'');
    populated_divorce_filing_dt_cnt := COUNT(GROUP,h.divorce_filing_dt <> (TYPEOF(h.divorce_filing_dt))'');
    populated_divorce_filing_dt_pcnt := AVE(GROUP,IF(h.divorce_filing_dt = (TYPEOF(h.divorce_filing_dt))'',0,100));
    maxlength_divorce_filing_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_filing_dt)));
    avelength_divorce_filing_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_filing_dt)),h.divorce_filing_dt<>(typeof(h.divorce_filing_dt))'');
    populated_divorce_dt_cnt := COUNT(GROUP,h.divorce_dt <> (TYPEOF(h.divorce_dt))'');
    populated_divorce_dt_pcnt := AVE(GROUP,IF(h.divorce_dt = (TYPEOF(h.divorce_dt))'',0,100));
    maxlength_divorce_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_dt)));
    avelength_divorce_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_dt)),h.divorce_dt<>(typeof(h.divorce_dt))'');
    populated_divorce_docket_volume_cnt := COUNT(GROUP,h.divorce_docket_volume <> (TYPEOF(h.divorce_docket_volume))'');
    populated_divorce_docket_volume_pcnt := AVE(GROUP,IF(h.divorce_docket_volume = (TYPEOF(h.divorce_docket_volume))'',0,100));
    maxlength_divorce_docket_volume := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_docket_volume)));
    avelength_divorce_docket_volume := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_docket_volume)),h.divorce_docket_volume<>(typeof(h.divorce_docket_volume))'');
    populated_divorce_filing_number_cnt := COUNT(GROUP,h.divorce_filing_number <> (TYPEOF(h.divorce_filing_number))'');
    populated_divorce_filing_number_pcnt := AVE(GROUP,IF(h.divorce_filing_number = (TYPEOF(h.divorce_filing_number))'',0,100));
    maxlength_divorce_filing_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_filing_number)));
    avelength_divorce_filing_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_filing_number)),h.divorce_filing_number<>(typeof(h.divorce_filing_number))'');
    populated_divorce_city_cnt := COUNT(GROUP,h.divorce_city <> (TYPEOF(h.divorce_city))'');
    populated_divorce_city_pcnt := AVE(GROUP,IF(h.divorce_city = (TYPEOF(h.divorce_city))'',0,100));
    maxlength_divorce_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_city)));
    avelength_divorce_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_city)),h.divorce_city<>(typeof(h.divorce_city))'');
    populated_divorce_county_cnt := COUNT(GROUP,h.divorce_county <> (TYPEOF(h.divorce_county))'');
    populated_divorce_county_pcnt := AVE(GROUP,IF(h.divorce_county = (TYPEOF(h.divorce_county))'',0,100));
    maxlength_divorce_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_county)));
    avelength_divorce_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.divorce_county)),h.divorce_county<>(typeof(h.divorce_county))'');
    populated_grounds_for_divorce_cnt := COUNT(GROUP,h.grounds_for_divorce <> (TYPEOF(h.grounds_for_divorce))'');
    populated_grounds_for_divorce_pcnt := AVE(GROUP,IF(h.grounds_for_divorce = (TYPEOF(h.grounds_for_divorce))'',0,100));
    maxlength_grounds_for_divorce := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.grounds_for_divorce)));
    avelength_grounds_for_divorce := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.grounds_for_divorce)),h.grounds_for_divorce<>(typeof(h.grounds_for_divorce))'');
    populated_marriage_duration_cd_cnt := COUNT(GROUP,h.marriage_duration_cd <> (TYPEOF(h.marriage_duration_cd))'');
    populated_marriage_duration_cd_pcnt := AVE(GROUP,IF(h.marriage_duration_cd = (TYPEOF(h.marriage_duration_cd))'',0,100));
    maxlength_marriage_duration_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_duration_cd)));
    avelength_marriage_duration_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_duration_cd)),h.marriage_duration_cd<>(typeof(h.marriage_duration_cd))'');
    populated_marriage_duration_cnt := COUNT(GROUP,h.marriage_duration <> (TYPEOF(h.marriage_duration))'');
    populated_marriage_duration_pcnt := AVE(GROUP,IF(h.marriage_duration = (TYPEOF(h.marriage_duration))'',0,100));
    maxlength_marriage_duration := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_duration)));
    avelength_marriage_duration := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriage_duration)),h.marriage_duration<>(typeof(h.marriage_duration))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_filing_subtype_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_party1_type_pcnt *   0.00 / 100 + T.Populated_party1_name_format_pcnt *   0.00 / 100 + T.Populated_party1_name_pcnt *   0.00 / 100 + T.Populated_party1_alias_pcnt *   0.00 / 100 + T.Populated_party1_dob_pcnt *   0.00 / 100 + T.Populated_party1_birth_state_pcnt *   0.00 / 100 + T.Populated_party1_age_pcnt *   0.00 / 100 + T.Populated_party1_race_pcnt *   0.00 / 100 + T.Populated_party1_addr1_pcnt *   0.00 / 100 + T.Populated_party1_csz_pcnt *   0.00 / 100 + T.Populated_party1_county_pcnt *   0.00 / 100 + T.Populated_party1_previous_marital_status_pcnt *   0.00 / 100 + T.Populated_party1_how_marriage_ended_pcnt *   0.00 / 100 + T.Populated_party1_times_married_pcnt *   0.00 / 100 + T.Populated_party1_last_marriage_end_dt_pcnt *   0.00 / 100 + T.Populated_party2_type_pcnt *   0.00 / 100 + T.Populated_party2_name_format_pcnt *   0.00 / 100 + T.Populated_party2_name_pcnt *   0.00 / 100 + T.Populated_party2_alias_pcnt *   0.00 / 100 + T.Populated_party2_dob_pcnt *   0.00 / 100 + T.Populated_party2_birth_state_pcnt *   0.00 / 100 + T.Populated_party2_age_pcnt *   0.00 / 100 + T.Populated_party2_race_pcnt *   0.00 / 100 + T.Populated_party2_addr1_pcnt *   0.00 / 100 + T.Populated_party2_csz_pcnt *   0.00 / 100 + T.Populated_party2_county_pcnt *   0.00 / 100 + T.Populated_party2_previous_marital_status_pcnt *   0.00 / 100 + T.Populated_party2_how_marriage_ended_pcnt *   0.00 / 100 + T.Populated_party2_times_married_pcnt *   0.00 / 100 + T.Populated_party2_last_marriage_end_dt_pcnt *   0.00 / 100 + T.Populated_number_of_children_pcnt *   0.00 / 100 + T.Populated_marriage_filing_dt_pcnt *   0.00 / 100 + T.Populated_marriage_dt_pcnt *   0.00 / 100 + T.Populated_marriage_city_pcnt *   0.00 / 100 + T.Populated_marriage_county_pcnt *   0.00 / 100 + T.Populated_place_of_marriage_pcnt *   0.00 / 100 + T.Populated_type_of_ceremony_pcnt *   0.00 / 100 + T.Populated_marriage_filing_number_pcnt *   0.00 / 100 + T.Populated_marriage_docket_volume_pcnt *   0.00 / 100 + T.Populated_divorce_filing_dt_pcnt *   0.00 / 100 + T.Populated_divorce_dt_pcnt *   0.00 / 100 + T.Populated_divorce_docket_volume_pcnt *   0.00 / 100 + T.Populated_divorce_filing_number_pcnt *   0.00 / 100 + T.Populated_divorce_city_pcnt *   0.00 / 100 + T.Populated_divorce_county_pcnt *   0.00 / 100 + T.Populated_grounds_for_divorce_pcnt *   0.00 / 100 + T.Populated_marriage_duration_cd_pcnt *   0.00 / 100 + T.Populated_marriage_duration_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_id','filing_type','filing_subtype','vendor','source_file','process_date','state_origin','party1_type','party1_name_format','party1_name','party1_alias','party1_dob','party1_birth_state','party1_age','party1_race','party1_addr1','party1_csz','party1_county','party1_previous_marital_status','party1_how_marriage_ended','party1_times_married','party1_last_marriage_end_dt','party2_type','party2_name_format','party2_name','party2_alias','party2_dob','party2_birth_state','party2_age','party2_race','party2_addr1','party2_csz','party2_county','party2_previous_marital_status','party2_how_marriage_ended','party2_times_married','party2_last_marriage_end_dt','number_of_children','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','place_of_marriage','type_of_ceremony','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','grounds_for_divorce','marriage_duration_cd','marriage_duration','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_record_id_pcnt,le.populated_filing_type_pcnt,le.populated_filing_subtype_pcnt,le.populated_vendor_pcnt,le.populated_source_file_pcnt,le.populated_process_date_pcnt,le.populated_state_origin_pcnt,le.populated_party1_type_pcnt,le.populated_party1_name_format_pcnt,le.populated_party1_name_pcnt,le.populated_party1_alias_pcnt,le.populated_party1_dob_pcnt,le.populated_party1_birth_state_pcnt,le.populated_party1_age_pcnt,le.populated_party1_race_pcnt,le.populated_party1_addr1_pcnt,le.populated_party1_csz_pcnt,le.populated_party1_county_pcnt,le.populated_party1_previous_marital_status_pcnt,le.populated_party1_how_marriage_ended_pcnt,le.populated_party1_times_married_pcnt,le.populated_party1_last_marriage_end_dt_pcnt,le.populated_party2_type_pcnt,le.populated_party2_name_format_pcnt,le.populated_party2_name_pcnt,le.populated_party2_alias_pcnt,le.populated_party2_dob_pcnt,le.populated_party2_birth_state_pcnt,le.populated_party2_age_pcnt,le.populated_party2_race_pcnt,le.populated_party2_addr1_pcnt,le.populated_party2_csz_pcnt,le.populated_party2_county_pcnt,le.populated_party2_previous_marital_status_pcnt,le.populated_party2_how_marriage_ended_pcnt,le.populated_party2_times_married_pcnt,le.populated_party2_last_marriage_end_dt_pcnt,le.populated_number_of_children_pcnt,le.populated_marriage_filing_dt_pcnt,le.populated_marriage_dt_pcnt,le.populated_marriage_city_pcnt,le.populated_marriage_county_pcnt,le.populated_place_of_marriage_pcnt,le.populated_type_of_ceremony_pcnt,le.populated_marriage_filing_number_pcnt,le.populated_marriage_docket_volume_pcnt,le.populated_divorce_filing_dt_pcnt,le.populated_divorce_dt_pcnt,le.populated_divorce_docket_volume_pcnt,le.populated_divorce_filing_number_pcnt,le.populated_divorce_city_pcnt,le.populated_divorce_county_pcnt,le.populated_grounds_for_divorce_pcnt,le.populated_marriage_duration_cd_pcnt,le.populated_marriage_duration_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_record_id,le.maxlength_filing_type,le.maxlength_filing_subtype,le.maxlength_vendor,le.maxlength_source_file,le.maxlength_process_date,le.maxlength_state_origin,le.maxlength_party1_type,le.maxlength_party1_name_format,le.maxlength_party1_name,le.maxlength_party1_alias,le.maxlength_party1_dob,le.maxlength_party1_birth_state,le.maxlength_party1_age,le.maxlength_party1_race,le.maxlength_party1_addr1,le.maxlength_party1_csz,le.maxlength_party1_county,le.maxlength_party1_previous_marital_status,le.maxlength_party1_how_marriage_ended,le.maxlength_party1_times_married,le.maxlength_party1_last_marriage_end_dt,le.maxlength_party2_type,le.maxlength_party2_name_format,le.maxlength_party2_name,le.maxlength_party2_alias,le.maxlength_party2_dob,le.maxlength_party2_birth_state,le.maxlength_party2_age,le.maxlength_party2_race,le.maxlength_party2_addr1,le.maxlength_party2_csz,le.maxlength_party2_county,le.maxlength_party2_previous_marital_status,le.maxlength_party2_how_marriage_ended,le.maxlength_party2_times_married,le.maxlength_party2_last_marriage_end_dt,le.maxlength_number_of_children,le.maxlength_marriage_filing_dt,le.maxlength_marriage_dt,le.maxlength_marriage_city,le.maxlength_marriage_county,le.maxlength_place_of_marriage,le.maxlength_type_of_ceremony,le.maxlength_marriage_filing_number,le.maxlength_marriage_docket_volume,le.maxlength_divorce_filing_dt,le.maxlength_divorce_dt,le.maxlength_divorce_docket_volume,le.maxlength_divorce_filing_number,le.maxlength_divorce_city,le.maxlength_divorce_county,le.maxlength_grounds_for_divorce,le.maxlength_marriage_duration_cd,le.maxlength_marriage_duration,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_record_id,le.avelength_filing_type,le.avelength_filing_subtype,le.avelength_vendor,le.avelength_source_file,le.avelength_process_date,le.avelength_state_origin,le.avelength_party1_type,le.avelength_party1_name_format,le.avelength_party1_name,le.avelength_party1_alias,le.avelength_party1_dob,le.avelength_party1_birth_state,le.avelength_party1_age,le.avelength_party1_race,le.avelength_party1_addr1,le.avelength_party1_csz,le.avelength_party1_county,le.avelength_party1_previous_marital_status,le.avelength_party1_how_marriage_ended,le.avelength_party1_times_married,le.avelength_party1_last_marriage_end_dt,le.avelength_party2_type,le.avelength_party2_name_format,le.avelength_party2_name,le.avelength_party2_alias,le.avelength_party2_dob,le.avelength_party2_birth_state,le.avelength_party2_age,le.avelength_party2_race,le.avelength_party2_addr1,le.avelength_party2_csz,le.avelength_party2_county,le.avelength_party2_previous_marital_status,le.avelength_party2_how_marriage_ended,le.avelength_party2_times_married,le.avelength_party2_last_marriage_end_dt,le.avelength_number_of_children,le.avelength_marriage_filing_dt,le.avelength_marriage_dt,le.avelength_marriage_city,le.avelength_marriage_county,le.avelength_place_of_marriage,le.avelength_type_of_ceremony,le.avelength_marriage_filing_number,le.avelength_marriage_docket_volume,le.avelength_divorce_filing_dt,le.avelength_divorce_dt,le.avelength_divorce_docket_volume,le.avelength_divorce_filing_number,le.avelength_divorce_city,le.avelength_divorce_county,le.avelength_grounds_for_divorce,le.avelength_marriage_duration_cd,le.avelength_marriage_duration,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 60, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.record_id <> 0,TRIM((SALT311.StrType)le.record_id), ''),TRIM((SALT311.StrType)le.filing_type),TRIM((SALT311.StrType)le.filing_subtype),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.party1_type),TRIM((SALT311.StrType)le.party1_name_format),TRIM((SALT311.StrType)le.party1_name),TRIM((SALT311.StrType)le.party1_alias),TRIM((SALT311.StrType)le.party1_dob),TRIM((SALT311.StrType)le.party1_birth_state),TRIM((SALT311.StrType)le.party1_age),TRIM((SALT311.StrType)le.party1_race),TRIM((SALT311.StrType)le.party1_addr1),TRIM((SALT311.StrType)le.party1_csz),TRIM((SALT311.StrType)le.party1_county),TRIM((SALT311.StrType)le.party1_previous_marital_status),TRIM((SALT311.StrType)le.party1_how_marriage_ended),TRIM((SALT311.StrType)le.party1_times_married),TRIM((SALT311.StrType)le.party1_last_marriage_end_dt),TRIM((SALT311.StrType)le.party2_type),TRIM((SALT311.StrType)le.party2_name_format),TRIM((SALT311.StrType)le.party2_name),TRIM((SALT311.StrType)le.party2_alias),TRIM((SALT311.StrType)le.party2_dob),TRIM((SALT311.StrType)le.party2_birth_state),TRIM((SALT311.StrType)le.party2_age),TRIM((SALT311.StrType)le.party2_race),TRIM((SALT311.StrType)le.party2_addr1),TRIM((SALT311.StrType)le.party2_csz),TRIM((SALT311.StrType)le.party2_county),TRIM((SALT311.StrType)le.party2_previous_marital_status),TRIM((SALT311.StrType)le.party2_how_marriage_ended),TRIM((SALT311.StrType)le.party2_times_married),TRIM((SALT311.StrType)le.party2_last_marriage_end_dt),TRIM((SALT311.StrType)le.number_of_children),TRIM((SALT311.StrType)le.marriage_filing_dt),TRIM((SALT311.StrType)le.marriage_dt),TRIM((SALT311.StrType)le.marriage_city),TRIM((SALT311.StrType)le.marriage_county),TRIM((SALT311.StrType)le.place_of_marriage),TRIM((SALT311.StrType)le.type_of_ceremony),TRIM((SALT311.StrType)le.marriage_filing_number),TRIM((SALT311.StrType)le.marriage_docket_volume),TRIM((SALT311.StrType)le.divorce_filing_dt),TRIM((SALT311.StrType)le.divorce_dt),TRIM((SALT311.StrType)le.divorce_docket_volume),TRIM((SALT311.StrType)le.divorce_filing_number),TRIM((SALT311.StrType)le.divorce_city),TRIM((SALT311.StrType)le.divorce_county),TRIM((SALT311.StrType)le.grounds_for_divorce),TRIM((SALT311.StrType)le.marriage_duration_cd),TRIM((SALT311.StrType)le.marriage_duration),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,60,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 60);
  SELF.FldNo2 := 1 + (C % 60);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.record_id <> 0,TRIM((SALT311.StrType)le.record_id), ''),TRIM((SALT311.StrType)le.filing_type),TRIM((SALT311.StrType)le.filing_subtype),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.party1_type),TRIM((SALT311.StrType)le.party1_name_format),TRIM((SALT311.StrType)le.party1_name),TRIM((SALT311.StrType)le.party1_alias),TRIM((SALT311.StrType)le.party1_dob),TRIM((SALT311.StrType)le.party1_birth_state),TRIM((SALT311.StrType)le.party1_age),TRIM((SALT311.StrType)le.party1_race),TRIM((SALT311.StrType)le.party1_addr1),TRIM((SALT311.StrType)le.party1_csz),TRIM((SALT311.StrType)le.party1_county),TRIM((SALT311.StrType)le.party1_previous_marital_status),TRIM((SALT311.StrType)le.party1_how_marriage_ended),TRIM((SALT311.StrType)le.party1_times_married),TRIM((SALT311.StrType)le.party1_last_marriage_end_dt),TRIM((SALT311.StrType)le.party2_type),TRIM((SALT311.StrType)le.party2_name_format),TRIM((SALT311.StrType)le.party2_name),TRIM((SALT311.StrType)le.party2_alias),TRIM((SALT311.StrType)le.party2_dob),TRIM((SALT311.StrType)le.party2_birth_state),TRIM((SALT311.StrType)le.party2_age),TRIM((SALT311.StrType)le.party2_race),TRIM((SALT311.StrType)le.party2_addr1),TRIM((SALT311.StrType)le.party2_csz),TRIM((SALT311.StrType)le.party2_county),TRIM((SALT311.StrType)le.party2_previous_marital_status),TRIM((SALT311.StrType)le.party2_how_marriage_ended),TRIM((SALT311.StrType)le.party2_times_married),TRIM((SALT311.StrType)le.party2_last_marriage_end_dt),TRIM((SALT311.StrType)le.number_of_children),TRIM((SALT311.StrType)le.marriage_filing_dt),TRIM((SALT311.StrType)le.marriage_dt),TRIM((SALT311.StrType)le.marriage_city),TRIM((SALT311.StrType)le.marriage_county),TRIM((SALT311.StrType)le.place_of_marriage),TRIM((SALT311.StrType)le.type_of_ceremony),TRIM((SALT311.StrType)le.marriage_filing_number),TRIM((SALT311.StrType)le.marriage_docket_volume),TRIM((SALT311.StrType)le.divorce_filing_dt),TRIM((SALT311.StrType)le.divorce_dt),TRIM((SALT311.StrType)le.divorce_docket_volume),TRIM((SALT311.StrType)le.divorce_filing_number),TRIM((SALT311.StrType)le.divorce_city),TRIM((SALT311.StrType)le.divorce_county),TRIM((SALT311.StrType)le.grounds_for_divorce),TRIM((SALT311.StrType)le.marriage_duration_cd),TRIM((SALT311.StrType)le.marriage_duration),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.record_id <> 0,TRIM((SALT311.StrType)le.record_id), ''),TRIM((SALT311.StrType)le.filing_type),TRIM((SALT311.StrType)le.filing_subtype),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.source_file),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.party1_type),TRIM((SALT311.StrType)le.party1_name_format),TRIM((SALT311.StrType)le.party1_name),TRIM((SALT311.StrType)le.party1_alias),TRIM((SALT311.StrType)le.party1_dob),TRIM((SALT311.StrType)le.party1_birth_state),TRIM((SALT311.StrType)le.party1_age),TRIM((SALT311.StrType)le.party1_race),TRIM((SALT311.StrType)le.party1_addr1),TRIM((SALT311.StrType)le.party1_csz),TRIM((SALT311.StrType)le.party1_county),TRIM((SALT311.StrType)le.party1_previous_marital_status),TRIM((SALT311.StrType)le.party1_how_marriage_ended),TRIM((SALT311.StrType)le.party1_times_married),TRIM((SALT311.StrType)le.party1_last_marriage_end_dt),TRIM((SALT311.StrType)le.party2_type),TRIM((SALT311.StrType)le.party2_name_format),TRIM((SALT311.StrType)le.party2_name),TRIM((SALT311.StrType)le.party2_alias),TRIM((SALT311.StrType)le.party2_dob),TRIM((SALT311.StrType)le.party2_birth_state),TRIM((SALT311.StrType)le.party2_age),TRIM((SALT311.StrType)le.party2_race),TRIM((SALT311.StrType)le.party2_addr1),TRIM((SALT311.StrType)le.party2_csz),TRIM((SALT311.StrType)le.party2_county),TRIM((SALT311.StrType)le.party2_previous_marital_status),TRIM((SALT311.StrType)le.party2_how_marriage_ended),TRIM((SALT311.StrType)le.party2_times_married),TRIM((SALT311.StrType)le.party2_last_marriage_end_dt),TRIM((SALT311.StrType)le.number_of_children),TRIM((SALT311.StrType)le.marriage_filing_dt),TRIM((SALT311.StrType)le.marriage_dt),TRIM((SALT311.StrType)le.marriage_city),TRIM((SALT311.StrType)le.marriage_county),TRIM((SALT311.StrType)le.place_of_marriage),TRIM((SALT311.StrType)le.type_of_ceremony),TRIM((SALT311.StrType)le.marriage_filing_number),TRIM((SALT311.StrType)le.marriage_docket_volume),TRIM((SALT311.StrType)le.divorce_filing_dt),TRIM((SALT311.StrType)le.divorce_dt),TRIM((SALT311.StrType)le.divorce_docket_volume),TRIM((SALT311.StrType)le.divorce_filing_number),TRIM((SALT311.StrType)le.divorce_city),TRIM((SALT311.StrType)le.divorce_county),TRIM((SALT311.StrType)le.grounds_for_divorce),TRIM((SALT311.StrType)le.marriage_duration_cd),TRIM((SALT311.StrType)le.marriage_duration),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),60*60,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'record_id'}
      ,{6,'filing_type'}
      ,{7,'filing_subtype'}
      ,{8,'vendor'}
      ,{9,'source_file'}
      ,{10,'process_date'}
      ,{11,'state_origin'}
      ,{12,'party1_type'}
      ,{13,'party1_name_format'}
      ,{14,'party1_name'}
      ,{15,'party1_alias'}
      ,{16,'party1_dob'}
      ,{17,'party1_birth_state'}
      ,{18,'party1_age'}
      ,{19,'party1_race'}
      ,{20,'party1_addr1'}
      ,{21,'party1_csz'}
      ,{22,'party1_county'}
      ,{23,'party1_previous_marital_status'}
      ,{24,'party1_how_marriage_ended'}
      ,{25,'party1_times_married'}
      ,{26,'party1_last_marriage_end_dt'}
      ,{27,'party2_type'}
      ,{28,'party2_name_format'}
      ,{29,'party2_name'}
      ,{30,'party2_alias'}
      ,{31,'party2_dob'}
      ,{32,'party2_birth_state'}
      ,{33,'party2_age'}
      ,{34,'party2_race'}
      ,{35,'party2_addr1'}
      ,{36,'party2_csz'}
      ,{37,'party2_county'}
      ,{38,'party2_previous_marital_status'}
      ,{39,'party2_how_marriage_ended'}
      ,{40,'party2_times_married'}
      ,{41,'party2_last_marriage_end_dt'}
      ,{42,'number_of_children'}
      ,{43,'marriage_filing_dt'}
      ,{44,'marriage_dt'}
      ,{45,'marriage_city'}
      ,{46,'marriage_county'}
      ,{47,'place_of_marriage'}
      ,{48,'type_of_ceremony'}
      ,{49,'marriage_filing_number'}
      ,{50,'marriage_docket_volume'}
      ,{51,'divorce_filing_dt'}
      ,{52,'divorce_dt'}
      ,{53,'divorce_docket_volume'}
      ,{54,'divorce_filing_number'}
      ,{55,'divorce_city'}
      ,{56,'divorce_county'}
      ,{57,'grounds_for_divorce'}
      ,{58,'marriage_duration_cd'}
      ,{59,'marriage_duration'}
      ,{60,'persistent_record_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_record_id((SALT311.StrType)le.record_id),
    Fields.InValid_filing_type((SALT311.StrType)le.filing_type),
    Fields.InValid_filing_subtype((SALT311.StrType)le.filing_subtype),
    Fields.InValid_vendor((SALT311.StrType)le.vendor),
    Fields.InValid_source_file((SALT311.StrType)le.source_file),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    Fields.InValid_party1_type((SALT311.StrType)le.party1_type),
    Fields.InValid_party1_name_format((SALT311.StrType)le.party1_name_format),
    Fields.InValid_party1_name((SALT311.StrType)le.party1_name),
    Fields.InValid_party1_alias((SALT311.StrType)le.party1_alias),
    Fields.InValid_party1_dob((SALT311.StrType)le.party1_dob),
    Fields.InValid_party1_birth_state((SALT311.StrType)le.party1_birth_state),
    Fields.InValid_party1_age((SALT311.StrType)le.party1_age),
    Fields.InValid_party1_race((SALT311.StrType)le.party1_race),
    Fields.InValid_party1_addr1((SALT311.StrType)le.party1_addr1),
    Fields.InValid_party1_csz((SALT311.StrType)le.party1_csz),
    Fields.InValid_party1_county((SALT311.StrType)le.party1_county),
    Fields.InValid_party1_previous_marital_status((SALT311.StrType)le.party1_previous_marital_status),
    Fields.InValid_party1_how_marriage_ended((SALT311.StrType)le.party1_how_marriage_ended),
    Fields.InValid_party1_times_married((SALT311.StrType)le.party1_times_married),
    Fields.InValid_party1_last_marriage_end_dt((SALT311.StrType)le.party1_last_marriage_end_dt),
    Fields.InValid_party2_type((SALT311.StrType)le.party2_type),
    Fields.InValid_party2_name_format((SALT311.StrType)le.party2_name_format),
    Fields.InValid_party2_name((SALT311.StrType)le.party2_name),
    Fields.InValid_party2_alias((SALT311.StrType)le.party2_alias),
    Fields.InValid_party2_dob((SALT311.StrType)le.party2_dob),
    Fields.InValid_party2_birth_state((SALT311.StrType)le.party2_birth_state),
    Fields.InValid_party2_age((SALT311.StrType)le.party2_age),
    Fields.InValid_party2_race((SALT311.StrType)le.party2_race),
    Fields.InValid_party2_addr1((SALT311.StrType)le.party2_addr1),
    Fields.InValid_party2_csz((SALT311.StrType)le.party2_csz),
    Fields.InValid_party2_county((SALT311.StrType)le.party2_county),
    Fields.InValid_party2_previous_marital_status((SALT311.StrType)le.party2_previous_marital_status),
    Fields.InValid_party2_how_marriage_ended((SALT311.StrType)le.party2_how_marriage_ended),
    Fields.InValid_party2_times_married((SALT311.StrType)le.party2_times_married),
    Fields.InValid_party2_last_marriage_end_dt((SALT311.StrType)le.party2_last_marriage_end_dt),
    Fields.InValid_number_of_children((SALT311.StrType)le.number_of_children),
    Fields.InValid_marriage_filing_dt((SALT311.StrType)le.marriage_filing_dt),
    Fields.InValid_marriage_dt((SALT311.StrType)le.marriage_dt),
    Fields.InValid_marriage_city((SALT311.StrType)le.marriage_city),
    Fields.InValid_marriage_county((SALT311.StrType)le.marriage_county),
    Fields.InValid_place_of_marriage((SALT311.StrType)le.place_of_marriage),
    Fields.InValid_type_of_ceremony((SALT311.StrType)le.type_of_ceremony),
    Fields.InValid_marriage_filing_number((SALT311.StrType)le.marriage_filing_number),
    Fields.InValid_marriage_docket_volume((SALT311.StrType)le.marriage_docket_volume),
    Fields.InValid_divorce_filing_dt((SALT311.StrType)le.divorce_filing_dt),
    Fields.InValid_divorce_dt((SALT311.StrType)le.divorce_dt),
    Fields.InValid_divorce_docket_volume((SALT311.StrType)le.divorce_docket_volume),
    Fields.InValid_divorce_filing_number((SALT311.StrType)le.divorce_filing_number),
    Fields.InValid_divorce_city((SALT311.StrType)le.divorce_city),
    Fields.InValid_divorce_county((SALT311.StrType)le.divorce_county),
    Fields.InValid_grounds_for_divorce((SALT311.StrType)le.grounds_for_divorce),
    Fields.InValid_marriage_duration_cd((SALT311.StrType)le.marriage_duration_cd),
    Fields.InValid_marriage_duration((SALT311.StrType)le.marriage_duration),
    Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,60,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_Num','invalid_filing_type','Unknown','invalid_vendor','invalid_source_file','invalid_date','invalid_state','invalid_party_type','invalid_name_format','invalid_name','invalid_name','invalid_date','invalid_state','Unknown','invalid_race','invalid_address','Unknown','invalid_county','Unknown','Unknown','Unknown','invalid_date','invalid_party_type','invalid_name_format','invalid_name','Unknown','invalid_date','invalid_state','Unknown','Unknown','invalid_address','Unknown','invalid_county','Unknown','Unknown','Unknown','invalid_date','Unknown','invalid_date','invalid_date','invalid_city','invalid_county','Unknown','Unknown','invalid_filing_number','invalid_docket_volume','invalid_date','invalid_date','invalid_docket_volume','invalid_filing_number','invalid_city','invalid_county','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),Fields.InValidMessage_filing_subtype(TotalErrors.ErrorNum),Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_party1_type(TotalErrors.ErrorNum),Fields.InValidMessage_party1_name_format(TotalErrors.ErrorNum),Fields.InValidMessage_party1_name(TotalErrors.ErrorNum),Fields.InValidMessage_party1_alias(TotalErrors.ErrorNum),Fields.InValidMessage_party1_dob(TotalErrors.ErrorNum),Fields.InValidMessage_party1_birth_state(TotalErrors.ErrorNum),Fields.InValidMessage_party1_age(TotalErrors.ErrorNum),Fields.InValidMessage_party1_race(TotalErrors.ErrorNum),Fields.InValidMessage_party1_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_party1_csz(TotalErrors.ErrorNum),Fields.InValidMessage_party1_county(TotalErrors.ErrorNum),Fields.InValidMessage_party1_previous_marital_status(TotalErrors.ErrorNum),Fields.InValidMessage_party1_how_marriage_ended(TotalErrors.ErrorNum),Fields.InValidMessage_party1_times_married(TotalErrors.ErrorNum),Fields.InValidMessage_party1_last_marriage_end_dt(TotalErrors.ErrorNum),Fields.InValidMessage_party2_type(TotalErrors.ErrorNum),Fields.InValidMessage_party2_name_format(TotalErrors.ErrorNum),Fields.InValidMessage_party2_name(TotalErrors.ErrorNum),Fields.InValidMessage_party2_alias(TotalErrors.ErrorNum),Fields.InValidMessage_party2_dob(TotalErrors.ErrorNum),Fields.InValidMessage_party2_birth_state(TotalErrors.ErrorNum),Fields.InValidMessage_party2_age(TotalErrors.ErrorNum),Fields.InValidMessage_party2_race(TotalErrors.ErrorNum),Fields.InValidMessage_party2_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_party2_csz(TotalErrors.ErrorNum),Fields.InValidMessage_party2_county(TotalErrors.ErrorNum),Fields.InValidMessage_party2_previous_marital_status(TotalErrors.ErrorNum),Fields.InValidMessage_party2_how_marriage_ended(TotalErrors.ErrorNum),Fields.InValidMessage_party2_times_married(TotalErrors.ErrorNum),Fields.InValidMessage_party2_last_marriage_end_dt(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_children(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_filing_dt(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_dt(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_city(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_county(TotalErrors.ErrorNum),Fields.InValidMessage_place_of_marriage(TotalErrors.ErrorNum),Fields.InValidMessage_type_of_ceremony(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_filing_number(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_docket_volume(TotalErrors.ErrorNum),Fields.InValidMessage_divorce_filing_dt(TotalErrors.ErrorNum),Fields.InValidMessage_divorce_dt(TotalErrors.ErrorNum),Fields.InValidMessage_divorce_docket_volume(TotalErrors.ErrorNum),Fields.InValidMessage_divorce_filing_number(TotalErrors.ErrorNum),Fields.InValidMessage_divorce_city(TotalErrors.ErrorNum),Fields.InValidMessage_divorce_county(TotalErrors.ErrorNum),Fields.InValidMessage_grounds_for_divorce(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_duration_cd(TotalErrors.ErrorNum),Fields.InValidMessage_marriage_duration(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Marriage_Divorce_V2, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
