IMPORT RiskWise, scoring_project_pip, Scoring_Project_Macros, Scoring_Project_DailyTracking, ut, std, ashirey, Gateway, Phone_Shell, Risk_Indicators;

//Options to change
thresh  := 0;
eyeball := 10;
a := (STRING8)std.Date.Today();


//Getting the previous day from the input day above
fn_LastTwoMonths(STRING10 date_inp,INTEGER offset) := FUNCTION
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
RETURN res[1..8];
END;

b  := fn_LastTwoMonths(a,1); //yesterdays date

a1 := a +'_1';
b1 := b +'_1'; 


//reading in dataset dph SOCIO
input_layout := RECORD
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



ds_base := dataset('~ScoringQA::Out::Socioeconomic_v5_Batch_' + b1, input_layout,thor); //dataset from macro
ds_test := dataset('~ScoringQA::Out::Socioeconomic_v5_Batch_' + a1, input_layout,thor);

// output(ds_base, named('ds_base'));

cert_ds_out := Scoring_Project_PIP.Compare_dsets_macro_email(ds_base, ds_test, ['acctno'], thresh); //start here with compare

//cert_ds_out_filter := cert_ds_out(field not in ['age_in_years']); //this can be used to filter out attributes that change frequently and need to be removed (eg. Seq)
//cert_ds_out_filter := cert_ds_out(field not in ['phone_shell__input_echo__in_processing_date']);


nonfcra_ds_curr := ds_test;
nonfcra_ds_prev := ds_base;

cleaned_nonfcra_curr_date := a1;
cleaned_nonfcra_prev_date := b1;

nonfcra_join1      := JOIN(nonfcra_ds_curr, nonfcra_ds_prev,  LEFT.acctno=RIGHT.acctno, transform(left)); //only returns matching records between daily collection files
nonfcra_clean_file := nonfcra_join1(acctno <> '');


//designing emailed report
		MyRec := RECORD
		INTEGER order;
		STRING line;
	END;
max_diff := (STRING)cert_ds_out[1].diff_pct	 + '%';

		
		
	ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
	
	//STRING filler := '        ';
	STRING filler := '  ';

//cert_realtime is socio attributes 
	cert_realtime := IF(COUNT(cert_ds_out) > 0,
																		PROJECT(cert_ds_out, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.Field) + filler)[1..42] + (LEFT.diff_cnt	+ filler)[1..12] + (LEFT.diff_pct	 + '%'+filler)[1..12]+ (left.up_cnt + filler)[1..12]    + (left.up_pct + '%'+filler)[1..12] + (left.down_cnt + filler)[1..12]    + (left.down_pct + '%')[1..12]     )),
																		ds_no_diff);

		//here																
	line_heading := ('SOCIO_ATTRIBUTES (Threshold: ' + thresh + '%)' + filler)[1..42] + ('Diff Cnt' + filler)[1..12] + ('Diff Pct' + filler)[1..12]+ ('Up Cnt' + filler)[1..12]+ ('Up Pct' + filler)[1..12]+('Down Cnt' + filler)[1..12] + ('Down Pct' + filler)[1..12];

filler2 := '                    ';

//first line in email, change as needed
main_head := DATASET([{1,'Socioeconomic Daily Monitoring (Model_v5)' + '\n'
												+ '*** This report is produced by ScoringQA ***'
												}], MyRec); 		
			
//details about the report
	head_cert_realtime := DATASET([{1,    
													'Environment:  CERT - NONFCRA'	+ '\n'
												+ 'Archive date:  999999' + '\n'
												+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
												+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
												+ 'Previous test case count:  ' + COUNT(nonfcra_ds_prev) + '\n'
												+ 'Current test case count:  ' + COUNT(nonfcra_ds_curr) + '\n'
												+ 'Matched records:  ' + COUNT(nonfcra_clean_file) + '\n'											
												}], MyRec); 


//Readmission score calculations(unmatched and matched)
line_heading_avg := ('Field' + filler)[1..42] + ('Previous Avg' + filler)[1..15] + ('Current Avg' + filler)[1..15]+ ('Diff Avg' + filler)[1..14] + 'Diff Pct';
j_base_matched := JOIN(ds_base, ds_test, LEFT.acctno = RIGHT.acctno, TRANSFORM(input_layout, SELF := LEFT));								
j_test_matched := JOIN(ds_base, ds_test, LEFT.acctno = RIGHT.acctno, TRANSFORM(input_layout, SELF := RIGHT));	

//Remove UNmatched once daily collection file is stable
Prev_Avg_SeRs_Score_Unmatched := ave(ds_base, (INTEGER)SeRs_Score); //overall average of entire sample regardless of how many records were returned (ex: 10000 records returned yesterday vs 25000 returned today)
Curr_Avg_SeRs_Score_Unmatched := ave(ds_test, (INTEGER)SeRs_Score);
Diff_Avg_SeRs_Score_Unmatched := Curr_Avg_SeRs_Score_Unmatched - Prev_Avg_SeRs_Score_Unmatched;
DiffPct_Avg_SeRs_Score_Unmatched := (Curr_Avg_SeRs_Score_Unmatched - Prev_Avg_SeRs_Score_Unmatched)/Prev_Avg_SeRs_Score_Unmatched*100;


//Matched is used for most of our reports
Prev_Avg_SeRs_Matched := ave(j_base_matched, (INTEGER)SeRs_Score);
Curr_Avg_SeRs_Matched := ave(j_test_matched, (INTEGER)SeRs_Score);
Diff_Avg_SeRs_Matched := Curr_Avg_SeRs_matched - Prev_Avg_SeRs_matched;
DiffPct_Avg_SeRs_Matched := (Diff_Avg_SeRs_matched) / Prev_Avg_SeRs_matched * 100;



//Medication adherence score calculations(unmatched and matched)
Prev_Avg_SeMa_Score_Unmatched := ave(ds_base, (INTEGER)SeMa_Score);
Curr_Avg_SeMa_Score_Unmatched := ave(ds_test, (INTEGER)SeMa_Score);
Diff_Avg_SeMa_Score_Unmatched := Curr_Avg_SeMa_Score_Unmatched - Prev_Avg_SeMa_Score_Unmatched;
DiffPct_Avg_SeMa_Score_Unmatched := (Curr_Avg_SeMa_Score_Unmatched - Prev_Avg_SeMa_Score_Unmatched)/Prev_Avg_SeMa_Score_Unmatched*100;

Prev_Avg_SeMa_Matched := ave(j_base_matched, (INTEGER)SeMa_Score);
Curr_Avg_SeMa_Matched := ave(j_test_matched, (INTEGER)SeMa_Score);
Diff_Avg_SeMa_Matched := Curr_Avg_SeMa_matched - Prev_Avg_SeMa_matched;
DiffPct_Avg_SeMa_Matched := (Diff_Avg_SeMa_matched)/Prev_Avg_SeMa_matched*100;



///////////////////////////testing scores/////////////////////////////////
/*OUTPUT(Prev_Avg_SeMa_Score_Unmatched,NAMED('Prev_Avg_SeMa_Score_Unmatched'));  //use this to troubleshoot individual scores
OUTPUT(Curr_Avg_SeMa_Score_Unmatched,NAMED('Curr_Avg_SeMa_Score_Unmatched'));  //use this to troubleshoot individual scores
OUTPUT(Diff_Avg_SeMa_Score_Unmatched,NAMED('Diff_Avg_SeMa_Score_Unmatched'));  //use this to troubleshoot individual scores
OUTPUT(DiffPct_Avg_SeMa_Score_Unmatched,NAMED('DiffPct_Avg_SeMa_Score_Unmatched'));  //use this to troubleshoot individual scores
OUTPUT(Prev_Avg_SeMa_Matched,NAMED('Prev_Avg_SeMa_Matched'));  //use this to troubleshoot individual scores
OUTPUT(Curr_Avg_SeMa_Matched,NAMED('Curr_Avg_SeMa_Matched'));  //use this to troubleshoot individual scores
OUTPUT(Diff_Avg_SeMa_Matched,NAMED('Diff_Avg_SeMa_Matched'));  //use this to troubleshoot individual scores
OUTPUT(DiffPct_Avg_SeMa_Matched,NAMED('DiffPct_Avg_SeMa_Matched'));  //use this to troubleshoot individual scores
*/

//Motivation score calculations(unmatched and matched)
Prev_Avg_SeMo_Score_Unmatched := ave(ds_base, (INTEGER)SeMo_Score);
Curr_Avg_SeMo_Score_Unmatched := ave(ds_test, (INTEGER)SeMo_Score);
Diff_Avg_SeMo_Score_Unmatched := Curr_Avg_SeMo_Score_Unmatched - Prev_Avg_SeMo_Score_Unmatched;
DiffPct_Avg_SeMo_Score_Unmatched := (Curr_Avg_SeMo_Score_Unmatched - Prev_Avg_SeMo_Score_Unmatched)/Prev_Avg_SeMo_Score_Unmatched*100;

Prev_Avg_SeMo_Matched    := ave(j_base_matched, (INTEGER)SeMo_Score);
Curr_Avg_SeMo_Matched    := ave(j_test_matched, (INTEGER)SeMo_Score);
Diff_Avg_SeMo_Matched    := Curr_Avg_SeMo_Matched - Prev_Avg_SeMo_Matched;
DiffPct_Avg_SeMo_Matched := (Diff_Avg_SeMo_Matched) / Prev_Avg_SeMo_Matched * 100;


//OUTPUT(Prev_Avg_SeMo_Score_Unmatched,NAMED('Prev_Avg_SeMo_Score_Unmatched'));
//OUTPUT(Curr_Avg_SeMo_Score_Unmatched,NAMED('Curr_Avg_SeMo_Score_Unmatched'));

//Scores from above formatted for output in email
	head_cert_realtime_avg := DATASET([{1,    
												line_heading_avg + '\n'
												+ '------------------------------------------------------------------------------------------------' + '\n'
												+('SeRs_Score(unmatched)' + filler)[1..45] + ((string)Round(Prev_Avg_SeRs_Score_Unmatched, 2) + filler)[1..14] + ((string)Round(Curr_Avg_SeRs_Score_Unmatched, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_SeRs_Score_Unmatched, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_SeRs_Score_Unmatched,1) + '\n'
												+('SeMa_Score(unmatched)' + filler)[1..45] + ((string)Round(Prev_Avg_SeMa_Score_Unmatched, 2) + filler)[1..14] + ((string)Round(Curr_Avg_SeMa_Score_Unmatched, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_SeMa_Score_Unmatched, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_SeMa_Score_Unmatched,1) + '\n'
												+('SeMo_Score(unmatched)' + filler)[1..45] + ((string)Round(Prev_Avg_SeMo_Score_Unmatched, 2) + filler)[1..14] + ((string)Round(Curr_Avg_SeMo_Score_Unmatched, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_SeMo_Score_Unmatched, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_SeMo_Score_Unmatched,1) + '\n'
												+('SeRs_Score(matched)'   + filler)[1..45] + ((string)Round(Prev_Avg_SeRs_Matched, 2)         + filler)[1..14] + ((string)Round(Curr_Avg_SeRs_Matched, 2)         + filler)[1..14]+ ((string)Round(Diff_Avg_SeRs_Matched, 2)         + filler)[1..14]+ (string)Round(DiffPct_Avg_SeRs_Matched,1)         + '\n'
												+('SeMa_Score(matched)'   + filler)[1..45] + ((string)Round(Prev_Avg_SeMa_Matched, 2)         + filler)[1..14] + ((string)Round(Curr_Avg_SeMa_Matched, 2)         + filler)[1..14]+ ((string)Round(Diff_Avg_SeMa_Matched, 2)         + filler)[1..14]+ (string)Round(DiffPct_Avg_SeMa_Matched,1)         + '\n'
												+('SeMo_Score(matched)'   + filler)[1..45] + ((string)Round(Prev_Avg_SeMo_Matched, 2)         + filler)[1..14] + ((string)Round(Curr_Avg_SeMo_Matched, 2)         + filler)[1..14]+ ((string)Round(Diff_Avg_SeMo_Matched, 2)         + filler)[1..14]+ (string)Round(DiffPct_Avg_SeMo_Matched,1)
												}], MyRec); 	
	
	

	head_cert_realtime_1 := DATASET([{1,    												
												line_heading + '\n'
												+ '----------------------------------------------------------------------------------------------------------------'
												}], MyRec); 
  
	spacer := DATASET([{3,    
													'\n'
												+ '\n' 
												+ '\n' 
												}], MyRec);
	
	spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 3; SELF := LEFT));
	spacer4 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
	spacer6 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));


	output_head_cert_realtime := PROJECT(SORT(head_cert_realtime, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
	output_cert_realtime_avg  := PROJECT(SORT(head_cert_realtime_avg, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
	output_cert_realtime      := PROJECT(SORT(head_cert_realtime_1 + cert_realtime, order), TRANSFORM(MyRec, SELF.order := 8; SELF := LEFT));


	output_append := main_head + spacer2 + output_head_cert_realtime + spacer4 + output_cert_realtime_avg + spacer6+output_cert_realtime;
	output_full   := SORT(output_append, order);

	MyRec Xform(myrec L,myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
			SELF := l;
	END;

	XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));

final := FileServices.SendEmail('Daniel.Harkins@lexisnexisrisk.com, Matthew.Ludewig@lexisnexisrisk.com', 'SOCIO_v5_Daily_Monitoring: MaxDiff' + max_diff, XtabOut[COUNT(XtabOut)].line);
//final;


rar_hi_1     := table(ds_base, {rar_driver_hi1; RAR_High_1_Count := count(group)}, rar_driver_hi1);//high table today
rar_hi_2     := table(ds_base, {rar_driver_hi2; RAR_High_2_Count := count(group)}, rar_driver_hi2);//high table today
rar_hi_3     := table(ds_base, {rar_driver_hi3; RAR_High_3_Count := count(group)}, rar_driver_hi3);//high table today
//rar_lo_1     := table(ds_base, {rar_driver_lo1; RAR_Low_1_Count  := count(group)}, rar_driver_lo1);//low table today
//ma_hi    := table(ds_base, {ma_driver_hi1;  namedcount := count(group)}, rar_driver_lo1);//high table today
//ma_lo    := table(ds_base, {ma_driver_lo1;  namedcount := count(group)}, rar_driver_lo1);//low table today
//mo_hi    := table(ds_base, {mo_driver_hi1;  namedcount := count(group)}, mo_driver_hi1);//high table today
//mo_lo    := table(ds_base, {mo_driver_lo1;  namedcount := count(group)}, mo_driver_lo1);//low table today

output(rar_hi_1,NAMED('rar_hi_1'));
output(rar_hi_2,NAMED('rar_hi_2'));
output(rar_hi_3,NAMED('rar_hi_3'));

SEQUENTIAL(final);
//final;

EXPORT SOCIO_Attributes_Report := 'todo';