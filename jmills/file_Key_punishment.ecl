import doxie_files;

layout_key_out := RECORD
  string60 ok;
  string1 pt;
  string8 process_date;
  string60 offender_key;
  string8 event_dt;
  string2 vendor;
  string20 source_file;
  string2 record_type;
  string2 orig_state;
  string50 offense_key;
  string1 punishment_type;
  string8 sent_date;
  string15 sent_length;
  string60 sent_length_desc;
  string8 cur_stat_inm;
  string50 cur_stat_inm_desc;
  string8 cur_loc_inm_cd;
  string60 cur_loc_inm;
  string8 inm_com_cty_cd;
  string25 inm_com_cty;
  string8 cur_sec_class_dt;
  string25 cur_loc_sec;
  string3 gain_time;
  string8 gain_time_eff_dt;
  string8 latest_adm_dt;
  string8 sch_rel_dt;
  string8 act_rel_dt;
  string8 ctl_rel_dt;
  string8 presump_par_rel_dt;
  string8 mutl_part_pgm_dt;
  string4 release_type;
  string2 office_region;
  string8 par_cur_stat;
  string50 par_cur_stat_desc;
  string8 par_status_dt;
  string8 par_st_dt;
  string8 par_sch_end_dt;
  string8 par_act_end_dt;
  string8 par_cty_cd;
  string50 par_cty;
  string30 supv_office;
  string30 supv_officer;
  string14 office_phone;
  string2 tdcjid_unit_type;
  string15 tdcjid_unit_assigned;
  string1 tdcjid_admit_date;
  string1 prison_status;
  string2 recv_dept_code;
  string10 recv_dept_date;
  string1 parole_active_flag;
  string10 casepull_date;
  string8 conviction_override_date;
  string1 conviction_override_date_type;
  unsigned8 punishment_persistent_id;
  END;

 key_in := doxie_files.key_punishment (true);

 //transform statement
layout_key_out makerecord (key_in L) := transform
self.ok := L.ok;
self.pt := L.pt;
self.process_date := L.process_date;
self.offender_key := L.offender_key;
self.event_dt := L.event_dt;
self.vendor := L.vendor;
self.source_file := L.source_file;
self.record_type := L.record_type;
self.orig_state := L.orig_state;
self.offense_key := L.offense_key;
self.punishment_type := L.punishment_type;
self.sent_date := L.sent_date;
self.sent_length := L.sent_length;
self.sent_length_desc := L.sent_length_desc;
self.cur_stat_inm := L.cur_stat_inm;
self.cur_stat_inm_desc := L.cur_stat_inm_desc;
self.cur_loc_inm_cd := L.cur_loc_inm_cd;
self.cur_loc_inm := L.cur_loc_inm;
self.inm_com_cty_cd := L.inm_com_cty_cd;
self.inm_com_cty := L.inm_com_cty;
self.cur_sec_class_dt := L.cur_sec_class_dt;
self.cur_loc_sec := L.cur_loc_sec;
self.gain_time := L.gain_time;
self.gain_time_eff_dt := L.gain_time_eff_dt;
self.latest_adm_dt := L.latest_adm_dt;
self.sch_rel_dt := L.sch_rel_dt;
self.act_rel_dt := L.act_rel_dt;
self.ctl_rel_dt := L.ctl_rel_dt;
self.presump_par_rel_dt := L.presump_par_rel_dt;
self.mutl_part_pgm_dt := L.mutl_part_pgm_dt;
self.release_type := L.release_type;
self.office_region := L.office_region;
self.par_cur_stat := L.par_cur_stat;
self.par_cur_stat_desc := L.par_cur_stat_desc;
self.par_status_dt := L.par_status_dt;
self.par_st_dt := L.par_st_dt;
self.par_sch_end_dt := L.par_sch_end_dt;
self.par_act_end_dt := L.par_act_end_dt;
self.par_cty_cd := L.par_cty_cd;
self.par_cty := L.par_cty;
self.supv_office := L.supv_office;
self.supv_officer := L.supv_officer;
self.office_phone := L.office_phone;
self.tdcjid_unit_type := L.tdcjid_unit_type;
self.tdcjid_unit_assigned := L.tdcjid_unit_assigned;
self.tdcjid_admit_date := L.tdcjid_admit_date;
self.prison_status := L.prison_status;
self.recv_dept_code := L.recv_dept_code;
self.recv_dept_date := L.recv_dept_date;
self.parole_active_flag := L.parole_active_flag;
self.casepull_date := L.casepull_date;
self.conviction_override_date := L.conviction_override_date;
self.conviction_override_date_type := L.conviction_override_date_type;
self.punishment_persistent_id := L.punishment_persistent_id;
END;




EXPORT file_Key_punishment := project(key_in,makerecord(left));

