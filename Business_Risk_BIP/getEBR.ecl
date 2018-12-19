IMPORT BIPV2, Business_Risk_BIP, EBR, MDR, UT;

EXPORT getEBR(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- EBR - Experian Business Records ------------------
	EBR5600Raw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(EBR5600Raw, Shell, EBR5600Seq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(EBR5600Seq);
	
	// Filter out records after our history date
	EBR5600 := Business_Risk_BIP.Common.FilterRecords(EBR5600Seq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_EBR, AllowedSourcesSet);

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	EBR5600Stats := TABLE(EBR5600,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_EBR,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Constants.MissingDate, //no vendor date fields in EBR5600 key
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 INTEGER FirmAgeEstablished := MAX(GROUP, (INTEGER)yrs_in_bus_actual),
       // For v30 and up, need to differentiate between 0 and '' for FirmReportedSales. Set missing records to -1.
			 INTEGER FirmReportedSales := MAX(GROUP, IF(EBR.fFix_amount_codes(Sales_Actual) = '' AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, -1, 
                                          (INTEGER)EBR.fFix_amount_codes(Sales_Actual)*100)) // Because the data team botched the conversion process Sales_Actual contains characters, and rather than fix the data they created a function to translate the characters to the correct numbers
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		INTEGER FirmAgeEstablished;
		INTEGER FirmReportedSales;
		UNSIGNED4 RecordCount;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
	END;
	EBR5600StatsTemp := PROJECT(EBR5600Stats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.FirmAgeEstablished := LEFT.FirmAgeEstablished;
																				SELF.FirmReportedSales := LEFT.FirmReportedSales;
																				SELF.RecordCount := LEFT.RecordCount;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	EBR5600StatsRolled := ROLLUP(EBR5600StatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, 
																				SELF.Seq := LEFT.Seq; 
																				SELF.FirmAgeEstablished := MAX(LEFT.FirmAgeEstablished, RIGHT.FirmAgeEstablished);
																				SELF.FirmReportedSales := MAX(LEFT.FirmReportedSales, RIGHT.FirmReportedSales);
																				SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
																				SELF.Sources := LEFT.Sources + RIGHT.Sources; 
																				SELF := LEFT));
	
	withEBR5600Stats := JOIN(Shell, EBR5600StatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Firmographic.FirmAgeEstablished := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmAgeEstablished, -1), -1, 110);
																							SELF.Firmographic.FirmReportedSales := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmReportedSales, -1), -1, 999999999);
																							SELF.Sources := RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Get all unique SIC Codes along with dates, for the primary and all 3 secondary SIC's
	getEBR5600SIC(InputDataset, OutputTable, OutputTemp, OutputRolled, WithInput, WithOutput, SICField, PrimarySIC) := MACRO
		OutputTable := TABLE(InputDataset,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_EBR,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := (StringLib.StringFilter((STRING)SICField, '0123456789'))[1..4],
			 BOOLEAN IsPrimary := PrimarySIC // SIC1 is the primary SIC in DNB DMI data, all others are not primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)SICField)[1..4]
			 );
		
		OutputTemp := PROJECT(OutputTable, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
		OutputRolled := ROLLUP(OutputTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	
		WithOutput := JOIN(WithInput, OutputRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	ENDMACRO;
	// Go through and TABLE/ROLLUP/JOIN all SIC fields in the DNB DMI data
	getEBR5600SIC(EBR5600, EBR5600SIC1, EBR5600SIC1Temp, EBR5600SIC1Rolled, withEBR5600Stats, withEBR5600SIC1, SIC_1_Code, TRUE);
	getEBR5600SIC(EBR5600, EBR5600SIC2, EBR5600SIC2Temp, EBR5600SIC2Rolled, withEBR5600SIC1, withEBR5600SIC2, SIC_2_Code, FALSE);
	getEBR5600SIC(EBR5600, EBR5600SIC3, EBR5600SIC3Temp, EBR5600SIC3Rolled, withEBR5600SIC2, withEBR5600SIC3, SIC_3_Code, FALSE);
	getEBR5600SIC(EBR5600, EBR5600SIC4, EBR5600SIC4Temp, EBR5600SIC4Rolled, withEBR5600SIC3, withEBR5600, SIC_4_Code, FALSE);
	
	withErrorCodes := JOIN(withEBR5600, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeEBR5600 := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(EBR5600Raw, 100), NAMED('Sample_EBR5600Raw'));
	// OUTPUT(CHOOSEN(EBR5600, 100), NAMED('Sample_EBR5600'));
	// OUTPUT(CHOOSEN(EBR5600Stats, 100), NAMED('Sample_EBR5600Stats'));
	// OUTPUT(CHOOSEN(EBR5600StatsTemp, 100), NAMED('Sample_EBR5600StatsTemp'));
	// OUTPUT(CHOOSEN(withEBR5600, 100), NAMED('Sample_withEBR5600'));
	
	RETURN withErrorCodes;
END;