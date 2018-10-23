/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte" default="1"/>
	<part name="DPPAPurpose"         type="xsd:byte" default="1"/>
	<part name="SSNMask" 							type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	<part name="ApplicationType"     type="xsd:string"/>
	
	<!-- SEARCH FIELDS -->
  <part name="SSN" 							   type="xsd:string"/>
  <part name="DOB"                 type="xsd:string"/>
  <part name="AgeLow"              type="xsd:string"/>
  <part name="AgeHigh"             type="xsd:string"/>
	
  <part name="UnParsedFullName"    type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
	<part name="LastName"            type="xsd:string"/>
	<part name="NameSuffix"				   type="xsd:string"/>
	
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
  <part name="ZipRadius"           type="xsd:unsignedInt"/>
  <part name="Latitude"						 type="xsd:real"/>
  <part name="Longitude"					 type="xsd:real"/>

  <!-- Roxie search service related options -->
  <part name="AllowNickNames"      type="xsd:boolean"/>
  <part name="PhoneticMatch"       type="xsd:boolean"/>
  <part name="DeepDive"            type="xsd:boolean"/>
  <part name="StrictMatch"         type="xsd:boolean"/>
  <part name="did"                 type="xsd:string"/>

  <!-- penalty fields -->
	<part name="OffenseCategory"			type="xsd:string"/>
	<part name="ScarsMarksTattoos"		type="xsd:string"/>

	<!-- Search request options -->
	<part name="ReturnCount"				          type="xsd:unsignedInt"/>
	<part name="StartingRecord"			          type="xsd:unsignedInt"/>
	<part name="IncludeRegisteredAddresses"   type="xsd:boolean"/>
	<part name="IncludeUnRegisteredAddresses" type="xsd:boolean"/>
	<part name="IncludeHistoricalAddresses"   type="xsd:boolean"/>
	<part name="IncludeAssociatedAddresses"   type="xsd:boolean"/>
	<part name="IncludeOffenses"   						type="xsd:boolean"/>
	<part name="IncludeBestAddress"   				type="xsd:boolean"/>
	<part name="IncludeWeAlsoFound"   				type="xsd:boolean"/>
	<part name="SearchAroundAddress"   				type="xsd:boolean"/>
	<part name="FilterRecsByAltAddresses"     type="xsd:boolean"/>
	
  <!-- Alert related options -->
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>		

  <!-- XML input search request -->
  <part name="OffenderSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Sexual Offender information.*/

import Alerts, AutoStandardI, iesp, ut;

export SearchService := macro
	 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  // Get XML input 
  rec_in := iesp.sexualoffender.t_OffenderSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('OffenderSearchRequest', FEW);
	first_row := ds_in[1] : independent;
  // set main search criteria:
	search_by := global (first_row.SearchBy);

  // This will set Name, Address, SSN, DID and DOB
	// NOTE: Even though the ECL2ESP function used below is named SetInputReportBy, 
	// it can also be used to set certain search_by fields.
  report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left; Self := []));
  iesp.ECL2ESP.SetInputReportBy (report_by);

  // store search_by field not handled by iesp.ECL2ESP
	#stored ('ZipRadius', search_by.Radius);
	#stored ('Latitude',	search_by.Location.Latitude);
	#stored ('Longitude',	search_by.Location.Longitude);
  #stored ('OffenseCategory', search_by.OffenseCategory);
	#stored ('ScarsMarksTattoos', search_by.ScarsMarksTattoos);
	#stored ('AgeLow', search_by.AgeRange.low);
	#stored ('AgeHigh', search_by.AgeRange.high);
	// NOTE: AgeRange is in the iesp.sexualoffender t_OffenderSearchBy record structure and
	// was on the old moxie wsonline search form, but even though it was on the moxie search
	// form, it did not appear to work.  Also it is not on the Accurint.com Sex Offender
	// search form, so it was not included here. 

  // set User, Base and generic search options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.Options);
  iesp.ECL2ESP.SetInputSearchOptions (Project(first_row.options,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT)));


  // store search options not handled by iesp.ECL2ESP
  search_options := global (first_row.Options);
	#stored ('IncludeRegisteredAddresses', search_options.IncludeRegisteredAddresses);
 	#stored ('IncludeUnregisteredAddresses', search_options.IncludeUnregisteredAddresses);
	#stored ('IncludeHistoricalAddresses', search_options.IncludeHistoricalAddresses);
	#stored ('IncludeAssociatedAddresses', search_options.IncludeAssociatedAddresses);
	#stored ('IncludeOffenses', search_options.IncludeOffenses);
	#stored ('IncludeBestAddress', search_options.IncludeBestAddress);
	#stored ('IncludeWeAlsoFound', search_options.IncludeWeAlsoFound);
	#stored ('SearchAroundAddress', search_options.SearchAroundAddress);
	#stored ('FilterRecsByAltAddresses', search_options.FilterRecsByAltAddresses);

	// NOTE: Input options fields for ReturnHashes and srch_hashvals only come in as SOAP
	// fields, not as part of the OffenderSearchRequest XML input dataset.
	// This is because that is how things are currently handled for other products with Alerts
	// and in discussions with Tony Fishbeck & Yanrui Ma on 05/04/09 it was decided to leave
	// them as SOAP input fields only.
	// Those SOAP fields are handled in Alerts.inputs

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,SexOffender_Services.IParam.search,opt));
	   // Store soap/xml input fields unique to SexOffender SearchService into unique 
		 // attribute names to be passed into SexOffender_Services.Search_Records, etc.
		 export boolean include_regaddrs   := false : stored('IncludeRegisteredAddresses');
		 export boolean include_unregaddrs := false : stored('IncludeUnregisteredAddresses');
		 export boolean include_histaddrs  := false : stored('IncludeHistoricalAddresses');
		 export boolean include_assocaddrs := false : stored('IncludeAssociatedAddresses');
		 export boolean include_offenses := false : stored('IncludeOffenses');
		 export boolean include_bestaddress := false : stored('IncludeBestAddress');
		 export boolean include_wealsofound := false : stored('IncludeWeAlsoFound');
		 export STRING offenseCategory := '' : stored('OffenseCategory');
		 string smt := '' : stored('ScarsMarksTattoos');
		 export STRING SmtWords := stringlib.stringtouppercase(smt);
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    export boolean zip_only_search := SexOffender_Services.Functions.is_zip_only_search ();
		 export boolean filterRecsByAltAddr := false : stored('FilterRecsByAltAddresses');
	end;

	tempresults := SexOffender_Services.Search_Records.val(tempmod);

	// Determine center point of a radius search (when applicable)
	lv := AutoStandardI.InterfaceTranslator.location_value.val(project(tempmod,AutoStandardI.InterfaceTranslator.location_value.params));
	sv := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(project(tempmod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));
	dsSearchAround := if(
		sv,
		dataset([{lv.latitude, lv.longitude, lv.geo_match, ut.geo_desc(lv.geo_match)}], iesp.share.t_GeoLocationMatch),
		dataset([], iesp.share.t_GeoLocationMatch)
	);
	
	// Convert to output layout, with pagination
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(
		tempresults, results, iesp.sexualoffender.t_OffenderSearchResponse,
		Records, false, RecordCount, SearchAroundInput, dsSearchAround
	);

  // Uncomment line below for debugging
	//output(tempresults,named('ss_tempresults'));
	//output(alert_results,named('ss_alert_results'));
	//output(alert_tokens,named('ss_alert_tokens'));
	// output(final_proj,named('ss_final_proj'));
	
	// This one is not for debugging.
  output(results,named('Results'));

endmacro;

// For testing/debugging in a web form xml text area
//SearchService();
/*
<OffenderSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <ApplicationType></ApplicationType>
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
  <UniqueID></UniqueID>
  <SSN></SSN>
	<Radius></Radius>
	<AgeRange>
   <High></High>
   <Low></Low>
  </AgeRange>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>
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
	<Location>
		<Latitude></Latitude>
		<Longitude></Longitude>
	</Location>
</SearchBy>
<Options>
  <StrictMatch>false</StrictMatch>
  <UseNicknames>false</UseNicknames>
  <IncludeAlsoFound>false</IncludeAlsoFound>
  <UsePhonetics>false</UsePhonetics>
  <PenaltyThreshold></PenaltyThreshold>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
	<IncludeRegisteredAddresses>false</IncludeRegisteredAddresses>
	<IncludeUnregisteredAddresses>false</IncludeUnregisteredAddresses>
	<IncludeHistoricalAddresses>false</IncludeHistoricalAddresses>
	<IncludeAssociatedAddresses>false</IncludeAssociatedAddresses>
	<SearchAroundAddress>false</SearchAroundAddress>
</Options>
</row>
</OffenderSearchRequest>
*/
