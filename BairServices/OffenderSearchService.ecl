/*--SOAP--
<message name="OffenderSearchService">
  <part name="BAIROffenderSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common, BairRx_Offender;

EXPORT OffenderSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_offender.t_BAIROffenderSearchRequest) : STORED('BAIROffenderSearchRequest', FEW);
	first_row := dIn[1] : INDEPENDENT;
	
	options := GLOBAL(first_row.options);
	BairRx_Common.IParam.SetInputSearchOptions(options);
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
		
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
		
	search_by := GLOBAL(first_row.SearchBy);							
	input_params := BairRx_Offender.IParam.getSearchParams(search_by, options.Raids); 	
	
	report_by := PROJECT(search_by, TRANSFORM(iesp.bair_share.t_BAIRBaseReportBy, SELF.EntityIDs := LEFT.EntityIDs, SELF := []));
	eid_input_params := BairRx_Common.IParam.getReportParams(report_by, options.Raids); 
	max_results_rpt := IF(options.MaxResults>0 AND options.MaxResults<=BairRx_Common.Constants.MAX_RPT_RESULT, options.MaxResults, BairRx_Common.Constants.DEFAULT_MAX_RPT_RESULT);	
	
	isReportMode := EXISTS(input_params.EIDs);
	BOOLEAN skipOffenderDates := NOT options.ApplyOffenderDates;
	dSrchRecs := BairRx_Offender.SearchRecords(input_params, BairRx_Common.ECL2ESP.Marshall.max_results_to_return, options.Raids, skipOffenderDates);		
	dRptRecs  := BairRx_Offender.ReportRecords(eid_input_params, max_results_rpt, options.IncludeNotes, options.Raids);			
	dRecs 		:= IF(isReportMode, dRptRecs, dSrchRecs);	
		
	iesp.bair_offender.t_BAIROffenderSearchRecord normResults(iesp.bair_offender.t_BAIROffenderSearchRecord R) := TRANSFORM
		SELF := R
	END;
	dSrchResults := NORMALIZE(dRecs, LEFT.records, normResults(RIGHT)); 	
	
	dPageResults := IF(isReportMode, dSrchResults, CHOOSEN(dSrchResults, BairRx_Common.ECL2ESP.Marshall.max_return, BairRx_Common.ECL2ESP.Marshall.starting_record));	
	
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(dPageResults, dResults, iesp.bair_offender.t_BAIROffenderSearchResponse, dRecs[1].match_count);	
	
	OUTPUT(dResults, NAMED('Results'));	
	
ENDMACRO;