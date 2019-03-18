/*--SOAP--
<message name="SexOffenderCPS_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataPermissionMask" 	type="xsd:string"/>
	<part name="run_deep_dive"        type="xsd:boolean"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="FFDOptionsMask" 	    type="xsd:string"/>
	<part name="FCRAPurpose"   	      type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/

/*
	NOTE: 'CPS' = 'Comprehensive Provider Service'. This service outputs a rather slim report notwithstanding
	the repeating Convictions.
*/
IMPORT BatchShare, BatchServices, Gateway;

EXPORT SexOffenderCPS_BatchServiceFCRA(useCannedRecs = false) := MACRO
		isFCRA := true;
	
		//TODO: figure out what input fields are actually used in the input layout and modify input layout
		ds_xml_in_raw 	:= dataset([], SexOffender_Services.Layouts.batch_in) : stored('batch_in', FEW);
		ds_xml_in := IF( NOT useCannedRecs, 
		                          ds_xml_in_raw, 
		                          project(BatchServices._Sample_inBatchMaster('SEXPREDATOR'), SexOffender_Services.Layouts.batch_in)
                             );	
														 		
		// common batch settings, including a gateway to a remote Picklist
		gm := AutoStandardI.GlobalModule(isFCRA);	
		
    batch_params := module (project (BatchShare.IParam.getBatchParamsV2(), SexOffender_Services.IParam.batch_params, opt))
			export dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
		  export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		  export integer  FCRAPurpose := FCRA.FCRAPurpose.Get();
    end;

		// run input through some standard procedures
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
		BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);	
		
		// append DID (a soap call to Picklist service
		BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, batch_params, IsFCRA);		
				

		//  Get the DID 
		dsDIDs := PROJECT(ds_batch_did, FFD.Layouts.DidBatch); 

		//  Call the person context
		pc_recs := FFD.FetchPersonContext(dsDIDs, batch_params.gateways, FFD.Constants.DataGroupSet.SexOffender, batch_params.FFDOptionsMask);
	
		// get records
		so := SexOffender_Services.batch_records(batch_params, ds_batch_did, isFCRA, pc_recs);
		ds_batch_out := so.records;
		
		//get statements
    ds_stmnts_out := so.FFD_Statements; 
		
		// Restore original acctno				
		BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_out, ds_batch_ready);	
		BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_stmnts_out, statements_ready, false, false);
		
		//sort by acctno
		ds_results	:= sort(ds_batch_ready, acctno);
		ds_statements := sort(statements_ready, acctno);
		ut.mac_TrimFields(ds_results, 'ds_results', results);
		
		OUTPUT(results, NAMED('Results'));		
		OUTPUT(ds_statements, NAMED('CSDResults'));
		
ENDMACRO;	
