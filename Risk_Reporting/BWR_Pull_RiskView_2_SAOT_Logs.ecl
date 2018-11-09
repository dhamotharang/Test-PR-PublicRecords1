/*2017-10-19T00:59:59Z (Andrea Koenen)
changing 1 more tag
*/
#workunit('name', 'RiskView_2_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20140201';
EndDate := '20140430';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

companyNameFilter := ''; // Set to BLANK '' to not filter by company name.  This filter is typically only needed for companies such as Experian who resell our products.
// companyNameFilter := StringLib.StringToUpperCase('DIRECTV'); // Set to BLANK '' to not filter by company name.  This filter is typically only needed for companies such as Experian who resell our products.

eyeball := 100;

outputFile := '~akoenen::out::RiskView_2_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID;

LogsRaw_1 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW2'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW2'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING25 LoginID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView2>', '<RiskView2><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<RiskView2>' + LEFT.outputxml + '</RiskView2>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.LoginID := LEFT.Login_ID;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs_1, eyeball), NAMED('Sample_Raw_Logs_1'));

Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout parseInput () := TRANSFORM
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
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedInput_1 := DISTRIBUTE(PARSE(Logs_1, inputxml, parseInput(), XML('RiskView2')), HASH64(TransactionID));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_Parsed_Input_1'));
//new XML tags
Logs_2 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING25 LoginID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView2Request>', '<RiskView2Request><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<RiskView2>' + LEFT.outputxml + '</RiskView2>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.LoginID := LEFT.Login_ID;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Raw_Logs_2'));

Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout parseInput_2 () := TRANSFORM
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
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedInput_2 := DISTRIBUTE(PARSE(Logs_2, inputxml, parseInput_2(), XML('RiskView2Request')), HASH64(TransactionID));
//End new XML tag code
LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22; //since the rawlog_1 has all the records, we only want the records with the correct XML tags we could link them to

OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_parsedInput_2'));

Parsed_Layout_Temp := RECORD
	Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout;
	
	STRING3 Score1 := '';
	STRING3 Score2 := '';
	STRING3 Score3 := '';
	STRING3 Score4 := '';
	STRING3 Score5 := '';
	STRING3 Score6 := '';
	
	STRING15 Model1 := '';
	STRING15 Model2 := '';
	STRING15 Model3 := '';
	STRING15 Model4 := '';
	STRING15 Model5 := '';
	STRING15 Model6 := '';
	
	STRING10 ScoreType1 := '';
	STRING10 ScoreType2 := '';
	STRING10 ScoreType3 := '';
	STRING10 ScoreType4 := '';
	STRING10 ScoreType5 := '';
	STRING10 ScoreType6 := '';
	
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
	STRING5 RC6_1		:= '';
	STRING5 RC6_2		:= '';
	STRING5 RC6_3		:= '';
	STRING5 RC6_4		:= '';
	STRING5 RC6_5		:= '';
	STRING5 RC6_6		:= '';
END;

Parsed_Layout_Temp parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	
	SELF.Score1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value'));
	SELF.Score2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Value'));
	SELF.Score3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Value'));
	SELF.Score4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Value'));
	SELF.Score5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Value'));
	SELF.Score6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/Value'));
	
	SELF.ScoreType1			:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type'));
	SELF.ScoreType2			:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Type'));
	SELF.ScoreType3			:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Type'));
	SELF.ScoreType4			:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Type'));
	SELF.ScoreType5			:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Type'));
	SELF.ScoreType6			:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/Type'));
	
	SELF.Model1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name'));
	SELF.Model2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Name'));
	SELF.Model3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Name'));
	SELF.Model4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Name'));
	SELF.Model5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Name'));
	SELF.Model6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Name'));
	
	SELF.RC1_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode'));
	SELF.RC1_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode'));
	SELF.RC1_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode'));
	SELF.RC1_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode'));
	SELF.RC1_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode'));
	SELF.RC1_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode'));
	
	SELF.RC2_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode'));
	SELF.RC2_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode'));
	SELF.RC2_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode'));
	SELF.RC2_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode'));
	SELF.RC2_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode'));
	SELF.RC2_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode'));
	
	SELF.RC3_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode'));
	SELF.RC3_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode'));
	SELF.RC3_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode'));
	SELF.RC3_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode'));
	SELF.RC3_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode'));
	SELF.RC3_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode'));
	
	SELF.RC4_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode'));
	SELF.RC4_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode'));
	SELF.RC4_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode'));
	SELF.RC4_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode'));
	SELF.RC4_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode'));
	SELF.RC4_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode'));
	
	SELF.RC5_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode'));
	SELF.RC5_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode'));
	SELF.RC5_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode'));
	SELF.RC5_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode'));
	SELF.RC5_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode'));
	SELF.RC5_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode'));
	
	SELF.RC6_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[1]/ReasonCode'));
	SELF.RC6_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[2]/ReasonCode'));
	SELF.RC6_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[3]/ReasonCode'));
	SELF.RC6_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[4]/ReasonCode'));
	SELF.RC6_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[5]/ReasonCode'));
	SELF.RC6_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/ScoreReasons[1]/ScoreReason[6]/ReasonCode'));
	
	SELF.Alert1					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[1]/Code'));
	SELF.Alert2					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[2]/Code'));
	SELF.Alert3					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[3]/Code'));
	SELF.Alert4					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[4]/Code'));
	SELF.Alert5					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[5]/Code'));
	SELF.Alert6					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[6]/Code'));
	SELF.Alert7					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[7]/Code'));
	SELF.Alert8					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[8]/Code'));
	SELF.Alert9					:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[9]/Code'));
	SELF.Alert10				:= TRIM(XMLTEXT('Result/Alerts[1]/Alert[10]/Code'));
	
	SELF := [];
END;

parsedOutputTemp_1 := PARSE(Logs_11, outputxml, parseOutput(), XML('RiskView2'));
parsedOutputTemp_2 := PARSE(Logs_22, outputxml, parseOutput(), XML('RiskView2'));
parsedOutputTemp := parsedOutputTemp_1 + parsedOutputTemp_2;
// parsedOutputTemp := DEDUP(SORT(DISTRIBUTE(parsedOutputTemp_1 + parsedOutputTemp_2, HASH64(TransactionID)),
													// TransactionID), TransactionID);
OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout normScores(Parsed_Layout_Temp le, UNSIGNED1 t) := TRANSFORM
	SELF.Score := CASE(t,
		1 => le.Score1,
		2 => le.Score2,
		3 => le.Score3,
		4 => le.Score4,
		5 => le.Score5,
		6 => le.Score6,
		'');
		
	SELF.ScoreType := CASE(t,
		1 => le.ScoreType1,
		2 => le.ScoreType2,
		3 => le.ScoreType3,
		4 => le.ScoreType4,
		5 => le.ScoreType5,
		6 => le.ScoreType6,
		'');
		
	SELF.Model := CASE(t,
		1 => le.Model1,
		2 => le.Model2,
		3 => le.Model3,
		4 => le.Model4,
		5 => le.Model5,
		6 => le.Model6,
		'');
		
	SELF.RC1 := CASE(t,
		1		=> le.RC1_1,
		2		=> le.RC2_1,
		3		=> le.RC3_1,
		4		=> le.RC4_1,
		5		=> le.RC5_1,
		6		=> le.RC6_1,
		'');

	SELF.RC2 := CASE(t,
		1		=> le.RC1_2,
		2		=> le.RC2_2,
		3		=> le.RC3_2,
		4		=> le.RC4_2,
		5		=> le.RC5_2,
		6		=> le.RC6_2,
		'');
	
	SELF.RC3 := CASE(t,
		1		=> le.RC1_3,
		2		=> le.RC2_3,
		3		=> le.RC3_3,
		4		=> le.RC4_3,
		5		=> le.RC5_3,
		6		=> le.RC6_3,
		'');
		
	SELF.RC4 := CASE(t,
		1		=> le.RC1_4,
		2		=> le.RC2_4,
		3		=> le.RC3_4,
		4		=> le.RC4_4,
		5		=> le.RC5_4,
		6		=> le.RC6_4,
		'');
		
	SELF.RC5 := CASE(t,
		1		=> le.RC1_5,
		2		=> le.RC2_5,
		3		=> le.RC3_5,
		4		=> le.RC4_5,
		5		=> le.RC5_5,
		6		=> le.RC6_5,
		'');
		
	SELF.RC6 := CASE(t,
		1		=> le.RC1_6,
		2		=> le.RC2_6,
		3		=> le.RC3_6,
		4		=> le.RC4_6,
		5		=> le.RC5_6,
		6		=> le.RC6_6,
		'');
	
	SELF := le;
END;
parsedOutput := NORMALIZE(parsedOutputTemp, 6, normScores(LEFT, COUNTER)) ((INTEGER)Score > 0);

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Normalized_Output'));

Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout le, Risk_Reporting.Layouts.Parsed_RiskView2_Tracking_Layout ri) := TRANSFORM
	SELF.Score	:= ri.Score;
	SELF.ScoreType := ri.ScoreType;
	SELF.Model	:= ri.Model;
	SELF.RC1		:= ri.RC1;
	SELF.RC2		:= ri.RC2;
	SELF.RC3		:= ri.RC3;
	SELF.RC4		:= ri.RC4;
	SELF.RC5		:= ri.RC5;
	SELF.RC6		:= ri.RC6;
	
	SELF.Alert1	:= ri.Alert1;
	SELF.Alert2	:= ri.Alert2;
	SELF.Alert3	:= ri.Alert3;
	SELF.Alert4	:= ri.Alert4;
	SELF.Alert5	:= ri.Alert5;
	SELF.Alert6	:= ri.Alert6;
	SELF.Alert7	:= ri.Alert7;
	SELF.Alert8	:= ri.Alert8;
	SELF.Alert9	:= ri.Alert9;
	SELF.Alert10:= ri.Alert10;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp_in := parsedInput_1+parsedInput_2 ;
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedRecordsTemp_in, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(10), ATMOST(RiskWise.max_atmost), LOCAL) (TRIM(StringLib.StringToUpperCase(companyname)) NOT IN ['', 'RISKWISE INTERNAL ADMIN']);

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF.LoginID := RIGHT.LoginID; SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));
OUTPUT(COUNT(parsedRecords), NAMED('Total_Fully_Parsed_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(TransactionDate)), TransactionDate, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
// table(finalRecords(AccountID = '101651' and TransactionDate between BeginDate and enddate), {TransactionDate,  cnt := count(group)}, TransactionDate,  few);
   
#if(companyNameFilter = '')
#else
	companyFilteredRecords := finalRecords (StringLib.StringToUpperCase(CompanyName) = companyNameFilter);
	OUTPUT(COUNT(companyFilteredRecords), NAMED('Total_Company_Records'));
	OUTPUT(companyFilteredRecords,, outputFile + '_' + companyNameFilter + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
#end