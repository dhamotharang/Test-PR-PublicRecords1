/* This FUNCTION does the disputes AND adds the ststementIDs DATASET */
IMPORT FFD, LiensV2_Services;

EXPORT fn_doFcraCompliance ( 
  GROUPED DATASET (LiensV2_Services.layout_lien_party_raw) ds_party_raw_grouped, //JOIN with key_party_id
  DATASET (LiensV2_Services.layout_liens_case_extended) ds_case_raw,
  DATASET (LiensV2_Services.layout_liens_history_extended) ds_history_raw,
  DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
  INTEGER8 inFFDOptionsMask = 0 ) := FUNCTION

  BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
  BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
                         
  //---------------------------------------------------------------------------------------------------
  // party
  ds_party_raw := UNGROUP(ds_party_raw_grouped);
  // Remove or mark Disputed party & add StatementIDs
  
  liensv2_services.layout_lien_party_raw xformLienParty
                          (LiensV2_Services.layout_lien_party_raw L , FFD.Layouts.PersonContextBatchSlim R ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND R.isDisputed) OR (~ShowConsumerStatements AND EXISTS(R.StatementIDs)))
    SELF.StatementIDs := R.StatementIds;
    SELF.IsDisputed := R.isDisputed;
    SELF := L;
  END;
  
  ds_party_raw_ffd := JOIN(ds_party_raw,ds_slim_pc,
    ((LEFT.acctno = RIGHT.acctno) OR (RIGHT.acctno = FFD.Constants.SingleSearchAcctno)) AND // IF the person context's acctno is FFD.Constants.SingleSearchAcctno,it's a nonbatch.
    (STRING) LEFT.persistent_record_id = RIGHT.RecID1 AND
    RIGHT.DataGroup = FFD.Constants.DataGroups.LIEN_PARTY,
    xformLienParty(LEFT, RIGHT), LEFT OUTER, LIMIT(0),
    KEEP(1));

  //---------------------------------------------------------------------------------------------------
  // case
  LiensV2_Services.layout_liens_case_extended xformLiencase
    (LiensV2_Services.layout_liens_case_extended L, FFD.Layouts.PersonContextBatchSlim R ) := TRANSFORM,
      SKIP((~ShowDisputedRecords AND R.isDisputed) OR (~ShowConsumerStatements AND EXISTS(R.StatementIDs)))
        SELF.StatementIDs := R.StatementIds;
        SELF.IsDisputed := R.isDisputed;
        SELF := L;
  END;
  
  ds_case_raw_ffd := JOIN(ds_case_raw,ds_slim_pc,
    ((LEFT.acctno = RIGHT.acctno) OR (RIGHT.acctno = FFD.Constants.SingleSearchAcctno)) AND // IF the person context's acctno is FFD.Constants.SingleSearchAcctno,it's a nonbatch.
  (STRING) LEFT.persistent_record_id = RIGHT.RecID1 AND
  RIGHT.DataGroup = FFD.Constants.DataGroups.LIEN_MAIN,
  xformLienCase(LEFT, RIGHT), LEFT OUTER, LIMIT(0),
  KEEP(1));

  //---------------------------------------------------------------------------------------------------
  // history

  // mark the original records so we can correctly unflatten them later
  layout_marked := RECORD
    RECORDOF(ds_history_raw);
    UNSIGNED _mark_id;
  END;

  ds_history_marked := PROJECT(ds_history_raw, TRANSFORM(layout_marked,
    SELF._mark_id := COUNTER,
    SELF := LEFT));

  // flatten it out ...
  flat_history_rec := RECORD(LiensV2_Services.layout_lien_history_w_bcb)
   LiensV2_Services.layout_liens_history_extended.acctno;
   UNSIGNED _mark_id;
  END;

  ds_history_raw_flat := NORMALIZE(ds_history_marked, LEFT.filings,
    TRANSFORM(flat_history_rec,
              SELF.acctno := LEFT.acctno,
              SELF._mark_id := LEFT._mark_id,
              SELF := RIGHT));
         
  flat_history_rec xformLienHistory(flat_history_rec L, FFD.Layouts.PersonContextBatchSlim R) := TRANSFORM,
  SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(R.StatementIDs)))
    SELF.StatementIDs := R.StatementIds;
    SELF.IsDisputed := R.isDisputed;
    SELF := L;
  END;
    
  ds_history_raw_ffd_flat := JOIN(ds_history_raw_flat, ds_slim_pc,
    ((LEFT.acctno = RIGHT.acctno) OR (RIGHT.acctno = FFD.Constants.SingleSearchAcctno)) AND // IF the person context's acctno is FFD.Constants.SingleSearchAcctno,it's a nonbatch.
    (STRING) LEFT.persistent_record_id = RIGHT.RecID1 AND
    RIGHT.DataGroup = FFD.Constants.DataGroups.LIEN_MAIN,
    xformLienHistory(LEFT, RIGHT), LEFT OUTER, LIMIT(0),
    KEEP(1));
                           
  // unflatten the recs back to how they were before
  layout_marked deNormHistory (ds_history_marked l, ds_history_raw_ffd_flat r ) := TRANSFORM
    filings := DATASET([{ r.filing_number, r.filing_type_desc, r.orig_filing_date, r.filing_date, r.filing_time,
                          r.filing_book, r.filing_page, r.agency,r.agency_state, r.agency_city, r.agency_county,
                          r.persistent_record_id, r.StatementIds, r.isDisputed, r.bcbflag, r.case_link_priority
                      }], LiensV2_Services.layout_lien_history_w_bcb);
    SELF.filings := l.filings + filings;
    SELF := l;
  END;
      
  // clear out original filings and replace with new, marked up versions
  ds_history_temp := PROJECT(ds_history_marked, TRANSFORM(layout_marked,
    SELF.filings := DATASET([], LiensV2_Services.layout_lien_history_w_bcb),
    SELF := LEFT));
  ds_history_denorm := DENORMALIZE(ds_history_temp, ds_history_raw_ffd_flat, LEFT._mark_id = RIGHT._mark_id,
    deNormHistory(LEFT,RIGHT) );
  ds_history_raw_ffd := PROJECT(ds_history_denorm, LiensV2_Services.layout_liens_history_extended);
  
  tempRec := RECORD
  DATASET(liensv2_services.layout_lien_party_raw) _party;
  DATASET(LiensV2_Services.layout_liens_case_extended) _case;
  DATASET(LiensV2_Services.layout_liens_history_extended) _history;
  END;

  // output(ds_slim_pc,named('ds_slim_pc'),EXTEND);
  // output(ds_party_raw_ffd,named('ds_party_raw_ffd'),EXTEND);
  // output(ds_case_raw_ffd,named('ds_case_raw_ffd'),EXTEND);
  // output(ds_history_raw_flat,named('ds_history_raw_flat'));
  // output(ds_history_raw_ffd_flat,named('ds_history_raw_ffd_flat'));

  //output(ds_history_raw,named('ds_history_raw'),EXTEND);
  //output(ds_history_raw_ffd,named('ds_history_raw_ffd'),EXTEND);
  //output(ShowDisputedRecords);
  
  RETURN DATASET([{ds_party_raw_ffd,ds_case_raw_ffd,ds_history_raw_ffd}],tempRec);
END;
