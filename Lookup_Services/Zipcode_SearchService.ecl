/*--SOAP--
<message name="Zipcode_SearchService">

	<!-- Search fields -->
	<part name="StreetNumber"        type="xsd:string"/>
	<part name="StreetName"          type="xsd:string"/>
  <part name="City"   	     			 type="xsd:string"/>
  <part name="State"	       			 type="xsd:string"/>
  <part name="Zip" 	        			 type="xsd:string"/>
	<part name="SearchType"          type="xsd:string"/>//values['Addresses','Zip5s','Zip4s','Cities','']
	<!-- Existing options -->
	<part name="ReturnCount"         type="xsd:unsignedInt"/>
	<part name="StartingRecord"      type="xsd:unsignedInt"/>

  <part name="ZipCodeSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Search for zipcode related information via City, State, Zip or combinations of these.
<pre>
		Valid SearchType values are 
		-	Zips: List All Zip5s in a City+State combination or filter results on a particular StreetName and or StreetNumber
		-	Zip4s: List All Zip4s within a Zip5
		-	Cities: List All Cities within a Zip5
</pre>
*/

Import doxie,iesp,AutoStandardI,address;
export Zipcode_SearchService() := macro

	
	rec_in := iesp.Zipcode.t_ZipCodeSearchRequest;
	ds_in := DATASET([],rec_in) : STORED('ZipCodeSearchRequest',FEW);
	request := ds_in[1] : INDEPENDENT;
	// set compliance from iesp XML input
	User := GLOBAL(request.User);
	iesp.ECL2ESP.SetInputUser(User);

	// set XML input
	SearchBy := GLOBAL(request.SearchBy);
	Options  := GLOBAL(request.Options);
	iesp.ECL2ESP.SetInputAddress(SearchBy.Address,true);
	a := address.GetCleanAddress(SearchBy.Address.StreetAddress1,SearchBy.Address.City+' '+SearchBy.Address.State+' '+SearchBy.Address.Zip5,address.Components.Country.US).str_addr;
	clnAddr := Address.CleanFields(a);

	String10 inStreetNumber:='':STORED('StreetNumber');
	STRING28 inStreet:='':STORED('StreetName');
	STRING28 inCity:='':STORED('City');
	STRING2  inState:='':STORED('State');
	STRING5  inZip:='':STORED('Zip');
	STRING10 inSearchType:=SearchBy.SearchType:STORED('SearchType');
	boolean isAddressesSearch:=stringlib.StringToUpperCase(inSearchType)='ZIPS';
	boolean isZip5Search:=stringlib.StringToUpperCase(inSearchType)='ZIPS';
	boolean isZip4ByZip5Search:=stringlib.StringToUpperCase(inSearchType)='ZIP4S';
	boolean isCityListByZip5Search:=stringlib.StringToUpperCase(inSearchType)='CITIES';

	//Create passed in parameters
	inrecMod := MODULE(Lookup_Services.Zipcode_IParam.searchParams)
		EXPORT STRING10	 StreetNumber := if(inStreetNumber <> '',stringlib.StringToUpperCase(inStreetNumber),if(SearchBy.Address.StreetNumber<>'',stringlib.StringToUpperCase(SearchBy.Address.StreetNumber),clnAddr.prim_range));
		EXPORT STRING28	 StreetName := if(inStreet <> '',stringlib.StringToUpperCase(inStreet),if(SearchBy.Address.StreetName<>'',stringlib.StringToUpperCase(SearchBy.Address.StreetName),clnAddr.prim_name));
		EXPORT STRING28  City  := if(inCity <> '',stringlib.StringToUpperCase(inCity),if(SearchBy.Address.City<>'',stringlib.StringToUpperCase(SearchBy.Address.City),clnAddr.p_city_name));
		EXPORT STRING2   State := if(inState <> '',stringlib.StringToUpperCase(inState),if(SearchBy.Address.State<>'',stringlib.StringToUpperCase(SearchBy.Address.State),clnAddr.st));
		EXPORT STRING5   Zip   := if(inZip <> '',inZip,if(SearchBy.Address.Zip5<>'',SearchBy.Address.Zip5,if(stringlib.StringToUpperCase(SearchBy.SearchType)<>'ZIPS',clnAddr.zip,'')));
		Export boolean	 isAddresses := if(isAddressesSearch,isAddressesSearch,stringlib.StringToUpperCase(SearchBy.SearchType)='ZIPS' and StreetName <>'');
		Export boolean	 isZip5 := if(isZip5Search,isZip5Search,stringlib.StringToUpperCase(SearchBy.SearchType)='ZIPS' and StreetName ='');
		Export boolean	 isZip4ByZip5 := if(isZip4ByZip5Search,isZip4ByZip5Search,stringlib.StringToUpperCase(SearchBy.SearchType)='ZIP4S');
		Export boolean	 isCityListByZip5 := if(isCityListByZip5Search,isCityListByZip5Search,stringlib.StringToUpperCase(SearchBy.SearchType)='CITIES');
	END;

	// compute results
	tempresults := Lookup_Services.Zipcode_records(inrecMod);
	// standard record counts & limits
	//doxie.MAC_Header_Field_Declare();

	iesp.ECL2ESP.Marshall.Mac_Set(GLOBAL(request.Options));
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults,results,
		iesp.Zipcode.t_ZipCodeSearchResponse,Records,false);


	// display results
	output(results, named('Results'));
	
endmacro;
 // Zipcode_SearchService();
