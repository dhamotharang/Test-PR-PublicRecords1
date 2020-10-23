/* This FUNCTION applies suppression AND formats FFD data for BK FCRA batch services. */

IMPORT BatchServices, FFD, FCRA;

EXPORT fn_fcra_ffd_batch(DATASET(BatchServices.layout_BankruptcyV3_Batch_out) ds_batch,
    DATASET(FFD.Layouts.PersonContextBatch) pc_recs,
    INTEGER8 inFFDOptionsMask = 0,
    INTEGER inFCRAPurpose = FCRA.FCRAPurpose.NoValueProvided) := FUNCTION

  BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputedBankruptcies(inFFDOptionsMask);
  alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, inFFDOptionsMask);

  layout_w_ffd := RECORD
    BatchServices.layout_BankruptcyV3_Batch_out;
    // FCRA FFD - differentiated fields for batch flattened layout
    DATASET(FFD.Layouts.StatementIdRec) StatementIds_deb := DATASET([],FFD.Layouts.StatementIdRec);
    BOOLEAN isDisputed_deb := FALSE;
    FFD.Layouts.CommonRawRecordElements;
  END;

  // Get record level alerts
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);

  // ffd for debtor records
  layout_w_ffd xformStatements( BatchServices.layout_BankruptcyV3_Batch_out l, FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
    SELF.StatementIds_deb := r.StatementIDs;
    SELF.isDisputed_deb := r.isDisputed;
    SELF := l;
  END;

  recs_deb := JOIN(ds_batch, slim_pc_recs,
    LEFT.tmsid = RIGHT.RecID1 AND
    BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR = RIGHT.RecID2 AND
    ((UNSIGNED6) LEFT.debtor_did = (UNSIGNED6) RIGHT.RecId3) AND
    (LEFT.acctno = RIGHT.acctno) AND
    RIGHT.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_SEARCH,
    xformStatements(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(1), LIMIT(0));

  // ffd for main records
  layout_w_ffd xmainStatements( layout_w_ffd l, FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
      SELF.StatementIds := r.StatementIDs;
      SELF.IsDisputed := r.isDisputed;
      SELF := l;
  END;

  recs_main := JOIN(recs_deb, slim_pc_recs,
    LEFT.court_code = RIGHT.RecID1 AND LEFT.case_number = RIGHT.RecId2 AND
    ((UNSIGNED6)LEFT.inquiry_lexID = (UNSIGNED6)RIGHT.lexid) AND
    (LEFT.acctno = RIGHT.acctno) AND
    RIGHT.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN,
    xmainStatements(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(1), LIMIT(0));

  BatchServices.layout_BankruptcyV3_Batch_FCRA.out_pre formstatements(layout_w_ffd L) := TRANSFORM
      debtor_statements := PROJECT(L.StatementIds_deb,
        FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'debtor', FFD.Constants.DataGroups.BANKRUPTCY_SEARCH, 0, L.acctno));
      debtor_dispute := IF(L.isDisputed_deb,
          DATASET(ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'debtor', FFD.Constants.DataGroups.BANKRUPTCY_SEARCH, 0, L.acctno))));
      main_statements := PROJECT(L.StatementIds,
        FFD.InitializeConsumerStatementBatch(LEFT, FFD.Constants.RecordType.RS, 'main', FFD.Constants.DataGroups.BANKRUPTCY_MAIN, 0, L.acctno));
      main_dispute := IF(L.isDisputed,
        DATASET(ROW(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid, FFD.Constants.RecordType.DR, 'main', FFD.Constants.DataGroups.BANKRUPTCY_MAIN, 0, L.acctno))));
      SELF.statements := debtor_statements + debtor_dispute + main_statements + main_dispute;
      SELF := L;
  END;
  // we create statements here disregarding ShowConsumerStatements option. The decision on whether to report statements/alerts/disputes is made later when preparing final output
  recs_out := PROJECT(recs_main, formstatements(LEFT));
  // records maybe suppressed due to alerts
  ds_out := FFD.Mac.ApplyConsumerAlertsBatch(recs_out, alert_flags, Statements, BatchServices.layout_BankruptcyV3_Batch_FCRA.out_pre, inFFDOptionsMask, inquiry_lexID, alert_data_under_dispute);

  // Sequencing for FCRA FFD. Also remove legal flag alert per project requirements.
  ds_out_seq := PROJECT(ds_out, TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_FCRA.out_pre, SELF.SequenceNumber := COUNTER,
    SELF.alert_legal_flag := '',
    SELF := LEFT));

  // get statements
  consumer_statements := NORMALIZE(ds_out_seq, LEFT.Statements,
    TRANSFORM (FFD.Layouts.ConsumerStatementBatch,
                SELF.Acctno := LEFT.Acctno,
                SELF.SequenceNumber := LEFT.SequenceNumber,
                SELF := RIGHT));

  consumer_statements_prep := FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, inFFDOptionsMask);
  consumer_alerts := FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, inFFDOptionsMask);

  //LH consumer alerts are filtered out per project requirements.
  consumer_statements_alerts := consumer_alerts(recordType <> FFD.Constants.RecordType.LH) + consumer_statements_prep;
  pre_result := PROJECT(ds_out_seq, BatchServices.layout_BankruptcyV3_Batch_out); // PROJECT to non ffd layout

  FFD.MAC.PrepareResultRecordBatch(pre_result, final_results, consumer_statements_alerts, BatchServices.layout_BankruptcyV3_Batch_out); // prepare results AND statements

  RETURN final_results;

 END;
