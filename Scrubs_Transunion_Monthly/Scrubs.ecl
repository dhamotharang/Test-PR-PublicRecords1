IMPORT ut,SALT32;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 name_prefix_Invalid;
    UNSIGNED1 name_suffix__Invalid;
    UNSIGNED1 perm_id_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 aka1_Invalid;
    UNSIGNED1 aka2_Invalid;
    UNSIGNED1 aka3_Invalid;
    UNSIGNED1 new_subject_flag_Invalid;
    UNSIGNED1 name_change_flag_Invalid;
    UNSIGNED1 address_change_flag_Invalid;
    UNSIGNED1 ssn_change_flag_Invalid;
    UNSIGNED1 file_since_date_change_flag_Invalid;
    UNSIGNED1 deceased_indicator_flag_Invalid;
    UNSIGNED1 dob_change_flag_Invalid;
    UNSIGNED1 phone_change_flag_Invalid;
    UNSIGNED1 filler2_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 mfdu_indicator_Invalid;
    UNSIGNED1 file_since_date_Invalid;
    UNSIGNED1 house_number_Invalid;
    UNSIGNED1 street_direction_Invalid;
    UNSIGNED1 street_name_Invalid;
    UNSIGNED1 street_type_Invalid;
    UNSIGNED1 street_post_direction_Invalid;
    UNSIGNED1 unit_type_Invalid;
    UNSIGNED1 unit_number_Invalid;
    UNSIGNED1 cty_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 zp4_Invalid;
    UNSIGNED1 address_standardization_indicator_Invalid;
    UNSIGNED1 date_address_reported_Invalid;
    UNSIGNED1 party_id_Invalid;
    UNSIGNED1 deceased_indicator_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 date_of_birth_estimated_ind_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 filler3_Invalid;
    UNSIGNED1 prepped_name_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
    UNSIGNED1 prepped_rec_type_Invalid;
    UNSIGNED1 isupdating_Invalid;
    UNSIGNED1 iscurrent_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_ssn_Invalid;
    UNSIGNED1 clean_dob_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 isdelete_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT32.StrType)le.record_type);
      clean_record_type := (TYPEOF(le.record_type))Fields.Make_record_type((SALT32.StrType)le.record_type);
      clean_record_type_Invalid := Fields.InValid_record_type((SALT32.StrType)clean_record_type);
      SELF.record_type := IF(withOnfail, clean_record_type, le.record_type); // ONFAIL(CLEAN)
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT32.StrType)le.first_name);
      clean_first_name := (TYPEOF(le.first_name))Fields.Make_first_name((SALT32.StrType)le.first_name);
      clean_first_name_Invalid := Fields.InValid_first_name((SALT32.StrType)clean_first_name);
      SELF.first_name := IF(withOnfail, clean_first_name, le.first_name); // ONFAIL(CLEAN)
    SELF.middle_name_Invalid := Fields.InValid_middle_name((SALT32.StrType)le.middle_name);
      clean_middle_name := (TYPEOF(le.middle_name))Fields.Make_middle_name((SALT32.StrType)le.middle_name);
      clean_middle_name_Invalid := Fields.InValid_middle_name((SALT32.StrType)clean_middle_name);
      SELF.middle_name := IF(withOnfail, clean_middle_name, le.middle_name); // ONFAIL(CLEAN)
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT32.StrType)le.last_name);
      clean_last_name := (TYPEOF(le.last_name))Fields.Make_last_name((SALT32.StrType)le.last_name);
      clean_last_name_Invalid := Fields.InValid_last_name((SALT32.StrType)clean_last_name);
      SELF.last_name := IF(withOnfail, clean_last_name, le.last_name); // ONFAIL(CLEAN)
    SELF.name_prefix_Invalid := Fields.InValid_name_prefix((SALT32.StrType)le.name_prefix);
      clean_name_prefix := (TYPEOF(le.name_prefix))Fields.Make_name_prefix((SALT32.StrType)le.name_prefix);
      clean_name_prefix_Invalid := Fields.InValid_name_prefix((SALT32.StrType)clean_name_prefix);
      SELF.name_prefix := IF(withOnfail, clean_name_prefix, le.name_prefix); // ONFAIL(CLEAN)
    SELF.name_suffix__Invalid := Fields.InValid_name_suffix_((SALT32.StrType)le.name_suffix_);
      clean_name_suffix_ := (TYPEOF(le.name_suffix_))Fields.Make_name_suffix_((SALT32.StrType)le.name_suffix_);
      clean_name_suffix__Invalid := Fields.InValid_name_suffix_((SALT32.StrType)clean_name_suffix_);
      SELF.name_suffix_ := IF(withOnfail, clean_name_suffix_, le.name_suffix_); // ONFAIL(CLEAN)
    SELF.perm_id_Invalid := Fields.InValid_perm_id((SALT32.StrType)le.perm_id);
      clean_perm_id := (TYPEOF(le.perm_id))Fields.Make_perm_id((SALT32.StrType)le.perm_id);
      clean_perm_id_Invalid := Fields.InValid_perm_id((SALT32.StrType)clean_perm_id);
      SELF.perm_id := IF(withOnfail, clean_perm_id, le.perm_id); // ONFAIL(CLEAN)
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT32.StrType)le.ssn);
      clean_ssn := (TYPEOF(le.ssn))Fields.Make_ssn((SALT32.StrType)le.ssn);
      clean_ssn_Invalid := Fields.InValid_ssn((SALT32.StrType)clean_ssn);
      SELF.ssn := IF(withOnfail, clean_ssn, le.ssn); // ONFAIL(CLEAN)
    SELF.aka1_Invalid := Fields.InValid_aka1((SALT32.StrType)le.aka1);
      clean_aka1 := (TYPEOF(le.aka1))Fields.Make_aka1((SALT32.StrType)le.aka1);
      clean_aka1_Invalid := Fields.InValid_aka1((SALT32.StrType)clean_aka1);
      SELF.aka1 := IF(withOnfail, clean_aka1, le.aka1); // ONFAIL(CLEAN)
    SELF.aka2_Invalid := Fields.InValid_aka2((SALT32.StrType)le.aka2);
      clean_aka2 := (TYPEOF(le.aka2))Fields.Make_aka2((SALT32.StrType)le.aka2);
      clean_aka2_Invalid := Fields.InValid_aka2((SALT32.StrType)clean_aka2);
      SELF.aka2 := IF(withOnfail, clean_aka2, le.aka2); // ONFAIL(CLEAN)
    SELF.aka3_Invalid := Fields.InValid_aka3((SALT32.StrType)le.aka3);
      clean_aka3 := (TYPEOF(le.aka3))Fields.Make_aka3((SALT32.StrType)le.aka3);
      clean_aka3_Invalid := Fields.InValid_aka3((SALT32.StrType)clean_aka3);
      SELF.aka3 := IF(withOnfail, clean_aka3, le.aka3); // ONFAIL(CLEAN)
    SELF.new_subject_flag_Invalid := Fields.InValid_new_subject_flag((SALT32.StrType)le.new_subject_flag);
      clean_new_subject_flag := (TYPEOF(le.new_subject_flag))Fields.Make_new_subject_flag((SALT32.StrType)le.new_subject_flag);
      clean_new_subject_flag_Invalid := Fields.InValid_new_subject_flag((SALT32.StrType)clean_new_subject_flag);
      SELF.new_subject_flag := IF(withOnfail, clean_new_subject_flag, le.new_subject_flag); // ONFAIL(CLEAN)
    SELF.name_change_flag_Invalid := Fields.InValid_name_change_flag((SALT32.StrType)le.name_change_flag);
      clean_name_change_flag := (TYPEOF(le.name_change_flag))Fields.Make_name_change_flag((SALT32.StrType)le.name_change_flag);
      clean_name_change_flag_Invalid := Fields.InValid_name_change_flag((SALT32.StrType)clean_name_change_flag);
      SELF.name_change_flag := IF(withOnfail, clean_name_change_flag, le.name_change_flag); // ONFAIL(CLEAN)
    SELF.address_change_flag_Invalid := Fields.InValid_address_change_flag((SALT32.StrType)le.address_change_flag);
      clean_address_change_flag := (TYPEOF(le.address_change_flag))Fields.Make_address_change_flag((SALT32.StrType)le.address_change_flag);
      clean_address_change_flag_Invalid := Fields.InValid_address_change_flag((SALT32.StrType)clean_address_change_flag);
      SELF.address_change_flag := IF(withOnfail, clean_address_change_flag, le.address_change_flag); // ONFAIL(CLEAN)
    SELF.ssn_change_flag_Invalid := Fields.InValid_ssn_change_flag((SALT32.StrType)le.ssn_change_flag);
      clean_ssn_change_flag := (TYPEOF(le.ssn_change_flag))Fields.Make_ssn_change_flag((SALT32.StrType)le.ssn_change_flag);
      clean_ssn_change_flag_Invalid := Fields.InValid_ssn_change_flag((SALT32.StrType)clean_ssn_change_flag);
      SELF.ssn_change_flag := IF(withOnfail, clean_ssn_change_flag, le.ssn_change_flag); // ONFAIL(CLEAN)
    SELF.file_since_date_change_flag_Invalid := Fields.InValid_file_since_date_change_flag((SALT32.StrType)le.file_since_date_change_flag);
      clean_file_since_date_change_flag := (TYPEOF(le.file_since_date_change_flag))Fields.Make_file_since_date_change_flag((SALT32.StrType)le.file_since_date_change_flag);
      clean_file_since_date_change_flag_Invalid := Fields.InValid_file_since_date_change_flag((SALT32.StrType)clean_file_since_date_change_flag);
      SELF.file_since_date_change_flag := IF(withOnfail, clean_file_since_date_change_flag, le.file_since_date_change_flag); // ONFAIL(CLEAN)
    SELF.deceased_indicator_flag_Invalid := Fields.InValid_deceased_indicator_flag((SALT32.StrType)le.deceased_indicator_flag);
      clean_deceased_indicator_flag := (TYPEOF(le.deceased_indicator_flag))Fields.Make_deceased_indicator_flag((SALT32.StrType)le.deceased_indicator_flag);
      clean_deceased_indicator_flag_Invalid := Fields.InValid_deceased_indicator_flag((SALT32.StrType)clean_deceased_indicator_flag);
      SELF.deceased_indicator_flag := IF(withOnfail, clean_deceased_indicator_flag, le.deceased_indicator_flag); // ONFAIL(CLEAN)
    SELF.dob_change_flag_Invalid := Fields.InValid_dob_change_flag((SALT32.StrType)le.dob_change_flag);
      clean_dob_change_flag := (TYPEOF(le.dob_change_flag))Fields.Make_dob_change_flag((SALT32.StrType)le.dob_change_flag);
      clean_dob_change_flag_Invalid := Fields.InValid_dob_change_flag((SALT32.StrType)clean_dob_change_flag);
      SELF.dob_change_flag := IF(withOnfail, clean_dob_change_flag, le.dob_change_flag); // ONFAIL(CLEAN)
    SELF.phone_change_flag_Invalid := Fields.InValid_phone_change_flag((SALT32.StrType)le.phone_change_flag);
      clean_phone_change_flag := (TYPEOF(le.phone_change_flag))Fields.Make_phone_change_flag((SALT32.StrType)le.phone_change_flag);
      clean_phone_change_flag_Invalid := Fields.InValid_phone_change_flag((SALT32.StrType)clean_phone_change_flag);
      SELF.phone_change_flag := IF(withOnfail, clean_phone_change_flag, le.phone_change_flag); // ONFAIL(CLEAN)
    SELF.filler2_Invalid := Fields.InValid_filler2((SALT32.StrType)le.filler2);
      clean_filler2 := (TYPEOF(le.filler2))Fields.Make_filler2((SALT32.StrType)le.filler2);
      clean_filler2_Invalid := Fields.InValid_filler2((SALT32.StrType)clean_filler2);
      SELF.filler2 := IF(withOnfail, clean_filler2, le.filler2); // ONFAIL(CLEAN)
    SELF.gender_Invalid := Fields.InValid_gender((SALT32.StrType)le.gender);
      clean_gender := (TYPEOF(le.gender))Fields.Make_gender((SALT32.StrType)le.gender);
      clean_gender_Invalid := Fields.InValid_gender((SALT32.StrType)clean_gender);
      SELF.gender := IF(withOnfail, clean_gender, le.gender); // ONFAIL(CLEAN)
    SELF.mfdu_indicator_Invalid := Fields.InValid_mfdu_indicator((SALT32.StrType)le.mfdu_indicator);
      clean_mfdu_indicator := (TYPEOF(le.mfdu_indicator))Fields.Make_mfdu_indicator((SALT32.StrType)le.mfdu_indicator);
      clean_mfdu_indicator_Invalid := Fields.InValid_mfdu_indicator((SALT32.StrType)clean_mfdu_indicator);
      SELF.mfdu_indicator := IF(withOnfail, clean_mfdu_indicator, le.mfdu_indicator); // ONFAIL(CLEAN)
    SELF.file_since_date_Invalid := Fields.InValid_file_since_date((SALT32.StrType)le.file_since_date);
      clean_file_since_date := (TYPEOF(le.file_since_date))Fields.Make_file_since_date((SALT32.StrType)le.file_since_date);
      clean_file_since_date_Invalid := Fields.InValid_file_since_date((SALT32.StrType)clean_file_since_date);
      SELF.file_since_date := IF(withOnfail, clean_file_since_date, le.file_since_date); // ONFAIL(CLEAN)
    SELF.house_number_Invalid := Fields.InValid_house_number((SALT32.StrType)le.house_number);
      clean_house_number := (TYPEOF(le.house_number))Fields.Make_house_number((SALT32.StrType)le.house_number);
      clean_house_number_Invalid := Fields.InValid_house_number((SALT32.StrType)clean_house_number);
      SELF.house_number := IF(withOnfail, clean_house_number, le.house_number); // ONFAIL(CLEAN)
    SELF.street_direction_Invalid := Fields.InValid_street_direction((SALT32.StrType)le.street_direction);
      clean_street_direction := (TYPEOF(le.street_direction))Fields.Make_street_direction((SALT32.StrType)le.street_direction);
      clean_street_direction_Invalid := Fields.InValid_street_direction((SALT32.StrType)clean_street_direction);
      SELF.street_direction := IF(withOnfail, clean_street_direction, le.street_direction); // ONFAIL(CLEAN)
    SELF.street_name_Invalid := Fields.InValid_street_name((SALT32.StrType)le.street_name);
      clean_street_name := (TYPEOF(le.street_name))Fields.Make_street_name((SALT32.StrType)le.street_name);
      clean_street_name_Invalid := Fields.InValid_street_name((SALT32.StrType)clean_street_name);
      SELF.street_name := IF(withOnfail, clean_street_name, le.street_name); // ONFAIL(CLEAN)
    SELF.street_type_Invalid := Fields.InValid_street_type((SALT32.StrType)le.street_type);
      clean_street_type := (TYPEOF(le.street_type))Fields.Make_street_type((SALT32.StrType)le.street_type);
      clean_street_type_Invalid := Fields.InValid_street_type((SALT32.StrType)clean_street_type);
      SELF.street_type := IF(withOnfail, clean_street_type, le.street_type); // ONFAIL(CLEAN)
    SELF.street_post_direction_Invalid := Fields.InValid_street_post_direction((SALT32.StrType)le.street_post_direction);
      clean_street_post_direction := (TYPEOF(le.street_post_direction))Fields.Make_street_post_direction((SALT32.StrType)le.street_post_direction);
      clean_street_post_direction_Invalid := Fields.InValid_street_post_direction((SALT32.StrType)clean_street_post_direction);
      SELF.street_post_direction := IF(withOnfail, clean_street_post_direction, le.street_post_direction); // ONFAIL(CLEAN)
    SELF.unit_type_Invalid := Fields.InValid_unit_type((SALT32.StrType)le.unit_type);
      clean_unit_type := (TYPEOF(le.unit_type))Fields.Make_unit_type((SALT32.StrType)le.unit_type);
      clean_unit_type_Invalid := Fields.InValid_unit_type((SALT32.StrType)clean_unit_type);
      SELF.unit_type := IF(withOnfail, clean_unit_type, le.unit_type); // ONFAIL(CLEAN)
    SELF.unit_number_Invalid := Fields.InValid_unit_number((SALT32.StrType)le.unit_number);
      clean_unit_number := (TYPEOF(le.unit_number))Fields.Make_unit_number((SALT32.StrType)le.unit_number);
      clean_unit_number_Invalid := Fields.InValid_unit_number((SALT32.StrType)clean_unit_number);
      SELF.unit_number := IF(withOnfail, clean_unit_number, le.unit_number); // ONFAIL(CLEAN)
    SELF.cty_Invalid := Fields.InValid_cty((SALT32.StrType)le.cty);
      clean_cty := (TYPEOF(le.cty))Fields.Make_cty((SALT32.StrType)le.cty);
      clean_cty_Invalid := Fields.InValid_cty((SALT32.StrType)clean_cty);
      SELF.cty := IF(withOnfail, clean_cty, le.cty); // ONFAIL(CLEAN)
    SELF.state_Invalid := Fields.InValid_state((SALT32.StrType)le.state);
      clean_state := (TYPEOF(le.state))Fields.Make_state((SALT32.StrType)le.state);
      clean_state_Invalid := Fields.InValid_state((SALT32.StrType)clean_state);
      SELF.state := IF(withOnfail, clean_state, le.state); // ONFAIL(CLEAN)
    SELF.zip_code_Invalid := Fields.InValid_zip_code((SALT32.StrType)le.zip_code);
      clean_zip_code := (TYPEOF(le.zip_code))Fields.Make_zip_code((SALT32.StrType)le.zip_code);
      clean_zip_code_Invalid := Fields.InValid_zip_code((SALT32.StrType)clean_zip_code);
      SELF.zip_code := IF(withOnfail, clean_zip_code, le.zip_code); // ONFAIL(CLEAN)
    SELF.zp4_Invalid := Fields.InValid_zp4((SALT32.StrType)le.zp4);
      clean_zp4 := (TYPEOF(le.zp4))Fields.Make_zp4((SALT32.StrType)le.zp4);
      clean_zp4_Invalid := Fields.InValid_zp4((SALT32.StrType)clean_zp4);
      SELF.zp4 := IF(withOnfail, clean_zp4, le.zp4); // ONFAIL(CLEAN)
    SELF.address_standardization_indicator_Invalid := Fields.InValid_address_standardization_indicator((SALT32.StrType)le.address_standardization_indicator);
      clean_address_standardization_indicator := (TYPEOF(le.address_standardization_indicator))Fields.Make_address_standardization_indicator((SALT32.StrType)le.address_standardization_indicator);
      clean_address_standardization_indicator_Invalid := Fields.InValid_address_standardization_indicator((SALT32.StrType)clean_address_standardization_indicator);
      SELF.address_standardization_indicator := IF(withOnfail, clean_address_standardization_indicator, le.address_standardization_indicator); // ONFAIL(CLEAN)
    SELF.date_address_reported_Invalid := Fields.InValid_date_address_reported((SALT32.StrType)le.date_address_reported);
      clean_date_address_reported := (TYPEOF(le.date_address_reported))Fields.Make_date_address_reported((SALT32.StrType)le.date_address_reported);
      clean_date_address_reported_Invalid := Fields.InValid_date_address_reported((SALT32.StrType)clean_date_address_reported);
      SELF.date_address_reported := IF(withOnfail, clean_date_address_reported, le.date_address_reported); // ONFAIL(CLEAN)
    SELF.party_id_Invalid := Fields.InValid_party_id((SALT32.StrType)le.party_id);
      clean_party_id := (TYPEOF(le.party_id))Fields.Make_party_id((SALT32.StrType)le.party_id);
      clean_party_id_Invalid := Fields.InValid_party_id((SALT32.StrType)clean_party_id);
      SELF.party_id := IF(withOnfail, clean_party_id, le.party_id); // ONFAIL(CLEAN)
    SELF.deceased_indicator_Invalid := Fields.InValid_deceased_indicator((SALT32.StrType)le.deceased_indicator);
      clean_deceased_indicator := (TYPEOF(le.deceased_indicator))Fields.Make_deceased_indicator((SALT32.StrType)le.deceased_indicator);
      clean_deceased_indicator_Invalid := Fields.InValid_deceased_indicator((SALT32.StrType)clean_deceased_indicator);
      SELF.deceased_indicator := IF(withOnfail, clean_deceased_indicator, le.deceased_indicator); // ONFAIL(CLEAN)
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT32.StrType)le.date_of_birth);
      clean_date_of_birth := (TYPEOF(le.date_of_birth))Fields.Make_date_of_birth((SALT32.StrType)le.date_of_birth);
      clean_date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT32.StrType)clean_date_of_birth);
      SELF.date_of_birth := IF(withOnfail, clean_date_of_birth, le.date_of_birth); // ONFAIL(CLEAN)
    SELF.date_of_birth_estimated_ind_Invalid := Fields.InValid_date_of_birth_estimated_ind((SALT32.StrType)le.date_of_birth_estimated_ind);
      clean_date_of_birth_estimated_ind := (TYPEOF(le.date_of_birth_estimated_ind))Fields.Make_date_of_birth_estimated_ind((SALT32.StrType)le.date_of_birth_estimated_ind);
      clean_date_of_birth_estimated_ind_Invalid := Fields.InValid_date_of_birth_estimated_ind((SALT32.StrType)clean_date_of_birth_estimated_ind);
      SELF.date_of_birth_estimated_ind := IF(withOnfail, clean_date_of_birth_estimated_ind, le.date_of_birth_estimated_ind); // ONFAIL(CLEAN)
    SELF.phone_Invalid := Fields.InValid_phone((SALT32.StrType)le.phone);
      clean_phone := (TYPEOF(le.phone))Fields.Make_phone((SALT32.StrType)le.phone);
      clean_phone_Invalid := Fields.InValid_phone((SALT32.StrType)clean_phone);
      SELF.phone := IF(withOnfail, clean_phone, le.phone); // ONFAIL(CLEAN)
    SELF.filler3_Invalid := Fields.InValid_filler3((SALT32.StrType)le.filler3);
      clean_filler3 := (TYPEOF(le.filler3))Fields.Make_filler3((SALT32.StrType)le.filler3);
      clean_filler3_Invalid := Fields.InValid_filler3((SALT32.StrType)clean_filler3);
      SELF.filler3 := IF(withOnfail, clean_filler3, le.filler3); // ONFAIL(CLEAN)
    SELF.prepped_name_Invalid := Fields.InValid_prepped_name((SALT32.StrType)le.prepped_name);
      clean_prepped_name := (TYPEOF(le.prepped_name))Fields.Make_prepped_name((SALT32.StrType)le.prepped_name);
      clean_prepped_name_Invalid := Fields.InValid_prepped_name((SALT32.StrType)clean_prepped_name);
      SELF.prepped_name := IF(withOnfail, clean_prepped_name, le.prepped_name); // ONFAIL(CLEAN)
    SELF.prepped_addr1_Invalid := Fields.InValid_prepped_addr1((SALT32.StrType)le.prepped_addr1);
      clean_prepped_addr1 := (TYPEOF(le.prepped_addr1))Fields.Make_prepped_addr1((SALT32.StrType)le.prepped_addr1);
      clean_prepped_addr1_Invalid := Fields.InValid_prepped_addr1((SALT32.StrType)clean_prepped_addr1);
      SELF.prepped_addr1 := IF(withOnfail, clean_prepped_addr1, le.prepped_addr1); // ONFAIL(CLEAN)
    SELF.prepped_addr2_Invalid := Fields.InValid_prepped_addr2((SALT32.StrType)le.prepped_addr2);
      clean_prepped_addr2 := (TYPEOF(le.prepped_addr2))Fields.Make_prepped_addr2((SALT32.StrType)le.prepped_addr2);
      clean_prepped_addr2_Invalid := Fields.InValid_prepped_addr2((SALT32.StrType)clean_prepped_addr2);
      SELF.prepped_addr2 := IF(withOnfail, clean_prepped_addr2, le.prepped_addr2); // ONFAIL(CLEAN)
    SELF.prepped_rec_type_Invalid := Fields.InValid_prepped_rec_type((SALT32.StrType)le.prepped_rec_type);
      clean_prepped_rec_type := (TYPEOF(le.prepped_rec_type))Fields.Make_prepped_rec_type((SALT32.StrType)le.prepped_rec_type);
      clean_prepped_rec_type_Invalid := Fields.InValid_prepped_rec_type((SALT32.StrType)clean_prepped_rec_type);
      SELF.prepped_rec_type := IF(withOnfail, clean_prepped_rec_type, le.prepped_rec_type); // ONFAIL(CLEAN)
    SELF.isupdating_Invalid := Fields.InValid_isupdating((SALT32.StrType)le.isupdating);
      clean_isupdating := (TYPEOF(le.isupdating))Fields.Make_isupdating((SALT32.StrType)le.isupdating);
      clean_isupdating_Invalid := Fields.InValid_isupdating((SALT32.StrType)clean_isupdating);
      SELF.isupdating := IF(withOnfail, clean_isupdating, le.isupdating); // ONFAIL(CLEAN)
    SELF.iscurrent_Invalid := Fields.InValid_iscurrent((SALT32.StrType)le.iscurrent);
      clean_iscurrent := (TYPEOF(le.iscurrent))Fields.Make_iscurrent((SALT32.StrType)le.iscurrent);
      clean_iscurrent_Invalid := Fields.InValid_iscurrent((SALT32.StrType)clean_iscurrent);
      SELF.iscurrent := IF(withOnfail, clean_iscurrent, le.iscurrent); // ONFAIL(CLEAN)
    SELF.did_Invalid := Fields.InValid_did((SALT32.StrType)le.did);
      clean_did := (TYPEOF(le.did))Fields.Make_did((SALT32.StrType)le.did);
      clean_did_Invalid := Fields.InValid_did((SALT32.StrType)clean_did);
      SELF.did := IF(withOnfail, clean_did, le.did); // ONFAIL(CLEAN)
    SELF.did_score_Invalid := Fields.InValid_did_score((SALT32.StrType)le.did_score);
      clean_did_score := (TYPEOF(le.did_score))Fields.Make_did_score((SALT32.StrType)le.did_score);
      clean_did_score_Invalid := Fields.InValid_did_score((SALT32.StrType)clean_did_score);
      SELF.did_score := IF(withOnfail, clean_did_score, le.did_score); // ONFAIL(CLEAN)
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen);
      clean_dt_first_seen := (TYPEOF(le.dt_first_seen))Fields.Make_dt_first_seen((SALT32.StrType)le.dt_first_seen);
      clean_dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT32.StrType)clean_dt_first_seen);
      SELF.dt_first_seen := IF(withOnfail, clean_dt_first_seen, le.dt_first_seen); // ONFAIL(CLEAN)
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen);
      clean_dt_last_seen := (TYPEOF(le.dt_last_seen))Fields.Make_dt_last_seen((SALT32.StrType)le.dt_last_seen);
      clean_dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT32.StrType)clean_dt_last_seen);
      SELF.dt_last_seen := IF(withOnfail, clean_dt_last_seen, le.dt_last_seen); // ONFAIL(CLEAN)
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT32.StrType)le.dt_vendor_last_reported);
      clean_dt_vendor_last_reported := (TYPEOF(le.dt_vendor_last_reported))Fields.Make_dt_vendor_last_reported((SALT32.StrType)le.dt_vendor_last_reported);
      clean_dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT32.StrType)clean_dt_vendor_last_reported);
      SELF.dt_vendor_last_reported := IF(withOnfail, clean_dt_vendor_last_reported, le.dt_vendor_last_reported); // ONFAIL(CLEAN)
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT32.StrType)le.dt_vendor_first_reported);
      clean_dt_vendor_first_reported := (TYPEOF(le.dt_vendor_first_reported))Fields.Make_dt_vendor_first_reported((SALT32.StrType)le.dt_vendor_first_reported);
      clean_dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT32.StrType)clean_dt_vendor_first_reported);
      SELF.dt_vendor_first_reported := IF(withOnfail, clean_dt_vendor_first_reported, le.dt_vendor_first_reported); // ONFAIL(CLEAN)
    SELF.clean_phone_Invalid := Fields.InValid_clean_phone((SALT32.StrType)le.clean_phone);
      clean_clean_phone := (TYPEOF(le.clean_phone))Fields.Make_clean_phone((SALT32.StrType)le.clean_phone);
      clean_clean_phone_Invalid := Fields.InValid_clean_phone((SALT32.StrType)clean_clean_phone);
      SELF.clean_phone := IF(withOnfail, clean_clean_phone, le.clean_phone); // ONFAIL(CLEAN)
    SELF.clean_ssn_Invalid := Fields.InValid_clean_ssn((SALT32.StrType)le.clean_ssn);
      clean_clean_ssn := (TYPEOF(le.clean_ssn))Fields.Make_clean_ssn((SALT32.StrType)le.clean_ssn);
      clean_clean_ssn_Invalid := Fields.InValid_clean_ssn((SALT32.StrType)clean_clean_ssn);
      SELF.clean_ssn := IF(withOnfail, clean_clean_ssn, le.clean_ssn); // ONFAIL(CLEAN)
    SELF.clean_dob_Invalid := Fields.InValid_clean_dob((SALT32.StrType)le.clean_dob);
      clean_clean_dob := (TYPEOF(le.clean_dob))Fields.Make_clean_dob((SALT32.StrType)le.clean_dob);
      clean_clean_dob_Invalid := Fields.InValid_clean_dob((SALT32.StrType)clean_clean_dob);
      SELF.clean_dob := IF(withOnfail, clean_clean_dob, le.clean_dob); // ONFAIL(CLEAN)
    SELF.title_Invalid := Fields.InValid_title((SALT32.StrType)le.title);
      clean_title := (TYPEOF(le.title))Fields.Make_title((SALT32.StrType)le.title);
      clean_title_Invalid := Fields.InValid_title((SALT32.StrType)clean_title);
      SELF.title := IF(withOnfail, clean_title, le.title); // ONFAIL(CLEAN)
    SELF.fname_Invalid := Fields.InValid_fname((SALT32.StrType)le.fname);
      clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT32.StrType)le.fname);
      clean_fname_Invalid := Fields.InValid_fname((SALT32.StrType)clean_fname);
      SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.mname_Invalid := Fields.InValid_mname((SALT32.StrType)le.mname);
      clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT32.StrType)le.mname);
      clean_mname_Invalid := Fields.InValid_mname((SALT32.StrType)clean_mname);
      SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.lname_Invalid := Fields.InValid_lname((SALT32.StrType)le.lname);
      clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT32.StrType)le.lname);
      clean_lname_Invalid := Fields.InValid_lname((SALT32.StrType)clean_lname);
      SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT32.StrType)le.name_suffix);
      clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT32.StrType)le.name_suffix);
      clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT32.StrType)clean_name_suffix);
      SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT32.StrType)le.name_score);
      clean_name_score := (TYPEOF(le.name_score))Fields.Make_name_score((SALT32.StrType)le.name_score);
      clean_name_score_Invalid := Fields.InValid_name_score((SALT32.StrType)clean_name_score);
      SELF.name_score := IF(withOnfail, clean_name_score, le.name_score); // ONFAIL(CLEAN)
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT32.StrType)le.prim_range);
      clean_prim_range := (TYPEOF(le.prim_range))Fields.Make_prim_range((SALT32.StrType)le.prim_range);
      clean_prim_range_Invalid := Fields.InValid_prim_range((SALT32.StrType)clean_prim_range);
      SELF.prim_range := IF(withOnfail, clean_prim_range, le.prim_range); // ONFAIL(CLEAN)
    SELF.predir_Invalid := Fields.InValid_predir((SALT32.StrType)le.predir);
      clean_predir := (TYPEOF(le.predir))Fields.Make_predir((SALT32.StrType)le.predir);
      clean_predir_Invalid := Fields.InValid_predir((SALT32.StrType)clean_predir);
      SELF.predir := IF(withOnfail, clean_predir, le.predir); // ONFAIL(CLEAN)
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT32.StrType)le.prim_name);
      clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT32.StrType)le.prim_name);
      clean_prim_name_Invalid := Fields.InValid_prim_name((SALT32.StrType)clean_prim_name);
      SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT32.StrType)le.addr_suffix);
      clean_addr_suffix := (TYPEOF(le.addr_suffix))Fields.Make_addr_suffix((SALT32.StrType)le.addr_suffix);
      clean_addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT32.StrType)clean_addr_suffix);
      SELF.addr_suffix := IF(withOnfail, clean_addr_suffix, le.addr_suffix); // ONFAIL(CLEAN)
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT32.StrType)le.postdir);
      clean_postdir := (TYPEOF(le.postdir))Fields.Make_postdir((SALT32.StrType)le.postdir);
      clean_postdir_Invalid := Fields.InValid_postdir((SALT32.StrType)clean_postdir);
      SELF.postdir := IF(withOnfail, clean_postdir, le.postdir); // ONFAIL(CLEAN)
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT32.StrType)le.unit_desig);
      clean_unit_desig := (TYPEOF(le.unit_desig))Fields.Make_unit_desig((SALT32.StrType)le.unit_desig);
      clean_unit_desig_Invalid := Fields.InValid_unit_desig((SALT32.StrType)clean_unit_desig);
      SELF.unit_desig := IF(withOnfail, clean_unit_desig, le.unit_desig); // ONFAIL(CLEAN)
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT32.StrType)le.sec_range);
      clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT32.StrType)le.sec_range);
      clean_sec_range_Invalid := Fields.InValid_sec_range((SALT32.StrType)clean_sec_range);
      SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT32.StrType)le.p_city_name);
      clean_p_city_name := (TYPEOF(le.p_city_name))Fields.Make_p_city_name((SALT32.StrType)le.p_city_name);
      clean_p_city_name_Invalid := Fields.InValid_p_city_name((SALT32.StrType)clean_p_city_name);
      SELF.p_city_name := IF(withOnfail, clean_p_city_name, le.p_city_name); // ONFAIL(CLEAN)
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT32.StrType)le.v_city_name);
      clean_v_city_name := (TYPEOF(le.v_city_name))Fields.Make_v_city_name((SALT32.StrType)le.v_city_name);
      clean_v_city_name_Invalid := Fields.InValid_v_city_name((SALT32.StrType)clean_v_city_name);
      SELF.v_city_name := IF(withOnfail, clean_v_city_name, le.v_city_name); // ONFAIL(CLEAN)
    SELF.st_Invalid := Fields.InValid_st((SALT32.StrType)le.st);
      clean_st := (TYPEOF(le.st))Fields.Make_st((SALT32.StrType)le.st);
      clean_st_Invalid := Fields.InValid_st((SALT32.StrType)clean_st);
      SELF.st := IF(withOnfail, clean_st, le.st); // ONFAIL(CLEAN)
    SELF.zip_Invalid := Fields.InValid_zip((SALT32.StrType)le.zip);
      clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT32.StrType)le.zip);
      clean_zip_Invalid := Fields.InValid_zip((SALT32.StrType)clean_zip);
      SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT32.StrType)le.zip4);
      clean_zip4 := (TYPEOF(le.zip4))Fields.Make_zip4((SALT32.StrType)le.zip4);
      clean_zip4_Invalid := Fields.InValid_zip4((SALT32.StrType)clean_zip4);
      SELF.zip4 := IF(withOnfail, clean_zip4, le.zip4); // ONFAIL(CLEAN)
    SELF.cart_Invalid := Fields.InValid_cart((SALT32.StrType)le.cart);
      clean_cart := (TYPEOF(le.cart))Fields.Make_cart((SALT32.StrType)le.cart);
      clean_cart_Invalid := Fields.InValid_cart((SALT32.StrType)clean_cart);
      SELF.cart := IF(withOnfail, clean_cart, le.cart); // ONFAIL(CLEAN)
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT32.StrType)le.cr_sort_sz);
      clean_cr_sort_sz := (TYPEOF(le.cr_sort_sz))Fields.Make_cr_sort_sz((SALT32.StrType)le.cr_sort_sz);
      clean_cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT32.StrType)clean_cr_sort_sz);
      SELF.cr_sort_sz := IF(withOnfail, clean_cr_sort_sz, le.cr_sort_sz); // ONFAIL(CLEAN)
    SELF.lot_Invalid := Fields.InValid_lot((SALT32.StrType)le.lot);
      clean_lot := (TYPEOF(le.lot))Fields.Make_lot((SALT32.StrType)le.lot);
      clean_lot_Invalid := Fields.InValid_lot((SALT32.StrType)clean_lot);
      SELF.lot := IF(withOnfail, clean_lot, le.lot); // ONFAIL(CLEAN)
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT32.StrType)le.lot_order);
      clean_lot_order := (TYPEOF(le.lot_order))Fields.Make_lot_order((SALT32.StrType)le.lot_order);
      clean_lot_order_Invalid := Fields.InValid_lot_order((SALT32.StrType)clean_lot_order);
      SELF.lot_order := IF(withOnfail, clean_lot_order, le.lot_order); // ONFAIL(CLEAN)
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT32.StrType)le.dbpc);
      clean_dbpc := (TYPEOF(le.dbpc))Fields.Make_dbpc((SALT32.StrType)le.dbpc);
      clean_dbpc_Invalid := Fields.InValid_dbpc((SALT32.StrType)clean_dbpc);
      SELF.dbpc := IF(withOnfail, clean_dbpc, le.dbpc); // ONFAIL(CLEAN)
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT32.StrType)le.chk_digit);
      clean_chk_digit := (TYPEOF(le.chk_digit))Fields.Make_chk_digit((SALT32.StrType)le.chk_digit);
      clean_chk_digit_Invalid := Fields.InValid_chk_digit((SALT32.StrType)clean_chk_digit);
      SELF.chk_digit := IF(withOnfail, clean_chk_digit, le.chk_digit); // ONFAIL(CLEAN)
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT32.StrType)le.rec_type);
      clean_rec_type := (TYPEOF(le.rec_type))Fields.Make_rec_type((SALT32.StrType)le.rec_type);
      clean_rec_type_Invalid := Fields.InValid_rec_type((SALT32.StrType)clean_rec_type);
      SELF.rec_type := IF(withOnfail, clean_rec_type, le.rec_type); // ONFAIL(CLEAN)
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT32.StrType)le.fips_county);
      clean_fips_county := (TYPEOF(le.fips_county))Fields.Make_fips_county((SALT32.StrType)le.fips_county);
      clean_fips_county_Invalid := Fields.InValid_fips_county((SALT32.StrType)clean_fips_county);
      SELF.fips_county := IF(withOnfail, clean_fips_county, le.fips_county); // ONFAIL(CLEAN)
    SELF.county_Invalid := Fields.InValid_county((SALT32.StrType)le.county);
      clean_county := (TYPEOF(le.county))Fields.Make_county((SALT32.StrType)le.county);
      clean_county_Invalid := Fields.InValid_county((SALT32.StrType)clean_county);
      SELF.county := IF(withOnfail, clean_county, le.county); // ONFAIL(CLEAN)
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT32.StrType)le.geo_lat);
      clean_geo_lat := (TYPEOF(le.geo_lat))Fields.Make_geo_lat((SALT32.StrType)le.geo_lat);
      clean_geo_lat_Invalid := Fields.InValid_geo_lat((SALT32.StrType)clean_geo_lat);
      SELF.geo_lat := IF(withOnfail, clean_geo_lat, le.geo_lat); // ONFAIL(CLEAN)
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT32.StrType)le.geo_long);
      clean_geo_long := (TYPEOF(le.geo_long))Fields.Make_geo_long((SALT32.StrType)le.geo_long);
      clean_geo_long_Invalid := Fields.InValid_geo_long((SALT32.StrType)clean_geo_long);
      SELF.geo_long := IF(withOnfail, clean_geo_long, le.geo_long); // ONFAIL(CLEAN)
    SELF.msa_Invalid := Fields.InValid_msa((SALT32.StrType)le.msa);
      clean_msa := (TYPEOF(le.msa))Fields.Make_msa((SALT32.StrType)le.msa);
      clean_msa_Invalid := Fields.InValid_msa((SALT32.StrType)clean_msa);
      SELF.msa := IF(withOnfail, clean_msa, le.msa); // ONFAIL(CLEAN)
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT32.StrType)le.geo_blk);
      clean_geo_blk := (TYPEOF(le.geo_blk))Fields.Make_geo_blk((SALT32.StrType)le.geo_blk);
      clean_geo_blk_Invalid := Fields.InValid_geo_blk((SALT32.StrType)clean_geo_blk);
      SELF.geo_blk := IF(withOnfail, clean_geo_blk, le.geo_blk); // ONFAIL(CLEAN)
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT32.StrType)le.geo_match);
      clean_geo_match := (TYPEOF(le.geo_match))Fields.Make_geo_match((SALT32.StrType)le.geo_match);
      clean_geo_match_Invalid := Fields.InValid_geo_match((SALT32.StrType)clean_geo_match);
      SELF.geo_match := IF(withOnfail, clean_geo_match, le.geo_match); // ONFAIL(CLEAN)
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT32.StrType)le.err_stat);
      clean_err_stat := (TYPEOF(le.err_stat))Fields.Make_err_stat((SALT32.StrType)le.err_stat);
      clean_err_stat_Invalid := Fields.InValid_err_stat((SALT32.StrType)clean_err_stat);
      SELF.err_stat := IF(withOnfail, clean_err_stat, le.err_stat); // ONFAIL(CLEAN)
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT32.StrType)le.rawaid);
      clean_rawaid := (TYPEOF(le.rawaid))Fields.Make_rawaid((SALT32.StrType)le.rawaid);
      clean_rawaid_Invalid := Fields.InValid_rawaid((SALT32.StrType)clean_rawaid);
      SELF.rawaid := IF(withOnfail, clean_rawaid, le.rawaid); // ONFAIL(CLEAN)
    SELF.isdelete_Invalid := Fields.InValid_isdelete((SALT32.StrType)le.isdelete);
      clean_isdelete := (TYPEOF(le.isdelete))Fields.Make_isdelete((SALT32.StrType)le.isdelete);
      clean_isdelete_Invalid := Fields.InValid_isdelete((SALT32.StrType)clean_isdelete);
      SELF.isdelete := IF(withOnfail, clean_isdelete, le.isdelete); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.record_type_Invalid << 0 ) + ( le.first_name_Invalid << 3 ) + ( le.middle_name_Invalid << 6 ) + ( le.last_name_Invalid << 9 ) + ( le.name_prefix_Invalid << 12 ) + ( le.name_suffix__Invalid << 15 ) + ( le.perm_id_Invalid << 17 ) + ( le.ssn_Invalid << 20 ) + ( le.aka1_Invalid << 23 ) + ( le.aka2_Invalid << 26 ) + ( le.aka3_Invalid << 29 ) + ( le.new_subject_flag_Invalid << 32 ) + ( le.name_change_flag_Invalid << 35 ) + ( le.address_change_flag_Invalid << 38 ) + ( le.ssn_change_flag_Invalid << 41 ) + ( le.file_since_date_change_flag_Invalid << 44 ) + ( le.deceased_indicator_flag_Invalid << 47 ) + ( le.dob_change_flag_Invalid << 50 ) + ( le.phone_change_flag_Invalid << 53 ) + ( le.filler2_Invalid << 56 ) + ( le.gender_Invalid << 59 );
    SELF.ScrubsBits2 := ( le.mfdu_indicator_Invalid << 0 ) + ( le.file_since_date_Invalid << 3 ) + ( le.house_number_Invalid << 6 ) + ( le.street_direction_Invalid << 8 ) + ( le.street_name_Invalid << 11 ) + ( le.street_type_Invalid << 14 ) + ( le.street_post_direction_Invalid << 17 ) + ( le.unit_type_Invalid << 20 ) + ( le.unit_number_Invalid << 22 ) + ( le.cty_Invalid << 25 ) + ( le.state_Invalid << 28 ) + ( le.zip_code_Invalid << 31 ) + ( le.zp4_Invalid << 34 ) + ( le.address_standardization_indicator_Invalid << 36 ) + ( le.date_address_reported_Invalid << 39 ) + ( le.party_id_Invalid << 42 ) + ( le.deceased_indicator_Invalid << 45 ) + ( le.date_of_birth_Invalid << 48 ) + ( le.date_of_birth_estimated_ind_Invalid << 51 ) + ( le.phone_Invalid << 54 ) + ( le.filler3_Invalid << 57 ) + ( le.prepped_name_Invalid << 60 );
    SELF.ScrubsBits3 := ( le.prepped_addr1_Invalid << 0 ) + ( le.prepped_addr2_Invalid << 3 ) + ( le.prepped_rec_type_Invalid << 6 ) + ( le.isupdating_Invalid << 9 ) + ( le.iscurrent_Invalid << 12 ) + ( le.did_Invalid << 15 ) + ( le.did_score_Invalid << 18 ) + ( le.dt_first_seen_Invalid << 21 ) + ( le.dt_last_seen_Invalid << 24 ) + ( le.dt_vendor_last_reported_Invalid << 27 ) + ( le.dt_vendor_first_reported_Invalid << 30 ) + ( le.clean_phone_Invalid << 33 ) + ( le.clean_ssn_Invalid << 36 ) + ( le.clean_dob_Invalid << 39 ) + ( le.title_Invalid << 42 ) + ( le.fname_Invalid << 45 ) + ( le.mname_Invalid << 48 ) + ( le.lname_Invalid << 51 ) + ( le.name_suffix_Invalid << 54 ) + ( le.name_score_Invalid << 57 ) + ( le.prim_range_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.predir_Invalid << 0 ) + ( le.prim_name_Invalid << 3 ) + ( le.addr_suffix_Invalid << 6 ) + ( le.postdir_Invalid << 9 ) + ( le.unit_desig_Invalid << 12 ) + ( le.sec_range_Invalid << 15 ) + ( le.p_city_name_Invalid << 18 ) + ( le.v_city_name_Invalid << 21 ) + ( le.st_Invalid << 24 ) + ( le.zip_Invalid << 27 ) + ( le.zip4_Invalid << 30 ) + ( le.cart_Invalid << 33 ) + ( le.cr_sort_sz_Invalid << 36 ) + ( le.lot_Invalid << 39 ) + ( le.lot_order_Invalid << 42 ) + ( le.dbpc_Invalid << 45 ) + ( le.chk_digit_Invalid << 48 ) + ( le.rec_type_Invalid << 51 ) + ( le.fips_county_Invalid << 54 ) + ( le.county_Invalid << 57 ) + ( le.geo_lat_Invalid << 60 );
    SELF.ScrubsBits5 := ( le.geo_long_Invalid << 0 ) + ( le.msa_Invalid << 3 ) + ( le.geo_blk_Invalid << 6 ) + ( le.geo_match_Invalid << 9 ) + ( le.err_stat_Invalid << 12 ) + ( le.rawaid_Invalid << 15 ) + ( le.isdelete_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.name_prefix_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.name_suffix__Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.perm_id_Invalid := (le.ScrubsBits1 >> 17) & 7;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 20) & 7;
    SELF.aka1_Invalid := (le.ScrubsBits1 >> 23) & 7;
    SELF.aka2_Invalid := (le.ScrubsBits1 >> 26) & 7;
    SELF.aka3_Invalid := (le.ScrubsBits1 >> 29) & 7;
    SELF.new_subject_flag_Invalid := (le.ScrubsBits1 >> 32) & 7;
    SELF.name_change_flag_Invalid := (le.ScrubsBits1 >> 35) & 7;
    SELF.address_change_flag_Invalid := (le.ScrubsBits1 >> 38) & 7;
    SELF.ssn_change_flag_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.file_since_date_change_flag_Invalid := (le.ScrubsBits1 >> 44) & 7;
    SELF.deceased_indicator_flag_Invalid := (le.ScrubsBits1 >> 47) & 7;
    SELF.dob_change_flag_Invalid := (le.ScrubsBits1 >> 50) & 7;
    SELF.phone_change_flag_Invalid := (le.ScrubsBits1 >> 53) & 7;
    SELF.filler2_Invalid := (le.ScrubsBits1 >> 56) & 7;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 59) & 7;
    SELF.mfdu_indicator_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.file_since_date_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.house_number_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.street_direction_Invalid := (le.ScrubsBits2 >> 8) & 7;
    SELF.street_name_Invalid := (le.ScrubsBits2 >> 11) & 7;
    SELF.street_type_Invalid := (le.ScrubsBits2 >> 14) & 7;
    SELF.street_post_direction_Invalid := (le.ScrubsBits2 >> 17) & 7;
    SELF.unit_type_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.unit_number_Invalid := (le.ScrubsBits2 >> 22) & 7;
    SELF.cty_Invalid := (le.ScrubsBits2 >> 25) & 7;
    SELF.state_Invalid := (le.ScrubsBits2 >> 28) & 7;
    SELF.zip_code_Invalid := (le.ScrubsBits2 >> 31) & 7;
    SELF.zp4_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.address_standardization_indicator_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.date_address_reported_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.party_id_Invalid := (le.ScrubsBits2 >> 42) & 7;
    SELF.deceased_indicator_Invalid := (le.ScrubsBits2 >> 45) & 7;
    SELF.date_of_birth_Invalid := (le.ScrubsBits2 >> 48) & 7;
    SELF.date_of_birth_estimated_ind_Invalid := (le.ScrubsBits2 >> 51) & 7;
    SELF.phone_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.filler3_Invalid := (le.ScrubsBits2 >> 57) & 7;
    SELF.prepped_name_Invalid := (le.ScrubsBits2 >> 60) & 7;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.prepped_rec_type_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.isupdating_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.iscurrent_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.did_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.did_score_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.clean_phone_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.clean_ssn_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.clean_dob_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.title_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.fname_Invalid := (le.ScrubsBits3 >> 45) & 7;
    SELF.mname_Invalid := (le.ScrubsBits3 >> 48) & 7;
    SELF.lname_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.name_suffix_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.name_score_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.prim_range_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.predir_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.prim_name_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.addr_suffix_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.postdir_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.unit_desig_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.sec_range_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.p_city_name_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.v_city_name_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.st_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF.zip_Invalid := (le.ScrubsBits4 >> 27) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits4 >> 30) & 7;
    SELF.cart_Invalid := (le.ScrubsBits4 >> 33) & 7;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits4 >> 36) & 7;
    SELF.lot_Invalid := (le.ScrubsBits4 >> 39) & 7;
    SELF.lot_order_Invalid := (le.ScrubsBits4 >> 42) & 7;
    SELF.dbpc_Invalid := (le.ScrubsBits4 >> 45) & 7;
    SELF.chk_digit_Invalid := (le.ScrubsBits4 >> 48) & 7;
    SELF.rec_type_Invalid := (le.ScrubsBits4 >> 51) & 7;
    SELF.fips_county_Invalid := (le.ScrubsBits4 >> 54) & 7;
    SELF.county_Invalid := (le.ScrubsBits4 >> 57) & 7;
    SELF.geo_lat_Invalid := (le.ScrubsBits4 >> 60) & 7;
    SELF.geo_long_Invalid := (le.ScrubsBits5 >> 0) & 7;
    SELF.msa_Invalid := (le.ScrubsBits5 >> 3) & 7;
    SELF.geo_blk_Invalid := (le.ScrubsBits5 >> 6) & 7;
    SELF.geo_match_Invalid := (le.ScrubsBits5 >> 9) & 7;
    SELF.err_stat_Invalid := (le.ScrubsBits5 >> 12) & 7;
    SELF.rawaid_Invalid := (le.ScrubsBits5 >> 15) & 7;
    SELF.isdelete_Invalid := (le.ScrubsBits5 >> 18) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    record_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=2);
    record_type_LENGTH_ErrorCount := COUNT(GROUP,h.record_type_Invalid=3);
    record_type_WORDS_ErrorCount := COUNT(GROUP,h.record_type_Invalid=4);
    record_type_Total_ErrorCount := COUNT(GROUP,h.record_type_Invalid>0);
    first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=2);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=3);
    first_name_WORDS_ErrorCount := COUNT(GROUP,h.first_name_Invalid=4);
    first_name_Total_ErrorCount := COUNT(GROUP,h.first_name_Invalid>0);
    middle_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=2);
    middle_name_LENGTH_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=3);
    middle_name_WORDS_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=4);
    middle_name_Total_ErrorCount := COUNT(GROUP,h.middle_name_Invalid>0);
    last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=2);
    last_name_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_Invalid=3);
    last_name_WORDS_ErrorCount := COUNT(GROUP,h.last_name_Invalid=4);
    last_name_Total_ErrorCount := COUNT(GROUP,h.last_name_Invalid>0);
    name_prefix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_prefix_Invalid=1);
    name_prefix_ALLOW_ErrorCount := COUNT(GROUP,h.name_prefix_Invalid=2);
    name_prefix_LENGTH_ErrorCount := COUNT(GROUP,h.name_prefix_Invalid=3);
    name_prefix_WORDS_ErrorCount := COUNT(GROUP,h.name_prefix_Invalid=4);
    name_prefix_Total_ErrorCount := COUNT(GROUP,h.name_prefix_Invalid>0);
    name_suffix__ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix__Invalid=1);
    name_suffix__LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix__Invalid=2);
    name_suffix__WORDS_ErrorCount := COUNT(GROUP,h.name_suffix__Invalid=3);
    name_suffix__Total_ErrorCount := COUNT(GROUP,h.name_suffix__Invalid>0);
    perm_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.perm_id_Invalid=1);
    perm_id_ALLOW_ErrorCount := COUNT(GROUP,h.perm_id_Invalid=2);
    perm_id_LENGTH_ErrorCount := COUNT(GROUP,h.perm_id_Invalid=3);
    perm_id_WORDS_ErrorCount := COUNT(GROUP,h.perm_id_Invalid=4);
    perm_id_Total_ErrorCount := COUNT(GROUP,h.perm_id_Invalid>0);
    ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_WORDS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=4);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    aka1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka1_Invalid=1);
    aka1_ALLOW_ErrorCount := COUNT(GROUP,h.aka1_Invalid=2);
    aka1_LENGTH_ErrorCount := COUNT(GROUP,h.aka1_Invalid=3);
    aka1_WORDS_ErrorCount := COUNT(GROUP,h.aka1_Invalid=4);
    aka1_Total_ErrorCount := COUNT(GROUP,h.aka1_Invalid>0);
    aka2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka2_Invalid=1);
    aka2_ALLOW_ErrorCount := COUNT(GROUP,h.aka2_Invalid=2);
    aka2_LENGTH_ErrorCount := COUNT(GROUP,h.aka2_Invalid=3);
    aka2_WORDS_ErrorCount := COUNT(GROUP,h.aka2_Invalid=4);
    aka2_Total_ErrorCount := COUNT(GROUP,h.aka2_Invalid>0);
    aka3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka3_Invalid=1);
    aka3_ALLOW_ErrorCount := COUNT(GROUP,h.aka3_Invalid=2);
    aka3_LENGTH_ErrorCount := COUNT(GROUP,h.aka3_Invalid=3);
    aka3_WORDS_ErrorCount := COUNT(GROUP,h.aka3_Invalid=4);
    aka3_Total_ErrorCount := COUNT(GROUP,h.aka3_Invalid>0);
    new_subject_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.new_subject_flag_Invalid=1);
    new_subject_flag_ALLOW_ErrorCount := COUNT(GROUP,h.new_subject_flag_Invalid=2);
    new_subject_flag_LENGTH_ErrorCount := COUNT(GROUP,h.new_subject_flag_Invalid=3);
    new_subject_flag_WORDS_ErrorCount := COUNT(GROUP,h.new_subject_flag_Invalid=4);
    new_subject_flag_Total_ErrorCount := COUNT(GROUP,h.new_subject_flag_Invalid>0);
    name_change_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_change_flag_Invalid=1);
    name_change_flag_ALLOW_ErrorCount := COUNT(GROUP,h.name_change_flag_Invalid=2);
    name_change_flag_LENGTH_ErrorCount := COUNT(GROUP,h.name_change_flag_Invalid=3);
    name_change_flag_WORDS_ErrorCount := COUNT(GROUP,h.name_change_flag_Invalid=4);
    name_change_flag_Total_ErrorCount := COUNT(GROUP,h.name_change_flag_Invalid>0);
    address_change_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address_change_flag_Invalid=1);
    address_change_flag_ALLOW_ErrorCount := COUNT(GROUP,h.address_change_flag_Invalid=2);
    address_change_flag_LENGTH_ErrorCount := COUNT(GROUP,h.address_change_flag_Invalid=3);
    address_change_flag_WORDS_ErrorCount := COUNT(GROUP,h.address_change_flag_Invalid=4);
    address_change_flag_Total_ErrorCount := COUNT(GROUP,h.address_change_flag_Invalid>0);
    ssn_change_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_change_flag_Invalid=1);
    ssn_change_flag_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_change_flag_Invalid=2);
    ssn_change_flag_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_change_flag_Invalid=3);
    ssn_change_flag_WORDS_ErrorCount := COUNT(GROUP,h.ssn_change_flag_Invalid=4);
    ssn_change_flag_Total_ErrorCount := COUNT(GROUP,h.ssn_change_flag_Invalid>0);
    file_since_date_change_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.file_since_date_change_flag_Invalid=1);
    file_since_date_change_flag_ALLOW_ErrorCount := COUNT(GROUP,h.file_since_date_change_flag_Invalid=2);
    file_since_date_change_flag_LENGTH_ErrorCount := COUNT(GROUP,h.file_since_date_change_flag_Invalid=3);
    file_since_date_change_flag_WORDS_ErrorCount := COUNT(GROUP,h.file_since_date_change_flag_Invalid=4);
    file_since_date_change_flag_Total_ErrorCount := COUNT(GROUP,h.file_since_date_change_flag_Invalid>0);
    deceased_indicator_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deceased_indicator_flag_Invalid=1);
    deceased_indicator_flag_ALLOW_ErrorCount := COUNT(GROUP,h.deceased_indicator_flag_Invalid=2);
    deceased_indicator_flag_LENGTH_ErrorCount := COUNT(GROUP,h.deceased_indicator_flag_Invalid=3);
    deceased_indicator_flag_WORDS_ErrorCount := COUNT(GROUP,h.deceased_indicator_flag_Invalid=4);
    deceased_indicator_flag_Total_ErrorCount := COUNT(GROUP,h.deceased_indicator_flag_Invalid>0);
    dob_change_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dob_change_flag_Invalid=1);
    dob_change_flag_ALLOW_ErrorCount := COUNT(GROUP,h.dob_change_flag_Invalid=2);
    dob_change_flag_LENGTH_ErrorCount := COUNT(GROUP,h.dob_change_flag_Invalid=3);
    dob_change_flag_WORDS_ErrorCount := COUNT(GROUP,h.dob_change_flag_Invalid=4);
    dob_change_flag_Total_ErrorCount := COUNT(GROUP,h.dob_change_flag_Invalid>0);
    phone_change_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_change_flag_Invalid=1);
    phone_change_flag_ALLOW_ErrorCount := COUNT(GROUP,h.phone_change_flag_Invalid=2);
    phone_change_flag_LENGTH_ErrorCount := COUNT(GROUP,h.phone_change_flag_Invalid=3);
    phone_change_flag_WORDS_ErrorCount := COUNT(GROUP,h.phone_change_flag_Invalid=4);
    phone_change_flag_Total_ErrorCount := COUNT(GROUP,h.phone_change_flag_Invalid>0);
    filler2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filler2_Invalid=1);
    filler2_ALLOW_ErrorCount := COUNT(GROUP,h.filler2_Invalid=2);
    filler2_LENGTH_ErrorCount := COUNT(GROUP,h.filler2_Invalid=3);
    filler2_WORDS_ErrorCount := COUNT(GROUP,h.filler2_Invalid=4);
    filler2_Total_ErrorCount := COUNT(GROUP,h.filler2_Invalid>0);
    gender_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_LENGTH_ErrorCount := COUNT(GROUP,h.gender_Invalid=3);
    gender_WORDS_ErrorCount := COUNT(GROUP,h.gender_Invalid=4);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    mfdu_indicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mfdu_indicator_Invalid=1);
    mfdu_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.mfdu_indicator_Invalid=2);
    mfdu_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.mfdu_indicator_Invalid=3);
    mfdu_indicator_WORDS_ErrorCount := COUNT(GROUP,h.mfdu_indicator_Invalid=4);
    mfdu_indicator_Total_ErrorCount := COUNT(GROUP,h.mfdu_indicator_Invalid>0);
    file_since_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.file_since_date_Invalid=1);
    file_since_date_ALLOW_ErrorCount := COUNT(GROUP,h.file_since_date_Invalid=2);
    file_since_date_LENGTH_ErrorCount := COUNT(GROUP,h.file_since_date_Invalid=3);
    file_since_date_WORDS_ErrorCount := COUNT(GROUP,h.file_since_date_Invalid=4);
    file_since_date_Total_ErrorCount := COUNT(GROUP,h.file_since_date_Invalid>0);
    house_number_ALLOW_ErrorCount := COUNT(GROUP,h.house_number_Invalid=1);
    house_number_LENGTH_ErrorCount := COUNT(GROUP,h.house_number_Invalid=2);
    house_number_WORDS_ErrorCount := COUNT(GROUP,h.house_number_Invalid=3);
    house_number_Total_ErrorCount := COUNT(GROUP,h.house_number_Invalid>0);
    street_direction_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street_direction_Invalid=1);
    street_direction_ALLOW_ErrorCount := COUNT(GROUP,h.street_direction_Invalid=2);
    street_direction_LENGTH_ErrorCount := COUNT(GROUP,h.street_direction_Invalid=3);
    street_direction_WORDS_ErrorCount := COUNT(GROUP,h.street_direction_Invalid=4);
    street_direction_Total_ErrorCount := COUNT(GROUP,h.street_direction_Invalid>0);
    street_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street_name_Invalid=1);
    street_name_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_Invalid=2);
    street_name_LENGTH_ErrorCount := COUNT(GROUP,h.street_name_Invalid=3);
    street_name_WORDS_ErrorCount := COUNT(GROUP,h.street_name_Invalid=4);
    street_name_Total_ErrorCount := COUNT(GROUP,h.street_name_Invalid>0);
    street_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street_type_Invalid=1);
    street_type_ALLOW_ErrorCount := COUNT(GROUP,h.street_type_Invalid=2);
    street_type_LENGTH_ErrorCount := COUNT(GROUP,h.street_type_Invalid=3);
    street_type_WORDS_ErrorCount := COUNT(GROUP,h.street_type_Invalid=4);
    street_type_Total_ErrorCount := COUNT(GROUP,h.street_type_Invalid>0);
    street_post_direction_LEFTTRIM_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid=1);
    street_post_direction_ALLOW_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid=2);
    street_post_direction_LENGTH_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid=3);
    street_post_direction_WORDS_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid=4);
    street_post_direction_Total_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid>0);
    unit_type_ALLOW_ErrorCount := COUNT(GROUP,h.unit_type_Invalid=1);
    unit_type_LENGTH_ErrorCount := COUNT(GROUP,h.unit_type_Invalid=2);
    unit_type_WORDS_ErrorCount := COUNT(GROUP,h.unit_type_Invalid=3);
    unit_type_Total_ErrorCount := COUNT(GROUP,h.unit_type_Invalid>0);
    unit_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=1);
    unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=2);
    unit_number_LENGTH_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=3);
    unit_number_WORDS_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=4);
    unit_number_Total_ErrorCount := COUNT(GROUP,h.unit_number_Invalid>0);
    cty_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cty_Invalid=1);
    cty_ALLOW_ErrorCount := COUNT(GROUP,h.cty_Invalid=2);
    cty_LENGTH_ErrorCount := COUNT(GROUP,h.cty_Invalid=3);
    cty_WORDS_ErrorCount := COUNT(GROUP,h.cty_Invalid=4);
    cty_Total_ErrorCount := COUNT(GROUP,h.cty_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_WORDS_ErrorCount := COUNT(GROUP,h.state_Invalid=4);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=2);
    zip_code_LENGTH_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=3);
    zip_code_WORDS_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=4);
    zip_code_Total_ErrorCount := COUNT(GROUP,h.zip_code_Invalid>0);
    zp4_ALLOW_ErrorCount := COUNT(GROUP,h.zp4_Invalid=1);
    zp4_LENGTH_ErrorCount := COUNT(GROUP,h.zp4_Invalid=2);
    zp4_WORDS_ErrorCount := COUNT(GROUP,h.zp4_Invalid=3);
    zp4_Total_ErrorCount := COUNT(GROUP,h.zp4_Invalid>0);
    address_standardization_indicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address_standardization_indicator_Invalid=1);
    address_standardization_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.address_standardization_indicator_Invalid=2);
    address_standardization_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.address_standardization_indicator_Invalid=3);
    address_standardization_indicator_WORDS_ErrorCount := COUNT(GROUP,h.address_standardization_indicator_Invalid=4);
    address_standardization_indicator_Total_ErrorCount := COUNT(GROUP,h.address_standardization_indicator_Invalid>0);
    date_address_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_address_reported_Invalid=1);
    date_address_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_address_reported_Invalid=2);
    date_address_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_address_reported_Invalid=3);
    date_address_reported_WORDS_ErrorCount := COUNT(GROUP,h.date_address_reported_Invalid=4);
    date_address_reported_Total_ErrorCount := COUNT(GROUP,h.date_address_reported_Invalid>0);
    party_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.party_id_Invalid=1);
    party_id_ALLOW_ErrorCount := COUNT(GROUP,h.party_id_Invalid=2);
    party_id_LENGTH_ErrorCount := COUNT(GROUP,h.party_id_Invalid=3);
    party_id_WORDS_ErrorCount := COUNT(GROUP,h.party_id_Invalid=4);
    party_id_Total_ErrorCount := COUNT(GROUP,h.party_id_Invalid>0);
    deceased_indicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deceased_indicator_Invalid=1);
    deceased_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.deceased_indicator_Invalid=2);
    deceased_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.deceased_indicator_Invalid=3);
    deceased_indicator_WORDS_ErrorCount := COUNT(GROUP,h.deceased_indicator_Invalid=4);
    deceased_indicator_Total_ErrorCount := COUNT(GROUP,h.deceased_indicator_Invalid>0);
    date_of_birth_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    date_of_birth_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=2);
    date_of_birth_LENGTH_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=3);
    date_of_birth_WORDS_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=4);
    date_of_birth_Total_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid>0);
    date_of_birth_estimated_ind_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_of_birth_estimated_ind_Invalid=1);
    date_of_birth_estimated_ind_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_birth_estimated_ind_Invalid=2);
    date_of_birth_estimated_ind_LENGTH_ErrorCount := COUNT(GROUP,h.date_of_birth_estimated_ind_Invalid=3);
    date_of_birth_estimated_ind_WORDS_ErrorCount := COUNT(GROUP,h.date_of_birth_estimated_ind_Invalid=4);
    date_of_birth_estimated_ind_Total_ErrorCount := COUNT(GROUP,h.date_of_birth_estimated_ind_Invalid>0);
    phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=3);
    phone_WORDS_ErrorCount := COUNT(GROUP,h.phone_Invalid=4);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    filler3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.filler3_Invalid=1);
    filler3_ALLOW_ErrorCount := COUNT(GROUP,h.filler3_Invalid=2);
    filler3_LENGTH_ErrorCount := COUNT(GROUP,h.filler3_Invalid=3);
    filler3_WORDS_ErrorCount := COUNT(GROUP,h.filler3_Invalid=4);
    filler3_Total_ErrorCount := COUNT(GROUP,h.filler3_Invalid>0);
    prepped_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_name_Invalid=1);
    prepped_name_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_name_Invalid=2);
    prepped_name_LENGTH_ErrorCount := COUNT(GROUP,h.prepped_name_Invalid=3);
    prepped_name_WORDS_ErrorCount := COUNT(GROUP,h.prepped_name_Invalid=4);
    prepped_name_Total_ErrorCount := COUNT(GROUP,h.prepped_name_Invalid>0);
    prepped_addr1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=2);
    prepped_addr1_LENGTH_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=3);
    prepped_addr1_WORDS_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=4);
    prepped_addr1_Total_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid>0);
    prepped_addr2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=2);
    prepped_addr2_LENGTH_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=3);
    prepped_addr2_WORDS_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=4);
    prepped_addr2_Total_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid>0);
    prepped_rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_rec_type_Invalid=1);
    prepped_rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_rec_type_Invalid=2);
    prepped_rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.prepped_rec_type_Invalid=3);
    prepped_rec_type_WORDS_ErrorCount := COUNT(GROUP,h.prepped_rec_type_Invalid=4);
    prepped_rec_type_Total_ErrorCount := COUNT(GROUP,h.prepped_rec_type_Invalid>0);
    isupdating_LEFTTRIM_ErrorCount := COUNT(GROUP,h.isupdating_Invalid=1);
    isupdating_ALLOW_ErrorCount := COUNT(GROUP,h.isupdating_Invalid=2);
    isupdating_LENGTH_ErrorCount := COUNT(GROUP,h.isupdating_Invalid=3);
    isupdating_WORDS_ErrorCount := COUNT(GROUP,h.isupdating_Invalid=4);
    isupdating_Total_ErrorCount := COUNT(GROUP,h.isupdating_Invalid>0);
    iscurrent_LEFTTRIM_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=1);
    iscurrent_ALLOW_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=2);
    iscurrent_LENGTH_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=3);
    iscurrent_WORDS_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid=4);
    iscurrent_Total_ErrorCount := COUNT(GROUP,h.iscurrent_Invalid>0);
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=3);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=4);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=2);
    did_score_LENGTH_ErrorCount := COUNT(GROUP,h.did_score_Invalid=3);
    did_score_WORDS_ErrorCount := COUNT(GROUP,h.did_score_Invalid=4);
    did_score_Total_ErrorCount := COUNT(GROUP,h.did_score_Invalid>0);
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=4);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=4);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=4);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=4);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    clean_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=2);
    clean_phone_LENGTH_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=3);
    clean_phone_WORDS_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=4);
    clean_phone_Total_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid>0);
    clean_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_ssn_Invalid=1);
    clean_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.clean_ssn_Invalid=2);
    clean_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.clean_ssn_Invalid=3);
    clean_ssn_WORDS_ErrorCount := COUNT(GROUP,h.clean_ssn_Invalid=4);
    clean_ssn_Total_ErrorCount := COUNT(GROUP,h.clean_ssn_Invalid>0);
    clean_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=1);
    clean_dob_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=2);
    clean_dob_LENGTH_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=3);
    clean_dob_WORDS_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=4);
    clean_dob_Total_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid>0);
    title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=4);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_WORDS_ErrorCount := COUNT(GROUP,h.fname_Invalid=4);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_WORDS_ErrorCount := COUNT(GROUP,h.mname_Invalid=4);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_WORDS_ErrorCount := COUNT(GROUP,h.lname_Invalid=4);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=4);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    name_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=2);
    name_score_LENGTH_ErrorCount := COUNT(GROUP,h.name_score_Invalid=3);
    name_score_WORDS_ErrorCount := COUNT(GROUP,h.name_score_Invalid=4);
    name_score_Total_ErrorCount := COUNT(GROUP,h.name_score_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_WORDS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=4);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_WORDS_ErrorCount := COUNT(GROUP,h.predir_Invalid=4);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=3);
    prim_name_WORDS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=4);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=3);
    addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=4);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_WORDS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=4);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=4);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=4);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=3);
    p_city_name_WORDS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=4);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=3);
    v_city_name_WORDS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=4);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=3);
    st_WORDS_ErrorCount := COUNT(GROUP,h.st_Invalid=4);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_WORDS_ErrorCount := COUNT(GROUP,h.zip_Invalid=4);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=3);
    zip4_WORDS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=4);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=3);
    cart_WORDS_ErrorCount := COUNT(GROUP,h.cart_Invalid=4);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_LENGTH_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=3);
    cr_sort_sz_WORDS_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=4);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=3);
    lot_WORDS_ErrorCount := COUNT(GROUP,h.lot_Invalid=4);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=3);
    lot_order_WORDS_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=4);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dbpc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=2);
    dbpc_LENGTH_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=3);
    dbpc_WORDS_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=4);
    dbpc_Total_ErrorCount := COUNT(GROUP,h.dbpc_Invalid>0);
    chk_digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=3);
    chk_digit_WORDS_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=4);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=3);
    rec_type_WORDS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=4);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    fips_county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=2);
    fips_county_LENGTH_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=3);
    fips_county_WORDS_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=4);
    fips_county_Total_ErrorCount := COUNT(GROUP,h.fips_county_Invalid>0);
    county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=3);
    county_WORDS_ErrorCount := COUNT(GROUP,h.county_Invalid=4);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    geo_lat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=3);
    geo_lat_WORDS_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=4);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=3);
    geo_long_WORDS_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=4);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=3);
    msa_WORDS_ErrorCount := COUNT(GROUP,h.msa_Invalid=4);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=3);
    geo_blk_WORDS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=4);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=3);
    geo_match_WORDS_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=4);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=3);
    err_stat_WORDS_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=4);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    rawaid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_LENGTH_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=3);
    rawaid_WORDS_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=4);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    isdelete_LEFTTRIM_ErrorCount := COUNT(GROUP,h.isdelete_Invalid=1);
    isdelete_ALLOW_ErrorCount := COUNT(GROUP,h.isdelete_Invalid=2);
    isdelete_LENGTH_ErrorCount := COUNT(GROUP,h.isdelete_Invalid=3);
    isdelete_WORDS_ErrorCount := COUNT(GROUP,h.isdelete_Invalid=4);
    isdelete_Total_ErrorCount := COUNT(GROUP,h.isdelete_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.record_type_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.last_name_Invalid,le.name_prefix_Invalid,le.name_suffix__Invalid,le.perm_id_Invalid,le.ssn_Invalid,le.aka1_Invalid,le.aka2_Invalid,le.aka3_Invalid,le.new_subject_flag_Invalid,le.name_change_flag_Invalid,le.address_change_flag_Invalid,le.ssn_change_flag_Invalid,le.file_since_date_change_flag_Invalid,le.deceased_indicator_flag_Invalid,le.dob_change_flag_Invalid,le.phone_change_flag_Invalid,le.filler2_Invalid,le.gender_Invalid,le.mfdu_indicator_Invalid,le.file_since_date_Invalid,le.house_number_Invalid,le.street_direction_Invalid,le.street_name_Invalid,le.street_type_Invalid,le.street_post_direction_Invalid,le.unit_type_Invalid,le.unit_number_Invalid,le.cty_Invalid,le.state_Invalid,le.zip_code_Invalid,le.zp4_Invalid,le.address_standardization_indicator_Invalid,le.date_address_reported_Invalid,le.party_id_Invalid,le.deceased_indicator_Invalid,le.date_of_birth_Invalid,le.date_of_birth_estimated_ind_Invalid,le.phone_Invalid,le.filler3_Invalid,le.prepped_name_Invalid,le.prepped_addr1_Invalid,le.prepped_addr2_Invalid,le.prepped_rec_type_Invalid,le.isupdating_Invalid,le.iscurrent_Invalid,le.did_Invalid,le.did_score_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_vendor_first_reported_Invalid,le.clean_phone_Invalid,le.clean_ssn_Invalid,le.clean_dob_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_county_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.rawaid_Invalid,le.isdelete_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_name_prefix(le.name_prefix_Invalid),Fields.InvalidMessage_name_suffix_(le.name_suffix__Invalid),Fields.InvalidMessage_perm_id(le.perm_id_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_aka1(le.aka1_Invalid),Fields.InvalidMessage_aka2(le.aka2_Invalid),Fields.InvalidMessage_aka3(le.aka3_Invalid),Fields.InvalidMessage_new_subject_flag(le.new_subject_flag_Invalid),Fields.InvalidMessage_name_change_flag(le.name_change_flag_Invalid),Fields.InvalidMessage_address_change_flag(le.address_change_flag_Invalid),Fields.InvalidMessage_ssn_change_flag(le.ssn_change_flag_Invalid),Fields.InvalidMessage_file_since_date_change_flag(le.file_since_date_change_flag_Invalid),Fields.InvalidMessage_deceased_indicator_flag(le.deceased_indicator_flag_Invalid),Fields.InvalidMessage_dob_change_flag(le.dob_change_flag_Invalid),Fields.InvalidMessage_phone_change_flag(le.phone_change_flag_Invalid),Fields.InvalidMessage_filler2(le.filler2_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_mfdu_indicator(le.mfdu_indicator_Invalid),Fields.InvalidMessage_file_since_date(le.file_since_date_Invalid),Fields.InvalidMessage_house_number(le.house_number_Invalid),Fields.InvalidMessage_street_direction(le.street_direction_Invalid),Fields.InvalidMessage_street_name(le.street_name_Invalid),Fields.InvalidMessage_street_type(le.street_type_Invalid),Fields.InvalidMessage_street_post_direction(le.street_post_direction_Invalid),Fields.InvalidMessage_unit_type(le.unit_type_Invalid),Fields.InvalidMessage_unit_number(le.unit_number_Invalid),Fields.InvalidMessage_cty(le.cty_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Fields.InvalidMessage_zp4(le.zp4_Invalid),Fields.InvalidMessage_address_standardization_indicator(le.address_standardization_indicator_Invalid),Fields.InvalidMessage_date_address_reported(le.date_address_reported_Invalid),Fields.InvalidMessage_party_id(le.party_id_Invalid),Fields.InvalidMessage_deceased_indicator(le.deceased_indicator_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_date_of_birth_estimated_ind(le.date_of_birth_estimated_ind_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_filler3(le.filler3_Invalid),Fields.InvalidMessage_prepped_name(le.prepped_name_Invalid),Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),Fields.InvalidMessage_prepped_rec_type(le.prepped_rec_type_Invalid),Fields.InvalidMessage_isupdating(le.isupdating_Invalid),Fields.InvalidMessage_iscurrent(le.iscurrent_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score(le.did_score_Invalid),Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Fields.InvalidMessage_clean_ssn(le.clean_ssn_Invalid),Fields.InvalidMessage_clean_dob(le.clean_dob_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Fields.InvalidMessage_isdelete(le.isdelete_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.record_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_prefix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix__Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.perm_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.new_subject_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_change_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.address_change_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_change_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.file_since_date_change_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deceased_indicator_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dob_change_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_change_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filler2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mfdu_indicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.file_since_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.house_number_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.street_direction_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.street_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.street_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.street_post_direction_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_type_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cty_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zp4_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.address_standardization_indicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_address_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.party_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deceased_indicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_of_birth_estimated_ind_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.filler3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prepped_rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.isupdating_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.iscurrent_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_dob_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.isdelete_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'record_type','first_name','middle_name','last_name','name_prefix','name_suffix_','perm_id','ssn','aka1','aka2','aka3','new_subject_flag','name_change_flag','address_change_flag','ssn_change_flag','file_since_date_change_flag','deceased_indicator_flag','dob_change_flag','phone_change_flag','filler2','gender','mfdu_indicator','file_since_date','house_number','street_direction','street_name','street_type','street_post_direction','unit_type','unit_number','cty','state','zip_code','zp4','address_standardization_indicator','date_address_reported','party_id','deceased_indicator','date_of_birth','date_of_birth_estimated_ind','phone','filler3','prepped_name','prepped_addr1','prepped_addr2','prepped_rec_type','isupdating','iscurrent','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','clean_phone','clean_ssn','clean_dob','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','isdelete','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'record_type','first_name','middle_name','last_name','name_prefix','name_suffix_','perm_id','ssn','aka1','aka2','aka3','new_subject_flag','name_change_flag','address_change_flag','ssn_change_flag','file_since_date_change_flag','deceased_indicator_flag','dob_change_flag','phone_change_flag','filler2','gender','mfdu_indicator','file_since_date','house_number','street_direction','street_name','street_type','street_post_direction','unit_type','unit_number','cty','state','zip_code','zp4','address_standardization_indicator','date_address_reported','party_id','deceased_indicator','date_of_birth','date_of_birth_estimated_ind','phone','filler3','prepped_name','prepped_addr1','prepped_addr2','prepped_rec_type','isupdating','iscurrent','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','clean_phone','clean_ssn','clean_dob','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','isdelete','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.record_type,(SALT32.StrType)le.first_name,(SALT32.StrType)le.middle_name,(SALT32.StrType)le.last_name,(SALT32.StrType)le.name_prefix,(SALT32.StrType)le.name_suffix_,(SALT32.StrType)le.perm_id,(SALT32.StrType)le.ssn,(SALT32.StrType)le.aka1,(SALT32.StrType)le.aka2,(SALT32.StrType)le.aka3,(SALT32.StrType)le.new_subject_flag,(SALT32.StrType)le.name_change_flag,(SALT32.StrType)le.address_change_flag,(SALT32.StrType)le.ssn_change_flag,(SALT32.StrType)le.file_since_date_change_flag,(SALT32.StrType)le.deceased_indicator_flag,(SALT32.StrType)le.dob_change_flag,(SALT32.StrType)le.phone_change_flag,(SALT32.StrType)le.filler2,(SALT32.StrType)le.gender,(SALT32.StrType)le.mfdu_indicator,(SALT32.StrType)le.file_since_date,(SALT32.StrType)le.house_number,(SALT32.StrType)le.street_direction,(SALT32.StrType)le.street_name,(SALT32.StrType)le.street_type,(SALT32.StrType)le.street_post_direction,(SALT32.StrType)le.unit_type,(SALT32.StrType)le.unit_number,(SALT32.StrType)le.cty,(SALT32.StrType)le.state,(SALT32.StrType)le.zip_code,(SALT32.StrType)le.zp4,(SALT32.StrType)le.address_standardization_indicator,(SALT32.StrType)le.date_address_reported,(SALT32.StrType)le.party_id,(SALT32.StrType)le.deceased_indicator,(SALT32.StrType)le.date_of_birth,(SALT32.StrType)le.date_of_birth_estimated_ind,(SALT32.StrType)le.phone,(SALT32.StrType)le.filler3,(SALT32.StrType)le.prepped_name,(SALT32.StrType)le.prepped_addr1,(SALT32.StrType)le.prepped_addr2,(SALT32.StrType)le.prepped_rec_type,(SALT32.StrType)le.isupdating,(SALT32.StrType)le.iscurrent,(SALT32.StrType)le.did,(SALT32.StrType)le.did_score,(SALT32.StrType)le.dt_first_seen,(SALT32.StrType)le.dt_last_seen,(SALT32.StrType)le.dt_vendor_last_reported,(SALT32.StrType)le.dt_vendor_first_reported,(SALT32.StrType)le.clean_phone,(SALT32.StrType)le.clean_ssn,(SALT32.StrType)le.clean_dob,(SALT32.StrType)le.title,(SALT32.StrType)le.fname,(SALT32.StrType)le.mname,(SALT32.StrType)le.lname,(SALT32.StrType)le.name_suffix,(SALT32.StrType)le.name_score,(SALT32.StrType)le.prim_range,(SALT32.StrType)le.predir,(SALT32.StrType)le.prim_name,(SALT32.StrType)le.addr_suffix,(SALT32.StrType)le.postdir,(SALT32.StrType)le.unit_desig,(SALT32.StrType)le.sec_range,(SALT32.StrType)le.p_city_name,(SALT32.StrType)le.v_city_name,(SALT32.StrType)le.st,(SALT32.StrType)le.zip,(SALT32.StrType)le.zip4,(SALT32.StrType)le.cart,(SALT32.StrType)le.cr_sort_sz,(SALT32.StrType)le.lot,(SALT32.StrType)le.lot_order,(SALT32.StrType)le.dbpc,(SALT32.StrType)le.chk_digit,(SALT32.StrType)le.rec_type,(SALT32.StrType)le.fips_county,(SALT32.StrType)le.county,(SALT32.StrType)le.geo_lat,(SALT32.StrType)le.geo_long,(SALT32.StrType)le.msa,(SALT32.StrType)le.geo_blk,(SALT32.StrType)le.geo_match,(SALT32.StrType)le.err_stat,(SALT32.StrType)le.rawaid,(SALT32.StrType)le.isdelete,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,92,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'record_type:record_type:LEFTTRIM','record_type:record_type:ALLOW','record_type:record_type:LENGTH','record_type:record_type:WORDS'
          ,'first_name:first_name:LEFTTRIM','first_name:first_name:ALLOW','first_name:first_name:LENGTH','first_name:first_name:WORDS'
          ,'middle_name:middle_name:LEFTTRIM','middle_name:middle_name:ALLOW','middle_name:middle_name:LENGTH','middle_name:middle_name:WORDS'
          ,'last_name:last_name:LEFTTRIM','last_name:last_name:ALLOW','last_name:last_name:LENGTH','last_name:last_name:WORDS'
          ,'name_prefix:name_prefix:LEFTTRIM','name_prefix:name_prefix:ALLOW','name_prefix:name_prefix:LENGTH','name_prefix:name_prefix:WORDS'
          ,'name_suffix_:name_suffix_:ALLOW','name_suffix_:name_suffix_:LENGTH','name_suffix_:name_suffix_:WORDS'
          ,'perm_id:perm_id:LEFTTRIM','perm_id:perm_id:ALLOW','perm_id:perm_id:LENGTH','perm_id:perm_id:WORDS'
          ,'ssn:ssn:LEFTTRIM','ssn:ssn:ALLOW','ssn:ssn:LENGTH','ssn:ssn:WORDS'
          ,'aka1:aka1:LEFTTRIM','aka1:aka1:ALLOW','aka1:aka1:LENGTH','aka1:aka1:WORDS'
          ,'aka2:aka2:LEFTTRIM','aka2:aka2:ALLOW','aka2:aka2:LENGTH','aka2:aka2:WORDS'
          ,'aka3:aka3:LEFTTRIM','aka3:aka3:ALLOW','aka3:aka3:LENGTH','aka3:aka3:WORDS'
          ,'new_subject_flag:new_subject_flag:LEFTTRIM','new_subject_flag:new_subject_flag:ALLOW','new_subject_flag:new_subject_flag:LENGTH','new_subject_flag:new_subject_flag:WORDS'
          ,'name_change_flag:name_change_flag:LEFTTRIM','name_change_flag:name_change_flag:ALLOW','name_change_flag:name_change_flag:LENGTH','name_change_flag:name_change_flag:WORDS'
          ,'address_change_flag:address_change_flag:LEFTTRIM','address_change_flag:address_change_flag:ALLOW','address_change_flag:address_change_flag:LENGTH','address_change_flag:address_change_flag:WORDS'
          ,'ssn_change_flag:ssn_change_flag:LEFTTRIM','ssn_change_flag:ssn_change_flag:ALLOW','ssn_change_flag:ssn_change_flag:LENGTH','ssn_change_flag:ssn_change_flag:WORDS'
          ,'file_since_date_change_flag:file_since_date_change_flag:LEFTTRIM','file_since_date_change_flag:file_since_date_change_flag:ALLOW','file_since_date_change_flag:file_since_date_change_flag:LENGTH','file_since_date_change_flag:file_since_date_change_flag:WORDS'
          ,'deceased_indicator_flag:deceased_indicator_flag:LEFTTRIM','deceased_indicator_flag:deceased_indicator_flag:ALLOW','deceased_indicator_flag:deceased_indicator_flag:LENGTH','deceased_indicator_flag:deceased_indicator_flag:WORDS'
          ,'dob_change_flag:dob_change_flag:LEFTTRIM','dob_change_flag:dob_change_flag:ALLOW','dob_change_flag:dob_change_flag:LENGTH','dob_change_flag:dob_change_flag:WORDS'
          ,'phone_change_flag:phone_change_flag:LEFTTRIM','phone_change_flag:phone_change_flag:ALLOW','phone_change_flag:phone_change_flag:LENGTH','phone_change_flag:phone_change_flag:WORDS'
          ,'filler2:filler2:LEFTTRIM','filler2:filler2:ALLOW','filler2:filler2:LENGTH','filler2:filler2:WORDS'
          ,'gender:gender:LEFTTRIM','gender:gender:ALLOW','gender:gender:LENGTH','gender:gender:WORDS'
          ,'mfdu_indicator:mfdu_indicator:LEFTTRIM','mfdu_indicator:mfdu_indicator:ALLOW','mfdu_indicator:mfdu_indicator:LENGTH','mfdu_indicator:mfdu_indicator:WORDS'
          ,'file_since_date:file_since_date:LEFTTRIM','file_since_date:file_since_date:ALLOW','file_since_date:file_since_date:LENGTH','file_since_date:file_since_date:WORDS'
          ,'house_number:house_number:ALLOW','house_number:house_number:LENGTH','house_number:house_number:WORDS'
          ,'street_direction:street_direction:LEFTTRIM','street_direction:street_direction:ALLOW','street_direction:street_direction:LENGTH','street_direction:street_direction:WORDS'
          ,'street_name:street_name:LEFTTRIM','street_name:street_name:ALLOW','street_name:street_name:LENGTH','street_name:street_name:WORDS'
          ,'street_type:street_type:LEFTTRIM','street_type:street_type:ALLOW','street_type:street_type:LENGTH','street_type:street_type:WORDS'
          ,'street_post_direction:street_post_direction:LEFTTRIM','street_post_direction:street_post_direction:ALLOW','street_post_direction:street_post_direction:LENGTH','street_post_direction:street_post_direction:WORDS'
          ,'unit_type:unit_type:ALLOW','unit_type:unit_type:LENGTH','unit_type:unit_type:WORDS'
          ,'unit_number:unit_number:LEFTTRIM','unit_number:unit_number:ALLOW','unit_number:unit_number:LENGTH','unit_number:unit_number:WORDS'
          ,'cty:cty:LEFTTRIM','cty:cty:ALLOW','cty:cty:LENGTH','cty:cty:WORDS'
          ,'state:state:LEFTTRIM','state:state:ALLOW','state:state:LENGTH','state:state:WORDS'
          ,'zip_code:zip_code:LEFTTRIM','zip_code:zip_code:ALLOW','zip_code:zip_code:LENGTH','zip_code:zip_code:WORDS'
          ,'zp4:zp4:ALLOW','zp4:zp4:LENGTH','zp4:zp4:WORDS'
          ,'address_standardization_indicator:address_standardization_indicator:LEFTTRIM','address_standardization_indicator:address_standardization_indicator:ALLOW','address_standardization_indicator:address_standardization_indicator:LENGTH','address_standardization_indicator:address_standardization_indicator:WORDS'
          ,'date_address_reported:date_address_reported:LEFTTRIM','date_address_reported:date_address_reported:ALLOW','date_address_reported:date_address_reported:LENGTH','date_address_reported:date_address_reported:WORDS'
          ,'party_id:party_id:LEFTTRIM','party_id:party_id:ALLOW','party_id:party_id:LENGTH','party_id:party_id:WORDS'
          ,'deceased_indicator:deceased_indicator:LEFTTRIM','deceased_indicator:deceased_indicator:ALLOW','deceased_indicator:deceased_indicator:LENGTH','deceased_indicator:deceased_indicator:WORDS'
          ,'date_of_birth:date_of_birth:LEFTTRIM','date_of_birth:date_of_birth:ALLOW','date_of_birth:date_of_birth:LENGTH','date_of_birth:date_of_birth:WORDS'
          ,'date_of_birth_estimated_ind:date_of_birth_estimated_ind:LEFTTRIM','date_of_birth_estimated_ind:date_of_birth_estimated_ind:ALLOW','date_of_birth_estimated_ind:date_of_birth_estimated_ind:LENGTH','date_of_birth_estimated_ind:date_of_birth_estimated_ind:WORDS'
          ,'phone:phone:LEFTTRIM','phone:phone:ALLOW','phone:phone:LENGTH','phone:phone:WORDS'
          ,'filler3:filler3:LEFTTRIM','filler3:filler3:ALLOW','filler3:filler3:LENGTH','filler3:filler3:WORDS'
          ,'prepped_name:prepped_name:LEFTTRIM','prepped_name:prepped_name:ALLOW','prepped_name:prepped_name:LENGTH','prepped_name:prepped_name:WORDS'
          ,'prepped_addr1:prepped_addr1:LEFTTRIM','prepped_addr1:prepped_addr1:ALLOW','prepped_addr1:prepped_addr1:LENGTH','prepped_addr1:prepped_addr1:WORDS'
          ,'prepped_addr2:prepped_addr2:LEFTTRIM','prepped_addr2:prepped_addr2:ALLOW','prepped_addr2:prepped_addr2:LENGTH','prepped_addr2:prepped_addr2:WORDS'
          ,'prepped_rec_type:prepped_rec_type:LEFTTRIM','prepped_rec_type:prepped_rec_type:ALLOW','prepped_rec_type:prepped_rec_type:LENGTH','prepped_rec_type:prepped_rec_type:WORDS'
          ,'isupdating:isupdating:LEFTTRIM','isupdating:isupdating:ALLOW','isupdating:isupdating:LENGTH','isupdating:isupdating:WORDS'
          ,'iscurrent:iscurrent:LEFTTRIM','iscurrent:iscurrent:ALLOW','iscurrent:iscurrent:LENGTH','iscurrent:iscurrent:WORDS'
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTH','did:did:WORDS'
          ,'did_score:did_score:LEFTTRIM','did_score:did_score:ALLOW','did_score:did_score:LENGTH','did_score:did_score:WORDS'
          ,'dt_first_seen:dt_first_seen:LEFTTRIM','dt_first_seen:dt_first_seen:ALLOW','dt_first_seen:dt_first_seen:LENGTH','dt_first_seen:dt_first_seen:WORDS'
          ,'dt_last_seen:dt_last_seen:LEFTTRIM','dt_last_seen:dt_last_seen:ALLOW','dt_last_seen:dt_last_seen:LENGTH','dt_last_seen:dt_last_seen:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTH','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTH','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'clean_phone:clean_phone:LEFTTRIM','clean_phone:clean_phone:ALLOW','clean_phone:clean_phone:LENGTH','clean_phone:clean_phone:WORDS'
          ,'clean_ssn:clean_ssn:LEFTTRIM','clean_ssn:clean_ssn:ALLOW','clean_ssn:clean_ssn:LENGTH','clean_ssn:clean_ssn:WORDS'
          ,'clean_dob:clean_dob:LEFTTRIM','clean_dob:clean_dob:ALLOW','clean_dob:clean_dob:LENGTH','clean_dob:clean_dob:WORDS'
          ,'title:title:LEFTTRIM','title:title:ALLOW','title:title:LENGTH','title:title:WORDS'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW','fname:fname:LENGTH','fname:fname:WORDS'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW','mname:mname:LENGTH','mname:mname:WORDS'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW','lname:lname:LENGTH','lname:lname:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTH','name_suffix:name_suffix:WORDS'
          ,'name_score:name_score:LEFTTRIM','name_score:name_score:ALLOW','name_score:name_score:LENGTH','name_score:name_score:WORDS'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW','prim_range:prim_range:LENGTH','prim_range:prim_range:WORDS'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW','predir:predir:LENGTH','predir:predir:WORDS'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW','prim_name:prim_name:LENGTH','prim_name:prim_name:WORDS'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW','addr_suffix:addr_suffix:LENGTH','addr_suffix:addr_suffix:WORDS'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW','postdir:postdir:LENGTH','postdir:postdir:WORDS'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW','unit_desig:unit_desig:LENGTH','unit_desig:unit_desig:WORDS'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTH','sec_range:sec_range:WORDS'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW','p_city_name:p_city_name:LENGTH','p_city_name:p_city_name:WORDS'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW','v_city_name:v_city_name:LENGTH','v_city_name:v_city_name:WORDS'
          ,'st:st:LEFTTRIM','st:st:ALLOW','st:st:LENGTH','st:st:WORDS'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW','zip:zip:LENGTH','zip:zip:WORDS'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW','zip4:zip4:LENGTH','zip4:zip4:WORDS'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW','cart:cart:LENGTH','cart:cart:WORDS'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW','cr_sort_sz:cr_sort_sz:LENGTH','cr_sort_sz:cr_sort_sz:WORDS'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW','lot:lot:LENGTH','lot:lot:WORDS'
          ,'lot_order:lot_order:LEFTTRIM','lot_order:lot_order:ALLOW','lot_order:lot_order:LENGTH','lot_order:lot_order:WORDS'
          ,'dbpc:dbpc:LEFTTRIM','dbpc:dbpc:ALLOW','dbpc:dbpc:LENGTH','dbpc:dbpc:WORDS'
          ,'chk_digit:chk_digit:LEFTTRIM','chk_digit:chk_digit:ALLOW','chk_digit:chk_digit:LENGTH','chk_digit:chk_digit:WORDS'
          ,'rec_type:rec_type:LEFTTRIM','rec_type:rec_type:ALLOW','rec_type:rec_type:LENGTH','rec_type:rec_type:WORDS'
          ,'fips_county:fips_county:LEFTTRIM','fips_county:fips_county:ALLOW','fips_county:fips_county:LENGTH','fips_county:fips_county:WORDS'
          ,'county:county:LEFTTRIM','county:county:ALLOW','county:county:LENGTH','county:county:WORDS'
          ,'geo_lat:geo_lat:LEFTTRIM','geo_lat:geo_lat:ALLOW','geo_lat:geo_lat:LENGTH','geo_lat:geo_lat:WORDS'
          ,'geo_long:geo_long:LEFTTRIM','geo_long:geo_long:ALLOW','geo_long:geo_long:LENGTH','geo_long:geo_long:WORDS'
          ,'msa:msa:LEFTTRIM','msa:msa:ALLOW','msa:msa:LENGTH','msa:msa:WORDS'
          ,'geo_blk:geo_blk:LEFTTRIM','geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTH','geo_blk:geo_blk:WORDS'
          ,'geo_match:geo_match:LEFTTRIM','geo_match:geo_match:ALLOW','geo_match:geo_match:LENGTH','geo_match:geo_match:WORDS'
          ,'err_stat:err_stat:LEFTTRIM','err_stat:err_stat:ALLOW','err_stat:err_stat:LENGTH','err_stat:err_stat:WORDS'
          ,'rawaid:rawaid:LEFTTRIM','rawaid:rawaid:ALLOW','rawaid:rawaid:LENGTH','rawaid:rawaid:WORDS'
          ,'isdelete:isdelete:LEFTTRIM','isdelete:isdelete:ALLOW','isdelete:isdelete:LENGTH','isdelete:isdelete:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_record_type(1),Fields.InvalidMessage_record_type(2),Fields.InvalidMessage_record_type(3),Fields.InvalidMessage_record_type(4)
          ,Fields.InvalidMessage_first_name(1),Fields.InvalidMessage_first_name(2),Fields.InvalidMessage_first_name(3),Fields.InvalidMessage_first_name(4)
          ,Fields.InvalidMessage_middle_name(1),Fields.InvalidMessage_middle_name(2),Fields.InvalidMessage_middle_name(3),Fields.InvalidMessage_middle_name(4)
          ,Fields.InvalidMessage_last_name(1),Fields.InvalidMessage_last_name(2),Fields.InvalidMessage_last_name(3),Fields.InvalidMessage_last_name(4)
          ,Fields.InvalidMessage_name_prefix(1),Fields.InvalidMessage_name_prefix(2),Fields.InvalidMessage_name_prefix(3),Fields.InvalidMessage_name_prefix(4)
          ,Fields.InvalidMessage_name_suffix_(1),Fields.InvalidMessage_name_suffix_(2),Fields.InvalidMessage_name_suffix_(3)
          ,Fields.InvalidMessage_perm_id(1),Fields.InvalidMessage_perm_id(2),Fields.InvalidMessage_perm_id(3),Fields.InvalidMessage_perm_id(4)
          ,Fields.InvalidMessage_ssn(1),Fields.InvalidMessage_ssn(2),Fields.InvalidMessage_ssn(3),Fields.InvalidMessage_ssn(4)
          ,Fields.InvalidMessage_aka1(1),Fields.InvalidMessage_aka1(2),Fields.InvalidMessage_aka1(3),Fields.InvalidMessage_aka1(4)
          ,Fields.InvalidMessage_aka2(1),Fields.InvalidMessage_aka2(2),Fields.InvalidMessage_aka2(3),Fields.InvalidMessage_aka2(4)
          ,Fields.InvalidMessage_aka3(1),Fields.InvalidMessage_aka3(2),Fields.InvalidMessage_aka3(3),Fields.InvalidMessage_aka3(4)
          ,Fields.InvalidMessage_new_subject_flag(1),Fields.InvalidMessage_new_subject_flag(2),Fields.InvalidMessage_new_subject_flag(3),Fields.InvalidMessage_new_subject_flag(4)
          ,Fields.InvalidMessage_name_change_flag(1),Fields.InvalidMessage_name_change_flag(2),Fields.InvalidMessage_name_change_flag(3),Fields.InvalidMessage_name_change_flag(4)
          ,Fields.InvalidMessage_address_change_flag(1),Fields.InvalidMessage_address_change_flag(2),Fields.InvalidMessage_address_change_flag(3),Fields.InvalidMessage_address_change_flag(4)
          ,Fields.InvalidMessage_ssn_change_flag(1),Fields.InvalidMessage_ssn_change_flag(2),Fields.InvalidMessage_ssn_change_flag(3),Fields.InvalidMessage_ssn_change_flag(4)
          ,Fields.InvalidMessage_file_since_date_change_flag(1),Fields.InvalidMessage_file_since_date_change_flag(2),Fields.InvalidMessage_file_since_date_change_flag(3),Fields.InvalidMessage_file_since_date_change_flag(4)
          ,Fields.InvalidMessage_deceased_indicator_flag(1),Fields.InvalidMessage_deceased_indicator_flag(2),Fields.InvalidMessage_deceased_indicator_flag(3),Fields.InvalidMessage_deceased_indicator_flag(4)
          ,Fields.InvalidMessage_dob_change_flag(1),Fields.InvalidMessage_dob_change_flag(2),Fields.InvalidMessage_dob_change_flag(3),Fields.InvalidMessage_dob_change_flag(4)
          ,Fields.InvalidMessage_phone_change_flag(1),Fields.InvalidMessage_phone_change_flag(2),Fields.InvalidMessage_phone_change_flag(3),Fields.InvalidMessage_phone_change_flag(4)
          ,Fields.InvalidMessage_filler2(1),Fields.InvalidMessage_filler2(2),Fields.InvalidMessage_filler2(3),Fields.InvalidMessage_filler2(4)
          ,Fields.InvalidMessage_gender(1),Fields.InvalidMessage_gender(2),Fields.InvalidMessage_gender(3),Fields.InvalidMessage_gender(4)
          ,Fields.InvalidMessage_mfdu_indicator(1),Fields.InvalidMessage_mfdu_indicator(2),Fields.InvalidMessage_mfdu_indicator(3),Fields.InvalidMessage_mfdu_indicator(4)
          ,Fields.InvalidMessage_file_since_date(1),Fields.InvalidMessage_file_since_date(2),Fields.InvalidMessage_file_since_date(3),Fields.InvalidMessage_file_since_date(4)
          ,Fields.InvalidMessage_house_number(1),Fields.InvalidMessage_house_number(2),Fields.InvalidMessage_house_number(3)
          ,Fields.InvalidMessage_street_direction(1),Fields.InvalidMessage_street_direction(2),Fields.InvalidMessage_street_direction(3),Fields.InvalidMessage_street_direction(4)
          ,Fields.InvalidMessage_street_name(1),Fields.InvalidMessage_street_name(2),Fields.InvalidMessage_street_name(3),Fields.InvalidMessage_street_name(4)
          ,Fields.InvalidMessage_street_type(1),Fields.InvalidMessage_street_type(2),Fields.InvalidMessage_street_type(3),Fields.InvalidMessage_street_type(4)
          ,Fields.InvalidMessage_street_post_direction(1),Fields.InvalidMessage_street_post_direction(2),Fields.InvalidMessage_street_post_direction(3),Fields.InvalidMessage_street_post_direction(4)
          ,Fields.InvalidMessage_unit_type(1),Fields.InvalidMessage_unit_type(2),Fields.InvalidMessage_unit_type(3)
          ,Fields.InvalidMessage_unit_number(1),Fields.InvalidMessage_unit_number(2),Fields.InvalidMessage_unit_number(3),Fields.InvalidMessage_unit_number(4)
          ,Fields.InvalidMessage_cty(1),Fields.InvalidMessage_cty(2),Fields.InvalidMessage_cty(3),Fields.InvalidMessage_cty(4)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2),Fields.InvalidMessage_state(3),Fields.InvalidMessage_state(4)
          ,Fields.InvalidMessage_zip_code(1),Fields.InvalidMessage_zip_code(2),Fields.InvalidMessage_zip_code(3),Fields.InvalidMessage_zip_code(4)
          ,Fields.InvalidMessage_zp4(1),Fields.InvalidMessage_zp4(2),Fields.InvalidMessage_zp4(3)
          ,Fields.InvalidMessage_address_standardization_indicator(1),Fields.InvalidMessage_address_standardization_indicator(2),Fields.InvalidMessage_address_standardization_indicator(3),Fields.InvalidMessage_address_standardization_indicator(4)
          ,Fields.InvalidMessage_date_address_reported(1),Fields.InvalidMessage_date_address_reported(2),Fields.InvalidMessage_date_address_reported(3),Fields.InvalidMessage_date_address_reported(4)
          ,Fields.InvalidMessage_party_id(1),Fields.InvalidMessage_party_id(2),Fields.InvalidMessage_party_id(3),Fields.InvalidMessage_party_id(4)
          ,Fields.InvalidMessage_deceased_indicator(1),Fields.InvalidMessage_deceased_indicator(2),Fields.InvalidMessage_deceased_indicator(3),Fields.InvalidMessage_deceased_indicator(4)
          ,Fields.InvalidMessage_date_of_birth(1),Fields.InvalidMessage_date_of_birth(2),Fields.InvalidMessage_date_of_birth(3),Fields.InvalidMessage_date_of_birth(4)
          ,Fields.InvalidMessage_date_of_birth_estimated_ind(1),Fields.InvalidMessage_date_of_birth_estimated_ind(2),Fields.InvalidMessage_date_of_birth_estimated_ind(3),Fields.InvalidMessage_date_of_birth_estimated_ind(4)
          ,Fields.InvalidMessage_phone(1),Fields.InvalidMessage_phone(2),Fields.InvalidMessage_phone(3),Fields.InvalidMessage_phone(4)
          ,Fields.InvalidMessage_filler3(1),Fields.InvalidMessage_filler3(2),Fields.InvalidMessage_filler3(3),Fields.InvalidMessage_filler3(4)
          ,Fields.InvalidMessage_prepped_name(1),Fields.InvalidMessage_prepped_name(2),Fields.InvalidMessage_prepped_name(3),Fields.InvalidMessage_prepped_name(4)
          ,Fields.InvalidMessage_prepped_addr1(1),Fields.InvalidMessage_prepped_addr1(2),Fields.InvalidMessage_prepped_addr1(3),Fields.InvalidMessage_prepped_addr1(4)
          ,Fields.InvalidMessage_prepped_addr2(1),Fields.InvalidMessage_prepped_addr2(2),Fields.InvalidMessage_prepped_addr2(3),Fields.InvalidMessage_prepped_addr2(4)
          ,Fields.InvalidMessage_prepped_rec_type(1),Fields.InvalidMessage_prepped_rec_type(2),Fields.InvalidMessage_prepped_rec_type(3),Fields.InvalidMessage_prepped_rec_type(4)
          ,Fields.InvalidMessage_isupdating(1),Fields.InvalidMessage_isupdating(2),Fields.InvalidMessage_isupdating(3),Fields.InvalidMessage_isupdating(4)
          ,Fields.InvalidMessage_iscurrent(1),Fields.InvalidMessage_iscurrent(2),Fields.InvalidMessage_iscurrent(3),Fields.InvalidMessage_iscurrent(4)
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2),Fields.InvalidMessage_did(3),Fields.InvalidMessage_did(4)
          ,Fields.InvalidMessage_did_score(1),Fields.InvalidMessage_did_score(2),Fields.InvalidMessage_did_score(3),Fields.InvalidMessage_did_score(4)
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2),Fields.InvalidMessage_dt_first_seen(3),Fields.InvalidMessage_dt_first_seen(4)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2),Fields.InvalidMessage_dt_last_seen(3),Fields.InvalidMessage_dt_last_seen(4)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2),Fields.InvalidMessage_dt_vendor_last_reported(3),Fields.InvalidMessage_dt_vendor_last_reported(4)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2),Fields.InvalidMessage_dt_vendor_first_reported(3),Fields.InvalidMessage_dt_vendor_first_reported(4)
          ,Fields.InvalidMessage_clean_phone(1),Fields.InvalidMessage_clean_phone(2),Fields.InvalidMessage_clean_phone(3),Fields.InvalidMessage_clean_phone(4)
          ,Fields.InvalidMessage_clean_ssn(1),Fields.InvalidMessage_clean_ssn(2),Fields.InvalidMessage_clean_ssn(3),Fields.InvalidMessage_clean_ssn(4)
          ,Fields.InvalidMessage_clean_dob(1),Fields.InvalidMessage_clean_dob(2),Fields.InvalidMessage_clean_dob(3),Fields.InvalidMessage_clean_dob(4)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2),Fields.InvalidMessage_title(3),Fields.InvalidMessage_title(4)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2),Fields.InvalidMessage_fname(3),Fields.InvalidMessage_fname(4)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2),Fields.InvalidMessage_mname(3),Fields.InvalidMessage_mname(4)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3),Fields.InvalidMessage_lname(4)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3),Fields.InvalidMessage_name_suffix(4)
          ,Fields.InvalidMessage_name_score(1),Fields.InvalidMessage_name_score(2),Fields.InvalidMessage_name_score(3),Fields.InvalidMessage_name_score(4)
          ,Fields.InvalidMessage_prim_range(1),Fields.InvalidMessage_prim_range(2),Fields.InvalidMessage_prim_range(3),Fields.InvalidMessage_prim_range(4)
          ,Fields.InvalidMessage_predir(1),Fields.InvalidMessage_predir(2),Fields.InvalidMessage_predir(3),Fields.InvalidMessage_predir(4)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2),Fields.InvalidMessage_prim_name(3),Fields.InvalidMessage_prim_name(4)
          ,Fields.InvalidMessage_addr_suffix(1),Fields.InvalidMessage_addr_suffix(2),Fields.InvalidMessage_addr_suffix(3),Fields.InvalidMessage_addr_suffix(4)
          ,Fields.InvalidMessage_postdir(1),Fields.InvalidMessage_postdir(2),Fields.InvalidMessage_postdir(3),Fields.InvalidMessage_postdir(4)
          ,Fields.InvalidMessage_unit_desig(1),Fields.InvalidMessage_unit_desig(2),Fields.InvalidMessage_unit_desig(3),Fields.InvalidMessage_unit_desig(4)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2),Fields.InvalidMessage_sec_range(3),Fields.InvalidMessage_sec_range(4)
          ,Fields.InvalidMessage_p_city_name(1),Fields.InvalidMessage_p_city_name(2),Fields.InvalidMessage_p_city_name(3),Fields.InvalidMessage_p_city_name(4)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2),Fields.InvalidMessage_v_city_name(3),Fields.InvalidMessage_v_city_name(4)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2),Fields.InvalidMessage_st(3),Fields.InvalidMessage_st(4)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2),Fields.InvalidMessage_zip(3),Fields.InvalidMessage_zip(4)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2),Fields.InvalidMessage_zip4(3),Fields.InvalidMessage_zip4(4)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2),Fields.InvalidMessage_cart(3),Fields.InvalidMessage_cart(4)
          ,Fields.InvalidMessage_cr_sort_sz(1),Fields.InvalidMessage_cr_sort_sz(2),Fields.InvalidMessage_cr_sort_sz(3),Fields.InvalidMessage_cr_sort_sz(4)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2),Fields.InvalidMessage_lot(3),Fields.InvalidMessage_lot(4)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2),Fields.InvalidMessage_lot_order(3),Fields.InvalidMessage_lot_order(4)
          ,Fields.InvalidMessage_dbpc(1),Fields.InvalidMessage_dbpc(2),Fields.InvalidMessage_dbpc(3),Fields.InvalidMessage_dbpc(4)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2),Fields.InvalidMessage_chk_digit(3),Fields.InvalidMessage_chk_digit(4)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2),Fields.InvalidMessage_rec_type(3),Fields.InvalidMessage_rec_type(4)
          ,Fields.InvalidMessage_fips_county(1),Fields.InvalidMessage_fips_county(2),Fields.InvalidMessage_fips_county(3),Fields.InvalidMessage_fips_county(4)
          ,Fields.InvalidMessage_county(1),Fields.InvalidMessage_county(2),Fields.InvalidMessage_county(3),Fields.InvalidMessage_county(4)
          ,Fields.InvalidMessage_geo_lat(1),Fields.InvalidMessage_geo_lat(2),Fields.InvalidMessage_geo_lat(3),Fields.InvalidMessage_geo_lat(4)
          ,Fields.InvalidMessage_geo_long(1),Fields.InvalidMessage_geo_long(2),Fields.InvalidMessage_geo_long(3),Fields.InvalidMessage_geo_long(4)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2),Fields.InvalidMessage_msa(3),Fields.InvalidMessage_msa(4)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2),Fields.InvalidMessage_geo_blk(3),Fields.InvalidMessage_geo_blk(4)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2),Fields.InvalidMessage_geo_match(3),Fields.InvalidMessage_geo_match(4)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2),Fields.InvalidMessage_err_stat(3),Fields.InvalidMessage_err_stat(4)
          ,Fields.InvalidMessage_rawaid(1),Fields.InvalidMessage_rawaid(2),Fields.InvalidMessage_rawaid(3),Fields.InvalidMessage_rawaid(4)
          ,Fields.InvalidMessage_isdelete(1),Fields.InvalidMessage_isdelete(2),Fields.InvalidMessage_isdelete(3),Fields.InvalidMessage_isdelete(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount,le.record_type_LENGTH_ErrorCount,le.record_type_WORDS_ErrorCount
          ,le.first_name_LEFTTRIM_ErrorCount,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount,le.first_name_WORDS_ErrorCount
          ,le.middle_name_LEFTTRIM_ErrorCount,le.middle_name_ALLOW_ErrorCount,le.middle_name_LENGTH_ErrorCount,le.middle_name_WORDS_ErrorCount
          ,le.last_name_LEFTTRIM_ErrorCount,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount,le.last_name_WORDS_ErrorCount
          ,le.name_prefix_LEFTTRIM_ErrorCount,le.name_prefix_ALLOW_ErrorCount,le.name_prefix_LENGTH_ErrorCount,le.name_prefix_WORDS_ErrorCount
          ,le.name_suffix__ALLOW_ErrorCount,le.name_suffix__LENGTH_ErrorCount,le.name_suffix__WORDS_ErrorCount
          ,le.perm_id_LEFTTRIM_ErrorCount,le.perm_id_ALLOW_ErrorCount,le.perm_id_LENGTH_ErrorCount,le.perm_id_WORDS_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.aka1_LEFTTRIM_ErrorCount,le.aka1_ALLOW_ErrorCount,le.aka1_LENGTH_ErrorCount,le.aka1_WORDS_ErrorCount
          ,le.aka2_LEFTTRIM_ErrorCount,le.aka2_ALLOW_ErrorCount,le.aka2_LENGTH_ErrorCount,le.aka2_WORDS_ErrorCount
          ,le.aka3_LEFTTRIM_ErrorCount,le.aka3_ALLOW_ErrorCount,le.aka3_LENGTH_ErrorCount,le.aka3_WORDS_ErrorCount
          ,le.new_subject_flag_LEFTTRIM_ErrorCount,le.new_subject_flag_ALLOW_ErrorCount,le.new_subject_flag_LENGTH_ErrorCount,le.new_subject_flag_WORDS_ErrorCount
          ,le.name_change_flag_LEFTTRIM_ErrorCount,le.name_change_flag_ALLOW_ErrorCount,le.name_change_flag_LENGTH_ErrorCount,le.name_change_flag_WORDS_ErrorCount
          ,le.address_change_flag_LEFTTRIM_ErrorCount,le.address_change_flag_ALLOW_ErrorCount,le.address_change_flag_LENGTH_ErrorCount,le.address_change_flag_WORDS_ErrorCount
          ,le.ssn_change_flag_LEFTTRIM_ErrorCount,le.ssn_change_flag_ALLOW_ErrorCount,le.ssn_change_flag_LENGTH_ErrorCount,le.ssn_change_flag_WORDS_ErrorCount
          ,le.file_since_date_change_flag_LEFTTRIM_ErrorCount,le.file_since_date_change_flag_ALLOW_ErrorCount,le.file_since_date_change_flag_LENGTH_ErrorCount,le.file_since_date_change_flag_WORDS_ErrorCount
          ,le.deceased_indicator_flag_LEFTTRIM_ErrorCount,le.deceased_indicator_flag_ALLOW_ErrorCount,le.deceased_indicator_flag_LENGTH_ErrorCount,le.deceased_indicator_flag_WORDS_ErrorCount
          ,le.dob_change_flag_LEFTTRIM_ErrorCount,le.dob_change_flag_ALLOW_ErrorCount,le.dob_change_flag_LENGTH_ErrorCount,le.dob_change_flag_WORDS_ErrorCount
          ,le.phone_change_flag_LEFTTRIM_ErrorCount,le.phone_change_flag_ALLOW_ErrorCount,le.phone_change_flag_LENGTH_ErrorCount,le.phone_change_flag_WORDS_ErrorCount
          ,le.filler2_LEFTTRIM_ErrorCount,le.filler2_ALLOW_ErrorCount,le.filler2_LENGTH_ErrorCount,le.filler2_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTH_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.mfdu_indicator_LEFTTRIM_ErrorCount,le.mfdu_indicator_ALLOW_ErrorCount,le.mfdu_indicator_LENGTH_ErrorCount,le.mfdu_indicator_WORDS_ErrorCount
          ,le.file_since_date_LEFTTRIM_ErrorCount,le.file_since_date_ALLOW_ErrorCount,le.file_since_date_LENGTH_ErrorCount,le.file_since_date_WORDS_ErrorCount
          ,le.house_number_ALLOW_ErrorCount,le.house_number_LENGTH_ErrorCount,le.house_number_WORDS_ErrorCount
          ,le.street_direction_LEFTTRIM_ErrorCount,le.street_direction_ALLOW_ErrorCount,le.street_direction_LENGTH_ErrorCount,le.street_direction_WORDS_ErrorCount
          ,le.street_name_LEFTTRIM_ErrorCount,le.street_name_ALLOW_ErrorCount,le.street_name_LENGTH_ErrorCount,le.street_name_WORDS_ErrorCount
          ,le.street_type_LEFTTRIM_ErrorCount,le.street_type_ALLOW_ErrorCount,le.street_type_LENGTH_ErrorCount,le.street_type_WORDS_ErrorCount
          ,le.street_post_direction_LEFTTRIM_ErrorCount,le.street_post_direction_ALLOW_ErrorCount,le.street_post_direction_LENGTH_ErrorCount,le.street_post_direction_WORDS_ErrorCount
          ,le.unit_type_ALLOW_ErrorCount,le.unit_type_LENGTH_ErrorCount,le.unit_type_WORDS_ErrorCount
          ,le.unit_number_LEFTTRIM_ErrorCount,le.unit_number_ALLOW_ErrorCount,le.unit_number_LENGTH_ErrorCount,le.unit_number_WORDS_ErrorCount
          ,le.cty_LEFTTRIM_ErrorCount,le.cty_ALLOW_ErrorCount,le.cty_LENGTH_ErrorCount,le.cty_WORDS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.zip_code_LEFTTRIM_ErrorCount,le.zip_code_ALLOW_ErrorCount,le.zip_code_LENGTH_ErrorCount,le.zip_code_WORDS_ErrorCount
          ,le.zp4_ALLOW_ErrorCount,le.zp4_LENGTH_ErrorCount,le.zp4_WORDS_ErrorCount
          ,le.address_standardization_indicator_LEFTTRIM_ErrorCount,le.address_standardization_indicator_ALLOW_ErrorCount,le.address_standardization_indicator_LENGTH_ErrorCount,le.address_standardization_indicator_WORDS_ErrorCount
          ,le.date_address_reported_LEFTTRIM_ErrorCount,le.date_address_reported_ALLOW_ErrorCount,le.date_address_reported_LENGTH_ErrorCount,le.date_address_reported_WORDS_ErrorCount
          ,le.party_id_LEFTTRIM_ErrorCount,le.party_id_ALLOW_ErrorCount,le.party_id_LENGTH_ErrorCount,le.party_id_WORDS_ErrorCount
          ,le.deceased_indicator_LEFTTRIM_ErrorCount,le.deceased_indicator_ALLOW_ErrorCount,le.deceased_indicator_LENGTH_ErrorCount,le.deceased_indicator_WORDS_ErrorCount
          ,le.date_of_birth_LEFTTRIM_ErrorCount,le.date_of_birth_ALLOW_ErrorCount,le.date_of_birth_LENGTH_ErrorCount,le.date_of_birth_WORDS_ErrorCount
          ,le.date_of_birth_estimated_ind_LEFTTRIM_ErrorCount,le.date_of_birth_estimated_ind_ALLOW_ErrorCount,le.date_of_birth_estimated_ind_LENGTH_ErrorCount,le.date_of_birth_estimated_ind_WORDS_ErrorCount
          ,le.phone_LEFTTRIM_ErrorCount,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount,le.phone_WORDS_ErrorCount
          ,le.filler3_LEFTTRIM_ErrorCount,le.filler3_ALLOW_ErrorCount,le.filler3_LENGTH_ErrorCount,le.filler3_WORDS_ErrorCount
          ,le.prepped_name_LEFTTRIM_ErrorCount,le.prepped_name_ALLOW_ErrorCount,le.prepped_name_LENGTH_ErrorCount,le.prepped_name_WORDS_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount,le.prepped_addr1_LENGTH_ErrorCount,le.prepped_addr1_WORDS_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount,le.prepped_addr2_LENGTH_ErrorCount,le.prepped_addr2_WORDS_ErrorCount
          ,le.prepped_rec_type_LEFTTRIM_ErrorCount,le.prepped_rec_type_ALLOW_ErrorCount,le.prepped_rec_type_LENGTH_ErrorCount,le.prepped_rec_type_WORDS_ErrorCount
          ,le.isupdating_LEFTTRIM_ErrorCount,le.isupdating_ALLOW_ErrorCount,le.isupdating_LENGTH_ErrorCount,le.isupdating_WORDS_ErrorCount
          ,le.iscurrent_LEFTTRIM_ErrorCount,le.iscurrent_ALLOW_ErrorCount,le.iscurrent_LENGTH_ErrorCount,le.iscurrent_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTH_ErrorCount,le.clean_phone_WORDS_ErrorCount
          ,le.clean_ssn_LEFTTRIM_ErrorCount,le.clean_ssn_ALLOW_ErrorCount,le.clean_ssn_LENGTH_ErrorCount,le.clean_ssn_WORDS_ErrorCount
          ,le.clean_dob_LEFTTRIM_ErrorCount,le.clean_dob_ALLOW_ErrorCount,le.clean_dob_LENGTH_ErrorCount,le.clean_dob_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.fips_county_LEFTTRIM_ErrorCount,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount,le.fips_county_WORDS_ErrorCount
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.rawaid_LEFTTRIM_ErrorCount,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount,le.rawaid_WORDS_ErrorCount
          ,le.isdelete_LEFTTRIM_ErrorCount,le.isdelete_ALLOW_ErrorCount,le.isdelete_LENGTH_ErrorCount,le.isdelete_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount,le.record_type_LENGTH_ErrorCount,le.record_type_WORDS_ErrorCount
          ,le.first_name_LEFTTRIM_ErrorCount,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount,le.first_name_WORDS_ErrorCount
          ,le.middle_name_LEFTTRIM_ErrorCount,le.middle_name_ALLOW_ErrorCount,le.middle_name_LENGTH_ErrorCount,le.middle_name_WORDS_ErrorCount
          ,le.last_name_LEFTTRIM_ErrorCount,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount,le.last_name_WORDS_ErrorCount
          ,le.name_prefix_LEFTTRIM_ErrorCount,le.name_prefix_ALLOW_ErrorCount,le.name_prefix_LENGTH_ErrorCount,le.name_prefix_WORDS_ErrorCount
          ,le.name_suffix__ALLOW_ErrorCount,le.name_suffix__LENGTH_ErrorCount,le.name_suffix__WORDS_ErrorCount
          ,le.perm_id_LEFTTRIM_ErrorCount,le.perm_id_ALLOW_ErrorCount,le.perm_id_LENGTH_ErrorCount,le.perm_id_WORDS_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.aka1_LEFTTRIM_ErrorCount,le.aka1_ALLOW_ErrorCount,le.aka1_LENGTH_ErrorCount,le.aka1_WORDS_ErrorCount
          ,le.aka2_LEFTTRIM_ErrorCount,le.aka2_ALLOW_ErrorCount,le.aka2_LENGTH_ErrorCount,le.aka2_WORDS_ErrorCount
          ,le.aka3_LEFTTRIM_ErrorCount,le.aka3_ALLOW_ErrorCount,le.aka3_LENGTH_ErrorCount,le.aka3_WORDS_ErrorCount
          ,le.new_subject_flag_LEFTTRIM_ErrorCount,le.new_subject_flag_ALLOW_ErrorCount,le.new_subject_flag_LENGTH_ErrorCount,le.new_subject_flag_WORDS_ErrorCount
          ,le.name_change_flag_LEFTTRIM_ErrorCount,le.name_change_flag_ALLOW_ErrorCount,le.name_change_flag_LENGTH_ErrorCount,le.name_change_flag_WORDS_ErrorCount
          ,le.address_change_flag_LEFTTRIM_ErrorCount,le.address_change_flag_ALLOW_ErrorCount,le.address_change_flag_LENGTH_ErrorCount,le.address_change_flag_WORDS_ErrorCount
          ,le.ssn_change_flag_LEFTTRIM_ErrorCount,le.ssn_change_flag_ALLOW_ErrorCount,le.ssn_change_flag_LENGTH_ErrorCount,le.ssn_change_flag_WORDS_ErrorCount
          ,le.file_since_date_change_flag_LEFTTRIM_ErrorCount,le.file_since_date_change_flag_ALLOW_ErrorCount,le.file_since_date_change_flag_LENGTH_ErrorCount,le.file_since_date_change_flag_WORDS_ErrorCount
          ,le.deceased_indicator_flag_LEFTTRIM_ErrorCount,le.deceased_indicator_flag_ALLOW_ErrorCount,le.deceased_indicator_flag_LENGTH_ErrorCount,le.deceased_indicator_flag_WORDS_ErrorCount
          ,le.dob_change_flag_LEFTTRIM_ErrorCount,le.dob_change_flag_ALLOW_ErrorCount,le.dob_change_flag_LENGTH_ErrorCount,le.dob_change_flag_WORDS_ErrorCount
          ,le.phone_change_flag_LEFTTRIM_ErrorCount,le.phone_change_flag_ALLOW_ErrorCount,le.phone_change_flag_LENGTH_ErrorCount,le.phone_change_flag_WORDS_ErrorCount
          ,le.filler2_LEFTTRIM_ErrorCount,le.filler2_ALLOW_ErrorCount,le.filler2_LENGTH_ErrorCount,le.filler2_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTH_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.mfdu_indicator_LEFTTRIM_ErrorCount,le.mfdu_indicator_ALLOW_ErrorCount,le.mfdu_indicator_LENGTH_ErrorCount,le.mfdu_indicator_WORDS_ErrorCount
          ,le.file_since_date_LEFTTRIM_ErrorCount,le.file_since_date_ALLOW_ErrorCount,le.file_since_date_LENGTH_ErrorCount,le.file_since_date_WORDS_ErrorCount
          ,le.house_number_ALLOW_ErrorCount,le.house_number_LENGTH_ErrorCount,le.house_number_WORDS_ErrorCount
          ,le.street_direction_LEFTTRIM_ErrorCount,le.street_direction_ALLOW_ErrorCount,le.street_direction_LENGTH_ErrorCount,le.street_direction_WORDS_ErrorCount
          ,le.street_name_LEFTTRIM_ErrorCount,le.street_name_ALLOW_ErrorCount,le.street_name_LENGTH_ErrorCount,le.street_name_WORDS_ErrorCount
          ,le.street_type_LEFTTRIM_ErrorCount,le.street_type_ALLOW_ErrorCount,le.street_type_LENGTH_ErrorCount,le.street_type_WORDS_ErrorCount
          ,le.street_post_direction_LEFTTRIM_ErrorCount,le.street_post_direction_ALLOW_ErrorCount,le.street_post_direction_LENGTH_ErrorCount,le.street_post_direction_WORDS_ErrorCount
          ,le.unit_type_ALLOW_ErrorCount,le.unit_type_LENGTH_ErrorCount,le.unit_type_WORDS_ErrorCount
          ,le.unit_number_LEFTTRIM_ErrorCount,le.unit_number_ALLOW_ErrorCount,le.unit_number_LENGTH_ErrorCount,le.unit_number_WORDS_ErrorCount
          ,le.cty_LEFTTRIM_ErrorCount,le.cty_ALLOW_ErrorCount,le.cty_LENGTH_ErrorCount,le.cty_WORDS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount,le.state_WORDS_ErrorCount
          ,le.zip_code_LEFTTRIM_ErrorCount,le.zip_code_ALLOW_ErrorCount,le.zip_code_LENGTH_ErrorCount,le.zip_code_WORDS_ErrorCount
          ,le.zp4_ALLOW_ErrorCount,le.zp4_LENGTH_ErrorCount,le.zp4_WORDS_ErrorCount
          ,le.address_standardization_indicator_LEFTTRIM_ErrorCount,le.address_standardization_indicator_ALLOW_ErrorCount,le.address_standardization_indicator_LENGTH_ErrorCount,le.address_standardization_indicator_WORDS_ErrorCount
          ,le.date_address_reported_LEFTTRIM_ErrorCount,le.date_address_reported_ALLOW_ErrorCount,le.date_address_reported_LENGTH_ErrorCount,le.date_address_reported_WORDS_ErrorCount
          ,le.party_id_LEFTTRIM_ErrorCount,le.party_id_ALLOW_ErrorCount,le.party_id_LENGTH_ErrorCount,le.party_id_WORDS_ErrorCount
          ,le.deceased_indicator_LEFTTRIM_ErrorCount,le.deceased_indicator_ALLOW_ErrorCount,le.deceased_indicator_LENGTH_ErrorCount,le.deceased_indicator_WORDS_ErrorCount
          ,le.date_of_birth_LEFTTRIM_ErrorCount,le.date_of_birth_ALLOW_ErrorCount,le.date_of_birth_LENGTH_ErrorCount,le.date_of_birth_WORDS_ErrorCount
          ,le.date_of_birth_estimated_ind_LEFTTRIM_ErrorCount,le.date_of_birth_estimated_ind_ALLOW_ErrorCount,le.date_of_birth_estimated_ind_LENGTH_ErrorCount,le.date_of_birth_estimated_ind_WORDS_ErrorCount
          ,le.phone_LEFTTRIM_ErrorCount,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount,le.phone_WORDS_ErrorCount
          ,le.filler3_LEFTTRIM_ErrorCount,le.filler3_ALLOW_ErrorCount,le.filler3_LENGTH_ErrorCount,le.filler3_WORDS_ErrorCount
          ,le.prepped_name_LEFTTRIM_ErrorCount,le.prepped_name_ALLOW_ErrorCount,le.prepped_name_LENGTH_ErrorCount,le.prepped_name_WORDS_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount,le.prepped_addr1_LENGTH_ErrorCount,le.prepped_addr1_WORDS_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount,le.prepped_addr2_LENGTH_ErrorCount,le.prepped_addr2_WORDS_ErrorCount
          ,le.prepped_rec_type_LEFTTRIM_ErrorCount,le.prepped_rec_type_ALLOW_ErrorCount,le.prepped_rec_type_LENGTH_ErrorCount,le.prepped_rec_type_WORDS_ErrorCount
          ,le.isupdating_LEFTTRIM_ErrorCount,le.isupdating_ALLOW_ErrorCount,le.isupdating_LENGTH_ErrorCount,le.isupdating_WORDS_ErrorCount
          ,le.iscurrent_LEFTTRIM_ErrorCount,le.iscurrent_ALLOW_ErrorCount,le.iscurrent_LENGTH_ErrorCount,le.iscurrent_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount,le.did_score_LENGTH_ErrorCount,le.did_score_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount,le.clean_phone_LENGTH_ErrorCount,le.clean_phone_WORDS_ErrorCount
          ,le.clean_ssn_LEFTTRIM_ErrorCount,le.clean_ssn_ALLOW_ErrorCount,le.clean_ssn_LENGTH_ErrorCount,le.clean_ssn_WORDS_ErrorCount
          ,le.clean_dob_LEFTTRIM_ErrorCount,le.clean_dob_ALLOW_ErrorCount,le.clean_dob_LENGTH_ErrorCount,le.clean_dob_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTH_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTH_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTH_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTH_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.fips_county_LEFTTRIM_ErrorCount,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTH_ErrorCount,le.fips_county_WORDS_ErrorCount
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.rawaid_LEFTTRIM_ErrorCount,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount,le.rawaid_WORDS_ErrorCount
          ,le.isdelete_LEFTTRIM_ErrorCount,le.isdelete_ALLOW_ErrorCount,le.isdelete_LENGTH_ErrorCount,le.isdelete_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,364,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
