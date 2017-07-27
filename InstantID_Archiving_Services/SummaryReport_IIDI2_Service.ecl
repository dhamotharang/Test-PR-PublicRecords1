/*--SOAP--
<message name="InstantIDInternationalSummaryReportRequest"  wuTimeout="300000">	
	<part name="gateways" 						type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="_CompanyId"  					type="xsd:string"/>
	<part name="InstantIDIntl2SummaryReportRequest" 	type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

IMPORT InstantId_Archiving_Services, AutoStandardI, iesp;

EXPORT SummaryReport_IIDI2_Service := MACRO

  rec_in     := iesp.iidi2summary.t_InstantIDIntl2SummaryReportRequest;
	ds_in      := DATASET([],rec_in) : STORED('InstantIDIntl2SummaryReportRequest',few);	

  first_row := ds_in[1] : INDEPENDENT;
	
	search_by := GLOBAL (first_row.SearchBy);
	report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, SELF := Left; SELF := []));
  iesp.ECL2ESP.SetInputReportBy (report_by);
	
	// set User, Base and generic search options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.SetInputSearchOptions (PROJECT(first_row.options,TRANSFORM(iesp.share.t_BaseSearchOptionEx, SELF := LEFT, SELF := [])));

  // store search options not handled by iesp.ECL2ESP
  search_options := GLOBAL (first_row.Options);
	
	input_params := AutoStandardI.GlobalModule();
	tempmod := MODULE(PROJECT(input_params, InstantId_Archiving_Services.IParam.IIDI2_summary_params, opt));
		EXPORT STRING8 	 StartDate  := iesp.ECL2ESP.t_DateToString8(search_by.SummaryDateRange.StartDate);
		EXPORT STRING8 	 EndDate 		:= iesp.ECL2ESP.t_DateToString8(search_by.SummaryDateRange.EndDate);
		EXPORT STRING 	 CompanyId  := first_row.user.CompanyId : STORED('_CompanyId');	
		EXPORT STRING 	 CountryId  := search_by.Country : STORED('Country');	
	END;
	
	// Gateway configurations
	dGateways := Gateway.Configuration.Get();
	
	Results := InstantId_Archiving_Services.SummaryReport_IIDI2_Records.doSummaryIIDI2Report(tempmod, dGateways);
	output(Results, named('Results'));

ENDMACRO;
