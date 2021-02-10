IMPORT Autokey_batch, Address, doxie, FFD;

Layout_PII_In := CriminalRecords_BatchService.Layouts.batch_pii_in;
Layout_PII_Out := CriminalRecords_BatchService.Layouts.batch_pii_out;


EXPORT Possible_Incarceration_Indicator_Batch_Service_Records(CriminalRecords_BatchService.IParam.batch_params configData,
                                                              dataset(Layout_PII_In) ds_batch_in,
                                                              boolean isFCRA = false) := FUNCTION

  //perform address cleaning here since the full address field might come from stAddr (old field used)
  Autokey_batch.Layouts.rec_inBatchMaster xformCommonBatchLayout(Layout_PII_In L) := transform
    addr1 := if(L.addr <> '', L.addr, L.stAddr);
    city_in :=  if(L.p_city_name <> '', L.p_city_name, L.city);
    state_in := if(L.st <> '', L. st, IF(LENGTH(TRIM(L.state, LEFT, RIGHT)) > 2, Address.Map_State_Name_To_Abbrev(L.state), L.state));
    zip_in := TRIM(L.zip, LEFT, RIGHT);
    z5 := if(L.z5 <> '', L.z5, REGEXFIND(Constants.ZIP_PATTERN, zip_in, 1));
    z4 := if(L.zip4 <> '', L.zip4, REGEXFIND(Constants.ZIP_PATTERN, zip_in, 3));
    addr2 := city_in + ', ' + state_in + ' ' + zip_in;
    tmp := Address.GetCleanAddress(addr1, addr2, Address.Components.Country.US).results;
    SELF.prim_range := tmp.prim_range;
    SELF.predir := tmp.predir;
    SELF.prim_name := tmp.prim_name;
    SELF.addr_suffix := tmp.suffix;
    SELF.postdir := tmp.postdir;
    SELF.unit_desig := tmp.unit_desig;
    SELF.sec_range := tmp.sec_range;
    SELF.p_city_name := city_in;
    SELF.st := state_in;
    SELF.z5 := z5;
    SELF.zip4 := z4;
    SELF.ssn := REGEXREPLACE(Constants.NOT_NUMBER, L.ssn, Constants.BLNK);
    SELF.dob := (STRING8) IF((unsigned)L.dob > 0, INTFORMAT((unsigned)L.dob, 8, 1), Constants.BLNK);
    SELF := L;
  end;

  ds_batch_in_common 	:= project(ds_batch_in, xformCommonBatchLayout(left));

  // overrides for FCRA
  ds_best  := project(ds_batch_in(did <> 0),transform(doxie.layout_best,self.did:=left.did, self:=[])); //using input to create dataset for getting the flag file (overrides). For FCRA we only use DID to get overrides.

  //FCRA FFD
  dids := project(ds_batch_in(did <> 0),FFD.Layouts.DidBatch);
  data_groups := FFD.Constants.DataGroupSet.Criminal_Incarceration;
  pc_recs := if(isFCRA, FFD.FetchPersonContext(dids, configData.gateways, data_groups, configData.FFDOptionsMask));
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);

  ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs)); //this is for more than one person

  alert_flags := if(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, configData.FCRAPurpose, configData.FFDOptionsMask));

  rslt_temp := CriminalRecords_BatchService.get_incarceration_records(ds_batch_in_common, configData, ds_flags, slim_pc_recs, isFCRA);
  //FFD
  ds_flat_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(rslt_temp, alert_flags, StatementsAndDisputes, CriminalRecords_BatchService.Layouts.batch_pii_out_pre, configData.FFDOptionsMask);

  // add resolved LexId to the results for inquiry history logging support
  ds_flat_with_inquiry := FFD.Mac.InquiryLexidBatch(ds_batch_in, ds_flat_with_alerts, CriminalRecords_BatchService.Layouts.batch_pii_out_pre, 0);

  rslt := if(isFCRA, ds_flat_with_inquiry, rslt_temp);

  sequenced_out := PROJECT(rslt, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_pii_out_pre, SELF.SequenceNumber := COUNTER, SELF := LEFT));
  out := project(sequenced_out,CriminalRecords_BatchService.Layouts.batch_pii_out);

  consumer_statements := NORMALIZE(sequenced_out, LEFT.StatementsAndDisputes,
    TRANSFORM(FFD.Layouts.ConsumerStatementBatch,
      SELF.Acctno := left.Acctno,
      SELF.SequenceNumber := left.SequenceNumber,
      SELF := RIGHT));

  consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, configData.FFDOptionsMask));
  consumer_alerts  := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, configData.FFDOptionsMask));
  consumer_statements_alerts := consumer_statements_prep + consumer_alerts;

  FFD.MAC.PrepareResultRecordBatch(out, record_out, consumer_statements_alerts, CriminalRecords_BatchService.Layouts.batch_pii_out);

  return record_out;

END;
