// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    Return Accident information in a report format.<br/>
    Use EnableNationalAccidents [x] else Florida Accidents Only.
*/
IMPORT iesp, AutoStandardI, Accident_services, WSInput;

EXPORT ReportService := MACRO

 //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_Accident_Services_ReportService();

  #CONSTANT('StrictMatch', TRUE);

  //get XML input
  rec_in := iesp.accident.t_AccidentReportRequest;
  ds_in := DATASET([],rec_in) : STORED('AccidentReportRequest',FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  report_opt := GLOBAL(first_row.Options);
  #STORED('EnableNationalAccidents',report_opt.EnableNationalAccidents);
  #STORED('EnableExtraAccidents',report_opt.EnableExtraAccidents);

  //set search criteria
  report_by := GLOBAL(first_row.ReportBy);
  #STORED('AccidentNumber',report_by.AccidentNumber);
  #STORED('AccidentState',report_by.AccidentState);

  glbMod := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(glbMod,Accident_Services.IParam.searchrecords,opt));
    EXPORT STRING40 Accident_Number := '' : STORED('AccidentNumber');
    EXPORT STRING2 Accident_State := '' : STORED('AccidentState');
    EXPORT BOOLEAN EnableNationalAccidents := FALSE : STORED('EnableNationalAccidents');
    EXPORT BOOLEAN EnableExtraAccidents := FALSE : STORED('EnableExtraAccidents');
    EXPORT BOOLEAN mask_dl := AutoStandardI.InterfaceTranslator.dl_mask_value.val(
        PROJECT(glbMod,AutoStandardI.InterfaceTranslator.dl_mask_value.params));
  END;

  // ACCIDENT NUMBER REPORT
  accNbrRpt := IF(tempmod.Accident_Number!='',
    Accident_Services.Report_Records.accidentNmbr(tempmod),
    DATASET([],iesp.accident.t_AccidentReportRecord));

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(accNbrRpt[1],Results,
    iesp.accident.t_AccidentReportResponse,AccidentRecord,TRUE);

  OUTPUT(Results,NAMED('Results'));

ENDMACRO;
