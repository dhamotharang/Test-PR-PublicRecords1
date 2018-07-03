import risk_indicators, iesp;

export layouts := module

export Layout_HealthCare_Attributes_Batch_In := RECORD
	unsigned4	seq;
	STRING30  AcctNo;
	STRING9   SSN;
	STRING120 unParsedFullName :='';
	STRING30  Name_First;
	STRING30  Name_Middle;
	STRING30  Name_Last;
	STRING5   Name_Suffix;
	STRING8   DOB;
	STRING65 	street_addr := '';
	STRING25  p_City_name;
	STRING2   St;
	STRING5   Z5;
	STRING10  Home_Phone;
	unsigned3 HistorydateYYYYMM;
  UNSIGNED6 UniqueID;
END;

export Layout_HealthCare_Attributes_Batch := RECORD
	STRING20 		AcctNo;
  UNSIGNED6 	DID;
	UNSIGNED3 	HistoryDate; 
	DECIMAL8_2	EstimatedHHSize;
	STRING2			HHOccupantDescription;
	DECIMAL8_2	CensusAveHHSize;
	UNSIGNED3 	EstimatedHHIncome;
END;

EXPORT Layout_HealthCare_Attributes_In := RECORD
	STRING30 	Seq := '1';
	STRING5  	Title := '';
	STRING20 	FirstName := '';
	STRING20 	MiddleName := '';
	STRING20 	LastName := '';
	STRING5 	SuffixName := '';
	STRING120 streetAddr := '';
	STRING25 	City := '';
	STRING2 	State := '';
	STRING5 	Zip := '';
	STRING25 	County := '';
	STRING10 	HomePhone := '';
	STRING10 	WorkPhone := '';
	STRING8 	DateOfBirth := '';
	STRING9 	SSN := '';
	STRING20 	AccountNumber := '';
  UNSIGNED6 DID := 0;
	UNSIGNED3 HistoryDate := 999999; 
END;

EXPORT Layout_HealthCare_Attributes := RECORD
	DECIMAL8_2	EstimatedHHSize;
	STRING2			HHOccupantDescription;
	DECIMAL8_2	CensusAveHHSize;
	UNSIGNED3 	EstimatedHHIncome;
END;

export Layout_CDM_Batch_In := RECORD
	unsigned4	seq;
	STRING30  AcctNo;
  STRING12 	ADL;
	STRING3 	ADLScore;
	STRING30  Name_First;
	STRING30  Name_Middle;
	STRING30  Name_Last;
	STRING5   Name_Suffix;
	STRING120 unParsedFullName :='';
	STRING120 Name_Company :='';
	STRING9   SSN;
	STRING65 	street_addr := '';
	STRING65 	street_addr_2 := '';
	STRING25  p_City_name;
	STRING2   St;
	STRING9   Zip;
	STRING8   DOB;
	STRING10  Service_Request;
	STRING2   Record_Type;
	STRING10  Phone_1;
	STRING10  Phone_2;
	STRING10  Phone_3;
	STRING10  Phone_4;
	STRING10  Phone_5;
	unsigned3 HistorydateYYYYMM;
END;

export Layout_CDM_Batch_Out := record
  string30 	AcctNo;
	unsigned4 seq;
	
	// ssn
	string2	  IDVerSSNCreditBureauCount;
	string4   IDVerSSNCreditBureauMonthsSeen;
	string3 	IDVerSSNGovernmentCount;
	string4   IDVerSSNGovernmentMonthsSeen;
	string2		IDVerSSNDriversLicense;
	string4		IDVerSSNDriversLicenseMonthsSeen;
	string3		IDVerSSNBehavioralCount;
	string4		IDVerSSNBehavioralMonthsSeen;
	
	// addr
	string2		IDVerAddrMatchesCurrent;
	string2		IDVerAddrCreditBureauCount;
	string4		IDVerAddrCreditBureauMonthsSeen;
	string3		IDVerAddrGovernmentCount;
	string4		IDVerAddrGovernmentMonthsSeen;
	string2		IDVerAddrDriversLicense;
	string4		IDVerAddrDriversLicenseMonthsSeen;
	string2		IDVerAddrVoterRegistration;
	string4		IDVerAddrVoterRegMonthsSeen;
	string2		IDVerAddrVehicleRegistration;
	string4		IDVerAddrVehicleRegMonthsSeen;
	string2		IDVerAddrProperty;
	string4		IDVerAddrPropertyMonthsSeen;
	string3		IDVerAddrBehavioralCount;
	string4		IDVerAddrBehavioralMonthsSeen;
	
	// dob
	string2		IDVerDOBCreditBureauCount;
	string4		IDVerDOBCreditBureauMonthsSeen;
	string3		IDVerDOBGovernmentCount;
	string4		IDVerDOBGovernmentMonthsSeen;
	string2		IDVerDOBDriversLicense;
	string4		IDVerDOBDriversLicenseMonthsSeen;
	string2		IDVerDOBVoterRegistration;
	string4		IDVerDOBVoterRegMonthsSeen;
	string2		IDVerDOBVehicleRegistration;
	string4		IDVerDOBVehicleRegMonthsSeen;
	string3		IDVerDOBBehavioralCount;
	string4		IDVerDOBBehavioralMonthsSeen;
	
	// firstname
	string2		IDVerFirstNameCreditBureauCount;
	string4   IDVerFirstNameCreditBureauMonthsSeen;
	string3		IDVerFirstNameGovernmentCount;
	string4   IDVerFirstNameGovernmentMonthsSeen;
	string3 	IDVerFirstNameBehavioralCount;
	string4		IDVerFirstNameBehavioralMonthsSeen;
  
 // lastname
	string2		IDVerLastNameCreditBureauCount;
	string4   IDVerLastNameCreditBureauMonthsSeen;
	string3		IDVerLastNameGovernmentCount;
	string4   IDVerLastNameGovernmentMonthsSeen;
	string3 	IDVerLastNameBehavioralCount;
	string4		IDVerLastNameBehavioralMonthsSeen;
  
 // deceased
	string2		IDVerDeceasedCreditBureauCount;
	string4   IDVerDeceasedCreditBureauMonthsSeen;
	string3		IDVerDeceasedGovernmentCount;
	string4   IDVerDeceasedGovernmentMonthsSeen;
	string3 	IDVerDeceasedBehavioralCount;
	string4		IDVerDeceasedBehavioralMonthsSeen;
	
end;


export Layout_LeadIntegrity_Batch_In := RECORD
	unsigned4	seq;
	STRING30  AcctNo;
	STRING9   SSN;
	STRING120 unParsedFullName :='';
	STRING30  Name_First;
	STRING30  Name_Middle;
	STRING30  Name_Last;
	STRING5   Name_Suffix;
	STRING8   DOB;
	STRING65 	street_addr := '';
	STRING25  p_City_name;
	STRING2   St;
	STRING5   Z5;
	STRING20  DL_Number;
	STRING2   DL_State;
	STRING10  Home_Phone;
	STRING10  Work_Phone;
	unsigned3 HistorydateYYYYMM;
		unsigned6 LexID;
END;


export layout_LeadIntegrity_attributes_batch_v1 := record
	string20 seq;
	string30 acctno;
		
// Identity Authentication Attributes
	string8 SubjectFirstSeen;
	string8 DateLastUpdate;
	string1 RecentUpdate;
	string3 NumSrcsConfirmIDAddr;
	string1 PhoneFullNameMatch;
	string1 PhoneLastNameMatch;
	string3 AgeRiskIndicator;  // NEW LOGIC around inferred_dob  > 18, > 21, >70, >80
	string1 InvalidSSN;
	string1 InvalidPhone;
	string1 InvalidAddr;
	string1 NoVerifyNameAddrPhoneSSN;

// SSN Attributes
	string1 SSNDeceased;
	string8 DateSSNDeceased;
	string1 SSNIssued;
	string1 RecentSSN;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 SSNIssueState;
	string1 NonUSssn;
	string1 SSN3Years;
	string1 SSNAfter5;
	string3 SSNProbs;
	
// Evidence of Compromised Identity
	string1 SSNNotFound;
	string1 SSNFoundOther;
	string1 SSNIssuedPrior;
	string1 PhoneOther;
	string3 SSNPerID;
	string3 AddrPerID;
	string3 PhonePerID;
	string3 IDPerSSN;
	string3 AddrPerSSN;
	string3 IDPerAddr;
	string3 SSNPerAddr;
	string3 PhonePerAddr;
	string3 IDPerPhone;
	string3 SSNPerID6;
	string3 AddrPerID6;
	string3 PhonePerID6;
	string3 IDPerSSN6;
	string3 AddrPerSSN6;
	string3 IDPerAddr6;
	string3 SSNPerAddr6;
	string3 PhonePerAddr6;
	string3 IDPerPhone6;

// Identity Change Information
	string3 LastNamePerSSN;
	string3 LastNamePerID;
	string4 TimeSinceLastName;	
	string3 LastNames30;
	string3 LastNames90;
	string3 LastNames180;
	string3 LastNames12;
	string3 LastNames24;
	string3 LastNames36;
	string3 LastNames60;
	string3 IDPerSFDUAddr;
	string3 SSNPerSFDUAddr;

// Characteristics of Input Address
	string3 TimeSinceInputAddrFirstSeen;
	string3 TimeSinceInputAddrLastSeen;
	string3 InputAddrLenOfRes;
	string1 InputAddrDwellType;
	string1 InputAddrLandUseCode;
	string10 InputAddrAssessedValue;
	string4 InputAddrTaxAssessedYr;
	string1 InputAddrApplicantOwned;
	string1 InputAddrFamilyOwned;
	string1 InputAddrOccupantOwned;
	string8 InputAddrLastSalesDate;
	string10 InputAddrLastSalesAmount;	
	string1 InputAddrNotPrimaryRes;
	string1 InputAddrActivePhoneList;
	string10 InputAddrActivePhoneNumber;
	string10 InputAddrMedianIncome;
	string10 InputAddrMedianHomeVal;
	string3 InputAddrMurderIndex;
	string3 InputAddrCarTheftIndex;
	string3 InputAddrBurglaryIndex;
	string3 InputAddrCrimeIndex;
	string10 InputAddrAssessMarket;
	string10 InputAddrTaxAssessVal;
	string10 InputAddrPriceIndVal;
	string10 InputAddrHedVal;
	string10 InputAddrAutoVal;
	string2 InputAddrConfScore;
	string5 InputAddrCountyIndex;
	string5 InputAddrTractIndex;
	string5 InputAddrBlockIndex;
	

// Characteristics of Current Address (most recently reported)
	string3 TimeSinceCurrAddrFirstSeen;
	string3 TimeSinceCurrAddrLastSeen;
	string3 CurrAddrLenOfRes;
	string1 CurrAddrDwellType;
	string1 CurrAddrLandUseCode;
	string10 CurrAddrAssessedValue;
	string4 CurrAddrTaxAssessedYr;
	string1 CurrAddrApplicantOwned;
	string1 CurrAddrFamilyOwned;
	string1 CurrAddrOccupantOwned;
	string8 CurrAddrLastSalesDate;
	string10 CurrAddrLastSalesAmount;	
	string1 CurrAddrNotPrimaryRes;
	string1 CurrAddrActivePhoneList;
	string10 CurrAddrActivePhoneNumber;
	string10 CurrAddrMedianIncome;
	string10 CurrAddrMedianHomeVal;
	string3 CurrAddrMurderIndex;
	string3 CurrAddrCarTheftIndex;
	string3 CurrAddrBurglaryIndex;
	string3 CurrAddrCrimeIndex;
	string10 CurrAddrAssessMarket;
	string10 CurrAddrTaxAssessVal;
	string10 CurrAddrPriceIndVal;
	string10 CurrAddrHedVal;
	string10 CurrAddrAutoVal;
	string2 CurrAddrConfScore;
	string5 CurrAddrCountyIndex;
	string5 CurrAddrTractIndex;
	string5 CurrAddrBlockIndex;

	
// Characteristics of Previous Address (next most recently reported)
	string3 TimeSincePrevAddrFirstSeen;
	string3 TimeSincePrevAddrLastSeen;
	string3 PrevAddrLenOfRes;
	string1 PrevAddrDwellType;
	string1 PrevAddrLandUseCode;
	string10 PrevAddrAssessedValue;
	string4 PrevAddrTaxAssessedYr;	
	string1 PrevAddrApplicantOwned;
	string1 PrevAddrFamilyOwned;
	string1 PrevAddrOccupantOwned;
	string8 PrevAddrLastSalesDate;
	string10 PrevAddrLastSalesAmount;	
	string1 PrevAddrNotPrimaryRes;
	string1 PrevAddrActivePhoneList;
	string10 PrevAddrActivePhoneNumber;
	string10 PrevAddrMedianIncome;
	string10 PrevAddrMedianHomeVal;
	string3 PrevAddrMurderIndex;
	string3 PrevAddrCarTheftIndex;
	string3 PrevAddrBurglaryIndex;
	string3 PrevAddrCrimeIndex;
	string10 PrevAddrAssessMarket;
	string10 PrevAddrTaxAssessVal;
	string10 PrevAddrPriceIndVal;
	string10 PrevAddrHedVal;
	string10 PrevAddrAutoVal;
	string2 PrevAddrConfScore;
	string5 PrevAddrCountyIndex;
	string5 PrevAddrTractIndex;
	string5 PrevAddrBlockIndex;


// Differences between Input Address and Current Address
	string1 InputAddrCurrAddrMatch;
	string4 InputAddrCurrAddrDistance;
	string1 InputAddrCurrAddrStateDiff;
	string11 InputAddrCurrAddrAssessedDiff;
	string11 InputAddrCurrAddrIncomeDiff;
	string11 InputAddrCurrAddrHomeValDiff;
	string4 InputAddrCurrAddrCrimeDiff;
	string2 EconomicTrajectory;
	
// Differences between Current Address and Previous Address
	string1 InputAddrPrevAddrMatch;
	string4 CurrAddrPrevAddrDistance;
	string1 CurrAddrPrevAddrStateDiff;
	string11 CurrAddrPrevAddrAssessedDiff;
	string11 CurrAddrPrevAddrIncomeDiff;
	string11 CurrAddrPrevAddrHomeValDiff;
	string4 CurrAddrPrevAddrCrimeDiff;
	string2 EconomicTrajectory2;

// Transient Person Attributes
	string1 AddrStability;
	string1 StatusMostRecent;
	string1 StatusPrevious;
	string1 StatusNextPrevious;
	string3 TimeSincePrevAddrDateFirstSeen;
	string3 TimeSinceNextPrevDateFirstSeen;
	string3 AddrChanges30;
	string3 AddrChanges90;
	string3 AddrChanges180;
	string3 AddrChanges12;
	string3 AddrChanges24;
	string3 AddrChanges36;
	string3 AddrChanges60;
	
// Property and Asset Information
	string3 PropertyOwnedTotal;
	string12 PropertyOwnedAssessedTotal;
	string3 PropertyHistoricallyOwned;
	string8 DateFirstPurchase;
	string8 DateMostRecentPurchase;
	string8 DateMostRecentSale;
	string3 PropPurchased30;
	string3 PropPurchased90;
	string3 PropPurchased180;
	string3 PropPurchased12;
	string3 PropPurchased24;
	string3 PropPurchased36;
	string3 PropPurchased60;
	string3 PropSold30;
	string3 PropSold90;
	string3 PropSold180;
	string3 PropSold12;
	string3 PropSold24;
	string3 PropSold36;
	string3 PropSold60;
	string3 NumWatercraft;
	string3 NumWatercraft30;
	string3 NumWatercraft90;
	string3 NumWatercraft180;
	string3 NumWatercraft12;
	string3 NumWatercraft24;
	string3 NumWatercraft36;
	string3 NumWatercraft60;
	string3 NumAircraft;
	string3 NumAircraft30;
	string3 NumAircraft90;
	string3 NumAircraft180;
	string3 NumAircraft12;
	string3 NumAircraft24;
	string3 NumAircraft36;
	string3 NumAircraft60;
	string1 WealthIndex;
	
	
// Derogatory Public Records
	string3 TotalNumberDerogs;
	string8 DateLastDerog;
	string3 NumFelonies;
	string8 DateLastConviction;
	string3 NumFelonies30;
	string3 NumFelonies90;
	string3 NumFelonies180;
	string3 NumFelonies12;
	string3 NumFelonies24;
	string3 NumFelonies36;
	string3 NumFelonies60;
	
	string3 NumArrests;
	string8 DateLastArrest;
	string3 NumArrests30;
	string3 NumArrests90;
	string3 NumArrests180;
	string3 NumArrests12;
	string3 NumArrests24;
	string3 NumArrests36;
	string3 NumArrests60;
	
	string3 LiensCount;
	string3 LiensUnreleasedCount;
	string8 MostRecentUnrelDate;
	string3 LiensUnreleasedCount30;
	string3 LiensUnreleasedCount90;
	string3 LiensUnreleasedCount180;
	string3 LiensUnreleasedCount12;
	string3 LiensUnreleasedCount24;
	string3 LiensUnreleasedCount36;
	string3 LiensUnreleasedCount60;
	string3 LiensReleasedCount;
	string8 MostRecentReleasedDate;
	string3 LiensReleasedCount30;
	string3 LiensReleasedCount90;
	string3 LiensReleasedCount180;
	string3 LiensReleasedCount12;
	string3 LiensReleasedCount24;
	string3 LiensReleasedCount36;
	string3 LiensReleasedCount60;
	
	string3 BankruptCount;
	string8 MostRecentBankruptDate;
	string1 MostRecentBankruptType;
	string35 MostRecentBankruptStatus;
	string3 BankruptCount30;
	string3 BankruptCount90;
	string3 BankruptCount180;
	string3 BankruptCount12;
	string3 BankruptCount24;
	string3 BankruptCount36;
	string3 BankruptCount60;

	string3 EvictionCount;
	string8 MostRecentEvictionDate;
	string3 EvictionCount30;
	string3 EvictionCount90;
	string3 EvictionCount180;
	string3 EvictionCount12;
	string3 EvictionCount24;
	string3 EvictionCount36;
	string3 EvictionCount60;
	
// Non-Derogatory Public Records	
	string3 NonDerogSrcCount;
	string3 NonDerogSrcCount30;
	string3 NonDerogSrcCount90;
	string3 NonDerogSrcCount180;
	string3 NonDerogSrcCount12;
	string3 NonDerogSrcCount24;
	string3 NonDerogSrcCount36;
	string3 NonDerogSrcCount60;
	
	string3 ProfLicCount;
	string8 MostRecentProfLicDate;
	string8 MostRecentProfLicExpireDate;
	string3 ProfLicCount30;
	string3 ProfLicCount90;
	string3 ProfLicCount180;
	string3 ProfLicCount12;
	string3 ProfLicCount24;
	string3 ProfLicCount36;
	string3 ProfLicCount60;
	string3 ProfLicExpireCount30;
	string3 ProfLicExpireCount90;
	string3 ProfLicExpireCount180;
	string3 ProfLicExpireCount12;
	string3 ProfLicExpireCount24;
	string3 ProfLicExpireCount36;
	string3 ProfLicExpireCount60;

// Higher Risk Address and Phone Attributes
	string1 InputAddrHighRisk;
	string1 InputPhoneHighRisk;
  string4 SIC;
	string1 InputAddrPrison;
	string1 InputZipPOBox;
	string1 InputZipCorpMil;
	string1 InputPhoneStatus;
	string1 InputPhonePager;
	string1 InputPhoneMobile;
	string3 TimeSinceSubjectPhoneFirstSeen;
	string3 TimeSinceSubjectPhoneLastSeen;
	string1 InvalidPhoneZip;
	string4 InputPhoneAddrDist;
	string1 PhoneType;
  string2 ServiceType;
	string1 AreaCodeChange;
	string1 AddrVal;
  string5 AddrValErrorCode;

// include a flag telling the customer if the applicant is on the Do Not Mail list
	string1 DoNotMail;

// for future use, possibly insurance model which uses the ITA filtering logic
	string3 score1 := '';
	string15 scorename1 := '';
	string2 reason1 := '';
	string2 reason2 := '';
	string2 reason3 := '';
	string2 reason4 := '';
	string2 reason5 := '';
	string2 reason6 := '';
end;

export layout_LeadIntegrity_attributes_batch_v3 := record
	string4 AgeOldestRecord;
	string4 AgeNewestRecord;
	string3 SrcsConfirmIDAddrCount;
	string1 CreditBureauRecord;
	string2 InvalidSSN;
	string2 InvalidPhone;
	string2 InvalidAddr;

	string2 SSNDeceased;
	string2 SSNIssued;
	string2 VerificationFailure;
	string2 SSNNotFound;
	string2 SSNFoundOther;
	string2 PhoneOther;


	string1 VerifiedName;
	string2 VerifiedSSN;
	string2 VerifiedPhone;
	string2 VerifiedPhoneFullName;
	string2 VerifiedPhoneLastName;
	string2 VerifiedAddress;
	string2 VerifiedDOB;

	string3 SubjectSSNCount;
	string3 SubjectAddrCount;
	string3 SubjectPhoneCount;
	string3 SubjectSSNRecentCount;
	string3 SubjectAddrRecentCount;
	string3 SubjectPhoneRecentCount;
	string3 SSNIdentitiesCount;
	string3 SSNAddrCount;
	string3 SSNIdentitiesRecentCount;
	string3 SSNAddrRecentCount;
	string3 InputAddrIdentitiesCount;
	string3 InputAddrSSNCount;
	string3 InputAddrPhoneCount;
	string3 InputAddrIdentitiesRecentCount;
	string3 InputAddrSSNRecentCount;
	string3 InputAddrPhoneRecentCount;
	string3 PhoneIdentitiesCount;
	string3 PhoneIdentitiesRecentCount;

	string3 SSNLastNameCount;
	string3 SubjectLastNameCount;
	// LastNameChangeAge not needed since TimeSinceLastAge is four bytes
	string3 LastNameChangeCount01;
	string3 LastNameChangeCount03;
	string3 LastNameChangeCount06;
	string3 LastNameChangeCount12;
	string3 LastNameChangeCount24;
	string3 LastNameChangeCount36;
	string3 LastNameChangeCount60;
	string3 SFDUAddrIdentitiesCount;
	string3 SFDUAddrSSNCount;


	string2 SSNRecent;
	string2 SSNNonUS;
	string2 SSN3Years;
	string2 SSNAfter5;
	string2 SSNIssuedPriorDOB;
	string3 RelativesCount;
	string3 RelativesBankruptcyCount;
	string3 RelativesFelonyCount;
	string3 RelativesPropOwnedCount;
	string13 RelativesPropOwnedTaxTotal;
	string2 RelativesDistanceClosest;
	string2 InputAddrDwellType;
	string2 InputAddrLandUseCode;
	string2 InputAddrApplicantOwned;
	string2 InputAddrFamilyOwned;
	string2 InputAddrOccupantOwned;
	string3 InputAddrAgeLastSale;
	string2 InputAddrNotPrimaryRes;
	string2 InputAddrActivePhoneList;
	string2 CurrAddrDwellType;
	string2 CurrAddrLandUseCode;
	string2 CurrAddrApplicantOwned;
	string2 CurrAddrFamilyOwned;
	string2 CurrAddrOccupantOwned;
	string3 CurrAddrAgeLastSale;
	string2 CurrAddrActivePhoneList;
	string2 PrevAddrDwellType;
	string2 PrevAddrLandUseCode;
	string2 PrevAddrApplicantOwned;
	string2 PrevAddrFamilyOwned;
	string2 PrevAddrOccupantOwned;
	string3 PrevAddrAgeLastSale;
	string2 PrevAddrActivePhoneList;
	string2 InputCurrAddrMatch;
	string2 InputCurrAddrStateDiff;
	string2 InputPrevAddrMatch;
	string2 CurrPrevAddrStateDiff;
	string1 EducationAttendedCollege;
	string2 EducationProgram2Yr;
	string2 EducationProgram4Yr;
	string2 EducationProgramGraduate;
	string2 EducationInstitutionPrivate;
	string2 EducationInstitutionRating;
	string2 EducationFieldofStudyType;
	string2 StatusMostRecent;
	string2 StatusPrevious;
	string2 StatusNextPrevious;

	string3 AddrChangeCount01;
	string3 AddrChangeCount03;
	string3 AddrChangeCount06;
	string3 AddrChangeCount12;
	string3 AddrChangeCount24;
	string3 AddrChangeCount36;
	string3 AddrChangeCount60;
	string3 PropOwnedCount;
	string3 PropOwnedHistoricalCount;

	string6 PredictedAnnualIncome;
	string3 PropAgeOldestPurchase;
	string3 PropAgeNewestPurchase;
	string3 PropAgeNewestSale;

	string3 PropPurchasedCount01;
	string3 PropPurchasedCount03;
	string3 PropPurchasedCount06;
	string3 PropPurchasedCount12;
	string3 PropPurchasedCount24;
	string3 PropPurchasedCount36;
	string3 PropPurchasedCount60;
	string3 PropSoldCount01;
	string3 PropSoldCount03;
	string3 PropSoldCount06;
	string3 PropSoldCount12;
	string3 PropSoldCount24;
	string3 PropSoldCount36;
	string3 PropSoldCount60;
	string3 WatercraftCount;
	string3 WatercraftCount01;
	string3 WatercraftCount03;
	string3 WatercraftCount06;
	string3 WatercraftCount12;
	string3 WatercraftCount24;
	string3 WatercraftCount36;
	string3 WatercraftCount60;
	string3 AircraftCount;
	string3 AircraftCount01;
	string3 AircraftCount03;
	string3 AircraftCount06;
	string3 AircraftCount12;
	string3 AircraftCount24;
	string3 AircraftCount36;
	string3 AircraftCount60;
	string3 DerogCount;
	string3 FelonyCount;
	string3 FelonyCount01;
	string3 FelonyCount03;
	string3 FelonyCount06;
	string3 FelonyCount12;
	string3 FelonyCount24;
	string3 FelonyCount36;
	string3 FelonyCount60;
	string3 ArrestCount;
	string3 ArrestCount01;
	string3 ArrestCount03;
	string3 ArrestCount06;
	string3 ArrestCount12;
	string3 ArrestCount24;
	string3 ArrestCount36;
	string3 ArrestCount60;
	string3 LienCount;
	string3 LienFiledCount;
	string3 LienFiledCount01;
	string3 LienFiledCount03;
	string3 LienFiledCount06;
	string3 LienFiledCount12;
	string3 LienFiledCount24;
	string3 LienFiledCount36;
	string3 LienFiledCount60;
	string3 LienReleasedCount;
	string3 LienReleasedCount01;
	string3 LienReleasedCount03;
	string3 LienReleasedCount06;
	string3 LienReleasedCount12;
	string3 LienReleasedCount24;
	string3 LienReleasedCount36;
	string3 LienReleasedCount60;
	string3 BankruptcyCount;
	string3 BankruptcyCount01;
	string3 BankruptcyCount03;
	string3 BankruptcyCount06;
	string3 BankruptcyCount12;
	string3 BankruptcyCount24;
	string3 BankruptcyCount36;
	string3 BankruptcyCount60;
	string3 EvictionCount;
	string3 EvictionCount01;
	string3 EvictionCount03;
	string3 EvictionCount06;
	string3 EvictionCount12;
	string3 EvictionCount24;
	string3 EvictionCount36;
	string3 EvictionCount60;
	string3 NonDerogCount;
	string3 NonDerogCount01;
	string3 NonDerogCount03;
	string3 NonDerogCount06;
	string3 NonDerogCount12;
	string3 NonDerogCount24;
	string3 NonDerogCount36;
	string3 NonDerogCount60;
	string3 ProfLicCount;
	string3 ProfLicCount01;
	string3 ProfLicCount03;
	string3 ProfLicCount06;
	string3 ProfLicCount12;
	string3 ProfLicCount24;
	string3 ProfLicCount36;
	string3 ProfLicCount60;
	string3 ProfLicExpireCount01;
	string3 ProfLicExpireCount03;
	string3 ProfLicExpireCount06;
	string3 ProfLicExpireCount12;
	string3 ProfLicExpireCount24;
	string3 ProfLicExpireCount36;
	string3 ProfLicExpireCount60;



	string4 PropNewestSalePurchaseIndex;
	string3 SubPrimeSolicitedCount;
	string3 SubPrimeSolicitedCount01;
	string3 SubprimeSolicitedCount03;
	string3 SubprimeSolicitedCount06;
	string3 SubPrimeSolicitedCount12;
	string3 SubPrimeSolicitedCount24;
	string3 SubPrimeSolicitedCount36;
	string3 SubPrimeSolicitedCount60;
	string2 DerogSeverityIndex;
	string3 DerogAge;
	string3 FelonyAge;
	string3 ArrestAge;
	string3 LienFiledAge;
	string3 LienReleasedAge;
	string3 BankruptcyAge;
	string2 BankruptcyType;
	string3 EvictionAge;
	string3 ProfLicAge;
	string2 ProfLicTypeCategory;
	string3 PRSearchCollectionCount;
	string3 PRSearchCollectionCount01;
	string3 PRSearchCollectionCount03;
	string3 PRSearchCollectionCount06;
	string3 PRSearchCollectionCount12;
	string3 PRSearchCollectionCount24;
	string3 PRSearchCollectionCount36;
	string3 PRSearchCollectionCount60;
	string3 PRSearchIDVFraudCount;
	string3 PRSearchIDVFraudCount01;
	string3 PRSearchIDVFraudCount03;
	string3 PRSearchIDVFraudCount06;
	string3 PRSearchIDVFraudCount12;
	string3 PRSearchIDVFraudCount24;
	string3 PRSearchIDVFraudCount36;
	string3 PRSearchIDVFraudCount60;
	string3 PRSearchOtherCount;
	string3 PRSearchOtherCount01;
	string3 PRSearchOtherCount03;
	string3 PRSearchOtherCount06;
	string3 PRSearchOtherCount12;
	string3 PRSearchOtherCount24;
	string3 PRSearchOtherCount36;
	string3 PRSearchOtherCount60;
	string2 InputPhoneStatus;
	string2 InputPhonePager;
	string2 InputPhoneMobile;
	string2 InputPhoneType;
	string2 InputAreaCodeChange;
	string3 PhoneOtherAgeOldestRecord;
	string3 PhoneOtherAgeNewestRecord;
	string2 InvalidPhoneZip;
	string2 InputAddrValidation;
	string2 InputAddrHighRisk;
	string2 InputPhoneHighRisk;
	string2 InputAddrPrison;
	string2 CurrAddrPrison;
	string2 PrevAddrPrison;
	string2 HistoricalAddrPrison;
	string2 InputZipPOBox;
	string2 InputZipCorpMil;
end;





export layout_LeadIntegrity_attributes_batch_v4 := record
	string4 v4_AgeOldestRecord;
	string4 v4_AgeNewestRecord;
	string1 v4_RecentUpdate;
	string3 v4_SrcsConfirmIDAddrCount;
	string1 v4_CreditBureauRecord;
	string2 v4_VerificationFailure;
	string2 v4_SSNNotFound;
	string2 v4_SSNFoundOther;
	string1 v4_VerifiedName;
	string2 v4_VerifiedSSN;
	string2 v4_VerifiedPhone;
	string2 v4_VerifiedAddress;
	string2 v4_VerifiedDOB;
	string3 v4_AgeRiskIndicator;
	string3 v4_SubjectSSNCount;
	string3 v4_SubjectAddrCount;
	string3 v4_SubjectPhoneCount;
	string3 v4_SubjectSSNRecentCount;
	string3 v4_SubjectAddrRecentCount;
	string3 v4_SubjectPhoneRecentCount;
	string3 v4_SSNIdentitiesCount;
	string3 v4_SSNAddrCount;
	string3 v4_SSNIdentitiesRecentCount;
	string3 v4_SSNAddrRecentCount;
	string3 v4_InputAddrPhoneCount;
	string3 v4_InputAddrPhoneRecentCount;
	string3 v4_PhoneIdentitiesCount;
	string3 v4_PhoneIdentitiesRecentCount;
	string2 v4_PhoneOther;
	string3 v4_SSNLastNameCount;
	string3 v4_SubjectLastNameCount;
	string4 v4_LastNameChangeAge;
	string3 v4_LastNameChangeCount01;
	string3 v4_LastNameChangeCount03;
	string3 v4_LastNameChangeCount06;
	string3 v4_LastNameChangeCount12;
	string3 v4_LastNameChangeCount24;
	string3 v4_LastNameChangeCount60;
	string3 v4_SFDUAddrIdentitiesCount;
	string3 v4_SFDUAddrSSNCount;
	string3 v4_SSNAgeDeceased;
	string2 v4_SSNRecent;
	string3 v4_SSNLowIssueAge;
	string3 v4_SSNHighIssueAge;
	string2 v4_SSNIssueState;
	string2 v4_SSNNonUS;
	string2 v4_SSN3Years;
	string2 v4_SSNAfter5;
	string2 v4_SSNProblems;
	string3 v4_RelativesCount;
	string3 v4_RelativesBankruptcyCount;
	string3 v4_RelativesFelonyCount;
	string3 v4_RelativesPropOwnedCount;
	string10 v4_RelativesPropOwnedTaxTotal;
	string2 v4_RelativesDistanceClosest;
	string3 v4_InputAddrAgeOldestRecord;
	string3 v4_InputAddrAgeNewestRecord;
	string2 v4_InputAddrHistoricalMatch;
	string3 v4_InputAddrLenOfRes;
	string2 v4_InputAddrDwellType;
	string2 v4_InputAddrDelivery;
	string2 v4_InputAddrApplicantOwned;
	string2 v4_InputAddrFamilyOwned;
	string2 v4_InputAddrOccupantOwned;
	string3 v4_InputAddrAgeLastSale;
	string10 v4_InputAddrLastSalesPrice;
	string2 v4_InputAddrMortgageType;
	string2 v4_InputAddrNotPrimaryRes;
	string2 v4_InputAddrActivePhoneList;
	string10 v4_InputAddrTaxValue;
	string4 v4_InputAddrTaxYr;
	string10 v4_InputAddrTaxMarketValue;
	string10 v4_InputAddrAVMValue;
	string10 v4_InputAddrAVMValue12;
	string10 v4_InputAddrAVMValue60;
	string5 v4_InputAddrCountyIndex;
	string5 v4_InputAddrTractIndex;
	string5 v4_InputAddrBlockIndex;
	string10 v4_InputAddrMedianIncome;
	string10 v4_InputAddrMedianValue;
	string3 v4_InputAddrMurderIndex;
	string3 v4_InputAddrCarTheftIndex;
	string3 v4_InputAddrBurglaryIndex;
	string3 v4_InputAddrCrimeIndex;
	string3 v4_InputAddrMobilityIndex;
	string3 v4_InputAddrVacantPropCount;
	string3 v4_InputAddrBusinessCount;
	string3 v4_InputAddrSingleFamilyCount;
	string3 v4_InputAddrMultiFamilyCount;
	string3 v4_CurrAddrAgeOldestRecord;
	string3 v4_CurrAddrAgeNewestRecord;
	string3 v4_CurrAddrLenOfRes;
	string2 v4_CurrAddrDwellType;
	string2 v4_CurrAddrApplicantOwned;
	string2 v4_CurrAddrFamilyOwned;
	string2 v4_CurrAddrOccupantOwned;
	string3 v4_CurrAddrAgeLastSale;
	string10 v4_CurrAddrLastSalesPrice;
	string2 v4_CurrAddrMortgageType;
	string2 v4_CurrAddrActivePhoneList;
	string10 v4_CurrAddrTaxValue;
	string4 v4_CurrAddrTaxYr;
	string10 v4_CurrAddrTaxMarketValue;
	string10 v4_CurrAddrAVMValue;
	string10 v4_CurrAddrAVMValue12;
	string10 v4_CurrAddrAVMValue60;
	string5 v4_CurrAddrCountyIndex;
	string5 v4_CurrAddrTractIndex;
	string5 v4_CurrAddrBlockIndex;
	string10 v4_CurrAddrMedianIncome;
	string10 v4_CurrAddrMedianValue;
	string3 v4_CurrAddrMurderIndex;
	string3 v4_CurrAddrCarTheftIndex;
	string3 v4_CurrAddrBurglaryIndex;
	string3 v4_CurrAddrCrimeIndex;
	string3 v4_PrevAddrAgeOldestRecord;
	string3 v4_PrevAddrAgeNewestRecord;
	string3 v4_PrevAddrLenOfRes;
	string2 v4_PrevAddrDwellType;
	string2 v4_PrevAddrApplicantOwned;
	string2 v4_PrevAddrFamilyOwned;
	string2 v4_PrevAddrOccupantOwned;
	string3 v4_PrevAddrAgeLastSale;
	string10 v4_PrevAddrLastSalesPrice;
	string10 v4_PrevAddrTaxValue;
	string4 v4_PrevAddrTaxYr;
	string10 v4_PrevAddrTaxMarketValue;
	string10 v4_PrevAddrAVMValue;
	string5 v4_PrevAddrCountyIndex;
	string5 v4_PrevAddrTractIndex;
	string5 v4_PrevAddrBlockIndex;
	string10 v4_PrevAddrMedianIncome;
	string10 v4_PrevAddrMedianValue;
	string3 v4_PrevAddrMurderIndex;
	string3 v4_PrevAddrCarTheftIndex;
	string3 v4_PrevAddrBurglaryIndex;
	string3 v4_PrevAddrCrimeIndex;
	string4 v4_AddrMostRecentDistance;
	string2 v4_AddrMostRecentStateDiff;
	string11 v4_AddrMostRecentTaxDiff;
	string3 v4_AddrMostRecentMoveAge;
	string11 v4_AddrMostRecentIncomeDiff;
	string11 v4_AddrMostRecentValueDIff;
	string4 v4_AddrMostRecentCrimeDiff;
	string2 v4_AddrRecentEconTrajectory;
	string2 v4_AddrRecentEconTrajectoryIndex;
	string1 v4_EducationAttendedCollege;
	string2 v4_EducationProgram2Yr;
	string2 v4_EducationProgram4Yr;
	string2 v4_EducationProgramGraduate;
	string2 v4_EducationInstitutionPrivate;
	string2 v4_EducationInstitutionRating;
	string2 v4_EducationFieldofStudyType;
	string1 v4_AddrStability;
	string2 v4_StatusMostRecent;
	string2 v4_StatusPrevious;
	string2 v4_StatusNextPrevious;
	string3 v4_AddrChangeCount01;
	string3 v4_AddrChangeCount03;
	string3 v4_AddrChangeCount06;
	string3 v4_AddrChangeCount12;
	string3 v4_AddrChangeCount24;
	string3 v4_AddrChangeCount60;
	string10 v4_EstimatedAnnualIncome;
	string1 v4_AssetOwner;
	string1 v4_PropertyOwner;
	string3 v4_PropOwnedCount;
	string10 v4_PropOwnedTaxTotal;
	string3 v4_PropOwnedHistoricalCount;
	string3 v4_PropAgeOldestPurchase;
	string3 v4_PropAgeNewestPurchase;
	string3 v4_PropAgeNewestSale;
	string10 v4_PropNewestSalePrice;
	string4 v4_PropNewestSalePurchaseIndex;
	string3 v4_PropPurchasedCount01;
	string3 v4_PropPurchasedCount03;
	string3 v4_PropPurchasedCount06;
	string3 v4_PropPurchasedCount12;
	string3 v4_PropPurchasedCount24;
	string3 v4_PropPurchasedCount60;
	string3 v4_PropSoldCount01;
	string3 v4_PropSoldCount03;
	string3 v4_PropSoldCount06;
	string3 v4_PropSoldCount12;
	string3 v4_PropSoldCount24;
	string3 v4_PropSoldCount60;
	string1 v4_WatercraftOwner;
	string3 v4_WatercraftCount;
	string3 v4_WatercraftCount01;
	string3 v4_WatercraftCount03;
	string3 v4_WatercraftCount06;
	string3 v4_WatercraftCount12;
	string3 v4_WatercraftCount24;
	string3 v4_WatercraftCount60;
	string1 v4_AircraftOwner;
	string3 v4_AircraftCount;
	string3 v4_AircraftCount01;
	string3 v4_AircraftCount03;
	string3 v4_AircraftCount06;
	string3 v4_AircraftCount12;
	string3 v4_AircraftCount24;
	string3 v4_AircraftCount60;
	string2 v4_WealthIndex;
	string2 v4_BusinessActiveAssociation;
	string2 v4_BusinessInactiveAssociation;
	string3 v4_BusinessAssociationAge;
	string100 v4_BusinessTitle;
	string3 v4_BusinessInputAddrCount;
	string2 v4_DerogSeverityIndex;
	string3 v4_DerogCount;
	string3 v4_DerogRecentCount;
	string3 v4_DerogAge;
	string3 v4_FelonyCount;
	string3 v4_FelonyAge;
	string3 v4_FelonyCount01;
	string3 v4_FelonyCount03;
	string3 v4_FelonyCount06;
	string3 v4_FelonyCount12;
	string3 v4_FelonyCount24;
	string3 v4_FelonyCount60;
	string3 v4_ArrestCount;
	string3 v4_ArrestAge;
	string3 v4_ArrestCount01;
	string3 v4_ArrestCount03;
	string3 v4_ArrestCount06;
	string3 v4_ArrestCount12;
	string3 v4_ArrestCount24;
	string3 v4_ArrestCount60;
	string3 v4_LienCount;
	string3 v4_LienFiledCount;
	string10 v4_LienFiledTotal;
	string3 v4_LienFiledAge;
	string3 v4_LienFiledCount01;
	string3 v4_LienFiledCount03;
	string3 v4_LienFiledCount06;
	string3 v4_LienFiledCount12;
	string3 v4_LienFiledCount24;
	string3 v4_LienFiledCount60;
	string3 v4_LienReleasedCount;
	string10 v4_LienReleasedTotal;
	string3 v4_LienReleasedAge;
	string3 v4_LienReleasedCount01;
	string3 v4_LienReleasedCount03;
	string3 v4_LienReleasedCount06;
	string3 v4_LienReleasedCount12;
	string3 v4_LienReleasedCount24;
	string3 v4_LienReleasedCount60;
	string3 v4_BankruptcyCount;
	string3 v4_BankruptcyAge;
	string2 v4_BankruptcyType;
	string35 v4_BankruptcyStatus;
	string3 v4_BankruptcyCount01;
	string3 v4_BankruptcyCount03;
	string3 v4_BankruptcyCount06;
	string3 v4_BankruptcyCount12;
	string3 v4_BankruptcyCount24;
	string3 v4_BankruptcyCount60;
	string3 v4_EvictionCount;
	string3 v4_EvictionAge;
	string3 v4_EvictionCount01;
	string3 v4_EvictionCount03;
	string3 v4_EvictionCount06;
	string3 v4_EvictionCount12;
	string3 v4_EvictionCount24;
	string3 v4_EvictionCount60;
	string3 v4_AccidentCount;
	string3 v4_AccidentAge;
	string2 v4_RecentActivityIndex;
	string3 v4_NonDerogCount;
	string3 v4_NonDerogCount01;
	string3 v4_NonDerogCount03;
	string3 v4_NonDerogCount06;
	string3 v4_NonDerogCount12;
	string3 v4_NonDerogCount24;
	string3 v4_NonDerogCount60;
	string1 v4_VoterRegistrationRecord;
	string3 v4_ProfLicCount;
	string3 v4_ProfLicAge;
	string2 v4_ProfLicTypeCategory;
	string2 v4_ProfLicExpired;
	string3 v4_ProfLicCount01;
	string3 v4_ProfLicCount03;
	string3 v4_ProfLicCount06;
	string3 v4_ProfLicCount12;
	string3 v4_ProfLicCount24;
	string3 v4_ProfLicCount60;
	string3 v4_PRSearchLocateCount;
	string3 v4_PRSearchLocateCount01;
	string3 v4_PRSearchLocateCount03;
	string3 v4_PRSearchLocateCount06;
	string3 v4_PRSearchLocateCount12;
	string3 v4_PRSearchLocateCount24;
	string3 v4_PRSearchPersonalFinanceCount;
	string3 v4_PRSearchPersonalFinanceCount01;
	string3 v4_PRSearchPersonalFinanceCount03;
	string3 v4_PRSearchPersonalFinanceCount06;
	string3 v4_PRSearchPersonalFinanceCount12;
	string3 v4_PRSearchPersonalFinanceCount24;
	string3 v4_PRSearchOtherCount;
	string3 v4_PRSearchOtherCount01;
	string3 v4_PRSearchOtherCount03;
	string3 v4_PRSearchOtherCount06;
	string3 v4_PRSearchOtherCount12;
	string3 v4_PRSearchOtherCount24;
	string3 v4_PRSearchIdentitySSNs;
	string3 v4_PRSearchIdentityAddrs;
	string3 v4_PRSearchIdentityPhones;
	string3 v4_PRSearchSSNIdentities;
	string3 v4_PRSearchAddrIdentities;
	string3 v4_PRSearchPhoneIdentities;
	string3 v4_SubPrimeOfferRequestCount;
	string3 v4_SubPrimeOfferRequestCount01;
	string3 v4_SubPrimeOfferRequestCount03;
	string3 v4_SubPrimeOfferRequestCount06;
	string3 v4_SubPrimeOfferRequestCount12;
	string3 v4_SubPrimeOfferRequestCount24;
	string3 v4_SubPrimeOfferRequestCount60;
	string2 v4_InputPhoneMobile;
	string2 v4_InputPhoneType;
	string2 v4_InputPhoneServiceType;
	string2 v4_InputAreaCodeChange;
	string3 v4_PhoneEDAAgeOldestRecord;
	string3 v4_PhoneEDAAgeNewestRecord;
	string3 v4_PhoneOtherAgeOldestRecord;
	string3 v4_PhoneOtherAgeNewestRecord;
	string2 v4_InputPhoneHighRisk;
	string2 v4_InputPhoneProblems;
	string2 v4_OnlineDirectory;
	string4 v4_InputAddrSICCode;
	string2 v4_InputAddrValidation;
	string5 v4_InputAddrErrorCode;
	string2 v4_InputAddrHighRisk;
	string2 v4_CurrAddrCorrectional;
	string2 v4_PrevAddrCorrectional;
	string2 v4_HistoricalAddrCorrectional;
	string2 v4_InputAddrProblems;
	string1 v4_DoNotMail;
	// 4.1 Attributes
	STRING2 v4_IdentityRiskLevel := '';
	STRING2 v4_IDVerRiskLevel := '';
	STRING3 v4_IDVerAddressAssocCount := '';
	STRING2 v4_IDVerSSNCreditBureauCount := '';
	STRING2 v4_IDVerSSNCreditBureauDelete := '';
	STRING2 v4_SourceRiskLevel := '';
	STRING1 v4_SourceWatchList := '';
	STRING1 v4_SourceOrderActivity := '';
	STRING3 v4_SourceOrderSourceCount := '';
	STRING3 v4_SourceOrderAgeLastOrder := '';
	STRING2 v4_VariationRiskLevel := '';
	STRING3 v4_VariationIdentityCount := '';
	STRING3 v4_VariationMSourcesSSNCount := '';
	STRING3 v4_VariationMSourcesSSNUnrelCount := '';
	STRING3 v4_VariationDOBCount := '';
	STRING3 v4_VariationDOBCountNew := '';
	STRING2 v4_SearchVelocityRiskLevel := '';
	STRING3 v4_SearchUnverifiedSSNCountYear := '';
	STRING3 v4_SearchUnverifiedAddrCountYear := '';
	STRING3 v4_SearchUnverifiedDOBCountYear := '';
	STRING3 v4_SearchUnverifiedPhoneCountYear := '';
	STRING2 v4_AssocRiskLevel := '';
	STRING3 v4_AssocSuspicousIdentitiesCount := '';
	STRING3 v4_AssocCreditBureauOnlyCount := '';
	STRING3 v4_AssocCreditBureauOnlyCountNew := '';
	STRING3 v4_AssocCreditBureauOnlyCountMonth := '';
	STRING3 v4_AssocHighRiskTopologyCount := '';
	STRING1 v4_ValidationRiskLevel := '';
	STRING1 v4_CorrelationRiskLevel := '';
	STRING1 v4_DivRiskLevel := '';
	STRING3 v4_DivSSNIdentityMSourceCount := '';
	STRING3 v4_DivSSNIdentityMSourceUrelCount := '';
	STRING3 v4_DivSSNLNameCountNew := '';
	STRING3 v4_DivSSNAddrMSourceCount := '';
	STRING3 v4_DivAddrIdentityCount := '';
	STRING3 v4_DivAddrIdentityCountNew := '';
	STRING3 v4_DivAddrIdentityMSourceCount := '';
	STRING3 v4_DivAddrSuspIdentityCountNew := '';
	STRING3 v4_DivAddrSSNCount := '';
	STRING3 v4_DivAddrSSNCountNew := '';
	STRING3 v4_DivAddrSSNMSourceCount := '';
	STRING3 v4_DivSearchAddrSuspIdentityCount := '';
	STRING1 v4_SearchComponentRiskLevel := '';
	STRING3 v4_SearchSSNSearchCount := '';
	STRING3 v4_SearchAddrSearchCount := '';
	STRING3 v4_SearchPhoneSearchCount := '';
	STRING1 v4_ComponentCharRiskLevel := '';
end;

export Layout_LeadIntegrity_attributes_v4 := RECORD
	iesp.issservice.t_LeadIntegrityAttributesISSv4;
	STRING2 IdentityRiskLevel {xpath('IdentityRiskLevel')} := '';
	STRING2 IDVerRiskLevel {xpath('IDVerRiskLevel')} := '';
	STRING3 IDVerAddressAssocCount {xpath('IDVerAddressAssocCount')} := '';
	STRING2 IDVerSSNCreditBureauCount {xpath('IDVerSSNCreditBureauCount')} := '';
	STRING2 IDVerSSNCreditBureauDelete {xpath('IDVerSSNCreditBureauDelete')} := '';
	STRING2 SourceRiskLevel {xpath('SourceRiskLevel')} := '';
	STRING1 SourceWatchList {xpath('SourceWatchList')} := '';
	STRING1 SourceOrderActivity {xpath('SourceOrderActivity')} := '';
	STRING3 SourceOrderSourceCount {xpath('SourceOrderSourceCount')} := '';
	STRING3 SourceOrderAgeLastOrder {xpath('SourceOrderAgeLastOrder')} := '';
	STRING2 VariationRiskLevel {xpath('VariationRiskLevel')} := '';
	STRING3 VariationIdentityCount {xpath('VariationIdentityCount')} := '';
	STRING3 VariationMSourcesSSNCount {xpath('VariationMSourcesSSNCount')} := '';
	STRING3 VariationMSourcesSSNUnrelCount {xpath('VariationMSourcesSSNUnrelCount')} := '';
	STRING3 VariationDOBCount {xpath('VariationDOBCount')} := '';
	STRING3 VariationDOBCountNew {xpath('VariationDOBCountNew')} := '';
	STRING2 SearchVelocityRiskLevel {xpath('SearchVelocityRiskLevel')} := '';
	STRING3 SearchUnverifiedSSNCountYear {xpath('SearchUnverifiedSSNCountYear')} := '';
	STRING3 SearchUnverifiedAddrCountYear {xpath('SearchUnverifiedAddrCountYear')} := '';
	STRING3 SearchUnverifiedDOBCountYear {xpath('SearchUnverifiedDOBCountYear')} := '';
	STRING3 SearchUnverifiedPhoneCountYear {xpath('SearchUnverifiedPhoneCountYear')} := '';
	STRING2 AssocRiskLevel {xpath('AssocRiskLevel')} := '';
	STRING3 AssocSuspicousIdentitiesCount {xpath('AssocSuspicousIdentitiesCount')} := '';
	STRING3 AssocCreditBureauOnlyCount {xpath('AssocCreditBureauOnlyCount')} := '';
	STRING3 AssocCreditBureauOnlyCountNew {xpath('AssocCreditBureauOnlyCountNew')} := '';
	STRING3 AssocCreditBureauOnlyCountMonth {xpath('AssocCreditBureauOnlyCountMonth')} := '';
	STRING3 AssocHighRiskTopologyCount {xpath('AssocHighRiskTopologyCount')} := '';
	STRING1 ValidationRiskLevel {xpath('ValidationRiskLevel')} := '';
	STRING1 CorrelationRiskLevel {xpath('CorrelationRiskLevel')} := '';
	STRING1 DivRiskLevel {xpath('DivRiskLevel')} := '';
	STRING3 DivSSNIdentityMSourceCount {xpath('DivSSNIdentityMSourceCount')} := '';
	STRING3 DivSSNIdentityMSourceUrelCount {xpath('DivSSNIdentityMSourceUrelCount')} := '';
	STRING3 DivSSNLNameCountNew {xpath('DivSSNLNameCountNew')} := '';
	STRING3 DivSSNAddrMSourceCount {xpath('DivSSNAddrMSourceCount')} := '';
	STRING3 DivAddrIdentityCount {xpath('DivAddrIdentityCount')} := '';
	STRING3 DivAddrIdentityCountNew {xpath('DivAddrIdentityCountNew')} := '';
	STRING3 DivAddrIdentityMSourceCount {xpath('DivAddrIdentityMSourceCount')} := '';
	STRING3 DivAddrSuspIdentityCountNew {xpath('DivAddrSuspIdentityCountNew')} := '';
	STRING3 DivAddrSSNCount {xpath('DivAddrSSNCount')} := '';
	STRING3 DivAddrSSNCountNew {xpath('DivAddrSSNCountNew')} := '';
	STRING3 DivAddrSSNMSourceCount {xpath('DivAddrSSNMSourceCount')} := '';
	STRING3 DivSearchAddrSuspIdentityCount {xpath('DivSearchAddrSuspIdentityCount')} := '';
	STRING1 SearchComponentRiskLevel {xpath('SearchComponentRiskLevel')} := '';
	STRING3 SearchSSNSearchCount {xpath('SearchSSNSearchCount')} := '';
	STRING3 SearchAddrSearchCount {xpath('SearchAddrSearchCount')} := '';
	STRING3 SearchPhoneSearchCount {xpath('SearchPhoneSearchCount')} := '';
	STRING1 ComponentCharRiskLevel {xpath('ComponentCharRiskLevel')} := '';
END;
export layout_LeadIntegrity_attributes_batch := record
  UNSIGNED6 DID := 0; // for internal use
	layout_LeadIntegrity_attributes_batch_v1;
	layout_LeadIntegrity_attributes_batch_v3 Version3;
	Layout_LeadIntegrity_attributes_v4 Version4;
end;


export layout_LeadIntegrity_attributes_batch_flattened := record
	layout_LeadIntegrity_attributes_batch_v1;
	string4 Version3__AgeOldestRecord;
	string4 Version3__AgeNewestRecord;
	string3 Version3__SrcsConfirmIDAddrCount;
	string1 Version3__CreditBureauRecord;
	string2 Version3__InvalidSSN;
	string2 Version3__InvalidPhone;
	string2 Version3__InvalidAddr;

	string2 Version3__SSNDeceased;
	string2 Version3__SSNIssued;
	string2 Version3__VerificationFailure;
	string2 Version3__SSNNotFound;
	string2 Version3__SSNFoundOther;
	string2 Version3__PhoneOther;


	string1 Version3__VerifiedName;
	string2 Version3__VerifiedSSN;
	string2 Version3__VerifiedPhone;
	string2 Version3__VerifiedPhoneFullName;
	string2 Version3__VerifiedPhoneLastName;
	string2 Version3__VerifiedAddress;
	string2 Version3__VerifiedDOB;

	string3 Version3__SubjectSSNCount;
	string3 Version3__SubjectAddrCount;
	string3 Version3__SubjectPhoneCount;
	string3 Version3__SubjectSSNRecentCount;
	string3 Version3__SubjectAddrRecentCount;
	string3 Version3__SubjectPhoneRecentCount;
	string3 Version3__SSNIdentitiesCount;
	string3 Version3__SSNAddrCount;
	string3 Version3__SSNIdentitiesRecentCount;
	string3 Version3__SSNAddrRecentCount;
	string3 Version3__InputAddrIdentitiesCount;
	string3 Version3__InputAddrSSNCount;
	string3 Version3__InputAddrPhoneCount;
	string3 Version3__InputAddrIdentitiesRecentCount;
	string3 Version3__InputAddrSSNRecentCount;
	string3 Version3__InputAddrPhoneRecentCount;
	string3 Version3__PhoneIdentitiesCount;
	string3 Version3__PhoneIdentitiesRecentCount;

	string3 Version3__SSNLastNameCount;
	string3 Version3__SubjectLastNameCount;
	// LastNameChangeAge not needed since TimeSinceLastAge is four bytes
	string3 Version3__LastNameChangeCount01;
	string3 Version3__LastNameChangeCount03;
	string3 Version3__LastNameChangeCount06;
	string3 Version3__LastNameChangeCount12;
	string3 Version3__LastNameChangeCount24;
	string3 Version3__LastNameChangeCount36;
	string3 Version3__LastNameChangeCount60;
	string3 Version3__SFDUAddrIdentitiesCount;
	string3 Version3__SFDUAddrSSNCount;


	string2 Version3__SSNRecent;
	string2 Version3__SSNNonUS;
	string2 Version3__SSN3Years;
	string2 Version3__SSNAfter5;
	string2 Version3__SSNIssuedPriorDOB;
	string3 Version3__RelativesCount;
	string3 Version3__RelativesBankruptcyCount;
	string3 Version3__RelativesFelonyCount;
	string3 Version3__RelativesPropOwnedCount;
	string13 Version3__RelativesPropOwnedTaxTotal;
	string2 Version3__RelativesDistanceClosest;
	string2 Version3__InputAddrDwellType;
	string2 Version3__InputAddrLandUseCode;
	string2 Version3__InputAddrApplicantOwned;
	string2 Version3__InputAddrFamilyOwned;
	string2 Version3__InputAddrOccupantOwned;
	string3 Version3__InputAddrAgeLastSale;
	string2 Version3__InputAddrNotPrimaryRes;
	string2 Version3__InputAddrActivePhoneList;
	string2 Version3__CurrAddrDwellType;
	string2 Version3__CurrAddrLandUseCode;
	string2 Version3__CurrAddrApplicantOwned;
	string2 Version3__CurrAddrFamilyOwned;
	string2 Version3__CurrAddrOccupantOwned;
	string3 Version3__CurrAddrAgeLastSale;
	string2 Version3__CurrAddrActivePhoneList;
	string2 Version3__PrevAddrDwellType;
	string2 Version3__PrevAddrLandUseCode;
	string2 Version3__PrevAddrApplicantOwned;
	string2 Version3__PrevAddrFamilyOwned;
	string2 Version3__PrevAddrOccupantOwned;
	string3 Version3__PrevAddrAgeLastSale;
	string2 Version3__PrevAddrActivePhoneList;
	string2 Version3__InputCurrAddrMatch;
	string2 Version3__InputCurrAddrStateDiff;
	string2 Version3__InputPrevAddrMatch;
	string2 Version3__CurrPrevAddrStateDiff;
	string1 Version3__EducationAttendedCollege;
	string2 Version3__EducationProgram2Yr;
	string2 Version3__EducationProgram4Yr;
	string2 Version3__EducationProgramGraduate;
	string2 Version3__EducationInstitutionPrivate;
	string2 Version3__EducationInstitutionRating;
	string2 Version3__EducationFieldofStudyType;
	string2 Version3__StatusMostRecent;
	string2 Version3__StatusPrevious;
	string2 Version3__StatusNextPrevious;

	string3 Version3__AddrChangeCount01;
	string3 Version3__AddrChangeCount03;
	string3 Version3__AddrChangeCount06;
	string3 Version3__AddrChangeCount12;
	string3 Version3__AddrChangeCount24;
	string3 Version3__AddrChangeCount36;
	string3 Version3__AddrChangeCount60;
	string3 Version3__PropOwnedCount;
	string3 Version3__PropOwnedHistoricalCount;

	string6 Version3__PredictedAnnualIncome;
	string3 Version3__PropAgeOldestPurchase;
	string3 Version3__PropAgeNewestPurchase;
	string3 Version3__PropAgeNewestSale;

	string3 Version3__PropPurchasedCount01;
	string3 Version3__PropPurchasedCount03;
	string3 Version3__PropPurchasedCount06;
	string3 Version3__PropPurchasedCount12;
	string3 Version3__PropPurchasedCount24;
	string3 Version3__PropPurchasedCount36;
	string3 Version3__PropPurchasedCount60;
	string3 Version3__PropSoldCount01;
	string3 Version3__PropSoldCount03;
	string3 Version3__PropSoldCount06;
	string3 Version3__PropSoldCount12;
	string3 Version3__PropSoldCount24;
	string3 Version3__PropSoldCount36;
	string3 Version3__PropSoldCount60;
	string3 Version3__WatercraftCount;
	string3 Version3__WatercraftCount01;
	string3 Version3__WatercraftCount03;
	string3 Version3__WatercraftCount06;
	string3 Version3__WatercraftCount12;
	string3 Version3__WatercraftCount24;
	string3 Version3__WatercraftCount36;
	string3 Version3__WatercraftCount60;
	string3 Version3__AircraftCount;
	string3 Version3__AircraftCount01;
	string3 Version3__AircraftCount03;
	string3 Version3__AircraftCount06;
	string3 Version3__AircraftCount12;
	string3 Version3__AircraftCount24;
	string3 Version3__AircraftCount36;
	string3 Version3__AircraftCount60;
	string3 Version3__DerogCount;
	string3 Version3__FelonyCount;
	string3 Version3__FelonyCount01;
	string3 Version3__FelonyCount03;
	string3 Version3__FelonyCount06;
	string3 Version3__FelonyCount12;
	string3 Version3__FelonyCount24;
	string3 Version3__FelonyCount36;
	string3 Version3__FelonyCount60;
	string3 Version3__ArrestCount;
	string3 Version3__ArrestCount01;
	string3 Version3__ArrestCount03;
	string3 Version3__ArrestCount06;
	string3 Version3__ArrestCount12;
	string3 Version3__ArrestCount24;
	string3 Version3__ArrestCount36;
	string3 Version3__ArrestCount60;
	string3 Version3__LienCount;
	string3 Version3__LienFiledCount;
	string3 Version3__LienFiledCount01;
	string3 Version3__LienFiledCount03;
	string3 Version3__LienFiledCount06;
	string3 Version3__LienFiledCount12;
	string3 Version3__LienFiledCount24;
	string3 Version3__LienFiledCount36;
	string3 Version3__LienFiledCount60;
	string3 Version3__LienReleasedCount;
	string3 Version3__LienReleasedCount01;
	string3 Version3__LienReleasedCount03;
	string3 Version3__LienReleasedCount06;
	string3 Version3__LienReleasedCount12;
	string3 Version3__LienReleasedCount24;
	string3 Version3__LienReleasedCount36;
	string3 Version3__LienReleasedCount60;
	string3 Version3__BankruptcyCount;
	string3 Version3__BankruptcyCount01;
	string3 Version3__BankruptcyCount03;
	string3 Version3__BankruptcyCount06;
	string3 Version3__BankruptcyCount12;
	string3 Version3__BankruptcyCount24;
	string3 Version3__BankruptcyCount36;
	string3 Version3__BankruptcyCount60;
	string3 Version3__EvictionCount;
	string3 Version3__EvictionCount01;
	string3 Version3__EvictionCount03;
	string3 Version3__EvictionCount06;
	string3 Version3__EvictionCount12;
	string3 Version3__EvictionCount24;
	string3 Version3__EvictionCount36;
	string3 Version3__EvictionCount60;
	string3 Version3__NonDerogCount;
	string3 Version3__NonDerogCount01;
	string3 Version3__NonDerogCount03;
	string3 Version3__NonDerogCount06;
	string3 Version3__NonDerogCount12;
	string3 Version3__NonDerogCount24;
	string3 Version3__NonDerogCount36;
	string3 Version3__NonDerogCount60;
	string3 Version3__ProfLicCount;
	string3 Version3__ProfLicCount01;
	string3 Version3__ProfLicCount03;
	string3 Version3__ProfLicCount06;
	string3 Version3__ProfLicCount12;
	string3 Version3__ProfLicCount24;
	string3 Version3__ProfLicCount36;
	string3 Version3__ProfLicCount60;
	string3 Version3__ProfLicExpireCount01;
	string3 Version3__ProfLicExpireCount03;
	string3 Version3__ProfLicExpireCount06;
	string3 Version3__ProfLicExpireCount12;
	string3 Version3__ProfLicExpireCount24;
	string3 Version3__ProfLicExpireCount36;
	string3 Version3__ProfLicExpireCount60;



	string4 Version3__PropNewestSalePurchaseIndex;
	string3 Version3__SubPrimeSolicitedCount;
	string3 Version3__SubPrimeSolicitedCount01;
	string3 Version3__SubprimeSolicitedCount03;
	string3 Version3__SubprimeSolicitedCount06;
	string3 Version3__SubPrimeSolicitedCount12;
	string3 Version3__SubPrimeSolicitedCount24;
	string3 Version3__SubPrimeSolicitedCount36;
	string3 Version3__SubPrimeSolicitedCount60;
	string2 Version3__DerogSeverityIndex;
	string3 Version3__DerogAge;
	string3 Version3__FelonyAge;
	string3 Version3__ArrestAge;
	string3 Version3__LienFiledAge;
	string3 Version3__LienReleasedAge;
	string3 Version3__BankruptcyAge;
	string2 Version3__BankruptcyType;
	string3 Version3__EvictionAge;
	string3 Version3__ProfLicAge;
	string2 Version3__ProfLicTypeCategory;
	string3 Version3__PRSearchCollectionCount;
	string3 Version3__PRSearchCollectionCount01;
	string3 Version3__PRSearchCollectionCount03;
	string3 Version3__PRSearchCollectionCount06;
	string3 Version3__PRSearchCollectionCount12;
	string3 Version3__PRSearchCollectionCount24;
	string3 Version3__PRSearchCollectionCount36;
	string3 Version3__PRSearchCollectionCount60;
	string3 Version3__PRSearchIDVFraudCount;
	string3 Version3__PRSearchIDVFraudCount01;
	string3 Version3__PRSearchIDVFraudCount03;
	string3 Version3__PRSearchIDVFraudCount06;
	string3 Version3__PRSearchIDVFraudCount12;
	string3 Version3__PRSearchIDVFraudCount24;
	string3 Version3__PRSearchIDVFraudCount36;
	string3 Version3__PRSearchIDVFraudCount60;
	string3 Version3__PRSearchOtherCount;
	string3 Version3__PRSearchOtherCount01;
	string3 Version3__PRSearchOtherCount03;
	string3 Version3__PRSearchOtherCount06;
	string3 Version3__PRSearchOtherCount12;
	string3 Version3__PRSearchOtherCount24;
	string3 Version3__PRSearchOtherCount36;
	string3 Version3__PRSearchOtherCount60;
	string2 Version3__InputPhoneStatus;
	string2 Version3__InputPhonePager;
	string2 Version3__InputPhoneMobile;
	string2 Version3__InputPhoneType;
	string2 Version3__InputAreaCodeChange;
	string3 Version3__PhoneOtherAgeOldestRecord;
	string3 Version3__PhoneOtherAgeNewestRecord;
	string2 Version3__InvalidPhoneZip;
	string2 Version3__InputAddrValidation;
	string2 Version3__InputAddrHighRisk;
	string2 Version3__InputPhoneHighRisk;
	string2 Version3__InputAddrPrison;
	string2 Version3__CurrAddrPrison;
	string2 Version3__PrevAddrPrison;
	string2 Version3__HistoricalAddrPrison;
	string2 Version3__InputZipPOBox;
	string2 Version3__InputZipCorpMil;

	layout_leadIntegrity_attributes_batch_v4;
	STRING12 did;	
end;
// for initial use with chargeback defender model structure
export Layout_Reason_Code_Sets := RECORD
	string15 name;
	dataset(risk_indicators.layouts.layout_reason_codes_plus_seq) reason_codes {maxcount(12)};
END;


export Layout_Score_Multiple := RECORD
	STRING3 i;
	STRING30 Description;
	STRING3 index := '';
	dataset(Layout_Reason_Code_Sets) RiskIndicatorSets {maxcount(5)};
END;


export Layout_Model_Multiple := RECORD
	STRING30 AccountNumber;
	STRING30 Description;
	DATASET(Layout_Score_Multiple) Scores {maxcount(5)};
END;


export Layout_CBD_Echo_In := RECORD
		string30 AccountNumber;
		string120 UnParsedFullName;
		string30 FirstName;
		string30 MiddleName;
		string30 LastName;
		string5 NameSuffix;
		string50 StreetAddress;
		string30  City;
		string2 State;
		string5 Zip;
		string10 HomePhone;
		string9 SSN;
		string50 Email;
		string20 DLNumber;
		string2 DLState;
		string8 DateOfBirth;
		string120 UnparsedFullName2;
		string30 first2;
		string30 middle2;
		string30 last2;
		string5 suffix2;
		string50 addr2 ;
		string30 city2;
		string2 state2;
		string5 zip2;
		string10 hphone2;
		string45 ipaddr;
		string9 SSN2;
		string50 Email2;	
		string20 DLNumber2;
		string2 DLState2;	
		string8 DateOfBirth2;
		string20 TypeOfOrder;
		Risk_Indicators.Layout_BocaShell_BtSt.input_Scores_values;
	END;
	

export Layout_CBD_Echo_In_for_output := RECORD
//these fields aren't outputted on output
		Layout_CBD_Echo_In	-DeviceProvider1_value -DeviceProvider2_value -DeviceProvider3_value -DeviceProvider4_value -TypeOfOrder -btst_order_type;
END;
	
export Layout_Attribute := RECORD	
				DATASET(Models.Layout_Parameters) Attribute ;
			END;
	
export 	Layout_AttributeGroup := RECORD
					string30 accountnumber;
					string40 name;
					string3 index;
					DATASET(Layout_Attribute) Attributes {maxcount(350)};
				END;

export Layout_Riskview_v4 := RECORD	
			string3	v4_AgeOldestRecord	;		
			string3	v4_AgeNewestRecord	;		
			string1	v4_RecentUpdate	;		
			string3	v4_SrcsConfirmIDAddrCount	;		
			string2	v4_InvalidDL	;		
			string1	v4_VerificationFailure	;		
			string2	v4_SSNNotFound	;		
			string1	v4_VerifiedName	;		
			string2	v4_VerifiedSSN	;		
			string2	v4_VerifiedPhone	;		
			string2	v4_VerifiedAddress	;		
			string2	v4_VerifiedDOB	;		
			string3	v4_InferredMinimumAge	;		
			string3	v4_BestReportedAge	;		
			string3	v4_SubjectSSNCount	;		
			string3	v4_SubjectAddrCount	;		
			string3	v4_SubjectPhoneCount	;		
			string3	v4_SubjectSSNRecentCount	;		
			string3	v4_SubjectAddrRecentCount	;		
			string3	v4_SubjectPhoneRecentCount	;		
			string3	v4_SSNIdentitiesCount	;		
			string3	v4_SSNAddrCount	;		
			string3	v4_SSNIdentitiesRecentCount	;		
			string3	v4_SSNAddrRecentCount	;		
			string3	v4_InputAddrPhoneCount	;		
			string3	v4_InputAddrPhoneRecentCount	;		
			string3	v4_PhoneIdentitiesCount	;		
			string3	v4_PhoneIdentitiesRecentCount	;		
			string3	v4_SSNAgeDeceased	;	// was named SSNDateDeceased	in version3
			string2	v4_SSNRecent	;		
			string3	v4_SSNLowIssueAge	;	// was named SSNLowIssueDate	in version3
			string3	v4_SSNHighIssueAge	;	// was named SSNHighIssueDate	in version3
			string2	v4_SSNIssueState	;		
			string2	v4_SSNNonUS	;		
			string2	v4_SSN3Years	;		
			string2	v4_SSNAfter5 	;		
			string2	v4_SSNProblems	;	// new to 4.0	
			string3	v4_InputAddrAgeOldestRecord	;		
			string3	v4_InputAddrAgeNewestRecord	;		
			string2	v4_InputAddrHistoricalMatch	;	// new to 4.0	
			string3	v4_InputAddrLenOfRes 	;		
			string2	v4_InputAddrDwellType 	;		
			string2	v4_InputAddrDelivery	;	// new to 4.0	
			string2	v4_InputAddrApplicantOwned	;		
			string2	v4_InputAddrFamilyOwned	;		
			string2	v4_InputAddrOccupantOwned 	;		
			string3	v4_InputAddrAgeLastSale	;		
			string10	v4_InputAddrLastSalesPrice	;		
			string2	v4_InputAddrMortgageType	;	// new to 4.0				
			string2	v4_InputAddrNotPrimaryRes 	;		
			string2	v4_InputAddrActivePhoneList 	;		
			string10	v4_InputAddrTaxValue 	;		
			string4	v4_InputAddrTaxYr	;		
			string10	v4_InputAddrTaxMarketValue	;		
			string10	v4_InputAddrAVMValue	;		
			string10	v4_InputAddrAVMValue12	;	// new to 4.0	
			string10	v4_InputAddrAVMValue60	;	// new to 4.0	
			string5	v4_InputAddrCountyIndex	;		
			string5	v4_InputAddrTractIndex	;		
			string5	v4_InputAddrBlockIndex	;		
			string3	v4_CurrAddrAgeOldestRecord	;		
			string3	v4_CurrAddrAgeNewestRecord	;		
			string3	v4_CurrAddrLenOfRes 	;		
			string2	v4_CurrAddrDwellType 	;		
			string2	v4_CurrAddrApplicantOwned 	;		
			string2	v4_CurrAddrFamilyOwned 	;		
			string2	v4_CurrAddrOccupantOwned 	;		
			string3	v4_CurrAddrAgeLastSale	;		
			string10	v4_CurrAddrLastSalesPrice	;		
			string2	v4_CurrAddrMortgageType	;	// new to 4.0	
			string2	v4_CurrAddrActivePhoneList 	;		
			string10	v4_CurrAddrTaxValue 	;		
			string4	v4_CurrAddrTaxYr	;		
			string10	v4_CurrAddrTaxMarketValue	;		
			string10	v4_CurrAddrAVMValue	;		
			string10	v4_CurrAddrAVMValue12	;	// new to 4.0	
			string10	v4_CurrAddrAVMValue60	;	// new to 4.0	
			string5	v4_CurrAddrCountyIndex	;		
			string5	v4_CurrAddrTractIndex	;		
			string5	v4_CurrAddrBlockIndex	;		
			string3	v4_PrevAddrAgeOldestRecord	;		
			string3	v4_PrevAddrAgeNewestRecord	;		
			string3	v4_PrevAddrLenOfRes 	;		
			string2	v4_PrevAddrDwellType 	;		
			string2	v4_PrevAddrApplicantOwned 	;		
			string2	v4_PrevAddrFamilyOwned 	;		
			string2	v4_PrevAddrOccupantOwned	;		
			string3	v4_PrevAddrAgeLastSale	;		
			string10	v4_PrevAddrLastSalesPrice	;		
			string10	v4_PrevAddrTaxValue	;		
			string4	v4_PrevAddrTaxYr	;		
			string10	v4_PrevAddrTaxMarketValue	;		
			string10	v4_PrevAddrAVMValue	;		
			string5	v4_PrevAddrCountyIndex	;		
			string5	v4_PrevAddrTractIndex	;		
			string5	v4_PrevAddrBlockIndex	;		
			string4	v4_AddrMostRecentDistance	;	// new to 4.0	
			string2	v4_AddrMostRecentStateDiff	;	// new to 4.0	
			string11	v4_AddrMostRecentTaxDiff	;	// new to 4.0	
			string3	v4_AddrMostRecentMoveAge	;	// new to 4.0				
			string2	v4_AddrRecentEconTrajectory	;	// new to 4.0	
			string2	v4_AddrRecentEconTrajectoryIndex	;	// new to 4.0	
			string1	v4_EducationAttendedCollege	;		
			string2	v4_EducationProgram2Yr	;		
			string2	v4_EducationProgram4Yr	;		
			string2	v4_EducationProgramGraduate	;		
			string2	v4_EducationInstitutionPrivate	;		
			string2	v4_EducationFieldofStudyType	;	// new to 4.0	
			string2	v4_EducationInstitutionRating	;		
			string1	v4_AddrStability 	;	// is this the new addrstabilityv2 model or old model?	
			string2	v4_StatusMostRecent 	;		
			string2	v4_StatusPrevious 	;		
			string2	v4_StatusNextPrevious	;		
			string3	v4_AddrChangeCount01	;		
			string3	v4_AddrChangeCount03	;		
			string3	v4_AddrChangeCount06	;		
			string3	v4_AddrChangeCount12	;		
			string3	v4_AddrChangeCount24 	;		
			string3	v4_AddrChangeCount60 	;		
			string10	v4_EstimatedAnnualIncome	;	// was named PredictedAnnualIncome	in version3
			string1	v4_PropertyOwner	;	// new to 4.0	
			string3	v4_PropOwnedCount	;		
			string10	v4_PropOwnedTaxTotal	;		
			string3	v4_PropOwnedHistoricalCount	;		
			string3	v4_PropAgeOldestPurchase	;		
			string3	v4_PropAgeNewestPurchase	;		
			string3	v4_PropAgeNewestSale	;		
			string10	v4_PropNewestSalePrice	;		
			string5	v4_PropNewestSalePurchaseIndex	;		
			string3	v4_PropPurchasedCount01	;		
			string3	v4_PropPurchasedCount03	;		
			string3	v4_PropPurchasedCount06	;		
			string3	v4_PropPurchasedCount12	;		
			string3	v4_PropPurchasedCount24	;		
			string3	v4_PropPurchasedCount60	;		
			string3	v4_PropSoldCount01	;		
			string3	v4_PropSoldCount03	;		
			string3	v4_PropSoldCount06	;		
			string3	v4_PropSoldCount12	;		
			string3	v4_PropSoldCount24 	;		
			string3	v4_PropSoldCount60 	;		
			string1	v4_AssetOwner	;	// new to 4.0	
			string1	v4_WatercraftOwner	;	// new to 4.0	
			string3	v4_WatercraftCount	;		
			string3	v4_WatercraftCount01	;		
			string3	v4_WatercraftCount03	;		
			string3	v4_WatercraftCount06	;		
			string3	v4_WatercraftCount12 	;		
			string3	v4_WatercraftCount24	;		
			string3	v4_WatercraftCount60 	;		
			string1	v4_AircraftOwner	;	// new to 4.0	
			string3	v4_AircraftCount	;		
			string3	v4_AircraftCount01	;		
			string3	v4_AircraftCount03	;		
			string3	v4_AircraftCount06	;		
			string3	v4_AircraftCount12 	;		
			string3	v4_AircraftCount24	;		
			string3	v4_AircraftCount60 	;		
			string2	v4_WealthIndex 	;		
			string2	v4_BusinessActiveAssociation	;	// new to 4.0	
			string2	v4_BusinessInactiveAssociation	;	// new to 4.0	
			string3	v4_BusinessAssociationAge	;	// new to 4.0	
			string100	v4_BusinessTitle	;	// new to 4.0	
			string1	v4_DerogSeverityIndex	;	// new to 4.0	
			string3	v4_DerogCount	;		
			string3	v4_DerogRecentCount	;	// new to 4.0	
			string3	v4_DerogAge	;		
			string3	v4_FelonyCount	;		
			string3	v4_FelonyAge	;		
			string3	v4_FelonyCount01	;		
			string3	v4_FelonyCount03	;		
			string3	v4_FelonyCount06	;		
			string3	v4_FelonyCount12	;		
			string3	v4_FelonyCount24	;		
			string3	v4_FelonyCount60	;		
			string3	v4_LienCount	;		
			string3	v4_LienFiledCount	;		
			string3	v4_LienFiledAge	;		
			string3	v4_LienFiledCount01	;		
			string3	v4_LienFiledCount03	;		
			string3	v4_LienFiledCount06	;		
			string3	v4_LienFiledCount12	;		
			string3	v4_LienFiledCount24	;		
			string3	v4_LienFiledCount60	;		
			string3	v4_LienReleasedCount	;		
			string3	v4_LienReleasedAge	;		
			string3	v4_LienReleasedCount01	;		
			string3	v4_LienReleasedCount03	;		
			string3	v4_LienReleasedCount06	;		
			string3	v4_LienReleasedCount12	;		
			string3	v4_LienReleasedCount24	;		
			string3	v4_LienReleasedCount60	;		
			string10	v4_LienFiledTotal	;	// new to 4.0	
			string10	v4_LienFederalTaxFiledTotal	;		
			string10	v4_LienTaxOtherFiledTotal	;		
			string10	v4_LienForeclosureFiledTotal	;		
			string10	v4_LienLandlordTenantFiledTotal	;		
			string10	v4_LienJudgmentFiledTotal	;		
			string10	v4_LienSmallClaimsFiledTotal	;		
			string10	v4_LienOtherFiledTotal	;		
			string10	v4_LienReleasedTotal	;	// new to 4.0	
			string10	v4_LienFederalTaxReleasedTotal	;		
			string10	v4_LienTaxOtherReleasedTotal	;		
			string10	v4_LienForeclosureReleasedTotal	;		
			string10	v4_LienLandlordTenantReleasedTotal	;		
			string10	v4_LienJudgmentReleasedTotal	;		
			string10	v4_LienSmallClaimsReleasedTotal	;		
			string10	v4_LienOtherReleasedTotal	;		
			string3	v4_LienFederalTaxFiledCount	;		
			string3	v4_LienTaxOtherFiledCount	;		
			string3	v4_LienForeclosureFiledCount	;		
			string3	v4_LienLandlordTenantFiledCount	;		
			string3	v4_LienJudgmentFiledCount	;		
			string3	v4_LienSmallClaimsFiledCount	;		
			string3	v4_LienOtherFiledCount	;		
			string3	v4_LienFederalTaxReleasedCount	;		
			string3	v4_LienTaxOtherReleasedCount	;		
			string3	v4_LienForeclosureReleasedCount	;		
			string3	v4_LienLandlordTenantReleasedCount	;		
			string3	v4_LienJudgmentReleasedCount	;		
			string3	v4_LienSmallClaimsReleasedCount	;		
			string3	v4_LienOtherReleasedCount	;		
			string3	v4_BankruptcyCount	;		
			string3	v4_BankruptcyAge	;		
			string3	v4_BankruptcyType	;		
			string35	v4_BankruptcyStatus	;		
			string3	v4_BankruptcyCount01	;		
			string3	v4_BankruptcyCount03	;		
			string3	v4_BankruptcyCount06	;		
			string3	v4_BankruptcyCount12	;		
			string3	v4_BankruptcyCount24	;		
			string3	v4_BankruptcyCount60	;		
			string3	v4_EvictionCount	;		
			string3	v4_EvictionAge	;		
			string3	v4_EvictionCount01	;		
			string3	v4_EvictionCount03	;		
			string3	v4_EvictionCount06	;		
			string3	v4_EvictionCount12 	;		
			string3	v4_EvictionCount24 	;		
			string3	v4_EvictionCount60 	;		
			string2	v4_RecentActivityIndex	;	// new to 4.0	
			string3	v4_NonDerogCount	;		
			string3	v4_NonDerogCount01	;		
			string3	v4_NonDerogCount03	;		
			string3	v4_NonDerogCount06	;		
			string3	v4_NonDerogCount12	;		
			string3	v4_NonDerogCount24	;		
			string3	v4_NonDerogCount60	;		
			string1	v4_VoterRegistrationRecord	;	// new to 4.0	
			string3	v4_ProfLicCount	;		
			string3	v4_ProfLicAge	;		
			string60	v4_ProfLicType	;		
			string2	v4_ProfLicTypeCategory	;		
			string2	v4_ProfLicExpired	;	// was named ProfLicExpireDate	in version3, changed to a boolean
			string3	v4_ProfLicCount01	;		
			string3	v4_ProfLicCount03	;		
			string3	v4_ProfLicCount06	;		
			string3	v4_ProfLicCount12	;		
			string3	v4_ProfLicCount24	;		
			string3	v4_ProfLicCount60	;		
			string1	v4_InquiryCollectionsRecent	;	// new to 4.0	
			string1	v4_InquiryPersonalFinanceRecent	;	// new to 4.0	
			string1	v4_InquiryOtherRecent	;	// new to 4.0	
			string1	v4_HighRiskCreditActivity	;	// new to 4.0	
			string3	v4_SubPrimeOfferRequestCount	;	// was named SubPrimeSolicitedCount	in version3
			string3	v4_SubPrimeOfferRequestCount01	;	// was named SubPrimeSolicitedCount01	in version3
			string3	v4_SubPrimeOfferRequestCount03	;	// was named SubprimeSolicitedCount03	in version3
			string3	v4_SubPrimeOfferRequestCount06	;	// was named SubprimeSolicitedCount06	in version3
			string3	v4_SubPrimeOfferRequestCount12	;	// was named SubPrimeSolicitedCount12	in version3
			string3	v4_SubPrimeOfferRequestCount24	;	// was named SubPrimeSolicitedCount24	in version3
			string3	v4_SubPrimeOfferRequestCount60	;	// was named SubPrimeSolicitedCount60	in version3
			string2	v4_InputPhoneMobile 	;		
			string3	v4_PhoneEDAAgeOldestRecord	;		
			string3	v4_PhoneEDAAgeNewestRecord	;		
			string3	v4_PhoneOtherAgeOldestRecord	;		
			string3	v4_PhoneOtherAgeNewestRecord	;		
			string2	v4_InputPhoneHighRisk	;		
			string2	v4_InputPhoneProblems	;	// new to 4.0	
			string2	v4_EmailAddress	;	// new to 4.0	
			string2	v4_InputAddrHighRisk	;			
			string2	v4_CurrAddrCorrectional	;	// new to 4.0	
			string2	v4_PrevAddrCorrectional	;	// new to 4.0	
			string2	v4_HistoricalAddrCorrectional	;	// new to 4.0	
			string2	v4_InputAddrProblems	;	// new to 4.0	
			string1	v4_SecurityFreeze	;		
			string1	v4_SecurityAlert	;		
			string1	v4_IDTheftFlag	;		
			string1	v4_ConsumerStatement	;	// new to 4.0	
			string2	v4_PrescreenOptOut	;		
	end;
	
export Layout_Capone_Batch_In := RECORD
	STRING12 	ADL;
	STRING3 	ADLScore;
	STRING30  AcctNo;
	STRING9   SSN;
	STRING120 UnParsedFullName :='';
	STRING65 	Street_Addr := '';
	STRING25  P_City_Name;
	STRING2   St;
	STRING5   Z5;
	UNSIGNED3 HistoryDateYYYYMM;
END;	
	
//Layout recieved from Rich 9.20.16, with acctNo & seq added.
//This way you can reference this layout and minus certain elements depending upon where you're at in the flow of execution
export Layout_CaponeRV5_Batch_In := RECORD
	STRING30  AcctNo;
	STRING50  RX_unparsedfullname := '';
	STRING50 	Address1 := '';
	STRING30 	Address2 := '';
	STRING20  City;
	STRING2   State;
	STRING5   Zip5;
	STRING9   RX_SSN;
	STRING12 	LexID;
END;	

export layout_fp1109 := record
	models.layout_modelout;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
end;


export Layout_Score_FP := record
	STRING3 i;
	STRING50 Description;
	STRING3 index := '';
	dataset(risk_indicators.layouts.layout_reason_codes_plus_seq) reason_codes;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
end;

export FP_Layout_Model :=
RECORD
	STRING30 AccountNumber;
	STRING50 Description;
	DATASET(Layout_Score_FP) Scores;
END;

export layout_risk_indices := record
	string30 name;
	string1 value;
end;

export Layout_Score_IID_wFP := record
	STRING3 i;
	STRING50 Description;
	STRING3 index := '';
	dataset(risk_indicators.layouts.layout_reason_codes_plus_seq) reason_codes;
	dataset(layout_risk_indices) risk_indices {maxcount(6)};
end;

export Layout_Model_IID :=
RECORD
	STRING30 AccountNumber;
	STRING50 Description;
	DATASET(Layout_Score_IID_wFP) Scores;
END;

export Layout_Model_Options := RECORD
	STRING OptionName := '';
	STRING OptionValue := '';
END;

export Layout_Model_Request_In := RECORD
	STRING ModelName := '';
	DATASET(Layout_Model_Options) ModelOptions;
END;

end;