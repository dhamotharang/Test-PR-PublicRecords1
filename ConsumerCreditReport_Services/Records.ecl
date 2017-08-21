IMPORT BatchShare;

EXPORT Records (DATASET(ConsumerCreditReport_Services.Layouts.inputRec) ds_input_recs,
								ConsumerCreditReport_Services.IParams.Params in_mod) := FUNCTION

	BatchShare.MAC_SequenceInput(ds_input_recs,ds_seq_input);
	ds_orig_input := PROJECT(ds_seq_input,TRANSFORM(ConsumerCreditReport_Services.Layouts.workRec,SELF:=LEFT,SELF:=[]));

	ds_cln_names := ConsumerCreditReport_Services.Functions.clean_Names(ds_input_recs);
	ds_validated := BatchShare.MAC_Process_Validate(ds_cln_names);
	ds_work_temp := PROJECT(ds_validated,TRANSFORM(ConsumerCreditReport_Services.Layouts.workRec,SELF:=LEFT,SELF:=[]));

	ds_with_dids := ConsumerCreditReport_Services.Functions.append_Dids(ds_work_temp,in_mod);
	ds_work_recs := ConsumerCreditReport_Services.Functions.append_PersonContext(ds_with_dids,in_mod);

	ds_ccr_Gateway := ConsumerCreditReport_Services.GetCCRGateway(ds_work_recs(error_code=0),in_mod);
	ds_ccr_UniqueId := ConsumerCreditReport_Services.Functions.append_UniqueId(ds_ccr_Gateway,in_mod);

	ds_ccr_LiensJudgments := IF(in_mod.FetchLiensJudgments,
		ConsumerCreditReport_Services.Functions.append_LiensJudgments(ds_ccr_UniqueId,in_mod),
		ds_ccr_UniqueId);

	ds_rejects := ConsumerCreditReport_Services.Functions.format_Rejects(ds_work_recs(error_code>0));
	ds_ccr_srt := SORT(ds_ccr_LiensJudgments+ds_rejects,(UNSIGNED)AccountNumber);

	RETURN ConsumerCreditReport_Services.Functions.restore_AccountNumber(ds_ccr_srt,ds_orig_input);
END;
