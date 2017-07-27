/*--SOAP--
<message name="Sample_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

IMPORT BatchServices, Autokey_batch;

EXPORT Batch_Service(useCannedRecs = false) := 
	MACRO
	
		// **************************************************************************************
		//     Define input XML as a dataset, or use canned records for development/testing.
		// **************************************************************************************
	  // 1. Accept input records.
		ds_xml_in   := DATASET([], NaturalDisaster_Readiness.Layouts.batch_in) : STORED('batch_in', FEW);
		ds_batch_in := IF( NOT useCannedRecs, ds_xml_in, NaturalDisaster_Readiness._canned_records );
		
		// 2. Get matching records and output
		OUTPUT( NaturalDisaster_Readiness.Batch_Service_Records(ds_batch_in), NAMED('Results') );
		
	ENDMACRO;