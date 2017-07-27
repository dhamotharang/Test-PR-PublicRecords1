
/*--SOAP--
<message name="EBRBatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataRestrictionMask"	type="xsd:string"/>
		
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT Autokey_batch, BatchServices;

EXPORT EBRBatchService(BOOLEAN useCannedRecs = false) := 
	FUNCTION

		// 1. Accept input records.
		ds_xml_in   := DATASET([], Autokey_batch.layouts.rec_inBatchMaster) : STORED('batch_in', FEW);
		ds_batch_in := IF( NOT useCannedRecs, 
		                   ds_xml_in, 
		                   EBR_Services._canned_records 
                      );
		
		// 2. Get matching records, penalized.
		ds_matching_recs := EBR_Services.EBRBatchService_Records(ds_batch_in);

		RETURN OUTPUT( ds_matching_recs, NAMED('Results') );
		
	END;