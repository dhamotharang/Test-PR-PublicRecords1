import header,address,AID,Tools, STD;
export Layouts := MODULE


EXPORT rlInternalEmailFile := RECORD

 integer2 recordid;
  string100 eventtype;
  string50 groupid;
  string emailaddress;
  string1 isrecipientinactive;
  string8 createdate;

END;


EXPORT rlEmailValidation := RECORD
	STRING EmailAddress;
END;




	export load := RECORD
		string2	Case_State_Abbreviation
		,string1	Case_Benefit_Type
		,string6	Case_Benefit_Month
		,string20	Case_Identifier
		,string30	Case_Last_Name
		,string25	Case_First_Name
		,string25	Case_Middle_Name
		,string10	Case_Phone_1
		,string10	Case_Phone_2
		,string256	Case_Email
		,string70	Case_Physical_Address_Street_1
		,string70	Case_Physical_Address_Street_2
		,string30	Case_Physical_Address_City
		,string2	Case_Physical_Address_State
		,string9	Case_Physical_Address_Zip
		,string70	Case_Mailing_Address_Street_1
		,string70	Case_Mailing_Address_Street_2
		,string30	Case_Mailing_Address_City
		,string2	Case_Mailing_Address_State
		,string9	Case_Mailing_Address_Zip
		,string3	Case_County_Parish_Code
		,string25	Case_County_Parish_Name
		,string20	Client_Identifier
		,string30	Client_Last_Name
		,string25	Client_First_Name
		,string25	Client_Middle_Name
		,string1	Client_Gender
		,string1	Client_Race
		,string1	Client_Ethnicity
		,string9	Client_SSN
		,string1	Client_SSN_Type_Indicator
		,string8	Client_DOB
		,string1	Client_DOB_Type_Indicator
		,string1	Client_Eligible_Status_Indicator
		,string8	Client_Eligible_Status_Date
		,string10	Client_Phone
		,string256	Client_Email
		,string50	State_Contact_Name
		,string10	State_Contact_Phone
		,string10	State_Contact_Phone_Extension
		,string256	State_Contact_Email
		,string52	Filler:=''
		,string1 cr:='\n'
	END;
	
	export vLoad := {string75 fn { virtual(logicalfilename)},load};

	export Input_Prepped := RECORD
		string75 FileName:=''
		,unsigned4 ProcessDate:=0
		,unsigned4 NCF_FileDate:=0
		,unsigned6 PrepRecNo:=0
		,unsigned6 PrepRecSeq:=0
		,load -[filler,cr]
	END;

	export load_old := RECORD
		String25 Case_Last_Name
		,String25 Case_First_Name
		,String1 Case_Middle_Initial
		,String6 Case_Benefit_Month
		,String1 Case_Benefit_Type
		,String25 Client_Last_Name
		,String25 Client_First_Name
		,String1 Client_Middle_Initial
		,String1 Client_Gender
		,String9 Client_SSN
		,String8 Client_DOB
		,String1 Client_Eligible_Indicator
		,String2 State_Abbreviation
		,String1 Client_SSN_Verification_Flag
		,String25 Case_Physical_Address_Street_1
		,String25 Case_Physical_Address_Street_2
		,String20 Case_Physical_Address_City
		,String2 Case_Physical_Address_State
		,String9 Case_Physical_Address_Zip
		,String25 Case_Mailing_Address_Street_1
		,String25 Case_Mailing_Address_Street_2
		,String20 Case_Mailing_Address_City
		,String2 Case_Mailing_Address_State
		,String9 Case_Mailing_Address_Zip
		,string1 cr
	END;

	export base := RECORD
		string75 FileName:=''
		,unsigned6 Case_Id:=0
		,load -[filler,cr]
		,String75  Prepped_name:=''
		,String60  Prepped_addr1:=''
		,String35  Prepped_addr2:=''
		,unsigned6 did:=0
		,unsigned  did_score:=0
		,unsigned4 ProcessDate:=0
		,unsigned4 NCF_FileDate:=0
		,string6 NCF_FileTime:=''
		,unsigned6 PrepRecSeq:=0
		,string9   clean_ssn:=''
		,string9   best_ssn:=''
		,integer4  clean_dob:=0
		,integer4  age:=0
		,integer4  best_dob:=0
		,address.Layout_Clean_Name.title
		,typeof(address.Layout_Clean_Name.fname) prefname:=''
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_county:=''
		,string3		county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat
		,unsigned1 zero :=0
		,string1   blank:=''
	END;
	
	export baseHistorical := RECORD
		Std.Date.Date_t	StartDate;
		Std.Date.Date_t	EndDate;
		String60  Phys_addr1:='';
		String45  Phys_addr2:='';
		String60  mail_addr1:='';
		String45  mail_addr2:='';
		string1		AddressType := '';
		base - [case_id];
		string4	GroupId;
		string5		case_name_suffix;
		string5		client_name_suffix;
	END;
		
	export slim1 := RECORD
		Base.PrepRecSeq
		,Base.NCF_FileDate
		,load.Case_State_Abbreviation
		,load.Case_Identifier
		,load.Client_Identifier
		,load.Client_Last_Name
		,load.Client_First_Name
		,load.Client_Middle_Name
		,load.Client_SSN
		,load.Client_DOB
	END;

	export Collisions_slim := RECORD
		unsigned1 pri:=0
		,string15 matchset:=''
		,unsigned6 LexID:=0
		,unsigned6 LexID_score:=0
		,load.Case_Benefit_Month
		,load.Client_Eligible_Status_Indicator
		,load.Case_Benefit_Type
		,slim1 left_rec
		,slim1 right_rec
	END;

export Collisions := record
	unsigned1 pri:=0
	,string15 matchset:=''
	,unsigned6 LexID:=0
	,string1 ActivityType:='4'
	,string40 BuildVersion
	,string2 BenefitState
	,string20 SearchCaseID
	,string20 SearchClientID
	,string1 SearchBenefitType
	,string6 SearchBenefitMonth
	,string30 SearchLastName
	,string25 SearchFirstName
	,string25 SearchMiddleName
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
	,string6 CaseBenefitMonth
	,string20 CaseID
	,string30 CaseLastName
	,string25 CaseFirstName
	,string25 CaseMiddleName
	,string10 CasePhone1
	,string10 CasePhone2
	,string256 CaseEmail
	,string70 CasePhysicalStreet1
	,string70 CasePhysicalStreet2
	,string30 CasePhysicalCity
	,string2 CasePhysicalState
	,string9 CasePhysicalZip
	,string70 CaseMailStreet1
	,string70 CaseMailStreet2
	,string30 CaseMailCity
	,string2 CaseMailState
	,string9 CaseMailZip
	,string3 CaseCountyParishCode
	,string25 CaseCountyParishName
	,string20 ClientID
	,string30 ClientLastName
	,string25 ClientFirstName
	,string25 ClientMiddleName
	,string1 ClientGender
	,string1 ClientRace
	,string1 ClientEthnicity
	,string9 ClientSSN
	,string1 ClientSSNType
	,string8 ClientDOB
	,string1 ClientDOBType
	,string1 ClientEligibilityStatus
	,string8 ClientEligibilityDate
	,string10 ClientPhone
	,string256 ClientEmail
	,string50 StateContactName
	,string10 StateContactPhone
	,string10 StateContactPhoneExtension
	,string256 StateContactEmail
	,string3 LexIdScore
	,string10 MatchCodes
	,unsigned6 OrigSearchSequenceNumber
	,string4 SearchSequenceNumber
	,unsigned6 OrigClientSequenceNumber
	,string4 ClientSequenceNumber
	,unsigned4 SearchNCFFileDate
	,unsigned4 ClientNCFFileDate
	,unsigned4 SearchProcessDate
	,unsigned4 ClientProcessDate
	,string1	ClientEligibleStatusIndicator
end;

export DBC := RECORD
		Collisions
					- [
						pri
						,matchset
						,LexID
						,SearchEligibilityDate
						,SearchEligibilityStatus
						,OrigSearchSequenceNumber
						,SearchSequenceNumber
						,OrigClientSequenceNumber
						,ClientSequenceNumber
						,SearchNCFFileDate
						,ClientNCFFileDate
						,SearchProcessDate
						,ClientProcessDate
						,ClientEligibleStatusIndicator
						]
		,string4 SequenceNumber
		,string1 LF:='\n'
	END;

export MSH:=record
		string1 ActivityType
		,string40 ActivitySource
		,string16 ESPTransactionId
		,string10 MRFRecordNumber
		,string20 DrupalUserLoginId
		,string15 DrupalUserIP
		,string2 DrupalUserState
		,string20 EndUserName
		,string15 EndUserIP
		,string16 DrupalTransactionId
		,string4 QueryStatus
		,string70 QueryStatusMessage
		,string20 SearchCaseId
		,string20 SearchClientId
		,string60 SearchFullName
		,string30 SearchLastName
		,string25 SearchFirstName
		,string25 SearchMiddleName
		,string5 SearchSuffix
		,string9 SearchSSN
		,string8 SearchDOB
		,string1 SearchBenefitType
		,string6 SearchBenefitMonth
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
		,string1 IncludeTwelveMonthHistory
		,string2 CaseState
		,string1 CaseBenefitType
		,string6 CaseBenefitMonth
		,string20 CaseID
		,string30 CaseLastName
		,string25 CaseFirstName
		,string25 CaseMiddleName
		,string10 CasePhone1
		,string10 CasePhone2
		,string256 CaseEmail
		,string70 CasePhysicalStreet1
		,string70 CasePhysicalStreet2
		,string30 CasePhysicalCity
		,string2 CasePhysicalState
		,string9 CasePhysicalZip
		,string70 CaseMailStreet1
		,string70 CaseMailStreet2
		,string30 CaseMailCity
		,string2 CaseMailState
		,string9 CaseMailZip
		,string3 CaseCountyParishCode
		,string25 CaseCountyParishName
		,string20 ClientID
		,string30 ClientLastName
		,string25 ClientFirstName
		,string25 ClientMiddleName
		,string1 ClientGender
		,string1 ClientRace
		,string1 ClientEthnicity
		,string9 ClientSSN
		,string1 ClientSSNType
		,string8 ClientDOB
		,string1 ClientDOBType
		,string1 ClientEligibilityStatus
		,string8 ClientEligibilityDate
		,string10 ClientPhone
		,string256 ClientEmail
		,string50 StateContactName
		,string10 StateContactPhone
		,string10 StateContactPhoneExtension
		,string256 StateContactEmail
		,string3 LexIdScore
		,string10 MatchCodes
		,string84 TwelveMonthHistory
		,string4 SequenceNumber
		,string1 LF:='\n'
	end;

	// NCM Example:		GA_NCF_20131001_100915.dat,GA,20131001,100915,Y,292,0,0,981
	export	NCM	:=
	record
		string		Filename;
		string		State;
		string		FileDate;
		string		FileTime;
		string		IsAccepted;
		string		RecordsTotal;
		string		RecordsRejected;
		string		ErrorCount;
		string		WarningCount;
	end;

	export	NCD	:=
	record
		string1		RecordType;					// C=Contribution, R=Record, F=Field
		string2		Filler1	:=	'';
		string4		Code;
		string2		Filler2	:=	'';
		string4		CodeValue;
		string2		Filler3	:=	'';
		string40	Description;
		string2		Filler4	:=	'';
		string12	CodeCount;
		string2		Filler5	:=	'';
		string8		CodePercent;
		//string2		Filler6	:=	'';
		//string12	SampleRecord;
		string2		Filler7	:=	'';
		string80	SampleValue;
		string1		LF	:=	'\n';
	end;

	export	MRR :=
	record
		string1		ActivityType;
		string8		BatchJobId;
		string40	BatchFileName;
		string10	BatchRecordNumber;
		string20	RequestRecordID;
		string20	SearchCaseID;
		string20	SearchClientID;
		string1		SearchBenefitType;
		string6		SearchBenefitMonth;
		string60	SearchFullName;
		string30	SearchLastName;
		string25	SearchFirstName;
		string25	SearchMiddleName;
		string5		SearchSuffix;
		string9		SearchSSN;
		string8		SearchDOB;
		string70	SearchAddress1StreetAddress1;
		string70	SearchAddress1StreetAddress2;
		string30	SearchAddress1City;
		string2		SearchAddress1State;
		string9		SearchAddress1Zip;
		string70	SearchAddress2StreetAddress1;
		string70	SearchAddress2StreetAddress2;
		string30	SearchAddress2City;
		string2		SearchAddress2State;
		string9		SearchAddress2Zip;
		string1		IncludeTwelveMonthHistory;
		string4		QueryStatus;
		string70	QueryStatusMessage;
		string2		CaseState;
		string1		CaseBenefitType;
		string6		CaseBenefitMonth;
		string20	CaseID;
		string30	CaseLastName;
		string25	CaseFirstName;
		string25	CaseMiddleName;
		string10	CasePhone1;
		string10	CasePhone2;
		string256	CaseEmail;
		string70	CasePhysicalStreet1;
		string70	CasePhysicalStreet2;
		string30	CasePhysicalCity;
		string2		CasePhysicalState;
		string9		CasePhysicalZip;
		string70	CaseMailStreet1;
		string70	CaseMailStreet2;
		string30	CaseMailCity;
		string2		CaseMailState;
		string9		CaseMailZip;
		string3		CaseCountyParishCode;
		string25	CaseCountyParishName;
		string20	ClientID;
		string30	ClientLastName;
		string25	ClientFirstName;
		string25	ClientMiddleName;
		string1		ClientGender;
		string1		ClientRace;
		string1		ClientEthnicity;
		string9		ClientSSN;
		string1		ClientSSNType;
		string8		ClientDOB;
		string1		ClientDOBType;
		string1		ClientEligibilityStatus;
		string8		ClientEligibilityDate;
		string10	ClientPhone;
		string256	ClientEmail;
		string50	StateContactName;
		string10	StateContactPhone;
		string10	StateContactPhoneExtension;
		string256	StateContactEmail;
		string3		LexIdScore;
		string10	MatchCodes;
		string84	TwelveMonthHistory;
		string4		SequenceNumber;
		string1		LF;
	end;
	
	export	MRR2 :=
	record
		string1		ActivityType;								// =2 for NAC processes internal use
		string10	BatchJobId;
		string40	BatchFileName;
		string10	BatchRecordNumber;					// numeric
		string20	RequestRecordID;
		string20	SearchCaseID;
		string20	SearchClientID;
		string1		SearchProgramCode;
		string1		SearchRangeType;						// M=Month, D=Date
		string8		SearchEligibilityStart;			// CCYYMMDD	
		string8		SearchEligibilityEnd;			// CCYYMMDD	
		
		string60	SearchFullName;
		string30	SearchLastName;
		string25	SearchFirstName;
		string25	SearchMiddleName;
		string5		SearchSuffixName;
		
		string9		SearchSSN;
		string8		SearchDOB;
		
		string70	SearchAddress1StreetAddress1;
		string70	SearchAddress1StreetAddress2;
		string30	SearchAddress1City;
		string2		SearchAddress1State;
		string9		SearchAddress1Zip;
		
		string70	SearchAddress2StreetAddress1;
		string70	SearchAddress2StreetAddress2;
		string30	SearchAddress2City;
		string2		SearchAddress2State;
		string9		SearchAddress2Zip;
		
		string1		IncludeEligibilityHistory;
		string1		IncludeInterstateAllPrograms;

		string4		QueryStatus;
		string70	QueryStatusMessage;
		
		string4		CaseNacGroupId;
		string2		CaseProgramState;
		string1		CaseProgramCode;
		
		string20	CaseID;
		string30	CaseLastName;
		string25	CaseFirstName;
		string25	CaseMiddleName;
		string5		CaseSuffixName;
		
		string10	CaseMonthlyAllotment;
		string3		CaseRegionCode;
		string3		CaseCountyParishCode;		// FIPS code
		string25	CaseCountyParishName;
		
		string10	CasePhone1;
		string10	CasePhone2;
		string256	CaseEmail;
		
		string1		PhysicalAddressCategory;
		string70	PhysicalAddressStreet1;
		string70	PhysicalAddressStreet2;
		string30	PhysicalAddressCity;
		string2		PhysicalAddressState;
		string9		PhysicalAddressZip;

		string1		MailAddressCategory;
		string70	MailAddressStreet1;
		string70	MailAddressStreet2;
		string30	MailAddressCity;
		string2		MailAddressState;
		string9		MailAddressZip;
		
		string20	ClientID;									// or individual ID
		string1		ClientHOHIndicator;
		string1		ClientABAWDIndicator;
		string1		ClientHoHRelationshipIndicator;
		
		string30	ClientLastName;
		string25	ClientFirstName;
		string25	ClientMiddleName;
		string5		ClientSuffixName;

		string1		ClientGender;
		string1		ClientRace;
		string1		ClientEthnicity;
		string9		ClientSSN;
		string1		ClientSSNType;
		string8		ClientDOB;						//YYYYMMDD
		string1		ClientDOBType;
		
		string20	ClientCertificateID;
		string10	ClientMonthlyAllotment;
		
		string1		ClientEligibilityStatus;
		string8		ClientEligibilityDate;		//YYYYMMDD
		string1		ClientEligibilityPeriodType;
		string5		ClientEligibilityPeriodCount;
		string8		ClientEligibilityPeriodStart;
		string8		ClientEligibilityPeriodEnd;
		
		string10	ClientPhone;
		string256	ClientEmail;
		
		string50	StateContactName;
		string10	StateContactPhone;
		string10	StateContactPhoneExtension;
		string256	StateContactEmail;
		string3		LexIdScore;
		string10	MatchCodes;
		
		string5		TotalEligiblePeriodsDays;
		string4		TotalEligiblePeriodsMonths;
		
		string3		ExceptionReasonCode;
		string50	ExceptionComments;
		string200	EligibilityPeriodsHistory;
		string4		SequenceNumber;
		string1		LF;
	end;


	export	SSE	:=
	record
		string1		ActivityType;
		string6		CaseBenefitMonth;
		string1		CaseBenefitType;
		string3		CaseCountyParishCode;
		string25	CaseCountyParishName;
		string256	CaseEmail;
		string25	CaseFirstName;
		string20	CaseID;
		string30	CaseLastName;
		string30	CaseMailCity;
		string2		CaseMailState;
		string70	CaseMailStreet1;
		string70	CaseMailStreet2;
		string9		CaseMailZip;
		string25	CaseMiddleName;
		string10	CasePhone1;
		string10	CasePhone2;
		string30	CasePhysicalCity;
		string2		CasePhysicalState;
		string70	CasePhysicalStreet1;
		string70	CasePhysicalStreet2;
		string9		CasePhysicalZip;
		string2		CaseState;
		string8		ClientDOB;
		string1		ClientDOBType;
		string8		ClientEligibilityDate;
		string1		ClientEligibilityStatus;
		string256	ClientEmail;
		string1		ClientEthnicity;
		string25	ClientFirstName;
		string1		ClientGender;
		string20	ClientID;
		string30	ClientLastName;
		string25	ClientMiddleName;
		string10	ClientPhone;
		string1		ClientRace;
		string9		ClientSSN;
		string1		ClientSSNType;
		string16	DrupalTransactionId;
		string15	DrupalUserIP;
		string20	DrupalUserLoginId;
		string2		DrupalUserState;
		string16	ESPTransactionId;
		string15	EndUserIP;
		string20	EndUserName;
		string1		IncludeTwelveMonthHistory;
		string3		LexIdScore;
		string2		MSHRecipientState;
		string10	MatchCodes;
		string4		QueryStatus;
		string70	QueryStatusMessage;
		string30	SearchAddress1City;
		string2		SearchAddress1State;
		string70	SearchAddress1StreetAddress1;
		string70	SearchAddress1StreetAddress2;
		string9		SearchAddress1Zip;
		string30	SearchAddress2City;
		string2		SearchAddress2State;
		string70	SearchAddress2StreetAddress1;
		string70	SearchAddress2StreetAddress2;
		string9		SearchAddress2Zip;
		string6		SearchBenefitMonth;
		string1		SearchBenefitType;
		string20	SearchCaseId;
		string20	SearchClientId;
		string8		SearchDOB;
		string25	SearchFirstName;
		string60	SearchFullName;
		string30	SearchLastName;
		string25	SearchMiddleName;
		string9		SearchSSN;
		string5		SearchSuffix;
		string4		SequenceNumber;
		string256	StateContactEmail;
		string50	StateContactName;
		string10	StateContactPhone;
		string10	StateContactPhoneExtension;
		string84	TwelveMonthHistory;
		string1		InvestigativePurpose;
		string2		SearchBenefitState;
		string6		SearchBenefitMonthStart;
		string6		SearchBenefitMonthEnd;
		string1		SearchEligibilityStatus;
		string1		LF;
	end;
	
	export MRF2	:=
	record
		string20	RequestRecordID;
		string20	SearchCaseId;
		string20	SearchClientId;
		string1		SearchprogramCode;
		string1		SearchRangeType;
		string8		SearchEligibilityStart;
		string8		SeachEligibilityEnd;
		string60	SearchFullName;
		string30	SearchLastName;
		string25	SearchFirstName;
		string25	SearchMiddleName;
		string5		SearchSuffixName;
		string9		SearchSSN;
		string8		SearchDOB;
		string70	SearchAddress1StreetAddress1;
		string70	SearchAddress1StreetAddress2;
		string30	SearchAddress1City;
		string2		SearchAddress1State;
		string9		SearchAddress1Zip;
		string70	SearchAddress2StreetAddress1;
		string70	SearchAddress2StreetAddress2;
		string30	SearchAddress2City;
		string2		SearchAddress2State;
		string9		SearchAddress2Zip;
		string1		SearchIncludeEligibilityHistory;
		string1		SearchIncludeInterstateAllPrograms;
	end;
	
	export MRX2 :=
	record
		string1		ActivityType;								// =2 for NAC processes internal use
		string10	BatchJobId;
		string40	BatchFileName;
		string10	BatchRecordNumber;					// numeric
		string20	RequestRecordID;
		string20	SearchCaseID;
		string20	SearchClientID;
		string1		SearchProgramCode;
		string1		SearchRangeType;						// M=Month, D=Date
		string8		SearchEligibilityStart;			// CCYYMMDD	
		string8		SearchEligibilityEnd;			// CCYYMMDD	
		
		string60	SearchFullName;
		string30	SearchLastName;
		string25	SearchFirstName;
		string25	SearchMiddleName;
		string5		SearchSuffixName;
		
		string9		SearchSSN;
		string8		SearchDOB;
		
		string70	SearchAddress1StreetAddress1;
		string70	SearchAddress1StreetAddress2;
		string30	SearchAddress1City;
		string2		SearchAddress1State;
		string9		SearchAddress1Zip;
		
		string70	SearchAddress2StreetAddress1;
		string70	SearchAddress2StreetAddress2;
		string30	SearchAddress2City;
		string2		SearchAddress2State;
		string9		SearchAddress2Zip;
		
		string1		IncludeEligibilityHistory;
		string1		IncludeInterstateAllPrograms;
		string4		QueryStatus;
		string70	QueryStatusMessage;
	end;
	
	export MSX2 :=
	record
		string1		ActivityType;								// 1=single 2=batch
		string40	ActivitySource;							// batch filename
		string16	NACTransactionId;						// ESP Transaction ID or Batch Jodb ID
		
		string10	BatchRecordNumber;					// numeric
		string20	RequestRecordID;
		string20	NACUserId;
		string15	NACUserIP;
		string20	EndUserId;
		string15	EndUserIP;
		
		string4		QueryStatus;
		string70	QueryStatusMessage;

		string20	SearchCaseID;
		string20	SearchClientID;
		string1		SearchProgramCode;
		string1		SearchRangeType;						// M=Month, D=Date
		string8		SearchEligibilityStart;			// CCYYMMDD	
		string8		SearchEligibilityEnd;			// CCYYMMDD	

		string60	SearchFullName;
		string30	SearchLastName;
		string25	SearchFirstName;
		string25	SearchMiddleName;
		string5		SearchSuffixName;
		string9		SearchSSN;
		string8		SearchDOB;
		
		string70	SearchAddress1StreetAddress1;
		string70	SearchAddress1StreetAddress2;
		string30	SearchAddress1City;
		string2		SearchAddress1State;
		string9		SearchAddress1Zip;
		
		string70	SearchAddress2StreetAddress1;
		string70	SearchAddress2StreetAddress2;
		string30	SearchAddress2City;
		string2		SearchAddress2State;
		string9		SearchAddress2Zip;
		
		string1		IncludeEligibilityHistory;
		string1		IncludeInterstateAllPrograms;
		string1   LineFeed := '\n';
	end;

	export	MSH2	:=
	record
		MSX2 -[LineFeed];
		string4		CaseNACGroupID;
		string2		CaseState;
		string1		CaseProgramCode;
		string20	CaseID;
		string30	CaseLastName;
		string25	CaseFirstName;
		string25	CaseMiddleName;
		string5		CaseSuffixName;
		string10	CaseMonthlyAllotment;
		string3		CaseRegionCode;
		string3		CaseCountyParishCode;
		string25	CaseCountyParishName;
		string10	CasePhone1;
		string10	CasePhone2;
		string256	CaseEmail;
		string1		PhysicalAddressCategory;
		string70	PhysicalAddressStreet1;
		string70	PhysicalAddressStreet2;
		string30	PhysicalAddressCity;
		string2		PhysicalAddressState;
		string9		PhysicalAddressZip;
		string1		MailAddressCategory;
		string70	MailAddressStreet1;
		string70	MailAddressStreet2;
		string30	MailAddressCity;
		string2		MailAddressState;
		string9		MailAddressZip;
		string20	ClientID;
		string1		ClientHoHIndicator;
		string1		ClientABAWDIndicator;
		string1		ClientHoHRelationshipIndicator;
		string30	ClientLastName;
		string25	ClientFirstName;
		string25	ClientMiddleName;
		string5		ClientSuffixName;
		string1		ClientGender;
		string1		ClientRace;
		string1		ClientEthnicity;
		string9		ClientSSN;
		string1		ClientSSNType;
		string8		ClientDOB;
		string1		ClientDOBType;
		string20	ClientCertificateID;
		string10	ClientMonthlyAllotment;
		string1		ClientEligibilityStatus;
		string8		ClientEligibilityDate;
		string1		ClientEligibilityPeriodType;
		string5		ClientEligibilityPeriodCount;
		string8		ClientEligibilityPeriodStart;
		string8		ClientEligibilityPeriodEnd;
		string10	ClientPhone;
		string256	ClientEmail;
		string50	StateContactName;
		string10	StateContactPhone;
		string10	StateContactPhoneExtension;
		string256	StateContactEmail;
		string3		LexIdScore;
		string10	MatchCodes;
		string5		TotalEligiblePeriodsDays;
		string4		TotalEligiblePeriodsMonths;
		string3		ExceptionReasonCode;
		string50	ExceptionComments;
		string200	EligibilityPeriodsHistory;
		string4		SequenceNumber;
		string1   LineFeed := '\n';
	end;

	export	MSX2PlusInternal	:=
	record
		string4		TargetNACGroupID;						// Internal
		string2		SourceState;								// Internal
		string30	ServiceName;								// Internal
		MSX2 -[LineFeed];
	end;

	export	MSH2PlusInternal :=
	record
		MSX2PlusInternal;
		MSH2 -[LineFeed];
	end;
		
end;