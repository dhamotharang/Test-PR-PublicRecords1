/*--SOAP--
<message name="SexOffenderCPS_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataPermissionMask" 	type="xsd:string"/>
	<part name="run_deep_dive"        type="xsd:boolean"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

/*
	NOTE: 'CPS' = 'Comprehensive Provider Service'. This service outputs a rather slim report notwithstanding
	the repeating Convictions.
*/
IMPORT BatchShare, SexOffender_Services;

EXPORT SexOffenderCPS_BatchService(useCannedRecs = false) := 
	MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);		
		gm := AutoStandardI.GlobalModule();	
		batch_params := module (project (BatchShare.IParam.getBatchParamsV2(), SexOffender_Services.IParam.batch_params, opt))
		end;
		
		ds_xml_in_raw 	:= dataset([], SexOffender_Services.Layouts.batch_in) : stored('batch_in', FEW);
		ds_xml_in := IF( NOT useCannedRecs, 
										 ds_xml_in_raw, 
										 project(BatchServices._Sample_inBatchMaster('SEXPREDATOR'), SexOffender_Services.Layouts.batch_in)
									  );		
														 
		// run input through some standard procedures
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
		BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);		
		
		// get records
		so := SexOffender_Services.batch_records(batch_params, ds_batch_in, false);
		ds_batch_out := so.records;

		// Restore original acctno				
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out, ds_batch_ready);	
		ds_results	:= sort(ds_batch_ready, acctno);
		
		// DEBUGs:	
		// OUTPUT(so.offenders, NAMED('offenders'));
		// OUTPUT(so.offenses, NAMED('offenses'));
		
		ut.mac_TrimFields(ds_results, 'ds_results', results);
		OUTPUT(results, NAMED('Results'));		
		
ENDMACRO;	
