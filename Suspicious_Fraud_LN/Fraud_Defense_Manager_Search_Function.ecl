IMPORT Address, Doxie, Gateway, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT, STD;

EXPORT Fraud_Defense_Manager_Search_Function(DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_In) Batch_In, 
																				UNSIGNED1 GLBPurpose, 
																				UNSIGNED1 DPPAPurpose, 
																				STRING50 DataRestrictionMask,
																				DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway,
																				doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	/* ************************************************
	 *   Grab Gateway Information                     *
	 **************************************************/
	DeltabaseGateway := Gateways (StringLib.StringToLowerCase(ServiceName) = 'delta_inquiry');
	NetAcuityGateway := Gateways (StringLib.StringToLowerCase(ServiceName) = 'netacuity');
	
	/* ************************************************
	 *   Clean the Input and Handle Duplicate Inputs  *
	 **************************************************/
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanInput(Suspicious_Fraud_LN.layouts.Layout_Batch_In le, UNSIGNED8 seqCounter) := TRANSFORM
		SELF.Seq := seqCounter; // Uniquely sequence each input record
		
		SELF.Clean_Input.AccountNumber := le.AcctNo;
		
		SELF.Clean_Input.FirstName			:= StringLib.StringToUpperCase(TRIM(le.FirstName));
		SELF.Clean_Input.MiddleName			:= IF(LENGTH(TRIM(le.MiddleName)) > 1, StringLib.StringToUpperCase(TRIM(le.MiddleName)), '');
		SELF.Clean_Input.MiddleInitial	:= IF(LENGTH(TRIM(le.MiddleName)) = 1, StringLib.StringToUpperCase(le.MiddleName[1]), '');
		SELF.Clean_Input.LastName				:= StringLib.StringToUpperCase(TRIM(le.LastName));
		
		streetAddr1 := StringLib.StringToUpperCase(TRIM(le.StreetAddress1));
		streetAddr2 := StringLib.StringToUpperCase(TRIM(le.StreetAddress2));
		city := StringLib.StringToUpperCase(TRIM(le.City));
		state := StringLib.StringToUpperCase(TRIM(le.State));
		numbers := '0123456789';
		zip5 := StringLib.StringFilter(le.Zip5, numbers);
		cleaned_address := Risk_Indicators.MOD_AddressClean.Clean_Addr(streetAddr1, city, state, zip5, streetAddr2);
		cleanStreetAddr1 := Address.Addr1FromComponents(Address.CleanFields(cleaned_address).Prim_Range, Address.CleanFields(cleaned_address).PreDir,
																										Address.CleanFields(cleaned_address).Prim_Name, Address.CleanFields(cleaned_address).Addr_Suffix,
																										Address.CleanFields(cleaned_address).PostDir, Address.CleanFields(cleaned_address).Unit_Desig,
																										Address.CleanFields(cleaned_address).Sec_Range);
		SELF.Clean_Input.StreetAddress1	:= cleanStreetAddr1;
		SELF.Clean_Input.StreetAddress2	:= streetAddr2;
		SELF.Clean_Input.City						:= Address.CleanFields(cleaned_address).P_City_Name;
		SELF.Clean_Input.State					:= Address.CleanFields(cleaned_address).St;
		SELF.Clean_Input.Zip						:= TRIM(Address.CleanFields(cleaned_address).Zip + Address.CleanFields(cleaned_address).Zip4);
		SELF.Clean_Input.Zip5						:= Address.CleanFields(cleaned_address).Zip;
		SELF.Clean_Input.Zip4						:= Address.CleanFields(cleaned_address).Zip4;
		SELF.Clean_Input.Prim_Range			:= Address.CleanFields(cleaned_address).Prim_Range;
		SELF.Clean_Input.Predir					:= Address.CleanFields(cleaned_address).Predir;
		SELF.Clean_Input.Prim_Name			:= Address.CleanFields(cleaned_address).Prim_Name;
		SELF.Clean_Input.Addr_Suffix		:= Address.CleanFields(cleaned_address).Addr_Suffix;
		SELF.Clean_Input.Postdir				:= Address.CleanFields(cleaned_address).Postdir;
		SELF.Clean_Input.Unit_Desig			:= Address.CleanFields(cleaned_address).Unit_Desig;
		SELF.Clean_Input.Sec_Range			:= Address.CleanFields(cleaned_address).Sec_Range;
		SELF.Clean_Input.Lat						:= Address.CleanFields(cleaned_address).Geo_Lat;
		SELF.Clean_Input.Long						:= Address.CleanFields(cleaned_address).Geo_Long;
		SELF.Clean_Input.County					:= Address.CleanFields(cleaned_address).County;
		SELF.Clean_Input.Geo_Block			:= Address.CleanFields(cleaned_address).Geo_Blk;
		SELF.Clean_Input.Addr_Type			:= Risk_Indicators.iid_constants.override_addr_type(cleanStreetAddr1, Address.CleanFields(cleaned_address).Rec_Type[1], Address.CleanFields(cleaned_address).Cart);
		SELF.Clean_Input.Addr_Status		:= Address.CleanFields(cleaned_address).Err_Stat;
		
		SELF.Clean_Input.DateOfBirth := StringLib.StringFilter(le.DateOfBirth, numbers);
		SELF.Clean_Input.SSN := StringLib.StringFilter(le.SSN, numbers);
		SELF.Clean_Input.Phone10 := StringLib.StringFilter(le.Phone10, numbers);
		SELF.Clean_Input.IPAddress := StringLib.StringToUpperCase(TRIM(le.IPAddress));
		SELF.Clean_Input.Email := StringLib.StringToUpperCase(TRIM(le.Email));
		SELF.Clean_Input.DriverLicenseNumber := StringLib.StringToUpperCase(TRIM(le.DriverLicenseNumber));
		SELF.Clean_Input.DriverLicenseState := StringLib.StringToUpperCase(TRIM(le.DriverLicenseState));
		SELF.Clean_Input.DeviceID := StringLib.StringToUpperCase(TRIM(le.DeviceID));
		
		HistoryDateYYYYMM := (UNSIGNED)(((STRING)le.ArchiveDate)[1..6]);
		Today := (UNSIGNED)((STRING8)Std.Date.Today())[1..6];
		// If history date is populated and less than today's date, use historical date, otherwise run realtime
		SELF.Clean_Input.ArchiveDate := IF(HistoryDateYYYYMM <= Today AND HistoryDateYYYYMM > 0, HistoryDateYYYYMM, 999999);
		
		SELF.Input_Echo := le;
		
		SELF := [];
	END;
	
	cleanedInput := PROJECT(Batch_In, cleanInput(LEFT, COUNTER));
	
	// Because Batch likes to do silly things such as running the same input multiple times, dedup our input and only run 1 copy through the entire service
	cleanedInputDeduped := DEDUP(SORT(cleanedInput, 
																		Clean_Input.FirstName, Clean_Input.MiddleName, Clean_Input.MiddleInitial, Clean_Input.LastName, Clean_Input.StreetAddress1, Clean_Input.StreetAddress2, Clean_Input.City, Clean_Input.State, Clean_Input.Zip, Clean_Input.Zip5, Clean_Input.Zip4, Clean_Input.Prim_Range, Clean_Input.Predir, Clean_Input.Prim_Name, Clean_Input.Addr_Suffix, Clean_Input.Postdir, Clean_Input.Unit_Desig, Clean_Input.Sec_Range, Clean_Input.DateOfBirth, Clean_Input.SSN, Clean_Input.Phone10, Clean_Input.IPAddress, Clean_Input.Email, Clean_Input.DriverLicenseNumber, Clean_Input.DriverLicenseState, Clean_Input.DeviceID, Clean_Input.ArchiveDate, Seq),
																		Clean_Input.FirstName, Clean_Input.MiddleName, Clean_Input.MiddleInitial, Clean_Input.LastName, Clean_Input.StreetAddress1, Clean_Input.StreetAddress2, Clean_Input.City, Clean_Input.State, Clean_Input.Zip, Clean_Input.Zip5, Clean_Input.Zip4, Clean_Input.Prim_Range, Clean_Input.Predir, Clean_Input.Prim_Name, Clean_Input.Addr_Suffix, Clean_Input.Postdir, Clean_Input.Unit_Desig, Clean_Input.Sec_Range, Clean_Input.DateOfBirth, Clean_Input.SSN, Clean_Input.Phone10, Clean_Input.IPAddress, Clean_Input.Email, Clean_Input.DriverLicenseNumber, Clean_Input.DriverLicenseState, Clean_Input.DeviceID, Clean_Input.ArchiveDate);
	// Use this to figure out which final sequence numbers match up to the input since we don't want to run duplicates through the entire service
	seqMap := JOIN(cleanedInput, cleanedInputDeduped, 
																		LEFT.Clean_Input.FirstName = RIGHT.Clean_Input.FirstName AND
																		LEFT.Clean_Input.MiddleName = RIGHT.Clean_Input.MiddleName AND
																		LEFT.Clean_Input.MiddleInitial = RIGHT.Clean_Input.MiddleInitial AND
																		LEFT.Clean_Input.LastName = RIGHT.Clean_Input.LastName AND
																		LEFT.Clean_Input.StreetAddress1 = RIGHT.Clean_Input.StreetAddress1 AND
																		LEFT.Clean_Input.StreetAddress2 = RIGHT.Clean_Input.StreetAddress2 AND
																		LEFT.Clean_Input.City = RIGHT.Clean_Input.City AND
																		LEFT.Clean_Input.State = RIGHT.Clean_Input.State AND
																		LEFT.Clean_Input.Zip = RIGHT.Clean_Input.Zip AND
																		LEFT.Clean_Input.Zip5 = RIGHT.Clean_Input.Zip5 AND
																		LEFT.Clean_Input.Zip4 = RIGHT.Clean_Input.Zip4 AND
																		LEFT.Clean_Input.Prim_Range = RIGHT.Clean_Input.Prim_Range AND
																		LEFT.Clean_Input.Predir = RIGHT.Clean_Input.Predir AND
																		LEFT.Clean_Input.Prim_Name = RIGHT.Clean_Input.Prim_Name AND
																		LEFT.Clean_Input.Addr_Suffix = RIGHT.Clean_Input.Addr_Suffix AND
																		LEFT.Clean_Input.Postdir = RIGHT.Clean_Input.Postdir AND
																		LEFT.Clean_Input.Unit_Desig = RIGHT.Clean_Input.Unit_Desig AND
																		LEFT.Clean_Input.Sec_Range = RIGHT.Clean_Input.Sec_Range AND
																		LEFT.Clean_Input.DateOfBirth = RIGHT.Clean_Input.DateOfBirth AND
																		LEFT.Clean_Input.SSN = RIGHT.Clean_Input.SSN AND
																		LEFT.Clean_Input.Phone10 = RIGHT.Clean_Input.Phone10 AND
																		LEFT.Clean_Input.IPAddress = RIGHT.Clean_Input.IPAddress AND
																		LEFT.Clean_Input.Email = RIGHT.Clean_Input.Email AND
																		LEFT.Clean_Input.DriverLicenseNumber = RIGHT.Clean_Input.DriverLicenseNumber AND
																		LEFT.Clean_Input.DriverLicenseState = RIGHT.Clean_Input.DriverLicenseState AND
																		LEFT.Clean_Input.DeviceID = RIGHT.Clean_Input.DeviceID AND
																		LEFT.Clean_Input.ArchiveDate = RIGHT.Clean_Input.ArchiveDate,
										TRANSFORM({UNSIGNED8 seq, UNSIGNED8 DedupedSeq, STRING30 AccountNumber}, SELF.seq := LEFT.seq, SELF.DedupedSeq := RIGHT.seq; SELF.AccountNumber := LEFT.Input_Echo.AcctNo), ATMOST(RiskWise.max_atmost));
	
	/* ************************************************
	 *   Perform DID append process                   *
	 **************************************************/	
	Risk_Indicators.Layout_Input intoDIDInput(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		SELF.seq := le.seq;
		
		SELF.historyDate := le.Clean_Input.ArchiveDate;
		
		SELF.fname := le.Clean_Input.FirstName;
		SELF.mname := TRIM(le.Clean_Input.MiddleName) + TRIM(le.Clean_Input.MiddleInitial);
		SELF.lname := le.Clean_Input.LastName;
		
		SELF.in_streetAddress := le.Clean_Input.StreetAddress1;
		SELF.in_city := le.Clean_Input.City;
		SELF.in_state := le.Clean_Input.State;
		SELF.in_zipcode := le.Clean_Input.Zip5;
		
		SELF.prim_range := le.Clean_Input.Prim_Range;
		SELF.predir := le.Clean_Input.Predir;
		SELF.prim_name := le.Clean_Input.Prim_Name;
		SELF.addr_suffix := le.Clean_Input.Addr_Suffix;
		SELF.postdir := le.Clean_Input.Postdir;
		SELF.unit_desig := le.Clean_Input.Unit_Desig;
		SELF.sec_range := le.Clean_Input.Sec_Range;
		SELF.p_city_name := le.Clean_Input.City;
		SELF.st := le.Clean_Input.State;
		SELF.z5 := le.Clean_Input.Zip5;
		SELF.zip4 := le.Clean_Input.Zip4;
		SELF.lat := le.Clean_Input.Lat;
		SELF.long := le.Clean_Input.Long;
		SELF.county := le.Clean_Input.County;
		SELF.geo_blk := le.Clean_Input.Geo_Block;
		SELF.Addr_Type := le.Clean_Input.Addr_Type;
		SELF.Addr_Status := le.Clean_Input.Addr_Status;
		
		SELF.SSN := le.Clean_Input.SSN;
		SELF.dob := le.Clean_Input.DateOfBirth;
		SELF.dl_number := le.Clean_Input.DriverLicenseNumber;
		SELF.dl_state := le.Clean_Input.DriverLicenseState;
		SELF.email_address := le.Clean_Input.Email;
		SELF.ip_address := le.Clean_Input.IPAddress;
		SELF.phone10 := le.Clean_Input.Phone10;
		
		SELF := [];
	END;
	prepDIDInput := PROJECT(cleanedInputDeduped, intoDIDInput(LEFT));
	
	isFCRA := FALSE;
	BSVersion := 41; // Just want to use Boca Shell V3+ DID append logic
	Append_Best := 0; // Don't need to append SSN
	BSOptions := 0; // No special Boca Shell options, just want to append the DID
	
	didAppended := Risk_Indicators.iid_getDID_prepOutput(prepDIDInput, DPPAPurpose, GLBPurpose, isFCRA, BSVersion, DataRestrictionMask, Append_Best, Gateways, BSOptions, mod_access);
	
	with_DID := JOIN(cleanedInputDeduped, didAppended, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.Input_Echo.LexID := RIGHT.did; SELF.Clean_Input.DID := RIGHT.did; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	/* ************************************************
	 *  Gather Inquiries Data - Used For Risk Codes   *
	 **************************************************/
	AddressInquiries			:= Suspicious_Fraud_LN.Search_Inquiries_Address(with_DID, DPPAPurpose, GLBPurpose, DataRestrictionMask, DeltabaseGateway, mod_access);
	
	EmailInquiries				:= Suspicious_Fraud_LN.Search_Inquiries_Email(with_DID, DPPAPurpose, GLBPurpose, DataRestrictionMask, DeltabaseGateway, mod_access);
	
	IPAddressInquiries		:= Suspicious_Fraud_LN.Search_Inquiries_IPAddress(with_DID, DPPAPurpose, GLBPurpose, DataRestrictionMask, DeltabaseGateway, mod_access);
	
	NameInquiries					:= Suspicious_Fraud_LN.Search_Inquiries_Name(with_DID, DPPAPurpose, GLBPurpose, DataRestrictionMask, DeltabaseGateway, mod_access);
	
	PhoneInquiries				:= Suspicious_Fraud_LN.Search_Inquiries_Phone(with_DID, DPPAPurpose, GLBPurpose, DataRestrictionMask, DeltabaseGateway, mod_access);
	
	SSNInquiries					:= Suspicious_Fraud_LN.Search_Inquiries_SSN(with_DID, DPPAPurpose, GLBPurpose, DataRestrictionMask, DeltabaseGateway, mod_access);
	
	/* ************************************************
	 *   Gather Risk Codes/Risk Indicators            *
	 **************************************************/
	AddressRisk						:= Suspicious_Fraud_LN.Search_Address_Risk(with_DID, AddressInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask, mod_access);
	
	EmailRisk							:= Suspicious_Fraud_LN.Search_Email_Risk(with_DID, EmailInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask, mod_access);
	
	IPAddressRisk					:= Suspicious_Fraud_LN.Search_IPAddress_Risk(with_DID, IPAddressInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask, NetAcuityGateway);
	
	NameRisk							:= Suspicious_Fraud_LN.Search_Name_Risk(with_DID, NameInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask);
	
	PhoneRisk							:= Suspicious_Fraud_LN.Search_Phone_Risk(with_DID, PhoneInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask, mod_access);
	
	SSNRisk								:= Suspicious_Fraud_LN.Search_SSN_Risk(with_DID, SSNInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask,
																																LexIdSourceOptout := mod_access.lexid_source_optout, 
																																TransactionID := mod_access.transaction_id, 
																																GlobalCompanyID := mod_access.global_company_id);
	
	CombinationRisk				:= Suspicious_Fraud_LN.Search_Combination_Risk(with_DID, AddressInquiries, EmailInquiries, IPAddressInquiries, NameInquiries, PhoneInquiries, SSNInquiries, DPPAPurpose, GLBPurpose, DataRestrictionMask);
	
	/* ************************************************
	 *   Combine It All Together                      *
	 **************************************************/
	with_AddressRisk			:= JOIN(with_DID, AddressRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_Address := RIGHT.RiskCode_Address; 
																																																																				SELF.USPISHotListRecords := RIGHT.USPISHotListRecords;
																																																																				Address_Hit := ut.Exists2(RIGHT.RiskCode_Address);
																																																																				SELF.Suspicious_Address.Address_Hit := IF(Address_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_Address.Address_Message := IF(Address_Hit, '', Suspicious_Fraud_LN.Constants.AddressMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_Address.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_Address.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_Address.DateFirstSeenInFile := IF(Address_Hit, cleanDate, '');
																																																																				SELF.Suspicious_Address := RIGHT.Suspicious_Address; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	with_EmailRisk				:= JOIN(with_AddressRisk, EmailRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_Email := RIGHT.RiskCode_Email; 
																																																																				Email_Hit := ut.Exists2(RIGHT.RiskCode_Email);
																																																																				SELF.Suspicious_Email.Email_Hit := IF(Email_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_Email.Email_Message := IF(Email_Hit, '', Suspicious_Fraud_LN.Constants.EmailMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_Email.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_Email.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_Email.DateFirstSeenInFile := IF(Email_Hit, cleanDate, '');
																																																																				SELF.Suspicious_Email := RIGHT.Suspicious_Email; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	with_IPAddressRisk		:= JOIN(with_EmailRisk, IPAddressRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_IPAddress := RIGHT.RiskCode_IPAddress; 
																																																																				IPAddress_Hit := ut.Exists2(RIGHT.RiskCode_IPAddress);
																																																																				SELF.Suspicious_IPAddress.IPAddress_Hit := IF(IPAddress_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_IPAddress.IPAddress_Message := IF(IPAddress_Hit, '', Suspicious_Fraud_LN.Constants.IPAddressMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_IPAddress.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_IPAddress.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_IPAddress.DateFirstSeenInFile := IF(IPAddress_Hit, cleanDate, '');
																																																																				SELF.Suspicious_IPAddress := RIGHT.Suspicious_IPAddress; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	with_NameRisk					:= JOIN(with_IPAddressRisk, NameRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_Name := RIGHT.RiskCode_Name; 
																																																																				Name_Hit := ut.Exists2(RIGHT.RiskCode_Name);
																																																																				SELF.Suspicious_Name.Name_Hit := IF(Name_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_Name.Name_Message := IF(Name_Hit, '', Suspicious_Fraud_LN.Constants.NameMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_Name.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_Name.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_Name.DateFirstSeenInFile := IF(Name_Hit, cleanDate, '');
																																																																				SELF.Suspicious_Name := RIGHT.Suspicious_Name; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	with_PhoneRisk				:= JOIN(with_NameRisk, PhoneRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_Phone := RIGHT.RiskCode_Phone; 
																																																																				Phone_Hit := ut.Exists2(RIGHT.RiskCode_Phone);
																																																																				SELF.Suspicious_Phone.Phone_Hit := IF(Phone_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_Phone.Phone_Message := IF(Phone_Hit, '', Suspicious_Fraud_LN.Constants.PhoneMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_Phone.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_Phone.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_Phone.DateFirstSeenInFile := IF(Phone_Hit, cleanDate, '');
																																																																				SELF.Suspicious_Phone := RIGHT.Suspicious_Phone; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	with_SSNRisk					:= JOIN(with_PhoneRisk, SSNRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_SSN := RIGHT.RiskCode_SSN; 
																																																																				SSN_Hit := ut.Exists2(RIGHT.RiskCode_SSN);
																																																																				SELF.Suspicious_SSN.SSN_Hit := IF(SSN_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_SSN.SSN_Message := IF(SSN_Hit, '', Suspicious_Fraud_LN.Constants.SSNMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_SSN.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_SSN.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_SSN.DateFirstSeenInFile := IF(SSN_Hit, cleanDate, '');
																																																																				SELF.Suspicious_SSN := RIGHT.Suspicious_SSN; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	with_CombinationRisk	:= JOIN(with_SSNRisk, CombinationRisk, LEFT.seq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.RiskCode_Combination := RIGHT.RiskCode_Combination; 
																																																																				Combination_Hit := ut.Exists2(RIGHT.RiskCode_Combination);
																																																																				SELF.Suspicious_Combination.Combination_Search_Hit := IF(Combination_Hit, 'Y', 'N');
																																																																				SELF.Suspicious_Combination.Combination_Search_Message := IF(Combination_Hit, '', Suspicious_Fraud_LN.Constants.CombinationMessage);
																																																																				todaysDate := IF(LEFT.Clean_Input.ArchiveDate = 999999, (STRING8)Std.Date.Today(), ((STRING)LEFT.Clean_Input.ArchiveDate)[1..6] + '01');
																																																																				validDate := Doxie.DOBTools((UNSIGNED)RIGHT.Suspicious_Combination.DateFirstSeenInFile).IsValidDOB;
																																																																				cleanDate := IF(validDate, RIGHT.Suspicious_Combination.DateFirstSeenInFile, todaysDate);
																																																																				SELF.Suspicious_Combination.DateFirstSeenInFile := IF(Combination_Hit, cleanDate, '');
																																																																				SELF.Suspicious_Combination := RIGHT.Suspicious_Combination; 
																																																																				SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	Result								:= with_CombinationRisk;
	
	/* ************************************************
	 * Copy the results for all duplicate inputs so   *
	 * that every original input record has an output *
	 * record - Return the Final Results
	 **************************************************/
	FinalResult := SORT(JOIN(seqMap, Result, LEFT.DedupedSeq = RIGHT.seq, TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus, SELF.Seq := LEFT.Seq; SELF.Input_Echo.AcctNo := LEFT.AccountNumber; SELF.Clean_Input.AccountNumber := LEFT.AccountNumber; SELF := RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost)), Seq);
	
	/* ************************************************
	 * DEBUGGING SECTION - COMMENT OUT FOR PRODUCTION *
	 **************************************************/
	// eyeball := 100;
	// OUTPUT(CHOOSEN(Batch_In, eyeball), NAMED('Batch_In'));
	// OUTPUT(CHOOSEN(cleanedInput, eyeball), NAMED('cleanedInput'));
	// OUTPUT(CHOOSEN(cleanedInputDeduped, eyeball), NAMED('cleanedInputDeduped'));
	// OUTPUT(CHOOSEN(seqMap, eyeball), NAMED('seqMap'));
	// OUTPUT(CHOOSEN(with_DID, eyeball), NAMED('with_DID'));
	// OUTPUT(CHOOSEN(AddressInquiries, eyeball), NAMED('AddressInquiries'));
	// OUTPUT(CHOOSEN(EmailInquiries, eyeball), NAMED('EmailInquiries'));
	// OUTPUT(CHOOSEN(IPAddressInquiries, eyeball), NAMED('IPAddressInquiries'));
	// OUTPUT(CHOOSEN(NameInquiries, eyeball), NAMED('NameInquiries'));
	// OUTPUT(CHOOSEN(PhoneInquiries, eyeball), NAMED('PhoneInquiries'));
	// OUTPUT(CHOOSEN(SSNInquiries, eyeball), NAMED('SSNInquiries'));
	// OUTPUT(CHOOSEN(AddressRisk, eyeball), NAMED('AddressRisk'));
	// OUTPUT(CHOOSEN(EmailRisk, eyeball), NAMED('EmailRisk'));
	// OUTPUT(CHOOSEN(IPAddressRisk, eyeball), NAMED('IPAddressRisk'));
	// OUTPUT(CHOOSEN(NameRisk, eyeball), NAMED('NameRisk'));
	// OUTPUT(CHOOSEN(PhoneRisk, eyeball), NAMED('PhoneRisk'));
	// OUTPUT(CHOOSEN(SSNRisk, eyeball), NAMED('SSNRisk'));
	// OUTPUT(CHOOSEN(CombinationRisk, eyeball), NAMED('CombinationRisk'));
	// OUTPUT(CHOOSEN(with_AddressRisk, eyeball), NAMED('with_AddressRisk'));
	// OUTPUT(CHOOSEN(with_EmailRisk, eyeball), NAMED('with_EmailRisk'));
	// OUTPUT(CHOOSEN(with_IPAddressRisk, eyeball), NAMED('with_IPAddressRisk'));
	// OUTPUT(CHOOSEN(with_NameRisk, eyeball), NAMED('with_NameRisk'));
	// OUTPUT(CHOOSEN(with_PhoneRisk, eyeball), NAMED('with_PhoneRisk'));
	// OUTPUT(CHOOSEN(with_SSNRisk, eyeball), NAMED('with_SSNRisk'));
	// OUTPUT(CHOOSEN(with_CombinationRisk, eyeball), NAMED('with_CombinationRisk'));
	// OUTPUT(CHOOSEN(Result, eyeball), NAMED('Result'));
	// OUTPUT(CHOOSEN(FinalResult, eyeball), NAMED('FinalResult'));
	/* ************************************************
	 *           END OF DEBUGGING SECTION             *
	 **************************************************/
	 
	RETURN FinalResult;
END;