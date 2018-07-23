IMPORT BankruptcyV3, BIPV2, Business_Risk_BIP, Data_Services, Doxie_Files, EASI, Liensv2, LN_PropertyV2, MDR, PAW, Risk_Indicators, RiskWise, UT;

EXPORT getAssociateSources(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION
											 
	MinAssociatesNeededToCalculate := 0; // Legal keeps changing their mind as to how many Associates are needed to return values, making this a variable up top should they change again.
											 
	seqContactInfo := NORMALIZE(Shell, LEFT.ContactDIDs, TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts, SELF := RIGHT));

	// ----- EASI Census Data (Non-Archivable) -----
	EASIRaw := JOIN(seqContactInfo, Easi.Key_Easi_Census, LEFT.Geo_Link <> '' AND KEYED(LEFT.Geo_Link = RIGHT.GeoLink),
											TRANSFORM({RECORDOF(LEFT), INTEGER TotalNeighborhoodCrime}, 
														SELF.TotalNeighborhoodCrime := (INTEGER)RIGHT.TotCrime;
														SELF := LEFT),
											LEFT OUTER, KEEP(1), ATMOST(100));
	
	// Count the number of unique Associates per Seq, and count the number that live in a high crime neighborhood
	EASIStats := TABLE(EASIRaw, 
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 HighCrimeAssociates := COUNT(GROUP, TotalNeighborhoodCrime >= 140) // Total Crime >= 140 is considered a high crime neighborhood
		},
		Seq);
	
	withEASI := JOIN(Shell, EASIStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateHighCrimeAddrCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.HighCrimeAssociates, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);
	
	// ----- Felony Data -----
	OffenderRaw := JOIN(seqContactInfo, Doxie_Files.Key_Offenders_Risk, LEFT.DID > 0 AND KEYED(LEFT.DID = RIGHT.SDID) AND 
									RIGHT.criminal_offender_level='4' AND RIGHT.offense_score='F' AND 
									(((UNSIGNED3)(RIGHT.Earliest_Offense_Date[1..6]) < LEFT.HistoryDate AND (UNSIGNED)RIGHT.Earliest_Offense_Date > 0) OR 
									((UNSIGNED)RIGHT.Earliest_Offense_Date = 0 AND  (UNSIGNED)RIGHT.Offense.Arr_Date[1..6] < LEFT.HistoryDate AND (UNSIGNED)RIGHT.Offense.Arr_Date > 0)), 
											TRANSFORM({RECORDOF(LEFT), UNSIGNED3 FelonyCount, UNSIGNED3 CurrentAssociateFelonyCount},
														IsFelony := RIGHT.Criminal_Offender_Level = '4' AND RIGHT.Offense_Score = 'F';
														SELF.FelonyCount := IF(IsFelony, 1, 0);
														SELF.CurrentAssociateFelonyCount := IF(IsFelony AND LEFT.IsCurrent, 1, 0);
														SELF := LEFT),
											LEFT OUTER, ATMOST(100));
	
	OffenderRolled := ROLLUP(SORT(OffenderRaw, Seq, DID), LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT),
														SELF.FelonyCount := LEFT.FelonyCount + RIGHT.FelonyCount;
														SELF.CurrentAssociateFelonyCount := LEFT.CurrentAssociateFelonyCount + RIGHT.CurrentAssociateFelonyCount;
														SELF := LEFT));
	
	// Count the number of associates per Seq, Sum up how many total felonies those associate have, and count how many associates have felonies
	OffenderStats := TABLE(OffenderRolled,
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 AssociateFelonyCount := SUM(GROUP, FelonyCount),
		UNSIGNED8 AssociateCountWithFelony := COUNT(GROUP, FelonyCount >= 1),
		UNSIGNED8 AssociateCurrentCountWithFelony := COUNT(GROUP, CurrentAssociateFelonyCount >=1)
		},
		Seq);
	withOffender := JOIN(withEASI, OffenderStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateFelonyCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateFelonyCount, -1, 999999), '-1');
			SELF.Associates.AssociateCountWithFelony := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCountWithFelony, -1, 999999), '-1');
			SELF.Associates.AssociateCurrentCountWithFelony := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentCountWithFelony, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);
	
	// ----- Bankruptcy -----
	BkBuildDate := Risk_Indicators.get_Build_date('Bankruptcy_daily');
	
	BankruptcyTMSID := JOIN(seqContactInfo, BankruptcyV3.Key_BankruptcyV3_DID(FALSE /*isFCRA*/), LEFT.DID > 0 AND KEYED(LEFT.DID = RIGHT.DID),
											TRANSFORM({RECORDOF(LEFT), STRING50 bk_tmsid, STRING5 court_code,	STRING7 case_num},
															SELF.BK_TMSID := RIGHT.TMSID;
															SELF.Court_Code := RIGHT.Court_Code;
															SELF.Case_Num := RIGHT.Case_Number;
															SELF := LEFT), LEFT OUTER, KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
															
	BankruptcyRaw := JOIN(BankruptcyTMSID, BankruptcyV3.key_bankruptcyv3_search_full_bip(), LEFT.BK_TMSID <> '' AND KEYED(LEFT.BK_TMSID = RIGHT.TMSID) AND
												RIGHT.Name_Type = 'D' AND (UNSIGNED)RIGHT.DID = LEFT.DID AND (UNSIGNED)(RIGHT.Date_Filed[1..6]) < LEFT.HistoryDate AND (UNSIGNED)RIGHT.Date_Filed > 0,
											TRANSFORM({RECORDOF(LEFT), UNSIGNED3 BankruptcyCount, UNSIGNED3 BankruptcyCount1Year, UNSIGNED3 CurrentAssociateBankruptcyCount},
															DismissedBankruptcy := StringLib.StringToUpperCase(RIGHT.disposition) = 'DISMISSED';
															TodaysDate := Business_Risk_BIP.Common.todaysDate(BkBuildDate, LEFT.HistoryDate);
															IsBankruptcy := DismissedBankruptcy = FALSE AND RIGHT.TMSID <> ''
                                              AND (Options.BusShellVersion < Business_Risk_BIP.Constants.BusShellVersion_v30 OR
                                                     UT.DaysApart(TodaysDate, RIGHT.Date_Filed) <= ut.DaysInNYears(10));
															SELF.BankruptcyCount := IF(IsBankruptcy, 1, 0);
															SELF.BankruptcyCount1Year := IF(IsBankruptcy AND UT.DaysApart(TodaysDate, RIGHT.Date_Filed) <= Business_Risk_BIP.Constants.OneYear, 1, 0);
															SELF.CurrentAssociateBankruptcyCount := IF(IsBankruptcy AND LEFT.IsCurrent, 1, 0);
															SELF := LEFT), LEFT OUTER, KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	BankruptcyRawUnique := DEDUP(SORT(BankruptcyRaw, Seq, DID, BK_TMSID, Case_Num), Seq, DID, BK_TMSID, Case_Num);
	
	BankruptcyRolled := ROLLUP(SORT(BankruptcyRawUnique, Seq, DID), LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), 
															SELF.BankruptcyCount := LEFT.BankruptcyCount + RIGHT.BankruptcyCount;
															SELF.BankruptcyCount1Year := LEFT.BankruptcyCount1Year + RIGHT.BankruptcyCount1Year;
															SELF.CurrentAssociateBankruptcyCount := LEFT.CurrentAssociateBankruptcyCount + RIGHT.CurrentAssociateBankruptcyCount;
															SELF := LEFT));
	
	// Count the number of associates per Seq, Sum up how many total bankruptcies those associate have, how many total bankruptcies those associates have in the past year, and count how many associates have bankruptcies
	BankruptcyStats := TABLE(BankruptcyRolled,
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 AssociateBankruptcyCount := SUM(GROUP, BankruptcyCount),
    // In version 3.0 and up, AssociateBankruptcyCount1Year is a count of associates with bankruptcies.
    // In previous versions, AssociateBankruptcyCount1Year is a count of bankruptcies associates have.
		UNSIGNED8 AssociateBankruptcyCount1Year := SUM(GROUP, BankruptcyCount1Year),
		UNSIGNED8 AssociateBankruptcyCount1Year_v30 := COUNT(GROUP, BankruptcyCount1Year >= 1),
		UNSIGNED8 AssociateCountWithBankruptcy := COUNT(GROUP, BankruptcyCount >= 1),
		UNSIGNED8 AssociateCurrentCountWithBankruptcy := COUNT(GROUP, CurrentAssociateBankruptcyCount >= 1)
		},
		Seq);
	withBankruptcy := JOIN(withOffender, BankruptcyStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateBankruptCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateBankruptcyCount, -1, 999999), '-1');
			AssociateBankrupt1YearCount := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, RIGHT.AssociateBankruptcyCount1Year_v30, RIGHT.AssociateBankruptcyCount1Year);
      SELF.Associates.AssociateBankrupt1YearCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(AssociateBankrupt1YearCount, -1, 999999), '-1');
			SELF.Associates.AssociateCountWithBankruptcy := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCountWithBankruptcy, -1, 999999), '-1');
			SELF.Associates.AssociateCurrentCountWithBankruptcy := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentCountWithBankruptcy, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);
	
	
	
	// ----- Liens/Judgments -----
	// Risk_Indicators.Boca_Shell_Derogs_Hist
	// liensv2.key_liens_DID (DID search, get TMSID/RMSID)
	// LiensV2.key_liens_main_ID (TMSID/RMSID search)
	// keyed(left.tmsid=right.tmsid) and keyed(LEFT.rmsid=RIGHT.rmsid) AND right.name_type='D' and (unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate
	LienBuildDate := Risk_Indicators.get_Build_Date('liens_build_version');
	
	LienJudgmentTMSIDRaw := JOIN(seqContactInfo, Liensv2.Key_Liens_DID, LEFT.DID > 0 AND KEYED(LEFT.DID = RIGHT.DID),
											TRANSFORM({RECORDOF(LEFT), STRING50 tmsid, STRING50 rmsid},
															SELF.TMSID := RIGHT.TMSID;
															SELF.RMSID := RIGHT.RMSID;
															SELF := LEFT), LEFT OUTER, KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	LienJudgmentTMSID := DEDUP(SORT(LienJudgmentTMSIDRaw, Seq, DID, TMSID, RMSID), Seq, DID, TMSID, RMSID);
															
	LienJudgmentRaw := JOIN(LienJudgmentTMSID, LiensV2.key_liens_main_ID, LEFT.TMSID <> '' AND LEFT.RMSID <> '' AND KEYED(LEFT.TMSID = RIGHT.TMSID AND LEFT.RMSID = RIGHT.RMSID) AND
												(((UNSIGNED)(RIGHT.Orig_Filing_Date[1..6]) < LEFT.HistoryDate AND (UNSIGNED)RIGHT.Orig_Filing_Date > 0) 
												OR ((UNSIGNED)RIGHT.Orig_Filing_Date = 0 AND (UNSIGNED)RIGHT.Process_Date[1..6] < LEFT.HistoryDate AND (UNSIGNED)RIGHT.Process_Date > 0)) AND
												TRIM(StringLib.StringToUpperCase(RIGHT.Filing_Type_Desc)) NOT IN Risk_Indicators.iid_constants.set_Invalid_Liens_50, // Ignore certain Lien types - matches Consumer Shell 5.0
											TRANSFORM({RECORDOF(LEFT), UNSIGNED3 LienCount, UNSIGNED3 CurrentAssociateLienCount, UNSIGNED3 JudgmentCount, UNSIGNED3 CurrentAssociateJudgmentCount, STRING8 Orig_Filing_Date, STRING8 Release_Date},
															FilingType := StringLib.StringToUpperCase(RIGHT.Filing_Type_Desc);
															Type_Category := MAP(FilingType IN Risk_Indicators.iid_constants.set_Invalid_Liens_50	=> 'Invalid',
																									 FilingType IN Risk_Indicators.iid_constants.setSuits           	=> 'Judgment',
																									 FilingType IN Risk_Indicators.iid_constants.setSmallClaims    		=> 'Judgment',
																									 FilingType IN Risk_Indicators.iid_constants.setFederalTax     		=> 'Lien',
																									 FilingType IN Risk_Indicators.iid_constants.setForeclosure     	=> 'Lien',
																									 FilingType IN Risk_Indicators.iid_constants.setLandlordTenant 		=> 'Lien',
																									 FilingType IN Risk_Indicators.iid_constants.setLisPendens     		=> 'Lien',
																									 FilingType IN Risk_Indicators.iid_constants.setOtherTax       		=> 'Lien',
																									 FilingType IN Risk_Indicators.iid_constants.setMechanicsLiens 		=> 'Lien',
																									 FilingType IN Risk_Indicators.iid_constants.setCivilJudgment  		=> 'Judgment',
																									 FilingType NOT IN 
																										 [ 
																											 Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
																											 Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setOtherTax + 
																											 Risk_Indicators.iid_constants.setSmallClaims + Risk_Indicators.iid_constants.setForeclosure
																										 ]  => 'Lien',
																									 'Lien' // default
																								 );
															TodaysDate := Business_Risk_BIP.Common.todaysDate(LienBuildDate, LEFT.HistoryDate);
															IsLien := Type_Category = 'Lien' AND UT.DaysApart(TodaysDate, RIGHT.Orig_Filing_Date) <= UT.DaysInNYears(7);
															IsJudgment := Type_Category = 'Judgment' AND UT.DaysApart(TodaysDate, RIGHT.Orig_Filing_Date) <= UT.DaysInNYears(7);
															SELF.LienCount := IF(IsLien, 1, 0);
															SELF.CurrentAssociateLienCount := IF(IsLien AND LEFT.IsCurrent, 1, 0);
															SELF.JudgmentCount := IF(IsJudgment, 1, 0);
															SELF.CurrentAssociateJudgmentCount := IF(IsJudgment AND LEFT.IsCurrent, 1, 0);
															SELF.Orig_Filing_Date := RIGHT.Orig_Filing_Date;
															SELF.Release_Date := MAP(((INTEGER)RIGHT.release_date[1..6]) <= LEFT.HistoryDate	=> RIGHT.release_date,
																																																									 Business_Risk_BIP.Constants.MissingDate);
															SELF := LEFT), LEFT OUTER, KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	// Get the "best" count per TMSID
	LienJudgmentRolledTMSID := ROLLUP(SORT(LienJudgmentRaw, Seq, DID, TMSID, -Orig_Filing_Date, -Release_Date), LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.TMSID = RIGHT.TMSID, TRANSFORM(RECORDOF(LEFT), 
															SELF.LienCount := MAX(LEFT.LienCount, RIGHT.LienCount); // Only keep 1 Lien count per TMSID, thus MAX instead of adding together
															SELF.CurrentAssociateLienCount := MAX(LEFT.CurrentAssociateLienCount, RIGHT.CurrentAssociateLienCount); // Only keep 1 Lien count per TMSID, thus MAX instead of adding together
															SELF.JudgmentCount := MAX(LEFT.JudgmentCount, RIGHT.JudgmentCount); // Only keep 1 Judgment count per TMSID, thus MAX instead of adding together
															SELF.CurrentAssociateJudgmentCount := MAX(LEFT.CurrentAssociateJudgmentCount, RIGHT.CurrentAssociateJudgmentCount); // Only keep 1 Judgment count per TMSID, thus MAX instead of adding together
															SELF := LEFT));
	
	// Get the count per DID
	LienJudgmentRolled := ROLLUP(SORT(LienJudgmentRolledTMSID, Seq, DID), LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), 
															SELF.LienCount := LEFT.LienCount + RIGHT.LienCount;
															SELF.CurrentAssociateLienCount := LEFT.CurrentAssociateLienCount + RIGHT.CurrentAssociateLienCount;
															SELF.JudgmentCount := LEFT.JudgmentCount + RIGHT.JudgmentCount;
															SELF.CurrentAssociateJudgmentCount := LEFT.CurrentAssociateJudgmentCount + RIGHT.CurrentAssociateJudgmentCount;
															SELF := LEFT));
	
	// Count the number of associates per Seq, Sum up how many total Liens/Judgments those associate have, and count how many associates have Liens/Judgments
	LienJudgmentStats := TABLE(LienJudgmentRolled,
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 AssociateLienCount := SUM(GROUP, LienCount),
		UNSIGNED8 AssociateCountWithLien := COUNT(GROUP, LienCount >= 1),
		UNSIGNED8 AssociateCurrentCountWithLien := COUNT(GROUP, CurrentAssociateLienCount >= 1),
		UNSIGNED8 AssociateJudgmentCount := SUM(GROUP, JudgmentCount),
		UNSIGNED8 AssociateCountWithJudgment := COUNT(GROUP, JudgmentCount >= 1),
		UNSIGNED8 AssociateCurrentCountWithJudgment := COUNT(GROUP, CurrentAssociateJudgmentCount >= 1)
		},
		Seq);
	withLienJudgment := JOIN(withBankruptcy, LienJudgmentStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateLienCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateLienCount, -1, 999999), '-1');
			SELF.Associates.AssociateCountWithLien := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCountWithLien, -1, 999999), '-1');
			SELF.Associates.AssociateCurrentCountWithLien := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentCountWithLien, -1, 999999), '-1');
			SELF.Associates.AssociateJudgmentCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateJudgmentCount, -1, 999999), '-1');
			SELF.Associates.AssociateCountWithJudgment := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCountWithJudgment, -1, 999999), '-1');
			SELF.Associates.AssociateCurrentCountWithJudgment := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentCountWithJudgment, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);
	
	
	// ----- HighRiskAddress -----
	GetZipClass := JOIN(seqContactInfo, RiskWise.Key_CityStZip, LEFT.Zip <> '' AND KEYED(LEFT.Zip = RIGHT.Zip5),
											TRANSFORM({RECORDOF(LEFT), STRING1 ZipClass},
														SELF.ZipClass := RIGHT.ZipClass;
														SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));
	HighRiskRaw := JOIN(GetZipClass, Risk_Indicators.Key_HRI_Address_To_SIC, LEFT.Zip <> '' AND LEFT.Prim_Name <> '' AND
									KEYED(LEFT.Zip = RIGHT.Z5) AND KEYED(LEFT.Prim_Name = RIGHT.Prim_Name) AND KEYED(LEFT.Suffix = RIGHT.Suffix) AND
									KEYED(LEFT.Predir = RIGHT.Predir) AND KEYED(LEFT.Postdir = RIGHT.Postdir) AND KEYED(LEFT.Prim_Range = RIGHT.Prim_Range) AND
									KEYED(UT.NNEQ(LEFT.Sec_Range, RIGHT.Sec_Range)) AND (UNSIGNED3)(((STRING)RIGHT.Dt_First_Seen)[1..6]) < LEFT.HistoryDate AND RIGHT.Dt_First_Seen > 0,
											TRANSFORM({RECORDOF(LEFT), STRING1 hriskaddrflag}, 
														addr_type := IF(TRIM(RIGHT.SIC_Code) = '2265', 'P', LEFT.Addr_Type); // A SIC of 2265 indicates US Postal Service
														SELF.hriskaddrflag := MAP(TRIM(LEFT.ZipClass) = 'P'																																=> '1',
																											TRIM(LEFT.ZipClass) = 'U'																																=> '2',
																											TRIM(LEFT.ZipClass) = 'M' OR TRIM(addr_type) = 'M'																			=> '3',
																											TRIM(LEFT.Prim_Name) = '' OR TRIM(LEFT.Zip) = ''																				=> '5',
																											TRIM(RIGHT.SIC_Code) = ''																																=> '0',	 		
																											TRIM(RIGHT.SIC_Code) <> '' AND RIGHT.SIC_Code IN Risk_Indicators.iid_constants.setCRMA	=> '4',		
																											TRIM(RIGHT.SIC_Code) <> '' AND TRIM(LEFT.Sec_Range) = TRIM(RIGHT.Sec_Range)							=> '4',
																																																																									'');
														SELF := LEFT),
											 LEFT OUTER, KEEP(100), ATMOST(KEYED(LEFT.Zip = RIGHT.Z5) AND KEYED(LEFT.Prim_Name = RIGHT.Prim_Name) AND KEYED(LEFT.Suffix = RIGHT.Suffix) AND
									KEYED(LEFT.Predir = RIGHT.Predir) AND KEYED(LEFT.Postdir = RIGHT.Postdir) AND KEYED(LEFT.Prim_Range = RIGHT.Prim_Range) AND
									KEYED(UT.NNEQ(LEFT.Sec_Range, RIGHT.Sec_Range)), Business_Risk_BIP.Constants.Limit_Default));
	
	// A hriskaddrflag of '4' indicates High Risk Address - so keep those records above all others
	HighRiskRolled := ROLLUP(SORT(HighRiskRaw, Seq, DID, -(hriskaddrflag = '4'), hriskaddrflag), LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), 
												SELF := LEFT));
	
	// Count the number of unique Associates per Seq, and count the number that live in a high crime neighborhood
	HighRiskStats := TABLE(HighRiskRolled, 
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 HighRiskAddressAssociates := COUNT(GROUP, hriskaddrflag = '4') // A hriskaddrflag of '4' indicates High Risk Address
		},
		Seq);
	
	withHighRisk := JOIN(withLienJudgment, HighRiskStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateHighRiskAddrCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.HighRiskAddressAssociates, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);
	
	
	// ----- Watchlist -----
	// Project our shell input into the appropriate layout, only the Company Name and Alt Company Name fields are used in watchlist searching
	watchlistInputPrep := PROJECT(seqContactInfo, TRANSFORM(Risk_Indicators.Layout_Output,
																				SELF.Seq := LEFT.Seq;
																				SELF.DID := LEFT.DID;
																				SELF.FName := LEFT.FName;
																				SELF.MName := LEFT.MName;
																				SELF.LName := LEFT.LName;
																				SELF.DOB := IF(LEFT.DOB > 0, (STRING)LEFT.DOB, '');
																				SELF.Age := IF(LEFT.Age > 0, (STRING)LEFT.Age, '');
																				SELF := []));
	
	// getWatshlists2 expects grouped input
	watchlistInput := GROUP(SORT(watchlistInputPrep, Seq), Seq);
	
	// Get the watchlist results.  To simplify watchlist searching we are only supporting the custom watchlist set (Could include 'ALL', 'OFA', 'OFC', 'OSC', 'BES', 'CFT', etc etc) - See Patriot.WL_Include_Keys for the full list.
	// By doing this it eliminates all of the extra OFAC_Only/Include_OFAC/Include_Additional_Watchlists input options that really can be accomplished with the Watchlists_Requested input dataset
	OFAC_Only := FALSE;
	Include_OFAC_Temp := if(options.OFAC_Version = 1, false, true);
	Include_OFAC := Include_OFAC_Temp;
  Include_Additional_Watchlists := FALSE;
	Skip_Company_Search := TRUE; // No need to search for company watchlist info - these are people
	DOB_Radius := -1;
	// Don't attempt to grab watchlists unless we actually have some in the list...
	watchlistResults := IF(COUNT(Options.Watchlists_Requested) <= 0, watchlistInputPrep,
																																	 UNGROUP(Risk_Indicators.getWatchLists2(watchlistInput, OFAC_Only, Skip_Company_Search, Options.OFAC_Version, Include_OFAC, Include_Additional_Watchlists, Options.Global_Watchlist_Threshold, DOB_Radius, Options.Watchlists_Requested, options.gateways)));
  if(exists(watchlistResults(watchlist_table = 'ERR')), FAIL('Bridger Gateway Error'));

  // Count the number of unique Associates per Seq, and count the number that have a watchlist hit
	watchlistStats := TABLE(watchlistResults, 
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 WatchlistAssociates := COUNT(GROUP, watchlist_record_number <> '')
		},
		Seq);
	
	watchlistRisk := JOIN(withHighRisk, watchlistStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateWatchlistCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.WatchlistAssociates, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);
	
	// ----- Business -----
	PAWContactID := JOIN(seqContactInfo, PAW.Key_Did, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID),
											TRANSFORM({RECORDOF(LEFT), UNSIGNED6 Contact_ID}, 
														SELF.Contact_ID := RIGHT.Contact_ID;
														SELF := LEFT),
											LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	PAWRaw := JOIN(PAWContactID, PAW.Key_ContactID, LEFT.Contact_ID <> 0 AND KEYED(LEFT.Contact_ID = RIGHT.Contact_ID) AND 
								(UNSIGNED)(RIGHT.Dt_First_Seen[1..6]) < LEFT.HistoryDate AND (UNSIGNED)RIGHT.Dt_First_Seen > 0 AND RIGHT.UltID > 0,
											TRANSFORM({RECORDOF(LEFT), UNSIGNED6 UltID, UNSIGNED6 OrgID, UNSIGNED6 SeleID, UNSIGNED6 ProxID, UNSIGNED6 PowID},
														SELF.UltID := RIGHT.UltID;
														SELF.OrgID := RIGHT.OrgID;
														SELF.SeleID := RIGHT.SeleID;
														SELF.ProxID := RIGHT.ProxID;
														SELF.PowID := RIGHT.PowID;
														SELF := LEFT), LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	// Count up the number of unique Businesses per DID
	PAWUniqueBusinessRecords := TABLE(PAWRaw,
		{Seq,
		 DID,
		 UNSIGNED8 UniqueBusinessRecords := COUNT(GROUP, UltID > 0 AND OrgID > 0 AND SeleID > 0 AND ProxID > 0 AND PowID > 0),
		 //UNSIGNED8 CurrentAssociateUniqueBusinessRecords := COUNT(GROUP, UltID > 0 AND OrgID > 0 AND SeleID > 0 AND ProxID > 0 AND PowID > 0 AND IsCurrent),
		 UNSIGNED8 Contact_ID := MAX(GROUP, Contact_ID),
		 BOOLEAN	 IsCurrent := MAX(GROUP, IsCurrent)
		},
		 Seq, DID, UltID);
		 
	PAWUniqueBusinessCounts := TABLE(PAWUniqueBusinessRecords,
		{Seq,
		DID,
		UNSIGNED8 UniqueBusinesses := COUNT(GROUP, UniqueBusinessRecords >= 1),
		//UNSIGNED8 CurrentAssociateUniqueBusinesses := COUNT(GROUP, CurrentAssociateUniqueBusinessRecords >= 1),
		UNSIGNED8 Contact_ID := MAX(GROUP, Contact_ID),
		BOOLEAN		IsCurrent := MAX(GROUP, IsCurrent)
		},
		Seq, DID);
	
	// Count the number of unique Associates per Seq, and add up the total businesses among all DIDs
	PAWStats := TABLE(PAWUniqueBusinessCounts, 
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 AssociatePAWCount := COUNT(GROUP, Contact_ID > 0),
		UNSIGNED8 AssociateCurrentPAWCount := COUNT(GROUP, Contact_ID > 0 AND IsCurrent),
		UNSIGNED8 AssociateBusinessCount := SUM(GROUP, UniqueBusinesses),
		UNSIGNED8 AssociateCurrentBusinessCount := SUM(GROUP, UniqueBusinesses, IsCurrent)
		},
		Seq);
	
	withPAW := JOIN(watchlistRisk, PAWStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateBusinessCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateBusinessCount, -1, 999999), '-1');
			SELF.Associates.AssociateCurrentBusinessCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentBusinessCount, -1, 999999), '-1');			
			SELF.Associates.AssociatePAWCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociatePAWCount, -1, 999999), '-1');
			SELF.Associates.AssociateCurrentPAWCount := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentPAWCount, -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);

	
	// ----- City/County -----
	withCityCountyCounts := JOIN(withPAW, Shell, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			// Grab the contacts who share the same City as the input Business - Check the Input_Echo section in case the address didn't clean properly
			matchingCity := RIGHT.ContactDIDs ((RIGHT.Clean_Input.City <> '' AND City_Name = RIGHT.Clean_Input.City) OR (RIGHT.Input_Echo.City <> '' AND City_Name = StringLib.StringToUpperCase(RIGHT.Input_Echo.City)));
			matchingCounty := RIGHT.ContactDIDs ((RIGHT.Clean_Input.County <> '' AND County = RIGHT.Clean_Input.County) OR (RIGHT.Input_Echo.County <> '' AND County = RIGHT.Input_Echo.County));
			associates := COUNT(RIGHT.ContactDIDs);
			SELF.Associates.AssociateCityCount := IF(associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(COUNT(matchingCity), -1, 999999), '-1');
			SELF.Associates.AssociateCountyCount := IF(associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(COUNT(matchingCounty), -1, 999999), '-1');
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);

	// ----- Property Ownership -----
	OwnershipKey := LN_PropertyV2.key_ownership_did(FALSE /*isFCRA*/);
	
	PropertyOwnership := JOIN(seqContactInfo, OwnershipKey, LEFT.DID > 0 AND LEFT.IsCurrent AND KEYED(LEFT.DID = RIGHT.DID) AND
			(INTEGER)(((STRING)RIGHT.dt_first_seen)[1..6]) < LEFT.HistoryDate, TRANSFORM({RECORDOF(LEFT), BOOLEAN IsPropertyOwner},
									SELF.IsPropertyOwner := RIGHT.DID > 0;
									SELF := LEFT),
			LEFT OUTER, KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default));		

	Properties := DEDUP(SORT(PropertyOwnership, Seq, DID, -IsPropertyOwner), Seq, DID);
	
	PropertyOwnershipStats := TABLE(Properties, 		
		{Seq,
		UNSIGNED8 Associates := COUNT(GROUP),
		UNSIGNED8 AssociateCurrentCountWithProperty := COUNT(GROUP, IsPropertyOwner)
		},
		Seq);
		
	withPropertyOwnership := JOIN(withCityCountyCounts, PropertyOwnershipStats, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
			SELF.Associates.AssociateCurrentCountWithProperty := IF(RIGHT.Associates >= MinAssociatesNeededToCalculate, (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssociateCurrentCountWithProperty, -1, 999999), '-1');;
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);

  // *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(seqContactInfo, 100), NAMED('Sample_seqContactInfo'));
	// OUTPUT(CHOOSEN(EASIRaw, 100), NAMED('Sample_EASIRaw'));
	// OUTPUT(CHOOSEN(EASIStats, 100), NAMED('Sample_EASIStats'));
	// OUTPUT(CHOOSEN(withEASI, 100), NAMED('Sample_withEASI'));
	// OUTPUT(CHOOSEN(OffenderRaw, 100), NAMED('Sample_OffenderRaw'));
	// OUTPUT(CHOOSEN(OffenderRolled, 100), NAMED('Sample_OffenderRolled'));
	// OUTPUT(CHOOSEN(OffenderStats, 100), NAMED('Sample_OffenderStats'));
	// OUTPUT(CHOOSEN(withOffender, 100), NAMED('Sample_withOffender'));
	// OUTPUT(CHOOSEN(BankruptcyTMSID, 100), NAMED('Sample_BankruptcyTMSID'));
	// OUTPUT(CHOOSEN(BankruptcyRaw, 100), NAMED('Sample_BankruptcyRaw'));
	// OUTPUT(CHOOSEN(BankruptcyRawUnique, 100), NAMED('Sample_BankruptcyRawUnique'));
	// OUTPUT(CHOOSEN(BankruptcyRolled, 100), NAMED('Sample_BankruptcyRolled'));
	// OUTPUT(CHOOSEN(BankruptcyStats, 100), NAMED('Sample_BankruptcyStats'));
	// OUTPUT(CHOOSEN(withBankruptcy, 100), NAMED('Sample_withBankruptcy'));
	// OUTPUT(CHOOSEN(LienJudgmentTMSID, 100), NAMED('Sample_LienJudgmentTMSID'));
	// OUTPUT(CHOOSEN(LienJudgmentRaw, 100), NAMED('Sample_LienJudgmentRaw'));
	// OUTPUT(CHOOSEN(LienJudgmentRolledTMSID, 100), NAMED('Sample_LienJudgmentRolledTMSID'));
	// OUTPUT(CHOOSEN(LienJudgmentRolled, 100), NAMED('Sample_LienJudgmentRolled'));
	// OUTPUT(CHOOSEN(LienJudgmentStats, 100), NAMED('Sample_LienJudgmentStats'));
	// OUTPUT(CHOOSEN(withLienJudgment, 100), NAMED('Sample_withLienJudgment'));
	// OUTPUT(CHOOSEN(GetZipClass, 100), NAMED('Sample_GetZipClass'));
	// OUTPUT(CHOOSEN(HighRiskRaw, 100), NAMED('Sample_HighRiskRaw'));
	// OUTPUT(CHOOSEN(HighRiskRolled, 100), NAMED('Sample_HighRiskRolled'));
	// OUTPUT(CHOOSEN(HighRiskStats, 100), NAMED('Sample_HighRiskStats'));
	// OUTPUT(CHOOSEN(withHighRisk, 100), NAMED('Sample_withHighRisk'));
	// OUTPUT(CHOOSEN(PAWContactID, 100), NAMED('Sample_PAWContactID'));
	// OUTPUT(CHOOSEN(PAWRaw, 100), NAMED('Sample_PAWRaw'));
	// OUTPUT(CHOOSEN(PAWUniqueBusinessCounts, 100), NAMED('Sample_PAWUniqueBusinessCounts'));
	// OUTPUT(CHOOSEN(PAWStats, 100), NAMED('Sample_PAWStats'));
	// OUTPUT(CHOOSEN(withPAW, 100), NAMED('Sample_withPAW'));
	// OUTPUT(CHOOSEN(withCityCountyCounts, 100), NAMED('Sample_withCityCountyCounts'));
	// OUTPUT(CHOOSEN(PropertyOwnershipStats, 100), NAMED('Sample_PropertyOwnershipStats'));
	// OUTPUT(CHOOSEN(withPropertyOwnership, 100), NAMED('Sample_withPropertyOwnership'));

	RETURN withPropertyOwnership;
END;