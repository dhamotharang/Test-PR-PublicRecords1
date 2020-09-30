IMPORT Address, ADVO, BIPV2, Risk_Indicators, RiskWise, UT;

EXPORT getInputBasedSources(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

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
					Options.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] <> '1' and
					// ADVO not allowed in marketing mode
					Options.MarketingMode = 0, 
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
																		
	withAdvoAttributes := IF(Options.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] = '1', Shell,
													JOIN(Shell, RollAdvoResidential, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							AddressPopulated_v22 := TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '';
                                              AddressPopulated_v30 := LEFT.Input.InputCheckBusAddrZip = '1';
                                              AddressPopulated := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, AddressPopulated_v30, AddressPopulated_v22);
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