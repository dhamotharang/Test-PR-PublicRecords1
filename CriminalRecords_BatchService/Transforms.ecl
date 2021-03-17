IMPORT BatchServices, CriminalRecords_BatchService, FFD, hygenics_crim, STD;

EXPORT Transforms := MODULE

  EXPORT CriminalRecords_BatchService.Layouts.batch_int makeOutputOffenses(
      RECORDOF(CriminalRecords_BatchService.Layouts.batch_int_offenses) L,
      DATASET(RECORDOF(CriminalRecords_BatchService.Layouts.batch_int_offenses)) R
    ) := TRANSFORM

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

    // ================= OFFENSE CATEGORY FIELDS 1-6 (up to 5 of each) ================= //
    // 06/13/2017 requested offense categories filtering enhancement
    // Use existing function to decode the offense_category(1-6) bitmap value into a string with
    // 1 or more space separated text values/words
    temp_off_cat1 := R[1].offense_category;
    temp_off_cat1_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat1);
    // Use STD.Str.SplitWords to parse the space separated text values into a set of 1 or more words.
    set_off_cat1_descs := STD.Str.SplitWords(temp_off_cat1_string, ' ');
    SELF.offense_category_1 := temp_off_cat1;
    // Then pick the parsed text values out of the set, 1 at a time
    SELF.off_cat_1_1 := set_off_cat1_descs[1];
    SELF.off_cat_2_1 := set_off_cat1_descs[2];
    SELF.off_cat_3_1 := set_off_cat1_descs[3];
    SELF.off_cat_4_1 := set_off_cat1_descs[4];
    SELF.off_cat_5_1 := set_off_cat1_descs[5];
    
    temp_off_cat2 := R[2].offense_category;
    temp_off_cat2_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat2);
    set_off_cat2_descs := STD.Str.SplitWords(temp_off_cat2_string, ' ');
    SELF.offense_category_2 := temp_off_cat2;
    SELF.off_cat_1_2 := set_off_cat2_descs[1];
    SELF.off_cat_2_2 := set_off_cat2_descs[2];
    SELF.off_cat_3_2 := set_off_cat2_descs[3];
    SELF.off_cat_4_2 := set_off_cat2_descs[4];
    SELF.off_cat_5_2 := set_off_cat2_descs[5];

    temp_off_cat3 := R[3].offense_category;
    temp_off_cat3_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat3);
    set_off_cat3_descs := STD.Str.SplitWords(temp_off_cat3_string, ' ');
    SELF.offense_category_3 := temp_off_cat3;
    SELF.off_cat_1_3 := set_off_cat3_descs[1];
    SELF.off_cat_2_3 := set_off_cat3_descs[2];
    SELF.off_cat_3_3 := set_off_cat3_descs[3];
    SELF.off_cat_4_3 := set_off_cat3_descs[4];
    SELF.off_cat_5_3 := set_off_cat3_descs[5];

    temp_off_cat4 := R[4].offense_category;
    temp_off_cat4_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat4);
    set_off_cat4_descs := STD.Str.SplitWords(temp_off_cat4_string, ' ');
    SELF.offense_category_4 := temp_off_cat4;
    SELF.off_cat_1_4 := set_off_cat4_descs[1];
    SELF.off_cat_2_4 := set_off_cat4_descs[2];
    SELF.off_cat_3_4 := set_off_cat4_descs[3];
    SELF.off_cat_4_4 := set_off_cat4_descs[4];
    SELF.off_cat_5_4 := set_off_cat4_descs[5];

    temp_off_cat5 := R[5].offense_category;
    temp_off_cat5_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat5);
    set_off_cat5_descs := STD.Str.SplitWords(temp_off_cat5_string, ' ');
    SELF.offense_category_5 := temp_off_cat5;
    SELF.off_cat_1_5 := set_off_cat5_descs[1];
    SELF.off_cat_2_5 := set_off_cat5_descs[2];
    SELF.off_cat_3_5 := set_off_cat5_descs[3];
    SELF.off_cat_4_5 := set_off_cat5_descs[4];
    SELF.off_cat_5_5 := set_off_cat5_descs[5];

    temp_off_cat6 := R[6].offense_category;
    temp_off_cat6_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat6);
    set_off_cat6_descs := STD.Str.SplitWords(temp_off_cat6_string, ' ');
    SELF.offense_category_6 := temp_off_cat6;
    SELF.off_cat_1_6 := set_off_cat6_descs[1];
    SELF.off_cat_2_6 := set_off_cat6_descs[2];
    SELF.off_cat_3_6 := set_off_cat6_descs[3];
    SELF.off_cat_4_6 := set_off_cat6_descs[4];
    SELF.off_cat_5_6 := set_off_cat6_descs[5];

    SELF := L;
      
    Offense_disputes_1 := IF(R[1].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'off_1',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[1].did)));
                                                
    Offense_statements_1 := PROJECT (R[1].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                LEFT,
                                                FFD.Constants.RecordType.RS,
                                                'off_1',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[1].did ));
                                                
    Offense_disputes_2 := IF(R[2].isDisputed, ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'off_2',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[2].did)));
                                                
    Offense_statements_2 := PROJECT (R[2].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                LEFT,
                                                FFD.Constants.RecordType.RS,
                                                'off_2',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[2].did ));
                                                
    Offense_disputes_3 := IF(R[3].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'off_3',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[3].did)));
                                                
    Offense_statements_3 := PROJECT (R[3].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                LEFT,
                                                FFD.Constants.RecordType.RS,
                                                'off_3',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[3].did ));
                                                
    Offense_disputes_4 := IF(R[4].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'off_4',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[4].did)));
                                                
    Offense_statements_4 := PROJECT (R[4].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                LEFT,
                                                FFD.Constants.RecordType.RS,
                                                'off_4',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[4].did ));
    Offense_disputes_5 := IF(R[5].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'off_5',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[5].did)));
                                                
    Offense_statements_5 := PROJECT (R[5].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                LEFT,
                                                FFD.Constants.RecordType.RS,
                                                'off_5',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[5].did ));
                                                
    Offense_disputes_6 := IF(R[6].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'off_6',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[6].did)));
                                                
    Offense_statements_6 := PROJECT (R[6].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                LEFT,
                                                FFD.Constants.RecordType.RS,
                                                'off_6',
                                                FFD.Constants.DataGroups.OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[6].did ));
                                                                                                      
                                                                                                      
                                                  
    SELF.StatementsAndDisputes := Offense_disputes_1 +
                                  Offense_disputes_2 +
                                  Offense_disputes_3 +
                                  Offense_disputes_4 +
                                  Offense_disputes_5 +
                                  Offense_disputes_6 +
                                  Offense_statements_1 +
                                  Offense_statements_2 +
                                  Offense_statements_3 +
                                  Offense_statements_4 +
                                  Offense_statements_5 +
                                  Offense_statements_6;
      SELF := [];
    END;
    
    EXPORT CriminalRecords_BatchService.Layouts.batch_int makeCourtOffenseOutput(
        RECORDOF(CriminalRecords_BatchService.Layouts.batch_int_court_offense) L,
        DATASET(RECORDOF(CriminalRecords_BatchService.Layouts.batch_int_court_offense)) R
      ) := TRANSFORM
      Currency := BatchServices.Functions.convert_cents_to_currency;
      STRING DISPLAY_NOTHING := '';
      
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
      SELF.stc_dt_1 := IF( TRIM(R[1].sent_date) != '', R[1].sent_date, R[1].court_disp_date );
      SELF.stc_comp_1 := '';
      SELF.stc_desc_1_1 := IF( TRIM(R[1].sent_jail) != '', 'Jail: ' + R[1].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_1 := IF( TRIM(R[1].sent_court_fine) != '', 'Court fine: ' + Currency( R[1].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_1 := IF( TRIM(R[1].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[1].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_1 := IF( TRIM(R[1].court_disp_desc_1) != '',
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
      SELF.stc_dt_2 := IF( TRIM(R[2].sent_date) != '', R[2].sent_date, R[2].court_disp_date );
      SELF.stc_comp_2 := '';
      SELF.stc_desc_1_2 := IF( TRIM(R[2].sent_jail) != '', 'Jail: ' + R[2].sent_jail, DISPLAY_NOTHING );
      SELF.stc_desc_2_2 := IF( TRIM(R[2].sent_court_fine) != '', 'Court fine: ' + Currency( R[2].sent_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_3_2 := IF( TRIM(R[2].sent_susp_court_fine) != '', 'Susp court fine: ' + Currency( R[2].sent_susp_court_fine ), DISPLAY_NOTHING );
      SELF.stc_desc_4_2 := IF( TRIM(R[2].court_disp_desc_1) != '',
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
      // self.did := (string)L.did;

      // ============== OFFENSE CATEGORY FIELD FROM RECORDS 1-6 (up to 5 of each) =============== //
      // 06/13/2017 requested offense categories filtering enhancement
      // Use existing function to decode the offense_category(1-6) bitmap value into a string with
      // 1 or more space separated text values/words
      temp_off_cat1 := R[1].offense_category;
      temp_off_cat1_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat1);
      // Use STD.Str.SplitWords to parse the space separated text values into a set of 1 or more words.
      set_off_cat1_descs := STD.Str.SplitWords(temp_off_cat1_string, ' ');
      SELF.offense_category_1 := temp_off_cat1;
      // Then pick the parsed text values out of the set, 1 at a time
      SELF.off_cat_1_1 := set_off_cat1_descs[1];
      SELF.off_cat_2_1 := set_off_cat1_descs[2];
      SELF.off_cat_3_1 := set_off_cat1_descs[3];
      SELF.off_cat_4_1 := set_off_cat1_descs[4];
      SELF.off_cat_5_1 := set_off_cat1_descs[5];
      
      temp_off_cat2 := R[2].offense_category;
      temp_off_cat2_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat2);
      set_off_cat2_descs := STD.Str.SplitWords(temp_off_cat2_string, ' ');
      SELF.offense_category_2 := temp_off_cat2;
      SELF.off_cat_1_2 := set_off_cat2_descs[1];
      SELF.off_cat_2_2 := set_off_cat2_descs[2];
      SELF.off_cat_3_2 := set_off_cat2_descs[3];
      SELF.off_cat_4_2 := set_off_cat2_descs[4];
      SELF.off_cat_5_2 := set_off_cat2_descs[5];
    
      temp_off_cat3 := R[3].offense_category;
      temp_off_cat3_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat3);
      set_off_cat3_descs := STD.Str.SplitWords(temp_off_cat3_string, ' ');
      SELF.offense_category_3 := temp_off_cat3;
      SELF.off_cat_1_3 := set_off_cat3_descs[1];
      SELF.off_cat_2_3 := set_off_cat3_descs[2];
      SELF.off_cat_3_3 := set_off_cat3_descs[3];
      SELF.off_cat_4_3 := set_off_cat3_descs[4];
      SELF.off_cat_5_3 := set_off_cat3_descs[5];

      temp_off_cat4 := R[4].offense_category;
      temp_off_cat4_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat4);
      set_off_cat4_descs := STD.Str.SplitWords(temp_off_cat4_string, ' ');
      SELF.offense_category_4 := temp_off_cat4;
      SELF.off_cat_1_4 := set_off_cat4_descs[1];
      SELF.off_cat_2_4 := set_off_cat4_descs[2];
      SELF.off_cat_3_4 := set_off_cat4_descs[3];
      SELF.off_cat_4_4 := set_off_cat4_descs[4];
      SELF.off_cat_5_4 := set_off_cat4_descs[5];

      temp_off_cat5 := R[5].offense_category;
      temp_off_cat5_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat5);
      set_off_cat5_descs := STD.Str.SplitWords(temp_off_cat5_string, ' ');
      SELF.offense_category_5 := temp_off_cat5;
      SELF.off_cat_1_5 := set_off_cat5_descs[1];
      SELF.off_cat_2_5 := set_off_cat5_descs[2];
      SELF.off_cat_3_5 := set_off_cat5_descs[3];
      SELF.off_cat_4_5 := set_off_cat5_descs[4];
      SELF.off_cat_5_5 := set_off_cat5_descs[5];

      temp_off_cat6 := R[6].offense_category;
      temp_off_cat6_string := hygenics_crim._functions.Get_category_from_bitmap(temp_off_cat6);
      set_off_cat6_descs := STD.Str.SplitWords(temp_off_cat6_string, ' ');
      SELF.offense_category_6 := temp_off_cat6;
      SELF.off_cat_1_6 := set_off_cat6_descs[1];
      SELF.off_cat_2_6 := set_off_cat6_descs[2];
      SELF.off_cat_3_6 := set_off_cat6_descs[3];
      SELF.off_cat_4_6 := set_off_cat6_descs[4];
      SELF.off_cat_5_6 := set_off_cat6_descs[5];

      SELF := L;
      
      Offense_disputes_1 := IF(R[1].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                FFD.Constants.BlankStatementid,
                                                FFD.Constants.RecordType.DR,
                                                'court_1',
                                                FFD.Constants.DataGroups.COURT_OFFENSES,
                                                0,L.acctno,
                                                (UNSIGNED)R[1].did)));
                                                  
      Offense_statements_1 := PROJECT (R[1].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'court_1',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[1].did ));
                                                  
      Offense_disputes_2 := IF(R[2].isDisputed, ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'court_2',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[2].did)));
                                                  
      Offense_statements_2 := PROJECT (R[2].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'court_2',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[2].did ));
                                                  
      Offense_disputes_3 := IF(R[3].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'court_3',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[3].did)));
                                                  
      Offense_statements_3 := PROJECT (R[3].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'court_3',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[3].did ));
                                                  
      Offense_disputes_4 := IF(R[4].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'court_4',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[4].did)));
                                                  
      Offense_statements_4 := PROJECT (R[4].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'court_4',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[4].did ));
      Offense_disputes_5 := IF(R[5].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'court_5',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[5].did)));
                                                  
      Offense_statements_5 := PROJECT (R[5].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'court_5',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[5].did ));
                                                  
      Offense_disputes_6 := IF(R[6].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'court_6',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[6].did)));
                                                  
      Offense_statements_6 := PROJECT (R[6].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'court_6',
                                                  FFD.Constants.DataGroups.COURT_OFFENSES,
                                                  0,L.acctno,
                                                  (UNSIGNED)R[6].did ));
                                                                                                        
                                                                                                      
                                                  
    SELF.StatementsAndDisputes := Offense_disputes_1 +
                                  Offense_disputes_2 +
                                  Offense_disputes_3 +
                                  Offense_disputes_4 +
                                  Offense_disputes_5 +
                                  Offense_disputes_6 +
                                  Offense_statements_1 +
                                  Offense_statements_2 +
                                  Offense_statements_3 +
                                  Offense_statements_4 +
                                  Offense_statements_5 +
                                  Offense_statements_6;
      SELF := [];
    END;
    
    EXPORT CriminalRecords_BatchService.Layouts.batch_int makePunishmentOutput(
        RECORDOF(CriminalRecords_BatchService.Layouts.batch_int_punishment) L,
        DATASET(RECORDOF(CriminalRecords_BatchService.Layouts.batch_int_punishment)) R) 
      := TRANSFORM
      
      P := R(punishment_type ='P');
      I :=R(punishment_type ='I');
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
      
      P_disputes_1 := IF(P[1].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'par_1',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[1].did)));
                                                  
      P_statements_1 := PROJECT (P[1].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'par_1',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[1].did ));
                                                  
      P_disputes_2 := IF(P[2].isDisputed, ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'par_2',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[2].did)));
                                                  
      P_statements_2 := PROJECT (P[2].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'par_2',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[2].did ));
                                                  
      P_disputes_3 := IF(P[3].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'par_3',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[3].did)));
                                                  
      P_statements_3 := PROJECT (P[3].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'par_3',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[3].did ));
                                                  
      P_disputes_4 := IF(P[4].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'par_4',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[4].did)));
                                                  
      P_statements_4 := PROJECT (P[4].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'par_4',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[4].did ));
      P_disputes_5 := IF(P[5].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'par_5',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[5].did)));
                                                  
      P_statements_5 := PROJECT (P[5].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'par_5',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[5].did ));
                                                  
      P_disputes_6 := IF(P[6].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'par_6',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[6].did)));
                                                  
      P_statements_6 := PROJECT (P[6].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'par_6',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)P[6].did ));
                                                                                                        
          
      I_disputes_1 := IF(I[1].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'in_1',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[1].did)));
                                                  
      I_statements_1 := PROJECT (I[1].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'in_1',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[1].did ));
                                                  
      I_disputes_2 := IF(I[2].isDisputed, ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'in_2',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[2].did)));
                                                  
      I_statements_2 := PROJECT (I[2].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'in_2',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[2].did ));
                                                  
      I_disputes_3 := IF(I[3].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'in_3',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[3].did)));
                                                  
      I_statements_3 := PROJECT (I[3].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'in_3',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[3].did ));
                                                  
      I_disputes_4 := IF(I[4].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'in_4',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[4].did)));
                                                  
      I_statements_4 := PROJECT (I[4].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'in_4',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[4].did ));
      I_disputes_5 := IF(I[5].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'in_5',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[5].did)));
                                                  
      I_statements_5 := PROJECT (I[5].StatementIds ,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'in_5',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[5].did ));
                                                  
      I_disputes_6 := IF(I[6].isDisputed ,ROW(FFD.InitializeConsumerStatementBatch(
                                                  FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'in_6',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[6].did)));
                                                  
      I_statements_6 := PROJECT (I[6].StatementIds,FFD.InitializeConsumerStatementBatch(
                                                  LEFT,
                                                  FFD.Constants.RecordType.RS,
                                                  'in_6',
                                                  FFD.Constants.DataGroups.PUNISHMENT,
                                                  0,L.acctno,
                                                  (UNSIGNED)I[6].did ));
                                                  
    SELF.StatementsAndDisputes := P_disputes_1 +
                                  P_disputes_2 +
                                  P_disputes_3 +
                                  P_disputes_4 +
                                  P_disputes_5 +
                                  P_disputes_6 +
                                  P_statements_1 +
                                  P_statements_2 +
                                  P_statements_3 +
                                  P_statements_4 +
                                  P_statements_5 +
                                  P_statements_6 +
                                  I_disputes_1 +
                                  I_disputes_2 +
                                  I_disputes_3 +
                                  I_disputes_4 +
                                  I_disputes_5 +
                                  I_disputes_6 +
                                  I_statements_1 +
                                  I_statements_2 +
                                  I_statements_3 +
                                  I_statements_4 +
                                  I_statements_5 +
                                  I_statements_6;
      
      SELF := [];
    END;
END;
