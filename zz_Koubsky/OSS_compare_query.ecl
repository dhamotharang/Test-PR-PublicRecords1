// EXPORT OSS_compare_query( filetag1, date1, filetag2, date2) := functionmacro
// 			( 1st filetag, 1st date, 2nd filetag, 2nd date)

IMPORT ashirey, RiskProcessing;

filetag1 := '702_221';
date1 := '20140818';
filetag2 := 'OSS_232';
date2 := '20140818';

// filetag1 := f1;
// date1 := d1;
// filetag2 := f2;
// date2 := d2;

eyeball := 25;

Experian_RVA_30_XML_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3'+ '_' + date1  + filetag1;
Experian_RVA_30_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3' + '_' + date1  + filetag1;
CapitalOne_RVAttributes_V3_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3' + '_' + date1  + filetag1;
CapitalOne_RVAttributes_V2_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2' + '_' + date1  + filetag1;
CreditAcceptanceCorp_RV2_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2' + '_' + date1  + filetag1;
T_Mobile_RVT1212_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4'+ '_' + date1  + filetag1;
T_Mobile_RVT1210_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4'+ '_' + date1  + filetag1;
Santander_RVA1304_1_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3' + '_' + date1  + filetag1;
Santander_RVA1304_2_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3' + '_' + date1  + filetag1;
RV_V3_ENOVA_XML_Scores_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4' + '_' + date1  + filetag1;
bocashell_41_cert_fcra_infile_name_1 := '~coringqa::out::bs_41_tracking_edina_fcra_NO_EDINA_' + filetag1 + '_'  + date1;
bocashell_50_cert_fcra_infile_name_1 := '~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag1 + '_'  + date1;

RV_Scores_V4_XML_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4' + '_'  + date1  + filetag1 ;
RV_Scores_V3_XML_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3'+ '_'  + date1  + filetag1 ;
RV_Attributes_V4_XML_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4' + '_' + date1  + filetag1 ;
RV_Attributes_V3_XML_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3' + '_' + date1  + filetag1 ;
RV_Attributes_V3_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3' + '_' + date1  + filetag1 ;
RV_Attributes_V4_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4' + '_' + date1  + filetag1 ;
RV_Attributes_V2_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2' + '_' + date1  + filetag1 ;
RV_Scores_V4_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4' + '_' + date1  + filetag1;
RV_Scores_V3_BATCH_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3' + '_' + date1  + filetag1;
Regional_Acceptance_RVA1008_1_infile_name_1 := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4' + '_' + date1  + filetag1 ;

Experian_RVA_30_XML_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3'+ '_' + date2  + filetag2;
Experian_RVA_30_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3' + '_' + date2  + filetag2;
CapitalOne_RVAttributes_V3_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3' + '_' + date2  + filetag2;
CapitalOne_RVAttributes_V2_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2' + '_' + date2  + filetag2;
CreditAcceptanceCorp_RV2_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2' + '_' + date2  + filetag2;
T_Mobile_RVT1212_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4'+ '_' + date2  + filetag2;
T_Mobile_RVT1210_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4'+ '_' + date2  + filetag2;
Santander_RVA1304_1_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3' + '_' + date2  + filetag2;
Santander_RVA1304_2_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3' + '_' + date2  + filetag2;
RV_V3_ENOVA_XML_Scores_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4' + '_' + date2  + filetag2;
bocashell_41_cert_fcra_infile_name_2 := '~coringqa::out::bs_41_tracking_edina_fcra_NO_EDINA_' + filetag2 + '_'  + date2;
bocashell_50_cert_fcra_infile_name_2 := '~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag2 + '_'  + date2;

RV_Scores_V4_XML_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4' + '_'  + date2  + filetag2 ;
RV_Scores_V3_XML_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3'+ '_'  + date2  + filetag2 ;
RV_Attributes_V4_XML_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4' + '_' + date2  + filetag2 ;
RV_Attributes_V3_XML_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3' + '_' + date2  + filetag2 ;
RV_Attributes_V3_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3' + '_' + date2  + filetag2 ;
RV_Attributes_V4_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4' + '_' + date2  + filetag2 ;
RV_Attributes_V2_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2' + '_' + date2  + filetag2 ;
RV_Scores_V4_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4' + '_' + date2  + filetag2;
RV_Scores_V3_BATCH_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3' + '_' + date2  + filetag2;
Regional_Acceptance_RVA1008_1_infile_name_2 := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4' + '_' + date2  + filetag2 ;


rv_attributes_norm := RECORD
	unsigned seq;

	string30 AccountNumber;
	
	STRING FirstName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING SSN;
	STRING DateOfBirth;
	STRING DLNumber;
	STRING DLState;
	STRING HomePhone;

	string4 AgeOldestRecord; 
	string4 AgeNewestRecord; 
	string1 isRecentUpdate;
	string3 NumSources;
	string1 VerifiedPhoneFullName;
	string1 VerifiedPhoneLastName;
	string1 InvalidSSN; 
	string1 InvalidPhone; 
	string1 InvalidAddr; 
	string1 InvalidDL; 
	string1 isNoVer;
	
	string1 SSNDeceased;
	string8 DeceasedDate;
	string1 SSNValid;
	string1 RecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 NonUS;
	string1 Issued3;
	string1 IssuedAge5;

	string4 IAAgeOldestRecord;
	string4 IAAgeNewestRecord;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string IAAssessedValue;
	string1 IAOwnedBySubject;
	string1 IAFamilyOwned;
	string1 IAOccupantOwned;
	string4 IAAgeLastSale;
	string IALastSaleAmount;
	string1 IANotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string4 CAAgeOldestRecord;
	string4 CAAgeNewestRecord;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string CAAssessedValue;
	string1 CAOwnedBySubject;
	string1 CAFamilyOwned;
	string1 CAOccupantOwned;
	string4 CAAgeLastSale;
	string CALastSaleAmount;
	string1 CANotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string4 PAAgeOldestRecord;
	string4 PAAgeNewestRecord;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string PAAssessedValue;
	string1 PAOwnedBySubject;
	string1 PAFamilyOwned;
	string1 PAOccupantOwned;
	string4 PAAgeLastSale;
	string PALastSaleAmount;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 InputCurrMatch;
	string DistInputCurr;
	string1 DiffState;
	string AssessedDiff;
	string2 EcoTrajectory;
	
	string1 InputPrevMatch;
	string DistCurrPrev;
	string1 DiffState2;
	string AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string14 property_owned_assessed_total;
	string3 property_historically_owned;
	string4 PropAgeOldestPurchase;
	string4 PropAgeNewestPurchase;
	string4 PropAgeNewestSale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string4 DerogAge;
	
	string3 felonies;
	string4 FelonyAge;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string4 LienFiledAge;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string4 LienReleasedAge;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string4 BankruptcyAge;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string4 EvictionAge;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string4 ProfLicAge;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 AddrHighRisk;
	string1 PhoneHighRisk;
	string1 AddrPrison;
	string1 ZipPOBox;
	string1 ZipCorpMil;
	string1 phoneStatus;
	string1 PhonePager;
	string1 PhoneMobile;
	string1 PhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	//string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	//string1 negativeAlert;
	string1 idTheftFlag;
	
	// new version 3 fields
	string1 SSNNotFound;
	string3 VerifiedName;
	string3 VerifiedSSN;
	string3 VerifiedPhone;
	string3 VerifiedAddress;
	string3 VerifiedDOB;
	string3 InferredMinimumAge;
	string3 BestReportedAge;
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
	string1 SSNIssuedPriorDOB;
	
	string4 InputAddrTaxYr;
	string14 InputAddrTaxMarketValue;
	string14 InputAddrAVMTax;
	string14 InputAddrAVMSalesPrice;
	string14 InputAddrAVMHedonic;
	string14 InputAddrAVMValue;
	string3 InputAddrAVMConfidence;
	string8 InputAddrCountyIndex;
	string8 InputAddrTractIndex;
	string8 InputAddrBlockIndex;
	
	string4 CurrAddrTaxYr;
	string14 CurrAddrTaxMarketValue;
	string14 CurrAddrAVMTax;
	string14 CurrAddrAVMSalesPrice;
	string14 CurrAddrAVMHedonic;
	string14 CurrAddrAVMValue;
	string3 CurrAddrAVMConfidence;
	string8 CurrAddrCountyIndex;
	string8 CurrAddrTractIndex;
	string8 CurrAddrBlockIndex;
	
	string4 PrevAddrTaxYr;
	string14 PrevAddrTaxMarketValue;
	string14 PrevAddrAVMTax;
	string14 PrevAddrAVMSalesPrice;
	string14 PrevAddrAVMHedonic;
	string14 PrevAddrAVMValue;
	string3 PrevAddrAVMConfidence;
	string8 PrevAddrCountyIndex;
	string8 PrevAddrTractIndex;
	string8 PrevAddrBlockIndex;
	
	string1 EducationAttendedCollege;
	string1 EducationProgram2Yr;
	string1 EducationProgram4Yr;
	string1 EducationProgramGraduate;
	string1 EducationInstitutionPrivate;
	string1 EducationInstitutionRating;
	
	string PredictedAnnualIncome;
	
	string14 PropNewestSalePrice;
	string8 PropNewestSalePurchaseIndex;
	// string8 PropNewestSaleTaxIndex;
	// string8 PropNewestSaleAVMIndex;
	
	string3 SubPrimeSolicitedCount;
	string3 SubPrimeSolicitedCount01;
	string3 SubprimeSolicitedCount03;
	string3 SubprimeSolicitedCount06;
	string3 SubPrimeSolicitedCount12;
	string3 SubPrimeSolicitedCount24;
	string3 SubPrimeSolicitedCount36;
	string3 SubPrimeSolicitedCount60;
	
	string14 LienFederalTaxFiledTotal;
	string14 LienTaxOtherFiledTotal;
	string14 LienForeclosureFiledTotal;
	string14 LienPreforeclosureFiledTotal;
	string14 LienLandlordTenantFiledTotal;
	string14 LienJudgmentFiledTotal;
	string14 LienSmallClaimsFiledTotal;
	string14 LienOtherFiledTotal;
	string14 LienFederalTaxReleasedTotal;
	string14 LienTaxOtherReleasedTotal;
	string14 LienForeclosureReleasedTotal;
	string14 LienPreforeclosureReleasedTotal;
	string14 LienLandlordTenantReleasedTotal;
	string14 LienJudgmentReleasedTotal;
	string14 LienSmallClaimsReleasedTotal;
	string14 LienOtherReleasedTotal;
	
	string3 LienFederalTaxFiledCount;
	string3 LienTaxOtherFiledCount;
	string3 LienForeclosureFiledCount;
	string3 LienPreforeclosureFiledCount;
	string3 LienLandlordTenantFiledCount;
	string3 LienJudgmentFiledCount;
	string3 LienSmallClaimsFiledCount;
	string3 LienOtherFiledCount;
	string3 LienFederalTaxReleasedCount;
	string3 LienTaxOtherReleasedCount;
	string3 LienForeclosureReleasedCount;
	string3 LienPreforeclosureReleasedCount;
	string3 LienLandlordTenantReleasedCount;
	string3 LienJudgmentReleasedCount;
	string3 LienSmallClaimsReleasedCount;
	string3 LienOtherReleasedCount;
	
	string1 ProfLicTypeCategory;
	
	string4 PhoneEDAAgeOldestRecord;
	string4 PhoneEDAAgeNewestRecord;
	string4 PhoneOtherAgeOldestRecord;
	string4 PhoneOtherAgeNewestRecord;
	
	string1 PrescreenOptOut;
	
	string6 history_date;
	
	string200 errorcode;
END;


final_layout := record
	string12 DID;
	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
		RiskProcessing.layout_internal_extras;
end;
final_layout2 := record
	string12 DID;
	string30 AccountNumber;
  string4 ageoldestrecord;
  string4 agenewestrecord;
  string1 isrecentupdate;
  string3 numsources;
  string1 verifiedphonefullname;
  string1 verifiedphonelastname;
  string1 invalidssn;
  string1 invalidphone;
  string1 invalidaddr;
  string1 invaliddl;
  string1 isnover;
  string1 ssndeceased;
  string8 deceaseddate;
  string1 ssnvalid;
  string1 recentissue;
  string8 lowissuedate;
  string8 highissuedate;
  string2 issuestate;
  string1 nonus;
  string1 issued3;
  string1 issuedage5;
  string4 iaageoldestrecord;
  string4 iaagenewestrecord;
  string4 ialenofres;
  string1 iadwelltype;
  string1 ialandusecode;
  string iaassessedvalue;
  string1 iaownedbysubject;
  string1 iafamilyowned;
  string1 iaoccupantowned;
  string4 iaagelastsale;
  string ialastsaleamount;
  string1 ianotprimaryres;
  string1 iaphonelisted;
  string10 iaphonenumber;
  string4 caageoldestrecord;
  string4 caagenewestrecord;
  string4 calenofres;
  string1 cadwelltype;
  string1 calandusecode;
  string caassessedvalue;
  string1 caownedbysubject;
  string1 cafamilyowned;
  string1 caoccupantowned;
  string4 caagelastsale;
  string calastsaleamount;
  string1 canotprimaryres;
  string1 caphonelisted;
  string10 caphonenumber;
  string4 paageoldestrecord;
  string4 paagenewestrecord;
  string4 palenofres;
  string1 padwelltype;
  string1 palandusecode;
  string paassessedvalue;
  string1 paownedbysubject;
  string1 pafamilyowned;
  string1 paoccupantowned;
  string4 paagelastsale;
  string palastsaleamount;
  string1 paphonelisted;
  string10 paphonenumber;
  string1 inputcurrmatch;
  string distinputcurr;
  string1 diffstate;
  string assesseddiff;
  string2 ecotrajectory;
  string1 inputprevmatch;
  string distcurrprev;
  string1 diffstate2;
  string assesseddiff2;
  string2 ecotrajectory2;
  string1 mobility_indicator;
  string1 statusaddr;
  string1 statusaddr2;
  string1 statusaddr3;
  string3 addrchanges30;
  string3 addrchanges90;
  string3 addrchanges180;
  string3 addrchanges12;
  string3 addrchanges24;
  string3 addrchanges36;
  string3 addrchanges60;
  string3 property_owned_total;
  string14 property_owned_assessed_total;
  string3 property_historically_owned;
  string4 propageoldestpurchase;
  string4 propagenewestpurchase;
  string4 propagenewestsale;
  string3 numpurchase30;
  string3 numpurchase90;
  string3 numpurchase180;
  string3 numpurchase12;
  string3 numpurchase24;
  string3 numpurchase36;
  string3 numpurchase60;
  string3 numsold30;
  string3 numsold90;
  string3 numsold180;
  string3 numsold12;
  string3 numsold24;
  string3 numsold36;
  string3 numsold60;
  string3 numwatercraft;
  string3 numwatercraft30;
  string3 numwatercraft90;
  string3 numwatercraft180;
  string3 numwatercraft12;
  string3 numwatercraft24;
  string3 numwatercraft36;
  string3 numwatercraft60;
  string3 numaircraft;
  string3 numaircraft30;
  string3 numaircraft90;
  string3 numaircraft180;
  string3 numaircraft12;
  string3 numaircraft24;
  string3 numaircraft36;
  string3 numaircraft60;
  string1 wealth_indicator;
  string3 total_number_derogs;
  string4 derogage;
  string3 felonies;
  string4 felonyage;
  string3 felonies30;
  string3 felonies90;
  string3 felonies180;
  string3 felonies12;
  string3 felonies24;
  string3 felonies36;
  string3 felonies60;
  string3 num_liens;
  string3 num_unreleased_liens;
  string4 lienfiledage;
  string3 num_unreleased_liens30;
  string3 num_unreleased_liens90;
  string3 num_unreleased_liens180;
  string3 num_unreleased_liens12;
  string3 num_unreleased_liens24;
  string3 num_unreleased_liens36;
  string3 num_unreleased_liens60;
  string3 num_released_liens;
  string4 lienreleasedage;
  string3 num_released_liens30;
  string3 num_released_liens90;
  string3 num_released_liens180;
  string3 num_released_liens12;
  string3 num_released_liens24;
  string3 num_released_liens36;
  string3 num_released_liens60;
  string3 bankruptcy_count;
  string4 bankruptcyage;
  string1 filing_type;
  string35 disposition;
  string3 bankruptcy_count30;
  string3 bankruptcy_count90;
  string3 bankruptcy_count180;
  string3 bankruptcy_count12;
  string3 bankruptcy_count24;
  string3 bankruptcy_count36;
  string3 bankruptcy_count60;
  string3 eviction_count;
  string4 evictionage;
  string3 eviction_count30;
  string3 eviction_count90;
  string3 eviction_count180;
  string3 eviction_count12;
  string3 eviction_count24;
  string3 eviction_count36;
  string3 eviction_count60;
  string3 num_nonderogs;
  string3 num_nonderogs30;
  string3 num_nonderogs90;
  string3 num_nonderogs180;
  string3 num_nonderogs12;
  string3 num_nonderogs24;
  string3 num_nonderogs36;
  string3 num_nonderogs60;
  string3 num_proflic;
  string4 proflicage;
  string60 proflic_type;
  string8 expire_date_last_proflic;
  string3 num_proflic30;
  string3 num_proflic90;
  string3 num_proflic180;
  string3 num_proflic12;
  string3 num_proflic24;
  string3 num_proflic36;
  string3 num_proflic60;
  string3 num_proflic_exp30;
  string3 num_proflic_exp90;
  string3 num_proflic_exp180;
  string3 num_proflic_exp12;
  string3 num_proflic_exp24;
  string3 num_proflic_exp36;
  string3 num_proflic_exp60;
  string1 addrhighrisk;
  string1 phonehighrisk;
  string1 addrprison;
  string1 zippobox;
  string1 zipcorpmil;
  string1 phonestatus;
  string1 phonepager;
  string1 phonemobile;
  string1 phonezipmismatch;
  string4 phoneaddrdist;
  string1 correctedflag;
  string1 securityfreeze;
  string1 securityalert;
  string1 idtheftflag;
  string1 ssnnotfound;
  string3 verifiedname;
  string3 verifiedssn;
  string3 verifiedphone;
  string3 verifiedaddress;
  string3 verifieddob;
  string3 inferredminimumage;
  string3 bestreportedage;
  string3 subjectssncount;
  string3 subjectaddrcount;
  string3 subjectphonecount;
  string3 subjectssnrecentcount;
  string3 subjectaddrrecentcount;
  string3 subjectphonerecentcount;
  string3 ssnidentitiescount;
  string3 ssnaddrcount;
  string3 ssnidentitiesrecentcount;
  string3 ssnaddrrecentcount;
  string3 inputaddridentitiescount;
  string3 inputaddrssncount;
  string3 inputaddrphonecount;
  string3 inputaddridentitiesrecentcount;
  string3 inputaddrssnrecentcount;
  string3 inputaddrphonerecentcount;
  string3 phoneidentitiescount;
  string3 phoneidentitiesrecentcount;
  string1 ssnissuedpriordob;
  string4 inputaddrtaxyr;
  string14 inputaddrtaxmarketvalue;
  string14 inputaddravmtax;
  string14 inputaddravmsalesprice;
  string14 inputaddravmhedonic;
  string14 inputaddravmvalue;
  string3 inputaddravmconfidence;
  string8 inputaddrcountyindex;
  string8 inputaddrtractindex;
  string8 inputaddrblockindex;
  string4 curraddrtaxyr;
  string14 curraddrtaxmarketvalue;
  string14 curraddravmtax;
  string14 curraddravmsalesprice;
  string14 curraddravmhedonic;
  string14 curraddravmvalue;
  string3 curraddravmconfidence;
  string8 curraddrcountyindex;
  string8 curraddrtractindex;
  string8 curraddrblockindex;
  string4 prevaddrtaxyr;
  string14 prevaddrtaxmarketvalue;
  string14 prevaddravmtax;
  string14 prevaddravmsalesprice;
  string14 prevaddravmhedonic;
  string14 prevaddravmvalue;
  string3 prevaddravmconfidence;
  string8 prevaddrcountyindex;
  string8 prevaddrtractindex;
  string8 prevaddrblockindex;
  string1 educationattendedcollege;
  string1 educationprogram2yr;
  string1 educationprogram4yr;
  string1 educationprogramgraduate;
  string1 educationinstitutionprivate;
  string1 educationinstitutionrating;
  string predictedannualincome;
  string14 propnewestsaleprice;
  string8 propnewestsalepurchaseindex;
  string3 subprimesolicitedcount;
  string3 subprimesolicitedcount01;
  string3 subprimesolicitedcount03;
  string3 subprimesolicitedcount06;
  string3 subprimesolicitedcount12;
  string3 subprimesolicitedcount24;
  string3 subprimesolicitedcount36;
  string3 subprimesolicitedcount60;
  string14 lienfederaltaxfiledtotal;
  string14 lientaxotherfiledtotal;
  string14 lienforeclosurefiledtotal;
  string14 lienpreforeclosurefiledtotal;
  string14 lienlandlordtenantfiledtotal;
  string14 lienjudgmentfiledtotal;
  string14 liensmallclaimsfiledtotal;
  string14 lienotherfiledtotal;
  string14 lienfederaltaxreleasedtotal;
  string14 lientaxotherreleasedtotal;
  string14 lienforeclosurereleasedtotal;
  string14 lienpreforeclosurereleasedtotal;
  string14 lienlandlordtenantreleasedtotal;
  string14 lienjudgmentreleasedtotal;
  string14 liensmallclaimsreleasedtotal;
  string14 lienotherreleasedtotal;
  string3 lienfederaltaxfiledcount;
  string3 lientaxotherfiledcount;
  string3 lienforeclosurefiledcount;
  string3 lienpreforeclosurefiledcount;
  string3 lienlandlordtenantfiledcount;
  string3 lienjudgmentfiledcount;
  string3 liensmallclaimsfiledcount;
  string3 lienotherfiledcount;
  string3 lienfederaltaxreleasedcount;
  string3 lientaxotherreleasedcount;
  string3 lienforeclosurereleasedcount;
  string3 lienpreforeclosurereleasedcount;
  string3 lienlandlordtenantreleasedcount;
  string3 lienjudgmentreleasedcount;
  string3 liensmallclaimsreleasedcount;
  string3 lienotherreleasedcount;
  string1 proflictypecategory;
  string4 phoneedaageoldestrecord;
  string4 phoneedaagenewestrecord;
  string4 phoneotherageoldestrecord;
  string4 phoneotheragenewestrecord;
  string1 prescreenoptout;
  string6 history_date;
  string200 errorcode;
		RiskProcessing.layout_internal_extras;
end;	


just_rv_attributes_v2 := RECORD
	string12 DID;
	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
END;
ox := RECORD
	STRING30 AccountNumber;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
		RiskProcessing.layout_internal_extras;
END;
ox2 := RECORD
	STRING30 AccountNumber;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	string3 RV_score_bank;
	string3 RV_bank_reason;
	string3 RV_bank_reason2;
	string3 RV_bank_reason3;
	string3 RV_bank_reason4;
	string3 RV_bank_reason5;	
	string3 RV_score_retail;
	string3 RV_retail_reason;
	string3 RV_retail_reason2;
	string3 RV_retail_reason3;
	string3 RV_retail_reason4;
	string3 RV_retail_reason5;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	string3 RV_score_money;
	string3 RV_money_reason;
	string3 RV_money_reason2;
	string3 RV_money_reason3;
	string3 RV_money_reason4;
	string3 RV_money_reason5;
	string3 RV_score_prescreen;
	string3 RV_prescreen_reason;
		RiskProcessing.layout_internal_extras;
END;

bs_lay := RECORD
	riskprocessing.layouts.layout_internal_shell
END;

rvs4_ox := RECORD
	STRING30 AccountNumber;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	string3 RV_score_bank;
	string3 RV_bank_reason;
	string3 RV_bank_reason2;
	string3 RV_bank_reason3;
	string3 RV_bank_reason4;
	string3 RV_bank_reason5;	
	string3 RV_score_retail;
	string3 RV_retail_reason;
	string3 RV_retail_reason2;
	string3 RV_retail_reason3;
	string3 RV_retail_reason4;
	string3 RV_retail_reason5;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	string3 RV_score_money;
	string3 RV_money_reason;
	string3 RV_money_reason2;
	string3 RV_money_reason3;
	string3 RV_money_reason4;
	string3 RV_money_reason5;
	string3 RV_score_prescreen;
	string3 RV_prescreen_reason;
		RiskProcessing.layout_internal_extras;
END;
rv_attributes_v4 := RECORD
	unsigned seq;
	string30 AccountNumber;
			string3	AgeOldestRecord	;		
			string3	AgeNewestRecord	;		
			string1	RecentUpdate	;		
			string3	SrcsConfirmIDAddrCount	;		
			string2	InvalidDL	;		
			string1	VerificationFailure	;		
			string2	SSNNotFound	;		
			string1	VerifiedName	;		
			string2	VerifiedSSN	;		
			string2	VerifiedPhone	;		
			string2	VerifiedAddress	;		
			string2	VerifiedDOB	;		
			string3	InferredMinimumAge	;		
			string3	BestReportedAge	;		
			string3	SubjectSSNCount	;		
			string3	SubjectAddrCount	;		
			string3	SubjectPhoneCount	;		
			string3	SubjectSSNRecentCount	;		
			string3	SubjectAddrRecentCount	;		
			string3	SubjectPhoneRecentCount	;		
			string3	SSNIdentitiesCount	;		
			string3	SSNAddrCount	;		
			string3	SSNIdentitiesRecentCount	;		
			string3	SSNAddrRecentCount	;		
			string3	InputAddrPhoneCount	;		
			string3	InputAddrPhoneRecentCount	;		
			string3	PhoneIdentitiesCount	;		
			string3	PhoneIdentitiesRecentCount	;		
			string3	SSNAgeDeceased	;	// was named SSNDateDeceased	in version3
			string2	SSNRecent	;		
			string3	SSNLowIssueAge	;	// was named SSNLowIssueDate	in version3
			string3	SSNHighIssueAge	;	// was named SSNHighIssueDate	in version3
			string2	SSNIssueState	;		
			string2	SSNNonUS	;		
			string2	SSN3Years	;		
			string2	SSNAfter5 	;		
			string2	SSNProblems	;	// new to 4.0	
			string3	InputAddrAgeOldestRecord	;		
			string3	InputAddrAgeNewestRecord	;		
			string2	InputAddrHistoricalMatch	;	// new to 4.0	
			string3	InputAddrLenOfRes 	;		
			string2	InputAddrDwellType 	;		
			string2	InputAddrDelivery	;	// new to 4.0	
			string2	InputAddrApplicantOwned	;		
			string2	InputAddrFamilyOwned	;		
			string2	InputAddrOccupantOwned 	;		
			string3	InputAddrAgeLastSale	;		
			string10	InputAddrLastSalesPrice	;		
			string2	InputAddrMortgageType	;	// new to 4.0				
			string2	InputAddrNotPrimaryRes 	;		
			string2	InputAddrActivePhoneList 	;		
			string10	InputAddrTaxValue 	;		
			string4	InputAddrTaxYr	;		
			string10	InputAddrTaxMarketValue	;		
			string10	InputAddrAVMValue	;		
			string10	InputAddrAVMValue12	;	// new to 4.0	
			string10	InputAddrAVMValue60	;	// new to 4.0	
			string5	InputAddrCountyIndex	;		
			string5	InputAddrTractIndex	;		
			string5	InputAddrBlockIndex	;		
			string3	CurrAddrAgeOldestRecord	;		
			string3	CurrAddrAgeNewestRecord	;		
			string3	CurrAddrLenOfRes 	;		
			string2	CurrAddrDwellType 	;		
			string2	CurrAddrApplicantOwned 	;		
			string2	CurrAddrFamilyOwned 	;		
			string2	CurrAddrOccupantOwned 	;		
			string3	CurrAddrAgeLastSale	;		
			string10	CurrAddrLastSalesPrice	;		
			string2	CurrAddrMortgageType	;	// new to 4.0	
			string2	CurrAddrActivePhoneList 	;		
			string10	CurrAddrTaxValue 	;		
			string4	CurrAddrTaxYr	;		
			string10	CurrAddrTaxMarketValue	;		
			string10	CurrAddrAVMValue	;		
			string10	CurrAddrAVMValue12	;	// new to 4.0	
			string10	CurrAddrAVMValue60	;	// new to 4.0	
			string5	CurrAddrCountyIndex	;		
			string5	CurrAddrTractIndex	;		
			string5	CurrAddrBlockIndex	;		
			string3	PrevAddrAgeOldestRecord	;		
			string3	PrevAddrAgeNewestRecord	;		
			string3	PrevAddrLenOfRes 	;		
			string2	PrevAddrDwellType 	;		
			string2	PrevAddrApplicantOwned 	;		
			string2	PrevAddrFamilyOwned 	;		
			string2	PrevAddrOccupantOwned	;		
			string3	PrevAddrAgeLastSale	;		
			string10	PrevAddrLastSalesPrice	;		
			string10	PrevAddrTaxValue	;		
			string4	PrevAddrTaxYr	;		
			string10	PrevAddrTaxMarketValue	;		
			string10	PrevAddrAVMValue	;		
			string5	PrevAddrCountyIndex	;		
			string5	PrevAddrTractIndex	;		
			string5	PrevAddrBlockIndex	;		
			string4	AddrMostRecentDistance	;	// new to 4.0	
			string2	AddrMostRecentStateDiff	;	// new to 4.0	
			string11	AddrMostRecentTaxDiff	;	// new to 4.0	
			string3	AddrMostRecentMoveAge	;	// new to 4.0				
			string2	AddrRecentEconTrajectory	;	// new to 4.0	
			string2	AddrRecentEconTrajectoryIndex	;	// new to 4.0	
			string1	EducationAttendedCollege	;		
			string2	EducationProgram2Yr	;		
			string2	EducationProgram4Yr	;		
			string2	EducationProgramGraduate	;		
			string2	EducationInstitutionPrivate	;		
			string2	EducationFieldofStudyType	;	// new to 4.0	
			string2	EducationInstitutionRating	;		
			string1	AddrStability 	;	// is this the new addrstabilityv2 model or old model?	
			string2	StatusMostRecent 	;		
			string2	StatusPrevious 	;		
			string2	StatusNextPrevious	;		
			string3	AddrChangeCount01	;		
			string3	AddrChangeCount03	;		
			string3	AddrChangeCount06	;		
			string3	AddrChangeCount12	;		
			string3	AddrChangeCount24 	;		
			string3	AddrChangeCount60 	;		
			string10	EstimatedAnnualIncome	;	// was named PredictedAnnualIncome	in version3
			string1	PropertyOwner	;	// new to 4.0	
			string3	PropOwnedCount	;		
			string10	PropOwnedTaxTotal	;		
			string3	PropOwnedHistoricalCount	;		
			string3	PropAgeOldestPurchase	;		
			string3	PropAgeNewestPurchase	;		
			string3	PropAgeNewestSale	;		
			string10	PropNewestSalePrice	;		
			string5	PropNewestSalePurchaseIndex	;		
			string3	PropPurchasedCount01	;		
			string3	PropPurchasedCount03	;		
			string3	PropPurchasedCount06	;		
			string3	PropPurchasedCount12	;		
			string3	PropPurchasedCount24	;		
			string3	PropPurchasedCount60	;		
			string3	PropSoldCount01	;		
			string3	PropSoldCount03	;		
			string3	PropSoldCount06	;		
			string3	PropSoldCount12	;		
			string3	PropSoldCount24 	;		
			string3	PropSoldCount60 	;		
			string1	AssetOwner	;	// new to 4.0	
			string1	WatercraftOwner	;	// new to 4.0	
			string3	WatercraftCount	;		
			string3	WatercraftCount01	;		
			string3	WatercraftCount03	;		
			string3	WatercraftCount06	;		
			string3	WatercraftCount12 	;		
			string3	WatercraftCount24	;		
			string3	WatercraftCount60 	;		
			string1	AircraftOwner	;	// new to 4.0	
			string3	AircraftCount	;		
			string3	AircraftCount01	;		
			string3	AircraftCount03	;		
			string3	AircraftCount06	;		
			string3	AircraftCount12 	;		
			string3	AircraftCount24	;		
			string3	AircraftCount60 	;		
			string2	WealthIndex 	;		
			string2	BusinessActiveAssociation	;	// new to 4.0	
			string2	BusinessInactiveAssociation	;	// new to 4.0	
			string3	BusinessAssociationAge	;	// new to 4.0	
			string100	BusinessTitle	;	// new to 4.0	
			string1	DerogSeverityIndex	;	// new to 4.0	
			string3	DerogCount	;		
			string3	DerogRecentCount	;	// new to 4.0	
			string3	DerogAge	;		
			string3	FelonyCount	;		
			string3	FelonyAge	;		
			string3	FelonyCount01	;		
			string3	FelonyCount03	;		
			string3	FelonyCount06	;		
			string3	FelonyCount12	;		
			string3	FelonyCount24	;		
			string3	FelonyCount60	;		
			string3	LienCount	;		
			string3	LienFiledCount	;		
			string3	LienFiledAge	;		
			string3	LienFiledCount01	;		
			string3	LienFiledCount03	;		
			string3	LienFiledCount06	;		
			string3	LienFiledCount12	;		
			string3	LienFiledCount24	;		
			string3	LienFiledCount60	;		
			string3	LienReleasedCount	;		
			string3	LienReleasedAge	;		
			string3	LienReleasedCount01	;		
			string3	LienReleasedCount03	;		
			string3	LienReleasedCount06	;		
			string3	LienReleasedCount12	;		
			string3	LienReleasedCount24	;		
			string3	LienReleasedCount60	;		
			string10	LienFiledTotal	;	// new to 4.0	
			string10	LienFederalTaxFiledTotal	;		
			string10	LienTaxOtherFiledTotal	;		
			string10	LienForeclosureFiledTotal	;		
			string10	LienLandlordTenantFiledTotal	;		
			string10	LienJudgmentFiledTotal	;		
			string10	LienSmallClaimsFiledTotal	;		
			string10	LienOtherFiledTotal	;		
			string10	LienReleasedTotal	;	// new to 4.0	
			string10	LienFederalTaxReleasedTotal	;		
			string10	LienTaxOtherReleasedTotal	;		
			string10	LienForeclosureReleasedTotal	;		
			string10	LienLandlordTenantReleasedTotal	;		
			string10	LienJudgmentReleasedTotal	;		
			string10	LienSmallClaimsReleasedTotal	;		
			string10	LienOtherReleasedTotal	;		
			string3	LienFederalTaxFiledCount	;		
			string3	LienTaxOtherFiledCount	;		
			string3	LienForeclosureFiledCount	;		
			string3	LienLandlordTenantFiledCount	;		
			string3	LienJudgmentFiledCount	;		
			string3	LienSmallClaimsFiledCount	;		
			string3	LienOtherFiledCount	;		
			string3	LienFederalTaxReleasedCount	;		
			string3	LienTaxOtherReleasedCount	;		
			string3	LienForeclosureReleasedCount	;		
			string3	LienLandlordTenantReleasedCount	;		
			string3	LienJudgmentReleasedCount	;		
			string3	LienSmallClaimsReleasedCount	;		
			string3	LienOtherReleasedCount	;		
			string3	BankruptcyCount	;		
			string3	BankruptcyAge	;		
			string3	BankruptcyType	;		
			string35	BankruptcyStatus	;		
			string3	BankruptcyCount01	;		
			string3	BankruptcyCount03	;		
			string3	BankruptcyCount06	;		
			string3	BankruptcyCount12	;		
			string3	BankruptcyCount24	;		
			string3	BankruptcyCount60	;		
			string3	EvictionCount	;		
			string3	EvictionAge	;		
			string3	EvictionCount01	;		
			string3	EvictionCount03	;		
			string3	EvictionCount06	;		
			string3	EvictionCount12 	;		
			string3	EvictionCount24 	;		
			string3	EvictionCount60 	;		
			string2	RecentActivityIndex	;	// new to 4.0	
			string3	NonDerogCount	;		
			string3	NonDerogCount01	;		
			string3	NonDerogCount03	;		
			string3	NonDerogCount06	;		
			string3	NonDerogCount12	;		
			string3	NonDerogCount24	;		
			string3	NonDerogCount60	;		
			string1	VoterRegistrationRecord	;	// new to 4.0	
			string3	ProfLicCount	;		
			string3	ProfLicAge	;		
			string60	ProfLicType	;		
			string2	ProfLicTypeCategory	;		
			string2	ProfLicExpired	;	// was named ProfLicExpireDate	in version3, changed to a boolean
			string3	ProfLicCount01	;		
			string3	ProfLicCount03	;		
			string3	ProfLicCount06	;		
			string3	ProfLicCount12	;		
			string3	ProfLicCount24	;		
			string3	ProfLicCount60	;		
			string1	InquiryCollectionsRecent	;	// new to 4.0	
			string1	InquiryPersonalFinanceRecent	;	// new to 4.0	
			string1	InquiryOtherRecent	;	// new to 4.0	
			string1	HighRiskCreditActivity	;	// new to 4.0	
			string3	SubPrimeOfferRequestCount	;	// was named SubPrimeSolicitedCount	in version3
			string3	SubPrimeOfferRequestCount01	;	// was named SubPrimeSolicitedCount01	in version3
			string3	SubPrimeOfferRequestCount03	;	// was named SubprimeSolicitedCount03	in version3
			string3	SubPrimeOfferRequestCount06	;	// was named SubprimeSolicitedCount06	in version3
			string3	SubPrimeOfferRequestCount12	;	// was named SubPrimeSolicitedCount12	in version3
			string3	SubPrimeOfferRequestCount24	;	// was named SubPrimeSolicitedCount24	in version3
			string3	SubPrimeOfferRequestCount60	;	// was named SubPrimeSolicitedCount60	in version3
			string2	InputPhoneMobile 	;		
			string3	PhoneEDAAgeOldestRecord	;		
			string3	PhoneEDAAgeNewestRecord	;		
			string3	PhoneOtherAgeOldestRecord	;		
			string3	PhoneOtherAgeNewestRecord	;		
			string2	InputPhoneHighRisk	;		
			string2	InputPhoneProblems	;	// new to 4.0	
			string2	EmailAddress	;	// new to 4.0	
			string2	InputAddrHighRisk	;			
			string2	CurrAddrCorrectional	;	// new to 4.0	
			string2	PrevAddrCorrectional	;	// new to 4.0	
			string2	HistoricalAddrCorrectional	;	// new to 4.0	
			string2	InputAddrProblems	;	// new to 4.0	
			string1	SecurityFreeze	;		
			string1	SecurityAlert	;		
			string1	IDTheftFlag	;		
			string1	ConsumerStatement	;	// new to 4.0	
			string2	PrescreenOptOut	;			
	RiskProcessing.layout_internal_extras;
	string200 errorcode;
END;
just_rv_attributes_v4 := RECORD
	string12 DID;
	string30 AccountNumber;

string3	 v4_AgeOldestRecord;
string3	 v4_AgeNewestRecord;
string1	 v4_RecentUpdate;
string3	 v4_SrcsConfirmIDAddrCount;
string2	 v4_InvalidDL;
string1	 v4_VerificationFailure;
string2	 v4_SSNNotFound;
string1	 v4_VerifiedName;
string2	 v4_VerifiedSSN;
string2	 v4_VerifiedPhone;
string2	 v4_VerifiedAddress;
string2	 v4_VerifiedDOB;
string3	 v4_InferredMinimumAge;
string3	 v4_BestReportedAge;
string3	 v4_SubjectSSNCount;
string3	 v4_SubjectAddrCount;
string3	 v4_SubjectPhoneCount;
string3	 v4_SubjectSSNRecentCount;
string3	 v4_SubjectAddrRecentCount;
string3	 v4_SubjectPhoneRecentCount;
string3	 v4_SSNIdentitiesCount;
string3	 v4_SSNAddrCount;
string3	 v4_SSNIdentitiesRecentCount;
string3	 v4_SSNAddrRecentCount;
string3	 v4_InputAddrPhoneCount;
string3	 v4_InputAddrPhoneRecentCount;
string3	 v4_PhoneIdentitiesCount;
string3	 v4_PhoneIdentitiesRecentCount;
string3	 v4_SSNAgeDeceased;	 // was named SSNDateDeceased	 in version3
string2	 v4_SSNRecent;
string3	 v4_SSNLowIssueAge;	 // was named SSNLowIssueDate	 in version3
string3	 v4_SSNHighIssueAge;	 // was named SSNHighIssueDate	 in version3
string2	 v4_SSNIssueState;
string2	 v4_SSNNonUS;
string2	 v4_SSN3Years;
string2	 v4_SSNAfter5 ;
string2	 v4_SSNProblems;	 // new to 4.0	
string3	 v4_InputAddrAgeOldestRecord;
string3	 v4_InputAddrAgeNewestRecord;
string2	 v4_InputAddrHistoricalMatch;	// new to 4.0	
string3	 v4_InputAddrLenOfRes ;
string2	 v4_InputAddrDwellType ;
string2	 v4_InputAddrDelivery;	 // new to 4.0	
string2	 v4_InputAddrApplicantOwned;
string2	 v4_InputAddrFamilyOwned;
string2	 v4_InputAddrOccupantOwned ;
string3	 v4_InputAddrAgeLastSale;
string10	 v4_InputAddrLastSalesPrice;
string2	 v4_InputAddrMortgageType;	 // new to 4.0	
string2	 v4_InputAddrNotPrimaryRes ;
string2	 v4_InputAddrActivePhoneList ;
string10	 v4_InputAddrTaxValue ;
string4	 v4_InputAddrTaxYr;
string10	 v4_InputAddrTaxMarketValue;
string10	 v4_InputAddrAVMValue;
string10	 v4_InputAddrAVMValue12;	 // new to 4.0	
string10	 v4_InputAddrAVMValue60;	 // new to 4.0	
string5	 v4_InputAddrCountyIndex;
string5	 v4_InputAddrTractIndex;
string5	 v4_InputAddrBlockIndex;
string3	 v4_CurrAddrAgeOldestRecord;
string3	 v4_CurrAddrAgeNewestRecord;
string3	 v4_CurrAddrLenOfRes ;
string2	 v4_CurrAddrDwellType ;
string2	 v4_CurrAddrApplicantOwned ;
string2	 v4_CurrAddrFamilyOwned ;
string2	 v4_CurrAddrOccupantOwned ;
string3	 v4_CurrAddrAgeLastSale;
string10	 v4_CurrAddrLastSalesPrice;
string2	 v4_CurrAddrMortgageType;	 // new to 4.0	
string2	 v4_CurrAddrActivePhoneList ;
string10	 v4_CurrAddrTaxValue ;
string4	 v4_CurrAddrTaxYr;
string10	 v4_CurrAddrTaxMarketValue;
string10	 v4_CurrAddrAVMValue;
string10	 v4_CurrAddrAVMValue12;	 // new to 4.0	
string10	 v4_CurrAddrAVMValue60;	 // new to 4.0	
string5	 v4_CurrAddrCountyIndex;
string5	 v4_CurrAddrTractIndex;
string5	 v4_CurrAddrBlockIndex;
string3	 v4_PrevAddrAgeOldestRecord;
string3	 v4_PrevAddrAgeNewestRecord;
string3	 v4_PrevAddrLenOfRes ;
string2	 v4_PrevAddrDwellType ;
string2	 v4_PrevAddrApplicantOwned ;
string2	 v4_PrevAddrFamilyOwned ;
string2	 v4_PrevAddrOccupantOwned;
string3	 v4_PrevAddrAgeLastSale;
string10	 v4_PrevAddrLastSalesPrice;
string10	 v4_PrevAddrTaxValue;
string4	 v4_PrevAddrTaxYr;
string10	 v4_PrevAddrTaxMarketValue;
string10	 v4_PrevAddrAVMValue;
string5	 v4_PrevAddrCountyIndex;
string5	 v4_PrevAddrTractIndex;
string5	 v4_PrevAddrBlockIndex;
string4	 v4_AddrMostRecentDistance;	 // new to 4.0	
string2	 v4_AddrMostRecentStateDiff;	 // new to 4.0	
string11	 v4_AddrMostRecentTaxDiff;	 // new to 4.0	
string3	 v4_AddrMostRecentMoveAge;	 // new to 4.0	
string2	 v4_AddrRecentEconTrajectory;	 // new to 4.0	
string2	 v4_AddrRecentEconTrajectoryIndex;	 // new to 4.0	
string1	 v4_EducationAttendedCollege;
string2	 v4_EducationProgram2Yr;
string2	 v4_EducationProgram4Yr;
string2	 v4_EducationProgramGraduate;
string2	 v4_EducationInstitutionPrivate;
string2	 v4_EducationFieldofStudyType;	 // new to 4.0	
string2	 v4_EducationInstitutionRating;
string1	 v4_AddrStability ;	 // is this the new addrstabilityv2 model or old model?	 
string2	 v4_StatusMostRecent ;
string2	 v4_StatusPrevious ;
string2	 v4_StatusNextPrevious;
string3	 v4_AddrChangeCount01;
string3	 v4_AddrChangeCount03;
string3	 v4_AddrChangeCount06;
string3	 v4_AddrChangeCount12;
string3	 v4_AddrChangeCount24 ;
string3	 v4_AddrChangeCount60 ;
string10	 v4_EstimatedAnnualIncome;	 // was named PredictedAnnualIncome	 in version3
string1	 v4_PropertyOwner;	 // new to 4.0	
string3	 v4_PropOwnedCount;
string10	 v4_PropOwnedTaxTotal;
string3	 v4_PropOwnedHistoricalCount;
string3	 v4_PropAgeOldestPurchase;
string3	 v4_PropAgeNewestPurchase;
string3	 v4_PropAgeNewestSale;
string10	 v4_PropNewestSalePrice;
string5	 v4_PropNewestSalePurchaseIndex;
string3	 v4_PropPurchasedCount01;
string3	 v4_PropPurchasedCount03;
string3	 v4_PropPurchasedCount06;
string3	 v4_PropPurchasedCount12;
string3	 v4_PropPurchasedCount24;
string3	 v4_PropPurchasedCount60;
string3	 v4_PropSoldCount01;
string3	 v4_PropSoldCount03;
string3	 v4_PropSoldCount06;
string3	 v4_PropSoldCount12;
string3	 v4_PropSoldCount24 ;
string3	 v4_PropSoldCount60 ;
string1	 v4_AssetOwner;	 // new to 4.0	
string1	 v4_WatercraftOwner;	 // new to 4.0	
string3	 v4_WatercraftCount;
string3	 v4_WatercraftCount01;
string3	 v4_WatercraftCount03;
string3	 v4_WatercraftCount06;
string3	 v4_WatercraftCount12 ;
string3	 v4_WatercraftCount24;
string3	 v4_WatercraftCount60 ;
string1	 v4_AircraftOwner;	 // new to 4.0	
string3	 v4_AircraftCount;
string3	 v4_AircraftCount01;
string3	 v4_AircraftCount03;
string3	 v4_AircraftCount06;
string3	 v4_AircraftCount12 ;
string3	 v4_AircraftCount24;
string3	 v4_AircraftCount60 ;
string2	 v4_WealthIndex ;
string2	 v4_BusinessActiveAssociation;	 // new to 4.0	
string2	 v4_BusinessInactiveAssociation;	 // new to 4.0	
string3	 v4_BusinessAssociationAge;	 // new to 4.0	
string100	 v4_BusinessTitle;	 // new to 4.0	
string1	 v4_DerogSeverityIndex;	 // new to 4.0	
string3	 v4_DerogCount;
string3	 v4_DerogRecentCount;	 // new to 4.0	
string3	 v4_DerogAge;
string3	 v4_FelonyCount;
string3	 v4_FelonyAge;
string3	 v4_FelonyCount01;
string3	 v4_FelonyCount03;
string3	 v4_FelonyCount06;
string3	 v4_FelonyCount12;
string3	 v4_FelonyCount24;
string3	 v4_FelonyCount60;
string3	 v4_LienCount;
string3	 v4_LienFiledCount;
string3	 v4_LienFiledAge;
string3	 v4_LienFiledCount01;
string3	 v4_LienFiledCount03;
string3	 v4_LienFiledCount06;
string3	 v4_LienFiledCount12;
string3	 v4_LienFiledCount24;
string3	 v4_LienFiledCount60;
string3	 v4_LienReleasedCount;
string3	 v4_LienReleasedAge;
string3	 v4_LienReleasedCount01;
string3	 v4_LienReleasedCount03;
string3	 v4_LienReleasedCount06;
string3	 v4_LienReleasedCount12;
string3	 v4_LienReleasedCount24;
string3	 v4_LienReleasedCount60;
string10	 v4_LienFiledTotal;	 // new to 4.0	
string10	 v4_LienFederalTaxFiledTotal;
string10	 v4_LienTaxOtherFiledTotal;
string10	 v4_LienForeclosureFiledTotal;
string10	 v4_LienLandlordTenantFiledTotal;
string10	 v4_LienJudgmentFiledTotal;
string10	 v4_LienSmallClaimsFiledTotal;
string10	 v4_LienOtherFiledTotal;
string10	 v4_LienReleasedTotal;	 // new to 4.0	
string10	 v4_LienFederalTaxReleasedTotal;
string10	 v4_LienTaxOtherReleasedTotal;
string10	 v4_LienForeclosureReleasedTotal;
string10	 v4_LienLandlordTenantReleasedTotal;
string10	 v4_LienJudgmentReleasedTotal;
string10	 v4_LienSmallClaimsReleasedTotal;
string10	 v4_LienOtherReleasedTotal;
string3	 v4_LienFederalTaxFiledCount;
string3	 v4_LienTaxOtherFiledCount;
string3	 v4_LienForeclosureFiledCount;
string3	 v4_LienLandlordTenantFiledCount;
string3	 v4_LienJudgmentFiledCount;
string3	 v4_LienSmallClaimsFiledCount;
string3	 v4_LienOtherFiledCount;
string3	 v4_LienFederalTaxReleasedCount;
string3	 v4_LienTaxOtherReleasedCount;
string3	 v4_LienForeclosureReleasedCount;
string3	 v4_LienLandlordTenantReleasedCount;
string3	 v4_LienJudgmentReleasedCount;
string3	 v4_LienSmallClaimsReleasedCount;
string3	 v4_LienOtherReleasedCount;
string3	 v4_BankruptcyCount;
string3	 v4_BankruptcyAge;
string3	 v4_BankruptcyType;
string35	 v4_BankruptcyStatus;
string3	 v4_BankruptcyCount01;
string3	 v4_BankruptcyCount03;
string3	 v4_BankruptcyCount06;
string3	 v4_BankruptcyCount12;
string3	 v4_BankruptcyCount24;
string3	 v4_BankruptcyCount60;
string3	 v4_EvictionCount;
string3	 v4_EvictionAge;
string3	 v4_EvictionCount01;
string3	 v4_EvictionCount03;
string3	 v4_EvictionCount06;
string3	 v4_EvictionCount12 ;
string3	 v4_EvictionCount24 ;
string3	 v4_EvictionCount60 ;
string2	 v4_RecentActivityIndex;	 // new to 4.0	
string3	 v4_NonDerogCount;
string3	 v4_NonDerogCount01;
string3	 v4_NonDerogCount03;
string3	 v4_NonDerogCount06;
string3	 v4_NonDerogCount12;
string3	 v4_NonDerogCount24;
string3	 v4_NonDerogCount60;
string1	 v4_VoterRegistrationRecord;	 // new to 4.0	
string3	 v4_ProfLicCount;
string3	 v4_ProfLicAge;
string60	 v4_ProfLicType;
string2	 v4_ProfLicTypeCategory;
string2	 v4_ProfLicExpired;	 // was named ProfLicExpireDate	 in version3, changed to a boolean
string3	 v4_ProfLicCount01;
string3	 v4_ProfLicCount03;
string3	 v4_ProfLicCount06;
string3	 v4_ProfLicCount12;
string3	 v4_ProfLicCount24;
string3	 v4_ProfLicCount60;
string1	 v4_InquiryCollectionsRecent;	 // new to 4.0	
string1	 v4_InquiryPersonalFinanceRecent;  // new to 4.0	
string1	 v4_InquiryOtherRecent;	 // new to 4.0	
string1	 v4_HighRiskCreditActivity;	 // new to 4.0	
string3	 v4_SubPrimeOfferRequestCount;	 // was named SubPrimeSolicitedCount	 in version3
string3	 v4_SubPrimeOfferRequestCount01;	 // was named SubPrimeSolicitedCount01	 in version3
string3	 v4_SubPrimeOfferRequestCount03;	 // was named SubprimeSolicitedCount03	 in version3
string3	 v4_SubPrimeOfferRequestCount06;	 // was named SubprimeSolicitedCount06	 in version3
string3	 v4_SubPrimeOfferRequestCount12;	 // was named SubPrimeSolicitedCount12	 in version3
string3	 v4_SubPrimeOfferRequestCount24;	 // was named SubPrimeSolicitedCount24	 in version3
string3	 v4_SubPrimeOfferRequestCount60;	 // was named SubPrimeSolicitedCount60	 in version3
string2	 v4_InputPhoneMobile ;
string3	 v4_PhoneEDAAgeOldestRecord;
string3	 v4_PhoneEDAAgeNewestRecord;
string3	 v4_PhoneOtherAgeOldestRecord;
string3	 v4_PhoneOtherAgeNewestRecord;
string2	 v4_InputPhoneHighRisk;
string2	 v4_InputPhoneProblems;	 // new to 4.0	
string2	 v4_EmailAddress;	 // new to 4.0	
string2	 v4_InputAddrHighRisk;
string2	 v4_CurrAddrCorrectional;	 // new to 4.0	
string2	 v4_PrevAddrCorrectional;	 // new to 4.0	
string2	 v4_HistoricalAddrCorrectional;	 // new to 4.0	
string2	 v4_InputAddrProblems;	 // new to 4.0	
string1	 v4_SecurityFreeze;
string1	 v4_SecurityAlert;
string1	 v4_IDTheftFlag;
string1	 v4_ConsumerStatement;	 // new to 4.0	
string2	 v4_PrescreenOptOut;
			string6 history_date;
      string200 errorcode;
 END;


just_rv_attributes_v3 := RECORD
	string12 DID;
	string30 AccountNumber;

 
  string4 ageoldestrecord;
  string4 agenewestrecord;
  string1 isrecentupdate;
  string3 numsources;
  string1 verifiedphonefullname;
  string1 verifiedphonelastname;
  string1 invalidssn;
  string1 invalidphone;
  string1 invalidaddr;
  string1 invaliddl;
  string1 isnover;
  string1 ssndeceased;
  string8 deceaseddate;
  string1 ssnvalid;
  string1 recentissue;
  string8 lowissuedate;
  string8 highissuedate;
  string2 issuestate;
  string1 nonus;
  string1 issued3;
  string1 issuedage5;
  string4 iaageoldestrecord;
  string4 iaagenewestrecord;
  string4 ialenofres;
  string1 iadwelltype;
  string1 ialandusecode;
  string iaassessedvalue;
  string1 iaownedbysubject;
  string1 iafamilyowned;
  string1 iaoccupantowned;
  string4 iaagelastsale;
  string ialastsaleamount;
  string1 ianotprimaryres;
  string1 iaphonelisted;
  string10 iaphonenumber;
  string4 caageoldestrecord;
  string4 caagenewestrecord;
  string4 calenofres;
  string1 cadwelltype;
  string1 calandusecode;
  string caassessedvalue;
  string1 caownedbysubject;
  string1 cafamilyowned;
  string1 caoccupantowned;
  string4 caagelastsale;
  string calastsaleamount;
  string1 canotprimaryres;
  string1 caphonelisted;
  string10 caphonenumber;
  string4 paageoldestrecord;
  string4 paagenewestrecord;
  string4 palenofres;
  string1 padwelltype;
  string1 palandusecode;
  string paassessedvalue;
  string1 paownedbysubject;
  string1 pafamilyowned;
  string1 paoccupantowned;
  string4 paagelastsale;
  string palastsaleamount;
  string1 paphonelisted;
  string10 paphonenumber;
  string1 inputcurrmatch;
  string distinputcurr;
  string1 diffstate;
  string assesseddiff;
  string2 ecotrajectory;
  string1 inputprevmatch;
  string distcurrprev;
  string1 diffstate2;
  string assesseddiff2;
  string2 ecotrajectory2;
  string1 mobility_indicator;
  string1 statusaddr;
  string1 statusaddr2;
  string1 statusaddr3;
  string3 addrchanges30;
  string3 addrchanges90;
  string3 addrchanges180;
  string3 addrchanges12;
  string3 addrchanges24;
  string3 addrchanges36;
  string3 addrchanges60;
  string3 property_owned_total;
  string14 property_owned_assessed_total;
  string3 property_historically_owned;
  string4 propageoldestpurchase;
  string4 propagenewestpurchase;
  string4 propagenewestsale;
  string3 numpurchase30;
  string3 numpurchase90;
  string3 numpurchase180;
  string3 numpurchase12;
  string3 numpurchase24;
  string3 numpurchase36;
  string3 numpurchase60;
  string3 numsold30;
  string3 numsold90;
  string3 numsold180;
  string3 numsold12;
  string3 numsold24;
  string3 numsold36;
  string3 numsold60;
  string3 numwatercraft;
  string3 numwatercraft30;
  string3 numwatercraft90;
  string3 numwatercraft180;
  string3 numwatercraft12;
  string3 numwatercraft24;
  string3 numwatercraft36;
  string3 numwatercraft60;
  string3 numaircraft;
  string3 numaircraft30;
  string3 numaircraft90;
  string3 numaircraft180;
  string3 numaircraft12;
  string3 numaircraft24;
  string3 numaircraft36;
  string3 numaircraft60;
  string1 wealth_indicator;
  string3 total_number_derogs;
  string4 derogage;
  string3 felonies;
  string4 felonyage;
  string3 felonies30;
  string3 felonies90;
  string3 felonies180;
  string3 felonies12;
  string3 felonies24;
  string3 felonies36;
  string3 felonies60;
  string3 num_liens;
  string3 num_unreleased_liens;
  string4 lienfiledage;
  string3 num_unreleased_liens30;
  string3 num_unreleased_liens90;
  string3 num_unreleased_liens180;
  string3 num_unreleased_liens12;
  string3 num_unreleased_liens24;
  string3 num_unreleased_liens36;
  string3 num_unreleased_liens60;
  string3 num_released_liens;
  string4 lienreleasedage;
  string3 num_released_liens30;
  string3 num_released_liens90;
  string3 num_released_liens180;
  string3 num_released_liens12;
  string3 num_released_liens24;
  string3 num_released_liens36;
  string3 num_released_liens60;
  string3 bankruptcy_count;
  string4 bankruptcyage;
  string1 filing_type;
  string35 disposition;
  string3 bankruptcy_count30;
  string3 bankruptcy_count90;
  string3 bankruptcy_count180;
  string3 bankruptcy_count12;
  string3 bankruptcy_count24;
  string3 bankruptcy_count36;
  string3 bankruptcy_count60;
  string3 eviction_count;
  string4 evictionage;
  string3 eviction_count30;
  string3 eviction_count90;
  string3 eviction_count180;
  string3 eviction_count12;
  string3 eviction_count24;
  string3 eviction_count36;
  string3 eviction_count60;
  string3 num_nonderogs;
  string3 num_nonderogs30;
  string3 num_nonderogs90;
  string3 num_nonderogs180;
  string3 num_nonderogs12;
  string3 num_nonderogs24;
  string3 num_nonderogs36;
  string3 num_nonderogs60;
  string3 num_proflic;
  string4 proflicage;
  string60 proflic_type;
  string8 expire_date_last_proflic;
  string3 num_proflic30;
  string3 num_proflic90;
  string3 num_proflic180;
  string3 num_proflic12;
  string3 num_proflic24;
  string3 num_proflic36;
  string3 num_proflic60;
  string3 num_proflic_exp30;
  string3 num_proflic_exp90;
  string3 num_proflic_exp180;
  string3 num_proflic_exp12;
  string3 num_proflic_exp24;
  string3 num_proflic_exp36;
  string3 num_proflic_exp60;
  string1 addrhighrisk;
  string1 phonehighrisk;
  string1 addrprison;
  string1 zippobox;
  string1 zipcorpmil;
  string1 phonestatus;
  string1 phonepager;
  string1 phonemobile;
  string1 phonezipmismatch;
  string4 phoneaddrdist;
  string1 correctedflag;
  string1 securityfreeze;
  string1 securityalert;
  string1 idtheftflag;
  string1 ssnnotfound;
  string3 verifiedname;
  string3 verifiedssn;
  string3 verifiedphone;
  string3 verifiedaddress;
  string3 verifieddob;
  string3 inferredminimumage;
  string3 bestreportedage;
  string3 subjectssncount;
  string3 subjectaddrcount;
  string3 subjectphonecount;
  string3 subjectssnrecentcount;
  string3 subjectaddrrecentcount;
  string3 subjectphonerecentcount;
  string3 ssnidentitiescount;
  string3 ssnaddrcount;
  string3 ssnidentitiesrecentcount;
  string3 ssnaddrrecentcount;
  string3 inputaddridentitiescount;
  string3 inputaddrssncount;
  string3 inputaddrphonecount;
  string3 inputaddridentitiesrecentcount;
  string3 inputaddrssnrecentcount;
  string3 inputaddrphonerecentcount;
  string3 phoneidentitiescount;
  string3 phoneidentitiesrecentcount;
  string1 ssnissuedpriordob;
  string4 inputaddrtaxyr;
  string14 inputaddrtaxmarketvalue;
  string14 inputaddravmtax;
  string14 inputaddravmsalesprice;
  string14 inputaddravmhedonic;
  string14 inputaddravmvalue;
  string3 inputaddravmconfidence;
  string8 inputaddrcountyindex;
  string8 inputaddrtractindex;
  string8 inputaddrblockindex;
  string4 curraddrtaxyr;
  string14 curraddrtaxmarketvalue;
  string14 curraddravmtax;
  string14 curraddravmsalesprice;
  string14 curraddravmhedonic;
  string14 curraddravmvalue;
  string3 curraddravmconfidence;
  string8 curraddrcountyindex;
  string8 curraddrtractindex;
  string8 curraddrblockindex;
  string4 prevaddrtaxyr;
  string14 prevaddrtaxmarketvalue;
  string14 prevaddravmtax;
  string14 prevaddravmsalesprice;
  string14 prevaddravmhedonic;
  string14 prevaddravmvalue;
  string3 prevaddravmconfidence;
  string8 prevaddrcountyindex;
  string8 prevaddrtractindex;
  string8 prevaddrblockindex;
  string1 educationattendedcollege;
  string1 educationprogram2yr;
  string1 educationprogram4yr;
  string1 educationprogramgraduate;
  string1 educationinstitutionprivate;
  string1 educationinstitutionrating;
  string predictedannualincome;
  string14 propnewestsaleprice;
  string8 propnewestsalepurchaseindex;
  string3 subprimesolicitedcount;
  string3 subprimesolicitedcount01;
  string3 subprimesolicitedcount03;
  string3 subprimesolicitedcount06;
  string3 subprimesolicitedcount12;
  string3 subprimesolicitedcount24;
  string3 subprimesolicitedcount36;
  string3 subprimesolicitedcount60;
  string14 lienfederaltaxfiledtotal;
  string14 lientaxotherfiledtotal;
  string14 lienforeclosurefiledtotal;
  string14 lienpreforeclosurefiledtotal;
  string14 lienlandlordtenantfiledtotal;
  string14 lienjudgmentfiledtotal;
  string14 liensmallclaimsfiledtotal;
  string14 lienotherfiledtotal;
  string14 lienfederaltaxreleasedtotal;
  string14 lientaxotherreleasedtotal;
  string14 lienforeclosurereleasedtotal;
  string14 lienpreforeclosurereleasedtotal;
  string14 lienlandlordtenantreleasedtotal;
  string14 lienjudgmentreleasedtotal;
  string14 liensmallclaimsreleasedtotal;
  string14 lienotherreleasedtotal;
  string3 lienfederaltaxfiledcount;
  string3 lientaxotherfiledcount;
  string3 lienforeclosurefiledcount;
  string3 lienpreforeclosurefiledcount;
  string3 lienlandlordtenantfiledcount;
  string3 lienjudgmentfiledcount;
  string3 liensmallclaimsfiledcount;
  string3 lienotherfiledcount;
  string3 lienfederaltaxreleasedcount;
  string3 lientaxotherreleasedcount;
  string3 lienforeclosurereleasedcount;
  string3 lienpreforeclosurereleasedcount;
  string3 lienlandlordtenantreleasedcount;
  string3 lienjudgmentreleasedcount;
  string3 liensmallclaimsreleasedcount;
  string3 lienotherreleasedcount;
  string1 proflictypecategory;
  string4 phoneedaageoldestrecord;
  string4 phoneedaagenewestrecord;
  string4 phoneotherageoldestrecord;
  string4 phoneotheragenewestrecord;
  string1 prescreenoptout;
  string6 history_date;
  string200 errorcode;
 END;
just_rv_att_v2 := RECORD
	string12 DID;
	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
END;

oxra := RECORD
	STRING30 AccountNumber;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
		RiskProcessing.layout_internal_extras;
END;

Experian_RVA_30_XML_ds_1 := dataset(Experian_RVA_30_XML_infile_name_1, rv_attributes_norm, csv(quote('"'), heading(1)) );
Experian_RVA_30_BATCH_ds_1 := dataset(Experian_RVA_30_BATCH_infile_name_1, rv_attributes_norm, csv(quote('"'), heading(1)) );
CapitalOne_RVAttributes_V3_ds_1 := dataset(CapitalOne_RVAttributes_V3_infile_name_1, final_layout2, csv(quote('"'), heading(1)) );
CapitalOne_RVAttributes_V2_ds_1 := dataset(CapitalOne_RVAttributes_V2_infile_name_1, final_layout, csv(quote('"'), heading(1)) );
CreditAcceptanceCorp_RV2_BATCH_ds_1 := dataset(CreditAcceptanceCorp_RV2_BATCH_infile_name_1, just_rv_attributes_v2, csv(quote('"'), heading(1)) );
T_Mobile_RVT1212_ds_1 := dataset(T_Mobile_RVT1212_infile_name_1, ox, csv(quote('"'), heading(1)) );
T_Mobile_RVT1210_ds_1 := dataset(T_Mobile_RVT1210_infile_name_1, ox, csv(quote('"'), heading(1)) );
Santander_RVA1304_1_ds_1 := dataset(Santander_RVA1304_1_infile_name_1, ox, csv(quote('"'), heading(1)) );
Santander_RVA1304_2_ds_1 := dataset(Santander_RVA1304_2_infile_name_1, ox, csv(quote('"'), heading(1)) );
RV_V3_ENOVA_XML_Scores_ds_1 := dataset(RV_V3_ENOVA_XML_Scores_infile_name_1, ox2, csv(quote('"'), heading(1)) );
RV_Scores_V4_XML_ds_1 := dataset(RV_Scores_V4_XML_infile_name_1, rvs4_ox, csv(quote('"'), heading(1)) );
RV_Scores_V3_XML_ds_1 := dataset(RV_Scores_V3_XML_infile_name_1, rvs4_ox, csv(quote('"'), heading(1)) );
RV_Attributes_V4_XML_ds_1 := dataset(RV_Attributes_V4_XML_infile_name_1, rv_attributes_v4, csv(quote('"'), heading(1)) );
RV_Attributes_V3_XML_ds_1 := dataset(RV_Attributes_V3_XML_infile_name_1, rv_attributes_norm, csv(quote('"'), heading(1)) );
RV_Attributes_V3_BATCH_ds_1 := dataset(RV_Attributes_V3_BATCH_infile_name_1, just_rv_attributes_v3, csv(quote('"'), heading(1)) );
RV_Attributes_V4_BATCH_ds_1 := dataset(RV_Attributes_V4_BATCH_infile_name_1, just_rv_attributes_v4, csv(quote('"'), heading(1)) );
RV_Attributes_V2_BATCH_ds_1 := dataset(RV_Attributes_V2_BATCH_infile_name_1, just_rv_att_v2, csv(quote('"'), heading(1)) );
RV_Scores_V4_BATCH_ds_1 := dataset(RV_Scores_V4_BATCH_infile_name_1, rvs4_ox, csv(quote('"'), heading(1)) );
RV_Scores_V3_BATCH_ds_1 := dataset(RV_Scores_V3_BATCH_infile_name_1, rvs4_ox, csv(quote('"'), heading(1)) );
Regional_Acceptance_RVA1008_1_ds_1 := dataset(Regional_Acceptance_RVA1008_1_infile_name_1, oxra, csv(quote('"'), heading(1)) );
bocashell_41_1 := dataset(bocashell_41_cert_fcra_infile_name_1, bs_lay, csv(quote('"'), heading(1)) );
bocashell_41_cert_fcra_ds_1 := project(bocashell_41_1, transform(bs_lay, self.time_ms := 0; self := left));
bocashell_50_1 := dataset(bocashell_50_cert_fcra_infile_name_1, bs_lay, csv(quote('"'), heading(1)) );
bocashell_50_cert_fcra_ds_1 := project(bocashell_50_1, transform(bs_lay, self.time_ms := 0; self := left));

Experian_RVA_30_XML_ds_2 := dataset(Experian_RVA_30_XML_infile_name_2, rv_attributes_norm, csv(quote('"'), heading(1)) );
Experian_RVA_30_BATCH_ds_2 := dataset(Experian_RVA_30_BATCH_infile_name_2, rv_attributes_norm, csv(quote('"'), heading(1)) );
CapitalOne_RVAttributes_V3_ds_2 := dataset(CapitalOne_RVAttributes_V3_infile_name_2, final_layout2, csv(quote('"'), heading(1)) );
CapitalOne_RVAttributes_V2_ds_2 := dataset(CapitalOne_RVAttributes_V2_infile_name_2, final_layout, csv(quote('"'), heading(1)) );
CreditAcceptanceCorp_RV2_BATCH_ds_2 := dataset(CreditAcceptanceCorp_RV2_BATCH_infile_name_2, just_rv_attributes_v2, csv(quote('"'), heading(1)) );
T_Mobile_RVT1212_ds_2 := dataset(T_Mobile_RVT1212_infile_name_2, ox, csv(quote('"'), heading(1)) );
T_Mobile_RVT1210_ds_2 := dataset(T_Mobile_RVT1210_infile_name_2, ox, csv(quote('"'), heading(1)) );
Santander_RVA1304_1_ds_2 := dataset(Santander_RVA1304_1_infile_name_2, ox, csv(quote('"'), heading(1)) );
Santander_RVA1304_2_ds_2 := dataset(Santander_RVA1304_2_infile_name_2, ox, csv(quote('"'), heading(1)) );
RV_V3_ENOVA_XML_Scores_ds_2 := dataset(RV_V3_ENOVA_XML_Scores_infile_name_2, ox2, csv(quote('"'), heading(1)) );
RV_Scores_V4_XML_ds_2 := dataset(RV_Scores_V4_XML_infile_name_2, rvs4_ox, csv(quote('"'), heading(1)) );
RV_Scores_V3_XML_ds_2 := dataset(RV_Scores_V3_XML_infile_name_2, rvs4_ox, csv(quote('"'), heading(1)) );
RV_Attributes_V4_XML_ds_2 := dataset(RV_Attributes_V4_XML_infile_name_2, rv_attributes_v4, csv(quote('"'), heading(1)) );
RV_Attributes_V3_XML_ds_2 := dataset(RV_Attributes_V3_XML_infile_name_2, rv_attributes_norm, csv(quote('"'), heading(1)) );
RV_Attributes_V3_BATCH_ds_2 := dataset(RV_Attributes_V3_BATCH_infile_name_2, just_rv_attributes_v3, csv(quote('"'), heading(1)) );
RV_Attributes_V4_BATCH_ds_2 := dataset(RV_Attributes_V4_BATCH_infile_name_2, just_rv_attributes_v4, csv(quote('"'), heading(1)) );
RV_Attributes_V2_BATCH_ds_2 := dataset(RV_Attributes_V2_BATCH_infile_name_2, just_rv_att_v2, csv(quote('"'), heading(1)) );
RV_Scores_V4_BATCH_ds_2 := dataset(RV_Scores_V4_BATCH_infile_name_2, rvs4_ox, csv(quote('"'), heading(1)) );
RV_Scores_V3_BATCH_ds_2 := dataset(RV_Scores_V3_BATCH_infile_name_2, rvs4_ox, csv(quote('"'), heading(1)) );
Regional_Acceptance_RVA1008_1_ds_2 := dataset(Regional_Acceptance_RVA1008_1_infile_name_2, oxra, csv(quote('"'), heading(1)) );
bocashell_41_2 := dataset(bocashell_41_cert_fcra_infile_name_2, bs_lay, csv(quote('"'), heading(1)) );
bocashell_41_cert_fcra_ds_2 := project(bocashell_41_2, transform(bs_lay, self.time_ms := 0; self := left));
bocashell_50_2 := dataset(bocashell_50_cert_fcra_infile_name_2, bs_lay, csv(quote('"'), heading(1)) );
bocashell_50_cert_fcra_ds_2 := project(bocashell_50_2, transform(bs_lay, self.time_ms := 0; self := left));

ashirey.flatten(Experian_RVA_30_XML_ds_1 , flatten_Experian_RVA_30_XML_ds_1 );
ashirey.flatten(Experian_RVA_30_BATCH_ds_1 , flatten_Experian_RVA_30_BATCH_ds_1 );
ashirey.flatten(CapitalOne_RVAttributes_V3_ds_1 , flatten_CapitalOne_RVAttributes_V3_ds_1 );
ashirey.flatten(CapitalOne_RVAttributes_V2_ds_1 , flatten_CapitalOne_RVAttributes_V2_ds_1 );
ashirey.flatten(CreditAcceptanceCorp_RV2_BATCH_ds_1 , flatten_CreditAcceptanceCorp_RV2_BATCH_ds_1 );
ashirey.flatten(T_Mobile_RVT1212_ds_1 , flatten_T_Mobile_RVT1212_ds_1 );
ashirey.flatten(T_Mobile_RVT1210_ds_1 , flatten_T_Mobile_RVT1210_ds_1 );
ashirey.flatten(Santander_RVA1304_1_ds_1 , flatten_Santander_RVA1304_1_ds_1 );
ashirey.flatten(Santander_RVA1304_2_ds_1 , flatten_Santander_RVA1304_2_ds_1 );
ashirey.flatten(RV_V3_ENOVA_XML_Scores_ds_1 , flatten_RV_V3_ENOVA_XML_Scores_ds_1 );
ashirey.flatten(RV_Scores_V4_XML_ds_1 , flatten_RV_Scores_V4_XML_ds_1 );
ashirey.flatten(RV_Scores_V3_XML_ds_1 , flatten_RV_Scores_V3_XML_ds_1 );
ashirey.flatten(RV_Attributes_V4_XML_ds_1 , flatten_RV_Attributes_V4_XML_ds_1 );
ashirey.flatten(RV_Attributes_V3_XML_ds_1 , flatten_RV_Attributes_V3_XML_ds_1 );
ashirey.flatten(RV_Attributes_V3_BATCH_ds_1 , flatten_RV_Attributes_V3_BATCH_ds_1 );
ashirey.flatten(RV_Attributes_V4_BATCH_ds_1 , flatten_RV_Attributes_V4_BATCH_ds_1 );
ashirey.flatten(RV_Attributes_V2_BATCH_ds_1 , flatten_RV_Attributes_V2_BATCH_ds_1 );
ashirey.flatten(RV_Scores_V4_BATCH_ds_1 , flatten_RV_Scores_V4_BATCH_ds_1 );
ashirey.flatten(RV_Scores_V3_BATCH_ds_1 , flatten_RV_Scores_V3_BATCH_ds_1 );
ashirey.flatten(Regional_Acceptance_RVA1008_1_ds_1 , flatten_Regional_Acceptance_RVA1008_1_ds_1 );
ashirey.flatten(bocashell_41_cert_fcra_ds_1 , flatten_bocashell_41_cert_fcra_ds_1 );
ashirey.flatten(bocashell_50_cert_fcra_ds_1 , flatten_bocashell_50_cert_fcra_ds_1 );

ashirey.flatten(Experian_RVA_30_XML_ds_2 , flatten_Experian_RVA_30_XML_ds_2 );
ashirey.flatten(Experian_RVA_30_BATCH_ds_2 , flatten_Experian_RVA_30_BATCH_ds_2 );
ashirey.flatten(CapitalOne_RVAttributes_V3_ds_2 , flatten_CapitalOne_RVAttributes_V3_ds_2 );
ashirey.flatten(CapitalOne_RVAttributes_V2_ds_2 , flatten_CapitalOne_RVAttributes_V2_ds_2 );
ashirey.flatten(CreditAcceptanceCorp_RV2_BATCH_ds_2 , flatten_CreditAcceptanceCorp_RV2_BATCH_ds_2 );
ashirey.flatten(T_Mobile_RVT1212_ds_2 , flatten_T_Mobile_RVT1212_ds_2 );
ashirey.flatten(T_Mobile_RVT1210_ds_2 , flatten_T_Mobile_RVT1210_ds_2 );
ashirey.flatten(Santander_RVA1304_1_ds_2 , flatten_Santander_RVA1304_1_ds_2 );
ashirey.flatten(Santander_RVA1304_2_ds_2 , flatten_Santander_RVA1304_2_ds_2 );
ashirey.flatten(RV_V3_ENOVA_XML_Scores_ds_2 , flatten_RV_V3_ENOVA_XML_Scores_ds_2 );
ashirey.flatten(RV_Scores_V4_XML_ds_2 , flatten_RV_Scores_V4_XML_ds_2 );
ashirey.flatten(RV_Scores_V3_XML_ds_2 , flatten_RV_Scores_V3_XML_ds_2 );
ashirey.flatten(RV_Attributes_V4_XML_ds_2 , flatten_RV_Attributes_V4_XML_ds_2 );
ashirey.flatten(RV_Attributes_V3_XML_ds_2 , flatten_RV_Attributes_V3_XML_ds_2 );
ashirey.flatten(RV_Attributes_V3_BATCH_ds_2 , flatten_RV_Attributes_V3_BATCH_ds_2 );
ashirey.flatten(RV_Attributes_V4_BATCH_ds_2 , flatten_RV_Attributes_V4_BATCH_ds_2 );
ashirey.flatten(RV_Attributes_V2_BATCH_ds_2 , flatten_RV_Attributes_V2_BATCH_ds_2 );
ashirey.flatten(RV_Scores_V4_BATCH_ds_2 , flatten_RV_Scores_V4_BATCH_ds_2 );
ashirey.flatten(RV_Scores_V3_BATCH_ds_2 , flatten_RV_Scores_V3_BATCH_ds_2 );
ashirey.flatten(Regional_Acceptance_RVA1008_1_ds_2 , flatten_Regional_Acceptance_RVA1008_1_ds_2 );
ashirey.flatten(bocashell_41_cert_fcra_ds_2 , flatten_bocashell_41_cert_fcra_ds_2 );
ashirey.flatten(bocashell_50_cert_fcra_ds_2 , flatten_bocashell_50_cert_fcra_ds_2 );

ashirey.Diff(flatten_Experian_RVA_30_XML_ds_1 ,flatten_Experian_RVA_30_XML_ds_2 , ['AccountNumber'], j1, 'Experian_XML');
ashirey.Diff(flatten_Experian_RVA_30_BATCH_ds_1 ,flatten_Experian_RVA_30_BATCH_ds_2 , ['AccountNumber'], j2, 'Experian_BATCH');
ashirey.Diff(flatten_CapitalOne_RVAttributes_V3_ds_1 ,flatten_CapitalOne_RVAttributes_V3_ds_2 , ['AccountNumber'], j3, 'CapitalOne_RVAttributes_V3');
ashirey.Diff(flatten_CapitalOne_RVAttributes_V2_ds_1 ,flatten_CapitalOne_RVAttributes_V2_ds_2 , ['AccountNumber'], j4, 'CapitalOne_RVAttributes_V2');
ashirey.Diff(flatten_CreditAcceptanceCorp_RV2_BATCH_ds_1 ,flatten_CreditAcceptanceCorp_RV2_BATCH_ds_2 , ['AccountNumber'], j5, 'CreditAcceptanceCorp_RV2_BATCH');
ashirey.Diff(flatten_T_Mobile_RVT1212_ds_1 ,flatten_T_Mobile_RVT1212_ds_2 , ['AccountNumber'], j6, 'T_Mobile_RVT1212');
ashirey.Diff(flatten_T_Mobile_RVT1210_ds_1 ,flatten_T_Mobile_RVT1210_ds_2 , ['AccountNumber'], j7, 'T_Mobile_RVT1210');
ashirey.Diff(flatten_Santander_RVA1304_1_ds_1 ,flatten_Santander_RVA1304_1_ds_2 , ['AccountNumber'], j8, 'Santander_RVA1304_1');
ashirey.Diff(flatten_Santander_RVA1304_2_ds_1 ,flatten_Santander_RVA1304_2_ds_2 , ['AccountNumber'], j9, 'Santander_RVA1304_2');
ashirey.Diff(flatten_RV_V3_ENOVA_XML_Scores_ds_1 ,flatten_RV_V3_ENOVA_XML_Scores_ds_2 , ['AccountNumber'], j10, 'RV_V3_ENOVA_XML_Scores');
ashirey.Diff( flatten_RV_Scores_V4_XML_ds_1 , flatten_RV_Scores_V4_XML_ds_2, ['AccountNumber'], j11, 'Scores_V4_XML' );
ashirey.Diff( flatten_RV_Scores_V3_XML_ds_1 , flatten_RV_Scores_V3_XML_ds_2, ['AccountNumber'], j12, 'Scores_V3_XML' );
ashirey.Diff( flatten_RV_Attributes_V4_XML_ds_1 , flatten_RV_Attributes_V4_XML_ds_2, ['AccountNumber'], j13, 'Attr_V4_XML' );
ashirey.Diff( flatten_RV_Attributes_V3_XML_ds_1 , flatten_RV_Attributes_V3_XML_ds_2, ['AccountNumber'], j14, 'Attr_V3_XML' );
ashirey.Diff( flatten_RV_Attributes_V3_BATCH_ds_1 , flatten_RV_Attributes_V3_BATCH_ds_2, ['AccountNumber'], j15, 'Attr_V3_BATCH' );
ashirey.Diff( flatten_RV_Attributes_V4_BATCH_ds_1 , flatten_RV_Attributes_V4_BATCH_ds_2, ['AccountNumber'], j16, 'Attr_V4_BATCH' );
ashirey.Diff( flatten_RV_Attributes_V2_BATCH_ds_1 , flatten_RV_Attributes_V2_BATCH_ds_2, ['AccountNumber'], j17, 'Attr_V2_BATCH' );
ashirey.Diff( flatten_RV_Scores_V4_BATCH_ds_1 , flatten_RV_Scores_V4_BATCH_ds_2, ['AccountNumber'], j18, 'Scores_V4_BATCH' );
ashirey.Diff( flatten_RV_Scores_V3_BATCH_ds_1 , flatten_RV_Scores_V3_BATCH_ds_2, ['AccountNumber'], j19, 'Scores_V3_BATCH' );
ashirey.Diff( flatten_Regional_Acceptance_RVA1008_1_ds_1 , flatten_Regional_Acceptance_RVA1008_1_ds_2, ['AccountNumber'], j20, 'RegAccept_RVA1008' );
ashirey.Diff(flatten_bocashell_41_cert_fcra_ds_1 ,flatten_bocashell_41_cert_fcra_ds_2 , ['AccountNumber'], j21, 'bocashell_41_fcra');
ashirey.Diff(flatten_bocashell_50_cert_fcra_ds_1 ,flatten_bocashell_50_cert_fcra_ds_2 , ['AccountNumber'], j22, 'bocashell_50_fcra');

// a1 := ashirey.Diff(flatten_Experian_RVA_30_XML_ds_1 ,flatten_Experian_RVA_30_XML_ds_2 , ['AccountNumber'], j1, 'Experian_XML');
// a2 := ashirey.Diff(flatten_Experian_RVA_30_BATCH_ds_1 ,flatten_Experian_RVA_30_BATCH_ds_2 , ['AccountNumber'], j2, 'Experian_BATCH');
// a3 := ashirey.Diff(flatten_CapitalOne_RVAttributes_V3_ds_1 ,flatten_CapitalOne_RVAttributes_V3_ds_2 , ['AccountNumber'], j3, 'CapitalOne_RVAttr_V3');
// a4 := ashirey.Diff(flatten_CapitalOne_RVAttributes_V2_ds_1 ,flatten_CapitalOne_RVAttributes_V2_ds_2 , ['AccountNumber'], j4, 'CapitalOne_RVAttr_V2');
// a5 := ashirey.Diff(flatten_CreditAcceptanceCorp_RV2_BATCH_ds_1 ,flatten_CreditAcceptanceCorp_RV2_BATCH_ds_2 , ['AccountNumber'], j5, 'CreditAcceptanceCorp_RV2_BATCH');
// a6 := ashirey.Diff(flatten_T_Mobile_RVT1212_ds_1 ,flatten_T_Mobile_RVT1212_ds_2 , ['AccountNumber'], j6, 'T_Mobile_RVT1212');
// a7 := ashirey.Diff(flatten_T_Mobile_RVT1210_ds_1 ,flatten_T_Mobile_RVT1210_ds_2 , ['AccountNumber'], j7, 'T_Mobile_RVT1210');
// a8 := ashirey.Diff(flatten_Santander_RVA1304_1_ds_1 ,flatten_Santander_RVA1304_1_ds_2 , ['AccountNumber'], j8, 'Santander_RVA1304');
// a9 := ashirey.Diff(flatten_Santander_RVA1304_2_ds_1 ,flatten_Santander_RVA1304_2_ds_2 , ['AccountNumber'], j9, 'Santander_RVA13042');
// a10 := ashirey.Diff(flatten_RV_V3_ENOVA_XML_Scores_ds_1 ,flatten_RV_V3_ENOVA_XML_Scores_ds_2 , ['AccountNumber'], j10, 'ENOVA_XML_Scores');
// a11 := ashirey.Diff( flatten_RV_Scores_V4_XML_ds_1 , flatten_RV_Scores_V4_XML_ds_2, ['AccountNumber'], j11, 'Scores_V4_XML' );
// a12 := ashirey.Diff( flatten_RV_Scores_V3_XML_ds_1 , flatten_RV_Scores_V3_XML_ds_2, ['AccountNumber'], j12, 'Scores_V3_XML' );
// a13 := ashirey.Diff( flatten_RV_Attributes_V4_XML_ds_1 , flatten_RV_Attributes_V4_XML_ds_2, ['AccountNumber'], j13, 'Attr_V4_XML' );
// a14 := ashirey.Diff( flatten_RV_Attributes_V3_XML_ds_1 , flatten_RV_Attributes_V3_XML_ds_2, ['AccountNumber'], j14, 'Attr_V3_XML' );
// a15 := ashirey.Diff( flatten_RV_Attributes_V3_BATCH_ds_1 , flatten_RV_Attributes_V3_BATCH_ds_2, ['AccountNumber'], j15, 'Attr_V3_BATCH' );
// a16 := ashirey.Diff( flatten_RV_Attributes_V4_BATCH_ds_1 , flatten_RV_Attributes_V4_BATCH_ds_2, ['AccountNumber'], j16, 'Attr_V4_BATCH' );
// a17 := ashirey.Diff( flatten_RV_Attributes_V2_BATCH_ds_1 , flatten_RV_Attributes_V2_BATCH_ds_2, ['AccountNumber'], j17, 'Attr_V2_BATCH' );
// a18 := ashirey.Diff( flatten_RV_Scores_V4_BATCH_ds_1 , flatten_RV_Scores_V4_BATCH_ds_2, ['AccountNumber'], j18, 'Scores_V4_BATCH' );
// a19 := ashirey.Diff( flatten_RV_Scores_V3_BATCH_ds_1 , flatten_RV_Scores_V3_BATCH_ds_2, ['AccountNumber'], j19, 'Scores_V3_BATCH' );
// a20 := ashirey.Diff( flatten_Regional_Acceptance_RVA1008_1_ds_1 , flatten_Regional_Acceptance_RVA1008_1_ds_2, ['AccountNumber'], j20, 'RegAccept_RVA1008' );
// a21 := ashirey.Diff(flatten_bocashell_41_cert_fcra_ds_1 ,flatten_bocashell_41_cert_fcra_ds_2 , ['AccountNumber'], j21, 'bocashell_41_fcra');
// a22 := ashirey.Diff(flatten_bocashell_50_cert_fcra_ds_1 ,flatten_bocashell_50_cert_fcra_ds_2 , ['AccountNumber'], j22, 'bocashell_50_fcra');

a24 := OUTPUT(count(flatten_Experian_RVA_30_XML_ds_1 ), named('count_1'));
a25 := OUTPUT(count(flatten_Experian_RVA_30_BATCH_ds_1 ), named('count_2'));
a26 := OUTPUT(count(flatten_CapitalOne_RVAttributes_V3_ds_1 ), named('count_3'));
a27 := OUTPUT(count(flatten_CapitalOne_RVAttributes_V2_ds_1 ), named('count_4'));
a28 := OUTPUT(count(flatten_CreditAcceptanceCorp_RV2_BATCH_ds_1 ), named('count_5'));
a29 := OUTPUT(count(flatten_T_Mobile_RVT1212_ds_1 ), named('count_6'));
a30 := OUTPUT(count(flatten_T_Mobile_RVT1210_ds_1 ), named('count_7'));
a31 := OUTPUT(count(flatten_Santander_RVA1304_1_ds_1 ), named('count_8'));
a32 := OUTPUT(count(flatten_Santander_RVA1304_2_ds_1 ), named('count_9'));
a33 := OUTPUT(count(flatten_RV_V3_ENOVA_XML_Scores_ds_1 ), named('count_10'));
a34 := OUTPUT(count(flatten_RV_Scores_V4_XML_ds_1 ), named('count_11'));
a35 := OUTPUT(count(flatten_RV_Scores_V3_XML_ds_1 ), named('count_12'));
a36 := OUTPUT(count(flatten_RV_Attributes_V4_XML_ds_1 ), named('count_13'));
a37 := OUTPUT(count(flatten_RV_Attributes_V3_XML_ds_1 ), named('count_14'));
a38 := OUTPUT(count(flatten_RV_Attributes_V3_BATCH_ds_1 ), named('count_15'));
a39 := OUTPUT(count(flatten_RV_Attributes_V4_BATCH_ds_1 ), named('count_16'));
a40 := OUTPUT(count(flatten_RV_Attributes_V2_BATCH_ds_1 ), named('count_17'));
a41 := OUTPUT(count(flatten_RV_Scores_V4_BATCH_ds_1 ), named('count_18'));
a42 := OUTPUT(count(flatten_RV_Scores_V3_BATCH_ds_1 ), named('count_19'));
a43 := OUTPUT(count(flatten_Regional_Acceptance_RVA1008_1_ds_1 ), named('count_20'));
a44 := OUTPUT(count(flatten_bocashell_41_cert_fcra_ds_1 ), named('count_21'));
a45 := OUTPUT(count(flatten_bocashell_50_cert_fcra_ds_1 ), named('count_22'));

a47 := OUTPUT(count(flatten_Experian_RVA_30_XML_ds_2 ), named('count_23'));
a48 := OUTPUT(count(flatten_Experian_RVA_30_BATCH_ds_2 ), named('count_24'));
a49 := OUTPUT(count(flatten_CapitalOne_RVAttributes_V3_ds_2 ), named('count_25'));
a50 := OUTPUT(count(flatten_CapitalOne_RVAttributes_V2_ds_2 ), named('count_26'));
a51 := OUTPUT(count(flatten_CreditAcceptanceCorp_RV2_BATCH_ds_2 ), named('count_27'));
a52 := OUTPUT(count(flatten_T_Mobile_RVT1212_ds_2 ), named('count_28'));
a53 := OUTPUT(count(flatten_T_Mobile_RVT1210_ds_2 ), named('count_29'));
a54 := OUTPUT(count(flatten_Santander_RVA1304_1_ds_2 ), named('count_30'));
a55 := OUTPUT(count(flatten_Santander_RVA1304_2_ds_2 ), named('count_31'));
a56 := OUTPUT(count(flatten_RV_V3_ENOVA_XML_Scores_ds_2 ), named('count_32'));
a57 := OUTPUT(count(flatten_RV_Scores_V4_XML_ds_2 ), named('count_33'));
a58 := OUTPUT(count(flatten_RV_Scores_V3_XML_ds_2 ), named('count_34'));
a59 := OUTPUT(count(flatten_RV_Attributes_V4_XML_ds_2 ), named('count_35'));
a60 := OUTPUT(count(flatten_RV_Attributes_V3_XML_ds_2 ), named('count_36'));
a61 := OUTPUT(count(flatten_RV_Attributes_V3_BATCH_ds_2 ), named('count_37'));
a62 := OUTPUT(count(flatten_RV_Attributes_V4_BATCH_ds_2 ), named('count_38'));
a63 := OUTPUT(count(flatten_RV_Attributes_V2_BATCH_ds_2 ), named('count_39'));
a64 := OUTPUT(count(flatten_RV_Scores_V4_BATCH_ds_2 ), named('count_41'));
a65 := OUTPUT(count(flatten_RV_Scores_V3_BATCH_ds_2 ), named('count_42'));
a66 := OUTPUT(count(flatten_Regional_Acceptance_RVA1008_1_ds_2 ), named('count_43'));
a67 := OUTPUT(count(flatten_bocashell_41_cert_fcra_ds_2 ), named('count_44'));
a68 := OUTPUT(count(flatten_bocashell_50_cert_fcra_ds_2 ), named('count_45'));

a70 := OUTPUT(count(j1), named('count_Experian_XML'));
a71 := OUTPUT(count(j2), named('count_Experian_BATCH'));
a72 := OUTPUT(count(j3), named('count_CapitalOne_RVAttributes_V3'));
a73 := OUTPUT(count(j4), named('count_CapitalOne_RVAttributes_V2'));
a74 := OUTPUT(count(j5), named('count_CreditAcceptanceCorp_RV2_BATCH'));
a75 := OUTPUT(count(j6), named('count_T_Mobile_RVT1212'));
a76 := OUTPUT(count(j7), named('count_T_Mobile_RVT1210'));
a77 := OUTPUT(count(j8), named('count_Santander_RVA1304_1'));
a78 := OUTPUT(count(j9), named('count_Santander_RVA1304_2'));
a79 := OUTPUT(count(j10), named('count_RV_V3_ENOVA_XML_Scores'));
a80 := OUTPUT(count(j11), named('count_RV_Attributes_V4_XML'));
a81 := OUTPUT(count(j12), named('count_RV_Attributes_V3_XML'));
a82 := OUTPUT(count(j13), named('count_RV_Scores_V4_XML'));
a83 := OUTPUT(count(j14), named('count_RV_Scores_V3_XML'));
a84 := OUTPUT(count(j15), named('count_RV_Scores_V4_BATCH'));
a85 := OUTPUT(count(j16), named('count_RV_Scores_V3_BATCH'));
a86 := OUTPUT(count(j17), named('count_RV_Attributes_V3_BATCH'));
a87 := OUTPUT(count(j18), named('count_RV_Attributes_V4_BATCH'));
a88 := OUTPUT(count(j19), named('count_RV_Attributes_V2_BATCH'));
a89 := OUTPUT(count(j20), named('count_Regional_Acceptance_RVA1008_1'));
a90 := OUTPUT(count(j21), named('count_bocashell_41_fcra'));
a91 := OUTPUT(count(j22), named('count_bocashell_50_fcra'));

a93 := OUTPUT(choosen(j1, eyeball), named('diff_Experian_XML'));
a94 := OUTPUT(choosen(j2, eyeball), named('diff_Experian_BATCH'));
a95 := OUTPUT(choosen(j3, eyeball), named('diff_CapitalOne_RVAttributes_V3'));
a96 := OUTPUT(choosen(j4, eyeball), named('diff_CapitalOne_RVAttributes_V2'));
a97 := OUTPUT(choosen(j5, eyeball), named('diff_CreditAcceptanceCorp_RV2_BATCH'));
a98 := OUTPUT(choosen(j6, eyeball), named('diff_T_Mobile_RVT1212'));
a99 := OUTPUT(choosen(j7, eyeball), named('diff_T_Mobile_RVT1210'));
a100 := OUTPUT(choosen(j8, eyeball), named('diff_Santander_RVA1304_1'));
a101 := OUTPUT(choosen(j9, eyeball), named('diff_Santander_RVA1304_2'));
a102 := OUTPUT(choosen(j10, eyeball), named('diff_RV_V3_ENOVA_XML_Scores'));
a103 := OUTPUT(choosen(j11, eyeball), named('diff_RV_Attributes_V4_XML'));
a104 := OUTPUT(choosen(j12, eyeball), named('diff_RV_Attributes_V3_XML'));
a105 := OUTPUT(choosen(j13, eyeball), named('diff_RV_Scores_V4_XML'));
a106 := OUTPUT(choosen(j14, eyeball), named('diff_RV_Scores_V3_XML'));
a107 := OUTPUT(choosen(j15, eyeball), named('diff_RV_Scores_V4_BATCH'));
a108 := OUTPUT(choosen(j16, eyeball), named('diff_RV_Scores_V3_BATCH'));
a109 := OUTPUT(choosen(j17, eyeball), named('diff_RV_Attributes_V3_BATCH'));
a110 := OUTPUT(choosen(j18, eyeball), named('diff_RV_Attributes_V4_BATCH'));
a111 := OUTPUT(choosen(j19, eyeball), named('diff_RV_Attributes_V2_BATCH'));
a112 := OUTPUT(choosen(j20, eyeball), named('diff_Regional_Acceptance_RVA1008_1'));
a113 := OUTPUT(choosen(j21, eyeball), named('diff_bocashell_41_fcra'));
a114 := OUTPUT(choosen(j22, eyeball), named('diff_bocashell_50_fcra'));


action := sequential(	
											// parallel(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22),
											parallel(a24, a25, a26, a27, a28, a29, a30, a31, a32, a33, a34, a35, a36, a37, a38, a39, a40, a41, a42, a43, a44, a45),
											parallel(a47, a48, a49, a50, a51, a52, a53, a54, a55, a56, a57, a58, a59, a60, a61, a62, a63, a64, a65, a66, a67, a68),
											parallel(a70, a71, a72, a73, a74, a75, a76, a77, a78, a79, a80, a81, a82, a83, a84, a85, a86, a87, a88, a89, a90, a91),
											parallel(a93, a94, a95, a96, a97, a98, a99, a100, a101, a102, a103, a104, a105, a106, a107, a108, a109, a110, a111, a112, a113, a114)
											);


// return action;
action;
// return sequential(a1, a93);

// endmacro;