﻿/*--SOAP--
<message name="SearchService"  wuTimeout="300000">
  <part name="EmailSearchV2SearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>
  <separator />
  <part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/

EXPORT SearchService :=
MACRO
  IMPORT iesp,EmailV2_Services;
  
  #WEBSERVICE(FIELDS(
    'EmailSearchV2Request',
    'gateways'
  ));
  
  // Input request
  in_req := DATASET([], iesp.emailsearchv2.t_EmailSearchV2Request) : STORED('EmailSearchV2Request');
  
  first_row := in_req[1] : INDEPENDENT;
  search_by := GLOBAL(first_row.SearchBy);
  search_options := GLOBAL(first_row.Options);
  
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.SetInputReportBy(ROW(search_by, TRANSFORM(iesp.bpsreport.t_BpsReportBy, SELF := LEFT, SELF := [])));
  iesp.ECL2ESP.SetInputSearchOptions (search_options);

  in_mod := EmailV2_Services.IParams.getSearchParams(search_options);
  
  rpt := EmailV2_Services.Search_Records(search_by, in_mod);
  IF(EXISTS(rpt.Response.Records), doxie.Compliance.logSoldToTransaction(in_mod));
  OUTPUT(rpt.Response, named('Results'));
  OUTPUT(rpt.Royalties, named('RoyaltySet'));
  
ENDMACRO;

