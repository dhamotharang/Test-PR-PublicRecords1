/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="ApplicationType"   	 type="xsd:string"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<part name="CompanyName"          type="xsd:string"/>
	<part name="DomainName"           type="xsd:string"/>
 	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	<part name="NamePrefix"				type="xsd:string"/>
	
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
	<part name="StrictMatch"      type="xsd:boolean"/>
	
	<part name="did"                 type="xsd:string"/>
	<part name="bdid"                type="xsd:string"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="ReturnCount"         type="xsd:string"/>
	<part name="StartingRecord"      type="xsd:string"/>
  

  <part name="InetDomainSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns Internet DomainSearch records.*/


import internetdomain_services, iesp, AutoStandardI;

export SearchService := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    //read ESP input values into ECL "standard" names
		// iesp.ECL2ESP.MAC_ReadESPInput();

    rec_in := iesp.InternetDomain.t_InetDomainSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('InetDomainSearchRequest', FEW);
		first_row := ds_in[1] : independent;
    //set options
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
		
		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
   
		#stored ('CompanyName', search_by.CompanyName);
		#stored ('DomainName', search_by.DomainName);
    
    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,internetDomain_services.SearchService_Records.params,opt))
		    shared string45 domainName_mixed := '' : stored('DomainName');
				shared string45 domainName := stringlib.StringToUpperCase(domainName_mixed);
				export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;
		
		tmpresults := InternetDomain_services.SearchService_Records.val(tempmod);		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, results, iesp.InternetDomain.t_InetDomainSearchResponse);
		output(results, named('Results'));
	
endmacro;
//SearchService ();
/*
<InetDomainSearchRequest>
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
	<DomainName></DomainName>
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
  <ReturnCount>100</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>0</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</InetDomainSearchRequest>
*/