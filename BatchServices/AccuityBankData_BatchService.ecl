/*--SOAP--
<message name="AccuityBankData_BatchService">
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="IncludeGeotriangulationComparison" type="xsd:boolean"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="30"/>
</message>
*/

IMPORT BatchServices,BatchShare,STD,Royalty,WSInput;

EXPORT AccuityBankData_BatchService := MACRO

	WSInput.MAC_AccuityBankData_BatchService();

	CNST:=BatchServices.AccuityBankData_Constants;

	in_mod := BatchShare.IParam.getBatchParams();
	BOOLEAN use_AccuityBankData := doxie.compliance.use_AccuityBankData(in_mod.DataPermissionMask);
	BOOLEAN IncludeGeotriangulationComparison := FALSE : STORED('IncludeGeotriangulationComparison');

	ds_batch_in := DATASET([],BatchServices.AccuityBankData_Layouts.batch_in) : STORED('batch_in',FEW);
	BatchShare.MAC_SequenceInput(ds_batch_in,ds_batch_seq);

	BatchServices.AccuityBankData_Layouts.batch_wrk validateInputs(ds_batch_seq L) := TRANSFORM
		RTN:=STD.Str.Filter(L.routing_transit_nbr,'0123456789');
		ST:=BatchServices.Functions.st2abbrev(L.state);
		SELF.in_routing_nbr:=RTN;
		SELF.in_state:=ST;
		SELF.in_region:=BatchServices.Functions.st2abbrev(L.edge_region);
		SELF.error_code:=IF((UNSIGNED)RTN!=0 AND LENGTH(TRIM(RTN,ALL))=9 AND LENGTH(TRIM(ST,ALL))=2,
			L.error_code,CNST.ErrCode.INSUFFICIENT_INPUT);
		SELF:=L;
		SELF:=[];
	END;

	ds_batch_wrk := PROJECT(ds_batch_seq,validateInputs(LEFT));
	ds_batch_rejects := ds_batch_wrk(error_code!=0);
	ds_batch_records := BatchServices.AccuityBankData_Records(ds_batch_wrk(error_code=0));

  // 2020-08-25, for JIRA RR-19445 moved the setOutputs transform to a new BatchServices.AccuityBankData_Functions.fn_SetOutputs, 
  // so that logic could also be used by the new GeoTriangulation_Services.BatchService.
  //
  // Call new function to set the 2 bank routing_transit_nbr/state/edge_region related fields
  ds_batch_out := BatchServices.AccuityBankData_Functions.fn_SetOutputs(
                                SORT(ds_batch_rejects+ds_batch_records, (UNSIGNED)acctno),
                                IncludeGeotriangulationComparison);

	ds_royalties := Royalty.RoyaltyAccuityBankData.GetBatchRoyaltiesByAcctno(ds_batch_rejects+ds_batch_records);
	dRoyalties := Royalty.GetBatchRoyalties(ds_royalties,in_mod.ReturnDetailedRoyalties);		

	IF(NOT use_AccuityBankData,FAIL(CNST.ErrCode.CONFIG_ERR,CNST.ErrMsg.CONFIG_ERR));

	OUTPUT(ds_batch_out,NAMED('Results'));
	OUTPUT(dRoyalties,NAMED('RoyaltySet'));

ENDMACRO;
