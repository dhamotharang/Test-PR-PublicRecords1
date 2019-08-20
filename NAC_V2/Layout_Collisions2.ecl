EXPORT Layout_Collisions2 := MODULE

	
	export slim1 := RECORD
		unsigned		PrepRecSeq;
		unsigned4 NCF_FileDate;
		string2			ProgramState;
		string1			ProgramCode;
		string20		CaseID;
		string20		ClientId;
		string30 	Client_Last_Name;
		string25 	Client_First_Name;
		string25 	Client_Middle_Name;
		string5 	Client_Suffix_Name;
		string9		SSN;
		string8		DOB;
	END;
	
	export Collisions_slim := RECORD
		unsigned1 pri:=0
		,string15 matchset:=''
		,string15 matchcodes:=''
		,unsigned6 LexID:=0
		,unsigned6 LexID_score:=0
		,string8	StartDate
		,string8	EndDate
		,string1	EligibilityStatus
		,slim1 Source
		,slim1 Match
	END;

EXPORT Layout_Collisions := RECORD

	unsigned1 pri:=0
	,string15 matchset:=''
	,unsigned6 LexID:=0
	,string1 ActivityType:='4'
		,string8	StartDate
		,string8	EndDate
	,string40 BuildVersion
	,string2 BenefitState
	,string4 SearchGroupID
	,string20 SearchCaseID
	,string20 SearchClientID
	,string1 SearchBenefitType
	,string1	SearchRangeType
	,string8	SearchStartDate
	,string8	SearchEndDate
	,string30 SearchLastName
	,string25 SearchFirstName
	,string25 SearchMiddleName
	,string5 SearchSuffixName := ''
	,string9 SearchSSN
	,string8 SearchDOB
	,STRING8 SearchEligibilityDate
	,string1 SearchEligibilityStatus
	,string70 SearchAddress1StreetAddress1
	,string70 SearchAddress1StreetAddress2
	,string30 SearchAddress1City
	,string2 SearchAddress1State
	,string9 SearchAddress1Zip
	,string70 SearchAddress2StreetAddress1
	,string70 SearchAddress2StreetAddress2
	,string30 SearchAddress2City
	,string2 SearchAddress2State
	,string9 SearchAddress2Zip
	,string2 CaseState
	,string1 CaseBenefitType
	,string4 CaseGroupId
	,string8	CaseStartDate
	,string8	CaseEndDate
	,string20 CaseID
	,string30 CaseLastName
	,string25 CaseFirstName
	,string25 CaseMiddleName
	,string5 CaseSuffixName := ''
	,string10	CaseMonthlyAllotment
	,string3	RegionCode
	,string10 CasePhone1
	,string10 CasePhone2
	,string256 CaseEmail
	,string1	AddressPhysicalCategory
	,string70 CasePhysicalStreet1
	,string70 CasePhysicalStreet2
	,string30 CasePhysicalCity
	,string2 CasePhysicalState
	,string9 CasePhysicalZip
	,string1	AddressMailCategory
	,string70 CaseMailStreet1
	,string70 CaseMailStreet2
	,string30 CaseMailCity
	,string2 CaseMailState
	,string9 CaseMailZip
	,string3 CaseCountyParishCode
	,string25 CaseCountyParishName
	,string20 ClientID
	,string1	HoHIndicator
	,string1	ABAWDIndicator
	,string1	RelationshipIndicator
	,string30 ClientLastName
	,string25 ClientFirstName
	,string25 ClientMiddleName
	,string5 ClientSuffixName := ''
	,string1 ClientGender
	,string1 ClientRace
	,string1 ClientEthnicity
	,string9 ClientSSN
	,string1 ClientSSNType
	,string8 ClientDOB
	,string1 ClientDOBType
	,string20	ClientCertificateType
	,string10	ClientMonthlyAllotment
	,string1 ClientEligibilityStatus
	,string8 ClientEligibilityDate
	,string1	ClientEligibilityPeriodType
	,string5	ClientEligibilityPeriodCount
	,string8	ClientEligibilityStartDate
	,string8	ClientEligibilityEndDate
	,string10 ClientPhone
	,string256 ClientEmail
	,string50 StateContactName
	,string10 StateContactPhone
	,string10 StateContactPhoneExtension
	,string256 StateContactEmail
	,string3 LexIdScore
	,string10 MatchCodes
	,unsigned6 OrigSearchSequenceNumber
	,string10 SearchSequenceNumber
	,unsigned6 OrigClientSequenceNumber
	,string5		TotalEligiblePeriodsDays
	,string4		TotalEligiblePeriodsMonths
	,string3		ExceptionReasonCode
	,string50		ExceptionComments
	,string200	EligibilityPeriodsHistory
	,string10 ClientSequenceNumber
	,unsigned4 SearchNCFFileDate
	,unsigned4 ClientNCFFileDate
	,unsigned4 SearchProcessDate
	,unsigned4 ClientProcessDate;
END;



END;