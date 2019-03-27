/*--SOAP--
<message name="BatchServiceFCRA">
  <part name="batch_in"    type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose"  type="xsd:byte"/> 
  <part name="MaxResults"  type="xsd:unsignedInt"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="FFDOptionsMask" type="xsd:string"/>
	<part name="FCRAPurpose" type="xsd:string"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service pulls from the FCRA Criminal Offenders file.*/

EXPORT BatchServiceFCRA() := MACRO
	boolean isFCRA := true;
	
	ds_xml_in		    := DATASET([], CriminalRecords_BatchService.Layouts.batch_in) : STORED('batch_in');

	batch_params		:= BatchShare.IParam.getBatchParamsV2();
	crim_batch_params := module(project(batch_params, CriminalRecords_BatchService.IParam.batch_params, opt))
		export dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
		unsigned2 MaxResults_val := 50 : stored('MaxResults');
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
	end;
	
	// run input through some standard procedures
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);	
	
	// append DID (a soap call to Picklist service)
	BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, crim_batch_params, IsFCRA);	
	
	ds_batch_out_all := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_batch_did, isFCRA);
	ds_batch_out := ds_batch_out_all.Records;
	statements 	 := ds_batch_out_all.Statements;
	
	// Restore original acctno.	
	BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_out, results);	
	BatchShare.MAC_RestoreAcctno(ds_batch_did, statements, csdresults , false, false);	
	
	ut.mac_TrimFields(results, 'results', result);
	
	OUTPUT(result, NAMED('RESULTS'), ALL);
	OUTPUT(csdresults, NAMED('CSDResults'), ALL);

ENDMACRO;
