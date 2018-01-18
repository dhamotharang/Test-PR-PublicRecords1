IMPORT BIPV2, Business_Risk_BIP, CalBus, DCAV2, DueDiligence, EBR, FBNv2, OSHAIR, YellowPages, STD;

/*
	Following Keys being used:
			OSHAIR.Key_OSHAIR_LinkIds.kFetch2
			EBR.Key_5600_Demographic_Data_linkids.kFetch2
			DCAV2.Key_LinkIds.kFetch2
			FBNv2.Key_LinkIds.kFetch2
			YellowPages.key_yellowpages_linkids.kFetch2
			CalBus.Key_Calbus_LinkIDS.kFetch2
*/

EXPORT getBusSicNaic(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
											Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
											BIPV2.mod_sources.iParams linkingOptions,
											BOOLEAN includeReportData) := FUNCTION


	linkIDs := DueDiligence.Common.GetLinkIDs(indata);
		
	// ---------------- OSHA - Occupational Safety and Health Administration ------------------
	oshaRaw := OSHAIR.Key_OSHAIR_LinkIds.kFetch2(linkIDs,
																							 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							 0, //ScoreThreshold --> 0 = Give me everything
																							 Business_Risk_BIP.Constants.Limit_Default,
																							 Options.KeepLargeBusinesses);																						 
																							 
	// Add back our Seq numbers
	oshaRawSeq := DueDiligence.Common.AppendSeq(oshaRaw, indata, TRUE);
				
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently 
	oshaCleanDate := DueDiligence.Common.CleanDatasetDateFields(oshaRawSeq, 'inspection_opening_date, inspection_close_date');
	
	// Filter out records after our history date.
	oshaFilt := DueDiligence.Common.FilterRecordsSingleDate(oshaCleanDate, inspection_opening_date);
	
	//retrieve SIC and NAIC codes with dates
	outOshaSic := DueDiligence.Common.getSicNaicCodes(oshaFilt, sic_code, TRUE, TRUE, inspection_opening_date, inspection_close_date);
	outOshaNaic := DueDiligence.Common.getSicNaicCodes(oshaFilt, naics_code, FALSE, TRUE, inspection_opening_date, inspection_close_date);
	outOshaNaic2 := DueDiligence.Common.getSicNaicCodes(oshaFilt, naics_secondary_code, FALSE, FALSE, inspection_opening_date, inspection_close_date);
	
	allOshaSicNaic := outOshaSic + outOshaNaic + outOshaNaic2;
	sortOshaRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(indata, allOshaSicNaic);
		
	addOshaSicNaic := JOIN(indata, sortOshaRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);		



	// ---------------- EBR - Experian Business Records ------------------
	ebr5600Raw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(linkIDs,
																															 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																															 0, //ScoreThreshold --> 0 = Give me everything
																															 linkingOptions,
																															 Business_Risk_BIP.Constants.Limit_Default,
																															 Options.KeepLargeBusinesses);
																															 
	// Add back our Seq numbers
	ebr5600RawSeq := DueDiligence.Common.AppendSeq(ebr5600Raw, indata, TRUE);

	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	ebrDateClean := DueDiligence.Common.CleanDatasetDateFields(ebr5600RawSeq, 'date_last_seen, date_first_seen');
	
	// Filter out records after our history date.
	ebrFilt := DueDiligence.Common.FilterRecordsSingleDate(ebrDateClean, date_first_seen);
	
	//retrieve SIC and NAIC codes with dates
	outEbrSic := DueDiligence.Common.getSicNaicCodes(ebrFilt, sic_1_code, TRUE, TRUE, date_first_seen, date_last_seen);
	outEbrSic2 := DueDiligence.Common.getSicNaicCodes(ebrFilt, sic_2_code, TRUE, FALSE, date_first_seen, date_last_seen);
	outEbrSic3 := DueDiligence.Common.getSicNaicCodes(ebrFilt, sic_3_code, TRUE, FALSE, date_first_seen, date_last_seen);
	outEbrSic4 := DueDiligence.Common.getSicNaicCodes(ebrFilt, sic_4_code, TRUE, FALSE, date_first_seen, date_last_seen);
	
	
	allEbrSicNaic := outEbrSic + outEbrSic2 + outEbrSic3 + outEbrSic4;
	sortEbrRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(addOshaSicNaic, allEbrSicNaic);
		
	addEbrSicNaic := JOIN(addOshaSicNaic, sortEbrRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);	
													
													
													
	// ---------------- DCA - Directory of Corporate Affiliations AKA LNCA ------------------
	dcaRaw := DCAV2.Key_LinkIds.kFetch2(linkIDs,
																			 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																			 0, //ScoreThreshold --> 0 = Give me everything
																			 Business_Risk_BIP.Constants.Limit_Default,
																			 Options.KeepLargeBusinesses);		
																							
	// Add back our Seq numbers
	dcaRawSeq := DueDiligence.Common.AppendSeq(dcaRaw, indata, TRUE);
		
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	dcaDateClean := DueDiligence.Common.CleanDatasetDateFields(dcaRawSeq, 'date_first_seen, date_vendor_first_reported, date_last_seen');
	
	// Filter out records after our history date.
	dcaFilt := DueDiligence.Common.FilterRecords(dcaDateClean, date_first_seen, date_vendor_first_reported);

	
	//retrieve SIC and NAIC codes with dates
	//SIC
	outDcaSic := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic1, TRUE, TRUE, date_first_seen, date_last_seen);
	outDcaSic2 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic2, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic3 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic3, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic4 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic4, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic5 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic5, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic6 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic6, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic7 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic7, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic8 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic8, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic9 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic9, TRUE, FALSE, date_first_seen, date_last_seen);
	outDcaSic10 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.sic10, TRUE, FALSE, date_first_seen, date_last_seen);
	
	//NAICS
	outDcaNaic := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics1, FALSE, TRUE, date_first_seen, date_last_seen);
	outDcaNaic2 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics2, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic3 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics3, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic4 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics4, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic5 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics5, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic6 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics6, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic7 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics7, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic8 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics8, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic9 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics9, FALSE, FALSE, date_first_seen, date_last_seen);
	outDcaNaic10 := DueDiligence.Common.getSicNaicCodes(dcaFilt, rawfields.naics10, FALSE, FALSE, date_first_seen, date_last_seen);
	
	allDcaSicNaic := outDcaSic + outDcaSic2 + outDcaSic3 + outDcaSic4 + outDcaSic5 + outDcaSic6 + outDcaSic7 + outDcaSic8 +
									 outDcaSic9 + outDcaSic10 + outDcaNaic + outDcaNaic2 + outDcaNaic3 + outDcaNaic4 + outDcaNaic5 + outDcaNaic6 +
									 outDcaNaic7 + outDcaNaic8 + outDcaNaic9 + outDcaNaic10;
									 
	sortDcaRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(addEbrSicNaic, allDcaSicNaic);
		
	addDcaSicNaic := JOIN(addEbrSicNaic, sortDcaRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);			
													
													
													
	// ---------------- Ficticious Business Name ---------------------
	fbnRaw := FBNv2.Key_LinkIds.kFetch2(linkIDs,
																			 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																			 0, //ScoreThreshold --> 0 = Give me everything
																			 Business_Risk_BIP.Constants.Limit_Default,
																			 Options.KeepLargeBusinesses);	
																			 
	// Add back our Seq numbers
	fbnRawSeq := DueDiligence.Common.AppendSeq(fbnRaw, indata, TRUE);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	fbnDateClean := DueDiligence.Common.CleanDatasetDateFields(fbnRawSeq, 'dt_first_seen, dt_vendor_first_reported, dt_last_seen');
			
	// Filter out records after our history date.
	fbnFilt := DueDiligence.Common.FilterRecords(fbnDateClean, dt_first_seen, dt_vendor_first_reported);
	
	//retrieve SIC and NAIC codes with dates
	outFbnSic := DueDiligence.Common.getSicNaicCodes(fbnFilt, sic_code, TRUE, TRUE, dt_first_seen, dt_last_seen);
	
	sortFbnRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(addDcaSicNaic, outFbnSic);
		
	addFbnSicNaic := JOIN(addDcaSicNaic, sortFbnRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);	
													
												
													
	// ---------------- Yellow Pages ---------------------
	ypRaw := YellowPages.key_yellowpages_linkids.kFetch2(linkIDs,
																											 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																											 0, //ScoreThreshold --> 0 = Give me everything
																											 Business_Risk_BIP.Constants.Limit_Default,
																											 Options.KeepLargeBusinesses);
																									 
	// Add back our Seq numbers
	ypRawSeq := DueDiligence.Common.AppendSeq(ypRaw, indata, TRUE);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	ypCleanDate := DueDiligence.Common.CleanDatasetDateFields(ypRawSeq, 'pub_date');
			
	// Filter out records after our history date.
	ypFiltRec := DueDiligence.Common.FilterRecordsSingleDate(ypCleanDate, pub_date);
	
	//yellow pages does not have an end date - create one
	tempLayout := RECORD
		RECORDOF(ypFiltRec);
		UNSIGNED4 lastSeen;
	END;
	dsWithEndDate := PROJECT(ypFiltRec, TRANSFORM(tempLayout, SELF := LEFT; SELF := [];));
	
	// retrieve SIC and NAIC codes with dates
	outYpSic := DueDiligence.Common.getSicNaicCodes(dsWithEndDate, sic_code, TRUE, TRUE, pub_date, lastSeen);
	outYpSic2 := DueDiligence.Common.getSicNaicCodes(dsWithEndDate, sic2, TRUE, FALSE, pub_date, lastSeen);
	outYpSic3 := DueDiligence.Common.getSicNaicCodes(dsWithEndDate, sic3, TRUE, FALSE, pub_date, lastSeen);
	outYpSic4 := DueDiligence.Common.getSicNaicCodes(dsWithEndDate, sic4, TRUE, FALSE, pub_date, lastSeen);
	
	outYpNaic := DueDiligence.Common.getSicNaicCodes(dsWithEndDate, naics_code, FALSE, TRUE, pub_date, lastSeen);
	
	allYpSicNaic := outYpSic + outYpSic2 + outYpSic3 + outYpSic4 + outYpNaic;
	sortYpRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(addFbnSicNaic, outYpSic);
		
	addYpSicNaic := JOIN(addFbnSicNaic, sortYpRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);
												
											
	// ---------------- CALBUS - California Business ---------------------
	calBusRaw := CalBus.Key_Calbus_LinkIDS.kFetch2(linkIDs,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, //ScoreThreshold --> 0 = Give me everything
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	// Add back our Seq numbers
	calBusRawSeq := DueDiligence.Common.AppendSeq(calBusRaw, indata, TRUE);
			
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	calBusCleanDate := DueDiligence.Common.CleanDatasetDateFields(calBusRawSeq, 'dt_first_seen, dt_last_seen');
	
	// Filter out records after our history date.
	calBusFilt := DueDiligence.Common.FilterRecordsSingleDate(calBusCleanDate, dt_first_seen);
	
	//retrieve SIC and NAIC codes with dates
	outCalBusNaic := DueDiligence.Common.getSicNaicCodes(calBusFilt, naics_code, FALSE, TRUE, dt_first_seen, dt_last_seen);
	sortCalBusRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(addYpSicNaic, outCalBusNaic);
		
	addCalBusSicNaic := JOIN(addYpSicNaic, sortCalBusRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);




	//Grab all the SIC and NAIC codes from all sources
	allCodes := NORMALIZE(addCalBusSicNaic, LEFT.SicNaicSources, TRANSFORM(DueDiligence.LayoutsInternal.SicNaicUniqueIndustryLayout,
																																					SELF.seq := LEFT.seq;
																																					SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																																					SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																																					SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																																					SELF.cibRetailExists :=  RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL OR 
																																																	 RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL;
																																					SELF.cibNonRetailExists := RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL OR 
																																																		 RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL;								 
																																					SELF.msbExists :=  RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS OR 
																																														 RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS;
																																					SELF.nbfiExists := RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS OR 
																																														 RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS;
																																					SELF.cagExists :=  RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING OR 
																																														 RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING;
																																					SELF.autoExists := RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE OR 
																																														 RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE;
																																					SELF.legAcctTeleFlightTravExists := RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL OR 
																																																							RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL;
																																					
																																					SELF.otherHighRiskIndustExists := (RIGHT.SICRiskLevel = DueDiligence.Constants.RISK_LEVEL_HIGH AND RIGHT.SICIndustry = DueDiligence.Constants.INDUSTRY_OTHER) OR
																																																						(RIGHT.NAICRiskLevel = DueDiligence.Constants.RISK_LEVEL_HIGH AND RIGHT.NAICIndustry = DueDiligence.Constants.INDUSTRY_OTHER);								
																																					SELF.moderateRiskIndustExists := RIGHT.NAICRiskLevel = DueDiligence.Constants.RISK_LEVEL_MEDIUM;
																																					SELF.lowRiskIndustExists := RIGHT.SICRiskLevel = DueDiligence.Constants.RISK_LEVEL_LOW OR 
																																																			RIGHT.NAICRiskLevel = DueDiligence.Constants.RISK_LEVEL_LOW;
																																					SELF.sicCodes := RIGHT.sicCode;
																																					SELF.naicCodes := RIGHT.naicCode;
																																					SELF := RIGHT;
																																					SELF := []));
	//Determine if industry level or risk was hit	
	uniqueIndustriesSort := SORT(allCodes, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), sicCode, naicCode);
	
	uniqueIndustries := ROLLUP(uniqueIndustriesSort, 
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID,
															TRANSFORM(DueDiligence.LayoutsInternal.SicNaicUniqueIndustryLayout,
																				SELF.cibRetailExists := LEFT.cibRetailExists OR RIGHT.cibRetailExists;
																				SELF.cibNonRetailExists := LEFT.cibNonRetailExists OR RIGHT.cibNonRetailExists;
																				SELF.msbExists := LEFT.msbExists OR RIGHT.msbExists;
																				SELF.nbfiExists := LEFT.nbfiExists OR RIGHT.nbfiExists;
																				SELF.cagExists := LEFT.cagExists OR RIGHT.cagExists;
																				SELF.legAcctTeleFlightTravExists := LEFT.legAcctTeleFlightTravExists OR RIGHT.legAcctTeleFlightTravExists;
																				SELF.autoExists := LEFT.autoExists OR RIGHT.autoExists;
																				SELF.otherHighRiskIndustExists := LEFT.otherHighRiskIndustExists OR RIGHT.otherHighRiskIndustExists;
																				SELF.moderateRiskIndustExists := LEFT.moderateRiskIndustExists OR RIGHT.moderateRiskIndustExists;
																				SELF.lowRiskIndustExists := LEFT.lowRiskIndustExists OR RIGHT.lowRiskIndustExists;
																				
																				sicFound := RIGHT.sicCodes <> DueDiligence.Constants.EMPTY AND STD.Str.Find(LEFT.sicCodes, RIGHT.sicCodes, 1) = 0;	
																				naicFound := RIGHT.naicCodes <> DueDiligence.Constants.EMPTY AND STD.Str.Find(LEFT.naicCodes, RIGHT.naicCodes, 1) = 0;	
																				
																				SELF.sicCodes := IF(sicFound, IF(LEFT.sicCodes = DueDiligence.Constants.EMPTY, RIGHT.sicCodes, TRIM(LEFT.sicCodes) + ', ' + RIGHT.sicCodes), LEFT.sicCodes);
																				SELF.naicCodes := IF(naicFound, IF(LEFT.naicCodes = DueDiligence.Constants.EMPTY, RIGHT.naicCodes, TRIM(LEFT.naicCodes) + ', ' + RIGHT.naicCodes), LEFT.naicCodes);
																				SELF := LEFT;));
																				
	addIndustry := JOIN(addYpSicNaic, uniqueIndustries,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																SELF.sicNaicRisk.cibRetailExists := RIGHT.cibRetailExists;
																SELF.sicNaicRisk.cibNonRetailExists := RIGHT.cibNonRetailExists;
																SELF.sicNaicRisk.msbExists := RIGHT.msbExists;
																SELF.sicNaicRisk.nbfiExists := RIGHT.nbfiExists;
																SELF.sicNaicRisk.cagExists := RIGHT.cagExists;
																SELF.sicNaicRisk.legAcctTeleFlightTravExists := RIGHT.legAcctTeleFlightTravExists;
																SELF.sicNaicRisk.autoExists := RIGHT.autoExists;
																SELF.sicNaicRisk.otherHighRiskIndustExists := RIGHT.otherHighRiskIndustExists;
																SELF.sicNaicRisk.moderateRiskIndustExists := RIGHT.moderateRiskIndustExists;
																SELF.sicNaicRisk.lowRiskIndustExists := RIGHT.lowRiskIndustExists;
																SELF.sicNaicRisk.sicCodes := RIGHT.sicCodes;
																SELF.sicNaicRisk.naicCodes := RIGHT.naicCodes;
																SELF := LEFT;),
											LEFT OUTER);
	
											
	// addReport := IF(includeReportData, DueDiligence.reportBusIndustryRisk(addIndustry), addIndustry);

	// OUTPUT(ebr5600Raw, NAMED('ebr5600Raw'));
	// OUTPUT(ebr5600RawSeq, NAMED('ebr5600RawSeq'));
	// OUTPUT(allYpSicNaic, NAMED('allYpSicNaic'));
	// OUTPUT(sortYpRollSicNaic, NAMED('sortYpRollSicNaic'));
	// OUTPUT(allCodes, NAMED('allCodes'));
	// OUTPUT(uniqueIndustriesSort, NAMED('uniqueIndustriesSort'));
	// OUTPUT(uniqueIndustries, NAMED('uniqueIndustries'));
	// OUTPUT(addIndustry, NAMED('addIndustry'));
	
	
	// OUTPUT(addReport, NAMED('addReport'));
	
	

	RETURN addIndustry;
END;