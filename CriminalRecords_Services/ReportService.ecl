// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service pulls from the Criminal Offenders file.*/
IMPORT iesp, AutoStandardI;

EXPORT ReportService := MACRO
rec_in := iesp.criminal.t_CrimReportRequest;
ds_in := DATASET([], rec_in) : STORED('CrimReportRequest', few);
first_row := ds_in[1] : INDEPENDENT;

iesp.ECL2ESP.SetInputBaseRequest(first_row);
report_opt := GLOBAL (first_row.Options);
// read specific for this query input (Note: DOCNumber isn't used by ESP for report).
report_by := GLOBAL (first_row.ReportBy);

iesp.ECL2ESP.SetInputName(report_by.Name);

#STORED('OffenderKey', report_by.OffenderId);
#STORED('IncludeAllCriminalRecords', report_opt.IncludeAllCriminalRecords);
#STORED('IncludeSexualOffenses', report_opt.IncludeSexualOffenses);
#STORED ('DID',report_by.UniqueId);
// used only for SOAP testing
input_params := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
tempmod := MODULE(PROJECT(input_params,CriminalRecords_Services.IParam.report,OPT))
  doxie.compliance.MAC_CopyModAccessValues(mod_access);
  EXPORT STRING25 doc_number := '' : STORED('DOCNumber');
  EXPORT STRING60 offender_key := '' : STORED('OffenderKey');
  EXPORT BOOLEAN IncludeAllCriminalRecords := FALSE :STORED('IncludeAllCriminalRecords');
  EXPORT BOOLEAN IncludeSexualOffenses := FALSE :STORED('IncludeSexualOffenses');
END;

ds_res := CriminalRecords_Services.ReportService_Records.val(tempmod);
results := PROJECT(ds_res, iesp.criminal.t_CrimReportResponse);

OUTPUT(results, NAMED('Results'));

ENDMACRO;
//Interface is wrong
//Name fields should not be in the interface as they don't seem to be used by the search
//Julie

// ReportService();
