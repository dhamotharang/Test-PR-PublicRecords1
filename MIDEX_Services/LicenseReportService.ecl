// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Search and return Midex License report.*/
// import AutoStandardI, iesp;

EXPORT LicenseReportService := MACRO

  IMPORT AutoStandardI,doxie,iesp,MIDEX_Services;
  // Get XML input
  rec_in := iesp.midexlicensereport.t_MIDEXLicenseReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('MIDEXLicenseReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  // Set input options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  
  report_options := GLOBAL (first_row.Options);
  // iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  // Store main search criteria:
  report_by := GLOBAL (first_row.ReportBy);
  alert_Input := GLOBAL(first_row.AlertInput);
  
  // Store mari rid and midex report number
  #STORED ('MidexReportNumber', report_by.MIDEXReportNumber);
  #STORED ('MariRid', report_by.MariRid);
  #STORED ('SearchType', report_by.SearchType);
  
  STRING26 Midex_number := '' : STORED('MidexReportNumber');
  STRING26 Mari_rid := '' : STORED('MariRid');
  
  MIDEX_Services.Layouts.rec_midex_payloadKeyField xfm_make_midx_record() := TRANSFORM
    SELF.midex_rpt_nbr := Midex_number;
    SELF := [];
  END;
  ds_Midex_number := DATASET([xfm_make_midx_record()]);
  
  MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField xfm_make_mari_record() := TRANSFORM
    SELF.mari_rid := (INTEGER) Mari_rid;
    SELF := [];
  END;

  ds_Mari_number := DATASET([xfm_make_mari_record()]);
  
  UNSIGNED1 vAlertVersion := IF(alert_input.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                Midex_Services.Constants.AlertVersion.Current,
                                alert_input.AlertVersion);
  
  // *** Start of processing
  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,Midex_Services.Iparam.reportrecords,OPT));
    // SearchBy fields not handled by AutoStandardI.GlobalModule
    EXPORT DATASET MidexReportNumbers := ds_Midex_number;
    EXPORT DATASET MariRidNumbers := ds_Mari_number;
    EXPORT STRING1 searchType := '' : STORED('SearchType');
    EXPORT STRING25 nameHash := alert_input.hashes.name.hashvalue;
    EXPORT STRING25 addressHash := alert_input.hashes.address.hashvalue;
    EXPORT STRING25 licenseStatHash := alert_input.hashes.LicenseStatus.hashvalue;
    EXPORT STRING25 phoneHash := alert_input.hashes.Phone.hashvalue;
    EXPORT STRING25 NMLSIdHash := alert_input.hashes.NMLSId.hashvalue;
    EXPORT STRING25 RepresentHash := alert_input.hashes.NMLSRepresents.hashvalue;
    EXPORT STRING25 RegistrationHash := alert_input.hashes.NMLSRegistration.hashvalue;
    EXPORT STRING25 DisciplinaryHash := alert_input.hashes.NMLSDisciplinary.hashvalue;
    EXPORT STRING25 AKAAndNameVariationHash := alert_input.hashes.AKAAndNameVariation.hashvalue;
    EXPORT BOOLEAN TrackName := alert_input.options.TrackName;
    EXPORT BOOLEAN TrackAddress := alert_input.options.TrackAddress;
    EXPORT BOOLEAN TrackLicenseStatus := alert_input.options.TrackLicenseStatus;
    EXPORT BOOLEAN TrackPhone := alert_input.options.TrackPhone;
    EXPORT BOOLEAN TrackRegistration := alert_input.options.TrackNMLSRegistration;
    EXPORT BOOLEAN TrackNMLSId := alert_input.options.TrackNMLSId;
    EXPORT BOOLEAN TrackRepresent := alert_input.options.TrackNMLSRepresents;
    EXPORT BOOLEAN TrackDisciplinary := alert_input.options.TrackNMLSDisciplinary;
    EXPORT BOOLEAN TrackAKAAndNameVariation := alert_input.options.TrackAKAAndNameVariation;
    EXPORT BOOLEAN EnableAlert := alert_input.EnableAlert;
    EXPORT UNSIGNED1 AlertVersion := IF(alert_input.EnableAlert,
                                        vAlertVersion,
                                        Midex_Services.Constants.AlertVersion.None);
    EXPORT BOOLEAN isLicenseOnlyReport := IF(Midex_number = '',TRUE,FALSE);
    EXPORT BOOLEAN includeLicRptsFromNMLS := FALSE; // Only return License report requested
  END;

  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  // No MAC_marshal is used, since the alert values are set at the repsone record level, the .val
  // returns the results already "Marshalled".
  ds_results := Midex_Services.LicenseReport_Records(tempmod, mod_access);
  finalresults := MIDEX_Services.Functions.Format_licenseReport_iespResponse(ds_results);
  
  // Output the search results
  // JIRA 10581 - because the format call above replicates rows, only output the first row
  OUTPUT(finalresults[1],NAMED('Results'));

ENDMACRO;

/*
For testing/debugging:
1. In the "LicenseReportRequest" xml text area, use the sample xml input below
   filling in:
   a. the appropriate input/search data fields,
   b. the appropriate common input/search options, (DPA, GLB, DRM, etc.)
   c. the product search specific ??? option (if needed/desired)

*/
