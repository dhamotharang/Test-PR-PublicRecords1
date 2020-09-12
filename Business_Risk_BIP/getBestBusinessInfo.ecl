IMPORT Address, ADVO, BIPV2, BIPV2_Best, Business_Risk_BIP, Corp2, LN_PropertyV2, MDR, Risk_Indicators, RiskWise, STD, UT;

	// The following function determines the Best information for a particular Business. 
	EXPORT getBestBusinessInfo(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

			LayoutBestInformation := RECORD
				UNSIGNED seq;
				Business_Risk_BIP.Layouts.LayoutBestInfo;
				STRING1 AddrIsBest;
			END;	

      runShell := Options.BusShellVersion;
      ShellV31 := Business_Risk_BIP.Constants.BusShellVersion_v31;
      
			useSBFE := Options.DataPermissionMask[12] NOT IN Business_Risk_BIP.Constants.RESTRICTED_SET;

			UCase := STD.Str.ToUpperCase;

			// 1.  Get LN Best Info
			ds_BestInformationRaw := BIPV2_Best.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
                                    Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
                                    ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
                                    in_mod := linkingOptions,
                                    IncludeStatus := TRUE,
                                    JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
                                    JoinType := Options.KeepLargeBusinesses);

			// NOTE: this filter (proxid = 0) is only correct if we're doing a SELEID based level fetch
			// --which is the default FETCH LEVEL set at upper most roxie service level. The dataset
			// ds_BestInformationRaw actually contains Best records for every SeleID/ProxID variation.
			ds_BestInformationRawFilt := ds_BestInformationRaw(proxid = 0);	
			
			LayoutBestInformation xfm_SelectBestInformation( RECORDOF(ds_BestInformationRaw) le ) := TRANSFORM
				bestCompanyName     := le.Company_Name[1];
				bestCompanyAddress  := le.Company_Address[1];

				SELF.Seq                 		:= le.uniqueid;
				SELF.BestCompanyName      	:= bestCompanyName.Company_Name;	
				SELF.BestCompanyAddress1   := Address.Addr1FromComponents(bestCompanyAddress.Company_Prim_Range, bestCompanyAddress.Company_Predir, bestCompanyAddress.Company_Prim_Name, bestCompanyAddress.Company_Addr_Suffix, bestCompanyAddress.Company_Postdir, bestCompanyAddress.Company_Unit_Desig, bestCompanyAddress.Company_Sec_Range);
				SELF.BestCompanyCity       := IF( bestCompanyAddress.company_p_city_name != '', bestCompanyAddress.company_p_city_name, bestCompanyAddress.address_v_city_name );
				SELF.BestCompanyState      := bestCompanyAddress.company_st;
				SELF.BestCompanyZip        := bestCompanyAddress.company_zip5;
				SELF.BestCompanyPhone      := le.Company_Phone[1].Company_Phone;
				SELF.BestCompanyFEIN       := le.Company_FEIN[1].Company_FEIN;
				SELF.BestPrimRange := bestCompanyAddress.Company_Prim_Range;
				SELF.BestPreDir := bestCompanyAddress.Company_Predir;
				SELF.BestPrimName := bestCompanyAddress.Company_Prim_Name;
				SELF.BestAddrSuffix := bestCompanyAddress.Company_Addr_Suffix;
				SELF.BestPostDir := bestCompanyAddress.Company_Postdir;
				SELF.BestUnitDesig := bestCompanyAddress.Company_Unit_Desig;
				SELF.BestSecRange := bestCompanyAddress.Company_Sec_Range;
				SELF := [];
			END;
			
			ds_bestBusinessInfo := PROJECT( ds_BestInformationRawFilt, xfm_SelectBestInformation(LEFT) );

			ds_best_records := SORT( ds_bestBusinessInfo, seq );

      
      withBestRecordsV31 := JOIN(Shell, ds_best_records, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Best_Info.BestCompanyName := RIGHT.BestCompanyName;
																							SELF.Best_Info.BestCompanyAddress1 := RIGHT.BestCompanyAddress1;
																							SELF.Best_Info.BestCompanyCity := RIGHT.BestCompanyCity;
																							SELF.Best_Info.BestCompanyState := RIGHT.BestCompanyState;
																							SELF.Best_Info.BestCompanyZip := RIGHT.BestCompanyZip;
																							SELF.Best_Info.BestCompanyFEIN := RIGHT.BestCompanyFEIN;
																							SELF.Best_Info.BestCompanyPhone := RIGHT.BestCompanyPhone;
																							SELF.Best_Info.BestPrimRange := RIGHT.BestPrimRange;
																							SELF.Best_Info.BestPreDir := RIGHT.BestPreDir;
																							SELF.Best_Info.BestPrimName := RIGHT.BestPrimName;
																							SELF.Best_Info.BestAddrSuffix := RIGHT.BestAddrSuffix;
																							SELF.Best_Info.BestPostDir := RIGHT.BestPostDir;
																							SELF.Best_Info.BestUnitDesig := RIGHT.BestUnitDesig;
																							SELF.Best_Info.BestSecRange := RIGHT.BestSecRange;

                                              UseBest := LEFT.input_echo.SeleID <> 0 AND (LEFT.input_echo.Companyname = '' 
                                                                                     AND LEFT.input_echo.StreetAddress1 = ''
                                                                                     AND LEFT.input_echo.City = ''
                                                                                     AND LEFT.input_echo.State = ''
                                                                                     AND LEFT.input_echo.Zip = '');
                                              
                                              SELF.Input_Echo.CompanyName := IF(UseBest, RIGHT.BestCompanyName, LEFT.Input_Echo.CompanyName);
																							SELF.Input_Echo.StreetAddress1 := IF(UseBest, RIGHT.BestCompanyAddress1, LEFT.Input_Echo.StreetAddress1);
																							SELF.Input_Echo.City := IF(UseBest, RIGHT.BestCompanyCity, LEFT.Input_Echo.City);
																							SELF.Input_Echo.State := IF(UseBest, RIGHT.BestCompanyState, LEFT.Input_Echo.State);
																							SELF.Input_Echo.Zip := IF(UseBest, RIGHT.BestCompanyZip, LEFT.Input_Echo.Zip);
																							SELF.Input_Echo.fein := IF(UseBest, RIGHT.BestCompanyFEIN, LEFT.Input_Echo.fein);
																							SELF.Input_Echo.Phone10 := IF(UseBest, RIGHT.BestCompanyPhone, LEFT.Input_Echo.Phone10);
																							SELF.Input_Echo.prim_range := IF(UseBest, RIGHT.BestPrimRange, LEFT.Input_Echo.prim_range);
																							SELF.Input_Echo.predir := IF(UseBest, RIGHT.BestPreDir, LEFT.Input_Echo.predir);
																							SELF.Input_Echo.prim_name := IF(UseBest, RIGHT.BestPrimName, LEFT.Input_Echo.prim_name );
																							SELF.Input_Echo.addr_suffix := IF(UseBest, RIGHT.BestAddrSuffix, LEFT.Input_Echo.addr_suffix);
																							SELF.Input_Echo.postdir := IF(UseBest, RIGHT.BestPostDir, LEFT.Input_Echo.postdir);
																							SELF.Input_Echo.unit_desig := IF(UseBest, RIGHT.BestUnitDesig, LEFT.Input_Echo.unit_desig);
																							SELF.Input_Echo.sec_range := IF(UseBest, RIGHT.BestSecRange, LEFT.Input_Echo.sec_range);
                                              
                                              // Company Address Fields
                                              SELF.Clean_Input.CompanyName := IF(UseBest, RIGHT.BestCompanyName, LEFT.Input_Echo.CompanyName);
																							SELF.Clean_Input.StreetAddress1 := IF(UseBest, RIGHT.BestCompanyAddress1, LEFT.Input_Echo.StreetAddress1);;
																							// SELF.Clean_Input.StreetAddress2 := IF(UseBest, RIGHT.BestCompanyAddress2, LEFT.Input_Echo.StreetAddress2);;
																							SELF.Clean_Input.Prim_Range :=  IF(UseBest, RIGHT.BestPrimRange, LEFT.Input_Echo.prim_range);
																							SELF.Clean_Input.Predir := IF(UseBest, RIGHT.BestPreDir, LEFT.Input_Echo.predir);
																							SELF.Clean_Input.Prim_Name := IF(UseBest, RIGHT.BestPrimName, LEFT.Input_Echo.prim_name );
																							SELF.Clean_Input.Addr_Suffix := IF(UseBest, RIGHT.BestAddrSuffix, LEFT.Input_Echo.addr_suffix);
																							SELF.Clean_Input.Postdir := IF(UseBest, RIGHT.BestPostDir, LEFT.Input_Echo.postdir);
																							SELF.Clean_Input.Unit_Desig := IF(UseBest, RIGHT.BestUnitDesig, LEFT.Input_Echo.unit_desig);
																							SELF.Clean_Input.Sec_Range := IF(UseBest, RIGHT.BestSecRange, LEFT.Input_Echo.sec_range);
																							SELF.Clean_Input.City := IF(UseBest, RIGHT.BestCompanyCity, LEFT.Input_Echo.City);
																							SELF.Clean_Input.State := IF(UseBest, RIGHT.BestCompanyState, LEFT.Input_Echo.State);
																							// SELF.Clean_Input.Zip := IF(UseBest, RIGHT.BestCompanyZip.Zip + RIGHT.BestCompanyZip4, LEFT.input_echo.Zip + LEFT.input_echo.Zip4);
																							SELF.Clean_Input.Zip5 := IF(UseBest, RIGHT.BestCompanyZip, LEFT.Input_Echo.Zip);
                                              
                                              chkCompanyName := IF(UseBest, RIGHT.BestCompanyName, LEFT.Input_Echo.CompanyName);
                                              SELF.Verification.VerWatchlistNameMatch := IF(chkCompanyName = '', '-1', '1');
																							
                                              AddressPopulated		:= TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(RIGHT.BestPrimName) <> '' AND RIGHT.BestCompanyZip <> '';
																							NoScoreValue				:= 255; // This is what the various score functions return if blank is passed in
																							ZIPScore						:= IF(LEFT.Clean_Input.Zip5 <> '' AND RIGHT.BestCompanyZip <> '' AND LEFT.Clean_Input.Zip5[1] = RIGHT.BestCompanyZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Zip5, RIGHT.BestCompanyZip), NoScoreValue);
																							StateMatched				:= StringLib.StringToUpperCase(LEFT.Clean_Input.State) = StringLib.StringToUpperCase(RIGHT.BestCompanyState);
																							CityStateScore			:= IF(LEFT.Clean_Input.City <> '' AND LEFT.Clean_Input.State <> '' AND RIGHT.BestCompanyCity <> '' AND RIGHT.BestCompanyState <> '' AND StateMatched, 
																																				Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.City, LEFT.Clean_Input.State, RIGHT.BestCompanyCity, RIGHT.BestCompanyState, ''), NoScoreValue);
		
																							AddressScore := MAP(NOT AddressPopulated => NoScoreValue,
																																		AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue => NoScoreValue,
																																		Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Prim_Range, LEFT.Clean_Input.Prim_Name, LEFT.Clean_Input.Sec_Range, 
																																		RIGHT.BestPrimRange, RIGHT.BestPrimName, RIGHT.BestSecRange,
																																		ZIPScore, CityStateScore));
																							AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);
																							SELF.Verification.AddrIsBest := IF(AddressMatched, '1', '0');
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

			withBestRecordsEarly := JOIN(Shell, ds_best_records, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Best_Info.BestCompanyName := RIGHT.BestCompanyName;
																							SELF.Best_Info.BestCompanyAddress1 := RIGHT.BestCompanyAddress1;
																							SELF.Best_Info.BestCompanyCity := RIGHT.BestCompanyCity;
																							SELF.Best_Info.BestCompanyState := RIGHT.BestCompanyState;
																							SELF.Best_Info.BestCompanyZip := RIGHT.BestCompanyZip;
																							SELF.Best_Info.BestCompanyFEIN := RIGHT.BestCompanyFEIN;
																							SELF.Best_Info.BestCompanyPhone := RIGHT.BestCompanyPhone;
																							SELF.Best_Info.BestPrimRange := RIGHT.BestPrimRange;
																							SELF.Best_Info.BestPreDir := RIGHT.BestPreDir;
																							SELF.Best_Info.BestPrimName := RIGHT.BestPrimName;
																							SELF.Best_Info.BestAddrSuffix := RIGHT.BestAddrSuffix;
																							SELF.Best_Info.BestPostDir := RIGHT.BestPostDir;
																							SELF.Best_Info.BestUnitDesig := RIGHT.BestUnitDesig;
																							SELF.Best_Info.BestSecRange := RIGHT.BestSecRange;
                                              

                                                
																							AddressPopulated		:= TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(RIGHT.BestPrimName) <> '' AND RIGHT.BestCompanyZip <> '';
																							NoScoreValue				:= 255; // This is what the various score functions return if blank is passed in
																							ZIPScore						:= IF(LEFT.Clean_Input.Zip5 <> '' AND RIGHT.BestCompanyZip <> '' AND LEFT.Clean_Input.Zip5[1] = RIGHT.BestCompanyZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Zip5, RIGHT.BestCompanyZip), NoScoreValue);
																							StateMatched				:= StringLib.StringToUpperCase(LEFT.Clean_Input.State) = StringLib.StringToUpperCase(RIGHT.BestCompanyState);
																							CityStateScore			:= IF(LEFT.Clean_Input.City <> '' AND LEFT.Clean_Input.State <> '' AND RIGHT.BestCompanyCity <> '' AND RIGHT.BestCompanyState <> '' AND StateMatched, 
																																				Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.City, LEFT.Clean_Input.State, RIGHT.BestCompanyCity, RIGHT.BestCompanyState, ''), NoScoreValue);
		
																							AddressScore := MAP(NOT AddressPopulated => NoScoreValue,
																																		AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue => NoScoreValue,
																																		Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Prim_Range, LEFT.Clean_Input.Prim_Name, LEFT.Clean_Input.Sec_Range, 
																																		RIGHT.BestPrimRange, RIGHT.BestPrimName, RIGHT.BestSecRange,
																																		ZIPScore, CityStateScore));
																							AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);
																							SELF.Verification.AddrIsBest := IF(AddressMatched, '1', '0');
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

  withBestRecords := IF(runShell >= shellV31, withBestRecordsV31, withBestRecordsEarly);
  
  
	// Get best property info
	KAF := LN_PropertyV2.key_addr_fid(false);
	KASF := LN_PropertyV2.key_assessor_fid(FALSE /*isFCRA*/);
	proprec := RECORD
		UNSIGNED seq;
		UNSIGNED6		HistoryDate;
	  Business_Risk_BIP.Layouts.LayoutBestInfo ;
		string12 fares_id;
		// unsigned4 BestLotSize; 
		// unsigned4 BestLotSize12Mos
		// unsigned4 BestAssessedValue; 
		// unsigned4 BestAssessedValue12Mos;
		// unsigned4 BestBldgSize;
		// unsigned4 BestBldgSize12Mos;
	END;

	proprec get_property_by_addr(Shell le, KAF ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.HistoryDate := le.Clean_Input.HistoryDate;
		SELF.fares_id := ri.ln_fares_id;
		SELF := le.Best_Info;
		SELF := [];
	END;

	property_by_address := JOIN(withBestRecords, KAF,
						LEFT.Best_Info.BestPrimName<>'' AND
						keyed(LEFT.Best_Info.BestPrimName=RIGHT.prim_name) AND
						keyed(LEFT.Best_Info.BestPrimRange=RIGHT.prim_range) AND
						keyed(LEFT.Best_Info.BestCompanyZip=RIGHT.zip) AND
						keyed(LEFT.Best_Info.BestPreDir=RIGHT.predir) AND
						keyed(LEFT.Best_Info.BestPostDir=RIGHT.postdir) AND
						keyed(LEFT.Best_Info.BestAddrSuffix=RIGHT.suffix) AND
						keyed(LEFT.Best_Info.BestSecRange=RIGHT.sec_range) and
						keyed(right.source_code_2 = 'P'),
					   get_property_by_addr(LEFT,RIGHT), KEEP(100), LEFT OUTER,
					   ATMOST(
						   keyed(LEFT.Best_Info.BestPrimName=RIGHT.prim_name) AND
						   keyed(LEFT.Best_Info.BestPrimRange=RIGHT.prim_range) AND
						   keyed(LEFT.Best_Info.BestCompanyZip=RIGHT.zip) AND
						   keyed(LEFT.Best_Info.BestPreDir=RIGHT.predir) AND
						   keyed(LEFT.Best_Info.BestPostDir=RIGHT.postdir) AND
						   keyed(LEFT.Best_Info.BestAddrSuffix=RIGHT.suffix) AND
						   keyed(LEFT.Best_Info.BestSecRange=RIGHT.sec_range) and
						   keyed(right.source_code_2 = 'P'),
						   Business_Risk_BIP.Constants.Limit_Default
					   ));
						 
						 
	proprec get_Assessements(property_by_address le, KASF ri) :=		TRANSFORM			 
					SELF.BestLotSize	:= StringLib.StringFilter(ri.land_square_footage, '0123456789');					 
          SELF.BestBldgSize := StringLib.StringFilter(ri.Building_Area, '0123456789');	
				  SELF.BestAssessedValue := (STRING)max((INTEGER)ri.assessed_total_value, (INTEGER)ri.market_total_value);	
					SELF := LE;
					SELF := [];
	END;
	
	PropertyAssessments := JOIN(DEDUP(SORT(property_by_address, Seq, Fares_ID), Seq, Fares_ID), KASF, 
															KEYED(LEFT.Fares_ID = RIGHT.LN_Fares_ID) 
															AND (unsigned3)((STRING)right.proc_date)[1..6] <= left.historydate
															AND (unsigned3)right.recording_date[1..6] <= left.historydate,
															get_Assessements(LEFT,RIGHT),
															ATMOST(keyed(LEFT.fares_id=RIGHT.ln_fares_id),Business_Risk_BIP.Constants.Limit_Assessments));
															
	PropertyBusnAssessRolled := ROLLUP(SORT(PropertyAssessments, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
																					SELF.BestLotSize := MAX(LEFT.BestLotSize, RIGHT.BestLotSize);
																					SELF.BestBldgSize := MAX(LEFT.BestBldgSize, RIGHT.BestBldgSize);
																					SELF.BestAssessedValue := MAX(LEFT.BestAssessedValue, RIGHT.BestAssessedValue);
																					SELF := LEFT));
																					
	withPropertyAssess := JOIN(withBestRecords, PropertyBusnAssessRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Best_Info.BestLotSize := (STRING)Business_Risk_BIP.Common.capNum((UNSIGNED)RIGHT.BestLotSize, -1, 999999999);
																							SELF.Best_Info.BestAssessedValue := (STRING)Business_Risk_BIP.Common.capNum((UNSIGNED)RIGHT.BestAssessedValue, -1, 999999999);
																							SELF.Best_Info.BestBldgSize := (STRING)Business_Risk_BIP.Common.capNum((UNSIGNED)RIGHT.BestBldgSize, -1, 999999999);
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
		STRING2 BestTypeAdvo;
		STRING2 BestVacancy;
	END;
	
	WithAdvo := JOIN(withBestRecords, Advo.Key_Addr1_history,
					LEFT.Best_Info.BestCompanyZip != '' AND 
					LEFT.Best_Info.BestPrimRange != '' AND
					KEYED(LEFT.Best_Info.BestCompanyZip = RIGHT.zip) AND
					KEYED(LEFT.Best_Info.BestPrimRange = RIGHT.prim_range) AND
					KEYED(LEFT.Best_Info.BestPrimName = RIGHT.prim_name) AND
					KEYED(LEFT.Best_Info.BestAddrSuffix = RIGHT.addr_suffix) AND
					KEYED(LEFT.Best_Info.BestPredir = RIGHT.predir) AND
					KEYED(LEFT.Best_Info.BestPostdir = RIGHT.postdir) AND
					KEYED(LEFT.Best_Info.BestSecRange = RIGHT.sec_range)  AND
					// Check history date
					((UNSIGNED)RIGHT.date_first_seen < (UNSIGNED)Risk_Indicators.iid_constants.full_history_date(LEFT.Clean_Input.HistoryDate)) AND
					// Check DRM for Advo restriction					
					Options.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] <> '1' and
					// ADVO not allowed in marketing mode
					Options.MarketingMode = 0, 
					TRANSFORM(tempAddrZipTypeLayout,
											SELF.Seq := LEFT.Seq,
											SELF.BestTypeAdvo   := RIGHT.Residential_or_Business_Ind ,
											SELF.BestVacancy := MAP(TRIM(RIGHT.Address_Vacancy_Indicator)='N' => '1',
																							TRIM(RIGHT.Address_Vacancy_Indicator)='Y' => '2',
																																													 ''),
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
																							SELF.BestTypeAdvo := IF(LEFT.BestTypeAdvo = '', RIGHT.BestTypeAdvo, LEFT.BestTypeAdvo),
																							SELF.BestVacancy := IF(LEFT.BestVacancy = '', RIGHT.BestVacancy, LEFT.BestVacancy),
																							SELF := []));
																		
	withAdvoAttributes := IF(Options.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] = '1', withPropertyAssess,
													JOIN(withPropertyAssess, RollAdvoResidential, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							AddressPopulated := TRIM(LEFT.Best_Info.BestCompanyZip) <> '' AND TRIM(LEFT.Best_Info.BestPrimName) <> '';
																							SELF.Best_Info.BestTypeAdvo := MAP(NOT AddressPopulated 														 => '-1',
																																								AddressPopulated AND TRIM(RIGHT.BestTypeAdvo) = '' => '0',
																																								AddressPopulated AND TRIM(RIGHT.BestTypeAdvo) <> '' => RIGHT.BestTypeAdvo,
																																																																			'-1');
																							SELF.Best_Info.BestVacancy := MAP(NOT AddressPopulated 														 	=> '-1',
																																								AddressPopulated AND TRIM(RIGHT.BestVacancy) = '' => '0',
																																								AddressPopulated AND TRIM(RIGHT.BestVacancy) <> '' => RIGHT.BestVacancy,
																																																																			'-1');
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW));																	
																		
	// ------ Determine Addr/Zip Type ------- //																	
	getZipType := JOIN(withBestRecords, RiskWise.Key_CityStZip, (INTEGER)LEFT.Best_Info.BestCompanyZip > 0 AND KEYED(LEFT.Best_Info.BestCompanyZip = RIGHT.Zip5),
																	TRANSFORM(tempAddrZipTypeLayout,
																							SELF.Seq := LEFT.Seq;
																							SELF.IsMilitaryAddress := RIGHT.ZipClass = 'M';
																							SELF.IsPOBox := RIGHT.ZipClass = 'P';
																							SELF.IsCommercial := RIGHT.ZipClass = 'U';
																							SELF := []),
																	ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));
	
	tempAddrZipTypeLayout getSICCodes(Shell le, Risk_Indicators.Key_HRI_Address_To_SIC ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.IsPrisonAddress := ri.sic_code = '2225';
		SELF.IsCommercial := (INTEGER)ri.sic_code > 0;
		SELF := [];
	END;

	getAddrSIC := JOIN(withBestRecords, Risk_Indicators.Key_HRI_Address_To_SIC,
																	LEFT.Best_Info.BestCompanyZip != '' AND LEFT.Best_Info.BestPrimName != '' AND
																	KEYED(LEFT.Best_Info.BestCompanyZip = RIGHT.z5) AND KEYED(LEFT.Best_Info.BestPrimName = RIGHT.Prim_Name) AND KEYED(LEFT.Best_Info.BestAddrSuffix = RIGHT.Suffix) AND 
																	KEYED(LEFT.Best_Info.BestPreDir = RIGHT.predir) AND KEYED(LEFT.Best_Info.BestPostDir = RIGHT.postdir) AND KEYED(LEFT.Best_Info.BestPrimRange = RIGHT.prim_range) AND 
																	KEYED(Ut.NNEQ(LEFT.Best_Info.BestSecRange, RIGHT.sec_range)) AND 
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
																							SELF := []));
				
	withAddrZipType := JOIN(withAdvoAttributes, RollAddrZipTypes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							IsPOBox := RIGHT.IsPOBox OR Address.isPOBox(LEFT.Best_Info.BestPrimName);
																							IsResidential := LEFT.Best_Info.BestTypeAdvo IN ['A', 'C'];
																							IsCommercial := RIGHT.IsCommercial OR LEFT.Best_Info.BestTypeAdvo IN ['B', 'D'];
																							SELF.Best_Info.BestZipcodeType := MAP(LEFT.Best_Info.BestCompanyZip = '' 																	 																			=> '-1', // No Zip Code, can't calculate
																																									IsCommercial AND NOT (RIGHT.IsMilitaryAddress OR RIGHT.IsPrisonAddress OR IsPOBox OR IsResidential) => '5',  // Commercial (and not flagged as another category)
																																									IsResidential AND NOT (RIGHT.IsMilitaryAddress OR RIGHT.IsPrisonAddress OR IsPOBox OR IsCommercial) => '4',	// Residential (and not flagged as another category)
																																									RIGHT.IsPrisonAddress 																																							=> '3',  // Prison address
																																									RIGHT.IsMilitaryAddress 																																						=> '2',  // Military address
																																									IsPOBox																																														 	=> '1',  // PO Box (Based on Zip code or Prim_Name)
																																																																																											 	 '0'); // Unknown Addr/Zip Type
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	// ------ Determine Address Type ------- //		
	CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
	                                         Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
	                                         0, // ScoreThreshold --> 0 = Give me everything
																					 Business_Risk_BIP.Constants.Limit_Default,
																					 Options.KeepLargeBusinesses
													);

	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(CorpFilings_raw, Shell, CorpFilings_seq);

 // Calculate the source code by state to restrict records for Marketing properly. We'll 
 // borrow corp_src_type for the state source code.
 CorpFilings_withSrcCode := 
  PROJECT(
    CorpFilings_seq,
    TRANSFORM( RECORDOF(CorpFilings_seq),
      SELF.corp_src_type := MDR.sourceTools.fCorpV2( LEFT.corp_key, LEFT.corp_state_origin ),
      SELF := LEFT
    ) );
    
	// Filter out records after our history date.
	CorpFilings_recs := Business_Risk_BIP.Common.FilterRecords(CorpFilings_withSrcCode, dt_first_seen, dt_vendor_first_reported, corp_src_type, AllowedSourcesSet);
	
	CorpFilings_Recs_BestAddr := JOIN(CorpFilings_recs, withBestRecords, LEFT.seq = RIGHT.seq,
		TRANSFORM({RECORDOF(LEFT), BOOLEAN BestAddressMatched},
			NoScoreValue 						:= 255;
			BestAddressPopulated		:= TRIM(RIGHT.Best_Info.BestPrimName) <> '' AND TRIM(RIGHT.Best_Info.BestCompanyZip) <> '' AND TRIM(LEFT.corp_addr1_prim_name) <> '' AND TRIM(LEFT.corp_addr1_zip5) <> '';
			BestZIPScore						:= IF(RIGHT.Best_Info.BestCompanyZip <> '' AND LEFT.corp_addr1_zip5 <> '' AND RIGHT.Best_Info.BestCompanyZip[1] = LEFT.corp_addr1_zip5[1], Risk_Indicators.AddrScore.ZIP_Score(RIGHT.Best_Info.BestCompanyZip, LEFT.corp_addr1_zip5), NoScoreValue);
			BestCityStateScore			:= IF(BestZIPScore <> NoScoreValue AND RIGHT.Best_Info.BestCompanyCity <> '' AND RIGHT.Best_Info.BestCompanyState <> '' AND LEFT.corp_addr1_p_city_name <> '' AND LEFT.corp_addr1_state <> '' AND RIGHT.Best_Info.BestCompanyState[1] = LEFT.corp_addr1_state[1], Risk_Indicators.AddrScore.CityState_Score(RIGHT.Best_Info.BestCompanyCity, RIGHT.Best_Info.BestCompanyState, LEFT.corp_addr1_p_city_name, LEFT.corp_addr1_state, ''), NoScoreValue);
			BestCityStateZipMatched	:= Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore) AND BestAddressPopulated;
			SELF.BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(IF(BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue, NoScoreValue, 
																						Risk_Indicators.AddrScore.AddressScore(RIGHT.Best_Info.BestPrimRange, RIGHT.Best_Info.BestPrimName, RIGHT.Best_Info.BestSecRange, 
																						LEFT.corp_addr1_prim_range, LEFT.corp_addr1_prim_name, LEFT.corp_addr1_sec_range,
																						BestZIPScore, BestCityStateScore)));
			SELF := LEFT),
		LEFT OUTER, KEEP(1), ATMOST(100));
		
	CorpFilings_sorted := SORT(CorpFilings_Recs_BestAddr(BestAddressMatched), seq, -corp_process_date, corp_key, record);

	CorpFilings_having_BusTypeAddr_most_recent := DEDUP(CorpFilings_sorted(corp_address1_type_cd != '' OR corp_address1_type_desc != ''), seq);

	withBusTypeAddress :=JOIN(withAddrZipType, CorpFilings_having_BusTypeAddr_most_recent,LEFT.seq = RIGHT.seq, 
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,			
				SELF.Best_Info.BestTypeOther := Business_Risk_BIP.Common.GetBusinessType(RIGHT.corp_address1_type_cd, RIGHT.corp_address1_type_desc),
				SELF := LEFT),
		LEFT OUTER, KEEP(1), ATMOST(100), FEW);

  // *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(ds_BestInformationRaw, 100), NAMED('Sample_ds_BestInformationRaw'));
	// OUTPUT(CHOOSEN(ds_BestInformationRawFilt, 100), NAMED('Sample_ds_BestInformationRawFilt'));
	// OUTPUT(CHOOSEN(ds_bestBusinessInfo, 100), NAMED('Sample_ds_bestBusinessInfo'));
	// OUTPUT(CHOOSEN(ds_best_records, 100), NAMED('Sample_ds_best_records'));
	// OUTPUT(CHOOSEN(withBestRecords, 100), NAMED('Sample_withBestRecords'));
  // OUTPUT(CHOOSEN(withBestRecordsEarly, 100), NAMED('Sample_withBestRecordsEarly'));
  // OUTPUT(CHOOSEN(withBestRecordsV31, 100), NAMED('Sample_withBestRecordsV31'));
  // OUTPUT(CHOOSEN(Shell, 100), NAMED('Sample_ShellV31'));
	// OUTPUT(CHOOSEN(property_by_address, 100), NAMED('Sample_property_by_address'));
	// OUTPUT(CHOOSEN(PropertyAssessments, 100), NAMED('Sample_PropertyAssessments'));
	// OUTPUT(CHOOSEN(PropertyBusnAssessRolled, 100), NAMED('Sample_PropertyBusnAssessRolled'));
	// OUTPUT(CHOOSEN(withPropertyAssess, 100), NAMED('Sample_withPropertyAssess'));
	// OUTPUT(CHOOSEN(WithAdvo, 100), NAMED('Sample_WithAdvo'));
	// OUTPUT(CHOOSEN(withAdvoDD, 100), NAMED('Sample_withAdvoDD'));
	// OUTPUT(CHOOSEN(RollAdvoResidential, 100), NAMED('Sample_RollAdvoResidential'));
	// OUTPUT(CHOOSEN(withAdvoAttributes, 100), NAMED('Sample_withAdvoAttributes'));
	// OUTPUT(CHOOSEN(getZipType, 100), NAMED('Sample_getZipType'));
	// OUTPUT(CHOOSEN(getAddrSIC, 100), NAMED('Sample_getAddrSIC'));
	// OUTPUT(CHOOSEN(AllAddrZipTypes, 100), NAMED('Sample_AllAddrZipTypes'));
	// OUTPUT(CHOOSEN(RollAddrZipTypes, 100), NAMED('Sample_RollAddrZipTypes'));
	// OUTPUT(CHOOSEN(withAddrZipType, 100), NAMED('Sample_withAddrZipType'));

	RETURN withBusTypeAddress;
END;