// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Return Official Records information in a report format for a certain OfficialRecordId.*/

IMPORT iesp;

EXPORT ReportService := MACRO

  // Get XML input
  rec_in := iesp.officialrecord.t_OfficialRecReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('OfficialRecReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  report_by := GLOBAL (first_row.ReportBy);
  #STORED ('OfficialRecordId', report_by.OfficialRecordId);

  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params, OfficialRecords_Services.Report_Records.params,OPT));
    EXPORT STRING60 OfficialRecordId := '' : STORED('OfficialRecordId');
    EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
  END;

  temp := OfficialRecords_Services.Report_Records.val(tempmod);
 
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp, results,
                iesp.officialrecord.t_OfficialRecReportResponse, OfficialRecords, TRUE);

  //Uncomment line below as needed to assist in debugging
  //output(temp,named('rs_temp'));

  OUTPUT(results,NAMED('Results'));

ENDMACRO;
