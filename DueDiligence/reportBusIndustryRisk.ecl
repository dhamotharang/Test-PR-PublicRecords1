IMPORT BIPv2, codes, DueDiligence, faa, iesp, Risk_Indicators, STD;

/*
	Following Keys being used:
			Risk_Indicators.Key_Sic_Description
			Codes.Key_NAICS
*/

EXPORT reportBusIndustryRisk(DATASET(DueDiligence.Layouts.Busn_Internal) inData) := FUNCTION



	industryRisk := NORMALIZE(inData, LEFT.sicNaicSources, TRANSFORM(DueDiligence.LayoutsInternal.SlimSicNaicLayout,
																																																																		SELF := RIGHT;
																																																																		SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																																																																		SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																																																																		SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																																																																		
																																																																		tempSic := TRIM(RIGHT.SICCode) + '00000000';
																																																																		newSic := tempSic[1..8];
																																																																		
																																																																		SELF.formattedSicCode := newSic;
																																																																		SELF := LEFT;
																																																																		SELF := [];));
																																		
	//filter out sic and naics
	sicOnly := industryRisk(SICCode <> DueDiligence.Constants.EMPTY);
	naicsOnly := industryRisk(NAICCode <> DueDiligence.Constants.EMPTY);
																																		
	//get descriptions
 sicDescriptions := JOIN(sicOnly, Risk_Indicators.Key_Sic_Description,
																									LEFT.formattedSicCode = RIGHT.sic_code,
																									TRANSFORM(RECORDOF(LEFT),	
																														SELF.codeDescription := RIGHT.sic_description; // get desc from key
																														SELF := LEFT;),
																									LEFT OUTER,
																									ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
																									KEEP(1)); // should only be 1 matching sic_code on right
								
	
	naicDiscriptions := JOIN(naicsOnly, Codes.Key_NAICS,
																										LEFT.NAICCode = RIGHT.naics_code,
																										TRANSFORM(RECORDOF(LEFT),	
																															SELF.codeDescription := RIGHT.naics_description; // get desc from key
																															SELF := LEFT;),
																										LEFT OUTER, 
																										ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
																										KEEP(1)); // should only be 1 matching sic_code on right					 
	

	//add the descriptions back together
	joinedCodes := sicDescriptions + naicDiscriptions;
	sortCodes := SORT(joinedCodes, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dateLastSeen);

	//group slimmed dataset by seq and linkIDs so counter can count per grouping
	groupIndustry := GROUP(sortCodes, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	
	//transform to limit the number of data in our dataset
	DueDiligence.LayoutsInternalReport.BusIndustryRiskChildren getReportChildren(DueDiligence.LayoutsInternal.SlimSicNaicLayout snuil, INTEGER c) := TRANSFORM, SKIP(c > iesp.Constants.DDRAttributesConst.MaxSICNAICs)
		SELF.industryRisk := PROJECT(snuil, TRANSFORM(iesp.duediligencereport.t_DDRSICNAIC,
																																																SELF.sicCode := LEFT.sicCode;
																																																SELF.naicsCode := LEFT.naicCode;
																																																SELF.description := LEFT.codeDescription;
																																																SELF.firstReported := iesp.ECL2ESP.toDate(LEFT.dateFirstSeen);
																																																SELF.lastReported := iesp.ECL2ESP.toDate(LEFT.dateLastSeen);
																																																SELF.industryRisk := IF(LEFT.sicRiskLevel = DueDiligence.Constants.EMPTY, LEFT.naicRiskLevel, LEFT.sicRiskLevel);
																																																
																																																SELF.cashIntensiveRetail := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL OR
																																																																LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL, TRUE, FALSE);
																																																																
																																																SELF.cashIntensiveNonRetail := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL OR
																																																																	LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL, TRUE, FALSE);
																																																
																																																SELF.moneyServiceBusiness := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS OR
																																																																LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS, TRUE, FALSE);
																																																
																																																SELF.nonBankFinancialInstituion := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS OR
																																																																			LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS, TRUE, FALSE);
																																																
																																																SELF.casinoOrGamblingRelated := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING OR
																																																																		LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING, TRUE, FALSE);
																																																
																																																SELF.legalAccountantTelemarketerFlightOrTravel := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL OR
																																																																											LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL, TRUE, FALSE);
																																																
																																																SELF.automotive := IF(LEFT.sicIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE OR
																																																											LEFT.naicIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE, TRUE, FALSE);
																																																
																																																SELF := LEFT;
																																																SELF := [];));
		SELF := snuil;
	END;
														
	//convert to iesp layout
	industryRiskChild := PROJECT(groupIndustry, getReportChildren(LEFT, COUNTER));
																									
	
	addIndustryToReport := DENORMALIZE(inData, industryRiskChild,
																			LEFT.seq = RIGHT.seq AND
																			LEFT.busn_info.BIP_IDs.UltID.LinkID = RIGHT.ultID AND
																			LEFT.busn_info.BIP_IDs.OrgID.LinkID = RIGHT.orgID AND
																			LEFT.busn_info.BIP_IDs.SeleID.LinkID = RIGHT.SeleID,
																			TRANSFORM(DueDiligence.layouts.Busn_Internal,
																								SELF.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.SICNAICs := LEFT.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessInformation.SICNAICs + RIGHT.industryrisk;
																								SELF := LEFT;));
												





	OUTPUT(industryRisk, NAMED('industryRisk'));
	OUTPUT(sicOnly, NAMED('sicOnly'));
	OUTPUT(naicsOnly, NAMED('naicsOnly'));
	OUTPUT(sicDescriptions, NAMED('sicDescriptions'));
	OUTPUT(naicDiscriptions, NAMED('naicDiscriptions'));
	// OUTPUT(joinedCodes, NAMED('joinedCodes'));
	// OUTPUT(sortCodes, NAMED('sortCodes'));


	// OUTPUT(industryRiskChild, NAMED('industryRiskChild'));
	// OUTPUT(addIndustryToReport, NAMED('addIndustryToReport'));
	
	
	RETURN addIndustryToReport;

END;   