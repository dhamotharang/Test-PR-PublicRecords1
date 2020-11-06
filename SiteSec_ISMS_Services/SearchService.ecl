// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns Safety Certification and Site Security Search records.*/
import iesp, AutoStandardI;

EXPORT SearchService := MACRO

    rec_in := iesp.siteSecurity.t_siteSecuritySearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('siteSecuritySearchRequest', FEW);
	  first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.Options);
		iesp.ECL2ESP.SetInputNameCompanyName (first_row.SearchBy.Name);

	  input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,SiteSec_ISMS_Services.IParam.searchrecords,opt))
		end;

		tmpresults := SiteSec_ISMS_Services.Search_Records.val(tempmod);
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults,
																								results,
																								iesp.siteSecurity.t_siteSecuritySearchResponse,,,,,,
																								iesp.Constants.SITE_SECURITY.MaxSearchRecords);

		output(results, named('Results'));

endmacro;
