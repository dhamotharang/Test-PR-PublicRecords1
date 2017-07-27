/*--SOAP--
<message name="NAC_V2 BatchService">
  <part name="nacgroupid"              type="xsd:string"/>	
  <part name="sourcestate"             type="xsd:string"/>	
  <part name="programsallowedsearch"   type="xsd:string"/>	
  <part name="programsallowedreturned" type="xsd:string"/>	
	<part name="batch_in"                type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
IMPORT NAC_V2_Services,BatchShare;
EXPORT BatchService() := FUNCTION
// Batch service DOES NOT SUPPORT INVESTIGATIVE SEARCHES
// Get input params and sequence
	ds_in   := DATASET([],NAC_V2_Services.Layouts.nac_batch_in) : STORED('batch_in',FEW);
	nac_mod := NAC_V2_Services.IParams.getBatchParams();
	BatchShare.MAC_SequenceInput(ds_in,ds_batch_in);
// Project to standard layout that is used for both the batch and search queries
	in_batch_processed:= NAC_V2_Services.BatchFunctions(nac_mod).processBatch(ds_batch_in);
// Get nac records
	nac_batch_recs    := NAC_V2_Services.Records(in_batch_processed,nac_mod);
// Group, Rollup & Populate Batch History
	nac_batch_w_hist  := NAC_V2_Services.BatchFunctions().populateBatchHistory(in_batch_processed,nac_batch_recs);
// Populate Match codes
	nac_recs_matchcodes := NAC_V2_Services.Functions().MatchCodeLogic(in_batch_processed,nac_batch_w_hist,nac_mod);
// Handle errors & nac2 exceptions.
	nac_batch_complete:= NAC_V2_Services.Functions().applyCommonProcedures(in_batch_processed,nac_recs_matchcodes,nac_mod);
// Put it all together - returns NAC_V2_Services.Layouts.nac_batch_out
  nac_batch_results := NAC_V2_Services.BatchFunctions().finalBatchTransform(nac_batch_complete);
	
	#WEBSERVICE(FIELDS('NacGroupID','SourceState','ProgramsAllowedSearch','ProgramsAllowedReturned','PenaltThreshold','batch_in'));
	RETURN OUTPUT(nac_batch_results, NAMED('Results'));
END;