// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT iesp, AutoStandardI, doxie;

EXPORT SearchService := MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #constant('SearchGoodSSNOnly',TRUE);
  #constant('SearchIgnoresAddressOnly',TRUE);
  #constant('getBdidsbyExecutive',FALSE);

  ds_in := DATASET ([], iesp.controlledsubstance.t_DEASearchRequest) : STORED ('DEASearchRequest', FEW);
  first_row := ds_in[1] : independent;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := global (first_row.SearchBy);
  iesp.ECL2ESP.SetInputName (search_by.Name);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  //process input specific for this service:
  #stored ('RegistrationNumber', search_by.DEARegistrationNumber);
  #stored ('SSN', search_by.SSN);
  #stored ('CompanyName', search_by.CompanyName);
  #stored ('DID',search_by.UniqueId);
  input_params := AutoStandardI.GlobalModule();

	tempmod := module(project(input_params,DEA_Services.Records.params,opt))
			EXPORT string9 dea_registration_number := '' : stored ('RegistrationNumber');
			EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params, AutoStandardI.InterfaceTranslator.application_type_val.params));
			EXPORT STRING6 SSNMASK 			:= 'NONE' : stored('SSNMask');
 end;

 	tmp := DEA_Services.Records.val(tempmod);

	 iesp.ECL2ESP.Marshall.MAC_Marshall_Results (tmp, results, iesp.controlledsubstance.t_DEASearchResponse);

  output(results, named('Results'));
ENDMACRO;
