/*--SOAP--
<message name="ReportService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="CaseId"              type="xsd:string"/>

	<!-- User -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
	
  <part name="CivilCourtReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- Returns Civil Court reports records.*/

import CivilCourt_services, iesp, AutoStandardI;
export ReportService := macro
		
		rec_in := iesp.CivilCourt.t_CivilCourtReportRequest;
    ds_in := DATASET ([], rec_in) : STORED ('CivilCourtReportRequest', FEW);
		first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);

    //set main search criteria:
    report_by := global (first_row.ReportBy);		
		#stored ('CaseId', report_by.caseId);
							
	tempmod := module(project(AutoStandardI.GlobalModule(),
	                    CivilCourt_services.ReportService_Records.params,opt))
			shared string60 caseID_mixed := '' : stored('CaseId');
			shared string60 caseID := stringlib.StringToUpperCase(caseID_mixed);
	
	end;
	
	  tmp := CivilCourt_services.ReportService_Records.val(tempmod);
		
		temp_results := project(tmp,  transform(iesp.civilCourt.t_CivilCourtReportResponse ,
		           self._Header := iesp.ECL2ESP.GetHeaderRow(),	
							 self.CivilCourtRecord  := left));
		results := Choosen(temp_results, iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
		output(results, named('Results'));			
endmacro;
//ReportService ();
/*
<CivilCourtReportRequest>
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
		<CaseId></CaseId>
	</ReportBy>
</row>
</CivilCourtReportRequest>
*/