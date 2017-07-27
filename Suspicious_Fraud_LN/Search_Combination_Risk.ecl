IMPORT Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_Combination_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																							DATASET(Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries) AddressInquiries,
																																							DATASET(Suspicious_Fraud_LN.layouts.Layout_Email_Inquiries) EmailInquiries,
																																							DATASET(Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries) IPAddressInquiries,
																																							DATASET(Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries) NameInquiries,
																																							DATASET(Suspicious_Fraud_LN.layouts.Layout_Phone_Inquiries) PhoneInquiries,
																																							DATASET(Suspicious_Fraud_LN.layouts.Layout_SSN_Inquiries) SSNInquiries,
																																							UNSIGNED1 DPPAPurpose,
																																							UNSIGNED1 GLBPurpose,
																																							STRING50 DataRestrictionMask) := FUNCTION
																																							
	// Count all of the inquiries
	InquiryCountCommon := RECORD
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
	
	TempInquiryAddress := RECORD
		UNSIGNED8 Seq := 0;
		STRING120 StreetAddress1 := '';
		STRING25 City := '';
		STRING2 State := '';
		STRING9 Zip := '';
		STRING5 Zip5 := '';
		STRING4 Zip4 := '';
		STRING10 Prim_Range := '';
		STRING2 Predir := '';
		STRING28 Prim_Name := '';
		STRING4 Addr_Suffix := '';
		STRING2 Postdir := '';
		STRING10 Unit_Desig := '';
		STRING8 Sec_Range := '';
		InquiryCountCommon;
	END;
	TempInquiryAddress getAddressInquiries(Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.Person_Q.Address;
		SELF.City := le.Person_Q.V_City_Name;
		SELF.State := le.Person_Q.State;
		SELF.Zip := TRIM(le.Person_Q.Zip5 + le.Person_Q.Zip4);
		SELF.Zip5 := le.Person_Q.Zip5;
		SELF.Zip4 := le.Person_Q.Zip4;
		SELF.Prim_Range := le.Person_Q.Prim_Range;
		SELF.Predir := le.Person_Q.Predir;
		SELF.Prim_Name := le.Person_Q.Prim_Name;
		SELF.Addr_Suffix := le.Person_Q.Addr_Suffix;
		SELF.Postdir := le.Person_Q.Postdir;
		SELF.Unit_Desig := le.Person_Q.Unit_Desig;
		SELF.Sec_Range := le.Person_Q.Sec_Range;
		
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
	addressInquiryBucketed := PROJECT(AddressInquiries, getAddressInquiries(LEFT));
	
	TempInquiryAddress countAddressInquiries(TempInquiryAddress le, TempInquiryAddress ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.StreetAddress1 := le.StreetAddress1;
		SELF.City := le.City;
		SELF.State := le.State;
		SELF.Zip := le.Zip;
		SELF.Zip5 := le.Zip5;
		SELF.Zip4 := le.Zip4;
		SELF.Prim_Range := le.Prim_Range;
		SELF.Predir := le.Predir;
		SELF.Prim_Name := le.Prim_Name;
		SELF.Addr_Suffix := le.Addr_Suffix;
		SELF.Postdir := le.Postdir;
		SELF.Unit_Desig := le.Unit_Desig;
		SELF.Sec_Range := le.Sec_Range;
		
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
	addressInquiriesCounted := ROLLUP(SORT(addressInquiryBucketed, Seq), LEFT.Seq = RIGHT.Seq, countAddressInquiries(LEFT, RIGHT));
	
	TempInquiryEmail := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 Email := '';
		InquiryCountCommon;
	END;
	TempInquiryEmail getEmailInquiries(Suspicious_Fraud_LN.layouts.Layout_Email_Inquiries le) := TRANSFORM
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
	emailInquiryBucketed := PROJECT(EmailInquiries, getEmailInquiries(LEFT));
	
	TempInquiryEmail countEmailInquiries(TempInquiryEmail le, TempInquiryEmail ri) := TRANSFORM
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
	emailInquiriesCounted := ROLLUP(SORT(emailInquiryBucketed, Seq), LEFT.Seq = RIGHT.Seq, countEmailInquiries(LEFT, RIGHT));
	
	TempInquiryIPAddress := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 IPAddress := '';
		InquiryCountCommon;
	END;
	TempInquiryIPAddress getIPAddressInquiries(Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries le) := TRANSFORM
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
	ipAddressInquiryBucketed := PROJECT(IPAddressInquiries, getIPAddressInquiries(LEFT));
	
	TempInquiryIPAddress countIPAddressInquiries(TempInquiryIPAddress le, TempInquiryIPAddress ri) := TRANSFORM
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
	ipAddressInquiriesCounted := ROLLUP(SORT(ipAddressInquiryBucketed, Seq), LEFT.Seq = RIGHT.Seq, countIPAddressInquiries(LEFT, RIGHT));
	
	TempInquiryName := RECORD
		UNSIGNED8 Seq := 0;
		STRING20 FirstName := '';
		STRING20 MiddleName := '';
		STRING1 MiddleInitial := '';
		STRING20 LastName := '';
		InquiryCountCommon;
	END;
	TempInquiryName getNameInquiries(Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries le) := TRANSFORM
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
	nameInquiryBucketed := PROJECT(NameInquiries, getNameInquiries(LEFT));
	
	TempInquiryName countNameInquiries(TempInquiryName le, TempInquiryName ri) := TRANSFORM
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
	nameInquiriesCounted := ROLLUP(SORT(nameInquiryBucketed, Seq), LEFT.Seq = RIGHT.Seq, countNameInquiries(LEFT, RIGHT));
	
	TempInquiryPhone := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Phone10 := '';
		InquiryCountCommon;
	END;
	TempInquiryPhone getPhoneInquiries(Suspicious_Fraud_LN.layouts.Layout_Phone_Inquiries le) := TRANSFORM
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
	phoneInquiryBucketed := PROJECT(PhoneInquiries, getPhoneInquiries(LEFT));
	
	TempInquiryPhone countPhoneInquiries(TempInquiryPhone le, TempInquiryPhone ri) := TRANSFORM
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
	phoneInquiriesCounted := ROLLUP(SORT(phoneInquiryBucketed, Seq, Phone10), LEFT.Seq = RIGHT.Seq, countPhoneInquiries(LEFT, RIGHT));
	
	TempInquirySSN := RECORD
		UNSIGNED8 Seq := 0;
		STRING9 SSN := '';
		InquiryCountCommon;
	END;
	TempInquirySSN getSSNInquiries(Suspicious_Fraud_LN.layouts.Layout_SSN_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.SSN;
		
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
	ssnInquiryBucketed := PROJECT(SSNInquiries, getSSNInquiries(LEFT));
	
	TempInquirySSN countSSNInquiries(TempInquirySSN le, TempInquirySSN ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.SSN;
		
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
	ssnInquiriesCounted := ROLLUP(SORT(ssnInquiryBucketed, Seq, SSN), LEFT.Seq = RIGHT.Seq, countSSNInquiries(LEFT, RIGHT));
	
	// Now that all of the inquiries have been counted, we need to combine everything and generate risk codes
	InquiriesCombined := RECORD
		UNSIGNED8 Seq := 0;
		InquiryCountCommon Address;
		InquiryCountCommon Email;
		InquiryCountCommon IPAddress;
		InquiryCountCommon Name;
		InquiryCountCommon Phone;
		InquiryCountCommon SSN;
	END;
	
	withAddress := JOIN(Input, addressInquiriesCounted, LEFT.Seq = RIGHT.Seq, TRANSFORM(InquiriesCombined, SELF.Seq := LEFT.Seq; SELF.Address := RIGHT; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withEmail := JOIN(withAddress, emailInquiriesCounted, LEFT.Seq = RIGHT.Seq, TRANSFORM(InquiriesCombined, SELF.Email := RIGHT; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withIPAddress := JOIN(withEmail, ipAddressInquiriesCounted, LEFT.Seq = RIGHT.Seq, TRANSFORM(InquiriesCombined, SELF.IPAddress := RIGHT; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withName := JOIN(withIPAddress, nameInquiriesCounted, LEFT.Seq = RIGHT.Seq, TRANSFORM(InquiriesCombined, SELF.Name := RIGHT; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withPhone := JOIN(withName, phoneInquiriesCounted, LEFT.Seq = RIGHT.Seq, TRANSFORM(InquiriesCombined, SELF.Phone := RIGHT; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withSSN := JOIN(withPhone, ssnInquiriesCounted, LEFT.Seq = RIGHT.Seq, TRANSFORM(InquiriesCombined, SELF.SSN := RIGHT; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	allInquiries := SORT(withSSN, Seq);
	
	// We need to be able to determine what sources were used in creating the reason codes so that we can appropriately take the MIN of the first seen dates for those sources
	AddressRCs := [
	'C01','C02','C03','C04','C05','C06','C07','C08','C09','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20',
	'C21','C22','C23','C24','C25','C26','C27','C28','C29','C30','C31','C32','C33','C34','C35','C56','C57','C58','C59','C60',
	'C61','C62','C63','C64','C65','C66','C67','C68','C69','C70','C71','C72','C73','C74','C75','C76','C77','C78','C79','C80',
	'C81','C82','C83','C84','C85','C86','C87','C88','C89','C90','C91','C92','C93','C94','C95','C131','C132','C133','C134',
	'C135','C156','C157','C158','C159','C160','C161','C162','C163','C164','C165','C166','C167','C168','C169','C170','C171',
	'C172','C173','C174','C175','C176','C177','C178','C179','C180','C181','C182','C183','C184','C185','C186','C187','C188',
	'C189','C190','C211','C212','C213','C214','C215','C216','C217','C218','C219','C220','C221','C222','C223','C224','C225',
	'C226','C227','C228','C229','C230','C231','C232','C233','C234','C235','C236','C237','C238','C239','C240','C241','C242',
	'C243','C244','C245','C246','C247','C248','C249','C250'
	];

	EmailRCs := [
	'C01','C02','C03','C04','C05','C11','C12','C13','C14','C15','C21','C22','C23','C24','C25','C31','C32','C33','C34','C35',
	'C36','C37','C38','C39','C40','C41','C42','C43','C44','C45','C51','C52','C53','C54','C55','C61','C62','C63','C64','C65',
	'C71','C72','C73','C74','C75','C81','C82','C83','C84','C85','C91','C92','C93','C94','C95','C96','C97','C98','C99','C100',
	'C106','C107','C108','C109','C110','C116','C117','C118','C119','C120','C126','C127','C128','C129','C130','C136','C137',
	'C138','C139','C140','C156','C157','C158','C159','C160','C166','C167','C168','C169','C170','C176','C177','C178','C179',
	'C180','C186','C187','C188','C189','C190','C191','C192','C193','C194','C195','C196','C197','C198','C199','C200','C206',
	'C207','C208','C209','C210','C216','C217','C218','C219','C220','C226','C227','C228','C229','C230','C236','C237','C238',
	'C239','C240','C246','C247','C248','C249','C250','C251','C252','C253','C254','C255','C261','C262','C263','C264','C265',
	'C271','C272','C273','C274','C275','C281','C282','C283','C284','C285'
	];

	IPAddressRCs := [
	'C06','C07','C08','C09','C10','C11','C12','C13','C14','C15','C26','C27','C28','C29','C30','C31','C32','C33','C34','C35',
	'C36','C37','C38','C39','C40','C46','C47','C48','C49','C50','C51','C52','C53','C54','C55','C66','C67','C68','C69','C70',
	'C71','C72','C73','C74','C75','C86','C87','C88','C89','C90','C91','C92','C93','C94','C95','C101','C102','C103','C104',
	'C105','C106','C107','C108','C109','C110','C121','C122','C123','C124','C125','C126','C127','C128','C129','C130','C141',
	'C142','C143','C144','C145','C161','C162','C163','C164','C165','C166','C167','C168','C169','C170','C181','C182','C183',
	'C184','C185','C186','C187','C188','C189','C190','C191','C192','C193','C194','C195','C201','C202','C203','C204','C205',
	'C206','C207','C208','C209','C210','C221','C222','C223','C224','C225','C226','C227','C228','C229','C230','C241','C242',
	'C243','C244','C245','C246','C247','C248','C249','C250','C256','C257','C258','C259','C260','C261','C262','C263','C264',
	'C265','C276','C277','C278','C279','C280','C281','C282','C283','C284','C285'
	];

	NameRCs := [
	'C16','C17','C18','C19','C20','C21','C22','C23','C24','C25','C26','C27','C28','C29','C30','C31','C32','C33','C34','C35',
	'C41','C42','C43','C44','C45','C46','C47','C48','C49','C50','C51','C52','C53','C54','C55','C76','C77','C78','C79','C80',
	'C81','C82','C83','C84','C85','C86','C87','C88','C89','C90','C91','C92','C93','C94','C95','C111','C112','C113','C114',
	'C115','C116','C117','C118','C119','C120','C121','C122','C123','C124','C125','C126','C127','C128','C129','C130','C146',
	'C147','C148','C149','C150','C171','C172','C173','C174','C175','C176','C177','C178','C179','C180','C181','C182','C183',
	'C184','C185','C186','C187','C188','C189','C190','C196','C197','C198','C199','C200','C201','C202','C203','C204','C205',
	'C206','C207','C208','C209','C210','C231','C232','C233','C234','C235','C236','C237','C238','C239','C240','C241','C242',
	'C243','C244','C245','C246','C247','C248','C249','C250','C266','C267','C268','C269','C270','C271','C272','C273','C274',
	'C275','C276','C277','C278','C279','C280','C281','C282','C283','C284','C285'
	];

	PhoneRCs := [
	'C56','C57','C58','C59','C60','C61','C62','C63','C64','C65','C66','C67','C68','C69','C70','C71','C72','C73','C74','C75',
	'C76','C77','C78','C79','C80','C81','C82','C83','C84','C85','C86','C87','C88','C89','C90','C91','C92','C93','C94','C95',
	'C96','C97','C98','C99','C100','C101','C102','C103','C104','C105','C106','C107','C108','C109','C110','C111','C112',
	'C113','C114','C115','C116','C117','C118','C119','C120','C121','C122','C123','C124','C125','C126','C127','C128','C129',
	'C130','C151','C152','C153','C154','C155','C211','C212','C213','C214','C215','C216','C217','C218','C219','C220','C221',
	'C222','C223','C224','C225','C226','C227','C228','C229','C230','C231','C232','C233','C234','C235','C236','C237','C238',
	'C239','C240','C241','C242','C243','C244','C245','C246','C247','C248','C249','C250','C251','C252','C253','C254','C255',
	'C256','C257','C258','C259','C260','C261','C262','C263','C264','C265','C266','C267','C268','C269','C270','C271','C272',
	'C273','C274','C275','C276','C277','C278','C279','C280','C281','C282','C283','C284','C285','C286','C287','C288','C289',
	'C290'
	];

	SSNRCs := [
	'C131','C132','C133','C134','C135','C136','C137','C138','C139','C140','C141','C142','C143','C144','C145','C146','C147',
	'C148','C149','C150','C151','C152','C153','C154','C155','C156','C157','C158','C159','C160','C161','C162','C163','C164',
	'C165','C166','C167','C168','C169','C170','C171','C172','C173','C174','C175','C176','C177','C178','C179','C180','C181',
	'C182','C183','C184','C185','C186','C187','C188','C189','C190','C191','C192','C193','C194','C195','C196','C197','C198',
	'C199','C200','C201','C202','C203','C204','C205','C206','C207','C208','C209','C210','C211','C212','C213','C214','C215',
	'C216','C217','C218','C219','C220','C221','C222','C223','C224','C225','C226','C227','C228','C229','C230','C231','C232',
	'C233','C234','C235','C236','C237','C238','C239','C240','C241','C242','C243','C244','C245','C246','C247','C248','C249',
	'C250','C251','C252','C253','C254','C255','C256','C257','C258','C259','C260','C261','C262','C263','C264','C265','C266',
	'C267','C268','C269','C270','C271','C272','C273','C274','C275','C276','C277','C278','C279','C280','C281','C282','C283',
	'C284','C285','C286','C287','C288','C289','C290'
	];
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquiryComboRiskCodes(InquiriesCombined le) := TRANSFORM
		YearLimit := 7;
		MonthLimit := 5;
		WeekLimit := 3;
		DayLimit := 1;
		HourLimit := 1;
		
		RiskCodesTemp																		:= 
			// Address + Email
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C01')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C02')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C03')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C04')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C05')) +
			// Address + IPAddress
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C06')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C07')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C08')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C09')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C10')) +
			// Address + Email + IPAddress
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C11')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C12')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C13')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C14')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C15')) +
			// Address + Name
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C16')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C17')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C18')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C19')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C20')) +
			// Address + Name + Email
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C21')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C22')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C23')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C24')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C25')) +
			// Address + Name + IPAddress
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C26')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C27')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C28')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C29')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C30')) +
			// Address + Name + IPAddress + Email
			IF(le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C31')) +
			IF(le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C32')) +
			IF(le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C33')) +
			IF(le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C34')) +
			IF(le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C35')) +
			// IPAddress + Email
			IF(le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C36')) +
			IF(le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C37')) +
			IF(le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C38')) +
			IF(le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C39')) +
			IF(le.IPAddress.InquiryCountSFHour >= HourLimit	AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C40')) +
			// Name + Email
			IF(le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C41')) +
			IF(le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C42')) +
			IF(le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C43')) +
			IF(le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C44')) +
			IF(le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C45')) +
			// Name + IPAddress
			IF(le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C46')) +
			IF(le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C47')) +
			IF(le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C48')) +
			IF(le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C49')) +
			IF(le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C50')) +
			// Name + IPAddress + Email
			IF(le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C51')) +
			IF(le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C52')) +
			IF(le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C53')) +
			IF(le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C54')) +
			IF(le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C55')) +
			// Phone + Address
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C56')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C57')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C58')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C59')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C60')) +
			// Phone + Address + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C61')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C62')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C63')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C64')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C65')) +
			// Phone + Address + IPAddress
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C66')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C67')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C68')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C69')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C70')) +
			// Phone + Address + IPAddress + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C71')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C72')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C73')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C74')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C75')) +
			// Phone + Address + Name
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C76')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C77')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C78')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C79')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C80')) +
			// Phone + Address + Name + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C81')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C82')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C83')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C84')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C85')) +
			// Phone + Address + Name + IPAddress
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C86')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C87')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C88')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C89')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C90')) +
			// Phone + Address + Name + IPAddress + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C91')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C92')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C93')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C94')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C95')) +
			// Phone + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C96')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C97')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C98')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C99')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C100')) +
			// Phone + IPAddress
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C101')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C102')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C103')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C104')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C105')) +
			// Phone + IPAddress + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C106')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C107')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C108')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C109')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C110')) +
			// Phone + Name
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C111')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C112')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C113')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C114')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C115')) +
			// Phone + Name + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C116')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C117')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C118')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C119')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C120')) +
			// Phone + Name + IPAddress
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C121')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C122')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C123')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C124')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C125')) +
			// Phone + Name + IPAddress + Email
			IF(le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C126')) +
			IF(le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C127')) +
			IF(le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C128')) +
			IF(le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C129')) +
			IF(le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C130')) +
			// SSN + Address
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C131')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C132')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C133')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C134')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C135')) +
			// SSN + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C136')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C137')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C138')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C139')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C140')) +
			// SSN + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C141')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C142')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C143')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C144')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C145')) +
			// SSN + Name
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C146')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C147')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C148')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C149')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C150')) +
			// SSN + Phone
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C151')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C152')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C153')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C154')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C155')) +
			// SSN + Address + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C156')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C157')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C158')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C159')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C160')) +
			// SSN + Address + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C161')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C162')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C163')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C164')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C165')) +
			// SSN + Address + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C166')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C167')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C168')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C169')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C170')) +
			// SSN + Address + Name
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C171')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C172')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C173')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C174')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C175')) +
			// SSN + Address + Name + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C176')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C177')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C178')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C179')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C180')) +
			// SSN + Address + Name + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C181')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C182')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C183')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C184')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C185')) +
			// SSN + Address + Name + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C186')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C187')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C188')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C189')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C190')) +
			// SSN + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C191')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C192')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C193')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C194')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C195')) +
			// SSN + Name + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C196')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C197')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C198')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C199')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C200')) +
			// SSN + Name + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C201')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C202')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C203')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C204')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C205')) +
			// SSN + Name + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C206')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C207')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C208')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C209')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C210')) +
			// SSN + Phone + Address
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C211')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C212')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C213')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C214')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C215')) +
			// SSN + Phone + Address + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C216')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C217')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C218')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C219')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C220')) +
			// SSN + Phone + Address + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C221')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C222')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C223')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C224')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C225')) +
			// SSN + Phone + Address + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C226')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C227')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C228')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C229')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C230')) +
			// SSN + Phone + Address + Name
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C231')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C232')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C233')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C234')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C235')) +
			// SSN + Phone + Address + Name + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C236')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C237')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C238')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C239')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C240')) +
			// SSN + Phone + Address + Name + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C241')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C242')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C243')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C244')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C245')) +
			// SSN + Phone + Address + Name + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Address.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C246')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Address.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C247')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Address.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C248')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Address.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C249')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Address.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C250')) +
			// SSN + Phone + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C251')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C252')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C253')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C254')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C255')) +
			// SSN + Phone + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C256')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C257')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C258')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C259')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C260')) +
			// SSN + Phone + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C261')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C262')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C263')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C264')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C265')) +
			// SSN + Phone + Name
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C266')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C267')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C268')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C269')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C270')) +
			// SSN + Phone + Name + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C271')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C272')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C273')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C274')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C275')) +
			// SSN + Phone + Name + IPAddress
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C276')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C277')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C278')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C279')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C280')) +
			// SSN + Phone + Name + IPAddress + Email
			IF(le.SSN.InquiryCountSFYear >= YearLimit AND le.Phone.InquiryCountSFYear >= YearLimit AND le.Name.InquiryCountSFYear >= YearLimit AND le.IPAddress.InquiryCountSFYear >= YearLimit AND le.Email.InquiryCountSFYear >= YearLimit, Suspicious_Fraud_LN.Common.genRiskCode('C281')) +
			IF(le.SSN.InquiryCountSFMonth >= MonthLimit AND le.Phone.InquiryCountSFMonth >= MonthLimit AND le.Name.InquiryCountSFMonth >= MonthLimit AND le.IPAddress.InquiryCountSFMonth >= MonthLimit AND le.Email.InquiryCountSFMonth >= MonthLimit, Suspicious_Fraud_LN.Common.genRiskCode('C282')) +
			IF(le.SSN.InquiryCountSFWeek >= WeekLimit AND le.Phone.InquiryCountSFWeek >= WeekLimit AND le.Name.InquiryCountSFWeek >= WeekLimit AND le.IPAddress.InquiryCountSFWeek >= WeekLimit AND le.Email.InquiryCountSFWeek >= WeekLimit, Suspicious_Fraud_LN.Common.genRiskCode('C283')) +
			IF(le.SSN.InquiryCountSFDay >= DayLimit AND le.Phone.InquiryCountSFDay >= DayLimit AND le.Name.InquiryCountSFDay >= DayLimit AND le.IPAddress.InquiryCountSFDay >= DayLimit AND le.Email.InquiryCountSFDay >= DayLimit, Suspicious_Fraud_LN.Common.genRiskCode('C284')) +
			IF(le.SSN.InquiryCountSFHour >= HourLimit AND le.Phone.InquiryCountSFHour >= HourLimit AND le.Name.InquiryCountSFHour >= HourLimit AND le.IPAddress.InquiryCountSFHour >= HourLimit AND le.Email.InquiryCountSFHour >= HourLimit, Suspicious_Fraud_LN.Common.genRiskCode('C285'));
			
		RiskCodes																					:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		CombinationHit 																		:= ut.Exists2(RiskCodes);
		Address																						:= ut.Exists2(RiskCodes (SuspiciousRiskCode IN AddressRCs));
		Email																							:= ut.Exists2(RiskCodes (SuspiciousRiskCode IN EmailRCs));
		IPAddress																					:= ut.Exists2(RiskCodes (SuspiciousRiskCode IN IPAddressRCs));
		Name																							:= ut.Exists2(RiskCodes (SuspiciousRiskCode IN NameRCs));
		Phone																							:= ut.Exists2(RiskCodes (SuspiciousRiskCode IN PhoneRCs));
		SSN																								:= ut.Exists2(RiskCodes (SuspiciousRiskCode IN SSNRCs));
		SELF.Suspicious_Combination.Data_Source						:= IF(CombinationHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		addressDateFirst := IF((INTEGER)le.Address.DateFirstSeenSF <= 0, 99999999, (INTEGER)le.Address.DateFirstSeenSF);
		emailDateFirst := IF((INTEGER)le.Email.DateFirstSeenSF <= 0, 99999999, (INTEGER)le.Email.DateFirstSeenSF);
		ipaddressDateFirst := IF((INTEGER)le.IPAddress.DateFirstSeenSF <= 0, 99999999, (INTEGER)le.IPAddress.DateFirstSeenSF);
		nameDateFirst := IF((INTEGER)le.Name.DateFirstSeenSF <= 0, 99999999, (INTEGER)le.Name.DateFirstSeenSF);
		phoneDateFirst := IF((INTEGER)le.Phone.DateFirstSeenSF <= 0, 99999999, (INTEGER)le.Phone.DateFirstSeenSF);
		ssnDateFirst := IF((INTEGER)le.SSN.DateFirstSeenSF <= 0, 99999999, (INTEGER)le.SSN.DateFirstSeenSF);
		dateFirstSeen := MIN(IF(Address, addressDateFirst, 99999999),
												 IF(Email, emailDateFirst, 99999999),
												 IF(IPAddress, ipaddressDateFirst, 99999999),
												 IF(Name, nameDateFirst, 99999999),
												 IF(Phone, phoneDateFirst, 99999999),
												 IF(SSN, ssnDateFirst, 99999999));
		SELF.Suspicious_Combination.DateFirstSeenInFile		:= MAP(CombinationHit = TRUE AND dateFirstSeen <> 99999999	=> (STRING)dateFirstSeen,
																																																										'');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_Combination.InquiryCountHour			:= IF(Address, le.Address.InquiryCountSFHour, 0) + 
																												 IF(Email, le.Email.InquiryCountSFHour, 0) +
																												 IF(IPAddress, le.IPAddress.InquiryCountSFHour, 0) +
																												 IF(Name, le.Name.InquiryCountSFHour, 0) +
																												 IF(Phone, le.Phone.InquiryCountSFHour, 0) +
																												 IF(SSN, le.SSN.InquiryCountSFHour, 0);
		SELF.Suspicious_Combination.InquiryCountDay				:= IF(Address, le.Address.InquiryCountSFDay, 0) + 
																												 IF(Email, le.Email.InquiryCountSFDay, 0) +
																												 IF(IPAddress, le.IPAddress.InquiryCountSFDay, 0) +
																												 IF(Name, le.Name.InquiryCountSFDay, 0) +
																												 IF(Phone, le.Phone.InquiryCountSFDay, 0) +
																												 IF(SSN, le.SSN.InquiryCountSFDay, 0);
		SELF.Suspicious_Combination.InquiryCountWeek			:= IF(Address, le.Address.InquiryCountSFWeek, 0) + 
																												 IF(Email, le.Email.InquiryCountSFWeek, 0) +
																												 IF(IPAddress, le.IPAddress.InquiryCountSFWeek, 0) +
																												 IF(Name, le.Name.InquiryCountSFWeek, 0) +
																												 IF(Phone, le.Phone.InquiryCountSFWeek, 0) +
																												 IF(SSN, le.SSN.InquiryCountSFWeek, 0);
		SELF.Suspicious_Combination.InquiryCountMonth			:= IF(Address, le.Address.InquiryCountSFMonth, 0) + 
																												 IF(Email, le.Email.InquiryCountSFMonth, 0) +
																												 IF(IPAddress, le.IPAddress.InquiryCountSFMonth, 0) +
																												 IF(Name, le.Name.InquiryCountSFMonth, 0) +
																												 IF(Phone, le.Phone.InquiryCountSFMonth, 0) +
																												 IF(SSN, le.SSN.InquiryCountSFMonth, 0);
		SELF.Suspicious_Combination.InquiryCountYear			:= IF(Address, le.Address.InquiryCountSFYear, 0) + 
																												 IF(Email, le.Email.InquiryCountSFYear, 0) +
																												 IF(IPAddress, le.IPAddress.InquiryCountSFYear, 0) +
																												 IF(Name, le.Name.InquiryCountSFYear, 0) +
																												 IF(Phone, le.Phone.InquiryCountSFYear, 0) +
																												 IF(SSN, le.SSN.InquiryCountSFYear, 0);
		SELF.Suspicious_Combination.InquiryCount					:= IF(Address, le.Address.InquiryCountSF, 0) + 
																												 IF(Email, le.Email.InquiryCountSF, 0) +
																												 IF(IPAddress, le.IPAddress.InquiryCountSF, 0) +
																												 IF(Name, le.Name.InquiryCountSF, 0) +
																												 IF(Phone, le.Phone.InquiryCountSF, 0) +
																												 IF(SSN, le.SSN.InquiryCountSF, 0);

		SELF.RiskCode_Combination													:= RiskCodes;
		
		SELF.Seq																					:= le.Seq;
		
		SELF 																							:= le;
		SELF 																							:= [];
	END;
	inquiryComboRiskCodes := PROJECT(allInquiries, getInquiryComboRiskCodes(LEFT)) (ut.Exists2(RiskCode_Combination));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combineComboRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_Combination.Data_Source := IF(le.Suspicious_Combination.Data_Source <> '', le.Suspicious_Combination.Data_Source, ri.Suspicious_Combination.Data_Source);
		SELF.Suspicious_Combination.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_Combination.DateFirstSeenInFile = 0	=> ri.Suspicious_Combination.DateFirstSeenInFile,
																													(UNSIGNED)ri.Suspicious_Combination.DateFirstSeenInFile = 0	=> le.Suspicious_Combination.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_Combination.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_Combination.DateFirstSeenInFile));
		SELF.Suspicious_Combination.InquiryCountHour := le.Suspicious_Combination.InquiryCountHour + ri.Suspicious_Combination.InquiryCountHour;
		SELF.Suspicious_Combination.InquiryCountDay := le.Suspicious_Combination.InquiryCountDay + ri.Suspicious_Combination.InquiryCountDay;
		SELF.Suspicious_Combination.InquiryCountWeek := le.Suspicious_Combination.InquiryCountWeek + ri.Suspicious_Combination.InquiryCountWeek;
		SELF.Suspicious_Combination.InquiryCountMonth := le.Suspicious_Combination.InquiryCountMonth + ri.Suspicious_Combination.InquiryCountMonth;
		SELF.Suspicious_Combination.InquiryCountYear := le.Suspicious_Combination.InquiryCountYear + ri.Suspicious_Combination.InquiryCountYear;
		SELF.Suspicious_Combination.InquiryCount := le.Suspicious_Combination.InquiryCount + ri.Suspicious_Combination.InquiryCount;
		SELF.RiskCode_Combination := le.RiskCode_Combination + ri.RiskCode_Combination;
		
		SELF := le;
	END;
	
	comboRiskCodesCombined := SORT(inquiryComboRiskCodes, Seq);

	comboRiskCodesTemp := ROLLUP(comboRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combineComboRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanComboRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_Combination, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_Combination := sortedCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanComboRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_Combination;
		SELF.Suspicious_Combination.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		SELF.Suspicious_Combination.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_Combination.DateFirstSeenInFile);
		SELF := le;
	END;
	comboRiskCodes1 := PROJECT(comboRiskCodesTemp, cleanComboRiskCodes1(LEFT));
	comboRiskCodes := PROJECT(NOFOLD(comboRiskCodes1), cleanComboRiskCodes2(LEFT));

	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(addressInquiriesCounted, NAMED('ComboaddressInquiriesCounted'));
	// OUTPUT(emailInquiriesCounted, NAMED('ComboemailInquiriesCounted'));
	// OUTPUT(ipAddressInquiriesCounted, NAMED('ComboipAddressInquiriesCounted'));
	// OUTPUT(nameInquiriesCounted, NAMED('CombonameInquiriesCounted'));
	// OUTPUT(phoneInquiriesCounted, NAMED('CombophoneInquiriesCounted'));
	// OUTPUT(ssnInquiriesCounted, NAMED('CombossnInquiriesCounted'));
	// OUTPUT(withAddress, NAMED('CombowithAddress'));
	// OUTPUT(withEmail, NAMED('CombowithEmail'));
	// OUTPUT(withIPAddress, NAMED('CombowithIPAddress'));
	// OUTPUT(withName, NAMED('CombowithName'));
	// OUTPUT(withPhone, NAMED('CombowithPhone'));
	// OUTPUT(withSSN, NAMED('CombowithSSN'));
	// OUTPUT(inquiryComboRiskCodes, NAMED('inquiryComboRiskCodes'));
	// OUTPUT(comboRiskCodesTemp, NAMED('comboRiskCodesTemp'));
	// OUTPUT(comboRiskCodes, NAMED('comboRiskCodes'));
	/* ******** END DEBUGGING SECTION **********/
	
	RETURN (comboRiskCodes);
END;