// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT AutoStandardI, Doxie, FCRA, FFD, Gateway, iesp;

EXPORT PossibleIncarcerationReportServiceFCRA := MACRO

  BOOLEAN isFCRA := TRUE;

  rec_in := iesp.criminal_possibleincarceration_fcra.t_FcraPossibleIncarcerationReportRequest;
  ds_in := DATASET([], rec_in) : STORED('FcraPossibleIncarcerationReportRequest', few);
  first_row := ds_in[1] : INDEPENDENT;

  iesp.ECL2ESP.SetInputBaseRequest(first_row);

  report_opt := GLOBAL(first_row.Options);
  report_by := GLOBAL(first_row.ReportBy);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  tempmod := MODULE(PROJECT(mod_access, CriminalRecords_Services.IParam.incarceration_report, OPT))
    EXPORT UNSIGNED8 did := (UNSIGNED8) report_by.UniqueID;
    EXPORT BOOLEAN ReturnDocName := report_opt.ReturnDocName;
    EXPORT BOOLEAN ReturnSSN := report_opt.ReturnSSN;
    EXPORT INTEGER FFDOptionsMask := FFD.FFDMask.Get(report_opt.FFDOptionsMask);
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(report_opt.FCRAPurpose);
    EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
  END;

  results := CriminalRecords_Services.PossibleIncarcerationReport_Records(tempmod, isFCRA);

  OUTPUT(results, NAMED('Results'));

ENDMACRO;
