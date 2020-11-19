// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import iesp;

export SearchService := macro
  #constant ('PenaltThreshold', 10);

  // Get XML input
  rec_in := iesp.accident.t_AccidentSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('AccidentSearchRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	iesp.ECL2ESP.SetInputName (search_by.Name);
  #stored ('CompanyName', search_by.CompanyName);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
	//Store fields unique to FL Accidents into soap names to be used below
  #stored ('AccidentNumber', search_by.AccidentNumber);
  #stored ('DriverLicenseNumber', search_by.DriverLicenseNumber);
  #stored ('VIN', search_by.VIN);
  #stored ('TagNumber', search_by.TagNumber);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,FLAccidents_Services.Search_Records.params,opt));
	  // Store soap fields unique to FL Accidents into unique attribute names to be passed
		// into FLAccidents_Services.Search_IDs
	  export string9  Accident_Number := '' : stored('AccidentNumber');
	  export string22 Vin_in          := '' : stored('VIN');
	  export string15 DL_Nbr          := '' : stored('DriverLicenseNumber');
	  export string8  Tag_Number      := '' : stored('TagNumber');
		export string32	ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	tempresults := FLAccidents_services.Search_Records.val(tempmod);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, iesp.accident.t_AccidentSearchResponse, Records, false);

  // Uncomment line below for debugging
	//output(tempresults,named('ss_tempresults'));
  output(results,named('Results'));

endmacro;
