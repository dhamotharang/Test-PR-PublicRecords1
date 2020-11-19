// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

// so in general approach is
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.

export SearchService := macro
import FaaV2_PilotServices, iesp, AutoStandardI;

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

		rec_in := iesp.faapilot.t_PilotSearchRequest;
		// "FEW" keyword set to make data read more efficient
    ds_in := DATASET ([], rec_in) : STORED ('PilotSearchRequest', FEW);
		// "independent" keyword used here to make statement atomic and a signal to
		// code generator to not combine it with other lines of code.
		first_row := ds_in[1] : independent;
    //set options
		search_by := global (first_row.SearchBy);

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

		#constant ('PenaltThreshold', 10);
		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
		string12 UniqueId   := search_by.UniqueId;
		#STORED('did',UniqueId);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,FaaV2_PilotServices.SearchService_Records.params,opt))
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));

	end;

	tmp := FaaV2_PilotServices.SearchService_Records.val(tempmod);

		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, results, iesp.faapilot.t_PilotSearchResponse);

		output(results, named('Results'));

endmacro;
