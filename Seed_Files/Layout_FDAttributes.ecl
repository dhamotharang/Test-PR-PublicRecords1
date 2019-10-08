﻿import riskwise;

Layout_Version1 := RECORD
	unsigned4 SSNFirstSeen;
	unsigned4 DateLastSeen;
	boolean   isRecentUpdate;
	unsigned1 NumSources;
	boolean   isPhoneFullNameMatch;
	boolean   isPhoneLastNameMatch;
	unsigned1 inferredAge;
	boolean   isSSNInvalid;
	boolean   isPhoneInvalid;
	boolean   isAddrInvalid;
	boolean   isDLInvalid;
	boolean   isNoVer;
	
	// SSN Attributes
	boolean   isDeceased;
	unsigned4 DeceasedDate;
	boolean   isSSNValid;
	boolean   isRecentIssue;
	unsigned4 LowIssueDate;
	unsigned4 HighIssueDate;
	string2   IssueState;
	boolean   isNonUS;
	boolean   isIssued3;
	boolean   isIssuedAge5;
	string3   ssnCode;
	
	// Evidence of Compromised Identity
	boolean   isSSNNotFound;
	boolean   isFoundOther;
	boolean   isIssuedPrior;
	boolean   isPhoneOther;
	unsigned1 SSNPerID;
	unsigned1 AddrPerID;
	unsigned1 PhonePerID;
	unsigned1 IDPerSSN;
	unsigned1 AddrPerSSN;
	unsigned1 IDPerAddr;
	unsigned1 SSNPerAddr;
	unsigned1 PhonePerAddr;
	unsigned1 IDPerPhone;
	unsigned1 SSNPerID6;
	unsigned1 AddrPerID6;
	unsigned1 PhonePerID6;
	unsigned1 IDPerSSN6;
	unsigned1 AddrPerSSN6;
	unsigned1 IDPerAddr6;
	unsigned1 SSNPerAddr6;
	unsigned1 PhonePerAddr6;
	unsigned1 IDPerPhone6;
	
	// Identity Change Information
	unsigned1 LastPerSSN;
	unsigned1 LastPerID;
	unsigned3 DateLastNameChange;
	string20  NewLastName;
	unsigned1 LastNames30;
	unsigned1 LastNames90;
	unsigned1 LastNames180;
	unsigned1 LastNames12;
	unsigned1 LastNames24;
	unsigned1 LastNames36;
	unsigned1 LastNames60;
	unsigned1 IDPerSFDUAddr;
	unsigned1 SSNPerSFDUAddr;

	// Characteristics of Input Address
	string65  IAAddress;
	string25  IACity;
	string2   IAState;
	string5   IAZip;
	string4   IAZip4;
	unsigned3 IADateFirstReported;
	unsigned3 IADateLastReported;
	unsigned1 IALenOfRes;
	string1   IADwellType;
	boolean   IAisNotPrimaryRes;
	unsigned1 IAPhoneListed;
	unsigned5 IAPhoneNumber;
	string10  IAMED_HHINC;
	string10  IAMED_HVAL;
	string3   IAMURDERS;
	string3   IACARTHEFT;
	string3   IABURGLARY;
	string3   IATOTCRIME;
	
	// Characteristics of Current Address (most recently reported)
	string65  CAAddress;
	string25  CACity;
	string2   CAState;
	string5   CAZip;
	string4   CAZip4;
	unsigned3 CADateFirstReported;
	unsigned3 CADateLastReported;
	unsigned1 CALenOfRes;
	string1   CADwellType;
	boolean   CAisNotPrimaryRes;
	unsigned1 CAPhoneListed;
	unsigned5 CAPhoneNumber;
	string10  CAMED_HHINC;
	string10  CAMED_HVAL;
	string3   CAMURDERS;
	string3   CACARTHEFT;
	string3   CABURGLARY;
	string3   CATOTCRIME;
	
	// Characteristics of Previous Address (next most recently reported)
	string65  PAAddress;
	string25  PACity;
	string2   PAState;
	string5   PAZip;
	string4   PAZip4;
	unsigned3 PADateFirstReported;
	unsigned3 PADateLastReported;
	unsigned1 PALenOfRes;
	string1   PADwellType;
	boolean   PAisNotPrimaryRes;
	unsigned1 PAPhoneListed;
	unsigned5 PAPhoneNumber;
	string10  PAMED_HHINC;
	string10  PAMED_HVAL;
	string3   PAMURDERS;
	string3   PACARTHEFT;
	string3   PABURGLARY;
	string3   PATOTCRIME;
	
	// Differences between Input Address and Current Address
	boolean   isInputCurrMatch;
	unsigned2 DistInputCurr;
	boolean   isDiffState;
	integer4  IncomeDiff;
	integer4  HomeValueDiff;
	integer   CrimeDiff;
	string2   EcoTrajectory;
	
	// Differences between Current Address and Previous Address
	boolean   isInputPrevMatch;
	unsigned2 DistCurrPrev;
	boolean   isDiffState2;
	integer4  IncomeDiff2;
	integer4  HomeValueDiff2;
	integer   CrimeDiff2;
	string2   EcoTrajectory2;
	
	// Transient Person Attributes
	string1   mobility_indicator;
	string1   statusAddr;
	string1   statusAddr2;
	string1   statusAddr3;
	unsigned3 PADateFirstReported2;
	unsigned3 NPADateFirstReported;
	unsigned1 addrChanges30;
	unsigned1 addrChanges90;
	unsigned1 addrChanges180;
	unsigned1 addrChanges12;
	unsigned1 addrChanges24;
	unsigned1 addrChanges36;
	unsigned1 addrChanges60;
	
	// Derogatory Public Records
	unsigned1 felonies;
	unsigned4 date_last_conviction;
	unsigned1 felonies30;
	unsigned1 felonies90;
	unsigned1 felonies180;
	unsigned1 felonies12;
	unsigned1 felonies24;
	unsigned1 felonies36;
	unsigned1 felonies60;
	
	// new section
	unsigned1 arrests;
	unsigned4 date_last_arrest;
	unsigned1 arrests30;
	unsigned1 arrests90;
	unsigned1 arrests180;
	unsigned1 arrests12;
	unsigned1 arrests24;
	unsigned1 arrests36;
	unsigned1 arrests60;
	
	// Higher Risk Address and Phone Attributes
	boolean   isAddrHighRisk;
	boolean   isPhoneHighRisk;
	string30  hriskcmpy;
  string6   sic;
	boolean   isAddrPrison;
	boolean   isZipPOBox;
	boolean   isZipCorpMil;
	string1   phoneStatus;
	boolean   isPhonePager;
	boolean   isPhoneMobile;
	boolean   isPhoneZipMismatch;
	unsigned3 phoneAddrDist;
	string1   hphonetypeflag;
  string2   hphonesrvcflag;
	string1   areacodesplit;
  string3   altareacode;
	string1   addrval;
  string5   invalidaddr;
	
	// Higher Risk Internet Connection Attributes
	boolean IPinvalid;
	boolean IPNonUS;
	string2 IPState;
	string2 IPCountry;
	string1 IPContinent;
END;

Layout_IDAttributes := RECORD
	STRING5 InputPresent;
	STRING5 DoOutput;
	STRING1 DataReturn;
	STRING3 FirstCount;
	STRING3 LastCount;
	STRING3 AddrCount;
	STRING3 FormerAddrCount;
	STRING3 HPhoneCount;
	STRING3 SocsCount;
	STRING2 SocsVerLevel;
	STRING3 DOBCount;
	STRING3 DRLCCount;
	STRING3 CmpyCount;
	STRING20 VerFirst;
	STRING20 VerLast;
	STRING100 VerCmpy;
	STRING120 VerAddr;
	STRING25 VerCity;
	STRING2 VerState;
	STRING9 VerZIP;
	STRING10 VerHPhone;
	STRING9 VerSocs;
	STRING20 VerDRLC;
	STRING8 VerDOB;
	STRING3 NumELever;
	STRING3 NumSource;
	STRING3 FirstScore;
	STRING3 LastScore;
	STRING3 CmpyScore;
	STRING3 AddrScore;
	STRING3 HPhoneScore;
	STRING3 SocsScore;
	STRING3 DOBScore;
	STRING3 DRLCScore;
	STRING20 WPhoneName;
	STRING120 WPhoneAddr;
	STRING25 WPhoneCity;
	STRING2 WPhoneState;
	STRING9 WPhoneZIP;
	STRING1 SocsMiskeyFlag;
	STRING1 HPhoneMiskeyFlag;
	STRING1 AddrMiskeyFlag;
	STRING1 IDTheftFlag;
	STRING1 AptScanFlag;
	STRING1 AddrHistoryFlag;
	STRING1 COAAlertFlag;
	STRING20 COAFirst;
	STRING20 COALast;
	STRING120 COAAddr;
	STRING25 COACity;
	STRING2 COAState;
	STRING9 COAZip;
	STRING1 WPhoneTypeFlag;
	STRING1 WPhoneValFlag;
	STRING1 HPhoneTypeFlag;
	STRING1 HPhoneValFlag;
	STRING1 PhoneZIPFlag;
	STRING1 PhoneDissFlag;
	STRING1 AddrValFlag;
	STRING1 DwellTypeFlag;
	STRING1 ZIPTypeFlag;
	STRING1 SocsValFlag;
	STRING1 DecsFlag;
	STRING1 SocsDOBFlag;
	STRING1 AreaCodeSplitFlag;
	STRING8 AreaCodeSplitDate;
	STRING3 AltAreaCode;
	STRING1 BansFlag;
	STRING1 DRLCValFlag;
	STRING1 DRLCSoundX;
	STRING20 DRLCFirst;
	STRING20 DRLCLast;
	STRING20 DRLCMiddle;
	STRING9 DRLCSocs;
	STRING8 DRLCDOB;
	STRING1 DRLCGender;
	STRING1 DistAddrPrevAddr;
	STRING10 DistHPhoneWPhone;
	STRING10 DistWPhoneAddr;
	STRING1 StateZIPFlag;
	STRING1 CityZIPFlag;
	STRING1 HPhoneStateFlag;
	STRING1 CheckAcctFlag;
	STRING120 CassAddr;
	STRING25 CassCity;
	STRING2 CassState;
	STRING9 CassZIP;
	STRING1 AddrCommFlag;
	STRING30 NonResName;
	STRING6 NonResSic;
	STRING10 NonResPhone;
	STRING50 NonResAddr;
	STRING30 NonResCity;
	STRING2 NonResState;
	STRING9 NonResZIP;
	STRING3 NumFraud;
	STRING1 Score2;
	STRING1 TciAddrFlag;
	STRING1 TciPrevAddrFlag;
	STRING1 EstIncome;
	STRING1 EmailDomainFlag;
	STRING1 EmailUserFlag;
	STRING1 EmailBrowserFlag;
	STRING1 HRiskEmailDomainFlag;
	STRING1 DistAddrDomain;
END;

Layout_version2 := record
	string2	IdentityRiskLevel	;
	string3	IdentityAgeOldest	;
	string3	IdentityAgeNewest	;
	string1	IdentityRecentUpdate	;
	string3	IdentityRecordCount	;
	string3	IdentitySourceCount	;
	string2	IdentityAgeRiskIndicator	;
	string2	IDVerRiskLevel	;
	string2	IDVerSSN	;
	string1	IDVerName	;
	string2	IDVerAddress	;
	string2	IDVerAddressNotCurrent	;
	string3	IDVerAddressAssocCount	;
	string2	IDVerPhone	;
	string2	IDVerDriversLicense	;
	string2	IDVerDOB	;
	string3	IDVerSSNSourceCount	;
	string3	IDVerAddressSourceCount	;
	string3	IDVerDOBSourceCount	;
	string2	IDVerSSNCreditBureauCount	;
	string2	IDVerSSNCreditBureauDelete	;
	string2	IDVerAddrCreditBureauCount	;
	string2	SourceRiskLevel	;
	string1	SourceFirstReportingIdentity	;
	string1	SourceCreditBureau	;
	string2	SourceCreditBureauCount	;
	string3	SourceCreditBureauAgeOldest	;
	string3	SourceCreditBureauAgeNewest	;
	string3	SourceCreditBureauAgeChange	;
	string1	SourcePublicRecord	;
	string3	SourcePublicRecordCount	;
	string3	SourcePublicRecordCountYear	;
	string1	SourceEducation	;
	string1	SourceOccupationalLicense	;
	string1	SourceVoterRegistration	;
	string2	SourceOnlineDirectory	;
	string1	SourceDoNotMail	;
	string1	SourceAccidents	;
	string1	SourceBusinessRecords	;
	string1	SourceProperty	;
	string1	SourceAssets	;
	string1	SourcePhoneDirectoryAssistance	;
	string1	SourcePhoneNonPublicDirectory	;
	string2	VariationRiskLevel	;
	string3	VariationIdentityCount	;
	string3	VariationSSNCount	;
	string3	VariationSSNCountNew	;
	string3	VariationMSourcesSSNCount	;
	string3	VariationMSourcesSSNUnrelCount	;
	string3	VariationLastNameCount	;
	string3	VariationLastNameCountNew	;
	string3	VariationAddrCountYear	;
	string3	VariationAddrCountNew	;
	string1	VariationAddrStability	;
	string3	VariationAddrChangeAge	;
	string3	VariationDOBCount	;
	string3	VariationDOBCountNew	;
	string3	VariationPhoneCount	;
	string3	VariationPhoneCountNew	;
	string3	VariationSearchSSNCount	;
	string3	VariationSearchAddrCount	;
	string3	VariationSearchPhoneCount	;
	string2	SearchVelocityRiskLevel	;
	string3	SearchCount	;
	string3	SearchCountYear	;
	string3	SearchCountMonth	;
	string3	SearchCountWeek	;
	string3	SearchCountDay	;
	string3	SearchUnverifiedSSNCountYear	;
	string3	SearchUnverifiedAddrCountYear	;
	string3	SearchUnverifiedDOBCountYear	;
	string3	SearchUnverifiedPhoneCountYear	;
	string3	SearchBankingSearchCount	;
	string3	SearchBankingSearchCountYear	;
	string3	SearchBankingSearchCountMonth	;
	string3	SearchBankingSearchCountWeek	;
	string3	SearchBankingSearchCountDay	;
	string3	SearchHighRiskSearchCount	;
	string3	SearchHighRiskSearchCountYear	;
	string3	SearchHighRiskSearchCountMonth	;
	string3	SearchHighRiskSearchCountWeek	;
	string3	SearchHighRiskSearchCountDay	;
	string3	SearchFraudSearchCount	;
	string3	SearchFraudSearchCountYear	;
	string3	SearchFraudSearchCountMonth	;
	string3	SearchFraudSearchCountWeek	;
	string3	SearchFraudSearchCountDay	;
	string3	SearchLocateSearchCount	;
	string3	SearchLocateSearchCountYear	;
	string3	SearchLocateSearchCountMonth	;
	string3	SearchLocateSearchCountWeek	;
	string3	SearchLocateSearchCountDay	;
	string2	AssocRiskLevel	;
	string3	AssocCount	;
	string2	AssocDistanceClosest	;
	string3	AssocSuspicousIdentitiesCount	;
	string3	AssocCreditBureauOnlyCount	;
	string3	AssocCreditBureauOnlyCountNew	;
	string3	AssocCreditBureauOnlyCountMonth	;
	string3	AssocHighRiskTopologyCount	;
	string2	ValidationRiskLevel	;
	string2	ValidationSSNProblems	;
	string2	ValidationAddrProblems	;
	string2	ValidationPhoneProblems	;
	string2	ValidationDLProblems	;
	string2	ValidationIPProblems	;
	string2	CorrelationRiskLevel	;
	string3	CorrelationSSNNameCount	;
	string3	CorrelationSSNAddrCount	;
	string3	CorrelationAddrNameCount	;
	string3	CorrelationAddrPhoneCount	;
	string3	CorrelationPhoneLastNameCount	;
	string2	DivRiskLevel	;
	string3	DivSSNIdentityCount	;
	string3	DivSSNIdentityCountNew	;
	string3	DivSSNIdentityMSourceCount	;
	string3	DivSSNIdentityMSourceUrelCount	;
	string3	DivSSNLNameCount	;
	string3	DivSSNLNameCountNew	;
	string3	DivSSNAddrCount	;
	string3	DivSSNAddrCountNew	;
	string3	DivSSNAddrMSourceCount	;
	string3	DivAddrIdentityCount	;
	string3	DivAddrIdentityCountNew	;
	string3	DivAddrIdentityMSourceCount	;
	string3	DivAddrSuspIdentityCountNew	;
	string3	DivAddrSSNCount	;
	string3	DivAddrSSNCountNew	;
	string3	DivAddrSSNMSourceCount	;
	string3	DivAddrPhoneCount	;
	string3	DivAddrPhoneCountNew	;
	string3	DivAddrPhoneMSourceCount	;
	string3	DivPhoneIdentityCount	;
	string3	DivPhoneIdentityCountNew	;
	string3	DivPhoneIdentityMSourceCount	;
	string3	DivPhoneAddrCount	;
	string3	DivPhoneAddrCountNew	;
	string3	DivSearchSSNIdentityCount	;
	string3	DivSearchAddrIdentityCount	;
	string3	DivSearchAddrSuspIdentityCount	;
	string3	DivSearchPhoneIdentityCount	;
	string2	SearchComponentRiskLevel	;
	string3	SearchSSNSearchCount	;
	string3	SearchSSNSearchCountYear	;
	string3	SearchSSNSearchCountMonth	;
	string3	SearchSSNSearchCountWeek	;
	string3	SearchSSNSearchCountDay	;
	string3	SearchAddrSearchCount	;
	string3	SearchAddrSearchCountYear	;
	string3	SearchAddrSearchCountMonth	;
	string3	SearchAddrSearchCountWeek	;
	string3	SearchAddrSearchCountDay	;
	string3	SearchPhoneSearchCount	;
	string3	SearchPhoneSearchCountYear	;
	string3	SearchPhoneSearchCountMonth	;
	string3	SearchPhoneSearchCountWeek	;
	string3	SearchPhoneSearchCountDay	;
	string2	ComponentCharRiskLevel	;
	string3	SSNHighIssueAge	;
	string3	SSNLowIssueAge	;
	string2	SSNIssueState	;
	string2	SSNNonUS	;
	string2	InputPhoneType	;
	string2 IPState;
	string2 IPCountry;
	string2 IPContinent;
	string3	InputAddrAgeOldest	;
	string3	InputAddrAgeNewest	;
	string2	InputAddrType	;
	string3	InputAddrLenOfRes	;
	string2	InputAddrDwellType	;
	string2	InputAddrDelivery	;
	string2	InputAddrActivePhoneList	;
	string2	InputAddrOccupantOwned	;
	string3	InputAddrBusinessCount	;
	string3	InputAddrNBRHDBusinessCount	;
	string3	InputAddrNBRHDSingleFamilyCount	;
	string3	InputAddrNBRHDMultiFamilyCount	;
	string10	InputAddrNBRHDMedianIncome	;
	string10	InputAddrNBRHDMedianValue	;
	string3	InputAddrNBRHDMurderIndex	;
	string3	InputAddrNBRHDCarTheftIndex	;
	string3	InputAddrNBRHDBurglaryIndex	;
	string3	InputAddrNBRHDCrimeIndex	;
	string3	InputAddrNBRHDMobilityIndex	;
	string3	InputAddrNBRHDVacantPropCount	;
	string4	AddrChangeDistance	;
	string2	AddrChangeStateDiff	;
	string11	AddrChangeIncomeDiff	;
	string11	AddrChangeValueDiff	;
	string4	AddrChangeCrimeDiff	;
	string2	AddrChangeEconTrajectory	;
	string2	AddrChangeEconTrajectoryIndex	;
	string3	CurrAddrAgeOldest	;
	string3	CurrAddrAgeNewest	;
	string3	CurrAddrLenOfRes	;
	string2	CurrAddrDwellType	;
	string2	CurrAddrStatus	;
	string2	CurrAddrActivePhoneList	;
	string10	CurrAddrMedianIncome	;
	string10	CurrAddrMedianValue	;
	string3	CurrAddrMurderIndex	;
	string3	CurrAddrCarTheftIndex	;
	string3	CurrAddrBurglaryIndex	;
	string3	CurrAddrCrimeIndex	;
	string3	PrevAddrAgeOldest	;
	string3	PrevAddrAgeNewest	;
	string3	PrevAddrLenOfRes	;
	string2	PrevAddrDwellType	;
	string2	PrevAddrStatus	;
	string2	PrevAddrOccupantOwned	;
	string10	PrevAddrMedianIncome	;
	string10	PrevAddrMedianValue	;
	string3	PrevAddrMurderIndex	;
	string3	PrevAddrCarTheftIndex	;
	string3	PrevAddrBurglaryIndex	;
	string3	PrevAddrCrimeIndex	;
end;

Layout_version201 := record
	string2	IDVerAddressMatchesCurrent;
	string2	IDVerAddressVoter;
	string2	IDVerAddressVehicleRegistation;
	string2	IDVerAddressDriversLicense;
	string2	IDVerDriversLicenseType;
	string2	IDVerSSNDriversLicense;
	string2	SourceVehicleRegistration;
	string2	SourceDriversLicense;
	string2	IdentityDriversLicenseComp	:= '';
end;
Layout_version202 := record
  string2 IDVerFNameBest := '';
  string2 IDVerLNameBest := '';
  string2 IDVerSSNBest := '';
  string3 VariationSearchSSNCtDay := '';
  string3 VariationSearchSSNCtWeek := '';
  string3 VariationSearchSSNCtMonth := '';
  string3 VariationSearchSSNCt3Month := '';
  string3 VariationSearchSSNCtNew := '';
  string3 VariationSearchAddrCtDay := '';
  string3 VariationSearchAddrCtWeek := '';
  string3 VariationSearchAddrCtMonth := '';
  string3 VariationSearchAddrCt3Month := '';
  string3 VariationSearchAddrCtNew := '';
  string3 VariationSearchPhoneCtDay := '';
  string3 VariationSearchPhoneCtWeek := '';
  string3 VariationSearchPhoneCtMonth := '';
  string3 VariationSearchPhoneCt3Month := '';
  string3 VariationSearchLNameCtDay := '';
  string3 VariationSearchLNameCtWeek := '';
  string3 VariationSearchLNameCtMonth := '';
  string3 VariationSearchLNameCt3Month := '';
  string3 VariationSearchFNameCtDay := '';
  string3 VariationSearchFNameCtWeek := '';
  string3 VariationSearchFNameCtMonth := '';
  string3 VariationSearchFNameCt3Month := '';
  string3 VariationSearchFNameCtNew := '';
  string3 VariationSearchDOBCtDay := '';
  string3 VariationSearchDOBCtWeek := '';
  string3 VariationSearchDOBCtMonth := '';
  string3 VariationSearchDOBCt3Month := '';
  string3 VariationSearchDOBCtNew := '';
  string3 VariationSearchEmailCt := '';
  string3 VariationSearchEmailCtDay := '';
  string3 VariationSearchEmailCtWeek := '';
  string3 VariationSearchEmailCtMonth := '';
  string3 VariationSearchEmailCt3Month := '';
  string3 VariationSearchEmailCtNew := '';
  string3 VariationSearchSSN1SubCt := '';
  string3 VariationSearchPhone1SubCt := '';
  string3 VariationSearchAddr1SubCt := '';
  string3 VariationSearchDOB1SubCt := '';
  string3 VariationSearchFName1SubCt := '';
  string3 VariationSearchLName1SubCt := '';
  string3 VariationSearchDOB1SubDayCt := '';
  string3 VariationSearchDOB1SubMoCt := '';
  string3 VariationSearchDOB1SubYrCt := '';
  string3 VariationSearchSSNSeqCt := '';
  string3 VariationSearchPhoneSeqCt := '';
  string3 VariationSearchAddrSeqCt := '';
  string3 VariationSearchDobSeqCt := '';
  string3 SearchSSNBestSearchCt := '';
  string3 DivSearchSSNBestIdentityCt := '';
  string3 DivSearchSSNBestLNameCt := '';
  string3 DivSearchSSNBestAddrCt := '';
  string3 DivSearchSSNBestDOBCt := '';
  string3 CorrNameDOBCt := '';
  string3 CorrAddrDOBCt := '';
  string3 CorrSSNDOBCt := '';
  string3 CorrSearchSSNNameCt := '';
  string3 CorrSearchVerSSNNameCt := '';
  string3 CorrSearchNamePhoneCt := '';
  string3 CorrSearchVerNamePhoneCt := '';
  string3 CorrSearchSSNAddrCt := '';
  string3 CorrSearchVerSSNAddrCt := '';
  string3 CorrSearchAddrDOBCt := '';
  string3 CorrSearchVerAddrDOBCt := '';
  string3 CorrSearchAddrPhoneCt := '';
  string3 CorrSearchVerAddrPhoneCt := '';
  string3 CorrSearchSSNDOBCt := '';
  string3 CorrSearchVerSSNDOBCt := '';
  string3 CorrSearchSSNPhoneCt := '';
  string3 CorrSearchVerSSNPhoneCt := '';
  string3 CorrSearchDOBPhoneCt := '';
  string3 CorrSearchVerDOBPhoneCt := '';
  string3 CorrSearchSSNAddrNameCt := '';
  string3 CorrSearchVerSSNAddrNameCt := '';
  string3 CorrSearchSSNNamePhoneCt := '';
  string3 CorrSearchVerSSNNamePhoneCt := '';
  string3 CorrSearchSSNAddrNamePhoneCt := '';
  string3 CorrSearchVerSSNAddrNamePhneCt := '';
  string3 DivSearchAddrSSNCtDay := '';
  string3 DivSearchAddrSSNCtWeek := '';
  string3 DivSearchAddrSSNCt1Month := '';
  string3 DivSearchAddrSSNCt3Month := '';
  string3 DivSearchAddrSSNCtNew := '';
  string3 DivSearchSSNIdentityCtDay := '';
  string3 DivSearchSSNIdentityCtWeek := '';
  string3 DivSearchSSNIdentityCt1Month := '';
  string3 DivSearchSSNIdentityCt3Month := '';
  string3 DivSearchSSNIdentityCtNew := '';
  string3 DivSearchAddrIdentityCtDay := '';
  string3 DivSearchAddrIdentityCtWeek := '';
  string3 DivSearchAddrIdentityCt1Month := '';
  string3 DivSearchAddrIdentityCt3Month := '';
  string3 DivSearchAddrIdentityCtNew := '';
  string3 DivSearchPhoneIdentityCt := '';
  string3 DivSearchPhoneIdentityCtDay := '';
  string3 DivSearchPhoneIdentityCtWeek := '';
  string3 DivSearchPhoneIdentityCt1Month := '';
  string3 DivSearchPhoneIdentityCt3Month := '';
  string3 DivSearchPhoneIdentityCtNew := '';
  string3 DivSearchSSNLNameCtDay := '';
  string3 DivSearchSSNLNameCtWeek := '';
  string3 DivSearchSSNLNameCt1Month := '';
  string3 DivSearchSSNLNameCt3Month := '';
  string3 DivSearchSSNLNameCtNew := '';
  string3 DivSearchSSNAddrCtDay := '';
  string3 DivSearchSSNAddrCtWeek := '';
  string3 DivSearchSSNAddrCt1Month := '';
  string3 DivSearchSSNAddrCt3Month := '';
  string3 DivSearchSSNAddrCtNew := '';
  string3 DivSearchSSNDOBCtDay := '';
  string3 DivSearchSSNDOBCtWeek := '';
  string3 DivSearchSSNDOBCt1Month := '';
  string3 DivSearchSSNDOBCt3Month := '';
  string3 DivSearchSSNDOBCtNew := '';
  string3 DivSearchAddrLNameCtDay := '';
  string3 DivSearchAddrLNameCtWeek := '';
  string3 DivSearchAddrLNameCt1Month := '';
  string3 DivSearchAddrLNameCt3Month := '';
  string3 DivSearchAddrLNameCtNew := '';
  string3 DivSearchEmailIdentityCt := '';
  string3 DivSearchEmailIdentityCtDay := '';
  string3 DivSearchEmailIdentityCtWeek := '';
  string3 DivSearchEmailIdentityCt1Month := '';
  string3 DivSearchEmailIdentityCt3Month := '';
  string3 DivSearchEmailIdentityCtNew := '';
  string3 SearchPhoneSearchCtDay := '';
  string3 SearchPhnSearchCtWeek := '';
  string3 SearchPhnSearchCt1Month := '';
  string3 SearchPhnSearchCt3Month := '';
  string3 SearchPhnSearchCtNew := '';
  string2 SourceTypeIndicator := '';
  string2 SourceTypeEmergence := '';
  string3 SourceTypeCredentialCt := '';
  string3 SourceTypeCredentialAgeOldest := '';
  string3 SourceTypeOtherCt := '';
  string3 SourceTypeOtherAgeOldest := '';
  string2 SourceCreditBureauCBOCt := '';
  string2 SourceCreditBureauVerSSN := '';
  string2 SourceCreditBureauVerAddr := '';
  string2 SourceCreditBureauVerDOB := '';
  string2 IDVerAddressMatchesCurrentV2 := '';
  string3 SearchSSNUnVerAddrCt := '';
  string4 SearchSSNIdentitySearchCtDiff := '';
  string3 SearchNonBankSearchCtWeek := '';
  string3 SearchNonBankSearchCtYear := '';
  string2 SearchNonBankSearchCtRecency := '';
  string3 AssocCBOIdentityCt := '';
  string3 AssocCBOHHMemberCt := '';
  string3 SourceCreditBureauFSAge := '';
  string2 SourceCreditBureauFSAge25to59 := '';
  string3 SourceCreditBureauCBOFSAge := '';
  string2 SourceCreditBureauNotSSNVer := '';
  string2 IdentitySyntheticRiskLevel := '';
  string2 IdentitySynthetic := '';
  string2 IdentityManipSSNRiskLevel := '';
  string2 IdentitySSNManip := '';
end;

Layout_version203 := record
  string3 IDVerSSNVerAgeOldest := '';
  string3 IDVerSSNNotVerAgeOldest := '';
end;

Layout_Threatmetrix := record
  string6 DIEOnBListBankFlagEv;
  string6 DIEOnBListEcomFlagEv;
  string6 DIEOnBListFinTechFlagEv;
  string6 DIEOnBListFlagEv;
  string6 DIEEIdOnBListFlagEv;
  string6 DIEEIdOnBListFlag1M;
  string6 DIPEIdOnBListFlag1M;
  string6 DIPEIdOnBListFlag1Y;
  string6 DIESmIdOnBListFlagEv;
  string6 DIESmIdOnBListFlag1M;
  string6 DIPSmIdOnBListFlag1M;
  string6 DIPSmIdOnBListFlag1Y;
  string6 DICorrPECntEv;
  string6 DICorrPECnt3M;
  string6 DICorrPECnt1Y;
  string6 DICorrPECnt1M;
  string6 DICorrFLECnt1Y;
  string6 DICorrAECnt6M;
  string6 DICorrAECntEv;
  string6 DICorrAECnt1M;
  string6 DICorrAECnt1Y;
  string6 DICorrAECnt3M;
  string6 DICorrFLECntEv;
  string6 DICorrFLECnt1M;
  string6 DICorrFLECnt3M;
  string6 DICorrFLECnt6M;
  string6 DICorrFLAPECntEv;
  string6 DICorrFLAPECnt1M;
  string6 DICorrFLAPECnt1Y;
  string6 DICorrFLAPECnt3M;
  string6 DICorrFLAPECnt6M;
  string6 DICorrPECnt6M;
  string6 DICorrFLPECntEv;
  string6 DICorrFLPECnt1M;
  string6 DICorrFLPECnt1Y;
  string6 DICorrFLPECnt3M;
  string6 DICorrFLPECnt6M;
  string6 DICorrFLPCntEv;
  string6 DICorrFLPCnt1M;
  string6 DICorrFLPCnt1Y;
  string6 DICorrFLPCnt3M;
  string6 DICorrFLPCnt6M;
  string8 DIAvTimeBtwEEvent;
  string6 DIAvTimeBtwPEvent;
  string6 DIAvDistBtwTrueIpEEvent;
  string6 DIAvDistBtwTrueIpPEvent;
  string8 DIEEventCnt6M;
  string6 DIEEventCnt1Y;
  string6 DIPEventCnt1Y;
  string6 DIPEventCntEv;
  string8 DIPEventCnt6M;
  string8 DILexIDDEventCnt1M;
  string8 DIAEventOldestDt;
  string8 DIAEventNewestDt;
  string8 DIEEventOldestDt;
  string8 DIEEventNewestDt;
  string8 DIFLEventOldestDt;
  string8 DIFLEventNewestDt;
  string8 DIPEventOldestDt;
  string8 DIPEventNewestDt;
  string6 DILexIDDEventOldestDt;
  string6 DILexIDDEventNewestDt;
  string6 DIEAliasFlag;
  string6 DIEHighRiskDomainFlag;
  string6 DIEMachineGenFlag;
  string6 DIEventEAcceptCntEv;
  string6 DIEventEAcceptCnt1M;
  string6 DIEventPAcceptCntEv;
  string6 DIEventPAcceptCnt1M;
  string6 DIEventERejectCntEv;
  string6 DIEventERejectCnt1M;
  string6 DIEventPRejectCntEv;
  string6 DIEventPRejectCnt1M;
  string6 DILexIDDFraudByCFlag1M;
  string6 DILexIDDFraudByCFlag1Y;
  string6 DILexIDDFraudByCFlag3M;
  string6 DILexIDDFraudByCFlag6M;
  string6 DIETrustByCFlag1M;
  string6 DIETrustByCFlag1Y;
  string6 DIETrustByCFlag3M;
  string6 DIETrustByCFlag6M;
  string6 DILexIDDTrustByCFlag1M;
  string6 DILexIDDTrustByCFlag1Y;
  string6 DILexIDDTrustByCFlag3M;
  string6 DILexIDDTrustByCFlag6M;
  string6 DIACHNumPerECntEv;
  string6 DIAgentPKeyHashPerECntEv;
  string6 DIBrowserPerECntEv;
  string6 DIBrowserSHashPerECntEv;
  string6 DICarrierIdPerECntEv;
  string6 DICCardPerECntEv;
  string6 DICurrencyPerECntEv;
  string6 DIDnsIpPerECntEv;
  string6 DIDnsIpGeoPerECntEv;
  string6 DIEIdPerECnt1M;
  string6 DIEIdPerECntEv;
  string6 DIEIdPerECnt3M;
  string6 DIEIdPerECnt6M;
  string6 DIEIdPerECnt1Y;
  string6 DIOrgIdPerECntEv;
  string6 DIPPerECnt1Y;
  string6 DIPPerECnt3M;
  string6 DIPPerECnt1M;
  string6 DIProxyIpPerECntEv;
  string6 DIProxyIpGeoPerECntEv;
  string6 DIScreenResPerECntEv;
  string6 DISmIdPerECnt1M;
  string6 DISmIdPerECnt3M;
  string6 DISmIdPerECntEv;
  string6 DISmIdPerECnt1Y;
  string6 DISmIdPerECnt6M;
  string6 DITimeZonePerECntEv;
  string6 DILexIDDPerECnt1M;
  string6 DILexIDDPerECntEv;
  string6 DILexIDDPerECnt1Y;
  string6 DILexIDDPerECnt3M;
  string6 DILexIDDPerECnt6M;
  string6 DITrueIpPerECntEv;
  string6 DITrueIpGeoPerECntEv;
  string6 DITrueIpRCPerECnt1W;
  string6 DIBrowserSHashPerPCntEv;
  string6 DIEPerPCnt3M;
  string6 DIEPerPCnt6M;
  string6 DIEPerPCnt1Y;
  string6 DIEPerPCntEv;
  string6 DIEPerPCnt1M;
  string6 DIEIdPerPCnt3M;
  string6 DIEIdPerPCntEv;
  string6 DIEIdPerPCnt1M;
  string6 DIEIdPerPCnt1Y;
  string6 DIEIdPerPCnt6M;
  string6 DILoginIdPerPCntEv;
  string6 DISmIdPerPCnt1M;
  string6 DISmIdPerPCnt1Y;
  string6 DISmIdPerPCntEv;
  string6 DISmIdPerPCnt3M;
  string6 DISmIdPerPCnt6M;
  string6 DILexIDDPerPCnt3M;
  string6 DILexIDDPerPCnt1Y;
  string6 DILexIDDPerPCntEv;
  string6 DILexIDDPerPCnt1M;
  string6 DILexIDDPerPCnt6M;
  string6 DITrueIpPerPCntEv;
  string6 DITrueIpRCPerPCnt1W;
  string6 DIEPerLexIDDCntEv;
  string6 DIEIdPerLexIDDCntEv;
  string6 DIEIdPerLexIDDCnt1W;
  string6 DIFLPerLexIDDCntEv;
  string6 DIPPerLexIDDCntEv;
  string6 DISmIdPerLexIDDCntEv;
  string6 DITrueIpPerLexIDDCnt1M;
  string6 DITrueIpPerLexIDDCntEv;
  string6 DITrueIpPerLexIDDCnt1W;
  string6 DITrueIpGeoPerLexIDDCnt1W;
end;
export Layout_FDAttributes := RECORD
	string20 dataset_name;
	string30 acctNo;
	string20 fname;
	string20 lname;
	string5  zip;
	string9  ssn;
	string10 hphone;
	Layout_Version1 version1;
	Layout_Version2 version2;
	Layout_IDAttributes IDAttributes;
	Layout_Version201 version201;
  Layout_Version202 version202;
  // Layout_Version203 version203;
  Layout_Threatmetrix Threatmetrix;
	riskwise.layouts.Paro_IT1O_layout ParoAttributes;
END;