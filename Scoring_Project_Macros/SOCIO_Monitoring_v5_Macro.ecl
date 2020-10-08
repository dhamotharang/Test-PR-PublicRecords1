EXPORT SOCIO_Monitoring_v5_Macro (roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,SOCIO_Monitoring_v5_infile,SOCIO_Monitoring_v5_outfile,no_of_recs_to_run):= FUNCTIONMACRO
                                  
IMPORT risk_indicators,std, ProfileBooster, ut, RiskWise;
IMPORT Models;

Layout_SocioEconomic_Batch_In := RECORD 
                UNSIGNED4 seq;
                STRING30  acctno;
                STRING9   ssn;
                STRING120 unparsedfullname := ' ';
                STRING30  name_first;
                STRING30  name_middle;
                STRING30  name_last;
                STRING5   name_suffix;
                STRING8   dob;
                STRING65  street_addr := ' ';
                STRING25  p_city_name;
                STRING2   st;
                STRING5   z5;
                STRING20  dl_number;
                STRING2   dl_state;
                STRING10  home_phone;
                STRING10  work_phone;
                STRING1   membergender := ' ';
                UNSIGNED6 did := 0;
                STRING8   admit_date;
                STRING8   admit_diagnosis_code;
                STRING2   financial_class;
                STRING1   patient_type;
                UNSIGNED3 historydateyyyymm := 999999;
                
END;

//inputFile := '~vidyapatil::sociodevtesting::inputdatasampleMA.csv';//Your Input Filename here
//inputFile := '~scoringqa::in::socio_v5';

//no_of_records := 0;    //choose 0 to run all records

//inputDataset := IF(no_of_records <= 0,
//DATASET(inputFile, Layout_SocioEconomic_Batch_In, CSV(HEADING(1),SEPARATOR([',']),TERMINATOR(['\n', '\r\n', '\n\r']))),
//CHOOSEN(DATASET(inputFile, Layout_SocioEconomic_Batch_In, CSV(HEADING(1),SEPARATOR([',']),TERMINATOR(['\n', '\r\n', '\n\r']))), no_of_records));


inputDataset := DISTRIBUTE(IF(no_of_recs_to_run <= 0,
DATASET(SOCIO_Monitoring_v5_infile, Layout_SocioEconomic_Batch_In, THOR),
CHOOSEN(DATASET(SOCIO_Monitoring_v5_infile, Layout_SocioEconomic_Batch_In, THOR), no_of_recs_to_run)),(integer)acctno);


//Number of parallel calls to run in the SOAPCALL to the Roxie Query 
threads := no_of_threads;

//Roxie the ECL Query is located on 
//roxieIP := RiskWise.Shortcuts.Dev194; //Hitting the DEV
//roxieIP := 'http://10.173.235.23:8130/';
//roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;    //Hitting the 128/130 Vip  
//roxieIP := 'http://10.173.128.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';    //Hitting 128 Roxie
//roxieIP := 'http://10.173.130.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';    //Hitting 130 Roxie
//roxieIP := riskwise.shortcuts.prod_batch_neutral;   //Hitting the prod 
//roxieIP := RiskWise.Shortcuts.Dev192; //Hitting the DEV
//roxieIP := 'http://dev156vip.hpcc.risk.regn.net:9876';  // dev roxie 156
//roxieIP := 'http://10.173.101.101:9876'; //cert 101


//string attributesonly_in := 'N';
//string historydateyyyymm_in := '999999'; //Your History date input here
default_DPPA := 0;
default_GLBA := 6;
default_DataRestriction := '000000000000010000000000000000'; 
default_DataPermission := '000000000000000000000000000000'; 
options_in := '7MO'; // report output options can be changed here (ex: 1MO, 2MO, 7MO, 8MO) 7mo is super-set

Socio_input_batch := record 
   dataset(Layout_SocioEconomic_Batch_In) batch_in;
   //string attributesonly := 'N';
   string50 datarestrictionmask;
   string50 datapermissionmask;
   unsigned1 DPPAPurpose;
   unsigned1 GLBPurpose;
   string options;
 //unsigned3 historydateyyyymm;
END;


soap_in := project(inputDataset, TRANSFORM(Socio_input_batch,
   SELF.batch_in := LEFT;
   SELF.datarestrictionmask := (string50)default_DataRestriction;
   SELF.datapermissionmask := (string50)default_DataPermission;
   SELF.DPPAPurpose := (unsigned1)default_DPPA;
   SELF.GLBPurpose := (unsigned1)default_GLBA;
   SELF.options := (string) options_in;
   self := left;
));



xlayout := RECORD
string10 seq;
string10 acctno;
string12 lexid;
string3 AccidentAge;
string3 AccidentCount;
string3 AddrChangeCount01;
string3 AddrChangeCount03;
string3 AddrChangeCount06;
string3 AddrChangeCount12;
string3 AddrChangeCount60;
string1 AddrStability;
String2 LifeEvEconTrajectory;
String2 LifeEvEconTrajectoryIndex;
String3 LifeEvEverResidedCnt;
String5 LifeEvLastMoveTaxRatioDiff;
string2 StatusMostRecent;
string2 StatusNextPrevious;
string2 StatusPrevious;
string3 AircraftCount;
string3 AircraftCount12;
string3 AircraftCount60;
string1 AircraftOwner;
string1 AssetOwner;
String3 HHPPCurrOwnedCnt;
String3 HHPPCurrOwnedWtrcrftCnt;
String7 HHPropCurrAVMHighest;
String3 HHPropCurrOwnedCnt;
String3 HHPropCurrOwnerMmbrCnt;
String3 LifeEvTimeFirstAssetPurchase;
String3 LifeEvTimeLastAssetPurchase;
String3 PPCurrOwnedCnt;
String2 PPCurrOwner;
string3 PropAgeNewestPurchase;
string3 PropAgeNewestSale;
string3 PropAgeOldestPurchase;
String7 PropCurrOwnedAVMTtl;
string1 PropertyOwner;
String3 PropEverOwnedCnt;
string10 PropNewestSalePrice;
string4 PropNewestSalePurchaseIndex;
string3 PropOwnedCount;
string3 PropOwnedHistoricalCount;
string10 PropOwnedTaxTotal;
string10 PropOwnedTaxTotal_12;
string10 PropOwnedTaxTotal_24;
string3 PropPurchasedCount12;
string3 PropPurchasedCount24;
string3 PropPurchasedCount60;
string3 PropSoldCount12;
string3 PropSoldCount60;
String3 RaAPPCurrOwnerAircrftMmbrCnt;
String3 RaAPPCurrOwnerMmbrCnt;
String3 RaAPPCurrOwnerWtrcrftMmbrCnt;
String3 RaAPropCurrOwnerMmbrCnt;
String7 RaAPropOwnerAVMHighest;
String7 RaAPropOwnerAVMMed;
string3 RelativesPropOwnedCount;
string10 RelativesPropOwnedTaxTotal;
string3 WatercraftCount;
string3 WatercraftCount12;
string3 WatercraftCount24;
string3 WatercraftCount60;
string1 WatercraftOwner;
string2 WealthIndex;
string3 CurrAddrAgeLastSale;
string3 CurrAddrAgeNewestRecord;
string3 CurrAddrAgeOldestRecord;
string2 CurrAddrApplicantOwned;
string10 CurrAddrAVMValue;
string10 CurrAddrAVMValue12;
string10 CurrAddrAVMValue60;
string5 CurrAddrBlockIndex;
string3 CurrAddrBurglaryIndex;
string3 CurrAddrBurglaryIndex_12;
string3 CurrAddrBurglaryIndex_24;
string3 CurrAddrCarTheftIndex;
string5 CurrAddrCountyIndex;
string3 CurrAddrCrimeIndex;
string2 CurrAddrDwellType;
string2 CurrAddrFamilyOwned;
string10 CurrAddrLastSalesPrice;
string3 CurrAddrLenOfRes;
string10 CurrAddrMedianIncome;
string10 CurrAddrMedianValue;
string2 CurrAddrMortgageType;
string3 CurrAddrMurderIndex;
string2 CurrAddrOccupantOwned;
string10 CurrAddrTaxMarketValue;
string10 CurrAddrTaxValue;
string4 CurrAddrTaxYr;
string5 CurrAddrTractIndex;
String5 ResCurrAVMRatioDiff12Mo;
String5 ResCurrAVMRatioDiff60Mo;
String3 ResCurrBusinessCnt;
String7 ResCurrMortgageAmount;
String2 ResCurrOwnershipIndex;
string16 Age_in_Years;
string2 Female;
String3 HHCnt;
String3 HHElderlyMmbrCnt;
String3 HHMiddleAgemmbrCnt;
String3 HHSeniorMmbrCnt;
String3 HHTeenagerMmbrCnt;
String3 HHYoungAdultMmbrCnt;
String2 ProspectMaritalStatus;
String3 RaAElderlyMmbrCnt;
String3 RaAHHCnt;
String3 RaAMiddleAgeMmbrCnt;
String3 RaAMmbrCnt;
String3 RaASeniorMmbrCnt;
String3 RaATeenageMmbrCnt;
String3 RaAYoungAdultMmbrCnt;
string3 RelativesCount;
string2 RelativesDistanceClosest;
string10 ST;
String3 CrtRecCnt;
String2 CrtRecSeverityIndex;
string3 DerogAge;
string3 DerogCount;
string3 DerogRecentCount;
string2 DerogSeverityIndex;
String3 HHCrtRecMmbrCnt;
String3 HHCrtRecMmbrCnt12Mo;
String3 RaACrtRecMmbrCnt;
String3 RaACrtRecMmbrCnt12Mo;
string3 ArrestAge;
string3 ArrestCount;
string3 ArrestCount12;
string3 ArrestCount60;
String3 CrtRecMsdmeanCnt;
String3 CrtRecMsdmeanCnt12Mo;
String3 CrtRecMsdmeanTimeNewest;
string3 FelonyAge;
string3 FelonyCount;
string3 FelonyCount12;
string3 FelonyCount60;
String3 HHCrtRecFelonyMmbrCnt;
String3 HHCrtRecFelonyMmbrCnt12Mo;
String3 HHCrtRecMsdmeanMmbrCnt;
String3 HHCrtRecMsdmeanMmbrCnt12Mo;
string2 HistoricalAddrCorrectional;
String3 RaACrtRecFelonyMmbrCnt;
String3 RaACrtRecFelonyMmbrCnt12Mo;
String3 RaACrtRecMsdmeanMmbrCnt;
String3 RaACrtRecMsdmeanMmbrCnt12Mo;
string3 RelativesFelonyCount;
string3 BankruptcyAge;
string3 BankruptcyCount;
string3 BankruptcyCount12;
string3 BankruptcyCount60;
string35 BankruptcyStatus;
string2 BankruptcyType;
String3 CrtRecLienJudgTimeNewest;
string3 EvictionAge;
string3 EvictionCount;
string3 EvictionCount12;
string3 EvictionCount60;
String3 HHCrtRecBkrptMmbrCnt;
String3 HHCrtRecBkrptMmbrCnt12Mo;
String3 HHCrtRecBkrptMmbrCnt24Mo;
String3 HHCrtRecEvictionMmbrCnt;
String3 HHCrtRecEvictionMmbrCnt12Mo;
String7 HHCrtRecLienJudgAmtTtl;
String3 HHCrtRecLienJudgMmbrCnt;
String3 HHCrtRecLienJudgMmbrCnt12Mo;
string3 LienCount;
string3 LienFiledAge;
string3 LienFiledCount;
string3 LienFiledCount12;
string3 LienFiledCount24;
string3 LienFiledCount60;
string10 LienFiledTotal;
string3 LienReleasedAge;
string3 LienReleasedCount;
string3 LienReleasedCount12;
string3 LienReleasedCount24;
string3 LienReleasedCount60;
string10 LienReleasedTotal;
String3 RaACrtRecBkrptMmbrCnt36Mo;
String3 RaACrtRecEvictionMmbrCnt;
String3 RaACrtRecEvictionMmbrCnt12Mo;
String7 RaACrtRecLienJudgAmtMax;
String3 RaACrtRecLienJudgMmbrCnt;
String3 RaACrtRecLienJudgMmbrCnt12Mo;
string3 RelativesBankruptcyCount;
string1 EducationAttendedCollege;
string2 EducationFieldofStudyType;
string2 EducationInstitutionPrivate;
string2 EducationInstitutionRating;
string2 EducationProgram2Yr;
string2 EducationProgram4Yr;
string2 EducationProgramGraduate;
String3 HHCollege2yrAttendedMmbrCnt;
String3 HHCollege4yrAttendedMmbrCnt;
String3 HHCollegeAttendedMmbrCnt;
String3 HHCollegeGradAttendedMmbrCnt;
String3 HHCollegePrivateMmbrCnt;
String2 HHCollegeTierMmbrHighest;
String2 ProspectCollegeAttended;
String2 ProspectCollegeAttending;
String2 ProspectCollegeProgramType;
String2 ProspectCollegeTier;
String3 RaACollege2yrAttendedMmbrCnt;
String3 RaACollege4yrAttendedMmbrCnt;
String3 RaACollegeAttendedMmbrCnt;
String3 RaACollegeGradAttendedMmbrCnt;
String3 RaACollegeLowTierMmbrCnt;
String3 RaACollegeMidTierMmbrCnt;
String3 RaACollegePrivateMmbrCnt;
String3 RaACollegeTopTierMmbrCnt;
string4 AgeNewestRecord;
string4 AgeOldestRecord;
string1 CreditBureauRecord;
string4 LastNameChangeAge;
string3 LastNameChangeCount06;
string3 LastNameChangeCount12;
string3 LastNameChangeCount60;
String2 ProspectBankingExperience;
string2 RecentActivityIndex;
string1 RecentUpdate;
STRING3 AssocCreditBureauOnlyCount;
STRING3 AssocCreditBureauOnlyCountMonth;
STRING3 AssocCreditBureauOnlyCountNew;
STRING3 AssocHighRiskTopologyCount;
STRING3 AssocSuspicousIdentitiesCount;
STRING2 AssocRiskLevel;
STRING1 ComponentCharRiskLevel;
STRING1 DivRiskLevel;
STRING2 IdentityRiskLevel;
STRING2 IDVerRiskLevel;
STRING1 SearchComponentRiskLevel;
STRING2 SearchVelocityRiskLevel;
STRING2 SourceRiskLevel;
STRING1 SourceWatchList;
STRING1 ValidationRiskLevel;
string3 PRSearchAddrIdentities;
string3 PRSearchIdentityAddrs;
string3 PRSearchIdentityPhones;
string3 PRSearchIdentitySSNs;
string3 PRSearchLocateCount;
string3 PRSearchLocateCount01;
string3 PRSearchLocateCount03;
string3 PRSearchLocateCount06;
string3 PRSearchLocateCount12;
string3 PRSearchLocateCount24;
string3 PRSearchOtherCount;
string3 PRSearchOtherCount03;
string3 PRSearchOtherCount12;
string3 PRSearchPersonalFinanceCount;
string3 PRSearchPersonalFinanceCount12;
string3 PRSearchPersonalFinanceCount24;
string3 PRSearchPhoneIdentities;
string3 PRSearchSSNIdentities;
STRING3 SearchAddrSearchCount;
STRING3 SearchPhoneSearchCount;
STRING3 SearchSSNSearchCount;
STRING3 SearchUnverifiedAddrCountYear;
STRING3 SearchUnverifiedDOBCountYear;
STRING3 SearchUnverifiedPhoneCountYear;
STRING3 SearchUnverifiedSSNCountYear;
string3 AgeRiskIndicator;
STRING1 CorrelationRiskLevel;
string2 OnlineDirectory;
string3 SrcsConfirmIDAddrCount;
string2 VerificationFailure;
string2 VerifiedAddress;
string2 VerifiedDOB;
string1 VerifiedName;
string3 SubjectAddrCount;
string3 SubjectAddrRecentCount;
string3 SubjectLastNameCount;
string3 SubjectSSNCount;
string3 SubjectSSNRecentCount;
STRING3 VariationDOBCount;
STRING3 VariationDOBCountNew;
STRING3 VariationIdentityCount;
STRING3 VariationMSourcesSSNCount;
STRING3 VariationMSourcesSSNUnrelCount;
STRING2 VariationRiskLevel;
string10 EstimatedAnnualIncome;
string10 EstimatedAnnualIncome_12;
string10 EstimatedAnnualIncome_24;
String2 HHEstimatedIncomeRange;
String2 ProspectEstimatedIncomeRange;
String2 RaAMedIncomeRange;
string3 BusinessInputAddrCount;
STRING3 DivAddrIdentityCount;
STRING3 DivAddrIdentityCountNew;
STRING3 DivAddrIdentityMSourceCount;
STRING3 DivAddrSSNCount;
STRING3 DivAddrSSNCountNew;
STRING3 DivAddrSSNMSourceCount;
STRING3 DivAddrSuspIdentityCountNew;
STRING3 DivSearchAddrSuspIdentityCount;
STRING3 IDVerAddressAssocCount;
string3 InputAddrAgeLastSale;
string3 InputAddrAgeNewestRecord;
string3 InputAddrAgeOldestRecord;
string2 InputAddrApplicantOwned;
string10 InputAddrAVMValue;
string10 InputAddrAVMValue12;
string10 InputAddrAVMValue60;
string5 InputAddrBlockIndex;
string3 InputAddrBurglaryIndex;
string3 InputAddrBusinessCount;
string3 InputAddrCarTheftIndex;
string5 InputAddrCountyIndex;
string3 InputAddrCrimeIndex;
string2 InputAddrDelivery;
string2 InputAddrDwellType;
string5 InputAddrErrorCode;
string2 InputAddrFamilyOwned;
string2 InputAddrHighRisk;
string2 InputAddrHistoricalMatch;
string10 InputAddrLastSalesPrice;
string3 InputAddrLenOfRes;
string10 InputAddrMedianIncome;
string10 InputAddrMedianValue;
string3 InputAddrMobilityIndex;
string2 InputAddrMortgageType;
string3 InputAddrMultiFamilyCount;
string3 InputAddrMurderIndex;
string2 InputAddrNotPrimaryRes;
string2 InputAddrOccupantOwned;
string2 InputAddrProblems;
string4 InputAddrSICCode;
string3 InputAddrSingleFamilyCount;
string10 InputAddrTaxMarketValue;
string10 InputAddrTaxValue;
string4 InputAddrTaxYr;
string5 InputAddrTractIndex;
string3 InputAddrVacantPropCount;
string2 InputAddrValidation;
String5 ResInputAVMRatioDiff12Mo;
String5 ResInputAVMRatioDiff60Mo;
String3 ResInputBusinessCnt;
String7 ResInputMortgageAmount;
String2 ResInputOwnershipIndex;
string3 SFDUAddrIdentitiesCount;
string3 SFDUAddrIdentitiesCount_12;
string3 SFDUAddrIdentitiesCount_24;
string3 SFDUAddrSSNCount;
STRING3 DivSSNAddrMSourceCount;
STRING3 DivSSNIdentityMSourceCount;
STRING3 DivSSNIdentityMSourceUrelCount;
STRING3 DivSSNLNameCountNew;
STRING2 IDVerSSNCreditBureauCount;
STRING2 IDVerSSNCreditBureauDelete;
string2 SSN3Years;
string3 SSNAddrCount;
string3 SSNAddrRecentCount;
string2 SSNAfter5;
string2 SSNFoundOther;
string3 SSNHighIssueAge;
string3 SSNIdentitiesCount;
string3 SSNIdentitiesRecentCount;
string2 SSNIssueState;
string3 SSNLastNameCount;
string3 SSNLowIssueAge;
string2 SSNNonUS;
string2 SSNNotFound;
string2 SSNProblems;
string2 SSNRecent;
string2 VerifiedSSN;
String3 HHInterestSportPersonMmbrCnt;
String2 InterestSportPerson;
String3 RaAInterestSportPersonMmbrCnt;
string4 AddrMostRecentCrimeDiff;
string4 AddrMostRecentDistance;
string11 AddrMostRecentIncomeDiff;
string3 AddrMostRecentMoveAge;
string2 AddrMostRecentStateDiff;
string11 AddrMostRecentTaxDiff;
string11 AddrMostRecentValueDIff;
string2 AddrRecentEconTrajectory;
string2 AddrRecentEconTrajectoryIndex;
string3 NonDerogCount;
string3 NonDerogCount06;
string3 NonDerogCount12;
string3 NonDerogCount24;
string3 NonDerogCount60;
string1 VoterRegistrationRecord;
string2 BusinessActiveAssociation;
string3 BusinessAssociationAge;
string2 BusinessInactiveAssociation;
String3 HHOccBusinessAssocMmbrCnt;
String3 HHOccProfLicMmbrCnt;
String2 OccBusinessAssociation;
String3 OccBusinessAssociationTime;
String2 OccBusinessTitleLeadership;
String2 OccProfLicense;
String2 OccProfLicenseCategory;
string3 ProfLicAge;
string3 ProfLicCount;
string3 ProfLicCount12;
string3 ProfLicCount60;
string2 ProfLicExpired;
string2 ProfLicTypeCategory;
String3 RaAOccBusinessAssocMmbrCnt;
String3 RaAOccProfLicMmbrCnt;
string2 CurrAddrActivePhoneList;
string2 InputAddrActivePhoneList;
string3 InputAddrPhoneCount;
string3 InputAddrPhoneRecentCount;
string2 InputAreaCodeChange;
string2 InputPhoneHighRisk;
string2 InputPhoneMobile;
string2 InputPhoneProblems;
string2 InputPhoneServiceType;
string2 InputPhoneType;
string3 PhoneEDAAgeNewestRecord;
string3 PhoneEDAAgeOldestRecord;
string3 PhoneIdentitiesCount;
string3 PhoneIdentitiesRecentCount;
string2 PhoneOther;
string3 PhoneOtherAgeNewestRecord;
string3 PhoneOtherAgeOldestRecord;
string3 SubjectPhoneCount;
string3 SubjectPhoneRecentCount;
string2 VerifiedPhone;
string3 PrevAddrAgeLastSale;
string3 PrevAddrAgeNewestRecord;
string3 PrevAddrAgeOldestRecord;
string2 PrevAddrApplicantOwned;
string10 PrevAddrAVMValue;
string5 PrevAddrBlockIndex;
string3 PrevAddrBurglaryIndex;
string3 PrevAddrCarTheftIndex;
string5 PrevAddrCountyIndex;
string3 PrevAddrCrimeIndex;
string2 PrevAddrDwellType;
string2 PrevAddrFamilyOwned;
string10 PrevAddrLastSalesPrice;
string3 PrevAddrLenOfRes;
string10 PrevAddrMedianIncome;
string10 PrevAddrMedianValue;
string3 PrevAddrMurderIndex;
string2 PrevAddrOccupantOwned;
string10 PrevAddrTaxMarketValue;
string10 PrevAddrTaxValue;
string4 PrevAddrTaxYr;
string5 PrevAddrTractIndex;
string3 SubPrimeOfferRequestCount;
string3 SubPrimeOfferRequestCount12;
string3 SubPrimeOfferRequestCount24;
string4 DoNotMail;
string4 SourceOrderActivity;
string4 SourceOrderAgeLastOrder;
string4 SourceOrderSourceCount;
String20 Score;
String3 ADLScore;
string1 PATIENT_TYPE;
string1 GENDER;
string2 FINANCIAL_CLASS;
string5 RSMemberAge;
string2 AGE_GROUP;
string11 ADMIT_DIAG;
string11 READMIT_DIAG;
string11 READMIT_LIFT;
string1 isSeRsExcludedDiag;
string1 isSeRsMinor;
string1 isSeRsInvalidDiag;
string1 isSeRsInvalidPatientType;
string1 isSeRsInvalidFinancialClass;
string1 isSeRsM1ModelUsed;
string8 SeRs_Score;
string20 SeRs_Raw_Score;
string10 RAR_Driver_Hi1;
string10 RAR_Driver_Hi2;
string10 RAR_Driver_Hi3;
string10 RAR_Driver_Lo1;
string10 RAR_Driver_Lo2;
string10 RAR_Driver_Lo3;
string8  SeMA_Score;
string20 SeMA_Raw_Score;
string10 MA_Driver_Hi1;
string10 MA_Driver_Hi2;
string10 MA_Driver_Hi3;
string10 MA_Driver_Lo1;
string10 MA_Driver_Lo2;
string10 MA_Driver_Lo3;
string8  SeMO_Score;
string20 SeMO_Raw_Score;
string10 MO_Driver_Hi1;
string10 MO_Driver_Hi2;
string10 MO_Driver_Hi3;
string10 MO_Driver_Lo1;
string10 MO_Driver_Lo2;
string10 MO_Driver_Lo3;
string3 ADDRCHANGECOUNT24;
string3 ARRESTCOUNT24;
string3 NONDEROGCOUNT01;
string3 PRSEARCHOTHERCOUNT24;
STRING4 PROSPECTTIMEONRECORD;
STRING3 PROSPECTTIMELASTUPDATE;
STRING3 PROSPECTAGE;
STRING3 PROPCURROWNEDCNT;
STRING3 PROPTIMELASTSALE;
STRING3 PROPSOLDCNT12MO;
STRING5 PROPSOLDRATIO;
STRING3 PPCURROWNEDAUTOCNT;
STRING3 CRTRECCNT12MO;
STRING3 CRTRECTIMENEWEST;
STRING3 CRTRECFELONYCNT;
STRING3 CRTRECLIENJUDGCNT;
STRING3 CRTRECBKRPTTIMENEWEST;
STRING3 HHPPCURROWNEDAUTOCNT;
string10 ReadmissionScore_Category;
string10 MedicationAdherenceScore_Category;
string10 MotivationScore_Category;
STRING errorcode;
   END;
   
xlayout myFail(soap_in le) := TRANSFORM
   SELF.errorcode := FAILCODE + FAILMESSAGE;
   SELF := le;
   SELF := [];
END;

 
  Socio_Results_v5 := soapcall(soap_in, roxieIP,
               'models.healthcare_socioeconomic_batch_service_v5', 
               {soap_in}, 
               DATASET(xlayout),
               PARALLEL(threads), 
               onFail(myFail(LEFT)));
							 
	/*Socio_Results_batch := soapcall(soap_in, roxieIP,
               'models.healthcare_socioeconomic_batch_service', 
               {soap_in}, 
               DATASET(xlayout),
               PARALLEL(threads), 
               onFail(myFail(LEFT)));*/
							 
//Soap_Out:= OUTPUT(Socio_Results_v5,, Output_file_name, CSV(HEADING(SINGLE), QUOTE('"')), OVERWRITE); //writes to disk						 
Soap_Out := OUTPUT(Socio_Results_v5,, SOCIO_Monitoring_v5_outfile, THOR, OVERWRITE); //writes to disk						 
//Soap_Out:= OUTPUT(Socio_Results_v5,, Output_file_name,, OVERWRITE); //writes to disk						 
//Soap_Out := OUTPUT(Soap_In,, Input_file_name, THOR);

RETURN Soap_Out;
//OUTPUT(Socio_Results_v5);
ENDMACRO;