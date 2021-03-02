IMPORT Address, doxie_files, FCRA, NID, FFD, STD, CriminalRecords_BatchService;

EXPORT Raw := MODULE

  EXPORT getPIIPunishmentRecords(DATASET(CriminalRecords_BatchService.Layouts.lookup_id_pii) in_ofks,
                                 BOOLEAN isFCRA = FALSE,
                                 DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                                 DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                                 INTEGER8 inFFDOptionsMask = 0
      ) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) AND showConsumerStatements;

    ds_flags := flagfile(file_id = FCRA.FILE_ID.PUNISHMENT);
    pun_correct_rec_id := SET(ds_flags, record_id);
    punishment_key := doxie_files.Key_Punishment (isFCRA);

    recs1 := JOIN(in_ofks, punishment_key,
                  KEYED(LEFT.offender_key = RIGHT.ok)
                  AND (~isFCRA OR (STRING)RIGHT.punishment_persistent_id NOT IN pun_correct_rec_id),
                  KEEP(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK),
                  ATMOST(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK_ATMOST));

    raw_rec := RECORD(RECORDOF(recs1))
      FFD.Layouts.CommonRawRecordElements;
    END;

    recs2 := PROJECT(recs1, raw_rec);

    // overrides
    recs_over := JOIN(ds_flags, FCRA.key_override_crim.punishment,
      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
      TRANSFORM(raw_rec,
                SELF.did := (UNSIGNED)LEFT.did,
                SELF.ok := RIGHT.offender_key,
                SELF := RIGHT,
                SELF := []), // acctno, matchresult, pt , StatementIds & isDisputed
      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));

    // we only want to keep the overrides that were in the original search records
    recs_override_final := JOIN(recs_over, in_ofks,
      LEFT.offender_key = RIGHT.offender_key,
      TRANSFORM(raw_rec, SELF := LEFT), 
      KEEP(1), 
      ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); 

    recs_fcra := recs2 + recs_override_final;

    //---------------------------------------FCRA FFD----------------------------------------------------------------
    // Remove or mark Disputed punishment & add StatementIDs
    raw_rec xformPunishment ( raw_rec L , FFD.Layouts.PersonContextBatchSlim R ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
      SELF.StatementIDs := r.StatementIds;
      SELF.isDisputed := r.isDisputed;
      SELF := L;
    END;
    recs_ds := JOIN(recs_fcra, slim_pc_recs,
      LEFT.punishment_persistent_id = (UNSIGNED) RIGHT.RecID1 AND
      RIGHT.acctno = LEFT.acctno AND
      RIGHT.DataGroup = FFD.Constants.DataGroups.PUNISHMENT,
        xformPunishment(LEFT, RIGHT),
      LEFT OUTER,
      KEEP(1), LIMIT(0));
    //----------------------------------------------------------------------------------------------------------------
    recs := IF(isFCRA, recs_ds, recs2);

    RETURN recs;
  END;

  EXPORT getPIIOffenderRecords(
      DATASET(CriminalRecords_BatchService.Layouts.lookup_id_pii) in_ofks,
      BOOLEAN isFCRA = FALSE,
      DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
      DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
      INTEGER8 inFFDOptionsMask = 0
    ) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) AND showConsumerStatements;

    ds_flags_ofp := flagfile(file_id = FCRA.FILE_ID.OFFENDERS_PLUS);
    ds_flags_ofk := flagfile(file_id = FCRA.FILE_ID.OFFENDERS);
    ofp_correct_rec_id := SET(ds_flags_ofp, record_id);
    ofk_correct_rec_id := SET(ds_flags_ofk, record_id);
    //here we identify offender_key values which are suppressions - flag_file_id is blank
    //we need them to support suppression of override records for cluster which is based on offender_key
    suppressed_ofk := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS AND flag_file_id=''), record_id);
    offender_key := doxie_files.Key_Offenders_OffenderKey (isFCRA);

    // BUG #97804 - Prefered Name and SSN Logic
    CriminalRecords_BatchService.Layouts.batch_pii_int_offender makeOutputOffender(offender_key R) := TRANSFORM
      SELF.pfirst := NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W', R.fname, ' '), LEFT, RIGHT), TRUE)[1..4];
      SELF := R;
    END;
    recs1 := JOIN( in_ofks,offender_key,
                   KEYED(LEFT.offender_key=RIGHT.ofk)
                   AND (~isFCRA OR ((STRING)RIGHT.offender_persistent_id NOT IN ofp_correct_rec_id
                                    AND (STRING)RIGHT.ofk NOT IN ofk_correct_rec_id)),
                   makeOutputOffender(RIGHT),
                   ATMOST(CriminalRecords_BatchService.Constants.MAX_OFFENDER_RECS_PER_OFK)); // Need to keep this below 500 otherwise we risk Memory Limit Exceeded errors on Roxie

    //overrides (FCRA side only) - we have 2 indices for offenders overrides
    // we are making this change to now account for both
    // we check against suppressed_ofk to support suppression of overrides based on cluster
    recs_over_ofp := JOIN(ds_flags_ofp, fcra.key_override_crim.offenders_plus,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id)
                      AND RIGHT.offender_key NOT IN suppressed_ofk,
                      TRANSFORM(RIGHT), KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));

    recs_over_ofk := JOIN(ds_flags_ofk, fcra.key_override_crim.offenders,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id)
                      AND RIGHT.offender_key NOT IN suppressed_ofk,
                      TRANSFORM(RIGHT),
                      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));

    recs_over := DEDUP(recs_over_ofp+recs_over_ofk, ALL);

    // we only want to keep the overrides that were in the original search records
    recs_override_final := JOIN(recs_over, in_ofks,
                                LEFT.offender_key = RIGHT.offender_key,
                                TRANSFORM(CriminalRecords_BatchService.Layouts.batch_pii_int_offender,
                                          SELF.did := (STRING)RIGHT.did,
                                          SELF.ofk := LEFT.offender_key,
                                          SELF := LEFT,
                                          SELF := []), //acctno, pfirst
                                KEEP(1), 
                                ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); 

    recs_fcra := (recs1 + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
    //---------------------------------------FCRA FFD----------------------------------------------------------------
    // Remove or mark Disputed punishment & add StatementIDs
    CriminalRecords_BatchService.Layouts.batch_pii_int_offender xformOffender( 
      CriminalRecords_BatchService.Layouts.batch_pii_int_offender L ,
      FFD.Layouts.PersonContextBatchSlim R ) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
        SELF.StatementIDs := r.StatementIds;
        SELF.isDisputed := r.isDisputed;
        SELF := L;
    END;
    recs_ds := JOIN(recs_fcra, slim_pc_recs,
      (UNSIGNED) LEFT.did = (UNSIGNED) RIGHT.lexid AND
      ((LEFT.offender_persistent_id = (UNSIGNED) RIGHT.RecID1 AND
        RIGHT.DataGroup = FFD.Constants.DataGroups.OFFENDERS_PLUS) OR
      (RIGHT.DataGroup = FFD.Constants.DATAGROUPS.OFFENDERS AND
        LEFT.offender_key = RIGHT.RecId1)),
        xformOffender(LEFT, RIGHT),
      LEFT OUTER,
      KEEP(1),
      LIMIT(0));

    //----------------------------------------------------------------------------------------------------------------
    recs := IF(isFCRA, recs_ds, recs1);

    RETURN recs;
  END;

  EXPORT getOffenderRecords(
      DATASET(CriminalRecords_BatchService.Layouts.lookup_id) in_ofks,
      BOOLEAN isFCRA = FALSE,
      BOOLEAN isCNSMR = FALSE,
      DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
      DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
      INTEGER8 inFFDOptionsMask = 0
    ) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) AND showConsumerStatements;

    ds_flags_ofp := flagfile(file_id = FCRA.FILE_ID.OFFENDERS_PLUS);
    ds_flags_ofk := flagfile(file_id=FCRA.FILE_ID.OFFENDERS);
    ofp_correct_rec_id := SET(ds_flags_ofp, record_id);
    ofk_correct_rec_id := SET(ds_flags_ofk, record_id);
    //here we identify offender_key values which are suppressions - flag_file_id is blank
    //we need them to support suppression of override records for cluster which is based on offender_key
    suppressed_ofk := SET (flagfile (file_id=FCRA.FILE_ID.OFFENDERS AND flag_file_id=''), record_id);
    Arrest_datatype := ['5'];
    offender_key := doxie_files.Key_Offenders_OffenderKey (isFCRA);

    raw_rec := RECORD(RECORDOF(offender_key))
      CriminalRecords_BatchService.Layouts.batch_in.acctno;
      FFD.Layouts.CommonRawRecordElements;
    END;

    recs1 := JOIN(in_ofks,offender_key,
                   KEYED(LEFT.offender_key=RIGHT.ofk)
                   AND (~isFCRA OR ((STRING)RIGHT.offender_persistent_id NOT IN ofp_correct_rec_id
                                    AND (STRING)RIGHT.ofk NOT IN ofk_correct_rec_id))
                   AND (~isCNSMR OR (STRING)RIGHT.data_type NOT IN Arrest_datatype),
                   TRANSFORM(raw_rec, SELF.acctno := LEFT.acctno, SELF := RIGHT),
                   KEEP(CriminalRecords_BatchService.Constants.MAX_RECS_PER_OFK), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_PER_OFK_ATMOST));

    //overrides for offenders are in 2 files
    // we check against suppressed_ofk to support suppression of overrides based on cluster
    recs_over_ofp := JOIN(ds_flags_ofp, fcra.key_override_crim.offenders_plus,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id)
                      AND RIGHT.offender_key NOT IN suppressed_ofk,
                      TRANSFORM(RIGHT),
                      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));

    recs_over_ofk := JOIN(ds_flags_ofk, fcra.key_override_crim.offenders,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id)
                      AND RIGHT.offender_key NOT IN suppressed_ofk,
                      TRANSFORM(RIGHT),
                      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));

    recs_over := DEDUP(recs_over_ofp+recs_over_ofk, ALL);

    // we only want to keep the overrides that were in the original search records
    recs_override_final := JOIN(recs_over, in_ofks,
                                LEFT.offender_key = RIGHT.offender_key,
                                TRANSFORM(raw_rec,
                                          SELF.acctno := RIGHT.acctno,
                                          SELF.ofk := LEFT.offender_key,
                                          SELF := LEFT,
                                          SELF.StatementIDs := [],
                                          SELF.isDisputed := FALSE),
                                          // self := []),
                                KEEP(1), 
                                ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); 

    recs_fcra := (PROJECT(recs1,raw_rec) + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));

    //---------------------------------------FCRA FFD----------------------------------------------------------------
  // Remove or mark Disputed & add StatementIDs
    raw_rec xformOffendersPlus ( raw_rec L, FFD.Layouts.PersonContextBatchSlim R ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
      SELF.StatementIDs := r.StatementIds;
      SELF.isDisputed := r.isDisputed;
      SELF := L;
    END;
    recs_ds := JOIN(recs_fcra, slim_pc_recs,
                       LEFT.acctno = RIGHT.acctno AND
                       ( (RIGHT.DataGroup = FFD.Constants.DATAGROUPS.OFFENDERS_PLUS AND
                          LEFT.offender_persistent_id = (UNSIGNED) RIGHT.RecID1) OR
                         (RIGHT.DataGroup = FFD.Constants.DATAGROUPS.OFFENDERS AND
                          LEFT.offender_key = RIGHT.RecId1)
                       ),
                       xformOffendersPlus(LEFT, RIGHT),
                       LEFT OUTER,
                       KEEP(1),
                       LIMIT(0));
    //----------------------------------------------------------------------------------------------------------------
    recs2 := IF(isFCRA, recs_ds, PROJECT(recs1,raw_rec));

    recs_dup := DEDUP(SORT(recs2, acctno, did, offender_key, -ssn, -lname, -fname, -mname, -prim_range,
                           -predir, -prim_name, -addr_suffix, -postdir, -sec_range, -p_city_name, -st, -zip5),
                      acctno, did, offender_key);

    CriminalRecords_BatchService.Layouts.batch_int makeOutputOffender(CriminalRecords_BatchService.Layouts.lookup_id L, raw_rec R) := TRANSFORM
      // SELF.did := if(L.did <> 0, L.did, (unsigned)R.did); //having this line changes the results as the alias records do not have DID or ssn_appended appended, so they don't get deduped later down the code
      SELF.did := (UNSIGNED)R.did;
      SELF.output_type := 'O';
      SELF.state_origin := Address.Map_State_Name_To_Abbrev(STD.Str.ToUpperCase(R.orig_state));
      SELF.offender_key := R.ofk;
      SELF.ssn := R.ssn_appended;
      SELF.pty_typ := R.pty_typ;
      SELF := R;
      SELF := L; //get acctno, match_type, too_many_code, too_many_flag from input
      offender_statements := PROJECT(R.StatementIds,
        FFD.InitializeConsumerStatementBatch( LEFT,
                                              FFD.Constants.RecordType.RS,
                                              'offender', 
                                              FFD.Constants.DataGroups.OFFENDERS_PLUS,
                                              0,R.acctno,
                                              (UNSIGNED) R.did));

      offender_disputes := IF(R.isDisputed,
        ROW( FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid,
                                                  FFD.Constants.RecordType.DR,
                                                  'offender',FFD.Constants.DataGroups.OFFENDERS_PLUS,
                                                  0,R.acctno,(UNSIGNED) R.did)));

      SELF.StatementsAndDisputes := offender_statements + offender_disputes;
      SELF := [];
    END;
    recs := JOIN(in_ofks, recs_dup,
                 LEFT.offender_key = RIGHT.offender_key,
                 makeOutputOffender(LEFT, RIGHT));

    RETURN recs;
  END;

  EXPORT getOffenseRecords(DATASET(CriminalRecords_batchService.Layouts.lookup_id) in_ofks,
                            BOOLEAN isFCRA = FALSE,
                            DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                            DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                            INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) AND showConsumerStatements;

    ds_flags := flagfile(file_id = FCRA.FILE_ID.OFFENSES);
    ofk_correct_rec_id := SET(ds_flags, record_id);
    offenses_key := doxie_files.key_offenses (isFCRA);

    recs1 := JOIN(in_ofks,offenses_key,
                  KEYED(LEFT.offender_key = RIGHT.ok)
                  AND (~isFCRA OR (STRING)RIGHT.offense_persistent_id NOT IN ofk_correct_rec_id),
                  TRANSFORM(CriminalRecords_BatchService.Layouts.batch_int_offenses, SELF := LEFT, SELF := RIGHT),
                  KEEP(CriminalRecords_BatchService.Constants.MAX_OFFENSES_RECS_PER_OK), ATMOST(CriminalRecords_BatchService.Constants.MAX_OFFENSES_RECS_PER_OK_ATMOST));

    //overrides
    recs_over := JOIN(ds_flags, fcra.key_override_crim.offenses,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
                      TRANSFORM(RIGHT),
                      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
    recs_override_final := JOIN(recs_over, in_ofks,
                                LEFT.offender_key = RIGHT.offender_key,
                                TRANSFORM(CriminalRecords_BatchService.Layouts.batch_int_offenses,
                                          SELF := LEFT,
                                          SELF := []),
                                KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records

    recs_fcra := (recs1 + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
    //---------------------------------------FCRA FFD----------------------------------------------------------------
  // Remove or mark Disputed punishment & add StatementIDs
    CriminalRecords_BatchService.Layouts.batch_int_offenses xformOffense
    ( CriminalRecords_BatchService.Layouts.batch_int_offenses L ,
      FFD.Layouts.PersonContextBatchSlim R ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
      SELF.StatementIDs := r.StatementIds;
      SELF.isDisputed := r.isDisputed;
      SELF := L;
    END;
    recs_ds := JOIN(recs_fcra, slim_pc_recs,
                       LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecID1 AND
                       LEFT.acctno = RIGHT.acctno AND
                       RIGHT.DataGroup = FFD.Constants.DataGroups.OFFENSES,
                       xformOffense(LEFT, RIGHT),
                       LEFT OUTER,
                       KEEP(1),
                       LIMIT(0));
    //----------------------------------------------------------------------------------------------------------------
    recs := IF(isFCRA, recs_ds, recs1);

    recs_grp := GROUP(DEDUP(SORT(recs
                              ,acctno, did,offender_key,-off_date,-arr_date,case_num,
                              off_desc_1, arr_disp_desc_1,
                              process_date)
                         ,acctno, did,offender_key,off_date,arr_date,case_num,
                         off_desc_1, arr_disp_desc_1,
                         process_date)
                    ,acctno, did,offender_key);

    recs_final := ROLLUP(recs_grp,GROUP,CriminalRecords_BatchService.Transforms.makeOutputOffenses(LEFT,ROWS(LEFT)));

    RETURN recs_final;
  END;

  EXPORT getCourtOffenseRecords(DATASET(CriminalRecords_batchService.Layouts.lookup_id) in_ofks,
                                BOOLEAN isFCRA = FALSE,
                                DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                                DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                                INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) AND showConsumerStatements;

    ds_flags := flagfile(file_id = FCRA.FILE_ID.COURT_OFFENSES);
    off_correct_rec_id := SET(ds_flags, record_id);
    court_offense_key := doxie_files.Key_Court_Offenses(isFCRA);

    recs1 := JOIN(in_ofks, court_offense_key,
                  KEYED(LEFT.offender_key = RIGHT.ofk)
                  AND (~isFCRA OR (STRING)RIGHT.offense_persistent_id NOT IN off_correct_rec_id),
                  TRANSFORM(CriminalRecords_BatchService.Layouts.batch_int_court_offense, SELF := LEFT, SELF := RIGHT),
                  KEEP(CriminalRecords_BatchService.Constants.MAX_COURT_OFFENSE_RECS_PER_OK), ATMOST(CriminalRecords_BatchService.Constants.MAX_COURT_OFFENSE_RECS_PER_OK_ATMOST));

    //overrides
    recs_over := JOIN(ds_flags, FCRA.key_override_crim.court_offenses,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
                      TRANSFORM(RIGHT),
                      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
    recs_override_final := JOIN(recs_over, in_ofks,
                                LEFT.offender_key = RIGHT.offender_key,
                                TRANSFORM(CriminalRecords_BatchService.Layouts.batch_int_court_offense,
                                          SELF := LEFT,
                                          SELF := []),
                                KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records

    recs_fcra := (recs1 + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
    //---------------------------------------FCRA FFD----------------------------------------------------------------
  // Remove or mark Disputed punishment & add StatementIDs
    CriminalRecords_BatchService.Layouts.batch_int_court_offense xformOffense
    ( CriminalRecords_BatchService.Layouts.batch_int_court_offense L ,
      FFD.Layouts.PersonContextBatchSlim R
    ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
      SELF.StatementIDs := r.StatementIds;
      SELF.isDisputed := r.isDisputed;
      SELF := L;
    END;
    recs_ds := JOIN(recs_fcra, slim_pc_recs,
                LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecID1 AND
                LEFT.acctno = RIGHT.acctno AND
                RIGHT.DataGroup = FFD.Constants.DataGroups.COURT_OFFENSES,
                xformOffense(LEFT, RIGHT),
                LEFT OUTER,
                KEEP(1),
                LIMIT(0));
    //----------------------------------------------------------------------------------------------------------------
    recs := IF(isFCRA, recs_ds, recs1);

    recs_grp := GROUP(DEDUP(SORT(recs,
                                 acctno, did, offender_key, -off_date, -arr_date, court_case_number,
                                 court_off_desc_1, arr_off_desc_1,sent_jail,court_disp_desc_1,
                                 court_statute, process_date),
                           acctno, did, offender_key, off_date, arr_date, court_case_number,
                           court_off_desc_1, arr_off_desc_1,sent_jail,court_disp_desc_1,
                           court_statute, process_date),
                     acctno, //this is currently missing, but shouldn't it be here???
                     // see similar coding above in getOffensesRecords GROUP(DEDUP(SORT(...
                     // plus acctno was the first field in the dedup & sort portions???
                     did,offender_key);

    recs_final := ROLLUP(recs_grp,GROUP,CriminalRecords_BatchService.Transforms.makeCourtOffenseOutput(LEFT,ROWS(LEFT)));

    RETURN recs_final;
  END;

  EXPORT getPunishmentRecords(DATASET(CriminalRecords_batchService.Layouts.lookup_id) in_ofks,
                              BOOLEAN isFCRA = FALSE,
                              DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                              DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                              INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) AND showConsumerStatements;

    ds_flags := flagfile(file_id = FCRA.FILE_ID.PUNISHMENT);
    pun_correct_rec_id := SET(ds_flags, record_id);
    punishment_key := doxie_files.key_punishment(isFCRA);

    recs1 := JOIN(in_ofks,punishment_key,
              KEYED(LEFT.offender_key = RIGHT.ok)
              AND (~isFCRA OR (STRING)RIGHT.punishment_persistent_id NOT IN pun_correct_rec_id),
              TRANSFORM(CriminalRecords_BatchService.Layouts.batch_int_punishment, SELF := LEFT, SELF := RIGHT),
              KEEP(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK), ATMOST(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK_ATMOST));

    //overrides
    recs_over := JOIN(ds_flags, FCRA.key_override_crim.punishment,
                  KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
                  TRANSFORM(RIGHT), KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
    recs_override_final := JOIN(recs_over, in_ofks,
                            LEFT.offender_key = RIGHT.offender_key,
                            TRANSFORM(CriminalRecords_BatchService.Layouts.batch_int_punishment,
                                      SELF.acctno := RIGHT.acctno,
                                      SELF.did := RIGHT.did,
                                      SELF.ok := RIGHT.offender_key,
                                      SELF := LEFT,
                                      SELF.pt := ''),
                            KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records

    recs_fcra := (recs1 + recs_override_final); //TODO: find out what to do for punishment FCRA restrictions
    //---------------------------------------FCRA FFD----------------------------------------------------------------
  // Remove or mark Disputed punishment & add StatementIDs
    CriminalRecords_BatchService.Layouts.batch_int_punishment xformPunishment
    ( CriminalRecords_BatchService.Layouts.batch_int_punishment L ,
      FFD.Layouts.PersonContextBatchSlim R
    ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
      SELF.StatementIDs := r.StatementIds;
      SELF.isDisputed := r.isDisputed;
      SELF := L;
    END;
    recs_ds := JOIN(recs_fcra, slim_pc_recs,
                LEFT.punishment_persistent_id = (UNSIGNED) RIGHT.RecID1 AND
                LEFT.acctno = RIGHT.acctno AND
                RIGHT.DataGroup = FFD.Constants.DataGroups.PUNISHMENT,
                xformPunishment(LEFT, RIGHT),
                LEFT OUTER,
                KEEP(1),
                LIMIT(0));
    //----------------------------------------------------------------------------------------------------------------
    recs := IF(isFCRA, recs_ds, recs1);

    recs_dup := DEDUP(SORT(recs
                      ,acctno,did,offender_key,punishment_type,-event_dt,sent_length
                      ,cur_stat_inm,cur_loc_inm,cur_loc_sec,latest_adm_dt,act_rel_dt,ctl_rel_dt)
                  ,acctno,did,offender_key,punishment_type ,event_dt,sent_length
                  ,cur_stat_inm,cur_loc_inm,cur_loc_sec,latest_adm_dt,act_rel_dt,ctl_rel_dt);

    recs_grp := GROUP(SORT(recs_dup
                        ,acctno,did,offender_key,punishment_type,-event_dt,-latest_adm_dt)
                        ,acctno,did,offender_key) ;

    recs_final := ROLLUP(recs_grp,GROUP,CriminalRecords_BatchService.Transforms.makePunishmentOutput(LEFT,ROWS(LEFT)));

    RETURN recs_final;
  END;
END;
