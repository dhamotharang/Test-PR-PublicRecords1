/*--SOAP--
<message name="CrashSearchService">
  <part name="BAIRCrashSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
/*--INFO--
*/
import iesp, BairRx_Common, BairRx_Crash;

EXPORT CrashSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_crash.t_BAIRCrashSearchRequest) : STORED('BAIRCrashSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);
		
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
			
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_Crash.IParam.getSearchParams(search_by); 
	
	dSrchRecs := BairRx_Crash.SearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return);	
	
	iesp.bair_crash.t_BAIRCrashSearchRecord normResults(iesp.bair_crash.t_BAIRCrashSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchResults := NORMALIZE(dSrchRecs, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchResults, dResults, iesp.bair_crash.t_BAIRCrashSearchResponse, dSrchRecs[1].match_count);	

	output(dResults, named('Results'));
	
ENDMACRO;