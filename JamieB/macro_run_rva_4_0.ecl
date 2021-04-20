export macro_run_rva_4_0(archive_date) := macro
#workunit('name','FCRA-Credit Attributes 4.0');
#option ('hthorMemoryLimit', 1000)
#option ('linkCountedRows', false) 

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;




unsigned1 eyeball := 0;
today := ut.GetDate[3..];
prii_layout := RECORD
     string  ACCOUNT;
     string  FirstName;
     string  MiddleName;
     string  LastName;
     string  StreetAddress;
     string  CITY;
     string  STATE;
     string  ZIP;
     string  HomePhone;
     string  SSN;
     string  DateOfBirth;
     string  WorkPhone;
     string  INCOME;
     string  DLNumber;
     string  DLState;
     string  BALANCE;
     string  CHARGEOFFD;
     string  FORMERName;
     string  EMAIL;
     string  EmployerName;
     integer HistoryDateYYYYMM;
		 unsigned did;
end;

infile_name := '~nmontpetit::in::ge_cap_100302_pii';
outfile_name := '~nmontpetit::out::rva_40_tracking_' ;

// f := dataset(infile_name, prii_layout, csv(quote('"')));
f := dataset(infile_name,prii_layout, csv(quote('"')));  // for testing a few records first
//OUTPUT (choosen(f, eyeball), NAMED ('input'));

Layout_Attributes_In := RECORD
	string name;
END;

layout_soap := record
	STRING  old_account_number;
	STRING  AccountNumber;
	STRING  FirstName;
	STRING  MiddleName;
	STRING  LastName;
	STRING  NameSuffix;
	STRING  StreetAddress;
	STRING  City;
	STRING  State;
	STRING  Zip;
	STRING  Country;
	STRING  SSN;
	STRING  DateOfBirth;
	STRING  Age;
	STRING  DLNumber;
	STRING  DLState;
	STRING  Email;
	STRING  IPAddress;
	STRING  HomePhone;
	STRING  WorkPhone;
	STRING  EmployerName;
	STRING  FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM := 999999;
	boolean Attributes := False;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	string DataRestrictionMask;
	string IntendedPurpose;
	unsigned6 did;
end;

fcraroxieIP := 'http://fcrathorvip.hpcc.risk.regn.net:9876';  
// fcraroxieIP := riskwise.shortcuts.dev64b; 
// fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieIP; 

layout_soap t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.Attributes := True;
	SELF.RequestedAttributeGroups := dataset([{'version4'}], layout_attributes_in);

	 // self.HistoryDateYYYYMM := le.historydateyyyymm;
	self.HistoryDateYYYYMM :=archive_date;
	
	self.gateways := dataset([{'neutralroxie', riskwise.shortcuts.prod_batch_neutral}], risk_indicators.Layout_Gateways_In);
	// self.gateways := dataset([{'neutralroxie', riskwise.shortcuts.dev64b}], risk_indicators.Layout_Gateways_In);
	// self.gateways := dataset([{'neutralroxie', riskwise.shortcuts.staging_neutral_roxieIP}], risk_indicators.Layout_Gateways_In);
	self.DataRestrictionMask := '100001000100'; // to restrict fares, experian and transunion 

	// self.IntendedPurpose := 'PRESCREENING';	// to run in prescreen mode
	self.IntendedPurpose := '';
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
//output(choosen(p_f, eyeball), named('RV_Input'));
//output(count(p_f), named('input_count'));

dist_dataset := distribute(p_f, random());

Layout_Attribute := RECORD, maxlength(100000)
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD, maxlength(100000)
	string name;
	string index;
	DATASET(Layout_Attribute) Attributes;
END;
layout_RVAttributesOut := RECORD, maxlength(100000)
	string30 accountnumber;
	DATASET(Layout_AttributeGroup) AttributeGroup;
END;
xlayout := RECORD, maxlength(100000)
	STRING30 AccountNumber;
	unsigned6 did;
	DATASET(Models.Layout_Model) models;
	Layout_RVAttributesOut AttributeGroups;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, fcraroxieIP,
										'Models.RiskView_Testing_Service', 
										{dist_dataset}, 
										DATASET(xlayout),
										PARALLEL(30), onFail(myFail(LEFT)));

//output(choosen(resu, eyeball), named('roxie_result'));

// models.layouts.Layout_Riskview_v4;  minus the v4_ on each field
layout_v4_attributes_flattened := record
			string3	  AgeOldestRecord	;		
			string3	  AgeNewestRecord	;		
			string1	  RecentUpdate	;		
			string3	  SrcsConfirmIDAddrCount	;		
			string2	  InvalidDL	;		
			string1	  VerificationFailure	;		
			string2	  SSNNotFound	;		
			string1	  VerifiedName	;		
			string2	  VerifiedSSN	;		
			string2	  VerifiedPhone	;		
			string2	  VerifiedAddress	;		
			string2	  VerifiedDOB	;		
			string3	  InferredMinimumAge	;		
			string3	  BestReportedAge	;		
			string3	  SubjectSSNCount	;		
			string3	  SubjectAddrCount	;		
			string3	  SubjectPhoneCount	;		
			string3	  SubjectSSNRecentCount	;		
			string3	  SubjectAddrRecentCount	;		
			string3	  SubjectPhoneRecentCount	;		
			string3	  SSNIdentitiesCount	;		
			string3	  SSNAddrCount	;		
			string3	  SSNIdentitiesRecentCount	;		
			string3	  SSNAddrRecentCount	;		
			string3	  InputAddrPhoneCount	;		
			string3	  InputAddrPhoneRecentCount	;		
			string3	  PhoneIdentitiesCount	;		
			string3	  PhoneIdentitiesRecentCount	;		
			string3	  SSNAgeDeceased	;	// was named SSNDateDeceased	in version3
			string2	  SSNRecent	;		
			string3	  SSNLowIssueAge	;	// was named SSNLowIssueDate	in version3
			string3	  SSNHighIssueAge	;	// was named SSNHighIssueDate	in version3
			string2	  SSNIssueState	;		
			string2	  SSNNonUS	;		
			string2	  SSN3Years	;		
			string2	  SSNAfter5 	;		
			string2	  SSNProblems	;	// new to 4.0	
			string3	  InputAddrAgeOldestRecord	;		
			string3	  InputAddrAgeNewestRecord	;		
			string2	  InputAddrHistoricalMatch	;	// new to 4.0	
			string3	  InputAddrLenOfRes 	;		
			string2	  InputAddrDwellType 	;		
			string2	  InputAddrDelivery	;	// new to 4.0	
			string2	  InputAddrApplicantOwned	;		
			string2	  InputAddrFamilyOwned	;		
			string2	  InputAddrOccupantOwned 	;		
			string3	  InputAddrAgeLastSale	;		
			string10  InputAddrLastSalesPrice	;		
			string2	  InputAddrMortgageType	;	// new to 4.0				
			string2	  InputAddrNotPrimaryRes 	;		
			string2	  InputAddrActivePhoneList 	;		
			string10  InputAddrTaxValue 	;		
			string4	  InputAddrTaxYr	;		
			string10  InputAddrTaxMarketValue	;		
			string10  InputAddrAVMValue	;		
			string10  InputAddrAVMValue12	;	// new to 4.0	
			string10  InputAddrAVMValue60	;	// new to 4.0	
			string5	  InputAddrCountyIndex	;		
			string5	  InputAddrTractIndex	;		
			string5	  InputAddrBlockIndex	;		
			string3	  CurrAddrAgeOldestRecord	;		
			string3	  CurrAddrAgeNewestRecord	;		
			string3	  CurrAddrLenOfRes 	;		
			string2	  CurrAddrDwellType 	;		
			string2	  CurrAddrApplicantOwned 	;		
			string2	  CurrAddrFamilyOwned 	;		
			string2	  CurrAddrOccupantOwned 	;		
			string3	  CurrAddrAgeLastSale	;		
			string10  CurrAddrLastSalesPrice	;		
			string2	  CurrAddrMortgageType	;	// new to 4.0	
			string2	  CurrAddrActivePhoneList 	;		
			string10  CurrAddrTaxValue 	;		
			string4	  CurrAddrTaxYr	;		
			string10  CurrAddrTaxMarketValue	;		
			string10  CurrAddrAVMValue	;		
			string10  CurrAddrAVMValue12	;	// new to 4.0	
			string10  CurrAddrAVMValue60	;	// new to 4.0	
			string5	  CurrAddrCountyIndex	;		
			string5	  CurrAddrTractIndex	;		
			string5	  CurrAddrBlockIndex	;		
			string3	  PrevAddrAgeOldestRecord	;		
			string3	  PrevAddrAgeNewestRecord	;		
			string3	  PrevAddrLenOfRes 	;		
			string2	  PrevAddrDwellType 	;		
			string2	  PrevAddrApplicantOwned 	;		
			string2	  PrevAddrFamilyOwned 	;		
			string2	  PrevAddrOccupantOwned	;		
			string3	  PrevAddrAgeLastSale	;		
			string10  PrevAddrLastSalesPrice	;		
			string10  PrevAddrTaxValue	;		
			string4	  PrevAddrTaxYr	;		
			string10  PrevAddrTaxMarketValue	;		
			string10  PrevAddrAVMValue	;		
			string5	  PrevAddrCountyIndex	;		
			string5	  PrevAddrTractIndex	;		
			string5	  PrevAddrBlockIndex	;		
			string4	  AddrMostRecentDistance	;	// new to 4.0	
			string2	  AddrMostRecentStateDiff	;	// new to 4.0	
			string11  AddrMostRecentTaxDiff	;	// new to 4.0	
			string3	  AddrMostRecentMoveAge	;	// new to 4.0				
			string2	  AddrRecentEconTrajectory	;	// new to 4.0	
			string2	  AddrRecentEconTrajectoryIndex	;	// new to 4.0	
			string1	  EducationAttendedCollege	;		
			string2	  EducationProgram2Yr	;		
			string2	  EducationProgram4Yr	;		
			string2	  EducationProgramGraduate	;		
			string2	  EducationInstitutionPrivate	;		
			string2   EducationFieldofStudyType	;	// new to 4.0	
			string2   EducationInstitutionRating	;		
			string1	  AddrStability 	;	// is this the new addrstabilityv2 model or old model?	
			string2	  StatusMostRecent 	;		
			string2	  StatusPrevious 	;		
			string2	  StatusNextPrevious	;		
			string3	  AddrChangeCount01	;		
			string3	  AddrChangeCount03	;		
			string3	  AddrChangeCount06	;		
			string3	  AddrChangeCount12	;		
			string3	  AddrChangeCount24 	;		
			string3	  AddrChangeCount60 	;		
			string10  EstimatedAnnualIncome	;	// was named PredictedAnnualIncome	in version3
			string1	  PropertyOwner	;	// new to 4.0	
			string3	  PropOwnedCount	;		
			string10  PropOwnedTaxTotal	;		
			string3	  PropOwnedHistoricalCount	;		
			string3	  PropAgeOldestPurchase	;		
			string3	  PropAgeNewestPurchase	;		
			string3	  PropAgeNewestSale	;		
			string10  PropNewestSalePrice	;		
			string5	  PropNewestSalePurchaseIndex	;		
			string3	  PropPurchasedCount01	;		
			string3	  PropPurchasedCount03	;		
			string3	  PropPurchasedCount06	;		
			string3	  PropPurchasedCount12	;		
			string3	  PropPurchasedCount24	;		
			string3	  PropPurchasedCount60	;		
			string3	  PropSoldCount01	;		
			string3	  PropSoldCount03	;		
			string3	  PropSoldCount06	;		
			string3	  PropSoldCount12	;		
			string3	  PropSoldCount24 	;		
			string3	  PropSoldCount60 	;		
			string1	  AssetOwner	;	// new to 4.0	
			string1	  WatercraftOwner	;	// new to 4.0	
			string3	  WatercraftCount	;		
			string3	  WatercraftCount01	;		
			string3	  WatercraftCount03	;		
			string3	  WatercraftCount06	;		
			string3	  WatercraftCount12 	;		
			string3	  WatercraftCount24	;		
			string3	  WatercraftCount60 	;		
			string1	  AircraftOwner	;	// new to 4.0	
			string3	  AircraftCount	;		
			string3	  AircraftCount01	;		
			string3	  AircraftCount03	;		
			string3	  AircraftCount06	;		
			string3	  AircraftCount12 	;		
			string3	  AircraftCount24	;		
			string3	  AircraftCount60 	;		
			string2	  WealthIndex 	;		
			string2	  BusinessActiveAssociation	;	// new to 4.0	
			string2	  BusinessInactiveAssociation	;	// new to 4.0	
			string3	  BusinessAssociationAge	;	// new to 4.0	
			string100	BusinessTitle	;	// new to 4.0	
			string1	  DerogSeverityIndex	;	// new to 4.0	
			string3	  DerogCount	;		
			string3	  DerogRecentCount	;	// new to 4.0	
			string3	  DerogAge	;		
			string3	  FelonyCount	;		
			string3	  FelonyAge	;		
			string3	  FelonyCount01	;		
			string3	  FelonyCount03	;		
			string3	  FelonyCount06	;		
			string3	  FelonyCount12	;		
			string3	  FelonyCount24	;		
			string3	  FelonyCount60	;		
			string3	  LienCount	;		
			string3	  LienFiledCount	;		
			string3	  LienFiledAge	;		
			string3	  LienFiledCount01	;		
			string3	  LienFiledCount03	;		
			string3	  LienFiledCount06	;		
			string3	  LienFiledCount12	;		
			string3	  LienFiledCount24	;		
			string3	  LienFiledCount60	;		
			string3	  LienReleasedCount	;		
			string3	  LienReleasedAge	;		
			string3	  LienReleasedCount01	;		
			string3	  LienReleasedCount03	;		
			string3	  LienReleasedCount06	;		
			string3	  LienReleasedCount12	;		
			string3	  LienReleasedCount24	;		
			string3	  LienReleasedCount60	;		
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
			string3	  LienFederalTaxFiledCount	;		
			string3	  LienTaxOtherFiledCount	;		
			string3	  LienForeclosureFiledCount	;		
			string3	  LienLandlordTenantFiledCount	;		
			string3	  LienJudgmentFiledCount	;		
			string3	  LienSmallClaimsFiledCount	;		
			string3	  LienOtherFiledCount	;		
			string3	  LienFederalTaxReleasedCount	;		
			string3	  LienTaxOtherReleasedCount	;		
			string3	  LienForeclosureReleasedCount	;		
			string3	  LienLandlordTenantReleasedCount	;		
			string3	  LienJudgmentReleasedCount	;		
			string3	  LienSmallClaimsReleasedCount	;		
			string3	  LienOtherReleasedCount	;		
			string3	  BankruptcyCount	;		
			string3	  BankruptcyAge	;		
			string3	  BankruptcyType	;		
			string35	BankruptcyStatus	;		
			string3	  BankruptcyCount01	;		
			string3	  BankruptcyCount03	;		
			string3	  BankruptcyCount06	;		
			string3	  BankruptcyCount12	;		
			string3	  BankruptcyCount24	;		
			string3	  BankruptcyCount60	;		
			string3	  EvictionCount	;		
			string3	  EvictionAge	;		
			string3	  EvictionCount01	;		
			string3	  EvictionCount03	;		
			string3	  EvictionCount06	;		
			string3	  EvictionCount12 	;		
			string3	  EvictionCount24 	;		
			string3	  EvictionCount60 	;		
			string2	  RecentActivityIndex	;	// new to 4.0	
			string3	  NonDerogCount	;		
			string3	  NonDerogCount01	;		
			string3	  NonDerogCount03	;		
			string3	  NonDerogCount06	;		
			string3	  NonDerogCount12	;		
			string3	  NonDerogCount24	;		
			string3	  NonDerogCount60	;		
			string1	  VoterRegistrationRecord	;	// new to 4.0	
			string3	  ProfLicCount	;		
			string3	  ProfLicAge	;		
			string60	ProfLicType	;		
			string2	  ProfLicTypeCategory	;		
			string2	  ProfLicExpired	;	// was named ProfLicExpireDate	in version3, changed to a boolean
			string3	  ProfLicCount01	;		
			string3	  ProfLicCount03	;		
			string3	  ProfLicCount06	;		
			string3	  ProfLicCount12	;		
			string3	  ProfLicCount24	;		
			string3	  ProfLicCount60	;		
			string1	  InquiryCollectionsRecent	;	// new to 4.0	
			string1	  InquiryPersonalFinanceRecent	;	// new to 4.0	
			string1	  InquiryOtherRecent	;	// new to 4.0	
			string1	  HighRiskCreditActivity	;	// new to 4.0	
			string3	  SubPrimeOfferRequestCount	;	// was named SubPrimeSolicitedCount	in version3
			string3	  SubPrimeOfferRequestCount01	;	// was named SubPrimeSolicitedCount01	in version3
			string3	  SubPrimeOfferRequestCount03	;	// was named SubprimeSolicitedCount03	in version3
			string3	  SubPrimeOfferRequestCount06	;	// was named SubprimeSolicitedCount06	in version3
			string3	  SubPrimeOfferRequestCount12	;	// was named SubPrimeSolicitedCount12	in version3
			string3	  SubPrimeOfferRequestCount24	;	// was named SubPrimeSolicitedCount24	in version3
			string3	  SubPrimeOfferRequestCount60	;	// was named SubPrimeSolicitedCount60	in version3
			string2	  InputPhoneMobile 	;		
			string3	  PhoneEDAAgeOldestRecord	;		
			string3	  PhoneEDAAgeNewestRecord	;		
			string3	  PhoneOtherAgeOldestRecord	;		
			string3	  PhoneOtherAgeNewestRecord	;		
			string2	  InputPhoneHighRisk	;		
			string2	  InputPhoneProblems	;	// new to 4.0	
			string2	  EmailAddress	;	// new to 4.0	
			string2	  InputAddrHighRisk	;			
			string2	  CurrAddrCorrectional	;	// new to 4.0	
			string2	  PrevAddrCorrectional	;	// new to 4.0	
			string2	  HistoricalAddrCorrectional	;	// new to 4.0	
			string2	  InputAddrProblems	;	// new to 4.0	
			string1	  SecurityFreeze	;		
			string1	  SecurityAlert	;		
			string1	  IDTheftFlag	;		
			string1	  ConsumerStatement	;	// new to 4.0	
			string2	  PrescreenOptOut	;			
end;
rv_attributes_v4 := RECORD
	//unsigned seq;
	string30 AccountNumber;
	layout_v4_attributes_flattened;		
	#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	#else
		string6 historydate;
	#end
	string200 errorcode;
END;
	
rv_attributes_v4 flatten_results(resu L, p_f R) := transform
	//self.seq := (unsigned)l.accountnumber;
	self.AccountNumber := r.old_account_number;
	#if(include_internal_extras)
		self.DID 														:= l.did; 
		self.historydate 										:= (string)r.HistoryDateYYYYMM;
		self.FNamePop 											:= r.firstname<>'';
		self.LNamePop 											:= r.lastname<>'';
		self.AddrPop 												:= r.streetaddress<>'';
		self.SSNLength 											:= (string)(length(trim(r.ssn))) ;
		self.DOBPop 												:= r.dateofbirth<>'';
		self.EmailPop 											:= r.email<>'';
		self.IPAddrPop 											:= r.ipaddress<>'';
		self.HPhnPop 												:= r.homephone<>'';
	#else
		self.historydate 										:= (string)r.HistoryDateYYYYMM;
	#end;
	self.errorcode 												:= l.errorcode;
		
	self.AgeOldestRecord									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AgeOldestRecord')[1].value;
	self.AgeNewestRecord									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AgeNewestRecord')[1].value;
	self.RecentUpdate											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='RecentUpdate')[1].value;
	self.SrcsConfirmIDAddrCount						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SrcsConfirmIDAddrCount')[1].value;
	self.InvalidDL												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InvalidDL')[1].value;
	self.VerificationFailure							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerificationFailure')[1].value;
	self.SSNNotFound											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNNotFound')[1].value;
	self.VerifiedName											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedName')[1].value;
	self.VerifiedSSN											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedSSN')[1].value;
	self.VerifiedPhone										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedPhone')[1].value;
	self.VerifiedAddress									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedAddress')[1].value;
	self.VerifiedDOB											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VerifiedDOB')[1].value;
	self.InferredMinimumAge								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InferredMinimumAge')[1].value;
	self.BestReportedAge									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BestReportedAge')[1].value;
	self.SubjectSSNCount									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectSSNCount')[1].value;
	self.SubjectAddrCount									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectAddrCount')[1].value;
	self.SubjectPhoneCount								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectPhoneCount')[1].value;
	self.SubjectSSNRecentCount						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectSSNRecentCount')[1].value;
	self.SubjectAddrRecentCount						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectAddrRecentCount')[1].value;
	self.SubjectPhoneRecentCount					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubjectPhoneRecentCount')[1].value;
	self.SSNIdentitiesCount								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNIdentitiesCount')[1].value;
	self.SSNAddrCount											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAddrCount')[1].value;
	self.SSNIdentitiesRecentCount					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNIdentitiesRecentCount')[1].value;
	self.SSNAddrRecentCount								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAddrRecentCount')[1].value;
	self.InputAddrPhoneCount							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrPhoneCount')[1].value;
	self.InputAddrPhoneRecentCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrPhoneRecentCount')[1].value;
	self.PhoneIdentitiesCount							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneIdentitiesCount')[1].value;
	self.PhoneIdentitiesRecentCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneIdentitiesRecentCount')[1].value;
	self.SSNAgeDeceased										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAgeDeceased')[1].value;
	self.SSNRecent												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNRecent')[1].value;
	self.SSNLowIssueAge										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNLowIssueAge')[1].value;
	self.SSNHighIssueAge									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNHighIssueAge')[1].value;
	self.SSNIssueState										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNIssueState')[1].value;
	self.SSNNonUS													:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNNonUS')[1].value;
	self.SSN3Years												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSN3Years')[1].value;
	self.SSNAfter5 												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNAfter5')[1].value;
	self.SSNProblems											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SSNProblems')[1].value;
	self.InputAddrAgeOldestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAgeOldestRecord')[1].value;
	self.InputAddrAgeNewestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAgeNewestRecord')[1].value;
	self.InputAddrHistoricalMatch					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrHistoricalMatch')[1].value;
	self.InputAddrLenOfRes 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrLenOfRes')[1].value;
	self.InputAddrDwellType 							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrDwellType')[1].value;
	self.InputAddrDelivery								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrDelivery')[1].value;
	self.InputAddrApplicantOwned					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrApplicantOwned')[1].value;
	self.InputAddrFamilyOwned							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrFamilyOwned')[1].value;
	self.InputAddrOccupantOwned 					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrOccupantOwned')[1].value;
	self.InputAddrAgeLastSale							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAgeLastSale')[1].value;
	self.InputAddrLastSalesPrice					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrLastSalesPrice')[1].value;
	self.InputAddrMortgageType						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrMortgageType')[1].value;
	self.InputAddrNotPrimaryRes 					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrNotPrimaryRes')[1].value;
	self.InputAddrActivePhoneList 				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrActivePhoneList')[1].value;
	self.InputAddrTaxValue 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTaxValue')[1].value;
	self.InputAddrTaxYr										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTaxYr')[1].value;
	self.InputAddrTaxMarketValue					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTaxMarketValue')[1].value;
	self.InputAddrAVMValue								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAVMValue')[1].value;
	self.InputAddrAVMValue12							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAVMValue12')[1].value;
	self.InputAddrAVMValue60							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrAVMValue60')[1].value;
	self.InputAddrCountyIndex							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrCountyIndex')[1].value;
	self.InputAddrTractIndex							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrTractIndex')[1].value;
	self.InputAddrBlockIndex							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrBlockIndex')[1].value;
	self.CurrAddrAgeOldestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAgeOldestRecord')[1].value;
	self.CurrAddrAgeNewestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAgeNewestRecord')[1].value;
	self.CurrAddrLenOfRes 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrLenOfRes')[1].value;
	self.CurrAddrDwellType 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrDwellType')[1].value;
	self.CurrAddrApplicantOwned 					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrApplicantOwned')[1].value;
	self.CurrAddrFamilyOwned 							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrFamilyOwned')[1].value;
	self.CurrAddrOccupantOwned 						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrOccupantOwned')[1].value;
	self.CurrAddrAgeLastSale							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAgeLastSale')[1].value;
	self.CurrAddrLastSalesPrice						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrLastSalesPrice')[1].value;
	self.CurrAddrMortgageType							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrMortgageType')[1].value;
	self.CurrAddrActivePhoneList 					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrActivePhoneList')[1].value;
	self.CurrAddrTaxValue 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTaxValue')[1].value;
	self.CurrAddrTaxYr										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTaxYr')[1].value;
	self.CurrAddrTaxMarketValue						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTaxMarketValue')[1].value;
	self.CurrAddrAVMValue									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAVMValue')[1].value;
	self.CurrAddrAVMValue12								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAVMValue12')[1].value;
	self.CurrAddrAVMValue60								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrAVMValue60')[1].value;
	self.CurrAddrCountyIndex							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrCountyIndex')[1].value;
	self.CurrAddrTractIndex								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrTractIndex')[1].value;
	self.CurrAddrBlockIndex								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrBlockIndex')[1].value;
	self.PrevAddrAgeOldestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAgeOldestRecord')[1].value;
	self.PrevAddrAgeNewestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAgeNewestRecord')[1].value;
	self.PrevAddrLenOfRes 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrLenOfRes')[1].value;
	self.PrevAddrDwellType 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrDwellType')[1].value;
	self.PrevAddrApplicantOwned 					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrApplicantOwned')[1].value;
	self.PrevAddrFamilyOwned 							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrFamilyOwned')[1].value;
	self.PrevAddrOccupantOwned						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrOccupantOwned')[1].value;
	self.PrevAddrAgeLastSale							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAgeLastSale')[1].value;
	self.PrevAddrLastSalesPrice						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrLastSalesPrice')[1].value;
	self.PrevAddrTaxValue									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTaxValue')[1].value;
	self.PrevAddrTaxYr										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTaxYr')[1].value;
	self.PrevAddrTaxMarketValue						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTaxMarketValue')[1].value;
	self.PrevAddrAVMValue									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrAVMValue')[1].value;
	self.PrevAddrCountyIndex							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrCountyIndex')[1].value;
	self.PrevAddrTractIndex								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrTractIndex')[1].value;
	self.PrevAddrBlockIndex								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrBlockIndex')[1].value;
	self.AddrMostRecentDistance						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentDistance')[1].value;
	self.AddrMostRecentStateDiff					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentStateDiff')[1].value;
	self.AddrMostRecentTaxDiff						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentTaxDiff')[1].value;
	self.AddrMostRecentMoveAge						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrMostRecentMoveAge')[1].value;
	self.AddrRecentEconTrajectory					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrRecentEconTrajectory')[1].value;
	self.AddrRecentEconTrajectoryIndex		:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrRecentEconTrajectoryIndex')[1].value;
	self.EducationAttendedCollege					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationAttendedCollege')[1].value;
	self.EducationProgram2Yr							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationProgram2Yr')[1].value;
	self.EducationProgram4Yr							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationProgram4Yr')[1].value;
	self.EducationProgramGraduate					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationProgramGraduate')[1].value;
	self.EducationInstitutionPrivate			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationInstitutionPrivate')[1].value;
	self.EducationFieldofStudyType				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationFieldofStudyType')[1].value;
	self.EducationInstitutionRating				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EducationInstitutionRating')[1].value;
	self.AddrStability 										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrStability')[1].value;
	self.StatusMostRecent 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='StatusMostRecent')[1].value;
	self.StatusPrevious 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='StatusPrevious')[1].value;
	self.StatusNextPrevious								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='StatusNextPrevious')[1].value;
	self.AddrChangeCount01								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount01')[1].value;
	self.AddrChangeCount03								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount03')[1].value;
	self.AddrChangeCount06								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount06')[1].value;
	self.AddrChangeCount12								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount12')[1].value;
	self.AddrChangeCount24 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount24')[1].value;
	self.AddrChangeCount60 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AddrChangeCount60')[1].value;
	self.EstimatedAnnualIncome						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EstimatedAnnualIncome')[1].value;
	self.PropertyOwner										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropertyOwner')[1].value;
	self.PropOwnedCount										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropOwnedCount')[1].value;
	self.PropOwnedTaxTotal								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropOwnedTaxTotal')[1].value;
	self.PropOwnedHistoricalCount					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropOwnedHistoricalCount')[1].value;
	self.PropAgeOldestPurchase						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropAgeOldestPurchase')[1].value;
	self.PropAgeNewestPurchase						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropAgeNewestPurchase')[1].value;
	self.PropAgeNewestSale								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropAgeNewestSale')[1].value;
	self.PropNewestSalePrice							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropNewestSalePrice')[1].value;
	self.PropNewestSalePurchaseIndex			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropNewestSalePurchaseIndex')[1].value;
	self.PropPurchasedCount01							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount01')[1].value;
	self.PropPurchasedCount03							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount03')[1].value;
	self.PropPurchasedCount06							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount06')[1].value;
	self.PropPurchasedCount12							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount12')[1].value;
	self.PropPurchasedCount24							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount24')[1].value;
	self.PropPurchasedCount60							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropPurchasedCount60')[1].value;
	self.PropSoldCount01									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount01')[1].value;
	self.PropSoldCount03									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount03')[1].value;
	self.PropSoldCount06									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount06')[1].value;
	self.PropSoldCount12									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount12')[1].value;
	self.PropSoldCount24 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount24')[1].value;
	self.PropSoldCount60 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PropSoldCount60')[1].value;
	self.AssetOwner												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AssetOwner')[1].value;
	self.WatercraftOwner									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftOwner')[1].value;
	self.WatercraftCount									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount')[1].value;
	self.WatercraftCount01								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount01')[1].value;
	self.WatercraftCount03								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount03')[1].value;
	self.WatercraftCount06								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount06')[1].value;
	self.WatercraftCount12 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount12')[1].value;
	self.WatercraftCount24								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount24')[1].value;
	self.WatercraftCount60 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WatercraftCount60')[1].value;
	self.AircraftOwner										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftOwner')[1].value;
	self.AircraftCount										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount')[1].value;
	self.AircraftCount01									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount01')[1].value;
	self.AircraftCount03									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount03')[1].value;
	self.AircraftCount06									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount06')[1].value;
	self.AircraftCount12 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount12')[1].value;
	self.AircraftCount24									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount24')[1].value;
	self.AircraftCount60 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='AircraftCount60')[1].value;
	self.WealthIndex 											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='WealthIndex')[1].value;
	self.BusinessActiveAssociation				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessActiveAssociation')[1].value;
	self.BusinessInactiveAssociation			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessInactiveAssociation')[1].value;
	self.BusinessAssociationAge						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessAssociationAge')[1].value;
	self.BusinessTitle										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BusinessTitle')[1].value;
	self.DerogSeverityIndex								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogSeverityIndex')[1].value;
	self.DerogCount												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogCount')[1].value;
	self.DerogRecentCount									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogRecentCount')[1].value;
	self.DerogAge													:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='DerogAge')[1].value;
	self.FelonyCount											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount')[1].value;
	self.FelonyAge												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyAge')[1].value;
	self.FelonyCount01										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount01')[1].value;
	self.FelonyCount03										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount03')[1].value;
	self.FelonyCount06										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount06')[1].value;
	self.FelonyCount12										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount12')[1].value;
	self.FelonyCount24										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount24')[1].value;
	self.FelonyCount60										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='FelonyCount60')[1].value;
	self.LienCount												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienCount')[1].value;
	self.LienFiledCount										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount')[1].value;
	self.LienFiledAge											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledAge')[1].value;
	self.LienFiledCount01									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount01')[1].value;
	self.LienFiledCount03									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount03')[1].value;
	self.LienFiledCount06									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount06')[1].value;
	self.LienFiledCount12									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount12')[1].value;
	self.LienFiledCount24									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount24')[1].value;
	self.LienFiledCount60									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledCount60')[1].value;
	self.LienReleasedCount								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount')[1].value;
	self.LienReleasedAge									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedAge')[1].value;
	self.LienReleasedCount01							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount01')[1].value;
	self.LienReleasedCount03							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount03')[1].value;
	self.LienReleasedCount06							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount06')[1].value;
	self.LienReleasedCount12							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount12')[1].value;
	self.LienReleasedCount24							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount24')[1].value;
	self.LienReleasedCount60							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedCount60')[1].value;
	self.LienFiledTotal										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFiledTotal')[1].value;
	self.LienFederalTaxFiledTotal					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxFiledTotal')[1].value;
	self.LienTaxOtherFiledTotal						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherFiledTotal')[1].value;
	self.LienForeclosureFiledTotal				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureFiledTotal')[1].value;
	self.LienLandlordTenantFiledTotal			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantFiledTotal')[1].value;
	self.LienJudgmentFiledTotal						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentFiledTotal')[1].value;
	self.LienSmallClaimsFiledTotal				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsFiledTotal')[1].value;
	self.LienOtherFiledTotal							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherFiledTotal')[1].value;
	self.LienReleasedTotal								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienReleasedTotal')[1].value;
	self.LienFederalTaxReleasedTotal			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxReleasedTotal')[1].value;
	self.LienTaxOtherReleasedTotal				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherReleasedTotal')[1].value;
	self.LienForeclosureReleasedTotal			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureReleasedTotal')[1].value;
	self.LienLandlordTenantReleasedTotal	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantReleasedTotal')[1].value;
	self.LienJudgmentReleasedTotal				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentReleasedTotal')[1].value;
	self.LienSmallClaimsReleasedTotal			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsReleasedTotal')[1].value;
	self.LienOtherReleasedTotal						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherReleasedTotal')[1].value;
	self.LienFederalTaxFiledCount					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxFiledCount')[1].value;
	self.LienTaxOtherFiledCount						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherFiledCount')[1].value;
	self.LienForeclosureFiledCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureFiledCount')[1].value;
	self.LienLandlordTenantFiledCount			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantFiledCount')[1].value;
	self.LienJudgmentFiledCount						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentFiledCount')[1].value;
	self.LienSmallClaimsFiledCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsFiledCount')[1].value;
	self.LienOtherFiledCount							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherFiledCount')[1].value;
	self.LienFederalTaxReleasedCount			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienFederalTaxReleasedCount')[1].value;
	self.LienTaxOtherReleasedCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienTaxOtherReleasedCount')[1].value;
	self.LienForeclosureReleasedCount			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienForeclosureReleasedCount')[1].value;
	self.LienLandlordTenantReleasedCount	:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienLandlordTenantReleasedCount')[1].value;
	self.LienJudgmentReleasedCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienJudgmentReleasedCount')[1].value;
	self.LienSmallClaimsReleasedCount			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienSmallClaimsReleasedCount')[1].value;
	self.LienOtherReleasedCount						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='LienOtherReleasedCount')[1].value;
	self.BankruptcyCount									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount')[1].value;
	self.BankruptcyAge										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyAge')[1].value;
	self.BankruptcyType										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyType')[1].value;
	self.BankruptcyStatus									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyStatus')[1].value;
	self.BankruptcyCount01								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount01')[1].value;
	self.BankruptcyCount03								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount03')[1].value;
	self.BankruptcyCount06								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount06')[1].value;
	self.BankruptcyCount12								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount12')[1].value;
	self.BankruptcyCount24								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount24')[1].value;
	self.BankruptcyCount60								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='BankruptcyCount60')[1].value;
	self.EvictionCount										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount')[1].value;
	self.EvictionAge											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionAge')[1].value;
	self.EvictionCount01									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount01')[1].value;
	self.EvictionCount03									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount03')[1].value;
	self.EvictionCount06									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount06')[1].value;
	self.EvictionCount12 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount12')[1].value;
	self.EvictionCount24 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount24')[1].value;
	self.EvictionCount60 									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EvictionCount60')[1].value;
	self.RecentActivityIndex							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='RecentActivityIndex')[1].value;
	self.NonDerogCount										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount')[1].value;
	self.NonDerogCount01									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount01')[1].value;
	self.NonDerogCount03									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount03')[1].value;
	self.NonDerogCount06									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount06')[1].value;
	self.NonDerogCount12									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount12')[1].value;
	self.NonDerogCount24									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount24')[1].value;
	self.NonDerogCount60									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='NonDerogCount60')[1].value;
	self.VoterRegistrationRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='VoterRegistrationRecord')[1].value;
	self.ProfLicCount											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount')[1].value;
	self.ProfLicAge												:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicAge')[1].value;
	self.ProfLicType											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicType')[1].value;
	self.ProfLicTypeCategory							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicTypeCategory')[1].value;
	self.ProfLicExpired										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicExpired')[1].value;
	self.ProfLicCount01										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount01')[1].value;
	self.ProfLicCount03										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount03')[1].value;
	self.ProfLicCount06										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount06')[1].value;
	self.ProfLicCount12										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount12')[1].value;
	self.ProfLicCount24										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount24')[1].value;
	self.ProfLicCount60										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ProfLicCount60')[1].value;
	self.InquiryCollectionsRecent					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InquiryCollectionsRecent')[1].value;
	self.InquiryPersonalFinanceRecent			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InquiryPersonalFinanceRecent')[1].value;
	self.InquiryOtherRecent								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InquiryOtherRecent')[1].value;
	self.HighRiskCreditActivity						:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='HighRiskCreditActivity')[1].value;
	self.SubPrimeOfferRequestCount				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount')[1].value;
	self.SubPrimeOfferRequestCount01			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount01')[1].value;
	self.SubPrimeOfferRequestCount03			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount03')[1].value;
	self.SubPrimeOfferRequestCount06			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount06')[1].value;
	self.SubPrimeOfferRequestCount12			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount12')[1].value;
	self.SubPrimeOfferRequestCount24			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount24')[1].value;
	self.SubPrimeOfferRequestCount60			:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SubPrimeOfferRequestCount60')[1].value;
	self.InputPhoneMobile 								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputPhoneMobile')[1].value;
	self.PhoneEDAAgeOldestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneEDAAgeOldestRecord')[1].value;
	self.PhoneEDAAgeNewestRecord					:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneEDAAgeNewestRecord')[1].value;
	self.PhoneOtherAgeOldestRecord				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneOtherAgeOldestRecord')[1].value;
	self.PhoneOtherAgeNewestRecord				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PhoneOtherAgeNewestRecord')[1].value;
	self.InputPhoneHighRisk								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputPhoneHighRisk')[1].value;
	self.InputPhoneProblems								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputPhoneProblems')[1].value;
	self.EmailAddress											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='EmailAddress')[1].value;
	self.InputAddrHighRisk								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrHighRisk')[1].value;
	self.CurrAddrCorrectional							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='CurrAddrCorrectional')[1].value;
	self.PrevAddrCorrectional							:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrevAddrCorrectional')[1].value;
	self.HistoricalAddrCorrectional				:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='HistoricalAddrCorrectional')[1].value;
	self.InputAddrProblems								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='InputAddrProblems')[1].value;
	self.SecurityFreeze										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SecurityFreeze')[1].value;
	self.SecurityAlert										:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='SecurityAlert')[1].value;
	self.IDTheftFlag											:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='IDTheftFlag')[1].value;
	self.ConsumerStatement								:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='ConsumerStatement')[1].value;
	self.PrescreenOptOut									:= l.attributegroups.AttributeGroup[1].attributes.attribute(name='PrescreenOptOut')[1].value;
end;

// j_f := sort(JOIN(resu,p_f,
									// LEFT.accountnumber=RIGHT.accountnumber,
									// flatten_results(left,right)), 
						// seq);
j_f := JOIN(resu,p_f,
				LEFT.accountnumber=RIGHT.accountnumber,
				flatten_results(left,right));

//output(choosen(j_f, eyeball), named('results_flattened'));

output(j_f,,outfile_name + today + '_' + (string)archive_date, CSV(quote('"')), overwrite);
output(j_f(errorcode<>''),,'~nmontpetit::out::rva_40_tracking_err' ,CSV(QUOTE('"')), overwrite);

endmacro;