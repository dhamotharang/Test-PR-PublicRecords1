// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT BatchShare, FFD, paw_services, WSInput;

EXPORT BatchServiceFCRA() := MACRO

  WSInput.MAC_paw_services_BatchServiceFCRA();

  in_mod:=paw_services.IParams.getBatchParams();

  ds_batch_in:=DATASET([],paw_services.Layouts.FCRA.inputRec) : STORED('batch_in',FEW);
  ds_validate:=BatchShare.MAC_Process_Validate(ds_batch_in,TRUE,BatchShare.Constants.Valid_Min_Cri.DID_OR_Name_Address);
  ds_valid_recs:=PROJECT(ds_validate(error_code=0),paw_services.Layouts.FCRA.workRec);
  ds_error_recs:=PROJECT(ds_validate(error_code>0),paw_services.Layouts.FCRA.workRec);
  BatchShare.MAC_AppendDidVilleDID(ds_valid_recs,ds_work_recs,in_mod,in_mod.DidScoreThreshold, TRUE);

  ds_PersonContext:=FFD.FetchPersonContext(PROJECT(ds_work_recs,TRANSFORM(FFD.Layouts.DidBatch,SELF:=LEFT)),in_mod.gateways,FFD.Constants.DataGroupSet.Paw);
  ds_AlertFlags:=FFD.ConsumerFlag.getAlertIndicators(ds_PersonContext,in_mod.FCRAPurpose,in_mod.FFDOptionsMask);

  ds_orig_recs:=SORT(ds_error_recs+ds_work_recs,(UNSIGNED)acctno);
  ds_paw_recs:=paw_services.Records.GetFCRA(ds_work_recs(did>0),ds_PersonContext,ds_AlertFlags,in_mod);
  ds_paw_out:=SORT(
    PROJECT(ds_paw_recs,TRANSFORM(paw_services.Layouts.FCRA.pawBatchOutRec,
      SELF:=LEFT,
      SELF:=[]))+
    PROJECT(ds_error_recs+ds_work_recs(did=0),TRANSFORM(paw_services.Layouts.FCRA.pawBatchOutRec,
      SELF.acctno:=LEFT.acctno,
      SELF.error_code:=LEFT.error_code,
      SELF:=[])),
    (UNSIGNED)acctno);
  BatchShare.MAC_RestoreAcctno(ds_orig_recs,ds_paw_out,ds_results,TRUE,FALSE);

  // Consumer Statements Alerts
  ds_Statements:=NORMALIZE(ds_paw_recs,LEFT.StatementsAndDisputes,
    TRANSFORM (FFD.Layouts.ConsumerStatementBatch,SELF:=RIGHT));
  ds_ConsumerStatements:=FFD.prepareConsumerStatementsBatch(ds_Statements,ds_PersonContext,in_mod.FFDOptionsMask);
  ds_ConsumerAlerts:=FFD.ConsumerFlag.prepareAlertMessagesBatch(ds_PersonContext,ds_AlertFlags,in_mod.FFDOptionsMask);
  ds_ConsumerResults:=SORT(ds_ConsumerStatements+ds_ConsumerAlerts,(UNSIGNED)acctno);
  BatchShare.MAC_RestoreAcctno(ds_orig_recs,ds_ConsumerResults,ds_csdResults,FALSE,FALSE);

  // OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
  // OUTPUT(ds_validate,NAMED('ds_validate'));
  // OUTPUT(ds_work_recs,NAMED('ds_work_recs'));

  // OUTPUT(ds_paw_recs,NAMED('ds_paw_recs'));
  // OUTPUT(ds_paw_out,NAMED('ds_paw_out'));

  OUTPUT(ds_results,NAMED('Results'));
  OUTPUT(ds_csdResults,NAMED('CSDResults'));

ENDMACRO;
