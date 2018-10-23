/*--SOAP--
<message name="NAC SearchService" wuTimeout="300000">
	<part  name="NACSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
IMPORT NAC_Services,NAC_V2_Services,iesp,AutoheaderV2;
EXPORT SearchService() := FUNCTION
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
//1. Get input params and store iesp standards for penalty calculations
	ds_in     := DATASET([], iesp.nac_search.t_NACSearchRequest) : STORED('NACSearchRequest',FEW);
	first_row := ds_in[1] : INDEPENDENT;
	nac_mod   := NAC_Services.IParams.getEspParams(first_row);
	NAC_V2_Services.Functions().StoreIesp(first_row,Suffix);

//2. Project to standard layout that is used for both the batch and search queries		
	in_rec_processed := NAC_Services.SearchFunctions.processSearch(first_row.SearchBy,nac_mod.InvestigativePurpose);

//3. Get nac records
	nac_search_recs  := NAC_Services.Records(in_rec_processed,nac_mod);

//4. Put everything together - returns iesp output layout - iesp.nac_search.t_NACSearchResultRecord
	nac_complete     := NAC_Services.SearchFunctions.finalSearchTransform(nac_search_recs,first_row.SearchBy.DrupalTransactionId);

	#WEBSERVICE(FIELDS('PenaltThreshold','NACSearchRequest'));
	RETURN OUTPUT(nac_complete, NAMED('Results'));
END;