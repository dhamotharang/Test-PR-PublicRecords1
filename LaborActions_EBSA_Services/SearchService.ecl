// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns Employee Benefit Security violation records.*/
import iesp, AutoStandardI;

EXPORT SearchService := MACRO

    rec_in := iesp.LaborAction_EBSA.t_LaborAction_EBSASearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('LaborAction_EBSASearchRequest', FEW);
	  first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.Options);
		iesp.ECL2ESP.SetInputNameCompanyName (first_row.SearchBy.Name);

	  input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,LaborActions_EBSA_Services.IParam.searchrecords,opt))
		  export string8 	 ClosingStartDate  := iesp.ECL2ESP.t_DateToString8(search_by.ClosingDateRange.StartDate);
		  export string8 	 ClosingEndDate    := iesp.ECL2ESP.t_DateToString8(search_by.ClosingDateRange.EndDate);
		end;

		is_valid_dateinput := (tempmod.ClosingStartDate = '' or ut.ValidDate(tempmod.ClosingStartDate))
		                      and (tempmod.ClosingEndDate = '' or ut.ValidDate(tempmod.ClosingEndDate));

    IF(~is_valid_dateinput, FAIL('An error occurred while running LaborActions_EBSA_Services.SearchService: invalid input dates.') );

		tmpresults := LaborActions_EBSA_Services.Search_Records.val(tempmod);
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults,
																								results,
																								iesp.LaborAction_EBSA.t_LaborAction_EBSASearchResponse,,,,,,
																								iesp.Constants.LABOR_ACTION_EBSA.MaxSearchRecords);

		output(results, named('Results'));

endmacro;
