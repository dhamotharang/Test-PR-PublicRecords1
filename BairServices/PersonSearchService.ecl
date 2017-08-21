/*--SOAP--
<message name="PersonSearchService">
  <part name="BAIRPersonSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/

EXPORT PersonSearchService := MACRO
	import iesp, BairRx_Common,BairRx_PSS;
	dIn := DATASET([], iesp.bair_person.t_BAIRPersonSearchRequest) : STORED('BAIRPersonSearchRequest', FEW);
	first_row := dIn[1] : independent;	
	options := GLOBAL(first_row.options);
	user := GLOBAL(first_row.user);
	searchBy := GLOBAL(first_row.searchBy);
	
	BairRx_PSS.IParam.SetInputOptions(options);	
	BairRx_PSS.IParam.SetInputUser(user);
	// BairRx_PersonSearch.IParam.SetInputSearchBy(searchBy);	
	
	input_params := BairRx_PSS.IParam.GetPersonSearchParams(searchBy, options, user); 	
	dSrchRecs := BairRx_PSS.PersonSearchRecords(input_params);	
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchRecs, results, iesp.bair_person.t_BAIRPersonSearchResponse);
	output(results, named('Results'));

ENDMACRO;