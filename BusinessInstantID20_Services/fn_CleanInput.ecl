IMPORT Address, BizLinkFull, Business_Risk_BIP, Risk_Indicators, RiskWise, STD, ut;

	// The following function cleans the input data for the Business and the Authorized Reps:
	//   o   CompanyName and Name
	//   o   Address
	//   o   Phone
	//   o   SSN and FEIN
	//   o   DOB, Age, DL Number
	EXPORT fn_CleanInput( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input ) := 
		FUNCTION
			UCase := STD.Str.ToUpperCase;
			
			BusinessInstantID20_Services.layouts.InputAuthRepInfoClean xfm_CleanAuthReps(BusinessInstantID20_Services.layouts.InputAuthRepInfo le) :=
				TRANSFORM
					BOOLEAN useNew := TRUE;
					BOOLEAN validCleaned := TRIM(le.FullName) <> '';

					// Clean up the Auth Rep Name, Auth Rep Address, SSN, Auth Rep Phone, etc.
					_CleanName     := Address.CleanPerson73(le.FullName);
					_Clean_phone10 := RiskWise.CleanPhone(le.Phone10);
					_Clean_SSN     := StringLib.StringFilter(le.SSN, '0123456789');
					_Clean_dob     := Riskwise.cleandob(le.DateOfBirth);
					_Clean_age     := IF( (UNSIGNED4)le.Age = 0 AND (UNSIGNED4)_Clean_dob != 0,(STRING3)ut.Age((UNSIGNED4)_Clean_dob), (le.Age) );
					_Clean_dl_num  := Riskwise.cleanDL_num(le.DLNumber);
					_Address       := Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1 + ' ' + le.StreetAddress2);
					_CleanAddr     := Risk_Indicators.MOD_AddressClean.clean_addr(_Address, le.City, le.State, le.Zip);											
					mod_Addr       := Address.CleanFields(_CleanAddr);
					mod_Name       := Address.CleanNameFields(_CleanName);
					_FirstName     := IF( le.FirstName = '' AND validCleaned, mod_Name.FName, le.FirstName );
					
					SELF.Rep_WhichOne       := le.Rep_WhichOne;
					SELF.FullName           := TRIM(UCase(le.FullName), LEFT, RIGHT);
					SELF.NameTitle          := TRIM(UCase(IF(le.NameTitle = '' AND validCleaned, mod_Name.Title, le.NameTitle)), LEFT, RIGHT);
					SELF.FirstName          := TRIM(UCase(_FirstName));
					SELF.MiddleName         := TRIM(UCase(IF(le.MiddleName = '' AND validCleaned,	mod_Name.MName, le.MiddleName)), LEFT, RIGHT);
					SELF.LastName           := TRIM(UCase(IF(le.LastName = '' AND validCleaned, mod_Name.LName, le.LastName)), LEFT, RIGHT);
					SELF.NameSuffix         := TRIM(UCase(IF(le.NameSuffix = '' AND validCleaned,	mod_Name.Name_Suffix, le.NameSuffix)), LEFT, RIGHT);
					SELF.FormerLastName     := TRIM(UCase(le.FormerLastName), LEFT, RIGHT);
					SELF.StreetAddress1     := TRIM(UCase(le.StreetAddress1));
					SELF.StreetAddress2     := TRIM(UCase(le.StreetAddress2));
					SELF.City               := TRIM(UCase(le.City));
					SELF.State              := TRIM(UCase(le.State));
					SELF.Zip                := le.Zip;
					
					BusinessInstantID20_Services.Macros.mac_AppendAddrData() // cleaned
					
					SELF.SSN                := IF(LENGTH(_Clean_SSN) != 9 OR (INTEGER)_Clean_SSN <= 0, '', _Clean_SSN); // Filter out SSN's that aren't 9-Bytes, or are repeating 0's
					SELF.DateOfBirth        := _Clean_dob;
					SELF.Age                := _Clean_age;
					SELF.DLNumber           := _Clean_dl_num;
					SELF.Phone10            := _Clean_phone10;
					SELF := le;
					SELF := [];
				END;
			
			BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean xfm_CleanInput(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo le) :=
				TRANSFORM
					// Clean up the Company Name, Company Address, FEIN, and Company Phone.
					_CompanyName   := IF(le.CompanyName <> '', BizLinkFull.Fields.Make_cnp_name(le.CompanyName), BizLinkFull.Fields.Make_cnp_name(le.AltCompanyName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
					_Clean_FEIN    := StringLib.StringFilter(le.FEIN, '0123456789');
					_Clean_phone10 := RiskWise.CleanPhone(le.Phone10);
					_Address       := Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1 + ' ' + le.StreetAddress2);
					_CleanAddr     := Risk_Indicators.MOD_AddressClean.clean_addr(_Address, le.City, le.State, le.Zip);											
					mod_Addr       := Address.CleanFields(_CleanAddr);

					SELF.Seq            := le.Seq;
					SELF.AcctNo         := le.AcctNo;
					SELF.HistoryDate    := IF(le.HistoryDate <= 0, (INTEGER)Business_Risk_BIP.Constants.NinesDate, le.HistoryDate); // If HistoryDate not populated run in "realtime" mode
					SELF.CompanyName    := TRIM(UCase(_CompanyName));
					SELF.AltCompanyName := IF(le.CompanyName <> '', BizLinkFull.Fields.Make_cnp_name(le.AltCompanyName), ''); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line
					SELF.StreetAddress1 := TRIM(UCase(le.StreetAddress1));
					SELF.StreetAddress2 := TRIM(UCase(le.StreetAddress2));
					SELF.City           := TRIM(UCase(le.City));
					SELF.State          := TRIM(UCase(le.State));
					SELF.Zip            := le.Zip;			
					
					BusinessInstantID20_Services.Macros.mac_AppendAddrData() // cleaned
					
					SELF.FEIN           := IF( LENGTH(_Clean_FEIN) != 9 OR (INTEGER)_Clean_FEIN <= 0, '', _Clean_FEIN); // Filter out FEIN's that aren't 9-Bytes, or are repeating 0's
					SELF.Phone10        := _Clean_phone10;
					
					SELF.AuthReps       := PROJECT( le.AuthReps, xfm_CleanAuthReps(LEFT) );
					SELF := le;
					SELF := [];
				END;
			
			ds_CleanedInput_pre := PROJECT( ds_input, xfm_CleanInput(LEFT) );
			
			// Remove any Auth Rep records that are blank or invalid.
			ds_CleanedInput := 
				PROJECT( 
					ds_CleanedInput_pre, 
					TRANSFORM( BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean,
						SELF.AuthReps := LEFT.AuthReps( LastName != '' ),
						SELF := LEFT,
						SELF := []
					) );
			
			RETURN ds_CleanedInput;
		
		END;