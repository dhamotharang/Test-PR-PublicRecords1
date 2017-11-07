#workunit('name', 'FlexID_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;
BeginDate := '20130601';
EndDate := '20150416';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids
 // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 100;

outputFile := 'bpahl::out::FLEXID_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// TransactionIDs :=['103748062R162943'];

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw_1 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FLEXID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs /*AND Transaction_ID IN transactionIDs*/))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FLEXID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs/* AND Transaction_ID IN transactionIDs*/))));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FlexID>', '<FlexID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<FlexID>' + LEFT.outputxml + '</FlexID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_1, eyeball), NAMED('Sample_Yesterday_Logs_1'));

Risk_Reporting.Layouts.Parsed_FlexID_Layout parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	//SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
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
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	//SELF.FullName				:= TRIM(XMLTEXT('SearchBy/Name/Full'));
	
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	ssn_temp := trim(XMLTEXT('SearchBy/SSN'));
	ssnlast4_temp := trim(XMLTEXT('SearchBy/SSNLast4'));
	ssn_val := if(ssn_temp <> '' and (integer)ssn_temp > 0, ssn_temp, ssnlast4_temp);
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(ssn_val);
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	//SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	//SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	
	//SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedInput_1 := DISTRIBUTE(PARSE(Logs_1, inputxml, parseInput(), XML('FlexID')), HASH64(TransactionID));
OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_parsedInput_1'));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_2 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FlexIDRequest>', '<FlexIDRequest><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<FlexID>' + LEFT.outputxml + '</FlexID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Yesterday_Logs_2'));

Risk_Reporting.Layouts.Parsed_FlexID_Layout parseInput_2 () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	//SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
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
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	//SELF.FullName				:= TRIM(XMLTEXT('SearchBy/Name/Full'));
	
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	ssn_temp := trim(XMLTEXT('SearchBy/SSN'));
	ssnlast4_temp := trim(XMLTEXT('SearchBy/SSNLast4'));
	ssn_val := if(ssn_temp <> '' and (integer)ssn_temp > 0, ssn_temp, ssnlast4_temp);
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(ssn_val);
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	//SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	//SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	
	//SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedInput_2 := DISTRIBUTE(PARSE(Logs_2, inputxml, parseInput_2(), XML('FlexIDRequest')), HASH64(TransactionID));
OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_parsedInput_2'));
LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22; //since the rawlog_1 has all the records, we only want the records with the correct XML tags we could link them to

Risk_Reporting.Layouts.Parsed_FlexID_Layout parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	ModelName           := TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type'));
	CVIModel						:= IF(StringLib.StringToUpperCase(ModelName) = 'CVI', TRUE, FALSE);
	SELF.CVI						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]/ComprehensiveVerificationIndex')) + // FLEXID
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value')), ''); // FLEXID Model
	SELF.NAP						:= TRIM(XMLTEXT('Result/NameAddressPhone[1]/Summary'));
	SELF.NAS						:= TRIM(XMLTEXT('Result/NameAddressSSNSummary'));
	FPModelName         := TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name'));
  IsFPModel           := IF(StringLib.StringToUpperCase(FPModelName) IN ['FRAUDDEFENDER', 'FRAUDPOINT','FRAUDPOINTFP31505_0'], TRUE, FALSE);
 SELF.FraudPointScore:= IF(IsFPModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value')), '');
 SELF.FraudPointRC1	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators/HighRiskIndicator[1]/RiskCode'));
	SELF.FraudPointRC2	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators/HighRiskIndicator[2]/RiskCode'));
	SELF.FraudPointRC3	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators/HighRiskIndicator[3]/RiskCode'));
	SELF.FraudPointRC4	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators/HighRiskIndicator[4]/RiskCode'));
	SELF.FraudPointRC5	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators/HighRiskIndicator[5]/RiskCode'));
	SELF.FraudPointRC6	:=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators/HighRiskIndicator[6]/RiskCode'));
	SELF.RiskIndex1     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[1]/Value'));
	SELF.RiskIndex2     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[2]/Value'));
	SELF.RiskIndex3     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[3]/Value'));
	SELF.RiskIndex4     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[4]/Value'));
	SELF.RiskIndex5     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[5]/Value'));
	SELF.RiskIndex6     :=TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndices/RiskIndex[6]/Value'));
	
	SELF.RC1						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode')), '');
	SELF.RC2						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[2]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode')), '');
	SELF.RC3						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[3]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode')), '');
	SELF.RC4						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[4]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode')), '');
	SELF.RC5						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[5]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode')), '');
	SELF.RC6						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[6]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode')), '');
	SELF.RC7						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[7]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode')), '');
	SELF.RC8						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[8]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode')), '');
	SELF.RC9						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[9]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode')), '');
	SELF.RC10						:= TRIM(XMLTEXT('Result/ComprehensiveVerification[1]//RiskIndicators[1]/RiskIndicator[10]/RiskCode')) + 
												 IF(CVIModel, TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode')), '');
	SELF := [];
END;

parsedOutputTemp_1 := PARSE(Logs_1, outputxml, parseOutput(), XML('FlexID'));
parsedOutputTemp_2 := PARSE(Logs_2, outputxml, parseOutput(), XML('FlexID'));
parsedOutputTemp := parsedOutputTemp_1 + parsedOutputTemp_2;

OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));
// OUTPUT(parsedOutputTemp(parsedOutputTemp.RiskIndex1 <>''), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_FLEXID_Layout normScores(Risk_Reporting.Layouts.Parsed_FLEXID_Layout le, UNSIGNED1 t) := TRANSFORM
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

Risk_Reporting.Layouts.Parsed_FLEXID_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_FLEXID_Layout le, Risk_Reporting.Layouts.Parsed_FLEXID_Layout ri) := TRANSFORM
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
parsedRecordsTemp_in := parsedInput_1+parsedInput_2;
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedRecordsTemp_in, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);
parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));

OUTPUT(COUNT(parsedRecords), NAMED('Total_Final_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, TransactionDate, TransactionID)), AccountID, TransactionDate, TransactionID, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));
// table(finalRecords(AccountID = '1541352' and TransactionDate between BeginDate and enddate), {TransactionDate,  cnt := count(group)}, TransactionDate,  few);
  
OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);

/* ***********************************************************************************************
 *************************************************************************************************
 *             MODIFY EVERYTHING BELOW AS NEEDED TO PERFORM SAOT ANALYSIS                        *
 *************************************************************************************************
 *********************************************************************************************** */
