IMPORT BIPV2, Business_Risk_BIP, FAA, MDR, Risk_Indicators, UT, Watercraft;

EXPORT getAirWatercraft(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION
	
	aircraft_build_date := Risk_Indicators.get_Build_date('faa_build_version');	   
	watercraft_build_date := Risk_Indicators.get_Build_date('watercraft_build_version');

	// ---------------- FAA - Aircraft Records ------------------
	AircraftRaw := FAA.Key_Aircraft_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(AircraftRaw, Shell, AircraftSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesAircraft := Business_Risk_BIP.Common.GrabFetchErrorCode(AircraftSeq);
	
	// Filter out records after our history date
	AircraftRecords := Business_Risk_BIP.Common.FilterRecords(AircraftSeq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, Business_Risk_BIP.Constants.Src_Aircrafts, AllowedSourcesSet);
	
	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	AircraftStats := TABLE(AircraftRecords,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := Business_Risk_BIP.Constants.Src_Aircrafts,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Constants.MissingDate, //no vendor first seen date field on aircraft records
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate, //no vendor last seen date field on aircraft records
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED4 AssetAircraftCount;
		UNSIGNED4 AssetWatercraftCount;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;
	AircraftStatsTemp := PROJECT(AircraftStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.AssetAircraftCount := LEFT.RecordCount;
																				SELF.Sources := IF(LEFT.RecordCount > 0, DATASET([{LEFT.Source, 
																																													IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																													IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																													LEFT.DateLastSeen,
																																													LEFT.DateVendorLastSeen,
																																													LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources), 
																																									DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF := []));
	AircraftStatsRolled := ROLLUP(AircraftStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF.AssetAircraftCount := LEFT.AssetAircraftCount + RIGHT.AssetAircraftCount; SELF := LEFT));
	
	withAircraftStats := JOIN(Shell, AircraftStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Asset_Information.AssetAircraftCount := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssetAircraftCount, -1, 999999);
																							SELF.Sources := RIGHT.Sources;
																							SELF.Data_Build_Dates.AircraftBuildDate := aircraft_build_date;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// ---------------- Watercraft Records ------------------
	WatercraftRaw := Watercraft.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(WatercraftRaw, Shell, WatercraftSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesWatercraft := Business_Risk_BIP.Common.GrabFetchErrorCode(WatercraftSeq);
	
	// Filter out records after our history date
	WatercraftRecords := Business_Risk_BIP.Common.FilterRecords(WatercraftSeq, date_first_seen, date_vendor_first_reported, Business_Risk_BIP.Constants.Src_Watercraft, AllowedSourcesSet);
	
	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	WatercraftStats := TABLE(WatercraftRecords,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := Business_Risk_BIP.Constants.Src_Watercraft,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq
	WatercraftStatsTemp := PROJECT(WatercraftStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.AssetWatercraftCount := LEFT.RecordCount;
																				SELF.Sources := IF(LEFT.RecordCount > 0, DATASET([{LEFT.Source, 
																																													 IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																													 IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																													 LEFT.DateLastSeen,
																																													 LEFT.DateVendorLastSeen,
																																													 LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources),
																																								 DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF := []));
	WatercraftStatsRolled := ROLLUP(WatercraftStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF.AssetWatercraftCount := LEFT.AssetWatercraftCount + RIGHT.AssetWatercraftCount; SELF := LEFT));
	
	withWatercraftStats := JOIN(withAircraftStats, WatercraftStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Asset_Information.AssetWatercraftCount := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.AssetWatercraftCount, -1, 999999);
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF.Data_Build_Dates.WatercraftBuildDate := watercraft_build_date;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesAircraft := JOIN(withWatercraftStats, kFetchErrorCodesAircraft, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeAircraft := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesWatercraft := JOIN(withErrorCodesAircraft, kFetchErrorCodesWatercraft, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeWatercraft := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
																	
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(AircraftRaw, 100), NAMED('Sample_AircraftRaw'));
	// OUTPUT(CHOOSEN(AircraftRecords, 100), NAMED('Sample_AircraftRecords'));
	// OUTPUT(CHOOSEN(AircraftStats, 100), NAMED('Sample_AircraftStats'));
	// OUTPUT(CHOOSEN(withAircraftStats, 100), NAMED('Sample_withAircraftStats'));
	// OUTPUT(CHOOSEN(WatercraftRaw, 100), NAMED('Sample_WatercraftRaw'));
	// OUTPUT(CHOOSEN(WatercraftRecords, 100), NAMED('Sample_WatercraftRecords'));
	// OUTPUT(CHOOSEN(WatercraftStats, 100), NAMED('Sample_WatercraftStats'));
	// OUTPUT(CHOOSEN(withWatercraftStats, 100), NAMED('Sample_withWatercraftStats'));
		
	RETURN withErrorCodesWatercraft;

END;