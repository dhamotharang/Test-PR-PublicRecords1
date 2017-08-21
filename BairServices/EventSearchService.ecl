/*--SOAP--
<message name="EventSearchService">
  <part name="BAIREventSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_Event;

/*--INFO--

*/
EXPORT EventSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_event.t_BAIREventSearchRequest) : STORED('BAIREventSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_Event.IParam.getSearchParams(search_by); 	

	dSrchRecs := BairRx_Event.SearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return);	
	
	iesp.bair_event.t_BAIREventSearchRecord normResults(iesp.bair_event.t_BAIREventSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchResults := NORMALIZE(dSrchRecs, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchResults, dResults, iesp.bair_event.t_BAIREventSearchResponse, dSrchRecs[1].match_count);	
	
	output(dResults, named('Results'));
	
ENDMACRO;