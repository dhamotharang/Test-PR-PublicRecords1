/*--SOAP--
<message name="NAC BatchService">
	<part name="Include12MonthHistory"  type="xsd:boolean"/>
	<part name="batch_in"               type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
IMPORT NAC_Services,BatchShare;
EXPORT BatchService() := FUNCTION
// Batch service DOES NOT SUPPORT INVESTIGATIVE SEARCHES
//1. Get input params and sequence
	ds_in 	:= DATASET([], NAC_Services.Layouts.nac_batch_in) : STORED('batch_in',FEW);
	nac_mod := NAC_Services.IParams.getBatchParams(ds_in[1].benefit_state);
	BatchShare.MAC_SequenceInput(ds_in,ds_batch_in);

//2. Project to standard layout that is used for both the batch and search queries
	in_batch_processed := NAC_Services.BatchFunctions.processBatch(ds_batch_in);

//3. Get nac records
	nac_batch_recs     := NAC_Services.Records(in_batch_processed,nac_mod);

//4. Put it all together - returns NAC_Services.Layouts.nac_batch_out
	nac_batch_complete := NAC_Services.BatchFunctions.finalBatchTransform(nac_batch_recs);

	#WEBSERVICE(FIELDS('Include12MonthHistory','PenaltThreshold','batch_in'));
	RETURN OUTPUT(nac_batch_complete, NAMED('Results'));		
END;