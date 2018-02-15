EXPORT RV_Attributes_V4_BATCH_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;

archive_date := (integer) ut.getdate ;
// today         := ut.GetDate[3..];

string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//==================  input file layout  ========================
layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;



  END;
 



f1 := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, layout_input, csv(quote('"')) ),
                            CHOOSEN(DATASET(ut.foreign_prod + infile_name, layout_input, csv(quote('"'))), no_of_records));
														
ds_input := distribute(f1, hash64(account));

// infile_name   := '~nmontpetit::in::rva_prescreen_tracking_pii';

//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
// neutral_roxie_IP := riskwise.shortcuts.staging_neutral_roxieip ;

 //prod  RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch


// FCRA service settings
// fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieip ;
// prod RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie





layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion4;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := le.account;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := le.historydateyyyymm ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := true;		
	self.IncludeVersion4 := true;
	SELF.DataRestrictionMask := DataRestrictionMask;
END;
	
soap_in := DISTRIBUTE(PROJECT(ds_input, make_rv_in(LEFT, counter)), RANDOM());
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
	models.Layout_RiskView_Batch_Out;
	string200 errorcode;
END;
       
roxie_out_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

resu := soapcall(soap_in, fcraroxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout), 
										RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

// output(choosen(resu, eyeball), named('soap_results'));
errors := resu(errorcode<>'');
// output(choosen(errors, eyeball), named('errors'));
op := output(count(errors), named('rv_batch40_error_count'));

just_rv_attributes_v4 := 

RECORD
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



rv_attributes_v4 := project(resu, 
	transform(just_rv_attributes_v4, 
	self.accountnumber := left.acctno;
	self.history_date := (string6)archive_date;
	

	self := left;
		));			

op_final := output(rv_attributes_v4 ,,outfile_name,CSV(heading(single), quote('"')), overwrite);

fin_res := sequential(op, op_final);

return fin_res;

endmacro;