IMPORT ut,SALT32;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 seq_rec_id_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_field_Invalid;
    UNSIGNED1 current_rec_flag_Invalid;
    UNSIGNED1 current_experian_pin_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 encrypted_experian_pin_Invalid;
    UNSIGNED1 social_security_number_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 telephone_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 additional_name_count_Invalid;
    UNSIGNED1 previous_address_count_Invalid;
    UNSIGNED1 nametype_Invalid;
    UNSIGNED1 orig_consumer_create_date_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 addressseq_Invalid;
    UNSIGNED1 orig_address_create_date_Invalid;
    UNSIGNED1 orig_address_update_date_Invalid;
    UNSIGNED1 orig_prim_range_Invalid;
    UNSIGNED1 orig_predir_Invalid;
    UNSIGNED1 orig_prim_name_Invalid;
    UNSIGNED1 orig_addr_suffix_Invalid;
    UNSIGNED1 orig_postdir_Invalid;
    UNSIGNED1 orig_unit_desig_Invalid;
    UNSIGNED1 orig_sec_range_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zipcode_Invalid;
    UNSIGNED1 orig_zipcode4_Invalid;
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
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 delete_flag_Invalid;
    UNSIGNED1 delete_file_date_Invalid;
    UNSIGNED1 suppression_code_Invalid;
    UNSIGNED1 deceased_ind_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.seq_rec_id_Invalid := Fields.InValid_seq_rec_id((SALT32.StrType)le.seq_rec_id);
      clean_seq_rec_id := (TYPEOF(le.seq_rec_id))Fields.Make_seq_rec_id((SALT32.StrType)le.seq_rec_id);
      clean_seq_rec_id_Invalid := Fields.InValid_seq_rec_id((SALT32.StrType)clean_seq_rec_id);
      SELF.seq_rec_id := IF(withOnfail, clean_seq_rec_id, le.seq_rec_id); // ONFAIL(CLEAN)
    SELF.did_Invalid := Fields.InValid_did((SALT32.StrType)le.did);
      clean_did := (TYPEOF(le.did))Fields.Make_did((SALT32.StrType)le.did);
      clean_did_Invalid := Fields.InValid_did((SALT32.StrType)clean_did);
      SELF.did := IF(withOnfail, clean_did, le.did); // ONFAIL(CLEAN)
    SELF.did_score_field_Invalid := Fields.InValid_did_score_field((SALT32.StrType)le.did_score_field);
      clean_did_score_field := (TYPEOF(le.did_score_field))Fields.Make_did_score_field((SALT32.StrType)le.did_score_field);
      clean_did_score_field_Invalid := Fields.InValid_did_score_field((SALT32.StrType)clean_did_score_field);
      SELF.did_score_field := IF(withOnfail, clean_did_score_field, le.did_score_field); // ONFAIL(CLEAN)
    SELF.current_rec_flag_Invalid := Fields.InValid_current_rec_flag((SALT32.StrType)le.current_rec_flag);
      clean_current_rec_flag := (TYPEOF(le.current_rec_flag))Fields.Make_current_rec_flag((SALT32.StrType)le.current_rec_flag);
      clean_current_rec_flag_Invalid := Fields.InValid_current_rec_flag((SALT32.StrType)clean_current_rec_flag);
      SELF.current_rec_flag := IF(withOnfail, clean_current_rec_flag, le.current_rec_flag); // ONFAIL(CLEAN)
    SELF.current_experian_pin_Invalid := Fields.InValid_current_experian_pin((SALT32.StrType)le.current_experian_pin);
      clean_current_experian_pin := (TYPEOF(le.current_experian_pin))Fields.Make_current_experian_pin((SALT32.StrType)le.current_experian_pin);
      clean_current_experian_pin_Invalid := Fields.InValid_current_experian_pin((SALT32.StrType)clean_current_experian_pin);
      SELF.current_experian_pin := IF(withOnfail, clean_current_experian_pin, le.current_experian_pin); // ONFAIL(CLEAN)
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT32.StrType)le.date_first_seen);
      clean_date_first_seen := (TYPEOF(le.date_first_seen))Fields.Make_date_first_seen((SALT32.StrType)le.date_first_seen);
      clean_date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT32.StrType)clean_date_first_seen);
      SELF.date_first_seen := IF(withOnfail, clean_date_first_seen, le.date_first_seen); // ONFAIL(CLEAN)
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT32.StrType)le.date_last_seen);
      clean_date_last_seen := (TYPEOF(le.date_last_seen))Fields.Make_date_last_seen((SALT32.StrType)le.date_last_seen);
      clean_date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT32.StrType)clean_date_last_seen);
      SELF.date_last_seen := IF(withOnfail, clean_date_last_seen, le.date_last_seen); // ONFAIL(CLEAN)
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT32.StrType)le.date_vendor_first_reported);
      clean_date_vendor_first_reported := (TYPEOF(le.date_vendor_first_reported))Fields.Make_date_vendor_first_reported((SALT32.StrType)le.date_vendor_first_reported);
      clean_date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT32.StrType)clean_date_vendor_first_reported);
      SELF.date_vendor_first_reported := IF(withOnfail, clean_date_vendor_first_reported, le.date_vendor_first_reported); // ONFAIL(CLEAN)
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT32.StrType)le.date_vendor_last_reported);
      clean_date_vendor_last_reported := (TYPEOF(le.date_vendor_last_reported))Fields.Make_date_vendor_last_reported((SALT32.StrType)le.date_vendor_last_reported);
      clean_date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT32.StrType)clean_date_vendor_last_reported);
      SELF.date_vendor_last_reported := IF(withOnfail, clean_date_vendor_last_reported, le.date_vendor_last_reported); // ONFAIL(CLEAN)
    SELF.encrypted_experian_pin_Invalid := Fields.InValid_encrypted_experian_pin((SALT32.StrType)le.encrypted_experian_pin);
      clean_encrypted_experian_pin := (TYPEOF(le.encrypted_experian_pin))Fields.Make_encrypted_experian_pin((SALT32.StrType)le.encrypted_experian_pin);
      clean_encrypted_experian_pin_Invalid := Fields.InValid_encrypted_experian_pin((SALT32.StrType)clean_encrypted_experian_pin);
      SELF.encrypted_experian_pin := IF(withOnfail, clean_encrypted_experian_pin, le.encrypted_experian_pin); // ONFAIL(CLEAN)
    SELF.social_security_number_Invalid := Fields.InValid_social_security_number((SALT32.StrType)le.social_security_number);
      clean_social_security_number := (TYPEOF(le.social_security_number))Fields.Make_social_security_number((SALT32.StrType)le.social_security_number);
      clean_social_security_number_Invalid := Fields.InValid_social_security_number((SALT32.StrType)clean_social_security_number);
      SELF.social_security_number := IF(withOnfail, clean_social_security_number, le.social_security_number); // ONFAIL(CLEAN)
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT32.StrType)le.date_of_birth);
      clean_date_of_birth := (TYPEOF(le.date_of_birth))Fields.Make_date_of_birth((SALT32.StrType)le.date_of_birth);
      clean_date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT32.StrType)clean_date_of_birth);
      SELF.date_of_birth := IF(withOnfail, clean_date_of_birth, le.date_of_birth); // ONFAIL(CLEAN)
    SELF.telephone_Invalid := Fields.InValid_telephone((SALT32.StrType)le.telephone);
      clean_telephone := (TYPEOF(le.telephone))Fields.Make_telephone((SALT32.StrType)le.telephone);
      clean_telephone_Invalid := Fields.InValid_telephone((SALT32.StrType)clean_telephone);
      SELF.telephone := IF(withOnfail, clean_telephone, le.telephone); // ONFAIL(CLEAN)
    SELF.gender_Invalid := Fields.InValid_gender((SALT32.StrType)le.gender);
      clean_gender := (TYPEOF(le.gender))Fields.Make_gender((SALT32.StrType)le.gender);
      clean_gender_Invalid := Fields.InValid_gender((SALT32.StrType)clean_gender);
      SELF.gender := IF(withOnfail, clean_gender, le.gender); // ONFAIL(CLEAN)
    SELF.additional_name_count_Invalid := Fields.InValid_additional_name_count((SALT32.StrType)le.additional_name_count);
      clean_additional_name_count := (TYPEOF(le.additional_name_count))Fields.Make_additional_name_count((SALT32.StrType)le.additional_name_count);
      clean_additional_name_count_Invalid := Fields.InValid_additional_name_count((SALT32.StrType)clean_additional_name_count);
      SELF.additional_name_count := IF(withOnfail, clean_additional_name_count, le.additional_name_count); // ONFAIL(CLEAN)
    SELF.previous_address_count_Invalid := Fields.InValid_previous_address_count((SALT32.StrType)le.previous_address_count);
      clean_previous_address_count := (TYPEOF(le.previous_address_count))Fields.Make_previous_address_count((SALT32.StrType)le.previous_address_count);
      clean_previous_address_count_Invalid := Fields.InValid_previous_address_count((SALT32.StrType)clean_previous_address_count);
      SELF.previous_address_count := IF(withOnfail, clean_previous_address_count, le.previous_address_count); // ONFAIL(CLEAN)
    SELF.nametype_Invalid := Fields.InValid_nametype((SALT32.StrType)le.nametype);
      clean_nametype := (TYPEOF(le.nametype))Fields.Make_nametype((SALT32.StrType)le.nametype);
      clean_nametype_Invalid := Fields.InValid_nametype((SALT32.StrType)clean_nametype);
      SELF.nametype := IF(withOnfail, clean_nametype, le.nametype); // ONFAIL(CLEAN)
    SELF.orig_consumer_create_date_Invalid := Fields.InValid_orig_consumer_create_date((SALT32.StrType)le.orig_consumer_create_date);
      clean_orig_consumer_create_date := (TYPEOF(le.orig_consumer_create_date))Fields.Make_orig_consumer_create_date((SALT32.StrType)le.orig_consumer_create_date);
      clean_orig_consumer_create_date_Invalid := Fields.InValid_orig_consumer_create_date((SALT32.StrType)clean_orig_consumer_create_date);
      SELF.orig_consumer_create_date := IF(withOnfail, clean_orig_consumer_create_date, le.orig_consumer_create_date); // ONFAIL(CLEAN)
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT32.StrType)le.orig_fname);
      clean_orig_fname := (TYPEOF(le.orig_fname))Fields.Make_orig_fname((SALT32.StrType)le.orig_fname);
      clean_orig_fname_Invalid := Fields.InValid_orig_fname((SALT32.StrType)clean_orig_fname);
      SELF.orig_fname := IF(withOnfail, clean_orig_fname, le.orig_fname); // ONFAIL(CLEAN)
    SELF.orig_mname_Invalid := Fields.InValid_orig_mname((SALT32.StrType)le.orig_mname);
      clean_orig_mname := (TYPEOF(le.orig_mname))Fields.Make_orig_mname((SALT32.StrType)le.orig_mname);
      clean_orig_mname_Invalid := Fields.InValid_orig_mname((SALT32.StrType)clean_orig_mname);
      SELF.orig_mname := IF(withOnfail, clean_orig_mname, le.orig_mname); // ONFAIL(CLEAN)
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT32.StrType)le.orig_lname);
      clean_orig_lname := (TYPEOF(le.orig_lname))Fields.Make_orig_lname((SALT32.StrType)le.orig_lname);
      clean_orig_lname_Invalid := Fields.InValid_orig_lname((SALT32.StrType)clean_orig_lname);
      SELF.orig_lname := IF(withOnfail, clean_orig_lname, le.orig_lname); // ONFAIL(CLEAN)
    SELF.orig_suffix_Invalid := Fields.InValid_orig_suffix((SALT32.StrType)le.orig_suffix);
      clean_orig_suffix := (TYPEOF(le.orig_suffix))Fields.Make_orig_suffix((SALT32.StrType)le.orig_suffix);
      clean_orig_suffix_Invalid := Fields.InValid_orig_suffix((SALT32.StrType)clean_orig_suffix);
      SELF.orig_suffix := IF(withOnfail, clean_orig_suffix, le.orig_suffix); // ONFAIL(CLEAN)
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
    SELF.addressseq_Invalid := Fields.InValid_addressseq((SALT32.StrType)le.addressseq);
      clean_addressseq := (TYPEOF(le.addressseq))Fields.Make_addressseq((SALT32.StrType)le.addressseq);
      clean_addressseq_Invalid := Fields.InValid_addressseq((SALT32.StrType)clean_addressseq);
      SELF.addressseq := IF(withOnfail, clean_addressseq, le.addressseq); // ONFAIL(CLEAN)
    SELF.orig_address_create_date_Invalid := Fields.InValid_orig_address_create_date((SALT32.StrType)le.orig_address_create_date);
      clean_orig_address_create_date := (TYPEOF(le.orig_address_create_date))Fields.Make_orig_address_create_date((SALT32.StrType)le.orig_address_create_date);
      clean_orig_address_create_date_Invalid := Fields.InValid_orig_address_create_date((SALT32.StrType)clean_orig_address_create_date);
      SELF.orig_address_create_date := IF(withOnfail, clean_orig_address_create_date, le.orig_address_create_date); // ONFAIL(CLEAN)
    SELF.orig_address_update_date_Invalid := Fields.InValid_orig_address_update_date((SALT32.StrType)le.orig_address_update_date);
      clean_orig_address_update_date := (TYPEOF(le.orig_address_update_date))Fields.Make_orig_address_update_date((SALT32.StrType)le.orig_address_update_date);
      clean_orig_address_update_date_Invalid := Fields.InValid_orig_address_update_date((SALT32.StrType)clean_orig_address_update_date);
      SELF.orig_address_update_date := IF(withOnfail, clean_orig_address_update_date, le.orig_address_update_date); // ONFAIL(CLEAN)
    SELF.orig_prim_range_Invalid := Fields.InValid_orig_prim_range((SALT32.StrType)le.orig_prim_range);
      clean_orig_prim_range := (TYPEOF(le.orig_prim_range))Fields.Make_orig_prim_range((SALT32.StrType)le.orig_prim_range);
      clean_orig_prim_range_Invalid := Fields.InValid_orig_prim_range((SALT32.StrType)clean_orig_prim_range);
      SELF.orig_prim_range := IF(withOnfail, clean_orig_prim_range, le.orig_prim_range); // ONFAIL(CLEAN)
    SELF.orig_predir_Invalid := Fields.InValid_orig_predir((SALT32.StrType)le.orig_predir);
      clean_orig_predir := (TYPEOF(le.orig_predir))Fields.Make_orig_predir((SALT32.StrType)le.orig_predir);
      clean_orig_predir_Invalid := Fields.InValid_orig_predir((SALT32.StrType)clean_orig_predir);
      SELF.orig_predir := IF(withOnfail, clean_orig_predir, le.orig_predir); // ONFAIL(CLEAN)
    SELF.orig_prim_name_Invalid := Fields.InValid_orig_prim_name((SALT32.StrType)le.orig_prim_name);
      clean_orig_prim_name := (TYPEOF(le.orig_prim_name))Fields.Make_orig_prim_name((SALT32.StrType)le.orig_prim_name);
      clean_orig_prim_name_Invalid := Fields.InValid_orig_prim_name((SALT32.StrType)clean_orig_prim_name);
      SELF.orig_prim_name := IF(withOnfail, clean_orig_prim_name, le.orig_prim_name); // ONFAIL(CLEAN)
    SELF.orig_addr_suffix_Invalid := Fields.InValid_orig_addr_suffix((SALT32.StrType)le.orig_addr_suffix);
      clean_orig_addr_suffix := (TYPEOF(le.orig_addr_suffix))Fields.Make_orig_addr_suffix((SALT32.StrType)le.orig_addr_suffix);
      clean_orig_addr_suffix_Invalid := Fields.InValid_orig_addr_suffix((SALT32.StrType)clean_orig_addr_suffix);
      SELF.orig_addr_suffix := IF(withOnfail, clean_orig_addr_suffix, le.orig_addr_suffix); // ONFAIL(CLEAN)
    SELF.orig_postdir_Invalid := Fields.InValid_orig_postdir((SALT32.StrType)le.orig_postdir);
      clean_orig_postdir := (TYPEOF(le.orig_postdir))Fields.Make_orig_postdir((SALT32.StrType)le.orig_postdir);
      clean_orig_postdir_Invalid := Fields.InValid_orig_postdir((SALT32.StrType)clean_orig_postdir);
      SELF.orig_postdir := IF(withOnfail, clean_orig_postdir, le.orig_postdir); // ONFAIL(CLEAN)
    SELF.orig_unit_desig_Invalid := Fields.InValid_orig_unit_desig((SALT32.StrType)le.orig_unit_desig);
      clean_orig_unit_desig := (TYPEOF(le.orig_unit_desig))Fields.Make_orig_unit_desig((SALT32.StrType)le.orig_unit_desig);
      clean_orig_unit_desig_Invalid := Fields.InValid_orig_unit_desig((SALT32.StrType)clean_orig_unit_desig);
      SELF.orig_unit_desig := IF(withOnfail, clean_orig_unit_desig, le.orig_unit_desig); // ONFAIL(CLEAN)
    SELF.orig_sec_range_Invalid := Fields.InValid_orig_sec_range((SALT32.StrType)le.orig_sec_range);
      clean_orig_sec_range := (TYPEOF(le.orig_sec_range))Fields.Make_orig_sec_range((SALT32.StrType)le.orig_sec_range);
      clean_orig_sec_range_Invalid := Fields.InValid_orig_sec_range((SALT32.StrType)clean_orig_sec_range);
      SELF.orig_sec_range := IF(withOnfail, clean_orig_sec_range, le.orig_sec_range); // ONFAIL(CLEAN)
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT32.StrType)le.orig_city);
      clean_orig_city := (TYPEOF(le.orig_city))Fields.Make_orig_city((SALT32.StrType)le.orig_city);
      clean_orig_city_Invalid := Fields.InValid_orig_city((SALT32.StrType)clean_orig_city);
      SELF.orig_city := IF(withOnfail, clean_orig_city, le.orig_city); // ONFAIL(CLEAN)
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT32.StrType)le.orig_state);
      clean_orig_state := (TYPEOF(le.orig_state))Fields.Make_orig_state((SALT32.StrType)le.orig_state);
      clean_orig_state_Invalid := Fields.InValid_orig_state((SALT32.StrType)clean_orig_state);
      SELF.orig_state := IF(withOnfail, clean_orig_state, le.orig_state); // ONFAIL(CLEAN)
    SELF.orig_zipcode_Invalid := Fields.InValid_orig_zipcode((SALT32.StrType)le.orig_zipcode);
      clean_orig_zipcode := (TYPEOF(le.orig_zipcode))Fields.Make_orig_zipcode((SALT32.StrType)le.orig_zipcode);
      clean_orig_zipcode_Invalid := Fields.InValid_orig_zipcode((SALT32.StrType)clean_orig_zipcode);
      SELF.orig_zipcode := IF(withOnfail, clean_orig_zipcode, le.orig_zipcode); // ONFAIL(CLEAN)
    SELF.orig_zipcode4_Invalid := Fields.InValid_orig_zipcode4((SALT32.StrType)le.orig_zipcode4);
      clean_orig_zipcode4 := (TYPEOF(le.orig_zipcode4))Fields.Make_orig_zipcode4((SALT32.StrType)le.orig_zipcode4);
      clean_orig_zipcode4_Invalid := Fields.InValid_orig_zipcode4((SALT32.StrType)clean_orig_zipcode4);
      SELF.orig_zipcode4 := IF(withOnfail, clean_orig_zipcode4, le.orig_zipcode4); // ONFAIL(CLEAN)
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
    SELF.delete_flag_Invalid := Fields.InValid_delete_flag((SALT32.StrType)le.delete_flag);
      clean_delete_flag := (TYPEOF(le.delete_flag))Fields.Make_delete_flag((SALT32.StrType)le.delete_flag);
      clean_delete_flag_Invalid := Fields.InValid_delete_flag((SALT32.StrType)clean_delete_flag);
      SELF.delete_flag := IF(withOnfail, clean_delete_flag, le.delete_flag); // ONFAIL(CLEAN)
    SELF.delete_file_date_Invalid := Fields.InValid_delete_file_date((SALT32.StrType)le.delete_file_date);
      clean_delete_file_date := (TYPEOF(le.delete_file_date))Fields.Make_delete_file_date((SALT32.StrType)le.delete_file_date);
      clean_delete_file_date_Invalid := Fields.InValid_delete_file_date((SALT32.StrType)clean_delete_file_date);
      SELF.delete_file_date := IF(withOnfail, clean_delete_file_date, le.delete_file_date); // ONFAIL(CLEAN)
    SELF.suppression_code_Invalid := Fields.InValid_suppression_code((SALT32.StrType)le.suppression_code);
      clean_suppression_code := (TYPEOF(le.suppression_code))Fields.Make_suppression_code((SALT32.StrType)le.suppression_code);
      clean_suppression_code_Invalid := Fields.InValid_suppression_code((SALT32.StrType)clean_suppression_code);
      SELF.suppression_code := IF(withOnfail, clean_suppression_code, le.suppression_code); // ONFAIL(CLEAN)
    SELF.deceased_ind_Invalid := Fields.InValid_deceased_ind((SALT32.StrType)le.deceased_ind);
      clean_deceased_ind := (TYPEOF(le.deceased_ind))Fields.Make_deceased_ind((SALT32.StrType)le.deceased_ind);
      clean_deceased_ind_Invalid := Fields.InValid_deceased_ind((SALT32.StrType)clean_deceased_ind);
      SELF.deceased_ind := IF(withOnfail, clean_deceased_ind, le.deceased_ind); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.seq_rec_id_Invalid << 0 ) + ( le.did_Invalid << 3 ) + ( le.did_score_field_Invalid << 6 ) + ( le.current_rec_flag_Invalid << 9 ) + ( le.current_experian_pin_Invalid << 12 ) + ( le.date_first_seen_Invalid << 15 ) + ( le.date_last_seen_Invalid << 18 ) + ( le.date_vendor_first_reported_Invalid << 21 ) + ( le.date_vendor_last_reported_Invalid << 24 ) + ( le.encrypted_experian_pin_Invalid << 27 ) + ( le.social_security_number_Invalid << 30 ) + ( le.date_of_birth_Invalid << 33 ) + ( le.telephone_Invalid << 36 ) + ( le.gender_Invalid << 39 ) + ( le.additional_name_count_Invalid << 42 ) + ( le.previous_address_count_Invalid << 45 ) + ( le.nametype_Invalid << 48 ) + ( le.orig_consumer_create_date_Invalid << 51 ) + ( le.orig_fname_Invalid << 54 ) + ( le.orig_mname_Invalid << 57 ) + ( le.orig_lname_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.orig_suffix_Invalid << 0 ) + ( le.title_Invalid << 3 ) + ( le.fname_Invalid << 6 ) + ( le.mname_Invalid << 9 ) + ( le.lname_Invalid << 12 ) + ( le.name_suffix_Invalid << 15 ) + ( le.name_score_Invalid << 18 ) + ( le.addressseq_Invalid << 21 ) + ( le.orig_address_create_date_Invalid << 24 ) + ( le.orig_address_update_date_Invalid << 27 ) + ( le.orig_prim_range_Invalid << 30 ) + ( le.orig_predir_Invalid << 33 ) + ( le.orig_prim_name_Invalid << 36 ) + ( le.orig_addr_suffix_Invalid << 39 ) + ( le.orig_postdir_Invalid << 42 ) + ( le.orig_unit_desig_Invalid << 45 ) + ( le.orig_sec_range_Invalid << 48 ) + ( le.orig_city_Invalid << 51 ) + ( le.orig_state_Invalid << 54 ) + ( le.orig_zipcode_Invalid << 57 ) + ( le.orig_zipcode4_Invalid << 60 );
    SELF.ScrubsBits3 := ( le.prim_range_Invalid << 0 ) + ( le.predir_Invalid << 3 ) + ( le.prim_name_Invalid << 6 ) + ( le.addr_suffix_Invalid << 9 ) + ( le.postdir_Invalid << 12 ) + ( le.unit_desig_Invalid << 15 ) + ( le.sec_range_Invalid << 18 ) + ( le.p_city_name_Invalid << 21 ) + ( le.v_city_name_Invalid << 24 ) + ( le.st_Invalid << 27 ) + ( le.zip_Invalid << 30 ) + ( le.zip4_Invalid << 33 ) + ( le.cart_Invalid << 36 ) + ( le.cr_sort_sz_Invalid << 39 ) + ( le.lot_Invalid << 42 ) + ( le.lot_order_Invalid << 45 ) + ( le.dbpc_Invalid << 48 ) + ( le.chk_digit_Invalid << 51 ) + ( le.rec_type_Invalid << 54 ) + ( le.county_Invalid << 57 ) + ( le.geo_lat_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.geo_long_Invalid << 0 ) + ( le.msa_Invalid << 3 ) + ( le.geo_blk_Invalid << 6 ) + ( le.geo_match_Invalid << 9 ) + ( le.err_stat_Invalid << 12 ) + ( le.delete_flag_Invalid << 15 ) + ( le.delete_file_date_Invalid << 18 ) + ( le.suppression_code_Invalid << 21 ) + ( le.deceased_ind_Invalid << 24 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.seq_rec_id_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.did_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.did_score_field_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.current_rec_flag_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.current_experian_pin_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.encrypted_experian_pin_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.social_security_number_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.additional_name_count_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.previous_address_count_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.nametype_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.orig_consumer_create_date_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.orig_suffix_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.title_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.fname_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.mname_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.lname_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.name_score_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.addressseq_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.orig_address_create_date_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.orig_address_update_date_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.orig_prim_range_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.orig_predir_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.orig_prim_name_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.orig_addr_suffix_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.orig_postdir_Invalid := (le.ScrubsBits2 >> 42) & 7;
    SELF.orig_unit_desig_Invalid := (le.ScrubsBits2 >> 45) & 7;
    SELF.orig_sec_range_Invalid := (le.ScrubsBits2 >> 48) & 7;
    SELF.orig_city_Invalid := (le.ScrubsBits2 >> 51) & 7;
    SELF.orig_state_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.orig_zipcode_Invalid := (le.ScrubsBits2 >> 57) & 7;
    SELF.orig_zipcode4_Invalid := (le.ScrubsBits2 >> 60) & 7;
    SELF.prim_range_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.predir_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.prim_name_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.addr_suffix_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.postdir_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.unit_desig_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.sec_range_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.v_city_name_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.st_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.cart_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.lot_order_Invalid := (le.ScrubsBits3 >> 45) & 7;
    SELF.dbpc_Invalid := (le.ScrubsBits3 >> 48) & 7;
    SELF.chk_digit_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.rec_type_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.county_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.geo_lat_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.geo_long_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.msa_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.geo_blk_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.geo_match_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.err_stat_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.delete_flag_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.delete_file_date_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.suppression_code_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.deceased_ind_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    seq_rec_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=1);
    seq_rec_id_ALLOW_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=2);
    seq_rec_id_LENGTH_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=3);
    seq_rec_id_WORDS_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=4);
    seq_rec_id_Total_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid>0);
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=3);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=4);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_field_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=1);
    did_score_field_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=2);
    did_score_field_LENGTH_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=3);
    did_score_field_WORDS_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=4);
    did_score_field_Total_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid>0);
    current_rec_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=1);
    current_rec_flag_ALLOW_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=2);
    current_rec_flag_LENGTH_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=3);
    current_rec_flag_WORDS_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=4);
    current_rec_flag_Total_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid>0);
    current_experian_pin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=1);
    current_experian_pin_ALLOW_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=2);
    current_experian_pin_LENGTH_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=3);
    current_experian_pin_WORDS_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=4);
    current_experian_pin_Total_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid>0);
    date_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=3);
    date_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=4);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=3);
    date_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=4);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=3);
    date_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=4);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=3);
    date_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=4);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    encrypted_experian_pin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=1);
    encrypted_experian_pin_ALLOW_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=2);
    encrypted_experian_pin_LENGTH_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=3);
    encrypted_experian_pin_WORDS_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=4);
    encrypted_experian_pin_Total_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid>0);
    social_security_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=1);
    social_security_number_ALLOW_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=2);
    social_security_number_LENGTH_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=3);
    social_security_number_WORDS_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=4);
    social_security_number_Total_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid>0);
    date_of_birth_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    date_of_birth_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=2);
    date_of_birth_LENGTH_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=3);
    date_of_birth_WORDS_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=4);
    date_of_birth_Total_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid>0);
    telephone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    telephone_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_Invalid=2);
    telephone_LENGTH_ErrorCount := COUNT(GROUP,h.telephone_Invalid=3);
    telephone_WORDS_ErrorCount := COUNT(GROUP,h.telephone_Invalid=4);
    telephone_Total_ErrorCount := COUNT(GROUP,h.telephone_Invalid>0);
    gender_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_LENGTH_ErrorCount := COUNT(GROUP,h.gender_Invalid=3);
    gender_WORDS_ErrorCount := COUNT(GROUP,h.gender_Invalid=4);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    additional_name_count_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=1);
    additional_name_count_ALLOW_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=2);
    additional_name_count_LENGTH_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=3);
    additional_name_count_WORDS_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=4);
    additional_name_count_Total_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid>0);
    previous_address_count_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=1);
    previous_address_count_ALLOW_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=2);
    previous_address_count_LENGTH_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=3);
    previous_address_count_WORDS_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=4);
    previous_address_count_Total_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid>0);
    nametype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nametype_Invalid=1);
    nametype_ALLOW_ErrorCount := COUNT(GROUP,h.nametype_Invalid=2);
    nametype_LENGTH_ErrorCount := COUNT(GROUP,h.nametype_Invalid=3);
    nametype_WORDS_ErrorCount := COUNT(GROUP,h.nametype_Invalid=4);
    nametype_Total_ErrorCount := COUNT(GROUP,h.nametype_Invalid>0);
    orig_consumer_create_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=1);
    orig_consumer_create_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=2);
    orig_consumer_create_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=3);
    orig_consumer_create_date_WORDS_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=4);
    orig_consumer_create_date_Total_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid>0);
    orig_fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=3);
    orig_fname_WORDS_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=4);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=3);
    orig_mname_WORDS_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=4);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=3);
    orig_lname_WORDS_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=4);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    orig_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=2);
    orig_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=3);
    orig_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=4);
    orig_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid>0);
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
    addressseq_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=1);
    addressseq_ALLOW_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=2);
    addressseq_LENGTH_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=3);
    addressseq_WORDS_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=4);
    addressseq_Total_ErrorCount := COUNT(GROUP,h.addressseq_Invalid>0);
    orig_address_create_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=1);
    orig_address_create_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=2);
    orig_address_create_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=3);
    orig_address_create_date_WORDS_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=4);
    orig_address_create_date_Total_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid>0);
    orig_address_update_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=1);
    orig_address_update_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=2);
    orig_address_update_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=3);
    orig_address_update_date_WORDS_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=4);
    orig_address_update_date_Total_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid>0);
    orig_prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=1);
    orig_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=2);
    orig_prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=3);
    orig_prim_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=4);
    orig_prim_range_Total_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid>0);
    orig_predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=1);
    orig_predir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=2);
    orig_predir_LENGTH_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=3);
    orig_predir_WORDS_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=4);
    orig_predir_Total_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid>0);
    orig_prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=1);
    orig_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=2);
    orig_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=3);
    orig_prim_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=4);
    orig_prim_name_Total_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid>0);
    orig_addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=1);
    orig_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=2);
    orig_addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=3);
    orig_addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=4);
    orig_addr_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid>0);
    orig_postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=1);
    orig_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=2);
    orig_postdir_LENGTH_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=3);
    orig_postdir_WORDS_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=4);
    orig_postdir_Total_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid>0);
    orig_unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=1);
    orig_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=2);
    orig_unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=3);
    orig_unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=4);
    orig_unit_desig_Total_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid>0);
    orig_sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=1);
    orig_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=2);
    orig_sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=3);
    orig_sec_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=4);
    orig_sec_range_Total_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid>0);
    orig_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_LENGTH_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=3);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=4);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_LENGTH_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=3);
    orig_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=4);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=1);
    orig_zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=2);
    orig_zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=3);
    orig_zipcode_WORDS_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=4);
    orig_zipcode_Total_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid>0);
    orig_zipcode4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=1);
    orig_zipcode4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=2);
    orig_zipcode4_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=3);
    orig_zipcode4_WORDS_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=4);
    orig_zipcode4_Total_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid>0);
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
    delete_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=1);
    delete_flag_ALLOW_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=2);
    delete_flag_LENGTH_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=3);
    delete_flag_WORDS_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=4);
    delete_flag_Total_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid>0);
    delete_file_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=1);
    delete_file_date_ALLOW_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=2);
    delete_file_date_LENGTH_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=3);
    delete_file_date_WORDS_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=4);
    delete_file_date_Total_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid>0);
    suppression_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=1);
    suppression_code_ALLOW_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=2);
    suppression_code_LENGTH_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=3);
    suppression_code_WORDS_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=4);
    suppression_code_Total_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid>0);
    deceased_ind_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=1);
    deceased_ind_ALLOW_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=2);
    deceased_ind_LENGTH_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=3);
    deceased_ind_WORDS_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=4);
    deceased_ind_Total_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.seq_rec_id_Invalid,le.did_Invalid,le.did_score_field_Invalid,le.current_rec_flag_Invalid,le.current_experian_pin_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.encrypted_experian_pin_Invalid,le.social_security_number_Invalid,le.date_of_birth_Invalid,le.telephone_Invalid,le.gender_Invalid,le.additional_name_count_Invalid,le.previous_address_count_Invalid,le.nametype_Invalid,le.orig_consumer_create_date_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_suffix_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.addressseq_Invalid,le.orig_address_create_date_Invalid,le.orig_address_update_date_Invalid,le.orig_prim_range_Invalid,le.orig_predir_Invalid,le.orig_prim_name_Invalid,le.orig_addr_suffix_Invalid,le.orig_postdir_Invalid,le.orig_unit_desig_Invalid,le.orig_sec_range_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zipcode_Invalid,le.orig_zipcode4_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.delete_flag_Invalid,le.delete_file_date_Invalid,le.suppression_code_Invalid,le.deceased_ind_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_seq_rec_id(le.seq_rec_id_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score_field(le.did_score_field_Invalid),Fields.InvalidMessage_current_rec_flag(le.current_rec_flag_Invalid),Fields.InvalidMessage_current_experian_pin(le.current_experian_pin_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_encrypted_experian_pin(le.encrypted_experian_pin_Invalid),Fields.InvalidMessage_social_security_number(le.social_security_number_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_telephone(le.telephone_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_additional_name_count(le.additional_name_count_Invalid),Fields.InvalidMessage_previous_address_count(le.previous_address_count_Invalid),Fields.InvalidMessage_nametype(le.nametype_Invalid),Fields.InvalidMessage_orig_consumer_create_date(le.orig_consumer_create_date_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_addressseq(le.addressseq_Invalid),Fields.InvalidMessage_orig_address_create_date(le.orig_address_create_date_Invalid),Fields.InvalidMessage_orig_address_update_date(le.orig_address_update_date_Invalid),Fields.InvalidMessage_orig_prim_range(le.orig_prim_range_Invalid),Fields.InvalidMessage_orig_predir(le.orig_predir_Invalid),Fields.InvalidMessage_orig_prim_name(le.orig_prim_name_Invalid),Fields.InvalidMessage_orig_addr_suffix(le.orig_addr_suffix_Invalid),Fields.InvalidMessage_orig_postdir(le.orig_postdir_Invalid),Fields.InvalidMessage_orig_unit_desig(le.orig_unit_desig_Invalid),Fields.InvalidMessage_orig_sec_range(le.orig_sec_range_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zipcode(le.orig_zipcode_Invalid),Fields.InvalidMessage_orig_zipcode4(le.orig_zipcode4_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_delete_flag(le.delete_flag_Invalid),Fields.InvalidMessage_delete_file_date(le.delete_file_date_Invalid),Fields.InvalidMessage_suppression_code(le.suppression_code_Invalid),Fields.InvalidMessage_deceased_ind(le.deceased_ind_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.seq_rec_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_field_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_rec_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_experian_pin_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.encrypted_experian_pin_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.social_security_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.additional_name_count_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.previous_address_count_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.nametype_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_consumer_create_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.addressseq_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_create_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_update_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_predir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_postdir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zipcode4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
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
          ,CHOOSE(le.county_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.delete_flag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.delete_file_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.suppression_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.deceased_ind_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.seq_rec_id,(SALT32.StrType)le.did,(SALT32.StrType)le.did_score_field,(SALT32.StrType)le.current_rec_flag,(SALT32.StrType)le.current_experian_pin,(SALT32.StrType)le.date_first_seen,(SALT32.StrType)le.date_last_seen,(SALT32.StrType)le.date_vendor_first_reported,(SALT32.StrType)le.date_vendor_last_reported,(SALT32.StrType)le.encrypted_experian_pin,(SALT32.StrType)le.social_security_number,(SALT32.StrType)le.date_of_birth,(SALT32.StrType)le.telephone,(SALT32.StrType)le.gender,(SALT32.StrType)le.additional_name_count,(SALT32.StrType)le.previous_address_count,(SALT32.StrType)le.nametype,(SALT32.StrType)le.orig_consumer_create_date,(SALT32.StrType)le.orig_fname,(SALT32.StrType)le.orig_mname,(SALT32.StrType)le.orig_lname,(SALT32.StrType)le.orig_suffix,(SALT32.StrType)le.title,(SALT32.StrType)le.fname,(SALT32.StrType)le.mname,(SALT32.StrType)le.lname,(SALT32.StrType)le.name_suffix,(SALT32.StrType)le.name_score,(SALT32.StrType)le.addressseq,(SALT32.StrType)le.orig_address_create_date,(SALT32.StrType)le.orig_address_update_date,(SALT32.StrType)le.orig_prim_range,(SALT32.StrType)le.orig_predir,(SALT32.StrType)le.orig_prim_name,(SALT32.StrType)le.orig_addr_suffix,(SALT32.StrType)le.orig_postdir,(SALT32.StrType)le.orig_unit_desig,(SALT32.StrType)le.orig_sec_range,(SALT32.StrType)le.orig_city,(SALT32.StrType)le.orig_state,(SALT32.StrType)le.orig_zipcode,(SALT32.StrType)le.orig_zipcode4,(SALT32.StrType)le.prim_range,(SALT32.StrType)le.predir,(SALT32.StrType)le.prim_name,(SALT32.StrType)le.addr_suffix,(SALT32.StrType)le.postdir,(SALT32.StrType)le.unit_desig,(SALT32.StrType)le.sec_range,(SALT32.StrType)le.p_city_name,(SALT32.StrType)le.v_city_name,(SALT32.StrType)le.st,(SALT32.StrType)le.zip,(SALT32.StrType)le.zip4,(SALT32.StrType)le.cart,(SALT32.StrType)le.cr_sort_sz,(SALT32.StrType)le.lot,(SALT32.StrType)le.lot_order,(SALT32.StrType)le.dbpc,(SALT32.StrType)le.chk_digit,(SALT32.StrType)le.rec_type,(SALT32.StrType)le.county,(SALT32.StrType)le.geo_lat,(SALT32.StrType)le.geo_long,(SALT32.StrType)le.msa,(SALT32.StrType)le.geo_blk,(SALT32.StrType)le.geo_match,(SALT32.StrType)le.err_stat,(SALT32.StrType)le.delete_flag,(SALT32.StrType)le.delete_file_date,(SALT32.StrType)le.suppression_code,(SALT32.StrType)le.deceased_ind,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,72,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'seq_rec_id:seq_rec_id:LEFTTRIM','seq_rec_id:seq_rec_id:ALLOW','seq_rec_id:seq_rec_id:LENGTH','seq_rec_id:seq_rec_id:WORDS'
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTH','did:did:WORDS'
          ,'did_score_field:did_score_field:LEFTTRIM','did_score_field:did_score_field:ALLOW','did_score_field:did_score_field:LENGTH','did_score_field:did_score_field:WORDS'
          ,'current_rec_flag:current_rec_flag:LEFTTRIM','current_rec_flag:current_rec_flag:ALLOW','current_rec_flag:current_rec_flag:LENGTH','current_rec_flag:current_rec_flag:WORDS'
          ,'current_experian_pin:current_experian_pin:LEFTTRIM','current_experian_pin:current_experian_pin:ALLOW','current_experian_pin:current_experian_pin:LENGTH','current_experian_pin:current_experian_pin:WORDS'
          ,'date_first_seen:date_first_seen:LEFTTRIM','date_first_seen:date_first_seen:ALLOW','date_first_seen:date_first_seen:LENGTH','date_first_seen:date_first_seen:WORDS'
          ,'date_last_seen:date_last_seen:LEFTTRIM','date_last_seen:date_last_seen:ALLOW','date_last_seen:date_last_seen:LENGTH','date_last_seen:date_last_seen:WORDS'
          ,'date_vendor_first_reported:date_vendor_first_reported:LEFTTRIM','date_vendor_first_reported:date_vendor_first_reported:ALLOW','date_vendor_first_reported:date_vendor_first_reported:LENGTH','date_vendor_first_reported:date_vendor_first_reported:WORDS'
          ,'date_vendor_last_reported:date_vendor_last_reported:LEFTTRIM','date_vendor_last_reported:date_vendor_last_reported:ALLOW','date_vendor_last_reported:date_vendor_last_reported:LENGTH','date_vendor_last_reported:date_vendor_last_reported:WORDS'
          ,'encrypted_experian_pin:encrypted_experian_pin:LEFTTRIM','encrypted_experian_pin:encrypted_experian_pin:ALLOW','encrypted_experian_pin:encrypted_experian_pin:LENGTH','encrypted_experian_pin:encrypted_experian_pin:WORDS'
          ,'social_security_number:social_security_number:LEFTTRIM','social_security_number:social_security_number:ALLOW','social_security_number:social_security_number:LENGTH','social_security_number:social_security_number:WORDS'
          ,'date_of_birth:date_of_birth:LEFTTRIM','date_of_birth:date_of_birth:ALLOW','date_of_birth:date_of_birth:LENGTH','date_of_birth:date_of_birth:WORDS'
          ,'telephone:telephone:LEFTTRIM','telephone:telephone:ALLOW','telephone:telephone:LENGTH','telephone:telephone:WORDS'
          ,'gender:gender:LEFTTRIM','gender:gender:ALLOW','gender:gender:LENGTH','gender:gender:WORDS'
          ,'additional_name_count:additional_name_count:LEFTTRIM','additional_name_count:additional_name_count:ALLOW','additional_name_count:additional_name_count:LENGTH','additional_name_count:additional_name_count:WORDS'
          ,'previous_address_count:previous_address_count:LEFTTRIM','previous_address_count:previous_address_count:ALLOW','previous_address_count:previous_address_count:LENGTH','previous_address_count:previous_address_count:WORDS'
          ,'nametype:nametype:LEFTTRIM','nametype:nametype:ALLOW','nametype:nametype:LENGTH','nametype:nametype:WORDS'
          ,'orig_consumer_create_date:orig_consumer_create_date:LEFTTRIM','orig_consumer_create_date:orig_consumer_create_date:ALLOW','orig_consumer_create_date:orig_consumer_create_date:LENGTH','orig_consumer_create_date:orig_consumer_create_date:WORDS'
          ,'orig_fname:orig_fname:LEFTTRIM','orig_fname:orig_fname:ALLOW','orig_fname:orig_fname:LENGTH','orig_fname:orig_fname:WORDS'
          ,'orig_mname:orig_mname:LEFTTRIM','orig_mname:orig_mname:ALLOW','orig_mname:orig_mname:LENGTH','orig_mname:orig_mname:WORDS'
          ,'orig_lname:orig_lname:LEFTTRIM','orig_lname:orig_lname:ALLOW','orig_lname:orig_lname:LENGTH','orig_lname:orig_lname:WORDS'
          ,'orig_suffix:orig_suffix:LEFTTRIM','orig_suffix:orig_suffix:ALLOW','orig_suffix:orig_suffix:LENGTH','orig_suffix:orig_suffix:WORDS'
          ,'title:title:LEFTTRIM','title:title:ALLOW','title:title:LENGTH','title:title:WORDS'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW','fname:fname:LENGTH','fname:fname:WORDS'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW','mname:mname:LENGTH','mname:mname:WORDS'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW','lname:lname:LENGTH','lname:lname:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTH','name_suffix:name_suffix:WORDS'
          ,'name_score:name_score:LEFTTRIM','name_score:name_score:ALLOW','name_score:name_score:LENGTH','name_score:name_score:WORDS'
          ,'addressseq:addressseq:LEFTTRIM','addressseq:addressseq:ALLOW','addressseq:addressseq:LENGTH','addressseq:addressseq:WORDS'
          ,'orig_address_create_date:orig_address_create_date:LEFTTRIM','orig_address_create_date:orig_address_create_date:ALLOW','orig_address_create_date:orig_address_create_date:LENGTH','orig_address_create_date:orig_address_create_date:WORDS'
          ,'orig_address_update_date:orig_address_update_date:LEFTTRIM','orig_address_update_date:orig_address_update_date:ALLOW','orig_address_update_date:orig_address_update_date:LENGTH','orig_address_update_date:orig_address_update_date:WORDS'
          ,'orig_prim_range:orig_prim_range:LEFTTRIM','orig_prim_range:orig_prim_range:ALLOW','orig_prim_range:orig_prim_range:LENGTH','orig_prim_range:orig_prim_range:WORDS'
          ,'orig_predir:orig_predir:LEFTTRIM','orig_predir:orig_predir:ALLOW','orig_predir:orig_predir:LENGTH','orig_predir:orig_predir:WORDS'
          ,'orig_prim_name:orig_prim_name:LEFTTRIM','orig_prim_name:orig_prim_name:ALLOW','orig_prim_name:orig_prim_name:LENGTH','orig_prim_name:orig_prim_name:WORDS'
          ,'orig_addr_suffix:orig_addr_suffix:LEFTTRIM','orig_addr_suffix:orig_addr_suffix:ALLOW','orig_addr_suffix:orig_addr_suffix:LENGTH','orig_addr_suffix:orig_addr_suffix:WORDS'
          ,'orig_postdir:orig_postdir:LEFTTRIM','orig_postdir:orig_postdir:ALLOW','orig_postdir:orig_postdir:LENGTH','orig_postdir:orig_postdir:WORDS'
          ,'orig_unit_desig:orig_unit_desig:LEFTTRIM','orig_unit_desig:orig_unit_desig:ALLOW','orig_unit_desig:orig_unit_desig:LENGTH','orig_unit_desig:orig_unit_desig:WORDS'
          ,'orig_sec_range:orig_sec_range:LEFTTRIM','orig_sec_range:orig_sec_range:ALLOW','orig_sec_range:orig_sec_range:LENGTH','orig_sec_range:orig_sec_range:WORDS'
          ,'orig_city:orig_city:LEFTTRIM','orig_city:orig_city:ALLOW','orig_city:orig_city:LENGTH','orig_city:orig_city:WORDS'
          ,'orig_state:orig_state:LEFTTRIM','orig_state:orig_state:ALLOW','orig_state:orig_state:LENGTH','orig_state:orig_state:WORDS'
          ,'orig_zipcode:orig_zipcode:LEFTTRIM','orig_zipcode:orig_zipcode:ALLOW','orig_zipcode:orig_zipcode:LENGTH','orig_zipcode:orig_zipcode:WORDS'
          ,'orig_zipcode4:orig_zipcode4:LEFTTRIM','orig_zipcode4:orig_zipcode4:ALLOW','orig_zipcode4:orig_zipcode4:LENGTH','orig_zipcode4:orig_zipcode4:WORDS'
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
          ,'county:county:LEFTTRIM','county:county:ALLOW','county:county:LENGTH','county:county:WORDS'
          ,'geo_lat:geo_lat:LEFTTRIM','geo_lat:geo_lat:ALLOW','geo_lat:geo_lat:LENGTH','geo_lat:geo_lat:WORDS'
          ,'geo_long:geo_long:LEFTTRIM','geo_long:geo_long:ALLOW','geo_long:geo_long:LENGTH','geo_long:geo_long:WORDS'
          ,'msa:msa:LEFTTRIM','msa:msa:ALLOW','msa:msa:LENGTH','msa:msa:WORDS'
          ,'geo_blk:geo_blk:LEFTTRIM','geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTH','geo_blk:geo_blk:WORDS'
          ,'geo_match:geo_match:LEFTTRIM','geo_match:geo_match:ALLOW','geo_match:geo_match:LENGTH','geo_match:geo_match:WORDS'
          ,'err_stat:err_stat:LEFTTRIM','err_stat:err_stat:ALLOW','err_stat:err_stat:LENGTH','err_stat:err_stat:WORDS'
          ,'delete_flag:delete_flag:LEFTTRIM','delete_flag:delete_flag:ALLOW','delete_flag:delete_flag:LENGTH','delete_flag:delete_flag:WORDS'
          ,'delete_file_date:delete_file_date:LEFTTRIM','delete_file_date:delete_file_date:ALLOW','delete_file_date:delete_file_date:LENGTH','delete_file_date:delete_file_date:WORDS'
          ,'suppression_code:suppression_code:LEFTTRIM','suppression_code:suppression_code:ALLOW','suppression_code:suppression_code:LENGTH','suppression_code:suppression_code:WORDS'
          ,'deceased_ind:deceased_ind:LEFTTRIM','deceased_ind:deceased_ind:ALLOW','deceased_ind:deceased_ind:LENGTH','deceased_ind:deceased_ind:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_seq_rec_id(1),Fields.InvalidMessage_seq_rec_id(2),Fields.InvalidMessage_seq_rec_id(3),Fields.InvalidMessage_seq_rec_id(4)
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2),Fields.InvalidMessage_did(3),Fields.InvalidMessage_did(4)
          ,Fields.InvalidMessage_did_score_field(1),Fields.InvalidMessage_did_score_field(2),Fields.InvalidMessage_did_score_field(3),Fields.InvalidMessage_did_score_field(4)
          ,Fields.InvalidMessage_current_rec_flag(1),Fields.InvalidMessage_current_rec_flag(2),Fields.InvalidMessage_current_rec_flag(3),Fields.InvalidMessage_current_rec_flag(4)
          ,Fields.InvalidMessage_current_experian_pin(1),Fields.InvalidMessage_current_experian_pin(2),Fields.InvalidMessage_current_experian_pin(3),Fields.InvalidMessage_current_experian_pin(4)
          ,Fields.InvalidMessage_date_first_seen(1),Fields.InvalidMessage_date_first_seen(2),Fields.InvalidMessage_date_first_seen(3),Fields.InvalidMessage_date_first_seen(4)
          ,Fields.InvalidMessage_date_last_seen(1),Fields.InvalidMessage_date_last_seen(2),Fields.InvalidMessage_date_last_seen(3),Fields.InvalidMessage_date_last_seen(4)
          ,Fields.InvalidMessage_date_vendor_first_reported(1),Fields.InvalidMessage_date_vendor_first_reported(2),Fields.InvalidMessage_date_vendor_first_reported(3),Fields.InvalidMessage_date_vendor_first_reported(4)
          ,Fields.InvalidMessage_date_vendor_last_reported(1),Fields.InvalidMessage_date_vendor_last_reported(2),Fields.InvalidMessage_date_vendor_last_reported(3),Fields.InvalidMessage_date_vendor_last_reported(4)
          ,Fields.InvalidMessage_encrypted_experian_pin(1),Fields.InvalidMessage_encrypted_experian_pin(2),Fields.InvalidMessage_encrypted_experian_pin(3),Fields.InvalidMessage_encrypted_experian_pin(4)
          ,Fields.InvalidMessage_social_security_number(1),Fields.InvalidMessage_social_security_number(2),Fields.InvalidMessage_social_security_number(3),Fields.InvalidMessage_social_security_number(4)
          ,Fields.InvalidMessage_date_of_birth(1),Fields.InvalidMessage_date_of_birth(2),Fields.InvalidMessage_date_of_birth(3),Fields.InvalidMessage_date_of_birth(4)
          ,Fields.InvalidMessage_telephone(1),Fields.InvalidMessage_telephone(2),Fields.InvalidMessage_telephone(3),Fields.InvalidMessage_telephone(4)
          ,Fields.InvalidMessage_gender(1),Fields.InvalidMessage_gender(2),Fields.InvalidMessage_gender(3),Fields.InvalidMessage_gender(4)
          ,Fields.InvalidMessage_additional_name_count(1),Fields.InvalidMessage_additional_name_count(2),Fields.InvalidMessage_additional_name_count(3),Fields.InvalidMessage_additional_name_count(4)
          ,Fields.InvalidMessage_previous_address_count(1),Fields.InvalidMessage_previous_address_count(2),Fields.InvalidMessage_previous_address_count(3),Fields.InvalidMessage_previous_address_count(4)
          ,Fields.InvalidMessage_nametype(1),Fields.InvalidMessage_nametype(2),Fields.InvalidMessage_nametype(3),Fields.InvalidMessage_nametype(4)
          ,Fields.InvalidMessage_orig_consumer_create_date(1),Fields.InvalidMessage_orig_consumer_create_date(2),Fields.InvalidMessage_orig_consumer_create_date(3),Fields.InvalidMessage_orig_consumer_create_date(4)
          ,Fields.InvalidMessage_orig_fname(1),Fields.InvalidMessage_orig_fname(2),Fields.InvalidMessage_orig_fname(3),Fields.InvalidMessage_orig_fname(4)
          ,Fields.InvalidMessage_orig_mname(1),Fields.InvalidMessage_orig_mname(2),Fields.InvalidMessage_orig_mname(3),Fields.InvalidMessage_orig_mname(4)
          ,Fields.InvalidMessage_orig_lname(1),Fields.InvalidMessage_orig_lname(2),Fields.InvalidMessage_orig_lname(3),Fields.InvalidMessage_orig_lname(4)
          ,Fields.InvalidMessage_orig_suffix(1),Fields.InvalidMessage_orig_suffix(2),Fields.InvalidMessage_orig_suffix(3),Fields.InvalidMessage_orig_suffix(4)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2),Fields.InvalidMessage_title(3),Fields.InvalidMessage_title(4)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2),Fields.InvalidMessage_fname(3),Fields.InvalidMessage_fname(4)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2),Fields.InvalidMessage_mname(3),Fields.InvalidMessage_mname(4)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3),Fields.InvalidMessage_lname(4)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3),Fields.InvalidMessage_name_suffix(4)
          ,Fields.InvalidMessage_name_score(1),Fields.InvalidMessage_name_score(2),Fields.InvalidMessage_name_score(3),Fields.InvalidMessage_name_score(4)
          ,Fields.InvalidMessage_addressseq(1),Fields.InvalidMessage_addressseq(2),Fields.InvalidMessage_addressseq(3),Fields.InvalidMessage_addressseq(4)
          ,Fields.InvalidMessage_orig_address_create_date(1),Fields.InvalidMessage_orig_address_create_date(2),Fields.InvalidMessage_orig_address_create_date(3),Fields.InvalidMessage_orig_address_create_date(4)
          ,Fields.InvalidMessage_orig_address_update_date(1),Fields.InvalidMessage_orig_address_update_date(2),Fields.InvalidMessage_orig_address_update_date(3),Fields.InvalidMessage_orig_address_update_date(4)
          ,Fields.InvalidMessage_orig_prim_range(1),Fields.InvalidMessage_orig_prim_range(2),Fields.InvalidMessage_orig_prim_range(3),Fields.InvalidMessage_orig_prim_range(4)
          ,Fields.InvalidMessage_orig_predir(1),Fields.InvalidMessage_orig_predir(2),Fields.InvalidMessage_orig_predir(3),Fields.InvalidMessage_orig_predir(4)
          ,Fields.InvalidMessage_orig_prim_name(1),Fields.InvalidMessage_orig_prim_name(2),Fields.InvalidMessage_orig_prim_name(3),Fields.InvalidMessage_orig_prim_name(4)
          ,Fields.InvalidMessage_orig_addr_suffix(1),Fields.InvalidMessage_orig_addr_suffix(2),Fields.InvalidMessage_orig_addr_suffix(3),Fields.InvalidMessage_orig_addr_suffix(4)
          ,Fields.InvalidMessage_orig_postdir(1),Fields.InvalidMessage_orig_postdir(2),Fields.InvalidMessage_orig_postdir(3),Fields.InvalidMessage_orig_postdir(4)
          ,Fields.InvalidMessage_orig_unit_desig(1),Fields.InvalidMessage_orig_unit_desig(2),Fields.InvalidMessage_orig_unit_desig(3),Fields.InvalidMessage_orig_unit_desig(4)
          ,Fields.InvalidMessage_orig_sec_range(1),Fields.InvalidMessage_orig_sec_range(2),Fields.InvalidMessage_orig_sec_range(3),Fields.InvalidMessage_orig_sec_range(4)
          ,Fields.InvalidMessage_orig_city(1),Fields.InvalidMessage_orig_city(2),Fields.InvalidMessage_orig_city(3),Fields.InvalidMessage_orig_city(4)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2),Fields.InvalidMessage_orig_state(3),Fields.InvalidMessage_orig_state(4)
          ,Fields.InvalidMessage_orig_zipcode(1),Fields.InvalidMessage_orig_zipcode(2),Fields.InvalidMessage_orig_zipcode(3),Fields.InvalidMessage_orig_zipcode(4)
          ,Fields.InvalidMessage_orig_zipcode4(1),Fields.InvalidMessage_orig_zipcode4(2),Fields.InvalidMessage_orig_zipcode4(3),Fields.InvalidMessage_orig_zipcode4(4)
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
          ,Fields.InvalidMessage_county(1),Fields.InvalidMessage_county(2),Fields.InvalidMessage_county(3),Fields.InvalidMessage_county(4)
          ,Fields.InvalidMessage_geo_lat(1),Fields.InvalidMessage_geo_lat(2),Fields.InvalidMessage_geo_lat(3),Fields.InvalidMessage_geo_lat(4)
          ,Fields.InvalidMessage_geo_long(1),Fields.InvalidMessage_geo_long(2),Fields.InvalidMessage_geo_long(3),Fields.InvalidMessage_geo_long(4)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2),Fields.InvalidMessage_msa(3),Fields.InvalidMessage_msa(4)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2),Fields.InvalidMessage_geo_blk(3),Fields.InvalidMessage_geo_blk(4)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2),Fields.InvalidMessage_geo_match(3),Fields.InvalidMessage_geo_match(4)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2),Fields.InvalidMessage_err_stat(3),Fields.InvalidMessage_err_stat(4)
          ,Fields.InvalidMessage_delete_flag(1),Fields.InvalidMessage_delete_flag(2),Fields.InvalidMessage_delete_flag(3),Fields.InvalidMessage_delete_flag(4)
          ,Fields.InvalidMessage_delete_file_date(1),Fields.InvalidMessage_delete_file_date(2),Fields.InvalidMessage_delete_file_date(3),Fields.InvalidMessage_delete_file_date(4)
          ,Fields.InvalidMessage_suppression_code(1),Fields.InvalidMessage_suppression_code(2),Fields.InvalidMessage_suppression_code(3),Fields.InvalidMessage_suppression_code(4)
          ,Fields.InvalidMessage_deceased_ind(1),Fields.InvalidMessage_deceased_ind(2),Fields.InvalidMessage_deceased_ind(3),Fields.InvalidMessage_deceased_ind(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.seq_rec_id_LEFTTRIM_ErrorCount,le.seq_rec_id_ALLOW_ErrorCount,le.seq_rec_id_LENGTH_ErrorCount,le.seq_rec_id_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_field_LEFTTRIM_ErrorCount,le.did_score_field_ALLOW_ErrorCount,le.did_score_field_LENGTH_ErrorCount,le.did_score_field_WORDS_ErrorCount
          ,le.current_rec_flag_LEFTTRIM_ErrorCount,le.current_rec_flag_ALLOW_ErrorCount,le.current_rec_flag_LENGTH_ErrorCount,le.current_rec_flag_WORDS_ErrorCount
          ,le.current_experian_pin_LEFTTRIM_ErrorCount,le.current_experian_pin_ALLOW_ErrorCount,le.current_experian_pin_LENGTH_ErrorCount,le.current_experian_pin_WORDS_ErrorCount
          ,le.date_first_seen_LEFTTRIM_ErrorCount,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount,le.date_first_seen_WORDS_ErrorCount
          ,le.date_last_seen_LEFTTRIM_ErrorCount,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount,le.date_last_seen_WORDS_ErrorCount
          ,le.date_vendor_first_reported_LEFTTRIM_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount,le.date_vendor_first_reported_WORDS_ErrorCount
          ,le.date_vendor_last_reported_LEFTTRIM_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,le.date_vendor_last_reported_WORDS_ErrorCount
          ,le.encrypted_experian_pin_LEFTTRIM_ErrorCount,le.encrypted_experian_pin_ALLOW_ErrorCount,le.encrypted_experian_pin_LENGTH_ErrorCount,le.encrypted_experian_pin_WORDS_ErrorCount
          ,le.social_security_number_LEFTTRIM_ErrorCount,le.social_security_number_ALLOW_ErrorCount,le.social_security_number_LENGTH_ErrorCount,le.social_security_number_WORDS_ErrorCount
          ,le.date_of_birth_LEFTTRIM_ErrorCount,le.date_of_birth_ALLOW_ErrorCount,le.date_of_birth_LENGTH_ErrorCount,le.date_of_birth_WORDS_ErrorCount
          ,le.telephone_LEFTTRIM_ErrorCount,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTH_ErrorCount,le.telephone_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTH_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.additional_name_count_LEFTTRIM_ErrorCount,le.additional_name_count_ALLOW_ErrorCount,le.additional_name_count_LENGTH_ErrorCount,le.additional_name_count_WORDS_ErrorCount
          ,le.previous_address_count_LEFTTRIM_ErrorCount,le.previous_address_count_ALLOW_ErrorCount,le.previous_address_count_LENGTH_ErrorCount,le.previous_address_count_WORDS_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount,le.nametype_LENGTH_ErrorCount,le.nametype_WORDS_ErrorCount
          ,le.orig_consumer_create_date_LEFTTRIM_ErrorCount,le.orig_consumer_create_date_ALLOW_ErrorCount,le.orig_consumer_create_date_LENGTH_ErrorCount,le.orig_consumer_create_date_WORDS_ErrorCount
          ,le.orig_fname_LEFTTRIM_ErrorCount,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_LEFTTRIM_ErrorCount,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_LEFTTRIM_ErrorCount,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_suffix_LEFTTRIM_ErrorCount,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_LENGTH_ErrorCount,le.orig_suffix_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.addressseq_LEFTTRIM_ErrorCount,le.addressseq_ALLOW_ErrorCount,le.addressseq_LENGTH_ErrorCount,le.addressseq_WORDS_ErrorCount
          ,le.orig_address_create_date_LEFTTRIM_ErrorCount,le.orig_address_create_date_ALLOW_ErrorCount,le.orig_address_create_date_LENGTH_ErrorCount,le.orig_address_create_date_WORDS_ErrorCount
          ,le.orig_address_update_date_LEFTTRIM_ErrorCount,le.orig_address_update_date_ALLOW_ErrorCount,le.orig_address_update_date_LENGTH_ErrorCount,le.orig_address_update_date_WORDS_ErrorCount
          ,le.orig_prim_range_LEFTTRIM_ErrorCount,le.orig_prim_range_ALLOW_ErrorCount,le.orig_prim_range_LENGTH_ErrorCount,le.orig_prim_range_WORDS_ErrorCount
          ,le.orig_predir_LEFTTRIM_ErrorCount,le.orig_predir_ALLOW_ErrorCount,le.orig_predir_LENGTH_ErrorCount,le.orig_predir_WORDS_ErrorCount
          ,le.orig_prim_name_LEFTTRIM_ErrorCount,le.orig_prim_name_ALLOW_ErrorCount,le.orig_prim_name_LENGTH_ErrorCount,le.orig_prim_name_WORDS_ErrorCount
          ,le.orig_addr_suffix_LEFTTRIM_ErrorCount,le.orig_addr_suffix_ALLOW_ErrorCount,le.orig_addr_suffix_LENGTH_ErrorCount,le.orig_addr_suffix_WORDS_ErrorCount
          ,le.orig_postdir_LEFTTRIM_ErrorCount,le.orig_postdir_ALLOW_ErrorCount,le.orig_postdir_LENGTH_ErrorCount,le.orig_postdir_WORDS_ErrorCount
          ,le.orig_unit_desig_LEFTTRIM_ErrorCount,le.orig_unit_desig_ALLOW_ErrorCount,le.orig_unit_desig_LENGTH_ErrorCount,le.orig_unit_desig_WORDS_ErrorCount
          ,le.orig_sec_range_LEFTTRIM_ErrorCount,le.orig_sec_range_ALLOW_ErrorCount,le.orig_sec_range_LENGTH_ErrorCount,le.orig_sec_range_WORDS_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_LENGTH_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTH_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zipcode_LEFTTRIM_ErrorCount,le.orig_zipcode_ALLOW_ErrorCount,le.orig_zipcode_LENGTH_ErrorCount,le.orig_zipcode_WORDS_ErrorCount
          ,le.orig_zipcode4_LEFTTRIM_ErrorCount,le.orig_zipcode4_ALLOW_ErrorCount,le.orig_zipcode4_LENGTH_ErrorCount,le.orig_zipcode4_WORDS_ErrorCount
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
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.delete_flag_LEFTTRIM_ErrorCount,le.delete_flag_ALLOW_ErrorCount,le.delete_flag_LENGTH_ErrorCount,le.delete_flag_WORDS_ErrorCount
          ,le.delete_file_date_LEFTTRIM_ErrorCount,le.delete_file_date_ALLOW_ErrorCount,le.delete_file_date_LENGTH_ErrorCount,le.delete_file_date_WORDS_ErrorCount
          ,le.suppression_code_LEFTTRIM_ErrorCount,le.suppression_code_ALLOW_ErrorCount,le.suppression_code_LENGTH_ErrorCount,le.suppression_code_WORDS_ErrorCount
          ,le.deceased_ind_LEFTTRIM_ErrorCount,le.deceased_ind_ALLOW_ErrorCount,le.deceased_ind_LENGTH_ErrorCount,le.deceased_ind_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.seq_rec_id_LEFTTRIM_ErrorCount,le.seq_rec_id_ALLOW_ErrorCount,le.seq_rec_id_LENGTH_ErrorCount,le.seq_rec_id_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_field_LEFTTRIM_ErrorCount,le.did_score_field_ALLOW_ErrorCount,le.did_score_field_LENGTH_ErrorCount,le.did_score_field_WORDS_ErrorCount
          ,le.current_rec_flag_LEFTTRIM_ErrorCount,le.current_rec_flag_ALLOW_ErrorCount,le.current_rec_flag_LENGTH_ErrorCount,le.current_rec_flag_WORDS_ErrorCount
          ,le.current_experian_pin_LEFTTRIM_ErrorCount,le.current_experian_pin_ALLOW_ErrorCount,le.current_experian_pin_LENGTH_ErrorCount,le.current_experian_pin_WORDS_ErrorCount
          ,le.date_first_seen_LEFTTRIM_ErrorCount,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount,le.date_first_seen_WORDS_ErrorCount
          ,le.date_last_seen_LEFTTRIM_ErrorCount,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount,le.date_last_seen_WORDS_ErrorCount
          ,le.date_vendor_first_reported_LEFTTRIM_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount,le.date_vendor_first_reported_WORDS_ErrorCount
          ,le.date_vendor_last_reported_LEFTTRIM_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount,le.date_vendor_last_reported_WORDS_ErrorCount
          ,le.encrypted_experian_pin_LEFTTRIM_ErrorCount,le.encrypted_experian_pin_ALLOW_ErrorCount,le.encrypted_experian_pin_LENGTH_ErrorCount,le.encrypted_experian_pin_WORDS_ErrorCount
          ,le.social_security_number_LEFTTRIM_ErrorCount,le.social_security_number_ALLOW_ErrorCount,le.social_security_number_LENGTH_ErrorCount,le.social_security_number_WORDS_ErrorCount
          ,le.date_of_birth_LEFTTRIM_ErrorCount,le.date_of_birth_ALLOW_ErrorCount,le.date_of_birth_LENGTH_ErrorCount,le.date_of_birth_WORDS_ErrorCount
          ,le.telephone_LEFTTRIM_ErrorCount,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTH_ErrorCount,le.telephone_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTH_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.additional_name_count_LEFTTRIM_ErrorCount,le.additional_name_count_ALLOW_ErrorCount,le.additional_name_count_LENGTH_ErrorCount,le.additional_name_count_WORDS_ErrorCount
          ,le.previous_address_count_LEFTTRIM_ErrorCount,le.previous_address_count_ALLOW_ErrorCount,le.previous_address_count_LENGTH_ErrorCount,le.previous_address_count_WORDS_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount,le.nametype_LENGTH_ErrorCount,le.nametype_WORDS_ErrorCount
          ,le.orig_consumer_create_date_LEFTTRIM_ErrorCount,le.orig_consumer_create_date_ALLOW_ErrorCount,le.orig_consumer_create_date_LENGTH_ErrorCount,le.orig_consumer_create_date_WORDS_ErrorCount
          ,le.orig_fname_LEFTTRIM_ErrorCount,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_LEFTTRIM_ErrorCount,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_LEFTTRIM_ErrorCount,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_suffix_LEFTTRIM_ErrorCount,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_LENGTH_ErrorCount,le.orig_suffix_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTH_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.addressseq_LEFTTRIM_ErrorCount,le.addressseq_ALLOW_ErrorCount,le.addressseq_LENGTH_ErrorCount,le.addressseq_WORDS_ErrorCount
          ,le.orig_address_create_date_LEFTTRIM_ErrorCount,le.orig_address_create_date_ALLOW_ErrorCount,le.orig_address_create_date_LENGTH_ErrorCount,le.orig_address_create_date_WORDS_ErrorCount
          ,le.orig_address_update_date_LEFTTRIM_ErrorCount,le.orig_address_update_date_ALLOW_ErrorCount,le.orig_address_update_date_LENGTH_ErrorCount,le.orig_address_update_date_WORDS_ErrorCount
          ,le.orig_prim_range_LEFTTRIM_ErrorCount,le.orig_prim_range_ALLOW_ErrorCount,le.orig_prim_range_LENGTH_ErrorCount,le.orig_prim_range_WORDS_ErrorCount
          ,le.orig_predir_LEFTTRIM_ErrorCount,le.orig_predir_ALLOW_ErrorCount,le.orig_predir_LENGTH_ErrorCount,le.orig_predir_WORDS_ErrorCount
          ,le.orig_prim_name_LEFTTRIM_ErrorCount,le.orig_prim_name_ALLOW_ErrorCount,le.orig_prim_name_LENGTH_ErrorCount,le.orig_prim_name_WORDS_ErrorCount
          ,le.orig_addr_suffix_LEFTTRIM_ErrorCount,le.orig_addr_suffix_ALLOW_ErrorCount,le.orig_addr_suffix_LENGTH_ErrorCount,le.orig_addr_suffix_WORDS_ErrorCount
          ,le.orig_postdir_LEFTTRIM_ErrorCount,le.orig_postdir_ALLOW_ErrorCount,le.orig_postdir_LENGTH_ErrorCount,le.orig_postdir_WORDS_ErrorCount
          ,le.orig_unit_desig_LEFTTRIM_ErrorCount,le.orig_unit_desig_ALLOW_ErrorCount,le.orig_unit_desig_LENGTH_ErrorCount,le.orig_unit_desig_WORDS_ErrorCount
          ,le.orig_sec_range_LEFTTRIM_ErrorCount,le.orig_sec_range_ALLOW_ErrorCount,le.orig_sec_range_LENGTH_ErrorCount,le.orig_sec_range_WORDS_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_LENGTH_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTH_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zipcode_LEFTTRIM_ErrorCount,le.orig_zipcode_ALLOW_ErrorCount,le.orig_zipcode_LENGTH_ErrorCount,le.orig_zipcode_WORDS_ErrorCount
          ,le.orig_zipcode4_LEFTTRIM_ErrorCount,le.orig_zipcode4_ALLOW_ErrorCount,le.orig_zipcode4_LENGTH_ErrorCount,le.orig_zipcode4_WORDS_ErrorCount
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
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTH_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTH_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.delete_flag_LEFTTRIM_ErrorCount,le.delete_flag_ALLOW_ErrorCount,le.delete_flag_LENGTH_ErrorCount,le.delete_flag_WORDS_ErrorCount
          ,le.delete_file_date_LEFTTRIM_ErrorCount,le.delete_file_date_ALLOW_ErrorCount,le.delete_file_date_LENGTH_ErrorCount,le.delete_file_date_WORDS_ErrorCount
          ,le.suppression_code_LEFTTRIM_ErrorCount,le.suppression_code_ALLOW_ErrorCount,le.suppression_code_LENGTH_ErrorCount,le.suppression_code_WORDS_ErrorCount
          ,le.deceased_ind_LEFTTRIM_ErrorCount,le.deceased_ind_ALLOW_ErrorCount,le.deceased_ind_LENGTH_ErrorCount,le.deceased_ind_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,288,Into(LEFT,COUNTER));
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
