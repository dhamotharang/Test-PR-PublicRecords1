IMPORT Autokey_batch, doxie, CriminalRecords_BatchService, FFD, Suppress;

EXPORT BatchRecords (CriminalRecords_BatchService.IParam.batch_params configData,
                     DATASET(CriminalRecords_BatchService.Layouts.batch_in) ds_batch_in,
                     BOOLEAN isFCRA = FALSE,
                     DATASET (FFD.Layouts.PersonContextBatch) in_pc_recs = DATASET ([],FFD.Layouts.PersonContextBatch),
                     BOOLEAN SkipPersonContextCall = FALSE) := FUNCTION
  
  ds_batch_in_common := PROJECT(ds_batch_in, Autokey_batch.Layouts.rec_inBatchMaster);
  BOOLEAN is_cnsmr := configData.isConsumer();

  UNSIGNED8 bitmap_all_includes := CriminalRecords_BatchService.Functions.Bitmap_all_includes(configData);
  
  // flagfiles for FCRA
  ds_best := PROJECT(ds_batch_in(did > 0),TRANSFORM(doxie.layout_best,SELF.did:=LEFT.did, SELF:=[])); //using input to create DATASET for getting the flag file (overrides). For FCRA we only use DID to get overrides.
  
  // FCRA FFD
  BOOLEAN do_skipPersonContextCall := ~isFCRA OR SkipPersonContextCall;
  
  dids := PROJECT(ds_batch_in(did > 0),FFD.Layouts.DidBatch);
        
  pc_recs := IF(do_skipPersonContextCall, in_pc_recs(datagroup IN FFD.Constants.DataGroupSet.Criminal),
              FFD.FetchPersonContext(dids, configData.gateways, FFD.Constants.DataGroupSet.Criminal, configData.FFDOptionsMask));
  
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  
  ds_flags := IF(isFCRA, FFD.GetFlagFile (ds_best, pc_recs)); //this is for more than one person
  
  alert_flags := IF(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, configData.FCRAPurpose, configData.FFDOptionsMask));

  
// 1. Search via AutoKey
  fromAK := CriminalRecords_BatchService.BatchIds.Ids.AutokeyIds(ds_batch_in_common);
    
  // 2. Search via DID and DID Lookup
  notFoundAccts := JOIN(ds_batch_in_common, fromAK(too_many_code = '0'), LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
  fromDID := CriminalRecords_BatchService.BatchIds.Ids.IdsByDID(IF(isFCRA, ds_batch_in_common, notFoundAccts), isFCRA, ds_flags);
  
  // 3. Search via DocNum
  fromDocNum := CriminalRecords_BatchService.BatchIds.Ids.IdsByDocNum(ds_batch_in);
  
  acctNos := IF(isFCRA, fromDID,  
    fromAK (too_many_code = '0') + fromDID + fromDocNum (too_many_code = '0'));

  acctNos_final := DEDUP(SORT(acctNos, acctno,did, offender_key), acctno, did, offender_key);
  
  /* =================== GET CRIMINAL RECORDS ==================== */
  offender := CriminalRecords_BatchService.Raw.getOffenderRecords(acctNos_final, isFCRA, is_cnsmr, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
  offender_ids := DEDUP(SORT(PROJECT(offender, TRANSFORM(CriminalRecords_BatchService.Layouts.lookup_id, SELF := LEFT)), acctno, did, offender_key), acctno, did, offender_key);
  offenses := CriminalRecords_BatchService.Raw.getOffenseRecords(offender_ids, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
  court_offenses := CriminalRecords_BatchService.Raw.getCourtOffenseRecords(offender_ids, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
  punishments := CriminalRecords_BatchService.Raw.getPunishmentRecords(offender_ids, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
  //combine offender, offenses, court_offenses and punishments
  crim_recs_t := offender + offenses + court_offenses + punishments;

  //Add SequenceNumber
  CriminalRecords_BatchService.Layouts.batch_int sequenceIt(
    CriminalRecords_BatchService.Layouts.batch_int L , 
    INTEGER C) := TRANSFORM
      SELF.SequenceNumber := C;
      SELF.StatementsAndDisputes := 
        PROJECT(L.StatementsAndDisputes,
          TRANSFORM(FFD.Layouts.ConsumerStatementBatch,
          SELF.SequenceNumber := C; SELF := LEFT));
      SELF := L;
  END;
              
  sequenced_int := PROJECT(crim_recs_t,sequenceIt(LEFT,COUNTER));
  
  // rollup into final layout
  CriminalRecords_BatchService.Layouts.batch_out_pre xformOutput(
    CriminalRecords_BatchService.Layouts.batch_int L, 
    DATASET(CriminalRecords_BatchService.Layouts.batch_int) R) := TRANSFORM
      off_recs := R(output_type = 'F');
      p_recs := R(output_type = 'P');
      F := PROJECT(off_recs,CriminalRecords_BatchService.Layouts.offenses);
      P := PROJECT(p_recs,CriminalRecords_BatchService.Layouts.Punishment);
      
      SELF.StatementsAndDisputes := off_recs[1].StatementsAndDisputes
        + p_recs[1].StatementsAndDisputes
        + L.StatementsAndDisputes;
      SELF.sDID := (STRING) L.did;
      SELF := F[1];
      SELF := P[1];
      SELF := L;
  END;
  
  crim_grp := GROUP(SORT(sequenced_int,acctno,did,offender_key),acctno,did,offender_key);
  crim_roll := ROLLUP(crim_grp,GROUP,xformOutput(LEFT,ROWS(LEFT)));
  crim_nr := DEDUP(SORT((fromAK + fromDocNum) (too_many_code <> '0'), RECORD), RECORD);
  crim_recs := crim_roll +
    IF(~isFCRA, PROJECT(crim_nr, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_out_pre, SELF := LEFT, SELF := [])));
               
  // ssn prunning
  doxie.MAC_PruneOldSSNs(crim_recs, out_pruned, ssn, did, isFCRA);
  Suppress.MAC_Suppress(out_pruned,pruned_did,configData.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);
  Suppress.MAC_Suppress(pruned_did,results_np,configData.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);
  
  // Start of 06/13/2017 offense categories filtering enhancement?

  // If any individual offense categories were requested, filter output to only include the records
  // that contain any of the requested offense categories.
  results_out_fltr := IF(NOT configdata.IncludeAtLeast1Offense,
    // if no individual offense category was requested, return all records
    results_np,
    // else do a bitwise "AND" of all the requested Include***s bitmap against
    // each of the 6 occurrences of offense_category_* (bitmap) on each record.
    // If any resulting values are not = to zero, that rec will be returned.
    results_np( bitmap_all_includes & offense_category_1 != 0 OR
                bitmap_all_includes & offense_category_2 != 0 OR
                bitmap_all_includes & offense_category_3 != 0 OR
                bitmap_all_includes & offense_category_4 != 0 OR
                bitmap_all_includes & offense_category_5 != 0 OR
                bitmap_all_includes & offense_category_6 != 0));
  // end of 06/13/2017 offense categories enhancement
  
  results_all := UNGROUP(TOPN(GROUP(SORT(results_out_fltr, acctno, pty_typ), acctno), configData.MaxResults, acctno, -process_date));

  // FFD - records maybe suppressed due to alerts
  ds_flat_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(results_all, alert_flags, StatementsAndDisputes, CriminalRecords_BatchService.Layouts.batch_out_pre, configData.FFDOptionsMask);
  
  // add resolved LexId to the results for inquiry history logging support
  ds_flat_with_inquiry := FFD.Mac.InquiryLexidBatch(ds_batch_in, ds_flat_with_alerts, CriminalRecords_BatchService.Layouts.batch_out_pre, 0);

  results_out_raw := IF(isFCRA, ds_flat_with_inquiry, results_all);
  
  consumer_statements := NORMALIZE(results_out_raw, LEFT.StatementsAndDisputes,
    TRANSFORM (FFD.Layouts.ConsumerStatementBatch,
      SELF.Acctno := LEFT.Acctno,
      SELF.SequenceNumber := LEFT.SequenceNumber,
      SELF := RIGHT));

  // append the actual contents of each consumer statement
  consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, configData.FFDOptionsMask));
  consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, configData.FFDOptionsMask));
  consumer_statements_alerts := consumer_statements_prep + consumer_alerts;
  
  results_out := PROJECT(results_out_raw, CriminalRecords_BatchService.Layouts.batch_out);
  
  // store both records and statements under a single record structure
  FFD.MAC.PrepareResultRecordBatch(results_out, record_out, consumer_statements_alerts, CriminalRecords_BatchService.Layouts.batch_out);

  // Uncomment as needed for debugging
  //OUTPUT(configdata.IncludeArson, named('IncArson'));
  //OUTPUT(configdata.IncludeAssaultAgg, named('IncAssAgg'));
  //OUTPUT(configdata.IncludeAssaultOther, named('IncAssOth'));
  //OUTPUT(configdata.IncludeDrug, named('IncDrug'));
  //OUTPUT(configdata.IncludeHomicide, named('IncHom'));
  //OUTPUT(configdata.IncludeTraffic, named('IncTraf'));
  //OUTPUT(configdata.IncludeAtLeast1Offense, named('br_IncAL1Off'));
  //OUTPUT(bitmap_all_includes, named('br_bitmap_all_incs'));
  //OUTPUT(results_out_raw, named('br_results_out_raw'));
  //OUTPUT(results_out, named('br_results_out'));

  RETURN record_out;
  
END;
