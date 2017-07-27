/*--SOAP--
<message name="InstantIDArchiveSearchRequest"  wuTimeout="300000">	
	<part name="gateways" 						type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="_CompanyId"  					type="xsd:string"/>
	<part name="InstantIDArchiveSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

IMPORT AutoStandardI, iesp, InstantID_Archiving_Services;

EXPORT Search_Service := MACRO

  rec_in     := iesp.iidarchivesearch.t_InstantIDArchiveSearchRequest;
	ds_in      := DATASET([],rec_in) : STORED('InstantIDArchiveSearchRequest',few);	

  first_row := ds_in[1] : INDEPENDENT;

	search_by := GLOBAL (first_row.SearchBy);
	report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, SELF := Left; SELF := []));
  iesp.ECL2ESP.SetInputReportBy (report_by);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);

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
		EXPORT STRING 	 NationalId    := search_by.NationalId;
		EXPORT STRING 	 CompanyId     := first_row.user.CompanyId : STORED('_CompanyId');	
	END;
	
	// Gateway configurations
	dGateways := Gateway.Configuration.Get();
	results := InstantID_Archiving_Services.Search_Records.doSingleSearch(tempmod, dGateways);
	output(results, named('Results'));
	
ENDMACRO;
