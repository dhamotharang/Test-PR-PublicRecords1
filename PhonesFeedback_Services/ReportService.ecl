/*--SOAP--
<message name="SearchService">
  <part name="Phone" type="xsd:string"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="PhonesfeedbackReportRequest" type="tns:XmlDataSet" cols="50" rows="10" />
</message>
*/
/*--INFO-- This service Returns Phones Feedback Information.*/

IMPORT PhonesFeedback_Services,PhonesFeedback,autostandardI,iesp;
EXPORT ReportService := MACRO

  rec_in := iesp.phonesfeedback.t_PhonesFeedbackReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('PhonesfeedbackReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  report_by := GLOBAL (first_row.ReportBy);
  #STORED('phone', report_by.Phone);
  #STORED('DID', report_by.UniqueId);
  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,PhonesFeedback_Services.ReportService_Records.params,OPT))
    EXPORT STRING15 Phone_number :='' :STORED('Phone');
    EXPORT STRING12 in_DID :='' :STORED('DID');
  END;

  res := PhonesFeedback_Services.ReportService_Records.val(tempmod);
  // iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, results, iesp.phonesfeedback.t_PhonesFeedbackSearchResponse);
  // output(results, named('Results'));
  OUTPUT(res, NAMED('Results'));
  // output(tempmod);
ENDMACRO;
