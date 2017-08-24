/*--SOAP--
<message name="IncidentIDSearchService">
  <part name="BAIRIncidentIDSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_MapIncident;

/*--INFO--
This query performs the same search as map incident search but no incident information other than Incident ID (EID) is returned.
*/
EXPORT IncidentIDSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_incident.t_BAIRIncidentIDSearchRequest) : STORED('BAIRIncidentIDSearchRequest', FEW);
	first_row := dIn[1] : independent;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);	
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := global(first_row.SearchBy);			
	input_params := BairRx_MapIncident.IParam.getSearchParams(search_by); 
		
	in_max_results := BairRx_Common.ECL2ESP.Marshall.in_max_results;
	noPaging := in_max_results = 0;	
	// by default, i.e. max_results not specified, we want to return all EIDs up to 100K.
	max_records := IF(noPaging, BairRx_Common.Constants.MAX_EID_SRCH_RESULTS, BairRx_Common.ECL2ESP.Marshall.max_results_to_return);
	
	boolean skipOffenderDates := NOT options.ApplyOffenderDates;
	dRecs := BairRx_MapIncident.IDSearchRecords(input_params, options.Raids, max_records, skipOffenderDates);	
	
	iesp.bair_incident.t_BAIRIncidentIDSearchRecord normResults(iesp.bair_incident.t_BAIRIncidentIDSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dRecsN := NORMALIZE(dRecs, left.records, normResults(RIGHT)); 	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dRecsN, dResults, iesp.bair_incident.t_BAIRIncidentIDSearchResponse, dRecs[1].match_count,,,,,,,,noPaging);	

	output(dResults, named('Results'));
		
ENDMACRO;