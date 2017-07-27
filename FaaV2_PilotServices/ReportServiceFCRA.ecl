/*--SOAP--
<message name="ReportServiceFCRA">
	
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="did"                   type="xsd:string"/>
	<part name="FcraPilotReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
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

import iesp, AutoStandardI,FaaV2_PilotServices, FFD;
export ReportServiceFCRA := macro

	rec_in := iesp.faapilot_fcra.t_FCRAPilotReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraPilotReportRequest', FEW);
	first_row := ds_in[1] : independent;
		
  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  report_by := global (first_row.ReportBy);		
	#stored ('DID', report_by.UniqueId);
		
	glbMod := AutoStandardI.GlobalModule(true);
	tempmod := module(project(glbMod, FaaV2_PilotServices.ReportService_Records.params,opt))
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(glbMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
    export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
	end;
	
	results := FaaV2_PilotServices.ReportService_Records.Fcra_val(tempmod);
		
	output(results, named('Results'));							
								
endmacro;
 // ReportServiceFCRA ();
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