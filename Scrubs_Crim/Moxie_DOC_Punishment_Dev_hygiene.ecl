IMPORT ut,SALT33;
EXPORT Moxie_DOC_Punishment_Dev_hygiene(dataset(Moxie_DOC_Punishment_Dev_layout_crim) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.vendor);    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_offender_key_pcnt := AVE(GROUP,IF(h.offender_key = (TYPEOF(h.offender_key))'',0,100));
    maxlength_offender_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_key)));
    avelength_offender_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_key)),h.offender_key<>(typeof(h.offender_key))'');
    populated_event_dt_pcnt := AVE(GROUP,IF(h.event_dt = (TYPEOF(h.event_dt))'',0,100));
    maxlength_event_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.event_dt)));
    avelength_event_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.event_dt)),h.event_dt<>(typeof(h.event_dt))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_offense_key_pcnt := AVE(GROUP,IF(h.offense_key = (TYPEOF(h.offense_key))'',0,100));
    maxlength_offense_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_key)));
    avelength_offense_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_key)),h.offense_key<>(typeof(h.offense_key))'');
    populated_punishment_type_pcnt := AVE(GROUP,IF(h.punishment_type = (TYPEOF(h.punishment_type))'',0,100));
    maxlength_punishment_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.punishment_type)));
    avelength_punishment_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.punishment_type)),h.punishment_type<>(typeof(h.punishment_type))'');
    populated_sent_date_pcnt := AVE(GROUP,IF(h.sent_date = (TYPEOF(h.sent_date))'',0,100));
    maxlength_sent_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sent_date)));
    avelength_sent_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sent_date)),h.sent_date<>(typeof(h.sent_date))'');
    populated_sent_length_pcnt := AVE(GROUP,IF(h.sent_length = (TYPEOF(h.sent_length))'',0,100));
    maxlength_sent_length := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sent_length)));
    avelength_sent_length := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sent_length)),h.sent_length<>(typeof(h.sent_length))'');
    populated_sent_length_desc_pcnt := AVE(GROUP,IF(h.sent_length_desc = (TYPEOF(h.sent_length_desc))'',0,100));
    maxlength_sent_length_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sent_length_desc)));
    avelength_sent_length_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sent_length_desc)),h.sent_length_desc<>(typeof(h.sent_length_desc))'');
    populated_cur_stat_inm_pcnt := AVE(GROUP,IF(h.cur_stat_inm = (TYPEOF(h.cur_stat_inm))'',0,100));
    maxlength_cur_stat_inm := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_stat_inm)));
    avelength_cur_stat_inm := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_stat_inm)),h.cur_stat_inm<>(typeof(h.cur_stat_inm))'');
    populated_cur_stat_inm_desc_pcnt := AVE(GROUP,IF(h.cur_stat_inm_desc = (TYPEOF(h.cur_stat_inm_desc))'',0,100));
    maxlength_cur_stat_inm_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_stat_inm_desc)));
    avelength_cur_stat_inm_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_stat_inm_desc)),h.cur_stat_inm_desc<>(typeof(h.cur_stat_inm_desc))'');
    populated_cur_loc_inm_cd_pcnt := AVE(GROUP,IF(h.cur_loc_inm_cd = (TYPEOF(h.cur_loc_inm_cd))'',0,100));
    maxlength_cur_loc_inm_cd := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_loc_inm_cd)));
    avelength_cur_loc_inm_cd := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_loc_inm_cd)),h.cur_loc_inm_cd<>(typeof(h.cur_loc_inm_cd))'');
    populated_cur_loc_inm_pcnt := AVE(GROUP,IF(h.cur_loc_inm = (TYPEOF(h.cur_loc_inm))'',0,100));
    maxlength_cur_loc_inm := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_loc_inm)));
    avelength_cur_loc_inm := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_loc_inm)),h.cur_loc_inm<>(typeof(h.cur_loc_inm))'');
    populated_inm_com_cty_cd_pcnt := AVE(GROUP,IF(h.inm_com_cty_cd = (TYPEOF(h.inm_com_cty_cd))'',0,100));
    maxlength_inm_com_cty_cd := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.inm_com_cty_cd)));
    avelength_inm_com_cty_cd := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.inm_com_cty_cd)),h.inm_com_cty_cd<>(typeof(h.inm_com_cty_cd))'');
    populated_inm_com_cty_pcnt := AVE(GROUP,IF(h.inm_com_cty = (TYPEOF(h.inm_com_cty))'',0,100));
    maxlength_inm_com_cty := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.inm_com_cty)));
    avelength_inm_com_cty := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.inm_com_cty)),h.inm_com_cty<>(typeof(h.inm_com_cty))'');
    populated_cur_sec_class_dt_pcnt := AVE(GROUP,IF(h.cur_sec_class_dt = (TYPEOF(h.cur_sec_class_dt))'',0,100));
    maxlength_cur_sec_class_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_sec_class_dt)));
    avelength_cur_sec_class_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_sec_class_dt)),h.cur_sec_class_dt<>(typeof(h.cur_sec_class_dt))'');
    populated_cur_loc_sec_pcnt := AVE(GROUP,IF(h.cur_loc_sec = (TYPEOF(h.cur_loc_sec))'',0,100));
    maxlength_cur_loc_sec := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_loc_sec)));
    avelength_cur_loc_sec := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cur_loc_sec)),h.cur_loc_sec<>(typeof(h.cur_loc_sec))'');
    populated_gain_time_pcnt := AVE(GROUP,IF(h.gain_time = (TYPEOF(h.gain_time))'',0,100));
    maxlength_gain_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.gain_time)));
    avelength_gain_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.gain_time)),h.gain_time<>(typeof(h.gain_time))'');
    populated_gain_time_eff_dt_pcnt := AVE(GROUP,IF(h.gain_time_eff_dt = (TYPEOF(h.gain_time_eff_dt))'',0,100));
    maxlength_gain_time_eff_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.gain_time_eff_dt)));
    avelength_gain_time_eff_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.gain_time_eff_dt)),h.gain_time_eff_dt<>(typeof(h.gain_time_eff_dt))'');
    populated_latest_adm_dt_pcnt := AVE(GROUP,IF(h.latest_adm_dt = (TYPEOF(h.latest_adm_dt))'',0,100));
    maxlength_latest_adm_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.latest_adm_dt)));
    avelength_latest_adm_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.latest_adm_dt)),h.latest_adm_dt<>(typeof(h.latest_adm_dt))'');
    populated_sch_rel_dt_pcnt := AVE(GROUP,IF(h.sch_rel_dt = (TYPEOF(h.sch_rel_dt))'',0,100));
    maxlength_sch_rel_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sch_rel_dt)));
    avelength_sch_rel_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sch_rel_dt)),h.sch_rel_dt<>(typeof(h.sch_rel_dt))'');
    populated_act_rel_dt_pcnt := AVE(GROUP,IF(h.act_rel_dt = (TYPEOF(h.act_rel_dt))'',0,100));
    maxlength_act_rel_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.act_rel_dt)));
    avelength_act_rel_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.act_rel_dt)),h.act_rel_dt<>(typeof(h.act_rel_dt))'');
    populated_ctl_rel_dt_pcnt := AVE(GROUP,IF(h.ctl_rel_dt = (TYPEOF(h.ctl_rel_dt))'',0,100));
    maxlength_ctl_rel_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ctl_rel_dt)));
    avelength_ctl_rel_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ctl_rel_dt)),h.ctl_rel_dt<>(typeof(h.ctl_rel_dt))'');
    populated_presump_par_rel_dt_pcnt := AVE(GROUP,IF(h.presump_par_rel_dt = (TYPEOF(h.presump_par_rel_dt))'',0,100));
    maxlength_presump_par_rel_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.presump_par_rel_dt)));
    avelength_presump_par_rel_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.presump_par_rel_dt)),h.presump_par_rel_dt<>(typeof(h.presump_par_rel_dt))'');
    populated_mutl_part_pgm_dt_pcnt := AVE(GROUP,IF(h.mutl_part_pgm_dt = (TYPEOF(h.mutl_part_pgm_dt))'',0,100));
    maxlength_mutl_part_pgm_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.mutl_part_pgm_dt)));
    avelength_mutl_part_pgm_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.mutl_part_pgm_dt)),h.mutl_part_pgm_dt<>(typeof(h.mutl_part_pgm_dt))'');
    populated_release_type_pcnt := AVE(GROUP,IF(h.release_type = (TYPEOF(h.release_type))'',0,100));
    maxlength_release_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.release_type)));
    avelength_release_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.release_type)),h.release_type<>(typeof(h.release_type))'');
    populated_office_region_pcnt := AVE(GROUP,IF(h.office_region = (TYPEOF(h.office_region))'',0,100));
    maxlength_office_region := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.office_region)));
    avelength_office_region := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.office_region)),h.office_region<>(typeof(h.office_region))'');
    populated_par_cur_stat_pcnt := AVE(GROUP,IF(h.par_cur_stat = (TYPEOF(h.par_cur_stat))'',0,100));
    maxlength_par_cur_stat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cur_stat)));
    avelength_par_cur_stat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cur_stat)),h.par_cur_stat<>(typeof(h.par_cur_stat))'');
    populated_par_cur_stat_desc_pcnt := AVE(GROUP,IF(h.par_cur_stat_desc = (TYPEOF(h.par_cur_stat_desc))'',0,100));
    maxlength_par_cur_stat_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cur_stat_desc)));
    avelength_par_cur_stat_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cur_stat_desc)),h.par_cur_stat_desc<>(typeof(h.par_cur_stat_desc))'');
    populated_par_status_dt_pcnt := AVE(GROUP,IF(h.par_status_dt = (TYPEOF(h.par_status_dt))'',0,100));
    maxlength_par_status_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_status_dt)));
    avelength_par_status_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_status_dt)),h.par_status_dt<>(typeof(h.par_status_dt))'');
    populated_par_st_dt_pcnt := AVE(GROUP,IF(h.par_st_dt = (TYPEOF(h.par_st_dt))'',0,100));
    maxlength_par_st_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_st_dt)));
    avelength_par_st_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_st_dt)),h.par_st_dt<>(typeof(h.par_st_dt))'');
    populated_par_sch_end_dt_pcnt := AVE(GROUP,IF(h.par_sch_end_dt = (TYPEOF(h.par_sch_end_dt))'',0,100));
    maxlength_par_sch_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_sch_end_dt)));
    avelength_par_sch_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_sch_end_dt)),h.par_sch_end_dt<>(typeof(h.par_sch_end_dt))'');
    populated_par_act_end_dt_pcnt := AVE(GROUP,IF(h.par_act_end_dt = (TYPEOF(h.par_act_end_dt))'',0,100));
    maxlength_par_act_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_act_end_dt)));
    avelength_par_act_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_act_end_dt)),h.par_act_end_dt<>(typeof(h.par_act_end_dt))'');
    populated_par_cty_cd_pcnt := AVE(GROUP,IF(h.par_cty_cd = (TYPEOF(h.par_cty_cd))'',0,100));
    maxlength_par_cty_cd := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cty_cd)));
    avelength_par_cty_cd := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cty_cd)),h.par_cty_cd<>(typeof(h.par_cty_cd))'');
    populated_par_cty_pcnt := AVE(GROUP,IF(h.par_cty = (TYPEOF(h.par_cty))'',0,100));
    maxlength_par_cty := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cty)));
    avelength_par_cty := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.par_cty)),h.par_cty<>(typeof(h.par_cty))'');
    populated_supv_office_pcnt := AVE(GROUP,IF(h.supv_office = (TYPEOF(h.supv_office))'',0,100));
    maxlength_supv_office := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.supv_office)));
    avelength_supv_office := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.supv_office)),h.supv_office<>(typeof(h.supv_office))'');
    populated_supv_officer_pcnt := AVE(GROUP,IF(h.supv_officer = (TYPEOF(h.supv_officer))'',0,100));
    maxlength_supv_officer := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.supv_officer)));
    avelength_supv_officer := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.supv_officer)),h.supv_officer<>(typeof(h.supv_officer))'');
    populated_office_phone_pcnt := AVE(GROUP,IF(h.office_phone = (TYPEOF(h.office_phone))'',0,100));
    maxlength_office_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.office_phone)));
    avelength_office_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.office_phone)),h.office_phone<>(typeof(h.office_phone))'');
    populated_tdcjid_unit_type_pcnt := AVE(GROUP,IF(h.tdcjid_unit_type = (TYPEOF(h.tdcjid_unit_type))'',0,100));
    maxlength_tdcjid_unit_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tdcjid_unit_type)));
    avelength_tdcjid_unit_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tdcjid_unit_type)),h.tdcjid_unit_type<>(typeof(h.tdcjid_unit_type))'');
    populated_tdcjid_unit_assigned_pcnt := AVE(GROUP,IF(h.tdcjid_unit_assigned = (TYPEOF(h.tdcjid_unit_assigned))'',0,100));
    maxlength_tdcjid_unit_assigned := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tdcjid_unit_assigned)));
    avelength_tdcjid_unit_assigned := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tdcjid_unit_assigned)),h.tdcjid_unit_assigned<>(typeof(h.tdcjid_unit_assigned))'');
    populated_tdcjid_admit_date_pcnt := AVE(GROUP,IF(h.tdcjid_admit_date = (TYPEOF(h.tdcjid_admit_date))'',0,100));
    maxlength_tdcjid_admit_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tdcjid_admit_date)));
    avelength_tdcjid_admit_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tdcjid_admit_date)),h.tdcjid_admit_date<>(typeof(h.tdcjid_admit_date))'');
    populated_prison_status_pcnt := AVE(GROUP,IF(h.prison_status = (TYPEOF(h.prison_status))'',0,100));
    maxlength_prison_status := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prison_status)));
    avelength_prison_status := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prison_status)),h.prison_status<>(typeof(h.prison_status))'');
    populated_recv_dept_code_pcnt := AVE(GROUP,IF(h.recv_dept_code = (TYPEOF(h.recv_dept_code))'',0,100));
    maxlength_recv_dept_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recv_dept_code)));
    avelength_recv_dept_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recv_dept_code)),h.recv_dept_code<>(typeof(h.recv_dept_code))'');
    populated_recv_dept_date_pcnt := AVE(GROUP,IF(h.recv_dept_date = (TYPEOF(h.recv_dept_date))'',0,100));
    maxlength_recv_dept_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recv_dept_date)));
    avelength_recv_dept_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recv_dept_date)),h.recv_dept_date<>(typeof(h.recv_dept_date))'');
    populated_parole_active_flag_pcnt := AVE(GROUP,IF(h.parole_active_flag = (TYPEOF(h.parole_active_flag))'',0,100));
    maxlength_parole_active_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parole_active_flag)));
    avelength_parole_active_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parole_active_flag)),h.parole_active_flag<>(typeof(h.parole_active_flag))'');
    populated_casepull_date_pcnt := AVE(GROUP,IF(h.casepull_date = (TYPEOF(h.casepull_date))'',0,100));
    maxlength_casepull_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.casepull_date)));
    avelength_casepull_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.casepull_date)),h.casepull_date<>(typeof(h.casepull_date))'');
    populated_pro_st_dt_pcnt := AVE(GROUP,IF(h.pro_st_dt = (TYPEOF(h.pro_st_dt))'',0,100));
    maxlength_pro_st_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_st_dt)));
    avelength_pro_st_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_st_dt)),h.pro_st_dt<>(typeof(h.pro_st_dt))'');
    populated_pro_end_dt_pcnt := AVE(GROUP,IF(h.pro_end_dt = (TYPEOF(h.pro_end_dt))'',0,100));
    maxlength_pro_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_end_dt)));
    avelength_pro_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_end_dt)),h.pro_end_dt<>(typeof(h.pro_end_dt))'');
    populated_pro_status_pcnt := AVE(GROUP,IF(h.pro_status = (TYPEOF(h.pro_status))'',0,100));
    maxlength_pro_status := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_status)));
    avelength_pro_status := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_status)),h.pro_status<>(typeof(h.pro_status))'');
    populated_conviction_override_date_pcnt := AVE(GROUP,IF(h.conviction_override_date = (TYPEOF(h.conviction_override_date))'',0,100));
    maxlength_conviction_override_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)));
    avelength_conviction_override_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)),h.conviction_override_date<>(typeof(h.conviction_override_date))'');
    populated_conviction_override_date_type_pcnt := AVE(GROUP,IF(h.conviction_override_date_type = (TYPEOF(h.conviction_override_date_type))'',0,100));
    maxlength_conviction_override_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)));
    avelength_conviction_override_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)),h.conviction_override_date_type<>(typeof(h.conviction_override_date_type))'');
    populated_punishment_persistent_id_pcnt := AVE(GROUP,IF(h.punishment_persistent_id = (TYPEOF(h.punishment_persistent_id))'',0,100));
    maxlength_punishment_persistent_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.punishment_persistent_id)));
    avelength_punishment_persistent_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.punishment_persistent_id)),h.punishment_persistent_id<>(typeof(h.punishment_persistent_id))'');
    populated_fcra_date_pcnt := AVE(GROUP,IF(h.fcra_date = (TYPEOF(h.fcra_date))'',0,100));
    maxlength_fcra_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)));
    avelength_fcra_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)),h.fcra_date<>(typeof(h.fcra_date))'');
    populated_fcra_date_type_pcnt := AVE(GROUP,IF(h.fcra_date_type = (TYPEOF(h.fcra_date_type))'',0,100));
    maxlength_fcra_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)));
    avelength_fcra_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)),h.fcra_date_type<>(typeof(h.fcra_date_type))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_offender_key_pcnt *   0.00 / 100 + T.Populated_event_dt_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_offense_key_pcnt *   0.00 / 100 + T.Populated_punishment_type_pcnt *   0.00 / 100 + T.Populated_sent_date_pcnt *   0.00 / 100 + T.Populated_sent_length_pcnt *   0.00 / 100 + T.Populated_sent_length_desc_pcnt *   0.00 / 100 + T.Populated_cur_stat_inm_pcnt *   0.00 / 100 + T.Populated_cur_stat_inm_desc_pcnt *   0.00 / 100 + T.Populated_cur_loc_inm_cd_pcnt *   0.00 / 100 + T.Populated_cur_loc_inm_pcnt *   0.00 / 100 + T.Populated_inm_com_cty_cd_pcnt *   0.00 / 100 + T.Populated_inm_com_cty_pcnt *   0.00 / 100 + T.Populated_cur_sec_class_dt_pcnt *   0.00 / 100 + T.Populated_cur_loc_sec_pcnt *   0.00 / 100 + T.Populated_gain_time_pcnt *   0.00 / 100 + T.Populated_gain_time_eff_dt_pcnt *   0.00 / 100 + T.Populated_latest_adm_dt_pcnt *   0.00 / 100 + T.Populated_sch_rel_dt_pcnt *   0.00 / 100 + T.Populated_act_rel_dt_pcnt *   0.00 / 100 + T.Populated_ctl_rel_dt_pcnt *   0.00 / 100 + T.Populated_presump_par_rel_dt_pcnt *   0.00 / 100 + T.Populated_mutl_part_pgm_dt_pcnt *   0.00 / 100 + T.Populated_release_type_pcnt *   0.00 / 100 + T.Populated_office_region_pcnt *   0.00 / 100 + T.Populated_par_cur_stat_pcnt *   0.00 / 100 + T.Populated_par_cur_stat_desc_pcnt *   0.00 / 100 + T.Populated_par_status_dt_pcnt *   0.00 / 100 + T.Populated_par_st_dt_pcnt *   0.00 / 100 + T.Populated_par_sch_end_dt_pcnt *   0.00 / 100 + T.Populated_par_act_end_dt_pcnt *   0.00 / 100 + T.Populated_par_cty_cd_pcnt *   0.00 / 100 + T.Populated_par_cty_pcnt *   0.00 / 100 + T.Populated_supv_office_pcnt *   0.00 / 100 + T.Populated_supv_officer_pcnt *   0.00 / 100 + T.Populated_office_phone_pcnt *   0.00 / 100 + T.Populated_tdcjid_unit_type_pcnt *   0.00 / 100 + T.Populated_tdcjid_unit_assigned_pcnt *   0.00 / 100 + T.Populated_tdcjid_admit_date_pcnt *   0.00 / 100 + T.Populated_prison_status_pcnt *   0.00 / 100 + T.Populated_recv_dept_code_pcnt *   0.00 / 100 + T.Populated_recv_dept_date_pcnt *   0.00 / 100 + T.Populated_parole_active_flag_pcnt *   0.00 / 100 + T.Populated_casepull_date_pcnt *   0.00 / 100 + T.Populated_pro_st_dt_pcnt *   0.00 / 100 + T.Populated_pro_end_dt_pcnt *   0.00 / 100 + T.Populated_pro_status_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_type_pcnt *   0.00 / 100 + T.Populated_punishment_persistent_id_pcnt *   0.00 / 100 + T.Populated_fcra_date_pcnt *   0.00 / 100 + T.Populated_fcra_date_type_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_offender_key_pcnt*ri.Populated_offender_key_pcnt *   0.00 / 10000 + le.Populated_event_dt_pcnt*ri.Populated_event_dt_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_offense_key_pcnt*ri.Populated_offense_key_pcnt *   0.00 / 10000 + le.Populated_punishment_type_pcnt*ri.Populated_punishment_type_pcnt *   0.00 / 10000 + le.Populated_sent_date_pcnt*ri.Populated_sent_date_pcnt *   0.00 / 10000 + le.Populated_sent_length_pcnt*ri.Populated_sent_length_pcnt *   0.00 / 10000 + le.Populated_sent_length_desc_pcnt*ri.Populated_sent_length_desc_pcnt *   0.00 / 10000 + le.Populated_cur_stat_inm_pcnt*ri.Populated_cur_stat_inm_pcnt *   0.00 / 10000 + le.Populated_cur_stat_inm_desc_pcnt*ri.Populated_cur_stat_inm_desc_pcnt *   0.00 / 10000 + le.Populated_cur_loc_inm_cd_pcnt*ri.Populated_cur_loc_inm_cd_pcnt *   0.00 / 10000 + le.Populated_cur_loc_inm_pcnt*ri.Populated_cur_loc_inm_pcnt *   0.00 / 10000 + le.Populated_inm_com_cty_cd_pcnt*ri.Populated_inm_com_cty_cd_pcnt *   0.00 / 10000 + le.Populated_inm_com_cty_pcnt*ri.Populated_inm_com_cty_pcnt *   0.00 / 10000 + le.Populated_cur_sec_class_dt_pcnt*ri.Populated_cur_sec_class_dt_pcnt *   0.00 / 10000 + le.Populated_cur_loc_sec_pcnt*ri.Populated_cur_loc_sec_pcnt *   0.00 / 10000 + le.Populated_gain_time_pcnt*ri.Populated_gain_time_pcnt *   0.00 / 10000 + le.Populated_gain_time_eff_dt_pcnt*ri.Populated_gain_time_eff_dt_pcnt *   0.00 / 10000 + le.Populated_latest_adm_dt_pcnt*ri.Populated_latest_adm_dt_pcnt *   0.00 / 10000 + le.Populated_sch_rel_dt_pcnt*ri.Populated_sch_rel_dt_pcnt *   0.00 / 10000 + le.Populated_act_rel_dt_pcnt*ri.Populated_act_rel_dt_pcnt *   0.00 / 10000 + le.Populated_ctl_rel_dt_pcnt*ri.Populated_ctl_rel_dt_pcnt *   0.00 / 10000 + le.Populated_presump_par_rel_dt_pcnt*ri.Populated_presump_par_rel_dt_pcnt *   0.00 / 10000 + le.Populated_mutl_part_pgm_dt_pcnt*ri.Populated_mutl_part_pgm_dt_pcnt *   0.00 / 10000 + le.Populated_release_type_pcnt*ri.Populated_release_type_pcnt *   0.00 / 10000 + le.Populated_office_region_pcnt*ri.Populated_office_region_pcnt *   0.00 / 10000 + le.Populated_par_cur_stat_pcnt*ri.Populated_par_cur_stat_pcnt *   0.00 / 10000 + le.Populated_par_cur_stat_desc_pcnt*ri.Populated_par_cur_stat_desc_pcnt *   0.00 / 10000 + le.Populated_par_status_dt_pcnt*ri.Populated_par_status_dt_pcnt *   0.00 / 10000 + le.Populated_par_st_dt_pcnt*ri.Populated_par_st_dt_pcnt *   0.00 / 10000 + le.Populated_par_sch_end_dt_pcnt*ri.Populated_par_sch_end_dt_pcnt *   0.00 / 10000 + le.Populated_par_act_end_dt_pcnt*ri.Populated_par_act_end_dt_pcnt *   0.00 / 10000 + le.Populated_par_cty_cd_pcnt*ri.Populated_par_cty_cd_pcnt *   0.00 / 10000 + le.Populated_par_cty_pcnt*ri.Populated_par_cty_pcnt *   0.00 / 10000 + le.Populated_supv_office_pcnt*ri.Populated_supv_office_pcnt *   0.00 / 10000 + le.Populated_supv_officer_pcnt*ri.Populated_supv_officer_pcnt *   0.00 / 10000 + le.Populated_office_phone_pcnt*ri.Populated_office_phone_pcnt *   0.00 / 10000 + le.Populated_tdcjid_unit_type_pcnt*ri.Populated_tdcjid_unit_type_pcnt *   0.00 / 10000 + le.Populated_tdcjid_unit_assigned_pcnt*ri.Populated_tdcjid_unit_assigned_pcnt *   0.00 / 10000 + le.Populated_tdcjid_admit_date_pcnt*ri.Populated_tdcjid_admit_date_pcnt *   0.00 / 10000 + le.Populated_prison_status_pcnt*ri.Populated_prison_status_pcnt *   0.00 / 10000 + le.Populated_recv_dept_code_pcnt*ri.Populated_recv_dept_code_pcnt *   0.00 / 10000 + le.Populated_recv_dept_date_pcnt*ri.Populated_recv_dept_date_pcnt *   0.00 / 10000 + le.Populated_parole_active_flag_pcnt*ri.Populated_parole_active_flag_pcnt *   0.00 / 10000 + le.Populated_casepull_date_pcnt*ri.Populated_casepull_date_pcnt *   0.00 / 10000 + le.Populated_pro_st_dt_pcnt*ri.Populated_pro_st_dt_pcnt *   0.00 / 10000 + le.Populated_pro_end_dt_pcnt*ri.Populated_pro_end_dt_pcnt *   0.00 / 10000 + le.Populated_pro_status_pcnt*ri.Populated_pro_status_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_pcnt*ri.Populated_conviction_override_date_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_type_pcnt*ri.Populated_conviction_override_date_type_pcnt *   0.00 / 10000 + le.Populated_punishment_persistent_id_pcnt*ri.Populated_punishment_persistent_id_pcnt *   0.00 / 10000 + le.Populated_fcra_date_pcnt*ri.Populated_fcra_date_pcnt *   0.00 / 10000 + le.Populated_fcra_date_type_pcnt*ri.Populated_fcra_date_type_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','offender_key','event_dt','vendor','source_file','record_type','orig_state','offense_key','punishment_type','sent_date','sent_length','sent_length_desc','cur_stat_inm','cur_stat_inm_desc','cur_loc_inm_cd','cur_loc_inm','inm_com_cty_cd','inm_com_cty','cur_sec_class_dt','cur_loc_sec','gain_time','gain_time_eff_dt','latest_adm_dt','sch_rel_dt','act_rel_dt','ctl_rel_dt','presump_par_rel_dt','mutl_part_pgm_dt','release_type','office_region','par_cur_stat','par_cur_stat_desc','par_status_dt','par_st_dt','par_sch_end_dt','par_act_end_dt','par_cty_cd','par_cty','supv_office','supv_officer','office_phone','tdcjid_unit_type','tdcjid_unit_assigned','tdcjid_admit_date','prison_status','recv_dept_code','recv_dept_date','parole_active_flag','casepull_date','pro_st_dt','pro_end_dt','pro_status','conviction_override_date','conviction_override_date_type','punishment_persistent_id','fcra_date','fcra_date_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_offender_key_pcnt,le.populated_event_dt_pcnt,le.populated_vendor_pcnt,le.populated_source_file_pcnt,le.populated_record_type_pcnt,le.populated_orig_state_pcnt,le.populated_offense_key_pcnt,le.populated_punishment_type_pcnt,le.populated_sent_date_pcnt,le.populated_sent_length_pcnt,le.populated_sent_length_desc_pcnt,le.populated_cur_stat_inm_pcnt,le.populated_cur_stat_inm_desc_pcnt,le.populated_cur_loc_inm_cd_pcnt,le.populated_cur_loc_inm_pcnt,le.populated_inm_com_cty_cd_pcnt,le.populated_inm_com_cty_pcnt,le.populated_cur_sec_class_dt_pcnt,le.populated_cur_loc_sec_pcnt,le.populated_gain_time_pcnt,le.populated_gain_time_eff_dt_pcnt,le.populated_latest_adm_dt_pcnt,le.populated_sch_rel_dt_pcnt,le.populated_act_rel_dt_pcnt,le.populated_ctl_rel_dt_pcnt,le.populated_presump_par_rel_dt_pcnt,le.populated_mutl_part_pgm_dt_pcnt,le.populated_release_type_pcnt,le.populated_office_region_pcnt,le.populated_par_cur_stat_pcnt,le.populated_par_cur_stat_desc_pcnt,le.populated_par_status_dt_pcnt,le.populated_par_st_dt_pcnt,le.populated_par_sch_end_dt_pcnt,le.populated_par_act_end_dt_pcnt,le.populated_par_cty_cd_pcnt,le.populated_par_cty_pcnt,le.populated_supv_office_pcnt,le.populated_supv_officer_pcnt,le.populated_office_phone_pcnt,le.populated_tdcjid_unit_type_pcnt,le.populated_tdcjid_unit_assigned_pcnt,le.populated_tdcjid_admit_date_pcnt,le.populated_prison_status_pcnt,le.populated_recv_dept_code_pcnt,le.populated_recv_dept_date_pcnt,le.populated_parole_active_flag_pcnt,le.populated_casepull_date_pcnt,le.populated_pro_st_dt_pcnt,le.populated_pro_end_dt_pcnt,le.populated_pro_status_pcnt,le.populated_conviction_override_date_pcnt,le.populated_conviction_override_date_type_pcnt,le.populated_punishment_persistent_id_pcnt,le.populated_fcra_date_pcnt,le.populated_fcra_date_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_offender_key,le.maxlength_event_dt,le.maxlength_vendor,le.maxlength_source_file,le.maxlength_record_type,le.maxlength_orig_state,le.maxlength_offense_key,le.maxlength_punishment_type,le.maxlength_sent_date,le.maxlength_sent_length,le.maxlength_sent_length_desc,le.maxlength_cur_stat_inm,le.maxlength_cur_stat_inm_desc,le.maxlength_cur_loc_inm_cd,le.maxlength_cur_loc_inm,le.maxlength_inm_com_cty_cd,le.maxlength_inm_com_cty,le.maxlength_cur_sec_class_dt,le.maxlength_cur_loc_sec,le.maxlength_gain_time,le.maxlength_gain_time_eff_dt,le.maxlength_latest_adm_dt,le.maxlength_sch_rel_dt,le.maxlength_act_rel_dt,le.maxlength_ctl_rel_dt,le.maxlength_presump_par_rel_dt,le.maxlength_mutl_part_pgm_dt,le.maxlength_release_type,le.maxlength_office_region,le.maxlength_par_cur_stat,le.maxlength_par_cur_stat_desc,le.maxlength_par_status_dt,le.maxlength_par_st_dt,le.maxlength_par_sch_end_dt,le.maxlength_par_act_end_dt,le.maxlength_par_cty_cd,le.maxlength_par_cty,le.maxlength_supv_office,le.maxlength_supv_officer,le.maxlength_office_phone,le.maxlength_tdcjid_unit_type,le.maxlength_tdcjid_unit_assigned,le.maxlength_tdcjid_admit_date,le.maxlength_prison_status,le.maxlength_recv_dept_code,le.maxlength_recv_dept_date,le.maxlength_parole_active_flag,le.maxlength_casepull_date,le.maxlength_pro_st_dt,le.maxlength_pro_end_dt,le.maxlength_pro_status,le.maxlength_conviction_override_date,le.maxlength_conviction_override_date_type,le.maxlength_punishment_persistent_id,le.maxlength_fcra_date,le.maxlength_fcra_date_type);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_offender_key,le.avelength_event_dt,le.avelength_vendor,le.avelength_source_file,le.avelength_record_type,le.avelength_orig_state,le.avelength_offense_key,le.avelength_punishment_type,le.avelength_sent_date,le.avelength_sent_length,le.avelength_sent_length_desc,le.avelength_cur_stat_inm,le.avelength_cur_stat_inm_desc,le.avelength_cur_loc_inm_cd,le.avelength_cur_loc_inm,le.avelength_inm_com_cty_cd,le.avelength_inm_com_cty,le.avelength_cur_sec_class_dt,le.avelength_cur_loc_sec,le.avelength_gain_time,le.avelength_gain_time_eff_dt,le.avelength_latest_adm_dt,le.avelength_sch_rel_dt,le.avelength_act_rel_dt,le.avelength_ctl_rel_dt,le.avelength_presump_par_rel_dt,le.avelength_mutl_part_pgm_dt,le.avelength_release_type,le.avelength_office_region,le.avelength_par_cur_stat,le.avelength_par_cur_stat_desc,le.avelength_par_status_dt,le.avelength_par_st_dt,le.avelength_par_sch_end_dt,le.avelength_par_act_end_dt,le.avelength_par_cty_cd,le.avelength_par_cty,le.avelength_supv_office,le.avelength_supv_officer,le.avelength_office_phone,le.avelength_tdcjid_unit_type,le.avelength_tdcjid_unit_assigned,le.avelength_tdcjid_admit_date,le.avelength_prison_status,le.avelength_recv_dept_code,le.avelength_recv_dept_date,le.avelength_parole_active_flag,le.avelength_casepull_date,le.avelength_pro_st_dt,le.avelength_pro_end_dt,le.avelength_pro_status,le.avelength_conviction_override_date,le.avelength_conviction_override_date_type,le.avelength_punishment_persistent_id,le.avelength_fcra_date,le.avelength_fcra_date_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 57, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.offender_key),TRIM((SALT33.StrType)le.event_dt),TRIM((SALT33.StrType)le.vendor),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.offense_key),TRIM((SALT33.StrType)le.punishment_type),TRIM((SALT33.StrType)le.sent_date),TRIM((SALT33.StrType)le.sent_length),TRIM((SALT33.StrType)le.sent_length_desc),TRIM((SALT33.StrType)le.cur_stat_inm),TRIM((SALT33.StrType)le.cur_stat_inm_desc),TRIM((SALT33.StrType)le.cur_loc_inm_cd),TRIM((SALT33.StrType)le.cur_loc_inm),TRIM((SALT33.StrType)le.inm_com_cty_cd),TRIM((SALT33.StrType)le.inm_com_cty),TRIM((SALT33.StrType)le.cur_sec_class_dt),TRIM((SALT33.StrType)le.cur_loc_sec),TRIM((SALT33.StrType)le.gain_time),TRIM((SALT33.StrType)le.gain_time_eff_dt),TRIM((SALT33.StrType)le.latest_adm_dt),TRIM((SALT33.StrType)le.sch_rel_dt),TRIM((SALT33.StrType)le.act_rel_dt),TRIM((SALT33.StrType)le.ctl_rel_dt),TRIM((SALT33.StrType)le.presump_par_rel_dt),TRIM((SALT33.StrType)le.mutl_part_pgm_dt),TRIM((SALT33.StrType)le.release_type),TRIM((SALT33.StrType)le.office_region),TRIM((SALT33.StrType)le.par_cur_stat),TRIM((SALT33.StrType)le.par_cur_stat_desc),TRIM((SALT33.StrType)le.par_status_dt),TRIM((SALT33.StrType)le.par_st_dt),TRIM((SALT33.StrType)le.par_sch_end_dt),TRIM((SALT33.StrType)le.par_act_end_dt),TRIM((SALT33.StrType)le.par_cty_cd),TRIM((SALT33.StrType)le.par_cty),TRIM((SALT33.StrType)le.supv_office),TRIM((SALT33.StrType)le.supv_officer),TRIM((SALT33.StrType)le.office_phone),TRIM((SALT33.StrType)le.tdcjid_unit_type),TRIM((SALT33.StrType)le.tdcjid_unit_assigned),TRIM((SALT33.StrType)le.tdcjid_admit_date),TRIM((SALT33.StrType)le.prison_status),TRIM((SALT33.StrType)le.recv_dept_code),TRIM((SALT33.StrType)le.recv_dept_date),TRIM((SALT33.StrType)le.parole_active_flag),TRIM((SALT33.StrType)le.casepull_date),TRIM((SALT33.StrType)le.pro_st_dt),TRIM((SALT33.StrType)le.pro_end_dt),TRIM((SALT33.StrType)le.pro_status),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),IF (le.punishment_persistent_id <> 0,TRIM((SALT33.StrType)le.punishment_persistent_id), ''),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,57,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 57);
  SELF.FldNo2 := 1 + (C % 57);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.offender_key),TRIM((SALT33.StrType)le.event_dt),TRIM((SALT33.StrType)le.vendor),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.offense_key),TRIM((SALT33.StrType)le.punishment_type),TRIM((SALT33.StrType)le.sent_date),TRIM((SALT33.StrType)le.sent_length),TRIM((SALT33.StrType)le.sent_length_desc),TRIM((SALT33.StrType)le.cur_stat_inm),TRIM((SALT33.StrType)le.cur_stat_inm_desc),TRIM((SALT33.StrType)le.cur_loc_inm_cd),TRIM((SALT33.StrType)le.cur_loc_inm),TRIM((SALT33.StrType)le.inm_com_cty_cd),TRIM((SALT33.StrType)le.inm_com_cty),TRIM((SALT33.StrType)le.cur_sec_class_dt),TRIM((SALT33.StrType)le.cur_loc_sec),TRIM((SALT33.StrType)le.gain_time),TRIM((SALT33.StrType)le.gain_time_eff_dt),TRIM((SALT33.StrType)le.latest_adm_dt),TRIM((SALT33.StrType)le.sch_rel_dt),TRIM((SALT33.StrType)le.act_rel_dt),TRIM((SALT33.StrType)le.ctl_rel_dt),TRIM((SALT33.StrType)le.presump_par_rel_dt),TRIM((SALT33.StrType)le.mutl_part_pgm_dt),TRIM((SALT33.StrType)le.release_type),TRIM((SALT33.StrType)le.office_region),TRIM((SALT33.StrType)le.par_cur_stat),TRIM((SALT33.StrType)le.par_cur_stat_desc),TRIM((SALT33.StrType)le.par_status_dt),TRIM((SALT33.StrType)le.par_st_dt),TRIM((SALT33.StrType)le.par_sch_end_dt),TRIM((SALT33.StrType)le.par_act_end_dt),TRIM((SALT33.StrType)le.par_cty_cd),TRIM((SALT33.StrType)le.par_cty),TRIM((SALT33.StrType)le.supv_office),TRIM((SALT33.StrType)le.supv_officer),TRIM((SALT33.StrType)le.office_phone),TRIM((SALT33.StrType)le.tdcjid_unit_type),TRIM((SALT33.StrType)le.tdcjid_unit_assigned),TRIM((SALT33.StrType)le.tdcjid_admit_date),TRIM((SALT33.StrType)le.prison_status),TRIM((SALT33.StrType)le.recv_dept_code),TRIM((SALT33.StrType)le.recv_dept_date),TRIM((SALT33.StrType)le.parole_active_flag),TRIM((SALT33.StrType)le.casepull_date),TRIM((SALT33.StrType)le.pro_st_dt),TRIM((SALT33.StrType)le.pro_end_dt),TRIM((SALT33.StrType)le.pro_status),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),IF (le.punishment_persistent_id <> 0,TRIM((SALT33.StrType)le.punishment_persistent_id), ''),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.offender_key),TRIM((SALT33.StrType)le.event_dt),TRIM((SALT33.StrType)le.vendor),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.offense_key),TRIM((SALT33.StrType)le.punishment_type),TRIM((SALT33.StrType)le.sent_date),TRIM((SALT33.StrType)le.sent_length),TRIM((SALT33.StrType)le.sent_length_desc),TRIM((SALT33.StrType)le.cur_stat_inm),TRIM((SALT33.StrType)le.cur_stat_inm_desc),TRIM((SALT33.StrType)le.cur_loc_inm_cd),TRIM((SALT33.StrType)le.cur_loc_inm),TRIM((SALT33.StrType)le.inm_com_cty_cd),TRIM((SALT33.StrType)le.inm_com_cty),TRIM((SALT33.StrType)le.cur_sec_class_dt),TRIM((SALT33.StrType)le.cur_loc_sec),TRIM((SALT33.StrType)le.gain_time),TRIM((SALT33.StrType)le.gain_time_eff_dt),TRIM((SALT33.StrType)le.latest_adm_dt),TRIM((SALT33.StrType)le.sch_rel_dt),TRIM((SALT33.StrType)le.act_rel_dt),TRIM((SALT33.StrType)le.ctl_rel_dt),TRIM((SALT33.StrType)le.presump_par_rel_dt),TRIM((SALT33.StrType)le.mutl_part_pgm_dt),TRIM((SALT33.StrType)le.release_type),TRIM((SALT33.StrType)le.office_region),TRIM((SALT33.StrType)le.par_cur_stat),TRIM((SALT33.StrType)le.par_cur_stat_desc),TRIM((SALT33.StrType)le.par_status_dt),TRIM((SALT33.StrType)le.par_st_dt),TRIM((SALT33.StrType)le.par_sch_end_dt),TRIM((SALT33.StrType)le.par_act_end_dt),TRIM((SALT33.StrType)le.par_cty_cd),TRIM((SALT33.StrType)le.par_cty),TRIM((SALT33.StrType)le.supv_office),TRIM((SALT33.StrType)le.supv_officer),TRIM((SALT33.StrType)le.office_phone),TRIM((SALT33.StrType)le.tdcjid_unit_type),TRIM((SALT33.StrType)le.tdcjid_unit_assigned),TRIM((SALT33.StrType)le.tdcjid_admit_date),TRIM((SALT33.StrType)le.prison_status),TRIM((SALT33.StrType)le.recv_dept_code),TRIM((SALT33.StrType)le.recv_dept_date),TRIM((SALT33.StrType)le.parole_active_flag),TRIM((SALT33.StrType)le.casepull_date),TRIM((SALT33.StrType)le.pro_st_dt),TRIM((SALT33.StrType)le.pro_end_dt),TRIM((SALT33.StrType)le.pro_status),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),IF (le.punishment_persistent_id <> 0,TRIM((SALT33.StrType)le.punishment_persistent_id), ''),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),57*57,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'offender_key'}
      ,{3,'event_dt'}
      ,{4,'vendor'}
      ,{5,'source_file'}
      ,{6,'record_type'}
      ,{7,'orig_state'}
      ,{8,'offense_key'}
      ,{9,'punishment_type'}
      ,{10,'sent_date'}
      ,{11,'sent_length'}
      ,{12,'sent_length_desc'}
      ,{13,'cur_stat_inm'}
      ,{14,'cur_stat_inm_desc'}
      ,{15,'cur_loc_inm_cd'}
      ,{16,'cur_loc_inm'}
      ,{17,'inm_com_cty_cd'}
      ,{18,'inm_com_cty'}
      ,{19,'cur_sec_class_dt'}
      ,{20,'cur_loc_sec'}
      ,{21,'gain_time'}
      ,{22,'gain_time_eff_dt'}
      ,{23,'latest_adm_dt'}
      ,{24,'sch_rel_dt'}
      ,{25,'act_rel_dt'}
      ,{26,'ctl_rel_dt'}
      ,{27,'presump_par_rel_dt'}
      ,{28,'mutl_part_pgm_dt'}
      ,{29,'release_type'}
      ,{30,'office_region'}
      ,{31,'par_cur_stat'}
      ,{32,'par_cur_stat_desc'}
      ,{33,'par_status_dt'}
      ,{34,'par_st_dt'}
      ,{35,'par_sch_end_dt'}
      ,{36,'par_act_end_dt'}
      ,{37,'par_cty_cd'}
      ,{38,'par_cty'}
      ,{39,'supv_office'}
      ,{40,'supv_officer'}
      ,{41,'office_phone'}
      ,{42,'tdcjid_unit_type'}
      ,{43,'tdcjid_unit_assigned'}
      ,{44,'tdcjid_admit_date'}
      ,{45,'prison_status'}
      ,{46,'recv_dept_code'}
      ,{47,'recv_dept_date'}
      ,{48,'parole_active_flag'}
      ,{49,'casepull_date'}
      ,{50,'pro_st_dt'}
      ,{51,'pro_end_dt'}
      ,{52,'pro_status'}
      ,{53,'conviction_override_date'}
      ,{54,'conviction_override_date_type'}
      ,{55,'punishment_persistent_id'}
      ,{56,'fcra_date'}
      ,{57,'fcra_date_type'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Moxie_DOC_Punishment_Dev_Fields.InValid_process_date((SALT33.StrType)le.process_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_offender_key((SALT33.StrType)le.offender_key),
    Moxie_DOC_Punishment_Dev_Fields.InValid_event_dt((SALT33.StrType)le.event_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_vendor((SALT33.StrType)le.vendor),
    Moxie_DOC_Punishment_Dev_Fields.InValid_source_file((SALT33.StrType)le.source_file),
    Moxie_DOC_Punishment_Dev_Fields.InValid_record_type((SALT33.StrType)le.record_type),
    Moxie_DOC_Punishment_Dev_Fields.InValid_orig_state((SALT33.StrType)le.orig_state),
    Moxie_DOC_Punishment_Dev_Fields.InValid_offense_key((SALT33.StrType)le.offense_key),
    Moxie_DOC_Punishment_Dev_Fields.InValid_punishment_type((SALT33.StrType)le.punishment_type),
    Moxie_DOC_Punishment_Dev_Fields.InValid_sent_date((SALT33.StrType)le.sent_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_sent_length((SALT33.StrType)le.sent_length),
    Moxie_DOC_Punishment_Dev_Fields.InValid_sent_length_desc((SALT33.StrType)le.sent_length_desc),
    Moxie_DOC_Punishment_Dev_Fields.InValid_cur_stat_inm((SALT33.StrType)le.cur_stat_inm),
    Moxie_DOC_Punishment_Dev_Fields.InValid_cur_stat_inm_desc((SALT33.StrType)le.cur_stat_inm_desc),
    Moxie_DOC_Punishment_Dev_Fields.InValid_cur_loc_inm_cd((SALT33.StrType)le.cur_loc_inm_cd),
    Moxie_DOC_Punishment_Dev_Fields.InValid_cur_loc_inm((SALT33.StrType)le.cur_loc_inm),
    Moxie_DOC_Punishment_Dev_Fields.InValid_inm_com_cty_cd((SALT33.StrType)le.inm_com_cty_cd),
    Moxie_DOC_Punishment_Dev_Fields.InValid_inm_com_cty((SALT33.StrType)le.inm_com_cty),
    Moxie_DOC_Punishment_Dev_Fields.InValid_cur_sec_class_dt((SALT33.StrType)le.cur_sec_class_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_cur_loc_sec((SALT33.StrType)le.cur_loc_sec),
    Moxie_DOC_Punishment_Dev_Fields.InValid_gain_time((SALT33.StrType)le.gain_time),
    Moxie_DOC_Punishment_Dev_Fields.InValid_gain_time_eff_dt((SALT33.StrType)le.gain_time_eff_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_latest_adm_dt((SALT33.StrType)le.latest_adm_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_sch_rel_dt((SALT33.StrType)le.sch_rel_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_act_rel_dt((SALT33.StrType)le.act_rel_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_ctl_rel_dt((SALT33.StrType)le.ctl_rel_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_presump_par_rel_dt((SALT33.StrType)le.presump_par_rel_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_mutl_part_pgm_dt((SALT33.StrType)le.mutl_part_pgm_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_release_type((SALT33.StrType)le.release_type),
    Moxie_DOC_Punishment_Dev_Fields.InValid_office_region((SALT33.StrType)le.office_region),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_cur_stat((SALT33.StrType)le.par_cur_stat),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_cur_stat_desc((SALT33.StrType)le.par_cur_stat_desc),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_status_dt((SALT33.StrType)le.par_status_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_st_dt((SALT33.StrType)le.par_st_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_sch_end_dt((SALT33.StrType)le.par_sch_end_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_act_end_dt((SALT33.StrType)le.par_act_end_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_cty_cd((SALT33.StrType)le.par_cty_cd),
    Moxie_DOC_Punishment_Dev_Fields.InValid_par_cty((SALT33.StrType)le.par_cty),
    Moxie_DOC_Punishment_Dev_Fields.InValid_supv_office((SALT33.StrType)le.supv_office),
    Moxie_DOC_Punishment_Dev_Fields.InValid_supv_officer((SALT33.StrType)le.supv_officer),
    Moxie_DOC_Punishment_Dev_Fields.InValid_office_phone((SALT33.StrType)le.office_phone),
    Moxie_DOC_Punishment_Dev_Fields.InValid_tdcjid_unit_type((SALT33.StrType)le.tdcjid_unit_type),
    Moxie_DOC_Punishment_Dev_Fields.InValid_tdcjid_unit_assigned((SALT33.StrType)le.tdcjid_unit_assigned),
    Moxie_DOC_Punishment_Dev_Fields.InValid_tdcjid_admit_date((SALT33.StrType)le.tdcjid_admit_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_prison_status((SALT33.StrType)le.prison_status),
    Moxie_DOC_Punishment_Dev_Fields.InValid_recv_dept_code((SALT33.StrType)le.recv_dept_code),
    Moxie_DOC_Punishment_Dev_Fields.InValid_recv_dept_date((SALT33.StrType)le.recv_dept_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_parole_active_flag((SALT33.StrType)le.parole_active_flag),
    Moxie_DOC_Punishment_Dev_Fields.InValid_casepull_date((SALT33.StrType)le.casepull_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_pro_st_dt((SALT33.StrType)le.pro_st_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_pro_end_dt((SALT33.StrType)le.pro_end_dt),
    Moxie_DOC_Punishment_Dev_Fields.InValid_pro_status((SALT33.StrType)le.pro_status),
    Moxie_DOC_Punishment_Dev_Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type),
    Moxie_DOC_Punishment_Dev_Fields.InValid_punishment_persistent_id((SALT33.StrType)le.punishment_persistent_id),
    Moxie_DOC_Punishment_Dev_Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date),
    Moxie_DOC_Punishment_Dev_Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,57,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := Moxie_DOC_Punishment_Dev_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Current_Date','Non_Blank','Invalid_Future_Date','Non_Blank','Unknown','Unknown','Invalid_Char','Unknown','Invalid_Punishment_Type','Invalid_Current_Date','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Future_Date','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Invalid_Current_Date','Unknown','Invalid_Current_Date','Invalid_Future_Date','Invalid_Future_Date','Unknown','Invalid_Future_Date','Invalid_ConOverDateFlag','Invalid_Num','Invalid_Current_Date','Invalid_FCRADateFlag');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Moxie_DOC_Punishment_Dev_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_offender_key(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_event_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_offense_key(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_punishment_type(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_sent_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_sent_length(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_sent_length_desc(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_cur_stat_inm(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_cur_stat_inm_desc(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_cur_loc_inm_cd(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_cur_loc_inm(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_inm_com_cty_cd(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_inm_com_cty(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_cur_sec_class_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_cur_loc_sec(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_gain_time(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_gain_time_eff_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_latest_adm_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_sch_rel_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_act_rel_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_ctl_rel_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_presump_par_rel_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_mutl_part_pgm_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_release_type(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_office_region(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_cur_stat(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_cur_stat_desc(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_status_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_st_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_sch_end_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_act_end_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_cty_cd(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_par_cty(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_supv_office(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_supv_officer(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_office_phone(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_tdcjid_unit_type(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_tdcjid_unit_assigned(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_tdcjid_admit_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_prison_status(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_recv_dept_code(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_recv_dept_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_parole_active_flag(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_casepull_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_pro_st_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_pro_end_dt(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_pro_status(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_conviction_override_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_conviction_override_date_type(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_punishment_persistent_id(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_fcra_date(TotalErrors.ErrorNum),Moxie_DOC_Punishment_Dev_Fields.InValidMessage_fcra_date_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
