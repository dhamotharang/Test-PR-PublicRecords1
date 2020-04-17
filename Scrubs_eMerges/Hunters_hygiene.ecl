IMPORT SALT311,STD;
EXPORT Hunters_hygiene(dataset(Hunters_layout_eMerges) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
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
    populated_regdate_cnt := COUNT(GROUP,h.regdate <> (TYPEOF(h.regdate))'');
    populated_regdate_pcnt := AVE(GROUP,IF(h.regdate = (TYPEOF(h.regdate))'',0,100));
    maxlength_regdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate)));
    avelength_regdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate)),h.regdate<>(typeof(h.regdate))'');
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
    populated_historyfiller_cnt := COUNT(GROUP,h.historyfiller <> (TYPEOF(h.historyfiller))'');
    populated_historyfiller_pcnt := AVE(GROUP,IF(h.historyfiller = (TYPEOF(h.historyfiller))'',0,100));
    maxlength_historyfiller := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.historyfiller)));
    avelength_historyfiller := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.historyfiller)),h.historyfiller<>(typeof(h.historyfiller))'');
    populated_huntfishperm_cnt := COUNT(GROUP,h.huntfishperm <> (TYPEOF(h.huntfishperm))'');
    populated_huntfishperm_pcnt := AVE(GROUP,IF(h.huntfishperm = (TYPEOF(h.huntfishperm))'',0,100));
    maxlength_huntfishperm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfishperm)));
    avelength_huntfishperm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.huntfishperm)),h.huntfishperm<>(typeof(h.huntfishperm))'');
    populated_license_type_mapped_cnt := COUNT(GROUP,h.license_type_mapped <> (TYPEOF(h.license_type_mapped))'');
    populated_license_type_mapped_pcnt := AVE(GROUP,IF(h.license_type_mapped = (TYPEOF(h.license_type_mapped))'',0,100));
    maxlength_license_type_mapped := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_type_mapped)));
    avelength_license_type_mapped := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.license_type_mapped)),h.license_type_mapped<>(typeof(h.license_type_mapped))'');
    populated_datelicense_cnt := COUNT(GROUP,h.datelicense <> (TYPEOF(h.datelicense))'');
    populated_datelicense_pcnt := AVE(GROUP,IF(h.datelicense = (TYPEOF(h.datelicense))'',0,100));
    maxlength_datelicense := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelicense)));
    avelength_datelicense := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelicense)),h.datelicense<>(typeof(h.datelicense))'');
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
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
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
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_did_out_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_file_id_pcnt *   0.00 / 100 + T.Populated_vendor_id_pcnt *   0.00 / 100 + T.Populated_source_state_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_file_acquired_date_pcnt *   0.00 / 100 + T.Populated__use_pcnt *   0.00 / 100 + T.Populated_title_in_pcnt *   0.00 / 100 + T.Populated_lname_in_pcnt *   0.00 / 100 + T.Populated_fname_in_pcnt *   0.00 / 100 + T.Populated_mname_in_pcnt *   0.00 / 100 + T.Populated_maiden_prior_pcnt *   0.00 / 100 + T.Populated_name_suffix_in_pcnt *   0.00 / 100 + T.Populated_votefiller_pcnt *   0.00 / 100 + T.Populated_source_voterid_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_agecat_pcnt *   0.00 / 100 + T.Populated_headhousehold_pcnt *   0.00 / 100 + T.Populated_place_of_birth_pcnt *   0.00 / 100 + T.Populated_occupation_pcnt *   0.00 / 100 + T.Populated_maiden_name_pcnt *   0.00 / 100 + T.Populated_motorvoterid_pcnt *   0.00 / 100 + T.Populated_regsource_pcnt *   0.00 / 100 + T.Populated_regdate_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_poliparty_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100 + T.Populated_other_phone_pcnt *   0.00 / 100 + T.Populated_active_status_pcnt *   0.00 / 100 + T.Populated_votefiller2_pcnt *   0.00 / 100 + T.Populated_active_other_pcnt *   0.00 / 100 + T.Populated_voterstatus_pcnt *   0.00 / 100 + T.Populated_resaddr1_pcnt *   0.00 / 100 + T.Populated_resaddr2_pcnt *   0.00 / 100 + T.Populated_res_city_pcnt *   0.00 / 100 + T.Populated_res_state_pcnt *   0.00 / 100 + T.Populated_res_zip_pcnt *   0.00 / 100 + T.Populated_res_county_pcnt *   0.00 / 100 + T.Populated_mail_addr1_pcnt *   0.00 / 100 + T.Populated_mail_addr2_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_mail_county_pcnt *   0.00 / 100 + T.Populated_historyfiller_pcnt *   0.00 / 100 + T.Populated_huntfishperm_pcnt *   0.00 / 100 + T.Populated_license_type_mapped_pcnt *   0.00 / 100 + T.Populated_datelicense_pcnt *   0.00 / 100 + T.Populated_homestate_pcnt *   0.00 / 100 + T.Populated_resident_pcnt *   0.00 / 100 + T.Populated_nonresident_pcnt *   0.00 / 100 + T.Populated_hunt_pcnt *   0.00 / 100 + T.Populated_fish_pcnt *   0.00 / 100 + T.Populated_combosuper_pcnt *   0.00 / 100 + T.Populated_sportsman_pcnt *   0.00 / 100 + T.Populated_trap_pcnt *   0.00 / 100 + T.Populated_archery_pcnt *   0.00 / 100 + T.Populated_muzzle_pcnt *   0.00 / 100 + T.Populated_drawing_pcnt *   0.00 / 100 + T.Populated_day1_pcnt *   0.00 / 100 + T.Populated_day3_pcnt *   0.00 / 100 + T.Populated_day7_pcnt *   0.00 / 100 + T.Populated_day14to15_pcnt *   0.00 / 100 + T.Populated_dayfiller_pcnt *   0.00 / 100 + T.Populated_seasonannual_pcnt *   0.00 / 100 + T.Populated_lifetimepermit_pcnt *   0.00 / 100 + T.Populated_landowner_pcnt *   0.00 / 100 + T.Populated_family_pcnt *   0.00 / 100 + T.Populated_junior_pcnt *   0.00 / 100 + T.Populated_seniorcit_pcnt *   0.00 / 100 + T.Populated_crewmemeber_pcnt *   0.00 / 100 + T.Populated_retarded_pcnt *   0.00 / 100 + T.Populated_indian_pcnt *   0.00 / 100 + T.Populated_serviceman_pcnt *   0.00 / 100 + T.Populated_disabled_pcnt *   0.00 / 100 + T.Populated_lowincome_pcnt *   0.00 / 100 + T.Populated_regioncounty_pcnt *   0.00 / 100 + T.Populated_blind_pcnt *   0.00 / 100 + T.Populated_huntfiller_pcnt *   0.00 / 100 + T.Populated_salmon_pcnt *   0.00 / 100 + T.Populated_freshwater_pcnt *   0.00 / 100 + T.Populated_saltwater_pcnt *   0.00 / 100 + T.Populated_lakesandresevoirs_pcnt *   0.00 / 100 + T.Populated_setlinefish_pcnt *   0.00 / 100 + T.Populated_trout_pcnt *   0.00 / 100 + T.Populated_fallfishing_pcnt *   0.00 / 100 + T.Populated_steelhead_pcnt *   0.00 / 100 + T.Populated_whitejubherring_pcnt *   0.00 / 100 + T.Populated_sturgeon_pcnt *   0.00 / 100 + T.Populated_shellfishcrab_pcnt *   0.00 / 100 + T.Populated_shellfishlobster_pcnt *   0.00 / 100 + T.Populated_deer_pcnt *   0.00 / 100 + T.Populated_bear_pcnt *   0.00 / 100 + T.Populated_elk_pcnt *   0.00 / 100 + T.Populated_moose_pcnt *   0.00 / 100 + T.Populated_buffalo_pcnt *   0.00 / 100 + T.Populated_antelope_pcnt *   0.00 / 100 + T.Populated_sikebull_pcnt *   0.00 / 100 + T.Populated_bighorn_pcnt *   0.00 / 100 + T.Populated_javelina_pcnt *   0.00 / 100 + T.Populated_cougar_pcnt *   0.00 / 100 + T.Populated_anterless_pcnt *   0.00 / 100 + T.Populated_pheasant_pcnt *   0.00 / 100 + T.Populated_goose_pcnt *   0.00 / 100 + T.Populated_duck_pcnt *   0.00 / 100 + T.Populated_turkey_pcnt *   0.00 / 100 + T.Populated_snowmobile_pcnt *   0.00 / 100 + T.Populated_biggame_pcnt *   0.00 / 100 + T.Populated_skipass_pcnt *   0.00 / 100 + T.Populated_migbird_pcnt *   0.00 / 100 + T.Populated_smallgame_pcnt *   0.00 / 100 + T.Populated_sturgeon2_pcnt *   0.00 / 100 + T.Populated_gun_pcnt *   0.00 / 100 + T.Populated_bonus_pcnt *   0.00 / 100 + T.Populated_lottery_pcnt *   0.00 / 100 + T.Populated_otherbirds_pcnt *   0.00 / 100 + T.Populated_huntfill1_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_score_on_input_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_mail_prim_range_pcnt *   0.00 / 100 + T.Populated_mail_predir_pcnt *   0.00 / 100 + T.Populated_mail_prim_name_pcnt *   0.00 / 100 + T.Populated_mail_addr_suffix_pcnt *   0.00 / 100 + T.Populated_mail_postdir_pcnt *   0.00 / 100 + T.Populated_mail_unit_desig_pcnt *   0.00 / 100 + T.Populated_mail_sec_range_pcnt *   0.00 / 100 + T.Populated_mail_p_city_name_pcnt *   0.00 / 100 + T.Populated_mail_v_city_name_pcnt *   0.00 / 100 + T.Populated_mail_st_pcnt *   0.00 / 100 + T.Populated_mail_ace_zip_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_mail_cart_pcnt *   0.00 / 100 + T.Populated_mail_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_mail_lot_pcnt *   0.00 / 100 + T.Populated_mail_lot_order_pcnt *   0.00 / 100 + T.Populated_mail_dpbc_pcnt *   0.00 / 100 + T.Populated_mail_chk_digit_pcnt *   0.00 / 100 + T.Populated_mail_record_type_pcnt *   0.00 / 100 + T.Populated_mail_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_mail_fipscounty_pcnt *   0.00 / 100 + T.Populated_mail_geo_lat_pcnt *   0.00 / 100 + T.Populated_mail_geo_long_pcnt *   0.00 / 100 + T.Populated_mail_msa_pcnt *   0.00 / 100 + T.Populated_mail_geo_blk_pcnt *   0.00 / 100 + T.Populated_mail_geo_match_pcnt *   0.00 / 100 + T.Populated_mail_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','historyfiller','huntfishperm','license_type_mapped','datelicense','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_persistent_record_id_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_score_pcnt,le.populated_best_ssn_pcnt,le.populated_did_out_pcnt,le.populated_source_pcnt,le.populated_file_id_pcnt,le.populated_vendor_id_pcnt,le.populated_source_state_pcnt,le.populated_source_code_pcnt,le.populated_file_acquired_date_pcnt,le.populated__use_pcnt,le.populated_title_in_pcnt,le.populated_lname_in_pcnt,le.populated_fname_in_pcnt,le.populated_mname_in_pcnt,le.populated_maiden_prior_pcnt,le.populated_name_suffix_in_pcnt,le.populated_votefiller_pcnt,le.populated_source_voterid_pcnt,le.populated_dob_pcnt,le.populated_agecat_pcnt,le.populated_headhousehold_pcnt,le.populated_place_of_birth_pcnt,le.populated_occupation_pcnt,le.populated_maiden_name_pcnt,le.populated_motorvoterid_pcnt,le.populated_regsource_pcnt,le.populated_regdate_pcnt,le.populated_race_pcnt,le.populated_gender_pcnt,le.populated_poliparty_pcnt,le.populated_phone_pcnt,le.populated_work_phone_pcnt,le.populated_other_phone_pcnt,le.populated_active_status_pcnt,le.populated_votefiller2_pcnt,le.populated_active_other_pcnt,le.populated_voterstatus_pcnt,le.populated_resaddr1_pcnt,le.populated_resaddr2_pcnt,le.populated_res_city_pcnt,le.populated_res_state_pcnt,le.populated_res_zip_pcnt,le.populated_res_county_pcnt,le.populated_mail_addr1_pcnt,le.populated_mail_addr2_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_pcnt,le.populated_mail_county_pcnt,le.populated_historyfiller_pcnt,le.populated_huntfishperm_pcnt,le.populated_license_type_mapped_pcnt,le.populated_datelicense_pcnt,le.populated_homestate_pcnt,le.populated_resident_pcnt,le.populated_nonresident_pcnt,le.populated_hunt_pcnt,le.populated_fish_pcnt,le.populated_combosuper_pcnt,le.populated_sportsman_pcnt,le.populated_trap_pcnt,le.populated_archery_pcnt,le.populated_muzzle_pcnt,le.populated_drawing_pcnt,le.populated_day1_pcnt,le.populated_day3_pcnt,le.populated_day7_pcnt,le.populated_day14to15_pcnt,le.populated_dayfiller_pcnt,le.populated_seasonannual_pcnt,le.populated_lifetimepermit_pcnt,le.populated_landowner_pcnt,le.populated_family_pcnt,le.populated_junior_pcnt,le.populated_seniorcit_pcnt,le.populated_crewmemeber_pcnt,le.populated_retarded_pcnt,le.populated_indian_pcnt,le.populated_serviceman_pcnt,le.populated_disabled_pcnt,le.populated_lowincome_pcnt,le.populated_regioncounty_pcnt,le.populated_blind_pcnt,le.populated_huntfiller_pcnt,le.populated_salmon_pcnt,le.populated_freshwater_pcnt,le.populated_saltwater_pcnt,le.populated_lakesandresevoirs_pcnt,le.populated_setlinefish_pcnt,le.populated_trout_pcnt,le.populated_fallfishing_pcnt,le.populated_steelhead_pcnt,le.populated_whitejubherring_pcnt,le.populated_sturgeon_pcnt,le.populated_shellfishcrab_pcnt,le.populated_shellfishlobster_pcnt,le.populated_deer_pcnt,le.populated_bear_pcnt,le.populated_elk_pcnt,le.populated_moose_pcnt,le.populated_buffalo_pcnt,le.populated_antelope_pcnt,le.populated_sikebull_pcnt,le.populated_bighorn_pcnt,le.populated_javelina_pcnt,le.populated_cougar_pcnt,le.populated_anterless_pcnt,le.populated_pheasant_pcnt,le.populated_goose_pcnt,le.populated_duck_pcnt,le.populated_turkey_pcnt,le.populated_snowmobile_pcnt,le.populated_biggame_pcnt,le.populated_skipass_pcnt,le.populated_migbird_pcnt,le.populated_smallgame_pcnt,le.populated_sturgeon2_pcnt,le.populated_gun_pcnt,le.populated_bonus_pcnt,le.populated_lottery_pcnt,le.populated_otherbirds_pcnt,le.populated_huntfill1_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_score_on_input_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_record_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_county_name_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_mail_prim_range_pcnt,le.populated_mail_predir_pcnt,le.populated_mail_prim_name_pcnt,le.populated_mail_addr_suffix_pcnt,le.populated_mail_postdir_pcnt,le.populated_mail_unit_desig_pcnt,le.populated_mail_sec_range_pcnt,le.populated_mail_p_city_name_pcnt,le.populated_mail_v_city_name_pcnt,le.populated_mail_st_pcnt,le.populated_mail_ace_zip_pcnt,le.populated_mail_zip4_pcnt,le.populated_mail_cart_pcnt,le.populated_mail_cr_sort_sz_pcnt,le.populated_mail_lot_pcnt,le.populated_mail_lot_order_pcnt,le.populated_mail_dpbc_pcnt,le.populated_mail_chk_digit_pcnt,le.populated_mail_record_type_pcnt,le.populated_mail_ace_fips_st_pcnt,le.populated_mail_fipscounty_pcnt,le.populated_mail_geo_lat_pcnt,le.populated_mail_geo_long_pcnt,le.populated_mail_msa_pcnt,le.populated_mail_geo_blk_pcnt,le.populated_mail_geo_match_pcnt,le.populated_mail_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_persistent_record_id,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_score,le.maxlength_best_ssn,le.maxlength_did_out,le.maxlength_source,le.maxlength_file_id,le.maxlength_vendor_id,le.maxlength_source_state,le.maxlength_source_code,le.maxlength_file_acquired_date,le.maxlength__use,le.maxlength_title_in,le.maxlength_lname_in,le.maxlength_fname_in,le.maxlength_mname_in,le.maxlength_maiden_prior,le.maxlength_name_suffix_in,le.maxlength_votefiller,le.maxlength_source_voterid,le.maxlength_dob,le.maxlength_agecat,le.maxlength_headhousehold,le.maxlength_place_of_birth,le.maxlength_occupation,le.maxlength_maiden_name,le.maxlength_motorvoterid,le.maxlength_regsource,le.maxlength_regdate,le.maxlength_race,le.maxlength_gender,le.maxlength_poliparty,le.maxlength_phone,le.maxlength_work_phone,le.maxlength_other_phone,le.maxlength_active_status,le.maxlength_votefiller2,le.maxlength_active_other,le.maxlength_voterstatus,le.maxlength_resaddr1,le.maxlength_resaddr2,le.maxlength_res_city,le.maxlength_res_state,le.maxlength_res_zip,le.maxlength_res_county,le.maxlength_mail_addr1,le.maxlength_mail_addr2,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip,le.maxlength_mail_county,le.maxlength_historyfiller,le.maxlength_huntfishperm,le.maxlength_license_type_mapped,le.maxlength_datelicense,le.maxlength_homestate,le.maxlength_resident,le.maxlength_nonresident,le.maxlength_hunt,le.maxlength_fish,le.maxlength_combosuper,le.maxlength_sportsman,le.maxlength_trap,le.maxlength_archery,le.maxlength_muzzle,le.maxlength_drawing,le.maxlength_day1,le.maxlength_day3,le.maxlength_day7,le.maxlength_day14to15,le.maxlength_dayfiller,le.maxlength_seasonannual,le.maxlength_lifetimepermit,le.maxlength_landowner,le.maxlength_family,le.maxlength_junior,le.maxlength_seniorcit,le.maxlength_crewmemeber,le.maxlength_retarded,le.maxlength_indian,le.maxlength_serviceman,le.maxlength_disabled,le.maxlength_lowincome,le.maxlength_regioncounty,le.maxlength_blind,le.maxlength_huntfiller,le.maxlength_salmon,le.maxlength_freshwater,le.maxlength_saltwater,le.maxlength_lakesandresevoirs,le.maxlength_setlinefish,le.maxlength_trout,le.maxlength_fallfishing,le.maxlength_steelhead,le.maxlength_whitejubherring,le.maxlength_sturgeon,le.maxlength_shellfishcrab,le.maxlength_shellfishlobster,le.maxlength_deer,le.maxlength_bear,le.maxlength_elk,le.maxlength_moose,le.maxlength_buffalo,le.maxlength_antelope,le.maxlength_sikebull,le.maxlength_bighorn,le.maxlength_javelina,le.maxlength_cougar,le.maxlength_anterless,le.maxlength_pheasant,le.maxlength_goose,le.maxlength_duck,le.maxlength_turkey,le.maxlength_snowmobile,le.maxlength_biggame,le.maxlength_skipass,le.maxlength_migbird,le.maxlength_smallgame,le.maxlength_sturgeon2,le.maxlength_gun,le.maxlength_bonus,le.maxlength_lottery,le.maxlength_otherbirds,le.maxlength_huntfill1,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_score_on_input,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_record_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_county_name,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_mail_prim_range,le.maxlength_mail_predir,le.maxlength_mail_prim_name,le.maxlength_mail_addr_suffix,le.maxlength_mail_postdir,le.maxlength_mail_unit_desig,le.maxlength_mail_sec_range,le.maxlength_mail_p_city_name,le.maxlength_mail_v_city_name,le.maxlength_mail_st,le.maxlength_mail_ace_zip,le.maxlength_mail_zip4,le.maxlength_mail_cart,le.maxlength_mail_cr_sort_sz,le.maxlength_mail_lot,le.maxlength_mail_lot_order,le.maxlength_mail_dpbc,le.maxlength_mail_chk_digit,le.maxlength_mail_record_type,le.maxlength_mail_ace_fips_st,le.maxlength_mail_fipscounty,le.maxlength_mail_geo_lat,le.maxlength_mail_geo_long,le.maxlength_mail_msa,le.maxlength_mail_geo_blk,le.maxlength_mail_geo_match,le.maxlength_mail_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_persistent_record_id,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_score,le.avelength_best_ssn,le.avelength_did_out,le.avelength_source,le.avelength_file_id,le.avelength_vendor_id,le.avelength_source_state,le.avelength_source_code,le.avelength_file_acquired_date,le.avelength__use,le.avelength_title_in,le.avelength_lname_in,le.avelength_fname_in,le.avelength_mname_in,le.avelength_maiden_prior,le.avelength_name_suffix_in,le.avelength_votefiller,le.avelength_source_voterid,le.avelength_dob,le.avelength_agecat,le.avelength_headhousehold,le.avelength_place_of_birth,le.avelength_occupation,le.avelength_maiden_name,le.avelength_motorvoterid,le.avelength_regsource,le.avelength_regdate,le.avelength_race,le.avelength_gender,le.avelength_poliparty,le.avelength_phone,le.avelength_work_phone,le.avelength_other_phone,le.avelength_active_status,le.avelength_votefiller2,le.avelength_active_other,le.avelength_voterstatus,le.avelength_resaddr1,le.avelength_resaddr2,le.avelength_res_city,le.avelength_res_state,le.avelength_res_zip,le.avelength_res_county,le.avelength_mail_addr1,le.avelength_mail_addr2,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip,le.avelength_mail_county,le.avelength_historyfiller,le.avelength_huntfishperm,le.avelength_license_type_mapped,le.avelength_datelicense,le.avelength_homestate,le.avelength_resident,le.avelength_nonresident,le.avelength_hunt,le.avelength_fish,le.avelength_combosuper,le.avelength_sportsman,le.avelength_trap,le.avelength_archery,le.avelength_muzzle,le.avelength_drawing,le.avelength_day1,le.avelength_day3,le.avelength_day7,le.avelength_day14to15,le.avelength_dayfiller,le.avelength_seasonannual,le.avelength_lifetimepermit,le.avelength_landowner,le.avelength_family,le.avelength_junior,le.avelength_seniorcit,le.avelength_crewmemeber,le.avelength_retarded,le.avelength_indian,le.avelength_serviceman,le.avelength_disabled,le.avelength_lowincome,le.avelength_regioncounty,le.avelength_blind,le.avelength_huntfiller,le.avelength_salmon,le.avelength_freshwater,le.avelength_saltwater,le.avelength_lakesandresevoirs,le.avelength_setlinefish,le.avelength_trout,le.avelength_fallfishing,le.avelength_steelhead,le.avelength_whitejubherring,le.avelength_sturgeon,le.avelength_shellfishcrab,le.avelength_shellfishlobster,le.avelength_deer,le.avelength_bear,le.avelength_elk,le.avelength_moose,le.avelength_buffalo,le.avelength_antelope,le.avelength_sikebull,le.avelength_bighorn,le.avelength_javelina,le.avelength_cougar,le.avelength_anterless,le.avelength_pheasant,le.avelength_goose,le.avelength_duck,le.avelength_turkey,le.avelength_snowmobile,le.avelength_biggame,le.avelength_skipass,le.avelength_migbird,le.avelength_smallgame,le.avelength_sturgeon2,le.avelength_gun,le.avelength_bonus,le.avelength_lottery,le.avelength_otherbirds,le.avelength_huntfill1,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_score_on_input,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_record_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_county_name,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_mail_prim_range,le.avelength_mail_predir,le.avelength_mail_prim_name,le.avelength_mail_addr_suffix,le.avelength_mail_postdir,le.avelength_mail_unit_desig,le.avelength_mail_sec_range,le.avelength_mail_p_city_name,le.avelength_mail_v_city_name,le.avelength_mail_st,le.avelength_mail_ace_zip,le.avelength_mail_zip4,le.avelength_mail_cart,le.avelength_mail_cr_sort_sz,le.avelength_mail_lot,le.avelength_mail_lot_order,le.avelength_mail_dpbc,le.avelength_mail_chk_digit,le.avelength_mail_record_type,le.avelength_mail_ace_fips_st,le.avelength_mail_fipscounty,le.avelength_mail_geo_lat,le.avelength_mail_geo_long,le.avelength_mail_msa,le.avelength_mail_geo_blk,le.avelength_mail_geo_match,le.avelength_mail_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 187, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.historyfiller),TRIM((SALT311.StrType)le.huntfishperm),TRIM((SALT311.StrType)le.license_type_mapped),TRIM((SALT311.StrType)le.datelicense),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.resident),TRIM((SALT311.StrType)le.nonresident),TRIM((SALT311.StrType)le.hunt),TRIM((SALT311.StrType)le.fish),TRIM((SALT311.StrType)le.combosuper),TRIM((SALT311.StrType)le.sportsman),TRIM((SALT311.StrType)le.trap),TRIM((SALT311.StrType)le.archery),TRIM((SALT311.StrType)le.muzzle),TRIM((SALT311.StrType)le.drawing),TRIM((SALT311.StrType)le.day1),TRIM((SALT311.StrType)le.day3),TRIM((SALT311.StrType)le.day7),TRIM((SALT311.StrType)le.day14to15),TRIM((SALT311.StrType)le.dayfiller),TRIM((SALT311.StrType)le.seasonannual),TRIM((SALT311.StrType)le.lifetimepermit),TRIM((SALT311.StrType)le.landowner),TRIM((SALT311.StrType)le.family),TRIM((SALT311.StrType)le.junior),TRIM((SALT311.StrType)le.seniorcit),TRIM((SALT311.StrType)le.crewmemeber),TRIM((SALT311.StrType)le.retarded),TRIM((SALT311.StrType)le.indian),TRIM((SALT311.StrType)le.serviceman),TRIM((SALT311.StrType)le.disabled),TRIM((SALT311.StrType)le.lowincome),TRIM((SALT311.StrType)le.regioncounty),TRIM((SALT311.StrType)le.blind),TRIM((SALT311.StrType)le.huntfiller),TRIM((SALT311.StrType)le.salmon),TRIM((SALT311.StrType)le.freshwater),TRIM((SALT311.StrType)le.saltwater),TRIM((SALT311.StrType)le.lakesandresevoirs),TRIM((SALT311.StrType)le.setlinefish),TRIM((SALT311.StrType)le.trout),TRIM((SALT311.StrType)le.fallfishing),TRIM((SALT311.StrType)le.steelhead),TRIM((SALT311.StrType)le.whitejubherring),TRIM((SALT311.StrType)le.sturgeon),TRIM((SALT311.StrType)le.shellfishcrab),TRIM((SALT311.StrType)le.shellfishlobster),TRIM((SALT311.StrType)le.deer),TRIM((SALT311.StrType)le.bear),TRIM((SALT311.StrType)le.elk),TRIM((SALT311.StrType)le.moose),TRIM((SALT311.StrType)le.buffalo),TRIM((SALT311.StrType)le.antelope),TRIM((SALT311.StrType)le.sikebull),TRIM((SALT311.StrType)le.bighorn),TRIM((SALT311.StrType)le.javelina),TRIM((SALT311.StrType)le.cougar),TRIM((SALT311.StrType)le.anterless),TRIM((SALT311.StrType)le.pheasant),TRIM((SALT311.StrType)le.goose),TRIM((SALT311.StrType)le.duck),TRIM((SALT311.StrType)le.turkey),TRIM((SALT311.StrType)le.snowmobile),TRIM((SALT311.StrType)le.biggame),TRIM((SALT311.StrType)le.skipass),TRIM((SALT311.StrType)le.migbird),TRIM((SALT311.StrType)le.smallgame),TRIM((SALT311.StrType)le.sturgeon2),TRIM((SALT311.StrType)le.gun),TRIM((SALT311.StrType)le.bonus),TRIM((SALT311.StrType)le.lottery),TRIM((SALT311.StrType)le.otherbirds),TRIM((SALT311.StrType)le.huntfill1),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,187,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 187);
  SELF.FldNo2 := 1 + (C % 187);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.historyfiller),TRIM((SALT311.StrType)le.huntfishperm),TRIM((SALT311.StrType)le.license_type_mapped),TRIM((SALT311.StrType)le.datelicense),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.resident),TRIM((SALT311.StrType)le.nonresident),TRIM((SALT311.StrType)le.hunt),TRIM((SALT311.StrType)le.fish),TRIM((SALT311.StrType)le.combosuper),TRIM((SALT311.StrType)le.sportsman),TRIM((SALT311.StrType)le.trap),TRIM((SALT311.StrType)le.archery),TRIM((SALT311.StrType)le.muzzle),TRIM((SALT311.StrType)le.drawing),TRIM((SALT311.StrType)le.day1),TRIM((SALT311.StrType)le.day3),TRIM((SALT311.StrType)le.day7),TRIM((SALT311.StrType)le.day14to15),TRIM((SALT311.StrType)le.dayfiller),TRIM((SALT311.StrType)le.seasonannual),TRIM((SALT311.StrType)le.lifetimepermit),TRIM((SALT311.StrType)le.landowner),TRIM((SALT311.StrType)le.family),TRIM((SALT311.StrType)le.junior),TRIM((SALT311.StrType)le.seniorcit),TRIM((SALT311.StrType)le.crewmemeber),TRIM((SALT311.StrType)le.retarded),TRIM((SALT311.StrType)le.indian),TRIM((SALT311.StrType)le.serviceman),TRIM((SALT311.StrType)le.disabled),TRIM((SALT311.StrType)le.lowincome),TRIM((SALT311.StrType)le.regioncounty),TRIM((SALT311.StrType)le.blind),TRIM((SALT311.StrType)le.huntfiller),TRIM((SALT311.StrType)le.salmon),TRIM((SALT311.StrType)le.freshwater),TRIM((SALT311.StrType)le.saltwater),TRIM((SALT311.StrType)le.lakesandresevoirs),TRIM((SALT311.StrType)le.setlinefish),TRIM((SALT311.StrType)le.trout),TRIM((SALT311.StrType)le.fallfishing),TRIM((SALT311.StrType)le.steelhead),TRIM((SALT311.StrType)le.whitejubherring),TRIM((SALT311.StrType)le.sturgeon),TRIM((SALT311.StrType)le.shellfishcrab),TRIM((SALT311.StrType)le.shellfishlobster),TRIM((SALT311.StrType)le.deer),TRIM((SALT311.StrType)le.bear),TRIM((SALT311.StrType)le.elk),TRIM((SALT311.StrType)le.moose),TRIM((SALT311.StrType)le.buffalo),TRIM((SALT311.StrType)le.antelope),TRIM((SALT311.StrType)le.sikebull),TRIM((SALT311.StrType)le.bighorn),TRIM((SALT311.StrType)le.javelina),TRIM((SALT311.StrType)le.cougar),TRIM((SALT311.StrType)le.anterless),TRIM((SALT311.StrType)le.pheasant),TRIM((SALT311.StrType)le.goose),TRIM((SALT311.StrType)le.duck),TRIM((SALT311.StrType)le.turkey),TRIM((SALT311.StrType)le.snowmobile),TRIM((SALT311.StrType)le.biggame),TRIM((SALT311.StrType)le.skipass),TRIM((SALT311.StrType)le.migbird),TRIM((SALT311.StrType)le.smallgame),TRIM((SALT311.StrType)le.sturgeon2),TRIM((SALT311.StrType)le.gun),TRIM((SALT311.StrType)le.bonus),TRIM((SALT311.StrType)le.lottery),TRIM((SALT311.StrType)le.otherbirds),TRIM((SALT311.StrType)le.huntfill1),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.historyfiller),TRIM((SALT311.StrType)le.huntfishperm),TRIM((SALT311.StrType)le.license_type_mapped),TRIM((SALT311.StrType)le.datelicense),TRIM((SALT311.StrType)le.homestate),TRIM((SALT311.StrType)le.resident),TRIM((SALT311.StrType)le.nonresident),TRIM((SALT311.StrType)le.hunt),TRIM((SALT311.StrType)le.fish),TRIM((SALT311.StrType)le.combosuper),TRIM((SALT311.StrType)le.sportsman),TRIM((SALT311.StrType)le.trap),TRIM((SALT311.StrType)le.archery),TRIM((SALT311.StrType)le.muzzle),TRIM((SALT311.StrType)le.drawing),TRIM((SALT311.StrType)le.day1),TRIM((SALT311.StrType)le.day3),TRIM((SALT311.StrType)le.day7),TRIM((SALT311.StrType)le.day14to15),TRIM((SALT311.StrType)le.dayfiller),TRIM((SALT311.StrType)le.seasonannual),TRIM((SALT311.StrType)le.lifetimepermit),TRIM((SALT311.StrType)le.landowner),TRIM((SALT311.StrType)le.family),TRIM((SALT311.StrType)le.junior),TRIM((SALT311.StrType)le.seniorcit),TRIM((SALT311.StrType)le.crewmemeber),TRIM((SALT311.StrType)le.retarded),TRIM((SALT311.StrType)le.indian),TRIM((SALT311.StrType)le.serviceman),TRIM((SALT311.StrType)le.disabled),TRIM((SALT311.StrType)le.lowincome),TRIM((SALT311.StrType)le.regioncounty),TRIM((SALT311.StrType)le.blind),TRIM((SALT311.StrType)le.huntfiller),TRIM((SALT311.StrType)le.salmon),TRIM((SALT311.StrType)le.freshwater),TRIM((SALT311.StrType)le.saltwater),TRIM((SALT311.StrType)le.lakesandresevoirs),TRIM((SALT311.StrType)le.setlinefish),TRIM((SALT311.StrType)le.trout),TRIM((SALT311.StrType)le.fallfishing),TRIM((SALT311.StrType)le.steelhead),TRIM((SALT311.StrType)le.whitejubherring),TRIM((SALT311.StrType)le.sturgeon),TRIM((SALT311.StrType)le.shellfishcrab),TRIM((SALT311.StrType)le.shellfishlobster),TRIM((SALT311.StrType)le.deer),TRIM((SALT311.StrType)le.bear),TRIM((SALT311.StrType)le.elk),TRIM((SALT311.StrType)le.moose),TRIM((SALT311.StrType)le.buffalo),TRIM((SALT311.StrType)le.antelope),TRIM((SALT311.StrType)le.sikebull),TRIM((SALT311.StrType)le.bighorn),TRIM((SALT311.StrType)le.javelina),TRIM((SALT311.StrType)le.cougar),TRIM((SALT311.StrType)le.anterless),TRIM((SALT311.StrType)le.pheasant),TRIM((SALT311.StrType)le.goose),TRIM((SALT311.StrType)le.duck),TRIM((SALT311.StrType)le.turkey),TRIM((SALT311.StrType)le.snowmobile),TRIM((SALT311.StrType)le.biggame),TRIM((SALT311.StrType)le.skipass),TRIM((SALT311.StrType)le.migbird),TRIM((SALT311.StrType)le.smallgame),TRIM((SALT311.StrType)le.sturgeon2),TRIM((SALT311.StrType)le.gun),TRIM((SALT311.StrType)le.bonus),TRIM((SALT311.StrType)le.lottery),TRIM((SALT311.StrType)le.otherbirds),TRIM((SALT311.StrType)le.huntfill1),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),187*187,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'persistent_record_id'}
      ,{2,'process_date'}
      ,{3,'date_first_seen'}
      ,{4,'date_last_seen'}
      ,{5,'score'}
      ,{6,'best_ssn'}
      ,{7,'did_out'}
      ,{8,'source'}
      ,{9,'file_id'}
      ,{10,'vendor_id'}
      ,{11,'source_state'}
      ,{12,'source_code'}
      ,{13,'file_acquired_date'}
      ,{14,'_use'}
      ,{15,'title_in'}
      ,{16,'lname_in'}
      ,{17,'fname_in'}
      ,{18,'mname_in'}
      ,{19,'maiden_prior'}
      ,{20,'name_suffix_in'}
      ,{21,'votefiller'}
      ,{22,'source_voterid'}
      ,{23,'dob'}
      ,{24,'agecat'}
      ,{25,'headhousehold'}
      ,{26,'place_of_birth'}
      ,{27,'occupation'}
      ,{28,'maiden_name'}
      ,{29,'motorvoterid'}
      ,{30,'regsource'}
      ,{31,'regdate'}
      ,{32,'race'}
      ,{33,'gender'}
      ,{34,'poliparty'}
      ,{35,'phone'}
      ,{36,'work_phone'}
      ,{37,'other_phone'}
      ,{38,'active_status'}
      ,{39,'votefiller2'}
      ,{40,'active_other'}
      ,{41,'voterstatus'}
      ,{42,'resaddr1'}
      ,{43,'resaddr2'}
      ,{44,'res_city'}
      ,{45,'res_state'}
      ,{46,'res_zip'}
      ,{47,'res_county'}
      ,{48,'mail_addr1'}
      ,{49,'mail_addr2'}
      ,{50,'mail_city'}
      ,{51,'mail_state'}
      ,{52,'mail_zip'}
      ,{53,'mail_county'}
      ,{54,'historyfiller'}
      ,{55,'huntfishperm'}
      ,{56,'license_type_mapped'}
      ,{57,'datelicense'}
      ,{58,'homestate'}
      ,{59,'resident'}
      ,{60,'nonresident'}
      ,{61,'hunt'}
      ,{62,'fish'}
      ,{63,'combosuper'}
      ,{64,'sportsman'}
      ,{65,'trap'}
      ,{66,'archery'}
      ,{67,'muzzle'}
      ,{68,'drawing'}
      ,{69,'day1'}
      ,{70,'day3'}
      ,{71,'day7'}
      ,{72,'day14to15'}
      ,{73,'dayfiller'}
      ,{74,'seasonannual'}
      ,{75,'lifetimepermit'}
      ,{76,'landowner'}
      ,{77,'family'}
      ,{78,'junior'}
      ,{79,'seniorcit'}
      ,{80,'crewmemeber'}
      ,{81,'retarded'}
      ,{82,'indian'}
      ,{83,'serviceman'}
      ,{84,'disabled'}
      ,{85,'lowincome'}
      ,{86,'regioncounty'}
      ,{87,'blind'}
      ,{88,'huntfiller'}
      ,{89,'salmon'}
      ,{90,'freshwater'}
      ,{91,'saltwater'}
      ,{92,'lakesandresevoirs'}
      ,{93,'setlinefish'}
      ,{94,'trout'}
      ,{95,'fallfishing'}
      ,{96,'steelhead'}
      ,{97,'whitejubherring'}
      ,{98,'sturgeon'}
      ,{99,'shellfishcrab'}
      ,{100,'shellfishlobster'}
      ,{101,'deer'}
      ,{102,'bear'}
      ,{103,'elk'}
      ,{104,'moose'}
      ,{105,'buffalo'}
      ,{106,'antelope'}
      ,{107,'sikebull'}
      ,{108,'bighorn'}
      ,{109,'javelina'}
      ,{110,'cougar'}
      ,{111,'anterless'}
      ,{112,'pheasant'}
      ,{113,'goose'}
      ,{114,'duck'}
      ,{115,'turkey'}
      ,{116,'snowmobile'}
      ,{117,'biggame'}
      ,{118,'skipass'}
      ,{119,'migbird'}
      ,{120,'smallgame'}
      ,{121,'sturgeon2'}
      ,{122,'gun'}
      ,{123,'bonus'}
      ,{124,'lottery'}
      ,{125,'otherbirds'}
      ,{126,'huntfill1'}
      ,{127,'title'}
      ,{128,'fname'}
      ,{129,'mname'}
      ,{130,'lname'}
      ,{131,'name_suffix'}
      ,{132,'score_on_input'}
      ,{133,'prim_range'}
      ,{134,'predir'}
      ,{135,'prim_name'}
      ,{136,'suffix'}
      ,{137,'postdir'}
      ,{138,'unit_desig'}
      ,{139,'sec_range'}
      ,{140,'p_city_name'}
      ,{141,'city_name'}
      ,{142,'st'}
      ,{143,'zip'}
      ,{144,'zip4'}
      ,{145,'cart'}
      ,{146,'cr_sort_sz'}
      ,{147,'lot'}
      ,{148,'lot_order'}
      ,{149,'dpbc'}
      ,{150,'chk_digit'}
      ,{151,'record_type'}
      ,{152,'ace_fips_st'}
      ,{153,'county'}
      ,{154,'county_name'}
      ,{155,'geo_lat'}
      ,{156,'geo_long'}
      ,{157,'msa'}
      ,{158,'geo_blk'}
      ,{159,'geo_match'}
      ,{160,'err_stat'}
      ,{161,'mail_prim_range'}
      ,{162,'mail_predir'}
      ,{163,'mail_prim_name'}
      ,{164,'mail_addr_suffix'}
      ,{165,'mail_postdir'}
      ,{166,'mail_unit_desig'}
      ,{167,'mail_sec_range'}
      ,{168,'mail_p_city_name'}
      ,{169,'mail_v_city_name'}
      ,{170,'mail_st'}
      ,{171,'mail_ace_zip'}
      ,{172,'mail_zip4'}
      ,{173,'mail_cart'}
      ,{174,'mail_cr_sort_sz'}
      ,{175,'mail_lot'}
      ,{176,'mail_lot_order'}
      ,{177,'mail_dpbc'}
      ,{178,'mail_chk_digit'}
      ,{179,'mail_record_type'}
      ,{180,'mail_ace_fips_st'}
      ,{181,'mail_fipscounty'}
      ,{182,'mail_geo_lat'}
      ,{183,'mail_geo_long'}
      ,{184,'mail_msa'}
      ,{185,'mail_geo_blk'}
      ,{186,'mail_geo_match'}
      ,{187,'mail_err_stat'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Hunters_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    Hunters_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Hunters_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Hunters_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Hunters_Fields.InValid_score((SALT311.StrType)le.score),
    Hunters_Fields.InValid_best_ssn((SALT311.StrType)le.best_ssn),
    Hunters_Fields.InValid_did_out((SALT311.StrType)le.did_out),
    Hunters_Fields.InValid_source((SALT311.StrType)le.source),
    Hunters_Fields.InValid_file_id((SALT311.StrType)le.file_id),
    Hunters_Fields.InValid_vendor_id((SALT311.StrType)le.vendor_id),
    Hunters_Fields.InValid_source_state((SALT311.StrType)le.source_state),
    Hunters_Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Hunters_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date),
    Hunters_Fields.InValid__use((SALT311.StrType)le._use),
    Hunters_Fields.InValid_title_in((SALT311.StrType)le.title_in),
    Hunters_Fields.InValid_lname_in((SALT311.StrType)le.lname_in),
    Hunters_Fields.InValid_fname_in((SALT311.StrType)le.fname_in),
    Hunters_Fields.InValid_mname_in((SALT311.StrType)le.mname_in),
    Hunters_Fields.InValid_maiden_prior((SALT311.StrType)le.maiden_prior),
    Hunters_Fields.InValid_name_suffix_in((SALT311.StrType)le.name_suffix_in),
    Hunters_Fields.InValid_votefiller((SALT311.StrType)le.votefiller),
    Hunters_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid),
    Hunters_Fields.InValid_dob((SALT311.StrType)le.dob),
    Hunters_Fields.InValid_agecat((SALT311.StrType)le.agecat),
    Hunters_Fields.InValid_headhousehold((SALT311.StrType)le.headhousehold),
    Hunters_Fields.InValid_place_of_birth((SALT311.StrType)le.place_of_birth),
    Hunters_Fields.InValid_occupation((SALT311.StrType)le.occupation),
    Hunters_Fields.InValid_maiden_name((SALT311.StrType)le.maiden_name),
    Hunters_Fields.InValid_motorvoterid((SALT311.StrType)le.motorvoterid),
    Hunters_Fields.InValid_regsource((SALT311.StrType)le.regsource),
    Hunters_Fields.InValid_regdate((SALT311.StrType)le.regdate),
    Hunters_Fields.InValid_race((SALT311.StrType)le.race),
    Hunters_Fields.InValid_gender((SALT311.StrType)le.gender),
    Hunters_Fields.InValid_poliparty((SALT311.StrType)le.poliparty),
    Hunters_Fields.InValid_phone((SALT311.StrType)le.phone),
    Hunters_Fields.InValid_work_phone((SALT311.StrType)le.work_phone),
    Hunters_Fields.InValid_other_phone((SALT311.StrType)le.other_phone),
    Hunters_Fields.InValid_active_status((SALT311.StrType)le.active_status),
    Hunters_Fields.InValid_votefiller2((SALT311.StrType)le.votefiller2),
    Hunters_Fields.InValid_active_other((SALT311.StrType)le.active_other),
    Hunters_Fields.InValid_voterstatus((SALT311.StrType)le.voterstatus),
    Hunters_Fields.InValid_resaddr1((SALT311.StrType)le.resaddr1),
    Hunters_Fields.InValid_resaddr2((SALT311.StrType)le.resaddr2),
    Hunters_Fields.InValid_res_city((SALT311.StrType)le.res_city),
    Hunters_Fields.InValid_res_state((SALT311.StrType)le.res_state),
    Hunters_Fields.InValid_res_zip((SALT311.StrType)le.res_zip),
    Hunters_Fields.InValid_res_county((SALT311.StrType)le.res_county),
    Hunters_Fields.InValid_mail_addr1((SALT311.StrType)le.mail_addr1),
    Hunters_Fields.InValid_mail_addr2((SALT311.StrType)le.mail_addr2),
    Hunters_Fields.InValid_mail_city((SALT311.StrType)le.mail_city),
    Hunters_Fields.InValid_mail_state((SALT311.StrType)le.mail_state),
    Hunters_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip),
    Hunters_Fields.InValid_mail_county((SALT311.StrType)le.mail_county),
    Hunters_Fields.InValid_historyfiller((SALT311.StrType)le.historyfiller),
    Hunters_Fields.InValid_huntfishperm((SALT311.StrType)le.huntfishperm),
    Hunters_Fields.InValid_license_type_mapped((SALT311.StrType)le.license_type_mapped),
    Hunters_Fields.InValid_datelicense((SALT311.StrType)le.datelicense),
    Hunters_Fields.InValid_homestate((SALT311.StrType)le.homestate),
    Hunters_Fields.InValid_resident((SALT311.StrType)le.resident),
    Hunters_Fields.InValid_nonresident((SALT311.StrType)le.nonresident),
    Hunters_Fields.InValid_hunt((SALT311.StrType)le.hunt),
    Hunters_Fields.InValid_fish((SALT311.StrType)le.fish),
    Hunters_Fields.InValid_combosuper((SALT311.StrType)le.combosuper),
    Hunters_Fields.InValid_sportsman((SALT311.StrType)le.sportsman),
    Hunters_Fields.InValid_trap((SALT311.StrType)le.trap),
    Hunters_Fields.InValid_archery((SALT311.StrType)le.archery),
    Hunters_Fields.InValid_muzzle((SALT311.StrType)le.muzzle),
    Hunters_Fields.InValid_drawing((SALT311.StrType)le.drawing),
    Hunters_Fields.InValid_day1((SALT311.StrType)le.day1),
    Hunters_Fields.InValid_day3((SALT311.StrType)le.day3),
    Hunters_Fields.InValid_day7((SALT311.StrType)le.day7),
    Hunters_Fields.InValid_day14to15((SALT311.StrType)le.day14to15),
    Hunters_Fields.InValid_dayfiller((SALT311.StrType)le.dayfiller),
    Hunters_Fields.InValid_seasonannual((SALT311.StrType)le.seasonannual),
    Hunters_Fields.InValid_lifetimepermit((SALT311.StrType)le.lifetimepermit),
    Hunters_Fields.InValid_landowner((SALT311.StrType)le.landowner),
    Hunters_Fields.InValid_family((SALT311.StrType)le.family),
    Hunters_Fields.InValid_junior((SALT311.StrType)le.junior),
    Hunters_Fields.InValid_seniorcit((SALT311.StrType)le.seniorcit),
    Hunters_Fields.InValid_crewmemeber((SALT311.StrType)le.crewmemeber),
    Hunters_Fields.InValid_retarded((SALT311.StrType)le.retarded),
    Hunters_Fields.InValid_indian((SALT311.StrType)le.indian),
    Hunters_Fields.InValid_serviceman((SALT311.StrType)le.serviceman),
    Hunters_Fields.InValid_disabled((SALT311.StrType)le.disabled),
    Hunters_Fields.InValid_lowincome((SALT311.StrType)le.lowincome),
    Hunters_Fields.InValid_regioncounty((SALT311.StrType)le.regioncounty),
    Hunters_Fields.InValid_blind((SALT311.StrType)le.blind),
    Hunters_Fields.InValid_huntfiller((SALT311.StrType)le.huntfiller),
    Hunters_Fields.InValid_salmon((SALT311.StrType)le.salmon),
    Hunters_Fields.InValid_freshwater((SALT311.StrType)le.freshwater),
    Hunters_Fields.InValid_saltwater((SALT311.StrType)le.saltwater),
    Hunters_Fields.InValid_lakesandresevoirs((SALT311.StrType)le.lakesandresevoirs),
    Hunters_Fields.InValid_setlinefish((SALT311.StrType)le.setlinefish),
    Hunters_Fields.InValid_trout((SALT311.StrType)le.trout),
    Hunters_Fields.InValid_fallfishing((SALT311.StrType)le.fallfishing),
    Hunters_Fields.InValid_steelhead((SALT311.StrType)le.steelhead),
    Hunters_Fields.InValid_whitejubherring((SALT311.StrType)le.whitejubherring),
    Hunters_Fields.InValid_sturgeon((SALT311.StrType)le.sturgeon),
    Hunters_Fields.InValid_shellfishcrab((SALT311.StrType)le.shellfishcrab),
    Hunters_Fields.InValid_shellfishlobster((SALT311.StrType)le.shellfishlobster),
    Hunters_Fields.InValid_deer((SALT311.StrType)le.deer),
    Hunters_Fields.InValid_bear((SALT311.StrType)le.bear),
    Hunters_Fields.InValid_elk((SALT311.StrType)le.elk),
    Hunters_Fields.InValid_moose((SALT311.StrType)le.moose),
    Hunters_Fields.InValid_buffalo((SALT311.StrType)le.buffalo),
    Hunters_Fields.InValid_antelope((SALT311.StrType)le.antelope),
    Hunters_Fields.InValid_sikebull((SALT311.StrType)le.sikebull),
    Hunters_Fields.InValid_bighorn((SALT311.StrType)le.bighorn),
    Hunters_Fields.InValid_javelina((SALT311.StrType)le.javelina),
    Hunters_Fields.InValid_cougar((SALT311.StrType)le.cougar),
    Hunters_Fields.InValid_anterless((SALT311.StrType)le.anterless),
    Hunters_Fields.InValid_pheasant((SALT311.StrType)le.pheasant),
    Hunters_Fields.InValid_goose((SALT311.StrType)le.goose),
    Hunters_Fields.InValid_duck((SALT311.StrType)le.duck),
    Hunters_Fields.InValid_turkey((SALT311.StrType)le.turkey),
    Hunters_Fields.InValid_snowmobile((SALT311.StrType)le.snowmobile),
    Hunters_Fields.InValid_biggame((SALT311.StrType)le.biggame),
    Hunters_Fields.InValid_skipass((SALT311.StrType)le.skipass),
    Hunters_Fields.InValid_migbird((SALT311.StrType)le.migbird),
    Hunters_Fields.InValid_smallgame((SALT311.StrType)le.smallgame),
    Hunters_Fields.InValid_sturgeon2((SALT311.StrType)le.sturgeon2),
    Hunters_Fields.InValid_gun((SALT311.StrType)le.gun),
    Hunters_Fields.InValid_bonus((SALT311.StrType)le.bonus),
    Hunters_Fields.InValid_lottery((SALT311.StrType)le.lottery),
    Hunters_Fields.InValid_otherbirds((SALT311.StrType)le.otherbirds),
    Hunters_Fields.InValid_huntfill1((SALT311.StrType)le.huntfill1),
    Hunters_Fields.InValid_title((SALT311.StrType)le.title),
    Hunters_Fields.InValid_fname((SALT311.StrType)le.fname),
    Hunters_Fields.InValid_mname((SALT311.StrType)le.mname),
    Hunters_Fields.InValid_lname((SALT311.StrType)le.lname),
    Hunters_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Hunters_Fields.InValid_score_on_input((SALT311.StrType)le.score_on_input),
    Hunters_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Hunters_Fields.InValid_predir((SALT311.StrType)le.predir),
    Hunters_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Hunters_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Hunters_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Hunters_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Hunters_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Hunters_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Hunters_Fields.InValid_city_name((SALT311.StrType)le.city_name),
    Hunters_Fields.InValid_st((SALT311.StrType)le.st),
    Hunters_Fields.InValid_zip((SALT311.StrType)le.zip),
    Hunters_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Hunters_Fields.InValid_cart((SALT311.StrType)le.cart),
    Hunters_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Hunters_Fields.InValid_lot((SALT311.StrType)le.lot),
    Hunters_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Hunters_Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Hunters_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Hunters_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Hunters_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Hunters_Fields.InValid_county((SALT311.StrType)le.county),
    Hunters_Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Hunters_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Hunters_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Hunters_Fields.InValid_msa((SALT311.StrType)le.msa),
    Hunters_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Hunters_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Hunters_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Hunters_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range),
    Hunters_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir),
    Hunters_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name),
    Hunters_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix),
    Hunters_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir),
    Hunters_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig),
    Hunters_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range),
    Hunters_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name),
    Hunters_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name),
    Hunters_Fields.InValid_mail_st((SALT311.StrType)le.mail_st),
    Hunters_Fields.InValid_mail_ace_zip((SALT311.StrType)le.mail_ace_zip),
    Hunters_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4),
    Hunters_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart),
    Hunters_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz),
    Hunters_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot),
    Hunters_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order),
    Hunters_Fields.InValid_mail_dpbc((SALT311.StrType)le.mail_dpbc),
    Hunters_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit),
    Hunters_Fields.InValid_mail_record_type((SALT311.StrType)le.mail_record_type),
    Hunters_Fields.InValid_mail_ace_fips_st((SALT311.StrType)le.mail_ace_fips_st),
    Hunters_Fields.InValid_mail_fipscounty((SALT311.StrType)le.mail_fipscounty),
    Hunters_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat),
    Hunters_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long),
    Hunters_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa),
    Hunters_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk),
    Hunters_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match),
    Hunters_Fields.InValid_mail_err_stat((SALT311.StrType)le.mail_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,187,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Hunters_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_Float','Invalid_No','Unknown','Invalid_Alpha','Invalid_No','Invalid_State','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Alpha','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_AlphaNum','Unknown','Invalid_AlphaNum','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Unknown','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Hunters_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_score(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_did_out(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_source(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_file_id(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_source_state(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_file_acquired_date(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage__use(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_title_in(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lname_in(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_fname_in(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mname_in(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_maiden_prior(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_name_suffix_in(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_votefiller(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_source_voterid(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_agecat(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_headhousehold(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_place_of_birth(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_occupation(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_maiden_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_motorvoterid(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_regsource(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_regdate(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_race(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_poliparty(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_other_phone(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_active_status(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_votefiller2(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_active_other(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_voterstatus(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_resaddr1(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_resaddr2(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_res_city(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_res_state(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_res_zip(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_res_county(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_addr1(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_addr2(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_county(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_historyfiller(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_huntfishperm(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_license_type_mapped(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_datelicense(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_homestate(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_resident(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_nonresident(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_hunt(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_fish(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_combosuper(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_sportsman(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_trap(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_archery(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_muzzle(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_drawing(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_day1(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_day3(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_day7(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_day14to15(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_dayfiller(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_seasonannual(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lifetimepermit(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_landowner(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_family(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_junior(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_seniorcit(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_crewmemeber(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_retarded(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_indian(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_serviceman(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_disabled(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lowincome(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_regioncounty(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_blind(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_huntfiller(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_salmon(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_freshwater(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_saltwater(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lakesandresevoirs(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_setlinefish(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_trout(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_fallfishing(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_steelhead(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_whitejubherring(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_sturgeon(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_shellfishcrab(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_shellfishlobster(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_deer(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_bear(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_elk(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_moose(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_buffalo(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_antelope(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_sikebull(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_bighorn(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_javelina(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_cougar(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_anterless(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_pheasant(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_goose(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_duck(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_turkey(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_snowmobile(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_biggame(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_skipass(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_migbird(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_smallgame(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_sturgeon2(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_gun(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_bonus(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lottery(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_otherbirds(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_huntfill1(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_title(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_score_on_input(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_st(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_county(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_prim_range(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_predir(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_prim_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_addr_suffix(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_postdir(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_unit_desig(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_sec_range(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_p_city_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_v_city_name(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_st(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_ace_zip(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_cart(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_cr_sort_sz(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_lot(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_lot_order(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_dpbc(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_chk_digit(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_record_type(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_ace_fips_st(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_fipscounty(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_geo_lat(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_geo_long(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_msa(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_geo_blk(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_geo_match(TotalErrors.ErrorNum),Hunters_Fields.InValidMessage_mail_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_eMerges, Hunters_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
