IMPORT BIPV2, Business_Risk, Business_Risk_BIP, BusReg, DCAV2, DNB_DMI, InfoUSA, MDR, OSHAIR, Risk_Indicators, UT, YellowPages;

EXPORT getEmployeeSources(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	// ---------------- DNB DMI - Dunn Bradstreet DMI ------------------
	DNBDMIRaw := IF(StringLib.StringFind(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0, // Only grab DNB DMI data if it is explicitly passed in as allowed
									DNB_DMI.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses
																							));
	
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(DNBDMIRaw, Shell, DNBDMISeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesDNBDMI := Business_Risk_BIP.Common.GrabFetchErrorCode(DNBDMISeq);
	
	// Filter out records after our history date
	DNBDMI := Business_Risk_BIP.Common.FilterRecords(DNBDMISeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_Dunn_Bradstreet, AllowedSourcesSet);
	
	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	DNBDMIStats := TABLE(DNBDMI,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Dunn_Bradstreet,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 INTEGER FirmEmployeeCount := MAX(GROUP, (INTEGER)RawFields.Employees_Total),
			 INTEGER FinanceWorthOfBus := MAX(GROUP, (INTEGER)(StringLib.StringFilter(RawFields.Net_Worth_Sign, '-') + (STRING)RawFields.Net_Worth))
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED8 FirmReportedSales;
		INTEGER FirmReportedEarnings;
		UNSIGNED8 FinanceWorthOfBus;
		UNSIGNED4 RecordCount;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) EmployeeSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
	END;
	
	DNBDMIStatsTemp := PROJECT(DNBDMIStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.EmployeeSources := DATASET([{LEFT.Source, 
																																					IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																					IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																					LEFT.DateLastSeen,
																																					LEFT.DateVendorLastSeen,
																																	LEFT.FirmEmployeeCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.FinanceWorthOfBus := LEFT.FinanceWorthOfBus;
																				SELF.RecordCount := LEFT.RecordCount;
																				SELF := []));
	DNBDMIStatsRolled := ROLLUP(DNBDMIStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; 
																																		SELF.Sources := LEFT.Sources + RIGHT.Sources; 
																																		SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources; 
																																		SELF.FinanceWorthOfBus := LEFT.FinanceWorthOfBus + RIGHT.FinanceWorthOfBus;
																																		SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
																																		SELF := LEFT));
	
	withDNBDMIStats := JOIN(Shell, DNBDMIStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																							SELF.Firmographic.FinanceWorthOfBus := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FinanceWorthOfBus, -1), -1, 999999999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// Get all unique SIC Codes along with dates, for the primary and all 5 secondary SIC's
	getDNBDMISIC(InputDataset, OutputTable, OutputTemp, OutputRolled, WithInput, WithOutput, SICField, PrimarySIC) := MACRO
		OutputTable := TABLE(InputDataset,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Dunn_Bradstreet,
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
	getDNBDMISIC(DNBDMI, DNBDMISIC1, DNBDMISIC1Temp, DNBDMISIC1Rolled, withDNBDMIStats, withDNBDMISIC1, RawFields.SIC1, TRUE);
	getDNBDMISIC(DNBDMI, DNBDMISIC2, DNBDMISIC2Temp, DNBDMISIC2Rolled, withDNBDMISIC1, withDNBDMISIC2, RawFields.SIC2, FALSE);
	getDNBDMISIC(DNBDMI, DNBDMISIC3, DNBDMISIC3Temp, DNBDMISIC3Rolled, withDNBDMISIC2, withDNBDMISIC3, RawFields.SIC3, FALSE);
	getDNBDMISIC(DNBDMI, DNBDMISIC4, DNBDMISIC4Temp, DNBDMISIC4Rolled, withDNBDMISIC3, withDNBDMISIC4, RawFields.SIC4, FALSE);
	getDNBDMISIC(DNBDMI, DNBDMISIC5, DNBDMISIC5Temp, DNBDMISIC5Rolled, withDNBDMISIC4, withDNBDMISIC5, RawFields.SIC5, FALSE);
	getDNBDMISIC(DNBDMI, DNBDMISIC6, DNBDMISIC6Temp, DNBDMISIC6Rolled, withDNBDMISIC5, withDNBDMI, RawFields.SIC6, FALSE);
		
	// ---------------- BusReg - Business Registration ------------------
	BusRegRaw := BusReg.key_busreg_company_linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(BusRegRaw, Shell, BusRegSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesBusinessRegistration := Business_Risk_BIP.Common.GrabFetchErrorCode(BusRegSeq);
	
	BusReg := Business_Risk_BIP.Common.FilterRecords(BusRegSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_Business_Registration, AllowedSourcesSet);
	
	BusRegStats := TABLE(BusReg,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Business_Registration,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 INTEGER FirmEmployeeCount := MAX(GROUP, (INTEGER)rawfields.emp_size)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	
	BusRegStatsTemp := PROJECT(BusRegStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.EmployeeSources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.FirmEmployeeCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	BusRegStatsRolled := ROLLUP(BusRegStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources; SELF := LEFT));
	
	withBusRegStats := JOIN(withDNBDMI, BusRegStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// Get all unique SIC Codes along with dates
	BusRegSIC := TABLE(BusReg,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Business_Registration,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := (StringLib.StringFilter((STRING)RawFields.SIC, '0123456789'))[1..4],
			 BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)RawFields.SIC)[1..4]
			 );
	// Get all unique NAIC Codes along with dates
	BusRegNAIC := TABLE(BusReg,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_Business_Registration,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 NAICCode := (StringLib.StringFilter((STRING)RawFields.NAICS, '0123456789'))[1..6],
			 BOOLEAN IsPrimary := TRUE // There is only 1 NAIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)RawFields.NAICS)[1..6]
			 );
	// Combine SIC and NAIC codes
	BusRegSICTemp := PROJECT(BusRegSIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
	BusRegNAICTemp := PROJECT(BusRegNAIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
	BusRegSICRolled := ROLLUP(BusRegSICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	BusRegNAICRolled := ROLLUP(BusRegNAICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	
	withBusRegSIC := JOIN(withBusRegStats, BusRegSICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	withBusReg := JOIN(withBusRegSIC, BusRegNAICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// ---------------- DCA - Directory of Corporate Affiliations AKA LNCA ------------------
	DCARaw := DCAV2.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(DCARaw, Shell, DCASeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesDCA := Business_Risk_BIP.Common.GrabFetchErrorCode(DCASeq);
	
	DCA := Business_Risk_BIP.Common.FilterRecords(DCASeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_DCA, AllowedSourcesSet);
	
	DCAStats := TABLE(DCA,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_DCA,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_vendor_last_reported, HistoryDate),
			 
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 INTEGER FirmEmployeeCount := MAX(GROUP, (INTEGER)RawFields.Emp_Num),
			 UNSIGNED8 FirmReportedSales := MAX(GROUP, (INTEGER)RawFields.Sales),
			 INTEGER FirmReportedEarnings := MAX(GROUP, (INTEGER)RawFields.Earnings),
			 UNSIGNED8 FinanceWorthOfBus := MAX(GROUP, (INTEGER)RawFields.Net_Worth)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
			 
	DCAStatsTemp := PROJECT(DCAStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.EmployeeSources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.FirmEmployeeCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.FirmReportedSales := LEFT.FirmReportedSales;
																				SELF.FirmReportedEarnings := LEFT.FirmReportedEarnings;
																				SELF.FinanceWorthOfBus := LEFT.FinanceWorthOfBus;
																				SELF.RecordCount := LEFT.RecordCount;
																				SELF := []));
	DCAStatsRolled := ROLLUP(DCAStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; 
																															SELF.Sources := LEFT.Sources + RIGHT.Sources; 
																															SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources; 
																															SELF.FirmReportedSales := LEFT.FirmReportedSales + RIGHT.FirmReportedSales; 
																															SELF.FirmReportedEarnings := LEFT.FirmReportedEarnings + RIGHT.FirmReportedEarnings; 
																															SELF.FinanceWorthOfBus := LEFT.FinanceWorthOfBus + RIGHT.FinanceWorthOfBus; 
																															SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
																															SELF := LEFT));
	
	withDCAStats := JOIN(withBusReg, DCAStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Firmographic.FirmReportedSales := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmReportedSales, -1), -1, 999999999);
																							SELF.Firmographic.FirmReportedEarnings := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmReportedEarnings, -1), -1, 999999999);
																							SELF.Firmographic.FinanceWorthOfBus := (STRING)Business_Risk_BIP.Common.capNum(MAX((INTEGER)LEFT.Firmographic.FinanceWorthOfBus, IF(RIGHT.RecordCount > 0, RIGHT.FinanceWorthOfBus, -1)), -1, 999999999); // Since DNB DMI also calculates this (When enabled) we need to keep the max
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// Get all unique SIC Codes along with dates, for the primary and all 9 secondary SIC's
	getDCASIC(InputDataset, OutputTable, OutputTemp, OutputRolled, WithInput, WithOutput, SICField, PrimarySIC) := MACRO
		OutputTable := TABLE(InputDataset,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_DCA,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := (StringLib.StringFilter((STRING)SICField, '0123456789'))[1..4],
			 BOOLEAN IsPrimary := PrimarySIC // SIC1 is the primary SIC in DCA data, all others are not primary
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
	// Go through and TABLE/ROLLUP/JOIN all SIC fields in the DCA data
	getDCASIC(DCA, DCASIC1, DCASIC1Temp, DCASIC1Rolled, withDCAStats, withDCASIC1, RawFields.SIC1, TRUE);
	getDCASIC(DCA, DCASIC2, DCASIC2Temp, DCASIC2Rolled, withDCASIC1, withDCASIC2, RawFields.SIC2, FALSE);
	getDCASIC(DCA, DCASIC3, DCASIC3Temp, DCASIC3Rolled, withDCASIC2, withDCASIC3, RawFields.SIC3, FALSE);
	getDCASIC(DCA, DCASIC4, DCASIC4Temp, DCASIC4Rolled, withDCASIC3, withDCASIC4, RawFields.SIC4, FALSE);
	getDCASIC(DCA, DCASIC5, DCASIC5Temp, DCASIC5Rolled, withDCASIC4, withDCASIC5, RawFields.SIC5, FALSE);
	getDCASIC(DCA, DCASIC6, DCASIC6Temp, DCASIC6Rolled, withDCASIC5, withDCASIC6, RawFields.SIC6, FALSE);
	getDCASIC(DCA, DCASIC7, DCASIC7Temp, DCASIC7Rolled, withDCASIC6, withDCASIC7, RawFields.SIC7, FALSE);
	getDCASIC(DCA, DCASIC8, DCASIC8Temp, DCASIC8Rolled, withDCASIC7, withDCASIC8, RawFields.SIC8, FALSE);
	getDCASIC(DCA, DCASIC9, DCASIC9Temp, DCASIC9Rolled, withDCASIC8, withDCASIC9, RawFields.SIC9, FALSE);
	getDCASIC(DCA, DCASIC10, DCASIC10Temp, DCASIC10Rolled, withDCASIC9, withDCASIC10, RawFields.SIC10, FALSE);
	
	// Get all unique NAIC Codes along with dates, for the primary and all 9 secondary NAIC's
	getDCANAIC(InputDataset, OutputTable, OutputTemp, OutputRolled, WithInput, WithOutput, NAICField, PrimaryNAIC) := MACRO
		OutputTable := TABLE(InputDataset,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_DCA,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 NAICCode := (StringLib.StringFilter((STRING)NAICField, '0123456789'))[1..6],
			 BOOLEAN IsPrimary := PrimaryNAIC // NAIC1 is the primary SIC in DCA data, all others are not primary
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
	// Go through and TABLE/ROLLUP/JOIN all NAIC fields in the DCA data
	getDCANAIC(DCA, DCANAIC1, DCANAIC1Temp, DCANAIC1Rolled, withDCASIC10, withDCANAIC1, RawFields.NAICS1, TRUE);
	getDCANAIC(DCA, DCANAIC2, DCANAIC2Temp, DCANAIC2Rolled, withDCANAIC1, withDCANAIC2, RawFields.NAICS2, FALSE);
	getDCANAIC(DCA, DCANAIC3, DCANAIC3Temp, DCANAIC3Rolled, withDCANAIC2, withDCANAIC3, RawFields.NAICS3, FALSE);
	getDCANAIC(DCA, DCANAIC4, DCANAIC4Temp, DCANAIC4Rolled, withDCANAIC3, withDCANAIC4, RawFields.NAICS4, FALSE);
	getDCANAIC(DCA, DCANAIC5, DCANAIC5Temp, DCANAIC5Rolled, withDCANAIC4, withDCANAIC5, RawFields.NAICS5, FALSE);
	getDCANAIC(DCA, DCANAIC6, DCANAIC6Temp, DCANAIC6Rolled, withDCANAIC5, withDCANAIC6, RawFields.NAICS6, FALSE);
	getDCANAIC(DCA, DCANAIC7, DCANAIC7Temp, DCANAIC7Rolled, withDCANAIC6, withDCANAIC7, RawFields.NAICS7, FALSE);
	getDCANAIC(DCA, DCANAIC8, DCANAIC8Temp, DCANAIC8Rolled, withDCANAIC7, withDCANAIC8, RawFields.NAICS8, FALSE);
	getDCANAIC(DCA, DCANAIC9, DCANAIC9Temp, DCANAIC9Rolled, withDCANAIC8, withDCANAIC9, RawFields.NAICS9, FALSE);
	getDCANAIC(DCA, DCANAIC10, DCANAIC10Temp, DCANAIC10Rolled, withDCANAIC9, withDCA, RawFields.NAICS10, FALSE);

	// ---------------- DEADCO ------------------
                                                                                                   
	DEADCORaw := InfoUSA.Key_DEADCO_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(DEADCORaw, Shell, DEADCOSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesDeadCo := Business_Risk_BIP.Common.GrabFetchErrorCode(DEADCOSeq);
	
	DEADCO := Business_Risk_BIP.Common.FilterRecords(DEADCOSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_INFOUSA_DEAD_COMPANIES, AllowedSourcesSet);
	
	DEADCOStats := TABLE(DEADCO,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_INFOUSA_DEAD_COMPANIES,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 // For DEADCO there are two fields containing employee counts, keep whichever has the higher population amount
			 INTEGER FirmEmployeeCount := MAX(MAX(GROUP, (INTEGER)total_employees_actual), MAX(GROUP, (INTEGER)num_employees_actual))
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
			 
	DEADCOStatsTemp := PROJECT(DEADCOStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.EmployeeSources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.FirmEmployeeCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	DEADCOStatsRolled := ROLLUP(DEADCOStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources; SELF := LEFT));

	// ----- DEADCO: calculate NameSources, AddressVerSources, and PhoneSources child datasets. -----

		tempDEADCOCalc := RECORD
    UNSIGNED4 Seq;
    DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneSources;
    DATASET(Business_Risk_BIP.Layouts.LayoutSources) NameSources;
    DATASET(Business_Risk_BIP.Layouts.LayoutSources) AddressVerSources;
  END;
	
	tempDEADCOCalc calcDEADCO(Business_Risk_BIP.Layouts.Shell le, DEADCO ri) := TRANSFORM
		SELF.Seq := le.Seq;
		
		// In an effort to "short circuit" the fuzzy matching require that the first character match before doing the fuzzy comparison - this helps with latency
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.company_name) <> '';
		NameMatched					 := NamePopulated AND le.Clean_Input.CompanyName[1] = ri.company_name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.company_name));
		
		NoScoreValue				 := 255;
		AddressPopulated	:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip5) <> '';
		ZIPScore						   := IF(le.Clean_Input.Zip <> '' AND ri.Zip5 <> '' AND le.Clean_Input.Zip[1] = ri.Zip5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip, ri.Zip5), NoScoreValue);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.St <> '' AND le.Clean_Input.State[1] = ri.St[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.St, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue, 
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));
		
		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.phone) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.phone[1] OR le.Clean_Input.Phone10[4] = ri.phone[4] OR le.Clean_Input.Phone10[4] = ri.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.phone));
		
		// This is also being calculated in Business_Risk_BIP.getBusinessHeader and Business_Risk_BIP.getEDA to help boost verification, 
		// Only the levels that can be calculated with a phone match will be calculated here	
  BNAPCalc := Business_Risk_BIP.Common.calcBNAP_narrow(NameMatched, AddressMatched, PhoneMatched);
		
		DateFirstSeen       := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_first_seen           , Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_first_reported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateLastSeen        := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen            , Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorLastSeen  := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_last_reported , Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		
		temp_Sources := DATASET([{MDR.SourceTools.src_INFOUSA_DEAD_COMPANIES, 
												 DateFirstSeen, 
												 DateVendorFirstSeen, 
												 DateLastSeen,
												 DateVendorLastSeen,
												 1}], Business_Risk_BIP.Layouts.LayoutSources); 
												 
		SELF.PhoneSources      := IF(                                  BNAPCalc IN ['4', '5', '8'], temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.NameSources       := IF(Options.BusShellVersion >= 22 AND BNAPCalc IN ['5', '8']     , temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));																											
		SELF.AddressVerSources := IF(Options.BusShellVersion >= 22 AND BNAPCalc IN ['4', '8']     , temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));					
	END;
	
	DEADCOBNAPRaw := JOIN(Shell, DEADCO, LEFT.Seq = RIGHT.Seq,
																	calcDEADCO(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	DEADCOBNAPRolled := ROLLUP(SORT(DEADCOBNAPRaw, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempDEADCOCalc,
																			SELF.NameSources       := LEFT.NameSources + RIGHT.NameSources;
																			SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																			SELF.PhoneSources      := LEFT.PhoneSources + RIGHT.PhoneSources;
																			SELF := LEFT));

  DEADCOStatsSources := JOIN(DEADCOStatsRolled, DEADCOBNAPRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                       SELF.seq                     := LEFT.seq;
                       SELF.NameSources             := RIGHT.NameSources;
                       SELF.AddressVerSources       := RIGHT.AddressVerSources;
                       SELF.PhoneSources            := RIGHT.PhoneSources;
                       SELF.Sources                 := LEFT.Sources;
                       SELF.EmployeeSources         := LEFT.EmployeeSources;
                       SELF := LEFT,
                       SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withDEADCO := JOIN(withDCA, DEADCOStatsSources, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                       SELF.NameSources             := LEFT.NameSources + RIGHT.NameSources,
                       SELF.AddressVerSources       := LEFT.AddressVerSources + RIGHT.AddressVerSources,
                       SELF.PhoneSources            := LEFT.PhoneSources + RIGHT.PhoneSources,
																							SELF.Sources                 := LEFT.Sources + RIGHT.Sources,
																							SELF.EmployeeSources         := LEFT.EmployeeSources + RIGHT.EmployeeSources,
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	// ---------------- ABIUS ------------------
	ABIUSRaw := InfoUSA.Key_ABIUS_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	
	Business_Risk_BIP.Common.AppendSeq2(ABIUSRaw, Shell, ABIUSSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesABIUS := Business_Risk_BIP.Common.GrabFetchErrorCode(ABIUSSeq);
	
	ABIUS := Business_Risk_BIP.Common.FilterRecords(ABIUSSeq, date_added, process_date, MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ, AllowedSourcesSet);
	
	ABIUSStats := TABLE(ABIUS,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_added, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(process_date, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(process_date, HistoryDate), // ABIUS doesn't contain a date last seen so we are attempting to use the date the record was processed (added) as last seen
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate, //nothing to use as vendor last seen date in ABIUS
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 // For DEADCO there are two fields containing employee counts, keep whichever has the higher population amount
			 INTEGER FirmEmployeeCount := MAX(MAX(GROUP, (INTEGER)total_employees_actual), MAX(GROUP, (INTEGER)num_employees_actual))
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	
	ABIUSStatsTemp := PROJECT(ABIUSStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF.EmployeeSources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.FirmEmployeeCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	ABIUSStatsRolled := ROLLUP(ABIUSStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources; SELF := LEFT));
	
	withABIUS := JOIN(withDEADCO, ABIUSStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							EmpSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
																							SELF.EmployeeSources := EmpSources;
																							// Keep the employee count that is tied to the most trustworthy source, following by dates first/last seen and employee count to be deterministic.
																							// Based on modeling feedback trust the sources in this order: DF, BR, IA, IC
																							// Only keep sources that have employee count populated
																							SELF.Firmographic.FirmEmployeeCount := (STRING)Business_Risk_BIP.Common.capNum(SORT(EmpSources (RecordCount > 0), -(Source = 'DF'), -(Source = 'BR'), -(Source = 'IA'), -(Source = 'IC'), -DateLastSeen, -DateFirstSeen, -RecordCount)[1].RecordCount, -1, 999999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	withErrorCodesDNBDMI := JOIN(withABIUS, kFetchErrorCodesDNBDMI, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeDNBDMI := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesBusinessRegistration := JOIN(withErrorCodesDNBDMI, kFetchErrorCodesBusinessRegistration, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeBusinessRegistration := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesDCA := JOIN(withErrorCodesBusinessRegistration, kFetchErrorCodesDCA, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeDCA := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesDeadCo := JOIN(withErrorCodesDCA, kFetchErrorCodesDeadCo, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeDeadCo := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesABIUS := JOIN(withErrorCodesDeadCo, kFetchErrorCodesABIUS, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeABIUS := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

  // *********************
  //   DEBUGGING OUTPUTS
  // *********************
  // OUTPUT(CHOOSEN(OSHARaw, 100), NAMED('Sample_OSHARaw'));
  // OUTPUT( DEADCO, NAMED('DEADCO'), ALL );
  // OUTPUT( DEADCOBNAPRaw, NAMED('DEADCOBNAPRaw') );
  // OUTPUT( DEADCOBNAPRolled, NAMED('DEADCOBNAPRolled') );
  // OUTPUT( DEADCOStatsSources, NAMED('DEADCOStatsSources') );
  // OUTPUT( withDEADCO, NAMED('withDEADCO') );
  
	
	RETURN withErrorCodesABIUS;
END;