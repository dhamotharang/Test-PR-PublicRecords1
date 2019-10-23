EXPORT smallBusinessAnalytics() := FUNCTION

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;

// BeginDate := '20180601';
// EndDate := '20180601';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 10;

outputFile := '~thor::bipheader::qa::SAOT::SmallBusinessAnalytics_' + BeginDate + '-' + EndDate;

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSANALYTICS'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSANALYTICS'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

op1 := OUTPUT(CHOOSEN(LogsRaw, eyeball), NAMED('LogsRaw'));

table(LogsRaw,{datetime[1..8],cnt := count(group)},datetime[1..8],merge);

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate},
																		SELF.inputxml := StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(LEFT.inputxml, '<SmallBusinessAnalyticsRequest>', '<SmallBusinessAnalytics>'),'</SmallBusinessAnalyticsRequest>', '</SmallBusinessAnalytics>'), '<SmallBusinessAnalytics>', '<SmallBusinessAnalytics><TransactionId>' + trim(LEFT.Transaction_Id,left,right) + '</TransactionId>');
																		SELF.outputxml := '<SmallBusinessAnalytics>' + LEFT.outputxml + '</SmallBusinessAnalytics>';
																		SELF.TransactionID :=trim(LEFT.Transaction_ID,left,right);
																		SELF.AccountID := LEFT.customer_id;
																		//self.login_id := 	LEFT.login_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));

op2 := OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));
op3 := OUTPUT(COUNT(Logs), NAMED('cnt_Logs'));

Parsed_SmallBusinessAnalytics_Layout := RECORD
STRING TransactionID := '';
String20 login_id := '';
STRING8		TransactionDate := '';
//options
// STRING AttributesVersionRequestName := '';
// company name
STRING InCompanyName := '';
STRING InAlternateCompanyName := '';
// address
STRING InCompanyStreetAddress1 := '';
STRING InCompanyStreetAddress2 := ''; // this looks to be duplicate of addr1
STRING InCompanyCity := '';
STRING InCompanyState := '';
STRING InCompanyZip5 := '';
STRING InCompanyPhone := '';
STRING InCompanyFEIN := '';
STRING InCompanySIC := '';
// authorized rep
STRING InRep1FirstName := '';
STRING InRep1LastName := '';
STRING InRep1StreetAddress1 := '';
STRING InRep1City := '';
STRING InRep1State := '';
STRING InRep1SSN := '';
STRING InRep1DOB := '';
STRING InRep1DL := '';
STRING InRep1DLState := '';
STRING InRep1Phone := '';
// doesn't look like BIP IDs or Best info is returned
END;

Parsed_SmallBusinessAnalytics_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	// SELF.AttributesVersionRequestName		:= TRIM(XMLTEXT('Options/AttributesVersionRequest/Name'));
	SELF.InCompanyName					:= TRIM(XMLTEXT('SearchBy/Company/CompanyName'));
	SELF.InAlternateCompanyName	:= TRIM(XMLTEXT('SearchBy/Company/AlternateCompanyName'));
	SELF.InCompanyStreetAddress1	:= TRIM(XMLTEXT('SearchBy/Company/Address/StreetAddress1'));
	SELF.InCompanyStreetAddress2	:= if(TRIM(XMLTEXT('SearchBy/Company/Address/StreetAddress2')) <> self.inCompanyStreetAddress1, TRIM(XMLTEXT('SearchBy/Company/Address/StreetAddress2')), '');
	SELF.InCompanyCity		:= TRIM(XMLTEXT('SearchBy/Company/Address/City'));
	SELF.InCompanyState		:= TRIM(XMLTEXT('SearchBy/Company/Address/State'));
	SELF.InCompanyZip5		:= TRIM(XMLTEXT('SearchBy/Company/Address/Zip5'));
	SELF.InCompanyPhone		:= TRIM(XMLTEXT('SearchBy/Company/Phone'));
	SELF.InCompanyFEIN		:= TRIM(XMLTEXT('SearchBy/Company/FEIN'));
	SELF.InCompanySIC		:= TRIM(XMLTEXT('SearchBy/Company/SICCode'));
	SELF.InRep1FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/First'));
	SELF.InRep1LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/Last'));
	SELF.InRep1StreetAddress1 := TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/SreetAddress1'));
	SELF.InRep1City 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/City'));
	SELF.InRep1State 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/State'));
	SELF.InRep1SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/SSN'));
	SELF.InRep1DOB				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DOB'));
	SELF.InRep1DL 				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseNumber'));
	SELF.InRep1DLState 		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseState'));
	SELF.InRep1Phone 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Phone'));
	SELF := [];
END;

parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('SmallBusinessAnalytics')), HASH64(TransactionID));

op4 := OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));
op5 := OUTPUT(COUNT(parsedInput), NAMED('parsedInput'));

// no output needed
parsedRecords := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.login_id := RIGHT.login_id; SELF := LEFT), LOCAL);

op6 := OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('parsedRecords'));

op7 := OUTPUT(COUNT(parsedRecords), NAMED('cnt_parsedRecords'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(login_id, TransactionDate, TransactionID)), login_id, TransactionDate, TransactionID, LOCAL);
op8 := OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('finalRecords'));

table(finalRecords,{TransactionDate,cnt := count(group)},TransactionDate,merge);

op := OUTPUT(finalRecords,, outputFile, THOR, OVERWRITE, COMPRESSED, EXPIRE(90));


RETURN op;
END;