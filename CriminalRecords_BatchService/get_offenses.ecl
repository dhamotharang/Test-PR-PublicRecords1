

IMPORT doxie_files,CriminalRecords_BatchService;

EXPORT get_offenses(DATASET(Assorted_Layouts.key) ofdkey_field = DATASET([],Assorted_Layouts.key)) := FUNCTION

  // offenses
  offs := doxie_files.key_offenses ();
  
  offs_field_2 := JOIN(ofdkey_field,offs, KEYED(LEFT.offender_key = RIGHT.ok));
    
  // OUTPUT(offs_field_2);
  offs_field_1 := GROUP(DEDUP(SORT(offs_field_2
                              ,sdid,offender_key,-off_date,-arr_date,case_num,off_code,process_date)
                        ,sdid,offender_key,off_date,arr_date,case_num,off_code,process_date)
                        ,sdid,offender_key);
                     
                       
  CriminalRecords_BatchService.Assorted_Layouts.Layout_out xfm_offenses(RECORDOF(offs_field_1) L, DATASET(RECORDOF(offs_field_1)) R) := TRANSFORM
    SELF.output_type := 'F';
    SELF.case_num_1 := R[1].case_num;
    SELF.off_date_1 := R[1].off_date;
    SELF.arr_date_1 := R[1].arr_date;
    SELF.num_of_counts_1 := R[1].num_of_counts;
    SELF.off_code_1 := R[1].off_code;
    SELF.chg_1 := R[1].chg;
    SELF.off_desc_1_1 := R[1].off_desc_1;
    SELF.off_desc_2_1 := R[1].off_desc_2;
    SELF.add_off_cd_1 := R[1].add_off_cd;
    SELF.add_off_desc_1 := R[1].add_off_desc;
    SELF.off_typ_1 := R[1].off_typ;
    SELF.off_lev_1 := R[1].off_lev;
    SELF.court_desc_1 := R[1].court_desc;
    SELF.cty_conv_1 := R[1].cty_conv;
    SELF.stc_dt_1 := R[1].stc_dt;
    SELF.stc_comp_1 := R[1].stc_comp;
    SELF.stc_desc_1_1 := R[1].stc_desc_1;
    SELF.stc_desc_2_1 := R[1].stc_desc_2;
    SELF.stc_desc_3_1 := R[1].stc_desc_3;
    SELF.stc_desc_4_1 := R[1].stc_desc_4;
    SELF.stc_lgth_1 := R[1].stc_lgth;
    SELF.stc_lgth_desc_1 := R[1].stc_lgth_desc;
    SELF.inc_adm_dt_1 := R[1].inc_adm_dt;
    SELF.min_term_1 := R[1].min_term;
    SELF.min_term_desc_1 := R[1].min_term_desc;
    SELF.max_term_1 := R[1].max_term;
    SELF.max_term_desc_1 := R[1].max_term_desc;

    SELF.case_num_2 := R[2].case_num;
    SELF.off_date_2 := R[2].off_date;
    SELF.arr_date_2 := R[2].arr_date;
    SELF.num_of_counts_2 := R[2].num_of_counts;
    SELF.off_code_2 := R[2].off_code;
    SELF.chg_2 := R[2].chg;
    SELF.off_desc_1_2 := R[2].off_desc_1;
    SELF.off_desc_2_2 := R[2].off_desc_2;
    SELF.add_off_cd_2 := R[2].add_off_cd;
    SELF.add_off_desc_2 := R[2].add_off_desc;
    SELF.off_typ_2 := R[2].off_typ;
    SELF.off_lev_2 := R[2].off_lev;
    SELF.court_desc_2 := R[2].court_desc;
    SELF.cty_conv_2 := R[2].cty_conv;
    SELF.stc_dt_2 := R[2].stc_dt;
    SELF.stc_comp_2 := R[2].stc_comp;
    SELF.stc_desc_1_2 := R[2].stc_desc_1;
    SELF.stc_desc_2_2 := R[2].stc_desc_2;
    SELF.stc_desc_3_2 := R[2].stc_desc_3;
    SELF.stc_desc_4_2 := R[2].stc_desc_4;
    SELF.stc_lgth_2 := R[2].stc_lgth;
    SELF.stc_lgth_desc_2 := R[2].stc_lgth_desc;
    SELF.inc_adm_dt_2 := R[2].inc_adm_dt;
    SELF.min_term_2 := R[2].min_term;
    SELF.min_term_desc_2 := R[2].min_term_desc;
    SELF.max_term_2 := R[2].max_term;
    SELF.max_term_desc_2 := R[2].max_term_desc;

    SELF.case_num_3 := R[3].case_num;
    SELF.off_date_3 := R[3].off_date;
    SELF.arr_date_3 := R[3].arr_date;
    SELF.num_of_counts_3 := R[3].num_of_counts;
    SELF.off_code_3 := R[3].off_code;
    SELF.chg_3 := R[3].chg;
    SELF.off_desc_1_3 := R[3].off_desc_1;
    SELF.off_desc_2_3 := R[3].off_desc_2;
    SELF.add_off_cd_3 := R[3].add_off_cd;
    SELF.add_off_desc_3 := R[3].add_off_desc;
    SELF.off_typ_3 := R[3].off_typ;
    SELF.off_lev_3 := R[3].off_lev;
    SELF.court_desc_3 := R[3].court_desc;
    SELF.cty_conv_3 := R[3].cty_conv;
    SELF.stc_dt_3 := R[3].stc_dt;
    SELF.stc_comp_3 := R[3].stc_comp;
    SELF.stc_desc_1_3 := R[3].stc_desc_1;
    SELF.stc_desc_2_3 := R[3].stc_desc_2;
    SELF.stc_desc_3_3 := R[3].stc_desc_3;
    SELF.stc_desc_4_3 := R[3].stc_desc_4;
    SELF.stc_lgth_3 := R[3].stc_lgth;
    SELF.stc_lgth_desc_3 := R[3].stc_lgth_desc;
    SELF.inc_adm_dt_3 := R[3].inc_adm_dt;
    SELF.min_term_3 := R[3].min_term;
    SELF.min_term_desc_3 := R[3].min_term_desc;
    SELF.max_term_3 := R[3].max_term;
    SELF.max_term_desc_3 := R[3].max_term_desc;

    SELF.case_num_4 := R[4].case_num;
    SELF.off_date_4 := R[4].off_date;
    SELF.arr_date_4 := R[4].arr_date;
    SELF.num_of_counts_4 := R[4].num_of_counts;
    SELF.off_code_4 := R[4].off_code;
    SELF.chg_4 := R[4].chg;
    SELF.off_desc_1_4 := R[4].off_desc_1;
    SELF.off_desc_2_4 := R[4].off_desc_2;
    SELF.add_off_cd_4 := R[4].add_off_cd;
    SELF.add_off_desc_4 := R[4].add_off_desc;
    SELF.off_typ_4 := R[4].off_typ;
    SELF.off_lev_4 := R[4].off_lev;
    SELF.court_desc_4 := R[4].court_desc;
    SELF.cty_conv_4 := R[4].cty_conv;
    SELF.stc_dt_4 := R[4].stc_dt;
    SELF.stc_comp_4 := R[4].stc_comp;
    SELF.stc_desc_1_4 := R[4].stc_desc_1;
    SELF.stc_desc_2_4 := R[4].stc_desc_2;
    SELF.stc_desc_3_4 := R[4].stc_desc_3;
    SELF.stc_desc_4_4 := R[4].stc_desc_4;
    SELF.stc_lgth_4 := R[4].stc_lgth;
    SELF.stc_lgth_desc_4 := R[4].stc_lgth_desc;
    SELF.inc_adm_dt_4 := R[4].inc_adm_dt;
    SELF.min_term_4 := R[4].min_term;
    SELF.min_term_desc_4 := R[4].min_term_desc;
    SELF.max_term_4 := R[4].max_term;
    SELF.max_term_desc_4 := R[4].max_term_desc;

    SELF.case_num_5 := R[5].case_num;
    SELF.off_date_5 := R[5].off_date;
    SELF.arr_date_5 := R[5].arr_date;
    SELF.num_of_counts_5 := R[5].num_of_counts;
    SELF.off_code_5 := R[5].off_code;
    SELF.chg_5 := R[5].chg;
    SELF.off_desc_1_5 := R[5].off_desc_1;
    SELF.off_desc_2_5 := R[5].off_desc_2;
    SELF.add_off_cd_5 := R[5].add_off_cd;
    SELF.add_off_desc_5 := R[5].add_off_desc;
    SELF.off_typ_5 := R[5].off_typ;
    SELF.off_lev_5 := R[5].off_lev;
    SELF.court_desc_5 := R[5].court_desc;
    SELF.cty_conv_5 := R[5].cty_conv;
    SELF.stc_dt_5 := R[5].stc_dt;
    SELF.stc_comp_5 := R[5].stc_comp;
    SELF.stc_desc_1_5 := R[5].stc_desc_1;
    SELF.stc_desc_2_5 := R[5].stc_desc_2;
    SELF.stc_desc_3_5 := R[5].stc_desc_3;
    SELF.stc_desc_4_5 := R[5].stc_desc_4;
    SELF.stc_lgth_5 := R[5].stc_lgth;
    SELF.stc_lgth_desc_5 := R[5].stc_lgth_desc;
    SELF.inc_adm_dt_5 := R[5].inc_adm_dt;
    SELF.min_term_5 := R[5].min_term;
    SELF.min_term_desc_5 := R[5].min_term_desc;
    SELF.max_term_5 := R[5].max_term;
    SELF.max_term_desc_5 := R[5].max_term_desc;

    SELF.case_num_6 := R[6].case_num;
    SELF.off_date_6 := R[6].off_date;
    SELF.arr_date_6 := R[6].arr_date;
    SELF.num_of_counts_6 := R[6].num_of_counts;
    SELF.off_code_6 := R[6].off_code;
    SELF.chg_6 := R[6].chg;
    SELF.off_desc_1_6 := R[6].off_desc_1;
    SELF.off_desc_2_6 := R[6].off_desc_2;
    SELF.add_off_cd_6 := R[6].add_off_cd;
    SELF.add_off_desc_6 := R[6].add_off_desc;
    SELF.off_typ_6 := R[6].off_typ;
    SELF.off_lev_6 := R[6].off_lev;
    SELF.court_desc_6 := R[6].court_desc;
    SELF.cty_conv_6 := R[6].cty_conv;
    SELF.stc_dt_6 := R[6].stc_dt;
    SELF.stc_comp_6 := R[6].stc_comp;
    SELF.stc_desc_1_6 := R[6].stc_desc_1;
    SELF.stc_desc_2_6 := R[6].stc_desc_2;
    SELF.stc_desc_3_6 := R[6].stc_desc_3;
    SELF.stc_desc_4_6 := R[6].stc_desc_4;
    SELF.stc_lgth_6 := R[6].stc_lgth;
    SELF.stc_lgth_desc_6 := R[6].stc_lgth_desc;
    SELF.inc_adm_dt_6 := R[6].inc_adm_dt;
    SELF.min_term_6 := R[6].min_term;
    SELF.min_term_desc_6 := R[6].min_term_desc;
    SELF.max_term_6 := R[6].max_term;
    SELF.max_term_desc_6 := R[6].max_term_desc;
    SELF := L;
    SELF := [];
  END;
  offs_field := ROLLUP(offs_field_1,GROUP,xfm_offenses(LEFT,ROWS(LEFT)));
  
  RETURN Offs_field;

END;
