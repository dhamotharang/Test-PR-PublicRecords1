IMPORT Inquiry_AccLogs, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_Name_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																			 DATASET(Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries) Inquiries,
																																			 UNSIGNED1 DPPAPurpose,
																																			 UNSIGNED1 GLBPurpose,
																																			 STRING50 DataRestrictionMask) := FUNCTION
	
	// Get all inquiries record information
	TempInquiryName := RECORD
		UNSIGNED8 Seq := 0;
		STRING20 FirstName := '';
		STRING20 MiddleName := '';
		STRING1 MiddleInitial := '';
		STRING20 LastName := '';
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
	TempInquiryName getInquiries(Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.FirstName := TRIM(le.fname, LEFT, RIGHT);
		Middle := TRIM(le.mname, LEFT, RIGHT);
		SELF.MiddleName := IF(LENGTH(TRIM(Middle)) <> 1, Middle, '');
		SELF.MiddleInitial := IF(LENGTH(TRIM(Middle)) = 1, Middle, '');
		SELF.LastName := TRIM(le.lname, LEFT, RIGHT);
		
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
	
	TempInquiryName countInquiries(TempInquiryName le, TempInquiryName ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.FirstName := le.FirstName;
		SELF.MiddleName := le.MiddleName;
		SELF.MiddleInitial := le.MiddleInitial;
		SELF.LastName := le.LastName;
		
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
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquiryNameRiskCodes(TempInquiryName le) := TRANSFORM
		RiskCodesSFTemp															:= IF(le.InquiryCountSFYear >= 7, Suspicious_Fraud_LN.Common.genRiskCode('N01')) +
																									 IF(le.InquiryCountSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('N02')) +
																									 IF(le.InquiryCountSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('N03')) +
																									 IF(le.InquiryCountSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('N04')) +
																									 IF(le.InquiryCountSFHour >= 1, Suspicious_Fraud_LN.Common.genRiskCode('N05'));
		RiskCodes																		:= RiskCodesSFTemp (TRIM(SuspiciousRiskCode) <> '');
		NameHit 																		:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Name.Data_Source						:= IF(NameHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Name.DateFirstSeenInFile		:= MAP(NameHit = TRUE	=> le.DateFirstSeenSF,
																																					'');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_Name.InquiryCountHour				:= le.InquiryCountSFHour;
		SELF.Suspicious_Name.InquiryCountDay				:= le.InquiryCountSFDay;
		SELF.Suspicious_Name.InquiryCountWeek				:= le.InquiryCountSFWeek;
		SELF.Suspicious_Name.InquiryCountMonth			:= le.InquiryCountSFMonth;
		SELF.Suspicious_Name.InquiryCountYear				:= le.InquiryCountSFYear;
		SELF.Suspicious_Name.InquiryCount						:= le.InquiryCountSF;
		SELF.RiskCode_Name													:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.FirstName									:= le.FirstName;
		SELF.Clean_Input.MiddleName									:= le.MiddleName;
		SELF.Clean_Input.MiddleInitial							:= le.MiddleInitial;
		SELF.Clean_Input.LastName										:= le.LastName;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	inquiryNameRiskCodes := PROJECT(inquiriesCounted, getInquiryNameRiskCodes(LEFT)) (ut.Exists2(RiskCode_Name));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combineNameRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_Name.Data_Source := IF(le.Suspicious_Name.Data_Source <> '', le.Suspicious_Name.Data_Source, ri.Suspicious_Name.Data_Source);
		SELF.Suspicious_Name.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_Name.DateFirstSeenInFile = 0	=> ri.Suspicious_Name.DateFirstSeenInFile,
																									 (UNSIGNED)ri.Suspicious_Name.DateFirstSeenInFile = 0	=> le.Suspicious_Name.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_Name.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_Name.DateFirstSeenInFile));
		SELF.Suspicious_Name.InquiryCountHour := le.Suspicious_Name.InquiryCountHour + ri.Suspicious_Name.InquiryCountHour;
		SELF.Suspicious_Name.InquiryCountDay := le.Suspicious_Name.InquiryCountDay + ri.Suspicious_Name.InquiryCountDay;
		SELF.Suspicious_Name.InquiryCountWeek := le.Suspicious_Name.InquiryCountWeek + ri.Suspicious_Name.InquiryCountWeek;
		SELF.Suspicious_Name.InquiryCountMonth := le.Suspicious_Name.InquiryCountMonth + ri.Suspicious_Name.InquiryCountMonth;
		SELF.Suspicious_Name.InquiryCountYear := le.Suspicious_Name.InquiryCountYear + ri.Suspicious_Name.InquiryCountYear;
		SELF.Suspicious_Name.InquiryCount := le.Suspicious_Name.InquiryCount + ri.Suspicious_Name.InquiryCount;
		SELF.RiskCode_Name := le.RiskCode_Name + ri.RiskCode_Name;
		
		SELF := le;
	END;
	
	nameRiskCodesCombined := SORT(inquiryNameRiskCodes, Seq);

	nameRiskCodesTemp := ROLLUP(nameRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combineNameRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanNameRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_Name, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_Name := sortedCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanNameRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_Name;
		SELF.Suspicious_Name.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		SELF.Suspicious_Name.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_Name.DateFirstSeenInFile);
		SELF := le;
	END;
	nameRiskCodes1 := PROJECT(nameRiskCodesTemp, cleanNameRiskCodes1(LEFT));
	nameRiskCodes := PROJECT(NOFOLD(nameRiskCodes1), cleanNameRiskCodes2(LEFT));

	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(inquiryBucketed, NAMED('inquiryNameBucketed'));
	// OUTPUT(inquiriesCounted, NAMED('inquiriesNameCounted'));
	// OUTPUT(inquiryNameRiskCodes, NAMED('inquiryNameRiskCodes'));
	// OUTPUT(nameRiskCodesCombined, NAMED('nameRiskCodesCombined'));
	// OUTPUT(nameRiskCodesTemp, NAMED('nameRiskCodesTemp'));
	// OUTPUT(nameRiskCodes, NAMED('nameRiskCodes'));

	/* ******** END DEBUGGING SECTION **********/
	RETURN (nameRiskCodes);
END;