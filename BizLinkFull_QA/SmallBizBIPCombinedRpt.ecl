EXPORT SmallBizBIPCombinedRpt() := FUNCTION

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;


EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;
// BeginDate := '20180601';
// EndDate := '20180601';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 10;

outputFile := '~thor::bipheader::qa::SAOT::SmallBizBIPCombinedRpt_' + BeginDate + '-' + EndDate;

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSBIPCOMBINEDREPORT'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSBIPCOMBINEDREPORT'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

op0 := OUTPUT(CHOOSEN(LogsRaw, eyeball), NAMED('LogsRaw'));

table(LogsRaw,{datetime[1..8],cnt := count(group)},datetime[1..8],merge);

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate},
																		SELF.inputxml := StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(LEFT.inputxml, '<SmallBusinessBipCombinedReportRequest>', '<SmallBusinessBipCombinedReport>'),'</SmallBusinessBipCombinedReportRequest>', '</SmallBusinessBipCombinedReport>'), '<SmallBusinessBipCombinedReport>', '<SmallBusinessBipCombinedReport><TransactionId>' + trim(LEFT.Transaction_Id,left,right) + '</TransactionId>');
																		SELF.outputxml := '<SmallBusinessBipCombinedReport>' + LEFT.outputxml + '</SmallBusinessBipCombinedReport>';
																		SELF.TransactionID :=trim(LEFT.Transaction_ID,left,right);
																		SELF.AccountID := LEFT.customer_id;
																		//self.login_id := 	LEFT.login_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));

op1 := OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));
op2 := OUTPUT(COUNT(Logs), NAMED('cnt_Logs'));

Parsed_CombinedReport_Layout := RECORD
STRING TransactionID := '';
String20 login_id := '';
STRING8		TransactionDate := '';
//options
// STRING AttributesVersionRequestName := '';
// company name
STRING InCompanyName := '';
STRING InAlternateCompanyName := '';
// business ids
UNSIGNED6 InDotID := 0;
UNSIGNED6 InEmpID := 0;
UNSIGNED6 InPOWID := 0;
UNSIGNED6 InProxID := 0;
UNSIGNED6 InSeleID := 0;
UNSIGNED6 InOrgID := 0;
UNSIGNED6 InUltID := 0;
// address
STRING InCompanyStreetNumber := '';
STRING InCompanyStreetName := '';
STRING InCompanyUnitNumber := '';
STRING InCompanyStreetAddress1 := '';
STRING InCompanyStreetAddress2 := '';
STRING InCompanyCity := '';
STRING InCompanyState := '';
STRING InCompanyZip5 := '';
STRING InCompanyStateCityZip := '';
UNSIGNED6 InZipRadius := 0;
STRING InCompanyPhone := '';
STRING InCompanyFEIN := '';
STRING InCompanySIC := '';
STRING InEmail := '';
// authorized rep
STRING InRep1FirstName := '';
STRING InRep1LastName := '';
STRING InRep1StreetAddress1 := '';
STRING InRep1City := '';
STRING InRep1State := '';
STRING InRep1Zip5 := '';
STRING InRep1SSN := '';
STRING InRep1DOB := '';
STRING InRep1DL := '';
STRING InRep1DLState := '';
STRING InRep1Phone := '';
// credit report records best info
UNSIGNED6 BestDotID := 0;
UNSIGNED6 BestEmpID := 0;
UNSIGNED6 BestPOWID := 0;
UNSIGNED6 BestProxID := 0;
UNSIGNED6 BestSeleID := 0;
UNSIGNED6 BestOrgID := 0;
UNSIGNED6 BestUltID := 0;
STRING BestCompanyName := '';
STRING BestCompanyStreetNumber := '';
STRING BestCompanyStreetName := '';
STRING BestCompanyUnitNumber := '';
STRING BestCompanyStreetAddress1 := '';
STRING BestCompanyStreetAddress2 := '';
STRING BestCompanyCity := '';
STRING BestCompanyState := '';
STRING BestCompanyZip5 := '';
STRING BestCompanyStateCityZip := '';
STRING BestCompanyPhone := '';
END;

Parsed_CombinedReport_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	// SELF.AttributesVersionRequestName		:= TRIM(XMLTEXT('Options/AttributesVersionRequest/Name'));
	SELF.InCompanyName					:= TRIM(XMLTEXT('SearchBy/Company/CompanyName'));
	SELF.InAlternateCompanyName	:= TRIM(XMLTEXT('SearchBy/Company/AlternateCompanyName'));
	SELF.InDotID 								:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/DotID'));
	SELF.InEmpID 								:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/EmpID'));
	SELF.InPOWID 								:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/POWID'));
	SELF.InProxID 							:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/ProxID'));
	SELF.InSeleID 							:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/SeleID'));
	SELF.InOrgID 								:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/OrgID'));
	SELF.InUltID 								:= (INTEGER) TRIM(XMLTEXT('SearchBy/Company/BusinessIds/UltID'));
	SELF.InCompanyStreetNumber 	:= TRIM(XMLTEXT('SearchBy/Company/Address/StreetNumber'));
	SELF.InCompanyStreetName 		:= TRIM(XMLTEXT('SearchBy/Company/Address/StreetName'));
	SELF.InCompanyUnitNumber 		:= TRIM(XMLTEXT('SearchBy/Company/Address/UnitNumber'));
	SELF.InCompanyStreetAddress1	:= TRIM(XMLTEXT('SearchBy/Company/Address/StreetAddress1'));
	SELF.InCompanyStreetAddress2	:= TRIM(XMLTEXT('SearchBy/Company/Address/StreetAddress2'));
	SELF.InCompanyCity		:= TRIM(XMLTEXT('SearchBy/Company/Address/City'));
	SELF.InCompanyState		:= TRIM(XMLTEXT('SearchBy/Company/Address/State'));
	SELF.InCompanyZip5		:= TRIM(XMLTEXT('SearchBy/Company/Address/Zip5'));
	SELF.InCompanyPhone		:= TRIM(XMLTEXT('SearchBy/Company/Phone'));
	SELF.InCompanyFEIN		:= TRIM(XMLTEXT('SearchBy/Company/FEIN'));
	SELF.InRep1FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/First'));
	SELF.InRep1LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/Last'));
	SELF.InRep1StreetAddress1 := TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/SreetAddress1'));
	SELF.InRep1City 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/City'));
	SELF.InRep1State 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/State'));
	SELF.InRep1Zip5 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/Zip5'));
	SELF.InRep1SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/SSN'));
	SELF.InRep1DOB				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DOB'));
	SELF.InRep1DL 				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseNumber'));
	SELF.InRep1DLState 		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseState'));
	SELF.InRep1Phone 			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Phone'));
	SELF := [];
END;

parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('SmallBusinessBipCombinedReport')), HASH64(TransactionID));

op3 := OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));
op4 := OUTPUT(COUNT(parsedInput), NAMED('parsedInput'));

Parsed_CombinedReport_Layout parseOutput() := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	SELF.BestDotID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/DotID'));
	SELF.BestEmpID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/EmpID'));
	SELF.BestPOWID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/POWID'));
	SELF.BestProxID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/ProxID'));
	SELF.BestSeleID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/SeleID'));
	SELF.BestOrgID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/OrgID'));
	SELF.BestUltID	:= (INTEGER) TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/BusinessIds/UltID'));
	SELF.BestCompanyName := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyName'));
	SELF.BestCompanyStreetNumber := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/StreetNumber'));
	SELF.BestCompanyStreetName := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/StreetName'));
	SELF.BestCompanyUnitNumber := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/UnitNumber'));;
	SELF.BestCompanyStreetAddress1 := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/StreetAddress1'));
	SELF.BestCompanyStreetAddress2 := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/StreetAddress2'));
	SELF.BestCompanyCity := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/City'));
	SELF.BestCompanyState := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/State'));
	SELF.BestCompanyZip5 := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/Zip5'));
	SELF.BestCompanyStateCityZip := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyAddress/StateCityZip'));
	SELF.BestCompanyPhone := TRIM(XMLTEXT('CreditReportRecords/Record/BestInformation/CompanyPhone'));
	SELF := [];
END;

parsedOutput := PARSE(Logs, outputxml, parseOutput(), XML('SmallBusinessBipCombinedReport'));

op5 := OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

op6 := OUTPUT(COUNT(parsedOutput), NAMED('parsedOutput'));


Parsed_CombinedReport_Layout combineParsedRecords(Parsed_CombinedReport_Layout le, Parsed_CombinedReport_Layout ri) := TRANSFORM

SELF.TransactionID := le.TransactionID;
SELF.login_id := le.login_id;
SELF.TransactionDate := le.TransactionDate;
SELF.InCompanyName := le.InCompanyName;
SELF.InAlternateCompanyName := le.InAlternateCompanyName;
SELF.InDotID := le.InDotID;
SELF.InEmpID := le.InEmpID;
SELF.InPOWID := le.InPOWID;
SELF.InProxID := le.InProxID;
SELF.InSeleID := le.InSeleID;
SELF.InOrgID := le.InOrgID;
SELF.InUltID := le.InUltID;
SELF.InCompanyStreetNumber := le.InCompanyStreetNumber;
SELF.InCompanyStreetName := le.InCompanyStreetName;
SELF.InCompanyUnitNumber := le.InCompanyUnitNumber;
SELF.InCompanyStreetAddress1 := le.InCompanyStreetAddress1;
SELF.InCompanyStreetAddress2 := le.InCompanyStreetAddress2;
SELF.InCompanyCity := le.InCompanyCity;
SELF.InCompanyState := le.InCompanyState;
SELF.InCompanyZip5 := le.InCompanyZip5;
SELF.InCompanyStateCityZip := le.InCompanyStateCityZip;
SELF.InZipRadius := le.InZipRadius;
SELF.InCompanyPhone := le.InCompanyPhone;
SELF.InCompanyFEIN := le.InCompanyFEIN;
SELF.InCompanySIC := le.InCompanySIC;
SELF.InEmail := le.InEmail;
SELF.InRep1FirstName := le.InRep1FirstName;
SELF.InRep1LastName := le.InRep1LastName;
SELF.InRep1StreetAddress1 := le.InRep1StreetAddress1;
SELF.InRep1City := le.InRep1City;
SELF.InRep1State := le.InRep1State;
SELF.InRep1Zip5 := le.InRep1Zip5;
SELF.InRep1SSN := le.InRep1SSN;
SELF.InRep1DOB := le.InRep1DOB;
SELF.InRep1DL := le.InRep1DL;
SELF.InRep1DLState := le.InRep1DLState;
SELF.InRep1Phone := le.InRep1Phone;
SELF := ri;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);

op7 := OUTPUT(COUNT(parsedRecordsTemp), NAMED('parsedRecordsTemp'));

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.login_id := RIGHT.login_id; SELF := LEFT), LOCAL);

op8 := OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('parsedRecords'));

OUTPUT(COUNT(parsedRecords), NAMED('cnt_parsedRecords'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(login_id, TransactionDate, TransactionID)), login_id, TransactionDate, TransactionID, LOCAL);
op9 := OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('finalRecords'));

table(finalRecords,{TransactionDate,cnt := count(group)},TransactionDate,merge);

op := OUTPUT(finalRecords,, outputFile, THOR, OVERWRITE, COMPRESSED, EXPIRE(90));

RETURN op;

END;
