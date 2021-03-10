
IMPORT BatchServices, doxie_files, CriminalRecords_BatchService;

EXPORT get_court_offenses(DATASET(Assorted_Layouts.key) ofdkey_field = DATASET([],Assorted_Layouts.key)) := FUNCTION

         Currency := BatchServices.Functions.convert_cents_to_currency;
  STRING DISPLAY_NOTHING := '';
  
  // (Layout of doxie_files.Key_Court_Offenses is Crim_Common.Layout_In_Court_Offenses.)
  ds_court_offenses := JOIN(ofdkey_field, doxie_files.Key_Court_Offenses (),
                            KEYED(LEFT.offender_key = RIGHT.ofk));
    
  ds_court_offenses_grouped :=
                   GROUP(DEDUP(SORT(ds_court_offenses,
                                    sdid,
                                    offender_key,
                                    -off_date,
                                    -arr_date,
                                    court_case_number,
                                    arr_off_code,
                                    process_date),
                               sdid,
                               offender_key,
                               off_date,
                               arr_date,
                               court_case_number,
                               arr_off_code,
                               process_date),
                         sdid,offender_key
                         );
                       
  CriminalRecords_BatchService.Assorted_Layouts.Layout_out xfm_offenses(RECORDOF(ds_court_offenses_grouped) L, DATASET(RECORDOF(ds_court_offenses_grouped)) R) :=
    TRANSFORM
      SELF.output_type := 'F';
      SELF.process_date := R[1].process_date;
      
      /* ================= RECORD 1 ================= */
      
      SELF.case_num_1 := MAP( TRIM(R[1].court_case_number) != '' => R[1].court_case_number,
                              TRIM(R[1].le_agency_case_number) != '' => R[1].le_agency_case_number,
                              /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.off_date_1 := R[1].off_date;
      SELF.arr_date_1 := R[1].arr_date;
      SELF.num_of_counts_1 := R[1].num_of_counts;
      SELF.off_code_1 := R[1].arr_off_code;
      SELF.chg_1 := '';
      SELF.off_desc_1_1 := MAP( TRIM(R[1].arr_off_desc_1) != '' => R[1].arr_off_desc_1,
                                TRIM(R[1].court_off_desc_1) != '' => R[1].court_off_desc_1,
                                TRIM(R[1].court_statute_desc) != '' => R[1].court_statute_desc,
                                /* ELSE.......................... */ DISPLAY_NOTHING );
      SELF.off_desc_2_1 := MAP( TRIM(R[1].arr_off_desc_2) != '' => R[1].arr_off_desc_2,
                                TRIM(R[1].court_off_desc_2) != '' => R[1].court_off_desc_2,
                                TRIM(R[1].arr_disp_desc_1) != '' => R[1].arr_disp_desc_1,
                                /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.add_off_cd_1 := '';
      SELF.add_off_desc_1 := TRIM(R[1].arr_off_lev_mapped)
                              + IF( TRIM(R[1].arr_off_lev_mapped) != '',
                                    ';' + TRIM(R[1].court_off_lev_mapped),
                                    TRIM(R[1].court_off_lev_mapped)
                                   );
      SELF.off_typ_1 := R[1].arr_off_type_cd;
      SELF.off_lev_1 := R[1].arr_off_lev;
      SELF.court_desc_1 := R[1].court_desc;
      SELF.cty_conv_1 := '';
      SELF.stc_dt_1 := IF(TRIM(R[1].sent_date) != '', R[1].sent_date, R[1].court_disp_date );
      SELF.stc_comp_1 := '';
      SELF.stc_desc_1_1 := IF(TRIM(R[1].sent_jail) != '', 'Jail: ' + R[1].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_1 := IF(TRIM(R[1].sent_court_fine) != '', 'Court fine: ' + Currency( R[1].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_1 := IF(TRIM(R[1].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[1].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_1 := IF(TRIM(R[1].court_disp_desc_1) != '',
                              'Court disp: ' + TRIM(R[1].court_disp_desc_1)
                              + IF( TRIM(R[1].court_disp_desc_2) != '',
                                    ';' + TRIM(R[1].court_disp_desc_2),
                                    ''
                                    ),
                                DISPLAY_NOTHING );
      SELF.stc_lgth_1 := '';
      SELF.stc_lgth_desc_1 := '';
      SELF.inc_adm_dt_1 := '';
      SELF.min_term_1 := '';
      SELF.min_term_desc_1 := '';
      SELF.max_term_1 := '';
      SELF.max_term_desc_1 := '';

      /* ================= RECORD 2 ================= */

      SELF.case_num_2 := MAP( TRIM(R[2].court_case_number) != '' => R[2].court_case_number,
                              TRIM(R[2].le_agency_case_number) != '' => R[2].le_agency_case_number,
                              /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.off_date_2 := R[2].off_date;
      SELF.arr_date_2 := R[2].arr_date;
      SELF.num_of_counts_2 := R[2].num_of_counts;
      SELF.off_code_2 := R[2].arr_off_code;
      SELF.chg_2 := '';
      SELF.off_desc_1_2 := MAP( TRIM(R[2].arr_off_desc_1) != '' => R[2].arr_off_desc_1,
                                TRIM(R[2].court_off_desc_1) != '' => R[2].court_off_desc_1,
                                TRIM(R[2].court_statute_desc) != '' => R[2].court_statute_desc,
                                /* ELSE.......................... */ DISPLAY_NOTHING );
      SELF.off_desc_2_2 := MAP( TRIM(R[2].arr_off_desc_2) != '' => R[2].arr_off_desc_2,
                                TRIM(R[2].court_off_desc_2) != '' => R[2].court_off_desc_2,
                                TRIM(R[2].arr_disp_desc_1) != '' => R[2].arr_disp_desc_1,
                                /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.add_off_cd_2 := '';
      SELF.add_off_desc_2 := TRIM(R[2].arr_off_lev_mapped)
                              + IF( TRIM(R[2].arr_off_lev_mapped) != '',
                                    ';' + TRIM(R[2].court_off_lev_mapped),
                                    TRIM(R[2].court_off_lev_mapped)
                                   );
      SELF.off_typ_2 := R[2].arr_off_type_cd;
      SELF.off_lev_2 := R[2].arr_off_lev;
      SELF.court_desc_2 := R[2].court_desc;
      SELF.cty_conv_2 := '';
      SELF.stc_dt_2 := IF(TRIM(R[2].sent_date) != '', R[2].sent_date, R[2].court_disp_date );
      SELF.stc_comp_2 := '';
      SELF.stc_desc_1_2 := IF(TRIM(R[2].sent_jail) != '', 'Jail: ' + R[2].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_2 := IF(TRIM(R[2].sent_court_fine) != '', 'Court fine: ' + Currency( R[2].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_2 := IF(TRIM(R[2].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[2].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_2 := IF(TRIM(R[2].court_disp_desc_1) != '',
                              'Court disp: ' + TRIM(R[2].court_disp_desc_1)
                              + IF( TRIM(R[2].court_disp_desc_2) != '',
                                    ';' + TRIM(R[2].court_disp_desc_2),
                                    ''
                                    ),
                              DISPLAY_NOTHING );
      SELF.stc_lgth_2 := '';
      SELF.stc_lgth_desc_2 := '';
      SELF.inc_adm_dt_2 := '';
      SELF.min_term_2 := '';
      SELF.min_term_desc_2 := '';
      SELF.max_term_2 := '';
      SELF.max_term_desc_2 := '';

      /* ================= RECORD 3 ================= */

      SELF.case_num_3 := MAP( TRIM(R[3].court_case_number) != '' => R[3].court_case_number,
                              TRIM(R[3].le_agency_case_number) != '' => R[3].le_agency_case_number,
                              /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.off_date_3 := R[3].off_date;
      SELF.arr_date_3 := R[3].arr_date;
      SELF.num_of_counts_3 := R[3].num_of_counts;
      SELF.off_code_3 := R[3].arr_off_code;
      SELF.chg_3 := '';
      SELF.off_desc_1_3 := MAP( TRIM(R[3].arr_off_desc_1) != '' => R[3].arr_off_desc_1,
                                TRIM(R[3].court_off_desc_1) != '' => R[3].court_off_desc_1,
                                TRIM(R[3].court_statute_desc) != '' => R[3].court_statute_desc,
                                /* ELSE.......................... */ DISPLAY_NOTHING );
      SELF.off_desc_2_3 := MAP( TRIM(R[3].arr_off_desc_2) != '' => R[3].arr_off_desc_2,
                                TRIM(R[3].court_off_desc_2) != '' => R[3].court_off_desc_2,
                                TRIM(R[3].arr_disp_desc_1) != '' => R[3].arr_disp_desc_1,
                                /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.add_off_cd_3 := '';
      SELF.add_off_desc_3 := TRIM(R[3].arr_off_lev_mapped)
                              + IF( TRIM(R[3].arr_off_lev_mapped) != '',
                                    ';' + TRIM(R[3].court_off_lev_mapped),
                                    TRIM(R[3].court_off_lev_mapped)
                                   );
      SELF.off_typ_3 := R[3].arr_off_type_cd;
      SELF.off_lev_3 := R[3].arr_off_lev;
      SELF.court_desc_3 := R[3].court_desc;
      SELF.cty_conv_3 := '';
      SELF.stc_dt_3 := IF( TRIM(R[3].sent_date) != '', R[3].sent_date, R[3].court_disp_date );
      SELF.stc_comp_3 := '';
      SELF.stc_desc_1_3 := IF( TRIM(R[3].sent_jail) != '', 'Jail: ' + R[3].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_3 := IF( TRIM(R[3].sent_court_fine) != '', 'Court fine: ' + Currency( R[3].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_3 := IF( TRIM(R[3].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[3].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_3 := IF( TRIM(R[3].court_disp_desc_1) != '',
                                  'Court disp: ' + TRIM(R[3].court_disp_desc_1)
                                  + IF( TRIM(R[3].court_disp_desc_2) != '',
                                        ';' + TRIM(R[3].court_disp_desc_2),
                                        ''
                                        ),
                                  DISPLAY_NOTHING );
      SELF.stc_lgth_3 := '';
      SELF.stc_lgth_desc_3 := '';
      SELF.inc_adm_dt_3 := '';
      SELF.min_term_3 := '';
      SELF.min_term_desc_3 := '';
      SELF.max_term_3 := '';
      SELF.max_term_desc_3 := '';

      /* ================= RECORD 4 ================= */
      
      SELF.case_num_4 := MAP( TRIM(R[4].court_case_number) != '' => R[4].court_case_number,
                              TRIM(R[4].le_agency_case_number) != '' => R[4].le_agency_case_number,
                              /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.off_date_4 := R[4].off_date;
      SELF.arr_date_4 := R[4].arr_date;
      SELF.num_of_counts_4 := R[4].num_of_counts;
      SELF.off_code_4 := R[4].arr_off_code;
      SELF.chg_4 := '';
      SELF.off_desc_1_4 := MAP( TRIM(R[4].arr_off_desc_1) != '' => R[4].arr_off_desc_1,
                                TRIM(R[4].court_off_desc_1) != '' => R[4].court_off_desc_1,
                                TRIM(R[4].court_statute_desc) != '' => R[4].court_statute_desc,
                                /* ELSE.......................... */ DISPLAY_NOTHING );
      SELF.off_desc_2_4 := MAP( TRIM(R[4].arr_off_desc_2) != '' => R[4].arr_off_desc_2,
                                TRIM(R[4].court_off_desc_2) != '' => R[4].court_off_desc_2,
                                TRIM(R[4].arr_disp_desc_1) != '' => R[4].arr_disp_desc_1,
                                /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.add_off_cd_4 := '';
      SELF.add_off_desc_4 := TRIM(R[4].arr_off_lev_mapped)
                              + IF( TRIM(R[4].arr_off_lev_mapped) != '',
                                    ';' + TRIM(R[4].court_off_lev_mapped),
                                    TRIM(R[4].court_off_lev_mapped)
                                   );
      SELF.off_typ_4 := R[4].arr_off_type_cd;
      SELF.off_lev_4 := R[4].arr_off_lev;
      SELF.court_desc_4 := R[4].court_desc;
      SELF.cty_conv_4 := '';
      SELF.stc_dt_4 := IF( TRIM(R[4].sent_date) != '', R[4].sent_date, R[4].court_disp_date );
      SELF.stc_comp_4 := '';
      SELF.stc_desc_1_4 := IF( TRIM(R[4].sent_jail) != '', 'Jail: ' + R[4].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_4 := IF( TRIM(R[4].sent_court_fine) != '', 'Court fine: ' + Currency( R[4].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_4 := IF( TRIM(R[4].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[4].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_4 := IF( TRIM(R[4].court_disp_desc_1) != '',
                                'Court disp: ' + TRIM(R[4].court_disp_desc_1)
                                + IF( TRIM(R[4].court_disp_desc_2) != '',
                                      ';' + TRIM(R[4].court_disp_desc_2),
                                      ''
                                      ),
                                DISPLAY_NOTHING );
      SELF.stc_lgth_4 := '';
      SELF.stc_lgth_desc_4 := '';
      SELF.inc_adm_dt_4 := '';
      SELF.min_term_4 := '';
      SELF.min_term_desc_4 := '';
      SELF.max_term_4 := '';
      SELF.max_term_desc_4 := '';
      
      /* ================= RECORD 5 ================= */
      
      SELF.case_num_5 := MAP( TRIM(R[5].court_case_number) != '' => R[5].court_case_number,
                              TRIM(R[5].le_agency_case_number) != '' => R[5].le_agency_case_number,
                              /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.off_date_5 := R[5].off_date;
      SELF.arr_date_5 := R[5].arr_date;
      SELF.num_of_counts_5 := R[5].num_of_counts;
      SELF.off_code_5 := R[5].arr_off_code;
      SELF.chg_5 := '';
      SELF.off_desc_1_5 := MAP( TRIM(R[5].arr_off_desc_1) != '' => R[5].arr_off_desc_1,
                                TRIM(R[5].court_off_desc_1) != '' => R[5].court_off_desc_1,
                                TRIM(R[5].court_statute_desc) != '' => R[5].court_statute_desc,
                                /* ELSE.......................... */ DISPLAY_NOTHING );
      SELF.off_desc_2_5 := MAP( TRIM(R[5].arr_off_desc_2) != '' => R[5].arr_off_desc_2,
                                TRIM(R[5].court_off_desc_2) != '' => R[5].court_off_desc_2,
                                TRIM(R[5].arr_disp_desc_1) != '' => R[5].arr_disp_desc_1,
                                /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.add_off_cd_5 := '';
      SELF.add_off_desc_5 := TRIM(R[5].arr_off_lev_mapped)
                              + IF( TRIM(R[5].arr_off_lev_mapped) != '',
                                    ';' + TRIM(R[5].court_off_lev_mapped),
                                    TRIM(R[5].court_off_lev_mapped)
                                   );
      SELF.off_typ_5 := R[5].arr_off_type_cd;
      SELF.off_lev_5 := R[5].arr_off_lev;
      SELF.court_desc_5 := R[5].court_desc;
      SELF.cty_conv_5 := '';
      SELF.stc_dt_5 := IF( TRIM(R[5].sent_date) != '', R[5].sent_date, R[5].court_disp_date );
      SELF.stc_comp_5 := '';
      SELF.stc_desc_1_5 := IF( TRIM(R[5].sent_jail) != '', 'Jail: ' + R[5].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_5 := IF( TRIM(R[5].sent_court_fine) != '', 'Court fine: ' + Currency( R[5].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_5 := IF( TRIM(R[5].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[5].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_5 := IF( TRIM(R[5].court_disp_desc_1) != '',
                                  'Court disp: ' + TRIM(R[5].court_disp_desc_1)
                                  + IF( TRIM(R[5].court_disp_desc_2) != '',
                                        ';' + TRIM(R[5].court_disp_desc_2),
                                        ''
                                        ),
                                  DISPLAY_NOTHING );
      SELF.stc_lgth_5 := '';
      SELF.stc_lgth_desc_5 := '';
      SELF.inc_adm_dt_5 := '';
      SELF.min_term_5 := '';
      SELF.min_term_desc_5 := '';
      SELF.max_term_5 := '';
      SELF.max_term_desc_5 := '';
      
      /* ================= RECORD 6 ================= */
      
      SELF.case_num_6 := MAP( TRIM(R[6].court_case_number) != '' => R[6].court_case_number,
                              TRIM(R[6].le_agency_case_number) != '' => R[6].le_agency_case_number,
                              /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.off_date_6 := R[6].off_date;
      SELF.arr_date_6 := R[6].arr_date;
      SELF.num_of_counts_6 := R[6].num_of_counts;
      SELF.off_code_6 := R[6].arr_off_code;
      SELF.chg_6 := '';
      SELF.off_desc_1_6 := MAP( TRIM(R[6].arr_off_desc_1) != '' => R[6].arr_off_desc_1,
                                TRIM(R[6].court_off_desc_1) != '' => R[6].court_off_desc_1,
                                TRIM(R[6].court_statute_desc) != '' => R[6].court_statute_desc,
                                /* ELSE.......................... */ DISPLAY_NOTHING );
      SELF.off_desc_2_6 := MAP( TRIM(R[6].arr_off_desc_2) != '' => R[6].arr_off_desc_2,
                                TRIM(R[6].court_off_desc_2) != '' => R[6].court_off_desc_2,
                                TRIM(R[6].arr_disp_desc_1) != '' => R[6].arr_disp_desc_1,
                                /* ELSE........................ */ DISPLAY_NOTHING );
      SELF.add_off_cd_6 := '';
      SELF.add_off_desc_6 := TRIM(R[6].arr_off_lev_mapped)
                              + IF( TRIM(R[6].arr_off_lev_mapped) != '',
                                    ';' + TRIM(R[6].court_off_lev_mapped),
                                    TRIM(R[6].court_off_lev_mapped)
                                   );
      SELF.off_typ_6 := R[6].arr_off_type_cd;
      SELF.off_lev_6 := R[6].arr_off_lev;
      SELF.court_desc_6 := R[6].court_desc;
      SELF.cty_conv_6 := '';
      SELF.stc_dt_6 := IF( TRIM(R[6].sent_date) != '', R[6].sent_date, R[6].court_disp_date );
      SELF.stc_comp_6 := '';
      SELF.stc_desc_1_6 := IF( TRIM(R[6].sent_jail) != '', 'Jail: ' + R[6].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_6 := IF( TRIM(R[6].sent_court_fine) != '', 'Court fine: ' + Currency( R[6].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_6 := IF( TRIM(R[6].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[6].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_6 := IF( TRIM(R[6].court_disp_desc_1) != '',
                                  'Court disp: ' + TRIM(R[6].court_disp_desc_1)
                                  + IF( TRIM(R[6].court_disp_desc_2) != '',
                                        ';' + TRIM(R[6].court_disp_desc_2),
                                        ''
                                        ),
                                  DISPLAY_NOTHING );
      SELF.stc_lgth_6 := '';
      SELF.stc_lgth_desc_6 := '';
      SELF.inc_adm_dt_6 := '';
      SELF.min_term_6 := '';
      SELF.min_term_desc_6 := '';
      SELF.max_term_6 := '';
      SELF.max_term_desc_6 := '';
      SELF := L;
      SELF := [];
    END;
    
  court_offenses := ROLLUP(ds_court_offenses_grouped,GROUP,xfm_offenses(LEFT,ROWS(LEFT)));
  
  // OUTPUT( ds_court_offenses_grouped, NAMED('ds_court_offenses_grouped') );
  
  RETURN court_offenses;

END;
