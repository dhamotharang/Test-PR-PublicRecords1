// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

// Returns FAA Aircraft Search records.
// so in general approach is
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.
import FaaV2_services, iesp, AutoStandardI;

export SearchService := macro

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

    //read ESP input values into ECL "standard" names
		// iesp.ECL2ESP.MAC_ReadESPInput();

    rec_in := iesp.faaaircraft.t_AircraftSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('AircraftSearchRequest', FEW);
		 first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
    #stored ('CompanyName', search_by.CompanyName);
    #stored ('AircraftNumber', search_by.AircraftNumber);
		//#stored ('PenaltThreshold', 10);
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
/*
    // TODO: check for "wealsofound": according to input XML it should be a constant, if any.
		// wealsofound is opposite of no deep dive
		boolean Reversed_weAlsoFound := false : stored('weAlsoFound');
		boolean weAlsoFound:= if (Reversed_weAlsoFound, false, true);
		#stored('NoDeepDive',weAlsoFound);
*/
    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,FaaV2_Services.SearchService_Records.params,opt))
			shared string8 n_number_mixed := '' : stored('AircraftNumber');
			shared string8 n_number := stringlib.StringToUpperCase(n_number_mixed);
			export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;

		res_temp := FaaV2_Services.SearchService_Records.val(tempmod);

		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(res_temp, results, iesp.faaaircraft.t_AircraftSearchResponse);

		output(results, named('Results'));

endmacro;
