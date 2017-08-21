/*--SOAP--
<message name="PhoneSearchService">
  <part name="BAIRPersonSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/

/*--INFO--
<hr>
This query will search for phones in crash and event datasources.
<br>The primary search is performed using SALT. 
<br>If option <i>SearchPhonesInNarratives</i> is selected, it will also match against phone numbers parsed from incident narratives.
<hr>
*/
EXPORT PhoneSearchService := MACRO
	import iesp, BairRx_Common;
	dIn := DATASET([], iesp.bair_phonesearch.t_BAIRPhoneSearchRequest) : STORED('BAIRPhoneSearchRequest', FEW);
	first_row := dIn[1] : independent;	
	options := GLOBAL(first_row.options);
	user := GLOBAL(first_row.user);
	searchBy := GLOBAL(first_row.searchBy);
	
	BairRx_PSS.IParam.SetInputOptions(options);	
	BairRx_PSS.IParam.SetInputUser(user);
		
	input_params := BairRx_PSS.IParam.GetPhoneSearchParams(searchBy, options, user); 	
	dSrchRecs := BairRx_PSS.PhoneSearchRecords(input_params);	
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchRecs, results, iesp.bair_phonesearch.t_BAIRPhoneSearchResponse);

	output(results, named('Results'));


ENDMACRO;