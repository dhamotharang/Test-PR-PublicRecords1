#workunit('name', 'Instant_ID_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20130301';
EndDate := '20150416';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 100;

outputFile := '~bpahl::out::InstantID_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['INSTANTID', 'INSTANTIDMODEL'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['INSTANTID', 'INSTANTIDMODEL'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		inputXMLTemp1 := StringLib.StringFindReplace(LEFT.inputxml, '<InstantID>', '<InstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		inputXMLTemp2 := StringLib.StringFindReplace(inputXMLTemp1, '<InstantIDModel>', '<InstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.inputxml := StringLib.StringFindReplace(inputXMLTemp2, '</InstantIDModel>', '</InstantID>'); 
																		SELF.outputxml := '<InstantID>' + LEFT.outputxml + '</InstantID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));
// OUTPUT(Logs(Logs.TransactionID = '131915833R121405'), NAMED('Sample_Yesterday_Logs'));

// OUTPUT(Logs(StringLib.StringToUpperCase(TRIM(XMLTEXT('InstantID/User/EndUser/CompanyName'))) = 'GREENDOT' ), NAMED('Sample_Yesterday_Logs'));//find greendot


Risk_Reporting.Layouts.Parsed_InstantID_Layout parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.LoadAmount			:= MAP(stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[1]/OptionName')))= 'loadamount' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[1]/OptionValue')),
															stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[2]/OptionName')))= 'loadamount' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[2]/OptionValue')),
															stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[3]/OptionName')))= 'loadamount' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[3]/OptionValue')),
															stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[4]/OptionName')))= 'loadamount' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[4]/OptionValue')),
															'');
	SELF.RetailZip			:= MAP(stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[1]/OptionName')))= 'retailzip' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[1]/OptionValue')),
															stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[2]/OptionName')))= 'retailzip' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[2]/OptionValue')),
															stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[3]/OptionName')))= 'retailzip' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[3]/OptionValue')),
															stringlib.stringtolowercase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[4]/OptionName')))= 'retailzip' => TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest/ModelOptions/ModelOption[4]/OptionValue')),
															'');
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
	
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.FullName				:= TRIM(XMLTEXT('SearchBy/Name/Full'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	SELF := [];
END;
parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('InstantID')), HASH64(TransactionID));

OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));

// OUTPUT(parsedInput(parsedInput.ModelName in ['FP1109_0','fp1109_0']), NAMED('Sample_Parsed_Input')); //xuran: get model name

Risk_Reporting.Layouts.Parsed_InstantID_Layout parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	ModelName           := TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type'));
	CVIModel						:= IF(StringLib.StringToUpperCase(ModelName) = 'CVI', TRUE, FALSE);
	SELF.CVI						:= TRIM(XMLTEXT('Result/ComprehensiveVerificationIndex')) + // Instant ID
												 TRIM(XMLTEXT('Result/ComprehensiveVerification/ComprehensiveVerificationIndex')) +
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value')), ''); // Instant ID Model
	SELF.NAP						:= TRIM(XMLTEXT('Result/NameAddressPhone[1]/Summary'));
	SELF.NAS						:= TRIM(XMLTEXT('Result/NameAddressSSNSummary'));
  FPModelName         := TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name'));
  IsFPModel           := IF(StringLib.StringToUpperCase(FPModelName) IN ['FRAUDDEFENDER', 'FRAUDPOINT'], TRUE, FALSE);
  SELF.FraudPointScore:= IF(IsFPModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value')), '');
  SELF.FraudPointRC1	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.FraudPointRC2	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.FraudPointRC3	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.FraudPointRC4	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.FraudPointRC5	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.FraudPointRC6	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.RiskIndex1     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[1]/Value'));
	SELF.RiskIndex2     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[2]/Value'));
	SELF.RiskIndex3     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[3]/Value'));
	SELF.RiskIndex4     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[4]/Value'));
	SELF.RiskIndex5     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[5]/Value'));
	SELF.RiskIndex6     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[6]/Value'));
	
	SELF.RC1						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode')), '');
	SELF.RC2						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode')), '');
	SELF.RC3						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode')), '');
	SELF.RC4						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode')), '');
	SELF.RC5						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode')), '');
	SELF.RC6						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode')), '');
	SELF.RC7						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[7]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode')), '');
	SELF.RC8						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[8]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode')), '');
	SELF.RC9						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[9]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode')), '');
	SELF.RC10						:= TRIM(XMLTEXT('Result/RiskIndicators[1]/RiskIndicator[10]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode')), '');	
	
	SELF := [];
END;
parsedOutputTemp := PARSE(Logs, outputxml, parseOutput(), XML('InstantID'));

OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));
// OUTPUT(parsedOutputTemp(parsedOutputTemp.FraudPointScore <> ''), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_InstantID_Layout normScores(Risk_Reporting.Layouts.Parsed_InstantID_Layout le, UNSIGNED1 t) := TRANSFORM
	SELF.CVI := CASE(t,
		1 => le.CVI,
		'');

	SELF.NAP := CASE(t,
		1 => le.NAP,
		'');

	SELF.NAS := CASE(t,
		1 => le.NAS,
		'');

	SELF.RC1 := CASE(t,
		1		=> le.RC1,
		'');

	SELF.RC2 := CASE(t,
		1		=> le.RC2,
		'');
	
	SELF.RC3 := CASE(t,
		1		=> le.RC3,
		'');
		
	SELF.RC4 := CASE(t,
		1		=> le.RC4,
		'');
		
	SELF.RC5 := CASE(t,
		1		=> le.RC5,
		'');
		
	SELF.RC6 := CASE(t,
		1		=> le.RC6,
		'');
		
	SELF.RC7 := CASE(t,
		1		=> le.RC7,
		'');
		
	SELF.RC8 := CASE(t,
		1		=> le.RC8,
		'');
		
	SELF.RC9 := CASE(t,
		1		=> le.RC9,
		'');
		
	SELF.RC10 := CASE(t,
		1		=> le.RC10,
		'');
		
	SELF := le;
END;
parsedOutput:= NORMALIZE(parsedOutputTemp, 1, normScores(LEFT, COUNTER));

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Normalized_Output'));

Risk_Reporting.Layouts.Parsed_InstantID_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_InstantID_Layout le, Risk_Reporting.Layouts.Parsed_InstantID_Layout ri) := TRANSFORM
	SELF.CVI		:= ri.CVI;
	SELF.NAP		:= ri.NAP;
	SELF.NAS		:= ri.NAS;
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
	SELF.FraudPointScore	:=ri.FraudPointScore;
	SELF.FraudPointRC1 	:=ri.FraudPointRC1;
	SELF.FraudPointRC2	:=ri.FraudPointRC2;
	SELF.FraudPointRC3	:=ri.FraudPointRC3;
	SELF.FraudPointRC4	:=ri.FraudPointRC4;
	SELF.FraudPointRC5	:=ri.FraudPointRC5;
	SELF.FraudPointRC6	:=ri.FraudPointRC6;
	SELF.RiskIndex1     :=ri.RiskIndex1;
	SELF.RiskIndex2     :=ri.RiskIndex2;
	SELF.RiskIndex3     :=ri.RiskIndex3;
	SELF.RiskIndex4     :=ri.RiskIndex4;
	SELF.RiskIndex5     :=ri.RiskIndex5;
	SELF.RiskIndex6     :=ri.RiskIndex6;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));

OUTPUT(COUNT(parsedRecords), NAMED('Total_Final_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, TransactionDate, TransactionID)), AccountID, TransactionDate, TransactionID, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);

/* ***********************************************************************************************
 *************************************************************************************************
 *             MODIFY EVERYTHING BELOW AS NEEDED TO PERFORM SAOT ANALYSIS                        *
 *************************************************************************************************
 *********************************************************************************************** */
