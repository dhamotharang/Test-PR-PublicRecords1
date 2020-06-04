IMPORT SALT311,STD;
EXPORT HVCCW_hygiene(dataset(HVCCW_layout_eMerges) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_seqnum_cnt := COUNT(GROUP,h.append_seqnum <> (TYPEOF(h.append_seqnum))'');
    populated_append_seqnum_pcnt := AVE(GROUP,IF(h.append_seqnum = (TYPEOF(h.append_seqnum))'',0,100));
    maxlength_append_seqnum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_seqnum)));
    avelength_append_seqnum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_seqnum)),h.append_seqnum<>(typeof(h.append_seqnum))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
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
    populated_score_cnt := COUNT(GROUP,h.score <> (TYPEOF(h.score))'');
    populated_score_pcnt := AVE(GROUP,IF(h.score = (TYPEOF(h.score))'',0,100));
    maxlength_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.score)));
    avelength_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.score)),h.score<>(typeof(h.score))'');
    populated_best_ssn_cnt := COUNT(GROUP,h.best_ssn <> (TYPEOF(h.best_ssn))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_did_out_cnt := COUNT(GROUP,h.did_out <> (TYPEOF(h.did_out))'');
    populated_did_out_pcnt := AVE(GROUP,IF(h.did_out = (TYPEOF(h.did_out))'',0,100));
    maxlength_did_out := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_out)));
    avelength_did_out := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_out)),h.did_out<>(typeof(h.did_out))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_file_id_cnt := COUNT(GROUP,h.file_id <> (TYPEOF(h.file_id))'');
    populated_file_id_pcnt := AVE(GROUP,IF(h.file_id = (TYPEOF(h.file_id))'',0,100));
    maxlength_file_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_id)));
    avelength_file_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_id)),h.file_id<>(typeof(h.file_id))'');
    populated_vendor_id_cnt := COUNT(GROUP,h.vendor_id <> (TYPEOF(h.vendor_id))'');
    populated_vendor_id_pcnt := AVE(GROUP,IF(h.vendor_id = (TYPEOF(h.vendor_id))'',0,100));
    maxlength_vendor_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_id)));
    avelength_vendor_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_id)),h.vendor_id<>(typeof(h.vendor_id))'');
    populated_source_state_cnt := COUNT(GROUP,h.source_state <> (TYPEOF(h.source_state))'');
    populated_source_state_pcnt := AVE(GROUP,IF(h.source_state = (TYPEOF(h.source_state))'',0,100));
    maxlength_source_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_state)));
    avelength_source_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_state)),h.source_state<>(typeof(h.source_state))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_file_acquired_date_cnt := COUNT(GROUP,h.file_acquired_date <> (TYPEOF(h.file_acquired_date))'');
    populated_file_acquired_date_pcnt := AVE(GROUP,IF(h.file_acquired_date = (TYPEOF(h.file_acquired_date))'',0,100));
    maxlength_file_acquired_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_acquired_date)));
    avelength_file_acquired_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_acquired_date)),h.file_acquired_date<>(typeof(h.file_acquired_date))'');
    populated__use_cnt := COUNT(GROUP,h._use <> (TYPEOF(h._use))'');
    populated__use_pcnt := AVE(GROUP,IF(h._use = (TYPEOF(h._use))'',0,100));
    maxlength__use := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h._use)));
    avelength__use := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h._use)),h._use<>(typeof(h._use))'');
    populated_title_in_cnt := COUNT(GROUP,h.title_in <> (TYPEOF(h.title_in))'');
    populated_title_in_pcnt := AVE(GROUP,IF(h.title_in = (TYPEOF(h.title_in))'',0,100));
    maxlength_title_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_in)));
    avelength_title_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_in)),h.title_in<>(typeof(h.title_in))'');
    populated_lname_in_cnt := COUNT(GROUP,h.lname_in <> (TYPEOF(h.lname_in))'');
    populated_lname_in_pcnt := AVE(GROUP,IF(h.lname_in = (TYPEOF(h.lname_in))'',0,100));
    maxlength_lname_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname_in)));
    avelength_lname_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname_in)),h.lname_in<>(typeof(h.lname_in))'');
    populated_fname_in_cnt := COUNT(GROUP,h.fname_in <> (TYPEOF(h.fname_in))'');
    populated_fname_in_pcnt := AVE(GROUP,IF(h.fname_in = (TYPEOF(h.fname_in))'',0,100));
    maxlength_fname_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname_in)));
    avelength_fname_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname_in)),h.fname_in<>(typeof(h.fname_in))'');
    populated_mname_in_cnt := COUNT(GROUP,h.mname_in <> (TYPEOF(h.mname_in))'');
    populated_mname_in_pcnt := AVE(GROUP,IF(h.mname_in = (TYPEOF(h.mname_in))'',0,100));
    maxlength_mname_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname_in)));
    avelength_mname_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname_in)),h.mname_in<>(typeof(h.mname_in))'');
    populated_maiden_prior_cnt := COUNT(GROUP,h.maiden_prior <> (TYPEOF(h.maiden_prior))'');
    populated_maiden_prior_pcnt := AVE(GROUP,IF(h.maiden_prior = (TYPEOF(h.maiden_prior))'',0,100));
    maxlength_maiden_prior := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.maiden_prior)));
    avelength_maiden_prior := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.maiden_prior)),h.maiden_prior<>(typeof(h.maiden_prior))'');
    populated_name_suffix_in_cnt := COUNT(GROUP,h.name_suffix_in <> (TYPEOF(h.name_suffix_in))'');
    populated_name_suffix_in_pcnt := AVE(GROUP,IF(h.name_suffix_in = (TYPEOF(h.name_suffix_in))'',0,100));
    maxlength_name_suffix_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix_in)));
    avelength_name_suffix_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix_in)),h.name_suffix_in<>(typeof(h.name_suffix_in))'');
    populated_votefiller_cnt := COUNT(GROUP,h.votefiller <> (TYPEOF(h.votefiller))'');
    populated_votefiller_pcnt := AVE(GROUP,IF(h.votefiller = (TYPEOF(h.votefiller))'',0,100));
    maxlength_votefiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.votefiller)));
    avelength_votefiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.votefiller)),h.votefiller<>(typeof(h.votefiller))'');
    populated_source_voterid_cnt := COUNT(GROUP,h.source_voterid <> (TYPEOF(h.source_voterid))'');
    populated_source_voterid_pcnt := AVE(GROUP,IF(h.source_voterid = (TYPEOF(h.source_voterid))'',0,100));
    maxlength_source_voterid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_voterid)));
    avelength_source_voterid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_voterid)),h.source_voterid<>(typeof(h.source_voterid))'');
    populated_dob_str_in_cnt := COUNT(GROUP,h.dob_str_in <> (TYPEOF(h.dob_str_in))'');
    populated_dob_str_in_pcnt := AVE(GROUP,IF(h.dob_str_in = (TYPEOF(h.dob_str_in))'',0,100));
    maxlength_dob_str_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_str_in)));
    avelength_dob_str_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_str_in)),h.dob_str_in<>(typeof(h.dob_str_in))'');
    populated_agecat_cnt := COUNT(GROUP,h.agecat <> (TYPEOF(h.agecat))'');
    populated_agecat_pcnt := AVE(GROUP,IF(h.agecat = (TYPEOF(h.agecat))'',0,100));
    maxlength_agecat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.agecat)));
    avelength_agecat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.agecat)),h.agecat<>(typeof(h.agecat))'');
    populated_headhousehold_cnt := COUNT(GROUP,h.headhousehold <> (TYPEOF(h.headhousehold))'');
    populated_headhousehold_pcnt := AVE(GROUP,IF(h.headhousehold = (TYPEOF(h.headhousehold))'',0,100));
    maxlength_headhousehold := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.headhousehold)));
    avelength_headhousehold := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.headhousehold)),h.headhousehold<>(typeof(h.headhousehold))'');
    populated_place_of_birth_cnt := COUNT(GROUP,h.place_of_birth <> (TYPEOF(h.place_of_birth))'');
    populated_place_of_birth_pcnt := AVE(GROUP,IF(h.place_of_birth = (TYPEOF(h.place_of_birth))'',0,100));
    maxlength_place_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.place_of_birth)));
    avelength_place_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.place_of_birth)),h.place_of_birth<>(typeof(h.place_of_birth))'');
    populated_occupation_cnt := COUNT(GROUP,h.occupation <> (TYPEOF(h.occupation))'');
    populated_occupation_pcnt := AVE(GROUP,IF(h.occupation = (TYPEOF(h.occupation))'',0,100));
    maxlength_occupation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.occupation)));
    avelength_occupation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.occupation)),h.occupation<>(typeof(h.occupation))'');
    populated_maiden_name_cnt := COUNT(GROUP,h.maiden_name <> (TYPEOF(h.maiden_name))'');
    populated_maiden_name_pcnt := AVE(GROUP,IF(h.maiden_name = (TYPEOF(h.maiden_name))'',0,100));
    maxlength_maiden_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.maiden_name)));
    avelength_maiden_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.maiden_name)),h.maiden_name<>(typeof(h.maiden_name))'');
    populated_motorvoterid_cnt := COUNT(GROUP,h.motorvoterid <> (TYPEOF(h.motorvoterid))'');
    populated_motorvoterid_pcnt := AVE(GROUP,IF(h.motorvoterid = (TYPEOF(h.motorvoterid))'',0,100));
    maxlength_motorvoterid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.motorvoterid)));
    avelength_motorvoterid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.motorvoterid)),h.motorvoterid<>(typeof(h.motorvoterid))'');
    populated_regsource_cnt := COUNT(GROUP,h.regsource <> (TYPEOF(h.regsource))'');
    populated_regsource_pcnt := AVE(GROUP,IF(h.regsource = (TYPEOF(h.regsource))'',0,100));
    maxlength_regsource := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regsource)));
    avelength_regsource := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regsource)),h.regsource<>(typeof(h.regsource))'');
    populated_regdate_in_cnt := COUNT(GROUP,h.regdate_in <> (TYPEOF(h.regdate_in))'');
    populated_regdate_in_pcnt := AVE(GROUP,IF(h.regdate_in = (TYPEOF(h.regdate_in))'',0,100));
    maxlength_regdate_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate_in)));
    avelength_regdate_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate_in)),h.regdate_in<>(typeof(h.regdate_in))'');
    populated_race_cnt := COUNT(GROUP,h.race <> (TYPEOF(h.race))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_poliparty_cnt := COUNT(GROUP,h.poliparty <> (TYPEOF(h.poliparty))'');
    populated_poliparty_pcnt := AVE(GROUP,IF(h.poliparty = (TYPEOF(h.poliparty))'',0,100));
    maxlength_poliparty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.poliparty)));
    avelength_poliparty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.poliparty)),h.poliparty<>(typeof(h.poliparty))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_work_phone_cnt := COUNT(GROUP,h.work_phone <> (TYPEOF(h.work_phone))'');
    populated_work_phone_pcnt := AVE(GROUP,IF(h.work_phone = (TYPEOF(h.work_phone))'',0,100));
    maxlength_work_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.work_phone)));
    avelength_work_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.work_phone)),h.work_phone<>(typeof(h.work_phone))'');
    populated_other_phone_cnt := COUNT(GROUP,h.other_phone <> (TYPEOF(h.other_phone))'');
    populated_other_phone_pcnt := AVE(GROUP,IF(h.other_phone = (TYPEOF(h.other_phone))'',0,100));
    maxlength_other_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_phone)));
    avelength_other_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_phone)),h.other_phone<>(typeof(h.other_phone))'');
    populated_active_status_cnt := COUNT(GROUP,h.active_status <> (TYPEOF(h.active_status))'');
    populated_active_status_pcnt := AVE(GROUP,IF(h.active_status = (TYPEOF(h.active_status))'',0,100));
    maxlength_active_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_status)));
    avelength_active_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_status)),h.active_status<>(typeof(h.active_status))'');
    populated_votefiller2_cnt := COUNT(GROUP,h.votefiller2 <> (TYPEOF(h.votefiller2))'');
    populated_votefiller2_pcnt := AVE(GROUP,IF(h.votefiller2 = (TYPEOF(h.votefiller2))'',0,100));
    maxlength_votefiller2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.votefiller2)));
    avelength_votefiller2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.votefiller2)),h.votefiller2<>(typeof(h.votefiller2))'');
    populated_active_other_cnt := COUNT(GROUP,h.active_other <> (TYPEOF(h.active_other))'');
    populated_active_other_pcnt := AVE(GROUP,IF(h.active_other = (TYPEOF(h.active_other))'',0,100));
    maxlength_active_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_other)));
    avelength_active_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_other)),h.active_other<>(typeof(h.active_other))'');
    populated_voterstatus_cnt := COUNT(GROUP,h.voterstatus <> (TYPEOF(h.voterstatus))'');
    populated_voterstatus_pcnt := AVE(GROUP,IF(h.voterstatus = (TYPEOF(h.voterstatus))'',0,100));
    maxlength_voterstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.voterstatus)));
    avelength_voterstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.voterstatus)),h.voterstatus<>(typeof(h.voterstatus))'');
    populated_resaddr1_cnt := COUNT(GROUP,h.resaddr1 <> (TYPEOF(h.resaddr1))'');
    populated_resaddr1_pcnt := AVE(GROUP,IF(h.resaddr1 = (TYPEOF(h.resaddr1))'',0,100));
    maxlength_resaddr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.resaddr1)));
    avelength_resaddr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.resaddr1)),h.resaddr1<>(typeof(h.resaddr1))'');
    populated_resaddr2_cnt := COUNT(GROUP,h.resaddr2 <> (TYPEOF(h.resaddr2))'');
    populated_resaddr2_pcnt := AVE(GROUP,IF(h.resaddr2 = (TYPEOF(h.resaddr2))'',0,100));
    maxlength_resaddr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.resaddr2)));
    avelength_resaddr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.resaddr2)),h.resaddr2<>(typeof(h.resaddr2))'');
    populated_res_city_cnt := COUNT(GROUP,h.res_city <> (TYPEOF(h.res_city))'');
    populated_res_city_pcnt := AVE(GROUP,IF(h.res_city = (TYPEOF(h.res_city))'',0,100));
    maxlength_res_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_city)));
    avelength_res_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_city)),h.res_city<>(typeof(h.res_city))'');
    populated_res_state_cnt := COUNT(GROUP,h.res_state <> (TYPEOF(h.res_state))'');
    populated_res_state_pcnt := AVE(GROUP,IF(h.res_state = (TYPEOF(h.res_state))'',0,100));
    maxlength_res_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_state)));
    avelength_res_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_state)),h.res_state<>(typeof(h.res_state))'');
    populated_res_zip_cnt := COUNT(GROUP,h.res_zip <> (TYPEOF(h.res_zip))'');
    populated_res_zip_pcnt := AVE(GROUP,IF(h.res_zip = (TYPEOF(h.res_zip))'',0,100));
    maxlength_res_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_zip)));
    avelength_res_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_zip)),h.res_zip<>(typeof(h.res_zip))'');
    populated_res_county_cnt := COUNT(GROUP,h.res_county <> (TYPEOF(h.res_county))'');
    populated_res_county_pcnt := AVE(GROUP,IF(h.res_county = (TYPEOF(h.res_county))'',0,100));
    maxlength_res_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_county)));
    avelength_res_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_county)),h.res_county<>(typeof(h.res_county))'');
    populated_mail_addr1_cnt := COUNT(GROUP,h.mail_addr1 <> (TYPEOF(h.mail_addr1))'');
    populated_mail_addr1_pcnt := AVE(GROUP,IF(h.mail_addr1 = (TYPEOF(h.mail_addr1))'',0,100));
    maxlength_mail_addr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr1)));
    avelength_mail_addr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr1)),h.mail_addr1<>(typeof(h.mail_addr1))'');
    populated_mail_addr2_cnt := COUNT(GROUP,h.mail_addr2 <> (TYPEOF(h.mail_addr2))'');
    populated_mail_addr2_pcnt := AVE(GROUP,IF(h.mail_addr2 = (TYPEOF(h.mail_addr2))'',0,100));
    maxlength_mail_addr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr2)));
    avelength_mail_addr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr2)),h.mail_addr2<>(typeof(h.mail_addr2))'');
    populated_mail_city_cnt := COUNT(GROUP,h.mail_city <> (TYPEOF(h.mail_city))'');
    populated_mail_city_pcnt := AVE(GROUP,IF(h.mail_city = (TYPEOF(h.mail_city))'',0,100));
    maxlength_mail_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_city)));
    avelength_mail_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_city)),h.mail_city<>(typeof(h.mail_city))'');
    populated_mail_state_cnt := COUNT(GROUP,h.mail_state <> (TYPEOF(h.mail_state))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip_cnt := COUNT(GROUP,h.mail_zip <> (TYPEOF(h.mail_zip))'');
    populated_mail_zip_pcnt := AVE(GROUP,IF(h.mail_zip = (TYPEOF(h.mail_zip))'',0,100));
    maxlength_mail_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip)));
    avelength_mail_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip)),h.mail_zip<>(typeof(h.mail_zip))'');
    populated_mail_county_cnt := COUNT(GROUP,h.mail_county <> (TYPEOF(h.mail_county))'');
    populated_mail_county_pcnt := AVE(GROUP,IF(h.mail_county = (TYPEOF(h.mail_county))'',0,100));
    maxlength_mail_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_county)));
    avelength_mail_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_county)),h.mail_county<>(typeof(h.mail_county))'');
    populated_addr_filler1_cnt := COUNT(GROUP,h.addr_filler1 <> (TYPEOF(h.addr_filler1))'');
    populated_addr_filler1_pcnt := AVE(GROUP,IF(h.addr_filler1 = (TYPEOF(h.addr_filler1))'',0,100));
    maxlength_addr_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_filler1)));
    avelength_addr_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_filler1)),h.addr_filler1<>(typeof(h.addr_filler1))'');
    populated_addr_filler2_cnt := COUNT(GROUP,h.addr_filler2 <> (TYPEOF(h.addr_filler2))'');
    populated_addr_filler2_pcnt := AVE(GROUP,IF(h.addr_filler2 = (TYPEOF(h.addr_filler2))'',0,100));
    maxlength_addr_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_filler2)));
    avelength_addr_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_filler2)),h.addr_filler2<>(typeof(h.addr_filler2))'');
    populated_city_filler_cnt := COUNT(GROUP,h.city_filler <> (TYPEOF(h.city_filler))'');
    populated_city_filler_pcnt := AVE(GROUP,IF(h.city_filler = (TYPEOF(h.city_filler))'',0,100));
    maxlength_city_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_filler)));
    avelength_city_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_filler)),h.city_filler<>(typeof(h.city_filler))'');
    populated_state_filler_cnt := COUNT(GROUP,h.state_filler <> (TYPEOF(h.state_filler))'');
    populated_state_filler_pcnt := AVE(GROUP,IF(h.state_filler = (TYPEOF(h.state_filler))'',0,100));
    maxlength_state_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_filler)));
    avelength_state_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_filler)),h.state_filler<>(typeof(h.state_filler))'');
    populated_zip_filler_cnt := COUNT(GROUP,h.zip_filler <> (TYPEOF(h.zip_filler))'');
    populated_zip_filler_pcnt := AVE(GROUP,IF(h.zip_filler = (TYPEOF(h.zip_filler))'',0,100));
    maxlength_zip_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_filler)));
    avelength_zip_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_filler)),h.zip_filler<>(typeof(h.zip_filler))'');
    populated_county_filler_cnt := COUNT(GROUP,h.county_filler <> (TYPEOF(h.county_filler))'');
    populated_county_filler_pcnt := AVE(GROUP,IF(h.county_filler = (TYPEOF(h.county_filler))'',0,100));
    maxlength_county_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_filler)));
    avelength_county_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_filler)),h.county_filler<>(typeof(h.county_filler))'');
    populated_towncode_cnt := COUNT(GROUP,h.towncode <> (TYPEOF(h.towncode))'');
    populated_towncode_pcnt := AVE(GROUP,IF(h.towncode = (TYPEOF(h.towncode))'',0,100));
    maxlength_towncode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.towncode)));
    avelength_towncode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.towncode)),h.towncode<>(typeof(h.towncode))'');
    populated_distcode_cnt := COUNT(GROUP,h.distcode <> (TYPEOF(h.distcode))'');
    populated_distcode_pcnt := AVE(GROUP,IF(h.distcode = (TYPEOF(h.distcode))'',0,100));
    maxlength_distcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.distcode)));
    avelength_distcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.distcode)),h.distcode<>(typeof(h.distcode))'');
    populated_countycode_cnt := COUNT(GROUP,h.countycode <> (TYPEOF(h.countycode))'');
    populated_countycode_pcnt := AVE(GROUP,IF(h.countycode = (TYPEOF(h.countycode))'',0,100));
    maxlength_countycode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycode)));
    avelength_countycode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycode)),h.countycode<>(typeof(h.countycode))'');
    populated_schoolcode_cnt := COUNT(GROUP,h.schoolcode <> (TYPEOF(h.schoolcode))'');
    populated_schoolcode_pcnt := AVE(GROUP,IF(h.schoolcode = (TYPEOF(h.schoolcode))'',0,100));
    maxlength_schoolcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolcode)));
    avelength_schoolcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolcode)),h.schoolcode<>(typeof(h.schoolcode))'');
    populated_cityinout_cnt := COUNT(GROUP,h.cityinout <> (TYPEOF(h.cityinout))'');
    populated_cityinout_pcnt := AVE(GROUP,IF(h.cityinout = (TYPEOF(h.cityinout))'',0,100));
    maxlength_cityinout := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cityinout)));
    avelength_cityinout := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cityinout)),h.cityinout<>(typeof(h.cityinout))'');
    populated_spec_dist1_cnt := COUNT(GROUP,h.spec_dist1 <> (TYPEOF(h.spec_dist1))'');
    populated_spec_dist1_pcnt := AVE(GROUP,IF(h.spec_dist1 = (TYPEOF(h.spec_dist1))'',0,100));
    maxlength_spec_dist1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec_dist1)));
    avelength_spec_dist1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec_dist1)),h.spec_dist1<>(typeof(h.spec_dist1))'');
    populated_spec_dist2_cnt := COUNT(GROUP,h.spec_dist2 <> (TYPEOF(h.spec_dist2))'');
    populated_spec_dist2_pcnt := AVE(GROUP,IF(h.spec_dist2 = (TYPEOF(h.spec_dist2))'',0,100));
    maxlength_spec_dist2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec_dist2)));
    avelength_spec_dist2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spec_dist2)),h.spec_dist2<>(typeof(h.spec_dist2))'');
    populated_precinct1_cnt := COUNT(GROUP,h.precinct1 <> (TYPEOF(h.precinct1))'');
    populated_precinct1_pcnt := AVE(GROUP,IF(h.precinct1 = (TYPEOF(h.precinct1))'',0,100));
    maxlength_precinct1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct1)));
    avelength_precinct1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct1)),h.precinct1<>(typeof(h.precinct1))'');
    populated_precinct2_cnt := COUNT(GROUP,h.precinct2 <> (TYPEOF(h.precinct2))'');
    populated_precinct2_pcnt := AVE(GROUP,IF(h.precinct2 = (TYPEOF(h.precinct2))'',0,100));
    maxlength_precinct2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct2)));
    avelength_precinct2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct2)),h.precinct2<>(typeof(h.precinct2))'');
    populated_precinct3_cnt := COUNT(GROUP,h.precinct3 <> (TYPEOF(h.precinct3))'');
    populated_precinct3_pcnt := AVE(GROUP,IF(h.precinct3 = (TYPEOF(h.precinct3))'',0,100));
    maxlength_precinct3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct3)));
    avelength_precinct3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct3)),h.precinct3<>(typeof(h.precinct3))'');
    populated_villageprecinct_cnt := COUNT(GROUP,h.villageprecinct <> (TYPEOF(h.villageprecinct))'');
    populated_villageprecinct_pcnt := AVE(GROUP,IF(h.villageprecinct = (TYPEOF(h.villageprecinct))'',0,100));
    maxlength_villageprecinct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.villageprecinct)));
    avelength_villageprecinct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.villageprecinct)),h.villageprecinct<>(typeof(h.villageprecinct))'');
    populated_schoolprecinct_cnt := COUNT(GROUP,h.schoolprecinct <> (TYPEOF(h.schoolprecinct))'');
    populated_schoolprecinct_pcnt := AVE(GROUP,IF(h.schoolprecinct = (TYPEOF(h.schoolprecinct))'',0,100));
    maxlength_schoolprecinct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolprecinct)));
    avelength_schoolprecinct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolprecinct)),h.schoolprecinct<>(typeof(h.schoolprecinct))'');
    populated_ward_cnt := COUNT(GROUP,h.ward <> (TYPEOF(h.ward))'');
    populated_ward_pcnt := AVE(GROUP,IF(h.ward = (TYPEOF(h.ward))'',0,100));
    maxlength_ward := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ward)));
    avelength_ward := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ward)),h.ward<>(typeof(h.ward))'');
    populated_precinct_citytown_cnt := COUNT(GROUP,h.precinct_citytown <> (TYPEOF(h.precinct_citytown))'');
    populated_precinct_citytown_pcnt := AVE(GROUP,IF(h.precinct_citytown = (TYPEOF(h.precinct_citytown))'',0,100));
    maxlength_precinct_citytown := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct_citytown)));
    avelength_precinct_citytown := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.precinct_citytown)),h.precinct_citytown<>(typeof(h.precinct_citytown))'');
    populated_ancsmdindc_cnt := COUNT(GROUP,h.ancsmdindc <> (TYPEOF(h.ancsmdindc))'');
    populated_ancsmdindc_pcnt := AVE(GROUP,IF(h.ancsmdindc = (TYPEOF(h.ancsmdindc))'',0,100));
    maxlength_ancsmdindc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ancsmdindc)));
    avelength_ancsmdindc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ancsmdindc)),h.ancsmdindc<>(typeof(h.ancsmdindc))'');
    populated_citycouncildist_cnt := COUNT(GROUP,h.citycouncildist <> (TYPEOF(h.citycouncildist))'');
    populated_citycouncildist_pcnt := AVE(GROUP,IF(h.citycouncildist = (TYPEOF(h.citycouncildist))'',0,100));
    maxlength_citycouncildist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.citycouncildist)));
    avelength_citycouncildist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.citycouncildist)),h.citycouncildist<>(typeof(h.citycouncildist))'');
    populated_countycommdist_cnt := COUNT(GROUP,h.countycommdist <> (TYPEOF(h.countycommdist))'');
    populated_countycommdist_pcnt := AVE(GROUP,IF(h.countycommdist = (TYPEOF(h.countycommdist))'',0,100));
    maxlength_countycommdist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycommdist)));
    avelength_countycommdist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycommdist)),h.countycommdist<>(typeof(h.countycommdist))'');
    populated_statehouse_cnt := COUNT(GROUP,h.statehouse <> (TYPEOF(h.statehouse))'');
    populated_statehouse_pcnt := AVE(GROUP,IF(h.statehouse = (TYPEOF(h.statehouse))'',0,100));
    maxlength_statehouse := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statehouse)));
    avelength_statehouse := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statehouse)),h.statehouse<>(typeof(h.statehouse))'');
    populated_statesenate_cnt := COUNT(GROUP,h.statesenate <> (TYPEOF(h.statesenate))'');
    populated_statesenate_pcnt := AVE(GROUP,IF(h.statesenate = (TYPEOF(h.statesenate))'',0,100));
    maxlength_statesenate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statesenate)));
    avelength_statesenate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statesenate)),h.statesenate<>(typeof(h.statesenate))'');
    populated_ushouse_cnt := COUNT(GROUP,h.ushouse <> (TYPEOF(h.ushouse))'');
    populated_ushouse_pcnt := AVE(GROUP,IF(h.ushouse = (TYPEOF(h.ushouse))'',0,100));
    maxlength_ushouse := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ushouse)));
    avelength_ushouse := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ushouse)),h.ushouse<>(typeof(h.ushouse))'');
    populated_elemschooldist_cnt := COUNT(GROUP,h.elemschooldist <> (TYPEOF(h.elemschooldist))'');
    populated_elemschooldist_pcnt := AVE(GROUP,IF(h.elemschooldist = (TYPEOF(h.elemschooldist))'',0,100));
    maxlength_elemschooldist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.elemschooldist)));
    avelength_elemschooldist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.elemschooldist)),h.elemschooldist<>(typeof(h.elemschooldist))'');
    populated_schooldist_cnt := COUNT(GROUP,h.schooldist <> (TYPEOF(h.schooldist))'');
    populated_schooldist_pcnt := AVE(GROUP,IF(h.schooldist = (TYPEOF(h.schooldist))'',0,100));
    maxlength_schooldist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.schooldist)));
    avelength_schooldist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.schooldist)),h.schooldist<>(typeof(h.schooldist))'');
    populated_schoolfiller_cnt := COUNT(GROUP,h.schoolfiller <> (TYPEOF(h.schoolfiller))'');
    populated_schoolfiller_pcnt := AVE(GROUP,IF(h.schoolfiller = (TYPEOF(h.schoolfiller))'',0,100));
    maxlength_schoolfiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolfiller)));
    avelength_schoolfiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolfiller)),h.schoolfiller<>(typeof(h.schoolfiller))'');
    populated_commcolldist_cnt := COUNT(GROUP,h.commcolldist <> (TYPEOF(h.commcolldist))'');
    populated_commcolldist_pcnt := AVE(GROUP,IF(h.commcolldist = (TYPEOF(h.commcolldist))'',0,100));
    maxlength_commcolldist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.commcolldist)));
    avelength_commcolldist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.commcolldist)),h.commcolldist<>(typeof(h.commcolldist))'');
    populated_dist_filler_cnt := COUNT(GROUP,h.dist_filler <> (TYPEOF(h.dist_filler))'');
    populated_dist_filler_pcnt := AVE(GROUP,IF(h.dist_filler = (TYPEOF(h.dist_filler))'',0,100));
    maxlength_dist_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dist_filler)));
    avelength_dist_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dist_filler)),h.dist_filler<>(typeof(h.dist_filler))'');
    populated_municipal_cnt := COUNT(GROUP,h.municipal <> (TYPEOF(h.municipal))'');
    populated_municipal_pcnt := AVE(GROUP,IF(h.municipal = (TYPEOF(h.municipal))'',0,100));
    maxlength_municipal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.municipal)));
    avelength_municipal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.municipal)),h.municipal<>(typeof(h.municipal))'');
    populated_villagedist_cnt := COUNT(GROUP,h.villagedist <> (TYPEOF(h.villagedist))'');
    populated_villagedist_pcnt := AVE(GROUP,IF(h.villagedist = (TYPEOF(h.villagedist))'',0,100));
    maxlength_villagedist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.villagedist)));
    avelength_villagedist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.villagedist)),h.villagedist<>(typeof(h.villagedist))'');
    populated_policejury_cnt := COUNT(GROUP,h.policejury <> (TYPEOF(h.policejury))'');
    populated_policejury_pcnt := AVE(GROUP,IF(h.policejury = (TYPEOF(h.policejury))'',0,100));
    maxlength_policejury := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policejury)));
    avelength_policejury := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policejury)),h.policejury<>(typeof(h.policejury))'');
    populated_policedist_cnt := COUNT(GROUP,h.policedist <> (TYPEOF(h.policedist))'');
    populated_policedist_pcnt := AVE(GROUP,IF(h.policedist = (TYPEOF(h.policedist))'',0,100));
    maxlength_policedist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.policedist)));
    avelength_policedist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.policedist)),h.policedist<>(typeof(h.policedist))'');
    populated_publicservcomm_cnt := COUNT(GROUP,h.publicservcomm <> (TYPEOF(h.publicservcomm))'');
    populated_publicservcomm_pcnt := AVE(GROUP,IF(h.publicservcomm = (TYPEOF(h.publicservcomm))'',0,100));
    maxlength_publicservcomm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicservcomm)));
    avelength_publicservcomm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.publicservcomm)),h.publicservcomm<>(typeof(h.publicservcomm))'');
    populated_rescue_cnt := COUNT(GROUP,h.rescue <> (TYPEOF(h.rescue))'');
    populated_rescue_pcnt := AVE(GROUP,IF(h.rescue = (TYPEOF(h.rescue))'',0,100));
    maxlength_rescue := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rescue)));
    avelength_rescue := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rescue)),h.rescue<>(typeof(h.rescue))'');
    populated_fire_cnt := COUNT(GROUP,h.fire <> (TYPEOF(h.fire))'');
    populated_fire_pcnt := AVE(GROUP,IF(h.fire = (TYPEOF(h.fire))'',0,100));
    maxlength_fire := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fire)));
    avelength_fire := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fire)),h.fire<>(typeof(h.fire))'');
    populated_sanitary_cnt := COUNT(GROUP,h.sanitary <> (TYPEOF(h.sanitary))'');
    populated_sanitary_pcnt := AVE(GROUP,IF(h.sanitary = (TYPEOF(h.sanitary))'',0,100));
    maxlength_sanitary := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sanitary)));
    avelength_sanitary := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sanitary)),h.sanitary<>(typeof(h.sanitary))'');
    populated_sewerdist_cnt := COUNT(GROUP,h.sewerdist <> (TYPEOF(h.sewerdist))'');
    populated_sewerdist_pcnt := AVE(GROUP,IF(h.sewerdist = (TYPEOF(h.sewerdist))'',0,100));
    maxlength_sewerdist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sewerdist)));
    avelength_sewerdist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sewerdist)),h.sewerdist<>(typeof(h.sewerdist))'');
    populated_waterdist_cnt := COUNT(GROUP,h.waterdist <> (TYPEOF(h.waterdist))'');
    populated_waterdist_pcnt := AVE(GROUP,IF(h.waterdist = (TYPEOF(h.waterdist))'',0,100));
    maxlength_waterdist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.waterdist)));
    avelength_waterdist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.waterdist)),h.waterdist<>(typeof(h.waterdist))'');
    populated_mosquitodist_cnt := COUNT(GROUP,h.mosquitodist <> (TYPEOF(h.mosquitodist))'');
    populated_mosquitodist_pcnt := AVE(GROUP,IF(h.mosquitodist = (TYPEOF(h.mosquitodist))'',0,100));
    maxlength_mosquitodist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mosquitodist)));
    avelength_mosquitodist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mosquitodist)),h.mosquitodist<>(typeof(h.mosquitodist))'');
    populated_taxdist_cnt := COUNT(GROUP,h.taxdist <> (TYPEOF(h.taxdist))'');
    populated_taxdist_pcnt := AVE(GROUP,IF(h.taxdist = (TYPEOF(h.taxdist))'',0,100));
    maxlength_taxdist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxdist)));
    avelength_taxdist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxdist)),h.taxdist<>(typeof(h.taxdist))'');
    populated_supremecourt_cnt := COUNT(GROUP,h.supremecourt <> (TYPEOF(h.supremecourt))'');
    populated_supremecourt_pcnt := AVE(GROUP,IF(h.supremecourt = (TYPEOF(h.supremecourt))'',0,100));
    maxlength_supremecourt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.supremecourt)));
    avelength_supremecourt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.supremecourt)),h.supremecourt<>(typeof(h.supremecourt))'');
    populated_justiceofpeace_cnt := COUNT(GROUP,h.justiceofpeace <> (TYPEOF(h.justiceofpeace))'');
    populated_justiceofpeace_pcnt := AVE(GROUP,IF(h.justiceofpeace = (TYPEOF(h.justiceofpeace))'',0,100));
    maxlength_justiceofpeace := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.justiceofpeace)));
    avelength_justiceofpeace := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.justiceofpeace)),h.justiceofpeace<>(typeof(h.justiceofpeace))'');
    populated_judicialdist_cnt := COUNT(GROUP,h.judicialdist <> (TYPEOF(h.judicialdist))'');
    populated_judicialdist_pcnt := AVE(GROUP,IF(h.judicialdist = (TYPEOF(h.judicialdist))'',0,100));
    maxlength_judicialdist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.judicialdist)));
    avelength_judicialdist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.judicialdist)),h.judicialdist<>(typeof(h.judicialdist))'');
    populated_superiorctdist_cnt := COUNT(GROUP,h.superiorctdist <> (TYPEOF(h.superiorctdist))'');
    populated_superiorctdist_pcnt := AVE(GROUP,IF(h.superiorctdist = (TYPEOF(h.superiorctdist))'',0,100));
    maxlength_superiorctdist := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.superiorctdist)));
    avelength_superiorctdist := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.superiorctdist)),h.superiorctdist<>(typeof(h.superiorctdist))'');
    populated_appealsct_cnt := COUNT(GROUP,h.appealsct <> (TYPEOF(h.appealsct))'');
    populated_appealsct_pcnt := AVE(GROUP,IF(h.appealsct = (TYPEOF(h.appealsct))'',0,100));
    maxlength_appealsct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.appealsct)));
    avelength_appealsct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.appealsct)),h.appealsct<>(typeof(h.appealsct))'');
    populated_courtfiller_cnt := COUNT(GROUP,h.courtfiller <> (TYPEOF(h.courtfiller))'');
    populated_courtfiller_pcnt := AVE(GROUP,IF(h.courtfiller = (TYPEOF(h.courtfiller))'',0,100));
    maxlength_courtfiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtfiller)));
    avelength_courtfiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.courtfiller)),h.courtfiller<>(typeof(h.courtfiller))'');
    populated_contributorparty_cnt := COUNT(GROUP,h.contributorparty <> (TYPEOF(h.contributorparty))'');
    populated_contributorparty_pcnt := AVE(GROUP,IF(h.contributorparty = (TYPEOF(h.contributorparty))'',0,100));
    maxlength_contributorparty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contributorparty)));
    avelength_contributorparty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contributorparty)),h.contributorparty<>(typeof(h.contributorparty))'');
    populated_recptparty_cnt := COUNT(GROUP,h.recptparty <> (TYPEOF(h.recptparty))'');
    populated_recptparty_pcnt := AVE(GROUP,IF(h.recptparty = (TYPEOF(h.recptparty))'',0,100));
    maxlength_recptparty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recptparty)));
    avelength_recptparty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recptparty)),h.recptparty<>(typeof(h.recptparty))'');
    populated_dateofcontr_in_cnt := COUNT(GROUP,h.dateofcontr_in <> (TYPEOF(h.dateofcontr_in))'');
    populated_dateofcontr_in_pcnt := AVE(GROUP,IF(h.dateofcontr_in = (TYPEOF(h.dateofcontr_in))'',0,100));
    maxlength_dateofcontr_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofcontr_in)));
    avelength_dateofcontr_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofcontr_in)),h.dateofcontr_in<>(typeof(h.dateofcontr_in))'');
    populated_dollaramt_cnt := COUNT(GROUP,h.dollaramt <> (TYPEOF(h.dollaramt))'');
    populated_dollaramt_pcnt := AVE(GROUP,IF(h.dollaramt = (TYPEOF(h.dollaramt))'',0,100));
    maxlength_dollaramt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dollaramt)));
    avelength_dollaramt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dollaramt)),h.dollaramt<>(typeof(h.dollaramt))'');
    populated_officecontto_cnt := COUNT(GROUP,h.officecontto <> (TYPEOF(h.officecontto))'');
    populated_officecontto_pcnt := AVE(GROUP,IF(h.officecontto = (TYPEOF(h.officecontto))'',0,100));
    maxlength_officecontto := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officecontto)));
    avelength_officecontto := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officecontto)),h.officecontto<>(typeof(h.officecontto))'');
    populated_cumuldollaramt_cnt := COUNT(GROUP,h.cumuldollaramt <> (TYPEOF(h.cumuldollaramt))'');
    populated_cumuldollaramt_pcnt := AVE(GROUP,IF(h.cumuldollaramt = (TYPEOF(h.cumuldollaramt))'',0,100));
    maxlength_cumuldollaramt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cumuldollaramt)));
    avelength_cumuldollaramt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cumuldollaramt)),h.cumuldollaramt<>(typeof(h.cumuldollaramt))'');
    populated_contfiller1_cnt := COUNT(GROUP,h.contfiller1 <> (TYPEOF(h.contfiller1))'');
    populated_contfiller1_pcnt := AVE(GROUP,IF(h.contfiller1 = (TYPEOF(h.contfiller1))'',0,100));
    maxlength_contfiller1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfiller1)));
    avelength_contfiller1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfiller1)),h.contfiller1<>(typeof(h.contfiller1))'');
    populated_contfiller2_cnt := COUNT(GROUP,h.contfiller2 <> (TYPEOF(h.contfiller2))'');
    populated_contfiller2_pcnt := AVE(GROUP,IF(h.contfiller2 = (TYPEOF(h.contfiller2))'',0,100));
    maxlength_contfiller2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfiller2)));
    avelength_contfiller2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfiller2)),h.contfiller2<>(typeof(h.contfiller2))'');
    populated_conttype_cnt := COUNT(GROUP,h.conttype <> (TYPEOF(h.conttype))'');
    populated_conttype_pcnt := AVE(GROUP,IF(h.conttype = (TYPEOF(h.conttype))'',0,100));
    maxlength_conttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.conttype)));
    avelength_conttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.conttype)),h.conttype<>(typeof(h.conttype))'');
    populated_contfiller3_cnt := COUNT(GROUP,h.contfiller3 <> (TYPEOF(h.contfiller3))'');
    populated_contfiller3_pcnt := AVE(GROUP,IF(h.contfiller3 = (TYPEOF(h.contfiller3))'',0,100));
    maxlength_contfiller3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfiller3)));
    avelength_contfiller3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contfiller3)),h.contfiller3<>(typeof(h.contfiller3))'');
    populated_primary02_cnt := COUNT(GROUP,h.primary02 <> (TYPEOF(h.primary02))'');
    populated_primary02_pcnt := AVE(GROUP,IF(h.primary02 = (TYPEOF(h.primary02))'',0,100));
    maxlength_primary02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary02)));
    avelength_primary02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary02)),h.primary02<>(typeof(h.primary02))'');
    populated_special02_cnt := COUNT(GROUP,h.special02 <> (TYPEOF(h.special02))'');
    populated_special02_pcnt := AVE(GROUP,IF(h.special02 = (TYPEOF(h.special02))'',0,100));
    maxlength_special02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special02)));
    avelength_special02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special02)),h.special02<>(typeof(h.special02))'');
    populated_other02_cnt := COUNT(GROUP,h.other02 <> (TYPEOF(h.other02))'');
    populated_other02_pcnt := AVE(GROUP,IF(h.other02 = (TYPEOF(h.other02))'',0,100));
    maxlength_other02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other02)));
    avelength_other02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other02)),h.other02<>(typeof(h.other02))'');
    populated_special202_cnt := COUNT(GROUP,h.special202 <> (TYPEOF(h.special202))'');
    populated_special202_pcnt := AVE(GROUP,IF(h.special202 = (TYPEOF(h.special202))'',0,100));
    maxlength_special202 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special202)));
    avelength_special202 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special202)),h.special202<>(typeof(h.special202))'');
    populated_general02_cnt := COUNT(GROUP,h.general02 <> (TYPEOF(h.general02))'');
    populated_general02_pcnt := AVE(GROUP,IF(h.general02 = (TYPEOF(h.general02))'',0,100));
    maxlength_general02 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general02)));
    avelength_general02 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general02)),h.general02<>(typeof(h.general02))'');
    populated_primary01_cnt := COUNT(GROUP,h.primary01 <> (TYPEOF(h.primary01))'');
    populated_primary01_pcnt := AVE(GROUP,IF(h.primary01 = (TYPEOF(h.primary01))'',0,100));
    maxlength_primary01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary01)));
    avelength_primary01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary01)),h.primary01<>(typeof(h.primary01))'');
    populated_special01_cnt := COUNT(GROUP,h.special01 <> (TYPEOF(h.special01))'');
    populated_special01_pcnt := AVE(GROUP,IF(h.special01 = (TYPEOF(h.special01))'',0,100));
    maxlength_special01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special01)));
    avelength_special01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special01)),h.special01<>(typeof(h.special01))'');
    populated_other01_cnt := COUNT(GROUP,h.other01 <> (TYPEOF(h.other01))'');
    populated_other01_pcnt := AVE(GROUP,IF(h.other01 = (TYPEOF(h.other01))'',0,100));
    maxlength_other01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other01)));
    avelength_other01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other01)),h.other01<>(typeof(h.other01))'');
    populated_special201_cnt := COUNT(GROUP,h.special201 <> (TYPEOF(h.special201))'');
    populated_special201_pcnt := AVE(GROUP,IF(h.special201 = (TYPEOF(h.special201))'',0,100));
    maxlength_special201 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special201)));
    avelength_special201 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special201)),h.special201<>(typeof(h.special201))'');
    populated_general01_cnt := COUNT(GROUP,h.general01 <> (TYPEOF(h.general01))'');
    populated_general01_pcnt := AVE(GROUP,IF(h.general01 = (TYPEOF(h.general01))'',0,100));
    maxlength_general01 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general01)));
    avelength_general01 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general01)),h.general01<>(typeof(h.general01))'');
    populated_pres00_cnt := COUNT(GROUP,h.pres00 <> (TYPEOF(h.pres00))'');
    populated_pres00_pcnt := AVE(GROUP,IF(h.pres00 = (TYPEOF(h.pres00))'',0,100));
    maxlength_pres00 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pres00)));
    avelength_pres00 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pres00)),h.pres00<>(typeof(h.pres00))'');
    populated_primary00_cnt := COUNT(GROUP,h.primary00 <> (TYPEOF(h.primary00))'');
    populated_primary00_pcnt := AVE(GROUP,IF(h.primary00 = (TYPEOF(h.primary00))'',0,100));
    maxlength_primary00 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary00)));
    avelength_primary00 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary00)),h.primary00<>(typeof(h.primary00))'');
    populated_special00_cnt := COUNT(GROUP,h.special00 <> (TYPEOF(h.special00))'');
    populated_special00_pcnt := AVE(GROUP,IF(h.special00 = (TYPEOF(h.special00))'',0,100));
    maxlength_special00 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special00)));
    avelength_special00 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special00)),h.special00<>(typeof(h.special00))'');
    populated_other00_cnt := COUNT(GROUP,h.other00 <> (TYPEOF(h.other00))'');
    populated_other00_pcnt := AVE(GROUP,IF(h.other00 = (TYPEOF(h.other00))'',0,100));
    maxlength_other00 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other00)));
    avelength_other00 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other00)),h.other00<>(typeof(h.other00))'');
    populated_special200_cnt := COUNT(GROUP,h.special200 <> (TYPEOF(h.special200))'');
    populated_special200_pcnt := AVE(GROUP,IF(h.special200 = (TYPEOF(h.special200))'',0,100));
    maxlength_special200 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special200)));
    avelength_special200 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special200)),h.special200<>(typeof(h.special200))'');
    populated_general00_cnt := COUNT(GROUP,h.general00 <> (TYPEOF(h.general00))'');
    populated_general00_pcnt := AVE(GROUP,IF(h.general00 = (TYPEOF(h.general00))'',0,100));
    maxlength_general00 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general00)));
    avelength_general00 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general00)),h.general00<>(typeof(h.general00))'');
    populated_primary99_cnt := COUNT(GROUP,h.primary99 <> (TYPEOF(h.primary99))'');
    populated_primary99_pcnt := AVE(GROUP,IF(h.primary99 = (TYPEOF(h.primary99))'',0,100));
    maxlength_primary99 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary99)));
    avelength_primary99 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary99)),h.primary99<>(typeof(h.primary99))'');
    populated_special99_cnt := COUNT(GROUP,h.special99 <> (TYPEOF(h.special99))'');
    populated_special99_pcnt := AVE(GROUP,IF(h.special99 = (TYPEOF(h.special99))'',0,100));
    maxlength_special99 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special99)));
    avelength_special99 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special99)),h.special99<>(typeof(h.special99))'');
    populated_other99_cnt := COUNT(GROUP,h.other99 <> (TYPEOF(h.other99))'');
    populated_other99_pcnt := AVE(GROUP,IF(h.other99 = (TYPEOF(h.other99))'',0,100));
    maxlength_other99 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other99)));
    avelength_other99 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other99)),h.other99<>(typeof(h.other99))'');
    populated_special299_cnt := COUNT(GROUP,h.special299 <> (TYPEOF(h.special299))'');
    populated_special299_pcnt := AVE(GROUP,IF(h.special299 = (TYPEOF(h.special299))'',0,100));
    maxlength_special299 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special299)));
    avelength_special299 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special299)),h.special299<>(typeof(h.special299))'');
    populated_general99_cnt := COUNT(GROUP,h.general99 <> (TYPEOF(h.general99))'');
    populated_general99_pcnt := AVE(GROUP,IF(h.general99 = (TYPEOF(h.general99))'',0,100));
    maxlength_general99 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general99)));
    avelength_general99 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general99)),h.general99<>(typeof(h.general99))'');
    populated_primary98_cnt := COUNT(GROUP,h.primary98 <> (TYPEOF(h.primary98))'');
    populated_primary98_pcnt := AVE(GROUP,IF(h.primary98 = (TYPEOF(h.primary98))'',0,100));
    maxlength_primary98 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary98)));
    avelength_primary98 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary98)),h.primary98<>(typeof(h.primary98))'');
    populated_special98_cnt := COUNT(GROUP,h.special98 <> (TYPEOF(h.special98))'');
    populated_special98_pcnt := AVE(GROUP,IF(h.special98 = (TYPEOF(h.special98))'',0,100));
    maxlength_special98 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special98)));
    avelength_special98 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special98)),h.special98<>(typeof(h.special98))'');
    populated_other98_cnt := COUNT(GROUP,h.other98 <> (TYPEOF(h.other98))'');
    populated_other98_pcnt := AVE(GROUP,IF(h.other98 = (TYPEOF(h.other98))'',0,100));
    maxlength_other98 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other98)));
    avelength_other98 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other98)),h.other98<>(typeof(h.other98))'');
    populated_special298_cnt := COUNT(GROUP,h.special298 <> (TYPEOF(h.special298))'');
    populated_special298_pcnt := AVE(GROUP,IF(h.special298 = (TYPEOF(h.special298))'',0,100));
    maxlength_special298 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special298)));
    avelength_special298 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special298)),h.special298<>(typeof(h.special298))'');
    populated_general98_cnt := COUNT(GROUP,h.general98 <> (TYPEOF(h.general98))'');
    populated_general98_pcnt := AVE(GROUP,IF(h.general98 = (TYPEOF(h.general98))'',0,100));
    maxlength_general98 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general98)));
    avelength_general98 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general98)),h.general98<>(typeof(h.general98))'');
    populated_primary97_cnt := COUNT(GROUP,h.primary97 <> (TYPEOF(h.primary97))'');
    populated_primary97_pcnt := AVE(GROUP,IF(h.primary97 = (TYPEOF(h.primary97))'',0,100));
    maxlength_primary97 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary97)));
    avelength_primary97 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary97)),h.primary97<>(typeof(h.primary97))'');
    populated_special97_cnt := COUNT(GROUP,h.special97 <> (TYPEOF(h.special97))'');
    populated_special97_pcnt := AVE(GROUP,IF(h.special97 = (TYPEOF(h.special97))'',0,100));
    maxlength_special97 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special97)));
    avelength_special97 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special97)),h.special97<>(typeof(h.special97))'');
    populated_other97_cnt := COUNT(GROUP,h.other97 <> (TYPEOF(h.other97))'');
    populated_other97_pcnt := AVE(GROUP,IF(h.other97 = (TYPEOF(h.other97))'',0,100));
    maxlength_other97 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other97)));
    avelength_other97 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other97)),h.other97<>(typeof(h.other97))'');
    populated_special297_cnt := COUNT(GROUP,h.special297 <> (TYPEOF(h.special297))'');
    populated_special297_pcnt := AVE(GROUP,IF(h.special297 = (TYPEOF(h.special297))'',0,100));
    maxlength_special297 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special297)));
    avelength_special297 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special297)),h.special297<>(typeof(h.special297))'');
    populated_general97_cnt := COUNT(GROUP,h.general97 <> (TYPEOF(h.general97))'');
    populated_general97_pcnt := AVE(GROUP,IF(h.general97 = (TYPEOF(h.general97))'',0,100));
    maxlength_general97 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general97)));
    avelength_general97 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general97)),h.general97<>(typeof(h.general97))'');
    populated_pres96_cnt := COUNT(GROUP,h.pres96 <> (TYPEOF(h.pres96))'');
    populated_pres96_pcnt := AVE(GROUP,IF(h.pres96 = (TYPEOF(h.pres96))'',0,100));
    maxlength_pres96 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pres96)));
    avelength_pres96 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pres96)),h.pres96<>(typeof(h.pres96))'');
    populated_primary96_cnt := COUNT(GROUP,h.primary96 <> (TYPEOF(h.primary96))'');
    populated_primary96_pcnt := AVE(GROUP,IF(h.primary96 = (TYPEOF(h.primary96))'',0,100));
    maxlength_primary96 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary96)));
    avelength_primary96 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary96)),h.primary96<>(typeof(h.primary96))'');
    populated_special96_cnt := COUNT(GROUP,h.special96 <> (TYPEOF(h.special96))'');
    populated_special96_pcnt := AVE(GROUP,IF(h.special96 = (TYPEOF(h.special96))'',0,100));
    maxlength_special96 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special96)));
    avelength_special96 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special96)),h.special96<>(typeof(h.special96))'');
    populated_other96_cnt := COUNT(GROUP,h.other96 <> (TYPEOF(h.other96))'');
    populated_other96_pcnt := AVE(GROUP,IF(h.other96 = (TYPEOF(h.other96))'',0,100));
    maxlength_other96 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other96)));
    avelength_other96 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other96)),h.other96<>(typeof(h.other96))'');
    populated_special296_cnt := COUNT(GROUP,h.special296 <> (TYPEOF(h.special296))'');
    populated_special296_pcnt := AVE(GROUP,IF(h.special296 = (TYPEOF(h.special296))'',0,100));
    maxlength_special296 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.special296)));
    avelength_special296 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.special296)),h.special296<>(typeof(h.special296))'');
    populated_general96_cnt := COUNT(GROUP,h.general96 <> (TYPEOF(h.general96))'');
    populated_general96_pcnt := AVE(GROUP,IF(h.general96 = (TYPEOF(h.general96))'',0,100));
    maxlength_general96 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.general96)));
    avelength_general96 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.general96)),h.general96<>(typeof(h.general96))'');
    populated_lastdayvote_in_cnt := COUNT(GROUP,h.lastdayvote_in <> (TYPEOF(h.lastdayvote_in))'');
    populated_lastdayvote_in_pcnt := AVE(GROUP,IF(h.lastdayvote_in = (TYPEOF(h.lastdayvote_in))'',0,100));
    maxlength_lastdayvote_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdayvote_in)));
    avelength_lastdayvote_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdayvote_in)),h.lastdayvote_in<>(typeof(h.lastdayvote_in))'');
    populated_historyfiller_cnt := COUNT(GROUP,h.historyfiller <> (TYPEOF(h.historyfiller))'');
    populated_historyfiller_pcnt := AVE(GROUP,IF(h.historyfiller = (TYPEOF(h.historyfiller))'',0,100));
    maxlength_historyfiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.historyfiller)));
    avelength_historyfiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.historyfiller)),h.historyfiller<>(typeof(h.historyfiller))'');
    populated_huntfishperm_cnt := COUNT(GROUP,h.huntfishperm <> (TYPEOF(h.huntfishperm))'');
    populated_huntfishperm_pcnt := AVE(GROUP,IF(h.huntfishperm = (TYPEOF(h.huntfishperm))'',0,100));
    maxlength_huntfishperm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfishperm)));
    avelength_huntfishperm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfishperm)),h.huntfishperm<>(typeof(h.huntfishperm))'');
    populated_datelicense_in_cnt := COUNT(GROUP,h.datelicense_in <> (TYPEOF(h.datelicense_in))'');
    populated_datelicense_in_pcnt := AVE(GROUP,IF(h.datelicense_in = (TYPEOF(h.datelicense_in))'',0,100));
    maxlength_datelicense_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelicense_in)));
    avelength_datelicense_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelicense_in)),h.datelicense_in<>(typeof(h.datelicense_in))'');
    populated_homestate_cnt := COUNT(GROUP,h.homestate <> (TYPEOF(h.homestate))'');
    populated_homestate_pcnt := AVE(GROUP,IF(h.homestate = (TYPEOF(h.homestate))'',0,100));
    maxlength_homestate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestate)));
    avelength_homestate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestate)),h.homestate<>(typeof(h.homestate))'');
    populated_resident_cnt := COUNT(GROUP,h.resident <> (TYPEOF(h.resident))'');
    populated_resident_pcnt := AVE(GROUP,IF(h.resident = (TYPEOF(h.resident))'',0,100));
    maxlength_resident := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.resident)));
    avelength_resident := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.resident)),h.resident<>(typeof(h.resident))'');
    populated_nonresident_cnt := COUNT(GROUP,h.nonresident <> (TYPEOF(h.nonresident))'');
    populated_nonresident_pcnt := AVE(GROUP,IF(h.nonresident = (TYPEOF(h.nonresident))'',0,100));
    maxlength_nonresident := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nonresident)));
    avelength_nonresident := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nonresident)),h.nonresident<>(typeof(h.nonresident))'');
    populated_hunt_cnt := COUNT(GROUP,h.hunt <> (TYPEOF(h.hunt))'');
    populated_hunt_pcnt := AVE(GROUP,IF(h.hunt = (TYPEOF(h.hunt))'',0,100));
    maxlength_hunt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hunt)));
    avelength_hunt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hunt)),h.hunt<>(typeof(h.hunt))'');
    populated_fish_cnt := COUNT(GROUP,h.fish <> (TYPEOF(h.fish))'');
    populated_fish_pcnt := AVE(GROUP,IF(h.fish = (TYPEOF(h.fish))'',0,100));
    maxlength_fish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fish)));
    avelength_fish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fish)),h.fish<>(typeof(h.fish))'');
    populated_combosuper_cnt := COUNT(GROUP,h.combosuper <> (TYPEOF(h.combosuper))'');
    populated_combosuper_pcnt := AVE(GROUP,IF(h.combosuper = (TYPEOF(h.combosuper))'',0,100));
    maxlength_combosuper := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.combosuper)));
    avelength_combosuper := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.combosuper)),h.combosuper<>(typeof(h.combosuper))'');
    populated_sportsman_cnt := COUNT(GROUP,h.sportsman <> (TYPEOF(h.sportsman))'');
    populated_sportsman_pcnt := AVE(GROUP,IF(h.sportsman = (TYPEOF(h.sportsman))'',0,100));
    maxlength_sportsman := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sportsman)));
    avelength_sportsman := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sportsman)),h.sportsman<>(typeof(h.sportsman))'');
    populated_trap_cnt := COUNT(GROUP,h.trap <> (TYPEOF(h.trap))'');
    populated_trap_pcnt := AVE(GROUP,IF(h.trap = (TYPEOF(h.trap))'',0,100));
    maxlength_trap := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trap)));
    avelength_trap := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trap)),h.trap<>(typeof(h.trap))'');
    populated_archery_cnt := COUNT(GROUP,h.archery <> (TYPEOF(h.archery))'');
    populated_archery_pcnt := AVE(GROUP,IF(h.archery = (TYPEOF(h.archery))'',0,100));
    maxlength_archery := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.archery)));
    avelength_archery := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.archery)),h.archery<>(typeof(h.archery))'');
    populated_muzzle_cnt := COUNT(GROUP,h.muzzle <> (TYPEOF(h.muzzle))'');
    populated_muzzle_pcnt := AVE(GROUP,IF(h.muzzle = (TYPEOF(h.muzzle))'',0,100));
    maxlength_muzzle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.muzzle)));
    avelength_muzzle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.muzzle)),h.muzzle<>(typeof(h.muzzle))'');
    populated_drawing_cnt := COUNT(GROUP,h.drawing <> (TYPEOF(h.drawing))'');
    populated_drawing_pcnt := AVE(GROUP,IF(h.drawing = (TYPEOF(h.drawing))'',0,100));
    maxlength_drawing := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drawing)));
    avelength_drawing := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drawing)),h.drawing<>(typeof(h.drawing))'');
    populated_day1_cnt := COUNT(GROUP,h.day1 <> (TYPEOF(h.day1))'');
    populated_day1_pcnt := AVE(GROUP,IF(h.day1 = (TYPEOF(h.day1))'',0,100));
    maxlength_day1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.day1)));
    avelength_day1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.day1)),h.day1<>(typeof(h.day1))'');
    populated_day3_cnt := COUNT(GROUP,h.day3 <> (TYPEOF(h.day3))'');
    populated_day3_pcnt := AVE(GROUP,IF(h.day3 = (TYPEOF(h.day3))'',0,100));
    maxlength_day3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.day3)));
    avelength_day3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.day3)),h.day3<>(typeof(h.day3))'');
    populated_day7_cnt := COUNT(GROUP,h.day7 <> (TYPEOF(h.day7))'');
    populated_day7_pcnt := AVE(GROUP,IF(h.day7 = (TYPEOF(h.day7))'',0,100));
    maxlength_day7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.day7)));
    avelength_day7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.day7)),h.day7<>(typeof(h.day7))'');
    populated_day14to15_cnt := COUNT(GROUP,h.day14to15 <> (TYPEOF(h.day14to15))'');
    populated_day14to15_pcnt := AVE(GROUP,IF(h.day14to15 = (TYPEOF(h.day14to15))'',0,100));
    maxlength_day14to15 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.day14to15)));
    avelength_day14to15 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.day14to15)),h.day14to15<>(typeof(h.day14to15))'');
    populated_dayfiller_cnt := COUNT(GROUP,h.dayfiller <> (TYPEOF(h.dayfiller))'');
    populated_dayfiller_pcnt := AVE(GROUP,IF(h.dayfiller = (TYPEOF(h.dayfiller))'',0,100));
    maxlength_dayfiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dayfiller)));
    avelength_dayfiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dayfiller)),h.dayfiller<>(typeof(h.dayfiller))'');
    populated_seasonannual_cnt := COUNT(GROUP,h.seasonannual <> (TYPEOF(h.seasonannual))'');
    populated_seasonannual_pcnt := AVE(GROUP,IF(h.seasonannual = (TYPEOF(h.seasonannual))'',0,100));
    maxlength_seasonannual := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seasonannual)));
    avelength_seasonannual := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seasonannual)),h.seasonannual<>(typeof(h.seasonannual))'');
    populated_lifetimepermit_cnt := COUNT(GROUP,h.lifetimepermit <> (TYPEOF(h.lifetimepermit))'');
    populated_lifetimepermit_pcnt := AVE(GROUP,IF(h.lifetimepermit = (TYPEOF(h.lifetimepermit))'',0,100));
    maxlength_lifetimepermit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lifetimepermit)));
    avelength_lifetimepermit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lifetimepermit)),h.lifetimepermit<>(typeof(h.lifetimepermit))'');
    populated_landowner_cnt := COUNT(GROUP,h.landowner <> (TYPEOF(h.landowner))'');
    populated_landowner_pcnt := AVE(GROUP,IF(h.landowner = (TYPEOF(h.landowner))'',0,100));
    maxlength_landowner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.landowner)));
    avelength_landowner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.landowner)),h.landowner<>(typeof(h.landowner))'');
    populated_family_cnt := COUNT(GROUP,h.family <> (TYPEOF(h.family))'');
    populated_family_pcnt := AVE(GROUP,IF(h.family = (TYPEOF(h.family))'',0,100));
    maxlength_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.family)));
    avelength_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.family)),h.family<>(typeof(h.family))'');
    populated_junior_cnt := COUNT(GROUP,h.junior <> (TYPEOF(h.junior))'');
    populated_junior_pcnt := AVE(GROUP,IF(h.junior = (TYPEOF(h.junior))'',0,100));
    maxlength_junior := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.junior)));
    avelength_junior := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.junior)),h.junior<>(typeof(h.junior))'');
    populated_seniorcit_cnt := COUNT(GROUP,h.seniorcit <> (TYPEOF(h.seniorcit))'');
    populated_seniorcit_pcnt := AVE(GROUP,IF(h.seniorcit = (TYPEOF(h.seniorcit))'',0,100));
    maxlength_seniorcit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seniorcit)));
    avelength_seniorcit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seniorcit)),h.seniorcit<>(typeof(h.seniorcit))'');
    populated_crewmemeber_cnt := COUNT(GROUP,h.crewmemeber <> (TYPEOF(h.crewmemeber))'');
    populated_crewmemeber_pcnt := AVE(GROUP,IF(h.crewmemeber = (TYPEOF(h.crewmemeber))'',0,100));
    maxlength_crewmemeber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crewmemeber)));
    avelength_crewmemeber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crewmemeber)),h.crewmemeber<>(typeof(h.crewmemeber))'');
    populated_retarded_cnt := COUNT(GROUP,h.retarded <> (TYPEOF(h.retarded))'');
    populated_retarded_pcnt := AVE(GROUP,IF(h.retarded = (TYPEOF(h.retarded))'',0,100));
    maxlength_retarded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.retarded)));
    avelength_retarded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.retarded)),h.retarded<>(typeof(h.retarded))'');
    populated_indian_cnt := COUNT(GROUP,h.indian <> (TYPEOF(h.indian))'');
    populated_indian_pcnt := AVE(GROUP,IF(h.indian = (TYPEOF(h.indian))'',0,100));
    maxlength_indian := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.indian)));
    avelength_indian := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.indian)),h.indian<>(typeof(h.indian))'');
    populated_serviceman_cnt := COUNT(GROUP,h.serviceman <> (TYPEOF(h.serviceman))'');
    populated_serviceman_pcnt := AVE(GROUP,IF(h.serviceman = (TYPEOF(h.serviceman))'',0,100));
    maxlength_serviceman := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.serviceman)));
    avelength_serviceman := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.serviceman)),h.serviceman<>(typeof(h.serviceman))'');
    populated_disabled_cnt := COUNT(GROUP,h.disabled <> (TYPEOF(h.disabled))'');
    populated_disabled_pcnt := AVE(GROUP,IF(h.disabled = (TYPEOF(h.disabled))'',0,100));
    maxlength_disabled := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.disabled)));
    avelength_disabled := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.disabled)),h.disabled<>(typeof(h.disabled))'');
    populated_lowincome_cnt := COUNT(GROUP,h.lowincome <> (TYPEOF(h.lowincome))'');
    populated_lowincome_pcnt := AVE(GROUP,IF(h.lowincome = (TYPEOF(h.lowincome))'',0,100));
    maxlength_lowincome := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lowincome)));
    avelength_lowincome := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lowincome)),h.lowincome<>(typeof(h.lowincome))'');
    populated_regioncounty_cnt := COUNT(GROUP,h.regioncounty <> (TYPEOF(h.regioncounty))'');
    populated_regioncounty_pcnt := AVE(GROUP,IF(h.regioncounty = (TYPEOF(h.regioncounty))'',0,100));
    maxlength_regioncounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regioncounty)));
    avelength_regioncounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regioncounty)),h.regioncounty<>(typeof(h.regioncounty))'');
    populated_blind_cnt := COUNT(GROUP,h.blind <> (TYPEOF(h.blind))'');
    populated_blind_pcnt := AVE(GROUP,IF(h.blind = (TYPEOF(h.blind))'',0,100));
    maxlength_blind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.blind)));
    avelength_blind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.blind)),h.blind<>(typeof(h.blind))'');
    populated_huntfiller_cnt := COUNT(GROUP,h.huntfiller <> (TYPEOF(h.huntfiller))'');
    populated_huntfiller_pcnt := AVE(GROUP,IF(h.huntfiller = (TYPEOF(h.huntfiller))'',0,100));
    maxlength_huntfiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfiller)));
    avelength_huntfiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfiller)),h.huntfiller<>(typeof(h.huntfiller))'');
    populated_salmon_cnt := COUNT(GROUP,h.salmon <> (TYPEOF(h.salmon))'');
    populated_salmon_pcnt := AVE(GROUP,IF(h.salmon = (TYPEOF(h.salmon))'',0,100));
    maxlength_salmon := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.salmon)));
    avelength_salmon := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.salmon)),h.salmon<>(typeof(h.salmon))'');
    populated_freshwater_cnt := COUNT(GROUP,h.freshwater <> (TYPEOF(h.freshwater))'');
    populated_freshwater_pcnt := AVE(GROUP,IF(h.freshwater = (TYPEOF(h.freshwater))'',0,100));
    maxlength_freshwater := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.freshwater)));
    avelength_freshwater := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.freshwater)),h.freshwater<>(typeof(h.freshwater))'');
    populated_saltwater_cnt := COUNT(GROUP,h.saltwater <> (TYPEOF(h.saltwater))'');
    populated_saltwater_pcnt := AVE(GROUP,IF(h.saltwater = (TYPEOF(h.saltwater))'',0,100));
    maxlength_saltwater := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.saltwater)));
    avelength_saltwater := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.saltwater)),h.saltwater<>(typeof(h.saltwater))'');
    populated_lakesandresevoirs_cnt := COUNT(GROUP,h.lakesandresevoirs <> (TYPEOF(h.lakesandresevoirs))'');
    populated_lakesandresevoirs_pcnt := AVE(GROUP,IF(h.lakesandresevoirs = (TYPEOF(h.lakesandresevoirs))'',0,100));
    maxlength_lakesandresevoirs := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lakesandresevoirs)));
    avelength_lakesandresevoirs := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lakesandresevoirs)),h.lakesandresevoirs<>(typeof(h.lakesandresevoirs))'');
    populated_setlinefish_cnt := COUNT(GROUP,h.setlinefish <> (TYPEOF(h.setlinefish))'');
    populated_setlinefish_pcnt := AVE(GROUP,IF(h.setlinefish = (TYPEOF(h.setlinefish))'',0,100));
    maxlength_setlinefish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.setlinefish)));
    avelength_setlinefish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.setlinefish)),h.setlinefish<>(typeof(h.setlinefish))'');
    populated_trout_cnt := COUNT(GROUP,h.trout <> (TYPEOF(h.trout))'');
    populated_trout_pcnt := AVE(GROUP,IF(h.trout = (TYPEOF(h.trout))'',0,100));
    maxlength_trout := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trout)));
    avelength_trout := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trout)),h.trout<>(typeof(h.trout))'');
    populated_fallfishing_cnt := COUNT(GROUP,h.fallfishing <> (TYPEOF(h.fallfishing))'');
    populated_fallfishing_pcnt := AVE(GROUP,IF(h.fallfishing = (TYPEOF(h.fallfishing))'',0,100));
    maxlength_fallfishing := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fallfishing)));
    avelength_fallfishing := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fallfishing)),h.fallfishing<>(typeof(h.fallfishing))'');
    populated_steelhead_cnt := COUNT(GROUP,h.steelhead <> (TYPEOF(h.steelhead))'');
    populated_steelhead_pcnt := AVE(GROUP,IF(h.steelhead = (TYPEOF(h.steelhead))'',0,100));
    maxlength_steelhead := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.steelhead)));
    avelength_steelhead := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.steelhead)),h.steelhead<>(typeof(h.steelhead))'');
    populated_whitejubherring_cnt := COUNT(GROUP,h.whitejubherring <> (TYPEOF(h.whitejubherring))'');
    populated_whitejubherring_pcnt := AVE(GROUP,IF(h.whitejubherring = (TYPEOF(h.whitejubherring))'',0,100));
    maxlength_whitejubherring := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.whitejubherring)));
    avelength_whitejubherring := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.whitejubherring)),h.whitejubherring<>(typeof(h.whitejubherring))'');
    populated_sturgeon_cnt := COUNT(GROUP,h.sturgeon <> (TYPEOF(h.sturgeon))'');
    populated_sturgeon_pcnt := AVE(GROUP,IF(h.sturgeon = (TYPEOF(h.sturgeon))'',0,100));
    maxlength_sturgeon := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sturgeon)));
    avelength_sturgeon := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sturgeon)),h.sturgeon<>(typeof(h.sturgeon))'');
    populated_shellfishcrab_cnt := COUNT(GROUP,h.shellfishcrab <> (TYPEOF(h.shellfishcrab))'');
    populated_shellfishcrab_pcnt := AVE(GROUP,IF(h.shellfishcrab = (TYPEOF(h.shellfishcrab))'',0,100));
    maxlength_shellfishcrab := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.shellfishcrab)));
    avelength_shellfishcrab := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.shellfishcrab)),h.shellfishcrab<>(typeof(h.shellfishcrab))'');
    populated_shellfishlobster_cnt := COUNT(GROUP,h.shellfishlobster <> (TYPEOF(h.shellfishlobster))'');
    populated_shellfishlobster_pcnt := AVE(GROUP,IF(h.shellfishlobster = (TYPEOF(h.shellfishlobster))'',0,100));
    maxlength_shellfishlobster := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.shellfishlobster)));
    avelength_shellfishlobster := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.shellfishlobster)),h.shellfishlobster<>(typeof(h.shellfishlobster))'');
    populated_deer_cnt := COUNT(GROUP,h.deer <> (TYPEOF(h.deer))'');
    populated_deer_pcnt := AVE(GROUP,IF(h.deer = (TYPEOF(h.deer))'',0,100));
    maxlength_deer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deer)));
    avelength_deer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deer)),h.deer<>(typeof(h.deer))'');
    populated_bear_cnt := COUNT(GROUP,h.bear <> (TYPEOF(h.bear))'');
    populated_bear_pcnt := AVE(GROUP,IF(h.bear = (TYPEOF(h.bear))'',0,100));
    maxlength_bear := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bear)));
    avelength_bear := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bear)),h.bear<>(typeof(h.bear))'');
    populated_elk_cnt := COUNT(GROUP,h.elk <> (TYPEOF(h.elk))'');
    populated_elk_pcnt := AVE(GROUP,IF(h.elk = (TYPEOF(h.elk))'',0,100));
    maxlength_elk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.elk)));
    avelength_elk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.elk)),h.elk<>(typeof(h.elk))'');
    populated_moose_cnt := COUNT(GROUP,h.moose <> (TYPEOF(h.moose))'');
    populated_moose_pcnt := AVE(GROUP,IF(h.moose = (TYPEOF(h.moose))'',0,100));
    maxlength_moose := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.moose)));
    avelength_moose := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.moose)),h.moose<>(typeof(h.moose))'');
    populated_buffalo_cnt := COUNT(GROUP,h.buffalo <> (TYPEOF(h.buffalo))'');
    populated_buffalo_pcnt := AVE(GROUP,IF(h.buffalo = (TYPEOF(h.buffalo))'',0,100));
    maxlength_buffalo := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buffalo)));
    avelength_buffalo := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buffalo)),h.buffalo<>(typeof(h.buffalo))'');
    populated_antelope_cnt := COUNT(GROUP,h.antelope <> (TYPEOF(h.antelope))'');
    populated_antelope_pcnt := AVE(GROUP,IF(h.antelope = (TYPEOF(h.antelope))'',0,100));
    maxlength_antelope := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.antelope)));
    avelength_antelope := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.antelope)),h.antelope<>(typeof(h.antelope))'');
    populated_sikebull_cnt := COUNT(GROUP,h.sikebull <> (TYPEOF(h.sikebull))'');
    populated_sikebull_pcnt := AVE(GROUP,IF(h.sikebull = (TYPEOF(h.sikebull))'',0,100));
    maxlength_sikebull := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sikebull)));
    avelength_sikebull := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sikebull)),h.sikebull<>(typeof(h.sikebull))'');
    populated_bighorn_cnt := COUNT(GROUP,h.bighorn <> (TYPEOF(h.bighorn))'');
    populated_bighorn_pcnt := AVE(GROUP,IF(h.bighorn = (TYPEOF(h.bighorn))'',0,100));
    maxlength_bighorn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bighorn)));
    avelength_bighorn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bighorn)),h.bighorn<>(typeof(h.bighorn))'');
    populated_javelina_cnt := COUNT(GROUP,h.javelina <> (TYPEOF(h.javelina))'');
    populated_javelina_pcnt := AVE(GROUP,IF(h.javelina = (TYPEOF(h.javelina))'',0,100));
    maxlength_javelina := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.javelina)));
    avelength_javelina := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.javelina)),h.javelina<>(typeof(h.javelina))'');
    populated_cougar_cnt := COUNT(GROUP,h.cougar <> (TYPEOF(h.cougar))'');
    populated_cougar_pcnt := AVE(GROUP,IF(h.cougar = (TYPEOF(h.cougar))'',0,100));
    maxlength_cougar := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cougar)));
    avelength_cougar := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cougar)),h.cougar<>(typeof(h.cougar))'');
    populated_anterless_cnt := COUNT(GROUP,h.anterless <> (TYPEOF(h.anterless))'');
    populated_anterless_pcnt := AVE(GROUP,IF(h.anterless = (TYPEOF(h.anterless))'',0,100));
    maxlength_anterless := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.anterless)));
    avelength_anterless := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.anterless)),h.anterless<>(typeof(h.anterless))'');
    populated_pheasant_cnt := COUNT(GROUP,h.pheasant <> (TYPEOF(h.pheasant))'');
    populated_pheasant_pcnt := AVE(GROUP,IF(h.pheasant = (TYPEOF(h.pheasant))'',0,100));
    maxlength_pheasant := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pheasant)));
    avelength_pheasant := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pheasant)),h.pheasant<>(typeof(h.pheasant))'');
    populated_goose_cnt := COUNT(GROUP,h.goose <> (TYPEOF(h.goose))'');
    populated_goose_pcnt := AVE(GROUP,IF(h.goose = (TYPEOF(h.goose))'',0,100));
    maxlength_goose := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.goose)));
    avelength_goose := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.goose)),h.goose<>(typeof(h.goose))'');
    populated_duck_cnt := COUNT(GROUP,h.duck <> (TYPEOF(h.duck))'');
    populated_duck_pcnt := AVE(GROUP,IF(h.duck = (TYPEOF(h.duck))'',0,100));
    maxlength_duck := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duck)));
    avelength_duck := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duck)),h.duck<>(typeof(h.duck))'');
    populated_turkey_cnt := COUNT(GROUP,h.turkey <> (TYPEOF(h.turkey))'');
    populated_turkey_pcnt := AVE(GROUP,IF(h.turkey = (TYPEOF(h.turkey))'',0,100));
    maxlength_turkey := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.turkey)));
    avelength_turkey := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.turkey)),h.turkey<>(typeof(h.turkey))'');
    populated_snowmobile_cnt := COUNT(GROUP,h.snowmobile <> (TYPEOF(h.snowmobile))'');
    populated_snowmobile_pcnt := AVE(GROUP,IF(h.snowmobile = (TYPEOF(h.snowmobile))'',0,100));
    maxlength_snowmobile := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.snowmobile)));
    avelength_snowmobile := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.snowmobile)),h.snowmobile<>(typeof(h.snowmobile))'');
    populated_biggame_cnt := COUNT(GROUP,h.biggame <> (TYPEOF(h.biggame))'');
    populated_biggame_pcnt := AVE(GROUP,IF(h.biggame = (TYPEOF(h.biggame))'',0,100));
    maxlength_biggame := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.biggame)));
    avelength_biggame := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.biggame)),h.biggame<>(typeof(h.biggame))'');
    populated_skipass_cnt := COUNT(GROUP,h.skipass <> (TYPEOF(h.skipass))'');
    populated_skipass_pcnt := AVE(GROUP,IF(h.skipass = (TYPEOF(h.skipass))'',0,100));
    maxlength_skipass := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.skipass)));
    avelength_skipass := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.skipass)),h.skipass<>(typeof(h.skipass))'');
    populated_migbird_cnt := COUNT(GROUP,h.migbird <> (TYPEOF(h.migbird))'');
    populated_migbird_pcnt := AVE(GROUP,IF(h.migbird = (TYPEOF(h.migbird))'',0,100));
    maxlength_migbird := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.migbird)));
    avelength_migbird := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.migbird)),h.migbird<>(typeof(h.migbird))'');
    populated_smallgame_cnt := COUNT(GROUP,h.smallgame <> (TYPEOF(h.smallgame))'');
    populated_smallgame_pcnt := AVE(GROUP,IF(h.smallgame = (TYPEOF(h.smallgame))'',0,100));
    maxlength_smallgame := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.smallgame)));
    avelength_smallgame := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.smallgame)),h.smallgame<>(typeof(h.smallgame))'');
    populated_sturgeon2_cnt := COUNT(GROUP,h.sturgeon2 <> (TYPEOF(h.sturgeon2))'');
    populated_sturgeon2_pcnt := AVE(GROUP,IF(h.sturgeon2 = (TYPEOF(h.sturgeon2))'',0,100));
    maxlength_sturgeon2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sturgeon2)));
    avelength_sturgeon2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sturgeon2)),h.sturgeon2<>(typeof(h.sturgeon2))'');
    populated_gun_cnt := COUNT(GROUP,h.gun <> (TYPEOF(h.gun))'');
    populated_gun_pcnt := AVE(GROUP,IF(h.gun = (TYPEOF(h.gun))'',0,100));
    maxlength_gun := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gun)));
    avelength_gun := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gun)),h.gun<>(typeof(h.gun))'');
    populated_bonus_cnt := COUNT(GROUP,h.bonus <> (TYPEOF(h.bonus))'');
    populated_bonus_pcnt := AVE(GROUP,IF(h.bonus = (TYPEOF(h.bonus))'',0,100));
    maxlength_bonus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bonus)));
    avelength_bonus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bonus)),h.bonus<>(typeof(h.bonus))'');
    populated_lottery_cnt := COUNT(GROUP,h.lottery <> (TYPEOF(h.lottery))'');
    populated_lottery_pcnt := AVE(GROUP,IF(h.lottery = (TYPEOF(h.lottery))'',0,100));
    maxlength_lottery := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lottery)));
    avelength_lottery := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lottery)),h.lottery<>(typeof(h.lottery))'');
    populated_otherbirds_cnt := COUNT(GROUP,h.otherbirds <> (TYPEOF(h.otherbirds))'');
    populated_otherbirds_pcnt := AVE(GROUP,IF(h.otherbirds = (TYPEOF(h.otherbirds))'',0,100));
    maxlength_otherbirds := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.otherbirds)));
    avelength_otherbirds := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.otherbirds)),h.otherbirds<>(typeof(h.otherbirds))'');
    populated_huntfill1_cnt := COUNT(GROUP,h.huntfill1 <> (TYPEOF(h.huntfill1))'');
    populated_huntfill1_pcnt := AVE(GROUP,IF(h.huntfill1 = (TYPEOF(h.huntfill1))'',0,100));
    maxlength_huntfill1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfill1)));
    avelength_huntfill1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfill1)),h.huntfill1<>(typeof(h.huntfill1))'');
    populated_boatindexnum_cnt := COUNT(GROUP,h.boatindexnum <> (TYPEOF(h.boatindexnum))'');
    populated_boatindexnum_pcnt := AVE(GROUP,IF(h.boatindexnum = (TYPEOF(h.boatindexnum))'',0,100));
    maxlength_boatindexnum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatindexnum)));
    avelength_boatindexnum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatindexnum)),h.boatindexnum<>(typeof(h.boatindexnum))'');
    populated_boatcoowner_cnt := COUNT(GROUP,h.boatcoowner <> (TYPEOF(h.boatcoowner))'');
    populated_boatcoowner_pcnt := AVE(GROUP,IF(h.boatcoowner = (TYPEOF(h.boatcoowner))'',0,100));
    maxlength_boatcoowner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatcoowner)));
    avelength_boatcoowner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatcoowner)),h.boatcoowner<>(typeof(h.boatcoowner))'');
    populated_hullidnum_cnt := COUNT(GROUP,h.hullidnum <> (TYPEOF(h.hullidnum))'');
    populated_hullidnum_pcnt := AVE(GROUP,IF(h.hullidnum = (TYPEOF(h.hullidnum))'',0,100));
    maxlength_hullidnum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hullidnum)));
    avelength_hullidnum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hullidnum)),h.hullidnum<>(typeof(h.hullidnum))'');
    populated_yearmade_cnt := COUNT(GROUP,h.yearmade <> (TYPEOF(h.yearmade))'');
    populated_yearmade_pcnt := AVE(GROUP,IF(h.yearmade = (TYPEOF(h.yearmade))'',0,100));
    maxlength_yearmade := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.yearmade)));
    avelength_yearmade := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.yearmade)),h.yearmade<>(typeof(h.yearmade))'');
    populated_model_cnt := COUNT(GROUP,h.model <> (TYPEOF(h.model))'');
    populated_model_pcnt := AVE(GROUP,IF(h.model = (TYPEOF(h.model))'',0,100));
    maxlength_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)));
    avelength_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)),h.model<>(typeof(h.model))'');
    populated_manufacturer_cnt := COUNT(GROUP,h.manufacturer <> (TYPEOF(h.manufacturer))'');
    populated_manufacturer_pcnt := AVE(GROUP,IF(h.manufacturer = (TYPEOF(h.manufacturer))'',0,100));
    maxlength_manufacturer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturer)));
    avelength_manufacturer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturer)),h.manufacturer<>(typeof(h.manufacturer))'');
    populated_lengt_cnt := COUNT(GROUP,h.lengt <> (TYPEOF(h.lengt))'');
    populated_lengt_pcnt := AVE(GROUP,IF(h.lengt = (TYPEOF(h.lengt))'',0,100));
    maxlength_lengt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lengt)));
    avelength_lengt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lengt)),h.lengt<>(typeof(h.lengt))'');
    populated_hullconstruct_cnt := COUNT(GROUP,h.hullconstruct <> (TYPEOF(h.hullconstruct))'');
    populated_hullconstruct_pcnt := AVE(GROUP,IF(h.hullconstruct = (TYPEOF(h.hullconstruct))'',0,100));
    maxlength_hullconstruct := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hullconstruct)));
    avelength_hullconstruct := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hullconstruct)),h.hullconstruct<>(typeof(h.hullconstruct))'');
    populated_primuse_cnt := COUNT(GROUP,h.primuse <> (TYPEOF(h.primuse))'');
    populated_primuse_pcnt := AVE(GROUP,IF(h.primuse = (TYPEOF(h.primuse))'',0,100));
    maxlength_primuse := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primuse)));
    avelength_primuse := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primuse)),h.primuse<>(typeof(h.primuse))'');
    populated_fueltype_cnt := COUNT(GROUP,h.fueltype <> (TYPEOF(h.fueltype))'');
    populated_fueltype_pcnt := AVE(GROUP,IF(h.fueltype = (TYPEOF(h.fueltype))'',0,100));
    maxlength_fueltype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fueltype)));
    avelength_fueltype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fueltype)),h.fueltype<>(typeof(h.fueltype))'');
    populated_propulsion_cnt := COUNT(GROUP,h.propulsion <> (TYPEOF(h.propulsion))'');
    populated_propulsion_pcnt := AVE(GROUP,IF(h.propulsion = (TYPEOF(h.propulsion))'',0,100));
    maxlength_propulsion := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.propulsion)));
    avelength_propulsion := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.propulsion)),h.propulsion<>(typeof(h.propulsion))'');
    populated_modeltype_cnt := COUNT(GROUP,h.modeltype <> (TYPEOF(h.modeltype))'');
    populated_modeltype_pcnt := AVE(GROUP,IF(h.modeltype = (TYPEOF(h.modeltype))'',0,100));
    maxlength_modeltype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.modeltype)));
    avelength_modeltype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.modeltype)),h.modeltype<>(typeof(h.modeltype))'');
    populated_regexpdate_in_cnt := COUNT(GROUP,h.regexpdate_in <> (TYPEOF(h.regexpdate_in))'');
    populated_regexpdate_in_pcnt := AVE(GROUP,IF(h.regexpdate_in = (TYPEOF(h.regexpdate_in))'',0,100));
    maxlength_regexpdate_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regexpdate_in)));
    avelength_regexpdate_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regexpdate_in)),h.regexpdate_in<>(typeof(h.regexpdate_in))'');
    populated_titlenum_cnt := COUNT(GROUP,h.titlenum <> (TYPEOF(h.titlenum))'');
    populated_titlenum_pcnt := AVE(GROUP,IF(h.titlenum = (TYPEOF(h.titlenum))'',0,100));
    maxlength_titlenum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.titlenum)));
    avelength_titlenum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.titlenum)),h.titlenum<>(typeof(h.titlenum))'');
    populated_stprimuse_cnt := COUNT(GROUP,h.stprimuse <> (TYPEOF(h.stprimuse))'');
    populated_stprimuse_pcnt := AVE(GROUP,IF(h.stprimuse = (TYPEOF(h.stprimuse))'',0,100));
    maxlength_stprimuse := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stprimuse)));
    avelength_stprimuse := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stprimuse)),h.stprimuse<>(typeof(h.stprimuse))'');
    populated_titlestatus_cnt := COUNT(GROUP,h.titlestatus <> (TYPEOF(h.titlestatus))'');
    populated_titlestatus_pcnt := AVE(GROUP,IF(h.titlestatus = (TYPEOF(h.titlestatus))'',0,100));
    maxlength_titlestatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.titlestatus)));
    avelength_titlestatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.titlestatus)),h.titlestatus<>(typeof(h.titlestatus))'');
    populated_vessel_cnt := COUNT(GROUP,h.vessel <> (TYPEOF(h.vessel))'');
    populated_vessel_pcnt := AVE(GROUP,IF(h.vessel = (TYPEOF(h.vessel))'',0,100));
    maxlength_vessel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vessel)));
    avelength_vessel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vessel)),h.vessel<>(typeof(h.vessel))'');
    populated_specreg_cnt := COUNT(GROUP,h.specreg <> (TYPEOF(h.specreg))'');
    populated_specreg_pcnt := AVE(GROUP,IF(h.specreg = (TYPEOF(h.specreg))'',0,100));
    maxlength_specreg := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.specreg)));
    avelength_specreg := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.specreg)),h.specreg<>(typeof(h.specreg))'');
    populated_boatfill1_cnt := COUNT(GROUP,h.boatfill1 <> (TYPEOF(h.boatfill1))'');
    populated_boatfill1_pcnt := AVE(GROUP,IF(h.boatfill1 = (TYPEOF(h.boatfill1))'',0,100));
    maxlength_boatfill1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatfill1)));
    avelength_boatfill1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatfill1)),h.boatfill1<>(typeof(h.boatfill1))'');
    populated_boatfill2_cnt := COUNT(GROUP,h.boatfill2 <> (TYPEOF(h.boatfill2))'');
    populated_boatfill2_pcnt := AVE(GROUP,IF(h.boatfill2 = (TYPEOF(h.boatfill2))'',0,100));
    maxlength_boatfill2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatfill2)));
    avelength_boatfill2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatfill2)),h.boatfill2<>(typeof(h.boatfill2))'');
    populated_boatfill3_cnt := COUNT(GROUP,h.boatfill3 <> (TYPEOF(h.boatfill3))'');
    populated_boatfill3_pcnt := AVE(GROUP,IF(h.boatfill3 = (TYPEOF(h.boatfill3))'',0,100));
    maxlength_boatfill3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatfill3)));
    avelength_boatfill3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.boatfill3)),h.boatfill3<>(typeof(h.boatfill3))'');
    populated_ccwpermnum_cnt := COUNT(GROUP,h.ccwpermnum <> (TYPEOF(h.ccwpermnum))'');
    populated_ccwpermnum_pcnt := AVE(GROUP,IF(h.ccwpermnum = (TYPEOF(h.ccwpermnum))'',0,100));
    maxlength_ccwpermnum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwpermnum)));
    avelength_ccwpermnum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwpermnum)),h.ccwpermnum<>(typeof(h.ccwpermnum))'');
    populated_ccwweapontype_cnt := COUNT(GROUP,h.ccwweapontype <> (TYPEOF(h.ccwweapontype))'');
    populated_ccwweapontype_pcnt := AVE(GROUP,IF(h.ccwweapontype = (TYPEOF(h.ccwweapontype))'',0,100));
    maxlength_ccwweapontype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwweapontype)));
    avelength_ccwweapontype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwweapontype)),h.ccwweapontype<>(typeof(h.ccwweapontype))'');
    populated_ccwregdate_in_cnt := COUNT(GROUP,h.ccwregdate_in <> (TYPEOF(h.ccwregdate_in))'');
    populated_ccwregdate_in_pcnt := AVE(GROUP,IF(h.ccwregdate_in = (TYPEOF(h.ccwregdate_in))'',0,100));
    maxlength_ccwregdate_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwregdate_in)));
    avelength_ccwregdate_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwregdate_in)),h.ccwregdate_in<>(typeof(h.ccwregdate_in))'');
    populated_ccwexpdate_in_cnt := COUNT(GROUP,h.ccwexpdate_in <> (TYPEOF(h.ccwexpdate_in))'');
    populated_ccwexpdate_in_pcnt := AVE(GROUP,IF(h.ccwexpdate_in = (TYPEOF(h.ccwexpdate_in))'',0,100));
    maxlength_ccwexpdate_in := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwexpdate_in)));
    avelength_ccwexpdate_in := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwexpdate_in)),h.ccwexpdate_in<>(typeof(h.ccwexpdate_in))'');
    populated_ccwpermtype_cnt := COUNT(GROUP,h.ccwpermtype <> (TYPEOF(h.ccwpermtype))'');
    populated_ccwpermtype_pcnt := AVE(GROUP,IF(h.ccwpermtype = (TYPEOF(h.ccwpermtype))'',0,100));
    maxlength_ccwpermtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwpermtype)));
    avelength_ccwpermtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwpermtype)),h.ccwpermtype<>(typeof(h.ccwpermtype))'');
    populated_ccwfill1_cnt := COUNT(GROUP,h.ccwfill1 <> (TYPEOF(h.ccwfill1))'');
    populated_ccwfill1_pcnt := AVE(GROUP,IF(h.ccwfill1 = (TYPEOF(h.ccwfill1))'',0,100));
    maxlength_ccwfill1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill1)));
    avelength_ccwfill1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill1)),h.ccwfill1<>(typeof(h.ccwfill1))'');
    populated_ccwfill2_cnt := COUNT(GROUP,h.ccwfill2 <> (TYPEOF(h.ccwfill2))'');
    populated_ccwfill2_pcnt := AVE(GROUP,IF(h.ccwfill2 = (TYPEOF(h.ccwfill2))'',0,100));
    maxlength_ccwfill2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill2)));
    avelength_ccwfill2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill2)),h.ccwfill2<>(typeof(h.ccwfill2))'');
    populated_ccwfill3_cnt := COUNT(GROUP,h.ccwfill3 <> (TYPEOF(h.ccwfill3))'');
    populated_ccwfill3_pcnt := AVE(GROUP,IF(h.ccwfill3 = (TYPEOF(h.ccwfill3))'',0,100));
    maxlength_ccwfill3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill3)));
    avelength_ccwfill3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill3)),h.ccwfill3<>(typeof(h.ccwfill3))'');
    populated_ccwfill4_cnt := COUNT(GROUP,h.ccwfill4 <> (TYPEOF(h.ccwfill4))'');
    populated_ccwfill4_pcnt := AVE(GROUP,IF(h.ccwfill4 = (TYPEOF(h.ccwfill4))'',0,100));
    maxlength_ccwfill4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill4)));
    avelength_ccwfill4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwfill4)),h.ccwfill4<>(typeof(h.ccwfill4))'');
    populated_miscfill1_cnt := COUNT(GROUP,h.miscfill1 <> (TYPEOF(h.miscfill1))'');
    populated_miscfill1_pcnt := AVE(GROUP,IF(h.miscfill1 = (TYPEOF(h.miscfill1))'',0,100));
    maxlength_miscfill1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill1)));
    avelength_miscfill1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill1)),h.miscfill1<>(typeof(h.miscfill1))'');
    populated_miscfill2_cnt := COUNT(GROUP,h.miscfill2 <> (TYPEOF(h.miscfill2))'');
    populated_miscfill2_pcnt := AVE(GROUP,IF(h.miscfill2 = (TYPEOF(h.miscfill2))'',0,100));
    maxlength_miscfill2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill2)));
    avelength_miscfill2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill2)),h.miscfill2<>(typeof(h.miscfill2))'');
    populated_miscfill3_cnt := COUNT(GROUP,h.miscfill3 <> (TYPEOF(h.miscfill3))'');
    populated_miscfill3_pcnt := AVE(GROUP,IF(h.miscfill3 = (TYPEOF(h.miscfill3))'',0,100));
    maxlength_miscfill3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill3)));
    avelength_miscfill3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill3)),h.miscfill3<>(typeof(h.miscfill3))'');
    populated_miscfill4_cnt := COUNT(GROUP,h.miscfill4 <> (TYPEOF(h.miscfill4))'');
    populated_miscfill4_pcnt := AVE(GROUP,IF(h.miscfill4 = (TYPEOF(h.miscfill4))'',0,100));
    maxlength_miscfill4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill4)));
    avelength_miscfill4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill4)),h.miscfill4<>(typeof(h.miscfill4))'');
    populated_miscfill5_cnt := COUNT(GROUP,h.miscfill5 <> (TYPEOF(h.miscfill5))'');
    populated_miscfill5_pcnt := AVE(GROUP,IF(h.miscfill5 = (TYPEOF(h.miscfill5))'',0,100));
    maxlength_miscfill5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill5)));
    avelength_miscfill5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.miscfill5)),h.miscfill5<>(typeof(h.miscfill5))'');
    populated_fillerother1_cnt := COUNT(GROUP,h.fillerother1 <> (TYPEOF(h.fillerother1))'');
    populated_fillerother1_pcnt := AVE(GROUP,IF(h.fillerother1 = (TYPEOF(h.fillerother1))'',0,100));
    maxlength_fillerother1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother1)));
    avelength_fillerother1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother1)),h.fillerother1<>(typeof(h.fillerother1))'');
    populated_fillerother2_cnt := COUNT(GROUP,h.fillerother2 <> (TYPEOF(h.fillerother2))'');
    populated_fillerother2_pcnt := AVE(GROUP,IF(h.fillerother2 = (TYPEOF(h.fillerother2))'',0,100));
    maxlength_fillerother2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother2)));
    avelength_fillerother2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother2)),h.fillerother2<>(typeof(h.fillerother2))'');
    populated_fillerother3_cnt := COUNT(GROUP,h.fillerother3 <> (TYPEOF(h.fillerother3))'');
    populated_fillerother3_pcnt := AVE(GROUP,IF(h.fillerother3 = (TYPEOF(h.fillerother3))'',0,100));
    maxlength_fillerother3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother3)));
    avelength_fillerother3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother3)),h.fillerother3<>(typeof(h.fillerother3))'');
    populated_fillerother4_cnt := COUNT(GROUP,h.fillerother4 <> (TYPEOF(h.fillerother4))'');
    populated_fillerother4_pcnt := AVE(GROUP,IF(h.fillerother4 = (TYPEOF(h.fillerother4))'',0,100));
    maxlength_fillerother4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother4)));
    avelength_fillerother4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother4)),h.fillerother4<>(typeof(h.fillerother4))'');
    populated_fillerother5_cnt := COUNT(GROUP,h.fillerother5 <> (TYPEOF(h.fillerother5))'');
    populated_fillerother5_pcnt := AVE(GROUP,IF(h.fillerother5 = (TYPEOF(h.fillerother5))'',0,100));
    maxlength_fillerother5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother5)));
    avelength_fillerother5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother5)),h.fillerother5<>(typeof(h.fillerother5))'');
    populated_fillerother6_cnt := COUNT(GROUP,h.fillerother6 <> (TYPEOF(h.fillerother6))'');
    populated_fillerother6_pcnt := AVE(GROUP,IF(h.fillerother6 = (TYPEOF(h.fillerother6))'',0,100));
    maxlength_fillerother6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother6)));
    avelength_fillerother6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother6)),h.fillerother6<>(typeof(h.fillerother6))'');
    populated_fillerother7_cnt := COUNT(GROUP,h.fillerother7 <> (TYPEOF(h.fillerother7))'');
    populated_fillerother7_pcnt := AVE(GROUP,IF(h.fillerother7 = (TYPEOF(h.fillerother7))'',0,100));
    maxlength_fillerother7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother7)));
    avelength_fillerother7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother7)),h.fillerother7<>(typeof(h.fillerother7))'');
    populated_fillerother8_cnt := COUNT(GROUP,h.fillerother8 <> (TYPEOF(h.fillerother8))'');
    populated_fillerother8_pcnt := AVE(GROUP,IF(h.fillerother8 = (TYPEOF(h.fillerother8))'',0,100));
    maxlength_fillerother8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother8)));
    avelength_fillerother8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother8)),h.fillerother8<>(typeof(h.fillerother8))'');
    populated_fillerother9_cnt := COUNT(GROUP,h.fillerother9 <> (TYPEOF(h.fillerother9))'');
    populated_fillerother9_pcnt := AVE(GROUP,IF(h.fillerother9 = (TYPEOF(h.fillerother9))'',0,100));
    maxlength_fillerother9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother9)));
    avelength_fillerother9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother9)),h.fillerother9<>(typeof(h.fillerother9))'');
    populated_fillerother10_cnt := COUNT(GROUP,h.fillerother10 <> (TYPEOF(h.fillerother10))'');
    populated_fillerother10_pcnt := AVE(GROUP,IF(h.fillerother10 = (TYPEOF(h.fillerother10))'',0,100));
    maxlength_fillerother10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother10)));
    avelength_fillerother10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fillerother10)),h.fillerother10<>(typeof(h.fillerother10))'');
    populated_eor_cnt := COUNT(GROUP,h.eor <> (TYPEOF(h.eor))'');
    populated_eor_pcnt := AVE(GROUP,IF(h.eor = (TYPEOF(h.eor))'',0,100));
    maxlength_eor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.eor)));
    avelength_eor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.eor)),h.eor<>(typeof(h.eor))'');
    populated_stuff_cnt := COUNT(GROUP,h.stuff <> (TYPEOF(h.stuff))'');
    populated_stuff_pcnt := AVE(GROUP,IF(h.stuff = (TYPEOF(h.stuff))'',0,100));
    maxlength_stuff := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stuff)));
    avelength_stuff := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stuff)),h.stuff<>(typeof(h.stuff))'');
    populated_dob_str_cnt := COUNT(GROUP,h.dob_str <> (TYPEOF(h.dob_str))'');
    populated_dob_str_pcnt := AVE(GROUP,IF(h.dob_str = (TYPEOF(h.dob_str))'',0,100));
    maxlength_dob_str := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_str)));
    avelength_dob_str := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_str)),h.dob_str<>(typeof(h.dob_str))'');
    populated_regdate_cnt := COUNT(GROUP,h.regdate <> (TYPEOF(h.regdate))'');
    populated_regdate_pcnt := AVE(GROUP,IF(h.regdate = (TYPEOF(h.regdate))'',0,100));
    maxlength_regdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate)));
    avelength_regdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate)),h.regdate<>(typeof(h.regdate))'');
    populated_dateofcontr_cnt := COUNT(GROUP,h.dateofcontr <> (TYPEOF(h.dateofcontr))'');
    populated_dateofcontr_pcnt := AVE(GROUP,IF(h.dateofcontr = (TYPEOF(h.dateofcontr))'',0,100));
    maxlength_dateofcontr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofcontr)));
    avelength_dateofcontr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofcontr)),h.dateofcontr<>(typeof(h.dateofcontr))'');
    populated_lastdayvote_cnt := COUNT(GROUP,h.lastdayvote <> (TYPEOF(h.lastdayvote))'');
    populated_lastdayvote_pcnt := AVE(GROUP,IF(h.lastdayvote = (TYPEOF(h.lastdayvote))'',0,100));
    maxlength_lastdayvote := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdayvote)));
    avelength_lastdayvote := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdayvote)),h.lastdayvote<>(typeof(h.lastdayvote))'');
    populated_datelicense_cnt := COUNT(GROUP,h.datelicense <> (TYPEOF(h.datelicense))'');
    populated_datelicense_pcnt := AVE(GROUP,IF(h.datelicense = (TYPEOF(h.datelicense))'',0,100));
    maxlength_datelicense := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelicense)));
    avelength_datelicense := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelicense)),h.datelicense<>(typeof(h.datelicense))'');
    populated_regexpdate_cnt := COUNT(GROUP,h.regexpdate <> (TYPEOF(h.regexpdate))'');
    populated_regexpdate_pcnt := AVE(GROUP,IF(h.regexpdate = (TYPEOF(h.regexpdate))'',0,100));
    maxlength_regexpdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regexpdate)));
    avelength_regexpdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regexpdate)),h.regexpdate<>(typeof(h.regexpdate))'');
    populated_ccwregdate_cnt := COUNT(GROUP,h.ccwregdate <> (TYPEOF(h.ccwregdate))'');
    populated_ccwregdate_pcnt := AVE(GROUP,IF(h.ccwregdate = (TYPEOF(h.ccwregdate))'',0,100));
    maxlength_ccwregdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwregdate)));
    avelength_ccwregdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwregdate)),h.ccwregdate<>(typeof(h.ccwregdate))'');
    populated_ccwexpdate_cnt := COUNT(GROUP,h.ccwexpdate <> (TYPEOF(h.ccwexpdate))'');
    populated_ccwexpdate_pcnt := AVE(GROUP,IF(h.ccwexpdate = (TYPEOF(h.ccwexpdate))'',0,100));
    maxlength_ccwexpdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwexpdate)));
    avelength_ccwexpdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ccwexpdate)),h.ccwexpdate<>(typeof(h.ccwexpdate))'');
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
    populated_score_on_input_cnt := COUNT(GROUP,h.score_on_input <> (TYPEOF(h.score_on_input))'');
    populated_score_on_input_pcnt := AVE(GROUP,IF(h.score_on_input = (TYPEOF(h.score_on_input))'',0,100));
    maxlength_score_on_input := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.score_on_input)));
    avelength_score_on_input := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.score_on_input)),h.score_on_input<>(typeof(h.score_on_input))'');
    populated_append_prep_resaddress1_cnt := COUNT(GROUP,h.append_prep_resaddress1 <> (TYPEOF(h.append_prep_resaddress1))'');
    populated_append_prep_resaddress1_pcnt := AVE(GROUP,IF(h.append_prep_resaddress1 = (TYPEOF(h.append_prep_resaddress1))'',0,100));
    maxlength_append_prep_resaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_resaddress1)));
    avelength_append_prep_resaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_resaddress1)),h.append_prep_resaddress1<>(typeof(h.append_prep_resaddress1))'');
    populated_append_prep_resaddress2_cnt := COUNT(GROUP,h.append_prep_resaddress2 <> (TYPEOF(h.append_prep_resaddress2))'');
    populated_append_prep_resaddress2_pcnt := AVE(GROUP,IF(h.append_prep_resaddress2 = (TYPEOF(h.append_prep_resaddress2))'',0,100));
    maxlength_append_prep_resaddress2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_resaddress2)));
    avelength_append_prep_resaddress2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_resaddress2)),h.append_prep_resaddress2<>(typeof(h.append_prep_resaddress2))'');
    populated_append_resrawaid_cnt := COUNT(GROUP,h.append_resrawaid <> (TYPEOF(h.append_resrawaid))'');
    populated_append_resrawaid_pcnt := AVE(GROUP,IF(h.append_resrawaid = (TYPEOF(h.append_resrawaid))'',0,100));
    maxlength_append_resrawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_resrawaid)));
    avelength_append_resrawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_resrawaid)),h.append_resrawaid<>(typeof(h.append_resrawaid))'');
    populated_append_prep_mailaddress1_cnt := COUNT(GROUP,h.append_prep_mailaddress1 <> (TYPEOF(h.append_prep_mailaddress1))'');
    populated_append_prep_mailaddress1_pcnt := AVE(GROUP,IF(h.append_prep_mailaddress1 = (TYPEOF(h.append_prep_mailaddress1))'',0,100));
    maxlength_append_prep_mailaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_mailaddress1)));
    avelength_append_prep_mailaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_mailaddress1)),h.append_prep_mailaddress1<>(typeof(h.append_prep_mailaddress1))'');
    populated_append_prep_mailaddress2_cnt := COUNT(GROUP,h.append_prep_mailaddress2 <> (TYPEOF(h.append_prep_mailaddress2))'');
    populated_append_prep_mailaddress2_pcnt := AVE(GROUP,IF(h.append_prep_mailaddress2 = (TYPEOF(h.append_prep_mailaddress2))'',0,100));
    maxlength_append_prep_mailaddress2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_mailaddress2)));
    avelength_append_prep_mailaddress2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_mailaddress2)),h.append_prep_mailaddress2<>(typeof(h.append_prep_mailaddress2))'');
    populated_append_mailrawaid_cnt := COUNT(GROUP,h.append_mailrawaid <> (TYPEOF(h.append_mailrawaid))'');
    populated_append_mailrawaid_pcnt := AVE(GROUP,IF(h.append_mailrawaid = (TYPEOF(h.append_mailrawaid))'',0,100));
    maxlength_append_mailrawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailrawaid)));
    avelength_append_mailrawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_mailrawaid)),h.append_mailrawaid<>(typeof(h.append_mailrawaid))'');
    populated_append_prep_cassaddress1_cnt := COUNT(GROUP,h.append_prep_cassaddress1 <> (TYPEOF(h.append_prep_cassaddress1))'');
    populated_append_prep_cassaddress1_pcnt := AVE(GROUP,IF(h.append_prep_cassaddress1 = (TYPEOF(h.append_prep_cassaddress1))'',0,100));
    maxlength_append_prep_cassaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_cassaddress1)));
    avelength_append_prep_cassaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_cassaddress1)),h.append_prep_cassaddress1<>(typeof(h.append_prep_cassaddress1))'');
    populated_append_prep_cassaddress2_cnt := COUNT(GROUP,h.append_prep_cassaddress2 <> (TYPEOF(h.append_prep_cassaddress2))'');
    populated_append_prep_cassaddress2_pcnt := AVE(GROUP,IF(h.append_prep_cassaddress2 = (TYPEOF(h.append_prep_cassaddress2))'',0,100));
    maxlength_append_prep_cassaddress2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_cassaddress2)));
    avelength_append_prep_cassaddress2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prep_cassaddress2)),h.append_prep_cassaddress2<>(typeof(h.append_prep_cassaddress2))'');
    populated_append_cassrawaid_cnt := COUNT(GROUP,h.append_cassrawaid <> (TYPEOF(h.append_cassrawaid))'');
    populated_append_cassrawaid_pcnt := AVE(GROUP,IF(h.append_cassrawaid = (TYPEOF(h.append_cassrawaid))'',0,100));
    maxlength_append_cassrawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_cassrawaid)));
    avelength_append_cassrawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_cassrawaid)),h.append_cassrawaid<>(typeof(h.append_cassrawaid))'');
    populated_aid_resclean_prim_range_cnt := COUNT(GROUP,h.aid_resclean_prim_range <> (TYPEOF(h.aid_resclean_prim_range))'');
    populated_aid_resclean_prim_range_pcnt := AVE(GROUP,IF(h.aid_resclean_prim_range = (TYPEOF(h.aid_resclean_prim_range))'',0,100));
    maxlength_aid_resclean_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_prim_range)));
    avelength_aid_resclean_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_prim_range)),h.aid_resclean_prim_range<>(typeof(h.aid_resclean_prim_range))'');
    populated_aid_resclean_predir_cnt := COUNT(GROUP,h.aid_resclean_predir <> (TYPEOF(h.aid_resclean_predir))'');
    populated_aid_resclean_predir_pcnt := AVE(GROUP,IF(h.aid_resclean_predir = (TYPEOF(h.aid_resclean_predir))'',0,100));
    maxlength_aid_resclean_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_predir)));
    avelength_aid_resclean_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_predir)),h.aid_resclean_predir<>(typeof(h.aid_resclean_predir))'');
    populated_aid_resclean_prim_name_cnt := COUNT(GROUP,h.aid_resclean_prim_name <> (TYPEOF(h.aid_resclean_prim_name))'');
    populated_aid_resclean_prim_name_pcnt := AVE(GROUP,IF(h.aid_resclean_prim_name = (TYPEOF(h.aid_resclean_prim_name))'',0,100));
    maxlength_aid_resclean_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_prim_name)));
    avelength_aid_resclean_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_prim_name)),h.aid_resclean_prim_name<>(typeof(h.aid_resclean_prim_name))'');
    populated_aid_resclean_addr_suffix_cnt := COUNT(GROUP,h.aid_resclean_addr_suffix <> (TYPEOF(h.aid_resclean_addr_suffix))'');
    populated_aid_resclean_addr_suffix_pcnt := AVE(GROUP,IF(h.aid_resclean_addr_suffix = (TYPEOF(h.aid_resclean_addr_suffix))'',0,100));
    maxlength_aid_resclean_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_addr_suffix)));
    avelength_aid_resclean_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_addr_suffix)),h.aid_resclean_addr_suffix<>(typeof(h.aid_resclean_addr_suffix))'');
    populated_aid_resclean_postdir_cnt := COUNT(GROUP,h.aid_resclean_postdir <> (TYPEOF(h.aid_resclean_postdir))'');
    populated_aid_resclean_postdir_pcnt := AVE(GROUP,IF(h.aid_resclean_postdir = (TYPEOF(h.aid_resclean_postdir))'',0,100));
    maxlength_aid_resclean_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_postdir)));
    avelength_aid_resclean_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_postdir)),h.aid_resclean_postdir<>(typeof(h.aid_resclean_postdir))'');
    populated_aid_resclean_unit_desig_cnt := COUNT(GROUP,h.aid_resclean_unit_desig <> (TYPEOF(h.aid_resclean_unit_desig))'');
    populated_aid_resclean_unit_desig_pcnt := AVE(GROUP,IF(h.aid_resclean_unit_desig = (TYPEOF(h.aid_resclean_unit_desig))'',0,100));
    maxlength_aid_resclean_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_unit_desig)));
    avelength_aid_resclean_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_unit_desig)),h.aid_resclean_unit_desig<>(typeof(h.aid_resclean_unit_desig))'');
    populated_aid_resclean_sec_range_cnt := COUNT(GROUP,h.aid_resclean_sec_range <> (TYPEOF(h.aid_resclean_sec_range))'');
    populated_aid_resclean_sec_range_pcnt := AVE(GROUP,IF(h.aid_resclean_sec_range = (TYPEOF(h.aid_resclean_sec_range))'',0,100));
    maxlength_aid_resclean_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_sec_range)));
    avelength_aid_resclean_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_sec_range)),h.aid_resclean_sec_range<>(typeof(h.aid_resclean_sec_range))'');
    populated_aid_resclean_p_city_name_cnt := COUNT(GROUP,h.aid_resclean_p_city_name <> (TYPEOF(h.aid_resclean_p_city_name))'');
    populated_aid_resclean_p_city_name_pcnt := AVE(GROUP,IF(h.aid_resclean_p_city_name = (TYPEOF(h.aid_resclean_p_city_name))'',0,100));
    maxlength_aid_resclean_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_p_city_name)));
    avelength_aid_resclean_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_p_city_name)),h.aid_resclean_p_city_name<>(typeof(h.aid_resclean_p_city_name))'');
    populated_aid_resclean_v_city_name_cnt := COUNT(GROUP,h.aid_resclean_v_city_name <> (TYPEOF(h.aid_resclean_v_city_name))'');
    populated_aid_resclean_v_city_name_pcnt := AVE(GROUP,IF(h.aid_resclean_v_city_name = (TYPEOF(h.aid_resclean_v_city_name))'',0,100));
    maxlength_aid_resclean_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_v_city_name)));
    avelength_aid_resclean_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_v_city_name)),h.aid_resclean_v_city_name<>(typeof(h.aid_resclean_v_city_name))'');
    populated_aid_resclean_st_cnt := COUNT(GROUP,h.aid_resclean_st <> (TYPEOF(h.aid_resclean_st))'');
    populated_aid_resclean_st_pcnt := AVE(GROUP,IF(h.aid_resclean_st = (TYPEOF(h.aid_resclean_st))'',0,100));
    maxlength_aid_resclean_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_st)));
    avelength_aid_resclean_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_st)),h.aid_resclean_st<>(typeof(h.aid_resclean_st))'');
    populated_aid_resclean_zip_cnt := COUNT(GROUP,h.aid_resclean_zip <> (TYPEOF(h.aid_resclean_zip))'');
    populated_aid_resclean_zip_pcnt := AVE(GROUP,IF(h.aid_resclean_zip = (TYPEOF(h.aid_resclean_zip))'',0,100));
    maxlength_aid_resclean_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_zip)));
    avelength_aid_resclean_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_zip)),h.aid_resclean_zip<>(typeof(h.aid_resclean_zip))'');
    populated_aid_resclean_zip4_cnt := COUNT(GROUP,h.aid_resclean_zip4 <> (TYPEOF(h.aid_resclean_zip4))'');
    populated_aid_resclean_zip4_pcnt := AVE(GROUP,IF(h.aid_resclean_zip4 = (TYPEOF(h.aid_resclean_zip4))'',0,100));
    maxlength_aid_resclean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_zip4)));
    avelength_aid_resclean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_zip4)),h.aid_resclean_zip4<>(typeof(h.aid_resclean_zip4))'');
    populated_aid_resclean_cart_cnt := COUNT(GROUP,h.aid_resclean_cart <> (TYPEOF(h.aid_resclean_cart))'');
    populated_aid_resclean_cart_pcnt := AVE(GROUP,IF(h.aid_resclean_cart = (TYPEOF(h.aid_resclean_cart))'',0,100));
    maxlength_aid_resclean_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_cart)));
    avelength_aid_resclean_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_cart)),h.aid_resclean_cart<>(typeof(h.aid_resclean_cart))'');
    populated_aid_resclean_cr_sort_sz_cnt := COUNT(GROUP,h.aid_resclean_cr_sort_sz <> (TYPEOF(h.aid_resclean_cr_sort_sz))'');
    populated_aid_resclean_cr_sort_sz_pcnt := AVE(GROUP,IF(h.aid_resclean_cr_sort_sz = (TYPEOF(h.aid_resclean_cr_sort_sz))'',0,100));
    maxlength_aid_resclean_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_cr_sort_sz)));
    avelength_aid_resclean_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_cr_sort_sz)),h.aid_resclean_cr_sort_sz<>(typeof(h.aid_resclean_cr_sort_sz))'');
    populated_aid_resclean_lot_cnt := COUNT(GROUP,h.aid_resclean_lot <> (TYPEOF(h.aid_resclean_lot))'');
    populated_aid_resclean_lot_pcnt := AVE(GROUP,IF(h.aid_resclean_lot = (TYPEOF(h.aid_resclean_lot))'',0,100));
    maxlength_aid_resclean_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_lot)));
    avelength_aid_resclean_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_lot)),h.aid_resclean_lot<>(typeof(h.aid_resclean_lot))'');
    populated_aid_resclean_lot_order_cnt := COUNT(GROUP,h.aid_resclean_lot_order <> (TYPEOF(h.aid_resclean_lot_order))'');
    populated_aid_resclean_lot_order_pcnt := AVE(GROUP,IF(h.aid_resclean_lot_order = (TYPEOF(h.aid_resclean_lot_order))'',0,100));
    maxlength_aid_resclean_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_lot_order)));
    avelength_aid_resclean_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_lot_order)),h.aid_resclean_lot_order<>(typeof(h.aid_resclean_lot_order))'');
    populated_aid_resclean_dpbc_cnt := COUNT(GROUP,h.aid_resclean_dpbc <> (TYPEOF(h.aid_resclean_dpbc))'');
    populated_aid_resclean_dpbc_pcnt := AVE(GROUP,IF(h.aid_resclean_dpbc = (TYPEOF(h.aid_resclean_dpbc))'',0,100));
    maxlength_aid_resclean_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_dpbc)));
    avelength_aid_resclean_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_dpbc)),h.aid_resclean_dpbc<>(typeof(h.aid_resclean_dpbc))'');
    populated_aid_resclean_chk_digit_cnt := COUNT(GROUP,h.aid_resclean_chk_digit <> (TYPEOF(h.aid_resclean_chk_digit))'');
    populated_aid_resclean_chk_digit_pcnt := AVE(GROUP,IF(h.aid_resclean_chk_digit = (TYPEOF(h.aid_resclean_chk_digit))'',0,100));
    maxlength_aid_resclean_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_chk_digit)));
    avelength_aid_resclean_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_chk_digit)),h.aid_resclean_chk_digit<>(typeof(h.aid_resclean_chk_digit))'');
    populated_aid_resclean_record_type_cnt := COUNT(GROUP,h.aid_resclean_record_type <> (TYPEOF(h.aid_resclean_record_type))'');
    populated_aid_resclean_record_type_pcnt := AVE(GROUP,IF(h.aid_resclean_record_type = (TYPEOF(h.aid_resclean_record_type))'',0,100));
    maxlength_aid_resclean_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_record_type)));
    avelength_aid_resclean_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_record_type)),h.aid_resclean_record_type<>(typeof(h.aid_resclean_record_type))'');
    populated_aid_resclean_ace_fips_st_cnt := COUNT(GROUP,h.aid_resclean_ace_fips_st <> (TYPEOF(h.aid_resclean_ace_fips_st))'');
    populated_aid_resclean_ace_fips_st_pcnt := AVE(GROUP,IF(h.aid_resclean_ace_fips_st = (TYPEOF(h.aid_resclean_ace_fips_st))'',0,100));
    maxlength_aid_resclean_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_ace_fips_st)));
    avelength_aid_resclean_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_ace_fips_st)),h.aid_resclean_ace_fips_st<>(typeof(h.aid_resclean_ace_fips_st))'');
    populated_aid_resclean_fipscounty_cnt := COUNT(GROUP,h.aid_resclean_fipscounty <> (TYPEOF(h.aid_resclean_fipscounty))'');
    populated_aid_resclean_fipscounty_pcnt := AVE(GROUP,IF(h.aid_resclean_fipscounty = (TYPEOF(h.aid_resclean_fipscounty))'',0,100));
    maxlength_aid_resclean_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_fipscounty)));
    avelength_aid_resclean_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_fipscounty)),h.aid_resclean_fipscounty<>(typeof(h.aid_resclean_fipscounty))'');
    populated_aid_resclean_geo_lat_cnt := COUNT(GROUP,h.aid_resclean_geo_lat <> (TYPEOF(h.aid_resclean_geo_lat))'');
    populated_aid_resclean_geo_lat_pcnt := AVE(GROUP,IF(h.aid_resclean_geo_lat = (TYPEOF(h.aid_resclean_geo_lat))'',0,100));
    maxlength_aid_resclean_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_lat)));
    avelength_aid_resclean_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_lat)),h.aid_resclean_geo_lat<>(typeof(h.aid_resclean_geo_lat))'');
    populated_aid_resclean_geo_long_cnt := COUNT(GROUP,h.aid_resclean_geo_long <> (TYPEOF(h.aid_resclean_geo_long))'');
    populated_aid_resclean_geo_long_pcnt := AVE(GROUP,IF(h.aid_resclean_geo_long = (TYPEOF(h.aid_resclean_geo_long))'',0,100));
    maxlength_aid_resclean_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_long)));
    avelength_aid_resclean_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_long)),h.aid_resclean_geo_long<>(typeof(h.aid_resclean_geo_long))'');
    populated_aid_resclean_msa_cnt := COUNT(GROUP,h.aid_resclean_msa <> (TYPEOF(h.aid_resclean_msa))'');
    populated_aid_resclean_msa_pcnt := AVE(GROUP,IF(h.aid_resclean_msa = (TYPEOF(h.aid_resclean_msa))'',0,100));
    maxlength_aid_resclean_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_msa)));
    avelength_aid_resclean_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_msa)),h.aid_resclean_msa<>(typeof(h.aid_resclean_msa))'');
    populated_aid_resclean_geo_blk_cnt := COUNT(GROUP,h.aid_resclean_geo_blk <> (TYPEOF(h.aid_resclean_geo_blk))'');
    populated_aid_resclean_geo_blk_pcnt := AVE(GROUP,IF(h.aid_resclean_geo_blk = (TYPEOF(h.aid_resclean_geo_blk))'',0,100));
    maxlength_aid_resclean_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_blk)));
    avelength_aid_resclean_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_blk)),h.aid_resclean_geo_blk<>(typeof(h.aid_resclean_geo_blk))'');
    populated_aid_resclean_geo_match_cnt := COUNT(GROUP,h.aid_resclean_geo_match <> (TYPEOF(h.aid_resclean_geo_match))'');
    populated_aid_resclean_geo_match_pcnt := AVE(GROUP,IF(h.aid_resclean_geo_match = (TYPEOF(h.aid_resclean_geo_match))'',0,100));
    maxlength_aid_resclean_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_match)));
    avelength_aid_resclean_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_geo_match)),h.aid_resclean_geo_match<>(typeof(h.aid_resclean_geo_match))'');
    populated_aid_resclean_err_stat_cnt := COUNT(GROUP,h.aid_resclean_err_stat <> (TYPEOF(h.aid_resclean_err_stat))'');
    populated_aid_resclean_err_stat_pcnt := AVE(GROUP,IF(h.aid_resclean_err_stat = (TYPEOF(h.aid_resclean_err_stat))'',0,100));
    maxlength_aid_resclean_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_err_stat)));
    avelength_aid_resclean_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_resclean_err_stat)),h.aid_resclean_err_stat<>(typeof(h.aid_resclean_err_stat))'');
    populated_aid_mailclean_prim_range_cnt := COUNT(GROUP,h.aid_mailclean_prim_range <> (TYPEOF(h.aid_mailclean_prim_range))'');
    populated_aid_mailclean_prim_range_pcnt := AVE(GROUP,IF(h.aid_mailclean_prim_range = (TYPEOF(h.aid_mailclean_prim_range))'',0,100));
    maxlength_aid_mailclean_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_prim_range)));
    avelength_aid_mailclean_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_prim_range)),h.aid_mailclean_prim_range<>(typeof(h.aid_mailclean_prim_range))'');
    populated_aid_mailclean_predir_cnt := COUNT(GROUP,h.aid_mailclean_predir <> (TYPEOF(h.aid_mailclean_predir))'');
    populated_aid_mailclean_predir_pcnt := AVE(GROUP,IF(h.aid_mailclean_predir = (TYPEOF(h.aid_mailclean_predir))'',0,100));
    maxlength_aid_mailclean_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_predir)));
    avelength_aid_mailclean_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_predir)),h.aid_mailclean_predir<>(typeof(h.aid_mailclean_predir))'');
    populated_aid_mailclean_prim_name_cnt := COUNT(GROUP,h.aid_mailclean_prim_name <> (TYPEOF(h.aid_mailclean_prim_name))'');
    populated_aid_mailclean_prim_name_pcnt := AVE(GROUP,IF(h.aid_mailclean_prim_name = (TYPEOF(h.aid_mailclean_prim_name))'',0,100));
    maxlength_aid_mailclean_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_prim_name)));
    avelength_aid_mailclean_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_prim_name)),h.aid_mailclean_prim_name<>(typeof(h.aid_mailclean_prim_name))'');
    populated_aid_mailclean_addr_suffix_cnt := COUNT(GROUP,h.aid_mailclean_addr_suffix <> (TYPEOF(h.aid_mailclean_addr_suffix))'');
    populated_aid_mailclean_addr_suffix_pcnt := AVE(GROUP,IF(h.aid_mailclean_addr_suffix = (TYPEOF(h.aid_mailclean_addr_suffix))'',0,100));
    maxlength_aid_mailclean_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_addr_suffix)));
    avelength_aid_mailclean_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_addr_suffix)),h.aid_mailclean_addr_suffix<>(typeof(h.aid_mailclean_addr_suffix))'');
    populated_aid_mailclean_postdir_cnt := COUNT(GROUP,h.aid_mailclean_postdir <> (TYPEOF(h.aid_mailclean_postdir))'');
    populated_aid_mailclean_postdir_pcnt := AVE(GROUP,IF(h.aid_mailclean_postdir = (TYPEOF(h.aid_mailclean_postdir))'',0,100));
    maxlength_aid_mailclean_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_postdir)));
    avelength_aid_mailclean_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_postdir)),h.aid_mailclean_postdir<>(typeof(h.aid_mailclean_postdir))'');
    populated_aid_mailclean_unit_desig_cnt := COUNT(GROUP,h.aid_mailclean_unit_desig <> (TYPEOF(h.aid_mailclean_unit_desig))'');
    populated_aid_mailclean_unit_desig_pcnt := AVE(GROUP,IF(h.aid_mailclean_unit_desig = (TYPEOF(h.aid_mailclean_unit_desig))'',0,100));
    maxlength_aid_mailclean_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_unit_desig)));
    avelength_aid_mailclean_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_unit_desig)),h.aid_mailclean_unit_desig<>(typeof(h.aid_mailclean_unit_desig))'');
    populated_aid_mailclean_sec_range_cnt := COUNT(GROUP,h.aid_mailclean_sec_range <> (TYPEOF(h.aid_mailclean_sec_range))'');
    populated_aid_mailclean_sec_range_pcnt := AVE(GROUP,IF(h.aid_mailclean_sec_range = (TYPEOF(h.aid_mailclean_sec_range))'',0,100));
    maxlength_aid_mailclean_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_sec_range)));
    avelength_aid_mailclean_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_sec_range)),h.aid_mailclean_sec_range<>(typeof(h.aid_mailclean_sec_range))'');
    populated_aid_mailclean_p_city_name_cnt := COUNT(GROUP,h.aid_mailclean_p_city_name <> (TYPEOF(h.aid_mailclean_p_city_name))'');
    populated_aid_mailclean_p_city_name_pcnt := AVE(GROUP,IF(h.aid_mailclean_p_city_name = (TYPEOF(h.aid_mailclean_p_city_name))'',0,100));
    maxlength_aid_mailclean_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_p_city_name)));
    avelength_aid_mailclean_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_p_city_name)),h.aid_mailclean_p_city_name<>(typeof(h.aid_mailclean_p_city_name))'');
    populated_aid_mailclean_v_city_name_cnt := COUNT(GROUP,h.aid_mailclean_v_city_name <> (TYPEOF(h.aid_mailclean_v_city_name))'');
    populated_aid_mailclean_v_city_name_pcnt := AVE(GROUP,IF(h.aid_mailclean_v_city_name = (TYPEOF(h.aid_mailclean_v_city_name))'',0,100));
    maxlength_aid_mailclean_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_v_city_name)));
    avelength_aid_mailclean_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_v_city_name)),h.aid_mailclean_v_city_name<>(typeof(h.aid_mailclean_v_city_name))'');
    populated_aid_mailclean_st_cnt := COUNT(GROUP,h.aid_mailclean_st <> (TYPEOF(h.aid_mailclean_st))'');
    populated_aid_mailclean_st_pcnt := AVE(GROUP,IF(h.aid_mailclean_st = (TYPEOF(h.aid_mailclean_st))'',0,100));
    maxlength_aid_mailclean_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_st)));
    avelength_aid_mailclean_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_st)),h.aid_mailclean_st<>(typeof(h.aid_mailclean_st))'');
    populated_aid_mailclean_zip_cnt := COUNT(GROUP,h.aid_mailclean_zip <> (TYPEOF(h.aid_mailclean_zip))'');
    populated_aid_mailclean_zip_pcnt := AVE(GROUP,IF(h.aid_mailclean_zip = (TYPEOF(h.aid_mailclean_zip))'',0,100));
    maxlength_aid_mailclean_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_zip)));
    avelength_aid_mailclean_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_zip)),h.aid_mailclean_zip<>(typeof(h.aid_mailclean_zip))'');
    populated_aid_mailclean_zip4_cnt := COUNT(GROUP,h.aid_mailclean_zip4 <> (TYPEOF(h.aid_mailclean_zip4))'');
    populated_aid_mailclean_zip4_pcnt := AVE(GROUP,IF(h.aid_mailclean_zip4 = (TYPEOF(h.aid_mailclean_zip4))'',0,100));
    maxlength_aid_mailclean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_zip4)));
    avelength_aid_mailclean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_zip4)),h.aid_mailclean_zip4<>(typeof(h.aid_mailclean_zip4))'');
    populated_aid_mailclean_cart_cnt := COUNT(GROUP,h.aid_mailclean_cart <> (TYPEOF(h.aid_mailclean_cart))'');
    populated_aid_mailclean_cart_pcnt := AVE(GROUP,IF(h.aid_mailclean_cart = (TYPEOF(h.aid_mailclean_cart))'',0,100));
    maxlength_aid_mailclean_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_cart)));
    avelength_aid_mailclean_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_cart)),h.aid_mailclean_cart<>(typeof(h.aid_mailclean_cart))'');
    populated_aid_mailclean_cr_sort_sz_cnt := COUNT(GROUP,h.aid_mailclean_cr_sort_sz <> (TYPEOF(h.aid_mailclean_cr_sort_sz))'');
    populated_aid_mailclean_cr_sort_sz_pcnt := AVE(GROUP,IF(h.aid_mailclean_cr_sort_sz = (TYPEOF(h.aid_mailclean_cr_sort_sz))'',0,100));
    maxlength_aid_mailclean_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_cr_sort_sz)));
    avelength_aid_mailclean_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_cr_sort_sz)),h.aid_mailclean_cr_sort_sz<>(typeof(h.aid_mailclean_cr_sort_sz))'');
    populated_aid_mailclean_lot_cnt := COUNT(GROUP,h.aid_mailclean_lot <> (TYPEOF(h.aid_mailclean_lot))'');
    populated_aid_mailclean_lot_pcnt := AVE(GROUP,IF(h.aid_mailclean_lot = (TYPEOF(h.aid_mailclean_lot))'',0,100));
    maxlength_aid_mailclean_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_lot)));
    avelength_aid_mailclean_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_lot)),h.aid_mailclean_lot<>(typeof(h.aid_mailclean_lot))'');
    populated_aid_mailclean_lot_order_cnt := COUNT(GROUP,h.aid_mailclean_lot_order <> (TYPEOF(h.aid_mailclean_lot_order))'');
    populated_aid_mailclean_lot_order_pcnt := AVE(GROUP,IF(h.aid_mailclean_lot_order = (TYPEOF(h.aid_mailclean_lot_order))'',0,100));
    maxlength_aid_mailclean_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_lot_order)));
    avelength_aid_mailclean_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_lot_order)),h.aid_mailclean_lot_order<>(typeof(h.aid_mailclean_lot_order))'');
    populated_aid_mailclean_dpbc_cnt := COUNT(GROUP,h.aid_mailclean_dpbc <> (TYPEOF(h.aid_mailclean_dpbc))'');
    populated_aid_mailclean_dpbc_pcnt := AVE(GROUP,IF(h.aid_mailclean_dpbc = (TYPEOF(h.aid_mailclean_dpbc))'',0,100));
    maxlength_aid_mailclean_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_dpbc)));
    avelength_aid_mailclean_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_dpbc)),h.aid_mailclean_dpbc<>(typeof(h.aid_mailclean_dpbc))'');
    populated_aid_mailclean_chk_digit_cnt := COUNT(GROUP,h.aid_mailclean_chk_digit <> (TYPEOF(h.aid_mailclean_chk_digit))'');
    populated_aid_mailclean_chk_digit_pcnt := AVE(GROUP,IF(h.aid_mailclean_chk_digit = (TYPEOF(h.aid_mailclean_chk_digit))'',0,100));
    maxlength_aid_mailclean_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_chk_digit)));
    avelength_aid_mailclean_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_chk_digit)),h.aid_mailclean_chk_digit<>(typeof(h.aid_mailclean_chk_digit))'');
    populated_aid_mailclean_record_type_cnt := COUNT(GROUP,h.aid_mailclean_record_type <> (TYPEOF(h.aid_mailclean_record_type))'');
    populated_aid_mailclean_record_type_pcnt := AVE(GROUP,IF(h.aid_mailclean_record_type = (TYPEOF(h.aid_mailclean_record_type))'',0,100));
    maxlength_aid_mailclean_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_record_type)));
    avelength_aid_mailclean_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_record_type)),h.aid_mailclean_record_type<>(typeof(h.aid_mailclean_record_type))'');
    populated_aid_mailclean_ace_fips_st_cnt := COUNT(GROUP,h.aid_mailclean_ace_fips_st <> (TYPEOF(h.aid_mailclean_ace_fips_st))'');
    populated_aid_mailclean_ace_fips_st_pcnt := AVE(GROUP,IF(h.aid_mailclean_ace_fips_st = (TYPEOF(h.aid_mailclean_ace_fips_st))'',0,100));
    maxlength_aid_mailclean_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_ace_fips_st)));
    avelength_aid_mailclean_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_ace_fips_st)),h.aid_mailclean_ace_fips_st<>(typeof(h.aid_mailclean_ace_fips_st))'');
    populated_aid_mailclean_fipscounty_cnt := COUNT(GROUP,h.aid_mailclean_fipscounty <> (TYPEOF(h.aid_mailclean_fipscounty))'');
    populated_aid_mailclean_fipscounty_pcnt := AVE(GROUP,IF(h.aid_mailclean_fipscounty = (TYPEOF(h.aid_mailclean_fipscounty))'',0,100));
    maxlength_aid_mailclean_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_fipscounty)));
    avelength_aid_mailclean_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_fipscounty)),h.aid_mailclean_fipscounty<>(typeof(h.aid_mailclean_fipscounty))'');
    populated_aid_mailclean_geo_lat_cnt := COUNT(GROUP,h.aid_mailclean_geo_lat <> (TYPEOF(h.aid_mailclean_geo_lat))'');
    populated_aid_mailclean_geo_lat_pcnt := AVE(GROUP,IF(h.aid_mailclean_geo_lat = (TYPEOF(h.aid_mailclean_geo_lat))'',0,100));
    maxlength_aid_mailclean_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_lat)));
    avelength_aid_mailclean_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_lat)),h.aid_mailclean_geo_lat<>(typeof(h.aid_mailclean_geo_lat))'');
    populated_aid_mailclean_geo_long_cnt := COUNT(GROUP,h.aid_mailclean_geo_long <> (TYPEOF(h.aid_mailclean_geo_long))'');
    populated_aid_mailclean_geo_long_pcnt := AVE(GROUP,IF(h.aid_mailclean_geo_long = (TYPEOF(h.aid_mailclean_geo_long))'',0,100));
    maxlength_aid_mailclean_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_long)));
    avelength_aid_mailclean_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_long)),h.aid_mailclean_geo_long<>(typeof(h.aid_mailclean_geo_long))'');
    populated_aid_mailclean_msa_cnt := COUNT(GROUP,h.aid_mailclean_msa <> (TYPEOF(h.aid_mailclean_msa))'');
    populated_aid_mailclean_msa_pcnt := AVE(GROUP,IF(h.aid_mailclean_msa = (TYPEOF(h.aid_mailclean_msa))'',0,100));
    maxlength_aid_mailclean_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_msa)));
    avelength_aid_mailclean_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_msa)),h.aid_mailclean_msa<>(typeof(h.aid_mailclean_msa))'');
    populated_aid_mailclean_geo_blk_cnt := COUNT(GROUP,h.aid_mailclean_geo_blk <> (TYPEOF(h.aid_mailclean_geo_blk))'');
    populated_aid_mailclean_geo_blk_pcnt := AVE(GROUP,IF(h.aid_mailclean_geo_blk = (TYPEOF(h.aid_mailclean_geo_blk))'',0,100));
    maxlength_aid_mailclean_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_blk)));
    avelength_aid_mailclean_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_blk)),h.aid_mailclean_geo_blk<>(typeof(h.aid_mailclean_geo_blk))'');
    populated_aid_mailclean_geo_match_cnt := COUNT(GROUP,h.aid_mailclean_geo_match <> (TYPEOF(h.aid_mailclean_geo_match))'');
    populated_aid_mailclean_geo_match_pcnt := AVE(GROUP,IF(h.aid_mailclean_geo_match = (TYPEOF(h.aid_mailclean_geo_match))'',0,100));
    maxlength_aid_mailclean_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_match)));
    avelength_aid_mailclean_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_geo_match)),h.aid_mailclean_geo_match<>(typeof(h.aid_mailclean_geo_match))'');
    populated_aid_mailclean_err_stat_cnt := COUNT(GROUP,h.aid_mailclean_err_stat <> (TYPEOF(h.aid_mailclean_err_stat))'');
    populated_aid_mailclean_err_stat_pcnt := AVE(GROUP,IF(h.aid_mailclean_err_stat = (TYPEOF(h.aid_mailclean_err_stat))'',0,100));
    maxlength_aid_mailclean_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_err_stat)));
    avelength_aid_mailclean_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aid_mailclean_err_stat)),h.aid_mailclean_err_stat<>(typeof(h.aid_mailclean_err_stat))'');
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
    populated_city_name_cnt := COUNT(GROUP,h.city_name <> (TYPEOF(h.city_name))'');
    populated_city_name_pcnt := AVE(GROUP,IF(h.city_name = (TYPEOF(h.city_name))'',0,100));
    maxlength_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)));
    avelength_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)),h.city_name<>(typeof(h.city_name))'');
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
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
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
    populated_mail_prim_range_cnt := COUNT(GROUP,h.mail_prim_range <> (TYPEOF(h.mail_prim_range))'');
    populated_mail_prim_range_pcnt := AVE(GROUP,IF(h.mail_prim_range = (TYPEOF(h.mail_prim_range))'',0,100));
    maxlength_mail_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_range)));
    avelength_mail_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_range)),h.mail_prim_range<>(typeof(h.mail_prim_range))'');
    populated_mail_predir_cnt := COUNT(GROUP,h.mail_predir <> (TYPEOF(h.mail_predir))'');
    populated_mail_predir_pcnt := AVE(GROUP,IF(h.mail_predir = (TYPEOF(h.mail_predir))'',0,100));
    maxlength_mail_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_predir)));
    avelength_mail_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_predir)),h.mail_predir<>(typeof(h.mail_predir))'');
    populated_mail_prim_name_cnt := COUNT(GROUP,h.mail_prim_name <> (TYPEOF(h.mail_prim_name))'');
    populated_mail_prim_name_pcnt := AVE(GROUP,IF(h.mail_prim_name = (TYPEOF(h.mail_prim_name))'',0,100));
    maxlength_mail_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_name)));
    avelength_mail_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_prim_name)),h.mail_prim_name<>(typeof(h.mail_prim_name))'');
    populated_mail_addr_suffix_cnt := COUNT(GROUP,h.mail_addr_suffix <> (TYPEOF(h.mail_addr_suffix))'');
    populated_mail_addr_suffix_pcnt := AVE(GROUP,IF(h.mail_addr_suffix = (TYPEOF(h.mail_addr_suffix))'',0,100));
    maxlength_mail_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_suffix)));
    avelength_mail_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_addr_suffix)),h.mail_addr_suffix<>(typeof(h.mail_addr_suffix))'');
    populated_mail_postdir_cnt := COUNT(GROUP,h.mail_postdir <> (TYPEOF(h.mail_postdir))'');
    populated_mail_postdir_pcnt := AVE(GROUP,IF(h.mail_postdir = (TYPEOF(h.mail_postdir))'',0,100));
    maxlength_mail_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_postdir)));
    avelength_mail_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_postdir)),h.mail_postdir<>(typeof(h.mail_postdir))'');
    populated_mail_unit_desig_cnt := COUNT(GROUP,h.mail_unit_desig <> (TYPEOF(h.mail_unit_desig))'');
    populated_mail_unit_desig_pcnt := AVE(GROUP,IF(h.mail_unit_desig = (TYPEOF(h.mail_unit_desig))'',0,100));
    maxlength_mail_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_unit_desig)));
    avelength_mail_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_unit_desig)),h.mail_unit_desig<>(typeof(h.mail_unit_desig))'');
    populated_mail_sec_range_cnt := COUNT(GROUP,h.mail_sec_range <> (TYPEOF(h.mail_sec_range))'');
    populated_mail_sec_range_pcnt := AVE(GROUP,IF(h.mail_sec_range = (TYPEOF(h.mail_sec_range))'',0,100));
    maxlength_mail_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_sec_range)));
    avelength_mail_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_sec_range)),h.mail_sec_range<>(typeof(h.mail_sec_range))'');
    populated_mail_p_city_name_cnt := COUNT(GROUP,h.mail_p_city_name <> (TYPEOF(h.mail_p_city_name))'');
    populated_mail_p_city_name_pcnt := AVE(GROUP,IF(h.mail_p_city_name = (TYPEOF(h.mail_p_city_name))'',0,100));
    maxlength_mail_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_p_city_name)));
    avelength_mail_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_p_city_name)),h.mail_p_city_name<>(typeof(h.mail_p_city_name))'');
    populated_mail_v_city_name_cnt := COUNT(GROUP,h.mail_v_city_name <> (TYPEOF(h.mail_v_city_name))'');
    populated_mail_v_city_name_pcnt := AVE(GROUP,IF(h.mail_v_city_name = (TYPEOF(h.mail_v_city_name))'',0,100));
    maxlength_mail_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_v_city_name)));
    avelength_mail_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_v_city_name)),h.mail_v_city_name<>(typeof(h.mail_v_city_name))'');
    populated_mail_st_cnt := COUNT(GROUP,h.mail_st <> (TYPEOF(h.mail_st))'');
    populated_mail_st_pcnt := AVE(GROUP,IF(h.mail_st = (TYPEOF(h.mail_st))'',0,100));
    maxlength_mail_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_st)));
    avelength_mail_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_st)),h.mail_st<>(typeof(h.mail_st))'');
    populated_mail_ace_zip_cnt := COUNT(GROUP,h.mail_ace_zip <> (TYPEOF(h.mail_ace_zip))'');
    populated_mail_ace_zip_pcnt := AVE(GROUP,IF(h.mail_ace_zip = (TYPEOF(h.mail_ace_zip))'',0,100));
    maxlength_mail_ace_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_ace_zip)));
    avelength_mail_ace_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_ace_zip)),h.mail_ace_zip<>(typeof(h.mail_ace_zip))'');
    populated_mail_zip4_cnt := COUNT(GROUP,h.mail_zip4 <> (TYPEOF(h.mail_zip4))'');
    populated_mail_zip4_pcnt := AVE(GROUP,IF(h.mail_zip4 = (TYPEOF(h.mail_zip4))'',0,100));
    maxlength_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip4)));
    avelength_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip4)),h.mail_zip4<>(typeof(h.mail_zip4))'');
    populated_mail_cart_cnt := COUNT(GROUP,h.mail_cart <> (TYPEOF(h.mail_cart))'');
    populated_mail_cart_pcnt := AVE(GROUP,IF(h.mail_cart = (TYPEOF(h.mail_cart))'',0,100));
    maxlength_mail_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cart)));
    avelength_mail_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cart)),h.mail_cart<>(typeof(h.mail_cart))'');
    populated_mail_cr_sort_sz_cnt := COUNT(GROUP,h.mail_cr_sort_sz <> (TYPEOF(h.mail_cr_sort_sz))'');
    populated_mail_cr_sort_sz_pcnt := AVE(GROUP,IF(h.mail_cr_sort_sz = (TYPEOF(h.mail_cr_sort_sz))'',0,100));
    maxlength_mail_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cr_sort_sz)));
    avelength_mail_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_cr_sort_sz)),h.mail_cr_sort_sz<>(typeof(h.mail_cr_sort_sz))'');
    populated_mail_lot_cnt := COUNT(GROUP,h.mail_lot <> (TYPEOF(h.mail_lot))'');
    populated_mail_lot_pcnt := AVE(GROUP,IF(h.mail_lot = (TYPEOF(h.mail_lot))'',0,100));
    maxlength_mail_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot)));
    avelength_mail_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot)),h.mail_lot<>(typeof(h.mail_lot))'');
    populated_mail_lot_order_cnt := COUNT(GROUP,h.mail_lot_order <> (TYPEOF(h.mail_lot_order))'');
    populated_mail_lot_order_pcnt := AVE(GROUP,IF(h.mail_lot_order = (TYPEOF(h.mail_lot_order))'',0,100));
    maxlength_mail_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot_order)));
    avelength_mail_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_lot_order)),h.mail_lot_order<>(typeof(h.mail_lot_order))'');
    populated_mail_dpbc_cnt := COUNT(GROUP,h.mail_dpbc <> (TYPEOF(h.mail_dpbc))'');
    populated_mail_dpbc_pcnt := AVE(GROUP,IF(h.mail_dpbc = (TYPEOF(h.mail_dpbc))'',0,100));
    maxlength_mail_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_dpbc)));
    avelength_mail_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_dpbc)),h.mail_dpbc<>(typeof(h.mail_dpbc))'');
    populated_mail_chk_digit_cnt := COUNT(GROUP,h.mail_chk_digit <> (TYPEOF(h.mail_chk_digit))'');
    populated_mail_chk_digit_pcnt := AVE(GROUP,IF(h.mail_chk_digit = (TYPEOF(h.mail_chk_digit))'',0,100));
    maxlength_mail_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_chk_digit)));
    avelength_mail_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_chk_digit)),h.mail_chk_digit<>(typeof(h.mail_chk_digit))'');
    populated_mail_record_type_cnt := COUNT(GROUP,h.mail_record_type <> (TYPEOF(h.mail_record_type))'');
    populated_mail_record_type_pcnt := AVE(GROUP,IF(h.mail_record_type = (TYPEOF(h.mail_record_type))'',0,100));
    maxlength_mail_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_record_type)));
    avelength_mail_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_record_type)),h.mail_record_type<>(typeof(h.mail_record_type))'');
    populated_mail_ace_fips_st_cnt := COUNT(GROUP,h.mail_ace_fips_st <> (TYPEOF(h.mail_ace_fips_st))'');
    populated_mail_ace_fips_st_pcnt := AVE(GROUP,IF(h.mail_ace_fips_st = (TYPEOF(h.mail_ace_fips_st))'',0,100));
    maxlength_mail_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_ace_fips_st)));
    avelength_mail_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_ace_fips_st)),h.mail_ace_fips_st<>(typeof(h.mail_ace_fips_st))'');
    populated_mail_fipscounty_cnt := COUNT(GROUP,h.mail_fipscounty <> (TYPEOF(h.mail_fipscounty))'');
    populated_mail_fipscounty_pcnt := AVE(GROUP,IF(h.mail_fipscounty = (TYPEOF(h.mail_fipscounty))'',0,100));
    maxlength_mail_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_fipscounty)));
    avelength_mail_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_fipscounty)),h.mail_fipscounty<>(typeof(h.mail_fipscounty))'');
    populated_mail_geo_lat_cnt := COUNT(GROUP,h.mail_geo_lat <> (TYPEOF(h.mail_geo_lat))'');
    populated_mail_geo_lat_pcnt := AVE(GROUP,IF(h.mail_geo_lat = (TYPEOF(h.mail_geo_lat))'',0,100));
    maxlength_mail_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_lat)));
    avelength_mail_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_lat)),h.mail_geo_lat<>(typeof(h.mail_geo_lat))'');
    populated_mail_geo_long_cnt := COUNT(GROUP,h.mail_geo_long <> (TYPEOF(h.mail_geo_long))'');
    populated_mail_geo_long_pcnt := AVE(GROUP,IF(h.mail_geo_long = (TYPEOF(h.mail_geo_long))'',0,100));
    maxlength_mail_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_long)));
    avelength_mail_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_long)),h.mail_geo_long<>(typeof(h.mail_geo_long))'');
    populated_mail_msa_cnt := COUNT(GROUP,h.mail_msa <> (TYPEOF(h.mail_msa))'');
    populated_mail_msa_pcnt := AVE(GROUP,IF(h.mail_msa = (TYPEOF(h.mail_msa))'',0,100));
    maxlength_mail_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_msa)));
    avelength_mail_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_msa)),h.mail_msa<>(typeof(h.mail_msa))'');
    populated_mail_geo_blk_cnt := COUNT(GROUP,h.mail_geo_blk <> (TYPEOF(h.mail_geo_blk))'');
    populated_mail_geo_blk_pcnt := AVE(GROUP,IF(h.mail_geo_blk = (TYPEOF(h.mail_geo_blk))'',0,100));
    maxlength_mail_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_blk)));
    avelength_mail_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_blk)),h.mail_geo_blk<>(typeof(h.mail_geo_blk))'');
    populated_mail_geo_match_cnt := COUNT(GROUP,h.mail_geo_match <> (TYPEOF(h.mail_geo_match))'');
    populated_mail_geo_match_pcnt := AVE(GROUP,IF(h.mail_geo_match = (TYPEOF(h.mail_geo_match))'',0,100));
    maxlength_mail_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_match)));
    avelength_mail_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_geo_match)),h.mail_geo_match<>(typeof(h.mail_geo_match))'');
    populated_mail_err_stat_cnt := COUNT(GROUP,h.mail_err_stat <> (TYPEOF(h.mail_err_stat))'');
    populated_mail_err_stat_pcnt := AVE(GROUP,IF(h.mail_err_stat = (TYPEOF(h.mail_err_stat))'',0,100));
    maxlength_mail_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_err_stat)));
    avelength_mail_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_err_stat)),h.mail_err_stat<>(typeof(h.mail_err_stat))'');
    populated_cass_prim_range_cnt := COUNT(GROUP,h.cass_prim_range <> (TYPEOF(h.cass_prim_range))'');
    populated_cass_prim_range_pcnt := AVE(GROUP,IF(h.cass_prim_range = (TYPEOF(h.cass_prim_range))'',0,100));
    maxlength_cass_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_prim_range)));
    avelength_cass_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_prim_range)),h.cass_prim_range<>(typeof(h.cass_prim_range))'');
    populated_cass_predir_cnt := COUNT(GROUP,h.cass_predir <> (TYPEOF(h.cass_predir))'');
    populated_cass_predir_pcnt := AVE(GROUP,IF(h.cass_predir = (TYPEOF(h.cass_predir))'',0,100));
    maxlength_cass_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_predir)));
    avelength_cass_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_predir)),h.cass_predir<>(typeof(h.cass_predir))'');
    populated_cass_prim_name_cnt := COUNT(GROUP,h.cass_prim_name <> (TYPEOF(h.cass_prim_name))'');
    populated_cass_prim_name_pcnt := AVE(GROUP,IF(h.cass_prim_name = (TYPEOF(h.cass_prim_name))'',0,100));
    maxlength_cass_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_prim_name)));
    avelength_cass_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_prim_name)),h.cass_prim_name<>(typeof(h.cass_prim_name))'');
    populated_cass_addr_suffix_cnt := COUNT(GROUP,h.cass_addr_suffix <> (TYPEOF(h.cass_addr_suffix))'');
    populated_cass_addr_suffix_pcnt := AVE(GROUP,IF(h.cass_addr_suffix = (TYPEOF(h.cass_addr_suffix))'',0,100));
    maxlength_cass_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_addr_suffix)));
    avelength_cass_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_addr_suffix)),h.cass_addr_suffix<>(typeof(h.cass_addr_suffix))'');
    populated_cass_postdir_cnt := COUNT(GROUP,h.cass_postdir <> (TYPEOF(h.cass_postdir))'');
    populated_cass_postdir_pcnt := AVE(GROUP,IF(h.cass_postdir = (TYPEOF(h.cass_postdir))'',0,100));
    maxlength_cass_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_postdir)));
    avelength_cass_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_postdir)),h.cass_postdir<>(typeof(h.cass_postdir))'');
    populated_cass_unit_desig_cnt := COUNT(GROUP,h.cass_unit_desig <> (TYPEOF(h.cass_unit_desig))'');
    populated_cass_unit_desig_pcnt := AVE(GROUP,IF(h.cass_unit_desig = (TYPEOF(h.cass_unit_desig))'',0,100));
    maxlength_cass_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_unit_desig)));
    avelength_cass_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_unit_desig)),h.cass_unit_desig<>(typeof(h.cass_unit_desig))'');
    populated_cass_sec_range_cnt := COUNT(GROUP,h.cass_sec_range <> (TYPEOF(h.cass_sec_range))'');
    populated_cass_sec_range_pcnt := AVE(GROUP,IF(h.cass_sec_range = (TYPEOF(h.cass_sec_range))'',0,100));
    maxlength_cass_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_sec_range)));
    avelength_cass_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_sec_range)),h.cass_sec_range<>(typeof(h.cass_sec_range))'');
    populated_cass_p_city_name_cnt := COUNT(GROUP,h.cass_p_city_name <> (TYPEOF(h.cass_p_city_name))'');
    populated_cass_p_city_name_pcnt := AVE(GROUP,IF(h.cass_p_city_name = (TYPEOF(h.cass_p_city_name))'',0,100));
    maxlength_cass_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_p_city_name)));
    avelength_cass_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_p_city_name)),h.cass_p_city_name<>(typeof(h.cass_p_city_name))'');
    populated_cass_v_city_name_cnt := COUNT(GROUP,h.cass_v_city_name <> (TYPEOF(h.cass_v_city_name))'');
    populated_cass_v_city_name_pcnt := AVE(GROUP,IF(h.cass_v_city_name = (TYPEOF(h.cass_v_city_name))'',0,100));
    maxlength_cass_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_v_city_name)));
    avelength_cass_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_v_city_name)),h.cass_v_city_name<>(typeof(h.cass_v_city_name))'');
    populated_cass_st_cnt := COUNT(GROUP,h.cass_st <> (TYPEOF(h.cass_st))'');
    populated_cass_st_pcnt := AVE(GROUP,IF(h.cass_st = (TYPEOF(h.cass_st))'',0,100));
    maxlength_cass_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_st)));
    avelength_cass_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_st)),h.cass_st<>(typeof(h.cass_st))'');
    populated_cass_ace_zip_cnt := COUNT(GROUP,h.cass_ace_zip <> (TYPEOF(h.cass_ace_zip))'');
    populated_cass_ace_zip_pcnt := AVE(GROUP,IF(h.cass_ace_zip = (TYPEOF(h.cass_ace_zip))'',0,100));
    maxlength_cass_ace_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_ace_zip)));
    avelength_cass_ace_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_ace_zip)),h.cass_ace_zip<>(typeof(h.cass_ace_zip))'');
    populated_cass_zip4_cnt := COUNT(GROUP,h.cass_zip4 <> (TYPEOF(h.cass_zip4))'');
    populated_cass_zip4_pcnt := AVE(GROUP,IF(h.cass_zip4 = (TYPEOF(h.cass_zip4))'',0,100));
    maxlength_cass_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_zip4)));
    avelength_cass_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_zip4)),h.cass_zip4<>(typeof(h.cass_zip4))'');
    populated_cass_cart_cnt := COUNT(GROUP,h.cass_cart <> (TYPEOF(h.cass_cart))'');
    populated_cass_cart_pcnt := AVE(GROUP,IF(h.cass_cart = (TYPEOF(h.cass_cart))'',0,100));
    maxlength_cass_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_cart)));
    avelength_cass_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_cart)),h.cass_cart<>(typeof(h.cass_cart))'');
    populated_cass_cr_sort_sz_cnt := COUNT(GROUP,h.cass_cr_sort_sz <> (TYPEOF(h.cass_cr_sort_sz))'');
    populated_cass_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cass_cr_sort_sz = (TYPEOF(h.cass_cr_sort_sz))'',0,100));
    maxlength_cass_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_cr_sort_sz)));
    avelength_cass_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_cr_sort_sz)),h.cass_cr_sort_sz<>(typeof(h.cass_cr_sort_sz))'');
    populated_cass_lot_cnt := COUNT(GROUP,h.cass_lot <> (TYPEOF(h.cass_lot))'');
    populated_cass_lot_pcnt := AVE(GROUP,IF(h.cass_lot = (TYPEOF(h.cass_lot))'',0,100));
    maxlength_cass_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_lot)));
    avelength_cass_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_lot)),h.cass_lot<>(typeof(h.cass_lot))'');
    populated_cass_lot_order_cnt := COUNT(GROUP,h.cass_lot_order <> (TYPEOF(h.cass_lot_order))'');
    populated_cass_lot_order_pcnt := AVE(GROUP,IF(h.cass_lot_order = (TYPEOF(h.cass_lot_order))'',0,100));
    maxlength_cass_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_lot_order)));
    avelength_cass_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_lot_order)),h.cass_lot_order<>(typeof(h.cass_lot_order))'');
    populated_cass_dpbc_cnt := COUNT(GROUP,h.cass_dpbc <> (TYPEOF(h.cass_dpbc))'');
    populated_cass_dpbc_pcnt := AVE(GROUP,IF(h.cass_dpbc = (TYPEOF(h.cass_dpbc))'',0,100));
    maxlength_cass_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_dpbc)));
    avelength_cass_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_dpbc)),h.cass_dpbc<>(typeof(h.cass_dpbc))'');
    populated_cass_chk_digit_cnt := COUNT(GROUP,h.cass_chk_digit <> (TYPEOF(h.cass_chk_digit))'');
    populated_cass_chk_digit_pcnt := AVE(GROUP,IF(h.cass_chk_digit = (TYPEOF(h.cass_chk_digit))'',0,100));
    maxlength_cass_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_chk_digit)));
    avelength_cass_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_chk_digit)),h.cass_chk_digit<>(typeof(h.cass_chk_digit))'');
    populated_cass_record_type_cnt := COUNT(GROUP,h.cass_record_type <> (TYPEOF(h.cass_record_type))'');
    populated_cass_record_type_pcnt := AVE(GROUP,IF(h.cass_record_type = (TYPEOF(h.cass_record_type))'',0,100));
    maxlength_cass_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_record_type)));
    avelength_cass_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_record_type)),h.cass_record_type<>(typeof(h.cass_record_type))'');
    populated_cass_ace_fips_st_cnt := COUNT(GROUP,h.cass_ace_fips_st <> (TYPEOF(h.cass_ace_fips_st))'');
    populated_cass_ace_fips_st_pcnt := AVE(GROUP,IF(h.cass_ace_fips_st = (TYPEOF(h.cass_ace_fips_st))'',0,100));
    maxlength_cass_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_ace_fips_st)));
    avelength_cass_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_ace_fips_st)),h.cass_ace_fips_st<>(typeof(h.cass_ace_fips_st))'');
    populated_cass_fipscounty_cnt := COUNT(GROUP,h.cass_fipscounty <> (TYPEOF(h.cass_fipscounty))'');
    populated_cass_fipscounty_pcnt := AVE(GROUP,IF(h.cass_fipscounty = (TYPEOF(h.cass_fipscounty))'',0,100));
    maxlength_cass_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_fipscounty)));
    avelength_cass_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_fipscounty)),h.cass_fipscounty<>(typeof(h.cass_fipscounty))'');
    populated_cass_geo_lat_cnt := COUNT(GROUP,h.cass_geo_lat <> (TYPEOF(h.cass_geo_lat))'');
    populated_cass_geo_lat_pcnt := AVE(GROUP,IF(h.cass_geo_lat = (TYPEOF(h.cass_geo_lat))'',0,100));
    maxlength_cass_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_lat)));
    avelength_cass_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_lat)),h.cass_geo_lat<>(typeof(h.cass_geo_lat))'');
    populated_cass_geo_long_cnt := COUNT(GROUP,h.cass_geo_long <> (TYPEOF(h.cass_geo_long))'');
    populated_cass_geo_long_pcnt := AVE(GROUP,IF(h.cass_geo_long = (TYPEOF(h.cass_geo_long))'',0,100));
    maxlength_cass_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_long)));
    avelength_cass_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_long)),h.cass_geo_long<>(typeof(h.cass_geo_long))'');
    populated_cass_msa_cnt := COUNT(GROUP,h.cass_msa <> (TYPEOF(h.cass_msa))'');
    populated_cass_msa_pcnt := AVE(GROUP,IF(h.cass_msa = (TYPEOF(h.cass_msa))'',0,100));
    maxlength_cass_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_msa)));
    avelength_cass_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_msa)),h.cass_msa<>(typeof(h.cass_msa))'');
    populated_cass_geo_blk_cnt := COUNT(GROUP,h.cass_geo_blk <> (TYPEOF(h.cass_geo_blk))'');
    populated_cass_geo_blk_pcnt := AVE(GROUP,IF(h.cass_geo_blk = (TYPEOF(h.cass_geo_blk))'',0,100));
    maxlength_cass_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_blk)));
    avelength_cass_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_blk)),h.cass_geo_blk<>(typeof(h.cass_geo_blk))'');
    populated_cass_geo_match_cnt := COUNT(GROUP,h.cass_geo_match <> (TYPEOF(h.cass_geo_match))'');
    populated_cass_geo_match_pcnt := AVE(GROUP,IF(h.cass_geo_match = (TYPEOF(h.cass_geo_match))'',0,100));
    maxlength_cass_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_match)));
    avelength_cass_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_geo_match)),h.cass_geo_match<>(typeof(h.cass_geo_match))'');
    populated_cass_err_stat_cnt := COUNT(GROUP,h.cass_err_stat <> (TYPEOF(h.cass_err_stat))'');
    populated_cass_err_stat_pcnt := AVE(GROUP,IF(h.cass_err_stat = (TYPEOF(h.cass_err_stat))'',0,100));
    maxlength_cass_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_err_stat)));
    avelength_cass_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cass_err_stat)),h.cass_err_stat<>(typeof(h.cass_err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_seqnum_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_did_out_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_file_id_pcnt *   0.00 / 100 + T.Populated_vendor_id_pcnt *   0.00 / 100 + T.Populated_source_state_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_file_acquired_date_pcnt *   0.00 / 100 + T.Populated__use_pcnt *   0.00 / 100 + T.Populated_title_in_pcnt *   0.00 / 100 + T.Populated_lname_in_pcnt *   0.00 / 100 + T.Populated_fname_in_pcnt *   0.00 / 100 + T.Populated_mname_in_pcnt *   0.00 / 100 + T.Populated_maiden_prior_pcnt *   0.00 / 100 + T.Populated_name_suffix_in_pcnt *   0.00 / 100 + T.Populated_votefiller_pcnt *   0.00 / 100 + T.Populated_source_voterid_pcnt *   0.00 / 100 + T.Populated_dob_str_in_pcnt *   0.00 / 100 + T.Populated_agecat_pcnt *   0.00 / 100 + T.Populated_headhousehold_pcnt *   0.00 / 100 + T.Populated_place_of_birth_pcnt *   0.00 / 100 + T.Populated_occupation_pcnt *   0.00 / 100 + T.Populated_maiden_name_pcnt *   0.00 / 100 + T.Populated_motorvoterid_pcnt *   0.00 / 100 + T.Populated_regsource_pcnt *   0.00 / 100 + T.Populated_regdate_in_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_poliparty_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100 + T.Populated_other_phone_pcnt *   0.00 / 100 + T.Populated_active_status_pcnt *   0.00 / 100 + T.Populated_votefiller2_pcnt *   0.00 / 100 + T.Populated_active_other_pcnt *   0.00 / 100 + T.Populated_voterstatus_pcnt *   0.00 / 100 + T.Populated_resaddr1_pcnt *   0.00 / 100 + T.Populated_resaddr2_pcnt *   0.00 / 100 + T.Populated_res_city_pcnt *   0.00 / 100 + T.Populated_res_state_pcnt *   0.00 / 100 + T.Populated_res_zip_pcnt *   0.00 / 100 + T.Populated_res_county_pcnt *   0.00 / 100 + T.Populated_mail_addr1_pcnt *   0.00 / 100 + T.Populated_mail_addr2_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_mail_county_pcnt *   0.00 / 100 + T.Populated_addr_filler1_pcnt *   0.00 / 100 + T.Populated_addr_filler2_pcnt *   0.00 / 100 + T.Populated_city_filler_pcnt *   0.00 / 100 + T.Populated_state_filler_pcnt *   0.00 / 100 + T.Populated_zip_filler_pcnt *   0.00 / 100 + T.Populated_county_filler_pcnt *   0.00 / 100 + T.Populated_towncode_pcnt *   0.00 / 100 + T.Populated_distcode_pcnt *   0.00 / 100 + T.Populated_countycode_pcnt *   0.00 / 100 + T.Populated_schoolcode_pcnt *   0.00 / 100 + T.Populated_cityinout_pcnt *   0.00 / 100 + T.Populated_spec_dist1_pcnt *   0.00 / 100 + T.Populated_spec_dist2_pcnt *   0.00 / 100 + T.Populated_precinct1_pcnt *   0.00 / 100 + T.Populated_precinct2_pcnt *   0.00 / 100 + T.Populated_precinct3_pcnt *   0.00 / 100 + T.Populated_villageprecinct_pcnt *   0.00 / 100 + T.Populated_schoolprecinct_pcnt *   0.00 / 100 + T.Populated_ward_pcnt *   0.00 / 100 + T.Populated_precinct_citytown_pcnt *   0.00 / 100 + T.Populated_ancsmdindc_pcnt *   0.00 / 100 + T.Populated_citycouncildist_pcnt *   0.00 / 100 + T.Populated_countycommdist_pcnt *   0.00 / 100 + T.Populated_statehouse_pcnt *   0.00 / 100 + T.Populated_statesenate_pcnt *   0.00 / 100 + T.Populated_ushouse_pcnt *   0.00 / 100 + T.Populated_elemschooldist_pcnt *   0.00 / 100 + T.Populated_schooldist_pcnt *   0.00 / 100 + T.Populated_schoolfiller_pcnt *   0.00 / 100 + T.Populated_commcolldist_pcnt *   0.00 / 100 + T.Populated_dist_filler_pcnt *   0.00 / 100 + T.Populated_municipal_pcnt *   0.00 / 100 + T.Populated_villagedist_pcnt *   0.00 / 100 + T.Populated_policejury_pcnt *   0.00 / 100 + T.Populated_policedist_pcnt *   0.00 / 100 + T.Populated_publicservcomm_pcnt *   0.00 / 100 + T.Populated_rescue_pcnt *   0.00 / 100 + T.Populated_fire_pcnt *   0.00 / 100 + T.Populated_sanitary_pcnt *   0.00 / 100 + T.Populated_sewerdist_pcnt *   0.00 / 100 + T.Populated_waterdist_pcnt *   0.00 / 100 + T.Populated_mosquitodist_pcnt *   0.00 / 100 + T.Populated_taxdist_pcnt *   0.00 / 100 + T.Populated_supremecourt_pcnt *   0.00 / 100 + T.Populated_justiceofpeace_pcnt *   0.00 / 100 + T.Populated_judicialdist_pcnt *   0.00 / 100 + T.Populated_superiorctdist_pcnt *   0.00 / 100 + T.Populated_appealsct_pcnt *   0.00 / 100 + T.Populated_courtfiller_pcnt *   0.00 / 100 + T.Populated_contributorparty_pcnt *   0.00 / 100 + T.Populated_recptparty_pcnt *   0.00 / 100 + T.Populated_dateofcontr_in_pcnt *   0.00 / 100 + T.Populated_dollaramt_pcnt *   0.00 / 100 + T.Populated_officecontto_pcnt *   0.00 / 100 + T.Populated_cumuldollaramt_pcnt *   0.00 / 100 + T.Populated_contfiller1_pcnt *   0.00 / 100 + T.Populated_contfiller2_pcnt *   0.00 / 100 + T.Populated_conttype_pcnt *   0.00 / 100 + T.Populated_contfiller3_pcnt *   0.00 / 100 + T.Populated_primary02_pcnt *   0.00 / 100 + T.Populated_special02_pcnt *   0.00 / 100 + T.Populated_other02_pcnt *   0.00 / 100 + T.Populated_special202_pcnt *   0.00 / 100 + T.Populated_general02_pcnt *   0.00 / 100 + T.Populated_primary01_pcnt *   0.00 / 100 + T.Populated_special01_pcnt *   0.00 / 100 + T.Populated_other01_pcnt *   0.00 / 100 + T.Populated_special201_pcnt *   0.00 / 100 + T.Populated_general01_pcnt *   0.00 / 100 + T.Populated_pres00_pcnt *   0.00 / 100 + T.Populated_primary00_pcnt *   0.00 / 100 + T.Populated_special00_pcnt *   0.00 / 100 + T.Populated_other00_pcnt *   0.00 / 100 + T.Populated_special200_pcnt *   0.00 / 100 + T.Populated_general00_pcnt *   0.00 / 100 + T.Populated_primary99_pcnt *   0.00 / 100 + T.Populated_special99_pcnt *   0.00 / 100 + T.Populated_other99_pcnt *   0.00 / 100 + T.Populated_special299_pcnt *   0.00 / 100 + T.Populated_general99_pcnt *   0.00 / 100 + T.Populated_primary98_pcnt *   0.00 / 100 + T.Populated_special98_pcnt *   0.00 / 100 + T.Populated_other98_pcnt *   0.00 / 100 + T.Populated_special298_pcnt *   0.00 / 100 + T.Populated_general98_pcnt *   0.00 / 100 + T.Populated_primary97_pcnt *   0.00 / 100 + T.Populated_special97_pcnt *   0.00 / 100 + T.Populated_other97_pcnt *   0.00 / 100 + T.Populated_special297_pcnt *   0.00 / 100 + T.Populated_general97_pcnt *   0.00 / 100 + T.Populated_pres96_pcnt *   0.00 / 100 + T.Populated_primary96_pcnt *   0.00 / 100 + T.Populated_special96_pcnt *   0.00 / 100 + T.Populated_other96_pcnt *   0.00 / 100 + T.Populated_special296_pcnt *   0.00 / 100 + T.Populated_general96_pcnt *   0.00 / 100 + T.Populated_lastdayvote_in_pcnt *   0.00 / 100 + T.Populated_historyfiller_pcnt *   0.00 / 100 + T.Populated_huntfishperm_pcnt *   0.00 / 100 + T.Populated_datelicense_in_pcnt *   0.00 / 100 + T.Populated_homestate_pcnt *   0.00 / 100 + T.Populated_resident_pcnt *   0.00 / 100 + T.Populated_nonresident_pcnt *   0.00 / 100 + T.Populated_hunt_pcnt *   0.00 / 100 + T.Populated_fish_pcnt *   0.00 / 100 + T.Populated_combosuper_pcnt *   0.00 / 100 + T.Populated_sportsman_pcnt *   0.00 / 100 + T.Populated_trap_pcnt *   0.00 / 100 + T.Populated_archery_pcnt *   0.00 / 100 + T.Populated_muzzle_pcnt *   0.00 / 100 + T.Populated_drawing_pcnt *   0.00 / 100 + T.Populated_day1_pcnt *   0.00 / 100 + T.Populated_day3_pcnt *   0.00 / 100 + T.Populated_day7_pcnt *   0.00 / 100 + T.Populated_day14to15_pcnt *   0.00 / 100 + T.Populated_dayfiller_pcnt *   0.00 / 100 + T.Populated_seasonannual_pcnt *   0.00 / 100 + T.Populated_lifetimepermit_pcnt *   0.00 / 100 + T.Populated_landowner_pcnt *   0.00 / 100 + T.Populated_family_pcnt *   0.00 / 100 + T.Populated_junior_pcnt *   0.00 / 100 + T.Populated_seniorcit_pcnt *   0.00 / 100 + T.Populated_crewmemeber_pcnt *   0.00 / 100 + T.Populated_retarded_pcnt *   0.00 / 100 + T.Populated_indian_pcnt *   0.00 / 100 + T.Populated_serviceman_pcnt *   0.00 / 100 + T.Populated_disabled_pcnt *   0.00 / 100 + T.Populated_lowincome_pcnt *   0.00 / 100 + T.Populated_regioncounty_pcnt *   0.00 / 100 + T.Populated_blind_pcnt *   0.00 / 100 + T.Populated_huntfiller_pcnt *   0.00 / 100 + T.Populated_salmon_pcnt *   0.00 / 100 + T.Populated_freshwater_pcnt *   0.00 / 100 + T.Populated_saltwater_pcnt *   0.00 / 100 + T.Populated_lakesandresevoirs_pcnt *   0.00 / 100 + T.Populated_setlinefish_pcnt *   0.00 / 100 + T.Populated_trout_pcnt *   0.00 / 100 + T.Populated_fallfishing_pcnt *   0.00 / 100 + T.Populated_steelhead_pcnt *   0.00 / 100 + T.Populated_whitejubherring_pcnt *   0.00 / 100 + T.Populated_sturgeon_pcnt *   0.00 / 100 + T.Populated_shellfishcrab_pcnt *   0.00 / 100 + T.Populated_shellfishlobster_pcnt *   0.00 / 100 + T.Populated_deer_pcnt *   0.00 / 100 + T.Populated_bear_pcnt *   0.00 / 100 + T.Populated_elk_pcnt *   0.00 / 100 + T.Populated_moose_pcnt *   0.00 / 100 + T.Populated_buffalo_pcnt *   0.00 / 100 + T.Populated_antelope_pcnt *   0.00 / 100 + T.Populated_sikebull_pcnt *   0.00 / 100 + T.Populated_bighorn_pcnt *   0.00 / 100 + T.Populated_javelina_pcnt *   0.00 / 100 + T.Populated_cougar_pcnt *   0.00 / 100 + T.Populated_anterless_pcnt *   0.00 / 100 + T.Populated_pheasant_pcnt *   0.00 / 100 + T.Populated_goose_pcnt *   0.00 / 100 + T.Populated_duck_pcnt *   0.00 / 100 + T.Populated_turkey_pcnt *   0.00 / 100 + T.Populated_snowmobile_pcnt *   0.00 / 100 + T.Populated_biggame_pcnt *   0.00 / 100 + T.Populated_skipass_pcnt *   0.00 / 100 + T.Populated_migbird_pcnt *   0.00 / 100 + T.Populated_smallgame_pcnt *   0.00 / 100 + T.Populated_sturgeon2_pcnt *   0.00 / 100 + T.Populated_gun_pcnt *   0.00 / 100 + T.Populated_bonus_pcnt *   0.00 / 100 + T.Populated_lottery_pcnt *   0.00 / 100 + T.Populated_otherbirds_pcnt *   0.00 / 100 + T.Populated_huntfill1_pcnt *   0.00 / 100 + T.Populated_boatindexnum_pcnt *   0.00 / 100 + T.Populated_boatcoowner_pcnt *   0.00 / 100 + T.Populated_hullidnum_pcnt *   0.00 / 100 + T.Populated_yearmade_pcnt *   0.00 / 100 + T.Populated_model_pcnt *   0.00 / 100 + T.Populated_manufacturer_pcnt *   0.00 / 100 + T.Populated_lengt_pcnt *   0.00 / 100 + T.Populated_hullconstruct_pcnt *   0.00 / 100 + T.Populated_primuse_pcnt *   0.00 / 100 + T.Populated_fueltype_pcnt *   0.00 / 100 + T.Populated_propulsion_pcnt *   0.00 / 100 + T.Populated_modeltype_pcnt *   0.00 / 100 + T.Populated_regexpdate_in_pcnt *   0.00 / 100 + T.Populated_titlenum_pcnt *   0.00 / 100 + T.Populated_stprimuse_pcnt *   0.00 / 100 + T.Populated_titlestatus_pcnt *   0.00 / 100 + T.Populated_vessel_pcnt *   0.00 / 100 + T.Populated_specreg_pcnt *   0.00 / 100 + T.Populated_boatfill1_pcnt *   0.00 / 100 + T.Populated_boatfill2_pcnt *   0.00 / 100 + T.Populated_boatfill3_pcnt *   0.00 / 100 + T.Populated_ccwpermnum_pcnt *   0.00 / 100 + T.Populated_ccwweapontype_pcnt *   0.00 / 100 + T.Populated_ccwregdate_in_pcnt *   0.00 / 100 + T.Populated_ccwexpdate_in_pcnt *   0.00 / 100 + T.Populated_ccwpermtype_pcnt *   0.00 / 100 + T.Populated_ccwfill1_pcnt *   0.00 / 100 + T.Populated_ccwfill2_pcnt *   0.00 / 100 + T.Populated_ccwfill3_pcnt *   0.00 / 100 + T.Populated_ccwfill4_pcnt *   0.00 / 100 + T.Populated_miscfill1_pcnt *   0.00 / 100 + T.Populated_miscfill2_pcnt *   0.00 / 100 + T.Populated_miscfill3_pcnt *   0.00 / 100 + T.Populated_miscfill4_pcnt *   0.00 / 100 + T.Populated_miscfill5_pcnt *   0.00 / 100 + T.Populated_fillerother1_pcnt *   0.00 / 100 + T.Populated_fillerother2_pcnt *   0.00 / 100 + T.Populated_fillerother3_pcnt *   0.00 / 100 + T.Populated_fillerother4_pcnt *   0.00 / 100 + T.Populated_fillerother5_pcnt *   0.00 / 100 + T.Populated_fillerother6_pcnt *   0.00 / 100 + T.Populated_fillerother7_pcnt *   0.00 / 100 + T.Populated_fillerother8_pcnt *   0.00 / 100 + T.Populated_fillerother9_pcnt *   0.00 / 100 + T.Populated_fillerother10_pcnt *   0.00 / 100 + T.Populated_eor_pcnt *   0.00 / 100 + T.Populated_stuff_pcnt *   0.00 / 100 + T.Populated_dob_str_pcnt *   0.00 / 100 + T.Populated_regdate_pcnt *   0.00 / 100 + T.Populated_dateofcontr_pcnt *   0.00 / 100 + T.Populated_lastdayvote_pcnt *   0.00 / 100 + T.Populated_datelicense_pcnt *   0.00 / 100 + T.Populated_regexpdate_pcnt *   0.00 / 100 + T.Populated_ccwregdate_pcnt *   0.00 / 100 + T.Populated_ccwexpdate_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_score_on_input_pcnt *   0.00 / 100 + T.Populated_append_prep_resaddress1_pcnt *   0.00 / 100 + T.Populated_append_prep_resaddress2_pcnt *   0.00 / 100 + T.Populated_append_resrawaid_pcnt *   0.00 / 100 + T.Populated_append_prep_mailaddress1_pcnt *   0.00 / 100 + T.Populated_append_prep_mailaddress2_pcnt *   0.00 / 100 + T.Populated_append_mailrawaid_pcnt *   0.00 / 100 + T.Populated_append_prep_cassaddress1_pcnt *   0.00 / 100 + T.Populated_append_prep_cassaddress2_pcnt *   0.00 / 100 + T.Populated_append_cassrawaid_pcnt *   0.00 / 100 + T.Populated_aid_resclean_prim_range_pcnt *   0.00 / 100 + T.Populated_aid_resclean_predir_pcnt *   0.00 / 100 + T.Populated_aid_resclean_prim_name_pcnt *   0.00 / 100 + T.Populated_aid_resclean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_aid_resclean_postdir_pcnt *   0.00 / 100 + T.Populated_aid_resclean_unit_desig_pcnt *   0.00 / 100 + T.Populated_aid_resclean_sec_range_pcnt *   0.00 / 100 + T.Populated_aid_resclean_p_city_name_pcnt *   0.00 / 100 + T.Populated_aid_resclean_v_city_name_pcnt *   0.00 / 100 + T.Populated_aid_resclean_st_pcnt *   0.00 / 100 + T.Populated_aid_resclean_zip_pcnt *   0.00 / 100 + T.Populated_aid_resclean_zip4_pcnt *   0.00 / 100 + T.Populated_aid_resclean_cart_pcnt *   0.00 / 100 + T.Populated_aid_resclean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_aid_resclean_lot_pcnt *   0.00 / 100 + T.Populated_aid_resclean_lot_order_pcnt *   0.00 / 100 + T.Populated_aid_resclean_dpbc_pcnt *   0.00 / 100 + T.Populated_aid_resclean_chk_digit_pcnt *   0.00 / 100 + T.Populated_aid_resclean_record_type_pcnt *   0.00 / 100 + T.Populated_aid_resclean_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_aid_resclean_fipscounty_pcnt *   0.00 / 100 + T.Populated_aid_resclean_geo_lat_pcnt *   0.00 / 100 + T.Populated_aid_resclean_geo_long_pcnt *   0.00 / 100 + T.Populated_aid_resclean_msa_pcnt *   0.00 / 100 + T.Populated_aid_resclean_geo_blk_pcnt *   0.00 / 100 + T.Populated_aid_resclean_geo_match_pcnt *   0.00 / 100 + T.Populated_aid_resclean_err_stat_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_prim_range_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_predir_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_prim_name_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_postdir_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_unit_desig_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_sec_range_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_p_city_name_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_v_city_name_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_st_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_zip_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_zip4_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_cart_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_lot_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_lot_order_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_dpbc_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_chk_digit_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_record_type_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_fipscounty_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_geo_lat_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_geo_long_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_msa_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_geo_blk_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_geo_match_pcnt *   0.00 / 100 + T.Populated_aid_mailclean_err_stat_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_mail_prim_range_pcnt *   0.00 / 100 + T.Populated_mail_predir_pcnt *   0.00 / 100 + T.Populated_mail_prim_name_pcnt *   0.00 / 100 + T.Populated_mail_addr_suffix_pcnt *   0.00 / 100 + T.Populated_mail_postdir_pcnt *   0.00 / 100 + T.Populated_mail_unit_desig_pcnt *   0.00 / 100 + T.Populated_mail_sec_range_pcnt *   0.00 / 100 + T.Populated_mail_p_city_name_pcnt *   0.00 / 100 + T.Populated_mail_v_city_name_pcnt *   0.00 / 100 + T.Populated_mail_st_pcnt *   0.00 / 100 + T.Populated_mail_ace_zip_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_mail_cart_pcnt *   0.00 / 100 + T.Populated_mail_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_mail_lot_pcnt *   0.00 / 100 + T.Populated_mail_lot_order_pcnt *   0.00 / 100 + T.Populated_mail_dpbc_pcnt *   0.00 / 100 + T.Populated_mail_chk_digit_pcnt *   0.00 / 100 + T.Populated_mail_record_type_pcnt *   0.00 / 100 + T.Populated_mail_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_mail_fipscounty_pcnt *   0.00 / 100 + T.Populated_mail_geo_lat_pcnt *   0.00 / 100 + T.Populated_mail_geo_long_pcnt *   0.00 / 100 + T.Populated_mail_msa_pcnt *   0.00 / 100 + T.Populated_mail_geo_blk_pcnt *   0.00 / 100 + T.Populated_mail_geo_match_pcnt *   0.00 / 100 + T.Populated_mail_err_stat_pcnt *   0.00 / 100 + T.Populated_cass_prim_range_pcnt *   0.00 / 100 + T.Populated_cass_predir_pcnt *   0.00 / 100 + T.Populated_cass_prim_name_pcnt *   0.00 / 100 + T.Populated_cass_addr_suffix_pcnt *   0.00 / 100 + T.Populated_cass_postdir_pcnt *   0.00 / 100 + T.Populated_cass_unit_desig_pcnt *   0.00 / 100 + T.Populated_cass_sec_range_pcnt *   0.00 / 100 + T.Populated_cass_p_city_name_pcnt *   0.00 / 100 + T.Populated_cass_v_city_name_pcnt *   0.00 / 100 + T.Populated_cass_st_pcnt *   0.00 / 100 + T.Populated_cass_ace_zip_pcnt *   0.00 / 100 + T.Populated_cass_zip4_pcnt *   0.00 / 100 + T.Populated_cass_cart_pcnt *   0.00 / 100 + T.Populated_cass_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_cass_lot_pcnt *   0.00 / 100 + T.Populated_cass_lot_order_pcnt *   0.00 / 100 + T.Populated_cass_dpbc_pcnt *   0.00 / 100 + T.Populated_cass_chk_digit_pcnt *   0.00 / 100 + T.Populated_cass_record_type_pcnt *   0.00 / 100 + T.Populated_cass_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_cass_fipscounty_pcnt *   0.00 / 100 + T.Populated_cass_geo_lat_pcnt *   0.00 / 100 + T.Populated_cass_geo_long_pcnt *   0.00 / 100 + T.Populated_cass_msa_pcnt *   0.00 / 100 + T.Populated_cass_geo_blk_pcnt *   0.00 / 100 + T.Populated_cass_geo_match_pcnt *   0.00 / 100 + T.Populated_cass_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'append_seqnum','persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob_str_in','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate_in','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','county_filler','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','contributorparty','recptparty','dateofcontr_in','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller3','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote_in','historyfiller','huntfishperm','datelicense_in','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','boatindexnum','boatcoowner','hullidnum','yearmade','model','manufacturer','lengt','hullconstruct','primuse','fueltype','propulsion','modeltype','regexpdate_in','titlenum','stprimuse','titlestatus','vessel','specreg','boatfill1','boatfill2','boatfill3','ccwpermnum','ccwweapontype','ccwregdate_in','ccwexpdate_in','ccwpermtype','ccwfill1','ccwfill2','ccwfill3','ccwfill4','miscfill1','miscfill2','miscfill3','miscfill4','miscfill5','fillerother1','fillerother2','fillerother3','fillerother4','fillerother5','fillerother6','fillerother7','fillerother8','fillerother9','fillerother10','eor','stuff','dob_str','regdate','dateofcontr','lastdayvote','datelicense','regexpdate','ccwregdate','ccwexpdate','title','fname','mname','lname','name_suffix','score_on_input','append_prep_resaddress1','append_prep_resaddress2','append_resrawaid','append_prep_mailaddress1','append_prep_mailaddress2','append_mailrawaid','append_prep_cassaddress1','append_prep_cassaddress2','append_cassrawaid','aid_resclean_prim_range','aid_resclean_predir','aid_resclean_prim_name','aid_resclean_addr_suffix','aid_resclean_postdir','aid_resclean_unit_desig','aid_resclean_sec_range','aid_resclean_p_city_name','aid_resclean_v_city_name','aid_resclean_st','aid_resclean_zip','aid_resclean_zip4','aid_resclean_cart','aid_resclean_cr_sort_sz','aid_resclean_lot','aid_resclean_lot_order','aid_resclean_dpbc','aid_resclean_chk_digit','aid_resclean_record_type','aid_resclean_ace_fips_st','aid_resclean_fipscounty','aid_resclean_geo_lat','aid_resclean_geo_long','aid_resclean_msa','aid_resclean_geo_blk','aid_resclean_geo_match','aid_resclean_err_stat','aid_mailclean_prim_range','aid_mailclean_predir','aid_mailclean_prim_name','aid_mailclean_addr_suffix','aid_mailclean_postdir','aid_mailclean_unit_desig','aid_mailclean_sec_range','aid_mailclean_p_city_name','aid_mailclean_v_city_name','aid_mailclean_st','aid_mailclean_zip','aid_mailclean_zip4','aid_mailclean_cart','aid_mailclean_cr_sort_sz','aid_mailclean_lot','aid_mailclean_lot_order','aid_mailclean_dpbc','aid_mailclean_chk_digit','aid_mailclean_record_type','aid_mailclean_ace_fips_st','aid_mailclean_fipscounty','aid_mailclean_geo_lat','aid_mailclean_geo_long','aid_mailclean_msa','aid_mailclean_geo_blk','aid_mailclean_geo_match','aid_mailclean_err_stat','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','cass_prim_range','cass_predir','cass_prim_name','cass_addr_suffix','cass_postdir','cass_unit_desig','cass_sec_range','cass_p_city_name','cass_v_city_name','cass_st','cass_ace_zip','cass_zip4','cass_cart','cass_cr_sort_sz','cass_lot','cass_lot_order','cass_dpbc','cass_chk_digit','cass_record_type','cass_ace_fips_st','cass_fipscounty','cass_geo_lat','cass_geo_long','cass_msa','cass_geo_blk','cass_geo_match','cass_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_seqnum_pcnt,le.populated_persistent_record_id_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_score_pcnt,le.populated_best_ssn_pcnt,le.populated_did_out_pcnt,le.populated_source_pcnt,le.populated_file_id_pcnt,le.populated_vendor_id_pcnt,le.populated_source_state_pcnt,le.populated_source_code_pcnt,le.populated_file_acquired_date_pcnt,le.populated__use_pcnt,le.populated_title_in_pcnt,le.populated_lname_in_pcnt,le.populated_fname_in_pcnt,le.populated_mname_in_pcnt,le.populated_maiden_prior_pcnt,le.populated_name_suffix_in_pcnt,le.populated_votefiller_pcnt,le.populated_source_voterid_pcnt,le.populated_dob_str_in_pcnt,le.populated_agecat_pcnt,le.populated_headhousehold_pcnt,le.populated_place_of_birth_pcnt,le.populated_occupation_pcnt,le.populated_maiden_name_pcnt,le.populated_motorvoterid_pcnt,le.populated_regsource_pcnt,le.populated_regdate_in_pcnt,le.populated_race_pcnt,le.populated_gender_pcnt,le.populated_poliparty_pcnt,le.populated_phone_pcnt,le.populated_work_phone_pcnt,le.populated_other_phone_pcnt,le.populated_active_status_pcnt,le.populated_votefiller2_pcnt,le.populated_active_other_pcnt,le.populated_voterstatus_pcnt,le.populated_resaddr1_pcnt,le.populated_resaddr2_pcnt,le.populated_res_city_pcnt,le.populated_res_state_pcnt,le.populated_res_zip_pcnt,le.populated_res_county_pcnt,le.populated_mail_addr1_pcnt,le.populated_mail_addr2_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_pcnt,le.populated_mail_county_pcnt,le.populated_addr_filler1_pcnt,le.populated_addr_filler2_pcnt,le.populated_city_filler_pcnt,le.populated_state_filler_pcnt,le.populated_zip_filler_pcnt,le.populated_county_filler_pcnt,le.populated_towncode_pcnt,le.populated_distcode_pcnt,le.populated_countycode_pcnt,le.populated_schoolcode_pcnt,le.populated_cityinout_pcnt,le.populated_spec_dist1_pcnt,le.populated_spec_dist2_pcnt,le.populated_precinct1_pcnt,le.populated_precinct2_pcnt,le.populated_precinct3_pcnt,le.populated_villageprecinct_pcnt,le.populated_schoolprecinct_pcnt,le.populated_ward_pcnt,le.populated_precinct_citytown_pcnt,le.populated_ancsmdindc_pcnt,le.populated_citycouncildist_pcnt,le.populated_countycommdist_pcnt,le.populated_statehouse_pcnt,le.populated_statesenate_pcnt,le.populated_ushouse_pcnt,le.populated_elemschooldist_pcnt,le.populated_schooldist_pcnt,le.populated_schoolfiller_pcnt,le.populated_commcolldist_pcnt,le.populated_dist_filler_pcnt,le.populated_municipal_pcnt,le.populated_villagedist_pcnt,le.populated_policejury_pcnt,le.populated_policedist_pcnt,le.populated_publicservcomm_pcnt,le.populated_rescue_pcnt,le.populated_fire_pcnt,le.populated_sanitary_pcnt,le.populated_sewerdist_pcnt,le.populated_waterdist_pcnt,le.populated_mosquitodist_pcnt,le.populated_taxdist_pcnt,le.populated_supremecourt_pcnt,le.populated_justiceofpeace_pcnt,le.populated_judicialdist_pcnt,le.populated_superiorctdist_pcnt,le.populated_appealsct_pcnt,le.populated_courtfiller_pcnt,le.populated_contributorparty_pcnt,le.populated_recptparty_pcnt,le.populated_dateofcontr_in_pcnt,le.populated_dollaramt_pcnt,le.populated_officecontto_pcnt,le.populated_cumuldollaramt_pcnt,le.populated_contfiller1_pcnt,le.populated_contfiller2_pcnt,le.populated_conttype_pcnt,le.populated_contfiller3_pcnt,le.populated_primary02_pcnt,le.populated_special02_pcnt,le.populated_other02_pcnt,le.populated_special202_pcnt,le.populated_general02_pcnt,le.populated_primary01_pcnt,le.populated_special01_pcnt,le.populated_other01_pcnt,le.populated_special201_pcnt,le.populated_general01_pcnt,le.populated_pres00_pcnt,le.populated_primary00_pcnt,le.populated_special00_pcnt,le.populated_other00_pcnt,le.populated_special200_pcnt,le.populated_general00_pcnt,le.populated_primary99_pcnt,le.populated_special99_pcnt,le.populated_other99_pcnt,le.populated_special299_pcnt,le.populated_general99_pcnt,le.populated_primary98_pcnt,le.populated_special98_pcnt,le.populated_other98_pcnt,le.populated_special298_pcnt,le.populated_general98_pcnt,le.populated_primary97_pcnt,le.populated_special97_pcnt,le.populated_other97_pcnt,le.populated_special297_pcnt,le.populated_general97_pcnt,le.populated_pres96_pcnt,le.populated_primary96_pcnt,le.populated_special96_pcnt,le.populated_other96_pcnt,le.populated_special296_pcnt,le.populated_general96_pcnt,le.populated_lastdayvote_in_pcnt,le.populated_historyfiller_pcnt,le.populated_huntfishperm_pcnt,le.populated_datelicense_in_pcnt,le.populated_homestate_pcnt,le.populated_resident_pcnt,le.populated_nonresident_pcnt,le.populated_hunt_pcnt,le.populated_fish_pcnt,le.populated_combosuper_pcnt,le.populated_sportsman_pcnt,le.populated_trap_pcnt,le.populated_archery_pcnt,le.populated_muzzle_pcnt,le.populated_drawing_pcnt,le.populated_day1_pcnt,le.populated_day3_pcnt,le.populated_day7_pcnt,le.populated_day14to15_pcnt,le.populated_dayfiller_pcnt,le.populated_seasonannual_pcnt,le.populated_lifetimepermit_pcnt,le.populated_landowner_pcnt,le.populated_family_pcnt,le.populated_junior_pcnt,le.populated_seniorcit_pcnt,le.populated_crewmemeber_pcnt,le.populated_retarded_pcnt,le.populated_indian_pcnt,le.populated_serviceman_pcnt,le.populated_disabled_pcnt,le.populated_lowincome_pcnt,le.populated_regioncounty_pcnt,le.populated_blind_pcnt,le.populated_huntfiller_pcnt,le.populated_salmon_pcnt,le.populated_freshwater_pcnt,le.populated_saltwater_pcnt,le.populated_lakesandresevoirs_pcnt,le.populated_setlinefish_pcnt,le.populated_trout_pcnt,le.populated_fallfishing_pcnt,le.populated_steelhead_pcnt,le.populated_whitejubherring_pcnt,le.populated_sturgeon_pcnt,le.populated_shellfishcrab_pcnt,le.populated_shellfishlobster_pcnt,le.populated_deer_pcnt,le.populated_bear_pcnt,le.populated_elk_pcnt,le.populated_moose_pcnt,le.populated_buffalo_pcnt,le.populated_antelope_pcnt,le.populated_sikebull_pcnt,le.populated_bighorn_pcnt,le.populated_javelina_pcnt,le.populated_cougar_pcnt,le.populated_anterless_pcnt,le.populated_pheasant_pcnt,le.populated_goose_pcnt,le.populated_duck_pcnt,le.populated_turkey_pcnt,le.populated_snowmobile_pcnt,le.populated_biggame_pcnt,le.populated_skipass_pcnt,le.populated_migbird_pcnt,le.populated_smallgame_pcnt,le.populated_sturgeon2_pcnt,le.populated_gun_pcnt,le.populated_bonus_pcnt,le.populated_lottery_pcnt,le.populated_otherbirds_pcnt,le.populated_huntfill1_pcnt,le.populated_boatindexnum_pcnt,le.populated_boatcoowner_pcnt,le.populated_hullidnum_pcnt,le.populated_yearmade_pcnt,le.populated_model_pcnt,le.populated_manufacturer_pcnt,le.populated_lengt_pcnt,le.populated_hullconstruct_pcnt,le.populated_primuse_pcnt,le.populated_fueltype_pcnt,le.populated_propulsion_pcnt,le.populated_modeltype_pcnt,le.populated_regexpdate_in_pcnt,le.populated_titlenum_pcnt,le.populated_stprimuse_pcnt,le.populated_titlestatus_pcnt,le.populated_vessel_pcnt,le.populated_specreg_pcnt,le.populated_boatfill1_pcnt,le.populated_boatfill2_pcnt,le.populated_boatfill3_pcnt,le.populated_ccwpermnum_pcnt,le.populated_ccwweapontype_pcnt,le.populated_ccwregdate_in_pcnt,le.populated_ccwexpdate_in_pcnt,le.populated_ccwpermtype_pcnt,le.populated_ccwfill1_pcnt,le.populated_ccwfill2_pcnt,le.populated_ccwfill3_pcnt,le.populated_ccwfill4_pcnt,le.populated_miscfill1_pcnt,le.populated_miscfill2_pcnt,le.populated_miscfill3_pcnt,le.populated_miscfill4_pcnt,le.populated_miscfill5_pcnt,le.populated_fillerother1_pcnt,le.populated_fillerother2_pcnt,le.populated_fillerother3_pcnt,le.populated_fillerother4_pcnt,le.populated_fillerother5_pcnt,le.populated_fillerother6_pcnt,le.populated_fillerother7_pcnt,le.populated_fillerother8_pcnt,le.populated_fillerother9_pcnt,le.populated_fillerother10_pcnt,le.populated_eor_pcnt,le.populated_stuff_pcnt,le.populated_dob_str_pcnt,le.populated_regdate_pcnt,le.populated_dateofcontr_pcnt,le.populated_lastdayvote_pcnt,le.populated_datelicense_pcnt,le.populated_regexpdate_pcnt,le.populated_ccwregdate_pcnt,le.populated_ccwexpdate_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_score_on_input_pcnt,le.populated_append_prep_resaddress1_pcnt,le.populated_append_prep_resaddress2_pcnt,le.populated_append_resrawaid_pcnt,le.populated_append_prep_mailaddress1_pcnt,le.populated_append_prep_mailaddress2_pcnt,le.populated_append_mailrawaid_pcnt,le.populated_append_prep_cassaddress1_pcnt,le.populated_append_prep_cassaddress2_pcnt,le.populated_append_cassrawaid_pcnt,le.populated_aid_resclean_prim_range_pcnt,le.populated_aid_resclean_predir_pcnt,le.populated_aid_resclean_prim_name_pcnt,le.populated_aid_resclean_addr_suffix_pcnt,le.populated_aid_resclean_postdir_pcnt,le.populated_aid_resclean_unit_desig_pcnt,le.populated_aid_resclean_sec_range_pcnt,le.populated_aid_resclean_p_city_name_pcnt,le.populated_aid_resclean_v_city_name_pcnt,le.populated_aid_resclean_st_pcnt,le.populated_aid_resclean_zip_pcnt,le.populated_aid_resclean_zip4_pcnt,le.populated_aid_resclean_cart_pcnt,le.populated_aid_resclean_cr_sort_sz_pcnt,le.populated_aid_resclean_lot_pcnt,le.populated_aid_resclean_lot_order_pcnt,le.populated_aid_resclean_dpbc_pcnt,le.populated_aid_resclean_chk_digit_pcnt,le.populated_aid_resclean_record_type_pcnt,le.populated_aid_resclean_ace_fips_st_pcnt,le.populated_aid_resclean_fipscounty_pcnt,le.populated_aid_resclean_geo_lat_pcnt,le.populated_aid_resclean_geo_long_pcnt,le.populated_aid_resclean_msa_pcnt,le.populated_aid_resclean_geo_blk_pcnt,le.populated_aid_resclean_geo_match_pcnt,le.populated_aid_resclean_err_stat_pcnt,le.populated_aid_mailclean_prim_range_pcnt,le.populated_aid_mailclean_predir_pcnt,le.populated_aid_mailclean_prim_name_pcnt,le.populated_aid_mailclean_addr_suffix_pcnt,le.populated_aid_mailclean_postdir_pcnt,le.populated_aid_mailclean_unit_desig_pcnt,le.populated_aid_mailclean_sec_range_pcnt,le.populated_aid_mailclean_p_city_name_pcnt,le.populated_aid_mailclean_v_city_name_pcnt,le.populated_aid_mailclean_st_pcnt,le.populated_aid_mailclean_zip_pcnt,le.populated_aid_mailclean_zip4_pcnt,le.populated_aid_mailclean_cart_pcnt,le.populated_aid_mailclean_cr_sort_sz_pcnt,le.populated_aid_mailclean_lot_pcnt,le.populated_aid_mailclean_lot_order_pcnt,le.populated_aid_mailclean_dpbc_pcnt,le.populated_aid_mailclean_chk_digit_pcnt,le.populated_aid_mailclean_record_type_pcnt,le.populated_aid_mailclean_ace_fips_st_pcnt,le.populated_aid_mailclean_fipscounty_pcnt,le.populated_aid_mailclean_geo_lat_pcnt,le.populated_aid_mailclean_geo_long_pcnt,le.populated_aid_mailclean_msa_pcnt,le.populated_aid_mailclean_geo_blk_pcnt,le.populated_aid_mailclean_geo_match_pcnt,le.populated_aid_mailclean_err_stat_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_record_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_mail_prim_range_pcnt,le.populated_mail_predir_pcnt,le.populated_mail_prim_name_pcnt,le.populated_mail_addr_suffix_pcnt,le.populated_mail_postdir_pcnt,le.populated_mail_unit_desig_pcnt,le.populated_mail_sec_range_pcnt,le.populated_mail_p_city_name_pcnt,le.populated_mail_v_city_name_pcnt,le.populated_mail_st_pcnt,le.populated_mail_ace_zip_pcnt,le.populated_mail_zip4_pcnt,le.populated_mail_cart_pcnt,le.populated_mail_cr_sort_sz_pcnt,le.populated_mail_lot_pcnt,le.populated_mail_lot_order_pcnt,le.populated_mail_dpbc_pcnt,le.populated_mail_chk_digit_pcnt,le.populated_mail_record_type_pcnt,le.populated_mail_ace_fips_st_pcnt,le.populated_mail_fipscounty_pcnt,le.populated_mail_geo_lat_pcnt,le.populated_mail_geo_long_pcnt,le.populated_mail_msa_pcnt,le.populated_mail_geo_blk_pcnt,le.populated_mail_geo_match_pcnt,le.populated_mail_err_stat_pcnt,le.populated_cass_prim_range_pcnt,le.populated_cass_predir_pcnt,le.populated_cass_prim_name_pcnt,le.populated_cass_addr_suffix_pcnt,le.populated_cass_postdir_pcnt,le.populated_cass_unit_desig_pcnt,le.populated_cass_sec_range_pcnt,le.populated_cass_p_city_name_pcnt,le.populated_cass_v_city_name_pcnt,le.populated_cass_st_pcnt,le.populated_cass_ace_zip_pcnt,le.populated_cass_zip4_pcnt,le.populated_cass_cart_pcnt,le.populated_cass_cr_sort_sz_pcnt,le.populated_cass_lot_pcnt,le.populated_cass_lot_order_pcnt,le.populated_cass_dpbc_pcnt,le.populated_cass_chk_digit_pcnt,le.populated_cass_record_type_pcnt,le.populated_cass_ace_fips_st_pcnt,le.populated_cass_fipscounty_pcnt,le.populated_cass_geo_lat_pcnt,le.populated_cass_geo_long_pcnt,le.populated_cass_msa_pcnt,le.populated_cass_geo_blk_pcnt,le.populated_cass_geo_match_pcnt,le.populated_cass_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_seqnum,le.maxlength_persistent_record_id,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_score,le.maxlength_best_ssn,le.maxlength_did_out,le.maxlength_source,le.maxlength_file_id,le.maxlength_vendor_id,le.maxlength_source_state,le.maxlength_source_code,le.maxlength_file_acquired_date,le.maxlength__use,le.maxlength_title_in,le.maxlength_lname_in,le.maxlength_fname_in,le.maxlength_mname_in,le.maxlength_maiden_prior,le.maxlength_name_suffix_in,le.maxlength_votefiller,le.maxlength_source_voterid,le.maxlength_dob_str_in,le.maxlength_agecat,le.maxlength_headhousehold,le.maxlength_place_of_birth,le.maxlength_occupation,le.maxlength_maiden_name,le.maxlength_motorvoterid,le.maxlength_regsource,le.maxlength_regdate_in,le.maxlength_race,le.maxlength_gender,le.maxlength_poliparty,le.maxlength_phone,le.maxlength_work_phone,le.maxlength_other_phone,le.maxlength_active_status,le.maxlength_votefiller2,le.maxlength_active_other,le.maxlength_voterstatus,le.maxlength_resaddr1,le.maxlength_resaddr2,le.maxlength_res_city,le.maxlength_res_state,le.maxlength_res_zip,le.maxlength_res_county,le.maxlength_mail_addr1,le.maxlength_mail_addr2,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip,le.maxlength_mail_county,le.maxlength_addr_filler1,le.maxlength_addr_filler2,le.maxlength_city_filler,le.maxlength_state_filler,le.maxlength_zip_filler,le.maxlength_county_filler,le.maxlength_towncode,le.maxlength_distcode,le.maxlength_countycode,le.maxlength_schoolcode,le.maxlength_cityinout,le.maxlength_spec_dist1,le.maxlength_spec_dist2,le.maxlength_precinct1,le.maxlength_precinct2,le.maxlength_precinct3,le.maxlength_villageprecinct,le.maxlength_schoolprecinct,le.maxlength_ward,le.maxlength_precinct_citytown,le.maxlength_ancsmdindc,le.maxlength_citycouncildist,le.maxlength_countycommdist,le.maxlength_statehouse,le.maxlength_statesenate,le.maxlength_ushouse,le.maxlength_elemschooldist,le.maxlength_schooldist,le.maxlength_schoolfiller,le.maxlength_commcolldist,le.maxlength_dist_filler,le.maxlength_municipal,le.maxlength_villagedist,le.maxlength_policejury,le.maxlength_policedist,le.maxlength_publicservcomm,le.maxlength_rescue,le.maxlength_fire,le.maxlength_sanitary,le.maxlength_sewerdist,le.maxlength_waterdist,le.maxlength_mosquitodist,le.maxlength_taxdist,le.maxlength_supremecourt,le.maxlength_justiceofpeace,le.maxlength_judicialdist,le.maxlength_superiorctdist,le.maxlength_appealsct,le.maxlength_courtfiller,le.maxlength_contributorparty,le.maxlength_recptparty,le.maxlength_dateofcontr_in,le.maxlength_dollaramt,le.maxlength_officecontto,le.maxlength_cumuldollaramt,le.maxlength_contfiller1,le.maxlength_contfiller2,le.maxlength_conttype,le.maxlength_contfiller3,le.maxlength_primary02,le.maxlength_special02,le.maxlength_other02,le.maxlength_special202,le.maxlength_general02,le.maxlength_primary01,le.maxlength_special01,le.maxlength_other01,le.maxlength_special201,le.maxlength_general01,le.maxlength_pres00,le.maxlength_primary00,le.maxlength_special00,le.maxlength_other00,le.maxlength_special200,le.maxlength_general00,le.maxlength_primary99,le.maxlength_special99,le.maxlength_other99,le.maxlength_special299,le.maxlength_general99,le.maxlength_primary98,le.maxlength_special98,le.maxlength_other98,le.maxlength_special298,le.maxlength_general98,le.maxlength_primary97,le.maxlength_special97,le.maxlength_other97,le.maxlength_special297,le.maxlength_general97,le.maxlength_pres96,le.maxlength_primary96,le.maxlength_special96,le.maxlength_other96,le.maxlength_special296,le.maxlength_general96,le.maxlength_lastdayvote_in,le.maxlength_historyfiller,le.maxlength_huntfishperm,le.maxlength_datelicense_in,le.maxlength_homestate,le.maxlength_resident,le.maxlength_nonresident,le.maxlength_hunt,le.maxlength_fish,le.maxlength_combosuper,le.maxlength_sportsman,le.maxlength_trap,le.maxlength_archery,le.maxlength_muzzle,le.maxlength_drawing,le.maxlength_day1,le.maxlength_day3,le.maxlength_day7,le.maxlength_day14to15,le.maxlength_dayfiller,le.maxlength_seasonannual,le.maxlength_lifetimepermit,le.maxlength_landowner,le.maxlength_family,le.maxlength_junior,le.maxlength_seniorcit,le.maxlength_crewmemeber,le.maxlength_retarded,le.maxlength_indian,le.maxlength_serviceman,le.maxlength_disabled,le.maxlength_lowincome,le.maxlength_regioncounty,le.maxlength_blind,le.maxlength_huntfiller,le.maxlength_salmon,le.maxlength_freshwater,le.maxlength_saltwater,le.maxlength_lakesandresevoirs,le.maxlength_setlinefish,le.maxlength_trout,le.maxlength_fallfishing,le.maxlength_steelhead,le.maxlength_whitejubherring,le.maxlength_sturgeon,le.maxlength_shellfishcrab,le.maxlength_shellfishlobster,le.maxlength_deer,le.maxlength_bear,le.maxlength_elk,le.maxlength_moose,le.maxlength_buffalo,le.maxlength_antelope,le.maxlength_sikebull,le.maxlength_bighorn,le.maxlength_javelina,le.maxlength_cougar,le.maxlength_anterless,le.maxlength_pheasant,le.maxlength_goose,le.maxlength_duck,le.maxlength_turkey,le.maxlength_snowmobile,le.maxlength_biggame,le.maxlength_skipass,le.maxlength_migbird,le.maxlength_smallgame,le.maxlength_sturgeon2,le.maxlength_gun,le.maxlength_bonus,le.maxlength_lottery,le.maxlength_otherbirds,le.maxlength_huntfill1,le.maxlength_boatindexnum,le.maxlength_boatcoowner,le.maxlength_hullidnum,le.maxlength_yearmade,le.maxlength_model,le.maxlength_manufacturer,le.maxlength_lengt,le.maxlength_hullconstruct,le.maxlength_primuse,le.maxlength_fueltype,le.maxlength_propulsion,le.maxlength_modeltype,le.maxlength_regexpdate_in,le.maxlength_titlenum,le.maxlength_stprimuse,le.maxlength_titlestatus,le.maxlength_vessel,le.maxlength_specreg,le.maxlength_boatfill1,le.maxlength_boatfill2,le.maxlength_boatfill3,le.maxlength_ccwpermnum,le.maxlength_ccwweapontype,le.maxlength_ccwregdate_in,le.maxlength_ccwexpdate_in,le.maxlength_ccwpermtype,le.maxlength_ccwfill1,le.maxlength_ccwfill2,le.maxlength_ccwfill3,le.maxlength_ccwfill4,le.maxlength_miscfill1,le.maxlength_miscfill2,le.maxlength_miscfill3,le.maxlength_miscfill4,le.maxlength_miscfill5,le.maxlength_fillerother1,le.maxlength_fillerother2,le.maxlength_fillerother3,le.maxlength_fillerother4,le.maxlength_fillerother5,le.maxlength_fillerother6,le.maxlength_fillerother7,le.maxlength_fillerother8,le.maxlength_fillerother9,le.maxlength_fillerother10,le.maxlength_eor,le.maxlength_stuff,le.maxlength_dob_str,le.maxlength_regdate,le.maxlength_dateofcontr,le.maxlength_lastdayvote,le.maxlength_datelicense,le.maxlength_regexpdate,le.maxlength_ccwregdate,le.maxlength_ccwexpdate,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_score_on_input,le.maxlength_append_prep_resaddress1,le.maxlength_append_prep_resaddress2,le.maxlength_append_resrawaid,le.maxlength_append_prep_mailaddress1,le.maxlength_append_prep_mailaddress2,le.maxlength_append_mailrawaid,le.maxlength_append_prep_cassaddress1,le.maxlength_append_prep_cassaddress2,le.maxlength_append_cassrawaid,le.maxlength_aid_resclean_prim_range,le.maxlength_aid_resclean_predir,le.maxlength_aid_resclean_prim_name,le.maxlength_aid_resclean_addr_suffix,le.maxlength_aid_resclean_postdir,le.maxlength_aid_resclean_unit_desig,le.maxlength_aid_resclean_sec_range,le.maxlength_aid_resclean_p_city_name,le.maxlength_aid_resclean_v_city_name,le.maxlength_aid_resclean_st,le.maxlength_aid_resclean_zip,le.maxlength_aid_resclean_zip4,le.maxlength_aid_resclean_cart,le.maxlength_aid_resclean_cr_sort_sz,le.maxlength_aid_resclean_lot,le.maxlength_aid_resclean_lot_order,le.maxlength_aid_resclean_dpbc,le.maxlength_aid_resclean_chk_digit,le.maxlength_aid_resclean_record_type,le.maxlength_aid_resclean_ace_fips_st,le.maxlength_aid_resclean_fipscounty,le.maxlength_aid_resclean_geo_lat,le.maxlength_aid_resclean_geo_long,le.maxlength_aid_resclean_msa,le.maxlength_aid_resclean_geo_blk,le.maxlength_aid_resclean_geo_match,le.maxlength_aid_resclean_err_stat,le.maxlength_aid_mailclean_prim_range,le.maxlength_aid_mailclean_predir,le.maxlength_aid_mailclean_prim_name,le.maxlength_aid_mailclean_addr_suffix,le.maxlength_aid_mailclean_postdir,le.maxlength_aid_mailclean_unit_desig,le.maxlength_aid_mailclean_sec_range,le.maxlength_aid_mailclean_p_city_name,le.maxlength_aid_mailclean_v_city_name,le.maxlength_aid_mailclean_st,le.maxlength_aid_mailclean_zip,le.maxlength_aid_mailclean_zip4,le.maxlength_aid_mailclean_cart,le.maxlength_aid_mailclean_cr_sort_sz,le.maxlength_aid_mailclean_lot,le.maxlength_aid_mailclean_lot_order,le.maxlength_aid_mailclean_dpbc,le.maxlength_aid_mailclean_chk_digit,le.maxlength_aid_mailclean_record_type,le.maxlength_aid_mailclean_ace_fips_st,le.maxlength_aid_mailclean_fipscounty,le.maxlength_aid_mailclean_geo_lat,le.maxlength_aid_mailclean_geo_long,le.maxlength_aid_mailclean_msa,le.maxlength_aid_mailclean_geo_blk,le.maxlength_aid_mailclean_geo_match,le.maxlength_aid_mailclean_err_stat,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_record_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_mail_prim_range,le.maxlength_mail_predir,le.maxlength_mail_prim_name,le.maxlength_mail_addr_suffix,le.maxlength_mail_postdir,le.maxlength_mail_unit_desig,le.maxlength_mail_sec_range,le.maxlength_mail_p_city_name,le.maxlength_mail_v_city_name,le.maxlength_mail_st,le.maxlength_mail_ace_zip,le.maxlength_mail_zip4,le.maxlength_mail_cart,le.maxlength_mail_cr_sort_sz,le.maxlength_mail_lot,le.maxlength_mail_lot_order,le.maxlength_mail_dpbc,le.maxlength_mail_chk_digit,le.maxlength_mail_record_type,le.maxlength_mail_ace_fips_st,le.maxlength_mail_fipscounty,le.maxlength_mail_geo_lat,le.maxlength_mail_geo_long,le.maxlength_mail_msa,le.maxlength_mail_geo_blk,le.maxlength_mail_geo_match,le.maxlength_mail_err_stat,le.maxlength_cass_prim_range,le.maxlength_cass_predir,le.maxlength_cass_prim_name,le.maxlength_cass_addr_suffix,le.maxlength_cass_postdir,le.maxlength_cass_unit_desig,le.maxlength_cass_sec_range,le.maxlength_cass_p_city_name,le.maxlength_cass_v_city_name,le.maxlength_cass_st,le.maxlength_cass_ace_zip,le.maxlength_cass_zip4,le.maxlength_cass_cart,le.maxlength_cass_cr_sort_sz,le.maxlength_cass_lot,le.maxlength_cass_lot_order,le.maxlength_cass_dpbc,le.maxlength_cass_chk_digit,le.maxlength_cass_record_type,le.maxlength_cass_ace_fips_st,le.maxlength_cass_fipscounty,le.maxlength_cass_geo_lat,le.maxlength_cass_geo_long,le.maxlength_cass_msa,le.maxlength_cass_geo_blk,le.maxlength_cass_geo_match,le.maxlength_cass_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_append_seqnum,le.avelength_persistent_record_id,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_score,le.avelength_best_ssn,le.avelength_did_out,le.avelength_source,le.avelength_file_id,le.avelength_vendor_id,le.avelength_source_state,le.avelength_source_code,le.avelength_file_acquired_date,le.avelength__use,le.avelength_title_in,le.avelength_lname_in,le.avelength_fname_in,le.avelength_mname_in,le.avelength_maiden_prior,le.avelength_name_suffix_in,le.avelength_votefiller,le.avelength_source_voterid,le.avelength_dob_str_in,le.avelength_agecat,le.avelength_headhousehold,le.avelength_place_of_birth,le.avelength_occupation,le.avelength_maiden_name,le.avelength_motorvoterid,le.avelength_regsource,le.avelength_regdate_in,le.avelength_race,le.avelength_gender,le.avelength_poliparty,le.avelength_phone,le.avelength_work_phone,le.avelength_other_phone,le.avelength_active_status,le.avelength_votefiller2,le.avelength_active_other,le.avelength_voterstatus,le.avelength_resaddr1,le.avelength_resaddr2,le.avelength_res_city,le.avelength_res_state,le.avelength_res_zip,le.avelength_res_county,le.avelength_mail_addr1,le.avelength_mail_addr2,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip,le.avelength_mail_county,le.avelength_addr_filler1,le.avelength_addr_filler2,le.avelength_city_filler,le.avelength_state_filler,le.avelength_zip_filler,le.avelength_county_filler,le.avelength_towncode,le.avelength_distcode,le.avelength_countycode,le.avelength_schoolcode,le.avelength_cityinout,le.avelength_spec_dist1,le.avelength_spec_dist2,le.avelength_precinct1,le.avelength_precinct2,le.avelength_precinct3,le.avelength_villageprecinct,le.avelength_schoolprecinct,le.avelength_ward,le.avelength_precinct_citytown,le.avelength_ancsmdindc,le.avelength_citycouncildist,le.avelength_countycommdist,le.avelength_statehouse,le.avelength_statesenate,le.avelength_ushouse,le.avelength_elemschooldist,le.avelength_schooldist,le.avelength_schoolfiller,le.avelength_commcolldist,le.avelength_dist_filler,le.avelength_municipal,le.avelength_villagedist,le.avelength_policejury,le.avelength_policedist,le.avelength_publicservcomm,le.avelength_rescue,le.avelength_fire,le.avelength_sanitary,le.avelength_sewerdist,le.avelength_waterdist,le.avelength_mosquitodist,le.avelength_taxdist,le.avelength_supremecourt,le.avelength_justiceofpeace,le.avelength_judicialdist,le.avelength_superiorctdist,le.avelength_appealsct,le.avelength_courtfiller,le.avelength_contributorparty,le.avelength_recptparty,le.avelength_dateofcontr_in,le.avelength_dollaramt,le.avelength_officecontto,le.avelength_cumuldollaramt,le.avelength_contfiller1,le.avelength_contfiller2,le.avelength_conttype,le.avelength_contfiller3,le.avelength_primary02,le.avelength_special02,le.avelength_other02,le.avelength_special202,le.avelength_general02,le.avelength_primary01,le.avelength_special01,le.avelength_other01,le.avelength_special201,le.avelength_general01,le.avelength_pres00,le.avelength_primary00,le.avelength_special00,le.avelength_other00,le.avelength_special200,le.avelength_general00,le.avelength_primary99,le.avelength_special99,le.avelength_other99,le.avelength_special299,le.avelength_general99,le.avelength_primary98,le.avelength_special98,le.avelength_other98,le.avelength_special298,le.avelength_general98,le.avelength_primary97,le.avelength_special97,le.avelength_other97,le.avelength_special297,le.avelength_general97,le.avelength_pres96,le.avelength_primary96,le.avelength_special96,le.avelength_other96,le.avelength_special296,le.avelength_general96,le.avelength_lastdayvote_in,le.avelength_historyfiller,le.avelength_huntfishperm,le.avelength_datelicense_in,le.avelength_homestate,le.avelength_resident,le.avelength_nonresident,le.avelength_hunt,le.avelength_fish,le.avelength_combosuper,le.avelength_sportsman,le.avelength_trap,le.avelength_archery,le.avelength_muzzle,le.avelength_drawing,le.avelength_day1,le.avelength_day3,le.avelength_day7,le.avelength_day14to15,le.avelength_dayfiller,le.avelength_seasonannual,le.avelength_lifetimepermit,le.avelength_landowner,le.avelength_family,le.avelength_junior,le.avelength_seniorcit,le.avelength_crewmemeber,le.avelength_retarded,le.avelength_indian,le.avelength_serviceman,le.avelength_disabled,le.avelength_lowincome,le.avelength_regioncounty,le.avelength_blind,le.avelength_huntfiller,le.avelength_salmon,le.avelength_freshwater,le.avelength_saltwater,le.avelength_lakesandresevoirs,le.avelength_setlinefish,le.avelength_trout,le.avelength_fallfishing,le.avelength_steelhead,le.avelength_whitejubherring,le.avelength_sturgeon,le.avelength_shellfishcrab,le.avelength_shellfishlobster,le.avelength_deer,le.avelength_bear,le.avelength_elk,le.avelength_moose,le.avelength_buffalo,le.avelength_antelope,le.avelength_sikebull,le.avelength_bighorn,le.avelength_javelina,le.avelength_cougar,le.avelength_anterless,le.avelength_pheasant,le.avelength_goose,le.avelength_duck,le.avelength_turkey,le.avelength_snowmobile,le.avelength_biggame,le.avelength_skipass,le.avelength_migbird,le.avelength_smallgame,le.avelength_sturgeon2,le.avelength_gun,le.avelength_bonus,le.avelength_lottery,le.avelength_otherbirds,le.avelength_huntfill1,le.avelength_boatindexnum,le.avelength_boatcoowner,le.avelength_hullidnum,le.avelength_yearmade,le.avelength_model,le.avelength_manufacturer,le.avelength_lengt,le.avelength_hullconstruct,le.avelength_primuse,le.avelength_fueltype,le.avelength_propulsion,le.avelength_modeltype,le.avelength_regexpdate_in,le.avelength_titlenum,le.avelength_stprimuse,le.avelength_titlestatus,le.avelength_vessel,le.avelength_specreg,le.avelength_boatfill1,le.avelength_boatfill2,le.avelength_boatfill3,le.avelength_ccwpermnum,le.avelength_ccwweapontype,le.avelength_ccwregdate_in,le.avelength_ccwexpdate_in,le.avelength_ccwpermtype,le.avelength_ccwfill1,le.avelength_ccwfill2,le.avelength_ccwfill3,le.avelength_ccwfill4,le.avelength_miscfill1,le.avelength_miscfill2,le.avelength_miscfill3,le.avelength_miscfill4,le.avelength_miscfill5,le.avelength_fillerother1,le.avelength_fillerother2,le.avelength_fillerother3,le.avelength_fillerother4,le.avelength_fillerother5,le.avelength_fillerother6,le.avelength_fillerother7,le.avelength_fillerother8,le.avelength_fillerother9,le.avelength_fillerother10,le.avelength_eor,le.avelength_stuff,le.avelength_dob_str,le.avelength_regdate,le.avelength_dateofcontr,le.avelength_lastdayvote,le.avelength_datelicense,le.avelength_regexpdate,le.avelength_ccwregdate,le.avelength_ccwexpdate,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_score_on_input,le.avelength_append_prep_resaddress1,le.avelength_append_prep_resaddress2,le.avelength_append_resrawaid,le.avelength_append_prep_mailaddress1,le.avelength_append_prep_mailaddress2,le.avelength_append_mailrawaid,le.avelength_append_prep_cassaddress1,le.avelength_append_prep_cassaddress2,le.avelength_append_cassrawaid,le.avelength_aid_resclean_prim_range,le.avelength_aid_resclean_predir,le.avelength_aid_resclean_prim_name,le.avelength_aid_resclean_addr_suffix,le.avelength_aid_resclean_postdir,le.avelength_aid_resclean_unit_desig,le.avelength_aid_resclean_sec_range,le.avelength_aid_resclean_p_city_name,le.avelength_aid_resclean_v_city_name,le.avelength_aid_resclean_st,le.avelength_aid_resclean_zip,le.avelength_aid_resclean_zip4,le.avelength_aid_resclean_cart,le.avelength_aid_resclean_cr_sort_sz,le.avelength_aid_resclean_lot,le.avelength_aid_resclean_lot_order,le.avelength_aid_resclean_dpbc,le.avelength_aid_resclean_chk_digit,le.avelength_aid_resclean_record_type,le.avelength_aid_resclean_ace_fips_st,le.avelength_aid_resclean_fipscounty,le.avelength_aid_resclean_geo_lat,le.avelength_aid_resclean_geo_long,le.avelength_aid_resclean_msa,le.avelength_aid_resclean_geo_blk,le.avelength_aid_resclean_geo_match,le.avelength_aid_resclean_err_stat,le.avelength_aid_mailclean_prim_range,le.avelength_aid_mailclean_predir,le.avelength_aid_mailclean_prim_name,le.avelength_aid_mailclean_addr_suffix,le.avelength_aid_mailclean_postdir,le.avelength_aid_mailclean_unit_desig,le.avelength_aid_mailclean_sec_range,le.avelength_aid_mailclean_p_city_name,le.avelength_aid_mailclean_v_city_name,le.avelength_aid_mailclean_st,le.avelength_aid_mailclean_zip,le.avelength_aid_mailclean_zip4,le.avelength_aid_mailclean_cart,le.avelength_aid_mailclean_cr_sort_sz,le.avelength_aid_mailclean_lot,le.avelength_aid_mailclean_lot_order,le.avelength_aid_mailclean_dpbc,le.avelength_aid_mailclean_chk_digit,le.avelength_aid_mailclean_record_type,le.avelength_aid_mailclean_ace_fips_st,le.avelength_aid_mailclean_fipscounty,le.avelength_aid_mailclean_geo_lat,le.avelength_aid_mailclean_geo_long,le.avelength_aid_mailclean_msa,le.avelength_aid_mailclean_geo_blk,le.avelength_aid_mailclean_geo_match,le.avelength_aid_mailclean_err_stat,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_record_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_mail_prim_range,le.avelength_mail_predir,le.avelength_mail_prim_name,le.avelength_mail_addr_suffix,le.avelength_mail_postdir,le.avelength_mail_unit_desig,le.avelength_mail_sec_range,le.avelength_mail_p_city_name,le.avelength_mail_v_city_name,le.avelength_mail_st,le.avelength_mail_ace_zip,le.avelength_mail_zip4,le.avelength_mail_cart,le.avelength_mail_cr_sort_sz,le.avelength_mail_lot,le.avelength_mail_lot_order,le.avelength_mail_dpbc,le.avelength_mail_chk_digit,le.avelength_mail_record_type,le.avelength_mail_ace_fips_st,le.avelength_mail_fipscounty,le.avelength_mail_geo_lat,le.avelength_mail_geo_long,le.avelength_mail_msa,le.avelength_mail_geo_blk,le.avelength_mail_geo_match,le.avelength_mail_err_stat,le.avelength_cass_prim_range,le.avelength_cass_predir,le.avelength_cass_prim_name,le.avelength_cass_addr_suffix,le.avelength_cass_postdir,le.avelength_cass_unit_desig,le.avelength_cass_sec_range,le.avelength_cass_p_city_name,le.avelength_cass_v_city_name,le.avelength_cass_st,le.avelength_cass_ace_zip,le.avelength_cass_zip4,le.avelength_cass_cart,le.avelength_cass_cr_sort_sz,le.avelength_cass_lot,le.avelength_cass_lot_order,le.avelength_cass_dpbc,le.avelength_cass_chk_digit,le.avelength_cass_record_type,le.avelength_cass_ace_fips_st,le.avelength_cass_fipscounty,le.avelength_cass_geo_lat,le.avelength_cass_geo_long,le.avelength_cass_msa,le.avelength_cass_geo_blk,le.avelength_cass_geo_match,le.avelength_cass_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 428, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.append_seqnum <> 0,TRIM((SALT311.StrType)le.append_seqnum), ''),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob_str_in),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate_in),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.addr_filler1),TRIM((SALT311.StrType)le.addr_filler2),TRIM((SALT311.StrType)le.city_filler),TRIM((SALT311.StrType)le.state_filler),TRIM((SALT311.StrType)le.zip_filler),TRIM((SALT311.StrType)le.county_filler),TRIM((SALT311.StrType)le.towncode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.cityinout),TRIM((SALT311.StrType)le.spec_dist1),TRIM((SALT311.StrType)le.spec_dist2),TRIM((SALT311.StrType)le.precinct1),TRIM((SALT311.StrType)le.precinct2),TRIM((SALT311.StrType)le.precinct3),TRIM((SALT311.StrType)le.villageprecinct),TRIM((SALT311.StrType)le.schoolprecinct),TRIM((SALT311.StrType)le.ward),TRIM((SALT311.StrType)le.precinct_citytown),TRIM((SALT311.StrType)le.ancsmdindc),TRIM((SALT311.StrType)le.citycouncildist),TRIM((SALT311.StrType)le.countycommdist),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.elemschooldist),TRIM((SALT311.StrType)le.schooldist),TRIM((SALT311.StrType)le.schoolfiller),TRIM((SALT311.StrType)le.commcolldist),TRIM((SALT311.StrType)le.dist_filler),TRIM((SALT311.StrType)le.municipal),TRIM((SALT311.StrType)le.villagedist),TRIM((SALT311.StrType)le.policejury),TRIM((SALT311.StrType)le.policedist),TRIM((SALT311.StrType)le.publicservcomm),TRIM((SALT311.StrType)le.rescue),TRIM((SALT311.StrType)le.fire),TRIM((SALT311.StrType)le.sanitary),TRIM((SALT311.StrType)le.sewerdist),TRIM((SALT311.StrType)le.waterdist),TRIM((SALT311.StrType)le.mosquitodist),TRIM((SALT311.StrType)le.taxdist),TRIM((SALT311.StrType)le.supremecourt),TRIM((SALT311.StrType)le.justiceofpeace),TRIM((SALT311.StrType)le.judicialdist),TRIM((SALT311.StrType)le.superiorctdist),TRIM((SALT311.StrType)le.appealsct),TRIM((SALT311.StrType)le.courtfiller),TRIM((SALT311.StrType)le.contributorparty),TRIM((SALT311.StrType)le.recptparty),TRIM((SALT311.StrType)le.dateofcontr_in),TRIM((SALT311.StrType)le.dollaramt),TRIM((SALT311.StrType)le.officecontto),TRIM((SALT311.StrType)le.cumuldollaramt),TRIM((SALT311.StrType)le.contfiller1),TRIM((SALT311.StrType)le.contfiller2),TRIM((SALT311.StrType)le.conttype),TRIM((SALT311.StrType)le.contfiller3),TRIM((SALT311.StrType)le.primary02),TRIM((SALT311.StrType)le.special02),TRIM((SALT311.StrType)le.other02),TRIM((SALT311.StrType)le.special202),TRIM((SALT311.StrType)le.general02),TRIM((SALT311.StrType)le.primary01),TRIM((SALT311.StrType)le.special01),TRIM((SALT311.StrType)le.other01),TRIM((SALT311.StrType)le.special201),TRIM((SALT311.StrType)le.general01),TRIM((SALT311.StrType)le.pres00),TRIM((SALT311.StrType)le.primary00),TRIM((SALT311.StrType)le.special00),TRIM((SALT311.StrType)le.other00),TRIM((SALT311.StrType)le.special200),TRIM((SALT311.StrType)le.general00),TRIM((SALT311.StrType)le.primary99),TRIM((SALT311.StrType)le.special99),TRIM((SALT311.StrType)le.other99),TRIM((SALT311.StrType)le.special299),TRIM((SALT311.StrType)le.general99),TRIM((SALT311.StrType)le.primary98),TRIM((SALT311.StrType)le.special98),TRIM((SALT311.StrType)le.other98),TRIM((SALT311.StrType)le.special298),TRIM((SALT311.StrType)le.general98),TRIM((SALT311.StrType)le.primary97),TRIM((SALT311.StrType)le.special97),TRIM((SALT311.StrType)le.other97),TRIM((SALT311.StrType)le.special297),TRIM((SALT311.StrType)le.general97),TRIM((SALT311.StrType)le.pres96),TRIM((SALT311.StrType)le.primary96),TRIM((SALT311.StrType)le.special96),TRIM((SALT311.StrType)le.other96),TRIM((SALT311.StrType)le.special296),TRIM((SALT311.StrType)le.general96),TRIM((SALT311.StrType)le.lastdayvote_in),TRIM((SALT311.StrType)le.historyfiller),TRIM((SALT311.StrType)le.huntfishperm),TRIM((SALT311.StrType)le.datelicense_in),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.resident),TRIM((SALT311.StrType)le.nonresident),TRIM((SALT311.StrType)le.hunt),TRIM((SALT311.StrType)le.fish),TRIM((SALT311.StrType)le.combosuper),TRIM((SALT311.StrType)le.sportsman),TRIM((SALT311.StrType)le.trap),TRIM((SALT311.StrType)le.archery),TRIM((SALT311.StrType)le.muzzle),TRIM((SALT311.StrType)le.drawing),TRIM((SALT311.StrType)le.day1),TRIM((SALT311.StrType)le.day3),TRIM((SALT311.StrType)le.day7),TRIM((SALT311.StrType)le.day14to15),TRIM((SALT311.StrType)le.dayfiller),TRIM((SALT311.StrType)le.seasonannual),TRIM((SALT311.StrType)le.lifetimepermit),TRIM((SALT311.StrType)le.landowner),TRIM((SALT311.StrType)le.family),TRIM((SALT311.StrType)le.junior),TRIM((SALT311.StrType)le.seniorcit),TRIM((SALT311.StrType)le.crewmemeber),TRIM((SALT311.StrType)le.retarded),TRIM((SALT311.StrType)le.indian),TRIM((SALT311.StrType)le.serviceman),TRIM((SALT311.StrType)le.disabled),TRIM((SALT311.StrType)le.lowincome),TRIM((SALT311.StrType)le.regioncounty),TRIM((SALT311.StrType)le.blind),TRIM((SALT311.StrType)le.huntfiller),TRIM((SALT311.StrType)le.salmon),TRIM((SALT311.StrType)le.freshwater),TRIM((SALT311.StrType)le.saltwater),TRIM((SALT311.StrType)le.lakesandresevoirs),TRIM((SALT311.StrType)le.setlinefish),TRIM((SALT311.StrType)le.trout),TRIM((SALT311.StrType)le.fallfishing),TRIM((SALT311.StrType)le.steelhead),TRIM((SALT311.StrType)le.whitejubherring),TRIM((SALT311.StrType)le.sturgeon),TRIM((SALT311.StrType)le.shellfishcrab),TRIM((SALT311.StrType)le.shellfishlobster),TRIM((SALT311.StrType)le.deer),TRIM((SALT311.StrType)le.bear),TRIM((SALT311.StrType)le.elk),TRIM((SALT311.StrType)le.moose),TRIM((SALT311.StrType)le.buffalo),TRIM((SALT311.StrType)le.antelope),TRIM((SALT311.StrType)le.sikebull),TRIM((SALT311.StrType)le.bighorn),TRIM((SALT311.StrType)le.javelina),TRIM((SALT311.StrType)le.cougar),TRIM((SALT311.StrType)le.anterless),TRIM((SALT311.StrType)le.pheasant),TRIM((SALT311.StrType)le.goose),TRIM((SALT311.StrType)le.duck),TRIM((SALT311.StrType)le.turkey),TRIM((SALT311.StrType)le.snowmobile),TRIM((SALT311.StrType)le.biggame),TRIM((SALT311.StrType)le.skipass),TRIM((SALT311.StrType)le.migbird),TRIM((SALT311.StrType)le.smallgame),TRIM((SALT311.StrType)le.sturgeon2),TRIM((SALT311.StrType)le.gun),TRIM((SALT311.StrType)le.bonus),TRIM((SALT311.StrType)le.lottery),TRIM((SALT311.StrType)le.otherbirds),TRIM((SALT311.StrType)le.huntfill1),TRIM((SALT311.StrType)le.boatindexnum),TRIM((SALT311.StrType)le.boatcoowner),TRIM((SALT311.StrType)le.hullidnum),TRIM((SALT311.StrType)le.yearmade),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.manufacturer),TRIM((SALT311.StrType)le.lengt),TRIM((SALT311.StrType)le.hullconstruct),TRIM((SALT311.StrType)le.primuse),TRIM((SALT311.StrType)le.fueltype),TRIM((SALT311.StrType)le.propulsion),TRIM((SALT311.StrType)le.modeltype),TRIM((SALT311.StrType)le.regexpdate_in),TRIM((SALT311.StrType)le.titlenum),TRIM((SALT311.StrType)le.stprimuse),TRIM((SALT311.StrType)le.titlestatus),TRIM((SALT311.StrType)le.vessel),TRIM((SALT311.StrType)le.specreg),TRIM((SALT311.StrType)le.boatfill1),TRIM((SALT311.StrType)le.boatfill2),TRIM((SALT311.StrType)le.boatfill3),TRIM((SALT311.StrType)le.ccwpermnum),TRIM((SALT311.StrType)le.ccwweapontype),TRIM((SALT311.StrType)le.ccwregdate_in),TRIM((SALT311.StrType)le.ccwexpdate_in),TRIM((SALT311.StrType)le.ccwpermtype),TRIM((SALT311.StrType)le.ccwfill1),TRIM((SALT311.StrType)le.ccwfill2),TRIM((SALT311.StrType)le.ccwfill3),TRIM((SALT311.StrType)le.ccwfill4),TRIM((SALT311.StrType)le.miscfill1),TRIM((SALT311.StrType)le.miscfill2),TRIM((SALT311.StrType)le.miscfill3),TRIM((SALT311.StrType)le.miscfill4),TRIM((SALT311.StrType)le.miscfill5),TRIM((SALT311.StrType)le.fillerother1),TRIM((SALT311.StrType)le.fillerother2),TRIM((SALT311.StrType)le.fillerother3),TRIM((SALT311.StrType)le.fillerother4),TRIM((SALT311.StrType)le.fillerother5),TRIM((SALT311.StrType)le.fillerother6),TRIM((SALT311.StrType)le.fillerother7),TRIM((SALT311.StrType)le.fillerother8),TRIM((SALT311.StrType)le.fillerother9),TRIM((SALT311.StrType)le.fillerother10),TRIM((SALT311.StrType)le.eor),TRIM((SALT311.StrType)le.stuff),TRIM((SALT311.StrType)le.dob_str),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.dateofcontr),TRIM((SALT311.StrType)le.lastdayvote),TRIM((SALT311.StrType)le.datelicense),TRIM((SALT311.StrType)le.regexpdate),TRIM((SALT311.StrType)le.ccwregdate),TRIM((SALT311.StrType)le.ccwexpdate),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.append_prep_resaddress1),TRIM((SALT311.StrType)le.append_prep_resaddress2),IF (le.append_resrawaid <> 0,TRIM((SALT311.StrType)le.append_resrawaid), ''),TRIM((SALT311.StrType)le.append_prep_mailaddress1),TRIM((SALT311.StrType)le.append_prep_mailaddress2),IF (le.append_mailrawaid <> 0,TRIM((SALT311.StrType)le.append_mailrawaid), ''),TRIM((SALT311.StrType)le.append_prep_cassaddress1),TRIM((SALT311.StrType)le.append_prep_cassaddress2),IF (le.append_cassrawaid <> 0,TRIM((SALT311.StrType)le.append_cassrawaid), ''),TRIM((SALT311.StrType)le.aid_resclean_prim_range),TRIM((SALT311.StrType)le.aid_resclean_predir),TRIM((SALT311.StrType)le.aid_resclean_prim_name),TRIM((SALT311.StrType)le.aid_resclean_addr_suffix),TRIM((SALT311.StrType)le.aid_resclean_postdir),TRIM((SALT311.StrType)le.aid_resclean_unit_desig),TRIM((SALT311.StrType)le.aid_resclean_sec_range),TRIM((SALT311.StrType)le.aid_resclean_p_city_name),TRIM((SALT311.StrType)le.aid_resclean_v_city_name),TRIM((SALT311.StrType)le.aid_resclean_st),TRIM((SALT311.StrType)le.aid_resclean_zip),TRIM((SALT311.StrType)le.aid_resclean_zip4),TRIM((SALT311.StrType)le.aid_resclean_cart),TRIM((SALT311.StrType)le.aid_resclean_cr_sort_sz),TRIM((SALT311.StrType)le.aid_resclean_lot),TRIM((SALT311.StrType)le.aid_resclean_lot_order),TRIM((SALT311.StrType)le.aid_resclean_dpbc),TRIM((SALT311.StrType)le.aid_resclean_chk_digit),TRIM((SALT311.StrType)le.aid_resclean_record_type),TRIM((SALT311.StrType)le.aid_resclean_ace_fips_st),TRIM((SALT311.StrType)le.aid_resclean_fipscounty),TRIM((SALT311.StrType)le.aid_resclean_geo_lat),TRIM((SALT311.StrType)le.aid_resclean_geo_long),TRIM((SALT311.StrType)le.aid_resclean_msa),TRIM((SALT311.StrType)le.aid_resclean_geo_blk),TRIM((SALT311.StrType)le.aid_resclean_geo_match),TRIM((SALT311.StrType)le.aid_resclean_err_stat),TRIM((SALT311.StrType)le.aid_mailclean_prim_range),TRIM((SALT311.StrType)le.aid_mailclean_predir),TRIM((SALT311.StrType)le.aid_mailclean_prim_name),TRIM((SALT311.StrType)le.aid_mailclean_addr_suffix),TRIM((SALT311.StrType)le.aid_mailclean_postdir),TRIM((SALT311.StrType)le.aid_mailclean_unit_desig),TRIM((SALT311.StrType)le.aid_mailclean_sec_range),TRIM((SALT311.StrType)le.aid_mailclean_p_city_name),TRIM((SALT311.StrType)le.aid_mailclean_v_city_name),TRIM((SALT311.StrType)le.aid_mailclean_st),TRIM((SALT311.StrType)le.aid_mailclean_zip),TRIM((SALT311.StrType)le.aid_mailclean_zip4),TRIM((SALT311.StrType)le.aid_mailclean_cart),TRIM((SALT311.StrType)le.aid_mailclean_cr_sort_sz),TRIM((SALT311.StrType)le.aid_mailclean_lot),TRIM((SALT311.StrType)le.aid_mailclean_lot_order),TRIM((SALT311.StrType)le.aid_mailclean_dpbc),TRIM((SALT311.StrType)le.aid_mailclean_chk_digit),TRIM((SALT311.StrType)le.aid_mailclean_record_type),TRIM((SALT311.StrType)le.aid_mailclean_ace_fips_st),TRIM((SALT311.StrType)le.aid_mailclean_fipscounty),TRIM((SALT311.StrType)le.aid_mailclean_geo_lat),TRIM((SALT311.StrType)le.aid_mailclean_geo_long),TRIM((SALT311.StrType)le.aid_mailclean_msa),TRIM((SALT311.StrType)le.aid_mailclean_geo_blk),TRIM((SALT311.StrType)le.aid_mailclean_geo_match),TRIM((SALT311.StrType)le.aid_mailclean_err_stat),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat),TRIM((SALT311.StrType)le.cass_prim_range),TRIM((SALT311.StrType)le.cass_predir),TRIM((SALT311.StrType)le.cass_prim_name),TRIM((SALT311.StrType)le.cass_addr_suffix),TRIM((SALT311.StrType)le.cass_postdir),TRIM((SALT311.StrType)le.cass_unit_desig),TRIM((SALT311.StrType)le.cass_sec_range),TRIM((SALT311.StrType)le.cass_p_city_name),TRIM((SALT311.StrType)le.cass_v_city_name),TRIM((SALT311.StrType)le.cass_st),TRIM((SALT311.StrType)le.cass_ace_zip),TRIM((SALT311.StrType)le.cass_zip4),TRIM((SALT311.StrType)le.cass_cart),TRIM((SALT311.StrType)le.cass_cr_sort_sz),TRIM((SALT311.StrType)le.cass_lot),TRIM((SALT311.StrType)le.cass_lot_order),TRIM((SALT311.StrType)le.cass_dpbc),TRIM((SALT311.StrType)le.cass_chk_digit),TRIM((SALT311.StrType)le.cass_record_type),TRIM((SALT311.StrType)le.cass_ace_fips_st),TRIM((SALT311.StrType)le.cass_fipscounty),TRIM((SALT311.StrType)le.cass_geo_lat),TRIM((SALT311.StrType)le.cass_geo_long),TRIM((SALT311.StrType)le.cass_msa),TRIM((SALT311.StrType)le.cass_geo_blk),TRIM((SALT311.StrType)le.cass_geo_match),TRIM((SALT311.StrType)le.cass_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,428,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 428);
  SELF.FldNo2 := 1 + (C % 428);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.append_seqnum <> 0,TRIM((SALT311.StrType)le.append_seqnum), ''),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob_str_in),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate_in),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.addr_filler1),TRIM((SALT311.StrType)le.addr_filler2),TRIM((SALT311.StrType)le.city_filler),TRIM((SALT311.StrType)le.state_filler),TRIM((SALT311.StrType)le.zip_filler),TRIM((SALT311.StrType)le.county_filler),TRIM((SALT311.StrType)le.towncode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.cityinout),TRIM((SALT311.StrType)le.spec_dist1),TRIM((SALT311.StrType)le.spec_dist2),TRIM((SALT311.StrType)le.precinct1),TRIM((SALT311.StrType)le.precinct2),TRIM((SALT311.StrType)le.precinct3),TRIM((SALT311.StrType)le.villageprecinct),TRIM((SALT311.StrType)le.schoolprecinct),TRIM((SALT311.StrType)le.ward),TRIM((SALT311.StrType)le.precinct_citytown),TRIM((SALT311.StrType)le.ancsmdindc),TRIM((SALT311.StrType)le.citycouncildist),TRIM((SALT311.StrType)le.countycommdist),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.elemschooldist),TRIM((SALT311.StrType)le.schooldist),TRIM((SALT311.StrType)le.schoolfiller),TRIM((SALT311.StrType)le.commcolldist),TRIM((SALT311.StrType)le.dist_filler),TRIM((SALT311.StrType)le.municipal),TRIM((SALT311.StrType)le.villagedist),TRIM((SALT311.StrType)le.policejury),TRIM((SALT311.StrType)le.policedist),TRIM((SALT311.StrType)le.publicservcomm),TRIM((SALT311.StrType)le.rescue),TRIM((SALT311.StrType)le.fire),TRIM((SALT311.StrType)le.sanitary),TRIM((SALT311.StrType)le.sewerdist),TRIM((SALT311.StrType)le.waterdist),TRIM((SALT311.StrType)le.mosquitodist),TRIM((SALT311.StrType)le.taxdist),TRIM((SALT311.StrType)le.supremecourt),TRIM((SALT311.StrType)le.justiceofpeace),TRIM((SALT311.StrType)le.judicialdist),TRIM((SALT311.StrType)le.superiorctdist),TRIM((SALT311.StrType)le.appealsct),TRIM((SALT311.StrType)le.courtfiller),TRIM((SALT311.StrType)le.contributorparty),TRIM((SALT311.StrType)le.recptparty),TRIM((SALT311.StrType)le.dateofcontr_in),TRIM((SALT311.StrType)le.dollaramt),TRIM((SALT311.StrType)le.officecontto),TRIM((SALT311.StrType)le.cumuldollaramt),TRIM((SALT311.StrType)le.contfiller1),TRIM((SALT311.StrType)le.contfiller2),TRIM((SALT311.StrType)le.conttype),TRIM((SALT311.StrType)le.contfiller3),TRIM((SALT311.StrType)le.primary02),TRIM((SALT311.StrType)le.special02),TRIM((SALT311.StrType)le.other02),TRIM((SALT311.StrType)le.special202),TRIM((SALT311.StrType)le.general02),TRIM((SALT311.StrType)le.primary01),TRIM((SALT311.StrType)le.special01),TRIM((SALT311.StrType)le.other01),TRIM((SALT311.StrType)le.special201),TRIM((SALT311.StrType)le.general01),TRIM((SALT311.StrType)le.pres00),TRIM((SALT311.StrType)le.primary00),TRIM((SALT311.StrType)le.special00),TRIM((SALT311.StrType)le.other00),TRIM((SALT311.StrType)le.special200),TRIM((SALT311.StrType)le.general00),TRIM((SALT311.StrType)le.primary99),TRIM((SALT311.StrType)le.special99),TRIM((SALT311.StrType)le.other99),TRIM((SALT311.StrType)le.special299),TRIM((SALT311.StrType)le.general99),TRIM((SALT311.StrType)le.primary98),TRIM((SALT311.StrType)le.special98),TRIM((SALT311.StrType)le.other98),TRIM((SALT311.StrType)le.special298),TRIM((SALT311.StrType)le.general98),TRIM((SALT311.StrType)le.primary97),TRIM((SALT311.StrType)le.special97),TRIM((SALT311.StrType)le.other97),TRIM((SALT311.StrType)le.special297),TRIM((SALT311.StrType)le.general97),TRIM((SALT311.StrType)le.pres96),TRIM((SALT311.StrType)le.primary96),TRIM((SALT311.StrType)le.special96),TRIM((SALT311.StrType)le.other96),TRIM((SALT311.StrType)le.special296),TRIM((SALT311.StrType)le.general96),TRIM((SALT311.StrType)le.lastdayvote_in),TRIM((SALT311.StrType)le.historyfiller),TRIM((SALT311.StrType)le.huntfishperm),TRIM((SALT311.StrType)le.datelicense_in),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.resident),TRIM((SALT311.StrType)le.nonresident),TRIM((SALT311.StrType)le.hunt),TRIM((SALT311.StrType)le.fish),TRIM((SALT311.StrType)le.combosuper),TRIM((SALT311.StrType)le.sportsman),TRIM((SALT311.StrType)le.trap),TRIM((SALT311.StrType)le.archery),TRIM((SALT311.StrType)le.muzzle),TRIM((SALT311.StrType)le.drawing),TRIM((SALT311.StrType)le.day1),TRIM((SALT311.StrType)le.day3),TRIM((SALT311.StrType)le.day7),TRIM((SALT311.StrType)le.day14to15),TRIM((SALT311.StrType)le.dayfiller),TRIM((SALT311.StrType)le.seasonannual),TRIM((SALT311.StrType)le.lifetimepermit),TRIM((SALT311.StrType)le.landowner),TRIM((SALT311.StrType)le.family),TRIM((SALT311.StrType)le.junior),TRIM((SALT311.StrType)le.seniorcit),TRIM((SALT311.StrType)le.crewmemeber),TRIM((SALT311.StrType)le.retarded),TRIM((SALT311.StrType)le.indian),TRIM((SALT311.StrType)le.serviceman),TRIM((SALT311.StrType)le.disabled),TRIM((SALT311.StrType)le.lowincome),TRIM((SALT311.StrType)le.regioncounty),TRIM((SALT311.StrType)le.blind),TRIM((SALT311.StrType)le.huntfiller),TRIM((SALT311.StrType)le.salmon),TRIM((SALT311.StrType)le.freshwater),TRIM((SALT311.StrType)le.saltwater),TRIM((SALT311.StrType)le.lakesandresevoirs),TRIM((SALT311.StrType)le.setlinefish),TRIM((SALT311.StrType)le.trout),TRIM((SALT311.StrType)le.fallfishing),TRIM((SALT311.StrType)le.steelhead),TRIM((SALT311.StrType)le.whitejubherring),TRIM((SALT311.StrType)le.sturgeon),TRIM((SALT311.StrType)le.shellfishcrab),TRIM((SALT311.StrType)le.shellfishlobster),TRIM((SALT311.StrType)le.deer),TRIM((SALT311.StrType)le.bear),TRIM((SALT311.StrType)le.elk),TRIM((SALT311.StrType)le.moose),TRIM((SALT311.StrType)le.buffalo),TRIM((SALT311.StrType)le.antelope),TRIM((SALT311.StrType)le.sikebull),TRIM((SALT311.StrType)le.bighorn),TRIM((SALT311.StrType)le.javelina),TRIM((SALT311.StrType)le.cougar),TRIM((SALT311.StrType)le.anterless),TRIM((SALT311.StrType)le.pheasant),TRIM((SALT311.StrType)le.goose),TRIM((SALT311.StrType)le.duck),TRIM((SALT311.StrType)le.turkey),TRIM((SALT311.StrType)le.snowmobile),TRIM((SALT311.StrType)le.biggame),TRIM((SALT311.StrType)le.skipass),TRIM((SALT311.StrType)le.migbird),TRIM((SALT311.StrType)le.smallgame),TRIM((SALT311.StrType)le.sturgeon2),TRIM((SALT311.StrType)le.gun),TRIM((SALT311.StrType)le.bonus),TRIM((SALT311.StrType)le.lottery),TRIM((SALT311.StrType)le.otherbirds),TRIM((SALT311.StrType)le.huntfill1),TRIM((SALT311.StrType)le.boatindexnum),TRIM((SALT311.StrType)le.boatcoowner),TRIM((SALT311.StrType)le.hullidnum),TRIM((SALT311.StrType)le.yearmade),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.manufacturer),TRIM((SALT311.StrType)le.lengt),TRIM((SALT311.StrType)le.hullconstruct),TRIM((SALT311.StrType)le.primuse),TRIM((SALT311.StrType)le.fueltype),TRIM((SALT311.StrType)le.propulsion),TRIM((SALT311.StrType)le.modeltype),TRIM((SALT311.StrType)le.regexpdate_in),TRIM((SALT311.StrType)le.titlenum),TRIM((SALT311.StrType)le.stprimuse),TRIM((SALT311.StrType)le.titlestatus),TRIM((SALT311.StrType)le.vessel),TRIM((SALT311.StrType)le.specreg),TRIM((SALT311.StrType)le.boatfill1),TRIM((SALT311.StrType)le.boatfill2),TRIM((SALT311.StrType)le.boatfill3),TRIM((SALT311.StrType)le.ccwpermnum),TRIM((SALT311.StrType)le.ccwweapontype),TRIM((SALT311.StrType)le.ccwregdate_in),TRIM((SALT311.StrType)le.ccwexpdate_in),TRIM((SALT311.StrType)le.ccwpermtype),TRIM((SALT311.StrType)le.ccwfill1),TRIM((SALT311.StrType)le.ccwfill2),TRIM((SALT311.StrType)le.ccwfill3),TRIM((SALT311.StrType)le.ccwfill4),TRIM((SALT311.StrType)le.miscfill1),TRIM((SALT311.StrType)le.miscfill2),TRIM((SALT311.StrType)le.miscfill3),TRIM((SALT311.StrType)le.miscfill4),TRIM((SALT311.StrType)le.miscfill5),TRIM((SALT311.StrType)le.fillerother1),TRIM((SALT311.StrType)le.fillerother2),TRIM((SALT311.StrType)le.fillerother3),TRIM((SALT311.StrType)le.fillerother4),TRIM((SALT311.StrType)le.fillerother5),TRIM((SALT311.StrType)le.fillerother6),TRIM((SALT311.StrType)le.fillerother7),TRIM((SALT311.StrType)le.fillerother8),TRIM((SALT311.StrType)le.fillerother9),TRIM((SALT311.StrType)le.fillerother10),TRIM((SALT311.StrType)le.eor),TRIM((SALT311.StrType)le.stuff),TRIM((SALT311.StrType)le.dob_str),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.dateofcontr),TRIM((SALT311.StrType)le.lastdayvote),TRIM((SALT311.StrType)le.datelicense),TRIM((SALT311.StrType)le.regexpdate),TRIM((SALT311.StrType)le.ccwregdate),TRIM((SALT311.StrType)le.ccwexpdate),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.append_prep_resaddress1),TRIM((SALT311.StrType)le.append_prep_resaddress2),IF (le.append_resrawaid <> 0,TRIM((SALT311.StrType)le.append_resrawaid), ''),TRIM((SALT311.StrType)le.append_prep_mailaddress1),TRIM((SALT311.StrType)le.append_prep_mailaddress2),IF (le.append_mailrawaid <> 0,TRIM((SALT311.StrType)le.append_mailrawaid), ''),TRIM((SALT311.StrType)le.append_prep_cassaddress1),TRIM((SALT311.StrType)le.append_prep_cassaddress2),IF (le.append_cassrawaid <> 0,TRIM((SALT311.StrType)le.append_cassrawaid), ''),TRIM((SALT311.StrType)le.aid_resclean_prim_range),TRIM((SALT311.StrType)le.aid_resclean_predir),TRIM((SALT311.StrType)le.aid_resclean_prim_name),TRIM((SALT311.StrType)le.aid_resclean_addr_suffix),TRIM((SALT311.StrType)le.aid_resclean_postdir),TRIM((SALT311.StrType)le.aid_resclean_unit_desig),TRIM((SALT311.StrType)le.aid_resclean_sec_range),TRIM((SALT311.StrType)le.aid_resclean_p_city_name),TRIM((SALT311.StrType)le.aid_resclean_v_city_name),TRIM((SALT311.StrType)le.aid_resclean_st),TRIM((SALT311.StrType)le.aid_resclean_zip),TRIM((SALT311.StrType)le.aid_resclean_zip4),TRIM((SALT311.StrType)le.aid_resclean_cart),TRIM((SALT311.StrType)le.aid_resclean_cr_sort_sz),TRIM((SALT311.StrType)le.aid_resclean_lot),TRIM((SALT311.StrType)le.aid_resclean_lot_order),TRIM((SALT311.StrType)le.aid_resclean_dpbc),TRIM((SALT311.StrType)le.aid_resclean_chk_digit),TRIM((SALT311.StrType)le.aid_resclean_record_type),TRIM((SALT311.StrType)le.aid_resclean_ace_fips_st),TRIM((SALT311.StrType)le.aid_resclean_fipscounty),TRIM((SALT311.StrType)le.aid_resclean_geo_lat),TRIM((SALT311.StrType)le.aid_resclean_geo_long),TRIM((SALT311.StrType)le.aid_resclean_msa),TRIM((SALT311.StrType)le.aid_resclean_geo_blk),TRIM((SALT311.StrType)le.aid_resclean_geo_match),TRIM((SALT311.StrType)le.aid_resclean_err_stat),TRIM((SALT311.StrType)le.aid_mailclean_prim_range),TRIM((SALT311.StrType)le.aid_mailclean_predir),TRIM((SALT311.StrType)le.aid_mailclean_prim_name),TRIM((SALT311.StrType)le.aid_mailclean_addr_suffix),TRIM((SALT311.StrType)le.aid_mailclean_postdir),TRIM((SALT311.StrType)le.aid_mailclean_unit_desig),TRIM((SALT311.StrType)le.aid_mailclean_sec_range),TRIM((SALT311.StrType)le.aid_mailclean_p_city_name),TRIM((SALT311.StrType)le.aid_mailclean_v_city_name),TRIM((SALT311.StrType)le.aid_mailclean_st),TRIM((SALT311.StrType)le.aid_mailclean_zip),TRIM((SALT311.StrType)le.aid_mailclean_zip4),TRIM((SALT311.StrType)le.aid_mailclean_cart),TRIM((SALT311.StrType)le.aid_mailclean_cr_sort_sz),TRIM((SALT311.StrType)le.aid_mailclean_lot),TRIM((SALT311.StrType)le.aid_mailclean_lot_order),TRIM((SALT311.StrType)le.aid_mailclean_dpbc),TRIM((SALT311.StrType)le.aid_mailclean_chk_digit),TRIM((SALT311.StrType)le.aid_mailclean_record_type),TRIM((SALT311.StrType)le.aid_mailclean_ace_fips_st),TRIM((SALT311.StrType)le.aid_mailclean_fipscounty),TRIM((SALT311.StrType)le.aid_mailclean_geo_lat),TRIM((SALT311.StrType)le.aid_mailclean_geo_long),TRIM((SALT311.StrType)le.aid_mailclean_msa),TRIM((SALT311.StrType)le.aid_mailclean_geo_blk),TRIM((SALT311.StrType)le.aid_mailclean_geo_match),TRIM((SALT311.StrType)le.aid_mailclean_err_stat),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat),TRIM((SALT311.StrType)le.cass_prim_range),TRIM((SALT311.StrType)le.cass_predir),TRIM((SALT311.StrType)le.cass_prim_name),TRIM((SALT311.StrType)le.cass_addr_suffix),TRIM((SALT311.StrType)le.cass_postdir),TRIM((SALT311.StrType)le.cass_unit_desig),TRIM((SALT311.StrType)le.cass_sec_range),TRIM((SALT311.StrType)le.cass_p_city_name),TRIM((SALT311.StrType)le.cass_v_city_name),TRIM((SALT311.StrType)le.cass_st),TRIM((SALT311.StrType)le.cass_ace_zip),TRIM((SALT311.StrType)le.cass_zip4),TRIM((SALT311.StrType)le.cass_cart),TRIM((SALT311.StrType)le.cass_cr_sort_sz),TRIM((SALT311.StrType)le.cass_lot),TRIM((SALT311.StrType)le.cass_lot_order),TRIM((SALT311.StrType)le.cass_dpbc),TRIM((SALT311.StrType)le.cass_chk_digit),TRIM((SALT311.StrType)le.cass_record_type),TRIM((SALT311.StrType)le.cass_ace_fips_st),TRIM((SALT311.StrType)le.cass_fipscounty),TRIM((SALT311.StrType)le.cass_geo_lat),TRIM((SALT311.StrType)le.cass_geo_long),TRIM((SALT311.StrType)le.cass_msa),TRIM((SALT311.StrType)le.cass_geo_blk),TRIM((SALT311.StrType)le.cass_geo_match),TRIM((SALT311.StrType)le.cass_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.append_seqnum <> 0,TRIM((SALT311.StrType)le.append_seqnum), ''),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob_str_in),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate_in),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.addr_filler1),TRIM((SALT311.StrType)le.addr_filler2),TRIM((SALT311.StrType)le.city_filler),TRIM((SALT311.StrType)le.state_filler),TRIM((SALT311.StrType)le.zip_filler),TRIM((SALT311.StrType)le.county_filler),TRIM((SALT311.StrType)le.towncode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.cityinout),TRIM((SALT311.StrType)le.spec_dist1),TRIM((SALT311.StrType)le.spec_dist2),TRIM((SALT311.StrType)le.precinct1),TRIM((SALT311.StrType)le.precinct2),TRIM((SALT311.StrType)le.precinct3),TRIM((SALT311.StrType)le.villageprecinct),TRIM((SALT311.StrType)le.schoolprecinct),TRIM((SALT311.StrType)le.ward),TRIM((SALT311.StrType)le.precinct_citytown),TRIM((SALT311.StrType)le.ancsmdindc),TRIM((SALT311.StrType)le.citycouncildist),TRIM((SALT311.StrType)le.countycommdist),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.elemschooldist),TRIM((SALT311.StrType)le.schooldist),TRIM((SALT311.StrType)le.schoolfiller),TRIM((SALT311.StrType)le.commcolldist),TRIM((SALT311.StrType)le.dist_filler),TRIM((SALT311.StrType)le.municipal),TRIM((SALT311.StrType)le.villagedist),TRIM((SALT311.StrType)le.policejury),TRIM((SALT311.StrType)le.policedist),TRIM((SALT311.StrType)le.publicservcomm),TRIM((SALT311.StrType)le.rescue),TRIM((SALT311.StrType)le.fire),TRIM((SALT311.StrType)le.sanitary),TRIM((SALT311.StrType)le.sewerdist),TRIM((SALT311.StrType)le.waterdist),TRIM((SALT311.StrType)le.mosquitodist),TRIM((SALT311.StrType)le.taxdist),TRIM((SALT311.StrType)le.supremecourt),TRIM((SALT311.StrType)le.justiceofpeace),TRIM((SALT311.StrType)le.judicialdist),TRIM((SALT311.StrType)le.superiorctdist),TRIM((SALT311.StrType)le.appealsct),TRIM((SALT311.StrType)le.courtfiller),TRIM((SALT311.StrType)le.contributorparty),TRIM((SALT311.StrType)le.recptparty),TRIM((SALT311.StrType)le.dateofcontr_in),TRIM((SALT311.StrType)le.dollaramt),TRIM((SALT311.StrType)le.officecontto),TRIM((SALT311.StrType)le.cumuldollaramt),TRIM((SALT311.StrType)le.contfiller1),TRIM((SALT311.StrType)le.contfiller2),TRIM((SALT311.StrType)le.conttype),TRIM((SALT311.StrType)le.contfiller3),TRIM((SALT311.StrType)le.primary02),TRIM((SALT311.StrType)le.special02),TRIM((SALT311.StrType)le.other02),TRIM((SALT311.StrType)le.special202),TRIM((SALT311.StrType)le.general02),TRIM((SALT311.StrType)le.primary01),TRIM((SALT311.StrType)le.special01),TRIM((SALT311.StrType)le.other01),TRIM((SALT311.StrType)le.special201),TRIM((SALT311.StrType)le.general01),TRIM((SALT311.StrType)le.pres00),TRIM((SALT311.StrType)le.primary00),TRIM((SALT311.StrType)le.special00),TRIM((SALT311.StrType)le.other00),TRIM((SALT311.StrType)le.special200),TRIM((SALT311.StrType)le.general00),TRIM((SALT311.StrType)le.primary99),TRIM((SALT311.StrType)le.special99),TRIM((SALT311.StrType)le.other99),TRIM((SALT311.StrType)le.special299),TRIM((SALT311.StrType)le.general99),TRIM((SALT311.StrType)le.primary98),TRIM((SALT311.StrType)le.special98),TRIM((SALT311.StrType)le.other98),TRIM((SALT311.StrType)le.special298),TRIM((SALT311.StrType)le.general98),TRIM((SALT311.StrType)le.primary97),TRIM((SALT311.StrType)le.special97),TRIM((SALT311.StrType)le.other97),TRIM((SALT311.StrType)le.special297),TRIM((SALT311.StrType)le.general97),TRIM((SALT311.StrType)le.pres96),TRIM((SALT311.StrType)le.primary96),TRIM((SALT311.StrType)le.special96),TRIM((SALT311.StrType)le.other96),TRIM((SALT311.StrType)le.special296),TRIM((SALT311.StrType)le.general96),TRIM((SALT311.StrType)le.lastdayvote_in),TRIM((SALT311.StrType)le.historyfiller),TRIM((SALT311.StrType)le.huntfishperm),TRIM((SALT311.StrType)le.datelicense_in),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.resident),TRIM((SALT311.StrType)le.nonresident),TRIM((SALT311.StrType)le.hunt),TRIM((SALT311.StrType)le.fish),TRIM((SALT311.StrType)le.combosuper),TRIM((SALT311.StrType)le.sportsman),TRIM((SALT311.StrType)le.trap),TRIM((SALT311.StrType)le.archery),TRIM((SALT311.StrType)le.muzzle),TRIM((SALT311.StrType)le.drawing),TRIM((SALT311.StrType)le.day1),TRIM((SALT311.StrType)le.day3),TRIM((SALT311.StrType)le.day7),TRIM((SALT311.StrType)le.day14to15),TRIM((SALT311.StrType)le.dayfiller),TRIM((SALT311.StrType)le.seasonannual),TRIM((SALT311.StrType)le.lifetimepermit),TRIM((SALT311.StrType)le.landowner),TRIM((SALT311.StrType)le.family),TRIM((SALT311.StrType)le.junior),TRIM((SALT311.StrType)le.seniorcit),TRIM((SALT311.StrType)le.crewmemeber),TRIM((SALT311.StrType)le.retarded),TRIM((SALT311.StrType)le.indian),TRIM((SALT311.StrType)le.serviceman),TRIM((SALT311.StrType)le.disabled),TRIM((SALT311.StrType)le.lowincome),TRIM((SALT311.StrType)le.regioncounty),TRIM((SALT311.StrType)le.blind),TRIM((SALT311.StrType)le.huntfiller),TRIM((SALT311.StrType)le.salmon),TRIM((SALT311.StrType)le.freshwater),TRIM((SALT311.StrType)le.saltwater),TRIM((SALT311.StrType)le.lakesandresevoirs),TRIM((SALT311.StrType)le.setlinefish),TRIM((SALT311.StrType)le.trout),TRIM((SALT311.StrType)le.fallfishing),TRIM((SALT311.StrType)le.steelhead),TRIM((SALT311.StrType)le.whitejubherring),TRIM((SALT311.StrType)le.sturgeon),TRIM((SALT311.StrType)le.shellfishcrab),TRIM((SALT311.StrType)le.shellfishlobster),TRIM((SALT311.StrType)le.deer),TRIM((SALT311.StrType)le.bear),TRIM((SALT311.StrType)le.elk),TRIM((SALT311.StrType)le.moose),TRIM((SALT311.StrType)le.buffalo),TRIM((SALT311.StrType)le.antelope),TRIM((SALT311.StrType)le.sikebull),TRIM((SALT311.StrType)le.bighorn),TRIM((SALT311.StrType)le.javelina),TRIM((SALT311.StrType)le.cougar),TRIM((SALT311.StrType)le.anterless),TRIM((SALT311.StrType)le.pheasant),TRIM((SALT311.StrType)le.goose),TRIM((SALT311.StrType)le.duck),TRIM((SALT311.StrType)le.turkey),TRIM((SALT311.StrType)le.snowmobile),TRIM((SALT311.StrType)le.biggame),TRIM((SALT311.StrType)le.skipass),TRIM((SALT311.StrType)le.migbird),TRIM((SALT311.StrType)le.smallgame),TRIM((SALT311.StrType)le.sturgeon2),TRIM((SALT311.StrType)le.gun),TRIM((SALT311.StrType)le.bonus),TRIM((SALT311.StrType)le.lottery),TRIM((SALT311.StrType)le.otherbirds),TRIM((SALT311.StrType)le.huntfill1),TRIM((SALT311.StrType)le.boatindexnum),TRIM((SALT311.StrType)le.boatcoowner),TRIM((SALT311.StrType)le.hullidnum),TRIM((SALT311.StrType)le.yearmade),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.manufacturer),TRIM((SALT311.StrType)le.lengt),TRIM((SALT311.StrType)le.hullconstruct),TRIM((SALT311.StrType)le.primuse),TRIM((SALT311.StrType)le.fueltype),TRIM((SALT311.StrType)le.propulsion),TRIM((SALT311.StrType)le.modeltype),TRIM((SALT311.StrType)le.regexpdate_in),TRIM((SALT311.StrType)le.titlenum),TRIM((SALT311.StrType)le.stprimuse),TRIM((SALT311.StrType)le.titlestatus),TRIM((SALT311.StrType)le.vessel),TRIM((SALT311.StrType)le.specreg),TRIM((SALT311.StrType)le.boatfill1),TRIM((SALT311.StrType)le.boatfill2),TRIM((SALT311.StrType)le.boatfill3),TRIM((SALT311.StrType)le.ccwpermnum),TRIM((SALT311.StrType)le.ccwweapontype),TRIM((SALT311.StrType)le.ccwregdate_in),TRIM((SALT311.StrType)le.ccwexpdate_in),TRIM((SALT311.StrType)le.ccwpermtype),TRIM((SALT311.StrType)le.ccwfill1),TRIM((SALT311.StrType)le.ccwfill2),TRIM((SALT311.StrType)le.ccwfill3),TRIM((SALT311.StrType)le.ccwfill4),TRIM((SALT311.StrType)le.miscfill1),TRIM((SALT311.StrType)le.miscfill2),TRIM((SALT311.StrType)le.miscfill3),TRIM((SALT311.StrType)le.miscfill4),TRIM((SALT311.StrType)le.miscfill5),TRIM((SALT311.StrType)le.fillerother1),TRIM((SALT311.StrType)le.fillerother2),TRIM((SALT311.StrType)le.fillerother3),TRIM((SALT311.StrType)le.fillerother4),TRIM((SALT311.StrType)le.fillerother5),TRIM((SALT311.StrType)le.fillerother6),TRIM((SALT311.StrType)le.fillerother7),TRIM((SALT311.StrType)le.fillerother8),TRIM((SALT311.StrType)le.fillerother9),TRIM((SALT311.StrType)le.fillerother10),TRIM((SALT311.StrType)le.eor),TRIM((SALT311.StrType)le.stuff),TRIM((SALT311.StrType)le.dob_str),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.dateofcontr),TRIM((SALT311.StrType)le.lastdayvote),TRIM((SALT311.StrType)le.datelicense),TRIM((SALT311.StrType)le.regexpdate),TRIM((SALT311.StrType)le.ccwregdate),TRIM((SALT311.StrType)le.ccwexpdate),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.append_prep_resaddress1),TRIM((SALT311.StrType)le.append_prep_resaddress2),IF (le.append_resrawaid <> 0,TRIM((SALT311.StrType)le.append_resrawaid), ''),TRIM((SALT311.StrType)le.append_prep_mailaddress1),TRIM((SALT311.StrType)le.append_prep_mailaddress2),IF (le.append_mailrawaid <> 0,TRIM((SALT311.StrType)le.append_mailrawaid), ''),TRIM((SALT311.StrType)le.append_prep_cassaddress1),TRIM((SALT311.StrType)le.append_prep_cassaddress2),IF (le.append_cassrawaid <> 0,TRIM((SALT311.StrType)le.append_cassrawaid), ''),TRIM((SALT311.StrType)le.aid_resclean_prim_range),TRIM((SALT311.StrType)le.aid_resclean_predir),TRIM((SALT311.StrType)le.aid_resclean_prim_name),TRIM((SALT311.StrType)le.aid_resclean_addr_suffix),TRIM((SALT311.StrType)le.aid_resclean_postdir),TRIM((SALT311.StrType)le.aid_resclean_unit_desig),TRIM((SALT311.StrType)le.aid_resclean_sec_range),TRIM((SALT311.StrType)le.aid_resclean_p_city_name),TRIM((SALT311.StrType)le.aid_resclean_v_city_name),TRIM((SALT311.StrType)le.aid_resclean_st),TRIM((SALT311.StrType)le.aid_resclean_zip),TRIM((SALT311.StrType)le.aid_resclean_zip4),TRIM((SALT311.StrType)le.aid_resclean_cart),TRIM((SALT311.StrType)le.aid_resclean_cr_sort_sz),TRIM((SALT311.StrType)le.aid_resclean_lot),TRIM((SALT311.StrType)le.aid_resclean_lot_order),TRIM((SALT311.StrType)le.aid_resclean_dpbc),TRIM((SALT311.StrType)le.aid_resclean_chk_digit),TRIM((SALT311.StrType)le.aid_resclean_record_type),TRIM((SALT311.StrType)le.aid_resclean_ace_fips_st),TRIM((SALT311.StrType)le.aid_resclean_fipscounty),TRIM((SALT311.StrType)le.aid_resclean_geo_lat),TRIM((SALT311.StrType)le.aid_resclean_geo_long),TRIM((SALT311.StrType)le.aid_resclean_msa),TRIM((SALT311.StrType)le.aid_resclean_geo_blk),TRIM((SALT311.StrType)le.aid_resclean_geo_match),TRIM((SALT311.StrType)le.aid_resclean_err_stat),TRIM((SALT311.StrType)le.aid_mailclean_prim_range),TRIM((SALT311.StrType)le.aid_mailclean_predir),TRIM((SALT311.StrType)le.aid_mailclean_prim_name),TRIM((SALT311.StrType)le.aid_mailclean_addr_suffix),TRIM((SALT311.StrType)le.aid_mailclean_postdir),TRIM((SALT311.StrType)le.aid_mailclean_unit_desig),TRIM((SALT311.StrType)le.aid_mailclean_sec_range),TRIM((SALT311.StrType)le.aid_mailclean_p_city_name),TRIM((SALT311.StrType)le.aid_mailclean_v_city_name),TRIM((SALT311.StrType)le.aid_mailclean_st),TRIM((SALT311.StrType)le.aid_mailclean_zip),TRIM((SALT311.StrType)le.aid_mailclean_zip4),TRIM((SALT311.StrType)le.aid_mailclean_cart),TRIM((SALT311.StrType)le.aid_mailclean_cr_sort_sz),TRIM((SALT311.StrType)le.aid_mailclean_lot),TRIM((SALT311.StrType)le.aid_mailclean_lot_order),TRIM((SALT311.StrType)le.aid_mailclean_dpbc),TRIM((SALT311.StrType)le.aid_mailclean_chk_digit),TRIM((SALT311.StrType)le.aid_mailclean_record_type),TRIM((SALT311.StrType)le.aid_mailclean_ace_fips_st),TRIM((SALT311.StrType)le.aid_mailclean_fipscounty),TRIM((SALT311.StrType)le.aid_mailclean_geo_lat),TRIM((SALT311.StrType)le.aid_mailclean_geo_long),TRIM((SALT311.StrType)le.aid_mailclean_msa),TRIM((SALT311.StrType)le.aid_mailclean_geo_blk),TRIM((SALT311.StrType)le.aid_mailclean_geo_match),TRIM((SALT311.StrType)le.aid_mailclean_err_stat),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat),TRIM((SALT311.StrType)le.cass_prim_range),TRIM((SALT311.StrType)le.cass_predir),TRIM((SALT311.StrType)le.cass_prim_name),TRIM((SALT311.StrType)le.cass_addr_suffix),TRIM((SALT311.StrType)le.cass_postdir),TRIM((SALT311.StrType)le.cass_unit_desig),TRIM((SALT311.StrType)le.cass_sec_range),TRIM((SALT311.StrType)le.cass_p_city_name),TRIM((SALT311.StrType)le.cass_v_city_name),TRIM((SALT311.StrType)le.cass_st),TRIM((SALT311.StrType)le.cass_ace_zip),TRIM((SALT311.StrType)le.cass_zip4),TRIM((SALT311.StrType)le.cass_cart),TRIM((SALT311.StrType)le.cass_cr_sort_sz),TRIM((SALT311.StrType)le.cass_lot),TRIM((SALT311.StrType)le.cass_lot_order),TRIM((SALT311.StrType)le.cass_dpbc),TRIM((SALT311.StrType)le.cass_chk_digit),TRIM((SALT311.StrType)le.cass_record_type),TRIM((SALT311.StrType)le.cass_ace_fips_st),TRIM((SALT311.StrType)le.cass_fipscounty),TRIM((SALT311.StrType)le.cass_geo_lat),TRIM((SALT311.StrType)le.cass_geo_long),TRIM((SALT311.StrType)le.cass_msa),TRIM((SALT311.StrType)le.cass_geo_blk),TRIM((SALT311.StrType)le.cass_geo_match),TRIM((SALT311.StrType)le.cass_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),428*428,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_seqnum'}
      ,{2,'persistent_record_id'}
      ,{3,'process_date'}
      ,{4,'date_first_seen'}
      ,{5,'date_last_seen'}
      ,{6,'score'}
      ,{7,'best_ssn'}
      ,{8,'did_out'}
      ,{9,'source'}
      ,{10,'file_id'}
      ,{11,'vendor_id'}
      ,{12,'source_state'}
      ,{13,'source_code'}
      ,{14,'file_acquired_date'}
      ,{15,'_use'}
      ,{16,'title_in'}
      ,{17,'lname_in'}
      ,{18,'fname_in'}
      ,{19,'mname_in'}
      ,{20,'maiden_prior'}
      ,{21,'name_suffix_in'}
      ,{22,'votefiller'}
      ,{23,'source_voterid'}
      ,{24,'dob_str_in'}
      ,{25,'agecat'}
      ,{26,'headhousehold'}
      ,{27,'place_of_birth'}
      ,{28,'occupation'}
      ,{29,'maiden_name'}
      ,{30,'motorvoterid'}
      ,{31,'regsource'}
      ,{32,'regdate_in'}
      ,{33,'race'}
      ,{34,'gender'}
      ,{35,'poliparty'}
      ,{36,'phone'}
      ,{37,'work_phone'}
      ,{38,'other_phone'}
      ,{39,'active_status'}
      ,{40,'votefiller2'}
      ,{41,'active_other'}
      ,{42,'voterstatus'}
      ,{43,'resaddr1'}
      ,{44,'resaddr2'}
      ,{45,'res_city'}
      ,{46,'res_state'}
      ,{47,'res_zip'}
      ,{48,'res_county'}
      ,{49,'mail_addr1'}
      ,{50,'mail_addr2'}
      ,{51,'mail_city'}
      ,{52,'mail_state'}
      ,{53,'mail_zip'}
      ,{54,'mail_county'}
      ,{55,'addr_filler1'}
      ,{56,'addr_filler2'}
      ,{57,'city_filler'}
      ,{58,'state_filler'}
      ,{59,'zip_filler'}
      ,{60,'county_filler'}
      ,{61,'towncode'}
      ,{62,'distcode'}
      ,{63,'countycode'}
      ,{64,'schoolcode'}
      ,{65,'cityinout'}
      ,{66,'spec_dist1'}
      ,{67,'spec_dist2'}
      ,{68,'precinct1'}
      ,{69,'precinct2'}
      ,{70,'precinct3'}
      ,{71,'villageprecinct'}
      ,{72,'schoolprecinct'}
      ,{73,'ward'}
      ,{74,'precinct_citytown'}
      ,{75,'ancsmdindc'}
      ,{76,'citycouncildist'}
      ,{77,'countycommdist'}
      ,{78,'statehouse'}
      ,{79,'statesenate'}
      ,{80,'ushouse'}
      ,{81,'elemschooldist'}
      ,{82,'schooldist'}
      ,{83,'schoolfiller'}
      ,{84,'commcolldist'}
      ,{85,'dist_filler'}
      ,{86,'municipal'}
      ,{87,'villagedist'}
      ,{88,'policejury'}
      ,{89,'policedist'}
      ,{90,'publicservcomm'}
      ,{91,'rescue'}
      ,{92,'fire'}
      ,{93,'sanitary'}
      ,{94,'sewerdist'}
      ,{95,'waterdist'}
      ,{96,'mosquitodist'}
      ,{97,'taxdist'}
      ,{98,'supremecourt'}
      ,{99,'justiceofpeace'}
      ,{100,'judicialdist'}
      ,{101,'superiorctdist'}
      ,{102,'appealsct'}
      ,{103,'courtfiller'}
      ,{104,'contributorparty'}
      ,{105,'recptparty'}
      ,{106,'dateofcontr_in'}
      ,{107,'dollaramt'}
      ,{108,'officecontto'}
      ,{109,'cumuldollaramt'}
      ,{110,'contfiller1'}
      ,{111,'contfiller2'}
      ,{112,'conttype'}
      ,{113,'contfiller3'}
      ,{114,'primary02'}
      ,{115,'special02'}
      ,{116,'other02'}
      ,{117,'special202'}
      ,{118,'general02'}
      ,{119,'primary01'}
      ,{120,'special01'}
      ,{121,'other01'}
      ,{122,'special201'}
      ,{123,'general01'}
      ,{124,'pres00'}
      ,{125,'primary00'}
      ,{126,'special00'}
      ,{127,'other00'}
      ,{128,'special200'}
      ,{129,'general00'}
      ,{130,'primary99'}
      ,{131,'special99'}
      ,{132,'other99'}
      ,{133,'special299'}
      ,{134,'general99'}
      ,{135,'primary98'}
      ,{136,'special98'}
      ,{137,'other98'}
      ,{138,'special298'}
      ,{139,'general98'}
      ,{140,'primary97'}
      ,{141,'special97'}
      ,{142,'other97'}
      ,{143,'special297'}
      ,{144,'general97'}
      ,{145,'pres96'}
      ,{146,'primary96'}
      ,{147,'special96'}
      ,{148,'other96'}
      ,{149,'special296'}
      ,{150,'general96'}
      ,{151,'lastdayvote_in'}
      ,{152,'historyfiller'}
      ,{153,'huntfishperm'}
      ,{154,'datelicense_in'}
      ,{155,'homestate'}
      ,{156,'resident'}
      ,{157,'nonresident'}
      ,{158,'hunt'}
      ,{159,'fish'}
      ,{160,'combosuper'}
      ,{161,'sportsman'}
      ,{162,'trap'}
      ,{163,'archery'}
      ,{164,'muzzle'}
      ,{165,'drawing'}
      ,{166,'day1'}
      ,{167,'day3'}
      ,{168,'day7'}
      ,{169,'day14to15'}
      ,{170,'dayfiller'}
      ,{171,'seasonannual'}
      ,{172,'lifetimepermit'}
      ,{173,'landowner'}
      ,{174,'family'}
      ,{175,'junior'}
      ,{176,'seniorcit'}
      ,{177,'crewmemeber'}
      ,{178,'retarded'}
      ,{179,'indian'}
      ,{180,'serviceman'}
      ,{181,'disabled'}
      ,{182,'lowincome'}
      ,{183,'regioncounty'}
      ,{184,'blind'}
      ,{185,'huntfiller'}
      ,{186,'salmon'}
      ,{187,'freshwater'}
      ,{188,'saltwater'}
      ,{189,'lakesandresevoirs'}
      ,{190,'setlinefish'}
      ,{191,'trout'}
      ,{192,'fallfishing'}
      ,{193,'steelhead'}
      ,{194,'whitejubherring'}
      ,{195,'sturgeon'}
      ,{196,'shellfishcrab'}
      ,{197,'shellfishlobster'}
      ,{198,'deer'}
      ,{199,'bear'}
      ,{200,'elk'}
      ,{201,'moose'}
      ,{202,'buffalo'}
      ,{203,'antelope'}
      ,{204,'sikebull'}
      ,{205,'bighorn'}
      ,{206,'javelina'}
      ,{207,'cougar'}
      ,{208,'anterless'}
      ,{209,'pheasant'}
      ,{210,'goose'}
      ,{211,'duck'}
      ,{212,'turkey'}
      ,{213,'snowmobile'}
      ,{214,'biggame'}
      ,{215,'skipass'}
      ,{216,'migbird'}
      ,{217,'smallgame'}
      ,{218,'sturgeon2'}
      ,{219,'gun'}
      ,{220,'bonus'}
      ,{221,'lottery'}
      ,{222,'otherbirds'}
      ,{223,'huntfill1'}
      ,{224,'boatindexnum'}
      ,{225,'boatcoowner'}
      ,{226,'hullidnum'}
      ,{227,'yearmade'}
      ,{228,'model'}
      ,{229,'manufacturer'}
      ,{230,'lengt'}
      ,{231,'hullconstruct'}
      ,{232,'primuse'}
      ,{233,'fueltype'}
      ,{234,'propulsion'}
      ,{235,'modeltype'}
      ,{236,'regexpdate_in'}
      ,{237,'titlenum'}
      ,{238,'stprimuse'}
      ,{239,'titlestatus'}
      ,{240,'vessel'}
      ,{241,'specreg'}
      ,{242,'boatfill1'}
      ,{243,'boatfill2'}
      ,{244,'boatfill3'}
      ,{245,'ccwpermnum'}
      ,{246,'ccwweapontype'}
      ,{247,'ccwregdate_in'}
      ,{248,'ccwexpdate_in'}
      ,{249,'ccwpermtype'}
      ,{250,'ccwfill1'}
      ,{251,'ccwfill2'}
      ,{252,'ccwfill3'}
      ,{253,'ccwfill4'}
      ,{254,'miscfill1'}
      ,{255,'miscfill2'}
      ,{256,'miscfill3'}
      ,{257,'miscfill4'}
      ,{258,'miscfill5'}
      ,{259,'fillerother1'}
      ,{260,'fillerother2'}
      ,{261,'fillerother3'}
      ,{262,'fillerother4'}
      ,{263,'fillerother5'}
      ,{264,'fillerother6'}
      ,{265,'fillerother7'}
      ,{266,'fillerother8'}
      ,{267,'fillerother9'}
      ,{268,'fillerother10'}
      ,{269,'eor'}
      ,{270,'stuff'}
      ,{271,'dob_str'}
      ,{272,'regdate'}
      ,{273,'dateofcontr'}
      ,{274,'lastdayvote'}
      ,{275,'datelicense'}
      ,{276,'regexpdate'}
      ,{277,'ccwregdate'}
      ,{278,'ccwexpdate'}
      ,{279,'title'}
      ,{280,'fname'}
      ,{281,'mname'}
      ,{282,'lname'}
      ,{283,'name_suffix'}
      ,{284,'score_on_input'}
      ,{285,'append_prep_resaddress1'}
      ,{286,'append_prep_resaddress2'}
      ,{287,'append_resrawaid'}
      ,{288,'append_prep_mailaddress1'}
      ,{289,'append_prep_mailaddress2'}
      ,{290,'append_mailrawaid'}
      ,{291,'append_prep_cassaddress1'}
      ,{292,'append_prep_cassaddress2'}
      ,{293,'append_cassrawaid'}
      ,{294,'aid_resclean_prim_range'}
      ,{295,'aid_resclean_predir'}
      ,{296,'aid_resclean_prim_name'}
      ,{297,'aid_resclean_addr_suffix'}
      ,{298,'aid_resclean_postdir'}
      ,{299,'aid_resclean_unit_desig'}
      ,{300,'aid_resclean_sec_range'}
      ,{301,'aid_resclean_p_city_name'}
      ,{302,'aid_resclean_v_city_name'}
      ,{303,'aid_resclean_st'}
      ,{304,'aid_resclean_zip'}
      ,{305,'aid_resclean_zip4'}
      ,{306,'aid_resclean_cart'}
      ,{307,'aid_resclean_cr_sort_sz'}
      ,{308,'aid_resclean_lot'}
      ,{309,'aid_resclean_lot_order'}
      ,{310,'aid_resclean_dpbc'}
      ,{311,'aid_resclean_chk_digit'}
      ,{312,'aid_resclean_record_type'}
      ,{313,'aid_resclean_ace_fips_st'}
      ,{314,'aid_resclean_fipscounty'}
      ,{315,'aid_resclean_geo_lat'}
      ,{316,'aid_resclean_geo_long'}
      ,{317,'aid_resclean_msa'}
      ,{318,'aid_resclean_geo_blk'}
      ,{319,'aid_resclean_geo_match'}
      ,{320,'aid_resclean_err_stat'}
      ,{321,'aid_mailclean_prim_range'}
      ,{322,'aid_mailclean_predir'}
      ,{323,'aid_mailclean_prim_name'}
      ,{324,'aid_mailclean_addr_suffix'}
      ,{325,'aid_mailclean_postdir'}
      ,{326,'aid_mailclean_unit_desig'}
      ,{327,'aid_mailclean_sec_range'}
      ,{328,'aid_mailclean_p_city_name'}
      ,{329,'aid_mailclean_v_city_name'}
      ,{330,'aid_mailclean_st'}
      ,{331,'aid_mailclean_zip'}
      ,{332,'aid_mailclean_zip4'}
      ,{333,'aid_mailclean_cart'}
      ,{334,'aid_mailclean_cr_sort_sz'}
      ,{335,'aid_mailclean_lot'}
      ,{336,'aid_mailclean_lot_order'}
      ,{337,'aid_mailclean_dpbc'}
      ,{338,'aid_mailclean_chk_digit'}
      ,{339,'aid_mailclean_record_type'}
      ,{340,'aid_mailclean_ace_fips_st'}
      ,{341,'aid_mailclean_fipscounty'}
      ,{342,'aid_mailclean_geo_lat'}
      ,{343,'aid_mailclean_geo_long'}
      ,{344,'aid_mailclean_msa'}
      ,{345,'aid_mailclean_geo_blk'}
      ,{346,'aid_mailclean_geo_match'}
      ,{347,'aid_mailclean_err_stat'}
      ,{348,'prim_range'}
      ,{349,'predir'}
      ,{350,'prim_name'}
      ,{351,'suffix'}
      ,{352,'postdir'}
      ,{353,'unit_desig'}
      ,{354,'sec_range'}
      ,{355,'p_city_name'}
      ,{356,'city_name'}
      ,{357,'st'}
      ,{358,'zip'}
      ,{359,'zip4'}
      ,{360,'cart'}
      ,{361,'cr_sort_sz'}
      ,{362,'lot'}
      ,{363,'lot_order'}
      ,{364,'dpbc'}
      ,{365,'chk_digit'}
      ,{366,'record_type'}
      ,{367,'ace_fips_st'}
      ,{368,'county'}
      ,{369,'geo_lat'}
      ,{370,'geo_long'}
      ,{371,'msa'}
      ,{372,'geo_blk'}
      ,{373,'geo_match'}
      ,{374,'err_stat'}
      ,{375,'mail_prim_range'}
      ,{376,'mail_predir'}
      ,{377,'mail_prim_name'}
      ,{378,'mail_addr_suffix'}
      ,{379,'mail_postdir'}
      ,{380,'mail_unit_desig'}
      ,{381,'mail_sec_range'}
      ,{382,'mail_p_city_name'}
      ,{383,'mail_v_city_name'}
      ,{384,'mail_st'}
      ,{385,'mail_ace_zip'}
      ,{386,'mail_zip4'}
      ,{387,'mail_cart'}
      ,{388,'mail_cr_sort_sz'}
      ,{389,'mail_lot'}
      ,{390,'mail_lot_order'}
      ,{391,'mail_dpbc'}
      ,{392,'mail_chk_digit'}
      ,{393,'mail_record_type'}
      ,{394,'mail_ace_fips_st'}
      ,{395,'mail_fipscounty'}
      ,{396,'mail_geo_lat'}
      ,{397,'mail_geo_long'}
      ,{398,'mail_msa'}
      ,{399,'mail_geo_blk'}
      ,{400,'mail_geo_match'}
      ,{401,'mail_err_stat'}
      ,{402,'cass_prim_range'}
      ,{403,'cass_predir'}
      ,{404,'cass_prim_name'}
      ,{405,'cass_addr_suffix'}
      ,{406,'cass_postdir'}
      ,{407,'cass_unit_desig'}
      ,{408,'cass_sec_range'}
      ,{409,'cass_p_city_name'}
      ,{410,'cass_v_city_name'}
      ,{411,'cass_st'}
      ,{412,'cass_ace_zip'}
      ,{413,'cass_zip4'}
      ,{414,'cass_cart'}
      ,{415,'cass_cr_sort_sz'}
      ,{416,'cass_lot'}
      ,{417,'cass_lot_order'}
      ,{418,'cass_dpbc'}
      ,{419,'cass_chk_digit'}
      ,{420,'cass_record_type'}
      ,{421,'cass_ace_fips_st'}
      ,{422,'cass_fipscounty'}
      ,{423,'cass_geo_lat'}
      ,{424,'cass_geo_long'}
      ,{425,'cass_msa'}
      ,{426,'cass_geo_blk'}
      ,{427,'cass_geo_match'}
      ,{428,'cass_err_stat'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    HVCCW_Fields.InValid_append_seqnum((SALT311.StrType)le.append_seqnum),
    HVCCW_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    HVCCW_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    HVCCW_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    HVCCW_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    HVCCW_Fields.InValid_score((SALT311.StrType)le.score),
    HVCCW_Fields.InValid_best_ssn((SALT311.StrType)le.best_ssn),
    HVCCW_Fields.InValid_did_out((SALT311.StrType)le.did_out),
    HVCCW_Fields.InValid_source((SALT311.StrType)le.source),
    HVCCW_Fields.InValid_file_id((SALT311.StrType)le.file_id),
    HVCCW_Fields.InValid_vendor_id((SALT311.StrType)le.vendor_id),
    HVCCW_Fields.InValid_source_state((SALT311.StrType)le.source_state),
    HVCCW_Fields.InValid_source_code((SALT311.StrType)le.source_code),
    HVCCW_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date),
    HVCCW_Fields.InValid__use((SALT311.StrType)le._use),
    HVCCW_Fields.InValid_title_in((SALT311.StrType)le.title_in),
    HVCCW_Fields.InValid_lname_in((SALT311.StrType)le.lname_in),
    HVCCW_Fields.InValid_fname_in((SALT311.StrType)le.fname_in),
    HVCCW_Fields.InValid_mname_in((SALT311.StrType)le.mname_in),
    HVCCW_Fields.InValid_maiden_prior((SALT311.StrType)le.maiden_prior),
    HVCCW_Fields.InValid_name_suffix_in((SALT311.StrType)le.name_suffix_in),
    HVCCW_Fields.InValid_votefiller((SALT311.StrType)le.votefiller),
    HVCCW_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid),
    HVCCW_Fields.InValid_dob_str_in((SALT311.StrType)le.dob_str_in),
    HVCCW_Fields.InValid_agecat((SALT311.StrType)le.agecat),
    HVCCW_Fields.InValid_headhousehold((SALT311.StrType)le.headhousehold),
    HVCCW_Fields.InValid_place_of_birth((SALT311.StrType)le.place_of_birth),
    HVCCW_Fields.InValid_occupation((SALT311.StrType)le.occupation),
    HVCCW_Fields.InValid_maiden_name((SALT311.StrType)le.maiden_name),
    HVCCW_Fields.InValid_motorvoterid((SALT311.StrType)le.motorvoterid),
    HVCCW_Fields.InValid_regsource((SALT311.StrType)le.regsource),
    HVCCW_Fields.InValid_regdate_in((SALT311.StrType)le.regdate_in),
    HVCCW_Fields.InValid_race((SALT311.StrType)le.race),
    HVCCW_Fields.InValid_gender((SALT311.StrType)le.gender),
    HVCCW_Fields.InValid_poliparty((SALT311.StrType)le.poliparty),
    HVCCW_Fields.InValid_phone((SALT311.StrType)le.phone),
    HVCCW_Fields.InValid_work_phone((SALT311.StrType)le.work_phone),
    HVCCW_Fields.InValid_other_phone((SALT311.StrType)le.other_phone),
    HVCCW_Fields.InValid_active_status((SALT311.StrType)le.active_status),
    HVCCW_Fields.InValid_votefiller2((SALT311.StrType)le.votefiller2),
    HVCCW_Fields.InValid_active_other((SALT311.StrType)le.active_other),
    HVCCW_Fields.InValid_voterstatus((SALT311.StrType)le.voterstatus),
    HVCCW_Fields.InValid_resaddr1((SALT311.StrType)le.resaddr1),
    HVCCW_Fields.InValid_resaddr2((SALT311.StrType)le.resaddr2),
    HVCCW_Fields.InValid_res_city((SALT311.StrType)le.res_city),
    HVCCW_Fields.InValid_res_state((SALT311.StrType)le.res_state),
    HVCCW_Fields.InValid_res_zip((SALT311.StrType)le.res_zip),
    HVCCW_Fields.InValid_res_county((SALT311.StrType)le.res_county),
    HVCCW_Fields.InValid_mail_addr1((SALT311.StrType)le.mail_addr1),
    HVCCW_Fields.InValid_mail_addr2((SALT311.StrType)le.mail_addr2),
    HVCCW_Fields.InValid_mail_city((SALT311.StrType)le.mail_city),
    HVCCW_Fields.InValid_mail_state((SALT311.StrType)le.mail_state),
    HVCCW_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip),
    HVCCW_Fields.InValid_mail_county((SALT311.StrType)le.mail_county),
    HVCCW_Fields.InValid_addr_filler1((SALT311.StrType)le.addr_filler1),
    HVCCW_Fields.InValid_addr_filler2((SALT311.StrType)le.addr_filler2),
    HVCCW_Fields.InValid_city_filler((SALT311.StrType)le.city_filler),
    HVCCW_Fields.InValid_state_filler((SALT311.StrType)le.state_filler),
    HVCCW_Fields.InValid_zip_filler((SALT311.StrType)le.zip_filler),
    HVCCW_Fields.InValid_county_filler((SALT311.StrType)le.county_filler),
    HVCCW_Fields.InValid_towncode((SALT311.StrType)le.towncode),
    HVCCW_Fields.InValid_distcode((SALT311.StrType)le.distcode),
    HVCCW_Fields.InValid_countycode((SALT311.StrType)le.countycode),
    HVCCW_Fields.InValid_schoolcode((SALT311.StrType)le.schoolcode),
    HVCCW_Fields.InValid_cityinout((SALT311.StrType)le.cityinout),
    HVCCW_Fields.InValid_spec_dist1((SALT311.StrType)le.spec_dist1),
    HVCCW_Fields.InValid_spec_dist2((SALT311.StrType)le.spec_dist2),
    HVCCW_Fields.InValid_precinct1((SALT311.StrType)le.precinct1),
    HVCCW_Fields.InValid_precinct2((SALT311.StrType)le.precinct2),
    HVCCW_Fields.InValid_precinct3((SALT311.StrType)le.precinct3),
    HVCCW_Fields.InValid_villageprecinct((SALT311.StrType)le.villageprecinct),
    HVCCW_Fields.InValid_schoolprecinct((SALT311.StrType)le.schoolprecinct),
    HVCCW_Fields.InValid_ward((SALT311.StrType)le.ward),
    HVCCW_Fields.InValid_precinct_citytown((SALT311.StrType)le.precinct_citytown),
    HVCCW_Fields.InValid_ancsmdindc((SALT311.StrType)le.ancsmdindc),
    HVCCW_Fields.InValid_citycouncildist((SALT311.StrType)le.citycouncildist),
    HVCCW_Fields.InValid_countycommdist((SALT311.StrType)le.countycommdist),
    HVCCW_Fields.InValid_statehouse((SALT311.StrType)le.statehouse),
    HVCCW_Fields.InValid_statesenate((SALT311.StrType)le.statesenate),
    HVCCW_Fields.InValid_ushouse((SALT311.StrType)le.ushouse),
    HVCCW_Fields.InValid_elemschooldist((SALT311.StrType)le.elemschooldist),
    HVCCW_Fields.InValid_schooldist((SALT311.StrType)le.schooldist),
    HVCCW_Fields.InValid_schoolfiller((SALT311.StrType)le.schoolfiller),
    HVCCW_Fields.InValid_commcolldist((SALT311.StrType)le.commcolldist),
    HVCCW_Fields.InValid_dist_filler((SALT311.StrType)le.dist_filler),
    HVCCW_Fields.InValid_municipal((SALT311.StrType)le.municipal),
    HVCCW_Fields.InValid_villagedist((SALT311.StrType)le.villagedist),
    HVCCW_Fields.InValid_policejury((SALT311.StrType)le.policejury),
    HVCCW_Fields.InValid_policedist((SALT311.StrType)le.policedist),
    HVCCW_Fields.InValid_publicservcomm((SALT311.StrType)le.publicservcomm),
    HVCCW_Fields.InValid_rescue((SALT311.StrType)le.rescue),
    HVCCW_Fields.InValid_fire((SALT311.StrType)le.fire),
    HVCCW_Fields.InValid_sanitary((SALT311.StrType)le.sanitary),
    HVCCW_Fields.InValid_sewerdist((SALT311.StrType)le.sewerdist),
    HVCCW_Fields.InValid_waterdist((SALT311.StrType)le.waterdist),
    HVCCW_Fields.InValid_mosquitodist((SALT311.StrType)le.mosquitodist),
    HVCCW_Fields.InValid_taxdist((SALT311.StrType)le.taxdist),
    HVCCW_Fields.InValid_supremecourt((SALT311.StrType)le.supremecourt),
    HVCCW_Fields.InValid_justiceofpeace((SALT311.StrType)le.justiceofpeace),
    HVCCW_Fields.InValid_judicialdist((SALT311.StrType)le.judicialdist),
    HVCCW_Fields.InValid_superiorctdist((SALT311.StrType)le.superiorctdist),
    HVCCW_Fields.InValid_appealsct((SALT311.StrType)le.appealsct),
    HVCCW_Fields.InValid_courtfiller((SALT311.StrType)le.courtfiller),
    HVCCW_Fields.InValid_contributorparty((SALT311.StrType)le.contributorparty),
    HVCCW_Fields.InValid_recptparty((SALT311.StrType)le.recptparty),
    HVCCW_Fields.InValid_dateofcontr_in((SALT311.StrType)le.dateofcontr_in),
    HVCCW_Fields.InValid_dollaramt((SALT311.StrType)le.dollaramt),
    HVCCW_Fields.InValid_officecontto((SALT311.StrType)le.officecontto),
    HVCCW_Fields.InValid_cumuldollaramt((SALT311.StrType)le.cumuldollaramt),
    HVCCW_Fields.InValid_contfiller1((SALT311.StrType)le.contfiller1),
    HVCCW_Fields.InValid_contfiller2((SALT311.StrType)le.contfiller2),
    HVCCW_Fields.InValid_conttype((SALT311.StrType)le.conttype),
    HVCCW_Fields.InValid_contfiller3((SALT311.StrType)le.contfiller3),
    HVCCW_Fields.InValid_primary02((SALT311.StrType)le.primary02),
    HVCCW_Fields.InValid_special02((SALT311.StrType)le.special02),
    HVCCW_Fields.InValid_other02((SALT311.StrType)le.other02),
    HVCCW_Fields.InValid_special202((SALT311.StrType)le.special202),
    HVCCW_Fields.InValid_general02((SALT311.StrType)le.general02),
    HVCCW_Fields.InValid_primary01((SALT311.StrType)le.primary01),
    HVCCW_Fields.InValid_special01((SALT311.StrType)le.special01),
    HVCCW_Fields.InValid_other01((SALT311.StrType)le.other01),
    HVCCW_Fields.InValid_special201((SALT311.StrType)le.special201),
    HVCCW_Fields.InValid_general01((SALT311.StrType)le.general01),
    HVCCW_Fields.InValid_pres00((SALT311.StrType)le.pres00),
    HVCCW_Fields.InValid_primary00((SALT311.StrType)le.primary00),
    HVCCW_Fields.InValid_special00((SALT311.StrType)le.special00),
    HVCCW_Fields.InValid_other00((SALT311.StrType)le.other00),
    HVCCW_Fields.InValid_special200((SALT311.StrType)le.special200),
    HVCCW_Fields.InValid_general00((SALT311.StrType)le.general00),
    HVCCW_Fields.InValid_primary99((SALT311.StrType)le.primary99),
    HVCCW_Fields.InValid_special99((SALT311.StrType)le.special99),
    HVCCW_Fields.InValid_other99((SALT311.StrType)le.other99),
    HVCCW_Fields.InValid_special299((SALT311.StrType)le.special299),
    HVCCW_Fields.InValid_general99((SALT311.StrType)le.general99),
    HVCCW_Fields.InValid_primary98((SALT311.StrType)le.primary98),
    HVCCW_Fields.InValid_special98((SALT311.StrType)le.special98),
    HVCCW_Fields.InValid_other98((SALT311.StrType)le.other98),
    HVCCW_Fields.InValid_special298((SALT311.StrType)le.special298),
    HVCCW_Fields.InValid_general98((SALT311.StrType)le.general98),
    HVCCW_Fields.InValid_primary97((SALT311.StrType)le.primary97),
    HVCCW_Fields.InValid_special97((SALT311.StrType)le.special97),
    HVCCW_Fields.InValid_other97((SALT311.StrType)le.other97),
    HVCCW_Fields.InValid_special297((SALT311.StrType)le.special297),
    HVCCW_Fields.InValid_general97((SALT311.StrType)le.general97),
    HVCCW_Fields.InValid_pres96((SALT311.StrType)le.pres96),
    HVCCW_Fields.InValid_primary96((SALT311.StrType)le.primary96),
    HVCCW_Fields.InValid_special96((SALT311.StrType)le.special96),
    HVCCW_Fields.InValid_other96((SALT311.StrType)le.other96),
    HVCCW_Fields.InValid_special296((SALT311.StrType)le.special296),
    HVCCW_Fields.InValid_general96((SALT311.StrType)le.general96),
    HVCCW_Fields.InValid_lastdayvote_in((SALT311.StrType)le.lastdayvote_in),
    HVCCW_Fields.InValid_historyfiller((SALT311.StrType)le.historyfiller),
    HVCCW_Fields.InValid_huntfishperm((SALT311.StrType)le.huntfishperm),
    HVCCW_Fields.InValid_datelicense_in((SALT311.StrType)le.datelicense_in),
    HVCCW_Fields.InValid_homestate((SALT311.StrType)le.homestate),
    HVCCW_Fields.InValid_resident((SALT311.StrType)le.resident),
    HVCCW_Fields.InValid_nonresident((SALT311.StrType)le.nonresident),
    HVCCW_Fields.InValid_hunt((SALT311.StrType)le.hunt),
    HVCCW_Fields.InValid_fish((SALT311.StrType)le.fish),
    HVCCW_Fields.InValid_combosuper((SALT311.StrType)le.combosuper),
    HVCCW_Fields.InValid_sportsman((SALT311.StrType)le.sportsman),
    HVCCW_Fields.InValid_trap((SALT311.StrType)le.trap),
    HVCCW_Fields.InValid_archery((SALT311.StrType)le.archery),
    HVCCW_Fields.InValid_muzzle((SALT311.StrType)le.muzzle),
    HVCCW_Fields.InValid_drawing((SALT311.StrType)le.drawing),
    HVCCW_Fields.InValid_day1((SALT311.StrType)le.day1),
    HVCCW_Fields.InValid_day3((SALT311.StrType)le.day3),
    HVCCW_Fields.InValid_day7((SALT311.StrType)le.day7),
    HVCCW_Fields.InValid_day14to15((SALT311.StrType)le.day14to15),
    HVCCW_Fields.InValid_dayfiller((SALT311.StrType)le.dayfiller),
    HVCCW_Fields.InValid_seasonannual((SALT311.StrType)le.seasonannual),
    HVCCW_Fields.InValid_lifetimepermit((SALT311.StrType)le.lifetimepermit),
    HVCCW_Fields.InValid_landowner((SALT311.StrType)le.landowner),
    HVCCW_Fields.InValid_family((SALT311.StrType)le.family),
    HVCCW_Fields.InValid_junior((SALT311.StrType)le.junior),
    HVCCW_Fields.InValid_seniorcit((SALT311.StrType)le.seniorcit),
    HVCCW_Fields.InValid_crewmemeber((SALT311.StrType)le.crewmemeber),
    HVCCW_Fields.InValid_retarded((SALT311.StrType)le.retarded),
    HVCCW_Fields.InValid_indian((SALT311.StrType)le.indian),
    HVCCW_Fields.InValid_serviceman((SALT311.StrType)le.serviceman),
    HVCCW_Fields.InValid_disabled((SALT311.StrType)le.disabled),
    HVCCW_Fields.InValid_lowincome((SALT311.StrType)le.lowincome),
    HVCCW_Fields.InValid_regioncounty((SALT311.StrType)le.regioncounty),
    HVCCW_Fields.InValid_blind((SALT311.StrType)le.blind),
    HVCCW_Fields.InValid_huntfiller((SALT311.StrType)le.huntfiller),
    HVCCW_Fields.InValid_salmon((SALT311.StrType)le.salmon),
    HVCCW_Fields.InValid_freshwater((SALT311.StrType)le.freshwater),
    HVCCW_Fields.InValid_saltwater((SALT311.StrType)le.saltwater),
    HVCCW_Fields.InValid_lakesandresevoirs((SALT311.StrType)le.lakesandresevoirs),
    HVCCW_Fields.InValid_setlinefish((SALT311.StrType)le.setlinefish),
    HVCCW_Fields.InValid_trout((SALT311.StrType)le.trout),
    HVCCW_Fields.InValid_fallfishing((SALT311.StrType)le.fallfishing),
    HVCCW_Fields.InValid_steelhead((SALT311.StrType)le.steelhead),
    HVCCW_Fields.InValid_whitejubherring((SALT311.StrType)le.whitejubherring),
    HVCCW_Fields.InValid_sturgeon((SALT311.StrType)le.sturgeon),
    HVCCW_Fields.InValid_shellfishcrab((SALT311.StrType)le.shellfishcrab),
    HVCCW_Fields.InValid_shellfishlobster((SALT311.StrType)le.shellfishlobster),
    HVCCW_Fields.InValid_deer((SALT311.StrType)le.deer),
    HVCCW_Fields.InValid_bear((SALT311.StrType)le.bear),
    HVCCW_Fields.InValid_elk((SALT311.StrType)le.elk),
    HVCCW_Fields.InValid_moose((SALT311.StrType)le.moose),
    HVCCW_Fields.InValid_buffalo((SALT311.StrType)le.buffalo),
    HVCCW_Fields.InValid_antelope((SALT311.StrType)le.antelope),
    HVCCW_Fields.InValid_sikebull((SALT311.StrType)le.sikebull),
    HVCCW_Fields.InValid_bighorn((SALT311.StrType)le.bighorn),
    HVCCW_Fields.InValid_javelina((SALT311.StrType)le.javelina),
    HVCCW_Fields.InValid_cougar((SALT311.StrType)le.cougar),
    HVCCW_Fields.InValid_anterless((SALT311.StrType)le.anterless),
    HVCCW_Fields.InValid_pheasant((SALT311.StrType)le.pheasant),
    HVCCW_Fields.InValid_goose((SALT311.StrType)le.goose),
    HVCCW_Fields.InValid_duck((SALT311.StrType)le.duck),
    HVCCW_Fields.InValid_turkey((SALT311.StrType)le.turkey),
    HVCCW_Fields.InValid_snowmobile((SALT311.StrType)le.snowmobile),
    HVCCW_Fields.InValid_biggame((SALT311.StrType)le.biggame),
    HVCCW_Fields.InValid_skipass((SALT311.StrType)le.skipass),
    HVCCW_Fields.InValid_migbird((SALT311.StrType)le.migbird),
    HVCCW_Fields.InValid_smallgame((SALT311.StrType)le.smallgame),
    HVCCW_Fields.InValid_sturgeon2((SALT311.StrType)le.sturgeon2),
    HVCCW_Fields.InValid_gun((SALT311.StrType)le.gun),
    HVCCW_Fields.InValid_bonus((SALT311.StrType)le.bonus),
    HVCCW_Fields.InValid_lottery((SALT311.StrType)le.lottery),
    HVCCW_Fields.InValid_otherbirds((SALT311.StrType)le.otherbirds),
    HVCCW_Fields.InValid_huntfill1((SALT311.StrType)le.huntfill1),
    HVCCW_Fields.InValid_boatindexnum((SALT311.StrType)le.boatindexnum),
    HVCCW_Fields.InValid_boatcoowner((SALT311.StrType)le.boatcoowner),
    HVCCW_Fields.InValid_hullidnum((SALT311.StrType)le.hullidnum),
    HVCCW_Fields.InValid_yearmade((SALT311.StrType)le.yearmade),
    HVCCW_Fields.InValid_model((SALT311.StrType)le.model),
    HVCCW_Fields.InValid_manufacturer((SALT311.StrType)le.manufacturer),
    HVCCW_Fields.InValid_lengt((SALT311.StrType)le.lengt),
    HVCCW_Fields.InValid_hullconstruct((SALT311.StrType)le.hullconstruct),
    HVCCW_Fields.InValid_primuse((SALT311.StrType)le.primuse),
    HVCCW_Fields.InValid_fueltype((SALT311.StrType)le.fueltype),
    HVCCW_Fields.InValid_propulsion((SALT311.StrType)le.propulsion),
    HVCCW_Fields.InValid_modeltype((SALT311.StrType)le.modeltype),
    HVCCW_Fields.InValid_regexpdate_in((SALT311.StrType)le.regexpdate_in),
    HVCCW_Fields.InValid_titlenum((SALT311.StrType)le.titlenum),
    HVCCW_Fields.InValid_stprimuse((SALT311.StrType)le.stprimuse),
    HVCCW_Fields.InValid_titlestatus((SALT311.StrType)le.titlestatus),
    HVCCW_Fields.InValid_vessel((SALT311.StrType)le.vessel),
    HVCCW_Fields.InValid_specreg((SALT311.StrType)le.specreg),
    HVCCW_Fields.InValid_boatfill1((SALT311.StrType)le.boatfill1),
    HVCCW_Fields.InValid_boatfill2((SALT311.StrType)le.boatfill2),
    HVCCW_Fields.InValid_boatfill3((SALT311.StrType)le.boatfill3),
    HVCCW_Fields.InValid_ccwpermnum((SALT311.StrType)le.ccwpermnum),
    HVCCW_Fields.InValid_ccwweapontype((SALT311.StrType)le.ccwweapontype),
    HVCCW_Fields.InValid_ccwregdate_in((SALT311.StrType)le.ccwregdate_in),
    HVCCW_Fields.InValid_ccwexpdate_in((SALT311.StrType)le.ccwexpdate_in),
    HVCCW_Fields.InValid_ccwpermtype((SALT311.StrType)le.ccwpermtype),
    HVCCW_Fields.InValid_ccwfill1((SALT311.StrType)le.ccwfill1),
    HVCCW_Fields.InValid_ccwfill2((SALT311.StrType)le.ccwfill2),
    HVCCW_Fields.InValid_ccwfill3((SALT311.StrType)le.ccwfill3),
    HVCCW_Fields.InValid_ccwfill4((SALT311.StrType)le.ccwfill4),
    HVCCW_Fields.InValid_miscfill1((SALT311.StrType)le.miscfill1),
    HVCCW_Fields.InValid_miscfill2((SALT311.StrType)le.miscfill2),
    HVCCW_Fields.InValid_miscfill3((SALT311.StrType)le.miscfill3),
    HVCCW_Fields.InValid_miscfill4((SALT311.StrType)le.miscfill4),
    HVCCW_Fields.InValid_miscfill5((SALT311.StrType)le.miscfill5),
    HVCCW_Fields.InValid_fillerother1((SALT311.StrType)le.fillerother1),
    HVCCW_Fields.InValid_fillerother2((SALT311.StrType)le.fillerother2),
    HVCCW_Fields.InValid_fillerother3((SALT311.StrType)le.fillerother3),
    HVCCW_Fields.InValid_fillerother4((SALT311.StrType)le.fillerother4),
    HVCCW_Fields.InValid_fillerother5((SALT311.StrType)le.fillerother5),
    HVCCW_Fields.InValid_fillerother6((SALT311.StrType)le.fillerother6),
    HVCCW_Fields.InValid_fillerother7((SALT311.StrType)le.fillerother7),
    HVCCW_Fields.InValid_fillerother8((SALT311.StrType)le.fillerother8),
    HVCCW_Fields.InValid_fillerother9((SALT311.StrType)le.fillerother9),
    HVCCW_Fields.InValid_fillerother10((SALT311.StrType)le.fillerother10),
    HVCCW_Fields.InValid_eor((SALT311.StrType)le.eor),
    HVCCW_Fields.InValid_stuff((SALT311.StrType)le.stuff),
    HVCCW_Fields.InValid_dob_str((SALT311.StrType)le.dob_str),
    HVCCW_Fields.InValid_regdate((SALT311.StrType)le.regdate),
    HVCCW_Fields.InValid_dateofcontr((SALT311.StrType)le.dateofcontr),
    HVCCW_Fields.InValid_lastdayvote((SALT311.StrType)le.lastdayvote),
    HVCCW_Fields.InValid_datelicense((SALT311.StrType)le.datelicense),
    HVCCW_Fields.InValid_regexpdate((SALT311.StrType)le.regexpdate),
    HVCCW_Fields.InValid_ccwregdate((SALT311.StrType)le.ccwregdate),
    HVCCW_Fields.InValid_ccwexpdate((SALT311.StrType)le.ccwexpdate),
    HVCCW_Fields.InValid_title((SALT311.StrType)le.title),
    HVCCW_Fields.InValid_fname((SALT311.StrType)le.fname),
    HVCCW_Fields.InValid_mname((SALT311.StrType)le.mname),
    HVCCW_Fields.InValid_lname((SALT311.StrType)le.lname),
    HVCCW_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    HVCCW_Fields.InValid_score_on_input((SALT311.StrType)le.score_on_input),
    HVCCW_Fields.InValid_append_prep_resaddress1((SALT311.StrType)le.append_prep_resaddress1),
    HVCCW_Fields.InValid_append_prep_resaddress2((SALT311.StrType)le.append_prep_resaddress2),
    HVCCW_Fields.InValid_append_resrawaid((SALT311.StrType)le.append_resrawaid),
    HVCCW_Fields.InValid_append_prep_mailaddress1((SALT311.StrType)le.append_prep_mailaddress1),
    HVCCW_Fields.InValid_append_prep_mailaddress2((SALT311.StrType)le.append_prep_mailaddress2),
    HVCCW_Fields.InValid_append_mailrawaid((SALT311.StrType)le.append_mailrawaid),
    HVCCW_Fields.InValid_append_prep_cassaddress1((SALT311.StrType)le.append_prep_cassaddress1),
    HVCCW_Fields.InValid_append_prep_cassaddress2((SALT311.StrType)le.append_prep_cassaddress2),
    HVCCW_Fields.InValid_append_cassrawaid((SALT311.StrType)le.append_cassrawaid),
    HVCCW_Fields.InValid_aid_resclean_prim_range((SALT311.StrType)le.aid_resclean_prim_range),
    HVCCW_Fields.InValid_aid_resclean_predir((SALT311.StrType)le.aid_resclean_predir),
    HVCCW_Fields.InValid_aid_resclean_prim_name((SALT311.StrType)le.aid_resclean_prim_name),
    HVCCW_Fields.InValid_aid_resclean_addr_suffix((SALT311.StrType)le.aid_resclean_addr_suffix),
    HVCCW_Fields.InValid_aid_resclean_postdir((SALT311.StrType)le.aid_resclean_postdir),
    HVCCW_Fields.InValid_aid_resclean_unit_desig((SALT311.StrType)le.aid_resclean_unit_desig),
    HVCCW_Fields.InValid_aid_resclean_sec_range((SALT311.StrType)le.aid_resclean_sec_range),
    HVCCW_Fields.InValid_aid_resclean_p_city_name((SALT311.StrType)le.aid_resclean_p_city_name),
    HVCCW_Fields.InValid_aid_resclean_v_city_name((SALT311.StrType)le.aid_resclean_v_city_name),
    HVCCW_Fields.InValid_aid_resclean_st((SALT311.StrType)le.aid_resclean_st),
    HVCCW_Fields.InValid_aid_resclean_zip((SALT311.StrType)le.aid_resclean_zip),
    HVCCW_Fields.InValid_aid_resclean_zip4((SALT311.StrType)le.aid_resclean_zip4),
    HVCCW_Fields.InValid_aid_resclean_cart((SALT311.StrType)le.aid_resclean_cart),
    HVCCW_Fields.InValid_aid_resclean_cr_sort_sz((SALT311.StrType)le.aid_resclean_cr_sort_sz),
    HVCCW_Fields.InValid_aid_resclean_lot((SALT311.StrType)le.aid_resclean_lot),
    HVCCW_Fields.InValid_aid_resclean_lot_order((SALT311.StrType)le.aid_resclean_lot_order),
    HVCCW_Fields.InValid_aid_resclean_dpbc((SALT311.StrType)le.aid_resclean_dpbc),
    HVCCW_Fields.InValid_aid_resclean_chk_digit((SALT311.StrType)le.aid_resclean_chk_digit),
    HVCCW_Fields.InValid_aid_resclean_record_type((SALT311.StrType)le.aid_resclean_record_type),
    HVCCW_Fields.InValid_aid_resclean_ace_fips_st((SALT311.StrType)le.aid_resclean_ace_fips_st),
    HVCCW_Fields.InValid_aid_resclean_fipscounty((SALT311.StrType)le.aid_resclean_fipscounty),
    HVCCW_Fields.InValid_aid_resclean_geo_lat((SALT311.StrType)le.aid_resclean_geo_lat),
    HVCCW_Fields.InValid_aid_resclean_geo_long((SALT311.StrType)le.aid_resclean_geo_long),
    HVCCW_Fields.InValid_aid_resclean_msa((SALT311.StrType)le.aid_resclean_msa),
    HVCCW_Fields.InValid_aid_resclean_geo_blk((SALT311.StrType)le.aid_resclean_geo_blk),
    HVCCW_Fields.InValid_aid_resclean_geo_match((SALT311.StrType)le.aid_resclean_geo_match),
    HVCCW_Fields.InValid_aid_resclean_err_stat((SALT311.StrType)le.aid_resclean_err_stat),
    HVCCW_Fields.InValid_aid_mailclean_prim_range((SALT311.StrType)le.aid_mailclean_prim_range),
    HVCCW_Fields.InValid_aid_mailclean_predir((SALT311.StrType)le.aid_mailclean_predir),
    HVCCW_Fields.InValid_aid_mailclean_prim_name((SALT311.StrType)le.aid_mailclean_prim_name),
    HVCCW_Fields.InValid_aid_mailclean_addr_suffix((SALT311.StrType)le.aid_mailclean_addr_suffix),
    HVCCW_Fields.InValid_aid_mailclean_postdir((SALT311.StrType)le.aid_mailclean_postdir),
    HVCCW_Fields.InValid_aid_mailclean_unit_desig((SALT311.StrType)le.aid_mailclean_unit_desig),
    HVCCW_Fields.InValid_aid_mailclean_sec_range((SALT311.StrType)le.aid_mailclean_sec_range),
    HVCCW_Fields.InValid_aid_mailclean_p_city_name((SALT311.StrType)le.aid_mailclean_p_city_name),
    HVCCW_Fields.InValid_aid_mailclean_v_city_name((SALT311.StrType)le.aid_mailclean_v_city_name),
    HVCCW_Fields.InValid_aid_mailclean_st((SALT311.StrType)le.aid_mailclean_st),
    HVCCW_Fields.InValid_aid_mailclean_zip((SALT311.StrType)le.aid_mailclean_zip),
    HVCCW_Fields.InValid_aid_mailclean_zip4((SALT311.StrType)le.aid_mailclean_zip4),
    HVCCW_Fields.InValid_aid_mailclean_cart((SALT311.StrType)le.aid_mailclean_cart),
    HVCCW_Fields.InValid_aid_mailclean_cr_sort_sz((SALT311.StrType)le.aid_mailclean_cr_sort_sz),
    HVCCW_Fields.InValid_aid_mailclean_lot((SALT311.StrType)le.aid_mailclean_lot),
    HVCCW_Fields.InValid_aid_mailclean_lot_order((SALT311.StrType)le.aid_mailclean_lot_order),
    HVCCW_Fields.InValid_aid_mailclean_dpbc((SALT311.StrType)le.aid_mailclean_dpbc),
    HVCCW_Fields.InValid_aid_mailclean_chk_digit((SALT311.StrType)le.aid_mailclean_chk_digit),
    HVCCW_Fields.InValid_aid_mailclean_record_type((SALT311.StrType)le.aid_mailclean_record_type),
    HVCCW_Fields.InValid_aid_mailclean_ace_fips_st((SALT311.StrType)le.aid_mailclean_ace_fips_st),
    HVCCW_Fields.InValid_aid_mailclean_fipscounty((SALT311.StrType)le.aid_mailclean_fipscounty),
    HVCCW_Fields.InValid_aid_mailclean_geo_lat((SALT311.StrType)le.aid_mailclean_geo_lat),
    HVCCW_Fields.InValid_aid_mailclean_geo_long((SALT311.StrType)le.aid_mailclean_geo_long),
    HVCCW_Fields.InValid_aid_mailclean_msa((SALT311.StrType)le.aid_mailclean_msa),
    HVCCW_Fields.InValid_aid_mailclean_geo_blk((SALT311.StrType)le.aid_mailclean_geo_blk),
    HVCCW_Fields.InValid_aid_mailclean_geo_match((SALT311.StrType)le.aid_mailclean_geo_match),
    HVCCW_Fields.InValid_aid_mailclean_err_stat((SALT311.StrType)le.aid_mailclean_err_stat),
    HVCCW_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    HVCCW_Fields.InValid_predir((SALT311.StrType)le.predir),
    HVCCW_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    HVCCW_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    HVCCW_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    HVCCW_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    HVCCW_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    HVCCW_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    HVCCW_Fields.InValid_city_name((SALT311.StrType)le.city_name),
    HVCCW_Fields.InValid_st((SALT311.StrType)le.st),
    HVCCW_Fields.InValid_zip((SALT311.StrType)le.zip),
    HVCCW_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    HVCCW_Fields.InValid_cart((SALT311.StrType)le.cart),
    HVCCW_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    HVCCW_Fields.InValid_lot((SALT311.StrType)le.lot),
    HVCCW_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    HVCCW_Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    HVCCW_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    HVCCW_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    HVCCW_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    HVCCW_Fields.InValid_county((SALT311.StrType)le.county),
    HVCCW_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    HVCCW_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    HVCCW_Fields.InValid_msa((SALT311.StrType)le.msa),
    HVCCW_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    HVCCW_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    HVCCW_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    HVCCW_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range),
    HVCCW_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir),
    HVCCW_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name),
    HVCCW_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix),
    HVCCW_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir),
    HVCCW_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig),
    HVCCW_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range),
    HVCCW_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name),
    HVCCW_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name),
    HVCCW_Fields.InValid_mail_st((SALT311.StrType)le.mail_st),
    HVCCW_Fields.InValid_mail_ace_zip((SALT311.StrType)le.mail_ace_zip),
    HVCCW_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4),
    HVCCW_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart),
    HVCCW_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz),
    HVCCW_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot),
    HVCCW_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order),
    HVCCW_Fields.InValid_mail_dpbc((SALT311.StrType)le.mail_dpbc),
    HVCCW_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit),
    HVCCW_Fields.InValid_mail_record_type((SALT311.StrType)le.mail_record_type),
    HVCCW_Fields.InValid_mail_ace_fips_st((SALT311.StrType)le.mail_ace_fips_st),
    HVCCW_Fields.InValid_mail_fipscounty((SALT311.StrType)le.mail_fipscounty),
    HVCCW_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat),
    HVCCW_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long),
    HVCCW_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa),
    HVCCW_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk),
    HVCCW_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match),
    HVCCW_Fields.InValid_mail_err_stat((SALT311.StrType)le.mail_err_stat),
    HVCCW_Fields.InValid_cass_prim_range((SALT311.StrType)le.cass_prim_range),
    HVCCW_Fields.InValid_cass_predir((SALT311.StrType)le.cass_predir),
    HVCCW_Fields.InValid_cass_prim_name((SALT311.StrType)le.cass_prim_name),
    HVCCW_Fields.InValid_cass_addr_suffix((SALT311.StrType)le.cass_addr_suffix),
    HVCCW_Fields.InValid_cass_postdir((SALT311.StrType)le.cass_postdir),
    HVCCW_Fields.InValid_cass_unit_desig((SALT311.StrType)le.cass_unit_desig),
    HVCCW_Fields.InValid_cass_sec_range((SALT311.StrType)le.cass_sec_range),
    HVCCW_Fields.InValid_cass_p_city_name((SALT311.StrType)le.cass_p_city_name),
    HVCCW_Fields.InValid_cass_v_city_name((SALT311.StrType)le.cass_v_city_name),
    HVCCW_Fields.InValid_cass_st((SALT311.StrType)le.cass_st),
    HVCCW_Fields.InValid_cass_ace_zip((SALT311.StrType)le.cass_ace_zip),
    HVCCW_Fields.InValid_cass_zip4((SALT311.StrType)le.cass_zip4),
    HVCCW_Fields.InValid_cass_cart((SALT311.StrType)le.cass_cart),
    HVCCW_Fields.InValid_cass_cr_sort_sz((SALT311.StrType)le.cass_cr_sort_sz),
    HVCCW_Fields.InValid_cass_lot((SALT311.StrType)le.cass_lot),
    HVCCW_Fields.InValid_cass_lot_order((SALT311.StrType)le.cass_lot_order),
    HVCCW_Fields.InValid_cass_dpbc((SALT311.StrType)le.cass_dpbc),
    HVCCW_Fields.InValid_cass_chk_digit((SALT311.StrType)le.cass_chk_digit),
    HVCCW_Fields.InValid_cass_record_type((SALT311.StrType)le.cass_record_type),
    HVCCW_Fields.InValid_cass_ace_fips_st((SALT311.StrType)le.cass_ace_fips_st),
    HVCCW_Fields.InValid_cass_fipscounty((SALT311.StrType)le.cass_fipscounty),
    HVCCW_Fields.InValid_cass_geo_lat((SALT311.StrType)le.cass_geo_lat),
    HVCCW_Fields.InValid_cass_geo_long((SALT311.StrType)le.cass_geo_long),
    HVCCW_Fields.InValid_cass_msa((SALT311.StrType)le.cass_msa),
    HVCCW_Fields.InValid_cass_geo_blk((SALT311.StrType)le.cass_geo_blk),
    HVCCW_Fields.InValid_cass_geo_match((SALT311.StrType)le.cass_geo_match),
    HVCCW_Fields.InValid_cass_err_stat((SALT311.StrType)le.cass_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,428,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := HVCCW_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_AlphaNum','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Unknown','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Float','Invalid_AlphaNum','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Unknown','Invalid_AlphaNum','Unknown','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Unknown','Invalid_Alpha','Invalid_AlphaNum','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Unknown','Unknown','Invalid_No','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Unknown','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Unknown','Unknown','Unknown','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_Float','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Unknown','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,HVCCW_Fields.InValidMessage_append_seqnum(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_score(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_did_out(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_source(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_file_id(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_source_state(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_file_acquired_date(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage__use(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_title_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lname_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fname_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mname_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_maiden_prior(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_name_suffix_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_votefiller(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_source_voterid(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dob_str_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_agecat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_headhousehold(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_place_of_birth(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_occupation(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_maiden_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_motorvoterid(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_regsource(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_regdate_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_race(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_gender(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_poliparty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_phone(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other_phone(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_active_status(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_votefiller2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_active_other(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_voterstatus(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_resaddr1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_resaddr2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_res_city(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_res_state(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_res_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_res_county(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_addr1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_addr2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_county(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_addr_filler1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_addr_filler2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_city_filler(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_state_filler(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_zip_filler(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_county_filler(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_towncode(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_distcode(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_countycode(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_schoolcode(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cityinout(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_spec_dist1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_spec_dist2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_precinct1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_precinct2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_precinct3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_villageprecinct(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_schoolprecinct(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ward(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_precinct_citytown(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ancsmdindc(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_citycouncildist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_countycommdist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_statehouse(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_statesenate(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ushouse(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_elemschooldist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_schooldist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_schoolfiller(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_commcolldist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dist_filler(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_municipal(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_villagedist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_policejury(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_policedist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_publicservcomm(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_rescue(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fire(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sanitary(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sewerdist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_waterdist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mosquitodist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_taxdist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_supremecourt(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_justiceofpeace(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_judicialdist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_superiorctdist(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_appealsct(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_courtfiller(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_contributorparty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_recptparty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dateofcontr_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dollaramt(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_officecontto(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cumuldollaramt(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_contfiller1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_contfiller2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_conttype(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_contfiller3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary02(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special02(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other02(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special202(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general02(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary01(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special01(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other01(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special201(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general01(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_pres00(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary00(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special00(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other00(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special200(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general00(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary99(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special99(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other99(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special299(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general99(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary98(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special98(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other98(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special298(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general98(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary97(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special97(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other97(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special297(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general97(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_pres96(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primary96(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special96(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_other96(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_special296(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_general96(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lastdayvote_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_historyfiller(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_huntfishperm(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_datelicense_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_homestate(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_resident(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_nonresident(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_hunt(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fish(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_combosuper(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sportsman(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_trap(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_archery(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_muzzle(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_drawing(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_day1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_day3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_day7(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_day14to15(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dayfiller(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_seasonannual(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lifetimepermit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_landowner(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_family(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_junior(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_seniorcit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_crewmemeber(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_retarded(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_indian(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_serviceman(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_disabled(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lowincome(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_regioncounty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_blind(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_huntfiller(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_salmon(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_freshwater(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_saltwater(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lakesandresevoirs(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_setlinefish(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_trout(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fallfishing(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_steelhead(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_whitejubherring(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sturgeon(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_shellfishcrab(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_shellfishlobster(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_deer(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_bear(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_elk(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_moose(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_buffalo(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_antelope(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sikebull(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_bighorn(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_javelina(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cougar(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_anterless(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_pheasant(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_goose(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_duck(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_turkey(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_snowmobile(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_biggame(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_skipass(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_migbird(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_smallgame(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sturgeon2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_gun(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_bonus(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lottery(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_otherbirds(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_huntfill1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_boatindexnum(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_boatcoowner(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_hullidnum(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_yearmade(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_model(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_manufacturer(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lengt(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_hullconstruct(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_primuse(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fueltype(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_propulsion(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_modeltype(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_regexpdate_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_titlenum(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_stprimuse(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_titlestatus(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_vessel(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_specreg(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_boatfill1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_boatfill2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_boatfill3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwpermnum(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwweapontype(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwregdate_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwexpdate_in(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwpermtype(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwfill1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwfill2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwfill3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwfill4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_miscfill1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_miscfill2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_miscfill3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_miscfill4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_miscfill5(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother3(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother5(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother6(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother7(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother8(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother9(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fillerother10(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_eor(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_stuff(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dob_str(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_regdate(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dateofcontr(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lastdayvote(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_datelicense(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_regexpdate(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwregdate(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ccwexpdate(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_title(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_fname(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mname(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lname(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_score_on_input(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_prep_resaddress1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_prep_resaddress2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_resrawaid(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_prep_mailaddress1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_prep_mailaddress2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_mailrawaid(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_prep_cassaddress1(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_prep_cassaddress2(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_append_cassrawaid(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_prim_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_predir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_prim_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_addr_suffix(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_postdir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_unit_desig(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_sec_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_p_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_v_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_zip4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_cart(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_cr_sort_sz(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_lot(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_lot_order(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_dpbc(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_chk_digit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_record_type(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_ace_fips_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_fipscounty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_geo_lat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_geo_long(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_msa(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_geo_blk(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_geo_match(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_resclean_err_stat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_prim_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_predir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_prim_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_addr_suffix(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_postdir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_unit_desig(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_sec_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_p_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_v_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_zip4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_cart(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_cr_sort_sz(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_lot(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_lot_order(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_dpbc(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_chk_digit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_record_type(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_ace_fips_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_fipscounty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_geo_lat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_geo_long(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_msa(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_geo_blk(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_geo_match(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_aid_mailclean_err_stat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_predir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cart(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lot(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_county(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_msa(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_prim_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_predir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_prim_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_addr_suffix(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_postdir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_unit_desig(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_sec_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_p_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_v_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_ace_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_cart(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_cr_sort_sz(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_lot(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_lot_order(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_dpbc(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_chk_digit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_record_type(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_ace_fips_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_fipscounty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_geo_lat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_geo_long(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_msa(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_geo_blk(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_geo_match(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_mail_err_stat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_prim_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_predir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_prim_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_addr_suffix(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_postdir(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_unit_desig(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_sec_range(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_p_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_v_city_name(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_ace_zip(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_zip4(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_cart(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_cr_sort_sz(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_lot(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_lot_order(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_dpbc(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_chk_digit(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_record_type(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_ace_fips_st(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_fipscounty(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_geo_lat(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_geo_long(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_msa(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_geo_blk(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_geo_match(TotalErrors.ErrorNum),HVCCW_Fields.InValidMessage_cass_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_eMerges, HVCCW_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
