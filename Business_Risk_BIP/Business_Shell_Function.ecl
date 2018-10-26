IMPORT Address, BIPV2, BizLinkFull, Business_Header, Business_Risk_BIP, Cortera, Gateway, MDR, NID, RiskWise, Risk_Indicators, UT, std;

EXPORT Business_Shell_Function(DATASET(Business_Risk_BIP.Layouts.Input) InputOrig, 
															 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
															 DATASET(Cortera.layout_Retrotest_raw) ds_CorteraRetrotestRecsRaw = DATASET([],Cortera.layout_Retrotest_raw) ) := FUNCTION


	RESTRICTED_SET := ['0', ''];

	// Restrict SBFE data here in Business_Shell_Function to return blank fields in the SBFE datarow.
	restrict_sbfe   := Options.DataPermissionMask[12] IN RESTRICTED_SET;
	
	// Instantiate a helper module, which will provide functionality to process AltCompanyNames.
	modInp := Business_Risk_BIP.mod_InputDataset(InputOrig, Options);

	// Make sure that something is populated, even if we don't get a hit on the key, and verify that the attribute is included in the version we are running
	checkBlank(STRING field, STRING default_val, UNSIGNED minVersion=2) := MAP(Options.BusShellVersion < minVersion => '',
																																						 field = '' 												  => default_val, 
																																																								     field);
	// Function to blank out attributes that are not to be returned in the requested business shell version.
	checkVersion(STRING field, UNSIGNED minVersion=2) := IF(Options.BusShellVersion < minVersion, '', field);
	
	calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);
 
	// Generate the linking parameters to be used in BIP's kFetch (Key Fetch) - These parameters should be global so figure them out here and pass around appropriately
	linkingOptions := MODULE(BIPV2.mod_sources.iParams)
		EXPORT STRING DataRestrictionMask		:= Options.DataRestrictionMask; // Note: Must unfortunately leave as undefined STRING length to match the module definition
		EXPORT BOOLEAN ignoreFares					:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN ignoreFidelity				:= FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - since the Business Shell doesn't accept this input default it to FALSE to always utilize whatever the DataRestrictionMask allows
		EXPORT BOOLEAN AllowAll							:= IF(Options.AllowedSources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE); // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
		EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.GLB_OK(Options.GLBA_Purpose, FALSE /*isFCRA*/);
		EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.DPPA_OK(Options.DPPA_Purpose, FALSE /*isFCRA*/);
		EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPA_Purpose;
		EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBA_Purpose;
		EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
		EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
	END;
	
	// For the AllowedSourcesSet, only include the Dunn Bradstreet source if that source is explicitly 
	// allowed and drop any unallowed Marketing sources when Marketing Mode is turned on. Also, filter 
	// out Experian data for those Scoring products intended primarily for the purpose of commercial 
	// credit origination. E.g.:
	//   o   Small Business Attributes
	//   o   Small Business Attributes with SBFE Data
	//   o   Small Business Credit Score with SBFE Data
	//   o   Small Business Blended Credit Score with SBFE Data
	//   o   Small Business Risk Score
	AllowedSourcesSet := 
			SET(
				CHOOSEN(
					Business_Risk_BIP.Constants.AllowedSources(
							(
								Source <> MDR.SourceTools.src_Dunn_Bradstreet OR 
								StringLib.StringFind(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0
							) AND
							(
								Options.MarketingMode = Business_Risk_BIP.Constants.Default_MarketingMode OR 
								Source NOT IN SET(Business_Risk_BIP.Constants.MarketingRestrictedSources, Source)
							) AND
							(
								Options.OverrideExperianRestriction = True OR
								Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
							) AND
							(
							
								Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 OR
								Source <> MDR.SourceTools.Src_Cortera
							)	 AND
							(
							
								Options.DataRestrictionMask[42] IN ['', '0'] OR
								Source <> MDR.SourceTools.Src_Cortera
							)	
					), 
					300
				), 
				Source );
	
	// Add new records to the Input_orig dataset for each record having an AltCompanyName.
	Input := IF(Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v22, InputOrig, modInp.InputOrigPlusAltCompanyNames);
	
	// Clean up the input - parse the name, address, clean SSN, clean Phone, etc.
	Business_Risk_BIP.Layouts.Shell cleanInput(Business_Risk_BIP.Layouts.Input le, UNSIGNED2 seqCounter) := TRANSFORM
		SELF.Seq := seqCounter; // Uniquely Sequence our input
		SELF.Clean_Input.Seq := seqCounter;
		
		SELF.Input_Echo := le; // Keep our original input
		
		// Company Name Fields
		CompanyName := IF(le.CompanyName <> '', BizLinkFull.Fields.Make_cnp_name(le.CompanyName), BizLinkFull.Fields.Make_cnp_name(le.AltCompanyName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
		SELF.Clean_Input.CompanyName := CompanyName;
		SELF.Clean_Input.AltCompanyName := IF(le.CompanyName <> '', BizLinkFull.Fields.Make_cnp_name(le.AltCompanyName), ''); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line
		// Company Address Fields
		companyAddress := Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1 + ' ' + le.StreetAddress2, le.Prim_Range, le.Predir, le.Prim_Name, le.Addr_Suffix, le.Postdir, le.Unit_Desig, le.Sec_Range);
		companyCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(companyAddress, le.City, le.State, le.Zip);											
		cleanedCompanyAddress := Address.CleanFields(companyCleanAddr);
		SELF.Clean_Input.StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Predir, cleanedCompanyAddress.Prim_Name, 
																											cleanedCompanyAddress.Addr_Suffix, cleanedCompanyAddress.Postdir, cleanedCompanyAddress.Unit_Desig, cleanedCompanyAddress.Sec_Range);
		SELF.Clean_Input.StreetAddress2 := TRIM(StringLib.StringToUppercase(le.StreetAddress2));
		SELF.Clean_Input.Prim_Range := cleanedCompanyAddress.Prim_Range;
		SELF.Clean_Input.Predir := cleanedCompanyAddress.Predir;
		SELF.Clean_Input.Prim_Name := cleanedCompanyAddress.Prim_Name;
		SELF.Clean_Input.Addr_Suffix := cleanedCompanyAddress.Addr_Suffix;
		SELF.Clean_Input.Postdir := cleanedCompanyAddress.Postdir;
		SELF.Clean_Input.Unit_Desig := cleanedCompanyAddress.Unit_Desig;
		SELF.Clean_Input.Sec_Range := cleanedCompanyAddress.Sec_Range;
		SELF.Clean_Input.City := cleanedCompanyAddress.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.State := cleanedCompanyAddress.St;
		SELF.Clean_Input.Zip := cleanedCompanyAddress.Zip + cleanedCompanyAddress.Zip4;
		SELF.Clean_Input.Zip5 := cleanedCompanyAddress.Zip;
		SELF.Clean_Input.Zip4 := cleanedCompanyAddress.Zip4;
		SELF.Clean_Input.Lat := cleanedCompanyAddress.Geo_Lat;
		SELF.Clean_Input.Long := cleanedCompanyAddress.Geo_Long;
		SELF.Clean_Input.Addr_Type := cleanedCompanyAddress.Rec_Type;
		SELF.Clean_Input.Addr_Status := cleanedCompanyAddress.Err_Stat;
		SELF.Clean_Input.County := companyCleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Geo_Block := cleanedCompanyAddress.Geo_Blk;
		// Company Other PII
		filteredFEIN := StringLib.StringFilter(le.FEIN, '0123456789');
		SELF.Clean_Input.FEIN := IF(LENGTH(filteredFEIN) != 9 OR (INTEGER)filteredFEIN <= 0, '', filteredFEIN); // Filter out FEIN's that aren't 9-Bytes, or are repeating 0's
		BusPhone10 := RiskWise.CleanPhone(le.Phone10);
		SELF.Clean_Input.Phone10 := BusPhone10;
		SELF.Clean_Input.IPAddr := StringLib.StringFilter(le.IPAddr, '0123456789.');
		SELF.Clean_Input.CompanyURL := REGEXREPLACE('^WWW[. ]{0,1}',TRIM(REGEXREPLACE('[:/].*$',REGEXREPLACE('HTTP://',le.CompanyURL,'',NOCASE),''),LEFT,RIGHT),'',NOCASE);
		SELF.Clean_Input.SIC := StringLib.StringFilter(le.SIC, '0123456789');
		SELF.Clean_Input.NAIC := StringLib.StringFilter(le.NAIC, '0123456789');
		// Authorized Representative Name Fields
		cleanedName := Address.CleanPerson73(le.Rep_FullName);
		cleanedRepName := Address.CleanNameFields(cleanedName);
		BOOLEAN validCleaned := TRIM(le.Rep_FullName) <> '';
		SELF.Clean_Input.Rep_FullName := StringLib.StringToUpperCase(le.Rep_FullName);
		SELF.Clean_Input.Rep_NameTitle := TRIM(StringLib.StringToUppercase(IF(le.Rep_NameTitle = '' AND validCleaned,		cleanedRepName.Title, le.Rep_NameTitle)), LEFT, RIGHT);
		RepFirstName := TRIM(StringLib.StringToUppercase(IF(le.Rep_FirstName = '' AND validCleaned,		cleanedRepName.FName, le.Rep_FirstName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep_FirstName := RepFirstName;
		RepPreferredFirstName := StringLib.StringToUpperCase(NID.PreferredFirstNew(RepFirstName, TRUE /*UseNew*/));
		SELF.Clean_Input.Rep_PreferredFirstName := RepPreferredFirstName;
		SELF.Clean_Input.Rep_MiddleName := TRIM(StringLib.StringToUppercase(IF(le.Rep_MiddleName = '' AND validCleaned,	cleanedRepName.MName, le.Rep_MiddleName)), LEFT, RIGHT);
		RepLastName := TRIM(StringLib.StringToUppercase(IF(le.Rep_LastName = '' AND validCleaned,			cleanedRepName.LName, le.Rep_LastName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep_LastName := RepLastName;
		SELF.Clean_Input.Rep_NameSuffix := TRIM(StringLib.StringToUppercase(IF(le.Rep_NameSuffix = '' AND validCleaned,	cleanedRepName.Name_Suffix, le.Rep_NameSuffix)), LEFT, RIGHT);
		SELF.Clean_Input.Rep_FormerLastName := TRIM(StringLib.StringToUppercase(le.Rep_FormerLastName), LEFT, RIGHT);
		// Authorized Representative Address Fields
		repAddress := Risk_Indicators.MOD_AddressClean.street_address(le.Rep_StreetAddress1 + ' ' + le.Rep_StreetAddress2, le.Rep_Prim_Range, le.Rep_Predir, le.Rep_Prim_Name, le.Rep_Addr_Suffix, le.Rep_Postdir, le.Rep_Unit_Desig, le.Rep_Sec_Range);
		repCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(repAddress, le.Rep_City, le.Rep_State, le.Rep_Zip);											
		cleanedRepAddress := Address.CleanFields(repCleanAddr);
		SELF.Clean_Input.Rep_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRepAddress.Prim_Range, cleanedRepAddress.Predir, cleanedRepAddress.Prim_Name, 
																											cleanedRepAddress.Addr_Suffix, cleanedRepAddress.Postdir, cleanedRepAddress.Unit_Desig, cleanedRepAddress.Sec_Range);
		SELF.Clean_Input.Rep_StreetAddress2 := TRIM(StringLib.StringToUppercase(le.Rep_StreetAddress2));
		SELF.Clean_Input.Rep_Prim_Range := cleanedRepAddress.Prim_Range;
		SELF.Clean_Input.Rep_Predir := cleanedRepAddress.Predir;
		SELF.Clean_Input.Rep_Prim_Name := cleanedRepAddress.Prim_Name;
		SELF.Clean_Input.Rep_Addr_Suffix := cleanedRepAddress.Addr_Suffix;
		SELF.Clean_Input.Rep_Postdir := cleanedRepAddress.Postdir;
		SELF.Clean_Input.Rep_Unit_Desig := cleanedRepAddress.Unit_Desig;
		SELF.Clean_Input.Rep_Sec_Range := cleanedRepAddress.Sec_Range;
		SELF.Clean_Input.Rep_City := cleanedRepAddress.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.Rep_State := cleanedRepAddress.St;
		SELF.Clean_Input.Rep_Zip := cleanedRepAddress.Zip + cleanedRepAddress.Zip4;
		SELF.Clean_Input.Rep_Zip5 := cleanedRepAddress.Zip;
		SELF.Clean_Input.Rep_Zip4 := cleanedRepAddress.Zip4;
		SELF.Clean_Input.Rep_Lat := cleanedRepAddress.Geo_Lat;
		SELF.Clean_Input.Rep_Long := cleanedRepAddress.Geo_Long;
		SELF.Clean_Input.Rep_Addr_Type := cleanedRepAddress.Rec_Type;
		SELF.Clean_Input.Rep_Addr_Status := cleanedRepAddress.Err_Stat;
		SELF.Clean_Input.Rep_County := repCleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Rep_Geo_Block := cleanedRepAddress.Geo_Blk;
		// Authorized Representative Other PII
		filteredSSN := StringLib.StringFilter(le.Rep_SSN, '0123456789');
		SELF.Clean_Input.Rep_SSN := IF(LENGTH(filteredSSN) != 9 OR (INTEGER)filteredSSN <= 0, '', filteredSSN); // Filter out SSN's that aren't 9-Bytes, or are repeating 0's
		SELF.Clean_Input.Rep_DateOfBirth := RiskWise.CleanDOB(le.Rep_DateOfBirth);
		RepPhone10 := RiskWise.CleanPhone(le.Rep_Phone10);
		SELF.Clean_Input.Rep_Phone10 := RepPhone10;
		SELF.Clean_Input.Rep_Age := IF((INTEGER)le.Rep_Age = 0 AND (INTEGER)le.Rep_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep_DateOfBirth), (le.Rep_Age));
		SELF.Clean_Input.Rep_DLNumber := RiskWise.CleanDL_Num(le.Rep_DLNumber);
		SELF.Clean_Input.Rep_DLState := StringLib.StringToUpperCase(TRIM(le.Rep_DLState, LEFT, RIGHT));
		SELF.Clean_Input.Rep_Email := StringLib.StringToUpperCase(TRIM(le.Rep_Email, LEFT, RIGHT));
		SELF.Clean_Input.Rep_BusinessTitle := StringLib.StringToUpperCase(TRIM(le.Rep_BusinessTitle, LEFT, RIGHT));

		// Authorized Representative 2 Name Fields
		cleanedNameRep2 := Address.CleanPerson73(le.Rep2_FullName);
		cleanedRep2Name := Address.CleanNameFields(cleanedNameRep2);
		BOOLEAN validCleanedRep2 := TRIM(le.Rep2_FullName) <> '';
		SELF.Clean_Input.Rep2_FullName := StringLib.StringToUpperCase(le.Rep2_FullName);
		SELF.Clean_Input.Rep2_NameTitle := TRIM(StringLib.StringToUppercase(IF(le.Rep2_NameTitle = '' AND validCleanedRep2,		cleanedRep2Name.Title, le.Rep2_NameTitle)), LEFT, RIGHT);
		Rep2FirstName := TRIM(StringLib.StringToUppercase(IF(le.Rep2_FirstName = '' AND validCleanedRep2,		cleanedRep2Name.FName, le.Rep2_FirstName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep2_FirstName := Rep2FirstName;
		Rep2PreferredFirstName := StringLib.StringToUpperCase(NID.PreferredFirstNew(Rep2FirstName, TRUE /*UseNew*/));
		SELF.Clean_Input.Rep2_PreferredFirstName := Rep2PreferredFirstName;
		SELF.Clean_Input.Rep2_MiddleName := TRIM(StringLib.StringToUppercase(IF(le.Rep2_MiddleName = '' AND validCleanedRep2,	cleanedRep2Name.MName, le.Rep2_MiddleName)), LEFT, RIGHT);
		Rep2LastName := TRIM(StringLib.StringToUppercase(IF(le.Rep2_LastName = '' AND validCleanedRep2,			cleanedRep2Name.LName, le.Rep2_LastName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep2_LastName := Rep2LastName;
		SELF.Clean_Input.Rep2_NameSuffix := TRIM(StringLib.StringToUppercase(IF(le.Rep2_NameSuffix = '' AND validCleanedRep2,	cleanedRep2Name.Name_Suffix, le.Rep2_NameSuffix)), LEFT, RIGHT);
		SELF.Clean_Input.Rep2_FormerLastName := TRIM(StringLib.StringToUppercase(le.Rep2_FormerLastName), LEFT, RIGHT);
		// Authorized Representative 2 Address Fields
		rep2Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep2_StreetAddress1 + ' ' + le.Rep2_StreetAddress2, le.Rep2_Prim_Range, le.Rep2_Predir, le.Rep2_Prim_Name, le.Rep2_Addr_Suffix, le.Rep2_Postdir, le.Rep2_Unit_Desig, le.Rep2_Sec_Range);
		Rep2CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(rep2Address, le.Rep2_City, le.Rep2_State, le.Rep2_Zip);											
		cleanedRep2Address := Address.CleanFields(Rep2CleanAddr);
		SELF.Clean_Input.Rep2_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep2Address.Prim_Range, cleanedRep2Address.Predir, cleanedRep2Address.Prim_Name, 
																											cleanedRep2Address.Addr_Suffix, cleanedRep2Address.Postdir, cleanedRep2Address.Unit_Desig, cleanedRep2Address.Sec_Range);
		SELF.Clean_Input.Rep2_StreetAddress2 := TRIM(StringLib.StringToUppercase(le.Rep2_StreetAddress2));
		SELF.Clean_Input.Rep2_Prim_Range := cleanedRep2Address.Prim_Range;
		SELF.Clean_Input.Rep2_Predir := cleanedRep2Address.Predir;
		SELF.Clean_Input.Rep2_Prim_Name := cleanedRep2Address.Prim_Name;
		SELF.Clean_Input.Rep2_Addr_Suffix := cleanedRep2Address.Addr_Suffix;
		SELF.Clean_Input.Rep2_Postdir := cleanedRep2Address.Postdir;
		SELF.Clean_Input.Rep2_Unit_Desig := cleanedRep2Address.Unit_Desig;
		SELF.Clean_Input.Rep2_Sec_Range := cleanedRep2Address.Sec_Range;
		SELF.Clean_Input.Rep2_City := cleanedRep2Address.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.Rep2_State := cleanedRep2Address.St;
		SELF.Clean_Input.Rep2_Zip := cleanedRep2Address.Zip + cleanedRep2Address.Zip4;
		SELF.Clean_Input.Rep2_Zip5 := cleanedRep2Address.Zip;
		SELF.Clean_Input.Rep2_Zip4 := cleanedRep2Address.Zip4;
		SELF.Clean_Input.Rep2_Lat := cleanedRep2Address.Geo_Lat;
		SELF.Clean_Input.Rep2_Long := cleanedRep2Address.Geo_Long;
		SELF.Clean_Input.Rep2_Addr_Type := cleanedRep2Address.Rec_Type;
		SELF.Clean_Input.Rep2_Addr_Status := cleanedRep2Address.Err_Stat;
		SELF.Clean_Input.Rep2_County := Rep2CleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Rep2_Geo_Block := cleanedRep2Address.Geo_Blk;
		// Authorized Representative 2 Other PII
		filteredSSNRep2 := StringLib.StringFilter(le.Rep2_SSN, '0123456789');
		SELF.Clean_Input.Rep2_SSN := IF(LENGTH(filteredSSNRep2) != 9 OR (INTEGER)filteredSSNRep2 <= 0, '', filteredSSNRep2); // Filter out SSN's that aren't 9-Bytes, or are Rep2eating 0's
		SELF.Clean_Input.Rep2_DateOfBirth := RiskWise.CleanDOB(le.Rep2_DateOfBirth);
		Rep2Phone10 := RiskWise.CleanPhone(le.Rep2_Phone10);
		SELF.Clean_Input.Rep2_Phone10 := Rep2Phone10;
		SELF.Clean_Input.Rep2_Age := IF((INTEGER)le.Rep2_Age = 0 AND (INTEGER)le.Rep2_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep2_DateOfBirth), (le.Rep2_Age));
		SELF.Clean_Input.Rep2_DLNumber := RiskWise.CleanDL_Num(le.Rep2_DLNumber);
		SELF.Clean_Input.Rep2_DLState := StringLib.StringToUpperCase(TRIM(le.Rep2_DLState, LEFT, RIGHT));
		SELF.Clean_Input.Rep2_Email := StringLib.StringToUpperCase(TRIM(le.Rep2_Email, LEFT, RIGHT));
		SELF.Clean_Input.Rep2_BusinessTitle := StringLib.StringToUpperCase(TRIM(le.Rep2_BusinessTitle, LEFT, RIGHT));

		// Authorized Representative 3 Name Fields
		cleanedNameRep3 := Address.CleanPerson73(le.Rep3_FullName);
		cleanedRep3Name := Address.CleanNameFields(cleanedNameRep3);
		BOOLEAN validCleanedRep3 := TRIM(le.Rep3_FullName) <> '';
		SELF.Clean_Input.Rep3_FullName := StringLib.StringToUpperCase(le.Rep3_FullName);
		SELF.Clean_Input.Rep3_NameTitle := TRIM(StringLib.StringToUppercase(IF(le.Rep3_NameTitle = '' AND validCleanedRep3,		cleanedRep3Name.Title, le.Rep3_NameTitle)), LEFT, RIGHT);
		Rep3FirstName := TRIM(StringLib.StringToUppercase(IF(le.Rep3_FirstName = '' AND validCleanedRep3,		cleanedRep3Name.FName, le.Rep3_FirstName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep3_FirstName := Rep3FirstName;
		Rep3PreferredFirstName := StringLib.StringToUpperCase(NID.PreferredFirstNew(Rep3FirstName, TRUE /*UseNew*/));
		SELF.Clean_Input.Rep3_PreferredFirstName := Rep3PreferredFirstName;
		SELF.Clean_Input.Rep3_MiddleName := TRIM(StringLib.StringToUppercase(IF(le.Rep3_MiddleName = '' AND validCleanedRep3,	cleanedRep3Name.MName, le.Rep3_MiddleName)), LEFT, RIGHT);
		Rep3LastName := TRIM(StringLib.StringToUppercase(IF(le.Rep3_LastName = '' AND validCleanedRep3,			cleanedRep3Name.LName, le.Rep3_LastName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep3_LastName := Rep3LastName;
		SELF.Clean_Input.Rep3_NameSuffix := TRIM(StringLib.StringToUppercase(IF(le.Rep3_NameSuffix = '' AND validCleanedRep3,	cleanedRep3Name.Name_Suffix, le.Rep3_NameSuffix)), LEFT, RIGHT);
		SELF.Clean_Input.Rep3_FormerLastName := TRIM(StringLib.StringToUppercase(le.Rep3_FormerLastName), LEFT, RIGHT);
		// Authorized Representative 3 Address Fields
		Rep3Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep3_StreetAddress1 + ' ' + le.Rep3_StreetAddress2, le.Rep3_Prim_Range, le.Rep3_Predir, le.Rep3_Prim_Name, le.Rep3_Addr_Suffix, le.Rep3_Postdir, le.Rep3_Unit_Desig, le.Rep3_Sec_Range);
		Rep3CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(Rep3Address, le.Rep3_City, le.Rep3_State, le.Rep3_Zip);											
		cleanedRep3Address := Address.CleanFields(Rep3CleanAddr);
		SELF.Clean_Input.Rep3_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep3Address.Prim_Range, cleanedRep3Address.Predir, cleanedRep3Address.Prim_Name, 
																											cleanedRep3Address.Addr_Suffix, cleanedRep3Address.Postdir, cleanedRep3Address.Unit_Desig, cleanedRep3Address.Sec_Range);
		SELF.Clean_Input.Rep3_StreetAddress2 := TRIM(StringLib.StringToUppercase(le.Rep3_StreetAddress2));
		SELF.Clean_Input.Rep3_Prim_Range := cleanedRep3Address.Prim_Range;
		SELF.Clean_Input.Rep3_Predir := cleanedRep3Address.Predir;
		SELF.Clean_Input.Rep3_Prim_Name := cleanedRep3Address.Prim_Name;
		SELF.Clean_Input.Rep3_Addr_Suffix := cleanedRep3Address.Addr_Suffix;
		SELF.Clean_Input.Rep3_Postdir := cleanedRep3Address.Postdir;
		SELF.Clean_Input.Rep3_Unit_Desig := cleanedRep3Address.Unit_Desig;
		SELF.Clean_Input.Rep3_Sec_Range := cleanedRep3Address.Sec_Range;
		SELF.Clean_Input.Rep3_City := cleanedRep3Address.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.Rep3_State := cleanedRep3Address.St;
		SELF.Clean_Input.Rep3_Zip := cleanedRep3Address.Zip + cleanedRep3Address.Zip4;
		SELF.Clean_Input.Rep3_Zip5 := cleanedRep3Address.Zip;
		SELF.Clean_Input.Rep3_Zip4 := cleanedRep3Address.Zip4;
		SELF.Clean_Input.Rep3_Lat := cleanedRep3Address.Geo_Lat;
		SELF.Clean_Input.Rep3_Long := cleanedRep3Address.Geo_Long;
		SELF.Clean_Input.Rep3_Addr_Type := cleanedRep3Address.Rec_Type;
		SELF.Clean_Input.Rep3_Addr_Status := cleanedRep3Address.Err_Stat;
		SELF.Clean_Input.Rep3_County := Rep3CleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Rep3_Geo_Block := cleanedRep3Address.Geo_Blk;
		// Authorized Representative 3 Other PII
		filteredSSNRep3 := StringLib.StringFilter(le.Rep3_SSN, '0123456789');
		SELF.Clean_Input.Rep3_SSN := IF(LENGTH(filteredSSNRep3) != 9 OR (INTEGER)filteredSSNRep3 <= 0, '', filteredSSNRep3); // Filter out SSN's that aren't 9-Bytes, or are Rep3eating 0's
		SELF.Clean_Input.Rep3_DateOfBirth := RiskWise.CleanDOB(le.Rep3_DateOfBirth);
		Rep3Phone10 := RiskWise.CleanPhone(le.Rep3_Phone10);
		SELF.Clean_Input.Rep3_Phone10 := Rep3Phone10;
		SELF.Clean_Input.Rep3_Age := IF((INTEGER)le.Rep3_Age = 0 AND (INTEGER)le.Rep3_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep3_DateOfBirth), (le.Rep3_Age));
		SELF.Clean_Input.Rep3_DLNumber := RiskWise.CleanDL_Num(le.Rep3_DLNumber);
		SELF.Clean_Input.Rep3_DLState := StringLib.StringToUpperCase(TRIM(le.Rep3_DLState, LEFT, RIGHT));
		SELF.Clean_Input.Rep3_Email := StringLib.StringToUpperCase(TRIM(le.Rep3_Email, LEFT, RIGHT));
		SELF.Clean_Input.Rep3_BusinessTitle := StringLib.StringToUpperCase(TRIM(le.Rep3_BusinessTitle, LEFT, RIGHT));


	// Authorized Representative 4 Name Fields
		cleanedNameRep4 := Address.CleanPerson73(le.Rep4_FullName);
		cleanedRep4Name := Address.CleanNameFields(cleanedNameRep4);
		BOOLEAN validCleanedRep4 := TRIM(le.Rep4_FullName) <> '';
		SELF.Clean_Input.Rep4_FullName := StringLib.StringToUpperCase(le.Rep4_FullName);
		SELF.Clean_Input.Rep4_NameTitle := TRIM(StringLib.StringToUppercase(IF(le.Rep4_NameTitle = '' AND validCleanedRep4,		cleanedRep4Name.Title, le.Rep4_NameTitle)), LEFT, RIGHT);
		Rep4FirstName := TRIM(StringLib.StringToUppercase(IF(le.Rep4_FirstName = '' AND validCleanedRep4,		cleanedRep4Name.FName, le.Rep4_FirstName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep4_FirstName := Rep4FirstName;
		Rep4PreferredFirstName := StringLib.StringToUpperCase(NID.PreferredFirstNew(Rep4FirstName, TRUE /*UseNew*/));
		SELF.Clean_Input.Rep4_PreferredFirstName := Rep4PreferredFirstName;
		SELF.Clean_Input.Rep4_MiddleName := TRIM(StringLib.StringToUppercase(IF(le.Rep4_MiddleName = '' AND validCleanedRep4,	cleanedRep4Name.MName, le.Rep4_MiddleName)), LEFT, RIGHT);
		Rep4LastName := TRIM(StringLib.StringToUppercase(IF(le.Rep4_LastName = '' AND validCleanedRep4,			cleanedRep4Name.LName, le.Rep4_LastName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep4_LastName := Rep4LastName;
		SELF.Clean_Input.Rep4_NameSuffix := TRIM(StringLib.StringToUppercase(IF(le.Rep4_NameSuffix = '' AND validCleanedRep4,	cleanedRep4Name.Name_Suffix, le.Rep4_NameSuffix)), LEFT, RIGHT);
		SELF.Clean_Input.Rep4_FormerLastName := TRIM(StringLib.StringToUppercase(le.Rep4_FormerLastName), LEFT, RIGHT);
		// Authorized Representative 4 Address Fields
		rep4Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep4_StreetAddress1 + ' ' + le.Rep4_StreetAddress2, le.Rep4_Prim_Range, le.Rep4_Predir, le.Rep4_Prim_Name, le.Rep4_Addr_Suffix, le.Rep4_Postdir, le.Rep4_Unit_Desig, le.Rep4_Sec_Range);
		Rep4CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(rep4Address, le.Rep4_City, le.Rep4_State, le.Rep4_Zip);											
		cleanedRep4Address := Address.CleanFields(Rep4CleanAddr);
		SELF.Clean_Input.Rep4_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep4Address.Prim_Range, cleanedRep4Address.Predir, cleanedRep4Address.Prim_Name, 
																											cleanedRep4Address.Addr_Suffix, cleanedRep4Address.Postdir, cleanedRep4Address.Unit_Desig, cleanedRep4Address.Sec_Range);
		SELF.Clean_Input.Rep4_StreetAddress2 := TRIM(StringLib.StringToUppercase(le.Rep4_StreetAddress2));
		SELF.Clean_Input.Rep4_Prim_Range := cleanedRep4Address.Prim_Range;
		SELF.Clean_Input.Rep4_Predir := cleanedRep4Address.Predir;
		SELF.Clean_Input.Rep4_Prim_Name := cleanedRep4Address.Prim_Name;
		SELF.Clean_Input.Rep4_Addr_Suffix := cleanedRep4Address.Addr_Suffix;
		SELF.Clean_Input.Rep4_Postdir := cleanedRep4Address.Postdir;
		SELF.Clean_Input.Rep4_Unit_Desig := cleanedRep4Address.Unit_Desig;
		SELF.Clean_Input.Rep4_Sec_Range := cleanedRep4Address.Sec_Range;
		SELF.Clean_Input.Rep4_City := cleanedRep4Address.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.Rep4_State := cleanedRep4Address.St;
		SELF.Clean_Input.Rep4_Zip := cleanedRep4Address.Zip + cleanedRep4Address.Zip4;
		SELF.Clean_Input.Rep4_Zip5 := cleanedRep4Address.Zip;
		SELF.Clean_Input.Rep4_Zip4 := cleanedRep4Address.Zip4;
		SELF.Clean_Input.Rep4_Lat := cleanedRep4Address.Geo_Lat;
		SELF.Clean_Input.Rep4_Long := cleanedRep4Address.Geo_Long;
		SELF.Clean_Input.Rep4_Addr_Type := cleanedRep4Address.Rec_Type;
		SELF.Clean_Input.Rep4_Addr_Status := cleanedRep4Address.Err_Stat;
		SELF.Clean_Input.Rep4_County := Rep4CleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Rep4_Geo_Block := cleanedRep4Address.Geo_Blk;
		// Authorized Representative 4 Other PII
		filteredSSNRep4 := StringLib.StringFilter(le.Rep4_SSN, '0123456789');
		SELF.Clean_Input.Rep4_SSN := IF(LENGTH(filteredSSNRep4) != 9 OR (INTEGER)filteredSSNRep4 <= 0, '', filteredSSNRep4); // Filter out SSN's that aren't 9-Bytes, or are Rep2eating 0's
		SELF.Clean_Input.Rep4_DateOfBirth := RiskWise.CleanDOB(le.Rep4_DateOfBirth);
		Rep4Phone10 := RiskWise.CleanPhone(le.Rep4_Phone10);
		SELF.Clean_Input.Rep4_Phone10 := Rep4Phone10;
		SELF.Clean_Input.Rep4_Age := IF((INTEGER)le.Rep4_Age = 0 AND (INTEGER)le.Rep4_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep4_DateOfBirth), (le.Rep4_Age));
		SELF.Clean_Input.Rep4_DLNumber := RiskWise.CleanDL_Num(le.Rep4_DLNumber);
		SELF.Clean_Input.Rep4_DLState := StringLib.StringToUpperCase(TRIM(le.Rep4_DLState, LEFT, RIGHT));
		SELF.Clean_Input.Rep4_Email := StringLib.StringToUpperCase(TRIM(le.Rep4_Email, LEFT, RIGHT));
		SELF.Clean_Input.Rep4_BusinessTitle := StringLib.StringToUpperCase(TRIM(le.Rep4_BusinessTitle, LEFT, RIGHT));

	// Authorized Representative 5 Name Fields
		cleanedNameRep5 := Address.CleanPerson73(le.Rep5_FullName);
		cleanedRep5Name := Address.CleanNameFields(cleanedNameRep5);
		BOOLEAN validCleanedRep5 := TRIM(le.Rep5_FullName) <> '';
		SELF.Clean_Input.Rep5_FullName := StringLib.StringToUpperCase(le.Rep5_FullName);
		SELF.Clean_Input.Rep5_NameTitle := TRIM(StringLib.StringToUppercase(IF(le.Rep5_NameTitle = '' AND validCleanedRep5,		cleanedRep5Name.Title, le.Rep5_NameTitle)), LEFT, RIGHT);
		Rep5FirstName := TRIM(StringLib.StringToUppercase(IF(le.Rep5_FirstName = '' AND validCleanedRep5,		cleanedRep5Name.FName, le.Rep5_FirstName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep5_FirstName := Rep5FirstName;
		Rep5PreferredFirstName := StringLib.StringToUpperCase(NID.PreferredFirstNew(Rep5FirstName, TRUE /*UseNew*/));
		SELF.Clean_Input.Rep5_PreferredFirstName := Rep5PreferredFirstName;
		SELF.Clean_Input.Rep5_MiddleName := TRIM(StringLib.StringToUppercase(IF(le.Rep5_MiddleName = '' AND validCleanedRep5,	cleanedRep5Name.MName, le.Rep5_MiddleName)), LEFT, RIGHT);
		Rep5LastName := TRIM(StringLib.StringToUppercase(IF(le.Rep5_LastName = '' AND validCleanedRep5,			cleanedRep5Name.LName, le.Rep5_LastName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep5_LastName := Rep5LastName;
		SELF.Clean_Input.Rep5_NameSuffix := TRIM(StringLib.StringToUppercase(IF(le.Rep5_NameSuffix = '' AND validCleanedRep5,	cleanedRep5Name.Name_Suffix, le.Rep5_NameSuffix)), LEFT, RIGHT);
		SELF.Clean_Input.Rep5_FormerLastName := TRIM(StringLib.StringToUppercase(le.Rep5_FormerLastName), LEFT, RIGHT);
		// Authorized Representative 5 Address Fields
		rep5Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep5_StreetAddress1 + ' ' + le.Rep5_StreetAddress2, le.Rep5_Prim_Range, le.Rep5_Predir, le.Rep5_Prim_Name, le.Rep5_Addr_Suffix, le.Rep5_Postdir, le.Rep5_Unit_Desig, le.Rep5_Sec_Range);
		Rep5CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(rep5Address, le.Rep5_City, le.Rep5_State, le.Rep5_Zip);											
		cleanedRep5Address := Address.CleanFields(Rep5CleanAddr);
		SELF.Clean_Input.Rep5_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep5Address.Prim_Range, cleanedRep5Address.Predir, cleanedRep5Address.Prim_Name, 
																											cleanedRep5Address.Addr_Suffix, cleanedRep5Address.Postdir, cleanedRep5Address.Unit_Desig, cleanedRep5Address.Sec_Range);
		SELF.Clean_Input.Rep5_StreetAddress2 := TRIM(StringLib.StringToUppercase(le.Rep5_StreetAddress2));
		SELF.Clean_Input.Rep5_Prim_Range := cleanedRep5Address.Prim_Range;
		SELF.Clean_Input.Rep5_Predir := cleanedRep5Address.Predir;
		SELF.Clean_Input.Rep5_Prim_Name := cleanedRep5Address.Prim_Name;
		SELF.Clean_Input.Rep5_Addr_Suffix := cleanedRep5Address.Addr_Suffix;
		SELF.Clean_Input.Rep5_Postdir := cleanedRep5Address.Postdir;
		SELF.Clean_Input.Rep5_Unit_Desig := cleanedRep5Address.Unit_Desig;
		SELF.Clean_Input.Rep5_Sec_Range := cleanedRep5Address.Sec_Range;
		SELF.Clean_Input.Rep5_City := cleanedRep5Address.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.Rep5_State := cleanedRep5Address.St;
		SELF.Clean_Input.Rep5_Zip := cleanedRep5Address.Zip + cleanedRep2Address.Zip4;
		SELF.Clean_Input.Rep5_Zip5 := cleanedRep5Address.Zip;
		SELF.Clean_Input.Rep5_Zip4 := cleanedRep5Address.Zip4;
		SELF.Clean_Input.Rep5_Lat := cleanedRep5Address.Geo_Lat;
		SELF.Clean_Input.Rep5_Long := cleanedRep5Address.Geo_Long;
		SELF.Clean_Input.Rep5_Addr_Type := cleanedRep5Address.Rec_Type;
		SELF.Clean_Input.Rep5_Addr_Status := cleanedRep5Address.Err_Stat;
		SELF.Clean_Input.Rep5_County := Rep5CleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Rep5_Geo_Block := cleanedRep5Address.Geo_Blk;
		// Authorized Representative 5 Other PII
		filteredSSNRep5 := StringLib.StringFilter(le.Rep5_SSN, '0123456789');
		SELF.Clean_Input.Rep5_SSN := IF(LENGTH(filteredSSNRep5) != 9 OR (INTEGER)filteredSSNRep5 <= 0, '', filteredSSNRep5); // Filter out SSN's that aren't 9-Bytes, or are Rep2eating 0's
		SELF.Clean_Input.Rep5_DateOfBirth := RiskWise.CleanDOB(le.Rep5_DateOfBirth);
		Rep5Phone10 := RiskWise.CleanPhone(le.Rep5_Phone10);
		SELF.Clean_Input.Rep5_Phone10 := Rep5Phone10;
		SELF.Clean_Input.Rep5_Age := IF((INTEGER)le.Rep5_Age = 0 AND (INTEGER)le.Rep5_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep5_DateOfBirth), (le.Rep5_Age));
		SELF.Clean_Input.Rep5_DLNumber := RiskWise.CleanDL_Num(le.Rep5_DLNumber);
		SELF.Clean_Input.Rep5_DLState := StringLib.StringToUpperCase(TRIM(le.Rep5_DLState, LEFT, RIGHT));
		SELF.Clean_Input.Rep5_Email := StringLib.StringToUpperCase(TRIM(le.Rep5_Email, LEFT, RIGHT));
		SELF.Clean_Input.Rep5_BusinessTitle := StringLib.StringToUpperCase(TRIM(le.Rep5_BusinessTitle, LEFT, RIGHT));


		SELF.Clean_Input.HistoryDate := IF(le.HistoryDate <= 0, (INTEGER)Business_Risk_BIP.Constants.NinesDate, le.HistoryDate); // If HistoryDate not populated run in "realtime" mode
		SELF.Clean_Input.HistoryDateTime := IF(le.HistoryDateTime <= 0, (INTEGER)Business_Risk_BIP.Constants.NinesDateTime, le.HistoryDateTime); // If HistoryDateTime not populated run in "realtime" mode
		
		SELF.Clean_Input := le; // Fill out the remaining fields with what was passed in
		
		// Calculate all of the input populated attributes
		BusNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.CompanyName) <> '');
		SELF.Input.InputCheckBusName := BusNameCheck;
		SELF.Input.InputCheckBusAltName := Business_Risk_BIP.Common.SetBoolean(TRIM(le.AltCompanyName) <> '');
		BusAddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(companyAddress) <> ''); // To allow for both parsed and unparsed addresses check companyAddress
		SELF.Input.InputCheckBusAddr := BusAddrLine1Check;
		BusAddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.City) <> '');
		SELF.Input.InputCheckBusCity := BusAddrCityCheck;
		BusAddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.State) <> '');
		SELF.Input.InputCheckBusState := BusAddrStateCheck;
		BusAddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Zip) <> '');
		SELF.Input.InputCheckBusZip := BusAddrZipCheck;
    InputCheckBusAddrZip := checkVersion(Business_Risk_BIP.Common.SetBoolean(
                                         BusAddrLine1Check = '1' AND (BusAddrZipCheck = '1' OR (BusAddrCityCheck = '1' AND BusAddrStateCheck = '1'))), 
                                         Business_Risk_BIP.Constants.BusShellVersion_v30);
    SELF.Input.InputCheckBusAddrZip := InputCheckBusAddrZip;
    
		AddrPOBox := MAP(BusAddrLine1Check = '0' OR InputCheckBusAddrZip = '0'                     => '-1',
																			 Address.isPOBox(cleanedCompanyAddress.Prim_Name) = TRUE => '1',
																																																  '0');
		SELF.Verification.AddrPOBox	:= checkBlank(AddrPOBox, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);																																											
		SELF.Input.InputCheckBusFEIN := Business_Risk_BIP.Common.SetBoolean(TRIM(le.FEIN) <> '');
		BusPhoneCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Phone10) <> '');
		SELF.Input.InputCheckBusPhone := BusPhoneCheck;
		SELF.Input.InputCheckBusSIC  := Business_Risk_BIP.Common.SetBoolean(TRIM(le.SIC)  <> '');
		SELF.Input.InputCheckBusNAICS  := Business_Risk_BIP.Common.SetBoolean(TRIM(le.NAIC)  <> '');
		//SELF.Input.InputBusLexIDCheck  := Business_Risk_BIP.Common.SetBoolean(le.Bus_LexID  <> 0);
		SELF.Input.InputCheckBusStructure  := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Bus_Structure)  <> '');
		SELF.Input.InputCheckBusAge  := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Years_in_Business) <> '');
		BusStartDateValidate := Business_Risk_BIP.Common.checkInvalidDate(le.Bus_Start_Date, '', le.historydate);
		SELF.Input.InputCheckBusStartDate   := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Bus_Start_Date) <> '');
		SELF.Input.InputCheckBusAnnualRevenue   := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Yearly_Revenue)	  <> '');
		BusFax := RiskWise.CleanPhone(le.Fax_Number);
		SELF.Input.InputCheckBusFax  := Business_Risk_BIP.Common.SetBoolean(TRIM(BusFax)  <> '');		

		AuthRepFirstNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep_FullName) <> '' AND cleanedName[6..25] <> '') OR TRIM(le.Rep_FirstName) <> ''); // If the rep full name was passed in see if it cleaned to a first name
		SELF.Input.InputCheckAuthRepFirstName := AuthRepFirstNameCheck;
		AuthRepLastNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep_FullName) <> '' AND cleanedName[46..65] <> '') OR TRIM(le.Rep_LastName) <> ''); // Similarly check to see if it cleaned to a last name
		SELF.Input.InputCheckAuthRepLastName := AuthRepLastNameCheck;
		SELF.Input.InputCheckAuthRepMiddleName := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep_FullName) <> '' AND cleanedName[26..45] <> '') OR TRIM(le.Rep_MiddleName) <> ''); // And cleaned to a middle name
		AuthRepAddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(repAddress) <> '');
		SELF.Input.InputCheckAuthRepAddr := AuthRepAddrLine1Check;
		AuthRepAddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_City) <> '');
		SELF.Input.InputCheckAuthRepCity := AuthRepAddrCityCheck;
		AuthRepAddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_State) <> '');
		SELF.Input.InputCheckAuthRepState := AuthRepAddrStateCheck;
		AuthRepAddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_Zip) <> '');
		SELF.Input.InputCheckAuthRepZip := AuthRepAddrZipCheck;
    SELF.Input.InputCheckAuthRepSSN := calculateValueFor._InputCheckAuthRepsSSN(filteredSSN);
		AuthRepPhoneCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_Phone10) <> '');
		SELF.Input.InputCheckAuthRepPhone := AuthRepPhoneCheck;
		SELF.Input.InputCheckAuthRepAge := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_Age) <> '');
		SELF.Input.InputCheckAuthRepDOBYear := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep_DateOfBirth[1..4]) > 0);
		SELF.Input.InputCheckAuthRepDOBMonth := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep_DateOfBirth[5..6]) > 0);
		SELF.Input.InputCheckAuthRepDOBDay := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep_DateOfBirth[7..8]) > 0);
		SELF.Input.InputCheckAuthRepDL := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_DLNumber) <> '');
		SELF.Input.InputCheckAuthRepDLState := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_DLState) <> '');
		//SELF.Input.InputAuthRepFormerLastNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_FormerLastName) <> '');
		SELF.Input.InputCheckAuthRepTitle := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep_BusinessTitle) <> '');
		// Authorized Rep 2 Checks
		AuthRep2FirstNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep2_FullName) <> '' AND cleanedNameRep2[6..25] <> '') OR TRIM(le.Rep2_FirstName) <> ''); // If the Rep2 full name was passed in see if it cleaned to a first name
		SELF.Input.InputCheckAuthRep2FirstName := AuthRep2FirstNameCheck;
		AuthRep2LastNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep2_FullName) <> '' AND cleanedNameRep2[46..65] <> '') OR TRIM(le.Rep2_LastName) <> ''); // Similarly check to see if it cleaned to a last name
		SELF.Input.InputCheckAuthRep2LastName := AuthRep2LastNameCheck;
		SELF.Input.InputCheckAuthRep2MiddleName := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep2_FullName) <> '' AND cleanedNameRep2[26..45] <> '') OR TRIM(le.Rep2_MiddleName) <> ''); // And cleaned to a middle name
		AuthRep2AddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep2Address) <> '');
		SELF.Input.InputCheckAuthRep2Addr := AuthRep2AddrLine1Check;
		AuthRep2AddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_City) <> '');
		SELF.Input.InputCheckAuthRep2City := AuthRep2AddrCityCheck;
		AuthRep2AddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_State) <> '');
		SELF.Input.InputCheckAuthRep2State := AuthRep2AddrStateCheck;
		AuthRep2AddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_Zip) <> '');
		SELF.Input.InputCheckAuthRep2Zip := AuthRep2AddrZipCheck;
    SELF.Input.InputCheckAuthRep2SSN := calculateValueFor._InputCheckAuthRepsSSN(filteredSSNRep2);
		AuthRep2PhoneCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_Phone10) <> '');
		SELF.Input.InputCheckAuthRep2Phone := AuthRep2PhoneCheck;
		SELF.Input.InputCheckAuthRep2Age := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_Age) <> '');
		SELF.Input.InputCheckAuthRep2DOBYear := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep2_DateOfBirth[1..4]) > 0);
		SELF.Input.InputCheckAuthRep2DOBMonth := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep2_DateOfBirth[5..6]) > 0);
		SELF.Input.InputCheckAuthRep2DOBDay := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep2_DateOfBirth[7..8]) > 0);
		SELF.Input.InputCheckAuthRep2DL := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_DLNumber) <> '');
		SELF.Input.InputCheckAuthRep2DLState := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_DLState) <> '');
		//SELF.Input.InputAuthRep2FormerLastNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_FormerLastName) <> '');
		SELF.Input.InputCheckAuthRep2Title := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep2_BusinessTitle) <> '');
		// Authorized Rep 3 Checks
		AuthRep3FirstNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep3_FullName) <> '' AND cleanedNameRep3[6..25] <> '') OR TRIM(le.Rep3_FirstName) <> ''); // If the Rep3 full name was passed in see if it cleaned to a first name
		SELF.Input.InputCheckAuthRep3FirstName := AuthRep3FirstNameCheck;
		AuthRep3LastNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep3_FullName) <> '' AND cleanedNameRep3[46..65] <> '') OR TRIM(le.Rep3_LastName) <> ''); // Similarly check to see if it cleaned to a last name
		SELF.Input.InputCheckAuthRep3LastName := AuthRep3LastNameCheck;
		SELF.Input.InputCheckAuthRep3MiddleName := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep3_FullName) <> '' AND cleanedNameRep3[26..45] <> '') OR TRIM(le.Rep3_MiddleName) <> ''); // And cleaned to a middle name
		AuthRep3AddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep3Address) <> '');
		SELF.Input.InputCheckAuthRep3Addr := AuthRep3AddrLine1Check;
		AuthRep3AddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_City) <> '');
		SELF.Input.InputCheckAuthRep3City := AuthRep3AddrCityCheck;
		AuthRep3AddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_State) <> '');
		SELF.Input.InputCheckAuthRep3State := AuthRep3AddrStateCheck;
		AuthRep3AddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_Zip) <> '');
		SELF.Input.InputCheckAuthRep3Zip := AuthRep3AddrZipCheck;
    SELF.Input.InputCheckAuthRep3SSN := calculateValueFor._InputCheckAuthRepsSSN(filteredSSNRep3);
		AuthRep3PhoneCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_Phone10) <> '');
		SELF.Input.InputCheckAuthRep3Phone := AuthRep3PhoneCheck;
		SELF.Input.InputCheckAuthRep3Age := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_Age) <> '');
		SELF.Input.InputCheckAuthRep3DOBYear := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep3_DateOfBirth[1..4]) > 0);
		SELF.Input.InputCheckAuthRep3DOBMonth := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep3_DateOfBirth[5..6]) > 0);
		SELF.Input.InputCheckAuthRep3DOBDay := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep3_DateOfBirth[7..8]) > 0);
		SELF.Input.InputCheckAuthRep3DL := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_DLNumber) <> '');
		SELF.Input.InputCheckAuthRep3DLState := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_DLState) <> '');
		// SELF.Input.InputAuthRep3FormerLastNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_FormerLastName) <> '');
		SELF.Input.InputCheckAuthRep3Title := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep3_BusinessTitle) <> '');
		
		
		// Authorized Rep 4 Checks
		AuthRep4FirstNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep4_FullName) <> '' AND cleanedNameRep4[6..25] <> '') OR TRIM(le.Rep4_FirstName) <> ''); // If the Rep2 full name was passed in see if it cleaned to a first name
		SELF.Input.InputCheckAuthRep4FirstName := AuthRep4FirstNameCheck;
		AuthRep4LastNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep4_FullName) <> '' AND cleanedNameRep4[46..65] <> '') OR TRIM(le.Rep4_LastName) <> ''); // Similarly check to see if it cleaned to a last name
		SELF.Input.InputCheckAuthRep4LastName := AuthRep4LastNameCheck;
		SELF.Input.InputCheckAuthRep4MiddleName := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep4_FullName) <> '' AND cleanedNameRep4[26..45] <> '') OR TRIM(le.Rep4_MiddleName) <> ''); // And cleaned to a middle name
		AuthRep4AddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep4Address) <> '');
		SELF.Input.InputCheckAuthRep4Addr := AuthRep4AddrLine1Check;
		AuthRep4AddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_City) <> '');
		SELF.Input.InputCheckAuthRep4City := AuthRep4AddrCityCheck;
		AuthRep4AddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_State) <> '');
		SELF.Input.InputCheckAuthRep4State := AuthRep4AddrStateCheck;
		AuthRep4AddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_Zip) <> '');
		SELF.Input.InputCheckAuthRep4Zip := AuthRep4AddrZipCheck;
		SELF.Input.InputCheckAuthRep4SSN := MAP((INTEGER)filteredSSNRep4 <= 0			=> '0',
																									 LENGTH(TRIM(filteredSSNRep4)) = 4	=> '1',
																									 LENGTH(TRIM(filteredSSNRep4)) = 9	=> '2',
																																										     '0');
		AuthRep4PhoneCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_Phone10) <> '');
		SELF.Input.InputCheckAuthRep4Phone := AuthRep4PhoneCheck;
		SELF.Input.InputCheckAuthRep4Age := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_Age) <> '');
		SELF.Input.InputCheckAuthRep4DOBYear := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep4_DateOfBirth[1..4]) > 0);
		SELF.Input.InputCheckAuthRep4DOBMonth := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep4_DateOfBirth[5..6]) > 0);
		SELF.Input.InputCheckAuthRep4DOBDay := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep4_DateOfBirth[7..8]) > 0);
		SELF.Input.InputCheckAuthRep4DL := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_DLNumber) <> '');
		SELF.Input.InputCheckAuthRep4DLState := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_DLState) <> '');
		//SELF.Input.InputAuthRep4FormerLastNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_FormerLastName) <> '');
		SELF.Input.InputCheckAuthRep4Title := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep4_BusinessTitle) <> '');

		// Authorized Rep 5 Checks
		AuthRep5FirstNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep5_FullName) <> '' AND cleanedNameRep5[6..25] <> '') OR TRIM(le.Rep5_FirstName) <> ''); // If the Rep2 full name was passed in see if it cleaned to a first name
		SELF.Input.InputCheckAuthRep5FirstName := AuthRep5FirstNameCheck;
		AuthRep5LastNameCheck := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep5_FullName) <> '' AND cleanedNameRep5[46..65] <> '') OR TRIM(le.Rep5_LastName) <> ''); // Similarly check to see if it cleaned to a last name
		SELF.Input.InputCheckAuthRep5LastName := AuthRep5LastNameCheck;
		SELF.Input.InputCheckAuthRep5MiddleName := Business_Risk_BIP.Common.SetBoolean((TRIM(le.Rep5_FullName) <> '' AND cleanedNameRep5[26..45] <> '') OR TRIM(le.Rep5_MiddleName) <> ''); // And cleaned to a middle name
		AuthRep5AddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep5Address) <> '');
		SELF.Input.InputCheckAuthRep5Addr := AuthRep5AddrLine1Check;
		AuthRep5AddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_City) <> '');
		SELF.Input.InputCheckAuthRep5City := AuthRep5AddrCityCheck;
		AuthRep5AddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_State) <> '');
		SELF.Input.InputCheckAuthRep5State := AuthRep5AddrStateCheck;
		AuthRep5AddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_Zip) <> '');
		SELF.Input.InputCheckAuthRep5Zip := AuthRep5AddrZipCheck;
		SELF.Input.InputCheckAuthRep5SSN := MAP((INTEGER)filteredSSNRep5 <= 0			=> '0',
																									 LENGTH(TRIM(filteredSSNRep5)) = 4	=> '1',
																									 LENGTH(TRIM(filteredSSNRep5)) = 9	=> '2',
																																										     '0');
		AuthRep5PhoneCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_Phone10) <> '');
		SELF.Input.InputCheckAuthRep5Phone := AuthRep5PhoneCheck;
		SELF.Input.InputCheckAuthRep5Age := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_Age) <> '');
		SELF.Input.InputCheckAuthRep5DOBYear := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep5_DateOfBirth[1..4]) > 0);
		SELF.Input.InputCheckAuthRep5DOBMonth := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep5_DateOfBirth[5..6]) > 0);
		SELF.Input.InputCheckAuthRep5DOBDay := Business_Risk_BIP.Common.SetBoolean((INTEGER)(le.Rep5_DateOfBirth[7..8]) > 0);
		SELF.Input.InputCheckAuthRep5DL := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_DLNumber) <> '');
		SELF.Input.InputCheckAuthRep5DLState := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_DLState) <> '');
		//SELF.Input.InputAuthRep5FormerLastNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_FormerLastName) <> '');
		SELF.Input.InputCheckAuthRep5Title := Business_Risk_BIP.Common.SetBoolean(TRIM(le.Rep5_BusinessTitle) <> '');
		
		// Calculate attributes based purely on input
		// Check to see if the Authorized Rep Name is part of the Company Name
		BusNameAuthRepFirst := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, RepFirstName));
		BusNameAuthRepPreferredFirst := Business_Risk_BIP.Common.SetBoolean(TRIM(RepPreferredFirstName) <> '' AND calculateValueFor._BusNameAuthRepMatch(CompanyName, RepPreferredFirstName));
		BusNameAuthRepLast := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, RepLastName));
		BusNameAuthRepFull := Business_Risk_BIP.Common.SetBoolean((BusNameAuthRepFirst = '1' AND BusNameAuthRepLast = '1') OR (BusNameAuthRepPreferredFirst = '1' AND BusNameAuthRepLast = '1'));
		//rep 2
		BusNameAuthRep2First := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep2FirstName));
		BusNameAuthRep2PreferredFirst := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep2PreferredFirstName) <> '' AND calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep2PreferredFirstName));
		BusNameAuthRep2Last := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep2LastName));
		BusNameAuthRep2Full := Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep2First = '1' AND BusNameAuthRep2Last = '1') OR (BusNameAuthRep2PreferredFirst = '1' AND BusNameAuthRep2Last = '1'));
		//rep 3
		BusNameAuthRep3First := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep3FirstName));
		BusNameAuthRep3PreferredFirst := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep3PreferredFirstName) <> '' AND calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep3PreferredFirstName));
		BusNameAuthRep3Last := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep3LastName));
		BusNameAuthRep3Full := Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep3First = '1' AND BusNameAuthRep3Last = '1') OR (BusNameAuthRep3PreferredFirst = '1' AND BusNameAuthRep3Last = '1'));
	  //rep 4
		BusNameAuthRep4First := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep4FirstName));
		BusNameAuthRep4PreferredFirst := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep4PreferredFirstName) <> '' AND calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep4PreferredFirstName));
		BusNameAuthRep4Last := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep4LastName));
		BusNameAuthRep4Full := Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep4First = '1' AND BusNameAuthRep4Last = '1') OR (BusNameAuthRep4PreferredFirst = '1' AND BusNameAuthRep4Last = '1'));
	  //rep 5
		BusNameAuthRep5First := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep5FirstName));
		BusNameAuthRep5PreferredFirst := Business_Risk_BIP.Common.SetBoolean(TRIM(Rep5PreferredFirstName) <> '' AND calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep5PreferredFirstName));
		BusNameAuthRep5Last := Business_Risk_BIP.Common.SetBoolean(calculateValueFor._BusNameAuthRepMatch(CompanyName, Rep5LastName));
		BusNameAuthRep5Full := Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep5First = '1' AND BusNameAuthRep5Last = '1') OR (BusNameAuthRep5PreferredFirst = '1' AND BusNameAuthRep5Last = '1'));
		
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirstInput := IF(BusNameCheck = '0' OR AuthRepFirstNameCheck = '0', '-1', BusNameAuthRepFirst);
		
		// We can't have a preferred first name populated unless the regular first name is populated - keep this as the AuthRepFirstNameCheck like we have in the line above
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstInput := IF(BusNameCheck = '0' OR AuthRepFirstNameCheck = '0', '-1', BusNameAuthRepPreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLastInput := IF(BusNameCheck = '0' OR AuthRepLastNameCheck = '0', '-1', BusNameAuthRepLast);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFullInput := IF(BusNameCheck = '0' OR AuthRepFirstNameCheck = '0' OR AuthRepLastNameCheck = '0', '-1', BusNameAuthRepFull);
		PhoneMatched := Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(BusPhone10, RepPhone10));
		PhoneMatched2 := Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(BusPhone10, Rep2Phone10));
		PhoneMatched3 := Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(BusPhone10, Rep3Phone10));
		PhoneMatched4 := Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(BusPhone10, Rep4Phone10));
		PhoneMatched5 := Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(BusPhone10, Rep5Phone10));
		ZIPScore						:= Risk_Indicators.AddrScore.ZIP_Score(cleanedCompanyAddress.Zip, cleanedRepAddress.Zip);
		CityStateScore			:= Risk_Indicators.AddrScore.CityState_Score(cleanedCompanyAddress.V_City_Name, cleanedCompanyAddress.St, cleanedRepAddress.V_City_Name, cleanedRepAddress.St, '');
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressMatched			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Prim_Name, cleanedCompanyAddress.Sec_Range, 
																						cleanedRepAddress.Prim_Range, cleanedRepAddress.Prim_Name, cleanedRepAddress.Sec_Range,
																						ZIPScore, CityStateScore));
		AddressNotPopulated := BusAddrLine1Check = '0' OR BusAddrCityCheck = '0' OR BusAddrStateCheck = '0' OR BusAddrZipCheck = '0' OR
													 AuthRepAddrLine1Check = '0' OR AuthRepAddrCityCheck = '0' OR AuthRepAddrStateCheck = '0' OR AuthRepAddrZipCheck = '0';
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddrInput := IF(AddressNotPopulated, '-1', Business_Risk_BIP.Common.SetBoolean(AddressMatched));
		
		//REP 2
    SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FirstInput := IF(BusNameCheck = '0' OR AuthRep2FirstNameCheck = '0', '-1', BusNameAuthRep2First);
		// We can't have a preferred first name populated unless the regular first name is populated - keep this as the AuthRepFirstNameCheck like we have in the line above
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstInput := IF(BusNameCheck = '0' OR AuthRep2FirstNameCheck = '0', '-1', BusNameAuthRep2PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2LastInput := IF(BusNameCheck = '0' OR AuthRep2LastNameCheck = '0', '-1', BusNameAuthRep2Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FullInput := IF(BusNameCheck = '0' OR AuthRep2FirstNameCheck = '0' OR AuthRep2LastNameCheck = '0', '-1', BusNameAuthRep2Full);
		ZIPScore2						:= Risk_Indicators.AddrScore.ZIP_Score(cleanedCompanyAddress.Zip, cleanedRep2Address.Zip);
		CityStateScore2			:= Risk_Indicators.AddrScore.CityState_Score(cleanedCompanyAddress.V_City_Name, cleanedCompanyAddress.St, cleanedRep2Address.V_City_Name, cleanedRep2Address.St, '');
		CityStateZipMatched2	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressMatched2			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Prim_Name, cleanedCompanyAddress.Sec_Range, 
																						cleanedRep2Address.Prim_Range, cleanedRep2Address.Prim_Name, cleanedRep2Address.Sec_Range,
																						ZIPScore2, CityStateScore2));
		AddressNotPopulated2 := BusAddrLine1Check = '0' OR BusAddrCityCheck = '0' OR BusAddrStateCheck = '0' OR BusAddrZipCheck = '0' OR
													 AuthRep2AddrLine1Check = '0' OR AuthRep2AddrCityCheck = '0' OR AuthRep2AddrStateCheck = '0' OR AuthRep2AddrZipCheck = '0';
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddrInput := IF(AddressNotPopulated2, '-1', Business_Risk_BIP.Common.SetBoolean(AddressMatched2));		
		// rep 3
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FirstInput := IF(BusNameCheck = '0' OR AuthRep3FirstNameCheck = '0', '-1', BusNameAuthRep3First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstInput := IF(BusNameCheck = '0' OR AuthRep3FirstNameCheck = '0', '-1', BusNameAuthRep3PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3LastInput := IF(BusNameCheck = '0' OR AuthRep3LastNameCheck = '0', '-1', BusNameAuthRep3Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FullInput := IF(BusNameCheck = '0' OR AuthRep3FirstNameCheck = '0' OR AuthRep3LastNameCheck = '0', '-1', BusNameAuthRep3Full);
		ZIPScore3						:= Risk_Indicators.AddrScore.ZIP_Score(cleanedCompanyAddress.Zip, cleanedRep3Address.Zip);
		CityStateScore3			:= Risk_Indicators.AddrScore.CityState_Score(cleanedCompanyAddress.V_City_Name, cleanedCompanyAddress.St, cleanedRep3Address.V_City_Name, cleanedRep3Address.St, '');
		CityStateZipMatched3	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressMatched3			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Prim_Name, cleanedCompanyAddress.Sec_Range, 
																						cleanedRep3Address.Prim_Range, cleanedRep3Address.Prim_Name, cleanedRep3Address.Sec_Range,
																						ZIPScore3, CityStateScore3));
		AddressNotPopulated3 := BusAddrLine1Check = '0' OR BusAddrCityCheck = '0' OR BusAddrStateCheck = '0' OR BusAddrZipCheck = '0' OR
													 AuthRep3AddrLine1Check = '0' OR AuthRep3AddrCityCheck = '0' OR AuthRep3AddrStateCheck = '0' OR AuthRep3AddrZipCheck = '0';
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddrInput := IF(AddressNotPopulated3, '-1', Business_Risk_BIP.Common.SetBoolean(AddressMatched3));	
		
		// rep 4
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4FirstInput := IF(BusNameCheck = '0' OR AuthRep4FirstNameCheck = '0', '-1', BusNameAuthRep4First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstInput := IF(BusNameCheck = '0' OR AuthRep4FirstNameCheck = '0', '-1', BusNameAuthRep4PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4LastInput := IF(BusNameCheck = '0' OR AuthRep4LastNameCheck = '0', '-1', BusNameAuthRep4Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4FullInput := IF(BusNameCheck = '0' OR AuthRep4FirstNameCheck = '0' OR AuthRep4LastNameCheck = '0', '-1', BusNameAuthRep4Full);
		ZIPScore4						:= Risk_Indicators.AddrScore.ZIP_Score(cleanedCompanyAddress.Zip, cleanedRep4Address.Zip);
		CityStateScore4			:= Risk_Indicators.AddrScore.CityState_Score(cleanedCompanyAddress.V_City_Name, cleanedCompanyAddress.St, cleanedRep4Address.V_City_Name, cleanedRep4Address.St, '');
		CityStateZipMatched4	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressMatched4			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Prim_Name, cleanedCompanyAddress.Sec_Range, 
																						cleanedRep4Address.Prim_Range, cleanedRep4Address.Prim_Name, cleanedRep4Address.Sec_Range,
																						ZIPScore4, CityStateScore4));
		AddressNotPopulated4 := BusAddrLine1Check = '0' OR BusAddrCityCheck = '0' OR BusAddrStateCheck = '0' OR BusAddrZipCheck = '0' OR
													 AuthRep4AddrLine1Check = '0' OR AuthRep4AddrCityCheck = '0' OR AuthRep4AddrStateCheck = '0' OR AuthRep4AddrZipCheck = '0';
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddrInput := IF(AddressNotPopulated4, '-1', Business_Risk_BIP.Common.SetBoolean(AddressMatched4));	

		//REP 5
    SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5FirstInput := IF(BusNameCheck = '0' OR AuthRep5FirstNameCheck = '0', '-1', BusNameAuthRep5First);
		// We can't have a preferred first name populated unless the regular first name is populated - keep this as the AuthRepFirstNameCheck like we have in the line above
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstInput := IF(BusNameCheck = '0' OR AuthRep5FirstNameCheck = '0', '-1', BusNameAuthRep5PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5LastInput := IF(BusNameCheck = '0' OR AuthRep5LastNameCheck = '0', '-1', BusNameAuthRep5Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5FullInput := IF(BusNameCheck = '0' OR AuthRep5FirstNameCheck = '0' OR AuthRep5LastNameCheck = '0', '-1', BusNameAuthRep5Full);
		ZIPScore5						:= Risk_Indicators.AddrScore.ZIP_Score(cleanedCompanyAddress.Zip, cleanedRep5Address.Zip);
		CityStateScore5			:= Risk_Indicators.AddrScore.CityState_Score(cleanedCompanyAddress.V_City_Name, cleanedCompanyAddress.St, cleanedRep5Address.V_City_Name, cleanedRep5Address.St, '');
		CityStateZipMatched5	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressMatched5			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Prim_Name, cleanedCompanyAddress.Sec_Range, 
																						cleanedRep5Address.Prim_Range, cleanedRep5Address.Prim_Name, cleanedRep5Address.Sec_Range,
																						ZIPScore5, CityStateScore5));
		AddressNotPopulated5 := BusAddrLine1Check = '0' OR BusAddrCityCheck = '0' OR BusAddrStateCheck = '0' OR BusAddrZipCheck = '0' OR
													 AuthRep5AddrLine1Check = '0' OR AuthRep5AddrCityCheck = '0' OR AuthRep5AddrStateCheck = '0' OR AuthRep5AddrZipCheck = '0';
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddrInput := IF(AddressNotPopulated5, '-1', Business_Risk_BIP.Common.SetBoolean(AddressMatched5));	
	
		
		
		InputAddrValid := MAP(TRIM(companyAddress) = '' OR InputCheckBusAddrZip = '0' => '-1', // No Company Address Input
													cleanedCompanyAddress.Err_Stat[1] = 'E'                 => '0',  // Error cleaning Address - Invalid
                                                                                     '1'); // Company Address Input and it passed the address cleaner
		SELF.Verification.InputAddrValid := InputAddrValid;										                 // This will get set to -1 below if no BIP IDs assigned
    SELF.Verification.InputAddrValidNoID := calculateValueFor._InputAddrValidNoID(InputAddrValid);
															
		InputPhoneValid := IF(TRIM(le.Phone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Business_Risk_BIP.Common.validPhone(le.Phone10)));													
		SELF.Verification.InputPhoneValid := InputPhoneValid; 		// This will get set to -1 below if no BIP IDs assigned
		
    SELF.Verification.InputPhoneValidNoID := calculateValueFor._InputPhoneValidNoID(InputPhoneValid);
		
		InputFEINValid := IF(TRIM(filteredFEIN) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Business_Header.ValidFEIN((INTEGER)filteredFEIN)));
		SELF.Verification.InputFEINValid := InputFEINValid;				// This will get set to -1 below if no BIP IDs assigned
    SELF.Verification.InputFEINValidNoID := calculateValueFor._InputFEINValidNoID(InputFEINValid);
		
		SELF := []; // None of the remaining attributes have been populated yet
	END;
	cleanedInput := PROJECT(Input, cleanInput(LEFT, COUNTER));
		
	Risk_Indicators.Layout_Input prepForDIDAppend(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		SELF.Seq := le.Clean_Input.Seq;
		SELF.HistoryDate := le.Clean_Input.HistoryDate;
		SELF.Title := le.Clean_Input.Rep_NameTitle;
		SELF.FName := le.Clean_Input.Rep_FirstName;
		SELF.MName := le.Clean_Input.Rep_MiddleName;
		SELF.LName := le.Clean_Input.Rep_LastName;
		SELF.Suffix := le.Clean_Input.Rep_NameSuffix;
		SELF.In_StreetAddress := le.Clean_Input.Rep_StreetAddress1;
		SELF.In_City := le.Clean_Input.Rep_City;
		SELF.In_State := le.Clean_Input.Rep_State;
		SELF.In_ZipCode := le.Clean_Input.Rep_Zip;
		SELF.Prim_Range := le.Clean_Input.Rep_Prim_Range;
		SELF.Predir := le.Clean_Input.Rep_Predir;
		SELF.Prim_Name := le.Clean_Input.Rep_Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Rep_Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Rep_Postdir;
		SELF.Unit_Desig := le.Clean_Input.Rep_Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Rep_Sec_Range;
		SELF.P_City_Name := le.Clean_Input.Rep_City;
		SELF.St := le.Clean_Input.Rep_State;
		SELF.Z5 := le.Clean_Input.Rep_Zip5;
		SELF.Zip4 := le.Clean_Input.Rep_Zip4;
		SELF.Lat := le.Clean_Input.Rep_Lat;
		SELF.Long := le.Clean_Input.Rep_Long;
		SELF.County := le.Clean_Input.Rep_County;
		SELF.Geo_Blk := le.Clean_Input.Rep_Geo_Block;
		SELF.Addr_Type := le.Clean_Input.Rep_Addr_Type;
		SELF.Addr_Status := le.Clean_Input.Rep_Addr_Status;
		SELF.SSN := le.Clean_Input.Rep_SSN;
		SELF.DOB := le.Clean_Input.Rep_DateOfBirth;
		SELF.Age := le.Clean_Input.Rep_Age;
		SELF.DL_Number := le.Clean_Input.Rep_DLNumber;
		SELF.DL_State := le.Clean_Input.Rep_DLState;
		SELF.Email_Address := le.Clean_Input.Rep_Email;
		SELF.Phone10 := le.Clean_Input.Rep_Phone10;
		
		SELF := [];
	END;
	prepDIDAppend := PROJECT(cleanedInput, prepForDIDAppend(LEFT));
	
	DIDAppend := Risk_Indicators.iid_getDID_prepOutput(prepDIDAppend,
																										Options.DPPA_Purpose,
																										Options.GLBA_Purpose,
																										FALSE, /*isFCRA*/
																										50, /*BSVersion*/
																										Options.DataRestrictionMask,
																										0, /*Append_Best*/
																										DATASET([], Gateway.Layouts.Config), /*Gateways*/
																										0 /*BSOptions*/);
																										
	// Pick the DID with the highest score, in the event that multiple have the same score, choose the lowest value DID to make this deterministic
	DIDKept := ROLLUP(SORT(DIDAppend, Seq, -Score, DID), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
	
	withDID := JOIN(cleanedInput, DIDKept, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell, 
																								SELF.Clean_Input.Rep_LexID := RIGHT.DID;
																								SELF.Clean_Input.Rep_LexIDScore := RIGHT.Score;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// Grab just the clean input to pass to the BIP Linking Process
	prepBIPAppend := PROJECT(withDID, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF := LEFT.Clean_Input));
	
	BIPAppend := Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend, , Options.DoNotUseAuthRepInBIPAppend);
	
	withBIP := JOIN(withDID, BIPAppend, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.BIP_IDs := RIGHT;
																								SELF.Verification.InputIDMatchConfidence := checkBlank((STRING)RIGHT.Weight, '0');
																								SELF.Verification.InputIDMatchPowID		:= (STRING)RIGHT.PowID.LinkID;
																								SELF.Verification.InputIDMatchProxID	:= (STRING)RIGHT.ProxID.LinkID;
																								SELF.Verification.InputIDMatchSeleID	:= (STRING)RIGHT.SeleID.LinkID;
																								SELF.Verification.InputIDMatchOrgID		:= (STRING)RIGHT.OrgID.LinkID;
																								SELF.Verification.InputIDMatchUltID		:= (STRING)RIGHT.UltID.LinkID;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	// Search by FEIN before we take out inputs with no BIP IDs assigned.
	WatchListHit := Business_Risk_BIP.getWatchlists(withBIP, Options, linkingOptions, AllowedSourcesSet);
		
	Phone := Business_Risk_BIP.getPhones(withBIP, Options, linkingOptions, AllowedSourcesSet);
	
	InputBasedSources := Business_Risk_BIP.getInputBasedSources(withBIP, Options, linkingOptions, AllowedSourcesSet); 
	
	BusinessByFEIN := Business_Risk_BIP.getBusinessByFEIN(withBIP, Options, linkingOptions, AllowedSourcesSet); 
	
	BusinessByPhone := Business_Risk_BIP.getBusinessByPhone(withBIP, Options, linkingOptions, AllowedSourcesSet); 
	
	BusinessByAddress := Business_Risk_BIP.getBusinessByAddress(withBIP, Options, linkingOptions, AllowedSourcesSet); 
  
  InquiriesByInputs := Business_Risk_BIP.getInquiriesByInputs(withBIP, Options, linkingOptions, AllowedSourcesSet); 

  PropertyByInputs := Business_Risk_BIP.getPropertyByInputs(withBIP, Options, linkingOptions, AllowedSourcesSet); 
  
	withWatchlists := JOIN(withBIP, WatchlistHit, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.WatchlistHits := RIGHT.WatchlistHits;
																								VerWatchlistNameMatch := IF(TRIM(LEFT.Clean_Input.CompanyName)='' AND TRIM(LEFT.Clean_Input.AltCompanyName)='', '-1', RIGHT.Verification.VerWatchlistNameMatch);
																								SELF.Verification.VerWatchlistNameMatch := checkBlank(VerWatchlistNameMatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	 withPhone := JOIN(withWatchlists, Phone, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Input_Characteristics.InputPhoneProblems  :=  RIGHT.Input_Characteristics.InputPhoneProblems,
																								SELF.Input_Characteristics.InputPhoneEntityCount := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22, RIGHT.Input_Characteristics.InputPhoneEntityCount, LEFT.Input_Characteristics.InputPhoneEntityCount),
																								SELF.Input_Characteristics.InputPhoneMobile := checkBlank(RIGHT.Input_Characteristics.InputPhoneMobile, '0'),
																								SELF.Verification.PhoneResidential := checkBlank(RIGHT.Verification.PhoneResidential, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.PhoneDisconnected := checkBlank(RIGHT.Verification.PhoneDisconnected, '2'); // A 2 indicates "Unknown"
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																								
	withInputBasedSources := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v21, withPhone, // unless running version 2.2 or higher we don't need any of the 'input based' attributes
																					JOIN(withPhone, InputBasedSources, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,

																								SELF.Verification.AddrZipType := checkBlank(RIGHT.Verification.AddrZipType, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.AddrZipMismatch := checkBlank(RIGHT.Verification.AddrZipMismatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Input_Characteristics.InputAddrTypeNoID := checkBlank(RIGHT.Input_Characteristics.InputAddrTypeNoID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Verification.InputAddrVacancyNoID := checkBlank( calculateValueFor._InputAddrVacancyNoID(RIGHT.Verification.InputAddrVacancyNoID), '0', Business_Risk_BIP.Constants.BusShellVersion_v22 ),
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));
																																				
	withBusinessByFEIN := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v21, withInputBasedSources, // unless running version 2.2 or higher we don't need any of the 'input based' attributes
																					JOIN(withInputBasedSources, BusinessByFEIN, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Verification.FEINOnFile := checkBlank(RIGHT.Verification.FEINOnFile, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINBusinessMismatch := checkBlank(RIGHT.Verification.FEINBusinessMismatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINAddrNameMismatch := checkBlank(RIGHT.Verification.FEINAddrNameMismatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Input_Characteristics.InputTINEntityCount := checkBlank(RIGHT.Input_Characteristics.InputTINEntityCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputTINEntityCount24Mos := checkBlank(RIGHT.Input_Characteristics.InputTINEntityCount24Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputTINEntityCount12Mos := checkBlank(RIGHT.Input_Characteristics.InputTINEntityCount12Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputTINEntityCount06Mos := checkBlank(RIGHT.Input_Characteristics.InputTINEntityCount06Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputTINEntityCount03Mos := checkBlank(RIGHT.Input_Characteristics.InputTINEntityCount03Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputTINEntityCount01Mos := checkBlank(RIGHT.Input_Characteristics.InputTINEntityCount01Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));
																						
	withBusinessByPhone := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22, withBusinessByFEIN, // unless running version 3.0 or higher we don't need any of the 'input based' attributes
																					JOIN(withBusinessByFEIN, BusinessByPhone, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                                SELF.Input_Characteristics.InputPhoneEntityCount := checkBlank(RIGHT.Input_Characteristics.InputPhoneEntityCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputPhoneEntityCount24Mos := checkBlank(RIGHT.Input_Characteristics.InputPhoneEntityCount24Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputPhoneEntityCount12Mos := checkBlank(RIGHT.Input_Characteristics.InputPhoneEntityCount12Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputPhoneEntityCount06Mos := checkBlank(RIGHT.Input_Characteristics.InputPhoneEntityCount06Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputPhoneEntityCount03Mos := checkBlank(RIGHT.Input_Characteristics.InputPhoneEntityCount03Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Input_Characteristics.InputPhoneEntityCount01Mos := checkBlank(RIGHT.Input_Characteristics.InputPhoneEntityCount01Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));
																						
	withBusinessByAddress := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22, withBusinessByPhone, // unless running version 3.0 or higher we don't need any of the 'input based' attributes
																					JOIN(withBusinessByPhone, BusinessByAddress, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Input_Characteristics.InputAddrTINCount := checkBlank(RIGHT.Input_Characteristics.InputAddrTINCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeenEver := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountFirstSeenEver, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen24Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen24Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen12Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen12Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen06Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen06Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen03Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen03Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen01Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountFirstSeen01Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount24Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount24Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount12Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount12Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount06Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount06Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount03Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount03Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount01Mos := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount01Mos, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountActive := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountActive, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountInactive := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountInactive, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCountDefunct := checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCountDefunct, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																							SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));		
  
  withInquiriesByInputs := JOIN(withBusinessByAddress, InquiriesByInputs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Inquiry.InquiryBusAddress := checkBlank(RIGHT.Inquiry.InquiryBusAddress, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusAddress01Mos := checkBlank(RIGHT.Inquiry.InquiryBusAddress01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusAddress03Mos := checkBlank(RIGHT.Inquiry.InquiryBusAddress03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusAddress06Mos := checkBlank(RIGHT.Inquiry.InquiryBusAddress06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusAddress12Mos := checkBlank(RIGHT.Inquiry.InquiryBusAddress12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusAddress24Mos := checkBlank(RIGHT.Inquiry.InquiryBusAddress24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusPhone := checkBlank(RIGHT.Inquiry.InquiryBusPhone, '-1');
																								SELF.Inquiry.InquiryBusPhone01Mos := checkBlank(RIGHT.Inquiry.InquiryBusPhone01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusPhone03Mos := checkBlank(RIGHT.Inquiry.InquiryBusPhone03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusPhone06Mos := checkBlank(RIGHT.Inquiry.InquiryBusPhone06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusPhone12Mos := checkBlank(RIGHT.Inquiry.InquiryBusPhone12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusPhone24Mos := checkBlank(RIGHT.Inquiry.InquiryBusPhone24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusFEIN := checkBlank(RIGHT.Inquiry.InquiryBusFEIN, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusFEIN01Mos := checkBlank(RIGHT.Inquiry.InquiryBusFEIN01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusFEIN03Mos := checkBlank(RIGHT.Inquiry.InquiryBusFEIN03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusFEIN06Mos := checkBlank(RIGHT.Inquiry.InquiryBusFEIN06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusFEIN12Mos := checkBlank(RIGHT.Inquiry.InquiryBusFEIN12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryBusFEIN24Mos := checkBlank(RIGHT.Inquiry.InquiryBusFEIN24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddress := checkBlank(RIGHT.Inquiry.InquiryConsumerAddress, '-1');
																								SELF.Inquiry.InquiryConsumerAddress01Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddress01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddress03Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddress03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddress06Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddress06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddress12Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddress12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddressSSN := checkBlank(RIGHT.Inquiry.InquiryConsumerAddressSSN, '-1');
																								SELF.Inquiry.InquiryConsumerAddressSSN01Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddressSSN01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddressSSN03Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddressSSN03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddressSSN06Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddressSSN06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerAddressSSN12Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerAddressSSN12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerPhone := checkBlank(RIGHT.Inquiry.InquiryConsumerPhone, '-1');
																								SELF.Inquiry.InquiryConsumerPhone01Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerPhone01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerPhone03Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerPhone03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerPhone06Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerPhone06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerPhone12Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerPhone12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerSSN := checkBlank(RIGHT.Inquiry.InquiryConsumerSSN, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerSSN01Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerSSN01Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerSSN03Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerSSN03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerSSN06Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerSSN06Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Inquiry.InquiryConsumerSSN12Mos := checkBlank(RIGHT.Inquiry.InquiryConsumerSSN12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW); 

  withPropertyByInputs := JOIN(withInquiriesByInputs, PropertyByInputs, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Input_Characteristics.InputAddrLotSize := checkBlank(RIGHT.Input_Characteristics.InputAddrLotSize, '0');
																								SELF.Input_Characteristics.InputAddrAssessedTotal := checkBlank(RIGHT.Input_Characteristics.InputAddrAssessedTotal, '0');
																								SELF.Input_Characteristics.InputAddrSqFootage := checkBlank(RIGHT.Input_Characteristics.InputAddrSqFootage, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW); 
                                                
  withAuthRepLexIDs := Business_Risk_BIP.getAuthRepLexIDs(withPropertyByInputs, Options);
  
	// Don't bother running a bunch of searches on Seq's that didn't find any ID's, just add them back at the end
	NoLinkIDsFound := withAuthRepLexIDs (BIP_IDs.PowID.LinkID = 0 AND BIP_IDs.ProxID.LinkID = 0 AND BIP_IDs.SeleID.LinkID = 0 AND BIP_IDs.OrgID.LinkID = 0 AND BIP_IDs.UltID.LinkID = 0);
	// Only run the searches with Seq's that found BIP Link ID's that we can search with
	LinkIDsFoundTemp := withAuthRepLexIDs (BIP_IDs.PowID.LinkID <> 0 OR BIP_IDs.ProxID.LinkID <> 0 OR BIP_IDs.SeleID.LinkID <> 0 OR BIP_IDs.OrgID.LinkID <> 0 OR BIP_IDs.UltID.LinkID <> 0);
	// Append "Best" Company information if only BIP ID's were passed in and it was requested in the Options that we perform the BIPBestAppend process, otherwise this function just returns what was sent to it
	LinkIDsFound := Business_Risk_BIP.BIP_Best_Append(LinkIDsFoundTemp, Options, linkingOptions, AllowedSourcesSet);
	
	// Go out and grab the various data/attributes

	BestBusinessInfo := Business_Risk_BIP.getBestBusinessInfo(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);

	withBestBusinessInfo :=  IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22, LinkIDsFound, 
																						JOIN(LinkIDsFound, BestBusinessInfo, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Best_Info.BestCompanyName := RIGHT.Best_Info.BestCompanyName;
																								SELF.Best_Info.BestCompanyAddress1 := RIGHT.Best_Info.BestCompanyAddress1;
																								SELF.Best_Info.BestCompanyCity := RIGHT.Best_Info.BestCompanyCity;
																								SELF.Best_Info.BestCompanyState := RIGHT.Best_Info.BestCompanyState;
																								SELF.Best_Info.BestCompanyZip := RIGHT.Best_Info.BestCompanyZip;
																								SELF.Best_Info.BestCompanyFEIN := RIGHT.Best_Info.BestCompanyFEIN;
																								SELF.Best_Info.BestCompanyPhone := RIGHT.Best_Info.BestCompanyPhone;
																								SELF.Best_Info.BestPrimRange := RIGHT.Best_Info.BestPrimRange;
																								SELF.Best_Info.BestPreDir := RIGHT.Best_Info.BestPreDir;
																								SELF.Best_Info.BestPrimName := RIGHT.Best_Info.BestPrimName;
																								SELF.Best_Info.BestAddrSuffix := RIGHT.Best_Info.BestAddrSuffix;
																								SELF.Best_Info.BestPostDir := RIGHT.Best_Info.BestPostDir;
																								SELF.Best_Info.BestUnitDesig := RIGHT.Best_Info.BestUnitDesig;
																								SELF.Best_Info.BestSecRange := RIGHT.Best_Info.BestSecRange;
																								SELF.Best_Info.BestAssessedValue := checkBlank(RIGHT.Best_Info.BestAssessedValue, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Best_Info.BestLotSize := checkBlank(RIGHT.Best_Info.BestLotSize, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Best_Info.BestBldgSize := checkBlank(RIGHT.Best_Info.BestBldgSize, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Best_Info.BestTypeAdvo := checkBlank(RIGHT.Best_Info.BestTypeAdvo, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Best_Info.BestZipcodeType := checkBlank(RIGHT.Best_Info.BestZipcodeType, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Best_Info.BestVacancy := checkBlank(RIGHT.Best_Info.BestVacancy, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Best_Info.BestTypeOther := checkBlank(RIGHT.Best_Info.BestTypeOther, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Verification.AddrIsBest := RIGHT.Verification.AddrIsBest;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));	

	
	businessHeader := Business_Risk_BIP.getBusinessHeader(withBestBusinessInfo, Options, linkingOptions, AllowedSourcesSet);
	
	consumerHeader_all := Business_Risk_BIP.getConsumerHeader(businessHeader + NoLinkIDsFound, Options, linkingOptions, AllowedSourcesSet); // Pass in Business Header results for companies with BIP IDs assigned. Also pass in records with no BIP IDs assigned.

	consumerHeader := consumerHeader_all(BIP_IDs.PowID.LinkID <> 0 OR BIP_IDs.ProxID.LinkID <> 0 OR BIP_IDs.SeleID.LinkID <> 0 OR BIP_IDs.OrgID.LinkID <> 0 OR BIP_IDs.UltID.LinkID <> 0);

	consumerHeader_noIds := consumerHeader_all(BIP_IDs.PowID.LinkID = 0 AND BIP_IDs.ProxID.LinkID = 0 AND BIP_IDs.SeleID.LinkID = 0 AND BIP_IDs.OrgID.LinkID = 0 AND BIP_IDs.UltID.LinkID = 0);

	associates := Business_Risk_BIP.getAssociateSources(businessHeader, Options, linkingOptions, AllowedSourcesSet); // Need to pass Business Header in because that contains the set of Contact DIDs

	OSHA := Business_Risk_BIP.getOSHA(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	Bankruptcy := Business_Risk_BIP.getBankruptcy(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	Property := Business_Risk_BIP.getProperty(withBestBusinessInfo, Options, linkingOptions, AllowedSourcesSet);

	EDA := Business_Risk_BIP.getEDA(withBestBusinessInfo, Options, linkingOptions, AllowedSourcesSet);
	
	EBR := Business_Risk_BIP.getEBR(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	Tradelines := Business_Risk_BIP.getTradelines(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	AddrAndPropertyData := Business_Risk_BIP.getAddrAndPropertyData(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	employeeSources := Business_Risk_BIP.getEmployeeSources(withBestBusinessInfo, Options, linkingOptions, AllowedSourcesSet);
	
	UCC := Business_Risk_BIP.getUCC(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	Liens := Business_Risk_BIP.getLiens(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	Inquiries := Business_Risk_BIP.getInquiries(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	otherSources := Business_Risk_BIP.getOtherSources(withBestBusinessInfo, Options, linkingOptions, AllowedSourcesSet);
	
	CorporateFilings := Business_Risk_BIP.getCorporateFilings(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	AirWatercraft := Business_Risk_BIP.getAirWatercraft(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	MotorVehicleData := Business_Risk_BIP.getMotorVehicles(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);

	GovernmentDebarred := Business_Risk_BIP.getGovernmentDebarred(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
		
	PhoneAddrDistances := Business_Risk_BIP.getPhoneAddrDistances(businessHeader, Options, linkingOptions, AllowedSourcesSet);
	
	ProfLic := Business_Risk_BIP.getProfLicenses(withBestBusinessInfo, Options, linkingOptions, AllowedSourcesSet);
		
	Cortera := Business_Risk_BIP.getCortera(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet, ds_CorteraRetrotestRecsRaw);
	 
	SBFE := Business_Risk_BIP.getSBFE(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);


	
	mergeBNAP(STRING leftBNAP, STRING rightBNAP) := FUNCTION
		maxBNAP := MAX((INTEGER)leftBNAP, (INTEGER)rightBNAP);
		minBNAP := MIN((INTEGER)leftBNAP, (INTEGER)rightBNAP);
		
		mergedBNAP := MAP(maxBNAP IN [5, 6, 7] AND minBNAP = 4	=> 8,
											maxBNAP IN [6, 7] AND minBNAP = 5			=> 8,
																															 maxBNAP);
		RETURN((STRING)mergedBNAP);
	END;
	
	// All data has been gathered, now join everything back together - utilize PARALLEL to minimize latency of the Shell
																						
	withBusinessHeader := JOIN(withBestBusinessInfo, businessHeader, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.Verification.NameMatch := (STRING)MAX((INTEGER)LEFT.Verification.NameMatch, (INTEGER)RIGHT.Verification.NameMatch);
																								VerNameMiskey := IF(TRIM(LEFT.Clean_Input.CompanyName) = '', '-1', RIGHT.Verification.VerNameMiskey);
																								SELF.Verification.VerNameMiskey := checkBlank(VerNameMiskey, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.VerInputNameAlternative := checkBlank(RIGHT.Verification.VerInputNameAlternative, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.VerInputNameDBA := checkBlank(RIGHT.Verification.VerInputNameDBA, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.AddrVerification := (STRING)MAX((INTEGER)LEFT.Verification.AddrVerification, (INTEGER)RIGHT.Verification.AddrVerification);
																								SELF.Verification.AddrMiskey := checkBlank(RIGHT.Verification.AddrMiskey, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.AddrZipVerification := checkBlank(RIGHT.Verification.AddrZipVerification, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.PhoneInputMiskey := checkBlank(RIGHT.Verification.PhoneInputMiskey, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.PhoneMatch := (STRING)MAX((INTEGER)LEFT.Verification.PhoneMatch, (INTEGER)RIGHT.Verification.PhoneMatch);
																								VerificationBusInputPhoneAddr := MAX((INTEGER)LEFT.Verification.VerificationBusInputPhoneAddr, (INTEGER)RIGHT.Verification.VerificationBusInputPhoneAddr);
																								SELF.Verification.VerificationBusInputPhoneAddr := IF(VerificationBusInputPhoneAddr = -2, '-1', (STRING)VerificationBusInputPhoneAddr);
																								SELF.Verification.PhoneNameMismatch := checkBlank((STRING)RIGHT.Verification.PhoneNameMismatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINVerification := (STRING)MAX((INTEGER)LEFT.Verification.FEINVerification, (INTEGER)RIGHT.Verification.FEINVerification);
																								SELF.Verification.FEINInputMiskey := checkBlank(RIGHT.Verification.FEINInputMiskey, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_Characteristics.BusinessAddrCount := checkBlank(RIGHT.Business_Characteristics.BusinessAddrCount, '0');
																								SELF.Business_Characteristics.BusinessBestAddrType := checkBlank(RIGHT.Business_Characteristics.BusinessBestAddrType, '-1');
																								SELF.Input_Characteristics.InputAddrType := checkBlank(RIGHT.Input_Characteristics.InputAddrType, '-1');
																								SELF.Verification.InputAddrVacancy := checkBlank(RIGHT.Verification.InputAddrVacancy, '0');
																								SELF.Verification.InputAddrNotMostRecent := checkBlank(RIGHT.Verification.InputAddrNotMostRecent, '-1');
																								SELF.Verification.BNAT := checkBlank(RIGHT.Verification.BNAT, '0');
																								SELF.Verification.BNAP := (STRING)MAX((INTEGER)LEFT.Verification.BNAP, (INTEGER)RIGHT.Verification.BNAP); // Keep the MAX of the Business Header, Gong, and Phones Plus BNAP
																								SELF.Verification.BNAT2 := checkBlank(RIGHT.Verification.BNAT2, '0');
																								SELF.Verification.BNAP2 := mergeBNAP(LEFT.Verification.BNAP2, RIGHT.Verification.BNAP2); // Merge the BNAP2 from Business Header, Gong, and Phones Plus
																								SELF.Verification.InputIDMatchCategory := checkBlank(RIGHT.Verification.InputIDMatchCategory, Business_Risk_BIP.Constants.Category_None, Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.InputIDMatchStatus := checkBlank(RIGHT.Verification.InputIDMatchStatus, 'UNKNOWN', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Organizational_Structure.UltIDOrgIDTreeCount := checkBlank(RIGHT.Organizational_Structure.UltIDOrgIDTreeCount, '0');
																								SELF.Organizational_Structure.OrgLegalEntityCount := checkBlank(RIGHT.Organizational_Structure.OrgLegalEntityCount, '0');
																								SELF.Organizational_Structure.OrgParentCompany := checkBlank(RIGHT.Organizational_Structure.OrgParentCompany, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Organizational_Structure.OrgAddrLegalEntityCount := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22,
																																						checkBlank(RIGHT.Organizational_Structure.OrgAddrLegalEntityCount, '0'), LEFT.Organizational_Structure.OrgAddrLegalEntityCount);
																								SELF.Organizational_Structure.UltIDProxIDTreeCount := checkBlank(RIGHT.Organizational_Structure.UltIDProxIDTreeCount, '0');
																								SELF.Organizational_Structure.UltIDPowIDTreeCount := checkBlank(RIGHT.Organizational_Structure.UltIDPowIDTreeCount, '0');
																								SELF.Organizational_Structure.OrgRelatedCount := checkBlank(RIGHT.Organizational_Structure.OrgRelatedCount, '0');
																								SELF.Organizational_Structure.OrgIDProxIDTreeCount := checkBlank(RIGHT.Organizational_Structure.OrgIDProxIDTreeCount, '0');
																								SELF.Organizational_Structure.OrgIDPowIDTreeCount := checkBlank(RIGHT.Organizational_Structure.OrgIDPowIDTreeCount, '0');
																								SELF.Organizational_Structure.OrgLocationCount := checkBlank(RIGHT.Organizational_Structure.OrgLocationCount, '0');
																								SELF.Organizational_Structure.SeleIDPowIDTreeCount := checkBlank(RIGHT.Organizational_Structure.SeleIDPowIDTreeCount, '0');
																								SELF.Organizational_Structure.ProxIDPowIDTreeCount := checkBlank(RIGHT.Organizational_Structure.ProxIDPowIDTreeCount, '0');
																								//rep1
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile, '0');
																								SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1PhoneBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2PhoneBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3PhoneBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4PhoneBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5PhoneBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1SSNBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2SSNBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3SSNBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4SSNBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5SSNBusHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN, '0');
		
																								//rep2
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN, '0');
																								//rep3
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein, '0');	
																								//rep4
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile, '0');
                                                SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN, '0');																
																								//rep5
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFEIN  := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFEIN, '0');
																							
																								SELF.Associates.AssociateCount := checkBlank(RIGHT.Associates.AssociateCount, '0');
																								SELF.Associates.AssociateCurrentCount := checkBlank(RIGHT.Associates.AssociateCurrentCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentSOSCount := checkBlank(RIGHT.Associates.AssociateCurrentSOSCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.PhoneAddressDistances.BestBusinessPrimRange := RIGHT.PhoneAddressDistances.BestBusinessPrimRange;
																								SELF.PhoneAddressDistances.BestBusinessPrimName := RIGHT.PhoneAddressDistances.BestBusinessPrimName;
																								SELF.PhoneAddressDistances.BestBusinessSecRange := RIGHT.PhoneAddressDistances.BestBusinessSecRange;
																								SELF.PhoneAddressDistances.BestBusinessZip := RIGHT.PhoneAddressDistances.BestBusinessZip;
																								SELF.PhoneAddressDistances.BestBusinessSt := RIGHT.PhoneAddressDistances.BestBusinessSt;
																								SELF.PhoneAddressDistances.BestBusinessCity := RIGHT.PhoneAddressDistances.BestBusinessCity;
																								SELF.PhoneAddressDistances.BestBusinessPhone := RIGHT.PhoneAddressDistances.BestBusinessPhone;
																								SELF.PhoneAddressDistances.BestBusinessLat := RIGHT.PhoneAddressDistances.BestBusinessLat;
																								SELF.PhoneAddressDistances.BestBusinessLong := RIGHT.PhoneAddressDistances.BestBusinessLong;
																								SELF.Data_Fetch_Indicators.FetchCodeBusinessHeader := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeBusinessHeader, '0');
																								SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																								SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																								SELF.AddressSources := LEFT.AddressSources + RIGHT.AddressSources;
																								SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																								SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																								SELF.FEINSources := LEFT.FEINSources + RIGHT.FEINSources;
																								SELF.ContactDIDs := LEFT.ContactDIDs + RIGHT.ContactDIDs;
																								SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																								SELF.Data_Build_Dates.BusinessHeaderBuildDate := RIGHT.Data_Build_Dates.BusinessHeaderBuildDate;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withConsumerHeader := JOIN(withBusinessHeader, consumerHeader, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Verification.BusAddrConsumerFirstName := checkBlank(RIGHT.Verification.BusAddrConsumerFirstName, '0');
																								SELF.Verification.BusAddrConsumerLastName := checkBlank(RIGHT.Verification.BusAddrConsumerLastName, '0');
																								SELF.Verification.BusAddrConsumerFullName := checkBlank(RIGHT.Verification.BusAddrConsumerFullName, '0');
																								SELF.Business_To_Person_Link.BusFEINPersonOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusFEINPersonOverlap, '0');
																								SELF.Business_To_Person_Link.BusFEINPersonAddrOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusFEINPersonAddrOverlap, '0');
																								SELF.Business_To_Person_Link.BusFEINPersonPhoneOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusFEINPersonPhoneOverlap, '0');
																								SELF.Business_To_Person_Link.BusAddrPersonNameOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusAddrPersonNameOverlap, '0');
																								SELF.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2NameBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2NameBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3NameBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3NameBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);			
																								SELF.Business_To_Executive_Link.AR2BRep4NameBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4NameBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5NameBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5NameBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								
																								SELF.Business_To_Executive_Link.AR2BRep1AddrBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1AddrBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2AddrBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2AddrBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3AddrBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3AddrBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);																								
																								SELF.Business_To_Executive_Link.AR2BRep4AddrBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4AddrBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5AddrBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5AddrBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);																								
																								
																								SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1PhoneBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2PhoneBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3PhoneBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);					
																                SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4PhoneBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5PhoneBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);							
																								
																								SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1SSNBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2SSNBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3SSNBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);					
																								SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4SSNBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeaderLexID := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5SSNBusHeaderLexID, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);																								
																								
																								SELF.Business_To_Executive_Link.AR2BRep1AddrAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1AddrAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2AddrAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2AddrAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3AddrAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3AddrAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep4AddrAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4AddrAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5AddrAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5AddrAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);																								
																								
																								SELF.Business_To_Executive_Link.AR2BRep1PhoneAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1PhoneAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2PhoneAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2PhoneAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3PhoneAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3PhoneAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep4PhoneAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4PhoneAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5PhoneAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5PhoneAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);																								
																								
																								SELF.Business_To_Executive_Link.AR2BRep1SSNAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep1SSNAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep2SSNAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep2SSNAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep3SSNAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep3SSNAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep4SSNAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep4SSNAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BRep5SSNAssociateCHeader := checkBlank(RIGHT.Business_To_Executive_Link.AR2BRep5SSNAssociateCHeader, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								
																								SELF.Verification.FEINPersonNameMatch := checkBlank(RIGHT.Verification.FEINPersonNameMatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINPersonAddrMatch := checkBlank(RIGHT.Verification.FEINPersonAddrMatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINAssociateSSNMatch := checkBlank(RIGHT.Verification.FEINAssociateSSNMatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINRelativeSSNMatch := checkBlank(RIGHT.Verification.FEINRelativeSSNMatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.FEINHouseholdSSNMatch := checkBlank(RIGHT.Verification.FEINHouseholdSSNMatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								PhoneNameMatchLevel := (STRING)MAX((INTEGER)LEFT.Verification.PhoneNameMismatch, (INTEGER)RIGHT.Verification.PhoneNameMismatch);
																								PhoneNameMismatch := MAP(PhoneNameMatchLevel = '-1' => '-1',
																																				 PhoneNameMatchLevel = '0' => '0',
																																				 PhoneNameMatchLevel = '1' => '4',
																																				 PhoneNameMatchLevel = '2' => '3',
																																				 PhoneNameMatchLevel = '3' => '2',
																																				 PhoneNameMatchLevel = '4' => '1',
																																																			'0');
																								SELF.Verification.PhoneNameMismatch := checkBlank(PhoneNameMismatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.BNAS := checkBlank(RIGHT.Verification.BNAS, '0');
																								SELF.Verification.BNAS2 := checkBlank(RIGHT.Verification.BNAS2, '0');
																								SELF.Verification.VerifiedConsumerName := RIGHT.Verification.VerifiedConsumerName;
																								SELF.Verification.VerifiedConsumerAddress1 := RIGHT.Verification.VerifiedConsumerAddress1;
																								SELF.Verification.VerifiedConsumerCity := RIGHT.Verification.VerifiedConsumerCity;
																								SELF.Verification.VerifiedConsumerState := RIGHT.Verification.VerifiedConsumerState;
																								SELF.Verification.VerifiedConsumerZip := RIGHT.Verification.VerifiedConsumerZip;
																								SELF.Verification.VerifiedConsumerFEIN := RIGHT.Verification.VerifiedConsumerFEIN;
																								SELF.Verification.VerifiedConsumerPhone := RIGHT.Verification.VerifiedConsumerPhone;
                                                SELF.DeceasedFEIN_As_SSN := checkBlank(RIGHT.DeceasedFEIN_As_SSN, 'N');
																								SELF.Input_Characteristics.InputAddrConsumerCount := checkBlank(RIGHT.Input_Characteristics.InputAddrConsumerCount, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withAssociates := JOIN(withConsumerHeader, associates, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Associates.AssociateHighCrimeAddrCount := checkBlank(RIGHT.Associates.AssociateHighCrimeAddrCount, '0');
																								SELF.Associates.AssociateFelonyCount := checkBlank(RIGHT.Associates.AssociateFelonyCount, '0');
																								SELF.Associates.AssociateCountWithFelony := checkBlank(RIGHT.Associates.AssociateCountWithFelony, '0');
																								SELF.Associates.AssociateBankruptCount := checkBlank(RIGHT.Associates.AssociateBankruptCount, '0');
																								SELF.Associates.AssociateBankrupt1YearCount := checkBlank(RIGHT.Associates.AssociateBankrupt1YearCount, '0');
																								SELF.Associates.AssociateCountWithBankruptcy := checkBlank(RIGHT.Associates.AssociateCountWithBankruptcy, '0');
																								SELF.Associates.AssociateLienCount := checkBlank(RIGHT.Associates.AssociateLienCount, '0');
																								SELF.Associates.AssociateCountWithLien := checkBlank(RIGHT.Associates.AssociateCountWithLien, '0');
																								SELF.Associates.AssociateJudgmentCount := checkBlank(RIGHT.Associates.AssociateJudgmentCount, '0');
																								SELF.Associates.AssociateCountWithJudgment := checkBlank(RIGHT.Associates.AssociateCountWithJudgment, '0');
																								SELF.Associates.AssociateHighRiskAddrCount := checkBlank(RIGHT.Associates.AssociateHighRiskAddrCount, '0');
																								SELF.Associates.AssociateWatchlistCount := checkBlank(RIGHT.Associates.AssociateWatchlistCount, '0');
																								SELF.Associates.AssociateBusinessCount := checkBlank(RIGHT.Associates.AssociateBusinessCount, '0');
																								SELF.Associates.AssociateCityCount := checkBlank(RIGHT.Associates.AssociateCityCount, '0');
																								SELF.Associates.AssociateCountyCount := checkBlank(RIGHT.Associates.AssociateCountyCount, '0');
																								SELF.Associates.AssociatePAWCount := checkBlank(RIGHT.Associates.AssociatePAWCount, '0');
																								SELF.Associates.AssociateCurrentCountWithFelony := checkBlank(RIGHT.Associates.AssociateCurrentCountWithFelony, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentCountWithBankruptcy := checkBlank(RIGHT.Associates.AssociateCurrentCountWithBankruptcy, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentCountWithLien := checkBlank(RIGHT.Associates.AssociateCurrentCountWithLien, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentCountWithJudgment := checkBlank(RIGHT.Associates.AssociateCurrentCountWithJudgment, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentCountWithProperty := checkBlank(RIGHT.Associates.AssociateCurrentCountWithProperty, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentBusinessCount := checkBlank(RIGHT.Associates.AssociateCurrentBusinessCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Associates.AssociateCurrentPAWCount := checkBlank(RIGHT.Associates.AssociateCurrentPAWCount, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
															
 withAuthRepTitles := Business_Risk_BIP.getAuthRepTitles(withAssociates, Options, linkingOptions, AllowedSourcesSet);
 
	withOSHA := JOIN(withAuthRepTitles, OSHA, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Firmographic.OwnershipType := checkBlank(RIGHT.Firmographic.OwnershipType, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																								SELF.Data_Fetch_Indicators.FetchCodeOSHA := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeOSHA, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withBankruptcy := JOIN(withOSHA, Bankruptcy, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.Bankruptcy.BankruptcyCount03Month := checkBlank(RIGHT.Bankruptcy.BankruptcyCount03Month, '0');
																								SELF.Bankruptcy.BankruptcyCount06Month := checkBlank(RIGHT.Bankruptcy.BankruptcyCount06Month, '0');
																								SELF.Bankruptcy.BankruptcyCount12Month := checkBlank(RIGHT.Bankruptcy.BankruptcyCount12Month, '0');
																								SELF.Bankruptcy.BankruptcyCount24Month := checkBlank(RIGHT.Bankruptcy.BankruptcyCount24Month, '0');
																								SELF.Bankruptcy.BankruptcyCount84Month := checkBlank(RIGHT.Bankruptcy.BankruptcyCount84Month, '0');
																								SELF.Bankruptcy.BankruptcyCount := checkBlank(RIGHT.Bankruptcy.BankruptcyCount, '0');
																								SELF.Bankruptcy.BankruptcyChapter := checkBlank(RIGHT.Bankruptcy.BankruptcyChapter, '00');
																								SELF.Bankruptcy.BankruptRecentDate := RIGHT.Bankruptcy.BankruptRecentDate;
																								SELF.Bankruptcy.BankruptcyTimeNewest := checkBlank(RIGHT.Bankruptcy.BankruptcyTimeNewest, '-1');
																								SELF.Bankruptcy.DismissedBankruptcyCount03Month := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyCount03Month, '0');
																								SELF.Bankruptcy.DismissedBankruptcyCount06Month := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyCount06Month, '0');
																								SELF.Bankruptcy.DismissedBankruptcyCount12Month := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyCount12Month, '0');
																								SELF.Bankruptcy.DismissedBankruptcyCount24Month := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyCount24Month, '0');
																								SELF.Bankruptcy.DismissedBankruptcyCount84Month := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyCount84Month, '0');
																								SELF.Bankruptcy.DismissedBankruptcyCount := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyCount, '0');
																								SELF.Bankruptcy.DismissedBankruptcyChapter := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyChapter, '00');
																								SELF.Bankruptcy.DismissedBankruptRecentDate := RIGHT.Bankruptcy.DismissedBankruptRecentDate;
																								SELF.Bankruptcy.DismissedBankruptcyTimeNewest := checkBlank(RIGHT.Bankruptcy.DismissedBankruptcyTimeNewest, '-1');
																								SELF.Data_Fetch_Indicators.FetchCodeBankruptcy := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeBankruptcy, '0');
																								SELF.Data_Build_Dates.BankruptcyBuildDate := RIGHT.Data_Build_Dates.BankruptcyBuildDate;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withProperty := JOIN(withBankruptcy, Property, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount2 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount2, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount3 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount3, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount4 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount4, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount5 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount5, '0');
																								
																								SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRepOwned := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusAddrAuthRepOwned, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep2Owned := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep2Owned, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep3Owned := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep3Owned, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep4Owned := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep4Owned, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep5Owned := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep5Owned, '0');
																								
																								SELF.Best_Info.BestOwnership := checkBlank(RIGHT.Best_Info.BestOwnership, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Data_Fetch_Indicators.FetchCodeProperty := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeProperty, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withEDA := JOIN(withProperty, EDA, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								VerificationBusInputPhoneAddr := MAX((INTEGER)LEFT.Verification.VerificationBusInputPhoneAddr, (INTEGER)RIGHT.Verification.VerificationBusInputPhoneAddr);
																								SELF.Verification.VerificationBusInputPhoneAddr := IF(VerificationBusInputPhoneAddr = -2, '-1', (STRING)VerificationBusInputPhoneAddr);
																								SELF.Verification.BNAP := (STRING)MAX((INTEGER)LEFT.Verification.BNAP, (INTEGER)RIGHT.Verification.BNAP); // Keep the MAX of the Business Header, Gong, and Phones Plus BNAP
																								SELF.Verification.BNAP2 := mergeBNAP(LEFT.Verification.BNAP2, RIGHT.Verification.BNAP2); // Merge the BNAP2 from Business Header, Gong, and Phones Plus
																								SELF.Verification.PhoneMatch := (STRING)MAX((INTEGER)LEFT.Verification.PhoneMatch, (INTEGER)RIGHT.Verification.PhoneMatch);
																								SELF.Data_Fetch_Indicators.FetchCodeEDA := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeEDA, '0');
																								SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.LinkIdSources := RIGHT.LinkIdSources;
																								SELF.PhoneIDSources := RIGHT.PhoneIDSources;
																								SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																								SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																								SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																								SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withEBR := JOIN(withEDA, EBR, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Firmographic.FirmAgeEstablished := checkBlank(RIGHT.Firmographic.FirmAgeEstablished, '-1');
																								SELF.Firmographic.FirmReportedSales := checkBlank(RIGHT.Firmographic.FirmReportedSales, '-1');
																								SELF.Data_Fetch_Indicators.FetchCodeEBR5600 := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeEBR5600, '0');
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withTradelines := JOIN(withEBR, Tradelines, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Tradeline.TradeBalanceCurrent := checkBlank(RIGHT.Tradeline.TradeBalanceCurrent, '-1');
																								SELF.Tradeline.Trade06MonthHighBalance := checkBlank(RIGHT.Tradeline.Trade06MonthHighBalance, '-1');
																								SELF.Tradeline.Trade06MonthLowBalance := checkBlank(RIGHT.Tradeline.Trade06MonthLowBalance, '-1');
																								SELF.Tradeline.TradeHighBalanceExtendCredit := checkBlank(RIGHT.Tradeline.TradeHighBalanceExtendCredit, '-1');
																								SELF.Tradeline.TradeMedianBalanceExtendCredit := checkBlank(RIGHT.Tradeline.TradeMedianBalanceExtendCredit, '-1');
																								SELF.Tradeline.TradeMedianHighExtendedCredit := checkBlank(RIGHT.Tradeline.TradeMedianHighExtendedCredit, '-1');
																								SELF.Tradeline.TradeHighBalanceNew := checkBlank(RIGHT.Tradeline.TradeHighBalanceNew, '-1');
																								SELF.Tradeline.TradeHighBalanceAged := checkBlank(RIGHT.Tradeline.TradeHighBalanceAged, '-1');
																								SELF.Tradeline.TradeHighBalance := checkBlank(RIGHT.Tradeline.TradeHighBalance, '-1');
																								SELF.Tradeline.TradeBalanceActive := checkBlank(RIGHT.Tradeline.TradeBalanceActive, '-1');
																								SELF.Tradeline.TradeGoodStandingNewPercent := checkBlank(RIGHT.Tradeline.TradeGoodStandingNewPercent, '-1');
																								SELF.Tradeline.TradeGoodStandingAgedPercent := checkBlank(RIGHT.Tradeline.TradeGoodStandingAgedPercent, '-1');
																								SELF.Tradeline.TradeGoodStandingPercent := checkBlank(RIGHT.Tradeline.TradeGoodStandingPercent, '-1');
																								SELF.Tradeline.TradeNewCount := checkBlank(RIGHT.Tradeline.TradeNewCount, '-1');
																								SELF.Tradeline.TradeAgedCount := checkBlank(RIGHT.Tradeline.TradeAgedCount, '-1');
																								SELF.Tradeline.TradeCount := checkBlank(RIGHT.Tradeline.TradeCount, '-1');
																								SELF.Tradeline.TradeDPD01NewPercent := checkBlank(RIGHT.Tradeline.TradeDPD01NewPercent, '-1');
																								SELF.Tradeline.TradeDPD31NewPercent := checkBlank(RIGHT.Tradeline.TradeDPD31NewPercent, '-1');
																								SELF.Tradeline.TradeDPD61NewPercent := checkBlank(RIGHT.Tradeline.TradeDPD61NewPercent, '-1');
																								SELF.Tradeline.TradeDPD91NewPercent := checkBlank(RIGHT.Tradeline.TradeDPD91NewPercent, '-1');
																								SELF.Tradeline.TradeDPD01AgedPercent := checkBlank(RIGHT.Tradeline.TradeDPD01AgedPercent, '-1');
																								SELF.Tradeline.TradeDPD31AgedPercent := checkBlank(RIGHT.Tradeline.TradeDPD31AgedPercent, '-1');
																								SELF.Tradeline.TradeDPD61AgedPercent := checkBlank(RIGHT.Tradeline.TradeDPD61AgedPercent, '-1');
																								SELF.Tradeline.TradeDPD91AgedPercent := checkBlank(RIGHT.Tradeline.TradeDPD91AgedPercent, '-1');
																								SELF.Tradeline.TradeDPD01Percent := checkBlank(RIGHT.Tradeline.TradeDPD01Percent, '-1');
																								SELF.Tradeline.TradeDPD31Percent := checkBlank(RIGHT.Tradeline.TradeDPD31Percent, '-1');
																								SELF.Tradeline.TradeDPD61Percent := checkBlank(RIGHT.Tradeline.TradeDPD61Percent, '-1');
																								SELF.Tradeline.TradeDPD91Percent := checkBlank(RIGHT.Tradeline.TradeDPD91Percent, '-1');
																								SELF.Tradeline.TradeNEW1orMoreDPD := checkBlank(RIGHT.Tradeline.TradeNEW1orMoreDPD, '-1');
																								SELF.Tradeline.TradeNEW31orMoreDPD := checkBlank(RIGHT.Tradeline.TradeNEW31orMoreDPD, '-1');
																								SELF.Tradeline.TradeNEW61orMoreDPD := checkBlank(RIGHT.Tradeline.TradeNEW61orMoreDPD, '-1');
																								SELF.Tradeline.TradeNEW91orMoreDPD := checkBlank(RIGHT.Tradeline.TradeNEW91orMoreDPD, '-1');
																								SELF.Tradeline.TradeAged1orMoreDPD := checkBlank(RIGHT.Tradeline.TradeAged1orMoreDPD, '-1');
																								SELF.Tradeline.TradeAged31orMoreDPD := checkBlank(RIGHT.Tradeline.TradeAged31orMoreDPD, '-1');
																								SELF.Tradeline.TradeAged61orMoreDPD := checkBlank(RIGHT.Tradeline.TradeAged61orMoreDPD, '-1');
																								SELF.Tradeline.TradeAged91orMoreDPD := checkBlank(RIGHT.Tradeline.TradeAged91orMoreDPD, '-1');
																								SELF.Tradeline.Trade1orMoreDPD := checkBlank(RIGHT.Tradeline.Trade1orMoreDPD, '-1');
																								SELF.Tradeline.Trade31orMoreDPD := checkBlank(RIGHT.Tradeline.Trade31orMoreDPD, '-1');
																								SELF.Tradeline.Trade61orMoreDPD := checkBlank(RIGHT.Tradeline.Trade61orMoreDPD, '-1');
																								SELF.Tradeline.Trade91orMoreDPD := checkBlank(RIGHT.Tradeline.Trade91orMoreDPD, '-1');
																								SELF.Tradeline.TradeHighestDPDNew := checkBlank(RIGHT.Tradeline.TradeHighestDPDNew, '-1');
																								SELF.Tradeline.TradeHighestDPDAged := checkBlank(RIGHT.Tradeline.TradeHighestDPDAged, '-1');
																								SELF.Tradeline.TradeHighestDPD := checkBlank(RIGHT.Tradeline.TradeHighestDPD, '-1');
																								SELF.Data_Fetch_Indicators.FetchCodeTradelines := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeTradelines, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withAddrAndPropertyData := JOIN(withTradelines, AddrAndPropertyData, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.Verification.AddrIsBest                       := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22, RIGHT.Verification.AddrIsBest, LEFT.Verification.AddrIsBest);
																								SELF.Verification.InputAddrOwnership               := checkBlank(RIGHT.Verification.InputAddrOwnership, '-1');
																								SELF.Firmographic.BusTypeAddress                   := calculateValueFor._BusTypeAddress( LEFT.Input, RIGHT.Firmographic.BusTypeAddress);
																								SELF.Input_Characteristics.InputAddrBusinessOwned  := checkBlank(RIGHT.Input_Characteristics.InputAddrBusinessOwned, '-1');
																								SELF.Asset_Information.PropertyAssessedValueList   := RIGHT.Asset_Information.PropertyAssessedValueList;
																								SELF.Asset_Information.AssetPropertyCount          := calculateValueFor._AssetPropertyField(RIGHT.Asset_Information.AssetPropertyCount);
																								SELF.Asset_Information.AssetPropertyAssessedTotal  := checkBlank(RIGHT.Asset_Information.AssetPropertyAssessedTotal, '-1');
																								SELF.Asset_Information.AssetPropertyStateCount     := calculateValueFor._AssetPropertyField(RIGHT.Asset_Information.AssetPropertyStateCount);
																								SELF.Asset_Information.AssetPropertyLotSizeTotal   := checkBlank(RIGHT.Asset_Information.AssetPropertyLotSizeTotal, '-1');
																								SELF.Asset_Information.AssetPropertySqFootageTotal := checkBlank(RIGHT.Asset_Information.AssetPropertySqFootageTotal, '-1');
																								SELF.Asset_Information.AssetCurrentPropertyCount          := calculateValueFor._AssetPropertyField(RIGHT.Asset_Information.AssetCurrentPropertyCount);
																								SELF.Asset_Information.AssetCurrentPropertyAssessedTotal  := checkBlank(RIGHT.Asset_Information.AssetCurrentPropertyAssessedTotal, '-1');
																								SELF.Asset_Information.AssetCurrentPropertyStateCount     := calculateValueFor._AssetPropertyField(RIGHT.Asset_Information.AssetCurrentPropertyStateCount);
																								SELF.Asset_Information.AssetCurrentPropertyLotSizeTotal   := checkBlank(RIGHT.Asset_Information.AssetCurrentPropertyLotSizeTotal, '-1');
																								SELF.Asset_Information.AssetCurrentPropertySqFootageTotal := checkBlank(RIGHT.Asset_Information.AssetCurrentPropertySqFootageTotal, '-1');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withEmployee := JOIN(withAddrAndPropertyData, employeeSources, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																			     SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																			     SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																		     	SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																					SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																								SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																								SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																								SELF.Firmographic.FirmEmployeeCount := checkBlank(RIGHT.Firmographic.FirmEmployeeCount, '0');
																								SELF.Firmographic.FirmReportedSales := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.Firmographic.FirmReportedSales, (INTEGER)checkBlank(RIGHT.Firmographic.FirmReportedSales, '-1')), -1, 99999999999); // Comes from multiple sources, need to make sure we keep inside the caps
																								SELF.Firmographic.FirmReportedEarnings := checkBlank(RIGHT.Firmographic.FirmReportedEarnings, '-1');
																								SELF.Firmographic.FinanceWorthOfBus := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)checkBlank(RIGHT.Firmographic.FinanceWorthOfBus, '-1'), -1, 999999999);
																								SELF.Data_Fetch_Indicators.FetchCodeDNBDMI := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeDNBDMI, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeBusinessRegistration := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeBusinessRegistration, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeDCA := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeDCA, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeDeadCo := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeDeadCo, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeABIUS := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeABIUS, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withUCC := JOIN(withEmployee, UCC, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.Public_Record.UCCCount := checkBlank(RIGHT.Public_Record.UCCCount, '0');
																								SELF.Public_Record.UCCActiveCount := checkBlank(RIGHT.Public_Record.UCCActiveCount, '0');
																								SELF.Public_Record.UCCTerminatedCount := checkBlank(RIGHT.Public_Record.UCCTerminatedCount, '0');
																								SELF.Public_Record.UCCOtherCount := checkBlank(RIGHT.Public_Record.UCCOtherCount, '0');
																								SELF.Public_Record.UCCDateList := RIGHT.Public_Record.UCCDateList;
																								SELF.Public_Record.UCCTimeNewest := checkBlank(RIGHT.Public_Record.UCCTimeNewest, '0');
																								SELF.Public_Record.UCCTimeOldest := checkBlank(RIGHT.Public_Record.UCCTimeOldest, '0');
																								SELF.Public_Record.UCCInitialFilingDateFirstSeen := checkBlank(RIGHT.Public_Record.UCCInitialFilingDateFirstSeen, '0');
																								SELF.Public_Record.UCCInitialFilingDateLastSeen := checkBlank(RIGHT.Public_Record.UCCInitialFilingDateLastSeen, '0');
																								SELF.Public_Record.UCCDateFirstSeen := checkBlank(RIGHT.Public_Record.UCCDateFirstSeen, '0');
																								SELF.Public_Record.UCCDateLastSeen := checkBlank(RIGHT.Public_Record.UCCDateLastSeen, '0');
																								SELF.Public_Record.UCCTypesList := RIGHT.Public_Record.UCCTypesList;
																								SELF.Public_Record.UCCRole := checkBlank(RIGHT.Public_Record.UCCRole, '0');
																								SELF.Public_Record.UCCRoleActive := checkBlank(RIGHT.Public_Record.UCCRoleActive, '0');
																								SELF.Public_Record.UCCFilingStatusList := RIGHT.Public_Record.UCCFilingStatusList;
																								SELF.Data_Fetch_Indicators.FetchCodeUCC := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeUCC, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withLiens := JOIN(withUCC, Liens, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Lien_And_Judgment.LienFilingDateList   := RIGHT.Lien_And_Judgment.LienFilingDateList;
																								SELF.Lien_And_Judgment.LienTimeNewest := RIGHT.Lien_And_Judgment.LienTimeNewest;
																								SELF.Lien_And_Judgment.LienTimeOldest := RIGHT.Lien_And_Judgment.LienTimeOldest;
																								SELF.Lien_And_Judgment.LienReleaseDateList  := RIGHT.Lien_And_Judgment.LienReleaseDateList;
																								SELF.Lien_And_Judgment.LienTypeList         := RIGHT.Lien_And_Judgment.LienTypeList;
																								SELF.Lien_And_Judgment.LienType       := checkBlank(RIGHT.Lien_And_Judgment.LienType, '-1');
																								SELF.Lien_And_Judgment.LienFilingStatusList := RIGHT.Lien_And_Judgment.LienFilingStatusList;
																								SELF.Lien_And_Judgment.LienFilingStateList  := RIGHT.Lien_And_Judgment.LienFilingStateList;
																								SELF.Lien_And_Judgment.LienAmountList       := RIGHT.Lien_And_Judgment.LienAmountList;
																								SELF.Lien_And_Judgment.LienDollarTotal      := checkBlank(RIGHT.Lien_And_Judgment.LienDollarTotal, '-1');
																								SELF.Lien_And_Judgment.LienCount            := checkBlank(RIGHT.Lien_And_Judgment.LienCount, '0');
																								SELF.Lien_And_Judgment.LienCount12Month     := checkBlank(RIGHT.Lien_And_Judgment.LienCount12Month, '0');
																								SELF.Lien_And_Judgment.LienCount24Month     := checkBlank(RIGHT.Lien_And_Judgment.LienCount24Month, '0');
																								SELF.Lien_And_Judgment.JudgmentCount        := checkBlank(RIGHT.Lien_And_Judgment.JudgmentCount, '0');
																								SELF.Lien_And_Judgment.JudgmentCount12Month := checkBlank(RIGHT.Lien_And_Judgment.JudgmentCount12Month, '0');
																								SELF.Lien_And_Judgment.JudgmentCount24Month := checkBlank(RIGHT.Lien_And_Judgment.JudgmentCount24Month, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedDateList := RIGHT.Lien_And_Judgment.JudgmentReleasedDateList;
																								SELF.Lien_And_Judgment.JudgmentFilingDateList   := RIGHT.Lien_And_Judgment.JudgmentFilingDateList;
																								SELF.Lien_And_Judgment.JudgmentTimeNewest   := RIGHT.Lien_And_Judgment.JudgmentTimeNewest;
																								SELF.Lien_And_Judgment.JudgmentTimeOldest   := RIGHT.Lien_And_Judgment.JudgmentTimeOldest;
																								SELF.Lien_And_Judgment.JudgmentTypeList         := RIGHT.Lien_And_Judgment.JudgmentTypeList;
																								SELF.Lien_And_Judgment.JudgmentType       := checkBlank(RIGHT.Lien_And_Judgment.JudgmentType, '-1');
																								SELF.Lien_And_Judgment.JudgmentFilingStatusList := RIGHT.Lien_And_Judgment.JudgmentFilingStatusList;
																								SELF.Lien_And_Judgment.JudgmentAmountList       := RIGHT.Lien_And_Judgment.JudgmentAmountList;
																								SELF.Lien_And_Judgment.JudgmentDollarTotal      := checkBlank(RIGHT.Lien_And_Judgment.JudgmentDollarTotal, '-1');
																								SELF.Lien_And_Judgment.LienReleasedCount               := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount, '0');
																								SELF.Lien_And_Judgment.LienFiledDateFirstSeen           := checkBlank(RIGHT.Lien_And_Judgment.LienFiledDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledDateLastSeen           := checkBlank(RIGHT.Lien_And_Judgment.LienFiledDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledCount60                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledCount60, '0');
																								SELF.Lien_And_Judgment.LienFiledCount36                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledCount36, '0');
																								SELF.Lien_And_Judgment.LienFiledCount24                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledCount24, '0');
																								SELF.Lien_And_Judgment.LienFiledCount12                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledCount12, '0');
																								SELF.Lien_And_Judgment.LienFiledCount06                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledCount06, '0');
																								SELF.Lien_And_Judgment.LienFiledCount03                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledCount03, '0');
																								SELF.Lien_And_Judgment.LienReleasedCount60             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount60, '0');
																								SELF.Lien_And_Judgment.LienReleasedCount36             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount36, '0');
																								SELF.Lien_And_Judgment.LienReleasedCount24             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount24, '0');
																								SELF.Lien_And_Judgment.LienReleasedCount12             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount12, '0');
																								SELF.Lien_And_Judgment.LienReleasedCount06             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount06, '0');
																								SELF.Lien_And_Judgment.LienReleasedCount03             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedCount03, '0');
																								SELF.Lien_And_Judgment.LienFiledFTCount                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFTCount, '0');
																								SELF.Lien_And_Judgment.LienFiledFTDateFirstSeen        := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledFTDateLastSeen         := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledFTTotalAmount          := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFTTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienReleasedFTCount             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFTCount, '0');
																								SELF.Lien_And_Judgment.LienReleasedFTDateFirstSeen     := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedFTDateLastSeen      := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedFTTotalAmount       := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFTTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienFiledFCCount                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFCCount, '0');
																								SELF.Lien_And_Judgment.LienFiledFCDateFirstSeen        := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFCDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledFCDateLastSeen         := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFCDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledFCTotalAmount          := checkBlank(RIGHT.Lien_And_Judgment.LienFiledFCTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienReleasedFCCount             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFCCount, '0');
																								SELF.Lien_And_Judgment.LienReleasedFCDateFirstSeen     := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFCDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedFCDateLastSeen      := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFCDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedFCTotalAmount       := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedFCTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienFiledLTCount                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledLTCount, '0');
																								SELF.Lien_And_Judgment.LienFiledLTDateFirstSeen        := checkBlank(RIGHT.Lien_And_Judgment.LienFiledLTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledLTDateLastSeen         := checkBlank(RIGHT.Lien_And_Judgment.LienFiledLTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledLTTotalAmount          := checkBlank(RIGHT.Lien_And_Judgment.LienFiledLTTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienReleasedLTCount             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedLTCount, '0');
																								SELF.Lien_And_Judgment.LienReleasedLTDateFirstSeen     := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedLTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedLTDateLastSeen      := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedLTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedLTTotalAmount       := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedLTTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienFiledOTCount                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledOTCount, '0');
																								SELF.Lien_And_Judgment.LienFiledOTDateFirstSeen        := checkBlank(RIGHT.Lien_And_Judgment.LienFiledOTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledOTDateLastSeen         := checkBlank(RIGHT.Lien_And_Judgment.LienFiledOTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledOTTotalAmount          := checkBlank(RIGHT.Lien_And_Judgment.LienFiledOTTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienReleasedOTCount             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedOTCount, '0');
																								SELF.Lien_And_Judgment.LienReleasedOTDateFirstSeen     := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedOTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedOTDateLastSeen      := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedOTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedOTTotalAmount       := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedOTTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienFiledMLCount                := checkBlank(RIGHT.Lien_And_Judgment.LienFiledMLCount, '0');
																								SELF.Lien_And_Judgment.LienFiledMLDateFirstSeen        := checkBlank(RIGHT.Lien_And_Judgment.LienFiledMLDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledMLDateLastSeen         := checkBlank(RIGHT.Lien_And_Judgment.LienFiledMLDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledMLTotalAmount          := checkBlank(RIGHT.Lien_And_Judgment.LienFiledMLTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienReleasedMLCount             := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedMLCount, '0');
																								SELF.Lien_And_Judgment.LienReleasedMLDateFirstSeen     := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedMLDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedMLDateLastSeen      := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedMLDateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedMLTotalAmount       := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedMLTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienFiledOCount                 := checkBlank(RIGHT.Lien_And_Judgment.LienFiledOCount, '0');
																								SELF.Lien_And_Judgment.LienFiledODateFirstSeen         := checkBlank(RIGHT.Lien_And_Judgment.LienFiledODateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledODateLastSeen          := checkBlank(RIGHT.Lien_And_Judgment.LienFiledODateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienFiledOTotalAmount           := checkBlank(RIGHT.Lien_And_Judgment.LienFiledOTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienReleasedOCount              := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedOCount, '0');
																								SELF.Lien_And_Judgment.LienReleasedODateFirstSeen      := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedODateFirstSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedODateLastSeen       := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedODateLastSeen, '0');
																								SELF.Lien_And_Judgment.LienReleasedOTotalAmount        := checkBlank(RIGHT.Lien_And_Judgment.LienReleasedOTotalAmount, '0');
																								SELF.Lien_And_Judgment.LienStateCount                  := checkBlank(RIGHT.Lien_And_Judgment.LienStateCount, '0');
																								SELF.Lien_And_Judgment.LienStateInput                  := checkBlank(RIGHT.Lien_And_Judgment.LienStateInput, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCount60            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCount60, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCount36            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCount36, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCount24            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCount24, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCount12            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCount12, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCount06            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCount06, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCount03            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCount03, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount60         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount60, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount36         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount36, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount24         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount24, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount12         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount12, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount06         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount06, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount03         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount03, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCJCount            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCJCount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCJDateFirstSeen    := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCJDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCJDateLastSeen     := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCJDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledCJTotalAmount      := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledCJTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCJCount         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCJCount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCJDateFirstSeen := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCJDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCJDateLastSeen  := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCJDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCJTotalAmount   := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCJTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSCCount            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSCCount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSCDateFirstSeen    := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSCDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSCDateLastSeen     := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSCDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSCTotalAmount      := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSCTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSCCount         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSCCount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSCDateFirstSeen := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSCDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSCDateLastSeen  := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSCDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSCTotalAmount   := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSCTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSTCount            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSTCount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSTDateFirstSeen    := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSTDateLastSeen     := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSTTotalAmount      := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSTTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSTCount         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSTCount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSTDateFirstSeen := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSTDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSTDateLastSeen  := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSTDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSTTotalAmount   := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSTTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSUCount            := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSUCount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSUDateFirstSeen    := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSUDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSUDateLastSeen     := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSUDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledSUTotalAmount      := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledSUTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSUCount         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSUCount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSUDateFirstSeen := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSUDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSUDateLastSeen  := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSUDateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedSUTotalAmount   := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedSUTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledOCount             := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledOCount, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledODateFirstSeen     := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledODateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledODateLastSeen      := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledODateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentFiledOTotalAmount       := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFiledOTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedOCount          := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedOCount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedODateFirstSeen  := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedODateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedODateLastSeen   := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedODateLastSeen, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedOTotalAmount    := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedOTotalAmount, '0');
																								SELF.Lien_And_Judgment.JudgmentReleasedCount           := checkBlank(RIGHT.Lien_And_Judgment.JudgmentReleasedCount, '0');
																								SELF.Lien_And_Judgment.JudgmentFilingStateList         := checkBlank(RIGHT.Lien_And_Judgment.JudgmentFilingStateList, '0');
																								SELF.Lien_And_Judgment.JudgmentStateCount              := checkBlank(RIGHT.Lien_And_Judgment.JudgmentStateCount, '0');
																								SELF.Lien_And_Judgment.JudgmentStateInput              := checkBlank(RIGHT.Lien_And_Judgment.JudgmentStateInput, '0');
																								SELF.Lien_And_Judgment.JudgFiledDateFirstSeen          := checkBlank(RIGHT.Lien_And_Judgment.JudgFiledDateFirstSeen, '0');
																								SELF.Lien_And_Judgment.JudgFiledDateLastSeen           := checkBlank(RIGHT.Lien_And_Judgment.JudgFiledDateLastSeen, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeLien 					 := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeLien, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withInquiries := JOIN(withLiens, Inquiries, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Inquiry.InquiryIndustryDescriptionList := RIGHT.Inquiry.InquiryIndustryDescriptionList;
																								SELF.Inquiry.InquiryDateList := RIGHT.Inquiry.InquiryDateList;
																								SELF.Inquiry.InquiryDateFirstSeen := checkBlank(RIGHT.Inquiry.InquiryDateFirstSeen, '0');
																								SELF.Inquiry.InquiryDateLastSeen := checkBlank(RIGHT.Inquiry.InquiryDateLastSeen, '0');
																								SELF.Inquiry.InquiryCount := checkBlank(RIGHT.Inquiry.InquiryCount, '0');
																								SELF.Inquiry.Inquiry24Month := checkBlank(RIGHT.Inquiry.Inquiry24Month, '0');
																								SELF.Inquiry.Inquiry12Month := checkBlank(RIGHT.Inquiry.Inquiry12Month, '0');
																								SELF.Inquiry.Inquiry06Month := checkBlank(RIGHT.Inquiry.Inquiry06Month, '0');
																								SELF.Inquiry.Inquiry03Month := checkBlank(RIGHT.Inquiry.Inquiry03Month, '0');
																								SELF.Inquiry.InquiryHighRiskCount := checkBlank(RIGHT.Inquiry.InquiryHighRiskCount, '0');
																								SELF.Inquiry.InquiryHighRisk24Month := checkBlank(RIGHT.Inquiry.InquiryHighRisk24Month, '0');
																								SELF.Inquiry.InquiryHighRisk12Month := checkBlank(RIGHT.Inquiry.InquiryHighRisk12Month, '0');
																								SELF.Inquiry.InquiryHighRisk06Month := checkBlank(RIGHT.Inquiry.InquiryHighRisk06Month, '0');
																								SELF.Inquiry.InquiryHighRisk03Month := checkBlank(RIGHT.Inquiry.InquiryHighRisk03Month, '0');
																								SELF.Inquiry.InquiryCreditCount := checkBlank(RIGHT.Inquiry.InquiryCreditCount, '0');
																								SELF.Inquiry.InquiryCredit24Month := checkBlank(RIGHT.Inquiry.InquiryCredit24Month, '0');
																								SELF.Inquiry.InquiryCredit12Month := checkBlank(RIGHT.Inquiry.InquiryCredit12Month, '0');
																								SELF.Inquiry.InquiryCredit06Month := checkBlank(RIGHT.Inquiry.InquiryCredit06Month, '0');
																								SELF.Inquiry.InquiryCredit03Month := checkBlank(RIGHT.Inquiry.InquiryCredit03Month, '0');
																								SELF.Inquiry.InquiryOtherCount := checkBlank(RIGHT.Inquiry.InquiryOtherCount, '0');
																								SELF.Inquiry.InquiryOther24Month := checkBlank(RIGHT.Inquiry.InquiryOther24Month, '0');
																								SELF.Inquiry.InquiryOther12Month := checkBlank(RIGHT.Inquiry.InquiryOther12Month, '0');
																								SELF.Inquiry.InquiryOther06Month := checkBlank(RIGHT.Inquiry.InquiryOther06Month, '0');
																								SELF.Inquiry.InquiryOther03Month := checkBlank(RIGHT.Inquiry.InquiryOther03Month, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount2 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount2, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount3 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount3, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount4 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount4, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount5 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount5, '0');
																								SELF.Data_Build_Dates.InquiriesBuildDate := RIGHT.Data_Build_Dates.InquiriesBuildDate;
																								SELF.Data_Fetch_Indicators.FetchCodeInquiries := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeInquiries, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeInquiriesUpdate := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeInquiriesUpdate, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW); 
																						
	withOther := JOIN(withInquiries, otherSources, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																								SELF.Verification.PhoneDisconnected := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, LEFT.Verification.PhoneDisconnected, checkBlank(RIGHT.Verification.PhoneDisconnected, '2')); // A 2 indicates "Unknown"
																								SELF.Verification.BNAP := (STRING)MAX((INTEGER)LEFT.Verification.BNAP, (INTEGER)RIGHT.Verification.BNAP); // Keep the MAX of the Business Header, Gong, and Phones Plus BNAP
																								SELF.Verification.BNAP2 := mergeBNAP(LEFT.Verification.BNAP2, RIGHT.Verification.BNAP2); // Merge the BNAP2 from Business Header, Gong, and Phones Plus
																								SELF.Verification.PhoneMatch := (STRING)MAX((INTEGER)LEFT.Verification.PhoneMatch, (INTEGER)RIGHT.Verification.PhoneMatch);
																								SELF.Firmographic.FirmReportedSales := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.Firmographic.FirmReportedSales, (INTEGER)checkBlank(RIGHT.Firmographic.FirmReportedSales, '-1')), -1, 99999999999); // Comes from multiple sources, need to make sure we keep inside the caps
																								SELF.Firmographic.FirmReportedEarnings := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.Firmographic.FirmReportedEarnings, (INTEGER)checkBlank(RIGHT.Firmographic.FirmReportedEarnings, '-1')), -1, 999999999); // Comes from multiple sources, need to make sure we keep inside the caps
																								SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																								SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																								SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																								SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																								SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																								SELF.Firmographic.FirmIRSRetirementPlan := checkBlank(RIGHT.Firmographic.FirmIRSRetirementPlan, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4, '0');
																								SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5 := checkBlank(RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5, '0');
																								SELF.Business_To_Executive_Link.AR2BBusPAWRep1 := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusPAWRep1, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BBusPAWRep2 := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusPAWRep2, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BBusPAWRep3 := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusPAWRep3, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BBusPAWRep4 := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusPAWRep4, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Executive_Link.AR2BBusPAWRep5 := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusPAWRep5, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								
																								SELF.Data_Fetch_Indicators.FetchCodeBBBMember := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeBBBMember, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeBBBNonMember := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeBBBNonMember, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeFBN := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeFBN, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeIRSNonProfit := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeIRSNonProfit, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeIRSRetirement := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeIRSRetirement, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeUtility := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeUtility, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeCalBus := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeCalBus, '0');
																								SELF.Data_Fetch_Indicators.FetchCodeYellowPages := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeYellowPages, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withCorporateFilings := JOIN(withOther, CorporateFilings, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.SOS.SOSDateOfIncorporationList     := RIGHT.SOS.SOSDateOfIncorporationList;
																								SELF.SOS.SOSStanding										:= checkBlank(RIGHT.SOS.SOSStanding, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.SOS.SOSEverDefunct                 := checkBlank(RIGHT.SOS.SOSEverDefunct, '-1');
																								SELF.SOS.SOSTimeIncorporation      			:= checkBlank(RIGHT.SOS.SOSTimeIncorporation, '-1');
																								SELF.SOS.SOSIncorporationCount					:= checkBlank(RIGHT.SOS.SOSIncorporationCount, '0');
																								SELF.SOS.SOSIncorporationDateFirstSeen	:= checkBlank(RIGHT.SOS.SOSIncorporationDateFirstSeen, '0');
																								SELF.SOS.SOSIncorporationDateLastSeen		:= checkBlank(RIGHT.SOS.SOSIncorporationDateLastSeen, '0');
																								SELF.SOS.SOSIncorporationStateFirst			:= RIGHT.SOS.SOSIncorporationStateFirst;
																								SELF.SOS.SOSIncorporationStateLast			:= RIGHT.SOS.SOSIncorporationStateLast;
																								SELF.SOS.SOSIncorporationStateInput			:= RIGHT.SOS.SOSIncorporationStateInput;
																								SELF.SOS.SOSTypeOfFilingTermList        := RIGHT.SOS.SOSTypeOfFilingTermList;
																								SELF.SOS.SOSStateOfIncorporationList    := RIGHT.SOS.SOSStateOfIncorporationList;
																								SELF.SOS.SOSStateOfIncorporationCount   := checkBlank(RIGHT.SOS.SOSStateOfIncorporationCount, '0');
																								SELF.SOS.SOSDateOfFilingList            := RIGHT.SOS.SOSDateOfFilingList;
																								SELF.SOS.SOSFilingCount									        := checkBlank(RIGHT.SOS.SOSFilingCount, '0');
																								SELF.SOS.SOSFilingDateFirstSeen					    := checkBlank(RIGHT.SOS.SOSFilingDateFirstSeen, '0');
																								SELF.SOS.SOSFilingDateLastSeen					     := checkBlank(RIGHT.SOS.SOSFilingDateLastSeen, '0');
																								SELF.SOS.SOSDomesticCount               := checkBlank(RIGHT.SOS.SOSDomesticCount, '0');
																								SELF.SOS.SOSDomesticDateFirstSeen       := checkBlank(RIGHT.SOS.SOSDomesticDateFirstSeen, '0');
																								SELF.SOS.SOSDomesticDateLastSeen        := checkBlank(RIGHT.SOS.SOSDomesticDateLastSeen, '0');
																								SELF.SOS.SOSDomesticMosSinceFirstSeen   := checkBlank(RIGHT.SOS.SOSDomesticMosSinceFirstSeen, '0');
																								SELF.SOS.SOSForeignCount                := checkBlank(RIGHT.SOS.SOSForeignCount, '0');
																								SELF.SOS.SOSForeignDateFirstSeen        := checkBlank(RIGHT.SOS.SOSForeignDateFirstSeen, '0');
																								SELF.SOS.SOSForeignDateLastSeen         := checkBlank(RIGHT.SOS.SOSForeignDateLastSeen, '0');
																								SELF.SOS.SOSForeignMosSinceFirstSeen    := checkBlank(RIGHT.SOS.SOSForeignMosSinceFirstSeen, '0');
																								SELF.SOS.SOSStandingBest                := checkBlank(RIGHT.SOS.SOSStandingBest, '0');
																								SELF.SOS.SOSStandingWorst               := checkBlank(RIGHT.SOS.SOSStandingWorst, '0');                                                
																								SELF.SOS.SOSCodeList                    := RIGHT.SOS.SOSCodeList;
																								SELF.SOS.SOSFilingCodeList              := RIGHT.SOS.SOSFilingCodeList;
																								SELF.SOS.SOSForeignStateList            := RIGHT.SOS.SOSForeignStateList;
																								SELF.SOS.SOSForeignStateFlag            := checkBlank(RIGHT.SOS.SOSForeignStateFlag, '-1');
																								SELF.SOS.SOSForeignStateCount           := checkBlank(RIGHT.SOS.SOSForeignStateCount, '0');
																								SELF.SOS.SOSCorporateStructureList      := RIGHT.SOS.SOSCorporateStructureList;
																								SELF.SOS.SOSOwnershipTypeList           := RIGHT.SOS.SOSOwnershipTypeList;
																								SELF.SOS.SOSLocationDescriptionList     := RIGHT.SOS.SOSLocationDescriptionList;
																								SELF.SOS.SOSNatureOfBusinessList        := RIGHT.SOS.SOSNatureOfBusinessList;
																								SELF.SOS.SOSCountOfAmendmentsList       := checkBlank(RIGHT.SOS.SOSCountOfAmendmentsList, '0');
																								SELF.SOS.SOSRegisterAgentChangeList     := RIGHT.SOS.SOSRegisterAgentChangeList;
																								SELF.SOS.SOSRegisterAgentChangeDateList := RIGHT.SOS.SOSRegisterAgentChangeDateList;
																								SELF.SOS.SOSRegisterAgentChangeCount		:= checkBlank(RIGHT.SOS.SOSRegisterAgentChangeCount, '0');
																								SELF.SOS.SOSRegisterAgentChangeDateFirstSeen := checkBlank(RIGHT.SOS.SOSRegisterAgentChangeDateFirstSeen, '0');
																								SELF.SOS.SOSRegisterAgentChangeDateLastSeen := checkBlank(RIGHT.SOS.SOSRegisterAgentChangeDateLastSeen, '0');
																								SELF.SOS.SOSTimeAgentChange := checkBlank(RIGHT.SOS.SOSTimeAgentChange, '-1');
																								SELF.SOS.SOSRegisterAgentChangeCount12Month := checkBlank(RIGHT.SOS.SOSRegisterAgentChangeCount12Month, '0');
																								SELF.SOS.SOSRegisterAgentChangeCount06Month := checkBlank(RIGHT.SOS.SOSRegisterAgentChangeCount06Month, '0');
																								SELF.SOS.SOSRegisterAgentChangeCount03Month := checkBlank(RIGHT.SOS.SOSRegisterAgentChangeCount03Month, '0');
																								SELF.SOS.SOSStateCount									:= checkBlank(RIGHT.SOS.SOSStateCount, '0');
																								SELF.Firmographic.OwnershipType := checkBlank((STRING)MAX((INTEGER)LEFT.Firmographic.OwnershipType, (INTEGER)RIGHT.Firmographic.OwnershipType), '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Data_Fetch_Indicators.FetchCodeCorporateFilings := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeCorporateFilings, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	withAirWatercraft := JOIN(withCorporateFilings, AirWatercraft, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.Asset_Information.AssetAircraftCount := checkBlank(RIGHT.Asset_Information.AssetAircraftCount, '0'),
																								SELF.Asset_Information.AssetWatercraftCount := checkBlank(RIGHT.Asset_Information.AssetWatercraftCount, '0'),
																								SELF.Data_Fetch_Indicators.FetchCodeAircraft := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeAircraft, '0'),
																								SELF.Data_Fetch_Indicators.FetchCodeWatercraft := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeWatercraft, '0'),
																								SELF.Data_Build_Dates.AircraftBuildDate := RIGHT.Data_Build_Dates.AircraftBuildDate;
																								SELF.Data_Build_Dates.WatercraftBuildDate := RIGHT.Data_Build_Dates.WatercraftBuildDate;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
 withMotorVehicles := JOIN(withAirWatercraft, MotorVehicleData, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Asset_Information.AssetVehicleCount := checkBlank(RIGHT.Asset_Information.AssetVehicleCount, '-1'),
																								SELF.Asset_Information.AssetPersonalVehicleCount := checkBlank(RIGHT.Asset_Information.AssetPersonalVehicleCount, '-1'),
																								SELF.Asset_Information.AssetCommercialVehicleCount := checkBlank(RIGHT.Asset_Information.AssetCommercialVehicleCount, '-1'),
																								SELF.Asset_Information.AssetOtherVehicleCount := checkBlank(RIGHT.Asset_Information.AssetOtherVehicleCount, '-1'),
																								SELF.Asset_Information.AssetTotalVehicleValue := checkBlank(RIGHT.Asset_Information.AssetTotalVehicleValue, '-1'),
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
 
	withGovernmentDebarred := JOIN(withMotorVehicles, GovernmentDebarred, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Public_Record.GovernmentDebarred := checkBlank(RIGHT.Public_Record.GovernmentDebarred, '0'),
																								SELF.Data_Fetch_Indicators.FetchCodeGovernmentDebarred := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeGovernmentDebarred, '0');
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
 
	withPhoneAddrDistance := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v21, withGovernmentDebarred, //PhoneAddrDistance attributes only needed for v2.2 and above.
																						JOIN(withGovernmentDebarred, PhoneAddrDistances, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Verification.PhoneDistance := checkBlank(RIGHT.Verification.PhoneDistance, '-1'),
																								SELF.Business_To_Executive_Link.AR2BBusRep1AddrDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep1AddrDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep1PhoneDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep1PhoneDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep2AddrDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep2AddrDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep2PhoneDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep2PhoneDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep3AddrDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep3AddrDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep3PhoneDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep3PhoneDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep4AddrDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep4AddrDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep4PhoneDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep4PhoneDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep5AddrDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep5AddrDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF.Business_To_Executive_Link.AR2BBusRep5PhoneDistance := checkBlank(RIGHT.Business_To_Executive_Link.AR2BBusRep5PhoneDistance, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22),
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));

	withProfLic := JOIN(withPhoneAddrDistance, ProfLic, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																								SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																								SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																								SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
                                           
	
	withCortera := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v22, withProfLic, 
																						JOIN(withProfLic, Cortera, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.B2B.UltimateIDCount := checkBlank(RIGHT.B2B.UltimateIDCount, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.B2B.UltimateIDCountActive := checkBlank(RIGHT.B2B.UltimateIDCountActive, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.B2B.UltimateIDCountInactive := checkBlank(RIGHT.B2B.UltimateIDCountInactive, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.B2B.HeaderTimeOldest := checkBlank(RIGHT.B2B.HeaderTimeOldest, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.B2B.AttributesTimeOldest := checkBlank(RIGHT.B2B.AttributesTimeOldest, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
                                                SELF.B2B.VendorScoreFutureDelinquencyMax := checkBlank(RIGHT.B2B.VendorScoreFutureDelinquencyMax, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.VendorScoreFutureDelinquencyMin := checkBlank(RIGHT.B2B.VendorScoreFutureDelinquencyMin, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.VendorScorePaymentBehaviorMax := checkBlank(RIGHT.B2B.VendorScorePaymentBehaviorMax, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.VendorScorePaymentBehaviorMin := checkBlank(RIGHT.B2B.VendorScorePaymentBehaviorMin, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgProviderCount12Mos := checkBlank(RIGHT.B2B.AvgProviderCount12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.ProviderTrajectory12Mos := checkBlank(RIGHT.B2B.ProviderTrajectory12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.ProviderTrajectory24Mos := checkBlank(RIGHT.B2B.ProviderTrajectory24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);	
																								SELF.B2B.NumSpendCategories12Mos := checkBlank(RIGHT.B2B.NumSpendCategories12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.TotalSpend12Mos := checkBlank(RIGHT.B2B.TotalSpend12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.SpendTrajectory12Mos := checkBlank(RIGHT.B2B.SpendTrajectory12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.SpendTrajectory24Mos := checkBlank(RIGHT.B2B.SpendTrajectory24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);	
																								SELF.B2B.AveDaysBeyondTerms := checkBlank(RIGHT.B2B.AveDaysBeyondTerms, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPctTradelinesGT30DPD12Mos := checkBlank(RIGHT.B2B.AvgPctTradelinesGT30DPD12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPctTradelinesGT30DPDIndex12Mos := checkBlank(RIGHT.B2B.AvgPctTradelinesGT30DPDIndex12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPctTradelinesGT60DPD12Mos := checkBlank(RIGHT.B2B.AvgPctTradelinesGT60DPD12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPctTradelinesGT60DPDIndex12Mos := checkBlank(RIGHT.B2B.AvgPctTradelinesGT60DPDIndex12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPctTradelinesGT90DPD12Mos := checkBlank(RIGHT.B2B.AvgPctTradelinesGT90DPD12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPctTradelinesGT90DPDIndex12Mos := checkBlank(RIGHT.B2B.AvgPctTradelinesGT90DPDIndex12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);	
																								SELF.B2B.DaysBeyondTerms30Trajectory12Mos := checkBlank(RIGHT.B2B.DaysBeyondTerms30Trajectory12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.DaysBeyondTerms30Trajectory24Mos := checkBlank(RIGHT.B2B.DaysBeyondTerms30Trajectory24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.DaysBeyondTerms60Trajectory12Mos := checkBlank(RIGHT.B2B.DaysBeyondTerms60Trajectory12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.DaysBeyondTerms60Trajectory24Mos := checkBlank(RIGHT.B2B.DaysBeyondTerms60Trajectory24Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.PaidInFull12Mos :=  checkBlank(RIGHT.B2B.PaidInFull12Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.AvgPayments03Mos :=  checkBlank(RIGHT.B2B.AvgPayments03Mos, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.B2B.BusinessClosedDate := checkBlank(RIGHT.B2B.BusinessClosedDate, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF.Data_Build_Dates.CorteraBuildDate := RIGHT.Data_Build_Dates.CorteraBuildDate;
																								SELF.Verification.SourceIndex := RIGHT.Verification.SourceIndex; // this will be adjusted below
																								SELF.Firmographic.FirmAgeEstablished := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.Firmographic.FirmAgeEstablished, (INTEGER)checkBlank(RIGHT.Firmographic.FirmAgeEstablished, '-1')), -1, 110);
																								SELF.Firmographic.FirmReportedSales := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.Firmographic.FirmReportedSales, (INTEGER)checkBlank(RIGHT.Firmographic.FirmReportedSales, '-1')), -1, 99999999999); // Comes from multiple sources, need to make sure we keep inside the caps
																								SELF.Firmographic.OwnershipType := IF((INTEGER)RIGHT.Firmographic.OwnershipType > 0, RIGHT.Firmographic.OwnershipType, LEFT.Firmographic.OwnershipType); // If we have Cortera data for ownership type, use that. Otherwise use Corp Filings/OSHAIR ownership type.
																								SELF.Sources := LEFT.Sources + RIGHT.Sources;
																								SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																								SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW));	
	
	withSBFE := JOIN(withCortera, SBFE, LEFT.Seq = Right.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								LNIDHit := LEFT.Verification.InputIDMatchCategory NOT IN [Business_Risk_BIP.Constants.Category_None, ''];
																								SELF.Verification.InputIDMatchStatus := checkBlank(IF(LNIDHit, LEFT.Verification.InputIDMatchStatus, RIGHT.Verification.InputIDMatchStatus), 'UNKNOWN', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Verification.InputIDMatchCategory := checkBlank(IF(LNIDHit, LEFT.Verification.InputIDMatchCategory , RIGHT.Verification.InputIDMatchCategory), Business_Risk_BIP.Constants.Category_None, Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.SBFE.SBFEVerBusInputName := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEVerBusInputName, '-99'));
																								SBFENameMatchDateFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFENameMatchDateFirstSeen);
																								SELF.SBFE.SBFENameMatchDateFirstSeen := checkBlank(SBFENameMatchDateFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFENameMatchMonthsFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFENameMatchMonthsFirstSeen);
																								SELF.SBFE.SBFENameMatchMonthsFirstSeen := checkBlank(SBFENameMatchMonthsFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFENameMatchDateLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFENameMatchDateLastSeen);
																								SELF.SBFE.SBFENameMatchDateLastSeen := checkBlank(SBFENameMatchDateLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFENameMatchMonthsLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFENameMatchMonthsLastSeen);
																								SELF.SBFE.SBFENameMatchMonthsLastSeen := checkBlank(SBFENameMatchMonthsLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.SBFE.SBFEVerBusInputAddr := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99',checkBlank(RIGHT.SBFE.SBFEVerBusInputAddr, '-99'));
																								SBFEAddrMatchDateFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEAddrMatchDateFirstSeen);
																								SELF.SBFE.SBFEAddrMatchDateFirstSeen := checkBlank(SBFEAddrMatchDateFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEAddrMatchMonthsFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEAddrMatchMonthsFirstSeen);
																								SELF.SBFE.SBFEAddrMatchMonthsFirstSeen := checkBlank(SBFEAddrMatchMonthsFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEAddrMatchDateLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEAddrMatchDateLastSeen);
																								SELF.SBFE.SBFEAddrMatchDateLastSeen := checkBlank(SBFEAddrMatchDateLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEAddrMatchMonthsLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEAddrMatchMonthsLastSeen);
																								SELF.SBFE.SBFEAddrMatchMonthsLastSeen := checkBlank(SBFEAddrMatchMonthsLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.SBFE.SBFEVerBusInputPhone := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99',checkBlank(RIGHT.SBFE.SBFEVerBusInputPhone, '-99'));
																								SBFEPhoneMatchDateFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEPhoneMatchDateFirstSeen);
																								SELF.SBFE.SBFEPhoneMatchDateFirstSeen := checkBlank(SBFEPhoneMatchDateFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22); 
																								SBFEPhoneMatchMonthsFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEPhoneMatchMonthsFirstSeen); 
																						 		SELF.SBFE.SBFEPhoneMatchMonthsFirstSeen := checkBlank(SBFEPhoneMatchMonthsFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEPhoneMatchDateLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEPhoneMatchDateLastSeen);
																								SELF.SBFE.SBFEPhoneMatchDateLastSeen := checkBlank(SBFEPhoneMatchDateLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEPhoneMatchMonthsLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEPhoneMatchMonthsLastSeen);
																								SELF.SBFE.SBFEPhoneMatchMonthsLastSeen := checkBlank(SBFEPhoneMatchMonthsLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.SBFE.SBFEVerBusInputPhoneAddr := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99',checkBlank(RIGHT.SBFE.SBFEVerBusInputPhoneAddr, '-99'));
																								SELF.SBFE.SBFEVerBusInputPhoneFEIN := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99',checkBlank(RIGHT.SBFE.SBFEVerBusInputPhoneFEIN, '-99'));
																								SBFEFEINMatchDateFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEFEINMatchDateFirstSeen);
																								SELF.SBFE.SBFEFEINMatchDateFirstSeen := checkBlank(SBFEFEINMatchDateFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEFEINMatchMonthsFirstSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEFEINMatchMonthsFirstSeen);
																								SELF.SBFE.SBFEFEINMatchMonthsFirstSeen := checkBlank(SBFEFEINMatchMonthsFirstSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEFEINMatchDateLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEFEINMatchDateLastSeen);
																								SELF.SBFE.SBFEFEINMatchDateLastSeen := checkBlank(SBFEFEINMatchDateLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SBFEFEINMatchMonthsLastSeen := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', RIGHT.SBFE.SBFEFEINMatchMonthsLastSeen);
																								SELF.SBFE.SBFEFEINMatchMonthsLastSeen := checkBlank(SBFEFEINMatchMonthsLastSeen, '-99', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.SBFE.SBFEVerBusInputIndustryCode := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99',checkBlank(RIGHT.SBFE.SBFEVerBusInputIndustryCode, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep1NameonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep1NameonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep1AddronFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep1AddronFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep1PhoneonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep1PhoneonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep1SSNonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep1SSNonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep2NameonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep2NameonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep2AddronFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep2AddronFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep2PhoneonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep2PhoneonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep2SSNonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep2SSNonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep3NameonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep3NameonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep3AddronFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep3AddronFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep3PhoneonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep3PhoneonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep3SSNonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep3SSNonFile, '-99'));	
																								SELF.SBFE.SBFEBusExecLinkRep4NameonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep4NameonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep4AddronFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep4AddronFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep4PhoneonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep4PhoneonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep4SSNonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep4SSNonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep5NameonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep5NameonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep5AddronFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep5AddronFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep5PhoneonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep5PhoneonFile, '-99'));
																								SELF.SBFE.SBFEBusExecLinkRep5SSNonFile := IF((INTEGER)RIGHT.SBFE.SBFEAccountCount <= 0, '-99', checkBlank(RIGHT.SBFE.SBFEBusExecLinkRep5SSNonFile, '-99'));
																								
																								SELF.SBFE.SBFEDateFirstCycleAll := checkBlank(RIGHT.SBFE.SBFEDateFirstCycleAll, '-99');
																								SELF.SBFE.SBFETimeOldestCycle := checkBlank(RIGHT.SBFE.SBFETimeOldestCycle,'-99');
																								SELF.SBFE.SBFEDateLastCycleAll := checkBlank(RIGHT.SBFE.SBFEDateLastCycleAll, '-99');
																								SELF.SBFE.SBFETimeNewestCycle := checkBlank(RIGHT.SBFE.SBFETimeNewestCycle,'-99');	
																								SELF.SBFE.SBFEAccountCount := checkBlank(RIGHT.SBFE.SBFEAccountCount, '-99');
																								SELF.SBFE.SBFEAccountCount12M := checkBlank(RIGHT.SBFE.SBFEAccountCount12M, '-99');
																								SELF.SBFE.SBFEOpenCount03M := checkBlank(RIGHT.SBFE.SBFEOpenCount03M, '-99');
																								SELF.SBFE.SBFEOpenCount06Month := checkBlank(RIGHT.SBFE.SBFEOpenCount06Month, '-99');
																								SELF.SBFE.SBFEOpenCount12Month := checkBlank(RIGHT.SBFE.SBFEOpenCount12Month, '-99');
																								SELF.SBFE.SBFEOpenCount24Month := checkBlank(RIGHT.SBFE.SBFEOpenCount24Month, '-99');
																								SELF.SBFE.SBFEOpenCount36Month := checkBlank(RIGHT.SBFE.SBFEOpenCount36Month, '-99');
																								SELF.SBFE.SBFEOpenCount60Month := checkBlank(RIGHT.SBFE.SBFEOpenCount60Month, '-99');
																								SELF.SBFE.SBFEOpenCount84M := checkBlank(RIGHT.SBFE.SBFEOpenCount84M, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenAll := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenAll, '-99');
																								SELF.SBFE.SBFETimeOldest := checkBlank(RIGHT.SBFE.SBFETimeOldest,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentAll := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentAll, '-99');
																								SELF.SBFE.SBFETimeNewest := checkBlank(RIGHT.SBFE.SBFETimeNewest,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentAll := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentAll, '-99');
																								SELF.SBFE.SBFETimeNewestClosed := checkBlank(RIGHT.SBFE.SBFETimeNewestClosed,'-99');
																								SELF.SBFE.SBFELoanCount := checkBlank(RIGHT.SBFE.SBFELoanCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenLoan := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenLoan, '-99');
																								SELF.SBFE.SBFETimeOldestLoan := checkBlank(RIGHT.SBFE.SBFETimeOldestLoan,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentLoan := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentLoan, '-99');
																								SELF.SBFE.SBFETimeNewestLoan := checkBlank(RIGHT.SBFE.SBFETimeNewestLoan,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentLoan := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentLoan, '-99');
																								SELF.SBFE.SBFETimeNewestClosedLoan := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedLoan,'-99');
																								SELF.SBFE.SBFELineCount := checkBlank(RIGHT.SBFE.SBFELineCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenLine := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenLine, '-99');
																								SELF.SBFE.SBFETimeOldestLine := checkBlank(RIGHT.SBFE.SBFETimeOldestLine,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentLine := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentLine, '-99');
																								SELF.SBFE.SBFETimeNewestLine := checkBlank(RIGHT.SBFE.SBFETimeNewestLine,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentLine := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentLine, '-99');
																								SELF.SBFE.SBFETimeNewestClosedLine := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedLine,'-99');
																								SELF.SBFE.SBFECardCount := checkBlank(RIGHT.SBFE.SBFECardCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenCard := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenCard, '-99');
																								SELF.SBFE.SBFETimeOldestCard := checkBlank(RIGHT.SBFE.SBFETimeOldestCard,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentCard := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentCard, '-99');
																								SELF.SBFE.SBFETimeNewestCard := checkBlank(RIGHT.SBFE.SBFETimeNewestCard,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentCard := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentCard, '-99');
																								SELF.SBFE.SBFETimeNewestClosedCard := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedCard,'-99');
																								SELF.SBFE.SBFELeaseCount := checkBlank(RIGHT.SBFE.SBFELeaseCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenLease := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenLease, '-99');
																								SELF.SBFE.SBFETimeOldestLease := checkBlank(RIGHT.SBFE.SBFETimeOldestLease,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentLease := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentLease, '-99');
																								SELF.SBFE.SBFETimeNewestLease := checkBlank(RIGHT.SBFE.SBFETimeNewestLease,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentLease := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentLease, '-99');
																								SELF.SBFE.SBFETimeNewestClosedLease := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedLease,'-99');
																								SELF.SBFE.SBFELetterCount := checkBlank(RIGHT.SBFE.SBFELetterCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenLetter := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenLetter, '-99');
																								SELF.SBFE.SBFETimeOldestLetter := checkBlank(RIGHT.SBFE.SBFETimeOldestLetter,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentLetter := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentLetter, '-99');
																								SELF.SBFE.SBFETimeNewestLetter := checkBlank(RIGHT.SBFE.SBFETimeNewestLetter,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentLetter := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentLetter, '-99');
																								SELF.SBFE.SBFETimeNewestClosedLetter := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedLetter,'-99');
																								SELF.SBFE.SBFEOLineCount := checkBlank(RIGHT.SBFE.SBFEOLineCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenOLine := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenOLine, '-99');
																								SELF.SBFE.SBFETimeOldestOELine := checkBlank(RIGHT.SBFE.SBFETimeOldestOELine,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentOLine := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentOLine, '-99');
																								SELF.SBFE.SBFETimeNewestOELine := checkBlank(RIGHT.SBFE.SBFETimeNewestOELine,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentOLine := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentOLine, '-99');
																								SELF.SBFE.SBFETimeNewestClosedOELine := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedOELine,'-99');
																								SELF.SBFE.SBFEOtherCount := checkBlank(RIGHT.SBFE.SBFEOtherCount, '-99');
																								SELF.SBFE.SBFEDateOpenFirstSeenOther := checkBlank(RIGHT.SBFE.SBFEDateOpenFirstSeenOther, '-99');
																								SELF.SBFE.SBFETimeOldestOther := checkBlank(RIGHT.SBFE.SBFETimeOldestOther,'-99');
																								SELF.SBFE.SBFEDateOpenMostRecentOther := checkBlank(RIGHT.SBFE.SBFEDateOpenMostRecentOther, '-99');
																								SELF.SBFE.SBFETimeNewestOther := checkBlank(RIGHT.SBFE.SBFETimeNewestOther,'-99');
																								SELF.SBFE.SBFEDateClosedMostRecentOther := checkBlank(RIGHT.SBFE.SBFEDateClosedMostRecentOther, '-99');
																								SELF.SBFE.SBFETimeNewestClosedOther := checkBlank(RIGHT.SBFE.SBFETimeNewestClosedOther,'-99');
																								SELF.SBFE.SBFEOpenAllCount := checkBlank(RIGHT.SBFE.SBFEOpenAllCount, '-99');
																								SELF.SBFE.SBFEOpenCountHist03M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist03M, '-99');
																								SELF.SBFE.SBFEOpenCountHist06M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist06M, '-99');
																								SELF.SBFE.SBFEOpenCountHist12M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist12M, '-99');
																								SELF.SBFE.SBFEOpenCountHist24M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist24M, '-99');
																								SELF.SBFE.SBFEOpenCountHist36M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist36M, '-99');
																								SELF.SBFE.SBFEOpenCountHist60M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist60M, '-99');
																								SELF.SBFE.SBFEOpenCountHist84M := checkBlank(RIGHT.SBFE.SBFEOpenCountHist84M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount, '-99');
																								SELF.SBFE.SBFEOpenLoanCount03M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount03M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount06M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount06M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount12M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount12M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount24M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount24M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount36M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount36M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount60M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount60M, '-99');
																								SELF.SBFE.SBFEOpenLoanCount84M := checkBlank(RIGHT.SBFE.SBFEOpenLoanCount84M, '-99');
																								SELF.SBFE.SBFEOpenLineCount := checkBlank(RIGHT.SBFE.SBFEOpenLineCount, '-99');
																								SELF.SBFE.SBFEOpenLineCount03M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount03M, '-99');
																								SELF.SBFE.SBFEOpenLineCount06M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount06M, '-99');
																								SELF.SBFE.SBFEOpenLineCount12M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount12M, '-99');
																								SELF.SBFE.SBFEOpenLineCount24M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount24M, '-99');
																								SELF.SBFE.SBFEOpenLineCount36M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount36M, '-99');
																								SELF.SBFE.SBFEOpenLineCount60M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount60M, '-99');
																								SELF.SBFE.SBFEOpenLineCount84M := checkBlank(RIGHT.SBFE.SBFEOpenLineCount84M, '-99');
																								SELF.SBFE.SBFEOpenCardCount := checkBlank(RIGHT.SBFE.SBFEOpenCardCount, '-99');
																								SELF.SBFE.SBFEOpenCardCount03M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount03M, '-99');
																								SELF.SBFE.SBFEOpenCardCount06M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount06M, '-99');
																								SELF.SBFE.SBFEOpenCardCount12M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount12M, '-99');
																								SELF.SBFE.SBFEOpenCardCount24M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount24M, '-99');
																								SELF.SBFE.SBFEOpenCardCount36M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount36M, '-99');
																								SELF.SBFE.SBFEOpenCardCount60M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount60M, '-99');
																								SELF.SBFE.SBFEOpenCardCount84M := checkBlank(RIGHT.SBFE.SBFEOpenCardCount84M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount03M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount03M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount06M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount06M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount12M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount12M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount24M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount24M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount36M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount36M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount60M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount60M, '-99');
																								SELF.SBFE.SBFEOpenLeaseCount84M := checkBlank(RIGHT.SBFE.SBFEOpenLeaseCount84M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount, '-99');
																								SELF.SBFE.SBFEOpenLetterCount03M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount03M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount06M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount06M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount12M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount12M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount24M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount24M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount36M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount36M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount60M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount60M, '-99');
																								SELF.SBFE.SBFEOpenLetterCount84M := checkBlank(RIGHT.SBFE.SBFEOpenLetterCount84M, '-99');
																								SELF.SBFE.SBFEOpenOLineCount := checkBlank(RIGHT.SBFE.SBFEOpenOLineCount, '-99');
																								SELF.SBFE.SBFEOpenOELineCount03M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount03M, '-99');
																								SELF.SBFE.SBFEOpenOELineCount06M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount06M, '-99');
																								SELF.SBFE.SBFEOpenOELineCount12M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount12M, '-99');
																								SELF.SBFE.SBFEOpenOELineCount24M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount24M, '-99');
																								SELF.SBFE.SBFEOpenOELineCount36M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount36M, '-99');
																								SELF.SBFE.SBFEOpenOELineCount60M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount60M, '-99');
																								SELF.SBFE.SBFEOpenOELineCount84M := checkBlank(RIGHT.SBFE.SBFEOpenOELineCount84M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount, '-99');
																								SELF.SBFE.SBFEOpenOtherCount03M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount03M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount06M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount06M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount12M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount12M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount24M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount24M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount36M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount36M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount60M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount60M, '-99');
																								SELF.SBFE.SBFEOpenOtherCount84M := checkBlank(RIGHT.SBFE.SBFEOpenOtherCount84M, '-99');
																								SELF.SBFE.SBFEOpenTypeCount := checkBlank(RIGHT.SBFE.SBFEOpenTypeCount, '-99');
																								SELF.SBFE.SBFEOpenCardCountOnly := checkBlank(RIGHT.SBFE.SBFEOpenCardCountOnly, '-99');
																								SELF.SBFE.SBFEActiveCount := checkBlank(RIGHT.SBFE.SBFEActiveCount, '-99');
																								SELF.SBFE.SBFEActiveLoanCount := checkBlank(RIGHT.SBFE.SBFEActiveLoanCount, '-99');
																								SELF.SBFE.SBFEActiveLineCount := checkBlank(RIGHT.SBFE.SBFEActiveLineCount, '-99');
																								SELF.SBFE.SBFEActiveCardCount := checkBlank(RIGHT.SBFE.SBFEActiveCardCount, '-99');
																								SELF.SBFE.SBFEActiveLeaseCount := checkBlank(RIGHT.SBFE.SBFEActiveLeaseCount, '-99');
																								SELF.SBFE.SBFEActiveLetterCount := checkBlank(RIGHT.SBFE.SBFEActiveLetterCount, '-99');
																								SELF.SBFE.SBFEActiveOLine := checkBlank(RIGHT.SBFE.SBFEActiveOLine, '-99');
																								SELF.SBFE.SBFEActiveOtherCount := checkBlank(RIGHT.SBFE.SBFEActiveOtherCount, '-99');
																								SELF.SBFE.SBFEClosedCount := checkBlank(RIGHT.SBFE.SBFEClosedCount, '-99');
																								SELF.SBFE.SBFEClosedCountLoan := checkBlank(RIGHT.SBFE.SBFEClosedCountLoan, '-99');
																								SELF.SBFE.SBFEClosedCountLine := checkBlank(RIGHT.SBFE.SBFEClosedCountLine, '-99');
																								SELF.SBFE.SBFEClosedCountCard := checkBlank(RIGHT.SBFE.SBFEClosedCountCard, '-99');
																								SELF.SBFE.SBFEClosedCountLease := checkBlank(RIGHT.SBFE.SBFEClosedCountLease, '-99');
																								SELF.SBFE.SBFEClosedCountLetter := checkBlank(RIGHT.SBFE.SBFEClosedCountLetter, '-99');
																								SELF.SBFE.SBFEClosedCountOline := checkBlank(RIGHT.SBFE.SBFEClosedCountOline, '-99');
																								SELF.SBFE.SBFEClosedCountOther := checkBlank(RIGHT.SBFE.SBFEClosedCountOther, '-99');
																								SELF.SBFE.SBFEClosedCountInvoluntary := checkBlank(RIGHT.SBFE.SBFEClosedCountInvoluntary, '-99');
																								SELF.SBFE.SBFEClosedCountVoluntary := checkBlank(RIGHT.SBFE.SBFEClosedCountVoluntary, '-99');
																								SELF.SBFE.SBFEStaleClosedCount := checkBlank(RIGHT.SBFE.SBFEStaleClosedCount, '-99');
																								SELF.SBFE.SBFEStaleClosedCountLoan := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountLoan, '-99');
																								SELF.SBFE.SBFEStaleClosedCountLine := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountLine, '-99');
																								SELF.SBFE.SBFEStaleClosedCountCard := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountCard, '-99');
																								SELF.SBFE.SBFEStaleClosedCountLease := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountLease, '-99');
																								SELF.SBFE.SBFEStaleClosedCountLetter := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountLetter, '-99');
																								SELF.SBFE.SBFEStaleClosedCountOLine := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountOLine, '-99');
																								SELF.SBFE.SBFEStaleClosedCountOther := checkBlank(RIGHT.SBFE.SBFEStaleClosedCountOther, '-99');
																								SELF.SBFE.SBFEInactiveCount := checkBlank(RIGHT.SBFE.SBFEInactiveCount, '-99');
																								SELF.SBFE.SBFEInactiveLoanCount := checkBlank(RIGHT.SBFE.SBFEInactiveLoanCount, '-99');
																								SELF.SBFE.SBFEInactiveLineCount := checkBlank(RIGHT.SBFE.SBFEInactiveLineCount, '-99');
																								SELF.SBFE.SBFEInactiveCardCount := checkBlank(RIGHT.SBFE.SBFEInactiveCardCount, '-99');
																								SELF.SBFE.SBFEInactiveLeaseCount := checkBlank(RIGHT.SBFE.SBFEInactiveLeaseCount, '-99');
																								SELF.SBFE.SBFEInactiveLetterCount := checkBlank(RIGHT.SBFE.SBFEInactiveLetterCount, '-99');
																								SELF.SBFE.SBFEInactiveOLineCount := checkBlank(RIGHT.SBFE.SBFEInactiveOLineCount, '-99');
																								SELF.SBFE.SBFEInactiveOtherCount := checkBlank(RIGHT.SBFE.SBFEInactiveOtherCount, '-99');
																								SELF.SBFE.SBFERecentBalanceAll := checkBlank(RIGHT.SBFE.SBFERecentBalanceAll, '-99');
																								SELF.SBFE.SBFERecentBalanceLoan := checkBlank(RIGHT.SBFE.SBFERecentBalanceLoan, '-99');
																								SELF.SBFE.SBFERecentBalanceLine := checkBlank(RIGHT.SBFE.SBFERecentBalanceLine, '-99');
																								SELF.SBFE.SBFERecentBalanceCard := checkBlank(RIGHT.SBFE.SBFERecentBalanceCard, '-99');
																								SELF.SBFE.SBFERecentBalanceLease := checkBlank(RIGHT.SBFE.SBFERecentBalanceLease, '-99');
																								SELF.SBFE.SBFERecentBalanceLetter := checkBlank(RIGHT.SBFE.SBFERecentBalanceLetter, '-99');
																								SELF.SBFE.SBFERecentBalanceOLine := checkBlank(RIGHT.SBFE.SBFERecentBalanceOLine, '-99');
																								SELF.SBFE.SBFERecentBalanceOther := checkBlank(RIGHT.SBFE.SBFERecentBalanceOther, '-99');
																								SELF.SBFE.SBFERecentBalanceRevAmt := checkBlank(RIGHT.SBFE.SBFERecentBalanceRevAmt, '-99');
																								SELF.SBFE.SBFERecentBalanceInstAmt := checkBlank(RIGHT.SBFE.SBFERecentBalanceInstAmt, '-99');
																								SELF.SBFE.SBFEBalanceAmt03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt03M, '-99');
																								SELF.SBFE.SBFEBalanceAmt06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt06M, '-99');
																								SELF.SBFE.SBFEBalanceAmt12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt12M, '-99');
																								SELF.SBFE.SBFEBalanceAmt24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt24M, '-99');
																								SELF.SBFE.SBFEBalanceAmt36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt36M, '-99');
																								SELF.SBFE.SBFEBalanceAmt60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt60M, '-99');
																								SELF.SBFE.SBFEBalanceAmt84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmt84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLoan84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLoan84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLine84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLine84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtCard84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtCard84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLease84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLease84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtLetter84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtLetter84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOELine84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOELine84M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther03M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther03M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther06M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther06M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther12M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther12M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther24M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther24M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther36M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther36M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther60M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther60M, '-99');
																								SELF.SBFE.SBFEBalanceAmtOther84M := checkBlank(RIGHT.SBFE.SBFEBalanceAmtOther84M, '-99');
																								SELF.SBFE.SBFEAvgBalance03M := checkBlank(RIGHT.SBFE.SBFEAvgBalance03M, '-99');
																								SELF.SBFE.SBFEAveBalance06 := checkBlank(RIGHT.SBFE.SBFEAveBalance06, '-99');
																								SELF.SBFE.SBFEAveBalance12 := checkBlank(RIGHT.SBFE.SBFEAveBalance12, '-99');
																								SELF.SBFE.SBFEAveBalance24 := checkBlank(RIGHT.SBFE.SBFEAveBalance24, '-99');
																								SELF.SBFE.SBFEAveBalance36 := checkBlank(RIGHT.SBFE.SBFEAveBalance36, '-99');
																								SELF.SBFE.SBFEAveBalance60 := checkBlank(RIGHT.SBFE.SBFEAveBalance60, '-99');
																								SELF.SBFE.SBFEAveBalance84 := checkBlank(RIGHT.SBFE.SBFEAveBalance84, '-99');
																								SELF.SBFE.SBFEAveBalanceEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceLoan03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceLoan03M, '-99');
																								SELF.SBFE.SBFEAveBalanceLoan06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoan06, '-99');
																								SELF.SBFE.SBFEAveBalanceLoan12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoan12, '-99');
																								SELF.SBFE.SBFEAveBalanceLoan24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoan24, '-99');
																								SELF.SBFE.SBFEAveBalanceLoan36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoan36, '-99');
																								SELF.SBFE.SBFEAveBalanceLoan60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoan60, '-99');
																								SELF.SBFE.SBFEAveBalanceLoan84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoan84, '-99');
																								SELF.SBFE.SBFEAveBalanceLoanEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceLoanEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceLine03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceLine03M, '-99');
																								SELF.SBFE.SBFEAveBalanceLine06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLine06, '-99');
																								SELF.SBFE.SBFEAveBalanceLine12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLine12, '-99');
																								SELF.SBFE.SBFEAveBalanceLine24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLine24, '-99');
																								SELF.SBFE.SBFEAveBalanceLine36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLine36, '-99');
																								SELF.SBFE.SBFEAveBalanceLine60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLine60, '-99');
																								SELF.SBFE.SBFEAveBalanceLine84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLine84, '-99');
																								SELF.SBFE.SBFEAveBalanceLineEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceLineEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceCard03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceCard03M, '-99');
																								SELF.SBFE.SBFEAveBalanceCard06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceCard06, '-99');
																								SELF.SBFE.SBFEAveBalanceCard12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceCard12, '-99');
																								SELF.SBFE.SBFEAveBalanceCard24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceCard24, '-99');
																								SELF.SBFE.SBFEAveBalanceCard36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceCard36, '-99');
																								SELF.SBFE.SBFEAveBalanceCard60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceCard60, '-99');
																								SELF.SBFE.SBFEAveBalanceCard84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceCard84, '-99');
																								SELF.SBFE.SBFEAveBalanceCardEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceCardEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceLease03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceLease03M, '-99');
																								SELF.SBFE.SBFEAveBalanceLease06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLease06, '-99');
																								SELF.SBFE.SBFEAveBalanceLease12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLease12, '-99');
																								SELF.SBFE.SBFEAveBalanceLease24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLease24, '-99');
																								SELF.SBFE.SBFEAveBalanceLease36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLease36, '-99');
																								SELF.SBFE.SBFEAveBalanceLease60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLease60, '-99');
																								SELF.SBFE.SBFEAveBalanceLease84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLease84, '-99');
																								SELF.SBFE.SBFEAveBalanceLeaseEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceLeaseEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceLetter03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceLetter03M, '-99');
																								SELF.SBFE.SBFEAveBalanceLetter06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetter06, '-99');
																								SELF.SBFE.SBFEAveBalanceLetter12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetter12, '-99');
																								SELF.SBFE.SBFEAveBalanceLetter24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetter24, '-99');
																								SELF.SBFE.SBFEAveBalanceLetter36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetter36, '-99');
																								SELF.SBFE.SBFEAveBalanceLetter60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetter60, '-99');
																								SELF.SBFE.SBFEAveBalanceLetter84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetter84, '-99');
																								SELF.SBFE.SBFEAveBalanceLetterEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceLetterEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceOELine03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceOELine03M, '-99');
																								SELF.SBFE.SBFEAveBalanceOLine06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLine06, '-99');
																								SELF.SBFE.SBFEAveBalanceOLine12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLine12, '-99');
																								SELF.SBFE.SBFEAveBalanceOLine24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLine24, '-99');
																								SELF.SBFE.SBFEAveBalanceOLine36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLine36, '-99');
																								SELF.SBFE.SBFEAveBalanceOLine60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLine60, '-99');
																								SELF.SBFE.SBFEAveBalanceOLine84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLine84, '-99');
																								SELF.SBFE.SBFEAveBalanceOLineEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceOLineEver, '-99');
																								SELF.SBFE.SBFEAvgBalanceOther03M := checkBlank(RIGHT.SBFE.SBFEAvgBalanceOther03M, '-99');
																								SELF.SBFE.SBFEAveBalanceOther06 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOther06, '-99');
																								SELF.SBFE.SBFEAveBalanceOther12 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOther12, '-99');
																								SELF.SBFE.SBFEAveBalanceOther24 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOther24, '-99');
																								SELF.SBFE.SBFEAveBalanceOther36 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOther36, '-99');
																								SELF.SBFE.SBFEAveBalanceOther60 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOther60, '-99');
																								SELF.SBFE.SBFEAveBalanceOther84 := checkBlank(RIGHT.SBFE.SBFEAveBalanceOther84, '-99');
																								SELF.SBFE.SBFEAveBalanceOtherEver := checkBlank(RIGHT.SBFE.SBFEAveBalanceOtherEver, '-99');
																								SELF.SBFE.SBFEHighBalance03M := checkBlank(RIGHT.SBFE.SBFEHighBalance03M, '-99');
																								SELF.SBFE.SBFEHighBalance06M := checkBlank(RIGHT.SBFE.SBFEHighBalance06M, '-99');
																								SELF.SBFE.SBFEHighBalance12M := checkBlank(RIGHT.SBFE.SBFEHighBalance12M, '-99');
																								SELF.SBFE.SBFEHighBalance24M := checkBlank(RIGHT.SBFE.SBFEHighBalance24M, '-99');
																								SELF.SBFE.SBFEHighBalance36M := checkBlank(RIGHT.SBFE.SBFEHighBalance36M, '-99');
																								SELF.SBFE.SBFEHighBalance60M := checkBlank(RIGHT.SBFE.SBFEHighBalance60M, '-99');
																								SELF.SBFE.SBFEHighBalance84M := checkBlank(RIGHT.SBFE.SBFEHighBalance84M, '-99');
																								SELF.SBFE.SBFEHighBalanceEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceEver, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan03M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan06M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan12M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan24M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan36M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan60M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoan84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoan84M, '-99');
																								SELF.SBFE.SBFEHighBalanceLoanEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceLoanEver, '-99');
																								SELF.SBFE.SBFEHighBalanceLine03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine03M, '-99');
																								SELF.SBFE.SBFEHighBalanceLine06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine06M, '-99');
																								SELF.SBFE.SBFEHighBalanceLine12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine12M, '-99');
																								SELF.SBFE.SBFEHighBalanceLine24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine24M, '-99');
																								SELF.SBFE.SBFEHighBalanceLine36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine36M, '-99');
																								SELF.SBFE.SBFEHighBalanceLine60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine60M, '-99');
																								SELF.SBFE.SBFEHighBalanceLine84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLine84M, '-99');
																								SELF.SBFE.SBFEHighBalanceLineEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceLineEver, '-99');
																								SELF.SBFE.SBFEHighBalanceCard03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard03M, '-99');
																								SELF.SBFE.SBFEHighBalanceCard06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard06M, '-99');
																								SELF.SBFE.SBFEHighBalanceCard12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard12M, '-99');
																								SELF.SBFE.SBFEHighBalanceCard24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard24M, '-99');
																								SELF.SBFE.SBFEHighBalanceCard36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard36M, '-99');
																								SELF.SBFE.SBFEHighBalanceCard60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard60M, '-99');
																								SELF.SBFE.SBFEHighBalanceCard84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceCard84M, '-99');
																								SELF.SBFE.SBFEHighBalanceCardEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceCardEver, '-99');
																								SELF.SBFE.SBFEHighBalanceLease03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease03M, '-99');
																								SELF.SBFE.SBFEHighBalanceLease06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease06M, '-99');
																								SELF.SBFE.SBFEHighBalanceLease12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease12M, '-99');
																								SELF.SBFE.SBFEHighBalanceLease24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease24M, '-99');
																								SELF.SBFE.SBFEHighBalanceLease36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease36M, '-99');
																								SELF.SBFE.SBFEHighBalanceLease60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease60M, '-99');
																								SELF.SBFE.SBFEHighBalanceLease84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLease84M, '-99');
																								SELF.SBFE.SBFEHighBalanceLeaseEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceLeaseEver, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter03M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter06M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter12M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter24M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter36M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter60M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetter84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetter84M, '-99');
																								SELF.SBFE.SBFEHighBalanceLetterEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceLetterEver, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine03M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine06M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine12M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine24M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine36M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine60M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELine84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELine84M, '-99');
																								SELF.SBFE.SBFEHighBalanceOELineEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceOELineEver, '-99');
																								SELF.SBFE.SBFEHighBalanceOther03M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther03M, '-99');
																								SELF.SBFE.SBFEHighBalanceOther06M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther06M, '-99');
																								SELF.SBFE.SBFEHighBalanceOther12M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther12M, '-99');
																								SELF.SBFE.SBFEHighBalanceOther24M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther24M, '-99');
																								SELF.SBFE.SBFEHighBalanceOther36M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther36M, '-99');
																								SELF.SBFE.SBFEHighBalanceOther60M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther60M, '-99');
																								SELF.SBFE.SBFEHighBalanceOther84M := checkBlank(RIGHT.SBFE.SBFEHighBalanceOther84M, '-99');
																								SELF.SBFE.SBFEHighBalanceOtherEver := checkBlank(RIGHT.SBFE.SBFEHighBalanceOtherEver, '-99');
																								SELF.SBFE.SBFEBalanceCard12Month := checkBlank(RIGHT.SBFE.SBFEBalanceCard12Month, '-99');
																								SELF.SBFE.SBFEBalanceCard24Month := checkBlank(RIGHT.SBFE.SBFEBalanceCard24Month, '-99');
																								SELF.SBFE.SBFEBalanceCount := checkBlank(RIGHT.SBFE.SBFEBalanceCount, '-99');
																								SELF.SBFE.SBFEBalanceCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCount06 := checkBlank(RIGHT.SBFE.SBFEBalanceCount06, '-99');
																								SELF.SBFE.SBFEBalanceCount12 := checkBlank(RIGHT.SBFE.SBFEBalanceCount12, '-99');
																								SELF.SBFE.SBFEBalanceCount24 := checkBlank(RIGHT.SBFE.SBFEBalanceCount24, '-99');
																								SELF.SBFE.SBFEBalanceCount36 := checkBlank(RIGHT.SBFE.SBFEBalanceCount36, '-99');
																								SELF.SBFE.SBFEBalanceCount60 := checkBlank(RIGHT.SBFE.SBFEBalanceCount60, '-99');
																								SELF.SBFE.SBFEBalanceCount84 := checkBlank(RIGHT.SBFE.SBFEBalanceCount84, '-99');
																								SELF.SBFE.SBFEBalanceCountEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountEver, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan, '-99');
																								SELF.SBFE.SBFEBalanceLoanCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceLoanCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan06, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan12, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan24, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan36, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan60, '-99');
																								SELF.SBFE.SBFEBalanceCountLoan84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoan84, '-99');
																								SELF.SBFE.SBFEBalanceCountLoanEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountLoanEver, '-99');
																								SELF.SBFE.SBFEBalanceCountLine := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine, '-99');
																								SELF.SBFE.SBFEBalanceLineCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceLineCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountLine06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine06, '-99');
																								SELF.SBFE.SBFEBalanceCountLine12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine12, '-99');
																								SELF.SBFE.SBFEBalanceCountLine24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine24, '-99');
																								SELF.SBFE.SBFEBalanceCountLine36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine36, '-99');
																								SELF.SBFE.SBFEBalanceCountLine60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine60, '-99');
																								SELF.SBFE.SBFEBalanceCountLine84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLine84, '-99');
																								SELF.SBFE.SBFEBalanceCountLineEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountLineEver, '-99');
																								SELF.SBFE.SBFEBalanceCountCard := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard, '-99');
																								SELF.SBFE.SBFEBalanceCardCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceCardCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountCard06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard06, '-99');
																								SELF.SBFE.SBFEBalanceCountCard12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard12, '-99');
																								SELF.SBFE.SBFEBalanceCountCard24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard24, '-99');
																								SELF.SBFE.SBFEBalanceCountCard36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard36, '-99');
																								SELF.SBFE.SBFEBalanceCountCard60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard60, '-99');
																								SELF.SBFE.SBFEBalanceCountCard84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountCard84, '-99');
																								SELF.SBFE.SBFEBalanceCountCardEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountCardEver, '-99');
																								SELF.SBFE.SBFEBalanceCountLease := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease, '-99');
																								SELF.SBFE.SBFEBalanceLeaseCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceLeaseCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountLease06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease06, '-99');
																								SELF.SBFE.SBFEBalanceCountLease12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease12, '-99');
																								SELF.SBFE.SBFEBalanceCountLease24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease24, '-99');
																								SELF.SBFE.SBFEBalanceCountLease36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease36, '-99');
																								SELF.SBFE.SBFEBalanceCountLease60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease60, '-99');
																								SELF.SBFE.SBFEBalanceCountLease84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLease84, '-99');
																								SELF.SBFE.SBFEBalanceCountLeaseEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountLeaseEver, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter, '-99');
																								SELF.SBFE.SBFEBalanceLetterCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceLetterCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter06, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter12, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter24, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter36, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter60, '-99');
																								SELF.SBFE.SBFEBalanceCountLetter84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetter84, '-99');
																								SELF.SBFE.SBFEBalanceCountLetterEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountLetterEver, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine, '-99');
																								SELF.SBFE.SBFEBalanceOELineCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceOELineCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine06, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine12, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine24, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine36, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine60, '-99');
																								SELF.SBFE.SBFEBalanceCountOLine84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLine84, '-99');
																								SELF.SBFE.SBFEBalanceCountOLineEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountOLineEver, '-99');
																								SELF.SBFE.SBFEBalanceCountOther := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther, '-99');
																								SELF.SBFE.SBFEBalanceOtherCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceOtherCount03M, '-99');
																								SELF.SBFE.SBFEBalanceCountOther06 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther06, '-99');
																								SELF.SBFE.SBFEBalanceCountOther12 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther12, '-99');
																								SELF.SBFE.SBFEBalanceCountOther24 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther24, '-99');
																								SELF.SBFE.SBFEBalanceCountOther36 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther36, '-99');
																								SELF.SBFE.SBFEBalanceCountOther60 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther60, '-99');
																								SELF.SBFE.SBFEBalanceCountOther84 := checkBlank(RIGHT.SBFE.SBFEBalanceCountOther84, '-99');
																								SELF.SBFE.SBFEBalanceCountOtherEver := checkBlank(RIGHT.SBFE.SBFEBalanceCountOtherEver, '-99');
																								SELF.SBFE.SBFEBalanceCountClosed := checkBlank(RIGHT.SBFE.SBFEBalanceCountClosed, '-99');
																								SELF.SBFE.SBFEBalanceClosedCount03M := checkBlank(RIGHT.SBFE.SBFEBalanceClosedCount03M, '-99');
																								SELF.SBFE.SBFEBalanceClosedCount06M := checkBlank(RIGHT.SBFE.SBFEBalanceClosedCount06M, '-99');
																								SELF.SBFE.SBFEBalanceClosedCount12Month := checkBlank(RIGHT.SBFE.SBFEBalanceClosedCount12Month, '-99');
																								SELF.SBFE.SBFEBalanceClosedCount24M := checkBlank(RIGHT.SBFE.SBFEBalanceClosedCount24M, '-99');
																								SELF.SBFE.SBFEOriginalLimitInstallment := checkBlank(RIGHT.SBFE.SBFEOriginalLimitInstallment, '-99');
																								SELF.SBFE.SBFEOriginalLimitLoan := checkBlank(RIGHT.SBFE.SBFEOriginalLimitLoan, '-99');
																								SELF.SBFE.SBFEOriginalLimitLease := checkBlank(RIGHT.SBFE.SBFEOriginalLimitLease, '-99');
																								SELF.SBFE.SBFECurrentLimitRevolving := checkBlank(RIGHT.SBFE.SBFECurrentLimitRevolving, '-99');
																								SELF.SBFE.SBFELimitRevAmt03M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt03M, '-99');
																								SELF.SBFE.SBFELimitRevAmt06M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt06M, '-99');
																								SELF.SBFE.SBFELimitRevAmt12M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt12M, '-99');
																								SELF.SBFE.SBFELimitRevAmt24M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt24M, '-99');
																								SELF.SBFE.SBFELimitRevAmt36M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt36M, '-99');
																								SELF.SBFE.SBFELimitRevAmt60M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt60M, '-99');
																								SELF.SBFE.SBFELimitRevAmt84M := checkBlank(RIGHT.SBFE.SBFELimitRevAmt84M, '-99');
																								SELF.SBFE.SBFECurrentLimitLine := checkBlank(RIGHT.SBFE.SBFECurrentLimitLine, '-99');
																								SELF.SBFE.SBFELimitLineAmt03M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt03M, '-99');
																								SELF.SBFE.SBFELimitLineAmt06M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt06M, '-99');
																								SELF.SBFE.SBFELimitLineAmt12M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt12M, '-99');
																								SELF.SBFE.SBFELimitLineAmt24M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt24M, '-99');
																								SELF.SBFE.SBFELimitLineAmt36M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt36M, '-99');
																								SELF.SBFE.SBFELimitLineAmt60M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt60M, '-99');
																								SELF.SBFE.SBFELimitLineAmt84M := checkBlank(RIGHT.SBFE.SBFELimitLineAmt84M, '-99');
																								SELF.SBFE.SBFECurrentLimitCard := checkBlank(RIGHT.SBFE.SBFECurrentLimitCard, '-99');
																								SELF.SBFE.SBFELimitCardAmt03M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt03M, '-99');
																								SELF.SBFE.SBFELimitCardAmt06M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt06M, '-99');
																								SELF.SBFE.SBFELimitCardAmt12M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt12M, '-99');
																								SELF.SBFE.SBFELimitCardAmt24M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt24M, '-99');
																								SELF.SBFE.SBFELimitCardAmt36M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt36M, '-99');
																								SELF.SBFE.SBFELimitCardAmt60M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt60M, '-99');
																								SELF.SBFE.SBFELimitCardAmt84M := checkBlank(RIGHT.SBFE.SBFELimitCardAmt84M, '-99');
																								SELF.SBFE.SBFECurrentLimitOLine := checkBlank(RIGHT.SBFE.SBFECurrentLimitOLine, '-99');
																								SELF.SBFE.SBFELimitOELineAmt03M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt03M, '-99');
																								SELF.SBFE.SBFELimitOELineAmt06M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt06M, '-99');
																								SELF.SBFE.SBFELimitOELineAmt12M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt12M, '-99');
																								SELF.SBFE.SBFELimitOELineAmt24M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt24M, '-99');
																								SELF.SBFE.SBFELimitOELineAmt36M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt36M, '-99');
																								SELF.SBFE.SBFELimitOELineAmt60M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt60M, '-99');
																								SELF.SBFE.SBFELimitOELineAmt84M := checkBlank(RIGHT.SBFE.SBFELimitOELineAmt84M, '-99');
																								SELF.SBFE.SBFEScheduledAll := checkBlank(RIGHT.SBFE.SBFEScheduledAll, '-99');
																								SELF.SBFE.SBFEScheduledLoan := checkBlank(RIGHT.SBFE.SBFEScheduledLoan, '-99');
																								SELF.SBFE.SBFEScheduledLine := checkBlank(RIGHT.SBFE.SBFEScheduledLine, '-99');
																								SELF.SBFE.SBFEScheduledCard := checkBlank(RIGHT.SBFE.SBFEScheduledCard, '-99');
																								SELF.SBFE.SBFEScheduledLease := checkBlank(RIGHT.SBFE.SBFEScheduledLease, '-99');
																								SELF.SBFE.SBFEScheduledLetter := checkBlank(RIGHT.SBFE.SBFEScheduledLetter, '-99');
																								SELF.SBFE.SBFEScheduledOLine := checkBlank(RIGHT.SBFE.SBFEScheduledOLine, '-99');
																								SELF.SBFE.SBFEScheduledOther := checkBlank(RIGHT.SBFE.SBFEScheduledOther, '-99');
																								SELF.SBFE.SBFEReceivedAll := checkBlank(RIGHT.SBFE.SBFEReceivedAll, '-99');
																								SELF.SBFE.SBFEReceivedLoan := checkBlank(RIGHT.SBFE.SBFEReceivedLoan, '-99');
																								SELF.SBFE.SBFEReceivedLine := checkBlank(RIGHT.SBFE.SBFEReceivedLine, '-99');
																								SELF.SBFE.SBFEReceivedCard := checkBlank(RIGHT.SBFE.SBFEReceivedCard, '-99');
																								SELF.SBFE.SBFEReceivedLease := checkBlank(RIGHT.SBFE.SBFEReceivedLease, '-99');
																								SELF.SBFE.SBFEReceivedLetter := checkBlank(RIGHT.SBFE.SBFEReceivedLetter, '-99');
																								SELF.SBFE.SBFEReceivedOLine := checkBlank(RIGHT.SBFE.SBFEReceivedOLine, '-99');
																								SELF.SBFE.SBFEReceivedOther := checkBlank(RIGHT.SBFE.SBFEReceivedOther, '-99');
																								SELF.SBFE.SBFEUtilizationCurrentRevolving := checkBlank(RIGHT.SBFE.SBFEUtilizationCurrentRevolving, '-99');
																								SELF.SBFE.SBFEAvailableCurrentRevolving := checkBlank(RIGHT.SBFE.SBFEAvailableCurrentRevolving, '-99');
																								SELF.SBFE.SBFEUtilRevolving03M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving03M, '-99');
																								SELF.SBFE.SBFEUtilRevolving06M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving06M, '-99');
																								SELF.SBFE.SBFEUtilRevolving12M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving12M, '-99');
																								SELF.SBFE.SBFEUtilRevolving24M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving24M, '-99');
																								SELF.SBFE.SBFEUtilRevolving36M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving36M, '-99');
																								SELF.SBFE.SBFEUtilRevolving60M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving60M, '-99');
																								SELF.SBFE.SBFEUtilRevolving84M := checkBlank(RIGHT.SBFE.SBFEUtilRevolving84M, '-99');
																								SELF.SBFE.SBFEUtilizationCurrentLine := checkBlank(RIGHT.SBFE.SBFEUtilizationCurrentLine, '-99');
																								SELF.SBFE.SBFEAvailableCurrentLine := checkBlank(RIGHT.SBFE.SBFEAvailableCurrentLine, '-99');
																								SELF.SBFE.SBFEUtilLine03M := checkBlank(RIGHT.SBFE.SBFEUtilLine03M, '-99');
																								SELF.SBFE.SBFEUtilLine06M := checkBlank(RIGHT.SBFE.SBFEUtilLine06M, '-99');
																								SELF.SBFE.SBFEUtilLine12M := checkBlank(RIGHT.SBFE.SBFEUtilLine12M, '-99');
																								SELF.SBFE.SBFEUtilLine24M := checkBlank(RIGHT.SBFE.SBFEUtilLine24M, '-99');
																								SELF.SBFE.SBFEUtilLine36M := checkBlank(RIGHT.SBFE.SBFEUtilLine36M, '-99');
																								SELF.SBFE.SBFEUtilLine60M := checkBlank(RIGHT.SBFE.SBFEUtilLine60M, '-99');
																								SELF.SBFE.SBFEUtilLine84M := checkBlank(RIGHT.SBFE.SBFEUtilLine84M, '-99');
																								SELF.SBFE.SBFEUtilizationCurrentCard := checkBlank(RIGHT.SBFE.SBFEUtilizationCurrentCard, '-99');
																								SELF.SBFE.SBFEAvailableCurrentCard := checkBlank(RIGHT.SBFE.SBFEAvailableCurrentCard, '-99');
																								SELF.SBFE.SBFEUtilCard03M := checkBlank(RIGHT.SBFE.SBFEUtilCard03M, '-99');
																								SELF.SBFE.SBFEUtilCard06M := checkBlank(RIGHT.SBFE.SBFEUtilCard06M, '-99');
																								SELF.SBFE.SBFEUtilCard12M := checkBlank(RIGHT.SBFE.SBFEUtilCard12M, '-99');
																								SELF.SBFE.SBFEUtilCard24M := checkBlank(RIGHT.SBFE.SBFEUtilCard24M, '-99');
																								SELF.SBFE.SBFEUtilCard36M := checkBlank(RIGHT.SBFE.SBFEUtilCard36M, '-99');
																								SELF.SBFE.SBFEUtilCard60M := checkBlank(RIGHT.SBFE.SBFEUtilCard60M, '-99');
																								SELF.SBFE.SBFEUtilCard84M := checkBlank(RIGHT.SBFE.SBFEUtilCard84M, '-99');
																								SELF.SBFE.SBFEUtilizationCurrentOLine := checkBlank(RIGHT.SBFE.SBFEUtilizationCurrentOLine, '-99');
																								SELF.SBFE.SBFEAvailableCurrentOELine := checkBlank(RIGHT.SBFE.SBFEAvailableCurrentOELine, '-99');
																								SELF.SBFE.SBFEUtilOELine03M := checkBlank(RIGHT.SBFE.SBFEUtilOELine03M, '-99');
																								SELF.SBFE.SBFEUtilOELine06M := checkBlank(RIGHT.SBFE.SBFEUtilOELine06M, '-99');
																								SELF.SBFE.SBFEUtilOELine12M := checkBlank(RIGHT.SBFE.SBFEUtilOELine12M, '-99');
																								SELF.SBFE.SBFEUtilOELine24M := checkBlank(RIGHT.SBFE.SBFEUtilOELine24M, '-99');
																								SELF.SBFE.SBFEUtilOELine36M := checkBlank(RIGHT.SBFE.SBFEUtilOELine36M, '-99');
																								SELF.SBFE.SBFEUtilOELine60M := checkBlank(RIGHT.SBFE.SBFEUtilOELine60M, '-99');
																								SELF.SBFE.SBFEUtilOELine84M := checkBlank(RIGHT.SBFE.SBFEUtilOELine84M, '-99');
																								SELF.SBFE.SBFEUtilization75RevolvingCount := checkBlank(RIGHT.SBFE.SBFEUtilization75RevolvingCount, '-99');
																								SELF.SBFE.SBFEUtilization75Line := checkBlank(RIGHT.SBFE.SBFEUtilization75Line, '-99');
																								SELF.SBFE.SBFEUtilization75Card := checkBlank(RIGHT.SBFE.SBFEUtilization75Card, '-99');
																								SELF.SBFE.SBFEUtilization75OLine := checkBlank(RIGHT.SBFE.SBFEUtilization75OLine, '-99');
																								SELF.SBFE.SBFEUtilization30Revolving := checkBlank(RIGHT.SBFE.SBFEUtilization30Revolving, '-99');
																								SELF.SBFE.SBFEUtilization30Line := checkBlank(RIGHT.SBFE.SBFEUtilization30Line, '-99');
																								SELF.SBFE.SBFEUtilization30Card := checkBlank(RIGHT.SBFE.SBFEUtilization30Card, '-99');
																								SELF.SBFE.SBFEUtilization30OLine := checkBlank(RIGHT.SBFE.SBFEUtilization30OLine, '-99');
																								SELF.SBFE.SBFEAvgUtil03M := checkBlank(RIGHT.SBFE.SBFEAvgUtil03M, '-99');
																								SELF.SBFE.SBFEUtilizationAve06 := checkBlank(RIGHT.SBFE.SBFEUtilizationAve06, '-99');
																								SELF.SBFE.SBFEUtilizationAve12 := checkBlank(RIGHT.SBFE.SBFEUtilizationAve12, '-99');
																								SELF.SBFE.SBFEUtilizationAve24 := checkBlank(RIGHT.SBFE.SBFEUtilizationAve24, '-99');
																								SELF.SBFE.SBFEUtilizationAve36 := checkBlank(RIGHT.SBFE.SBFEUtilizationAve36, '-99');
																								SELF.SBFE.SBFEUtilizationAve60 := checkBlank(RIGHT.SBFE.SBFEUtilizationAve60, '-99');
																								SELF.SBFE.SBFEUtilizationAve84 := checkBlank(RIGHT.SBFE.SBFEUtilizationAve84, '-99');
																								SELF.SBFE.SBFEUtilizationAveEver := checkBlank(RIGHT.SBFE.SBFEUtilizationAveEver, '-99');
																								SELF.SBFE.SBFEAvgUtilLine03M := checkBlank(RIGHT.SBFE.SBFEAvgUtilLine03M, '-99');
																								SELF.SBFE.SBFEUtilizationAve06Line := checkBlank(RIGHT.SBFE.SBFEUtilizationAve06Line, '-99');
																								SELF.SBFE.SBFEUtilizationAve12Line := checkBlank(RIGHT.SBFE.SBFEUtilizationAve12Line, '-99');
																								SELF.SBFE.SBFEUtilizationAve24Line := checkBlank(RIGHT.SBFE.SBFEUtilizationAve24Line, '-99');
																								SELF.SBFE.SBFEUtilizationAve36Line := checkBlank(RIGHT.SBFE.SBFEUtilizationAve36Line, '-99');
																								SELF.SBFE.SBFEUtilizationAve60Line := checkBlank(RIGHT.SBFE.SBFEUtilizationAve60Line, '-99');
																								SELF.SBFE.SBFEUtilizationAve84Line := checkBlank(RIGHT.SBFE.SBFEUtilizationAve84Line, '-99');
																								SELF.SBFE.SBFEUtilizationAveEverLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAveEverLine, '-99');
																								SELF.SBFE.SBFEAvgUtilCard03M := checkBlank(RIGHT.SBFE.SBFEAvgUtilCard03M, '-99');
																								SELF.SBFE.SBFEUtilizationAve06Card := checkBlank(RIGHT.SBFE.SBFEUtilizationAve06Card, '-99');
																								SELF.SBFE.SBFEUtilizationAve12Card := checkBlank(RIGHT.SBFE.SBFEUtilizationAve12Card, '-99');
																								SELF.SBFE.SBFEUtilizationAve24Card := checkBlank(RIGHT.SBFE.SBFEUtilizationAve24Card, '-99');
																								SELF.SBFE.SBFEUtilizationAve36Card := checkBlank(RIGHT.SBFE.SBFEUtilizationAve36Card, '-99');
																								SELF.SBFE.SBFEUtilizationAve60Card := checkBlank(RIGHT.SBFE.SBFEUtilizationAve60Card, '-99');
																								SELF.SBFE.SBFEUtilizationAve84Card := checkBlank(RIGHT.SBFE.SBFEUtilizationAve84Card, '-99');
																								SELF.SBFE.SBFEUtilizationAveEverCard := checkBlank(RIGHT.SBFE.SBFEUtilizationAveEverCard, '-99');
																								SELF.SBFE.SBFEAvgUtilOELine03M := checkBlank(RIGHT.SBFE.SBFEAvgUtilOELine03M, '-99');
																								SELF.SBFE.SBFEUtilizationAve06OLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAve06OLine, '-99');
																								SELF.SBFE.SBFEUtilizationAve12OLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAve12OLine, '-99');
																								SELF.SBFE.SBFEUtilizationAve24OLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAve24OLine, '-99');
																								SELF.SBFE.SBFEUtilizationAve36OLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAve36OLine, '-99');
																								SELF.SBFE.SBFEUtilizationAve60OLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAve60OLine, '-99');
																								SELF.SBFE.SBFEUtilizationAve84OLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAve84OLine, '-99');
																								SELF.SBFE.SBFEUtilizationAveEverOLine := checkBlank(RIGHT.SBFE.SBFEUtilizationAveEverOLine, '-99');
																								SELF.SBFE.SBFEUtilizationHighRevolving := checkBlank(RIGHT.SBFE.SBFEUtilizationHighRevolving, '-99');
																								SELF.SBFE.SBFEUtilizationHighLine := checkBlank(RIGHT.SBFE.SBFEUtilizationHighLine, '-99');
																								SELF.SBFE.SBFEUtilizationHighCard := checkBlank(RIGHT.SBFE.SBFEUtilizationHighCard, '-99');
																								SELF.SBFE.SBFEUtilizationIndexCard12Month := checkBlank(RIGHT.SBFE.SBFEUtilizationIndexCard12Month, '-99');
																								SELF.SBFE.SBFEUtilizationIndexCard24Month := checkBlank(RIGHT.SBFE.SBFEUtilizationIndexCard24Month, '-99');
																								SELF.SBFE.SBFEUtiliztionHighOLine := checkBlank(RIGHT.SBFE.SBFEUtiliztionHighOLine, '-99');
																								SELF.SBFE.SBFEWorstOpen := checkBlank(RIGHT.SBFE.SBFEWorstOpen, '-99');
																								SELF.SBFE.SBFEHighDelq03M := checkBlank(RIGHT.SBFE.SBFEHighDelq03M, '-99');
																								SELF.SBFE.SBFEWorst06 := checkBlank(RIGHT.SBFE.SBFEWorst06, '-99');
																								SELF.SBFE.SBFEWorst12 := checkBlank(RIGHT.SBFE.SBFEWorst12, '-99');
																								SELF.SBFE.SBFEWorst24 := checkBlank(RIGHT.SBFE.SBFEWorst24, '-99');
																								SELF.SBFE.SBFEWorst36 := checkBlank(RIGHT.SBFE.SBFEWorst36, '-99');
																								SELF.SBFE.SBFEWorst60 := checkBlank(RIGHT.SBFE.SBFEWorst60, '-99');
																								SELF.SBFE.SBFEWorst84 := checkBlank(RIGHT.SBFE.SBFEWorst84, '-99');
																								SELF.SBFE.SBFEWorstEver := checkBlank(RIGHT.SBFE.SBFEWorstEver, '-99');
																								SELF.SBFE.SBFEWorstLoan := checkBlank(RIGHT.SBFE.SBFEWorstLoan, '-99');
																								SELF.SBFE.SBFEHighDelqLoan03M := checkBlank(RIGHT.SBFE.SBFEHighDelqLoan03M, '-99');
																								SELF.SBFE.SBFEWorstLoan06 := checkBlank(RIGHT.SBFE.SBFEWorstLoan06, '-99');
																								SELF.SBFE.SBFEWorstLoan12 := checkBlank(RIGHT.SBFE.SBFEWorstLoan12, '-99');
																								SELF.SBFE.SBFEWorstLoan24 := checkBlank(RIGHT.SBFE.SBFEWorstLoan24, '-99');
																								SELF.SBFE.SBFEWorstLoan36 := checkBlank(RIGHT.SBFE.SBFEWorstLoan36, '-99');
																								SELF.SBFE.SBFEWorstLoan60 := checkBlank(RIGHT.SBFE.SBFEWorstLoan60, '-99');
																								SELF.SBFE.SBFEWorstLoan84 := checkBlank(RIGHT.SBFE.SBFEWorstLoan84, '-99');
																								SELF.SBFE.SBFEWorstLoanEver := checkBlank(RIGHT.SBFE.SBFEWorstLoanEver, '-99');
																								SELF.SBFE.SBFEWorstLine := checkBlank(RIGHT.SBFE.SBFEWorstLine, '-99');
																								SELF.SBFE.SBFEHighDelqLine03M := checkBlank(RIGHT.SBFE.SBFEHighDelqLine03M, '-99');
																								SELF.SBFE.SBFEWorstLine06 := checkBlank(RIGHT.SBFE.SBFEWorstLine06, '-99');
																								SELF.SBFE.SBFEWorstLine12 := checkBlank(RIGHT.SBFE.SBFEWorstLine12, '-99');
																								SELF.SBFE.SBFEWorstLine24 := checkBlank(RIGHT.SBFE.SBFEWorstLine24, '-99');
																								SELF.SBFE.SBFEWorstLine36 := checkBlank(RIGHT.SBFE.SBFEWorstLine36, '-99');
																								SELF.SBFE.SBFEWorstLine60 := checkBlank(RIGHT.SBFE.SBFEWorstLine60, '-99');
																								SELF.SBFE.SBFEWorstLine84 := checkBlank(RIGHT.SBFE.SBFEWorstLine84, '-99');
																								SELF.SBFE.SBFEWorstLineEver := checkBlank(RIGHT.SBFE.SBFEWorstLineEver, '-99');
																								SELF.SBFE.SBFEWorstCard := checkBlank(RIGHT.SBFE.SBFEWorstCard, '-99');
																								SELF.SBFE.SBFEHighDelqCard03M := checkBlank(RIGHT.SBFE.SBFEHighDelqCard03M, '-99');
																								SELF.SBFE.SBFEWorstCard06 := checkBlank(RIGHT.SBFE.SBFEWorstCard06, '-99');
																								SELF.SBFE.SBFEWorstCard12 := checkBlank(RIGHT.SBFE.SBFEWorstCard12, '-99');
																								SELF.SBFE.SBFEWorstCard24 := checkBlank(RIGHT.SBFE.SBFEWorstCard24, '-99');
																								SELF.SBFE.SBFEWorstCard36 := checkBlank(RIGHT.SBFE.SBFEWorstCard36, '-99');
																								SELF.SBFE.SBFEWorstCard60 := checkBlank(RIGHT.SBFE.SBFEWorstCard60, '-99');
																								SELF.SBFE.SBFEWorstCard84 := checkBlank(RIGHT.SBFE.SBFEWorstCard84, '-99');
																								SELF.SBFE.SBFEWorstCardEver := checkBlank(RIGHT.SBFE.SBFEWorstCardEver, '-99');
																								SELF.SBFE.SBFEWorstLease := checkBlank(RIGHT.SBFE.SBFEWorstLease, '-99');
																								SELF.SBFE.SBFEHighDelqLease03M := checkBlank(RIGHT.SBFE.SBFEHighDelqLease03M, '-99');
																								SELF.SBFE.SBFEWorstLease06 := checkBlank(RIGHT.SBFE.SBFEWorstLease06, '-99');
																								SELF.SBFE.SBFEWorstLease12 := checkBlank(RIGHT.SBFE.SBFEWorstLease12, '-99');
																								SELF.SBFE.SBFEWorstLease24 := checkBlank(RIGHT.SBFE.SBFEWorstLease24, '-99');
																								SELF.SBFE.SBFEWorstLease36 := checkBlank(RIGHT.SBFE.SBFEWorstLease36, '-99');
																								SELF.SBFE.SBFEWorstLease60 := checkBlank(RIGHT.SBFE.SBFEWorstLease60, '-99');
																								SELF.SBFE.SBFEWorstLease84 := checkBlank(RIGHT.SBFE.SBFEWorstLease84, '-99');
																								SELF.SBFE.SBFEWorstLeaseEver := checkBlank(RIGHT.SBFE.SBFEWorstLeaseEver, '-99');
																								SELF.SBFE.SBFEWorstLetter := checkBlank(RIGHT.SBFE.SBFEWorstLetter, '-99');
																								SELF.SBFE.SBFEHighDelqLetter03M := checkBlank(RIGHT.SBFE.SBFEHighDelqLetter03M, '-99');
																								SELF.SBFE.SBFEWorstLetter06 := checkBlank(RIGHT.SBFE.SBFEWorstLetter06, '-99');
																								SELF.SBFE.SBFEWorstLetter12 := checkBlank(RIGHT.SBFE.SBFEWorstLetter12, '-99');
																								SELF.SBFE.SBFEWorstLetter24 := checkBlank(RIGHT.SBFE.SBFEWorstLetter24, '-99');
																								SELF.SBFE.SBFEWorstLetter36 := checkBlank(RIGHT.SBFE.SBFEWorstLetter36, '-99');
																								SELF.SBFE.SBFEWorstLetter60 := checkBlank(RIGHT.SBFE.SBFEWorstLetter60, '-99');
																								SELF.SBFE.SBFEWorstLetter84 := checkBlank(RIGHT.SBFE.SBFEWorstLetter84, '-99');
																								SELF.SBFE.SBFEWorstLetterEver := checkBlank(RIGHT.SBFE.SBFEWorstLetterEver, '-99');
																								SELF.SBFE.SBFEWorstOLine := checkBlank(RIGHT.SBFE.SBFEWorstOLine, '-99');
																								SELF.SBFE.SBFEHighDelqOELine03M := checkBlank(RIGHT.SBFE.SBFEHighDelqOELine03M, '-99');
																								SELF.SBFE.SBFEWorstOLine06 := checkBlank(RIGHT.SBFE.SBFEWorstOLine06, '-99');
																								SELF.SBFE.SBFEWorstOLine12 := checkBlank(RIGHT.SBFE.SBFEWorstOLine12, '-99');
																								SELF.SBFE.SBFEWorstOLine24 := checkBlank(RIGHT.SBFE.SBFEWorstOLine24, '-99');
																								SELF.SBFE.SBFEWorstOLine36 := checkBlank(RIGHT.SBFE.SBFEWorstOLine36, '-99');
																								SELF.SBFE.SBFEWorstOLine60 := checkBlank(RIGHT.SBFE.SBFEWorstOLine60, '-99');
																								SELF.SBFE.SBFEWorstOLine84 := checkBlank(RIGHT.SBFE.SBFEWorstOLine84, '-99');
																								SELF.SBFE.SBFEWorstOLineEver := checkBlank(RIGHT.SBFE.SBFEWorstOLineEver, '-99');
																								SELF.SBFE.SBFEWorstOther := checkBlank(RIGHT.SBFE.SBFEWorstOther, '-99');
																								SELF.SBFE.SBFEHighDelqOther03M := checkBlank(RIGHT.SBFE.SBFEHighDelqOther03M, '-99');
																								SELF.SBFE.SBFEWorstOther06 := checkBlank(RIGHT.SBFE.SBFEWorstOther06, '-99');
																								SELF.SBFE.SBFEWorstOther12 := checkBlank(RIGHT.SBFE.SBFEWorstOther12, '-99');
																								SELF.SBFE.SBFEWorstOther24 := checkBlank(RIGHT.SBFE.SBFEWorstOther24, '-99');
																								SELF.SBFE.SBFEWorstOther36 := checkBlank(RIGHT.SBFE.SBFEWorstOther36, '-99');
																								SELF.SBFE.SBFEWorstOther60 := checkBlank(RIGHT.SBFE.SBFEWorstOther60, '-99');
																								SELF.SBFE.SBFEWorstOther84 := checkBlank(RIGHT.SBFE.SBFEWorstOther84, '-99');
																								SELF.SBFE.SBFEWorstOtherEver := checkBlank(RIGHT.SBFE.SBFEWorstOtherEver, '-99');
																								SELF.SBFE.SBFEHighDelqRevOpen := checkBlank(RIGHT.SBFE.SBFEHighDelqRevOpen, '-99');
																								SELF.SBFE.SBFEHighDelqRev03M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev03M, '-99');
																								SELF.SBFE.SBFEHighDelqRev06M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev06M, '-99');
																								SELF.SBFE.SBFEHighDelqRev12M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev12M, '-99');
																								SELF.SBFE.SBFEHighDelqRev24M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev24M, '-99');
																								SELF.SBFE.SBFEHighDelqRev36M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev36M, '-99');
																								SELF.SBFE.SBFEHighDelqRev60M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev60M, '-99');
																								SELF.SBFE.SBFEHighDelqRev84M := checkBlank(RIGHT.SBFE.SBFEHighDelqRev84M, '-99');
																								SELF.SBFE.SBFEHighDelqRevEver := checkBlank(RIGHT.SBFE.SBFEHighDelqRevEver, '-99');
																								SELF.SBFE.SBFEHighDelqInstOpen := checkBlank(RIGHT.SBFE.SBFEHighDelqInstOpen, '-99');
																								SELF.SBFE.SBFEHighDelqInst03M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst03M, '-99');
																								SELF.SBFE.SBFEHighDelqInst06M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst06M, '-99');
																								SELF.SBFE.SBFEHighDelqInst12M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst12M, '-99');
																								SELF.SBFE.SBFEHighDelqInst24M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst24M, '-99');
																								SELF.SBFE.SBFEHighDelqInst36M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst36M, '-99');
																								SELF.SBFE.SBFEHighDelqInst60M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst60M, '-99');
																								SELF.SBFE.SBFEHighDelqInst84M := checkBlank(RIGHT.SBFE.SBFEHighDelqInst84M, '-99');
																								SELF.SBFE.SBFEHighDelqInstEver := checkBlank(RIGHT.SBFE.SBFEHighDelqInstEver, '-99');
																								SELF.SBFE.SBFECurrentCount := checkBlank(RIGHT.SBFE.SBFECurrentCount, '-99');
																								SELF.SBFE.SBFESatisfactoryCount := checkBlank(RIGHT.SBFE.SBFESatisfactoryCount, '-99');
																								SELF.SBFE.SBFESatisfactoryCountLoan := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountLoan, '-99');
																								SELF.SBFE.SBFESatisfactoryCountLine := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountLine, '-99');
																								SELF.SBFE.SBFESatisfactoryCountCard := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountCard, '-99');
																								SELF.SBFE.SBFESatisfactoryCountLease := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountLease, '-99');
																								SELF.SBFE.SBFESatisfactoryCountLetter := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountLetter, '-99');
																								SELF.SBFE.SBFESatisfactoryCountOLine := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountOLine, '-99');
																								SELF.SBFE.SBFESatisfactoryCountOther := checkBlank(RIGHT.SBFE.SBFESatisfactoryCountOther, '-99');
																								SELF.SBFE.SBFEDPDDateLastSeen := checkBlank(RIGHT.SBFE.SBFEDPDDateLastSeen, '-99');
																								SELF.SBFE.SBFETimeNewestDelq := checkBlank(RIGHT.SBFE.SBFETimeNewestDelq,'-99');
																								SELF.SBFE.SBFEDelq1CountTtl := checkBlank(RIGHT.SBFE.SBFEDelq1CountTtl, '-99');
																								SELF.SBFE.SBFEDelq1CountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq1CountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDPD1Count := checkBlank(RIGHT.SBFE.SBFEDPD1Count, '-99');
																								SELF.SBFE.SBFEDelq1Count03M := checkBlank(RIGHT.SBFE.SBFEDelq1Count03M, '-99');
																								SELF.SBFE.SBFEDPD1Count06 := checkBlank(RIGHT.SBFE.SBFEDPD1Count06, '-99');
																								SELF.SBFE.SBFEDPD1Count12 := checkBlank(RIGHT.SBFE.SBFEDPD1Count12, '-99');
																								SELF.SBFE.SBFEDPD1Count24 := checkBlank(RIGHT.SBFE.SBFEDPD1Count24, '-99');
																								SELF.SBFE.SBFEDPD1Count36 := checkBlank(RIGHT.SBFE.SBFEDPD1Count36, '-99');
																								SELF.SBFE.SBFEDPD1Count60 := checkBlank(RIGHT.SBFE.SBFEDPD1Count60, '-99');
																								SELF.SBFE.SBFEDPD1Count84 := checkBlank(RIGHT.SBFE.SBFEDPD1Count84, '-99');
																								SELF.SBFE.SBFEDPD1CountEver := checkBlank(RIGHT.SBFE.SBFEDPD1CountEver, '-99');
																								SELF.SBFE.SBFEDelq1CountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq1CountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount03M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount06M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount12M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount24M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount36M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount60M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCount84M, '-99');
																								SELF.SBFE.SBFEDelq1LoanCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCountEver, '-99');
																								SELF.SBFE.SBFEDelq1LineCount := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount, '-99');
																								SELF.SBFE.SBFEDelq1LineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount03M, '-99');
																								SELF.SBFE.SBFEDelq1LineCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount06M, '-99');
																								SELF.SBFE.SBFEDelq1LineCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount12M, '-99');
																								SELF.SBFE.SBFEDelq1LineCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount24M, '-99');
																								SELF.SBFE.SBFEDelq1LineCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount36M, '-99');
																								SELF.SBFE.SBFEDelq1LineCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount60M, '-99');
																								SELF.SBFE.SBFEDelq1LineCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1LineCount84M, '-99');
																								SELF.SBFE.SBFEDelq1LineCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1LineCountEver, '-99');
																								SELF.SBFE.SBFEDelq1CardCount := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount, '-99');
																								SELF.SBFE.SBFEDelq1CardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount03M, '-99');
																								SELF.SBFE.SBFEDelq1CardCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount06M, '-99');
																								SELF.SBFE.SBFEDelq1CardCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount12M, '-99');
																								SELF.SBFE.SBFEDelq1CardCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount24M, '-99');
																								SELF.SBFE.SBFEDelq1CardCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount36M, '-99');
																								SELF.SBFE.SBFEDelq1CardCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount60M, '-99');
																								SELF.SBFE.SBFEDelq1CardCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1CardCount84M, '-99');
																								SELF.SBFE.SBFEDelq1CardCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1CardCountEver, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount03M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount06M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount12M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount24M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount36M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount60M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCount84M, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCountEver, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount03M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount06M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount12M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount24M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount36M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount60M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCount84M, '-99');
																								SELF.SBFE.SBFEDelq1LetterCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1LetterCountEver, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount03M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount06M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount12M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount24M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount36M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount60M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCount84M, '-99');
																								SELF.SBFE.SBFEDelq1OELineCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1OELineCountEver, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount03M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount06M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount06M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount12M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount12M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount24M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount24M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount36M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount36M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount60M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount60M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCount84M := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCount84M, '-99');
																								SELF.SBFE.SBFEDelq1OtherCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1OtherCountEver, '-99');
																								SELF.SBFE.SBFEDelq1LeaseCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq1LeaseCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq1LoanCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq1LoanCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelqLetterCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelqLetterCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq1InstCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq1InstCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq1InstCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1InstCountEver, '-99');
																								SELF.SBFE.SBFEDelq1InstCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq1InstCountTtl, '-99');
																								SELF.SBFE.SBFEDelq1InstCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq1InstCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq1RevCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq1RevCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq1RevCountEver := checkBlank(RIGHT.SBFE.SBFEDelq1RevCountEver, '-99');
																								SELF.SBFE.SBFEDelq1RevCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq1RevCountTtl, '-99');
																								SELF.SBFE.SBFEDelq1RevCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq1RevCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq31CountTtl := checkBlank(RIGHT.SBFE.SBFEDelq31CountTtl, '-99');
																								SELF.SBFE.SBFEDelq31CountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq31CountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDPD31Count := checkBlank(RIGHT.SBFE.SBFEDPD31Count, '-99');
																								SELF.SBFE.SBFEDelq31Count03M := checkBlank(RIGHT.SBFE.SBFEDelq31Count03M, '-99');
																								SELF.SBFE.SBFEDPD31Count06 := checkBlank(RIGHT.SBFE.SBFEDPD31Count06, '-99');
																								SELF.SBFE.SBFEDPD31Count12 := checkBlank(RIGHT.SBFE.SBFEDPD31Count12, '-99');
																								SELF.SBFE.SBFEDPD31Count24 := checkBlank(RIGHT.SBFE.SBFEDPD31Count24, '-99');
																								SELF.SBFE.SBFEDPD31Count36 := checkBlank(RIGHT.SBFE.SBFEDPD31Count36, '-99');
																								SELF.SBFE.SBFEDPD31Count60 := checkBlank(RIGHT.SBFE.SBFEDPD31Count60, '-99');
																								SELF.SBFE.SBFEDPD31Count84 := checkBlank(RIGHT.SBFE.SBFEDPD31Count84, '-99');
																								SELF.SBFE.SBFEDPD31CountEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountEver, '-99');
																								SELF.SBFE.SBFEDelq31CountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq31CountEverTtl, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan, '-99');
																								SELF.SBFE.SBFEDelq31LoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan06, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan12, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan24, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan36, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan60, '-99');
																								SELF.SBFE.SBFEDPD31CountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoan84, '-99');
																								SELF.SBFE.SBFEDPD31CountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountLoanEver, '-99');
																								SELF.SBFE.SBFEDPD31CountLine := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine, '-99');
																								SELF.SBFE.SBFEDelq31LineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31LineCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine06, '-99');
																								SELF.SBFE.SBFEDPD31CountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine12, '-99');
																								SELF.SBFE.SBFEDPD31CountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine24, '-99');
																								SELF.SBFE.SBFEDPD31CountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine36, '-99');
																								SELF.SBFE.SBFEDPD31CountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine60, '-99');
																								SELF.SBFE.SBFEDPD31CountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLine84, '-99');
																								SELF.SBFE.SBFEDPD31CountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountLineEver, '-99');
																								SELF.SBFE.SBFEDPD31CountCard := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard, '-99');
																								SELF.SBFE.SBFEDelq31CardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31CardCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard06, '-99');
																								SELF.SBFE.SBFEDPD31CountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard12, '-99');
																								SELF.SBFE.SBFEDPD31CountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard24, '-99');
																								SELF.SBFE.SBFEDPD31CountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard36, '-99');
																								SELF.SBFE.SBFEDPD31CountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard60, '-99');
																								SELF.SBFE.SBFEDPD31CountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountCard84, '-99');
																								SELF.SBFE.SBFEDPD31CountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountCardEver, '-99');
																								SELF.SBFE.SBFEDPD31CountLease := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease, '-99');
																								SELF.SBFE.SBFEDelq31LeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease06, '-99');
																								SELF.SBFE.SBFEDPD31CountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease12, '-99');
																								SELF.SBFE.SBFEDPD31CountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease24, '-99');
																								SELF.SBFE.SBFEDPD31CountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease36, '-99');
																								SELF.SBFE.SBFEDPD31CountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease60, '-99');
																								SELF.SBFE.SBFEDPD31CountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLease84, '-99');
																								SELF.SBFE.SBFEDPD31CountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountLeaseEver, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter, '-99');
																								SELF.SBFE.SBFEDelq31LetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter06, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter12, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter24, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter36, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter60, '-99');
																								SELF.SBFE.SBFEDPD31CountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetter84, '-99');
																								SELF.SBFE.SBFEDPD31CountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountLetterEver, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine, '-99');
																								SELF.SBFE.SBFEDelq31OELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine06, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine12, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine24, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine36, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine60, '-99');
																								SELF.SBFE.SBFEDPD31CountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLine84, '-99');
																								SELF.SBFE.SBFEDPD31CountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountOLineEver, '-99');
																								SELF.SBFE.SBFEDPD31CountOther := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther, '-99');
																								SELF.SBFE.SBFEDelq31OtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD31CountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther06, '-99');
																								SELF.SBFE.SBFEDPD31CountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther12, '-99');
																								SELF.SBFE.SBFEDPD31CountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther24, '-99');
																								SELF.SBFE.SBFEDPD31CountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther36, '-99');
																								SELF.SBFE.SBFEDPD31CountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther60, '-99');
																								SELF.SBFE.SBFEDPD31CountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD31CountOther84, '-99');
																								SELF.SBFE.SBFEDPD31CountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD31CountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq31InstCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq31InstCountTtl, '-99');
																								SELF.SBFE.SBFEDelq31InstCountEver := checkBlank(RIGHT.SBFE.SBFEDelq31InstCountEver, '-99');
																								SELF.SBFE.SBFEDelq31InstCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq31InstCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq31RevCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq31RevCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq31RevCountEver := checkBlank(RIGHT.SBFE.SBFEDelq31RevCountEver, '-99');
																								SELF.SBFE.SBFEDelq31RevCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq31RevCountTtl, '-99');
																								SELF.SBFE.SBFEDelq31RevCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq31RevCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq61CountTtl := checkBlank(RIGHT.SBFE.SBFEDelq61CountTtl, '-99');
																								SELF.SBFE.SBFEDelq61CountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq61CountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelinquentCount := checkBlank(RIGHT.SBFE.SBFEDelinquentCount, '-99');
																								SELF.SBFE.SBFEDelq61Count03M := checkBlank(RIGHT.SBFE.SBFEDelq61Count03M, '-99');
																								SELF.SBFE.SBFEDelinquentCount06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCount06, '-99');
																								SELF.SBFE.SBFEDelinquentCount12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCount12, '-99');
																								SELF.SBFE.SBFEDelinquentCount24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCount24, '-99');
																								SELF.SBFE.SBFEDelinquentCount36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCount36, '-99');
																								SELF.SBFE.SBFEDelinquentCount60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCount60, '-99');
																								SELF.SBFE.SBFEDelinquentCount84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCount84, '-99');
																								SELF.SBFE.SBFEDelinquentCountEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountEver, '-99');
																								SELF.SBFE.SBFEDelq61CountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq61CountEverTtl, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan, '-99');
																								SELF.SBFE.SBFEDelq61LoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan06, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan12, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan24, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan36, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan60, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoan84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoan84, '-99');
																								SELF.SBFE.SBFEDelinquentCountLoanEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLoanEver, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine, '-99');
																								SELF.SBFE.SBFEDelq61LineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61LineCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine06, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine12, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine24, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine36, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine60, '-99');
																								SELF.SBFE.SBFEDelinquentCountLine84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLine84, '-99');
																								SELF.SBFE.SBFEDelinquentCountLineEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLineEver, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard, '-99');
																								SELF.SBFE.SBFEDelq61CardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61CardCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard06, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard12, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard24, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard36, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard60, '-99');
																								SELF.SBFE.SBFEDelinquentCountCard84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCard84, '-99');
																								SELF.SBFE.SBFEDelinquentCountCardEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountCardEver, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease, '-99');
																								SELF.SBFE.SBFEDelq61LeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease06, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease12, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease24, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease36, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease60, '-99');
																								SELF.SBFE.SBFEDelinquentCountLease84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLease84, '-99');
																								SELF.SBFE.SBFEDelinquentCountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLeaseEver, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter, '-99');
																								SELF.SBFE.SBFEDelq61LetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter06, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter12, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter24, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter36, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter60, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetter84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetter84, '-99');
																								SELF.SBFE.SBFEDelinquentCountLetterEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountLetterEver, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine, '-99');
																								SELF.SBFE.SBFEDelq61OELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine06, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine12, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine24, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine36, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine60, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLine84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLine84, '-99');
																								SELF.SBFE.SBFEDelinquentCountOLineEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOLineEver, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther, '-99');
																								SELF.SBFE.SBFEDelq61OtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherCount03M, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther06 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther06, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther12 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther12, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther24 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther24, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther36 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther36, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther60 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther60, '-99');
																								SELF.SBFE.SBFEDelinquentCountOther84 := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOther84, '-99');
																								SELF.SBFE.SBFEDelinquentCountOtherEver := checkBlank(RIGHT.SBFE.SBFEDelinquentCountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq61InstCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq61InstCountTtl, '-99');
																								SELF.SBFE.SBFEDelq61InstCountEver := checkBlank(RIGHT.SBFE.SBFEDelq61InstCountEver, '-99');
																								SELF.SBFE.SBFEDelq61InstCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq61InstCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq61RevCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq61RevCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq61RevCountEver := checkBlank(RIGHT.SBFE.SBFEDelq61RevCountEver, '-99');
																								SELF.SBFE.SBFEDelq61RevCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq61RevCountTtl, '-99');
																								SELF.SBFE.SBFEDelq61RevCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq61RevCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq91CountTtl := checkBlank(RIGHT.SBFE.SBFEDelq91CountTtl, '-99');
																								SELF.SBFE.SBFEDelq91CountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq91CountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDPD91Count := checkBlank(RIGHT.SBFE.SBFEDPD91Count, '-99');
																								SELF.SBFE.SBFEDelq91Count03M := checkBlank(RIGHT.SBFE.SBFEDelq91Count03M, '-99');
																								SELF.SBFE.SBFEDPD91Count06 := checkBlank(RIGHT.SBFE.SBFEDPD91Count06, '-99');
																								SELF.SBFE.SBFEDPD91Count12 := checkBlank(RIGHT.SBFE.SBFEDPD91Count12, '-99');
																								SELF.SBFE.SBFEDPD91Count24 := checkBlank(RIGHT.SBFE.SBFEDPD91Count24, '-99');
																								SELF.SBFE.SBFEDPD91Count36 := checkBlank(RIGHT.SBFE.SBFEDPD91Count36, '-99');
																								SELF.SBFE.SBFEDPD91Count60 := checkBlank(RIGHT.SBFE.SBFEDPD91Count60, '-99');
																								SELF.SBFE.SBFEDPD91Count84 := checkBlank(RIGHT.SBFE.SBFEDPD91Count84, '-99');
																								SELF.SBFE.SBFEDPD91CountEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountEver, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan, '-99');
																								SELF.SBFE.SBFEDelq91LoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan06, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan12, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan24, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan36, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan60, '-99');
																								SELF.SBFE.SBFEDPD91CountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoan84, '-99');
																								SELF.SBFE.SBFEDPD91CountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountLoanEver, '-99');
																								SELF.SBFE.SBFEDPD91CountLine := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine, '-99');
																								SELF.SBFE.SBFEDelq91LineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91LineCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine06, '-99');
																								SELF.SBFE.SBFEDPD91CountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine12, '-99');
																								SELF.SBFE.SBFEDPD91CountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine24, '-99');
																								SELF.SBFE.SBFEDPD91CountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine36, '-99');
																								SELF.SBFE.SBFEDPD91CountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine60, '-99');
																								SELF.SBFE.SBFEDPD91CountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLine84, '-99');
																								SELF.SBFE.SBFEDPD91CountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountLineEver, '-99');
																								SELF.SBFE.SBFEDPD91CountCard := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard, '-99');
																								SELF.SBFE.SBFEDelq91CardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91CardCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard06, '-99');
																								SELF.SBFE.SBFEDPD91CountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard12, '-99');
																								SELF.SBFE.SBFEDPD91CountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard24, '-99');
																								SELF.SBFE.SBFEDPD91CountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard36, '-99');
																								SELF.SBFE.SBFEDPD91CountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard60, '-99');
																								SELF.SBFE.SBFEDPD91CountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountCard84, '-99');
																								SELF.SBFE.SBFEDPD91CountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountCardEver, '-99');
																								SELF.SBFE.SBFEDPD91CountLease := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease, '-99');
																								SELF.SBFE.SBFEDelq91LeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease06, '-99');
																								SELF.SBFE.SBFEDPD91CountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease12, '-99');
																								SELF.SBFE.SBFEDPD91CountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease24, '-99');
																								SELF.SBFE.SBFEDPD91CountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease36, '-99');
																								SELF.SBFE.SBFEDPD91CountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease60, '-99');
																								SELF.SBFE.SBFEDPD91CountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLease84, '-99');
																								SELF.SBFE.SBFEDPD91CountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountLeaseEver, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter, '-99');
																								SELF.SBFE.SBFEDelq91LetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter06, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter12, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter24, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter36, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter60, '-99');
																								SELF.SBFE.SBFEDPD91CountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetter84, '-99');
																								SELF.SBFE.SBFEDPD91CountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountLetterEver, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine, '-99');
																								SELF.SBFE.SBFEDelq91OELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine06, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine12, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine24, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine36, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine60, '-99');
																								SELF.SBFE.SBFEDPD91CountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLine84, '-99');
																								SELF.SBFE.SBFEDPD91CountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountOLineEver, '-99');
																								SELF.SBFE.SBFEDPD91CountOther := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther, '-99');
																								SELF.SBFE.SBFEDelq91OtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD91CountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther06, '-99');
																								SELF.SBFE.SBFEDPD91CountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther12, '-99');
																								SELF.SBFE.SBFEDPD91CountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther24, '-99');
																								SELF.SBFE.SBFEDPD91CountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther36, '-99');
																								SELF.SBFE.SBFEDPD91CountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther60, '-99');
																								SELF.SBFE.SBFEDPD91CountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD91CountOther84, '-99');
																								SELF.SBFE.SBFEDPD91CountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD91CountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq91InstCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq91InstCountTtl, '-99');
																								SELF.SBFE.SBFEDelq91InstCountEver := checkBlank(RIGHT.SBFE.SBFEDelq91InstCountEver, '-99');
																								SELF.SBFE.SBFEDelq91InstCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq91InstCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq91RevCountEverTtl := checkBlank(RIGHT.SBFE.SBFEDelq91RevCountEverTtl, '-99');
																								SELF.SBFE.SBFEDelq91RevCountEver := checkBlank(RIGHT.SBFE.SBFEDelq91RevCountEver, '-99');
																								SELF.SBFE.SBFEDelq91RevCountTtl := checkBlank(RIGHT.SBFE.SBFEDelq91RevCountTtl, '-99');
																								SELF.SBFE.SBFEDelq91RevCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq91RevCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq121CountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq121CountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDPD121Count := checkBlank(RIGHT.SBFE.SBFEDPD121Count, '-99');
																								SELF.SBFE.SBFEDelq121Count03M := checkBlank(RIGHT.SBFE.SBFEDelq121Count03M, '-99');
																								SELF.SBFE.SBFEDPD121Count06 := checkBlank(RIGHT.SBFE.SBFEDPD121Count06, '-99');
																								SELF.SBFE.SBFEDPD121Count12 := checkBlank(RIGHT.SBFE.SBFEDPD121Count12, '-99');
																								SELF.SBFE.SBFEDPD121Count24 := checkBlank(RIGHT.SBFE.SBFEDPD121Count24, '-99');
																								SELF.SBFE.SBFEDPD121Count36 := checkBlank(RIGHT.SBFE.SBFEDPD121Count36, '-99');
																								SELF.SBFE.SBFEDPD121Count60 := checkBlank(RIGHT.SBFE.SBFEDPD121Count60, '-99');
																								SELF.SBFE.SBFEDPD121Count84 := checkBlank(RIGHT.SBFE.SBFEDPD121Count84, '-99');
																								SELF.SBFE.SBFEDPD121CountEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountEver, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan, '-99');
																								SELF.SBFE.SBFEDelq121LoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan06, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan12, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan24, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan36, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan60, '-99');
																								SELF.SBFE.SBFEDPD121CountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoan84, '-99');
																								SELF.SBFE.SBFEDPD121CountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountLoanEver, '-99');
																								SELF.SBFE.SBFEDPD121CountLine := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine, '-99');
																								SELF.SBFE.SBFEDelq121LineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121LineCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine06, '-99');
																								SELF.SBFE.SBFEDPD121CountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine12, '-99');
																								SELF.SBFE.SBFEDPD121CountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine24, '-99');
																								SELF.SBFE.SBFEDPD121CountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine36, '-99');
																								SELF.SBFE.SBFEDPD121CountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine60, '-99');
																								SELF.SBFE.SBFEDPD121CountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLine84, '-99');
																								SELF.SBFE.SBFEDPD121CountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountLineEver, '-99');
																								SELF.SBFE.SBFEDPD121CountCard := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard, '-99');
																								SELF.SBFE.SBFEDelq121CardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121CardCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard06, '-99');
																								SELF.SBFE.SBFEDPD121CountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard12, '-99');
																								SELF.SBFE.SBFEDPD121CountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard24, '-99');
																								SELF.SBFE.SBFEDPD121CountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard36, '-99');
																								SELF.SBFE.SBFEDPD121CountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard60, '-99');
																								SELF.SBFE.SBFEDPD121CountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountCard84, '-99');
																								SELF.SBFE.SBFEDPD121CountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountCardEver, '-99');
																								SELF.SBFE.SBFEDPD121CountLease := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease, '-99');
																								SELF.SBFE.SBFEDelq121LeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease06, '-99');
																								SELF.SBFE.SBFEDPD121CountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease12, '-99');
																								SELF.SBFE.SBFEDPD121CountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease24, '-99');
																								SELF.SBFE.SBFEDPD121CountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease36, '-99');
																								SELF.SBFE.SBFEDPD121CountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease60, '-99');
																								SELF.SBFE.SBFEDPD121CountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLease84, '-99');
																								SELF.SBFE.SBFEDPD121CountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountLeaseEver, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter, '-99');
																								SELF.SBFE.SBFEDelq121LetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter06, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter12, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter24, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter36, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter60, '-99');
																								SELF.SBFE.SBFEDPD121CountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetter84, '-99');
																								SELF.SBFE.SBFEDPD121CountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountLetterEver, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine, '-99');
																								SELF.SBFE.SBFEDelq121OELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine06, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine12, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine24, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine36, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine60, '-99');
																								SELF.SBFE.SBFEDPD121CountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLine84, '-99');
																								SELF.SBFE.SBFEDPD121CountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountOLineEver, '-99');
																								SELF.SBFE.SBFEDPD121CountOther := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther, '-99');
																								SELF.SBFE.SBFEDelq121OtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD121CountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther06, '-99');
																								SELF.SBFE.SBFEDPD121CountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther12, '-99');
																								SELF.SBFE.SBFEDPD121CountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther24, '-99');
																								SELF.SBFE.SBFEDPD121CountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther36, '-99');
																								SELF.SBFE.SBFEDPD121CountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther60, '-99');
																								SELF.SBFE.SBFEDPD121CountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD121CountOther84, '-99');
																								SELF.SBFE.SBFEDPD121CountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD121CountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq121InstCountEver := checkBlank(RIGHT.SBFE.SBFEDelq121InstCountEver, '-99');
																								SELF.SBFE.SBFEDelq121InstCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq121InstCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelq121RevCountEver := checkBlank(RIGHT.SBFE.SBFEDelq121RevCountEver, '-99');
																								SELF.SBFE.SBFEDelq121RevCountTtlChargeoff := checkBlank(RIGHT.SBFE.SBFEDelq121RevCountTtlChargeoff, '-99');
																								SELF.SBFE.SBFEDelinquent31Ratio := checkBlank(RIGHT.SBFE.SBFEDelinquent31Ratio, '-99');
																								SELF.SBFE.SBFEDelinquent31LoanRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31LoanRatio, '-99');
																								SELF.SBFE.SBFEDelinquent31LineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31LineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent31CardRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31CardRatio, '-99');
																								SELF.SBFE.SBFEDelinquent31LeaseRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31LeaseRatio, '-99');
																								SELF.SBFE.SBFEDelinquent31LetterRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31LetterRatio, '-99');
																								SELF.SBFE.SBFEDelinquent31OLineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31OLineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent31OtherRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent31OtherRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61Ratio := checkBlank(RIGHT.SBFE.SBFEDelinquent61Ratio, '-99');
																								SELF.SBFE.SBFEDelinquent61LoanRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61LoanRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61LineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61LineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61CardRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61CardRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61LeaseRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61LeaseRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61LetterRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61LetterRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61OLineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61OLineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent61OtherRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent61OtherRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91Ratio := checkBlank(RIGHT.SBFE.SBFEDelinquent91Ratio, '-99');
																								SELF.SBFE.SBFEDelinquent91LoanRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91LoanRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91LineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91LineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91CardRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91CardRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91LeaseRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91LeaseRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91LetterRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91LetterRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91OLineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91OLineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent91OtherRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent91OtherRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121Ratio := checkBlank(RIGHT.SBFE.SBFEDelinquent121Ratio, '-99');
																								SELF.SBFE.SBFEDelinquent121LoanRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121LoanRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121LineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121LineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121CardRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121CardRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121LeaseRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121LeaseRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121LetterRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121LetterRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121OLineRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121OLineRatio, '-99');
																								SELF.SBFE.SBFEDelinquent121OtherRatio := checkBlank(RIGHT.SBFE.SBFEDelinquent121OtherRatio, '-99');
																								SELF.SBFE.SBFEDelq1OccurCount03M := checkBlank(RIGHT.SBFE.SBFEDelq1OccurCount03M, '-99');
																								SELF.SBFE.SBFEDPD1OccurCount06 := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCount06, '-99');
																								SELF.SBFE.SBFEDPD1OccurCount12 := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCount12, '-99');
																								SELF.SBFE.SBFEDPD1OccurCount24 := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCount24, '-99');
																								SELF.SBFE.SBFEDPD1OccurCount36 := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCount36, '-99');
																								SELF.SBFE.SBFEDPD1OccurCount60 := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCount60, '-99');
																								SELF.SBFE.SBFEDPD1OccurCount84 := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCount84, '-99');
																								SELF.SBFE.SBFEDPD1OccurCountEver := checkBlank(RIGHT.SBFE.SBFEDPD1OccurCountEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCount06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCount06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCount12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCount12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCount24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCount24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCount36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCount36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCount60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCount60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCount84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCount84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurLoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurLoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoan06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoan12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoan24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoan36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoan60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoan84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLoanEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurLineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurLineCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLine06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLine12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLine24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLine36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLine60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLine84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLineEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurCardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurCardCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCard06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCard12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCard24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCard36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCard60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCard84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountCardEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurLeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurLeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLease06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLease12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLease24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLease36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLease60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLease84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLeaseEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurLetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurLetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetter06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetter12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetter24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetter36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetter60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetter84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountLetterEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurOELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurOELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLine06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLine12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLine24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLine36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLine60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLine84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOLineEver, '-99');
																								SELF.SBFE.SBFEDelq31OccurOtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq31OccurOtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOther06, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOther12, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOther24, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOther36, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOther60, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOther84, '-99');
																								SELF.SBFE.SBFEDPD31OccurCountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD31OccurCountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCount06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCount06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCount12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCount12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCount24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCount24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCount36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCount36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCount60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCount60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCount84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCount84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurLoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurLoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoan06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoan12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoan24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoan36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoan60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoan84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLoanEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurLineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurLineCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLine06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLine12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLine24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLine36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLine60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLine84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLineEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurCardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurCardCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCard06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCard12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCard24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCard36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCard60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCard84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountCardEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurLeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurLeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLease06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLease12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLease24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLease36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLease60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLease84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLeaseEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurLetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurLetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetter06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetter12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetter24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetter36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetter60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetter84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountLetterEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurOELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurOELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLine06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLine12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLine24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLine36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLine60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLine84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOLineEver, '-99');
																								SELF.SBFE.SBFEDelq61OccurOtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq61OccurOtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOther06, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOther12, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOther24, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOther36, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOther60, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOther84, '-99');
																								SELF.SBFE.SBFEDPD61OccurCountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD61OccurCountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCount06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCount06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCount12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCount12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCount24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCount24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCount36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCount36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCount60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCount60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCount84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCount84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurLoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurLoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoan06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoan12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoan24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoan36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoan60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoan84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLoanEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurLineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurLineCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLine06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLine12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLine24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLine36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLine60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLine84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLineEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurCardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurCardCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCard06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCard12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCard24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCard36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCard60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCard84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountCardEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurLeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurLeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLease06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLease12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLease24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLease36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLease60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLease84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLeaseEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurLetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurLetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetter06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetter12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetter24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetter36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetter60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetter84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountLetterEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurOELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurOELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLine06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLine12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLine24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLine36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLine60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLine84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOLineEver, '-99');
																								SELF.SBFE.SBFEDelq91OccurOtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq91OccurOtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOther06, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOther12, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOther24, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOther36, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOther60, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOther84, '-99');
																								SELF.SBFE.SBFEDPD91OccurCountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD91OccurCountOtherEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCount06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCount06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCount12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCount12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCount24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCount24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCount36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCount36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCount60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCount60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCount84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCount84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurLoanCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurLoanCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoan06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoan06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoan12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoan12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoan24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoan24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoan36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoan36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoan60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoan60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoan84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoan84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLoanEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLoanEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurLineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurLineCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLine06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLine06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLine12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLine12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLine24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLine24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLine36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLine36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLine60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLine60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLine84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLine84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLineEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLineEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurCardCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurCardCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCard06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCard06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCard12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCard12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCard24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCard24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCard36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCard36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCard60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCard60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCard84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCard84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountCardEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountCardEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurLeaseCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurLeaseCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLease06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLease06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLease12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLease12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLease24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLease24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLease36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLease36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLease60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLease60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLease84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLease84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLeaseEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLeaseEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurLetterCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurLetterCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetter06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetter06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetter12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetter12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetter24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetter24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetter36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetter36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetter60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetter60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetter84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetter84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountLetterEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountLetterEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurOELineCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurOELineCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLine06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLine06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLine12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLine12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLine24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLine24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLine36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLine36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLine60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLine60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLine84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLine84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOLineEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOLineEver, '-99');
																								SELF.SBFE.SBFEDelq121OccurOtherCount03M := checkBlank(RIGHT.SBFE.SBFEDelq121OccurOtherCount03M, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOther06 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOther06, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOther12 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOther12, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOther24 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOther24, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOther36 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOther36, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOther60 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOther60, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOther84 := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOther84, '-99');
																								SELF.SBFE.SBFEDPD121OccurCountOtherEver := checkBlank(RIGHT.SBFE.SBFEDPD121OccurCountOtherEver, '-99');
																								SELF.SBFE.SBFEDPDAmount := checkBlank(RIGHT.SBFE.SBFEDPDAmount, '-99');
																								SELF.SBFE.SBFEDPD01Amount := checkBlank(RIGHT.SBFE.SBFEDPD01Amount, '-99');
																								SELF.SBFE.SBFEDelq01AmtTtl := checkBlank(RIGHT.SBFE.SBFEDelq01AmtTtl, '-99');
																								SELF.SBFE.SBFEDelq01Amt03M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt03M, '-99');
																								SELF.SBFE.SBFEDelq01Amt06M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt06M, '-99');
																								SELF.SBFE.SBFEDelq01Amt12M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt12M, '-99');
																								SELF.SBFE.SBFEDelq01Amt24M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt24M, '-99');
																								SELF.SBFE.SBFEDelq01Amt36M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt36M, '-99');
																								SELF.SBFE.SBFEDelq01Amt60M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt60M, '-99');
																								SELF.SBFE.SBFEDelq01Amt84M := checkBlank(RIGHT.SBFE.SBFEDelq01Amt84M, '-99');
																								SELF.SBFE.SBFEDPD31Amount := checkBlank(RIGHT.SBFE.SBFEDPD31Amount, '-99');
																								SELF.SBFE.SBFEDelq31AmtTtl := checkBlank(RIGHT.SBFE.SBFEDelq31AmtTtl, '-99');
																								SELF.SBFE.SBFEDelq31Amt03M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt03M, '-99');
																								SELF.SBFE.SBFEDelq31Amt06M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt06M, '-99');
																								SELF.SBFE.SBFEDelq31Amt12M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt12M, '-99');
																								SELF.SBFE.SBFEDelq31Amt24M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt24M, '-99');
																								SELF.SBFE.SBFEDelq31Amt36M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt36M, '-99');
																								SELF.SBFE.SBFEDelq31Amt60M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt60M, '-99');
																								SELF.SBFE.SBFEDelq31Amt84M := checkBlank(RIGHT.SBFE.SBFEDelq31Amt84M, '-99');
																								SELF.SBFE.SBFEDPD61Amount := checkBlank(RIGHT.SBFE.SBFEDPD61Amount, '-99');
																								SELF.SBFE.SBFEDelq61AmtTtl := checkBlank(RIGHT.SBFE.SBFEDelq61AmtTtl, '-99');
																								SELF.SBFE.SBFEDelq61Amt03M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt03M, '-99');
																								SELF.SBFE.SBFEDelq61Amt06M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt06M, '-99');
																								SELF.SBFE.SBFEDelq61Amt12M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt12M, '-99');
																								SELF.SBFE.SBFEDelq61Amt24M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt24M, '-99');
																								SELF.SBFE.SBFEDelq61Amt36M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt36M, '-99');
																								SELF.SBFE.SBFEDelq61Amt60M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt60M, '-99');
																								SELF.SBFE.SBFEDelq61Amt84M := checkBlank(RIGHT.SBFE.SBFEDelq61Amt84M, '-99');
																								SELF.SBFE.SBFEDPD91Amount := checkBlank(RIGHT.SBFE.SBFEDPD91Amount, '-99');
																								SELF.SBFE.SBFEDelq91AmtTtl := checkBlank(RIGHT.SBFE.SBFEDelq91AmtTtl, '-99');
																								SELF.SBFE.SBFEDelq91Amt03M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt03M, '-99');
																								SELF.SBFE.SBFEDelq91Amt06M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt06M, '-99');
																								SELF.SBFE.SBFEDelq91Amt12M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt12M, '-99');
																								SELF.SBFE.SBFEDelq91Amt24M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt24M, '-99');
																								SELF.SBFE.SBFEDelq91Amt36M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt36M, '-99');
																								SELF.SBFE.SBFEDelq91Amt60M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt60M, '-99');
																								SELF.SBFE.SBFEDelq91Amt84M := checkBlank(RIGHT.SBFE.SBFEDelq91Amt84M, '-99');
																								SELF.SBFE.SBFEDPD121Amount := checkBlank(RIGHT.SBFE.SBFEDPD121Amount, '-99');
																								SELF.SBFE.SBFEDelq121Amt03M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt03M, '-99');
																								SELF.SBFE.SBFEDelq121Amt06M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt06M, '-99');
																								SELF.SBFE.SBFEDelq121Amt12M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt12M, '-99');
																								SELF.SBFE.SBFEDelq121Amt24M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt24M, '-99');
																								SELF.SBFE.SBFEDelq121Amt36M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt36M, '-99');
																								SELF.SBFE.SBFEDelq121Amt60M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt60M, '-99');
																								SELF.SBFE.SBFEDelq121Amt84M := checkBlank(RIGHT.SBFE.SBFEDelq121Amt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountLoan := checkBlank(RIGHT.SBFE.SBFEDPDAmountLoan, '-99');
																								SELF.SBFE.SBFEDPD01AmountLoan := checkBlank(RIGHT.SBFE.SBFEDPD01AmountLoan, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01LoanAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01LoanAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountLoan := checkBlank(RIGHT.SBFE.SBFEDPD31AmountLoan, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31LoanAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31LoanAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountLoan := checkBlank(RIGHT.SBFE.SBFEDPD61AmountLoan, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61LoanAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61LoanAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountLoan := checkBlank(RIGHT.SBFE.SBFEDPD91AmountLoan, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91LoanAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91LoanAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountLoan := checkBlank(RIGHT.SBFE.SBFEDPD121AmountLoan, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121LoanAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121LoanAmt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountLine := checkBlank(RIGHT.SBFE.SBFEDPDAmountLine, '-99');
																								SELF.SBFE.SBFEDPD01AmountLine := checkBlank(RIGHT.SBFE.SBFEDPD01AmountLine, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01LineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01LineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountLine := checkBlank(RIGHT.SBFE.SBFEDPD31AmountLine, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31LineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31LineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountLine := checkBlank(RIGHT.SBFE.SBFEDPD61AmountLine, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61LineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61LineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountLine := checkBlank(RIGHT.SBFE.SBFEDPD91AmountLine, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91LineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91LineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountLine := checkBlank(RIGHT.SBFE.SBFEDPD121AmountLine, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121LineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121LineAmt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountCard := checkBlank(RIGHT.SBFE.SBFEDPDAmountCard, '-99');
																								SELF.SBFE.SBFEDPD01AmountCard := checkBlank(RIGHT.SBFE.SBFEDPD01AmountCard, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01CardAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01CardAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountCard := checkBlank(RIGHT.SBFE.SBFEDPD31AmountCard, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31CardAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31CardAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountCard := checkBlank(RIGHT.SBFE.SBFEDPD61AmountCard, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61CardAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61CardAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountCard := checkBlank(RIGHT.SBFE.SBFEDPD91AmountCard, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91CardAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91CardAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountCard := checkBlank(RIGHT.SBFE.SBFEDPD121AmountCard, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121CardAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121CardAmt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountLease := checkBlank(RIGHT.SBFE.SBFEDPDAmountLease, '-99');
																								SELF.SBFE.SBFEDPD01AmountLease := checkBlank(RIGHT.SBFE.SBFEDPD01AmountLease, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01LeaseAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01LeaseAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountLease := checkBlank(RIGHT.SBFE.SBFEDPD31AmountLease, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31LeaseAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31LeaseAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountLease := checkBlank(RIGHT.SBFE.SBFEDPD61AmountLease, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61LeaseAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61LeaseAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountLease := checkBlank(RIGHT.SBFE.SBFEDPD91AmountLease, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91LeaseAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91LeaseAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountLease := checkBlank(RIGHT.SBFE.SBFEDPD121AmountLease, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121LeaseAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121LeaseAmt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountLetter := checkBlank(RIGHT.SBFE.SBFEDPDAmountLetter, '-99');
																								SELF.SBFE.SBFEDPD01AmountLetter := checkBlank(RIGHT.SBFE.SBFEDPD01AmountLetter, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01LetterAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01LetterAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountLetter := checkBlank(RIGHT.SBFE.SBFEDPD31AmountLetter, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31LetterAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31LetterAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountLetter := checkBlank(RIGHT.SBFE.SBFEDPD61AmountLetter, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61LetterAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61LetterAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountLetter := checkBlank(RIGHT.SBFE.SBFEDPD91AmountLetter, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91LetterAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91LetterAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountLetter := checkBlank(RIGHT.SBFE.SBFEDPD121AmountLetter, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121LetterAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121LetterAmt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountOLine := checkBlank(RIGHT.SBFE.SBFEDPDAmountOLine, '-99');
																								SELF.SBFE.SBFEDPD01AmountOLine := checkBlank(RIGHT.SBFE.SBFEDPD01AmountOLine, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01OELineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01OELineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountOLine := checkBlank(RIGHT.SBFE.SBFEDPD31AmountOLine, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31OELineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31OELineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountOLine := checkBlank(RIGHT.SBFE.SBFEDPD61AmountOLine, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61OELineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61OELineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountOLine := checkBlank(RIGHT.SBFE.SBFEDPD91AmountOLine, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91OELineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91OELineAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountOLine := checkBlank(RIGHT.SBFE.SBFEDPD121AmountOLine, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121OELineAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121OELineAmt84M, '-99');
																								SELF.SBFE.SBFEDPDAmountOther := checkBlank(RIGHT.SBFE.SBFEDPDAmountOther, '-99');
																								SELF.SBFE.SBFEDPD01AmountOther := checkBlank(RIGHT.SBFE.SBFEDPD01AmountOther, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt03M, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt06M, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt12M, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt24M, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt36M, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt60M, '-99');
																								SELF.SBFE.SBFEDelq01OtherAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq01OtherAmt84M, '-99');
																								SELF.SBFE.SBFEDPD31AmountOther := checkBlank(RIGHT.SBFE.SBFEDPD31AmountOther, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt03M, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt06M, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt12M, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt24M, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt36M, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt60M, '-99');
																								SELF.SBFE.SBFEDelq31OtherAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq31OtherAmt84M, '-99');
																								SELF.SBFE.SBFEDPD61AmountOther := checkBlank(RIGHT.SBFE.SBFEDPD61AmountOther, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt03M, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt06M, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt12M, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt24M, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt36M, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt60M, '-99');
																								SELF.SBFE.SBFEDelq61OtherAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq61OtherAmt84M, '-99');
																								SELF.SBFE.SBFEDPD91AmountOther := checkBlank(RIGHT.SBFE.SBFEDPD91AmountOther, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt03M, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt06M, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt12M, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt24M, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt36M, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt60M, '-99');
																								SELF.SBFE.SBFEDelq91OtherAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq91OtherAmt84M, '-99');
																								SELF.SBFE.SBFEDPD121AmountOther := checkBlank(RIGHT.SBFE.SBFEDPD121AmountOther, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt03M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt03M, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt06M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt06M, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt12M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt12M, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt24M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt24M, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt36M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt36M, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt60M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt60M, '-99');
																								SELF.SBFE.SBFEDelq121OtherAmt84M := checkBlank(RIGHT.SBFE.SBFEDelq121OtherAmt84M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct03M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct03M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct06M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct06M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct12M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct12M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct24M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct24M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct36M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct36M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct60M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct60M, '-99');
																								SELF.SBFE.SBFEDelq1AmtPct84M := checkBlank(RIGHT.SBFE.SBFEDelq1AmtPct84M, '-99');
																								SELF.SBFE.SBFEDelq1RevAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq1RevAmtPct, '-99');
																								SELF.SBFE.SBFEDelq1InstAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq1InstAmtPct, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct03M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct03M, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct06M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct06M, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct12M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct12M, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct24M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct24M, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct36M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct36M, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct60M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct60M, '-99');
																								SELF.SBFE.SBFEDelq31AmtPct84M := checkBlank(RIGHT.SBFE.SBFEDelq31AmtPct84M, '-99');
																								SELF.SBFE.SBFEDelq31RevAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq31RevAmtPct, '-99');
																								SELF.SBFE.SBFEDelq31InstAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq31InstAmtPct, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct03M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct03M, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct06M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct06M, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct12M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct12M, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct24M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct24M, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct36M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct36M, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct60M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct60M, '-99');
																								SELF.SBFE.SBFEDelq61AmtPct84M := checkBlank(RIGHT.SBFE.SBFEDelq61AmtPct84M, '-99');
																								SELF.SBFE.SBFEDelq61RevAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq61RevAmtPct, '-99');
																								SELF.SBFE.SBFEDelq61InstAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq61InstAmtPct, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct03M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct03M, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct06M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct06M, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct12M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct12M, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct24M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct24M, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct36M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct36M, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct60M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct60M, '-99');
																								SELF.SBFE.SBFEDelq91AmtPct84M := checkBlank(RIGHT.SBFE.SBFEDelq91AmtPct84M, '-99');
																								SELF.SBFE.SBFEDelq91RevAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq91RevAmtPct, '-99');
																								SELF.SBFE.SBFEDelq91InstAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq91InstAmtPct, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct03M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct03M, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct06M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct06M, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct12M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct12M, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct24M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct24M, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct36M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct36M, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct60M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct60M, '-99');
																								SELF.SBFE.SBFEDelq121AmtPct84M := checkBlank(RIGHT.SBFE.SBFEDelq121AmtPct84M, '-99');
																								SELF.SBFE.SBFEDelq121RevAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq121RevAmtPct, '-99');
																								SELF.SBFE.SBFEDelq121InstAmtPct := checkBlank(RIGHT.SBFE.SBFEDelq121InstAmtPct, '-99');
																								SELF.SBFE.SBFEDelqAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDPDAveAmount06 := checkBlank(RIGHT.SBFE.SBFEDPDAveAmount06, '-99');
																								SELF.SBFE.SBFEDPDAveAmount12 := checkBlank(RIGHT.SBFE.SBFEDPDAveAmount12, '-99');
																								SELF.SBFE.SBFEDPDAveAmount24 := checkBlank(RIGHT.SBFE.SBFEDPDAveAmount24, '-99');
																								SELF.SBFE.SBFEDPDAveAmount36 := checkBlank(RIGHT.SBFE.SBFEDPDAveAmount36, '-99');
																								SELF.SBFE.SBFEDPDAveAmount60 := checkBlank(RIGHT.SBFE.SBFEDPDAveAmount60, '-99');
																								SELF.SBFE.SBFEDPDAveAmount84 := checkBlank(RIGHT.SBFE.SBFEDPDAveAmount84, '-99');
																								SELF.SBFE.SBFEDPDAveAmountEver := checkBlank(RIGHT.SBFE.SBFEDPDAveAmountEver, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqLoanAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqLoanAvgAmtEver, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqLineAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqLineAvgAmtEver, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqCardAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqCardAvgAmtEver, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqLeaseAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqLeaseAvgAmtEver, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqLetterAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqLetterAvgAmtEver, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqOELineAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqOELineAvgAmtEver, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt03M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt03M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt06M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt06M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt12M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt12M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt24M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt24M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt36M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt36M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt60M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt60M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmt84M := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmt84M, '-99');
																								SELF.SBFE.SBFEDelqOtherAvgAmtEver := checkBlank(RIGHT.SBFE.SBFEDelqOtherAvgAmtEver, '-99');
																								SELF.SBFE.SBFEChargeoffCount := checkBlank(RIGHT.SBFE.SBFEChargeoffCount, '-99');
																								SELF.SBFE.SBFEChargeoffLoanCount := checkBlank(RIGHT.SBFE.SBFEChargeoffLoanCount, '-99');
																								SELF.SBFE.SBFEChargeoffLineCount := checkBlank(RIGHT.SBFE.SBFEChargeoffLineCount, '-99');
																								SELF.SBFE.SBFEChargeoffCardCount := checkBlank(RIGHT.SBFE.SBFEChargeoffCardCount, '-99');
																								SELF.SBFE.SBFEChargeoffLeaseCount := checkBlank(RIGHT.SBFE.SBFEChargeoffLeaseCount, '-99');
																								SELF.SBFE.SBFEChargeoffLetterCount := checkBlank(RIGHT.SBFE.SBFEChargeoffLetterCount, '-99');
																								SELF.SBFE.SBFEChargeoffOLineCount := checkBlank(RIGHT.SBFE.SBFEChargeoffOLineCount, '-99');
																								SELF.SBFE.SBFEChargeoffOtherCount := checkBlank(RIGHT.SBFE.SBFEChargeoffOtherCount, '-99');
																								SELF.SBFE.SBFEChargeoffAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffAmount, '-99');
																								SELF.SBFE.SBFEChargeoffLoanAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffLoanAmount, '-99');
																								SELF.SBFE.SBFEChargeoffLineAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffLineAmount, '-99');
																								SELF.SBFE.SBFEChargeoffCardAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffCardAmount, '-99');
																								SELF.SBFE.SBFEChargeoffLeaseAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffLeaseAmount, '-99');
																								SELF.SBFE.SBFEChargeoffLetterAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffLetterAmount, '-99');
																								SELF.SBFE.SBFEChargeoffOLineAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffOLineAmount, '-99');
																								SELF.SBFE.SBFEChargeoffOtherAmount := checkBlank(RIGHT.SBFE.SBFEChargeoffOtherAmount, '-99');
																								SELF.SBFE.SBFEChargeoffDateLastSeen := checkBlank(RIGHT.SBFE.SBFEChargeoffDateLastSeen, '-99');
																								SELF.SBFE.SBFETimeNewestChargeoff := checkBlank(RIGHT.SBFE.SBFETimeNewestChargeoff,'-99');
																								SELF.SBFE.SBFEBalloonCount := checkBlank(RIGHT.SBFE.SBFEBalloonCount, '-99');
																								SELF.SBFE.SBFEBalloonPaymentAmount := checkBlank(RIGHT.SBFE.SBFEBalloonPaymentAmount, '-99');
																								SELF.SBFE.SBFEBalloonPaymentDueDate := checkBlank(RIGHT.SBFE.SBFEBalloonPaymentDueDate, '-99');
																								SELF.SBFE.SBFEFirmBusStructure := checkBlank(RIGHT.SBFE.SBFEFirmBusStructure, '-99');
																								SELF.SBFE.SBFESICCode := checkBlank(RIGHT.SBFE.SBFESICCode, '-99');
																								SELF.SBFE.SBFENAICSCode := checkBlank(RIGHT.SBFE.SBFENAICSCode, '-99');
																								SELF.SBFE.SBFEGovGuaranteeCount := checkBlank(RIGHT.SBFE.SBFEGovGuaranteeCount, '-99');
																								SELF.SBFE.SBFEGuarantorAccountCount := checkBlank(RIGHT.SBFE.SBFEGuarantorAccountCount, '-99');
																								SELF.SBFE.SBFEGuarantorMinCount := checkBlank(RIGHT.SBFE.SBFEGuarantorMinCount, '-99');
																								SELF.SBFE.SBFEGuarantorMaxCount := checkBlank(RIGHT.SBFE.SBFEGuarantorMaxCount, '-99');
																								SELF.SBFE.SBFEPrincipalAccountCount := checkBlank(RIGHT.SBFE.SBFEPrincipalAccountCount, '-99');
																								SELF.SBFE.SBFEPrincipalMinCount := checkBlank(RIGHT.SBFE.SBFEPrincipalMinCount, '-99');
																								SELF.SBFE.SBFEPrincipalMaxCount := checkBlank(RIGHT.SBFE.SBFEPrincipalMaxCount, '-99');							
																								SELF.SBFE.SBFEINTERNALObservedPerf06 := checkBlank(RIGHT.SBFE.SBFEINTERNALObservedPerf06, '-99');
																								SELF.SBFE.SBFEINTERNALObservedPerf12 := checkBlank(RIGHT.SBFE.SBFEINTERNALObservedPerf12, '-99');
																								SELF.SBFE.SBFEINTERNALObservedPerf18 := checkBlank(RIGHT.SBFE.SBFEINTERNALObservedPerf18, '-99');
																								SELF.SBFE.SBFEINTERNALObservedPerf24 := checkBlank(RIGHT.SBFE.SBFEINTERNALObservedPerf24, '-99');
																								SELF.SBFE.SBFEINTERNALObservedPerf36 := checkBlank(RIGHT.SBFE.SBFEINTERNALObservedPerf36, '-99');
																								SELF.Data_Fetch_Indicators.FetchCodeSBFE := checkBlank(RIGHT.Data_Fetch_Indicators.FetchCodeSBFE, '0');
																								
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
 
	// Call Targus Gateway for each input record that has a legit Business Phone, no records
	// found among our inhouse phone sources, and no Targus restriction for the customer.
	targusGatewayPrep_pre_pre := 
		JOIN(
			LinkIDsFound, withSBFE,
			LEFT.seq = RIGHT.seq AND
			COUNT(RIGHT.PhoneSources) > 0,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell, SELF := LEFT, SELF := [] ),
			LEFT ONLY
		);
		
	targusGatewayPrep_pre := IF( Options.RunTargusGatewayAnywayForTesting, LinkIDsFound, targusGatewayPrep_pre_pre );

	targusGatewayPrep := targusGatewayPrep_pre(Input.InputCheckBusPhone = '1');
	
	targusGateway := Business_Risk_BIP.getTargusGateway(targusGatewayPrep, Options, linkingOptions, AllowedSourcesSet);

	withTargusGateway := JOIN(withSBFE, targusGateway, LEFT.Seq = Right.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Input_Characteristics.InputPhoneEntityCount := (STRING)MAX((INTEGER)LEFT.Input_Characteristics.InputPhoneEntityCount, (INTEGER)RIGHT.InputPhoneEntityCount),
																								SELF.Input_Characteristics.InputPhoneMobile := (STRING)MAX((INTEGER)LEFT.Input_Characteristics.InputPhoneMobile, (INTEGER)RIGHT.InputPhoneMobile),
																								SELF.Verification.PhoneDisconnected := 
																										IF(
																												LEFT.seq = RIGHT.seq,
																												(STRING)MIN((INTEGER)LEFT.Verification.PhoneDisconnected, (INTEGER)RIGHT.PhoneDisconnected),
																												LEFT.Verification.PhoneDisconnected
																										),
																								SELF.Verification.BNAP := (STRING)MAX((INTEGER)LEFT.Verification.BNAP, (INTEGER)RIGHT.BNAP), // Keep the MAX of the Business Header, Gong, and Phones Plus BNAP
																								SELF.Verification.PhoneMatch := (STRING)MAX((INTEGER)LEFT.Verification.PhoneMatch, (INTEGER)RIGHT.PhoneMatch),
																								SELF.Sources := LEFT.Sources + RIGHT.PhoneSources,
																								SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources,
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																						
	 BestAddrPhones := Business_Risk_BIP.getBestAddrPhones(withTargusGateway, Options, linkingOptions, AllowedSourcesSet);

	 withBestAddrPhones := JOIN(withTargusGateway, BestAddrPhones, LEFT.Seq = Right.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								SELF.Best_Info.BestPhoneService := checkBlank(RIGHT.Best_Info.BestPhoneService, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
																								SELF := LEFT),
																						LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);	
																						
	// Now that everything is back together, combine the sources into their delimited list fields, and calculate source based attributes	
	Business_Risk_BIP.Layouts.LayoutSources rollSource(Business_Risk_BIP.Layouts.LayoutSources le, Business_Risk_BIP.Layouts.LayoutSources ri) := TRANSFORM
		SELF.Source := IF(StringLib.StringFind(le.Source, ',', 1) > 0, '\'' + le.Source + '\'', le.Source); // Because this is a comma delimited list - if a source contains a comma, put quotes around it
		MinDate := MAP((INTEGER)le.DateFirstSeen > 0 AND (INTEGER)ri.DateFirstSeen > 0		=> MIN((INTEGER)le.DateFirstSeen, (INTEGER)ri.DateFirstSeen),
									 (INTEGER)le.DateFirstSeen <= 0 AND (INTEGER)ri.DateFirstSeen > 0	=> (INTEGER)ri.DateFirstSeen,
																																														 (INTEGER)le.DateFirstSeen);
		SELF.DateFirstSeen := IF(MinDate <= 0, Business_Risk_BIP.Constants.MissingDate, (STRING)MinDate);
		
		MinVendorDate := MAP((INTEGER)le.DateVendorFirstSeen > 0 AND (INTEGER)ri.DateVendorFirstSeen > 0		=> MIN((INTEGER)le.DateVendorFirstSeen, (INTEGER)ri.DateVendorFirstSeen),
									 (INTEGER)le.DateVendorFirstSeen <= 0 AND (INTEGER)ri.DateVendorFirstSeen > 0	=> (INTEGER)ri.DateVendorFirstSeen,
																																														 (INTEGER)le.DateVendorFirstSeen);
		SELF.DateVendorFirstSeen := IF(MinVendorDate <= 0, Business_Risk_BIP.Constants.MissingDate, (STRING)MinVendorDate);				
		
		MaxDate := MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen);
		SELF.DateLastSeen := IF(MaxDate <= 0, Business_Risk_BIP.Constants.MissingDate, (STRING)MaxDate);
		
		MaxVendorDate := MAX((INTEGER)le.DateVendorLastSeen, (INTEGER)ri.DateVendorLastSeen);
		SELF.DateVendorLastSeen := IF(MaxVendorDate <= 0, Business_Risk_BIP.Constants.MissingDate, (STRING)MaxVendorDate);
		
		SELF.RecordCount := le.RecordCount + ri.RecordCount;
		
		SELF := le;
	END;
	Business_Risk_BIP.Layouts.LayoutSICNAIC rollSICNAICSource(Business_Risk_BIP.Layouts.LayoutSICNAIC le, Business_Risk_BIP.Layouts.LayoutSICNAIC ri) := TRANSFORM
		SELF.Source := IF(StringLib.StringFind(le.Source, ',', 1) > 0, '\'' + le.Source + '\'', le.Source); // Because this is a comma delimited list - if a source contains a comma, put quotes around it
		MinDate := MAP((INTEGER)le.DateFirstSeen > 0 AND (INTEGER)ri.DateFirstSeen > 0		=> MIN((INTEGER)le.DateFirstSeen, (INTEGER)ri.DateFirstSeen),
									 (INTEGER)le.DateFirstSeen <= 0 AND (INTEGER)ri.DateFirstSeen > 0	=> (INTEGER)ri.DateFirstSeen,
																																														 (INTEGER)le.DateFirstSeen);
		SELF.DateFirstSeen := IF(MinDate <= 0, Business_Risk_BIP.Constants.MissingDate, (STRING)MinDate);
		MaxDate := MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen);
		SELF.DateLastSeen := IF(MaxDate <= 0, Business_Risk_BIP.Constants.MissingDate, (STRING)MaxDate);
		SELF.RecordCount := le.RecordCount + ri.RecordCount;
		
		SELF := le;
	END;
	
	Business_Risk_BIP.Layouts.Shell finalizeDelimitedFields(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		// Get the header build date as a reference point for any date calculations
		BHBuildDate := Risk_Indicators.get_Build_date('bheader_build_version');
		TodaysDate := Business_Risk_BIP.Common.todaysDate(BHBuildDate, le.Clean_Input.HistoryDate);

		
		// Group sources based on what the modelers would like to see
		GroupedSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.Sources);
		GroupedNameSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.NameSources);
		GroupedAddressVerSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.AddressVerSources);
		GroupedAddressSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.AddressSources);
		GroupedBestAddressSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.BestAddressSources);
    // Starting in v30, phone sources should be a subset of phoneID sources, so add in the Gong results (PhoneIDSources) when found searching by BIP ID  in v30 and up.
		GroupedPhoneSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.PhoneSources + 
                                            IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, le.PhoneIDSources));
		GroupedFEINSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.FEINSources);
		GroupedEmployeeSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, le.EmployeeSources);
		GroupedSICNAICSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSICNAIC, le.SICNAICSources);
		
		// Get this Seq's unique Sources/Dates
		UniqueSources := ROLLUP(SORT(GroupedSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueNameSources := ROLLUP(SORT(GroupedNameSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueAddressVerSources := ROLLUP(SORT(GroupedAddressVerSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueAddressSources := ROLLUP(SORT(GroupedAddressSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueBestAddressSources := ROLLUP(SORT(GroupedBestAddressSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniquePhoneSources := ROLLUP(SORT(GroupedPhoneSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueFEINSources := ROLLUP(SORT(GroupedFEINSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		UniqueEmployeeSources := ROLLUP(SORT(GroupedEmployeeSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		
		// Now sort the sources by the order we want them to appear in our delimited fields, most recent to oldest
		SeqSources := SORT(UniqueSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		SeqNameSources := SORT(UniqueNameSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		SeqAddressVerSources := SORT(UniqueAddressVerSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		SeqAddressSources := SORT(UniqueAddressSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		SeqBestAddressSources := SORT(UniqueBestAddressSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		SeqPhoneSources := SORT(UniquePhoneSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		SeqFEINSources := SORT(UniqueFEINSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
    // Filter out sources that didn't have Employee count available. In verison 3.0, we differentiate between none available (-1) and 0, but in earlier versions these are all 0s.
		SeqEmployeeSources := SORT(UniqueEmployeeSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount) (IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, RecordCount > -1, RecordCount > 0)); 

		gong_src := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v22, MDR.sourceTools.set_Gong_History, MDR.sourceTools.set_Gong_Business);
		
		sourcesFiltered := le.Sources(source NOT IN [gong_src, MDR.sourceTools.set_Phones_Plus]);
		LinkIdSources := sourcesFiltered + le.LinkIdSources;
		GroupedSourcesLinkIds := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, LinkIdSources);
		UniqueSourcesLinkIds := ROLLUP(SORT(GroupedSourcesLinkIds, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		SeqSourcesLinkIds := SORT(UniqueSourcesLinkIds, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);
		
		// SELF.Verification.VerInputIDTruebiz := checkVersion(IF(COUNT(SeqSourcesLinkIds) > 0, '1', '0'), Business_Risk_BIP.Constants.BusShellVersion_v22);
		VerInputIDTruebiz := calculateValueFor._VerInputIDTruebiz(SeqSourcesLinkIds);
		SELF.Verification.VerInputIDTruebiz := VerInputIDTruebiz;
		
		SICSources := ROLLUP(SORT((GroupedSICNAICSources ((INTEGER)SICCode > 0 AND Source <> '')), Source, ((INTEGER)SICCode), -IsPrimary, -DateLastSeen, -DateFirstSeen, -RecordCount), LEFT.Source = RIGHT.Source AND LEFT.SICCode = RIGHT.SICCode, rollSICNAICSource(LEFT, RIGHT));
		NAICSources := ROLLUP(SORT((GroupedSICNAICSources ((INTEGER)NAICCode > 0 AND Source <> '')), Source, ((INTEGER)NAICCode), -IsPrimary, -DateLastSeen, -DateFirstSeen, -RecordCount), LEFT.Source = RIGHT.Source AND LEFT.SICCode = RIGHT.SICCode, rollSICNAICSource(LEFT, RIGHT));

		DerogSourceRecords := SeqSources (Source IN Business_Risk_BIP.Constants.Set_Derog);
		NonDerogSourceRecords := SeqSources (Source IN Business_Risk_BIP.Constants.Set_NonDerog);
		
		DerogSourceRecords12Month := DerogSourceRecords ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.OneYear);
		DerogSourceRecords06Month := DerogSourceRecords12Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
		DerogSourceRecords03Month := DerogSourceRecords06Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
		
		NonDerogSourceRecords60Month := NonDerogSourceRecords ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(5));
		NonDerogSourceRecords36Month := NonDerogSourceRecords60Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(3));
		NonDerogSourceRecords24Month := NonDerogSourceRecords36Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(2));
		NonDerogSourceRecords12Month := NonDerogSourceRecords24Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(1));
		NonDerogSourceRecords06Month := NonDerogSourceRecords12Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
		NonDerogSourceRecords03Month := NonDerogSourceRecords06Month ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
		
		SELF.Sources := SeqSources;
		// Convert to a delimited list
		SELF.Verification.SourceList := Business_Risk_BIP.Common.convertDelimited(SeqSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.SourceDateFirstSeenList := Business_Risk_BIP.Common.convertDelimited(SeqSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);
    SELF.Verification.SourceDateFirstSeenListV := calculateValueFor._SourceDateFirstSeenListV(SeqSources);
		SELF.Verification.SourceDateLastSeenList := Business_Risk_BIP.Common.convertDelimited(SeqSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.SourceDateLastSeenListV := calculateValueFor._SourceDateLastSeenListV(SeqSources);

		SELF.Verification.SourceCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqSources), -1, 99);
		SELF.Verification.NameMatchSourceList := Business_Risk_BIP.Common.convertDelimited(SeqNameSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.NameMatchDateFirstSeenList := Business_Risk_BIP.Common.convertDelimited(SeqNameSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.NameMatchSourceFSList := calculateValueFor._NameMatchSourceFSList(SeqNameSources);
		SELF.Verification.NameMatchDateLastSeenList := Business_Risk_BIP.Common.convertDelimited(SeqNameSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.NameMatchSourceLSList := calculateValueFor._NameMatchSourceLSList(SeqNameSources);

		SELF.Verification.NameMatchSourceCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqNameSources), -1, 99);
                          
    cantVerifyAddress := FALSE;  // don't check the individual parts anymore, part of RQ-14786
                          
		SELF.Verification.AddrVerificationSourceList := IF(cantVerifyAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqAddressVerSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.Verification.AddrVerificationSourceCount := IF(cantVerifyAddress, '-1', (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqAddressVerSources), -1, 99));
		SELF.Verification.AddrVerificationDateFirstSeenList := IF(cantVerifyAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqAddressVerSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.Input_Characteristics.InputAddrConsumerCount := IF(le.Input.InputCheckBusAddrZip = '0' AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1', le.Input_Characteristics.InputAddrConsumerCount);
		
		SELF.Verification.AddrMatchSourceFSList := calculateValueFor._AddrMatchSourceFSList(cantVerifyAddress, SeqAddressVerSources);
		SELF.Verification.AddrVerificationDateLastSeenList := IF(cantVerifyAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqAddressVerSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.Verification.AddrMatchSourceLSList := calculateValueFor._AddrMatchSourceLSList(cantVerifyAddress, SeqAddressVerSources);

		newestAddrDate := calculateValueFor._newestAddrDate(SeqAddressVerSources, le.Clean_Input.HistoryDate);
		oldestAddrDate := calculateValueFor._oldestAddrDate(SeqAddressVerSources, le.Clean_Input.HistoryDate);
		
		InputAddrLengthOfResidence := IF(NOT cantVerifyAddress AND newestAddrDate <> Business_Risk_BIP.Constants.MissingDate AND oldestAddrDate <> Business_Risk_BIP.Constants.MissingDate, (STRING)Business_Risk_BIP.Common.CapNum(ut.MonthsApart(newestAddrDate, oldestAddrDate), -1, 99999), '-1');
		SELF.Verification.InputAddrLengthOfResidence := calculateValueFor.checkTrueBiz(InputAddrLengthOfResidence, VerInputIDTruebiz);

		SELF.Input_Characteristics.InputAddrSourceCount := IF(cantVerifyAddress, '-1', (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqAddressVerSources), -1, 10));
		SELF.Verification.AddrSourceCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqAddressSources), -1, 10);
		SELF.Verification.PhoneMatchSourceList := Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.PhoneMatchDateFirstSeenList := Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.PhoneMatchSourceDateFSList := calculateValueFor._PhoneMatchSourceDateFSList(SeqPhoneSources);
		SELF.Verification.PhoneMatchDateLastSeenList := Business_Risk_BIP.Common.convertDelimited(SeqPhoneSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.PhoneMatchSourceDateLSList := calculateValueFor._PhoneMatchSourceDateLSList(SeqPhoneSources);
		SELF.Verification.PhoneMatchDateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqPhoneSources, 1, DateFirstSeen)[1].DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate);
		SELF.Verification.PhoneMatchDateLastSeen := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqPhoneSources, 1, -DateLastSeen)[1].DateLastSeen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate);
		SELF.Verification.PhoneMatchSourceCount := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND le.Input.InputCheckBusPhone = '0', '-1',
                                                  (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqPhoneSources), -1, 99));
		
    SELF.Verification.FEINMatchSourceList := Business_Risk_BIP.Common.convertDelimited(SeqFEINSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.FEINMatchDateFirstSeenList := Business_Risk_BIP.Common.convertDelimited(SeqFEINSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.FEINMatchSourceDateFSList := calculateValueFor._FEINMatchSourceDateFSList(SeqFEINSources);
		SELF.Verification.FEINMatchDateLastSeenList := Business_Risk_BIP.Common.convertDelimited(SeqFEINSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.FEINMatchSourceDateLSList := calculateValueFor._FEINMatchSourceDateLSList(SeqFEINSources);
		SELF.Verification.FEINMatchSourceCount := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND le.Input.InputCheckBusFEIN = '0', '-1',
                                                (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqFEINSources), -1, 99));

		NoBestAddress := IF(TRIM(le.Best_Info.BestPrimRange) = '' OR // If best address wasn't populated we can't verify it
												TRIM(le.Best_Info.BestCompanyZip) = '',
													TRUE, FALSE);
													
		BestSourceCount := IF(NoBestAddress, '-1', (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqBestAddressSources), -1, 99));
		BestSourceCount_TrueBiz := calculateValueFor.checkTrueBiz(BestSourceCount, VerInputIDTruebiz);
		SELF.Best_Info.BestSourceCount := BestSourceCount_TrueBiz;		
    SELF.Best_Info.BestSourceList := IF(NoBestAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqBestAddressSources, Source, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.Best_Info.BestSourceFirstSeenList := IF(NoBestAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqBestAddressSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter));
		SELF.Best_Info.BestSourceLastSeenList := IF(NoBestAddress, '', Business_Risk_BIP.Common.convertDelimited(SeqBestAddressSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter));

		newestBestAddrDate := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqBestAddressSources, 1, -DateLastSeen)[1].DateLastSeen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate);
		oldestBestAddrDate := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqBestAddressSources, 1, DateFirstSeen)[1].DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate);
		BestLengthResidency := IF(NOT cantVerifyAddress AND newestBestAddrDate <> Business_Risk_BIP.Constants.MissingDate AND oldestBestAddrDate <> Business_Risk_BIP.Constants.MissingDate, (STRING)Business_Risk_BIP.Common.CapNum(ut.MonthsApart(newestBestAddrDate, oldestBestAddrDate), -1, 99999), '-1');
		SELF.Best_Info.BestLengthResidency := calculateValueFor.checkBestAddr(BestLengthResidency, BestSourceCount_TrueBiz);

		SELF.Firmographic.FirmEmployeeCountSourceList := Business_Risk_BIP.Common.convertDelimited(SeqEmployeeSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.FirmEmployeeCountDateFirstSeenList := Business_Risk_BIP.Common.convertDelimited(SeqEmployeeSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.FirmEmployeeCountDateLastSeenList := Business_Risk_BIP.Common.convertDelimited(SeqEmployeeSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.FirmEmployeeCountList := Business_Risk_BIP.Common.convertDelimited(SeqEmployeeSources, RecordCount, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustrySourceNAICBestList := Business_Risk_BIP.Common.convertDelimited(NAICSources (IsPrimary = TRUE), Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustryNAICBestList := Business_Risk_BIP.Common.convertDelimited(NAICSources (IsPrimary = TRUE), NAICCode, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustrySourceNAICCompleteList := Business_Risk_BIP.Common.convertDelimited(NAICSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustryNAICCompleteList := Business_Risk_BIP.Common.convertDelimited(NAICSources, NAICCode, Business_Risk_BIP.Constants.FieldDelimiter);
		IndustryNAICRecent := TOPN(NAICSources, 1, -DateLastSeen)[1].NAICCode;
		SELF.Firmographic.IndustryNAICRecent := calculateValueFor._IndustryNAICRecent(IndustryNAICRecent);
    SELF.Firmographic.IndustrySICSourceBestList := Business_Risk_BIP.Common.convertDelimited(SICSources (IsPrimary = TRUE), Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustrySICBestList := Business_Risk_BIP.Common.convertDelimited(SICSources (IsPrimary = TRUE), SICCode, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustrySourceSICCompleteList := Business_Risk_BIP.Common.convertDelimited(SICSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Firmographic.IndustrySICCompleteList := Business_Risk_BIP.Common.convertDelimited(SICSources, SICCode, Business_Risk_BIP.Constants.FieldDelimiter);
		IndustrySICRecent := TOPN(SICSources, 1, -DateLastSeen)[1].SICCode;
		SELF.Firmographic.IndustrySICRecent := calculateValueFor._IndustrySICRecent(IndustrySICRecent);
    SELF.Firmographic.FirmReportedSales := calculateValueFor._FirmReportedSales(le.Firmographic.FirmReportedSales);
		SELF.Firmographic.FirmReportedSalesRange := checkVersion(IF(le.Firmographic.FirmReportedSales = '-1', le.Firmographic.FirmReportedSales, (STRING)Business_Risk_BIP.Common.getSalesRangeIndex((INTEGER)le.Firmographic.FirmReportedSales)), Business_Risk_BIP.Constants.BusShellVersion_v30);
    FirmAgeEstablished := calculateValueFor._FirmAgeEstablished(le.Firmographic.FirmAgeEstablished);
    SELF.Firmographic.FirmAgeEstablished := calculateValueFor.checkTrueBiz(FirmAgeEstablished, VerInputIDTruebiz);
    // Grab the oldest first seen date and newest last seen date across all sources
		// Set 0's to all 9's to ensure MIN works properly
		MinDateFirstSeen := (STRING)MIN(PROJECT(SeqSources, TRANSFORM(RECORDOF(LEFT), SELF.DateFirstSeen := IF((INTEGER)LEFT.DateFirstSeen <= 0, Business_Risk_BIP.Constants.NinesDate, LEFT.DateFirstSeen))), (INTEGER)DateFirstSeen);
		DateFirstSeen := IF(MinDateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_Bip.Constants.MissingDate, MinDateFirstSeen);
		SELF.Verification.DateFirstSeen := DateFirstSeen;
		MaxDateLastSeen := (STRING)MAX(SeqSources, (INTEGER)DateLastSeen);
		SELF.Verification.DateLastSeen := MaxDateLastSeen;
		// Per the requirements we actually don't want 0 month calculations, instead bump those up to 1 month thus the cap is from 1 to 99999
		BRTimeNewest := (STRING)IF((INTEGER)MaxDateLastSeen > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)MaxDateLastSeen, (STRING)TodaysDate), 1, 99999), -1);
		BRTimeOldest := (STRING)IF((INTEGER)DateFirstSeen > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)DateFirstSeen, (STRING)TodaysDate), 1, 99999), -1);
		SELF.Business_Activity.BusinessRecordTimeNewest := IF((INTEGER)BRTimeNewest > 0 AND (INTEGER)BRTimeOldest > 0, (STRING)MIN((INTEGER)BRTimeNewest, (INTEGER)BRTimeOldest), BRTimeNewest);
		SELF.Business_Activity.BusinessRecordTimeOldest := (STRING)MAX((INTEGER)BRTimeNewest, (INTEGER)BRTimeOldest);
		MonthsMostRecentOnFile := (STRING)IF((INTEGER)MaxDateLastSeen > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)MaxDateLastSeen, (STRING)TodaysDate), 1, 99999), -1);
		SELF.Verification.SourceMostRecentTimeonFile := MonthsMostRecentOnFile;
		SELF.Business_Activity.BusinessRecordUpdated12Month := IF((INTEGER)MaxDateLastSeen > 0, Business_Risk_BIP.Common.SetBoolean((INTEGER)MonthsMostRecentOnFile BETWEEN 1 AND 12), '-1');
		
		BureauMinDateFirstSeen := (STRING)MIN(PROJECT(SeqSources (Source IN Business_Risk_BIP.Constants.Set_Bureau), TRANSFORM(RECORDOF(LEFT), SELF.DateFirstSeen := IF((INTEGER)LEFT.DateFirstSeen <= 0, Business_Risk_BIP.Constants.NinesDate, LEFT.DateFirstSeen))), (INTEGER)DateFirstSeen);
		BureauDateFirstSeen := IF(BureauMinDateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_Bip.Constants.MissingDate, BureauMinDateFirstSeen);
		BureauMaxDateLastSeen := (STRING)MAX(SeqSources (Source IN Business_Risk_BIP.Constants.Set_Bureau), (INTEGER)DateLastSeen);
		TrTimeNewest := (STRING)IF((INTEGER)BureauMaxDateLastSeen > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)BureauMaxDateLastSeen, (STRING)TodaysDate), 1, 99999), -1);
		TrTimeOldest := (STRING)IF((INTEGER)BureauDateFirstSeen > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)BureauDateFirstSeen, (STRING)TodaysDate), 1, 99999), -1);
		SELF.Tradeline.TradeTimeNewest := IF((INTEGER)TrTimeNewest > 0 AND (INTEGER)TrTimeOldest > 0, (STRING)MIN((INTEGER)TrTimeNewest, (INTEGER)TrTimeOldest), TrTimeNewest);
		SELF.Tradeline.TradeTimeOldest := (STRING)MAX((INTEGER)TrTimeNewest, (INTEGER)TrTimeOldest);

		// Now check to see if any of our sources contain sources for the following fields
		SELF.Verification.SourceFBN := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source = Business_Risk_BIP.Constants.Src_FBN)));
		SELF.Verification.SourceBureau := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source IN Business_Risk_BIP.Constants.Set_Bureau)));
		SELF.Verification.SourceUCC := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source IN Business_Risk_BIP.Constants.Set_UCC)));
		SELF.Verification.SourceBBBMember := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source = Business_Risk_BIP.Constants.Src_BBB_Member)));
		SELF.Verification.SourceBBBNonMember := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source = Business_Risk_BIP.Constants.Src_BBB_Non_Member)));
		SELF.Verification.SourceBBB := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source IN [Business_Risk_BIP.Constants.Src_BBB_Member, Business_Risk_BIP.Constants.Src_BBB_Non_Member])));
		SELF.Firmographic.FirmNonProfit := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source = Business_Risk_BIP.Constants.Src_IRS_Non_Profit)));
		SELF.Verification.SourceOSHA := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source = Business_Risk_BIP.Constants.Src_OSHA)));
		SELF.Verification.SourceBankruptcy := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source IN Business_Risk_BIP.Constants.Set_Bankruptcy)));
		SELF.Verification.SourceProperty := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source IN Business_Risk_BIP.Constants.Set_Property)));
		SELF.Verification.SourceUtility := Business_Risk_BIP.Common.SetBoolean(ut.Exists2(SeqSources (Source = Business_Risk_BIP.Constants.Src_Utility_sources)));
		// Make sure the full match is set to true if both the first and last name were found on the consumer header (In case they were found on separate records)
		SELF.Verification.BusAddrConsumerFullName := IF(le.Verification.BusAddrConsumerFirstName= '1' AND le.Verification.BusAddrConsumerLastName = '1', '1', le.Verification.BusAddrConsumerFullName);
		// If the input wasn't populated, blank out these attributes
		correctedAddrVerification := IF(le.Input.InputCheckBusAddr = '0' OR // If any element of address wasn't populated we can't verify it
																		le.Input.InputCheckBusCity = '0' OR
																		le.Input.InputCheckBusState = '0' OR
																		le.Input.InputCheckBusZip = '0', '-1', le.Verification.AddrVerification);
		SELF.Verification.AddrVerification :=  correctedAddrVerification;
		correctedVerificationBusInputPhoneAddr := IF(correctedAddrVerification = '-1' AND le.Input.InputCheckBusPhone = '1', '-1', le.Verification.VerificationBusInputPhoneAddr); // If we override the AddrVerification to a -1 above check if we need to override VerificationBusInputPhoneAddr check as well
		VerificationBusInputPhoneAddr := IF(le.Input.InputCheckBusPhone = '0', '-1', correctedVerificationBusInputPhoneAddr);
		SELF.Verification.VerificationBusInputPhoneAddr := calculateValueFor.checkTrueBiz(VerificationBusInputPhoneAddr, VerInputIDTruebiz);
    
		// Ensure we don't have any weird corner cases
		SELF.Verification.NameMatch := IF(ut.Exists2(SeqNameSources), le.Verification.NameMatch, Business_Risk_BIP.Common.SetBoolean(FALSE)); // Only return a name match if we kept a source confirming name match
		SELF.Verification.NameMatchCount := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(SeqNameSources), -1, 99999);
		SELF.Verification.PhoneMatch := IF(ut.Exists2(SeqPhoneSources), le.Verification.PhoneMatch, Business_Risk_BIP.Common.SetBoolean(FALSE)); // Only return a phone match if we kept a source confirming phone match
		SELF.Verification.PhoneMatchCount := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(SeqPhoneSources), -1, 99999);
		// --------------------- Start BVI Calculation ------------------------
		// Grab our three calculated verification indexes
		BNAT_Indicator := le.Verification.BNAT;
		BNAP_Indicator := le.Verification.BNAP;
		BNAS_Indicator := le.Verification.BNAS;
		MultiSrcAddr := COUNT(SeqAddressVerSources) > 1; // More than 1 source verified address across all time
		MultiSrcAddrCurr := COUNT(SeqAddressVerSources (ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(1))) > 1; // More than 1 source verified address within the past year of the header build date
		MultiSrcCmpy := COUNT(SeqNameSources) > 1; // More than 1 source verified company name across all time
		MultiSrcCmpyCurr := COUNT(SeqNameSources (ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(1))) > 1; // More than 1 source verified company name within the past year of the header build date
		WatchlistHitFound := ut.Exists2(le.WatchlistHits); // We have a hit on the watchlist(s)
		DeceasedFEINAsSSN := le.DeceasedFEIN_As_SSN;
		// Requires that all elements verify within the same header record
		SELF.Verification.BVIIndicator := Business_Risk_BIP.calculateBVI_V1(BNAT_Indicator, BNAP_Indicator, BNAS_Indicator, 
																													MultiSrcAddr, MultiSrcAddrCurr, MultiSrcCmpy, MultiSrcCmpyCurr, 
																													WatchlistHitFound, DeceasedFEINAsSSN);
		
		// Looks at all header records to verify elements in cases where individual header records have partial information
		BNAT2_Indicator := le.Verification.BNAT2;
		BNAP2_Indicator := le.Verification.BNAP2;
		BNAS2_Indicator := le.Verification.BNAS2;
		SELF.Verification.BVIIndicator2 := Business_Risk_BIP.calculateBVI_V1(BNAT2_Indicator, BNAP2_Indicator, BNAS2_Indicator, 
																													MultiSrcAddr, MultiSrcAddrCurr, MultiSrcCmpy, MultiSrcCmpyCurr, 
																													WatchlistHitFound, DeceasedFEINAsSSN);

		// --------------------- End BVI Calculation ------------------------
		
		SELF.Verification.VerificationBusInputPhone := MAP(le.Input.InputCheckBusPhone = '0' 																													 => '-1', 
																											 BNAP2_Indicator IN ['7', '8'] AND COUNT(SeqPhoneSources) > 0																 => '2',
																											 COUNT(SeqPhoneSources) > 0																																	 => '1',
																																																																											'0');
																																							
		SELF.Verification.VerificationBusInputAddr := MAP(cantVerifyAddress																										=> '-1',
																											BNAT2_Indicator IN ['4', '6', '7', '8']															=> '2',
																											COUNT(SeqAddressVerSources) > 0 OR correctedAddrVerification = '1'	=> '1',
																																																														 '0');
		
		SELF.Verification.VerificationBusInputName := MAP(le.Input.InputCheckBusName = '0'																										=> '-1',
																											BNAT2_Indicator IN ['5', '6', '7', '8'] OR BNAP2_Indicator IN ['5', '6', '7', '8']	=> '1',
																																																																						 '0');
																																																																						 
		FEINVerificationNotPopulatedCorrection := IF(le.Input.InputCheckBusFEIN = '0', '-1', le.Verification.FEINVerification);
		VerificationBusInputFEIN := MAP(le.Input.InputCheckBusFEIN = '0'											=> '-1',
																		FEINVerificationNotPopulatedCorrection IN ['3', '4']	=> '2',
																		FEINVerificationNotPopulatedCorrection IN ['1', '2']	=> '1',
																																															'0');																				 
		SELF.Verification.VerificationBusInputFEIN := VerificationBusInputFEIN;
		SELF.Verification.FEINVerification := IF(VerificationBusInputFEIN <> '0', FEINVerificationNotPopulatedCorrection, '0'); // Return a 0 if we calculated a VerificationBusInputFEIN of 0
		
		// Since the BIP link IDs are populated in this transform, make sure the counts are at least 1 in case we didn't get a hit on the Business Header
		SELF.Organizational_Structure.UltIDOrgIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.UltIDOrgIDTreeCount);
		SELF.Organizational_Structure.OrgLegalEntityCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.OrgLegalEntityCount);
		SELF.Organizational_Structure.OrgAddrLegalEntityCount := calculateValueFor._OrgAddrLegalEntityCount(le.Organizational_Structure.OrgAddrLegalEntityCount);
		SELF.Organizational_Structure.UltIDProxIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.UltIDProxIDTreeCount);
		SELF.Organizational_Structure.UltIDPowIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.UltIDPowIDTreeCount);
		SELF.Organizational_Structure.OrgRelatedCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.OrgRelatedCount);
		SELF.Organizational_Structure.OrgIDProxIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.OrgIDProxIDTreeCount);
		SELF.Organizational_Structure.OrgIDPowIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.OrgIDPowIDTreeCount);
		SELF.Organizational_Structure.OrgLocationCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.OrgLocationCount);
		SELF.Organizational_Structure.SeleIDPowIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.SeleIDPowIDTreeCount);
		SELF.Organizational_Structure.ProxIDPowIDTreeCount := (STRING)MAX(1, (INTEGER)le.Organizational_Structure.ProxIDPowIDTreeCount);
		
		FirmEmployeeCount_v22 := IF(ut.Exists2(SeqEmployeeSources), le.Firmographic.FirmEmployeeCount, '-1');
		FirmEmployeeCount_v30 := IF(ut.Exists2(SeqEmployeeSources), (STRING)Business_Risk_BIP.Common.capNum(SORT(SeqEmployeeSources (RecordCount > -1), -(Source = 'DF'), -(Source = 'RR'), -(Source = 'BR'), -(Source = 'IA'), -(Source = 'IC'), -DateLastSeen, -DateFirstSeen, -RecordCount)[1].RecordCount, -1, 999999), '-1');
		SELF.Firmographic.FirmEmployeeCount := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, FirmEmployeeCount_v30, FirmEmployeeCount_v22);
		SELF.Firmographic.FirmEmployeeRangeCount := checkVersion((STRING)Business_Risk_BIP.Common.getEmployeeRangeIndex((INTEGER)FirmEmployeeCount_v30), Business_Risk_BIP.Constants.BusShellVersion_v30);
		FirmEmployeeCountSmallest := (STRING)Business_Risk_BIP.Common.capNum(IF(ut.Exists2(SeqEmployeeSources), MIN(SeqEmployeeSources, RecordCount), -1), -1, 999999);
		SELF.Firmographic.FirmEmployeeCountSmallest := FirmEmployeeCountSmallest;
		SELF.Firmographic.FirmEmployeeRangeCountSmallest := checkVersion((STRING)Business_Risk_BIP.Common.getEmployeeRangeIndex((INTEGER)FirmEmployeeCountSmallest), Business_Risk_BIP.Constants.BusShellVersion_v30);
		FirmEmployeeCountLargest := (STRING)Business_Risk_BIP.Common.capNum(IF(ut.Exists2(SeqEmployeeSources), MAX(SeqEmployeeSources, RecordCount), -1), -1, 999999);
		SELF.Firmographic.FirmEmployeeCountLargest := FirmEmployeeCountLargest;
		SELF.Firmographic.FirmEmployeeRangeCountlargest := checkVersion((STRING)Business_Risk_BIP.Common.getEmployeeRangeIndex((INTEGER)FirmEmployeeCountLargest), Business_Risk_BIP.Constants.BusShellVersion_v30);
		FirmEmployeeCountMostRecent := (STRING)Business_Risk_BIP.Common.capNum(IF(ut.Exists2(SeqEmployeeSources), SORT(SeqEmployeeSources, -DateLastSeen, -DateFirstSeen, -RecordCount, -Source)[1].RecordCount, -1), -1, 999999);
		SELF.Firmographic.FirmEmployeeCountMostRecent := FirmEmployeeCountMostRecent;
		SELF.Firmographic.FirmEmployeeRangeCountMostRecent := checkVersion((STRING)Business_Risk_BIP.Common.getEmployeeRangeIndex((INTEGER)FirmEmployeeCountMostRecent), Business_Risk_BIP.Constants.BusShellVersion_v30);

		SELF.Firmographic.BusObservedAge := IF(DateFirstSeen = Business_Risk_BIP.Constants.MissingDate, 
		     '-1', 
		     (STRING)Business_Risk_BIP.Common.capNum(ROUNDUP(ut.DaysApart(DateFirstSeen, Business_Risk_BIP.Common.todaysDate((STRING8)Std.Date.Today(), le.Clean_Input.HistoryDate)) / 365.25), -1, 110)
		);
		
		// To choose the best SIC/NAIC we are going with a waterfall source selection - the first source in this list is the SIC/NAIC we choose.  Adding dates/record counts to ensure we don't have some sort of magical indeterminate code..
		// DCA (DF), Experian EBR (ER), YellowPages (Y), OSHAIR (OS), BusReg (BR), FBN (FH), CalBus (C#), DNBDMI (DN)
		BestSIC := SORT((SICSources (IsPrimary = TRUE)), -(Source = 'DF'), -(Source = 'ER'), -(Source = 'Y'), -(Source = 'OS'), -(Source = 'BR'), -(Source = 'FH'), -(Source = 'C#'), -(Source = 'DN'), -DateLastSeen, -DateFirstSeen, -RecordCount)[1];
		BestNAIC := SORT((NAICSources (IsPrimary = TRUE)), -(Source = 'DF'), -(Source = 'ER'), -(Source = 'Y'), -(Source = 'OS'), -(Source = 'BR'), -(Source = 'FH'), -(Source = 'C#'), -(Source = 'DN'), -DateLastSeen, -DateFirstSeen, -RecordCount)[1];
		SICSet := SET(SICSources, SICCode);
		SICIndustrySet := SET(SICSources, SICIndustryGroup);
		NAICSet := SET(NAICSources, NAICCode);
		NAICIndustrySet := SET(NAICSources, NAICIndustryGroup);
		SELF.Firmographic.FirmSICCode := IF(BestSIC.SICCode = '', '-1', BestSIC.SICCode);
		SELF.Firmographic.FirmNAICSCode := IF(BestNAIC.NAICCode = '', '-1', BestNAIC.NAICCode);
		inputSICPopulated := (INTEGER)le.Clean_Input.SIC > 0;
		inputNAICPopulated := (INTEGER)le.Clean_Input.NAIC > 0;
		SELF.Verification.VerificationBusInputIndustry := MAP(inputSICPopulated = FALSE AND inputNAICPopulated = FALSE																														=> '-1', // SIC and NAIC not populated on input
																						(inputSICPopulated = TRUE AND le.Clean_Input.SIC IN SICSet) OR 																																	 // SIC populated and found on file
																						(inputNAICPopulated = TRUE AND le.Clean_Input.NAIC IN NAICSet)																													=> '2',  // NAIC populated and found on file
																						(inputSICPopulated = TRUE AND Business_Risk_BIP.Common.industryGroup(le.Clean_Input.SIC, Business_Risk_BIP.Constants.SIC) IN SICIndustrySet) OR						 // SIC Populated and the industry group matches
																						(inputNAICPopulated = TRUE AND Business_Risk_BIP.Common.industryGroup(le.Clean_Input.NAIC, Business_Risk_BIP.Constants.NAIC) IN NAICIndustrySet)	=> '1',	 // NAIC populated and the industry group matches
																																																																																			 '0'); // Neither SIC or NAIC matched what we found, or we found nothing
																						
		// Make sure these return values can't contradict each other due to flaws in the data
		BankruptcyCount := IF((INTEGER)le.Bankruptcy.BankruptcyChapter > 0, (STRING)MAX((INTEGER)le.Bankruptcy.BankruptcyCount, 1), le.Bankruptcy.BankruptcyCount); // If we have a bankruptcy chapter, make sure the bankruptcy count is at least 1
		SELF.Bankruptcy.BankruptcyCount := calculateValueFor.checkTrueBiz(le.Bankruptcy.BankruptcyCount, VerInputIDTruebiz);

		boundedPropertyCount := IF((INTEGER)le.Asset_Information.AssetPropertyAssessedTotal > 0, (STRING)MAX((INTEGER)le.Asset_Information.AssetPropertyCount, 1), le.Asset_Information.AssetPropertyCount); // Make sure we have a property count of at least 1 if we have assessed values
		SELF.Asset_Information.AssetPropertyCount := calculateValueFor.checkTrueBiz(boundedPropertyCount, VerInputIDTruebiz);
		AssetPropertyAssessedTotal := calculateValueFor._AssetPropertyAssessedTotal(boundedPropertyCount, le.Asset_Information.AssetPropertyAssessedTotal);
		SELF.Asset_Information.AssetPropertyAssessedTotal := calculateValueFor.checkTrueBiz(AssetPropertyAssessedTotal, VerInputIDTruebiz);
		SELF.Asset_Information.PropertyAssessedValueList := IF((INTEGER)boundedPropertyCount > 0, le.Asset_Information.PropertyAssessedValueList, ''); // Return a blank list if there are no properties to count
		SELF.Asset_Information.AssetPropertyStateCount := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetPropertyStateCount, VerInputIDTruebiz);
		SELF.Asset_Information.AssetPropertyLotSizeTotal := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetPropertyLotSizeTotal, VerInputIDTruebiz);
		SELF.Asset_Information.AssetPropertySqFootageTotal := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetPropertySqFootageTotal, VerInputIDTruebiz);
		AssetAircraftCount := IF(COUNT(SeqSources (Source = Business_Risk_BIP.Constants.Src_Aircrafts)) > 0, (STRING)MAX((INTEGER)le.Asset_Information.AssetAircraftCount, 1), le.Asset_Information.AssetAircraftCount);
		SELF.Asset_Information.AssetAircraftCount := calculateValueFor.checkTrueBiz(AssetAircraftCount, VerInputIDTruebiz);
		AssetWatercraftCount := IF(COUNT(SeqSources (Source = Business_Risk_BIP.Constants.Src_Watercraft)) > 0, (STRING)MAX((INTEGER)le.Asset_Information.AssetWatercraftCount, 1), le.Asset_Information.AssetWatercraftCount);
		SELF.Asset_Information.AssetWatercraftCount := calculateValueFor.checkTrueBiz(AssetWatercraftCount, VerInputIDTruebiz);

		boundedCurrentPropertyCount := IF((INTEGER)le.Asset_Information.AssetCurrentPropertyAssessedTotal > 0, (STRING)MAX((INTEGER)le.Asset_Information.AssetCurrentPropertyCount, 1), le.Asset_Information.AssetCurrentPropertyCount); // Make sure we have a property count of at least 1 if we have assessed values
		SELF.Asset_Information.AssetCurrentPropertyCount := calculateValueFor.checkTrueBiz(boundedCurrentPropertyCount, VerInputIDTruebiz);
		AssetCurrentPropertyAssessedTotal := IF((INTEGER)boundedCurrentPropertyCount > 0, le.Asset_Information.AssetCurrentPropertyAssessedTotal, '0'); // Return -1 for the assessed total if there are no properties to count
		SELF.Asset_Information.AssetCurrentPropertyAssessedTotal := calculateValueFor.checkTrueBiz(AssetCurrentPropertyAssessedTotal, VerInputIDTruebiz);
		SELF.Asset_Information.AssetCurrentPropertyStateCount := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetCurrentPropertyStateCount, VerInputIDTruebiz);
		SELF.Asset_Information.AssetCurrentPropertyLotSizeTotal := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetCurrentPropertyLotSizeTotal, VerInputIDTruebiz);
		SELF.Asset_Information.AssetCurrentPropertySqFootageTotal := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetCurrentPropertySqFootageTotal, VerInputIDTruebiz);

    SELF.Asset_Information.AssetVehicleCount := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetVehicleCount, VerInputIDTruebiz);
    SELF.Asset_Information.AssetPersonalVehicleCount := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetPersonalVehicleCount, VerInputIDTruebiz);
    SELF.Asset_Information.AssetCommercialVehicleCount := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetCommercialVehicleCount, VerInputIDTruebiz);
    SELF.Asset_Information.AssetOtherVehicleCount := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetOtherVehicleCount, VerInputIDTruebiz);
    SELF.Asset_Information.AssetTotalVehicleValue := calculateValueFor.checkTrueBiz(le.Asset_Information.AssetTotalVehicleValue, VerInputIDTruebiz);
    
		// Make sure we can't have more property overlap than properties owned
		BusExecLinkPropertyOverlapCount := IF(le.Input.InputCheckAuthRepFirstName = '0' OR le.Input.InputCheckAuthRepLastName = '0', '-1', (STRING)MIN((INTEGER)le.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount, (INTEGER)le.Asset_Information.AssetPropertyCount));
		SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount := calculateValueFor.checkTrueBiz(BusExecLinkPropertyOverlapCount, VerInputIDTruebiz);		
		BusExecLinkPropertyOverlapCount2 := IF(le.Input.InputCheckAuthRep2FirstName = '0' OR le.Input.InputCheckAuthRep2LastName = '0', '-1', (STRING)MIN((INTEGER)le.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount2, (INTEGER)le.Asset_Information.AssetPropertyCount));
		SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount2 := calculateValueFor.checkTrueBiz(BusExecLinkPropertyOverlapCount2, VerInputIDTruebiz);
		BusExecLinkPropertyOverlapCount3 := IF(le.Input.InputCheckAuthRep3FirstName = '0' OR le.Input.InputCheckAuthRep3LastName = '0', '-1', (STRING)MIN((INTEGER)le.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount3, (INTEGER)le.Asset_Information.AssetPropertyCount));
		SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount3 := calculateValueFor.checkTrueBiz(BusExecLinkPropertyOverlapCount3, VerInputIDTruebiz);
		BusExecLinkPropertyOverlapCount4 := IF(le.Input.InputCheckAuthRep4FirstName = '0' OR le.Input.InputCheckAuthRep4LastName = '0', '-1', (STRING)MIN((INTEGER)le.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount4, (INTEGER)le.Asset_Information.AssetPropertyCount));
		SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount4 := calculateValueFor.checkTrueBiz(BusExecLinkPropertyOverlapCount4, VerInputIDTruebiz);
		BusExecLinkPropertyOverlapCount5 := IF(le.Input.InputCheckAuthRep5FirstName = '0' OR le.Input.InputCheckAuthRep4LastName = '0', '-1', (STRING)MIN((INTEGER)le.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount5, (INTEGER)le.Asset_Information.AssetPropertyCount));
		SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount5 := calculateValueFor.checkTrueBiz(BusExecLinkPropertyOverlapCount5, VerInputIDTruebiz);

		//rep1
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile := IF(le.Input.InputCheckAuthRepFirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile, VerInputIDTruebiz);		
		BusExecLinkBusNameAuthRepFirst := IF(le.Input.InputCheckAuthRepFirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRepFirst, VerInputIDTruebiz);
		BusExecLinkBusNameAuthRepLast := IF(le.Input.InputCheckAuthRepLastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRepLast, VerInputIDTruebiz);
		BusExecLinkBusNameAuthRepFull := IF(le.Input.InputCheckAuthRepFirstName = '0' OR le.Input.InputCheckAuthRepLastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRepFull, VerInputIDTruebiz);		
		BusExecLinkAuthRepPhoneBusPhone := IF(le.Input.InputCheckAuthRepPhone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepPhoneBusPhone, VerInputIDTruebiz);
		BusExecLinkAuthRepAddrBusAddr := IF(le.Input.InputCheckAuthRepAddr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepAddrBusAddr, VerInputIDTruebiz);
		
		BusExecLinkAuthRepNameOnFile  := IF(le.Input.InputCheckAuthRepFirstName = '0' AND le.Input.InputCheckAuthRepLastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepNameOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRepAddrOnFile := IF(le.Input.InputCheckAuthRepAddr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepAddrOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRepPhoneOnFile  := IF(le.Input.InputCheckAuthRepPhone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepPhoneOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRepSSNOnFile  := IF(le.Input.InputCheckAuthRepSSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepSSNOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRepSSNBusFEIN  := IF(le.Input.InputCheckAuthRepSSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN := calculateValueFor.checkTrueBiz(BusExecLinkAuthRepSSNBusFEIN, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1AddrBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1AddrBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1PhoneBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1SSNBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1PhoneBusHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1SSNBusHeader, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BRep1AddrAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1AddrAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1PhoneAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1PhoneAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep1SSNAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep1SSNAssociateCHeader, VerInputIDTruebiz);
		AR2BBusPAWRep1 := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND (TRIM(le.Clean_Input.Rep_FirstName) = '' AND TRIM(le.Clean_Input.Rep_LastName) = ''), '-1', le.Business_To_Executive_Link.AR2BBusPAWRep1);
    SELF.Business_To_Executive_Link.AR2BBusPAWRep1 := calculateValueFor.checkTrueBiz(AR2BBusPAWRep1, VerInputIDTruebiz);

		BusExecLinkBusAddrAuthRepOwned := IF((INTEGER)le.Clean_Input.Rep_LexID <= 0, '-1', le.Business_To_Executive_Link.BusExecLinkBusAddrAuthRepOwned);
		SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRepOwned := calculateValueFor.checkTrueBiz(BusExecLinkBusAddrAuthRepOwned, VerInputIDTruebiz);
		BusExecLinkUtilityOverlapCount := IF(le.Input.InputCheckAuthRepFirstName = '0' OR le.Input.InputCheckAuthRepLastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount);
		SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount := calculateValueFor.checkTrueBiz(BusExecLinkUtilityOverlapCount, VerInputIDTruebiz);
		BusExecLinkInquiryOverlapCount := IF(le.Input.InputCheckAuthRepFirstName = '0' OR le.Input.InputCheckAuthRepLastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount);		
		SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount := calculateValueFor.checkTrueBiz(BusExecLinkInquiryOverlapCount, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BBusRep1AddrDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep1AddrDistance, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BBusRep1PhoneDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep1PhoneDistance, VerInputIDTruebiz);
		//rep2
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile, VerInputIDTruebiz);		
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile := IF(le.Input.InputCheckAuthRep2FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile);
		BusExecLinkBusNameAuthRep2First := IF(le.Input.InputCheckAuthRep2FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep2First, VerInputIDTruebiz);		
		BusExecLinkBusNameAuthRep2Last := IF(le.Input.InputCheckAuthRep2LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep2Last, VerInputIDTruebiz);		
		BusExecLinkBusNameAuthRep2Full := IF(le.Input.InputCheckAuthRep2FirstName = '0' OR le.Input.InputCheckAuthRep2LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep2Full, VerInputIDTruebiz);		
		BusExecLinkAuthRep2PhoneBusPhone := IF(le.Input.InputCheckAuthRep2Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2PhoneBusPhone, VerInputIDTruebiz);
		BusExecLinkAuthRep2AddrBusAddr := IF(le.Input.InputCheckAuthRep2Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2AddrBusAddr, VerInputIDTruebiz);
		BusExecLinkAuthRep2NameOnFile  := IF(le.Input.InputCheckAuthRep2FirstName = '0' AND le.Input.InputCheckAuthRep2LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2NameOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep2AddrOnFile := IF(le.Input.InputCheckAuthRep2Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2AddrOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep2PhoneOnFile  := IF(le.Input.InputCheckAuthRep2Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2PhoneOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep2SSNOnFile  := IF(le.Input.InputCheckAuthRep2SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2SSNOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep2SSNBusFEIN  := IF(le.Input.InputCheckAuthRep2SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep2SSNBusFEIN, VerInputIDTruebiz);		
		SELF.Business_To_Executive_Link.AR2BRep2NameBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2NameBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2AddrBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2AddrBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2PhoneBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2SSNBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2PhoneBusHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2SSNBusHeader, VerInputIDTruebiz);
		AR2BBusPAWRep2 := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND (TRIM(le.Clean_Input.Rep2_FirstName) = '' AND TRIM(le.Clean_Input.Rep2_LastName) = ''), '-1', le.Business_To_Executive_Link.AR2BBusPAWRep2);
		SELF.Business_To_Executive_Link.AR2BBusPAWRep2 := calculateValueFor.checkTrueBiz(AR2BBusPAWRep2, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BRep2AddrAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2AddrAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2PhoneAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2PhoneAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep2SSNAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep2SSNAssociateCHeader, VerInputIDTruebiz);
		BusExecLinkBusAddrAuthRep2Owned := IF((INTEGER)le.Clean_Input.Rep2_LexID <= 0, '-1', le.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep2Owned);
		SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep2Owned := calculateValueFor.checkTrueBiz(BusExecLinkBusAddrAuthRep2Owned, VerInputIDTruebiz);
		BusExecLinkUtilityOverlapCount2 := IF(le.Input.InputCheckAuthRep2FirstName = '0' OR le.Input.InputCheckAuthRep2LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2);
		SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2 := calculateValueFor.checkTrueBiz(BusExecLinkUtilityOverlapCount2, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount2 := IF(le.Input.InputCheckAuthRep2FirstName = '0' OR le.Input.InputCheckAuthRep2LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount2);
    SELF.Business_To_Executive_Link.AR2BBusRep2AddrDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep2AddrDistance, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BBusRep2PhoneDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep2PhoneDistance, VerInputIDTruebiz);
		//rep3
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile, VerInputIDTruebiz);		
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile := IF(le.Input.InputCheckAuthRep3FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile);
		BusExecLinkBusNameAuthRep3First := IF(le.Input.InputCheckAuthRep3FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep3First, VerInputIDTruebiz);
		BusExecLinkBusNameAuthRep3Last := IF(le.Input.InputCheckAuthRep3LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep3Last, VerInputIDTruebiz);
		BusExecLinkBusNameAuthRep3Full := IF(le.Input.InputCheckAuthRep3FirstName = '0' OR le.Input.InputCheckAuthRep3LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep3Full, VerInputIDTruebiz);		
		BusExecLinkAuthRep3PhoneBusPhone := IF(le.Input.InputCheckAuthRep3Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3PhoneBusPhone, VerInputIDTruebiz);
		BusExecLinkAuthRep3AddrBusAddr := IF(le.Input.InputCheckAuthRep3Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3AddrBusAddr, VerInputIDTruebiz);
		BusExecLinkAuthRep3NameOnFile  := IF(le.Input.InputCheckAuthRep3FirstName = '0' AND le.Input.InputCheckAuthRep3LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3NameOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep3AddrOnFile := IF(le.Input.InputCheckAuthRep3Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3AddrOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep3PhoneOnFile  := IF(le.Input.InputCheckAuthRep3Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3PhoneOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep3SSNOnFile  := IF(le.Input.InputCheckAuthRep3SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3SSNOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep3SSNBusFein  := IF(le.Input.InputCheckAuthRep3SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFEIN := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep3SSNBusFEIN, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3NameBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3NameBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3AddrBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3AddrBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3PhoneBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3SSNBusHeaderLexID, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3PhoneBusHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3SSNBusHeader, VerInputIDTruebiz);
		AR2BBusPAWRep3 := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND (TRIM(le.Clean_Input.Rep3_FirstName) = '' AND TRIM(le.Clean_Input.Rep3_LastName) = ''), '-1', le.Business_To_Executive_Link.AR2BBusPAWRep3);
    SELF.Business_To_Executive_Link.AR2BBusPAWRep3 := calculateValueFor.checkTrueBiz(AR2BBusPAWRep3, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3AddrAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3AddrAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3PhoneAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3PhoneAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep3SSNAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep3SSNAssociateCHeader, VerInputIDTruebiz);
		BusExecLinkBusAddrAuthRep3Owned := IF((INTEGER)le.Clean_Input.Rep3_LexID <= 0, '-1', le.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep3Owned);
		SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep3Owned := calculateValueFor.checkTrueBiz(BusExecLinkBusAddrAuthRep3Owned, VerInputIDTruebiz);
		BusExecLinkUtilityOverlapCount3 := IF(le.Input.InputCheckAuthRep3FirstName = '0' OR le.Input.InputCheckAuthRep3LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3);
		SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3 := calculateValueFor.checkTrueBiz(BusExecLinkUtilityOverlapCount3, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount3 := IF(le.Input.InputCheckAuthRep3FirstName = '0' OR le.Input.InputCheckAuthRep3LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount3);
    SELF.Business_To_Executive_Link.AR2BBusRep3AddrDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep3AddrDistance, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BBusRep3PhoneDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep3PhoneDistance, VerInputIDTruebiz);
		//rep4
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile, VerInputIDTruebiz);		
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile := IF(le.Input.InputCheckAuthRep4FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile);
		BusExecLinkBusNameAuthRep4First := IF(le.Input.InputCheckAuthRep4FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep4First, VerInputIDTruebiz);
		BusExecLinkBusNameAuthRep4Last := IF(le.Input.InputCheckAuthRep4LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep4Last, VerInputIDTruebiz);
		BusExecLinkBusNameAuthRep4Full := IF(le.Input.InputCheckAuthRep4FirstName = '0' OR le.Input.InputCheckAuthRep4LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep4Full, VerInputIDTruebiz);				
		BusExecLinkAuthRep4PhoneBusPhone := IF(le.Input.InputCheckAuthRep4Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep4PhoneBusPhone, VerInputIDTruebiz);		
		BusExecLinkAuthRep4AddrBusAddr := IF(le.Input.InputCheckAuthRep4Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep4AddrBusAddr, VerInputIDTruebiz);		
		BusExecLinkAuthRep4NameOnFile  := IF(le.Input.InputCheckAuthRep4FirstName = '0' AND le.Input.InputCheckAuthRep4LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep4NameOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep4AddrOnFile := IF(le.Input.InputCheckAuthRep4Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep4AddrOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep4PhoneOnFile  := IF(le.Input.InputCheckAuthRep4Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep4PhoneOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep4SSNOnFile  := IF(le.Input.InputCheckAuthRep4SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep4SSNOnFile, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN  := IF(le.Input.InputCheckAuthRep4SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN);
		SELF.Business_To_Executive_Link.AR2BRep4NameBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4NameBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep4AddrBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4AddrBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4PhoneBusHeaderLexID, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4SSNBusHeaderLexID, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4PhoneBusHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4SSNBusHeader, VerInputIDTruebiz);
		AR2BBusPAWRep4 := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND (TRIM(le.Clean_Input.Rep4_FirstName) = '' AND TRIM(le.Clean_Input.Rep4_LastName) = ''), '-1', le.Business_To_Executive_Link.AR2BBusPAWRep4);
    SELF.Business_To_Executive_Link.AR2BBusPAWRep4 := calculateValueFor.checkTrueBiz(AR2BBusPAWRep4, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep4AddrAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4AddrAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep4PhoneAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4PhoneAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep4SSNAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep4SSNAssociateCHeader, VerInputIDTruebiz);
		BusExecLinkBusAddrAuthRep4Owned := IF((INTEGER)le.Clean_Input.Rep4_LexID <= 0, '-1', le.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep4Owned);
		SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep4Owned := calculateValueFor.checkTrueBiz(BusExecLinkBusAddrAuthRep4Owned, VerInputIDTruebiz);
		BusExecLinkUtilityOverlapCount4 := IF(le.Input.InputCheckAuthRep4FirstName = '0' OR le.Input.InputCheckAuthRep4LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4);
		SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4 := calculateValueFor.checkTrueBiz(BusExecLinkUtilityOverlapCount4, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount4 := IF(le.Input.InputCheckAuthRep4FirstName = '0' OR le.Input.InputCheckAuthRep4LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount4);
    SELF.Business_To_Executive_Link.AR2BBusRep4AddrDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep4AddrDistance, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BBusRep4PhoneDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep4PhoneDistance, VerInputIDTruebiz);
		//rep5
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile, VerInputIDTruebiz);		
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile := IF(le.Input.InputCheckAuthRep5FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile);
		BusExecLinkBusNameAuthRep5First := IF(le.Input.InputCheckAuthRep5FirstName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep5First, VerInputIDTruebiz);		
		BusExecLinkBusNameAuthRep5Last := IF(le.Input.InputCheckAuthRep5LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep5Last, VerInputIDTruebiz);		
		BusExecLinkBusNameAuthRep5Full := IF(le.Input.InputCheckAuthRep5FirstName = '0' OR le.Input.InputCheckAuthRep5LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full := calculateValueFor.checkTrueBiz(BusExecLinkBusNameAuthRep5Full, VerInputIDTruebiz);				
		BusExecLinkAuthRep5PhoneBusPhone := IF(le.Input.InputCheckAuthRep5Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep5PhoneBusPhone, VerInputIDTruebiz);		
		BusExecLinkAuthRep5AddrBusAddr := IF(le.Input.InputCheckAuthRep5Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep5AddrBusAddr, VerInputIDTruebiz);
		BusExecLinkAuthRep5NameOnFile  := IF(le.Input.InputCheckAuthRep5FirstName = '0' AND le.Input.InputCheckAuthRep5LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep5NameOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep5AddrOnFile := IF(le.Input.InputCheckAuthRep5Addr = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep5AddrOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep5PhoneOnFile  := IF(le.Input.InputCheckAuthRep5Phone = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep5PhoneOnFile, VerInputIDTruebiz);
		BusExecLinkAuthRep5SSNOnFile  := IF(le.Input.InputCheckAuthRep5SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile := calculateValueFor.checkTrueBiz(BusExecLinkAuthRep5SSNOnFile, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFEIN  := IF(le.Input.InputCheckAuthRep5SSN = '0', '-1', le.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFEIN);
		SELF.Business_To_Executive_Link.AR2BRep5NameBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5NameBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5AddrBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5AddrBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5PhoneBusHeaderLexID, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeaderLexID := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5SSNBusHeaderLexID, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5PhoneBusHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5SSNBusHeader, VerInputIDTruebiz);
		AR2BBusPAWRep5 := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND (TRIM(le.Clean_Input.Rep5_FirstName) = '' AND TRIM(le.Clean_Input.Rep5_LastName) = ''), '-1', le.Business_To_Executive_Link.AR2BBusPAWRep5);
    SELF.Business_To_Executive_Link.AR2BBusPAWRep5 := calculateValueFor.checkTrueBiz(AR2BBusPAWRep5, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5AddrAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5AddrAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5PhoneAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5PhoneAssociateCHeader, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.AR2BRep5SSNAssociateCHeader := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BRep5SSNAssociateCHeader, VerInputIDTruebiz);
		BusExecLinkBusAddrAuthRep5Owned := IF((INTEGER)le.Clean_Input.Rep5_LexID <= 0, '-1', le.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep5Owned);
		SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep5Owned := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep5Owned, VerInputIDTruebiz);
		BusExecLinkUtilityOverlapCount5 := IF(le.Input.InputCheckAuthRep5FirstName = '0' OR le.Input.InputCheckAuthRep5LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5);
		SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5 := calculateValueFor.checkTrueBiz(BusExecLinkUtilityOverlapCount5, VerInputIDTruebiz);
		SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount5 := IF(le.Input.InputCheckAuthRep5FirstName = '0' OR le.Input.InputCheckAuthRep5LastName = '0', '-1', le.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount5);
    SELF.Business_To_Executive_Link.AR2BBusRep5AddrDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep5AddrDistance, VerInputIDTruebiz);
    SELF.Business_To_Executive_Link.AR2BBusRep5PhoneDistance := calculateValueFor.checkTrueBiz(le.Business_To_Executive_Link.AR2BBusRep5PhoneDistance, VerInputIDTruebiz);
		
		SELF.Inquiry.InquiryConsumerAddress := IF(le.Input.InputCheckBusAddr = '0', '-1', le.Inquiry.InquiryConsumerAddress);
		SELF.Inquiry.InquiryConsumerPhone := IF(le.Input.InputCheckBusPhone = '0', '-1', le.Inquiry.InquiryConsumerPhone);
		SELF.Inquiry.InquiryConsumerAddressSSN := IF(le.Input.InputCheckBusAddr = '0', '-1', le.Inquiry.InquiryConsumerAddressSSN);
		SELF.Input_Characteristics.InputPhoneMobile := IF(le.Input.InputCheckBusPhone = '0', '-1', le.Input_Characteristics.InputPhoneMobile);
		InputPhoneProblems := MAP(le.Input.InputCheckBusPhone = '0'				=> '-1',
															le.Verification.PhoneDisconnected = '1'	=> '1',
																																				 le.Input_Characteristics.InputPhoneProblems);
		SELF.Input_Characteristics.InputPhoneProblems := InputPhoneProblems;
		SELF.Verification.PhoneDisconnected := MAP(le.Input.InputCheckBusPhone = '0'	=> '-1',
																							 InputPhoneProblems = '1'						=> '1',
																																										 le.Verification.PhoneDisconnected);
		SELF.Input_Characteristics.InputAddrBusinessOwned := IF(le.Input.InputCheckBusAddr = '0', '-1', le.Input_Characteristics.InputAddrBusinessOwned);
    SELF.Input_Characteristics.InputPhoneEntityCount := calculateValueFor._InputPhoneEntityCount(le.Input_Characteristics.InputPhoneEntityCount, le.Input.InputCheckBusPhone, le.Clean_Input.Phone10);

		BusinessAddrCount := (STRING)MAX((INTEGER)le.Business_Characteristics.BusinessAddrCount, 0); // We have BIP ID's, make sure the count is at least 0
		SELF.Business_Characteristics.BusinessAddrCount := calculateValueFor.checkTrueBiz(BusinessAddrCount, VerInputIDTruebiz);
		BusinessActivity36Month := 											MAP((INTEGER)MaxDateLastSeen <= 0 															=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyTimeNewest	BETWEEN 1 AND 36 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount36 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount36 > 0			=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 36 OR
																												COUNT(NonDerogSourceRecords36Month) = 0 AND	
																												(INTEGER)MaxDateLastSeen > 0 																=> '1',
																												COUNT(NonDerogSourceRecords36Month) = 1											=> '2',
																												COUNT(NonDerogSourceRecords36Month) = 2											=> '3',
																												COUNT(NonDerogSourceRecords36Month) = 3											=> '4',
																												COUNT(NonDerogSourceRecords36Month) >= 4										=> '5',
																																																											 '-1');
		SELF.Business_Activity.BusinessActivity36Month := checkBlank(BusinessActivity36Month, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22);
		BusinessActivity24Month := 											MAP((INTEGER)MaxDateLastSeen <= 0																=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount24Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount24 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount24 > 0			=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 24 OR
																												COUNT(NonDerogSourceRecords24Month) = 0 AND	
																												(INTEGER)MaxDateLastSeen > 0 																=> '1',
																												COUNT(NonDerogSourceRecords24Month) = 1											=> '2',
																												COUNT(NonDerogSourceRecords24Month) = 2											=> '3',
																												COUNT(NonDerogSourceRecords24Month) = 3											=> '4',
																												COUNT(NonDerogSourceRecords24Month) >= 4										=> '5',
																																																											 '-1');
		SELF.Business_Activity.BusinessActivity24Month := checkBlank(BusinessActivity24Month, '-1', Business_Risk_BIP.Constants.BusShellVersion_v22);
		
		SELF.Business_Activity.BusinessActivity12Month := MAP((INTEGER)MaxDateLastSeen <= 0 														=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount12Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount12 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount12 > 0			=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 12 OR
																												COUNT(NonDerogSourceRecords12Month) = 0 AND	
																												(INTEGER)MaxDateLastSeen > 0 																=> '1',
																												COUNT(NonDerogSourceRecords12Month) = 1											=> '2',
																												COUNT(NonDerogSourceRecords12Month) = 2											=> '3',
																												COUNT(NonDerogSourceRecords12Month) = 3											=> '4',
																												COUNT(NonDerogSourceRecords12Month) >= 4										=> '5',
																																																											 '-1');
		SELF.Business_Activity.BusinessActivity06Month := MAP((INTEGER)MaxDateLastSeen <= 0 														=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount06Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount06 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount06 > 0			=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 6 OR
																												COUNT(NonDerogSourceRecords06Month) = 0 AND	
																												(INTEGER)MaxDateLastSeen > 0 																=> '1',
																												COUNT(NonDerogSourceRecords06Month) = 1											=> '2',
																												COUNT(NonDerogSourceRecords06Month) = 2											=> '3',
																												COUNT(NonDerogSourceRecords06Month) = 3											=> '4',
																												COUNT(NonDerogSourceRecords06Month) >= 4										=> '5',
																																																											 '-1');
		SELF.Business_Activity.BusinessActivity03Month := MAP((INTEGER)MaxDateLastSeen <= 0 														=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount03Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount03 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount03 > 0			=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 3 OR
																												COUNT(NonDerogSourceRecords03Month) = 0 AND	
																												(INTEGER)MaxDateLastSeen > 0 																=> '1',
																												COUNT(NonDerogSourceRecords03Month) = 1											=> '2',
																												COUNT(NonDerogSourceRecords03Month) = 2											=> '3',
																												COUNT(NonDerogSourceRecords03Month) = 3											=> '4',
																												COUNT(NonDerogSourceRecords03Month) >= 4										=> '5',
																																																											 '-1');
	
		BankruptcyTimeNewest := IF((INTEGER)le.Bankruptcy.BankruptcyCount > 0, le.Bankruptcy.BankruptcyTimeNewest, '-1');
		SELF.Bankruptcy.BankruptcyTimeNewest := calculateValueFor.checkTrueBiz(BankruptcyTimeNewest, VerInputIDTruebiz);
		SELF.Bankruptcy.BankruptcyCount12Month := calculateValueFor.checkTrueBiz(le.Bankruptcy.BankruptcyCount12Month, VerInputIDTruebiz);
		SELF.Bankruptcy.BankruptcyCount24Month := calculateValueFor.checkTrueBiz(le.Bankruptcy.BankruptcyCount24Month, VerInputIDTruebiz);
		SELF.Bankruptcy.BankruptcyCount84Month := calculateValueFor.checkTrueBiz(le.Bankruptcy.BankruptcyCount84Month, VerInputIDTruebiz);
		SELF.Bankruptcy.BankruptcyChapter := calculateValueFor.checkTrueBiz(le.Bankruptcy.BankruptcyChapter, VerInputIDTruebiz);
		SELF.Bankruptcy.bankruptrecentdate := calculateValueFor.checkTrueBiz(le.Bankruptcy.bankruptrecentdate, VerInputIDTruebiz);
		
		SELF.Verification.SourceNonDerogCount := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords), -1, 99999);
		SELF.Verification.SourceNonDerogCount03 := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords03Month), -1, 99999);
		SELF.Verification.SourceNonDerogCount06 := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords06Month), -1, 99999);
		SELF.Verification.SourceNonDerogCount12 := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords12Month), -1, 99999);
		SELF.Verification.SourceNonDerogCount24 := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords24Month), -1, 99999);
		SELF.Verification.SourceNonDerogCount36 := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords36Month), -1, 99999);
		SELF.Verification.SourceNonDerogCount60 := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords60Month), -1, 99999);
		
		// Not coded yet, set to default values
		SELF.Business_To_Executive_Link.BusExecLinkPublishedAssociation := '-1';
		SELF.Business_To_Executive_Link.BusExecLinkPublishedAssociation2 := '-1';
		SELF.Business_To_Executive_Link.BusExecLinkPublishedAssociation3 := '-1';
		SELF.Business_To_Executive_Link.BusExecLinkPublishedAssociation4 := '-1';
		SELF.Business_To_Executive_Link.BusExecLinkPublishedAssociation5 := '-1';
		
		SELF.Verification.BusFEINOnFileCount := '-1';
		SELF.Verification.FEINMiskeyFlag := Business_Risk_BIP.Common.SetBoolean(FALSE);
		SELF.Verification.PhoneMisKey := Business_Risk_BIP.Common.SetBoolean(FALSE);
		SELF.Verification.AddrConsumerCount := '-1';
	//	SELF.Verification.AddrMiskey := Business_Risk_BIP.Common.SetBoolean(FALSE);
		SELF.Verification.AddrEverReported := '-1';
		SELF.Verification.NameMiskey := Business_Risk_BIP.Common.SetBoolean(FALSE);
		
		SBFEExists := (INTEGER)le.SBFE.SBFEAccountCount > 0;
		SELF.SBFE.SBFESourceIndex := MAP(COUNT(SeqSources) > 0 AND NOT SBFEExists => '1',  //LN only
																		 COUNT(SeqSources) = 0 AND SBFEExists 		=> '2',  //SBFE only
																		 COUNT(SeqSources) > 0 AND SBFEExists 		=> '3',  //LN and SBFE
																																								 '0'); // Else there are no sources as of the archive date
		
		LNExists := COUNT(SeqSourcesLinkIds) > 0;
		CorteraExists := le.Verification.SourceIndex = '2';
		
		SELF.Verification.SourceIndex := MAP(NOT LNExists AND NOT CorteraExists AND NOT SBFEExists 	=> '-1',
																				 LNExists AND NOT CorteraExists AND NOT SBFEExists 		 	=> '1',
																				 NOT LNExists AND CorteraExists AND NOT SBFEExists 		  => '2',
																				 NOT LNExists AND NOT CorteraExists AND SBFEExists 			=> '3',
																				 LNExists AND CorteraExists AND NOT SBFEExists 					=> '4',
																				 LNExists AND NOT CorteraExists AND SBFEExists 					=> '5',
																				 NOT LNExists AND CorteraExists AND SBFEExists 					=> '6',
																				 LNExists AND CorteraExists AND SBFEExists 							=> '7',
																																																	 '-1');
																				 
																		
																				 
		SELF.BillingHit := IF( (COUNT(SeqSources) > 0 AND NOT SBFEExists) OR SBFEExists, '1', '0' );
		
		MinDateFirstSeenID := (STRING)MIN(PROJECT(SeqSourcesLinkIds, TRANSFORM(RECORDOF(LEFT), SELF.DateFirstSeen := IF((INTEGER)LEFT.DateFirstSeen <= 0, Business_Risk_BIP.Constants.NinesDate, LEFT.DateFirstSeen))), (INTEGER)DateFirstSeen);
		SourceFirstSeenID := IF(MinDateFirstSeenID = Business_Risk_BIP.Constants.NinesDate, Business_Risk_Bip.Constants.MissingDate, MinDateFirstSeenID);
		SELF.Verification.SourceFirstSeenID := SourceFirstSeenID;
		MaxDateLastSeenID := (STRING)MAX(SeqSourcesLinkIds, (INTEGER)DateLastSeen);
		SELF.Verification.SourceLastSeenID := MaxDateLastSeenID;
		BRTimeNewestID := (STRING)IF((INTEGER)MaxDateLastSeenID > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)MaxDateLastSeenID, (STRING)TodaysDate), 1, 99999), -1);
		BRTimeOldestID := (STRING)IF((INTEGER)SourceFirstSeenID > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)SourceFirstSeenID, (STRING)TodaysDate), 1, 99999), -1);
		SELF.Business_Activity.SourceBusinessRecordTimeNewestID := IF((INTEGER)BRTimeNewestID > 0 AND (INTEGER)BRTimeOldestID > 0, (STRING)MIN((INTEGER)BRTimeNewestID, (INTEGER)BRTimeOldestID), BRTimeNewestID);
		SELF.Business_Activity.SourceBusinessRecordTimeOldestID := (STRING)MAX((INTEGER)BRTimeNewestID, (INTEGER)BRTimeOldestID);
		MonthsMostRecentOnFileID := (STRING)IF((INTEGER)MaxDateLastSeenID > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart((STRING)MaxDateLastSeenID, (STRING)TodaysDate), 1, 99999), -1);
		SELF.Business_Activity.SourceBusinessRecordUpdated12MonthID := IF((INTEGER)MaxDateLastSeenID > 0, Business_Risk_BIP.Common.SetBoolean((INTEGER)MonthsMostRecentOnFileID BETWEEN 1 AND 12), '-1');		
		
		SourceCountID := (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqSourcesLinkIds), -1, 99);
		SELF.Verification.SourceCountID := calculateValueFor.checkTrueBiz(SourceCountID, VerInputIDTruebiz);
		
		NonDerogSourceRecordsID := SeqSourcesLinkIds (Source IN Business_Risk_BIP.Constants.Set_NonDerog);
		NonDerogSourceRecords60MonthID := NonDerogSourceRecordsID ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(5)); 
		NonDerogSourceRecords36MonthID := NonDerogSourceRecords60MonthID ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(3));
		NonDerogSourceRecords24MonthID := NonDerogSourceRecords36MonthID ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(2));
		NonDerogSourceRecords12MonthID := NonDerogSourceRecords24MonthID ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= ut.DaysInNYears(1));
		NonDerogSourceRecords06MonthID := NonDerogSourceRecords12MonthID ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.SixMonths);
		NonDerogSourceRecords03MonthID := NonDerogSourceRecords06MonthID ((INTEGER)DateLastSeen > 0 AND ut.DaysApart(DateLastSeen, TodaysDate) <= Business_Risk_BIP.Constants.ThreeMonths);
		
		SourceNonDerogCountID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecordsID), -1, 99999);
		SourceNonDerogCount03MonthID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords03MonthID), -1, 99999);
		SourceNonDerogCount06MonthID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords06MonthID), -1, 99999);
		SourceNonDerogCount12MonthID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords12MonthID), -1, 99999);
		SourceNonDerogCount24MonthID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(
                            IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, NonDerogSourceRecords24MonthID, NonDerogSourceRecords12MonthID)), -1, 99999);
		SourceNonDerogCount36MonthID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords36MonthID), -1, 99999);
		SourceNonDerogCount60MonthID := (STRING)Business_Risk_BIP.Common.CapNum(COUNT(NonDerogSourceRecords60MonthID), -1, 99999);

		SELF.Verification.SourceNonDerogCountID := calculateValueFor.checkTrueBiz(SourceNonDerogCountID, VerInputIDTruebiz);
		SELF.Verification.SourceNonDerogCount03MonthID := calculateValueFor.checkTrueBiz(SourceNonDerogCount03MonthID, VerInputIDTruebiz);
		SELF.Verification.SourceNonDerogCount06MonthID := calculateValueFor.checkTrueBiz(SourceNonDerogCount06MonthID, VerInputIDTruebiz);
		SELF.Verification.SourceNonDerogCount12MonthID := calculateValueFor.checkTrueBiz(SourceNonDerogCount12MonthID, VerInputIDTruebiz);
		SELF.Verification.SourceNonDerogCount24MonthID := calculateValueFor.checkTrueBiz(SourceNonDerogCount24MonthID, VerInputIDTruebiz);
		SELF.Verification.SourceNonDerogCount36MonthID := calculateValueFor.checkTrueBiz(SourceNonDerogCount36MonthID, VerInputIDTruebiz);
		SELF.Verification.SourceNonDerogCount60MonthID := calculateValueFor.checkTrueBiz(SourceNonDerogCount60MonthID, VerInputIDTruebiz);
		
		SELF.Business_Activity.BusinessActivity03MonthID := 	MAP((INTEGER)MaxDateLastSeenID <= 0 														=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount03Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount03 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount03 > 0							=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 3 OR
																												COUNT(NonDerogSourceRecords03MonthID) = 0 AND	
																												(INTEGER)MaxDateLastSeenID > 0 																=> '1',
																												COUNT(NonDerogSourceRecords03MonthID) = 1											=> '2',
																												COUNT(NonDerogSourceRecords03MonthID) = 2											=> '3',
																												COUNT(NonDerogSourceRecords03MonthID) = 3											=> '4',
																												COUNT(NonDerogSourceRecords03MonthID) >= 4											=> '5',
																																																															'-1');
		SELF.Business_Activity.BusinessActivity06MonthID := MAP((INTEGER)MaxDateLastSeenID <= 0 															=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount06Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount06 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount06 > 0							=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 6 OR
																												COUNT(NonDerogSourceRecords06MonthID) = 0 AND	
																												(INTEGER)MaxDateLastSeenID > 0 																=> '1',
																												COUNT(NonDerogSourceRecords06MonthID) = 1											=> '2',
																												COUNT(NonDerogSourceRecords06MonthID) = 2											=> '3',
																												COUNT(NonDerogSourceRecords06MonthID) = 3											=> '4',
																												COUNT(NonDerogSourceRecords06MonthID) >= 4											=> '5',
																																																															'-1');
		SELF.Business_Activity.BusinessActivity12MonthID := MAP((INTEGER)MaxDateLastSeenID <= 0 														=> '-1', 
																												(INTEGER)le.Bankruptcy.BankruptcyCount12Month > 0 OR 
																												(INTEGER)le.Lien_And_Judgment.LienFiledCount12 > 0 OR
																												(INTEGER)le.Lien_And_Judgment.JudgmentFiledCount12 > 0			=> '0',
																												(INTEGER)le.SOS.SOSTimeAgentChange BETWEEN 1 AND 12 OR
																												COUNT(NonDerogSourceRecords12MonthID) = 0 AND	
																												(INTEGER)MaxDateLastSeenID > 0 																=> '1',
																												COUNT(NonDerogSourceRecords12MonthID) = 1											=> '2',
																												COUNT(NonDerogSourceRecords12MonthID) = 2											=> '3',
																												COUNT(NonDerogSourceRecords12MonthID) = 3											=> '4',
																												COUNT(NonDerogSourceRecords12MonthID) >= 4										=> '5',
																																																											 '-1');
		SELF.Verification.sourcelistID := Business_Risk_BIP.Common.convertDelimited(SeqSourcesLinkIds, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.sourcedatefirstseenlistID := Business_Risk_BIP.Common.convertDelimited(SeqSourcesLinkIds, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.SourceIDDateFirstSeenList := calculateValueFor._SourceIDDateFirstSeenList(SeqSourcesLinkIds);
		SELF.Verification.sourcedatelastseenlistID := Business_Risk_BIP.Common.convertDelimited(SeqSourcesLinkIds, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.SourceIDDateLastSeenList := calculateValueFor._SourceIDDateLastSeenList(SeqSourcesLinkIds);

		SELF.Firmographic.busobservedageID := IF(SourceFirstSeenID = Business_Risk_BIP.Constants.MissingDate, 
		     '-1', 
         (STRING)Business_Risk_BIP.Common.capNum(ROUNDUP(ut.DaysApart(SourceFirstSeenID, Business_Risk_BIP.Common.todaysDate((STRING8)Std.Date.Today(), le.Clean_Input.HistoryDate)) / 365.25), -1, 110)
    );
		                                         
		PhoneIDSources := le.PhoneSources(source NOT IN [gong_src, MDR.sourceTools.set_Phones_Plus]) + le.PhoneIDSources;
		GroupedPhoneIDSources := Business_Risk_BIP.Common.groupSources(Business_Risk_BIP.Layouts.LayoutSources, PhoneIDSources);
		UniquePhoneIDSources := ROLLUP(SORT(GroupedPhoneIDSources, Source), LEFT.Source = RIGHT.Source, rollSource(LEFT, RIGHT)) (Source <> '');
		SeqPhoneIDSources := SORT(UniquePhoneIDSources, -DateLastSeen, -DateFirstSeen, Source, -RecordCount);		
		
		
		SELF.Verification.PhoneMatchDateFirstSeenID := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqPhoneIDSources, 1, DateFirstSeen)[1].DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate);
		SELF.Verification.PhoneMatchDateLastSeenID := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SeqPhoneIDSources, 1, -DateLastSeen)[1].DateLastSeen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate);
		SELF.Verification.PhoneMatchSourceCountID :=  IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND le.Input.InputCheckBusPhone = '0', '-1',
                                                    (STRING)Business_Risk_BIP.Common.capNum(COUNT(SeqPhoneIDSources), -1, 99));
		SELF.Verification.PhoneMatchSourceListID := Business_Risk_BIP.Common.convertDelimited(SeqPhoneIDSources, Source, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.PhoneDateFirstSeenListID := Business_Risk_BIP.Common.convertDelimited(SeqPhoneIDSources, DateFirstSeen, Business_Risk_BIP.Constants.FieldDelimiter);

		SELF.Verification.PhoneMatchIDSourceDateFSList := calculateValueFor._PhoneMatchIDSourceDateFSList(SeqPhoneIDSources);
		SELF.Verification.PhoneDateLastSeenListID := Business_Risk_BIP.Common.convertDelimited(SeqPhoneIDSources, DateLastSeen, Business_Risk_BIP.Constants.FieldDelimiter);
		SELF.Verification.PhoneMatchIDSourceDateLSList := calculateValueFor._PhoneMatchIDSourceDateLSList(SeqPhoneIDSources);
		
		// If the Business Header JOIN() LIMIT was reached, manually assign the match category and match status attriutes now, since that data couldn't be pulled out of the business header data earlier.
		IsLargeBusinessCategory := le.Data_Fetch_Indicators.FetchCodeBusinessHeader = Business_Risk_BIP.Constants.LimitExceededErrorCode;						
		SELF.Verification.InputIDMatchCategory := calculateValueFor._InputIDMatchCategory(IsLargeBusinessCategory, le.Verification.InputIDMatchCategory);
		SELF.Verification.InputIDMatchStatus := calculateValueFor._InputIDMatchStatus(IsLargeBusinessCategory, le.Verification.InputIDMatchStatus);

		// In version 3.0 and above, if business did not exist as of the history date, adjust fields to return default values
		SELF.Verification.VerInputNameAlternative := calculateValueFor.checkTrueBiz(le.Verification.VerInputNameAlternative, VerInputIDTruebiz);
		SELF.Verification.VerInputNameDBA := calculateValueFor.checkTrueBiz(le.Verification.VerInputNameDBA, VerInputIDTruebiz);
    SELF.Verification.AddrIsBest := calculateValueFor.checkTrueBiz(le.Verification.AddrIsBest, VerInputIDTruebiz);
		SELF.Verification.AddrZipVerification := calculateValueFor.checkTrueBiz(le.Verification.AddrZipVerification, VerInputIDTruebiz);
		SELF.Verification.InputAddrOwnership := calculateValueFor.checkTrueBiz(le.Verification.InputAddrOwnership, VerInputIDTruebiz);
		SELF.Verification.PhoneInputMiskey := calculateValueFor.checkTrueBiz(le.Verification.PhoneInputMiskey, VerInputIDTruebiz);
    SELF.Verification.FEINInputMiskey := calculateValueFor.checkTrueBiz(le.Verification.FEINInputMiskey, VerInputIDTruebiz);
    SELF.Verification.FEINPersonNameMatch := calculateValueFor.checkTrueBiz(le.Verification.FEINPersonNameMatch, VerInputIDTruebiz);
    SELF.Verification.FEINPersonAddrMatch := calculateValueFor.checkTrueBiz(le.Verification.FEINPersonAddrMatch, VerInputIDTruebiz);
    SELF.Verification.FEINAssociateSSNMatch := calculateValueFor.checkTrueBiz(le.Verification.FEINAssociateSSNMatch, VerInputIDTruebiz);
    SELF.Verification.FEINRelativeSSNMatch := calculateValueFor.checkTrueBiz(le.Verification.FEINRelativeSSNMatch, VerInputIDTruebiz);
    SELF.Verification.FEINHouseholdSSNMatch := calculateValueFor.checkTrueBiz(le.Verification.FEINHouseholdSSNMatch, VerInputIDTruebiz);
    SELF.Firmographic.OwnershipType := calculateValueFor.checkTrueBiz(le.Firmographic.OwnershipType, VerInputIDTruebiz);
		SELF.SOS.SOSIncorporationCount := calculateValueFor.checkTrueBiz(le.SOS.SOSIncorporationCount, VerInputIDTruebiz);
		SELF.SOS.SOSIncorporationDateFirstSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSIncorporationDateFirstSeen, VerInputIDTruebiz);
		SELF.SOS.SOSIncorporationDateLastSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSIncorporationDateLastSeen, VerInputIDTruebiz);
		SELF.SOS.SOSTimeIncorporation := calculateValueFor.checkTrueBiz(le.SOS.SOSTimeIncorporation, VerInputIDTruebiz);
		SELF.SOS.SOSStateCount := calculateValueFor.checkTrueBiz(le.SOS.SOSStateCount, VerInputIDTruebiz);
		SELF.SOS.SOSIncorporationStateInput := calculateValueFor.checkTrueBiz(le.SOS.SOSIncorporationStateInput, VerInputIDTruebiz);
    SELF.SOS.SOSDomesticCount := calculateValueFor.checkTrueBiz(le.SOS.SOSDomesticCount, VerInputIDTruebiz);
		SELF.SOS.SOSDomesticDateFirstSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSDomesticDateFirstSeen, VerInputIDTruebiz);
		SELF.SOS.SOSDomesticDateLastSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSDomesticDateLastSeen, VerInputIDTruebiz);
		SELF.SOS.SOSDomesticMosSinceFirstSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSDomesticMosSinceFirstSeen, VerInputIDTruebiz);
		SELF.SOS.SOSForeignCount := calculateValueFor.checkTrueBiz(le.SOS.SOSForeignCount, VerInputIDTruebiz);
		SELF.SOS.SOSForeignDateFirstSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSForeignDateFirstSeen, VerInputIDTruebiz);
		SELF.SOS.SOSForeignDateLastSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSForeignDateLastSeen, VerInputIDTruebiz);
    SELF.SOS.SOSForeignMosSinceFirstSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSForeignMosSinceFirstSeen, VerInputIDTruebiz);
		SELF.SOS.SOSForeignStateCount := calculateValueFor.checkTrueBiz(le.SOS.SOSForeignStateCount, VerInputIDTruebiz);
    SELF.SOS.SOSStandingBest := calculateValueFor.checkTrueBiz(le.SOS.SOSStandingBest, VerInputIDTruebiz);
    SELF.SOS.SOSStandingWorst := calculateValueFor.checkTrueBiz(le.SOS.SOSStandingWorst, VerInputIDTruebiz);
		SELF.SOS.soseverdefunct := calculateValueFor.checkTrueBiz(le.SOS.soseverdefunct, VerInputIDTruebiz);
		SELF.SOS.SOSRegisterAgentChangeDateLastSeen := calculateValueFor.checkTrueBiz(le.SOS.SOSRegisterAgentChangeDateLastSeen, VerInputIDTruebiz);
		SELF.SOS.SOSTimeAgentChange := calculateValueFor.checkTrueBiz(le.SOS.SOSTimeAgentChange, VerInputIDTruebiz);
		SELF.Associates.AssociateCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCount, VerInputIDTruebiz);
		SELF.Associates.AssociateFelonyCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateFelonyCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCountWithFelony := calculateValueFor.checkTrueBiz(le.Associates.AssociateCountWithFelony, VerInputIDTruebiz);
		SELF.Associates.AssociateBankruptCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateBankruptCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCountWithBankruptcy := calculateValueFor.checkTrueBiz(le.Associates.AssociateCountWithBankruptcy, VerInputIDTruebiz);
		SELF.Associates.AssociateBankrupt1YearCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateBankrupt1YearCount, VerInputIDTruebiz);
		SELF.Associates.AssociateLienCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateLienCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCountWithLien := calculateValueFor.checkTrueBiz(le.Associates.AssociateCountWithLien, VerInputIDTruebiz);
		SELF.Associates.AssociateJudgmentCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateJudgmentCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCountWithJudgment := calculateValueFor.checkTrueBiz(le.Associates.AssociateCountWithJudgment, VerInputIDTruebiz);
		SELF.Associates.AssociatePAWCount := calculateValueFor.checkTrueBiz(le.Associates.AssociatePAWCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCityCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCityCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCountyCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCountyCount, VerInputIDTruebiz);
		SELF.Associates.AssociateHighRiskAddrCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateHighRiskAddrCount, VerInputIDTruebiz);
		SELF.Associates.AssociateHighCrimeAddrCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateHighCrimeAddrCount, VerInputIDTruebiz);
		SELF.Associates.AssociateWatchlistCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateWatchlistCount, VerInputIDTruebiz);
		SELF.Associates.AssociateBusinessCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateBusinessCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentCountWithFelony := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentCountWithFelony, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentCountWithBankruptcy := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentCountWithBankruptcy, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentCountWithLien := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentCountWithLien, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentCountWithJudgment := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentCountWithJudgment, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentCountWithProperty := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentCountWithProperty, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentBusinessCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentBusinessCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentPAWCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentPAWCount, VerInputIDTruebiz);
		SELF.Associates.AssociateCurrentSOSCount := calculateValueFor.checkTrueBiz(le.Associates.AssociateCurrentSOSCount, VerInputIDTruebiz);
		
		SELF.Lien_And_Judgment.LienCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienStateCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienStateCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienStateInput := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienStateInput, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienDollarTotal := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienDollarTotal, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienType := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienType, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienTimeOldest := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienTimeOldest, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienTimeNewest := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienTimeNewest, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledCount03 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledCount03, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledCount06 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledCount06, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledCount12 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledCount12, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledCount24 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledCount24, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledCount36 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledCount36, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledCount60 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledCount60, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount03 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount03, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount06 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount06, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount12 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount12, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount24 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount24, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount36 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount36, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedCount60 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedCount60, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFCCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFCCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFCDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFCDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFCDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFCDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledFCTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledFCTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFCCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFCCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFCDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFCDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFCDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFCDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedFCTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedFCTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledLTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledLTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledLTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledLTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledLTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledLTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledLTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledLTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedLTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedLTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedLTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedLTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedLTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedLTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedLTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedLTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledOTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledOTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledOTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledOTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledOTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledOTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledOTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledOTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedOTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedOTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedOTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedOTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedOTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedOTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedOTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedOTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledMLCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledMLCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledMLDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledMLDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledMLDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledMLDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledMLTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledMLTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedMLCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedMLCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedMLDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedMLDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedMLDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedMLDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedMLTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedMLTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledOCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledOCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledODateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledODateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledODateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledODateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienFiledOTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienFiledOTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedOCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedOCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedODateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedODateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedODateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedODateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.LienReleasedOTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.LienReleasedOTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentStateCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentStateCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentStateInput := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentStateInput, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentDollarTotal := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentDollarTotal, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentType := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentType, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgFiledDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgFiledDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgFiledDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgFiledDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentTimeOldest := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentTimeOldest, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentTimeNewest := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentTimeNewest, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCount03 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCount03, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCount06 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCount06, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCount12 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCount12, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCount24 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCount24, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCount36 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCount36, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCount60 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCount60, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount03 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount03, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount06 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount06, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount12 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount12, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount24 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount24, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount36 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount36, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCount60 := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCount60, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCJCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCJCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCJDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCJDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCJDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCJDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledCJTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledCJTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCJCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCJCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCJDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCJDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCJDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCJDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedCJTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedCJTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSCCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSCCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSCDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSCDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSCDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSCDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSCTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSCTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSCCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSCCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSCDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSCDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSCDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSCDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSCTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSCTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledSTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledSTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSTCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSTCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSTDateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSTDateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSTDateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSTDateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedSTTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedSTTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledOCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledOCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledODateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledODateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledODateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledODateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentFiledOTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentFiledOTotalAmount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedOCount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedOCount, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedODateFirstSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedODateFirstSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedODateLastSeen := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedODateLastSeen, VerInputIDTruebiz);
		SELF.Lien_And_Judgment.JudgmentReleasedOTotalAmount := calculateValueFor.checkTrueBiz(le.Lien_And_Judgment.JudgmentReleasedOTotalAmount, VerInputIDTruebiz);
		
		SELF.Inquiry.InquiryDateFirstSeen := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryDateFirstSeen, VerInputIDTruebiz);
		SELF.Inquiry.InquiryDateLastSeen := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryDateLastSeen, VerInputIDTruebiz);
		SELF.Inquiry.InquiryCount := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryCount, VerInputIDTruebiz);
		SELF.Inquiry.Inquiry03Month := calculateValueFor.checkTrueBiz(le.Inquiry.Inquiry03Month, VerInputIDTruebiz);
		SELF.Inquiry.Inquiry06Month := calculateValueFor.checkTrueBiz(le.Inquiry.Inquiry06Month, VerInputIDTruebiz);
		SELF.Inquiry.Inquiry12Month := calculateValueFor.checkTrueBiz(le.Inquiry.Inquiry12Month, VerInputIDTruebiz);
		SELF.Inquiry.Inquiry24Month := calculateValueFor.checkTrueBiz(le.Inquiry.Inquiry24Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryCreditCount := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryCreditCount, VerInputIDTruebiz);
		SELF.Inquiry.InquiryCredit03Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryCredit03Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryCredit06Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryCredit06Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryCredit12Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryCredit12Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryCredit24Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryCredit24Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryHighRiskCount := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryHighRiskCount, VerInputIDTruebiz);
		SELF.Inquiry.InquiryHighRisk03Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryHighRisk03Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryHighRisk06Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryHighRisk06Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryHighRisk12Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryHighRisk12Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryHighRisk24Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryHighRisk24Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryOtherCount := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryOtherCount, VerInputIDTruebiz);
		SELF.Inquiry.InquiryOther03Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryOther03Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryOther06Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryOther06Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryOther12Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryOther12Month, VerInputIDTruebiz);
		SELF.Inquiry.InquiryOther24Month := calculateValueFor.checkTrueBiz(le.Inquiry.InquiryOther24Month, VerInputIDTruebiz);
		SELF.Public_Record.ucccount := calculateValueFor.checkTrueBiz(le.Public_Record.ucccount, VerInputIDTruebiz);
		SELF.Public_Record.UCCInitialFilingDateFirstSeen := calculateValueFor.checkTrueBiz(le.Public_Record.UCCInitialFilingDateFirstSeen, VerInputIDTruebiz);
		SELF.Public_Record.UCCInitialFilingDateLastSeen := calculateValueFor.checkTrueBiz(le.Public_Record.UCCInitialFilingDateLastSeen, VerInputIDTruebiz);
		SELF.Public_Record.UCCTimeOldest := calculateValueFor.checkTrueBiz(le.Public_Record.UCCTimeOldest, VerInputIDTruebiz);
		SELF.Public_Record.UCCTimeNewest := calculateValueFor.checkTrueBiz(le.Public_Record.UCCTimeNewest, VerInputIDTruebiz);
		SELF.Public_Record.UCCDateFirstSeen := calculateValueFor.checkTrueBiz(le.Public_Record.UCCDateFirstSeen, VerInputIDTruebiz);
		SELF.Public_Record.UCCDateLastSeen := calculateValueFor.checkTrueBiz(le.Public_Record.UCCDateLastSeen, VerInputIDTruebiz);
		SELF.Public_Record.UCCActiveCount := calculateValueFor.checkTrueBiz(le.Public_Record.UCCActiveCount, VerInputIDTruebiz);
		SELF.Public_Record.UCCTerminatedCount := calculateValueFor.checkTrueBiz(le.Public_Record.UCCTerminatedCount, VerInputIDTruebiz);
		SELF.Public_Record.UCCOtherCount := calculateValueFor.checkTrueBiz(le.Public_Record.UCCOtherCount, VerInputIDTruebiz);
    SELF.Public_Record.UCCRole := calculateValueFor.checkTrueBiz(le.Public_Record.UCCRole, VerInputIDTruebiz);
    SELF.Public_Record.UCCRoleActive := calculateValueFor.checkTrueBiz(le.Public_Record.UCCRoleActive, VerInputIDTruebiz);
		SELF.Public_Record.GovernmentDebarred := calculateValueFor.checkTrueBiz(le.Public_Record.GovernmentDebarred, VerInputIDTruebiz);

		// If BestSourceCount_TrueBiz <= 0, then we can't verify the best address existed as of the archive date, so we set
		// the fields based on best address to -1. 
		SELF.Best_Info.BestTypeAdvo := calculateValueFor.checkBestAddr(le.Best_Info.BestTypeAdvo, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestZipcodeType := calculateValueFor.checkBestAddr(le.Best_Info.BestZipcodeType, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestVacancy := calculateValueFor.checkBestAddr(le.Best_Info.BestVacancy, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestOwnership := calculateValueFor.checkBestAddr(le.Best_Info.BestOwnership, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestAssessedValue := calculateValueFor.checkBestAddr(le.Best_Info.BestAssessedValue, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestLotSize := calculateValueFor.checkBestAddr(le.Best_Info.BestLotSize, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestBldgSize := calculateValueFor.checkBestAddr(le.Best_Info.BestBldgSize, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestPhoneService := calculateValueFor.checkBestAddr(le.Best_Info.BestPhoneService, BestSourceCount_TrueBiz);
		SELF.Best_Info.BestTypeOther := calculateValueFor.checkBestAddr(le.Best_Info.BestTypeOther, BestSourceCount_TrueBiz);

		// If any of our data fetches didn't return results because it exceeded our limit, report it as a "Large Business"
		SELF.Data_Fetch_Indicators.LargeBusiness := IF(
				le.Data_Fetch_Indicators.FetchCodeABIUS = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeAircraft = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeBankruptcy = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeBBBMember = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeBBBNonMember = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeBusinessHeader = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeBusinessRegistration = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeCalBus = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeEBR5600 = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeCorporateFilings = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeDCA = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeDeadCo = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeDNBDMI = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeEDA = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeFBN = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeGovernmentDebarred = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeInquiries = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeInquiriesUpdate = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeIRSNonProfit = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeIRSRetirement = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeLien = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeOSHA = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeProperty = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeSBFE = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeTradelines = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeUCC = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeUtility = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeWatercraft = Business_Risk_BIP.Constants.LimitExceededErrorCode OR
				le.Data_Fetch_Indicators.FetchCodeYellowPages = Business_Risk_BIP.Constants.LimitExceededErrorCode,
			'1', '0');
		
		SELF := le;
	END;

	withFinalDelimitedFields := PROJECT(withBestAddrPhones, finalizeDelimitedFields(LEFT));

 // Add Verified input elements.
 withVerifiedInputElements := Business_Risk_BIP.getVerifiedElements(withFinalDelimitedFields, Options, linkingOptions, AllowedSourcesSet);
	
 // Add Scores and other Verification Indicators.
 TempShell := Business_Risk_BIP.getScoresAndIndicators( withVerifiedInputElements, Options );

	withConsumerHeader_noIds := JOIN(NoLinkIDsFound, consumerHeader_noIds, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																								PhoneNameMatchLevel := RIGHT.Verification.PhoneNameMismatch;
																								PhoneNameMismatch := MAP(PhoneNameMatchLevel = '-1' => '-1',
																																					PhoneNameMatchLevel = '0' => '0',
																																					PhoneNameMatchLevel = '1' => '4',
																																					PhoneNameMatchLevel = '2' => '3',
																																					PhoneNameMatchLevel = '3' => '2',
																																					PhoneNameMatchLevel = '4' => '1',
																																																			 '0');
																								SELF.Verification.PhoneNameMismatch := checkBlank(PhoneNameMismatch, '0', Business_Risk_BIP.Constants.BusShellVersion_v22);
																								SELF.Business_To_Person_Link.BusFEINPersonOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusFEINPersonOverlap, '0');
																								SELF.Business_To_Person_Link.BusFEINPersonAddrOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusFEINPersonAddrOverlap, '0');
																								SELF.Business_To_Person_Link.BusFEINPersonPhoneOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusFEINPersonPhoneOverlap, '0');
																								SELF.Business_To_Person_Link.BusAddrPersonNameOverlap := checkBlank(RIGHT.Business_To_Person_Link.BusAddrPersonNameOverlap, '0');
																								SELF.Verification.VerifiedConsumerName := RIGHT.Verification.VerifiedConsumerName;
																								SELF.Verification.VerifiedConsumerAddress1 := RIGHT.Verification.VerifiedConsumerAddress1;
																								SELF.Verification.VerifiedConsumerCity := RIGHT.Verification.VerifiedConsumerCity;
																								SELF.Verification.VerifiedConsumerState := RIGHT.Verification.VerifiedConsumerState;
																								SELF.Verification.VerifiedConsumerZip := RIGHT.Verification.VerifiedConsumerZip;
																								SELF.Verification.VerifiedConsumerFEIN := RIGHT.Verification.VerifiedConsumerFEIN;
																								SELF.Verification.VerifiedConsumerPhone := RIGHT.Verification.VerifiedConsumerPhone;
                                                SELF.Input_Characteristics.InputAddrConsumerCount := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, 
                                                                                            checkBlank(RIGHT.Input_Characteristics.InputAddrConsumerCount, '0'), '-1');
                                                SELF := LEFT),
																					LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	TempBlankShell := PROJECT(withConsumerHeader_noIds, Business_Risk_BIP.xfm_finalizeBlankShellFields(LEFT,Options.BusShellVersion));
	
	// Combine what we found in the shell with the inputs that we couldn't find a BIP Link ID for
	FinalShell_pre := SORT(TempShell + TempBlankShell, Seq);
	
	// Last, render blank the SBFE datarow if the DataPermissionMask restricts SBFE data.
	FinalShell_restricted := 
		PROJECT( FinalShell_pre, TRANSFORM( Business_Risk_BIP.Layouts.Shell, SELF.SBFE := [], SELF := LEFT ) );
		
	FinalShell_v20 := PROJECT(FinalShell_pre, Business_Risk_BIP.xfm_blankOutSBFEEnhancementAttrs(LEFT));

	FinalShell := MAP( restrict_sbfe 								 																							=> FinalShell_restricted, // If SBFE data not allowed, blank all SBFE fields
										 Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v20 => FinalShell_v20,				// If Business shell v2 is requested, blank out SBFE enhancement (v2.1) attributes
																																																	 FinalShell_pre );
																																																	 
	FinalShell_rolled := IF(Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v22, FinalShell, modInp.fn_PopulateAltCompanyNameFields(FinalShell));																																																 
	
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(InputOrig, 100), NAMED('Sample_InputOrig'));
	// OUTPUT(CHOOSEN(Input, 100), NAMED('Sample_Input'));
	// OUTPUT(CHOOSEN(cleanedInput, 100), NAMED('Sample_cleanedInput'));
	// OUTPUT(CHOOSEN(prepDIDAppend, 100), NAMED('Sample_prepDIDAppend'));
	// OUTPUT(CHOOSEN(DIDAppend, 100), NAMED('Sample_DIDAppend'));
	// OUTPUT(CHOOSEN(withDID, 100), NAMED('Sample_withDID'));
	// OUTPUT(CHOOSEN(prepBIPAppend, 100), NAMED('Sample_PrepBIPAppend'));
	// OUTPUT(CHOOSEN(BIPAppend, 100), NAMED('Sample_BIPAppend'));
	// OUTPUT(CHOOSEN(withBIP, 100), NAMED('Sample_withBIP'));
	// OUTPUT(CHOOSEN(LinkIDsFound, 100), NAMED('Sample_LinkIDsFound'));
	// OUTPUT(CHOOSEN(withBusinessHeader, 100), NAMED('Sample_withBusinessHeader'));
	// OUTPUT(CHOOSEN(withOSHA, 100), NAMED('Sample_withOSHA'));
	// OUTPUT(CHOOSEN(withBankruptcy, 100), NAMED('Sample_withBankruptcy'));
	// OUTPUT(CHOOSEN(withProperty, 100), NAMED('Sample_withProperty'));
	// OUTPUT(CHOOSEN(withEDA, 100), NAMED('Sample_withEDA'));
	// OUTPUT(CHOOSEN(withTradelines, 100), NAMED('Sample_withTradelines'));
	// OUTPUT(CHOOSEN(withInquiries, 100), NAMED('Sample_withInquiries'));
	// OUTPUT(CHOOSEN(withOther, 100), NAMED('Sample_withOther'));
	// OUTPUT(CHOOSEN(withCorporateFilings, 100), NAMED('Sample_withCorporateFilings'));
	// OUTPUT(CHOOSEN(TempShell, 100), NAMED('Sample_TempShell'));
	
	/* The  following Debugs are useful for evaluating the AltCompanyName changes (RR-10930). */
	// OUTPUT( CHOOSEN(modInp.InputOrigResequencedPlusOrigSeq, 100), NAMED('InputOrigResequencedPlusOrigSeq') );
	
	// TempShell_pre_slim := PROJECT( CHOOSEN(TempShell_pre, 100), modInp.xfm_slimShellResults(LEFT) );
	// OUTPUT( TempShell_pre_slim, NAMED('before_rollup') );
	
	// TempShell_slim := PROJECT( CHOOSEN(TempShell, 100), modInp.xfm_slimShellResults(LEFT) );
	// OUTPUT( TempShell_slim, NAMED('after_rollup') );
	

	RETURN FinalShell_rolled;
END;