export macro_compare_rva_3_0_pre(olddate, newdate, old_adate, new_adate) := macro
#workunit('name','RVA 3.0 Prescreen Comparison for Tracking');
#option ('hthorMemoryLimit', 1000);


IMPORT Risk_Indicators;

//===================  input-output files  ======================
infile_original :=  '~nmontpetit::out::rva_30_pre_tracking_'+(string)olddate+'_'+(string)old_adate;
infile_compare :=   '~nmontpetit::out::rva_30_pre_tracking_'+(string)newdate+'_'+(string)new_adate;

layout_rva_30 := RECORD
	string30 AccountNumber;
	string4 AgeOldestRecord; 
	string4 AgeNewestRecord; 
	string1 RecentUpdate;  //
	string3 SrcsConfirmIDAddrCount;  //
	string1 InvalidSSN; 
	string1 InvalidAddr; 
	string1 InvalidDL; 
	string1 InvalidPhone; 
	string1 VerificationFailure;//
	string1 SSNNotFound;
	string3 VerifiedName;
	string3 VerifiedSSN;
	string3 VerifiedPhone;
	string1 VerifiedPhoneFullName;
	string1 VerifiedPhoneLastName;
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
	string1 SSNDeceased;
	string8 SSNDateDeceased;//
	string1 SSNValid;//
	string1 SSNRecent;//
	string8 SSNLowIssueDate;//
	string8 SSNHighIssueDate;//
	string2 SSNIssueState;//
	string1 SSNNonUS;//
	string1 SSNIssuedPriorDOB;
	string1 SSN3Years;//
	string1 SSNAfter5;//
	string4 InputAddrAgeOldestRecord;//
	string4 InputAddrAgeNewestRecord;//
	string4 InputAddrALenOfRes;//
	string1 InputAddrDwellType;//
	string1 InputAddrLandUseCode;//
	string1 InputAddrOwnedBySubject;//
	string1 InputAddrFamilyOwned;//
	string1 InputAddrOccupantOwned;//
	string4 InputAddrAgeLastSale;//
	string InputAddrLastSalesPrice;//
	string1 InputAddrNotPrimaryRes;//
	string1 InputAddrActivePhoneList;//
	string10 InputAddrActivePhoneNumber;//
	string14 InputAddrTaxValue;//
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
	string4 CurrAddrAgeOldestRecord;//
	string4 CurrAddrAgeNewestRecord;//
	string4 CurrAddrLenOfRes;//
	string1 CurrAddrDwellType;//
	string1 CurrAddrALandUseCode;//
	string1 CurrAddrApplicantOwned;//
	string1 CurrAddrFamilyOwned;//
	string1 CurrAddrOccupantOwned;//
	string4 CurrAddrAgeLastSale;//
	string CurrAddrLastSalesPrice;//
	string1 CurrAddrNotPrimaryRes;//
	string1 CurrAddrActivePhoneList;//
	string10 CurrAddrActivePhoneNumber;//
	string14 CurrAddrTaxValue;//
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
	string4 PrevAddrAgeOldestRecord; //
	string4 PrevAddrAgeNewestRecord;//
	string4 PrevAddrLenOfRes;//
	string1 PrevAddrDwellType;//
	string1 PrevAddrLandUseCode;//
	string1 PrevAddrApplicantOwned;//
	string1 PrevAddrFamilyOwned;//
	string1 PrevAddrOccupantOwned;//
	string4 PrevAddrAgeLastSale;//
	string14 PrevAddrLastSalesPrice;//
	string1 PrevAddrPhoneListed;//
	string10 PrevAddrPhoneNumber;//
	string14 PrevAddrAssessedValue;//
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
	string1 InputCurrAddrMatch;//
	string4 InputCurrAddrDistance;//
	string1 InputCurrAddrStateDiff;//
	string InputCurrAddrTaxDiff;//
	string2 InputCurrEconTrajectory;//
	string1 InputPrevAddrMatch;//
	string4 CurrPrevAddrDistance;//
	string1 CurrPrevAddrStateDiff;//
	string CurrPrevAddrTaxDiff;//
	string2 PrevCurrEconTrajectory;//
	string1 EducationAttendedCollege;
	string1 EducationProgram2Yr;
	string1 EducationProgram4Yr;
	string1 EducationProgramGraduate;
	string1 EducationInstitutionPrivate;
	string1 EducationInstitutionRating;
	string1 AddrStability;//
	string1 StatusMostRecent;//
	string1 StatusPrevious; //
	string1 StatusNextPrevious;//
	string3 AddrChangeCount01;//
	string3 AddrChangeCount03; //
	string3 AddrChangeCount06; //
	string3 AddrChangeCount12; //
	string3 AddrChangeCount24; //
	string3 AddrChangeCount36; //
	string3 AddrChangeCount60; //
	string10 PredictedAnnualIncome;
	string3 PropOwnedCount; //
	string14 PropOwnedTaxTotal; //
	string3 PropOwnedHistoricalCount; //
	string4 PropAgeOldestPurchase;
	string4 PropAgeNewestPurchase;
	string4 PropAgeNewestSale;
	string14 PropNewestSalePrice;
	string8 PropNewestSalePurchaseIndex;
	string3 PropPurchasedCount01;//
	string3 PropPurchasedCount03;//
	string3 PropPurchasedCount06;//
	string3 PropPurchasedCount12;//
	string3 PropPurchasedCount24;//
	string3 PropPurchasedCount36;//
	string3 PropPurchasedCount60;//
	string3 PropSoldCount01;//
	string3 PropSoldCount03;//
	string3 PropSoldCount06;//
	string3 PropSoldCount12;//
	string3 PropSoldCount24;//
	string3 PropSoldCount36;//
	string3 PropSoldCount60;//
	string3 WatercraftCount;//
	string3 WatercraftCount01;//
	string3 WatercraftCount03;//
	string3 WatercraftCount06;//
	string3 WatercraftCount12;//
	string3 WatercraftCount24;//
	string3 WatercraftCount36;//
	string3 WatercraftCount60;//
	string3 AircraftCount;//
	string3 AircraftCount01;//
	string3 AircraftCount03;//
	string3 AircraftCount06;//
	string3 AircraftCount12;//
	string3 AircraftCount24;//
	string3 AircraftCount36;//
	string3 AircraftCount60;//
	string1 WealthIndex; //
	string3 SubPrimeSolicitedCount;
	string3 SubPrimeSolicitedCount01;
	string3 SubprimeSolicitedCount03;
	string3 SubprimeSolicitedCount06;
	string3 SubPrimeSolicitedCount12;
	string3 SubPrimeSolicitedCount24;
	string3 SubPrimeSolicitedCount36;
	string3 SubPrimeSolicitedCount60;
	string3 DerogCount;//
	string4 DerogAge;
	string3 FelonyCount;//
	string4 FelonyAge;
	string3 FelonyCount01;//
	string3 FelonyCount03;//
	string3 FelonyCount06;//
	string3 FelonyCount12;//
	string3 FelonyCount24;//
	string3 FelonyCount36;//
	string3 FelonyCount60;//
	string3 LienCount;//
	string3 LienFiledCount;//
	string4 LienFiledAge;
	string3 LienFiledCount01;//
	string3 LienFiledCount03;//
	string3 LienFiledCount06;//
	string3 LienFiledCount12;//
	string3 LienFiledCount24;//
	string3 LienFiledCount36;//
	string3 LienFiledCount60;//
	string3 LienReleasedCount;//
	string4 LienReleasedAge;
	string3 LienReleasedCount01;//
	string3 LienReleasedCount03;//
	string3 LienReleasedCount06;//
	string3 LienReleasedCount12;//
	string3 LienReleasedCount24;//
	string3 LienReleasedCount36;//
	string3 LienReleasedCount60;//
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
	string3 BankruptcyCount;//
	string4 BankruptcyAge;
	STRING1 BankruptcyType;//
	STRING35 BankruptcyStatus;//
	string3 BankruptcyCount01;//
	string3 BankruptcyCount03;//
	string3 BankruptcyCount06;//
	string3 BankruptcyCount12;//
	string3 BankruptcyCount24;//
	string3 BankruptcyCount36;//
	string3 BankruptcyCount60;//
	string3 EvictionCount;//
	string4 EvictionAge;
	string3 EvictionCount01;//
	string3 EvictionCount03; //
	string3 EvictionCount06; //
	string3 EvictionCount12;//
	string3 EvictionCount24;//
	string3 EvictionCount36;//
	string3 EvictionCount60;//
	string3 NonDerogCount;//
	string3 NonDerogCount01;//
	string3 NonDerogCount03; //
	string3 NonDerogCount06; //
	string3 NonDerogCount12;//
	string3 NonDerogCount24;//
	string3 NonDerogCount36;//
	string3 NonDerogCount60;//
	string3 ProfLicCount;//
	string4 ProfLicAge;
	string60 proflic_type;
	string1 ProfLicTypeCategory;
	string8 expire_date_last_proflic;
	string3 ProfLicCount01;//
	string3 ProfLicCount03;//
	string3 ProfLicCount06;//
	string3 ProfLicCount12;//
	string3 ProfLicCount24;//
	string3 ProfLicCount36;//
	string3 ProfLicCount60;//
	string3 ProflicExpireCount01;//
	string3 ProflicExpireCount03;//
	string3 ProflicExpireCount06;//
	string3 ProflicExpireCount12;//
	string3 ProflicExpireCount24;//
	string3 ProflicExpireCount36;//
	string3 ProflicExpireCount60;//
	string1 InputPhoneStatus;//
	string1 InputPhonePager;//
	string1 InputPhoneMobile;//
	string4 PhoneEDAAgeOldestRecord;
	string4 PhoneEDAAgeNewestRecord;
	string4 PhoneOtherAgeOldestRecord;
	string4 PhoneOtherAgeNewestRecord;
	string1 InvalidPhoneZip;//
	string4 InputPhoneAddrDist; //
	string1 InputAddrHighRisk;//
	string1 InputPhoneHighRisk;//
	string1 InputAddrPrison;//
	string1 InputZipPOBox;//
	string1 InputZipCorpMil;//
	string1 correctedFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 idTheftFlag;
	string1 PrescreenOptOut;
	string6 history_date;
	string200  errorcode;
end;

ds_original := 	dataset(infile_original, 	layout_rva_30, csv(heading(1), quote('"'), maxlength(32000)));
ds_compare := 	dataset(infile_compare, 	layout_rva_30, csv(heading(1), quote('"'), maxlength(32000)));

//output(ds_original);
//output(ds_compare);

layout_res := RECORD
	integer AccountNumber;
	integer AgeOldestRecord;
	integer AgeNewestRecord;
	integer RecentUpdate;
	integer SrcsConfirmIDAddrCount;
	integer InvalidSSN;
	integer InvalidAddr;
	integer InvalidDL;
	integer InvalidPhone;
	integer VerificationFailure;
	integer SSNNotFound;
	integer VerifiedName;
	integer VerifiedSSN;
	integer VerifiedPhone;
	integer VerifiedPhoneFullName;
	integer VerifiedPhoneLastName;
	integer VerifiedAddress;
	integer VerifiedDOB;
	integer InferredMinimumAge;
	integer BestReportedAge;
	integer SubjectSSNCount;
	integer SubjectAddrCount;
	integer SubjectPhoneCount;
	integer SubjectSSNRecentCount;
	integer SubjectAddrRecentCount;
	integer SubjectPhoneRecentCount;
	integer SSNIdentitiesCount;
	integer SSNAddrCount;
	integer SSNIdentitiesRecentCount;
	integer SSNAddrRecentCount;
	integer InputAddrIdentitiesCount;
	integer InputAddrSSNCount;
	integer InputAddrPhoneCount;
	integer InputAddrIdentitiesRecentCount;
	integer InputAddrSSNRecentCount;
	integer InputAddrPhoneRecentCount;
	integer PhoneIdentitiesCount;
	integer PhoneIdentitiesRecentCount;
	integer SSNDeceased;
	integer SSNDateDeceased;
	integer SSNValid;
	integer SSNRecent;
	integer SSNLowIssueDate;
	integer SSNHighIssueDate;
	integer SSNIssueState;
	integer SSNNonUS;
	integer SSNIssuedPriorDOB;
	integer SSN3Years;
	integer SSNAfter5;
	integer InputAddrAgeOldestRecord;
	integer InputAddrAgeNewestRecord;
	integer InputAddrALenOfRes;
	integer InputAddrDwellType;
	integer InputAddrLandUseCode;
	integer InputAddrOwnedBySubject;
	integer InputAddrFamilyOwned;
	integer InputAddrOccupantOwned;
	integer InputAddrAgeLastSale;
	integer InputAddrLastSalesPrice;
	integer InputAddrNotPrimaryRes;
	integer InputAddrActivePhoneList;
	integer InputAddrActivePhoneNumber;
	integer InputAddrTaxValue;
	integer InputAddrTaxYr;
	integer InputAddrTaxMarketValue;
	integer InputAddrAVMTax;
	integer InputAddrAVMSalesPrice;
	integer InputAddrAVMHedonic;
	integer InputAddrAVMValue;
	integer InputAddrAVMConfidence;
	integer InputAddrCountyIndex;
	integer InputAddrTractIndex;
	integer InputAddrBlockIndex;
	integer CurrAddrAgeOldestRecord;
	integer CurrAddrAgeNewestRecord;
	integer CurrAddrLenOfRes;
	integer CurrAddrDwellType;
	integer CurrAddrALandUseCode;
	integer CurrAddrApplicantOwned;
	integer CurrAddrFamilyOwned;
	integer CurrAddrOccupantOwned;
	integer CurrAddrAgeLastSale;
	integer CurrAddrLastSalesPrice;
	integer CurrAddrNotPrimaryRes;
	integer CurrAddrActivePhoneList;
	integer CurrAddrActivePhoneNumber;
	integer CurrAddrTaxValue;
	integer CurrAddrTaxYr;
	integer CurrAddrTaxMarketValue;
	integer CurrAddrAVMTax;
	integer CurrAddrAVMSalesPrice;
	integer CurrAddrAVMHedonic;
	integer CurrAddrAVMValue;
	integer CurrAddrAVMConfidence;
	integer CurrAddrCountyIndex;
	integer CurrAddrTractIndex;
	integer CurrAddrBlockIndex;
	integer PrevAddrAgeOldestRecord;
	integer PrevAddrAgeNewestRecord;
	integer PrevAddrLenOfRes;
	integer PrevAddrDwellType;
	integer PrevAddrLandUseCode;
	integer PrevAddrApplicantOwned;
	integer PrevAddrFamilyOwned;
	integer PrevAddrOccupantOwned;
	integer PrevAddrAgeLastSale;
	integer PrevAddrLastSalesPrice;
	integer PrevAddrPhoneListed;
	integer PrevAddrPhoneNumber;
	integer PrevAddrAssessedValue;
	integer PrevAddrTaxYr;
	integer PrevAddrTaxMarketValue;
	integer PrevAddrAVMTax;
	integer PrevAddrAVMSalesPrice;
	integer PrevAddrAVMHedonic;
	integer PrevAddrAVMValue;
	integer PrevAddrAVMConfidence;
	integer PrevAddrCountyIndex;
	integer PrevAddrTractIndex;
	integer PrevAddrBlockIndex;
	integer InputCurrAddrMatch;
	integer InputCurrAddrDistance;
	integer InputCurrAddrStateDiff;
	integer InputCurrAddrTaxDiff;
	integer InputCurrEconTrajectory;
	integer InputPrevAddrMatch;
	integer CurrPrevAddrDistance;
	integer CurrPrevAddrStateDiff;
	integer CurrPrevAddrTaxDiff;
	integer PrevCurrEconTrajectory;
	integer EducationAttendedCollege;
	integer EducationProgram2Yr;
	integer EducationProgram4Yr;
	integer EducationProgramGraduate;
	integer EducationInstitutionPrivate;
	integer EducationInstitutionRating;
	integer AddrStability;
	integer StatusMostRecent;
	integer StatusPrevious;
	integer StatusNextPrevious;
	integer AddrChangeCount01;
	integer AddrChangeCount03;
	integer AddrChangeCount06;
	integer AddrChangeCount12;
	integer AddrChangeCount24;
	integer AddrChangeCount36;
	integer AddrChangeCount60;
	integer PredictedAnnualIncome;
	integer PropOwnedCount;
	integer PropOwnedTaxTotal;
	integer PropOwnedHistoricalCount;
	integer PropAgeOldestPurchase;
	integer PropAgeNewestPurchase;
	integer PropAgeNewestSale;
	integer PropNewestSalePrice;
	integer PropNewestSalePurchaseIndex;
	integer PropPurchasedCount01;
	integer PropPurchasedCount03;
	integer PropPurchasedCount06;
	integer PropPurchasedCount12;
	integer PropPurchasedCount24;
	integer PropPurchasedCount36;
	integer PropPurchasedCount60;
	integer PropSoldCount01;
	integer PropSoldCount03;
	integer PropSoldCount06;
	integer PropSoldCount12;
	integer PropSoldCount24;
	integer PropSoldCount36;
	integer PropSoldCount60;
	integer WatercraftCount;
	integer WatercraftCount01;
	integer WatercraftCount03;
	integer WatercraftCount06;
	integer WatercraftCount12;
	integer WatercraftCount24;
	integer WatercraftCount36;
	integer WatercraftCount60;
	integer AircraftCount;
	integer AircraftCount01;
	integer AircraftCount03;
	integer AircraftCount06;
	integer AircraftCount12;
	integer AircraftCount24;
	integer AircraftCount36;
	integer AircraftCount60;
	integer WealthIndex;
	integer SubPrimeSolicitedCount;
	integer SubPrimeSolicitedCount01;
	integer SubprimeSolicitedCount03;
	integer SubprimeSolicitedCount06;
	integer SubPrimeSolicitedCount12;
	integer SubPrimeSolicitedCount24;
	integer SubPrimeSolicitedCount36;
	integer SubPrimeSolicitedCount60;
	integer DerogCount;
	integer DerogAge;
	integer FelonyCount;
	integer FelonyAge;
	integer FelonyCount01;
	integer FelonyCount03;
	integer FelonyCount06;
	integer FelonyCount12;
	integer FelonyCount24;
	integer FelonyCount36;
	integer FelonyCount60;
	integer LienCount;
	integer LienFiledCount;
	integer LienFiledAge;
	integer LienFiledCount01;
	integer LienFiledCount03;
	integer LienFiledCount06;
	integer LienFiledCount12;
	integer LienFiledCount24;
	integer LienFiledCount36;
	integer LienFiledCount60;
	integer LienReleasedCount;
	integer LienReleasedAge;
	integer LienReleasedCount01;
	integer LienReleasedCount03;
	integer LienReleasedCount06;
	integer LienReleasedCount12;
	integer LienReleasedCount24;
	integer LienReleasedCount36;
	integer LienReleasedCount60;
	integer LienFederalTaxFiledTotal;
	integer LienTaxOtherFiledTotal;
	integer LienForeclosureFiledTotal;
	integer LienPreforeclosureFiledTotal;
	integer LienLandlordTenantFiledTotal;
	integer LienJudgmentFiledTotal;
	integer LienSmallClaimsFiledTotal;
	integer LienOtherFiledTotal;
	integer LienFederalTaxReleasedTotal;
	integer LienTaxOtherReleasedTotal;
	integer LienForeclosureReleasedTotal;
	integer LienPreforeclosureReleasedTotal;
	integer LienLandlordTenantReleasedTotal;
	integer LienJudgmentReleasedTotal;
	integer LienSmallClaimsReleasedTotal;
	integer LienOtherReleasedTotal;
	integer LienFederalTaxFiledCount;
	integer LienTaxOtherFiledCount;
	integer LienForeclosureFiledCount;
	integer LienPreforeclosureFiledCount;
	integer LienLandlordTenantFiledCount;
	integer LienJudgmentFiledCount;
	integer LienSmallClaimsFiledCount;
	integer LienOtherFiledCount;
	integer LienFederalTaxReleasedCount;
	integer LienTaxOtherReleasedCount;
	integer LienForeclosureReleasedCount;
	integer LienPreforeclosureReleasedCount;
	integer LienLandlordTenantReleasedCount;
	integer LienJudgmentReleasedCount;
	integer LienSmallClaimsReleasedCount;
	integer LienOtherReleasedCount;
	integer BankruptcyCount;
	integer BankruptcyAge;
	integer BankruptcyType;
	integer BankruptcyStatus;
	integer BankruptcyCount01;
	integer BankruptcyCount03;
	integer BankruptcyCount06;
	integer BankruptcyCount12;
	integer BankruptcyCount24;
	integer BankruptcyCount36;
	integer BankruptcyCount60;
	integer EvictionCount;
	integer EvictionAge;
	integer EvictionCount01;
	integer EvictionCount03;
	integer EvictionCount06;
	integer EvictionCount12;
	integer EvictionCount24;
	integer EvictionCount36;
	integer EvictionCount60;
	integer NonDerogCount;
	integer NonDerogCount01;
	integer NonDerogCount03;
	integer NonDerogCount06;
	integer NonDerogCount12;
	integer NonDerogCount24;
	integer NonDerogCount36;
	integer NonDerogCount60;
	integer ProfLicCount;
	integer ProfLicAge;
	integer proflic_type;
	integer ProfLicTypeCategory;
	integer expire_date_last_proflic;
	integer ProfLicCount01;
	integer ProfLicCount03;
	integer ProfLicCount06;
	integer ProfLicCount12;
	integer ProfLicCount24;
	integer ProfLicCount36;
	integer ProfLicCount60;
	integer ProflicExpireCount01;
	integer ProflicExpireCount03;
	integer ProflicExpireCount06;
	integer ProflicExpireCount12;
	integer ProflicExpireCount24;
	integer ProflicExpireCount36;
	integer ProflicExpireCount60;
	integer InputPhoneStatus;
	integer InputPhonePager;
	integer InputPhoneMobile;
	integer PhoneEDAAgeOldestRecord;
	integer PhoneEDAAgeNewestRecord;
	integer PhoneOtherAgeOldestRecord;
	integer PhoneOtherAgeNewestRecord;
	integer InvalidPhoneZip;
	integer InputPhoneAddrDist;
	integer InputAddrHighRisk;
	integer InputPhoneHighRisk;
	integer InputAddrPrison;
	integer InputZipPOBox;
	integer InputZipCorpMil;
	integer correctedFlag;
	integer securityFreeze;
	integer securityAlert;
	integer idTheftFlag;
	integer PrescreenOptOut;
	integer history_date;
	integer errorcode;
END;

layout_res mk_matches(layout_rva_30 le, layout_rva_30 ri) := TRANSFORM
	self.AccountNumber                   :=(integer)(le.AccountNumber                    != ri.AccountNumber);
	self.AgeOldestRecord                 :=(integer)(le.AgeOldestRecord                  != ri.AgeOldestRecord);
	self.AgeNewestRecord                 :=(integer)(le.AgeNewestRecord                  != ri.AgeNewestRecord);
	self.RecentUpdate                    :=(integer)(le.RecentUpdate                     != ri.RecentUpdate);
	self.SrcsConfirmIDAddrCount          :=(integer)(le.SrcsConfirmIDAddrCount           != ri.SrcsConfirmIDAddrCount);
	self.InvalidSSN                      :=(integer)(le.InvalidSSN                       != ri.InvalidSSN);
	self.InvalidAddr                     :=(integer)(le.InvalidAddr                      != ri.InvalidAddr);
	self.InvalidDL                       :=(integer)(le.InvalidDL                        != ri.InvalidDL);
	self.InvalidPhone                    :=(integer)(le.InvalidPhone                     != ri.InvalidPhone);
	self.VerificationFailure             :=(integer)(le.VerificationFailure              != ri.VerificationFailure);
	self.SSNNotFound                     :=(integer)(le.SSNNotFound                      != ri.SSNNotFound);
	self.VerifiedName                    :=(integer)(le.VerifiedName                     != ri.VerifiedName);
	self.VerifiedSSN                     :=(integer)(le.VerifiedSSN                      != ri.VerifiedSSN);
	self.VerifiedPhone                   :=(integer)(le.VerifiedPhone                    != ri.VerifiedPhone);
	self.VerifiedPhoneFullName           :=(integer)(le.VerifiedPhoneFullName            != ri.VerifiedPhoneFullName);
	self.VerifiedPhoneLastName           :=(integer)(le.VerifiedPhoneLastName            != ri.VerifiedPhoneLastName);
	self.VerifiedAddress                 :=(integer)(le.VerifiedAddress                  != ri.VerifiedAddress);
	self.VerifiedDOB                     :=(integer)(le.VerifiedDOB                      != ri.VerifiedDOB);
	self.InferredMinimumAge              :=(integer)(le.InferredMinimumAge               != ri.InferredMinimumAge);
	self.BestReportedAge                 :=(integer)(le.BestReportedAge                  != ri.BestReportedAge);
	self.SubjectSSNCount                 :=(integer)(le.SubjectSSNCount                  != ri.SubjectSSNCount);
	self.SubjectAddrCount                :=(integer)(le.SubjectAddrCount                 != ri.SubjectAddrCount);
	self.SubjectPhoneCount               :=(integer)(le.SubjectPhoneCount                != ri.SubjectPhoneCount);
	self.SubjectSSNRecentCount           :=(integer)(le.SubjectSSNRecentCount            != ri.SubjectSSNRecentCount);
	self.SubjectAddrRecentCount          :=(integer)(le.SubjectAddrRecentCount           != ri.SubjectAddrRecentCount);
	self.SubjectPhoneRecentCount         :=(integer)(le.SubjectPhoneRecentCount          != ri.SubjectPhoneRecentCount);
	self.SSNIdentitiesCount              :=(integer)(le.SSNIdentitiesCount               != ri.SSNIdentitiesCount);
	self.SSNAddrCount                    :=(integer)(le.SSNAddrCount                     != ri.SSNAddrCount);
	self.SSNIdentitiesRecentCount        :=(integer)(le.SSNIdentitiesRecentCount         != ri.SSNIdentitiesRecentCount);
	self.SSNAddrRecentCount              :=(integer)(le.SSNAddrRecentCount               != ri.SSNAddrRecentCount);
	self.InputAddrIdentitiesCount        :=(integer)(le.InputAddrIdentitiesCount         != ri.InputAddrIdentitiesCount);
	self.InputAddrSSNCount               :=(integer)(le.InputAddrSSNCount                != ri.InputAddrSSNCount);
	self.InputAddrPhoneCount             :=(integer)(le.InputAddrPhoneCount              != ri.InputAddrPhoneCount);
	self.InputAddrIdentitiesRecentCount  :=(integer)(le.InputAddrIdentitiesRecentCount   != ri.InputAddrIdentitiesRecentCount);
	self.InputAddrSSNRecentCount         :=(integer)(le.InputAddrSSNRecentCount          != ri.InputAddrSSNRecentCount);
	self.InputAddrPhoneRecentCount       :=(integer)(le.InputAddrPhoneRecentCount        != ri.InputAddrPhoneRecentCount);
	self.PhoneIdentitiesCount            :=(integer)(le.PhoneIdentitiesCount             != ri.PhoneIdentitiesCount);
	self.PhoneIdentitiesRecentCount      :=(integer)(le.PhoneIdentitiesRecentCount       != ri.PhoneIdentitiesRecentCount);
	self.SSNDeceased                     :=(integer)(le.SSNDeceased                      != ri.SSNDeceased);
	self.SSNDateDeceased                 :=(integer)(le.SSNDateDeceased                  != ri.SSNDateDeceased);
	self.SSNValid                        :=(integer)(le.SSNValid                         != ri.SSNValid);
	self.SSNRecent                       :=(integer)(le.SSNRecent                        != ri.SSNRecent);
	self.SSNLowIssueDate                 :=(integer)(le.SSNLowIssueDate                  != ri.SSNLowIssueDate);
	self.SSNHighIssueDate                :=(integer)(le.SSNHighIssueDate                 != ri.SSNHighIssueDate);
	self.SSNIssueState                   :=(integer)(le.SSNIssueState                    != ri.SSNIssueState);
	self.SSNNonUS                        :=(integer)(le.SSNNonUS                         != ri.SSNNonUS);
	self.SSNIssuedPriorDOB               :=(integer)(le.SSNIssuedPriorDOB                != ri.SSNIssuedPriorDOB);
	self.SSN3Years                       :=(integer)(le.SSN3Years                        != ri.SSN3Years);
	self.SSNAfter5                       :=(integer)(le.SSNAfter5                        != ri.SSNAfter5);
	self.InputAddrAgeOldestRecord        :=(integer)(le.InputAddrAgeOldestRecord         != ri.InputAddrAgeOldestRecord);
	self.InputAddrAgeNewestRecord        :=(integer)(le.InputAddrAgeNewestRecord         != ri.InputAddrAgeNewestRecord);
	self.InputAddrALenOfRes              :=(integer)(le.InputAddrALenOfRes               != ri.InputAddrALenOfRes);
	self.InputAddrDwellType              :=(integer)(le.InputAddrDwellType               != ri.InputAddrDwellType);
	self.InputAddrLandUseCode            :=(integer)(le.InputAddrLandUseCode             != ri.InputAddrLandUseCode);
	self.InputAddrOwnedBySubject         :=(integer)(le.InputAddrOwnedBySubject          != ri.InputAddrOwnedBySubject);
	self.InputAddrFamilyOwned            :=(integer)(le.InputAddrFamilyOwned             != ri.InputAddrFamilyOwned);
	self.InputAddrOccupantOwned          :=(integer)(le.InputAddrOccupantOwned           != ri.InputAddrOccupantOwned);
	self.InputAddrAgeLastSale            :=(integer)(le.InputAddrAgeLastSale             != ri.InputAddrAgeLastSale);
	self.InputAddrLastSalesPrice         :=(integer)(le.InputAddrLastSalesPrice          != ri.InputAddrLastSalesPrice);
	self.InputAddrNotPrimaryRes          :=(integer)(le.InputAddrNotPrimaryRes           != ri.InputAddrNotPrimaryRes);
	self.InputAddrActivePhoneList        :=(integer)(le.InputAddrActivePhoneList         != ri.InputAddrActivePhoneList);
	self.InputAddrActivePhoneNumber      :=(integer)(le.InputAddrActivePhoneNumber       != ri.InputAddrActivePhoneNumber);
	self.InputAddrTaxValue               :=(integer)(le.InputAddrTaxValue                != ri.InputAddrTaxValue);
	self.InputAddrTaxYr                  :=(integer)(le.InputAddrTaxYr                   != ri.InputAddrTaxYr);
	self.InputAddrTaxMarketValue         :=(integer)(le.InputAddrTaxMarketValue          != ri.InputAddrTaxMarketValue);
	self.InputAddrAVMTax                 :=(integer)(le.InputAddrAVMTax                  != ri.InputAddrAVMTax);
	self.InputAddrAVMSalesPrice          :=(integer)(le.InputAddrAVMSalesPrice           != ri.InputAddrAVMSalesPrice);
	self.InputAddrAVMHedonic             :=(integer)(le.InputAddrAVMHedonic              != ri.InputAddrAVMHedonic);
	self.InputAddrAVMValue               :=(integer)(le.InputAddrAVMValue                != ri.InputAddrAVMValue);
	self.InputAddrAVMConfidence          :=(integer)(le.InputAddrAVMConfidence           != ri.InputAddrAVMConfidence);
	self.InputAddrCountyIndex            :=(integer)(le.InputAddrCountyIndex             != ri.InputAddrCountyIndex);
	self.InputAddrTractIndex             :=(integer)(le.InputAddrTractIndex              != ri.InputAddrTractIndex);
	self.InputAddrBlockIndex             :=(integer)(le.InputAddrBlockIndex              != ri.InputAddrBlockIndex);
	self.CurrAddrAgeOldestRecord         :=(integer)(le.CurrAddrAgeOldestRecord          != ri.CurrAddrAgeOldestRecord);
	self.CurrAddrAgeNewestRecord         :=(integer)(le.CurrAddrAgeNewestRecord          != ri.CurrAddrAgeNewestRecord);
	self.CurrAddrLenOfRes                :=(integer)(le.CurrAddrLenOfRes                 != ri.CurrAddrLenOfRes);
	self.CurrAddrDwellType               :=(integer)(le.CurrAddrDwellType                != ri.CurrAddrDwellType);
	self.CurrAddrALandUseCode            :=(integer)(le.CurrAddrALandUseCode             != ri.CurrAddrALandUseCode);
	self.CurrAddrApplicantOwned          :=(integer)(le.CurrAddrApplicantOwned           != ri.CurrAddrApplicantOwned);
	self.CurrAddrFamilyOwned             :=(integer)(le.CurrAddrFamilyOwned              != ri.CurrAddrFamilyOwned);
	self.CurrAddrOccupantOwned           :=(integer)(le.CurrAddrOccupantOwned            != ri.CurrAddrOccupantOwned);
	self.CurrAddrAgeLastSale             :=(integer)(le.CurrAddrAgeLastSale              != ri.CurrAddrAgeLastSale);
	self.CurrAddrLastSalesPrice          :=(integer)(le.CurrAddrLastSalesPrice           != ri.CurrAddrLastSalesPrice);
	self.CurrAddrNotPrimaryRes           :=(integer)(le.CurrAddrNotPrimaryRes            != ri.CurrAddrNotPrimaryRes);
	self.CurrAddrActivePhoneList         :=(integer)(le.CurrAddrActivePhoneList          != ri.CurrAddrActivePhoneList);
	self.CurrAddrActivePhoneNumber       :=(integer)(le.CurrAddrActivePhoneNumber        != ri.CurrAddrActivePhoneNumber);
	self.CurrAddrTaxValue                :=(integer)(le.CurrAddrTaxValue                 != ri.CurrAddrTaxValue);
	self.CurrAddrTaxYr                   :=(integer)(le.CurrAddrTaxYr                    != ri.CurrAddrTaxYr);
	self.CurrAddrTaxMarketValue          :=(integer)(le.CurrAddrTaxMarketValue           != ri.CurrAddrTaxMarketValue);
	self.CurrAddrAVMTax                  :=(integer)(le.CurrAddrAVMTax                   != ri.CurrAddrAVMTax);
	self.CurrAddrAVMSalesPrice           :=(integer)(le.CurrAddrAVMSalesPrice            != ri.CurrAddrAVMSalesPrice);
	self.CurrAddrAVMHedonic              :=(integer)(le.CurrAddrAVMHedonic               != ri.CurrAddrAVMHedonic);
	self.CurrAddrAVMValue                :=(integer)(le.CurrAddrAVMValue                 != ri.CurrAddrAVMValue);
	self.CurrAddrAVMConfidence           :=(integer)(le.CurrAddrAVMConfidence            != ri.CurrAddrAVMConfidence);
	self.CurrAddrCountyIndex             :=(integer)(le.CurrAddrCountyIndex              != ri.CurrAddrCountyIndex);
	self.CurrAddrTractIndex              :=(integer)(le.CurrAddrTractIndex               != ri.CurrAddrTractIndex);
	self.CurrAddrBlockIndex              :=(integer)(le.CurrAddrBlockIndex               != ri.CurrAddrBlockIndex);
	self.PrevAddrAgeOldestRecord         :=(integer)(le.PrevAddrAgeOldestRecord          != ri.PrevAddrAgeOldestRecord);
	self.PrevAddrAgeNewestRecord         :=(integer)(le.PrevAddrAgeNewestRecord          != ri.PrevAddrAgeNewestRecord);
	self.PrevAddrLenOfRes                :=(integer)(le.PrevAddrLenOfRes                 != ri.PrevAddrLenOfRes);
	self.PrevAddrDwellType               :=(integer)(le.PrevAddrDwellType                != ri.PrevAddrDwellType);
	self.PrevAddrLandUseCode             :=(integer)(le.PrevAddrLandUseCode              != ri.PrevAddrLandUseCode);
	self.PrevAddrApplicantOwned          :=(integer)(le.PrevAddrApplicantOwned           != ri.PrevAddrApplicantOwned);
	self.PrevAddrFamilyOwned             :=(integer)(le.PrevAddrFamilyOwned              != ri.PrevAddrFamilyOwned);
	self.PrevAddrOccupantOwned           :=(integer)(le.PrevAddrOccupantOwned            != ri.PrevAddrOccupantOwned);
	self.PrevAddrAgeLastSale             :=(integer)(le.PrevAddrAgeLastSale              != ri.PrevAddrAgeLastSale);
	self.PrevAddrLastSalesPrice          :=(integer)(le.PrevAddrLastSalesPrice           != ri.PrevAddrLastSalesPrice);
	self.PrevAddrPhoneListed             :=(integer)(le.PrevAddrPhoneListed              != ri.PrevAddrPhoneListed);
	self.PrevAddrPhoneNumber             :=(integer)(le.PrevAddrPhoneNumber              != ri.PrevAddrPhoneNumber);
	self.PrevAddrAssessedValue           :=(integer)(le.PrevAddrAssessedValue            != ri.PrevAddrAssessedValue);
	self.PrevAddrTaxYr                   :=(integer)(le.PrevAddrTaxYr                    != ri.PrevAddrTaxYr);
	self.PrevAddrTaxMarketValue          :=(integer)(le.PrevAddrTaxMarketValue           != ri.PrevAddrTaxMarketValue);
	self.PrevAddrAVMTax                  :=(integer)(le.PrevAddrAVMTax                   != ri.PrevAddrAVMTax);
	self.PrevAddrAVMSalesPrice           :=(integer)(le.PrevAddrAVMSalesPrice            != ri.PrevAddrAVMSalesPrice);
	self.PrevAddrAVMHedonic              :=(integer)(le.PrevAddrAVMHedonic               != ri.PrevAddrAVMHedonic);
	self.PrevAddrAVMValue                :=(integer)(le.PrevAddrAVMValue                 != ri.PrevAddrAVMValue);
	self.PrevAddrAVMConfidence           :=(integer)(le.PrevAddrAVMConfidence            != ri.PrevAddrAVMConfidence);
	self.PrevAddrCountyIndex             :=(integer)(le.PrevAddrCountyIndex              != ri.PrevAddrCountyIndex);
	self.PrevAddrTractIndex              :=(integer)(le.PrevAddrTractIndex               != ri.PrevAddrTractIndex);
	self.PrevAddrBlockIndex              :=(integer)(le.PrevAddrBlockIndex               != ri.PrevAddrBlockIndex);
	self.InputCurrAddrMatch              :=(integer)(le.InputCurrAddrMatch               != ri.InputCurrAddrMatch);
	self.InputCurrAddrDistance           :=(integer)(le.InputCurrAddrDistance            != ri.InputCurrAddrDistance);
	self.InputCurrAddrStateDiff          :=(integer)(le.InputCurrAddrStateDiff           != ri.InputCurrAddrStateDiff);
	self.InputCurrAddrTaxDiff            :=(integer)(le.InputCurrAddrTaxDiff             != ri.InputCurrAddrTaxDiff);
	self.InputCurrEconTrajectory         :=(integer)(le.InputCurrEconTrajectory          != ri.InputCurrEconTrajectory);
	self.InputPrevAddrMatch              :=(integer)(le.InputPrevAddrMatch               != ri.InputPrevAddrMatch);
	self.CurrPrevAddrDistance            :=(integer)(le.CurrPrevAddrDistance             != ri.CurrPrevAddrDistance);
	self.CurrPrevAddrStateDiff           :=(integer)(le.CurrPrevAddrStateDiff            != ri.CurrPrevAddrStateDiff);
	self.CurrPrevAddrTaxDiff             :=(integer)(le.CurrPrevAddrTaxDiff              != ri.CurrPrevAddrTaxDiff);
	self.PrevCurrEconTrajectory          :=(integer)(le.PrevCurrEconTrajectory           != ri.PrevCurrEconTrajectory);
	self.EducationAttendedCollege        :=(integer)(le.EducationAttendedCollege         != ri.EducationAttendedCollege);
	self.EducationProgram2Yr             :=(integer)(le.EducationProgram2Yr              != ri.EducationProgram2Yr);
	self.EducationProgram4Yr             :=(integer)(le.EducationProgram4Yr              != ri.EducationProgram4Yr);
	self.EducationProgramGraduate        :=(integer)(le.EducationProgramGraduate         != ri.EducationProgramGraduate);
	self.EducationInstitutionPrivate     :=(integer)(le.EducationInstitutionPrivate      != ri.EducationInstitutionPrivate);
	self.EducationInstitutionRating      :=(integer)(le.EducationInstitutionRating       != ri.EducationInstitutionRating);
	self.AddrStability                   :=(integer)(le.AddrStability                    != ri.AddrStability);
	self.StatusMostRecent                :=(integer)(le.StatusMostRecent                 != ri.StatusMostRecent);
	self.StatusPrevious                  :=(integer)(le.StatusPrevious                   != ri.StatusPrevious);
	self.StatusNextPrevious              :=(integer)(le.StatusNextPrevious               != ri.StatusNextPrevious);
	self.AddrChangeCount01               :=(integer)(le.AddrChangeCount01                != ri.AddrChangeCount01);
	self.AddrChangeCount03               :=(integer)(le.AddrChangeCount03                != ri.AddrChangeCount03);
	self.AddrChangeCount06               :=(integer)(le.AddrChangeCount06                != ri.AddrChangeCount06);
	self.AddrChangeCount12               :=(integer)(le.AddrChangeCount12                != ri.AddrChangeCount12);
	self.AddrChangeCount24               :=(integer)(le.AddrChangeCount24                != ri.AddrChangeCount24);
	self.AddrChangeCount36               :=(integer)(le.AddrChangeCount36                != ri.AddrChangeCount36);
	self.AddrChangeCount60               :=(integer)(le.AddrChangeCount60                != ri.AddrChangeCount60);
	self.PredictedAnnualIncome           :=(integer)(le.PredictedAnnualIncome            != ri.PredictedAnnualIncome);
	self.PropOwnedCount                  :=(integer)(le.PropOwnedCount                   != ri.PropOwnedCount);
	self.PropOwnedTaxTotal               :=(integer)(le.PropOwnedTaxTotal                != ri.PropOwnedTaxTotal);
	self.PropOwnedHistoricalCount        :=(integer)(le.PropOwnedHistoricalCount         != ri.PropOwnedHistoricalCount);
	self.PropAgeOldestPurchase           :=(integer)(le.PropAgeOldestPurchase            != ri.PropAgeOldestPurchase);
	self.PropAgeNewestPurchase           :=(integer)(le.PropAgeNewestPurchase            != ri.PropAgeNewestPurchase);
	self.PropAgeNewestSale               :=(integer)(le.PropAgeNewestSale                != ri.PropAgeNewestSale);
	self.PropNewestSalePrice             :=(integer)(le.PropNewestSalePrice              != ri.PropNewestSalePrice);
	self.PropNewestSalePurchaseIndex     :=(integer)(le.PropNewestSalePurchaseIndex      != ri.PropNewestSalePurchaseIndex);
	self.PropPurchasedCount01            :=(integer)(le.PropPurchasedCount01             != ri.PropPurchasedCount01);
	self.PropPurchasedCount03            :=(integer)(le.PropPurchasedCount03             != ri.PropPurchasedCount03);
	self.PropPurchasedCount06            :=(integer)(le.PropPurchasedCount06             != ri.PropPurchasedCount06);
	self.PropPurchasedCount12            :=(integer)(le.PropPurchasedCount12             != ri.PropPurchasedCount12);
	self.PropPurchasedCount24            :=(integer)(le.PropPurchasedCount24             != ri.PropPurchasedCount24);
	self.PropPurchasedCount36            :=(integer)(le.PropPurchasedCount36             != ri.PropPurchasedCount36);
	self.PropPurchasedCount60            :=(integer)(le.PropPurchasedCount60             != ri.PropPurchasedCount60);
	self.PropSoldCount01                 :=(integer)(le.PropSoldCount01                  != ri.PropSoldCount01);
	self.PropSoldCount03                 :=(integer)(le.PropSoldCount03                  != ri.PropSoldCount03);
	self.PropSoldCount06                 :=(integer)(le.PropSoldCount06                  != ri.PropSoldCount06);
	self.PropSoldCount12                 :=(integer)(le.PropSoldCount12                  != ri.PropSoldCount12);
	self.PropSoldCount24                 :=(integer)(le.PropSoldCount24                  != ri.PropSoldCount24);
	self.PropSoldCount36                 :=(integer)(le.PropSoldCount36                  != ri.PropSoldCount36);
	self.PropSoldCount60                 :=(integer)(le.PropSoldCount60                  != ri.PropSoldCount60);
	self.WatercraftCount                 :=(integer)(le.WatercraftCount                  != ri.WatercraftCount);
	self.WatercraftCount01               :=(integer)(le.WatercraftCount01                != ri.WatercraftCount01);
	self.WatercraftCount03               :=(integer)(le.WatercraftCount03                != ri.WatercraftCount03);
	self.WatercraftCount06               :=(integer)(le.WatercraftCount06                != ri.WatercraftCount06);
	self.WatercraftCount12               :=(integer)(le.WatercraftCount12                != ri.WatercraftCount12);
	self.WatercraftCount24               :=(integer)(le.WatercraftCount24                != ri.WatercraftCount24);
	self.WatercraftCount36               :=(integer)(le.WatercraftCount36                != ri.WatercraftCount36);
	self.WatercraftCount60               :=(integer)(le.WatercraftCount60                != ri.WatercraftCount60);
	self.AircraftCount                   :=(integer)(le.AircraftCount                    != ri.AircraftCount);
	self.AircraftCount01                 :=(integer)(le.AircraftCount01                  != ri.AircraftCount01);
	self.AircraftCount03                 :=(integer)(le.AircraftCount03                  != ri.AircraftCount03);
	self.AircraftCount06                 :=(integer)(le.AircraftCount06                  != ri.AircraftCount06);
	self.AircraftCount12                 :=(integer)(le.AircraftCount12                  != ri.AircraftCount12);
	self.AircraftCount24                 :=(integer)(le.AircraftCount24                  != ri.AircraftCount24);
	self.AircraftCount36                 :=(integer)(le.AircraftCount36                  != ri.AircraftCount36);
	self.AircraftCount60                 :=(integer)(le.AircraftCount60                  != ri.AircraftCount60);
	self.WealthIndex                     :=(integer)(le.WealthIndex                      != ri.WealthIndex);
	self.SubPrimeSolicitedCount          :=(integer)(le.SubPrimeSolicitedCount           != ri.SubPrimeSolicitedCount);
	self.SubPrimeSolicitedCount01        :=(integer)(le.SubPrimeSolicitedCount01         != ri.SubPrimeSolicitedCount01);
	self.SubprimeSolicitedCount03        :=(integer)(le.SubprimeSolicitedCount03         != ri.SubprimeSolicitedCount03);
	self.SubprimeSolicitedCount06        :=(integer)(le.SubprimeSolicitedCount06         != ri.SubprimeSolicitedCount06);
	self.SubPrimeSolicitedCount12        :=(integer)(le.SubPrimeSolicitedCount12         != ri.SubPrimeSolicitedCount12);
	self.SubPrimeSolicitedCount24        :=(integer)(le.SubPrimeSolicitedCount24         != ri.SubPrimeSolicitedCount24);
	self.SubPrimeSolicitedCount36        :=(integer)(le.SubPrimeSolicitedCount36         != ri.SubPrimeSolicitedCount36);
	self.SubPrimeSolicitedCount60        :=(integer)(le.SubPrimeSolicitedCount60         != ri.SubPrimeSolicitedCount60);
	self.DerogCount                      :=(integer)(le.DerogCount                       != ri.DerogCount);
	self.DerogAge                        :=(integer)(le.DerogAge                         != ri.DerogAge);
	self.FelonyCount                     :=(integer)(le.FelonyCount                      != ri.FelonyCount);
	self.FelonyAge                       :=(integer)(le.FelonyAge                        != ri.FelonyAge);
	self.FelonyCount01                   :=(integer)(le.FelonyCount01                    != ri.FelonyCount01);
	self.FelonyCount03                   :=(integer)(le.FelonyCount03                    != ri.FelonyCount03);
	self.FelonyCount06                   :=(integer)(le.FelonyCount06                    != ri.FelonyCount06);
	self.FelonyCount12                   :=(integer)(le.FelonyCount12                    != ri.FelonyCount12);
	self.FelonyCount24                   :=(integer)(le.FelonyCount24                    != ri.FelonyCount24);
	self.FelonyCount36                   :=(integer)(le.FelonyCount36                    != ri.FelonyCount36);
	self.FelonyCount60                   :=(integer)(le.FelonyCount60                    != ri.FelonyCount60);
	self.LienCount                       :=(integer)(le.LienCount                        != ri.LienCount);
	self.LienFiledCount                  :=(integer)(le.LienFiledCount                   != ri.LienFiledCount);
	self.LienFiledAge                    :=(integer)(le.LienFiledAge                     != ri.LienFiledAge);
	self.LienFiledCount01                :=(integer)(le.LienFiledCount01                 != ri.LienFiledCount01);
	self.LienFiledCount03                :=(integer)(le.LienFiledCount03                 != ri.LienFiledCount03);
	self.LienFiledCount06                :=(integer)(le.LienFiledCount06                 != ri.LienFiledCount06);
	self.LienFiledCount12                :=(integer)(le.LienFiledCount12                 != ri.LienFiledCount12);
	self.LienFiledCount24                :=(integer)(le.LienFiledCount24                 != ri.LienFiledCount24);
	self.LienFiledCount36                :=(integer)(le.LienFiledCount36                 != ri.LienFiledCount36);
	self.LienFiledCount60                :=(integer)(le.LienFiledCount60                 != ri.LienFiledCount60);
	self.LienReleasedCount               :=(integer)(le.LienReleasedCount                != ri.LienReleasedCount);
	self.LienReleasedAge                 :=(integer)(le.LienReleasedAge                  != ri.LienReleasedAge);
	self.LienReleasedCount01             :=(integer)(le.LienReleasedCount01              != ri.LienReleasedCount01);
	self.LienReleasedCount03             :=(integer)(le.LienReleasedCount03              != ri.LienReleasedCount03);
	self.LienReleasedCount06             :=(integer)(le.LienReleasedCount06              != ri.LienReleasedCount06);
	self.LienReleasedCount12             :=(integer)(le.LienReleasedCount12              != ri.LienReleasedCount12);
	self.LienReleasedCount24             :=(integer)(le.LienReleasedCount24              != ri.LienReleasedCount24);
	self.LienReleasedCount36             :=(integer)(le.LienReleasedCount36              != ri.LienReleasedCount36);
	self.LienReleasedCount60             :=(integer)(le.LienReleasedCount60              != ri.LienReleasedCount60);
	self.LienFederalTaxFiledTotal        :=(integer)(le.LienFederalTaxFiledTotal         != ri.LienFederalTaxFiledTotal);
	self.LienTaxOtherFiledTotal          :=(integer)(le.LienTaxOtherFiledTotal           != ri.LienTaxOtherFiledTotal);
	self.LienForeclosureFiledTotal       :=(integer)(le.LienForeclosureFiledTotal        != ri.LienForeclosureFiledTotal);
	self.LienPreforeclosureFiledTotal    :=(integer)(le.LienPreforeclosureFiledTotal     != ri.LienPreforeclosureFiledTotal);
	self.LienLandlordTenantFiledTotal    :=(integer)(le.LienLandlordTenantFiledTotal     != ri.LienLandlordTenantFiledTotal);
	self.LienJudgmentFiledTotal          :=(integer)(le.LienJudgmentFiledTotal           != ri.LienJudgmentFiledTotal);
	self.LienSmallClaimsFiledTotal       :=(integer)(le.LienSmallClaimsFiledTotal        != ri.LienSmallClaimsFiledTotal);
	self.LienOtherFiledTotal             :=(integer)(le.LienOtherFiledTotal              != ri.LienOtherFiledTotal);
	self.LienFederalTaxReleasedTotal     :=(integer)(le.LienFederalTaxReleasedTotal      != ri.LienFederalTaxReleasedTotal);
	self.LienTaxOtherReleasedTotal       :=(integer)(le.LienTaxOtherReleasedTotal        != ri.LienTaxOtherReleasedTotal);
	self.LienForeclosureReleasedTotal    :=(integer)(le.LienForeclosureReleasedTotal     != ri.LienForeclosureReleasedTotal);
	self.LienPreforeclosureReleasedTotal :=(integer)(le.LienPreforeclosureReleasedTotal  != ri.LienPreforeclosureReleasedTotal);
	self.LienLandlordTenantReleasedTotal :=(integer)(le.LienLandlordTenantReleasedTotal  != ri.LienLandlordTenantReleasedTotal);
	self.LienJudgmentReleasedTotal       :=(integer)(le.LienJudgmentReleasedTotal        != ri.LienJudgmentReleasedTotal);
	self.LienSmallClaimsReleasedTotal    :=(integer)(le.LienSmallClaimsReleasedTotal     != ri.LienSmallClaimsReleasedTotal);
	self.LienOtherReleasedTotal          :=(integer)(le.LienOtherReleasedTotal           != ri.LienOtherReleasedTotal);
	self.LienFederalTaxFiledCount        :=(integer)(le.LienFederalTaxFiledCount         != ri.LienFederalTaxFiledCount);
	self.LienTaxOtherFiledCount          :=(integer)(le.LienTaxOtherFiledCount           != ri.LienTaxOtherFiledCount);
	self.LienForeclosureFiledCount       :=(integer)(le.LienForeclosureFiledCount        != ri.LienForeclosureFiledCount);
	self.LienPreforeclosureFiledCount    :=(integer)(le.LienPreforeclosureFiledCount     != ri.LienPreforeclosureFiledCount);
	self.LienLandlordTenantFiledCount    :=(integer)(le.LienLandlordTenantFiledCount     != ri.LienLandlordTenantFiledCount);
	self.LienJudgmentFiledCount          :=(integer)(le.LienJudgmentFiledCount           != ri.LienJudgmentFiledCount);
	self.LienSmallClaimsFiledCount       :=(integer)(le.LienSmallClaimsFiledCount        != ri.LienSmallClaimsFiledCount);
	self.LienOtherFiledCount             :=(integer)(le.LienOtherFiledCount              != ri.LienOtherFiledCount);
	self.LienFederalTaxReleasedCount     :=(integer)(le.LienFederalTaxReleasedCount      != ri.LienFederalTaxReleasedCount);
	self.LienTaxOtherReleasedCount       :=(integer)(le.LienTaxOtherReleasedCount        != ri.LienTaxOtherReleasedCount);
	self.LienForeclosureReleasedCount    :=(integer)(le.LienForeclosureReleasedCount     != ri.LienForeclosureReleasedCount);
	self.LienPreforeclosureReleasedCount :=(integer)(le.LienPreforeclosureReleasedCount  != ri.LienPreforeclosureReleasedCount);
	self.LienLandlordTenantReleasedCount :=(integer)(le.LienLandlordTenantReleasedCount  != ri.LienLandlordTenantReleasedCount);
	self.LienJudgmentReleasedCount       :=(integer)(le.LienJudgmentReleasedCount        != ri.LienJudgmentReleasedCount);
	self.LienSmallClaimsReleasedCount    :=(integer)(le.LienSmallClaimsReleasedCount     != ri.LienSmallClaimsReleasedCount);
	self.LienOtherReleasedCount          :=(integer)(le.LienOtherReleasedCount           != ri.LienOtherReleasedCount);
	self.BankruptcyCount                 :=(integer)(le.BankruptcyCount                  != ri.BankruptcyCount);
	self.BankruptcyAge                   :=(integer)(le.BankruptcyAge                    != ri.BankruptcyAge);
	self.BankruptcyType                  :=(integer)(le.BankruptcyType                   != ri.BankruptcyType);
	self.BankruptcyStatus                :=(integer)(le.BankruptcyStatus                 != ri.BankruptcyStatus);
	self.BankruptcyCount01               :=(integer)(le.BankruptcyCount01                != ri.BankruptcyCount01);
	self.BankruptcyCount03               :=(integer)(le.BankruptcyCount03                != ri.BankruptcyCount03);
	self.BankruptcyCount06               :=(integer)(le.BankruptcyCount06                != ri.BankruptcyCount06);
	self.BankruptcyCount12               :=(integer)(le.BankruptcyCount12                != ri.BankruptcyCount12);
	self.BankruptcyCount24               :=(integer)(le.BankruptcyCount24                != ri.BankruptcyCount24);
	self.BankruptcyCount36               :=(integer)(le.BankruptcyCount36                != ri.BankruptcyCount36);
	self.BankruptcyCount60               :=(integer)(le.BankruptcyCount60                != ri.BankruptcyCount60);
	self.EvictionCount                   :=(integer)(le.EvictionCount                    != ri.EvictionCount);
	self.EvictionAge                     :=(integer)(le.EvictionAge                      != ri.EvictionAge);
	self.EvictionCount01                 :=(integer)(le.EvictionCount01                  != ri.EvictionCount01);
	self.EvictionCount03                 :=(integer)(le.EvictionCount03                  != ri.EvictionCount03);
	self.EvictionCount06                 :=(integer)(le.EvictionCount06                  != ri.EvictionCount06);
	self.EvictionCount12                 :=(integer)(le.EvictionCount12                  != ri.EvictionCount12);
	self.EvictionCount24                 :=(integer)(le.EvictionCount24                  != ri.EvictionCount24);
	self.EvictionCount36                 :=(integer)(le.EvictionCount36                  != ri.EvictionCount36);
	self.EvictionCount60                 :=(integer)(le.EvictionCount60                  != ri.EvictionCount60);
	self.NonDerogCount                   :=(integer)(le.NonDerogCount                    != ri.NonDerogCount);
	self.NonDerogCount01                 :=(integer)(le.NonDerogCount01                  != ri.NonDerogCount01);
	self.NonDerogCount03                 :=(integer)(le.NonDerogCount03                  != ri.NonDerogCount03);
	self.NonDerogCount06                 :=(integer)(le.NonDerogCount06                  != ri.NonDerogCount06);
	self.NonDerogCount12                 :=(integer)(le.NonDerogCount12                  != ri.NonDerogCount12);
	self.NonDerogCount24                 :=(integer)(le.NonDerogCount24                  != ri.NonDerogCount24);
	self.NonDerogCount36                 :=(integer)(le.NonDerogCount36                  != ri.NonDerogCount36);
	self.NonDerogCount60                 :=(integer)(le.NonDerogCount60                  != ri.NonDerogCount60);
	self.ProfLicCount                    :=(integer)(le.ProfLicCount                     != ri.ProfLicCount);
	self.ProfLicAge                      :=(integer)(le.ProfLicAge                       != ri.ProfLicAge);
	self.proflic_type                    :=(integer)(le.proflic_type                     != ri.proflic_type);
	self.ProfLicTypeCategory             :=(integer)(le.ProfLicTypeCategory              != ri.ProfLicTypeCategory);
	self.expire_date_last_proflic        :=(integer)(le.expire_date_last_proflic         != ri.expire_date_last_proflic);
	self.ProfLicCount01                  :=(integer)(le.ProfLicCount01                   != ri.ProfLicCount01);
	self.ProfLicCount03                  :=(integer)(le.ProfLicCount03                   != ri.ProfLicCount03);
	self.ProfLicCount06                  :=(integer)(le.ProfLicCount06                   != ri.ProfLicCount06);
	self.ProfLicCount12                  :=(integer)(le.ProfLicCount12                   != ri.ProfLicCount12);
	self.ProfLicCount24                  :=(integer)(le.ProfLicCount24                   != ri.ProfLicCount24);
	self.ProfLicCount36                  :=(integer)(le.ProfLicCount36                   != ri.ProfLicCount36);
	self.ProfLicCount60                  :=(integer)(le.ProfLicCount60                   != ri.ProfLicCount60);
	self.ProflicExpireCount01            :=(integer)(le.ProflicExpireCount01             != ri.ProflicExpireCount01);
	self.ProflicExpireCount03            :=(integer)(le.ProflicExpireCount03             != ri.ProflicExpireCount03);
	self.ProflicExpireCount06            :=(integer)(le.ProflicExpireCount06             != ri.ProflicExpireCount06);
	self.ProflicExpireCount12            :=(integer)(le.ProflicExpireCount12             != ri.ProflicExpireCount12);
	self.ProflicExpireCount24            :=(integer)(le.ProflicExpireCount24             != ri.ProflicExpireCount24);
	self.ProflicExpireCount36            :=(integer)(le.ProflicExpireCount36             != ri.ProflicExpireCount36);
	self.ProflicExpireCount60            :=(integer)(le.ProflicExpireCount60             != ri.ProflicExpireCount60);
	self.InputPhoneStatus                :=(integer)(le.InputPhoneStatus                 != ri.InputPhoneStatus);
	self.InputPhonePager                 :=(integer)(le.InputPhonePager                  != ri.InputPhonePager);
	self.InputPhoneMobile                :=(integer)(le.InputPhoneMobile                 != ri.InputPhoneMobile);
	self.PhoneEDAAgeOldestRecord         :=(integer)(le.PhoneEDAAgeOldestRecord          != ri.PhoneEDAAgeOldestRecord);
	self.PhoneEDAAgeNewestRecord         :=(integer)(le.PhoneEDAAgeNewestRecord          != ri.PhoneEDAAgeNewestRecord);
	self.PhoneOtherAgeOldestRecord       :=(integer)(le.PhoneOtherAgeOldestRecord        != ri.PhoneOtherAgeOldestRecord);
	self.PhoneOtherAgeNewestRecord       :=(integer)(le.PhoneOtherAgeNewestRecord        != ri.PhoneOtherAgeNewestRecord);
	self.InvalidPhoneZip                 :=(integer)(le.InvalidPhoneZip                  != ri.InvalidPhoneZip);
	self.InputPhoneAddrDist              :=(integer)(le.InputPhoneAddrDist               != ri.InputPhoneAddrDist);
	self.InputAddrHighRisk               :=(integer)(le.InputAddrHighRisk                != ri.InputAddrHighRisk);
	self.InputPhoneHighRisk              :=(integer)(le.InputPhoneHighRisk               != ri.InputPhoneHighRisk);
	self.InputAddrPrison                 :=(integer)(le.InputAddrPrison                  != ri.InputAddrPrison);
	self.InputZipPOBox                   :=(integer)(le.InputZipPOBox                    != ri.InputZipPOBox);
	self.InputZipCorpMil                 :=(integer)(le.InputZipCorpMil                  != ri.InputZipCorpMil);
	self.correctedFlag                   :=(integer)(le.correctedFlag                    != ri.correctedFlag);
	self.securityFreeze                  :=(integer)(le.securityFreeze                   != ri.securityFreeze);
	self.securityAlert                   :=(integer)(le.securityAlert                    != ri.securityAlert);
	self.idTheftFlag                     :=(integer)(le.idTheftFlag                      != ri.idTheftFlag);
	self.PrescreenOptOut                 :=(integer)(le.PrescreenOptOut                  != ri.PrescreenOptOut);
	self.history_date                    :=(integer)(le.history_date                     != ri.history_date);
	self.errorcode                       :=(integer)(le.errorcode                        != ri.errorcode);
END;

res := JOIN (ds_original, ds_compare, LEFT.accountnumber=RIGHT.accountnumber, mk_matches(LEFT,RIGHT));
//output(res);

total := count(res);
AccountNumber                    := count(res(AccountNumber                    = 1));
AgeOldestRecord                  := count(res(AgeOldestRecord                  = 1));
AgeNewestRecord                  := count(res(AgeNewestRecord                  = 1));
RecentUpdate                     := count(res(RecentUpdate                     = 1));
SrcsConfirmIDAddrCount           := count(res(SrcsConfirmIDAddrCount           = 1));
InvalidSSN                       := count(res(InvalidSSN                       = 1));
InvalidAddr                      := count(res(InvalidAddr                      = 1));
InvalidDL                        := count(res(InvalidDL                        = 1));
InvalidPhone                     := count(res(InvalidPhone                     = 1));
VerificationFailure              := count(res(VerificationFailure              = 1));
SSNNotFound                      := count(res(SSNNotFound                      = 1));
VerifiedName                     := count(res(VerifiedName                     = 1));
VerifiedSSN                      := count(res(VerifiedSSN                      = 1));
VerifiedPhone                    := count(res(VerifiedPhone                    = 1));
VerifiedPhoneFullName            := count(res(VerifiedPhoneFullName            = 1));
VerifiedPhoneLastName            := count(res(VerifiedPhoneLastName            = 1));
VerifiedAddress                  := count(res(VerifiedAddress                  = 1));
VerifiedDOB                      := count(res(VerifiedDOB                      = 1));
InferredMinimumAge               := count(res(InferredMinimumAge               = 1));
BestReportedAge                  := count(res(BestReportedAge                  = 1));
SubjectSSNCount                  := count(res(SubjectSSNCount                  = 1));
SubjectAddrCount                 := count(res(SubjectAddrCount                 = 1));
SubjectPhoneCount                := count(res(SubjectPhoneCount                = 1));
SubjectSSNRecentCount            := count(res(SubjectSSNRecentCount            = 1));
SubjectAddrRecentCount           := count(res(SubjectAddrRecentCount           = 1));
SubjectPhoneRecentCount          := count(res(SubjectPhoneRecentCount          = 1));
SSNIdentitiesCount               := count(res(SSNIdentitiesCount               = 1));
SSNAddrCount                     := count(res(SSNAddrCount                     = 1));
SSNIdentitiesRecentCount         := count(res(SSNIdentitiesRecentCount         = 1));
SSNAddrRecentCount               := count(res(SSNAddrRecentCount               = 1));
InputAddrIdentitiesCount         := count(res(InputAddrIdentitiesCount         = 1));
InputAddrSSNCount                := count(res(InputAddrSSNCount                = 1));
InputAddrPhoneCount              := count(res(InputAddrPhoneCount              = 1));
InputAddrIdentitiesRecentCount   := count(res(InputAddrIdentitiesRecentCount   = 1));
InputAddrSSNRecentCount          := count(res(InputAddrSSNRecentCount          = 1));
InputAddrPhoneRecentCount        := count(res(InputAddrPhoneRecentCount        = 1));
PhoneIdentitiesCount             := count(res(PhoneIdentitiesCount             = 1));
PhoneIdentitiesRecentCount       := count(res(PhoneIdentitiesRecentCount       = 1));
SSNDeceased                      := count(res(SSNDeceased                      = 1));
SSNDateDeceased                  := count(res(SSNDateDeceased                  = 1));
SSNValid                         := count(res(SSNValid                         = 1));
SSNRecent                        := count(res(SSNRecent                        = 1));
SSNLowIssueDate                  := count(res(SSNLowIssueDate                  = 1));
SSNHighIssueDate                 := count(res(SSNHighIssueDate                 = 1));
SSNIssueState                    := count(res(SSNIssueState                    = 1));
SSNNonUS                         := count(res(SSNNonUS                         = 1));
SSNIssuedPriorDOB                := count(res(SSNIssuedPriorDOB                = 1));
SSN3Years                        := count(res(SSN3Years                        = 1));
SSNAfter5                        := count(res(SSNAfter5                        = 1));
InputAddrAgeOldestRecord         := count(res(InputAddrAgeOldestRecord         = 1));
InputAddrAgeNewestRecord         := count(res(InputAddrAgeNewestRecord         = 1));
InputAddrALenOfRes               := count(res(InputAddrALenOfRes               = 1));
InputAddrDwellType               := count(res(InputAddrDwellType               = 1));
InputAddrLandUseCode             := count(res(InputAddrLandUseCode             = 1));
InputAddrOwnedBySubject          := count(res(InputAddrOwnedBySubject          = 1));
InputAddrFamilyOwned             := count(res(InputAddrFamilyOwned             = 1));
InputAddrOccupantOwned           := count(res(InputAddrOccupantOwned           = 1));
InputAddrAgeLastSale             := count(res(InputAddrAgeLastSale             = 1));
InputAddrLastSalesPrice          := count(res(InputAddrLastSalesPrice          = 1));
InputAddrNotPrimaryRes           := count(res(InputAddrNotPrimaryRes           = 1));
InputAddrActivePhoneList         := count(res(InputAddrActivePhoneList         = 1));
InputAddrActivePhoneNumber       := count(res(InputAddrActivePhoneNumber       = 1));
InputAddrTaxValue                := count(res(InputAddrTaxValue                = 1));
InputAddrTaxYr                   := count(res(InputAddrTaxYr                   = 1));
InputAddrTaxMarketValue          := count(res(InputAddrTaxMarketValue          = 1));
InputAddrAVMTax                  := count(res(InputAddrAVMTax                  = 1));
InputAddrAVMSalesPrice           := count(res(InputAddrAVMSalesPrice           = 1));
InputAddrAVMHedonic              := count(res(InputAddrAVMHedonic              = 1));
InputAddrAVMValue                := count(res(InputAddrAVMValue                = 1));
InputAddrAVMConfidence           := count(res(InputAddrAVMConfidence           = 1));
InputAddrCountyIndex             := count(res(InputAddrCountyIndex             = 1));
InputAddrTractIndex              := count(res(InputAddrTractIndex              = 1));
InputAddrBlockIndex              := count(res(InputAddrBlockIndex              = 1));
CurrAddrAgeOldestRecord          := count(res(CurrAddrAgeOldestRecord          = 1));
CurrAddrAgeNewestRecord          := count(res(CurrAddrAgeNewestRecord          = 1));
CurrAddrLenOfRes                 := count(res(CurrAddrLenOfRes                 = 1));
CurrAddrDwellType                := count(res(CurrAddrDwellType                = 1));
CurrAddrALandUseCode             := count(res(CurrAddrALandUseCode             = 1));
CurrAddrApplicantOwned           := count(res(CurrAddrApplicantOwned           = 1));
CurrAddrFamilyOwned              := count(res(CurrAddrFamilyOwned              = 1));
CurrAddrOccupantOwned            := count(res(CurrAddrOccupantOwned            = 1));
CurrAddrAgeLastSale              := count(res(CurrAddrAgeLastSale              = 1));
CurrAddrLastSalesPrice           := count(res(CurrAddrLastSalesPrice           = 1));
CurrAddrNotPrimaryRes            := count(res(CurrAddrNotPrimaryRes            = 1));
CurrAddrActivePhoneList          := count(res(CurrAddrActivePhoneList          = 1));
CurrAddrActivePhoneNumber        := count(res(CurrAddrActivePhoneNumber        = 1));
CurrAddrTaxValue                 := count(res(CurrAddrTaxValue                 = 1));
CurrAddrTaxYr                    := count(res(CurrAddrTaxYr                    = 1));
CurrAddrTaxMarketValue           := count(res(CurrAddrTaxMarketValue           = 1));
CurrAddrAVMTax                   := count(res(CurrAddrAVMTax                   = 1));
CurrAddrAVMSalesPrice            := count(res(CurrAddrAVMSalesPrice            = 1));
CurrAddrAVMHedonic               := count(res(CurrAddrAVMHedonic               = 1));
CurrAddrAVMValue                 := count(res(CurrAddrAVMValue                 = 1));
CurrAddrAVMConfidence            := count(res(CurrAddrAVMConfidence            = 1));
CurrAddrCountyIndex              := count(res(CurrAddrCountyIndex              = 1));
CurrAddrTractIndex               := count(res(CurrAddrTractIndex               = 1));
CurrAddrBlockIndex               := count(res(CurrAddrBlockIndex               = 1));
PrevAddrAgeOldestRecord          := count(res(PrevAddrAgeOldestRecord          = 1));
PrevAddrAgeNewestRecord          := count(res(PrevAddrAgeNewestRecord          = 1));
PrevAddrLenOfRes                 := count(res(PrevAddrLenOfRes                 = 1));
PrevAddrDwellType                := count(res(PrevAddrDwellType                = 1));
PrevAddrLandUseCode              := count(res(PrevAddrLandUseCode              = 1));
PrevAddrApplicantOwned           := count(res(PrevAddrApplicantOwned           = 1));
PrevAddrFamilyOwned              := count(res(PrevAddrFamilyOwned              = 1));
PrevAddrOccupantOwned            := count(res(PrevAddrOccupantOwned            = 1));
PrevAddrAgeLastSale              := count(res(PrevAddrAgeLastSale              = 1));
PrevAddrLastSalesPrice           := count(res(PrevAddrLastSalesPrice           = 1));
PrevAddrPhoneListed              := count(res(PrevAddrPhoneListed              = 1));
PrevAddrPhoneNumber              := count(res(PrevAddrPhoneNumber              = 1));
PrevAddrAssessedValue            := count(res(PrevAddrAssessedValue            = 1));
PrevAddrTaxYr                    := count(res(PrevAddrTaxYr                    = 1));
PrevAddrTaxMarketValue           := count(res(PrevAddrTaxMarketValue           = 1));
PrevAddrAVMTax                   := count(res(PrevAddrAVMTax                   = 1));
PrevAddrAVMSalesPrice            := count(res(PrevAddrAVMSalesPrice            = 1));
PrevAddrAVMHedonic               := count(res(PrevAddrAVMHedonic               = 1));
PrevAddrAVMValue                 := count(res(PrevAddrAVMValue                 = 1));
PrevAddrAVMConfidence            := count(res(PrevAddrAVMConfidence            = 1));
PrevAddrCountyIndex              := count(res(PrevAddrCountyIndex              = 1));
PrevAddrTractIndex               := count(res(PrevAddrTractIndex               = 1));
PrevAddrBlockIndex               := count(res(PrevAddrBlockIndex               = 1));
InputCurrAddrMatch               := count(res(InputCurrAddrMatch               = 1));
InputCurrAddrDistance            := count(res(InputCurrAddrDistance            = 1));
InputCurrAddrStateDiff           := count(res(InputCurrAddrStateDiff           = 1));
InputCurrAddrTaxDiff             := count(res(InputCurrAddrTaxDiff             = 1));
InputCurrEconTrajectory          := count(res(InputCurrEconTrajectory          = 1));
InputPrevAddrMatch               := count(res(InputPrevAddrMatch               = 1));
CurrPrevAddrDistance             := count(res(CurrPrevAddrDistance             = 1));
CurrPrevAddrStateDiff            := count(res(CurrPrevAddrStateDiff            = 1));
CurrPrevAddrTaxDiff              := count(res(CurrPrevAddrTaxDiff              = 1));
PrevCurrEconTrajectory           := count(res(PrevCurrEconTrajectory           = 1));
EducationAttendedCollege         := count(res(EducationAttendedCollege         = 1));
EducationProgram2Yr              := count(res(EducationProgram2Yr              = 1));
EducationProgram4Yr              := count(res(EducationProgram4Yr              = 1));
EducationProgramGraduate         := count(res(EducationProgramGraduate         = 1));
EducationInstitutionPrivate      := count(res(EducationInstitutionPrivate      = 1));
EducationInstitutionRating       := count(res(EducationInstitutionRating       = 1));
AddrStability                    := count(res(AddrStability                    = 1));
StatusMostRecent                 := count(res(StatusMostRecent                 = 1));
StatusPrevious                   := count(res(StatusPrevious                   = 1));
StatusNextPrevious               := count(res(StatusNextPrevious               = 1));
AddrChangeCount01                := count(res(AddrChangeCount01                = 1));
AddrChangeCount03                := count(res(AddrChangeCount03                = 1));
AddrChangeCount06                := count(res(AddrChangeCount06                = 1));
AddrChangeCount12                := count(res(AddrChangeCount12                = 1));
AddrChangeCount24                := count(res(AddrChangeCount24                = 1));
AddrChangeCount36                := count(res(AddrChangeCount36                = 1));
AddrChangeCount60                := count(res(AddrChangeCount60                = 1));
PredictedAnnualIncome            := count(res(PredictedAnnualIncome            = 1));
PropOwnedCount                   := count(res(PropOwnedCount                   = 1));
PropOwnedTaxTotal                := count(res(PropOwnedTaxTotal                = 1));
PropOwnedHistoricalCount         := count(res(PropOwnedHistoricalCount         = 1));
PropAgeOldestPurchase            := count(res(PropAgeOldestPurchase            = 1));
PropAgeNewestPurchase            := count(res(PropAgeNewestPurchase            = 1));
PropAgeNewestSale                := count(res(PropAgeNewestSale                = 1));
PropNewestSalePrice              := count(res(PropNewestSalePrice              = 1));
PropNewestSalePurchaseIndex      := count(res(PropNewestSalePurchaseIndex      = 1));
PropPurchasedCount01             := count(res(PropPurchasedCount01             = 1));
PropPurchasedCount03             := count(res(PropPurchasedCount03             = 1));
PropPurchasedCount06             := count(res(PropPurchasedCount06             = 1));
PropPurchasedCount12             := count(res(PropPurchasedCount12             = 1));
PropPurchasedCount24             := count(res(PropPurchasedCount24             = 1));
PropPurchasedCount36             := count(res(PropPurchasedCount36             = 1));
PropPurchasedCount60             := count(res(PropPurchasedCount60             = 1));
PropSoldCount01                  := count(res(PropSoldCount01                  = 1));
PropSoldCount03                  := count(res(PropSoldCount03                  = 1));
PropSoldCount06                  := count(res(PropSoldCount06                  = 1));
PropSoldCount12                  := count(res(PropSoldCount12                  = 1));
PropSoldCount24                  := count(res(PropSoldCount24                  = 1));
PropSoldCount36                  := count(res(PropSoldCount36                  = 1));
PropSoldCount60                  := count(res(PropSoldCount60                  = 1));
WatercraftCount                  := count(res(WatercraftCount                  = 1));
WatercraftCount01                := count(res(WatercraftCount01                = 1));
WatercraftCount03                := count(res(WatercraftCount03                = 1));
WatercraftCount06                := count(res(WatercraftCount06                = 1));
WatercraftCount12                := count(res(WatercraftCount12                = 1));
WatercraftCount24                := count(res(WatercraftCount24                = 1));
WatercraftCount36                := count(res(WatercraftCount36                = 1));
WatercraftCount60                := count(res(WatercraftCount60                = 1));
AircraftCount                    := count(res(AircraftCount                    = 1));
AircraftCount01                  := count(res(AircraftCount01                  = 1));
AircraftCount03                  := count(res(AircraftCount03                  = 1));
AircraftCount06                  := count(res(AircraftCount06                  = 1));
AircraftCount12                  := count(res(AircraftCount12                  = 1));
AircraftCount24                  := count(res(AircraftCount24                  = 1));
AircraftCount36                  := count(res(AircraftCount36                  = 1));
AircraftCount60                  := count(res(AircraftCount60                  = 1));
WealthIndex                      := count(res(WealthIndex                      = 1));
SubPrimeSolicitedCount           := count(res(SubPrimeSolicitedCount           = 1));
SubPrimeSolicitedCount01         := count(res(SubPrimeSolicitedCount01         = 1));
SubprimeSolicitedCount03         := count(res(SubprimeSolicitedCount03         = 1));
SubprimeSolicitedCount06         := count(res(SubprimeSolicitedCount06         = 1));
SubPrimeSolicitedCount12         := count(res(SubPrimeSolicitedCount12         = 1));
SubPrimeSolicitedCount24         := count(res(SubPrimeSolicitedCount24         = 1));
SubPrimeSolicitedCount36         := count(res(SubPrimeSolicitedCount36         = 1));
SubPrimeSolicitedCount60         := count(res(SubPrimeSolicitedCount60         = 1));
DerogCount                       := count(res(DerogCount                       = 1));
DerogAge                         := count(res(DerogAge                         = 1));
FelonyCount                      := count(res(FelonyCount                      = 1));
FelonyAge                        := count(res(FelonyAge                        = 1));
FelonyCount01                    := count(res(FelonyCount01                    = 1));
FelonyCount03                    := count(res(FelonyCount03                    = 1));
FelonyCount06                    := count(res(FelonyCount06                    = 1));
FelonyCount12                    := count(res(FelonyCount12                    = 1));
FelonyCount24                    := count(res(FelonyCount24                    = 1));
FelonyCount36                    := count(res(FelonyCount36                    = 1));
FelonyCount60                    := count(res(FelonyCount60                    = 1));
LienCount                        := count(res(LienCount                        = 1));
LienFiledCount                   := count(res(LienFiledCount                   = 1));
LienFiledAge                     := count(res(LienFiledAge                     = 1));
LienFiledCount01                 := count(res(LienFiledCount01                 = 1));
LienFiledCount03                 := count(res(LienFiledCount03                 = 1));
LienFiledCount06                 := count(res(LienFiledCount06                 = 1));
LienFiledCount12                 := count(res(LienFiledCount12                 = 1));
LienFiledCount24                 := count(res(LienFiledCount24                 = 1));
LienFiledCount36                 := count(res(LienFiledCount36                 = 1));
LienFiledCount60                 := count(res(LienFiledCount60                 = 1));
LienReleasedCount                := count(res(LienReleasedCount                = 1));
LienReleasedAge                  := count(res(LienReleasedAge                  = 1));
LienReleasedCount01              := count(res(LienReleasedCount01              = 1));
LienReleasedCount03              := count(res(LienReleasedCount03              = 1));
LienReleasedCount06              := count(res(LienReleasedCount06              = 1));
LienReleasedCount12              := count(res(LienReleasedCount12              = 1));
LienReleasedCount24              := count(res(LienReleasedCount24              = 1));
LienReleasedCount36              := count(res(LienReleasedCount36              = 1));
LienReleasedCount60              := count(res(LienReleasedCount60              = 1));
LienFederalTaxFiledTotal         := count(res(LienFederalTaxFiledTotal         = 1));
LienTaxOtherFiledTotal           := count(res(LienTaxOtherFiledTotal           = 1));
LienForeclosureFiledTotal        := count(res(LienForeclosureFiledTotal        = 1));
LienPreforeclosureFiledTotal     := count(res(LienPreforeclosureFiledTotal     = 1));
LienLandlordTenantFiledTotal     := count(res(LienLandlordTenantFiledTotal     = 1));
LienJudgmentFiledTotal           := count(res(LienJudgmentFiledTotal           = 1));
LienSmallClaimsFiledTotal        := count(res(LienSmallClaimsFiledTotal        = 1));
LienOtherFiledTotal              := count(res(LienOtherFiledTotal              = 1));
LienFederalTaxReleasedTotal      := count(res(LienFederalTaxReleasedTotal      = 1));
LienTaxOtherReleasedTotal        := count(res(LienTaxOtherReleasedTotal        = 1));
LienForeclosureReleasedTotal     := count(res(LienForeclosureReleasedTotal     = 1));
LienPreforeclosureReleasedTotal  := count(res(LienPreforeclosureReleasedTotal  = 1));
LienLandlordTenantReleasedTotal  := count(res(LienLandlordTenantReleasedTotal  = 1));
LienJudgmentReleasedTotal        := count(res(LienJudgmentReleasedTotal        = 1));
LienSmallClaimsReleasedTotal     := count(res(LienSmallClaimsReleasedTotal     = 1));
LienOtherReleasedTotal           := count(res(LienOtherReleasedTotal           = 1));
LienFederalTaxFiledCount         := count(res(LienFederalTaxFiledCount         = 1));
LienTaxOtherFiledCount           := count(res(LienTaxOtherFiledCount           = 1));
LienForeclosureFiledCount        := count(res(LienForeclosureFiledCount        = 1));
LienPreforeclosureFiledCount     := count(res(LienPreforeclosureFiledCount     = 1));
LienLandlordTenantFiledCount     := count(res(LienLandlordTenantFiledCount     = 1));
LienJudgmentFiledCount           := count(res(LienJudgmentFiledCount           = 1));
LienSmallClaimsFiledCount        := count(res(LienSmallClaimsFiledCount        = 1));
LienOtherFiledCount              := count(res(LienOtherFiledCount              = 1));
LienFederalTaxReleasedCount      := count(res(LienFederalTaxReleasedCount      = 1));
LienTaxOtherReleasedCount        := count(res(LienTaxOtherReleasedCount        = 1));
LienForeclosureReleasedCount     := count(res(LienForeclosureReleasedCount     = 1));
LienPreforeclosureReleasedCount  := count(res(LienPreforeclosureReleasedCount  = 1));
LienLandlordTenantReleasedCount  := count(res(LienLandlordTenantReleasedCount  = 1));
LienJudgmentReleasedCount        := count(res(LienJudgmentReleasedCount        = 1));
LienSmallClaimsReleasedCount     := count(res(LienSmallClaimsReleasedCount     = 1));
LienOtherReleasedCount           := count(res(LienOtherReleasedCount           = 1));
BankruptcyCount                  := count(res(BankruptcyCount                  = 1));
BankruptcyAge                    := count(res(BankruptcyAge                    = 1));
BankruptcyType                   := count(res(BankruptcyType                   = 1));
BankruptcyStatus                 := count(res(BankruptcyStatus                 = 1));
BankruptcyCount01                := count(res(BankruptcyCount01                = 1));
BankruptcyCount03                := count(res(BankruptcyCount03                = 1));
BankruptcyCount06                := count(res(BankruptcyCount06                = 1));
BankruptcyCount12                := count(res(BankruptcyCount12                = 1));
BankruptcyCount24                := count(res(BankruptcyCount24                = 1));
BankruptcyCount36                := count(res(BankruptcyCount36                = 1));
BankruptcyCount60                := count(res(BankruptcyCount60                = 1));
EvictionCount                    := count(res(EvictionCount                    = 1));
EvictionAge                      := count(res(EvictionAge                      = 1));
EvictionCount01                  := count(res(EvictionCount01                  = 1));
EvictionCount03                  := count(res(EvictionCount03                  = 1));
EvictionCount06                  := count(res(EvictionCount06                  = 1));
EvictionCount12                  := count(res(EvictionCount12                  = 1));
EvictionCount24                  := count(res(EvictionCount24                  = 1));
EvictionCount36                  := count(res(EvictionCount36                  = 1));
EvictionCount60                  := count(res(EvictionCount60                  = 1));
NonDerogCount                    := count(res(NonDerogCount                    = 1));
NonDerogCount01                  := count(res(NonDerogCount01                  = 1));
NonDerogCount03                  := count(res(NonDerogCount03                  = 1));
NonDerogCount06                  := count(res(NonDerogCount06                  = 1));
NonDerogCount12                  := count(res(NonDerogCount12                  = 1));
NonDerogCount24                  := count(res(NonDerogCount24                  = 1));
NonDerogCount36                  := count(res(NonDerogCount36                  = 1));
NonDerogCount60                  := count(res(NonDerogCount60                  = 1));
ProfLicCount                     := count(res(ProfLicCount                     = 1));
ProfLicAge                       := count(res(ProfLicAge                       = 1));
proflic_type                     := count(res(proflic_type                     = 1));
ProfLicTypeCategory              := count(res(ProfLicTypeCategory              = 1));
expire_date_last_proflic         := count(res(expire_date_last_proflic         = 1));
ProfLicCount01                   := count(res(ProfLicCount01                   = 1));
ProfLicCount03                   := count(res(ProfLicCount03                   = 1));
ProfLicCount06                   := count(res(ProfLicCount06                   = 1));
ProfLicCount12                   := count(res(ProfLicCount12                   = 1));
ProfLicCount24                   := count(res(ProfLicCount24                   = 1));
ProfLicCount36                   := count(res(ProfLicCount36                   = 1));
ProfLicCount60                   := count(res(ProfLicCount60                   = 1));
ProflicExpireCount01             := count(res(ProflicExpireCount01             = 1));
ProflicExpireCount03             := count(res(ProflicExpireCount03             = 1));
ProflicExpireCount06             := count(res(ProflicExpireCount06             = 1));
ProflicExpireCount12             := count(res(ProflicExpireCount12             = 1));
ProflicExpireCount24             := count(res(ProflicExpireCount24             = 1));
ProflicExpireCount36             := count(res(ProflicExpireCount36             = 1));
ProflicExpireCount60             := count(res(ProflicExpireCount60             = 1));
InputPhoneStatus                 := count(res(InputPhoneStatus                 = 1));
InputPhonePager                  := count(res(InputPhonePager                  = 1));
InputPhoneMobile                 := count(res(InputPhoneMobile                 = 1));
PhoneEDAAgeOldestRecord          := count(res(PhoneEDAAgeOldestRecord          = 1));
PhoneEDAAgeNewestRecord          := count(res(PhoneEDAAgeNewestRecord          = 1));
PhoneOtherAgeOldestRecord        := count(res(PhoneOtherAgeOldestRecord        = 1));
PhoneOtherAgeNewestRecord        := count(res(PhoneOtherAgeNewestRecord        = 1));
InvalidPhoneZip                  := count(res(InvalidPhoneZip                  = 1));
InputPhoneAddrDist               := count(res(InputPhoneAddrDist               = 1));
InputAddrHighRisk                := count(res(InputAddrHighRisk                = 1));
InputPhoneHighRisk               := count(res(InputPhoneHighRisk               = 1));
InputAddrPrison                  := count(res(InputAddrPrison                  = 1));
InputZipPOBox                    := count(res(InputZipPOBox                    = 1));
InputZipCorpMil                  := count(res(InputZipCorpMil                  = 1));
correctedFlag                    := count(res(correctedFlag                    = 1));
securityFreeze                   := count(res(securityFreeze                   = 1));
securityAlert                    := count(res(securityAlert                    = 1));
idTheftFlag                      := count(res(idTheftFlag                      = 1));
PrescreenOptOut                  := count(res(PrescreenOptOut                  = 1));
history_date                     := count(res(history_date                     = 1));
errorcode                        := count(res(errorcode                        = 1));


summary_format := record
	total;
	AccountNumber;
	AgeOldestRecord;
	AgeNewestRecord;
	RecentUpdate;
	SrcsConfirmIDAddrCount;
	InvalidSSN;
	InvalidAddr;
	InvalidDL;
	InvalidPhone;
	VerificationFailure;
	SSNNotFound;
	VerifiedName;
	VerifiedSSN;
	VerifiedPhone;
	VerifiedPhoneFullName;
	VerifiedPhoneLastName;
	VerifiedAddress;
	VerifiedDOB;
	InferredMinimumAge;
	BestReportedAge;
	SubjectSSNCount;
	SubjectAddrCount;
	SubjectPhoneCount;
	SubjectSSNRecentCount;
	SubjectAddrRecentCount;
	SubjectPhoneRecentCount;
	SSNIdentitiesCount;
	SSNAddrCount;
	SSNIdentitiesRecentCount;
	SSNAddrRecentCount;
	InputAddrIdentitiesCount;
	InputAddrSSNCount;
	InputAddrPhoneCount;
	InputAddrIdentitiesRecentCount;
	InputAddrSSNRecentCount;
	InputAddrPhoneRecentCount;
	PhoneIdentitiesCount;
	PhoneIdentitiesRecentCount;
	SSNDeceased;
	SSNDateDeceased;
	SSNValid;
	SSNRecent;
	SSNLowIssueDate;
	SSNHighIssueDate;
	SSNIssueState;
	SSNNonUS;
	SSNIssuedPriorDOB;
	SSN3Years;
	SSNAfter5;
	InputAddrAgeOldestRecord;
	InputAddrAgeNewestRecord;
	InputAddrALenOfRes;
	InputAddrDwellType;
	InputAddrLandUseCode;
	InputAddrOwnedBySubject;
	InputAddrFamilyOwned;
	InputAddrOccupantOwned;
	InputAddrAgeLastSale;
	InputAddrLastSalesPrice;
	InputAddrNotPrimaryRes;
	InputAddrActivePhoneList;
	InputAddrActivePhoneNumber;
	InputAddrTaxValue;
	InputAddrTaxYr;
	InputAddrTaxMarketValue;
	InputAddrAVMTax;
	InputAddrAVMSalesPrice;
	InputAddrAVMHedonic;
	InputAddrAVMValue;
	InputAddrAVMConfidence;
	InputAddrCountyIndex;
	InputAddrTractIndex;
	InputAddrBlockIndex;
	CurrAddrAgeOldestRecord;
	CurrAddrAgeNewestRecord;
	CurrAddrLenOfRes;
	CurrAddrDwellType;
	CurrAddrALandUseCode;
	CurrAddrApplicantOwned;
	CurrAddrFamilyOwned;
	CurrAddrOccupantOwned;
	CurrAddrAgeLastSale;
	CurrAddrLastSalesPrice;
	CurrAddrNotPrimaryRes;
	CurrAddrActivePhoneList;
	CurrAddrActivePhoneNumber;
	CurrAddrTaxValue;
	CurrAddrTaxYr;
	CurrAddrTaxMarketValue;
	CurrAddrAVMTax;
	CurrAddrAVMSalesPrice;
	CurrAddrAVMHedonic;
	CurrAddrAVMValue;
	CurrAddrAVMConfidence;
	CurrAddrCountyIndex;
	CurrAddrTractIndex;
	CurrAddrBlockIndex;
	PrevAddrAgeOldestRecord;
	PrevAddrAgeNewestRecord;
	PrevAddrLenOfRes;
	PrevAddrDwellType;
	PrevAddrLandUseCode;
	PrevAddrApplicantOwned;
	PrevAddrFamilyOwned;
	PrevAddrOccupantOwned;
	PrevAddrAgeLastSale;
	PrevAddrLastSalesPrice;
	PrevAddrPhoneListed;
	PrevAddrPhoneNumber;
	PrevAddrAssessedValue;
	PrevAddrTaxYr;
	PrevAddrTaxMarketValue;
	PrevAddrAVMTax;
	PrevAddrAVMSalesPrice;
	PrevAddrAVMHedonic;
	PrevAddrAVMValue;
	PrevAddrAVMConfidence;
	PrevAddrCountyIndex;
	PrevAddrTractIndex;
	PrevAddrBlockIndex;
	InputCurrAddrMatch;
	InputCurrAddrDistance;
	InputCurrAddrStateDiff;
	InputCurrAddrTaxDiff;
	InputCurrEconTrajectory;
	InputPrevAddrMatch;
	CurrPrevAddrDistance;
	CurrPrevAddrStateDiff;
	CurrPrevAddrTaxDiff;
	PrevCurrEconTrajectory;
	EducationAttendedCollege;
	EducationProgram2Yr;
	EducationProgram4Yr;
	EducationProgramGraduate;
	EducationInstitutionPrivate;
	EducationInstitutionRating;
	AddrStability;
	StatusMostRecent;
	StatusPrevious;
	StatusNextPrevious;
	AddrChangeCount01;
	AddrChangeCount03;
	AddrChangeCount06;
	AddrChangeCount12;
	AddrChangeCount24;
	AddrChangeCount36;
	AddrChangeCount60;
	PredictedAnnualIncome;
	PropOwnedCount;
	PropOwnedTaxTotal;
	PropOwnedHistoricalCount;
	PropAgeOldestPurchase;
	PropAgeNewestPurchase;
	PropAgeNewestSale;
	PropNewestSalePrice;
	PropNewestSalePurchaseIndex;
	PropPurchasedCount01;
	PropPurchasedCount03;
	PropPurchasedCount06;
	PropPurchasedCount12;
	PropPurchasedCount24;
	PropPurchasedCount36;
	PropPurchasedCount60;
	PropSoldCount01;
	PropSoldCount03;
	PropSoldCount06;
	PropSoldCount12;
	PropSoldCount24;
	PropSoldCount36;
	PropSoldCount60;
	WatercraftCount;
	WatercraftCount01;
	WatercraftCount03;
	WatercraftCount06;
	WatercraftCount12;
	WatercraftCount24;
	WatercraftCount36;
	WatercraftCount60;
	AircraftCount;
	AircraftCount01;
	AircraftCount03;
	AircraftCount06;
	AircraftCount12;
	AircraftCount24;
	AircraftCount36;
	AircraftCount60;
	WealthIndex;
	SubPrimeSolicitedCount;
	SubPrimeSolicitedCount01;
	SubprimeSolicitedCount03;
	SubprimeSolicitedCount06;
	SubPrimeSolicitedCount12;
	SubPrimeSolicitedCount24;
	SubPrimeSolicitedCount36;
	SubPrimeSolicitedCount60;
	DerogCount;
	DerogAge;
	FelonyCount;
	FelonyAge;
	FelonyCount01;
	FelonyCount03;
	FelonyCount06;
	FelonyCount12;
	FelonyCount24;
	FelonyCount36;
	FelonyCount60;
	LienCount;
	LienFiledCount;
	LienFiledAge;
	LienFiledCount01;
	LienFiledCount03;
	LienFiledCount06;
	LienFiledCount12;
	LienFiledCount24;
	LienFiledCount36;
	LienFiledCount60;
	LienReleasedCount;
	LienReleasedAge;
	LienReleasedCount01;
	LienReleasedCount03;
	LienReleasedCount06;
	LienReleasedCount12;
	LienReleasedCount24;
	LienReleasedCount36;
	LienReleasedCount60;
	LienFederalTaxFiledTotal;
	LienTaxOtherFiledTotal;
	LienForeclosureFiledTotal;
	LienPreforeclosureFiledTotal;
	LienLandlordTenantFiledTotal;
	LienJudgmentFiledTotal;
	LienSmallClaimsFiledTotal;
	LienOtherFiledTotal;
	LienFederalTaxReleasedTotal;
	LienTaxOtherReleasedTotal;
	LienForeclosureReleasedTotal;
	LienPreforeclosureReleasedTotal;
	LienLandlordTenantReleasedTotal;
	LienJudgmentReleasedTotal;
	LienSmallClaimsReleasedTotal;
	LienOtherReleasedTotal;
	LienFederalTaxFiledCount;
	LienTaxOtherFiledCount;
	LienForeclosureFiledCount;
	LienPreforeclosureFiledCount;
	LienLandlordTenantFiledCount;
	LienJudgmentFiledCount;
	LienSmallClaimsFiledCount;
	LienOtherFiledCount;
	LienFederalTaxReleasedCount;
	LienTaxOtherReleasedCount;
	LienForeclosureReleasedCount;
	LienPreforeclosureReleasedCount;
	LienLandlordTenantReleasedCount;
	LienJudgmentReleasedCount;
	LienSmallClaimsReleasedCount;
	LienOtherReleasedCount;
	BankruptcyCount;
	BankruptcyAge;
	BankruptcyType;
	BankruptcyStatus;
	BankruptcyCount01;
	BankruptcyCount03;
	BankruptcyCount06;
	BankruptcyCount12;
	BankruptcyCount24;
	BankruptcyCount36;
	BankruptcyCount60;
	EvictionCount;
	EvictionAge;
	EvictionCount01;
	EvictionCount03;
	EvictionCount06;
	EvictionCount12;
	EvictionCount24;
	EvictionCount36;
	EvictionCount60;
	NonDerogCount;
	NonDerogCount01;
	NonDerogCount03;
	NonDerogCount06;
	NonDerogCount12;
	NonDerogCount24;
	NonDerogCount36;
	NonDerogCount60;
	ProfLicCount;
	ProfLicAge;
	proflic_type;
	ProfLicTypeCategory;
	expire_date_last_proflic;
	ProfLicCount01;
	ProfLicCount03;
	ProfLicCount06;
	ProfLicCount12;
	ProfLicCount24;
	ProfLicCount36;
	ProfLicCount60;
	ProflicExpireCount01;
	ProflicExpireCount03;
	ProflicExpireCount06;
	ProflicExpireCount12;
	ProflicExpireCount24;
	ProflicExpireCount36;
	ProflicExpireCount60;
	InputPhoneStatus;
	InputPhonePager;
	InputPhoneMobile;
	PhoneEDAAgeOldestRecord;
	PhoneEDAAgeNewestRecord;
	PhoneOtherAgeOldestRecord;
	PhoneOtherAgeNewestRecord;
	InvalidPhoneZip;
	InputPhoneAddrDist;
	InputAddrHighRisk;
	InputPhoneHighRisk;
	InputAddrPrison;
	InputZipPOBox;
	InputZipCorpMil;
	correctedFlag;
	securityFreeze;
	securityAlert;
	idTheftFlag;
	PrescreenOptOut;
	history_date;
	errorcode;
END;


summary_res := table(res, summary_format, total);	
output(summary_res);

endmacro;