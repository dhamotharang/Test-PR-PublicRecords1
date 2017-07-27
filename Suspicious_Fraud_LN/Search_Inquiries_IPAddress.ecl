/* This function searches our Inquiries Keys and Inquiries Deltabase for IPAddress Inquiries */

IMPORT Gateway, Inquiry_AccLogs, Inquiry_Deltabase, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT;

EXPORT Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries Search_Inquiries_IPAddress (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																											UNSIGNED1 DPPAPurpose,
																																											UNSIGNED1 GLBPurpose,
																																											STRING50 DataRestrictionMask,
																																											DATASET(Gateway.Layouts.Config) DeltabaseGateway = Gateway.Constants.void_gateway) := FUNCTION
	InquiriesKey := Inquiry_AccLogs.Key_Inquiry_IPAddr;
	InquiriesUpdateKey := Inquiry_AccLogs.Key_Inquiry_IPAddr_Update;

	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesKey, Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries, InquiriesKey);
	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesUpdateKey, Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries, InquiriesUpdateKey);
	Suspicious_Fraud_LN.InquiryTransformMac (getInquiriesDeltabase, Suspicious_Fraud_LN.layouts.Layout_IPAddress_Inquiries, Inquiry_Deltabase.Layouts.Inquiry_IPAddr);
	
	rawInquiriesKey := JOIN(Input, InquiriesKey, TRIM(LEFT.Clean_Input.IPAddress) <> '' AND KEYED(LEFT.Clean_Input.IPAddress = RIGHT.IPaddr) AND
																							 Inquiry_AccLogs.Shell_Constants.Valid_Suspicious_Fraud_Inquiry(LEFT.Clean_Input.ArchiveDate, RIGHT.Search_Info.DateTime[1..8], StringLib.StringToUpperCase(TRIM(RIGHT.Bus_Intel.Industry, ALL)), StringLib.StringToUpperCase(TRIM(RIGHT.Search_Info.Function_Description)), RIGHT.Bus_Intel.Use) AND
																							 (UNSIGNED)RIGHT.search_info.datetime[1..6] <= LEFT.Clean_Input.ArchiveDate,
																							 getInquiriesKey(LEFT, RIGHT), KEEP(5000), ATMOST(5000));
																							 
	rawInquiriesUpdateKey := JOIN(Input, InquiriesUpdateKey, TRIM(LEFT.Clean_Input.IPAddress) <> '' AND KEYED(LEFT.Clean_Input.IPAddress = RIGHT.IPaddr) AND
																							 Inquiry_AccLogs.Shell_Constants.Valid_Suspicious_Fraud_Inquiry(LEFT.Clean_Input.ArchiveDate, RIGHT.Search_Info.DateTime[1..8], StringLib.StringToUpperCase(TRIM(RIGHT.Bus_Intel.Industry, ALL)), StringLib.StringToUpperCase(TRIM(RIGHT.Search_Info.Function_Description)), RIGHT.Bus_Intel.Use) AND
																							 (UNSIGNED)RIGHT.search_info.datetime[1..6] <= LEFT.Clean_Input.ArchiveDate,
																							 getInquiriesUpdateKey(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));
	
	// We will only call the Deltabase for Realtime queries, not Archive Runs, since the Deltabase will have at most a week of transactions in it.
	deltabaseInput := PROJECT(Input (Clean_Input.ArchiveDate = 999999), TRANSFORM(Inquiry_Deltabase.Layouts.Input_Deltabase_IPAddr, SELF.Seq := LEFT.Seq;
																																														SELF.IPAddress := LEFT.Clean_Input.IPAddress));
	
	deltabaseInquiries := IF(TRIM(DeltabaseGateway[1].URL) <> '' AND ut.Exists2(deltabaseInput), 
																										 Inquiry_Deltabase.Search_IPAddr(deltabaseInput, Inquiry_AccLogs.shell_constants.set_valid_suspiciousfraud_functions, (STRING)Suspicious_Fraud_LN.Constants.DeltabaseLimit, DeltabaseGateway),
																										 DATASET([], Inquiry_Deltabase.Layouts.Inquiry_IPAddr));
	
	rawInquiriesDeltabase := JOIN(Input, deltabaseInquiries, TRIM(LEFT.Clean_Input.IPAddress) <> '' AND LEFT.Clean_Input.IPAddress = RIGHT.IPaddr,
																							 getInquiriesDeltabase(LEFT, RIGHT), KEEP(RiskWise.max_atmost)); // Cannot use ATMOST with non-keyed join to the Deltabase dataset.  Compiles on THOR with ATMOST, but not ROXIE.
	
	rawInquiriesCombined := UNGROUP(rawInquiriesKey + rawInquiriesUpdateKey + rawInquiriesDeltabase);
	
	// Only keep the inquiries that are valid (Have an Inquiry_Hit)
	rawInquiriesFull := DEDUP(SORT(rawInquiriesCombined (Inquiry_Hit = TRUE), Seq, Transaction_ID, -LogDate, -LogTime), Seq, Transaction_ID, LogDate, LogTime);
	
	final := rawInquiriesFull;
	
	// OUTPUT(CHOOSEN(rawInquiriesDeltabase, 100), NAMED('Deltabase_IPAddr'));
	
	RETURN (final);																																						
END;