IMPORT BIPV2, Business_Risk_BIP, dx_OSHAIR, MDR,STD;

EXPORT getOSHA(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- OSHA - Occupational Safety and Health Administration ------------------
	OSHARaw := dx_OSHAIR.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(OSHARaw, Shell, OSHASeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(OSHASeq);

	// Filter out records after our history date
	OSHA := Business_Risk_BIP.Common.FilterRecords(OSHASeq, inspection_opening_date, inspection_close_date, MDR.SourceTools.src_OSHAIR, AllowedSourcesSet);

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	OSHAStats := TABLE(OSHA,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_OSHAIR,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(inspection_opening_date, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(inspection_close_date, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(inspection_close_date, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate,
			 BOOLEAN PrivateOwnership := COUNT(GROUP, TRIM(own_type_desc) = 'PRIVATE') > 0;
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED OwnershipType;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
	END;
	OSHAStatsTemp := PROJECT(OSHAStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.OwnershipType := IF(LEFT.PrivateOwnership, 2, 0);
																				SELF.Sources := DATASET([{LEFT.Source,
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	OSHAStatsRolled := ROLLUP(OSHAStatsTemp, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(tempLayout,
																							SELF.Seq := LEFT.Seq;
																							SELF.OwnershipType := MAX(LEFT.OwnershipType, RIGHT.OwnershipType);
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF := LEFT));

	withOSHAStats := JOIN(Shell, OSHAStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Firmographic.OwnershipType := (STRING)RIGHT.OwnershipType;
																							SELF.Sources := RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// Get all unique NAIC Codes along with dates, for the primary and 1 secondary NAIC
	getOSHANAIC(InputDataset, OutputTable, OutputTemp, OutputRolled, WithInput, WithOutput, NAICField, PrimaryNAIC) := MACRO
		OutputTable := TABLE(InputDataset,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_OSHAIR,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(inspection_opening_date, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(inspection_close_date, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 NAICCode := (STD.Str.Filter((STRING)NAICField, '0123456789'))[1..6],
			 BOOLEAN IsPrimary := PrimaryNAIC // NAIC1 is the primary NAIC in DCA data, all others are not primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)NAICField)[1..6]
			 );

		OutputTemp := PROJECT(OutputTable, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
		OutputRolled := ROLLUP(OutputTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));

		WithOutput := JOIN(WithInput, OutputRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	ENDMACRO;
	// Go through and TABLE/ROLLUP/JOIN all NAIC fields in the OSHA data
	getOSHANAIC(OSHA, OSHANAIC1, OSHANAIC1Temp, OSHANAIC1Rolled, withOSHAStats, withOSHANAIC1, NAICs_Code, TRUE);
	getOSHANAIC(OSHA, OSHANAIC2, OSHANAIC2Temp, OSHANAIC2Rolled, withOSHANAIC1, withOSHANAIC, NAICs_Secondary_Code, FALSE);

	// Get all unique SIC Codes along with dates
	OSHASIC := TABLE(OSHA,
    {Seq,
		  LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
		  Source := MDR.SourceTools.src_OSHAIR,
		  STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(inspection_opening_date, HistoryDate),
		  STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(inspection_close_date, HistoryDate),
		  UNSIGNED4 RecordCount := COUNT(GROUP),
     STRING10 SICCode := IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,(STD.Str.Filter((STRING)SIC_Code, '0123456789'))[1..8],(STD.Str.Filter((STRING)SIC_Code, '0123456789'))[1..4]),
		  BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)SIC_Code)[1..4]
			 );

	OSHASICTemp := PROJECT(OSHASIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));

	OSHASICRolled := ROLLUP(OSHASICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));

	withOSHA := JOIN(withOSHANAIC, OSHASICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withErrorCodes := JOIN(withOSHA, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeOSHA := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(OSHARaw, 100), NAMED('Sample_OSHARaw'));
	// OUTPUT(CHOOSEN(OSHA, 100), NAMED('Sample_OSHA'));
	// OUTPUT(CHOOSEN(OSHAStats, 100), NAMED('Sample_OSHAStats'));
	// OUTPUT(CHOOSEN(OSHAStatsTemp, 100), NAMED('Sample_OSHAStatsTemp'));
	// OUTPUT(CHOOSEN(withOSHA, 100), NAMED('Sample_withOSHA'));

	RETURN withErrorCodes;
END;
