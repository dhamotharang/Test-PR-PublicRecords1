/*--SOAP--
<message name="SearchService" wuTimeout="300000">
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <separator />
  <part name="AddressSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Searches for Address Report*/


import iesp, Address_Services;
EXPORT SearchService := MACRO

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AddrServices_SearchService();
  
  rec_in := iesp.Addresssearch.t_AddressSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('AddressSearchRequest', FEW);
  
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
  SearchBy := global (first_row.SearchBy);
  
  //for testing purposes
  STRING200 Addr := '' : STORED('Addr');
  string25 City := '' : STORED('City');
  string2 State := '' : STORED('State');
  string6 Zip := '' : STORED('Zip');
  StoredInput := dataset([{'', '', '', '', '', '', '', Addr, '' , City, State, Zip, '', '', '', ''}], iesp.addresssearch.t_AddressSearchBy);
  
  addr_in := if(SearchBy <> row([], iesp.Addresssearch.t_AddressSearchBy), dataset(SearchBy), StoredInput);
  BOOLEAN streetNotBlank := ( addr_in[1].Address.StreetNumber <> '' and addr_in[1].Address.StreetName <> '') OR addr_in[1].Address.StreetAddress1 <> '';
  BOOLEAN isEnoughInput := streetNotBlank and ((addr_in[1].Address.City <> '' and addr_in[1].Address.State <> '') or addr_in[1].Address.Zip5 <> '');
  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

  recs := Address_Services.SearchRecords (addr_in, mod_access);
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs, results, iesp.addresssearch.t_AddressSearchResponse, Addresses);
  
  if(~isEnoughInput,
    FAIL(310, doxie.ErrorCodes(310)),
    output(results, named ('Results')));
ENDMACRO;
