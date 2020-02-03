IMPORT Address, BizLinkFull, Business_Header, Business_Risk_BIP, NID, RiskWise, Risk_Indicators, ut, STD;

EXPORT fn_CleanInput(DATASET(Business_Risk_BIP.Layouts.Input) Input,
                      Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := FUNCTION

	// Function to blank out attributes that are not to be returned in the requested business shell version.
	checkVersion(STRING field, UNSIGNED minVersion = 2) := IF(Options.BusShellVersion < minVersion, '', field);

	// Make sure that something is populated, even if we don't get a hit on the key, and verify that the attribute is included in the version we are running
	checkBlank(STRING field, STRING default_val, UNSIGNED minVersion = 2) := 
			MAP(Options.BusShellVersion < minVersion => '', field = '' => default_val, field);

	calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);

	// Clean up the input - parse the name, address, clean SSN, clean Phone, etc.
	Business_Risk_BIP.Layouts.Shell xfm_cleanInput(Business_Risk_BIP.Layouts.Input le, UNSIGNED2 seqCounter) := TRANSFORM
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
			SELF.Clean_Input.StreetAddress2 := TRIM(STD.Str.ToUppercase(le.StreetAddress2));
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
			filteredFEIN := STD.Str.Filter(le.FEIN, '0123456789');
			SELF.Clean_Input.FEIN := IF(LENGTH(filteredFEIN) != 9 OR (INTEGER)filteredFEIN <= 0, '', filteredFEIN); // Filter out FEIN's that aren't 9-Bytes, or are repeating 0's
			BusPhone10 := RiskWise.CleanPhone(le.Phone10);
			SELF.Clean_Input.Phone10 := BusPhone10;
			SELF.Clean_Input.IPAddr := STD.Str.Filter(le.IPAddr, '0123456789.');
			SELF.Clean_Input.CompanyURL := REGEXREPLACE('^WWW[. ]{0,1}',TRIM(REGEXREPLACE('[:/].*$',REGEXREPLACE('HTTP://',le.CompanyURL,'',NOCASE),''),LEFT,RIGHT),'',NOCASE);
			SELF.Clean_Input.SIC := STD.Str.Filter(le.SIC, '0123456789');
			SELF.Clean_Input.NAIC := STD.Str.Filter(le.NAIC, '0123456789');
			// Authorized Representative Name Fields
			cleanedName := Address.CleanPerson73(le.Rep_FullName);
			cleanedRepName := Address.CleanNameFields(cleanedName);
			BOOLEAN validCleaned := TRIM(le.Rep_FullName) <> '';
			SELF.Clean_Input.Rep_FullName := STD.Str.ToUpperCase(le.Rep_FullName);
			SELF.Clean_Input.Rep_NameTitle := TRIM(STD.Str.ToUppercase(IF(le.Rep_NameTitle = '' AND validCleaned,		cleanedRepName.Title, le.Rep_NameTitle)), LEFT, RIGHT);
			RepFirstName := TRIM(STD.Str.ToUppercase(IF(le.Rep_FirstName = '' AND validCleaned,		cleanedRepName.FName, le.Rep_FirstName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep_FirstName := RepFirstName;
			RepPreferredFirstName := STD.Str.ToUpperCase(NID.PreferredFirstNew(RepFirstName, TRUE /*UseNew*/));
			SELF.Clean_Input.Rep_PreferredFirstName := RepPreferredFirstName;
			SELF.Clean_Input.Rep_MiddleName := TRIM(STD.Str.ToUppercase(IF(le.Rep_MiddleName = '' AND validCleaned,	cleanedRepName.MName, le.Rep_MiddleName)), LEFT, RIGHT);
			RepLastName := TRIM(STD.Str.ToUppercase(IF(le.Rep_LastName = '' AND validCleaned,			cleanedRepName.LName, le.Rep_LastName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep_LastName := RepLastName;
			SELF.Clean_Input.Rep_NameSuffix := TRIM(STD.Str.ToUppercase(IF(le.Rep_NameSuffix = '' AND validCleaned,	cleanedRepName.Name_Suffix, le.Rep_NameSuffix)), LEFT, RIGHT);
			SELF.Clean_Input.Rep_FormerLastName := TRIM(STD.Str.ToUppercase(le.Rep_FormerLastName), LEFT, RIGHT);
			// Authorized Representative Address Fields
			repAddress := Risk_Indicators.MOD_AddressClean.street_address(le.Rep_StreetAddress1 + ' ' + le.Rep_StreetAddress2, le.Rep_Prim_Range, le.Rep_Predir, le.Rep_Prim_Name, le.Rep_Addr_Suffix, le.Rep_Postdir, le.Rep_Unit_Desig, le.Rep_Sec_Range);
			repCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(repAddress, le.Rep_City, le.Rep_State, le.Rep_Zip);
			cleanedRepAddress := Address.CleanFields(repCleanAddr);
			SELF.Clean_Input.Rep_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRepAddress.Prim_Range, cleanedRepAddress.Predir, cleanedRepAddress.Prim_Name,
																												cleanedRepAddress.Addr_Suffix, cleanedRepAddress.Postdir, cleanedRepAddress.Unit_Desig, cleanedRepAddress.Sec_Range);
			SELF.Clean_Input.Rep_StreetAddress2 := TRIM(STD.Str.ToUppercase(le.Rep_StreetAddress2));
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
			filteredSSN := STD.Str.Filter(le.Rep_SSN, '0123456789');
			SELF.Clean_Input.Rep_SSN := IF(LENGTH(filteredSSN) != 9 OR (INTEGER)filteredSSN <= 0, '', filteredSSN); // Filter out SSN's that aren't 9-Bytes, or are repeating 0's
			SELF.Clean_Input.Rep_DateOfBirth := RiskWise.CleanDOB(le.Rep_DateOfBirth);
			RepPhone10 := RiskWise.CleanPhone(le.Rep_Phone10);
			SELF.Clean_Input.Rep_Phone10 := RepPhone10;
			SELF.Clean_Input.Rep_Age := IF((INTEGER)le.Rep_Age = 0 AND (INTEGER)le.Rep_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep_DateOfBirth), (le.Rep_Age));
			SELF.Clean_Input.Rep_DLNumber := RiskWise.CleanDL_Num(le.Rep_DLNumber);
			SELF.Clean_Input.Rep_DLState := STD.Str.ToUpperCase(TRIM(le.Rep_DLState, LEFT, RIGHT));
			SELF.Clean_Input.Rep_Email := STD.Str.ToUpperCase(TRIM(le.Rep_Email, LEFT, RIGHT));
			SELF.Clean_Input.Rep_BusinessTitle := STD.Str.ToUpperCase(TRIM(le.Rep_BusinessTitle, LEFT, RIGHT));

			// Authorized Representative 2 Name Fields
			cleanedNameRep2 := Address.CleanPerson73(le.Rep2_FullName);
			cleanedRep2Name := Address.CleanNameFields(cleanedNameRep2);
			BOOLEAN validCleanedRep2 := TRIM(le.Rep2_FullName) <> '';
			SELF.Clean_Input.Rep2_FullName := STD.Str.ToUpperCase(le.Rep2_FullName);
			SELF.Clean_Input.Rep2_NameTitle := TRIM(STD.Str.ToUppercase(IF(le.Rep2_NameTitle = '' AND validCleanedRep2,		cleanedRep2Name.Title, le.Rep2_NameTitle)), LEFT, RIGHT);
			Rep2FirstName := TRIM(STD.Str.ToUppercase(IF(le.Rep2_FirstName = '' AND validCleanedRep2,		cleanedRep2Name.FName, le.Rep2_FirstName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep2_FirstName := Rep2FirstName;
			Rep2PreferredFirstName := STD.Str.ToUpperCase(NID.PreferredFirstNew(Rep2FirstName, TRUE /*UseNew*/));
			SELF.Clean_Input.Rep2_PreferredFirstName := Rep2PreferredFirstName;
			SELF.Clean_Input.Rep2_MiddleName := TRIM(STD.Str.ToUppercase(IF(le.Rep2_MiddleName = '' AND validCleanedRep2,	cleanedRep2Name.MName, le.Rep2_MiddleName)), LEFT, RIGHT);
			Rep2LastName := TRIM(STD.Str.ToUppercase(IF(le.Rep2_LastName = '' AND validCleanedRep2,			cleanedRep2Name.LName, le.Rep2_LastName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep2_LastName := Rep2LastName;
			SELF.Clean_Input.Rep2_NameSuffix := TRIM(STD.Str.ToUppercase(IF(le.Rep2_NameSuffix = '' AND validCleanedRep2,	cleanedRep2Name.Name_Suffix, le.Rep2_NameSuffix)), LEFT, RIGHT);
			SELF.Clean_Input.Rep2_FormerLastName := TRIM(STD.Str.ToUppercase(le.Rep2_FormerLastName), LEFT, RIGHT);
			// Authorized Representative 2 Address Fields
			rep2Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep2_StreetAddress1 + ' ' + le.Rep2_StreetAddress2, le.Rep2_Prim_Range, le.Rep2_Predir, le.Rep2_Prim_Name, le.Rep2_Addr_Suffix, le.Rep2_Postdir, le.Rep2_Unit_Desig, le.Rep2_Sec_Range);
			Rep2CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(rep2Address, le.Rep2_City, le.Rep2_State, le.Rep2_Zip);
			cleanedRep2Address := Address.CleanFields(Rep2CleanAddr);
			SELF.Clean_Input.Rep2_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep2Address.Prim_Range, cleanedRep2Address.Predir, cleanedRep2Address.Prim_Name,
																												cleanedRep2Address.Addr_Suffix, cleanedRep2Address.Postdir, cleanedRep2Address.Unit_Desig, cleanedRep2Address.Sec_Range);
			SELF.Clean_Input.Rep2_StreetAddress2 := TRIM(STD.Str.ToUppercase(le.Rep2_StreetAddress2));
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
			filteredSSNRep2 := STD.Str.Filter(le.Rep2_SSN, '0123456789');
			SELF.Clean_Input.Rep2_SSN := IF(LENGTH(filteredSSNRep2) != 9 OR (INTEGER)filteredSSNRep2 <= 0, '', filteredSSNRep2); // Filter out SSN's that aren't 9-Bytes, or are Rep2eating 0's
			SELF.Clean_Input.Rep2_DateOfBirth := RiskWise.CleanDOB(le.Rep2_DateOfBirth);
			Rep2Phone10 := RiskWise.CleanPhone(le.Rep2_Phone10);
			SELF.Clean_Input.Rep2_Phone10 := Rep2Phone10;
			SELF.Clean_Input.Rep2_Age := IF((INTEGER)le.Rep2_Age = 0 AND (INTEGER)le.Rep2_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep2_DateOfBirth), (le.Rep2_Age));
			SELF.Clean_Input.Rep2_DLNumber := RiskWise.CleanDL_Num(le.Rep2_DLNumber);
			SELF.Clean_Input.Rep2_DLState := STD.Str.ToUpperCase(TRIM(le.Rep2_DLState, LEFT, RIGHT));
			SELF.Clean_Input.Rep2_Email := STD.Str.ToUpperCase(TRIM(le.Rep2_Email, LEFT, RIGHT));
			SELF.Clean_Input.Rep2_BusinessTitle := STD.Str.ToUpperCase(TRIM(le.Rep2_BusinessTitle, LEFT, RIGHT));

			// Authorized Representative 3 Name Fields
			cleanedNameRep3 := Address.CleanPerson73(le.Rep3_FullName);
			cleanedRep3Name := Address.CleanNameFields(cleanedNameRep3);
			BOOLEAN validCleanedRep3 := TRIM(le.Rep3_FullName) <> '';
			SELF.Clean_Input.Rep3_FullName := STD.Str.ToUpperCase(le.Rep3_FullName);
			SELF.Clean_Input.Rep3_NameTitle := TRIM(STD.Str.ToUppercase(IF(le.Rep3_NameTitle = '' AND validCleanedRep3,		cleanedRep3Name.Title, le.Rep3_NameTitle)), LEFT, RIGHT);
			Rep3FirstName := TRIM(STD.Str.ToUppercase(IF(le.Rep3_FirstName = '' AND validCleanedRep3,		cleanedRep3Name.FName, le.Rep3_FirstName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep3_FirstName := Rep3FirstName;
			Rep3PreferredFirstName := STD.Str.ToUpperCase(NID.PreferredFirstNew(Rep3FirstName, TRUE /*UseNew*/));
			SELF.Clean_Input.Rep3_PreferredFirstName := Rep3PreferredFirstName;
			SELF.Clean_Input.Rep3_MiddleName := TRIM(STD.Str.ToUppercase(IF(le.Rep3_MiddleName = '' AND validCleanedRep3,	cleanedRep3Name.MName, le.Rep3_MiddleName)), LEFT, RIGHT);
			Rep3LastName := TRIM(STD.Str.ToUppercase(IF(le.Rep3_LastName = '' AND validCleanedRep3,			cleanedRep3Name.LName, le.Rep3_LastName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep3_LastName := Rep3LastName;
			SELF.Clean_Input.Rep3_NameSuffix := TRIM(STD.Str.ToUppercase(IF(le.Rep3_NameSuffix = '' AND validCleanedRep3,	cleanedRep3Name.Name_Suffix, le.Rep3_NameSuffix)), LEFT, RIGHT);
			SELF.Clean_Input.Rep3_FormerLastName := TRIM(STD.Str.ToUppercase(le.Rep3_FormerLastName), LEFT, RIGHT);
			// Authorized Representative 3 Address Fields
			Rep3Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep3_StreetAddress1 + ' ' + le.Rep3_StreetAddress2, le.Rep3_Prim_Range, le.Rep3_Predir, le.Rep3_Prim_Name, le.Rep3_Addr_Suffix, le.Rep3_Postdir, le.Rep3_Unit_Desig, le.Rep3_Sec_Range);
			Rep3CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(Rep3Address, le.Rep3_City, le.Rep3_State, le.Rep3_Zip);
			cleanedRep3Address := Address.CleanFields(Rep3CleanAddr);
			SELF.Clean_Input.Rep3_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep3Address.Prim_Range, cleanedRep3Address.Predir, cleanedRep3Address.Prim_Name,
																												cleanedRep3Address.Addr_Suffix, cleanedRep3Address.Postdir, cleanedRep3Address.Unit_Desig, cleanedRep3Address.Sec_Range);
			SELF.Clean_Input.Rep3_StreetAddress2 := TRIM(STD.Str.ToUppercase(le.Rep3_StreetAddress2));
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
			filteredSSNRep3 := STD.Str.Filter(le.Rep3_SSN, '0123456789');
			SELF.Clean_Input.Rep3_SSN := IF(LENGTH(filteredSSNRep3) != 9 OR (INTEGER)filteredSSNRep3 <= 0, '', filteredSSNRep3); // Filter out SSN's that aren't 9-Bytes, or are Rep3eating 0's
			SELF.Clean_Input.Rep3_DateOfBirth := RiskWise.CleanDOB(le.Rep3_DateOfBirth);
			Rep3Phone10 := RiskWise.CleanPhone(le.Rep3_Phone10);
			SELF.Clean_Input.Rep3_Phone10 := Rep3Phone10;
			SELF.Clean_Input.Rep3_Age := IF((INTEGER)le.Rep3_Age = 0 AND (INTEGER)le.Rep3_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep3_DateOfBirth), (le.Rep3_Age));
			SELF.Clean_Input.Rep3_DLNumber := RiskWise.CleanDL_Num(le.Rep3_DLNumber);
			SELF.Clean_Input.Rep3_DLState := STD.Str.ToUpperCase(TRIM(le.Rep3_DLState, LEFT, RIGHT));
			SELF.Clean_Input.Rep3_Email := STD.Str.ToUpperCase(TRIM(le.Rep3_Email, LEFT, RIGHT));
			SELF.Clean_Input.Rep3_BusinessTitle := STD.Str.ToUpperCase(TRIM(le.Rep3_BusinessTitle, LEFT, RIGHT));

		// Authorized Representative 4 Name Fields
			cleanedNameRep4 := Address.CleanPerson73(le.Rep4_FullName);
			cleanedRep4Name := Address.CleanNameFields(cleanedNameRep4);
			BOOLEAN validCleanedRep4 := TRIM(le.Rep4_FullName) <> '';
			SELF.Clean_Input.Rep4_FullName := STD.Str.ToUpperCase(le.Rep4_FullName);
			SELF.Clean_Input.Rep4_NameTitle := TRIM(STD.Str.ToUppercase(IF(le.Rep4_NameTitle = '' AND validCleanedRep4,		cleanedRep4Name.Title, le.Rep4_NameTitle)), LEFT, RIGHT);
			Rep4FirstName := TRIM(STD.Str.ToUppercase(IF(le.Rep4_FirstName = '' AND validCleanedRep4,		cleanedRep4Name.FName, le.Rep4_FirstName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep4_FirstName := Rep4FirstName;
			Rep4PreferredFirstName := STD.Str.ToUpperCase(NID.PreferredFirstNew(Rep4FirstName, TRUE /*UseNew*/));
			SELF.Clean_Input.Rep4_PreferredFirstName := Rep4PreferredFirstName;
			SELF.Clean_Input.Rep4_MiddleName := TRIM(STD.Str.ToUppercase(IF(le.Rep4_MiddleName = '' AND validCleanedRep4,	cleanedRep4Name.MName, le.Rep4_MiddleName)), LEFT, RIGHT);
			Rep4LastName := TRIM(STD.Str.ToUppercase(IF(le.Rep4_LastName = '' AND validCleanedRep4,			cleanedRep4Name.LName, le.Rep4_LastName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep4_LastName := Rep4LastName;
			SELF.Clean_Input.Rep4_NameSuffix := TRIM(STD.Str.ToUppercase(IF(le.Rep4_NameSuffix = '' AND validCleanedRep4,	cleanedRep4Name.Name_Suffix, le.Rep4_NameSuffix)), LEFT, RIGHT);
			SELF.Clean_Input.Rep4_FormerLastName := TRIM(STD.Str.ToUppercase(le.Rep4_FormerLastName), LEFT, RIGHT);
			// Authorized Representative 4 Address Fields
			rep4Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep4_StreetAddress1 + ' ' + le.Rep4_StreetAddress2, le.Rep4_Prim_Range, le.Rep4_Predir, le.Rep4_Prim_Name, le.Rep4_Addr_Suffix, le.Rep4_Postdir, le.Rep4_Unit_Desig, le.Rep4_Sec_Range);
			Rep4CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(rep4Address, le.Rep4_City, le.Rep4_State, le.Rep4_Zip);
			cleanedRep4Address := Address.CleanFields(Rep4CleanAddr);
			SELF.Clean_Input.Rep4_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep4Address.Prim_Range, cleanedRep4Address.Predir, cleanedRep4Address.Prim_Name,
																												cleanedRep4Address.Addr_Suffix, cleanedRep4Address.Postdir, cleanedRep4Address.Unit_Desig, cleanedRep4Address.Sec_Range);
			SELF.Clean_Input.Rep4_StreetAddress2 := TRIM(STD.Str.ToUppercase(le.Rep4_StreetAddress2));
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
			filteredSSNRep4 := STD.Str.Filter(le.Rep4_SSN, '0123456789');
			SELF.Clean_Input.Rep4_SSN := IF(LENGTH(filteredSSNRep4) != 9 OR (INTEGER)filteredSSNRep4 <= 0, '', filteredSSNRep4); // Filter out SSN's that aren't 9-Bytes, or are Rep2eating 0's
			SELF.Clean_Input.Rep4_DateOfBirth := RiskWise.CleanDOB(le.Rep4_DateOfBirth);
			Rep4Phone10 := RiskWise.CleanPhone(le.Rep4_Phone10);
			SELF.Clean_Input.Rep4_Phone10 := Rep4Phone10;
			SELF.Clean_Input.Rep4_Age := IF((INTEGER)le.Rep4_Age = 0 AND (INTEGER)le.Rep4_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep4_DateOfBirth), (le.Rep4_Age));
			SELF.Clean_Input.Rep4_DLNumber := RiskWise.CleanDL_Num(le.Rep4_DLNumber);
			SELF.Clean_Input.Rep4_DLState := STD.Str.ToUpperCase(TRIM(le.Rep4_DLState, LEFT, RIGHT));
			SELF.Clean_Input.Rep4_Email := STD.Str.ToUpperCase(TRIM(le.Rep4_Email, LEFT, RIGHT));
			SELF.Clean_Input.Rep4_BusinessTitle := STD.Str.ToUpperCase(TRIM(le.Rep4_BusinessTitle, LEFT, RIGHT));

		// Authorized Representative 5 Name Fields
			cleanedNameRep5 := Address.CleanPerson73(le.Rep5_FullName);
			cleanedRep5Name := Address.CleanNameFields(cleanedNameRep5);
			BOOLEAN validCleanedRep5 := TRIM(le.Rep5_FullName) <> '';
			SELF.Clean_Input.Rep5_FullName := STD.Str.ToUpperCase(le.Rep5_FullName);
			SELF.Clean_Input.Rep5_NameTitle := TRIM(STD.Str.ToUppercase(IF(le.Rep5_NameTitle = '' AND validCleanedRep5,		cleanedRep5Name.Title, le.Rep5_NameTitle)), LEFT, RIGHT);
			Rep5FirstName := TRIM(STD.Str.ToUppercase(IF(le.Rep5_FirstName = '' AND validCleanedRep5,		cleanedRep5Name.FName, le.Rep5_FirstName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep5_FirstName := Rep5FirstName;
			Rep5PreferredFirstName := STD.Str.ToUpperCase(NID.PreferredFirstNew(Rep5FirstName, TRUE /*UseNew*/));
			SELF.Clean_Input.Rep5_PreferredFirstName := Rep5PreferredFirstName;
			SELF.Clean_Input.Rep5_MiddleName := TRIM(STD.Str.ToUppercase(IF(le.Rep5_MiddleName = '' AND validCleanedRep5,	cleanedRep5Name.MName, le.Rep5_MiddleName)), LEFT, RIGHT);
			Rep5LastName := TRIM(STD.Str.ToUppercase(IF(le.Rep5_LastName = '' AND validCleanedRep5,			cleanedRep5Name.LName, le.Rep5_LastName)), LEFT, RIGHT);
			SELF.Clean_Input.Rep5_LastName := Rep5LastName;
			SELF.Clean_Input.Rep5_NameSuffix := TRIM(STD.Str.ToUppercase(IF(le.Rep5_NameSuffix = '' AND validCleanedRep5,	cleanedRep5Name.Name_Suffix, le.Rep5_NameSuffix)), LEFT, RIGHT);
			SELF.Clean_Input.Rep5_FormerLastName := TRIM(STD.Str.ToUppercase(le.Rep5_FormerLastName), LEFT, RIGHT);
			// Authorized Representative 5 Address Fields
			rep5Address := Risk_Indicators.MOD_AddressClean.street_address(le.Rep5_StreetAddress1 + ' ' + le.Rep5_StreetAddress2, le.Rep5_Prim_Range, le.Rep5_Predir, le.Rep5_Prim_Name, le.Rep5_Addr_Suffix, le.Rep5_Postdir, le.Rep5_Unit_Desig, le.Rep5_Sec_Range);
			Rep5CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(rep5Address, le.Rep5_City, le.Rep5_State, le.Rep5_Zip);
			cleanedRep5Address := Address.CleanFields(Rep5CleanAddr);
			SELF.Clean_Input.Rep5_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRep5Address.Prim_Range, cleanedRep5Address.Predir, cleanedRep5Address.Prim_Name,
																												cleanedRep5Address.Addr_Suffix, cleanedRep5Address.Postdir, cleanedRep5Address.Unit_Desig, cleanedRep5Address.Sec_Range);
			SELF.Clean_Input.Rep5_StreetAddress2 := TRIM(STD.Str.ToUppercase(le.Rep5_StreetAddress2));
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
			filteredSSNRep5 := STD.Str.Filter(le.Rep5_SSN, '0123456789');
			SELF.Clean_Input.Rep5_SSN := IF(LENGTH(filteredSSNRep5) != 9 OR (INTEGER)filteredSSNRep5 <= 0, '', filteredSSNRep5); // Filter out SSN's that aren't 9-Bytes, or are Rep2eating 0's
			SELF.Clean_Input.Rep5_DateOfBirth := RiskWise.CleanDOB(le.Rep5_DateOfBirth);
			Rep5Phone10 := RiskWise.CleanPhone(le.Rep5_Phone10);
			SELF.Clean_Input.Rep5_Phone10 := Rep5Phone10;
			SELF.Clean_Input.Rep5_Age := IF((INTEGER)le.Rep5_Age = 0 AND (INTEGER)le.Rep5_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep5_DateOfBirth), (le.Rep5_Age));
			SELF.Clean_Input.Rep5_DLNumber := RiskWise.CleanDL_Num(le.Rep5_DLNumber);
			SELF.Clean_Input.Rep5_DLState := STD.Str.ToUpperCase(TRIM(le.Rep5_DLState, LEFT, RIGHT));
			SELF.Clean_Input.Rep5_Email := STD.Str.ToUpperCase(TRIM(le.Rep5_Email, LEFT, RIGHT));
			SELF.Clean_Input.Rep5_BusinessTitle := STD.Str.ToUpperCase(TRIM(le.Rep5_BusinessTitle, LEFT, RIGHT));

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

	cleanedInput := PROJECT(Input, xfm_cleanInput(LEFT, COUNTER));
	
	RETURN cleanedInput;
END;