// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service pulls from the Criminal Offenders file.*/
IMPORT iesp, AutoStandardI, FFD, Gateway;

EXPORT ReportServiceFCRA := MACRO
  BOOLEAN isFCRA := TRUE;
  
  // Get XML input
  rec_in := iesp.criminal_fcra.t_FcraCriminalReportRequest;
  ds_in := DATASET([], rec_in) : STORED('FcraCriminalReportRequest', few);
  first_row := ds_in[1] : INDEPENDENT;
  
  // set options
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  
  // set main search criteria
  report_opt := GLOBAL (first_row.Options);
  report_by := GLOBAL (first_row.ReportBy);
  
  //Store "report-by" fields into soap names to be used below for SOAP testing
  #STORED('IncludeAllCriminalRecords', report_opt.IncludeAllCriminalRecords);
  #STORED('IncludeSexualOffenses', report_opt.IncludeSexualOffenses);
  #STORED ('DID', report_by.UniqueId);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  // used only for SOAP testing
  tempmod := MODULE(PROJECT(input_params,CriminalRecords_Services.IParam.report,OPT))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    EXPORT STRING14 did := '' : STORED('DID');
    EXPORT BOOLEAN IncludeAllCriminalRecords := FALSE :STORED('IncludeAllCriminalRecords');
    EXPORT BOOLEAN IncludeSexualOffenses := FALSE :STORED('IncludeSexualOffenses');
    EXPORT STRING25 doc_number := ''; //TODO: Create IParam attribute
    EXPORT STRING60 offender_key := '';
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(report_opt.FFDOptionsMask);
    EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    EXPORT BOOLEAN SkipPersonContextCall := FALSE;
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(report_opt.FCRAPurpose);
  END;

  results := CriminalRecords_Services.ReportService_Records.val(tempmod, isFCRA);
    
  // iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp, results,
                // iesp.criminal_fcra.t_FcraCriminalReportResponse);

  OUTPUT(results, NAMED('Results'));

ENDMACRO;
