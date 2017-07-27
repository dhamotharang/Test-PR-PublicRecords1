IMPORT BankruptcyV3, BIPV2, Business_Risk_BIP, MDR, Risk_Indicators, UT;

EXPORT getBankruptcy(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION
	// ------------ Bankruptcy Build Date -------------
	BkBuildDate := Risk_Indicators.get_Build_date('Bankruptcy_daily');
	
	// --------------- Bankruptcy Data ----------------
	BankruptcyRaw := BankruptcyV3.Key_BankruptcyV3_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						  Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BankruptcyRaw, Shell, BankruptcySeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(BankruptcySeq);
	
	// Filter out records after our history date
	Bankruptcy := Business_Risk_BIP.Common.FilterRecords(BankruptcySeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_Bankruptcy, AllowedSourcesSet);
	

	
	// Sort dismissed case numbers to the top, that way when we rollup below we can keep the left to determine if this bankruptcy was dismissed
	// Only keep the debtor records --> Name_Type = 'D'
	BankruptcySorted := SORT(Bankruptcy (TRIM(Name_Type) = 'D'), Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), case_number, -(StringLib.StringFind(StringLib.StringToUpperCase(Disposition), 'DISMISS', 1) > 0), -date_first_seen, -date_last_seen);
	
	// Figure out which bankruptcies are valid, and which have been discharged
	RECORDOF(BankruptcySorted) rollBankruptcy(BankruptcySorted le, BankruptcySorted ri) := TRANSFORM
		SELF.date_first_seen := (STRING)MIN(IF((INTEGER)(le.date_first_seen) <= 0, (INTEGER)(Business_Risk_BIP.Constants.NinesDate + '99'),	(INTEGER)Business_Risk_BIP.Common.checkInvalidDate(le.date_first_seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate)),
																IF((INTEGER)(ri.date_first_seen) <= 0, (INTEGER)(Business_Risk_BIP.Constants.NinesDate + '99'),	(INTEGER)Business_Risk_BIP.Common.checkInvalidDate(ri.date_first_seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate)));
		SELF.date_last_seen := (STRING)MAX((INTEGER)Business_Risk_BIP.Common.checkInvalidDate(le.date_last_seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate), (INTEGER)Business_Risk_BIP.Common.checkInvalidDate(ri.date_last_seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate));
		
		// Any dismissed records will be on the left due to BankruptcySorted, just keep the left to find out if this case_number was ever discharged
		SELF := le;
	END;
	
	BankruptcyRolled := ROLLUP(BankruptcySorted, LEFT.Seq = RIGHT.Seq AND LEFT.Case_Number = RIGHT.Case_Number, rollBankruptcy(LEFT, RIGHT));

	//Only keep bankruptcies from the last 10 years
	RecentBankruptcy := BankruptcyRolled(ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(10));


	// Bankruptcies that have been dismissed
	BankruptcyDismissed := RecentBankruptcy (StringLib.StringFind(StringLib.StringToUpperCase(Disposition), 'DISMISS', 1) > 0);
	
	// Bankruptcies with no dismissal
	BankruptcyOnFile := RecentBankruptcy (StringLib.StringFind(StringLib.StringToUpperCase(Disposition), 'DISMISS', 1) <= 0);
	
	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	BankruptcyStats := TABLE(BankruptcyOnFile,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Bankruptcy,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_vendor_last_reported, HistoryDate),
			 // If the HistoryDate indicates this is a realtime transaction use the build date, otherwise use the historical date
			 UNSIGNED4 BankruptcyCount03Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= Business_Risk_BIP.Constants.ThreeMonths)),
			 UNSIGNED4 BankruptcyCount06Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= Business_Risk_BIP.Constants.SixMonths)),
			 UNSIGNED4 BankruptcyCount12Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(1))),
			 UNSIGNED4 BankruptcyCount24Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(2))),
			 UNSIGNED4 BankruptcyCount84Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(7))),
			 UNSIGNED4 BankruptcyCount := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(10))), // Only go back up to 10 years for our "ever" count
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Keep the most recent bankruptcy per sequence for calculating recent type and recent date
	MostRecentBankruptcy := ROLLUP(SORT(BankruptcyOnFile, Seq, -date_first_seen, -date_last_seen), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
			
	// Rollup the dates first/last seen into child datasets by Seq, keep our other bankruptcy calculations
	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		UNSIGNED4 BankruptcyCount03Month;
		UNSIGNED4 BankruptcyCount06Month;
		UNSIGNED4 BankruptcyCount12Month;
		UNSIGNED4 BankruptcyCount24Month;
		UNSIGNED4 BankruptcyCount84Month;
		UNSIGNED4 BankruptcyCount;
	END;
	BankruptcyStatsTemp := PROJECT(BankruptcyStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.BankruptcyCount03Month := LEFT.BankruptcyCount03Month;
																				SELF.BankruptcyCount06Month := LEFT.BankruptcyCount06Month;
																				SELF.BankruptcyCount12Month := LEFT.BankruptcyCount12Month;
																				SELF.BankruptcyCount24Month := LEFT.BankruptcyCount24Month;
																				SELF.BankruptcyCount84Month := LEFT.BankruptcyCount84Month;
																				SELF.BankruptcyCount := LEFT.BankruptcyCount));
	BankruptcyStatsRolled := ROLLUP(BankruptcyStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; 
																																																	 SELF.Sources := LEFT.Sources + RIGHT.Sources;
																																																	 SELF.BankruptcyCount03Month := LEFT.BankruptcyCount03Month + RIGHT.BankruptcyCount03Month;
																																																	 SELF.BankruptcyCount06Month := LEFT.BankruptcyCount06Month + RIGHT.BankruptcyCount06Month;
																																																	 SELF.BankruptcyCount12Month := LEFT.BankruptcyCount12Month + RIGHT.BankruptcyCount12Month;
																																																	 SELF.BankruptcyCount24Month := LEFT.BankruptcyCount24Month + RIGHT.BankruptcyCount24Month;
																																																	 SELF.BankruptcyCount84Month := LEFT.BankruptcyCount84Month + RIGHT.BankruptcyCount84Month;
																																																	 SELF.BankruptcyCount := LEFT.BankruptcyCount + RIGHT.BankruptcyCount));
	
	withBankruptcy := JOIN(Shell, BankruptcyStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := RIGHT.Sources;
																							SELF.Bankruptcy.BankruptcyCount03Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BankruptcyCount03Month, -1, 999);
																							SELF.Bankruptcy.BankruptcyCount06Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BankruptcyCount06Month, -1, 999);
																							SELF.Bankruptcy.BankruptcyCount12Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BankruptcyCount12Month, -1, 999);
																							SELF.Bankruptcy.BankruptcyCount24Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BankruptcyCount24Month, -1, 999);
																							SELF.Bankruptcy.BankruptcyCount84Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BankruptcyCount84Month, -1, 999);
																							SELF.Bankruptcy.BankruptcyCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BankruptcyCount, -1, 999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	withRecentBankruptcy := JOIN(withBankruptcy, MostRecentBankruptcy, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							Chapter := IF((INTEGER)RIGHT.Chapter = 304, '15', RIGHT.Chapter);
																							SELF.Bankruptcy.BankruptcyChapter := INTFORMAT((INTEGER)Chapter, 2, 1);
																							BankruptRecentDate := (STRING)(INTEGER)RIGHT.Date_First_Seen; 
																							SELF.Bankruptcy.BankruptRecentDate := BankruptRecentDate; // This date is already cleaned in the MostRecentBankruptcy calculation, no need to checkInvalidDate here
																							TodaysDate := Business_Risk_BIP.Common.todaysDate(BkBuildDate, LEFT.Clean_Input.HistoryDate);
																							SELF.Bankruptcy.BankruptcyTimeNewest := (STRING)IF((INTEGER)LEFT.Bankruptcy.BankruptcyCount > 0 AND (INTEGER)LEFT.Bankruptcy.BankruptcyCount > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(BankruptRecentDate, TodaysDate), 1, 120), -1);
																							SELF.Data_Build_Dates.BankruptcyBuildDate := BkBuildDate;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	// Figure out the Dismissed first seen and last seen date per source for each Seq, by LinkID level
	BankruptcyDismissedStats := TABLE(BankruptcyDismissed,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Bankruptcy,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_vendor_last_reported, HistoryDate), 
			 // If the HistoryDate indicates this is a realtime transaction use the build date, otherwise use the historical date
			 UNSIGNED4 DismissedBankruptcyCount03Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= Business_Risk_BIP.Constants.ThreeMonths)),
			 UNSIGNED4 DismissedBankruptcyCount06Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= Business_Risk_BIP.Constants.SixMonths)),
			 UNSIGNED4 DismissedBankruptcyCount12Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(1))),
			 UNSIGNED4 DismissedBankruptcyCount24Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(2))),
			 UNSIGNED4 DismissedBankruptcyCount84Month := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(7))),
			 UNSIGNED4 DismissedBankruptcyCount := COUNT(GROUP, (ut.DaysApart(date_first_seen, Business_Risk_BIP.Common.todaysDate(BkBuildDate, HistoryDate)) <= ut.DaysInNYears(10))), // Only go back up to 10 years for our ever count
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Keep the most recent bankruptcy per sequence for calculating recent type and recent date
	MostRecentDismissedBankruptcy := ROLLUP(SORT(BankruptcyDismissed, Seq, -date_first_seen, -date_last_seen), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
			
	// Rollup the dates first/last seen into child datasets by Seq, keep our other bankruptcy calculations
	tempDismissedLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		UNSIGNED4 DismissedBankruptcyCount03Month;
		UNSIGNED4 DismissedBankruptcyCount06Month;
		UNSIGNED4 DismissedBankruptcyCount12Month;
		UNSIGNED4 DismissedBankruptcyCount24Month;
		UNSIGNED4 DismissedBankruptcyCount84Month;
		UNSIGNED4 DismissedBankruptcyCount;
	END;
	BankruptcyDismissedStatsTemp := PROJECT(BankruptcyDismissedStats, TRANSFORM(tempDismissedLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.DismissedBankruptcyCount03Month := LEFT.DismissedBankruptcyCount03Month;
																				SELF.DismissedBankruptcyCount06Month := LEFT.DismissedBankruptcyCount06Month;
																				SELF.DismissedBankruptcyCount12Month := LEFT.DismissedBankruptcyCount12Month;
																				SELF.DismissedBankruptcyCount24Month := LEFT.DismissedBankruptcyCount24Month;
																				SELF.DismissedBankruptcyCount84Month := LEFT.DismissedBankruptcyCount84Month;
																				SELF.DismissedBankruptcyCount := LEFT.DismissedBankruptcyCount));
	BankruptcyDismissedStatsRolled := ROLLUP(BankruptcyDismissedStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempDismissedLayout, SELF.Seq := LEFT.Seq; 
																																																	 SELF.Sources := LEFT.Sources + RIGHT.Sources;
																																																	 SELF.DismissedBankruptcyCount03Month := LEFT.DismissedBankruptcyCount03Month + RIGHT.DismissedBankruptcyCount03Month;
																																																	 SELF.DismissedBankruptcyCount06Month := LEFT.DismissedBankruptcyCount06Month + RIGHT.DismissedBankruptcyCount06Month;
																																																	 SELF.DismissedBankruptcyCount12Month := LEFT.DismissedBankruptcyCount12Month + RIGHT.DismissedBankruptcyCount12Month;
																																																	 SELF.DismissedBankruptcyCount24Month := LEFT.DismissedBankruptcyCount24Month + RIGHT.DismissedBankruptcyCount24Month;
																																																	 SELF.DismissedBankruptcyCount84Month := LEFT.DismissedBankruptcyCount84Month + RIGHT.DismissedBankruptcyCount84Month;
																																																	 SELF.DismissedBankruptcyCount := LEFT.DismissedBankruptcyCount + RIGHT.DismissedBankruptcyCount));
	
	withBankruptcyDismissed := JOIN(withRecentBankruptcy, BankruptcyDismissedStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF.Bankruptcy.DismissedBankruptcyCount03Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.DismissedBankruptcyCount03Month, -1, 999);
																							SELF.Bankruptcy.DismissedBankruptcyCount06Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.DismissedBankruptcyCount06Month, -1, 999);
																							SELF.Bankruptcy.DismissedBankruptcyCount12Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.DismissedBankruptcyCount12Month, -1, 999);
																							SELF.Bankruptcy.DismissedBankruptcyCount24Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.DismissedBankruptcyCount24Month, -1, 999);
																							SELF.Bankruptcy.DismissedBankruptcyCount84Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.DismissedBankruptcyCount84Month, -1, 999);
																							SELF.Bankruptcy.DismissedBankruptcyCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.DismissedBankruptcyCount, -1, 999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	withRecentDismissedBankruptcy := JOIN(withBankruptcyDismissed, MostRecentDismissedBankruptcy, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							Chapter := IF((INTEGER)RIGHT.Chapter = 304, '15', RIGHT.Chapter);
																							SELF.Bankruptcy.DismissedBankruptcyChapter := INTFORMAT((INTEGER)Chapter, 2, 1);
																							DismissedBankruptRecentDate := (STRING)(INTEGER)RIGHT.Date_First_Seen;
																							SELF.Bankruptcy.DismissedBankruptRecentDate := DismissedBankruptRecentDate; // This date is already cleaned in the MostRecentBankruptcy calculation, no need to checkInvalidDate here
																							TodaysDate := Business_Risk_BIP.Common.todaysDate(BkBuildDate, LEFT.Clean_Input.HistoryDate);
																							SELF.Bankruptcy.DismissedBankruptcyTimeNewest := (STRING)IF((INTEGER)LEFT.Bankruptcy.DismissedBankruptcyCount > 0, Business_Risk_BIP.Common.capNum((INTEGER)ut.MonthsApart(DismissedBankruptRecentDate, TodaysDate), 1, 99999), -1);
																							SELF.Data_Build_Dates.BankruptcyBuildDate := BkBuildDate;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	withErrorCodes := JOIN(withRecentDismissedBankruptcy, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeBankruptcy := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(BankruptcyRaw, 100), NAMED('Sample_BankruptcyRaw'));
	// OUTPUT(CHOOSEN(Bankruptcy, 100), NAMED('Sample_Bankruptcy'));
	// OUTPUT(CHOOSEN(BankruptcyStats, 100), NAMED('Sample_BankruptcyStats'));
	// OUTPUT(CHOOSEN(BankruptcyStatsTemp, 100), NAMED('Sample_BankruptcyStatsTemp'));
	// OUTPUT(CHOOSEN(BankruptcyStatsRolled, 100), NAMED('Sample_BankruptcyStatsRolled'));
	// OUTPUT(CHOOSEN(withBankruptcy, 100), NAMED('Sample_withBankruptcy'));
	// OUTPUT(CHOOSEN(withRecentBankruptcy, 100), NAMED('Sample_withRecentBankruptcy'));
	
	RETURN withErrorCodes;
END;