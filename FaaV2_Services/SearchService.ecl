/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<part name="CompanyName"         type="xsd:string"/>
	<part name="AircraftNumber"      type="xsd:string"/>

 	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	
	<part name="prim_range" type="xsd:string"/>
	<part name="prim_name" type="xsd:string"/>
  <part name="predir" type="xsd:string"/>
  <part name="postdir" type="xsd:string"/>
	<part name="suffix"  type="xsd:string"/>
  <part name="sec_range" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
 
  <part name="allownicknames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>
	
	<part name="did"                 type="xsd:string"/>
	<part name="ReturnCount"         type="xsd:string"/>
	<part name="StartingRecord"      type="xsd:string"/>
  <part name="NoDeepDive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>

  <part name="AircraftSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns FAA Aircraft Search records.*/

// so in general approach is 
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.
import FaaV2_services, iesp, AutoStandardI;

export SearchService := macro

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

    //read ESP input values into ECL "standard" names
		// iesp.ECL2ESP.MAC_ReadESPInput();

    rec_in := iesp.faaaircraft.t_AircraftSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('AircraftSearchRequest', FEW);
		 first_row := ds_in[1] : independent;
    //set options
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
    #stored ('CompanyName', search_by.CompanyName);
    #stored ('AircraftNumber', search_by.AircraftNumber);
		//#stored ('PenaltThreshold', 10);
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
/*
    // TODO: check for "wealsofound": according to input XML it should be a constant, if any.	
		// wealsofound is opposite of no deep dive
		boolean Reversed_weAlsoFound := false : stored('weAlsoFound');
		boolean weAlsoFound:= if (Reversed_weAlsoFound, false, true);
		#stored('NoDeepDive',weAlsoFound);
*/
    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,FaaV2_Services.SearchService_Records.params,opt))
			shared string8 n_number_mixed := '' : stored('AircraftNumber');
			shared string8 n_number := stringlib.StringToUpperCase(n_number_mixed);
			export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;
		
		res_temp := FaaV2_Services.SearchService_Records.val(tempmod);

		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(res_temp, results, iesp.faaaircraft.t_AircraftSearchResponse);

		output(results, named('Results'));
	
endmacro;
//SearchService ();
/*
<AircraftSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>

<SearchBy>
  <CompanyName></CompanyName>
  <AircraftNumber></AircraftNumber>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
</SearchBy>
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</AircraftSearchRequest>
*/