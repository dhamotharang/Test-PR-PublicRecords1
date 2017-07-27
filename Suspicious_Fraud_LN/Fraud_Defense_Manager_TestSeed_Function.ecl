IMPORT Models, Risk_Indicators, RiskWise, Seed_Files, Suspicious_Fraud_LN, UT;

EXPORT Fraud_Defense_Manager_TestSeed_Function (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_In) Input,
																								 STRING32 TestDataTableName = '') := FUNCTION
																								 
	AddressKey			:= Seed_Files.Key_IdentityFraudNetwork_Address; // Keyed: TestDataTableName, StreetAddress1, Zip5
	EmailKey				:= Seed_Files.Key_IdentityFraudNetwork_Email; // Keyed TestDataTableName, Email
	IPAddressKey		:= Seed_Files.Key_IdentityFraudNetwork_IPAddress; // Keyed TestDataTableName, IPAddress
	NameKey					:= Seed_Files.Key_IdentityFraudNetwork_Name; // Keyed TestDataTableName, LastName, FirstName
	PhoneKey				:= Seed_Files.Key_IdentityFraudNetwork_Phone; // Keyed TestDataTableName, Phone10
	SSNKey					:= Seed_Files.Key_IdentityFraudNetwork_SSN; // Keyed TestDataTableName, SSN
	CombinationKey	:= Seed_Files.Key_IdentityFraudNetwork_Combination; // Keyed TestDataTableName, LastName, FirstName, StreetAddress1, Zip5, Phone10, SSN, Email, IPAddress
	
	/* ****************************************************************************
   *   In order to provide the full test seed result we need to join to several *
   * testseed keys and combine them to produce our final test seed record.      *
   ******************************************************************************
   *                     Gather ADDRESS Test Seed Data                          *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getAddress(Suspicious_Fraud_LN.layouts.Layout_Batch_In le, AddressKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																		:= TRIM(ri.AddressRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp												:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset														:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit																:= RiskCodes <> '';
		SELF.Suspicious_Address.Address_Hit					:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_Address.Address_Message			:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.AddressMessage);
		SELF.Suspicious_Address.Data_Source					:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_Address.DateFirstSeenInFile	:= IF(RiskCodesHit, ri.AddressDateFirstSeen, '');
		SELF.Suspicious_Address.InquiryCount				:= IF(RiskCodesHit, ri.AddressInquiryCount, 0);
		SELF.Suspicious_Address.InquiryCountHour		:= IF(RiskCodesHit, ri.AddressInquiryCountHour, 0);
		SELF.Suspicious_Address.InquiryCountDay			:= IF(RiskCodesHit, ri.AddressInquiryCountDay, 0);
		SELF.Suspicious_Address.InquiryCountWeek		:= IF(RiskCodesHit, ri.AddressInquiryCountWeek, 0);
		SELF.Suspicious_Address.InquiryCountMonth		:= IF(RiskCodesHit, ri.AddressInquiryCountMonth, 0);
		SELF.Suspicious_Address.InquiryCountYear		:= IF(RiskCodesHit, ri.AddressInquiryCountYear, 0);
		
		SELF.RiskCode_Address												:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		// Save our input for the following test seed joins
		SELF.Clean_Input														:= le;
		
		SELF																				:= le;
		SELF																				:= [];
	END;
	
	withAddress := JOIN(Input, AddressKey, LEFT.StreetAddress1 <> '' AND LEFT.Zip5 <> '' AND 
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.StreetAddress1 = RIGHT.StreetAddress1 AND
																								LEFT.Zip5 = RIGHT.Zip5), getAddress(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
																													
	
	/* ****************************************************************************
   *                      Gather EMAIL Test Seed Data                           *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getEmail(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, EmailKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																		:= TRIM(ri.EmailRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp												:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset														:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit																:= RiskCodes <> '';
		SELF.Suspicious_Email.Email_Hit							:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_Email.Email_Message					:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.EmailMessage);
		SELF.Suspicious_Email.Data_Source						:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_Email.DateFirstSeenInFile		:= IF(RiskCodesHit, ri.EmailDateFirstSeen, '');
		SELF.Suspicious_Email.InquiryCount					:= IF(RiskCodesHit, ri.EmailInquiryCount, 0);
		SELF.Suspicious_Email.InquiryCountHour			:= IF(RiskCodesHit, ri.EmailInquiryCountHour, 0);
		SELF.Suspicious_Email.InquiryCountDay				:= IF(RiskCodesHit, ri.EmailInquiryCountDay, 0);
		SELF.Suspicious_Email.InquiryCountWeek			:= IF(RiskCodesHit, ri.EmailInquiryCountWeek, 0);
		SELF.Suspicious_Email.InquiryCountMonth			:= IF(RiskCodesHit, ri.EmailInquiryCountMonth, 0);
		SELF.Suspicious_Email.InquiryCountYear			:= IF(RiskCodesHit, ri.EmailInquiryCountYear, 0);
		
		SELF.RiskCode_Email													:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		SELF																				:= le;
	END;
	
	withEmail := JOIN(withAddress, EmailKey, LEFT.Clean_Input.Email <> '' AND  
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.Clean_Input.Email = RIGHT.Email), 
																					getEmail(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	/* ****************************************************************************
   *                    Gather IPADDRESS Test Seed Data                         *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getIPAddress(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, IPAddressKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																				:= TRIM(ri.IPAddressRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp														:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset																:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit																		:= RiskCodes <> '';
		SELF.Suspicious_IPAddress.IPAddress_Hit					:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_IPAddress.IPAddress_Message			:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.IPAddressMessage);
		SELF.Suspicious_IPAddress.Data_Source						:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_IPAddress.DateFirstSeenInFile		:= IF(RiskCodesHit, ri.IPAddressDateFirstSeen, '');
		SELF.Suspicious_IPAddress.InquiryCount					:= IF(RiskCodesHit, ri.IPAddressInquiryCount, 0);
		SELF.Suspicious_IPAddress.InquiryCountHour			:= IF(RiskCodesHit, ri.IPAddressInquiryCountHour, 0);
		SELF.Suspicious_IPAddress.InquiryCountDay				:= IF(RiskCodesHit, ri.IPAddressInquiryCountDay, 0);
		SELF.Suspicious_IPAddress.InquiryCountWeek			:= IF(RiskCodesHit, ri.IPAddressInquiryCountWeek, 0);
		SELF.Suspicious_IPAddress.InquiryCountMonth			:= IF(RiskCodesHit, ri.IPAddressInquiryCountMonth, 0);
		SELF.Suspicious_IPAddress.InquiryCountYear			:= IF(RiskCodesHit, ri.IPAddressInquiryCountYear, 0);
		
		SELF.RiskCode_IPAddress													:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		SELF																						:= le;
	END;
	
	withIPAddress := JOIN(withEmail, IPAddressKey, LEFT.Clean_Input.IPAddress <> '' AND  
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.Clean_Input.IPAddress = RIGHT.IPAddress), 
																					getIPAddress(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	/* ****************************************************************************
   *                       Gather NAME Test Seed Data                           *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getName(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, NameKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																	:= TRIM(ri.NameRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp											:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset													:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit															:= RiskCodes <> '';
		SELF.Suspicious_Name.Name_Hit							:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_Name.Name_Message					:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.NameMessage);
		SELF.Suspicious_Name.Data_Source					:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_Name.DateFirstSeenInFile	:= IF(RiskCodesHit, ri.NameDateFirstSeen, '');
		SELF.Suspicious_Name.InquiryCount					:= IF(RiskCodesHit, ri.NameInquiryCount, 0);
		SELF.Suspicious_Name.InquiryCountHour			:= IF(RiskCodesHit, ri.NameInquiryCountHour, 0);
		SELF.Suspicious_Name.InquiryCountDay			:= IF(RiskCodesHit, ri.NameInquiryCountDay, 0);
		SELF.Suspicious_Name.InquiryCountWeek			:= IF(RiskCodesHit, ri.NameInquiryCountWeek, 0);
		SELF.Suspicious_Name.InquiryCountMonth		:= IF(RiskCodesHit, ri.NameInquiryCountMonth, 0);
		SELF.Suspicious_Name.InquiryCountYear			:= IF(RiskCodesHit, ri.NameInquiryCountYear, 0);
		
		SELF.RiskCode_Name												:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		SELF																			:= le;
	END;
	
	withName := JOIN(withIPAddress, NameKey, LEFT.Clean_Input.FirstName <> '' AND LEFT.Clean_Input.LastName <> '' AND
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.Clean_Input.LastName = RIGHT.LastName AND LEFT.Clean_Input.FirstName = RIGHT.FirstName), 
																					getName(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	/* ****************************************************************************
   *                      Gather PHONE Test Seed Data                           *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getPhone(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, PhoneKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																	:= TRIM(ri.PhoneRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp											:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset													:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit															:= RiskCodes <> '';
		SELF.Suspicious_Phone.Phone_Hit						:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_Phone.Phone_Message				:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.PhoneMessage);
		SELF.Suspicious_Phone.Data_Source					:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_Phone.DateFirstSeenInFile	:= IF(RiskCodesHit, ri.PhoneDateFirstSeen, '');
		SELF.Suspicious_Phone.InquiryCount				:= IF(RiskCodesHit, ri.PhoneInquiryCount, 0);
		SELF.Suspicious_Phone.InquiryCountHour		:= IF(RiskCodesHit, ri.PhoneInquiryCountHour, 0);
		SELF.Suspicious_Phone.InquiryCountDay			:= IF(RiskCodesHit, ri.PhoneInquiryCountDay, 0);
		SELF.Suspicious_Phone.InquiryCountWeek		:= IF(RiskCodesHit, ri.PhoneInquiryCountWeek, 0);
		SELF.Suspicious_Phone.InquiryCountMonth		:= IF(RiskCodesHit, ri.PhoneInquiryCountMonth, 0);
		SELF.Suspicious_Phone.InquiryCountYear		:= IF(RiskCodesHit, ri.PhoneInquiryCountYear, 0);
		
		SELF.RiskCode_Phone												:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		SELF																			:= le;
	END;
	
	withPhone := JOIN(withName, PhoneKey, LEFT.Clean_Input.Phone10 <> '' AND 
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.Clean_Input.Phone10 = RIGHT.Phone10), 
																					getPhone(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	/* ****************************************************************************
   *                       Gather SSN Test Seed Data                            *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getSSN(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, SSNKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																:= TRIM(ri.SSNRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp										:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset												:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit														:= RiskCodes <> '';
		SELF.Suspicious_SSN.SSN_Hit							:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_SSN.SSN_Message					:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.SSNMessage);
		SELF.Suspicious_SSN.Data_Source					:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_SSN.DateFirstSeenInFile	:= IF(RiskCodesHit, ri.SSNDateFirstSeen, '');
		SELF.Suspicious_SSN.InquiryCount				:= IF(RiskCodesHit, ri.SSNInquiryCount, 0);
		SELF.Suspicious_SSN.InquiryCountHour		:= IF(RiskCodesHit, ri.SSNInquiryCountHour, 0);
		SELF.Suspicious_SSN.InquiryCountDay			:= IF(RiskCodesHit, ri.SSNInquiryCountDay, 0);
		SELF.Suspicious_SSN.InquiryCountWeek		:= IF(RiskCodesHit, ri.SSNInquiryCountWeek, 0);
		SELF.Suspicious_SSN.InquiryCountMonth		:= IF(RiskCodesHit, ri.SSNInquiryCountMonth, 0);
		SELF.Suspicious_SSN.InquiryCountYear		:= IF(RiskCodesHit, ri.SSNInquiryCountYear, 0);
		
		SELF.RiskCode_SSN												:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		SELF																		:= le;
	END;
	
	withSSN := JOIN(withPhone, SSNKey, LEFT.Clean_Input.SSN <> '' AND 
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.Clean_Input.SSN = RIGHT.SSN), 
																					getSSN(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	/* ****************************************************************************
   *                   Gather COMBINATION Test Seed Data                        *
   **************************************************************************** */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getCombination(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, CombinationKey ri) := TRANSFORM
		// Gather Delimited list of Risk Codes from testseeds
		RiskCodes																				:= TRIM(ri.CombinationRiskCodes);
		// Generate a Dataset from that delimited list for use in XML
		RiskCodesDatasetTemp														:= Suspicious_Fraud_LN.Common.fromDelimited(RiskCodes, ',');
		RiskCodesDataset																:= PROJECT(RiskCodesDatasetTemp, TRANSFORM(Suspicious_Fraud_LN.Layouts.Risk_Indicators, SELF.SuspiciousRiskCode := LEFT.fieldValues;
																																																																				SELF.SuspiciousRiskIndicator :=  Suspicious_Fraud_LN.getSusCodeDesc(LEFT.fieldValues)));
		
		RiskCodesHit																		:= RiskCodes <> '';
		SELF.Suspicious_Combination.Combination_Search_Hit			:= IF(RiskCodesHit, 'Y', 'N');
		SELF.Suspicious_Combination.Combination_Search_Message	:= IF(RiskCodesHit, '', Suspicious_Fraud_LN.Constants.CombinationMessage);
		SELF.Suspicious_Combination.Data_Source					:= If(RiskCodesHit, Suspicious_Fraud_LN.Constants.DefaultDataSource, '');
		SELF.Suspicious_Combination.DateFirstSeenInFile	:= IF(RiskCodesHit, ri.CombinationDateFirstSeen, '');
		SELF.Suspicious_Combination.InquiryCount				:= IF(RiskCodesHit, ri.CombinationInquiryCount, 0);
		SELF.Suspicious_Combination.InquiryCountHour		:= IF(RiskCodesHit, ri.CombinationInquiryCountHour, 0);
		SELF.Suspicious_Combination.InquiryCountDay			:= IF(RiskCodesHit, ri.CombinationInquiryCountDay, 0);
		SELF.Suspicious_Combination.InquiryCountWeek		:= IF(RiskCodesHit, ri.CombinationInquiryCountWeek, 0);
		SELF.Suspicious_Combination.InquiryCountMonth		:= IF(RiskCodesHit, ri.CombinationInquiryCountMonth, 0);
		SELF.Suspicious_Combination.InquiryCountYear		:= IF(RiskCodesHit, ri.CombinationInquiryCountYear, 0);
		
		SELF.RiskCode_Combination												:= IF(RiskCodesHit, RiskCodesDataset, DATASET([], Suspicious_Fraud_LN.Layouts.Risk_Indicators));
		
		SELF																						:= le;
	END;
	
	withCombination := JOIN(withSSN, CombinationKey,  
																					KEYED(TestDataTableName = RIGHT.TestDataTableName AND LEFT.Clean_Input.LastName = RIGHT.LastName AND
																					LEFT.Clean_Input.FirstName = RIGHT.FirstName AND LEFT.Clean_Input.StreetAddress1 = RIGHT.StreetAddress1 AND 
																					LEFT.Clean_Input.Zip5 = RIGHT.Zip5 AND LEFT.Clean_Input.Phone10 = RIGHT.Phone10 AND LEFT.Clean_Input.SSN = RIGHT.SSN AND
																					LEFT.Clean_Input.Email = RIGHT.Email AND LEFT.Clean_Input.IPAddress = RIGHT.IPAddress), 
																					getCombination(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
  /* ****************************************************************************
   *            All test seed data gathered, return the Layout_Batch_Plus       *
   **************************************************************************** */
	RETURN(withCombination);
END;