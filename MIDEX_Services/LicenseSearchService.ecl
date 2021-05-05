// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Search and return Midex License information.*/
IMPORT AutoStandardI,doxie,iesp,MIDEX_Services;

EXPORT LicenseSearchService := MACRO
  
  // Get XML input
  rec_in := iesp.midexlicensesearch.t_MIDEXLicenseSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('MIDEXLicenseSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  // Set input options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  // Store main search criteria:
  search_by := GLOBAL (first_row.SearchBy);
  alert_Input := GLOBAL(first_row.AlertInput);
  
  // Store search options
  options_by := GLOBAL(first_row.Options);
  
  // Store common person & company ssn/ssn4/tin/name/address/phone/license Number xml inputs
  #STORED ('ssn', search_by.SSN);
  #STORED ('SSNLast4', search_by.SSNLast4);

  iesp.ECL2ESP.SetInputName (search_by.Name);
  #STORED ('CompanyName', search_by.CompanyName);

  iesp.ECL2ESP.SetInputAddress (search_by.Address);
  #STORED ('Phone', search_by.Phone);
  #STORED ('did', search_by.UniqueID);

  // Store product specific license number xml input
  #STORED ('LicenseNumber', search_by.LicenseNumber);
  #STORED ('LicenseState', search_by.LicenseState);
  #STORED ('Tin', search_by.Tin);
  #STORED ('NmlsID', search_by.NmlsID);
        
  // *** Start of processing
  input_params := AutoStandardI.GlobalModule();
  
  // Get alert input
  ds_Search_hashes := PROJECT(alert_Input.Hashes, 
    TRANSFORM(MIDEX_Services.Layouts.hash_layout,
      SELF.all_hash := (INTEGER)LEFT.HashValue,
      SELF := []));
  
  UNSIGNED1 vAlertVersion := IF(alert_input.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                Midex_Services.Constants.AlertVersion.Current,
                                alert_input.AlertVersion);
  
  tempmod := MODULE(PROJECT(input_params,Midex_Services.Iparam.searchrecords,OPT));
    // SearchBy fields not handled by AutoStandardI.GlobalModule
    EXPORT STRING4 ssn_last4 := '' : STORED('SSNLast4');
    EXPORT DATASET searchHashes := ds_Search_Hashes;
    EXPORT STRING20 license_number := '' : STORED('LicenseNumber');
    EXPORT STRING20 license_state := '' : STORED('LicenseState');
    EXPORT STRING40 tin := '' : STORED('Tin');
    EXPORT STRING40 nmls_id := '' : STORED('NmlsID');
    EXPORT UNSIGNED8 dob_filter := iesp.ECL2ESP.DateToInteger(search_by.DOB);
    EXPORT BOOLEAN EnableAlert := alert_Input.EnableAlert;
    // ReturnAllRecords option not being used any more. Just kept it if ESP or portal needs this option in the future
    EXPORT BOOLEAN ReturnAllRecords := alert_Input.ReturnAllRecords : STORED('ReturnAllRecords');
    EXPORT UNSIGNED1 AlertVersion := IF(alert_input.EnableAlert,
                                        vAlertVersion,
                                        Midex_Services.Constants.AlertVersion.None);
  END;

  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  ds_results := Midex_Services.LicenseSearch_Records(tempmod, mod_access);
  
  // Output the search results
  OUTPUT(ds_results, NAMED('Results'));
  

ENDMACRO;

/*
For testing/debugging:
1. In the "LicenseSearchRequest" xml text area, use the sample xml input below
   filling in:
   a. the appropriate input/search data fields,
   b. the appropriate common input/search options, (DPA, GLB, DRM, etc.)
   c. the product search specific ??? option (if needed/desired)
*/
