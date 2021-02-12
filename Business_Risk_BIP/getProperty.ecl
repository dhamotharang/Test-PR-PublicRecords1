IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, Risk_Indicators, STD;

EXPORT getProperty(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// --------------- Property Data - Using Business IDs ----------------
	PropertyRaw := LN_PropertyV2.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Property,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(PropertyRaw, Shell, PropertySeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(PropertySeq);

	// Filter out records after our history date. Set sourceCode to null string for FilterRecords so all Property
	// records return whether Marketing restriction is indicated or not.
	Property_pre := Business_Risk_BIP.Common.FilterRecords(PropertySeq, dt_first_seen, dt_vendor_first_reported, '', AllowedSourcesSet);

	// Under the most recent definition for source codes that are allowed for Marketing purposes, all Property
	// are ALLOWED with the exception of the following states ['ID','IL','KS','NM','SC','WA', ''] when they are
	// in records whose src type is src_LnPropV2_Lexis_Asrs or src_LnPropV2_Lexis_Deeds_Mtgs (i.e. 'LA','LP').
	Property_with_src :=
		PROJECT(
			Property_pre,
			TRANSFORM( { RECORDOF(Property_pre), STRING src },
				SELF.src := MDR.SourceTools.fProperty(LEFT.ln_fares_id),
				SELF := LEFT
			)
		);

	Property := IF( Options.MarketingMode = 1,
			Property_with_src(src IN AllowedSourcesSet AND Business_Risk_BIP.Common.isMarketingAllowedProperty(src, st)),
			Property_with_src);

	PropertyWithBest := JOIN(DEDUP(SORT(Property, Seq, LN_Fares_ID), Seq, LN_Fares_ID), Shell, LEFT.Seq = RIGHT.Seq,
															TRANSFORM({RECORDOF(LEFT), BOOLEAN AddrIsBest},
																	NoScoreValue := 255;
																	BestAddressPopulated := TRIM(RIGHT.Best_Info.BestPrimName) <> '' AND TRIM(RIGHT.Best_Info.BestCompanyZip) <> '' AND TRIM(LEFT.prim_name) <> '' AND TRIM(LEFT.Zip) <> '';
																	BestZIPScore						:= IF(RIGHT.Best_Info.BestCompanyZip <> '' AND LEFT.Zip <> '' AND RIGHT.Best_Info.BestCompanyZip[1] = LEFT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(RIGHT.Best_Info.BestCompanyZip, LEFT.Zip), NoScoreValue);
																	BestStateMatched				:= STD.Str.ToUpperCase(RIGHT.Best_Info.BestCompanyState) = STD.Str.ToUpperCase(LEFT.st);
																	BestCityStateScore			:= IF(RIGHT.Best_Info.BestCompanyCity <> '' AND RIGHT.Best_Info.BestCompanyState <> '' AND LEFT.p_city_name <> '' AND LEFT.st <> '' AND BestStateMatched,
																													Risk_Indicators.AddrScore.CityState_Score(RIGHT.Best_Info.BestCompanyCity, RIGHT.Best_Info.BestCompanyState, LEFT.p_city_name, LEFT.st, ''), NoScoreValue);
																	BestCityStateZipMatched	:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore);

																	BestAddressScore := MAP(NOT BestAddressPopulated => NoScoreValue,
																	BestAddressPopulated AND BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue => NoScoreValue,
																																		Risk_Indicators.AddrScore.AddressScore(RIGHT.Best_Info.BestPrimRange, RIGHT.Best_Info.BestPrimName, RIGHT.Best_Info.BestSecRange,
																																		LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																																		BestZIPScore, BestCityStateScore));
																	BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(BestAddressScore);
																	SELF.AddrIsBest := BestAddressMatched;
																	SELF := LEFT),
																ATMOST(Business_Risk_BIP.Constants.Limit_Default), KEEP(1), LEFT OUTER);


	PropertyDeeds := JOIN(PropertyWithBest, LN_PropertyV2.key_deed_fid(FALSE /*isFCRA*/), KEYED(LEFT.LN_Fares_ID = RIGHT.LN_Fares_ID),
															TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, BOOLEAN AddrIsBest}, SELF.Seq := LEFT.Seq; SELF.AddrIsBest := LEFT.AddrIsBest; SELF := RIGHT),
															ATMOST(Business_Risk_BIP.Constants.Limit_Deeds));

	PropertyDeedsRep := JOIN(Shell, PropertyDeeds, LEFT.Seq = RIGHT.Seq, TRANSFORM({RECORDOF(RIGHT), INTEGER3 BusExecLinkPropertyOverlapCount, INTEGER3 BusExecLinkPropertyOverlapCount2, INTEGER3 BusExecLinkPropertyOverlapCount3,INTEGER3 BusExecLinkPropertyOverlapCount4, INTEGER3 BusExecLinkPropertyOverlapCount5, INTEGER1 BestOwnership},
																	// Clean both names associated with the Deed to break it up into First and Last Name
																	cleanName1 := Address.CleanNameFields(Address.CleanPerson73(RIGHT.name1));
																	cleanName2 := Address.CleanNameFields(Address.CleanPerson73(RIGHT.name2));
																	// Score each name against the input representative name
																	fname1InputPopulated := TRIM(LEFT.Clean_Input.Rep_FirstName) <> '';
																	lname1InputPopulated := TRIM(LEFT.Clean_Input.Rep_LastName) <> '';
																	FirstNameMatch1 := fname1InputPopulated AND LEFT.Clean_Input.Rep_FirstName[1] = cleanName1.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName1.FName, LEFT.Clean_Input.Rep_FirstName));
																	LastNameMatch1 := lname1InputPopulated AND LEFT.Clean_Input.Rep_LastName[1] = cleanName1.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName1.LName, LEFT.Clean_Input.Rep_LastName));
																	NameMatch1 := FirstNameMatch1 AND LastNameMatch1;
																	FirstNameMatch2 := fname1InputPopulated AND LEFT.Clean_Input.Rep_FirstName[1] = cleanName2.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName2.FName, LEFT.Clean_Input.Rep_FirstName));
																	LastNameMatch2 := lname1InputPopulated AND LEFT.Clean_Input.Rep_LastName[1] = cleanName2.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName2.LName, LEFT.Clean_Input.Rep_LastName));
																	NameMatch2 := FirstNameMatch2 AND LastNameMatch2;
																	NameMatch := NameMatch1 OR NameMatch2;
																	SELF.BusExecLinkPropertyOverlapCount := IF(NameMatch, 1, 0);
																	//rep 2
																	fname2InputPopulated := TRIM(LEFT.Clean_Input.Rep2_FirstName) <> '';
																	lname2InputPopulated := TRIM(LEFT.Clean_Input.Rep2_LastName) <> '';
																	FirstNameMatch1Rep2 := fname2InputPopulated AND LEFT.Clean_Input.Rep2_FirstName[1] = cleanName1.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName1.FName, LEFT.Clean_Input.Rep2_FirstName));
																	LastNameMatch1Rep2 := lname2InputPopulated AND LEFT.Clean_Input.Rep2_LastName[1] = cleanName1.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName1.LName, LEFT.Clean_Input.Rep2_LastName));
																	NameMatch1Rep2 := FirstNameMatch1Rep2 AND LastNameMatch1Rep2;
																	FirstNameMatch2Rep2 := fname2InputPopulated AND LEFT.Clean_Input.Rep2_FirstName[1] = cleanName2.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName2.FName, LEFT.Clean_Input.Rep2_FirstName));
																	LastNameMatch2Rep2 := lname2InputPopulated AND LEFT.Clean_Input.Rep2_LastName[1] = cleanName2.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName2.LName, LEFT.Clean_Input.Rep2_LastName));
																	NameMatch2Rep2 := FirstNameMatch2Rep2 AND LastNameMatch2Rep2;
																	NameMatchRep2 := NameMatch1Rep2 OR NameMatch2Rep2;
																	SELF.BusExecLinkPropertyOverlapCount2 := IF(NameMatchRep2, 1, 0);
																	//rep 3
																	fname3InputPopulated := TRIM(LEFT.Clean_Input.Rep3_FirstName) <> '';
																	lname3InputPopulated := TRIM(LEFT.Clean_Input.Rep3_LastName) <> '';
																	FirstNameMatch1Rep3 := fname3InputPopulated AND LEFT.Clean_Input.Rep3_FirstName[1] = cleanName1.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName1.FName, LEFT.Clean_Input.Rep3_FirstName));
																	LastNameMatch1Rep3 := lname3InputPopulated AND LEFT.Clean_Input.Rep3_LastName[1] = cleanName1.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName1.LName, LEFT.Clean_Input.Rep3_LastName));
																	NameMatch1Rep3 := FirstNameMatch1Rep3 AND LastNameMatch1Rep3;
																	FirstNameMatch2Rep3 := fname3InputPopulated AND LEFT.Clean_Input.Rep3_FirstName[1] = cleanName2.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName2.FName, LEFT.Clean_Input.Rep3_FirstName));
																	LastNameMatch2Rep3 := lname3InputPopulated AND LEFT.Clean_Input.Rep3_LastName[1] = cleanName2.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName2.LName, LEFT.Clean_Input.Rep3_LastName));
																	NameMatch2Rep3 := FirstNameMatch2Rep3 AND LastNameMatch2Rep3;
																	NameMatchRep3 := NameMatch1Rep3 OR NameMatch2Rep3;
																	SELF.BusExecLinkPropertyOverlapCount3 := IF(NameMatchRep3, 1, 0);

																		//rep 4
																	fname4InputPopulated := TRIM(LEFT.Clean_Input.Rep4_FirstName) <> '';
																	lname4InputPopulated := TRIM(LEFT.Clean_Input.Rep4_LastName) <> '';
																	FirstNameMatch1Rep4 := fname4InputPopulated AND LEFT.Clean_Input.Rep4_FirstName[1] = cleanName1.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName1.FName, LEFT.Clean_Input.Rep4_FirstName));
																	LastNameMatch1Rep4 := lname4InputPopulated AND LEFT.Clean_Input.Rep4_LastName[1] = cleanName1.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName1.LName, LEFT.Clean_Input.Rep4_LastName));
																	NameMatch1Rep4 := FirstNameMatch1Rep4 AND LastNameMatch1Rep4;
																	FirstNameMatch2Rep4 := fname4InputPopulated AND LEFT.Clean_Input.Rep4_FirstName[1] = cleanName2.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName2.FName, LEFT.Clean_Input.Rep4_FirstName));
																	LastNameMatch2Rep4 := lname4InputPopulated AND LEFT.Clean_Input.Rep4_LastName[1] = cleanName2.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName2.LName, LEFT.Clean_Input.Rep4_LastName));
																	NameMatch2Rep4 := FirstNameMatch2Rep4 AND LastNameMatch2Rep4;
																	NameMatchRep4 := NameMatch1Rep4 OR NameMatch2Rep4;
																	SELF.BusExecLinkPropertyOverlapCount4 := IF(NameMatchRep4, 1, 0);
																	//rep 5
																	fname5InputPopulated := TRIM(LEFT.Clean_Input.Rep5_FirstName) <> '';
																	lname5InputPopulated := TRIM(LEFT.Clean_Input.Rep5_LastName) <> '';
																	FirstNameMatch1Rep5 := fname5InputPopulated AND LEFT.Clean_Input.Rep5_FirstName[1] = cleanName1.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName1.FName, LEFT.Clean_Input.Rep5_FirstName));
																	LastNameMatch1Rep5 := lname5InputPopulated AND LEFT.Clean_Input.Rep5_LastName[1] = cleanName1.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName1.LName, LEFT.Clean_Input.Rep5_LastName));
																	NameMatch1Rep5 := FirstNameMatch1Rep5 AND LastNameMatch1Rep5;
																	FirstNameMatch2Rep5 := fname5InputPopulated AND LEFT.Clean_Input.Rep5_FirstName[1] = cleanName2.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(cleanName2.FName, LEFT.Clean_Input.Rep5_FirstName));
																	LastNameMatch2Rep5 := lname5InputPopulated AND LEFT.Clean_Input.Rep5_LastName[1] = cleanName2.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(cleanName2.LName, LEFT.Clean_Input.Rep5_LastName));
																	NameMatch2Rep5 := FirstNameMatch2Rep5 AND LastNameMatch2Rep5;
																	NameMatchRep5 := NameMatch1Rep5 OR NameMatch2Rep5;
																	SELF.BusExecLinkPropertyOverlapCount5 := IF(NameMatchRep5, 1, 0);

																	SELF.BestOwnership := IF(RIGHT.AddrIsBest, 1, 0);
																	SELF := RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Deeds));



	PropertyDeedsRepStats := TABLE(PropertyDeedsRep,
			{Seq,
			 LN_Fares_ID,
			 MaxBusExecLinkPropertyOverlapCount := MAX(GROUP, BusExecLinkPropertyOverlapCount),
			 MaxBusExecLinkPropertyOverlapCount2 := MAX(GROUP, BusExecLinkPropertyOverlapCount2),
			 MaxBusExecLinkPropertyOverlapCount3 := MAX(GROUP, BusExecLinkPropertyOverlapCount3),
			 MaxBusExecLinkPropertyOverlapCount4 := MAX(GROUP, BusExecLinkPropertyOverlapCount4),
			 MaxBusExecLinkPropertyOverlapCount5 := MAX(GROUP, BusExecLinkPropertyOverlapCount5),
			 MaxBestOwnership := MAX(GROUP, BestOwnership)},
			 Seq, LN_Fares_ID);

	PropertyDeedsRepCounts := ROLLUP(SORT(PropertyDeedsRepStats, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
																					SELF.MaxBusExecLinkPropertyOverlapCount := LEFT.MaxBusExecLinkPropertyOverlapCount + RIGHT.MaxBusExecLinkPropertyOverlapCount;
																					SELF.MaxBusExecLinkPropertyOverlapCount2 := LEFT.MaxBusExecLinkPropertyOverlapCount2 + RIGHT.MaxBusExecLinkPropertyOverlapCount2;
																					SELF.MaxBusExecLinkPropertyOverlapCount3 := LEFT.MaxBusExecLinkPropertyOverlapCount3 + RIGHT.MaxBusExecLinkPropertyOverlapCount3;
																					SELF.MaxBusExecLinkPropertyOverlapCount4 := LEFT.MaxBusExecLinkPropertyOverlapCount4 + RIGHT.MaxBusExecLinkPropertyOverlapCount4;
																					SELF.MaxBusExecLinkPropertyOverlapCount5 := LEFT.MaxBusExecLinkPropertyOverlapCount5 + RIGHT.MaxBusExecLinkPropertyOverlapCount5;
																					SELF.MaxBestOwnership := MAX(LEFT.MaxBestOwnership, RIGHT.MaxBestOwnership);
																					SELF := LEFT));

	// --------------- Property Data - Using Consumer DID ----------------
	OwnershipKey := LN_PropertyV2.key_ownership_did(FALSE /*isFCRA*/);
	tempOwnershipRec := RECORD
		UNSIGNED4 Seq;
		UNSIGNED4 BusExecLinkBusAddrAuthRepOwned;
		UNSIGNED4 BusExecLinkBusAddrAuthRep2Owned;
		UNSIGNED4 BusExecLinkBusAddrAuthRep3Owned;
		UNSIGNED4 BusExecLinkBusAddrAuthRep4Owned;
		UNSIGNED4 BusExecLinkBusAddrAuthRep5Owned;
	END;
	tempOwnershipRec getOwnership(Business_Risk_BIP.Layouts.Shell le, OwnershipKey ri) := TRANSFORM
		SELF.Seq := le.Seq;

		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));
		Rep1Matched         := le.Clean_Input.Rep_LexID = ri.DID;
		Rep2Matched         := le.Clean_Input.Rep2_LexID = ri.DID;
		Rep3Matched         := le.Clean_Input.Rep3_LexID = ri.DID;
		Rep4Matched         := le.Clean_Input.Rep4_LexID = ri.DID;
		Rep5Matched         := le.Clean_Input.Rep5_LexID = ri.DID;

		SELF.BusExecLinkBusAddrAuthRepOwned := IF(AddressMatched and Rep1Matched, 1, 0);
		SELF.BusExecLinkBusAddrAuthRep2Owned := IF(AddressMatched and Rep2Matched, 1, 0);
		SELF.BusExecLinkBusAddrAuthRep3Owned := IF(AddressMatched and Rep3Matched, 1, 0);
		SELF.BusExecLinkBusAddrAuthRep4Owned := IF(AddressMatched and Rep4Matched, 1, 0);
		SELF.BusExecLinkBusAddrAuthRep5Owned := IF(AddressMatched and Rep5Matched, 1, 0);


	END;

	RepPropertyOwned := JOIN(Shell, OwnershipKey, (LEFT.Clean_Input.Rep_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep2_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep2_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep3_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep3_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep4_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep4_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep5_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep5_LexID = RIGHT.DID))
																									AND
																								(INTEGER)(((STRING)RIGHT.dt_first_seen)[1..6]) < LEFT.Clean_Input.HistoryDate,
																						getOwnership(LEFT, RIGHT), ATMOST((LEFT.Clean_Input.Rep_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep2_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep2_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep3_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep3_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep4_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep4_LexID = RIGHT.DID) or
																									LEFT.Clean_Input.Rep5_LexID > 0 AND KEYED(LEFT.Clean_Input.Rep5_LexID = RIGHT.DID)),Business_Risk_BIP.Constants.Limit_Default));

	RepPropertyOwnedCounts := ROLLUP(SORT(RepPropertyOwned, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
																					SELF.BusExecLinkBusAddrAuthRepOwned := LEFT.BusExecLinkBusAddrAuthRepOwned + RIGHT.BusExecLinkBusAddrAuthRepOwned;
																					SELF.BusExecLinkBusAddrAuthRep2Owned := LEFT.BusExecLinkBusAddrAuthRep2Owned + RIGHT.BusExecLinkBusAddrAuthRep2Owned;
																					SELF.BusExecLinkBusAddrAuthRep3Owned := LEFT.BusExecLinkBusAddrAuthRep3Owned + RIGHT.BusExecLinkBusAddrAuthRep3Owned;
																					SELF.BusExecLinkBusAddrAuthRep4Owned := LEFT.BusExecLinkBusAddrAuthRep4Owned + RIGHT.BusExecLinkBusAddrAuthRep4Owned;
																					SELF.BusExecLinkBusAddrAuthRep5Owned := LEFT.BusExecLinkBusAddrAuthRep5Owned + RIGHT.BusExecLinkBusAddrAuthRep5Owned;
																					SELF := LEFT));

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	PropertyStats := TABLE(Property,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := CASE(LN_Fares_ID[2],
											'A' => MDR.SourceTools.src_LnPropV2_Fares_Asrs,
											'D' => MDR.SourceTools.src_LnPropV2_Fares_Deeds,
														 '');
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, LN_Fares_ID[2], Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 ) (Source <> ''); // Ensure we only have Deeds/Assessment Records

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;
	PropertyStatsTemp := PROJECT(PropertyStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source,
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources)));
	PropertyStatsRolled := ROLLUP(PropertyStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources));

	withProperty := JOIN(Shell, PropertyStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withPropertyDeedsRep := JOIN(withProperty, PropertyDeedsRepCounts, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.MaxBusExecLinkPropertyOverlapCount, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount2 := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.MaxBusExecLinkPropertyOverlapCount2, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount3 := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.MaxBusExecLinkPropertyOverlapCount3, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount4 := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.MaxBusExecLinkPropertyOverlapCount4, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkPropertyOverlapCount5 := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.MaxBusExecLinkPropertyOverlapCount5, -1, 99999);
																							SELF.Best_Info.BestOwnership := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.MaxBestOwnership, -1, 1);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withRepPropertyOwned := JOIN(withPropertyDeedsRep, RepPropertyOwnedCounts, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRepOwned := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusExecLinkBusAddrAuthRepOwned, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep2Owned := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusExecLinkBusAddrAuthRep2Owned, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep3Owned := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusExecLinkBusAddrAuthRep3Owned, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep4Owned := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusExecLinkBusAddrAuthRep4Owned, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkBusAddrAuthRep5Owned := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusExecLinkBusAddrAuthRep5Owned, -1, 99999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);



	withErrorCodes := JOIN(withRepPropertyOwned, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeProperty := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(PropertyRaw, 100), NAMED('Sample_PropertyRaw'));
	// OUTPUT(CHOOSEN(Property, 100), NAMED('Sample_Property'));
	// OUTPUT(CHOOSEN(PropertyAssessments, 100), NAMED('Sample_PropertyAssessments'));
	// OUTPUT(CHOOSEN(PropertyDeeds, 100), NAMED('Sample_PropertyDeeds'));
	// OUTPUT(CHOOSEN(PropertyDeedsRep, 100), NAMED('Sample_PropertyDeedsRep'));
	// OUTPUT(CHOOSEN(PropertyDeedsRepStats, 100), NAMED('Sample_PropertyDeedsRepStats'));
	// OUTPUT(CHOOSEN(PropertyDeedsRepCounts, 100), NAMED('Sample_PropertyDeedsRepCounts'));
	// OUTPUT(CHOOSEN(Shell, 100), NAMED('Sample_propertyShell'));
	// OUTPUT(CHOOSEN(property_by_address, 100), NAMED('Sample_property_by_address'));
	// OUTPUT(CHOOSEN(PropertyStats, 100), NAMED('Sample_PropertyStats'));
	// OUTPUT(CHOOSEN(PropertyStatsTemp, 100), NAMED('Sample_PropertyStatsTemp'));
	// OUTPUT(CHOOSEN(withProperty, 100), NAMED('Sample_withProperty'));

	RETURN withErrorCodes;
END;
