IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_seq_rec_id_cnt := COUNT(GROUP,h.seq_rec_id <> (TYPEOF(h.seq_rec_id))'');
    populated_seq_rec_id_pcnt := AVE(GROUP,IF(h.seq_rec_id = (TYPEOF(h.seq_rec_id))'',0,100));
    maxlength_seq_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seq_rec_id)));
    avelength_seq_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seq_rec_id)),h.seq_rec_id<>(typeof(h.seq_rec_id))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_field_cnt := COUNT(GROUP,h.did_score_field <> (TYPEOF(h.did_score_field))'');
    populated_did_score_field_pcnt := AVE(GROUP,IF(h.did_score_field = (TYPEOF(h.did_score_field))'',0,100));
    maxlength_did_score_field := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score_field)));
    avelength_did_score_field := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score_field)),h.did_score_field<>(typeof(h.did_score_field))'');
    populated_current_rec_flag_cnt := COUNT(GROUP,h.current_rec_flag <> (TYPEOF(h.current_rec_flag))'');
    populated_current_rec_flag_pcnt := AVE(GROUP,IF(h.current_rec_flag = (TYPEOF(h.current_rec_flag))'',0,100));
    maxlength_current_rec_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec_flag)));
    avelength_current_rec_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec_flag)),h.current_rec_flag<>(typeof(h.current_rec_flag))'');
    populated_current_experian_pin_cnt := COUNT(GROUP,h.current_experian_pin <> (TYPEOF(h.current_experian_pin))'');
    populated_current_experian_pin_pcnt := AVE(GROUP,IF(h.current_experian_pin = (TYPEOF(h.current_experian_pin))'',0,100));
    maxlength_current_experian_pin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_experian_pin)));
    avelength_current_experian_pin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_experian_pin)),h.current_experian_pin<>(typeof(h.current_experian_pin))'');
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
    populated_encrypted_experian_pin_cnt := COUNT(GROUP,h.encrypted_experian_pin <> (TYPEOF(h.encrypted_experian_pin))'');
    populated_encrypted_experian_pin_pcnt := AVE(GROUP,IF(h.encrypted_experian_pin = (TYPEOF(h.encrypted_experian_pin))'',0,100));
    maxlength_encrypted_experian_pin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.encrypted_experian_pin)));
    avelength_encrypted_experian_pin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.encrypted_experian_pin)),h.encrypted_experian_pin<>(typeof(h.encrypted_experian_pin))'');
    populated_social_security_number_cnt := COUNT(GROUP,h.social_security_number <> (TYPEOF(h.social_security_number))'');
    populated_social_security_number_pcnt := AVE(GROUP,IF(h.social_security_number = (TYPEOF(h.social_security_number))'',0,100));
    maxlength_social_security_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.social_security_number)));
    avelength_social_security_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.social_security_number)),h.social_security_number<>(typeof(h.social_security_number))'');
    populated_date_of_birth_cnt := COUNT(GROUP,h.date_of_birth <> (TYPEOF(h.date_of_birth))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_telephone_cnt := COUNT(GROUP,h.telephone <> (TYPEOF(h.telephone))'');
    populated_telephone_pcnt := AVE(GROUP,IF(h.telephone = (TYPEOF(h.telephone))'',0,100));
    maxlength_telephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)));
    avelength_telephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)),h.telephone<>(typeof(h.telephone))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_additional_name_count_cnt := COUNT(GROUP,h.additional_name_count <> (TYPEOF(h.additional_name_count))'');
    populated_additional_name_count_pcnt := AVE(GROUP,IF(h.additional_name_count = (TYPEOF(h.additional_name_count))'',0,100));
    maxlength_additional_name_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.additional_name_count)));
    avelength_additional_name_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.additional_name_count)),h.additional_name_count<>(typeof(h.additional_name_count))'');
    populated_previous_address_count_cnt := COUNT(GROUP,h.previous_address_count <> (TYPEOF(h.previous_address_count))'');
    populated_previous_address_count_pcnt := AVE(GROUP,IF(h.previous_address_count = (TYPEOF(h.previous_address_count))'',0,100));
    maxlength_previous_address_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.previous_address_count)));
    avelength_previous_address_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.previous_address_count)),h.previous_address_count<>(typeof(h.previous_address_count))'');
    populated_nametype_cnt := COUNT(GROUP,h.nametype <> (TYPEOF(h.nametype))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_orig_consumer_create_date_cnt := COUNT(GROUP,h.orig_consumer_create_date <> (TYPEOF(h.orig_consumer_create_date))'');
    populated_orig_consumer_create_date_pcnt := AVE(GROUP,IF(h.orig_consumer_create_date = (TYPEOF(h.orig_consumer_create_date))'',0,100));
    maxlength_orig_consumer_create_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_consumer_create_date)));
    avelength_orig_consumer_create_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_consumer_create_date)),h.orig_consumer_create_date<>(typeof(h.orig_consumer_create_date))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_suffix_cnt := COUNT(GROUP,h.orig_suffix <> (TYPEOF(h.orig_suffix))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
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
    populated_addressseq_cnt := COUNT(GROUP,h.addressseq <> (TYPEOF(h.addressseq))'');
    populated_addressseq_pcnt := AVE(GROUP,IF(h.addressseq = (TYPEOF(h.addressseq))'',0,100));
    maxlength_addressseq := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressseq)));
    avelength_addressseq := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressseq)),h.addressseq<>(typeof(h.addressseq))'');
    populated_orig_address_create_date_cnt := COUNT(GROUP,h.orig_address_create_date <> (TYPEOF(h.orig_address_create_date))'');
    populated_orig_address_create_date_pcnt := AVE(GROUP,IF(h.orig_address_create_date = (TYPEOF(h.orig_address_create_date))'',0,100));
    maxlength_orig_address_create_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_create_date)));
    avelength_orig_address_create_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_create_date)),h.orig_address_create_date<>(typeof(h.orig_address_create_date))'');
    populated_orig_address_update_date_cnt := COUNT(GROUP,h.orig_address_update_date <> (TYPEOF(h.orig_address_update_date))'');
    populated_orig_address_update_date_pcnt := AVE(GROUP,IF(h.orig_address_update_date = (TYPEOF(h.orig_address_update_date))'',0,100));
    maxlength_orig_address_update_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_update_date)));
    avelength_orig_address_update_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_address_update_date)),h.orig_address_update_date<>(typeof(h.orig_address_update_date))'');
    populated_orig_prim_range_cnt := COUNT(GROUP,h.orig_prim_range <> (TYPEOF(h.orig_prim_range))'');
    populated_orig_prim_range_pcnt := AVE(GROUP,IF(h.orig_prim_range = (TYPEOF(h.orig_prim_range))'',0,100));
    maxlength_orig_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_prim_range)));
    avelength_orig_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_prim_range)),h.orig_prim_range<>(typeof(h.orig_prim_range))'');
    populated_orig_predir_cnt := COUNT(GROUP,h.orig_predir <> (TYPEOF(h.orig_predir))'');
    populated_orig_predir_pcnt := AVE(GROUP,IF(h.orig_predir = (TYPEOF(h.orig_predir))'',0,100));
    maxlength_orig_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_predir)));
    avelength_orig_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_predir)),h.orig_predir<>(typeof(h.orig_predir))'');
    populated_orig_prim_name_cnt := COUNT(GROUP,h.orig_prim_name <> (TYPEOF(h.orig_prim_name))'');
    populated_orig_prim_name_pcnt := AVE(GROUP,IF(h.orig_prim_name = (TYPEOF(h.orig_prim_name))'',0,100));
    maxlength_orig_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_prim_name)));
    avelength_orig_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_prim_name)),h.orig_prim_name<>(typeof(h.orig_prim_name))'');
    populated_orig_addr_suffix_cnt := COUNT(GROUP,h.orig_addr_suffix <> (TYPEOF(h.orig_addr_suffix))'');
    populated_orig_addr_suffix_pcnt := AVE(GROUP,IF(h.orig_addr_suffix = (TYPEOF(h.orig_addr_suffix))'',0,100));
    maxlength_orig_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_addr_suffix)));
    avelength_orig_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_addr_suffix)),h.orig_addr_suffix<>(typeof(h.orig_addr_suffix))'');
    populated_orig_postdir_cnt := COUNT(GROUP,h.orig_postdir <> (TYPEOF(h.orig_postdir))'');
    populated_orig_postdir_pcnt := AVE(GROUP,IF(h.orig_postdir = (TYPEOF(h.orig_postdir))'',0,100));
    maxlength_orig_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_postdir)));
    avelength_orig_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_postdir)),h.orig_postdir<>(typeof(h.orig_postdir))'');
    populated_orig_unit_desig_cnt := COUNT(GROUP,h.orig_unit_desig <> (TYPEOF(h.orig_unit_desig))'');
    populated_orig_unit_desig_pcnt := AVE(GROUP,IF(h.orig_unit_desig = (TYPEOF(h.orig_unit_desig))'',0,100));
    maxlength_orig_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_unit_desig)));
    avelength_orig_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_unit_desig)),h.orig_unit_desig<>(typeof(h.orig_unit_desig))'');
    populated_orig_sec_range_cnt := COUNT(GROUP,h.orig_sec_range <> (TYPEOF(h.orig_sec_range))'');
    populated_orig_sec_range_pcnt := AVE(GROUP,IF(h.orig_sec_range = (TYPEOF(h.orig_sec_range))'',0,100));
    maxlength_orig_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_sec_range)));
    avelength_orig_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_sec_range)),h.orig_sec_range<>(typeof(h.orig_sec_range))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zipcode_cnt := COUNT(GROUP,h.orig_zipcode <> (TYPEOF(h.orig_zipcode))'');
    populated_orig_zipcode_pcnt := AVE(GROUP,IF(h.orig_zipcode = (TYPEOF(h.orig_zipcode))'',0,100));
    maxlength_orig_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zipcode)));
    avelength_orig_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zipcode)),h.orig_zipcode<>(typeof(h.orig_zipcode))'');
    populated_orig_zipcode4_cnt := COUNT(GROUP,h.orig_zipcode4 <> (TYPEOF(h.orig_zipcode4))'');
    populated_orig_zipcode4_pcnt := AVE(GROUP,IF(h.orig_zipcode4 = (TYPEOF(h.orig_zipcode4))'',0,100));
    maxlength_orig_zipcode4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zipcode4)));
    avelength_orig_zipcode4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zipcode4)),h.orig_zipcode4<>(typeof(h.orig_zipcode4))'');
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
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
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
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
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
    populated_delete_flag_cnt := COUNT(GROUP,h.delete_flag <> (TYPEOF(h.delete_flag))'');
    populated_delete_flag_pcnt := AVE(GROUP,IF(h.delete_flag = (TYPEOF(h.delete_flag))'',0,100));
    maxlength_delete_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.delete_flag)));
    avelength_delete_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.delete_flag)),h.delete_flag<>(typeof(h.delete_flag))'');
    populated_delete_file_date_cnt := COUNT(GROUP,h.delete_file_date <> (TYPEOF(h.delete_file_date))'');
    populated_delete_file_date_pcnt := AVE(GROUP,IF(h.delete_file_date = (TYPEOF(h.delete_file_date))'',0,100));
    maxlength_delete_file_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.delete_file_date)));
    avelength_delete_file_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.delete_file_date)),h.delete_file_date<>(typeof(h.delete_file_date))'');
    populated_suppression_code_cnt := COUNT(GROUP,h.suppression_code <> (TYPEOF(h.suppression_code))'');
    populated_suppression_code_pcnt := AVE(GROUP,IF(h.suppression_code = (TYPEOF(h.suppression_code))'',0,100));
    maxlength_suppression_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suppression_code)));
    avelength_suppression_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suppression_code)),h.suppression_code<>(typeof(h.suppression_code))'');
    populated_deceased_ind_cnt := COUNT(GROUP,h.deceased_ind <> (TYPEOF(h.deceased_ind))'');
    populated_deceased_ind_pcnt := AVE(GROUP,IF(h.deceased_ind = (TYPEOF(h.deceased_ind))'',0,100));
    maxlength_deceased_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceased_ind)));
    avelength_deceased_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deceased_ind)),h.deceased_ind<>(typeof(h.deceased_ind))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_seq_rec_id_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_field_pcnt *   0.00 / 100 + T.Populated_current_rec_flag_pcnt *   0.00 / 100 + T.Populated_current_experian_pin_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_encrypted_experian_pin_pcnt *   0.00 / 100 + T.Populated_social_security_number_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_telephone_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_additional_name_count_pcnt *   0.00 / 100 + T.Populated_previous_address_count_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_orig_consumer_create_date_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_addressseq_pcnt *   0.00 / 100 + T.Populated_orig_address_create_date_pcnt *   0.00 / 100 + T.Populated_orig_address_update_date_pcnt *   0.00 / 100 + T.Populated_orig_prim_range_pcnt *   0.00 / 100 + T.Populated_orig_predir_pcnt *   0.00 / 100 + T.Populated_orig_prim_name_pcnt *   0.00 / 100 + T.Populated_orig_addr_suffix_pcnt *   0.00 / 100 + T.Populated_orig_postdir_pcnt *   0.00 / 100 + T.Populated_orig_unit_desig_pcnt *   0.00 / 100 + T.Populated_orig_sec_range_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zipcode_pcnt *   0.00 / 100 + T.Populated_orig_zipcode4_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_delete_flag_pcnt *   0.00 / 100 + T.Populated_delete_file_date_pcnt *   0.00 / 100 + T.Populated_suppression_code_pcnt *   0.00 / 100 + T.Populated_deceased_ind_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind');
  SELF.populated_pcnt := CHOOSE(C,le.populated_seq_rec_id_pcnt,le.populated_did_pcnt,le.populated_did_score_field_pcnt,le.populated_current_rec_flag_pcnt,le.populated_current_experian_pin_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_encrypted_experian_pin_pcnt,le.populated_social_security_number_pcnt,le.populated_date_of_birth_pcnt,le.populated_telephone_pcnt,le.populated_gender_pcnt,le.populated_additional_name_count_pcnt,le.populated_previous_address_count_pcnt,le.populated_nametype_pcnt,le.populated_orig_consumer_create_date_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_suffix_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_addressseq_pcnt,le.populated_orig_address_create_date_pcnt,le.populated_orig_address_update_date_pcnt,le.populated_orig_prim_range_pcnt,le.populated_orig_predir_pcnt,le.populated_orig_prim_name_pcnt,le.populated_orig_addr_suffix_pcnt,le.populated_orig_postdir_pcnt,le.populated_orig_unit_desig_pcnt,le.populated_orig_sec_range_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zipcode_pcnt,le.populated_orig_zipcode4_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_delete_flag_pcnt,le.populated_delete_file_date_pcnt,le.populated_suppression_code_pcnt,le.populated_deceased_ind_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_seq_rec_id,le.maxlength_did,le.maxlength_did_score_field,le.maxlength_current_rec_flag,le.maxlength_current_experian_pin,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_encrypted_experian_pin,le.maxlength_social_security_number,le.maxlength_date_of_birth,le.maxlength_telephone,le.maxlength_gender,le.maxlength_additional_name_count,le.maxlength_previous_address_count,le.maxlength_nametype,le.maxlength_orig_consumer_create_date,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_suffix,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_addressseq,le.maxlength_orig_address_create_date,le.maxlength_orig_address_update_date,le.maxlength_orig_prim_range,le.maxlength_orig_predir,le.maxlength_orig_prim_name,le.maxlength_orig_addr_suffix,le.maxlength_orig_postdir,le.maxlength_orig_unit_desig,le.maxlength_orig_sec_range,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zipcode,le.maxlength_orig_zipcode4,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_delete_flag,le.maxlength_delete_file_date,le.maxlength_suppression_code,le.maxlength_deceased_ind);
  SELF.avelength := CHOOSE(C,le.avelength_seq_rec_id,le.avelength_did,le.avelength_did_score_field,le.avelength_current_rec_flag,le.avelength_current_experian_pin,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_encrypted_experian_pin,le.avelength_social_security_number,le.avelength_date_of_birth,le.avelength_telephone,le.avelength_gender,le.avelength_additional_name_count,le.avelength_previous_address_count,le.avelength_nametype,le.avelength_orig_consumer_create_date,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_suffix,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_addressseq,le.avelength_orig_address_create_date,le.avelength_orig_address_update_date,le.avelength_orig_prim_range,le.avelength_orig_predir,le.avelength_orig_prim_name,le.avelength_orig_addr_suffix,le.avelength_orig_postdir,le.avelength_orig_unit_desig,le.avelength_orig_sec_range,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zipcode,le.avelength_orig_zipcode4,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_delete_flag,le.avelength_delete_file_date,le.avelength_suppression_code,le.avelength_deceased_ind);
END;
EXPORT invSummary := NORMALIZE(summary0, 72, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.seq_rec_id <> 0,TRIM((SALT311.StrType)le.seq_rec_id), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score_field <> 0,TRIM((SALT311.StrType)le.did_score_field), ''),IF (le.current_rec_flag <> 0,TRIM((SALT311.StrType)le.current_rec_flag), ''),IF (le.current_experian_pin <> 0,TRIM((SALT311.StrType)le.current_experian_pin), ''),IF (le.date_first_seen <> 0,TRIM((SALT311.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT311.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),TRIM((SALT311.StrType)le.encrypted_experian_pin),TRIM((SALT311.StrType)le.social_security_number),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.additional_name_count),TRIM((SALT311.StrType)le.previous_address_count),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.orig_consumer_create_date),TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),IF (le.addressseq <> 0,TRIM((SALT311.StrType)le.addressseq), ''),TRIM((SALT311.StrType)le.orig_address_create_date),TRIM((SALT311.StrType)le.orig_address_update_date),TRIM((SALT311.StrType)le.orig_prim_range),TRIM((SALT311.StrType)le.orig_predir),TRIM((SALT311.StrType)le.orig_prim_name),TRIM((SALT311.StrType)le.orig_addr_suffix),TRIM((SALT311.StrType)le.orig_postdir),TRIM((SALT311.StrType)le.orig_unit_desig),TRIM((SALT311.StrType)le.orig_sec_range),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zipcode),TRIM((SALT311.StrType)le.orig_zipcode4),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.delete_flag <> 0,TRIM((SALT311.StrType)le.delete_flag), ''),IF (le.delete_file_date <> 0,TRIM((SALT311.StrType)le.delete_file_date), ''),IF (le.suppression_code <> 0,TRIM((SALT311.StrType)le.suppression_code), ''),IF (le.deceased_ind <> 0,TRIM((SALT311.StrType)le.deceased_ind), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,72,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 72);
  SELF.FldNo2 := 1 + (C % 72);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.seq_rec_id <> 0,TRIM((SALT311.StrType)le.seq_rec_id), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score_field <> 0,TRIM((SALT311.StrType)le.did_score_field), ''),IF (le.current_rec_flag <> 0,TRIM((SALT311.StrType)le.current_rec_flag), ''),IF (le.current_experian_pin <> 0,TRIM((SALT311.StrType)le.current_experian_pin), ''),IF (le.date_first_seen <> 0,TRIM((SALT311.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT311.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),TRIM((SALT311.StrType)le.encrypted_experian_pin),TRIM((SALT311.StrType)le.social_security_number),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.additional_name_count),TRIM((SALT311.StrType)le.previous_address_count),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.orig_consumer_create_date),TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),IF (le.addressseq <> 0,TRIM((SALT311.StrType)le.addressseq), ''),TRIM((SALT311.StrType)le.orig_address_create_date),TRIM((SALT311.StrType)le.orig_address_update_date),TRIM((SALT311.StrType)le.orig_prim_range),TRIM((SALT311.StrType)le.orig_predir),TRIM((SALT311.StrType)le.orig_prim_name),TRIM((SALT311.StrType)le.orig_addr_suffix),TRIM((SALT311.StrType)le.orig_postdir),TRIM((SALT311.StrType)le.orig_unit_desig),TRIM((SALT311.StrType)le.orig_sec_range),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zipcode),TRIM((SALT311.StrType)le.orig_zipcode4),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.delete_flag <> 0,TRIM((SALT311.StrType)le.delete_flag), ''),IF (le.delete_file_date <> 0,TRIM((SALT311.StrType)le.delete_file_date), ''),IF (le.suppression_code <> 0,TRIM((SALT311.StrType)le.suppression_code), ''),IF (le.deceased_ind <> 0,TRIM((SALT311.StrType)le.deceased_ind), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.seq_rec_id <> 0,TRIM((SALT311.StrType)le.seq_rec_id), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score_field <> 0,TRIM((SALT311.StrType)le.did_score_field), ''),IF (le.current_rec_flag <> 0,TRIM((SALT311.StrType)le.current_rec_flag), ''),IF (le.current_experian_pin <> 0,TRIM((SALT311.StrType)le.current_experian_pin), ''),IF (le.date_first_seen <> 0,TRIM((SALT311.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT311.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.date_vendor_last_reported), ''),TRIM((SALT311.StrType)le.encrypted_experian_pin),TRIM((SALT311.StrType)le.social_security_number),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.additional_name_count),TRIM((SALT311.StrType)le.previous_address_count),TRIM((SALT311.StrType)le.nametype),TRIM((SALT311.StrType)le.orig_consumer_create_date),TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_suffix),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),IF (le.addressseq <> 0,TRIM((SALT311.StrType)le.addressseq), ''),TRIM((SALT311.StrType)le.orig_address_create_date),TRIM((SALT311.StrType)le.orig_address_update_date),TRIM((SALT311.StrType)le.orig_prim_range),TRIM((SALT311.StrType)le.orig_predir),TRIM((SALT311.StrType)le.orig_prim_name),TRIM((SALT311.StrType)le.orig_addr_suffix),TRIM((SALT311.StrType)le.orig_postdir),TRIM((SALT311.StrType)le.orig_unit_desig),TRIM((SALT311.StrType)le.orig_sec_range),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zipcode),TRIM((SALT311.StrType)le.orig_zipcode4),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.delete_flag <> 0,TRIM((SALT311.StrType)le.delete_flag), ''),IF (le.delete_file_date <> 0,TRIM((SALT311.StrType)le.delete_file_date), ''),IF (le.suppression_code <> 0,TRIM((SALT311.StrType)le.suppression_code), ''),IF (le.deceased_ind <> 0,TRIM((SALT311.StrType)le.deceased_ind), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),72*72,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'seq_rec_id'}
      ,{2,'did'}
      ,{3,'did_score_field'}
      ,{4,'current_rec_flag'}
      ,{5,'current_experian_pin'}
      ,{6,'date_first_seen'}
      ,{7,'date_last_seen'}
      ,{8,'date_vendor_first_reported'}
      ,{9,'date_vendor_last_reported'}
      ,{10,'encrypted_experian_pin'}
      ,{11,'social_security_number'}
      ,{12,'date_of_birth'}
      ,{13,'telephone'}
      ,{14,'gender'}
      ,{15,'additional_name_count'}
      ,{16,'previous_address_count'}
      ,{17,'nametype'}
      ,{18,'orig_consumer_create_date'}
      ,{19,'orig_fname'}
      ,{20,'orig_mname'}
      ,{21,'orig_lname'}
      ,{22,'orig_suffix'}
      ,{23,'title'}
      ,{24,'fname'}
      ,{25,'mname'}
      ,{26,'lname'}
      ,{27,'name_suffix'}
      ,{28,'name_score'}
      ,{29,'addressseq'}
      ,{30,'orig_address_create_date'}
      ,{31,'orig_address_update_date'}
      ,{32,'orig_prim_range'}
      ,{33,'orig_predir'}
      ,{34,'orig_prim_name'}
      ,{35,'orig_addr_suffix'}
      ,{36,'orig_postdir'}
      ,{37,'orig_unit_desig'}
      ,{38,'orig_sec_range'}
      ,{39,'orig_city'}
      ,{40,'orig_state'}
      ,{41,'orig_zipcode'}
      ,{42,'orig_zipcode4'}
      ,{43,'prim_range'}
      ,{44,'predir'}
      ,{45,'prim_name'}
      ,{46,'addr_suffix'}
      ,{47,'postdir'}
      ,{48,'unit_desig'}
      ,{49,'sec_range'}
      ,{50,'p_city_name'}
      ,{51,'v_city_name'}
      ,{52,'st'}
      ,{53,'zip'}
      ,{54,'zip4'}
      ,{55,'cart'}
      ,{56,'cr_sort_sz'}
      ,{57,'lot'}
      ,{58,'lot_order'}
      ,{59,'dbpc'}
      ,{60,'chk_digit'}
      ,{61,'rec_type'}
      ,{62,'county'}
      ,{63,'geo_lat'}
      ,{64,'geo_long'}
      ,{65,'msa'}
      ,{66,'geo_blk'}
      ,{67,'geo_match'}
      ,{68,'err_stat'}
      ,{69,'delete_flag'}
      ,{70,'delete_file_date'}
      ,{71,'suppression_code'}
      ,{72,'deceased_ind'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_seq_rec_id((SALT311.StrType)le.seq_rec_id),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score_field((SALT311.StrType)le.did_score_field),
    Fields.InValid_current_rec_flag((SALT311.StrType)le.current_rec_flag),
    Fields.InValid_current_experian_pin((SALT311.StrType)le.current_experian_pin),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_encrypted_experian_pin((SALT311.StrType)le.encrypted_experian_pin),
    Fields.InValid_social_security_number((SALT311.StrType)le.social_security_number),
    Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth),
    Fields.InValid_telephone((SALT311.StrType)le.telephone),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_additional_name_count((SALT311.StrType)le.additional_name_count),
    Fields.InValid_previous_address_count((SALT311.StrType)le.previous_address_count),
    Fields.InValid_nametype((SALT311.StrType)le.nametype),
    Fields.InValid_orig_consumer_create_date((SALT311.StrType)le.orig_consumer_create_date),
    Fields.InValid_orig_fname((SALT311.StrType)le.orig_fname),
    Fields.InValid_orig_mname((SALT311.StrType)le.orig_mname),
    Fields.InValid_orig_lname((SALT311.StrType)le.orig_lname),
    Fields.InValid_orig_suffix((SALT311.StrType)le.orig_suffix),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Fields.InValid_addressseq((SALT311.StrType)le.addressseq),
    Fields.InValid_orig_address_create_date((SALT311.StrType)le.orig_address_create_date),
    Fields.InValid_orig_address_update_date((SALT311.StrType)le.orig_address_update_date),
    Fields.InValid_orig_prim_range((SALT311.StrType)le.orig_prim_range),
    Fields.InValid_orig_predir((SALT311.StrType)le.orig_predir),
    Fields.InValid_orig_prim_name((SALT311.StrType)le.orig_prim_name),
    Fields.InValid_orig_addr_suffix((SALT311.StrType)le.orig_addr_suffix),
    Fields.InValid_orig_postdir((SALT311.StrType)le.orig_postdir),
    Fields.InValid_orig_unit_desig((SALT311.StrType)le.orig_unit_desig),
    Fields.InValid_orig_sec_range((SALT311.StrType)le.orig_sec_range),
    Fields.InValid_orig_city((SALT311.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    Fields.InValid_orig_zipcode((SALT311.StrType)le.orig_zipcode),
    Fields.InValid_orig_zipcode4((SALT311.StrType)le.orig_zipcode4),
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
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_delete_flag((SALT311.StrType)le.delete_flag),
    Fields.InValid_delete_file_date((SALT311.StrType)le.delete_file_date),
    Fields.InValid_suppression_code((SALT311.StrType)le.suppression_code),
    Fields.InValid_deceased_ind((SALT311.StrType)le.deceased_ind),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,72,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_seq_rec_id(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score_field(TotalErrors.ErrorNum),Fields.InValidMessage_current_rec_flag(TotalErrors.ErrorNum),Fields.InValidMessage_current_experian_pin(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_encrypted_experian_pin(TotalErrors.ErrorNum),Fields.InValidMessage_social_security_number(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_telephone(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_additional_name_count(TotalErrors.ErrorNum),Fields.InValidMessage_previous_address_count(TotalErrors.ErrorNum),Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Fields.InValidMessage_orig_consumer_create_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_addressseq(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address_create_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address_update_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_predir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_orig_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zipcode4(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_delete_flag(TotalErrors.ErrorNum),Fields.InValidMessage_delete_file_date(TotalErrors.ErrorNum),Fields.InValidMessage_suppression_code(TotalErrors.ErrorNum),Fields.InValidMessage_deceased_ind(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Experian_Monthly, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
