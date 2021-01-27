/*--SOAP--
<message name="Identifier2_Service">
	<part name="AccountNumber" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>
	<part name="OFACVersion" type="xsd:unsignedInt"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="FromIIDModel" type="xsd:boolean"/>
	<part name="RedFlags_version" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
	<part name="DOBMask" type="xsd:string"/>
	<part name="scores" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="DOBMatchOptions" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="Identifier2Request" type="tns:XmlDataSet" cols="80" rows="150" />
end;
	
 </message>
*/
/*--INFO-- Identifier2_Service (ESDL-compliant)*/
/*--HELP-- 
<pre>
&lt;Identifier2Request&gt;
    &lt;Row&gt;
        &lt;Options&gt;
            &lt;IncludeOFAC&gt;0&lt;/IncludeOFAC&gt;
            &lt;IncludeOtherWatchLists&gt;0&lt;/IncludeOtherWatchLists&gt;
            &lt;ExcludeWatchLists&gt;0&lt;/ExcludeWatchLists&gt;
            &lt;IncludeOFACOnly&gt;0&lt;/IncludeOFACOnly&gt;
            &lt;Watchlists&gt;
                &lt;Watchlist&gt;&lt;/Watchlist&gt;
            &lt;/Watchlists&gt;
            &lt;UseDOBFilter&gt;0&lt;/UseDOBFilter&gt;
            &lt;DOBRadius&gt;0&lt;/DOBRadius&gt;
            &lt;PoBoxCompliance&gt;0&lt;/PoBoxCompliance&gt; 
            &lt;IncludeModels&gt; 
                &lt;ThindexOLD&gt;0&lt;/ThindexOLD&gt;
                &lt;Thindex&gt;0&lt;/Thindex&gt;
                &lt;Recover&gt;0&lt;/Recover&gt;
                &lt;FraudDefender&gt;0&lt;/FraudDefender&gt;
                &lt;FraudPointModel&gt;&lt;/FraudPointModel&gt;
                &lt;StudentDefenderModel&gt;
                    &lt;ModelName&gt;&lt;/ModelName&gt;
                    &lt;ModelOptions&gt;
                        &lt;ModelOption&gt;&lt;/ModelOption&gt;
                    &lt;/ModelOptions&gt; 
                &lt;/StudentDefenderModel&gt;
                &lt;ModelRequests&gt;
                    &lt;ModelName&gt;&lt;/ModelName&gt;
                    &lt;ModelOptions&gt;
                        &lt;ModelOption&gt;&lt;/ModelOption&gt;
                    &lt;/ModelOptions&gt; 
                &lt;/ModelRequests&gt;        
            &lt;/IncludeModels&gt;
            &lt;RedFlagsReport&gt;&lt;/RedFlagsReport&gt; 
            &lt;GlobalWatchlistThreshold&gt;0.84&lt;/GlobalWatchlistThreshold&gt; 
            &lt;DisallowTargusEID3220&gt;0&lt;/DisallowTargusEID3220&gt; 
            &lt;RequireExactMatch&gt;
                &lt;LastName&gt;0&lt;/LastName&gt; 
                &lt;FirstName&gt;0&lt;/FirstName&gt; 
                &lt;Address&gt;0&lt;/Address&gt; 
                &lt;UnitNumber&gt;0&lt;/UnitNumber&gt; 
                &lt;HomePhone&gt;0&lt;/HomePhone&gt; 
                &lt;SSN&gt;0&lt;/SSN&gt; 
                &lt;DOB&gt;0&lt;/DOB&gt; 
                &lt;FirstNameAllowNickname&gt;0&lt;/FirstNameAllowNickname&gt;
            &lt;/RequireExactMatch&gt;
            &lt;DOBMatch&gt;
                &lt;MatchType&gt;&lt;/MatchType&gt; 
                &lt;MatchYearRadius&gt;0&lt;/MatchYearRadius&gt; 
            &lt;/DOBMatch&gt;
            &lt;VerifyInputAddressPropertyOwnership&gt;
                &lt;CurrentOwner&gt;1&lt;/CurrentOwner&gt; 
                &lt;EverOwner&gt;1&lt;/EverOwner&gt; 
                &lt;EverOwnedPastYears&gt;0&lt;/EverOwnedPastYears&gt; 
            &lt;/VerifyInputAddressPropertyOwnership&gt;
            &lt;VerifyOwnedAnyProperty&gt;1&lt;/VerifyOwnedAnyProperty&gt; 
            &lt;DiscoverDOB&gt;1&lt;/DiscoverDOB&gt; 
            &lt;ValidateDiscoveredDOBToSSN&gt;1&lt;/ValidateDiscoveredDOBToSSN&gt;
            &lt;ReturnMultipleIdentities&gt;1&lt;/ReturnMultipleIdentities&gt;
            &lt;VerifySSNExistsOnAnyAddress&gt;1&lt;/VerifySSNExistsOnAnyAddress&gt; 
            &lt;VerifyInput&gt;
                &lt;DOBMatchesSSN&gt;1&lt;/DOBMatchesSSN&gt; 
                &lt;YOBMatchesSSN&gt;1&lt;/YOBMatchesSSN&gt; 
                &lt;ZipMatchesState&gt;1&lt;/ZipMatchesState&gt; 
                &lt;SSNMatchesLastAndDOB&gt;1&lt;/SSNMatchesLastAndDOB&gt;
            &lt;/VerifyInput&gt;
            &lt;VerifyInputAddressOccupancy&gt;
                &lt;CurrentOccupant&gt;1&lt;/CurrentOccupant&gt;
                &lt;EverOccupant&gt;1&lt;/EverOccupant&gt;
                &lt;EverOccupantPastMonths&gt;0&lt;/EverOccupantPastMonths&gt;
                &lt;EverOccupantStartDate&gt;
                    &lt;Year&gt;&lt;/Year&gt;
                    &lt;Month&gt;&lt;/Month&gt;
                    &lt;Day&gt;&lt;/Day&gt;
                &lt;/EverOccupantStartDate&gt;
								&lt;IncludeNAPData&gt;1&lt;/IncludeNAPData&gt;
            &lt;/VerifyInputAddressOccupancy&gt;
            &lt;VerifyValidDEALicense&gt;1&lt;/VerifyValidDEALicense&gt;
            &lt;VerifyValidProfessionalLicense&gt;1&lt;/VerifyValidProfessionalLicense&gt;
            &lt;VerifyValidDriversLicense&gt;1&lt;/VerifyValidDriversLicense&gt;
            &lt;NumberOfRiskCodesReturned&gt;1&lt;/NumberOfRiskCodesReturned&gt;
            &lt;IncludePropertyData&gt;1&lt;/IncludePropertyData&gt; 
            &lt;IncludeMultipleIdentitiesData&gt;1&lt;/IncludeMultipleIdentitiesData&gt; 
            &lt;IncludeDEALicenseData&gt;1&lt;/IncludeDEALicenseData&gt; 
            &lt;IncludeProfessionalLicenseData&gt;1&lt;/IncludeProfessionalLicenseData&gt; 
            &lt;IncludeDriversLicenseData&gt;1&lt;/IncludeDriversLicenseData&gt; 
            &lt;IncludeSSNExistsData&gt;1&lt;/IncludeSSNExistsData&gt; 
            &lt;IncludeAllRiskIndicators&gt;1&lt;/IncludeAllRiskIndicators&gt;
            &lt;LastSeenThreshold&gt;365&lt;/LastSeenThreshold&gt;
            &lt;CustomDataFilter&gt;&lt;/CustomDataFilter&gt;
            &lt;VerifyInputAddressMatchesKnownBad&gt;&lt;/VerifyInputAddressMatchesKnownBad&gt;
						&lt;OFACVersion&gt;1&lt;/OFACVersion&gt;
        &lt;/Options&gt;
        &lt;SearchBy&gt;
            &lt;Name&gt;
                &lt;Full&gt;&lt;/Full&gt;
                &lt;First&gt;&lt;/First&gt;
                &lt;Middle&gt;&lt;/Middle&gt;
                &lt;Last&gt;&lt;/Last&gt;
            &lt;/Name&gt;
            &lt;Address&gt;
                &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
                &lt;StreetName&gt;&lt;/StreetName&gt;
                &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
                &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
                &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
                &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
                &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
                &lt;State&gt;&lt;/State&gt;
                &lt;City&gt;&lt;/City&gt;
                &lt;Zip5&gt;&lt;/Zip5&gt;
            &lt;/Address&gt;
            &lt;DOB&gt;
                &lt;Year&gt;&lt;/Year&gt;
                &lt;Month&gt;&lt;/Month&gt;
                &lt;Day&gt;&lt;/Day&gt;
            &lt;/DOB&gt;
            &lt;Age&gt;&lt;/Age&gt;
            &lt;SSN&gt;&lt;/SSN&gt;
            &lt;SSNLast4&gt;&lt;/SSNLast4&gt; 
            &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt; 
            &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt; 
            &lt;IPAddress&gt;&lt;/IPAddress&gt; 
            &lt;HomePhone&gt;&lt;/HomePhone&gt; 
            &lt;WorkPhone&gt;&lt;/WorkPhone&gt;
            &lt;UseDOBFilter&gt;0&lt;/UseDOBFilter&gt;
            &lt;Models&gt;
                &lt;Model&gt;
                &lt;/Model&gt;
            &lt;/Models&gt;
            &lt;ModelsWithHRI&gt;
                &lt;Model&gt;
                &lt;/Model&gt;
            &lt;/ModelsWithHRI&gt;
            &lt;Temp&gt;&lt;/Temp&gt;
            &lt;Passport&gt;
                &lt;MachineReadableLine1&gt;&lt;/MachineReadableLine1&gt;
                &lt;MachineReadableLine2&gt;&lt;/MachineReadableLine2&gt;
            &lt;/Passport&gt;
            &lt;Gender&gt;&lt;/Gender&gt;
        &lt;UniqueId&gt;&lt;/UniqueId&gt;
        &lt;/SearchBy&gt;
    &lt;/Row&gt;
&lt;/Identifier2Request&gt;
</pre>
*/




import iesp, OFAC_XG5, Risk_Indicators, Inquiry_AccLogs, AutoheaderV2, Risk_Reporting, Identifier2, STD;

export Identifier2_Service := MACRO
 
  WSInput.MAC_identifier2_service_GovIdAttributes();
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  ds_in := DATASET ([], iesp.mod_identifier2.t_Identifier2Request) : STORED ('Identifier2Request', FEW);
  first_row := ds_in[1] : independent;
  
  unsigned3 history_date         := 999999 : stored('HistoryDateYYYYMM');
  boolean  Test_Data_Enabled    := FALSE  : stored('TestDataEnabled');
  string20 Test_Data_Table_Name := ''     : stored('TestDataTableName');

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
    string10 InterfaceVersion   := '';
    #stored('_ESPClientInterfaceVersion', InterfaceVersion);
	string6 ssnmask             := 'NONE' : STORED('SSNMask');
	string6 dobmask	            := ''	: STORED('DOBMask');
	unsigned1 dlmask              := 0	: STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	boolean ExcludeDMVPII       := FALSE : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
  
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Identifier2__Identifier2_Service);
/* ************* End Scout Fields **************/

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
 // iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := global (first_row.SearchBy);
  options := global(first_row.Options);
	parsed_addr := identifier2.fn_make_address(search_by.address)[1].address;
	
	#stored( 'in_city', search_by.address.city);
	
	// perform zip/state matching prior to address cleaning. zip state match is true if and only if zip and state are input and zip is in the state
	doesZipMatchState :=
		options.VerifyInput.ZipMatchesState
		and trim(search_by.address.State) != ''
		and trim(search_by.address.zip5) != ''
		and ziplib.ZipToState2(trim(search_by.address.zip5)) = STD.Str.ToUpperCase( trim(search_by.address.State) );
	#stored( 'ZipStateMatch', doesZipMatchState);
	
	// Check for DOBMatch options and store if entered
	
	dobTemp := record
		risk_indicators.layouts.Layout_DOB_Match_Options;
	end;
    dob_temp := DATASET ([transform(dobTemp, self.DOBMatch := options.DOBMatch.MatchType, self.DOBMatchYearRadius := options.DOBMatch.MatchYearRadius)]);
	#stored ('DOBMatchOptions', dob_temp);	
	
	
	//if no parsed address in request fill in based on full address
	search_address := if (search_by.address.StreetNumber <> '' or 
	                      search_by.address.StreetName <> '' or 
												search_by.address.StreetAddress1 ='',
												// search_by.address, dataset([make_addr()]));
												search_by.address, parsed_addr);
    string28 streetName := search_address.StreetName;
    #stored ('prim_name', streetName);
    string10 streetNumber := search_address.StreetNumber;
    #stored ('prim_range', streetNumber);
    string2 streetPreDirection := search_address.StreetPreDirection;
    #stored ('predir', streetPreDirection);
    string2 streetPostDirection := search_address.StreetPostDirection;
    #stored ('postdir', streetPostDirection);
    string4 streetSuffix := search_address.StreetSuffix;
    #stored ('suffix', streetSuffix);
    string8 UnitNumber := search_address.UnitNumber;
    #stored ('sec_range', UnitNumber);
		string10 UnitDesig := search_address.unitdesignation;
		in_streetaddr := address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
    string60 in_streetAddress1 := IF(search_address.StreetAddress1='',in_streetAddr,search_address.StreetAddress1);
    string60 in_streetAddress2 := search_address.StreetAddress2;
    string addr := trim (in_streetAddress1) + ' ' + trim (in_streetAddress2);
    #stored('Addr',addr);
    string2 State := search_address.State;
    #stored ('State', State);
    string25 City := search_address.City;
    #stored ('City', City);
    string5 zip5 := search_address.Zip5; 
    #stored('zip',zip5);
    string18 County :=search_address.County;
		#stored('County',County);
    string50 StateCityZip := search_address.StateCityZip; 
    #stored('StateCityZip',StateCityZip);
  												
    #stored ('FirstName', search_by.Name.First);
    #stored ('MiddleName', search_by.Name.Middle);
    #stored ('LastName', search_by.Name.Last);
    #stored ('namesuffix', search_by.Name.Suffix); // unlikely used anywhere.
    #stored ('UnParsedFullName', search_by.Name.Full);	

	boolean useFML := true;
	#stored ('cleanNameFML', useFML);
  iesp.ECL2ESP.SetInputDate (search_by.DOB , 'DOB'); 
  unsigned8 dob_value_temp := 0 : stored('DOB');
	string    dob_value := if(dob_value_temp between 0101 and 1231, intformat(dob_value_temp,8,1), (string)dob_value_temp);
	#stored ('UnitDesignation', search_address.UnitDesignation);
	#stored ('StreetAddress',addr);  //instantid uses this value as input
	//process input specific for this service:
	#stored ('SSN',search_by.SSN);
	#stored ('DateOfBirth',dob_value);
	#stored ('Age',search_by.Age);
	#stored ('DLNumber',search_by.DriverLicenseNumber);
	#stored ('DLState',search_by.DriverLicenseState);
	boolean IncludeDLverification := (trim(search_by.DriverLicenseNumber)<>'' and trim(search_by.DriverLicenseState)<>'');	// do DL verification if both DL num and DL state are input
	#stored ('IncludeDLverification', IncludeDLverification);
	#stored ('IPAddress',search_by.IPAddress);
	#stored ('HomePhone',search_by.HomePhone);
	#stored ('WorkPhone',search_by.WorkPhone);
	#stored ('IncludeOfacOnly',options.IncludeOfacOnly);
	#stored ('ExcludeWatchLists',options.ExcludeWatchLists);
	unsigned1 tempOFACVersion := max(options.OFACVersion, 2); //default to version 2, unless a higher version is passed in
	#stored ('OFACVersion',tempOFACVersion); 
	#stored ('IncludeOfac',options.IncludeOfac);
	real gwt := options.GlobalWatchlistThreshold;
	real globalWatchlistThreshold :=  if (gwt=0.00, 0.84, gwt);
	#stored ('GlobalWatchlistThreshold',globalWatchlistThreshold);
	#stored ('IncludeAdditionalWatchLists',options.IncludeOtherWatchLists);
	lastSeen_Threshold := MAP((UNSIGNED)options.LastSeenThreshold > 0 => (UNSIGNED)options.LastSeenThreshold,
																																				risk_indicators.iid_constants.oneyear
														);
	#stored ('LastSeenThreshold', lastSeen_Threshold);
	
	ReturnAllRiskIndicators := (BOOLEAN)options.IncludeAllRiskIndicators; // Set to TRUE to return all Risk Indicators
	#stored('IncludeAllRiskIndicators', ReturnAllRiskIndicators);
	
	temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	end;
    watchlist_temp := DATASET ([transform(temp, self.Watchlist := options.Watchlists)]);
	#stored( 'Watchlist', watchlist_temp );
	
	
	boolean useDOB := search_by.UseDOBFilter or options.UseDOBFilter;
	#stored ('UseDOBFilter',useDOB);
	
	integer dobRadius := if( options.DOBRadius > 0, options.DOBRadius, search_by.DOBRadius );
	#stored ('DOBRadius',DOBRadius);
	STRING10 RedFlags_version := '' : STORED('RedFlags_version');
	redFlagsVersion := MAP(
													TRIM(options.RedFlagsReport) <> '' AND STD.Str.Contains(options.RedFlagsReport, 'version', TRUE) 	=> (INTEGER)(options.RedFlagsReport[8..]), // Check in-band first
													TRIM(RedFlags_version) <> '' AND STD.Str.Contains(RedFlags_version, 'version', TRUE) 							=> (INTEGER)(RedFlags_version[8..]), // Then check out-of-band
																																																																				0 // No Red Flags Requested
												);
	#stored ('RedFlag_version', redFlagsVersion);
	boolean disallowTargusE3220 := options.DisallowTargusEID3220;
	#stored ('IncludeTargusE3220',~disallowTargusE3220);

	#stored ('ExactFirstNameMatch',options.RequireExactMatch.FirstName);
	#stored ('ExactLastNameMatch',options.RequireExactMatch.LastName);
	#stored ('ExactAddrMatch',options.RequireExactMatch.Address);
	#stored ('ExactPhoneMatch',options.RequireExactMatch.HomePhone);
	#stored ('ExactSSNMatch',options.RequireExactMatch.SSN);
	#stored ('ExactDOBMatch',options.RequireExactMatch.DOB);
	#stored ('ExactFirstNameMatchAllowNicknames',options.RequireExactMatch.FirstNameAllowNickname);
	#stored ('CustomDataFilter',options.CustomDataFilter);
	#stored ('VerifyInputAddressMatchesKnownBad',options.VerifyInputAddressMatchesKnownBad);
	
	#stored ('CurrentlyOwnInputProperty',options.VerifyInputAddressPropertyOwnership.CurrentOwner);
	#stored ('EverOwnedInputProperty',options.VerifyInputAddressPropertyOwnership.EverOwner);
	#stored ('EverOwnedInputPropertyInPastNumberOfYears',options.VerifyInputAddressPropertyOwnership.EverOwnedPastYears);
	#stored ('OwnedAnyProperty',options.VerifyOwnedAnyProperty);

	string start_date1 := iesp.ECL2ESP.t_DateToString8(options.VerifyInputAddressOccupancy.EverOccupantStartDate);
	start_date := if( ''=trim(start_date1), '99999999', start_date1 );
	#stored ('CurrentOccupant',options.VerifyInputAddressOccupancy.CurrentOccupant);
	#stored ('EverOccupant',options.VerifyInputAddressOccupancy.EverOccupant);
	#stored ('EverOccupant_PastMonths', options.VerifyInputAddressOccupancy.EverOccupantPastMonths);
	#stored ('EverOccupant_StartDate', (unsigned4) start_date);
	#stored ('IncludeNAPData', options.VerifyInputAddressOccupancy.IncludeNAPData);

	#stored ('IncludeDiscoveredDOB',options.DiscoverDOB);
	#stored ('CompareDiscoveredDOBToSSN',options.ValidateDiscoveredDOBToSSN);
	#stored ('IncludeMultipleIdentities',options.ReturnMultipleIdentities );
	#stored ('VerifySSNExistsOnAnyAddress',options.VerifySSNExistsOnAnyAddress);
	
	#stored ('DOBMatchesSSN',options.VerifyInput.DOBMatchesSSN);
	#stored ('YOBMatchesSSN',options.VerifyInput.YOBMatchesSSN);
	#stored ('ZipMatchesState',options.VerifyInput.ZipMatchesState);
	#stored ('SSNLastDOB',options.VerifyInput.SSNMatchesLastAndDOB);
	
	#stored ('IncludeValidDEALicense',options.VerifyValidDEALicense);
	#stored ('IncludeValidProfessionalLicense',options.VerifyValidProfessionalLicense);
	#stored ('IncludeValidDriversLicense',options.VerifyValidDriversLicense);
	#stored ('NumberOfRiskCodesReturned',options.NumberOfRiskCodesReturned);
	
	#stored ('IncludePropertyData',options.IncludePropertyData);    
	#stored ('IncludeImposterData',options.IncludeMultipleIdentitiesData);    
	#stored ('IncludeDEALicenseData',options.IncludeDEALicenseData);    
	#stored ('IncludeProfLicenseData',options.IncludeProfessionalLicenseData);    
	#stored ('IncludeDriverLicenseData',options.IncludeDriversLicenseData);    
	#stored ('IncludeSSNExistData',options.IncludeSSNExistsData);    
	
	#stored ('MachineReadableLine1', search_by.Passport.MachineReadableLine1);
	#stored ('MachineReadableLine2', search_by.Passport.MachineReadableLine2);
	#stored ('Gender', search_by.Gender);
	#stored ('UniqueId', search_by.UniqueId);
	
  IF( options.OFACVersion != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlist_temp[1].WatchList, value),
      FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

	// With Emerging Identities changes, bump from BS version 3 to 51
	#stored( 'BSVersion', 51 );
  
  recs2 := Identifier2.Identifier2records : INDEPENDENT;
  recswGovId := Identifier2.getGovID(recs2,search_by,Options);
  recs := iesp.transform_identifier2(recswGovId);
	 
	 dRoyalties := Project(recswGovId, transform(Royalty.Layouts.Royalty,
																		self.royalty_type_code := left.royalty_type_code_targus,
                  self.royalty_type := left.royalty_type_targus,	
																		self.royalty_count := left.royalty_count_targus,
																		self.non_royalty_count := left.non_royalty_count_targus,
																		self.count_entity := left.count_entity_targus,
																		self := left));
	 
	// wrap it into output structure
	iesp.mod_identifier2.t_Identifier2Response SetResponse (iesp.mod_identifier2.t_Identifier2Result L) := transform
		Self._Header := iesp.ECL2ESP.GetHeaderRow ();
		self.RecordCount := 1;
		SELF.Result.RedFlagsReport.Version := redFlagsVersion;
		Self.Result := L;
	end;
	results := PROJECT (recs, SetResponse (Left));
  
  
	Deltabase_Logging_prep := project(recswGovId, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                  self.company_id := (Integer)CompanyID,
                                  self.login_id := _LoginID,
                                  self.product_id := Risk_Reporting.ProductID.Identifier2__Identifier2_Service,
                                  self.function_name := FunctionName,
                                  self.esp_method := ESPMethod,
                                  self.interface_version := InterfaceVersion,
                                  self.delivery_method := DeliveryMethod,
                                  self.date_added := (STRING8)Std.Date.Today(),
                                  self.death_master_purpose := DeathMasterPurpose,
                                  self.ssn_mask := ssnmask,
                                  self.dob_mask := dobmask,
                                  self.dl_mask := (STRING)dlmask,
                                  self.exclude_dmv_pii := IF(ExcludeDMVPII, '1', '0'),
                                  self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
                                  self.archive_opt_in := ArchiveOptIn,
                                  self.glb := (UNSIGNED1)first_row.User.GLBPurpose,
                                  self.dppa := (UNSIGNED1)first_row.User.DLPurpose,
                                  self.data_restriction_mask := first_row.User.DataRestrictionMask,
                                  self.data_permission_mask := first_row.User.DataPermissionMask,
                                  self.industry := Industry_Search[1].Industry,
                                  self.i_ssn := first_row.SearchBy.SSN,
                                  self.i_dob := INTFORMAT(first_row.SearchBy.DOB.Year, 4, 1) + INTFORMAT(first_row.SearchBy.DOB.Month, 2, 1) + INTFORMAT(first_row.SearchBy.DOB.Day, 2, 1),
                                  self.i_name_full := first_row.SearchBy.Name.Full,
                                  self.i_name_first := first_row.SearchBy.Name.First,
                                  self.i_name_last := first_row.SearchBy.Name.Last,
                                  self.i_address := first_row.SearchBy.Address.StreetAddress1,
                                  self.i_city := first_row.SearchBy.Address.City,
                                  self.i_state := first_row.SearchBy.Address.State,
                                  self.i_zip := first_row.SearchBy.Address.Zip5 + first_row.SearchBy.Address.Zip4,
                                  self.i_dl := first_row.SearchBy.DriverLicenseNumber,
                                  self.i_dl_state := first_row.SearchBy.DriverLicenseState,
                                  self.i_home_phone := first_row.SearchBy.HomePhone,
                                  self.i_model_name_1 := 'CVI';
                                  self.i_model_name_2 := first_row.Options.IncludeModels.ModelRequests[1].ModelName,
                                  self.o_score_1    := (STRING)left.ComprehensiveVerificationIndex;
                                  self.o_reason_1_1 := left.RiskIndicators[1].riskcode,
                                  self.o_reason_1_2 := left.RiskIndicators[2].riskcode,
                                  self.o_reason_1_3 := left.RiskIndicators[3].riskcode,
                                  self.o_reason_1_4 := left.RiskIndicators[4].riskcode,
                                  self.o_reason_1_5 := left.RiskIndicators[5].riskcode,
                                  self.o_reason_1_6 := left.RiskIndicators[6].riskcode,
                                  self.o_score_2 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].i, ''),
                                  self.o_reason_2_1 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].Reason_Codes[1].Reason_Code, ''),
                                  self.o_reason_2_2 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].Reason_Codes[2].Reason_Code, ''),
                                  self.o_reason_2_3 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].Reason_Codes[3].Reason_Code, ''),
                                  self.o_reason_2_4 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].Reason_Codes[4].Reason_Code, ''),
                                  self.o_reason_2_5 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].Reason_Codes[5].Reason_Code, ''),
                                  self.o_reason_2_6 := IF(self.i_model_name_2 != '', left.Models[1].Scores[1].Reason_Codes[6].Reason_Code, ''),
                                  self.o_lexid := (INTEGER)left.UniqueId,
                                  self := left,
                                  self := [] ));
																	
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
  
  IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output (results, named ('Results'));

output(dRoyalties, named('RoyaltySet'));
ENDMACRO;
// Identifier2_Service()