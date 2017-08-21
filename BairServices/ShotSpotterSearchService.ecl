/*--SOAP--
<message name="ShotSpotterSearchService">
  <part name="BAIRShotSpotterSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import BairRx_Common,iesp;
EXPORT ShotSpotterSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_shotspotter.t_BAIRShotSpotterSearchRequest) : STORED('BAIRShotSpotterSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);	
		
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);

	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
		
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_Spotter.IParam.getSearchParams(search_by); 
	max_results_rpt := IF(options.MaxResults>0 AND options.MaxResults<=BairRx_Common.Constants.MAX_RPT_RESULT, options.MaxResults, BairRx_Common.Constants.DEFAULT_MAX_RPT_RESULT);		
	
	dSrchRecs := BairRx_Spotter.SearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return);	
	dRptRecs  := BairRx_Spotter.ReportRecords(input_params, max_results_rpt);			
	dRecs := IF(EXISTS(input_params.EIDs), dRptRecs, dSrchRecs);
		
	iesp.bair_shotspotter.t_BAIRShotSpotterSearchRecord normResults(iesp.bair_shotspotter.t_BAIRShotSpotterSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchResults := NORMALIZE(dRecs, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchResults, dResults, iesp.bair_shotspotter.t_BAIRShotSpotterSearchResponse, dRecs[1].match_count);	
	
	output(dResults, named('Results'));
	
ENDMACRO;