/* This function searches our Inquiries Keys and Inquiries Deltabase for Address Inquiries */

IMPORT Gateway, Inquiry_AccLogs, Inquiry_Deltabase, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries Search_Inquiries_Address (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																											UNSIGNED1 DPPAPurpose,
																																											UNSIGNED1 GLBPurpose,
																																											STRING50 DataRestrictionMask,
																																											DATASET(Gateway.Layouts.Config) DeltabaseGateway = Gateway.Constants.void_gateway) := FUNCTION
	InquiriesKey := Inquiry_AccLogs.Key_Inquiry_Address;
	InquiriesUpdateKey := Inquiry_AccLogs.Key_Inquiry_Address_Update;

	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesKey, Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries, InquiriesKey);
	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesUpdateKey, Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries, InquiriesUpdateKey);
	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesDeltabase, Suspicious_Fraud_LN.layouts.Layout_Address_Inquiries, Inquiry_Deltabase.Layouts.Inquiry_Address);
	
	rawInquiriesKey := JOIN(Input, InquiriesKey, TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																							 KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip) AND
																							 KEYED(LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name) AND
																							 KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range) AND
																							 KEYED(LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range) AND
																							 LEFT.Clean_Input.PreDir = RIGHT.Person_Q.Predir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Person_Q.Addr_Suffix AND
																							 Inquiry_AccLogs.Shell_Constants.Valid_Suspicious_Fraud_Inquiry(LEFT.Clean_Input.ArchiveDate, RIGHT.Search_Info.DateTime[1..8], StringLib.StringToUpperCase(TRIM(RIGHT.Bus_Intel.Industry, ALL)), StringLib.StringToUpperCase(TRIM(RIGHT.Search_Info.Function_Description)), RIGHT.Bus_Intel.Use) AND
																							 (UNSIGNED)RIGHT.search_info.datetime[1..6] <= LEFT.Clean_Input.ArchiveDate,
																							 getInquiriesKey(LEFT, RIGHT), KEEP(5000), ATMOST(5000));
																							 
	rawInquiriesUpdateKey := JOIN(Input, InquiriesUpdateKey, TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																							 KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip) AND
																							 KEYED(LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name) AND
																							 KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range) AND
																							 KEYED(LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range) AND
																							 LEFT.Clean_Input.PreDir = RIGHT.Person_Q.Predir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Person_Q.Addr_Suffix AND
																							 Inquiry_AccLogs.Shell_Constants.Valid_Suspicious_Fraud_Inquiry(LEFT.Clean_Input.ArchiveDate, RIGHT.Search_Info.DateTime[1..8], StringLib.StringToUpperCase(TRIM(RIGHT.Bus_Intel.Industry, ALL)), StringLib.StringToUpperCase(TRIM(RIGHT.Search_Info.Function_Description)), RIGHT.Bus_Intel.Use) AND
																							 (UNSIGNED)RIGHT.search_info.datetime[1..6] <= LEFT.Clean_Input.ArchiveDate,
																							 getInquiriesUpdateKey(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));
	
	// We will only call the Deltabase for Realtime queries, not Archive Runs, since the Deltabase will have at most a week of transactions in it.
	deltabaseInput := PROJECT(Input (Clean_Input.ArchiveDate = 999999), TRANSFORM(Inquiry_Deltabase.Layouts.Input_Deltabase_Address, SELF.Seq := LEFT.Seq;
																																														SELF.Prim_Range := LEFT.Clean_Input.Prim_Range;
																																														SELF.Prim_Name := LEFT.Clean_Input.Prim_Name;
																																														SELF.Sec_Range := LEFT.Clean_Input.Sec_Range;
																																														SELF.Zip5 := LEFT.Clean_Input.Zip5));
	
	deltabaseInquiries := IF(TRIM(DeltabaseGateway[1].URL) <> '' AND ut.Exists2(deltabaseInput), 
																										 Inquiry_Deltabase.Search_Address(deltabaseInput, Inquiry_AccLogs.shell_constants.set_valid_suspiciousfraud_functions, (STRING)Suspicious_Fraud_LN.Constants.DeltabaseLimit, DeltabaseGateway),
																										 DATASET([], Inquiry_Deltabase.Layouts.Inquiry_Address));
	
	rawInquiriesDeltabase := JOIN(Input, deltabaseInquiries, TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																							 LEFT.Clean_Input.Zip5 = RIGHT.Zip AND
																							 LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND
																							 LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND
																							 LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range AND
																							 LEFT.Clean_Input.PreDir = RIGHT.Person_Q.Predir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Person_Q.Addr_Suffix,
																							 getInquiriesDeltabase(LEFT, RIGHT), KEEP(RiskWise.max_atmost)); // Cannot use ATMOST with non-keyed join to the Deltabase dataset.  Compiles on THOR with ATMOST, but not ROXIE.
	
	rawInquiriesCombined := UNGROUP(rawInquiriesKey + rawInquiriesUpdateKey + rawInquiriesDeltabase);
	
	// Only keep the inquiries that are valid (Have an Inquiry_Hit)
	rawInquiriesFull := DEDUP(SORT(rawInquiriesCombined (Inquiry_Hit = TRUE), Seq, Transaction_ID, -LogDate, -LogTime), Seq, Transaction_ID, LogDate, LogTime);
	
	final := rawInquiriesFull;
	
	// OUTPUT(CHOOSEN(rawInquiriesDeltabase, 100), NAMED('Deltabase_Address'));
	
	RETURN (final);																																									
END;