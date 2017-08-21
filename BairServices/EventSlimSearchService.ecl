/*--SOAP--
<message name="EventSearchService">
  <part name="BAIREventSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_Event;

/*--INFO--

*/
EXPORT EventSlimSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_event_slim.t_BAIREventSlimSearchRequest) : STORED('BAIREventSlimSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := GLOBAL(first_row.SearchBy);							
	input_params := BairRx_Event.IParam.getSlimSearchParams(search_by, options.Raids); 	

	dSrchRecs := BairRx_Event.SlimSearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return, options.Raids);	
	dRptRecs := BairRx_Event.SlimReportRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return, options.Raids);	
	dRecs := IF(EXISTS(input_params.EIDs), dRptRecs, dSrchRecs);
	
	iesp.bair_event_slim.t_BAIREventSlimSearchRecord normResults(iesp.bair_event_slim.t_BAIREventSlimSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchResults := NORMALIZE(dRecs, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchResults, dResults, iesp.bair_event_slim.t_BAIREventSlimSearchResponse, dRecs[1].match_count);	

	output(dResults, named('Results'));
	
ENDMACRO;