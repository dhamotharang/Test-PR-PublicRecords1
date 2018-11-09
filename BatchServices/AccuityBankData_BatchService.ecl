/*--SOAP--
<message name="AccuityBankData_BatchService">
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="IncludeGeotriangulationComparison" type="xsd:boolean"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="30"/>
</message>
*/

IMPORT BatchServices,BatchShare,AutoStandardI,STD,Royalty;

EXPORT AccuityBankData_BatchService := MACRO

	CNST:=BatchServices.AccuityBankData_Constants;

	in_mod := BatchShare.IParam.getBatchParams();
	dpmMod := MODULE(AutoStandardI.DataPermissionI.params)
		EXPORT dataPermissionMask:=in_mod.DataPermissionMask;
	END;
	BOOLEAN use_AccuityBankData := AutoStandardI.DataPermissionI.val(dpmMod).use_AccuityBankData;
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

	BatchServices.AccuityBankData_Layouts.batch_out setOutputs(ds_batch_wrk L) := TRANSFORM
		SELF.acctno:=L.orig_acctno;
		SELF.ultimate_bank_in_state:=MAP(
			L.error_code=CNST.ErrCode.INSUFFICIENT_INPUT => CNST.ErrMsg.INSUFFICIENT_INPUT,
			L.err_search=CNST.SrchCode.BANK_STATE_MATCHED => CNST.SrchMsg.BANK_STATE_MATCHED,
			L.err_search=CNST.SrchCode.BANK_STATE_NO_MATCH => CNST.SrchMsg.BANK_STATE_NO_MATCH,
			L.err_search=CNST.SrchCode.BANK_STATE_NULL => CNST.SrchMsg.BANK_STATE_NULL,
			L.err_search=CNST.SrchCode.ABA_RTN_NOT_FOUND => CNST.SrchMsg.ABA_RTN_NOT_FOUND,
			'');
		NO_MATCH_OR_NULL:=[CNST.SrchCode.BANK_STATE_NO_MATCH,CNST.SrchCode.BANK_STATE_NULL];
		SELF.geotriangulation:=IF(IncludeGeotriangulationComparison,
			MAP(L.error_code=CNST.ErrCode.INSUFFICIENT_INPUT OR
				L.err_search=CNST.SrchCode.ABA_RTN_NOT_FOUND => '',
				L.in_region='' => CNST.ErrMsg.INSUFFICIENT_INPUT,
				L.err_search=CNST.SrchCode.BANK_STATE_MATCHED AND L.in_region=L.in_state => CNST.GeoMsg.REGION_MATCHED,
				L.err_search=CNST.SrchCode.BANK_STATE_MATCHED AND L.in_region!=L.in_state => CNST.GeoMsg.REGION_IP_MISMATCH,
				L.err_search IN NO_MATCH_OR_NULL AND L.in_region=L.in_state => CNST.GeoMsg.REGION_BANK_MISMATCH,
				L.err_search IN NO_MATCH_OR_NULL AND L.in_region!=L.in_state => CNST.GeoMsg.REGION_NO_MATCH,
				''),
			'');
		SELF:=L;
	END;

	ds_batch_out := PROJECT(SORT(ds_batch_rejects+ds_batch_records,(UNSIGNED)acctno),setOutputs(LEFT));
	ds_royalties := Royalty.RoyaltyAccuityBankData.GetBatchRoyaltiesByAcctno(ds_batch_rejects+ds_batch_records);
	dRoyalties := Royalty.GetBatchRoyalties(ds_royalties,in_mod.ReturnDetailedRoyalties);		

	IF(NOT use_AccuityBankData,FAIL(CNST.ErrCode.CONFIG_ERR,CNST.ErrMsg.CONFIG_ERR));

	OUTPUT(ds_batch_out,NAMED('Results'));
	OUTPUT(dRoyalties,NAMED('RoyaltySet'));

ENDMACRO;
