import Models, Risk_Indicators, RiskView, Seed_Files, iesp;

export TestSeed_Function(DATASET(Risk_Indicators.Layout_Input) inData, 
												STRING32 TestDataTableName_in, 
												STRING AttributesVersionRequest,
												STRING Auto_Model_Name,
												STRING Bankcard_Model_Name,
												STRING Short_Term_Lending_Model_Name,
												STRING Telecommunications_Model_Name,
												STRING Custom_Model_Name,
												STRING Custom2_Model_Name,
												STRING Custom3_Model_Name,
												STRING Custom4_Model_Name,
												STRING Custom5_Model_Name,
												STRING Intended_Purpose,
												STRING prescreen_score_threshold,
												BOOLEAN run_report, BOOLEAN lnjattributes_requested) := FUNCTION

	SeedKey := Seed_Files.Key_RiskView2;
	
	model_info := Models.LIB_RiskView_Models().ValidV50Models; // Grab the valid models, output model name, billing index and model type
	valid_model_names := SET(model_info, Model_Name);
	valid_attributes := RiskView.Constants.valid_attributes;
	
	isPreScreenPurpose := StringLib.StringToUpperCase(Intended_Purpose) = 'PRESCREENING';
	isCollectionsPurpose := StringLib.StringToUpperCase(Intended_Purpose) = 'COLLECTIONS';
	
// Get TestSeed Results
RiskView.Layouts.Layout_RiskView5_Search_Results getSeed(Risk_Indicators.Layout_Input le, SeedKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		
		SELF.LexID := ri.LexID;
		
		auto_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Auto_Model_Name, LEFT, RIGHT)))[1];
		valid_auto := Auto_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Auto_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Auto_Index := if(valid_auto, (STRING)auto_info.Billing_Index, '');
		SELF.Auto_Score_Name := if(valid_auto, auto_info.Output_Model_Name, '');
		SELF.Auto_Type := if(valid_auto, auto_info.Model_Type, '');
		SELF.Auto_score := if(valid_auto, ri.auto_score, '');
		SELF.Auto_reason1 := if(valid_auto AND NOT isPreScreenPurpose AND ri.auto_reason1 <> '00', ri.auto_reason1, '');
		SELF.Auto_reason2 := if(valid_auto AND NOT isPreScreenPurpose AND ri.auto_reason2 <> '00', ri.auto_reason2, '');
		SELF.Auto_reason3 := if(valid_auto AND NOT isPreScreenPurpose AND ri.auto_reason3 <> '00', ri.auto_reason3, '');
		SELF.Auto_reason4 := if(valid_auto AND NOT isPreScreenPurpose AND ri.auto_reason4 <> '00', ri.auto_reason4, '');
		SELF.Auto_reason5 := if(valid_auto AND NOT isPreScreenPurpose AND ri.auto_reason5 <> '00', ri.auto_reason5, '');
		
		Bankcard_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Bankcard_Model_Name, LEFT, RIGHT)))[1];
		valid_Bankcard := Bankcard_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Bankcard_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Bankcard_Index := if(valid_Bankcard, (STRING)Bankcard_info.Billing_Index, '');
		SELF.Bankcard_Score_Name := if(valid_Bankcard, Bankcard_info.Output_Model_Name, '');
		SELF.Bankcard_Type := if(valid_Bankcard, Bankcard_info.Model_Type, '');
		SELF.Bankcard_score := if(valid_Bankcard, ri.Bankcard_score, '');
		SELF.Bankcard_reason1 := if(valid_Bankcard AND NOT isPreScreenPurpose AND ri.Bankcard_reason1 <> '00', ri.Bankcard_reason1, '');
		SELF.Bankcard_reason2 := if(valid_Bankcard AND NOT isPreScreenPurpose AND ri.Bankcard_reason2 <> '00', ri.Bankcard_reason2, '');
		SELF.Bankcard_reason3 := if(valid_Bankcard AND NOT isPreScreenPurpose AND ri.Bankcard_reason3 <> '00', ri.Bankcard_reason3, '');
		SELF.Bankcard_reason4 := if(valid_Bankcard AND NOT isPreScreenPurpose AND ri.Bankcard_reason4 <> '00', ri.Bankcard_reason4, '');
		SELF.Bankcard_reason5 := if(valid_Bankcard AND NOT isPreScreenPurpose AND ri.Bankcard_reason5 <> '00', ri.Bankcard_reason5, '');

		Short_Term_Lending_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Short_Term_Lending_Model_Name, LEFT, RIGHT)))[1];
		valid_Short_Term_Lending := Short_Term_Lending_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Short_Term_Lending_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Short_term_lending_Index := if(valid_Short_Term_Lending, (STRING)Short_Term_Lending_info.Billing_Index, '');
		SELF.Short_Term_Lending_Score_Name := if(valid_Short_Term_Lending, Short_Term_Lending_info.Output_Model_Name, '');
		SELF.Short_Term_Lending_Type := if(valid_Short_Term_Lending, Short_Term_Lending_info.Model_Type, '');
		SELF.Short_Term_Lending_score := if(valid_Short_Term_Lending, ri.Short_Term_Lending_score, '');
		SELF.Short_Term_Lending_reason1 := if(valid_Short_Term_Lending AND NOT isPreScreenPurpose AND ri.short_term_lending_reason1 <> '00', ri.short_term_lending_reason1, '');
		SELF.Short_Term_Lending_reason2 := if(valid_Short_Term_Lending AND NOT isPreScreenPurpose AND ri.short_term_lending_reason2 <> '00', ri.short_term_lending_reason2, '');
		SELF.Short_Term_Lending_reason3 := if(valid_Short_Term_Lending AND NOT isPreScreenPurpose AND ri.short_term_lending_reason3 <> '00', ri.short_term_lending_reason3, '');
		SELF.Short_Term_Lending_reason4 := if(valid_Short_Term_Lending AND NOT isPreScreenPurpose AND ri.short_term_lending_reason4 <> '00', ri.short_term_lending_reason4, '');
		SELF.Short_Term_Lending_reason5 := if(valid_Short_Term_Lending AND NOT isPreScreenPurpose AND ri.short_term_lending_reason5 <> '00', ri.short_term_lending_reason5, '');

		Telecommunications_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Telecommunications_Model_Name, LEFT, RIGHT)))[1];
		valid_Telecommunications := Telecommunications_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Telecommunications_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Telecommunications_Index := if(valid_Telecommunications, (STRING)Telecommunications_info.Billing_Index, '');
		SELF.Telecommunications_Score_Name := if(valid_Telecommunications, Telecommunications_info.Output_Model_Name, '');
		SELF.Telecommunications_Type := if(valid_Telecommunications, Telecommunications_info.Model_Type, '');
		SELF.Telecommunications_score := if(valid_Telecommunications, ri.Telecommunications_score, '');
		SELF.Telecommunications_reason1 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND ri.telecommunications_reason1 <> '00', ri.telecommunications_reason1, '');
		SELF.Telecommunications_reason2 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND ri.telecommunications_reason2 <> '00', ri.telecommunications_reason2, '');
		SELF.Telecommunications_reason3 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND ri.telecommunications_reason3 <> '00', ri.telecommunications_reason3, '');
		SELF.Telecommunications_reason4 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND ri.telecommunications_reason4 <> '00', ri.telecommunications_reason4, '');
		SELF.Telecommunications_reason5 := if(valid_Telecommunications AND NOT isPreScreenPurpose AND ri.telecommunications_reason5 <> '00', ri.telecommunications_reason5, '');

		Custom_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Custom_Model_Name, LEFT, RIGHT)))[1];
		valid_Custom := Custom_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Custom_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Custom_Index := if(valid_Custom, (STRING)Custom_info.Billing_Index, '');
		SELF.Custom_Score_Name := if(valid_Custom, Custom_info.Output_Model_Name, '');
		SELF.Custom_Type := if(valid_Custom, Custom_info.Model_Type, '');
		SELF.Custom_score := if(valid_Custom, ri.Custom_score, '');
		SELF.Custom_reason1 := if(valid_Custom AND NOT isPreScreenPurpose AND ri.custom_reason1 <> '00', ri.custom_reason1, '');
		SELF.Custom_reason2 := if(valid_Custom AND NOT isPreScreenPurpose AND ri.custom_reason2 <> '00', ri.custom_reason2, '');
		SELF.Custom_reason3 := if(valid_Custom AND NOT isPreScreenPurpose AND ri.custom_reason3 <> '00', ri.custom_reason3, '');
		SELF.Custom_reason4 := if(valid_Custom AND NOT isPreScreenPurpose AND ri.custom_reason4 <> '00', ri.custom_reason4, '');
		SELF.Custom_reason5 := if(valid_Custom AND NOT isPreScreenPurpose AND ri.custom_reason5 <> '00', ri.custom_reason5, '');

		Custom2_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Custom2_Model_Name, LEFT, RIGHT)))[1];
		valid_Custom2 := Custom2_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Custom2_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Custom2_Index := if(valid_Custom2, (STRING)Custom2_info.Billing_Index, '');
		SELF.Custom2_Score_Name := if(valid_Custom2, Custom2_info.Output_Model_Name, '');
		SELF.Custom2_Type := if(valid_Custom2, Custom2_info.Model_Type, '');
		SELF.Custom2_score := if(valid_Custom2, ri.Custom2_score, '');
		SELF.Custom2_reason1 := if(valid_Custom2 AND NOT isPreScreenPurpose AND ri.custom2_reason1 <> '00', ri.custom2_reason1, '');
		SELF.Custom2_reason2 := if(valid_Custom2 AND NOT isPreScreenPurpose AND ri.custom2_reason2 <> '00', ri.custom2_reason2, '');
		SELF.Custom2_reason3 := if(valid_Custom2 AND NOT isPreScreenPurpose AND ri.custom2_reason3 <> '00', ri.custom2_reason3, '');
		SELF.Custom2_reason4 := if(valid_Custom2 AND NOT isPreScreenPurpose AND ri.custom2_reason4 <> '00', ri.custom2_reason4, '');
		SELF.Custom2_reason5 := if(valid_Custom2 AND NOT isPreScreenPurpose AND ri.custom2_reason5 <> '00', ri.custom2_reason5, '');

		Custom3_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Custom3_Model_Name, LEFT, RIGHT)))[1];
		valid_Custom3 := Custom3_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Custom3_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Custom3_Index := if(valid_Custom3, (STRING)Custom3_info.Billing_Index, '');
		SELF.Custom3_Score_Name := if(valid_Custom3, Custom3_info.Output_Model_Name, '');
		SELF.Custom3_Type := if(valid_Custom3, Custom3_info.Model_Type, '');
		SELF.Custom3_score := if(valid_Custom3, ri.Custom3_score, '');
		SELF.Custom3_reason1 := if(valid_Custom3 AND NOT isPreScreenPurpose AND ri.custom3_reason1 <> '00', ri.custom3_reason1, '');
		SELF.Custom3_reason2 := if(valid_Custom3 AND NOT isPreScreenPurpose AND ri.custom3_reason2 <> '00', ri.custom3_reason2, '');
		SELF.Custom3_reason3 := if(valid_Custom3 AND NOT isPreScreenPurpose AND ri.custom3_reason3 <> '00', ri.custom3_reason3, '');
		SELF.Custom3_reason4 := if(valid_Custom3 AND NOT isPreScreenPurpose AND ri.custom3_reason4 <> '00', ri.custom3_reason4, '');
		SELF.Custom3_reason5 := if(valid_Custom3 AND NOT isPreScreenPurpose AND ri.custom3_reason5 <> '00', ri.custom3_reason5, '');

		Custom4_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Custom4_Model_Name, LEFT, RIGHT)))[1];
		valid_Custom4 := Custom4_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Custom4_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Custom4_Index := if(valid_Custom4, (STRING)Custom4_info.Billing_Index, '');
		SELF.Custom4_Score_Name := if(valid_Custom4, Custom4_info.Output_Model_Name, '');
		SELF.Custom4_Type := if(valid_Custom4, Custom4_info.Model_Type, '');
		SELF.Custom4_score := if(valid_Custom4, ri.Custom4_score, '');
		SELF.Custom4_reason1 := if(valid_Custom4 AND NOT isPreScreenPurpose AND ri.custom4_reason1 <> '00', ri.custom4_reason1, '');
		SELF.Custom4_reason2 := if(valid_Custom4 AND NOT isPreScreenPurpose AND ri.custom4_reason2 <> '00', ri.custom4_reason2, '');
		SELF.Custom4_reason3 := if(valid_Custom4 AND NOT isPreScreenPurpose AND ri.custom4_reason3 <> '00', ri.custom4_reason3, '');
		SELF.Custom4_reason4 := if(valid_Custom4 AND NOT isPreScreenPurpose AND ri.custom4_reason4 <> '00', ri.custom4_reason4, '');
		SELF.Custom4_reason5 := if(valid_Custom4 AND NOT isPreScreenPurpose AND ri.custom4_reason5 <> '00', ri.custom4_reason5, '');

		Custom5_info := model_info(Model_Name = StringLib.StringToUpperCase(TRIM(Custom5_Model_Name, LEFT, RIGHT)))[1];
		valid_Custom5 := Custom5_Model_Name <> '' AND StringLib.StringToUpperCase(TRIM(Custom5_Model_Name, LEFT, RIGHT)) IN valid_model_names;
		SELF.Custom5_Index := if(valid_Custom5, (STRING)Custom5_info.Billing_Index, '');
		SELF.Custom5_Score_Name := if(valid_Custom5, Custom5_info.Output_Model_Name, '');
		SELF.Custom5_Type := if(valid_Custom5, Custom5_info.Model_Type, '');
		SELF.Custom5_score := if(valid_Custom5, ri.Custom5_score, '');
		SELF.Custom5_reason1 := if(valid_Custom5 AND NOT isPreScreenPurpose AND ri.custom5_reason1 <> '00', ri.custom5_reason1, '');
		SELF.Custom5_reason2 := if(valid_Custom5 AND NOT isPreScreenPurpose AND ri.custom5_reason2 <> '00', ri.custom5_reason2, '');
		SELF.Custom5_reason3 := if(valid_Custom5 AND NOT isPreScreenPurpose AND ri.custom5_reason3 <> '00', ri.custom5_reason3, '');
		SELF.Custom5_reason4 := if(valid_Custom5 AND NOT isPreScreenPurpose AND ri.custom5_reason4 <> '00', ri.custom5_reason4, '');
		SELF.Custom5_reason5 := if(valid_Custom5 AND NOT isPreScreenPurpose AND ri.custom5_reason5 <> '00', ri.custom5_reason5, '');

		SELF.Alert1 := ri.Alert1;
		SELF.Alert2 := ri.Alert2;
		SELF.Alert3 := ri.Alert3;
		SELF.Alert4 := ri.Alert4;
		SELF.Alert5 := ri.Alert5;
		SELF.Alert6 := ri.Alert6;
		SELF.Alert7 := ri.Alert7;
		SELF.Alert8 := ri.Alert8;
		SELF.Alert9 := ri.Alert9;
		SELF.Alert10 := ri.Alert10;
		
		valid_attributes := RiskView.Constants.valid_attributes;
		valid_attributes_requested := stringlib.stringtolowercase(AttributesVersionRequest) in valid_attributes;

		self.Attribute_Index 	:= if(valid_attributes_requested, ri.Attribute_Index 	, '');
		self.InputProvidedFirstName	:= if(valid_attributes_requested, ri.InputProvidedFirstName	, '');
		self.InputProvidedLastName	:= if(valid_attributes_requested, ri.InputProvidedLastName	, '');
		self.InputProvidedStreetAddress	:= if(valid_attributes_requested, ri.InputProvidedStreetAddress	, '');
		self.InputProvidedCity	:= if(valid_attributes_requested, ri.InputProvidedCity	, '');
		self.InputProvidedState	:= if(valid_attributes_requested, ri.InputProvidedState	, '');
		self.InputProvidedZipCode	:= if(valid_attributes_requested, ri.InputProvidedZipCode	, '');
		self.InputProvidedSSN	:= if(valid_attributes_requested, ri.InputProvidedSSN	, '');
		self.InputProvidedDateofBirth	:= if(valid_attributes_requested, ri.InputProvidedDateofBirth	, '');
		self.InputProvidedPhone	:= if(valid_attributes_requested, ri.InputProvidedPhone	, '');
		self.InputProvidedLexID	:= if(valid_attributes_requested, ri.InputProvidedLexID	, '');
		self.SubjectRecordTimeOldest	:= if(valid_attributes_requested, ri.SubjectRecordTimeOldest	, '');
		self.SubjectRecordTimeNewest	:= if(valid_attributes_requested, ri.SubjectRecordTimeNewest	, '');
		self.SubjectNewestRecord12Month	:= if(valid_attributes_requested, ri.SubjectNewestRecord12Month	, '');
		self.SubjectActivityIndex03Month	:= if(valid_attributes_requested, ri.SubjectActivityIndex03Month	, '');
		self.SubjectActivityIndex06Month	:= if(valid_attributes_requested, ri.SubjectActivityIndex06Month	, '');
		self.SubjectActivityIndex12Month	:= if(valid_attributes_requested, ri.SubjectActivityIndex12Month	, '');
		self.SubjectAge	:= if(valid_attributes_requested, ri.SubjectAge	, '');
		self.SubjectDeceased	:= if(valid_attributes_requested, ri.SubjectDeceased	, '');
		self.SubjectSSNCount	:= if(valid_attributes_requested, ri.SubjectSSNCount	, '');
		self.SubjectStabilityIndex	:= if(valid_attributes_requested, ri.SubjectStabilityIndex	, '');
		self.SubjectStabilityPrimaryFactor	:= if(valid_attributes_requested, ri.SubjectStabilityPrimaryFactor	, '');
		self.SubjectAbilityIndex	:= if(valid_attributes_requested, ri.SubjectAbilityIndex	, '');
		self.SubjectAbilityPrimaryFactor	:= if(valid_attributes_requested, ri.SubjectAbilityPrimaryFactor	, '');
		self.SubjectWillingnessIndex	:= if(valid_attributes_requested, ri.SubjectWillingnessIndex	, '');
		self.SubjectWillingnessPrimaryFactor	:= if(valid_attributes_requested, ri.SubjectWillingnessPrimaryFactor	, '');
		self.ConfirmationSubjectFound	:= if(valid_attributes_requested, ri.ConfirmationSubjectFound	, '');
		self.ConfirmationInputName	:= if(valid_attributes_requested, ri.ConfirmationInputName	, '');
		self.ConfirmationInputDOB	:= if(valid_attributes_requested, ri.ConfirmationInputDOB	, '');
		self.ConfirmationInputSSN	:= if(valid_attributes_requested, ri.ConfirmationInputSSN	, '');
		self.ConfirmationInputAddress	:= if(valid_attributes_requested, ri.ConfirmationInputAddress	, '');
		self.SourceNonDerogProfileIndex	:= if(valid_attributes_requested, ri.SourceNonDerogProfileIndex	, '');
		self.SourceNonDerogCount	:= if(valid_attributes_requested, ri.SourceNonDerogCount	, '');
		self.SourceNonDerogCount03Month	:= if(valid_attributes_requested, ri.SourceNonDerogCount03Month	, '');
		self.SourceNonDerogCount06Month	:= if(valid_attributes_requested, ri.SourceNonDerogCount06Month	, '');
		self.SourceNonDerogCount12Month	:= if(valid_attributes_requested, ri.SourceNonDerogCount12Month	, '');
		self.SourceCredHeaderTimeOldest	:= if(valid_attributes_requested, ri.SourceCredHeaderTimeOldest	, '');
		self.SourceCredHeaderTimeNewest	:= if(valid_attributes_requested, ri.SourceCredHeaderTimeNewest	, '');
		self.SourceVoterRegistration	:= if(valid_attributes_requested, ri.SourceVoterRegistration	, '');
		self.EducationAttendance	:= if(valid_attributes_requested, ri.EducationAttendance	, '');
		self.EducationEvidence	:= if(valid_attributes_requested, ri.EducationEvidence	, '');
		self.EducationProgramAttended	:= if(valid_attributes_requested, ri.EducationProgramAttended	, '');
		self.EducationInstitutionPrivate	:= if(valid_attributes_requested, ri.EducationInstitutionPrivate	, '');
		self.EducationInstitutionRating	:= if(valid_attributes_requested, ri.EducationInstitutionRating	, '');
		self.ProfLicCount	:= if(valid_attributes_requested, ri.ProfLicCount	, '');
		self.ProfLicTypeCategory	:= if(valid_attributes_requested, ri.ProfLicTypeCategory	, '');
		self.BusinessAssociation	:= if(valid_attributes_requested, ri.BusinessAssociation	, '');
		self.BusinessAssociationIndex	:= if(valid_attributes_requested, ri.BusinessAssociationIndex	, '');
		self.BusinessAssociationTimeOldest	:= if(valid_attributes_requested, ri.BusinessAssociationTimeOldest	, '');
		self.BusinessTitleLeadership	:= if(valid_attributes_requested, ri.BusinessTitleLeadership	, '');
		self.AssetIndex	:= if(valid_attributes_requested, ri.AssetIndex	, '');
		self.AssetIndexPrimaryFactor	:= if(valid_attributes_requested, ri.AssetIndexPrimaryFactor	, '');
		self.AssetOwnership	:= if(valid_attributes_requested, ri.AssetOwnership	, '');
		self.AssetProp	:= if(valid_attributes_requested, ri.AssetProp	, '');
		self.AssetPropIndex	:= if(valid_attributes_requested, ri.AssetPropIndex	, '');
		self.AssetPropEverCount	:= if(valid_attributes_requested, ri.AssetPropEverCount	, '');
		self.AssetPropCurrentCount	:= if(valid_attributes_requested, ri.AssetPropCurrentCount	, '');
		self.AssetPropCurrentTaxTotal	:= if(valid_attributes_requested, ri.AssetPropCurrentTaxTotal	, '');
		self.AssetPropPurchaseCount12Month	:= if(valid_attributes_requested, ri.AssetPropPurchaseCount12Month	, '');
		self.AssetPropPurchaseTimeOldest	:= if(valid_attributes_requested, ri.AssetPropPurchaseTimeOldest	, '');
		self.AssetPropPurchaseTimeNewest	:= if(valid_attributes_requested, ri.AssetPropPurchaseTimeNewest	, '');
		self.AssetPropNewestMortgageType	:= if(valid_attributes_requested, ri.AssetPropNewestMortgageType	, '');
		self.AssetPropEverSoldCount	:= if(valid_attributes_requested, ri.AssetPropEverSoldCount	, '');
		self.AssetPropSoldCount12Month	:= if(valid_attributes_requested, ri.AssetPropSoldCount12Month	, '');
		self.AssetPropSaleTimeOldest	:= if(valid_attributes_requested, ri.AssetPropSaleTimeOldest	, '');
		self.AssetPropSaleTimeNewest	:= if(valid_attributes_requested, ri.AssetPropSaleTimeNewest	, '');
		self.AssetPropNewestSalePrice	:= if(valid_attributes_requested, ri.AssetPropNewestSalePrice	, '');
		self.AssetPropSalePurchaseRatio	:= if(valid_attributes_requested, ri.AssetPropSalePurchaseRatio	, '');
		self.AssetPersonal	:= if(valid_attributes_requested, ri.AssetPersonal	, '');
		self.AssetPersonalCount	:= if(valid_attributes_requested, ri.AssetPersonalCount	, '');
		self.PurchaseActivityIndex	:= if(valid_attributes_requested, ri.PurchaseActivityIndex	, '');
		self.PurchaseActivityCount	:= if(valid_attributes_requested, ri.PurchaseActivityCount	, '');
		self.PurchaseActivityDollarTotal	:= if(valid_attributes_requested, ri.PurchaseActivityDollarTotal	, '');
		self.DerogSeverityIndex	:= if(valid_attributes_requested, ri.DerogSeverityIndex	, '');
		self.DerogCount	:= if(valid_attributes_requested, ri.DerogCount	, '');
		self.DerogCount12Month	:= if(valid_attributes_requested, ri.DerogCount12Month	, '');
		self.DerogTimeNewest	:= if(valid_attributes_requested, ri.DerogTimeNewest	, '');
		self.CriminalFelonyCount	:= if(valid_attributes_requested, ri.CriminalFelonyCount	, '');
		self.CriminalFelonyCount12Month	:= if(valid_attributes_requested, ri.CriminalFelonyCount12Month	, '');
		self.CriminalFelonyTimeNewest	:= if(valid_attributes_requested, ri.CriminalFelonyTimeNewest	, '');
		self.CriminalNonFelonyCount	:= if(valid_attributes_requested, ri.CriminalNonFelonyCount	, '');
		self.CriminalNonFelonyCount12Month	:= if(valid_attributes_requested, ri.CriminalNonFelonyCount12Month	, '');
		self.CriminalNonFelonyTimeNewest	:= if(valid_attributes_requested, ri.CriminalNonFelonyTimeNewest	, '');
		self.EvictionCount	:= if(valid_attributes_requested, ri.EvictionCount	, '');
		self.EvictionCount12Month	:= if(valid_attributes_requested, ri.EvictionCount12Month	, '');
		self.EvictionTimeNewest	:= if(valid_attributes_requested, ri.EvictionTimeNewest	, '');
		self.LienJudgmentSeverityIndex	:= if(valid_attributes_requested, ri.LienJudgmentSeverityIndex	, '');
		self.LienJudgmentCount	:= if(valid_attributes_requested, ri.LienJudgmentCount	, '');
		self.LienJudgmentCount12Month	:= if(valid_attributes_requested, ri.LienJudgmentCount12Month	, '');
		self.LienJudgmentSmallClaimsCount	:= if(valid_attributes_requested, ri.LienJudgmentSmallClaimsCount	, '');
		self.LienJudgmentCourtCount	:= if(valid_attributes_requested, ri.LienJudgmentCourtCount	, '');
		self.LienJudgmentTaxCount	:= if(valid_attributes_requested, ri.LienJudgmentTaxCount	, '');
		self.LienJudgmentForeclosureCount	:= if(valid_attributes_requested, ri.LienJudgmentForeclosureCount	, '');
		self.LienJudgmentOtherCount	:= if(valid_attributes_requested, ri.LienJudgmentOtherCount	, '');
		self.LienJudgmentTimeNewest	:= if(valid_attributes_requested, ri.LienJudgmentTimeNewest	, '');
		self.LienJudgmentDollarTotal	:= if(valid_attributes_requested, ri.LienJudgmentDollarTotal	, '');
		self.BankruptcyCount 	:= if(valid_attributes_requested, ri.BankruptcyCount 	, '');
		self.BankruptcyCount24Month	:= if(valid_attributes_requested, ri.BankruptcyCount24Month	, '');
		self.BankruptcyTimeNewest	:= if(valid_attributes_requested, ri.BankruptcyTimeNewest	, '');
		self.BankruptcyChapter	:= if(valid_attributes_requested, ri.BankruptcyChapter	, '');
		self.BankruptcyStatus	:= if(valid_attributes_requested, ri.BankruptcyStatus	, '');
		self.BankruptcyDismissed24Month	:= if(valid_attributes_requested, ri.BankruptcyDismissed24Month	, '');
		self.ShortTermLoanRequest	:= if(valid_attributes_requested, ri.ShortTermLoanRequest	, '');
		self.ShortTermLoanRequest12Month	:= if(valid_attributes_requested, ri.ShortTermLoanRequest12Month	, '');
		self.ShortTermLoanRequest24Month	:= if(valid_attributes_requested, ri.ShortTermLoanRequest24Month	, '');
		self.InquiryAuto12Month	:= if(valid_attributes_requested, ri.InquiryAuto12Month	, '');
		self.InquiryBanking12Month	:= if(valid_attributes_requested, ri.InquiryBanking12Month	, '');
		self.InquiryTelcom12Month	:= if(valid_attributes_requested, ri.InquiryTelcom12Month	, '');
		self.InquiryNonShortTerm12Month	:= if(valid_attributes_requested, ri.InquiryNonShortTerm12Month	, '');
		self.InquiryShortTerm12Month	:= if(valid_attributes_requested, ri.InquiryShortTerm12Month	, '');
		self.InquiryCollections12Month	:= if(valid_attributes_requested, ri.InquiryCollections12Month	, '');
		self.SSNSubjectCount	:= if(valid_attributes_requested, ri.SSNSubjectCount	, '');
		self.SSNDeceased	:= if(valid_attributes_requested, ri.SSNDeceased	, '');
		self.SSNDateLowIssued	:= if(valid_attributes_requested, ri.SSNDateLowIssued	, '');
		self.SSNProblems	:= if(valid_attributes_requested, ri.SSNProblems	, '');
		self.AddrOnFileCount	:= if(valid_attributes_requested, ri.AddrOnFileCount	, '');
		self.AddrOnFileCorrectional	:= if(valid_attributes_requested, ri.AddrOnFileCorrectional	, '');
		self.AddrOnFileCollege	:= if(valid_attributes_requested, ri.AddrOnFileCollege	, '');
		self.AddrOnFileHighRisk	:= if(valid_attributes_requested, ri.AddrOnFileHighRisk	, '');
		self.AddrInputTimeOldest	:= if(valid_attributes_requested, ri.AddrInputTimeOldest	, '');
		self.AddrInputTimeNewest	:= if(valid_attributes_requested, ri.AddrInputTimeNewest	, '');
		self.AddrInputLengthOfRes	:= if(valid_attributes_requested, ri.AddrInputLengthOfRes	, '');
		self.AddrInputSubjectCount	:= if(valid_attributes_requested, ri.AddrInputSubjectCount	, '');
		self.AddrInputMatchIndex	:= if(valid_attributes_requested, ri.AddrInputMatchIndex	, '');
		self.AddrInputSubjectOwned	:= if(valid_attributes_requested, ri.AddrInputSubjectOwned	, '');
		self.AddrInputDeedMailing	:= if(valid_attributes_requested, ri.AddrInputDeedMailing	, '');
		self.AddrInputOwnershipIndex	:= if(valid_attributes_requested, ri.AddrInputOwnershipIndex	, '');
		self.AddrInputPhoneService	:= if(valid_attributes_requested, ri.AddrInputPhoneService	, '');
		self.AddrInputPhoneCount	:= if(valid_attributes_requested, ri.AddrInputPhoneCount	, '');
		self.AddrInputDwellType	:= if(valid_attributes_requested, ri.AddrInputDwellType	, '');
		self.AddrInputDwellTypeIndex	:= if(valid_attributes_requested, ri.AddrInputDwellTypeIndex	, '');
		self.AddrInputDelivery	:= if(valid_attributes_requested, ri.AddrInputDelivery	, '');
		self.AddrInputTimeLastSale	:= if(valid_attributes_requested, ri.AddrInputTimeLastSale	, '');
		self.AddrInputLastSalePrice	:= if(valid_attributes_requested, ri.AddrInputLastSalePrice	, '');
		self.AddrInputTaxValue	:= if(valid_attributes_requested, ri.AddrInputTaxValue	, '');
		self.AddrInputTaxYr	:= if(valid_attributes_requested, ri.AddrInputTaxYr	, '');
		self.AddrInputTaxMarketValue	:= if(valid_attributes_requested, ri.AddrInputTaxMarketValue	, '');
		self.AddrInputAVMValue	:= if(valid_attributes_requested, ri.AddrInputAVMValue	, '');
		self.AddrInputAVMValue12Month	:= if(valid_attributes_requested, ri.AddrInputAVMValue12Month	, '');
		self.AddrInputAVMRatio12MonthPrior	:= if(valid_attributes_requested, ri.AddrInputAVMRatio12MonthPrior	, '');
		self.AddrInputAVMValue60Month	:= if(valid_attributes_requested, ri.AddrInputAVMValue60Month	, '');
		self.AddrInputAVMRatio60MonthPrior	:= if(valid_attributes_requested, ri.AddrInputAVMRatio60MonthPrior	, '');
		self.AddrInputCountyRatio	:= if(valid_attributes_requested, ri.AddrInputCountyRatio	, '');
		self.AddrInputTractRatio	:= if(valid_attributes_requested, ri.AddrInputTractRatio	, '');
		self.AddrInputBlockRatio	:= if(valid_attributes_requested, ri.AddrInputBlockRatio	, '');
		self.AddrInputProblems	:= if(valid_attributes_requested, ri.AddrInputProblems	, '');
		self.AddrCurrentTimeOldest	:= if(valid_attributes_requested, ri.AddrCurrentTimeOldest	, '');
		self.AddrCurrentTimeNewest	:= if(valid_attributes_requested, ri.AddrCurrentTimeNewest	, '');
		self.AddrCurrentLengthOfRes 	:= if(valid_attributes_requested, ri.AddrCurrentLengthOfRes 	, '');
		self.AddrCurrentSubjectOwned 	:= if(valid_attributes_requested, ri.AddrCurrentSubjectOwned 	, '');
		self.AddrCurrentDeedMailing	:= if(valid_attributes_requested, ri.AddrCurrentDeedMailing	, '');
		self.AddrCurrentOwnershipIndex	:= if(valid_attributes_requested, ri.AddrCurrentOwnershipIndex	, '');
		self.AddrCurrentPhoneService	:= if(valid_attributes_requested, ri.AddrCurrentPhoneService	, '');
		self.AddrCurrentDwellType 	:= if(valid_attributes_requested, ri.AddrCurrentDwellType 	, '');
		self.AddrCurrentDwellTypeIndex	:= if(valid_attributes_requested, ri.AddrCurrentDwellTypeIndex	, '');
		self.AddrCurrentTimeLastSale	:= if(valid_attributes_requested, ri.AddrCurrentTimeLastSale	, '');
		self.AddrCurrentLastSalesPrice	:= if(valid_attributes_requested, ri.AddrCurrentLastSalesPrice	, '');
		self.AddrCurrentTaxValue	:= if(valid_attributes_requested, ri.AddrCurrentTaxValue	, '');
		self.AddrCurrentTaxYr	:= if(valid_attributes_requested, ri.AddrCurrentTaxYr	, '');
		self.AddrCurrentTaxMarketValue	:= if(valid_attributes_requested, ri.AddrCurrentTaxMarketValue	, '');
		self.AddrCurrentAVMValue	:= if(valid_attributes_requested, ri.AddrCurrentAVMValue	, '');
		self.AddrCurrentAVMValue12Month	:= if(valid_attributes_requested, ri.AddrCurrentAVMValue12Month	, '');
		self.AddrCurrentAVMRatio12MonthPrior	:= if(valid_attributes_requested, ri.AddrCurrentAVMRatio12MonthPrior	, '');
		self.AddrCurrentAVMValue60Month	:= if(valid_attributes_requested, ri.AddrCurrentAVMValue60Month	, '');
		self.AddrCurrentAVMRatio60MonthPrior	:= if(valid_attributes_requested, ri.AddrCurrentAVMRatio60MonthPrior	, '');
		self.AddrCurrentCountyRatio	:= if(valid_attributes_requested, ri.AddrCurrentCountyRatio	, '');
		self.AddrCurrentTractRatio	:= if(valid_attributes_requested, ri.AddrCurrentTractRatio	, '');
		self.AddrCurrentBlockRatio	:= if(valid_attributes_requested, ri.AddrCurrentBlockRatio	, '');
		self.AddrCurrentCorrectional	:= if(valid_attributes_requested, ri.AddrCurrentCorrectional	, '');
		self.AddrPreviousTimeOldest	:= if(valid_attributes_requested, ri.AddrPreviousTimeOldest	, '');
		self.AddrPreviousTimeNewest	:= if(valid_attributes_requested, ri.AddrPreviousTimeNewest	, '');
		self.AddrPreviousLengthOfRes 	:= if(valid_attributes_requested, ri.AddrPreviousLengthOfRes 	, '');
		self.AddrPreviousSubjectOwned 	:= if(valid_attributes_requested, ri.AddrPreviousSubjectOwned 	, '');
		self.AddrPreviousOwnershipIndex	:= if(valid_attributes_requested, ri.AddrPreviousOwnershipIndex	, '');
		self.AddrPreviousDwellType 	:= if(valid_attributes_requested, ri.AddrPreviousDwellType 	, '');
		self.AddrPreviousDwellTypeIndex	:= if(valid_attributes_requested, ri.AddrPreviousDwellTypeIndex	, '');
		self.AddrPreviousCorrectional	:= if(valid_attributes_requested, ri.AddrPreviousCorrectional	, '');
		self.AddrStabilityIndex	:= if(valid_attributes_requested, ri.AddrStabilityIndex	, '');
		self.AddrChangeCount03Month	:= if(valid_attributes_requested, ri.AddrChangeCount03Month	, '');
		self.AddrChangeCount06Month	:= if(valid_attributes_requested, ri.AddrChangeCount06Month	, '');
		self.AddrChangeCount12Month	:= if(valid_attributes_requested, ri.AddrChangeCount12Month	, '');
		self.AddrChangeCount24Month	:= if(valid_attributes_requested, ri.AddrChangeCount24Month	, '');
		self.AddrChangeCount60Month	:= if(valid_attributes_requested, ri.AddrChangeCount60Month	, '');
		self.AddrLastMoveTaxRatioDiff	:= if(valid_attributes_requested, ri.AddrLastMoveTaxRatioDiff	, '');
		self.AddrLastMoveEconTrajectory	:= if(valid_attributes_requested, ri.AddrLastMoveEconTrajectory	, '');
		self.AddrLastMoveEconTrajectoryIndex	:= if(valid_attributes_requested, ri.AddrLastMoveEconTrajectoryIndex	, '');
		self.PhoneInputProblems	:= if(valid_attributes_requested, ri.PhoneInputProblems	, '');
		self.PhoneInputSubjectCount	:= if(valid_attributes_requested, ri.PhoneInputSubjectCount	, '');
		self.PhoneInputMobile 	:= if(valid_attributes_requested, ri.PhoneInputMobile 	, '');
		self.AlertRegulatoryCondition	:= if(valid_attributes_requested, ri.AlertRegulatoryCondition	, '');
	
	
		
		//lien-judment section
		self.LnJEvictionTotalCount           := if(lnjattributes_requested, ri.LnJEvictionTotalCount	, '');         
		self.LnJEvictionTotalCount12Month    := if(lnjattributes_requested, ri.LnJEvictionTotalCount12Month	, '');           
		self.LnjEvictionTimeNewest           := if(lnjattributes_requested, ri.LnjEvictionTimeNewest	, '');           
		self.LnJJudgmentSmallClaimsCount     := if(lnjattributes_requested, ri.LnJJudgmentSmallClaimsCount	, '');           
		self.LnjJudgmentCourtCount           := if(lnjattributes_requested, ri.LnjJudgmentCourtCount	, '');          
		self.LnjJudgmentForeclosureCount     := if(lnjattributes_requested, ri.LnjJudgmentForeclosureCount	, '');        
		self.LnjLienJudgmentSeverityIndex    := if(lnjattributes_requested, ri.LnjLienJudgmentSeverityIndex	, '');          
		self.LnjLienJudgmentCount            := if(lnjattributes_requested, ri.LnjLienJudgmentCount	, '');         
		self.LnjLienJudgmentCount12Month     := if(lnjattributes_requested, ri.LnjLienJudgmentCount12Month	, '');          
		self.LnJLienTaxCount                 := if(lnjattributes_requested, ri.LnJLienTaxCount	, '');         
		self.LnjLienJudgmentOtherCount       := if(lnjattributes_requested, ri.LnjLienJudgmentOtherCount	, '');           
		self.LnjLienJudgmentTimeNewest       := if(lnjattributes_requested, ri.LnjLienJudgmentTimeNewest	, '');           
		self.LnjLienJudgmentDollarTotal      := if(lnjattributes_requested, ri.LnjLienJudgmentDollarTotal	, '');          
		self.LnjLienCount                    := if(lnjattributes_requested, ri.LnjLienCount 	, '');           
		self.LnjLienTimeNewest               := if(lnjattributes_requested, ri.LnjLienTimeNewest	, '');           
		self.LnjLienDollarTotal              := if(lnjattributes_requested, ri.LnjLienDollarTotal	, '');                
		self.LnjLienTaxTimeNewest            := if(lnjattributes_requested, ri.LnjLienTaxTimeNewest	, '');           
		self.LnjLienTaxDollarTotal           := if(lnjattributes_requested, ri.LnjLienTaxDollarTotal	, '');          
		self.LnjLienTaxStateCount            := if(lnjattributes_requested, ri.LnjLienTaxStateCount	, '');           
		self.LnjLienTaxStateTimeNewest       := if(lnjattributes_requested, ri.LnjLienTaxStateTimeNewest	, '');           
		self.LnjLienTaxStateDollarTotal      := if(lnjattributes_requested, ri.LnjLienTaxStateDollarTotal	, '');           
		self.LnjLienTaxFederalCount          := if(lnjattributes_requested, ri.LnjLienTaxFederalCount	, '');           
		self.LnjLienTaxFederalTimeNewest     := if(lnjattributes_requested, ri.LnjLienTaxFederalTimeNewest	, '');          
		self.LnjLienTaxFederalDollarTotal    := if(lnjattributes_requested, ri.LnjLienTaxFederalDollarTotal	, '');           
		self.LnjJudgmentCount                := if(lnjattributes_requested, ri.LnjJudgmentCount	, '');           
		self.LnjJudgmentTimeNewest           := if(lnjattributes_requested, ri.LnjJudgmentTimeNewest	, '');           
		self.LnjJudgmentDollarTotal          := if(lnjattributes_requested, ri.LnjJudgmentDollarTotal	, ''); 
		
		
		// liens 1&2
	
		 A:= dataset([transform(
		Risk_Indicators.Layouts_Derog_Info.Liens,
		self.seq 												     	:= ri.liens1_seq;
	 self.DateFiled      							:= ri.liens1_DateFiled;
  self.LienTypeID            := ri.Liens1_LienTypeID;
		self.LienType       							:= ri.Liens1_LienType;
		self.Amount         							:= ri.Liens1_Amount;
		self.ReleaseDate    							:= ri.Liens1_ReleaseDate;
		self.DateLastSeen   							:= ri.Liens1_DateLastSeen;
		self.FilingNumber   							:= ri.Liens1_FilingNumber;
		self.FilingBook     							:= ri.Liens1_FilingBook;
		self.FilingPage     							:= ri.Liens1_FilingPage;
		self.Agency         							:= ri.Liens1_Agency;
		self.AgencyCounty   							:= ri.Liens1_AgencyCounty;
		self.AgencyState	   							:= ri.Liens1_AgencyState;
  self.ConsumerStatementID   := ri.Liens1_ConsumerStatementID;
		SELF := [];
	)]);
	
	B:= dataset([transform(
		Risk_Indicators.Layouts_Derog_Info.Liens,
		self.seq 										     		:= ri.liens2_seq;
		self.DateFiled      						:= ri.Liens2_DateFiled;
  self.LienTypeID           := ri.Liens2_LienTypeID;
		self.LienType      							:= ri.Liens2_LienType;
		self.Amount        							:= ri.Liens2_Amount;
		self.ReleaseDate    						:= ri.Liens2_ReleaseDate;
		self.DateLastSeen   						:= ri.Liens2_DateLastSeen;
		self.FilingNumber   						:= ri.Liens2_FilingNumber;
		self.FilingBook     						:= ri.Liens2_FilingBook;
		self.FilingPage     						:= ri.Liens2_FilingPage;
		self.Agency         						:= ri.Liens2_Agency;
		self.AgencyCounty   						:= ri.Liens2_AgencyCounty;
		self.AgencyState	   						:= ri.Liens2_AgencyState;
  self.ConsumerStatementID  := ri.Liens2_ConsumerStatementID;
		SELF := [];
		)]);
	
		
	
	
	// Judgments 1&2
	C:= dataset([transform(
		Risk_Indicators.Layouts_Derog_Info.Judgments,
		self.seq 							     					:= ri.Jgmts1_seq;
		self.DateFiled      						:= ri.Jgmts1_DateFiled;
  self.JudgmentTypeID       := ri.Jgmts1_JudgmentTypeID;
		self.JudgmentType      			:= ri.Jgmts1_JudgmentType;
		self.Amount        							:= ri.Jgmts1_Amount;
		self.ReleaseDate    						:= ri.Jgmts1_ReleaseDate;
		self.FilingDescription    := ri.Jgmts1_FilingDescription;
		self.DateLastSeen   						:= ri.Jgmts1_DateLastSeen;
		self.Defendant   			      := ri.Jgmts1_Defendant;
		self.Plaintiff    			     := ri.Jgmts1_Plaintiff ;
		self.FilingNumber   						:= ri.Jgmts1_FilingNumber;
		self.FilingBook     						:= ri.Jgmts1_FilingBook;
		self.FilingPage     						:= ri.Jgmts1_FilingPage;
		self.Eviction             := ri.Jgmts1_Eviction;
		self.Agency         						:= ri.Jgmts1_Agency;
		self.AgencyCounty   						:= ri.Jgmts1_AgencyCounty;
		self.AgencyState	   						:= ri.Jgmts1_AgencyState;
  self.ConsumerStatementID  := ri.Jgmts1_ConsumerStatementID;
		SELF := [];
		)]);
		
		
	D:= dataset([transform(
		Risk_Indicators.Layouts_Derog_Info.Judgments,
		self.seq 											     	:= ri.Jgmts2_seq;
		self.DateFiled      						:= ri.Jgmts2_DateFiled;
  self.JudgmentTypeID       := ri.Jgmts2_JudgmentTypeID;
		self.JudgmentType       		:= ri.Jgmts2_JudgmentType;
		self.Amount        							:= ri.Jgmts2_Amount;
		self.ReleaseDate    						:= ri.Jgmts2_ReleaseDate;
		self.FilingDescription    := ri.Jgmts2_FilingDescription;
		self.DateLastSeen   						:= ri.Jgmts2_DateLastSeen;
		self.Defendant   			      := ri.Jgmts2_Defendant;
		self.Plaintiff    			     := ri.Jgmts2_Plaintiff ;
		self.FilingNumber   						:= ri.Jgmts2_FilingNumber;
		self.FilingBook     						:= ri.Jgmts2_FilingBook;
		self.FilingPage     						:= ri.Jgmts2_FilingPage;
		self.Eviction             := ri.Jgmts2_Eviction;
		self.Agency         						:= ri.Jgmts2_Agency;
		self.AgencyCounty   						:= ri.Jgmts2_AgencyCounty;
		self.AgencyState	   						:= ri.Jgmts2_AgencyState;
  self.ConsumerStatementID  := ri.Jgmts2_ConsumerStatementID;
		SELF := [];
		)]);	
		
		// ConsumerStatement 1&2	
		E:= dataset([transform(
		iesp.share_fcra.t_ConsumerStatement,
			self.UniqueId := ri.CS_UniqueId;	
			self.TimeStamp.Year   := ri.CS_Year;
			self.TimeStamp.Month  := ri.CS_Month;
			self.TimeStamp.Day    := ri.CS_Day;	
			self.Timestamp.Hour24  := ri.CS_Hour24;
			self.Timestamp.Minute  := ri.CS_Minute;
			self.Timestamp.Second  := ri.CS_Second;
			self.StatementId  		 := ri.CS_StatementId;
			self.StatementType 		 := ri.CS_StatementType;
			self.DataGroup         := ri.CS_DataGroup ;
			self.Content           := ri.CS_Content;
			SELF := [];
			)]);
	
	
		F:= dataset([transform(
		iesp.share_fcra.t_ConsumerStatement,
			self.UniqueId := ri.CS2_UniqueId;	
			self.TimeStamp.Year   := ri.CS2_Year;
			self.TimeStamp.Month  := ri.CS2_Month;
			self.TimeStamp.Day    := ri.CS2_Day;
			self.Timestamp.Hour24  := ri.CS2_Hour24;
			self.Timestamp.Minute  := ri.CS2_Minute;
			self.Timestamp.Second  := ri.CS2_Second;
			self.StatementId  		 := ri.CS2_StatementId;
			self.StatementType 		 := ri.CS2_StatementType;
			self.DataGroup         := ri.CS2_DataGroup ;
			self.Content           := ri.CS2_Content;

		SELF := [];
		)]);	
	
	
	
		Self.lnjliens 			    :=  if(lnjattributes_requested,(A + B)(seq<>''),dataset([],Risk_Indicators.Layouts_Derog_Info.Liens));
		Self.lnjJudgments 	    :=  if(lnjattributes_requested,(C + D)(seq<>''),dataset([],Risk_Indicators.Layouts_Derog_Info.Judgments));
	  Self.ConsumerStatements :=  (E + F);
		
		SELF := le;
		SELF := [];
	END;
	seedResults := JOIN(inData, SeedKey, KEYED(RIGHT.TestDataTableName = TestDataTableName_in) AND
																																 KEYED(RIGHT.HashValue = Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(LEFT.FName, LEFT, RIGHT)), StringLib.StringToUpperCase(TRIM(LEFT.LName, LEFT, RIGHT)), TRIM(LEFT.SSN, LEFT, RIGHT), Risk_Indicators.nullstring, TRIM(LEFT.in_Zipcode[1..5], LEFT, RIGHT), TRIM(LEFT.Phone10, LEFT, RIGHT), Risk_Indicators.nullstring)),
															getSeed(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
	returnLayout := RECORD
		unsigned4 Seq;
		iesp.riskview2.t_RiskView2Report;
	END;
	
	report_results := if(run_report, Report_TestSeed_Function(Indata, TestDataTableName_in), dataset([], returnLayout));
	
	
	FinalSeed := Join(seedResults, report_results, left.seq=right.seq, transform(RiskView.Layouts.Layout_RiskView5_Search_Results, self.report:=right, self:=left), LEFT OUTER, KEEP(1), ATMOST(100));
	

	// ------------------ DEBUGGING SECTION --------------------
	// OUTPUT(inData, NAMED('TS_inData'));
	// OUTPUT(Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(inData[1].FName, LEFT, RIGHT)), StringLib.StringToUpperCase(TRIM(inData[1].LName, LEFT, RIGHT)), TRIM(inData[1].SSN, LEFT, RIGHT), Risk_Indicators.nullstring, TRIM(inData[1].in_Zipcode[1..5], LEFT, RIGHT), TRIM(inData[1].Phone10, LEFT, RIGHT), Risk_Indicators.nullstring), NAMED('TS_Hashdata'));
	// OUTPUT(TestDataTableName_in, NAMED('TS_TestDataTableName'));
	// OUTPUT(AttributesVersionRequest, NAMED('TS_AttributesVersionRequest'));
	// OUTPUT(Auto_Model_Name, NAMED('TS_Auto_Model_Name'));
	// OUTPUT(Bankcard_Model_Name, NAMED('TS_Bankcard_Model_Name'));
	// OUTPUT(Short_Term_Lending_Model_Name, NAMED('TS_Short_Term_Lending_Model_Name'));
	// OUTPUT(Telecommunications_Model_Name, NAMED('TS_Telecommunications_Model_Name'));
	// OUTPUT(Custom_Model_Name, NAMED('TS_Custom_Model_Name'));
	// OUTPUT(seedResults, NAMED('seedResults'));
	// ---------------------------------------------------------
	
	RETURN FinalSeed;
END;