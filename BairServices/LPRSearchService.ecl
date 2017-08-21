/*--SOAP--
<message name="LPRSearchService">
  <part name="BAIRLprSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_LPR;
/*--INFO--	
*/

EXPORT LPRSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_lpr.t_BAIRLprSearchRequest) : STORED('BAIRLprSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);	
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_Lpr.IParam.getSearchParams(search_by); 
	max_results_rpt := IF(options.MaxResults>0 AND options.MaxResults<=BairRx_Common.Constants.MAX_RPT_RESULT, options.MaxResults, BairRx_Common.Constants.DEFAULT_MAX_RPT_RESULT);	
	
	dSrchRecs := BairRx_LPR.SearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return);		
	dRptRecs  := BairRx_LPR.ReportRecords(input_params, max_results_rpt);			
	dRecs :=  IF(EXISTS(input_params.EIDs), dRptRecs, dSrchRecs);
	
	iesp.bair_lpr.t_BAIRLprSearchRecord normResults(iesp.bair_lpr.t_BAIRLprSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dOutRecs := NORMALIZE(dRecs, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dOutRecs, dResults, iesp.bair_lpr.t_BAIRLprSearchResponse, dRecs[1].match_count);	
	
	output(dResults, named('Results'));
	
ENDMACRO;