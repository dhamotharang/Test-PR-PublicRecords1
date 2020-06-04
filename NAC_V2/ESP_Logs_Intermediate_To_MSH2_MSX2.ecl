import Std;

export ESP_Logs_Intermediate_To_MSH2_MSX2 :=
module

	////////////////////////////////////////////////////////////////
	// shared	rMSX2PlusInternal	:=
	// record
		// string4		TargetNACGroupID;						// Internal
		// string2		SourceState;								// Internal
		// string30	ServiceName;								// Internal
		// Layouts.MSX2;
	// end;

	////////////////////////////////////////////////////////////////
	// shared	rMSH2PlusInternal :=
	// record
		// rMSX2PlusInternal;
		// Layouts.MSH2;
	// end;

	//////////////////////////////////////////////////////////////////
	shared	Layouts.MSX2PlusInternal	tMSX2PlusInternal(ESP_Logs_To_MSH2_MSX2_Intermediate(dataset([], ESP_Logs_Layouts.TransactionLogsCombined)).rIntermediateMissFlattened pInput)	:=
	transform
		self.TargetNACGroupID									:=	pInput.SearchBy_NacGroupID;		// Internal
		self.SourceState											:=	pInput.SearchBy_SourceState;	// Internal
		self.ServiceName											:=	pInput.ServiceName;						// Internal
		self.ActivityType											:=	'1';			// "1" = Interactive
		self.ActivitySource										:=	pInput.SearchBy_NacGroupID + ':' + pInput.DateAdded;
		self.NACTransactionId									:=	pInput.TransactionID;
		self.BatchRecordNumber								:=	'0000000000';
		self.RequestRecordID									:=	'';
		self.NACUserID												:=	if(pInput.User_BillingCode <> '',
																								 regexfind('(^[^@]*)', pInput.User_BillingCode, 1),
																								 if(pInput.WsUser_LoginID <> '',
																										pInput.WsUser_LoginID,
																										pInput.UserID
																									 )
																								);
		self.NACUserIP												:=	if(pInput.WsUser_IP <> '',
																										pInput.WsUser_IP,
																										pInput.UserIP
																								);
		self.EndUserID												:=	if(pInput.EndUser_LoginID <> '',
																										pInput.EndUser_LoginID,
																										pInput.EndUserLoginID
																								);
		self.EndUserIP												:=	if(pInput.EndUser_IP <> '',
																										pInput.EndUser_IP,
																										pInput.EndUserIP
																								);
		self.QueryStatus											:=	(string4)max(pInput.Response_Header_Exceptions_Code, pInput.Response_Header_Status);
		self.QueryStatusMessage								:=	if(pInput.Response_Header_Exceptions_Message <> '', pInput.Response_Header_Exceptions_Message, pInput.Response_Header_Message);
		self.SearchCaseId											:=	pInput.SearchBy_Identity_CaseIdentifier;
		self.SearchClientId										:=	pInput.SearchBy_Identity_ClientIdentifier;
		self.SearchProgramCode								:=	pInput.SearchBy_Identity_ProgramCode;
		self.SearchRangeType									:=	pInput.SearchBy_Identity_EligibilityRangeType;
		self.SearchEligibilityStart						:=	pInput.SearchBy_Identity_EligibilityStart;
		self.SearchEligibilityEnd							:=	pInput.SearchBy_Identity_EligibilityEnd;
		self.SearchFullName										:=	pInput.SearchBy_Identity_FullName;
		self.SearchLastName										:=	pInput.SearchBy_Identity_LastName;
		self.SearchFirstName									:=	pInput.SearchBy_Identity_FirstName;
		self.SearchMiddleName									:=	pInput.SearchBy_Identity_MiddleName;
		self.SearchSuffixName									:=	pInput.SearchBy_Identity_SuffixName;
		self.SearchSSN												:=	pInput.SearchBy_Identity_SSN;
		self.SearchDOB												:=	pInput.SearchBy_Identity_DOB;
		self.SearchAddress1StreetAddress1			:=	pInput.SearchBy_Identity_Address1_StreetAddress1;
		self.SearchAddress1StreetAddress2			:=	pInput.SearchBy_Identity_Address1_StreetAddress2;
		self.SearchAddress1City								:=	pInput.SearchBy_Identity_Address1_City;
		self.SearchAddress1State							:=	pInput.SearchBy_Identity_Address1_State;
		self.SearchAddress1Zip								:=	pInput.SearchBy_Identity_Address1_Zip;
		self.SearchAddress2StreetAddress1			:=	pInput.SearchBy_Identity_Address2_StreetAddress1;
		self.SearchAddress2StreetAddress2			:=	pInput.SearchBy_Identity_Address2_StreetAddress2;
		self.SearchAddress2City								:=	pInput.SearchBy_Identity_Address2_City;
		self.SearchAddress2State							:=	pInput.SearchBy_Identity_Address2_State;
		self.SearchAddress2Zip								:=	pInput.SearchBy_Identity_Address2_Zip;
		self.IncludeEligibilityHistory				:=	if(pInput.Options_IncludeEligibilityHistory, 'Y', 'N');
		self.IncludeInterstateAllPrograms			:=	if(pInput.Options_IncludeInterstateAllPrograms, 'Y', 'N');
	end;

	//////////////////////////////////////////////////////////////////
	shared	Layouts.MSH2PlusInternal	tMSH2PlusInternal(ESP_Logs_To_MSH2_MSX2_Intermediate(dataset([], ESP_Logs_Layouts.TransactionLogsCombined)).rIntermediateHitFlattened2 pInput)	:=
	transform
		self.TargetNACGroupID									:=	pInput.SearchBy_NacGroupID;
		self.SourceState											:=	pInput.SearchBy_SourceState;	// Internal
		self.ServiceName											:=	pInput.ServiceName;						// Internal
		self.ActivityType											:=	'1';			// "1" = Interactive
		self.ActivitySource										:=	pInput.SearchBy_NacGroupID + ':' + pInput.DateAdded;
		self.NACTransactionId									:=	pInput.TransactionID;
		self.BatchRecordNumber								:=	'0000000000';
		self.RequestRecordID									:=	'';
		self.NACUserID												:=	if(pInput.User_BillingCode <> '',
																								 regexfind('(^[^@]*)', pInput.User_BillingCode, 1),
																								 if(pInput.WsUser_LoginID <> '',
																										pInput.WsUser_LoginID,
																										pInput.UserID
																									 )
																								);
		self.NACUserIP												:=	if(pInput.WsUser_IP <> '',
																										pInput.WsUser_IP,
																										pInput.UserIP
																								);
		self.EndUserID												:=	if(pInput.EndUser_LoginID <> '',
																										pInput.EndUser_LoginID,
																										pInput.EndUserLoginID
																								);
		self.EndUserIP												:=	if(pInput.EndUser_IP <> '',
																										pInput.EndUser_IP,
																										pInput.EndUserIP
																								);
		self.QueryStatus											:=	(string4)max(pInput.Response_Header_Exceptions_Code, pInput.Response_Header_Status);
		self.QueryStatusMessage								:=	if(pInput.Response_Header_Exceptions_Message <> '', pInput.Response_Header_Exceptions_Message, pInput.Response_Header_Message);
/*
		self.QueryStatusMessage								:=	if(pInput.Response_Header_Exceptions_Message <> '',
																								 pInput.Response_Header_Exceptions_Message,
																								 if(pInput.Response_Header_Status = 0,
																										'Success',
																										pInput.Response_Header_Message
																									 )
																								);
*/
		self.SearchCaseId											:=	pInput.SearchBy_Identity_CaseIdentifier;
		self.SearchClientId										:=	pInput.SearchBy_Identity_ClientIdentifier;
		self.SearchProgramCode								:=	pInput.SearchBy_Identity_ProgramCode;
		self.SearchRangeType									:=	pInput.SearchBy_Identity_EligibilityRangeType;
		self.SearchEligibilityStart						:=	pInput.SearchBy_Identity_EligibilityStart;
		self.SearchEligibilityEnd							:=	pInput.SearchBy_Identity_EligibilityEnd;
		self.SearchFullName										:=	pInput.SearchBy_Identity_FullName;
		self.SearchLastName										:=	pInput.SearchBy_Identity_LastName;
		self.SearchFirstName									:=	pInput.SearchBy_Identity_FirstName;
		self.SearchMiddleName									:=	pInput.SearchBy_Identity_MiddleName;
		self.SearchSuffixName									:=	pInput.SearchBy_Identity_SuffixName;
		self.SearchSSN												:=	pInput.SearchBy_Identity_SSN;
		self.SearchDOB												:=	pInput.SearchBy_Identity_DOB;
		self.SearchAddress1StreetAddress1			:=	pInput.SearchBy_Identity_Address1_StreetAddress1;
		self.SearchAddress1StreetAddress2			:=	pInput.SearchBy_Identity_Address1_StreetAddress2;
		self.SearchAddress1City								:=	pInput.SearchBy_Identity_Address1_City;
		self.SearchAddress1State							:=	pInput.SearchBy_Identity_Address1_State;
		self.SearchAddress1Zip								:=	pInput.SearchBy_Identity_Address1_Zip;
		self.SearchAddress2StreetAddress1			:=	pInput.SearchBy_Identity_Address2_StreetAddress1;
		self.SearchAddress2StreetAddress2			:=	pInput.SearchBy_Identity_Address2_StreetAddress2;
		self.SearchAddress2City								:=	pInput.SearchBy_Identity_Address2_City;
		self.SearchAddress2State							:=	pInput.SearchBy_Identity_Address2_State;
		self.SearchAddress2Zip								:=	pInput.SearchBy_Identity_Address2_Zip;
		self.IncludeEligibilityHistory				:=	if(pInput.Options_IncludeEligibilityHistory, 'Y', 'N');
		self.IncludeInterstateAllPrograms			:=	if(pInput.Options_IncludeInterstateAllPrograms, 'Y', 'N');

		self.CaseNACGroupID										:=	pInput.Response_Record.NAC2Record_NacGroupId;
		self.CaseState												:=	pInput.Response_Record.NAC2Record_Case_ProgramState;
		self.CaseProgramCode									:=	pInput.Response_Record.NAC2Record_Case_ProgramCode;
		self.CaseID														:=	pInput.Response_Record.NAC2Record_Case_CaseIdentifier;
		self.CaseLastName											:=	pInput.Response_Record.NAC2Record_Case_LastName;
		self.CaseFirstName										:=	pInput.Response_Record.NAC2Record_Case_FirstName;
		self.CaseMiddleName										:=	pInput.Response_Record.NAC2Record_Case_MiddleName;
		self.CaseSuffixName										:=	pInput.Response_Record.NAC2Record_Case_SuffixName;
		self.CaseMonthlyAllotment							:=	pInput.Response_Record.NAC2Record_Case_MonthlyAllotment;
		self.CaseRegionCode										:=	pInput.Response_Record.NAC2Record_Case_RegionCode;
		self.CaseCountyParishCode							:=	pInput.Response_Record.NAC2Record_Case_CountyParishCode;
		self.CaseCountyParishName							:=	pInput.Response_Record.NAC2Record_Case_CountyParishName;
		self.CasePhone1												:=	pInput.Response_Record.NAC2Record_Case_Phone1;
		self.CasePhone2												:=	pInput.Response_Record.NAC2Record_Case_Phone2;
		self.CaseEmail												:=	pInput.Response_Record.NAC2Record_Case_Email;
		self.PhysicalAddressCategory					:=	pInput.Response_Record.NAC2Record_Case_PhysicalAddress_AddressCategory;
		self.PhysicalAddressStreet1						:=	pInput.Response_Record.NAC2Record_Case_PhysicalAddress_StreetAddress1;
		self.PhysicalAddressStreet2						:=	pInput.Response_Record.NAC2Record_Case_PhysicalAddress_StreetAddress2;
		self.PhysicalAddressCity							:=	pInput.Response_Record.NAC2Record_Case_PhysicalAddress_City;
		self.PhysicalAddressState							:=	pInput.Response_Record.NAC2Record_Case_PhysicalAddress_State;
		self.PhysicalAddressZip								:=	pInput.Response_Record.NAC2Record_Case_PhysicalAddress_Zip;
		self.MailAddressCategory							:=	pInput.Response_Record.NAC2Record_Case_MailingAddress_AddressCategory;
		self.MailAddressStreet1								:=	pInput.Response_Record.NAC2Record_Case_MailingAddress_StreetAddress1;
		self.MailAddressStreet2								:=	pInput.Response_Record.NAC2Record_Case_MailingAddress_StreetAddress2;
		self.MailAddressCity									:=	pInput.Response_Record.NAC2Record_Case_MailingAddress_City;
		self.MailAddressState									:=	pInput.Response_Record.NAC2Record_Case_MailingAddress_State;
		self.MailAddressZip										:=	pInput.Response_Record.NAC2Record_Case_MailingAddress_Zip;
		self.ClientID													:=	pInput.Response_Record.NAC2Record_Client_ClientIdentifier;
		self.ClientHoHIndicator								:=	pInput.Response_Record.NAC2Record_Client_HOHIndicator;
		self.ClientABAWDIndicator							:=	pInput.Response_Record.NAC2Record_Client_ABAWDIndicator;
		self.ClientHoHRelationshipIndicator		:=	pInput.Response_Record.NAC2Record_Client_RelationshipIndicator;
		self.ClientLastName										:=	pInput.Response_Record.NAC2Record_Client_LastName;
		self.ClientFirstName									:=	pInput.Response_Record.NAC2Record_Client_FirstName;
		self.ClientMiddleName									:=	pInput.Response_Record.NAC2Record_Client_MiddleName;
		self.ClientSuffixName									:=	pInput.Response_Record.NAC2Record_Client_SuffixName;
		self.ClientGender											:=	pInput.Response_Record.NAC2Record_Client_Gender;
		self.ClientRace												:=	pInput.Response_Record.NAC2Record_Client_Race;
		self.ClientEthnicity									:=	pInput.Response_Record.NAC2Record_Client_Ethnicity;
		self.ClientSSN												:=	pInput.Response_Record.NAC2Record_Client_SSN;
		self.ClientSSNType										:=	pInput.Response_Record.NAC2Record_Client_SSNTypeIndicator;
		self.ClientDOB												:=	pInput.Response_Record.NAC2Record_Client_DOB;
		self.ClientDOBType										:=	pInput.Response_Record.NAC2Record_Client_DOBTypeIndicator;
		self.ClientCertificateID							:=	pInput.Response_Record.NAC2Record_Client_CertificateIDType;
		self.ClientMonthlyAllotment						:=	pInput.Response_Record.NAC2Record_Client_MonthlyAllotment;
		self.ClientEligibilityStatus					:=	pInput.Response_Record.NAC2Record_Eligibility_StatusIndicator;
		self.ClientEligibilityDate						:=	pInput.Response_Record.NAC2Record_Eligibility_StatusDate;
		self.ClientEligibilityPeriodType			:=	pInput.Response_Record.NAC2Record_Eligibility_PeriodType;
		self.ClientEligibilityPeriodCount			:=	if(Std.Str.ToUpperCase(pInput.Response_Record.NAC2Record_Eligibility_PeriodType) = 'M',
																								 pInput.Response_Record.NAC2Record_Eligibility_PeriodCountMonths,
																								 pInput.Response_Record.NAC2Record_Eligibility_PeriodCountDays
																								);
		self.ClientEligibilityPeriodStart			:=	pInput.Response_Record.NAC2Record_Eligibility_PeriodStart;
		self.ClientEligibilityPeriodEnd				:=	pInput.Response_Record.NAC2Record_Eligibility_PeriodEnd;
		self.ClientPhone											:=	pInput.Response_Record.NAC2Record_Client_Phone;
		self.ClientEmail											:=	pInput.Response_Record.NAC2Record_Client_Email;
		self.StateContactName									:=	pInput.Response_Record.NAC2Record_StateContact_Name;
		self.StateContactPhone								:=	pInput.Response_Record.NAC2Record_StateContact_Phone;
		self.StateContactPhoneExtension				:=	pInput.Response_Record.NAC2Record_StateContact_PhoneExtension;
		self.StateContactEmail								:=	pInput.Response_Record.NAC2Record_StateContact_Email;
		self.LexIDScore												:=	intformat((integer1)pInput.Response_Record.NAC2Record_LexIDScore, 3, 1);
		self.MatchCodes												:=	pInput.Response_Record.NAC2Record_MatchCode;
		self.TotalEligiblePeriodsDays					:=	pInput.Response_Record.NAC2Record_MatchHistory_TotalEligiblePeriodCountDays;
		self.TotalEligiblePeriodsMonths				:=	pInput.Response_Record.NAC2Record_MatchHistory_TotalEligiblePeriodCountMonths;
		self.ExceptionReasonCode							:=	pInput.Response_Record.NAC2Record_Client_Exception_ReasonCode;
		self.ExceptionComments								:=	pInput.Response_Record.NAC2Record_Client_Exception_Comment;
		self.EligibilityPeriodsHistory				:=	pInput.NAC2Record_MatchHistory_Flattened;
		self.SequenceNumber										:=	intformat((integer2)pInput.Response_Record.NAC2Record_SequenceNumber, 4, 1);
	end;

	//////////////////////////////////////////////////////////////////
	export	dataset(Layouts.MSH2PlusInternal)	fMSH2InternalFromHitsFlattened(dataset(ESP_Logs_To_MSH2_MSX2_Intermediate(dataset([], ESP_Logs_Layouts.TransactionLogsCombined)).rIntermediateHitFlattened2) pHitsFlattened)	:=
	function
		return	project(pHitsFlattened, tMSH2PlusInternal(left));
	end;

	//////////////////////////////////////////////////////////////////
	export	dataset(Layouts.MSX2PlusInternal)	fMSX2InternalFromMissesFlattened(dataset(ESP_Logs_To_MSH2_MSX2_Intermediate(dataset([], ESP_Logs_Layouts.TransactionLogsCombined)).rIntermediateMissFlattened) pMissesFlattened)	:=
	function
		return	project(pMissesFlattened, tMSX2PlusInternal(left));
	end;

	//////////////////////////////////////////////////////////////////
	export	dataset(Layouts.MSH2)	fMSH2ByGroupID(dataset(ESP_Logs_To_MSH2_MSX2_Intermediate(dataset([], ESP_Logs_Layouts.TransactionLogsCombined)).rIntermediateHitFlattened2) pHitsFlattened, string4 pGroupID)	:=
	function
		dFlattenedIn1	:=	project(pHitsFlattened, tMSH2PlusInternal(left))(TargetNACGroupID = pGroupID);
		dFlattenedIn3	:=	project(pHitsFlattened, tMSH2PlusInternal(left))(CaseNACGroupID = pGroupID);
		Layouts.MSH2	tToMSH2_1(Layouts.MSH2PlusInternal pInput)	:=
		transform
			self	:=	pInput;
		end;
		Layouts.MSH2	tToMSH2_3(Layouts.MSH2PlusInternal pInput)	:=
		transform
			self.ActivityType := '3';
			self							:=	pInput;
		end;
		dMSH2_1		:=	project(dFlattenedIn1, tToMSH2_1(left));
		dMSH2_3		:=	project(dFlattenedIn3, tToMSH2_3(left));
		return	dMSH2_1 + dMSH2_3;
	end;

	//////////////////////////////////////////////////////////////////
	export	dataset(Layouts.MSX2)	fMSX2ByGroupID(dataset(ESP_Logs_To_MSH2_MSX2_Intermediate(dataset([], ESP_Logs_Layouts.TransactionLogsCombined)).rIntermediateMissFlattened) pMissFlattened, string4 pGroupID)	:=
	function
		dFlattenedIn	:=	project(pMissFlattened, tMSX2PlusInternal(left));
		Layouts.MSX2	tToMSX2(Layouts.MSX2PlusInternal pInput)	:=
		transform
			self	:=	pInput;
		end;
		return	project(dFlattenedIn(TargetNACGroupID = pGroupID), tToMSX2(left));
	end;

end;
