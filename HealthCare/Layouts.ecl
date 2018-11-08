﻿EXPORT Layouts := MODULE
	
	EXPORT Provider	:=	RECORD
		STRING50 ProviderKey;
		STRING10 NPINumber;
		STRING12 DEANumber;
		STRING10 Taxonomy;
		STRING10 ProviderTaxID;
		STRING5  ProviderTaxIDSuffix;
		STRING12 ProviderNumber;
		STRING5  ProviderNumberSuffix;
		STRING2  ProviderNumberQualifier;
		STRING2  SecurityAuthorizationCode;
		STRING3  NetworkCode;
		STRING50 FacilityName;
		STRING12 FacilityNumber;
		STRING30 FirstName;
		STRING36 LastName;
		STRING36 AddressLine1;
		STRING36 AddressLine2;
		STRING24 City;
		STRING2  State;
		STRING9  Zip5;
		STRING30 County;
		STRING2  Country;
		STRING4  Regions;
		STRING9  SpecialityCode1;
		STRING9  SpecialityCode2;
		STRING2  ProviderType;
		STRING1  WatchCode;
		STRING8  LastUpdateDate;
		STRING50 UserDefinedField01;
		STRING50 UserDefinedField02;
		STRING50 UserDefinedField03;
		STRING50 UserDefinedField04;
		STRING50 UserDefinedField05;
		STRING50 UserDefinedField06;
		STRING50 UserDefinedField07;
		STRING50 UserDefinedField08;
		STRING50 UserDefinedField09;
		STRING50 UserDefinedField10;	
	END;
	
	EXPORT MedicalClaim := RECORD
		STRING50 TransactionKey;		
		STRING50 RenderingProviderKey;	
		STRING50 PatientKey;		
		STRING50 MedicalRecordNumber;	
		STRING38 PatientAccountNumber;	
		STRING50 PrimaryCarePhysicianKey;	
		STRING50 BillingProviderKey;	
		STRING50 ReferringProviderKey;	
		STRING50 PrimaryInsuredMemberKey;	
		STRING10 FacilityNPI;			
		STRING9  CompanyIdentificationNumber;		
		STRING2  SecurityAuthorizationCode;		
		STRING55 ClaimNumber;				
		STRING10 ClaimLineNumber;			
		STRING1  PatientStatus;				
		STRING2  ClaimStatus;			
		STRING4  ClaimType;			
		STRING1  TransactionType;			
		STRING5  AdjustmentCode;			
		STRING2  AdjustmentNumber;			
		STRING5  RejectReasonCode1;		
		STRING5  RejectReasonCode2;		
		STRING5  RejectReasonCode3;		
		STRING5  RejectReasonCode4;		
		STRING5  RejectReasonCode5;			
		STRING5  RejectReasonCode6;		
		STRING9  AuthorizationCode;		
		STRING20 AgreementID;				
		STRING12 LineOfBusiness;			
		STRING20 TypeOfPlan;				
		STRING20 BenefitPlan;			
		STRING4  TypeOfBill;		
		STRING50 CheckNumber;		
		STRING8  CheckPaidDate;		
		STRING8  CheckProcessedDate;		
		STRING22 ClaimDateAndTimeStamp;			
		STRING8  BeginningDateOfService;		
		STRING8  EndingDateOfService;			
		STRING8  ServiceDate;				
		STRING8  AdmittanceDate;			
		STRING8  DischargeDate;				
		STRING8  ClaimReceivedDate;			
		STRING8  AccidentDate;			
		STRING10 AccidentType;		
		STRING2  PlaceOfService;			
		STRING10 TypeOfService;			
		STRING15 UnitOfServiceType;		
		STRING5  UnitOfService;				
		STRING5  UnitOfServiceAllowed;			
		STRING12 CPTHCPCSProcedureCode;			
		STRING2  CPTHCPCSProcedureCodeModifier1;	
		STRING2  CPTHCPCSProcedureCodeModifier2;	
		STRING2  CPTHCPCSProcedureCodeModifier3;	
		STRING2  CPTHCPCSProcedureCodeMod;	
		STRING10 PaymentType;		
		STRING4  ReimbursementMethodType;	
		STRING4  ReimbursementMethodVersion;
		STRING10 DiagnosisRelatedGroupCode;
		STRING10 DiagnosisRelatedGroupCode2;
		STRING18 DRGPricing;		
		STRING2  OutlierCode;		
		STRING2  ICDVersionIndicator;	
		STRING10 PrincipalDiagnosisCode;	
		STRING10 AdmissionDiagnosisCode;	
		STRING10 PatientReasonForVisitDiagnosisCode;
		STRING10 DiagnosisCode1;		
		STRING10 DiagnosisCode2;		
		STRING10 DiagnosisCode3;		
		STRING10 DiagnosisCode4;		
		STRING10 DiagnosisCode5;		
		STRING10 DiagnosisCode6;		
		STRING10 DiagnosisCode7;		
		STRING10 DiagnosisCode8;		
		STRING10 DiagnosisCode9;		
		STRING10 DiagnosisCode10;		
		STRING10 DiagnosisCode11;		
		STRING10 DiagnosisCode12;		
		STRING12 PrincipalProcedureCode;	
		STRING12 ICDProcedureCode1;	
		STRING12 ICDProcedureCode2;	
		STRING12 ICDProcedureCode3;	
		STRING12 ICDProcedureCode4;	
		STRING12 ICDProcedureCode5;	
		STRING11 NDCCode1;		
		STRING6  NDCQuantity1;		
		STRING2  NDCUnitsOfMeasure1;	
		STRING11 NDCCode2;		
		STRING6  NDCQuantity2;		
		STRING2  NDCUnitsOfMeasure2;	
		STRING11 NDCCode3;		
		STRING6  NDCQuantity3;		
		STRING2  NDCUnitsOfMeasure3;	
		STRING11 NDCCode4;		
		STRING6  NDCQuantity4;		
		STRING2  NDCUnitsOfMeasure4;	
		STRING11 NDCCode5;		
		STRING6  NDCQuantity5;		
		STRING2  NDCUnitsOfMeasure5;	
		STRING11 NDCCode6;		
		STRING6  NDCQuantity6;		
		STRING2  NDCUnitsOfMeasure6;	
		STRING11 NDCCode7;		
		STRING6  NDCQuantity7;		
		STRING2  NDCUnitsOfMeasure7;	
		STRING11 NDCCode8;		
		STRING6  NDCQuantity8;		
		STRING2  NDCUnitsOfMeasure8;	
		STRING11 NDCCode9;		
		STRING6  NDCQuantity9;		
		STRING2  NDCUnitsOfMeasure9;	
		STRING11 NDCCode10;		
		STRING6  NDCQuantity10;			
		STRING2  NDCUnitsOfMeasure10;			
		STRING10 RevenueCode;				
		STRING50 PayeeCode;				
		STRING1  NetworkIndicator;			
		STRING1  ProviderMedicareParticipation;		
		STRING1  MaxOutOfPocketMetIndividualInd;	
		STRING1  MaxOutOfPocketMetFamilyInd;		
		STRING1  DeductibleMetIndividualInd;		
		STRING1  DeductibleMetFamilyInd;		
		STRING1  PriceIndicator;			
		STRING18 ChargeAmount;				
		STRING18 ReasonableAndCustomaryAmount;		
		STRING18 DeductibleAmount;			
		STRING18 PaidAmount;			
		STRING18 CoPayAmount;			
		STRING18 CoOrdinationOfBenefits;		
		STRING18 CoInsuranceAmount;			
		STRING50 UserDefinedField01;
		STRING50 UserDefinedField02;
		STRING50 UserDefinedField03;
		STRING50 UserDefinedField04;
		STRING50 UserDefinedField05;
		STRING50 UserDefinedField06;
		STRING50 UserDefinedField07;
		STRING50 UserDefinedField08;
		STRING50 UserDefinedField09;
		STRING50 UserDefinedField10;
	END; 

	EXPORT Scoring_Input := RECORD
		UNSIGNED8 LNPID;
		UNSIGNED8 LNFID;
		STRING50  ProviderKey;
		STRING10  ClientNPINumber;
		STRING12  ClientDEANumber;
		STRING10  ClientTaxonomy;
		STRING10  ClientProviderTaxID;
		STRING2   ProviderType;
		STRING1		ADVODoNotDeliver;
		STRING8		ADVOVacantIndicator;
		STRING1		ADVODropIndicator; //Mail drop 'C' and 'Y'
		STRING1		ADVORecordTypeCode;
		STRING1		ADVOAddressType;
		STRING1		ADVOResidentialOrBusinessIndicator;
		BOOLEAN		ACAHitFound;
		STRING60	ClientLicenseStatus;
		STRING8		ClientLicenseExpiredDate;
		STRING8		ClientLicenseInactiveDate;
		UNSIGNED4	HeaderLicenseCount;
		UNSIGNED4	HeaderLicenseStateCount;
		UNSIGNED4	HeaderActiveLicenseCount;
		UNSIGNED4	HeaderInactiveLicenseCount;
		UNSIGNED4	HeaderRevokedLicenseCount;
		BOOLEAN		hasStateSanction;
		BOOLEAN		hasOIGSanction;
		BOOLEAN		hasOPMSanction;
		STRING8		SanctionDate;
		BOOLEAN		hasDeceased;
		STRING8		DateofDeath;
		STRING1		ClientDeaExpiredFlag;
		UNSIGNED4	HeaderDeaCount;
		UNSIGNED4	HeaderActiveDeaCount;
		UNSIGNED4	HeaderExpiredDeaCount;
		STRING1		ClientNPIStatus;
		STRING8		ClientNPIDeactivationDate;
		STRING1		HeaderNPIStatus;
		STRING8		HeaderNPIDeactivationDate;
		BOOLEAN		hasBankruptcy;
		STRING8		BankruptcyDate;
		BOOLEAN		isSexOffender;
		BOOLEAN		isCriminal;
	END;
	
	EXPORT ClaimAnalysisInput := RECORD
		UNSIGNED8  LNPID;
		UNSIGNED8  LNFID;
		UNSIGNED8  LEXID;
		STRING50 	 ProviderKey;
		STRING20   FirstName;
		STRING20   MiddleName;
		STRING20   LastName;
		STRING5    NameSuffix;
		STRING10   PrimaryRange;
		STRING2    PreDirectional;
		STRING28   PrimaryName;
		STRING4	   AddressSuffix;
		STRING2	   PostDirectional;
		STRING8	   SecondaryRange;
		STRING25   CityNameVanity;
		STRING2    State;
		STRING5    Zip5;
		STRING4		 AddressErrorCode; 
		STRING10   ClientNPINumber;
		STRING12   ClientDEANumber;
		STRING10   ClientTaxonomy;
		STRING1    ProviderType;
		STRING1    DoNotDeliver;
		STRING1    VacantIndicator;
		STRING1    DropIndicator;
		STRING1    RecordTypeCode;
		STRING1    AddressType;
		STRING1    ResidentialOrBusinessIndicator;
		BOOLEAN    PrisonIndicator;
		STRING60   ClientLicenseStatus;
		STRING8    DateClientLicenseExpired;
		STRING8    DateClientLicenseInactive;
		UNSIGNED4  ProviderLicenseCount;
		UNSIGNED4  ProviderLicenseStateCount;
		UNSIGNED4  ProvderActiveLicenseCount;
		UNSIGNED4  ProviderInactiveLicenseCount;
		UNSIGNED4  ProviderRevokedLicenseCount;
		BOOLEAN    HasStateSanction;
		BOOLEAN    HasOIGSanction;
		BOOLEAN    HasOPMSanction;
		STRING8    SanctionDate;
		BOOLEAN    HasDeceased;
		STRING8    DateofDeath;
		STRING10	 ProviderNPINumber;
		STRING1    ClientDEAExpiredFlag;
		STRING10	 ProviderDeaNumber;
		UNSIGNED4	 ProviderDateDEAExpired;
		UNSIGNED4  ProviderDEACount;
		UNSIGNED4  ProviderActiveDEACount;
		UNSIGNED4  ProviderExpiredDEACount;
		STRING1    ClientNPIStatus;
		STRING8    ClientNPIDeactivationDate;
		STRING1    ProviderNPIStatus;
		STRING8    ProviderNPIDeactivationDate;
		BOOLEAN    HasBackruptcy;
		STRING8    BankruptcyDate;
		BOOLEAN    isSexOffender;
		BOOLEAN    isCriminal;
		STRING50   TransactionKey;
		STRING50   RenderingProviderKey;
		STRING50   PatientKey;
		STRING50   MedicalRecordNumber;
		STRING38   PatientAccountNumber;
		STRING50   PrimaryCarePhysicianKey;
		STRING50   BillingProviderKey;
		STRING50   ReferringProviderKey;
		STRING50   PrimaryInsuredMemberKey;
		STRING10   FacilityNPI;
		STRING9    CompanyIdentificationNumber;
		STRING2    SecurityAuthorizationCode;
		STRING55   ClaimNumber;
		STRING10   ClaimLineNumber;
		STRING1    PatientStatus;
		STRING2    ClaimStatus;
		STRING4    ClaimType;
		STRING1    TransactionType;
		STRING5    AdjustmentCode;
		STRING2    AdjustmentNumber;
		STRING5    RejectReasonCode1;
		STRING5    RejectReasonCode2;
		STRING5    RejectReasonCode3;
		STRING5    RejectReasonCode4;
		STRING5    RejectReasonCode5;
		STRING5    RejectReasonCode6;
		STRING9    AuthorizationCode;
		STRING20   AgreementID;
		STRING12   LineOfBusiness;
		STRING20   TypeOfPlan;
		STRING20   BenefitPlan;
		STRING4    TypeOfBill;
		STRING50   CheckNumber;
		STRING8    CheckPaidDate;
		STRING8    CheckProcessedDate;
		STRING22   ClaimDateAndTimeStamp;
		STRING8    BeginningDateOfService;
		STRING8    EndingDateOfService;
		STRING8    ServiceDate;
		STRING8    AdmittanceDate;
		STRING8    DischargeDate;
		STRING8    ClaimReceivedDate;
		STRING8    AccidentDate;
		STRING10   AccidentType;
		STRING2    PlaceOfService;
		STRING10   TypeOfService;
		STRING15   UnitOfServiceType;
		STRING5    UnitOfService;
		STRING5    UnitOfServiceAllowed;
		STRING12   CPTHCPCSProcedureCode;
		STRING2    CPTHCPCSProcedureCodeModifier1;
		STRING2    CPTHCPCSProcedureCodeModifier2;
		STRING2    CPTHCPCSProcedureCodeModifier3;
		STRING2    CPTHCPCSProcedureCodeModifier4;
		STRING10   PaymentType;
		STRING4    ReimbursementMethodType;
		STRING4    ReimbursementMethodVersion;
		STRING10   DiagnosisRelatedGroupCode;
		STRING10   DiagnosisRelatedGroupCode2;
		STRING18   DRGPricing;
		STRING2    OutlierCode;
		STRING2    ICDVersionIndicator;
		STRING10   PrincipalDiagnosisCode;
		STRING10   AdmissionDiagnosisCode;
		STRING10   PatientReasonForVisitDiagnosisCode;
		STRING10   DiagnosisCode1;
		STRING10   DiagnosisCode2;
		STRING10   DiagnosisCode3;
		STRING10   DiagnosisCode4;
		STRING10   DiagnosisCode5;
		STRING10   DiagnosisCode6;
		STRING10   DiagnosisCode7;
		STRING10   DiagnosisCode8;
		STRING10   DiagnosisCode9;
		STRING10   DiagnosisCode10;
		STRING10   DiagnosisCode11;
		STRING10   DiagnosisCode12;
		STRING12   PrincipalProcedureCode;
		STRING12   ICDProcedureCode1;
		STRING12   ICDProcedureCode2;
		STRING12   ICDProcedureCode3;
		STRING12   ICDProcedureCode4;
		STRING12   ICDProcedureCode5;
		STRING11   NDCCode1;
		STRING6    NDCQuantity1;
		STRING2    NDCUnitsOfMeasure1;
		STRING11   NDCCode2;
		STRING6    NDCQuantity2;
		STRING2    NDCUnitsOfMeasure2;
		STRING11   NDCCode3;
		STRING6    NDCQuantity3;
		STRING2    NDCUnitsOfMeasure3;
		STRING11   NDCCode4;
		STRING6    NDCQuantity4;
		STRING2    NDCUnitsOfMeasure4;
		STRING11   NDCCode5;
		STRING6    NDCQuantity5;
		STRING2    NDCUnitsOfMeasure5;
		STRING11   NDCCode6;
		STRING6    NDCQuantity6;
		STRING2    NDCUnitsOfMeasure6;
		STRING11   NDCCode7;
		STRING6    NDCQuantity7;
		STRING2    NDCUnitsOfMeasure7;
		STRING11   NDCCode8;
		STRING6    NDCQuantity8;
		STRING2    NDCUnitsOfMeasure8;
		STRING11   NDCCode9;
		STRING6    NDCQuantity9;
		STRING2    NDCUnitsOfMeasure9;
		STRING11   NDCCode10;
		STRING6    NDCQuantity10;
		STRING2    NDCUnitsOfMeasure10;
		STRING10   RevenueCode;
		STRING50   PayeeCode;
		STRING1    NetworkIndicator;
		STRING1    ProviderMedicareParticipation;
		STRING1    MaxOutOfPocketMetIndividualInd;
		STRING1    MaxOutOfPocketMetFamilyInd;
		STRING1    DeductibleMetIndividualInd;
		STRING1    DeductibleMetFamilyInd;
		STRING1    PriceIndicator;
		STRING18   ChargeAmount;
		STRING18   ReasonableAndCustomaryAmount;
		STRING18   DeductibleAmount;
		STRING18   PaidAmount;
		STRING18   CoPayAmount;
		STRING18   CoOrdinationOfBenefits;
		STRING18   CoInsuranceAmount;
		STRING50   UserDefinedField01;
		STRING50   UserDefinedField02;
		STRING50   UserDefinedField03;
		STRING50   UserDefinedField04;
		STRING50   UserDefinedField05;
		STRING50   UserDefinedField06;
		STRING50   UserDefinedField07;
		STRING50   UserDefinedField08;
		STRING50   UserDefinedField09;
		STRING50   UserDefinedField10;
	END;
	
	EXPORT Medical_Claim := RECORD
		STRING50 	ProviderKey;
		UNSIGNED8 TotalClaimCount;
		UNSIGNED8 TotalPatientCount;
		UNSIGNED8 TotalClaimsPended;
		UNSIGNED8	TotalClaimsDenied;
		UNSIGNED8 TotalChargeAmount;
		UNSIGNED8 TotalPaidAmount;
		UNSIGNED8 ClaimCountAfterDeaceased;	
		UNSIGNED8 TotalChargeAmountAfterDeaceased;
		UNSIGNED8 TotalPaidAmountAfterDeaceased;
		UNSIGNED8 ClaimCountAfterNPIDeactivated;		
		UNSIGNED8 TotalChargeAmountAfterNPIDeactivated;
		UNSIGNED8 TotalPaidAmountAfterNPIDeactivated;
		UNSIGNED8 ClaimCountAfterDEAExpired;
		UNSIGNED8 TotalChargeAmountAfterDEAExpired;
		UNSIGNED8 TotalPaidAmountAfterDEAExpired;
		UNSIGNED8 ClaimCountAfterLicenseExpired;		
		UNSIGNED8 TotalChargeAmountAfterLicenseExpired;
		UNSIGNED8 TotalPaidAmountAfterLicenseExpired;
		UNSIGNED8 ClaimCountAfterBankruptcy;		
		UNSIGNED8 TotalChargeAmountAfterBankruptcy;
		UNSIGNED8 TotalPaidAmountAfterBankruptcy;
		UNSIGNED8 DistinctProcedureCodeCount;	
		UNSIGNED8 DistinctModCodeCount;		
		UNSIGNED8 DistinctRevenueCodeCount;	
		UNSIGNED8 DistinctDrugCodeCount;	
		UNSIGNED8 DistinctDiagCodeCount;	
		UNSIGNED8 DistinctPatientCodeCount;	
		UNSIGNED8 PatientAveragePaidAmount;
	END;

	EXPORT ScoringAnalysisInput := RECORD
		UNSIGNED8  LNPID;
		UNSIGNED8  LNFID;
		UNSIGNED8  LEXID;
		STRING50 	 ProviderKey;
		STRING20   FirstName;
		STRING20   MiddleName;
		STRING20   LastName;
		STRING5    NameSuffix;
		STRING120	 FacilityName;
		STRING10   PrimaryRange;
		STRING2    PreDirectional;
		STRING28   PrimaryName;
		STRING4	   AddressSuffix;
		STRING2	   PostDirectional;
		STRING8	   SecondaryRange;
		STRING25   CityNameVanity;
		STRING2    State;
		STRING5    Zip5;
		STRING4		 AddressErrorCode;
		STRING10   ClientNPINumber;
		STRING12   ClientDEANumber;
		STRING10   ClientTaxonomy;
		STRING1    ProviderType;
		BOOLEAN		 AdvoHit;
		STRING1    VacantIndicator;
		STRING1		 SeasonalDeliveryIndicator;
		STRING1    DoNotDeliver;
		STRING1		 CollegeIndicator;
		STRING1    DropIndicator;
		STRING1    ResidentialOrBusinessIndicator;		
		STRING1    AddressType;		
		STRING1    RecordTypeCode;
		STRING8		 VacationBeginDate;
		STRING8		 AddressFirstSeenDate;
		STRING8		 AddressLastSeeDate;
		BOOLEAN    PrisonIndicator;
		STRING60   ClientLicenseStatus;
		STRING8    DateClientLicenseExpired;
		STRING8    DateClientLicenseInactive;
		UNSIGNED4  ProviderLicenseCount;
		UNSIGNED4  ProviderLicenseStateCount;
		UNSIGNED4  ProvderActiveLicenseCount;
		UNSIGNED4  ProviderInactiveLicenseCount;
		UNSIGNED4  ProviderRevokedLicenseCount;
		BOOLEAN    HasStateSanction;
		BOOLEAN    HasOIGSanction;
		BOOLEAN    HasOPMSanction;
		STRING50	 Category;
		STRING100	 LegacyType;
		STRING8    SanctionDate;
		BOOLEAN    HasDeceased;
		STRING8    DateofDeath;
		STRING10	 ProviderNPINumber;
		STRING1    ClientDEAExpiredFlag;
		STRING10	 ProviderDeaNumber;
		UNSIGNED4	 ProviderDateDEAExpired;
		UNSIGNED4  ProviderDEACount;
		UNSIGNED4  ProviderActiveDEACount;
		UNSIGNED4  ProviderExpiredDEACount;
		STRING1    ClientNPIStatus;
		STRING8    ClientNPIDeactivationDate;
		STRING1    ProviderNPIStatus;
		STRING8    ProviderNPIDeactivationDate;
		BOOLEAN    HasBackruptcy;
		STRING8    BankruptcyDate;
		BOOLEAN    isSexOffender;
		BOOLEAN    isCriminal;
		UNSIGNED8 TotalClaimCount;
		UNSIGNED8 TotalPatientCount;
		UNSIGNED8 TotalClaimsPended;
		UNSIGNED8	TotalClaimsDenied;
		UNSIGNED8 TotalChargeAmount;
		UNSIGNED8 TotalPaidAmount;
		UNSIGNED8 ClaimCountAfterDeaceased;	
		UNSIGNED8 TotalChargeAmountAfterDeaceased;
		UNSIGNED8 TotalPaidAmountAfterDeaceased;
		UNSIGNED8 ClaimCountAfterNPIDeactivated;		
		UNSIGNED8 TotalChargeAmountAfterNPIDeactivated;
		UNSIGNED8 TotalPaidAmountAfterNPIDeactivated;
		UNSIGNED8 ClaimCountAfterDEAExpired;
		UNSIGNED8 TotalChargeAmountAfterDEAExpired;
		UNSIGNED8 TotalPaidAmountAfterDEAExpired;
		UNSIGNED8 ClaimCountAfterLicenseExpired;		
		UNSIGNED8 TotalChargeAmountAfterLicenseExpired;
		UNSIGNED8 TotalPaidAmountAfterLicenseExpired;
		UNSIGNED8 ClaimCountAfterBankruptcy;		
		UNSIGNED8 TotalChargeAmountAfterBankruptcy;
		UNSIGNED8 TotalPaidAmountAfterBankruptcy;
		UNSIGNED8 DistinctProcedureCodeCount;	
		UNSIGNED8 DistinctModCodeCount;		
		UNSIGNED8 DistinctRevenueCodeCount;	
		UNSIGNED8 DistinctDrugCodeCount;	
		UNSIGNED8 DistinctDiagCodeCount;	
		UNSIGNED8 DistinctPatientCodeCount;	
		UNSIGNED8 PatientAveragePaidAmount;
	END;
	
	EXPORT ScoringAnalysisInputWOutlier := RECORD
		ScoringAnalysisInput;
		STRING1 HighNumberOfPatientsFlag;
		UNSIGNED4 HighNumberOfPatientsRank;
		REAL4 HighNumberOfPatientsMedian;
		REAL4 HighNumberOfPatientsOuterFence;
		STRING1 HighNumberOfClaimsFlag;
		UNSIGNED4 HighNumberOfClaimsRank;
		REAL4 HighNumberOfClaimsMedian;
		REAL4 HighNumberOfClaimsOuterFence;
		STRING1 HighNumberOfClaimsPerPatientFlag;
		UNSIGNED4 HighNumberOfClaimsPerPatientRank;
		REAL4 HighNumberOfClaimsPerPatientMedian;
		REAL4 HighNumberOfClaimsPerPatientOuterFence;
		STRING1 HighPaidDollarsFlag;
		UNSIGNED4 HighPaidDollarsRank;
		REAL4 HighPaidDollarsMedian;
		REAL4 HighPaidDollarsOuterFence;
		STRING1 HighPaidDollarsPerClaimFlag;
		UNSIGNED4 HighPaidDollarsPerClaimRank;
		REAL4 HighPaidDollarsPerClaimMedian;
		REAL4 HighPaidDollarsPerClaimOuterFence;
		STRING1 HighPaidDollarsPerPatientFlag;
		UNSIGNED4 HighPaidDollarsPerPatientRank;
		REAL4 HighPaidDollarsPerPatientMedian;
		REAL4 HighPaidDollarsPerPatientOuterFence;
		STRING1 LongPatientDrivingDistanceFlag;
		UNSIGNED4 LongPatientDrivingDistanceRank;
		REAL4 LongPatientDrivingDistanceMedian;
		REAL4 LongPatientDrivingDistanceOuterFence;
	END;
	
	EXPORT ScoringInput := RECORD
		ScoringAnalysisInputWOutlier;
		STRING1 FacilitiesOutlierFlag;
		UNSIGNED4 FacilitiesOutlierRank;
		REAL4 FacilitiesOutlierMedian;
		REAL4 FacilitiesOutlierFence;
		REAL8 PropertySquareFootage;
		UNSIGNED4 TotalNPICount;
		UNSIGNED4 RecentNPICount;
		UNSIGNED4 StudentNPICount;
		STRING8 NPI_Enumeration_Date;
		UNSIGNED4 Number_of_Suspect_Providers_At_Address;
		UNSIGNED4	Number_of_Providers_At_Single_Address;
		STRING1 Provider_With_Single_Address;
	END;
	
	EXPORT Speciality_Taxonomy_Rec := RECORD
		STRING2     SPECIALITY_CODE;
		STRING50    SPECIALITY_DESC;
		STRING10    TAXONOMY_CODE;
		STRING100   TAXONOMY_DESC;
	END;

	EXPORT Spec_Cd_Rec := RECORD
		STRING9 Speciality_Code;
		STRING50 Speciality_Desc;
	END;
	
	EXPORT NPI_REC := RECORD
		STRING10		NPI_NUMBER;
		STRING10		TAXONOMY;
		STRING8			ENUMERATION_DATE;
		STRING8			LAST_UPDATE_DATE;
		STRING8			NPI_DEACTIVATION_DATE;
		STRING1			ENTITY_TYPE;
		STRING5			TITLE;
		STRING20		FNAME;
		STRING20		MNAME;
		STRING28		LNAME; 
		STRING5			SNAME;
		STRING120 	CNAME;
		STRING10    PRIM_RANGE;
		STRING2     PREDIR;
		STRING28    PRIM_NAME;
		STRING4     ADDR_SUFFIX;
		STRING2     POSTDIR;
		STRING10    UNIT_DESIG;
		STRING8     SEC_RANGE;
		STRING25    V_CITY_NAME;
		STRING2     ST;
		STRING5     ZIP;
	END;
	
	EXPORT TIN_NPI_REC := RECORD
		unsigned8 lnpid;
		unsigned8 lnfid;
		string50 provider_key;
		string1 provider_type;
		string50 provider_facility_name;
		string30 provider_first_name;
		string36 provider_last_name;
		string10 primaryrange;
		string2 predirectional;
		string28 primaryname;
		string4 addresssuffix;
		string2 postdirectional;
		string10 unitdesignation;
		string8 secondaryrange;
		string25 cityname_vanity;
		string2 state;
		string5 zip5;
		string4 zip4;
		string38 group_key;
		string11 prac_addr_confidence_score;
		string11 bill_addr_confidence_score;
		string38 sloc_group_key;
		string38 billing_group_key;
		string10 npi;
		string10 bill_npi;
		string8 npi_enumeration_date;
		string8 bill_npi_enumeration_date;
		string10 npi_taxonomy;
		string10 bill_npi_taxonomy;
		string50 bill_tin;
		string8 cam_earliest;
	END;
	
	EXPORT Hospital_Exclusion_Rec := RECORD
		string120 cnp_name;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string8 sec_range;
		string25 v_city_name;
		string2 st;
		string5 zip;
		boolean isHospital;
	END;
	
	EXPORT LNPID_TO_LNPID_REC := RECORD
  string38 person_group_key;
  string38 assoc_group_key;
  unsigned8 person_lnpid;
  unsigned8 assoc_lnpid;
  unsigned8 person_lexid;
  unsigned8 assoc_lexid;
  string20 relationship;
  unsigned4 assoc_count;
  unsigned4 bad_assoc_count;
  integer4 caf_addr_rank;
  string20 addr_key;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string50 person_name;
  string50 assoc_name;
  string1 hasactiveexclusion;
  string1 hasactiverevocation;
  string1 hasreinstatedexclusion;
  string1 hasreinstatedrevocation;
  string1 hasbackruptcy;
  string1 hascriminalhistory;
  string1 hasrelativeconvictions;
  string1 hasrelativebankruptcy;
  string1 hasdeceased;
  integer2 score;
 END;

 EXPORT Provider_REC := RECORD
                        STRING50    PROVIDER_KEY;
                        STRING10    PROVIDER_NPI;
                        STRING12    PROVIDER_DEA;
                        STRING10    PROVIDER_TAXONOMY;
                        STRING10    PROVIDER_TAX_ID;
                        STRING5     PROVIDER_TAX_ID_SUFFIX;
                        STRING12    PROVIDER_NUM;
                        STRING5     PROVIDER_NUM_SUFFIX;
                        STRING2     PROVIDER_NUM_QUALIFIER;
                        STRING2     PROVIDER_SECURITY_CODE;
                        STRING3     NETWORK_CODE;
                        STRING50    PROVIDER_FACILITY_NAME;
                        STRING12    PROVIDER_FACILITY_NUM;
                        STRING30    PROVIDER_FIRST_NAME;
                        STRING36    PROVIDER_LAST_NAME;
                        STRING36    PROVIDER_ADDRESS_1;
                        STRING36    PROVIDER_ADDRESS_2;
                        STRING24    PROVIDER_CITY;
                        STRING2     PROVIDER_STATE;
                        STRING9     PROVIDER_ZIP_CD;
                        STRING30    PROVIDER_COUNTY;
                        STRING2    PROVIDER_COUNTRY;
                        STRING4    PROVIDER_REGION;
                        STRING9    PROV_SPECIALTY_CD_1;
                        STRING9    PROV_SPECIALTY_CD_2;
                        STRING2    PROVIDER_TYPE;
                        STRING1    WATCH_CD;
                        STRING8    PROVIDER_LATEST_UPDATE_DATE;
                        STRING50    PROV_USER_DEF_01;
                        STRING50    PROV_USER_DEF_02;
                        STRING50    PROV_USER_DEF_03;
                        STRING50    PROV_USER_DEF_04;
                        STRING50    PROV_USER_DEF_05;
                        STRING50    PROV_USER_DEF_06;
                        STRING50    PROV_USER_DEF_07;
                        STRING50    PROV_USER_DEF_08;
                        STRING50    PROV_USER_DEF_09;
                        STRING50    PROV_USER_DEF_10;
	 END;
 
	EXPORT Provider_REC_NEW := RECORD(PROVIDER_REC)
		STRING8 ProviderDOB;
		STRING9 ProviderSSN;
	 END;	 
END;