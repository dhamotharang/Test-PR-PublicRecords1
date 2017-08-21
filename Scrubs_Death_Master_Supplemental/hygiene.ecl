IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Death_Master_Supplemental) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source_state);    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_source_state_pcnt := AVE(GROUP,IF(h.source_state = (TYPEOF(h.source_state))'',0,100));
    maxlength_source_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_state)));
    avelength_source_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_state)),h.source_state<>(typeof(h.source_state))'');
    populated_certificate_vol_no_pcnt := AVE(GROUP,IF(h.certificate_vol_no = (TYPEOF(h.certificate_vol_no))'',0,100));
    maxlength_certificate_vol_no := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.certificate_vol_no)));
    avelength_certificate_vol_no := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.certificate_vol_no)),h.certificate_vol_no<>(typeof(h.certificate_vol_no))'');
    populated_certificate_vol_year_pcnt := AVE(GROUP,IF(h.certificate_vol_year = (TYPEOF(h.certificate_vol_year))'',0,100));
    maxlength_certificate_vol_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.certificate_vol_year)));
    avelength_certificate_vol_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.certificate_vol_year)),h.certificate_vol_year<>(typeof(h.certificate_vol_year))'');
    populated_publication_pcnt := AVE(GROUP,IF(h.publication = (TYPEOF(h.publication))'',0,100));
    maxlength_publication := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.publication)));
    avelength_publication := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.publication)),h.publication<>(typeof(h.publication))'');
    populated_decedent_name_pcnt := AVE(GROUP,IF(h.decedent_name = (TYPEOF(h.decedent_name))'',0,100));
    maxlength_decedent_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_name)));
    avelength_decedent_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_name)),h.decedent_name<>(typeof(h.decedent_name))'');
    populated_decedent_race_pcnt := AVE(GROUP,IF(h.decedent_race = (TYPEOF(h.decedent_race))'',0,100));
    maxlength_decedent_race := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_race)));
    avelength_decedent_race := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_race)),h.decedent_race<>(typeof(h.decedent_race))'');
    populated_decedent_origin_pcnt := AVE(GROUP,IF(h.decedent_origin = (TYPEOF(h.decedent_origin))'',0,100));
    maxlength_decedent_origin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_origin)));
    avelength_decedent_origin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_origin)),h.decedent_origin<>(typeof(h.decedent_origin))'');
    populated_decedent_sex_pcnt := AVE(GROUP,IF(h.decedent_sex = (TYPEOF(h.decedent_sex))'',0,100));
    maxlength_decedent_sex := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_sex)));
    avelength_decedent_sex := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_sex)),h.decedent_sex<>(typeof(h.decedent_sex))'');
    populated_decedent_age_pcnt := AVE(GROUP,IF(h.decedent_age = (TYPEOF(h.decedent_age))'',0,100));
    maxlength_decedent_age := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_age)));
    avelength_decedent_age := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.decedent_age)),h.decedent_age<>(typeof(h.decedent_age))'');
    populated_education_pcnt := AVE(GROUP,IF(h.education = (TYPEOF(h.education))'',0,100));
    maxlength_education := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.education)));
    avelength_education := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.education)),h.education<>(typeof(h.education))'');
    populated_occupation_pcnt := AVE(GROUP,IF(h.occupation = (TYPEOF(h.occupation))'',0,100));
    maxlength_occupation := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.occupation)));
    avelength_occupation := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.occupation)),h.occupation<>(typeof(h.occupation))'');
    populated_where_worked_pcnt := AVE(GROUP,IF(h.where_worked = (TYPEOF(h.where_worked))'',0,100));
    maxlength_where_worked := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.where_worked)));
    avelength_where_worked := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.where_worked)),h.where_worked<>(typeof(h.where_worked))'');
    populated_cause_pcnt := AVE(GROUP,IF(h.cause = (TYPEOF(h.cause))'',0,100));
    maxlength_cause := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cause)));
    avelength_cause := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cause)),h.cause<>(typeof(h.cause))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_dod_pcnt := AVE(GROUP,IF(h.dod = (TYPEOF(h.dod))'',0,100));
    maxlength_dod := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dod)));
    avelength_dod := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dod)),h.dod<>(typeof(h.dod))'');
    populated_birthplace_pcnt := AVE(GROUP,IF(h.birthplace = (TYPEOF(h.birthplace))'',0,100));
    maxlength_birthplace := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.birthplace)));
    avelength_birthplace := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.birthplace)),h.birthplace<>(typeof(h.birthplace))'');
    populated_marital_status_pcnt := AVE(GROUP,IF(h.marital_status = (TYPEOF(h.marital_status))'',0,100));
    maxlength_marital_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.marital_status)));
    avelength_marital_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.marital_status)),h.marital_status<>(typeof(h.marital_status))'');
    populated_father_pcnt := AVE(GROUP,IF(h.father = (TYPEOF(h.father))'',0,100));
    maxlength_father := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.father)));
    avelength_father := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.father)),h.father<>(typeof(h.father))'');
    populated_mother_pcnt := AVE(GROUP,IF(h.mother = (TYPEOF(h.mother))'',0,100));
    maxlength_mother := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mother)));
    avelength_mother := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mother)),h.mother<>(typeof(h.mother))'');
    populated_filed_date_pcnt := AVE(GROUP,IF(h.filed_date = (TYPEOF(h.filed_date))'',0,100));
    maxlength_filed_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filed_date)));
    avelength_filed_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filed_date)),h.filed_date<>(typeof(h.filed_date))'');
    populated_year_pcnt := AVE(GROUP,IF(h.year = (TYPEOF(h.year))'',0,100));
    maxlength_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.year)));
    avelength_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.year)),h.year<>(typeof(h.year))'');
    populated_county_residence_pcnt := AVE(GROUP,IF(h.county_residence = (TYPEOF(h.county_residence))'',0,100));
    maxlength_county_residence := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_residence)));
    avelength_county_residence := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_residence)),h.county_residence<>(typeof(h.county_residence))'');
    populated_county_death_pcnt := AVE(GROUP,IF(h.county_death = (TYPEOF(h.county_death))'',0,100));
    maxlength_county_death := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_death)));
    avelength_county_death := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_death)),h.county_death<>(typeof(h.county_death))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_autopsy_pcnt := AVE(GROUP,IF(h.autopsy = (TYPEOF(h.autopsy))'',0,100));
    maxlength_autopsy := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.autopsy)));
    avelength_autopsy := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.autopsy)),h.autopsy<>(typeof(h.autopsy))'');
    populated_autopsy_findings_pcnt := AVE(GROUP,IF(h.autopsy_findings = (TYPEOF(h.autopsy_findings))'',0,100));
    maxlength_autopsy_findings := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.autopsy_findings)));
    avelength_autopsy_findings := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.autopsy_findings)),h.autopsy_findings<>(typeof(h.autopsy_findings))'');
    populated_primary_cause_of_death_pcnt := AVE(GROUP,IF(h.primary_cause_of_death = (TYPEOF(h.primary_cause_of_death))'',0,100));
    maxlength_primary_cause_of_death := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_cause_of_death)));
    avelength_primary_cause_of_death := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_cause_of_death)),h.primary_cause_of_death<>(typeof(h.primary_cause_of_death))'');
    populated_underlying_cause_of_death_pcnt := AVE(GROUP,IF(h.underlying_cause_of_death = (TYPEOF(h.underlying_cause_of_death))'',0,100));
    maxlength_underlying_cause_of_death := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.underlying_cause_of_death)));
    avelength_underlying_cause_of_death := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.underlying_cause_of_death)),h.underlying_cause_of_death<>(typeof(h.underlying_cause_of_death))'');
    populated_med_exam_pcnt := AVE(GROUP,IF(h.med_exam = (TYPEOF(h.med_exam))'',0,100));
    maxlength_med_exam := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.med_exam)));
    avelength_med_exam := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.med_exam)),h.med_exam<>(typeof(h.med_exam))'');
    populated_est_lic_no_pcnt := AVE(GROUP,IF(h.est_lic_no = (TYPEOF(h.est_lic_no))'',0,100));
    maxlength_est_lic_no := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.est_lic_no)));
    avelength_est_lic_no := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.est_lic_no)),h.est_lic_no<>(typeof(h.est_lic_no))'');
    populated_disposition_pcnt := AVE(GROUP,IF(h.disposition = (TYPEOF(h.disposition))'',0,100));
    maxlength_disposition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.disposition)));
    avelength_disposition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.disposition)),h.disposition<>(typeof(h.disposition))'');
    populated_disposition_date_pcnt := AVE(GROUP,IF(h.disposition_date = (TYPEOF(h.disposition_date))'',0,100));
    maxlength_disposition_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.disposition_date)));
    avelength_disposition_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.disposition_date)),h.disposition_date<>(typeof(h.disposition_date))'');
    populated_work_injury_pcnt := AVE(GROUP,IF(h.work_injury = (TYPEOF(h.work_injury))'',0,100));
    maxlength_work_injury := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_injury)));
    avelength_work_injury := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_injury)),h.work_injury<>(typeof(h.work_injury))'');
    populated_injury_date_pcnt := AVE(GROUP,IF(h.injury_date = (TYPEOF(h.injury_date))'',0,100));
    maxlength_injury_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_date)));
    avelength_injury_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_date)),h.injury_date<>(typeof(h.injury_date))'');
    populated_injury_type_pcnt := AVE(GROUP,IF(h.injury_type = (TYPEOF(h.injury_type))'',0,100));
    maxlength_injury_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_type)));
    avelength_injury_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_type)),h.injury_type<>(typeof(h.injury_type))'');
    populated_injury_location_pcnt := AVE(GROUP,IF(h.injury_location = (TYPEOF(h.injury_location))'',0,100));
    maxlength_injury_location := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_location)));
    avelength_injury_location := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_location)),h.injury_location<>(typeof(h.injury_location))'');
    populated_surg_performed_pcnt := AVE(GROUP,IF(h.surg_performed = (TYPEOF(h.surg_performed))'',0,100));
    maxlength_surg_performed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.surg_performed)));
    avelength_surg_performed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.surg_performed)),h.surg_performed<>(typeof(h.surg_performed))'');
    populated_surgery_date_pcnt := AVE(GROUP,IF(h.surgery_date = (TYPEOF(h.surgery_date))'',0,100));
    maxlength_surgery_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.surgery_date)));
    avelength_surgery_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.surgery_date)),h.surgery_date<>(typeof(h.surgery_date))'');
    populated_hospital_status_pcnt := AVE(GROUP,IF(h.hospital_status = (TYPEOF(h.hospital_status))'',0,100));
    maxlength_hospital_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hospital_status)));
    avelength_hospital_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hospital_status)),h.hospital_status<>(typeof(h.hospital_status))'');
    populated_pregnancy_pcnt := AVE(GROUP,IF(h.pregnancy = (TYPEOF(h.pregnancy))'',0,100));
    maxlength_pregnancy := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pregnancy)));
    avelength_pregnancy := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pregnancy)),h.pregnancy<>(typeof(h.pregnancy))'');
    populated_facility_death_pcnt := AVE(GROUP,IF(h.facility_death = (TYPEOF(h.facility_death))'',0,100));
    maxlength_facility_death := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.facility_death)));
    avelength_facility_death := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.facility_death)),h.facility_death<>(typeof(h.facility_death))'');
    populated_embalmer_lic_no_pcnt := AVE(GROUP,IF(h.embalmer_lic_no = (TYPEOF(h.embalmer_lic_no))'',0,100));
    maxlength_embalmer_lic_no := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.embalmer_lic_no)));
    avelength_embalmer_lic_no := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.embalmer_lic_no)),h.embalmer_lic_no<>(typeof(h.embalmer_lic_no))'');
    populated_death_type_pcnt := AVE(GROUP,IF(h.death_type = (TYPEOF(h.death_type))'',0,100));
    maxlength_death_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.death_type)));
    avelength_death_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.death_type)),h.death_type<>(typeof(h.death_type))'');
    populated_time_death_pcnt := AVE(GROUP,IF(h.time_death = (TYPEOF(h.time_death))'',0,100));
    maxlength_time_death := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_death)));
    avelength_time_death := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_death)),h.time_death<>(typeof(h.time_death))'');
    populated_birth_cert_pcnt := AVE(GROUP,IF(h.birth_cert = (TYPEOF(h.birth_cert))'',0,100));
    maxlength_birth_cert := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.birth_cert)));
    avelength_birth_cert := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.birth_cert)),h.birth_cert<>(typeof(h.birth_cert))'');
    populated_certifier_pcnt := AVE(GROUP,IF(h.certifier = (TYPEOF(h.certifier))'',0,100));
    maxlength_certifier := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.certifier)));
    avelength_certifier := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.certifier)),h.certifier<>(typeof(h.certifier))'');
    populated_cert_number_pcnt := AVE(GROUP,IF(h.cert_number = (TYPEOF(h.cert_number))'',0,100));
    maxlength_cert_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cert_number)));
    avelength_cert_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cert_number)),h.cert_number<>(typeof(h.cert_number))'');
    populated_birth_vol_year_pcnt := AVE(GROUP,IF(h.birth_vol_year = (TYPEOF(h.birth_vol_year))'',0,100));
    maxlength_birth_vol_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.birth_vol_year)));
    avelength_birth_vol_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.birth_vol_year)),h.birth_vol_year<>(typeof(h.birth_vol_year))'');
    populated_local_file_no_pcnt := AVE(GROUP,IF(h.local_file_no = (TYPEOF(h.local_file_no))'',0,100));
    maxlength_local_file_no := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_file_no)));
    avelength_local_file_no := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_file_no)),h.local_file_no<>(typeof(h.local_file_no))'');
    populated_vdi_pcnt := AVE(GROUP,IF(h.vdi = (TYPEOF(h.vdi))'',0,100));
    maxlength_vdi := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vdi)));
    avelength_vdi := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vdi)),h.vdi<>(typeof(h.vdi))'');
    populated_cite_id_pcnt := AVE(GROUP,IF(h.cite_id = (TYPEOF(h.cite_id))'',0,100));
    maxlength_cite_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cite_id)));
    avelength_cite_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cite_id)),h.cite_id<>(typeof(h.cite_id))'');
    populated_file_id_pcnt := AVE(GROUP,IF(h.file_id = (TYPEOF(h.file_id))'',0,100));
    maxlength_file_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.file_id)));
    avelength_file_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.file_id)),h.file_id<>(typeof(h.file_id))'');
    populated_date_last_trans_pcnt := AVE(GROUP,IF(h.date_last_trans = (TYPEOF(h.date_last_trans))'',0,100));
    maxlength_date_last_trans := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_trans)));
    avelength_date_last_trans := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_trans)),h.date_last_trans<>(typeof(h.date_last_trans))'');
    populated_amendment_code_pcnt := AVE(GROUP,IF(h.amendment_code = (TYPEOF(h.amendment_code))'',0,100));
    maxlength_amendment_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.amendment_code)));
    avelength_amendment_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.amendment_code)),h.amendment_code<>(typeof(h.amendment_code))'');
    populated_amendment_year_pcnt := AVE(GROUP,IF(h.amendment_year = (TYPEOF(h.amendment_year))'',0,100));
    maxlength_amendment_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.amendment_year)));
    avelength_amendment_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.amendment_year)),h.amendment_year<>(typeof(h.amendment_year))'');
    populated__on_lexis_pcnt := AVE(GROUP,IF(h._on_lexis = (TYPEOF(h._on_lexis))'',0,100));
    maxlength__on_lexis := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h._on_lexis)));
    avelength__on_lexis := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h._on_lexis)),h._on_lexis<>(typeof(h._on_lexis))'');
    populated__fs_profile_pcnt := AVE(GROUP,IF(h._fs_profile = (TYPEOF(h._fs_profile))'',0,100));
    maxlength__fs_profile := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h._fs_profile)));
    avelength__fs_profile := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h._fs_profile)),h._fs_profile<>(typeof(h._fs_profile))'');
    populated_us_armed_forces_pcnt := AVE(GROUP,IF(h.us_armed_forces = (TYPEOF(h.us_armed_forces))'',0,100));
    maxlength_us_armed_forces := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.us_armed_forces)));
    avelength_us_armed_forces := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.us_armed_forces)),h.us_armed_forces<>(typeof(h.us_armed_forces))'');
    populated_place_of_death_pcnt := AVE(GROUP,IF(h.place_of_death = (TYPEOF(h.place_of_death))'',0,100));
    maxlength_place_of_death := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.place_of_death)));
    avelength_place_of_death := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.place_of_death)),h.place_of_death<>(typeof(h.place_of_death))'');
    populated_state_death_id_pcnt := AVE(GROUP,IF(h.state_death_id = (TYPEOF(h.state_death_id))'',0,100));
    maxlength_state_death_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_death_id)));
    avelength_state_death_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_death_id)),h.state_death_id<>(typeof(h.state_death_id))'');
    populated_state_death_flag_pcnt := AVE(GROUP,IF(h.state_death_flag = (TYPEOF(h.state_death_flag))'',0,100));
    maxlength_state_death_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_death_flag)));
    avelength_state_death_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_death_flag)),h.state_death_flag<>(typeof(h.state_death_flag))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_orig_address1_pcnt := AVE(GROUP,IF(h.orig_address1 = (TYPEOF(h.orig_address1))'',0,100));
    maxlength_orig_address1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address1)));
    avelength_orig_address1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address1)),h.orig_address1<>(typeof(h.orig_address1))'');
    populated_orig_address2_pcnt := AVE(GROUP,IF(h.orig_address2 = (TYPEOF(h.orig_address2))'',0,100));
    maxlength_orig_address2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address2)));
    avelength_orig_address2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address2)),h.orig_address2<>(typeof(h.orig_address2))'');
    populated_statefn_pcnt := AVE(GROUP,IF(h.statefn = (TYPEOF(h.statefn))'',0,100));
    maxlength_statefn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.statefn)));
    avelength_statefn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.statefn)),h.statefn<>(typeof(h.statefn))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_state,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_source_state_pcnt *   0.00 / 100 + T.Populated_certificate_vol_no_pcnt *   0.00 / 100 + T.Populated_certificate_vol_year_pcnt *   0.00 / 100 + T.Populated_publication_pcnt *   0.00 / 100 + T.Populated_decedent_name_pcnt *   0.00 / 100 + T.Populated_decedent_race_pcnt *   0.00 / 100 + T.Populated_decedent_origin_pcnt *   0.00 / 100 + T.Populated_decedent_sex_pcnt *   0.00 / 100 + T.Populated_decedent_age_pcnt *   0.00 / 100 + T.Populated_education_pcnt *   0.00 / 100 + T.Populated_occupation_pcnt *   0.00 / 100 + T.Populated_where_worked_pcnt *   0.00 / 100 + T.Populated_cause_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_dod_pcnt *   0.00 / 100 + T.Populated_birthplace_pcnt *   0.00 / 100 + T.Populated_marital_status_pcnt *   0.00 / 100 + T.Populated_father_pcnt *   0.00 / 100 + T.Populated_mother_pcnt *   0.00 / 100 + T.Populated_filed_date_pcnt *   0.00 / 100 + T.Populated_year_pcnt *   0.00 / 100 + T.Populated_county_residence_pcnt *   0.00 / 100 + T.Populated_county_death_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_autopsy_pcnt *   0.00 / 100 + T.Populated_autopsy_findings_pcnt *   0.00 / 100 + T.Populated_primary_cause_of_death_pcnt *   0.00 / 100 + T.Populated_underlying_cause_of_death_pcnt *   0.00 / 100 + T.Populated_med_exam_pcnt *   0.00 / 100 + T.Populated_est_lic_no_pcnt *   0.00 / 100 + T.Populated_disposition_pcnt *   0.00 / 100 + T.Populated_disposition_date_pcnt *   0.00 / 100 + T.Populated_work_injury_pcnt *   0.00 / 100 + T.Populated_injury_date_pcnt *   0.00 / 100 + T.Populated_injury_type_pcnt *   0.00 / 100 + T.Populated_injury_location_pcnt *   0.00 / 100 + T.Populated_surg_performed_pcnt *   0.00 / 100 + T.Populated_surgery_date_pcnt *   0.00 / 100 + T.Populated_hospital_status_pcnt *   0.00 / 100 + T.Populated_pregnancy_pcnt *   0.00 / 100 + T.Populated_facility_death_pcnt *   0.00 / 100 + T.Populated_embalmer_lic_no_pcnt *   0.00 / 100 + T.Populated_death_type_pcnt *   0.00 / 100 + T.Populated_time_death_pcnt *   0.00 / 100 + T.Populated_birth_cert_pcnt *   0.00 / 100 + T.Populated_certifier_pcnt *   0.00 / 100 + T.Populated_cert_number_pcnt *   0.00 / 100 + T.Populated_birth_vol_year_pcnt *   0.00 / 100 + T.Populated_local_file_no_pcnt *   0.00 / 100 + T.Populated_vdi_pcnt *   0.00 / 100 + T.Populated_cite_id_pcnt *   0.00 / 100 + T.Populated_file_id_pcnt *   0.00 / 100 + T.Populated_date_last_trans_pcnt *   0.00 / 100 + T.Populated_amendment_code_pcnt *   0.00 / 100 + T.Populated_amendment_year_pcnt *   0.00 / 100 + T.Populated__on_lexis_pcnt *   0.00 / 100 + T.Populated__fs_profile_pcnt *   0.00 / 100 + T.Populated_us_armed_forces_pcnt *   0.00 / 100 + T.Populated_place_of_death_pcnt *   0.00 / 100 + T.Populated_state_death_id_pcnt *   0.00 / 100 + T.Populated_state_death_flag_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_orig_address1_pcnt *   0.00 / 100 + T.Populated_orig_address2_pcnt *   0.00 / 100 + T.Populated_statefn_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source_state1;
    STRING source_state2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_state1 := le.Source;
    SELF.source_state2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_source_state_pcnt*ri.Populated_source_state_pcnt *   0.00 / 10000 + le.Populated_certificate_vol_no_pcnt*ri.Populated_certificate_vol_no_pcnt *   0.00 / 10000 + le.Populated_certificate_vol_year_pcnt*ri.Populated_certificate_vol_year_pcnt *   0.00 / 10000 + le.Populated_publication_pcnt*ri.Populated_publication_pcnt *   0.00 / 10000 + le.Populated_decedent_name_pcnt*ri.Populated_decedent_name_pcnt *   0.00 / 10000 + le.Populated_decedent_race_pcnt*ri.Populated_decedent_race_pcnt *   0.00 / 10000 + le.Populated_decedent_origin_pcnt*ri.Populated_decedent_origin_pcnt *   0.00 / 10000 + le.Populated_decedent_sex_pcnt*ri.Populated_decedent_sex_pcnt *   0.00 / 10000 + le.Populated_decedent_age_pcnt*ri.Populated_decedent_age_pcnt *   0.00 / 10000 + le.Populated_education_pcnt*ri.Populated_education_pcnt *   0.00 / 10000 + le.Populated_occupation_pcnt*ri.Populated_occupation_pcnt *   0.00 / 10000 + le.Populated_where_worked_pcnt*ri.Populated_where_worked_pcnt *   0.00 / 10000 + le.Populated_cause_pcnt*ri.Populated_cause_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_dod_pcnt*ri.Populated_dod_pcnt *   0.00 / 10000 + le.Populated_birthplace_pcnt*ri.Populated_birthplace_pcnt *   0.00 / 10000 + le.Populated_marital_status_pcnt*ri.Populated_marital_status_pcnt *   0.00 / 10000 + le.Populated_father_pcnt*ri.Populated_father_pcnt *   0.00 / 10000 + le.Populated_mother_pcnt*ri.Populated_mother_pcnt *   0.00 / 10000 + le.Populated_filed_date_pcnt*ri.Populated_filed_date_pcnt *   0.00 / 10000 + le.Populated_year_pcnt*ri.Populated_year_pcnt *   0.00 / 10000 + le.Populated_county_residence_pcnt*ri.Populated_county_residence_pcnt *   0.00 / 10000 + le.Populated_county_death_pcnt*ri.Populated_county_death_pcnt *   0.00 / 10000 + le.Populated_address_pcnt*ri.Populated_address_pcnt *   0.00 / 10000 + le.Populated_autopsy_pcnt*ri.Populated_autopsy_pcnt *   0.00 / 10000 + le.Populated_autopsy_findings_pcnt*ri.Populated_autopsy_findings_pcnt *   0.00 / 10000 + le.Populated_primary_cause_of_death_pcnt*ri.Populated_primary_cause_of_death_pcnt *   0.00 / 10000 + le.Populated_underlying_cause_of_death_pcnt*ri.Populated_underlying_cause_of_death_pcnt *   0.00 / 10000 + le.Populated_med_exam_pcnt*ri.Populated_med_exam_pcnt *   0.00 / 10000 + le.Populated_est_lic_no_pcnt*ri.Populated_est_lic_no_pcnt *   0.00 / 10000 + le.Populated_disposition_pcnt*ri.Populated_disposition_pcnt *   0.00 / 10000 + le.Populated_disposition_date_pcnt*ri.Populated_disposition_date_pcnt *   0.00 / 10000 + le.Populated_work_injury_pcnt*ri.Populated_work_injury_pcnt *   0.00 / 10000 + le.Populated_injury_date_pcnt*ri.Populated_injury_date_pcnt *   0.00 / 10000 + le.Populated_injury_type_pcnt*ri.Populated_injury_type_pcnt *   0.00 / 10000 + le.Populated_injury_location_pcnt*ri.Populated_injury_location_pcnt *   0.00 / 10000 + le.Populated_surg_performed_pcnt*ri.Populated_surg_performed_pcnt *   0.00 / 10000 + le.Populated_surgery_date_pcnt*ri.Populated_surgery_date_pcnt *   0.00 / 10000 + le.Populated_hospital_status_pcnt*ri.Populated_hospital_status_pcnt *   0.00 / 10000 + le.Populated_pregnancy_pcnt*ri.Populated_pregnancy_pcnt *   0.00 / 10000 + le.Populated_facility_death_pcnt*ri.Populated_facility_death_pcnt *   0.00 / 10000 + le.Populated_embalmer_lic_no_pcnt*ri.Populated_embalmer_lic_no_pcnt *   0.00 / 10000 + le.Populated_death_type_pcnt*ri.Populated_death_type_pcnt *   0.00 / 10000 + le.Populated_time_death_pcnt*ri.Populated_time_death_pcnt *   0.00 / 10000 + le.Populated_birth_cert_pcnt*ri.Populated_birth_cert_pcnt *   0.00 / 10000 + le.Populated_certifier_pcnt*ri.Populated_certifier_pcnt *   0.00 / 10000 + le.Populated_cert_number_pcnt*ri.Populated_cert_number_pcnt *   0.00 / 10000 + le.Populated_birth_vol_year_pcnt*ri.Populated_birth_vol_year_pcnt *   0.00 / 10000 + le.Populated_local_file_no_pcnt*ri.Populated_local_file_no_pcnt *   0.00 / 10000 + le.Populated_vdi_pcnt*ri.Populated_vdi_pcnt *   0.00 / 10000 + le.Populated_cite_id_pcnt*ri.Populated_cite_id_pcnt *   0.00 / 10000 + le.Populated_file_id_pcnt*ri.Populated_file_id_pcnt *   0.00 / 10000 + le.Populated_date_last_trans_pcnt*ri.Populated_date_last_trans_pcnt *   0.00 / 10000 + le.Populated_amendment_code_pcnt*ri.Populated_amendment_code_pcnt *   0.00 / 10000 + le.Populated_amendment_year_pcnt*ri.Populated_amendment_year_pcnt *   0.00 / 10000 + le.Populated__on_lexis_pcnt*ri.Populated__on_lexis_pcnt *   0.00 / 10000 + le.Populated__fs_profile_pcnt*ri.Populated__fs_profile_pcnt *   0.00 / 10000 + le.Populated_us_armed_forces_pcnt*ri.Populated_us_armed_forces_pcnt *   0.00 / 10000 + le.Populated_place_of_death_pcnt*ri.Populated_place_of_death_pcnt *   0.00 / 10000 + le.Populated_state_death_id_pcnt*ri.Populated_state_death_id_pcnt *   0.00 / 10000 + le.Populated_state_death_flag_pcnt*ri.Populated_state_death_flag_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt *   0.00 / 10000 + le.Populated_orig_address1_pcnt*ri.Populated_orig_address1_pcnt *   0.00 / 10000 + le.Populated_orig_address2_pcnt*ri.Populated_orig_address2_pcnt *   0.00 / 10000 + le.Populated_statefn_pcnt*ri.Populated_statefn_pcnt *   0.00 / 10000 + le.Populated_lf_pcnt*ri.Populated_lf_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','source_state','certificate_vol_no','certificate_vol_year','publication','decedent_name','decedent_race','decedent_origin','decedent_sex','decedent_age','education','occupation','where_worked','cause','ssn','dob','dod','birthplace','marital_status','father','mother','filed_date','year','county_residence','county_death','address','autopsy','autopsy_findings','primary_cause_of_death','underlying_cause_of_death','med_exam','est_lic_no','disposition','disposition_date','work_injury','injury_date','injury_type','injury_location','surg_performed','surgery_date','hospital_status','pregnancy','facility_death','embalmer_lic_no','death_type','time_death','birth_cert','certifier','cert_number','birth_vol_year','local_file_no','vdi','cite_id','file_id','date_last_trans','amendment_code','amendment_year','_on_lexis','_fs_profile','us_armed_forces','place_of_death','state_death_id','state_death_flag','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','orig_address1','orig_address2','statefn','lf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_source_state_pcnt,le.populated_certificate_vol_no_pcnt,le.populated_certificate_vol_year_pcnt,le.populated_publication_pcnt,le.populated_decedent_name_pcnt,le.populated_decedent_race_pcnt,le.populated_decedent_origin_pcnt,le.populated_decedent_sex_pcnt,le.populated_decedent_age_pcnt,le.populated_education_pcnt,le.populated_occupation_pcnt,le.populated_where_worked_pcnt,le.populated_cause_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_dod_pcnt,le.populated_birthplace_pcnt,le.populated_marital_status_pcnt,le.populated_father_pcnt,le.populated_mother_pcnt,le.populated_filed_date_pcnt,le.populated_year_pcnt,le.populated_county_residence_pcnt,le.populated_county_death_pcnt,le.populated_address_pcnt,le.populated_autopsy_pcnt,le.populated_autopsy_findings_pcnt,le.populated_primary_cause_of_death_pcnt,le.populated_underlying_cause_of_death_pcnt,le.populated_med_exam_pcnt,le.populated_est_lic_no_pcnt,le.populated_disposition_pcnt,le.populated_disposition_date_pcnt,le.populated_work_injury_pcnt,le.populated_injury_date_pcnt,le.populated_injury_type_pcnt,le.populated_injury_location_pcnt,le.populated_surg_performed_pcnt,le.populated_surgery_date_pcnt,le.populated_hospital_status_pcnt,le.populated_pregnancy_pcnt,le.populated_facility_death_pcnt,le.populated_embalmer_lic_no_pcnt,le.populated_death_type_pcnt,le.populated_time_death_pcnt,le.populated_birth_cert_pcnt,le.populated_certifier_pcnt,le.populated_cert_number_pcnt,le.populated_birth_vol_year_pcnt,le.populated_local_file_no_pcnt,le.populated_vdi_pcnt,le.populated_cite_id_pcnt,le.populated_file_id_pcnt,le.populated_date_last_trans_pcnt,le.populated_amendment_code_pcnt,le.populated_amendment_year_pcnt,le.populated__on_lexis_pcnt,le.populated__fs_profile_pcnt,le.populated_us_armed_forces_pcnt,le.populated_place_of_death_pcnt,le.populated_state_death_id_pcnt,le.populated_state_death_flag_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_rawaid_pcnt,le.populated_orig_address1_pcnt,le.populated_orig_address2_pcnt,le.populated_statefn_pcnt,le.populated_lf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_source_state,le.maxlength_certificate_vol_no,le.maxlength_certificate_vol_year,le.maxlength_publication,le.maxlength_decedent_name,le.maxlength_decedent_race,le.maxlength_decedent_origin,le.maxlength_decedent_sex,le.maxlength_decedent_age,le.maxlength_education,le.maxlength_occupation,le.maxlength_where_worked,le.maxlength_cause,le.maxlength_ssn,le.maxlength_dob,le.maxlength_dod,le.maxlength_birthplace,le.maxlength_marital_status,le.maxlength_father,le.maxlength_mother,le.maxlength_filed_date,le.maxlength_year,le.maxlength_county_residence,le.maxlength_county_death,le.maxlength_address,le.maxlength_autopsy,le.maxlength_autopsy_findings,le.maxlength_primary_cause_of_death,le.maxlength_underlying_cause_of_death,le.maxlength_med_exam,le.maxlength_est_lic_no,le.maxlength_disposition,le.maxlength_disposition_date,le.maxlength_work_injury,le.maxlength_injury_date,le.maxlength_injury_type,le.maxlength_injury_location,le.maxlength_surg_performed,le.maxlength_surgery_date,le.maxlength_hospital_status,le.maxlength_pregnancy,le.maxlength_facility_death,le.maxlength_embalmer_lic_no,le.maxlength_death_type,le.maxlength_time_death,le.maxlength_birth_cert,le.maxlength_certifier,le.maxlength_cert_number,le.maxlength_birth_vol_year,le.maxlength_local_file_no,le.maxlength_vdi,le.maxlength_cite_id,le.maxlength_file_id,le.maxlength_date_last_trans,le.maxlength_amendment_code,le.maxlength_amendment_year,le.maxlength__on_lexis,le.maxlength__fs_profile,le.maxlength_us_armed_forces,le.maxlength_place_of_death,le.maxlength_state_death_id,le.maxlength_state_death_flag,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_state,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_rawaid,le.maxlength_orig_address1,le.maxlength_orig_address2,le.maxlength_statefn,le.maxlength_lf);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_source_state,le.avelength_certificate_vol_no,le.avelength_certificate_vol_year,le.avelength_publication,le.avelength_decedent_name,le.avelength_decedent_race,le.avelength_decedent_origin,le.avelength_decedent_sex,le.avelength_decedent_age,le.avelength_education,le.avelength_occupation,le.avelength_where_worked,le.avelength_cause,le.avelength_ssn,le.avelength_dob,le.avelength_dod,le.avelength_birthplace,le.avelength_marital_status,le.avelength_father,le.avelength_mother,le.avelength_filed_date,le.avelength_year,le.avelength_county_residence,le.avelength_county_death,le.avelength_address,le.avelength_autopsy,le.avelength_autopsy_findings,le.avelength_primary_cause_of_death,le.avelength_underlying_cause_of_death,le.avelength_med_exam,le.avelength_est_lic_no,le.avelength_disposition,le.avelength_disposition_date,le.avelength_work_injury,le.avelength_injury_date,le.avelength_injury_type,le.avelength_injury_location,le.avelength_surg_performed,le.avelength_surgery_date,le.avelength_hospital_status,le.avelength_pregnancy,le.avelength_facility_death,le.avelength_embalmer_lic_no,le.avelength_death_type,le.avelength_time_death,le.avelength_birth_cert,le.avelength_certifier,le.avelength_cert_number,le.avelength_birth_vol_year,le.avelength_local_file_no,le.avelength_vdi,le.avelength_cite_id,le.avelength_file_id,le.avelength_date_last_trans,le.avelength_amendment_code,le.avelength_amendment_year,le.avelength__on_lexis,le.avelength__fs_profile,le.avelength_us_armed_forces,le.avelength_place_of_death,le.avelength_state_death_id,le.avelength_state_death_flag,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_state,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_rawaid,le.avelength_orig_address1,le.avelength_orig_address2,le.avelength_statefn,le.avelength_lf);
END;
EXPORT invSummary := NORMALIZE(summary0, 101, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_state;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.source_state),TRIM((SALT30.StrType)le.certificate_vol_no),TRIM((SALT30.StrType)le.certificate_vol_year),TRIM((SALT30.StrType)le.publication),TRIM((SALT30.StrType)le.decedent_name),TRIM((SALT30.StrType)le.decedent_race),TRIM((SALT30.StrType)le.decedent_origin),TRIM((SALT30.StrType)le.decedent_sex),TRIM((SALT30.StrType)le.decedent_age),TRIM((SALT30.StrType)le.education),TRIM((SALT30.StrType)le.occupation),TRIM((SALT30.StrType)le.where_worked),TRIM((SALT30.StrType)le.cause),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.dod),TRIM((SALT30.StrType)le.birthplace),TRIM((SALT30.StrType)le.marital_status),TRIM((SALT30.StrType)le.father),TRIM((SALT30.StrType)le.mother),TRIM((SALT30.StrType)le.filed_date),TRIM((SALT30.StrType)le.year),TRIM((SALT30.StrType)le.county_residence),TRIM((SALT30.StrType)le.county_death),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.autopsy),TRIM((SALT30.StrType)le.autopsy_findings),TRIM((SALT30.StrType)le.primary_cause_of_death),TRIM((SALT30.StrType)le.underlying_cause_of_death),TRIM((SALT30.StrType)le.med_exam),TRIM((SALT30.StrType)le.est_lic_no),TRIM((SALT30.StrType)le.disposition),TRIM((SALT30.StrType)le.disposition_date),TRIM((SALT30.StrType)le.work_injury),TRIM((SALT30.StrType)le.injury_date),TRIM((SALT30.StrType)le.injury_type),TRIM((SALT30.StrType)le.injury_location),TRIM((SALT30.StrType)le.surg_performed),TRIM((SALT30.StrType)le.surgery_date),TRIM((SALT30.StrType)le.hospital_status),TRIM((SALT30.StrType)le.pregnancy),TRIM((SALT30.StrType)le.facility_death),TRIM((SALT30.StrType)le.embalmer_lic_no),TRIM((SALT30.StrType)le.death_type),TRIM((SALT30.StrType)le.time_death),TRIM((SALT30.StrType)le.birth_cert),TRIM((SALT30.StrType)le.certifier),TRIM((SALT30.StrType)le.cert_number),TRIM((SALT30.StrType)le.birth_vol_year),TRIM((SALT30.StrType)le.local_file_no),TRIM((SALT30.StrType)le.vdi),TRIM((SALT30.StrType)le.cite_id),TRIM((SALT30.StrType)le.file_id),TRIM((SALT30.StrType)le.date_last_trans),TRIM((SALT30.StrType)le.amendment_code),TRIM((SALT30.StrType)le.amendment_year),TRIM((SALT30.StrType)le._on_lexis),TRIM((SALT30.StrType)le._fs_profile),TRIM((SALT30.StrType)le.us_armed_forces),TRIM((SALT30.StrType)le.place_of_death),TRIM((SALT30.StrType)le.state_death_id),TRIM((SALT30.StrType)le.state_death_flag),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip5),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.fips_state),TRIM((SALT30.StrType)le.fips_county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.orig_address1),TRIM((SALT30.StrType)le.orig_address2),TRIM((SALT30.StrType)le.statefn),TRIM((SALT30.StrType)le.lf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,101,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 101);
  SELF.FldNo2 := 1 + (C % 101);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.source_state),TRIM((SALT30.StrType)le.certificate_vol_no),TRIM((SALT30.StrType)le.certificate_vol_year),TRIM((SALT30.StrType)le.publication),TRIM((SALT30.StrType)le.decedent_name),TRIM((SALT30.StrType)le.decedent_race),TRIM((SALT30.StrType)le.decedent_origin),TRIM((SALT30.StrType)le.decedent_sex),TRIM((SALT30.StrType)le.decedent_age),TRIM((SALT30.StrType)le.education),TRIM((SALT30.StrType)le.occupation),TRIM((SALT30.StrType)le.where_worked),TRIM((SALT30.StrType)le.cause),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.dod),TRIM((SALT30.StrType)le.birthplace),TRIM((SALT30.StrType)le.marital_status),TRIM((SALT30.StrType)le.father),TRIM((SALT30.StrType)le.mother),TRIM((SALT30.StrType)le.filed_date),TRIM((SALT30.StrType)le.year),TRIM((SALT30.StrType)le.county_residence),TRIM((SALT30.StrType)le.county_death),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.autopsy),TRIM((SALT30.StrType)le.autopsy_findings),TRIM((SALT30.StrType)le.primary_cause_of_death),TRIM((SALT30.StrType)le.underlying_cause_of_death),TRIM((SALT30.StrType)le.med_exam),TRIM((SALT30.StrType)le.est_lic_no),TRIM((SALT30.StrType)le.disposition),TRIM((SALT30.StrType)le.disposition_date),TRIM((SALT30.StrType)le.work_injury),TRIM((SALT30.StrType)le.injury_date),TRIM((SALT30.StrType)le.injury_type),TRIM((SALT30.StrType)le.injury_location),TRIM((SALT30.StrType)le.surg_performed),TRIM((SALT30.StrType)le.surgery_date),TRIM((SALT30.StrType)le.hospital_status),TRIM((SALT30.StrType)le.pregnancy),TRIM((SALT30.StrType)le.facility_death),TRIM((SALT30.StrType)le.embalmer_lic_no),TRIM((SALT30.StrType)le.death_type),TRIM((SALT30.StrType)le.time_death),TRIM((SALT30.StrType)le.birth_cert),TRIM((SALT30.StrType)le.certifier),TRIM((SALT30.StrType)le.cert_number),TRIM((SALT30.StrType)le.birth_vol_year),TRIM((SALT30.StrType)le.local_file_no),TRIM((SALT30.StrType)le.vdi),TRIM((SALT30.StrType)le.cite_id),TRIM((SALT30.StrType)le.file_id),TRIM((SALT30.StrType)le.date_last_trans),TRIM((SALT30.StrType)le.amendment_code),TRIM((SALT30.StrType)le.amendment_year),TRIM((SALT30.StrType)le._on_lexis),TRIM((SALT30.StrType)le._fs_profile),TRIM((SALT30.StrType)le.us_armed_forces),TRIM((SALT30.StrType)le.place_of_death),TRIM((SALT30.StrType)le.state_death_id),TRIM((SALT30.StrType)le.state_death_flag),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip5),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.fips_state),TRIM((SALT30.StrType)le.fips_county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.orig_address1),TRIM((SALT30.StrType)le.orig_address2),TRIM((SALT30.StrType)le.statefn),TRIM((SALT30.StrType)le.lf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.source_state),TRIM((SALT30.StrType)le.certificate_vol_no),TRIM((SALT30.StrType)le.certificate_vol_year),TRIM((SALT30.StrType)le.publication),TRIM((SALT30.StrType)le.decedent_name),TRIM((SALT30.StrType)le.decedent_race),TRIM((SALT30.StrType)le.decedent_origin),TRIM((SALT30.StrType)le.decedent_sex),TRIM((SALT30.StrType)le.decedent_age),TRIM((SALT30.StrType)le.education),TRIM((SALT30.StrType)le.occupation),TRIM((SALT30.StrType)le.where_worked),TRIM((SALT30.StrType)le.cause),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.dob),TRIM((SALT30.StrType)le.dod),TRIM((SALT30.StrType)le.birthplace),TRIM((SALT30.StrType)le.marital_status),TRIM((SALT30.StrType)le.father),TRIM((SALT30.StrType)le.mother),TRIM((SALT30.StrType)le.filed_date),TRIM((SALT30.StrType)le.year),TRIM((SALT30.StrType)le.county_residence),TRIM((SALT30.StrType)le.county_death),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.autopsy),TRIM((SALT30.StrType)le.autopsy_findings),TRIM((SALT30.StrType)le.primary_cause_of_death),TRIM((SALT30.StrType)le.underlying_cause_of_death),TRIM((SALT30.StrType)le.med_exam),TRIM((SALT30.StrType)le.est_lic_no),TRIM((SALT30.StrType)le.disposition),TRIM((SALT30.StrType)le.disposition_date),TRIM((SALT30.StrType)le.work_injury),TRIM((SALT30.StrType)le.injury_date),TRIM((SALT30.StrType)le.injury_type),TRIM((SALT30.StrType)le.injury_location),TRIM((SALT30.StrType)le.surg_performed),TRIM((SALT30.StrType)le.surgery_date),TRIM((SALT30.StrType)le.hospital_status),TRIM((SALT30.StrType)le.pregnancy),TRIM((SALT30.StrType)le.facility_death),TRIM((SALT30.StrType)le.embalmer_lic_no),TRIM((SALT30.StrType)le.death_type),TRIM((SALT30.StrType)le.time_death),TRIM((SALT30.StrType)le.birth_cert),TRIM((SALT30.StrType)le.certifier),TRIM((SALT30.StrType)le.cert_number),TRIM((SALT30.StrType)le.birth_vol_year),TRIM((SALT30.StrType)le.local_file_no),TRIM((SALT30.StrType)le.vdi),TRIM((SALT30.StrType)le.cite_id),TRIM((SALT30.StrType)le.file_id),TRIM((SALT30.StrType)le.date_last_trans),TRIM((SALT30.StrType)le.amendment_code),TRIM((SALT30.StrType)le.amendment_year),TRIM((SALT30.StrType)le._on_lexis),TRIM((SALT30.StrType)le._fs_profile),TRIM((SALT30.StrType)le.us_armed_forces),TRIM((SALT30.StrType)le.place_of_death),TRIM((SALT30.StrType)le.state_death_id),TRIM((SALT30.StrType)le.state_death_flag),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip5),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.fips_state),TRIM((SALT30.StrType)le.fips_county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.orig_address1),TRIM((SALT30.StrType)le.orig_address2),TRIM((SALT30.StrType)le.statefn),TRIM((SALT30.StrType)le.lf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),101*101,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'source_state'}
      ,{3,'certificate_vol_no'}
      ,{4,'certificate_vol_year'}
      ,{5,'publication'}
      ,{6,'decedent_name'}
      ,{7,'decedent_race'}
      ,{8,'decedent_origin'}
      ,{9,'decedent_sex'}
      ,{10,'decedent_age'}
      ,{11,'education'}
      ,{12,'occupation'}
      ,{13,'where_worked'}
      ,{14,'cause'}
      ,{15,'ssn'}
      ,{16,'dob'}
      ,{17,'dod'}
      ,{18,'birthplace'}
      ,{19,'marital_status'}
      ,{20,'father'}
      ,{21,'mother'}
      ,{22,'filed_date'}
      ,{23,'year'}
      ,{24,'county_residence'}
      ,{25,'county_death'}
      ,{26,'address'}
      ,{27,'autopsy'}
      ,{28,'autopsy_findings'}
      ,{29,'primary_cause_of_death'}
      ,{30,'underlying_cause_of_death'}
      ,{31,'med_exam'}
      ,{32,'est_lic_no'}
      ,{33,'disposition'}
      ,{34,'disposition_date'}
      ,{35,'work_injury'}
      ,{36,'injury_date'}
      ,{37,'injury_type'}
      ,{38,'injury_location'}
      ,{39,'surg_performed'}
      ,{40,'surgery_date'}
      ,{41,'hospital_status'}
      ,{42,'pregnancy'}
      ,{43,'facility_death'}
      ,{44,'embalmer_lic_no'}
      ,{45,'death_type'}
      ,{46,'time_death'}
      ,{47,'birth_cert'}
      ,{48,'certifier'}
      ,{49,'cert_number'}
      ,{50,'birth_vol_year'}
      ,{51,'local_file_no'}
      ,{52,'vdi'}
      ,{53,'cite_id'}
      ,{54,'file_id'}
      ,{55,'date_last_trans'}
      ,{56,'amendment_code'}
      ,{57,'amendment_year'}
      ,{58,'_on_lexis'}
      ,{59,'_fs_profile'}
      ,{60,'us_armed_forces'}
      ,{61,'place_of_death'}
      ,{62,'state_death_id'}
      ,{63,'state_death_flag'}
      ,{64,'title'}
      ,{65,'fname'}
      ,{66,'mname'}
      ,{67,'lname'}
      ,{68,'name_suffix'}
      ,{69,'name_score'}
      ,{70,'prim_range'}
      ,{71,'predir'}
      ,{72,'prim_name'}
      ,{73,'addr_suffix'}
      ,{74,'postdir'}
      ,{75,'unit_desig'}
      ,{76,'sec_range'}
      ,{77,'p_city_name'}
      ,{78,'v_city_name'}
      ,{79,'state'}
      ,{80,'zip5'}
      ,{81,'zip4'}
      ,{82,'cart'}
      ,{83,'cr_sort_sz'}
      ,{84,'lot'}
      ,{85,'lot_order'}
      ,{86,'dpbc'}
      ,{87,'chk_digit'}
      ,{88,'rec_type'}
      ,{89,'fips_state'}
      ,{90,'fips_county'}
      ,{91,'geo_lat'}
      ,{92,'geo_long'}
      ,{93,'msa'}
      ,{94,'geo_blk'}
      ,{95,'geo_match'}
      ,{96,'err_stat'}
      ,{97,'rawaid'}
      ,{98,'orig_address1'}
      ,{99,'orig_address2'}
      ,{100,'statefn'}
      ,{101,'lf'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_state) source_state; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT30.StrType)le.process_date),
    Fields.InValid_source_state((SALT30.StrType)le.source_state),
    Fields.InValid_certificate_vol_no((SALT30.StrType)le.certificate_vol_no),
    Fields.InValid_certificate_vol_year((SALT30.StrType)le.certificate_vol_year),
    Fields.InValid_publication((SALT30.StrType)le.publication),
    Fields.InValid_decedent_name((SALT30.StrType)le.decedent_name),
    Fields.InValid_decedent_race((SALT30.StrType)le.decedent_race),
    Fields.InValid_decedent_origin((SALT30.StrType)le.decedent_origin),
    Fields.InValid_decedent_sex((SALT30.StrType)le.decedent_sex),
    Fields.InValid_decedent_age((SALT30.StrType)le.decedent_age),
    Fields.InValid_education((SALT30.StrType)le.education),
    Fields.InValid_occupation((SALT30.StrType)le.occupation),
    Fields.InValid_where_worked((SALT30.StrType)le.where_worked),
    Fields.InValid_cause((SALT30.StrType)le.cause),
    Fields.InValid_ssn((SALT30.StrType)le.ssn),
    Fields.InValid_dob((SALT30.StrType)le.dob),
    Fields.InValid_dod((SALT30.StrType)le.dod),
    Fields.InValid_birthplace((SALT30.StrType)le.birthplace),
    Fields.InValid_marital_status((SALT30.StrType)le.marital_status),
    Fields.InValid_father((SALT30.StrType)le.father),
    Fields.InValid_mother((SALT30.StrType)le.mother),
    Fields.InValid_filed_date((SALT30.StrType)le.filed_date),
    Fields.InValid_year((SALT30.StrType)le.year),
    Fields.InValid_county_residence((SALT30.StrType)le.county_residence),
    Fields.InValid_county_death((SALT30.StrType)le.county_death),
    Fields.InValid_address((SALT30.StrType)le.address),
    Fields.InValid_autopsy((SALT30.StrType)le.autopsy),
    Fields.InValid_autopsy_findings((SALT30.StrType)le.autopsy_findings),
    Fields.InValid_primary_cause_of_death((SALT30.StrType)le.primary_cause_of_death),
    Fields.InValid_underlying_cause_of_death((SALT30.StrType)le.underlying_cause_of_death),
    Fields.InValid_med_exam((SALT30.StrType)le.med_exam),
    Fields.InValid_est_lic_no((SALT30.StrType)le.est_lic_no),
    Fields.InValid_disposition((SALT30.StrType)le.disposition),
    Fields.InValid_disposition_date((SALT30.StrType)le.disposition_date),
    Fields.InValid_work_injury((SALT30.StrType)le.work_injury),
    Fields.InValid_injury_date((SALT30.StrType)le.injury_date),
    Fields.InValid_injury_type((SALT30.StrType)le.injury_type),
    Fields.InValid_injury_location((SALT30.StrType)le.injury_location),
    Fields.InValid_surg_performed((SALT30.StrType)le.surg_performed),
    Fields.InValid_surgery_date((SALT30.StrType)le.surgery_date),
    Fields.InValid_hospital_status((SALT30.StrType)le.hospital_status),
    Fields.InValid_pregnancy((SALT30.StrType)le.pregnancy),
    Fields.InValid_facility_death((SALT30.StrType)le.facility_death),
    Fields.InValid_embalmer_lic_no((SALT30.StrType)le.embalmer_lic_no),
    Fields.InValid_death_type((SALT30.StrType)le.death_type),
    Fields.InValid_time_death((SALT30.StrType)le.time_death),
    Fields.InValid_birth_cert((SALT30.StrType)le.birth_cert),
    Fields.InValid_certifier((SALT30.StrType)le.certifier),
    Fields.InValid_cert_number((SALT30.StrType)le.cert_number),
    Fields.InValid_birth_vol_year((SALT30.StrType)le.birth_vol_year),
    Fields.InValid_local_file_no((SALT30.StrType)le.local_file_no),
    Fields.InValid_vdi((SALT30.StrType)le.vdi),
    Fields.InValid_cite_id((SALT30.StrType)le.cite_id),
    Fields.InValid_file_id((SALT30.StrType)le.file_id),
    Fields.InValid_date_last_trans((SALT30.StrType)le.date_last_trans),
    Fields.InValid_amendment_code((SALT30.StrType)le.amendment_code),
    Fields.InValid_amendment_year((SALT30.StrType)le.amendment_year),
    Fields.InValid__on_lexis((SALT30.StrType)le._on_lexis),
    Fields.InValid__fs_profile((SALT30.StrType)le._fs_profile),
    Fields.InValid_us_armed_forces((SALT30.StrType)le.us_armed_forces),
    Fields.InValid_place_of_death((SALT30.StrType)le.place_of_death),
    Fields.InValid_state_death_id((SALT30.StrType)le.state_death_id),
    Fields.InValid_state_death_flag((SALT30.StrType)le.state_death_flag),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT30.StrType)le.name_score),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_zip5((SALT30.StrType)le.zip5),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_cart((SALT30.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT30.StrType)le.lot),
    Fields.InValid_lot_order((SALT30.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT30.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_fips_state((SALT30.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT30.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT30.StrType)le.geo_long),
    Fields.InValid_msa((SALT30.StrType)le.msa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT30.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT30.StrType)le.err_stat),
    Fields.InValid_rawaid((SALT30.StrType)le.rawaid),
    Fields.InValid_orig_address1((SALT30.StrType)le.orig_address1),
    Fields.InValid_orig_address2((SALT30.StrType)le.orig_address2),
    Fields.InValid_statefn((SALT30.StrType)le.statefn),
    Fields.InValid_lf((SALT30.StrType)le.lf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_state := le.source_state;
END;
Errors := NORMALIZE(h,101,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_state;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_state,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_state;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_process_date','invalid_source_state','invalid_certificate_vol_no','invalid_certificate_vol_year','invalid_publication','invalid_decedent_name','invalid_decedent_race','invalid_decedent_origin','invalid_decedent_sex','invalid_decedent_age','invalid_education','invalid_occupation','invalid_where_worked','invalid_cause','invalid_ssn','invalid_date','invalid_date','invalid_birthplace','invalid_marital_status','invalid_parent_name','invalid_parent_name','invalid_date','invalid_year','invalid_county_residence','invalid_county_death','invalid_address','invalid_autopsy','invalid_autopsy_findings','invalid_primary_cause_of_death','invalid_underlying_cause_of_death','invalid_med_exam','invalid_est_lic_no','invalid_disposition','invalid_date','invalid_work_injury','invalid_injury_date','invalid_injury_type','invalid_injury_location','invalid_surg_performed','invalid_date','invalid_hospital_status','invalid_pregnancy','invalid_facility_death','invalid_embalmer_lic_no','invalid_death_type','invalid_time_death','invalid_birth_cert','invalid_certifier','invalid_cert_number','invalid_year','invalid_local_file_no','invalid_vdi','invalid_cite_id','invalid_file_id','invalid_date','invalid_amendment_code','invalid_amendment_year','invalid__on_lexis','invalid__fs_profile','invalid_us_armed_forces','invalid_place_of_death','invalid_state_death_id','invalid_state_death_flag','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name_score','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_addr_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_p_city_name','invalid_v_city_name','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fipsstate','invalid_fipscounty','invalid_geo_lat','invalid_geo_long','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_rawaid','invalid_address','invalid_address','invalid_statefn','invalid_lf');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_source_state(TotalErrors.ErrorNum),Fields.InValidMessage_certificate_vol_no(TotalErrors.ErrorNum),Fields.InValidMessage_certificate_vol_year(TotalErrors.ErrorNum),Fields.InValidMessage_publication(TotalErrors.ErrorNum),Fields.InValidMessage_decedent_name(TotalErrors.ErrorNum),Fields.InValidMessage_decedent_race(TotalErrors.ErrorNum),Fields.InValidMessage_decedent_origin(TotalErrors.ErrorNum),Fields.InValidMessage_decedent_sex(TotalErrors.ErrorNum),Fields.InValidMessage_decedent_age(TotalErrors.ErrorNum),Fields.InValidMessage_education(TotalErrors.ErrorNum),Fields.InValidMessage_occupation(TotalErrors.ErrorNum),Fields.InValidMessage_where_worked(TotalErrors.ErrorNum),Fields.InValidMessage_cause(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_dod(TotalErrors.ErrorNum),Fields.InValidMessage_birthplace(TotalErrors.ErrorNum),Fields.InValidMessage_marital_status(TotalErrors.ErrorNum),Fields.InValidMessage_father(TotalErrors.ErrorNum),Fields.InValidMessage_mother(TotalErrors.ErrorNum),Fields.InValidMessage_filed_date(TotalErrors.ErrorNum),Fields.InValidMessage_year(TotalErrors.ErrorNum),Fields.InValidMessage_county_residence(TotalErrors.ErrorNum),Fields.InValidMessage_county_death(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_autopsy(TotalErrors.ErrorNum),Fields.InValidMessage_autopsy_findings(TotalErrors.ErrorNum),Fields.InValidMessage_primary_cause_of_death(TotalErrors.ErrorNum),Fields.InValidMessage_underlying_cause_of_death(TotalErrors.ErrorNum),Fields.InValidMessage_med_exam(TotalErrors.ErrorNum),Fields.InValidMessage_est_lic_no(TotalErrors.ErrorNum),Fields.InValidMessage_disposition(TotalErrors.ErrorNum),Fields.InValidMessage_disposition_date(TotalErrors.ErrorNum),Fields.InValidMessage_work_injury(TotalErrors.ErrorNum),Fields.InValidMessage_injury_date(TotalErrors.ErrorNum),Fields.InValidMessage_injury_type(TotalErrors.ErrorNum),Fields.InValidMessage_injury_location(TotalErrors.ErrorNum),Fields.InValidMessage_surg_performed(TotalErrors.ErrorNum),Fields.InValidMessage_surgery_date(TotalErrors.ErrorNum),Fields.InValidMessage_hospital_status(TotalErrors.ErrorNum),Fields.InValidMessage_pregnancy(TotalErrors.ErrorNum),Fields.InValidMessage_facility_death(TotalErrors.ErrorNum),Fields.InValidMessage_embalmer_lic_no(TotalErrors.ErrorNum),Fields.InValidMessage_death_type(TotalErrors.ErrorNum),Fields.InValidMessage_time_death(TotalErrors.ErrorNum),Fields.InValidMessage_birth_cert(TotalErrors.ErrorNum),Fields.InValidMessage_certifier(TotalErrors.ErrorNum),Fields.InValidMessage_cert_number(TotalErrors.ErrorNum),Fields.InValidMessage_birth_vol_year(TotalErrors.ErrorNum),Fields.InValidMessage_local_file_no(TotalErrors.ErrorNum),Fields.InValidMessage_vdi(TotalErrors.ErrorNum),Fields.InValidMessage_cite_id(TotalErrors.ErrorNum),Fields.InValidMessage_file_id(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_trans(TotalErrors.ErrorNum),Fields.InValidMessage_amendment_code(TotalErrors.ErrorNum),Fields.InValidMessage_amendment_year(TotalErrors.ErrorNum),Fields.InValidMessage__on_lexis(TotalErrors.ErrorNum),Fields.InValidMessage__fs_profile(TotalErrors.ErrorNum),Fields.InValidMessage_us_armed_forces(TotalErrors.ErrorNum),Fields.InValidMessage_place_of_death(TotalErrors.ErrorNum),Fields.InValidMessage_state_death_id(TotalErrors.ErrorNum),Fields.InValidMessage_state_death_flag(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2(TotalErrors.ErrorNum),Fields.InValidMessage_statefn(TotalErrors.ErrorNum),Fields.InValidMessage_lf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_state=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
