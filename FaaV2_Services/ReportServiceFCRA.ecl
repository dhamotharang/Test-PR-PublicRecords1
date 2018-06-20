/*--SOAP--
<message name="ReportServiceFCRA">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
 <part name="FCRAPurpose"         type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>
	<part name="MaxWaitSeconds"      type="xsd:integer"/>

	<!-- User -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
	
  <part name="FcraAircraftReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- Returns FAA Aircraft reports records.*/

// so in general approach is 
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.

import FaaV2_services, iesp, AutoStandardI, FFD;
export ReportServiceFCRA := macro

  #constant('NoDeepDive', true);
	
  rec_in := iesp.faaaircraft_fcra.t_FcraAircraftReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraAircraftReportRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  report_by := global (first_row.ReportBy);
	
  #stored('DID',report_by.uniqueid);
	
  input_params := AutoStandardI.GlobalModule(true);
  tempmod := module(project(input_params, FaaV2_Services.ReportService_Records.params,opt))
    export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  end;
	
  recs := FaaV2_Services.ReportService_Records.fcra_val(tempmod);
	
  input_consumer := FFD.MAC.PrepareConsumerRecord(tempmod.did, true, , report_by.uniqueid);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs.records, results_pre, iesp.faaaircraft_fcra.t_FcraAircraftReportResponse, Aircrafts, true);
	 
  FFD.MAC.AppendConsumerAlertsAndStatements(results_pre, results, recs.Statements, recs.ConsumerAlerts, input_consumer, iesp.faaaircraft_fcra.t_FcraAircraftReportResponse);
  
  output(results, named('Results'));							
		
endmacro;
 // ReportServiceFCRA ();
/*
<AircraftReportRequest>
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
		<AircraftNumber></AircraftNumber>
		<UniqueId></UniqueId>
	</ReportBy>
</row>
</AircraftReportRequest>
*/