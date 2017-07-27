/*--SOAP--
<message name="ReportService">

	<!-- User Section -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>
		
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="SSNMask" 							type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<!-- SEARCH FIELDS -->
  <part name="UnParsedFullName"    type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="NameSuffix"				   type="xsd:string"/>
  <part name="PrimaryKey"			     type="xsd:string"/>

  <!-- Internal testing search field -->
	<part name="did" 							   type="xsd:string"/>
	
  <!-- Options -->
	<part name="AllowGraphicDescription"		 type="xsd:boolean"/>
	<part name="IncludeBestAddress"   type="xsd:boolean"/>
		
  <part name="SexOffReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Return Sex Offender information in a report format.*/

import iesp, AutoStandardI;

export ReportService := macro

  // Get XML input 
  rec_in := iesp.sexualoffender.t_SexOffReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('SexOffReportRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	// add coding to additional options for name searching options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
	report_by := global (first_row.ReportBy);
	options		:= global (first_row.Options);

	//Do not need to store name fields since they are not used in prod/moxie even though
	//they are on the moxie (wsonline) search form.

	//Store "report-by" fields into soap names to be used below
  #stored ('PrimaryKey', report_by.PrimaryKey);
  #stored('did', report_by.UniqueId);
  #stored('AllowGraphicDescription', options.AllowGraphicDescription);
  #stored('IncludeBestAddress', options.IncludeBestAddress);
	
	glbMod := AutoStandardI.GlobalModule();
	tempmod := module(project(glbMod, SexOffender_Services.IParam.report,opt));
	  export string60 Primary_Key							:= ''			: stored('PrimaryKey');
	  export boolean	AllowGraphicDescription	:= false	: stored('AllowGraphicDescription');
	  export boolean include_bestaddress := false : stored('IncludeBestAddress');
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(glbMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	temp := SexOffender_Services.ReportRecords.val(tempmod);
 
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp, results, 
                iesp.sexualoffender.t_SexOffReportResponse, SexualOffenses, true);

  //Uncomment line below as needed to assist in debugging
  //output(temp,named('rs_temp'));

  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//ReportService ();
/*
<SexOffReportRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <ApplicationType></ApplicationType>
  <SSNMask></SSNMask>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<Options>
  <AllowGraphicDescription></AllowGraphicDescription>
</Options>
<ReportBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <PrimaryKey></PrimaryKey>
  <UniqueId></UniqueId>
</ReportBy>
</row>
</SexOffReportRequest>
*/