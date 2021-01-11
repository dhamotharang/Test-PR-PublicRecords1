/* This FUNCTION gets Full File Disclosure records for BK FCRA search AND report services. */

IMPORT bankruptcyv3, FFD, BankruptcyV3_Services;

EXPORT fn_fcra_ffd(DATASET(BankruptcyV3_Services.layouts.layout_rollup) ds_recs,
                   DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                   INTEGER8 inFFDOptionsMask) := FUNCTION
                   
  BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputedBankruptcies(inFFDOptionsMask);
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

  rec_w_tms := RECORD
   STRING50 TMSID ;
   BankruptcyV3_Services.layouts.layout_party;
  END;
  
  debtors_norm := NORMALIZE(ds_recs, LEFT.debtors, TRANSFORM(rec_w_tms, SELF.tmsid := LEFT.tmsid, SELF := RIGHT));
  
  // ffd for debtor records for matched party did
  rec_w_tms xformStatements( rec_w_tms l, FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIds := r.StatementIDs;
      SELF.IsDisputed := r.isDisputed;
      SELF := l;
  END;

  recs_fcra_debtors := JOIN(debtors_norm, slim_pc_recs,
    LEFT.tmsid = RIGHT.RecID1 AND
    BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR = RIGHT.RecID2 AND // FFD compliance for debtors
    (UNSIGNED6)LEFT.did = (UNSIGNED6) RIGHT.RecId3 AND
    (RIGHT.acctno = FFD.Constants.SingleSearchAcctno) AND
    RIGHT.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_SEARCH,
      xformStatements(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(1), LIMIT(0));
                                 
  BankruptcyV3_Services.layouts.layout_rollup denorm_deb(BankruptcyV3_Services.layouts.layout_rollup l,
                                                              DATASET(rec_w_tms) r) := TRANSFORM
                                                            
    SELF.debtors := PROJECT(r, BankruptcyV3_Services.layouts.layout_party);
    SELF := l;
  END;

  denorm_ds := DENORMALIZE(ds_recs, recs_fcra_debtors,
    LEFT.tmsid = RIGHT.tmsid,
    GROUP,
    denorm_deb(LEFT,ROWS(RIGHT)));
  
  layout_w_did := RECORD
    BankruptcyV3_Services.layouts.layout_rollup;
    UNSIGNED6 matched_did;
  END;
  
  main_w_did := PROJECT(denorm_ds,
    TRANSFORM(layout_w_did,
    SELF.matched_did := (UNSIGNED6)LEFT.matched_party.did,
    SELF := LEFT));
  
  // ffd for main records for matched party did
  BankruptcyV3_Services.layouts.layout_rollup xmainStatements( layout_w_did l, FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIds := r.StatementIDs;
      SELF.IsDisputed := r.isDisputed;
      SELF := l;
    END;
      
  recs_fcra_ds := JOIN(main_w_did, slim_pc_recs,
    LEFT.court_code = RIGHT.RecID1 AND LEFT.case_number = RIGHT.RecID2 AND
    LEFT.matched_did = (UNSIGNED6) RIGHT.lexid AND
    (RIGHT.acctno = FFD.Constants.SingleSearchAcctno) AND
    RIGHT.DataGroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN,
    xmainStatements(LEFT,RIGHT),
    LEFT OUTER,
    KEEP(1),
    LIMIT(0));
                      
  RETURN recs_fcra_ds;
  
END;
