/*--SOAP--
<message name="Batch_Service">
	<part name="ApplicationType" type="xsd:string"/>
	<part name="SSNMask"         type="xsd:string"/>
	<part name="batch_in"        type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchShare, FaaV2_PilotServices, WSInput;

EXPORT Batch_Service() := MACRO

	WSInput.MAC_FAA_Pilot_BatchService();

	in_mod:=BatchShare.IParam.getBatchParams();

	ds_batch_in:=DATASET([],FaaV2_PilotServices.Layouts.batch_in) : STORED('batch_in',FEW);
	BatchShare.MAC_SequenceInput(ds_batch_in,ds_seq_recs);
	BatchShare.MAC_CapitalizeInput(ds_seq_recs,ds_cap_recs);
	BatchShare.MAC_CleanAddresses(ds_cap_recs,ds_cln_recs);

	// validate input records
	ds_wrk_recs:=PROJECT(ds_cln_recs,TRANSFORM(FaaV2_PilotServices.Layouts.batch_work,
		SELF.error_code:=IF(BatchShare.MAC_IsInputValid(LEFT,BatchShare.Constants.Valid_Min_Cri.DID_OR_Name_Address)
			OR ((UNSIGNED)LEFT.SSN<>0 AND LENGTH(TRIM(LEFT.SSN,ALL))=9),
			BatchShare.Constants.ValidInput,
			FaaV2_PilotServices.Constants.INSUFFICIENT_INPUT),
		SELF:=LEFT));

	ds_airmen_recs:=FaaV2_PilotServices.Batch_Records(ds_wrk_recs,in_mod);
	ds_airmen_errs:=JOIN(ds_wrk_recs,ds_airmen_recs,LEFT.acctno=RIGHT.acctno,
		TRANSFORM(FaaV2_PilotServices.Layouts.batch_out,
			SELF.acctno:=LEFT.acctno,
			SELF.error_code:=IF(LEFT.error_code>0,LEFT.error_code,FaaV2_PilotServices.Constants.NO_RECORDS),
			SELF:=[]),
		LEFT ONLY);

	ds_airmen_children:=SORT(ds_airmen_recs+ds_airmen_errs,(UNSIGNED)acctno,-date_first_seen,-date_last_seen);
	ds_airmen_parents:=DEDUP(PROJECT(ds_airmen_children,
		TRANSFORM(FaaV2_PilotServices.Layouts.batch_out_flat,SELF:=LEFT,SELF:=[])),ALL);

	ds_airmen_flat:=BatchShare.MAC_ExpandLayout.Denorm(ds_airmen_parents,ds_airmen_children,
		FaaV2_PilotServices.Layouts.airmenRec,'',FaaV2_PilotServices.Constants.MAX_AIRMEN,'_');

	BatchShare.MAC_RestoreAcctno(ds_wrk_recs,ds_airmen_flat,ds_results,TRUE,FALSE);

	// OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
	// OUTPUT(ds_wrk_recs,NAMED('ds_wrk_recs'));
	// OUTPUT(ds_airmen_recs,NAMED('ds_airmen_recs'));
	// OUTPUT(ds_airmen_errs,NAMED('ds_airmen_errs'));
	// OUTPUT(ds_airmen_children,NAMED('ds_airmen_children'));
	// OUTPUT(ds_airmen_parents,NAMED('ds_airmen_parents'));
	// OUTPUT(ds_airmen_flat,NAMED('ds_airmen_flat'));

	OUTPUT(ds_results,NAMED('Results'));

ENDMACRO;
