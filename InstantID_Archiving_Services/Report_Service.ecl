/*--SOAP--
<message name="InstantIDArchiveSingleReportRequest"  wuTimeout="300000">	
	<part name="gateways" 						type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="_CompanyId"  					type="xsd:string"/>
	<part name="InstantIDArchiveSingleReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

IMPORT AutoStandardI, iesp, InstantID_Archiving_Services, Gateway;

EXPORT Report_Service := MACRO

  rec_in     := iesp.iidsinglereport.t_InstantIDArchiveSingleReportRequest;
	ds_in      := DATASET([],rec_in) : STORED('InstantIDArchiveSingleReportRequest',few);	
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
	tempmod := MODULE(PROJECT(input_params, InstantID_Archiving_Services.IParam.search_params, opt));
		EXPORT string 	 ProductType   := search_options.ProductType;
		EXPORT STRING 	 QueryId       := search_by.QueryId;
		EXPORT STRING 	 UniqueId      := search_by.UniqueId;
		EXPORT STRING 	 TransactionId := search_by.TransactionId;	
		EXPORT STRING 	 NationalId    := search_by.NationalId;
		EXPORT STRING 	 CompanyId     := first_row.user.CompanyId : STORED('_CompanyId');	
	END;
	// Gateway configurations
	dGateways := Gateway.Configuration.Get();
	
	results := InstantID_Archiving_Services.Report_Records.doSingleReport(tempmod, dGateways);
	output(results, named('Results'));
	
ENDMACRO;	
