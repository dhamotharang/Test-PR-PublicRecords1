IMPORT ProfileBooster, Address, BO_Address, AID, NID, ProfileBooster.ProfileBoosterV2_KEL, STD;

EXPORT Fn_CleanInput_THOR( DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII) ds_InputEcho) := 
	FUNCTION
		// NOTE: name and address cleaning logic borrowed from Frandx.Standardize_NameAddr
		
		CleanSpacesAndUpper(STRING pStr) := STD.Str.ToUpperCase(STD.Str.CleanSpaces(pStr));

    // 1. ---------------[ Clean names ]---------------

    layout_tmp := RECORD
      ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII;
      STRING NameSuffix; // necessary for name cleaner
    END;
    
		ds_InputEcho_tmp := 
			PROJECT( 
				ds_InputEcho,
				TRANSFORM( layout_tmp,
					SELF.NameSuffix := '',
					SELF := LEFT,
					SELF := []
				));
		
		ds_with_cleaned_names_pre := Nid.fn_CleanParsedNames(
				ds_InputEcho_tmp, P_InpNameFirst, P_InpNameMid, P_InpNameLast, NameSuffix, 
				normalizeDualNames := FALSE, useV2 := TRUE, includeInRepository := FALSE);
	
		// Sometimes the Thor name cleaner will swap the first name and last name if (1) both the
		// first name and last name can be a first name (e.g. James Daniel), and (2) if the last 
		// name is a more populare first name than the first name is. At any rate, we don't want
		// this behavior, so we swap them back here.
		ds_with_cleaned_names := 
			PROJECT(
				ds_with_cleaned_names_pre,
				TRANSFORM( RECORDOF(ds_with_cleaned_names_pre),
					firstAndLastNamesAreSwapped := 
							STD.Str.Find( LEFT.P_InpNameLast, LEFT.cln_fname, 1 ) > 0  OR
							STD.Str.Find( LEFT.P_InpNameFirst, LEFT.cln_lname, 1 ) > 0;
					SELF.cln_fname := IF( firstAndLastNamesAreSwapped, LEFT.cln_lname, LEFT.cln_fname ),
					SELF.cln_lname := IF( firstAndLastNamesAreSwapped, LEFT.cln_fname, LEFT.cln_lname ),
					SELF := LEFT,
					SELF := [] 
				)
			);
		
		// 2. ---------------[ Clean addresses ]---------------
		
		layout_with_cleaned_names := RECORDOF(ds_with_cleaned_names);

		/* Temporarily Disabling AID Cache until issues can be resolved
		layout_withCleanedNames_tmp := RECORD
			layout_with_cleaned_names;		
			STRING prep_addr_line1;
			STRING prep_addr_line_last;
			UNSIGNED8 raw_aid := 0;
			UNSIGNED8 ace_aid := 0;
		END;
		
		layout_withCleanedNames_tmp xfm_prep_addresses_for_cleaning( layout_with_cleaned_names le ) := 
			TRANSFORM
				cityStateZip := CleanSpacesAndUpper(le.P_InpAddrCity) + if (trim(le.P_InpAddrCity) != '',', ','')	+ 
												CleanSpacesAndUpper(le.P_InpAddrState) + ' ' + TRIM(le.P_InpAddrZip);
				addr1 :=	CleanSpacesAndUpper(le.P_InpAddrLine1 + ' ' + le.P_InpAddrLine2);
				addr2 :=	cityStateZip; 
				
				SELF.prep_addr_line1     := addr1;
				SELF.prep_addr_line_last := addr2;
				
				SELF := le;
				SELF := [];
			END;

		ds_input_prepped_for_addr_clean := PROJECT( ds_with_cleaned_names, xfm_prep_addresses_for_cleaning(LEFT) );

		UNSIGNED4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | 
				AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;
	
		AID.MacAppendFromRaw_2Line(ds_input_prepped_for_addr_clean, prep_addr_line1, prep_addr_line_last, 
				raw_aid, ds_with_cleaned_addresses, lFlags);
		*/
		
    // 3. ---------------[ Transform into final layout ]---------------

		ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII xfm_GetInputCleaned( RECORDOF(ds_with_cleaned_names) le ) := 
			TRANSFORM
				NameNotPopulated  := IF(le.cln_fname = '' AND le.cln_mname = '' AND le.cln_lname = '', '', le.cln_fname);
				cleaned_zip       := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Zip(le.P_InpAddrZip);
				cleaned_DL        := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_DLNumber(le.P_InpDL);
				cleaned_DLState   := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_DLState(le.P_InpDLState); 
				cleaned_email     := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Email(le.P_InpEmail);
				cleaned_phone10   := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Phone(le.P_InpPhoneHome);
				cleaned_workphone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Phone(le.P_InpPhoneWork);
				cleaned_SSN       := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_SSN(le.P_InpSSN);
				DOB_dates         := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(le.P_InpDOB, 
															ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.VALIDATE_YEAR_RANGE_LOW_DOB, 
															ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.VALIDATE_YEAR_RANGE_HIGH_DOB);
				cleaned_DOB       := DOB_dates[1];
			 cityStateZip       := CleanSpacesAndUpper(le.P_InpAddrCity) + IF(TRIM(le.P_InpAddrCity) != '',', ','') + CleanSpacesAndUpper(le.P_InpAddrState) + ' ' + TRIM(cleaned_zip);
		
				address_line1     := STD.Str.Filter(CleanSpacesAndUpper(le.P_InpAddrLine1 + ' ' + le.P_InpAddrLine2),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.\\/#- '); 
				address_line1_filtered :=    IF(LENGTH(TRIM(address_line1)) <= 2,'',address_line1);
				address_line2     := cityStateZip; 
				cleaned_address_raw:= Address.CleanAddress182(address_line1_filtered, address_line2, BO_Address.BO_Server, BO_Address.BO_Port);
				cleaned_address   := Address.CleanFields(cleaned_address_raw);
				cleaned_archivedate := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(le.P_InpArchDt, 
															ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.VALIDATE_YEAR_RANGE_LOW_ARCHIVEDATE, 
															ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.VALIDATE_YEAR_RANGE_HIGH_ARCHIVEDATE,
															SetDefault := TRUE /*if no date was input, set to current date/time*/)[1];

				// Input Echo perserved
				SELF.G_ProcUID				  := le.G_ProcUID;
				SELF.G_ProcBusUID		   := le.G_ProcBusUID;
				SELF.P_InpAcct      := le.P_InpAcct;
				SELF.P_InpLexID        := le.P_InpLexID;
				SELF.P_InpNameFirst    := le.P_InpNameFirst;
				SELF.P_InpNameMid   := le.P_InpNameMid;
				SELF.P_InpNameLast     := le.P_InpNameLast;			
				SELF.P_InpAddrLine1       := le.P_InpAddrLine1;
				SELF.P_InpAddrLine2       := le.P_InpAddrLine2;
				SELF.P_InpAddrCity         := le.P_InpAddrCity;
				SELF.P_InpAddrState        := le.P_InpAddrState; 
				SELF.P_InpAddrZip          := le.P_InpAddrZip;
				SELF.P_InpPhoneHome    := le.P_InpPhoneHome;
				SELF.P_InpPhoneWork    := le.P_InpPhoneWork;
				SELF.P_InpEmail        := le.P_InpEmail; 
				SELF.P_InpArchDt  := le.P_InpArchDt;
				SELF.P_InpSSN          := le.P_InpSSN;
				SELF.P_InpDOB					 := le.P_InpDOB;
				SELF.P_InpDL					 := le.P_InpDL;
				SELF.P_InpDLState      := le.P_InpDLState;
				
				// Cleaned Archive Date
				SELF.P_InpClnArchDt := cleaned_archivedate.ValidPortion_01 + cleaned_archivedate.TimeStamp; 

				// Cleaned name
				SELF.P_InpClnNamePrfx      := le.cln_title;
				SELF.P_InpClnNameFirst   := le.cln_fname;
				SELF.P_InpClnNameMid  := le.cln_mname;
				SELF.P_InpClnNameLast    := le.cln_lname;
				SELF.P_InpClnNameSffx      := le.cln_suffix;
					
				// Cleaned address
				SELF.P_InpClnAddrPrimRng   := cleaned_address.prim_range;
				SELF.P_InpClnAddrPreDir   := cleaned_address.predir;
				SELF.P_InpClnAddrPrimName    := cleaned_address.prim_name;
				SELF.P_InpClnAddrSffx  := cleaned_address.addr_suffix;
				SELF.P_InpClnAddrPostDir  := cleaned_address.postdir;
				SELF.P_InpClnAddrUnitDesig      := cleaned_address.unit_desig;
				SELF.P_InpClnAddrSecRng := cleaned_address.sec_range;
				SELF.P_InpClnAddrCity           := cleaned_address.v_city_name;
				SELF.P_InpClnAddrState          := cleaned_address.st;
				SELF.P_InpClnAddrZip5           := cleaned_address.zip;
				SELF.P_InpClnAddrZip4           := cleaned_address.zip4;
				SELF.P_InpClnAddrLat       := cleaned_address.geo_lat;
				SELF.P_InpClnAddrLng      := cleaned_address.geo_long;
				SELF.P_InpClnAddrType    := cleaned_address.rec_type;
				SELF.P_InpClnAddrStatus  := cleaned_address.err_stat;
				SELF.P_InpClnAddrCnty         := cleaned_address.county[3..5];
				SELF.P_InpClnAddrGeo       := cleaned_address.geo_blk;
						
				// Other cleaned fields (email, homephone, workphone, SSN, DOB, DL)
				SELF.P_InpClnEmail     := cleaned_email;
				SELF.P_InpClnPhoneHome := cleaned_phone10;
				SELF.P_InpClnPhoneWork := cleaned_workphone;				
				SELF.P_InpClnSSN       := cleaned_SSN;
				SELF.P_InpClnDOB       := cleaned_DOB.ValidPortion_00; 
				SELF.P_InpClnDL  			 := cleaned_DL;  
				SELF.P_InpClnDLState   := cleaned_DLState;   
				
				// Cleaned DOB metadata
				SELF.DateAsNumsOnly    := cleaned_DOB.DateAsNumsOnly; 
				SELF.result            := cleaned_DOB.result;  
				SELF.Populated         := cleaned_DOB.Populated; 
				SELF.YearFilled        := cleaned_DOB.YearFilled; 
				SELF.MonthFilled       := cleaned_DOB.MonthFilled; 
				SELF.DayFilled         := cleaned_DOB.DayFilled;  
				SELF.YearNonZero       := cleaned_DOB.YearNonZero; 
				SELF.MonthNonZero      := cleaned_DOB.MonthNonZero; 
				SELF.DayNonZero        := cleaned_DOB.DayNonZero;  
				SELF.YearValid         := cleaned_DOB.YearValid;  
				SELF.MonthValid        := cleaned_DOB.MonthValid; 
				SELF.DayValid          := cleaned_DOB.DayValid; 
				SELF.InPast            := cleaned_DOB.InPast; 
				SELF.InvalidChars      := cleaned_DOB.InvalidChars;  
				SELF.ChronStateUnknown := cleaned_DOB.ChronStateUnknown;  
				SELF.DateValid         := cleaned_DOB.DateValid;  
				SELF.ValidPortion_00   := cleaned_DOB.ValidPortion_00; 
				SELF.ValidPortion_01   := cleaned_DOB.ValidPortion_01; 
				
				SELF.RepNumber := le.RepNumber;
				SELF := le;
				SELF := [];
			END;

  ds_cleanInput := PROJECT( ds_with_cleaned_names, xfm_GetInputCleaned(LEFT) );

	// DEBUGs
	// =========================================
	// ds_debugWithCleanedNames := ds_with_cleaned_names( STD.Str.Find( TRIM(P_InpNameFirst,LEFT,RIGHT), TRIM(cln_fname,LEFT,RIGHT), 1 ) = 0 );
	// ds_debugWithCleanedAddrs := ds_with_cleaned_addresses( STD.Str.Find( TRIM(P_InpNameFirst,LEFT,RIGHT), TRIM(cln_fname,LEFT,RIGHT), 1 ) = 0 );
	
	// OUTPUT( CHOOSEN(ds_InputEcho,100), NAMED('InputEcho') );
	// OUTPUT( CHOOSEN(ds_with_cleaned_names,100), NAMED('with_cleaned_names') ); 
	// OUTPUT( CHOOSEN(ds_debugWithCleanedNames,100), NAMED('debugWithCleanedNames') ); 
	// OUTPUT( CHOOSEN(ds_input_prepped_for_addr_clean,100), NAMED('input_prepped_for_addr_clean') ); 
	// OUTPUT( CHOOSEN(ds_with_cleaned_addresses,100), NAMED('with_cleaned_addresses') ); 
	// OUTPUT( CHOOSEN(ds_debugWithCleanedAddrs,100), NAMED('debugWithCleanedAddrs') );
	// OUTPUT( CHOOSEN(ds_cleanInput,100), NAMED('with_cleaned_names_addrs') );

  RETURN ds_cleanInput;
END;