/*--SOAP--
<message name="FCRADataService"  wuTimeout="300000">
  <part name="UniqueID" type="xsd:integer"/>
  <separator />
  <part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <separator />
  <part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/

EXPORT FCRADataService :=
MACRO
  IMPORT doxie,ConsumerDisclosure,iesp,STD,WSInput;
  
  WSInput.MAC_FCRA_DataService();
  
  // Input request
  in_req := DATASET([], iesp.fcradataservice.t_FcraDataServiceRequest) : STORED('FcraDataServiceRequest');
  
  // Report request and options
  first_row := in_req[1] : INDEPENDENT;
  report_options := GLOBAL(first_row.options);
  report_by := GLOBAL(first_row.ReportBy);
  
  // For legacy purposes
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.SetInputReportBy(ROW(report_by, TRANSFORM(iesp.bpsreport.t_BpsReportBy, SELF := LEFT, SELF := [])));
  ConsumerDisclosure.IParams.SetInputUser(first_row.User);

  in_mod := ConsumerDisclosure.IParams.GetParams(report_options);
  in_dids := DATASET([{report_by.LexID}], doxie.layout_references);
  rpt := ConsumerDisclosure.ReportRecords(in_dids, in_mod);
  service_header := iesp.ECL2ESP.GetHeaderRow();
    
  iesp.fcradataservice.t_FcraDataServiceReportResponse xform() := TRANSFORM
    SELF._Header.QueryId       := service_header.QueryId;
    SELF._Header.TransactionId := service_header.TransactionId;
    SELF._Header.Status        := rpt.Status;
    SELF._Header.Message       := rpt.Message;
    SELF._Header.Exceptions    := rpt.Exceptions;
    SELF.Results      := rpt.Records;
    SELF.LexId        := report_by.LexID;
    SELF.RoxieCluster := STD.System.Thorlib.Cluster();                             
  END;
  outfile := DATASET([xform()]);
  
  OUTPUT(outfile, named('Results'));
  
ENDMACRO;