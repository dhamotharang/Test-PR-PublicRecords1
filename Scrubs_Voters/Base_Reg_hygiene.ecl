IMPORT SALT39,STD;
EXPORT Base_Reg_hygiene(dataset(Base_Reg_layout_Voters) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_rid_cnt := COUNT(GROUP,h.rid <> (TYPEOF(h.rid))'');
    populated_rid_pcnt := AVE(GROUP,IF(h.rid = (TYPEOF(h.rid))'',0,100));
    maxlength_rid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rid)));
    avelength_rid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rid)),h.rid<>(typeof(h.rid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_vtid_cnt := COUNT(GROUP,h.vtid <> (TYPEOF(h.vtid))'');
    populated_vtid_pcnt := AVE(GROUP,IF(h.vtid = (TYPEOF(h.vtid))'',0,100));
    maxlength_vtid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vtid)));
    avelength_vtid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vtid)),h.vtid<>(typeof(h.vtid))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_file_id_cnt := COUNT(GROUP,h.file_id <> (TYPEOF(h.file_id))'');
    populated_file_id_pcnt := AVE(GROUP,IF(h.file_id = (TYPEOF(h.file_id))'',0,100));
    maxlength_file_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_id)));
    avelength_file_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_id)),h.file_id<>(typeof(h.file_id))'');
    populated_vendor_id_cnt := COUNT(GROUP,h.vendor_id <> (TYPEOF(h.vendor_id))'');
    populated_vendor_id_pcnt := AVE(GROUP,IF(h.vendor_id = (TYPEOF(h.vendor_id))'',0,100));
    maxlength_vendor_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor_id)));
    avelength_vendor_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor_id)),h.vendor_id<>(typeof(h.vendor_id))'');
    populated_source_state_cnt := COUNT(GROUP,h.source_state <> (TYPEOF(h.source_state))'');
    populated_source_state_pcnt := AVE(GROUP,IF(h.source_state = (TYPEOF(h.source_state))'',0,100));
    maxlength_source_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_state)));
    avelength_source_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_state)),h.source_state<>(typeof(h.source_state))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_file_acquired_date_cnt := COUNT(GROUP,h.file_acquired_date <> (TYPEOF(h.file_acquired_date))'');
    populated_file_acquired_date_pcnt := AVE(GROUP,IF(h.file_acquired_date = (TYPEOF(h.file_acquired_date))'',0,100));
    maxlength_file_acquired_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_acquired_date)));
    avelength_file_acquired_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_acquired_date)),h.file_acquired_date<>(typeof(h.file_acquired_date))'');
    populated_use_code_cnt := COUNT(GROUP,h.use_code <> (TYPEOF(h.use_code))'');
    populated_use_code_pcnt := AVE(GROUP,IF(h.use_code = (TYPEOF(h.use_code))'',0,100));
    maxlength_use_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.use_code)));
    avelength_use_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.use_code)),h.use_code<>(typeof(h.use_code))'');
    populated_prefix_title_cnt := COUNT(GROUP,h.prefix_title <> (TYPEOF(h.prefix_title))'');
    populated_prefix_title_pcnt := AVE(GROUP,IF(h.prefix_title = (TYPEOF(h.prefix_title))'',0,100));
    maxlength_prefix_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prefix_title)));
    avelength_prefix_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prefix_title)),h.prefix_title<>(typeof(h.prefix_title))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_cnt := COUNT(GROUP,h.middle_name <> (TYPEOF(h.middle_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_maiden_prior_cnt := COUNT(GROUP,h.maiden_prior <> (TYPEOF(h.maiden_prior))'');
    populated_maiden_prior_pcnt := AVE(GROUP,IF(h.maiden_prior = (TYPEOF(h.maiden_prior))'',0,100));
    maxlength_maiden_prior := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.maiden_prior)));
    avelength_maiden_prior := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.maiden_prior)),h.maiden_prior<>(typeof(h.maiden_prior))'');
    populated_clean_maiden_pri_cnt := COUNT(GROUP,h.clean_maiden_pri <> (TYPEOF(h.clean_maiden_pri))'');
    populated_clean_maiden_pri_pcnt := AVE(GROUP,IF(h.clean_maiden_pri = (TYPEOF(h.clean_maiden_pri))'',0,100));
    maxlength_clean_maiden_pri := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.clean_maiden_pri)));
    avelength_clean_maiden_pri := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.clean_maiden_pri)),h.clean_maiden_pri<>(typeof(h.clean_maiden_pri))'');
    populated_name_suffix_in_cnt := COUNT(GROUP,h.name_suffix_in <> (TYPEOF(h.name_suffix_in))'');
    populated_name_suffix_in_pcnt := AVE(GROUP,IF(h.name_suffix_in = (TYPEOF(h.name_suffix_in))'',0,100));
    maxlength_name_suffix_in := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix_in)));
    avelength_name_suffix_in := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix_in)),h.name_suffix_in<>(typeof(h.name_suffix_in))'');
    populated_voterfiller_cnt := COUNT(GROUP,h.voterfiller <> (TYPEOF(h.voterfiller))'');
    populated_voterfiller_pcnt := AVE(GROUP,IF(h.voterfiller = (TYPEOF(h.voterfiller))'',0,100));
    maxlength_voterfiller := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.voterfiller)));
    avelength_voterfiller := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.voterfiller)),h.voterfiller<>(typeof(h.voterfiller))'');
    populated_source_voterid_cnt := COUNT(GROUP,h.source_voterid <> (TYPEOF(h.source_voterid))'');
    populated_source_voterid_pcnt := AVE(GROUP,IF(h.source_voterid = (TYPEOF(h.source_voterid))'',0,100));
    maxlength_source_voterid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_voterid)));
    avelength_source_voterid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_voterid)),h.source_voterid<>(typeof(h.source_voterid))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_agecat_cnt := COUNT(GROUP,h.agecat <> (TYPEOF(h.agecat))'');
    populated_agecat_pcnt := AVE(GROUP,IF(h.agecat = (TYPEOF(h.agecat))'',0,100));
    maxlength_agecat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.agecat)));
    avelength_agecat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.agecat)),h.agecat<>(typeof(h.agecat))'');
    populated_agecat_exp_cnt := COUNT(GROUP,h.agecat_exp <> (TYPEOF(h.agecat_exp))'');
    populated_agecat_exp_pcnt := AVE(GROUP,IF(h.agecat_exp = (TYPEOF(h.agecat_exp))'',0,100));
    maxlength_agecat_exp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.agecat_exp)));
    avelength_agecat_exp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.agecat_exp)),h.agecat_exp<>(typeof(h.agecat_exp))'');
    populated_headhousehold_cnt := COUNT(GROUP,h.headhousehold <> (TYPEOF(h.headhousehold))'');
    populated_headhousehold_pcnt := AVE(GROUP,IF(h.headhousehold = (TYPEOF(h.headhousehold))'',0,100));
    maxlength_headhousehold := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.headhousehold)));
    avelength_headhousehold := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.headhousehold)),h.headhousehold<>(typeof(h.headhousehold))'');
    populated_place_of_birth_cnt := COUNT(GROUP,h.place_of_birth <> (TYPEOF(h.place_of_birth))'');
    populated_place_of_birth_pcnt := AVE(GROUP,IF(h.place_of_birth = (TYPEOF(h.place_of_birth))'',0,100));
    maxlength_place_of_birth := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.place_of_birth)));
    avelength_place_of_birth := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.place_of_birth)),h.place_of_birth<>(typeof(h.place_of_birth))'');
    populated_occupation_cnt := COUNT(GROUP,h.occupation <> (TYPEOF(h.occupation))'');
    populated_occupation_pcnt := AVE(GROUP,IF(h.occupation = (TYPEOF(h.occupation))'',0,100));
    maxlength_occupation := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.occupation)));
    avelength_occupation := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.occupation)),h.occupation<>(typeof(h.occupation))'');
    populated_maiden_name_cnt := COUNT(GROUP,h.maiden_name <> (TYPEOF(h.maiden_name))'');
    populated_maiden_name_pcnt := AVE(GROUP,IF(h.maiden_name = (TYPEOF(h.maiden_name))'',0,100));
    maxlength_maiden_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.maiden_name)));
    avelength_maiden_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.maiden_name)),h.maiden_name<>(typeof(h.maiden_name))'');
    populated_motorvoterid_cnt := COUNT(GROUP,h.motorvoterid <> (TYPEOF(h.motorvoterid))'');
    populated_motorvoterid_pcnt := AVE(GROUP,IF(h.motorvoterid = (TYPEOF(h.motorvoterid))'',0,100));
    maxlength_motorvoterid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.motorvoterid)));
    avelength_motorvoterid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.motorvoterid)),h.motorvoterid<>(typeof(h.motorvoterid))'');
    populated_regsource_cnt := COUNT(GROUP,h.regsource <> (TYPEOF(h.regsource))'');
    populated_regsource_pcnt := AVE(GROUP,IF(h.regsource = (TYPEOF(h.regsource))'',0,100));
    maxlength_regsource := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.regsource)));
    avelength_regsource := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.regsource)),h.regsource<>(typeof(h.regsource))'');
    populated_regdate_cnt := COUNT(GROUP,h.regdate <> (TYPEOF(h.regdate))'');
    populated_regdate_pcnt := AVE(GROUP,IF(h.regdate = (TYPEOF(h.regdate))'',0,100));
    maxlength_regdate := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.regdate)));
    avelength_regdate := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.regdate)),h.regdate<>(typeof(h.regdate))'');
    populated_race_cnt := COUNT(GROUP,h.race <> (TYPEOF(h.race))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_race_exp_cnt := COUNT(GROUP,h.race_exp <> (TYPEOF(h.race_exp))'');
    populated_race_exp_pcnt := AVE(GROUP,IF(h.race_exp = (TYPEOF(h.race_exp))'',0,100));
    maxlength_race_exp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.race_exp)));
    avelength_race_exp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.race_exp)),h.race_exp<>(typeof(h.race_exp))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_political_party_cnt := COUNT(GROUP,h.political_party <> (TYPEOF(h.political_party))'');
    populated_political_party_pcnt := AVE(GROUP,IF(h.political_party = (TYPEOF(h.political_party))'',0,100));
    maxlength_political_party := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.political_party)));
    avelength_political_party := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.political_party)),h.political_party<>(typeof(h.political_party))'');
    populated_politicalparty_exp_cnt := COUNT(GROUP,h.politicalparty_exp <> (TYPEOF(h.politicalparty_exp))'');
    populated_politicalparty_exp_pcnt := AVE(GROUP,IF(h.politicalparty_exp = (TYPEOF(h.politicalparty_exp))'',0,100));
    maxlength_politicalparty_exp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.politicalparty_exp)));
    avelength_politicalparty_exp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.politicalparty_exp)),h.politicalparty_exp<>(typeof(h.politicalparty_exp))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_work_phone_cnt := COUNT(GROUP,h.work_phone <> (TYPEOF(h.work_phone))'');
    populated_work_phone_pcnt := AVE(GROUP,IF(h.work_phone = (TYPEOF(h.work_phone))'',0,100));
    maxlength_work_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.work_phone)));
    avelength_work_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.work_phone)),h.work_phone<>(typeof(h.work_phone))'');
    populated_other_phone_cnt := COUNT(GROUP,h.other_phone <> (TYPEOF(h.other_phone))'');
    populated_other_phone_pcnt := AVE(GROUP,IF(h.other_phone = (TYPEOF(h.other_phone))'',0,100));
    maxlength_other_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.other_phone)));
    avelength_other_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.other_phone)),h.other_phone<>(typeof(h.other_phone))'');
    populated_active_status_cnt := COUNT(GROUP,h.active_status <> (TYPEOF(h.active_status))'');
    populated_active_status_pcnt := AVE(GROUP,IF(h.active_status = (TYPEOF(h.active_status))'',0,100));
    maxlength_active_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.active_status)));
    avelength_active_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.active_status)),h.active_status<>(typeof(h.active_status))'');
    populated_active_status_exp_cnt := COUNT(GROUP,h.active_status_exp <> (TYPEOF(h.active_status_exp))'');
    populated_active_status_exp_pcnt := AVE(GROUP,IF(h.active_status_exp = (TYPEOF(h.active_status_exp))'',0,100));
    maxlength_active_status_exp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.active_status_exp)));
    avelength_active_status_exp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.active_status_exp)),h.active_status_exp<>(typeof(h.active_status_exp))'');
    populated_gendersurnamguess_cnt := COUNT(GROUP,h.gendersurnamguess <> (TYPEOF(h.gendersurnamguess))'');
    populated_gendersurnamguess_pcnt := AVE(GROUP,IF(h.gendersurnamguess = (TYPEOF(h.gendersurnamguess))'',0,100));
    maxlength_gendersurnamguess := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.gendersurnamguess)));
    avelength_gendersurnamguess := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.gendersurnamguess)),h.gendersurnamguess<>(typeof(h.gendersurnamguess))'');
    populated_active_other_cnt := COUNT(GROUP,h.active_other <> (TYPEOF(h.active_other))'');
    populated_active_other_pcnt := AVE(GROUP,IF(h.active_other = (TYPEOF(h.active_other))'',0,100));
    maxlength_active_other := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.active_other)));
    avelength_active_other := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.active_other)),h.active_other<>(typeof(h.active_other))'');
    populated_voter_status_cnt := COUNT(GROUP,h.voter_status <> (TYPEOF(h.voter_status))'');
    populated_voter_status_pcnt := AVE(GROUP,IF(h.voter_status = (TYPEOF(h.voter_status))'',0,100));
    maxlength_voter_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.voter_status)));
    avelength_voter_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.voter_status)),h.voter_status<>(typeof(h.voter_status))'');
    populated_voter_status_exp_cnt := COUNT(GROUP,h.voter_status_exp <> (TYPEOF(h.voter_status_exp))'');
    populated_voter_status_exp_pcnt := AVE(GROUP,IF(h.voter_status_exp = (TYPEOF(h.voter_status_exp))'',0,100));
    maxlength_voter_status_exp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.voter_status_exp)));
    avelength_voter_status_exp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.voter_status_exp)),h.voter_status_exp<>(typeof(h.voter_status_exp))'');
    populated_res_addr1_cnt := COUNT(GROUP,h.res_addr1 <> (TYPEOF(h.res_addr1))'');
    populated_res_addr1_pcnt := AVE(GROUP,IF(h.res_addr1 = (TYPEOF(h.res_addr1))'',0,100));
    maxlength_res_addr1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_addr1)));
    avelength_res_addr1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_addr1)),h.res_addr1<>(typeof(h.res_addr1))'');
    populated_res_addr2_cnt := COUNT(GROUP,h.res_addr2 <> (TYPEOF(h.res_addr2))'');
    populated_res_addr2_pcnt := AVE(GROUP,IF(h.res_addr2 = (TYPEOF(h.res_addr2))'',0,100));
    maxlength_res_addr2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_addr2)));
    avelength_res_addr2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_addr2)),h.res_addr2<>(typeof(h.res_addr2))'');
    populated_res_city_cnt := COUNT(GROUP,h.res_city <> (TYPEOF(h.res_city))'');
    populated_res_city_pcnt := AVE(GROUP,IF(h.res_city = (TYPEOF(h.res_city))'',0,100));
    maxlength_res_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_city)));
    avelength_res_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_city)),h.res_city<>(typeof(h.res_city))'');
    populated_res_state_cnt := COUNT(GROUP,h.res_state <> (TYPEOF(h.res_state))'');
    populated_res_state_pcnt := AVE(GROUP,IF(h.res_state = (TYPEOF(h.res_state))'',0,100));
    maxlength_res_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_state)));
    avelength_res_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_state)),h.res_state<>(typeof(h.res_state))'');
    populated_res_zip_cnt := COUNT(GROUP,h.res_zip <> (TYPEOF(h.res_zip))'');
    populated_res_zip_pcnt := AVE(GROUP,IF(h.res_zip = (TYPEOF(h.res_zip))'',0,100));
    maxlength_res_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_zip)));
    avelength_res_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_zip)),h.res_zip<>(typeof(h.res_zip))'');
    populated_res_county_cnt := COUNT(GROUP,h.res_county <> (TYPEOF(h.res_county))'');
    populated_res_county_pcnt := AVE(GROUP,IF(h.res_county = (TYPEOF(h.res_county))'',0,100));
    maxlength_res_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_county)));
    avelength_res_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.res_county)),h.res_county<>(typeof(h.res_county))'');
    populated_mail_addr1_cnt := COUNT(GROUP,h.mail_addr1 <> (TYPEOF(h.mail_addr1))'');
    populated_mail_addr1_pcnt := AVE(GROUP,IF(h.mail_addr1 = (TYPEOF(h.mail_addr1))'',0,100));
    maxlength_mail_addr1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_addr1)));
    avelength_mail_addr1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_addr1)),h.mail_addr1<>(typeof(h.mail_addr1))'');
    populated_mail_addr2_cnt := COUNT(GROUP,h.mail_addr2 <> (TYPEOF(h.mail_addr2))'');
    populated_mail_addr2_pcnt := AVE(GROUP,IF(h.mail_addr2 = (TYPEOF(h.mail_addr2))'',0,100));
    maxlength_mail_addr2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_addr2)));
    avelength_mail_addr2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_addr2)),h.mail_addr2<>(typeof(h.mail_addr2))'');
    populated_mail_city_cnt := COUNT(GROUP,h.mail_city <> (TYPEOF(h.mail_city))'');
    populated_mail_city_pcnt := AVE(GROUP,IF(h.mail_city = (TYPEOF(h.mail_city))'',0,100));
    maxlength_mail_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_city)));
    avelength_mail_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_city)),h.mail_city<>(typeof(h.mail_city))'');
    populated_mail_state_cnt := COUNT(GROUP,h.mail_state <> (TYPEOF(h.mail_state))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip_cnt := COUNT(GROUP,h.mail_zip <> (TYPEOF(h.mail_zip))'');
    populated_mail_zip_pcnt := AVE(GROUP,IF(h.mail_zip = (TYPEOF(h.mail_zip))'',0,100));
    maxlength_mail_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_zip)));
    avelength_mail_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_zip)),h.mail_zip<>(typeof(h.mail_zip))'');
    populated_mail_county_cnt := COUNT(GROUP,h.mail_county <> (TYPEOF(h.mail_county))'');
    populated_mail_county_pcnt := AVE(GROUP,IF(h.mail_county = (TYPEOF(h.mail_county))'',0,100));
    maxlength_mail_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_county)));
    avelength_mail_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_county)),h.mail_county<>(typeof(h.mail_county))'');
    populated_addr_filler1_cnt := COUNT(GROUP,h.addr_filler1 <> (TYPEOF(h.addr_filler1))'');
    populated_addr_filler1_pcnt := AVE(GROUP,IF(h.addr_filler1 = (TYPEOF(h.addr_filler1))'',0,100));
    maxlength_addr_filler1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_filler1)));
    avelength_addr_filler1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_filler1)),h.addr_filler1<>(typeof(h.addr_filler1))'');
    populated_addr_filler2_cnt := COUNT(GROUP,h.addr_filler2 <> (TYPEOF(h.addr_filler2))'');
    populated_addr_filler2_pcnt := AVE(GROUP,IF(h.addr_filler2 = (TYPEOF(h.addr_filler2))'',0,100));
    maxlength_addr_filler2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_filler2)));
    avelength_addr_filler2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_filler2)),h.addr_filler2<>(typeof(h.addr_filler2))'');
    populated_city_filler_cnt := COUNT(GROUP,h.city_filler <> (TYPEOF(h.city_filler))'');
    populated_city_filler_pcnt := AVE(GROUP,IF(h.city_filler = (TYPEOF(h.city_filler))'',0,100));
    maxlength_city_filler := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.city_filler)));
    avelength_city_filler := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.city_filler)),h.city_filler<>(typeof(h.city_filler))'');
    populated_state_filler_cnt := COUNT(GROUP,h.state_filler <> (TYPEOF(h.state_filler))'');
    populated_state_filler_pcnt := AVE(GROUP,IF(h.state_filler = (TYPEOF(h.state_filler))'',0,100));
    maxlength_state_filler := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_filler)));
    avelength_state_filler := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_filler)),h.state_filler<>(typeof(h.state_filler))'');
    populated_zip_filler_cnt := COUNT(GROUP,h.zip_filler <> (TYPEOF(h.zip_filler))'');
    populated_zip_filler_pcnt := AVE(GROUP,IF(h.zip_filler = (TYPEOF(h.zip_filler))'',0,100));
    maxlength_zip_filler := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip_filler)));
    avelength_zip_filler := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip_filler)),h.zip_filler<>(typeof(h.zip_filler))'');
    populated_timezonetbl_cnt := COUNT(GROUP,h.timezonetbl <> (TYPEOF(h.timezonetbl))'');
    populated_timezonetbl_pcnt := AVE(GROUP,IF(h.timezonetbl = (TYPEOF(h.timezonetbl))'',0,100));
    maxlength_timezonetbl := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.timezonetbl)));
    avelength_timezonetbl := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.timezonetbl)),h.timezonetbl<>(typeof(h.timezonetbl))'');
    populated_towncode_cnt := COUNT(GROUP,h.towncode <> (TYPEOF(h.towncode))'');
    populated_towncode_pcnt := AVE(GROUP,IF(h.towncode = (TYPEOF(h.towncode))'',0,100));
    maxlength_towncode := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.towncode)));
    avelength_towncode := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.towncode)),h.towncode<>(typeof(h.towncode))'');
    populated_distcode_cnt := COUNT(GROUP,h.distcode <> (TYPEOF(h.distcode))'');
    populated_distcode_pcnt := AVE(GROUP,IF(h.distcode = (TYPEOF(h.distcode))'',0,100));
    maxlength_distcode := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.distcode)));
    avelength_distcode := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.distcode)),h.distcode<>(typeof(h.distcode))'');
    populated_countycode_cnt := COUNT(GROUP,h.countycode <> (TYPEOF(h.countycode))'');
    populated_countycode_pcnt := AVE(GROUP,IF(h.countycode = (TYPEOF(h.countycode))'',0,100));
    maxlength_countycode := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.countycode)));
    avelength_countycode := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.countycode)),h.countycode<>(typeof(h.countycode))'');
    populated_schoolcode_cnt := COUNT(GROUP,h.schoolcode <> (TYPEOF(h.schoolcode))'');
    populated_schoolcode_pcnt := AVE(GROUP,IF(h.schoolcode = (TYPEOF(h.schoolcode))'',0,100));
    maxlength_schoolcode := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolcode)));
    avelength_schoolcode := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolcode)),h.schoolcode<>(typeof(h.schoolcode))'');
    populated_cityinout_cnt := COUNT(GROUP,h.cityinout <> (TYPEOF(h.cityinout))'');
    populated_cityinout_pcnt := AVE(GROUP,IF(h.cityinout = (TYPEOF(h.cityinout))'',0,100));
    maxlength_cityinout := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cityinout)));
    avelength_cityinout := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cityinout)),h.cityinout<>(typeof(h.cityinout))'');
    populated_spec_dist1_cnt := COUNT(GROUP,h.spec_dist1 <> (TYPEOF(h.spec_dist1))'');
    populated_spec_dist1_pcnt := AVE(GROUP,IF(h.spec_dist1 = (TYPEOF(h.spec_dist1))'',0,100));
    maxlength_spec_dist1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.spec_dist1)));
    avelength_spec_dist1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.spec_dist1)),h.spec_dist1<>(typeof(h.spec_dist1))'');
    populated_spec_dist2_cnt := COUNT(GROUP,h.spec_dist2 <> (TYPEOF(h.spec_dist2))'');
    populated_spec_dist2_pcnt := AVE(GROUP,IF(h.spec_dist2 = (TYPEOF(h.spec_dist2))'',0,100));
    maxlength_spec_dist2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.spec_dist2)));
    avelength_spec_dist2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.spec_dist2)),h.spec_dist2<>(typeof(h.spec_dist2))'');
    populated_precinct1_cnt := COUNT(GROUP,h.precinct1 <> (TYPEOF(h.precinct1))'');
    populated_precinct1_pcnt := AVE(GROUP,IF(h.precinct1 = (TYPEOF(h.precinct1))'',0,100));
    maxlength_precinct1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct1)));
    avelength_precinct1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct1)),h.precinct1<>(typeof(h.precinct1))'');
    populated_precinct2_cnt := COUNT(GROUP,h.precinct2 <> (TYPEOF(h.precinct2))'');
    populated_precinct2_pcnt := AVE(GROUP,IF(h.precinct2 = (TYPEOF(h.precinct2))'',0,100));
    maxlength_precinct2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct2)));
    avelength_precinct2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct2)),h.precinct2<>(typeof(h.precinct2))'');
    populated_precinct3_cnt := COUNT(GROUP,h.precinct3 <> (TYPEOF(h.precinct3))'');
    populated_precinct3_pcnt := AVE(GROUP,IF(h.precinct3 = (TYPEOF(h.precinct3))'',0,100));
    maxlength_precinct3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct3)));
    avelength_precinct3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct3)),h.precinct3<>(typeof(h.precinct3))'');
    populated_villageprecinct_cnt := COUNT(GROUP,h.villageprecinct <> (TYPEOF(h.villageprecinct))'');
    populated_villageprecinct_pcnt := AVE(GROUP,IF(h.villageprecinct = (TYPEOF(h.villageprecinct))'',0,100));
    maxlength_villageprecinct := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.villageprecinct)));
    avelength_villageprecinct := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.villageprecinct)),h.villageprecinct<>(typeof(h.villageprecinct))'');
    populated_schoolprecinct_cnt := COUNT(GROUP,h.schoolprecinct <> (TYPEOF(h.schoolprecinct))'');
    populated_schoolprecinct_pcnt := AVE(GROUP,IF(h.schoolprecinct = (TYPEOF(h.schoolprecinct))'',0,100));
    maxlength_schoolprecinct := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolprecinct)));
    avelength_schoolprecinct := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolprecinct)),h.schoolprecinct<>(typeof(h.schoolprecinct))'');
    populated_ward_cnt := COUNT(GROUP,h.ward <> (TYPEOF(h.ward))'');
    populated_ward_pcnt := AVE(GROUP,IF(h.ward = (TYPEOF(h.ward))'',0,100));
    maxlength_ward := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward)));
    avelength_ward := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward)),h.ward<>(typeof(h.ward))'');
    populated_precinct_citytown_cnt := COUNT(GROUP,h.precinct_citytown <> (TYPEOF(h.precinct_citytown))'');
    populated_precinct_citytown_pcnt := AVE(GROUP,IF(h.precinct_citytown = (TYPEOF(h.precinct_citytown))'',0,100));
    maxlength_precinct_citytown := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct_citytown)));
    avelength_precinct_citytown := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct_citytown)),h.precinct_citytown<>(typeof(h.precinct_citytown))'');
    populated_ancsmdindc_cnt := COUNT(GROUP,h.ancsmdindc <> (TYPEOF(h.ancsmdindc))'');
    populated_ancsmdindc_pcnt := AVE(GROUP,IF(h.ancsmdindc = (TYPEOF(h.ancsmdindc))'',0,100));
    maxlength_ancsmdindc := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ancsmdindc)));
    avelength_ancsmdindc := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ancsmdindc)),h.ancsmdindc<>(typeof(h.ancsmdindc))'');
    populated_citycouncildist_cnt := COUNT(GROUP,h.citycouncildist <> (TYPEOF(h.citycouncildist))'');
    populated_citycouncildist_pcnt := AVE(GROUP,IF(h.citycouncildist = (TYPEOF(h.citycouncildist))'',0,100));
    maxlength_citycouncildist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.citycouncildist)));
    avelength_citycouncildist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.citycouncildist)),h.citycouncildist<>(typeof(h.citycouncildist))'');
    populated_countycommdist_cnt := COUNT(GROUP,h.countycommdist <> (TYPEOF(h.countycommdist))'');
    populated_countycommdist_pcnt := AVE(GROUP,IF(h.countycommdist = (TYPEOF(h.countycommdist))'',0,100));
    maxlength_countycommdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.countycommdist)));
    avelength_countycommdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.countycommdist)),h.countycommdist<>(typeof(h.countycommdist))'');
    populated_statehouse_cnt := COUNT(GROUP,h.statehouse <> (TYPEOF(h.statehouse))'');
    populated_statehouse_pcnt := AVE(GROUP,IF(h.statehouse = (TYPEOF(h.statehouse))'',0,100));
    maxlength_statehouse := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.statehouse)));
    avelength_statehouse := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.statehouse)),h.statehouse<>(typeof(h.statehouse))'');
    populated_statesenate_cnt := COUNT(GROUP,h.statesenate <> (TYPEOF(h.statesenate))'');
    populated_statesenate_pcnt := AVE(GROUP,IF(h.statesenate = (TYPEOF(h.statesenate))'',0,100));
    maxlength_statesenate := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.statesenate)));
    avelength_statesenate := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.statesenate)),h.statesenate<>(typeof(h.statesenate))'');
    populated_ushouse_cnt := COUNT(GROUP,h.ushouse <> (TYPEOF(h.ushouse))'');
    populated_ushouse_pcnt := AVE(GROUP,IF(h.ushouse = (TYPEOF(h.ushouse))'',0,100));
    maxlength_ushouse := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ushouse)));
    avelength_ushouse := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ushouse)),h.ushouse<>(typeof(h.ushouse))'');
    populated_elemschooldist_cnt := COUNT(GROUP,h.elemschooldist <> (TYPEOF(h.elemschooldist))'');
    populated_elemschooldist_pcnt := AVE(GROUP,IF(h.elemschooldist = (TYPEOF(h.elemschooldist))'',0,100));
    maxlength_elemschooldist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.elemschooldist)));
    avelength_elemschooldist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.elemschooldist)),h.elemschooldist<>(typeof(h.elemschooldist))'');
    populated_schooldist_cnt := COUNT(GROUP,h.schooldist <> (TYPEOF(h.schooldist))'');
    populated_schooldist_pcnt := AVE(GROUP,IF(h.schooldist = (TYPEOF(h.schooldist))'',0,100));
    maxlength_schooldist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.schooldist)));
    avelength_schooldist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.schooldist)),h.schooldist<>(typeof(h.schooldist))'');
    populated_schoolfiller_cnt := COUNT(GROUP,h.schoolfiller <> (TYPEOF(h.schoolfiller))'');
    populated_schoolfiller_pcnt := AVE(GROUP,IF(h.schoolfiller = (TYPEOF(h.schoolfiller))'',0,100));
    maxlength_schoolfiller := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolfiller)));
    avelength_schoolfiller := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolfiller)),h.schoolfiller<>(typeof(h.schoolfiller))'');
    populated_commcolldist_cnt := COUNT(GROUP,h.commcolldist <> (TYPEOF(h.commcolldist))'');
    populated_commcolldist_pcnt := AVE(GROUP,IF(h.commcolldist = (TYPEOF(h.commcolldist))'',0,100));
    maxlength_commcolldist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.commcolldist)));
    avelength_commcolldist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.commcolldist)),h.commcolldist<>(typeof(h.commcolldist))'');
    populated_dist_filler_cnt := COUNT(GROUP,h.dist_filler <> (TYPEOF(h.dist_filler))'');
    populated_dist_filler_pcnt := AVE(GROUP,IF(h.dist_filler = (TYPEOF(h.dist_filler))'',0,100));
    maxlength_dist_filler := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dist_filler)));
    avelength_dist_filler := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dist_filler)),h.dist_filler<>(typeof(h.dist_filler))'');
    populated_municipal_cnt := COUNT(GROUP,h.municipal <> (TYPEOF(h.municipal))'');
    populated_municipal_pcnt := AVE(GROUP,IF(h.municipal = (TYPEOF(h.municipal))'',0,100));
    maxlength_municipal := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.municipal)));
    avelength_municipal := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.municipal)),h.municipal<>(typeof(h.municipal))'');
    populated_villagedist_cnt := COUNT(GROUP,h.villagedist <> (TYPEOF(h.villagedist))'');
    populated_villagedist_pcnt := AVE(GROUP,IF(h.villagedist = (TYPEOF(h.villagedist))'',0,100));
    maxlength_villagedist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.villagedist)));
    avelength_villagedist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.villagedist)),h.villagedist<>(typeof(h.villagedist))'');
    populated_policejury_cnt := COUNT(GROUP,h.policejury <> (TYPEOF(h.policejury))'');
    populated_policejury_pcnt := AVE(GROUP,IF(h.policejury = (TYPEOF(h.policejury))'',0,100));
    maxlength_policejury := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.policejury)));
    avelength_policejury := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.policejury)),h.policejury<>(typeof(h.policejury))'');
    populated_policedist_cnt := COUNT(GROUP,h.policedist <> (TYPEOF(h.policedist))'');
    populated_policedist_pcnt := AVE(GROUP,IF(h.policedist = (TYPEOF(h.policedist))'',0,100));
    maxlength_policedist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.policedist)));
    avelength_policedist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.policedist)),h.policedist<>(typeof(h.policedist))'');
    populated_publicservcomm_cnt := COUNT(GROUP,h.publicservcomm <> (TYPEOF(h.publicservcomm))'');
    populated_publicservcomm_pcnt := AVE(GROUP,IF(h.publicservcomm = (TYPEOF(h.publicservcomm))'',0,100));
    maxlength_publicservcomm := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.publicservcomm)));
    avelength_publicservcomm := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.publicservcomm)),h.publicservcomm<>(typeof(h.publicservcomm))'');
    populated_rescue_cnt := COUNT(GROUP,h.rescue <> (TYPEOF(h.rescue))'');
    populated_rescue_pcnt := AVE(GROUP,IF(h.rescue = (TYPEOF(h.rescue))'',0,100));
    maxlength_rescue := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rescue)));
    avelength_rescue := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rescue)),h.rescue<>(typeof(h.rescue))'');
    populated_fire_cnt := COUNT(GROUP,h.fire <> (TYPEOF(h.fire))'');
    populated_fire_pcnt := AVE(GROUP,IF(h.fire = (TYPEOF(h.fire))'',0,100));
    maxlength_fire := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fire)));
    avelength_fire := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fire)),h.fire<>(typeof(h.fire))'');
    populated_sanitary_cnt := COUNT(GROUP,h.sanitary <> (TYPEOF(h.sanitary))'');
    populated_sanitary_pcnt := AVE(GROUP,IF(h.sanitary = (TYPEOF(h.sanitary))'',0,100));
    maxlength_sanitary := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sanitary)));
    avelength_sanitary := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sanitary)),h.sanitary<>(typeof(h.sanitary))'');
    populated_sewerdist_cnt := COUNT(GROUP,h.sewerdist <> (TYPEOF(h.sewerdist))'');
    populated_sewerdist_pcnt := AVE(GROUP,IF(h.sewerdist = (TYPEOF(h.sewerdist))'',0,100));
    maxlength_sewerdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sewerdist)));
    avelength_sewerdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sewerdist)),h.sewerdist<>(typeof(h.sewerdist))'');
    populated_waterdist_cnt := COUNT(GROUP,h.waterdist <> (TYPEOF(h.waterdist))'');
    populated_waterdist_pcnt := AVE(GROUP,IF(h.waterdist = (TYPEOF(h.waterdist))'',0,100));
    maxlength_waterdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.waterdist)));
    avelength_waterdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.waterdist)),h.waterdist<>(typeof(h.waterdist))'');
    populated_mosquitodist_cnt := COUNT(GROUP,h.mosquitodist <> (TYPEOF(h.mosquitodist))'');
    populated_mosquitodist_pcnt := AVE(GROUP,IF(h.mosquitodist = (TYPEOF(h.mosquitodist))'',0,100));
    maxlength_mosquitodist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mosquitodist)));
    avelength_mosquitodist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mosquitodist)),h.mosquitodist<>(typeof(h.mosquitodist))'');
    populated_taxdist_cnt := COUNT(GROUP,h.taxdist <> (TYPEOF(h.taxdist))'');
    populated_taxdist_pcnt := AVE(GROUP,IF(h.taxdist = (TYPEOF(h.taxdist))'',0,100));
    maxlength_taxdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.taxdist)));
    avelength_taxdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.taxdist)),h.taxdist<>(typeof(h.taxdist))'');
    populated_supremecourt_cnt := COUNT(GROUP,h.supremecourt <> (TYPEOF(h.supremecourt))'');
    populated_supremecourt_pcnt := AVE(GROUP,IF(h.supremecourt = (TYPEOF(h.supremecourt))'',0,100));
    maxlength_supremecourt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.supremecourt)));
    avelength_supremecourt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.supremecourt)),h.supremecourt<>(typeof(h.supremecourt))'');
    populated_justiceofpeace_cnt := COUNT(GROUP,h.justiceofpeace <> (TYPEOF(h.justiceofpeace))'');
    populated_justiceofpeace_pcnt := AVE(GROUP,IF(h.justiceofpeace = (TYPEOF(h.justiceofpeace))'',0,100));
    maxlength_justiceofpeace := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.justiceofpeace)));
    avelength_justiceofpeace := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.justiceofpeace)),h.justiceofpeace<>(typeof(h.justiceofpeace))'');
    populated_judicialdist_cnt := COUNT(GROUP,h.judicialdist <> (TYPEOF(h.judicialdist))'');
    populated_judicialdist_pcnt := AVE(GROUP,IF(h.judicialdist = (TYPEOF(h.judicialdist))'',0,100));
    maxlength_judicialdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judicialdist)));
    avelength_judicialdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judicialdist)),h.judicialdist<>(typeof(h.judicialdist))'');
    populated_superiorctdist_cnt := COUNT(GROUP,h.superiorctdist <> (TYPEOF(h.superiorctdist))'');
    populated_superiorctdist_pcnt := AVE(GROUP,IF(h.superiorctdist = (TYPEOF(h.superiorctdist))'',0,100));
    maxlength_superiorctdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.superiorctdist)));
    avelength_superiorctdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.superiorctdist)),h.superiorctdist<>(typeof(h.superiorctdist))'');
    populated_appealsct_cnt := COUNT(GROUP,h.appealsct <> (TYPEOF(h.appealsct))'');
    populated_appealsct_pcnt := AVE(GROUP,IF(h.appealsct = (TYPEOF(h.appealsct))'',0,100));
    maxlength_appealsct := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.appealsct)));
    avelength_appealsct := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.appealsct)),h.appealsct<>(typeof(h.appealsct))'');
    populated_courtfiller_cnt := COUNT(GROUP,h.courtfiller <> (TYPEOF(h.courtfiller))'');
    populated_courtfiller_pcnt := AVE(GROUP,IF(h.courtfiller = (TYPEOF(h.courtfiller))'',0,100));
    maxlength_courtfiller := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.courtfiller)));
    avelength_courtfiller := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.courtfiller)),h.courtfiller<>(typeof(h.courtfiller))'');
    populated_cassaddrtyptbl_cnt := COUNT(GROUP,h.cassaddrtyptbl <> (TYPEOF(h.cassaddrtyptbl))'');
    populated_cassaddrtyptbl_pcnt := AVE(GROUP,IF(h.cassaddrtyptbl = (TYPEOF(h.cassaddrtyptbl))'',0,100));
    maxlength_cassaddrtyptbl := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cassaddrtyptbl)));
    avelength_cassaddrtyptbl := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cassaddrtyptbl)),h.cassaddrtyptbl<>(typeof(h.cassaddrtyptbl))'');
    populated_cassdelivpointcd_cnt := COUNT(GROUP,h.cassdelivpointcd <> (TYPEOF(h.cassdelivpointcd))'');
    populated_cassdelivpointcd_pcnt := AVE(GROUP,IF(h.cassdelivpointcd = (TYPEOF(h.cassdelivpointcd))'',0,100));
    maxlength_cassdelivpointcd := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cassdelivpointcd)));
    avelength_cassdelivpointcd := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cassdelivpointcd)),h.cassdelivpointcd<>(typeof(h.cassdelivpointcd))'');
    populated_casscarrierrtetbl_cnt := COUNT(GROUP,h.casscarrierrtetbl <> (TYPEOF(h.casscarrierrtetbl))'');
    populated_casscarrierrtetbl_pcnt := AVE(GROUP,IF(h.casscarrierrtetbl = (TYPEOF(h.casscarrierrtetbl))'',0,100));
    maxlength_casscarrierrtetbl := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.casscarrierrtetbl)));
    avelength_casscarrierrtetbl := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.casscarrierrtetbl)),h.casscarrierrtetbl<>(typeof(h.casscarrierrtetbl))'');
    populated_blkgrpenumdist_cnt := COUNT(GROUP,h.blkgrpenumdist <> (TYPEOF(h.blkgrpenumdist))'');
    populated_blkgrpenumdist_pcnt := AVE(GROUP,IF(h.blkgrpenumdist = (TYPEOF(h.blkgrpenumdist))'',0,100));
    maxlength_blkgrpenumdist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.blkgrpenumdist)));
    avelength_blkgrpenumdist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.blkgrpenumdist)),h.blkgrpenumdist<>(typeof(h.blkgrpenumdist))'');
    populated_congressionaldist_cnt := COUNT(GROUP,h.congressionaldist <> (TYPEOF(h.congressionaldist))'');
    populated_congressionaldist_pcnt := AVE(GROUP,IF(h.congressionaldist = (TYPEOF(h.congressionaldist))'',0,100));
    maxlength_congressionaldist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.congressionaldist)));
    avelength_congressionaldist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.congressionaldist)),h.congressionaldist<>(typeof(h.congressionaldist))'');
    populated_lattitude_cnt := COUNT(GROUP,h.lattitude <> (TYPEOF(h.lattitude))'');
    populated_lattitude_pcnt := AVE(GROUP,IF(h.lattitude = (TYPEOF(h.lattitude))'',0,100));
    maxlength_lattitude := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lattitude)));
    avelength_lattitude := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lattitude)),h.lattitude<>(typeof(h.lattitude))'');
    populated_countyfips_cnt := COUNT(GROUP,h.countyfips <> (TYPEOF(h.countyfips))'');
    populated_countyfips_pcnt := AVE(GROUP,IF(h.countyfips = (TYPEOF(h.countyfips))'',0,100));
    maxlength_countyfips := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.countyfips)));
    avelength_countyfips := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.countyfips)),h.countyfips<>(typeof(h.countyfips))'');
    populated_censustract_cnt := COUNT(GROUP,h.censustract <> (TYPEOF(h.censustract))'');
    populated_censustract_pcnt := AVE(GROUP,IF(h.censustract = (TYPEOF(h.censustract))'',0,100));
    maxlength_censustract := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.censustract)));
    avelength_censustract := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.censustract)),h.censustract<>(typeof(h.censustract))'');
    populated_fipsstcountycd_cnt := COUNT(GROUP,h.fipsstcountycd <> (TYPEOF(h.fipsstcountycd))'');
    populated_fipsstcountycd_pcnt := AVE(GROUP,IF(h.fipsstcountycd = (TYPEOF(h.fipsstcountycd))'',0,100));
    maxlength_fipsstcountycd := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fipsstcountycd)));
    avelength_fipsstcountycd := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fipsstcountycd)),h.fipsstcountycd<>(typeof(h.fipsstcountycd))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_contributorparty_cnt := COUNT(GROUP,h.contributorparty <> (TYPEOF(h.contributorparty))'');
    populated_contributorparty_pcnt := AVE(GROUP,IF(h.contributorparty = (TYPEOF(h.contributorparty))'',0,100));
    maxlength_contributorparty := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.contributorparty)));
    avelength_contributorparty := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.contributorparty)),h.contributorparty<>(typeof(h.contributorparty))'');
    populated_recipientparty_cnt := COUNT(GROUP,h.recipientparty <> (TYPEOF(h.recipientparty))'');
    populated_recipientparty_pcnt := AVE(GROUP,IF(h.recipientparty = (TYPEOF(h.recipientparty))'',0,100));
    maxlength_recipientparty := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.recipientparty)));
    avelength_recipientparty := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.recipientparty)),h.recipientparty<>(typeof(h.recipientparty))'');
    populated_dateofcontr_cnt := COUNT(GROUP,h.dateofcontr <> (TYPEOF(h.dateofcontr))'');
    populated_dateofcontr_pcnt := AVE(GROUP,IF(h.dateofcontr = (TYPEOF(h.dateofcontr))'',0,100));
    maxlength_dateofcontr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dateofcontr)));
    avelength_dateofcontr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dateofcontr)),h.dateofcontr<>(typeof(h.dateofcontr))'');
    populated_dollaramt_cnt := COUNT(GROUP,h.dollaramt <> (TYPEOF(h.dollaramt))'');
    populated_dollaramt_pcnt := AVE(GROUP,IF(h.dollaramt = (TYPEOF(h.dollaramt))'',0,100));
    maxlength_dollaramt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dollaramt)));
    avelength_dollaramt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dollaramt)),h.dollaramt<>(typeof(h.dollaramt))'');
    populated_officecontto_cnt := COUNT(GROUP,h.officecontto <> (TYPEOF(h.officecontto))'');
    populated_officecontto_pcnt := AVE(GROUP,IF(h.officecontto = (TYPEOF(h.officecontto))'',0,100));
    maxlength_officecontto := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.officecontto)));
    avelength_officecontto := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.officecontto)),h.officecontto<>(typeof(h.officecontto))'');
    populated_cumuldollaramt_cnt := COUNT(GROUP,h.cumuldollaramt <> (TYPEOF(h.cumuldollaramt))'');
    populated_cumuldollaramt_pcnt := AVE(GROUP,IF(h.cumuldollaramt = (TYPEOF(h.cumuldollaramt))'',0,100));
    maxlength_cumuldollaramt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cumuldollaramt)));
    avelength_cumuldollaramt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cumuldollaramt)),h.cumuldollaramt<>(typeof(h.cumuldollaramt))'');
    populated_contfiller1_cnt := COUNT(GROUP,h.contfiller1 <> (TYPEOF(h.contfiller1))'');
    populated_contfiller1_pcnt := AVE(GROUP,IF(h.contfiller1 = (TYPEOF(h.contfiller1))'',0,100));
    maxlength_contfiller1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.contfiller1)));
    avelength_contfiller1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.contfiller1)),h.contfiller1<>(typeof(h.contfiller1))'');
    populated_contfiller2_cnt := COUNT(GROUP,h.contfiller2 <> (TYPEOF(h.contfiller2))'');
    populated_contfiller2_pcnt := AVE(GROUP,IF(h.contfiller2 = (TYPEOF(h.contfiller2))'',0,100));
    maxlength_contfiller2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.contfiller2)));
    avelength_contfiller2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.contfiller2)),h.contfiller2<>(typeof(h.contfiller2))'');
    populated_conttype_cnt := COUNT(GROUP,h.conttype <> (TYPEOF(h.conttype))'');
    populated_conttype_pcnt := AVE(GROUP,IF(h.conttype = (TYPEOF(h.conttype))'',0,100));
    maxlength_conttype := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.conttype)));
    avelength_conttype := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.conttype)),h.conttype<>(typeof(h.conttype))'');
    populated_contfiller4_cnt := COUNT(GROUP,h.contfiller4 <> (TYPEOF(h.contfiller4))'');
    populated_contfiller4_pcnt := AVE(GROUP,IF(h.contfiller4 = (TYPEOF(h.contfiller4))'',0,100));
    maxlength_contfiller4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.contfiller4)));
    avelength_contfiller4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.contfiller4)),h.contfiller4<>(typeof(h.contfiller4))'');
    populated_lastdatevote_cnt := COUNT(GROUP,h.lastdatevote <> (TYPEOF(h.lastdatevote))'');
    populated_lastdatevote_pcnt := AVE(GROUP,IF(h.lastdatevote = (TYPEOF(h.lastdatevote))'',0,100));
    maxlength_lastdatevote := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lastdatevote)));
    avelength_lastdatevote := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lastdatevote)),h.lastdatevote<>(typeof(h.lastdatevote))'');
    populated_miscvotehist_cnt := COUNT(GROUP,h.miscvotehist <> (TYPEOF(h.miscvotehist))'');
    populated_miscvotehist_pcnt := AVE(GROUP,IF(h.miscvotehist = (TYPEOF(h.miscvotehist))'',0,100));
    maxlength_miscvotehist := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.miscvotehist)));
    avelength_miscvotehist := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.miscvotehist)),h.miscvotehist<>(typeof(h.miscvotehist))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_mail_prim_range_cnt := COUNT(GROUP,h.mail_prim_range <> (TYPEOF(h.mail_prim_range))'');
    populated_mail_prim_range_pcnt := AVE(GROUP,IF(h.mail_prim_range = (TYPEOF(h.mail_prim_range))'',0,100));
    maxlength_mail_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_prim_range)));
    avelength_mail_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_prim_range)),h.mail_prim_range<>(typeof(h.mail_prim_range))'');
    populated_mail_predir_cnt := COUNT(GROUP,h.mail_predir <> (TYPEOF(h.mail_predir))'');
    populated_mail_predir_pcnt := AVE(GROUP,IF(h.mail_predir = (TYPEOF(h.mail_predir))'',0,100));
    maxlength_mail_predir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_predir)));
    avelength_mail_predir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_predir)),h.mail_predir<>(typeof(h.mail_predir))'');
    populated_mail_prim_name_cnt := COUNT(GROUP,h.mail_prim_name <> (TYPEOF(h.mail_prim_name))'');
    populated_mail_prim_name_pcnt := AVE(GROUP,IF(h.mail_prim_name = (TYPEOF(h.mail_prim_name))'',0,100));
    maxlength_mail_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_prim_name)));
    avelength_mail_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_prim_name)),h.mail_prim_name<>(typeof(h.mail_prim_name))'');
    populated_mail_addr_suffix_cnt := COUNT(GROUP,h.mail_addr_suffix <> (TYPEOF(h.mail_addr_suffix))'');
    populated_mail_addr_suffix_pcnt := AVE(GROUP,IF(h.mail_addr_suffix = (TYPEOF(h.mail_addr_suffix))'',0,100));
    maxlength_mail_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_addr_suffix)));
    avelength_mail_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_addr_suffix)),h.mail_addr_suffix<>(typeof(h.mail_addr_suffix))'');
    populated_mail_postdir_cnt := COUNT(GROUP,h.mail_postdir <> (TYPEOF(h.mail_postdir))'');
    populated_mail_postdir_pcnt := AVE(GROUP,IF(h.mail_postdir = (TYPEOF(h.mail_postdir))'',0,100));
    maxlength_mail_postdir := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_postdir)));
    avelength_mail_postdir := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_postdir)),h.mail_postdir<>(typeof(h.mail_postdir))'');
    populated_mail_unit_desig_cnt := COUNT(GROUP,h.mail_unit_desig <> (TYPEOF(h.mail_unit_desig))'');
    populated_mail_unit_desig_pcnt := AVE(GROUP,IF(h.mail_unit_desig = (TYPEOF(h.mail_unit_desig))'',0,100));
    maxlength_mail_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_unit_desig)));
    avelength_mail_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_unit_desig)),h.mail_unit_desig<>(typeof(h.mail_unit_desig))'');
    populated_mail_sec_range_cnt := COUNT(GROUP,h.mail_sec_range <> (TYPEOF(h.mail_sec_range))'');
    populated_mail_sec_range_pcnt := AVE(GROUP,IF(h.mail_sec_range = (TYPEOF(h.mail_sec_range))'',0,100));
    maxlength_mail_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_sec_range)));
    avelength_mail_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_sec_range)),h.mail_sec_range<>(typeof(h.mail_sec_range))'');
    populated_mail_p_city_name_cnt := COUNT(GROUP,h.mail_p_city_name <> (TYPEOF(h.mail_p_city_name))'');
    populated_mail_p_city_name_pcnt := AVE(GROUP,IF(h.mail_p_city_name = (TYPEOF(h.mail_p_city_name))'',0,100));
    maxlength_mail_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_p_city_name)));
    avelength_mail_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_p_city_name)),h.mail_p_city_name<>(typeof(h.mail_p_city_name))'');
    populated_mail_v_city_name_cnt := COUNT(GROUP,h.mail_v_city_name <> (TYPEOF(h.mail_v_city_name))'');
    populated_mail_v_city_name_pcnt := AVE(GROUP,IF(h.mail_v_city_name = (TYPEOF(h.mail_v_city_name))'',0,100));
    maxlength_mail_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_v_city_name)));
    avelength_mail_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_v_city_name)),h.mail_v_city_name<>(typeof(h.mail_v_city_name))'');
    populated_mail_st_cnt := COUNT(GROUP,h.mail_st <> (TYPEOF(h.mail_st))'');
    populated_mail_st_pcnt := AVE(GROUP,IF(h.mail_st = (TYPEOF(h.mail_st))'',0,100));
    maxlength_mail_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_st)));
    avelength_mail_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_st)),h.mail_st<>(typeof(h.mail_st))'');
    populated_mail_ace_zip_cnt := COUNT(GROUP,h.mail_ace_zip <> (TYPEOF(h.mail_ace_zip))'');
    populated_mail_ace_zip_pcnt := AVE(GROUP,IF(h.mail_ace_zip = (TYPEOF(h.mail_ace_zip))'',0,100));
    maxlength_mail_ace_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_ace_zip)));
    avelength_mail_ace_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_ace_zip)),h.mail_ace_zip<>(typeof(h.mail_ace_zip))'');
    populated_mail_zip4_cnt := COUNT(GROUP,h.mail_zip4 <> (TYPEOF(h.mail_zip4))'');
    populated_mail_zip4_pcnt := AVE(GROUP,IF(h.mail_zip4 = (TYPEOF(h.mail_zip4))'',0,100));
    maxlength_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_zip4)));
    avelength_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_zip4)),h.mail_zip4<>(typeof(h.mail_zip4))'');
    populated_mail_cart_cnt := COUNT(GROUP,h.mail_cart <> (TYPEOF(h.mail_cart))'');
    populated_mail_cart_pcnt := AVE(GROUP,IF(h.mail_cart = (TYPEOF(h.mail_cart))'',0,100));
    maxlength_mail_cart := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_cart)));
    avelength_mail_cart := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_cart)),h.mail_cart<>(typeof(h.mail_cart))'');
    populated_mail_cr_sort_sz_cnt := COUNT(GROUP,h.mail_cr_sort_sz <> (TYPEOF(h.mail_cr_sort_sz))'');
    populated_mail_cr_sort_sz_pcnt := AVE(GROUP,IF(h.mail_cr_sort_sz = (TYPEOF(h.mail_cr_sort_sz))'',0,100));
    maxlength_mail_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_cr_sort_sz)));
    avelength_mail_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_cr_sort_sz)),h.mail_cr_sort_sz<>(typeof(h.mail_cr_sort_sz))'');
    populated_mail_lot_cnt := COUNT(GROUP,h.mail_lot <> (TYPEOF(h.mail_lot))'');
    populated_mail_lot_pcnt := AVE(GROUP,IF(h.mail_lot = (TYPEOF(h.mail_lot))'',0,100));
    maxlength_mail_lot := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_lot)));
    avelength_mail_lot := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_lot)),h.mail_lot<>(typeof(h.mail_lot))'');
    populated_mail_lot_order_cnt := COUNT(GROUP,h.mail_lot_order <> (TYPEOF(h.mail_lot_order))'');
    populated_mail_lot_order_pcnt := AVE(GROUP,IF(h.mail_lot_order = (TYPEOF(h.mail_lot_order))'',0,100));
    maxlength_mail_lot_order := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_lot_order)));
    avelength_mail_lot_order := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_lot_order)),h.mail_lot_order<>(typeof(h.mail_lot_order))'');
    populated_mail_dpbc_cnt := COUNT(GROUP,h.mail_dpbc <> (TYPEOF(h.mail_dpbc))'');
    populated_mail_dpbc_pcnt := AVE(GROUP,IF(h.mail_dpbc = (TYPEOF(h.mail_dpbc))'',0,100));
    maxlength_mail_dpbc := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_dpbc)));
    avelength_mail_dpbc := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_dpbc)),h.mail_dpbc<>(typeof(h.mail_dpbc))'');
    populated_mail_chk_digit_cnt := COUNT(GROUP,h.mail_chk_digit <> (TYPEOF(h.mail_chk_digit))'');
    populated_mail_chk_digit_pcnt := AVE(GROUP,IF(h.mail_chk_digit = (TYPEOF(h.mail_chk_digit))'',0,100));
    maxlength_mail_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_chk_digit)));
    avelength_mail_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_chk_digit)),h.mail_chk_digit<>(typeof(h.mail_chk_digit))'');
    populated_mail_rec_type_cnt := COUNT(GROUP,h.mail_rec_type <> (TYPEOF(h.mail_rec_type))'');
    populated_mail_rec_type_pcnt := AVE(GROUP,IF(h.mail_rec_type = (TYPEOF(h.mail_rec_type))'',0,100));
    maxlength_mail_rec_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_rec_type)));
    avelength_mail_rec_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_rec_type)),h.mail_rec_type<>(typeof(h.mail_rec_type))'');
    populated_mail_ace_fips_st_cnt := COUNT(GROUP,h.mail_ace_fips_st <> (TYPEOF(h.mail_ace_fips_st))'');
    populated_mail_ace_fips_st_pcnt := AVE(GROUP,IF(h.mail_ace_fips_st = (TYPEOF(h.mail_ace_fips_st))'',0,100));
    maxlength_mail_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_ace_fips_st)));
    avelength_mail_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_ace_fips_st)),h.mail_ace_fips_st<>(typeof(h.mail_ace_fips_st))'');
    populated_mail_fips_county_cnt := COUNT(GROUP,h.mail_fips_county <> (TYPEOF(h.mail_fips_county))'');
    populated_mail_fips_county_pcnt := AVE(GROUP,IF(h.mail_fips_county = (TYPEOF(h.mail_fips_county))'',0,100));
    maxlength_mail_fips_county := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_fips_county)));
    avelength_mail_fips_county := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_fips_county)),h.mail_fips_county<>(typeof(h.mail_fips_county))'');
    populated_mail_geo_lat_cnt := COUNT(GROUP,h.mail_geo_lat <> (TYPEOF(h.mail_geo_lat))'');
    populated_mail_geo_lat_pcnt := AVE(GROUP,IF(h.mail_geo_lat = (TYPEOF(h.mail_geo_lat))'',0,100));
    maxlength_mail_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_lat)));
    avelength_mail_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_lat)),h.mail_geo_lat<>(typeof(h.mail_geo_lat))'');
    populated_mail_geo_long_cnt := COUNT(GROUP,h.mail_geo_long <> (TYPEOF(h.mail_geo_long))'');
    populated_mail_geo_long_pcnt := AVE(GROUP,IF(h.mail_geo_long = (TYPEOF(h.mail_geo_long))'',0,100));
    maxlength_mail_geo_long := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_long)));
    avelength_mail_geo_long := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_long)),h.mail_geo_long<>(typeof(h.mail_geo_long))'');
    populated_mail_msa_cnt := COUNT(GROUP,h.mail_msa <> (TYPEOF(h.mail_msa))'');
    populated_mail_msa_pcnt := AVE(GROUP,IF(h.mail_msa = (TYPEOF(h.mail_msa))'',0,100));
    maxlength_mail_msa := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_msa)));
    avelength_mail_msa := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_msa)),h.mail_msa<>(typeof(h.mail_msa))'');
    populated_mail_geo_blk_cnt := COUNT(GROUP,h.mail_geo_blk <> (TYPEOF(h.mail_geo_blk))'');
    populated_mail_geo_blk_pcnt := AVE(GROUP,IF(h.mail_geo_blk = (TYPEOF(h.mail_geo_blk))'',0,100));
    maxlength_mail_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_blk)));
    avelength_mail_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_blk)),h.mail_geo_blk<>(typeof(h.mail_geo_blk))'');
    populated_mail_geo_match_cnt := COUNT(GROUP,h.mail_geo_match <> (TYPEOF(h.mail_geo_match))'');
    populated_mail_geo_match_pcnt := AVE(GROUP,IF(h.mail_geo_match = (TYPEOF(h.mail_geo_match))'',0,100));
    maxlength_mail_geo_match := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_match)));
    avelength_mail_geo_match := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_geo_match)),h.mail_geo_match<>(typeof(h.mail_geo_match))'');
    populated_mail_err_stat_cnt := COUNT(GROUP,h.mail_err_stat <> (TYPEOF(h.mail_err_stat))'');
    populated_mail_err_stat_pcnt := AVE(GROUP,IF(h.mail_err_stat = (TYPEOF(h.mail_err_stat))'',0,100));
    maxlength_mail_err_stat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_err_stat)));
    avelength_mail_err_stat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mail_err_stat)),h.mail_err_stat<>(typeof(h.mail_err_stat))'');
    populated_idtypes_cnt := COUNT(GROUP,h.idtypes <> (TYPEOF(h.idtypes))'');
    populated_idtypes_pcnt := AVE(GROUP,IF(h.idtypes = (TYPEOF(h.idtypes))'',0,100));
    maxlength_idtypes := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.idtypes)));
    avelength_idtypes := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.idtypes)),h.idtypes<>(typeof(h.idtypes))'');
    populated_precinct_cnt := COUNT(GROUP,h.precinct <> (TYPEOF(h.precinct))'');
    populated_precinct_pcnt := AVE(GROUP,IF(h.precinct = (TYPEOF(h.precinct))'',0,100));
    maxlength_precinct := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct)));
    avelength_precinct := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinct)),h.precinct<>(typeof(h.precinct))'');
    populated_ward1_cnt := COUNT(GROUP,h.ward1 <> (TYPEOF(h.ward1))'');
    populated_ward1_pcnt := AVE(GROUP,IF(h.ward1 = (TYPEOF(h.ward1))'',0,100));
    maxlength_ward1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward1)));
    avelength_ward1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward1)),h.ward1<>(typeof(h.ward1))'');
    populated_idcode_cnt := COUNT(GROUP,h.idcode <> (TYPEOF(h.idcode))'');
    populated_idcode_pcnt := AVE(GROUP,IF(h.idcode = (TYPEOF(h.idcode))'',0,100));
    maxlength_idcode := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.idcode)));
    avelength_idcode := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.idcode)),h.idcode<>(typeof(h.idcode))'');
    populated_precinctparttextdesig_cnt := COUNT(GROUP,h.precinctparttextdesig <> (TYPEOF(h.precinctparttextdesig))'');
    populated_precinctparttextdesig_pcnt := AVE(GROUP,IF(h.precinctparttextdesig = (TYPEOF(h.precinctparttextdesig))'',0,100));
    maxlength_precinctparttextdesig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinctparttextdesig)));
    avelength_precinctparttextdesig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinctparttextdesig)),h.precinctparttextdesig<>(typeof(h.precinctparttextdesig))'');
    populated_precinctparttextname_cnt := COUNT(GROUP,h.precinctparttextname <> (TYPEOF(h.precinctparttextname))'');
    populated_precinctparttextname_pcnt := AVE(GROUP,IF(h.precinctparttextname = (TYPEOF(h.precinctparttextname))'',0,100));
    maxlength_precinctparttextname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinctparttextname)));
    avelength_precinctparttextname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precinctparttextname)),h.precinctparttextname<>(typeof(h.precinctparttextname))'');
    populated_precincttextdesig_cnt := COUNT(GROUP,h.precincttextdesig <> (TYPEOF(h.precincttextdesig))'');
    populated_precincttextdesig_pcnt := AVE(GROUP,IF(h.precincttextdesig = (TYPEOF(h.precincttextdesig))'',0,100));
    maxlength_precincttextdesig := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.precincttextdesig)));
    avelength_precincttextdesig := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.precincttextdesig)),h.precincttextdesig<>(typeof(h.precincttextdesig))'');
    populated_marriedappend_cnt := COUNT(GROUP,h.marriedappend <> (TYPEOF(h.marriedappend))'');
    populated_marriedappend_pcnt := AVE(GROUP,IF(h.marriedappend = (TYPEOF(h.marriedappend))'',0,100));
    maxlength_marriedappend := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.marriedappend)));
    avelength_marriedappend := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.marriedappend)),h.marriedappend<>(typeof(h.marriedappend))'');
    populated_supervisordistrict_cnt := COUNT(GROUP,h.supervisordistrict <> (TYPEOF(h.supervisordistrict))'');
    populated_supervisordistrict_pcnt := AVE(GROUP,IF(h.supervisordistrict = (TYPEOF(h.supervisordistrict))'',0,100));
    maxlength_supervisordistrict := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.supervisordistrict)));
    avelength_supervisordistrict := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.supervisordistrict)),h.supervisordistrict<>(typeof(h.supervisordistrict))'');
    populated_district_cnt := COUNT(GROUP,h.district <> (TYPEOF(h.district))'');
    populated_district_pcnt := AVE(GROUP,IF(h.district = (TYPEOF(h.district))'',0,100));
    maxlength_district := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.district)));
    avelength_district := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.district)),h.district<>(typeof(h.district))'');
    populated_ward2_cnt := COUNT(GROUP,h.ward2 <> (TYPEOF(h.ward2))'');
    populated_ward2_pcnt := AVE(GROUP,IF(h.ward2 = (TYPEOF(h.ward2))'',0,100));
    maxlength_ward2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward2)));
    avelength_ward2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward2)),h.ward2<>(typeof(h.ward2))'');
    populated_citycountycouncil_cnt := COUNT(GROUP,h.citycountycouncil <> (TYPEOF(h.citycountycouncil))'');
    populated_citycountycouncil_pcnt := AVE(GROUP,IF(h.citycountycouncil = (TYPEOF(h.citycountycouncil))'',0,100));
    maxlength_citycountycouncil := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.citycountycouncil)));
    avelength_citycountycouncil := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.citycountycouncil)),h.citycountycouncil<>(typeof(h.citycountycouncil))'');
    populated_countyprecinct_cnt := COUNT(GROUP,h.countyprecinct <> (TYPEOF(h.countyprecinct))'');
    populated_countyprecinct_pcnt := AVE(GROUP,IF(h.countyprecinct = (TYPEOF(h.countyprecinct))'',0,100));
    maxlength_countyprecinct := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.countyprecinct)));
    avelength_countyprecinct := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.countyprecinct)),h.countyprecinct<>(typeof(h.countyprecinct))'');
    populated_countycommis_cnt := COUNT(GROUP,h.countycommis <> (TYPEOF(h.countycommis))'');
    populated_countycommis_pcnt := AVE(GROUP,IF(h.countycommis = (TYPEOF(h.countycommis))'',0,100));
    maxlength_countycommis := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.countycommis)));
    avelength_countycommis := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.countycommis)),h.countycommis<>(typeof(h.countycommis))'');
    populated_schoolboard_cnt := COUNT(GROUP,h.schoolboard <> (TYPEOF(h.schoolboard))'');
    populated_schoolboard_pcnt := AVE(GROUP,IF(h.schoolboard = (TYPEOF(h.schoolboard))'',0,100));
    maxlength_schoolboard := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolboard)));
    avelength_schoolboard := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.schoolboard)),h.schoolboard<>(typeof(h.schoolboard))'');
    populated_ward3_cnt := COUNT(GROUP,h.ward3 <> (TYPEOF(h.ward3))'');
    populated_ward3_pcnt := AVE(GROUP,IF(h.ward3 = (TYPEOF(h.ward3))'',0,100));
    maxlength_ward3 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward3)));
    avelength_ward3 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ward3)),h.ward3<>(typeof(h.ward3))'');
    populated_towncitycouncil1_cnt := COUNT(GROUP,h.towncitycouncil1 <> (TYPEOF(h.towncitycouncil1))'');
    populated_towncitycouncil1_pcnt := AVE(GROUP,IF(h.towncitycouncil1 = (TYPEOF(h.towncitycouncil1))'',0,100));
    maxlength_towncitycouncil1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.towncitycouncil1)));
    avelength_towncitycouncil1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.towncitycouncil1)),h.towncitycouncil1<>(typeof(h.towncitycouncil1))'');
    populated_towncitycouncil2_cnt := COUNT(GROUP,h.towncitycouncil2 <> (TYPEOF(h.towncitycouncil2))'');
    populated_towncitycouncil2_pcnt := AVE(GROUP,IF(h.towncitycouncil2 = (TYPEOF(h.towncitycouncil2))'',0,100));
    maxlength_towncitycouncil2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.towncitycouncil2)));
    avelength_towncitycouncil2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.towncitycouncil2)),h.towncitycouncil2<>(typeof(h.towncitycouncil2))'');
    populated_regents_cnt := COUNT(GROUP,h.regents <> (TYPEOF(h.regents))'');
    populated_regents_pcnt := AVE(GROUP,IF(h.regents = (TYPEOF(h.regents))'',0,100));
    maxlength_regents := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.regents)));
    avelength_regents := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.regents)),h.regents<>(typeof(h.regents))'');
    populated_watershed_cnt := COUNT(GROUP,h.watershed <> (TYPEOF(h.watershed))'');
    populated_watershed_pcnt := AVE(GROUP,IF(h.watershed = (TYPEOF(h.watershed))'',0,100));
    maxlength_watershed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.watershed)));
    avelength_watershed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.watershed)),h.watershed<>(typeof(h.watershed))'');
    populated_education_cnt := COUNT(GROUP,h.education <> (TYPEOF(h.education))'');
    populated_education_pcnt := AVE(GROUP,IF(h.education = (TYPEOF(h.education))'',0,100));
    maxlength_education := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.education)));
    avelength_education := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.education)),h.education<>(typeof(h.education))'');
    populated_policeconstable_cnt := COUNT(GROUP,h.policeconstable <> (TYPEOF(h.policeconstable))'');
    populated_policeconstable_pcnt := AVE(GROUP,IF(h.policeconstable = (TYPEOF(h.policeconstable))'',0,100));
    maxlength_policeconstable := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.policeconstable)));
    avelength_policeconstable := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.policeconstable)),h.policeconstable<>(typeof(h.policeconstable))'');
    populated_freeholder_cnt := COUNT(GROUP,h.freeholder <> (TYPEOF(h.freeholder))'');
    populated_freeholder_pcnt := AVE(GROUP,IF(h.freeholder = (TYPEOF(h.freeholder))'',0,100));
    maxlength_freeholder := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.freeholder)));
    avelength_freeholder := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.freeholder)),h.freeholder<>(typeof(h.freeholder))'');
    populated_municourt_cnt := COUNT(GROUP,h.municourt <> (TYPEOF(h.municourt))'');
    populated_municourt_pcnt := AVE(GROUP,IF(h.municourt = (TYPEOF(h.municourt))'',0,100));
    maxlength_municourt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.municourt)));
    avelength_municourt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.municourt)),h.municourt<>(typeof(h.municourt))'');
    populated_changedate_cnt := COUNT(GROUP,h.changedate <> (TYPEOF(h.changedate))'');
    populated_changedate_pcnt := AVE(GROUP,IF(h.changedate = (TYPEOF(h.changedate))'',0,100));
    maxlength_changedate := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.changedate)));
    avelength_changedate := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.changedate)),h.changedate<>(typeof(h.changedate))'');
    populated_name_type_cnt := COUNT(GROUP,h.name_type <> (TYPEOF(h.name_type))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_addr_type_cnt := COUNT(GROUP,h.addr_type <> (TYPEOF(h.addr_type))'');
    populated_addr_type_pcnt := AVE(GROUP,IF(h.addr_type = (TYPEOF(h.addr_type))'',0,100));
    maxlength_addr_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_type)));
    avelength_addr_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_type)),h.addr_type<>(typeof(h.addr_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_rid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_vtid_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_file_id_pcnt *   0.00 / 100 + T.Populated_vendor_id_pcnt *   0.00 / 100 + T.Populated_source_state_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_file_acquired_date_pcnt *   0.00 / 100 + T.Populated_use_code_pcnt *   0.00 / 100 + T.Populated_prefix_title_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_maiden_prior_pcnt *   0.00 / 100 + T.Populated_clean_maiden_pri_pcnt *   0.00 / 100 + T.Populated_name_suffix_in_pcnt *   0.00 / 100 + T.Populated_voterfiller_pcnt *   0.00 / 100 + T.Populated_source_voterid_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_agecat_pcnt *   0.00 / 100 + T.Populated_agecat_exp_pcnt *   0.00 / 100 + T.Populated_headhousehold_pcnt *   0.00 / 100 + T.Populated_place_of_birth_pcnt *   0.00 / 100 + T.Populated_occupation_pcnt *   0.00 / 100 + T.Populated_maiden_name_pcnt *   0.00 / 100 + T.Populated_motorvoterid_pcnt *   0.00 / 100 + T.Populated_regsource_pcnt *   0.00 / 100 + T.Populated_regdate_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_race_exp_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_political_party_pcnt *   0.00 / 100 + T.Populated_politicalparty_exp_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100 + T.Populated_other_phone_pcnt *   0.00 / 100 + T.Populated_active_status_pcnt *   0.00 / 100 + T.Populated_active_status_exp_pcnt *   0.00 / 100 + T.Populated_gendersurnamguess_pcnt *   0.00 / 100 + T.Populated_active_other_pcnt *   0.00 / 100 + T.Populated_voter_status_pcnt *   0.00 / 100 + T.Populated_voter_status_exp_pcnt *   0.00 / 100 + T.Populated_res_addr1_pcnt *   0.00 / 100 + T.Populated_res_addr2_pcnt *   0.00 / 100 + T.Populated_res_city_pcnt *   0.00 / 100 + T.Populated_res_state_pcnt *   0.00 / 100 + T.Populated_res_zip_pcnt *   0.00 / 100 + T.Populated_res_county_pcnt *   0.00 / 100 + T.Populated_mail_addr1_pcnt *   0.00 / 100 + T.Populated_mail_addr2_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_mail_county_pcnt *   0.00 / 100 + T.Populated_addr_filler1_pcnt *   0.00 / 100 + T.Populated_addr_filler2_pcnt *   0.00 / 100 + T.Populated_city_filler_pcnt *   0.00 / 100 + T.Populated_state_filler_pcnt *   0.00 / 100 + T.Populated_zip_filler_pcnt *   0.00 / 100 + T.Populated_timezonetbl_pcnt *   0.00 / 100 + T.Populated_towncode_pcnt *   0.00 / 100 + T.Populated_distcode_pcnt *   0.00 / 100 + T.Populated_countycode_pcnt *   0.00 / 100 + T.Populated_schoolcode_pcnt *   0.00 / 100 + T.Populated_cityinout_pcnt *   0.00 / 100 + T.Populated_spec_dist1_pcnt *   0.00 / 100 + T.Populated_spec_dist2_pcnt *   0.00 / 100 + T.Populated_precinct1_pcnt *   0.00 / 100 + T.Populated_precinct2_pcnt *   0.00 / 100 + T.Populated_precinct3_pcnt *   0.00 / 100 + T.Populated_villageprecinct_pcnt *   0.00 / 100 + T.Populated_schoolprecinct_pcnt *   0.00 / 100 + T.Populated_ward_pcnt *   0.00 / 100 + T.Populated_precinct_citytown_pcnt *   0.00 / 100 + T.Populated_ancsmdindc_pcnt *   0.00 / 100 + T.Populated_citycouncildist_pcnt *   0.00 / 100 + T.Populated_countycommdist_pcnt *   0.00 / 100 + T.Populated_statehouse_pcnt *   0.00 / 100 + T.Populated_statesenate_pcnt *   0.00 / 100 + T.Populated_ushouse_pcnt *   0.00 / 100 + T.Populated_elemschooldist_pcnt *   0.00 / 100 + T.Populated_schooldist_pcnt *   0.00 / 100 + T.Populated_schoolfiller_pcnt *   0.00 / 100 + T.Populated_commcolldist_pcnt *   0.00 / 100 + T.Populated_dist_filler_pcnt *   0.00 / 100 + T.Populated_municipal_pcnt *   0.00 / 100 + T.Populated_villagedist_pcnt *   0.00 / 100 + T.Populated_policejury_pcnt *   0.00 / 100 + T.Populated_policedist_pcnt *   0.00 / 100 + T.Populated_publicservcomm_pcnt *   0.00 / 100 + T.Populated_rescue_pcnt *   0.00 / 100 + T.Populated_fire_pcnt *   0.00 / 100 + T.Populated_sanitary_pcnt *   0.00 / 100 + T.Populated_sewerdist_pcnt *   0.00 / 100 + T.Populated_waterdist_pcnt *   0.00 / 100 + T.Populated_mosquitodist_pcnt *   0.00 / 100 + T.Populated_taxdist_pcnt *   0.00 / 100 + T.Populated_supremecourt_pcnt *   0.00 / 100 + T.Populated_justiceofpeace_pcnt *   0.00 / 100 + T.Populated_judicialdist_pcnt *   0.00 / 100 + T.Populated_superiorctdist_pcnt *   0.00 / 100 + T.Populated_appealsct_pcnt *   0.00 / 100 + T.Populated_courtfiller_pcnt *   0.00 / 100 + T.Populated_cassaddrtyptbl_pcnt *   0.00 / 100 + T.Populated_cassdelivpointcd_pcnt *   0.00 / 100 + T.Populated_casscarrierrtetbl_pcnt *   0.00 / 100 + T.Populated_blkgrpenumdist_pcnt *   0.00 / 100 + T.Populated_congressionaldist_pcnt *   0.00 / 100 + T.Populated_lattitude_pcnt *   0.00 / 100 + T.Populated_countyfips_pcnt *   0.00 / 100 + T.Populated_censustract_pcnt *   0.00 / 100 + T.Populated_fipsstcountycd_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_contributorparty_pcnt *   0.00 / 100 + T.Populated_recipientparty_pcnt *   0.00 / 100 + T.Populated_dateofcontr_pcnt *   0.00 / 100 + T.Populated_dollaramt_pcnt *   0.00 / 100 + T.Populated_officecontto_pcnt *   0.00 / 100 + T.Populated_cumuldollaramt_pcnt *   0.00 / 100 + T.Populated_contfiller1_pcnt *   0.00 / 100 + T.Populated_contfiller2_pcnt *   0.00 / 100 + T.Populated_conttype_pcnt *   0.00 / 100 + T.Populated_contfiller4_pcnt *   0.00 / 100 + T.Populated_lastdatevote_pcnt *   0.00 / 100 + T.Populated_miscvotehist_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_mail_prim_range_pcnt *   0.00 / 100 + T.Populated_mail_predir_pcnt *   0.00 / 100 + T.Populated_mail_prim_name_pcnt *   0.00 / 100 + T.Populated_mail_addr_suffix_pcnt *   0.00 / 100 + T.Populated_mail_postdir_pcnt *   0.00 / 100 + T.Populated_mail_unit_desig_pcnt *   0.00 / 100 + T.Populated_mail_sec_range_pcnt *   0.00 / 100 + T.Populated_mail_p_city_name_pcnt *   0.00 / 100 + T.Populated_mail_v_city_name_pcnt *   0.00 / 100 + T.Populated_mail_st_pcnt *   0.00 / 100 + T.Populated_mail_ace_zip_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_mail_cart_pcnt *   0.00 / 100 + T.Populated_mail_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_mail_lot_pcnt *   0.00 / 100 + T.Populated_mail_lot_order_pcnt *   0.00 / 100 + T.Populated_mail_dpbc_pcnt *   0.00 / 100 + T.Populated_mail_chk_digit_pcnt *   0.00 / 100 + T.Populated_mail_rec_type_pcnt *   0.00 / 100 + T.Populated_mail_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_mail_fips_county_pcnt *   0.00 / 100 + T.Populated_mail_geo_lat_pcnt *   0.00 / 100 + T.Populated_mail_geo_long_pcnt *   0.00 / 100 + T.Populated_mail_msa_pcnt *   0.00 / 100 + T.Populated_mail_geo_blk_pcnt *   0.00 / 100 + T.Populated_mail_geo_match_pcnt *   0.00 / 100 + T.Populated_mail_err_stat_pcnt *   0.00 / 100 + T.Populated_idtypes_pcnt *   0.00 / 100 + T.Populated_precinct_pcnt *   0.00 / 100 + T.Populated_ward1_pcnt *   0.00 / 100 + T.Populated_idcode_pcnt *   0.00 / 100 + T.Populated_precinctparttextdesig_pcnt *   0.00 / 100 + T.Populated_precinctparttextname_pcnt *   0.00 / 100 + T.Populated_precincttextdesig_pcnt *   0.00 / 100 + T.Populated_marriedappend_pcnt *   0.00 / 100 + T.Populated_supervisordistrict_pcnt *   0.00 / 100 + T.Populated_district_pcnt *   0.00 / 100 + T.Populated_ward2_pcnt *   0.00 / 100 + T.Populated_citycountycouncil_pcnt *   0.00 / 100 + T.Populated_countyprecinct_pcnt *   0.00 / 100 + T.Populated_countycommis_pcnt *   0.00 / 100 + T.Populated_schoolboard_pcnt *   0.00 / 100 + T.Populated_ward3_pcnt *   0.00 / 100 + T.Populated_towncitycouncil1_pcnt *   0.00 / 100 + T.Populated_towncitycouncil2_pcnt *   0.00 / 100 + T.Populated_regents_pcnt *   0.00 / 100 + T.Populated_watershed_pcnt *   0.00 / 100 + T.Populated_education_pcnt *   0.00 / 100 + T.Populated_policeconstable_pcnt *   0.00 / 100 + T.Populated_freeholder_pcnt *   0.00 / 100 + T.Populated_municourt_pcnt *   0.00 / 100 + T.Populated_changedate_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_addr_type_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'rid','did','did_score','ssn','vtid','process_date','date_first_seen','date_last_seen','source','file_id','vendor_id','source_state','source_code','file_acquired_date','use_code','prefix_title','last_name','first_name','middle_name','maiden_prior','clean_maiden_pri','name_suffix_in','voterfiller','source_voterid','dob','agecat','agecat_exp','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','race_exp','gender','political_party','politicalparty_exp','phone','work_phone','other_phone','active_status','active_status_exp','gendersurnamguess','active_other','voter_status','voter_status_exp','res_addr1','res_addr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','timezonetbl','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','cassaddrtyptbl','cassdelivpointcd','casscarrierrtetbl','blkgrpenumdist','congressionaldist','lattitude','countyfips','censustract','fipsstcountycd','longitude','contributorparty','recipientparty','dateofcontr','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller4','lastdatevote','miscvotehist','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_rec_type','mail_ace_fips_st','mail_fips_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','idtypes','precinct','ward1','idcode','precinctparttextdesig','precinctparttextname','precincttextdesig','marriedappend','supervisordistrict','district','ward2','citycountycouncil','countyprecinct','countycommis','schoolboard','ward3','towncitycouncil1','towncitycouncil2','regents','watershed','education','policeconstable','freeholder','municourt','changedate','name_type','addr_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_rid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_ssn_pcnt,le.populated_vtid_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_source_pcnt,le.populated_file_id_pcnt,le.populated_vendor_id_pcnt,le.populated_source_state_pcnt,le.populated_source_code_pcnt,le.populated_file_acquired_date_pcnt,le.populated_use_code_pcnt,le.populated_prefix_title_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_maiden_prior_pcnt,le.populated_clean_maiden_pri_pcnt,le.populated_name_suffix_in_pcnt,le.populated_voterfiller_pcnt,le.populated_source_voterid_pcnt,le.populated_dob_pcnt,le.populated_agecat_pcnt,le.populated_agecat_exp_pcnt,le.populated_headhousehold_pcnt,le.populated_place_of_birth_pcnt,le.populated_occupation_pcnt,le.populated_maiden_name_pcnt,le.populated_motorvoterid_pcnt,le.populated_regsource_pcnt,le.populated_regdate_pcnt,le.populated_race_pcnt,le.populated_race_exp_pcnt,le.populated_gender_pcnt,le.populated_political_party_pcnt,le.populated_politicalparty_exp_pcnt,le.populated_phone_pcnt,le.populated_work_phone_pcnt,le.populated_other_phone_pcnt,le.populated_active_status_pcnt,le.populated_active_status_exp_pcnt,le.populated_gendersurnamguess_pcnt,le.populated_active_other_pcnt,le.populated_voter_status_pcnt,le.populated_voter_status_exp_pcnt,le.populated_res_addr1_pcnt,le.populated_res_addr2_pcnt,le.populated_res_city_pcnt,le.populated_res_state_pcnt,le.populated_res_zip_pcnt,le.populated_res_county_pcnt,le.populated_mail_addr1_pcnt,le.populated_mail_addr2_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_pcnt,le.populated_mail_county_pcnt,le.populated_addr_filler1_pcnt,le.populated_addr_filler2_pcnt,le.populated_city_filler_pcnt,le.populated_state_filler_pcnt,le.populated_zip_filler_pcnt,le.populated_timezonetbl_pcnt,le.populated_towncode_pcnt,le.populated_distcode_pcnt,le.populated_countycode_pcnt,le.populated_schoolcode_pcnt,le.populated_cityinout_pcnt,le.populated_spec_dist1_pcnt,le.populated_spec_dist2_pcnt,le.populated_precinct1_pcnt,le.populated_precinct2_pcnt,le.populated_precinct3_pcnt,le.populated_villageprecinct_pcnt,le.populated_schoolprecinct_pcnt,le.populated_ward_pcnt,le.populated_precinct_citytown_pcnt,le.populated_ancsmdindc_pcnt,le.populated_citycouncildist_pcnt,le.populated_countycommdist_pcnt,le.populated_statehouse_pcnt,le.populated_statesenate_pcnt,le.populated_ushouse_pcnt,le.populated_elemschooldist_pcnt,le.populated_schooldist_pcnt,le.populated_schoolfiller_pcnt,le.populated_commcolldist_pcnt,le.populated_dist_filler_pcnt,le.populated_municipal_pcnt,le.populated_villagedist_pcnt,le.populated_policejury_pcnt,le.populated_policedist_pcnt,le.populated_publicservcomm_pcnt,le.populated_rescue_pcnt,le.populated_fire_pcnt,le.populated_sanitary_pcnt,le.populated_sewerdist_pcnt,le.populated_waterdist_pcnt,le.populated_mosquitodist_pcnt,le.populated_taxdist_pcnt,le.populated_supremecourt_pcnt,le.populated_justiceofpeace_pcnt,le.populated_judicialdist_pcnt,le.populated_superiorctdist_pcnt,le.populated_appealsct_pcnt,le.populated_courtfiller_pcnt,le.populated_cassaddrtyptbl_pcnt,le.populated_cassdelivpointcd_pcnt,le.populated_casscarrierrtetbl_pcnt,le.populated_blkgrpenumdist_pcnt,le.populated_congressionaldist_pcnt,le.populated_lattitude_pcnt,le.populated_countyfips_pcnt,le.populated_censustract_pcnt,le.populated_fipsstcountycd_pcnt,le.populated_longitude_pcnt,le.populated_contributorparty_pcnt,le.populated_recipientparty_pcnt,le.populated_dateofcontr_pcnt,le.populated_dollaramt_pcnt,le.populated_officecontto_pcnt,le.populated_cumuldollaramt_pcnt,le.populated_contfiller1_pcnt,le.populated_contfiller2_pcnt,le.populated_conttype_pcnt,le.populated_contfiller4_pcnt,le.populated_lastdatevote_pcnt,le.populated_miscvotehist_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_mail_prim_range_pcnt,le.populated_mail_predir_pcnt,le.populated_mail_prim_name_pcnt,le.populated_mail_addr_suffix_pcnt,le.populated_mail_postdir_pcnt,le.populated_mail_unit_desig_pcnt,le.populated_mail_sec_range_pcnt,le.populated_mail_p_city_name_pcnt,le.populated_mail_v_city_name_pcnt,le.populated_mail_st_pcnt,le.populated_mail_ace_zip_pcnt,le.populated_mail_zip4_pcnt,le.populated_mail_cart_pcnt,le.populated_mail_cr_sort_sz_pcnt,le.populated_mail_lot_pcnt,le.populated_mail_lot_order_pcnt,le.populated_mail_dpbc_pcnt,le.populated_mail_chk_digit_pcnt,le.populated_mail_rec_type_pcnt,le.populated_mail_ace_fips_st_pcnt,le.populated_mail_fips_county_pcnt,le.populated_mail_geo_lat_pcnt,le.populated_mail_geo_long_pcnt,le.populated_mail_msa_pcnt,le.populated_mail_geo_blk_pcnt,le.populated_mail_geo_match_pcnt,le.populated_mail_err_stat_pcnt,le.populated_idtypes_pcnt,le.populated_precinct_pcnt,le.populated_ward1_pcnt,le.populated_idcode_pcnt,le.populated_precinctparttextdesig_pcnt,le.populated_precinctparttextname_pcnt,le.populated_precincttextdesig_pcnt,le.populated_marriedappend_pcnt,le.populated_supervisordistrict_pcnt,le.populated_district_pcnt,le.populated_ward2_pcnt,le.populated_citycountycouncil_pcnt,le.populated_countyprecinct_pcnt,le.populated_countycommis_pcnt,le.populated_schoolboard_pcnt,le.populated_ward3_pcnt,le.populated_towncitycouncil1_pcnt,le.populated_towncitycouncil2_pcnt,le.populated_regents_pcnt,le.populated_watershed_pcnt,le.populated_education_pcnt,le.populated_policeconstable_pcnt,le.populated_freeholder_pcnt,le.populated_municourt_pcnt,le.populated_changedate_pcnt,le.populated_name_type_pcnt,le.populated_addr_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_rid,le.maxlength_did,le.maxlength_did_score,le.maxlength_ssn,le.maxlength_vtid,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_source,le.maxlength_file_id,le.maxlength_vendor_id,le.maxlength_source_state,le.maxlength_source_code,le.maxlength_file_acquired_date,le.maxlength_use_code,le.maxlength_prefix_title,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_maiden_prior,le.maxlength_clean_maiden_pri,le.maxlength_name_suffix_in,le.maxlength_voterfiller,le.maxlength_source_voterid,le.maxlength_dob,le.maxlength_agecat,le.maxlength_agecat_exp,le.maxlength_headhousehold,le.maxlength_place_of_birth,le.maxlength_occupation,le.maxlength_maiden_name,le.maxlength_motorvoterid,le.maxlength_regsource,le.maxlength_regdate,le.maxlength_race,le.maxlength_race_exp,le.maxlength_gender,le.maxlength_political_party,le.maxlength_politicalparty_exp,le.maxlength_phone,le.maxlength_work_phone,le.maxlength_other_phone,le.maxlength_active_status,le.maxlength_active_status_exp,le.maxlength_gendersurnamguess,le.maxlength_active_other,le.maxlength_voter_status,le.maxlength_voter_status_exp,le.maxlength_res_addr1,le.maxlength_res_addr2,le.maxlength_res_city,le.maxlength_res_state,le.maxlength_res_zip,le.maxlength_res_county,le.maxlength_mail_addr1,le.maxlength_mail_addr2,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip,le.maxlength_mail_county,le.maxlength_addr_filler1,le.maxlength_addr_filler2,le.maxlength_city_filler,le.maxlength_state_filler,le.maxlength_zip_filler,le.maxlength_timezonetbl,le.maxlength_towncode,le.maxlength_distcode,le.maxlength_countycode,le.maxlength_schoolcode,le.maxlength_cityinout,le.maxlength_spec_dist1,le.maxlength_spec_dist2,le.maxlength_precinct1,le.maxlength_precinct2,le.maxlength_precinct3,le.maxlength_villageprecinct,le.maxlength_schoolprecinct,le.maxlength_ward,le.maxlength_precinct_citytown,le.maxlength_ancsmdindc,le.maxlength_citycouncildist,le.maxlength_countycommdist,le.maxlength_statehouse,le.maxlength_statesenate,le.maxlength_ushouse,le.maxlength_elemschooldist,le.maxlength_schooldist,le.maxlength_schoolfiller,le.maxlength_commcolldist,le.maxlength_dist_filler,le.maxlength_municipal,le.maxlength_villagedist,le.maxlength_policejury,le.maxlength_policedist,le.maxlength_publicservcomm,le.maxlength_rescue,le.maxlength_fire,le.maxlength_sanitary,le.maxlength_sewerdist,le.maxlength_waterdist,le.maxlength_mosquitodist,le.maxlength_taxdist,le.maxlength_supremecourt,le.maxlength_justiceofpeace,le.maxlength_judicialdist,le.maxlength_superiorctdist,le.maxlength_appealsct,le.maxlength_courtfiller,le.maxlength_cassaddrtyptbl,le.maxlength_cassdelivpointcd,le.maxlength_casscarrierrtetbl,le.maxlength_blkgrpenumdist,le.maxlength_congressionaldist,le.maxlength_lattitude,le.maxlength_countyfips,le.maxlength_censustract,le.maxlength_fipsstcountycd,le.maxlength_longitude,le.maxlength_contributorparty,le.maxlength_recipientparty,le.maxlength_dateofcontr,le.maxlength_dollaramt,le.maxlength_officecontto,le.maxlength_cumuldollaramt,le.maxlength_contfiller1,le.maxlength_contfiller2,le.maxlength_conttype,le.maxlength_contfiller4,le.maxlength_lastdatevote,le.maxlength_miscvotehist,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_mail_prim_range,le.maxlength_mail_predir,le.maxlength_mail_prim_name,le.maxlength_mail_addr_suffix,le.maxlength_mail_postdir,le.maxlength_mail_unit_desig,le.maxlength_mail_sec_range,le.maxlength_mail_p_city_name,le.maxlength_mail_v_city_name,le.maxlength_mail_st,le.maxlength_mail_ace_zip,le.maxlength_mail_zip4,le.maxlength_mail_cart,le.maxlength_mail_cr_sort_sz,le.maxlength_mail_lot,le.maxlength_mail_lot_order,le.maxlength_mail_dpbc,le.maxlength_mail_chk_digit,le.maxlength_mail_rec_type,le.maxlength_mail_ace_fips_st,le.maxlength_mail_fips_county,le.maxlength_mail_geo_lat,le.maxlength_mail_geo_long,le.maxlength_mail_msa,le.maxlength_mail_geo_blk,le.maxlength_mail_geo_match,le.maxlength_mail_err_stat,le.maxlength_idtypes,le.maxlength_precinct,le.maxlength_ward1,le.maxlength_idcode,le.maxlength_precinctparttextdesig,le.maxlength_precinctparttextname,le.maxlength_precincttextdesig,le.maxlength_marriedappend,le.maxlength_supervisordistrict,le.maxlength_district,le.maxlength_ward2,le.maxlength_citycountycouncil,le.maxlength_countyprecinct,le.maxlength_countycommis,le.maxlength_schoolboard,le.maxlength_ward3,le.maxlength_towncitycouncil1,le.maxlength_towncitycouncil2,le.maxlength_regents,le.maxlength_watershed,le.maxlength_education,le.maxlength_policeconstable,le.maxlength_freeholder,le.maxlength_municourt,le.maxlength_changedate,le.maxlength_name_type,le.maxlength_addr_type);
  SELF.avelength := CHOOSE(C,le.avelength_rid,le.avelength_did,le.avelength_did_score,le.avelength_ssn,le.avelength_vtid,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_source,le.avelength_file_id,le.avelength_vendor_id,le.avelength_source_state,le.avelength_source_code,le.avelength_file_acquired_date,le.avelength_use_code,le.avelength_prefix_title,le.avelength_last_name,le.avelength_first_name,le.avelength_middle_name,le.avelength_maiden_prior,le.avelength_clean_maiden_pri,le.avelength_name_suffix_in,le.avelength_voterfiller,le.avelength_source_voterid,le.avelength_dob,le.avelength_agecat,le.avelength_agecat_exp,le.avelength_headhousehold,le.avelength_place_of_birth,le.avelength_occupation,le.avelength_maiden_name,le.avelength_motorvoterid,le.avelength_regsource,le.avelength_regdate,le.avelength_race,le.avelength_race_exp,le.avelength_gender,le.avelength_political_party,le.avelength_politicalparty_exp,le.avelength_phone,le.avelength_work_phone,le.avelength_other_phone,le.avelength_active_status,le.avelength_active_status_exp,le.avelength_gendersurnamguess,le.avelength_active_other,le.avelength_voter_status,le.avelength_voter_status_exp,le.avelength_res_addr1,le.avelength_res_addr2,le.avelength_res_city,le.avelength_res_state,le.avelength_res_zip,le.avelength_res_county,le.avelength_mail_addr1,le.avelength_mail_addr2,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip,le.avelength_mail_county,le.avelength_addr_filler1,le.avelength_addr_filler2,le.avelength_city_filler,le.avelength_state_filler,le.avelength_zip_filler,le.avelength_timezonetbl,le.avelength_towncode,le.avelength_distcode,le.avelength_countycode,le.avelength_schoolcode,le.avelength_cityinout,le.avelength_spec_dist1,le.avelength_spec_dist2,le.avelength_precinct1,le.avelength_precinct2,le.avelength_precinct3,le.avelength_villageprecinct,le.avelength_schoolprecinct,le.avelength_ward,le.avelength_precinct_citytown,le.avelength_ancsmdindc,le.avelength_citycouncildist,le.avelength_countycommdist,le.avelength_statehouse,le.avelength_statesenate,le.avelength_ushouse,le.avelength_elemschooldist,le.avelength_schooldist,le.avelength_schoolfiller,le.avelength_commcolldist,le.avelength_dist_filler,le.avelength_municipal,le.avelength_villagedist,le.avelength_policejury,le.avelength_policedist,le.avelength_publicservcomm,le.avelength_rescue,le.avelength_fire,le.avelength_sanitary,le.avelength_sewerdist,le.avelength_waterdist,le.avelength_mosquitodist,le.avelength_taxdist,le.avelength_supremecourt,le.avelength_justiceofpeace,le.avelength_judicialdist,le.avelength_superiorctdist,le.avelength_appealsct,le.avelength_courtfiller,le.avelength_cassaddrtyptbl,le.avelength_cassdelivpointcd,le.avelength_casscarrierrtetbl,le.avelength_blkgrpenumdist,le.avelength_congressionaldist,le.avelength_lattitude,le.avelength_countyfips,le.avelength_censustract,le.avelength_fipsstcountycd,le.avelength_longitude,le.avelength_contributorparty,le.avelength_recipientparty,le.avelength_dateofcontr,le.avelength_dollaramt,le.avelength_officecontto,le.avelength_cumuldollaramt,le.avelength_contfiller1,le.avelength_contfiller2,le.avelength_conttype,le.avelength_contfiller4,le.avelength_lastdatevote,le.avelength_miscvotehist,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_mail_prim_range,le.avelength_mail_predir,le.avelength_mail_prim_name,le.avelength_mail_addr_suffix,le.avelength_mail_postdir,le.avelength_mail_unit_desig,le.avelength_mail_sec_range,le.avelength_mail_p_city_name,le.avelength_mail_v_city_name,le.avelength_mail_st,le.avelength_mail_ace_zip,le.avelength_mail_zip4,le.avelength_mail_cart,le.avelength_mail_cr_sort_sz,le.avelength_mail_lot,le.avelength_mail_lot_order,le.avelength_mail_dpbc,le.avelength_mail_chk_digit,le.avelength_mail_rec_type,le.avelength_mail_ace_fips_st,le.avelength_mail_fips_county,le.avelength_mail_geo_lat,le.avelength_mail_geo_long,le.avelength_mail_msa,le.avelength_mail_geo_blk,le.avelength_mail_geo_match,le.avelength_mail_err_stat,le.avelength_idtypes,le.avelength_precinct,le.avelength_ward1,le.avelength_idcode,le.avelength_precinctparttextdesig,le.avelength_precinctparttextname,le.avelength_precincttextdesig,le.avelength_marriedappend,le.avelength_supervisordistrict,le.avelength_district,le.avelength_ward2,le.avelength_citycountycouncil,le.avelength_countyprecinct,le.avelength_countycommis,le.avelength_schoolboard,le.avelength_ward3,le.avelength_towncitycouncil1,le.avelength_towncitycouncil2,le.avelength_regents,le.avelength_watershed,le.avelength_education,le.avelength_policeconstable,le.avelength_freeholder,le.avelength_municourt,le.avelength_changedate,le.avelength_name_type,le.avelength_addr_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 218, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.rid <> 0,TRIM((SALT39.StrType)le.rid), ''),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT39.StrType)le.did_score), ''),TRIM((SALT39.StrType)le.ssn),IF (le.vtid <> 0,TRIM((SALT39.StrType)le.vtid), ''),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.date_first_seen),TRIM((SALT39.StrType)le.date_last_seen),TRIM((SALT39.StrType)le.source),TRIM((SALT39.StrType)le.file_id),TRIM((SALT39.StrType)le.vendor_id),TRIM((SALT39.StrType)le.source_state),TRIM((SALT39.StrType)le.source_code),TRIM((SALT39.StrType)le.file_acquired_date),TRIM((SALT39.StrType)le.use_code),TRIM((SALT39.StrType)le.prefix_title),TRIM((SALT39.StrType)le.last_name),TRIM((SALT39.StrType)le.first_name),TRIM((SALT39.StrType)le.middle_name),TRIM((SALT39.StrType)le.maiden_prior),TRIM((SALT39.StrType)le.clean_maiden_pri),TRIM((SALT39.StrType)le.name_suffix_in),TRIM((SALT39.StrType)le.voterfiller),TRIM((SALT39.StrType)le.source_voterid),TRIM((SALT39.StrType)le.dob),TRIM((SALT39.StrType)le.agecat),TRIM((SALT39.StrType)le.agecat_exp),TRIM((SALT39.StrType)le.headhousehold),TRIM((SALT39.StrType)le.place_of_birth),TRIM((SALT39.StrType)le.occupation),TRIM((SALT39.StrType)le.maiden_name),TRIM((SALT39.StrType)le.motorvoterid),TRIM((SALT39.StrType)le.regsource),TRIM((SALT39.StrType)le.regdate),TRIM((SALT39.StrType)le.race),TRIM((SALT39.StrType)le.race_exp),TRIM((SALT39.StrType)le.gender),TRIM((SALT39.StrType)le.political_party),TRIM((SALT39.StrType)le.politicalparty_exp),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.work_phone),TRIM((SALT39.StrType)le.other_phone),TRIM((SALT39.StrType)le.active_status),TRIM((SALT39.StrType)le.active_status_exp),TRIM((SALT39.StrType)le.gendersurnamguess),TRIM((SALT39.StrType)le.active_other),TRIM((SALT39.StrType)le.voter_status),TRIM((SALT39.StrType)le.voter_status_exp),TRIM((SALT39.StrType)le.res_addr1),TRIM((SALT39.StrType)le.res_addr2),TRIM((SALT39.StrType)le.res_city),TRIM((SALT39.StrType)le.res_state),TRIM((SALT39.StrType)le.res_zip),TRIM((SALT39.StrType)le.res_county),TRIM((SALT39.StrType)le.mail_addr1),TRIM((SALT39.StrType)le.mail_addr2),TRIM((SALT39.StrType)le.mail_city),TRIM((SALT39.StrType)le.mail_state),TRIM((SALT39.StrType)le.mail_zip),TRIM((SALT39.StrType)le.mail_county),TRIM((SALT39.StrType)le.addr_filler1),TRIM((SALT39.StrType)le.addr_filler2),TRIM((SALT39.StrType)le.city_filler),TRIM((SALT39.StrType)le.state_filler),TRIM((SALT39.StrType)le.zip_filler),TRIM((SALT39.StrType)le.timezonetbl),TRIM((SALT39.StrType)le.towncode),TRIM((SALT39.StrType)le.distcode),TRIM((SALT39.StrType)le.countycode),TRIM((SALT39.StrType)le.schoolcode),TRIM((SALT39.StrType)le.cityinout),TRIM((SALT39.StrType)le.spec_dist1),TRIM((SALT39.StrType)le.spec_dist2),TRIM((SALT39.StrType)le.precinct1),TRIM((SALT39.StrType)le.precinct2),TRIM((SALT39.StrType)le.precinct3),TRIM((SALT39.StrType)le.villageprecinct),TRIM((SALT39.StrType)le.schoolprecinct),TRIM((SALT39.StrType)le.ward),TRIM((SALT39.StrType)le.precinct_citytown),TRIM((SALT39.StrType)le.ancsmdindc),TRIM((SALT39.StrType)le.citycouncildist),TRIM((SALT39.StrType)le.countycommdist),TRIM((SALT39.StrType)le.statehouse),TRIM((SALT39.StrType)le.statesenate),TRIM((SALT39.StrType)le.ushouse),TRIM((SALT39.StrType)le.elemschooldist),TRIM((SALT39.StrType)le.schooldist),TRIM((SALT39.StrType)le.schoolfiller),TRIM((SALT39.StrType)le.commcolldist),TRIM((SALT39.StrType)le.dist_filler),TRIM((SALT39.StrType)le.municipal),TRIM((SALT39.StrType)le.villagedist),TRIM((SALT39.StrType)le.policejury),TRIM((SALT39.StrType)le.policedist),TRIM((SALT39.StrType)le.publicservcomm),TRIM((SALT39.StrType)le.rescue),TRIM((SALT39.StrType)le.fire),TRIM((SALT39.StrType)le.sanitary),TRIM((SALT39.StrType)le.sewerdist),TRIM((SALT39.StrType)le.waterdist),TRIM((SALT39.StrType)le.mosquitodist),TRIM((SALT39.StrType)le.taxdist),TRIM((SALT39.StrType)le.supremecourt),TRIM((SALT39.StrType)le.justiceofpeace),TRIM((SALT39.StrType)le.judicialdist),TRIM((SALT39.StrType)le.superiorctdist),TRIM((SALT39.StrType)le.appealsct),TRIM((SALT39.StrType)le.courtfiller),TRIM((SALT39.StrType)le.cassaddrtyptbl),TRIM((SALT39.StrType)le.cassdelivpointcd),TRIM((SALT39.StrType)le.casscarrierrtetbl),TRIM((SALT39.StrType)le.blkgrpenumdist),TRIM((SALT39.StrType)le.congressionaldist),TRIM((SALT39.StrType)le.lattitude),TRIM((SALT39.StrType)le.countyfips),TRIM((SALT39.StrType)le.censustract),TRIM((SALT39.StrType)le.fipsstcountycd),TRIM((SALT39.StrType)le.longitude),TRIM((SALT39.StrType)le.contributorparty),TRIM((SALT39.StrType)le.recipientparty),TRIM((SALT39.StrType)le.dateofcontr),TRIM((SALT39.StrType)le.dollaramt),TRIM((SALT39.StrType)le.officecontto),TRIM((SALT39.StrType)le.cumuldollaramt),TRIM((SALT39.StrType)le.contfiller1),TRIM((SALT39.StrType)le.contfiller2),TRIM((SALT39.StrType)le.conttype),TRIM((SALT39.StrType)le.contfiller4),TRIM((SALT39.StrType)le.lastdatevote),TRIM((SALT39.StrType)le.miscvotehist),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.name_score),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.predir),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.addr_suffix),TRIM((SALT39.StrType)le.postdir),TRIM((SALT39.StrType)le.unit_desig),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.p_city_name),TRIM((SALT39.StrType)le.v_city_name),TRIM((SALT39.StrType)le.st),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.zip4),TRIM((SALT39.StrType)le.cart),TRIM((SALT39.StrType)le.cr_sort_sz),TRIM((SALT39.StrType)le.lot),TRIM((SALT39.StrType)le.lot_order),TRIM((SALT39.StrType)le.dpbc),TRIM((SALT39.StrType)le.chk_digit),TRIM((SALT39.StrType)le.rec_type),TRIM((SALT39.StrType)le.ace_fips_st),TRIM((SALT39.StrType)le.fips_county),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.msa),TRIM((SALT39.StrType)le.geo_blk),TRIM((SALT39.StrType)le.geo_match),TRIM((SALT39.StrType)le.err_stat),TRIM((SALT39.StrType)le.mail_prim_range),TRIM((SALT39.StrType)le.mail_predir),TRIM((SALT39.StrType)le.mail_prim_name),TRIM((SALT39.StrType)le.mail_addr_suffix),TRIM((SALT39.StrType)le.mail_postdir),TRIM((SALT39.StrType)le.mail_unit_desig),TRIM((SALT39.StrType)le.mail_sec_range),TRIM((SALT39.StrType)le.mail_p_city_name),TRIM((SALT39.StrType)le.mail_v_city_name),TRIM((SALT39.StrType)le.mail_st),TRIM((SALT39.StrType)le.mail_ace_zip),TRIM((SALT39.StrType)le.mail_zip4),TRIM((SALT39.StrType)le.mail_cart),TRIM((SALT39.StrType)le.mail_cr_sort_sz),TRIM((SALT39.StrType)le.mail_lot),TRIM((SALT39.StrType)le.mail_lot_order),TRIM((SALT39.StrType)le.mail_dpbc),TRIM((SALT39.StrType)le.mail_chk_digit),TRIM((SALT39.StrType)le.mail_rec_type),TRIM((SALT39.StrType)le.mail_ace_fips_st),TRIM((SALT39.StrType)le.mail_fips_county),TRIM((SALT39.StrType)le.mail_geo_lat),TRIM((SALT39.StrType)le.mail_geo_long),TRIM((SALT39.StrType)le.mail_msa),TRIM((SALT39.StrType)le.mail_geo_blk),TRIM((SALT39.StrType)le.mail_geo_match),TRIM((SALT39.StrType)le.mail_err_stat),TRIM((SALT39.StrType)le.idtypes),TRIM((SALT39.StrType)le.precinct),TRIM((SALT39.StrType)le.ward1),TRIM((SALT39.StrType)le.idcode),TRIM((SALT39.StrType)le.precinctparttextdesig),TRIM((SALT39.StrType)le.precinctparttextname),TRIM((SALT39.StrType)le.precincttextdesig),TRIM((SALT39.StrType)le.marriedappend),TRIM((SALT39.StrType)le.supervisordistrict),TRIM((SALT39.StrType)le.district),TRIM((SALT39.StrType)le.ward2),TRIM((SALT39.StrType)le.citycountycouncil),TRIM((SALT39.StrType)le.countyprecinct),TRIM((SALT39.StrType)le.countycommis),TRIM((SALT39.StrType)le.schoolboard),TRIM((SALT39.StrType)le.ward3),TRIM((SALT39.StrType)le.towncitycouncil1),TRIM((SALT39.StrType)le.towncitycouncil2),TRIM((SALT39.StrType)le.regents),TRIM((SALT39.StrType)le.watershed),TRIM((SALT39.StrType)le.education),TRIM((SALT39.StrType)le.policeconstable),TRIM((SALT39.StrType)le.freeholder),TRIM((SALT39.StrType)le.municourt),TRIM((SALT39.StrType)le.changedate),TRIM((SALT39.StrType)le.name_type),TRIM((SALT39.StrType)le.addr_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,218,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 218);
  SELF.FldNo2 := 1 + (C % 218);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.rid <> 0,TRIM((SALT39.StrType)le.rid), ''),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT39.StrType)le.did_score), ''),TRIM((SALT39.StrType)le.ssn),IF (le.vtid <> 0,TRIM((SALT39.StrType)le.vtid), ''),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.date_first_seen),TRIM((SALT39.StrType)le.date_last_seen),TRIM((SALT39.StrType)le.source),TRIM((SALT39.StrType)le.file_id),TRIM((SALT39.StrType)le.vendor_id),TRIM((SALT39.StrType)le.source_state),TRIM((SALT39.StrType)le.source_code),TRIM((SALT39.StrType)le.file_acquired_date),TRIM((SALT39.StrType)le.use_code),TRIM((SALT39.StrType)le.prefix_title),TRIM((SALT39.StrType)le.last_name),TRIM((SALT39.StrType)le.first_name),TRIM((SALT39.StrType)le.middle_name),TRIM((SALT39.StrType)le.maiden_prior),TRIM((SALT39.StrType)le.clean_maiden_pri),TRIM((SALT39.StrType)le.name_suffix_in),TRIM((SALT39.StrType)le.voterfiller),TRIM((SALT39.StrType)le.source_voterid),TRIM((SALT39.StrType)le.dob),TRIM((SALT39.StrType)le.agecat),TRIM((SALT39.StrType)le.agecat_exp),TRIM((SALT39.StrType)le.headhousehold),TRIM((SALT39.StrType)le.place_of_birth),TRIM((SALT39.StrType)le.occupation),TRIM((SALT39.StrType)le.maiden_name),TRIM((SALT39.StrType)le.motorvoterid),TRIM((SALT39.StrType)le.regsource),TRIM((SALT39.StrType)le.regdate),TRIM((SALT39.StrType)le.race),TRIM((SALT39.StrType)le.race_exp),TRIM((SALT39.StrType)le.gender),TRIM((SALT39.StrType)le.political_party),TRIM((SALT39.StrType)le.politicalparty_exp),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.work_phone),TRIM((SALT39.StrType)le.other_phone),TRIM((SALT39.StrType)le.active_status),TRIM((SALT39.StrType)le.active_status_exp),TRIM((SALT39.StrType)le.gendersurnamguess),TRIM((SALT39.StrType)le.active_other),TRIM((SALT39.StrType)le.voter_status),TRIM((SALT39.StrType)le.voter_status_exp),TRIM((SALT39.StrType)le.res_addr1),TRIM((SALT39.StrType)le.res_addr2),TRIM((SALT39.StrType)le.res_city),TRIM((SALT39.StrType)le.res_state),TRIM((SALT39.StrType)le.res_zip),TRIM((SALT39.StrType)le.res_county),TRIM((SALT39.StrType)le.mail_addr1),TRIM((SALT39.StrType)le.mail_addr2),TRIM((SALT39.StrType)le.mail_city),TRIM((SALT39.StrType)le.mail_state),TRIM((SALT39.StrType)le.mail_zip),TRIM((SALT39.StrType)le.mail_county),TRIM((SALT39.StrType)le.addr_filler1),TRIM((SALT39.StrType)le.addr_filler2),TRIM((SALT39.StrType)le.city_filler),TRIM((SALT39.StrType)le.state_filler),TRIM((SALT39.StrType)le.zip_filler),TRIM((SALT39.StrType)le.timezonetbl),TRIM((SALT39.StrType)le.towncode),TRIM((SALT39.StrType)le.distcode),TRIM((SALT39.StrType)le.countycode),TRIM((SALT39.StrType)le.schoolcode),TRIM((SALT39.StrType)le.cityinout),TRIM((SALT39.StrType)le.spec_dist1),TRIM((SALT39.StrType)le.spec_dist2),TRIM((SALT39.StrType)le.precinct1),TRIM((SALT39.StrType)le.precinct2),TRIM((SALT39.StrType)le.precinct3),TRIM((SALT39.StrType)le.villageprecinct),TRIM((SALT39.StrType)le.schoolprecinct),TRIM((SALT39.StrType)le.ward),TRIM((SALT39.StrType)le.precinct_citytown),TRIM((SALT39.StrType)le.ancsmdindc),TRIM((SALT39.StrType)le.citycouncildist),TRIM((SALT39.StrType)le.countycommdist),TRIM((SALT39.StrType)le.statehouse),TRIM((SALT39.StrType)le.statesenate),TRIM((SALT39.StrType)le.ushouse),TRIM((SALT39.StrType)le.elemschooldist),TRIM((SALT39.StrType)le.schooldist),TRIM((SALT39.StrType)le.schoolfiller),TRIM((SALT39.StrType)le.commcolldist),TRIM((SALT39.StrType)le.dist_filler),TRIM((SALT39.StrType)le.municipal),TRIM((SALT39.StrType)le.villagedist),TRIM((SALT39.StrType)le.policejury),TRIM((SALT39.StrType)le.policedist),TRIM((SALT39.StrType)le.publicservcomm),TRIM((SALT39.StrType)le.rescue),TRIM((SALT39.StrType)le.fire),TRIM((SALT39.StrType)le.sanitary),TRIM((SALT39.StrType)le.sewerdist),TRIM((SALT39.StrType)le.waterdist),TRIM((SALT39.StrType)le.mosquitodist),TRIM((SALT39.StrType)le.taxdist),TRIM((SALT39.StrType)le.supremecourt),TRIM((SALT39.StrType)le.justiceofpeace),TRIM((SALT39.StrType)le.judicialdist),TRIM((SALT39.StrType)le.superiorctdist),TRIM((SALT39.StrType)le.appealsct),TRIM((SALT39.StrType)le.courtfiller),TRIM((SALT39.StrType)le.cassaddrtyptbl),TRIM((SALT39.StrType)le.cassdelivpointcd),TRIM((SALT39.StrType)le.casscarrierrtetbl),TRIM((SALT39.StrType)le.blkgrpenumdist),TRIM((SALT39.StrType)le.congressionaldist),TRIM((SALT39.StrType)le.lattitude),TRIM((SALT39.StrType)le.countyfips),TRIM((SALT39.StrType)le.censustract),TRIM((SALT39.StrType)le.fipsstcountycd),TRIM((SALT39.StrType)le.longitude),TRIM((SALT39.StrType)le.contributorparty),TRIM((SALT39.StrType)le.recipientparty),TRIM((SALT39.StrType)le.dateofcontr),TRIM((SALT39.StrType)le.dollaramt),TRIM((SALT39.StrType)le.officecontto),TRIM((SALT39.StrType)le.cumuldollaramt),TRIM((SALT39.StrType)le.contfiller1),TRIM((SALT39.StrType)le.contfiller2),TRIM((SALT39.StrType)le.conttype),TRIM((SALT39.StrType)le.contfiller4),TRIM((SALT39.StrType)le.lastdatevote),TRIM((SALT39.StrType)le.miscvotehist),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.name_score),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.predir),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.addr_suffix),TRIM((SALT39.StrType)le.postdir),TRIM((SALT39.StrType)le.unit_desig),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.p_city_name),TRIM((SALT39.StrType)le.v_city_name),TRIM((SALT39.StrType)le.st),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.zip4),TRIM((SALT39.StrType)le.cart),TRIM((SALT39.StrType)le.cr_sort_sz),TRIM((SALT39.StrType)le.lot),TRIM((SALT39.StrType)le.lot_order),TRIM((SALT39.StrType)le.dpbc),TRIM((SALT39.StrType)le.chk_digit),TRIM((SALT39.StrType)le.rec_type),TRIM((SALT39.StrType)le.ace_fips_st),TRIM((SALT39.StrType)le.fips_county),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.msa),TRIM((SALT39.StrType)le.geo_blk),TRIM((SALT39.StrType)le.geo_match),TRIM((SALT39.StrType)le.err_stat),TRIM((SALT39.StrType)le.mail_prim_range),TRIM((SALT39.StrType)le.mail_predir),TRIM((SALT39.StrType)le.mail_prim_name),TRIM((SALT39.StrType)le.mail_addr_suffix),TRIM((SALT39.StrType)le.mail_postdir),TRIM((SALT39.StrType)le.mail_unit_desig),TRIM((SALT39.StrType)le.mail_sec_range),TRIM((SALT39.StrType)le.mail_p_city_name),TRIM((SALT39.StrType)le.mail_v_city_name),TRIM((SALT39.StrType)le.mail_st),TRIM((SALT39.StrType)le.mail_ace_zip),TRIM((SALT39.StrType)le.mail_zip4),TRIM((SALT39.StrType)le.mail_cart),TRIM((SALT39.StrType)le.mail_cr_sort_sz),TRIM((SALT39.StrType)le.mail_lot),TRIM((SALT39.StrType)le.mail_lot_order),TRIM((SALT39.StrType)le.mail_dpbc),TRIM((SALT39.StrType)le.mail_chk_digit),TRIM((SALT39.StrType)le.mail_rec_type),TRIM((SALT39.StrType)le.mail_ace_fips_st),TRIM((SALT39.StrType)le.mail_fips_county),TRIM((SALT39.StrType)le.mail_geo_lat),TRIM((SALT39.StrType)le.mail_geo_long),TRIM((SALT39.StrType)le.mail_msa),TRIM((SALT39.StrType)le.mail_geo_blk),TRIM((SALT39.StrType)le.mail_geo_match),TRIM((SALT39.StrType)le.mail_err_stat),TRIM((SALT39.StrType)le.idtypes),TRIM((SALT39.StrType)le.precinct),TRIM((SALT39.StrType)le.ward1),TRIM((SALT39.StrType)le.idcode),TRIM((SALT39.StrType)le.precinctparttextdesig),TRIM((SALT39.StrType)le.precinctparttextname),TRIM((SALT39.StrType)le.precincttextdesig),TRIM((SALT39.StrType)le.marriedappend),TRIM((SALT39.StrType)le.supervisordistrict),TRIM((SALT39.StrType)le.district),TRIM((SALT39.StrType)le.ward2),TRIM((SALT39.StrType)le.citycountycouncil),TRIM((SALT39.StrType)le.countyprecinct),TRIM((SALT39.StrType)le.countycommis),TRIM((SALT39.StrType)le.schoolboard),TRIM((SALT39.StrType)le.ward3),TRIM((SALT39.StrType)le.towncitycouncil1),TRIM((SALT39.StrType)le.towncitycouncil2),TRIM((SALT39.StrType)le.regents),TRIM((SALT39.StrType)le.watershed),TRIM((SALT39.StrType)le.education),TRIM((SALT39.StrType)le.policeconstable),TRIM((SALT39.StrType)le.freeholder),TRIM((SALT39.StrType)le.municourt),TRIM((SALT39.StrType)le.changedate),TRIM((SALT39.StrType)le.name_type),TRIM((SALT39.StrType)le.addr_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.rid <> 0,TRIM((SALT39.StrType)le.rid), ''),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT39.StrType)le.did_score), ''),TRIM((SALT39.StrType)le.ssn),IF (le.vtid <> 0,TRIM((SALT39.StrType)le.vtid), ''),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.date_first_seen),TRIM((SALT39.StrType)le.date_last_seen),TRIM((SALT39.StrType)le.source),TRIM((SALT39.StrType)le.file_id),TRIM((SALT39.StrType)le.vendor_id),TRIM((SALT39.StrType)le.source_state),TRIM((SALT39.StrType)le.source_code),TRIM((SALT39.StrType)le.file_acquired_date),TRIM((SALT39.StrType)le.use_code),TRIM((SALT39.StrType)le.prefix_title),TRIM((SALT39.StrType)le.last_name),TRIM((SALT39.StrType)le.first_name),TRIM((SALT39.StrType)le.middle_name),TRIM((SALT39.StrType)le.maiden_prior),TRIM((SALT39.StrType)le.clean_maiden_pri),TRIM((SALT39.StrType)le.name_suffix_in),TRIM((SALT39.StrType)le.voterfiller),TRIM((SALT39.StrType)le.source_voterid),TRIM((SALT39.StrType)le.dob),TRIM((SALT39.StrType)le.agecat),TRIM((SALT39.StrType)le.agecat_exp),TRIM((SALT39.StrType)le.headhousehold),TRIM((SALT39.StrType)le.place_of_birth),TRIM((SALT39.StrType)le.occupation),TRIM((SALT39.StrType)le.maiden_name),TRIM((SALT39.StrType)le.motorvoterid),TRIM((SALT39.StrType)le.regsource),TRIM((SALT39.StrType)le.regdate),TRIM((SALT39.StrType)le.race),TRIM((SALT39.StrType)le.race_exp),TRIM((SALT39.StrType)le.gender),TRIM((SALT39.StrType)le.political_party),TRIM((SALT39.StrType)le.politicalparty_exp),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.work_phone),TRIM((SALT39.StrType)le.other_phone),TRIM((SALT39.StrType)le.active_status),TRIM((SALT39.StrType)le.active_status_exp),TRIM((SALT39.StrType)le.gendersurnamguess),TRIM((SALT39.StrType)le.active_other),TRIM((SALT39.StrType)le.voter_status),TRIM((SALT39.StrType)le.voter_status_exp),TRIM((SALT39.StrType)le.res_addr1),TRIM((SALT39.StrType)le.res_addr2),TRIM((SALT39.StrType)le.res_city),TRIM((SALT39.StrType)le.res_state),TRIM((SALT39.StrType)le.res_zip),TRIM((SALT39.StrType)le.res_county),TRIM((SALT39.StrType)le.mail_addr1),TRIM((SALT39.StrType)le.mail_addr2),TRIM((SALT39.StrType)le.mail_city),TRIM((SALT39.StrType)le.mail_state),TRIM((SALT39.StrType)le.mail_zip),TRIM((SALT39.StrType)le.mail_county),TRIM((SALT39.StrType)le.addr_filler1),TRIM((SALT39.StrType)le.addr_filler2),TRIM((SALT39.StrType)le.city_filler),TRIM((SALT39.StrType)le.state_filler),TRIM((SALT39.StrType)le.zip_filler),TRIM((SALT39.StrType)le.timezonetbl),TRIM((SALT39.StrType)le.towncode),TRIM((SALT39.StrType)le.distcode),TRIM((SALT39.StrType)le.countycode),TRIM((SALT39.StrType)le.schoolcode),TRIM((SALT39.StrType)le.cityinout),TRIM((SALT39.StrType)le.spec_dist1),TRIM((SALT39.StrType)le.spec_dist2),TRIM((SALT39.StrType)le.precinct1),TRIM((SALT39.StrType)le.precinct2),TRIM((SALT39.StrType)le.precinct3),TRIM((SALT39.StrType)le.villageprecinct),TRIM((SALT39.StrType)le.schoolprecinct),TRIM((SALT39.StrType)le.ward),TRIM((SALT39.StrType)le.precinct_citytown),TRIM((SALT39.StrType)le.ancsmdindc),TRIM((SALT39.StrType)le.citycouncildist),TRIM((SALT39.StrType)le.countycommdist),TRIM((SALT39.StrType)le.statehouse),TRIM((SALT39.StrType)le.statesenate),TRIM((SALT39.StrType)le.ushouse),TRIM((SALT39.StrType)le.elemschooldist),TRIM((SALT39.StrType)le.schooldist),TRIM((SALT39.StrType)le.schoolfiller),TRIM((SALT39.StrType)le.commcolldist),TRIM((SALT39.StrType)le.dist_filler),TRIM((SALT39.StrType)le.municipal),TRIM((SALT39.StrType)le.villagedist),TRIM((SALT39.StrType)le.policejury),TRIM((SALT39.StrType)le.policedist),TRIM((SALT39.StrType)le.publicservcomm),TRIM((SALT39.StrType)le.rescue),TRIM((SALT39.StrType)le.fire),TRIM((SALT39.StrType)le.sanitary),TRIM((SALT39.StrType)le.sewerdist),TRIM((SALT39.StrType)le.waterdist),TRIM((SALT39.StrType)le.mosquitodist),TRIM((SALT39.StrType)le.taxdist),TRIM((SALT39.StrType)le.supremecourt),TRIM((SALT39.StrType)le.justiceofpeace),TRIM((SALT39.StrType)le.judicialdist),TRIM((SALT39.StrType)le.superiorctdist),TRIM((SALT39.StrType)le.appealsct),TRIM((SALT39.StrType)le.courtfiller),TRIM((SALT39.StrType)le.cassaddrtyptbl),TRIM((SALT39.StrType)le.cassdelivpointcd),TRIM((SALT39.StrType)le.casscarrierrtetbl),TRIM((SALT39.StrType)le.blkgrpenumdist),TRIM((SALT39.StrType)le.congressionaldist),TRIM((SALT39.StrType)le.lattitude),TRIM((SALT39.StrType)le.countyfips),TRIM((SALT39.StrType)le.censustract),TRIM((SALT39.StrType)le.fipsstcountycd),TRIM((SALT39.StrType)le.longitude),TRIM((SALT39.StrType)le.contributorparty),TRIM((SALT39.StrType)le.recipientparty),TRIM((SALT39.StrType)le.dateofcontr),TRIM((SALT39.StrType)le.dollaramt),TRIM((SALT39.StrType)le.officecontto),TRIM((SALT39.StrType)le.cumuldollaramt),TRIM((SALT39.StrType)le.contfiller1),TRIM((SALT39.StrType)le.contfiller2),TRIM((SALT39.StrType)le.conttype),TRIM((SALT39.StrType)le.contfiller4),TRIM((SALT39.StrType)le.lastdatevote),TRIM((SALT39.StrType)le.miscvotehist),TRIM((SALT39.StrType)le.title),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.name_score),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.predir),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.addr_suffix),TRIM((SALT39.StrType)le.postdir),TRIM((SALT39.StrType)le.unit_desig),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.p_city_name),TRIM((SALT39.StrType)le.v_city_name),TRIM((SALT39.StrType)le.st),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.zip4),TRIM((SALT39.StrType)le.cart),TRIM((SALT39.StrType)le.cr_sort_sz),TRIM((SALT39.StrType)le.lot),TRIM((SALT39.StrType)le.lot_order),TRIM((SALT39.StrType)le.dpbc),TRIM((SALT39.StrType)le.chk_digit),TRIM((SALT39.StrType)le.rec_type),TRIM((SALT39.StrType)le.ace_fips_st),TRIM((SALT39.StrType)le.fips_county),TRIM((SALT39.StrType)le.geo_lat),TRIM((SALT39.StrType)le.geo_long),TRIM((SALT39.StrType)le.msa),TRIM((SALT39.StrType)le.geo_blk),TRIM((SALT39.StrType)le.geo_match),TRIM((SALT39.StrType)le.err_stat),TRIM((SALT39.StrType)le.mail_prim_range),TRIM((SALT39.StrType)le.mail_predir),TRIM((SALT39.StrType)le.mail_prim_name),TRIM((SALT39.StrType)le.mail_addr_suffix),TRIM((SALT39.StrType)le.mail_postdir),TRIM((SALT39.StrType)le.mail_unit_desig),TRIM((SALT39.StrType)le.mail_sec_range),TRIM((SALT39.StrType)le.mail_p_city_name),TRIM((SALT39.StrType)le.mail_v_city_name),TRIM((SALT39.StrType)le.mail_st),TRIM((SALT39.StrType)le.mail_ace_zip),TRIM((SALT39.StrType)le.mail_zip4),TRIM((SALT39.StrType)le.mail_cart),TRIM((SALT39.StrType)le.mail_cr_sort_sz),TRIM((SALT39.StrType)le.mail_lot),TRIM((SALT39.StrType)le.mail_lot_order),TRIM((SALT39.StrType)le.mail_dpbc),TRIM((SALT39.StrType)le.mail_chk_digit),TRIM((SALT39.StrType)le.mail_rec_type),TRIM((SALT39.StrType)le.mail_ace_fips_st),TRIM((SALT39.StrType)le.mail_fips_county),TRIM((SALT39.StrType)le.mail_geo_lat),TRIM((SALT39.StrType)le.mail_geo_long),TRIM((SALT39.StrType)le.mail_msa),TRIM((SALT39.StrType)le.mail_geo_blk),TRIM((SALT39.StrType)le.mail_geo_match),TRIM((SALT39.StrType)le.mail_err_stat),TRIM((SALT39.StrType)le.idtypes),TRIM((SALT39.StrType)le.precinct),TRIM((SALT39.StrType)le.ward1),TRIM((SALT39.StrType)le.idcode),TRIM((SALT39.StrType)le.precinctparttextdesig),TRIM((SALT39.StrType)le.precinctparttextname),TRIM((SALT39.StrType)le.precincttextdesig),TRIM((SALT39.StrType)le.marriedappend),TRIM((SALT39.StrType)le.supervisordistrict),TRIM((SALT39.StrType)le.district),TRIM((SALT39.StrType)le.ward2),TRIM((SALT39.StrType)le.citycountycouncil),TRIM((SALT39.StrType)le.countyprecinct),TRIM((SALT39.StrType)le.countycommis),TRIM((SALT39.StrType)le.schoolboard),TRIM((SALT39.StrType)le.ward3),TRIM((SALT39.StrType)le.towncitycouncil1),TRIM((SALT39.StrType)le.towncitycouncil2),TRIM((SALT39.StrType)le.regents),TRIM((SALT39.StrType)le.watershed),TRIM((SALT39.StrType)le.education),TRIM((SALT39.StrType)le.policeconstable),TRIM((SALT39.StrType)le.freeholder),TRIM((SALT39.StrType)le.municourt),TRIM((SALT39.StrType)le.changedate),TRIM((SALT39.StrType)le.name_type),TRIM((SALT39.StrType)le.addr_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),218*218,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'rid'}
      ,{2,'did'}
      ,{3,'did_score'}
      ,{4,'ssn'}
      ,{5,'vtid'}
      ,{6,'process_date'}
      ,{7,'date_first_seen'}
      ,{8,'date_last_seen'}
      ,{9,'source'}
      ,{10,'file_id'}
      ,{11,'vendor_id'}
      ,{12,'source_state'}
      ,{13,'source_code'}
      ,{14,'file_acquired_date'}
      ,{15,'use_code'}
      ,{16,'prefix_title'}
      ,{17,'last_name'}
      ,{18,'first_name'}
      ,{19,'middle_name'}
      ,{20,'maiden_prior'}
      ,{21,'clean_maiden_pri'}
      ,{22,'name_suffix_in'}
      ,{23,'voterfiller'}
      ,{24,'source_voterid'}
      ,{25,'dob'}
      ,{26,'agecat'}
      ,{27,'agecat_exp'}
      ,{28,'headhousehold'}
      ,{29,'place_of_birth'}
      ,{30,'occupation'}
      ,{31,'maiden_name'}
      ,{32,'motorvoterid'}
      ,{33,'regsource'}
      ,{34,'regdate'}
      ,{35,'race'}
      ,{36,'race_exp'}
      ,{37,'gender'}
      ,{38,'political_party'}
      ,{39,'politicalparty_exp'}
      ,{40,'phone'}
      ,{41,'work_phone'}
      ,{42,'other_phone'}
      ,{43,'active_status'}
      ,{44,'active_status_exp'}
      ,{45,'gendersurnamguess'}
      ,{46,'active_other'}
      ,{47,'voter_status'}
      ,{48,'voter_status_exp'}
      ,{49,'res_addr1'}
      ,{50,'res_addr2'}
      ,{51,'res_city'}
      ,{52,'res_state'}
      ,{53,'res_zip'}
      ,{54,'res_county'}
      ,{55,'mail_addr1'}
      ,{56,'mail_addr2'}
      ,{57,'mail_city'}
      ,{58,'mail_state'}
      ,{59,'mail_zip'}
      ,{60,'mail_county'}
      ,{61,'addr_filler1'}
      ,{62,'addr_filler2'}
      ,{63,'city_filler'}
      ,{64,'state_filler'}
      ,{65,'zip_filler'}
      ,{66,'timezonetbl'}
      ,{67,'towncode'}
      ,{68,'distcode'}
      ,{69,'countycode'}
      ,{70,'schoolcode'}
      ,{71,'cityinout'}
      ,{72,'spec_dist1'}
      ,{73,'spec_dist2'}
      ,{74,'precinct1'}
      ,{75,'precinct2'}
      ,{76,'precinct3'}
      ,{77,'villageprecinct'}
      ,{78,'schoolprecinct'}
      ,{79,'ward'}
      ,{80,'precinct_citytown'}
      ,{81,'ancsmdindc'}
      ,{82,'citycouncildist'}
      ,{83,'countycommdist'}
      ,{84,'statehouse'}
      ,{85,'statesenate'}
      ,{86,'ushouse'}
      ,{87,'elemschooldist'}
      ,{88,'schooldist'}
      ,{89,'schoolfiller'}
      ,{90,'commcolldist'}
      ,{91,'dist_filler'}
      ,{92,'municipal'}
      ,{93,'villagedist'}
      ,{94,'policejury'}
      ,{95,'policedist'}
      ,{96,'publicservcomm'}
      ,{97,'rescue'}
      ,{98,'fire'}
      ,{99,'sanitary'}
      ,{100,'sewerdist'}
      ,{101,'waterdist'}
      ,{102,'mosquitodist'}
      ,{103,'taxdist'}
      ,{104,'supremecourt'}
      ,{105,'justiceofpeace'}
      ,{106,'judicialdist'}
      ,{107,'superiorctdist'}
      ,{108,'appealsct'}
      ,{109,'courtfiller'}
      ,{110,'cassaddrtyptbl'}
      ,{111,'cassdelivpointcd'}
      ,{112,'casscarrierrtetbl'}
      ,{113,'blkgrpenumdist'}
      ,{114,'congressionaldist'}
      ,{115,'lattitude'}
      ,{116,'countyfips'}
      ,{117,'censustract'}
      ,{118,'fipsstcountycd'}
      ,{119,'longitude'}
      ,{120,'contributorparty'}
      ,{121,'recipientparty'}
      ,{122,'dateofcontr'}
      ,{123,'dollaramt'}
      ,{124,'officecontto'}
      ,{125,'cumuldollaramt'}
      ,{126,'contfiller1'}
      ,{127,'contfiller2'}
      ,{128,'conttype'}
      ,{129,'contfiller4'}
      ,{130,'lastdatevote'}
      ,{131,'miscvotehist'}
      ,{132,'title'}
      ,{133,'fname'}
      ,{134,'mname'}
      ,{135,'lname'}
      ,{136,'name_suffix'}
      ,{137,'name_score'}
      ,{138,'prim_range'}
      ,{139,'predir'}
      ,{140,'prim_name'}
      ,{141,'addr_suffix'}
      ,{142,'postdir'}
      ,{143,'unit_desig'}
      ,{144,'sec_range'}
      ,{145,'p_city_name'}
      ,{146,'v_city_name'}
      ,{147,'st'}
      ,{148,'zip'}
      ,{149,'zip4'}
      ,{150,'cart'}
      ,{151,'cr_sort_sz'}
      ,{152,'lot'}
      ,{153,'lot_order'}
      ,{154,'dpbc'}
      ,{155,'chk_digit'}
      ,{156,'rec_type'}
      ,{157,'ace_fips_st'}
      ,{158,'fips_county'}
      ,{159,'geo_lat'}
      ,{160,'geo_long'}
      ,{161,'msa'}
      ,{162,'geo_blk'}
      ,{163,'geo_match'}
      ,{164,'err_stat'}
      ,{165,'mail_prim_range'}
      ,{166,'mail_predir'}
      ,{167,'mail_prim_name'}
      ,{168,'mail_addr_suffix'}
      ,{169,'mail_postdir'}
      ,{170,'mail_unit_desig'}
      ,{171,'mail_sec_range'}
      ,{172,'mail_p_city_name'}
      ,{173,'mail_v_city_name'}
      ,{174,'mail_st'}
      ,{175,'mail_ace_zip'}
      ,{176,'mail_zip4'}
      ,{177,'mail_cart'}
      ,{178,'mail_cr_sort_sz'}
      ,{179,'mail_lot'}
      ,{180,'mail_lot_order'}
      ,{181,'mail_dpbc'}
      ,{182,'mail_chk_digit'}
      ,{183,'mail_rec_type'}
      ,{184,'mail_ace_fips_st'}
      ,{185,'mail_fips_county'}
      ,{186,'mail_geo_lat'}
      ,{187,'mail_geo_long'}
      ,{188,'mail_msa'}
      ,{189,'mail_geo_blk'}
      ,{190,'mail_geo_match'}
      ,{191,'mail_err_stat'}
      ,{192,'idtypes'}
      ,{193,'precinct'}
      ,{194,'ward1'}
      ,{195,'idcode'}
      ,{196,'precinctparttextdesig'}
      ,{197,'precinctparttextname'}
      ,{198,'precincttextdesig'}
      ,{199,'marriedappend'}
      ,{200,'supervisordistrict'}
      ,{201,'district'}
      ,{202,'ward2'}
      ,{203,'citycountycouncil'}
      ,{204,'countyprecinct'}
      ,{205,'countycommis'}
      ,{206,'schoolboard'}
      ,{207,'ward3'}
      ,{208,'towncitycouncil1'}
      ,{209,'towncitycouncil2'}
      ,{210,'regents'}
      ,{211,'watershed'}
      ,{212,'education'}
      ,{213,'policeconstable'}
      ,{214,'freeholder'}
      ,{215,'municourt'}
      ,{216,'changedate'}
      ,{217,'name_type'}
      ,{218,'addr_type'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Reg_Fields.InValid_rid((SALT39.StrType)le.rid),
    Base_Reg_Fields.InValid_did((SALT39.StrType)le.did),
    Base_Reg_Fields.InValid_did_score((SALT39.StrType)le.did_score),
    Base_Reg_Fields.InValid_ssn((SALT39.StrType)le.ssn),
    Base_Reg_Fields.InValid_vtid((SALT39.StrType)le.vtid),
    Base_Reg_Fields.InValid_process_date((SALT39.StrType)le.process_date),
    Base_Reg_Fields.InValid_date_first_seen((SALT39.StrType)le.date_first_seen),
    Base_Reg_Fields.InValid_date_last_seen((SALT39.StrType)le.date_last_seen),
    Base_Reg_Fields.InValid_source((SALT39.StrType)le.source),
    Base_Reg_Fields.InValid_file_id((SALT39.StrType)le.file_id),
    Base_Reg_Fields.InValid_vendor_id((SALT39.StrType)le.vendor_id),
    Base_Reg_Fields.InValid_source_state((SALT39.StrType)le.source_state),
    Base_Reg_Fields.InValid_source_code((SALT39.StrType)le.source_code),
    Base_Reg_Fields.InValid_file_acquired_date((SALT39.StrType)le.file_acquired_date),
    Base_Reg_Fields.InValid_use_code((SALT39.StrType)le.use_code),
    Base_Reg_Fields.InValid_prefix_title((SALT39.StrType)le.prefix_title),
    Base_Reg_Fields.InValid_last_name((SALT39.StrType)le.last_name,(SALT39.StrType)le.first_name,(SALT39.StrType)le.middle_name),
    Base_Reg_Fields.InValid_first_name((SALT39.StrType)le.first_name),
    Base_Reg_Fields.InValid_middle_name((SALT39.StrType)le.middle_name),
    Base_Reg_Fields.InValid_maiden_prior((SALT39.StrType)le.maiden_prior),
    Base_Reg_Fields.InValid_clean_maiden_pri((SALT39.StrType)le.clean_maiden_pri),
    Base_Reg_Fields.InValid_name_suffix_in((SALT39.StrType)le.name_suffix_in),
    Base_Reg_Fields.InValid_voterfiller((SALT39.StrType)le.voterfiller),
    Base_Reg_Fields.InValid_source_voterid((SALT39.StrType)le.source_voterid),
    Base_Reg_Fields.InValid_dob((SALT39.StrType)le.dob),
    Base_Reg_Fields.InValid_agecat((SALT39.StrType)le.agecat),
    Base_Reg_Fields.InValid_agecat_exp((SALT39.StrType)le.agecat_exp,(SALT39.StrType)le.agecat),
    Base_Reg_Fields.InValid_headhousehold((SALT39.StrType)le.headhousehold),
    Base_Reg_Fields.InValid_place_of_birth((SALT39.StrType)le.place_of_birth),
    Base_Reg_Fields.InValid_occupation((SALT39.StrType)le.occupation),
    Base_Reg_Fields.InValid_maiden_name((SALT39.StrType)le.maiden_name),
    Base_Reg_Fields.InValid_motorvoterid((SALT39.StrType)le.motorvoterid),
    Base_Reg_Fields.InValid_regsource((SALT39.StrType)le.regsource),
    Base_Reg_Fields.InValid_regdate((SALT39.StrType)le.regdate),
    Base_Reg_Fields.InValid_race((SALT39.StrType)le.race),
    Base_Reg_Fields.InValid_race_exp((SALT39.StrType)le.race_exp,(SALT39.StrType)le.race),
    Base_Reg_Fields.InValid_gender((SALT39.StrType)le.gender),
    Base_Reg_Fields.InValid_political_party((SALT39.StrType)le.political_party,(SALT39.StrType)le.politicalparty_exp),
    Base_Reg_Fields.InValid_politicalparty_exp((SALT39.StrType)le.politicalparty_exp),
    Base_Reg_Fields.InValid_phone((SALT39.StrType)le.phone),
    Base_Reg_Fields.InValid_work_phone((SALT39.StrType)le.work_phone),
    Base_Reg_Fields.InValid_other_phone((SALT39.StrType)le.other_phone),
    Base_Reg_Fields.InValid_active_status((SALT39.StrType)le.active_status),
    Base_Reg_Fields.InValid_active_status_exp((SALT39.StrType)le.active_status_exp),
    Base_Reg_Fields.InValid_gendersurnamguess((SALT39.StrType)le.gendersurnamguess),
    Base_Reg_Fields.InValid_active_other((SALT39.StrType)le.active_other),
    Base_Reg_Fields.InValid_voter_status((SALT39.StrType)le.voter_status),
    Base_Reg_Fields.InValid_voter_status_exp((SALT39.StrType)le.voter_status_exp),
    Base_Reg_Fields.InValid_res_addr1((SALT39.StrType)le.res_addr1),
    Base_Reg_Fields.InValid_res_addr2((SALT39.StrType)le.res_addr2),
    Base_Reg_Fields.InValid_res_city((SALT39.StrType)le.res_city),
    Base_Reg_Fields.InValid_res_state((SALT39.StrType)le.res_state),
    Base_Reg_Fields.InValid_res_zip((SALT39.StrType)le.res_zip),
    Base_Reg_Fields.InValid_res_county((SALT39.StrType)le.res_county),
    Base_Reg_Fields.InValid_mail_addr1((SALT39.StrType)le.mail_addr1),
    Base_Reg_Fields.InValid_mail_addr2((SALT39.StrType)le.mail_addr2),
    Base_Reg_Fields.InValid_mail_city((SALT39.StrType)le.mail_city),
    Base_Reg_Fields.InValid_mail_state((SALT39.StrType)le.mail_state),
    Base_Reg_Fields.InValid_mail_zip((SALT39.StrType)le.mail_zip),
    Base_Reg_Fields.InValid_mail_county((SALT39.StrType)le.mail_county),
    Base_Reg_Fields.InValid_addr_filler1((SALT39.StrType)le.addr_filler1),
    Base_Reg_Fields.InValid_addr_filler2((SALT39.StrType)le.addr_filler2),
    Base_Reg_Fields.InValid_city_filler((SALT39.StrType)le.city_filler),
    Base_Reg_Fields.InValid_state_filler((SALT39.StrType)le.state_filler),
    Base_Reg_Fields.InValid_zip_filler((SALT39.StrType)le.zip_filler),
    Base_Reg_Fields.InValid_timezonetbl((SALT39.StrType)le.timezonetbl),
    Base_Reg_Fields.InValid_towncode((SALT39.StrType)le.towncode),
    Base_Reg_Fields.InValid_distcode((SALT39.StrType)le.distcode),
    Base_Reg_Fields.InValid_countycode((SALT39.StrType)le.countycode),
    Base_Reg_Fields.InValid_schoolcode((SALT39.StrType)le.schoolcode),
    Base_Reg_Fields.InValid_cityinout((SALT39.StrType)le.cityinout),
    Base_Reg_Fields.InValid_spec_dist1((SALT39.StrType)le.spec_dist1),
    Base_Reg_Fields.InValid_spec_dist2((SALT39.StrType)le.spec_dist2),
    Base_Reg_Fields.InValid_precinct1((SALT39.StrType)le.precinct1),
    Base_Reg_Fields.InValid_precinct2((SALT39.StrType)le.precinct2),
    Base_Reg_Fields.InValid_precinct3((SALT39.StrType)le.precinct3),
    Base_Reg_Fields.InValid_villageprecinct((SALT39.StrType)le.villageprecinct),
    Base_Reg_Fields.InValid_schoolprecinct((SALT39.StrType)le.schoolprecinct),
    Base_Reg_Fields.InValid_ward((SALT39.StrType)le.ward),
    Base_Reg_Fields.InValid_precinct_citytown((SALT39.StrType)le.precinct_citytown),
    Base_Reg_Fields.InValid_ancsmdindc((SALT39.StrType)le.ancsmdindc),
    Base_Reg_Fields.InValid_citycouncildist((SALT39.StrType)le.citycouncildist),
    Base_Reg_Fields.InValid_countycommdist((SALT39.StrType)le.countycommdist),
    Base_Reg_Fields.InValid_statehouse((SALT39.StrType)le.statehouse),
    Base_Reg_Fields.InValid_statesenate((SALT39.StrType)le.statesenate),
    Base_Reg_Fields.InValid_ushouse((SALT39.StrType)le.ushouse),
    Base_Reg_Fields.InValid_elemschooldist((SALT39.StrType)le.elemschooldist),
    Base_Reg_Fields.InValid_schooldist((SALT39.StrType)le.schooldist),
    Base_Reg_Fields.InValid_schoolfiller((SALT39.StrType)le.schoolfiller),
    Base_Reg_Fields.InValid_commcolldist((SALT39.StrType)le.commcolldist),
    Base_Reg_Fields.InValid_dist_filler((SALT39.StrType)le.dist_filler),
    Base_Reg_Fields.InValid_municipal((SALT39.StrType)le.municipal),
    Base_Reg_Fields.InValid_villagedist((SALT39.StrType)le.villagedist),
    Base_Reg_Fields.InValid_policejury((SALT39.StrType)le.policejury),
    Base_Reg_Fields.InValid_policedist((SALT39.StrType)le.policedist),
    Base_Reg_Fields.InValid_publicservcomm((SALT39.StrType)le.publicservcomm),
    Base_Reg_Fields.InValid_rescue((SALT39.StrType)le.rescue),
    Base_Reg_Fields.InValid_fire((SALT39.StrType)le.fire),
    Base_Reg_Fields.InValid_sanitary((SALT39.StrType)le.sanitary),
    Base_Reg_Fields.InValid_sewerdist((SALT39.StrType)le.sewerdist),
    Base_Reg_Fields.InValid_waterdist((SALT39.StrType)le.waterdist),
    Base_Reg_Fields.InValid_mosquitodist((SALT39.StrType)le.mosquitodist),
    Base_Reg_Fields.InValid_taxdist((SALT39.StrType)le.taxdist),
    Base_Reg_Fields.InValid_supremecourt((SALT39.StrType)le.supremecourt),
    Base_Reg_Fields.InValid_justiceofpeace((SALT39.StrType)le.justiceofpeace),
    Base_Reg_Fields.InValid_judicialdist((SALT39.StrType)le.judicialdist),
    Base_Reg_Fields.InValid_superiorctdist((SALT39.StrType)le.superiorctdist),
    Base_Reg_Fields.InValid_appealsct((SALT39.StrType)le.appealsct),
    Base_Reg_Fields.InValid_courtfiller((SALT39.StrType)le.courtfiller),
    Base_Reg_Fields.InValid_cassaddrtyptbl((SALT39.StrType)le.cassaddrtyptbl),
    Base_Reg_Fields.InValid_cassdelivpointcd((SALT39.StrType)le.cassdelivpointcd),
    Base_Reg_Fields.InValid_casscarrierrtetbl((SALT39.StrType)le.casscarrierrtetbl),
    Base_Reg_Fields.InValid_blkgrpenumdist((SALT39.StrType)le.blkgrpenumdist),
    Base_Reg_Fields.InValid_congressionaldist((SALT39.StrType)le.congressionaldist),
    Base_Reg_Fields.InValid_lattitude((SALT39.StrType)le.lattitude),
    Base_Reg_Fields.InValid_countyfips((SALT39.StrType)le.countyfips),
    Base_Reg_Fields.InValid_censustract((SALT39.StrType)le.censustract),
    Base_Reg_Fields.InValid_fipsstcountycd((SALT39.StrType)le.fipsstcountycd),
    Base_Reg_Fields.InValid_longitude((SALT39.StrType)le.longitude),
    Base_Reg_Fields.InValid_contributorparty((SALT39.StrType)le.contributorparty),
    Base_Reg_Fields.InValid_recipientparty((SALT39.StrType)le.recipientparty),
    Base_Reg_Fields.InValid_dateofcontr((SALT39.StrType)le.dateofcontr),
    Base_Reg_Fields.InValid_dollaramt((SALT39.StrType)le.dollaramt),
    Base_Reg_Fields.InValid_officecontto((SALT39.StrType)le.officecontto),
    Base_Reg_Fields.InValid_cumuldollaramt((SALT39.StrType)le.cumuldollaramt),
    Base_Reg_Fields.InValid_contfiller1((SALT39.StrType)le.contfiller1),
    Base_Reg_Fields.InValid_contfiller2((SALT39.StrType)le.contfiller2),
    Base_Reg_Fields.InValid_conttype((SALT39.StrType)le.conttype),
    Base_Reg_Fields.InValid_contfiller4((SALT39.StrType)le.contfiller4),
    Base_Reg_Fields.InValid_lastdatevote((SALT39.StrType)le.lastdatevote),
    Base_Reg_Fields.InValid_miscvotehist((SALT39.StrType)le.miscvotehist),
    Base_Reg_Fields.InValid_title((SALT39.StrType)le.title),
    Base_Reg_Fields.InValid_fname((SALT39.StrType)le.fname,(SALT39.StrType)le.mname,(SALT39.StrType)le.lname),
    Base_Reg_Fields.InValid_mname((SALT39.StrType)le.mname),
    Base_Reg_Fields.InValid_lname((SALT39.StrType)le.lname),
    Base_Reg_Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix),
    Base_Reg_Fields.InValid_name_score((SALT39.StrType)le.name_score),
    Base_Reg_Fields.InValid_prim_range((SALT39.StrType)le.prim_range),
    Base_Reg_Fields.InValid_predir((SALT39.StrType)le.predir),
    Base_Reg_Fields.InValid_prim_name((SALT39.StrType)le.prim_name),
    Base_Reg_Fields.InValid_addr_suffix((SALT39.StrType)le.addr_suffix),
    Base_Reg_Fields.InValid_postdir((SALT39.StrType)le.postdir),
    Base_Reg_Fields.InValid_unit_desig((SALT39.StrType)le.unit_desig),
    Base_Reg_Fields.InValid_sec_range((SALT39.StrType)le.sec_range),
    Base_Reg_Fields.InValid_p_city_name((SALT39.StrType)le.p_city_name),
    Base_Reg_Fields.InValid_v_city_name((SALT39.StrType)le.v_city_name),
    Base_Reg_Fields.InValid_st((SALT39.StrType)le.st),
    Base_Reg_Fields.InValid_zip((SALT39.StrType)le.zip),
    Base_Reg_Fields.InValid_zip4((SALT39.StrType)le.zip4),
    Base_Reg_Fields.InValid_cart((SALT39.StrType)le.cart),
    Base_Reg_Fields.InValid_cr_sort_sz((SALT39.StrType)le.cr_sort_sz),
    Base_Reg_Fields.InValid_lot((SALT39.StrType)le.lot),
    Base_Reg_Fields.InValid_lot_order((SALT39.StrType)le.lot_order),
    Base_Reg_Fields.InValid_dpbc((SALT39.StrType)le.dpbc),
    Base_Reg_Fields.InValid_chk_digit((SALT39.StrType)le.chk_digit),
    Base_Reg_Fields.InValid_rec_type((SALT39.StrType)le.rec_type),
    Base_Reg_Fields.InValid_ace_fips_st((SALT39.StrType)le.ace_fips_st),
    Base_Reg_Fields.InValid_fips_county((SALT39.StrType)le.fips_county),
    Base_Reg_Fields.InValid_geo_lat((SALT39.StrType)le.geo_lat),
    Base_Reg_Fields.InValid_geo_long((SALT39.StrType)le.geo_long),
    Base_Reg_Fields.InValid_msa((SALT39.StrType)le.msa),
    Base_Reg_Fields.InValid_geo_blk((SALT39.StrType)le.geo_blk),
    Base_Reg_Fields.InValid_geo_match((SALT39.StrType)le.geo_match),
    Base_Reg_Fields.InValid_err_stat((SALT39.StrType)le.err_stat),
    Base_Reg_Fields.InValid_mail_prim_range((SALT39.StrType)le.mail_prim_range),
    Base_Reg_Fields.InValid_mail_predir((SALT39.StrType)le.mail_predir),
    Base_Reg_Fields.InValid_mail_prim_name((SALT39.StrType)le.mail_prim_name),
    Base_Reg_Fields.InValid_mail_addr_suffix((SALT39.StrType)le.mail_addr_suffix),
    Base_Reg_Fields.InValid_mail_postdir((SALT39.StrType)le.mail_postdir),
    Base_Reg_Fields.InValid_mail_unit_desig((SALT39.StrType)le.mail_unit_desig),
    Base_Reg_Fields.InValid_mail_sec_range((SALT39.StrType)le.mail_sec_range),
    Base_Reg_Fields.InValid_mail_p_city_name((SALT39.StrType)le.mail_p_city_name),
    Base_Reg_Fields.InValid_mail_v_city_name((SALT39.StrType)le.mail_v_city_name),
    Base_Reg_Fields.InValid_mail_st((SALT39.StrType)le.mail_st),
    Base_Reg_Fields.InValid_mail_ace_zip((SALT39.StrType)le.mail_ace_zip),
    Base_Reg_Fields.InValid_mail_zip4((SALT39.StrType)le.mail_zip4),
    Base_Reg_Fields.InValid_mail_cart((SALT39.StrType)le.mail_cart),
    Base_Reg_Fields.InValid_mail_cr_sort_sz((SALT39.StrType)le.mail_cr_sort_sz),
    Base_Reg_Fields.InValid_mail_lot((SALT39.StrType)le.mail_lot),
    Base_Reg_Fields.InValid_mail_lot_order((SALT39.StrType)le.mail_lot_order),
    Base_Reg_Fields.InValid_mail_dpbc((SALT39.StrType)le.mail_dpbc),
    Base_Reg_Fields.InValid_mail_chk_digit((SALT39.StrType)le.mail_chk_digit),
    Base_Reg_Fields.InValid_mail_rec_type((SALT39.StrType)le.mail_rec_type),
    Base_Reg_Fields.InValid_mail_ace_fips_st((SALT39.StrType)le.mail_ace_fips_st),
    Base_Reg_Fields.InValid_mail_fips_county((SALT39.StrType)le.mail_fips_county),
    Base_Reg_Fields.InValid_mail_geo_lat((SALT39.StrType)le.mail_geo_lat),
    Base_Reg_Fields.InValid_mail_geo_long((SALT39.StrType)le.mail_geo_long),
    Base_Reg_Fields.InValid_mail_msa((SALT39.StrType)le.mail_msa),
    Base_Reg_Fields.InValid_mail_geo_blk((SALT39.StrType)le.mail_geo_blk),
    Base_Reg_Fields.InValid_mail_geo_match((SALT39.StrType)le.mail_geo_match),
    Base_Reg_Fields.InValid_mail_err_stat((SALT39.StrType)le.mail_err_stat),
    Base_Reg_Fields.InValid_idtypes((SALT39.StrType)le.idtypes),
    Base_Reg_Fields.InValid_precinct((SALT39.StrType)le.precinct),
    Base_Reg_Fields.InValid_ward1((SALT39.StrType)le.ward1),
    Base_Reg_Fields.InValid_idcode((SALT39.StrType)le.idcode),
    Base_Reg_Fields.InValid_precinctparttextdesig((SALT39.StrType)le.precinctparttextdesig),
    Base_Reg_Fields.InValid_precinctparttextname((SALT39.StrType)le.precinctparttextname),
    Base_Reg_Fields.InValid_precincttextdesig((SALT39.StrType)le.precincttextdesig),
    Base_Reg_Fields.InValid_marriedappend((SALT39.StrType)le.marriedappend),
    Base_Reg_Fields.InValid_supervisordistrict((SALT39.StrType)le.supervisordistrict),
    Base_Reg_Fields.InValid_district((SALT39.StrType)le.district),
    Base_Reg_Fields.InValid_ward2((SALT39.StrType)le.ward2),
    Base_Reg_Fields.InValid_citycountycouncil((SALT39.StrType)le.citycountycouncil),
    Base_Reg_Fields.InValid_countyprecinct((SALT39.StrType)le.countyprecinct),
    Base_Reg_Fields.InValid_countycommis((SALT39.StrType)le.countycommis),
    Base_Reg_Fields.InValid_schoolboard((SALT39.StrType)le.schoolboard),
    Base_Reg_Fields.InValid_ward3((SALT39.StrType)le.ward3),
    Base_Reg_Fields.InValid_towncitycouncil1((SALT39.StrType)le.towncitycouncil1),
    Base_Reg_Fields.InValid_towncitycouncil2((SALT39.StrType)le.towncitycouncil2),
    Base_Reg_Fields.InValid_regents((SALT39.StrType)le.regents),
    Base_Reg_Fields.InValid_watershed((SALT39.StrType)le.watershed),
    Base_Reg_Fields.InValid_education((SALT39.StrType)le.education),
    Base_Reg_Fields.InValid_policeconstable((SALT39.StrType)le.policeconstable),
    Base_Reg_Fields.InValid_freeholder((SALT39.StrType)le.freeholder),
    Base_Reg_Fields.InValid_municourt((SALT39.StrType)le.municourt),
    Base_Reg_Fields.InValid_changedate((SALT39.StrType)le.changedate),
    Base_Reg_Fields.InValid_name_type((SALT39.StrType)le.name_type),
    Base_Reg_Fields.InValid_addr_type((SALT39.StrType)le.addr_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,218,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Reg_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_percentage','invalid_ssn','invalid_vtid','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_source','invalid_file_id','invalid_alphanum','invalid_source_state','Unknown','invalid_pastdate8','Unknown','Unknown','invalid_last_name','invalid_alphanum_specials','invalid_alphanum_specials','Unknown','Unknown','Unknown','Unknown','invalid_alphanum','invalid_dob','invalid_agecat','invalid_agecat_exp','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_regdate','invalid_race','invalid_race_exp','invalid_gender','invalid_political_party','invalid_politicalparty_exp','invalid_phone','invalid_phone','invalid_nums_empty','invalid_alphanum_empty','invalid_active_status_exp','invalid_alphanum_empty','invalid_alphanum_empty','invalid_alphanum_empty','invalid_voter_status_exp','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_nums_empty','Unknown','invalid_alphanum_empty','invalid_alphanum_empty','invalid_alphanum_specials','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alphanum_empty','invalid_alphanumquot_empty','invalid_alphanum_empty','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_lastdatevote','Unknown','Unknown','invalid_fname','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_boolean_yn_empty','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_changedate','invalid_name_type','invalid_addr_type');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Reg_Fields.InValidMessage_rid(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_vtid(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_source(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_file_id(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_source_state(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_file_acquired_date(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_use_code(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_prefix_title(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_maiden_prior(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_clean_maiden_pri(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_name_suffix_in(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_voterfiller(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_source_voterid(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_agecat(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_agecat_exp(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_headhousehold(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_place_of_birth(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_occupation(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_maiden_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_motorvoterid(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_regsource(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_regdate(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_race(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_race_exp(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_political_party(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_politicalparty_exp(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_other_phone(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_active_status(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_active_status_exp(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_gendersurnamguess(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_active_other(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_voter_status(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_voter_status_exp(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_res_addr1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_res_addr2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_res_city(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_res_state(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_res_zip(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_res_county(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_addr1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_addr2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_county(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_addr_filler1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_addr_filler2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_city_filler(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_state_filler(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_zip_filler(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_timezonetbl(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_towncode(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_distcode(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_countycode(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_schoolcode(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_cityinout(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_spec_dist1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_spec_dist2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinct1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinct2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinct3(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_villageprecinct(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_schoolprecinct(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ward(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinct_citytown(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ancsmdindc(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_citycouncildist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_countycommdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_statehouse(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_statesenate(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ushouse(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_elemschooldist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_schooldist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_schoolfiller(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_commcolldist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_dist_filler(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_municipal(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_villagedist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_policejury(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_policedist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_publicservcomm(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_rescue(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_fire(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_sanitary(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_sewerdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_waterdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mosquitodist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_taxdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_supremecourt(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_justiceofpeace(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_judicialdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_superiorctdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_appealsct(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_courtfiller(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_cassaddrtyptbl(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_cassdelivpointcd(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_casscarrierrtetbl(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_blkgrpenumdist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_congressionaldist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_lattitude(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_countyfips(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_censustract(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_fipsstcountycd(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_contributorparty(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_recipientparty(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_dateofcontr(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_dollaramt(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_officecontto(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_cumuldollaramt(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_contfiller1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_contfiller2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_conttype(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_contfiller4(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_lastdatevote(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_miscvotehist(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_prim_range(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_predir(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_prim_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_addr_suffix(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_postdir(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_unit_desig(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_sec_range(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_p_city_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_v_city_name(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_st(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_ace_zip(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_cart(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_cr_sort_sz(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_lot(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_lot_order(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_dpbc(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_chk_digit(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_rec_type(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_ace_fips_st(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_fips_county(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_geo_lat(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_geo_long(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_msa(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_geo_blk(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_geo_match(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_mail_err_stat(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_idtypes(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinct(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ward1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_idcode(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinctparttextdesig(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precinctparttextname(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_precincttextdesig(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_marriedappend(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_supervisordistrict(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_district(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ward2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_citycountycouncil(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_countyprecinct(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_countycommis(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_schoolboard(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_ward3(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_towncitycouncil1(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_towncitycouncil2(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_regents(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_watershed(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_education(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_policeconstable(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_freeholder(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_municourt(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_changedate(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Base_Reg_Fields.InValidMessage_addr_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Voters, Base_Reg_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
