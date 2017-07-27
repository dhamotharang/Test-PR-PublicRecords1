/*--SOAP--
<message name="Areacode_SearchService">

	<!-- Search fields -->
  <part name="Areacode"   	     			type="xsd:string"/>
  <part name="City"   	     			type="xsd:string"/>
  <part name="State"	       			type="xsd:string"/>
  <part name="Zip" 	        			type="xsd:string"/>
  <part name="StateCityZip"				type="xsd:string"/>
	<!-- Existing options -->
	<part name="ReturnCount"         type="xsd:unsignedInt"/>
	<part name="StartingRecord"      type="xsd:unsignedInt"/>
	
  <part name="AreaCodeSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Search for Areacode information via Areacode, City, State, Zip or City+State. */
Import doxie,iesp,AutoStandardI,Address;
export Areacode_SearchService() := macro

	STRING3 inAreacode:='':STORED('Areacode');
	STRING28 inCity:='':STORED('City');
	STRING2 inState:='':STORED('State');
	STRING5 inZip:='':STORED('Zip');
	STRING50 inStateCityZip:='':STORED('StateCityZip');
	
	rec_in := iesp.Areacode.t_AreaCodeSearchRequest;
	
	ds_in := DATASET([],rec_in) : STORED('AreaCodeSearchRequest',FEW);
	request := ds_in[1] : INDEPENDENT;
	// set compliance from iesp XML input
	User := GLOBAL(request.User);
	iesp.ECL2ESP.SetInputUser(User);

	// set XML input
	SearchBy := GLOBAL(request.SearchBy);
	Options  := GLOBAL(request.Options);
	
	stateCityZip := MAP(length(trim(inStateCityZip))>0 => inStateCityZip,
											length(trim(SearchBy.StateCityZip))>0 => SearchBy.StateCityZip,
											'');
	clean_addr := Address.GetCleanAddress('', stateCityZip, address.Components.Country.US).results;
	
	//Create passed in parameters
	inrecMod := MODULE(Lookup_Services.Areacode_IParam.searchParams)
		EXPORT STRING3	 AreaCode := MAP(length(trim(inAreacode))>0 => inAreaCode,
		                                 length(trim(SearchBy.AreaCode))>0 => SearchBy.AreaCode,
																		 '');
		EXPORT STRING28  City  := MAP(length(trim(inCity))>0 => stringlib.StringToUpperCase(inCity),
														      length(trim(SearchBy.City))>0 => stringlib.StringToUpperCase(SearchBy.City),	
																	clean_addr.v_city);
		EXPORT STRING2   State := MAP(length(trim(inState))>0 => stringlib.StringToUpperCase(inState),
		                              length(trim(SearchBy.State))>0 => stringlib.StringToUpperCase(SearchBy.State),
																	clean_addr.state);
		EXPORT STRING5   Zip   := MAP(length(trim(inZip))>0 => inZip,
																	length(trim(SearchBy.Zip5))>0 => SearchBy.Zip5,
																	clean_addr.zip);
	END;
	
	// compute results
	tempresults := Lookup_Services.Areacode_records(inrecMod);
	// standard record counts & limits
	//doxie.MAC_Header_Field_Declare()

	iesp.ECL2ESP.Marshall.Mac_Set(GLOBAL(request.Options));
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults,results,
		iesp.Areacode.t_AreaCodeSearchResponse,Records,false);


	// display results
	output(results, named('Results'));
	
endmacro;
//Areacode_SearchService();