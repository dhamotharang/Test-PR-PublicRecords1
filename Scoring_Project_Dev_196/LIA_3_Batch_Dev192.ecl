#workunit('name','Lead Integrity Attributes_batch');
#option ('hthorMemoryLimit', 1000)

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing ;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
recordsToRun := 1000;
record_limit := 1000;
eyeball := 50;
threads := 1;

roxieIP := RiskWise.shortcuts.dev192;

infile_name_25000     := '~nmontpetit::in::ge_cap_100302_pii'; 

inputFile := ut.foreign_prod + infile_name_25000;

outfile_name := '~nkoubsky::out::nonFcra_LIAttributes_batch_v30_Dev192_'  + thorlib.wuid()  ;


// Versions Available: 1, 3 and 4
version := 3;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;

// Boca Shell Version
bocaShellVersion := 4;

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 999999;

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
prii_layout := RECORD
	STRING AccountNumber;
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
	STRING DLNumber;
	STRING DLState;
	STRING BALANCE; 
	STRING CHARGEOFFD;  
	STRING FormerName;
	STRING EMAIL;  
	STRING COMPANY;
	INTEGER historydateyyyymm;
	unsigned did := 0;
END;

f_all := DATASET(inputFile, prii_layout, CSV(QUOTE('"')));
f := IF(recordsToRun = 0, f_all, CHOOSEN(f_all, recordsToRun));
// OUTPUT(CHOOSEN(f, eyeball), NAMED('customer_file'));

// Run the ADL based bocashell with that history date to append the SSN if it's missing
layout_soap_boca := RECORD
	STRING old_account_number;
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	STRING DataRestrictionMask;	
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	
	unsigned did;
	string wuid;
	string jobowner;
END;

layout_soap_boca transform_input_boca(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.adl_based_shell := true;
	SELF.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	SELF.Version := bocaShellVersion;
	SELF := le;
	
	self.wuid := thorlib.wuid();
	self.jobowner := thorlib.jobowner();

	SELF := [];
END;

p_f := PROJECT(f, transform_input_boca(LEFT, COUNTER));
// OUTPUT(CHOOSEN(p_f, eyeball), NAMED('original_input'));
// OUTPUT(COUNT(p_f(ssn<>'')), NAMED('records_with_ssn_originally'));

shell_input := DISTRIBUTE(p_f(ssn=''), RANDOM());

xlayout := RECORD
	risk_indicators.Layout_Boca_Shell;
	STRING errorcode;
END;

xlayout myFail(shell_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (UNSIGNED)le.AccountNumber;
	SELF := le;
	SELF := [];
END;

adlappendshell := SOAPCALL(shell_input, roxieIP,
				'Risk_Indicators.Boca_Shell', {shell_input}, 
				DATASET(xlayout),
				RETRY(3), TIMEOUT(120), 
				//RETRY(5), TIMEOUT(500), LITERAL,
				PARALLEL(1), onFail(myFail(LEFT)));

// output(adlappendshell, named ('adlappendshell'));

appended_ssns := JOIN(shell_input, adlappendshell, (UNSIGNED)LEFT.accountnumber=RIGHT.seq,
					TRANSFORM(layout_soap_boca, SELF.ssn := RIGHT.shell_input.ssn, SELF := LEFT));

// version 4 attributes append best ssn internally if not present, so it should not run the adl shell
LeadIntegrity_input_temp := IF(runADL and version != 4, appended_ssns + p_f(ssn<>''), p_f);  // add back the records that already had the SSN on the customer file if TRUE, skip if FALSE

layout_soap := RECORD
	DATASET(iesp.leadintegrity.t_LeadIntegrityRequest) LeadIntegrityRequest;
	unsigned DID;
	UNSIGNED3 HistoryDateYYYYMM;
	string old_account_number;
	string wuid;
	string jobowner;
END;

layout_soap transform_input_request( LeadIntegrity_input_temp le) := TRANSFORM
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := le.accountnumber; SELF.DLPurpose := '0'; SELF.GLBPurpose := '5'; SELF.DataRestrictionMask := '000000000000'; SELF := []));
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityOptions, SELF.AttributesVersionRequest := (STRING)VERSION; SELF := []));
	
	n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.First := le.FirstName; SELF.Middle := le.MiddleName; SELF.Last := le.LastName; SELF := []));
	a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.StreetAddress; SELF.City := le.City; SELF.State := le.State; SELF.Zip5 := le.Zip; SELF := []));
	d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.DateOfBirth[1..4]; SELF.Month := (INTEGER)le.DateOfBirth[5..6]; SELF.Day := (INTEGER)le.DateOfBirth[7..8]; SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegritySearchBy, SELF.Seq := le.AccountNumber; 
																																											SELF.Name := n[1]; 
																																											SELF.Address := a[1]; 
																																											SELF.DOB := d[1]; 
																																											SELF.SSN := le.SSN; 
																																											SELF.HomePhone := le.HomePhone; 
																																											SELF.WorkPhone := le.WorkPhone;
																																											SELF.DriverLicenseNumber := le.DLNumber;
																																											SELF.DriverLicenseState := le.DLState;
																																											SELF := []));
	r := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
	SELF.LeadIntegrityRequest := r[1];
	self.did := le.did;
	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	self.old_account_number := le.old_account_number;
	self.wuid := thorlib.wuid();
	self.jobowner := thorlib.jobowner();
	SELF := [];
END;

LeadIntegrity_input := DISTRIBUTE(PROJECT(LeadIntegrity_input_temp, transform_input_request(LEFT)), RANDOM());

// OUTPUT(CHOOSEN(LeadIntegrity_input, eyeball), NAMED('LeadIntegrity_input'));  
// OUTPUT(COUNT(LeadIntegrity_input (LeadIntegrityRequest[1].SearchBy.SSN <> '')), NAMED('records_with_ssn_after_appending_it')); // double check that this one has ssns

//added by Chad
ds_input := IF (record_limit = 0, f, CHOOSEN (f , record_limit));

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	// boolean IncludeVersion4;
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	
	//BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := le.accountnumber;
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
	self.historydateyyyymm := 999999 ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', roxieIP}], risk_indicators.layout_gateways_in);
	// SELF.IsPreScreen := true;		
	// self.IncludeVersion4 := true;
	SELF.Version := bocaShellVersion;
	SELF.adl_based_shell := true;
  SELF.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	END;
	
	soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));

//End added by chad


// Now run the LeadIntegrity attributes
LeadIntegrityoutput := RECORD
	// unsigned6 did;
  // models.layouts.layout_LeadIntegrity_attributes_batch ;
	Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
	STRING errorcode;
END;

LeadIntegrityoutput myFail2(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

// LeadIntegrity_attributes := SOAPCALL(LeadIntegrity_input, roxieIP,
				// 'Models.LeadIntegrity_Batch_Service', {LeadIntegrity_input}, 
				// DATASET(LeadIntegrityoutput),
				// PARALLEL(threads), onFail(myFail2(LEFT)));
				
LeadIntegrity_attributes := SOAPCALL(soap_in, roxieIP,
				'Models.LeadIntegrity_Batch_Service.0', {soap_in}, 
				DATASET(LeadIntegrityoutput),
				PARALLEL(threads), onFail(myFail2(LEFT)));				
				
// OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode=''), eyeball), NAMED('LeadIntegrity_results'));
// OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode<>''), eyeball), NAMED('LeadIntegrity_errors'));

// op_final := output(LeadIntegrity_attributes,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


	layout_slimmed := record
		STRING20 seq;
		STRING30 AccountNumber;
		string4 AgeOldestRecord;
		string4 AgeNewestRecord;
		string1 RecentUpdate;
		string3 SrcsConfirmIDAddrCount;
		string1 CreditBureauRecord;
		string2 VerificationFailure;
		string2 SSNNotFound;
		string2 SSNFoundOther;
		string1 VerifiedName;
		string2 VerifiedSSN;
		string2 VerifiedPhone;
		string2 VerifiedAddress;
		string2 VerifiedDOB;
		string3 AgeRiskIndicator;
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
		string3 InputAddrPhoneCount;
		string3 InputAddrPhoneRecentCount;
		string3 PhoneIdentitiesCount;
		string3 PhoneIdentitiesRecentCount;
		string2 PhoneOther;
		string3 SSNLastNameCount;
		string3 SubjectLastNameCount;
		string4 LastNameChangeAge;
		string3 LastNameChangeCount01;
		string3 LastNameChangeCount03;
		string3 LastNameChangeCount06;
		string3 LastNameChangeCount12;
		string3 LastNameChangeCount24;
		string3 LastNameChangeCount60;
		string3 SFDUAddrIdentitiesCount;
		string3 SFDUAddrSSNCount;
		string3 SSNAgeDeceased;
		string2 SSNRecent;
		string3 SSNLowIssueAge;
		string3 SSNHighIssueAge;
		string2 SSNIssueState;
		string2 SSNNonUS;
		string2 SSN3Years;
		string2 SSNAfter5;
		string2 SSNProblems;
		string3 RelativesCount;
		string3 RelativesBankruptcyCount;
		string3 RelativesFelonyCount;
		string3 RelativesPropOwnedCount;
		string10 RelativesPropOwnedTaxTotal;
		string2 RelativesDistanceClosest;
		string3 InputAddrAgeOldestRecord;
		string3 InputAddrAgeNewestRecord;
		string2 InputAddrHistoricalMatch;
		string3 InputAddrLenOfRes;
		string2 InputAddrDwellType;
		string2 InputAddrDelivery;
		string2 InputAddrApplicantOwned;
		string2 InputAddrFamilyOwned;
		string2 InputAddrOccupantOwned;
		string3 InputAddrAgeLastSale;
		string10 InputAddrLastSalesPrice;
		string2 InputAddrMortgageType;
		string2 InputAddrNotPrimaryRes;
		string2 InputAddrActivePhoneList;
		string10 InputAddrTaxValue;
		string4 InputAddrTaxYr;
		string10 InputAddrTaxMarketValue;
		string10 InputAddrAVMValue;
		string10 InputAddrAVMValue12;
		string10 InputAddrAVMValue60;
		string5 InputAddrCountyIndex;
		string5 InputAddrTractIndex;
		string5 InputAddrBlockIndex;
		string10 InputAddrMedianIncome;
		string10 InputAddrMedianValue;
		string3 InputAddrMurderIndex;
		string3 InputAddrCarTheftIndex;
		string3 InputAddrBurglaryIndex;
		string3 InputAddrCrimeIndex;
		string3 InputAddrMobilityIndex;
		string3 InputAddrVacantPropCount;
		string3 InputAddrBusinessCount;
		string3 InputAddrSingleFamilyCount;
		string3 InputAddrMultiFamilyCount;
		string3 CurrAddrAgeOldestRecord;
		string3 CurrAddrAgeNewestRecord;
		string3 CurrAddrLenOfRes;
		string2 CurrAddrDwellType;
		string2 CurrAddrApplicantOwned;
		string2 CurrAddrFamilyOwned;
		string2 CurrAddrOccupantOwned;
		string3 CurrAddrAgeLastSale;
		string10 CurrAddrLastSalesPrice;
		string2 CurrAddrMortgageType;
		string2 CurrAddrActivePhoneList;
		string10 CurrAddrTaxValue;
		string4 CurrAddrTaxYr;
		string10 CurrAddrTaxMarketValue;
		string10 CurrAddrAVMValue;
		string10 CurrAddrAVMValue12;
		string10 CurrAddrAVMValue60;
		string5 CurrAddrCountyIndex;
		string5 CurrAddrTractIndex;
		string5 CurrAddrBlockIndex;
		string10 CurrAddrMedianIncome;
		string10 CurrAddrMedianValue;
		string3 CurrAddrMurderIndex;
		string3 CurrAddrCarTheftIndex;
		string3 CurrAddrBurglaryIndex;
		string3 CurrAddrCrimeIndex;
		string3 PrevAddrAgeOldestRecord;
		string3 PrevAddrAgeNewestRecord;
		string3 PrevAddrLenOfRes;
		string2 PrevAddrDwellType;
		string2 PrevAddrApplicantOwned;
		string2 PrevAddrFamilyOwned;
		string2 PrevAddrOccupantOwned;
		string3 PrevAddrAgeLastSale;
		string10 PrevAddrLastSalesPrice;
		string10 PrevAddrTaxValue;
		string4 PrevAddrTaxYr;
		string10 PrevAddrTaxMarketValue;
		string10 PrevAddrAVMValue;
		string5 PrevAddrCountyIndex;
		string5 PrevAddrTractIndex;
		string5 PrevAddrBlockIndex;
		string10 PrevAddrMedianIncome;
		string10 PrevAddrMedianValue;
		string3 PrevAddrMurderIndex;
		string3 PrevAddrCarTheftIndex;
		string3 PrevAddrBurglaryIndex;
		string3 PrevAddrCrimeIndex;
		string4 AddrMostRecentDistance;
		string2 AddrMostRecentStateDiff;
		string11 AddrMostRecentTaxDiff;
		string3 AddrMostRecentMoveAge;
		string11 AddrMostRecentIncomeDiff;
		string11 AddrMostRecentValueDIff;
		string4 AddrMostRecentCrimeDiff;
		string2 AddrRecentEconTrajectory;
		string2 AddrRecentEconTrajectoryIndex;
		string1 EducationAttendedCollege;
		string2 EducationProgram2Yr;
		string2 EducationProgram4Yr;
		string2 EducationProgramGraduate;
		string2 EducationInstitutionPrivate;
		string2 EducationInstitutionRating;
		string2 EducationFieldofStudyType;
		string1 AddrStability;
		string2 StatusMostRecent;
		string2 StatusPrevious;
		string2 StatusNextPrevious;
		string3 AddrChangeCount01;
		string3 AddrChangeCount03;
		string3 AddrChangeCount06;
		string3 AddrChangeCount12;
		string3 AddrChangeCount24;
		string3 AddrChangeCount60;
		string10 EstimatedAnnualIncome;
		string1 AssetOwner;
		string1 PropertyOwner;
		string3 PropOwnedCount;
		string10 PropOwnedTaxTotal;
		string3 PropOwnedHistoricalCount;
		string3 PropAgeOldestPurchase;
		string3 PropAgeNewestPurchase;
		string3 PropAgeNewestSale;
		string10 PropNewestSalePrice;
		string4 PropNewestSalePurchaseIndex;
		string3 PropPurchasedCount01;
		string3 PropPurchasedCount03;
		string3 PropPurchasedCount06;
		string3 PropPurchasedCount12;
		string3 PropPurchasedCount24;
		string3 PropPurchasedCount60;
		string3 PropSoldCount01;
		string3 PropSoldCount03;
		string3 PropSoldCount06;
		string3 PropSoldCount12;
		string3 PropSoldCount24;
		string3 PropSoldCount60;
		string1 WatercraftOwner;
		string3 WatercraftCount;
		string3 WatercraftCount01;
		string3 WatercraftCount03;
		string3 WatercraftCount06;
		string3 WatercraftCount12;
		string3 WatercraftCount24;
		string3 WatercraftCount60;
		string1 AircraftOwner;
		string3 AircraftCount;
		string3 AircraftCount01;
		string3 AircraftCount03;
		string3 AircraftCount06;
		string3 AircraftCount12;
		string3 AircraftCount24;
		string3 AircraftCount60;
		string2 WealthIndex;
		string2 BusinessActiveAssociation;
		string2 BusinessInactiveAssociation;
		string3 BusinessAssociationAge;
		string100 BusinessTitle;
		string3 BusinessInputAddrCount;
		string2 DerogSeverityIndex;
		string3 DerogCount;
		string3 DerogRecentCount;
		string3 DerogAge;
		string3 FelonyCount;
		string3 FelonyAge;
		string3 FelonyCount01;
		string3 FelonyCount03;
		string3 FelonyCount06;
		string3 FelonyCount12;
		string3 FelonyCount24;
		string3 FelonyCount60;
		string3 ArrestCount;
		string3 ArrestAge;
		string3 ArrestCount01;
		string3 ArrestCount03;
		string3 ArrestCount06;
		string3 ArrestCount12;
		string3 ArrestCount24;
		string3 ArrestCount60;
		string3 LienCount;
		string3 LienFiledCount;
		string10 LienFiledTotal;
		string3 LienFiledAge;
		string3 LienFiledCount01;
		string3 LienFiledCount03;
		string3 LienFiledCount06;
		string3 LienFiledCount12;
		string3 LienFiledCount24;
		string3 LienFiledCount60;
		string3 LienReleasedCount;
		string10 LienReleasedTotal;
		string3 LienReleasedAge;
		string3 LienReleasedCount01;
		string3 LienReleasedCount03;
		string3 LienReleasedCount06;
		string3 LienReleasedCount12;
		string3 LienReleasedCount24;
		string3 LienReleasedCount60;
		string3 BankruptcyCount;
		string3 BankruptcyAge;
		string2 BankruptcyType;
		string35 BankruptcyStatus;
		string3 BankruptcyCount01;
		string3 BankruptcyCount03;
		string3 BankruptcyCount06;
		string3 BankruptcyCount12;
		string3 BankruptcyCount24;
		string3 BankruptcyCount60;
		string3 EvictionCount;
		string3 EvictionAge;
		string3 EvictionCount01;
		string3 EvictionCount03;
		string3 EvictionCount06;
		string3 EvictionCount12;
		string3 EvictionCount24;
		string3 EvictionCount60;
		string3 AccidentCount;
		string3 AccidentAge;
		string2 RecentActivityIndex;
		string3 NonDerogCount;
		string3 NonDerogCount01;
		string3 NonDerogCount03;
		string3 NonDerogCount06;
		string3 NonDerogCount12;
		string3 NonDerogCount24;
		string3 NonDerogCount60;
		string1 VoterRegistrationRecord;
		string3 ProfLicCount;
		string3 ProfLicAge;
		string2 ProfLicTypeCategory;
		string2 ProfLicExpired;
		string3 ProfLicCount01;
		string3 ProfLicCount03;
		string3 ProfLicCount06;
		string3 ProfLicCount12;
		string3 ProfLicCount24;
		string3 ProfLicCount60;
		string3 PRSearchLocateCount;
		string3 PRSearchLocateCount01;
		string3 PRSearchLocateCount03;
		string3 PRSearchLocateCount06;
		string3 PRSearchLocateCount12;
		string3 PRSearchLocateCount24;
		string3 PRSearchPersonalFinanceCount;
		string3 PRSearchPersonalFinanceCount01;
		string3 PRSearchPersonalFinanceCount03;
		string3 PRSearchPersonalFinanceCount06;
		string3 PRSearchPersonalFinanceCount12;
		string3 PRSearchPersonalFinanceCount24;
		string3 PRSearchOtherCount;
		string3 PRSearchOtherCount01;
		string3 PRSearchOtherCount03;
		string3 PRSearchOtherCount06;
		string3 PRSearchOtherCount12;
		string3 PRSearchOtherCount24;
		string3 PRSearchIdentitySSNs;
		string3 PRSearchIdentityAddrs;
		string3 PRSearchIdentityPhones;
		string3 PRSearchSSNIdentities;
		string3 PRSearchAddrIdentities;
		string3 PRSearchPhoneIdentities;
		string3 SubPrimeOfferRequestCount;
		string3 SubPrimeOfferRequestCount01;
		string3 SubPrimeOfferRequestCount03;
		string3 SubPrimeOfferRequestCount06;
		string3 SubPrimeOfferRequestCount12;
		string3 SubPrimeOfferRequestCount24;
		string3 SubPrimeOfferRequestCount60;
		string2 InputPhoneMobile;
		string2 InputPhoneType;
		string2 InputPhoneServiceType;
		string2 InputAreaCodeChange;
		string3 PhoneEDAAgeOldestRecord;
		string3 PhoneEDAAgeNewestRecord;
		string3 PhoneOtherAgeOldestRecord;
		string3 PhoneOtherAgeNewestRecord;
		string2 InputPhoneHighRisk;
		string2 InputPhoneProblems;
		string2 OnlineDirectory;
		string4 InputAddrSICCode;
		string2 InputAddrValidation;
		string5 InputAddrErrorCode;
		string2 InputAddrHighRisk;
		string2 CurrAddrCorrectional;
		string2 PrevAddrCorrectional;
		string2 HistoricalAddrCorrectional;
		string2 InputAddrProblems;
		string1 DoNotMail;
		// 4.1 Attributes (Part of 4.0)
		STRING2 IdentityRiskLevel := '';
		STRING2 IDVerRiskLevel := '';
		STRING3 IDVerAddressAssocCount := '';
		STRING2 IDVerSSNCreditBureauCount := '';
		STRING2 IDVerSSNCreditBureauDelete := '';
		STRING2 SourceRiskLevel := '';
		STRING1 SourceWatchList := '';
		STRING1 SourceOrderActivity := '';
		STRING3 SourceOrderSourceCount := '';
		STRING3 SourceOrderAgeLastOrder := '';
		STRING2 VariationRiskLevel := '';
		STRING3 VariationIdentityCount := '';
		STRING3 VariationMSourcesSSNCount := '';
		STRING3 VariationMSourcesSSNUnrelCount := '';
		STRING3 VariationDOBCount := '';
		STRING3 VariationDOBCountNew := '';
		STRING2 SearchVelocityRiskLevel := '';
		STRING3 SearchUnverifiedSSNCountYear := '';
		STRING3 SearchUnverifiedAddrCountYear := '';
		STRING3 SearchUnverifiedDOBCountYear := '';
		STRING3 SearchUnverifiedPhoneCountYear := '';
		STRING2 AssocRiskLevel := '';
		STRING3 AssocSuspicousIdentitiesCount := '';
		STRING3 AssocCreditBureauOnlyCount := '';
		STRING3 AssocCreditBureauOnlyCountNew := '';
		STRING3 AssocCreditBureauOnlyCountMonth := '';
		STRING3 AssocHighRiskTopologyCount := '';
		STRING1 ValidationRiskLevel := '';
		STRING1 CorrelationRiskLevel := '';
		STRING1 DivRiskLevel := '';
		STRING3 DivSSNIdentityMSourceCount := '';
		STRING3 DivSSNIdentityMSourceUrelCount := '';
		STRING3 DivSSNLNameCountNew := '';
		STRING3 DivSSNAddrMSourceCount := '';
		STRING3 DivAddrIdentityCount := '';
		STRING3 DivAddrIdentityCountNew := '';
		STRING3 DivAddrIdentityMSourceCount := '';
		STRING3 DivAddrSuspIdentityCountNew := '';
		STRING3 DivAddrSSNCount := '';
		STRING3 DivAddrSSNCountNew := '';
		STRING3 DivAddrSSNMSourceCount := '';
		STRING3 DivSearchAddrSuspIdentityCount := '';
		STRING1 SearchComponentRiskLevel := '';
		STRING3 SearchSSNSearchCount := '';
		STRING3 SearchAddrSearchCount := '';
		STRING3 SearchPhoneSearchCount := '';
		STRING1 ComponentCharRiskLevel := '';
		
		#if(include_internal_extras)
			RiskProcessing.layout_internal_extras;
		#end
	end;

	layout_slimmed slim_v4( LeadIntegrity_attributes le ) := TRANSFORM
		self.accountnumber := le.acctno ; // original account number not available here...
		SELF.seq := le.Seq; // ...so hang onto the seq

				self.AgeOldestRecord                      	      :=  le.v4_AgeOldestRecord                ; 
				self.AgeNewestRecord                      	      :=  le.v4_AgeNewestRecord                 ; 
				self.RecentUpdate                         	      :=  le.v4_RecentUpdate                   ; 
				self.SrcsConfirmIDAddrCount               	      :=  le.v4_SrcsConfirmIDAddrCount         ;
	  		self.CreditBureauRecord                   	      :=  le.v4_CreditBureauRecord             ;
    		self.VerificationFailure                  	      :=  le.v4_VerificationFailure            ;
	  		self.SSNNotFound                          	      :=  le.v4_SSNNotFound                     ;
    		self.SSNFoundOther                        	      :=  le.v4_SSNFoundOther                   ;
		    self.VerifiedName                         	      :=  le.v4_VerifiedName                    ;
    		self.VerifiedSSN                          	      :=  le.v4_VerifiedSSN                     ;
    		self.VerifiedPhone                        	      :=  le.v4_VerifiedPhone                   ;
    		self.VerifiedAddress                      	      :=  le.v4_VerifiedAddress                 ;
    		self.VerifiedDOB                          	      :=  le.v4_VerifiedDOB                     ;
    		self.AgeRiskIndicator                     	      :=  le.v4_AgeRiskIndicator                ;
    		self.SubjectSSNCount                      	      :=  le.v4_SubjectSSNCount                 ;
    		self.SubjectAddrCount                     	      :=  le.v4_SubjectAddrCount                ;
    		self.SubjectPhoneCount                    	      :=  le.v4_SubjectPhoneCount               ;
    		self.SubjectSSNRecentCount                	      :=  le.v4_SubjectSSNRecentCount           ;
    		self.SubjectAddrRecentCount               	      :=  le.v4_SubjectAddrRecentCount          ;
    		self.SubjectPhoneRecentCount              	      :=  le.v4_SubjectPhoneRecentCount         ;
    		self.SSNIdentitiesCount                   	      :=  le.v4_SSNIdentitiesCount              ;
    		self.SSNAddrCount                         	      :=  le.v4_SSNAddrCount                    ;
    		self.SSNIdentitiesRecentCount             	      :=  le.v4_SSNIdentitiesRecentCount        ;
    		self.SSNAddrRecentCount                   	      :=  le.v4_SSNAddrRecentCount              ;
    		self.InputAddrPhoneCount                  	      :=  le.v4_InputAddrPhoneCount             ;
    		self.InputAddrPhoneRecentCount            	      :=  le.v4_InputAddrPhoneRecentCount       ;
    		self.PhoneIdentitiesCount                 	      :=  le.v4_PhoneIdentitiesCount            ;
    		self.PhoneIdentitiesRecentCount           	      :=  le.v4_PhoneIdentitiesRecentCount      ;
    		self.PhoneOther                           	      :=  le.v4_PhoneOther                      ;
    		self.SSNLastNameCount                     	      :=  le.v4_SSNLastNameCount                ;
    		self.SubjectLastNameCount                 	      :=  le.v4_SubjectLastNameCount            ;
    		self.LastNameChangeAge                    	      :=  le.v4_LastNameChangeAge               ;
    		self.LastNameChangeCount01                	      :=  le.v4_LastNameChangeCount01           ;
    		self.LastNameChangeCount03                	      :=  le.v4_LastNameChangeCount03           ;
    		self.LastNameChangeCount06                	      :=  le.v4_LastNameChangeCount06           ;
    		self.LastNameChangeCount12                	      :=  le.v4_LastNameChangeCount12           ;
    		self.LastNameChangeCount24                	      :=  le.v4_LastNameChangeCount24           ;
    		self.LastNameChangeCount60                	      :=  le.v4_LastNameChangeCount60           ;
    		self.SFDUAddrIdentitiesCount              	      :=  le.v4_SFDUAddrIdentitiesCount         ;
    		self.SFDUAddrSSNCount                     	      :=  le.v4_SFDUAddrSSNCount                ;
    		self.SSNAgeDeceased                       	      :=  le.v4_SSNAgeDeceased                  ;
    		self.SSNRecent                            	      :=  le.v4_SSNRecent                       ;
    		self.SSNLowIssueAge                       	      :=  le.v4_SSNLowIssueAge                  ;
    		self.SSNHighIssueAge                      	      :=  le.v4_SSNHighIssueAge                 ;
    		self.SSNIssueState                        	      :=  le.v4_SSNIssueState                   ;
    		self.SSNNonUS                             	      :=  le.v4_SSNNonUS                        ;
    		self.SSN3Years                            	      :=  le.v4_SSN3Years                       ;
    		self.SSNAfter5                            	      :=  le.v4_SSNAfter5                       ;
    		self.SSNProblems                          	      :=  le.v4_SSNProblems                     ;
    		self.RelativesCount                       	      :=  le.v4_RelativesCount                  ;
    		self.RelativesBankruptcyCount             	      :=  le.v4_RelativesBankruptcyCount        ;
    		self.RelativesFelonyCount                 	      :=  le.v4_RelativesFelonyCount            ;
    		self.RelativesPropOwnedCount              	      :=  le.v4_RelativesPropOwnedCount         ;
    		self.RelativesPropOwnedTaxTotal           	      :=  le.v4_RelativesPropOwnedTaxTotal      ;
    		self.RelativesDistanceClosest             	      :=  le.v4_RelativesDistanceClosest        ;
    		self.InputAddrAgeOldestRecord             	      :=  le.v4_InputAddrAgeOldestRecord        ;
    		self.InputAddrAgeNewestRecord             	      :=  le.v4_InputAddrAgeNewestRecord        ;
    		self.InputAddrHistoricalMatch             	      :=  le.v4_InputAddrHistoricalMatch        ;
    		self.InputAddrLenOfRes                    	      :=  le.v4_InputAddrLenOfRes               ;
    		self.InputAddrDwellType                   	      :=  le.v4_InputAddrDwellType              ;
    		self.InputAddrDelivery                    	      :=  le.v4_InputAddrDelivery               ;
    		self.InputAddrApplicantOwned              	      :=  le.v4_InputAddrApplicantOwned         ;
    		self.InputAddrFamilyOwned                 	      :=  le.v4_InputAddrFamilyOwned            ;
    		self.InputAddrOccupantOwned               	      :=  le.v4_InputAddrOccupantOwned          ;
    		self.InputAddrAgeLastSale                 	      :=  le.v4_InputAddrAgeLastSale           ;
    		self.InputAddrLastSalesPrice              	      :=  le.v4_InputAddrLastSalesPrice         ;
    		self.InputAddrMortgageType                	      :=  le.v4_InputAddrMortgageType           ;
    		self.InputAddrNotPrimaryRes               	      :=  le.v4_InputAddrNotPrimaryRes          ;
    		self.InputAddrActivePhoneList             	      :=  le.v4_InputAddrActivePhoneList        ;
    		self.InputAddrTaxValue                    	      :=  le.v4_InputAddrTaxValue               ;
    		self.InputAddrTaxYr                       	      :=  le.v4_InputAddrTaxYr                  ;
    		self.InputAddrTaxMarketValue              	      :=  le.v4_InputAddrTaxMarketValue         ;
    		self.InputAddrAVMValue                    	      :=  le.v4_InputAddrAVMValue               ;
    		self.InputAddrAVMValue12                  	      :=  le.v4_InputAddrAVMValue12             ;
    		self.InputAddrAVMValue60                  	      :=  le.v4_InputAddrAVMValue60             ;
    		self.InputAddrCountyIndex                 	      :=  le.v4_InputAddrCountyIndex            ;
    		self.InputAddrTractIndex                  	      :=  le.v4_InputAddrTractIndex             ;
    		self.InputAddrBlockIndex                  	      :=  le.v4_InputAddrBlockIndex             ;
    		self.InputAddrMedianIncome                	      :=  le.v4_InputAddrMedianIncome           ;
    		self.InputAddrMedianValue                 	      :=  le.v4_InputAddrMedianValue            ;
    		self.InputAddrMurderIndex                 	      :=  le.v4_InputAddrMurderIndex            ;
    		self.InputAddrCarTheftIndex               	      :=  le.v4_InputAddrCarTheftIndex          ;
    		self.InputAddrBurglaryIndex               	      :=  le.v4_InputAddrBurglaryIndex          ;
    		self.InputAddrCrimeIndex                  	      :=  le.v4_InputAddrCrimeIndex             ;
    		self.InputAddrMobilityIndex               	      :=  le.v4_InputAddrMobilityIndex          ;
    		self.InputAddrVacantPropCount             	      :=  le.v4_InputAddrVacantPropCount        ;
    		self.InputAddrBusinessCount               	      :=  le.v4_InputAddrBusinessCount          ;
    		self.InputAddrSingleFamilyCount           	      :=  le.v4_InputAddrSingleFamilyCount      ;
    		self.InputAddrMultiFamilyCount            	      :=  le.v4_InputAddrMultiFamilyCount       ;
    		self.CurrAddrAgeOldestRecord              	      :=  le.v4_CurrAddrAgeOldestRecord         ;
    		self.CurrAddrAgeNewestRecord              	      :=  le.v4_CurrAddrAgeNewestRecord         ;
    		self.CurrAddrLenOfRes                     	      :=  le.v4_CurrAddrLenOfRes               ;
    		self.CurrAddrDwellType                    	      :=  le.v4_CurrAddrDwellType               ;
    		self.CurrAddrApplicantOwned               	      :=  le.v4_CurrAddrApplicantOwned          ;
    		self.CurrAddrFamilyOwned                  	      :=  le.v4_CurrAddrFamilyOwned             ;
    		self.CurrAddrOccupantOwned                	      :=  le.v4_CurrAddrOccupantOwned           ;
    		self.CurrAddrAgeLastSale                  	      :=  le.v4_CurrAddrAgeLastSale            ;
    		self.CurrAddrLastSalesPrice               	      :=  le.v4_CurrAddrLastSalesPrice          ;
    		self.CurrAddrMortgageType                 	      :=  le.v4_CurrAddrMortgageType            ;
    		self.CurrAddrActivePhoneList              	      :=  le.v4_CurrAddrActivePhoneList         ;
    		self.CurrAddrTaxValue                     	      :=  le.v4_CurrAddrTaxValue                ;
    		self.CurrAddrTaxYr                        	      :=  le.v4_CurrAddrTaxYr                   ;
    		self.CurrAddrTaxMarketValue               	      :=  le.v4_CurrAddrTaxMarketValue          ;
    		self.CurrAddrAVMValue                     	      :=  le.v4_CurrAddrAVMValue                ;
    		self.CurrAddrAVMValue12                   	      :=  le.v4_CurrAddrAVMValue12              ;
    		self.CurrAddrAVMValue60                   	      :=  le.v4_CurrAddrAVMValue60              ;
    		self.CurrAddrCountyIndex                  	      :=  le.v4_CurrAddrCountyIndex             ;
    		self.CurrAddrTractIndex                   	      :=  le.v4_CurrAddrTractIndex              ;
    		self.CurrAddrBlockIndex                   	      :=  le.v4_CurrAddrBlockIndex              ;
    		self.CurrAddrMedianIncome                 	      :=  le.v4_CurrAddrMedianIncome            ;
    		self.CurrAddrMedianValue                  	      :=  le.v4_CurrAddrMedianValue             ;
    		self.CurrAddrMurderIndex                  	      :=  le.v4_CurrAddrMurderIndex             ;
    		self.CurrAddrCarTheftIndex                	      :=  le.v4_CurrAddrCarTheftIndex           ;
    		self.CurrAddrBurglaryIndex                	      :=  le.v4_CurrAddrBurglaryIndex           ;
    		self.CurrAddrCrimeIndex                   	      :=  le.v4_CurrAddrCrimeIndex              ;
    		self.PrevAddrAgeOldestRecord              	      :=  le.v4_PrevAddrAgeOldestRecord         ;
    		self.PrevAddrAgeNewestRecord              	      :=  le.v4_PrevAddrAgeNewestRecord         ;
    		self.PrevAddrLenOfRes                     	      :=  le.v4_PrevAddrLenOfRes                ;
    		self.PrevAddrDwellType                    	      :=  le.v4_PrevAddrDwellType               ;
    		self.PrevAddrApplicantOwned               	      :=  le.v4_PrevAddrApplicantOwned          ;
    		self.PrevAddrFamilyOwned                  	      :=  le.v4_PrevAddrFamilyOwned             ;
    		self.PrevAddrOccupantOwned                	      :=  le.v4_PrevAddrOccupantOwned           ;
    		self.PrevAddrAgeLastSale                  	      :=  le.v4_PrevAddrAgeLastSale            ;
    		self.PrevAddrLastSalesPrice               	      :=  le.v4_PrevAddrLastSalesPrice          ;
    		self.PrevAddrTaxValue                     	      :=  le.v4_PrevAddrTaxValue                ;
    		self.PrevAddrTaxYr                        	      :=  le.v4_PrevAddrTaxYr                   ;
    		self.PrevAddrTaxMarketValue               	      :=  le.v4_PrevAddrTaxMarketValue          ;
    		self.PrevAddrAVMValue                     	      :=  le.v4_PrevAddrAVMValue                ;
    		self.PrevAddrCountyIndex                  	      :=  le.v4_PrevAddrCountyIndex             ;
    		self.PrevAddrTractIndex                   	      :=  le.v4_PrevAddrTractIndex              ;
    		self.PrevAddrBlockIndex                   	      :=  le.v4_PrevAddrBlockIndex              ;
    		self.PrevAddrMedianIncome                 	      :=  le.v4_PrevAddrMedianIncome            ;
    		self.PrevAddrMedianValue                  	      :=  le.v4_PrevAddrMedianValue             ;
    		self.PrevAddrMurderIndex                  	      :=  le.v4_PrevAddrMurderIndex             ;
    		self.PrevAddrCarTheftIndex                	      :=  le.v4_PrevAddrCarTheftIndex           ;
    		self.PrevAddrBurglaryIndex                	      :=  le.v4_PrevAddrBurglaryIndex           ;
    		self.PrevAddrCrimeIndex                   	      :=  le.v4_PrevAddrCrimeIndex              ;
    		self.AddrMostRecentDistance               	      :=  le.v4_AddrMostRecentDistance          ;
    		self.AddrMostRecentStateDiff              	      :=  le.v4_AddrMostRecentStateDiff         ;
    		self.AddrMostRecentTaxDiff                	      :=  le.v4_AddrMostRecentTaxDiff           ;
    		self.AddrMostRecentMoveAge                	      :=  le.v4_AddrMostRecentMoveAge           ;
    		self.AddrMostRecentIncomeDiff             	      :=  le.v4_AddrMostRecentIncomeDiff        ;
    		self.AddrMostRecentValueDIff              	      :=  le.v4_AddrMostRecentValueDIff         ;
    		self.AddrMostRecentCrimeDiff              	      :=  le.v4_AddrMostRecentCrimeDiff         ;
    		self.AddrRecentEconTrajectory             	      :=  le.v4_AddrRecentEconTrajectory        ;
    		self.AddrRecentEconTrajectoryIndex        	      :=  le.v4_AddrRecentEconTrajectoryIndex   ;
    		self.EducationAttendedCollege             	      :=  le.v4_EducationAttendedCollege       ;
    		self.EducationProgram2Yr                  	      :=  le.v4_EducationProgram2Yr             ;
    		self.EducationProgram4Yr                  	      :=  le.v4_EducationProgram4Yr             ;
    		self.EducationProgramGraduate             	      :=  le.v4_EducationProgramGraduate        ;
    		self.EducationInstitutionPrivate          	      :=  le.v4_EducationInstitutionPrivate     ;
    		self.EducationInstitutionRating           	      :=  le.v4_EducationInstitutionRating      ;
    		self.EducationFieldofStudyType            	      :=  le.v4_EducationFieldofStudyType       ;
    		self.AddrStability                        	      :=  le.v4_AddrStability                   ;
    		self.StatusMostRecent                     	      :=  le.v4_StatusMostRecent                ;
    		self.StatusPrevious                       	      :=  le.v4_StatusPrevious                  ;
    		self.StatusNextPrevious                   	      :=  le.v4_StatusNextPrevious              ;
    		self.AddrChangeCount01                    	      :=  le.v4_AddrChangeCount01               ;
    		self.AddrChangeCount03                    	      :=  le.v4_AddrChangeCount03               ;
    		self.AddrChangeCount06                    	      :=  le.v4_AddrChangeCount06               ;
    		self.AddrChangeCount12                    	      :=  le.v4_AddrChangeCount12               ;
    		self.AddrChangeCount24                    	      :=  le.v4_AddrChangeCount24               ;
    		self.AddrChangeCount60                    	      :=  le.v4_AddrChangeCount60               ;
    		self.EstimatedAnnualIncome                	      :=  le.v4_EstimatedAnnualIncome           ;
    		self.AssetOwner                           	      :=  le.v4_AssetOwner                      ;
    		self.PropertyOwner                        	      :=  le.v4_PropertyOwner                   ;
    		self.PropOwnedCount                       	      :=  le.v4_PropOwnedCount                  ;
    		self.PropOwnedTaxTotal                    	      :=  le.v4_PropOwnedTaxTotal               ;
    		self.PropOwnedHistoricalCount             	      :=  le.v4_PropOwnedHistoricalCount        ;
    		self.PropAgeOldestPurchase                	      :=  le.v4_PropAgeOldestPurchase           ;
    		self.PropAgeNewestPurchase                	      :=  le.v4_PropAgeNewestPurchase           ;
    		self.PropAgeNewestSale                    	      :=  le.v4_PropAgeNewestSale             ;
    		self.PropNewestSalePrice                  	      :=  le.v4_PropNewestSalePrice             ;
    		self.PropNewestSalePurchaseIndex          	      :=  le.v4_PropNewestSalePurchaseIndex     ;
    		self.PropPurchasedCount01                 	      :=  le.v4_PropPurchasedCount01            ;
    		self.PropPurchasedCount03                 	      :=  le.v4_PropPurchasedCount03            ;
    		self.PropPurchasedCount06                 	      :=  le.v4_PropPurchasedCount06            ;
    		self.PropPurchasedCount12                 	      :=  le.v4_PropPurchasedCount12            ;
    		self.PropPurchasedCount24                 	      :=  le.v4_PropPurchasedCount24            ;
    		self.PropPurchasedCount60                 	      :=  le.v4_PropPurchasedCount60            ;
    		self.PropSoldCount01                      	      :=  le.v4_PropSoldCount01                 ;
    		self.PropSoldCount03                      	      :=  le.v4_PropSoldCount03                 ;
    		self.PropSoldCount06                      	      :=  le.v4_PropSoldCount06                 ;
    		self.PropSoldCount12                      	      :=  le.v4_PropSoldCount12                 ;
    		self.PropSoldCount24                      	      :=  le.v4_PropSoldCount24                 ;
    		self.PropSoldCount60                      	      :=  le.v4_PropSoldCount60                 ;
    		self.WatercraftOwner                      	      :=  le.v4_WatercraftOwner                 ;
    		self.WatercraftCount                      	      :=  le.v4_WatercraftCount                 ;
    		self.WatercraftCount01                    	      :=  le.v4_WatercraftCount01               ;
    		self.WatercraftCount03                    	      :=  le.v4_WatercraftCount03               ;
    		self.WatercraftCount06                    	      :=  le.v4_WatercraftCount06               ;
    		self.WatercraftCount12                    	      :=  le.v4_WatercraftCount12               ;
    		self.WatercraftCount24                    	      :=  le.v4_WatercraftCount24               ;
    		self.WatercraftCount60                    	      :=  le.v4_WatercraftCount60               ;
    		self.AircraftOwner                        	      :=  le.v4_AircraftOwner                   ;
    		self.AircraftCount                        	      :=  le.v4_AircraftCount                   ;
    		self.AircraftCount01                      	      :=  le.v4_AircraftCount01                 ;
    		self.AircraftCount03                      	      :=  le.v4_AircraftCount03                 ;
    		self.AircraftCount06                      	      :=  le.v4_AircraftCount06                 ;
    		self.AircraftCount12                      	      :=  le.v4_AircraftCount12                 ;
    		self.AircraftCount24                      	      :=  le.v4_AircraftCount24                 ;
    		self.AircraftCount60                      	      :=  le.v4_AircraftCount60                 ;
    		self.WealthIndex                          	      :=  le.v4_WealthIndex                     ;
    		self.BusinessActiveAssociation            	      :=  le.v4_BusinessActiveAssociation       ;
    		self.BusinessInactiveAssociation          	      :=  le.v4_BusinessInactiveAssociation     ;
    		self.BusinessAssociationAge               	      :=  le.v4_BusinessAssociationAge          ;
    		self.BusinessTitle                        	      :=  le.v4_BusinessTitle                  ;
    		self.BusinessInputAddrCount               	      :=  le.v4_BusinessInputAddrCount          ;
    		self.DerogSeverityIndex                   	      :=  le.v4_DerogSeverityIndex              ;
    		self.DerogCount                           	      :=  le.v4_DerogCount                      ;
    		self.DerogRecentCount                     	      :=  le.v4_DerogRecentCount                ;
    		self.DerogAge                             	      :=  le.v4_DerogAge                        ;
    		self.FelonyCount                          	      :=  le.v4_FelonyCount                     ;
    		self.FelonyAge                            	      :=  le.v4_FelonyAge                       ;
    		self.FelonyCount01                        	      :=  le.v4_FelonyCount01                   ;
    		self.FelonyCount03                        	      :=  le.v4_FelonyCount03                   ;
    		self.FelonyCount06                        	      :=  le.v4_FelonyCount06                   ;
    		self.FelonyCount12                        	      :=  le.v4_FelonyCount12                   ;
    		self.FelonyCount24                        	      :=  le.v4_FelonyCount24                   ;
    		self.FelonyCount60                        	      :=  le.v4_FelonyCount60                   ;
    		self.ArrestCount                          	      :=  le.v4_ArrestCount                     ;
    		self.ArrestAge                            	      :=  le.v4_ArrestAge                       ;
    		self.ArrestCount01                        	      :=  le.v4_ArrestCount01                   ;
    		self.ArrestCount03                        	      :=  le.v4_ArrestCount03                   ;
    		self.ArrestCount06                        	      :=  le.v4_ArrestCount06                   ;
    		self.ArrestCount12                        	      :=  le.v4_ArrestCount12                   ;
    		self.ArrestCount24                        	      :=  le.v4_ArrestCount24                   ;
    		self.ArrestCount60                        	      :=  le.v4_ArrestCount60                   ;
    		self.LienCount                            	      :=  le.v4_LienCount                       ;
    		self.LienFiledCount                       	      :=  le.v4_LienFiledCount                  ;
    		self.LienFiledTotal                       	      :=  le.v4_LienFiledTotal                  ;
    		self.LienFiledAge                         	      :=  le.v4_LienFiledAge                    ;
    		self.LienFiledCount01                     	      :=  le.v4_LienFiledCount01                ;
    		self.LienFiledCount03                     	      :=  le.v4_LienFiledCount03                ;
    		self.LienFiledCount06                     	      :=  le.v4_LienFiledCount06                ;
    		self.LienFiledCount12                     	      :=  le.v4_LienFiledCount12                ;
    		self.LienFiledCount24                     	      :=  le.v4_LienFiledCount24                ;
    		self.LienFiledCount60                     	      :=  le.v4_LienFiledCount60                ;
    		self.LienReleasedCount                    	      :=  le.v4_LienReleasedCount               ;
    		self.LienReleasedTotal                    	      :=  le.v4_LienReleasedTotal               ;
    		self.LienReleasedAge                      	      :=  le.v4_LienReleasedAge                 ;
    		self.LienReleasedCount01                  	      :=  le.v4_LienReleasedCount01             ;
    		self.LienReleasedCount03                  	      :=  le.v4_LienReleasedCount03             ;
    		self.LienReleasedCount06                  	      :=  le.v4_LienReleasedCount06             ;
    		self.LienReleasedCount12                  	      :=  le.v4_LienReleasedCount12             ;
    		self.LienReleasedCount24                  	      :=  le.v4_LienReleasedCount24             ;
    		self.LienReleasedCount60                  	      :=  le.v4_LienReleasedCount60             ;
    		self.BankruptcyCount                      	      :=  le.v4_BankruptcyCount                 ;
    		self.BankruptcyAge                        	      :=  le.v4_BankruptcyAge                   ;
    		self.BankruptcyType                       	      :=  le.v4_BankruptcyType                  ;
    		self.BankruptcyStatus                     	      :=  le.v4_BankruptcyStatus                ;
    		self.BankruptcyCount01                    	      :=  le.v4_BankruptcyCount01               ;
    		self.BankruptcyCount03                    	      :=  le.v4_BankruptcyCount03               ;
    		self.BankruptcyCount06                    	      :=  le.v4_BankruptcyCount06               ;
    		self.BankruptcyCount12                    	      :=  le.v4_BankruptcyCount12               ;
    		self.BankruptcyCount24                    	      :=  le.v4_BankruptcyCount24               ;
    		self.BankruptcyCount60                    	      :=  le.v4_BankruptcyCount60               ;
    		self.EvictionCount                        	      :=  le.v4_EvictionCount                   ;
    		self.EvictionAge                          	      :=  le.v4_EvictionAge                     ;
    		self.EvictionCount01                      	      :=  le.v4_EvictionCount01                 ;
    		self.EvictionCount03                      	      :=  le.v4_EvictionCount03                 ;
    		self.EvictionCount06                      	      :=  le.v4_EvictionCount06                 ;
    		self.EvictionCount12                      	      :=  le.v4_EvictionCount12                 ;
    		self.EvictionCount24                      	      :=  le.v4_EvictionCount24                 ;
    		self.EvictionCount60                      	      :=  le.v4_EvictionCount60                 ;
    		self.AccidentCount                        	      :=  le.v4_AccidentCount                   ;
    		self.AccidentAge                          	      :=  le.v4_AccidentAge                     ;
    		self.RecentActivityIndex                  	      :=  le.v4_RecentActivityIndex             ;
    		self.NonDerogCount                        	      :=  le.v4_NonDerogCount                   ;
    		self.NonDerogCount01                      	      :=  le.v4_NonDerogCount01                 ;
    		self.NonDerogCount03                      	      :=  le.v4_NonDerogCount03                 ;
    		self.NonDerogCount06                      	      :=  le.v4_NonDerogCount06                 ;
    		self.NonDerogCount12                      	      :=  le.v4_NonDerogCount12                 ;
    		self.NonDerogCount24                      	      :=  le.v4_NonDerogCount24                 ;
    		self.NonDerogCount60                      	      :=  le.v4_NonDerogCount60                 ;
    		self.VoterRegistrationRecord              	      :=  le.v4_VoterRegistrationRecord         ;
    		self.ProfLicCount                         	      :=  le.v4_ProfLicCount                    ;
    		self.ProfLicAge                           	      :=  le.v4_ProfLicAge                      ;
    		self.ProfLicTypeCategory                  	      :=  le.v4_ProfLicTypeCategory             ;
    		self.ProfLicExpired                       	      :=  le.v4_ProfLicExpired                  ;
    		self.ProfLicCount01                       	      :=  le.v4_ProfLicCount01                  ;
    		self.ProfLicCount03                       	      :=  le.v4_ProfLicCount03                  ;
    		self.ProfLicCount06                       	      :=  le.v4_ProfLicCount06                  ;
    		self.ProfLicCount12                       	      :=  le.v4_ProfLicCount12                  ;
    		self.ProfLicCount24                       	      :=  le.v4_ProfLicCount24                  ;
    		self.ProfLicCount60                       	      :=  le.v4_ProfLicCount60                  ;
    		self.PRSearchLocateCount                  	      :=  le.v4_PRSearchLocateCount             ;
    		self.PRSearchLocateCount01                	      :=  le.v4_PRSearchLocateCount01           ;
    		self.PRSearchLocateCount03                	      :=  le.v4_PRSearchLocateCount03           ;
    		self.PRSearchLocateCount06                	      :=  le.v4_PRSearchLocateCount06           ;
    		self.PRSearchLocateCount12                	      :=  le.v4_PRSearchLocateCount12           ;
    		self.PRSearchLocateCount24                	      :=  le.v4_PRSearchLocateCount24           ;
    		self.PRSearchPersonalFinanceCount         	      :=  le.v4_PRSearchPersonalFinanceCount    ;
    		self.PRSearchPersonalFinanceCount01       	      :=  le.v4_PRSearchPersonalFinanceCount01  ;
    		self.PRSearchPersonalFinanceCount03       	      :=  le.v4_PRSearchPersonalFinanceCount03  ;
    		self.PRSearchPersonalFinanceCount06       	      :=  le.v4_PRSearchPersonalFinanceCount06  ;
    		self.PRSearchPersonalFinanceCount12       	      :=  le.v4_PRSearchPersonalFinanceCount12  ;
    		self.PRSearchPersonalFinanceCount24       	      :=  le.v4_PRSearchPersonalFinanceCount24  ;
    		self.PRSearchOtherCount                   	      :=  le.v4_PRSearchOtherCount              ;
    		self.PRSearchOtherCount01                 	      :=  le.v4_PRSearchOtherCount01            ;
    		self.PRSearchOtherCount03                 	      :=  le.v4_PRSearchOtherCount03            ;
    		self.PRSearchOtherCount06                 	      :=  le.v4_PRSearchOtherCount06            ;
    		self.PRSearchOtherCount12                 	      :=  le.v4_PRSearchOtherCount12            ;
    		self.PRSearchOtherCount24                 	      :=  le.v4_PRSearchOtherCount24            ;
    		self.PRSearchIdentitySSNs                 	      :=  le.v4_PRSearchIdentitySSNs            ;
    		self.PRSearchIdentityAddrs                	      :=  le.v4_PRSearchIdentityAddrs           ;
    		self.PRSearchIdentityPhones               	      :=  le.v4_PRSearchIdentityPhones          ;
    		self.PRSearchSSNIdentities                	      :=  le.v4_PRSearchSSNIdentities           ;
    		self.PRSearchAddrIdentities               	      :=  le.v4_PRSearchAddrIdentities          ;
    		self.PRSearchPhoneIdentities              	      :=  le.v4_PRSearchPhoneIdentities         ;
    		self.SubPrimeOfferRequestCount            	      :=  le.v4_SubPrimeOfferRequestCount       ;
    		self.SubPrimeOfferRequestCount01          	      :=  le.v4_SubPrimeOfferRequestCount01     ;
    		self.SubPrimeOfferRequestCount03          	      :=  le.v4_SubPrimeOfferRequestCount03     ;
    		self.SubPrimeOfferRequestCount06          	      :=  le.v4_SubPrimeOfferRequestCount06     ;
    		self.SubPrimeOfferRequestCount12          	      :=  le.v4_SubPrimeOfferRequestCount12     ;
    		self.SubPrimeOfferRequestCount24          	      :=  le.v4_SubPrimeOfferRequestCount24     ;
    		self.SubPrimeOfferRequestCount60          	      :=  le.v4_SubPrimeOfferRequestCount60     ;
    		self.InputPhoneMobile                     	      :=  le.v4_InputPhoneMobile              ;
    		self.InputPhoneType                       	      :=  le.v4_InputPhoneType                  ;
    		self.InputPhoneServiceType                	      :=  le.v4_InputPhoneServiceType           ;
    		self.InputAreaCodeChange                  	      :=  le.v4_InputAreaCodeChange             ;
    		self.PhoneEDAAgeOldestRecord              	      :=  le.v4_PhoneEDAAgeOldestRecord         ;
    		self.PhoneEDAAgeNewestRecord              	      :=  le.v4_PhoneEDAAgeNewestRecord         ;
    		self.PhoneOtherAgeOldestRecord            	      :=  le.v4_PhoneOtherAgeOldestRecord       ;
    		self.PhoneOtherAgeNewestRecord            	      :=  le.v4_PhoneOtherAgeNewestRecord       ;
    		self.InputPhoneHighRisk                   	      :=  le.v4_InputPhoneHighRisk              ;
    		self.InputPhoneProblems                   	      :=  le.v4_InputPhoneProblems             ;
    		self.OnlineDirectory                      	      :=  le.v4_OnlineDirectory                 ;
    		self.InputAddrSICCode                     	      :=  le.v4_InputAddrSICCode                ;
    		self.InputAddrValidation                  	      :=  le.v4_InputAddrValidation             ;
    		self.InputAddrErrorCode                   	      :=  le.v4_InputAddrErrorCode              ;
    		self.InputAddrHighRisk                    	      :=  le.v4_InputAddrHighRisk               ;
    		self.CurrAddrCorrectional                 	      :=  le.v4_CurrAddrCorrectional            ;
    		self.PrevAddrCorrectional                 	      :=  le.v4_PrevAddrCorrectional            ;
    		self.HistoricalAddrCorrectional           	      :=  le.v4_HistoricalAddrCorrectional      ;
    		self.InputAddrProblems                    	      :=  le.v4_InputAddrProblems               ;
    		self.DoNotMail                            	      :=  le.v4_DoNotMail                       ;
    		// 4.1 Attributes (Part of 4.0)			      // 4.1 Attributes (Part of 4.0) ;
    		SELF.IdentityRiskLevel                    	      :=  le.v4_IdentityRisklevel               ;
    		SELF.IDVerRiskLevel                       	      :=  le.v4_IDVerRisklevel                  ;
    		SELF.IDVerAddressAssocCount 			      :=  le.v4_IDVerAddressAssocCount 		 ;
    		SELF.IDVerSSNCreditBureauCount 			      :=  le.v4_IDVerSSNCreditBureauCount 		 ;
    		SELF.IDVerSSNCreditBureauDelete 		      :=  le.v4_IDVerSSNCreditBureauDelete 	 ;
    		SELF.SourceRiskLevel 				      :=  le.v4_SourceRisklevel 			 ;
    		SELF.SourceWatchList 				      :=  le.v4_SourceWatchList 			 ;
    		SELF.SourceOrderActivity 			      :=  le.v4_SourceOrderActivity 		 ;
    		SELF.SourceOrderSourceCount 			      :=  le.v4_SourceOrderSourceCount 		 ;
    		SELF.SourceOrderAgeLastOrder 			      :=  le.v4_SourceOrderAgeLastOrder 		 ;
    		SELF.VariationRiskLevel 			      :=  le.v4_VariationRisklevel 		 ;
    		SELF.VariationIdentityCount 			      :=  le.v4_VariationIdentityCount 		 ;
    		SELF.VariationMSourcesSSNCount 			      :=  le.v4_VariationMSourcesSSNCount 		 ;
    		SELF.VariationMSourcesSSNUnrelCount 		      :=  le.v4_VariationMSourcesSSNUnrelCount  ;
    		SELF.VariationDOBCount 				      :=  le.v4_VariationDOBCount 			 ;
    		SELF.VariationDOBCountNew 			      :=  le.v4_VariationDOBCountNew 		 ;
    		SELF.SearchVelocityRiskLevel 			      :=  le.v4_SearchVelocityRisklevel 		 ;
    		SELF.SearchUnverifiedSSNCountYear 		      :=  le.v4_SearchUnverifiedSSNCountYear  ;
    		SELF.SearchUnverifiedAddrCountYear 		      :=  le.v4_SearchUnverifiedAddrCountYear  ;
    		SELF.SearchUnverifiedDOBCountYear 		      :=  le.v4_SearchUnverifiedDOBCountYear  ;
    		SELF.SearchUnverifiedPhoneCountYear 		      :=  le.v4_SearchUnverifiedPhoneCountYear  ;
    		SELF.AssocRiskLevel 				      :=  le.v4_AssocRisklevel 			 ;
    		SELF.AssocSuspicousIdentitiesCount 		      :=  le.v4_AssocSuspicousIdentitiesCount  ;
    		SELF.AssocCreditBureauOnlyCount 		      :=  le.v4_AssocCreditBureauOnlyCount 	 ;
    		SELF.AssocCreditBureauOnlyCountNew 		      :=  le.v4_AssocCreditBureauOnlyCountNew  ;
    		SELF.AssocCreditBureauOnlyCountMonth 		      :=  le.v4_AssocCreditBureauOnlyCountMonth ;
    		SELF.AssocHighRiskTopologyCount 		      :=  le.v4_AssocHighRiskTopologyCount 	 ;
    		SELF.ValidationRiskLevel 			      :=  le.v4_ValidationRisklevel 		 ;
    		SELF.CorrelationRiskLevel 			      :=  le.v4_CorrelationRisklevel 		 ;
    		SELF.DivRiskLevel 				      :=  le.v4_DivRisklevel 			 ;
    		SELF.DivSSNIdentityMSourceCount 		      :=  le.v4_DivSSNIdentityMSourceCount 	 ;
    		SELF.DivSSNIdentityMSourceUrelCount 		      :=  le.v4_DivSSNIdentityMSourceUrelCount  ;
    		SELF.DivSSNLNameCountNew 			      :=  le.v4_DivSSNLNameCountNew 		 ;
    		SELF.DivSSNAddrMSourceCount 			      :=  le.v4_DivSSNAddrMSourceCount 		 ;
    		SELF.DivAddrIdentityCount 			      :=  le.v4_DivAddrIdentityCount 		 ;
    		SELF.DivAddrIdentityCountNew 			      :=  le.v4_DivAddrIdentityCountNew 		 ;
    		SELF.DivAddrIdentityMSourceCount 		      :=  le.v4_DivAddrIdentityMSourceCount  ;
    		SELF.DivAddrSuspIdentityCountNew 		      :=  le.v4_DivAddrSuspIdentityCountNew  ;
    		SELF.DivAddrSSNCount 				      :=  le.v4_DivAddrSSNCount 			 ;
    		SELF.DivAddrSSNCountNew 			      :=  le.v4_DivAddrSSNCountNew 		 ;
    		SELF.DivAddrSSNMSourceCount 			      :=  le.v4_DivAddrSSNMSourceCount 		 ;
    		SELF.DivSearchAddrSuspIdentityCount 		      :=  le.v4_DivSearchAddrSuspIdentityCount  ;
    		SELF.SearchComponentRiskLevel 			      :=  le.v4_SearchComponentRisklevel 		 ;
    		SELF.SearchSSNSearchCount 			      :=  le.v4_SearchSSNSearchCount 		 ;
    		SELF.SearchAddrSearchCount 			      :=  le.v4_SearchAddrSearchCount 		 ;
    		SELF.SearchPhoneSearchCount 			      :=  le.v4_SearchPhoneSearchCount 		 ;
    		SELF.ComponentCharRiskLevel 			      :=  le.v4_ComponentCharRisklevel 		 ;
				
				#if(include_internal_extras)
			// self.DID := le.did; 
			  self := [];
		   #end;
	END;

	slim_attr := project( LeadIntegrity_attributes, slim_v4(left) );
	
	op_final := output(slim_attr,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

sequential(op_final);

EXPORT LIA_3_Batch_Dev192 := 'Success';