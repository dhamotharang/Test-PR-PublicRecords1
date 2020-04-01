export ESP_Logs_Layouts	:=
module
	shared	t_StringArrayItem	:=
	record
		string			_Value{xpath(''), maxlength(8192)};
	end;

	shared	t_EndUserInfo :=
	record
		string120		CompanyName{xpath('CompanyName')};
		string200		StreetAddress1{xpath('StreetAddress1')};
		string25		City{xpath('City')};
		string2			State{xpath('State')};
		string5			Zip5{xpath('Zip5')};
		string10		Phone{xpath('Phone')};
	end;

	shared	t_User :=
	record
		string50		ReferenceCode{xpath('ReferenceCode')};
		string20		BillingCode{xpath('BillingCode')};
		string50		QueryID{xpath('QueryId')};
		string20		CompanyID{xpath('CompanyId')};
		string20		BillingID{xpath('BillingId')};
		string2			GLBPurpose{xpath('GLBPurpose')};
		string2			DLPurpose{xpath('DLPurpose')};
		string20		LoginHistoryID{xpath('LoginHistoryId')};
		integer8		DebitUnits{xpath('DebitUnits')};
		string15		IP{xpath('IP')};
		string5			IndustryClass{xpath('IndustryClass')};
		string3			ResultFormat{xpath('ResultFormat')};
		string16		LogAsFunction{xpath('LogAsFunction')};
		string6			SSNMask{xpath('SSNMask')};
		string6			DOBMask{xpath('DOBMask')};
		boolean			ExcludeDMVPII{xpath('ExcludeDMVPII')};
		boolean			DLMask{xpath('DLMask')};
		string50		DataRestrictionMask{xpath('DataRestrictionMask')};
		string50		DataPermissionMask{xpath('DataPermissionMask')};
		string			SourceCode{xpath('SourceCode')};
		string32		ApplicationType{xpath('ApplicationType')};
		boolean			SSNMaskingOn{xpath('SSNMaskingOn')};
		boolean			DLMaskingOn{xpath('DLMaskingOn')};
		boolean			LNBranded{xpath('LnBranded')};
		t_enduserinfo	EndUser{xpath('EndUser')};
		integer8		MaxWaitSeconds{xpath('MaxWaitSeconds')};
		string16		RelatedTransactionID{xpath('RelatedTransactionId')};
		string20		AccountNumber{xpath('AccountNumber')};
		boolean			_TestDataEnabled{xpath('TestDataEnabled')};
		string32		_TestDataTableName{xpath('TestDataTableName')};
		boolean			OutcomeTrackingOptOut{xpath('OutcomeTrackingOptOut')};
		integer8		NonSubjectSuppression{xpath('NonSubjectSuppression')};
		string			ProductCode{xpath('ProductCode')};
	end;

	shared	t_ServiceParameter	:=
	record
		string32		Name{xpath('Name')};
		string			Value_{xpath('Value'), maxlength(128)};
	end;

	shared	t_ServiceLocation	:=
	record
		string			LocationID{xpath('LocationId'), maxlength(256)};
		string			ServiceName{xpath('ServiceName'), maxlength(128)};
		dataset(t_ServiceParameter) Parameters{xpath('Parameters/Parameter'), maxcount(1)};
	end;

	shared	t_NAC2SearchOptions	:=
	record
		boolean			Blind{xpath('Blind')};
		integer8		MakeVendorGatewayCall{xpath('MakeVendorGatewayCall')};
		boolean			InvestigativePurpose{xpath('InvestigativePurpose')};
		boolean			IncludeEligibilityHistory{xpath('IncludeEligibilityHistory')};
		boolean			IncludeInterstateAllPrograms{xpath('IncludeInterstateAllPrograms')};
		boolean			_IsOnline{xpath('IsOnline')};
		boolean			_ProdDataTestMode{xpath('ProdDataTestMode')};				// not in ECL definitions
		boolean			_Encrypt{xpath('Encrypt')};													// not in ECL definitions
	end;

	shared	t_NAC2EndUser	:=
	record
		string			LoginID{xpath('LoginId')};
		string			IP{xpath('IP')};
		string			UserName{xpath('UserName')};
	end;

	shared	t_NAC2WSUser	:=
	record
		string			LoginID{xpath('LoginId')};
		string			IP{xpath('IP')};
		string			_ActivityType{xpath('ActivityType')};
	end;

	shared	t_NAC2Investigative	:=
	record
		string2			ProgramState{xpath('ProgramState')};
		string1			EligibilityStatus{xpath('EligibilityStatus')};
	end;

	shared	t_NAC2Address	:=
	record
		string200		StreetAddress1{xpath('StreetAddress1')};
		string200		StreetAddress2{xpath('StreetAddress2')};
		string30		City{xpath('City')};
		string2			State{xpath('State')};
		string9			Zip{xpath('Zip')};
	end;

	shared	t_NAC2Identity:=
	record
		string30		LastName{xpath('LastName')};
		string25		FirstName{xpath('FirstName')};
		string25		MiddleName{xpath('MiddleName')};
		string5			SuffixName{xpath('SuffixName')};
		string62		FullName{xpath('FullName')};
		t_nac2address Address1{xpath('Address1')};
		t_nac2address Address2{xpath('Address2')};
		string9			SSN{xpath('SSN')};
		string8			DOB{xpath('DOB')};
		string1			ProgramCode{xpath('ProgramCode')};
		string1			EligibilityRangeType{xpath('EligibilityRangeType')};
		string8			EligibilityStart{xpath('EligibilityStart')};
		string8			EligibilityEnd{xpath('EligibilityEnd')};
		string20		CaseIdentifier{xpath('CaseIdentifier')};
		string20		ClientIdentifier{xpath('ClientIdentifier')};
	end;

	shared	t_NAC2Search	:=
	record
		string2			_SourceState{xpath('SourceState')};
		string32		_ProgramsAllowedSearch{xpath('ProgramsAllowedSearch')};
		string32		_ProgramsAllowedReturned{xpath('ProgramsAllowedReturned')};
		string4			_NacGroupID{xpath('NacGroupId')};
		string4			_PPAGroupID{xpath('PPAGroupId')};
		t_nac2identity Identity{xpath('Identity')};
		t_nac2investigative InvestigativeFields{xpath('InvestigativeFields')};
		unsigned2		PenaltThreshold{xpath('PenaltThreshold')};
	end;
		 
	export	t_NAC2SearchRequest	:=
	record
		t_User			User{xpath('User')};
		dataset(t_StringArrayItem) RemoteLocations{xpath('RemoteLocations/Item'), maxcount(1)};
		dataset(t_ServiceLocation) ServiceLocations{xpath('ServiceLocations/ServiceLocation'), maxcount(1)};
		t_NAC2SearchOptions Options{xpath('Options')};
		t_NAC2EndUser EndUser{xpath('EndUser')};
		t_NAC2WSUser WsUser{xpath('WsUser')};
		t_NAC2Search SearchBy{xpath('SearchBy')};
	end;

	shared	t_WSException	:=
	record
		string			Source{xpath('Source'), maxlength(64)};
		integer8		Code{xpath('Code')};
		string			Location{xpath('Location'), maxlength(64)};
		string256		Message{xpath('Message')};
	end;

	shared	t_ResponseHeader	:=
	record
		integer8		Status{xpath('Status')};
		string256		Message{xpath('Message')};
		string50		QueryID{xpath('QueryId')};
		string16		TransactionID{xpath('TransactionId')};
		dataset(t_WSException) Exceptions{xpath('Exceptions/Item'), maxcount(4)};
	end;

	shared	t_NAC2AddressOut	:=
	record
		string200		StreetAddress1{xpath('StreetAddress1')};
		string200		StreetAddress2{xpath('StreetAddress2')};
		string30		City{xpath('City')};
		string2			State{xpath('State')};
		string9			Zip{xpath('Zip')};
		string1			AddressCategory{xpath('AddressCategory')};
	end;

	shared	t_NAC2Case	:=
	record
		string30		LastName{xpath('LastName')};
		string25		FirstName{xpath('FirstName')};
		string25		MiddleName{xpath('MiddleName')};
		string5			SuffixName{xpath('SuffixName')};
		string20		CaseIdentifier{xpath('CaseIdentifier')};
		string2			ProgramState{xpath('ProgramState')};
		string1			ProgramCode{xpath('ProgramCode')};
		string10		Phone1{xpath('Phone1')};
		string10		Phone2{xpath('Phone2')};
		string256		Email{xpath('Email')};
		t_nac2addressout PhysicalAddress{xpath('PhysicalAddress')};
		t_nac2addressout MailingAddress{xpath('MailingAddress')};
		string3			CountyParishCode{xpath('CountyParishCode')};
		string25		CountyParishName{xpath('CountyParishName')};
		string10		MonthlyAllotment{xpath('MonthlyAllotment')};
		string3			RegionCode{xpath('RegionCode')};
	end;

	shared	t_NAC2Exception	:=
	record
		string3			ReasonCode{xpath('ReasonCode')};
		string50		Comment{xpath('Comment')};
	end;

	shared	t_NAC2Client	:=
	record
		string30		LastName{xpath('LastName')};
		string25		FirstName{xpath('FirstName')};
		string25		MiddleName{xpath('MiddleName')};
		string5			SuffixName{xpath('SuffixName')};
		string20		ClientIdentifier{xpath('ClientIdentifier')};
		string1			Gender{xpath('Gender')};
		string1			Race{xpath('Race')};
		string1			Ethnicity{xpath('Ethnicity')};
		string10		Phone{xpath('Phone')};
		string256		Email{xpath('Email')};
		string9			SSN{xpath('SSN')};
		string1			SSNTypeIndicator{xpath('SsnTypeIndicator')};
		string8			DOB{xpath('DOB')};
		string1			DOBTypeIndicator{xpath('DobTypeIndicator')};
		string10		MonthlyAllotment{xpath('MonthlyAllotment')};
		string1			HOHIndicator{xpath('HohIndicator')};
		string1			ABAWDIndicator{xpath('AbawdIndicator')};
		string1			RelationshipIndicator{xpath('RelationshipIndicator')};
		string20		CertificateIDType{xpath('CertificateIdType')};
		string5			HistoricalBenefitCount{xpath('HistoricalBenefitCount')};
		t_NAC2Exception Exception{xpath('Exception')};
	end;

	shared	t_NAC2StateContact	:=
	record
		string50		Name{xpath('Name')};
		string10		Phone{xpath('Phone')};
		string10		PhoneExtension{xpath('PhoneExtension')};
		string256		Email{xpath('Email')};
	end;

	shared	t_NAC2Eligibility	:=
	record
		string1			StatusIndicator{xpath('StatusIndicator')};
		string8			StatusDate{xpath('StatusDate')};
		string1			PeriodType{xpath('PeriodType')};
		string8			PeriodStart{xpath('PeriodStart')};
		string8			PeriodEnd{xpath('PeriodEnd')};
		string6			PeriodCountDays{xpath('PeriodCountDays')};
		string4			PeriodCountMonths{xpath('PeriodCountMonths')};
	end;

	shared	t_NAC2InvestigativeHistory	:=
	record
		string8			EarliestStart{xpath('EarliestStart')};
		string8			LatestEnd{xpath('LatestEnd')};
		string5			TotalRecords{xpath('TotalRecords')};
	end;

	export	t_NAC2MatchInnerHistory	:=
	record
		string20		CaseIdentifier{xpath('CaseIdentifier')};
		string1			StatusIndicator{xpath('StatusIndicator')};
		string8			PeriodStart{xpath('PeriodStart')};
		string8			PeriodEnd{xpath('PeriodEnd')};
		string6			PeriodCountDays{xpath('PeriodCountDays')};
		string4			PeriodCountMonths{xpath('PeriodCountMonths')};
		string10		Matchcode{xpath('Matchcode')};
		string4			LexIDScore{xpath('LexIdScore')};
	end;

	shared	t_NAC2MatchHistory	:=
	record
		string6			TotalEligiblePeriodCountDays{xpath('TotalEligiblePeriodCountDays')};
		string4			TotalEligiblePeriodCountMonths{xpath('TotalEligiblePeriodCountMonths')};
		dataset(t_NAC2MatchInnerHistory) MatchInnerHistories{xpath('MatchInnerHistories/MatchInnerHistory'), maxcount(60)};
	end;

	shared	t_NAC2Record	:=
	record
		string4			NacGroupId{xpath('NacGroupId')};
		t_NAC2Case Case_{xpath('Case')};
		t_NAC2Client Client{xpath('Client')};
		t_NAC2StateContact StateContact{xpath('StateContact')};
		t_NAC2Eligibility Eligibility{xpath('Eligibility')};
		t_NAC2InvestigativeHistory InvestigativeHistory{xpath('InvestigativeHistory')};
		t_NAC2MatchHistory MatchHistory{xpath('MatchHistory')};
	end;

	export	t_NAC2SearchResultRecord	:=
	record
		t_NAC2Record NAC2Record{xpath('NAC2Record')};
		string10		MatchCode{xpath('MatchCode')};
		unsigned2		LexIDScore{xpath('LexIdScore')};
		unsigned4		SequenceNumber{xpath('SequenceNumber')};
		unsigned6		_LexID{xpath('LexId')};
		unsigned2		_Penalty{xpath('Penalty')};
	end;

	shared	t_NAC2SearchResponse	:=
	record
		t_ResponseHeader Header_{xpath('Header')};
		integer8		_RecordCount{xpath('RecordCount')};
		dataset(t_NAC2SearchResultRecord) Records{xpath('Records/Record'), maxcount(60)};
	end;

	export	t_NAC2SearchResponseEx	:=
	record
		t_NAC2SearchResponse Response{xpath('Dataset/Row')};
	end;

	export	TransactionLogOnlineRaw	:=
	record
		string16	TransactionID;
		string30	ServiceName;
		string19	DateAdded;
		string		RequestBlob;
		string		ResponseBlob;
		string		_LogicalFileName{virtual(LogicalFileName)};
	end;
		
	export	TransactionLogOnlineParsed	:=
	record
		string16	TransactionID;
		string30	ServiceName;
		string19	DateAdded;
		t_NAC2SearchRequest			NAC2SearchRequest;
		t_NAC2SearchResponseEx	NAC2SearchResponse;
		string		_LogicalFileName;
	end;

	export	TransactionLogDelimited	:=
	record
		string			TransactionID;
		string			DateAdded;
		string			UserID;
		string			UserIP;
		string			SearchSSN;
		string			SearchDOB;
		string			SearchProgramCode;
		string			SearchEligibilityRangeType;
		string			SearchEligibilityStart;
		string			SearchEligibilityEnd;
		string			SearchCaseID;
		string			SearchClientID;
		string			SearchProgramState;
		string			SearchEligibilityStatus;
		// Options -----------------------------------
		string			InvestigativePurpose;
		string			IncludeEligibilityHistory;
		string			IncludeInterstateAll;
		// Internal ----------------------------------
		string			IsOnline;
		// Set from MBS ------------------------------
		string			SourceState;
		string			ProgramsAllowedSearch;
		string			ProgramsAllowedReturn;
		string			NACGroupID;
		// End user ----------------------------------
		string			EndUserLoginID;
		string			EndUserIP;
		string			EndUserUserName;
		// ESP stuff ---------------------------------
		string			ResponseTime;
		string			ReferenceCode;
		string			_LogicalFileName{virtual(LogicalFileName)};
	end;

	export	TransactionLogFixed	:=
	record
		string16		TransactionID;
		string19		DateAdded;
		string50		UserID;
		string50		UserIP;
		string9			SearchSSN;
		string8			SearchDOB;
		string1			SearchProgramCode;
		string1			SearchEligibilityRangeType;
		string8			SearchEligibilityStart;
		string8			SearchEligibilityEnd;
		string20		SearchCaseID;
		string20		SearchClientID;
		string2			SearchProgramState;
		string1			SearchEligibilityStatus;
		// Options -----------------------------------
		boolean			InvestigativePurpose;
		boolean			IncludeEligibilityHistory;
		boolean			IncludeInterstateAll;
		// Internal ----------------------------------
		boolean			IsOnline;
		// Set from MBS ------------------------------
		string2			SourceState;
		string32		ProgramsAllowedSearch;
		string32		ProgramsAllowedReturn;
		string4			NACGroupID;
		// End user ----------------------------------
		string50		EndUserLoginID;
		string50		EndUserIP;
		string50		EndUserUserName;
		// ESP stuff ---------------------------------
		decimal5_2	ResponseTime;
		string50		ReferenceCode;
		string			_LogicalFileName;
	end;

	export	TransactionLogsCombined	:=
	record
		TransactionLogFixed and not [_LogicalFileName]	LogFixed;
		TransactionLogOnlineParsed	and not [TransactionID, DateAdded, _LogicalFileName] LogOnlineParsed;
	end;

end;