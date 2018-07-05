/*--SOAP--
<message name="WorkPlace_SearchService">

	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="SSNMask" 					   type="xsd:string"/>
	<part name="ApplicationType"   	 type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<!-- SEARCH FIELDS, order matches WEB/GUI search form -->
	<part name="LastName"            type="xsd:string"/>
	<part name="FirstName"           type="xsd:string"/>
	<part name="MiddleName"          type="xsd:string"/>
  <part name="SSN"          			 type="xsd:string"/>
  <part name="Addr"                type="xsd:string"/>
  <part name="City"                type="xsd:string"/>
  <part name="State"               type="xsd:string"/>
  <part name="Zip"                 type="xsd:string"/>
	<part name="Phone"               type="xsd:string"/>

  <part name="did"                 type="xsd:string"/>
	
	<!-- ADDITIONAL USER OPTIONS -->
	<part name="IncludeSpouseData"   type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>

  <part name="WorkPlaceSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

	<!-- RESULTS DATA EXCLUSION OPTIONS FOR INTERNAL USE-->
	<part name="ExcludedSources"      type="xsd:string"/>

</message>
*/
/*--INFO-- Search and return WorkPlace information.*/
import iesp, Royalty;

export SearchService := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#stored('AllowNickNames',true); // used to find the best subject for the input data
#stored('PhoneticMatch',true);  // used to find the best subject for the input data

  // Get XML input 
  rec_in := iesp.workplace.t_WorkPlaceSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('WorkPlaceSearchRequest', FEW);
	first_row := ds_in[1] : independent;

  // Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	// Store product specific search option
  #stored ('IncludeSpouseData', first_row.options.IncludeSpouseData);
	#stored ('includeCriminalIndicators',first_row.options.includeCriminalIndicators);

  // Store source exclusion option
  #stored ('ExcludedSources',     first_row.options.ExcludedSources); 

  // Store main search criteria:
	search_by := global (first_row.SearchBy);
	iesp.ECL2ESP.SetInputName (search_by.Name);
	#stored ('SSN', search_by.SSN);
  iesp.ECL2ESP.SetInputAddress (search_by.Address);
	#stored ('Phone', search_by.Phone10);
	
  // used to determine the 1 "best" did for the input criteria
	// ...but only if SSN used, due to previous customer requirement - bug #75560
  #stored('useOnlyBestDID', IF(search_by.SSN != '', TRUE, FALSE));

  // Did does not need stored because it is only soap input (not xml) to be used for
	// internal testing and will be handled by using it's default global name of did.
	// However the UniqueID xml input needs handled here.
  #stored('did', search_by.UniqueId); // for internal testing
	
  // *** Start of processing
  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,WorkPlace_Services.Search_Records.params,opt));
	  export boolean include_spouse   := false : stored('IncludeSpouseData');  //default to OFF per specs
	  export string  excluded_sources := ''    : stored('ExcludedSources'); 
		export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		export boolean includeCriminalIndicators := false : stored('IncludeCriminalIndicators');
	end;

	ds_temp_results := WorkPlace_Services.Search_Records.val(tempmod);

  OUTPUT_RECORDCOUNT := FALSE;
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_temp_results, 
	                                           ds_results,
																						 iesp.workplace.t_WorkPlaceSearchResponse, 
																						 Records, 
																			       OUTPUT_RECORDCOUNT,
																						 RecordCount,,,iesp.Constants.WP_MAX_COUNT_SEARCH_RESPONSE_SINGLE_RECORD);

  // Output the search results
  output(ds_results, named('Results'));

  // Create the royalty count/info ("RoyaltySet") output dataset.
	//
	// First project the results with a non-zero record count, onto a common layout so 
	// we can count the sources for royalty purposes with a common function.
	// NOTE: the ds_results will only have 1 record in it, so it's Ok in the 
	// transform below to use left.Records[1]...
	ds_results_slimmed := project(ds_results(RecordCount>0),
	                              transform(WorkPlace_Services.Layouts.result_sources,
	                                self.source := left.Records[1].SourceCode));

  // Next call a function to actually count the source.
	Royalty.MAC_RoyaltyWorkplace(ds_results_slimmed, ds_royalties);
 
	// Then output the RoyaltySet dataset
	output(ds_royalties,Named('RoyaltySet'));	

  // Uncomment line below for debugging
	//output(ds_temp_results,named('ds_temp_results'));
  //output(ds_results_slimmed,named('ds_results_slimmed'));

endmacro;
/*
For testing/debugging: 
1. In the "WorkPlaceSearchRequest" xml text area, use the sample xml input below 
   filling in:
   a. the appropriate input/search data fields, 
   b. The IncludeSpouseData option (if needed/desired) and 
   c. If needed, set the "ExcludedSources" list of comma de-limited sources to be excluded.

<WorkPlaceSearchRequest>
<row>
 <User>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <DataRestrictionMask>00000000000</DataRestrictionMask>
  <SSNMask></SSNMask>
  <ApplicationType></ApplicationType>
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
  <SSN></SSN>
  <Address>
   <StreetAddress1></StreetAddress1>
   <State></State>
   <City></City>
   <Zip5></Zip5>
   <Zip4></Zip4>
  </Address>
  <Phone10></Phone10>
  <UniqueID></UniqueID>
 </SearchBy>
 <Options>
  <IncludeSpouseData>false</IncludeSpouseData>
  <ExcludedSources></ExcludedSources>
  <IncludeCriminalIndicators></IncludeCriminalIndicators>
  </Options>
</row>
</WorkPlaceSearchRequest>

*/
