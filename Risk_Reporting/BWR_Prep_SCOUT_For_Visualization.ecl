#workunit('name', 'SCOUT_ETL_ModelScores');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

eyeball := 100;

outputFile := '~bpahl::out::scout_models';

/* ***********************************************************************************************
 *************************************************************************************************
 *             GATHER AND PARSE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                        *
 *************************************************************************************************
 *********************************************************************************************** */

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;
FCRALogFile := Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID;

LogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product))			IN ['FRAUDPOINT', 'RISKVIEW', 'RISKVIEWATTRIBUTES', 'INSTANTID', 'INSTANTIDMODEL', 'SMALLBUSINESSRISK', 'LEADINTEGRITY'] AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))) +
           DISTRIBUTE(PULL(FCRALogFile (StringLib.StringToUpperCase(TRIM(Product))	IN ['FRAUDPOINT', 'RISKVIEW', 'RISKVIEWATTRIBUTES', 'INSTANTID', 'INSTANTIDMODEL', 'SMALLBUSINESSRISK', 'LEADINTEGRITY'] AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs)));

sfr := StringLib.StringFindReplace;

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING50 AccountID, STRING8 TransactionDate, STRING50 ProductName, STRING50 LoginID, STRING100 BillingCode}, 
				fraudpoint := sfr(sfr(LEFT.inputxml, '<FraudPoint>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</FraudPoint>', '</SCOUT>');
				riskview := sfr(sfr(fraudpoint, '<RiskView>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</RiskView>', '</SCOUT>');
				riskviewattr := sfr(sfr(riskview, '<RiskViewAttributes>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</RiskViewAttributes>', '</SCOUT>');
				instantid := sfr(sfr(riskviewattr, '<InstantID>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</InstantID>', '</SCOUT>');
				instantidmodel := sfr(sfr(instantid, '<InstantIDModel>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</InstantIDModel>', '</SCOUT>');
				smallbusinessrisk := sfr(sfr(instantidmodel, '<SmallBusinessRisk>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</SmallBusinessRisk>', '</SCOUT>');
				leadintegrity := sfr(sfr(smallbusinessrisk, '<LeadIntegrity>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</LeadIntegrity>', '</SCOUT>');
				riskview2 := sfr(sfr(leadintegrity, '<RiskView2>', '<SCOUT><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'), '</RiskView2>', '</SCOUT>');
				SELF.inputxml := riskview2;
				SELF.outputxml := '<SCOUT>' + LEFT.outputxml + '</SCOUT>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF.ProductName := StringLib.StringToUpperCase(LEFT.Product);
				SELF.LoginID := StringLib.StringToUpperCase(LEFT.Login_ID);
				SELF.BillingCode := StringLib.StringToUpperCase(LEFT.Billing_Code);
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Raw_Logs'));

Parsed_Layout := RECORD
	STRING30 TransactionID := '';
	STRING8 TransactionDate := '';
	STRING50 AccountID := '';
	STRING50 LoginID := '';
	STRING100 BillingCode := '';
	STRING50 ProductName := '';
	STRING30	FirstName := '';
	STRING30	LastName := '';
	STRING70	FullName := '';
	STRING9		SSN := '';
	STRING8		DOB := '';
	STRING120	Address := '';
	STRING25	City := '';
	STRING2		State := '';
	STRING9		Zip := '';
	STRING20	DL := '';
	STRING2		DLState := '';
	STRING10	HomePhone := '';
	STRING10	WorkPhone := '';
	STRING50	Email := '';
	STRING20	IPAddress := '';
	STRING100 CustomModelOptionName1;
	STRING100 CustomModelOptionValue1;
	STRING100 CustomModelOptionName2;
	STRING100 CustomModelOptionValue2;
	STRING100 CustomModelOptionName3;
	STRING100 CustomModelOptionValue3;
	STRING100 CustomModelOptionName4;
	STRING100 CustomModelOptionValue4;
	STRING100 CustomModelOptionName5;
	STRING100 CustomModelOptionValue5;
	STRING25 ModelName := '';
	STRING25 ModelType := '';
	STRING3 ModelScore := '';
	STRING5 ReasonCode1 := '';
	STRING5 ReasonCode2 := '';
	STRING5 ReasonCode3 := '';
	STRING5 ReasonCode4 := '';
	STRING5 ReasonCode5 := '';
	STRING5 ReasonCode6 := '';
END;

Parsed_Layout_Input_Temp := RECORD
	Parsed_Layout;
	STRING25 FraudPointModel;
	STRING25 RiskViewAutoModel;
	STRING25 RiskViewBankCardModel;
	STRING25 RiskViewTelecomModel;
	STRING25 RiskViewRetailModel;
	STRING25 RiskViewMoneyServiceModel;
	STRING25 RiskViewPrescreenModel;
END;

Parsed_Layout_Temp := RECORD
	Parsed_Layout;
	
	STRING3 Score1 := '';
	STRING3 Score2 := '';
	STRING3 Score3 := '';
	STRING3 Score4 := '';
	STRING3 Score5 := '';
	
	STRING15 Model1 := '';
	STRING15 Model2 := '';
	STRING15 Model3 := '';
	STRING15 Model4 := '';
	STRING15 Model5 := '';
	
	STRING15 Type1 := '';
	STRING15 Type2 := '';
	STRING15 Type3 := '';
	STRING15 Type4 := '';
	STRING15 Type5 := '';
	
	STRING5 RC1_1		:= '';
	STRING5 RC1_2		:= '';
	STRING5 RC1_3		:= '';
	STRING5 RC1_4		:= '';
	STRING5 RC1_5		:= '';
	STRING5 RC1_6		:= '';
	STRING5 RC2_1		:= '';
	STRING5 RC2_2		:= '';
	STRING5 RC2_3		:= '';
	STRING5 RC2_4		:= '';
	STRING5 RC2_5		:= '';
	STRING5 RC2_6		:= '';
	STRING5 RC3_1		:= '';
	STRING5 RC3_2		:= '';
	STRING5 RC3_3		:= '';
	STRING5 RC3_4		:= '';
	STRING5 RC3_5		:= '';
	STRING5 RC3_6		:= '';
	STRING5 RC4_1		:= '';
	STRING5 RC4_2		:= '';
	STRING5 RC4_3		:= '';
	STRING5 RC4_4		:= '';
	STRING5 RC4_5		:= '';
	STRING5 RC4_6		:= '';
	STRING5 RC5_1		:= '';
	STRING5 RC5_2		:= '';
	STRING5 RC5_3		:= '';
	STRING5 RC5_4		:= '';
	STRING5 RC5_5		:= '';
	STRING5 RC5_6		:= '';
END;

Parsed_Layout_Input_Temp parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.FirstName			:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/Name/First')) + TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/First')));
	SELF.LastName				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/Name/Last')) + TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/Last')));
	SELF.FullName				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/Name/Full')) + TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/Full')));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN') + XMLTEXT('SearchBy/SSNLast4') + XMLTEXT('SearchBy/AuthorizedRepresentative/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= StringLib.StringToUpperCase(Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber')));
	SELF.City						:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/Address/City')));
	SELF.State					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/Address/State')));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DL							:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/DriverLicenseNumber')));
	SELF.DLState				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/DriverLicenseState')));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	SELF.Email					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/Email')));
	SELF.IPAddress			:= StringLib.StringToUpperCase(TRIM(XMLTEXT('SearchBy/IPAddress')));
	
	// Attempt to grab the model name from input in case the model name on output isn't particularly useful - IE Fraud Point models
	SELF.FraudPointModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/FraudPointModel')) + TRIM(XMLTEXT('Options/IncludeModels/FraudPointModel/ModelName')));
	SELF.RiskViewAutoModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Auto')));
	SELF.RiskViewBankCardModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/BankCard')));
	SELF.RiskViewTelecomModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Telecom')));
	SELF.RiskViewRetailModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Retail')));
	SELF.RiskViewMoneyServiceModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/MoneyService')));
	SELF.RiskViewPrescreenModel := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Prescreen')));
	
	// Grab the custom input options, if OptionName1 = 'CUSTOM' then OptionValue1 contains the custom model name
	SELF.CustomModelOptionName1    := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[1]/OptionName')));
	SELF.CustomModelOptionValue1   := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[1]/OptionValue')));
	SELF.CustomModelOptionName2    := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[2]/OptionName')));
	SELF.CustomModelOptionValue2   := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[2]/OptionValue')));
	SELF.CustomModelOptionName3    := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[3]/OptionName')));
	SELF.CustomModelOptionValue3   := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[3]/OptionValue')));
	SELF.CustomModelOptionName4    := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[4]/OptionName')));
	SELF.CustomModelOptionValue4   := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[4]/OptionValue')));
	SELF.CustomModelOptionName5    := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[5]/OptionName')));
	SELF.CustomModelOptionValue5   := StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[5]/OptionValue')));

	SELF := [];
END;
parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('SCOUT')), HASH64(TransactionID));

OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));

Parsed_Layout_Temp parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	
	SELF.Model1					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name')));
	SELF.Model2					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[2]/Name')));
	SELF.Model3					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[3]/Name')));
	SELF.Model4					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[4]/Name')));
	SELF.Model5					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[5]/Name')));
	
	SELF.Type1					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type')));
	SELF.Type2					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Type')));
	SELF.Type3					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Type')));
	SELF.Type4					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Type')));
	SELF.Type5					:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Type')));
	
	SELF.Score1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value'));
	SELF.Score2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Value'));
	SELF.Score3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Value'));
	SELF.Score4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Value'));
	SELF.Score5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Value'));

	SELF.RC1_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[1]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC1_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[2]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC1_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[3]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC1_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[4]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC1_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[5]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC1_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[6]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));

	SELF.RC2_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[1]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[2]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC2_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[2]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[2]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC2_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[3]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[2]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC2_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[4]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[2]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC2_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[5]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[2]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC2_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[6]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[2]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));

	SELF.RC3_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[1]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[3]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC3_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[2]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[3]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC3_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[3]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[3]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC3_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[4]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[3]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC3_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[5]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[3]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC3_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[6]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[3]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));

	SELF.RC4_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[1]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[4]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC4_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[2]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[4]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC4_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[3]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[4]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC4_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[4]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[4]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC4_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[5]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[4]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC4_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[6]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[4]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));

	SELF.RC5_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[1]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[5]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[1]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC5_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[2]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[5]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[2]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC5_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[3]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[5]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[3]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC5_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[4]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[5]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[4]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC5_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[5]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[5]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[5]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC5_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/WarningCodeIndicators[1]/WarningCodeIndicator[6]/WarningCode')) + TRIM(XMLTEXT('Result/Models/Model[5]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[6]/RiskCode')) + TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));

	SELF := [];
END;
parsedOutputTemp := PARSE(Logs, outputxml, parseOutput(), XML('SCOUT'));

OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));

Parsed_Layout normScores(Parsed_Layout_Temp le, UNSIGNED1 t) := TRANSFORM
	NameTypeReverse := ['RISKVIEW'];
	SELF.ModelName := CASE(t,
	  1 => IF(le.Model1 IN NameTypeReverse, le.Type1, le.Model1),
	  2 => IF(le.Model2 IN NameTypeReverse, le.Type2, le.Model2),
	  3 => IF(le.Model3 IN NameTypeReverse, le.Type3, le.Model3),
	  4 => IF(le.Model4 IN NameTypeReverse, le.Type4, le.Model4),
	  5 => IF(le.Model5 IN NameTypeReverse, le.Type5, le.Model5),
		'');
	
	SELF.ModelType := CASE(t,
	  1 => IF(le.Model1 IN NameTypeReverse, le.Model1, le.Type1),
	  2 => IF(le.Model2 IN NameTypeReverse, le.Model2, le.Type2),
	  3 => IF(le.Model3 IN NameTypeReverse, le.Model3, le.Type3),
	  4 => IF(le.Model4 IN NameTypeReverse, le.Model4, le.Type4),
	  5 => IF(le.Model5 IN NameTypeReverse, le.Model5, le.Type5),
		'');
		
	SELF.ModelScore := CASE(t,
		1 => le.Score1,
		2 => le.Score2,
		3 => le.Score3,
		4 => le.Score4,
		5 => le.Score5,
		'');
		
	SELF.ReasonCode1 := CASE(t,
		1		=> le.RC1_1,
		2		=> le.RC2_1,
		3		=> le.RC3_1,
		4		=> le.RC4_1,
		5		=> le.RC5_1,
		'');

	SELF.ReasonCode2 := CASE(t,
		1		=> le.RC1_2,
		2		=> le.RC2_2,
		3		=> le.RC3_2,
		4		=> le.RC4_2,
		5		=> le.RC5_2,
		'');
	
	SELF.ReasonCode3 := CASE(t,
		1		=> le.RC1_3,
		2		=> le.RC2_3,
		3		=> le.RC3_3,
		4		=> le.RC4_3,
		5		=> le.RC5_3,
		'');
		
	SELF.ReasonCode4 := CASE(t,
		1		=> le.RC1_4,
		2		=> le.RC2_4,
		3		=> le.RC3_4,
		4		=> le.RC4_4,
		5		=> le.RC5_4,
		'');
		
	SELF.ReasonCode5 := CASE(t,
		1		=> le.RC1_5,
		2		=> le.RC2_5,
		3		=> le.RC3_5,
		4		=> le.RC4_5,
		5		=> le.RC5_5,
		'');
		
	SELF.ReasonCode6 := CASE(t,
		1		=> le.RC1_6,
		2		=> le.RC2_6,
		3		=> le.RC3_6,
		4		=> le.RC4_6,
		5		=> le.RC5_6,
		'');
		
	SELF := le;
END;
parsedOutput := NORMALIZE(parsedOutputTemp, 5, normScores(LEFT, COUNTER)) ((INTEGER)ModelScore > 0);

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Normalized_Output'));


Parsed_Layout combineParsedRecords(Parsed_Layout_Input_Temp le, Parsed_Layout ri) := TRANSFORM
	// Since the raw ModelName isn't always a part of the response, we need to check and see if it was part of the input
	SELF.ModelName		:= MAP(ri.ModelName = 'AUTO' AND le.RiskViewAutoModel <> ''						=> le.RiskViewAutoModel,
													 ri.ModelName = 'BANKCARD' AND le.RiskViewBankCardModel <> ''		=> le.RiskViewBankCardModel,
													 ri.ModelName = 'TELECOM' AND le.RiskViewTelecomModel <> ''			=> le.RiskViewTelecomModel,
													 ri.ModelName = 'RETAIL' AND le.RiskViewRetailModel <> ''				=> le.RiskViewRetailModel,
													 ri.ModelName = 'MONEY' AND le.RiskViewMoneyServiceModel <> ''	=> le.RiskViewMoneyServiceModel,
													 ri.ModelName = 'PRESCREEN' AND le.RiskViewPrescreenModel <> ''	=> le.RiskViewPrescreenModel,
													 ri.ModelName IN ['FRAUDPOINT','FRAUDDEFENDER'] AND 
															le.FraudPointModel <> ''																		=> le.FraudPointModel,
													 ri.ModelName IN ['FRAUDPOINT','FRAUDDEFENDER'] AND 
															le.FraudPointModel = '' AND 
															le.CustomModelOptionName1 = 'CUSTOM'												=> le.CustomModelOptionValue1,
																																														 ri.ModelName);
	
	SELF.ModelType		:= ri.ModelType;
	SELF.ModelScore		:= ri.ModelScore;
	SELF.ReasonCode1	:= ri.ReasonCode1;
	SELF.ReasonCode2	:= ri.ReasonCode2;
	SELF.ReasonCode3	:= ri.ReasonCode3;
	SELF.ReasonCode4	:= ri.ReasonCode4;
	SELF.ReasonCode5	:= ri.ReasonCode5;
	SELF.ReasonCode6	:= ri.ReasonCode6;
	
	SELF := le;
END;

parsedRecordsTemp := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(5), ATMOST(RiskWise.max_atmost), LOCAL);

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), 
									SELF.TransactionDate := RIGHT.TransactionDate; 
									SELF.AccountID := RIGHT.AccountID; 
									SELF.ProductName := RIGHT.ProductName; 
									SELF.LoginID := RIGHT.LoginID;
									SELF.BillingCode := RIGHT.BillingCode;
									SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));
OUTPUT(COUNT(parsedRecords), NAMED('Total_Fully_Parsed_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, TransactionDate, TransactionID)), AccountID, TransactionDate, TransactionID, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

// OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid(), THOR);