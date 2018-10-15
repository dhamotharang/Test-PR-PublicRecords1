/*--SOAP--
<message name="Plus_SearchService">
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
	<part name="CompanyName"         type="xsd:string"/>

  <part name="did"                 type="xsd:string"/>

	<!-- ADDITIONAL OPTIONS -->
	<part name="IncludeSpouseData" 	 type="xsd:boolean"/>
	<part name="PenaltThreshold"		 type="xsd:unsignedInt"/>
	<part name="NoDeepDive"          type="xsd:boolean"/>
	<part name="AllowNickNames" 		 type="xsd:boolean"/>
	<part name="PhoneticMatch"  		 type="xsd:boolean"/>

	<!-- RESULTS LIST MANAGEMENT -->
	<part name="MaxResults"					 type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	 type="xsd:unsignedInt"/>
	<part name="SkipRecords"				 type="xsd:unsignedInt"/>

	<!-- RESULTS DATA EXCLUSION OPTIONS FOR INTERNAL USE-->
	<part name="ExcludedSources"     type="xsd:string"/>

	<!-- XML Input Dataset -->
  <part name="WorkplacePlusSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Search and return WorkPlace information. They both take in person data 
and return company data.  The main difference is the source of the information for 
each product. Entering company data will likely yield no results. */

import iesp, Royalty;

export Plus_SearchService() := macro
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('useOnlyBestDID', TRUE);

	INTEGER Max_Results := iesp.constants.WP_PLUS_MAX_COUNT_SEARCH_RESPONSE_RECORDS;
	
	#STORED('ReturnCount',Max_Results); // For iesp.ECL2ESP.Marshall
	
  // Get XML input 
  rec_in    := iesp.workplaceplus.t_WorkPlacePlusSearchRequest;
  ds_in     := DATASET ([], rec_in) : STORED ('WorkplacePlusSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;

	// Search options
	#STORED('AllowNickNames'   , TRUE); // for fuzzy matching
	#STORED('PhoneticMatch'    , TRUE); // for fuzzy matching
  #STORED('IncludeSpouseData', first_row.options.IncludeSpouseData); // product-specific search option
  #STORED('ExcludedSources'  , first_row.options.ExcludedSources);   // source exclusion option
	
  // Set some base options
	iesp.ECL2ESP.SetInputBaseRequest(first_row);

  // Store main searchby criteria: Name, Address, SSN, Phone, CompanyName.
	search_by := GLOBAL(first_row.SearchBy);
	
	iesp.share.t_NameAndCompany xfm_build_NameAndCompany() := transform
		self.Full        := search_by.Name.Full;
		self.First       := search_by.Name.First;
		self.Middle      := search_by.Name.Middle;
		self.Last        := search_by.Name.Last;
		self.Suffix      := search_by.Name.Suffix;
		self.Prefix      := search_by.Name.Prefix;
		self.CompanyName := search_by.CompanyName;
	end;
	rw_NameAndCompany := ROW(xfm_build_NameAndCompany());

	iesp.ECL2ESP.SetInputNameCompanyName(rw_NameAndCompany);
  iesp.ECL2ESP.SetInputAddress(search_by.Address);
	#STORED('SSN'    , search_by.SSN);
	#STORED('Phone', search_by.Phone10);
	
  // used to determine the 1 "best" did for the input criteria
	// ...but only if SSN used, due to previous customer requirement - bug #75560
  #STORED('useOnlyBestDID', IF(search_by.SSN != '', TRUE, FALSE));

  // Did does not need stored because it is only soap input (not xml) to be used for
	// internal testing and will be handled by using it's default global name of did.
	// However the UniqueID xml input needs handled here.
  #STORED('did', search_by.UniqueId); // for internal testing

	// Instantiate _Records module.
	in_mod := MODULE(WorkPlace_Services.Plus_SearchService_Records().params)
		EXPORT BOOLEAN include_spouse    := FALSE : STORED('IncludeSpouseData');
		EXPORT STRING excluded_sources   := ''    : STORED('ExcludedSources');
		EXPORT UNSIGNED2 penaltThreshold := 5     : STORED('PenaltThreshold');
	END;
	
	m_records := WorkPlace_Services.Plus_SearchService_Records();
	
	// Run PAW an WPL Search Services.
	ds_PAW_recs := m_records.get_PAW_records(in_mod);
	ds_WPL_recs := m_records.get_WPL_records(in_mod);

	// Union, dedup; sort descending by date last seen and choosen; then marshall.
	ds_combined_recs_unioned := ds_WPL_recs + ds_PAW_recs;
	ds_combined_recs_deduped := DEDUP( SORT(ds_combined_recs_unioned, RECORD), RECORD );
	
	ds_combined_recs := 
		CHOOSEN( 
			SORT(
				ds_combined_recs_deduped, 
				-datelastseen.year, -datelastseen.month, -datelastseen.day
			),
			Max_Results 
		);
	
	// Set the number of PAW + WPL records to return (referenced in iesp.ECL2ESP.Marshall).
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_combined_recs, 
	                                           ds_results,
																						 iesp.workplaceplus.t_WorkPlacePlusSearchResponse, 
																						 Records,
																						 FALSE,,,,
																						 Max_Results);

	// Create the royalty count/info ("RoyaltySet") output dataset.
	Royalty.MAC_RoyaltyWorkplace(CHOOSEN(ds_WPL_recs, Max_Results), ds_royalty_recs, SourceCode);

	// Debugs.
	// OUTPUT( ds_PAW_recs, NAMED('ds_PAW_recs') );
	// OUTPUT( ds_WPL_recs, NAMED('ds_WPL_recs') );
	
	// Results.
  OUTPUT( ds_results     , NAMED('Results') );	
	OUTPUT( ds_royalty_recs, NAMED('RoyaltySet') );	
	
ENDMACRO;

/*
For testing/debugging: 
1. In the "WorkPlaceSearchRequest" xml text area, use the sample xml input below 
   filling in:
   a. the appropriate input/search data fields, 
   b. The IncludeSpouseData option (if needed/desired) and 
   c. If needed, set the "ExcludedSources" list of comma de-limited sources to be excluded.

<!-- For testing both sides. -->
<WorkplacePlusSearchRequest>
  <row>
    <User>
      <GLBPurpose>3</GLBPurpose>
      <DLPurpose>1</DLPurpose>
      <DataRestrictionMask>0000000001000000</DataRestrictionMask>
      <SSNMask>0110</SSNMask>
      <ApplicationType>MyApp</ApplicationType>
    </User>
    <SearchBy>
			<SSN></SSN>
			<Phone10></Phone10>
      <UniqueID></UniqueID>
      <Name>
        <Full></Full>
        <First>EVERETT</First>
        <Middle></Middle>
        <Last>AABERG</Last>
        <Suffix></Suffix>
        <Prefix></Prefix>
      </Name>
      <SSN></SSN>
      <Address>
        <StreetAddress1>13701 DALLAS PKWY</StreetAddress1>
        <State>TX</State>
        <City>DALLAS</City>
        <Zip5>75240</Zip5>
        <Zip4/>
      </Address>
      <CompanyName></CompanyName>
    </SearchBy>
    <Options>
      <UseNicknames>TRUE</UseNicknames>
      <UsePhonetics>TRUE</UsePhonetics>
      <Penalty_Threshold>15</Penalty_Threshold>
			<IncludeSpouseData>false</IncludeSpouseData>
			<ExcludedSources></ExcludedSources>
    </Options>
  </row>
</WorkplacePlusSearchRequest>

<!-- For testing the PAW side only. -->
<WorkplacePlusSearchRequest>
  <row>
    <User>
      <GLBPurpose>3</GLBPurpose>
      <DLPurpose>1</DLPurpose>
      <DataRestrictionMask>0000000001000000</DataRestrictionMask>
      <SSNMask>0110</SSNMask>
      <ApplicationType>MyApp</ApplicationType>
    </User>
    <SearchBy>
			<SSN></SSN>
			<Phone10></Phone10>
      <UniqueID></UniqueID>
      <Name>
        <Full>WILSMYA WATTS</Full>
        <First>WILSMYA</First>
        <Middle></Middle>
        <Last>WATTS</Last>
        <Suffix></Suffix>
        <Prefix></Prefix>
      </Name>
      <Address>
        <StreetAddress1></StreetAddress1>
        <State>KY</State>
        <City></City>
        <Zip5>41465</Zip5>
        <Zip4/>
      </Address>
      <CompanyName></CompanyName>
    </SearchBy>
    <Options>
      <UseNicknames>TRUE</UseNicknames>
      <UsePhonetics>TRUE</UsePhonetics>
      <Penalty_Threshold>100</Penalty_Threshold>
			<IncludeSpouseData>false</IncludeSpouseData>
			<ExcludedSources></ExcludedSources>
    </Options>
  </row>
</WorkplacePlusSearchRequest>

<!-- For testing the WPL side only. -->
<WorkplacePlusSearchRequest>
  <row>
    <User>
      <GLBPurpose>3</GLBPurpose>
      <DLPurpose>1</DLPurpose>
      <DataRestrictionMask>0000000001000000</DataRestrictionMask>
      <SSNMask>0110</SSNMask>
      <ApplicationType>MyApp</ApplicationType>
    </User>
    <SearchBy>
			<SSN></SSN>
			<Phone10>9817874990</Phone10>
      <UniqueID></UniqueID>
      <Name>
        <Full>AZIZ ABDUL</Full>
        <First>AZIZ</First>
        <Middle></Middle>
        <Last>ABDUL</Last>
        <Suffix></Suffix>
        <Prefix></Prefix>
      </Name>
      <Address>
        <StreetAddress1>1790 NANTUCKET CIR</StreetAddress1>
        <State>CA</State>
        <City>SANTA CLARA</City>
        <Zip5>95054</Zip5>
        <Zip4/>
      </Address>
      <CompanyName></CompanyName>
    </SearchBy>
    <Options>
      <UseNicknames>TRUE</UseNicknames>
      <UsePhonetics>TRUE</UsePhonetics>
      <Penalty_Threshold>100</Penalty_Threshold>
			<IncludeSpouseData>false</IncludeSpouseData>
			<ExcludedSources></ExcludedSources>
    </Options>
  </row>
</WorkplacePlusSearchRequest>
*/
