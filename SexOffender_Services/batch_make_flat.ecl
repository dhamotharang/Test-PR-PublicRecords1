IMPORT FFD;
displayOffense(SexOffender_Services.Layouts.rec_offense_raw offense) :=
  TRIM( TRIM(offense.offense_code_or_statute) + ' '
        + TRIM(offense.offense_description) + ' '
        + TRIM(offense.offense_description_2 ) );

displayCourt(SexOffender_Services.Layouts.rec_offense_raw offense) :=
  TRIM( TRIM(offense.conviction_jurisdiction) + ' ' + TRIM(offense.court) );
  
EXPORT SexOffender_Services.Layouts.batch_out_pre batch_make_flat(
  SexOffender_Services.Layouts.batch_out_pre l,
  SexOffender_Services.Layouts.rec_offense_raw r,
  INTEGER C) := TRANSFORM
  
    SELF.offense_1 := IF( C=1, displayOffense( r ), l.offense_1 );
    SELF.conviction_place_1 := IF( C=1, displayCourt( r ) , l.conviction_place_1 );
    SELF.conviction_date_1 := IF( C=1, r.conviction_date , l.conviction_date_1 );
    SELF.victim_minor_1 := IF( C=1, r.victim_minor , l.victim_minor_1 );
    SELF.conviction_jurisdiction_1 := IF( C=1, r.conviction_jurisdiction , l.conviction_jurisdiction_1 );
    SELF.court_case_number_1 := IF( C=1, r.court_case_number , l.court_case_number_1 );
    SELF.offense_date_1 := IF( C=1, r.offense_date , l.offense_date_1 );
    
    SELF.offense_2 := IF( C=2, displayOffense( r ), l.offense_2 );
    SELF.conviction_place_2 := IF( C=2, displayCourt( r ) , l.conviction_place_2 );
    SELF.conviction_date_2 := IF( C=2, r.conviction_date , l.conviction_date_2 );
    SELF.victim_minor_2 := IF( C=2, r.victim_minor , l.victim_minor_2 );
    SELF.conviction_jurisdiction_2 := IF( C=2, r.conviction_jurisdiction , l.conviction_jurisdiction_2 );
    SELF.court_case_number_2 := IF( C=2, r.court_case_number , l.court_case_number_2 );
    SELF.offense_date_2 := IF( C=2, r.offense_date , l.offense_date_2 );

    SELF.offense_3 := IF( C=3, displayOffense( r ), l.offense_3 );
    SELF.conviction_place_3 := IF( C=3, displayCourt( r ) , l.conviction_place_3 );
    SELF.conviction_date_3 := IF( C=3, r.conviction_date , l.conviction_date_3 );
    SELF.victim_minor_3 := IF( C=3, r.victim_minor , l.victim_minor_3 );
    SELF.conviction_jurisdiction_3 := IF( C=3, r.conviction_jurisdiction , l.conviction_jurisdiction_3 );
    SELF.court_case_number_3 := IF( C=3, r.court_case_number , l.court_case_number_3 );
    SELF.offense_date_3 := IF( C=3, r.offense_date , l.offense_date_3 );

    SELF.offense_4 := IF( C=4, displayOffense( r ), l.offense_4 );
    SELF.conviction_place_4 := IF( C=4, displayCourt( r ) , l.conviction_place_4 );
    SELF.conviction_date_4 := IF( C=4, r.conviction_date , l.conviction_date_4 );
    SELF.victim_minor_4 := IF( C=4, r.victim_minor , l.victim_minor_4 );
    SELF.conviction_jurisdiction_4 := IF( C=4, r.conviction_jurisdiction , l.conviction_jurisdiction_4 );
    SELF.court_case_number_4 := IF( C=4, r.court_case_number , l.court_case_number_4 );
    SELF.offense_date_4 := IF( C=4, r.offense_date , l.offense_date_4 );

    SELF.offense_5 := IF( C=5, displayOffense( r ), l.offense_5 );
    SELF.conviction_place_5 := IF( C=5, displayCourt( r ) , l.conviction_place_5 );
    SELF.conviction_date_5 := IF( C=5, r.conviction_date , l.conviction_date_5 );
    SELF.victim_minor_5 := IF( C=5, r.victim_minor , l.victim_minor_5 );
    SELF.conviction_jurisdiction_5 := IF( C=5, r.conviction_jurisdiction , l.conviction_jurisdiction_5 );
    SELF.court_case_number_5 := IF( C=5, r.court_case_number , l.court_case_number_5 );
    SELF.offense_date_5 := IF( C=5, r.offense_date , l.offense_date_5 );

    SELF.offense_6 := IF( C=6, displayOffense( r ), l.offense_6 );
    SELF.conviction_place_6 := IF( C=6, displayCourt( r ) , l.conviction_place_6 );
    SELF.conviction_date_6 := IF( C=6, r.conviction_date , l.conviction_date_6 );
    SELF.victim_minor_6 := IF( C=6, r.victim_minor , l.victim_minor_6 );
    SELF.conviction_jurisdiction_6 := IF( C=6, r.conviction_jurisdiction , l.conviction_jurisdiction_6 );
    SELF.court_case_number_6 := IF( C=6, r.court_case_number , l.court_case_number_6 );
    SELF.offense_date_6 := IF( C=6, r.offense_date , l.offense_date_6 );

    SELF.offense_7 := IF( C=7, displayOffense( r ), l.offense_7 );
    SELF.conviction_place_7 := IF( C=7, displayCourt( r ) , l.conviction_place_7 );
    SELF.conviction_date_7 := IF( C=7, r.conviction_date , l.conviction_date_7 );
    SELF.victim_minor_7 := IF( C=7, r.victim_minor , l.victim_minor_7 );
    SELF.conviction_jurisdiction_7 := IF( C=7, r.conviction_jurisdiction , l.conviction_jurisdiction_7 );
    SELF.court_case_number_7 := IF( C=7, r.court_case_number , l.court_case_number_7 );
    SELF.offense_date_7 := IF( C=7, r.offense_date , l.offense_date_7 );

    SELF.offense_8 := IF( C=8, displayOffense( r ), l.offense_8 );
    SELF.conviction_place_8 := IF( C=8, displayCourt( r ) , l.conviction_place_8 );
    SELF.conviction_date_8 := IF( C=8, r.conviction_date , l.conviction_date_8 );
    SELF.victim_minor_8 := IF( C=8, r.victim_minor , l.victim_minor_8 );
    SELF.conviction_jurisdiction_8 := IF( C=8, r.conviction_jurisdiction , l.conviction_jurisdiction_8 );
    SELF.court_case_number_8 := IF( C=8, r.court_case_number , l.court_case_number_8 );
    SELF.offense_date_8 := IF( C=8, r.offense_date , l.offense_date_8 );

    SELF.offense_9 := IF( C=9, displayOffense( r ), l.offense_9 );
    SELF.conviction_place_9 := IF( C=9, displayCourt( r ) , l.conviction_place_9 );
    SELF.conviction_date_9 := IF( C=9, r.conviction_date , l.conviction_date_9 );
    SELF.victim_minor_9 := IF( C=9, r.victim_minor , l.victim_minor_9 );
    SELF.conviction_jurisdiction_9 := IF( C=9, r.conviction_jurisdiction , l.conviction_jurisdiction_9 );
    SELF.court_case_number_9 := IF( C=9, r.court_case_number , l.court_case_number_9 );
    SELF.offense_date_9 := IF( C=9, r.offense_date , l.offense_date_9 );

    SELF.offense_10 := IF( C=10, displayOffense( r ), l.offense_10 );
    SELF.conviction_place_10 := IF( C=10, displayCourt( r ) , l.conviction_place_10 );
    SELF.conviction_date_10 := IF( C=10, r.conviction_date , l.conviction_date_10 );
    SELF.victim_minor_10 := IF( C=10, r.victim_minor , l.victim_minor_10 );
    SELF.conviction_jurisdiction_10 := IF( C=10, r.conviction_jurisdiction , l.conviction_jurisdiction_10 );
    SELF.court_case_number_10 := IF( C=10, r.court_case_number , l.court_case_number_10 );
    SELF.offense_date_10 := IF( C=10, r.offense_date , l.offense_date_10 );
    //FCRA FFD
    section_id_val := 'offense_'+C;
  
    offenses_statements := PROJECT(R.StatementIds,
      FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, section_id_val, FFD.Constants.DataGroups.SO_OFFENSES, 0, L.acctno));
    offenses_dispute := IF(R.isDisputed,
      ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, section_id_val, FFD.Constants.DataGroups.SO_OFFENSES, 0, L.acctno)));
    SELF.statements := l.statements + offenses_statements + offenses_dispute;
    SELF := l;
END;
