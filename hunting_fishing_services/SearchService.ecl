// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import iesp, AutoStandardI;

export SearchService := macro

  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  // Get XML input
  rec_in := iesp.huntingfishing.t_HuntFishSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('HuntFishSearchRequest', FEW);
  first_row := ds_in[1] : independent;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := global (first_row.SearchBy);
  #stored ('SSN', search_by.SSN);
  iesp.ECL2ESP.SetInputName (search_by.Name);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  tempmod := module(project(input_params,hunting_fishing_services.Search_Records.params,opt));
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
  end;
  tempresults := hunting_fishing_services.Search_Records.val(tempmod);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults.Records, results, iesp.huntingfishing.t_HuntFishSearchResponse, Records, false);

  output(results,named('Results'));

endmacro;
// SearchService ();
