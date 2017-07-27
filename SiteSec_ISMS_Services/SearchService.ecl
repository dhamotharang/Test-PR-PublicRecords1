/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"         type="xsd:byte"/>
	<part name="DPPAPurpose"        type="xsd:byte"/>
	<part name="CompanyName"      	type="xsd:string"/>
	<part name="FirstName"        	type="xsd:string"/>
	<part name="LastName"         	type="xsd:string"/>
	<part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="StrictMatch" 				type="xsd:boolean"/>

  <part name="siteSecuritySearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns Safety Certification and Site Security Search records.*/


import SiteSec_ISMS, iesp, AutoStandardI;

EXPORT SearchService := MACRO

    rec_in := iesp.siteSecurity.t_siteSecuritySearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('siteSecuritySearchRequest', FEW);
	  first_row := ds_in[1] : independent;
    //set options
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		
    //set main search criteria:
		search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.Options);
		iesp.ECL2ESP.SetInputNameCompanyName (first_row.SearchBy.Name);
	 	
	  input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,SiteSec_ISMS_Services.IParam.searchrecords,opt))
		end;
					
		tmpresults := SiteSec_ISMS_Services.Search_Records.val(tempmod);		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, 
																								results, 
																								iesp.siteSecurity.t_siteSecuritySearchResponse,,,,,,
																								iesp.Constants.SITE_SECURITY.MaxSearchRecords);
		
		output(results, named('Results'));
	
endmacro;
//SearchService ();
/*
<siteSecuritySearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
	<SSNMask></SSNMask>
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
		<CompanyName></CompanyName>
  </Name>
</SearchBy>
<Options>
  <ReturnCount></ReturnCount>
  <StartingRecord></StartingRecord>
  <UseNicknames>0</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</siteSecuritySearchRequest>
*/