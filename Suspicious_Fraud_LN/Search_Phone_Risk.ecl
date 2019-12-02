IMPORT dx_header, AutoKey, Data_Services, PhonesPlus_V2, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT, Doxie, Suppress, STD;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_Phone_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																				DATASET(Suspicious_Fraud_LN.layouts.Layout_Phone_Inquiries) Inquiries,
																																				UNSIGNED1 DPPAPurpose,
																																				UNSIGNED1 GLBPurpose,
																																				STRING50 DataRestrictionMask,
																																				doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	// Phone Indexed Keys Used
	PhonesPlusAutoKey := AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_');
	PhonesPlusKey := Phonesplus_v2.key_phonesplus_fdid;
	RiskTableKey := Risk_Indicators.Key_Phone_Table_V2;
	
	headerBuild := CHOOSEN(dx_header.key_max_dt_last_seen(), 1);
	headerBuildDate := (((STRING)headerBuild[1].Max_Date_Last_Seen)[1..6]) + '01';
	
	// Get the Fake DID - used to search the full phones plus payload
	layoutPPTemp := RECORD
		UNSIGNED8 fdid := 0;
		Suspicious_Fraud_LN.layouts.Layout_Batch_Plus;
	END;
	layoutPPTemp getFDID(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, PhonesPlusAutoKey ri) := TRANSFORM
		SELF.fdid := ri.did;
		SELF := le;
	END;
	getPhoneFDID := JOIN(Input, PhonesPlusAutoKey, (INTEGER)LEFT.Clean_Input.Phone10 <> 0 AND KEYED(RIGHT.p7 = LEFT.Clean_Input.Phone10[4..10]) AND KEYED(RIGHT.p3 = LEFT.Clean_Input.Phone10[1..3]),
																		getFDID(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
	// We have all of the Fake DID's associated with the phone, now get the phones plus DID information
	TempPhonesPlusPhone := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Phone10 := '';
		STRING8 DateFirstSeen := '';
		UNSIGNED8 DID := 0;
		UNSIGNED4 UniqueDIDCount := 0;
		UNSIGNED4 UniqueDIDCount2Months := 0;
	END;
	
	{TempPhonesPlusPhone, unsigned4 global_sid} getPhonesPlusDIDs(layoutPPTemp le, PhonesPlusKey ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.Seq := le.Seq;
		SELF.Phone10 := le.Clean_Input.Phone10;
		
		SELF.DateFirstSeen := Suspicious_Fraud_LN.Common.padDate((STRING)ri.DateFirstSeen);
		SELF.DID := ri.DID;
		
		todaysDateTemp := IF((INTEGER)Std.Date.Today() >= le.Clean_Input.ArchiveDate AND le.Clean_Input.ArchiveDate <> 999999, (STRING)le.Clean_Input.ArchiveDate + '01', (STRING8)Std.Date.Today());
		// If todaysDate is greater than the header build date, use the header build date
		todaysDate := IF(todaysDateTemp >= headerBuildDate, headerBuildDate, todaysDateTemp);
		
		dateLastAge := IF((INTEGER)ri.DateFirstSeen = 0, -1, (INTEGER)ut.DaysApart((STRING)ri.DateFirstSeen, todaysDate));
		SELF.UniqueDIDCount := 1; // Will rollup later
		SELF.UniqueDIDCount2Months := IF(dateLastAge BETWEEN 0 AND 61, 1, 0);
	END;
	withPhonesPlus_unsuppressed := JOIN(getPhoneFDID, PhonesPlusKey, LEFT.FDID <> 0 AND KEYED(LEFT.FDID = RIGHT.FDID) AND
																											(UNSIGNED)((STRING)RIGHT.DateFirstSeen)[1..6] <= LEFT.Clean_Input.ArchiveDate AND (INTEGER)RIGHT.DID > 0, // Only grab non-zero DID records before our ArchiveDate
																		getPhonesPlusDIDs(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	withPhonesPlus := Suppress.Suppress_ReturnOldLayout(withPhonesPlus_unsuppressed, mod_access, TempPhonesPlusPhone);
	phonesPlusDeduped := DEDUP(SORT(withPhonesPlus, Seq, DID, -UniqueDIDCount2Months, DateFirstSeen), Seq, DID);
	PhonesPlusCounted := ROLLUP(phonesPlusDeduped, LEFT.Seq = RIGHT.Seq, TRANSFORM(TempPhonesPlusPhone, SELF.DateFirstSeen := MAP((INTEGER)LEFT.DateFirstSeen = 0		=> RIGHT.DateFirstSeen,
																																																											(INTEGER)RIGHT.DateFirstSeen = 0	=> LEFT.DateFirstSeen,
																																																																													(STRING)MIN((INTEGER)LEFT.DateFirstSeen, (INTEGER)RIGHT.DateFirstSeen));
																																														SELF.UniqueDIDCount := LEFT.UniqueDIDCount + RIGHT.UniqueDIDCount;
																																														SELF.UniqueDIDCount2Months := LEFT.UniqueDIDCount2Months + RIGHT.UniqueDIDCount2Months;
																																														SELF := LEFT));
	
	// Get High Risk Indicators from the RiskTableKey
	TempHRIPhone := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Phone10 := '';
		STRING8 DateFirstSeen := '';
		BOOLEAN Pager := FALSE;
		BOOLEAN TransientCommercialIdentity := FALSE;
		BOOLEAN Disconnected := FALSE;
		BOOLEAN PayPhone := FALSE;
	END;
	{TempHRIPhone, unsigned4 global_sid, unsigned6 did} getHRIPhones(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, RiskTableKey ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.did := ri.did;
		SELF.Seq := le.Seq;
		SELF.Phone10 := le.Clean_Input.Phone10;
		SELF.DateFirstSeen := IF((UNSIGNED)ri.dt_first_seen <> 0, Suspicious_Fraud_LN.Common.padDate((STRING)ri.dt_first_seen), '');
		// These three taken from Doxie.Mac_AddHRIPhone
		SELF.Pager := ri.nxx_type IN ['02','52','56','61'];
		SELF.TransientCommercialIdentity := ri.sic_code <> '';
		SELF.Disconnected := ri.potDisconnect = TRUE;
		// Taken from Risk_Indicators.PRIIPhoneRiskFlag
		SELF.PayPhone := ri.nxx_type = '16' OR REGEXFIND('PAYPHONE|PAY PHONE', ri.LName); // OR le.Clean_Input.Phone10[7] = '9';
	END;
	withHRI_unsuppressed := JOIN(Input, RiskTableKey, (INTEGER)LEFT.Clean_Input.Phone10 <> 0 AND KEYED(LEFT.Clean_Input.Phone10 = RIGHT.Phone10) AND
																				(UNSIGNED)((STRING)RIGHT.dt_first_seen)[1..6] <= LEFT.Clean_Input.ArchiveDate, // Make sure this phone is prior to the archive date
																			getHRIPhones(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
	withHRI := Suppress.Suppress_ReturnOldLayout(withHRI_unsuppressed, mod_access, TempHRIPhone);
	rolledHRI := ROLLUP(withHRI, LEFT.Seq = RIGHT.Seq, TRANSFORM(TempHRIPhone,
														SELF.DateFirstSeen := MAP((UNSIGNED)LEFT.DateFirstSeen = 0	=> RIGHT.DateFirstSeen,
																											(UNSIGNED)RIGHT.DateFirstSeen = 0	=> LEFT.DateFirstSeen,
																																													 (STRING)MIN((UNSIGNED)LEFT.DateFirstSeen, (UNSIGNED)RIGHT.DateFirstSeen));
														SELF.Pager := LEFT.Pager OR RIGHT.Pager;
														SELF.TransientCommercialIdentity := LEFT.TransientCommercialIdentity OR RIGHT.TransientCommercialIdentity;
														SELF.Disconnected := LEFT.Disconnected AND RIGHT.Disconnected; // In order to be disconnected, we need all records to say disconnected, otherwise it was just temporarily disconnected
														SELF.PayPhone := LEFT.PayPhone OR RIGHT.PayPhone;
														SELF := LEFT));
														
	// Get all inquiries record information
	TempInquiryPhone := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Phone10 := '';
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
	TempInquiryPhone getInquiries(Suspicious_Fraud_LN.layouts.Layout_Phone_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.Phone10 := le.Phone10;
		
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
	
	TempInquiryPhone countInquiries(TempInquiryPhone le, TempInquiryPhone ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.Phone10 := le.Phone10;
		
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
	inquiriesCounted := ROLLUP(SORT(inquiryBucketed, Seq, Phone10), LEFT.Seq = RIGHT.Seq, countInquiries(LEFT, RIGHT));
	
Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquiryPhoneRiskCodes(TempInquiryPhone le) := TRANSFORM
		RiskCodesLNRSnSFTemp										:= IF(le.InquiryCountLNRSnSFYear >= 30, Suspicious_Fraud_LN.Common.genRiskCode('P03')) + 
																							 IF(le.InquiryCountLNRSnSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('P04')) +
																							 IF(le.InquiryCountLNRSnSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('P05')) +
																							 IF(le.InquiryCountLNRSnSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('P06'));
		RiskCodesLNRSnSF												:= RiskCodesLNRSnSFTemp (TRIM(SuspiciousRiskCode) <> '');
		RiskCodesSFTemp													:= IF(le.InquiryCountSFYear >= 7, Suspicious_Fraud_LN.Common.genRiskCode('P10')) +
																							 IF(le.InquiryCountSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('P11')) +
																							 IF(le.InquiryCountSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('P12')) +
																							 IF(le.InquiryCountSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('P13')) +
																							 IF(le.InquiryCountSFHour >= 1, Suspicious_Fraud_LN.Common.genRiskCode('P14'));
		RiskCodesSF																:= RiskCodesSFTemp (TRIM(SuspiciousRiskCode) <> '');
		RiskCodes																	:= RiskCodesLNRSnSF + RiskCodesSF;
		LNRSnSFHit																:= ut.Exists2(RiskCodesLNRSnSF);
		SFHit																			:= ut.Exists2(RiskCodesSF);
		PhoneHit 																	:= LNRSnSFHit OR SFHit;
		SELF.Suspicious_Phone.Data_Source					:= IF(PhoneHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Phone.DateFirstSeenInFile	:= MAP(LNRSnSFHit = TRUE	=> le.DateFirstSeenLNRSnSF,
																										SFHit = TRUE				=> le.DateFirstSeenSF,
																																				 '');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_Phone.InquiryCountHour		:= le.InquiryCountSFHour;
		SELF.Suspicious_Phone.InquiryCountDay			:= le.InquiryCountSFDay;
		SELF.Suspicious_Phone.InquiryCountWeek		:= le.InquiryCountSFWeek;
		SELF.Suspicious_Phone.InquiryCountMonth		:= le.InquiryCountSFMonth;
		SELF.Suspicious_Phone.InquiryCountYear		:= le.InquiryCountSFYear;
		SELF.Suspicious_Phone.InquiryCount				:= le.InquiryCountSF;
		SELF.RiskCode_Phone												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.Phone10								:= le.Phone10;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	inquiryPhoneRiskCodes := PROJECT(inquiriesCounted, getInquiryPhoneRiskCodes(LEFT)) (ut.Exists2(RiskCode_Phone));

	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getHRIPhoneRiskCodes(TempHRIPhone le) := TRANSFORM
		RiskCodes																:= IF(le.Pager = TRUE, Suspicious_Fraud_LN.Common.genRiskCode('P01')) + 
																							 IF(le.TransientCommercialIdentity = TRUE, Suspicious_Fraud_LN.Common.genRiskCode('P02')) +
																							 IF(le.Disconnected = TRUE, Suspicious_Fraud_LN.Common.genRiskCode('P07')) +
																							 IF(le.PayPhone = TRUE, Suspicious_Fraud_LN.Common.genRiskCode('P08'));
		PhoneHit 																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Phone.Data_Source					:= IF(PhoneHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Phone.DateFirstSeenInFile	:= IF(PhoneHit = TRUE, le.DateFirstSeen, '');
		
		SELF.RiskCode_Phone												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.Phone10								:= le.Phone10;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	hriPhoneRiskCodes := PROJECT(rolledHRI, getHRIPhoneRiskCodes(LEFT)) (ut.Exists2(RiskCode_Phone));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getIdentityPhoneRiskCodes(TempPhonesPlusPhone le) := TRANSFORM
		RiskCodes																:= IF(le.UniqueDIDCount2Months >= 5, Suspicious_Fraud_LN.Common.genRiskCode('P09'));
		PhoneHit 																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Phone.Data_Source					:= IF(PhoneHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Phone.DateFirstSeenInFile	:= IF(PhoneHit = TRUE, le.DateFirstSeen, '');
		
		SELF.RiskCode_Phone												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.Phone10								:= le.Phone10;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	identityPhoneRiskCodes := PROJECT(PhonesPlusCounted, getIdentityPhoneRiskCodes(LEFT)) (ut.Exists2(RiskCode_Phone));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combinePhoneRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_Phone.Data_Source := IF(le.Suspicious_Phone.Data_Source <> '', le.Suspicious_Phone.Data_Source, ri.Suspicious_Phone.Data_Source);
		SELF.Suspicious_Phone.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_Phone.DateFirstSeenInFile = 0	=> ri.Suspicious_Phone.DateFirstSeenInFile,
																									 (UNSIGNED)ri.Suspicious_Phone.DateFirstSeenInFile = 0	=> le.Suspicious_Phone.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_Phone.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_Phone.DateFirstSeenInFile));
		SELF.Suspicious_Phone.InquiryCountHour := le.Suspicious_Phone.InquiryCountHour + ri.Suspicious_Phone.InquiryCountHour;
		SELF.Suspicious_Phone.InquiryCountDay := le.Suspicious_Phone.InquiryCountDay + ri.Suspicious_Phone.InquiryCountDay;
		SELF.Suspicious_Phone.InquiryCountWeek := le.Suspicious_Phone.InquiryCountWeek + ri.Suspicious_Phone.InquiryCountWeek;
		SELF.Suspicious_Phone.InquiryCountMonth := le.Suspicious_Phone.InquiryCountMonth + ri.Suspicious_Phone.InquiryCountMonth;
		SELF.Suspicious_Phone.InquiryCountYear := le.Suspicious_Phone.InquiryCountYear + ri.Suspicious_Phone.InquiryCountYear;
		SELF.Suspicious_Phone.InquiryCount := le.Suspicious_Phone.InquiryCount + ri.Suspicious_Phone.InquiryCount;
		SELF.RiskCode_Phone := le.RiskCode_Phone + ri.RiskCode_Phone;
		
		SELF := le;
	END;
	
	PhoneRiskCodesCombined := SORT(inquiryPhoneRiskCodes + hriPhoneRiskCodes + identityPhoneRiskCodes, Seq);

	PhoneRiskCodesTemp := ROLLUP(PhoneRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combinePhoneRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanPhoneRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_Phone, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_Phone := sortedCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanPhoneRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_Phone;
		SELF.Suspicious_Phone.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		SELF.Suspicious_Phone.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_Phone.DateFirstSeenInFile);
		SELF := le;
	END;
	PhoneRiskCodes1 := PROJECT(PhoneRiskCodesTemp, cleanPhoneRiskCodes1(LEFT));
	PhoneRiskCodes := PROJECT(NOFOLD(PhoneRiskCodes1), cleanPhoneRiskCodes2(LEFT));
	
	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(withHRI, NAMED('withHRIPhone'));
	// OUTPUT(rolledHRI, NAMED('rolledHRIPhone'));
	// OUTPUT(getPhoneFDID, NAMED('getPhoneFDID'));
	// OUTPUT(withPhonesPlus, NAMED('withPhonesPlus'));
	// OUTPUT(phonesPlusDeduped, NAMED('phonesPlusDeduped'));
	// OUTPUT(PhonesPlusCounted, NAMED('PhonesPlusCounted'));
	// OUTPUT(inquiryBucketed, NAMED('inquiryPhoneBucketed'));
	// OUTPUT(inquiriesCounted, NAMED('inquiriesPhoneCounted'));
	// OUTPUT(inquiryPhoneRiskCodes, NAMED('inquiryPhoneRiskCodes'));
	// OUTPUT(hriPhoneRiskCodes, NAMED('hriPhoneRiskCodes'));
	// OUTPUT(PhoneRiskCodesCombined, NAMED('PhoneRiskCodesCombined'));
	// OUTPUT(PhoneRiskCodesTemp, NAMED('PhoneRiskCodesTemp'));
	// OUTPUT(PhoneRiskCodes, NAMED('PhoneRiskCodes'));
	/* ******** END DEBUGGING SECTION **********/
	
	RETURN (PhoneRiskCodes);
END;
