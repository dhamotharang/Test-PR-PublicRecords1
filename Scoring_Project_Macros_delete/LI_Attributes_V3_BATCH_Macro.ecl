EXPORT LI_Attributes_V3_BATCH_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing ;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


// Versions Available: 1, 3 and 4
version := 3;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;

// Boca Shell Version
bocaShellVersion := 3;  //version 3 is for LI attributes 3, 4 for Li attributes version 4

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;

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








f_all := DATASET(ut.foreign_prod + infile_name, prii_layout, CSV(QUOTE('"')));
f := IF(no_of_records = 0, f_all, CHOOSEN(f_all, no_of_records));
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
				RETRY(retry), TIMEOUT(timeout),
				PARALLEL(threads), onFail(myFail(LEFT)));

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

//added by Chad
ds_input := IF (no_of_records = 0, f, CHOOSEN (f , no_of_records));

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion3;
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
	self.IncludeVersion3 := true;
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

				
LeadIntegrity_attributes := SOAPCALL(soap_in, roxieIP,
				'Models.LeadIntegrity_Batch_Service', {soap_in}, 
				DATASET(LeadIntegrityoutput),
				PARALLEL(threads), onFail(myFail2(LEFT)));				

layout_slimmed := RECORD
		STRING20 seq;
		STRING30 AccountNumber;

		STRING4  AgeOldestRecord;
		STRING4  AgeNewestRecord;	
		STRING1  RecentUpdate;
		STRING2  SrcsConfirmIDAddrCount;
		STRING1  CreditBureauRecord;
		STRING2  InvalidSSN;
		STRING2  InvalidAddr;
		STRING2  InvalidPhone;
		STRING2  VerificationFailure;
		STRING2  SSNNotFound;
		STRING2  SSNFoundOther;
		STRING1  VerifiedName;
		STRING2  VerifiedSSN;
		STRING2  VerifiedPhone;
		STRING2  VerifiedPhoneFullName;
		STRING2  VerifiedPhoneLastName;
		STRING2  VerifiedAddress;
		STRING2  VerifiedDOB;
		STRING3  AgeRiskIndicator;
		STRING3  SubjectSSNCount;
		STRING3  SubjectAddrCount;
		STRING3  SubjectPhoneCount;
		STRING3  SubjectSSNRecentCount;
		STRING3  SubjectAddrRecentCount;
		STRING3  SubjectPhoneRecentCount;
		STRING3  SSNIdentitiesCount;
		STRING3  SSNAddrCount;
		STRING3  SSNIdentitiesRecentCount;
		STRING3  SSNAddrRecentCount;
		STRING3  InputAddrIdentitiesCount;
		STRING3  InputAddrSSNCount;
		STRING3  InputAddrPhoneCount;
		STRING3  InputAddrIdentitiesRecentCount;
		STRING3  InputAddrSSNRecentCount;
		STRING3  InputAddrPhoneRecentCount;
		STRING3  PhoneIdentitiesCount;
		STRING3  PhoneIdentitiesRecentCount;
		STRING2  PhoneOther;
		STRING3  SSNLastNameCount;
		STRING3  SubjectLastNameCount;
		STRING4  LastNameChangeAge;
		STRING3  LastNameChangeCount01;
		STRING3  LastNameChangeCount03;
		STRING3  LastNameChangeCount06;
		STRING3  LastNameChangeCount12;
		STRING3  LastNameChangeCount24;
		STRING3  LastNameChangeCount36;
		STRING3  LastNameChangeCount60;
		STRING3  SFDUAddrIdentitiesCount;
		STRING3  SFDUAddrSSNCount;
		STRING2  SSNDeceased;
		STRING8  SSNDateDeceased;
		STRING2  SSNIssued;
		STRING2  SSNRecent;
		STRING8  SSNLowIssueDate;
		STRING8  SSNHighIssueDate;
		STRING2  SSNIssueState;
		STRING2  SSNNonUS;
		STRING2  SSNIssuedPriorDOB;
		STRING2  SSN3Years;
		STRING2  SSNAfter5;
		STRING3  SSNProblems;
		STRING3  RelativesCount;
		STRING3  RelativesBankruptcyCount;
		STRING3  RelativesFelonyCount;
		STRING3  RelativesPropOwnedCount;
		STRING13 RelativesPropOwnedTaxTotal;
		STRING2  RelativesDistanceClosest;
		STRING4  InputAddrAgeOldestRecord;
		STRING4  InputAddrAgeNewestRecord;
		STRING3  InputAddrLenOfRes;
		STRING2  InputAddrDwellType;
		STRING2  InputAddrLandUseCode;
		STRING2  InputAddrApplicantOwned;
		STRING2  InputAddrFamilyOwned;
		STRING2  InputAddrOccupantOwned;
		STRING4  InputAddrAgeLastSale;
		STRING10 InputAddrLastSalesPrice;
		STRING2  InputAddrNotPrimaryRes;
		STRING2  InputAddrActivePhoneList;
		STRING10 InputAddrActivePhoneNumber;
		STRING10 InputAddrTaxValue;
		STRING4  InputAddrTaxYr;
		STRING10 InputAddrTaxMarketValue;
		STRING10 InputAddrAVMTax;
		STRING10 InputAddrAVMSalesPrice;
		STRING10 InputAddrAVMHedonic;
		STRING10 InputAddrAVMValue;
		STRING2  InputAddrAVMConfidence;
		STRING5  InputAddrCountyIndex;
		STRING5  InputAddrTractIndex;
		STRING5  InputAddrBlockIndex;
		STRING10 InputAddrMedianIncome;
		STRING10 InputAddrMedianValue;
		STRING3  InputAddrMurderIndex;
		STRING3  InputAddrCarTheftIndex;
		STRING3  InputAddrBurglaryIndex;
		STRING3  InputAddrCrimeIndex;
		STRING4  CurrAddrAgeOldestRecord;
		STRING4  CurrAddrAgeNewestRecord;
		STRING3  CurrAddrLenOfRes;
		STRING2  CurrAddrDwellType;
		STRING2  CurrAddrLandUseCode;
		STRING2  CurrAddrApplicantOwned;
		STRING2  CurrAddrFamilyOwned;
		STRING2  CurrAddrOccupantOwned;
		STRING4  CurrAddrAgeLastSale;
		STRING10 CurrAddrLastSalesPrice;
		STRING2  CurrAddrActivePhoneList;
		STRING10 CurrAddrActivePhoneNumber;
		STRING10 CurrAddrTaxValue;
		STRING4  CurrAddrTaxYr;
		STRING10 CurrAddrTaxMarketValue;
		STRING10 CurrAddrAVMTax;
		STRING10 CurrAddrAVMSalesPrice;
		STRING10 CurrAddrAVMHedonic;
		STRING10 CurrAddrAVMValue;
		STRING2  CurrAddrAVMConfidence;
		STRING5  CurrAddrCountyIndex;
		STRING5  CurrAddrTractIndex;
		STRING5  CurrAddrBlockIndex;
		STRING10 CurrAddrMedianIncome;
		STRING10 CurrAddrMedianValue;
		STRING3  CurrAddrMurderIndex;
		STRING3  CurrAddrCarTheftIndex;
		STRING3  CurrAddrBurglaryIndex;
		STRING3  CurrAddrCrimeIndex;
		STRING4  PrevAddrAgeOldestRecord;
		STRING4  PrevAddrAgeNewestRecord;
		STRING3  PrevAddrLenOfRes;
		STRING2  PrevAddrDwellType;
		STRING2  PrevAddrLandUseCode;
		STRING2  PrevAddrApplicantOwned;
		STRING2  PrevAddrFamilyOwned;
		STRING2  PrevAddrOccupantOwned;
		STRING4  PrevAddrAgeLastSale;
		STRING10 PrevAddrLastSalesPrice;
		STRING2  PrevAddrActivePhoneList;
		STRING10 PrevAddrActivePhoneNumber;
		STRING10 PrevAddrTaxValue;
		STRING4  PrevAddrTaxYr;
		STRING10 PrevAddrTaxMarketValue;
		STRING10 PrevAddrAVMTax;
		STRING10 PrevAddrAVMSalesPrice;
		STRING10 PrevAddrAVMHedonic;
		STRING10 PrevAddrAVMValue;
		STRING2  PrevAddrAVMConfidence;
		STRING5  PrevAddrCountyIndex;
		STRING5  PrevAddrTractIndex;
		STRING5  PrevAddrBlockIndex;
		STRING10 PrevAddrMedianIncome;
		STRING10 PrevAddrMedianValue;
		STRING3  PrevAddrMurderIndex;
		STRING3  PrevAddrCarTheftIndex;
		STRING3  PrevAddrBurglaryIndex;
		STRING3  PrevAddrCrimeIndex;
		STRING2  InputCurrAddrMatch;
		STRING4  InputCurrAddrDistance;
		STRING2  InputCurrAddrStateDiff;
		STRING10 InputCurrAddrTaxDiff;
		STRING11 InputCurrAddrIncomeDiff;
		STRING11 InputCurrAddrValueDiff;
		STRING4  InputCurrAddrCrimeDiff;
		STRING2  InputCurrEconTrajectory;
		STRING2  InputPrevAddrMatch;
		STRING4  CurrPrevAddrDistance;
		STRING2  CurrPrevAddrStateDiff;
		STRING10 CurrPrevAddrTaxDiff;
		STRING11 CurrPrevAddrIncomeDiff;
		STRING11 CurrPrevAddrValueDiff;
		STRING4  CurrPrevAddrCrimeDiff;
		STRING2  PrevCurrEconTrajectory;
		STRING1  EducationAttendedCollege;
		STRING2  EducationProgram2Yr;
		STRING2  EducationProgram4Yr;
		STRING2  EducationProgramGraduate;
		STRING2  EducationInstitutionPrivate;
		STRING2  EducationInstitutionRating;
		STRING2  EducationFieldofStudyType;
		STRING1  AddrStability;
		STRING2  StatusMostRecent;
		STRING2  StatusPrevious;
		STRING2  StatusNextPrevious;
		STRING3  AddrChangeCount01;
		STRING3  AddrChangeCount03;
		STRING3  AddrChangeCount06;
		STRING3  AddrChangeCount12;
		STRING3  AddrChangeCount24;
		STRING3  AddrChangeCount36;
		STRING3  AddrChangeCount60;
		STRING6  PredictedAnnualIncome;
		STRING3  PropOwnedCount;
		STRING13 PropOwnedTaxTotal;
		STRING3  PropOwnedHistoricalCount;
		STRING3  PropAgeOldestPurchase;
		STRING3  PropAgeNewestPurchase;
		STRING3  PropAgeNewestSale;
		STRING4  PropNewestSalePurchaseIndex;
		STRING3  PropPurchasedCount01;
		STRING3  PropPurchasedCount03;
		STRING3  PropPurchasedCount06;
		STRING3  PropPurchasedCount12;
		STRING3  PropPurchasedCount24;
		STRING3  PropPurchasedCount36;
		STRING3  PropPurchasedCount60;
		STRING3  PropSoldCount01;
		STRING3  PropSoldCount03;
		STRING3  PropSoldCount06;
		STRING3  PropSoldCount12;
		STRING3  PropSoldCount24;
		STRING3  PropSoldCount36;
		STRING3  PropSoldCount60;
		STRING3  WatercraftCount;
		STRING3  WatercraftCount01;
		STRING3  WatercraftCount03;
		STRING3  WatercraftCount06;
		STRING3  WatercraftCount12;
		STRING3  WatercraftCount24;
		STRING3  WatercraftCount36;
		STRING3  WatercraftCount60;
		STRING3  AircraftCount;
		STRING3  AircraftCount01;
		STRING3  AircraftCount03;
		STRING3  AircraftCount06;
		STRING3  AircraftCount12;
		STRING3  AircraftCount24;
		STRING3  AircraftCount36;
		STRING3  AircraftCount60;
		STRING1  WealthIndex;
		STRING3  SubPrimeSolicitedCount;
		STRING3  SubPrimeSolicitedCount01;
		STRING3  SubPrimeSolicitedCount03;
		STRING3  SubPrimeSolicitedCount06;
		STRING3  SubPrimeSolicitedCount12;
		STRING3  SubPrimeSolicitedCount24;
		STRING3  SubPrimeSolicitedCount36;
		STRING3  SubPrimeSolicitedCount60;
		STRING2  DerogSeverityIndex;
		STRING3  DerogCount;
		STRING4  DerogAge;
		STRING3  FelonyCount;
		STRING4  FelonyAge;
		STRING3  FelonyCount01;
		STRING3  FelonyCount03;
		STRING3  FelonyCount06;
		STRING3  FelonyCount12;
		STRING3  FelonyCount24;
		STRING3  FelonyCount36;
		STRING3  FelonyCount60;
		STRING3  ArrestCount;
		STRING4  ArrestAge;
		STRING3  ArrestCount01;
		STRING3  ArrestCount03;
		STRING3  ArrestCount06;
		STRING3  ArrestCount12;
		STRING3  ArrestCount24;
		STRING3  ArrestCount36;
		STRING3  ArrestCount60;
		STRING3  LienCount;
		STRING3  LienFiledCount;
		STRING4  LienFiledAge;
		STRING3  LienFiledCount01;
		STRING3  LienFiledCount03;
		STRING3  LienFiledCount06;
		STRING3  LienFiledCount12;
		STRING3  LienFiledCount24;
		STRING3  LienFiledCount36;
		STRING3  LienFiledCount60;
		STRING3  LienReleasedCount;
		STRING4  LienReleasedAge;
		STRING3  LienReleasedCount01;
		STRING3  LienReleasedCount03;
		STRING3  LienReleasedCount06;
		STRING3  LienReleasedCount12;
		STRING3  LienReleasedCount24;
		STRING3  LienReleasedCount36;
		STRING3  LienReleasedCount60;
		STRING3  BankruptcyCount;
		STRING4  BankruptcyAge;
		STRING2  BankruptcyType;
		STRING35 BankruptcyStatus;
		STRING3  BankruptcyCount01;
		STRING3  BankruptcyCount03;
		STRING3  BankruptcyCount06;
		STRING3  BankruptcyCount12;
		STRING3  BankruptcyCount24;
		STRING3  BankruptcyCount36;
		STRING3  BankruptcyCount60;
		STRING3  EvictionCount;
		STRING4  EvictionAge;
		STRING3  EvictionCount01;
		STRING3  EvictionCount03;
		STRING3  EvictionCount06;
		STRING3  EvictionCount12;
		STRING3  EvictionCount24;
		STRING3  EvictionCount36;
		STRING3  EvictionCount60;
		STRING3  NonDerogCount;
		STRING3  NonDerogCount01;
		STRING3  NonDerogCount03;
		STRING3  NonDerogCount06;
		STRING3  NonDerogCount12;
		STRING3  NonDerogCount24;
		STRING3  NonDerogCount36;
		STRING3  NonDerogCount60;
		STRING3  ProfLicCount;
		STRING4  ProfLicAge;
		STRING2  ProfLicTypeCategory;
		STRING8  ProfLicExpireDate;
		STRING3  ProfLicCount01;
		STRING3  ProfLicCount03;
		STRING3  ProfLicCount06;
		STRING3  ProfLicCount12;
		STRING3  ProfLicCount24;
		STRING3  ProfLicCount36;
		STRING3  ProfLicCount60;
		STRING3  ProfLicExpireCount01;
		STRING3  ProfLicExpireCount03;
		STRING3  ProfLicExpireCount06;
		STRING3  ProfLicExpireCount12;
		STRING3  ProfLicExpireCount24;
		STRING3  ProfLicExpireCount36;
		STRING3  ProfLicExpireCount60;
		STRING3  PRSearchCollectionCount;
		STRING3  PRSearchCollectionCount01;
		STRING3  PRSearchCollectionCount03;
		STRING3  PRSearchCollectionCount06;
		STRING3  PRSearchCollectionCount12;
		STRING3  PRSearchCollectionCount24;
		STRING3  PRSearchCollectionCount36;
		STRING3  PRSearchCollectionCount60;
		STRING3  PRSearchIDVFraudCount;
		STRING3  PRSearchIDVFraudCount01;
		STRING3  PRSearchIDVFraudCount03;
		STRING3  PRSearchIDVFraudCount06;
		STRING3  PRSearchIDVFraudCount12;
		STRING3  PRSearchIDVFraudCount24;
		STRING3  PRSearchIDVFraudCount36;
		STRING3  PRSearchIDVFraudCount60;
		STRING3  PRSearchOtherCount;
		STRING3  PRSearchOtherCount01;
		STRING3  PRSearchOtherCount03;
		STRING3  PRSearchOtherCount06;
		STRING3  PRSearchOtherCount12;
		STRING3  PRSearchOtherCount24;
		STRING3  PRSearchOtherCount36;
		STRING3  PRSearchOtherCount60;
		STRING2  InputPhoneStatus;
		STRING2  InputPhonePager;
		STRING2  InputPhoneMobile;
		STRING2  InputPhoneType;
		STRING2  InputPhoneServiceType;
		STRING2  InputAreaCodeChange;
		STRING4  PhoneEDAAgeOldestRecord;
		STRING4  PhoneEDAAgeNewestRecord;
		STRING4  PhoneOtherAgeOldestRecord;
		STRING4  PhoneOtherAgeNewestRecord;
		STRING2  InvalidPhoneZip;
		STRING4  InputPhoneAddrDist;
		STRING6  InputAddrSICCode;
		STRING2  InputAddrValidation;
		STRING5  InputAddrErrorCode;
		STRING2  InputAddrHighRisk;
		STRING2  InputPhoneHighRisk;
		STRING2  InputAddrPrison;
		STRING2  CurrAddrPrison;
		STRING2  PrevAddrPrison;
		STRING2  HistoricalAddrPrison;
		STRING2  InputZipPOBox;
		STRING2  InputZipCorpMil;
		STRING1  DoNotMail;
		#if(include_internal_extras)
			RiskProcessing.layout_internal_extras;
		#end
	END;

	layout_slimmed slim_v3( LeadIntegrity_attributes le ) := TRANSFORM
		SELF.AccountNumber                            := le.acctno;
		SELF.seq                                      := le.seq;


		SELF.AgeOldestRecord                         			    :=  le.version3__AgeOldestRecord                          ;
		SELF.AgeNewestRecord                         			    :=  le.version3__AgeNewestRecord                          ;
		SELF.RecentUpdate                            			    :=  le.RecentUpdate                             ;
		SELF.SrcsConfirmIDAddrCount                  			    :=  le.version3__SrcsConfirmIDAddrCount                   ;
		SELF.CreditBureauRecord                      			    :=  le.version3__CreditBureauRecord                       ;
		SELF.InvalidSSN                              			    :=  le.version3__InvalidSSN                               ;
		SELF.InvalidAddr                             			    :=  le.version3__InvalidAddr                              ;
		SELF.InvalidPhone                            			    :=  le.version3__InvalidPhone                             ;
		SELF.VerificationFailure                     			    :=  le.version3__VerificationFailure                      ;
		SELF.SSNNotFound                             			    :=  le.version3__SSNNotFound                              ;
		SELF.SSNFoundOther                           			    :=  le.version3__SSNFoundOther                            ;
		SELF.VerifiedName                            			    :=  le.version3__VerifiedName                             ;
		SELF.VerifiedSSN                             			    :=  le.version3__VerifiedSSN                              ;
		SELF.VerifiedPhone                           			    :=  le.version3__VerifiedPhone                            ;
		SELF.VerifiedPhoneFullName                   			    :=  le.version3__VerifiedPhoneFullName                    ;
		SELF.VerifiedPhoneLastName                   			    :=  le.version3__VerifiedPhoneLastName                    ;
		SELF.VerifiedAddress                         			    :=  le.version3__VerifiedAddress                          ;
		SELF.VerifiedDOB                             			    :=  le.version3__VerifiedDOB                              ;
		SELF.AgeRiskIndicator                        			    :=  le.AgeRiskIndicator                         ;
		SELF.SubjectSSNCount                         			    :=  le.version3__SubjectSSNCount                          ;
		SELF.SubjectAddrCount                        			    :=  le.version3__SubjectAddrCount                         ;
		SELF.SubjectPhoneCount                       			    :=  le.version3__SubjectPhoneCount                        ;
		SELF.SubjectSSNRecentCount                   			    :=  le.version3__SubjectSSNRecentCount                    ;
		SELF.SubjectAddrRecentCount                  			    :=  le.version3__SubjectAddrRecentCount                   ;
		SELF.SubjectPhoneRecentCount                 			    :=  le.version3__SubjectPhoneRecentCount                  ;
		SELF.SSNIdentitiesCount                      			    :=  le.version3__SSNIdentitiesCount                       ;
		SELF.SSNAddrCount                            			    :=  le.version3__SSNAddrCount                             ;
		SELF.SSNIdentitiesRecentCount                			    :=  le.version3__SSNIdentitiesRecentCount                 ;
		SELF.SSNAddrRecentCount                      			    :=  le.version3__SSNAddrRecentCount                       ;
		SELF.InputAddrIdentitiesCount                			    :=  le.version3__InputAddrIdentitiesCount                 ;
		SELF.InputAddrSSNCount                       			    :=  le.version3__InputAddrSSNCount                        ;
		SELF.InputAddrPhoneCount                     			    :=  le.version3__InputAddrPhoneCount                      ;
		SELF.InputAddrIdentitiesRecentCount          			    :=  le.version3__InputAddrIdentitiesRecentCount           ;
		SELF.InputAddrSSNRecentCount                 			    :=  le.version3__InputAddrSSNRecentCount                  ;
		SELF.InputAddrPhoneRecentCount               			    :=  le.version3__InputAddrPhoneRecentCount                ;
		SELF.PhoneIdentitiesCount                    			    :=  le.version3__PhoneIdentitiesCount                     ;
		SELF.PhoneIdentitiesRecentCount              			    :=  le.version3__PhoneIdentitiesRecentCount               ;
		SELF.PhoneOther                              			    :=  le.version3__PhoneOther                               ;
		SELF.SSNLastNameCount                        			    :=  le.version3__SSNLastNameCount                         ;
		SELF.SubjectLastNameCount                    			    :=  le.version3__SubjectLastNameCount                     ;
		SELF.LastNameChangeAge                       			    :=  '';//le.LastNameChangeAge                        ;
		SELF.LastNameChangeCount01                   			    :=  le.version3__LastNameChangeCount01                    ;
		SELF.LastNameChangeCount03                   			    :=  le.version3__LastNameChangeCount03                    ;
		SELF.LastNameChangeCount06                   			    :=  le.version3__LastNameChangeCount06                    ;
		SELF.LastNameChangeCount12                   			    :=  le.version3__LastNameChangeCount12                    ;
		SELF.LastNameChangeCount24                   			    :=  le.version3__LastNameChangeCount24                    ;
		SELF.LastNameChangeCount36                   			    :=  le.version3__LastNameChangeCount36                    ;
		SELF.LastNameChangeCount60                   			    :=  le.version3__LastNameChangeCount60                    ;
		SELF.SFDUAddrIdentitiesCount                 			    :=  le.version3__SFDUAddrIdentitiesCount                  ;
		SELF.SFDUAddrSSNCount                        			    :=  le.version3__SFDUAddrSSNCount                         ;
		SELF.SSNDeceased                             			    :=  le.version3__SSNDeceased                              ;
		SELF.SSNDateDeceased                         			    :=  ''; // le.SSNDateDeceased                          ;
		SELF.SSNIssued                               			    :=  le.version3__SSNIssued                                ;
		SELF.SSNRecent                               			    :=  le.version3__SSNRecent                                ;
		SELF.SSNLowIssueDate                         			    :=  '';//le.version3__SSNLowIssueDate                          ;
		SELF.SSNHighIssueDate                        			    :=  '';// le.version3__SSNHighIssueDate                         ;
		SELF.SSNIssueState                           			    :=  '';// le.version3__SSNIssueState                            ;
		SELF.SSNNonUS                                			    :=  le.version3__SSNNonUS                                 ;
		SELF.SSNIssuedPriorDOB                       			    :=  le.version3__SSNIssuedPriorDOB                        ;
		SELF.SSN3Years                               			    :=  le.version3__SSN3Years                                ;
		SELF.SSNAfter5                               			    :=  le.version3__SSNAfter5                                ;
		SELF.SSNProblems                             			    :=  '';// le.version3__SSNProblems                              ;
		SELF.RelativesCount                          			    :=  le.version3__RelativesCount                           ;
		SELF.RelativesBankruptcyCount                			    :=  le.version3__RelativesBankruptcyCount                 ;
		SELF.RelativesFelonyCount                    			    :=  le.version3__RelativesFelonyCount                     ;
		SELF.RelativesPropOwnedCount                 			    :=  le.version3__RelativesPropOwnedCount                  ;
		SELF.RelativesPropOwnedTaxTotal              			    :=  le.version3__RelativesPropOwnedTaxTotal               ;
		SELF.RelativesDistanceClosest                			    :=  le.version3__RelativesDistanceClosest                 ;
		SELF.InputAddrAgeOldestRecord                			    :=  '';// le.version3__InputAddrAgeOldestRecord                 ;
		SELF.InputAddrAgeNewestRecord                			    :=  '';//le.version3__InputAddrAgeNewestRecord                 ;
		SELF.InputAddrLenOfRes                       			    :=  '';//le.version3__InputAddrLenOfRes                        ;
		SELF.InputAddrDwellType                      			    :=  le.version3__InputAddrDwellType                       ;
		SELF.InputAddrLandUseCode                    			    :=  le.version3__InputAddrLandUseCode                     ;
		SELF.InputAddrApplicantOwned                 			    :=  le.version3__InputAddrApplicantOwned                  ;
		SELF.InputAddrFamilyOwned                    			    :=  le.version3__InputAddrFamilyOwned                     ;
		SELF.InputAddrOccupantOwned                  			    :=  le.version3__InputAddrOccupantOwned                   ;
		SELF.InputAddrAgeLastSale                    			    :=  le.version3__InputAddrAgeLastSale                     ;
		SELF.InputAddrLastSalesPrice                 			    :=  '';//START : added by Suman//le.version3__InputAddrLastSalesPrice                  ;
		SELF.InputAddrNotPrimaryRes                  			    :=  le.version3__InputAddrNotPrimaryRes                   ;
		SELF.InputAddrActivePhoneList                			    :=  le.version3__InputAddrActivePhoneList                 ;
		SELF.InputAddrActivePhoneNumber              			    :=  '';//le.version3__InputAddrActivePhoneNumber               ;
		SELF.InputAddrTaxValue                       			    :=  '';//le.version3__InputAddrTaxValue                        ;
		SELF.InputAddrTaxYr                          			    :=  '';//le.version3__InputAddrTaxYr                           ;
		SELF.InputAddrTaxMarketValue                 			    :=  '';//  le.version3__InputAddrTaxMarketValue                  ;
		SELF.InputAddrAVMTax                         			    :=  '';//  le.version3__InputAddrAVMTax                          ;
		SELF.InputAddrAVMSalesPrice                  			    :=  '';//  le.version3__InputAddrAVMSalesPrice                   ;
		SELF.InputAddrAVMHedonic                     			    :=  '';//  le.version3__InputAddrAVMHedonic                      ;
		SELF.InputAddrAVMValue                       			    :=  '';//  le.version3__InputAddrAVMValue                        ;
		SELF.InputAddrAVMConfidence                  			    :=  '';//  le.version3__InputAddrAVMConfidence                   ;
		SELF.InputAddrCountyIndex                    			    :=  '';//  le.version3__InputAddrCountyIndex                     ;
		SELF.InputAddrTractIndex                     			    :=  '';//  le.version3__InputAddrTractIndex                      ;
		SELF.InputAddrBlockIndex                     			    :=  '';//  le.version3__InputAddrBlockIndex                      ;
		SELF.InputAddrMedianIncome                   			    :=  '';//  le.version3__InputAddrMedianIncome                    ;
		SELF.InputAddrMedianValue                    			    :=  '';//  le.version3__InputAddrMedianValue                     ;
		SELF.InputAddrMurderIndex                    			    :=  '';//  le.version3__InputAddrMurderIndex                     ;
		SELF.InputAddrCarTheftIndex                  			    :=  '';//  le.version3__InputAddrCarTheftIndex                   ;
		SELF.InputAddrBurglaryIndex                  			    :=  '';//  le.version3__InputAddrBurglaryIndex                   ;
		SELF.InputAddrCrimeIndex                     			    :=  '';//  le.version3__InputAddrCrimeIndex                      ;
		SELF.CurrAddrAgeOldestRecord                 			    :=  '';//  le.version3__CurrAddrAgeOldestRecord                  ;
		SELF.CurrAddrAgeNewestRecord                 			    :=  '';//  le.version3__CurrAddrAgeNewestRecord                  ;
		SELF.CurrAddrLenOfRes                        			    :=  '';//  le.version3__CurrAddrLenOfRes                         ;
		SELF.CurrAddrDwellType                       			    :=  le.version3__CurrAddrDwellType                        ;
		SELF.CurrAddrLandUseCode                     			    :=   le.version3__CurrAddrLandUseCode                      ;
		SELF.CurrAddrApplicantOwned                  			    :=    le.version3__CurrAddrApplicantOwned                   ;
		SELF.CurrAddrFamilyOwned                     			    :=   le.version3__CurrAddrFamilyOwned                      ;
		SELF.CurrAddrOccupantOwned                   			    :=   le.version3__CurrAddrOccupantOwned                    ;
		SELF.CurrAddrAgeLastSale                     			    :=   le.version3__CurrAddrAgeLastSale                      ;
		SELF.CurrAddrLastSalesPrice                  			    :=  '';//  le.version3__CurrAddrLastSalesPrice                   ;
		SELF.CurrAddrActivePhoneList                 			    :=   le.version3__CurrAddrActivePhoneList                  ;
		SELF.CurrAddrActivePhoneNumber               			    :=  '';//  le.version3__CurrAddrActivePhoneNumber                ;
		SELF.CurrAddrTaxValue                        			    :=  '';//  le.version3__CurrAddrTaxValue                         ;
		SELF.CurrAddrTaxYr                           			    :=  '';//  le.version3__CurrAddrTaxYr                            ;
		SELF.CurrAddrTaxMarketValue                  			    :=  '';//  le.version3__CurrAddrTaxMarketValue                   ;
		SELF.CurrAddrAVMTax                          			    :=  '';//  le.version3__CurrAddrAVMTax                           ;
		SELF.CurrAddrAVMSalesPrice                   			    :=  '';//  le.version3__CurrAddrAVMSalesPrice                    ;
		SELF.CurrAddrAVMHedonic                      			    :=  '';//  le.version3__CurrAddrAVMHedonic                       ;
		SELF.CurrAddrAVMValue                        			    :=  '';//  le.version3__CurrAddrAVMValue                         ;
		SELF.CurrAddrAVMConfidence                   			    :=  '';//  le.version3__CurrAddrAVMConfidence                    ;
		SELF.CurrAddrCountyIndex                     			    :=  '';//  le.version3__CurrAddrCountyIndex                      ;
		SELF.CurrAddrTractIndex                      			    :=  '';//  le.version3__CurrAddrTractIndex                       ;
		SELF.CurrAddrBlockIndex                      			    :=  '';//  le.version3__CurrAddrBlockIndex                       ;
		SELF.CurrAddrMedianIncome                    			    :=  '';//  le.version3__CurrAddrMedianIncome                     ;
		SELF.CurrAddrMedianValue                     			    :=  '';//  le.version3__CurrAddrMedianValue                      ;
		SELF.CurrAddrMurderIndex                     			    :=  '';//  le.version3__CurrAddrMurderIndex                      ;
		SELF.CurrAddrCarTheftIndex                   			    :=  '';//  le.version3__CurrAddrCarTheftIndex                    ;
		SELF.CurrAddrBurglaryIndex                   			    :=  '';//  le.version3__CurrAddrBurglaryIndex                    ;
		SELF.CurrAddrCrimeIndex                      			    :=  '';//  le.version3__CurrAddrCrimeIndex                       ;
		SELF.PrevAddrAgeOldestRecord                 			    :=  '';//  le.version3__PrevAddrAgeOldestRecord                  ;
		SELF.PrevAddrAgeNewestRecord                 			    :=  '';//  le.version3__PrevAddrAgeNewestRecord                  ;
		SELF.PrevAddrLenOfRes                        			    :=  '';//le.version3__PrevAddrLenOfRes                         ;
		SELF.PrevAddrDwellType                       			    :=    le.version3__PrevAddrDwellType                        ;
		SELF.PrevAddrLandUseCode                     			    :=   le.version3__PrevAddrLandUseCode                      ;
		SELF.PrevAddrApplicantOwned                  			    :=   le.version3__PrevAddrApplicantOwned                   ;
		SELF.PrevAddrFamilyOwned                     			    :=  le.version3__PrevAddrFamilyOwned                      ;
		SELF.PrevAddrOccupantOwned                   			    :=   le.version3__PrevAddrOccupantOwned                    ;
		SELF.PrevAddrAgeLastSale                     			    :=    le.version3__PrevAddrAgeLastSale                      ;
		SELF.PrevAddrLastSalesPrice                  			    :=    '';//le.version3__PrevAddrLastSalesPrice                   ;
		SELF.PrevAddrActivePhoneList                 			    :=  le.version3__PrevAddrActivePhoneList                  ;
		SELF.PrevAddrActivePhoneNumber               			    :=  '';//  le.version3__PrevAddrActivePhoneNumber                ;
		SELF.PrevAddrTaxValue                        			    :=  '';//  le.version3__PrevAddrTaxValue                         ;
		SELF.PrevAddrTaxYr                           			    :=  '';//  le.version3__PrevAddrTaxYr                            ;
		SELF.PrevAddrTaxMarketValue                  			    :=  '';//  le.version3__PrevAddrTaxMarketValue                   ;
		SELF.PrevAddrAVMTax                          			    :=  '';//  le.version3__PrevAddrAVMTax                           ;
		SELF.PrevAddrAVMSalesPrice                   			    :=  '';//  le.version3__PrevAddrAVMSalesPrice                    ;
		SELF.PrevAddrAVMHedonic                      			    :=  '';//  le.version3__PrevAddrAVMHedonic                       ;
		SELF.PrevAddrAVMValue                        			    :=  '';//  le.version3__PrevAddrAVMValue                         ;
		SELF.PrevAddrAVMConfidence                   			    :=  '';//  le.version3__PrevAddrAVMConfidence                    ;
		SELF.PrevAddrCountyIndex                     			    :=  '';//  le.version3__PrevAddrCountyIndex                      ;
		SELF.PrevAddrTractIndex                      			    :=  '';//  le.version3__PrevAddrTractIndex                       ;
		SELF.PrevAddrBlockIndex                      			    :=  '';//  le.version3__PrevAddrBlockIndex                       ;
		SELF.PrevAddrMedianIncome                    			    :=  '';//  le.version3__PrevAddrMedianIncome                     ;
		SELF.PrevAddrMedianValue                     			    :=  '';//  le.version3__PrevAddrMedianValue                      ;
		SELF.PrevAddrMurderIndex                     			    :=  '';//  le.version3__PrevAddrMurderIndex                      ;
		SELF.PrevAddrCarTheftIndex                   			    :=  '';//  le.version3__PrevAddrCarTheftIndex                    ;
		SELF.PrevAddrBurglaryIndex                   			    :=  '';//  le.version3__PrevAddrBurglaryIndex                    ;
		SELF.PrevAddrCrimeIndex                      			    :=  '';//  le.version3__PrevAddrCrimeIndex                       ;
		SELF.InputCurrAddrMatch                      			    :=   le.version3__InputCurrAddrMatch                       ;
		SELF.InputCurrAddrDistance                   			    :=  '';//  le.version3__InputCurrAddrDistance                    ;
		SELF.InputCurrAddrStateDiff                  			    :=   le.version3__InputCurrAddrStateDiff                   ;
		SELF.InputCurrAddrTaxDiff                    			    :=  '';//  le.version3__InputCurrAddrTaxDiff                     ;
		SELF.InputCurrAddrIncomeDiff                 			    :=  '';//  le.version3__InputCurrAddrIncomeDiff                  ;
		SELF.InputCurrAddrValueDiff                  			    :=  '';//  le.version3__InputCurrAddrValueDiff                   ;
		SELF.InputCurrAddrCrimeDiff                  			    :=  '';//  le.version3__InputCurrAddrCrimeDiff                   ;
		SELF.InputCurrEconTrajectory                 			    :=  '';//  le.version3__InputCurrEconTrajectory                  ;
		SELF.InputPrevAddrMatch                      			    :=  le.version3__InputPrevAddrMatch                       ;
		SELF.CurrPrevAddrDistance                    			    :=   '';//le.version3__CurrPrevAddrDistance                     ;
		SELF.CurrPrevAddrStateDiff                   			    :=    le.version3__CurrPrevAddrStateDiff                    ;
		SELF.CurrPrevAddrTaxDiff                     			    :=  '';//  le.version3__CurrPrevAddrTaxDiff                      ;
		SELF.CurrPrevAddrIncomeDiff                  			    :=  '';//  le.version3__CurrPrevAddrIncomeDiff                   ;
		SELF.CurrPrevAddrValueDiff                   			    :=  '';//  le.version3__CurrPrevAddrValueDiff                    ;
		SELF.CurrPrevAddrCrimeDiff                   			    :=  '';//  le.version3__CurrPrevAddrCrimeDiff                    ;
		SELF.PrevCurrEconTrajectory                  			    :=  '';//  le.version3__PrevCurrEconTrajectory                   ;
		SELF.EducationAttendedCollege                			    :=  le.version3__EducationAttendedCollege                 ;
		SELF.EducationProgram2Yr                     			    :=   le.version3__EducationProgram2Yr                      ;
		SELF.EducationProgram4Yr                     			    :=   le.version3__EducationProgram4Yr                      ;
		SELF.EducationProgramGraduate                			    :=   le.version3__EducationProgramGraduate                 ;
		SELF.EducationInstitutionPrivate             			    :=   le.version3__EducationInstitutionPrivate              ;
		SELF.EducationInstitutionRating              			    :=  le.version3__EducationInstitutionRating               ;
		SELF.EducationFieldofStudyType               			    :=   le.version3__EducationFieldofStudyType                ;
		SELF.AddrStability                           			    :=  '';//  le.version3__AddrStability                            ;
		SELF.StatusMostRecent                        			    :=  le.version3__StatusMostRecent                         ;
		SELF.StatusPrevious                          			    :=   le.version3__StatusPrevious                           ;
		SELF.StatusNextPrevious                      			    :=    le.version3__StatusNextPrevious                       ;
		SELF.AddrChangeCount01                       			    :=     le.version3__AddrChangeCount01                        ;
		SELF.AddrChangeCount03                       			    :=     le.version3__AddrChangeCount03                        ;
		SELF.AddrChangeCount06                       			    :=     le.version3__AddrChangeCount06                        ;
		SELF.AddrChangeCount12                       			    :=     le.version3__AddrChangeCount12                        ;
		SELF.AddrChangeCount24                       			    :=     le.version3__AddrChangeCount24                        ;
		SELF.AddrChangeCount36                       			    :=     le.version3__AddrChangeCount36                        ;
		SELF.AddrChangeCount60                       			    :=     le.version3__AddrChangeCount60                        ;
		SELF.PredictedAnnualIncome                   			    :=   le.version3__PredictedAnnualIncome                    ;
		SELF.PropOwnedCount                          			    :=    le.version3__PropOwnedCount                           ;
		SELF.PropOwnedTaxTotal                       			    :=   '';//le.version3__PropOwnedTaxTotal                        ;
		SELF.PropOwnedHistoricalCount                			    :=    le.version3__PropOwnedHistoricalCount                 ;
		SELF.PropAgeOldestPurchase                   			    :=    le.version3__PropAgeOldestPurchase                    ;
		SELF.PropAgeNewestPurchase                   			    :=    le.version3__PropAgeNewestPurchase                    ;
		SELF.PropAgeNewestSale                       			    :=    le.version3__PropAgeNewestSale                        ;
		SELF.PropNewestSalePurchaseIndex             			    :=    le.version3__PropNewestSalePurchaseIndex              ;
		SELF.PropPurchasedCount01                    			    :=    le.version3__PropPurchasedCount01                     ;
		SELF.PropPurchasedCount03                    			    :=   le.version3__PropPurchasedCount03                     ;
		SELF.PropPurchasedCount06                    			    :=   le.version3__PropPurchasedCount06                     ;
		SELF.PropPurchasedCount12                    			    :=    le.version3__PropPurchasedCount12                     ;
		SELF.PropPurchasedCount24                    			    :=   le.version3__PropPurchasedCount24                     ;
		SELF.PropPurchasedCount36                    			    :=   le.version3__PropPurchasedCount36                     ;
		SELF.PropPurchasedCount60                    			    :=   le.version3__PropPurchasedCount60                     ;
		SELF.PropSoldCount01                         			    :=  le.version3__PropSoldCount01                          ;
		SELF.PropSoldCount03                         			    :=  le.version3__PropSoldCount03                          ;
		SELF.PropSoldCount06                         			    :=  le.version3__PropSoldCount06                          ;
		SELF.PropSoldCount12                         			    :=  le.version3__PropSoldCount12                          ;
		SELF.PropSoldCount24                         			    :=  le.version3__PropSoldCount24                          ;
		SELF.PropSoldCount36                         			    :=  le.version3__PropSoldCount36                          ;
		SELF.PropSoldCount60                         			    :=  le.version3__PropSoldCount60                          ;
		SELF.WatercraftCount                         			    :=  le.version3__WatercraftCount                          ;
		SELF.WatercraftCount01                       			    :=  le.version3__WatercraftCount01                        ;
		SELF.WatercraftCount03                       			    :=  le.version3__WatercraftCount03                        ;
		SELF.WatercraftCount06                       			    :=  le.version3__WatercraftCount06                        ;
		SELF.WatercraftCount12                       			    :=  le.version3__WatercraftCount12                        ;
		SELF.WatercraftCount24                       			    :=  le.version3__WatercraftCount24                        ;
		SELF.WatercraftCount36                       			    :=  le.version3__WatercraftCount36                        ;
		SELF.WatercraftCount60                       			    :=  le.version3__WatercraftCount60                        ;
		SELF.AircraftCount                           			    :=  le.version3__AircraftCount                            ;
		SELF.AircraftCount01                         			    :=  le.version3__AircraftCount01                          ;
		SELF.AircraftCount03                         			    :=  le.version3__AircraftCount03                          ;
		SELF.AircraftCount06                         			    :=  le.version3__AircraftCount06                          ;
		SELF.AircraftCount12                         			    :=  le.version3__AircraftCount12                          ;
		SELF.AircraftCount24                         			    :=  le.version3__AircraftCount24                          ;
		SELF.AircraftCount36                         			    :=  le.version3__AircraftCount36                          ;
		SELF.AircraftCount60                         			    :=  le.version3__AircraftCount60                          ;
		SELF.WealthIndex                             			    :=  '';//le.version3__WealthIndex                              ;
		SELF.SubPrimeSolicitedCount                  			    :=  le.version3__SubPrimeSolicitedCount                   ;
		SELF.SubPrimeSolicitedCount01                			    :=  le.version3__SubPrimeSolicitedCount01                 ;
		SELF.SubPrimeSolicitedCount03                			    :=  le.version3__SubPrimeSolicitedCount03                 ;
		SELF.SubPrimeSolicitedCount06                			    :=  le.version3__SubPrimeSolicitedCount06                 ;
		SELF.SubPrimeSolicitedCount12                			    :=  le.version3__SubPrimeSolicitedCount12                 ;
		SELF.SubPrimeSolicitedCount24                			    :=  le.version3__SubPrimeSolicitedCount24                 ;
		SELF.SubPrimeSolicitedCount36                			    :=  le.version3__SubPrimeSolicitedCount36                 ;
		SELF.SubPrimeSolicitedCount60                			    :=  le.version3__SubPrimeSolicitedCount60                 ;
		SELF.DerogSeverityIndex                      			    :=  le.version3__DerogSeverityIndex                       ;
		SELF.DerogCount                              			    :=  le.version3__DerogCount                               ;
		SELF.DerogAge                                			    :=  le.version3__DerogAge                                 ;
		SELF.FelonyCount                             			    :=  le.version3__FelonyCount                              ;
		SELF.FelonyAge                               			    :=  le.version3__FelonyAge                                ;
		SELF.FelonyCount01                           			    :=  le.version3__FelonyCount01                            ;
		SELF.FelonyCount03                           			    :=  le.version3__FelonyCount03                            ;
		SELF.FelonyCount06                           			    :=  le.version3__FelonyCount06                            ;
		SELF.FelonyCount12                           			    :=  le.version3__FelonyCount12                            ;
		SELF.FelonyCount24                           			    :=  le.version3__FelonyCount24                            ;
		SELF.FelonyCount36                           			    :=  le.version3__FelonyCount36                            ;
		SELF.FelonyCount60                           			    :=  le.version3__FelonyCount60                            ;
		SELF.ArrestCount                             			    :=  le.version3__ArrestCount                              ;
		SELF.ArrestAge                               			    :=  le.version3__ArrestAge                                ;
		SELF.ArrestCount01                           			    :=  le.version3__ArrestCount01                            ;
		SELF.ArrestCount03                           			    :=  le.version3__ArrestCount03                            ;
		SELF.ArrestCount06                           			    :=  le.version3__ArrestCount06                            ;
		SELF.ArrestCount12                           			    :=  le.version3__ArrestCount12                            ;
		SELF.ArrestCount24                           			    :=  le.version3__ArrestCount24                            ;
		SELF.ArrestCount36                           			    :=  le.version3__ArrestCount36                            ;
		SELF.ArrestCount60                           			    :=  le.version3__ArrestCount60                            ;
		SELF.LienCount                               			    :=  le.version3__LienCount                                ;
		SELF.LienFiledCount                          			    :=  le.version3__LienFiledCount                           ;
		SELF.LienFiledAge                            			    :=  le.version3__LienFiledAge                             ;
		SELF.LienFiledCount01                        			    :=  le.version3__LienFiledCount01                         ;
		SELF.LienFiledCount03                        			    :=  le.version3__LienFiledCount03                         ;
		SELF.LienFiledCount06                        			    :=  le.version3__LienFiledCount06                         ;
		SELF.LienFiledCount12                        			    :=  le.version3__LienFiledCount12                         ;
		SELF.LienFiledCount24                        			    :=  le.version3__LienFiledCount24                         ;
		SELF.LienFiledCount36                        			    :=  le.version3__LienFiledCount36                         ;
		SELF.LienFiledCount60                        			    :=  le.version3__LienFiledCount60                         ;
		SELF.LienReleasedCount                       			    :=  le.version3__LienReleasedCount                        ;
		SELF.LienReleasedAge                         			    :=  le.version3__LienReleasedAge                          ;
		SELF.LienReleasedCount01                     			    :=  le.version3__LienReleasedCount01                      ;
		SELF.LienReleasedCount03                     			    :=  le.version3__LienReleasedCount03                      ;
		SELF.LienReleasedCount06                     			    :=  le.version3__LienReleasedCount06                      ;
		SELF.LienReleasedCount12                     			    :=  le.version3__LienReleasedCount12                      ;
		SELF.LienReleasedCount24                     			    :=  le.version3__LienReleasedCount24                      ;
		SELF.LienReleasedCount36                     			    :=  le.version3__LienReleasedCount36                      ;
		SELF.LienReleasedCount60                     			    :=  le.version3__LienReleasedCount60                      ;
		SELF.BankruptcyCount                         			    :=  le.version3__BankruptcyCount                          ;
		SELF.BankruptcyAge                           			    :=  le.version3__BankruptcyAge                            ;
		SELF.BankruptcyType                          			    :=  le.version3__BankruptcyType                           ;
		SELF.BankruptcyStatus                        			    :=  '';//le.version3__BankruptcyStatus                         ;
		SELF.BankruptcyCount01                       			    :=  le.version3__BankruptcyCount01                        ;
		SELF.BankruptcyCount03                       			    :=  le.version3__BankruptcyCount03                        ;
		SELF.BankruptcyCount06                       			    :=  le.version3__BankruptcyCount06                        ;
		SELF.BankruptcyCount12                       			    :=  le.version3__BankruptcyCount12                        ;
		SELF.BankruptcyCount24                       			    :=  le.version3__BankruptcyCount24                        ;
		SELF.BankruptcyCount36                       			    :=  le.version3__BankruptcyCount36                        ;
		SELF.BankruptcyCount60                       			    :=  le.version3__BankruptcyCount60                        ;
		SELF.EvictionCount                           			    :=  le.version3__EvictionCount                            ;
		SELF.EvictionAge                             			    :=  le.version3__EvictionAge                              ;
		SELF.EvictionCount01                         			    :=  le.version3__EvictionCount01                          ;
		SELF.EvictionCount03                         			    :=  le.version3__EvictionCount03                          ;
		SELF.EvictionCount06                         			    :=  le.version3__EvictionCount06                          ;
		SELF.EvictionCount12                         			    :=  le.version3__EvictionCount12                          ;
		SELF.EvictionCount24                         			    :=  le.version3__EvictionCount24                          ;
		SELF.EvictionCount36                         			    :=  le.version3__EvictionCount36                          ;
		SELF.EvictionCount60                         			    :=  le.version3__EvictionCount60                          ;
		SELF.NonDerogCount                           			    :=  le.version3__NonDerogCount                            ;
		SELF.NonDerogCount01                         			    :=  le.version3__NonDerogCount01                          ;
		SELF.NonDerogCount03                         			    :=  le.version3__NonDerogCount03                          ;
		SELF.NonDerogCount06                         			    :=  le.version3__NonDerogCount06                          ;
		SELF.NonDerogCount12                         			    :=  le.version3__NonDerogCount12                          ;
		SELF.NonDerogCount24                         			    :=  le.version3__NonDerogCount24                          ;
		SELF.NonDerogCount36                         			    :=  le.version3__NonDerogCount36                          ;
		SELF.NonDerogCount60                         			    :=  le.version3__NonDerogCount60                          ;
		SELF.ProfLicCount                            			    :=  le.version3__ProfLicCount                             ;
		SELF.ProfLicAge                              			    :=  le.version3__ProfLicAge                               ;
		SELF.ProfLicTypeCategory                     			    :=  le.version3__ProfLicTypeCategory                      ;
		SELF.ProfLicExpireDate                       			    :=  '';//le.version3__ProfLicExpireDate                        ;
		SELF.ProfLicCount01                          			    :=  le.version3__ProfLicCount01                           ;
		SELF.ProfLicCount03                          			    :=  le.version3__ProfLicCount03                           ;
		SELF.ProfLicCount06                          			    :=  le.version3__ProfLicCount06                           ;
		SELF.ProfLicCount12                          			    :=  le.version3__ProfLicCount12                           ;
		SELF.ProfLicCount24                          			    :=  le.version3__ProfLicCount24                           ;
		SELF.ProfLicCount36                          			    :=  le.version3__ProfLicCount36                           ;
		SELF.ProfLicCount60                          			    :=  le.version3__ProfLicCount60                           ;
		SELF.ProfLicExpireCount01                    			    :=  le.version3__ProfLicExpireCount01                     ;
		SELF.ProfLicExpireCount03                    			    :=  le.version3__ProfLicExpireCount03                     ;
		SELF.ProfLicExpireCount06                    			    :=  le.version3__ProfLicExpireCount06                     ;
		SELF.ProfLicExpireCount12                    			    :=  le.version3__ProfLicExpireCount12                     ;
		SELF.ProfLicExpireCount24                    			    :=  le.version3__ProfLicExpireCount24                     ;
		SELF.ProfLicExpireCount36                    			    :=  le.version3__ProfLicExpireCount36                     ;
		SELF.ProfLicExpireCount60                    			    :=  le.version3__ProfLicExpireCount60                     ;
		SELF.PRSearchCollectionCount                 			    :=  le.version3__PRSearchCollectionCount                  ;
		SELF.PRSearchCollectionCount01               			    :=  le.version3__PRSearchCollectionCount01                ;
		SELF.PRSearchCollectionCount03               			    :=  le.version3__PRSearchCollectionCount03                ;
		SELF.PRSearchCollectionCount06               			    :=  le.version3__PRSearchCollectionCount06                ;
		SELF.PRSearchCollectionCount12               			    :=  le.version3__PRSearchCollectionCount12                ;
		SELF.PRSearchCollectionCount24               			    :=  le.version3__PRSearchCollectionCount24                ;
		SELF.PRSearchCollectionCount36               			    :=  le.version3__PRSearchCollectionCount36                ;
		SELF.PRSearchCollectionCount60               			    :=  le.version3__PRSearchCollectionCount60                ;
		SELF.PRSearchIDVFraudCount                   			    :=  le.version3__PRSearchIDVFraudCount                    ;
		SELF.PRSearchIDVFraudCount01                 			    :=  le.version3__PRSearchIDVFraudCount01                  ;
		SELF.PRSearchIDVFraudCount03                 			    :=  le.version3__PRSearchIDVFraudCount03                  ;
		SELF.PRSearchIDVFraudCount06                 			    :=  le.version3__PRSearchIDVFraudCount06                  ;
		SELF.PRSearchIDVFraudCount12                 			    :=  le.version3__PRSearchIDVFraudCount12                  ;
		SELF.PRSearchIDVFraudCount24                 			    :=  le.version3__PRSearchIDVFraudCount24                  ;
		SELF.PRSearchIDVFraudCount36                 			    :=  le.version3__PRSearchIDVFraudCount36                  ;
		SELF.PRSearchIDVFraudCount60                 			    :=  le.version3__PRSearchIDVFraudCount60                  ;
		SELF.PRSearchOtherCount                      			    :=  le.version3__PRSearchOtherCount                       ;
		SELF.PRSearchOtherCount01                    			    :=  le.version3__PRSearchOtherCount01                     ;
		SELF.PRSearchOtherCount03                    			    :=  le.version3__PRSearchOtherCount03                     ;
		SELF.PRSearchOtherCount06                    			    :=  le.version3__PRSearchOtherCount06                     ;
		SELF.PRSearchOtherCount12                    			    :=  le.version3__PRSearchOtherCount12                     ;
		SELF.PRSearchOtherCount24                    			    :=  le.version3__PRSearchOtherCount24                     ;
		SELF.PRSearchOtherCount36                    			    :=  le.version3__PRSearchOtherCount36                     ;
		SELF.PRSearchOtherCount60                   			    :=  le.version3__PRSearchOtherCount60                    ;
		SELF.InputPhoneStatus                       			    :=  le.version3__InputPhoneStatus                        ;
		SELF.InputPhonePager                        			    :=  le.version3__InputPhonePager                         ;
		SELF.InputPhoneMobile                       			    :=  le.version3__InputPhoneMobile                        ;
		SELF.InputPhoneType                         			    :=  le.version3__InputPhoneType                          ;
		SELF.InputPhoneServiceType                  			    := '';// le.version3__InputPhoneServiceType                   ;
		SELF.InputAreaCodeChange                    			    :=  le.version3__InputAreaCodeChange                     ;
		SELF.PhoneEDAAgeOldestRecord                			    :=  '';//le.version3__PhoneEDAAgeOldestRecord                 ;
		SELF.PhoneEDAAgeNewestRecord                			    :=  '';//le.version3__PhoneEDAAgeNewestRecord                 ;
		SELF.PhoneOtherAgeOldestRecord              			    :=  le.version3__PhoneOtherAgeOldestRecord               ;
		SELF.PhoneOtherAgeNewestRecord              			    :=  le.version3__PhoneOtherAgeNewestRecord               ;
		SELF.InvalidPhoneZip                        			    :=  le.version3__InvalidPhoneZip                         ;
		SELF.InputPhoneAddrDist                     			    :=  '';//le.version3__InputPhoneAddrDist                      ;
		SELF.InputAddrSICCode                       			    :=  '';//le.version3__InputAddrSICCode                        ;
		SELF.InputAddrValidation                    			    :=  le.version3__InputAddrValidation                     ;
		SELF.InputAddrErrorCode                     			    :=  '';//le.version3__InputAddrErrorCode                      ;
		SELF.InputAddrHighRisk                      			    :=  le.version3__InputAddrHighRisk                       ;
		SELF.InputPhoneHighRisk                     			    :=  le.version3__InputPhoneHighRisk                      ;
		SELF.InputAddrPrison                        			    :=  le.version3__InputAddrPrison                         ;
		SELF.CurrAddrPrison                         			    :=  le.version3__CurrAddrPrison                          ;
		SELF.PrevAddrPrison                         			    :=  le.version3__PrevAddrPrison                          ;
		SELF.HistoricalAddrPrison                   			    :=  le.version3__HistoricalAddrPrison                    ;
		SELF.InputZipPOBox                          			    :=  le.version3__InputZipPOBox                           ;
		SELF.InputZipCorpMil                        			    :=  le.version3__InputZipCorpMil                         ;
		SELF.DoNotMail                              			    :=  '';//le.version3__DoNotMail                               ;
 
 	#if(include_internal_extras)
			// self.DID := le.did; 
			  self := [];
		   #end;
	END;

	slim_attr := project( LeadIntegrity_attributes, slim_v3(left) );
	
	op_final := output(slim_attr,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_out := sequential(op_final);



return fin_out;

endmacro;