IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_name_prefix_pcnt := AVE(GROUP,IF(h.name_prefix = (TYPEOF(h.name_prefix))'',0,100));
    maxlength_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_prefix)));
    avelength_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_prefix)),h.name_prefix<>(typeof(h.name_prefix))'');
    populated_name_suffix__pcnt := AVE(GROUP,IF(h.name_suffix_ = (TYPEOF(h.name_suffix_))'',0,100));
    maxlength_name_suffix_ := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix_)));
    avelength_name_suffix_ := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix_)),h.name_suffix_<>(typeof(h.name_suffix_))'');
    populated_perm_id_pcnt := AVE(GROUP,IF(h.perm_id = (TYPEOF(h.perm_id))'',0,100));
    maxlength_perm_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.perm_id)));
    avelength_perm_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.perm_id)),h.perm_id<>(typeof(h.perm_id))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_aka1_pcnt := AVE(GROUP,IF(h.aka1 = (TYPEOF(h.aka1))'',0,100));
    maxlength_aka1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.aka1)));
    avelength_aka1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.aka1)),h.aka1<>(typeof(h.aka1))'');
    populated_aka2_pcnt := AVE(GROUP,IF(h.aka2 = (TYPEOF(h.aka2))'',0,100));
    maxlength_aka2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.aka2)));
    avelength_aka2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.aka2)),h.aka2<>(typeof(h.aka2))'');
    populated_aka3_pcnt := AVE(GROUP,IF(h.aka3 = (TYPEOF(h.aka3))'',0,100));
    maxlength_aka3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.aka3)));
    avelength_aka3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.aka3)),h.aka3<>(typeof(h.aka3))'');
    populated_new_subject_flag_pcnt := AVE(GROUP,IF(h.new_subject_flag = (TYPEOF(h.new_subject_flag))'',0,100));
    maxlength_new_subject_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.new_subject_flag)));
    avelength_new_subject_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.new_subject_flag)),h.new_subject_flag<>(typeof(h.new_subject_flag))'');
    populated_name_change_flag_pcnt := AVE(GROUP,IF(h.name_change_flag = (TYPEOF(h.name_change_flag))'',0,100));
    maxlength_name_change_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_change_flag)));
    avelength_name_change_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_change_flag)),h.name_change_flag<>(typeof(h.name_change_flag))'');
    populated_address_change_flag_pcnt := AVE(GROUP,IF(h.address_change_flag = (TYPEOF(h.address_change_flag))'',0,100));
    maxlength_address_change_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address_change_flag)));
    avelength_address_change_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address_change_flag)),h.address_change_flag<>(typeof(h.address_change_flag))'');
    populated_ssn_change_flag_pcnt := AVE(GROUP,IF(h.ssn_change_flag = (TYPEOF(h.ssn_change_flag))'',0,100));
    maxlength_ssn_change_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.ssn_change_flag)));
    avelength_ssn_change_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.ssn_change_flag)),h.ssn_change_flag<>(typeof(h.ssn_change_flag))'');
    populated_file_since_date_change_flag_pcnt := AVE(GROUP,IF(h.file_since_date_change_flag = (TYPEOF(h.file_since_date_change_flag))'',0,100));
    maxlength_file_since_date_change_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.file_since_date_change_flag)));
    avelength_file_since_date_change_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.file_since_date_change_flag)),h.file_since_date_change_flag<>(typeof(h.file_since_date_change_flag))'');
    populated_deceased_indicator_flag_pcnt := AVE(GROUP,IF(h.deceased_indicator_flag = (TYPEOF(h.deceased_indicator_flag))'',0,100));
    maxlength_deceased_indicator_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.deceased_indicator_flag)));
    avelength_deceased_indicator_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.deceased_indicator_flag)),h.deceased_indicator_flag<>(typeof(h.deceased_indicator_flag))'');
    populated_dob_change_flag_pcnt := AVE(GROUP,IF(h.dob_change_flag = (TYPEOF(h.dob_change_flag))'',0,100));
    maxlength_dob_change_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dob_change_flag)));
    avelength_dob_change_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dob_change_flag)),h.dob_change_flag<>(typeof(h.dob_change_flag))'');
    populated_phone_change_flag_pcnt := AVE(GROUP,IF(h.phone_change_flag = (TYPEOF(h.phone_change_flag))'',0,100));
    maxlength_phone_change_flag := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone_change_flag)));
    avelength_phone_change_flag := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone_change_flag)),h.phone_change_flag<>(typeof(h.phone_change_flag))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_mfdu_indicator_pcnt := AVE(GROUP,IF(h.mfdu_indicator = (TYPEOF(h.mfdu_indicator))'',0,100));
    maxlength_mfdu_indicator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.mfdu_indicator)));
    avelength_mfdu_indicator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.mfdu_indicator)),h.mfdu_indicator<>(typeof(h.mfdu_indicator))'');
    populated_file_since_date_pcnt := AVE(GROUP,IF(h.file_since_date = (TYPEOF(h.file_since_date))'',0,100));
    maxlength_file_since_date := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.file_since_date)));
    avelength_file_since_date := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.file_since_date)),h.file_since_date<>(typeof(h.file_since_date))'');
    populated_house_number_pcnt := AVE(GROUP,IF(h.house_number = (TYPEOF(h.house_number))'',0,100));
    maxlength_house_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.house_number)));
    avelength_house_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.house_number)),h.house_number<>(typeof(h.house_number))'');
    populated_street_direction_pcnt := AVE(GROUP,IF(h.street_direction = (TYPEOF(h.street_direction))'',0,100));
    maxlength_street_direction := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_direction)));
    avelength_street_direction := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_direction)),h.street_direction<>(typeof(h.street_direction))'');
    populated_street_name_pcnt := AVE(GROUP,IF(h.street_name = (TYPEOF(h.street_name))'',0,100));
    maxlength_street_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_name)));
    avelength_street_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_name)),h.street_name<>(typeof(h.street_name))'');
    populated_street_type_pcnt := AVE(GROUP,IF(h.street_type = (TYPEOF(h.street_type))'',0,100));
    maxlength_street_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_type)));
    avelength_street_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_type)),h.street_type<>(typeof(h.street_type))'');
    populated_street_post_direction_pcnt := AVE(GROUP,IF(h.street_post_direction = (TYPEOF(h.street_post_direction))'',0,100));
    maxlength_street_post_direction := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_post_direction)));
    avelength_street_post_direction := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.street_post_direction)),h.street_post_direction<>(typeof(h.street_post_direction))'');
    populated_unit_type_pcnt := AVE(GROUP,IF(h.unit_type = (TYPEOF(h.unit_type))'',0,100));
    maxlength_unit_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_type)));
    avelength_unit_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_type)),h.unit_type<>(typeof(h.unit_type))'');
    populated_unit_number_pcnt := AVE(GROUP,IF(h.unit_number = (TYPEOF(h.unit_number))'',0,100));
    maxlength_unit_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_number)));
    avelength_unit_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_number)),h.unit_number<>(typeof(h.unit_number))'');
    populated_cty_pcnt := AVE(GROUP,IF(h.cty = (TYPEOF(h.cty))'',0,100));
    maxlength_cty := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cty)));
    avelength_cty := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cty)),h.cty<>(typeof(h.cty))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_zp4_pcnt := AVE(GROUP,IF(h.zp4 = (TYPEOF(h.zp4))'',0,100));
    maxlength_zp4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zp4)));
    avelength_zp4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zp4)),h.zp4<>(typeof(h.zp4))'');
    populated_address_standardization_indicator_pcnt := AVE(GROUP,IF(h.address_standardization_indicator = (TYPEOF(h.address_standardization_indicator))'',0,100));
    maxlength_address_standardization_indicator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address_standardization_indicator)));
    avelength_address_standardization_indicator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address_standardization_indicator)),h.address_standardization_indicator<>(typeof(h.address_standardization_indicator))'');
    populated_date_address_reported_pcnt := AVE(GROUP,IF(h.date_address_reported = (TYPEOF(h.date_address_reported))'',0,100));
    maxlength_date_address_reported := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.date_address_reported)));
    avelength_date_address_reported := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.date_address_reported)),h.date_address_reported<>(typeof(h.date_address_reported))'');
    populated_party_id_pcnt := AVE(GROUP,IF(h.party_id = (TYPEOF(h.party_id))'',0,100));
    maxlength_party_id := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.party_id)));
    avelength_party_id := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.party_id)),h.party_id<>(typeof(h.party_id))'');
    populated_deceased_indicator_pcnt := AVE(GROUP,IF(h.deceased_indicator = (TYPEOF(h.deceased_indicator))'',0,100));
    maxlength_deceased_indicator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.deceased_indicator)));
    avelength_deceased_indicator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.deceased_indicator)),h.deceased_indicator<>(typeof(h.deceased_indicator))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_date_of_birth_estimated_ind_pcnt := AVE(GROUP,IF(h.date_of_birth_estimated_ind = (TYPEOF(h.date_of_birth_estimated_ind))'',0,100));
    maxlength_date_of_birth_estimated_ind := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.date_of_birth_estimated_ind)));
    avelength_date_of_birth_estimated_ind := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.date_of_birth_estimated_ind)),h.date_of_birth_estimated_ind<>(typeof(h.date_of_birth_estimated_ind))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_filler3_pcnt := AVE(GROUP,IF(h.filler3 = (TYPEOF(h.filler3))'',0,100));
    maxlength_filler3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.filler3)));
    avelength_filler3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.filler3)),h.filler3<>(typeof(h.filler3))'');
    populated_prepped_name_pcnt := AVE(GROUP,IF(h.prepped_name = (TYPEOF(h.prepped_name))'',0,100));
    maxlength_prepped_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_name)));
    avelength_prepped_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_name)),h.prepped_name<>(typeof(h.prepped_name))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_prepped_rec_type_pcnt := AVE(GROUP,IF(h.prepped_rec_type = (TYPEOF(h.prepped_rec_type))'',0,100));
    maxlength_prepped_rec_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_rec_type)));
    avelength_prepped_rec_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prepped_rec_type)),h.prepped_rec_type<>(typeof(h.prepped_rec_type))'');
    populated_isupdating_pcnt := AVE(GROUP,IF(h.isupdating = (TYPEOF(h.isupdating))'',0,100));
    maxlength_isupdating := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.isupdating)));
    avelength_isupdating := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.isupdating)),h.isupdating<>(typeof(h.isupdating))'');
    populated_iscurrent_pcnt := AVE(GROUP,IF(h.iscurrent = (TYPEOF(h.iscurrent))'',0,100));
    maxlength_iscurrent := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.iscurrent)));
    avelength_iscurrent := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.iscurrent)),h.iscurrent<>(typeof(h.iscurrent))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_ssn_pcnt := AVE(GROUP,IF(h.clean_ssn = (TYPEOF(h.clean_ssn))'',0,100));
    maxlength_clean_ssn := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.clean_ssn)));
    avelength_clean_ssn := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.clean_ssn)),h.clean_ssn<>(typeof(h.clean_ssn))'');
    populated_clean_dob_pcnt := AVE(GROUP,IF(h.clean_dob = (TYPEOF(h.clean_dob))'',0,100));
    maxlength_clean_dob := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.clean_dob)));
    avelength_clean_dob := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.clean_dob)),h.clean_dob<>(typeof(h.clean_dob))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_isdelete_pcnt := AVE(GROUP,IF(h.isdelete = (TYPEOF(h.isdelete))'',0,100));
    maxlength_isdelete := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.isdelete)));
    avelength_isdelete := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.isdelete)),h.isdelete<>(typeof(h.isdelete))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_name_prefix_pcnt *   0.00 / 100 + T.Populated_name_suffix__pcnt *   0.00 / 100 + T.Populated_perm_id_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_aka1_pcnt *   0.00 / 100 + T.Populated_aka2_pcnt *   0.00 / 100 + T.Populated_aka3_pcnt *   0.00 / 100 + T.Populated_new_subject_flag_pcnt *   0.00 / 100 + T.Populated_name_change_flag_pcnt *   0.00 / 100 + T.Populated_address_change_flag_pcnt *   0.00 / 100 + T.Populated_ssn_change_flag_pcnt *   0.00 / 100 + T.Populated_file_since_date_change_flag_pcnt *   0.00 / 100 + T.Populated_deceased_indicator_flag_pcnt *   0.00 / 100 + T.Populated_dob_change_flag_pcnt *   0.00 / 100 + T.Populated_phone_change_flag_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_mfdu_indicator_pcnt *   0.00 / 100 + T.Populated_file_since_date_pcnt *   0.00 / 100 + T.Populated_house_number_pcnt *   0.00 / 100 + T.Populated_street_direction_pcnt *   0.00 / 100 + T.Populated_street_name_pcnt *   0.00 / 100 + T.Populated_street_type_pcnt *   0.00 / 100 + T.Populated_street_post_direction_pcnt *   0.00 / 100 + T.Populated_unit_type_pcnt *   0.00 / 100 + T.Populated_unit_number_pcnt *   0.00 / 100 + T.Populated_cty_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_zp4_pcnt *   0.00 / 100 + T.Populated_address_standardization_indicator_pcnt *   0.00 / 100 + T.Populated_date_address_reported_pcnt *   0.00 / 100 + T.Populated_party_id_pcnt *   0.00 / 100 + T.Populated_deceased_indicator_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_date_of_birth_estimated_ind_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_filler3_pcnt *   0.00 / 100 + T.Populated_prepped_name_pcnt *   0.00 / 100 + T.Populated_prepped_addr1_pcnt *   0.00 / 100 + T.Populated_prepped_addr2_pcnt *   0.00 / 100 + T.Populated_prepped_rec_type_pcnt *   0.00 / 100 + T.Populated_isupdating_pcnt *   0.00 / 100 + T.Populated_iscurrent_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_ssn_pcnt *   0.00 / 100 + T.Populated_clean_dob_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_isdelete_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'record_type','first_name','middle_name','last_name','name_prefix','name_suffix_','perm_id','ssn','aka1','aka2','aka3','new_subject_flag','name_change_flag','address_change_flag','ssn_change_flag','file_since_date_change_flag','deceased_indicator_flag','dob_change_flag','phone_change_flag','filler2','gender','mfdu_indicator','file_since_date','house_number','street_direction','street_name','street_type','street_post_direction','unit_type','unit_number','cty','state','zip_code','zp4','address_standardization_indicator','date_address_reported','party_id','deceased_indicator','date_of_birth','date_of_birth_estimated_ind','phone','filler3','prepped_name','prepped_addr1','prepped_addr2','prepped_rec_type','isupdating','iscurrent','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','clean_phone','clean_ssn','clean_dob','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','isdelete');
  SELF.populated_pcnt := CHOOSE(C,le.populated_record_type_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_pcnt,le.populated_name_prefix_pcnt,le.populated_name_suffix__pcnt,le.populated_perm_id_pcnt,le.populated_ssn_pcnt,le.populated_aka1_pcnt,le.populated_aka2_pcnt,le.populated_aka3_pcnt,le.populated_new_subject_flag_pcnt,le.populated_name_change_flag_pcnt,le.populated_address_change_flag_pcnt,le.populated_ssn_change_flag_pcnt,le.populated_file_since_date_change_flag_pcnt,le.populated_deceased_indicator_flag_pcnt,le.populated_dob_change_flag_pcnt,le.populated_phone_change_flag_pcnt,le.populated_filler2_pcnt,le.populated_gender_pcnt,le.populated_mfdu_indicator_pcnt,le.populated_file_since_date_pcnt,le.populated_house_number_pcnt,le.populated_street_direction_pcnt,le.populated_street_name_pcnt,le.populated_street_type_pcnt,le.populated_street_post_direction_pcnt,le.populated_unit_type_pcnt,le.populated_unit_number_pcnt,le.populated_cty_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_zp4_pcnt,le.populated_address_standardization_indicator_pcnt,le.populated_date_address_reported_pcnt,le.populated_party_id_pcnt,le.populated_deceased_indicator_pcnt,le.populated_date_of_birth_pcnt,le.populated_date_of_birth_estimated_ind_pcnt,le.populated_phone_pcnt,le.populated_filler3_pcnt,le.populated_prepped_name_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prepped_addr2_pcnt,le.populated_prepped_rec_type_pcnt,le.populated_isupdating_pcnt,le.populated_iscurrent_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_ssn_pcnt,le.populated_clean_dob_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_county_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_isdelete_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_record_type,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name,le.maxlength_name_prefix,le.maxlength_name_suffix_,le.maxlength_perm_id,le.maxlength_ssn,le.maxlength_aka1,le.maxlength_aka2,le.maxlength_aka3,le.maxlength_new_subject_flag,le.maxlength_name_change_flag,le.maxlength_address_change_flag,le.maxlength_ssn_change_flag,le.maxlength_file_since_date_change_flag,le.maxlength_deceased_indicator_flag,le.maxlength_dob_change_flag,le.maxlength_phone_change_flag,le.maxlength_filler2,le.maxlength_gender,le.maxlength_mfdu_indicator,le.maxlength_file_since_date,le.maxlength_house_number,le.maxlength_street_direction,le.maxlength_street_name,le.maxlength_street_type,le.maxlength_street_post_direction,le.maxlength_unit_type,le.maxlength_unit_number,le.maxlength_cty,le.maxlength_state,le.maxlength_zip_code,le.maxlength_zp4,le.maxlength_address_standardization_indicator,le.maxlength_date_address_reported,le.maxlength_party_id,le.maxlength_deceased_indicator,le.maxlength_date_of_birth,le.maxlength_date_of_birth_estimated_ind,le.maxlength_phone,le.maxlength_filler3,le.maxlength_prepped_name,le.maxlength_prepped_addr1,le.maxlength_prepped_addr2,le.maxlength_prepped_rec_type,le.maxlength_isupdating,le.maxlength_iscurrent,le.maxlength_did,le.maxlength_did_score,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_vendor_first_reported,le.maxlength_clean_phone,le.maxlength_clean_ssn,le.maxlength_clean_dob,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_county,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_isdelete);
  SELF.avelength := CHOOSE(C,le.avelength_record_type,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name,le.avelength_name_prefix,le.avelength_name_suffix_,le.avelength_perm_id,le.avelength_ssn,le.avelength_aka1,le.avelength_aka2,le.avelength_aka3,le.avelength_new_subject_flag,le.avelength_name_change_flag,le.avelength_address_change_flag,le.avelength_ssn_change_flag,le.avelength_file_since_date_change_flag,le.avelength_deceased_indicator_flag,le.avelength_dob_change_flag,le.avelength_phone_change_flag,le.avelength_filler2,le.avelength_gender,le.avelength_mfdu_indicator,le.avelength_file_since_date,le.avelength_house_number,le.avelength_street_direction,le.avelength_street_name,le.avelength_street_type,le.avelength_street_post_direction,le.avelength_unit_type,le.avelength_unit_number,le.avelength_cty,le.avelength_state,le.avelength_zip_code,le.avelength_zp4,le.avelength_address_standardization_indicator,le.avelength_date_address_reported,le.avelength_party_id,le.avelength_deceased_indicator,le.avelength_date_of_birth,le.avelength_date_of_birth_estimated_ind,le.avelength_phone,le.avelength_filler3,le.avelength_prepped_name,le.avelength_prepped_addr1,le.avelength_prepped_addr2,le.avelength_prepped_rec_type,le.avelength_isupdating,le.avelength_iscurrent,le.avelength_did,le.avelength_did_score,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_last_reported,le.avelength_dt_vendor_first_reported,le.avelength_clean_phone,le.avelength_clean_ssn,le.avelength_clean_dob,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_county,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_isdelete);
END;
EXPORT invSummary := NORMALIZE(summary0, 92, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.record_type),TRIM((SALT32.StrType)le.first_name),TRIM((SALT32.StrType)le.middle_name),TRIM((SALT32.StrType)le.last_name),TRIM((SALT32.StrType)le.name_prefix),TRIM((SALT32.StrType)le.name_suffix_),TRIM((SALT32.StrType)le.perm_id),TRIM((SALT32.StrType)le.ssn),TRIM((SALT32.StrType)le.aka1),TRIM((SALT32.StrType)le.aka2),TRIM((SALT32.StrType)le.aka3),TRIM((SALT32.StrType)le.new_subject_flag),TRIM((SALT32.StrType)le.name_change_flag),TRIM((SALT32.StrType)le.address_change_flag),TRIM((SALT32.StrType)le.ssn_change_flag),TRIM((SALT32.StrType)le.file_since_date_change_flag),TRIM((SALT32.StrType)le.deceased_indicator_flag),TRIM((SALT32.StrType)le.dob_change_flag),TRIM((SALT32.StrType)le.phone_change_flag),TRIM((SALT32.StrType)le.filler2),TRIM((SALT32.StrType)le.gender),TRIM((SALT32.StrType)le.mfdu_indicator),TRIM((SALT32.StrType)le.file_since_date),TRIM((SALT32.StrType)le.house_number),TRIM((SALT32.StrType)le.street_direction),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.street_type),TRIM((SALT32.StrType)le.street_post_direction),TRIM((SALT32.StrType)le.unit_type),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.cty),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip_code),TRIM((SALT32.StrType)le.zp4),TRIM((SALT32.StrType)le.address_standardization_indicator),TRIM((SALT32.StrType)le.date_address_reported),TRIM((SALT32.StrType)le.party_id),TRIM((SALT32.StrType)le.deceased_indicator),TRIM((SALT32.StrType)le.date_of_birth),TRIM((SALT32.StrType)le.date_of_birth_estimated_ind),TRIM((SALT32.StrType)le.phone),TRIM((SALT32.StrType)le.filler3),TRIM((SALT32.StrType)le.prepped_name),TRIM((SALT32.StrType)le.prepped_addr1),TRIM((SALT32.StrType)le.prepped_addr2),TRIM((SALT32.StrType)le.prepped_rec_type),TRIM((SALT32.StrType)le.isupdating),TRIM((SALT32.StrType)le.iscurrent),IF (le.did <> 0,TRIM((SALT32.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT32.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT32.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT32.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT32.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT32.StrType)le.dt_vendor_first_reported), ''),TRIM((SALT32.StrType)le.clean_phone),TRIM((SALT32.StrType)le.clean_ssn),IF (le.clean_dob <> 0,TRIM((SALT32.StrType)le.clean_dob), ''),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.name_score),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.predir),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.addr_suffix),TRIM((SALT32.StrType)le.postdir),TRIM((SALT32.StrType)le.unit_desig),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.p_city_name),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.cart),TRIM((SALT32.StrType)le.cr_sort_sz),TRIM((SALT32.StrType)le.lot),TRIM((SALT32.StrType)le.lot_order),TRIM((SALT32.StrType)le.dbpc),TRIM((SALT32.StrType)le.chk_digit),TRIM((SALT32.StrType)le.rec_type),TRIM((SALT32.StrType)le.fips_county),TRIM((SALT32.StrType)le.county),TRIM((SALT32.StrType)le.geo_lat),TRIM((SALT32.StrType)le.geo_long),TRIM((SALT32.StrType)le.msa),TRIM((SALT32.StrType)le.geo_blk),TRIM((SALT32.StrType)le.geo_match),TRIM((SALT32.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT32.StrType)le.rawaid), ''),TRIM((SALT32.StrType)le.isdelete)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,92,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 92);
  SELF.FldNo2 := 1 + (C % 92);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.record_type),TRIM((SALT32.StrType)le.first_name),TRIM((SALT32.StrType)le.middle_name),TRIM((SALT32.StrType)le.last_name),TRIM((SALT32.StrType)le.name_prefix),TRIM((SALT32.StrType)le.name_suffix_),TRIM((SALT32.StrType)le.perm_id),TRIM((SALT32.StrType)le.ssn),TRIM((SALT32.StrType)le.aka1),TRIM((SALT32.StrType)le.aka2),TRIM((SALT32.StrType)le.aka3),TRIM((SALT32.StrType)le.new_subject_flag),TRIM((SALT32.StrType)le.name_change_flag),TRIM((SALT32.StrType)le.address_change_flag),TRIM((SALT32.StrType)le.ssn_change_flag),TRIM((SALT32.StrType)le.file_since_date_change_flag),TRIM((SALT32.StrType)le.deceased_indicator_flag),TRIM((SALT32.StrType)le.dob_change_flag),TRIM((SALT32.StrType)le.phone_change_flag),TRIM((SALT32.StrType)le.filler2),TRIM((SALT32.StrType)le.gender),TRIM((SALT32.StrType)le.mfdu_indicator),TRIM((SALT32.StrType)le.file_since_date),TRIM((SALT32.StrType)le.house_number),TRIM((SALT32.StrType)le.street_direction),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.street_type),TRIM((SALT32.StrType)le.street_post_direction),TRIM((SALT32.StrType)le.unit_type),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.cty),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip_code),TRIM((SALT32.StrType)le.zp4),TRIM((SALT32.StrType)le.address_standardization_indicator),TRIM((SALT32.StrType)le.date_address_reported),TRIM((SALT32.StrType)le.party_id),TRIM((SALT32.StrType)le.deceased_indicator),TRIM((SALT32.StrType)le.date_of_birth),TRIM((SALT32.StrType)le.date_of_birth_estimated_ind),TRIM((SALT32.StrType)le.phone),TRIM((SALT32.StrType)le.filler3),TRIM((SALT32.StrType)le.prepped_name),TRIM((SALT32.StrType)le.prepped_addr1),TRIM((SALT32.StrType)le.prepped_addr2),TRIM((SALT32.StrType)le.prepped_rec_type),TRIM((SALT32.StrType)le.isupdating),TRIM((SALT32.StrType)le.iscurrent),IF (le.did <> 0,TRIM((SALT32.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT32.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT32.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT32.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT32.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT32.StrType)le.dt_vendor_first_reported), ''),TRIM((SALT32.StrType)le.clean_phone),TRIM((SALT32.StrType)le.clean_ssn),IF (le.clean_dob <> 0,TRIM((SALT32.StrType)le.clean_dob), ''),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.name_score),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.predir),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.addr_suffix),TRIM((SALT32.StrType)le.postdir),TRIM((SALT32.StrType)le.unit_desig),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.p_city_name),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.cart),TRIM((SALT32.StrType)le.cr_sort_sz),TRIM((SALT32.StrType)le.lot),TRIM((SALT32.StrType)le.lot_order),TRIM((SALT32.StrType)le.dbpc),TRIM((SALT32.StrType)le.chk_digit),TRIM((SALT32.StrType)le.rec_type),TRIM((SALT32.StrType)le.fips_county),TRIM((SALT32.StrType)le.county),TRIM((SALT32.StrType)le.geo_lat),TRIM((SALT32.StrType)le.geo_long),TRIM((SALT32.StrType)le.msa),TRIM((SALT32.StrType)le.geo_blk),TRIM((SALT32.StrType)le.geo_match),TRIM((SALT32.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT32.StrType)le.rawaid), ''),TRIM((SALT32.StrType)le.isdelete)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.record_type),TRIM((SALT32.StrType)le.first_name),TRIM((SALT32.StrType)le.middle_name),TRIM((SALT32.StrType)le.last_name),TRIM((SALT32.StrType)le.name_prefix),TRIM((SALT32.StrType)le.name_suffix_),TRIM((SALT32.StrType)le.perm_id),TRIM((SALT32.StrType)le.ssn),TRIM((SALT32.StrType)le.aka1),TRIM((SALT32.StrType)le.aka2),TRIM((SALT32.StrType)le.aka3),TRIM((SALT32.StrType)le.new_subject_flag),TRIM((SALT32.StrType)le.name_change_flag),TRIM((SALT32.StrType)le.address_change_flag),TRIM((SALT32.StrType)le.ssn_change_flag),TRIM((SALT32.StrType)le.file_since_date_change_flag),TRIM((SALT32.StrType)le.deceased_indicator_flag),TRIM((SALT32.StrType)le.dob_change_flag),TRIM((SALT32.StrType)le.phone_change_flag),TRIM((SALT32.StrType)le.filler2),TRIM((SALT32.StrType)le.gender),TRIM((SALT32.StrType)le.mfdu_indicator),TRIM((SALT32.StrType)le.file_since_date),TRIM((SALT32.StrType)le.house_number),TRIM((SALT32.StrType)le.street_direction),TRIM((SALT32.StrType)le.street_name),TRIM((SALT32.StrType)le.street_type),TRIM((SALT32.StrType)le.street_post_direction),TRIM((SALT32.StrType)le.unit_type),TRIM((SALT32.StrType)le.unit_number),TRIM((SALT32.StrType)le.cty),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip_code),TRIM((SALT32.StrType)le.zp4),TRIM((SALT32.StrType)le.address_standardization_indicator),TRIM((SALT32.StrType)le.date_address_reported),TRIM((SALT32.StrType)le.party_id),TRIM((SALT32.StrType)le.deceased_indicator),TRIM((SALT32.StrType)le.date_of_birth),TRIM((SALT32.StrType)le.date_of_birth_estimated_ind),TRIM((SALT32.StrType)le.phone),TRIM((SALT32.StrType)le.filler3),TRIM((SALT32.StrType)le.prepped_name),TRIM((SALT32.StrType)le.prepped_addr1),TRIM((SALT32.StrType)le.prepped_addr2),TRIM((SALT32.StrType)le.prepped_rec_type),TRIM((SALT32.StrType)le.isupdating),TRIM((SALT32.StrType)le.iscurrent),IF (le.did <> 0,TRIM((SALT32.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT32.StrType)le.did_score), ''),IF (le.dt_first_seen <> 0,TRIM((SALT32.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT32.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT32.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT32.StrType)le.dt_vendor_first_reported), ''),TRIM((SALT32.StrType)le.clean_phone),TRIM((SALT32.StrType)le.clean_ssn),IF (le.clean_dob <> 0,TRIM((SALT32.StrType)le.clean_dob), ''),TRIM((SALT32.StrType)le.title),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.name_score),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.predir),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.addr_suffix),TRIM((SALT32.StrType)le.postdir),TRIM((SALT32.StrType)le.unit_desig),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.p_city_name),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.zip4),TRIM((SALT32.StrType)le.cart),TRIM((SALT32.StrType)le.cr_sort_sz),TRIM((SALT32.StrType)le.lot),TRIM((SALT32.StrType)le.lot_order),TRIM((SALT32.StrType)le.dbpc),TRIM((SALT32.StrType)le.chk_digit),TRIM((SALT32.StrType)le.rec_type),TRIM((SALT32.StrType)le.fips_county),TRIM((SALT32.StrType)le.county),TRIM((SALT32.StrType)le.geo_lat),TRIM((SALT32.StrType)le.geo_long),TRIM((SALT32.StrType)le.msa),TRIM((SALT32.StrType)le.geo_blk),TRIM((SALT32.StrType)le.geo_match),TRIM((SALT32.StrType)le.err_stat),IF (le.rawaid <> 0,TRIM((SALT32.StrType)le.rawaid), ''),TRIM((SALT32.StrType)le.isdelete)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),92*92,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'record_type'}
      ,{2,'first_name'}
      ,{3,'middle_name'}
      ,{4,'last_name'}
      ,{5,'name_prefix'}
      ,{6,'name_suffix_'}
      ,{7,'perm_id'}
      ,{8,'ssn'}
      ,{9,'aka1'}
      ,{10,'aka2'}
      ,{11,'aka3'}
      ,{12,'new_subject_flag'}
      ,{13,'name_change_flag'}
      ,{14,'address_change_flag'}
      ,{15,'ssn_change_flag'}
      ,{16,'file_since_date_change_flag'}
      ,{17,'deceased_indicator_flag'}
      ,{18,'dob_change_flag'}
      ,{19,'phone_change_flag'}
      ,{20,'filler2'}
      ,{21,'gender'}
      ,{22,'mfdu_indicator'}
      ,{23,'file_since_date'}
      ,{24,'house_number'}
      ,{25,'street_direction'}
      ,{26,'street_name'}
      ,{27,'street_type'}
      ,{28,'street_post_direction'}
      ,{29,'unit_type'}
      ,{30,'unit_number'}
      ,{31,'cty'}
      ,{32,'state'}
      ,{33,'zip_code'}
      ,{34,'zp4'}
      ,{35,'address_standardization_indicator'}
      ,{36,'date_address_reported'}
      ,{37,'party_id'}
      ,{38,'deceased_indicator'}
      ,{39,'date_of_birth'}
      ,{40,'date_of_birth_estimated_ind'}
      ,{41,'phone'}
      ,{42,'filler3'}
      ,{43,'prepped_name'}
      ,{44,'prepped_addr1'}
      ,{45,'prepped_addr2'}
      ,{46,'prepped_rec_type'}
      ,{47,'isupdating'}
      ,{48,'iscurrent'}
      ,{49,'did'}
      ,{50,'did_score'}
      ,{51,'dt_first_seen'}
      ,{52,'dt_last_seen'}
      ,{53,'dt_vendor_last_reported'}
      ,{54,'dt_vendor_first_reported'}
      ,{55,'clean_phone'}
      ,{56,'clean_ssn'}
      ,{57,'clean_dob'}
      ,{58,'title'}
      ,{59,'fname'}
      ,{60,'mname'}
      ,{61,'lname'}
      ,{62,'name_suffix'}
      ,{63,'name_score'}
      ,{64,'prim_range'}
      ,{65,'predir'}
      ,{66,'prim_name'}
      ,{67,'addr_suffix'}
      ,{68,'postdir'}
      ,{69,'unit_desig'}
      ,{70,'sec_range'}
      ,{71,'p_city_name'}
      ,{72,'v_city_name'}
      ,{73,'st'}
      ,{74,'zip'}
      ,{75,'zip4'}
      ,{76,'cart'}
      ,{77,'cr_sort_sz'}
      ,{78,'lot'}
      ,{79,'lot_order'}
      ,{80,'dbpc'}
      ,{81,'chk_digit'}
      ,{82,'rec_type'}
      ,{83,'fips_county'}
      ,{84,'county'}
      ,{85,'geo_lat'}
      ,{86,'geo_long'}
      ,{87,'msa'}
      ,{88,'geo_blk'}
      ,{89,'geo_match'}
      ,{90,'err_stat'}
      ,{91,'rawaid'}
      ,{92,'isdelete'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_record_type((SALT32.StrType)le.record_type),
    Fields.InValid_first_name((SALT32.StrType)le.first_name),
    Fields.InValid_middle_name((SALT32.StrType)le.middle_name),
    Fields.InValid_last_name((SALT32.StrType)le.last_name),
    Fields.InValid_name_prefix((SALT32.StrType)le.name_prefix),
    Fields.InValid_name_suffix_((SALT32.StrType)le.name_suffix_),
    Fields.InValid_perm_id((SALT32.StrType)le.perm_id),
    Fields.InValid_ssn((SALT32.StrType)le.ssn),
    Fields.InValid_aka1((SALT32.StrType)le.aka1),
    Fields.InValid_aka2((SALT32.StrType)le.aka2),
    Fields.InValid_aka3((SALT32.StrType)le.aka3),
    Fields.InValid_new_subject_flag((SALT32.StrType)le.new_subject_flag),
    Fields.InValid_name_change_flag((SALT32.StrType)le.name_change_flag),
    Fields.InValid_address_change_flag((SALT32.StrType)le.address_change_flag),
    Fields.InValid_ssn_change_flag((SALT32.StrType)le.ssn_change_flag),
    Fields.InValid_file_since_date_change_flag((SALT32.StrType)le.file_since_date_change_flag),
    Fields.InValid_deceased_indicator_flag((SALT32.StrType)le.deceased_indicator_flag),
    Fields.InValid_dob_change_flag((SALT32.StrType)le.dob_change_flag),
    Fields.InValid_phone_change_flag((SALT32.StrType)le.phone_change_flag),
    Fields.InValid_filler2((SALT32.StrType)le.filler2),
    Fields.InValid_gender((SALT32.StrType)le.gender),
    Fields.InValid_mfdu_indicator((SALT32.StrType)le.mfdu_indicator),
    Fields.InValid_file_since_date((SALT32.StrType)le.file_since_date),
    Fields.InValid_house_number((SALT32.StrType)le.house_number),
    Fields.InValid_street_direction((SALT32.StrType)le.street_direction),
    Fields.InValid_street_name((SALT32.StrType)le.street_name),
    Fields.InValid_street_type((SALT32.StrType)le.street_type),
    Fields.InValid_street_post_direction((SALT32.StrType)le.street_post_direction),
    Fields.InValid_unit_type((SALT32.StrType)le.unit_type),
    Fields.InValid_unit_number((SALT32.StrType)le.unit_number),
    Fields.InValid_cty((SALT32.StrType)le.cty),
    Fields.InValid_state((SALT32.StrType)le.state),
    Fields.InValid_zip_code((SALT32.StrType)le.zip_code),
    Fields.InValid_zp4((SALT32.StrType)le.zp4),
    Fields.InValid_address_standardization_indicator((SALT32.StrType)le.address_standardization_indicator),
    Fields.InValid_date_address_reported((SALT32.StrType)le.date_address_reported),
    Fields.InValid_party_id((SALT32.StrType)le.party_id),
    Fields.InValid_deceased_indicator((SALT32.StrType)le.deceased_indicator),
    Fields.InValid_date_of_birth((SALT32.StrType)le.date_of_birth),
    Fields.InValid_date_of_birth_estimated_ind((SALT32.StrType)le.date_of_birth_estimated_ind),
    Fields.InValid_phone((SALT32.StrType)le.phone),
    Fields.InValid_filler3((SALT32.StrType)le.filler3),
    Fields.InValid_prepped_name((SALT32.StrType)le.prepped_name),
    Fields.InValid_prepped_addr1((SALT32.StrType)le.prepped_addr1),
    Fields.InValid_prepped_addr2((SALT32.StrType)le.prepped_addr2),
    Fields.InValid_prepped_rec_type((SALT32.StrType)le.prepped_rec_type),
    Fields.InValid_isupdating((SALT32.StrType)le.isupdating),
    Fields.InValid_iscurrent((SALT32.StrType)le.iscurrent),
    Fields.InValid_did((SALT32.StrType)le.did),
    Fields.InValid_did_score((SALT32.StrType)le.did_score),
    Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_last_reported((SALT32.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_vendor_first_reported((SALT32.StrType)le.dt_vendor_first_reported),
    Fields.InValid_clean_phone((SALT32.StrType)le.clean_phone),
    Fields.InValid_clean_ssn((SALT32.StrType)le.clean_ssn),
    Fields.InValid_clean_dob((SALT32.StrType)le.clean_dob),
    Fields.InValid_title((SALT32.StrType)le.title),
    Fields.InValid_fname((SALT32.StrType)le.fname),
    Fields.InValid_mname((SALT32.StrType)le.mname),
    Fields.InValid_lname((SALT32.StrType)le.lname),
    Fields.InValid_name_suffix((SALT32.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT32.StrType)le.name_score),
    Fields.InValid_prim_range((SALT32.StrType)le.prim_range),
    Fields.InValid_predir((SALT32.StrType)le.predir),
    Fields.InValid_prim_name((SALT32.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT32.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT32.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT32.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT32.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT32.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT32.StrType)le.v_city_name),
    Fields.InValid_st((SALT32.StrType)le.st),
    Fields.InValid_zip((SALT32.StrType)le.zip),
    Fields.InValid_zip4((SALT32.StrType)le.zip4),
    Fields.InValid_cart((SALT32.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT32.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT32.StrType)le.lot),
    Fields.InValid_lot_order((SALT32.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT32.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT32.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT32.StrType)le.rec_type),
    Fields.InValid_fips_county((SALT32.StrType)le.fips_county),
    Fields.InValid_county((SALT32.StrType)le.county),
    Fields.InValid_geo_lat((SALT32.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT32.StrType)le.geo_long),
    Fields.InValid_msa((SALT32.StrType)le.msa),
    Fields.InValid_geo_blk((SALT32.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT32.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT32.StrType)le.err_stat),
    Fields.InValid_rawaid((SALT32.StrType)le.rawaid),
    Fields.InValid_isdelete((SALT32.StrType)le.isdelete),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,92,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'record_type','first_name','middle_name','last_name','name_prefix','name_suffix_','perm_id','ssn','aka1','aka2','aka3','new_subject_flag','name_change_flag','address_change_flag','ssn_change_flag','file_since_date_change_flag','deceased_indicator_flag','dob_change_flag','phone_change_flag','filler2','gender','mfdu_indicator','file_since_date','house_number','street_direction','street_name','street_type','street_post_direction','unit_type','unit_number','cty','state','zip_code','zp4','address_standardization_indicator','date_address_reported','party_id','deceased_indicator','date_of_birth','date_of_birth_estimated_ind','phone','filler3','prepped_name','prepped_addr1','prepped_addr2','prepped_rec_type','isupdating','iscurrent','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','clean_phone','clean_ssn','clean_dob','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','isdelete');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix_(TotalErrors.ErrorNum),Fields.InValidMessage_perm_id(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_aka1(TotalErrors.ErrorNum),Fields.InValidMessage_aka2(TotalErrors.ErrorNum),Fields.InValidMessage_aka3(TotalErrors.ErrorNum),Fields.InValidMessage_new_subject_flag(TotalErrors.ErrorNum),Fields.InValidMessage_name_change_flag(TotalErrors.ErrorNum),Fields.InValidMessage_address_change_flag(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_change_flag(TotalErrors.ErrorNum),Fields.InValidMessage_file_since_date_change_flag(TotalErrors.ErrorNum),Fields.InValidMessage_deceased_indicator_flag(TotalErrors.ErrorNum),Fields.InValidMessage_dob_change_flag(TotalErrors.ErrorNum),Fields.InValidMessage_phone_change_flag(TotalErrors.ErrorNum),Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_mfdu_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_file_since_date(TotalErrors.ErrorNum),Fields.InValidMessage_house_number(TotalErrors.ErrorNum),Fields.InValidMessage_street_direction(TotalErrors.ErrorNum),Fields.InValidMessage_street_name(TotalErrors.ErrorNum),Fields.InValidMessage_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_street_post_direction(TotalErrors.ErrorNum),Fields.InValidMessage_unit_type(TotalErrors.ErrorNum),Fields.InValidMessage_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_cty(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_zp4(TotalErrors.ErrorNum),Fields.InValidMessage_address_standardization_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_date_address_reported(TotalErrors.ErrorNum),Fields.InValidMessage_party_id(TotalErrors.ErrorNum),Fields.InValidMessage_deceased_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth_estimated_ind(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_filler3(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_name(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_isupdating(TotalErrors.ErrorNum),Fields.InValidMessage_iscurrent(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Fields.InValidMessage_clean_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dob(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_isdelete(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
