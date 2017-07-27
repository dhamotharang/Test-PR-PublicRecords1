/*--SOAP--
<message name="DisclosedEntity_SearchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

import iesp, AutoStandardI;

export DisclosedEntity_BatchService := MACRO
	batch_in_layout := Healthcare_Services.DisclosedEntity_Layouts.batchInput;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	gm := AutoStandardI.GlobalModule();

	recs := Healthcare_Services.DisclosedEntity_Records.getRecordsBatch(project(ds_batch_in_stored,Healthcare_Services.DisclosedEntity_Layouts.flatInput),gm.GLBPurpose,gm.DPPAPurpose,gm.DataRestrictionMask);	
	results:=project(recs,Healthcare_Services.DisclosedEntity_Transforms.fmtBatchResults(left));
	output(results, named('Results'));
ENDMACRO;
