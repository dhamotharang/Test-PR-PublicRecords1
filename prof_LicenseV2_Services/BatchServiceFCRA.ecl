/*--SOAP--
<message name="BatchServiceFCRA">
	<part name="ApplicationType"      type="xsd:string"/>
	<part name="FCRAPurpose"          type="xsd:integer"/>
	<part name="IndustryClass"        type="xsd:string"/>
	<part name="DOBMask"              type="xsd:string"/>
	<part name="FFDOptionsMask"       type="xsd:string"/>
	<part name="DidScoreThreshold"    type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>
	<part name="Gateways"             type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchShare, FFD, prof_LicenseV2_Services, WSInput;

EXPORT BatchServiceFCRA() := MACRO

	WSInput.MAC_profLic_services_BatchServiceFCRA();

	in_mod:=prof_LicenseV2_Services.IParams.getBatchParams();

	ds_batch_in:=DATASET([],prof_LicenseV2_Services.Layouts.FCRA.inputRec) : STORED('batch_in',FEW);
	ds_validate:=BatchShare.MAC_Process_Validate(ds_batch_in,TRUE,BatchShare.Constants.Valid_Min_Cri.DID_OR_Name_Address);
	ds_valid_recs:=PROJECT(ds_validate(error_code=0),prof_LicenseV2_Services.Layouts.FCRA.workRec);
	ds_error_recs:=PROJECT(ds_validate(error_code>0),prof_LicenseV2_Services.Layouts.FCRA.workRec);
	BatchShare.MAC_AppendDidVilleDID(ds_valid_recs,ds_work_recs,in_mod,in_mod.DidScoreThreshold, true);

	ds_PersonContext:=FFD.FetchPersonContext(PROJECT(ds_work_recs,TRANSFORM(FFD.Layouts.DidBatch,SELF:=LEFT)),in_mod.gateways,FFD.Constants.DataGroupSet.ProfLicenses);
	ds_AlertFlags:=FFD.ConsumerFlag.getAlertIndicators(ds_PersonContext,in_mod.FCRAPurpose,in_mod.FFDOptionsMask);

	ds_orig_recs:=SORT(ds_error_recs+ds_work_recs,(UNSIGNED)acctno);
	ds_proflic_recs:=prof_LicenseV2_Services.Records.GetFCRA(ds_work_recs(did>0),ds_PersonContext,ds_AlertFlags,in_mod);
	ds_proflic_out:=SORT(
		PROJECT(ds_proflic_recs,TRANSFORM(prof_LicenseV2_Services.Layouts.FCRA.proflicBatchOutRec,
			SELF:=LEFT,
			SELF:=[]))+
		PROJECT(ds_error_recs+ds_work_recs(did=0),TRANSFORM(prof_LicenseV2_Services.Layouts.FCRA.proflicBatchOutRec,
			SELF.acctno:=LEFT.acctno,
			SELF.error_code:=LEFT.error_code,
			SELF:=[])),
		(UNSIGNED)acctno);
	BatchShare.MAC_RestoreAcctno(ds_orig_recs,ds_proflic_out,ds_results,TRUE,FALSE);

	// Consumer Statements Alerts
	ds_Statements:=NORMALIZE(ds_proflic_recs,LEFT.StatementsAndDisputes,
		TRANSFORM (FFD.Layouts.ConsumerStatementBatch,SELF:=RIGHT));
	ds_ConsumerStatements:=FFD.prepareConsumerStatementsBatch(ds_Statements,ds_PersonContext,in_mod.FFDOptionsMask);
	ds_ConsumerAlerts:=FFD.ConsumerFlag.prepareAlertMessagesBatch(ds_PersonContext,ds_AlertFlags,in_mod.FFDOptionsMask);
	ds_ConsumerResults:=SORT(ds_ConsumerStatements+ds_ConsumerAlerts,(UNSIGNED)acctno);
	BatchShare.MAC_RestoreAcctno(ds_orig_recs,ds_ConsumerResults,ds_csdResults,FALSE,FALSE);

	// OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
	// OUTPUT(ds_validate,NAMED('ds_validate'));
	// OUTPUT(ds_work_recs,NAMED('ds_work_recs'));

	// OUTPUT(ds_proflic_recs,NAMED('ds_proflic_recs'));
	// OUTPUT(ds_proflic_out,NAMED('ds_proflic_out'));

	OUTPUT(ds_results,NAMED('Results'));
	OUTPUT(ds_csdResults,NAMED('CSDResults'));

ENDMACRO;
