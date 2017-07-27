/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="ApplicationType"     type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<!-- SEARCH FIELDS -->
  <part name="State"               type="xsd:string"/>
  <part name="SearchByCounty"      type="xsd:string"/>
	<part name="CompanyName"         type="xsd:string"/>
	<part name="UnParsedFullName"    type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="NameSuffix"				   type="xsd:string"/>
  <part name="FilingStartDateYear"  type="xsd:string"/>
  <part name="FilingStartDateMonth" type="xsd:string"/>
  <part name="FilingStartDateDay"   type="xsd:string"/>
  <part name="FilingEndDateYear"    type="xsd:string"/>
  <part name="FilingEndDateMonth"   type="xsd:string"/>
  <part name="FilingEndDateDay"     type="xsd:string"/>
	
  <!-- New fields/options -->
  <part name="allowNicknames"      type="xsd:boolean"/>
  <part name="PhoneticMatch"       type="xsd:boolean"/>
	<part name="StrictMatch"         type="xsd:boolean"/>
	
  <!-- Existing options -->
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>

  <part name="OfficialRecSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search official records.*/

import iesp, AutoStandardI;

export SearchService := macro

  // Get XML input 
  rec_in := iesp.officialrecord.t_OfficialRecSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('OfficialRecSearchRequest', FEW);
	first_row := ds_in[1] : independent;

  //set User info and RecordCount & StartingRecord options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	iesp.ECL2ESP.SetInputName (search_by.Name);

  #stored ('CompanyName', search_by.CompanyName);

	//Store XML input state value into global "State" field for autokey fetches to use.
	//Normally this would be set by iesp.ECL2ESP.SetInputAddress, but state is the only 
	// address field used, so it's done here.
	string2 State := global (search_by.State);
	#stored ('State', search_by.State);

  // Store XML input county value first into soap attribute name and then save soap 
	// attribute in tempmod below for autokey fetches to use.
	// NOTE: Used a separate SearchByCounty attribute name instead of "county" so it did
	// not conflict with the global "county" attribute set in AutoStandardI.GlobalModule.
	#stored ('SearchByCounty', search_by.County);

  //Store FilingDate input fields whihc are used for filtering.
  #stored ('FilingStartDateYear', search_by.FilingDateRange.StartDate.Year);
  #stored ('FilingStartDateMonth', search_by.FilingDateRange.StartDate.Month);
  #stored ('FilingStartDateDay', search_by.FilingDateRange.StartDate.Day);
  #stored ('FilingEndDateYear', search_by.FilingDateRange.EndDate.Year);
  #stored ('FilingEndDateMonth', search_by.FilingDateRange.EndDate.Month);
  #stored ('FilingEndDateDay', search_by.FilingDateRange.EndDate.Day);

  // set other search options
	iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,OfficialRecords_Services.Search_Records.params,opt));
 	  // Store SearchByCounty from xml or soap input into global "CITY" field for 
		// autokey fetches to use.
		// NOTE: citystname autokey files were built with the county value from the data files
		// stored in the city field.  So the input search county field must alos be stored as 
		// "city" for autofetches to work.
	  // See official_records.File_Autokey_Party & official_records.Proc_Build_Autokey for
		// more information.
		export string25 city := '' : stored('SearchByCounty');

		// Store input fields unique to Official Records into attribute names
		// to be passed into OfficialRecords_Services.Search_Records
	  export integer2 FilingStartDateYear  := 0 : stored('FilingStartDateYear');
	  export integer2 FilingStartDateMonth := 0 : stored('FilingStartDateMonth');
	  export integer2 FilingStartDateDay   := 0 : stored('FilingStartDateDay');
	  export integer2 FilingEndDateYear    := 0 : stored('FilingEndDateYear');
	  export integer2 FilingEndDateMonth   := 0 : stored('FilingEndDateMonth');
	  export integer2 FilingEndDateDay     := 0 : stored('FilingEndDateDay');
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	tempresults := OfficialRecords_Services.Search_Records.val(tempmod);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, iesp.officialrecord.t_OfficialRecSearchResponse, Records, false);

  // Uncomment line below for debugging
	//output(tempresults,named('ss_tempresults'));
  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//SearchService ();
/*
<OfficialRecSearchRequest>
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
  <State></State>
  <County></County>
  <CompanyName></CompanyName>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
	<FilingDateRange>
	  <StartDate>
		  <Year></Year>
      <Month></Month>
	    <Day></Day>
	  </StartDate>
	  <EndDate>
		  <Year></Year>
      <Month></Month>
	    <Day></Day>
		</EndDate>
	</FilingDateRange>
</SearchBy>
<Options>
	<StrictMatch>false</StrictMatch>
  <UseNicknames>false</UseNicknames>
  <IncludeAlsoFound>false</IncludeAlsoFound>
  <UsePhonetics>false</UsePhonetics>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
</Options>
</row>
</OfficialRecSearchRequest>
*/