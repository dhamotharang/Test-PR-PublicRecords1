IMPORT BatchShare, FFD, ConsumerCreditReport_Services, doxie;

EXPORT Records (DATASET(ConsumerCreditReport_Services.Layouts.inputRec) ds_input_recs,
								ConsumerCreditReport_Services.IParams.Params in_mod,
								BOOLEAN isFCRA) := FUNCTION

	BatchShare.MAC_SequenceInput(ds_input_recs,ds_seq_input);
	IF(NOT isFCRA AND NOT in_mod.hasGlbPermissiblePurpose, FAIL(ConsumerCreditReport_Services.Constants.GLB_REQUIRED_MSG));
	ds_orig_input := PROJECT(ds_seq_input,TRANSFORM(ConsumerCreditReport_Services.Layouts.workRec,SELF:=LEFT,SELF:=[]));

	ds_cln_names := ConsumerCreditReport_Services.Functions.clean_Names(ds_input_recs);
	ds_validated := BatchShare.MAC_Process_Validate(ds_cln_names);
	ds_work_temp := PROJECT(ds_validated,TRANSFORM(ConsumerCreditReport_Services.Layouts.workRec,SELF:=LEFT,SELF:=[]));

	ds_with_dids := ConsumerCreditReport_Services.Functions.append_Dids(ds_work_temp,in_mod);
  
 ds_dids:=PROJECT(ds_with_dids(did!=0),TRANSFORM(FFD.Layouts.DidBatch,
                                                 SELF.acctno := FFD.Constants.SingleSearchAcctno,
																								 SELF.did:=LEFT.did));
 
 DataGroupSet:=IF(in_mod.FetchLiensJudgments,FFD.Constants.DataGroupSet.Liens,FFD.Constants.DataGroupSet.Person);
 pc_recs :=IF(isFCRA, FFD.FetchPersonContext(ds_dids,in_mod.gateways,DataGroupSet,in_mod.FFDOptionsMask),DATASET([],FFD.Layouts.PersonContextBatch));
 
	ds_work_recs := IF(isFCRA, ConsumerCreditReport_Services.Functions.append_PersonContext(ds_with_dids,in_mod, pc_recs), ds_with_dids);

	ds_ccr_Gateway := ConsumerCreditReport_Services.GetCCRGateway(ds_work_recs(error_code=0),in_mod);
	ds_ccr_UniqueId := ConsumerCreditReport_Services.Functions.append_UniqueId(ds_ccr_Gateway,in_mod);

 ds_best := PROJECT(ds_ccr_UniqueId,TRANSFORM(doxie.layout_best,SELF.did:=(UNSIGNED)LEFT.UniqueId1,SELF:=LEFT,SELF:=[]));
 ds_flags := IF(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));
 
	ds_ccr_LiensJudgments := IF(in_mod.FetchLiensJudgments AND isFCRA,
		ConsumerCreditReport_Services.Functions.append_LiensJudgments(ds_ccr_UniqueId, in_mod, ds_flags, pc_recs),
		ds_ccr_UniqueId);

	ds_rejects := ConsumerCreditReport_Services.Functions.format_Rejects(ds_work_recs(error_code>0));
	ds_ccr_srt := SORT(ds_ccr_LiensJudgments+ds_rejects,(UNSIGNED)AccountNumber);

	RETURN ConsumerCreditReport_Services.Functions.restore_AccountNumber(ds_ccr_srt,ds_orig_input);
END;
