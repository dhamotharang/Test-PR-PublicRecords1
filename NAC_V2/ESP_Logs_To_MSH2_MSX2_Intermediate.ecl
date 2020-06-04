export ESP_Logs_To_MSH2_MSX2_Intermediate(dataset(ESP_Logs_Layouts.TransactionLogsCombined) pLogsCombined) :=
module

	//////////////////////////////////////////////////////////////////
	shared	rIntermediateMatchInnerHistory	:=
	record
		string20		CaseIdentifier;
		string1			StatusIndicator;
		string8			PeriodStart;
		string8			PeriodEnd;
		string6			PeriodCountDays;
		string4			PeriodCountMonths;
		string10		Matchcode;
		string4			LexIDScore;
	end;

	//////////////////////////////////////////////////////////////////
	shared	rIntermediateResultRecord	:=
	record
		string4			NAC2Record_NacGroupId;

		string30		NAC2Record_Case_LastName;
		string25		NAC2Record_Case_FirstName;
		string25		NAC2Record_Case_MiddleName;
		string5			NAC2Record_Case_SuffixName;
		string20		NAC2Record_Case_CaseIdentifier;
		string2			NAC2Record_Case_ProgramState;
		string1			NAC2Record_Case_ProgramCode;
		string10		NAC2Record_Case_Phone1;
		string10		NAC2Record_Case_Phone2;
		string256		NAC2Record_Case_Email;
		string70		NAC2Record_Case_PhysicalAddress_StreetAddress1;
		string70		NAC2Record_Case_PhysicalAddress_StreetAddress2;
		string30		NAC2Record_Case_PhysicalAddress_City;
		string2			NAC2Record_Case_PhysicalAddress_State;
		string9			NAC2Record_Case_PhysicalAddress_Zip;
		string1			NAC2Record_Case_PhysicalAddress_AddressCategory;
		string70		NAC2Record_Case_MailingAddress_StreetAddress1;
		string70		NAC2Record_Case_MailingAddress_StreetAddress2;
		string30		NAC2Record_Case_MailingAddress_City;
		string2			NAC2Record_Case_MailingAddress_State;
		string9			NAC2Record_Case_MailingAddress_Zip;
		string1			NAC2Record_Case_MailingAddress_AddressCategory;
		string3			NAC2Record_Case_CountyParishCode;
		string25		NAC2Record_Case_CountyParishName;
		string10		NAC2Record_Case_MonthlyAllotment;
		string3			NAC2Record_Case_RegionCode;

		string30		NAC2Record_Client_LastName;
		string25		NAC2Record_Client_FirstName;
		string25		NAC2Record_Client_MiddleName;
		string5			NAC2Record_Client_SuffixName;
		string20		NAC2Record_Client_ClientIdentifier;
		string1			NAC2Record_Client_Gender;
		string1			NAC2Record_Client_Race;
		string1			NAC2Record_Client_Ethnicity;
		string10		NAC2Record_Client_Phone;
		string256		NAC2Record_Client_Email;
		string9			NAC2Record_Client_SSN;
		string1			NAC2Record_Client_SSNTypeIndicator;
		string8			NAC2Record_Client_DOB;
		string1			NAC2Record_Client_DOBTypeIndicator;
		string10		NAC2Record_Client_MonthlyAllotment;
		string1			NAC2Record_Client_HOHIndicator;
		string1			NAC2Record_Client_ABAWDIndicator;
		string1			NAC2Record_Client_RelationshipIndicator;
		string20		NAC2Record_Client_CertificateIDType;
		string5			NAC2Record_Client_HistoricalBenefitCount;
		string3			NAC2Record_Client_Exception_ReasonCode;
		string50		NAC2Record_Client_Exception_Comment;

		string50		NAC2Record_StateContact_Name;
		string10		NAC2Record_StateContact_Phone;
		string10		NAC2Record_StateContact_PhoneExtension;
		string256		NAC2Record_StateContact_Email;

		string1			NAC2Record_Eligibility_StatusIndicator;
		string8			NAC2Record_Eligibility_StatusDate;
		string1			NAC2Record_Eligibility_PeriodType;
		string8			NAC2Record_Eligibility_PeriodStart;
		string8			NAC2Record_Eligibility_PeriodEnd;
		string6			NAC2Record_Eligibility_PeriodCountDays;						// Internal					
		string4			NAC2Record_Eligibility_PeriodCountMonths;					// Internal

		string8			NAC2Record_InvestigativeHistory_EarliestStart;
		string8			NAC2Record_InvestigativeHistory_LatestEnd;
		string5			NAC2Record_InvestigativeHistory_TotalRecords;

		string6			NAC2Record_MatchHistory_TotalEligiblePeriodCountDays;
		string4			NAC2Record_MatchHistory_TotalEligiblePeriodCountMonths;
		dataset(rIntermediateMatchInnerHistory) NAC2Record_MatchHistory_MatchInnerHistories{maxcount(60)};
		
		string10		NAC2Record_MatchCode;
		unsigned2		NAC2Record_LexIDScore;
		unsigned4		NAC2Record_SequenceNumber;
		unsigned6		NAC2Record_LexID;																	// Internal
		unsigned2		NAC2Record_Penalty;																// Internal
	end;

	//////////////////////////////////////////////////////////////////
	shared	rIntermediate	:=
	record
		string16		TransactionID;
		string19		DateAdded;
		decimal5_2	ResponseTime;																				// Internal
		string20		UserID;
		string20		UserIP;
		string20		EndUserLoginID;
		string20		EndUserIP;
		string30		ServiceName;																				// Internal
		string20		User_BillingCode;
		string15		User_IP;
		boolean			User_TestDataEnabled;																// Internal
		string32		User_TestDataTableName;															// Internal

		boolean			Options_InvestigativePurpose;
		boolean			Options_IncludeEligibilityHistory;
		boolean			Options_IncludeInterstateAllPrograms;
		boolean			Options_IsOnline;																		// Internal
		boolean			Options_ProdDataTestMode;														// Internal, not in ECL definitions
		boolean			Options_Encrypt;																		// Internal, not in ECL definitions

		string20		EndUser_LoginID;
		string15		EndUser_IP;
		string20		EndUser_UserName;

		string20		WsUser_LoginID;
		string15		WsUser_IP;
		string20		WsUser_ActivityType;

		string2			SearchBy_SourceState;																// Internal
		string32		SearchBy_ProgramsAllowedSearch;											// Internal
		string32		SearchBy_ProgramsAllowedReturn;											// Internal
		string4			SearchBy_NacGroupID;																// Internal

		string30		SearchBy_Identity_LastName;
		string25		SearchBy_Identity_FirstName;
		string25		SearchBy_Identity_MiddleName;
		string5			SearchBy_Identity_SuffixName;
		string60		SearchBy_Identity_FullName;
		string70		SearchBy_Identity_Address1_StreetAddress1;
		string70		SearchBy_Identity_Address1_StreetAddress2;
		string30		SearchBy_Identity_Address1_City;
		string2			SearchBy_Identity_Address1_State;
		string9			SearchBy_Identity_Address1_Zip;
		string70		SearchBy_Identity_Address2_StreetAddress1;
		string70		SearchBy_Identity_Address2_StreetAddress2;
		string30		SearchBy_Identity_Address2_City;
		string2			SearchBy_Identity_Address2_State;
		string9			SearchBy_Identity_Address2_Zip;
		string9			SearchBy_Identity_SSN;
		string8			SearchBy_Identity_DOB;
		string1			SearchBy_Identity_ProgramCode;
		string1			SearchBy_Identity_EligibilityRangeType;
		string8			SearchBy_Identity_EligibilityStart;
		string8			SearchBy_Identity_EligibilityEnd;
		string20		SearchBy_Identity_CaseIdentifier;
		string20		SearchBy_Identity_ClientIdentifier;

		string2			SearchBy_InvestigativeFields_ProgramState;
		string1			SearchBy_InvestigativeFields_EligibilityStatus;

		integer8		Response_Header_Status;
		string70		Response_Header_Message;
		integer8		Response_Header_Exceptions_Code;
		string70		Response_Header_Exceptions_Message;
		integer8		Response_RecordCount;																// Internal
		dataset(rIntermediateResultRecord) Response_Records;
	end;

	//////////////////////////////////////////////////////////////////
	rIntermediateMatchInnerHistory tIntermediateMatchInnerHistory(ESP_Logs_Layouts.t_NAC2MatchInnerHistory pInput)	:=
	transform
		self.CaseIdentifier						:=	pInput.CaseIdentifier;
		self.StatusIndicator					:=	pInput.StatusIndicator;
		self.PeriodStart							:=	pInput.PeriodStart;
		self.PeriodEnd								:=	pInput.PeriodEnd;
		self.PeriodCountDays					:=	pInput.PeriodCountDays;
		self.PeriodCountMonths				:=	pInput.PeriodCountMonths;
		self.Matchcode								:=	pInput.Matchcode;
		self.LexIDScore								:=	pInput.LexIDScore;
	end;

	//////////////////////////////////////////////////////////////////
	rIntermediateResultRecord	tIntermediateResultRecord(ESP_Logs_Layouts.t_NAC2SearchResultRecord pInput)	:=
	transform
		self.NAC2Record_NACGroupId																	:=	pInput.NAC2Record.NACGroupID;

		self.NAC2Record_Case_LastName																:=	pInput.NAC2Record.Case_.LastName;
		self.NAC2Record_Case_FirstName															:=	pInput.NAC2Record.Case_.FirstName;
		self.NAC2Record_Case_MiddleName															:=	pInput.NAC2Record.Case_.MiddleName;
		self.NAC2Record_Case_SuffixName															:=	pInput.NAC2Record.Case_.SuffixName;
		self.NAC2Record_Case_CaseIdentifier													:=	pInput.NAC2Record.Case_.CaseIdentifier;
		self.NAC2Record_Case_ProgramState														:=	pInput.NAC2Record.Case_.ProgramState;
		self.NAC2Record_Case_ProgramCode														:=	pInput.NAC2Record.Case_.ProgramCode;
		self.NAC2Record_Case_Phone1																	:=	pInput.NAC2Record.Case_.Phone1;
		self.NAC2Record_Case_Phone2																	:=	pInput.NAC2Record.Case_.Phone2;
		self.NAC2Record_Case_Email																	:=	pInput.NAC2Record.Case_.Email;
		self.NAC2Record_Case_PhysicalAddress_StreetAddress1					:=	pInput.NAC2Record.Case_.PhysicalAddress.StreetAddress1;
		self.NAC2Record_Case_PhysicalAddress_StreetAddress2					:=	pInput.NAC2Record.Case_.PhysicalAddress.StreetAddress2;
		self.NAC2Record_Case_PhysicalAddress_City										:=	pInput.NAC2Record.Case_.PhysicalAddress.City;
		self.NAC2Record_Case_PhysicalAddress_State									:=	pInput.NAC2Record.Case_.PhysicalAddress.State;
		self.NAC2Record_Case_PhysicalAddress_Zip										:=	pInput.NAC2Record.Case_.PhysicalAddress.Zip;
		self.NAC2Record_Case_PhysicalAddress_AddressCategory				:=	pInput.NAC2Record.Case_.PhysicalAddress.AddressCategory;
		self.NAC2Record_Case_MailingAddress_StreetAddress1					:=	pInput.NAC2Record.Case_.MailingAddress.StreetAddress1;
		self.NAC2Record_Case_MailingAddress_StreetAddress2					:=	pInput.NAC2Record.Case_.MailingAddress.StreetAddress2;
		self.NAC2Record_Case_MailingAddress_City										:=	pInput.NAC2Record.Case_.MailingAddress.City;
		self.NAC2Record_Case_MailingAddress_State										:=	pInput.NAC2Record.Case_.MailingAddress.State;
		self.NAC2Record_Case_MailingAddress_Zip											:=	pInput.NAC2Record.Case_.MailingAddress.Zip;
		self.NAC2Record_Case_MailingAddress_AddressCategory					:=	pInput.NAC2Record.Case_.MailingAddress.AddressCategory;
		self.NAC2Record_Case_CountyParishCode												:=	pInput.NAC2Record.Case_.CountyParishCode;
		self.NAC2Record_Case_CountyParishName												:=	pInput.NAC2Record.Case_.CountyParishName;
		self.NAC2Record_Case_MonthlyAllotment												:=	pInput.NAC2Record.Case_.MonthlyAllotment;
		self.NAC2Record_Case_RegionCode															:=	pInput.NAC2Record.Case_.RegionCode;

		self.NAC2Record_Client_LastName															:=	pInput.NAC2Record.Client.LastName;
		self.NAC2Record_Client_FirstName														:=	pInput.NAC2Record.Client.FirstName;
		self.NAC2Record_Client_MiddleName														:=	pInput.NAC2Record.Client.MiddleName;
		self.NAC2Record_Client_SuffixName														:=	pInput.NAC2Record.Client.SuffixName;
		self.NAC2Record_Client_ClientIdentifier											:=	pInput.NAC2Record.Client.ClientIdentifier;
		self.NAC2Record_Client_Gender																:=	pInput.NAC2Record.Client.Gender;
		self.NAC2Record_Client_Race																	:=	pInput.NAC2Record.Client.Race;
		self.NAC2Record_Client_Ethnicity														:=	pInput.NAC2Record.Client.Ethnicity;
		self.NAC2Record_Client_Phone																:=	pInput.NAC2Record.Client.Phone;
		self.NAC2Record_Client_Email																:=	pInput.NAC2Record.Client.Email;
		self.NAC2Record_Client_SSN																	:=	pInput.NAC2Record.Client.SSN;
		self.NAC2Record_Client_SSNTypeIndicator											:=	pInput.NAC2Record.Client.SSNTypeIndicator;
		self.NAC2Record_Client_DOB																	:=	pInput.NAC2Record.Client.DOB;
		self.NAC2Record_Client_DOBTypeIndicator											:=	pInput.NAC2Record.Client.DOBTypeIndicator;
		self.NAC2Record_Client_MonthlyAllotment											:=	pInput.NAC2Record.Client.MonthlyAllotment;
		self.NAC2Record_Client_HOHIndicator													:=	pInput.NAC2Record.Client.HOHIndicator;
		self.NAC2Record_Client_ABAWDIndicator												:=	pInput.NAC2Record.Client.ABAWDIndicator;
		self.NAC2Record_Client_RelationshipIndicator								:=	pInput.NAC2Record.Client.RelationshipIndicator;
		self.NAC2Record_Client_CertificateIDType										:=	pInput.NAC2Record.Client.CertificateIDType;
		self.NAC2Record_Client_HistoricalBenefitCount								:=	pInput.NAC2Record.Client.HistoricalBenefitCount;
		self.NAC2Record_Client_Exception_ReasonCode									:=	pInput.NAC2Record.Client.Exception.ReasonCode;
		self.NAC2Record_Client_Exception_Comment										:=	pInput.NAC2Record.Client.Exception.Comment;

		self.NAC2Record_StateContact_Name														:=	pInput.NAC2Record.StateContact.Name;
		self.NAC2Record_StateContact_Phone													:=	pInput.NAC2Record.StateContact.Phone;
		self.NAC2Record_StateContact_PhoneExtension									:=	pInput.NAC2Record.StateContact.PhoneExtension;
		self.NAC2Record_StateContact_Email													:=	pInput.NAC2Record.StateContact.Email;

		self.NAC2Record_Eligibility_StatusIndicator									:=	pInput.NAC2Record.Eligibility.StatusIndicator;
		self.NAC2Record_Eligibility_StatusDate											:=	pInput.NAC2Record.Eligibility.StatusDate;
		self.NAC2Record_Eligibility_PeriodType											:=	pInput.NAC2Record.Eligibility.PeriodType;
		self.NAC2Record_Eligibility_PeriodStart											:=	pInput.NAC2Record.Eligibility.PeriodStart;
		self.NAC2Record_Eligibility_PeriodEnd												:=	pInput.NAC2Record.Eligibility.PeriodEnd;
		self.NAC2Record_Eligibility_PeriodCountDays									:=	pInput.NAC2Record.Eligibility.PeriodCountDays;						// Internal					
		self.NAC2Record_Eligibility_PeriodCountMonths								:=	pInput.NAC2Record.Eligibility.PeriodCountMonths;					// Internal

		self.NAC2Record_InvestigativeHistory_EarliestStart					:=	pInput.NAC2Record.InvestigativeHistory.EarliestStart;
		self.NAC2Record_InvestigativeHistory_LatestEnd							:=	pInput.NAC2Record.InvestigativeHistory.LatestEnd;
		self.NAC2Record_InvestigativeHistory_TotalRecords						:=	pInput.NAC2Record.InvestigativeHistory.TotalRecords;

		self.NAC2Record_MatchHistory_TotalEligiblePeriodCountDays		:=	pInput.NAC2Record.MatchHistory.TotalEligiblePeriodCountDays;
		self.NAC2Record_MatchHistory_TotalEligiblePeriodCountMonths	:=	pInput.NAC2Record.MatchHistory.TotalEligiblePeriodCountMonths;

		self.NAC2Record_MatchHistory_MatchInnerHistories						:=	project(pInput.NAC2Record.MatchHistory.MatchInnerHistories, tIntermediateMatchInnerHistory(left));
		
		self.NAC2Record_MatchCode																		:=	pInput.MatchCode;
		self.NAC2Record_LexIDScore																	:=	pInput.LexIDScore;
		self.NAC2Record_SequenceNumber															:=	pInput.SequenceNumber;
		self.NAC2Record_LexID																				:=	pInput._LexID;																									// Internal
		self.NAC2Record_Penalty																			:=	pInput._Penalty;																								// Internal
	end;

	//////////////////////////////////////////////////////////////////
	rIntermediate tIntermediate(ESP_Logs_Layouts.TransactionLogsCombined pInput)	:=
	transform
		self.TransactionID																	:=	pInput.LogFixed.TransactionID;
		self.DateAdded																			:=	pInput.LogFixed.DateAdded;
		self.ResponseTime																		:=	pInput.LogFixed.ResponseTime;																						// Internal
		self.UserID																					:=	pInput.LogFixed.UserID;
		self.UserIP																					:=	pInput.LogFixed.UserIP;
		self.EndUserLoginID																	:=	pInput.LogFixed.EndUserLoginID;
		self.EndUserIP																			:=	pInput.LogFixed.EndUserIP;
		self.ServiceName																		:=	pInput.LogOnlineParsed.ServiceName;

		self.User_BillingCode																:=	pInput.LogOnlineParsed.NAC2SearchRequest.User.BillingCode;
		self.User_IP																				:=	pInput.LogOnlineParsed.NAC2SearchRequest.User.IP;
		self.User_TestDataEnabled														:=	pInput.LogOnlineParsed.NAC2SearchRequest.User._TestDataEnabled;									// Internal
		self.User_TestDataTableName													:=	pInput.LogOnlineParsed.NAC2SearchRequest.User._TestDataTableName;								// Internal

		self.Options_InvestigativePurpose										:=	pInput.LogOnlineParsed.NAC2SearchRequest.Options.InvestigativePurpose;
		self.Options_IncludeEligibilityHistory							:=	pInput.LogOnlineParsed.NAC2SearchRequest.Options.IncludeEligibilityHistory;
		self.Options_IncludeInterstateAllPrograms						:=	pInput.LogOnlineParsed.NAC2SearchRequest.Options.IncludeInterstateAllPrograms;
		self.Options_IsOnline																:=	pInput.LogOnlineParsed.NAC2SearchRequest.Options._IsOnline;											// Internal
		self.Options_ProdDataTestMode												:=	pInput.LogOnlineParsed.NAC2SearchRequest.Options._ProdDataTestMode;							// Internal, not in ECL definitions
		self.Options_Encrypt																:=	pInput.LogOnlineParsed.NAC2SearchRequest.Options._Encrypt;												// Internal, not in ECL definitions

		self.EndUser_LoginID																:=	pInput.LogOnlineParsed.NAC2SearchRequest.EndUser.LoginID;
		self.EndUser_IP																			:=	pInput.LogOnlineParsed.NAC2SearchRequest.EndUser.IP;
		self.EndUser_UserName																:=	pInput.LogOnlineParsed.NAC2SearchRequest.EndUser.UserName;

		self.WsUser_LoginID																	:=	pInput.LogOnlineParsed.NAC2SearchRequest.WsUser.LoginID;
		self.WsUser_IP																			:=	pInput.LogOnlineParsed.NAC2SearchRequest.WsUser.IP;
		self.WsUser_ActivityType														:=	pInput.LogOnlineParsed.NAC2SearchRequest.WsUser._ActivityType;

		self.SearchBy_SourceState														:=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy._SourceState;									// Internal
		self.SearchBy_ProgramsAllowedSearch									:=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedSearch;				// Internal
		self.SearchBy_ProgramsAllowedReturn									:=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedReturned;			// Internal
		self.SearchBy_NacGroupID														:=	if(pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy._NACGroupID <> '',					// Internal
																															 pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy._NACGroupID,
																															 pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy._PPAGroupID
																															);

		self.SearchBy_Identity_LastName											:=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.LastName;
		self.SearchBy_Identity_FirstName                    :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.FirstName;
		self.SearchBy_Identity_MiddleName                   :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.MiddleName;
		self.SearchBy_Identity_SuffixName                   :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.SuffixName;
		self.SearchBy_Identity_FullName                     :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.FullName;
		self.SearchBy_Identity_Address1_StreetAddress1      :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address1.StreetAddress1;
		self.SearchBy_Identity_Address1_StreetAddress2      :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address1.StreetAddress2;
		self.SearchBy_Identity_Address1_City                :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address1.City;
		self.SearchBy_Identity_Address1_State               :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address1.State;
		self.SearchBy_Identity_Address1_Zip                 :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address1.Zip;
		self.SearchBy_Identity_Address2_StreetAddress1      :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address2.StreetAddress1;
		self.SearchBy_Identity_Address2_StreetAddress2      :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address2.StreetAddress2;
		self.SearchBy_Identity_Address2_City                :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address2.City;
		self.SearchBy_Identity_Address2_State               :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address2.State;
		self.SearchBy_Identity_Address2_Zip                 :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.Address2.Zip;
		self.SearchBy_Identity_SSN                          :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.SSN;
		self.SearchBy_Identity_DOB                          :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.DOB;
		self.SearchBy_Identity_ProgramCode                  :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.ProgramCode;
		self.SearchBy_Identity_EligibilityRangeType         :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.EligibilityRangeType;
		self.SearchBy_Identity_EligibilityStart             :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.EligibilityStart;
		self.SearchBy_Identity_EligibilityEnd               :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.EligibilityEnd;
		self.SearchBy_Identity_CaseIdentifier               :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.CaseIdentifier;
		self.SearchBy_Identity_ClientIdentifier             :=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.Identity.ClientIdentifier;

		self.SearchBy_InvestigativeFields_ProgramState			:=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.InvestigativeFields.ProgramState;				// Investigative
		self.SearchBy_InvestigativeFields_EligibilityStatus	:=	pInput.LogOnlineParsed.NAC2SearchRequest.SearchBy.InvestigativeFields.EligibilityStatus;		// Investigative

		self.Response_Header_Status													:=	pInput.LogOnlineParsed.NAC2SearchResponse.Response.Header_.Status;
		self.Response_Header_Message												:=	pInput.LogOnlineParsed.NAC2SearchResponse.Response.Header_.Message;
		self.Response_Header_Exceptions_Code								:=	pInput.LogOnlineParsed.NAC2SearchResponse.Response.Header_.Exceptions[1].Code;
		self.Response_Header_Exceptions_Message							:=	pInput.LogOnlineParsed.NAC2SearchResponse.Response.Header_.Exceptions[1].Message;
		self.Response_RecordCount														:=	pInput.LogOnlineParsed.NAC2SearchResponse.Response._RecordCount;														// Internal

		self.Response_Records																:=	project(pInput.LogOnlineParsed.NAC2SearchResponse.Response.Records, tIntermediateResultRecord(left));
	end;
	shared	dIntermediate			:=	project(pLogsCombined, tIntermediate(left));
	shared	dIntermediateHit	:=	dIntermediate(Response_RecordCount <> 0);
	shared	dIntermediateMiss	:=	dIntermediate(Response_RecordCount = 0);

	//////////////////////////////////////////////////////////////////
	export	rIntermediateMissFlattened	:=
	record
		rIntermediate	and not [Response_Records];
	end;

	//////////////////////////////////////////////////////////////////
	shared	rIntermediateMissFlattened	tIntermediateMissFlattened1(dIntermediateMiss pInput)	:=
	transform
		self									:=	pInput;
	end;
	export	dIntermediateMissFlattened	:=	project(dIntermediateMiss, tIntermediateMissFlattened1(left));

	//////////////////////////////////////////////////////////////////
	shared	rIntermediateFlattened1	:=
	record
		rIntermediate	and not [Response_Records];
		rIntermediateResultRecord		Response_Record;
	end;

	//////////////////////////////////////////////////////////////////
	rIntermediateFlattened1	tIntermediateHitFlattened1(dIntermediateHit pInput, rIntermediateResultRecord pChild)	:=
	transform
		self.Response_Record	:=	pChild;
		self									:=	pInput;
	end;
	shared	dIntermediateHitFlattened1	:=	normalize(dIntermediateHit, left.Response_Records,
																											tIntermediateHitFlattened1(left, right)
																										 );

	//////////////////////////////////////////////////////////////////
	export	rIntermediateHitFlattened2	:=
	record
		rIntermediateFlattened1	and not [Response_Record];
		rIntermediateResultRecord and not [nac2record_matchhistory_matchinnerhistories]  Response_Record;
		string200		NAC2Record_MatchHistory_Flattened;
	end;
	shared	rIntermediateHitFlattened2	tIntermediateHitFlattened2NoHistory(dIntermediateHitFlattened1 pInput)	:=
	transform
		self.NAC2Record_MatchHistory_Flattened	:=	'';
		self																		:=	pInput;
	end;
	shared	rIntermediateHitFlattened2	tIntermediateHitFlattened2(dIntermediateHitFlattened1 pInput, rIntermediateMatchInnerHistory pChild)	:=
	transform
		self.NAC2Record_MatchHistory_Flattened	:=	pChild.StatusIndicator + ':' + pChild.PeriodStart + '-' + pChild.PeriodEnd;
		self																		:=	pInput;
	end;
	dIntermediateHitFlattened2	:=	project(dIntermediateHitFlattened1(count(Response_Record.nac2record_matchhistory_matchinnerhistories) = 0), tIntermediateHitFlattened2NoHistory(left))
																				+		normalize(dIntermediateHitFlattened1, left.Response_Record.nac2record_matchhistory_matchinnerhistories,
																											tIntermediateHitFlattened2(left, right)
																										 );

	//////////////////////////////////////////////////////////////////
	dIntermediateHitFlattenedSorted	:=	sort(dIntermediateHitFlattened2, TransactionID, Response_Record.NAC2Record_NACGroupID, Response_Record.NAC2Record_Case_ProgramCode,
																																															Response_Record.NAC2Record_Client_ClientIdentifier, Response_Record.NAC2Record_SequenceNumber,
																																															-NAC2Record_MatchHistory_Flattened);
	rIntermediateHitFlattened2	tRollupMatchInnerHistory(dIntermediateHitFlattenedSorted pLeft, dIntermediateHitFlattenedSorted pRight)	:=
	transform
		self.NAC2Record_MatchHistory_Flattened	:=	(string19)pLeft.NAC2Record_MatchHistory_Flattened + ',' + pRight.NAC2Record_MatchHistory_Flattened;
		self																		:=	pLeft;
	end;
	export	dIntermediateHitFlattenedRolled	:=	rollup(dIntermediateHitFlattenedSorted,
																																 tRollupMatchInnerHistory(left, right),
																																 TransactionID, Response_Record.NAC2Record_NACGroupID, Response_Record.NAC2Record_Case_ProgramCode,
																																	Response_Record.NAC2Record_Client_ClientIdentifier, Response_Record.NAC2Record_SequenceNumber
																																);

end;