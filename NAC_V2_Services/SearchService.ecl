/*--SOAP--
<message name="NAC_V2_SearchService" wuTimeout="300000">
	<part name="NAC2SearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
IMPORT NAC_V2_Services,iesp,AutoheaderV2;
EXPORT SearchService() := FUNCTION
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
// Get input params and store iesp standards for penalty calculations
	ds_in     := DATASET([], iesp.nac2_search.t_NAC2SearchRequest) : STORED('NAC2SearchRequest',FEW);
	first_row := ds_in[1] : INDEPENDENT;
	nac_mod   := NAC_V2_Services.IParams.getEspParams(first_row);
	NAC_V2_Services.Functions().StoreIesp(first_row);
// Project to standard layout that is used for both the batch and search queries
	in_rec_processed    := NAC_V2_Services.SearchFunctions(nac_mod).processSearch(first_row.SearchBy);
// Get nac records
	nac_search_recs     := NAC_V2_Services.Records(in_rec_processed,nac_mod);
// Populate NAC match codes. ***NOTE - WE need this specifically BEFORE populating the match history section below
	nac_recs_matchcodes := NAC_V2_Services.Functions().MatchCodeLogic(in_rec_processed,nac_search_recs,nac_mod);
// Format nac recs - Denormalize match history
	nac_search_w_hist   := NAC_V2_Services.SearchFunctions(nac_mod).populateSearchHistory(UNGROUP(nac_recs_matchcodes));
// Handle errors & nac2 exceptions
	nac_search_complete := NAC_V2_Services.Functions().applyCommonProcedures(in_rec_processed,nac_search_w_hist,nac_mod);
// Put everything together - returns iesp output layout - iesp.nac2_search.t_NAC2SearchResultRecord
	nac_search_results  := NAC_V2_Services.SearchFunctions(nac_mod).finalSearchTransform(nac_search_complete);

	nac_canned_results	:= NAC_V2_Services.GetCannedRecords(first_row);
	
	final_results	:= if(first_row.user.testdataenabled,nac_canned_results,nac_search_results);

	#WEBSERVICE(FIELDS('NAC2SearchRequest'));
	RETURN OUTPUT(final_results, NAMED('Results'));
END;