#workunit('name', 'Insurview2 testing');

IMPORT IESP, Models, Risk_Indicators, RiskWise, RiskProcessing, RiskView, ut, gateway;

eyeball := 100;

recordsToRun := 0; // Set to 0 or -1 to run ALL records in the file
threads := 2; // 1 - 30, 1-2 if using 50 way, 10-30 if using 3_way pound_option_thor cluster.  not exceed 100 threads total as roxies are 100 node machines
// NeutralRoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;

// FCRARoxieIP := RiskWise.shortcuts.staging_fcra_roxieIP;
FCRARoxieIP := RiskWise.shortcuts.prod_batch_fcra;
NeutralRoxieIP := RiskWise.shortcuts.prod_batch_neutral;
	
inputFile := ut.foreign_prod+'dvstemp::in::insurview2_sample_20191111_2019113';
outputFile := '~dvstemp::out::insurview2_roxie_' + thorlib.wuid();

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
	string DLNumber;
	string DLState;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	integer historydateyyyymm;
	string LexID;
END;

inputData := IF(recordsToRun > 0, CHOOSEN(DATASET(inputFile, prii_layout, CSV(QUOTE('"'), heading(1))), recordsToRun),
																	DATASET(inputFile, prii_layout, CSV(QUOTE('"'), heading(1))));

OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Raw_Input'));


soapLayout := RECORD
	string userid := '';
	DATASET(iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesRequest) FCRAInsurView2AttributesRequest;
	integer HistoryDateYYYYMM := 999999;
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	boolean RetainInputDID := true;
END;

soapLayout intoSOAP(inputData le, UNSIGNED4 c) := TRANSFORM
	name := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name,
						SELF.First := le.FirstName;
						SELF.Middle := le.MiddleName;
						SELF.Last := le.LastName;
						SELF := []))[1];
	address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address,
						SELF.StreetAddress1 := le.StreetAddress;
						SELF.City := le.City;
						SELF.State := le.State;
						SELF.Zip5 := le.Zip;
						SELF := []))[1];
	dob := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date,
						SELF.Year := (integer)le.DateOfBirth[1..4];
						SELF.Month := (integer)le.DateOfBirth[5..6];
						SELF.Day := (integer)le.DateOfBirth[7..8];
						SELF := []))[1];
	
	search := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2SearchBy,
						// self.seq := le.AccountNumber; // for comparing to vault files, we'll just use the LexID for comparison.  seq number is causing us to lose records on response
						self.uniqueid := le.lexid;
						SELF.Name := name;
						SELF.Address := address;
						SELF.DOB := dob;
						SELF.SSN := le.SSN;
						SELF.DriverLicenseNumber := le.DLNumber;
						SELF.DriverLicenseState := le.DLState;
						SELF.HomePhone := le.HomePhone;
						SELF.WorkPhone := le.WorkPhone;
						SELF := []));
	
	option := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesOptions,
						SELF.AttributesVersionRequest := 'insurview2attr';
						SELF.IntendedPurpose := 'Insurance Application';
						self.Allow10YearBankruptcy := true;
						self.FFDOptionsMask := '100';  // this is what exists in the roxielogs in production
						self.IncludeLiensJudgmentsReport := false;  // JULI report isn't part of the normal request in this product, even though the option is there
						SELF := []));
	
	users := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User,
						SELF.DataRestrictionMask := '0000000000010100000000000'; // This is the DRM coming in from ISS in the production roxie logs
						SELF.AccountNumber := IF(le.AccountNumber <> '', le.AccountNumber, (STRING)c);
						SELF.TestDataEnabled := FALSE;
						SELF.OutcomeTrackingOptOut := TRUE;
						SELF := []));
	
	SELF.FCRAInsurView2AttributesRequest := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesRequest, 
						SELF.SearchBy := search[1];
						SELF.Options := option[1];
						SELF.User := users[1];
						SELF := []));
	
	SELF.HistoryDateYYYYMM := 999999;
	self.RetainInputDID := true;
	self.userid := 'testing_via_soapcall';
	SELF.Gateways := PROJECT(ut.ds_oneRecord, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'neutralroxie'; SELF.URL := NeutralRoxieIP; SELF := []));
END;

soapInput := DISTRIBUTE(PROJECT(inputData, intoSOAP(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(soapInput, eyeball), NAMED('Sample_SOAP_Input'));


xlayout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.fcrainsurview2attributes.t_FCRAInsurView2AttributesResponse;
	STRING errorcode;
END;

xlayout myFail(soapInput le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

soapResults := SOAPCALL(soapInput, 
				FCRARoxieIP,
				'ISS.fcrainsurview2_service', 
				{soapInput}, 
				DATASET(xlayout),
				XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
        RETRY(5),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
OUTPUT(CHOOSEN(soapResults, eyeball), NAMED('Sample_SOAP_Results'));

validResults := soapResults (errorcode = '');
failedResults := soapResults (errorcode <> '');

OUTPUT(COUNT(validResults), NAMED('Total_Passed'));
OUTPUT(CHOOSEN(validResults, eyeball), NAMED('Sample_Passed_Results'));

OUTPUT(COUNT(failedResults), NAMED('Total_Failed'));
OUTPUT(CHOOSEN(failedResults, eyeball), NAMED('Sample_Failed_Results'));

flattened_result := project(soapResults, transform(riskprocessing.layouts.insurview2_batch_response_layout,
	// self.acctno := left.result.inputecho.seq,  // when passing in the seq number, not all results come back
	self.acctno := left.result.uniqueid,  // use the lexid on input, it should be unique when processing this file anyway
	self.LexID := left.result.UniqueId;

	self.InputProvidedFirstName := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedFirstName;
	self.InputProvidedLastName := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedLastName;
	self.InputProvidedStreetAddress := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedStreetAddress;
	self.InputProvidedCity := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedCity;
	self.InputProvidedState := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedState;
	self.InputProvidedZipCode := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedZipCode;
	self.InputProvidedSSN := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedSSN;
	self.InputProvidedDateofBirth := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedDateofBirth;
	self.InputProvidedPhone := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedPhone;
	self.InputProvidedLexID := left.result.InsurView2Attributes.InputDataCheckFlags.InputProvidedLexID;
	
	self.SubjectRecordTimeOldest := left.result.InsurView2Attributes.SubjectSource.SubjectRecordTimeOldest;
	self.SubjectRecordTimeNewest := left.result.InsurView2Attributes.SubjectSource.SubjectRecordTimeNewest;
	self.SubjectNewestRecord12Month := left.result.InsurView2Attributes.SubjectSource.SubjectNewestRecord12Month;
	self.SubjectActivityIndex03Month := left.result.InsurView2Attributes.SubjectSource.SubjectActivityIndex03Month;
	self.SubjectActivityIndex06Month := left.result.InsurView2Attributes.SubjectSource.SubjectActivityIndex06Month;
	self.SubjectActivityIndex12Month := left.result.InsurView2Attributes.SubjectSource.SubjectActivityIndex12Month;
	self.SubjectAge := left.result.InsurView2Attributes.SubjectSource.SubjectAge;
	self.SubjectDeceased := left.result.InsurView2Attributes.SubjectSource.SubjectDeceased;
	self.SubjectSSNCount := left.result.InsurView2Attributes.SubjectSource.SubjectSSNCount;
	self.SubjectStabilityIndex := left.result.InsurView2Attributes.SubjectSource.SubjectStabilityIndex;
	self.SubjectStabilityPrimaryFactor := left.result.InsurView2Attributes.SubjectSource.SubjectStabilityPrimaryFactor;
	self.SubjectAbilityIndex := left.result.InsurView2Attributes.SubjectSource.SubjectAbilityIndex;
	self.SubjectAbilityPrimaryFactor := left.result.InsurView2Attributes.SubjectSource.SubjectAbilityPrimaryFactor;
	self.SubjectWillingnessIndex := left.result.InsurView2Attributes.SubjectSource.SubjectWillingnessIndex;
	self.SubjectWillingnessPrimaryFactor := left.result.InsurView2Attributes.SubjectSource.SubjectWillingnessPrimaryFactor;
		
	self.ConfirmationSubjectFound := left.result.InsurView2Attributes.SubjectConfirmation.ConfirmationSubjectFound;
	self.ConfirmationInputName := left.result.InsurView2Attributes.SubjectConfirmation.ConfirmationInputName;
	self.ConfirmationInputDOB := left.result.InsurView2Attributes.SubjectConfirmation.ConfirmationInputDOB;
	self.ConfirmationInputSSN := left.result.InsurView2Attributes.SubjectConfirmation.ConfirmationInputSSN;
	self.ConfirmationInputAddress := left.result.InsurView2Attributes.SubjectConfirmation.ConfirmationInputAddress;
	
	self.SourceNonDerogProfileIndex := left.result.InsurView2Attributes.SourceRecordActivity.SourceNonDerogProfileIndex;
	self.SourceNonDerogCount := left.result.InsurView2Attributes.SourceRecordActivity.SourceNonDerogCount;
	self.SourceNonDerogCount03Month := left.result.InsurView2Attributes.SourceRecordActivity.SourceNonDerogCount03Month;
	self.SourceNonDerogCount06Month := left.result.InsurView2Attributes.SourceRecordActivity.SourceNonDerogCount06Month;
	self.SourceNonDerogCount12Month := left.result.InsurView2Attributes.SourceRecordActivity.SourceNonDerogCount12Month;
	self.SourceCredHeaderTimeOldest := left.result.InsurView2Attributes.SourceRecordActivity.SourceCredHeaderTimeOldest;
	self.SourceCredHeaderTimeNewest := left.result.InsurView2Attributes.SourceRecordActivity.SourceCredHeaderTimeNewest;
	self.SourceVoterRegistration := left.result.InsurView2Attributes.SourceRecordActivity.SourceVoterRegistration;
	
	self.EducationAttendance := left.result.InsurView2Attributes.Education.EducationAttendance;
	self.EducationEvidence := left.result.InsurView2Attributes.Education.EducationEvidence;
	self.EducationProgramAttended := left.result.InsurView2Attributes.Education.EducationProgramAttended;
	self.EducationInstitutionPrivate := left.result.InsurView2Attributes.Education.EducationInstitutionPrivate;
	self.EducationInstitutionRating := left.result.InsurView2Attributes.Education.EducationInstitutionRating;
	
	self.ProfLicCount := left.result.InsurView2Attributes.ProfessionalLicense.ProfLicCount;
	self.ProfLicTypeCategory := left.result.InsurView2Attributes.ProfessionalLicense.ProfLicTypeCategory;
	
	self.BusinessAssociation := left.result.InsurView2Attributes.BusinessAssociation.BusinessAssociation;
	self.BusinessAssociationIndex := left.result.InsurView2Attributes.BusinessAssociation.BusinessAssociationIndex;
	self.BusinessAssociationTimeOldest := left.result.InsurView2Attributes.BusinessAssociation.BusinessAssociationTimeOldest;
	self.BusinessTitleLeadership := left.result.InsurView2Attributes.BusinessAssociation.BusinessTitleLeadership;
	
	self.AssetIndex := left.result.InsurView2Attributes.Asset.AssetIndex;
	self.AssetIndexPrimaryFactor := left.result.InsurView2Attributes.Asset.AssetIndexPrimaryFactor;
	self.AssetOwnership := left.result.InsurView2Attributes.Asset.AssetOwnership;
	self.AssetProp := left.result.InsurView2Attributes.Asset.AssetProp;
	self.AssetPropIndex := left.result.InsurView2Attributes.Asset.AssetPropIndex;
	self.AssetPropEverCount := left.result.InsurView2Attributes.Asset.AssetPropEverCount;
	self.AssetPropCurrentCount := left.result.InsurView2Attributes.Asset.AssetPropCurrentCount;
	self.AssetPropCurrentTaxTotal := left.result.InsurView2Attributes.Asset.AssetPropCurrentTaxTotal;
	self.AssetPropPurchaseCount12Month := left.result.InsurView2Attributes.Asset.AssetPropPurchaseCount12Month;
	self.AssetPropPurchaseTimeOldest := left.result.InsurView2Attributes.Asset.AssetPropPurchaseTimeOldest;
	self.AssetPropPurchaseTimeNewest := left.result.InsurView2Attributes.Asset.AssetPropPurchaseTimeNewest;
	self.AssetPropNewestMortgageType := left.result.InsurView2Attributes.Asset.AssetPropNewestMortgageType;
	self.AssetPropEverSoldCount := left.result.InsurView2Attributes.Asset.AssetPropEverSoldCount;
	self.AssetPropSoldCount12Month := left.result.InsurView2Attributes.Asset.AssetPropSoldCount12Month;
	self.AssetPropSaleTimeOldest := left.result.InsurView2Attributes.Asset.AssetPropSaleTimeOldest;
	self.AssetPropSaleTimeNewest := left.result.InsurView2Attributes.Asset.AssetPropSaleTimeNewest;
	self.AssetPropNewestSalePrice := left.result.InsurView2Attributes.Asset.AssetPropNewestSalePrice;
	self.AssetPropSalePurchaseRatio := left.result.InsurView2Attributes.Asset.AssetPropSalePurchaseRatio;
	self.AssetPersonal := left.result.InsurView2Attributes.Asset.AssetPersonal;
	self.AssetPersonalCount := left.result.InsurView2Attributes.Asset.AssetPersonalCount;
	
	self.PurchaseActivityIndex := left.result.InsurView2Attributes.PurchaseActivity.PurchaseActivityIndex;
	self.PurchaseActivityCount := left.result.InsurView2Attributes.PurchaseActivity.PurchaseActivityCount;
	self.PurchaseActivityDollarTotal := left.result.InsurView2Attributes.PurchaseActivity.PurchaseActivityDollarTotal;
	
	self.DerogSeverityIndex := left.result.InsurView2Attributes.DerogatoryPublicRecords.DerogSeverityIndex;
	self.DerogCount := left.result.InsurView2Attributes.DerogatoryPublicRecords.DerogCount;
	self.DerogCount12Month := left.result.InsurView2Attributes.DerogatoryPublicRecords.DerogCount12Month;
	self.DerogTimeNewest := left.result.InsurView2Attributes.DerogatoryPublicRecords.DerogTimeNewest;
	
	self.CriminalFelonyCount := left.result.InsurView2Attributes.CriminalRecords.CriminalFelonyCount;
	self.CriminalFelonyCount12Month := left.result.InsurView2Attributes.CriminalRecords.CriminalFelonyCount12Month;
	self.CriminalFelonyTimeNewest := left.result.InsurView2Attributes.CriminalRecords.CriminalFelonyTimeNewest;
	self.CriminalNonFelonyCount := left.result.InsurView2Attributes.CriminalRecords.CriminalNonFelonyCount;
	self.CriminalNonFelonyCount12Month := left.result.InsurView2Attributes.CriminalRecords.CriminalNonFelonyCount12Month;
	self.CriminalNonFelonyTimeNewest := left.result.InsurView2Attributes.CriminalRecords.CriminalNonFelonyTimeNewest;
	
	self.EvictionCount := left.result.InsurView2Attributes.EvictionRecords.EvictionCount;
	self.EvictionCount12Month := left.result.InsurView2Attributes.EvictionRecords.EvictionCount12Month;
	self.EvictionTimeNewest := left.result.InsurView2Attributes.EvictionRecords.EvictionTimeNewest;
	
	self.LienJudgmentSeverityIndex := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentSeverityIndex;
	self.LienJudgmentCount := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentCount;
	self.LienJudgmentCount12Month := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentCount12Month;
	self.LienJudgmentSmallClaimsCount := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentSmallClaimsCount;
	self.LienJudgmentCourtCount := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentCourtCount;
	self.LienJudgmentTaxCount := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentTaxCount;
	self.LienJudgmentForeclosureCount := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentForeclosureCount;
	self.LienJudgmentOtherCount := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentOtherCount;
	self.LienJudgmentTimeNewest := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentTimeNewest;
	self.LienJudgmentDollarTotal := left.result.InsurView2Attributes.TaxLienAndCourtJudgmentRecords.LienJudgmentDollarTotal;
	
	self.BankruptcyCount := left.result.InsurView2Attributes.BankruptcyRecords.BankruptcyCount;
	self.BankruptcyCount24Month := left.result.InsurView2Attributes.BankruptcyRecords.BankruptcyCount24Month;
	self.BankruptcyTimeNewest := left.result.InsurView2Attributes.BankruptcyRecords.BankruptcyTimeNewest;
	self.BankruptcyChapter := left.result.InsurView2Attributes.BankruptcyRecords.BankruptcyChapter;
	self.BankruptcyStatus := left.result.InsurView2Attributes.BankruptcyRecords.BankruptcyStatus;
	self.BankruptcyDismissed24Month := left.result.InsurView2Attributes.BankruptcyRecords.BankruptcyDismissed24Month;
	
	self.ShortTermLoanRequest := left.result.InsurView2Attributes.ShortTermLoanSolicitationRecords.ShortTermLoanRequest;
	self.ShortTermLoanRequest12Month := left.result.InsurView2Attributes.ShortTermLoanSolicitationRecords.ShortTermLoanRequest12Month;
	self.ShortTermLoanRequest24Month := left.result.InsurView2Attributes.ShortTermLoanSolicitationRecords.ShortTermLoanRequest24Month;
	
	self.InquiryAuto12Month := left.result.InsurView2Attributes.InquiryActivity.InquiryAuto12Month;
	self.InquiryBanking12Month := left.result.InsurView2Attributes.InquiryActivity.InquiryBanking12Month;
	self.InquiryTelcom12Month := left.result.InsurView2Attributes.InquiryActivity.InquiryTelcom12Month;
	self.InquiryNonShortTerm12Month := left.result.InsurView2Attributes.InquiryActivity.InquiryNonShortTerm12Month;
	self.InquiryShortTerm12Month := left.result.InsurView2Attributes.InquiryActivity.InquiryShortTerm12Month;
	self.InquiryCollections12Month := left.result.InsurView2Attributes.InquiryActivity.InquiryCollections12Month;
	
	self.SSNSubjectCount := left.result.InsurView2Attributes.SSNCharacteristics.SSNSubjectCount;
	self.SSNDeceased := left.result.InsurView2Attributes.SSNCharacteristics.SSNDeceased;
	self.SSNDateLowIssued := left.result.InsurView2Attributes.SSNCharacteristics.SSNDateLowIssued;
	self.SSNProblems := left.result.InsurView2Attributes.SSNCharacteristics.SSNProblems;
	
	self.AddrOnFileCount := left.result.InsurView2Attributes.AddressCharacteristics.AddrOnFileCount;
	self.AddrOnFileCorrectional := left.result.InsurView2Attributes.AddressCharacteristics.AddrOnFileCorrectional;
	self.AddrOnFileCollege := left.result.InsurView2Attributes.AddressCharacteristics.AddrOnFileCollege;
	self.AddrOnFileHighRisk := left.result.InsurView2Attributes.AddressCharacteristics.AddrOnFileHighRisk;
	self.AddrInputTimeOldest := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTimeOldest;
	self.AddrInputTimeNewest := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTimeNewest;
	self.AddrInputLengthOfRes := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputLengthOfRes;
	self.AddrInputSubjectCount := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputSubjectCount;
	self.AddrInputMatchIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputMatchIndex;
	self.AddrInputSubjectOwned := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputSubjectOwned;
	self.AddrInputDeedMailing := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputDeedMailing;
	self.AddrInputOwnershipIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputOwnershipIndex;
	self.AddrInputPhoneService := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputPhoneService;
	self.AddrInputPhoneCount := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputPhoneCount;
	self.AddrInputDwellType := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputDwellType;
	self.AddrInputDwellTypeIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputDwellTypeIndex;
	self.AddrInputDelivery := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputDelivery;
	self.AddrInputTimeLastSale := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTimeLastSale;
	self.AddrInputLastSalePrice := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputLastSalePrice;
	self.AddrInputTaxValue := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTaxValue;
	self.AddrInputTaxYr := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTaxYr;
	self.AddrInputTaxMarketValue := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTaxMarketValue;
	self.AddrInputAVMValue := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputAVMValue;
	self.AddrInputAVMValue12Month := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputAVMValue12Month;
	self.AddrInputAVMRatio12MonthPrior := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputAVMRatio12MonthPrior;
	self.AddrInputAVMValue60Month := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputAVMValue60Month;
	self.AddrInputAVMRatio60MonthPrior := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputAVMRatio60MonthPrior;
	self.AddrInputCountyRatio := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputCountyRatio;
	self.AddrInputTractRatio := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputTractRatio;
	self.AddrInputBlockRatio := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputBlockRatio;
	self.AddrInputProblems := left.result.InsurView2Attributes.AddressCharacteristics.AddrInputProblems;
	self.AddrCurrentTimeOldest := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTimeOldest;
	self.AddrCurrentTimeNewest := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTimeNewest;
	self.AddrCurrentLengthOfRes := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentLengthOfRes;
	self.AddrCurrentSubjectOwned := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentSubjectOwned;
	self.AddrCurrentDeedMailing := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentDeedMailing;
	self.AddrCurrentOwnershipIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentOwnershipIndex;
	self.AddrCurrentPhoneService := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentPhoneService;
	self.AddrCurrentDwellType := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentDwellType;
	self.AddrCurrentDwellTypeIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentDwellTypeIndex;
	self.AddrCurrentTimeLastSale := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTimeLastSale;
	self.AddrCurrentLastSalesPrice := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentLastSalesPrice;
	self.AddrCurrentTaxValue := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTaxValue;
	self.AddrCurrentTaxYr := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTaxYr;
	self.AddrCurrentTaxMarketValue := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTaxMarketValue;
	self.AddrCurrentAVMValue := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentAVMValue;
	self.AddrCurrentAVMValue12Month := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentAVMValue12Month;
	self.AddrCurrentAVMRatio12MonthPrior := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentAVMRatio12MonthPrior;
	self.AddrCurrentAVMValue60Month := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentAVMValue60Month;
	self.AddrCurrentAVMRatio60MonthPrior := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentAVMRatio60MonthPrior;
	self.AddrCurrentCountyRatio := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentCountyRatio;
	self.AddrCurrentTractRatio := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentTractRatio;
	self.AddrCurrentBlockRatio := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentBlockRatio;
	self.AddrCurrentCorrectional := left.result.InsurView2Attributes.AddressCharacteristics.AddrCurrentCorrectional;
	self.AddrPreviousTimeOldest := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousTimeOldest;
	self.AddrPreviousTimeNewest := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousTimeNewest;
	self.AddrPreviousLengthOfRes := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousLengthOfRes;
	self.AddrPreviousSubjectOwned := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousSubjectOwned;
	self.AddrPreviousOwnershipIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousOwnershipIndex;
	self.AddrPreviousDwellType := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousDwellType;
	self.AddrPreviousDwellTypeIndex := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousDwellTypeIndex;
	self.AddrPreviousCorrectional := left.result.InsurView2Attributes.AddressCharacteristics.AddrPreviousCorrectional;
	
	self.AddrStabilityIndex := left.result.InsurView2Attributes.AddressHistory.AddrStabilityIndex;
	self.AddrChangeCount03Month := left.result.InsurView2Attributes.AddressHistory.AddrChangeCount03Month;
	self.AddrChangeCount06Month := left.result.InsurView2Attributes.AddressHistory.AddrChangeCount06Month;
	self.AddrChangeCount12Month := left.result.InsurView2Attributes.AddressHistory.AddrChangeCount12Month;
	self.AddrChangeCount24Month := left.result.InsurView2Attributes.AddressHistory.AddrChangeCount24Month;
	self.AddrChangeCount60Month := left.result.InsurView2Attributes.AddressHistory.AddrChangeCount60Month;
	self.AddrLastMoveTaxRatioDiff := left.result.InsurView2Attributes.AddressHistory.AddrLastMoveTaxRatioDiff;
	self.AddrLastMoveEconTrajectory := left.result.InsurView2Attributes.AddressHistory.AddrLastMoveEconTrajectory;
	self.AddrLastMoveEconTrajectoryIndex := left.result.InsurView2Attributes.AddressHistory.AddrLastMoveEconTrajectoryIndex;
	
	self.PhoneInputProblems := left.result.InsurView2Attributes.PhoneCharacteristics.PhoneInputProblems;
	self.PhoneInputSubjectCount := left.result.InsurView2Attributes.PhoneCharacteristics.PhoneInputSubjectCount;
	self.PhoneInputMobile := left.result.InsurView2Attributes.PhoneCharacteristics.PhoneInputMobile;
	
	self.AlertRegulatoryCondition := left.result.InsurView2Attributes.ConsumerAlert.AlertRegulatoryCondition;
	
	// self.LnJEvictionTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJEvictionTimeNewest ;
	// self.LnJEvictionTotalCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJEvictionTotalCount ;
	// self.LnJEvictionTotalCount12Month := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJEvictionTotalCount12Month ;
	// self.LnJJudgmentCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJJudgmentCount ;
	// self.LnJJudgmentCourtCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJJudgmentCourtCount ;
	// self.LnJJudgmentDollarTotal := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJJudgmentDollarTotal ;
	// self.LnJJudgmentForeclosureCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJJudgmentForeclosureCount ;
	// self.LnJJudgmentSmallClaimsCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJJudgmentSmallClaimsCount ;
	// self.LnjJudgmentTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJJudgementTimeNewest ;
	// self.LnJLienCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienCount ;
	// self.LnJLienDollarTotal := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienDollarTotal ;
	// self.LnJLienJudgmentCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienJudgmentCount ;
	// self.LnJLienJudgmentCount12Month := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienJudgmentCount12Month ;
	// self.LnJLienJudgmentDollarTotal := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienJudgmentDollarTotal ;
	// self.LnJLienJudgmentOtherCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienJudgmentOtherCount ;
	// self.LnJLienJudgmentSeverityIndex := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienJudgmentSeverityIndex ;
	// self.LnJLienJudgmentTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienJudgmentTimeNewest ;
	// self.LnJLienTaxCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxCount ;
	// self.LnJLienTaxDollarTotal := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxDollarTotal ;
	// self.LnJLienTaxFederalCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxFederalCount ;
	// self.LnJLienTaxFederalDollarTotal := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxFederalDollarTotal ;
	// self.LnJLienTaxFederalTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxFederalTimeNewest ;
	// self.LnJLienTaxStateCount := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxStateCount ;
	// self.LnJLienTaxStateDollarTotal := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxStateDollarTotal ;
	// self.LnJLienTaxStateTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxStateTimeNewest ;
	// self.LnJLienTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTimeNewest ;
	// self.LnJLienTaxTimeNewest := left.result.InsurView2Attributes.LiensAndJudgmentsReport.LnJLienTaxTimeNewest ;

self := left;
self := []));
	
output(choosen(flattened_result, eyeball), named('flattened_result'));
output(flattened_result,,outputFile, CSV(heading(single), quote('"')));


