/*--SOAP--
<message name="ReportServiceFCRA">

  <!-- User Section -->
  <part name="ReferenceCode" type="xsd:string"/>
  <part name="BillingCode" type="xsd:string"/>
  <part name="QueryId" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>

  <!-- COMPLIANCE SETTINGS -->
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="FCRAPurpose" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="MaxWaitSeconds" type="xsd:integer"/>

  <!-- FCRA REPORT FIELD -->
  <part name="DID" type="xsd:string"/>

  <!-- Options -->
  <part name="AllowGraphicDescription" type="xsd:boolean"/>

  <part name="FcraSexOffenderReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Return Sex Offender information in a report format.*/

IMPORT doxie, iesp, AutoStandardI, FFD;

EXPORT ReportServiceFCRA := MACRO
  BOOLEAN isFCRA := TRUE;
  #CONSTANT('NoDeepDive', TRUE);

  // Get XML input
  rec_in := iesp.sexualoffender_fcra.t_FcraSexOffenderReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraSexOffenderReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  // add coding to additional options for name searching options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  report_by := GLOBAL (first_row.ReportBy);
  options := GLOBAL (first_row.Options);
  //Do not need to store name fields since they are not used in prod/moxie even though
  //they are on the moxie (wsonline) search form.

  //Store "report-by" fields into soap names to be used below
  #STORED('AllowGraphicDescription', options.AllowGraphicDescription);
  #STORED('IncludeBestAddress', options.IncludeBestAddress);

  glbMod := AutoStandardI.GlobalModule(isFCRA);
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(glbMod);
  tempmod := MODULE(PROJECT(mod_access, SexOffender_Services.IParam.report,OPT))
    STRING14 soap_did := '' : STORED('DID');
    EXPORT STRING14 DID := IF(report_by.UniqueId <> '', report_by.UniqueId, soap_did);
    EXPORT BOOLEAN AllowGraphicDescription := FALSE : STORED('AllowGraphicDescription');
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  END;

  temp := SexOffender_Services.ReportRecords.fcra_val(tempmod);
  input_consumer := FFD.MAC.PrepareConsumerRecord(tempmod.did, TRUE, , report_by.UniqueId);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp.Records, results,
    iesp.sexualoffender_fcra.t_FcraSexOffenderReportResponse, SexualOffenses, TRUE);
 // transform to FCRA FFD layout
  FFD.MAC.AppendConsumerAlertsAndStatements(results, out_results, temp.Statements, 
    temp.ConsumerAlerts, input_consumer, iesp.sexualoffender_fcra.t_FcraSexOffenderReportResponse);

  OUTPUT(out_results,NAMED('Results'));

ENDMACRO;
