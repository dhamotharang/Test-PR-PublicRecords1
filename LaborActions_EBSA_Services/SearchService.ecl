/*--SOAP--
<message name="LaborActions_EBSA_SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"         type="xsd:byte"/>
	<part name="DPPAPurpose"        type="xsd:byte"/>
	<part name="CompanyName"      	type="xsd:string"/>
	<part name="FirstName"        	type="xsd:string"/>
	<part name="LastName"         	type="xsd:string"/>
	<part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="StrictMatch" 				type="xsd:boolean"/>

  <part name="laborAction_EBSASearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns Employee Benefit Security violation records.*/


import LaborActions_EBSA, iesp, AutoStandardI;

EXPORT SearchService := MACRO

    rec_in := iesp.LaborAction_EBSA.t_LaborAction_EBSASearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('LaborAction_EBSASearchRequest', FEW);
	  first_row := ds_in[1] : independent;
    //set options
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		
    //set main search criteria:
		search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.Options);
		iesp.ECL2ESP.SetInputNameCompanyName (first_row.SearchBy.Name);
			
	  input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,LaborActions_EBSA_Services.IParam.searchrecords,opt))
		  export string8 	 ClosingStartDate  := iesp.ECL2ESP.t_DateToString8(search_by.ClosingDateRange.StartDate);
		  export string8 	 ClosingEndDate    := iesp.ECL2ESP.t_DateToString8(search_by.ClosingDateRange.EndDate);
		end;

		is_valid_dateinput := (tempmod.ClosingStartDate = '' or ut.ValidDate(tempmod.ClosingStartDate)) 
		                      and (tempmod.ClosingEndDate = '' or ut.ValidDate(tempmod.ClosingEndDate));
		
    IF(~is_valid_dateinput, FAIL('An error occurred while running LaborActions_EBSA_Services.SearchService: invalid input dates.') );
	
		tmpresults := LaborActions_EBSA_Services.Search_Records.val(tempmod);		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, 
																								results, 
																								iesp.LaborAction_EBSA.t_LaborAction_EBSASearchResponse,,,,,,
																								iesp.Constants.LABOR_ACTION_EBSA.MaxSearchRecords);
			
		output(results, named('Results'));
	
endmacro;
//SearchService ();
/*
<laborAction_EBSASearchRequest>
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
</laborAction_EBSASearchRequest>
*/