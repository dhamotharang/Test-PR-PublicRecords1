EXPORT RV_Scores_Attributes_V5_XML_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO
IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT, Gateway;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
    gateways := Gateway;

		//*********** SETTINGS ********************************

		DataRestrictionMask:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V5_XML_Generic_settings.DRM;
		isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V5_XML_Generic_settings.isFCRA=true,'FCRA','NONFCRA');
		
		// PCG_Dev := 'http://delta_dempers_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		PCG_Cert := 'http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		integer FFD := 1;	
		
		
		AttributesVersion := 'riskviewattrv5';
    intendedPurpose := '';// Turn on the PRESCREENING intended purpose if this customer will be running in prescreen mode 
		
    // models		
		model1 := 'RVG1502_0'; 
		model2 := 'RVB1503_0'; 
		model3 := 'RVA1503_0'; 
		model4 := 'RVT1503_0'; 
		model5 := 'RVS1706_0'; 
		
		HistoryDate := 999999;
		
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);
																	
		//*********** RV Attributes V5 XML SETUP AND SOAPCALL ******************

		soapLayout := RECORD
			DATASET(iesp.riskview2.t_RiskView2Request) RiskView2Request := DATASET([], iesp.riskview2.t_RiskView2Request);
			STRING HistoryDateTimeStamp := '';
			// DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways := DATASET([], Risk_Indicators.Layout_Gateways_In);
		END;

		soapLayout intoSOAP(ds_raw_input le, UNSIGNED4 c) := TRANSFORM
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
								self.seq := (string)le.AccountNumber;
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
															IF(model5 <> '', DATASET([{model5}], iesp.share.t_StringArrayItem), DATASET([], iesp.share.t_StringArrayItem)) ;
															
								SELF.ModelOptions := DATASET([], iesp.riskview_share.t_ModelOptionRV);
								SELF := []));
			option := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Options,
								SELF.IncludeModels := models[1];
								SELF.AttributesVersionRequest := AttributesVersion;
								SELF.IncludeReport := FALSE; 
								self.FFDOptionsMask := (string)FFD;
								SELF.IntendedPurpose := intendedPurpose;
								SELF := []));
			
			users := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User,
								SELF.DataRestrictionMask := DataRestrictionMask;
								SELF.AccountNumber := (STRING) le.AccountNumber;
								SELF.TestDataEnabled := FALSE;
								SELF.OutcomeTrackingOptOut := TRUE;
								SELF := []));
			
			SELF.RiskView2Request := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.riskview2.t_RiskView2Request, 
								SELF.SearchBy := search[1];
								SELF.Options := option[1];
								SELF.User := users[1];
								SELF := []));
			
			SELF.HistoryDateTimeStamp := (string)HistoryDate;

			// SELF.Gateways := PROJECT(ut.ds_oneRecord, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'neutralroxie'; SELF.URL := NeutralRoxieIP; SELF := []));
			SELF.Gateways := DATASET([{'neutralroxie', NeutralRoxieIP}, // TransUnion Gateway
														{'delta_personcontext', PCG_Cert}], Risk_Indicators.Layout_Gateways_In);
		END;

	  //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, intoSOAP(LEFT, COUNTER)), RANDOM());
		
		//Soap output layout		
		layout_Soap_output := RECORD
			unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
			iesp.riskview2.t_RiskView2Response;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			self.result.inputecho.seq := le.riskview2request[1].SearchBy.seq;
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;

	  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := SOAPCALL(soap_in, 
						FCRARoxieIP,
						'RiskView.Search_Service', 
						{soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(RETRY), TIMEOUT(timeout),
						PARALLEL(threads), onFail(myFail(LEFT)));
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout;	
		END;

    //Mapping Version5 attributes 	
		flattened_result := project(Soap_output, transform(Global_output_lay,
			self.time_ms := left.time_ms;			
			self.accountnumber := left.result.inputecho.seq,
			self.acctno := left.result.inputecho.seq,
			self.did := (integer)left.result.UniqueId;

			auto_model := left.result.models(stringlib.stringtolowercase(name)[1..4]='auto');
			bankcard_model := left.result.models(stringlib.stringtolowercase(name)[1..4]='bank');
			short_term_lending_model := left.result.models(stringlib.stringtolowercase(name)[1..5]='short');
			Telecommunications_model := left.result.models(stringlib.stringtolowercase(name)[1..7]='telecom');
			Crossindustry_model := left.result.models(stringlib.stringtolowercase(name)[1..5]='cross');
			
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
			
			self.Crossindustry_Index := '';	
			self.Crossindustry_Score_Name := Crossindustry_model[1].name;
			self.Crossindustry_score := (string)Crossindustry_model[1].scores[1].value;
			self.Crossindustry_reason1 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=1)[1].ReasonCode;
			self.Crossindustry_reason2 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=2)[1].ReasonCode;
			self.Crossindustry_reason3 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=3)[1].ReasonCode;
			self.Crossindustry_reason4 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=4)[1].ReasonCode;
			self.Crossindustry_reason5 := Crossindustry_model[1].scores[1].ScoreReasons(sequence=5)[1].ReasonCode;


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
			// self.errorcode := left.result.errorcode;
			self := left;
			self := []));		

	  //Appeding internal extras to Soap output file 
		Global_output_lay normit(flattened_result L, soap_in R) := TRANSFORM
			self.historydate := (STRING)r.HistoryDateTimeStamp;
			self.FNamePop := r.RiskView2Request[1].SearchBy.Name.First<>'';
			self.LNamePop := r.RiskView2Request[1].SearchBy.Name.Last<>'';
			self.AddrPop := r.RiskView2Request[1].SearchBy.Address.StreetAddress1<>'';
			self.SSNLength := (STRING)(length(trim(r.RiskView2Request[1].SearchBy.ssn,left,right))) ;
			self.DOBPop := r.RiskView2Request[1].SearchBy.dob.year<>0 and r.RiskView2Request[1].SearchBy.dob.year<>0 and r.RiskView2Request[1].SearchBy.dob.year<>0 ;
			self.IPAddrPop := r.RiskView2Request[1].SearchBy.ipaddress<>'';
			self.HPhnPop := r.RiskView2Request[1].SearchBy.HomePhone<>'';
		  self := L;
			self := [];
		END;
				 
		ds_with_extras := JOIN(flattened_result,soap_in,LEFT.accountnumber=(STRING)RIGHT.RiskView2Request[1].user.accountnumber,normit(LEFT,RIGHT));

		//final file out to thor
		final_output := output(ds_with_extras ,,outfile_name, thor, compressed, overwrite);
		
		// output(Soap_output,named('Soap_output'));
		// output(soap_in,named('soap_in'));
		
		RETURN final_output;
ENDMACRO; 