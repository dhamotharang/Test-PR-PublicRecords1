/*--SOAP--
<message name="NCPDP_Batch">
	<!-- COMPLIANCE SETTINGS -->
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
	<part name="NCPDPFullAccess"   		type="xsd:boolean"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

import iesp, AutoStandardI;

export NCPDP_Batch := MACRO
	batch_in_layout := Healthcare_Services.NCPDP_Layouts.autokeyInput;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	hasFullNCPDP := false :STORED('NCPDPFullAccess');

	unsigned1 DPPA_Purpose  := 0 : STORED('DPPAPurpose');
	unsigned1 GLB_Purpose := 8 : STORED('GLBPurpose');

	results := Healthcare_Services.NCPDP_Records().getRecordsBatch(ds_batch_in_stored);
	finalResults := project(results,Healthcare_Services.NCPDP_Transforms.fmtBatchResults(left,hasFullNCPDP));
	output(finalResults, named('Results'));
	EndMacro;