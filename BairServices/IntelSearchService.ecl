/*--SOAP--
<message name="IntelSearchService">
  <part name="BAIRIntelSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_Intel;

/*--INFO--
*/
EXPORT IntelSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_intel.t_BAIRIntelSearchRequest) : STORED('BAIRIntelSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);	
		
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_Intel.IParam.getSearchParams(search_by); 
	
	dSrchResults := BairRx_Intel.SearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return);	
	
	iesp.bair_intel.t_BAIRIntelSearchRecord normResults(iesp.bair_intel.t_BAIRIntelSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchRecs := NORMALIZE(dSrchResults, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchRecs, dResults, iesp.bair_intel.t_BAIRIntelSearchResponse, dSrchResults[1].match_count);	
	
	output(dResults, named('Results'));	
	
ENDMACRO;