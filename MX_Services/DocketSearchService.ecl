// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- <br>Search service for Mexican dockets.<br>*/
import iesp;

export DocketSearchService := MACRO

	ds_in := DATASET ([], iesp.internationaldocket.t_InternationalDocketSearchRequest) : STORED('InternationalDocketSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	MX_Services.IParam.SetInputDocketSearchBy(first_row.searchBy);
	MX_Services.IParam.SetInputDocketSearchOptions(first_row.options);
	in_mod 	:= MX_Services.Functions.getDocketSearchModule(first_row);
	recs 		:= MX_Services.SearchRecords.Docket.records(in_mod);
	recs_out := choosen(MX_Services.Functions.toFinalDocketOut(recs),  MX_Services.Constants.Limits.MAX_RESULTS);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs_out,results,iesp.internationaldocket.t_InternationalDocketSearchResponse);
	output(results, named('Results'));

ENDMACRO;
