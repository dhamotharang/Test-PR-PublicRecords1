EXPORT Layout_RVAttributes := MODULE

EXPORT Layout_Lifestyle := RECORD
	string1 dwelltype;
	unsigned4 assessed_amount;
	boolean applicant_owned;
	boolean family_owned;
	boolean occupant_owned;
	boolean isbestmatch;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_first_seen2;
	UNSIGNED4 date_first_seen3;
	string2 number_nonderogs;
	unsigned4 date_last_seen;
	boolean recent_update;
END;

EXPORT Layout_Demographic := RECORD
	boolean ssn_issued;
	UNSIGNED4 low_issue_date;
	UNSIGNED4 high_issue_date;
	boolean nonUS_ssn;
	string2 ssn_issue_state;
	unsigned3 ssn_first_seen;
END;

EXPORT Layout_Financial := RECORD
	boolean phone_full_name_match;
	boolean phone_last_name_match;
	string1 nap_status;
END;

EXPORT Layout_Property := RECORD
	unsigned1 property_owned_total;
	unsigned5 property_owned_assessed_total;
	unsigned1 property_historically_owned;
END;

EXPORT Layout_Derogatory := RECORD
	unsigned1 criminal_count;
	unsigned1 filing_count;
	unsigned4 date_last_seen;
	string35 disposition;
	UNSIGNED1 liens_historical_unreleased_count;
	UNSIGNED1 liens_recent_unreleased_count;
	unsigned1 total_number_derogs;
END;
// end of version 1

// version 2	
EXPORT Layout_Version2 := RECORD
	unsigned4 SSNFirstSeen;
	unsigned4 DateLastSeen;
	boolean isRecentUpdate;
	unsigned1 NumSources;
	boolean isPhoneFullNameMatch;
	boolean isPhoneLastNameMatch;
	boolean isSSNInvalid;
	boolean isPhoneInvalid;
	boolean isAddrInvalid;
	boolean isDLInvalid;
	boolean isNoVer;
	
	boolean isDeceased;
	unsigned4 DeceasedDate;
	boolean isSSNValid;
	boolean isRecentIssue;
	unsigned4 LowIssueDate;
	unsigned4 HighIssueDate;
	string2 IssueState;
	boolean isNonUS;
	boolean isIssued3;
	boolean isIssuedAge5;

	unsigned3 IADateFirstReported;
	unsigned3 IADateLastReported;
	unsigned1 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	unsigned4 IAAssessedValue;
	boolean IAisOwnedBySubject;
	boolean IAisFamilyOwned;
	boolean IAisOccupantOwned;
	unsigned4 IALastSaleDate;
	unsigned4 IALastSaleAmount;
	boolean IAisNotPrimaryRes;
	unsigned1 IAPhoneListed;
	unsigned5 IAPhoneNumber;

	unsigned3 CADateFirstReported;
	unsigned3 CADateLastReported;
	unsigned1 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	unsigned4 CAAssessedValue;
	boolean CAisOwnedBySubject;
	boolean CAisFamilyOwned;
	boolean CAisOccupantOwned;
	unsigned4 CALastSaleDate;
	unsigned4 CALastSaleAmount;
	boolean CAisNotPrimaryRes;
	unsigned1 CAPhoneListed;
	unsigned5 CAPhoneNumber;
	
	unsigned3 PADateFirstReported;
	unsigned3 PADateLastReported;
	unsigned1 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	unsigned4 PAAssessedValue;
	boolean PAisOwnedBySubject;
	boolean PAisFamilyOwned;
	boolean PAisOccupantOwned;
	unsigned4 PALastSaleDate;
	unsigned4 PALastSaleAmount;
	boolean PAisNotPrimaryRes;
	unsigned1 PAPhoneListed;
	unsigned5 PAPhoneNumber;
	
	boolean isInputCurrMatch;
	unsigned2 DistInputCurr;
	boolean isDiffState;
	integer4 AssessedDiff;
	string2 EcoTrajectory;
	
	boolean isInputPrevMatch;
	unsigned2 DistCurrPrev;
	boolean isDiffState2;
	integer4 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	unsigned3 PADateFirstReported2;
	unsigned3 NPADateFirstReported;
	unsigned1 addrChanges30;
	unsigned1 addrChanges90;
	unsigned1 addrChanges180;
	unsigned1 addrChanges12;
	unsigned1 addrChanges24;
	unsigned1 addrChanges36;
	unsigned1 addrChanges60;
	
	unsigned1 property_owned_total;
	unsigned5 property_owned_assessed_total;
	unsigned1 property_historically_owned;
	unsigned4 date_first_purchase;
	unsigned4 date_most_recent_purchase;
	unsigned4 date_most_recent_sale;
	
	unsigned1 numPurchase30;
	unsigned1 numPurchase90;
	unsigned1 numPurchase180;
	unsigned1 numPurchase12;
	unsigned1 numPurchase24;
	unsigned1 numPurchase36;
	unsigned1 numPurchase60;
	
	unsigned1 numSold30;
	unsigned1 numSold90;
	unsigned1 numSold180;
	unsigned1 numSold12;
	unsigned1 numSold24;
	unsigned1 numSold36;
	unsigned1 numSold60;
	
	unsigned1 numWatercraft;
	unsigned1 numWatercraft30;
	unsigned1 numWatercraft90;
	unsigned1 numWatercraft180;
	unsigned1 numWatercraft12;
	unsigned1 numWatercraft24;
	unsigned1 numWatercraft36;
	unsigned1 numWatercraft60;
	
	unsigned1 numAircraft;
	unsigned1 numAircraft30;
	unsigned1 numAircraft90;
	unsigned1 numAircraft180;
	unsigned1 numAircraft12;
	unsigned1 numAircraft24;
	unsigned1 numAircraft36;
	unsigned1 numAircraft60;
	
	string1 wealth_indicator;

	unsigned1 total_number_derogs;
	unsigned4 date_last_derog;
	
	unsigned1 felonies;
	unsigned4 date_last_conviction;
	unsigned1 felonies30;
	unsigned1 felonies90;
	unsigned1 felonies180;
	unsigned1 felonies12;
	unsigned1 felonies24;
	unsigned1 felonies36;
	unsigned1 felonies60;
	
	unsigned1 num_liens;
	unsigned1 num_unreleased_liens;
	unsigned4 date_last_unreleased;
	unsigned1 num_unreleased_liens30;
	unsigned1 num_unreleased_liens90;
	unsigned1 num_unreleased_liens180;
	unsigned1 num_unreleased_liens12;
	unsigned1 num_unreleased_liens24;
	unsigned1 num_unreleased_liens36;
	unsigned1 num_unreleased_liens60;
	
	unsigned1 num_released_liens;
	unsigned4 date_last_released;
	unsigned1 num_released_liens30;
	unsigned1 num_released_liens90;
	unsigned1 num_released_liens180;
	unsigned1 num_released_liens12;
	unsigned1 num_released_liens24;
	unsigned1 num_released_liens36;
	unsigned1 num_released_liens60;
	
	unsigned1 bankruptcy_count;
	unsigned4 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	unsigned1 bankruptcy_count30;
	unsigned1 bankruptcy_count90;
	unsigned1 bankruptcy_count180;
	unsigned1 bankruptcy_count12;
	unsigned1 bankruptcy_count24;
	unsigned1 bankruptcy_count36;
	unsigned1 bankruptcy_count60;
	
	unsigned1 eviction_count;
	unsigned4 date_last_eviction;
	unsigned1 eviction_count30;
	unsigned1 eviction_count90;
	unsigned1 eviction_count180;
	unsigned1 eviction_count12;
	unsigned1 eviction_count24;
	unsigned1 eviction_count36;
	unsigned1 eviction_count60;

	unsigned1 num_nonderogs;
	unsigned1 num_nonderogs30;
	unsigned1 num_nonderogs90;
	unsigned1 num_nonderogs180;
	unsigned1 num_nonderogs12;
	unsigned1 num_nonderogs24;
	unsigned1 num_nonderogs36;
	unsigned1 num_nonderogs60;
	
	unsigned1 num_proflic;
	unsigned4 date_last_proflic;
	string60 proflic_type;
	unsigned4 expire_date_last_proflic;
	
	unsigned1 num_proflic30;
	unsigned1 num_proflic90;
	unsigned1 num_proflic180;
	unsigned1 num_proflic12;
	unsigned1 num_proflic24;
	unsigned1 num_proflic36;
	unsigned1 num_proflic60;
	
	unsigned1 num_proflic_exp30;
	unsigned1 num_proflic_exp90;
	unsigned1 num_proflic_exp180;
	unsigned1 num_proflic_exp12;
	unsigned1 num_proflic_exp24;
	unsigned1 num_proflic_exp36;
	unsigned1 num_proflic_exp60;
	
	boolean isAddrHighRisk;
	boolean isPhoneHighRisk;
	boolean isAddrPrison;
	boolean isZipPOBox;
	boolean isZipCorpMil;
	string1 phoneStatus;
	boolean isPhonePager;
	boolean isPhoneMobile;
	boolean isPhoneZipMismatch;
	unsigned3 phoneAddrDist;
	
	boolean correctedFlag;
	boolean disputeFlag;
	boolean securityFreeze;
	boolean securityAlert;
	boolean negativeAlert;
	boolean idTheftFlag;
END;
// end version2
	
// version 3	
EXPORT Layout_Version3 := RECORD
	string4 AgeOldestRecord; 
	string4 AgeNewestRecord; 
	boolean isRecentUpdate;
	unsigned1 NumSources;
	string1 VerifiedPhoneFullName;
	string1 VerifiedPhoneLastName;
	string1 InvalidSSN; 
	string1 InvalidPhone; 
	string1 InvalidAddr; 
	string1 InvalidDL; 
	boolean isNoVer;
	
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
	unsigned1 addrChanges30;
	unsigned1 addrChanges90;
	unsigned1 addrChanges180;
	unsigned1 addrChanges12;
	unsigned1 addrChanges24;
	unsigned1 addrChanges36;
	unsigned1 addrChanges60;
	
	unsigned1 property_owned_total;
	unsigned5 property_owned_assessed_total;
	unsigned1 property_historically_owned;
	string4 PropAgeOldestPurchase;
	string4 PropAgeNewestPurchase;
	string4 PropAgeNewestSale;
	
	unsigned1 numPurchase30;
	unsigned1 numPurchase90;
	unsigned1 numPurchase180;
	unsigned1 numPurchase12;
	unsigned1 numPurchase24;
	unsigned1 numPurchase36;
	unsigned1 numPurchase60;
	
	unsigned1 numSold30;
	unsigned1 numSold90;
	unsigned1 numSold180;
	unsigned1 numSold12;
	unsigned1 numSold24;
	unsigned1 numSold36;
	unsigned1 numSold60;
	
	unsigned1 numWatercraft;
	unsigned1 numWatercraft30;
	unsigned1 numWatercraft90;
	unsigned1 numWatercraft180;
	unsigned1 numWatercraft12;
	unsigned1 numWatercraft24;
	unsigned1 numWatercraft36;
	unsigned1 numWatercraft60;
	
	unsigned1 numAircraft;
	unsigned1 numAircraft30;
	unsigned1 numAircraft90;
	unsigned1 numAircraft180;
	unsigned1 numAircraft12;
	unsigned1 numAircraft24;
	unsigned1 numAircraft36;
	unsigned1 numAircraft60;
	
	string1 wealth_indicator;

	unsigned1 total_number_derogs;
	string4 DerogAge;
	
	unsigned1 felonies;
	string4 FelonyAge;
	unsigned1 felonies30;
	unsigned1 felonies90;
	unsigned1 felonies180;
	unsigned1 felonies12;
	unsigned1 felonies24;
	unsigned1 felonies36;
	unsigned1 felonies60;
	
	unsigned1 num_liens;
	unsigned1 num_unreleased_liens;
	string4 LienFiledAge;
	unsigned1 num_unreleased_liens30;
	unsigned1 num_unreleased_liens90;
	unsigned1 num_unreleased_liens180;
	unsigned1 num_unreleased_liens12;
	unsigned1 num_unreleased_liens24;
	unsigned1 num_unreleased_liens36;
	unsigned1 num_unreleased_liens60;
	
	unsigned1 num_released_liens;
	string4 LienReleasedAge;
	unsigned1 num_released_liens30;
	unsigned1 num_released_liens90;
	unsigned1 num_released_liens180;
	unsigned1 num_released_liens12;
	unsigned1 num_released_liens24;
	unsigned1 num_released_liens36;
	unsigned1 num_released_liens60;
	
	unsigned1 bankruptcy_count;
	string4 BankruptcyAge;
	STRING1 filing_type;
	STRING35 disposition;
	unsigned1 bankruptcy_count30;
	unsigned1 bankruptcy_count90;
	unsigned1 bankruptcy_count180;
	unsigned1 bankruptcy_count12;
	unsigned1 bankruptcy_count24;
	unsigned1 bankruptcy_count36;
	unsigned1 bankruptcy_count60;
	
	unsigned1 eviction_count;
	string4 EvictionAge;
	unsigned1 eviction_count30;
	unsigned1 eviction_count90;
	unsigned1 eviction_count180;
	unsigned1 eviction_count12;
	unsigned1 eviction_count24;
	unsigned1 eviction_count36;
	unsigned1 eviction_count60;

	unsigned1 num_nonderogs;
	unsigned1 num_nonderogs30;
	unsigned1 num_nonderogs90;
	unsigned1 num_nonderogs180;
	unsigned1 num_nonderogs12;
	unsigned1 num_nonderogs24;
	unsigned1 num_nonderogs36;
	unsigned1 num_nonderogs60;
	
	unsigned1 num_proflic;
	string4 ProfLicAge;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	unsigned1 num_proflic30;
	unsigned1 num_proflic90;
	unsigned1 num_proflic180;
	unsigned1 num_proflic12;
	unsigned1 num_proflic24;
	unsigned1 num_proflic36;
	unsigned1 num_proflic60;
	
	unsigned1 num_proflic_exp30;
	unsigned1 num_proflic_exp90;
	unsigned1 num_proflic_exp180;
	unsigned1 num_proflic_exp12;
	unsigned1 num_proflic_exp24;
	unsigned1 num_proflic_exp36;
	unsigned1 num_proflic_exp60;
	
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
	
	boolean correctedFlag;
	//boolean disputeFlag;
	boolean securityFreeze;
	boolean securityAlert;
	//boolean negativeAlert;
	boolean idTheftFlag;
	
	// new version 3 fields
	string1 SSNNotFound;
	unsigned1 VerifiedName;
	unsigned1 VerifiedSSN;
	unsigned1 VerifiedPhone;
	unsigned1 VerifiedAddress;
	unsigned1 VerifiedDOB;
	string3 InferredMinimumAge;
	string3 BestReportedAge;
	unsigned1 SubjectSSNCount;
	unsigned1 SubjectAddrCount;
	unsigned1 SubjectPhoneCount;
	unsigned1 SubjectSSNRecentCount;
	unsigned1 SubjectAddrRecentCount;
	unsigned1 SubjectPhoneRecentCount;
	unsigned1 SSNIdentitiesCount;
	unsigned1 SSNAddrCount;
	unsigned1 SSNIdentitiesRecentCount;
	unsigned1 SSNAddrRecentCount;
	unsigned1 InputAddrIdentitiesCount;
	unsigned1 InputAddrSSNCount;
	unsigned1 InputAddrPhoneCount;
	unsigned1 InputAddrIdentitiesRecentCount;
	unsigned1 InputAddrSSNRecentCount;
	unsigned1 InputAddrPhoneRecentCount;
	unsigned1 PhoneIdentitiesCount;
	unsigned1 PhoneIdentitiesRecentCount;
	string1 SSNIssuedPriorDOB;
	
	string4 InputAddrTaxYr;
	unsigned5 InputAddrTaxMarketValue;
	unsigned5 InputAddrAVMTax;
	unsigned5 InputAddrAVMSalesPrice;
	unsigned5 InputAddrAVMHedonic;
	unsigned5 InputAddrAVMValue;
	unsigned1 InputAddrAVMConfidence;
	decimal4_2 InputAddrCountyIndex;
	decimal4_2 InputAddrTractIndex;
	decimal4_2 InputAddrBlockIndex;
	
	string4 CurrAddrTaxYr;
	unsigned5 CurrAddrTaxMarketValue;
	unsigned5 CurrAddrAVMTax;
	unsigned5 CurrAddrAVMSalesPrice;
	unsigned5 CurrAddrAVMHedonic;
	unsigned5 CurrAddrAVMValue;
	unsigned1 CurrAddrAVMConfidence;
	decimal4_2 CurrAddrCountyIndex;
	decimal4_2 CurrAddrTractIndex;
	decimal4_2 CurrAddrBlockIndex;
	
	string4 PrevAddrTaxYr;
	unsigned5 PrevAddrTaxMarketValue;
	unsigned5 PrevAddrAVMTax;
	unsigned5 PrevAddrAVMSalesPrice;
	unsigned5 PrevAddrAVMHedonic;
	unsigned5 PrevAddrAVMValue;
	unsigned1 PrevAddrAVMConfidence;
	decimal4_2 PrevAddrCountyIndex;
	decimal4_2 PrevAddrTractIndex;
	decimal4_2 PrevAddrBlockIndex;
	
	string1 EducationAttendedCollege;
	string1 EducationProgram2Yr;
	string1 EducationProgram4Yr;
	string1 EducationProgramGraduate;
	string1 EducationInstitutionPrivate;
	string1 EducationInstitutionRating;
	
	string PredictedAnnualIncome;
	
	unsigned5 PropNewestSalePrice;
	decimal4_2 PropNewestSalePurchaseIndex;
	// decimal4_2 PropNewestSaleTaxIndex;	// this will not be populated
	// decimal4_2 PropNewestSaleAVMIndex;	// this will not be populated
	
	unsigned1 SubPrimeSolicitedCount;
	unsigned1 SubPrimeSolicitedCount01;
	unsigned1 SubprimeSolicitedCount03;
	unsigned1 SubprimeSolicitedCount06;
	unsigned1 SubPrimeSolicitedCount12;
	unsigned1 SubPrimeSolicitedCount24;
	unsigned1 SubPrimeSolicitedCount36;
	unsigned1 SubPrimeSolicitedCount60;
	
	unsigned5 LienFederalTaxFiledTotal;
	unsigned5 LienTaxOtherFiledTotal;
	unsigned5 LienForeclosureFiledTotal;
	unsigned5 LienPreforeclosureFiledTotal;
	unsigned5 LienLandlordTenantFiledTotal;
	unsigned5 LienJudgmentFiledTotal;
	unsigned5 LienSmallClaimsFiledTotal;
	unsigned5 LienOtherFiledTotal;
	unsigned5 LienFederalTaxReleasedTotal;
	unsigned5 LienTaxOtherReleasedTotal;
	unsigned5 LienForeclosureReleasedTotal;
	unsigned5 LienPreforeclosureReleasedTotal;
	unsigned5 LienLandlordTenantReleasedTotal;
	unsigned5 LienJudgmentReleasedTotal;
	unsigned5 LienSmallClaimsReleasedTotal;
	unsigned5 LienOtherReleasedTotal;
	
	unsigned1 LienFederalTaxFiledCount;
	unsigned1 LienTaxOtherFiledCount;
	unsigned1 LienForeclosureFiledCount;
	unsigned1 LienPreforeclosureFiledCount;
	unsigned1 LienLandlordTenantFiledCount;
	unsigned1 LienJudgmentFiledCount;
	unsigned1 LienSmallClaimsFiledCount;
	unsigned1 LienOtherFiledCount;
	unsigned1 LienFederalTaxReleasedCount;
	unsigned1 LienTaxOtherReleasedCount;
	unsigned1 LienForeclosureReleasedCount;
	unsigned1 LienPreforeclosureReleasedCount;
	unsigned1 LienLandlordTenantReleasedCount;
	unsigned1 LienJudgmentReleasedCount;
	unsigned1 LienSmallClaimsReleasedCount;
	unsigned1 LienOtherReleasedCount;
	
	string1 ProfLicTypeCategory;
	
	string4 PhoneEDAAgeOldestRecord;
	string4 PhoneEDAAgeNewestRecord;
	string4 PhoneOtherAgeOldestRecord;
	string4 PhoneOtherAgeNewestRecord;
	
	string1 PrescreenOptOut;
END;

EXPORT Layout_RVAddressAppendAttr := RECORD
	// Address Append Attributes
	STRING1		AddrAppendInputCurr;
	STRING120	AddrAppendStreetAddress;
	STRING25	AddrAppendCity;
	STRING2		AddrAppendState;
	STRING5		AddrAppendZip;
END;
// Need to have two separate "V3" layouts because Seed_Files.Layout_RVAttributes references these layouts as well, but the testseeds don't include the Addr Append attr
EXPORT Layout_Version3_Plus := RECORD
	Layout_Version3;
	Layout_RVAddressAppendAttr;
END;
// end version3

export RVAttributes := RECORD
	string30 AccountNumber;
	Layout_Lifestyle lifestyle;
	Layout_Demographic dems;
	Layout_Financial finance;
	Layout_Property property;
	Layout_Derogatory derogs;
	Layout_Version2 version2;
	Layout_Version3 version3;
	Models.Layouts.Layout_Riskview_v4;
END;

export RVAttributesWithAddrAppend := RECORD
	string30 AccountNumber;
	Layout_Lifestyle lifestyle;
	Layout_Demographic dems;
	Layout_Financial finance;
	Layout_Property property;
	Layout_Derogatory derogs;
	Layout_Version2 version2;
	Layout_Version3_Plus version3;
	Models.Layouts.Layout_Riskview_v4;
END;

EXPORT Layout_rvAttrSeq := RECORD
	UNSIGNED4 seq;
	RVAttributes;
END;

EXPORT Layout_rvAttrSeqWithAddrAppend := RECORD
	UNSIGNED4 seq;
	RVAttributesWithAddrAppend;
END;

END;