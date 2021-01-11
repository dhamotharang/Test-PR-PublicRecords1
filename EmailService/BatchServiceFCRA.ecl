/*--SOAP--
<message name="BatchServiceFCRA">
	<part name="ApplicationType"         type="xsd:string"/>
	<part name="FCRAPurpose"             type="xsd:integer"/>
	<part name="IndustryClass"           type="xsd:string"/>
	<part name="FFDOptionsMask"          type="xsd:string"/>
	<part name="DidScoreThreshold"       type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct"    type="xsd:unsignedInt"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="Gateways"                type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="batch_in"                type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchShare, EmailService, FFD, WSInput;

EXPORT BatchServiceFCRA() := MACRO

	WSInput.MAC_EmailService_BatchServiceFCRA();

	in_mod:=EmailService.IParams.getBatchParams();

	ds_batch_in:=DATASET([],EmailService.Layouts.FCRA.inputRec) : STORED('batch_in',FEW);
	ds_validate:=BatchShare.MAC_Process_Validate(ds_batch_in,TRUE,BatchShare.Constants.Valid_Min_Cri.DID_OR_Name_Address);
	ds_valid_recs:=PROJECT(ds_validate(error_code=0),EmailService.Layouts.FCRA.workRec);
	ds_error_recs:=PROJECT(ds_validate(error_code>0),EmailService.Layouts.FCRA.workRec);
	BatchShare.MAC_AppendDidVilleDID(ds_valid_recs,ds_work_recs,in_mod,in_mod.DidScoreThreshold, true);

	ds_PersonContext:=FFD.FetchPersonContext(PROJECT(ds_work_recs,TRANSFORM(FFD.Layouts.DidBatch,SELF:=LEFT)),in_mod.gateways,FFD.Constants.DataGroupSet.EmailData);
	ds_AlertFlags:=FFD.ConsumerFlag.getAlertIndicators(ds_PersonContext,in_mod.FCRAPurpose,in_mod.FFDOptionsMask);

	ds_orig_recs:=SORT(ds_error_recs+ds_work_recs,(UNSIGNED)acctno);
	ds_email_recs:=EmailService.Records.GetFCRA(ds_work_recs(did>0),ds_PersonContext,ds_AlertFlags,in_mod);
	ds_email_out:=SORT(
		PROJECT(ds_email_recs,TRANSFORM(EmailService.Layouts.FCRA.emailBatchOutRec,
			SELF:=LEFT,
			SELF:=[]))+
		PROJECT(ds_error_recs+ds_work_recs(did=0),TRANSFORM(EmailService.Layouts.FCRA.emailBatchOutRec,
			SELF.acctno:=LEFT.acctno,
			SELF.error_code:=LEFT.error_code,
			SELF:=[])),
		(UNSIGNED)acctno);
	BatchShare.MAC_RestoreAcctno(ds_orig_recs,ds_email_out,ds_results,TRUE,FALSE);

	// Consumer Statements Alerts
	ds_Statements:=NORMALIZE(ds_email_recs,LEFT.StatementsAndDisputes,
		TRANSFORM (FFD.Layouts.ConsumerStatementBatch,SELF:=RIGHT));
	ds_ConsumerStatements:=FFD.prepareConsumerStatementsBatch(ds_Statements,ds_PersonContext,in_mod.FFDOptionsMask);
	ds_ConsumerAlerts:=FFD.ConsumerFlag.prepareAlertMessagesBatch(ds_PersonContext,ds_AlertFlags,in_mod.FFDOptionsMask);
	ds_ConsumerResults:=SORT(ds_ConsumerStatements+ds_ConsumerAlerts,(UNSIGNED)acctno);
	BatchShare.MAC_RestoreAcctno(ds_orig_recs,ds_ConsumerResults,ds_csdResults,FALSE,FALSE);

	// Royalties
	ds_royalties:=Royalty.RoyaltyEmail.GetBatchRoyaltySet(ds_email_out,email_src,in_mod.MaxResultsPerAcct,in_mod.ReturnDetailedRoyalties,TRUE);
	Royalty.MAC_RestoreAcctno(ds_orig_recs,ds_royalties,ds_royaltySet);

	// OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
	// OUTPUT(ds_validate,NAMED('ds_validate'));
	// OUTPUT(ds_work_recs,NAMED('ds_work_recs'));

	// OUTPUT(ds_email_recs,NAMED('ds_email_recs'));
	// OUTPUT(ds_email_out,NAMED('ds_email_out'));

	OUTPUT(ds_results,NAMED('Results'));
	OUTPUT(ds_royaltySet,NAMED('RoyaltySet'));
	OUTPUT(ds_csdResults,NAMED('CSDResults'));

ENDMACRO;
