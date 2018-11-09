#workunit('name', 'FraudPoint_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20150601';
EndDate := '20150630';

AccountIDs := ['1609001']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 100;

outputFile := '~bpahl::out::FraudPoint_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

/* ***********************************************************************************************
 *************************************************************************************************
 *             GATHER AND PARSE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                        *
 *************************************************************************************************
 *********************************************************************************************** */

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

LogsRaw_1 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FraudPoint>', '<FraudPoint><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<FraudPoint>' + LEFT.outputxml + '</FraudPoint>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs_1, eyeball), NAMED('Sample_Raw_Logs_1'));

Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	// SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	SELF.Email					:= TRIM(XMLTEXT('SearchBy/Email'));
	SELF.IPAddress			:= TRIM(XMLTEXT('SearchBy/IPAddress'));
	
	SELF.OptionName1    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[1]/OptionName'));
	SELF.OptionValue1   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[1]/OptionValue'));
	SELF.OptionName2    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[2]/OptionName'));
	SELF.OptionValue2   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[2]/OptionValue'));
	SELF.OptionName3    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[3]/OptionName'));
	SELF.OptionValue3   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[3]/OptionValue'));
	SELF.OptionName4    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[4]/OptionName'));
	SELF.OptionValue4   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[4]/OptionValue'));
	SELF.OptionName5    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[5]/OptionName'));
	SELF.OptionValue5   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[5]/OptionValue'));
	SELF.OptionName6    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[6]/OptionName'));
	SELF.OptionValue6   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[6]/OptionValue'));
	SELF.OptionName7    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[7]/OptionName'));
	SELF.OptionValue7   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[7]/OptionValue'));
	SELF.OptionName8    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[8]/OptionName'));
	SELF.OptionValue8   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[8]/OptionValue'));
	SELF.OptionName9    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[9]/OptionName'));
	SELF.OptionValue9   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[9]/OptionValue'));
	SELF.OptionName10   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[10]/OptionName'));
	SELF.OptionValue10  := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[10]/OptionValue'));
	
	SELF := [];
END;
parsedInput_1 := DISTRIBUTE(PARSE(Logs_1, inputxml, parseInput(), XML('FraudPoint')), HASH64(TransactionID));

OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_Parsed_Input_1'));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs_2 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FraudPointRequest>', '<FraudPointRequest><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<FraudPoint>' + LEFT.outputxml + '</FraudPoint>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));			
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Raw_Logs_2'));

Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout parseInput_2 () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	// SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	SELF.Email					:= TRIM(XMLTEXT('SearchBy/Email'));
	SELF.IPAddress			:= TRIM(XMLTEXT('SearchBy/IPAddress'));
	
	SELF.OptionName1    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[1]/OptionName'));
	SELF.OptionValue1   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[1]/OptionValue'));
	SELF.OptionName2    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[2]/OptionName'));
	SELF.OptionValue2   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[2]/OptionValue'));
	SELF.OptionName3    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[3]/OptionName'));
	SELF.OptionValue3   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[3]/OptionValue'));
	SELF.OptionName4    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[4]/OptionName'));
	SELF.OptionValue4   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[4]/OptionValue'));
	SELF.OptionName5    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[5]/OptionName'));
	SELF.OptionValue5   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[5]/OptionValue'));
	SELF.OptionName6    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[6]/OptionName'));
	SELF.OptionValue6   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[6]/OptionValue'));
	SELF.OptionName7    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[7]/OptionName'));
	SELF.OptionValue7   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[7]/OptionValue'));
	SELF.OptionName8    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[8]/OptionName'));
	SELF.OptionValue8   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[8]/OptionValue'));
	SELF.OptionName9    := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[9]/OptionName'));
	SELF.OptionValue9   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[9]/OptionValue'));
	SELF.OptionName10   := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[10]/OptionName'));
	SELF.OptionValue10  := TRIM(XMLTEXT('Options/IncludeModels/ModelRequests[1]/ModelRequest[1]/ModelOptions[1]/ModelOption[10]/OptionValue'));
	
	SELF := [];
END;
parsedInput_2 := DISTRIBUTE(PARSE(Logs_2, inputxml, parseInput_2(), XML('FraudPointRequest')), HASH64(TransactionID));
OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_Parsed_Input_2'));
LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22; //since the rawlog_1 has all the records, we only want the records with the correct XML tags we could link them to

Parsed_Layout_Temp := RECORD
	Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout;
	
	STRING3 Score1 := '';
	STRING3 Score2 := '';
	STRING3 Score3 := '';
	STRING3 Score4 := '';
	STRING3 Score5 := '';
	STRING3 Score6 := '';
	STRING3 Score7 := '';
	STRING3 Score8 := '';
	STRING3 Score9 := '';
	STRING3 Score10 := '';
	
	STRING15 Model1 := '';
	STRING15 Model2 := '';
	STRING15 Model3 := '';
	STRING15 Model4 := '';
	STRING15 Model5 := '';
	STRING15 Model6 := '';
	STRING15 Model7 := '';
	STRING15 Model8 := '';
	STRING15 Model9 := '';
	STRING15 Model10 := '';
	
	STRING5 RC1_1		:= '';
	STRING5 RC1_2		:= '';
	STRING5 RC1_3		:= '';
	STRING5 RC1_4		:= '';
	STRING5 RC1_5		:= '';
	STRING5 RC1_6		:= '';
	STRING5 RC1_7		:= '';
	STRING5 RC1_8		:= '';
	STRING5 RC1_9		:= '';
	STRING5 RC1_10	:= '';
	STRING5 RC2_1		:= '';
	STRING5 RC2_2		:= '';
	STRING5 RC2_3		:= '';
	STRING5 RC2_4		:= '';
	STRING5 RC2_5		:= '';
	STRING5 RC2_6		:= '';
	STRING5 RC2_7		:= '';
	STRING5 RC2_8		:= '';
	STRING5 RC2_9		:= '';
	STRING5 RC2_10	:= '';
	STRING5 RC3_1		:= '';
	STRING5 RC3_2		:= '';
	STRING5 RC3_3		:= '';
	STRING5 RC3_4		:= '';
	STRING5 RC3_5		:= '';
	STRING5 RC3_6		:= '';
	STRING5 RC3_7		:= '';
	STRING5 RC3_8		:= '';
	STRING5 RC3_9		:= '';
	STRING5 RC3_10	:= '';
	STRING5 RC4_1		:= '';
	STRING5 RC4_2		:= '';
	STRING5 RC4_3		:= '';
	STRING5 RC4_4		:= '';
	STRING5 RC4_5		:= '';
	STRING5 RC4_6		:= '';
	STRING5 RC4_7		:= '';
	STRING5 RC4_8		:= '';
	STRING5 RC4_9		:= '';
	STRING5 RC4_10	:= '';
	STRING5 RC5_1		:= '';
	STRING5 RC5_2		:= '';
	STRING5 RC5_3		:= '';
	STRING5 RC5_4		:= '';
	STRING5 RC5_5		:= '';
	STRING5 RC5_6		:= '';
	STRING5 RC5_7		:= '';
	STRING5 RC5_8		:= '';
	STRING5 RC5_9		:= '';
	STRING5 RC5_10	:= '';
	STRING5 RC6_1		:= '';
	STRING5 RC6_2		:= '';
	STRING5 RC6_3		:= '';
	STRING5 RC6_4		:= '';
	STRING5 RC6_5		:= '';
	STRING5 RC6_6		:= '';
	STRING5 RC6_7		:= '';
	STRING5 RC6_8		:= '';
	STRING5 RC6_9		:= '';
	STRING5 RC6_10	:= '';
	STRING5 RC7_1		:= '';
	STRING5 RC7_2		:= '';
	STRING5 RC7_3		:= '';
	STRING5 RC7_4		:= '';
	STRING5 RC7_5		:= '';
	STRING5 RC7_6		:= '';
	STRING5 RC7_7		:= '';
	STRING5 RC7_8		:= '';
	STRING5 RC7_9		:= '';
	STRING5 RC7_10	:= '';
	STRING5 RC8_1		:= '';
	STRING5 RC8_2		:= '';
	STRING5 RC8_3		:= '';
	STRING5 RC8_4		:= '';
	STRING5 RC8_5		:= '';
	STRING5 RC8_6		:= '';
	STRING5 RC8_7		:= '';
	STRING5 RC8_8		:= '';
	STRING5 RC8_9		:= '';
	STRING5 RC8_10	:= '';
	STRING5 RC9_1		:= '';
	STRING5 RC9_2		:= '';
	STRING5 RC9_3		:= '';
	STRING5 RC9_4		:= '';
	STRING5 RC9_5		:= '';
	STRING5 RC9_6		:= '';
	STRING5 RC9_7		:= '';
	STRING5 RC9_8		:= '';
	STRING5 RC9_9		:= '';
	STRING5 RC9_10	:= '';
	STRING5 RC10_1	:= '';
	STRING5 RC10_2	:= '';
	STRING5 RC10_3	:= '';
	STRING5 RC10_4	:= '';
	STRING5 RC10_5	:= '';
	STRING5 RC10_6	:= '';
	STRING5 RC10_7	:= '';
	STRING5 RC10_8	:= '';
	STRING5 RC10_9	:= '';
	STRING5 RC10_10	:= '';
END;

Parsed_Layout_Temp parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	
	SELF.Score1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value'));
	SELF.Score2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Value'));
	SELF.Score3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Value'));
	SELF.Score4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Value'));
	SELF.Score5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Value'));
	SELF.Score6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/Value'));
	SELF.Score7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/Value'));
	SELF.Score8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/Value'));
	SELF.Score9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/Value'));
	SELF.Score10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/Value'));
	
	SELF.Model1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type'));
	SELF.Model2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Type'));
	SELF.Model3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Type'));
	SELF.Model4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Type'));
	SELF.Model5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Type'));
	SELF.Model6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/Type'));
	SELF.Model7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/Type'));
	SELF.Model8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/Type'));
	SELF.Model9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/Type'));
	SELF.Model10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/Type'));
	
	SELF.RC1_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC1_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC1_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC1_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC1_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC1_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC1_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC1_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC1_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC1_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC2_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC2_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC2_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC2_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC2_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC2_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC2_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC2_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC2_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC2_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC3_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC3_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC3_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC3_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC3_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC3_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC3_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC3_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC3_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC3_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC4_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC4_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC4_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC4_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC4_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC4_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC4_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC4_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC4_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC4_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC5_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC5_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC5_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC5_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC5_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC5_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC5_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC5_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC5_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC5_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC6_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC6_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC6_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC6_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC6_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC6_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC6_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC6_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC6_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC6_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC7_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC7_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC7_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC7_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC7_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC7_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC7_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC7_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC7_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC7_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC8_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC8_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC8_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC8_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC8_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC8_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC8_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC8_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC8_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC8_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC9_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC9_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC9_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC9_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC9_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC9_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC9_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC9_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC9_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC9_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF.RC10_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC10_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC10_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC10_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC10_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC10_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC10_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[7]/RiskCode'));
	SELF.RC10_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[8]/RiskCode'));
	SELF.RC10_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[9]/RiskCode'));
	SELF.RC10_10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[10]/RiskCode'));
	
	SELF := [];
END;
parsedOutputTemp_1 := PARSE(Logs_11, outputxml, parseOutput(), XML('FraudPoint'));
parsedOutputTemp_2 := PARSE(Logs_22, outputxml, parseOutput(), XML('FraudPoint'));
parsedOutputTemp := parsedOutputTemp_1 + parsedOutputTemp_2;
OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout normScores(Parsed_Layout_Temp le, UNSIGNED1 t) := TRANSFORM
	SELF.Score := CASE(t,
		1 => le.Score1,
		2 => le.Score2,
		3 => le.Score3,
		4 => le.Score4,
		5 => le.Score5,
		6 => le.Score6,
		7 => le.Score7,
		8 => le.Score8,
		9 => le.Score9,
		10 => le.Score10,
		'');
	SELF.Model := CASE(t,
		1 => le.Model1,
		2 => le.Model2,
		3 => le.Model3,
		4 => le.Model4,
		5 => le.Model5,
		6 => le.Model6,
		7 => le.Model7,
		8 => le.Model8,
		9 => le.Model9,
		10 => le.Model10,
		'');
		
	SELF.RC1 := CASE(t,
		1		=> le.RC1_1,
		2		=> le.RC2_1,
		3		=> le.RC3_1,
		4		=> le.RC4_1,
		5		=> le.RC5_1,
		6		=> le.RC6_1,
		7		=> le.RC7_1,
		8		=> le.RC8_1,
		9		=> le.RC9_1,
		10	=> le.RC10_1,
		'');

	SELF.RC2 := CASE(t,
		1		=> le.RC1_2,
		2		=> le.RC2_2,
		3		=> le.RC3_2,
		4		=> le.RC4_2,
		5		=> le.RC5_2,
		6		=> le.RC6_2,
		7		=> le.RC7_2,
		8		=> le.RC8_2,
		9		=> le.RC9_2,
		10	=> le.RC10_2,
		'');
	
	SELF.RC3 := CASE(t,
		1		=> le.RC1_3,
		2		=> le.RC2_3,
		3		=> le.RC3_3,
		4		=> le.RC4_3,
		5		=> le.RC5_3,
		6		=> le.RC6_3,
		7		=> le.RC7_3,
		8		=> le.RC8_3,
		9		=> le.RC9_3,
		10	=> le.RC10_3,
		'');
		
	SELF.RC4 := CASE(t,
		1		=> le.RC1_4,
		2		=> le.RC2_4,
		3		=> le.RC3_4,
		4		=> le.RC4_4,
		5		=> le.RC5_4,
		6		=> le.RC6_4,
		7		=> le.RC7_4,
		8		=> le.RC8_4,
		9		=> le.RC9_4,
		10	=> le.RC10_4,
		'');
		
	SELF.RC5 := CASE(t,
		1		=> le.RC1_5,
		2		=> le.RC2_5,
		3		=> le.RC3_5,
		4		=> le.RC4_5,
		5		=> le.RC5_5,
		6		=> le.RC6_5,
		7		=> le.RC7_5,
		8		=> le.RC8_5,
		9		=> le.RC9_5,
		10	=> le.RC10_5,
		'');
		
	SELF.RC6 := CASE(t,
		1		=> le.RC1_6,
		2		=> le.RC2_6,
		3		=> le.RC3_6,
		4		=> le.RC4_6,
		5		=> le.RC5_6,
		6		=> le.RC6_6,
		7		=> le.RC7_6,
		8		=> le.RC8_6,
		9		=> le.RC9_6,
		10	=> le.RC10_6,
		'');
		
	SELF.RC7 := CASE(t,
		1		=> le.RC1_7,
		2		=> le.RC2_7,
		3		=> le.RC3_7,
		4		=> le.RC4_7,
		5		=> le.RC5_7,
		6		=> le.RC6_7,
		7		=> le.RC7_7,
		8		=> le.RC8_7,
		9		=> le.RC9_7,
		10	=> le.RC10_7,
		'');
		
	SELF.RC8 := CASE(t,
		1		=> le.RC1_8,
		2		=> le.RC2_8,
		3		=> le.RC3_8,
		4		=> le.RC4_8,
		5		=> le.RC5_8,
		6		=> le.RC6_8,
		7		=> le.RC7_8,
		8		=> le.RC8_8,
		9		=> le.RC9_8,
		10	=> le.RC10_8,
		'');
		
	SELF.RC9 := CASE(t,
		1		=> le.RC1_9,
		2		=> le.RC2_9,
		3		=> le.RC3_9,
		4		=> le.RC4_9,
		5		=> le.RC5_9,
		6		=> le.RC6_9,
		7		=> le.RC7_9,
		8		=> le.RC8_9,
		9		=> le.RC9_9,
		10	=> le.RC10_9,
		'');
		
	SELF.RC10 := CASE(t,
		1		=> le.RC1_10,
		2		=> le.RC2_10,
		3		=> le.RC3_10,
		4		=> le.RC4_10,
		5		=> le.RC5_10,
		6		=> le.RC6_10,
		7		=> le.RC7_10,
		8		=> le.RC8_10,
		9		=> le.RC9_10,
		10	=> le.RC10_10,
		'');
		
	SELF := le;
END;
parsedOutput := NORMALIZE(parsedOutputTemp, 10, normScores(LEFT, COUNTER)) ((INTEGER)Score > 0);

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Normalized_Output'));

Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout le, Risk_Reporting.Layouts.Parsed_FraudAdvisor_Layout ri) := TRANSFORM
	SELF.Score	:= ri.Score;
	SELF.Model	:= ri.Model;
	SELF.RC1		:= ri.RC1;
	SELF.RC2		:= ri.RC2;
	SELF.RC3		:= ri.RC3;
	SELF.RC4		:= ri.RC4;
	SELF.RC5		:= ri.RC5;
	SELF.RC6		:= ri.RC6;
	SELF.RC7		:= ri.RC7;
	SELF.RC8		:= ri.RC8;
	SELF.RC9		:= ri.RC9;
	SELF.RC10		:= ri.RC10;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp_in := parsedInput_1+parsedInput_2 ;
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedRecordsTemp_in, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(10), ATMOST(RiskWise.max_atmost), LOCAL) (TRIM(StringLib.StringToUpperCase(model)) NOT IN ['', '00 TO 50', '10 TO 50']);

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));
OUTPUT(COUNT(parsedRecords), NAMED('Total_Fully_Parsed_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, TransactionDate, TransactionID)), AccountID, TransactionDate, TransactionID, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));
// table(finalRecords(AccountID = '1534586' and TransactionDate between BeginDate and enddate), {TransactionDate,  cnt := count(group)}, TransactionDate,  few);
   

OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);