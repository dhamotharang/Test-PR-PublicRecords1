/*--SOAP--
<message name="ReportService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     type="xsd:string"/>
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="AircraftNumber"      type="xsd:string"/>

	<!-- User -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
	
  <part name="AircraftReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
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

import FaaV2_services, iesp, AutoStandardI;
export ReportService := macro
		
		rec_in := iesp.faaaircraft.t_AircraftReportRequest;
    ds_in := DATASET ([], rec_in) : STORED ('AircraftReportRequest', FEW);
		first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);

    //set main search criteria:
    report_by := global (first_row.ReportBy);		
		#stored ('AircraftNumber', report_by.AircraftNumber);

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params, FaaV2_Services.ReportService_Records.params,opt))
			shared string8 n_number_mixed := '' : stored('AircraftNumber');
			shared string8 n_number := stringlib.StringToUpperCase(n_number_mixed);
			export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;
	
	  temp_res := FaaV2_Services.ReportService_Records.val(tempmod);

		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp_res, results, iesp.faaaircraft.t_AircraftReportResponse, Aircrafts, true);
   
		output(results, named('Results'));							
		
endmacro;
//ReportService ();
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
	</ReportBy>
</row>
</AircraftReportRequest>
*/