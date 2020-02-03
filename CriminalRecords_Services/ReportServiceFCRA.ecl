/*--SOAP--
<message name="CriminalRecords::ReportService">

  <!-- Keyed Fields -->
  <part name="DID"               type="xsd:string"/>
 
  <!-- Tuning -->
  <part name="PenaltThreshold"  type="xsd:unsignedInt"/>
  <part name="IncludeAllCriminalRecords"  type="xsd:boolean"/>
  <part name="IncludeSexualOffenses"  type="xsd:boolean"/>
    
  
  <!-- Compliance Settings -->
  <part name="DPPAPurpose"      type="xsd:byte"/>
  <part name="GLBPurpose"       type="xsd:byte"/>
  <part name="SSNMask"          type="xsd:string"/>
  <part name="DLMask"           type="xsd:string"/>
  <part name="ApplicationType"  type="xsd:string"/>
  <part name="FCRAPurpose" type="xsd:string"/>
  
  <!-- Record Management -->
  <part name="MaxResults"         type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords"        type="xsd:unsignedInt"/>
  
  <!-- Gateway Input -->
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>

  <!-- XML Input -->
  <part name="FcraCriminalReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
  
  
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/
import iesp, AutoStandardI, FFD, Gateway;

export ReportServiceFCRA := MACRO
  boolean isFCRA := true;
  
  // Get XML input
  rec_in    := iesp.criminal_fcra.t_FcraCriminalReportRequest;
  ds_in      := dataset([], rec_in) : STORED('FcraCriminalReportRequest', few);
  first_row  := ds_in[1] : INDEPENDENT;
  
  // set options
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  
  // set main search criteria
  report_opt   := global (first_row.Options);
  report_by := global (first_row.ReportBy);
  
  //Store "report-by" fields into soap names to be used below for SOAP testing
  #stored('IncludeAllCriminalRecords', report_opt.IncludeAllCriminalRecords);
  #stored('IncludeSexualOffenses', report_opt.IncludeSexualOffenses);
  #stored ('DID', report_by.UniqueId);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  // used only for SOAP testing
  tempmod := module(project(input_params,CriminalRecords_Services.IParam.report,opt))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    export string14   did                       := '' : STORED('DID');
    export boolean    IncludeAllCriminalRecords := false :STORED('IncludeAllCriminalRecords');
    export boolean    IncludeSexualOffenses     := false :STORED('IncludeSexualOffenses');  
    export string25   doc_number      := ''; //TODO: Create IParam attribute
    export string60   offender_key    := '';
    EXPORT integer8   FFDOptionsMask  := FFD.FFDMask.Get(report_opt.FFDOptionsMask);
    export dataset(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    export boolean    SkipPersonContextCall := false;    
    export integer FCRAPurpose := FCRA.FCRAPurpose.Get(report_opt.FCRAPurpose);  
  end;

  results := CriminalRecords_Services.ReportService_Records.val(tempmod, isFCRA);
    
  // iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp, results, 
                // iesp.criminal_fcra.t_FcraCriminalReportResponse);

  output(results, named('Results'));

endmacro;
