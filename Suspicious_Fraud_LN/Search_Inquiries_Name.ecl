/* This function searches our Inquiries Keys and Inquiries Deltabase for Name Inquiries */

IMPORT Gateway, Inquiry_AccLogs, Inquiry_Deltabase, RiskWise, Suspicious_Fraud_LN, UT, Doxie, Suppress;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries Search_Inquiries_Name (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																											UNSIGNED1 DPPAPurpose,
																																											UNSIGNED1 GLBPurpose,
																																											STRING50 DataRestrictionMask,
																																											DATASET(Gateway.Layouts.Config) DeltabaseGateway = Gateway.Constants.void_gateway,
																																											doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	InquiriesKey := Inquiry_AccLogs.Key_Inquiry_Name;
	InquiriesUpdateKey := Inquiry_AccLogs.Key_Inquiry_Name_Update;
	
	Layout_Address_Inquiries_CCPA := RECORD
		Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries;
		UNSIGNED6 did;
	END;

	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesKey, Layout_Address_Inquiries_CCPA, InquiriesKey, TRUE);
	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesUpdateKey, Layout_Address_Inquiries_CCPA, InquiriesUpdateKey, TRUE);
	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesDeltabase, Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries, Inquiry_Deltabase.Layouts.Inquiry_Name);

	rawInquiriesKey_unsuppressed := JOIN(Input, InquiriesKey, LEFT.Clean_Input.FirstName <> '' AND KEYED(LEFT.Clean_Input.FirstName = RIGHT.fname) AND // First Name Matches
																								((LEFT.Clean_Input.LastName <> '' AND LEFT.Clean_Input.LastName = RIGHT.lname) OR // And last name, or middle name/middle initial matches
																									((LEFT.Clean_Input.MiddleName <> '' AND LEFT.Clean_Input.MiddleName = RIGHT.mname) OR
																									 (LEFT.Clean_Input.MiddleInitial <> '' AND LEFT.Clean_Input.MiddleInitial = RIGHT.mname[1])))
																								 AND
																							 Inquiry_AccLogs.Shell_Constants.Valid_Suspicious_Fraud_Inquiry(LEFT.Clean_Input.ArchiveDate, RIGHT.Search_Info.DateTime[1..8], StringLib.StringToUpperCase(TRIM(RIGHT.Bus_Intel.Industry, ALL)), StringLib.StringToUpperCase(TRIM(RIGHT.Search_Info.Function_Description)), RIGHT.Bus_Intel.Use) AND
																							 (UNSIGNED)RIGHT.search_info.datetime[1..6] <= LEFT.Clean_Input.ArchiveDate,
																							 getInquiriesKey(LEFT, RIGHT), KEEP(5000), ATMOST(5000));
		
	rawInquiriesKey := Suppress.Suppress_ReturnOldLayout(rawInquiriesKey_unsuppressed, mod_access, Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries, gsidfield := ccpa.global_sid);
																						 
	rawInquiriesUpdateKey_unsuppressed := JOIN(Input, InquiriesUpdateKey, LEFT.Clean_Input.FirstName <> '' AND KEYED(LEFT.Clean_Input.FirstName = RIGHT.fname) AND // First Name Matches
																								((LEFT.Clean_Input.LastName <> '' AND LEFT.Clean_Input.LastName = RIGHT.lname) OR // And last name, or middle name/middle initial matches
																									((LEFT.Clean_Input.MiddleName <> '' AND LEFT.Clean_Input.MiddleName = RIGHT.mname) OR
																									 (LEFT.Clean_Input.MiddleInitial <> '' AND LEFT.Clean_Input.MiddleInitial = RIGHT.mname[1])))
																								 AND
																							 Inquiry_AccLogs.Shell_Constants.Valid_Suspicious_Fraud_Inquiry(LEFT.Clean_Input.ArchiveDate, RIGHT.Search_Info.DateTime[1..8], StringLib.StringToUpperCase(TRIM(RIGHT.Bus_Intel.Industry, ALL)), StringLib.StringToUpperCase(TRIM(RIGHT.Search_Info.Function_Description)), RIGHT.Bus_Intel.Use) AND
																							 (UNSIGNED)RIGHT.search_info.datetime[1..6] <= LEFT.Clean_Input.ArchiveDate,
																							 getInquiriesUpdateKey(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));
		
	rawInquiriesUpdateKey := Suppress.Suppress_ReturnOldLayout(rawInquiriesUpdateKey_unsuppressed, mod_access, Suspicious_Fraud_LN.layouts.Layout_Name_Inquiries, gsidfield := ccpa.global_sid);

	// We will only call the Deltabase for Realtime queries, not Archive Runs, since the Deltabase will have at most a week of transactions in it.
	deltabaseInput := PROJECT(Input (Clean_Input.ArchiveDate = 999999), TRANSFORM(Inquiry_Deltabase.Layouts.Input_Deltabase_Name, SELF.Seq := LEFT.Seq;
																																														SELF.FirstName := LEFT.Clean_Input.FirstName;
																																														SELF.MiddleName := LEFT.Clean_Input.MiddleName;
																																														SELF.LastName := LEFT.Clean_Input.LastName));
	
	deltabaseInquiries := IF(TRIM(DeltabaseGateway[1].URL) <> '' AND ut.Exists2(deltabaseInput), 
																										 Inquiry_Deltabase.Search_Name(deltabaseInput, Inquiry_AccLogs.shell_constants.set_valid_suspiciousfraud_functions, (STRING)Suspicious_Fraud_LN.Constants.DeltabaseLimit, DeltabaseGateway),
																										 DATASET([], Inquiry_Deltabase.Layouts.Inquiry_Name));
	
	rawInquiriesDeltabase := JOIN(Input, deltabaseInquiries, LEFT.Clean_Input.FirstName <> '' AND LEFT.Clean_Input.FirstName = RIGHT.fname AND // First Name Matches
																								((LEFT.Clean_Input.LastName <> '' AND LEFT.Clean_Input.LastName = RIGHT.lname) OR // And last name, or middle name/middle initial matches
																									((LEFT.Clean_Input.MiddleName <> '' AND LEFT.Clean_Input.MiddleName = RIGHT.mname) OR
																									 (LEFT.Clean_Input.MiddleInitial <> '' AND LEFT.Clean_Input.MiddleInitial = RIGHT.mname[1]))),
																							 getInquiriesDeltabase(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ALL); // Because of the complex join condition we can't use ATMOST and must include ALL for it to compile. Thankfully Deltabase records is a small dataset.
	
	rawInquiriesCombined := UNGROUP(rawInquiriesKey + rawInquiriesUpdateKey + rawInquiriesDeltabase);
	
	// Only keep the inquiries that are valid (Have an Inquiry_Hit) and meet the Name Match rules
	rawInquiriesFull := DEDUP(SORT(rawInquiriesCombined (Inquiry_Hit = TRUE AND Name_Match = TRUE), Seq, Transaction_ID, -LogDate, -LogTime), Seq, Transaction_ID, LogDate, LogTime);
	
	final := rawInquiriesFull;
	
	// OUTPUT(CHOOSEN(rawInquiriesDeltabase, 100), NAMED('Deltabase_Name'));
	
	RETURN (final);
END;