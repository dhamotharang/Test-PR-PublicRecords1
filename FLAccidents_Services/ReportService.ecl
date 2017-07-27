/*--SOAP--
<message name="SearchService">

	<!-- User Section -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
		
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	
	<!-- SEARCH FIELDS -->
  <part name="AccidentNumber"			 type="xsd:string"/>
  <part name="AccidentReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Return FL Accident information in a report format for a certain accident number.*/

import iesp, AutoStandardI;

export ReportService := macro

  // Get XML input 
  rec_in := iesp.accident.t_AccidentReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('AccidentReportRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
	report_by := global (first_row.ReportBy);
  #stored ('AccidentNumber', report_by.AccidentNumber);

  gmod := AutoStandardI.GlobalModule();
	tempmod := module(FLAccidents_Services.Report_Records.params)
	  export string9  Accident_Number := '' : stored('AccidentNumber');
    export boolean mask_dl := AutoStandardI.InterfaceTranslator.dl_mask_value.val(project(gmod,AutoStandardI.InterfaceTranslator.dl_mask_value.params)); 
		export string32	ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(gmod,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	temp := FLAccidents_Services.Report_Records.val(tempmod);
 
  // Since the result being returned from Report_Records immediately above in temp 
	// is just one record (see the iesp.accident.t_AccidentReportResponse) and does not
	// contain a dataset, then "...temp[1]..." was used below.
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp[1], results, 
	                            iesp.accident.t_AccidentReportResponse, AccidentRecord, true);

  //Uncomment line below as needed to assist in debugging
  //output(temp,named('rs_temp'));

  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//ReportService ();
/*
<AccidentReportRequest>
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
  <AccidentNumber></AccidentNumber>
</ReportBy>
</row>
</AccidentReportRequest>
*/
