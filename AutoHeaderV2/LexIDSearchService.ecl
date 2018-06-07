/*--SOAP--
<message name="LexIDSearchService" fast_display = "true">
	<part name="LexIDSearchRequest" type="tns:XmlDataSet" cols="80" rows="20" />
	<part name="SearchCode" type="xsd:integer" />
</message>
*/

/*--INFO-- This service searches the header file.<br>Quick header excluded.*/


import AutoheaderV2,WSInput;

EXPORT LexIDSearchService () := FUNCTION
  
	 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
  ds_search := DATASET ([], AutoheaderV2.layouts.lib_search) : STORED ('LexIDSearchRequest', FEW);
  search_code := 0 : stored ('SearchCode');

  lib_res := LIBRARY (AutoheaderV2.Constants.SearchLibraryName, AutoheaderV2.ILIB.IHeaderSearch (ds_search, search_code));

  output (lib_res._input, named ('search_input'));
  output (lib_res.results, named ('search_results'));
  output (lib_res.messages, named ('search_diagnostics'));
	
	//The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_AutoHeaderV2_LexIDSearchService();

  return 0;
END;
