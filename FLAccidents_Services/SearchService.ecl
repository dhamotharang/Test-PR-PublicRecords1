/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	
	<!-- SEARCH FIELDS -->
  <part name="UnParsedFullName"    type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="NameSuffix"				   type="xsd:string"/>
	
  <part name="allowNicknames"      type="xsd:boolean"/>
  <part name="PhoneticMatch"       type="xsd:boolean"/>
	
	<part name="CompanyName"         type="xsd:string"/>
	
  <part name="prim_range"          type="xsd:string"/>
  <part name="predir"              type="xsd:string"/>
  <part name="prim_name"           type="xsd:string"/>
  <part name="suffix"              type="xsd:string"/>
  <part name="postdir"             type="xsd:string"/>
  <part name="sec_range"           type="xsd:string"/>
  <part name="Addr"                type="xsd:string"/>
  <part name="City"                type="xsd:string"/>
  <part name="State"               type="xsd:string"/>
  <part name="Zip"                 type="xsd:string"/>
	
  <part name="AccidentNumber"			 type="xsd:string"/>
  <part name="DriverLicenseNumber" type="xsd:string"/>
  <part name="VIN"          			 type="xsd:string"/>
  <part name="TagNumber"	    		 type="xsd:string"/>
	
  <!-- New fields/options -->
  <part name="NoDeepDive"          type="xsd:boolean" default="true"/>
	<part name="PenaltThreshold"	   type="xsd:unsignedInt" default="0"/>
  <part name="did"                 type="xsd:string"/>
	<part name="BDID"                type="xsd:string"/>
	
  <!-- Existing options -->
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>

  <part name="AccidentSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return FL Accident information.*/

import iesp;

export SearchService := macro
  #constant ('PenaltThreshold', 10);

  // Get XML input 
  rec_in := iesp.accident.t_AccidentSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('AccidentSearchRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	iesp.ECL2ESP.SetInputName (search_by.Name);
  #stored ('CompanyName', search_by.CompanyName);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
	//Store fields unique to FL Accidents into soap names to be used below
  #stored ('AccidentNumber', search_by.AccidentNumber);
  #stored ('DriverLicenseNumber', search_by.DriverLicenseNumber);
  #stored ('VIN', search_by.VIN);
  #stored ('TagNumber', search_by.TagNumber);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,FLAccidents_Services.Search_Records.params,opt));
	  // Store soap fields unique to FL Accidents into unique attribute names to be passed 
		// into FLAccidents_Services.Search_IDs
	  export string9  Accident_Number := '' : stored('AccidentNumber');
	  export string22 Vin_in          := '' : stored('VIN');
	  export string15 DL_Nbr          := '' : stored('DriverLicenseNumber');
	  export string8  Tag_Number      := '' : stored('TagNumber');
		export string32	ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	tempresults := FLAccidents_services.Search_Records.val(tempmod);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, iesp.accident.t_AccidentSearchResponse, Records, false);

  // Uncomment line below for debugging
	//output(tempresults,named('ss_tempresults'));
  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//SearchService ();
/*
<AccidentSearchRequest>
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
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <CompanyName></CompanyName>
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
  <AccidentNumber></AccidentNumber>
  <DriverLicenseNumber></DriverLicenseNumber>
  <VIN></VIN>
  <TagNumber></TagNumber>
</SearchBy>
<Options>
  <UseNicknames>false</UseNicknames>
  <IncludeAlsoFound>false</IncludeAlsoFound>
  <UsePhonetics>false</UsePhonetics>
  <PenaltyThreshold>0</PenaltyThreshold>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</AccidentSearchRequest>
*/
