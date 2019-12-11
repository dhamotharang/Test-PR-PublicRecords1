IMPORT Email_Data, MDR, RiskWise, Suspicious_Fraud_LN, UT, dx_header, Doxie, Suppress, STD;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_Email_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																				DATASET(Suspicious_Fraud_LN.layouts.Layout_Email_Inquiries) Inquiries,
																																				UNSIGNED1 DPPAPurpose,
																																				UNSIGNED1 GLBPurpose,
																																				STRING50 DataRestrictionMask,
																																				doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	// Email Indexed Keys Used
	EmailKey := Email_Data.Key_Email_Address;
	
	// For E-Mail data, don't use any Royalty Sources
	RoyaltyEmailSources := [MDR.SourceTools.src_Acquiredweb, MDR.SourceTools.src_Entiera, MDR.SourceTools.src_MediaOne, MDR.SourceTools.src_OutwardMedia];

	headerBuild := CHOOSEN(dx_header.key_max_dt_last_seen(), 1);
	headerBuildDate := (((STRING)headerBuild[1].Max_Date_Last_Seen)[1..6]) + '01';

	TempIdentityEmail := RECORD
		UNSIGNED8 Seq 											:= 0;
		STRING100 Email 										:= '';
		UNSIGNED4 ArchiveDate 							:= 0;
		STRING8 TodaysDate									:= '';
		STRING8 DateFirstSeen								:= '';
		STRING8 DateLastSeen								:= ''; // Only count unique DID's with a last seen date <= 2 months
		INTEGER DaysLastSeen								:= -1; // Number of days between TodaysDate and DateLastSeen fields
		UNSIGNED8 DID												:= 0;
		UNSIGNED3 UniqueDIDCount						:= 0; // All unique DID's counted for that Email
		UNSIGNED3 UniqueDIDCount2Months			:= 0; // Only count unique DID's with a last seen date <= 2 months
	END;
	
	{TempIdentityEmail, unsigned4 global_sid} getEmailIdentities(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, EmailKey ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.Seq := le.Seq;
		SELF.Email := le.Clean_Input.Email;
		SELF.DID := ri.DID;
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		
		todaysDateTemp := IF((INTEGER)(STRING8)Std.Date.Today() >= le.Clean_Input.ArchiveDate AND le.Clean_Input.ArchiveDate <> 999999, (STRING)le.Clean_Input.ArchiveDate + '01', (STRING8)Std.Date.Today());
		// If todaysDate is greater than the header build date, use the header build date
		todaysDate := IF(todaysDateTemp >= headerBuildDate, headerBuildDate, todaysDateTemp);
		
		dt_lastTemp := MAP((INTEGER)ri.date_last_seen <> 0							=> (INTEGER)Suspicious_Fraud_LN.Common.padDate(ri.date_last_seen),
											 (INTEGER)ri.date_vendor_last_reported <> 0		=> (INTEGER)Suspicious_Fraud_LN.Common.padDate(ri.date_vendor_last_reported),
											 (INTEGER)ri.date_first_seen <> 0							=> (INTEGER)Suspicious_Fraud_LN.Common.padDate(ri.date_first_seen),
											 (INTEGER)ri.date_vendor_first_reported <> 0	=> (INTEGER)Suspicious_Fraud_LN.Common.padDate(ri.date_vendor_first_reported),
																																				0);
		dt_last := IF(dt_lastTemp >= (INTEGER)todaysDate, (INTEGER)todaysDate, dt_lastTemp);
		
		dt_firstTemp := MAP((INTEGER)ri.date_first_seen <> 0							=> (INTEGER)Suspicious_Fraud_LN.Common.padDate(ri.date_first_seen),
												(INTEGER)ri.date_vendor_first_reported <> 0		=> (INTEGER)Suspicious_Fraud_LN.Common.padDate(ri.date_vendor_first_reported),
																																				0);
		dt_first := IF(dt_firstTemp >= (INTEGER)todaysDate, (INTEGER)todaysDate, dt_firstTemp);
																							
		// If the Archive Date was before the last header build date, use the Archive Date as todays date
		SELF.TodaysDate := todaysDate;
		dateLastAge := IF(dt_last = 0, -1, (INTEGER)ut.DaysApart((STRING)dt_last, todaysDate));
		SELF.DateFirstSeen := (STRING8)dt_first;
		SELF.DateLastSeen := (STRING8)dt_last;
		SELF.DaysLastSeen := IF((UNSIGNED)todaysDate < dt_last OR dt_last = 0, -1, dateLastAge);
		
		SELF.UniqueDIDCount := 1; // Will rollup later
		SELF.UniqueDIDCount2Months := IF(dateLastAge BETWEEN 0 AND 61, 1, 0);
		
		SELF := le;
	END;
	
	emailIdentities_unsuppressed := JOIN(Input, EmailKey, LEFT.Clean_Input.Email <> '' AND KEYED(LEFT.Clean_Input.Email = RIGHT.Clean_Email) AND
																					RIGHT.email_src NOT IN RoyaltyEmailSources AND RIGHT.DID <> 0 AND
																					(((INTEGER)RIGHT.date_first_seen <> 0 AND (INTEGER)RIGHT.date_first_seen[1..6] <= LEFT.Clean_Input.ArchiveDate) OR
																					 ((INTEGER)RIGHT.date_first_seen = 0 AND (INTEGER)RIGHT.date_vendor_first_reported <> 0 AND (INTEGER)RIGHT.date_vendor_first_reported[1..6] <= LEFT.Clean_Input.ArchiveDate)),
																getEmailIdentities(LEFT, RIGHT), ATMOST(RiskWise.max_atmost));
																
	emailIdentities := Suppress.Suppress_ReturnOldLayout(emailIdentities_unsuppressed, mod_access, TempIdentityEmail);
	
	emailIdentitiesDeduped := DEDUP(SORT(emailIdentities, Seq, DID, -UniqueDIDCount2Months, DateFirstSeen), Seq, DID);
	emailIdentitiesCounted := ROLLUP(emailIdentitiesDeduped, LEFT.Seq = RIGHT.Seq, TRANSFORM(TempIdentityEmail, SELF.DateFirstSeen := MAP((INTEGER)LEFT.DateFirstSeen = 0	=> RIGHT.DateFirstSeen,
																																																																 (INTEGER)RIGHT.DateFirstSeen = 0 => LEFT.DateFirstSeen,
																																																																																		 (STRING)MIN((INTEGER)LEFT.DateFirstSeen, (INTEGER)RIGHT.DateFirstSeen));
																																																			 SELF.UniqueDIDCount := LEFT.UniqueDIDCount + RIGHT.UniqueDIDCount;
																																																			 SELF.UniqueDIDCount2Months := LEFT.UniqueDIDCount2Months + RIGHT.UniqueDIDCount2Months;
																																																			 SELF := LEFT));

	// Get all inquiries record information
	TempInquiryEmail := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 Email := '';
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
	TempInquiryEmail getInquiries(Suspicious_Fraud_LN.layouts.Layout_Email_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.Email := le.email_address;
		
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
	
	TempInquiryEmail countInquiries(TempInquiryEmail le, TempInquiryEmail ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.Email := le.Email;
		
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
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getIdentityEmailRiskCodes(TempIdentityEmail le) := TRANSFORM
		RiskCodesTemp																:= IF(le.UniqueDIDCount2Months >= 5, Suspicious_Fraud_LN.Common.genRiskCode('E01'));
		RiskCodes																		:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		EmailHit 																		:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Email.Data_Source						:= IF(EmailHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Email.DateFirstSeenInFile		:= MAP(EmailHit = TRUE	=> le.DateFirstSeen,
																																					'');

		SELF.RiskCode_Email													:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.Email											:= le.Email;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	identityEmailRiskCodes := PROJECT(emailIdentitiesCounted, getIdentityEmailRiskCodes(LEFT)) (ut.Exists2(RiskCode_Email));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquiryEmailRiskCodes(TempInquiryEmail le) := TRANSFORM
		RiskCodesSFTemp															:= IF(le.InquiryCountSFYear >= 7, Suspicious_Fraud_LN.Common.genRiskCode('E02')) +
																									 IF(le.InquiryCountSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('E03')) +
																									 IF(le.InquiryCountSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('E04')) +
																									 IF(le.InquiryCountSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('E05')) +
																									 IF(le.InquiryCountSFHour >= 1, Suspicious_Fraud_LN.Common.genRiskCode('E06'));
		RiskCodes																		:= RiskCodesSFTemp (TRIM(SuspiciousRiskCode) <> '');
		EmailHit 																		:= ut.Exists2(RiskCodes);
		SELF.Suspicious_Email.Data_Source						:= IF(EmailHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_Email.DateFirstSeenInFile		:= MAP(EmailHit = TRUE	=> le.DateFirstSeenSF,
																																					'');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_Email.InquiryCountHour			:= le.InquiryCountSFHour;
		SELF.Suspicious_Email.InquiryCountDay				:= le.InquiryCountSFDay;
		SELF.Suspicious_Email.InquiryCountWeek			:= le.InquiryCountSFWeek;
		SELF.Suspicious_Email.InquiryCountMonth			:= le.InquiryCountSFMonth;
		SELF.Suspicious_Email.InquiryCountYear			:= le.InquiryCountSFYear;
		SELF.Suspicious_Email.InquiryCount					:= le.InquiryCountSF;
		SELF.RiskCode_Email													:= RiskCodes;
		
		SELF.Seq																		:= le.Seq;
		SELF.Clean_Input.Email											:= le.Email;
		
		SELF 																				:= le;
		SELF 																				:= [];
	END;
	inquiryEmailRiskCodes := PROJECT(inquiriesCounted, getInquiryEmailRiskCodes(LEFT)) (ut.Exists2(RiskCode_Email));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combineEmailRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_Email.Data_Source := IF(le.Suspicious_Email.Data_Source <> '', le.Suspicious_Email.Data_Source, ri.Suspicious_Email.Data_Source);
		SELF.Suspicious_Email.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_Email.DateFirstSeenInFile = 0	=> ri.Suspicious_Email.DateFirstSeenInFile,
																									 (UNSIGNED)ri.Suspicious_Email.DateFirstSeenInFile = 0	=> le.Suspicious_Email.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_Email.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_Email.DateFirstSeenInFile));
		SELF.Suspicious_Email.InquiryCountHour := le.Suspicious_Email.InquiryCountHour + ri.Suspicious_Email.InquiryCountHour;
		SELF.Suspicious_Email.InquiryCountDay := le.Suspicious_Email.InquiryCountDay + ri.Suspicious_Email.InquiryCountDay;
		SELF.Suspicious_Email.InquiryCountWeek := le.Suspicious_Email.InquiryCountWeek + ri.Suspicious_Email.InquiryCountWeek;
		SELF.Suspicious_Email.InquiryCountMonth := le.Suspicious_Email.InquiryCountMonth + ri.Suspicious_Email.InquiryCountMonth;
		SELF.Suspicious_Email.InquiryCountYear := le.Suspicious_Email.InquiryCountYear + ri.Suspicious_Email.InquiryCountYear;
		SELF.Suspicious_Email.InquiryCount := le.Suspicious_Email.InquiryCount + ri.Suspicious_Email.InquiryCount;
		SELF.RiskCode_Email := le.RiskCode_Email + ri.RiskCode_Email;
		
		SELF := le;
	END;
	
	EmailRiskCodesCombined := SORT(inquiryEmailRiskCodes + identityEmailRiskCodes, Seq);

	EmailRiskCodesTemp := ROLLUP(EmailRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combineEmailRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanEmailRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_Email, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_Email := sortedCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanEmailRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_Email;
		SELF.Suspicious_Email.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		SELF.Suspicious_Email.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_Email.DateFirstSeenInFile);
		SELF := le;
	END;
	EmailRiskCodes1 := PROJECT(EmailRiskCodesTemp, cleanEmailRiskCodes1(LEFT));
	EmailRiskCodes := PROJECT(NOFOLD(EmailRiskCodes1), cleanEmailRiskCodes2(LEFT));

	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(emailIdentitiesCounted, NAMED('emailIdentitiesCounted'));
	// OUTPUT(inquiryBucketed, NAMED('inquiryEmailBucketed'));
	// OUTPUT(inquiriesCounted, NAMED('inquiriesEmailCounted'));
	// OUTPUT(identityEmailRiskCodes, NAMED('identityEmailRiskCodes'));
	// OUTPUT(inquiryEmailRiskCodes, NAMED('inquiryEmailRiskCodes'));
	// OUTPUT(EmailRiskCodesCombined, NAMED('EmailRiskCodesCombined'));
	// OUTPUT(EmailRiskCodesTemp, NAMED('EmailRiskCodesTemp'));
	// OUTPUT(EmailRiskCodes, NAMED('EmailRiskCodes'));

	/* ******** END DEBUGGING SECTION **********/
	RETURN (EmailRiskCodes);
END;