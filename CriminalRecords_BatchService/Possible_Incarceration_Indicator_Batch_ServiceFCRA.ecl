/*--SOAP--
<message name="Possible_Incarceration_Indicator_Batch_ServiceFCRA" wuTimeout="300000">
	<part name="Return_DOC_Name" type="xsd:boolean"/>
	<part name="Return_SSN" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="FFDOptionsMask" type="xsd:string"/>
	<part name="FCRAPurpose" type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- FCRA Incarceration Indicator.*/


IMPORT AutoStandardI, BatchShare, CriminalRecords_BatchService,ut;

EXPORT Possible_Incarceration_Indicator_Batch_ServiceFCRA() := MACRO
	boolean isFCRA := true;
	
	ds_xml_in := DATASET([], CriminalRecords_BatchService.Layouts.batch_pii_in) : STORED('batch_in', FEW);
		
	gm := AutoStandardI.GlobalModule(isFCRA);
	batch_params		:= BatchShare.IParam.getBatchParamsV2();
	pii_batch_params := module(project(batch_params, CriminalRecords_BatchService.IParam.batch_params, opt))
		export dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
	end;
		
	// run input through some standard procedures
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);	
	
	
	// append DID (a soap call to Picklist service)
	BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, pii_batch_params, IsFCRA);	
		
	crim_out:= CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records(pii_batch_params, ds_batch_did, isFCRA);
  ds_batch_out := crim_out.Records;
	statements 	 := crim_out.Statements;
	 
	// Restore original acctno.	
	BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_out, ds_batch_ready);	
	BatchShare.MAC_RestoreAcctno(ds_batch_did, statements, statements_ready, false, false);	

	ut.mac_TrimFields(ds_batch_ready, 'ds_batch_ready', results);
	
	OUTPUT(results, NAMED('Results'));
	OUTPUT(statements_ready, NAMED('CSDResults'));	
	
ENDMACRO;