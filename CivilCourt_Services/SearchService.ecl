// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import iesp, AutoStandardI, ut;

export SearchService := macro

    //read ESP input values into ECL "standard" names

    rec_in := iesp.civilCourt.t_CivilCourtSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('CivilCourtSearchRequest', FEW);
		 first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);

		iesp.ECL2ESP.SetInputName (search_by.Name);
		#stored ('CompanyName', search_by.CompanyName);

    // to make it available from both SOAP and ESP requests (abbreviate state, if needed)
		string state_tmp := trim(search_by.State, left, right);
    esp_in_state := if (length(state_tmp) > 2,
                        ut.st2Abbrev (StringLib.StringToUpperCase (state_tmp)), state_tmp);
		#stored ('State', esp_in_state);

		string25 City := search_by.City;
    #stored ('City', City);

		#stored ('SearchByJurisdiction', search_by.Jurisdiction);

    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,CivilCourt_services.SearchService_Records.params,opt))
				export string2  State_in := '' : stored('State');
				string25 City_tmp_in := '' : stored('City');
				export string25 City_in := stringlib.StringToUpperCase(City_tmp_in);
				export string60 jurisdiction_mixedCase := '' : stored('SearchByJurisdiction');
				export string60 jurisdiction_in := stringlib.StringToUpperCase(jurisdiction_mixedCase);
		end;

		tmpresults := CivilCourt_services.SearchService_Records.val(tempmod);
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, results, iesp.civilCourt.t_CivilCourtSearchResponse);
		output(results, named('Results'));
endmacro;
