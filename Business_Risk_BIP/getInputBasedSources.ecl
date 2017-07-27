IMPORT Address, ADVO, BIPV2, BizLinkFull, Business_Risk, CellPhone, Gong, Risk_Indicators, RiskWise, UT;

EXPORT getInputBasedSources(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ------- Get FEIN Matches across all businesses ------------- //
	For_FEIN_Search := PROJECT(Shell, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
				SELF.acctno := (string)LEFT.Seq,
				SELF.FEIN := LEFT.Clean_Input.FEIN,
				SELF := []));
				
	FEIN_results_w_acct := PROJECT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(For_FEIN_Search).uid_results_w_acct, 
																			TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID := (UNSIGNED)LEFT.acctno,
																								SELF.UltID := LEFT.UltID,
																								SELF.OrgID := LEFT.OrgID,
																								SELF.SeleID := LEFT.SeleID,
																								SELF.ProxID := LEFT.ProxID,
																								SELF.PowID := LEFT.PowID,
																								SELF := []));

																					
	UniqueRawFEINMatches := DEDUP(SORT(FEIN_results_w_acct, UniqueID, UltID, OrgID, SeleID, ProxID, PowID),	UniqueID, UltID, OrgID, SeleID, ProxID, PowID);
	
	
	BusinessHeaderRaw := BIPV2.Key_BH_Linking_Ids.kFetch2(UniqueRawFEINMatches,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.PowID), // Search at most restrictive level since we already know the full BIP ID set of the FEIN match
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses);
											
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BusinessHeaderRaw, Shell, BusinessHeaderSeq);
	

	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeader := GROUP(Business_Risk_BIP.Common.FilterRecords(BusinessHeaderSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);

	tempVerificationLayout := RECORD
		UNSIGNED4 Seq,
		STRING2 FEINOnFile;
		STRING2 FEINBusinessMatchLevel;
		STRING2 FEINAddrNameMatchLevel;
	END;
	
	tempVerificationLayout verifyFEINs(Shell le, BusinessHeader ri) := TRANSFORM
		FEINInput 						 := le.Input_Echo.FEIN <> '';
		FEINMatched 					 := (INTEGER)ri.Company_FEIN > 0 AND le.Clean_Input.FEIN = ri.Company_FEIN;
		NoScoreValue					 := 255;
		BusinessNamePopulated  := TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Company_Name) <> '';
		BusinessNameMatchScore := IF(BusinessNamePopulated AND le.Clean_Input.CompanyName[1] = ri.Company_Name[1], Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Company_Name), NoScoreValue);
		BusinessNameMatched 	 := Risk_Indicators.iid_constants.g(BusinessNameMatchScore);
		
		AddressPopulated 			 := TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		ZIPScore							 := IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		StateMatched					 := StringLib.StringToUpperCase(le.Clean_Input.State) = StringLib.StringToUpperCase(ri.st);
		CityStateScore				 := IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND StateMatched, 
															Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched		 := AddressPopulated AND Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);
		AddressScore 					 := MAP(NOT AddressPopulated 																														 => NoScoreValue,
																  AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue   => NoScoreValue,
																							Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range, 
																							ri.prim_range, ri.prim_name, ri.sec_range,
																							ZIPScore, CityStateScore));
		AddressMatched 				 := AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);
		
		BIPIDsMatched 				 := le.BIP_IDs.UltID.LinkID = ri.UltID AND
														  (le.BIP_IDs.OrgID.LinkID = ri.OrgID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltIDSet)) AND
															(le.BIP_IDs.SeleID.LinkID = ri.SeleID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgIDSet)) AND
															(le.BIP_IDs.ProxID.LinkID = ri.ProxID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgSeleIDSet)) AND
														  (le.BIP_IDs.PowID.LinkID = ri.PowID OR (Options.LinkSearchLevel IN Business_Risk_BIP.Constants.UltOrgSeleProxIDSet));
		
		SELF.Seq 							 := le.Seq;
		SELF.FEINOnFile := MAP(NOT FEINInput 																															=> '-1', // FEIN not Input 
													FEINInput AND NOT FEINMatched																								=> '0',	 // FEIN not found
													FEINInput AND FEINMatched 																									=> '1',	 // FEIN found on Business Header
																																																				 '0');
																																
		SELF.FEINBusinessMatchLevel := MAP(NOT FEINInput 																									=> '-1', // FEIN not input
																			FEINInput AND NOT FEINMatched 																	=> '0',	 // Input FEIN not found in Business Header
																			FEINMatched AND NOT BIPIDsMatched 															=> '1',  // FEIN found with different BIP IDs from input business
																			FEINMatched AND BIPIDsMatched 																	=> '2',	 // FEIN found with same BIP IDs as input business
																																																				 '0');
																			
		SELF.FEINAddrNameMatchLevel := MAP(NOT FEINInput 																									=> '-1', // FEIN not Input
																			FEINInput AND NOT FEINMatched 																	=> '0',	 // FEIN not found
																			FEINMatched AND NOT BusinessNameMatched AND NOT AddressMatched 	=> '1',	 // FEIN found with different Name and Address
																			FEINMatched AND BusinessNameMatched AND NOT AddressMatched 			=> '2',	 // FEIN found with matching Name and different Address
																			FEINMatched AND NOT BusinessNameMatched AND AddressMatched 			=> '3',	 // FEIN found with different Name and mathcing Address
																			FEINMatched AND BusinessNameMatched AND AddressMatched 					=> '4',	 // FEIN found with matching Name and Address
																																																				 '0');				
	END;

	FEINVerification := JOIN(Shell, BusinessHeader, LEFT.Seq = RIGHT.Seq AND LEFT.Clean_Input.FEIN = RIGHT.Company_FEIN,
																	verifyFEINs(LEFT,RIGHT),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));
														
	FEINVerificationRolled := ROLLUP(SORT(FEINVerification, Seq), LEFT.Seq = RIGHT.Seq, 												
																	TRANSFORM(tempVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							SELF.FEINOnFile := (STRING)MAX((INTEGER)LEFT.FEINOnFile, (INTEGER)RIGHT.FEINOnFile);
																							SELF.FEINBusinessMatchLevel := (STRING)MAX((INTEGER)LEFT.FEINBusinessMatchLevel, (INTEGER)RIGHT.FEINBusinessMatchLevel);
																							SELF.FEINAddrNameMatchLevel := (STRING)MAX((INTEGER)LEFT.FEINAddrNameMatchLevel, (INTEGER)RIGHT.FEINAddrNameMatchLevel)));
																
	
	withFEINVerification := JOIN(Shell, FEINVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.FEINOnFile := RIGHT.FEINOnFile;
																							SELF.Verification.FEINBusinessMismatch := MAP(RIGHT.FEINBusinessMatchLevel = '-1' => '-1', // FEIN not provided
																																														RIGHT.FEINBusinessMatchLevel = '0' => '0',	 // Input FEIN not found in Business Header
																																														RIGHT.FEINBusinessMatchLevel = '1' => '2',	 // FEIN found with different BIP IDs from input business
																																														RIGHT.FEINBusinessMatchLevel = '2' => '1',   // FEIN found with same BIP IDs as input business
																																																																	'0');
																																																																	
																							SELF.Verification.FEINAddrNameMismatch := MAP(RIGHT.FEINAddrNameMatchLevel = '-1' => '-1', // FEIN not Input
																																														RIGHT.FEINAddrNameMatchLevel = '0' => '0',	 // FEIN not found
																																														RIGHT.FEINAddrNameMatchLevel = '1' => '4',   // FEIN found with different Name and Address
																																														RIGHT.FEINAddrNameMatchLevel = '2' => '3',   // FEIN found with matching Name and different Address
																																														RIGHT.FEINAddrNameMatchLevel = '3' => '2',   // FEIN found with different Name and mathcing Address
																																														RIGHT.FEINAddrNameMatchLevel = '4' => '1',	 // FEIN found with matching Name and Address
																																																																	'0');
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// -------- Get ADVO Address Data --------- //
	
	tempAddrZipTypeLayout := RECORD
		UNSIGNED4 Seq;
		STRING5 Zip;
		STRING10 prim_range;
		STRING28 prim_name;
		STRING4 addr_suffix;
		STRING2 predir;
		STRING2 postdir;
		STRING8 sec_range;
		BOOLEAN IsMilitaryAddress;
		BOOLEAN IsPOBox;
		BOOLEAN IsPrisonAddress;
	//	BOOLEAN IsResidential;
		BOOLEAN IsCommercial;
		INTEGER AdvoDtfirstseen;
		STRING2 InputAddrType;
		STRING2 InputAddrVacancy;
		STRING2 AddrZipMismatch;
	END;
	
	WithAdvo := JOIN(Shell, Advo.Key_Addr1_history,
					LEFT.Clean_Input.Zip5 != '' AND 
					LEFT.Clean_Input.Prim_Range != '' AND
					KEYED(LEFT.Clean_Input.Zip5 = RIGHT.zip) AND
					KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.prim_range) AND
					KEYED(LEFT.Clean_Input.Prim_Name = RIGHT.prim_name) AND
					KEYED(LEFT.Clean_Input.Addr_Suffix = RIGHT.addr_suffix) AND
					KEYED(LEFT.Clean_Input.Predir = RIGHT.predir) AND
					KEYED(LEFT.Clean_Input.Postdir = RIGHT.postdir) AND
					KEYED(LEFT.Clean_Input.Sec_Range = RIGHT.sec_range)  AND
					// Check history date
					((UNSIGNED)RIGHT.date_first_seen < (UNSIGNED)Risk_Indicators.iid_constants.full_history_date(LEFT.Clean_Input.HistoryDate)) AND
					// Check DRM for Advo restriction					
					Options.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] <> '1', 
					TRANSFORM(tempAddrZipTypeLayout,
											SELF.Seq := LEFT.Seq,
											SELF.InputAddrType   := RIGHT.Residential_or_Business_Ind ,
											SELF.InputAddrVacancy := RIGHT.Address_Vacancy_Indicator,
											SELF.AdvoDtfirstseen   := (INTEGER)RIGHT.date_first_seen,
											SELF.zip := left.Clean_Input.Zip5,
											SELF.prim_range := left.Clean_Input.Prim_Range, 
											SELF.prim_name := left.Clean_Input.Prim_Name, 
											SELF.Addr_Suffix := LEFT.Clean_Input.Addr_Suffix,
											SELF.Predir := LEFT.Clean_Input.Predir,
											SELF.Postdir := LEFT.Clean_Input.Postdir,
											SELF.sec_range := left.Clean_Input.Sec_Range,
											SELF := []), LEFT OUTER, ATMOST(50));
																				
	withAdvoDD := DEDUP(SORT(withAdvo, seq, zip,prim_range,	prim_name, addr_suffix, predir, postdir, sec_range, -AdvoDtfirstseen), 
															seq, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range	);
		
	RollAdvoResidential := ROLLUP(withAdvoDD, LEFT.Seq = RIGHT.Seq, 
																	TRANSFORM(tempAddrZipTypeLayout,
																							SELF.InputAddrType := IF(LEFT.InputAddrType = '', RIGHT.InputAddrType, LEFT.InputAddrType),
																							SELF.InputAddrVacancy := IF(LEFT.InputAddrVacancy = '', RIGHT.InputAddrVacancy, LEFT.InputAddrVacancy),
																							SELF := []));
																		
	withAdvoAttributes := IF(Options.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] = '1', withFEINVerification,
													JOIN(withFEINVerification, RollAdvoResidential, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							AddressPopulated := TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '';
																							SELF.Input_Characteristics.InputAddrTypeNoID := IF(AddressPopulated, RIGHT.InputAddrType, '-1'),
																							SELF.Verification.InputAddrVacancyNoID := IF(AddressPopulated, RIGHT.InputAddrVacancy, '-1'),
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW));																	
																		
	// ------ Determine Addr/Zip Type ------- //																	
	getZipType := JOIN(Shell, RiskWise.Key_CityStZip, (INTEGER)LEFT.Clean_Input.Zip5 > 0 AND KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip5),
																	TRANSFORM(tempAddrZipTypeLayout,
																							SELF.Seq := LEFT.Seq;
																							SELF.IsMilitaryAddress := RIGHT.ZipClass = 'M';
																							SELF.IsPOBox := RIGHT.ZipClass = 'P';
																							SELF.IsCommercial := RIGHT.ZipClass = 'U';
																							SELF.AddrZipMismatch := IF((TRIM(LEFT.Clean_Input.State) <> '' AND StringLib.StringToUpperCase(LEFT.Clean_Input.State) <> RIGHT.state) OR
																																			(TRIM(LEFT.Clean_Input.City) <> '' AND StringLib.StringToUpperCase(LEFT.Clean_Input.City) <> RIGHT.City), '1', '0');
						
																							SELF := []),
																	ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));
	
	tempAddrZipTypeLayout getSICCodes(Shell le, Risk_Indicators.Key_HRI_Address_To_SIC ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.IsPrisonAddress := ri.sic_code = '2225';
		SELF.IsCommercial := (INTEGER)ri.sic_code > 0;
		SELF := [];
	END;

	getAddrSIC := JOIN(Shell, Risk_Indicators.Key_HRI_Address_To_SIC,
																	LEFT.Clean_Input.Zip5 != '' AND LEFT.Clean_Input.Prim_Name != '' AND
																	KEYED(LEFT.Clean_Input.Zip5 = RIGHT.z5) AND KEYED(LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name) AND KEYED(LEFT.Clean_Input.Addr_Suffix = RIGHT.Suffix) AND 
																	KEYED(LEFT.Clean_Input.PreDir = RIGHT.predir) AND KEYED(LEFT.Clean_Input.PostDir = RIGHT.postdir) AND KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.prim_range) AND 
																	KEYED(Ut.NNEQ(LEFT.Clean_Input.Sec_Range, RIGHT.sec_range)) AND 
																	// check date
																	RIGHT.dt_first_seen < LEFT.Clean_Input.HistoryDate AND
																	// Check source
																	RIGHT.Source IN AllowedSourcesSet, 
																	getSICCodes(LEFT, RIGHT),
																	ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader), KEEP(100));
	
	
	
	AllAddrZipTypes := SORT(getZipType + getAddrSIC, Seq);

	RollAddrZipTypes := ROLLUP(AllAddrZipTypes, LEFT.Seq = RIGHT.Seq, 
																	TRANSFORM(tempAddrZipTypeLayout,
																							SELF.Seq := LEFT.Seq,
																							SELF.IsMilitaryAddress := LEFT.IsMilitaryAddress OR RIGHT.IsMilitaryAddress,
																							SELF.IsPOBox := LEFT.IsPOBox OR RIGHT.IsPOBox,
																							SELF.IsPrisonAddress := LEFT.IsPrisonAddress OR RIGHT.IsPrisonAddress,
																							SELF.IsCommercial := LEFT.IsCommercial OR RIGHT.IsCommercial,
																							SELF.AddrZipMismatch := IF(LEFT.AddrZipMismatch = '0' OR RIGHT.AddrZipMismatch = '0', '0', // if we have a record with no mismatch, use it
																																				MAX(LEFT.AddrZipMismatch, RIGHT.AddrZipMismatch));
																							SELF := []));
				
	withAddrZipType := JOIN(withAdvoAttributes, RollAddrZipTypes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							IsPOBox := RIGHT.IsPOBox OR Address.isPOBox(LEFT.Clean_Input.Prim_Name);
																							IsResidential := LEFT.Input_Characteristics.InputAddrTypeNoID IN ['A', 'C'];
																							IsCommercial := RIGHT.IsCommercial OR LEFT.Input_Characteristics.InputAddrTypeNoID IN ['B', 'D'];
																							SELF.Verification.AddrZipType := MAP(LEFT.Clean_Input.Zip5 = '' 																	 																			=> '-1', // No Zip Code, can't calculate
																																									IsCommercial AND NOT (RIGHT.IsMilitaryAddress OR RIGHT.IsPrisonAddress OR IsPOBox OR IsResidential) => '5',  // Commercial (and not flagged as another category)
																																									IsResidential AND NOT (RIGHT.IsMilitaryAddress OR RIGHT.IsPrisonAddress OR IsPOBox OR IsCommercial) => '4',	// Residential (and not flagged as another category)
																																									RIGHT.IsPrisonAddress 																																							=> '3',  // Prison address
																																									RIGHT.IsMilitaryAddress 																																						=> '2',  // Military address
																																									IsPOBox																																														 	=> '1',  // PO Box (Based on Zip code or Prim_Name)
																																																																																											 	 '0'); // Unknown Addr/Zip Type
																							SELF.Verification.AddrZipMismatch := IF(TRIM(LEFT.Clean_Input.City) = '' OR TRIM(LEFT.Clean_Input.State) = '' OR TRIM(LEFT.Clean_Input.Zip5) = '', '-1',
																																									RIGHT.AddrZipMismatch);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);																	
													

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(Shell, 100), NAMED('Sample_Shell'));	
	// OUTPUT(CHOOSEN(RawFEINMatches, 100), NAMED('Sample_RawFEINMatches'));
	// OUTPUT(CHOOSEN(UniqueRawFEINMatches, 100), NAMED('Sample_UniqueRawFEINMatches'));
	// OUTPUT(CHOOSEN(BusinessHeaderRaw, 100), NAMED('Sample_BusinessHeaderRaw'));
	// OUTPUT(CHOOSEN(BusinessHeader, 100), NAMED('Sample_BusinessHeader'));
	// OUTPUT(CHOOSEN(FEINVerification, 100), NAMED('Sample_FEINVerification'));
	// OUTPUT(CHOOSEN(FEINVerificationRolled, 100), NAMED('Sample_FEINVerificationRolled'));
	// OUTPUT(CHOOSEN(withFEINVerification, 100), NAMED('Sample_withFEINVerification'));
	// OUTPUT(CHOOSEN(GongPhones, 100), NAMED('Sample_GongPhones'));
	// OUTPUT(CHOOSEN(GongPhonesRolled, 100), NAMED('Sample_GongPhonesRolled'));
	// OUTPUT(CHOOSEN(withGongPhones, 100), NAMED('Sample_withGongPhones'));
	// OUTPUT(CHOOSEN(WithAdvo, 100), NAMED('Sample_WithAdvo'));
	// OUTPUT(CHOOSEN(WithAdvoDD, 100), NAMED('Sample_WithAdvoDD'));
	// OUTPUT(CHOOSEN(RollAdvoResidential, 100), NAMED('Sample_RollAdvoResidential'));
	// OUTPUT(CHOOSEN(WithAdvoAttributes, 100), NAMED('Sample_WithAdvoAttributes'));
	// OUTPUT(CHOOSEN(getZipType, 100), NAMED('Sample_getZipType'));
	// OUTPUT(CHOOSEN(getAddrSIC, 100), NAMED('Sample_getAddrSIC'));
	// OUTPUT(CHOOSEN(AllAddrZipTypes, 100), NAMED('Sample_AllAddrZipTypes'));
	// OUTPUT(CHOOSEN(RollAddrZipTypes, 100), NAMED('Sample_RollAddrZipTypes'));
	// OUTPUT(CHOOSEN(withAddrZipType, 100), NAMED('Sample_withAddrZipType'));
	RETURN withAddrZipType;
END;													