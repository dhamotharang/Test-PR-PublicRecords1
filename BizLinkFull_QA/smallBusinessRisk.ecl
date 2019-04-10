EXPORT smallBusinessRisk() := FUNCTION

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;

// BeginDate := '20180601';
// EndDate := '20180601';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 10;

outputFile := '~thor::bipheader::qa::SAOT::SmallBusinessRisk_' + BeginDate + '-' + EndDate;

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSRISK'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSRISK'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

op1 := OUTPUT(CHOOSEN(LogsRaw, eyeball), NAMED('LogsRaw'));

table(LogsRaw,{datetime[1..8],cnt := count(group)},datetime[1..8],merge);

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate},
																		SELF.inputxml := StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(LEFT.inputxml, '<SmallBusinessRiskRequest>', '<SmallBusinessRisk>'),'</SmallBusinessRiskRequest>', '</SmallBusinessRisk>'), '<SmallBusinessRisk>', '<SmallBusinessRisk><TransactionId>' + trim(LEFT.Transaction_Id,left,right) + '</TransactionId>');
																		SELF.outputxml := '<SmallBusinessRisk>' + LEFT.outputxml + '</SmallBusinessRisk>';
																		SELF.TransactionID :=trim(LEFT.Transaction_ID,left,right);
																		SELF.AccountID := LEFT.customer_id;
																		//self.login_id := 	LEFT.login_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));

op2 := OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));
op3 := OUTPUT(COUNT(Logs), NAMED('cnt_Logs'));



Parsed_SmallBusinessRisk_Layout := RECORD
STRING TransactionID := '';
String20 login_id := '';
STRING8		TransactionDate := '';
//options
// company name
STRING InCompanyName := '';
STRING InAlternateCompanyName := '';
// address
STRING InCompanyStreetAddress1 := '';
STRING InCompanyCity := '';
STRING InCompanyState := '';
STRING InCompanyZip5 := '';
STRING InCompanyPhone := '';
STRING InCompanyFEIN := '';
// authorized rep
STRING InRep1Name := '';
STRING InRep1SSN := '';
STRING InRep1DOB := '';
STRING InRep1DL := '';
STRING InRep1DLState := '';
STRING InRep1Phone := '';
// doesn't look like BIP IDs or Best info is returned
END;

Parsed_SmallBusinessRisk_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.InCompanyName					:= TRIM(XMLTEXT('SearchBy/Business/Name'));
	SELF.InAlternateCompanyName	:= TRIM(XMLTEXT('SearchBy/Business/AlternateName'));
	SELF.InCompanyStreetAddress1	:= TRIM(XMLTEXT('SearchBy/Business/Address/StreetAddress1'));
	SELF.InCompanyCity		:= TRIM(XMLTEXT('SearchBy/Business/Address/City'));
	SELF.InCompanyState		:= TRIM(XMLTEXT('SearchBy/Business/Address/State'));
	SELF.InCompanyZip5		:= TRIM(XMLTEXT('SearchBy/Business/Address/Zip5'));
	SELF.InCompanyPhone		:= TRIM(XMLTEXT('SearchBy/Business/Phone10'));
	SELF.InCompanyFEIN		:= TRIM(XMLTEXT('SearchBy/Business/FEIN'));
	SELF.InRep1Name	:= TRIM(XMLTEXT('SearchBy/OwnerAgent/Name'));
	SELF.InRep1SSN				:= TRIM(XMLTEXT('SearchBy/OwnerAgent/SSN'));
	SELF.InRep1DOB				:= TRIM(XMLTEXT('SearchBy/OwnerAgent/DOB'));
	SELF.InRep1DL 				:= TRIM(XMLTEXT('SearchBy/OwnerAgent/DriverLicenseNumber'));
	SELF.InRep1DLState 		:= TRIM(XMLTEXT('SearchBy/OwnerAgent/DriverLicenseState'));
	SELF.InRep1Phone 			:= TRIM(XMLTEXT('SearchBy/OwnerAgent/Phone10'));
	SELF := [];
END;

parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('SmallBusinessRisk')), HASH64(TransactionID));

op4 := OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));
op5 := OUTPUT(COUNT(parsedInput), NAMED('parsedInput'));

// no output needed
parsedRecords := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.login_id := RIGHT.login_id; SELF := LEFT), LOCAL);

op6 := OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('parsedRecords'));

op7 := OUTPUT(COUNT(parsedRecords), NAMED('cnt_parsedRecords'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(login_id, TransactionDate, TransactionID)), login_id, TransactionDate, TransactionID, LOCAL);
op9 := OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('finalRecords'));

table(finalRecords,{TransactionDate,cnt := count(group)},TransactionDate,merge);

op := OUTPUT(finalRecords,, outputFile, THOR, OVERWRITE, COMPRESSED, EXPIRE(90));

RETURN op;

END;