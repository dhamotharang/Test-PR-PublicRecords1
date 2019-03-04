#workunit('name', 'RiskView_V5');

IMPORT IESP, Models, Risk_Indicators, RiskWise, RiskProcessing, RiskView, ut, gateway;

eyeball := 100;

recordsToRun := 10; // Set to 0 or -1 to run ALL records in the file
threads := 2; // 1 - 30
// FCRARoxieIP := RiskWise.shortcuts.Dev194;
// NeutralRoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;

FCRARoxieIP := RiskWise.shortcuts.prod_batch_fcra;
NeutralRoxieIP := RiskWise.shortcuts.prod_batch_neutral;
	
inputFile := ut.foreign_prod+'dvstemp::in::audit_input_file_w20140701-122932';
outputFile := '~dvstemp::out::riskview_v5_' + thorlib.wuid();

model1 := ''; // Populate this first, if only 1 model is being requested this will be the only model field populated
model2 := ''; // Populate this second
model3 := ''; // Populate this third
model4 := ''; // Populate this fourth
model5 := ''; // Populate this fifth

/* Turn on the PRESCREENING intended purpose if this customer will be running in prescreen mode */
intendedPurpose := '';
// intendedPurpose := 'PRESCREENING';
// intendedPurpose := 'COLLECTIONS';

attributesVersion := 'riskviewattrv5';

DataRestrictionMask := '100001000100010000000000'; // to restrict fares, experian, transunion and experian FCRA 
OverrideHistoryDate := 0; // Set to 0 or -1 to use the history date located on our inputFile, set to anything else to use this historydate

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
END;

inputData := IF(recordsToRun > 0, CHOOSEN(DATASET(inputFile, prii_layout, CSV(QUOTE('"'))), recordsToRun),
																	DATASET(inputFile, prii_layout, CSV(QUOTE('"'))));

OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Raw_Input'));

soapLayout := RECORD
	DATASET(iesp.riskview2.t_RiskView2Request) RiskView2Request := DATASET([], iesp.riskview2.t_RiskView2Request);
	STRING HistoryDateTimeStamp := '';
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	boolean FilterLiens;
END;

soapLayout intoSOAP(inputData le, UNSIGNED4 c) := TRANSFORM
	self.filterLiens := false;  // temporary input option, RQ-12867
	
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
						self.seq := le.AccountNumber;
						SELF.Name := name;
						SELF.Address := address;
						SELF.DOB := dob;
						SELF.SSN := le.SSN;
						SELF.DriverLicenseNumber := le.DLNumber;
						SELF.DriverLicenseState := le.DLState;
						SELF.HomePhone := le.HomePhone;
						SELF.WorkPhone := le.WorkPhone;
						SELF := []));
	
	models := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Models,
						SELF.Names := IF(model1 <> '', DATASET([{model1}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) + 
													IF(model2 <> '', DATASET([{model2}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model3 <> '', DATASET([{model3}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model4 <> '', DATASET([{model4}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) +
													IF(model5 <> '', DATASET([{model5}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem));
						SELF.ModelOptions := DATASET([], iesp.riskview_share.t_ModelOptionRV);
						SELF := []));
	option := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Options,
						SELF.IncludeModels := models[1];
						SELF.AttributesVersionRequest := attributesVersion;
						SELF.IncludeReport := FALSE; // Never request the Report
						SELF.IntendedPurpose := intendedPurpose;
						SELF := []));
	
	users := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User,
						SELF.DataRestrictionMask := DataRestrictionMask;
						SELF.AccountNumber := IF(le.AccountNumber <> '', le.AccountNumber, (STRING)c);
						SELF.TestDataEnabled := FALSE;
						SELF.OutcomeTrackingOptOut := TRUE;
						SELF := []));
	
	SELF.RiskView2Request := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Request, 
						SELF.SearchBy := search[1];
						SELF.Options := option[1];
						SELF.User := users[1];
						SELF := []));
	
	SELF.HistoryDateTimeStamp := '';

	SELF.Gateways := PROJECT(ut.ds_oneRecord, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'neutralroxie'; SELF.URL := NeutralRoxieIP; SELF := []));
END;

soapInput := DISTRIBUTE(PROJECT(inputData, intoSOAP(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(soapInput, eyeball), NAMED('Sample_SOAP_Input'));

xlayout := RECORD
	iesp.riskview2.t_RiskView2Response;
	STRING errorcode;
END;

xlayout myFail(soapInput le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

soapResults_raw := SOAPCALL(soapInput, 
				FCRARoxieIP,
				'RiskView.Search_Service', 
				{soapInput}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500),
        // XPATH('riskview.search_serviceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

soapResults := soapResults_raw(Result.inputEcho.seq<>'');  // filter out the intermediate logging rows from the response
				
OUTPUT(CHOOSEN(soapResults, eyeball), NAMED('Sample_SOAP_Results'));
validResults := soapResults (errorcode = '');
failedResults := soapResults (errorcode <> '');

OUTPUT(COUNT(validResults), NAMED('Total_Passed'));
OUTPUT(CHOOSEN(validResults, eyeball), NAMED('Sample_Passed_Results'));

OUTPUT(COUNT(failedResults), NAMED('Total_Failed'));
OUTPUT(CHOOSEN(failedResults, eyeball), NAMED('Sample_Failed_Results'));


roxie_output_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	riskview.layouts.layout_riskview5_batch_response;
	STRING errorcode;
END;

flattened_result := project(soapResults, transform(roxie_output_layout,
	self.acctno := left.result.inputecho.seq,
	self.LexID := left.result.UniqueId;

	auto_model := left.result.models(stringlib.stringtolowercase(name)[1..4]='auto');
	bankcard_model := left.result.models(stringlib.stringtolowercase(name)[1..4]='bank');
	short_term_lending_model := left.result.models(stringlib.stringtolowercase(name)[1..5]='short');
	Telecommunications_model := left.result.models(stringlib.stringtolowercase(name)[1..7]='telecom');
	
	self.Auto_Index := '';
	self.Auto_Score_Name := auto_model[1].name;
	self.Auto_score := (string)auto_model[1].scores[1].value;
	self.Auto_reason1 := auto_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
	self.Auto_reason2 := auto_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
	self.Auto_reason3 := auto_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
	self.Auto_reason4 := auto_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
	self.Auto_reason5 := auto_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
	
	self.Bankcard_Index := '';	
	self.BankCard_Score_Name := BankCard_model[1].name;
	self.BankCard_score := (string)BankCard_model[1].scores[1].value;
	self.BankCard_reason1 := BankCard_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
	self.BankCard_reason2 := BankCard_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
	self.BankCard_reason3 := BankCard_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
	self.BankCard_reason4 := BankCard_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
	self.BankCard_reason5 := BankCard_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
	
	self.short_term_lending_Index := '';	
	self.short_term_lending_Score_Name := short_term_lending_model[1].name;
	self.short_term_lending_score := (string)short_term_lending_model[1].scores[1].value;
	self.short_term_lending_reason1 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
	self.short_term_lending_reason2 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
	self.short_term_lending_reason3 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
	self.short_term_lending_reason4 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
	self.short_term_lending_reason5 := short_term_lending_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
	
	self.Telecommunications_Index := '';	
	self.Telecommunications_Score_Name := Telecommunications_model[1].name;
	self.Telecommunications_score := (string)Telecommunications_model[1].scores[1].value;
	self.Telecommunications_reason1 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
	self.Telecommunications_reason2 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
	self.Telecommunications_reason3 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
	self.Telecommunications_reason4 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
	self.Telecommunications_reason5 := Telecommunications_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;
	
		// fill in the custom score stuff later
	self.Custom_Index := '';
	self.Custom_Score_Name := '';
	self.Custom_score := '';
	self.Custom_reason1 := '';
	self.Custom_reason2 := '';
	self.Custom_reason3 := '';
	self.Custom_reason4 := '';
	self.Custom_reason5 := '';
	
	self.Attribute_Index := '0';  // initial version of the attributes is index 0
	self.InputProvidedFirstName := left.result.AttributesGroup.attributes(name='InputProvidedFirstName')[1].value;
	self.InputProvidedLastName := left.result.AttributesGroup.attributes(name='InputProvidedLastName')[1].value;
	self.InputProvidedStreetAddress := left.result.AttributesGroup.attributes(name='InputProvidedStreetAddress')[1].value;
	self.InputProvidedCity := left.result.AttributesGroup.attributes(name='InputProvidedCity')[1].value;
	self.InputProvidedState := left.result.AttributesGroup.attributes(name='InputProvidedState')[1].value;
	self.InputProvidedZipCode := left.result.AttributesGroup.attributes(name='InputProvidedZipCode')[1].value;
	self.InputProvidedSSN := left.result.AttributesGroup.attributes(name='InputProvidedSSN')[1].value;
	self.InputProvidedDateofBirth := left.result.AttributesGroup.attributes(name='InputProvidedDateofBirth')[1].value;
	self.InputProvidedPhone := left.result.AttributesGroup.attributes(name='InputProvidedPhone')[1].value;
	self.InputProvidedLexID := left.result.AttributesGroup.attributes(name='InputProvidedLexID')[1].value;
	self.SubjectRecordTimeOldest := left.result.AttributesGroup.attributes(name='SubjectRecordTimeOldest')[1].value;
	self.SubjectRecordTimeNewest := left.result.AttributesGroup.attributes(name='SubjectRecordTimeNewest')[1].value;
	self.SubjectNewestRecord12Month := left.result.AttributesGroup.attributes(name='SubjectNewestRecord12Month')[1].value;
	self.SubjectActivityIndex03Month := left.result.AttributesGroup.attributes(name='SubjectActivityIndex03Month')[1].value;
	self.SubjectActivityIndex06Month := left.result.AttributesGroup.attributes(name='SubjectActivityIndex06Month')[1].value;
	self.SubjectActivityIndex12Month := left.result.AttributesGroup.attributes(name='SubjectActivityIndex12Month')[1].value;
	self.SubjectAge := left.result.AttributesGroup.attributes(name='SubjectAge')[1].value;
	self.SubjectDeceased := left.result.AttributesGroup.attributes(name='SubjectDeceased')[1].value;
	self.SubjectSSNCount := left.result.AttributesGroup.attributes(name='SubjectSSNCount')[1].value;
	self.SubjectStabilityIndex := left.result.AttributesGroup.attributes(name='SubjectStabilityIndex')[1].value;
	self.SubjectStabilityPrimaryFactor := left.result.AttributesGroup.attributes(name='SubjectStabilityPrimaryFactor')[1].value;
	self.SubjectAbilityIndex := left.result.AttributesGroup.attributes(name='SubjectAbilityIndex')[1].value;
	self.SubjectAbilityPrimaryFactor := left.result.AttributesGroup.attributes(name='SubjectAbilityPrimaryFactor')[1].value;
	self.SubjectWillingnessIndex := left.result.AttributesGroup.attributes(name='SubjectWillingnessIndex')[1].value;
	self.SubjectWillingnessPrimaryFactor := left.result.AttributesGroup.attributes(name='SubjectWillingnessPrimaryFactor')[1].value;
	self.ConfirmationSubjectFound := left.result.AttributesGroup.attributes(name='ConfirmationSubjectFound')[1].value;
	self.ConfirmationInputName := left.result.AttributesGroup.attributes(name='ConfirmationInputName')[1].value;
	self.ConfirmationInputDOB := left.result.AttributesGroup.attributes(name='ConfirmationInputDOB')[1].value;
	self.ConfirmationInputSSN := left.result.AttributesGroup.attributes(name='ConfirmationInputSSN')[1].value;
	self.ConfirmationInputAddress := left.result.AttributesGroup.attributes(name='ConfirmationInputAddress')[1].value;
	self.SourceNonDerogProfileIndex := left.result.AttributesGroup.attributes(name='SourceNonDerogProfileIndex')[1].value;
	self.SourceNonDerogCount := left.result.AttributesGroup.attributes(name='SourceNonDerogCount')[1].value;
	self.SourceNonDerogCount03Month := left.result.AttributesGroup.attributes(name='SourceNonDerogCount03Month')[1].value;
	self.SourceNonDerogCount06Month := left.result.AttributesGroup.attributes(name='SourceNonDerogCount06Month')[1].value;
	self.SourceNonDerogCount12Month := left.result.AttributesGroup.attributes(name='SourceNonDerogCount12Month')[1].value;
	self.SourceCredHeaderTimeOldest := left.result.AttributesGroup.attributes(name='SourceCredHeaderTimeOldest')[1].value;
	self.SourceCredHeaderTimeNewest := left.result.AttributesGroup.attributes(name='SourceCredHeaderTimeNewest')[1].value;
	self.SourceVoterRegistration := left.result.AttributesGroup.attributes(name='SourceVoterRegistration')[1].value;
	self.EducationAttendance := left.result.AttributesGroup.attributes(name='EducationAttendance')[1].value;
	self.EducationEvidence := left.result.AttributesGroup.attributes(name='EducationEvidence')[1].value;
	self.EducationProgramAttended := left.result.AttributesGroup.attributes(name='EducationProgramAttended')[1].value;
	self.EducationInstitutionPrivate := left.result.AttributesGroup.attributes(name='EducationInstitutionPrivate')[1].value;
	self.EducationInstitutionRating := left.result.AttributesGroup.attributes(name='EducationInstitutionRating')[1].value;
	self.ProfLicCount := left.result.AttributesGroup.attributes(name='ProfLicCount')[1].value;
	self.ProfLicTypeCategory := left.result.AttributesGroup.attributes(name='ProfLicTypeCategory')[1].value;
	self.BusinessAssociation := left.result.AttributesGroup.attributes(name='BusinessAssociation')[1].value;
	self.BusinessAssociationIndex := left.result.AttributesGroup.attributes(name='BusinessAssociationIndex')[1].value;
	self.BusinessAssociationTimeOldest := left.result.AttributesGroup.attributes(name='BusinessAssociationTimeOldest')[1].value;
	self.BusinessTitleLeadership := left.result.AttributesGroup.attributes(name='BusinessTitleLeadership')[1].value;
	self.AssetIndex := left.result.AttributesGroup.attributes(name='AssetIndex')[1].value;
	self.AssetIndexPrimaryFactor := left.result.AttributesGroup.attributes(name='AssetIndexPrimaryFactor')[1].value;
	self.AssetOwnership := left.result.AttributesGroup.attributes(name='AssetOwnership')[1].value;
	self.AssetProp := left.result.AttributesGroup.attributes(name='AssetProp')[1].value;
	self.AssetPropIndex := left.result.AttributesGroup.attributes(name='AssetPropIndex')[1].value;
	self.AssetPropEverCount := left.result.AttributesGroup.attributes(name='AssetPropEverCount')[1].value;
	self.AssetPropCurrentCount := left.result.AttributesGroup.attributes(name='AssetPropCurrentCount')[1].value;
	self.AssetPropCurrentTaxTotal := left.result.AttributesGroup.attributes(name='AssetPropCurrentTaxTotal')[1].value;
	self.AssetPropPurchaseCount12Month := left.result.AttributesGroup.attributes(name='AssetPropPurchaseCount12Month')[1].value;
	self.AssetPropPurchaseTimeOldest := left.result.AttributesGroup.attributes(name='AssetPropPurchaseTimeOldest')[1].value;
	self.AssetPropPurchaseTimeNewest := left.result.AttributesGroup.attributes(name='AssetPropPurchaseTimeNewest')[1].value;
	self.AssetPropNewestMortgageType := left.result.AttributesGroup.attributes(name='AssetPropNewestMortgageType')[1].value;
	self.AssetPropEverSoldCount := left.result.AttributesGroup.attributes(name='AssetPropEverSoldCount')[1].value;
	self.AssetPropSoldCount12Month := left.result.AttributesGroup.attributes(name='AssetPropSoldCount12Month')[1].value;
	self.AssetPropSaleTimeOldest := left.result.AttributesGroup.attributes(name='AssetPropSaleTimeOldest')[1].value;
	self.AssetPropSaleTimeNewest := left.result.AttributesGroup.attributes(name='AssetPropSaleTimeNewest')[1].value;
	self.AssetPropNewestSalePrice := left.result.AttributesGroup.attributes(name='AssetPropNewestSalePrice')[1].value;
	self.AssetPropSalePurchaseRatio := left.result.AttributesGroup.attributes(name='AssetPropSalePurchaseRatio')[1].value;
	self.AssetPersonal := left.result.AttributesGroup.attributes(name='AssetPersonal')[1].value;
	self.AssetPersonalCount := left.result.AttributesGroup.attributes(name='AssetPersonalCount')[1].value;
	self.PurchaseActivityIndex := left.result.AttributesGroup.attributes(name='PurchaseActivityIndex')[1].value;
	self.PurchaseActivityCount := left.result.AttributesGroup.attributes(name='PurchaseActivityCount')[1].value;
	self.PurchaseActivityDollarTotal := left.result.AttributesGroup.attributes(name='PurchaseActivityDollarTotal')[1].value;
	self.DerogSeverityIndex := left.result.AttributesGroup.attributes(name='DerogSeverityIndex')[1].value;
	self.DerogCount := left.result.AttributesGroup.attributes(name='DerogCount')[1].value;
	self.DerogCount12Month := left.result.AttributesGroup.attributes(name='DerogCount12Month')[1].value;
	self.DerogTimeNewest := left.result.AttributesGroup.attributes(name='DerogTimeNewest')[1].value;
	self.CriminalFelonyCount := left.result.AttributesGroup.attributes(name='CriminalFelonyCount')[1].value;
	self.CriminalFelonyCount12Month := left.result.AttributesGroup.attributes(name='CriminalFelonyCount12Month')[1].value;
	self.CriminalFelonyTimeNewest := left.result.AttributesGroup.attributes(name='CriminalFelonyTimeNewest')[1].value;
	self.CriminalNonFelonyCount := left.result.AttributesGroup.attributes(name='CriminalNonFelonyCount')[1].value;
	self.CriminalNonFelonyCount12Month := left.result.AttributesGroup.attributes(name='CriminalNonFelonyCount12Month')[1].value;
	self.CriminalNonFelonyTimeNewest := left.result.AttributesGroup.attributes(name='CriminalNonFelonyTimeNewest')[1].value;
	self.EvictionCount := left.result.AttributesGroup.attributes(name='EvictionCount')[1].value;
	self.EvictionCount12Month := left.result.AttributesGroup.attributes(name='EvictionCount12Month')[1].value;
	self.EvictionTimeNewest := left.result.AttributesGroup.attributes(name='EvictionTimeNewest')[1].value;
	self.LienJudgmentSeverityIndex := left.result.AttributesGroup.attributes(name='LienJudgmentSeverityIndex')[1].value;
	self.LienJudgmentCount := left.result.AttributesGroup.attributes(name='LienJudgmentCount')[1].value;
	self.LienJudgmentCount12Month := left.result.AttributesGroup.attributes(name='LienJudgmentCount12Month')[1].value;
	self.LienJudgmentSmallClaimsCount := left.result.AttributesGroup.attributes(name='LienJudgmentSmallClaimsCount')[1].value;
	self.LienJudgmentCourtCount := left.result.AttributesGroup.attributes(name='LienJudgmentCourtCount')[1].value;
	self.LienJudgmentTaxCount := left.result.AttributesGroup.attributes(name='LienJudgmentTaxCount')[1].value;
	self.LienJudgmentForeclosureCount := left.result.AttributesGroup.attributes(name='LienJudgmentForeclosureCount')[1].value;
	self.LienJudgmentOtherCount := left.result.AttributesGroup.attributes(name='LienJudgmentOtherCount')[1].value;
	self.LienJudgmentTimeNewest := left.result.AttributesGroup.attributes(name='LienJudgmentTimeNewest')[1].value;
	self.LienJudgmentDollarTotal := left.result.AttributesGroup.attributes(name='LienJudgmentDollarTotal')[1].value;
	self.BankruptcyCount := left.result.AttributesGroup.attributes(name='BankruptcyCount')[1].value;
	self.BankruptcyCount24Month := left.result.AttributesGroup.attributes(name='BankruptcyCount24Month')[1].value;
	self.BankruptcyTimeNewest := left.result.AttributesGroup.attributes(name='BankruptcyTimeNewest')[1].value;
	self.BankruptcyChapter := left.result.AttributesGroup.attributes(name='BankruptcyChapter')[1].value;
	self.BankruptcyStatus := left.result.AttributesGroup.attributes(name='BankruptcyStatus')[1].value;
	self.BankruptcyDismissed24Month := left.result.AttributesGroup.attributes(name='BankruptcyDismissed24Month')[1].value;
	self.ShortTermLoanRequest := left.result.AttributesGroup.attributes(name='ShortTermLoanRequest')[1].value;
	self.ShortTermLoanRequest12Month := left.result.AttributesGroup.attributes(name='ShortTermLoanRequest12Month')[1].value;
	self.ShortTermLoanRequest24Month := left.result.AttributesGroup.attributes(name='ShortTermLoanRequest24Month')[1].value;
	self.InquiryAuto12Month := left.result.AttributesGroup.attributes(name='InquiryAuto12Month')[1].value;
	self.InquiryBanking12Month := left.result.AttributesGroup.attributes(name='InquiryBanking12Month')[1].value;
	self.InquiryTelcom12Month := left.result.AttributesGroup.attributes(name='InquiryTelcom12Month')[1].value;
	self.InquiryNonShortTerm12Month := left.result.AttributesGroup.attributes(name='InquiryNonShortTerm12Month')[1].value;
	self.InquiryShortTerm12Month := left.result.AttributesGroup.attributes(name='InquiryShortTerm12Month')[1].value;
	self.InquiryCollections12Month := left.result.AttributesGroup.attributes(name='InquiryCollections12Month')[1].value;
	self.SSNSubjectCount := left.result.AttributesGroup.attributes(name='SSNSubjectCount')[1].value;
	self.SSNDeceased := left.result.AttributesGroup.attributes(name='SSNDeceased')[1].value;
	self.SSNDateLowIssued := left.result.AttributesGroup.attributes(name='SSNDateLowIssued')[1].value;
	self.SSNProblems := left.result.AttributesGroup.attributes(name='SSNProblems')[1].value;
	self.AddrOnFileCount := left.result.AttributesGroup.attributes(name='AddrOnFileCount')[1].value;
	self.AddrOnFileCorrectional := left.result.AttributesGroup.attributes(name='AddrOnFileCorrectional')[1].value;
	self.AddrOnFileCollege := left.result.AttributesGroup.attributes(name='AddrOnFileCollege')[1].value;
	self.AddrOnFileHighRisk := left.result.AttributesGroup.attributes(name='AddrOnFileHighRisk')[1].value;
	self.AddrInputTimeOldest := left.result.AttributesGroup.attributes(name='AddrInputTimeOldest')[1].value;
	self.AddrInputTimeNewest := left.result.AttributesGroup.attributes(name='AddrInputTimeNewest')[1].value;
	self.AddrInputLengthOfRes := left.result.AttributesGroup.attributes(name='AddrInputLengthOfRes')[1].value;
	self.AddrInputSubjectCount := left.result.AttributesGroup.attributes(name='AddrInputSubjectCount')[1].value;
	self.AddrInputMatchIndex := left.result.AttributesGroup.attributes(name='AddrInputMatchIndex')[1].value;
	self.AddrInputSubjectOwned := left.result.AttributesGroup.attributes(name='AddrInputSubjectOwned')[1].value;
	self.AddrInputDeedMailing := left.result.AttributesGroup.attributes(name='AddrInputDeedMailing')[1].value;
	self.AddrInputOwnershipIndex := left.result.AttributesGroup.attributes(name='AddrInputOwnershipIndex')[1].value;
	self.AddrInputPhoneService := left.result.AttributesGroup.attributes(name='AddrInputPhoneService')[1].value;
	self.AddrInputPhoneCount := left.result.AttributesGroup.attributes(name='AddrInputPhoneCount')[1].value;
	self.AddrInputDwellType := left.result.AttributesGroup.attributes(name='AddrInputDwellType')[1].value;
	self.AddrInputDwellTypeIndex := left.result.AttributesGroup.attributes(name='AddrInputDwellTypeIndex')[1].value;
	self.AddrInputDelivery := left.result.AttributesGroup.attributes(name='AddrInputDelivery')[1].value;
	self.AddrInputTimeLastSale := left.result.AttributesGroup.attributes(name='AddrInputTimeLastSale')[1].value;
	self.AddrInputLastSalePrice := left.result.AttributesGroup.attributes(name='AddrInputLastSalePrice')[1].value;
	self.AddrInputTaxValue := left.result.AttributesGroup.attributes(name='AddrInputTaxValue')[1].value;
	self.AddrInputTaxYr := left.result.AttributesGroup.attributes(name='AddrInputTaxYr')[1].value;
	self.AddrInputTaxMarketValue := left.result.AttributesGroup.attributes(name='AddrInputTaxMarketValue')[1].value;
	self.AddrInputAVMValue := left.result.AttributesGroup.attributes(name='AddrInputAVMValue')[1].value;
	self.AddrInputAVMValue12Month := left.result.AttributesGroup.attributes(name='AddrInputAVMValue12Month')[1].value;
	self.AddrInputAVMRatio12MonthPrior := left.result.AttributesGroup.attributes(name='AddrInputAVMRatio12MonthPrior')[1].value;
	self.AddrInputAVMValue60Month := left.result.AttributesGroup.attributes(name='AddrInputAVMValue60Month')[1].value;
	self.AddrInputAVMRatio60MonthPrior := left.result.AttributesGroup.attributes(name='AddrInputAVMRatio60MonthPrior')[1].value;
	self.AddrInputCountyRatio := left.result.AttributesGroup.attributes(name='AddrInputCountyRatio')[1].value;
	self.AddrInputTractRatio := left.result.AttributesGroup.attributes(name='AddrInputTractRatio')[1].value;
	self.AddrInputBlockRatio := left.result.AttributesGroup.attributes(name='AddrInputBlockRatio')[1].value;
	self.AddrInputProblems := left.result.AttributesGroup.attributes(name='AddrInputProblems')[1].value;
	self.AddrCurrentTimeOldest := left.result.AttributesGroup.attributes(name='AddrCurrentTimeOldest')[1].value;
	self.AddrCurrentTimeNewest := left.result.AttributesGroup.attributes(name='AddrCurrentTimeNewest')[1].value;
	self.AddrCurrentLengthOfRes := left.result.AttributesGroup.attributes(name='AddrCurrentLengthOfRes')[1].value;
	self.AddrCurrentSubjectOwned := left.result.AttributesGroup.attributes(name='AddrCurrentSubjectOwned')[1].value;
	self.AddrCurrentDeedMailing := left.result.AttributesGroup.attributes(name='AddrCurrentDeedMailing')[1].value;
	self.AddrCurrentOwnershipIndex := left.result.AttributesGroup.attributes(name='AddrCurrentOwnershipIndex')[1].value;
	self.AddrCurrentPhoneService := left.result.AttributesGroup.attributes(name='AddrCurrentPhoneService')[1].value;
	self.AddrCurrentDwellType := left.result.AttributesGroup.attributes(name='AddrCurrentDwellType')[1].value;
	self.AddrCurrentDwellTypeIndex := left.result.AttributesGroup.attributes(name='AddrCurrentDwellTypeIndex')[1].value;
	self.AddrCurrentTimeLastSale := left.result.AttributesGroup.attributes(name='AddrCurrentTimeLastSale')[1].value;
	self.AddrCurrentLastSalesPrice := left.result.AttributesGroup.attributes(name='AddrCurrentLastSalesPrice')[1].value;
	self.AddrCurrentTaxValue := left.result.AttributesGroup.attributes(name='AddrCurrentTaxValue')[1].value;
	self.AddrCurrentTaxYr := left.result.AttributesGroup.attributes(name='AddrCurrentTaxYr')[1].value;
	self.AddrCurrentTaxMarketValue := left.result.AttributesGroup.attributes(name='AddrCurrentTaxMarketValue')[1].value;
	self.AddrCurrentAVMValue := left.result.AttributesGroup.attributes(name='AddrCurrentAVMValue')[1].value;
	self.AddrCurrentAVMValue12Month := left.result.AttributesGroup.attributes(name='AddrCurrentAVMValue12Month')[1].value;
	self.AddrCurrentAVMRatio12MonthPrior := left.result.AttributesGroup.attributes(name='AddrCurrentAVMRatio12MonthPrior')[1].value;
	self.AddrCurrentAVMValue60Month := left.result.AttributesGroup.attributes(name='AddrCurrentAVMValue60Month')[1].value;
	self.AddrCurrentAVMRatio60MonthPrior := left.result.AttributesGroup.attributes(name='AddrCurrentAVMRatio60MonthPrior')[1].value;
	self.AddrCurrentCountyRatio := left.result.AttributesGroup.attributes(name='AddrCurrentCountyRatio')[1].value;
	self.AddrCurrentTractRatio := left.result.AttributesGroup.attributes(name='AddrCurrentTractRatio')[1].value;
	self.AddrCurrentBlockRatio := left.result.AttributesGroup.attributes(name='AddrCurrentBlockRatio')[1].value;
	self.AddrCurrentCorrectional := left.result.AttributesGroup.attributes(name='AddrCurrentCorrectional')[1].value;
	self.AddrPreviousTimeOldest := left.result.AttributesGroup.attributes(name='AddrPreviousTimeOldest')[1].value;
	self.AddrPreviousTimeNewest := left.result.AttributesGroup.attributes(name='AddrPreviousTimeNewest')[1].value;
	self.AddrPreviousLengthOfRes := left.result.AttributesGroup.attributes(name='AddrPreviousLengthOfRes')[1].value;
	self.AddrPreviousSubjectOwned := left.result.AttributesGroup.attributes(name='AddrPreviousSubjectOwned')[1].value;
	self.AddrPreviousOwnershipIndex := left.result.AttributesGroup.attributes(name='AddrPreviousOwnershipIndex')[1].value;
	self.AddrPreviousDwellType := left.result.AttributesGroup.attributes(name='AddrPreviousDwellType')[1].value;
	self.AddrPreviousDwellTypeIndex := left.result.AttributesGroup.attributes(name='AddrPreviousDwellTypeIndex')[1].value;
	self.AddrPreviousCorrectional := left.result.AttributesGroup.attributes(name='AddrPreviousCorrectional')[1].value;
	self.AddrStabilityIndex := left.result.AttributesGroup.attributes(name='AddrStabilityIndex')[1].value;
	self.AddrChangeCount03Month := left.result.AttributesGroup.attributes(name='AddrChangeCount03Month')[1].value;
	self.AddrChangeCount06Month := left.result.AttributesGroup.attributes(name='AddrChangeCount06Month')[1].value;
	self.AddrChangeCount12Month := left.result.AttributesGroup.attributes(name='AddrChangeCount12Month')[1].value;
	self.AddrChangeCount24Month := left.result.AttributesGroup.attributes(name='AddrChangeCount24Month')[1].value;
	self.AddrChangeCount60Month := left.result.AttributesGroup.attributes(name='AddrChangeCount60Month')[1].value;
	self.AddrLastMoveTaxRatioDiff := left.result.AttributesGroup.attributes(name='AddrLastMoveTaxRatioDiff')[1].value;
	self.AddrLastMoveEconTrajectory := left.result.AttributesGroup.attributes(name='AddrLastMoveEconTrajectory')[1].value;
	self.AddrLastMoveEconTrajectoryIndex := left.result.AttributesGroup.attributes(name='AddrLastMoveEconTrajectoryIndex')[1].value;
	self.PhoneInputProblems := left.result.AttributesGroup.attributes(name='PhoneInputProblems')[1].value;
	self.PhoneInputSubjectCount := left.result.AttributesGroup.attributes(name='PhoneInputSubjectCount')[1].value;
	self.PhoneInputMobile := left.result.AttributesGroup.attributes(name='PhoneInputMobile')[1].value;
	self.AlertRegulatoryCondition := left.result.AttributesGroup.attributes(name='AlertRegulatoryCondition')[1].value;
	
	self.Alert1 := left.result.alerts[1].code;
	self.Alert2 := left.result.alerts[2].code;
	self.Alert3 := left.result.alerts[3].code;
	self.Alert4 := left.result.alerts[4].code;
	self.Alert5 := left.result.alerts[5].code;
	self.Alert6 := left.result.alerts[6].code;
	self.Alert7 := left.result.alerts[7].code;
	self.Alert8 := left.result.alerts[8].code;
	self.Alert9 := left.result.alerts[9].code;
	self.Alert10 := left.result.alerts[10].code;
	
	self.ConsumerStatementText := left.result.Report.ConsumerStatement;
	
	self := left;
	self := []));
	
output(choosen(flattened_result, eyeball), named('flattened_result'));
output(flattened_result,,outfile_name, CSV(heading(single), quote('"')));
