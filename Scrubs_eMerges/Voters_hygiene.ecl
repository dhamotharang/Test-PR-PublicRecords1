IMPORT SALT311,STD;
EXPORT Voters_hygiene(dataset(Voters_layout_eMerges) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_poliparty_mapped_cnt := COUNT(GROUP,h.poliparty_mapped <> (TYPEOF(h.poliparty_mapped))'');
    populated_poliparty_mapped_pcnt := AVE(GROUP,IF(h.poliparty_mapped = (TYPEOF(h.poliparty_mapped))'',0,100));
    maxlength_poliparty_mapped := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.poliparty_mapped)));
    avelength_poliparty_mapped := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.poliparty_mapped)),h.poliparty_mapped<>(typeof(h.poliparty_mapped))'');
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
    populated_active_status_mapped_cnt := COUNT(GROUP,h.active_status_mapped <> (TYPEOF(h.active_status_mapped))'');
    populated_active_status_mapped_pcnt := AVE(GROUP,IF(h.active_status_mapped = (TYPEOF(h.active_status_mapped))'',0,100));
    maxlength_active_status_mapped := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_status_mapped)));
    avelength_active_status_mapped := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_status_mapped)),h.active_status_mapped<>(typeof(h.active_status_mapped))'');
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
    populated_voterstatus_mapped_cnt := COUNT(GROUP,h.voterstatus_mapped <> (TYPEOF(h.voterstatus_mapped))'');
    populated_voterstatus_mapped_pcnt := AVE(GROUP,IF(h.voterstatus_mapped = (TYPEOF(h.voterstatus_mapped))'',0,100));
    maxlength_voterstatus_mapped := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.voterstatus_mapped)));
    avelength_voterstatus_mapped := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.voterstatus_mapped)),h.voterstatus_mapped<>(typeof(h.voterstatus_mapped))'');
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
    populated_dateofcontr_cnt := COUNT(GROUP,h.dateofcontr <> (TYPEOF(h.dateofcontr))'');
    populated_dateofcontr_pcnt := AVE(GROUP,IF(h.dateofcontr = (TYPEOF(h.dateofcontr))'',0,100));
    maxlength_dateofcontr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofcontr)));
    avelength_dateofcontr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofcontr)),h.dateofcontr<>(typeof(h.dateofcontr))'');
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
    populated_lastdayvote_cnt := COUNT(GROUP,h.lastdayvote <> (TYPEOF(h.lastdayvote))'');
    populated_lastdayvote_pcnt := AVE(GROUP,IF(h.lastdayvote = (TYPEOF(h.lastdayvote))'',0,100));
    maxlength_lastdayvote := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdayvote)));
    avelength_lastdayvote := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdayvote)),h.lastdayvote<>(typeof(h.lastdayvote))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_did_out_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_file_id_pcnt *   0.00 / 100 + T.Populated_vendor_id_pcnt *   0.00 / 100 + T.Populated_source_state_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_file_acquired_date_pcnt *   0.00 / 100 + T.Populated__use_pcnt *   0.00 / 100 + T.Populated_title_in_pcnt *   0.00 / 100 + T.Populated_lname_in_pcnt *   0.00 / 100 + T.Populated_fname_in_pcnt *   0.00 / 100 + T.Populated_mname_in_pcnt *   0.00 / 100 + T.Populated_maiden_prior_pcnt *   0.00 / 100 + T.Populated_name_suffix_in_pcnt *   0.00 / 100 + T.Populated_votefiller_pcnt *   0.00 / 100 + T.Populated_source_voterid_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_agecat_pcnt *   0.00 / 100 + T.Populated_headhousehold_pcnt *   0.00 / 100 + T.Populated_place_of_birth_pcnt *   0.00 / 100 + T.Populated_occupation_pcnt *   0.00 / 100 + T.Populated_maiden_name_pcnt *   0.00 / 100 + T.Populated_motorvoterid_pcnt *   0.00 / 100 + T.Populated_regsource_pcnt *   0.00 / 100 + T.Populated_regdate_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_poliparty_pcnt *   0.00 / 100 + T.Populated_poliparty_mapped_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100 + T.Populated_other_phone_pcnt *   0.00 / 100 + T.Populated_active_status_pcnt *   0.00 / 100 + T.Populated_active_status_mapped_pcnt *   0.00 / 100 + T.Populated_votefiller2_pcnt *   0.00 / 100 + T.Populated_active_other_pcnt *   0.00 / 100 + T.Populated_voterstatus_pcnt *   0.00 / 100 + T.Populated_voterstatus_mapped_pcnt *   0.00 / 100 + T.Populated_resaddr1_pcnt *   0.00 / 100 + T.Populated_resaddr2_pcnt *   0.00 / 100 + T.Populated_res_city_pcnt *   0.00 / 100 + T.Populated_res_state_pcnt *   0.00 / 100 + T.Populated_res_zip_pcnt *   0.00 / 100 + T.Populated_res_county_pcnt *   0.00 / 100 + T.Populated_mail_addr1_pcnt *   0.00 / 100 + T.Populated_mail_addr2_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_mail_county_pcnt *   0.00 / 100 + T.Populated_addr_filler1_pcnt *   0.00 / 100 + T.Populated_addr_filler2_pcnt *   0.00 / 100 + T.Populated_city_filler_pcnt *   0.00 / 100 + T.Populated_state_filler_pcnt *   0.00 / 100 + T.Populated_zip_filler_pcnt *   0.00 / 100 + T.Populated_county_filler_pcnt *   0.00 / 100 + T.Populated_towncode_pcnt *   0.00 / 100 + T.Populated_distcode_pcnt *   0.00 / 100 + T.Populated_countycode_pcnt *   0.00 / 100 + T.Populated_schoolcode_pcnt *   0.00 / 100 + T.Populated_cityinout_pcnt *   0.00 / 100 + T.Populated_spec_dist1_pcnt *   0.00 / 100 + T.Populated_spec_dist2_pcnt *   0.00 / 100 + T.Populated_precinct1_pcnt *   0.00 / 100 + T.Populated_precinct2_pcnt *   0.00 / 100 + T.Populated_precinct3_pcnt *   0.00 / 100 + T.Populated_villageprecinct_pcnt *   0.00 / 100 + T.Populated_schoolprecinct_pcnt *   0.00 / 100 + T.Populated_ward_pcnt *   0.00 / 100 + T.Populated_precinct_citytown_pcnt *   0.00 / 100 + T.Populated_ancsmdindc_pcnt *   0.00 / 100 + T.Populated_citycouncildist_pcnt *   0.00 / 100 + T.Populated_countycommdist_pcnt *   0.00 / 100 + T.Populated_statehouse_pcnt *   0.00 / 100 + T.Populated_statesenate_pcnt *   0.00 / 100 + T.Populated_ushouse_pcnt *   0.00 / 100 + T.Populated_elemschooldist_pcnt *   0.00 / 100 + T.Populated_schooldist_pcnt *   0.00 / 100 + T.Populated_schoolfiller_pcnt *   0.00 / 100 + T.Populated_commcolldist_pcnt *   0.00 / 100 + T.Populated_dist_filler_pcnt *   0.00 / 100 + T.Populated_municipal_pcnt *   0.00 / 100 + T.Populated_villagedist_pcnt *   0.00 / 100 + T.Populated_policejury_pcnt *   0.00 / 100 + T.Populated_policedist_pcnt *   0.00 / 100 + T.Populated_publicservcomm_pcnt *   0.00 / 100 + T.Populated_rescue_pcnt *   0.00 / 100 + T.Populated_fire_pcnt *   0.00 / 100 + T.Populated_sanitary_pcnt *   0.00 / 100 + T.Populated_sewerdist_pcnt *   0.00 / 100 + T.Populated_waterdist_pcnt *   0.00 / 100 + T.Populated_mosquitodist_pcnt *   0.00 / 100 + T.Populated_taxdist_pcnt *   0.00 / 100 + T.Populated_supremecourt_pcnt *   0.00 / 100 + T.Populated_justiceofpeace_pcnt *   0.00 / 100 + T.Populated_judicialdist_pcnt *   0.00 / 100 + T.Populated_superiorctdist_pcnt *   0.00 / 100 + T.Populated_appealsct_pcnt *   0.00 / 100 + T.Populated_courtfiller_pcnt *   0.00 / 100 + T.Populated_contributorparty_pcnt *   0.00 / 100 + T.Populated_recptparty_pcnt *   0.00 / 100 + T.Populated_dateofcontr_pcnt *   0.00 / 100 + T.Populated_dollaramt_pcnt *   0.00 / 100 + T.Populated_officecontto_pcnt *   0.00 / 100 + T.Populated_cumuldollaramt_pcnt *   0.00 / 100 + T.Populated_contfiller1_pcnt *   0.00 / 100 + T.Populated_contfiller2_pcnt *   0.00 / 100 + T.Populated_conttype_pcnt *   0.00 / 100 + T.Populated_contfiller3_pcnt *   0.00 / 100 + T.Populated_primary02_pcnt *   0.00 / 100 + T.Populated_special02_pcnt *   0.00 / 100 + T.Populated_other02_pcnt *   0.00 / 100 + T.Populated_special202_pcnt *   0.00 / 100 + T.Populated_general02_pcnt *   0.00 / 100 + T.Populated_primary01_pcnt *   0.00 / 100 + T.Populated_special01_pcnt *   0.00 / 100 + T.Populated_other01_pcnt *   0.00 / 100 + T.Populated_special201_pcnt *   0.00 / 100 + T.Populated_general01_pcnt *   0.00 / 100 + T.Populated_pres00_pcnt *   0.00 / 100 + T.Populated_primary00_pcnt *   0.00 / 100 + T.Populated_special00_pcnt *   0.00 / 100 + T.Populated_other00_pcnt *   0.00 / 100 + T.Populated_special200_pcnt *   0.00 / 100 + T.Populated_general00_pcnt *   0.00 / 100 + T.Populated_primary99_pcnt *   0.00 / 100 + T.Populated_special99_pcnt *   0.00 / 100 + T.Populated_other99_pcnt *   0.00 / 100 + T.Populated_special299_pcnt *   0.00 / 100 + T.Populated_general99_pcnt *   0.00 / 100 + T.Populated_primary98_pcnt *   0.00 / 100 + T.Populated_special98_pcnt *   0.00 / 100 + T.Populated_other98_pcnt *   0.00 / 100 + T.Populated_special298_pcnt *   0.00 / 100 + T.Populated_general98_pcnt *   0.00 / 100 + T.Populated_primary97_pcnt *   0.00 / 100 + T.Populated_special97_pcnt *   0.00 / 100 + T.Populated_other97_pcnt *   0.00 / 100 + T.Populated_special297_pcnt *   0.00 / 100 + T.Populated_general97_pcnt *   0.00 / 100 + T.Populated_pres96_pcnt *   0.00 / 100 + T.Populated_primary96_pcnt *   0.00 / 100 + T.Populated_special96_pcnt *   0.00 / 100 + T.Populated_other96_pcnt *   0.00 / 100 + T.Populated_special296_pcnt *   0.00 / 100 + T.Populated_general96_pcnt *   0.00 / 100 + T.Populated_lastdayvote_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_score_on_input_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_mail_prim_range_pcnt *   0.00 / 100 + T.Populated_mail_predir_pcnt *   0.00 / 100 + T.Populated_mail_prim_name_pcnt *   0.00 / 100 + T.Populated_mail_addr_suffix_pcnt *   0.00 / 100 + T.Populated_mail_postdir_pcnt *   0.00 / 100 + T.Populated_mail_unit_desig_pcnt *   0.00 / 100 + T.Populated_mail_sec_range_pcnt *   0.00 / 100 + T.Populated_mail_p_city_name_pcnt *   0.00 / 100 + T.Populated_mail_v_city_name_pcnt *   0.00 / 100 + T.Populated_mail_st_pcnt *   0.00 / 100 + T.Populated_mail_ace_zip_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_mail_cart_pcnt *   0.00 / 100 + T.Populated_mail_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_mail_lot_pcnt *   0.00 / 100 + T.Populated_mail_lot_order_pcnt *   0.00 / 100 + T.Populated_mail_dpbc_pcnt *   0.00 / 100 + T.Populated_mail_chk_digit_pcnt *   0.00 / 100 + T.Populated_mail_record_type_pcnt *   0.00 / 100 + T.Populated_mail_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_mail_fipscounty_pcnt *   0.00 / 100 + T.Populated_mail_geo_lat_pcnt *   0.00 / 100 + T.Populated_mail_geo_long_pcnt *   0.00 / 100 + T.Populated_mail_msa_pcnt *   0.00 / 100 + T.Populated_mail_geo_blk_pcnt *   0.00 / 100 + T.Populated_mail_geo_match_pcnt *   0.00 / 100 + T.Populated_mail_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','poliparty_mapped','phone','work_phone','other_phone','active_status','active_status_mapped','votefiller2','active_other','voterstatus','voterstatus_mapped','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','county_filler','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','contributorparty','recptparty','dateofcontr','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller3','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_score_pcnt,le.populated_best_ssn_pcnt,le.populated_did_out_pcnt,le.populated_source_pcnt,le.populated_file_id_pcnt,le.populated_vendor_id_pcnt,le.populated_source_state_pcnt,le.populated_source_code_pcnt,le.populated_file_acquired_date_pcnt,le.populated__use_pcnt,le.populated_title_in_pcnt,le.populated_lname_in_pcnt,le.populated_fname_in_pcnt,le.populated_mname_in_pcnt,le.populated_maiden_prior_pcnt,le.populated_name_suffix_in_pcnt,le.populated_votefiller_pcnt,le.populated_source_voterid_pcnt,le.populated_dob_pcnt,le.populated_agecat_pcnt,le.populated_headhousehold_pcnt,le.populated_place_of_birth_pcnt,le.populated_occupation_pcnt,le.populated_maiden_name_pcnt,le.populated_motorvoterid_pcnt,le.populated_regsource_pcnt,le.populated_regdate_pcnt,le.populated_race_pcnt,le.populated_gender_pcnt,le.populated_poliparty_pcnt,le.populated_poliparty_mapped_pcnt,le.populated_phone_pcnt,le.populated_work_phone_pcnt,le.populated_other_phone_pcnt,le.populated_active_status_pcnt,le.populated_active_status_mapped_pcnt,le.populated_votefiller2_pcnt,le.populated_active_other_pcnt,le.populated_voterstatus_pcnt,le.populated_voterstatus_mapped_pcnt,le.populated_resaddr1_pcnt,le.populated_resaddr2_pcnt,le.populated_res_city_pcnt,le.populated_res_state_pcnt,le.populated_res_zip_pcnt,le.populated_res_county_pcnt,le.populated_mail_addr1_pcnt,le.populated_mail_addr2_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_pcnt,le.populated_mail_county_pcnt,le.populated_addr_filler1_pcnt,le.populated_addr_filler2_pcnt,le.populated_city_filler_pcnt,le.populated_state_filler_pcnt,le.populated_zip_filler_pcnt,le.populated_county_filler_pcnt,le.populated_towncode_pcnt,le.populated_distcode_pcnt,le.populated_countycode_pcnt,le.populated_schoolcode_pcnt,le.populated_cityinout_pcnt,le.populated_spec_dist1_pcnt,le.populated_spec_dist2_pcnt,le.populated_precinct1_pcnt,le.populated_precinct2_pcnt,le.populated_precinct3_pcnt,le.populated_villageprecinct_pcnt,le.populated_schoolprecinct_pcnt,le.populated_ward_pcnt,le.populated_precinct_citytown_pcnt,le.populated_ancsmdindc_pcnt,le.populated_citycouncildist_pcnt,le.populated_countycommdist_pcnt,le.populated_statehouse_pcnt,le.populated_statesenate_pcnt,le.populated_ushouse_pcnt,le.populated_elemschooldist_pcnt,le.populated_schooldist_pcnt,le.populated_schoolfiller_pcnt,le.populated_commcolldist_pcnt,le.populated_dist_filler_pcnt,le.populated_municipal_pcnt,le.populated_villagedist_pcnt,le.populated_policejury_pcnt,le.populated_policedist_pcnt,le.populated_publicservcomm_pcnt,le.populated_rescue_pcnt,le.populated_fire_pcnt,le.populated_sanitary_pcnt,le.populated_sewerdist_pcnt,le.populated_waterdist_pcnt,le.populated_mosquitodist_pcnt,le.populated_taxdist_pcnt,le.populated_supremecourt_pcnt,le.populated_justiceofpeace_pcnt,le.populated_judicialdist_pcnt,le.populated_superiorctdist_pcnt,le.populated_appealsct_pcnt,le.populated_courtfiller_pcnt,le.populated_contributorparty_pcnt,le.populated_recptparty_pcnt,le.populated_dateofcontr_pcnt,le.populated_dollaramt_pcnt,le.populated_officecontto_pcnt,le.populated_cumuldollaramt_pcnt,le.populated_contfiller1_pcnt,le.populated_contfiller2_pcnt,le.populated_conttype_pcnt,le.populated_contfiller3_pcnt,le.populated_primary02_pcnt,le.populated_special02_pcnt,le.populated_other02_pcnt,le.populated_special202_pcnt,le.populated_general02_pcnt,le.populated_primary01_pcnt,le.populated_special01_pcnt,le.populated_other01_pcnt,le.populated_special201_pcnt,le.populated_general01_pcnt,le.populated_pres00_pcnt,le.populated_primary00_pcnt,le.populated_special00_pcnt,le.populated_other00_pcnt,le.populated_special200_pcnt,le.populated_general00_pcnt,le.populated_primary99_pcnt,le.populated_special99_pcnt,le.populated_other99_pcnt,le.populated_special299_pcnt,le.populated_general99_pcnt,le.populated_primary98_pcnt,le.populated_special98_pcnt,le.populated_other98_pcnt,le.populated_special298_pcnt,le.populated_general98_pcnt,le.populated_primary97_pcnt,le.populated_special97_pcnt,le.populated_other97_pcnt,le.populated_special297_pcnt,le.populated_general97_pcnt,le.populated_pres96_pcnt,le.populated_primary96_pcnt,le.populated_special96_pcnt,le.populated_other96_pcnt,le.populated_special296_pcnt,le.populated_general96_pcnt,le.populated_lastdayvote_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_score_on_input_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_record_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_county_name_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_mail_prim_range_pcnt,le.populated_mail_predir_pcnt,le.populated_mail_prim_name_pcnt,le.populated_mail_addr_suffix_pcnt,le.populated_mail_postdir_pcnt,le.populated_mail_unit_desig_pcnt,le.populated_mail_sec_range_pcnt,le.populated_mail_p_city_name_pcnt,le.populated_mail_v_city_name_pcnt,le.populated_mail_st_pcnt,le.populated_mail_ace_zip_pcnt,le.populated_mail_zip4_pcnt,le.populated_mail_cart_pcnt,le.populated_mail_cr_sort_sz_pcnt,le.populated_mail_lot_pcnt,le.populated_mail_lot_order_pcnt,le.populated_mail_dpbc_pcnt,le.populated_mail_chk_digit_pcnt,le.populated_mail_record_type_pcnt,le.populated_mail_ace_fips_st_pcnt,le.populated_mail_fipscounty_pcnt,le.populated_mail_geo_lat_pcnt,le.populated_mail_geo_long_pcnt,le.populated_mail_msa_pcnt,le.populated_mail_geo_blk_pcnt,le.populated_mail_geo_match_pcnt,le.populated_mail_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_score,le.maxlength_best_ssn,le.maxlength_did_out,le.maxlength_source,le.maxlength_file_id,le.maxlength_vendor_id,le.maxlength_source_state,le.maxlength_source_code,le.maxlength_file_acquired_date,le.maxlength__use,le.maxlength_title_in,le.maxlength_lname_in,le.maxlength_fname_in,le.maxlength_mname_in,le.maxlength_maiden_prior,le.maxlength_name_suffix_in,le.maxlength_votefiller,le.maxlength_source_voterid,le.maxlength_dob,le.maxlength_agecat,le.maxlength_headhousehold,le.maxlength_place_of_birth,le.maxlength_occupation,le.maxlength_maiden_name,le.maxlength_motorvoterid,le.maxlength_regsource,le.maxlength_regdate,le.maxlength_race,le.maxlength_gender,le.maxlength_poliparty,le.maxlength_poliparty_mapped,le.maxlength_phone,le.maxlength_work_phone,le.maxlength_other_phone,le.maxlength_active_status,le.maxlength_active_status_mapped,le.maxlength_votefiller2,le.maxlength_active_other,le.maxlength_voterstatus,le.maxlength_voterstatus_mapped,le.maxlength_resaddr1,le.maxlength_resaddr2,le.maxlength_res_city,le.maxlength_res_state,le.maxlength_res_zip,le.maxlength_res_county,le.maxlength_mail_addr1,le.maxlength_mail_addr2,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip,le.maxlength_mail_county,le.maxlength_addr_filler1,le.maxlength_addr_filler2,le.maxlength_city_filler,le.maxlength_state_filler,le.maxlength_zip_filler,le.maxlength_county_filler,le.maxlength_towncode,le.maxlength_distcode,le.maxlength_countycode,le.maxlength_schoolcode,le.maxlength_cityinout,le.maxlength_spec_dist1,le.maxlength_spec_dist2,le.maxlength_precinct1,le.maxlength_precinct2,le.maxlength_precinct3,le.maxlength_villageprecinct,le.maxlength_schoolprecinct,le.maxlength_ward,le.maxlength_precinct_citytown,le.maxlength_ancsmdindc,le.maxlength_citycouncildist,le.maxlength_countycommdist,le.maxlength_statehouse,le.maxlength_statesenate,le.maxlength_ushouse,le.maxlength_elemschooldist,le.maxlength_schooldist,le.maxlength_schoolfiller,le.maxlength_commcolldist,le.maxlength_dist_filler,le.maxlength_municipal,le.maxlength_villagedist,le.maxlength_policejury,le.maxlength_policedist,le.maxlength_publicservcomm,le.maxlength_rescue,le.maxlength_fire,le.maxlength_sanitary,le.maxlength_sewerdist,le.maxlength_waterdist,le.maxlength_mosquitodist,le.maxlength_taxdist,le.maxlength_supremecourt,le.maxlength_justiceofpeace,le.maxlength_judicialdist,le.maxlength_superiorctdist,le.maxlength_appealsct,le.maxlength_courtfiller,le.maxlength_contributorparty,le.maxlength_recptparty,le.maxlength_dateofcontr,le.maxlength_dollaramt,le.maxlength_officecontto,le.maxlength_cumuldollaramt,le.maxlength_contfiller1,le.maxlength_contfiller2,le.maxlength_conttype,le.maxlength_contfiller3,le.maxlength_primary02,le.maxlength_special02,le.maxlength_other02,le.maxlength_special202,le.maxlength_general02,le.maxlength_primary01,le.maxlength_special01,le.maxlength_other01,le.maxlength_special201,le.maxlength_general01,le.maxlength_pres00,le.maxlength_primary00,le.maxlength_special00,le.maxlength_other00,le.maxlength_special200,le.maxlength_general00,le.maxlength_primary99,le.maxlength_special99,le.maxlength_other99,le.maxlength_special299,le.maxlength_general99,le.maxlength_primary98,le.maxlength_special98,le.maxlength_other98,le.maxlength_special298,le.maxlength_general98,le.maxlength_primary97,le.maxlength_special97,le.maxlength_other97,le.maxlength_special297,le.maxlength_general97,le.maxlength_pres96,le.maxlength_primary96,le.maxlength_special96,le.maxlength_other96,le.maxlength_special296,le.maxlength_general96,le.maxlength_lastdayvote,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_score_on_input,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_record_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_county_name,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_mail_prim_range,le.maxlength_mail_predir,le.maxlength_mail_prim_name,le.maxlength_mail_addr_suffix,le.maxlength_mail_postdir,le.maxlength_mail_unit_desig,le.maxlength_mail_sec_range,le.maxlength_mail_p_city_name,le.maxlength_mail_v_city_name,le.maxlength_mail_st,le.maxlength_mail_ace_zip,le.maxlength_mail_zip4,le.maxlength_mail_cart,le.maxlength_mail_cr_sort_sz,le.maxlength_mail_lot,le.maxlength_mail_lot_order,le.maxlength_mail_dpbc,le.maxlength_mail_chk_digit,le.maxlength_mail_record_type,le.maxlength_mail_ace_fips_st,le.maxlength_mail_fipscounty,le.maxlength_mail_geo_lat,le.maxlength_mail_geo_long,le.maxlength_mail_msa,le.maxlength_mail_geo_blk,le.maxlength_mail_geo_match,le.maxlength_mail_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_score,le.avelength_best_ssn,le.avelength_did_out,le.avelength_source,le.avelength_file_id,le.avelength_vendor_id,le.avelength_source_state,le.avelength_source_code,le.avelength_file_acquired_date,le.avelength__use,le.avelength_title_in,le.avelength_lname_in,le.avelength_fname_in,le.avelength_mname_in,le.avelength_maiden_prior,le.avelength_name_suffix_in,le.avelength_votefiller,le.avelength_source_voterid,le.avelength_dob,le.avelength_agecat,le.avelength_headhousehold,le.avelength_place_of_birth,le.avelength_occupation,le.avelength_maiden_name,le.avelength_motorvoterid,le.avelength_regsource,le.avelength_regdate,le.avelength_race,le.avelength_gender,le.avelength_poliparty,le.avelength_poliparty_mapped,le.avelength_phone,le.avelength_work_phone,le.avelength_other_phone,le.avelength_active_status,le.avelength_active_status_mapped,le.avelength_votefiller2,le.avelength_active_other,le.avelength_voterstatus,le.avelength_voterstatus_mapped,le.avelength_resaddr1,le.avelength_resaddr2,le.avelength_res_city,le.avelength_res_state,le.avelength_res_zip,le.avelength_res_county,le.avelength_mail_addr1,le.avelength_mail_addr2,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip,le.avelength_mail_county,le.avelength_addr_filler1,le.avelength_addr_filler2,le.avelength_city_filler,le.avelength_state_filler,le.avelength_zip_filler,le.avelength_county_filler,le.avelength_towncode,le.avelength_distcode,le.avelength_countycode,le.avelength_schoolcode,le.avelength_cityinout,le.avelength_spec_dist1,le.avelength_spec_dist2,le.avelength_precinct1,le.avelength_precinct2,le.avelength_precinct3,le.avelength_villageprecinct,le.avelength_schoolprecinct,le.avelength_ward,le.avelength_precinct_citytown,le.avelength_ancsmdindc,le.avelength_citycouncildist,le.avelength_countycommdist,le.avelength_statehouse,le.avelength_statesenate,le.avelength_ushouse,le.avelength_elemschooldist,le.avelength_schooldist,le.avelength_schoolfiller,le.avelength_commcolldist,le.avelength_dist_filler,le.avelength_municipal,le.avelength_villagedist,le.avelength_policejury,le.avelength_policedist,le.avelength_publicservcomm,le.avelength_rescue,le.avelength_fire,le.avelength_sanitary,le.avelength_sewerdist,le.avelength_waterdist,le.avelength_mosquitodist,le.avelength_taxdist,le.avelength_supremecourt,le.avelength_justiceofpeace,le.avelength_judicialdist,le.avelength_superiorctdist,le.avelength_appealsct,le.avelength_courtfiller,le.avelength_contributorparty,le.avelength_recptparty,le.avelength_dateofcontr,le.avelength_dollaramt,le.avelength_officecontto,le.avelength_cumuldollaramt,le.avelength_contfiller1,le.avelength_contfiller2,le.avelength_conttype,le.avelength_contfiller3,le.avelength_primary02,le.avelength_special02,le.avelength_other02,le.avelength_special202,le.avelength_general02,le.avelength_primary01,le.avelength_special01,le.avelength_other01,le.avelength_special201,le.avelength_general01,le.avelength_pres00,le.avelength_primary00,le.avelength_special00,le.avelength_other00,le.avelength_special200,le.avelength_general00,le.avelength_primary99,le.avelength_special99,le.avelength_other99,le.avelength_special299,le.avelength_general99,le.avelength_primary98,le.avelength_special98,le.avelength_other98,le.avelength_special298,le.avelength_general98,le.avelength_primary97,le.avelength_special97,le.avelength_other97,le.avelength_special297,le.avelength_general97,le.avelength_pres96,le.avelength_primary96,le.avelength_special96,le.avelength_other96,le.avelength_special296,le.avelength_general96,le.avelength_lastdayvote,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_score_on_input,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_record_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_county_name,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_mail_prim_range,le.avelength_mail_predir,le.avelength_mail_prim_name,le.avelength_mail_addr_suffix,le.avelength_mail_postdir,le.avelength_mail_unit_desig,le.avelength_mail_sec_range,le.avelength_mail_p_city_name,le.avelength_mail_v_city_name,le.avelength_mail_st,le.avelength_mail_ace_zip,le.avelength_mail_zip4,le.avelength_mail_cart,le.avelength_mail_cr_sort_sz,le.avelength_mail_lot,le.avelength_mail_lot_order,le.avelength_mail_dpbc,le.avelength_mail_chk_digit,le.avelength_mail_record_type,le.avelength_mail_ace_fips_st,le.avelength_mail_fipscounty,le.avelength_mail_geo_lat,le.avelength_mail_geo_long,le.avelength_mail_msa,le.avelength_mail_geo_blk,le.avelength_mail_geo_match,le.avelength_mail_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 213, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.poliparty_mapped),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.active_status_mapped),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.voterstatus_mapped),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.addr_filler1),TRIM((SALT311.StrType)le.addr_filler2),TRIM((SALT311.StrType)le.city_filler),TRIM((SALT311.StrType)le.state_filler),TRIM((SALT311.StrType)le.zip_filler),TRIM((SALT311.StrType)le.county_filler),TRIM((SALT311.StrType)le.towncode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.cityinout),TRIM((SALT311.StrType)le.spec_dist1),TRIM((SALT311.StrType)le.spec_dist2),TRIM((SALT311.StrType)le.precinct1),TRIM((SALT311.StrType)le.precinct2),TRIM((SALT311.StrType)le.precinct3),TRIM((SALT311.StrType)le.villageprecinct),TRIM((SALT311.StrType)le.schoolprecinct),TRIM((SALT311.StrType)le.ward),TRIM((SALT311.StrType)le.precinct_citytown),TRIM((SALT311.StrType)le.ancsmdindc),TRIM((SALT311.StrType)le.citycouncildist),TRIM((SALT311.StrType)le.countycommdist),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.elemschooldist),TRIM((SALT311.StrType)le.schooldist),TRIM((SALT311.StrType)le.schoolfiller),TRIM((SALT311.StrType)le.commcolldist),TRIM((SALT311.StrType)le.dist_filler),TRIM((SALT311.StrType)le.municipal),TRIM((SALT311.StrType)le.villagedist),TRIM((SALT311.StrType)le.policejury),TRIM((SALT311.StrType)le.policedist),TRIM((SALT311.StrType)le.publicservcomm),TRIM((SALT311.StrType)le.rescue),TRIM((SALT311.StrType)le.fire),TRIM((SALT311.StrType)le.sanitary),TRIM((SALT311.StrType)le.sewerdist),TRIM((SALT311.StrType)le.waterdist),TRIM((SALT311.StrType)le.mosquitodist),TRIM((SALT311.StrType)le.taxdist),TRIM((SALT311.StrType)le.supremecourt),TRIM((SALT311.StrType)le.justiceofpeace),TRIM((SALT311.StrType)le.judicialdist),TRIM((SALT311.StrType)le.superiorctdist),TRIM((SALT311.StrType)le.appealsct),TRIM((SALT311.StrType)le.courtfiller),TRIM((SALT311.StrType)le.contributorparty),TRIM((SALT311.StrType)le.recptparty),TRIM((SALT311.StrType)le.dateofcontr),TRIM((SALT311.StrType)le.dollaramt),TRIM((SALT311.StrType)le.officecontto),TRIM((SALT311.StrType)le.cumuldollaramt),TRIM((SALT311.StrType)le.contfiller1),TRIM((SALT311.StrType)le.contfiller2),TRIM((SALT311.StrType)le.conttype),TRIM((SALT311.StrType)le.contfiller3),TRIM((SALT311.StrType)le.primary02),TRIM((SALT311.StrType)le.special02),TRIM((SALT311.StrType)le.other02),TRIM((SALT311.StrType)le.special202),TRIM((SALT311.StrType)le.general02),TRIM((SALT311.StrType)le.primary01),TRIM((SALT311.StrType)le.special01),TRIM((SALT311.StrType)le.other01),TRIM((SALT311.StrType)le.special201),TRIM((SALT311.StrType)le.general01),TRIM((SALT311.StrType)le.pres00),TRIM((SALT311.StrType)le.primary00),TRIM((SALT311.StrType)le.special00),TRIM((SALT311.StrType)le.other00),TRIM((SALT311.StrType)le.special200),TRIM((SALT311.StrType)le.general00),TRIM((SALT311.StrType)le.primary99),TRIM((SALT311.StrType)le.special99),TRIM((SALT311.StrType)le.other99),TRIM((SALT311.StrType)le.special299),TRIM((SALT311.StrType)le.general99),TRIM((SALT311.StrType)le.primary98),TRIM((SALT311.StrType)le.special98),TRIM((SALT311.StrType)le.other98),TRIM((SALT311.StrType)le.special298),TRIM((SALT311.StrType)le.general98),TRIM((SALT311.StrType)le.primary97),TRIM((SALT311.StrType)le.special97),TRIM((SALT311.StrType)le.other97),TRIM((SALT311.StrType)le.special297),TRIM((SALT311.StrType)le.general97),TRIM((SALT311.StrType)le.pres96),TRIM((SALT311.StrType)le.primary96),TRIM((SALT311.StrType)le.special96),TRIM((SALT311.StrType)le.other96),TRIM((SALT311.StrType)le.special296),TRIM((SALT311.StrType)le.general96),TRIM((SALT311.StrType)le.lastdayvote),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,213,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 213);
  SELF.FldNo2 := 1 + (C % 213);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.poliparty_mapped),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.active_status_mapped),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.voterstatus_mapped),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.addr_filler1),TRIM((SALT311.StrType)le.addr_filler2),TRIM((SALT311.StrType)le.city_filler),TRIM((SALT311.StrType)le.state_filler),TRIM((SALT311.StrType)le.zip_filler),TRIM((SALT311.StrType)le.county_filler),TRIM((SALT311.StrType)le.towncode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.cityinout),TRIM((SALT311.StrType)le.spec_dist1),TRIM((SALT311.StrType)le.spec_dist2),TRIM((SALT311.StrType)le.precinct1),TRIM((SALT311.StrType)le.precinct2),TRIM((SALT311.StrType)le.precinct3),TRIM((SALT311.StrType)le.villageprecinct),TRIM((SALT311.StrType)le.schoolprecinct),TRIM((SALT311.StrType)le.ward),TRIM((SALT311.StrType)le.precinct_citytown),TRIM((SALT311.StrType)le.ancsmdindc),TRIM((SALT311.StrType)le.citycouncildist),TRIM((SALT311.StrType)le.countycommdist),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.elemschooldist),TRIM((SALT311.StrType)le.schooldist),TRIM((SALT311.StrType)le.schoolfiller),TRIM((SALT311.StrType)le.commcolldist),TRIM((SALT311.StrType)le.dist_filler),TRIM((SALT311.StrType)le.municipal),TRIM((SALT311.StrType)le.villagedist),TRIM((SALT311.StrType)le.policejury),TRIM((SALT311.StrType)le.policedist),TRIM((SALT311.StrType)le.publicservcomm),TRIM((SALT311.StrType)le.rescue),TRIM((SALT311.StrType)le.fire),TRIM((SALT311.StrType)le.sanitary),TRIM((SALT311.StrType)le.sewerdist),TRIM((SALT311.StrType)le.waterdist),TRIM((SALT311.StrType)le.mosquitodist),TRIM((SALT311.StrType)le.taxdist),TRIM((SALT311.StrType)le.supremecourt),TRIM((SALT311.StrType)le.justiceofpeace),TRIM((SALT311.StrType)le.judicialdist),TRIM((SALT311.StrType)le.superiorctdist),TRIM((SALT311.StrType)le.appealsct),TRIM((SALT311.StrType)le.courtfiller),TRIM((SALT311.StrType)le.contributorparty),TRIM((SALT311.StrType)le.recptparty),TRIM((SALT311.StrType)le.dateofcontr),TRIM((SALT311.StrType)le.dollaramt),TRIM((SALT311.StrType)le.officecontto),TRIM((SALT311.StrType)le.cumuldollaramt),TRIM((SALT311.StrType)le.contfiller1),TRIM((SALT311.StrType)le.contfiller2),TRIM((SALT311.StrType)le.conttype),TRIM((SALT311.StrType)le.contfiller3),TRIM((SALT311.StrType)le.primary02),TRIM((SALT311.StrType)le.special02),TRIM((SALT311.StrType)le.other02),TRIM((SALT311.StrType)le.special202),TRIM((SALT311.StrType)le.general02),TRIM((SALT311.StrType)le.primary01),TRIM((SALT311.StrType)le.special01),TRIM((SALT311.StrType)le.other01),TRIM((SALT311.StrType)le.special201),TRIM((SALT311.StrType)le.general01),TRIM((SALT311.StrType)le.pres00),TRIM((SALT311.StrType)le.primary00),TRIM((SALT311.StrType)le.special00),TRIM((SALT311.StrType)le.other00),TRIM((SALT311.StrType)le.special200),TRIM((SALT311.StrType)le.general00),TRIM((SALT311.StrType)le.primary99),TRIM((SALT311.StrType)le.special99),TRIM((SALT311.StrType)le.other99),TRIM((SALT311.StrType)le.special299),TRIM((SALT311.StrType)le.general99),TRIM((SALT311.StrType)le.primary98),TRIM((SALT311.StrType)le.special98),TRIM((SALT311.StrType)le.other98),TRIM((SALT311.StrType)le.special298),TRIM((SALT311.StrType)le.general98),TRIM((SALT311.StrType)le.primary97),TRIM((SALT311.StrType)le.special97),TRIM((SALT311.StrType)le.other97),TRIM((SALT311.StrType)le.special297),TRIM((SALT311.StrType)le.general97),TRIM((SALT311.StrType)le.pres96),TRIM((SALT311.StrType)le.primary96),TRIM((SALT311.StrType)le.special96),TRIM((SALT311.StrType)le.other96),TRIM((SALT311.StrType)le.special296),TRIM((SALT311.StrType)le.general96),TRIM((SALT311.StrType)le.lastdayvote),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.score),TRIM((SALT311.StrType)le.best_ssn),TRIM((SALT311.StrType)le.did_out),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.vendor_id),TRIM((SALT311.StrType)le.source_state),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le._use),TRIM((SALT311.StrType)le.title_in),TRIM((SALT311.StrType)le.lname_in),TRIM((SALT311.StrType)le.fname_in),TRIM((SALT311.StrType)le.mname_in),TRIM((SALT311.StrType)le.maiden_prior),TRIM((SALT311.StrType)le.name_suffix_in),TRIM((SALT311.StrType)le.votefiller),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.headhousehold),TRIM((SALT311.StrType)le.place_of_birth),TRIM((SALT311.StrType)le.occupation),TRIM((SALT311.StrType)le.maiden_name),TRIM((SALT311.StrType)le.motorvoterid),TRIM((SALT311.StrType)le.regsource),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.poliparty),TRIM((SALT311.StrType)le.poliparty_mapped),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.work_phone),TRIM((SALT311.StrType)le.other_phone),TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.active_status_mapped),TRIM((SALT311.StrType)le.votefiller2),TRIM((SALT311.StrType)le.active_other),TRIM((SALT311.StrType)le.voterstatus),TRIM((SALT311.StrType)le.voterstatus_mapped),TRIM((SALT311.StrType)le.resaddr1),TRIM((SALT311.StrType)le.resaddr2),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.res_county),TRIM((SALT311.StrType)le.mail_addr1),TRIM((SALT311.StrType)le.mail_addr2),TRIM((SALT311.StrType)le.mail_city),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.mail_county),TRIM((SALT311.StrType)le.addr_filler1),TRIM((SALT311.StrType)le.addr_filler2),TRIM((SALT311.StrType)le.city_filler),TRIM((SALT311.StrType)le.state_filler),TRIM((SALT311.StrType)le.zip_filler),TRIM((SALT311.StrType)le.county_filler),TRIM((SALT311.StrType)le.towncode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.cityinout),TRIM((SALT311.StrType)le.spec_dist1),TRIM((SALT311.StrType)le.spec_dist2),TRIM((SALT311.StrType)le.precinct1),TRIM((SALT311.StrType)le.precinct2),TRIM((SALT311.StrType)le.precinct3),TRIM((SALT311.StrType)le.villageprecinct),TRIM((SALT311.StrType)le.schoolprecinct),TRIM((SALT311.StrType)le.ward),TRIM((SALT311.StrType)le.precinct_citytown),TRIM((SALT311.StrType)le.ancsmdindc),TRIM((SALT311.StrType)le.citycouncildist),TRIM((SALT311.StrType)le.countycommdist),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.elemschooldist),TRIM((SALT311.StrType)le.schooldist),TRIM((SALT311.StrType)le.schoolfiller),TRIM((SALT311.StrType)le.commcolldist),TRIM((SALT311.StrType)le.dist_filler),TRIM((SALT311.StrType)le.municipal),TRIM((SALT311.StrType)le.villagedist),TRIM((SALT311.StrType)le.policejury),TRIM((SALT311.StrType)le.policedist),TRIM((SALT311.StrType)le.publicservcomm),TRIM((SALT311.StrType)le.rescue),TRIM((SALT311.StrType)le.fire),TRIM((SALT311.StrType)le.sanitary),TRIM((SALT311.StrType)le.sewerdist),TRIM((SALT311.StrType)le.waterdist),TRIM((SALT311.StrType)le.mosquitodist),TRIM((SALT311.StrType)le.taxdist),TRIM((SALT311.StrType)le.supremecourt),TRIM((SALT311.StrType)le.justiceofpeace),TRIM((SALT311.StrType)le.judicialdist),TRIM((SALT311.StrType)le.superiorctdist),TRIM((SALT311.StrType)le.appealsct),TRIM((SALT311.StrType)le.courtfiller),TRIM((SALT311.StrType)le.contributorparty),TRIM((SALT311.StrType)le.recptparty),TRIM((SALT311.StrType)le.dateofcontr),TRIM((SALT311.StrType)le.dollaramt),TRIM((SALT311.StrType)le.officecontto),TRIM((SALT311.StrType)le.cumuldollaramt),TRIM((SALT311.StrType)le.contfiller1),TRIM((SALT311.StrType)le.contfiller2),TRIM((SALT311.StrType)le.conttype),TRIM((SALT311.StrType)le.contfiller3),TRIM((SALT311.StrType)le.primary02),TRIM((SALT311.StrType)le.special02),TRIM((SALT311.StrType)le.other02),TRIM((SALT311.StrType)le.special202),TRIM((SALT311.StrType)le.general02),TRIM((SALT311.StrType)le.primary01),TRIM((SALT311.StrType)le.special01),TRIM((SALT311.StrType)le.other01),TRIM((SALT311.StrType)le.special201),TRIM((SALT311.StrType)le.general01),TRIM((SALT311.StrType)le.pres00),TRIM((SALT311.StrType)le.primary00),TRIM((SALT311.StrType)le.special00),TRIM((SALT311.StrType)le.other00),TRIM((SALT311.StrType)le.special200),TRIM((SALT311.StrType)le.general00),TRIM((SALT311.StrType)le.primary99),TRIM((SALT311.StrType)le.special99),TRIM((SALT311.StrType)le.other99),TRIM((SALT311.StrType)le.special299),TRIM((SALT311.StrType)le.general99),TRIM((SALT311.StrType)le.primary98),TRIM((SALT311.StrType)le.special98),TRIM((SALT311.StrType)le.other98),TRIM((SALT311.StrType)le.special298),TRIM((SALT311.StrType)le.general98),TRIM((SALT311.StrType)le.primary97),TRIM((SALT311.StrType)le.special97),TRIM((SALT311.StrType)le.other97),TRIM((SALT311.StrType)le.special297),TRIM((SALT311.StrType)le.general97),TRIM((SALT311.StrType)le.pres96),TRIM((SALT311.StrType)le.primary96),TRIM((SALT311.StrType)le.special96),TRIM((SALT311.StrType)le.other96),TRIM((SALT311.StrType)le.special296),TRIM((SALT311.StrType)le.general96),TRIM((SALT311.StrType)le.lastdayvote),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.score_on_input),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.mail_prim_range),TRIM((SALT311.StrType)le.mail_predir),TRIM((SALT311.StrType)le.mail_prim_name),TRIM((SALT311.StrType)le.mail_addr_suffix),TRIM((SALT311.StrType)le.mail_postdir),TRIM((SALT311.StrType)le.mail_unit_desig),TRIM((SALT311.StrType)le.mail_sec_range),TRIM((SALT311.StrType)le.mail_p_city_name),TRIM((SALT311.StrType)le.mail_v_city_name),TRIM((SALT311.StrType)le.mail_st),TRIM((SALT311.StrType)le.mail_ace_zip),TRIM((SALT311.StrType)le.mail_zip4),TRIM((SALT311.StrType)le.mail_cart),TRIM((SALT311.StrType)le.mail_cr_sort_sz),TRIM((SALT311.StrType)le.mail_lot),TRIM((SALT311.StrType)le.mail_lot_order),TRIM((SALT311.StrType)le.mail_dpbc),TRIM((SALT311.StrType)le.mail_chk_digit),TRIM((SALT311.StrType)le.mail_record_type),TRIM((SALT311.StrType)le.mail_ace_fips_st),TRIM((SALT311.StrType)le.mail_fipscounty),TRIM((SALT311.StrType)le.mail_geo_lat),TRIM((SALT311.StrType)le.mail_geo_long),TRIM((SALT311.StrType)le.mail_msa),TRIM((SALT311.StrType)le.mail_geo_blk),TRIM((SALT311.StrType)le.mail_geo_match),TRIM((SALT311.StrType)le.mail_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),213*213,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'date_first_seen'}
      ,{3,'date_last_seen'}
      ,{4,'score'}
      ,{5,'best_ssn'}
      ,{6,'did_out'}
      ,{7,'source'}
      ,{8,'file_id'}
      ,{9,'vendor_id'}
      ,{10,'source_state'}
      ,{11,'source_code'}
      ,{12,'file_acquired_date'}
      ,{13,'_use'}
      ,{14,'title_in'}
      ,{15,'lname_in'}
      ,{16,'fname_in'}
      ,{17,'mname_in'}
      ,{18,'maiden_prior'}
      ,{19,'name_suffix_in'}
      ,{20,'votefiller'}
      ,{21,'source_voterid'}
      ,{22,'dob'}
      ,{23,'agecat'}
      ,{24,'headhousehold'}
      ,{25,'place_of_birth'}
      ,{26,'occupation'}
      ,{27,'maiden_name'}
      ,{28,'motorvoterid'}
      ,{29,'regsource'}
      ,{30,'regdate'}
      ,{31,'race'}
      ,{32,'gender'}
      ,{33,'poliparty'}
      ,{34,'poliparty_mapped'}
      ,{35,'phone'}
      ,{36,'work_phone'}
      ,{37,'other_phone'}
      ,{38,'active_status'}
      ,{39,'active_status_mapped'}
      ,{40,'votefiller2'}
      ,{41,'active_other'}
      ,{42,'voterstatus'}
      ,{43,'voterstatus_mapped'}
      ,{44,'resaddr1'}
      ,{45,'resaddr2'}
      ,{46,'res_city'}
      ,{47,'res_state'}
      ,{48,'res_zip'}
      ,{49,'res_county'}
      ,{50,'mail_addr1'}
      ,{51,'mail_addr2'}
      ,{52,'mail_city'}
      ,{53,'mail_state'}
      ,{54,'mail_zip'}
      ,{55,'mail_county'}
      ,{56,'addr_filler1'}
      ,{57,'addr_filler2'}
      ,{58,'city_filler'}
      ,{59,'state_filler'}
      ,{60,'zip_filler'}
      ,{61,'county_filler'}
      ,{62,'towncode'}
      ,{63,'distcode'}
      ,{64,'countycode'}
      ,{65,'schoolcode'}
      ,{66,'cityinout'}
      ,{67,'spec_dist1'}
      ,{68,'spec_dist2'}
      ,{69,'precinct1'}
      ,{70,'precinct2'}
      ,{71,'precinct3'}
      ,{72,'villageprecinct'}
      ,{73,'schoolprecinct'}
      ,{74,'ward'}
      ,{75,'precinct_citytown'}
      ,{76,'ancsmdindc'}
      ,{77,'citycouncildist'}
      ,{78,'countycommdist'}
      ,{79,'statehouse'}
      ,{80,'statesenate'}
      ,{81,'ushouse'}
      ,{82,'elemschooldist'}
      ,{83,'schooldist'}
      ,{84,'schoolfiller'}
      ,{85,'commcolldist'}
      ,{86,'dist_filler'}
      ,{87,'municipal'}
      ,{88,'villagedist'}
      ,{89,'policejury'}
      ,{90,'policedist'}
      ,{91,'publicservcomm'}
      ,{92,'rescue'}
      ,{93,'fire'}
      ,{94,'sanitary'}
      ,{95,'sewerdist'}
      ,{96,'waterdist'}
      ,{97,'mosquitodist'}
      ,{98,'taxdist'}
      ,{99,'supremecourt'}
      ,{100,'justiceofpeace'}
      ,{101,'judicialdist'}
      ,{102,'superiorctdist'}
      ,{103,'appealsct'}
      ,{104,'courtfiller'}
      ,{105,'contributorparty'}
      ,{106,'recptparty'}
      ,{107,'dateofcontr'}
      ,{108,'dollaramt'}
      ,{109,'officecontto'}
      ,{110,'cumuldollaramt'}
      ,{111,'contfiller1'}
      ,{112,'contfiller2'}
      ,{113,'conttype'}
      ,{114,'contfiller3'}
      ,{115,'primary02'}
      ,{116,'special02'}
      ,{117,'other02'}
      ,{118,'special202'}
      ,{119,'general02'}
      ,{120,'primary01'}
      ,{121,'special01'}
      ,{122,'other01'}
      ,{123,'special201'}
      ,{124,'general01'}
      ,{125,'pres00'}
      ,{126,'primary00'}
      ,{127,'special00'}
      ,{128,'other00'}
      ,{129,'special200'}
      ,{130,'general00'}
      ,{131,'primary99'}
      ,{132,'special99'}
      ,{133,'other99'}
      ,{134,'special299'}
      ,{135,'general99'}
      ,{136,'primary98'}
      ,{137,'special98'}
      ,{138,'other98'}
      ,{139,'special298'}
      ,{140,'general98'}
      ,{141,'primary97'}
      ,{142,'special97'}
      ,{143,'other97'}
      ,{144,'special297'}
      ,{145,'general97'}
      ,{146,'pres96'}
      ,{147,'primary96'}
      ,{148,'special96'}
      ,{149,'other96'}
      ,{150,'special296'}
      ,{151,'general96'}
      ,{152,'lastdayvote'}
      ,{153,'title'}
      ,{154,'fname'}
      ,{155,'mname'}
      ,{156,'lname'}
      ,{157,'name_suffix'}
      ,{158,'score_on_input'}
      ,{159,'prim_range'}
      ,{160,'predir'}
      ,{161,'prim_name'}
      ,{162,'suffix'}
      ,{163,'postdir'}
      ,{164,'unit_desig'}
      ,{165,'sec_range'}
      ,{166,'p_city_name'}
      ,{167,'city_name'}
      ,{168,'st'}
      ,{169,'zip'}
      ,{170,'zip4'}
      ,{171,'cart'}
      ,{172,'cr_sort_sz'}
      ,{173,'lot'}
      ,{174,'lot_order'}
      ,{175,'dpbc'}
      ,{176,'chk_digit'}
      ,{177,'record_type'}
      ,{178,'ace_fips_st'}
      ,{179,'county'}
      ,{180,'county_name'}
      ,{181,'geo_lat'}
      ,{182,'geo_long'}
      ,{183,'msa'}
      ,{184,'geo_blk'}
      ,{185,'geo_match'}
      ,{186,'err_stat'}
      ,{187,'mail_prim_range'}
      ,{188,'mail_predir'}
      ,{189,'mail_prim_name'}
      ,{190,'mail_addr_suffix'}
      ,{191,'mail_postdir'}
      ,{192,'mail_unit_desig'}
      ,{193,'mail_sec_range'}
      ,{194,'mail_p_city_name'}
      ,{195,'mail_v_city_name'}
      ,{196,'mail_st'}
      ,{197,'mail_ace_zip'}
      ,{198,'mail_zip4'}
      ,{199,'mail_cart'}
      ,{200,'mail_cr_sort_sz'}
      ,{201,'mail_lot'}
      ,{202,'mail_lot_order'}
      ,{203,'mail_dpbc'}
      ,{204,'mail_chk_digit'}
      ,{205,'mail_record_type'}
      ,{206,'mail_ace_fips_st'}
      ,{207,'mail_fipscounty'}
      ,{208,'mail_geo_lat'}
      ,{209,'mail_geo_long'}
      ,{210,'mail_msa'}
      ,{211,'mail_geo_blk'}
      ,{212,'mail_geo_match'}
      ,{213,'mail_err_stat'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Voters_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Voters_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Voters_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Voters_Fields.InValid_score((SALT311.StrType)le.score),
    Voters_Fields.InValid_best_ssn((SALT311.StrType)le.best_ssn),
    Voters_Fields.InValid_did_out((SALT311.StrType)le.did_out),
    Voters_Fields.InValid_source((SALT311.StrType)le.source),
    Voters_Fields.InValid_file_id((SALT311.StrType)le.file_id),
    Voters_Fields.InValid_vendor_id((SALT311.StrType)le.vendor_id),
    Voters_Fields.InValid_source_state((SALT311.StrType)le.source_state),
    Voters_Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Voters_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date),
    Voters_Fields.InValid__use((SALT311.StrType)le._use),
    Voters_Fields.InValid_title_in((SALT311.StrType)le.title_in),
    Voters_Fields.InValid_lname_in((SALT311.StrType)le.lname_in),
    Voters_Fields.InValid_fname_in((SALT311.StrType)le.fname_in),
    Voters_Fields.InValid_mname_in((SALT311.StrType)le.mname_in),
    Voters_Fields.InValid_maiden_prior((SALT311.StrType)le.maiden_prior),
    Voters_Fields.InValid_name_suffix_in((SALT311.StrType)le.name_suffix_in),
    Voters_Fields.InValid_votefiller((SALT311.StrType)le.votefiller),
    Voters_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid),
    Voters_Fields.InValid_dob((SALT311.StrType)le.dob),
    Voters_Fields.InValid_agecat((SALT311.StrType)le.agecat),
    Voters_Fields.InValid_headhousehold((SALT311.StrType)le.headhousehold),
    Voters_Fields.InValid_place_of_birth((SALT311.StrType)le.place_of_birth),
    Voters_Fields.InValid_occupation((SALT311.StrType)le.occupation),
    Voters_Fields.InValid_maiden_name((SALT311.StrType)le.maiden_name),
    Voters_Fields.InValid_motorvoterid((SALT311.StrType)le.motorvoterid),
    Voters_Fields.InValid_regsource((SALT311.StrType)le.regsource),
    Voters_Fields.InValid_regdate((SALT311.StrType)le.regdate),
    Voters_Fields.InValid_race((SALT311.StrType)le.race),
    Voters_Fields.InValid_gender((SALT311.StrType)le.gender),
    Voters_Fields.InValid_poliparty((SALT311.StrType)le.poliparty),
    Voters_Fields.InValid_poliparty_mapped((SALT311.StrType)le.poliparty_mapped),
    Voters_Fields.InValid_phone((SALT311.StrType)le.phone),
    Voters_Fields.InValid_work_phone((SALT311.StrType)le.work_phone),
    Voters_Fields.InValid_other_phone((SALT311.StrType)le.other_phone),
    Voters_Fields.InValid_active_status((SALT311.StrType)le.active_status),
    Voters_Fields.InValid_active_status_mapped((SALT311.StrType)le.active_status_mapped),
    Voters_Fields.InValid_votefiller2((SALT311.StrType)le.votefiller2),
    Voters_Fields.InValid_active_other((SALT311.StrType)le.active_other),
    Voters_Fields.InValid_voterstatus((SALT311.StrType)le.voterstatus),
    Voters_Fields.InValid_voterstatus_mapped((SALT311.StrType)le.voterstatus_mapped),
    Voters_Fields.InValid_resaddr1((SALT311.StrType)le.resaddr1),
    Voters_Fields.InValid_resaddr2((SALT311.StrType)le.resaddr2),
    Voters_Fields.InValid_res_city((SALT311.StrType)le.res_city),
    Voters_Fields.InValid_res_state((SALT311.StrType)le.res_state),
    Voters_Fields.InValid_res_zip((SALT311.StrType)le.res_zip),
    Voters_Fields.InValid_res_county((SALT311.StrType)le.res_county),
    Voters_Fields.InValid_mail_addr1((SALT311.StrType)le.mail_addr1),
    Voters_Fields.InValid_mail_addr2((SALT311.StrType)le.mail_addr2),
    Voters_Fields.InValid_mail_city((SALT311.StrType)le.mail_city),
    Voters_Fields.InValid_mail_state((SALT311.StrType)le.mail_state),
    Voters_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip),
    Voters_Fields.InValid_mail_county((SALT311.StrType)le.mail_county),
    Voters_Fields.InValid_addr_filler1((SALT311.StrType)le.addr_filler1),
    Voters_Fields.InValid_addr_filler2((SALT311.StrType)le.addr_filler2),
    Voters_Fields.InValid_city_filler((SALT311.StrType)le.city_filler),
    Voters_Fields.InValid_state_filler((SALT311.StrType)le.state_filler),
    Voters_Fields.InValid_zip_filler((SALT311.StrType)le.zip_filler),
    Voters_Fields.InValid_county_filler((SALT311.StrType)le.county_filler),
    Voters_Fields.InValid_towncode((SALT311.StrType)le.towncode),
    Voters_Fields.InValid_distcode((SALT311.StrType)le.distcode),
    Voters_Fields.InValid_countycode((SALT311.StrType)le.countycode),
    Voters_Fields.InValid_schoolcode((SALT311.StrType)le.schoolcode),
    Voters_Fields.InValid_cityinout((SALT311.StrType)le.cityinout),
    Voters_Fields.InValid_spec_dist1((SALT311.StrType)le.spec_dist1),
    Voters_Fields.InValid_spec_dist2((SALT311.StrType)le.spec_dist2),
    Voters_Fields.InValid_precinct1((SALT311.StrType)le.precinct1),
    Voters_Fields.InValid_precinct2((SALT311.StrType)le.precinct2),
    Voters_Fields.InValid_precinct3((SALT311.StrType)le.precinct3),
    Voters_Fields.InValid_villageprecinct((SALT311.StrType)le.villageprecinct),
    Voters_Fields.InValid_schoolprecinct((SALT311.StrType)le.schoolprecinct),
    Voters_Fields.InValid_ward((SALT311.StrType)le.ward),
    Voters_Fields.InValid_precinct_citytown((SALT311.StrType)le.precinct_citytown),
    Voters_Fields.InValid_ancsmdindc((SALT311.StrType)le.ancsmdindc),
    Voters_Fields.InValid_citycouncildist((SALT311.StrType)le.citycouncildist),
    Voters_Fields.InValid_countycommdist((SALT311.StrType)le.countycommdist),
    Voters_Fields.InValid_statehouse((SALT311.StrType)le.statehouse),
    Voters_Fields.InValid_statesenate((SALT311.StrType)le.statesenate),
    Voters_Fields.InValid_ushouse((SALT311.StrType)le.ushouse),
    Voters_Fields.InValid_elemschooldist((SALT311.StrType)le.elemschooldist),
    Voters_Fields.InValid_schooldist((SALT311.StrType)le.schooldist),
    Voters_Fields.InValid_schoolfiller((SALT311.StrType)le.schoolfiller),
    Voters_Fields.InValid_commcolldist((SALT311.StrType)le.commcolldist),
    Voters_Fields.InValid_dist_filler((SALT311.StrType)le.dist_filler),
    Voters_Fields.InValid_municipal((SALT311.StrType)le.municipal),
    Voters_Fields.InValid_villagedist((SALT311.StrType)le.villagedist),
    Voters_Fields.InValid_policejury((SALT311.StrType)le.policejury),
    Voters_Fields.InValid_policedist((SALT311.StrType)le.policedist),
    Voters_Fields.InValid_publicservcomm((SALT311.StrType)le.publicservcomm),
    Voters_Fields.InValid_rescue((SALT311.StrType)le.rescue),
    Voters_Fields.InValid_fire((SALT311.StrType)le.fire),
    Voters_Fields.InValid_sanitary((SALT311.StrType)le.sanitary),
    Voters_Fields.InValid_sewerdist((SALT311.StrType)le.sewerdist),
    Voters_Fields.InValid_waterdist((SALT311.StrType)le.waterdist),
    Voters_Fields.InValid_mosquitodist((SALT311.StrType)le.mosquitodist),
    Voters_Fields.InValid_taxdist((SALT311.StrType)le.taxdist),
    Voters_Fields.InValid_supremecourt((SALT311.StrType)le.supremecourt),
    Voters_Fields.InValid_justiceofpeace((SALT311.StrType)le.justiceofpeace),
    Voters_Fields.InValid_judicialdist((SALT311.StrType)le.judicialdist),
    Voters_Fields.InValid_superiorctdist((SALT311.StrType)le.superiorctdist),
    Voters_Fields.InValid_appealsct((SALT311.StrType)le.appealsct),
    Voters_Fields.InValid_courtfiller((SALT311.StrType)le.courtfiller),
    Voters_Fields.InValid_contributorparty((SALT311.StrType)le.contributorparty),
    Voters_Fields.InValid_recptparty((SALT311.StrType)le.recptparty),
    Voters_Fields.InValid_dateofcontr((SALT311.StrType)le.dateofcontr),
    Voters_Fields.InValid_dollaramt((SALT311.StrType)le.dollaramt),
    Voters_Fields.InValid_officecontto((SALT311.StrType)le.officecontto),
    Voters_Fields.InValid_cumuldollaramt((SALT311.StrType)le.cumuldollaramt),
    Voters_Fields.InValid_contfiller1((SALT311.StrType)le.contfiller1),
    Voters_Fields.InValid_contfiller2((SALT311.StrType)le.contfiller2),
    Voters_Fields.InValid_conttype((SALT311.StrType)le.conttype),
    Voters_Fields.InValid_contfiller3((SALT311.StrType)le.contfiller3),
    Voters_Fields.InValid_primary02((SALT311.StrType)le.primary02),
    Voters_Fields.InValid_special02((SALT311.StrType)le.special02),
    Voters_Fields.InValid_other02((SALT311.StrType)le.other02),
    Voters_Fields.InValid_special202((SALT311.StrType)le.special202),
    Voters_Fields.InValid_general02((SALT311.StrType)le.general02),
    Voters_Fields.InValid_primary01((SALT311.StrType)le.primary01),
    Voters_Fields.InValid_special01((SALT311.StrType)le.special01),
    Voters_Fields.InValid_other01((SALT311.StrType)le.other01),
    Voters_Fields.InValid_special201((SALT311.StrType)le.special201),
    Voters_Fields.InValid_general01((SALT311.StrType)le.general01),
    Voters_Fields.InValid_pres00((SALT311.StrType)le.pres00),
    Voters_Fields.InValid_primary00((SALT311.StrType)le.primary00),
    Voters_Fields.InValid_special00((SALT311.StrType)le.special00),
    Voters_Fields.InValid_other00((SALT311.StrType)le.other00),
    Voters_Fields.InValid_special200((SALT311.StrType)le.special200),
    Voters_Fields.InValid_general00((SALT311.StrType)le.general00),
    Voters_Fields.InValid_primary99((SALT311.StrType)le.primary99),
    Voters_Fields.InValid_special99((SALT311.StrType)le.special99),
    Voters_Fields.InValid_other99((SALT311.StrType)le.other99),
    Voters_Fields.InValid_special299((SALT311.StrType)le.special299),
    Voters_Fields.InValid_general99((SALT311.StrType)le.general99),
    Voters_Fields.InValid_primary98((SALT311.StrType)le.primary98),
    Voters_Fields.InValid_special98((SALT311.StrType)le.special98),
    Voters_Fields.InValid_other98((SALT311.StrType)le.other98),
    Voters_Fields.InValid_special298((SALT311.StrType)le.special298),
    Voters_Fields.InValid_general98((SALT311.StrType)le.general98),
    Voters_Fields.InValid_primary97((SALT311.StrType)le.primary97),
    Voters_Fields.InValid_special97((SALT311.StrType)le.special97),
    Voters_Fields.InValid_other97((SALT311.StrType)le.other97),
    Voters_Fields.InValid_special297((SALT311.StrType)le.special297),
    Voters_Fields.InValid_general97((SALT311.StrType)le.general97),
    Voters_Fields.InValid_pres96((SALT311.StrType)le.pres96),
    Voters_Fields.InValid_primary96((SALT311.StrType)le.primary96),
    Voters_Fields.InValid_special96((SALT311.StrType)le.special96),
    Voters_Fields.InValid_other96((SALT311.StrType)le.other96),
    Voters_Fields.InValid_special296((SALT311.StrType)le.special296),
    Voters_Fields.InValid_general96((SALT311.StrType)le.general96),
    Voters_Fields.InValid_lastdayvote((SALT311.StrType)le.lastdayvote),
    Voters_Fields.InValid_title((SALT311.StrType)le.title),
    Voters_Fields.InValid_fname((SALT311.StrType)le.fname),
    Voters_Fields.InValid_mname((SALT311.StrType)le.mname),
    Voters_Fields.InValid_lname((SALT311.StrType)le.lname),
    Voters_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Voters_Fields.InValid_score_on_input((SALT311.StrType)le.score_on_input),
    Voters_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Voters_Fields.InValid_predir((SALT311.StrType)le.predir),
    Voters_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Voters_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Voters_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Voters_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Voters_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Voters_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Voters_Fields.InValid_city_name((SALT311.StrType)le.city_name),
    Voters_Fields.InValid_st((SALT311.StrType)le.st),
    Voters_Fields.InValid_zip((SALT311.StrType)le.zip),
    Voters_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Voters_Fields.InValid_cart((SALT311.StrType)le.cart),
    Voters_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Voters_Fields.InValid_lot((SALT311.StrType)le.lot),
    Voters_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Voters_Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Voters_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Voters_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Voters_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Voters_Fields.InValid_county((SALT311.StrType)le.county),
    Voters_Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Voters_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Voters_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Voters_Fields.InValid_msa((SALT311.StrType)le.msa),
    Voters_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Voters_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Voters_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Voters_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range),
    Voters_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir),
    Voters_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name),
    Voters_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix),
    Voters_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir),
    Voters_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig),
    Voters_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range),
    Voters_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name),
    Voters_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name),
    Voters_Fields.InValid_mail_st((SALT311.StrType)le.mail_st),
    Voters_Fields.InValid_mail_ace_zip((SALT311.StrType)le.mail_ace_zip),
    Voters_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4),
    Voters_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart),
    Voters_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz),
    Voters_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot),
    Voters_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order),
    Voters_Fields.InValid_mail_dpbc((SALT311.StrType)le.mail_dpbc),
    Voters_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit),
    Voters_Fields.InValid_mail_record_type((SALT311.StrType)le.mail_record_type),
    Voters_Fields.InValid_mail_ace_fips_st((SALT311.StrType)le.mail_ace_fips_st),
    Voters_Fields.InValid_mail_fipscounty((SALT311.StrType)le.mail_fipscounty),
    Voters_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat),
    Voters_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long),
    Voters_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa),
    Voters_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk),
    Voters_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match),
    Voters_Fields.InValid_mail_err_stat((SALT311.StrType)le.mail_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,213,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Voters_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_Float','Invalid_No','Unknown','Invalid_Alpha','Unknown','Invalid_State','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Unknown','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Alpha','Invalid_Alpha','Unknown','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Unknown','Invalid_AlphaNum','Unknown','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Unknown','Invalid_Alpha','Invalid_No','Invalid_Date','Invalid_No','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Voters_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_score(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_did_out(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_source(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_file_id(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_source_state(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_file_acquired_date(TotalErrors.ErrorNum),Voters_Fields.InValidMessage__use(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_title_in(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_lname_in(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_fname_in(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mname_in(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_maiden_prior(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_name_suffix_in(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_votefiller(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_source_voterid(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_agecat(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_headhousehold(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_place_of_birth(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_occupation(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_maiden_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_motorvoterid(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_regsource(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_regdate(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_race(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_poliparty(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_poliparty_mapped(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other_phone(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_active_status(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_active_status_mapped(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_votefiller2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_active_other(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_voterstatus(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_voterstatus_mapped(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_resaddr1(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_resaddr2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_res_city(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_res_state(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_res_zip(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_res_county(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_addr1(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_addr2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_county(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_addr_filler1(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_addr_filler2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_city_filler(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_state_filler(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_zip_filler(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_county_filler(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_towncode(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_distcode(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_countycode(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_schoolcode(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_cityinout(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_spec_dist1(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_spec_dist2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_precinct1(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_precinct2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_precinct3(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_villageprecinct(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_schoolprecinct(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_ward(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_precinct_citytown(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_ancsmdindc(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_citycouncildist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_countycommdist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_statehouse(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_statesenate(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_ushouse(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_elemschooldist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_schooldist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_schoolfiller(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_commcolldist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_dist_filler(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_municipal(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_villagedist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_policejury(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_policedist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_publicservcomm(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_rescue(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_fire(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_sanitary(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_sewerdist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_waterdist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mosquitodist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_taxdist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_supremecourt(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_justiceofpeace(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_judicialdist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_superiorctdist(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_appealsct(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_courtfiller(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_contributorparty(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_recptparty(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_dateofcontr(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_dollaramt(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_officecontto(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_cumuldollaramt(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_contfiller1(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_contfiller2(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_conttype(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_contfiller3(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary02(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special02(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other02(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special202(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general02(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary01(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special01(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other01(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special201(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general01(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_pres00(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary00(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special00(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other00(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special200(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general00(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary99(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special99(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other99(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special299(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general99(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary98(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special98(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other98(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special298(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general98(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary97(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special97(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other97(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special297(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general97(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_pres96(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_primary96(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special96(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_other96(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_special296(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_general96(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_lastdayvote(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_title(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_score_on_input(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_st(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_county(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_prim_range(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_predir(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_prim_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_addr_suffix(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_postdir(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_unit_desig(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_sec_range(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_p_city_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_v_city_name(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_st(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_ace_zip(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_cart(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_cr_sort_sz(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_lot(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_lot_order(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_dpbc(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_chk_digit(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_record_type(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_ace_fips_st(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_fipscounty(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_geo_lat(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_geo_long(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_msa(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_geo_blk(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_geo_match(TotalErrors.ErrorNum),Voters_Fields.InValidMessage_mail_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_eMerges, Voters_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
