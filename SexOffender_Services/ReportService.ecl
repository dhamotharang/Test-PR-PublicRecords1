/*--SOAP--
<message name="ReportService">

  <!-- User Section -->
  <part name="ReferenceCode" type="xsd:string"/>
  <part name="BillingCode" type="xsd:string"/>
  <part name="QueryId" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
    
  <!-- COMPLIANCE SETTINGS -->
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="MaxWaitSeconds" type="xsd:integer"/>
  
  <!-- SEARCH FIELDS -->
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="NameSuffix" type="xsd:string"/>
  <part name="PrimaryKey" type="xsd:string"/>

  <!-- Internal testing search field -->
  <part name="did" type="xsd:string"/>
  
  <!-- Options -->
  <part name="AllowGraphicDescription" type="xsd:boolean"/>
  <part name="IncludeBestAddress" type="xsd:boolean"/>
    
  <part name="SexOffReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Return Sex Offender information in a report format.*/

IMPORT iesp, AutoStandardI;

EXPORT ReportService := MACRO

  // Get XML input
  rec_in := iesp.sexualoffender.t_SexOffReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('SexOffReportRequest', FEW);
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
  #STORED ('PrimaryKey', report_by.PrimaryKey);
  #STORED('did', report_by.UniqueId);
  #STORED('AllowGraphicDescription', options.AllowGraphicDescription);
  #STORED('IncludeBestAddress', options.IncludeBestAddress);
  
  glbMod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(glbMod);
  tempmod := MODULE(PROJECT(mod_access, SexOffender_Services.IParam.report,OPT))
    EXPORT STRING14 did := glbMod.did;
    EXPORT STRING60 Primary_Key := '' : STORED('PrimaryKey');
    EXPORT BOOLEAN AllowGraphicDescription := FALSE : STORED('AllowGraphicDescription');
    EXPORT BOOLEAN include_bestaddress := FALSE : STORED('IncludeBestAddress');
  END;

  temp := SexOffender_Services.ReportRecords.val(tempmod);
 
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp, results,
    iesp.sexualoffender.t_SexOffReportResponse, SexualOffenses, TRUE);

  //Uncomment line below as needed to assist in debugging
  //output(temp,named('rs_temp'));

  OUTPUT(results,NAMED('Results'));

ENDMACRO;
