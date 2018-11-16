IMPORT SALT311,STD;
EXPORT Experian_hygiene(dataset(Experian_layout_VehicleV2) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.append_state_origin))'', MAX(GROUP,h.append_state_origin));
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_cnt := COUNT(GROUP,h.append_process_date <> (TYPEOF(h.append_process_date))'');
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_append_state_origin_cnt := COUNT(GROUP,h.append_state_origin <> (TYPEOF(h.append_state_origin))'');
    populated_append_state_origin_pcnt := AVE(GROUP,IF(h.append_state_origin = (TYPEOF(h.append_state_origin))'',0,100));
    maxlength_append_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_state_origin)));
    avelength_append_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_state_origin)),h.append_state_origin<>(typeof(h.append_state_origin))'');
    populated_file_typ_cnt := COUNT(GROUP,h.file_typ <> (TYPEOF(h.file_typ))'');
    populated_file_typ_pcnt := AVE(GROUP,IF(h.file_typ = (TYPEOF(h.file_typ))'',0,100));
    maxlength_file_typ := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_typ)));
    avelength_file_typ := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_typ)),h.file_typ<>(typeof(h.file_typ))'');
    populated_vin_cnt := COUNT(GROUP,h.vin <> (TYPEOF(h.vin))'');
    populated_vin_pcnt := AVE(GROUP,IF(h.vin = (TYPEOF(h.vin))'',0,100));
    maxlength_vin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin)));
    avelength_vin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin)),h.vin<>(typeof(h.vin))'');
    populated_vehicle_typ_cnt := COUNT(GROUP,h.vehicle_typ <> (TYPEOF(h.vehicle_typ))'');
    populated_vehicle_typ_pcnt := AVE(GROUP,IF(h.vehicle_typ = (TYPEOF(h.vehicle_typ))'',0,100));
    maxlength_vehicle_typ := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicle_typ)));
    avelength_vehicle_typ := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicle_typ)),h.vehicle_typ<>(typeof(h.vehicle_typ))'');
    populated_model_yr_cnt := COUNT(GROUP,h.model_yr <> (TYPEOF(h.model_yr))'');
    populated_model_yr_pcnt := AVE(GROUP,IF(h.model_yr = (TYPEOF(h.model_yr))'',0,100));
    maxlength_model_yr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_yr)));
    avelength_model_yr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_yr)),h.model_yr<>(typeof(h.model_yr))'');
    populated_model_yr_ind_cnt := COUNT(GROUP,h.model_yr_ind <> (TYPEOF(h.model_yr_ind))'');
    populated_model_yr_ind_pcnt := AVE(GROUP,IF(h.model_yr_ind = (TYPEOF(h.model_yr_ind))'',0,100));
    maxlength_model_yr_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_yr_ind)));
    avelength_model_yr_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_yr_ind)),h.model_yr_ind<>(typeof(h.model_yr_ind))'');
    populated_make_cnt := COUNT(GROUP,h.make <> (TYPEOF(h.make))'');
    populated_make_pcnt := AVE(GROUP,IF(h.make = (TYPEOF(h.make))'',0,100));
    maxlength_make := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.make)));
    avelength_make := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.make)),h.make<>(typeof(h.make))'');
    populated_make_ind_cnt := COUNT(GROUP,h.make_ind <> (TYPEOF(h.make_ind))'');
    populated_make_ind_pcnt := AVE(GROUP,IF(h.make_ind = (TYPEOF(h.make_ind))'',0,100));
    maxlength_make_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.make_ind)));
    avelength_make_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.make_ind)),h.make_ind<>(typeof(h.make_ind))'');
    populated_series_cnt := COUNT(GROUP,h.series <> (TYPEOF(h.series))'');
    populated_series_pcnt := AVE(GROUP,IF(h.series = (TYPEOF(h.series))'',0,100));
    maxlength_series := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.series)));
    avelength_series := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.series)),h.series<>(typeof(h.series))'');
    populated_series_ind_cnt := COUNT(GROUP,h.series_ind <> (TYPEOF(h.series_ind))'');
    populated_series_ind_pcnt := AVE(GROUP,IF(h.series_ind = (TYPEOF(h.series_ind))'',0,100));
    maxlength_series_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_ind)));
    avelength_series_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_ind)),h.series_ind<>(typeof(h.series_ind))'');
    populated_prime_color_cnt := COUNT(GROUP,h.prime_color <> (TYPEOF(h.prime_color))'');
    populated_prime_color_pcnt := AVE(GROUP,IF(h.prime_color = (TYPEOF(h.prime_color))'',0,100));
    maxlength_prime_color := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prime_color)));
    avelength_prime_color := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prime_color)),h.prime_color<>(typeof(h.prime_color))'');
    populated_second_color_cnt := COUNT(GROUP,h.second_color <> (TYPEOF(h.second_color))'');
    populated_second_color_pcnt := AVE(GROUP,IF(h.second_color = (TYPEOF(h.second_color))'',0,100));
    maxlength_second_color := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_color)));
    avelength_second_color := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_color)),h.second_color<>(typeof(h.second_color))'');
    populated_body_style_cnt := COUNT(GROUP,h.body_style <> (TYPEOF(h.body_style))'');
    populated_body_style_pcnt := AVE(GROUP,IF(h.body_style = (TYPEOF(h.body_style))'',0,100));
    maxlength_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.body_style)));
    avelength_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.body_style)),h.body_style<>(typeof(h.body_style))'');
    populated_body_style_ind_cnt := COUNT(GROUP,h.body_style_ind <> (TYPEOF(h.body_style_ind))'');
    populated_body_style_ind_pcnt := AVE(GROUP,IF(h.body_style_ind = (TYPEOF(h.body_style_ind))'',0,100));
    maxlength_body_style_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.body_style_ind)));
    avelength_body_style_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.body_style_ind)),h.body_style_ind<>(typeof(h.body_style_ind))'');
    populated_model_cnt := COUNT(GROUP,h.model <> (TYPEOF(h.model))'');
    populated_model_pcnt := AVE(GROUP,IF(h.model = (TYPEOF(h.model))'',0,100));
    maxlength_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)));
    avelength_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)),h.model<>(typeof(h.model))'');
    populated_model_ind_cnt := COUNT(GROUP,h.model_ind <> (TYPEOF(h.model_ind))'');
    populated_model_ind_pcnt := AVE(GROUP,IF(h.model_ind = (TYPEOF(h.model_ind))'',0,100));
    maxlength_model_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_ind)));
    avelength_model_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_ind)),h.model_ind<>(typeof(h.model_ind))'');
    populated_weight_cnt := COUNT(GROUP,h.weight <> (TYPEOF(h.weight))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_lengt_cnt := COUNT(GROUP,h.lengt <> (TYPEOF(h.lengt))'');
    populated_lengt_pcnt := AVE(GROUP,IF(h.lengt = (TYPEOF(h.lengt))'',0,100));
    maxlength_lengt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lengt)));
    avelength_lengt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lengt)),h.lengt<>(typeof(h.lengt))'');
    populated_axle_cnt_cnt := COUNT(GROUP,h.axle_cnt <> (TYPEOF(h.axle_cnt))'');
    populated_axle_cnt_pcnt := AVE(GROUP,IF(h.axle_cnt = (TYPEOF(h.axle_cnt))'',0,100));
    maxlength_axle_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.axle_cnt)));
    avelength_axle_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.axle_cnt)),h.axle_cnt<>(typeof(h.axle_cnt))'');
    populated_plate_nbr_cnt := COUNT(GROUP,h.plate_nbr <> (TYPEOF(h.plate_nbr))'');
    populated_plate_nbr_pcnt := AVE(GROUP,IF(h.plate_nbr = (TYPEOF(h.plate_nbr))'',0,100));
    maxlength_plate_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plate_nbr)));
    avelength_plate_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plate_nbr)),h.plate_nbr<>(typeof(h.plate_nbr))'');
    populated_plate_state_cnt := COUNT(GROUP,h.plate_state <> (TYPEOF(h.plate_state))'');
    populated_plate_state_pcnt := AVE(GROUP,IF(h.plate_state = (TYPEOF(h.plate_state))'',0,100));
    maxlength_plate_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plate_state)));
    avelength_plate_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plate_state)),h.plate_state<>(typeof(h.plate_state))'');
    populated_prev_plate_nbr_cnt := COUNT(GROUP,h.prev_plate_nbr <> (TYPEOF(h.prev_plate_nbr))'');
    populated_prev_plate_nbr_pcnt := AVE(GROUP,IF(h.prev_plate_nbr = (TYPEOF(h.prev_plate_nbr))'',0,100));
    maxlength_prev_plate_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prev_plate_nbr)));
    avelength_prev_plate_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prev_plate_nbr)),h.prev_plate_nbr<>(typeof(h.prev_plate_nbr))'');
    populated_prev_plate_state_cnt := COUNT(GROUP,h.prev_plate_state <> (TYPEOF(h.prev_plate_state))'');
    populated_prev_plate_state_pcnt := AVE(GROUP,IF(h.prev_plate_state = (TYPEOF(h.prev_plate_state))'',0,100));
    maxlength_prev_plate_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prev_plate_state)));
    avelength_prev_plate_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prev_plate_state)),h.prev_plate_state<>(typeof(h.prev_plate_state))'');
    populated_plate_typ_cd_cnt := COUNT(GROUP,h.plate_typ_cd <> (TYPEOF(h.plate_typ_cd))'');
    populated_plate_typ_cd_pcnt := AVE(GROUP,IF(h.plate_typ_cd = (TYPEOF(h.plate_typ_cd))'',0,100));
    maxlength_plate_typ_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plate_typ_cd)));
    avelength_plate_typ_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plate_typ_cd)),h.plate_typ_cd<>(typeof(h.plate_typ_cd))'');
    populated_mstr_src_state_cnt := COUNT(GROUP,h.mstr_src_state <> (TYPEOF(h.mstr_src_state))'');
    populated_mstr_src_state_pcnt := AVE(GROUP,IF(h.mstr_src_state = (TYPEOF(h.mstr_src_state))'',0,100));
    maxlength_mstr_src_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mstr_src_state)));
    avelength_mstr_src_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mstr_src_state)),h.mstr_src_state<>(typeof(h.mstr_src_state))'');
    populated_reg_decal_nbr_cnt := COUNT(GROUP,h.reg_decal_nbr <> (TYPEOF(h.reg_decal_nbr))'');
    populated_reg_decal_nbr_pcnt := AVE(GROUP,IF(h.reg_decal_nbr = (TYPEOF(h.reg_decal_nbr))'',0,100));
    maxlength_reg_decal_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_decal_nbr)));
    avelength_reg_decal_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_decal_nbr)),h.reg_decal_nbr<>(typeof(h.reg_decal_nbr))'');
    populated_org_reg_dt_cnt := COUNT(GROUP,h.org_reg_dt <> (TYPEOF(h.org_reg_dt))'');
    populated_org_reg_dt_pcnt := AVE(GROUP,IF(h.org_reg_dt = (TYPEOF(h.org_reg_dt))'',0,100));
    maxlength_org_reg_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.org_reg_dt)));
    avelength_org_reg_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.org_reg_dt)),h.org_reg_dt<>(typeof(h.org_reg_dt))'');
    populated_reg_renew_dt_cnt := COUNT(GROUP,h.reg_renew_dt <> (TYPEOF(h.reg_renew_dt))'');
    populated_reg_renew_dt_pcnt := AVE(GROUP,IF(h.reg_renew_dt = (TYPEOF(h.reg_renew_dt))'',0,100));
    maxlength_reg_renew_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_renew_dt)));
    avelength_reg_renew_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_renew_dt)),h.reg_renew_dt<>(typeof(h.reg_renew_dt))'');
    populated_reg_exp_dt_cnt := COUNT(GROUP,h.reg_exp_dt <> (TYPEOF(h.reg_exp_dt))'');
    populated_reg_exp_dt_pcnt := AVE(GROUP,IF(h.reg_exp_dt = (TYPEOF(h.reg_exp_dt))'',0,100));
    maxlength_reg_exp_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_exp_dt)));
    avelength_reg_exp_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reg_exp_dt)),h.reg_exp_dt<>(typeof(h.reg_exp_dt))'');
    populated_title_nbr_cnt := COUNT(GROUP,h.title_nbr <> (TYPEOF(h.title_nbr))'');
    populated_title_nbr_pcnt := AVE(GROUP,IF(h.title_nbr = (TYPEOF(h.title_nbr))'',0,100));
    maxlength_title_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_nbr)));
    avelength_title_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_nbr)),h.title_nbr<>(typeof(h.title_nbr))'');
    populated_org_title_dt_cnt := COUNT(GROUP,h.org_title_dt <> (TYPEOF(h.org_title_dt))'');
    populated_org_title_dt_pcnt := AVE(GROUP,IF(h.org_title_dt = (TYPEOF(h.org_title_dt))'',0,100));
    maxlength_org_title_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.org_title_dt)));
    avelength_org_title_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.org_title_dt)),h.org_title_dt<>(typeof(h.org_title_dt))'');
    populated_title_trans_dt_cnt := COUNT(GROUP,h.title_trans_dt <> (TYPEOF(h.title_trans_dt))'');
    populated_title_trans_dt_pcnt := AVE(GROUP,IF(h.title_trans_dt = (TYPEOF(h.title_trans_dt))'',0,100));
    maxlength_title_trans_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_trans_dt)));
    avelength_title_trans_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_trans_dt)),h.title_trans_dt<>(typeof(h.title_trans_dt))'');
    populated_name_typ_cd_cnt := COUNT(GROUP,h.name_typ_cd <> (TYPEOF(h.name_typ_cd))'');
    populated_name_typ_cd_pcnt := AVE(GROUP,IF(h.name_typ_cd = (TYPEOF(h.name_typ_cd))'',0,100));
    maxlength_name_typ_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_typ_cd)));
    avelength_name_typ_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_typ_cd)),h.name_typ_cd<>(typeof(h.name_typ_cd))'');
    populated_owner_typ_cd_cnt := COUNT(GROUP,h.owner_typ_cd <> (TYPEOF(h.owner_typ_cd))'');
    populated_owner_typ_cd_pcnt := AVE(GROUP,IF(h.owner_typ_cd = (TYPEOF(h.owner_typ_cd))'',0,100));
    maxlength_owner_typ_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_typ_cd)));
    avelength_owner_typ_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_typ_cd)),h.owner_typ_cd<>(typeof(h.owner_typ_cd))'');
    populated_first_nm_cnt := COUNT(GROUP,h.first_nm <> (TYPEOF(h.first_nm))'');
    populated_first_nm_pcnt := AVE(GROUP,IF(h.first_nm = (TYPEOF(h.first_nm))'',0,100));
    maxlength_first_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_nm)));
    avelength_first_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_nm)),h.first_nm<>(typeof(h.first_nm))'');
    populated_middle_nm_cnt := COUNT(GROUP,h.middle_nm <> (TYPEOF(h.middle_nm))'');
    populated_middle_nm_pcnt := AVE(GROUP,IF(h.middle_nm = (TYPEOF(h.middle_nm))'',0,100));
    maxlength_middle_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_nm)));
    avelength_middle_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_nm)),h.middle_nm<>(typeof(h.middle_nm))'');
    populated_last_nm_cnt := COUNT(GROUP,h.last_nm <> (TYPEOF(h.last_nm))'');
    populated_last_nm_pcnt := AVE(GROUP,IF(h.last_nm = (TYPEOF(h.last_nm))'',0,100));
    maxlength_last_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_nm)));
    avelength_last_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_nm)),h.last_nm<>(typeof(h.last_nm))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_prof_suffix_cnt := COUNT(GROUP,h.prof_suffix <> (TYPEOF(h.prof_suffix))'');
    populated_prof_suffix_pcnt := AVE(GROUP,IF(h.prof_suffix = (TYPEOF(h.prof_suffix))'',0,100));
    maxlength_prof_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prof_suffix)));
    avelength_prof_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prof_suffix)),h.prof_suffix<>(typeof(h.prof_suffix))'');
    populated_ind_ssn_cnt := COUNT(GROUP,h.ind_ssn <> (TYPEOF(h.ind_ssn))'');
    populated_ind_ssn_pcnt := AVE(GROUP,IF(h.ind_ssn = (TYPEOF(h.ind_ssn))'',0,100));
    maxlength_ind_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_ssn)));
    avelength_ind_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_ssn)),h.ind_ssn<>(typeof(h.ind_ssn))'');
    populated_ind_dob_cnt := COUNT(GROUP,h.ind_dob <> (TYPEOF(h.ind_dob))'');
    populated_ind_dob_pcnt := AVE(GROUP,IF(h.ind_dob = (TYPEOF(h.ind_dob))'',0,100));
    maxlength_ind_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_dob)));
    avelength_ind_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ind_dob)),h.ind_dob<>(typeof(h.ind_dob))'');
    populated_mail_range_cnt := COUNT(GROUP,h.mail_range <> (TYPEOF(h.mail_range))'');
    populated_mail_range_pcnt := AVE(GROUP,IF(h.mail_range = (TYPEOF(h.mail_range))'',0,100));
    maxlength_mail_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_range)));
    avelength_mail_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_range)),h.mail_range<>(typeof(h.mail_range))'');
    populated_m_pre_dir_cnt := COUNT(GROUP,h.m_pre_dir <> (TYPEOF(h.m_pre_dir))'');
    populated_m_pre_dir_pcnt := AVE(GROUP,IF(h.m_pre_dir = (TYPEOF(h.m_pre_dir))'',0,100));
    maxlength_m_pre_dir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_pre_dir)));
    avelength_m_pre_dir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_pre_dir)),h.m_pre_dir<>(typeof(h.m_pre_dir))'');
    populated_m_street_cnt := COUNT(GROUP,h.m_street <> (TYPEOF(h.m_street))'');
    populated_m_street_pcnt := AVE(GROUP,IF(h.m_street = (TYPEOF(h.m_street))'',0,100));
    maxlength_m_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_street)));
    avelength_m_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_street)),h.m_street<>(typeof(h.m_street))'');
    populated_m_suffix_cnt := COUNT(GROUP,h.m_suffix <> (TYPEOF(h.m_suffix))'');
    populated_m_suffix_pcnt := AVE(GROUP,IF(h.m_suffix = (TYPEOF(h.m_suffix))'',0,100));
    maxlength_m_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_suffix)));
    avelength_m_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_suffix)),h.m_suffix<>(typeof(h.m_suffix))'');
    populated_m_post_dir_cnt := COUNT(GROUP,h.m_post_dir <> (TYPEOF(h.m_post_dir))'');
    populated_m_post_dir_pcnt := AVE(GROUP,IF(h.m_post_dir = (TYPEOF(h.m_post_dir))'',0,100));
    maxlength_m_post_dir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_post_dir)));
    avelength_m_post_dir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_post_dir)),h.m_post_dir<>(typeof(h.m_post_dir))'');
    populated_m_pob_cnt := COUNT(GROUP,h.m_pob <> (TYPEOF(h.m_pob))'');
    populated_m_pob_pcnt := AVE(GROUP,IF(h.m_pob = (TYPEOF(h.m_pob))'',0,100));
    maxlength_m_pob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_pob)));
    avelength_m_pob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_pob)),h.m_pob<>(typeof(h.m_pob))'');
    populated_m_rr_nbr_cnt := COUNT(GROUP,h.m_rr_nbr <> (TYPEOF(h.m_rr_nbr))'');
    populated_m_rr_nbr_pcnt := AVE(GROUP,IF(h.m_rr_nbr = (TYPEOF(h.m_rr_nbr))'',0,100));
    maxlength_m_rr_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_rr_nbr)));
    avelength_m_rr_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_rr_nbr)),h.m_rr_nbr<>(typeof(h.m_rr_nbr))'');
    populated_m_rr_box_cnt := COUNT(GROUP,h.m_rr_box <> (TYPEOF(h.m_rr_box))'');
    populated_m_rr_box_pcnt := AVE(GROUP,IF(h.m_rr_box = (TYPEOF(h.m_rr_box))'',0,100));
    maxlength_m_rr_box := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_rr_box)));
    avelength_m_rr_box := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_rr_box)),h.m_rr_box<>(typeof(h.m_rr_box))'');
    populated_m_scndry_rng_cnt := COUNT(GROUP,h.m_scndry_rng <> (TYPEOF(h.m_scndry_rng))'');
    populated_m_scndry_rng_pcnt := AVE(GROUP,IF(h.m_scndry_rng = (TYPEOF(h.m_scndry_rng))'',0,100));
    maxlength_m_scndry_rng := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_scndry_rng)));
    avelength_m_scndry_rng := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_scndry_rng)),h.m_scndry_rng<>(typeof(h.m_scndry_rng))'');
    populated_m_scndry_des_cnt := COUNT(GROUP,h.m_scndry_des <> (TYPEOF(h.m_scndry_des))'');
    populated_m_scndry_des_pcnt := AVE(GROUP,IF(h.m_scndry_des = (TYPEOF(h.m_scndry_des))'',0,100));
    maxlength_m_scndry_des := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_scndry_des)));
    avelength_m_scndry_des := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_scndry_des)),h.m_scndry_des<>(typeof(h.m_scndry_des))'');
    populated_m_city_cnt := COUNT(GROUP,h.m_city <> (TYPEOF(h.m_city))'');
    populated_m_city_pcnt := AVE(GROUP,IF(h.m_city = (TYPEOF(h.m_city))'',0,100));
    maxlength_m_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_city)));
    avelength_m_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_city)),h.m_city<>(typeof(h.m_city))'');
    populated_m_state_cnt := COUNT(GROUP,h.m_state <> (TYPEOF(h.m_state))'');
    populated_m_state_pcnt := AVE(GROUP,IF(h.m_state = (TYPEOF(h.m_state))'',0,100));
    maxlength_m_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_state)));
    avelength_m_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_state)),h.m_state<>(typeof(h.m_state))'');
    populated_m_zip5_cnt := COUNT(GROUP,h.m_zip5 <> (TYPEOF(h.m_zip5))'');
    populated_m_zip5_pcnt := AVE(GROUP,IF(h.m_zip5 = (TYPEOF(h.m_zip5))'',0,100));
    maxlength_m_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_zip5)));
    avelength_m_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_zip5)),h.m_zip5<>(typeof(h.m_zip5))'');
    populated_m_zip4_cnt := COUNT(GROUP,h.m_zip4 <> (TYPEOF(h.m_zip4))'');
    populated_m_zip4_pcnt := AVE(GROUP,IF(h.m_zip4 = (TYPEOF(h.m_zip4))'',0,100));
    maxlength_m_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_zip4)));
    avelength_m_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_zip4)),h.m_zip4<>(typeof(h.m_zip4))'');
    populated_m_cntry_cd_cnt := COUNT(GROUP,h.m_cntry_cd <> (TYPEOF(h.m_cntry_cd))'');
    populated_m_cntry_cd_pcnt := AVE(GROUP,IF(h.m_cntry_cd = (TYPEOF(h.m_cntry_cd))'',0,100));
    maxlength_m_cntry_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_cntry_cd)));
    avelength_m_cntry_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_cntry_cd)),h.m_cntry_cd<>(typeof(h.m_cntry_cd))'');
    populated_m_cc_filler_cnt := COUNT(GROUP,h.m_cc_filler <> (TYPEOF(h.m_cc_filler))'');
    populated_m_cc_filler_pcnt := AVE(GROUP,IF(h.m_cc_filler = (TYPEOF(h.m_cc_filler))'',0,100));
    maxlength_m_cc_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_cc_filler)));
    avelength_m_cc_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_cc_filler)),h.m_cc_filler<>(typeof(h.m_cc_filler))'');
    populated_m_cc_cnt := COUNT(GROUP,h.m_cc <> (TYPEOF(h.m_cc))'');
    populated_m_cc_pcnt := AVE(GROUP,IF(h.m_cc = (TYPEOF(h.m_cc))'',0,100));
    maxlength_m_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_cc)));
    avelength_m_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_cc)),h.m_cc<>(typeof(h.m_cc))'');
    populated_m_county_cnt := COUNT(GROUP,h.m_county <> (TYPEOF(h.m_county))'');
    populated_m_county_pcnt := AVE(GROUP,IF(h.m_county = (TYPEOF(h.m_county))'',0,100));
    maxlength_m_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_county)));
    avelength_m_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.m_county)),h.m_county<>(typeof(h.m_county))'');
    populated_phys_range_cnt := COUNT(GROUP,h.phys_range <> (TYPEOF(h.phys_range))'');
    populated_phys_range_pcnt := AVE(GROUP,IF(h.phys_range = (TYPEOF(h.phys_range))'',0,100));
    maxlength_phys_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phys_range)));
    avelength_phys_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phys_range)),h.phys_range<>(typeof(h.phys_range))'');
    populated_p_pre_dir_cnt := COUNT(GROUP,h.p_pre_dir <> (TYPEOF(h.p_pre_dir))'');
    populated_p_pre_dir_pcnt := AVE(GROUP,IF(h.p_pre_dir = (TYPEOF(h.p_pre_dir))'',0,100));
    maxlength_p_pre_dir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_pre_dir)));
    avelength_p_pre_dir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_pre_dir)),h.p_pre_dir<>(typeof(h.p_pre_dir))'');
    populated_p_street_cnt := COUNT(GROUP,h.p_street <> (TYPEOF(h.p_street))'');
    populated_p_street_pcnt := AVE(GROUP,IF(h.p_street = (TYPEOF(h.p_street))'',0,100));
    maxlength_p_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_street)));
    avelength_p_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_street)),h.p_street<>(typeof(h.p_street))'');
    populated_p_suffix_cnt := COUNT(GROUP,h.p_suffix <> (TYPEOF(h.p_suffix))'');
    populated_p_suffix_pcnt := AVE(GROUP,IF(h.p_suffix = (TYPEOF(h.p_suffix))'',0,100));
    maxlength_p_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_suffix)));
    avelength_p_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_suffix)),h.p_suffix<>(typeof(h.p_suffix))'');
    populated_p_post_dir_cnt := COUNT(GROUP,h.p_post_dir <> (TYPEOF(h.p_post_dir))'');
    populated_p_post_dir_pcnt := AVE(GROUP,IF(h.p_post_dir = (TYPEOF(h.p_post_dir))'',0,100));
    maxlength_p_post_dir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_post_dir)));
    avelength_p_post_dir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_post_dir)),h.p_post_dir<>(typeof(h.p_post_dir))'');
    populated_p_pob_cnt := COUNT(GROUP,h.p_pob <> (TYPEOF(h.p_pob))'');
    populated_p_pob_pcnt := AVE(GROUP,IF(h.p_pob = (TYPEOF(h.p_pob))'',0,100));
    maxlength_p_pob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_pob)));
    avelength_p_pob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_pob)),h.p_pob<>(typeof(h.p_pob))'');
    populated_p_rr_nbr_cnt := COUNT(GROUP,h.p_rr_nbr <> (TYPEOF(h.p_rr_nbr))'');
    populated_p_rr_nbr_pcnt := AVE(GROUP,IF(h.p_rr_nbr = (TYPEOF(h.p_rr_nbr))'',0,100));
    maxlength_p_rr_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_rr_nbr)));
    avelength_p_rr_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_rr_nbr)),h.p_rr_nbr<>(typeof(h.p_rr_nbr))'');
    populated_p_rr_box_cnt := COUNT(GROUP,h.p_rr_box <> (TYPEOF(h.p_rr_box))'');
    populated_p_rr_box_pcnt := AVE(GROUP,IF(h.p_rr_box = (TYPEOF(h.p_rr_box))'',0,100));
    maxlength_p_rr_box := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_rr_box)));
    avelength_p_rr_box := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_rr_box)),h.p_rr_box<>(typeof(h.p_rr_box))'');
    populated_p_scndry_rng_cnt := COUNT(GROUP,h.p_scndry_rng <> (TYPEOF(h.p_scndry_rng))'');
    populated_p_scndry_rng_pcnt := AVE(GROUP,IF(h.p_scndry_rng = (TYPEOF(h.p_scndry_rng))'',0,100));
    maxlength_p_scndry_rng := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_scndry_rng)));
    avelength_p_scndry_rng := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_scndry_rng)),h.p_scndry_rng<>(typeof(h.p_scndry_rng))'');
    populated_p_scndry_des_cnt := COUNT(GROUP,h.p_scndry_des <> (TYPEOF(h.p_scndry_des))'');
    populated_p_scndry_des_pcnt := AVE(GROUP,IF(h.p_scndry_des = (TYPEOF(h.p_scndry_des))'',0,100));
    maxlength_p_scndry_des := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_scndry_des)));
    avelength_p_scndry_des := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_scndry_des)),h.p_scndry_des<>(typeof(h.p_scndry_des))'');
    populated_p_city_cnt := COUNT(GROUP,h.p_city <> (TYPEOF(h.p_city))'');
    populated_p_city_pcnt := AVE(GROUP,IF(h.p_city = (TYPEOF(h.p_city))'',0,100));
    maxlength_p_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city)));
    avelength_p_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city)),h.p_city<>(typeof(h.p_city))'');
    populated_p_state_cnt := COUNT(GROUP,h.p_state <> (TYPEOF(h.p_state))'');
    populated_p_state_pcnt := AVE(GROUP,IF(h.p_state = (TYPEOF(h.p_state))'',0,100));
    maxlength_p_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_state)));
    avelength_p_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_state)),h.p_state<>(typeof(h.p_state))'');
    populated_p_zip5_cnt := COUNT(GROUP,h.p_zip5 <> (TYPEOF(h.p_zip5))'');
    populated_p_zip5_pcnt := AVE(GROUP,IF(h.p_zip5 = (TYPEOF(h.p_zip5))'',0,100));
    maxlength_p_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_zip5)));
    avelength_p_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_zip5)),h.p_zip5<>(typeof(h.p_zip5))'');
    populated_p_zip4_cnt := COUNT(GROUP,h.p_zip4 <> (TYPEOF(h.p_zip4))'');
    populated_p_zip4_pcnt := AVE(GROUP,IF(h.p_zip4 = (TYPEOF(h.p_zip4))'',0,100));
    maxlength_p_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_zip4)));
    avelength_p_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_zip4)),h.p_zip4<>(typeof(h.p_zip4))'');
    populated_p_cntry_cd_cnt := COUNT(GROUP,h.p_cntry_cd <> (TYPEOF(h.p_cntry_cd))'');
    populated_p_cntry_cd_pcnt := AVE(GROUP,IF(h.p_cntry_cd = (TYPEOF(h.p_cntry_cd))'',0,100));
    maxlength_p_cntry_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_cntry_cd)));
    avelength_p_cntry_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_cntry_cd)),h.p_cntry_cd<>(typeof(h.p_cntry_cd))'');
    populated_p_cc_filler_cnt := COUNT(GROUP,h.p_cc_filler <> (TYPEOF(h.p_cc_filler))'');
    populated_p_cc_filler_pcnt := AVE(GROUP,IF(h.p_cc_filler = (TYPEOF(h.p_cc_filler))'',0,100));
    maxlength_p_cc_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_cc_filler)));
    avelength_p_cc_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_cc_filler)),h.p_cc_filler<>(typeof(h.p_cc_filler))'');
    populated_p_cc_cnt := COUNT(GROUP,h.p_cc <> (TYPEOF(h.p_cc))'');
    populated_p_cc_pcnt := AVE(GROUP,IF(h.p_cc = (TYPEOF(h.p_cc))'',0,100));
    maxlength_p_cc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_cc)));
    avelength_p_cc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_cc)),h.p_cc<>(typeof(h.p_cc))'');
    populated_p_county_cnt := COUNT(GROUP,h.p_county <> (TYPEOF(h.p_county))'');
    populated_p_county_pcnt := AVE(GROUP,IF(h.p_county = (TYPEOF(h.p_county))'',0,100));
    maxlength_p_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_county)));
    avelength_p_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_county)),h.p_county<>(typeof(h.p_county))'');
    populated_opt_out_cd_cnt := COUNT(GROUP,h.opt_out_cd <> (TYPEOF(h.opt_out_cd))'');
    populated_opt_out_cd_pcnt := AVE(GROUP,IF(h.opt_out_cd = (TYPEOF(h.opt_out_cd))'',0,100));
    maxlength_opt_out_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_out_cd)));
    avelength_opt_out_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_out_cd)),h.opt_out_cd<>(typeof(h.opt_out_cd))'');
    populated_asg_wgt_cnt := COUNT(GROUP,h.asg_wgt <> (TYPEOF(h.asg_wgt))'');
    populated_asg_wgt_pcnt := AVE(GROUP,IF(h.asg_wgt = (TYPEOF(h.asg_wgt))'',0,100));
    maxlength_asg_wgt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.asg_wgt)));
    avelength_asg_wgt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.asg_wgt)),h.asg_wgt<>(typeof(h.asg_wgt))'');
    populated_asg_wgt_uom_cnt := COUNT(GROUP,h.asg_wgt_uom <> (TYPEOF(h.asg_wgt_uom))'');
    populated_asg_wgt_uom_pcnt := AVE(GROUP,IF(h.asg_wgt_uom = (TYPEOF(h.asg_wgt_uom))'',0,100));
    maxlength_asg_wgt_uom := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.asg_wgt_uom)));
    avelength_asg_wgt_uom := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.asg_wgt_uom)),h.asg_wgt_uom<>(typeof(h.asg_wgt_uom))'');
    populated_source_ctl_id_cnt := COUNT(GROUP,h.source_ctl_id <> (TYPEOF(h.source_ctl_id))'');
    populated_source_ctl_id_pcnt := AVE(GROUP,IF(h.source_ctl_id = (TYPEOF(h.source_ctl_id))'',0,100));
    maxlength_source_ctl_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_ctl_id)));
    avelength_source_ctl_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_ctl_id)),h.source_ctl_id<>(typeof(h.source_ctl_id))'');
    populated_raw_name_cnt := COUNT(GROUP,h.raw_name <> (TYPEOF(h.raw_name))'');
    populated_raw_name_pcnt := AVE(GROUP,IF(h.raw_name = (TYPEOF(h.raw_name))'',0,100));
    maxlength_raw_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_name)));
    avelength_raw_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_name)),h.raw_name<>(typeof(h.raw_name))'');
    populated_branded_title_flag_cnt := COUNT(GROUP,h.branded_title_flag <> (TYPEOF(h.branded_title_flag))'');
    populated_branded_title_flag_pcnt := AVE(GROUP,IF(h.branded_title_flag = (TYPEOF(h.branded_title_flag))'',0,100));
    maxlength_branded_title_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.branded_title_flag)));
    avelength_branded_title_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.branded_title_flag)),h.branded_title_flag<>(typeof(h.branded_title_flag))'');
    populated_brand_code_1_cnt := COUNT(GROUP,h.brand_code_1 <> (TYPEOF(h.brand_code_1))'');
    populated_brand_code_1_pcnt := AVE(GROUP,IF(h.brand_code_1 = (TYPEOF(h.brand_code_1))'',0,100));
    maxlength_brand_code_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_1)));
    avelength_brand_code_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_1)),h.brand_code_1<>(typeof(h.brand_code_1))'');
    populated_brand_date_1_cnt := COUNT(GROUP,h.brand_date_1 <> (TYPEOF(h.brand_date_1))'');
    populated_brand_date_1_pcnt := AVE(GROUP,IF(h.brand_date_1 = (TYPEOF(h.brand_date_1))'',0,100));
    maxlength_brand_date_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_1)));
    avelength_brand_date_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_1)),h.brand_date_1<>(typeof(h.brand_date_1))'');
    populated_brand_state_1_cnt := COUNT(GROUP,h.brand_state_1 <> (TYPEOF(h.brand_state_1))'');
    populated_brand_state_1_pcnt := AVE(GROUP,IF(h.brand_state_1 = (TYPEOF(h.brand_state_1))'',0,100));
    maxlength_brand_state_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_1)));
    avelength_brand_state_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_1)),h.brand_state_1<>(typeof(h.brand_state_1))'');
    populated_brand_code_2_cnt := COUNT(GROUP,h.brand_code_2 <> (TYPEOF(h.brand_code_2))'');
    populated_brand_code_2_pcnt := AVE(GROUP,IF(h.brand_code_2 = (TYPEOF(h.brand_code_2))'',0,100));
    maxlength_brand_code_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_2)));
    avelength_brand_code_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_2)),h.brand_code_2<>(typeof(h.brand_code_2))'');
    populated_brand_date_2_cnt := COUNT(GROUP,h.brand_date_2 <> (TYPEOF(h.brand_date_2))'');
    populated_brand_date_2_pcnt := AVE(GROUP,IF(h.brand_date_2 = (TYPEOF(h.brand_date_2))'',0,100));
    maxlength_brand_date_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_2)));
    avelength_brand_date_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_2)),h.brand_date_2<>(typeof(h.brand_date_2))'');
    populated_brand_state_2_cnt := COUNT(GROUP,h.brand_state_2 <> (TYPEOF(h.brand_state_2))'');
    populated_brand_state_2_pcnt := AVE(GROUP,IF(h.brand_state_2 = (TYPEOF(h.brand_state_2))'',0,100));
    maxlength_brand_state_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_2)));
    avelength_brand_state_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_2)),h.brand_state_2<>(typeof(h.brand_state_2))'');
    populated_brand_code_3_cnt := COUNT(GROUP,h.brand_code_3 <> (TYPEOF(h.brand_code_3))'');
    populated_brand_code_3_pcnt := AVE(GROUP,IF(h.brand_code_3 = (TYPEOF(h.brand_code_3))'',0,100));
    maxlength_brand_code_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_3)));
    avelength_brand_code_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_3)),h.brand_code_3<>(typeof(h.brand_code_3))'');
    populated_brand_date_3_cnt := COUNT(GROUP,h.brand_date_3 <> (TYPEOF(h.brand_date_3))'');
    populated_brand_date_3_pcnt := AVE(GROUP,IF(h.brand_date_3 = (TYPEOF(h.brand_date_3))'',0,100));
    maxlength_brand_date_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_3)));
    avelength_brand_date_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_3)),h.brand_date_3<>(typeof(h.brand_date_3))'');
    populated_brand_state_3_cnt := COUNT(GROUP,h.brand_state_3 <> (TYPEOF(h.brand_state_3))'');
    populated_brand_state_3_pcnt := AVE(GROUP,IF(h.brand_state_3 = (TYPEOF(h.brand_state_3))'',0,100));
    maxlength_brand_state_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_3)));
    avelength_brand_state_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_3)),h.brand_state_3<>(typeof(h.brand_state_3))'');
    populated_brand_code_4_cnt := COUNT(GROUP,h.brand_code_4 <> (TYPEOF(h.brand_code_4))'');
    populated_brand_code_4_pcnt := AVE(GROUP,IF(h.brand_code_4 = (TYPEOF(h.brand_code_4))'',0,100));
    maxlength_brand_code_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_4)));
    avelength_brand_code_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_4)),h.brand_code_4<>(typeof(h.brand_code_4))'');
    populated_brand_date_4_cnt := COUNT(GROUP,h.brand_date_4 <> (TYPEOF(h.brand_date_4))'');
    populated_brand_date_4_pcnt := AVE(GROUP,IF(h.brand_date_4 = (TYPEOF(h.brand_date_4))'',0,100));
    maxlength_brand_date_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_4)));
    avelength_brand_date_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_4)),h.brand_date_4<>(typeof(h.brand_date_4))'');
    populated_brand_state_4_cnt := COUNT(GROUP,h.brand_state_4 <> (TYPEOF(h.brand_state_4))'');
    populated_brand_state_4_pcnt := AVE(GROUP,IF(h.brand_state_4 = (TYPEOF(h.brand_state_4))'',0,100));
    maxlength_brand_state_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_4)));
    avelength_brand_state_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_4)),h.brand_state_4<>(typeof(h.brand_state_4))'');
    populated_brand_code_5_cnt := COUNT(GROUP,h.brand_code_5 <> (TYPEOF(h.brand_code_5))'');
    populated_brand_code_5_pcnt := AVE(GROUP,IF(h.brand_code_5 = (TYPEOF(h.brand_code_5))'',0,100));
    maxlength_brand_code_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_5)));
    avelength_brand_code_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_code_5)),h.brand_code_5<>(typeof(h.brand_code_5))'');
    populated_brand_date_5_cnt := COUNT(GROUP,h.brand_date_5 <> (TYPEOF(h.brand_date_5))'');
    populated_brand_date_5_pcnt := AVE(GROUP,IF(h.brand_date_5 = (TYPEOF(h.brand_date_5))'',0,100));
    maxlength_brand_date_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_5)));
    avelength_brand_date_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_date_5)),h.brand_date_5<>(typeof(h.brand_date_5))'');
    populated_brand_state_5_cnt := COUNT(GROUP,h.brand_state_5 <> (TYPEOF(h.brand_state_5))'');
    populated_brand_state_5_pcnt := AVE(GROUP,IF(h.brand_state_5 = (TYPEOF(h.brand_state_5))'',0,100));
    maxlength_brand_state_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_5)));
    avelength_brand_state_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_state_5)),h.brand_state_5<>(typeof(h.brand_state_5))'');
    populated_tod_flag_cnt := COUNT(GROUP,h.tod_flag <> (TYPEOF(h.tod_flag))'');
    populated_tod_flag_pcnt := AVE(GROUP,IF(h.tod_flag = (TYPEOF(h.tod_flag))'',0,100));
    maxlength_tod_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tod_flag)));
    avelength_tod_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tod_flag)),h.tod_flag<>(typeof(h.tod_flag))'');
    populated_model_class_code_cnt := COUNT(GROUP,h.model_class_code <> (TYPEOF(h.model_class_code))'');
    populated_model_class_code_pcnt := AVE(GROUP,IF(h.model_class_code = (TYPEOF(h.model_class_code))'',0,100));
    maxlength_model_class_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_class_code)));
    avelength_model_class_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_class_code)),h.model_class_code<>(typeof(h.model_class_code))'');
    populated_model_class_cnt := COUNT(GROUP,h.model_class <> (TYPEOF(h.model_class))'');
    populated_model_class_pcnt := AVE(GROUP,IF(h.model_class = (TYPEOF(h.model_class))'',0,100));
    maxlength_model_class := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_class)));
    avelength_model_class := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_class)),h.model_class<>(typeof(h.model_class))'');
    populated_min_door_count_cnt := COUNT(GROUP,h.min_door_count <> (TYPEOF(h.min_door_count))'');
    populated_min_door_count_pcnt := AVE(GROUP,IF(h.min_door_count = (TYPEOF(h.min_door_count))'',0,100));
    maxlength_min_door_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.min_door_count)));
    avelength_min_door_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.min_door_count)),h.min_door_count<>(typeof(h.min_door_count))'');
    populated_safety_type_cnt := COUNT(GROUP,h.safety_type <> (TYPEOF(h.safety_type))'');
    populated_safety_type_pcnt := AVE(GROUP,IF(h.safety_type = (TYPEOF(h.safety_type))'',0,100));
    maxlength_safety_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_type)));
    avelength_safety_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_type)),h.safety_type<>(typeof(h.safety_type))'');
    populated_airbag_driver_cnt := COUNT(GROUP,h.airbag_driver <> (TYPEOF(h.airbag_driver))'');
    populated_airbag_driver_pcnt := AVE(GROUP,IF(h.airbag_driver = (TYPEOF(h.airbag_driver))'',0,100));
    maxlength_airbag_driver := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_driver)));
    avelength_airbag_driver := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_driver)),h.airbag_driver<>(typeof(h.airbag_driver))'');
    populated_airbag_front_driver_side_cnt := COUNT(GROUP,h.airbag_front_driver_side <> (TYPEOF(h.airbag_front_driver_side))'');
    populated_airbag_front_driver_side_pcnt := AVE(GROUP,IF(h.airbag_front_driver_side = (TYPEOF(h.airbag_front_driver_side))'',0,100));
    maxlength_airbag_front_driver_side := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_driver_side)));
    avelength_airbag_front_driver_side := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_driver_side)),h.airbag_front_driver_side<>(typeof(h.airbag_front_driver_side))'');
    populated_airbag_front_head_curtain_cnt := COUNT(GROUP,h.airbag_front_head_curtain <> (TYPEOF(h.airbag_front_head_curtain))'');
    populated_airbag_front_head_curtain_pcnt := AVE(GROUP,IF(h.airbag_front_head_curtain = (TYPEOF(h.airbag_front_head_curtain))'',0,100));
    maxlength_airbag_front_head_curtain := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_head_curtain)));
    avelength_airbag_front_head_curtain := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_head_curtain)),h.airbag_front_head_curtain<>(typeof(h.airbag_front_head_curtain))'');
    populated_airbag_front_pass_cnt := COUNT(GROUP,h.airbag_front_pass <> (TYPEOF(h.airbag_front_pass))'');
    populated_airbag_front_pass_pcnt := AVE(GROUP,IF(h.airbag_front_pass = (TYPEOF(h.airbag_front_pass))'',0,100));
    maxlength_airbag_front_pass := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_pass)));
    avelength_airbag_front_pass := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_pass)),h.airbag_front_pass<>(typeof(h.airbag_front_pass))'');
    populated_airbag_front_pass_side_cnt := COUNT(GROUP,h.airbag_front_pass_side <> (TYPEOF(h.airbag_front_pass_side))'');
    populated_airbag_front_pass_side_pcnt := AVE(GROUP,IF(h.airbag_front_pass_side = (TYPEOF(h.airbag_front_pass_side))'',0,100));
    maxlength_airbag_front_pass_side := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_pass_side)));
    avelength_airbag_front_pass_side := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbag_front_pass_side)),h.airbag_front_pass_side<>(typeof(h.airbag_front_pass_side))'');
    populated_airbags_cnt := COUNT(GROUP,h.airbags <> (TYPEOF(h.airbags))'');
    populated_airbags_pcnt := AVE(GROUP,IF(h.airbags = (TYPEOF(h.airbags))'',0,100));
    maxlength_airbags := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbags)));
    avelength_airbags := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.airbags)),h.airbags<>(typeof(h.airbags))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,append_state_origin,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_append_state_origin_pcnt *   0.00 / 100 + T.Populated_file_typ_pcnt *   0.00 / 100 + T.Populated_vin_pcnt *   0.00 / 100 + T.Populated_vehicle_typ_pcnt *   0.00 / 100 + T.Populated_model_yr_pcnt *   0.00 / 100 + T.Populated_model_yr_ind_pcnt *   0.00 / 100 + T.Populated_make_pcnt *   0.00 / 100 + T.Populated_make_ind_pcnt *   0.00 / 100 + T.Populated_series_pcnt *   0.00 / 100 + T.Populated_series_ind_pcnt *   0.00 / 100 + T.Populated_prime_color_pcnt *   0.00 / 100 + T.Populated_second_color_pcnt *   0.00 / 100 + T.Populated_body_style_pcnt *   0.00 / 100 + T.Populated_body_style_ind_pcnt *   0.00 / 100 + T.Populated_model_pcnt *   0.00 / 100 + T.Populated_model_ind_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_lengt_pcnt *   0.00 / 100 + T.Populated_axle_cnt_pcnt *   0.00 / 100 + T.Populated_plate_nbr_pcnt *   0.00 / 100 + T.Populated_plate_state_pcnt *   0.00 / 100 + T.Populated_prev_plate_nbr_pcnt *   0.00 / 100 + T.Populated_prev_plate_state_pcnt *   0.00 / 100 + T.Populated_plate_typ_cd_pcnt *   0.00 / 100 + T.Populated_mstr_src_state_pcnt *   0.00 / 100 + T.Populated_reg_decal_nbr_pcnt *   0.00 / 100 + T.Populated_org_reg_dt_pcnt *   0.00 / 100 + T.Populated_reg_renew_dt_pcnt *   0.00 / 100 + T.Populated_reg_exp_dt_pcnt *   0.00 / 100 + T.Populated_title_nbr_pcnt *   0.00 / 100 + T.Populated_org_title_dt_pcnt *   0.00 / 100 + T.Populated_title_trans_dt_pcnt *   0.00 / 100 + T.Populated_name_typ_cd_pcnt *   0.00 / 100 + T.Populated_owner_typ_cd_pcnt *   0.00 / 100 + T.Populated_first_nm_pcnt *   0.00 / 100 + T.Populated_middle_nm_pcnt *   0.00 / 100 + T.Populated_last_nm_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_prof_suffix_pcnt *   0.00 / 100 + T.Populated_ind_ssn_pcnt *   0.00 / 100 + T.Populated_ind_dob_pcnt *   0.00 / 100 + T.Populated_mail_range_pcnt *   0.00 / 100 + T.Populated_m_pre_dir_pcnt *   0.00 / 100 + T.Populated_m_street_pcnt *   0.00 / 100 + T.Populated_m_suffix_pcnt *   0.00 / 100 + T.Populated_m_post_dir_pcnt *   0.00 / 100 + T.Populated_m_pob_pcnt *   0.00 / 100 + T.Populated_m_rr_nbr_pcnt *   0.00 / 100 + T.Populated_m_rr_box_pcnt *   0.00 / 100 + T.Populated_m_scndry_rng_pcnt *   0.00 / 100 + T.Populated_m_scndry_des_pcnt *   0.00 / 100 + T.Populated_m_city_pcnt *   0.00 / 100 + T.Populated_m_state_pcnt *   0.00 / 100 + T.Populated_m_zip5_pcnt *   0.00 / 100 + T.Populated_m_zip4_pcnt *   0.00 / 100 + T.Populated_m_cntry_cd_pcnt *   0.00 / 100 + T.Populated_m_cc_filler_pcnt *   0.00 / 100 + T.Populated_m_cc_pcnt *   0.00 / 100 + T.Populated_m_county_pcnt *   0.00 / 100 + T.Populated_phys_range_pcnt *   0.00 / 100 + T.Populated_p_pre_dir_pcnt *   0.00 / 100 + T.Populated_p_street_pcnt *   0.00 / 100 + T.Populated_p_suffix_pcnt *   0.00 / 100 + T.Populated_p_post_dir_pcnt *   0.00 / 100 + T.Populated_p_pob_pcnt *   0.00 / 100 + T.Populated_p_rr_nbr_pcnt *   0.00 / 100 + T.Populated_p_rr_box_pcnt *   0.00 / 100 + T.Populated_p_scndry_rng_pcnt *   0.00 / 100 + T.Populated_p_scndry_des_pcnt *   0.00 / 100 + T.Populated_p_city_pcnt *   0.00 / 100 + T.Populated_p_state_pcnt *   0.00 / 100 + T.Populated_p_zip5_pcnt *   0.00 / 100 + T.Populated_p_zip4_pcnt *   0.00 / 100 + T.Populated_p_cntry_cd_pcnt *   0.00 / 100 + T.Populated_p_cc_filler_pcnt *   0.00 / 100 + T.Populated_p_cc_pcnt *   0.00 / 100 + T.Populated_p_county_pcnt *   0.00 / 100 + T.Populated_opt_out_cd_pcnt *   0.00 / 100 + T.Populated_asg_wgt_pcnt *   0.00 / 100 + T.Populated_asg_wgt_uom_pcnt *   0.00 / 100 + T.Populated_source_ctl_id_pcnt *   0.00 / 100 + T.Populated_raw_name_pcnt *   0.00 / 100 + T.Populated_branded_title_flag_pcnt *   0.00 / 100 + T.Populated_brand_code_1_pcnt *   0.00 / 100 + T.Populated_brand_date_1_pcnt *   0.00 / 100 + T.Populated_brand_state_1_pcnt *   0.00 / 100 + T.Populated_brand_code_2_pcnt *   0.00 / 100 + T.Populated_brand_date_2_pcnt *   0.00 / 100 + T.Populated_brand_state_2_pcnt *   0.00 / 100 + T.Populated_brand_code_3_pcnt *   0.00 / 100 + T.Populated_brand_date_3_pcnt *   0.00 / 100 + T.Populated_brand_state_3_pcnt *   0.00 / 100 + T.Populated_brand_code_4_pcnt *   0.00 / 100 + T.Populated_brand_date_4_pcnt *   0.00 / 100 + T.Populated_brand_state_4_pcnt *   0.00 / 100 + T.Populated_brand_code_5_pcnt *   0.00 / 100 + T.Populated_brand_date_5_pcnt *   0.00 / 100 + T.Populated_brand_state_5_pcnt *   0.00 / 100 + T.Populated_tod_flag_pcnt *   0.00 / 100 + T.Populated_model_class_code_pcnt *   0.00 / 100 + T.Populated_model_class_pcnt *   0.00 / 100 + T.Populated_min_door_count_pcnt *   0.00 / 100 + T.Populated_safety_type_pcnt *   0.00 / 100 + T.Populated_airbag_driver_pcnt *   0.00 / 100 + T.Populated_airbag_front_driver_side_pcnt *   0.00 / 100 + T.Populated_airbag_front_head_curtain_pcnt *   0.00 / 100 + T.Populated_airbag_front_pass_pcnt *   0.00 / 100 + T.Populated_airbag_front_pass_side_pcnt *   0.00 / 100 + T.Populated_airbags_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING append_state_origin1;
    STRING append_state_origin2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.append_state_origin1 := le.Source;
    SELF.append_state_origin2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_append_process_date_pcnt*ri.Populated_append_process_date_pcnt *   0.00 / 10000 + le.Populated_append_state_origin_pcnt*ri.Populated_append_state_origin_pcnt *   0.00 / 10000 + le.Populated_file_typ_pcnt*ri.Populated_file_typ_pcnt *   0.00 / 10000 + le.Populated_vin_pcnt*ri.Populated_vin_pcnt *   0.00 / 10000 + le.Populated_vehicle_typ_pcnt*ri.Populated_vehicle_typ_pcnt *   0.00 / 10000 + le.Populated_model_yr_pcnt*ri.Populated_model_yr_pcnt *   0.00 / 10000 + le.Populated_model_yr_ind_pcnt*ri.Populated_model_yr_ind_pcnt *   0.00 / 10000 + le.Populated_make_pcnt*ri.Populated_make_pcnt *   0.00 / 10000 + le.Populated_make_ind_pcnt*ri.Populated_make_ind_pcnt *   0.00 / 10000 + le.Populated_series_pcnt*ri.Populated_series_pcnt *   0.00 / 10000 + le.Populated_series_ind_pcnt*ri.Populated_series_ind_pcnt *   0.00 / 10000 + le.Populated_prime_color_pcnt*ri.Populated_prime_color_pcnt *   0.00 / 10000 + le.Populated_second_color_pcnt*ri.Populated_second_color_pcnt *   0.00 / 10000 + le.Populated_body_style_pcnt*ri.Populated_body_style_pcnt *   0.00 / 10000 + le.Populated_body_style_ind_pcnt*ri.Populated_body_style_ind_pcnt *   0.00 / 10000 + le.Populated_model_pcnt*ri.Populated_model_pcnt *   0.00 / 10000 + le.Populated_model_ind_pcnt*ri.Populated_model_ind_pcnt *   0.00 / 10000 + le.Populated_weight_pcnt*ri.Populated_weight_pcnt *   0.00 / 10000 + le.Populated_lengt_pcnt*ri.Populated_lengt_pcnt *   0.00 / 10000 + le.Populated_axle_cnt_pcnt*ri.Populated_axle_cnt_pcnt *   0.00 / 10000 + le.Populated_plate_nbr_pcnt*ri.Populated_plate_nbr_pcnt *   0.00 / 10000 + le.Populated_plate_state_pcnt*ri.Populated_plate_state_pcnt *   0.00 / 10000 + le.Populated_prev_plate_nbr_pcnt*ri.Populated_prev_plate_nbr_pcnt *   0.00 / 10000 + le.Populated_prev_plate_state_pcnt*ri.Populated_prev_plate_state_pcnt *   0.00 / 10000 + le.Populated_plate_typ_cd_pcnt*ri.Populated_plate_typ_cd_pcnt *   0.00 / 10000 + le.Populated_mstr_src_state_pcnt*ri.Populated_mstr_src_state_pcnt *   0.00 / 10000 + le.Populated_reg_decal_nbr_pcnt*ri.Populated_reg_decal_nbr_pcnt *   0.00 / 10000 + le.Populated_org_reg_dt_pcnt*ri.Populated_org_reg_dt_pcnt *   0.00 / 10000 + le.Populated_reg_renew_dt_pcnt*ri.Populated_reg_renew_dt_pcnt *   0.00 / 10000 + le.Populated_reg_exp_dt_pcnt*ri.Populated_reg_exp_dt_pcnt *   0.00 / 10000 + le.Populated_title_nbr_pcnt*ri.Populated_title_nbr_pcnt *   0.00 / 10000 + le.Populated_org_title_dt_pcnt*ri.Populated_org_title_dt_pcnt *   0.00 / 10000 + le.Populated_title_trans_dt_pcnt*ri.Populated_title_trans_dt_pcnt *   0.00 / 10000 + le.Populated_name_typ_cd_pcnt*ri.Populated_name_typ_cd_pcnt *   0.00 / 10000 + le.Populated_owner_typ_cd_pcnt*ri.Populated_owner_typ_cd_pcnt *   0.00 / 10000 + le.Populated_first_nm_pcnt*ri.Populated_first_nm_pcnt *   0.00 / 10000 + le.Populated_middle_nm_pcnt*ri.Populated_middle_nm_pcnt *   0.00 / 10000 + le.Populated_last_nm_pcnt*ri.Populated_last_nm_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_prof_suffix_pcnt*ri.Populated_prof_suffix_pcnt *   0.00 / 10000 + le.Populated_ind_ssn_pcnt*ri.Populated_ind_ssn_pcnt *   0.00 / 10000 + le.Populated_ind_dob_pcnt*ri.Populated_ind_dob_pcnt *   0.00 / 10000 + le.Populated_mail_range_pcnt*ri.Populated_mail_range_pcnt *   0.00 / 10000 + le.Populated_m_pre_dir_pcnt*ri.Populated_m_pre_dir_pcnt *   0.00 / 10000 + le.Populated_m_street_pcnt*ri.Populated_m_street_pcnt *   0.00 / 10000 + le.Populated_m_suffix_pcnt*ri.Populated_m_suffix_pcnt *   0.00 / 10000 + le.Populated_m_post_dir_pcnt*ri.Populated_m_post_dir_pcnt *   0.00 / 10000 + le.Populated_m_pob_pcnt*ri.Populated_m_pob_pcnt *   0.00 / 10000 + le.Populated_m_rr_nbr_pcnt*ri.Populated_m_rr_nbr_pcnt *   0.00 / 10000 + le.Populated_m_rr_box_pcnt*ri.Populated_m_rr_box_pcnt *   0.00 / 10000 + le.Populated_m_scndry_rng_pcnt*ri.Populated_m_scndry_rng_pcnt *   0.00 / 10000 + le.Populated_m_scndry_des_pcnt*ri.Populated_m_scndry_des_pcnt *   0.00 / 10000 + le.Populated_m_city_pcnt*ri.Populated_m_city_pcnt *   0.00 / 10000 + le.Populated_m_state_pcnt*ri.Populated_m_state_pcnt *   0.00 / 10000 + le.Populated_m_zip5_pcnt*ri.Populated_m_zip5_pcnt *   0.00 / 10000 + le.Populated_m_zip4_pcnt*ri.Populated_m_zip4_pcnt *   0.00 / 10000 + le.Populated_m_cntry_cd_pcnt*ri.Populated_m_cntry_cd_pcnt *   0.00 / 10000 + le.Populated_m_cc_filler_pcnt*ri.Populated_m_cc_filler_pcnt *   0.00 / 10000 + le.Populated_m_cc_pcnt*ri.Populated_m_cc_pcnt *   0.00 / 10000 + le.Populated_m_county_pcnt*ri.Populated_m_county_pcnt *   0.00 / 10000 + le.Populated_phys_range_pcnt*ri.Populated_phys_range_pcnt *   0.00 / 10000 + le.Populated_p_pre_dir_pcnt*ri.Populated_p_pre_dir_pcnt *   0.00 / 10000 + le.Populated_p_street_pcnt*ri.Populated_p_street_pcnt *   0.00 / 10000 + le.Populated_p_suffix_pcnt*ri.Populated_p_suffix_pcnt *   0.00 / 10000 + le.Populated_p_post_dir_pcnt*ri.Populated_p_post_dir_pcnt *   0.00 / 10000 + le.Populated_p_pob_pcnt*ri.Populated_p_pob_pcnt *   0.00 / 10000 + le.Populated_p_rr_nbr_pcnt*ri.Populated_p_rr_nbr_pcnt *   0.00 / 10000 + le.Populated_p_rr_box_pcnt*ri.Populated_p_rr_box_pcnt *   0.00 / 10000 + le.Populated_p_scndry_rng_pcnt*ri.Populated_p_scndry_rng_pcnt *   0.00 / 10000 + le.Populated_p_scndry_des_pcnt*ri.Populated_p_scndry_des_pcnt *   0.00 / 10000 + le.Populated_p_city_pcnt*ri.Populated_p_city_pcnt *   0.00 / 10000 + le.Populated_p_state_pcnt*ri.Populated_p_state_pcnt *   0.00 / 10000 + le.Populated_p_zip5_pcnt*ri.Populated_p_zip5_pcnt *   0.00 / 10000 + le.Populated_p_zip4_pcnt*ri.Populated_p_zip4_pcnt *   0.00 / 10000 + le.Populated_p_cntry_cd_pcnt*ri.Populated_p_cntry_cd_pcnt *   0.00 / 10000 + le.Populated_p_cc_filler_pcnt*ri.Populated_p_cc_filler_pcnt *   0.00 / 10000 + le.Populated_p_cc_pcnt*ri.Populated_p_cc_pcnt *   0.00 / 10000 + le.Populated_p_county_pcnt*ri.Populated_p_county_pcnt *   0.00 / 10000 + le.Populated_opt_out_cd_pcnt*ri.Populated_opt_out_cd_pcnt *   0.00 / 10000 + le.Populated_asg_wgt_pcnt*ri.Populated_asg_wgt_pcnt *   0.00 / 10000 + le.Populated_asg_wgt_uom_pcnt*ri.Populated_asg_wgt_uom_pcnt *   0.00 / 10000 + le.Populated_source_ctl_id_pcnt*ri.Populated_source_ctl_id_pcnt *   0.00 / 10000 + le.Populated_raw_name_pcnt*ri.Populated_raw_name_pcnt *   0.00 / 10000 + le.Populated_branded_title_flag_pcnt*ri.Populated_branded_title_flag_pcnt *   0.00 / 10000 + le.Populated_brand_code_1_pcnt*ri.Populated_brand_code_1_pcnt *   0.00 / 10000 + le.Populated_brand_date_1_pcnt*ri.Populated_brand_date_1_pcnt *   0.00 / 10000 + le.Populated_brand_state_1_pcnt*ri.Populated_brand_state_1_pcnt *   0.00 / 10000 + le.Populated_brand_code_2_pcnt*ri.Populated_brand_code_2_pcnt *   0.00 / 10000 + le.Populated_brand_date_2_pcnt*ri.Populated_brand_date_2_pcnt *   0.00 / 10000 + le.Populated_brand_state_2_pcnt*ri.Populated_brand_state_2_pcnt *   0.00 / 10000 + le.Populated_brand_code_3_pcnt*ri.Populated_brand_code_3_pcnt *   0.00 / 10000 + le.Populated_brand_date_3_pcnt*ri.Populated_brand_date_3_pcnt *   0.00 / 10000 + le.Populated_brand_state_3_pcnt*ri.Populated_brand_state_3_pcnt *   0.00 / 10000 + le.Populated_brand_code_4_pcnt*ri.Populated_brand_code_4_pcnt *   0.00 / 10000 + le.Populated_brand_date_4_pcnt*ri.Populated_brand_date_4_pcnt *   0.00 / 10000 + le.Populated_brand_state_4_pcnt*ri.Populated_brand_state_4_pcnt *   0.00 / 10000 + le.Populated_brand_code_5_pcnt*ri.Populated_brand_code_5_pcnt *   0.00 / 10000 + le.Populated_brand_date_5_pcnt*ri.Populated_brand_date_5_pcnt *   0.00 / 10000 + le.Populated_brand_state_5_pcnt*ri.Populated_brand_state_5_pcnt *   0.00 / 10000 + le.Populated_tod_flag_pcnt*ri.Populated_tod_flag_pcnt *   0.00 / 10000 + le.Populated_model_class_code_pcnt*ri.Populated_model_class_code_pcnt *   0.00 / 10000 + le.Populated_model_class_pcnt*ri.Populated_model_class_pcnt *   0.00 / 10000 + le.Populated_min_door_count_pcnt*ri.Populated_min_door_count_pcnt *   0.00 / 10000 + le.Populated_safety_type_pcnt*ri.Populated_safety_type_pcnt *   0.00 / 10000 + le.Populated_airbag_driver_pcnt*ri.Populated_airbag_driver_pcnt *   0.00 / 10000 + le.Populated_airbag_front_driver_side_pcnt*ri.Populated_airbag_front_driver_side_pcnt *   0.00 / 10000 + le.Populated_airbag_front_head_curtain_pcnt*ri.Populated_airbag_front_head_curtain_pcnt *   0.00 / 10000 + le.Populated_airbag_front_pass_pcnt*ri.Populated_airbag_front_pass_pcnt *   0.00 / 10000 + le.Populated_airbag_front_pass_side_pcnt*ri.Populated_airbag_front_pass_side_pcnt *   0.00 / 10000 + le.Populated_airbags_pcnt*ri.Populated_airbags_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'append_process_date','append_state_origin','file_typ','vin','vehicle_typ','model_yr','model_yr_ind','make','make_ind','series','series_ind','prime_color','second_color','body_style','body_style_ind','model','model_ind','weight','lengt','axle_cnt','plate_nbr','plate_state','prev_plate_nbr','prev_plate_state','plate_typ_cd','mstr_src_state','reg_decal_nbr','org_reg_dt','reg_renew_dt','reg_exp_dt','title_nbr','org_title_dt','title_trans_dt','name_typ_cd','owner_typ_cd','first_nm','middle_nm','last_nm','name_suffix','prof_suffix','ind_ssn','ind_dob','mail_range','m_pre_dir','m_street','m_suffix','m_post_dir','m_pob','m_rr_nbr','m_rr_box','m_scndry_rng','m_scndry_des','m_city','m_state','m_zip5','m_zip4','m_cntry_cd','m_cc_filler','m_cc','m_county','phys_range','p_pre_dir','p_street','p_suffix','p_post_dir','p_pob','p_rr_nbr','p_rr_box','p_scndry_rng','p_scndry_des','p_city','p_state','p_zip5','p_zip4','p_cntry_cd','p_cc_filler','p_cc','p_county','opt_out_cd','asg_wgt','asg_wgt_uom','source_ctl_id','raw_name','branded_title_flag','brand_code_1','brand_date_1','brand_state_1','brand_code_2','brand_date_2','brand_state_2','brand_code_3','brand_date_3','brand_state_3','brand_code_4','brand_date_4','brand_state_4','brand_code_5','brand_date_5','brand_state_5','tod_flag','model_class_code','model_class','min_door_count','safety_type','airbag_driver','airbag_front_driver_side','airbag_front_head_curtain','airbag_front_pass','airbag_front_pass_side','airbags');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_append_state_origin_pcnt,le.populated_file_typ_pcnt,le.populated_vin_pcnt,le.populated_vehicle_typ_pcnt,le.populated_model_yr_pcnt,le.populated_model_yr_ind_pcnt,le.populated_make_pcnt,le.populated_make_ind_pcnt,le.populated_series_pcnt,le.populated_series_ind_pcnt,le.populated_prime_color_pcnt,le.populated_second_color_pcnt,le.populated_body_style_pcnt,le.populated_body_style_ind_pcnt,le.populated_model_pcnt,le.populated_model_ind_pcnt,le.populated_weight_pcnt,le.populated_lengt_pcnt,le.populated_axle_cnt_pcnt,le.populated_plate_nbr_pcnt,le.populated_plate_state_pcnt,le.populated_prev_plate_nbr_pcnt,le.populated_prev_plate_state_pcnt,le.populated_plate_typ_cd_pcnt,le.populated_mstr_src_state_pcnt,le.populated_reg_decal_nbr_pcnt,le.populated_org_reg_dt_pcnt,le.populated_reg_renew_dt_pcnt,le.populated_reg_exp_dt_pcnt,le.populated_title_nbr_pcnt,le.populated_org_title_dt_pcnt,le.populated_title_trans_dt_pcnt,le.populated_name_typ_cd_pcnt,le.populated_owner_typ_cd_pcnt,le.populated_first_nm_pcnt,le.populated_middle_nm_pcnt,le.populated_last_nm_pcnt,le.populated_name_suffix_pcnt,le.populated_prof_suffix_pcnt,le.populated_ind_ssn_pcnt,le.populated_ind_dob_pcnt,le.populated_mail_range_pcnt,le.populated_m_pre_dir_pcnt,le.populated_m_street_pcnt,le.populated_m_suffix_pcnt,le.populated_m_post_dir_pcnt,le.populated_m_pob_pcnt,le.populated_m_rr_nbr_pcnt,le.populated_m_rr_box_pcnt,le.populated_m_scndry_rng_pcnt,le.populated_m_scndry_des_pcnt,le.populated_m_city_pcnt,le.populated_m_state_pcnt,le.populated_m_zip5_pcnt,le.populated_m_zip4_pcnt,le.populated_m_cntry_cd_pcnt,le.populated_m_cc_filler_pcnt,le.populated_m_cc_pcnt,le.populated_m_county_pcnt,le.populated_phys_range_pcnt,le.populated_p_pre_dir_pcnt,le.populated_p_street_pcnt,le.populated_p_suffix_pcnt,le.populated_p_post_dir_pcnt,le.populated_p_pob_pcnt,le.populated_p_rr_nbr_pcnt,le.populated_p_rr_box_pcnt,le.populated_p_scndry_rng_pcnt,le.populated_p_scndry_des_pcnt,le.populated_p_city_pcnt,le.populated_p_state_pcnt,le.populated_p_zip5_pcnt,le.populated_p_zip4_pcnt,le.populated_p_cntry_cd_pcnt,le.populated_p_cc_filler_pcnt,le.populated_p_cc_pcnt,le.populated_p_county_pcnt,le.populated_opt_out_cd_pcnt,le.populated_asg_wgt_pcnt,le.populated_asg_wgt_uom_pcnt,le.populated_source_ctl_id_pcnt,le.populated_raw_name_pcnt,le.populated_branded_title_flag_pcnt,le.populated_brand_code_1_pcnt,le.populated_brand_date_1_pcnt,le.populated_brand_state_1_pcnt,le.populated_brand_code_2_pcnt,le.populated_brand_date_2_pcnt,le.populated_brand_state_2_pcnt,le.populated_brand_code_3_pcnt,le.populated_brand_date_3_pcnt,le.populated_brand_state_3_pcnt,le.populated_brand_code_4_pcnt,le.populated_brand_date_4_pcnt,le.populated_brand_state_4_pcnt,le.populated_brand_code_5_pcnt,le.populated_brand_date_5_pcnt,le.populated_brand_state_5_pcnt,le.populated_tod_flag_pcnt,le.populated_model_class_code_pcnt,le.populated_model_class_pcnt,le.populated_min_door_count_pcnt,le.populated_safety_type_pcnt,le.populated_airbag_driver_pcnt,le.populated_airbag_front_driver_side_pcnt,le.populated_airbag_front_head_curtain_pcnt,le.populated_airbag_front_pass_pcnt,le.populated_airbag_front_pass_side_pcnt,le.populated_airbags_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_append_state_origin,le.maxlength_file_typ,le.maxlength_vin,le.maxlength_vehicle_typ,le.maxlength_model_yr,le.maxlength_model_yr_ind,le.maxlength_make,le.maxlength_make_ind,le.maxlength_series,le.maxlength_series_ind,le.maxlength_prime_color,le.maxlength_second_color,le.maxlength_body_style,le.maxlength_body_style_ind,le.maxlength_model,le.maxlength_model_ind,le.maxlength_weight,le.maxlength_lengt,le.maxlength_axle_cnt,le.maxlength_plate_nbr,le.maxlength_plate_state,le.maxlength_prev_plate_nbr,le.maxlength_prev_plate_state,le.maxlength_plate_typ_cd,le.maxlength_mstr_src_state,le.maxlength_reg_decal_nbr,le.maxlength_org_reg_dt,le.maxlength_reg_renew_dt,le.maxlength_reg_exp_dt,le.maxlength_title_nbr,le.maxlength_org_title_dt,le.maxlength_title_trans_dt,le.maxlength_name_typ_cd,le.maxlength_owner_typ_cd,le.maxlength_first_nm,le.maxlength_middle_nm,le.maxlength_last_nm,le.maxlength_name_suffix,le.maxlength_prof_suffix,le.maxlength_ind_ssn,le.maxlength_ind_dob,le.maxlength_mail_range,le.maxlength_m_pre_dir,le.maxlength_m_street,le.maxlength_m_suffix,le.maxlength_m_post_dir,le.maxlength_m_pob,le.maxlength_m_rr_nbr,le.maxlength_m_rr_box,le.maxlength_m_scndry_rng,le.maxlength_m_scndry_des,le.maxlength_m_city,le.maxlength_m_state,le.maxlength_m_zip5,le.maxlength_m_zip4,le.maxlength_m_cntry_cd,le.maxlength_m_cc_filler,le.maxlength_m_cc,le.maxlength_m_county,le.maxlength_phys_range,le.maxlength_p_pre_dir,le.maxlength_p_street,le.maxlength_p_suffix,le.maxlength_p_post_dir,le.maxlength_p_pob,le.maxlength_p_rr_nbr,le.maxlength_p_rr_box,le.maxlength_p_scndry_rng,le.maxlength_p_scndry_des,le.maxlength_p_city,le.maxlength_p_state,le.maxlength_p_zip5,le.maxlength_p_zip4,le.maxlength_p_cntry_cd,le.maxlength_p_cc_filler,le.maxlength_p_cc,le.maxlength_p_county,le.maxlength_opt_out_cd,le.maxlength_asg_wgt,le.maxlength_asg_wgt_uom,le.maxlength_source_ctl_id,le.maxlength_raw_name,le.maxlength_branded_title_flag,le.maxlength_brand_code_1,le.maxlength_brand_date_1,le.maxlength_brand_state_1,le.maxlength_brand_code_2,le.maxlength_brand_date_2,le.maxlength_brand_state_2,le.maxlength_brand_code_3,le.maxlength_brand_date_3,le.maxlength_brand_state_3,le.maxlength_brand_code_4,le.maxlength_brand_date_4,le.maxlength_brand_state_4,le.maxlength_brand_code_5,le.maxlength_brand_date_5,le.maxlength_brand_state_5,le.maxlength_tod_flag,le.maxlength_model_class_code,le.maxlength_model_class,le.maxlength_min_door_count,le.maxlength_safety_type,le.maxlength_airbag_driver,le.maxlength_airbag_front_driver_side,le.maxlength_airbag_front_head_curtain,le.maxlength_airbag_front_pass,le.maxlength_airbag_front_pass_side,le.maxlength_airbags);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_append_state_origin,le.avelength_file_typ,le.avelength_vin,le.avelength_vehicle_typ,le.avelength_model_yr,le.avelength_model_yr_ind,le.avelength_make,le.avelength_make_ind,le.avelength_series,le.avelength_series_ind,le.avelength_prime_color,le.avelength_second_color,le.avelength_body_style,le.avelength_body_style_ind,le.avelength_model,le.avelength_model_ind,le.avelength_weight,le.avelength_lengt,le.avelength_axle_cnt,le.avelength_plate_nbr,le.avelength_plate_state,le.avelength_prev_plate_nbr,le.avelength_prev_plate_state,le.avelength_plate_typ_cd,le.avelength_mstr_src_state,le.avelength_reg_decal_nbr,le.avelength_org_reg_dt,le.avelength_reg_renew_dt,le.avelength_reg_exp_dt,le.avelength_title_nbr,le.avelength_org_title_dt,le.avelength_title_trans_dt,le.avelength_name_typ_cd,le.avelength_owner_typ_cd,le.avelength_first_nm,le.avelength_middle_nm,le.avelength_last_nm,le.avelength_name_suffix,le.avelength_prof_suffix,le.avelength_ind_ssn,le.avelength_ind_dob,le.avelength_mail_range,le.avelength_m_pre_dir,le.avelength_m_street,le.avelength_m_suffix,le.avelength_m_post_dir,le.avelength_m_pob,le.avelength_m_rr_nbr,le.avelength_m_rr_box,le.avelength_m_scndry_rng,le.avelength_m_scndry_des,le.avelength_m_city,le.avelength_m_state,le.avelength_m_zip5,le.avelength_m_zip4,le.avelength_m_cntry_cd,le.avelength_m_cc_filler,le.avelength_m_cc,le.avelength_m_county,le.avelength_phys_range,le.avelength_p_pre_dir,le.avelength_p_street,le.avelength_p_suffix,le.avelength_p_post_dir,le.avelength_p_pob,le.avelength_p_rr_nbr,le.avelength_p_rr_box,le.avelength_p_scndry_rng,le.avelength_p_scndry_des,le.avelength_p_city,le.avelength_p_state,le.avelength_p_zip5,le.avelength_p_zip4,le.avelength_p_cntry_cd,le.avelength_p_cc_filler,le.avelength_p_cc,le.avelength_p_county,le.avelength_opt_out_cd,le.avelength_asg_wgt,le.avelength_asg_wgt_uom,le.avelength_source_ctl_id,le.avelength_raw_name,le.avelength_branded_title_flag,le.avelength_brand_code_1,le.avelength_brand_date_1,le.avelength_brand_state_1,le.avelength_brand_code_2,le.avelength_brand_date_2,le.avelength_brand_state_2,le.avelength_brand_code_3,le.avelength_brand_date_3,le.avelength_brand_state_3,le.avelength_brand_code_4,le.avelength_brand_date_4,le.avelength_brand_state_4,le.avelength_brand_code_5,le.avelength_brand_date_5,le.avelength_brand_state_5,le.avelength_tod_flag,le.avelength_model_class_code,le.avelength_model_class,le.avelength_min_door_count,le.avelength_safety_type,le.avelength_airbag_driver,le.avelength_airbag_front_driver_side,le.avelength_airbag_front_head_curtain,le.avelength_airbag_front_pass,le.avelength_airbag_front_pass_side,le.avelength_airbags);
END;
EXPORT invSummary := NORMALIZE(summary0, 110, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.append_state_origin;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.append_process_date),TRIM((SALT311.StrType)le.append_state_origin),TRIM((SALT311.StrType)le.file_typ),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.vehicle_typ),TRIM((SALT311.StrType)le.model_yr),TRIM((SALT311.StrType)le.model_yr_ind),TRIM((SALT311.StrType)le.make),TRIM((SALT311.StrType)le.make_ind),TRIM((SALT311.StrType)le.series),TRIM((SALT311.StrType)le.series_ind),TRIM((SALT311.StrType)le.prime_color),TRIM((SALT311.StrType)le.second_color),TRIM((SALT311.StrType)le.body_style),TRIM((SALT311.StrType)le.body_style_ind),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.model_ind),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.lengt),TRIM((SALT311.StrType)le.axle_cnt),TRIM((SALT311.StrType)le.plate_nbr),TRIM((SALT311.StrType)le.plate_state),TRIM((SALT311.StrType)le.prev_plate_nbr),TRIM((SALT311.StrType)le.prev_plate_state),TRIM((SALT311.StrType)le.plate_typ_cd),TRIM((SALT311.StrType)le.mstr_src_state),TRIM((SALT311.StrType)le.reg_decal_nbr),TRIM((SALT311.StrType)le.org_reg_dt),TRIM((SALT311.StrType)le.reg_renew_dt),TRIM((SALT311.StrType)le.reg_exp_dt),TRIM((SALT311.StrType)le.title_nbr),TRIM((SALT311.StrType)le.org_title_dt),TRIM((SALT311.StrType)le.title_trans_dt),TRIM((SALT311.StrType)le.name_typ_cd),TRIM((SALT311.StrType)le.owner_typ_cd),TRIM((SALT311.StrType)le.first_nm),TRIM((SALT311.StrType)le.middle_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.prof_suffix),TRIM((SALT311.StrType)le.ind_ssn),TRIM((SALT311.StrType)le.ind_dob),TRIM((SALT311.StrType)le.mail_range),TRIM((SALT311.StrType)le.m_pre_dir),TRIM((SALT311.StrType)le.m_street),TRIM((SALT311.StrType)le.m_suffix),TRIM((SALT311.StrType)le.m_post_dir),TRIM((SALT311.StrType)le.m_pob),TRIM((SALT311.StrType)le.m_rr_nbr),TRIM((SALT311.StrType)le.m_rr_box),TRIM((SALT311.StrType)le.m_scndry_rng),TRIM((SALT311.StrType)le.m_scndry_des),TRIM((SALT311.StrType)le.m_city),TRIM((SALT311.StrType)le.m_state),TRIM((SALT311.StrType)le.m_zip5),TRIM((SALT311.StrType)le.m_zip4),TRIM((SALT311.StrType)le.m_cntry_cd),TRIM((SALT311.StrType)le.m_cc_filler),TRIM((SALT311.StrType)le.m_cc),TRIM((SALT311.StrType)le.m_county),TRIM((SALT311.StrType)le.phys_range),TRIM((SALT311.StrType)le.p_pre_dir),TRIM((SALT311.StrType)le.p_street),TRIM((SALT311.StrType)le.p_suffix),TRIM((SALT311.StrType)le.p_post_dir),TRIM((SALT311.StrType)le.p_pob),TRIM((SALT311.StrType)le.p_rr_nbr),TRIM((SALT311.StrType)le.p_rr_box),TRIM((SALT311.StrType)le.p_scndry_rng),TRIM((SALT311.StrType)le.p_scndry_des),TRIM((SALT311.StrType)le.p_city),TRIM((SALT311.StrType)le.p_state),TRIM((SALT311.StrType)le.p_zip5),TRIM((SALT311.StrType)le.p_zip4),TRIM((SALT311.StrType)le.p_cntry_cd),TRIM((SALT311.StrType)le.p_cc_filler),TRIM((SALT311.StrType)le.p_cc),TRIM((SALT311.StrType)le.p_county),TRIM((SALT311.StrType)le.opt_out_cd),TRIM((SALT311.StrType)le.asg_wgt),TRIM((SALT311.StrType)le.asg_wgt_uom),TRIM((SALT311.StrType)le.source_ctl_id),TRIM((SALT311.StrType)le.raw_name),TRIM((SALT311.StrType)le.branded_title_flag),TRIM((SALT311.StrType)le.brand_code_1),TRIM((SALT311.StrType)le.brand_date_1),TRIM((SALT311.StrType)le.brand_state_1),TRIM((SALT311.StrType)le.brand_code_2),TRIM((SALT311.StrType)le.brand_date_2),TRIM((SALT311.StrType)le.brand_state_2),TRIM((SALT311.StrType)le.brand_code_3),TRIM((SALT311.StrType)le.brand_date_3),TRIM((SALT311.StrType)le.brand_state_3),TRIM((SALT311.StrType)le.brand_code_4),TRIM((SALT311.StrType)le.brand_date_4),TRIM((SALT311.StrType)le.brand_state_4),TRIM((SALT311.StrType)le.brand_code_5),TRIM((SALT311.StrType)le.brand_date_5),TRIM((SALT311.StrType)le.brand_state_5),TRIM((SALT311.StrType)le.tod_flag),TRIM((SALT311.StrType)le.model_class_code),TRIM((SALT311.StrType)le.model_class),TRIM((SALT311.StrType)le.min_door_count),TRIM((SALT311.StrType)le.safety_type),TRIM((SALT311.StrType)le.airbag_driver),TRIM((SALT311.StrType)le.airbag_front_driver_side),TRIM((SALT311.StrType)le.airbag_front_head_curtain),TRIM((SALT311.StrType)le.airbag_front_pass),TRIM((SALT311.StrType)le.airbag_front_pass_side),TRIM((SALT311.StrType)le.airbags)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,110,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 110);
  SELF.FldNo2 := 1 + (C % 110);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.append_process_date),TRIM((SALT311.StrType)le.append_state_origin),TRIM((SALT311.StrType)le.file_typ),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.vehicle_typ),TRIM((SALT311.StrType)le.model_yr),TRIM((SALT311.StrType)le.model_yr_ind),TRIM((SALT311.StrType)le.make),TRIM((SALT311.StrType)le.make_ind),TRIM((SALT311.StrType)le.series),TRIM((SALT311.StrType)le.series_ind),TRIM((SALT311.StrType)le.prime_color),TRIM((SALT311.StrType)le.second_color),TRIM((SALT311.StrType)le.body_style),TRIM((SALT311.StrType)le.body_style_ind),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.model_ind),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.lengt),TRIM((SALT311.StrType)le.axle_cnt),TRIM((SALT311.StrType)le.plate_nbr),TRIM((SALT311.StrType)le.plate_state),TRIM((SALT311.StrType)le.prev_plate_nbr),TRIM((SALT311.StrType)le.prev_plate_state),TRIM((SALT311.StrType)le.plate_typ_cd),TRIM((SALT311.StrType)le.mstr_src_state),TRIM((SALT311.StrType)le.reg_decal_nbr),TRIM((SALT311.StrType)le.org_reg_dt),TRIM((SALT311.StrType)le.reg_renew_dt),TRIM((SALT311.StrType)le.reg_exp_dt),TRIM((SALT311.StrType)le.title_nbr),TRIM((SALT311.StrType)le.org_title_dt),TRIM((SALT311.StrType)le.title_trans_dt),TRIM((SALT311.StrType)le.name_typ_cd),TRIM((SALT311.StrType)le.owner_typ_cd),TRIM((SALT311.StrType)le.first_nm),TRIM((SALT311.StrType)le.middle_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.prof_suffix),TRIM((SALT311.StrType)le.ind_ssn),TRIM((SALT311.StrType)le.ind_dob),TRIM((SALT311.StrType)le.mail_range),TRIM((SALT311.StrType)le.m_pre_dir),TRIM((SALT311.StrType)le.m_street),TRIM((SALT311.StrType)le.m_suffix),TRIM((SALT311.StrType)le.m_post_dir),TRIM((SALT311.StrType)le.m_pob),TRIM((SALT311.StrType)le.m_rr_nbr),TRIM((SALT311.StrType)le.m_rr_box),TRIM((SALT311.StrType)le.m_scndry_rng),TRIM((SALT311.StrType)le.m_scndry_des),TRIM((SALT311.StrType)le.m_city),TRIM((SALT311.StrType)le.m_state),TRIM((SALT311.StrType)le.m_zip5),TRIM((SALT311.StrType)le.m_zip4),TRIM((SALT311.StrType)le.m_cntry_cd),TRIM((SALT311.StrType)le.m_cc_filler),TRIM((SALT311.StrType)le.m_cc),TRIM((SALT311.StrType)le.m_county),TRIM((SALT311.StrType)le.phys_range),TRIM((SALT311.StrType)le.p_pre_dir),TRIM((SALT311.StrType)le.p_street),TRIM((SALT311.StrType)le.p_suffix),TRIM((SALT311.StrType)le.p_post_dir),TRIM((SALT311.StrType)le.p_pob),TRIM((SALT311.StrType)le.p_rr_nbr),TRIM((SALT311.StrType)le.p_rr_box),TRIM((SALT311.StrType)le.p_scndry_rng),TRIM((SALT311.StrType)le.p_scndry_des),TRIM((SALT311.StrType)le.p_city),TRIM((SALT311.StrType)le.p_state),TRIM((SALT311.StrType)le.p_zip5),TRIM((SALT311.StrType)le.p_zip4),TRIM((SALT311.StrType)le.p_cntry_cd),TRIM((SALT311.StrType)le.p_cc_filler),TRIM((SALT311.StrType)le.p_cc),TRIM((SALT311.StrType)le.p_county),TRIM((SALT311.StrType)le.opt_out_cd),TRIM((SALT311.StrType)le.asg_wgt),TRIM((SALT311.StrType)le.asg_wgt_uom),TRIM((SALT311.StrType)le.source_ctl_id),TRIM((SALT311.StrType)le.raw_name),TRIM((SALT311.StrType)le.branded_title_flag),TRIM((SALT311.StrType)le.brand_code_1),TRIM((SALT311.StrType)le.brand_date_1),TRIM((SALT311.StrType)le.brand_state_1),TRIM((SALT311.StrType)le.brand_code_2),TRIM((SALT311.StrType)le.brand_date_2),TRIM((SALT311.StrType)le.brand_state_2),TRIM((SALT311.StrType)le.brand_code_3),TRIM((SALT311.StrType)le.brand_date_3),TRIM((SALT311.StrType)le.brand_state_3),TRIM((SALT311.StrType)le.brand_code_4),TRIM((SALT311.StrType)le.brand_date_4),TRIM((SALT311.StrType)le.brand_state_4),TRIM((SALT311.StrType)le.brand_code_5),TRIM((SALT311.StrType)le.brand_date_5),TRIM((SALT311.StrType)le.brand_state_5),TRIM((SALT311.StrType)le.tod_flag),TRIM((SALT311.StrType)le.model_class_code),TRIM((SALT311.StrType)le.model_class),TRIM((SALT311.StrType)le.min_door_count),TRIM((SALT311.StrType)le.safety_type),TRIM((SALT311.StrType)le.airbag_driver),TRIM((SALT311.StrType)le.airbag_front_driver_side),TRIM((SALT311.StrType)le.airbag_front_head_curtain),TRIM((SALT311.StrType)le.airbag_front_pass),TRIM((SALT311.StrType)le.airbag_front_pass_side),TRIM((SALT311.StrType)le.airbags)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.append_process_date),TRIM((SALT311.StrType)le.append_state_origin),TRIM((SALT311.StrType)le.file_typ),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.vehicle_typ),TRIM((SALT311.StrType)le.model_yr),TRIM((SALT311.StrType)le.model_yr_ind),TRIM((SALT311.StrType)le.make),TRIM((SALT311.StrType)le.make_ind),TRIM((SALT311.StrType)le.series),TRIM((SALT311.StrType)le.series_ind),TRIM((SALT311.StrType)le.prime_color),TRIM((SALT311.StrType)le.second_color),TRIM((SALT311.StrType)le.body_style),TRIM((SALT311.StrType)le.body_style_ind),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.model_ind),TRIM((SALT311.StrType)le.weight),TRIM((SALT311.StrType)le.lengt),TRIM((SALT311.StrType)le.axle_cnt),TRIM((SALT311.StrType)le.plate_nbr),TRIM((SALT311.StrType)le.plate_state),TRIM((SALT311.StrType)le.prev_plate_nbr),TRIM((SALT311.StrType)le.prev_plate_state),TRIM((SALT311.StrType)le.plate_typ_cd),TRIM((SALT311.StrType)le.mstr_src_state),TRIM((SALT311.StrType)le.reg_decal_nbr),TRIM((SALT311.StrType)le.org_reg_dt),TRIM((SALT311.StrType)le.reg_renew_dt),TRIM((SALT311.StrType)le.reg_exp_dt),TRIM((SALT311.StrType)le.title_nbr),TRIM((SALT311.StrType)le.org_title_dt),TRIM((SALT311.StrType)le.title_trans_dt),TRIM((SALT311.StrType)le.name_typ_cd),TRIM((SALT311.StrType)le.owner_typ_cd),TRIM((SALT311.StrType)le.first_nm),TRIM((SALT311.StrType)le.middle_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.prof_suffix),TRIM((SALT311.StrType)le.ind_ssn),TRIM((SALT311.StrType)le.ind_dob),TRIM((SALT311.StrType)le.mail_range),TRIM((SALT311.StrType)le.m_pre_dir),TRIM((SALT311.StrType)le.m_street),TRIM((SALT311.StrType)le.m_suffix),TRIM((SALT311.StrType)le.m_post_dir),TRIM((SALT311.StrType)le.m_pob),TRIM((SALT311.StrType)le.m_rr_nbr),TRIM((SALT311.StrType)le.m_rr_box),TRIM((SALT311.StrType)le.m_scndry_rng),TRIM((SALT311.StrType)le.m_scndry_des),TRIM((SALT311.StrType)le.m_city),TRIM((SALT311.StrType)le.m_state),TRIM((SALT311.StrType)le.m_zip5),TRIM((SALT311.StrType)le.m_zip4),TRIM((SALT311.StrType)le.m_cntry_cd),TRIM((SALT311.StrType)le.m_cc_filler),TRIM((SALT311.StrType)le.m_cc),TRIM((SALT311.StrType)le.m_county),TRIM((SALT311.StrType)le.phys_range),TRIM((SALT311.StrType)le.p_pre_dir),TRIM((SALT311.StrType)le.p_street),TRIM((SALT311.StrType)le.p_suffix),TRIM((SALT311.StrType)le.p_post_dir),TRIM((SALT311.StrType)le.p_pob),TRIM((SALT311.StrType)le.p_rr_nbr),TRIM((SALT311.StrType)le.p_rr_box),TRIM((SALT311.StrType)le.p_scndry_rng),TRIM((SALT311.StrType)le.p_scndry_des),TRIM((SALT311.StrType)le.p_city),TRIM((SALT311.StrType)le.p_state),TRIM((SALT311.StrType)le.p_zip5),TRIM((SALT311.StrType)le.p_zip4),TRIM((SALT311.StrType)le.p_cntry_cd),TRIM((SALT311.StrType)le.p_cc_filler),TRIM((SALT311.StrType)le.p_cc),TRIM((SALT311.StrType)le.p_county),TRIM((SALT311.StrType)le.opt_out_cd),TRIM((SALT311.StrType)le.asg_wgt),TRIM((SALT311.StrType)le.asg_wgt_uom),TRIM((SALT311.StrType)le.source_ctl_id),TRIM((SALT311.StrType)le.raw_name),TRIM((SALT311.StrType)le.branded_title_flag),TRIM((SALT311.StrType)le.brand_code_1),TRIM((SALT311.StrType)le.brand_date_1),TRIM((SALT311.StrType)le.brand_state_1),TRIM((SALT311.StrType)le.brand_code_2),TRIM((SALT311.StrType)le.brand_date_2),TRIM((SALT311.StrType)le.brand_state_2),TRIM((SALT311.StrType)le.brand_code_3),TRIM((SALT311.StrType)le.brand_date_3),TRIM((SALT311.StrType)le.brand_state_3),TRIM((SALT311.StrType)le.brand_code_4),TRIM((SALT311.StrType)le.brand_date_4),TRIM((SALT311.StrType)le.brand_state_4),TRIM((SALT311.StrType)le.brand_code_5),TRIM((SALT311.StrType)le.brand_date_5),TRIM((SALT311.StrType)le.brand_state_5),TRIM((SALT311.StrType)le.tod_flag),TRIM((SALT311.StrType)le.model_class_code),TRIM((SALT311.StrType)le.model_class),TRIM((SALT311.StrType)le.min_door_count),TRIM((SALT311.StrType)le.safety_type),TRIM((SALT311.StrType)le.airbag_driver),TRIM((SALT311.StrType)le.airbag_front_driver_side),TRIM((SALT311.StrType)le.airbag_front_head_curtain),TRIM((SALT311.StrType)le.airbag_front_pass),TRIM((SALT311.StrType)le.airbag_front_pass_side),TRIM((SALT311.StrType)le.airbags)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),110*110,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'append_state_origin'}
      ,{3,'file_typ'}
      ,{4,'vin'}
      ,{5,'vehicle_typ'}
      ,{6,'model_yr'}
      ,{7,'model_yr_ind'}
      ,{8,'make'}
      ,{9,'make_ind'}
      ,{10,'series'}
      ,{11,'series_ind'}
      ,{12,'prime_color'}
      ,{13,'second_color'}
      ,{14,'body_style'}
      ,{15,'body_style_ind'}
      ,{16,'model'}
      ,{17,'model_ind'}
      ,{18,'weight'}
      ,{19,'lengt'}
      ,{20,'axle_cnt'}
      ,{21,'plate_nbr'}
      ,{22,'plate_state'}
      ,{23,'prev_plate_nbr'}
      ,{24,'prev_plate_state'}
      ,{25,'plate_typ_cd'}
      ,{26,'mstr_src_state'}
      ,{27,'reg_decal_nbr'}
      ,{28,'org_reg_dt'}
      ,{29,'reg_renew_dt'}
      ,{30,'reg_exp_dt'}
      ,{31,'title_nbr'}
      ,{32,'org_title_dt'}
      ,{33,'title_trans_dt'}
      ,{34,'name_typ_cd'}
      ,{35,'owner_typ_cd'}
      ,{36,'first_nm'}
      ,{37,'middle_nm'}
      ,{38,'last_nm'}
      ,{39,'name_suffix'}
      ,{40,'prof_suffix'}
      ,{41,'ind_ssn'}
      ,{42,'ind_dob'}
      ,{43,'mail_range'}
      ,{44,'m_pre_dir'}
      ,{45,'m_street'}
      ,{46,'m_suffix'}
      ,{47,'m_post_dir'}
      ,{48,'m_pob'}
      ,{49,'m_rr_nbr'}
      ,{50,'m_rr_box'}
      ,{51,'m_scndry_rng'}
      ,{52,'m_scndry_des'}
      ,{53,'m_city'}
      ,{54,'m_state'}
      ,{55,'m_zip5'}
      ,{56,'m_zip4'}
      ,{57,'m_cntry_cd'}
      ,{58,'m_cc_filler'}
      ,{59,'m_cc'}
      ,{60,'m_county'}
      ,{61,'phys_range'}
      ,{62,'p_pre_dir'}
      ,{63,'p_street'}
      ,{64,'p_suffix'}
      ,{65,'p_post_dir'}
      ,{66,'p_pob'}
      ,{67,'p_rr_nbr'}
      ,{68,'p_rr_box'}
      ,{69,'p_scndry_rng'}
      ,{70,'p_scndry_des'}
      ,{71,'p_city'}
      ,{72,'p_state'}
      ,{73,'p_zip5'}
      ,{74,'p_zip4'}
      ,{75,'p_cntry_cd'}
      ,{76,'p_cc_filler'}
      ,{77,'p_cc'}
      ,{78,'p_county'}
      ,{79,'opt_out_cd'}
      ,{80,'asg_wgt'}
      ,{81,'asg_wgt_uom'}
      ,{82,'source_ctl_id'}
      ,{83,'raw_name'}
      ,{84,'branded_title_flag'}
      ,{85,'brand_code_1'}
      ,{86,'brand_date_1'}
      ,{87,'brand_state_1'}
      ,{88,'brand_code_2'}
      ,{89,'brand_date_2'}
      ,{90,'brand_state_2'}
      ,{91,'brand_code_3'}
      ,{92,'brand_date_3'}
      ,{93,'brand_state_3'}
      ,{94,'brand_code_4'}
      ,{95,'brand_date_4'}
      ,{96,'brand_state_4'}
      ,{97,'brand_code_5'}
      ,{98,'brand_date_5'}
      ,{99,'brand_state_5'}
      ,{100,'tod_flag'}
      ,{101,'model_class_code'}
      ,{102,'model_class'}
      ,{103,'min_door_count'}
      ,{104,'safety_type'}
      ,{105,'airbag_driver'}
      ,{106,'airbag_front_driver_side'}
      ,{107,'airbag_front_head_curtain'}
      ,{108,'airbag_front_pass'}
      ,{109,'airbag_front_pass_side'}
      ,{110,'airbags'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.append_state_origin) append_state_origin; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Experian_Fields.InValid_append_process_date((SALT311.StrType)le.append_process_date),
    Experian_Fields.InValid_append_state_origin((SALT311.StrType)le.append_state_origin),
    Experian_Fields.InValid_file_typ((SALT311.StrType)le.file_typ),
    Experian_Fields.InValid_vin((SALT311.StrType)le.vin),
    Experian_Fields.InValid_vehicle_typ((SALT311.StrType)le.vehicle_typ),
    Experian_Fields.InValid_model_yr((SALT311.StrType)le.model_yr),
    Experian_Fields.InValid_model_yr_ind((SALT311.StrType)le.model_yr_ind),
    Experian_Fields.InValid_make((SALT311.StrType)le.make),
    Experian_Fields.InValid_make_ind((SALT311.StrType)le.make_ind),
    Experian_Fields.InValid_series((SALT311.StrType)le.series),
    Experian_Fields.InValid_series_ind((SALT311.StrType)le.series_ind),
    Experian_Fields.InValid_prime_color((SALT311.StrType)le.prime_color),
    Experian_Fields.InValid_second_color((SALT311.StrType)le.second_color),
    Experian_Fields.InValid_body_style((SALT311.StrType)le.body_style),
    Experian_Fields.InValid_body_style_ind((SALT311.StrType)le.body_style_ind),
    Experian_Fields.InValid_model((SALT311.StrType)le.model),
    Experian_Fields.InValid_model_ind((SALT311.StrType)le.model_ind),
    Experian_Fields.InValid_weight((SALT311.StrType)le.weight),
    Experian_Fields.InValid_lengt((SALT311.StrType)le.lengt),
    Experian_Fields.InValid_axle_cnt((SALT311.StrType)le.axle_cnt),
    Experian_Fields.InValid_plate_nbr((SALT311.StrType)le.plate_nbr),
    Experian_Fields.InValid_plate_state((SALT311.StrType)le.plate_state),
    Experian_Fields.InValid_prev_plate_nbr((SALT311.StrType)le.prev_plate_nbr),
    Experian_Fields.InValid_prev_plate_state((SALT311.StrType)le.prev_plate_state),
    Experian_Fields.InValid_plate_typ_cd((SALT311.StrType)le.plate_typ_cd),
    Experian_Fields.InValid_mstr_src_state((SALT311.StrType)le.mstr_src_state),
    Experian_Fields.InValid_reg_decal_nbr((SALT311.StrType)le.reg_decal_nbr),
    Experian_Fields.InValid_org_reg_dt((SALT311.StrType)le.org_reg_dt),
    Experian_Fields.InValid_reg_renew_dt((SALT311.StrType)le.reg_renew_dt),
    Experian_Fields.InValid_reg_exp_dt((SALT311.StrType)le.reg_exp_dt),
    Experian_Fields.InValid_title_nbr((SALT311.StrType)le.title_nbr),
    Experian_Fields.InValid_org_title_dt((SALT311.StrType)le.org_title_dt),
    Experian_Fields.InValid_title_trans_dt((SALT311.StrType)le.title_trans_dt),
    Experian_Fields.InValid_name_typ_cd((SALT311.StrType)le.name_typ_cd),
    Experian_Fields.InValid_owner_typ_cd((SALT311.StrType)le.owner_typ_cd),
    Experian_Fields.InValid_first_nm((SALT311.StrType)le.first_nm),
    Experian_Fields.InValid_middle_nm((SALT311.StrType)le.middle_nm),
    Experian_Fields.InValid_last_nm((SALT311.StrType)le.last_nm),
    Experian_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Experian_Fields.InValid_prof_suffix((SALT311.StrType)le.prof_suffix),
    Experian_Fields.InValid_ind_ssn((SALT311.StrType)le.ind_ssn),
    Experian_Fields.InValid_ind_dob((SALT311.StrType)le.ind_dob),
    Experian_Fields.InValid_mail_range((SALT311.StrType)le.mail_range),
    Experian_Fields.InValid_m_pre_dir((SALT311.StrType)le.m_pre_dir),
    Experian_Fields.InValid_m_street((SALT311.StrType)le.m_street),
    Experian_Fields.InValid_m_suffix((SALT311.StrType)le.m_suffix),
    Experian_Fields.InValid_m_post_dir((SALT311.StrType)le.m_post_dir),
    Experian_Fields.InValid_m_pob((SALT311.StrType)le.m_pob),
    Experian_Fields.InValid_m_rr_nbr((SALT311.StrType)le.m_rr_nbr),
    Experian_Fields.InValid_m_rr_box((SALT311.StrType)le.m_rr_box),
    Experian_Fields.InValid_m_scndry_rng((SALT311.StrType)le.m_scndry_rng),
    Experian_Fields.InValid_m_scndry_des((SALT311.StrType)le.m_scndry_des),
    Experian_Fields.InValid_m_city((SALT311.StrType)le.m_city),
    Experian_Fields.InValid_m_state((SALT311.StrType)le.m_state),
    Experian_Fields.InValid_m_zip5((SALT311.StrType)le.m_zip5),
    Experian_Fields.InValid_m_zip4((SALT311.StrType)le.m_zip4),
    Experian_Fields.InValid_m_cntry_cd((SALT311.StrType)le.m_cntry_cd),
    Experian_Fields.InValid_m_cc_filler((SALT311.StrType)le.m_cc_filler),
    Experian_Fields.InValid_m_cc((SALT311.StrType)le.m_cc),
    Experian_Fields.InValid_m_county((SALT311.StrType)le.m_county),
    Experian_Fields.InValid_phys_range((SALT311.StrType)le.phys_range),
    Experian_Fields.InValid_p_pre_dir((SALT311.StrType)le.p_pre_dir),
    Experian_Fields.InValid_p_street((SALT311.StrType)le.p_street),
    Experian_Fields.InValid_p_suffix((SALT311.StrType)le.p_suffix),
    Experian_Fields.InValid_p_post_dir((SALT311.StrType)le.p_post_dir),
    Experian_Fields.InValid_p_pob((SALT311.StrType)le.p_pob),
    Experian_Fields.InValid_p_rr_nbr((SALT311.StrType)le.p_rr_nbr),
    Experian_Fields.InValid_p_rr_box((SALT311.StrType)le.p_rr_box),
    Experian_Fields.InValid_p_scndry_rng((SALT311.StrType)le.p_scndry_rng),
    Experian_Fields.InValid_p_scndry_des((SALT311.StrType)le.p_scndry_des),
    Experian_Fields.InValid_p_city((SALT311.StrType)le.p_city),
    Experian_Fields.InValid_p_state((SALT311.StrType)le.p_state),
    Experian_Fields.InValid_p_zip5((SALT311.StrType)le.p_zip5),
    Experian_Fields.InValid_p_zip4((SALT311.StrType)le.p_zip4),
    Experian_Fields.InValid_p_cntry_cd((SALT311.StrType)le.p_cntry_cd),
    Experian_Fields.InValid_p_cc_filler((SALT311.StrType)le.p_cc_filler),
    Experian_Fields.InValid_p_cc((SALT311.StrType)le.p_cc),
    Experian_Fields.InValid_p_county((SALT311.StrType)le.p_county),
    Experian_Fields.InValid_opt_out_cd((SALT311.StrType)le.opt_out_cd),
    Experian_Fields.InValid_asg_wgt((SALT311.StrType)le.asg_wgt),
    Experian_Fields.InValid_asg_wgt_uom((SALT311.StrType)le.asg_wgt_uom),
    Experian_Fields.InValid_source_ctl_id((SALT311.StrType)le.source_ctl_id),
    Experian_Fields.InValid_raw_name((SALT311.StrType)le.raw_name),
    Experian_Fields.InValid_branded_title_flag((SALT311.StrType)le.branded_title_flag),
    Experian_Fields.InValid_brand_code_1((SALT311.StrType)le.brand_code_1),
    Experian_Fields.InValid_brand_date_1((SALT311.StrType)le.brand_date_1),
    Experian_Fields.InValid_brand_state_1((SALT311.StrType)le.brand_state_1),
    Experian_Fields.InValid_brand_code_2((SALT311.StrType)le.brand_code_2),
    Experian_Fields.InValid_brand_date_2((SALT311.StrType)le.brand_date_2),
    Experian_Fields.InValid_brand_state_2((SALT311.StrType)le.brand_state_2),
    Experian_Fields.InValid_brand_code_3((SALT311.StrType)le.brand_code_3),
    Experian_Fields.InValid_brand_date_3((SALT311.StrType)le.brand_date_3),
    Experian_Fields.InValid_brand_state_3((SALT311.StrType)le.brand_state_3),
    Experian_Fields.InValid_brand_code_4((SALT311.StrType)le.brand_code_4),
    Experian_Fields.InValid_brand_date_4((SALT311.StrType)le.brand_date_4),
    Experian_Fields.InValid_brand_state_4((SALT311.StrType)le.brand_state_4),
    Experian_Fields.InValid_brand_code_5((SALT311.StrType)le.brand_code_5),
    Experian_Fields.InValid_brand_date_5((SALT311.StrType)le.brand_date_5),
    Experian_Fields.InValid_brand_state_5((SALT311.StrType)le.brand_state_5),
    Experian_Fields.InValid_tod_flag((SALT311.StrType)le.tod_flag),
    Experian_Fields.InValid_model_class_code((SALT311.StrType)le.model_class_code),
    Experian_Fields.InValid_model_class((SALT311.StrType)le.model_class),
    Experian_Fields.InValid_min_door_count((SALT311.StrType)le.min_door_count),
    Experian_Fields.InValid_safety_type((SALT311.StrType)le.safety_type),
    Experian_Fields.InValid_airbag_driver((SALT311.StrType)le.airbag_driver),
    Experian_Fields.InValid_airbag_front_driver_side((SALT311.StrType)le.airbag_front_driver_side),
    Experian_Fields.InValid_airbag_front_head_curtain((SALT311.StrType)le.airbag_front_head_curtain),
    Experian_Fields.InValid_airbag_front_pass((SALT311.StrType)le.airbag_front_pass),
    Experian_Fields.InValid_airbag_front_pass_side((SALT311.StrType)le.airbag_front_pass_side),
    Experian_Fields.InValid_airbags((SALT311.StrType)le.airbags),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.append_state_origin := le.append_state_origin;
END;
Errors := NORMALIZE(h,110,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.append_state_origin;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,append_state_origin,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.append_state_origin;
  FieldNme := Experian_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_state','invalid_file_typ','invalid_vin','invalid_vehicle_typ','invalid_year','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_only_alpha','invalid_only_alpha','invalid_alpha','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_weight','invalid_number','invalid_number','invalid_alpha','invalid_state','invalid_alpha','invalid_state','invalid_only_alpha','invalid_state','invalid_alphanumeric','invalid_date','invalid_date','invalid_date','invalid_alphanumeric','invalid_date','invalid_date','invalid_name_typ_cd','invalid_owner_typ_cd','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_ssn','invalid_date','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','Unknown','Unknown','invalid_cc','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','Unknown','Unknown','invalid_cc','invalid_alpha','invalid_opt_out_cd','invalid_number','invalid_only_alpha','invalid_number','invalid_alpha','invalid_yes_no','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_yes_no','Unknown','invalid_alpha','invalid_min_door_count','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Experian_Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_append_state_origin(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_file_typ(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_vin(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_vehicle_typ(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_model_yr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_model_yr_ind(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_make(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_make_ind(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_series(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_series_ind(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_prime_color(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_second_color(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_body_style(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_body_style_ind(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_model(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_model_ind(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_weight(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_lengt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_axle_cnt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_plate_nbr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_plate_state(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_prev_plate_nbr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_prev_plate_state(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_plate_typ_cd(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_mstr_src_state(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_reg_decal_nbr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_org_reg_dt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_reg_renew_dt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_reg_exp_dt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_title_nbr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_org_title_dt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_title_trans_dt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_name_typ_cd(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_owner_typ_cd(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_first_nm(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_middle_nm(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_last_nm(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_prof_suffix(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_ind_ssn(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_ind_dob(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_mail_range(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_pre_dir(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_street(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_suffix(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_post_dir(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_pob(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_rr_nbr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_rr_box(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_scndry_rng(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_scndry_des(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_city(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_state(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_zip5(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_zip4(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_cntry_cd(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_cc_filler(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_cc(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_m_county(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_phys_range(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_pre_dir(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_street(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_suffix(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_post_dir(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_pob(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_rr_nbr(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_rr_box(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_scndry_rng(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_scndry_des(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_city(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_state(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_zip5(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_zip4(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_cntry_cd(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_cc_filler(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_cc(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_p_county(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_opt_out_cd(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_asg_wgt(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_asg_wgt_uom(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_source_ctl_id(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_raw_name(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_branded_title_flag(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_code_1(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_date_1(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_state_1(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_code_2(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_date_2(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_state_2(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_code_3(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_date_3(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_state_3(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_code_4(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_date_4(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_state_4(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_code_5(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_date_5(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_brand_state_5(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_tod_flag(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_model_class_code(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_model_class(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_min_door_count(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_safety_type(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_airbag_driver(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_airbag_front_driver_side(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_airbag_front_head_curtain(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_airbag_front_pass(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_airbag_front_pass_side(TotalErrors.ErrorNum),Experian_Fields.InValidMessage_airbags(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.append_state_origin=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_VehicleV2, Experian_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));

  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));

  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
