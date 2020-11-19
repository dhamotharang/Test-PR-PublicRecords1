// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import internetdomain_services, iesp, AutoStandardI;

export SearchService := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    //read ESP input values into ECL "standard" names
		// iesp.ECL2ESP.MAC_ReadESPInput();

    rec_in := iesp.InternetDomain.t_InetDomainSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('InetDomainSearchRequest', FEW);
		first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);

		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);

		#stored ('CompanyName', search_by.CompanyName);
		#stored ('DomainName', search_by.DomainName);

    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,internetDomain_services.SearchService_Records.params,opt))
		    shared string45 domainName_mixed := '' : stored('DomainName');
				shared string45 domainName := stringlib.StringToUpperCase(domainName_mixed);
				export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;

		tmpresults := InternetDomain_services.SearchService_Records.val(tempmod);
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, results, iesp.InternetDomain.t_InetDomainSearchResponse);
		output(results, named('Results'));

endmacro;
