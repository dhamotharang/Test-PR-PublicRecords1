EXPORT fn_ReNormalizeCollisions_2(DATASET(Nac_V2.Layout_Collisions2.Layout_Collisions) c) := FUNCTION

Layout_Slim := RECORD

	string6 matchset:=''
	,string10 MatchCodes
	,unsigned6 LexID:=0
	,string30 SearchLastName
	,string25 SearchFirstName
	,string25 SearchMiddleName
	//,string5 SearchSuffixName := ''
	,string30 ClientLastName
	,string25 ClientFirstName
	,string25 ClientMiddleName
	//,string5 ClientSuffixName := ''
	,string20 SearchClientID
	,string20 ClientID
		,string8	StartDate
		,string8	EndDate
	,string2 BenefitState
	,string1 SearchBenefitType
	,string2 CaseState
	,string1 CaseBenefitType

	,string9 SearchSSN
	,string8 SearchDOB
	,string9 ClientSSN
	,string8 ClientDOB
	
	,string4 SearchGroupID
	,string4 CaseGroupId
	,string20 CaseID
	,string20 SearchCaseID
	,string8	SearchStartDate
	,string8	SearchEndDate
	,string8	CaseStartDate
	,string8	CaseEndDate
	,string		addr1
	,string		addr2
	,string1  ExceptionReasonCode;
END;

Layout_Slim xSlim (Nac_V2.Layout_Collisions2.Layout_Collisions c) := TRANSFORM
	self.Addr1 := StandardizeName(c.SearchAddress1StreetAddress1 + ', ' +
													c.SearchAddress1City + ', ' + c.SearchAddress1State + ' ' + c.SearchAddress1Zip[1..5]);	
	self.Addr2 := StandardizeName(c.SearchAddress2StreetAddress1 + ', ' +
													c.SearchAddress2City + ', ' + c.SearchAddress2State + ' ' + c.SearchAddress2Zip[1..5]);	
	self := c;
END;

	Nac_V2.Layout_Collisions2.Layout_Collisions xCollisions(Nac_V2.Layout_Collisions2.Layout_Collisions c, integer n) := TRANSFORM
	
						self.BenefitState := CHOOSE(n, c.BenefitState, c.CaseState, '');
						self.SearchBenefitType := CHOOSE(n, c.SearchBenefitType, c.CaseBenefitType, '');
						self.SearchCaseId := CHOOSE(n, c.SearchCaseID, c.CaseID, '');
						self.OrigSearchSequenceNumber := CHOOSE(n, c.OrigSearchSequenceNumber, c.OrigClientSequenceNumber, 0);
						self.SearchNCFFileDate := CHOOSE(n, c.SearchNCFFileDate, c.ClientNCFFileDate, 0);
						self.SearchClientID := CHOOSE(n, c.SearchClientID, c.ClientID, '');
						self.SearchLastName := CHOOSE(n, c.SearchLastName, c.ClientLastName, '');
						self.SearchFirstName := CHOOSE(n, c.SearchFirstName, c.ClientFirstName, '');
						self.SearchMiddleName := CHOOSE(n, c.SearchMiddleName, c.ClientMiddleName, '');
						self.SearchSuffixName := CHOOSE(n, c.SearchSuffixName, c.ClientSuffixName, '');
						self.SearchEligibilityStatus := CHOOSE(n, c.SearchEligibilityStatus, c.ClientEligibilityStatus, '');
						self.SearchSSN := CHOOSE(n, c.SearchSSN, c.ClientSSN, '');
						self.SearchDOB := CHOOSE(n, c.SearchDOB, c.ClientDob, '');
						// physical address
						self.SearchAddress1StreetAddress1 := CHOOSE(n, c.SearchAddress1StreetAddress1, c.CasePhysicalStreet1, '');
						self.SearchAddress1StreetAddress2 := CHOOSE(n, c.SearchAddress1StreetAddress2, c.CasePhysicalStreet2, '');
						self.SearchAddress1City := CHOOSE(n, c.SearchAddress1City, c.CasePhysicalCity, '');
						self.SearchAddress1State := CHOOSE(n, c.SearchAddress1State, c.CasePhysicalState, '');
						self.SearchAddress1Zip := CHOOSE(n, c.SearchAddress1Zip, c.CasePhysicalZip, '');
						// mailing address
						self.SearchAddress2StreetAddress1 := CHOOSE(n, c.SearchAddress2StreetAddress1, c.CaseMailStreet1, '');
						self.SearchAddress2StreetAddress2 := CHOOSE(n, c.SearchAddress2StreetAddress2, c.CaseMailStreet2, '');
						self.SearchAddress2City := CHOOSE(n, c.SearchAddress2City, c.CaseMailCity, '');
						self.SearchAddress2State := CHOOSE(n, c.SearchAddress2State, c.CaseMailState, '');
						self.SearchAddress2Zip := CHOOSE(n, c.SearchAddress2Zip, c.CaseMailZip, '');

						self.CaseState := CHOOSE(n, c.CaseState, c.BenefitState, '');
						self.CaseBenefitType := CHOOSE(n, c.CaseBenefitType, c.SearchBenefitType, '');
						self.CaseID := CHOOSE(n, c.CaseID, c.SearchCaseID, '');
						self.OrigClientSequenceNumber := CHOOSE(n, c.OrigClientSequenceNumber, c.OrigSearchSequenceNumber, 0);
						self.ClientNCFFileDate := CHOOSE(n, c.ClientNCFFileDate, c.SearchNCFFileDate, 0);
						self.ClientID := CHOOSE(n, c.ClientID, c.SearchClientID, '');
						self.ClientLastName := CHOOSE(n, c.ClientLastName, c.SearchLastName, '');
						self.ClientFirstName := CHOOSE(n, c.ClientFirstName, c.SearchFirstName, '');
						self.ClientMiddleName := CHOOSE(n, c.ClientMiddleName, c.SearchMiddleName, '');
						self.ClientSuffixName := CHOOSE(n, c.ClientSuffixName, c.SearchSuffixName, '');
						self.ClientEligibilityStatus := CHOOSE(n, c.ClientEligibilityStatus, c.SearchEligibilityStatus, '');
						self.ClientSSN := CHOOSE(n, c.ClientSSN, c.SearchSSN, '');
						self.ClientDob := CHOOSE(n, c.ClientDob, c.SearchDOB, '');
						// physical address
						self.CasePhysicalStreet1 := CHOOSE(n, c.CasePhysicalStreet1, c.SearchAddress1StreetAddress1, '');
						self.CasePhysicalStreet2 := CHOOSE(n, c.CasePhysicalStreet2, c.SearchAddress1StreetAddress2, '');
						self.CasePhysicalCity := CHOOSE(n, c.CasePhysicalCity, c.SearchAddress1City, '');
						self.CasePhysicalState := CHOOSE(n, c.CasePhysicalState, c.SearchAddress1State, '');
						self.CasePhysicalZip := CHOOSE(n, c.CasePhysicalZip, c.SearchAddress1Zip, '');
						// mailing address
						self.CaseMailStreet1 := CHOOSE(n, c.CaseMailStreet1, c.SearchAddress2StreetAddress1, '');
						self.CaseMailStreet2 := CHOOSE(n, c.CaseMailStreet2, c.SearchAddress2StreetAddress2, '');
						self.CaseMailCity := CHOOSE(n, c.CaseMailCity, c.SearchAddress2City, '');
						self.CaseMailState := CHOOSE(n, c.CaseMailState, c.SearchAddress2State, '');
						self.CaseMailZip := CHOOSE(n, c.CaseMailZip, c.SearchAddress2Zip, '');

						self := c;
	END;

	diff := c(benefitstate<>casestate);
	same := c(benefitstate=casestate);
	
	fixed := NORMALIZE(same, 2, xCollisions(LEFT, COUNTER));

	return PROJECT(diff + fixed, xSlim(LEFT));

END;