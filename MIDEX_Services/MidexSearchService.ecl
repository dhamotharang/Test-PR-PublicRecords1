// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Search and return Midex information.*/
// <message name="Midex DataPermissionMask: Position 8=1: Nonpublic included, 9=1: Freddie Mac included">
  
IMPORT AutoStandardI,doxie,iesp,MIDEX_Services;

EXPORT MidexSearchService :=
  MACRO


    #CONSTANT('AllowNickNames',TRUE); // used to find the best subject for the input data
    #CONSTANT('PhoneticMatch', TRUE); // used to find the best subject for the input data

    // Get XML input
    rec_in := iesp.midexrecordsearch.t_MIDEXRecordSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('MIDEXRecordSearchRequest', FEW);
    first_row := ds_in[1] : INDEPENDENT;

    // Set global options
    iesp.ECL2ESP.SetInputBaseRequest(first_row); //dppa, glba, data restriction mask & ssn mask
    // Set/store common input RecordCount & StartingRecord options //???
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    // Store main search criteria:
    search_by := GLOBAL(first_row.SearchBy);
    options := GLOBAL(first_row.Options);
    alert_Input := GLOBAL(first_row.AlertInput);

    // Store common person & company ssn/fein/name/address/dob/phone xml inputs
    #STORED('ssn', search_by.SSN);
    #STORED('SSNLast4', search_by.SSNLast4);
    #STORED('LicenseNumber', search_by.LicenseNumber);
    #STORED('LicenseState', search_by.LicenseState);
    #STORED('Phone', search_by.Phone10);
    #STORED('DID', search_by.UniqueId);
    #STORED('MIDEXReportNumber', search_by.MIDEXReportNumber);
    #STORED('TIN', search_by.TIN);
    #STORED('companyName', search_by.companyName);
    #STORED('NMLSId', search_by.NMLSId);
    #STORED('StartLoadDate', iesp.ECL2ESP.t_DateToString8(search_by.StartLoadDate));
    #STORED('EnableAlert', alert_Input.EnableAlert);
    
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
  
    // *** Start of processing
    input_params := AutoStandardI.GlobalModule();
    
    // Get alert input
    ds_Search_hashes := PROJECT(alert_Input.Hashes,TRANSFORM(MIDEX_Services.Layouts.hash_layout,
                                                    SELF.all_hash := (INTEGER)LEFT.HashValue,
                                                    SELF := []));
    
    UNSIGNED1 vAlertVersion := IF(alert_input.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                  Midex_Services.Constants.AlertVersion.Current,
                                  alert_input.AlertVersion);
    
    tempmod := MODULE(PROJECT(input_params,MIDEX_Services.Iparam.searchrecords,OPT));
      // SearchBy fields not handled by AutoStandardI.GlobalModule
      EXPORT STRING4 ssn_last4 := '' : STORED('SSNLast4');
      EXPORT STRING20 license_number := '' : STORED('LicenseNumber');
      EXPORT STRING20 license_state := '' : STORED('LicenseState');
      EXPORT STRING26 midex_rpt_num := '' : STORED('MIDEXReportNumber');
      EXPORT STRING40 TIN := '' : STORED('TIN');
      EXPORT STRING40 nmls_id := '' : STORED('NMLSId');
      EXPORT DATASET searchHashes := ds_Search_Hashes;
      EXPORT UNSIGNED8 dob_filter := iesp.ECL2ESP.DateToInteger(search_by.DOB);
      EXPORT STRING8 StartLoadDate := '' : STORED('StartLoadDate');
      EXPORT BOOLEAN EnableAlert := FALSE : STORED('EnableAlert');
      EXPORT UNSIGNED1 AlertVersion := IF(alert_Input.EnableAlert,
                                                      vAlertVersion,
                                                      Midex_Services.Constants.AlertVersion.None);
      EXPORT BOOLEAN ReturnAllRecords := alert_Input.ReturnAllRecords : STORED('ReturnAllRecords');
    END;
    
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
    ds_results := Midex_Services.MidexSearch_Records(tempmod, mod_access);
    
    OUTPUT(ds_results, NAMED('Results'));

  ENDMACRO;

/*
For testing/debugging:
1. In the "MidexSearchRequest" xml text area, use the sample xml input below
   filling in:
   a. the appropriate input/search data fields,
   b. the appropriate common input/search options, (DPA, GLB, DRM, etc.)
   c. the product search specific ??? option (if needed/desired)
*/
