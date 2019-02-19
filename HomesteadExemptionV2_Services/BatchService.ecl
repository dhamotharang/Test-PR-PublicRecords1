/*--SOAP--
<message name="BatchService">
	<part name="DPPAPurpose"             type="xsd:byte"/>
	<part name="GLBPurpose"              type="xsd:byte"/>
	<part name="SSNMask"                 type="xsd:string"/>
	<part name="DOBMask"                 type="xsd:string"/>
	<part name="DataPermissionMask"      type="xsd:string"/>
	<part name="DataRestrictionMask"     type="xsd:string"/>
	<part name="DidScoreThreshold"       type="xsd:unsignedInt"/>
	<part name="MaxProperties"           type="xsd:unsignedInt"/>
	<part name="TaxYear"                 type="xsd:string"/>
	<part name="TaxState"                type="xsd:string"/>
	<part name="LNBranded"               type="xsd:boolean"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="IncludeRealtimeVehicles" type="xsd:boolean"/>
	<part name="RealTimePermissibleUse"  type="xsd:string"/>
	<part name="IncludePrevOwnedProps"   type="xsd:boolean"/>
	<part name="Gateways"                type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="batch_in"                type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT WSInput, Royalty;

EXPORT BatchService := MACRO

	#CONSTANT('SearchLibraryVersion',AutoheaderV2.Constants.LibVersion.LEGACY);
	WSInput.MAC_HomesteadExemption_BatchService();

	in_mod:=HomesteadExemptionV2_Services.IParams.getParams();
	IF(NOT in_mod.isValidGlb(), FAIL(HomesteadExemptionV2_Services.Constants.GLB_REQUIRED_MSG));

	ds_batch_in:=DATASET([],HomesteadExemptionV2_Services.Layouts.inputRec) : STORED('batch_in',FEW);
	ds_seq_input:=HomesteadExemptionV2_Services.Functions.seqLinkInput(ds_batch_in);

	ds_work_recs:=HomesteadExemptionV2_Services.Records(ds_seq_input,in_mod);
	ds_work_batch:=HomesteadExemptionV2_Services.fn_getBatchOutput(ds_work_recs,in_mod);

	// BATCH OUTPUT
	ds_batch_parents:=PROJECT(ds_work_batch,TRANSFORM(HomesteadExemptionV2_Services.Layouts.batchOutRec,SELF:=LEFT,SELF:=[]));
	ds_batch_children:=NORMALIZE(ds_work_batch,LEFT.property_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.batchWorkPropRec,SELF:=RIGHT));
	ds_batch_denormalized:=BatchShare.MAC_ExpandLayout.Denorm(ds_batch_parents,ds_batch_children,
		HomesteadExemptionV2_Services.Layouts.propertyOutRec,'',HomesteadExemptionV2_Services.Constants.MAX_PROPERTIES,'_');
	BatchShare.MAC_RestoreAcctno(ds_seq_input,ds_batch_denormalized,ds_results,,FALSE);

	// ROYALTIES
	ds_property_recs:=NORMALIZE(ds_work_recs,LEFT.property_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.propertyRec,SELF:=RIGHT));
	ds_vehicle_recs:=NORMALIZE(ds_property_recs,LEFT.vehicle_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.vehRoyaltyRec,SELF:=RIGHT));
	BatchShare.MAC_RestoreAcctno(ds_seq_input,ds_vehicle_recs,ds_vehicle_acctno_recs,,FALSE);
	Royalty.RoyaltyVehicles.MAC_Append(ds_vehicle_acctno_recs,ds_vehicle_royalty_recs,vin,source_code,TRUE);
	Royalty.RoyaltyVehicles.MAC_BatchSet(ds_vehicle_royalty_recs,ds_royalties,,in_mod.ReturnDetailedRoyalties);	

	// OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
	// OUTPUT(ds_seq_input,NAMED('ds_seq_input'));

	// OUTPUT(ds_work_recs,NAMED('ds_work_recs'));
	// OUTPUT(ds_work_batch,NAMED('ds_work_batch'));

	// OUTPUT(ds_vehicle_recs,NAMED('ds_vehicle_recs'));
	// OUTPUT(ds_vehicle_acctno_recs,NAMED('ds_vehicle_acctno_recs'));
	// OUTPUT(ds_vehicle_royalty_recs,NAMED('ds_vehicle_royalty_recs'));

	// OUTPUT(ds_batch_parents,NAMED('ds_batch_parents'));
	// OUTPUT(ds_batch_children,NAMED('ds_batch_children'));
	// OUTPUT(ds_batch_denormalized,NAMED('ds_batch_denormalized'));

	OUTPUT(ds_results,NAMED('Results'));
	OUTPUT(ds_royalties,NAMED('RoyaltySet'));
ENDMACRO;
