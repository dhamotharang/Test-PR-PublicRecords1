/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	
 	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	<part name="NamePrefix"				type="xsd:string"/>
	
	<part name="CompanyName"          type="xsd:string"/>
	<part name="State"                type="xsd:string"/>
	<part name="City"                 type="xsd:string"/>
	<part name="SearchByJurisdiction" type="xsd:string"/>
	
 
  <part name="allownicknames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>
	<part name="StrictMatch"      type="xsd:boolean"/>
	
	<part name="did"                 type="xsd:string"/>
	<part name="ReturnCount"         type="xsd:string"/>
	<part name="StartingRecord"      type="xsd:string"/>
  

  <part name="CivilCourtSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns Civil Court Search records.*/


import iesp, AutoStandardI, ut;

export SearchService := macro

    //read ESP input values into ECL "standard" names

    rec_in := iesp.civilCourt.t_CivilCourtSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('CivilCourtSearchRequest', FEW);
		 first_row := ds_in[1] : independent;
    //set options
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

    //set main search criteria:
		search_by := global (first_row.SearchBy);
    
		iesp.ECL2ESP.SetInputName (search_by.Name);
		#stored ('CompanyName', search_by.CompanyName);
		
    // to make it available from both SOAP and ESP requests (abbreviate state, if needed)
		string state_tmp := trim(search_by.State, left, right);
    esp_in_state := if (length(state_tmp) > 2, 
                        ut.st2Abbrev (StringLib.StringToUpperCase (state_tmp)), state_tmp);
		#stored ('State', esp_in_state);
		
		string25 City := search_by.City;
    #stored ('City', City);
		
		#stored ('SearchByJurisdiction', search_by.Jurisdiction);
	
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,CivilCourt_services.SearchService_Records.params,opt))
				export string2  State_in := '' : stored('State');
				string25 City_tmp_in := '' : stored('City');
				export string25 City_in := stringlib.StringToUpperCase(City_tmp_in);
				export string60 jurisdiction_mixedCase := '' : stored('SearchByJurisdiction');
				export string60 jurisdiction_in := stringlib.StringToUpperCase(jurisdiction_mixedCase);
		end;
		
		tmpresults := CivilCourt_services.SearchService_Records.val(tempmod);		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, results, iesp.civilCourt.t_CivilCourtSearchResponse);
		output(results, named('Results'));
endmacro;
//SearchService ();
/*
<CivilCourtSearchRequest>
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
	<State></State>
	<City></City>
	<Jurisdiction></Jurisdiction>
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
</CivilCourtSearchRequest>
*/
