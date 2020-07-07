IMPORT Gateway, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT, Royalty, STD;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_IPAddress_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																						DATASET(Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries) Inquiries,
																																						UNSIGNED1 DPPAPurpose,
																																						UNSIGNED1 GLBPurpose,
																																						STRING50 DataRestrictionMask,
																																						DATASET(Gateway.Layouts.Config) NetacuityGateway = Gateway.Constants.void_gateway) := FUNCTION
		
	// Get NetAcuity Gateway information so we can determine if the country is outside the United States
	RiskWise.Layout_IPAI formatInput(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.IPAddr := le.Clean_Input.IPAddress;
	END;
	formattedInput := PROJECT(Input, formatInput(LEFT));
	
	netAcuityResults := Risk_Indicators.getNetAcuity(formattedInput, NetacuityGateway, DPPAPurpose, GLBPurpose);

	TempNetAcuity := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 IPAddress := '';
		STRING8 DateFirstSeen := '';
		BOOLEAN IPAddressNotInUSA := FALSE;
		UNSIGNED2 Royalty_NAG := 0;
	END;
	TempNetAcuity getNetAcuityResults(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, RiskWise.Layout_IP2O ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.IPAddress := ri.IPAddr;
		SELF.DateFirstSeen := IF(le.Clean_Input.ArchiveDate <> 999999, le.Clean_Input.ArchiveDate + '01', (STRING8)Std.Date.Today());
		SELF.IPAddressNotInUSA := ri.ipresponse <> 'Gateway Error' AND ri.CountryCode NOT IN ['US', '']; // If the Gateway didn't error and the CountryCode is outside the US set to TRUE.
		SELF.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(ri.ipaddr, ri.iptype);
	END;
	withNetAcuity := JOIN(Input, netAcuityResults, LEFT.Seq = RIGHT.Seq, getNetAcuityResults(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost));
	
	// Get all inquiries record information
	TempInquiryIPAddress := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 IPAddress := '';
		// LNRS Counts are all inquiries across LexisNexisRiskSolutions products included in set_valid_suspiciousfraud_functions
		UNSIGNED2 InquiryCountLNRSHour := 0;
		UNSIGNED2 InquiryCountLNRSDay := 0;
		UNSIGNED2 InquiryCountLNRSWeek := 0;
		UNSIGNED2 InquiryCountLNRSMonth := 0;
		UNSIGNED2 InquiryCountLNRSYear := 0;
		UNSIGNED3 InquiryCountLNRS := 0;
		STRING8 DateFirstSeenLNRS := '';
		// LNRSnSF Counts are all inquiries in LNRS excluding Suspicious Fraud Function (nSF = No Suspicious Fraud)
		UNSIGNED2 InquiryCountLNRSnSFHour := 0;
		UNSIGNED2 InquiryCountLNRSnSFDay := 0;
		UNSIGNED2 InquiryCountLNRSnSFWeek := 0;
		UNSIGNED2 InquiryCountLNRSnSFMonth := 0;
		UNSIGNED2 InquiryCountLNRSnSFYear := 0;
		UNSIGNED3 InquiryCountLNRSnSF := 0;
		STRING8 DateFirstSeenLNRSnSF := '';
		// SF Counts are all inquiries to the Suspicious Fraud Function
		UNSIGNED2 InquiryCountSFHour := 0;
		UNSIGNED2 InquiryCountSFDay := 0;
		UNSIGNED2 InquiryCountSFWeek := 0;
		UNSIGNED2 InquiryCountSFMonth := 0;
		UNSIGNED2 InquiryCountSFYear := 0;
		UNSIGNED3 InquiryCountSF := 0;
		STRING8 DateFirstSeenSF := '';
	END;
	TempInquiryIPAddress getInquiries(Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.IPAddress := le.IPaddr;
		
		isSF := le.SuspiciousFraudFunction = TRUE;
		lastHour := le.ageinhours <= 1; // Inquiry within the last hour
		lastDay := le.ageindays <= 1; // Inquiry within the last day
		lastWeek := le.ageinweeks <= 1; // Inquiry within the last week
		lastMonth := le.ageinmonths <= 1; // Inquiry within the last month
		lastYear := le.ageinyears <= 1; // Inquiry within the last year
		
		// LNRS Counts are all inquiries across LexisNexisRiskSolutions products included in set_valid_suspiciousfraud_functions
		SELF.InquiryCountLNRSHour := IF(lastHour, 1, 0);
		SELF.InquiryCountLNRSDay := IF(lastDay, 1, 0);
		SELF.InquiryCountLNRSWeek := IF(lastWeek, 1, 0);
		SELF.InquiryCountLNRSMonth := IF(lastMonth, 1, 0);
		SELF.InquiryCountLNRSYear := IF(lastYear, 1, 0);
		SELF.InquiryCountLNRS := 1;
		SELF.DateFirstSeenLNRS := le.logdate;
		// LNRSnSF Counts are all inquiries in LNRS excluding Suspicious Fraud Function (nSF = No Suspicious Fraud)
		SELF.InquiryCountLNRSnSFHour := IF(~isSF AND lastHour, 1, 0);
		SELF.InquiryCountLNRSnSFDay := IF(~isSF AND lastDay, 1, 0);
		SELF.InquiryCountLNRSnSFWeek := IF(~isSF AND lastWeek, 1, 0);
		SELF.InquiryCountLNRSnSFMonth := IF(~isSF AND lastMonth, 1, 0);
		SELF.InquiryCountLNRSnSFYear := IF(~isSF AND lastYear, 1, 0);
		SELF.InquiryCountLNRSnSF := IF(~isSF, 1, 0);
		SELF.DateFirstSeenLNRSnSF := IF(~isSF, le.logdate, '');
		// SF Counts are all inquiries to the Suspicious Fraud Function
		SELF.InquiryCountSFHour := IF(isSF AND lastHour, 1, 0);
		SELF.InquiryCountSFDay := IF(isSF AND lastDay, 1, 0);
		SELF.InquiryCountSFWeek := IF(isSF AND lastWeek, 1, 0);
		SELF.InquiryCountSFMonth := IF(isSF AND lastMonth, 1, 0);
		SELF.InquiryCountSFYear := IF(isSF AND lastYear, 1, 0);
		SELF.InquiryCountSF := IF(isSF, 1, 0);
		SELF.DateFirstSeenSF := IF(isSF, le.logdate, '');
	END;
	inquiryBucketed := PROJECT(Inquiries, getInquiries(LEFT));
	
	TempInquiryIPAddress countInquiries(TempInquiryIPAddress le, TempInquiryIPAddress ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.IPAddress := le.IPAddress;
		
		SELF.InquiryCountLNRSHour := le.InquiryCountLNRSHour + ri.InquiryCountLNRSHour;
		SELF.InquiryCountLNRSDay := le.InquiryCountLNRSDay + ri.InquiryCountLNRSDay;
		SELF.InquiryCountLNRSWeek := le.InquiryCountLNRSWeek + ri.InquiryCountLNRSWeek;
		SELF.InquiryCountLNRSMonth := le.InquiryCountLNRSMonth + ri.InquiryCountLNRSMonth;
		SELF.InquiryCountLNRSYear := le.InquiryCountLNRSYear + ri.InquiryCountLNRSYear;
		SELF.InquiryCountLNRS := le.InquiryCountLNRS + ri.InquiryCountLNRS;
		SELF.DateFirstSeenLNRS := MAP((UNSIGNED)le.DateFirstSeenLNRS = 0	=> ri.DateFirstSeenLNRS,
																	(UNSIGNED)ri.DateFirstSeenLNRS = 0	=> le.DateFirstSeenLNRS,
																																				(STRING8)MIN((UNSIGNED)le.DateFirstSeenLNRS, (UNSIGNED)ri.DateFirstSeenLNRS));
		
		SELF.InquiryCountLNRSnSFHour := le.InquiryCountLNRSnSFHour + ri.InquiryCountLNRSnSFHour;
		SELF.InquiryCountLNRSnSFDay := le.InquiryCountLNRSnSFDay + ri.InquiryCountLNRSnSFDay;
		SELF.InquiryCountLNRSnSFWeek := le.InquiryCountLNRSnSFWeek + ri.InquiryCountLNRSnSFWeek;
		SELF.InquiryCountLNRSnSFMonth := le.InquiryCountLNRSnSFMonth + ri.InquiryCountLNRSnSFMonth;
		SELF.InquiryCountLNRSnSFYear := le.InquiryCountLNRSnSFYear + ri.InquiryCountLNRSnSFYear;
		SELF.InquiryCountLNRSnSF := le.InquiryCountLNRSnSF + ri.InquiryCountLNRSnSF;
		SELF.DateFirstSeenLNRSnSF := MAP((UNSIGNED)le.DateFirstSeenLNRSnSF = 0	=> ri.DateFirstSeenLNRSnSF,
																		 (UNSIGNED)ri.DateFirstSeenLNRSnSF = 0	=> le.DateFirstSeenLNRSnSF,
																																							(STRING8)MIN((UNSIGNED)le.DateFirstSeenLNRSnSF, (UNSIGNED)ri.DateFirstSeenLNRSnSF));
		
		SELF.InquiryCountSFHour := le.InquiryCountSFHour + ri.InquiryCountSFHour;
		SELF.InquiryCountSFDay := le.InquiryCountSFDay + ri.InquiryCountSFDay;
		SELF.InquiryCountSFWeek := le.InquiryCountSFWeek + ri.InquiryCountSFWeek;
		SELF.InquiryCountSFMonth := le.InquiryCountSFMonth + ri.InquiryCountSFMonth;
		SELF.InquiryCountSFYear := le.InquiryCountSFYear + ri.InquiryCountSFYear;
		SELF.InquiryCountSF := le.InquiryCountSF + ri.InquiryCountSF;
		SELF.DateFirstSeenSF := MAP((UNSIGNED)le.DateFirstSeenSF = 0	=> ri.DateFirstSeenSF,
																(UNSIGNED)ri.DateFirstSeenSF = 0	=> le.DateFirstSeenSF,
																																		(STRING8)MIN((UNSIGNED)le.DateFirstSeenSF, (UNSIGNED)ri.DateFirstSeenSF));
	END;
	inquiriesCounted := ROLLUP(SORT(inquiryBucketed, Seq), LEFT.Seq = RIGHT.Seq, countInquiries(LEFT, RIGHT));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquiryIPAddressRiskCodes(TempInquiryIPAddress le) := TRANSFORM
		RiskCodesSFTemp															:= IF(le.InquiryCountSFYear >= 7, Suspicious_Fraud_LN.Common.genRiskCode('I02')) +
																									 IF(le.InquiryCountSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('I03')) +
																									 IF(le.InquiryCountSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('I04')) +
																									 IF(le.InquiryCountSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('I05')) +
																									 IF(le.InquiryCountSFHour >= 1, Suspicious_Fraud_LN.Common.genRiskCode('I06'));
		RiskCodes																				:= RiskCodesSFTemp (TRIM(SuspiciousRiskCode) <> '');
		IPAddressHit 																		:= ut.Exists2(RiskCodes);
		SELF.Suspicious_IPAddress.Data_Source						:= IF(IPAddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_IPAddress.DateFirstSeenInFile		:= MAP(IPAddressHit = TRUE	=> le.DateFirstSeenSF,
																																					'');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_IPAddress.InquiryCountHour			:= le.InquiryCountSFHour;
		SELF.Suspicious_IPAddress.InquiryCountDay				:= le.InquiryCountSFDay;
		SELF.Suspicious_IPAddress.InquiryCountWeek			:= le.InquiryCountSFWeek;
		SELF.Suspicious_IPAddress.InquiryCountMonth			:= le.InquiryCountSFMonth;
		SELF.Suspicious_IPAddress.InquiryCountYear			:= le.InquiryCountSFYear;
		SELF.Suspicious_IPAddress.InquiryCount					:= le.InquiryCountSF;
		SELF.RiskCode_IPAddress													:= RiskCodes;
		
		SELF.Seq																				:= le.Seq;
		SELF.Clean_Input.IPAddress											:= le.IPAddress;
		
		SELF 																						:= le;
		SELF 																						:= [];
	END;
	inquiryIPAddressRiskCodes := PROJECT(inquiriesCounted, getInquiryIPAddressRiskCodes(LEFT)) (ut.Exists2(RiskCode_IPAddress));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getNetAcuityIPAddressRiskCodes(TempNetAcuity le) := TRANSFORM
		RiskCodesTemp																		:= IF(le.IPAddressNotInUSA = TRUE, Suspicious_Fraud_LN.Common.genRiskCode('I01'));
		RiskCodes																				:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		IPAddressHit 																		:= ut.Exists2(RiskCodes);
		SELF.Suspicious_IPAddress.Data_Source						:= IF(IPAddressHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_IPAddress.DateFirstSeenInFile		:= MAP(IPAddressHit = TRUE	=> le.DateFirstSeen,'');
		SELF.Suspicious_IPAddress.Royalty_NAG						:= le.Royalty_NAG;																																				
		SELF.RiskCode_IPAddress													:= RiskCodes;
		
		SELF.Seq																				:= le.Seq;
		SELF.Clean_Input.IPAddress											:= le.IPAddress;
		
		SELF 																						:= le;
		SELF 																						:= [];
	END;
	netAcuityIPAddressRiskCodes := PROJECT(withNetAcuity, getNetAcuityIPAddressRiskCodes(LEFT));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combineIPAddressRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_IPAddress.Data_Source := IF(le.Suspicious_IPAddress.Data_Source <> '', le.Suspicious_IPAddress.Data_Source, ri.Suspicious_IPAddress.Data_Source);
		SELF.Suspicious_IPAddress.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_IPAddress.DateFirstSeenInFile = 0	=> ri.Suspicious_IPAddress.DateFirstSeenInFile,
																									 (UNSIGNED)ri.Suspicious_IPAddress.DateFirstSeenInFile = 0	=> le.Suspicious_IPAddress.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_IPAddress.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_IPAddress.DateFirstSeenInFile));
		SELF.Suspicious_IPAddress.InquiryCountHour := le.Suspicious_IPAddress.InquiryCountHour + ri.Suspicious_IPAddress.InquiryCountHour;
		SELF.Suspicious_IPAddress.InquiryCountDay := le.Suspicious_IPAddress.InquiryCountDay + ri.Suspicious_IPAddress.InquiryCountDay;
		SELF.Suspicious_IPAddress.InquiryCountWeek := le.Suspicious_IPAddress.InquiryCountWeek + ri.Suspicious_IPAddress.InquiryCountWeek;
		SELF.Suspicious_IPAddress.InquiryCountMonth := le.Suspicious_IPAddress.InquiryCountMonth + ri.Suspicious_IPAddress.InquiryCountMonth;
		SELF.Suspicious_IPAddress.InquiryCountYear := le.Suspicious_IPAddress.InquiryCountYear + ri.Suspicious_IPAddress.InquiryCountYear;
		SELF.Suspicious_IPAddress.InquiryCount := le.Suspicious_IPAddress.InquiryCount + ri.Suspicious_IPAddress.InquiryCount;
		SELF.Suspicious_IPAddress.Royalty_NAG := le.Suspicious_IPAddress.Royalty_NAG+ri.Suspicious_IPAddress.Royalty_NAG;
		SELF.RiskCode_IPAddress := le.RiskCode_IPAddress + ri.RiskCode_IPAddress;
		
		SELF := le;
	END;
	
	IPAddressRiskCodesCombined := SORT(inquiryIPAddressRiskCodes + netAcuityIPAddressRiskCodes, Seq);

	IPAddressRiskCodesTemp := ROLLUP(IPAddressRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combineIPAddressRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanIPAddressRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_IPAddress, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_IPAddress := sortedCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanIPAddressRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_IPAddress;
		SELF.Suspicious_IPAddress.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		SELF.Suspicious_IPAddress.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_IPAddress.DateFirstSeenInFile);
		SELF := le;
	END;
	IPAddressRiskCodes1 := PROJECT(IPAddressRiskCodesTemp, cleanIPAddressRiskCodes1(LEFT));
	IPAddressRiskCodes := PROJECT(NOFOLD(IPAddressRiskCodes1), cleanIPAddressRiskCodes2(LEFT));

	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(inquiryBucketed, NAMED('inquiryIPAddressBucketed'));
	// OUTPUT(inquiriesCounted, NAMED('inquiriesIPAddressCounted'));
	// OUTPUT(formattedInput, NAMED('formattedInput'));
	// OUTPUT(netAcuityResults, NAMED('netAcuityResults'));
	// OUTPUT(withNetAcuity, NAMED('withNetAcuity'));
	// OUTPUT(inquiryIPAddressRiskCodes, NAMED('inquiryIPAddressRiskCodes'));
	// OUTPUT(netAcuityIPAddressRiskCodes, NAMED('netAcuityIPAddressRiskCodes'));
	// OUTPUT(IPAddressRiskCodesCombined, NAMED('IPAddressRiskCodesCombined'));
	// OUTPUT(IPAddressRiskCodesTemp, NAMED('IPAddressRiskCodesTemp'));
	// OUTPUT(IPAddressRiskCodes1, NAMED('IPAddressRiskCodes1'));
	// OUTPUT(IPAddressRiskCodes, NAMED('IPAddressRiskCodes'));

	/* ******** END DEBUGGING SECTION **********/
	RETURN (IPAddressRiskCodes);
END;