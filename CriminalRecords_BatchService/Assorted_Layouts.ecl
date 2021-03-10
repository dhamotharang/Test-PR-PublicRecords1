IMPORT Doxie, Autokey_batch, Corrections;

EXPORT Assorted_Layouts := MODULE
  EXPORT Layout_IN := RECORD
    Autokey_batch.Layouts.rec_inBatchMaster;
    STRING25 docnum := '' ;
  END;
  
  EXPORT key := RECORD
    STRING30 acctno := '';
    STRING1 Match_type := '';
    STRING20 sdid := '';
    STRING60 offender_key := '';
  END;
  
  EXPORT offender := RECORD
    //offender
    //thor_data400::key::corrections_offenders::20071130::public
    STRING9 ssn;
    STRING30 lname;
    STRING30 fname;
    STRING30 mname;
    STRING1 pty_typ;
    STRING2 citizenship;
    STRING2 state_origin;
    STRING10 dle_num;
    STRING9 fbi_num;
    STRING10 ins_num;
    STRING15 id_num;
    STRING10 doc_num;
    STRING8 dob;
    STRING8 dob_alias;
    STRING25 place_of_birth;
    STRING25 street_address_1;
    STRING25 street_address_2;
    STRING25 street_address_3;
    STRING10 street_address_4;
    STRING10 street_address_5;
    Corrections.Layout_Offender.curr_incar_flag;
    Corrections.Layout_Offender.curr_parole_flag;
    Corrections.Layout_Offender.curr_probation_flag;
    STRING3 race;
    STRING30 race_desc;
    STRING7 sex;
    STRING3 hair_color;
    STRING15 hair_color_desc;
    STRING3 eye_color;
    STRING15 eye_color_desc;
    STRING3 skin_color;
    STRING15 skin_color_desc;
    STRING3 height;
    STRING3 weight;
    STRING5 party_status;
    STRING60 party_status_desc;
    STRING1 data_type;
    STRING45 datasource;
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING10 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 p_city_name;
    QSTRING25 v_city_name;
    STRING2 st;
    QSTRING5 zip5;
    QSTRING4 zip4;
  END;
  

  EXPORT Offenses := RECORD
    STRING8 process_date;
    // STRING20 offender_key;
    STRING35 case_num_1;
    STRING8 off_date_1;
    STRING8 arr_date_1;
    STRING3 num_of_counts_1;
    STRING20 off_code_1;
    STRING31 chg_1;
    STRING75 off_desc_1_1;
    STRING50 off_desc_2_1;
    STRING2 add_off_cd_1;
    STRING30 add_off_desc_1;
    STRING1 off_typ_1;
    STRING2 off_lev_1;
    STRING40 court_desc_1;
    STRING30 cty_conv_1;
    STRING8 stc_dt_1;
    STRING3 stc_comp_1;
    STRING50 stc_desc_1_1;
    STRING50 stc_desc_2_1;
    STRING50 stc_desc_3_1;
    STRING50 stc_desc_4_1;
    STRING15 stc_lgth_1;
    STRING50 stc_lgth_desc_1;
    STRING8 inc_adm_dt_1;
    STRING10 min_term_1;
    STRING35 min_term_desc_1;
    STRING10 max_term_1;
    STRING35 max_term_desc_1;
    
    STRING35 case_num_2;
    STRING8 off_date_2;
    STRING8 arr_date_2;
    STRING3 num_of_counts_2;
    STRING20 off_code_2;
    STRING31 chg_2;
    STRING75 off_desc_1_2;
    STRING50 off_desc_2_2;
    STRING2 add_off_cd_2;
    STRING30 add_off_desc_2;
    STRING1 off_typ_2;
    STRING2 off_lev_2;
    STRING40 court_desc_2;
    STRING30 cty_conv_2;
    STRING8 stc_dt_2;
    STRING3 stc_comp_2;
    STRING50 stc_desc_1_2;
    STRING50 stc_desc_2_2;
    STRING50 stc_desc_3_2;
    STRING50 stc_desc_4_2;
    STRING15 stc_lgth_2;
    STRING50 stc_lgth_desc_2;
    STRING8 inc_adm_dt_2;
    STRING10 min_term_2;
    STRING35 min_term_desc_2;
    STRING10 max_term_2;
    STRING35 max_term_desc_2;
    
    STRING35 case_num_3;
    STRING8 off_date_3;
    STRING8 arr_date_3;
    STRING3 num_of_counts_3;
    STRING20 off_code_3;
    STRING31 chg_3;
    STRING75 off_desc_1_3;
    STRING50 off_desc_2_3;
    STRING2 add_off_cd_3;
    STRING30 add_off_desc_3;
    STRING1 off_typ_3;
    STRING2 off_lev_3;
    STRING40 court_desc_3;
    STRING30 cty_conv_3;
    STRING8 stc_dt_3;
    STRING3 stc_comp_3;
    STRING50 stc_desc_1_3;
    STRING50 stc_desc_2_3;
    STRING50 stc_desc_3_3;
    STRING50 stc_desc_4_3;
    STRING15 stc_lgth_3;
    STRING50 stc_lgth_desc_3;
    STRING8 inc_adm_dt_3;
    STRING10 min_term_3;
    STRING35 min_term_desc_3;
    STRING10 max_term_3;
    STRING35 max_term_desc_3;
    
    STRING35 case_num_4;
    STRING8 off_date_4;
    STRING8 arr_date_4;
    STRING3 num_of_counts_4;
    STRING20 off_code_4;
    STRING31 chg_4;
    STRING75 off_desc_1_4;
    STRING50 off_desc_2_4;
    STRING2 add_off_cd_4;
    STRING30 add_off_desc_4;
    STRING1 off_typ_4;
    STRING2 off_lev_4;
    STRING40 court_desc_4;
    STRING30 cty_conv_4;
    STRING8 stc_dt_4;
    STRING3 stc_comp_4;
    STRING50 stc_desc_1_4;
    STRING50 stc_desc_2_4;
    STRING50 stc_desc_3_4;
    STRING50 stc_desc_4_4;
    STRING15 stc_lgth_4;
    STRING50 stc_lgth_desc_4;
    STRING8 inc_adm_dt_4;
    STRING10 min_term_4;
    STRING35 min_term_desc_4;
    STRING10 max_term_4;
    STRING35 max_term_desc_4;
    
    STRING35 case_num_5;
    STRING8 off_date_5;
    STRING8 arr_date_5;
    STRING3 num_of_counts_5;
    STRING20 off_code_5;
    STRING31 chg_5;
    STRING75 off_desc_1_5;
    STRING50 off_desc_2_5;
    STRING2 add_off_cd_5;
    STRING30 add_off_desc_5;
    STRING1 off_typ_5;
    STRING2 off_lev_5;
    STRING40 court_desc_5;
    STRING30 cty_conv_5;
    STRING8 stc_dt_5;
    STRING3 stc_comp_5;
    STRING50 stc_desc_1_5;
    STRING50 stc_desc_2_5;
    STRING50 stc_desc_3_5;
    STRING50 stc_desc_4_5;
    STRING15 stc_lgth_5;
    STRING50 stc_lgth_desc_5;
    STRING8 inc_adm_dt_5;
    STRING10 min_term_5;
    STRING35 min_term_desc_5;
    STRING10 max_term_5;
    STRING35 max_term_desc_5;
    
    STRING35 case_num_6;
    STRING8 off_date_6;
    STRING8 arr_date_6;
    STRING3 num_of_counts_6;
    STRING20 off_code_6;
    STRING31 chg_6;
    STRING75 off_desc_1_6;
    STRING50 off_desc_2_6;
    STRING2 add_off_cd_6;
    STRING30 add_off_desc_6;
    STRING1 off_typ_6;
    STRING2 off_lev_6;
    STRING40 court_desc_6;
    STRING30 cty_conv_6;
    STRING8 stc_dt_6;
    STRING3 stc_comp_6;
    STRING50 stc_desc_1_6;
    STRING50 stc_desc_2_6;
    STRING50 stc_desc_3_6;
    STRING50 stc_desc_4_6;
    STRING15 stc_lgth_6;
    STRING50 stc_lgth_desc_6;
    STRING8 inc_adm_dt_6;
    STRING10 min_term_6;
    STRING35 min_term_desc_6;
    STRING10 max_term_6;
    STRING35 max_term_desc_6;

  END;

  EXPORT par_punishment := RECORD
      
    STRING8 par_event_dt_1;
    STRING8 presump_par_rel_dt_1;
    STRING8 par_cur_stat_1;
    STRING50 par_cur_stat_desc_1;
    STRING8 par_st_dt_1;
    STRING8 par_sch_end_dt_1;
    STRING8 par_act_end_dt_1;
    STRING50 par_cty_1;

    STRING8 par_event_dt_2;
    STRING8 presump_par_rel_dt_2;
    STRING8 par_cur_stat_2;
    STRING50 par_cur_stat_desc_2;
    STRING8 par_st_dt_2;
    STRING8 par_sch_end_dt_2;
    STRING8 par_act_end_dt_2;
    STRING50 par_cty_2;
    
    STRING8 par_event_dt_3;
    STRING8 presump_par_rel_dt_3;
    STRING8 par_cur_stat_3;
    STRING50 par_cur_stat_desc_3;
    STRING8 par_st_dt_3;
    STRING8 par_sch_end_dt_3;
    STRING8 par_act_end_dt_3;
    STRING50 par_cty_3;
    
    STRING8 par_event_dt_4;
    STRING8 presump_par_rel_dt_4;
    STRING8 par_cur_stat_4;
    STRING50 par_cur_stat_desc_4;
    STRING8 par_st_dt_4;
    STRING8 par_sch_end_dt_4;
    STRING8 par_act_end_dt_4;
    STRING50 par_cty_4;
    
    STRING8 par_event_dt_5;
    STRING8 presump_par_rel_dt_5;
    STRING8 par_cur_stat_5;
    STRING50 par_cur_stat_desc_5;
    STRING8 par_st_dt_5;
    STRING8 par_sch_end_dt_5;
    STRING8 par_act_end_dt_5;
    STRING50 par_cty_5;
    
    STRING8 par_event_dt_6;
    STRING8 presump_par_rel_dt_6;
    STRING8 par_cur_stat_6;
    STRING50 par_cur_stat_desc_6;
    STRING8 par_st_dt_6;
    STRING8 par_sch_end_dt_6;
    STRING8 par_act_end_dt_6;
    STRING50 par_cty_6;
  END;

  EXPORT in_Punishment := RECORD
    STRING8 in_event_dt_1;
    STRING15 sent_length_1;
    STRING60 sent_length_desc_1;
    STRING8 cur_stat_inm_1;
    STRING50 cur_stat_inm_desc_1;
    STRING8 cur_loc_inm_cd_1;
    STRING60 cur_loc_inm_1;
    STRING8 cur_sec_class_dt_1;
    STRING25 cur_loc_sec_1;
    STRING3 gain_time_1;
    STRING8 gain_time_eff_dt_1;
    STRING8 latest_adm_dt_1;
    STRING8 sch_rel_dt_1;
    STRING8 act_rel_dt_1;
    STRING8 ctl_rel_dt_1;
    
    STRING8 in_event_dt_2;
    STRING15 sent_length_2;
    STRING60 sent_length_desc_2;
    STRING8 cur_stat_inm_2;
    STRING50 cur_stat_inm_desc_2;
    STRING8 cur_loc_inm_cd_2;
    STRING60 cur_loc_inm_2;
    STRING8 cur_sec_class_dt_2;
    STRING25 cur_loc_sec_2;
    STRING3 gain_time_2;
    STRING8 gain_time_eff_dt_2;
    STRING8 latest_adm_dt_2;
    STRING8 sch_rel_dt_2;
    STRING8 act_rel_dt_2;
    STRING8 ctl_rel_dt_2;

    STRING8 in_event_dt_3;
    STRING15 sent_length_3;
    STRING60 sent_length_desc_3;
    STRING8 cur_stat_inm_3;
    STRING50 cur_stat_inm_desc_3;
    STRING8 cur_loc_inm_cd_3;
    STRING60 cur_loc_inm_3;
    STRING8 cur_sec_class_dt_3;
    STRING25 cur_loc_sec_3;
    STRING3 gain_time_3;
    STRING8 gain_time_eff_dt_3;
    STRING8 latest_adm_dt_3;
    STRING8 sch_rel_dt_3;
    STRING8 act_rel_dt_3;
    STRING8 ctl_rel_dt_3;
    
    STRING8 in_event_dt_4;
    STRING15 sent_length_4;
    STRING60 sent_length_desc_4;
    STRING8 cur_stat_inm_4;
    STRING50 cur_stat_inm_desc_4;
    STRING8 cur_loc_inm_cd_4;
    STRING60 cur_loc_inm_4;
    STRING8 cur_sec_class_dt_4;
    STRING25 cur_loc_sec_4;
    STRING3 gain_time_4;
    STRING8 gain_time_eff_dt_4;
    STRING8 latest_adm_dt_4;
    STRING8 sch_rel_dt_4;
    STRING8 act_rel_dt_4;
    STRING8 ctl_rel_dt_4;
    
    STRING8 in_event_dt_5;
    STRING15 sent_length_5;
    STRING60 sent_length_desc_5;
    STRING8 cur_stat_inm_5;
    STRING50 cur_stat_inm_desc_5;
    STRING8 cur_loc_inm_cd_5;
    STRING60 cur_loc_inm_5;
    STRING8 cur_sec_class_dt_5;
    STRING25 cur_loc_sec_5;
    STRING3 gain_time_5;
    STRING8 gain_time_eff_dt_5;
    STRING8 latest_adm_dt_5;
    STRING8 sch_rel_dt_5;
    STRING8 act_rel_dt_5;
    STRING8 ctl_rel_dt_5;
    
    STRING8 in_event_dt_6;
    STRING15 sent_length_6;
    STRING60 sent_length_desc_6;
    STRING8 cur_stat_inm_6;
    STRING50 cur_stat_inm_desc_6;
    STRING8 cur_loc_inm_cd_6;
    STRING60 cur_loc_inm_6;
    STRING8 cur_sec_class_dt_6;
    STRING25 cur_loc_sec_6;
    STRING3 gain_time_6;
    STRING8 gain_time_eff_dt_6;
    STRING8 latest_adm_dt_6;
    STRING8 sch_rel_dt_6;
    STRING8 act_rel_dt_6;
    STRING8 ctl_rel_dt_6;
  END;
  
  EXPORT punishment := RECORD
    in_punishment;
    par_punishment;
  END;
  
  EXPORT Layout_OUT := RECORD
    // unsigned2 penalt := 0;
    STRING2 output_type;
    key;
    offender;
    offenses;
    punishment;
  END;
  
  EXPORT Layout_OUT1 := RECORD
    key;
    offender;
    offenses;
    punishment;
    STRING3 too_many_code :='';
    STRING1 too_many_flag := '';
  END;
  
  EXPORT Layout_PII_In := RECORD
    doxie.layout_references_acctno.acctno;

    STRING20 name_first;
    STRING20 name_middle;
    STRING20 name_last;
    STRING10 name_suffix;

    STRING12 ssn;
    UNSIGNED dob;

    STRING stAddr{MAXLENGTH(120)};
    STRING25 city;
    STRING25 state;
    STRING10 zip;
  END;

  EXPORT Layout_PII_Out := RECORD
    doxie.layout_references_acctno.acctno;
    STRING1 Incarceration_Flag;
    TYPEOF(Corrections.Layout_Offender.orig_state) INCR_state_origin;
    TYPEOF(Corrections.Layout_Offender.doc_num) INCR_doc_num;
    TYPEOF(Corrections.Layout_Offender.dob) INCR_dob;
    Corrections.Layout_CrimPunishment.event_dt;
    Corrections.Layout_CrimPunishment.punishment_type;
    Corrections.Layout_CrimPunishment.sent_length;
    Corrections.Layout_CrimPunishment.sent_length_desc;
    Corrections.Layout_CrimPunishment.cur_stat_inm;
    Corrections.Layout_CrimPunishment.cur_stat_inm_desc;
    Corrections.Layout_CrimPunishment.cur_loc_inm;
    Corrections.Layout_CrimPunishment.cur_sec_class_dt;
    Corrections.Layout_CrimPunishment.cur_loc_sec;
    Corrections.Layout_CrimPunishment.gain_time;
    Corrections.Layout_CrimPunishment.gain_time_eff_dt;
    Corrections.Layout_CrimPunishment.latest_adm_dt;
    Corrections.Layout_CrimPunishment.sch_rel_dt;
    Corrections.Layout_CrimPunishment.act_rel_dt;
    Corrections.Layout_CrimPunishment.ctl_rel_dt;
    Corrections.Layout_CrimPunishment.presump_par_rel_dt;
    STRING match_type{MAXLENGTH(8)};
    // BUG #97804 - Return Name and SSN
    TYPEOF(Corrections.Layout_Offender.ssn) INCR_ssn;
    TYPEOF(Corrections.Layout_Offender.fname) INCR_fname;
    TYPEOF(Corrections.Layout_Offender.lname) INCR_lname;
  END;


END;
