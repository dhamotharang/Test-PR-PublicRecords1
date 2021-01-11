// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- <p>Search service for Mexican professional certification.</p>*/
import iesp;

// Used by Accurint->International->Professional Certification Search.
//	- formerly known as International Professional License Search (ProfLicenseSearchService)
export ProfessionSearchService := MACRO
	#onwarning(4207, ignore);

	ds_in := DATASET ([], iesp.internationalprofcert.t_InternationalProfCertificationSearchRequest) : STORED('InternationalProfCertificationSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	MX_Services.IParam.SetInputProfessionSearchBy(first_row.searchBy);
	MX_Services.IParam.SetInputProfessionSearchOptions(first_row.options);
	in_mod 			:= MX_Services.Functions.getProfessionSearchModule(first_row);
	recs 				:= MX_Services.SearchRecords.Profession.records(in_mod);
	recs_final 	:= choosen(MX_Services.Functions.toFinalProfessionOut(recs), MX_Services.Constants.Limits.MAX_RESULTS);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs_final,Results,iesp.internationalprofcert.t_InternationalProfCertificationSearchResponse);
	output(Results, named('results'));

ENDMACRO;
