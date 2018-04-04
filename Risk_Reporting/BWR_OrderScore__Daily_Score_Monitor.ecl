#workunit('name', 'Order_Score_Daily_Score_Monitor');

// #option('allowedClusters', 'thor400_20,thor400_44,thor400_60'); // This workunit can run on these clusters
// #option('AllowAutoQueueSwitch', TRUE); // If the current queue is full, use an available cluster from above

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

// Pull logs for the past year to do our rolling Average on
EndDate := ut.GetDate;
BeginDateTemp := ut.date_math(EndDate, -365);//'20160501';//
BeginDate := IF(BeginDateTemp >= '20160501', BeginDateTemp, '20160501'); // Tracking didn't fully start until this date, eliminate the "test" days before this date.

eyeball := 100;

/* ***********************************************************************************************
 *************************************************************************************************
 *             GATHER AND PARSE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                        *
 *************************************************************************************************
 *********************************************************************************************** */

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

LogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['ORDERSCORE'] AND 
		datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) 
		NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs
		)));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<OrderScore>', '<OrderScore><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<OrderScore>' + LEFT.outputxml + '</OrderScore>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs_1, eyeball), NAMED('Sample_Raw_Logs_1'));

Risk_Reporting.Layouts.Parsed_OrderScore_Layout parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.OrderType 			:= TRIM(XMLTEXT('Options/OrderType'));

	SELF.FullName				:= TRIM(XMLTEXT('SearchBy/BillTo/Name/Full'));
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/BillTo/Name/First'));
	SELF.MiddleName			:= TRIM(XMLTEXT('SearchBy/BillTo/Name/Middle'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/BillTo/Name/Last'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/BillTo/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/BillTo/DOB')) + 
												Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/BillTo/DOB/Year'), 
												XMLTEXT('SearchBy/BillTo/DOB/Month'), XMLTEXT('SearchBy/BillTo/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/BillTo/Address/StreetAddress1'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetAddress2'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetNumber'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetPreDirection'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetName'),
												XMLTEXT('SearchBy/BillTo/Address/StreetSuffix'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetPostDirection'), 
												XMLTEXT('SearchBy/BillTo/Address/UnitDesignation'),
												XMLTEXT('SearchBy/BillTo/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/BillTo/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/BillTo/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/BillTo/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/BillTo/DriverLicenseNumber'));
	SELF.DLState				:= TRIM(XMLTEXT('SearchBy/BillTo/DriverLicenseState'));

	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/BillTo/Phone10'));
	//SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	SELF.Email					:= TRIM(XMLTEXT('SearchBy/BillTo/EmailAddress'));
	SELF.IPAddress			:= TRIM(XMLTEXT('SearchBy/BillTo/IPAddress'));
	//Ship to
	SELF.FullName2				:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/Full'));
	SELF.FirstName2			:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/First'));
	SELF.MiddleName2			:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/Middle'));
	SELF.LastName2				:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/Last'));
	SELF.DOB2						:= TRIM(XMLTEXT('SearchBy/ShipTo/DOB')) + 
												Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/ShipTo/DOB/Year'), 
												XMLTEXT('SearchBy/ShipTo/DOB/Month'), XMLTEXT('SearchBy/ShipTo/DOB/Day'));
	SELF.Address2				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/ShipTo/Address/StreetAddress1'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetAddress2'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetNumber'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetPreDirection'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetName'),
												XMLTEXT('SearchBy/ShipTo/Address/StreetSuffix2'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetPostDirection'), 
												XMLTEXT('SearchBy/ShipTo/Address/UnitDesignation'),
												XMLTEXT('SearchBy/ShipTo/Address/UnitNumber'));
	SELF.City2						:= TRIM(XMLTEXT('SearchBy/ShipTo/Address/City'));
	SELF.State2					:= TRIM(XMLTEXT('SearchBy/ShipTo/Address/State'));
	SELF.Zip2						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/ShipTo/Address/Zip5'));
	SELF.DL2						:= TRIM(XMLTEXT('SearchBy/ShipTo/DriverLicenseNumber'));
	SELF.DLState2				:= TRIM(XMLTEXT('SearchBy/ShipTo/DriverLicenseState'));
	SELF.HomePhone2			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/ShipTo/Phone10'));
	SELF.Email2					:= TRIM(XMLTEXT('SearchBy/ShipTo/EmailAddress'));
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
parsedInput_1 := PARSE(Logs_1, inputxml, parseInput(), XML('OrderScore1'));
OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_parsedInput_1'));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);

Logs_2 := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<OrderScoreRequest>', '<OrderScoreRequest><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<OrderScore>' + LEFT.outputxml + '</OrderScore>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Raw_Logs_2'));

Risk_Reporting.Layouts.Parsed_OrderScore_Layout parseInput2 () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.OrderType 			:= TRIM(XMLTEXT('Options/OrderType'));

	SELF.FullName				:= TRIM(XMLTEXT('SearchBy/BillTo/Name/Full'));
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/BillTo/Name/First'));
	SELF.MiddleName			:= TRIM(XMLTEXT('SearchBy/BillTo/Name/Middle'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/BillTo/Name/Last'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/BillTo/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/BillTo/DOB')) + 
												Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/BillTo/DOB/Year'), 
												XMLTEXT('SearchBy/BillTo/DOB/Month'), XMLTEXT('SearchBy/BillTo/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/BillTo/Address/StreetAddress1'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetAddress2'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetNumber'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetPreDirection'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetName'),
												XMLTEXT('SearchBy/BillTo/Address/StreetSuffix'), 
												XMLTEXT('SearchBy/BillTo/Address/StreetPostDirection'), 
												XMLTEXT('SearchBy/BillTo/Address/UnitDesignation'),
												XMLTEXT('SearchBy/BillTo/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/BillTo/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/BillTo/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/BillTo/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/BillTo/DriverLicenseNumber'));
	SELF.DLState				:= TRIM(XMLTEXT('SearchBy/BillTo/DriverLicenseState'));

	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/BillTo/Phone10'));
	//SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	SELF.Email					:= TRIM(XMLTEXT('SearchBy/BillTo/EmailAddress'));
	SELF.IPAddress			:= TRIM(XMLTEXT('SearchBy/BillTo/IPAddress'));
	//Ship to
	SELF.FullName2				:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/Full'));
	SELF.FirstName2			:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/First'));
	SELF.MiddleName2			:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/Middle'));
	SELF.LastName2				:= TRIM(XMLTEXT('SearchBy/ShipTo/Name/Last'));
	SELF.DOB2						:= TRIM(XMLTEXT('SearchBy/ShipTo/DOB')) + 
												Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/ShipTo/DOB/Year'), 
												XMLTEXT('SearchBy/ShipTo/DOB/Month'), XMLTEXT('SearchBy/ShipTo/DOB/Day'));
	SELF.Address2				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/ShipTo/Address/StreetAddress1'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetAddress2'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetNumber'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetPreDirection'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetName'),
												XMLTEXT('SearchBy/ShipTo/Address/StreetSuffix2'), 
												XMLTEXT('SearchBy/ShipTo/Address/StreetPostDirection'), 
												XMLTEXT('SearchBy/ShipTo/Address/UnitDesignation'),
												XMLTEXT('SearchBy/ShipTo/Address/UnitNumber'));
	SELF.City2						:= TRIM(XMLTEXT('SearchBy/ShipTo/Address/City'));
	SELF.State2					:= TRIM(XMLTEXT('SearchBy/ShipTo/Address/State'));
	SELF.Zip2						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/ShipTo/Address/Zip5'));
	SELF.DL2						:= TRIM(XMLTEXT('SearchBy/ShipTo/DriverLicenseNumber'));
	SELF.DLState2				:= TRIM(XMLTEXT('SearchBy/ShipTo/DriverLicenseState'));
	SELF.HomePhone2			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/ShipTo/Phone10'));
	SELF.Email2					:= TRIM(XMLTEXT('SearchBy/ShipTo/EmailAddress'));
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
parsedInput_2 := PARSE(Logs_2, inputxml, parseInput2(), XML('OrderScoreRequest'));
OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_parsedInput_2'));
LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22; 

Parsed_Layout_Temp := RECORD
	Risk_Reporting.Layouts.Parsed_OrderScore_Layout;
	
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
	
	SELF.RC1_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC1_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC1_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC1_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.RC1_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.RC1_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.RC1_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.RC1_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.RC1_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.RC1_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	
	SELF.RC2_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC2_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC2_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC2_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC2_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC2_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC2_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC2_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC2_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC2_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC3_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC3_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC3_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC3_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC3_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC3_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC3_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC3_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC3_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC3_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC4_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC4_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC4_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC4_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC4_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC4_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC4_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC4_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC4_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC4_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC5_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC5_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC5_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC5_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC5_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC5_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC5_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC5_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC5_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC5_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC6_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC6_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC6_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC6_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC6_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC6_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC6_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC6_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC6_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC6_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC7_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC7_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC7_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC7_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC7_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC7_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC7_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC7_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC7_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC7_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC8_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC8_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC8_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC8_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC8_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC8_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC8_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC8_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC8_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC8_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC9_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC9_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC9_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC9_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC9_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC9_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC9_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC9_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC9_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC9_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF.RC10_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC10_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC10_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC10_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	SELF.RC10_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[5]/RiskCode'));
	SELF.RC10_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[1]/RiskIndicators[1]//RiskIndicator[6]/RiskCode'));
	SELF.RC10_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[1]/RiskCode'));
	SELF.RC10_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[2]/RiskCode'));
	SELF.RC10_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[3]/RiskCode'));
	SELF.RC10_10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/RiskIndicatorSets[1]/RiskIndicatorSet[2]/RiskIndicators[1]//RiskIndicator[4]/RiskCode'));
	
	SELF := [];
END;
parsedOutputTemp_1 := PARSE(Logs_11, outputxml, parseOutput(), XML('OrderScore'));
parsedOutputTemp_2 := PARSE(Logs_22, outputxml, parseOutput(), XML('OrderScore'));
parsedOutputTemp := parsedOutputTemp_1 + parsedOutputTemp_2;
OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_OrderScore_Layout normScores(Parsed_Layout_Temp le, UNSIGNED1 t) := TRANSFORM
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

Risk_Reporting.Layouts.Parsed_OrderScore_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_OrderScore_Layout le, Risk_Reporting.Layouts.Parsed_OrderScore_Layout ri) := TRANSFORM
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
parsedRecordsTemp := JOIN(parsedRecordsTemp_in, parsedOutput, 
	LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), 
	KEEP(10), ATMOST(RiskWise.max_atmost)) 
	(TRIM(StringLib.StringToUpperCase(model)) NOT IN ['', '00 TO 50', '10 TO 50']);

parsedRecords := JOIN(parsedRecordsTemp, Logs, 
	LEFT.TransactionID = RIGHT.TransactionID, 
	TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; 
	SELF.AccountID := RIGHT.AccountID; SELF := LEFT));

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));
OUTPUT(COUNT(parsedRecords), NAMED('Total_Fully_Parsed_Records'));

finalRecords := SORT(parsedRecords, TransactionDate);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

/* ***********************************************************************************************
 *************************************************************************************************
 *                                    CALCULATE PERCENTAGES/COUNTS                               *
 *************************************************************************************************
 *********************************************************************************************** */
trackingLayout := RECORD
	// General Statistics
	STRING8 Date_Of_Report															:= finalRecords.TransactionDate;
	UNSIGNED8 Total_Number_Of_Transactions							:= COUNT(GROUP);
	UNSIGNED8 Number_Of_Unique_Account_IDs_Transacted		:= 0;
	
	// Input Population Statistics
	DECIMAL6_3	Percent_First_Name_Populated := (COUNT(GROUP, finalRecords.FirstName <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Last_Name_Populated := (COUNT(GROUP, finalRecords.LastName <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_SSN_Populated		:= (COUNT(GROUP, finalRecords.SSN <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_DOB_Populated		:= (COUNT(GROUP, finalRecords.DOB <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Address_Populated:= (COUNT(GROUP, finalRecords.Address <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_City_Populated	:= (COUNT(GROUP, finalRecords.City <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_State_Populated	:= (COUNT(GROUP, finalRecords.State <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Zip_Populated		:= (COUNT(GROUP, finalRecords.Zip <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_DL_Populated		:= (COUNT(GROUP, finalRecords.DL <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Home_Phone_Populated := (COUNT(GROUP, finalRecords.HomePhone <> '') / COUNT(GROUP)) * 100;
//	DECIMAL6_3	Percent_Work_Phone_Populated := (COUNT(GROUP, finalRecords.WorkPhone <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Email_Populated := (COUNT(GROUP, finalRecords.Email <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_IP_Address_Populated := (COUNT(GROUP, finalRecords.IPAddress <> '') / COUNT(GROUP)) * 100;
//ORDER TYPE
	DECIMAL6_3	Percent_Physical_OrderType_Populated := (COUNT(GROUP, StringLib.StringToUpperCase(TRIM(finalRecords.OrderType)) <> 'DIGITAL' and finalRecords.OrderType <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Digital_OrderType_Populated:= (COUNT(GROUP, StringLib.StringToUpperCase(TRIM(finalRecords.OrderType)) <> 'PHYSICAL' and finalRecords.OrderType <> '') / COUNT(GROUP)) * 100;
//SHIPPIN
	DECIMAL6_3	Percent_Address2_Populated:= (COUNT(GROUP, finalRecords.Address2 <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_City2_Populated	:= (COUNT(GROUP, finalRecords.City2 <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_State2_Populated	:= (COUNT(GROUP, finalRecords.State2 <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Zip2_Populated		:= (COUNT(GROUP, finalRecords.Zip2 <> '') / COUNT(GROUP)) * 100;
	
	// Score Bucket Statistics
	DECIMAL6_3	Percent_Scored_200			:= (COUNT(GROUP, (INTEGER)finalRecords.Score = 200) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_201			:= (COUNT(GROUP, (INTEGER)finalRecords.Score = 201) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_202			:= (COUNT(GROUP, (INTEGER)finalRecords.Score = 202) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_203			:= (COUNT(GROUP, (INTEGER)finalRecords.Score = 203) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_222			:= (COUNT(GROUP, (INTEGER)finalRecords.Score = 222) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_300_350 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 300 AND 350) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_351_400 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 351 AND 400) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_401_450 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 401 AND 450) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_451_500 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 451 AND 500) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_501_550 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 501 AND 550) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_551_600 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 551 AND 600) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_601_650 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 601 AND 650) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_651_700 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 651 AND 700) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_701_750 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 701 AND 750) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Between_751_900 := (COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 751 AND 900) / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Scored_Above_900:= (COUNT(GROUP, (INTEGER)finalRecords.Score > 900) / COUNT(GROUP)) * 100;
	
	UNSIGNED2		Average_Score_Excluding_Exceptions			:= ROUND(SUM(GROUP, IF((INTEGER)finalRecords.Score BETWEEN 223 AND 900, (INTEGER)finalRecords.Score, 0)) / COUNT(GROUP, (INTEGER)finalRecords.Score BETWEEN 223 AND 900));
	
	// Reason Code Population Statistics
	DECIMAL6_3	Percent_RC_04						:=	(COUNT(GROUP, finalRecords.RC1 = '04' OR finalRecords.RC2 = '04' OR finalRecords.RC3 = '04' OR finalRecords.RC4 = '04' OR finalRecords.RC5 = '04' OR finalRecords.RC6 = '04' OR finalRecords.RC7 = '04' OR finalRecords.RC8 = '04' OR finalRecords.RC9 = '04' OR finalRecords.RC10 = '04') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_07						:=	(COUNT(GROUP, finalRecords.RC1 = '07' OR finalRecords.RC2 = '07' OR finalRecords.RC3 = '07' OR finalRecords.RC4 = '07' OR finalRecords.RC5 = '07' OR finalRecords.RC6 = '07' OR finalRecords.RC7 = '07' OR finalRecords.RC8 = '07' OR finalRecords.RC9 = '07' OR finalRecords.RC10 = '07') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_08						:=	(COUNT(GROUP, finalRecords.RC1 = '08' OR finalRecords.RC2 = '08' OR finalRecords.RC3 = '08' OR finalRecords.RC4 = '08' OR finalRecords.RC5 = '08' OR finalRecords.RC6 = '08' OR finalRecords.RC7 = '08' OR finalRecords.RC8 = '08' OR finalRecords.RC9 = '08' OR finalRecords.RC10 = '08') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_09						:=	(COUNT(GROUP, finalRecords.RC1 = '09' OR finalRecords.RC2 = '09' OR finalRecords.RC3 = '09' OR finalRecords.RC4 = '09' OR finalRecords.RC5 = '09' OR finalRecords.RC6 = '09' OR finalRecords.RC7 = '09' OR finalRecords.RC8 = '09' OR finalRecords.RC9 = '09' OR finalRecords.RC10 = '09') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_10						:=	(COUNT(GROUP, finalRecords.RC1 = '10' OR finalRecords.RC2 = '10' OR finalRecords.RC3 = '10' OR finalRecords.RC4 = '10' OR finalRecords.RC5 = '10' OR finalRecords.RC6 = '10' OR finalRecords.RC7 = '10' OR finalRecords.RC8 = '10' OR finalRecords.RC9 = '10' OR finalRecords.RC10 = '10') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_11						:=	(COUNT(GROUP, finalRecords.RC1 = '11' OR finalRecords.RC2 = '11' OR finalRecords.RC3 = '11' OR finalRecords.RC4 = '11' OR finalRecords.RC5 = '11' OR finalRecords.RC6 = '11' OR finalRecords.RC7 = '11' OR finalRecords.RC8 = '11' OR finalRecords.RC9 = '11' OR finalRecords.RC10 = '11') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_13						:=	(COUNT(GROUP, finalRecords.RC1 = '13' OR finalRecords.RC2 = '13' OR finalRecords.RC3 = '13' OR finalRecords.RC4 = '13' OR finalRecords.RC5 = '13' OR finalRecords.RC6 = '13' OR finalRecords.RC7 = '13' OR finalRecords.RC8 = '13' OR finalRecords.RC9 = '13' OR finalRecords.RC10 = '13') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_14						:=	(COUNT(GROUP, finalRecords.RC1 = '14' OR finalRecords.RC2 = '14' OR finalRecords.RC3 = '14' OR finalRecords.RC4 = '14' OR finalRecords.RC5 = '14' OR finalRecords.RC6 = '14' OR finalRecords.RC7 = '14' OR finalRecords.RC8 = '14' OR finalRecords.RC9 = '14' OR finalRecords.RC10 = '14') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_15						:=	(COUNT(GROUP, finalRecords.RC1 = '15' OR finalRecords.RC2 = '15' OR finalRecords.RC3 = '15' OR finalRecords.RC4 = '15' OR finalRecords.RC5 = '15' OR finalRecords.RC6 = '15' OR finalRecords.RC7 = '15' OR finalRecords.RC8 = '15' OR finalRecords.RC9 = '15' OR finalRecords.RC10 = '15') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_16						:=	(COUNT(GROUP, finalRecords.RC1 = '16' OR finalRecords.RC2 = '16' OR finalRecords.RC3 = '16' OR finalRecords.RC4 = '16' OR finalRecords.RC5 = '16' OR finalRecords.RC6 = '16' OR finalRecords.RC7 = '16' OR finalRecords.RC8 = '16' OR finalRecords.RC9 = '16' OR finalRecords.RC10 = '16') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_19						:=	(COUNT(GROUP, finalRecords.RC1 = '19' OR finalRecords.RC2 = '19' OR finalRecords.RC3 = '19' OR finalRecords.RC4 = '19' OR finalRecords.RC5 = '19' OR finalRecords.RC6 = '19' OR finalRecords.RC7 = '19' OR finalRecords.RC8 = '19' OR finalRecords.RC9 = '19' OR finalRecords.RC10 = '19') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_25						:=	(COUNT(GROUP, finalRecords.RC1 = '25' OR finalRecords.RC2 = '25' OR finalRecords.RC3 = '25' OR finalRecords.RC4 = '25' OR finalRecords.RC5 = '25' OR finalRecords.RC6 = '25' OR finalRecords.RC7 = '25' OR finalRecords.RC8 = '25' OR finalRecords.RC9 = '25' OR finalRecords.RC10 = '25') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_27						:=	(COUNT(GROUP, finalRecords.RC1 = '27' OR finalRecords.RC2 = '27' OR finalRecords.RC3 = '27' OR finalRecords.RC4 = '27' OR finalRecords.RC5 = '27' OR finalRecords.RC6 = '27' OR finalRecords.RC7 = '27' OR finalRecords.RC8 = '27' OR finalRecords.RC9 = '27' OR finalRecords.RC10 = '27') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_30						:=	(COUNT(GROUP, finalRecords.RC1 = '30' OR finalRecords.RC2 = '30' OR finalRecords.RC3 = '30' OR finalRecords.RC4 = '30' OR finalRecords.RC5 = '30' OR finalRecords.RC6 = '30' OR finalRecords.RC7 = '30' OR finalRecords.RC8 = '30' OR finalRecords.RC9 = '30' OR finalRecords.RC10 = '30') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_31						:=	(COUNT(GROUP, finalRecords.RC1 = '31' OR finalRecords.RC2 = '31' OR finalRecords.RC3 = '31' OR finalRecords.RC4 = '31' OR finalRecords.RC5 = '31' OR finalRecords.RC6 = '31' OR finalRecords.RC7 = '31' OR finalRecords.RC8 = '31' OR finalRecords.RC9 = '31' OR finalRecords.RC10 = '31') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_37						:=	(COUNT(GROUP, finalRecords.RC1 = '37' OR finalRecords.RC2 = '37' OR finalRecords.RC3 = '37' OR finalRecords.RC4 = '37' OR finalRecords.RC5 = '37' OR finalRecords.RC6 = '37' OR finalRecords.RC7 = '37' OR finalRecords.RC8 = '37' OR finalRecords.RC9 = '37' OR finalRecords.RC10 = '37') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_40						:=	(COUNT(GROUP, finalRecords.RC1 = '40' OR finalRecords.RC2 = '40' OR finalRecords.RC3 = '40' OR finalRecords.RC4 = '40' OR finalRecords.RC5 = '40' OR finalRecords.RC6 = '40' OR finalRecords.RC7 = '40' OR finalRecords.RC8 = '40' OR finalRecords.RC9 = '40' OR finalRecords.RC10 = '40') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_43						:=	(COUNT(GROUP, finalRecords.RC1 = '43' OR finalRecords.RC2 = '43' OR finalRecords.RC3 = '43' OR finalRecords.RC4 = '43' OR finalRecords.RC5 = '43' OR finalRecords.RC6 = '43' OR finalRecords.RC7 = '43' OR finalRecords.RC8 = '43' OR finalRecords.RC9 = '43' OR finalRecords.RC10 = '43') / COUNT(GROUP)) * 100;	
	DECIMAL6_3	Percent_RC_50						:=	(COUNT(GROUP, finalRecords.RC1 = '50' OR finalRecords.RC2 = '50' OR finalRecords.RC3 = '50' OR finalRecords.RC4 = '50' OR finalRecords.RC5 = '50' OR finalRecords.RC6 = '50' OR finalRecords.RC7 = '50' OR finalRecords.RC8 = '50' OR finalRecords.RC9 = '50' OR finalRecords.RC10 = '50') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_75						:=	(COUNT(GROUP, finalRecords.RC1 = '75' OR finalRecords.RC2 = '75' OR finalRecords.RC3 = '75' OR finalRecords.RC4 = '75' OR finalRecords.RC5 = '75' OR finalRecords.RC6 = '75' OR finalRecords.RC7 = '75' OR finalRecords.RC8 = '75' OR finalRecords.RC9 = '75' OR finalRecords.RC10 = '75') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_76						:=	(COUNT(GROUP, finalRecords.RC1 = '76' OR finalRecords.RC2 = '76' OR finalRecords.RC3 = '76' OR finalRecords.RC4 = '76' OR finalRecords.RC5 = '76' OR finalRecords.RC6 = '76' OR finalRecords.RC7 = '76' OR finalRecords.RC8 = '76' OR finalRecords.RC9 = '76' OR finalRecords.RC10 = '76') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_77						:=	(COUNT(GROUP, finalRecords.RC1 = '77' OR finalRecords.RC2 = '77' OR finalRecords.RC3 = '77' OR finalRecords.RC4 = '77' OR finalRecords.RC5 = '77' OR finalRecords.RC6 = '77' OR finalRecords.RC7 = '77' OR finalRecords.RC8 = '77' OR finalRecords.RC9 = '77' OR finalRecords.RC10 = '77') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_78						:=	(COUNT(GROUP, finalRecords.RC1 = '78' OR finalRecords.RC2 = '78' OR finalRecords.RC3 = '78' OR finalRecords.RC4 = '78' OR finalRecords.RC5 = '78' OR finalRecords.RC6 = '78' OR finalRecords.RC7 = '78' OR finalRecords.RC8 = '78' OR finalRecords.RC9 = '78' OR finalRecords.RC10 = '78') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_80						:=	(COUNT(GROUP, finalRecords.RC1 = '80' OR finalRecords.RC2 = '80' OR finalRecords.RC3 = '80' OR finalRecords.RC4 = '80' OR finalRecords.RC5 = '80' OR finalRecords.RC6 = '80' OR finalRecords.RC7 = '80' OR finalRecords.RC8 = '80' OR finalRecords.RC9 = '80' OR finalRecords.RC10 = '80') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_82						:=	(COUNT(GROUP, finalRecords.RC1 = '82' OR finalRecords.RC2 = '82' OR finalRecords.RC3 = '82' OR finalRecords.RC4 = '82' OR finalRecords.RC5 = '82' OR finalRecords.RC6 = '82' OR finalRecords.RC7 = '82' OR finalRecords.RC8 = '82' OR finalRecords.RC9 = '82' OR finalRecords.RC10 = '82') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O1						:=	(COUNT(GROUP, finalRecords.RC1 = 'O1' OR finalRecords.RC2 = 'O1' OR finalRecords.RC3 = 'O1' OR finalRecords.RC4 = 'O1' OR finalRecords.RC5 = 'O1' OR finalRecords.RC6 = 'O1' OR finalRecords.RC7 = 'O1' OR finalRecords.RC8 = 'O1' OR finalRecords.RC9 = 'O1' OR finalRecords.RC10 = 'O1') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O2						:=	(COUNT(GROUP, finalRecords.RC1 = 'O2' OR finalRecords.RC2 = 'O2' OR finalRecords.RC3 = 'O2' OR finalRecords.RC4 = 'O2' OR finalRecords.RC5 = 'O2' OR finalRecords.RC6 = 'O2' OR finalRecords.RC7 = 'O2' OR finalRecords.RC8 = 'O2' OR finalRecords.RC9 = 'O2' OR finalRecords.RC10 = 'O2') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O3						:=	(COUNT(GROUP, finalRecords.RC1 = 'O3' OR finalRecords.RC2 = 'O3' OR finalRecords.RC3 = 'O3' OR finalRecords.RC4 = 'O3' OR finalRecords.RC5 = 'O3' OR finalRecords.RC6 = 'O3' OR finalRecords.RC7 = 'O3' OR finalRecords.RC8 = 'O3' OR finalRecords.RC9 = 'O3' OR finalRecords.RC10 = 'O3') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O4						:=	(COUNT(GROUP, finalRecords.RC1 = 'O4' OR finalRecords.RC2 = 'O4' OR finalRecords.RC3 = 'O4' OR finalRecords.RC4 = 'O4' OR finalRecords.RC5 = 'O4' OR finalRecords.RC6 = 'O4' OR finalRecords.RC7 = 'O4' OR finalRecords.RC8 = 'O4' OR finalRecords.RC9 = 'O4' OR finalRecords.RC10 = 'O4') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O5						:=	(COUNT(GROUP, finalRecords.RC1 = 'O5' OR finalRecords.RC2 = 'O5' OR finalRecords.RC3 = 'O5' OR finalRecords.RC4 = 'O5' OR finalRecords.RC5 = 'O5' OR finalRecords.RC6 = 'O5' OR finalRecords.RC7 = 'O5' OR finalRecords.RC8 = 'O5' OR finalRecords.RC9 = 'O5' OR finalRecords.RC10 = 'O5') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O6						:=	(COUNT(GROUP, finalRecords.RC1 = 'O6' OR finalRecords.RC2 = 'O6' OR finalRecords.RC3 = 'O6' OR finalRecords.RC4 = 'O6' OR finalRecords.RC5 = 'O6' OR finalRecords.RC6 = 'O6' OR finalRecords.RC7 = 'O6' OR finalRecords.RC8 = 'O6' OR finalRecords.RC9 = 'O6' OR finalRecords.RC10 = 'O6') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_O7						:=	(COUNT(GROUP, finalRecords.RC1 = 'O7' OR finalRecords.RC2 = 'O7' OR finalRecords.RC3 = 'O7' OR finalRecords.RC4 = 'O7' OR finalRecords.RC5 = 'O7' OR finalRecords.RC6 = 'O7' OR finalRecords.RC7 = 'O7' OR finalRecords.RC8 = 'O7' OR finalRecords.RC9 = 'O7' OR finalRecords.RC10 = 'O7') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_S1						:=	(COUNT(GROUP, finalRecords.RC1 = 'S1' OR finalRecords.RC2 = 'S1' OR finalRecords.RC3 = 'S1' OR finalRecords.RC4 = 'S1' OR finalRecords.RC5 = 'S1' OR finalRecords.RC6 = 'S1' OR finalRecords.RC7 = 'S1' OR finalRecords.RC8 = 'S1' OR finalRecords.RC9 = 'S1' OR finalRecords.RC10 = 'S1') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_S2						:=	(COUNT(GROUP, finalRecords.RC1 = 'S2' OR finalRecords.RC2 = 'S2' OR finalRecords.RC3 = 'S2' OR finalRecords.RC4 = 'S2' OR finalRecords.RC5 = 'S2' OR finalRecords.RC6 = 'S2' OR finalRecords.RC7 = 'S2' OR finalRecords.RC8 = 'S2' OR finalRecords.RC9 = 'S2' OR finalRecords.RC10 = 'S2') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_S3						:=	(COUNT(GROUP, finalRecords.RC1 = 'S3' OR finalRecords.RC2 = 'S3' OR finalRecords.RC3 = 'S3' OR finalRecords.RC4 = 'S3' OR finalRecords.RC5 = 'S3' OR finalRecords.RC6 = 'S3' OR finalRecords.RC7 = 'S3' OR finalRecords.RC8 = 'S3' OR finalRecords.RC9 = 'S3' OR finalRecords.RC10 = 'S3') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_S4						:=	(COUNT(GROUP, finalRecords.RC1 = 'S4' OR finalRecords.RC2 = 'S4' OR finalRecords.RC3 = 'S4' OR finalRecords.RC4 = 'S4' OR finalRecords.RC5 = 'S4' OR finalRecords.RC6 = 'S4' OR finalRecords.RC7 = 'S4' OR finalRecords.RC8 = 'S4' OR finalRecords.RC9 = 'S4' OR finalRecords.RC10 = 'S4') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_S5						:=	(COUNT(GROUP, finalRecords.RC1 = 'S5' OR finalRecords.RC2 = 'S5' OR finalRecords.RC3 = 'S5' OR finalRecords.RC4 = 'S5' OR finalRecords.RC5 = 'S5' OR finalRecords.RC6 = 'S5' OR finalRecords.RC7 = 'S5' OR finalRecords.RC8 = 'S5' OR finalRecords.RC9 = 'S5' OR finalRecords.RC10 = 'S5') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_IA						:=	(COUNT(GROUP, finalRecords.RC1 = 'IA' OR finalRecords.RC2 = 'IA' OR finalRecords.RC3 = 'IA' OR finalRecords.RC4 = 'IA' OR finalRecords.RC5 = 'IA' OR finalRecords.RC6 = 'IA' OR finalRecords.RC7 = 'IA' OR finalRecords.RC8 = 'IA' OR finalRecords.RC9 = 'IA' OR finalRecords.RC10 = 'IA') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_IB						:=	(COUNT(GROUP, finalRecords.RC1 = 'IB' OR finalRecords.RC2 = 'IB' OR finalRecords.RC3 = 'IB' OR finalRecords.RC4 = 'IB' OR finalRecords.RC5 = 'IB' OR finalRecords.RC6 = 'IB' OR finalRecords.RC7 = 'IB' OR finalRecords.RC8 = 'IB' OR finalRecords.RC9 = 'IB' OR finalRecords.RC10 = 'IB') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_IC						:=	(COUNT(GROUP, finalRecords.RC1 = 'IC' OR finalRecords.RC2 = 'IC' OR finalRecords.RC3 = 'IC' OR finalRecords.RC4 = 'IC' OR finalRecords.RC5 = 'IC' OR finalRecords.RC6 = 'IC' OR finalRecords.RC7 = 'IC' OR finalRecords.RC8 = 'IC' OR finalRecords.RC9 = 'IC' OR finalRecords.RC10 = 'IC') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_ID						:=	(COUNT(GROUP, finalRecords.RC1 = 'ID' OR finalRecords.RC2 = 'ID' OR finalRecords.RC3 = 'ID' OR finalRecords.RC4 = 'ID' OR finalRecords.RC5 = 'ID' OR finalRecords.RC6 = 'ID' OR finalRecords.RC7 = 'ID' OR finalRecords.RC8 = 'ID' OR finalRecords.RC9 = 'ID' OR finalRecords.RC10 = 'ID') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_IE						:=	(COUNT(GROUP, finalRecords.RC1 = 'IE' OR finalRecords.RC2 = 'IE' OR finalRecords.RC3 = 'IE' OR finalRecords.RC4 = 'IE' OR finalRecords.RC5 = 'IE' OR finalRecords.RC6 = 'IE' OR finalRecords.RC7 = 'IE' OR finalRecords.RC8 = 'IE' OR finalRecords.RC9 = 'IE' OR finalRecords.RC10 = 'IE') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_IF						:=	(COUNT(GROUP, finalRecords.RC1 = 'IF' OR finalRecords.RC2 = 'IF' OR finalRecords.RC3 = 'IF' OR finalRecords.RC4 = 'IF' OR finalRecords.RC5 = 'IF' OR finalRecords.RC6 = 'IF' OR finalRecords.RC7 = 'IF' OR finalRecords.RC8 = 'IF' OR finalRecords.RC9 = 'IF' OR finalRecords.RC10 = 'IF') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_IG						:=	(COUNT(GROUP, finalRecords.RC1 = 'IG' OR finalRecords.RC2 = 'IG' OR finalRecords.RC3 = 'IG' OR finalRecords.RC4 = 'IG' OR finalRecords.RC5 = 'IG' OR finalRecords.RC6 = 'IG' OR finalRecords.RC7 = 'IG' OR finalRecords.RC8 = 'IG' OR finalRecords.RC9 = 'IG' OR finalRecords.RC10 = 'IG') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_AS						:=	(COUNT(GROUP, finalRecords.RC1 = 'AS' OR finalRecords.RC2 = 'AS' OR finalRecords.RC3 = 'AS' OR finalRecords.RC4 = 'AS' OR finalRecords.RC5 = 'AS' OR finalRecords.RC6 = 'AS' OR finalRecords.RC7 = 'AS' OR finalRecords.RC8 = 'AS' OR finalRecords.RC9 = 'AS' OR finalRecords.RC10 = 'AS') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_RC_EA						:=	(COUNT(GROUP, finalRecords.RC1 = 'EA' OR finalRecords.RC2 = 'EA' OR finalRecords.RC3 = 'EA' OR finalRecords.RC4 = 'EA' OR finalRecords.RC5 = 'EA' OR finalRecords.RC6 = 'EA' OR finalRecords.RC7 = 'EA' OR finalRecords.RC8 = 'EA' OR finalRecords.RC9 = 'EA' OR finalRecords.RC10 = 'EA') / COUNT(GROUP)) * 100;

END;

trackingLayout2 := RECORD
	STRING8 Date_Of_Report															:= finalRecords.TransactionDate;
	UNSIGNED8 Number_Of_Unique_Account_IDs_Transacted		:= COUNT(GROUP);
END;

mainStats := TABLE(finalRecords, trackingLayout, TransactionDate);
OUTPUT(CHOOSEN(mainStats, eyeball), NAMED('Main_Stats'));
uniqueIDRecs := DEDUP(SORT(finalRecords, TransactionDate, AccountID), TransactionDate, AccountID);
uniqueIDs := TABLE(uniqueIDRecs, trackingLayout2, TransactionDate);
OUTPUT(CHOOSEN(uniqueIDs, eyeball), NAMED('Unique_IDs'));

stats := JOIN(mainStats, uniqueIDs, LEFT.Date_Of_Report = RIGHT.Date_Of_Report, 
		TRANSFORM(RECORDOF(LEFT), 
			SELF.Number_Of_Unique_Account_IDs_Transacted := RIGHT.Number_Of_Unique_Account_IDs_Transacted; SELF := LEFT))
			//(Total_Number_Of_Transactions >= 50)
			; // If the total number of transactions for the day is less than 50, assume it's a bad key build

MostRecent := SORT(stats, -Date_Of_Report); // Sort most recent dates to the front
Oldest := SORT(stats, Date_Of_Report);

day1 := MostRecent[1];
day2 := MostRecent[2];
day3 := MostRecent[3];
day4 := MostRecent[4];
day5 := MostRecent[5];
day6 := MostRecent[6];
day7 := MostRecent[7];

OUTPUT(CHOOSEN(MostRecent, eyeball), NAMED('Sample_Stats'));

averageTrackingLayout := RECORD
	// General Statistics
	STRING8 Date_Of_Report := '';							
	UNSIGNED8 Total_Number_Of_Transactions;							
	UNSIGNED8 Number_Of_Unique_Account_IDs_Transacted;		
	
	// Input Population Statistics
	DECIMAL6_3	Percent_First_Name_Populated;
	DECIMAL6_3	Percent_Last_Name_Populated;
	DECIMAL6_3	Percent_SSN_Populated;
	DECIMAL6_3	Percent_DOB_Populated;
	DECIMAL6_3	Percent_Address_Populated;
	DECIMAL6_3	Percent_City_Populated;
	DECIMAL6_3	Percent_State_Populated;
	DECIMAL6_3	Percent_Zip_Populated;
	DECIMAL6_3	Percent_DL_Populated;
	DECIMAL6_3	Percent_Home_Phone_Populated;
//	DECIMAL6_3	Percent_Work_Phone_Populated;
	DECIMAL6_3	Percent_Email_Populated;
	DECIMAL6_3	Percent_IP_Address_Populated;			
	DECIMAL6_3	Percent_Physical_OrderType_Populated ;
	DECIMAL6_3	Percent_Digital_OrderType_Populated;
//SHIPPIN
	DECIMAL6_3	Percent_Address2_Populated;
	DECIMAL6_3	Percent_City2_Populated	;
	DECIMAL6_3	Percent_State2_Populated	;
	DECIMAL6_3	Percent_Zip2_Populated	;
	
	// Score Bucket Statistics
	DECIMAL6_3	Percent_Scored_200;
	DECIMAL6_3	Percent_Scored_201;
	DECIMAL6_3	Percent_Scored_202;
	DECIMAL6_3	Percent_Scored_203;
	DECIMAL6_3	Percent_Scored_222;
	DECIMAL6_3	Percent_Scored_Between_300_350;
	DECIMAL6_3	Percent_Scored_Between_351_400;
	DECIMAL6_3	Percent_Scored_Between_401_450;
	DECIMAL6_3	Percent_Scored_Between_451_500;
	DECIMAL6_3	Percent_Scored_Between_501_550;
	DECIMAL6_3	Percent_Scored_Between_551_600;
	DECIMAL6_3	Percent_Scored_Between_601_650;
	DECIMAL6_3	Percent_Scored_Between_651_700;
	DECIMAL6_3	Percent_Scored_Between_701_750;
	DECIMAL6_3	Percent_Scored_Between_751_900;
	DECIMAL6_3	Percent_Scored_Above_900;
	
	UNSIGNED2		Average_Score_Excluding_Exceptions;
	
	// Reason Code Population Statistics

	DECIMAL6_3	Percent_RC_04;
	DECIMAL6_3	Percent_RC_07;
	DECIMAL6_3	Percent_RC_08;
	DECIMAL6_3	Percent_RC_09;
	DECIMAL6_3	Percent_RC_10;
	DECIMAL6_3	Percent_RC_11;
	DECIMAL6_3	Percent_RC_13;
	DECIMAL6_3	Percent_RC_14;
	DECIMAL6_3	Percent_RC_15;
	DECIMAL6_3	Percent_RC_16;
	DECIMAL6_3	Percent_RC_19;
	DECIMAL6_3	Percent_RC_25;
	DECIMAL6_3	Percent_RC_27;
	DECIMAL6_3	Percent_RC_30;
	DECIMAL6_3	Percent_RC_31;
	DECIMAL6_3	Percent_RC_37;
	DECIMAL6_3	Percent_RC_40;
	DECIMAL6_3	Percent_RC_43;
	DECIMAL6_3	Percent_RC_50;
	DECIMAL6_3	Percent_RC_75;
	DECIMAL6_3	Percent_RC_76;
	DECIMAL6_3	Percent_RC_77;
	DECIMAL6_3	Percent_RC_78;
	DECIMAL6_3	Percent_RC_80;
	DECIMAL6_3	Percent_RC_82;
	DECIMAL6_3	Percent_RC_O1;
	DECIMAL6_3	Percent_RC_O2;
	DECIMAL6_3	Percent_RC_O3;
	DECIMAL6_3	Percent_RC_O4;
	DECIMAL6_3	Percent_RC_O5;
	DECIMAL6_3	Percent_RC_O6;
	DECIMAL6_3	Percent_RC_O7;
	DECIMAL6_3	Percent_RC_S1;
	DECIMAL6_3	Percent_RC_S2;
	DECIMAL6_3	Percent_RC_S3;
	DECIMAL6_3	Percent_RC_S4;
	DECIMAL6_3	Percent_RC_S5;
	DECIMAL6_3	Percent_RC_IA;
	DECIMAL6_3	Percent_RC_IB;
	DECIMAL6_3	Percent_RC_IC;
	DECIMAL6_3	Percent_RC_ID;
	DECIMAL6_3	Percent_RC_IE;
	DECIMAL6_3	Percent_RC_IF;
	DECIMAL6_3	Percent_RC_IG;
	DECIMAL6_3	Percent_RC_AS;
	DECIMAL6_3	Percent_RC_EA;
	
END;

rounded (field) := FUNCTIONMACRO
	RETURN(ROUND(AVE(MostRecent, MostRecent.field)));
ENDMACRO;

percented (field) := FUNCTIONMACRO
	RETURN((DECIMAL6_3)AVE(MostRecent, MostRecent.field));
ENDMACRO;

averageTrackingLayout getAverages(ut.ds_oneRecord le) := TRANSFORM
	// General Statistics
	SELF.Date_Of_Report := 'AVERAGE';							
	SELF.Total_Number_Of_Transactions := rounded(Total_Number_Of_Transactions);							
	SELF.Number_Of_Unique_Account_IDs_Transacted := rounded(Number_Of_Unique_Account_IDs_Transacted);		
	
	// Input Population Statistics
	SELF.Percent_First_Name_Populated := percented(Percent_First_Name_Populated);						
	SELF.Percent_Last_Name_Populated := percented(Percent_Last_Name_Populated);							
	SELF.Percent_SSN_Populated := percented(Percent_SSN_Populated);		
	SELF.Percent_DOB_Populated := percented(Percent_DOB_Populated);		
	SELF.Percent_Address_Populated := percented(Percent_Address_Populated);
	SELF.Percent_City_Populated := percented(Percent_City_Populated);	
	SELF.Percent_State_Populated := percented(Percent_State_Populated);	
	SELF.Percent_Zip_Populated := percented(Percent_Zip_Populated);		
	SELF.Percent_DL_Populated := percented(Percent_DL_Populated);		
	SELF.Percent_Home_Phone_Populated := percented(Percent_Home_Phone_Populated);						
//	SELF.Percent_Work_Phone_Populated := percented(Percent_Work_Phone_Populated);						
	SELF.Percent_Email_Populated := percented(Percent_Email_Populated);						
	SELF.Percent_IP_Address_Populated := percented(Percent_IP_Address_Populated);						
	SELF.Percent_Physical_OrderType_Populated  := percented(Percent_Physical_OrderType_Populated);
	SELF.Percent_Digital_OrderType_Populated := percented(Percent_Digital_OrderType_Populated);
//SHIPPIN
	SELF.Percent_Address2_Populated := percented(Percent_Address2_Populated);
	SELF.Percent_City2_Populated	 := percented(Percent_City2_Populated);
	SELF.Percent_State2_Populated	 := percented(Percent_State2_Populated);
	SELF.Percent_Zip2_Populated	 := percented(Percent_Zip2_Populated);
	// Score Bucket Statistics
	SELF.Percent_Scored_200 := percented(Percent_Scored_200);
	SELF.Percent_Scored_201 := percented(Percent_Scored_201);
	SELF.Percent_Scored_202 := percented(Percent_Scored_202);
	SELF.Percent_Scored_203 := percented(Percent_Scored_203);
	SELF.Percent_Scored_222 := percented(Percent_Scored_222);
	SELF.Percent_Scored_Between_300_350 := percented(Percent_Scored_Between_300_350);					
	SELF.Percent_Scored_Between_351_400 := percented(Percent_Scored_Between_351_400);					
	SELF.Percent_Scored_Between_401_450 := percented(Percent_Scored_Between_401_450);					
	SELF.Percent_Scored_Between_451_500 := percented(Percent_Scored_Between_451_500);					
	SELF.Percent_Scored_Between_501_550 := percented(Percent_Scored_Between_501_550);					
	SELF.Percent_Scored_Between_551_600 := percented(Percent_Scored_Between_551_600);					
	SELF.Percent_Scored_Between_601_650 := percented(Percent_Scored_Between_601_650);					
	SELF.Percent_Scored_Between_651_700 := percented(Percent_Scored_Between_651_700);					
	SELF.Percent_Scored_Between_701_750 := percented(Percent_Scored_Between_701_750);					
	SELF.Percent_Scored_Between_751_900 := percented(Percent_Scored_Between_751_900);					
	SELF.Percent_Scored_Above_900 := percented(Percent_Scored_Above_900);
	
	SELF.Average_Score_Excluding_Exceptions := rounded(Average_Score_Excluding_Exceptions);			
	
	// Reason Code Population Statistics		
	self.Percent_RC_04 := percented(Percent_RC_04);
	self.Percent_RC_07 := percented(Percent_RC_07);
	self.Percent_RC_08 := percented(Percent_RC_08);
	self.Percent_RC_09 := percented(Percent_RC_09);
	self.Percent_RC_10 := percented(Percent_RC_10);
	self.Percent_RC_11 := percented(Percent_RC_11);
	self.Percent_RC_13 := percented(Percent_RC_13);
	self.Percent_RC_14 := percented(Percent_RC_14);
	self.Percent_RC_15 := percented(Percent_RC_15);
	self.Percent_RC_16 := percented(Percent_RC_16);
	self.Percent_RC_19 := percented(Percent_RC_19);
	self.Percent_RC_25 := percented(Percent_RC_25);
	self.Percent_RC_27 := percented(Percent_RC_27);
	self.Percent_RC_30 := percented(Percent_RC_30);
	self.Percent_RC_31 := percented(Percent_RC_31);
	self.Percent_RC_37 := percented(Percent_RC_37);
	self.Percent_RC_40 := percented(Percent_RC_40);
	self.Percent_RC_43 := percented(Percent_RC_43);
	self.Percent_RC_50 := percented(Percent_RC_50);
	self.Percent_RC_75 := percented(Percent_RC_75);
	self.Percent_RC_76 := percented(Percent_RC_76);
	self.Percent_RC_77 := percented(Percent_RC_77);
	self.Percent_RC_78 := percented(Percent_RC_78);
	self.Percent_RC_80 := percented(Percent_RC_80);
	self.Percent_RC_82 := percented(Percent_RC_82);
	self.Percent_RC_O1 := percented(Percent_RC_O1);
	self.Percent_RC_O2 := percented(Percent_RC_O2);
	self.Percent_RC_O3 := percented(Percent_RC_O3);
	self.Percent_RC_O4 := percented(Percent_RC_O4);
	self.Percent_RC_O5 := percented(Percent_RC_O5);
	self.Percent_RC_O6 := percented(Percent_RC_O6);
	self.Percent_RC_O7 := percented(Percent_RC_O7);
	self.Percent_RC_S1 := percented(Percent_RC_S1);
	self.Percent_RC_S2 := percented(Percent_RC_S2);
	self.Percent_RC_S3 := percented(Percent_RC_S3);
	self.Percent_RC_S4 := percented(Percent_RC_S4);
	self.Percent_RC_S5 := percented(Percent_RC_S5);
	self.Percent_RC_IA := percented(Percent_RC_IA);
	self.Percent_RC_IB := percented(Percent_RC_IB);
	self.Percent_RC_IC := percented(Percent_RC_IC);
	self.Percent_RC_ID := percented(Percent_RC_ID);
	self.Percent_RC_IE := percented(Percent_RC_IE);
	self.Percent_RC_IF := percented(Percent_RC_IF);
	self.Percent_RC_IG := percented(Percent_RC_IG);
	self.Percent_RC_AS := percented(Percent_RC_AS);
	self.Percent_RC_EA := percented(Percent_RC_EA);	
	
END;

Averaged := PROJECT(ut.ds_oneRecord, getAverages(LEFT))[1];
OUTPUT(Averaged, NAMED('Averages'));

difference (field) := FUNCTIONMACRO
	RETURN(ABS(day1.field - Averaged.field));
ENDMACRO;

averageTrackingLayout getDifferences(ut.ds_oneRecord le) := TRANSFORM
		// General Statistics
	SELF.Date_Of_Report := 'DIFFERS';							
	SELF.Total_Number_Of_Transactions := difference(Total_Number_Of_Transactions);							
	SELF.Number_Of_Unique_Account_IDs_Transacted := difference(Number_Of_Unique_Account_IDs_Transacted);		
	
	// Input Population Statistics
	SELF.Percent_First_Name_Populated := difference(Percent_First_Name_Populated);
	SELF.Percent_Last_Name_Populated := difference(Percent_Last_Name_Populated);	
	SELF.Percent_SSN_Populated := difference(Percent_SSN_Populated);
	SELF.Percent_DOB_Populated := difference(Percent_DOB_Populated);
	SELF.Percent_Address_Populated := difference(Percent_Address_Populated);
	SELF.Percent_City_Populated := difference(Percent_City_Populated);
	SELF.Percent_State_Populated := difference(Percent_State_Populated);
	SELF.Percent_Zip_Populated := difference(Percent_Zip_Populated);
	SELF.Percent_DL_Populated := difference(Percent_DL_Populated);
	SELF.Percent_Home_Phone_Populated := difference(Percent_Home_Phone_Populated);
	//SELF.Percent_Work_Phone_Populated := difference(Percent_Work_Phone_Populated);						
	SELF.Percent_Email_Populated := difference(Percent_Email_Populated);						
	SELF.Percent_IP_Address_Populated := difference(Percent_IP_Address_Populated);						
	SELF.Percent_Physical_OrderType_Populated  := difference(Percent_Physical_OrderType_Populated);
	SELF.Percent_Digital_OrderType_Populated := difference(Percent_Digital_OrderType_Populated);
//SHIPPIN
	SELF.Percent_Address2_Populated := difference(Percent_Address2_Populated);
	SELF.Percent_City2_Populated	 := difference(Percent_City2_Populated);
	SELF.Percent_State2_Populated	 := difference(Percent_State2_Populated);
	SELF.Percent_Zip2_Populated	 := difference(Percent_Zip2_Populated);
	// Score Bucket Statistics
	SELF.Percent_Scored_200 := difference(Percent_Scored_200);
	SELF.Percent_Scored_201 := difference(Percent_Scored_201);
	SELF.Percent_Scored_202 := difference(Percent_Scored_202);
	SELF.Percent_Scored_203 := difference(Percent_Scored_203);
	SELF.Percent_Scored_222 := difference(Percent_Scored_222);
	SELF.Percent_Scored_Between_300_350 := difference(Percent_Scored_Between_300_350);					
	SELF.Percent_Scored_Between_351_400 := difference(Percent_Scored_Between_351_400);					
	SELF.Percent_Scored_Between_401_450 := difference(Percent_Scored_Between_401_450);					
	SELF.Percent_Scored_Between_451_500 := difference(Percent_Scored_Between_451_500);					
	SELF.Percent_Scored_Between_501_550 := difference(Percent_Scored_Between_501_550);					
	SELF.Percent_Scored_Between_551_600 := difference(Percent_Scored_Between_551_600);					
	SELF.Percent_Scored_Between_601_650 := difference(Percent_Scored_Between_601_650);					
	SELF.Percent_Scored_Between_651_700 := difference(Percent_Scored_Between_651_700);					
	SELF.Percent_Scored_Between_701_750 := difference(Percent_Scored_Between_701_750);					
	SELF.Percent_Scored_Between_751_900 := difference(Percent_Scored_Between_751_900);			
	SELF.Percent_Scored_Above_900 := difference(Percent_Scored_Above_900);
	
	SELF.Average_Score_Excluding_Exceptions := difference(Average_Score_Excluding_Exceptions);	
	
	// Reason Code Population Statistics
	self.Percent_RC_04 := difference(Percent_RC_04);
	self.Percent_RC_07 := difference(Percent_RC_07);
	self.Percent_RC_08 := difference(Percent_RC_08);
	self.Percent_RC_09 := difference(Percent_RC_09);
	self.Percent_RC_10 := difference(Percent_RC_10);
	self.Percent_RC_11 := difference(Percent_RC_11);
	self.Percent_RC_13 := difference(Percent_RC_13);
	self.Percent_RC_14 := difference(Percent_RC_14);
	self.Percent_RC_15 := difference(Percent_RC_15);
	self.Percent_RC_16 := difference(Percent_RC_16);
	self.Percent_RC_19 := difference(Percent_RC_19);
	self.Percent_RC_25 := difference(Percent_RC_25);
	self.Percent_RC_27 := difference(Percent_RC_27);
	self.Percent_RC_30 := difference(Percent_RC_30);
	self.Percent_RC_31 := difference(Percent_RC_31);
	self.Percent_RC_37 := difference(Percent_RC_37);
	self.Percent_RC_40 := difference(Percent_RC_40);
	self.Percent_RC_43 := difference(Percent_RC_43);
	self.Percent_RC_50 := difference(Percent_RC_50);
	self.Percent_RC_75 := difference(Percent_RC_75);
	self.Percent_RC_76 := difference(Percent_RC_76);
	self.Percent_RC_77 := difference(Percent_RC_77);
	self.Percent_RC_78 := difference(Percent_RC_78);
	self.Percent_RC_80 := difference(Percent_RC_80);
	self.Percent_RC_82 := difference(Percent_RC_82);
	self.Percent_RC_O1 := difference(Percent_RC_O1);
	self.Percent_RC_O2 := difference(Percent_RC_O2);
	self.Percent_RC_O3 := difference(Percent_RC_O3);
	self.Percent_RC_O4 := difference(Percent_RC_O4);
	self.Percent_RC_O5 := difference(Percent_RC_O5);
	self.Percent_RC_O6 := difference(Percent_RC_O6);
	self.Percent_RC_O7 := difference(Percent_RC_O7);
	self.Percent_RC_S1 := difference(Percent_RC_S1);
	self.Percent_RC_S2 := difference(Percent_RC_S2);
	self.Percent_RC_S3 := difference(Percent_RC_S3);
	self.Percent_RC_S4 := difference(Percent_RC_S4);
	self.Percent_RC_S5 := difference(Percent_RC_S5);
	self.Percent_RC_IA := difference(Percent_RC_IA);
	self.Percent_RC_IB := difference(Percent_RC_IB);
	self.Percent_RC_IC := difference(Percent_RC_IC);
	self.Percent_RC_ID := difference(Percent_RC_ID);
	self.Percent_RC_IE := difference(Percent_RC_IE);
	self.Percent_RC_IF := difference(Percent_RC_IF);
	self.Percent_RC_IG := difference(Percent_RC_IG);
	self.Percent_RC_AS := difference(Percent_RC_AS);
	self.Percent_RC_EA := difference(Percent_RC_EA);
END;

Differs := PROJECT(ut.ds_oneRecord, getDifferences(LEFT))[1];

OUTPUT(Differs, NAMED('Differences'));

/* ***********************************************************************************************
 *************************************************************************************************
 *                                        GENERATE E-MAIL BODY                                   *
 *************************************************************************************************
 *********************************************************************************************** */

dashes := '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n';
STRING padNumber (STRING number, BOOLEAN exist) := MAP(exist = FALSE 	=> ' \t\t|',
				LENGTH(number) >= 0 AND LENGTH(number) <= 5 	=> ' ' + number + '\t\t|',
				LENGTH(number) >= 6 AND LENGTH(number) <= 12 	=> ' ' + number + '\t|',
				LENGTH(number) >= 13 AND LENGTH(number) <= 13 => ' ' + number + '|',
					number + '|');

genRow (field, disablePercent = FALSE, disableDiffers = FALSE) := MACRO
	padNumber((STRING)day1.field + IF(disablePercent = TRUE, '', '%'), day1.Date_Of_Report <> '') + 
	padNumber((STRING)day2.field + IF(disablePercent = TRUE, '', '%'), day2.Date_Of_Report <> '') + 
	padNumber((STRING)day3.field + IF(disablePercent = TRUE, '', '%'), day3.Date_Of_Report <> '') + 
	padNumber((STRING)day4.field + IF(disablePercent = TRUE, '', '%'), day4.Date_Of_Report <> '') + 
	padNumber((STRING)day5.field + IF(disablePercent = TRUE, '', '%'), day5.Date_Of_Report <> '') + 
	padNumber((STRING)Oldest[1].field + IF(disablePercent = TRUE, '', '%'), COUNT(Oldest) > 0) + 
	padNumber((STRING)Averaged.field + IF(disablePercent = TRUE, '', '%'), Averaged.Date_Of_Report <> '') +
	IF(disableDiffers = TRUE, '', padNumber((STRING)Differs.field + IF(disablePercent = TRUE, '', '%'), Differs.Date_Of_Report <> '')) +
	'\n' +
	dashes
ENDMACRO;

potentialProblems (field, fieldName, thresh) := MACRO
	IF(Differs.field >= thresh, fieldName + ':\t' + (STRING)Differs.field + '%\t(' + (STRING)thresh + '% Threshold)\n', '')
ENDMACRO;

emailBody := 
'Order Score Point Daily Score Monitor' + '\n' +
'========================\n' +
'Report Run Date: ' + EndDate + '\n' + 
'SAOT Key Latest Date: ' + day1.Date_Of_Report + '\n\n' +
// Highlight any potential issues at the top of the email, so you don't have to look at the whole thing if you don't want to
'Potential Problems - Percent Change Between ' + day1.Date_Of_Report + ' and Average >= Threshold\n' + 
'===============================================================\n' + 
potentialProblems(Percent_Scored_200, 'Percent_Scored_200', Risk_Reporting.Constants.ThreshPercent_Scored_200) +
potentialProblems(Percent_Scored_201, 'Percent_Scored_201', Risk_Reporting.Constants.ThreshPercent_Scored_201) +
potentialProblems(Percent_Scored_202, 'Percent_Scored_202', Risk_Reporting.Constants.ThreshPercent_Scored_202) +
potentialProblems(Percent_Scored_203, 'Percent_Scored_203', Risk_Reporting.Constants.ThreshPercent_Scored_203) +
potentialProblems(Percent_Scored_222, 'Percent_Scored_222', Risk_Reporting.Constants.ThreshPercent_Scored_222) +
potentialProblems(Percent_Scored_Between_300_350, 'Percent_Scored_Between_300_350', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_351_400, 'Percent_Scored_Between_351_400', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_401_450, 'Percent_Scored_Between_401_450', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_451_500, 'Percent_Scored_Between_451_500', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_501_550, 'Percent_Scored_Between_501_550', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_551_600, 'Percent_Scored_Between_551_600', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_601_650, 'Percent_Scored_Between_601_650', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_651_700, 'Percent_Scored_Between_651_700', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_701_750, 'Percent_Scored_Between_701_750', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Between_751_900, 'Percent_Scored_Between_751_900', Risk_Reporting.Constants.ThreshOrderScoreScoreBuckets) +
potentialProblems(Percent_Scored_Above_900, 'Percent_Scored_Above_900', Risk_Reporting.Constants.ThreshScoredAbove900) +
// potentialProblems(Average_Score_Excluding_Exceptions, 'Average_Score_Excluding_Exceptions', 1.000) +
potentialProblems(Percent_RC_04, 'Percent_RC_04', Risk_Reporting.Constants.ThreshPercent_RC_04) +
potentialProblems(Percent_RC_07, 'Percent_RC_07', Risk_Reporting.Constants.ThreshPercent_RC_07) +
potentialProblems(Percent_RC_08, 'Percent_RC_08', Risk_Reporting.Constants.ThreshPercent_RC_08) +
potentialProblems(Percent_RC_09, 'Percent_RC_09', Risk_Reporting.Constants.ThreshPercent_RC_09) +
potentialProblems(Percent_RC_10, 'Percent_RC_10', Risk_Reporting.Constants.ThreshPercent_RC_10) +
potentialProblems(Percent_RC_11, 'Percent_RC_11', Risk_Reporting.Constants.ThreshPercent_RC_11) +
potentialProblems(Percent_RC_13, 'Percent_RC_13', Risk_Reporting.Constants.ThreshPercent_RC_13) +
potentialProblems(Percent_RC_14, 'Percent_RC_14', Risk_Reporting.Constants.ThreshPercent_RC_14) +
potentialProblems(Percent_RC_15, 'Percent_RC_15', Risk_Reporting.Constants.ThreshPercent_RC_15) +
potentialProblems(Percent_RC_16, 'Percent_RC_16', Risk_Reporting.Constants.ThreshPercent_RC_16) +
potentialProblems(Percent_RC_19, 'Percent_RC_19', Risk_Reporting.Constants.ThreshPercent_RC_19) +
potentialProblems(Percent_RC_25, 'Percent_RC_25', Risk_Reporting.Constants.ThreshPercent_RC_25) +
potentialProblems(Percent_RC_27, 'Percent_RC_27', Risk_Reporting.Constants.ThreshPercent_RC_27) +
potentialProblems(Percent_RC_30, 'Percent_RC_30', Risk_Reporting.Constants.ThreshPercent_RC_30) +
potentialProblems(Percent_RC_31, 'Percent_RC_31', Risk_Reporting.Constants.ThreshPercent_RC_31) +
potentialProblems(Percent_RC_37, 'Percent_RC_37', Risk_Reporting.Constants.ThreshPercent_RC_37) +
potentialProblems(Percent_RC_40, 'Percent_RC_40', Risk_Reporting.Constants.ThreshPercent_RC_40) +
potentialProblems(Percent_RC_43, 'Percent_RC_43', Risk_Reporting.Constants.ThreshPercent_RC_43) +
potentialProblems(Percent_RC_50, 'Percent_RC_50', Risk_Reporting.Constants.ThreshPercent_RC_50) +
potentialProblems(Percent_RC_75, 'Percent_RC_75', Risk_Reporting.Constants.ThreshPercent_RC_75) +
potentialProblems(Percent_RC_76, 'Percent_RC_76', Risk_Reporting.Constants.ThreshPercent_RC_76) +
potentialProblems(Percent_RC_77, 'Percent_RC_77', Risk_Reporting.Constants.ThreshPercent_RC_77) +
potentialProblems(Percent_RC_78, 'Percent_RC_78', Risk_Reporting.Constants.ThreshPercent_RC_78) +
potentialProblems(Percent_RC_80, 'Percent_RC_80', Risk_Reporting.Constants.ThreshPercent_RC_80) +
potentialProblems(Percent_RC_82, 'Percent_RC_82', Risk_Reporting.Constants.ThreshPercent_RC_82) +
potentialProblems(Percent_RC_O1, 'Percent_RC_O1', Risk_Reporting.Constants.ThreshPercent_RC_O1) +
potentialProblems(Percent_RC_O2, 'Percent_RC_O2', Risk_Reporting.Constants.ThreshPercent_RC_O2) +
potentialProblems(Percent_RC_O3, 'Percent_RC_O3', Risk_Reporting.Constants.ThreshPercent_RC_O3) +
potentialProblems(Percent_RC_O4, 'Percent_RC_O4', Risk_Reporting.Constants.ThreshPercent_RC_O4) +
potentialProblems(Percent_RC_O5, 'Percent_RC_O5', Risk_Reporting.Constants.ThreshPercent_RC_O5) +
potentialProblems(Percent_RC_O6, 'Percent_RC_O6', Risk_Reporting.Constants.ThreshPercent_RC_O6) +
potentialProblems(Percent_RC_O7, 'Percent_RC_O7', Risk_Reporting.Constants.ThreshPercent_RC_O7) +
potentialProblems(Percent_RC_S1, 'Percent_RC_S1', Risk_Reporting.Constants.ThreshPercent_RC_S1) +
potentialProblems(Percent_RC_S2, 'Percent_RC_S2', Risk_Reporting.Constants.ThreshPercent_RC_S2) +
potentialProblems(Percent_RC_S3, 'Percent_RC_S3', Risk_Reporting.Constants.ThreshPercent_RC_S3) +
potentialProblems(Percent_RC_S4, 'Percent_RC_S4', Risk_Reporting.Constants.ThreshPercent_RC_S4) +
potentialProblems(Percent_RC_S5, 'Percent_RC_S5', Risk_Reporting.Constants.ThreshPercent_RC_S5) +
potentialProblems(Percent_RC_IA, 'Percent_RC_IA', Risk_Reporting.Constants.ThreshPercent_RC_IA) +
potentialProblems(Percent_RC_IB, 'Percent_RC_IB', Risk_Reporting.Constants.ThreshPercent_RC_IB) +
potentialProblems(Percent_RC_IC, 'Percent_RC_IC', Risk_Reporting.Constants.ThreshPercent_RC_IC) +
potentialProblems(Percent_RC_ID, 'Percent_RC_ID', Risk_Reporting.Constants.ThreshPercent_RC_ID) +
potentialProblems(Percent_RC_IE, 'Percent_RC_IE', Risk_Reporting.Constants.ThreshPercent_RC_IE) +
potentialProblems(Percent_RC_IF, 'Percent_RC_IF', Risk_Reporting.Constants.ThreshPercent_RC_IF) +
potentialProblems(Percent_RC_IG, 'Percent_RC_IG', Risk_Reporting.Constants.ThreshPercent_RC_IG) +
potentialProblems(Percent_RC_AS, 'Percent_RC_AS', Risk_Reporting.Constants.ThreshPercent_RC_AS) +
potentialProblems(Percent_RC_EA, 'Percent_RC_EA', Risk_Reporting.Constants.ThreshPercent_RC_EA) +

// Generate the table
'\n\nRolling 5 Day Window Stats:\n' +
'=====================\n' +
'\t\t\t\t\t| ' + day1.Date_Of_Report + '\t| ' + 
day2.Date_Of_Report + '\t| ' + 
day3.Date_Of_Report + '\t| ' + 
day4.Date_Of_Report + '\t| ' + 
day5.Date_Of_Report + '\t| ' + 
'1st-' + Oldest[1].Date_Of_Report + '\t| ' +
'1 Year Avg\t| ' +
'% Differ Col 1/Avg\n' +
dashes +
'Total Number of Transactions\t\t|' + genRow(Total_Number_Of_Transactions, TRUE, TRUE) +
'Number of Unique Account IDs\t\t|' + genRow(Number_Of_Unique_Account_IDs_Transacted,TRUE, TRUE) +
'% First Name Populated\t\t|' + genRow(Percent_First_Name_Populated) +
'% Last Name Populated\t\t|' + genRow(Percent_Last_Name_Populated) +
'% SSN Populated\t\t\t|' + genRow(Percent_SSN_Populated) +
'% Date of Birth Populated\t\t|' + genRow(Percent_DOB_Populated) +
'% Address Populated\t\t\t|' + genRow(Percent_Address_Populated) +
'% City Populated\t\t\t|' + genRow(Percent_City_Populated) +
'% State Populated\t\t\t|' + genRow(Percent_State_Populated) +
'% Zip Code Populated\t\t\t|' + genRow(Percent_Zip_Populated) +
'% Drivers License Populated\t\t|' + genRow(Percent_DL_Populated) +
'% Home Phone Populated\t\t|' + genRow(Percent_Home_Phone_Populated) +
//'% Work Phone Populated\t\t|' + genRow(Percent_Work_Phone_Populated) +
'% Email Populated\t\t\t|' + genRow(Percent_Email_Populated) +
'% IP Address Populated\t\t|' + genRow(Percent_IP_Address_Populated) +
'% Physical Order Type Populated\t\t|' + genRow(Percent_Physical_OrderType_Populated) +
'% Digital Order Type Populated\t\t|' + genRow(Percent_Digital_OrderType_Populated) +
//SHIPPIN
'% Address2 Populated\t\t|' + genRow(Percent_Address2_PopulateD) +
'% City2 Populated\t\t|' + genRow(Percent_City2_Populated) +
'% State2 Populated\t\t|' + genRow(Percent_State2_Populated) +
'% Zip2 Populated \t\t|' + genRow(Percent_Zip2_Populated) +
'% Scored 200\t\t\t\t|' + genRow(Percent_Scored_200) +
'% Scored 201\t\t\t\t|' + genRow(Percent_Scored_201) +
'% Scored 202\t\t\t\t|' + genRow(Percent_Scored_202) +
'% Scored 203\t\t\t\t|' + genRow(Percent_Scored_203) +
'% Scored 222\t\t\t\t|' + genRow(Percent_Scored_222) +
'% Scored Between 300 - 350\t\t|' + genRow(Percent_Scored_Between_300_350) +
'% Scored Between 351 - 400\t\t|' + genRow(Percent_Scored_Between_351_400) +
'% Scored Between 401 - 450\t\t|' + genRow(Percent_Scored_Between_401_450) +
'% Scored Between 451 - 500\t\t|' + genRow(Percent_Scored_Between_451_500) +
'% Scored Between 501 - 550\t\t|' + genRow(Percent_Scored_Between_501_550) +
'% Scored Between 551 - 600\t\t|' + genRow(Percent_Scored_Between_551_600) +
'% Scored Between 601 - 650\t\t|' + genRow(Percent_Scored_Between_601_650) +
'% Scored Between 651 - 700\t\t|' + genRow(Percent_Scored_Between_651_700) +
'% Scored Between 701 - 750\t\t|' + genRow(Percent_Scored_Between_701_750) +
'% Scored Between 751 - 900\t\t|' + genRow(Percent_Scored_Between_751_900) +
'% Scored Above 900\t\t\t|' + genRow(Percent_Scored_Above_900) +
'Average Score Excluding Exceptions\t|' + genRow(Average_Score_Excluding_Exceptions, TRUE, TRUE) +
'% Returned Reason Code 04\t\t|' + genRow(Percent_RC_04) +
'% Returned Reason Code 07\t\t|' + genRow(Percent_RC_07) +
'% Returned Reason Code 08\t\t|' + genRow(Percent_RC_08) +
'% Returned Reason Code 09\t\t|' + genRow(Percent_RC_09) +
'% Returned Reason Code 10\t\t|' + genRow(Percent_RC_10) +
'% Returned Reason Code 11\t\t|' + genRow(Percent_RC_11) +
'% Returned Reason Code 13\t\t|' + genRow(Percent_RC_13) +
'% Returned Reason Code 14\t\t|' + genRow(Percent_RC_14) +
'% Returned Reason Code 15\t\t|' + genRow(Percent_RC_15) +
'% Returned Reason Code 16\t\t|' + genRow(Percent_RC_16) +
'% Returned Reason Code 19\t\t|' + genRow(Percent_RC_19) +
'% Returned Reason Code 25\t\t|' + genRow(Percent_RC_25) +
'% Returned Reason Code 27\t\t|' + genRow(Percent_RC_27) +
'% Returned Reason Code 30\t\t|' + genRow(Percent_RC_30) +
'% Returned Reason Code 31\t\t|' + genRow(Percent_RC_31) +
'% Returned Reason Code 37\t\t|' + genRow(Percent_RC_37) +
'% Returned Reason Code 40\t\t|' + genRow(Percent_RC_40) +
'% Returned Reason Code 43\t\t|' + genRow(Percent_RC_43) +
'% Returned Reason Code 50\t\t|' + genRow(Percent_RC_50) +
'% Returned Reason Code 75\t\t|' + genRow(Percent_RC_75) +
'% Returned Reason Code 76\t\t|' + genRow(Percent_RC_76) +
'% Returned Reason Code 77\t\t|' + genRow(Percent_RC_77) +
'% Returned Reason Code 78\t\t|' + genRow(Percent_RC_78) +
'% Returned Reason Code 80\t\t|' + genRow(Percent_RC_80) +
'% Returned Reason Code 82\t\t|' + genRow(Percent_RC_82) +
'% Returned Reason Code O1\t\t|' + genRow(Percent_RC_O1) +
'% Returned Reason Code O2\t\t|' + genRow(Percent_RC_O2) +
'% Returned Reason Code O3\t\t|' + genRow(Percent_RC_O3) +
'% Returned Reason Code O4\t\t|' + genRow(Percent_RC_O4) +
'% Returned Reason Code O5\t\t|' + genRow(Percent_RC_O5) +
'% Returned Reason Code O6\t\t|' + genRow(Percent_RC_O6) +
'% Returned Reason Code O7\t\t|' + genRow(Percent_RC_O7) +
'% Returned Reason Code S1\t\t|' + genRow(Percent_RC_S1) +
'% Returned Reason Code S2\t\t|' + genRow(Percent_RC_S2) +
'% Returned Reason Code S3\t\t|' + genRow(Percent_RC_S3) +
'% Returned Reason Code S4\t\t|' + genRow(Percent_RC_S4) +
'% Returned Reason Code S5\t\t|' + genRow(Percent_RC_S5) +
'% Returned Reason Code IA\t\t|' + genRow(Percent_RC_IA) +
'% Returned Reason Code IB\t\t|' + genRow(Percent_RC_IB) +
'% Returned Reason Code IC\t\t|' + genRow(Percent_RC_IC) +
'% Returned Reason Code ID\t\t|' + genRow(Percent_RC_ID) +
'% Returned Reason Code IE\t\t|' + genRow(Percent_RC_IE) +
'% Returned Reason Code IF\t\t|' + genRow(Percent_RC_IF) +
'% Returned Reason Code IG\t\t|' + genRow(Percent_RC_IG) +
'% Returned Reason Code AS\t\t|' + genRow(Percent_RC_AS) +
'% Returned Reason Code EA\t\t|' + genRow(Percent_RC_EA) +


'\n\n' +
'Workunit ' + StringLib.StringToUpperCase(ThorLib.wuid()) + '\n  http://10.173.84.202:8010/?inner=../WsWorkunits/WUInfo?Wuid=' + StringLib.StringToUpperCase(ThorLib.wuid());

OUTPUT(emailBody, NAMED('E_Mail_Body'));


/* ***********************************************************************************************
 *************************************************************************************************
 *                                         SEND THE EMAIL                                        *
 *************************************************************************************************
 *********************************************************************************************** */

subject := 'Order Score Daily Score Monitor';

FileServices.SendEmail(Risk_Reporting.Constants.emailv2OrderScoreReportsTo, subject,
																		emailBody,
																		GETENV('SMTPserver'),
																		(UNSIGNED4)GETENV('SMTPport', '25'),
																		'ThorReport@lexisnexis.com');		
																		
																		
																		
																		
