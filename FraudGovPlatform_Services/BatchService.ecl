/*--SOAP--
<message name="BatchService">
	<!-- Common input options -->
	<part name="ApplicationType" type="xsd:string"/>
  <part name="DataPermissionMask"	type="xsd:string"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose"	type="xsd:byte"/> 
  <part name="IndustryClass" type="xsd:string"/>
	
	<!-- FDN Related Options -->
	<part name="GlobalCompanyId"	type="xsd:unsigned6"/>	
	<part name="IndustryType"	type="xsd:unsigned2"/>	
	<part name="ProductCode"	type="xsd:unsigned6"/>

	<!-- Other Options -->
	<part name="AgencyCounty" type="xsd:string"/>
	<part name="AgencyState" type="xsd:string"/>
	<part name="AgencyVerticalType"	type="xsd:string"/>
	<part name="AppendBest" type="xsd:boolean"/>
	<part name="DIDScoreThreshold" type="xsd:unsigned3"/>
	<part name="FraudPlatform" type="xsd:string"/>
	<part name="MaxVelocities" type="xsd:integer"/>	

  <part name="batch_in"	type="tns:XmlDataSet" cols="70" rows="25"/> 
</message>
*/

IMPORT BatchShare, FraudShared_Services, WSInput;

EXPORT BatchService(useCannedRecs = FALSE) := MACRO

	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_FraudGovPlatform_Services_BatchService();

  // **************************************************************************************
  // Read parameters and XML input. Providing a canned dataset for testing is optional,
  // but it comes in handy for everyone else.
  // **************************************************************************************
  batch_params  := FraudGovPlatform_Services.IParam.getBatchParams();
  ds_xml_in_raw := DATASET([], FraudShared_Services.Layouts.BatchIn_rec) : STORED('batch_in', FEW);
  ds_in         := IF(useCannedRecs, FraudGovPlatform_Services.BatchCannedInput, ds_xml_in_raw);

  // **************************************************************************************
  // Preprocess input as necessary
  // **************************************************************************************	
	BatchShare.MAC_SequenceInput(ds_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);
	
  // **************************************************************************************
  // Append DID for Input PII
  // **************************************************************************************	  
	ds_batch_in_with_did := BatchShare.MAC_Get_Scored_DIDs(ds_batch_in, batch_params, usePhone:=TRUE);

  // **************************************************************************************
  // Call Batch Records attribute to fetch records. 
  // **************************************************************************************
	ds_records := FraudGovPlatform_Services.BatchRecords(ds_batch_in_with_did, batch_params);

  // **
  // ** Simple transform to convert the input layout to the output layout
  // **
	flatten_out := FraudGovPlatform_Services.Functions.getFlatBatchOut(ds_records);
	
	BatchShare.MAC_RestoreAcctno(ds_batch_in, flatten_out, Results,true, false);
 
	// OUTPUT(ds_xml_in_raw, NAMED('ds_xml_in_raw'));
	// OUTPUT(ds_in, NAMED('ds_in'));
	// OUTPUT(ds_batch_in, NAMED('ds_batch_in'));
	// OUTPUT(ds_records, NAMED('ds_records'));
	// OUTPUT(flatten_out, NAMED('flatten_out'));
	OUTPUT(Results, NAMED('Results'));

ENDMACRO;	
