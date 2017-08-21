/*--SOAP--
<message name="MapIncidentSearchService">
  <part name="BAIRMapIncidentSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRX_MapIncident;

EXPORT MapIncidentSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_mapincident.t_BAIRMapIncidentSearchRequest) : STORED('BAIRMapIncidentSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);	
		
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_MapIncident.IParam.getSearchParams(search_by,options.Raids); 
	
	max_id_records := IF(options.EIDDownload, BairRx_Common.Constants.MAX_EID_SRCH_RESULTS, 0);
	max_records := MAX(BairRx_Common.ECL2ESP.Marshall.max_results_to_return, max_id_records);
	
	dSrchResults := BairRx_MapIncident.SearchRecords(input_params, options, max_records);	
	
	iesp.bair_mapincident.t_BAIRMapIncidentSearchRecord normResults(iesp.bair_mapincident.t_BAIRMapIncidentSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchRecs := NORMALIZE(dSrchResults, left.records, normResults(RIGHT)); 
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchRecs, dResults, iesp.bair_mapincident.t_BAIRMapIncidentSearchResponse, dSrchResults[1].match_count,,,,
		metadata, dSrchResults[1].metadata,
		Clustermetadata, dSrchResults[1].Clustermetadata,  options.EIDDownload);	

	output(dResults, named('Results'));
		
ENDMACRO;