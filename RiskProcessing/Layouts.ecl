import risk_indicators, riskview;

export Layouts := module

// ******************** layouts for importing CSV files to process *************
EXPORT nugen_prii_layout := RECORD
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
    string DLNumber;
    string DLState;
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    string historydateyyyymm;
END;

export legacy_prii_layout := record
     string ACCOUNT;
     string Fname;
     string MIDDLEINI;
     string Lname;
     string ADDRESS;
     string CITY;
     string STATE;
     string ZIP;
     string HOMEPHONE;
     string SOCIAL;
     string DOB;
     string WORKPHONE;
     string INCOME;
     string DRLC;
     string DRLCST;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERLAST;
     string EMAIL;
     string COMPANY;
     string HistoryDateYYYYMM;
end;

export biid_layout:= record
	string	AccountNumber	;
	string	CompanyName	;
	string	AlternateCompanyName	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	Businesstype   ;
	string	TaxIdNumber	;
	string	BusinessPhone	;
	string	BusinessPhone2	;
	string	BusinessPhone3	;
	string	website ;
	string	RepresentativeFirstName	;
	string	RepresentativeLastName	;
	string	RepresentativeNameSuffix  ;
	string	RepresentativeAddr	;
	string	RepresentativeCity	;
	string	RepresentativeState	;
	string	RepresentativeZip	;
	string	RepresentativeSSN	;
	string	RepresentativeDOB	;
	string	RepresentativeHomePhone	;
	string	RepresentativeWorkPhone	;
	string	RepresentativeDLNumber	;
	string	RepresentativeDLState	;
	string	RepresentativeEmailAddress	;
	integer	HistoryDateYYYYMM;
end;

export billto_shipto_layout := record  // to be used for Bill-to / Ship-To bocashell and 
	string30 accountnumber := '';
	string1  apptype := '';
	string15 firstname := '';
	string20 lastname := '';
	string30 employername := '';
	string50 streetaddress := '';
	string30 city := '';
	string2  state := '';
	string9  zip := '';
	string9  ssn := '';
	string8  dateofbirth := '';
	string10 homephone := '';
	string10 workphone := '';
	string20 dlnumber := '';
	string2  dlstate := '';
	string50 email := '';
	string1  apptype2 := '';
	string15 firstname2 := '';
	string20 lastname2 := '';
	string30 employername2 := '';
	string50 streetaddress2 := '';
	string30 city2 := '';
	string2  state2 := '';
	string9  zip2 := '';
	string9  ssn2 := '';
	string8  dateofbirth2 := '';
	string10 homephone2 := '';
	string10 workphone2 := '';
	string20 dlnumber2 := '';
	string2  dlstate2 := '';
	string50 email2 := '';
	string6  saleamt := '';
	string8  purchdate := '';
	string6  purchtime := '';
	string11 checkaba := '';
	string9  checkacct := '';
	string7  checknum := '';
	string40 bankname := '';
	string2  pymtmethod := '';
	string1  cctype := '';
	string2  avscode := '';
	string2  inquiries := '';
	string3  trades := '';
	string6  balance := '';
	string6  bankbalance := '';
	string6  highcredit := '';
	string3  delinquent90plus := '';
	string2  revolving := '';
	string2  autotrades := '';
	string2  autotradesopen := '';
	string6  income := '';
	string6  income2 := '';
	string45 ipaddress := '';
	string16 ccnum := '';
	string8  ccexpdate := '';
	string2  taxclass := '';
	string6  historydateyyyymm := '';
end;


export Layout_CDXO_Soapcall := record
	string	account	;
	string	ordertype	;
	string	cmpy	;
	string	cmpytype	;
	string	first	;
	string	last	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	hphone	;
	string	wphone	;
	string	socs	;
	string	formerlast	;
	string	email	;
	string	drlc	;
	string	drlcstate	;
	string	ipaddr	;
	string	avscode	;
	string	channel	;
	string	first2	;
	string	last2	;
	string	cmpy2	;
	string	addr2	;
	string	city2	;
	string	state2	;
	string	zip2	;
	string	hphone2	;
	string	channel2	;
	string	orderamt	;
	string	numitems	;
	string	orderdate	;
	string	cidcode	;
	string	shipmode	;
	string	pymtmethod	;
	string	productcode	;
	string	score	;
	string	score2	;
	integer	HistoryDateYYYYMM;
end;

export Layout_InstID_SoapCall := RECORD
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
	string  neutral_gateway := '';
	string  veris_gateway := '';
	boolean IncludeScore := true;
END;

export Layout_SDBO_Soapcall := record
	string  tribcode;	
	string  account;
	string  apptype;
	string  first;
	string  last;
	string  cmpy;
	string  addr;
	string  city;
	string  state;
	string  zip;
	string  socs;
	string  dob;
	string  hphone;
	string  wphone;
	string  drlc;
	string  ddrlcstate;
	string  email;
	string  apptype2;
	string  first2;
	string  last2;
	string  cmpy2;
	string  addr2;
	string  city2;
	string  state2;
	string  zip2;
	string  socs2;
	string  dob2;
	string  hphone2;
	string  wphone2;
	string  drlc2;
	string  drlcstate2;
	string  email2;
	string  saleamt;
	string  purchdate;
	string  purchtime;
	string  checkaba;
	string  checkacct;
	string  checknum;
	string  bankname;
	string  pymtmethod;
	string  cctype;
	string  avscode;
	string  inquiries;
	string  trades;
	string  balance;
	string  bankbalance;
	string  highcredit;
	string  delinquent90plus;
	string  revolving;
	string  autotrades;
	string  autotradesopen;
	string  income;
	string  income2;
	string  ipaddr;
	string  ccnum;
	string  ccexpdate;
	string  taxclass;
	string  countrycode;
	string  countrycode2;
	boolean runSeed;
	integer DPPAPurpose;
	integer GLBPurpose;
	integer HistoryDateYYYYMM;

end;

export layout_internal_shell := record
	unsigned8 time_ms := 0;
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	string errorcode;
end;

export layout_internal_shell_noDatasets := record
	unsigned8 time_ms := 0;
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell -LnJ_datasets - ConsumerStatements - bk_chapters ;
	string errorcode;
end;

rva := RiskView.Layouts.layout_riskview5_batch_response;

export insurview2_batch_response_layout := record
rva.acctno;
rva.LexID;

rva.InputProvidedFirstName;
rva.InputProvidedLastName;
rva.InputProvidedStreetAddress;
rva.InputProvidedCity;
rva.InputProvidedState;
rva.InputProvidedZipCode;
rva.InputProvidedSSN;
rva.InputProvidedDateofBirth;
rva.InputProvidedPhone;
rva.InputProvidedLexID;

rva.SubjectRecordTimeOldest;
rva.SubjectRecordTimeNewest;
rva.SubjectNewestRecord12Month;
rva.SubjectActivityIndex03Month;
rva.SubjectActivityIndex06Month;
rva.SubjectActivityIndex12Month;
rva.SubjectAge;
rva.SubjectDeceased;
rva.SubjectSSNCount;
rva.SubjectStabilityIndex;
rva.SubjectStabilityPrimaryFactor;
rva.SubjectAbilityIndex;
rva.SubjectAbilityPrimaryFactor;
rva.SubjectWillingnessIndex;
rva.SubjectWillingnessPrimaryFactor;

rva.ConfirmationSubjectFound;
rva.ConfirmationInputName;
rva.ConfirmationInputDOB;
rva.ConfirmationInputSSN;
rva.ConfirmationInputAddress;

rva.SourceNonDerogProfileIndex;
rva.SourceNonDerogCount;
rva.SourceNonDerogCount03Month;
rva.SourceNonDerogCount06Month;
rva.SourceNonDerogCount12Month;
rva.SourceCredHeaderTimeOldest;
rva.SourceCredHeaderTimeNewest;
rva.SourceVoterRegistration;

rva.SSNSubjectCount;
rva.SSNDeceased;
rva.SSNDateLowIssued;
rva.SSNProblems;

rva.AddrOnFileCount;
rva.AddrOnFileCorrectional;
rva.AddrOnFileCollege;
rva.AddrOnFileHighRisk;
rva.AddrInputTimeOldest;
rva.AddrInputTimeNewest;
rva.AddrInputLengthOfRes;
rva.AddrInputSubjectCount;
rva.AddrInputMatchIndex;
rva.AddrInputSubjectOwned;
rva.AddrInputDeedMailing;
rva.AddrInputOwnershipIndex;
rva.AddrInputPhoneService;
rva.AddrInputPhoneCount;
rva.AddrInputDwellType;
rva.AddrInputDwellTypeIndex;
rva.AddrInputDelivery;
rva.AddrInputTimeLastSale;
rva.AddrInputLastSalePrice;
rva.AddrInputTaxValue;
rva.AddrInputTaxYr;
rva.AddrInputTaxMarketValue;
rva.AddrInputAVMValue;
rva.AddrInputAVMValue12Month;
rva.AddrInputAVMValue60Month;
rva.AddrInputAVMRatio12MonthPrior;
rva.AddrInputAVMRatio60MonthPrior;
rva.AddrInputCountyRatio;
rva.AddrInputTractRatio;
rva.AddrInputBlockRatio;
rva.AddrInputProblems;
rva.AddrCurrentTimeOldest;
rva.AddrCurrentTimeNewest;
rva.AddrCurrentLengthOfRes;
rva.AddrCurrentSubjectOwned;
rva.AddrCurrentDeedMailing;
rva.AddrCurrentOwnershipIndex;
rva.AddrCurrentPhoneService;
rva.AddrCurrentDwellType;
rva.AddrCurrentDwellTypeIndex;
rva.AddrCurrentTimeLastSale;
rva.AddrCurrentLastSalesPrice;
rva.AddrCurrentTaxValue;
rva.AddrCurrentTaxYr;
rva.AddrCurrentTaxMarketValue;
rva.AddrCurrentAVMValue;
rva.AddrCurrentAVMValue12Month;
rva.AddrCurrentAVMRatio12MonthPrior;
rva.AddrCurrentAVMValue60Month;
rva.AddrCurrentAVMRatio60MonthPrior;
rva.AddrCurrentCountyRatio;
rva.AddrCurrentTractRatio;
rva.AddrCurrentBlockRatio;
rva.AddrCurrentCorrectional;
rva.AddrPreviousTimeOldest;
rva.AddrPreviousTimeNewest;
rva.AddrPreviousLengthOfRes;
rva.AddrPreviousSubjectOwned;
rva.AddrPreviousOwnershipIndex;
rva.AddrPreviousDwellType;
rva.AddrPreviousDwellTypeIndex;
rva.AddrPreviousCorrectional;


rva.AddrStabilityIndex;
rva.AddrChangeCount03Month;
rva.AddrChangeCount06Month;
rva.AddrChangeCount12Month;
rva.AddrChangeCount24Month;
rva.AddrChangeCount60Month;
rva.AddrLastMoveTaxRatioDiff;
rva.AddrLastMoveEconTrajectory;
rva.AddrLastMoveEconTrajectoryIndex;

rva.PhoneInputProblems;
rva.PhoneInputSubjectCount;
rva.PhoneInputMobile;

rva.EducationAttendance;
rva.EducationEvidence;
rva.EducationProgramAttended;
rva.EducationInstitutionPrivate;
rva.EducationInstitutionRating;

rva.BusinessAssociation;
rva.BusinessAssociationIndex;
rva.BusinessAssociationTimeOldest;
rva.BusinessTitleLeadership;


rva.ProfLicCount;
rva.ProfLicTypeCategory;

rva.AssetIndex;
rva.AssetIndexPrimaryFactor;
rva.AssetOwnership;
rva.AssetProp;
rva.AssetPropIndex;
rva.AssetPropEverCount;
rva.AssetPropCurrentCount;
rva.AssetPropCurrentTaxTotal;
rva.AssetPropPurchaseCount12Month;
rva.AssetPropPurchaseTimeOldest;
rva.AssetPropPurchaseTimeNewest;
rva.AssetPropNewestMortgageType;
rva.AssetPropEverSoldCount;
rva.AssetPropSoldCount12Month;
rva.AssetPropSaleTimeOldest;
rva.AssetPropSaleTimeNewest;
rva.AssetPropNewestSalePrice;
rva.AssetPropSalePurchaseRatio;
rva.AssetPersonal;
rva.AssetPersonalCount;

rva.PurchaseActivityIndex;
rva.PurchaseActivityCount;
rva.PurchaseActivityDollarTotal;

rva.DerogSeverityIndex;
rva.DerogCount;
rva.DerogCount12Month;
rva.DerogTimeNewest;

rva.CriminalFelonyCount;
rva.CriminalFelonyCount12Month;
rva.CriminalFelonyTimeNewest;
rva.CriminalNonFelonyCount;
rva.CriminalNonFelonyCount12Month;
rva.CriminalNonFelonyTimeNewest;

rva.EvictionCount;
rva.EvictionCount12Month;
rva.EvictionTimeNewest;

rva.LienJudgmentSeverityIndex;
rva.LienJudgmentCount;
rva.LienJudgmentCount12Month;
rva.LienJudgmentSmallClaimsCount;
rva.LienJudgmentCourtCount;
rva.LienJudgmentTaxCount;
rva.LienJudgmentForeclosureCount;
rva.LienJudgmentOtherCount;
rva.LienJudgmentTimeNewest;
rva.LienJudgmentDollarTotal;

rva.BankruptcyCount;
rva.BankruptcyCount24Month;
rva.BankruptcyTimeNewest;
rva.BankruptcyChapter;
rva.BankruptcyStatus;
rva.BankruptcyDismissed24Month;

rva.ShortTermLoanRequest;
rva.ShortTermLoanRequest12Month;
rva.ShortTermLoanRequest24Month;

rva.InquiryAuto12Month;
rva.InquiryBanking12Month;
rva.InquiryTelcom12Month;
rva.InquiryNonShortTerm12Month;
rva.InquiryShortTerm12Month;
rva.InquiryCollections12Month;

rva.AlertRegulatoryCondition;

unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing in soapcall script.  this will be 0 in the Vault thor script
string errorcode := '';

end;

END;
