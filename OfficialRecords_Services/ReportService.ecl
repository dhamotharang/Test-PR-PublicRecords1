/*--SOAP--
<message name="ReportService">

	<!-- User Section -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="ApplicationType"     type="xsd:string"/>
	
	<!-- SEARCH FIELDS -->
  <part name="OfficialRecordId"		 type="xsd:string"/>
  
	<part name="OfficialRecReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Return Official Records information in a report format for a certain OfficialRecordId.*/

import iesp;

export ReportService := macro

  // Get XML input 
  rec_in := iesp.officialrecord.t_OfficialRecReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('OfficialRecReportRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
	report_by := global (first_row.ReportBy);
  #stored ('OfficialRecordId', report_by.OfficialRecordId);

  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params, OfficialRecords_Services.Report_Records.params,opt));
	  export string60  OfficialRecordId := '' : stored('OfficialRecordId');
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	temp := OfficialRecords_Services.Report_Records.val(tempmod);
 
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp, results, 
                iesp.officialrecord.t_OfficialRecReportResponse, OfficialRecords, true);

  //Uncomment line below as needed to assist in debugging
  //output(temp,named('rs_temp'));

  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//ReportService ();
/*
<OfficialRecReportRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<ReportBy>
  <OfficialRecordId></OfficialRecordId>
</ReportBy>
</row>
</OfficialRecReportRequest>
*/
