IMPORT Address, Gateway, Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT, STD;

EXPORT Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout Phone_Shell_Function (DATASET(Phone_Shell.Layout_Phone_Shell.Input) Input,
																																							 DATASET(Gateway.Layouts.Config) Gateways = DATASET([], Gateway.Layouts.Config),
																																							 UNSIGNED1 GLBPurpose = 0,
																																						 	UNSIGNED1 DPPAPurpose = 0,
																																						 	STRING50 DataRestrictionMask = Phone_Shell.Constants.default_DataRestriction,
																																						 	STRING50 DataPermissionMask = Phone_Shell.Constants.Default_DataPermission,
																																						 	UNSIGNED1 PhoneRestrictionMaskTemp = Phone_Shell.Constants.PRM.AllPhones,
																																						 	UNSIGNED3 MaxPhones = Phone_Shell.Constants.Default_MaxPhones,
																																						 	UNSIGNED3 InsuranceVerificationAgeLimit = Phone_Shell.Constants.Default_InsuranceVerificationAgeLimit,
																																							 UNSIGNED2 PhoneShellVersion = 10, // use 2-digit notation (10 = phone shell version 1.0)
																																						 	STRING2 SPIIAccessLevel = Phone_Shell.Constants.Default_SPIIAccessLevel, // 5A or 5B - used in TransUnion Gateway
																																						 	STRING30 VerticalMarket = '', // Example: 'Receivables Management' restricts certain Gateways
																																						 	STRING30 IndustryClass = '', // Example: 'UTILI' restricts the Utility Data Search
																																							 INTEGER RelocationsMaxDaysBefore = Relocations.wdtg.default_daysBefore, 
																																							 INTEGER RelocationsMaxDaysAfter = Relocations.wdtg.default_daysAfter, 
																																							 INTEGER RelocationsTargetRadius = Relocations.wdtg.default_radius,
																																							 BOOLEAN IncludeLastResort = FALSE, // Include Phones of Last Resort Phones Plus Royalty Dataset (There is a cost associated with this)
																																							 BOOLEAN IncludePhonesFeedback = FALSE,
																																							 // Boca Shell Options
																																							 BOOLEAN includeRel = TRUE,
																																							 BOOLEAN includeDL = FALSE,
																																							 BOOLEAN includeVeh = FALSE,
																																							 BOOLEAN includeDerog = TRUE,
																																							 BOOLEAN ofac_only = TRUE,
																																							 BOOLEAN excludeWatchlists = FALSE,
																																							 BOOLEAN include_ofac = FALSE,
																																							 BOOLEAN addtl_watchlists = FALSE,
																																							 BOOLEAN doScore = FALSE,
																																							 BOOLEAN suppressNearDups = FALSE,
																																							 BOOLEAN require2ele = FALSE,
																																							 INTEGER AppendBest = 1, // Append the best SSN for Subject Level attribute
																																							 INTEGER ofac_version = 1,
																																							 REAL watchlist_threshold = 0.84,
																																							 INTEGER dob_radius = -1,
																																						 	BOOLEAN TestAccount = FALSE, // Indicates if TestAccounts should be enforced for Gateways
																																						 	BOOLEAN Batch = FALSE, // Indicates if this is a Batch transaction (FALSE = realtime)
																																							 UNSIGNED2 SX_Match_Restriction_Limit = 10, // By default return a MAX of 10 Extended Skip Trace Phones
																																							 BOOLEAN Strict_APSX = FALSE, // By default don't enforce strict Extended Skip Trace matching
																																							 BOOLEAN BlankOutDuplicatePhones = FALSE,
																																							 BOOLEAN UsePremiumSource_A = FALSE,
																																							 BOOLEAN RunRelocation = FALSE) := FUNCTION

	/* ************************************************************************
	 *  Clean the input and copy the input data into appropriate echo fields  *
	 ************************************************************************ */
	// If you are outside the PhoneRestrictionMask range, set it to the default of 0 - ALL PHONES
	PhoneRestrictionMask := IF(PhoneRestrictionMaskTemp > 5 OR PhoneRestrictionMaskTemp < 0, 0, PhoneRestrictionMaskTemp);
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanInputs(Phone_Shell.Layout_Phone_Shell.Input le, UNSIGNED4 seqCounter) := TRANSFORM
		cleaned_name := Address.CleanPerson73(le.FullName);
		BOOLEAN valid_cleaned := TRIM(le.FullName) <> '';
		
		SELF.Input_Echo.seq 								:= seqCounter;
		SELF.Input_Echo.LexID								:= le.DID;
		SELF.Input_Echo.AcctNo				 			:= le.AcctNo;
		SELF.Input_Echo.in_FName 						:= TRIM(StringLib.StringToUppercase(IF(le.FirstName = '' AND valid_cleaned, cleaned_name[6..25], le.FirstName)));
		SELF.Input_Echo.in_MName						:= TRIM(StringLib.StringToUppercase(IF(le.MiddleName = '' AND valid_cleaned, cleaned_name[26..45], le.MiddleName)));
		SELF.Input_Echo.in_LName 						:= TRIM(StringLib.StringToUppercase(IF(le.LastName = '' AND valid_cleaned, cleaned_name[46..65], le.LastName)));
		SELF.Input_Echo.in_SName 						:= TRIM(StringLib.StringToUppercase(IF(le.SuffixName = '' AND valid_cleaned, cleaned_name[66..70], le.SuffixName)));
		SELF.Input_Echo.in_StreetAddress 		:= TRIM(StringLib.StringToUppercase(Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1, le.Prim_Range, le.Predir, le.Prim_Name, le.Addr_Suffix, le.Postdir, le.Unit_Desig, le.Sec_Range)));
		SELF.Input_Echo.in_City 						:= TRIM(StringLib.StringToUppercase(le.City));
		SELF.Input_Echo.in_State 						:= TRIM(StringLib.StringToUppercase(le.State));
		//Since batch uses zip5 and XML uses zip, we want to send the populated zip to the address cleaner
		//as if no zip is populated into addr cleaner than zip could come back empty if no zip is found. But if the zip
		//is populated and no address cleaned then the zip would still be populated. So trying to be consistent between the 2 input fields 
		ZipToUse := if(le.Zip != '', le.zip, le.zip5);
		SELF.Input_Echo.in_ZipCode 					:= ZipToUse;//le.Zip;
		SELF.Input_Echo.in_DOB 							:= le.DateOfBirth;
		SELF.Input_Echo.in_SSN 							:= le.SSN;
		SELF.Input_Echo.in_Phone10 					:= le.HomePhone;
		SELF.Input_Echo.in_WPhone10 				:= le.WorkPhone;
		SELF.Input_Echo.in_TargusGW_Enabled := le.TargusGatewayEnabled;
		SELF.Input_Echo.in_TUGW_Enabled 		:= le.TransUnionGatewayEnabled;
		SELF.Input_Echo.in_INSGW_Enabled 		:= le.InsuranceGatewayEnabled;
		SELF.Input_Echo.in_Processing_Date 	:= (string) Std.Date.Today();
		SELF.Input_Echo.in_Burea_Enabled				:= UsePremiumSource_A;			
		SELF.Clean_Input.seq 						:= seqCounter;
		SELF.Clean_Input.did						:= le.DID;
		SELF.Clean_Input.AcctNo				 	:= le.AcctNo;
		
		SELF.Clean_Input.FullName 			:= StringLib.StringToUpperCase(le.FullName);
		SELF.Clean_Input.FirstName  		:= TRIM(StringLib.StringToUppercase(IF(le.FirstName = '' AND valid_cleaned, cleaned_name[6..25], le.FirstName)));
		SELF.Clean_Input.MiddleName  		:= TRIM(StringLib.StringToUppercase(IF(le.MiddleName = '' AND valid_cleaned, cleaned_name[26..45], le.MiddleName)));
		SELF.Clean_Input.LastName  			:= TRIM(StringLib.StringToUppercase(IF(le.LastName = '' AND valid_cleaned, cleaned_name[46..65], le.LastName)));
		SELF.Clean_Input.SuffixName 		:= TRIM(StringLib.StringToUppercase(IF(le.SuffixName = '' AND valid_cleaned, cleaned_name[66..70], le.SuffixName)));	
		SELF.Clean_Input.TitleName  		:= TRIM(StringLib.StringToUppercase(IF(le.TitleName = '' AND valid_cleaned, cleaned_name[1..5], le.TitleName)));
		
		// Determine if we had StreetAddress populated or if the parsed elements were populated
		street_address := Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1 + ' ' + le.StreetAddress2, le.Prim_Range, le.Predir, le.Prim_Name, le.Addr_Suffix, le.Postdir, le.Unit_Desig, le.Sec_Range);
		cleaned_address := Risk_Indicators.MOD_AddressClean.clean_addr(street_address, le.City, le.State, ZipToUse);											
		SELF.Clean_Input.StreetAddress1 := TRIM(StringLib.StringToUppercase(Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1, le.Prim_Range, le.Predir, le.Prim_Name, le.Addr_Suffix, le.Postdir, le.Unit_Desig, le.Sec_Range)));
		SELF.Clean_Input.StreetAddress2 := TRIM(StringLib.StringToUppercase(le.StreetAddress2));
		SELF.Clean_Input.Prim_Range 		:= cleaned_address[1..10];
		SELF.Clean_Input.Predir 				:= cleaned_address[11..12];
		SELF.Clean_Input.Prim_Name 			:= cleaned_address[13..40];
		SELF.Clean_Input.Addr_Suffix 		:= cleaned_address[41..44];
		SELF.Clean_Input.Postdir 				:= cleaned_address[45..46];
		SELF.Clean_Input.Unit_Desig 		:= cleaned_address[47..56];
		SELF.Clean_Input.Sec_Range 			:= cleaned_address[57..65];
		SELF.Clean_Input.Zip5 					:= cleaned_address[117..121];
		SELF.Clean_Input.Zip4 					:= cleaned_address[122..125];
		SELF.Clean_Input.Lat 						:= cleaned_address[146..155];
		SELF.Clean_Input.Long 					:= cleaned_address[156..166];
		SELF.Clean_Input.Addr_Type 			:= Risk_Indicators.iid_constants.override_addr_type(street_address, cleaned_address[139], cleaned_address[126..129]);
		SELF.Clean_Input.Addr_Status 		:= cleaned_address[179..182];
		SELF.Clean_Input.County 				:= cleaned_address[143..145];
		SELF.Clean_Input.Geo_Block 			:= cleaned_address[171..177];
		SELF.Clean_Input.City						:= cleaned_address[90..114];
		SELF.Clean_Input.State					:= cleaned_address[115..116];
		SELF.Clean_Input.Zip						:= TRIM(cleaned_address[117..121] + cleaned_address[122..125]);
		
		SELF.Clean_Input.SSN						:= StringLib.StringFilter(le.SSN, '0123456789');
		SELF.Clean_Input.DateOfBirth		:= StringLib.StringFilter(le.DateOfBirth, '0123456789');
		SELF.Clean_Input.Age						:= IF((INTEGER)le.DateOfBirth != 0,	(STRING3)ut.Age ((UNSIGNED)le.DateOfBirth, (UNSIGNED)risk_indicators.iid_constants.myGetDate(999999)), StringLib.StringFilter(le.Age, '0123456789'));
		SELF.Clean_Input.HomePhone			:= StringLib.StringFilter(le.HomePhone, '0123456789');
		SELF.Clean_Input.WorkPhone			:= StringLib.StringFilter(le.WorkPhone, '0123456789');

		SELF.Clean_Input.TargusGatewayEnabled					:= le.TargusGatewayEnabled;
		SELF.Clean_Input.TransUnionGatewayEnabled			:= le.TransUnionGatewayEnabled;
		SELF.Clean_Input.InsuranceGatewayEnabled			:= le.InsuranceGatewayEnabled;
		SELF.Raw_Input.seq 							:= seqCounter;
		SELF.Raw_Input.did							:= le.DID;
		SELF.Raw_Input 									:= le;
		
		SELF := le;
		SELF := [];
	END;
	cleanedBatchInput := PROJECT(Input, cleanInputs(LEFT, COUNTER));

	/* ************************************************************************
	 *  Prepare IID/Boca Shell input to gather Boca Shell Data                *
	 ************************************************************************ */
	Risk_Indicators.Layout_Input iidPrep(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.seq							:= le.Clean_Input.seq;
		SELF.did							:= le.Clean_Input.did;
		SELF.score						:= IF(le.Clean_Input.DID <> 0, 100, 0);
		
		// Archive mode is NOT supported for the Phone Shell
		SELF.historydate			:= 999999;
		
		// These fields have already been cleaned in the previous TRANSFORM
		SELF.ssn							:= le.Clean_Input.SSN;
		SELF.dob							:= le.Clean_Input.DateOfBirth;
		SELF.age							:= le.Clean_Input.Age;
		SELF.fname						:= le.Clean_Input.FirstName;
		SELF.mname						:= le.Clean_Input.MiddleName;
		SELF.lname						:= le.Clean_Input.LastName;
		SELF.suffix						:= le.Clean_Input.SuffixName;
		SELF.title						:= le.Clean_Input.TitleName;
		SELF.in_streetAddress	:= TRIM(le.Clean_Input.StreetAddress1 + ' ' + le.Clean_Input.StreetAddress2);
		SELF.in_city					:= le.Clean_Input.City;
		SELF.in_state					:= le.Clean_Input.State;
		SELF.in_zipCode				:= le.Clean_Input.Zip;
		SELF.prim_range				:= le.Clean_Input.Prim_Range;
		SELF.predir						:= le.Clean_Input.Predir;
		SELF.prim_name				:= le.Clean_Input.Prim_Name;
		SELF.addr_suffix			:= le.Clean_Input.Addr_Suffix;
		SELF.postdir					:= le.Clean_Input.Postdir;
		SELF.unit_desig				:= le.Clean_Input.Unit_Desig;
		SELF.sec_range				:= le.Clean_Input.Sec_Range;
		SELF.p_city_name			:= le.Clean_Input.City;
		SELF.st								:= le.Clean_Input.State;
		SELF.z5								:= le.Clean_Input.Zip5;
		SELF.zip4							:= le.Clean_Input.Zip4;
		SELF.lat							:= le.Clean_Input.Lat;
		SELF.long							:= le.Clean_Input.Long;
		SELF.addr_type				:= le.Clean_Input.Addr_Type;
		SELF.addr_status			:= le.Clean_Input.Addr_Status;
		SELF.county						:= le.Clean_Input.County;
		SELF.geo_blk					:= le.Clean_Input.Geo_Block;
		SELF.phone10					:= le.Clean_Input.HomePhone;
		SELF.wphone10					:= le.Clean_Input.WorkPhone;

		SELF									:= [];
	END;
	// Make sure DID only searches are first
	iid_prep := SORT(PROJECT(cleanedBatchInput, iidPrep(LEFT)), -DID, seq);


	/* ************************************************************************
	 *  Set IID and Boca Shell Options - Most of the Boca Shell Options are   *
	 * passed into this Phone_Shell_Function.																	*
	 ************************************************************************ */
	nugen               := TRUE;
	from_IT1O           := FALSE;
	isUtility           := IF(StringLib.StringToUpperCase(TRIM(IndustryClass, ALL)) = 'UTILI', TRUE, FALSE);
	isFCRA              := FALSE;
	ln_branded          := FALSE;
	from_biid           := FALSE;

	// We don't want to call Targus twice...
	BocaShellGateways		:= if(exists(Gateways(servicename = 'bridgerwlc')), Gateways, Gateway.Constants.void_gateway);
	
 // Choose BocaShellVersion based on what PhoneShellVersion was passed in
 BocaShellVersion := if(PhoneShellVersion >= 20, // PhoneShell V2 (2.0, 2.1, etc)
                        54, // If PhoneShell V2 then Boca Shell 5.4
                        41); // Else use Boca Shell 4.1
 
	/* ************************************************************************
	 *  Get IID and Boca Shell Data - This will also perform our DID append   *
	 ************************************************************************ */
	InstantID := Risk_Indicators.InstantID_Function(iid_prep, BocaShellGateways, DPPAPurpose, GLBPurpose, isUtility, ln_branded, ofac_only, suppressNearDups, require2ele, isFCRA, from_biid, 
																						ExcludeWatchLists, from_IT1O, ofac_version, include_ofac, addtl_watchlists, watchlist_threshold, dob_radius, BocaShellVersion, 
																						in_DataRestriction := DataRestrictionMask, in_append_best := AppendBest,                                             
                      in_DataPermission := DataPermissionMask);
	
	BocaShell := Risk_Indicators.Boca_Shell_Function(InstantID, BocaShellGateways, DPPAPurpose, GLBPurpose, isUtility, ln_branded, includeRel, includeDL, includeVeh, includeDerog, BocaShellVersion, 
																						doScore, nugen, DataRestriction := DataRestrictionMask, DataPermission := DataPermissionMask);

	/* ************************************************************************
	 *  Merge Boca Shell Data with original input                             *
	 ************************************************************************ */
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus mergeBocaShell(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Risk_Indicators.Layout_Boca_Shell ri) := TRANSFORM
		SELF.Clam 						:= ri;
		SELF.DID							:= ri.DID;
		SELF.Clean_Input.DID	:= ri.DID;
		// If we only input the DID/LexID, attempt to populate name and address
		SELF.Clean_Input.FirstName := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.FirstName) = '', ri.IID.Combo_First, le.Clean_Input.FirstName);
		SELF.Clean_Input.LastName := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.LastName) = '', ri.IID.Combo_Last, le.Clean_Input.LastName);
		SELF.Clean_Input.Prim_Range := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Prim_Range) = '', ri.IID.Combo_Prim_Range, le.Clean_Input.Prim_Range);
		SELF.Clean_Input.Predir := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Predir) = '', ri.IID.Combo_Predir, le.Clean_Input.Predir);
		SELF.Clean_Input.Prim_Name := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Prim_Name) = '', ri.IID.Combo_Prim_Name, le.Clean_Input.Prim_Name);
		SELF.Clean_Input.Addr_Suffix := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Addr_Suffix) = '', ri.IID.Combo_Suffix, le.Clean_Input.Addr_Suffix);
		SELF.Clean_Input.Postdir := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Postdir) = '', ri.IID.Combo_Postdir, le.Clean_Input.Postdir);
		SELF.Clean_Input.Unit_Desig := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Unit_Desig) = '', ri.IID.Combo_Unit_Desig, le.Clean_Input.Unit_Desig);
		SELF.Clean_Input.Sec_Range := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Sec_Range) = '', ri.IID.Combo_Sec_Range, le.Clean_Input.Sec_Range);
		SELF.Clean_Input.City := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.City) = '', ri.IID.Combo_City, le.Clean_Input.City);
		SELF.Clean_Input.State := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.State) = '', ri.IID.Combo_State, le.Clean_Input.State);
		SELF.Clean_Input.Zip := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Zip) = '', ri.IID.Combo_Zip, le.Clean_Input.Zip);
		SELF.Clean_Input.Zip5 := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Zip5) = '', ri.IID.Combo_Zip[1..5], le.Clean_Input.Zip5);
		SELF.Clean_Input.Zip4 := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.Zip4) = '', ri.IID.Combo_Zip[6..9], le.Clean_Input.Zip4);
		SELF.Clean_Input.SSN := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.SSN) = '', ri.IID.Combo_SSN, le.Clean_Input.SSN);
		SELF.Clean_Input.DateOfBirth := IF(le.Clean_Input.DID <> 0 AND TRIM(le.Clean_Input.DateOfBirth) = '', ri.IID.Combo_DOB, le.Clean_Input.DateOfBirth);
		
		SELF.Raw_Input.DID		:= ri.DID;
		SELF									:= le;
	END;
	withBocaShell := JOIN(cleanedBatchInput, BocaShell, LEFT.Clean_Input.seq = RIGHT.seq, mergeBocaShell(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	/* ************************************************************************
	 *  Gather universe of Phone Shell Phones                                 *
	 ************************************************************************ */
	withPhones := Phone_Shell.Gather_Phones(withBocaShell, Gateways, GLBPurpose, DPPAPurpose, DataRestrictionMask, DataPermissionMask, PhoneRestrictionMask, MaxPhones, InsuranceVerificationAgeLimit,
																					SPIIAccessLevel, VerticalMarket, IndustryClass, RelocationsMaxDaysBefore, RelocationsMaxDaysAfter, RelocationsTargetRadius, IncludeLastResort, IncludePhonesFeedback, TestAccount, Batch, SX_Match_Restriction_Limit, Strict_APSX, 
																					BlankOutDuplicatePhones, 
																					UsePremiumSource_A, RunRelocation);

	/* ************************************************************************
	 *  Gather attributes for the discovered phones                           *
	 ************************************************************************ */
	withAttributes := Phone_Shell.Gather_Attributes(withPhones, GLBPurpose, DPPAPurpose, DataRestrictionMask, InsuranceVerificationAgeLimit, IndustryClass);

	/* ************************************************************************
	 *  Generate final output                                                 *
	 ************************************************************************ */
	Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout intoFinal(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.Boca_Shell := le.Clam;
		SELF.Phone_Shell := le;
		SELF := le;
	END;
	final := PROJECT(withAttributes, intoFinal(LEFT));
	
	// OUTPUT(iid_prep, NAMED('iid_prep'));
	// OUTPUT(InstantID, NAMED('InstantID'));
	// OUTPUT(BocaShell, NAMED('BocaShell'));
	// OUTPUT(withBocaShell, NAMED('withBocaShell'));
 // OUTPUT(glbpurpose, named('glbpurpose'));
	// OUTPUT(withPhones, NAMED('fnc_WithPhones'));
	// OUTPUT(withAttributes, NAMED('fnc_WithAttributes'));
 // output(withAttributes(gathered_phone = '5598270214'),named('fnc_Attr'));

	RETURN(final);
END;