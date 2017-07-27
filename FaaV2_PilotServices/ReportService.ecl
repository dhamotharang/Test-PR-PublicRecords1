/*--SOAP--
<message name="ReportService">
	<part name="did"              type="xsd:string"/>
	<part name="FAAPilotRecordId" type="xsd:string"/>
	<part name="LetterCode"       type="xsd:string"/>
  <part name="AirmenId"         type="xsd:integer"/>

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>

	<part name="PilotReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns FAA Pilot report records.*/

// so in general approach is 
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.

import iesp, AutoStandardI;
export ReportService := macro

		rec_in := iesp.faapilot.t_PilotReportRequest;
    ds_in := DATASET ([], rec_in) : STORED ('PilotReportRequest', FEW);
		first_row := ds_in[1] : independent;
		
    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);

    //set main search criteria:
    report_by := global (first_row.ReportBy);		
		#stored ('FAAPilotRecordId', report_by.FAAPilotRecordId);
		// #stored ('LetterCode', report_by.LetterCode);
		
	glbMod := AutoStandardI.GlobalModule();
	tempmod := module(project(glbMod, FaaV2_PilotServices.ReportService_Records.params,opt))
		export string8 unique_id := '' : stored('FAAPilotRecordId');
		export string1 letter_code := '' : stored('LetterCode');
		export unsigned6 airmen_id := 0 : stored('AirmenId');
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(glbMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;
	
	results := FaaV2_PilotServices.ReportService_Records.val(tempmod);
	
		output(results, named('Results'));							
endmacro;
// ReportService ();
/*
<PilotReportRequest>
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
		<FAAPilotRecordId></FAAPilotRecordId>
	</ReportBy>
</row>
</PilotReportRequest>
*/