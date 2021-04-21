
IMPORT doxie_files,CriminalRecords_BatchService;

EXPORT get_punishments(DATASET(Assorted_Layouts.key) ofdkey_field = DATASET([],Assorted_Layouts.Key)) := FUNCTION
 
  pun_field_3 := JOIN(ofdkey_field, doxie_files.key_punishment(),
    KEYED(LEFT.offender_key = RIGHT.ok));
                          
  pun_field_2 := DEDUP(SORT(pun_field_3
                            ,sdid,offender_key,punishment_type,-event_dt,sent_length
                            ,cur_stat_inm,cur_loc_inm,cur_loc_sec,latest_adm_dt,act_rel_dt,ctl_rel_dt)
                      ,sdid,offender_key,punishment_type ,event_dt,sent_length
                      ,cur_stat_inm,cur_loc_inm,cur_loc_sec,latest_adm_dt,act_rel_dt,ctl_rel_dt);
 // OUTPUT(pun_field_2);
  pun_field_1 := GROUP(SORT(pun_field_2
                      ,sdid,offender_key,punishment_type,-event_dt,-latest_adm_dt)
                      ,sdid,offender_key) ;
                      
  CriminalRecords_BatchService.Assorted_Layouts.Layout_out xfm_punishment(
    RECORDOF(pun_field_1) L, DATASET(RECORDOF(pun_field_1)) R) := TRANSFORM
    // R := SORT(R1,-latest_adm_dt);
    P := R(punishment_type ='P');
    I :=R(punishment_type ='I');
    // I := R(punishment_type ='I');
    SELF.output_type := 'P';

    SELF.par_event_dt_1 := P[1].event_dt;
    SELF.presump_par_rel_dt_1 := P[1].presump_par_rel_dt;
    SELF.par_cur_stat_1 := P[1].par_cur_stat;
    SELF.par_cur_stat_desc_1 := P[1].par_cur_stat_desc;
    SELF.par_st_dt_1 := P[1].par_st_dt;
    SELF.par_sch_end_dt_1 := P[1].par_sch_end_dt;
    SELF.par_act_end_dt_1 := P[1].par_act_end_dt;
    SELF.par_cty_1 := P[1].par_cty;

    SELF.par_event_dt_2 := P[2].event_dt;
    SELF.presump_par_rel_dt_2 := P[2].presump_par_rel_dt;
    SELF.par_cur_stat_2 := P[2].par_cur_stat;
    SELF.par_cur_stat_desc_2 := P[2].par_cur_stat_desc;
    SELF.par_st_dt_2 := P[2].par_st_dt;
    SELF.par_sch_end_dt_2 := P[2].par_sch_end_dt;
    SELF.par_act_end_dt_2 := P[2].par_act_end_dt;
    SELF.par_cty_2 := P[2].par_cty;

    SELF.par_event_dt_3 := P[3].event_dt;
    SELF.presump_par_rel_dt_3 := P[3].presump_par_rel_dt;
    SELF.par_cur_stat_3 := P[3].par_cur_stat;
    SELF.par_cur_stat_desc_3 := P[3].par_cur_stat_desc;
    SELF.par_st_dt_3 := P[3].par_st_dt;
    SELF.par_sch_end_dt_3 := P[3].par_sch_end_dt;
    SELF.par_act_end_dt_3 := P[3].par_act_end_dt;
    SELF.par_cty_3 := P[3].par_cty;

    SELF.par_event_dt_4 := P[4].event_dt;
    SELF.presump_par_rel_dt_4 := P[4].presump_par_rel_dt;
    SELF.par_cur_stat_4 := P[4].par_cur_stat;
    SELF.par_cur_stat_desc_4 := P[4].par_cur_stat_desc;
    SELF.par_st_dt_4 := P[4].par_st_dt;
    SELF.par_sch_end_dt_4 := P[4].par_sch_end_dt;
    SELF.par_act_end_dt_4 := P[4].par_act_end_dt;
    SELF.par_cty_4 := P[4].par_cty;

    SELF.par_event_dt_5 := P[5].event_dt;
    SELF.presump_par_rel_dt_5 := P[5].presump_par_rel_dt;
    SELF.par_cur_stat_5 := P[5].par_cur_stat;
    SELF.par_cur_stat_desc_5 := P[5].par_cur_stat_desc;
    SELF.par_st_dt_5 := P[5].par_st_dt;
    SELF.par_sch_end_dt_5 := P[5].par_sch_end_dt;
    SELF.par_act_end_dt_5 := P[5].par_act_end_dt;
    SELF.par_cty_5 := P[5].par_cty;

    SELF.par_event_dt_6 := P[6].event_dt;
    SELF.presump_par_rel_dt_6 := P[6].presump_par_rel_dt;
    SELF.par_cur_stat_6 := P[6].par_cur_stat;
    SELF.par_cur_stat_desc_6 := P[6].par_cur_stat_desc;
    SELF.par_st_dt_6 := P[6].par_st_dt;
    SELF.par_sch_end_dt_6 := P[6].par_sch_end_dt;
    SELF.par_act_end_dt_6 := P[6].par_act_end_dt;
    SELF.par_cty_6 := P[6].par_cty;
    
    SELF.in_event_dt_1 := I[1].event_dt;
    SELF.sent_length_1:= I[1].sent_length;
    SELF.sent_length_desc_1 := I[1].sent_length_desc;
    SELF.cur_stat_inm_1 := I[1].cur_stat_inm;
    SELF.cur_stat_inm_desc_1 := I[1].cur_stat_inm_desc;
    SELF.cur_loc_inm_cd_1 := I[1].cur_loc_inm_cd;
    SELF.cur_loc_inm_1 := I[1].cur_loc_inm;
    SELF.cur_sec_class_dt_1 := I[1].cur_sec_class_dt;
    SELF.cur_loc_sec_1 := I[1].cur_loc_sec;
    SELF.gain_time_1 := I[1].gain_time;
    SELF.gain_time_eff_dt_1 := I[1].gain_time_eff_dt;
    SELF.latest_adm_dt_1 := I[1].latest_adm_dt;
    SELF.sch_rel_dt_1 := I[1].sch_rel_dt;
    SELF.act_rel_dt_1 := I[1].act_rel_dt;
    SELF.ctl_rel_dt_1 := I[1].ctl_rel_dt;

    SELF.in_event_dt_2 := I[2].event_dt;
    SELF.sent_length_2:= I[2].sent_length;
    SELF.sent_length_desc_2 := I[2].sent_length_desc;
    SELF.cur_stat_inm_2 := I[2].cur_stat_inm;
    SELF.cur_stat_inm_desc_2 := I[2].cur_stat_inm_desc;
    SELF.cur_loc_inm_cd_2 := I[2].cur_loc_inm_cd;
    SELF.cur_loc_inm_2 := I[2].cur_loc_inm;
    SELF.cur_sec_class_dt_2 := I[2].cur_sec_class_dt;
    SELF.cur_loc_sec_2 := I[2].cur_loc_sec;
    SELF.gain_time_2 := I[2].gain_time;
    SELF.gain_time_eff_dt_2 := I[2].gain_time_eff_dt;
    SELF.latest_adm_dt_2 := I[2].latest_adm_dt;
    SELF.sch_rel_dt_2 := I[2].sch_rel_dt;
    SELF.act_rel_dt_2 := I[2].act_rel_dt;
    SELF.ctl_rel_dt_2 := I[2].ctl_rel_dt;
    
    SELF.in_event_dt_3 := I[3].event_dt;
    SELF.sent_length_3:= I[3].sent_length;
    SELF.sent_length_desc_3 := I[3].sent_length_desc;
    SELF.cur_stat_inm_3 := I[3].cur_stat_inm;
    SELF.cur_stat_inm_desc_3 := I[3].cur_stat_inm_desc;
    SELF.cur_loc_inm_cd_3 := I[3].cur_loc_inm_cd;
    SELF.cur_loc_inm_3 := I[3].cur_loc_inm;
    SELF.cur_sec_class_dt_3 := I[3].cur_sec_class_dt;
    SELF.cur_loc_sec_3 := I[3].cur_loc_sec;
    SELF.gain_time_3 := I[3].gain_time;
    SELF.gain_time_eff_dt_3 := I[3].gain_time_eff_dt;
    SELF.latest_adm_dt_3 := I[3].latest_adm_dt;
    SELF.sch_rel_dt_3 := I[3].sch_rel_dt;
    SELF.act_rel_dt_3 := I[3].act_rel_dt;
    SELF.ctl_rel_dt_3 := I[3].ctl_rel_dt;

    SELF.in_event_dt_4 := I[4].event_dt;
    SELF.sent_length_4:= I[4].sent_length;
    SELF.sent_length_desc_4 := I[4].sent_length_desc;
    SELF.cur_stat_inm_4 := I[4].cur_stat_inm;
    SELF.cur_stat_inm_desc_4 := I[4].cur_stat_inm_desc;
    SELF.cur_loc_inm_cd_4 := I[4].cur_loc_inm_cd;
    SELF.cur_loc_inm_4 := I[4].cur_loc_inm;
    SELF.cur_sec_class_dt_4 := I[4].cur_sec_class_dt;
    SELF.cur_loc_sec_4 := I[4].cur_loc_sec;
    SELF.gain_time_4 := I[4].gain_time;
    SELF.gain_time_eff_dt_4 := I[4].gain_time_eff_dt;
    SELF.latest_adm_dt_4 := I[4].latest_adm_dt;
    SELF.sch_rel_dt_4 := I[4].sch_rel_dt;
    SELF.act_rel_dt_4 := I[4].act_rel_dt;
    SELF.ctl_rel_dt_4 := I[4].ctl_rel_dt;
    
    SELF.in_event_dt_5 := I[5].event_dt;
    SELF.sent_length_5:= I[5].sent_length;
    SELF.sent_length_desc_5 := I[5].sent_length_desc;
    SELF.cur_stat_inm_5 := I[5].cur_stat_inm;
    SELF.cur_stat_inm_desc_5 := I[5].cur_stat_inm_desc;
    SELF.cur_loc_inm_cd_5 := I[5].cur_loc_inm_cd;
    SELF.cur_loc_inm_5 := I[5].cur_loc_inm;
    SELF.cur_sec_class_dt_5 := I[5].cur_sec_class_dt;
    SELF.cur_loc_sec_5 := I[5].cur_loc_sec;
    SELF.gain_time_5 := I[5].gain_time;
    SELF.gain_time_eff_dt_5 := I[5].gain_time_eff_dt;
    SELF.latest_adm_dt_5 := I[5].latest_adm_dt;
    SELF.sch_rel_dt_5 := I[5].sch_rel_dt;
    SELF.act_rel_dt_5 := I[5].act_rel_dt;
    SELF.ctl_rel_dt_5 := I[5].ctl_rel_dt;

    SELF.in_event_dt_6 := I[6].event_dt;
    SELF.sent_length_6:= I[6].sent_length;
    SELF.sent_length_desc_6 := I[6].sent_length_desc;
    SELF.cur_stat_inm_6 := I[6].cur_stat_inm;
    SELF.cur_stat_inm_desc_6 := I[6].cur_stat_inm_desc;
    SELF.cur_loc_inm_cd_6 := I[6].cur_loc_inm_cd;
    SELF.cur_loc_inm_6 := I[6].cur_loc_inm;
    SELF.cur_sec_class_dt_6 := I[6].cur_sec_class_dt;
    SELF.cur_loc_sec_6 := I[6].cur_loc_sec;
    SELF.gain_time_6 := I[6].gain_time;
    SELF.gain_time_eff_dt_6 := I[6].gain_time_eff_dt;
    SELF.latest_adm_dt_6 := I[6].latest_adm_dt;
    SELF.sch_rel_dt_6 := I[6].sch_rel_dt;
    SELF.act_rel_dt_6 := I[6].act_rel_dt;
    SELF.ctl_rel_dt_6 := I[6].ctl_rel_dt;
    SELF := L;
    SELF := [];
  END;
                      
  pun_field := ROLLUP(pun_field_1,GROUP,xfm_punishment(LEFT,ROWS(LEFT)));
  
  RETURN pun_field;
END;
