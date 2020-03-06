﻿IMPORT STD, ADDRESS;
EXPORT saotDataSample := MODULE

EXPORT businessCreditReport() := FUNCTION

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;

// BeginDate := '20180601';
// EndDate := '20180601';

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 10;

outputFile := '~thor::bipheader::qa::SAOT::BusinessCreditReport_' + BeginDate + '-' + EndDate;

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSCREDITREPORT'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSCREDITREPORT'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

op1 := OUTPUT(CHOOSEN(LogsRaw, eyeball), NAMED('LogsRaw'));

table(LogsRaw,{datetime[1..8],cnt := count(group)},datetime[1..8],merge);

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate},
																		SELF.inputxml := StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(LEFT.inputxml, '<BusinessCreditReportRequest>', '<BusinessCreditReport>'),'</BusinessCreditReportRequest>', '</BusinessCreditReport>'), '<BusinessCreditReport>', '<BusinessCreditReport><TransactionId>' + trim(LEFT.Transaction_Id,left,right) + '</TransactionId>');
																		SELF.outputxml := '<BusinessCreditReport>' + LEFT.outputxml + '</BusinessCreditReport>';
																		SELF.TransactionID :=trim(LEFT.Transaction_ID,left,right);
																		SELF.AccountID := LEFT.customer_id;
																		//self.login_id := 	LEFT.login_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));

op2 := OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));
op3 := OUTPUT(COUNT(Logs), NAMED('cnt_Logs'));


Parsed_BusinessCreditReport_Layout := RECORD
STRING TransactionID := '';
String20 login_id := '';
STRING8		TransactionDate := '';
// company name
STRING InCompanyName := '';
STRING InAlternateCompanyName := ''; // ?
// business ids
UNSIGNED6 InDotID := 0;
UNSIGNED6 InEmpID := 0;
UNSIGNED6 InPOWID := 0;
UNSIGNED6 InProxID := 0;
UNSIGNED6 InSeleID := 0;
UNSIGNED6 InOrgID := 0;
UNSIGNED6 InUltID := 0;
// address // ?
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

Parsed_BusinessCreditReport_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	// SELF.AttributesVersionRequestName		:= TRIM(XMLTEXT('Options/AttributesVersionRequest/Name'));
	SELF.InCompanyName					:= TRIM(XMLTEXT('ReportBy/Company/CompanyName'));
	SELF.InAlternateCompanyName	:= TRIM(XMLTEXT('ReportBy/Company/AlternateCompanyName'));
	SELF.InDotID 								:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/DotID'));
	SELF.InEmpID 								:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/EmpID'));
	SELF.InPOWID 								:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/POWID'));
	SELF.InProxID 							:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/ProxID'));
	SELF.InSeleID 							:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/SeleID'));
	SELF.InOrgID 								:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/OrgID'));
	SELF.InUltID 								:= (INTEGER) TRIM(XMLTEXT('ReportBy/Company/BusinessIds/UltID'));
	SELF.InCompanyStreetNumber 	:= TRIM(XMLTEXT('ReportBy/Company/Address/StreetNumber'));
	SELF.InCompanyStreetName 		:= TRIM(XMLTEXT('ReportBy/Company/Address/StreetName'));
	SELF.InCompanyUnitNumber 		:= TRIM(XMLTEXT('ReportBy/Company/Address/UnitNumber'));
	SELF.InCompanyStreetAddress1	:= TRIM(XMLTEXT('ReportBy/Company/Address/StreetAddress1'));
	SELF.InCompanyStreetAddress2	:= TRIM(XMLTEXT('ReportBy/Company/Address/StreetAddress2'));
	SELF.InCompanyCity		:= TRIM(XMLTEXT('ReportBy/Company/Address/City'));
	SELF.InCompanyState		:= TRIM(XMLTEXT('ReportBy/Company/Address/State'));
	SELF.InCompanyZip5		:= TRIM(XMLTEXT('ReportBy/Company/Address/Zip5'));
	SELF.InCompanyStateCityZip := TRIM(XMLTEXT('ReportBy/Company/Address/StateCityZip'));
	SELF.InCompanyPhone		:= TRIM(XMLTEXT('ReportBy/Company/Phone10'));
	SELF.InCompanyFEIN		:= TRIM(XMLTEXT('ReportBy/Company/TIN'));
	SELF.InEmail					:= TRIM(XMLTEXT('ReportBy/Company/Email'));
	SELF.InRep1FirstName	:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/Name/First'));
	SELF.InRep1LastName		:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/Name/Last'));
	SELF.InRep1StreetAddress1 := TRIM(XMLTEXT('ReportBy/AuthorizedRep/Address/SreetAddress1'));
	SELF.InRep1City 			:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/Address/City'));
	SELF.InRep1State 			:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/Address/State'));
	SELF.InRep1Zip5 			:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/Address/Zip5'));
	SELF.InRep1SSN				:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/SSN'));
	SELF.InRep1DOB				:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/DOB'));
	SELF.InRep1DL 				:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/DriverLicenseNumber'));
	SELF.InRep1DLState 		:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/DriverLicenseState'));
	SELF.InRep1Phone 			:= TRIM(XMLTEXT('ReportBy/AuthorizedRep/Phone10'));
	SELF := [];
END;

parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('BusinessCreditReport')), HASH64(TransactionID));

op4 := OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));
op5 := OUTPUT(COUNT(parsedInput), NAMED('parsedInput'));

Parsed_BusinessCreditReport_Layout parseOutput() := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	SELF.BestDotID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/DotID'));
	SELF.BestEmpID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/EmpID'));
	SELF.BestPOWID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/POWID'));
	SELF.BestProxID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/ProxID'));
	SELF.BestSeleID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/SeleID'));
	SELF.BestOrgID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/OrgID'));
	SELF.BestUltID	:= (INTEGER) TRIM(XMLTEXT('Records/Record/BestInformation/BusinessIds/UltID'));
	SELF.BestCompanyName := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyName'));
	SELF.BestCompanyStreetNumber := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/StreetNumber'));
	SELF.BestCompanyStreetName := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/StreetName'));
	SELF.BestCompanyUnitNumber := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/UnitNumber'));;
	SELF.BestCompanyStreetAddress1 := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/StreetAddress1'));
	SELF.BestCompanyStreetAddress2 := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/StreetAddress2'));
	SELF.BestCompanyCity := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/City'));
	SELF.BestCompanyState := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/State'));
	SELF.BestCompanyZip5 := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/Zip5'));
	SELF.BestCompanyStateCityZip := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyAddress/StateCityZip'));
	SELF.BestCompanyPhone := TRIM(XMLTEXT('Records/Record/BestInformation/CompanyPhone'));
	SELF := [];
END;

parsedOutput := PARSE(Logs, outputxml, parseOutput(), XML('BusinessCreditReport'));

op6 := OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

op7 := OUTPUT(COUNT(parsedOutput), NAMED('parsedOutput'));


Parsed_BusinessCreditReport_Layout combineParsedRecords(Parsed_BusinessCreditReport_Layout le, Parsed_BusinessCreditReport_Layout ri) := TRANSFORM

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

op8 := OUTPUT(COUNT(parsedRecordsTemp), NAMED('parsedRecordsTemp'));

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.login_id := RIGHT.login_id; SELF := LEFT), LOCAL);

op9 := OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('parsedRecords'));

op10 := OUTPUT(COUNT(parsedRecords), NAMED('cnt_parsedRecords'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(login_id, TransactionDate, TransactionID)), login_id, TransactionDate, TransactionID, LOCAL);
op11 := OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('finalRecords'));

table(finalRecords,{TransactionDate,cnt := count(group)},TransactionDate,merge);

op := OUTPUT(finalRecords,, outputFile, THOR, OVERWRITE, COMPRESSED, EXPIRE(90));


RETURN op;

END;
/* end businessCreditReport */

EXPORT businessInstantID2() := FUNCTION

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;

AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 100;

outputFile := '~thor::bipheader::qa::SAOT::Business_InstantID2_' + BeginDate + '-' + EndDate;

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSINSTANTID2'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSINSTANTID2'] AND datetime[1..8] BETWEEN (string)BeginDate AND (string)EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

op1 := OUTPUT(CHOOSEN(LogsRaw, eyeball), NAMED('LogsRaw'));

table(LogsRaw,{datetime[1..8],cnt := count(group)},datetime[1..8],merge);

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate},
																		SELF.inputxml := StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(LEFT.inputxml, '<BusinessInstantID2Request>', '<BusinessInstantID2>'),'</BusinessInstantID2Request>', '</BusinessInstantID2>'), '<BusinessInstantID2>', '<BusinessInstantID2><TransactionId>' + trim(LEFT.Transaction_Id,left,right) + '</TransactionId>');
																			SELF.outputxml := '<BusinessInstantID2>' + LEFT.outputxml + '</BusinessInstantID2>';
																		SELF.TransactionID :=trim(LEFT.Transaction_ID,left,right);
																		SELF.AccountID := LEFT.customer_id;
																		//self.login_id := 	LEFT.login_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));

// Logs := Logs_pre(trim(TransactionID,left,right) in ['172072228R18193','158852973R137039','158852973R294799','158852983R133882','158856933R164949','158852313R176297','158852693R362573','158856993R221379','158856993R242064','158857023R94515']);														

op2 := OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));
op3 := OUTPUT(COUNT(Logs), NAMED('cnt_Logs'));

Parsed_BusinessIID2_Layout := RECORD
STRING TransactionID := '';
STRING10	AccountID			:= '';
String20 login_id;
STRING8		TransactionDate := '';
STRING EndUserCompanyName := '';
STRING ReferenceCode := '';
//options
STRING BIID20ProductType := '';
STRING GlobalWatchlistThreshold     := '';
STRING WatchListsRequested := '';
STRING DOBRadius := '';
STRING ExactAddrMatch := '';
STRING ExactDOBMatch := '';
STRING ExactDriverLicenseMatch := '';
STRING ExactFirstNameMatch := '';
STRING ExactFirstNameMatchAllowNicknames := '';
STRING ExactLastNameMatch := '';
STRING ExactPhoneMatch := '';
STRING ExactSSNMatch := '';
STRING ExcludeWatchLists := '';
STRING IncludeAdditionalWatchlists := '';
STRING IncludeCLOverride := '';
STRING IncludeDLVerification := '';
STRING IncludeDOBInCVI := '';
STRING IncludeDPBC := '';
STRING IncludeDriverLicenseInCVI := '';
STRING IncludeMIOverride := '';
STRING IncludeMSOverride := '';
STRING IncludeOFAC := '';
STRING LastSeenThreshold := '';
STRING NameInputOrder := '';
STRING PoBoxCompliance := '';
STRING UseDOBFilter := '';
//options
STRING InCompanyName := '';
STRING InAlternateCompanyName := '';
STRING InCompanyStreetAddress := '';
STRING InCompanyCity := '';
STRING InCompanyState := '';
STRING InCompanyZip5 := '';
STRING InCompanyPhone := '';
STRING InCompanyFEIN := '';
STRING InRep1FirstName := '';
STRING InRep1LastName := '';
STRING InRep1StreetAddress := '';
STRING InRep1City := '';
STRING InRep1State := '';
STRING InRep1Zip5 := '';
STRING InRep1SSN := '';
STRING InRep1DOB := '';
STRING InRep1Phone := '';
STRING InRep1DL := '';
STRING InRep1DLState := '';
STRING InRep2FirstName := '';
STRING InRep2LastName := '';
STRING InRep2StreetAddress := '';
STRING InRep2City := '';
STRING InRep2State := '';
STRING InRep2Zip5 := '';
STRING InRep2SSN := '';
STRING InRep2DOB := '';
STRING InRep2Phone := '';
STRING InRep2DL := '';
STRING InRep2DLState := '';
STRING InRep3FirstName := '';
STRING InRep3LastName := '';
STRING InRep3StreetAddress := '';
STRING InRep3City := '';
STRING InRep3State := '';
STRING InRep3Zip5 := '';
STRING InRep3SSN := '';
STRING InRep3DOB := '';
STRING InRep3Phone := '';
STRING InRep3DL := '';
STRING InRep3DLState := '';
STRING InRep4FirstName := '';
STRING InRep4LastName := '';
STRING InRep4StreetAddress := '';
STRING InRep4City := '';
STRING InRep4State := '';
STRING InRep4Zip5 := '';
STRING InRep4SSN := '';
STRING InRep4DOB := '';
STRING InRep4Phone := '';
STRING InRep4DL := '';
STRING InRep4DLState := '';
STRING InRep5FirstName := '';
STRING InRep5LastName := '';
STRING InRep5StreetAddress := '';
STRING InRep5City := '';
STRING InRep5State := '';
STRING InRep5Zip5 := '';
STRING InRep5SSN := '';
STRING InRep5DOB := '';
STRING InRep5Phone := '';
STRING InRep5DL := '';
STRING InRep5DLState := '';

// Output Fields
// STRING TransactionID := '';
STRING NumberValidAuthRepsInput := '';
STRING CompanySeleID := '';
STRING VerCompanyName := '';
STRING VerCompanyAddr := '';
STRING VerCompanyCity := '';
STRING VerCompanyState := '';
STRING VerCompanyZip := '';
STRING VerCompanyPhone := '';
STRING VerCompanyFEIN := '';
STRING CompanyBusinessVerificationIndex := '';
STRING CompanyBusinessVerificationDesc := '';
STRING CompanyPRI_Seq1 := '';
STRING CompanyPRI_Code1 := '';
STRING CompanyPRI_Desc1 := '';
STRING CompanyPRI_Seq2 := '';
STRING CompanyPRI_Code2 := '';
STRING CompanyPRI_Desc2 := '';
STRING CompanyPRI_Seq3 := '';
STRING CompanyPRI_Code3 := '';
STRING CompanyPRI_Desc3 := '';
STRING CompanyPRI_Seq4 := '';
STRING CompanyPRI_Code4 := '';
STRING CompanyPRI_Desc4 := '';
STRING CompanyPRI_Seq5 := '';
STRING CompanyPRI_Code5 := '';
STRING CompanyPRI_Desc5 := '';
STRING CompanyPRI_Seq6 := '';
STRING CompanyPRI_Code6 := '';
STRING CompanyPRI_Desc6 := '';
STRING CompanyPRI_Seq7 := '';
STRING CompanyPRI_Code7 := '';
STRING CompanyPRI_Desc7 := '';
STRING CompanyPRI_Seq8 := '';
STRING CompanyPRI_Code8 := '';
STRING CompanyPRI_Desc8 := '';
STRING CompanyResidentialDesc := '';
STRING CompanyVeriSummary_Type1 := '';
STRING CompanyVeriSummary_Index1 := '';
STRING CompanyVeriSummary_Desc1 := '';
STRING CompanyVeriSummary_Type2 := '';
STRING CompanyVeriSummary_Index2 := '';
STRING CompanyVeriSummary_Desc2 := '';
STRING CompanyVeriSummary_Type3 := '';
STRING CompanyVeriSummary_Index3 := '';
STRING CompanyVeriSummary_Desc3 := '';
STRING CompanyVeriSummary_Type4 := '';
STRING CompanyVeriSummary_Index4 := '';
STRING CompanyVeriSummary_Desc4 := '';
STRING CompanyVeriSummary_Type5 := '';
STRING CompanyVeriSummary_Index5 := '';
STRING CompanyVeriSummary_Desc5 := '';
STRING BusToExexIndex_Rep1 := '';
STRING BusToExexIndex_Index1 := '';
STRING BusToExexIndex_Desc1 := '';
STRING BusToExexIndex_Rep2 := '';
STRING BusToExexIndex_Index2 := '';
STRING BusToExexIndex_Desc2 := '';
STRING BusToExexIndex_Rep3 := '';
STRING BusToExexIndex_Index3 := '';
STRING BusToExexIndex_Desc3 := '';
STRING BusToExexIndex_Rep4 := '';
STRING BusToExexIndex_Index4 := '';
STRING BusToExexIndex_Desc4 := '';
STRING BusToExexIndex_Rep5 := '';
STRING BusToExexIndex_Index5 := '';
STRING BusToExexIndex_Desc5 := '';
STRING Rep1UniqueId := '';
STRING Rep1CVI := '';
STRING Rep1NAP := '';
STRING Rep1NAS := '';
STRING Rep1RI_seq1 := '';
STRING Rep1RI_Code1 := '';
STRING Rep1RI_Desc1 := '';
STRING Rep1RI_seq2 := '';
STRING Rep1RI_Code2 := '';
STRING Rep1RI_Desc2 := '';
STRING Rep1RI_seq3 := '';
STRING Rep1RI_Code3 := '';
STRING Rep1RI_Desc3 := '';
STRING Rep1RI_seq4 := '';
STRING Rep1RI_Code4 := '';
STRING Rep1RI_Desc4 := '';
STRING Rep1RI_seq5 := '';
STRING Rep1RI_Code5 := '';
STRING Rep1RI_Desc5 := '';
STRING Rep1RI_seq6 := '';
STRING Rep1RI_Code6 := '';
STRING Rep1RI_Desc6 := '';
STRING Rep1RI_seq7 := '';
STRING Rep1RI_Code7 := '';
STRING Rep1RI_Desc7 := '';
STRING Rep1RI_seq8 := '';
STRING Rep1RI_Code8 := '';
STRING Rep1RI_Desc8 := '';
STRING Rep1RI_seq9 := '';
STRING Rep1RI_Code9 := '';
STRING Rep1RI_Desc9 := '';
STRING Rep1RI_seq10 := '';
STRING Rep1RI_Code10 := '';
STRING Rep1RI_Desc10 := '';

STRING Rep2UniqueId := '';
STRING Rep2CVI := '';
STRING Rep2NAP := '';
STRING Rep2NAS := '';
STRING Rep2RI_seq1 := '';
STRING Rep2RI_Code1 := '';
STRING Rep2RI_Desc1 := '';
STRING Rep2RI_seq2 := '';
STRING Rep2RI_Code2 := '';
STRING Rep2RI_Desc2 := '';
STRING Rep2RI_seq3 := '';
STRING Rep2RI_Code3 := '';
STRING Rep2RI_Desc3 := '';
STRING Rep2RI_seq4 := '';
STRING Rep2RI_Code4 := '';
STRING Rep2RI_Desc4 := '';
STRING Rep2RI_seq5 := '';
STRING Rep2RI_Code5 := '';
STRING Rep2RI_Desc5 := '';
STRING Rep2RI_seq6 := '';
STRING Rep2RI_Code6 := '';
STRING Rep2RI_Desc6 := '';
STRING Rep2RI_seq7 := '';
STRING Rep2RI_Code7 := '';
STRING Rep2RI_Desc7 := '';
STRING Rep2RI_seq8 := '';
STRING Rep2RI_Code8 := '';
STRING Rep2RI_Desc8 := '';
STRING Rep2RI_seq9 := '';
STRING Rep2RI_Code9 := '';
STRING Rep2RI_Desc9 := '';
STRING Rep2RI_seq10 := '';
STRING Rep2RI_Code10 := '';
STRING Rep2RI_Desc10 := '';
STRING Rep3UniqueId := '';
STRING Rep3CVI := '';
STRING Rep3NAP := '';
STRING Rep3NAS := '';
STRING Rep3RI_seq1 := '';
STRING Rep3RI_Code1 := '';
STRING Rep3RI_Desc1 := '';
STRING Rep3RI_seq2 := '';
STRING Rep3RI_Code2 := '';
STRING Rep3RI_Desc2 := '';
STRING Rep3RI_seq3 := '';
STRING Rep3RI_Code3 := '';
STRING Rep3RI_Desc3 := '';
STRING Rep3RI_seq4 := '';
STRING Rep3RI_Code4 := '';
STRING Rep3RI_Desc4 := '';
STRING Rep3RI_seq5 := '';
STRING Rep3RI_Code5 := '';
STRING Rep3RI_Desc5 := '';
STRING Rep3RI_seq6 := '';
STRING Rep3RI_Code6 := '';
STRING Rep3RI_Desc6 := '';
STRING Rep3RI_seq7 := '';
STRING Rep3RI_Code7 := '';
STRING Rep3RI_Desc7 := '';
STRING Rep3RI_seq8 := '';
STRING Rep3RI_Code8 := '';
STRING Rep3RI_Desc8 := '';
STRING Rep3RI_seq9 := '';
STRING Rep3RI_Code9 := '';
STRING Rep3RI_Desc9 := '';
STRING Rep3RI_seq10 := '';
STRING Rep3RI_Code10 := '';
STRING Rep3RI_Desc10 := '';
STRING Rep4UniqueId := '';
STRING Rep4CVI := '';
STRING Rep4NAP := '';
STRING Rep4NAS := '';
STRING Rep4RI_seq1 := '';
STRING Rep4RI_Code1 := '';
STRING Rep4RI_Desc1 := '';
STRING Rep4RI_seq2 := '';
STRING Rep4RI_Code2 := '';
STRING Rep4RI_Desc2 := '';
STRING Rep4RI_seq3 := '';
STRING Rep4RI_Code3 := '';
STRING Rep4RI_Desc3 := '';
STRING Rep4RI_seq4 := '';
STRING Rep4RI_Code4 := '';
STRING Rep4RI_Desc4 := '';
STRING Rep4RI_seq5 := '';
STRING Rep4RI_Code5 := '';
STRING Rep4RI_Desc5 := '';
STRING Rep4RI_seq6 := '';
STRING Rep4RI_Code6 := '';
STRING Rep4RI_Desc6 := '';
STRING Rep4RI_seq7 := '';
STRING Rep4RI_Code7 := '';
STRING Rep4RI_Desc7 := '';
STRING Rep4RI_seq8 := '';
STRING Rep4RI_Code8 := '';
STRING Rep4RI_Desc8 := '';
STRING Rep4RI_seq9 := '';
STRING Rep4RI_Code9 := '';
STRING Rep4RI_Desc9 := '';
STRING Rep4RI_seq10 := '';
STRING Rep4RI_Code10 := '';
STRING Rep4RI_Desc10 := '';
STRING Rep5UniqueId := '';
STRING Rep5CVI := '';
STRING Rep5NAP := '';
STRING Rep5NAS := '';
STRING Rep5RI_seq1 := '';
STRING Rep5RI_Code1 := '';
STRING Rep5RI_Desc1 := '';
STRING Rep5RI_seq2 := '';
STRING Rep5RI_Code2 := '';
STRING Rep5RI_Desc2 := '';
STRING Rep5RI_seq3 := '';
STRING Rep5RI_Code3 := '';
STRING Rep5RI_Desc3 := '';
STRING Rep5RI_seq4 := '';
STRING Rep5RI_Code4 := '';
STRING Rep5RI_Desc4 := '';
STRING Rep5RI_seq5 := '';
STRING Rep5RI_Code5 := '';
STRING Rep5RI_Desc5 := '';
STRING Rep5RI_seq6 := '';
STRING Rep5RI_Code6 := '';
STRING Rep5RI_Desc6 := '';
STRING Rep5RI_seq7 := '';
STRING Rep5RI_Code7 := '';
STRING Rep5RI_Desc7 := '';
STRING Rep5RI_seq8 := '';
STRING Rep5RI_Code8 := '';
STRING Rep5RI_Desc8 := '';
STRING Rep5RI_seq9 := '';
STRING Rep5RI_Code9 := '';
STRING Rep5RI_Desc9 := '';
STRING Rep5RI_seq10 := '';
STRING Rep5RI_Code10 := '';
STRING Rep5RI_Desc10 := '';
END;

Parsed_BusinessIID2_Layout parseInput () := TRANSFORM

  _InRep1DOB_year  := TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DOB/Year'));
  _InRep1DOB_month := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DOB/Month'));
  _InRep1DOB_day   := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DOB/Day'));
  _InRep1DOB := _InRep1DOB_year + _InRep1DOB_month[(LENGTH(_InRep1DOB_month)-1)..(LENGTH(_InRep1DOB_month))] + _InRep1DOB_day[(LENGTH(_InRep1DOB_day)-1)..(LENGTH(_InRep1DOB_day))];
  
  _InRep2DOB_year  := TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DOB/Year'));
  _InRep2DOB_month := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DOB/Month'));
  _InRep2DOB_day   := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DOB/Day'));
  _InRep2DOB := _InRep2DOB_year + _InRep2DOB_month[(LENGTH(_InRep2DOB_month)-1)..(LENGTH(_InRep2DOB_month))] + _InRep2DOB_day[(LENGTH(_InRep2DOB_day)-1)..(LENGTH(_InRep2DOB_day))];

  _InRep3DOB_year  := TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DOB/Year'));
  _InRep3DOB_month := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DOB/Month'));
  _InRep3DOB_day   := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DOB/Day'));
  _InRep3DOB := _InRep3DOB_year + _InRep3DOB_month[(LENGTH(_InRep3DOB_month)-1)..(LENGTH(_InRep3DOB_month))] + _InRep3DOB_day[(LENGTH(_InRep3DOB_day)-1)..(LENGTH(_InRep3DOB_day))];
  
  _InRep4DOB_year  := TRIM(XMLTEXT('SearchBy/AuthorizedRep4/DOB/Year'));
  _InRep4DOB_month := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep4/DOB/Month'));
  _InRep4DOB_day   := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep4/DOB/Day'));
  _InRep4DOB := _InRep4DOB_year + _InRep4DOB_month[(LENGTH(_InRep4DOB_month)-1)..(LENGTH(_InRep4DOB_month))] + _InRep4DOB_day[(LENGTH(_InRep4DOB_day)-1)..(LENGTH(_InRep4DOB_day))];
  
  _InRep5DOB_year  := TRIM(XMLTEXT('SearchBy/AuthorizedRep5/DOB/Year'));
  _InRep5DOB_month := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep5/DOB/Month'));
  _InRep5DOB_day   := '00' + TRIM(XMLTEXT('SearchBy/AuthorizedRep5/DOB/Day'));
  _InRep5DOB := _InRep5DOB_year + _InRep5DOB_month[(LENGTH(_InRep5DOB_month)-1)..(LENGTH(_InRep5DOB_month))] + _InRep5DOB_day[(LENGTH(_InRep5DOB_day)-1)..(LENGTH(_InRep5DOB_day))];
  
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.ReferenceCode				:= TRIM(XMLTEXT('User/ReferenceCode'));
	SELF.BIID20ProductType		:= TRIM(XMLTEXT('Options/BIID20ProductType'));
	SELF.GlobalWatchlistThreshold		:= TRIM(XMLTEXT('Options/GlobalWatchlistThreshold'));
	SELF.WatchListsRequested		:= TRIM(XMLTEXT('Options/WatchListsRequested'));
	SELF.DOBRadius		:= TRIM(XMLTEXT('Options/DOBRadius'));
	SELF.ExactAddrMatch		:= TRIM(XMLTEXT('Options/ExactAddrMatch'));
	SELF.ExactDOBMatch		:= TRIM(XMLTEXT('Options/ExactDOBMatch'));
	SELF.ExactDriverLicenseMatch		:= TRIM(XMLTEXT('Options/ExactDriverLicenseMatch'));
	SELF.ExactFirstNameMatch		:= TRIM(XMLTEXT('Options/ExactFirstNameMatch'));
	SELF.ExactFirstNameMatchAllowNicknames		:= TRIM(XMLTEXT('Options/ExactFirstNameMatchAllowNicknames'));
	SELF.ExactLastNameMatch		:= TRIM(XMLTEXT('Options/ExactLastNameMatch'));
	SELF.ExactPhoneMatch		:= TRIM(XMLTEXT('Options/ExactPhoneMatch'));
	SELF.ExactSSNMatch		:= TRIM(XMLTEXT('Options/ExactSSNMatch'));
	SELF.ExcludeWatchLists		:= TRIM(XMLTEXT('Options/ExcludeWatchLists'));
	SELF.IncludeAdditionalWatchlists		:= TRIM(XMLTEXT('Options/IncludeAdditionalWatchlists'));
	SELF.IncludeCLOverride		:= TRIM(XMLTEXT('Options/IncludeCLOverride'));
	SELF.IncludeDLVerification		:= TRIM(XMLTEXT('Options/IncludeDLVerification'));
	SELF.IncludeDOBInCVI		:= TRIM(XMLTEXT('Options/IncludeDOBInCVI'));
	SELF.IncludeDPBC		:= TRIM(XMLTEXT('Options/IncludeDPBC'));
	SELF.IncludeDriverLicenseInCVI		:= TRIM(XMLTEXT('Options/IncludeDriverLicenseInCVI'));
	SELF.IncludeMIOverride		:= TRIM(XMLTEXT('Options/IncludeMIOverride'));
	SELF.IncludeMSOverride		:= TRIM(XMLTEXT('Options/IncludeMSOverride'));
	SELF.IncludeOFAC		:= TRIM(XMLTEXT('Options/IncludeOFAC'));
	SELF.LastSeenThreshold		:= TRIM(XMLTEXT('Options/LastSeenThreshold'));
	SELF.NameInputOrder		:= TRIM(XMLTEXT('Options/NameInputOrder'));
	SELF.PoBoxCompliance		:= TRIM(XMLTEXT('Options/PoBoxCompliance'));
	SELF.UseDOBFilter		:= TRIM(XMLTEXT('Options/UseDOBFilter'));
	SELF.InCompanyName					:= TRIM(XMLTEXT('SearchBy/Company/CompanyName'));
	SELF.InAlternateCompanyName	:= TRIM(XMLTEXT('SearchBy/Company/AlternateCompanyName'));
	SELF.InCompanyStreetAddress	:= TRIM(XMLTEXT('SearchBy/Company/Address/StreetAddress1'));
	SELF.InCompanyCity		:= TRIM(XMLTEXT('SearchBy/Company/Address/City'));
	SELF.InCompanyState		:= TRIM(XMLTEXT('SearchBy/Company/Address/State'));
	SELF.InCompanyZip5		:= TRIM(XMLTEXT('SearchBy/Company/Address/Zip5'));
	SELF.InCompanyPhone		:= TRIM(XMLTEXT('SearchBy/Company/Phone'));
	SELF.InCompanyFEIN		:= TRIM(XMLTEXT('SearchBy/Company/FEIN'));
	SELF.InRep1FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/First'));
	SELF.InRep1LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Name/Last'));
	SELF.InRep1StreetAddress	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/StreetAddress1'));
	SELF.InRep1City				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/City'));
	SELF.InRep1State			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/State'));
  SELF.InRep1Zip5       := TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Address/Zip5'));
	SELF.InRep1SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/SSN'));
	SELF.InRep1DOB				:= IF( (INTEGER)_InRep1DOB = 0, '', _InRep1DOB );
	SELF.InRep1Phone			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/Phone'));
	SELF.InRep1DL					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseNumber'));
	SELF.InRep1DLState		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep1/DriverLicenseState'));
	
	SELF.InRep2FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Name/First'));
	SELF.InRep2LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Name/Last'));
	SELF.InRep2StreetAddress	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Address/StreetAddress1'));
	SELF.InRep2City				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Address/City'));
	SELF.InRep2State			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Address/State'));
  SELF.InRep2Zip5       := TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Address/Zip5'));
	SELF.InRep2SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/SSN'));
	SELF.InRep2DOB				:= IF( (INTEGER)_InRep2DOB = 0, '', _InRep2DOB );
	SELF.InRep2Phone			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/Phone'));
	SELF.InRep2DL					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DriverLicenseNumber'));
	SELF.InRep2DLState		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep2/DriverLicenseState'));
	
	SELF.InRep3FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Name/First'));
	SELF.InRep3LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Name/Last'));
	SELF.InRep3StreetAddress	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Address/StreetAddress1'));
	SELF.InRep3City				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Address/City'));
	SELF.InRep3State			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Address/State'));
  SELF.InRep3Zip5       := TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Address/Zip5'));
	SELF.InRep3SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/SSN'));
	SELF.InRep3DOB				:= IF( (INTEGER)_InRep3DOB = 0, '', _InRep3DOB );
	SELF.InRep3Phone			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/Phone'));
	SELF.InRep3DL					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DriverLicenseNumber'));
	SELF.InRep3DLState		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep3/DriverLicenseState'));
	
	SELF.InRep4FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Name/First'));
	SELF.InRep4LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Name/Last'));
	SELF.InRep4StreetAddress	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Address/StreetAddress1'));
	SELF.InRep4City				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Address/City'));
	SELF.InRep4State			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Address/State'));
  SELF.InRep4Zip5       := TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Address/Zip5'));
	SELF.InRep4SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/SSN'));
	SELF.InRep4DOB				:= IF( (INTEGER)_InRep4DOB = 0, '', _InRep4DOB );
	SELF.InRep4Phone			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/Phone'));
	SELF.InRep4DL					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/DriverLicenseNumber'));
	SELF.InRep4DLState		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep4/DriverLicenseState'));
	
	SELF.InRep5FirstName	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Name/First'));
	SELF.InRep5LastName		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Name/Last'));
	SELF.InRep5StreetAddress	:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Address/StreetAddress1'));
	SELF.InRep5City				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Address/City'));
	SELF.InRep5State			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Address/State'));
  SELF.InRep5Zip5       := TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Address/Zip5'));
	SELF.InRep5SSN				:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/SSN'));
	SELF.InRep5DOB				:= IF( (INTEGER)_InRep5DOB = 0, '', _InRep5DOB );
	SELF.InRep5Phone			:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/Phone'));
	SELF.InRep5DL					:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/DriverLicenseNumber'));
	SELF.InRep5DLState		:= TRIM(XMLTEXT('SearchBy/AuthorizedRep5/DriverLicenseState'));
	SELF := [];
END;

parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('BusinessInstantID2')), HASH64(TransactionID));

op4 := OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));
op5 := OUTPUT(COUNT(parsedInput), NAMED('parsedInput'));

Parsed_BusinessIID2_Layout parseOutput() := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
												 
	SELF.NumberValidAuthRepsInput := TRIM(XMLTEXT('Result/NumberValidAuthRepsInput'));
	SELF.CompanySeleID 						:= TRIM(XMLTEXT('Result/CompanyResults/BusinessIds/SeleID'));
  SELF.VerCompanyName  					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/CompanyName'))   = '1', 'TRUE', 'FALSE');
  SELF.VerCompanyAddr  					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/StreetAddress')) = '1', 'TRUE', 'FALSE');
  SELF.VerCompanyCity  					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/City'))          = '1', 'TRUE', 'FALSE');
  SELF.VerCompanyState 					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/State'))         = '1', 'TRUE', 'FALSE');
  SELF.VerCompanyZip   					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/Zip'))           = '1', 'TRUE', 'FALSE');
  SELF.VerCompanyPhone 					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/Phone'))         = '1', 'TRUE', 'FALSE');
  SELF.VerCompanyFEIN  					:= IF(TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/FEIN'))          = '1', 'TRUE', 'FALSE');
	SELF.CompanyBusinessVerificationIndex := TRIM(XMLTEXT('Result/CompanyResults/BusinessVerification/Index'));
	SELF.CompanyBusinessVerificationDesc := TRIM(XMLTEXT('Result/CompanyResults/BusinessVerification/Description'));
	// RI1_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[1]/Sequence'));
	// RI1_Seq_flag					:= IF((RI1_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq1 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[1]/Sequence'));
	SELF.CompanyPRI_Code1:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.CompanyPRI_Desc1:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[1]/Description'));

	// RI2_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[2]/Sequence'));
	// RI2_Seq_flag					:= IF((RI2_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq2 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[2]/Sequence'));	
	SELF.CompanyPRI_Code2:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.CompanyPRI_Desc2:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[2]/Description'));
	
	// RI3_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[3]/Sequence'));
	// RI3_Seq_flag					:= IF((RI3_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq3 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[3]/Sequence'));	
	SELF.CompanyPRI_Code3:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.CompanyPRI_Desc3:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[3]/Description'));
	
	// RI4_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[4]/Sequence'));
	// RI4_Seq_flag					:= IF((RI4_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq4 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[4]/Sequence'));		
	SELF.CompanyPRI_Code4:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.CompanyPRI_Desc4:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[4]/Description'));
	
	// RI5_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[5]/Sequence'));
	// RI5_Seq_flag					:= IF((RI5_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq5 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[5]/Sequence'));		
	SELF.CompanyPRI_Code5:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.CompanyPRI_Desc5:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[5]/Description'));
	
	// RI6_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[6]/Sequence'));
	// RI6_Seq_flag					:= IF((RI6_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq6 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[6]/Sequence'));		
	SELF.CompanyPRI_Code6:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.CompanyPRI_Desc6:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[6]/Description'));
	
	// RI7_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[7]/Sequence'));
	// RI7_Seq_flag					:= IF((RI7_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq7 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[7]/Sequence'));		
	SELF.CompanyPRI_Code7:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[7]/RiskCode'));
	SELF.CompanyPRI_Desc7:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[7]/Description'));
	
	// RI8_Seq           		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[8]/Sequence'));
	// RI8_Seq_flag					:= IF((RI8_Seq) = '1', TRUE, FALSE);
	SELF.CompanyPRI_Seq8 := TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[8]/Sequence'));		
	SELF.CompanyPRI_Code8:=  TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[8]/RiskCode'));
	SELF.CompanyPRI_Desc8:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[8]/Description'));
	
	SELF.CompanyResidentialDesc := TRIM(XMLTEXT('Result/CompanyResults/ResidentialBusinesses/ResidentialBusiness/Description'));
	
	SELF.CompanyVeriSummary_Type1:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[1]/Type'));
	SELF.CompanyVeriSummary_Index1:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[1]/Index')),;
	SELF.CompanyVeriSummary_Desc1:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[1]/Description'));
	
	SELF.CompanyVeriSummary_Type2:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[2]/Type'));
	SELF.CompanyVeriSummary_Index2:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[2]/Index')),;
	SELF.CompanyVeriSummary_Desc2:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[2]/Description'));
	
	SELF.CompanyVeriSummary_Type3:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[3]/Type'));
	SELF.CompanyVeriSummary_Index3:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[3]/Index')),;
	SELF.CompanyVeriSummary_Desc3:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[3]/Description'));
	
	SELF.CompanyVeriSummary_Type4:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[4]/Type'));
	SELF.CompanyVeriSummary_Index4:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[4]/Index')),;
	SELF.CompanyVeriSummary_Desc4:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[4]/Description'));
	
	SELF.CompanyVeriSummary_Type5:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[5]/Type'));
	SELF.CompanyVeriSummary_Index5:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[5]/Index')),;
	SELF.CompanyVeriSummary_Desc5:= TRIM(XMLTEXT('Result/CompanyResults/VerificationSummaries/VerificationSummary[5]/Description'));
	
	SELF.BusToExexIndex_Rep1:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[1]/InputRepNumber'));
	SELF.BusToExexIndex_Index1:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[1]/Index')),;
	SELF.BusToExexIndex_Desc1:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[1]/Description'));
	
	SELF.BusToExexIndex_Rep2:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[2]/InputRepNumber'));
	SELF.BusToExexIndex_Index2:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[2]/Index')),;
	SELF.BusToExexIndex_Desc2:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[2]/Description'));
	
	SELF.BusToExexIndex_Rep3:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[3]/InputRepNumber'));
	SELF.BusToExexIndex_Index3:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[3]/Index')),;
	SELF.BusToExexIndex_Desc3:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[3]/Description'));
	
	SELF.BusToExexIndex_Rep4:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[4]/InputRepNumber'));
	SELF.BusToExexIndex_Index4:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[4]/Index')),;
	SELF.BusToExexIndex_Desc4:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[4]/Description'));
	
	SELF.BusToExexIndex_Rep5:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[5]/InputRepNumber'));
	SELF.BusToExexIndex_Index5:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[5]/Index')),;
	SELF.BusToExexIndex_Desc5:= TRIM(XMLTEXT('Result/CompanyResults/BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex[5]/Description'));
	//AuthorizedRepresentativeResult1
	SELF.Rep1UniqueId		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/UniqueId'));
	SELF.Rep1CVI		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/ComprehensiveVerificationIndex'));
	SELF.Rep1NAP		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/NameAddressPhoneSummary'));
	SELF.Rep1NAS		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/NameAddressSSNSummary'));
	
	SELF.Rep1RI_seq1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[1]/Sequence'));
	SELF.Rep1RI_Code1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.Rep1RI_Desc1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[1]/Description'));
		
	SELF.Rep1RI_seq2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[2]/Sequence'));
	SELF.Rep1RI_Code2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.Rep1RI_Desc2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[2]/Description'));
		
	SELF.Rep1RI_seq3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[3]/Sequence'));
	SELF.Rep1RI_Code3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.Rep1RI_Desc3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[3]/Description'));
		
	SELF.Rep1RI_seq4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[4]/Sequence'));
	SELF.Rep1RI_Code4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.Rep1RI_Desc4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[4]/Description'));
		
	SELF.Rep1RI_seq5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[5]/Sequence'));
	SELF.Rep1RI_Code5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.Rep1RI_Desc5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[5]/Description'));
		
	SELF.Rep1RI_seq6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[6]/Sequence'));
	SELF.Rep1RI_Code6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.Rep1RI_Desc6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[6]/Description'));
		
	SELF.Rep1RI_seq7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[7]/Sequence'));
	SELF.Rep1RI_Code7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[7]/RiskCode'));
	SELF.Rep1RI_Desc7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[7]/Description'));
		
	SELF.Rep1RI_seq8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[8]/Sequence'));
	SELF.Rep1RI_Code8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[8]/RiskCode'));
	SELF.Rep1RI_Desc8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[8]/Description'));
		
	SELF.Rep1RI_seq9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[9]/Sequence'));
	SELF.Rep1RI_Code9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[9]/RiskCode'));
	SELF.Rep1RI_Desc9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[9]/Description'));
		
	SELF.Rep1RI_seq10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[10]/Sequence'));
	SELF.Rep1RI_Code10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[10]/RiskCode'));
	SELF.Rep1RI_Desc10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[1]/RiskIndicators/RiskIndicator[10]/Description'));
	
	//AuthorizedRepresentativeResult2
	SELF.Rep2UniqueId		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/UniqueId'));
	SELF.Rep2CVI		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/ComprehensiveVerificationIndex'));
	SELF.Rep2NAP		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/NameAddressPhoneSummary'));
	SELF.Rep2NAS		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/NameAddressSSNSummary'));
	
	SELF.Rep2RI_seq1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[1]/Sequence'));
	SELF.Rep2RI_Code1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.Rep2RI_Desc1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[1]/Description'));
		
	SELF.Rep2RI_seq2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[2]/Sequence'));
	SELF.Rep2RI_Code2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.Rep2RI_Desc2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[2]/Description'));
		
	SELF.Rep2RI_seq3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[3]/Sequence'));
	SELF.Rep2RI_Code3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.Rep2RI_Desc3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[3]/Description'));
		
	SELF.Rep2RI_seq4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[4]/Sequence'));
	SELF.Rep2RI_Code4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.Rep2RI_Desc4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[4]/Description'));
		
	SELF.Rep2RI_seq5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[5]/Sequence'));
	SELF.Rep2RI_Code5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.Rep2RI_Desc5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[5]/Description'));
		
	SELF.Rep2RI_seq6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[6]/Sequence'));
	SELF.Rep2RI_Code6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.Rep2RI_Desc6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[6]/Description'));
		
	SELF.Rep2RI_seq7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[7]/Sequence'));
	SELF.Rep2RI_Code7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[7]/RiskCode'));
	SELF.Rep2RI_Desc7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[7]/Description'));
		
	SELF.Rep2RI_seq8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[8]/Sequence'));
	SELF.Rep2RI_Code8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[8]/RiskCode'));
	SELF.Rep2RI_Desc8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[8]/Description'));
		
	SELF.Rep2RI_seq9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[9]/Sequence'));
	SELF.Rep2RI_Code9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[9]/RiskCode'));
	SELF.Rep2RI_Desc9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[9]/Description'));
		
	SELF.Rep2RI_seq10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[10]/Sequence'));
	SELF.Rep2RI_Code10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[10]/RiskCode'));
	SELF.Rep2RI_Desc10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[2]/RiskIndicators/RiskIndicator[10]/Description'));
	
	//AuthorizedRepresentativeResult3
	SELF.Rep3UniqueId		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/UniqueId'));
	SELF.Rep3CVI		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/ComprehensiveVerificationIndex'));
	SELF.Rep3NAP		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/NameAddressPhoneSummary'));
	SELF.Rep3NAS		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/NameAddressSSNSummary'));
	
	SELF.Rep3RI_seq1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[1]/Sequence'));
	SELF.Rep3RI_Code1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.Rep3RI_Desc1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[1]/Description'));
		
	SELF.Rep3RI_seq2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[2]/Sequence'));
	SELF.Rep3RI_Code2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.Rep3RI_Desc2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[2]/Description'));
		
	SELF.Rep3RI_seq3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[3]/Sequence'));
	SELF.Rep3RI_Code3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.Rep3RI_Desc3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[3]/Description'));
		
	SELF.Rep3RI_seq4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[4]/Sequence'));
	SELF.Rep3RI_Code4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.Rep3RI_Desc4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[4]/Description'));
		
	SELF.Rep3RI_seq5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[5]/Sequence'));
	SELF.Rep3RI_Code5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.Rep3RI_Desc5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[5]/Description'));
		
	SELF.Rep3RI_seq6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[6]/Sequence'));
	SELF.Rep3RI_Code6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.Rep3RI_Desc6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[6]/Description'));
		
	SELF.Rep3RI_seq7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[7]/Sequence'));
	SELF.Rep3RI_Code7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[7]/RiskCode'));
	SELF.Rep3RI_Desc7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[7]/Description'));
		
	SELF.Rep3RI_seq8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[8]/Sequence'));
	SELF.Rep3RI_Code8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[8]/RiskCode'));
	SELF.Rep3RI_Desc8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[8]/Description'));
		
	SELF.Rep3RI_seq9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[9]/Sequence'));
	SELF.Rep3RI_Code9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[9]/RiskCode'));
	SELF.Rep3RI_Desc9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[9]/Description'));
		
	SELF.Rep3RI_seq10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[10]/Sequence'));
	SELF.Rep3RI_Code10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[10]/RiskCode'));
	SELF.Rep3RI_Desc10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[3]/RiskIndicators/RiskIndicator[10]/Description'));
	
	//AuthorizedRepresentativeResult4
	SELF.Rep4UniqueId		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/UniqueId'));
	SELF.Rep4CVI		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/ComprehensiveVerificationIndex'));
	SELF.Rep4NAP		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/NameAddressPhoneSummary'));
	SELF.Rep4NAS		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/NameAddressSSNSummary'));
	
	SELF.Rep4RI_seq1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[1]/Sequence'));
	SELF.Rep4RI_Code1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.Rep4RI_Desc1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[1]/Description'));
		
	SELF.Rep4RI_seq2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[2]/Sequence'));
	SELF.Rep4RI_Code2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.Rep4RI_Desc2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[2]/Description'));
		
	SELF.Rep4RI_seq3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[3]/Sequence'));
	SELF.Rep4RI_Code3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.Rep4RI_Desc3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[3]/Description'));
		
	SELF.Rep4RI_seq4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[4]/Sequence'));
	SELF.Rep4RI_Code4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.Rep4RI_Desc4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[4]/Description'));
		
	SELF.Rep4RI_seq5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[5]/Sequence'));
	SELF.Rep4RI_Code5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.Rep4RI_Desc5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[5]/Description'));
		
	SELF.Rep4RI_seq6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[6]/Sequence'));
	SELF.Rep4RI_Code6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.Rep4RI_Desc6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[6]/Description'));
		
	SELF.Rep4RI_seq7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[7]/Sequence'));
	SELF.Rep4RI_Code7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[7]/RiskCode'));
	SELF.Rep4RI_Desc7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[7]/Description'));
		
	SELF.Rep4RI_seq8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[8]/Sequence'));
	SELF.Rep4RI_Code8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[8]/RiskCode'));
	SELF.Rep4RI_Desc8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[8]/Description'));
		
	SELF.Rep4RI_seq9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[9]/Sequence'));
	SELF.Rep4RI_Code9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[9]/RiskCode'));
	SELF.Rep4RI_Desc9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[9]/Description'));
		
	SELF.Rep4RI_seq10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[10]/Sequence'));
	SELF.Rep4RI_Code10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[10]/RiskCode'));
	SELF.Rep4RI_Desc10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[4]/RiskIndicators/RiskIndicator[10]/Description'));
	
	//AuthorizedRepresentativeResult5
	SELF.Rep5UniqueId		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/UniqueId'));
	SELF.Rep5CVI		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/ComprehensiveVerificationIndex'));
	SELF.Rep5NAP		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/NameAddressPhoneSummary'));
	SELF.Rep5NAS		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/NameAddressSSNSummary'));
	
	SELF.Rep5RI_seq1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[1]/Sequence'));
	SELF.Rep5RI_Code1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.Rep5RI_Desc1		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[1]/Description'));
		
	SELF.Rep5RI_seq2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[2]/Sequence'));
	SELF.Rep5RI_Code2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.Rep5RI_Desc2		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[2]/Description'));
		
	SELF.Rep5RI_seq3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[3]/Sequence'));
	SELF.Rep5RI_Code3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.Rep5RI_Desc3		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[3]/Description'));
		
	SELF.Rep5RI_seq4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[4]/Sequence'));
	SELF.Rep5RI_Code4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.Rep5RI_Desc4		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[4]/Description'));
		
	SELF.Rep5RI_seq5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[5]/Sequence'));
	SELF.Rep5RI_Code5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.Rep5RI_Desc5		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[5]/Description'));
		
	SELF.Rep5RI_seq6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[6]/Sequence'));
	SELF.Rep5RI_Code6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[6]/RiskCode'));
	SELF.Rep5RI_Desc6		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[6]/Description'));
		
	SELF.Rep5RI_seq7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[7]/Sequence'));
	SELF.Rep5RI_Code7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[7]/RiskCode'));
	SELF.Rep5RI_Desc7		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[7]/Description'));
		
	SELF.Rep5RI_seq8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[8]/Sequence'));
	SELF.Rep5RI_Code8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[8]/RiskCode'));
	SELF.Rep5RI_Desc8		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[8]/Description'));
		
	SELF.Rep5RI_seq9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[9]/Sequence'));
	SELF.Rep5RI_Code9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[9]/RiskCode'));
	SELF.Rep5RI_Desc9		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[9]/Description'));
		
	SELF.Rep5RI_seq10		:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[10]/Sequence'));
	SELF.Rep5RI_Code10	:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[10]/RiskCode'));
	SELF.Rep5RI_Desc10	:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AuthorizedRepresentativeResult[5]/RiskIndicators/RiskIndicator[10]/Description'));
	SELF := [];
END;

parsedOutput := PARSE(Logs, outputxml, parseOutput(), XML('BusinessInstantID2'));

op6 := OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

op7 := OUTPUT(COUNT(parsedOutput), NAMED('parsedOutput'));


Parsed_BusinessIID2_Layout combineParsedRecords(Parsed_BusinessIID2_Layout le, Parsed_BusinessIID2_Layout ri) := TRANSFORM
SELF.NumberValidAuthRepsInput:=ri.NumberValidAuthRepsInput;
SELF.CompanySeleID:=ri.CompanySeleID;
SELF.VerCompanyName := ri.VerCompanyName;
SELF.VerCompanyAddr := ri.VerCompanyAddr;
SELF.VerCompanyCity := ri.VerCompanyCity;
SELF.VerCompanyState:= ri.VerCompanyState;
SELF.VerCompanyZip  := ri.VerCompanyZip;
SELF.VerCompanyPhone:= ri.VerCompanyPhone;
SELF.VerCompanyFEIN := ri.VerCompanyFEIN;
SELF.CompanyBusinessVerificationIndex:=ri.CompanyBusinessVerificationIndex;
SELF.CompanyBusinessVerificationDesc:=ri.CompanyBusinessVerificationDesc;
SELF.CompanyPRI_Seq1:=ri.CompanyPRI_Seq1;
SELF.CompanyPRI_Code1:=ri.CompanyPRI_Code1;
SELF.CompanyPRI_Desc1:=ri.CompanyPRI_Desc1;
SELF.CompanyPRI_Seq2:=ri.CompanyPRI_Seq2;
SELF.CompanyPRI_Code2:=ri.CompanyPRI_Code2;
SELF.CompanyPRI_Desc2:=ri.CompanyPRI_Desc2;
SELF.CompanyPRI_Seq3:=ri.CompanyPRI_Seq3;
SELF.CompanyPRI_Code3:=ri.CompanyPRI_Code3;
SELF.CompanyPRI_Desc3:=ri.CompanyPRI_Desc3;
SELF.CompanyPRI_Seq4:=ri.CompanyPRI_Seq4;
SELF.CompanyPRI_Code4:=ri.CompanyPRI_Code4;
SELF.CompanyPRI_Desc4:=ri.CompanyPRI_Desc4;
SELF.CompanyPRI_Seq5:=ri.CompanyPRI_Seq5;
SELF.CompanyPRI_Code5:=ri.CompanyPRI_Code5;
SELF.CompanyPRI_Desc5:=ri.CompanyPRI_Desc5;
SELF.CompanyPRI_Seq6:=ri.CompanyPRI_Seq6;
SELF.CompanyPRI_Code6:=ri.CompanyPRI_Code6;
SELF.CompanyPRI_Desc6:=ri.CompanyPRI_Desc6;
SELF.CompanyPRI_Seq7:=ri.CompanyPRI_Seq7;
SELF.CompanyPRI_Code7:=ri.CompanyPRI_Code7;
SELF.CompanyPRI_Desc7:=ri.CompanyPRI_Desc7;
SELF.CompanyPRI_Seq8:=ri.CompanyPRI_Seq8;
SELF.CompanyPRI_Code8:=ri.CompanyPRI_Code8;
SELF.CompanyPRI_Desc8:=ri.CompanyPRI_Desc8;
SELF.CompanyResidentialDesc:=ri.CompanyResidentialDesc;
SELF.CompanyVeriSummary_Type1:=ri.CompanyVeriSummary_Type1;
SELF.CompanyVeriSummary_Index1:=ri.CompanyVeriSummary_Index1;
SELF.CompanyVeriSummary_Desc1:=ri.CompanyVeriSummary_Desc1;
SELF.CompanyVeriSummary_Type2:=ri.CompanyVeriSummary_Type2;
SELF.CompanyVeriSummary_Index2:=ri.CompanyVeriSummary_Index2;
SELF.CompanyVeriSummary_Desc2:=ri.CompanyVeriSummary_Desc2;
SELF.CompanyVeriSummary_Type3:=ri.CompanyVeriSummary_Type3;
SELF.CompanyVeriSummary_Index3:=ri.CompanyVeriSummary_Index3;
SELF.CompanyVeriSummary_Desc3:=ri.CompanyVeriSummary_Desc3;
SELF.CompanyVeriSummary_Type4:=ri.CompanyVeriSummary_Type4;
SELF.CompanyVeriSummary_Index4:=ri.CompanyVeriSummary_Index4;
SELF.CompanyVeriSummary_Desc4:=ri.CompanyVeriSummary_Desc4;
SELF.CompanyVeriSummary_Type5:=ri.CompanyVeriSummary_Type5;
SELF.CompanyVeriSummary_Index5:=ri.CompanyVeriSummary_Index5;
SELF.CompanyVeriSummary_Desc5:=ri.CompanyVeriSummary_Desc5;
SELF.BusToExexIndex_Rep1:=ri.BusToExexIndex_Rep1;
SELF.BusToExexIndex_Index1:=ri.BusToExexIndex_Index1;
SELF.BusToExexIndex_Desc1:=ri.BusToExexIndex_Desc1;
SELF.BusToExexIndex_Rep2:=ri.BusToExexIndex_Rep2;
SELF.BusToExexIndex_Index2:=ri.BusToExexIndex_Index2;
SELF.BusToExexIndex_Desc2:=ri.BusToExexIndex_Desc2;
SELF.BusToExexIndex_Rep3:=ri.BusToExexIndex_Rep3;
SELF.BusToExexIndex_Index3:=ri.BusToExexIndex_Index3;
SELF.BusToExexIndex_Desc3:=ri.BusToExexIndex_Desc3;
SELF.BusToExexIndex_Rep4:=ri.BusToExexIndex_Rep4;
SELF.BusToExexIndex_Index4:=ri.BusToExexIndex_Index4;
SELF.BusToExexIndex_Desc4:=ri.BusToExexIndex_Desc4;
SELF.BusToExexIndex_Rep5:=ri.BusToExexIndex_Rep5;
SELF.BusToExexIndex_Index5:=ri.BusToExexIndex_Index5;
SELF.BusToExexIndex_Desc5:=ri.BusToExexIndex_Desc5;
SELF.Rep1UniqueId:=ri.Rep1UniqueId;
SELF.Rep1CVI:=ri.Rep1CVI;
SELF.Rep1NAP:=ri.Rep1NAP;
SELF.Rep1NAS:=ri.Rep1NAS;
SELF.Rep1RI_seq1:=ri.Rep1RI_seq1;
SELF.Rep1RI_Code1:=ri.Rep1RI_Code1;
SELF.Rep1RI_Desc1:=ri.Rep1RI_Desc1;
SELF.Rep1RI_seq2:=ri.Rep1RI_seq2;
SELF.Rep1RI_Code2:=ri.Rep1RI_Code2;
SELF.Rep1RI_Desc2:=ri.Rep1RI_Desc2;
SELF.Rep1RI_seq3:=ri.Rep1RI_seq3;
SELF.Rep1RI_Code3:=ri.Rep1RI_Code3;
SELF.Rep1RI_Desc3:=ri.Rep1RI_Desc3;
SELF.Rep1RI_seq4:=ri.Rep1RI_seq4;
SELF.Rep1RI_Code4:=ri.Rep1RI_Code4;
SELF.Rep1RI_Desc4:=ri.Rep1RI_Desc4;
SELF.Rep1RI_seq5:=ri.Rep1RI_seq5;
SELF.Rep1RI_Code5:=ri.Rep1RI_Code5;
SELF.Rep1RI_Desc5:=ri.Rep1RI_Desc5;
SELF.Rep1RI_seq6:=ri.Rep1RI_seq6;
SELF.Rep1RI_Code6:=ri.Rep1RI_Code6;
SELF.Rep1RI_Desc6:=ri.Rep1RI_Desc6;
SELF.Rep1RI_seq7:=ri.Rep1RI_seq7;
SELF.Rep1RI_Code7:=ri.Rep1RI_Code7;
SELF.Rep1RI_Desc7:=ri.Rep1RI_Desc7;
SELF.Rep1RI_seq8:=ri.Rep1RI_seq8;
SELF.Rep1RI_Code8:=ri.Rep1RI_Code8;
SELF.Rep1RI_Desc8:=ri.Rep1RI_Desc8;
SELF.Rep1RI_seq9:=ri.Rep1RI_seq9;
SELF.Rep1RI_Code9:=ri.Rep1RI_Code9;
SELF.Rep1RI_Desc9:=ri.Rep1RI_Desc9;
SELF.Rep1RI_seq10:=ri.Rep1RI_seq10;
SELF.Rep1RI_Code10:=ri.Rep1RI_Code10;
SELF.Rep1RI_Desc10:=ri.Rep1RI_Desc10;
SELF.Rep2UniqueId:=ri.Rep2UniqueId;
SELF.Rep2CVI:=ri.Rep2CVI;
SELF.Rep2NAP:=ri.Rep2NAP;
SELF.Rep2NAS:=ri.Rep2NAS;
SELF.Rep2RI_seq1:=ri.Rep2RI_seq1;
SELF.Rep2RI_Code1:=ri.Rep2RI_Code1;
SELF.Rep2RI_Desc1:=ri.Rep2RI_Desc1;
SELF.Rep2RI_seq2:=ri.Rep2RI_seq2;
SELF.Rep2RI_Code2:=ri.Rep2RI_Code2;
SELF.Rep2RI_Desc2:=ri.Rep2RI_Desc2;
SELF.Rep2RI_seq3:=ri.Rep2RI_seq3;
SELF.Rep2RI_Code3:=ri.Rep2RI_Code3;
SELF.Rep2RI_Desc3:=ri.Rep2RI_Desc3;
SELF.Rep2RI_seq4:=ri.Rep2RI_seq4;
SELF.Rep2RI_Code4:=ri.Rep2RI_Code4;
SELF.Rep2RI_Desc4:=ri.Rep2RI_Desc4;
SELF.Rep2RI_seq5:=ri.Rep2RI_seq5;
SELF.Rep2RI_Code5:=ri.Rep2RI_Code5;
SELF.Rep2RI_Desc5:=ri.Rep2RI_Desc5;
SELF.Rep2RI_seq6:=ri.Rep2RI_seq6;
SELF.Rep2RI_Code6:=ri.Rep2RI_Code6;
SELF.Rep2RI_Desc6:=ri.Rep2RI_Desc6;
SELF.Rep2RI_seq7:=ri.Rep2RI_seq7;
SELF.Rep2RI_Code7:=ri.Rep2RI_Code7;
SELF.Rep2RI_Desc7:=ri.Rep2RI_Desc7;
SELF.Rep2RI_seq8:=ri.Rep2RI_seq8;
SELF.Rep2RI_Code8:=ri.Rep2RI_Code8;
SELF.Rep2RI_Desc8:=ri.Rep2RI_Desc8;
SELF.Rep2RI_seq9:=ri.Rep2RI_seq9;
SELF.Rep2RI_Code9:=ri.Rep2RI_Code9;
SELF.Rep2RI_Desc9:=ri.Rep2RI_Desc9;
SELF.Rep2RI_seq10:=ri.Rep2RI_seq10;
SELF.Rep2RI_Code10:=ri.Rep2RI_Code10;
SELF.Rep2RI_Desc10:=ri.Rep2RI_Desc10;
SELF.Rep3UniqueId:=ri.Rep3UniqueId;
SELF.Rep3CVI:=ri.Rep3CVI;
SELF.Rep3NAP:=ri.Rep3NAP;
SELF.Rep3NAS:=ri.Rep3NAS;
SELF.Rep3RI_seq1:=ri.Rep3RI_seq1;
SELF.Rep3RI_Code1:=ri.Rep3RI_Code1;
SELF.Rep3RI_Desc1:=ri.Rep3RI_Desc1;
SELF.Rep3RI_seq2:=ri.Rep3RI_seq2;
SELF.Rep3RI_Code2:=ri.Rep3RI_Code2;
SELF.Rep3RI_Desc2:=ri.Rep3RI_Desc2;
SELF.Rep3RI_seq3:=ri.Rep3RI_seq3;
SELF.Rep3RI_Code3:=ri.Rep3RI_Code3;
SELF.Rep3RI_Desc3:=ri.Rep3RI_Desc3;
SELF.Rep3RI_seq4:=ri.Rep3RI_seq4;
SELF.Rep3RI_Code4:=ri.Rep3RI_Code4;
SELF.Rep3RI_Desc4:=ri.Rep3RI_Desc4;
SELF.Rep3RI_seq5:=ri.Rep3RI_seq5;
SELF.Rep3RI_Code5:=ri.Rep3RI_Code5;
SELF.Rep3RI_Desc5:=ri.Rep3RI_Desc5;
SELF.Rep3RI_seq6:=ri.Rep3RI_seq6;
SELF.Rep3RI_Code6:=ri.Rep3RI_Code6;
SELF.Rep3RI_Desc6:=ri.Rep3RI_Desc6;
SELF.Rep3RI_seq7:=ri.Rep3RI_seq7;
SELF.Rep3RI_Code7:=ri.Rep3RI_Code7;
SELF.Rep3RI_Desc7:=ri.Rep3RI_Desc7;
SELF.Rep3RI_seq8:=ri.Rep3RI_seq8;
SELF.Rep3RI_Code8:=ri.Rep3RI_Code8;
SELF.Rep3RI_Desc8:=ri.Rep3RI_Desc8;
SELF.Rep3RI_seq9:=ri.Rep3RI_seq9;
SELF.Rep3RI_Code9:=ri.Rep3RI_Code9;
SELF.Rep3RI_Desc9:=ri.Rep3RI_Desc9;
SELF.Rep3RI_seq10:=ri.Rep3RI_seq10;
SELF.Rep3RI_Code10:=ri.Rep3RI_Code10;
SELF.Rep3RI_Desc10:=ri.Rep3RI_Desc10;
SELF.Rep4UniqueId:=ri.Rep4UniqueId;
SELF.Rep4CVI:=ri.Rep4CVI;
SELF.Rep4NAP:=ri.Rep4NAP;
SELF.Rep4NAS:=ri.Rep4NAS;
SELF.Rep4RI_seq1:=ri.Rep4RI_seq1;
SELF.Rep4RI_Code1:=ri.Rep4RI_Code1;
SELF.Rep4RI_Desc1:=ri.Rep4RI_Desc1;
SELF.Rep4RI_seq2:=ri.Rep4RI_seq2;
SELF.Rep4RI_Code2:=ri.Rep4RI_Code2;
SELF.Rep4RI_Desc2:=ri.Rep4RI_Desc2;
SELF.Rep4RI_seq3:=ri.Rep4RI_seq3;
SELF.Rep4RI_Code3:=ri.Rep4RI_Code3;
SELF.Rep4RI_Desc3:=ri.Rep4RI_Desc3;
SELF.Rep4RI_seq4:=ri.Rep4RI_seq4;
SELF.Rep4RI_Code4:=ri.Rep4RI_Code4;
SELF.Rep4RI_Desc4:=ri.Rep4RI_Desc4;
SELF.Rep4RI_seq5:=ri.Rep4RI_seq5;
SELF.Rep4RI_Code5:=ri.Rep4RI_Code5;
SELF.Rep4RI_Desc5:=ri.Rep4RI_Desc5;
SELF.Rep4RI_seq6:=ri.Rep4RI_seq6;
SELF.Rep4RI_Code6:=ri.Rep4RI_Code6;
SELF.Rep4RI_Desc6:=ri.Rep4RI_Desc6;
SELF.Rep4RI_seq7:=ri.Rep4RI_seq7;
SELF.Rep4RI_Code7:=ri.Rep4RI_Code7;
SELF.Rep4RI_Desc7:=ri.Rep4RI_Desc7;
SELF.Rep4RI_seq8:=ri.Rep4RI_seq8;
SELF.Rep4RI_Code8:=ri.Rep4RI_Code8;
SELF.Rep4RI_Desc8:=ri.Rep4RI_Desc8;
SELF.Rep4RI_seq9:=ri.Rep4RI_seq9;
SELF.Rep4RI_Code9:=ri.Rep4RI_Code9;
SELF.Rep4RI_Desc9:=ri.Rep4RI_Desc9;
SELF.Rep4RI_seq10:=ri.Rep4RI_seq10;
SELF.Rep4RI_Code10:=ri.Rep4RI_Code10;
SELF.Rep4RI_Desc10:=ri.Rep4RI_Desc10;
SELF.Rep5UniqueId:=ri.Rep5UniqueId;
SELF.Rep5CVI:=ri.Rep5CVI;
SELF.Rep5NAP:=ri.Rep5NAP;
SELF.Rep5NAS:=ri.Rep5NAS;
SELF.Rep5RI_seq1:=ri.Rep5RI_seq1;
SELF.Rep5RI_Code1:=ri.Rep5RI_Code1;
SELF.Rep5RI_Desc1:=ri.Rep5RI_Desc1;
SELF.Rep5RI_seq2:=ri.Rep5RI_seq2;
SELF.Rep5RI_Code2:=ri.Rep5RI_Code2;
SELF.Rep5RI_Desc2:=ri.Rep5RI_Desc2;
SELF.Rep5RI_seq3:=ri.Rep5RI_seq3;
SELF.Rep5RI_Code3:=ri.Rep5RI_Code3;
SELF.Rep5RI_Desc3:=ri.Rep5RI_Desc3;
SELF.Rep5RI_seq4:=ri.Rep5RI_seq4;
SELF.Rep5RI_Code4:=ri.Rep5RI_Code4;
SELF.Rep5RI_Desc4:=ri.Rep5RI_Desc4;
SELF.Rep5RI_seq5:=ri.Rep5RI_seq5;
SELF.Rep5RI_Code5:=ri.Rep5RI_Code5;
SELF.Rep5RI_Desc5:=ri.Rep5RI_Desc5;
SELF.Rep5RI_seq6:=ri.Rep5RI_seq6;
SELF.Rep5RI_Code6:=ri.Rep5RI_Code6;
SELF.Rep5RI_Desc6:=ri.Rep5RI_Desc6;
SELF.Rep5RI_seq7:=ri.Rep5RI_seq7;
SELF.Rep5RI_Code7:=ri.Rep5RI_Code7;
SELF.Rep5RI_Desc7:=ri.Rep5RI_Desc7;
SELF.Rep5RI_seq8:=ri.Rep5RI_seq8;
SELF.Rep5RI_Code8:=ri.Rep5RI_Code8;
SELF.Rep5RI_Desc8:=ri.Rep5RI_Desc8;
SELF.Rep5RI_seq9:=ri.Rep5RI_seq9;
SELF.Rep5RI_Code9:=ri.Rep5RI_Code9;
SELF.Rep5RI_Desc9:=ri.Rep5RI_Desc9;
SELF.Rep5RI_seq10:=ri.Rep5RI_seq10;
SELF.Rep5RI_Code10:=ri.Rep5RI_Code10;
SELF.Rep5RI_Desc10:=ri.Rep5RI_Desc10;
SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);

op8 := OUTPUT(COUNT(parsedRecordsTemp), NAMED('parsedRecordsTemp'));

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), trim(LEFT.TransactionID,left,right) = trim(RIGHT.TransactionID,left,right), TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF.login_id := RIGHT.login_id; SELF := LEFT), LOCAL);

op9 := OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('parsedRecords'));

op10 := OUTPUT(COUNT(parsedRecords), NAMED('cnt_parsedRecords'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, login_id, TransactionDate, TransactionID)), AccountID, login_id, TransactionDate, TransactionID, LOCAL);
op11 := OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('finalRecords'));

table(finalRecords,{TransactionDate,cnt := count(group)},TransactionDate,merge);

op := OUTPUT(finalRecords,, outputFile, THOR, OVERWRITE, COMPRESSED, EXPIRE(90));

 
RETURN op;
END;
/* end businessInstantID2 */




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

/*end SmallBizBIPCombinedRpt */




//*************************************************************************************************************************************************
//Parse smallBusinessAnalytics data from SAOT data
//*************************************************************************************************************************************************

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

/* end smallBusinessAnalytics */


//*************************************************************************************************************************************************
//Parse smallBusinessRisk data from SAOT data
//*************************************************************************************************************************************************
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
/*end smallBusinessRisk */


//*************************************************************************************************************************************************
//Sample SAOT data from pile
//*************************************************************************************************************************************************
EXPORT captureData() := function
//src definition
//T1 = Business Credit Report
//T2 = Small Business Analytics
//T3 = Small Business Bip Combined Report 
//T4 = Small Business Risk
//T5 = Business Instant ID2
EndDate := STD.Date.CurrentDate(True);
BeginDate := EndDate - 10000;

infile1 := '~thor::bipheader::qa::SAOT::businesscreditreport_' + BeginDate + '-' + EndDate;
infile2 := '~thor::bipheader::qa::SAOT::smallbusinessanalytics_' + BeginDate + '-' + EndDate;
infile3 := '~thor::bipheader::qa::SAOT::smallbizbipcombinedrpt_' + BeginDate + '-' + EndDate;
infile4 := '~thor::bipheader::qa::SAOT::smallbusinessrisk_' + BeginDate + '-' + EndDate;
infile5 := '~thor::bipheader::qa::SAOT::business_instantid2_' + BeginDate + '-' + EndDate;

SAMPLER_LAYOUT := RECORD
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 orgid;
  unsigned6 ultid;
  unsigned6 empid;
  unsigned6 powid;
  unsigned6 dotid;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  boolean has_lgid;
  string120 company_name;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 iscontact;
  string9 contact_ssn;
  string60 contact_email;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string3 fips_county;
  string2 source;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string9 company_fein;
  string9 active_duns_number;
  string10 company_phone;
  string1 phone_type;
  string80 company_url;
  string8 company_sic_code1;
  string50 company_status_derived;
  string34 vl_id;
  unsigned8 source_record_id;
  string100 source_docid;
  unsigned6 contact_did;
  string30 contact_email_domain;
  string50 contact_job_title_derived;
  string4 err_stat;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 rcid;
  string1 address_type_derived;
 END;
 
//SAOT Business Credit Report Layout
 SAOT_BCR_LAYOUT := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  unsigned6 indotid;
  unsigned6 inempid;
  unsigned6 inpowid;
  unsigned6 inproxid;
  unsigned6 inseleid;
  unsigned6 inorgid;
  unsigned6 inultid;
  string incompanystreetnumber;
  string incompanystreetname;
  string incompanyunitnumber;
  string incompanystreetaddress1;
  string incompanystreetaddress2;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanystatecityzip;
  unsigned6 inzipradius;
  string incompanyphone;
  string incompanyfein;
  string inemail;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress1;
  string inrep1city;
  string inrep1state;
  string inrep1zip5;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
  unsigned6 bestdotid;
  unsigned6 bestempid;
  unsigned6 bestpowid;
  unsigned6 bestproxid;
  unsigned6 bestseleid;
  unsigned6 bestorgid;
  unsigned6 bestultid;
  string bestcompanyname;
  string bestcompanystreetnumber;
  string bestcompanystreetname;
  string bestcompanyunitnumber;
  string bestcompanystreetaddress1;
  string bestcompanystreetaddress2;
  string bestcompanycity;
  string bestcompanystate;
  string bestcompanyzip5;
  string bestcompanystatecityzip;
  string bestcompanyphone;
 END; 
 ds_bcr := dataset(infile1, SAOT_BCR_LAYOUT, THOR);
 
 pj_bcr_s := project(ds_bcr, transform(SAMPLER_LAYOUT, 
  self.proxid := left.inproxid;
  self.seleid := left.inseleid;
  self.orgid := left.inorgid;
  self.ultid := left.inultid;
  self.empid := left.inempid;
  self.powid := left.inpowid;
  self.dotid := left.indotid;
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.fname := left.inrep1firstname;
  self.lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.p_city_name:= TRIM(sAddress[65..89]);
  SELF.st:= TRIM(sAddress[115..116]);
  SELF.zip:= TRIM(sAddress[117..121]);                                   
	self.source := 'T1';
  self.company_fein := left.incompanyfein;
  self.company_phone := left.incompanyphone;
  self := [];));	

//Small Business Analytics			
SAOT_SBA_Layout := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  string incompanystreetaddress1;
  string incompanystreetaddress2;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanyphone;
  string incompanyfein;
  string incompanysic;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress1;
  string inrep1city;
  string inrep1state;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
 END;
ds_sba := dataset(infile2, SAOT_SBA_Layout, thor);

pj_sba_s := project(ds_sba, transform(	SAMPLER_LAYOUT,
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.fname := left.inrep1firstname;
  self.lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.p_city_name:= TRIM(sAddress[65..89]);
  SELF.st:= TRIM(sAddress[115..116]);
  SELF.zip:= TRIM(sAddress[117..121]);                                   
	self.source := 'T2';
  self.company_fein := left.incompanyfein;
  self.company_phone := left.incompanyphone;
  self := [];));


//Small Business BIP Combined Report
SAOT_SBB_Layout := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  unsigned6 indotid;
  unsigned6 inempid;
  unsigned6 inpowid;
  unsigned6 inproxid;
  unsigned6 inseleid;
  unsigned6 inorgid;
  unsigned6 inultid;
  string incompanystreetnumber;
  string incompanystreetname;
  string incompanyunitnumber;
  string incompanystreetaddress1;
  string incompanystreetaddress2;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanystatecityzip;
  unsigned6 inzipradius;
  string incompanyphone;
  string incompanyfein;
  string incompanysic;
  string inemail;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress1;
  string inrep1city;
  string inrep1state;
  string inrep1zip5;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
  unsigned6 bestdotid;
  unsigned6 bestempid;
  unsigned6 bestpowid;
  unsigned6 bestproxid;
  unsigned6 bestseleid;
  unsigned6 bestorgid;
  unsigned6 bestultid;
  string bestcompanyname;
  string bestcompanystreetnumber;
  string bestcompanystreetname;
  string bestcompanyunitnumber;
  string bestcompanystreetaddress1;
  string bestcompanystreetaddress2;
  string bestcompanycity;
  string bestcompanystate;
  string bestcompanyzip5;
  string bestcompanystatecityzip;
  string bestcompanyphone;
 END;
 ds_sbbc := dataset(infile3, SAOT_SBB_Layout, thor);
 
  pj_sbbc_s := project(ds_sbbc, transform(SAMPLER_LAYOUT, 
  self.proxid := left.inproxid;
  self.seleid := left.inseleid;
  self.orgid := left.inorgid;
  self.ultid := left.inultid;
  self.empid := left.inempid;
  self.powid := left.inpowid;
  self.dotid := left.indotid;
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.fname := left.inrep1firstname;
  self.lname :=left.inrep1lastname;
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.p_city_name:= TRIM(sAddress[65..89]);
  SELF.st:= TRIM(sAddress[115..116]);
  SELF.zip:= TRIM(sAddress[117..121]);                                   
	self.source := 'T3';
  self.company_fein := left.incompanyfein;
  self.company_phone := left.incompanyphone;
  self := [];));	



//Small Business Risk 
SAOT_SBR_Layout := RECORD
  string transactionid;
  string20 login_id;
  string8 transactiondate;
  string incompanyname;
  string inalternatecompanyname;
  string incompanystreetaddress1;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanyphone;
  string incompanyfein;
  string inrep1name;
  string inrep1ssn;
  string inrep1dob;
  string inrep1dl;
  string inrep1dlstate;
  string inrep1phone;
 END;
 
ds_sbr := dataset(infile4, SAOT_SBR_Layout, thor);

pj_sbr_s := project(ds_sbr, transform(SAMPLER_LAYOUT,
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.contact_ssn := left.inrep1ssn;;
  addr1 := TRIM(left.incompanystreetaddress1);
  addr2 := LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range:= TRIM(sAddress[..10]);
  SELF.prim_name:= TRIM(sAddress[13..40]);
  SELF.sec_range:=TRIM(sAddress[57..64]);
  SELF.p_city_name:= TRIM(sAddress[65..89]);
  SELF.st:= TRIM(sAddress[115..116]);
  SELF.zip:= TRIM(sAddress[117..121]);                                   
	self.source := 'T4';
  self.company_fein := left.incompanyfein;
  self.company_phone := left.incompanyphone;
  self := [];));

//BIID2
SAOT_BIID2_Layout := RECORD
  string transactionid;
  string10 accountid;
  string20 login_id;
  string8 transactiondate;
  string endusercompanyname;
  string referencecode;
  string biid20producttype;
  string globalwatchlistthreshold;
  string watchlistsrequested;
  string dobradius;
  string exactaddrmatch;
  string exactdobmatch;
  string exactdriverlicensematch;
  string exactfirstnamematch;
  string exactfirstnamematchallownicknames;
  string exactlastnamematch;
  string exactphonematch;
  string exactssnmatch;
  string excludewatchlists;
  string includeadditionalwatchlists;
  string includecloverride;
  string includedlverification;
  string includedobincvi;
  string includedpbc;
  string includedriverlicenseincvi;
  string includemioverride;
  string includemsoverride;
  string includeofac;
  string lastseenthreshold;
  string nameinputorder;
  string poboxcompliance;
  string usedobfilter;
  string incompanyname;
  string inalternatecompanyname;
  string incompanystreetaddress;
  string incompanycity;
  string incompanystate;
  string incompanyzip5;
  string incompanyphone;
  string incompanyfein;
  string inrep1firstname;
  string inrep1lastname;
  string inrep1streetaddress;
  string inrep1city;
  string inrep1state;
  string inrep1zip5;
  string inrep1ssn;
  string inrep1dob;
  string inrep1phone;
  string inrep1dl;
  string inrep1dlstate;
  string inrep2firstname;
  string inrep2lastname;
  string inrep2streetaddress;
  string inrep2city;
  string inrep2state;
  string inrep2zip5;
  string inrep2ssn;
  string inrep2dob;
  string inrep2phone;
  string inrep2dl;
  string inrep2dlstate;
  string inrep3firstname;
  string inrep3lastname;
  string inrep3streetaddress;
  string inrep3city;
  string inrep3state;
  string inrep3zip5;
  string inrep3ssn;
  string inrep3dob;
  string inrep3phone;
  string inrep3dl;
  string inrep3dlstate;
  string inrep4firstname;
  string inrep4lastname;
  string inrep4streetaddress;
  string inrep4city;
  string inrep4state;
  string inrep4zip5;
  string inrep4ssn;
  string inrep4dob;
  string inrep4phone;
  string inrep4dl;
  string inrep4dlstate;
  string inrep5firstname;
  string inrep5lastname;
  string inrep5streetaddress;
  string inrep5city;
  string inrep5state;
  string inrep5zip5;
  string inrep5ssn;
  string inrep5dob;
  string inrep5phone;
  string inrep5dl;
  string inrep5dlstate;
  string numbervalidauthrepsinput;
  string companyseleid;
  string vercompanyname;
  string vercompanyaddr;
  string vercompanycity;
  string vercompanystate;
  string vercompanyzip;
  string vercompanyphone;
  string vercompanyfein;
  string companybusinessverificationindex;
  string companybusinessverificationdesc;
  string companypri_seq1;
  string companypri_code1;
  string companypri_desc1;
  string companypri_seq2;
  string companypri_code2;
  string companypri_desc2;
  string companypri_seq3;
  string companypri_code3;
  string companypri_desc3;
  string companypri_seq4;
  string companypri_code4;
  string companypri_desc4;
  string companypri_seq5;
  string companypri_code5;
  string companypri_desc5;
  string companypri_seq6;
  string companypri_code6;
  string companypri_desc6;
  string companypri_seq7;
  string companypri_code7;
  string companypri_desc7;
  string companypri_seq8;
  string companypri_code8;
  string companypri_desc8;
  string companyresidentialdesc;
  string companyverisummary_type1;
  string companyverisummary_index1;
  string companyverisummary_desc1;
  string companyverisummary_type2;
  string companyverisummary_index2;
  string companyverisummary_desc2;
  string companyverisummary_type3;
  string companyverisummary_index3;
  string companyverisummary_desc3;
  string companyverisummary_type4;
  string companyverisummary_index4;
  string companyverisummary_desc4;
  string companyverisummary_type5;
  string companyverisummary_index5;
  string companyverisummary_desc5;
  string bustoexexindex_rep1;
  string bustoexexindex_index1;
  string bustoexexindex_desc1;
  string bustoexexindex_rep2;
  string bustoexexindex_index2;
  string bustoexexindex_desc2;
  string bustoexexindex_rep3;
  string bustoexexindex_index3;
  string bustoexexindex_desc3;
  string bustoexexindex_rep4;
  string bustoexexindex_index4;
  string bustoexexindex_desc4;
  string bustoexexindex_rep5;
  string bustoexexindex_index5;
  string bustoexexindex_desc5;
  string rep1uniqueid;
  string rep1cvi;
  string rep1nap;
  string rep1nas;
  string rep1ri_seq1;
  string rep1ri_code1;
  string rep1ri_desc1;
  string rep1ri_seq2;
  string rep1ri_code2;
  string rep1ri_desc2;
  string rep1ri_seq3;
  string rep1ri_code3;
  string rep1ri_desc3;
  string rep1ri_seq4;
  string rep1ri_code4;
  string rep1ri_desc4;
  string rep1ri_seq5;
  string rep1ri_code5;
  string rep1ri_desc5;
  string rep1ri_seq6;
  string rep1ri_code6;
  string rep1ri_desc6;
  string rep1ri_seq7;
  string rep1ri_code7;
  string rep1ri_desc7;
  string rep1ri_seq8;
  string rep1ri_code8;
  string rep1ri_desc8;
  string rep1ri_seq9;
  string rep1ri_code9;
  string rep1ri_desc9;
  string rep1ri_seq10;
  string rep1ri_code10;
  string rep1ri_desc10;
  string rep2uniqueid;
  string rep2cvi;
  string rep2nap;
  string rep2nas;
  string rep2ri_seq1;
  string rep2ri_code1;
  string rep2ri_desc1;
  string rep2ri_seq2;
  string rep2ri_code2;
  string rep2ri_desc2;
  string rep2ri_seq3;
  string rep2ri_code3;
  string rep2ri_desc3;
  string rep2ri_seq4;
  string rep2ri_code4;
  string rep2ri_desc4;
  string rep2ri_seq5;
  string rep2ri_code5;
  string rep2ri_desc5;
  string rep2ri_seq6;
  string rep2ri_code6;
  string rep2ri_desc6;
  string rep2ri_seq7;
  string rep2ri_code7;
  string rep2ri_desc7;
  string rep2ri_seq8;
  string rep2ri_code8;
  string rep2ri_desc8;
  string rep2ri_seq9;
  string rep2ri_code9;
  string rep2ri_desc9;
  string rep2ri_seq10;
  string rep2ri_code10;
  string rep2ri_desc10;
  string rep3uniqueid;
  string rep3cvi;
  string rep3nap;
  string rep3nas;
  string rep3ri_seq1;
  string rep3ri_code1;
  string rep3ri_desc1;
  string rep3ri_seq2;
  string rep3ri_code2;
  string rep3ri_desc2;
  string rep3ri_seq3;
  string rep3ri_code3;
  string rep3ri_desc3;
  string rep3ri_seq4;
  string rep3ri_code4;
  string rep3ri_desc4;
  string rep3ri_seq5;
  string rep3ri_code5;
  string rep3ri_desc5;
  string rep3ri_seq6;
  string rep3ri_code6;
  string rep3ri_desc6;
  string rep3ri_seq7;
  string rep3ri_code7;
  string rep3ri_desc7;
  string rep3ri_seq8;
  string rep3ri_code8;
  string rep3ri_desc8;
  string rep3ri_seq9;
  string rep3ri_code9;
  string rep3ri_desc9;
  string rep3ri_seq10;
  string rep3ri_code10;
  string rep3ri_desc10;
  string rep4uniqueid;
  string rep4cvi;
  string rep4nap;
  string rep4nas;
  string rep4ri_seq1;
  string rep4ri_code1;
  string rep4ri_desc1;
  string rep4ri_seq2;
  string rep4ri_code2;
  string rep4ri_desc2;
  string rep4ri_seq3;
  string rep4ri_code3;
  string rep4ri_desc3;
  string rep4ri_seq4;
  string rep4ri_code4;
  string rep4ri_desc4;
  string rep4ri_seq5;
  string rep4ri_code5;
  string rep4ri_desc5;
  string rep4ri_seq6;
  string rep4ri_code6;
  string rep4ri_desc6;
  string rep4ri_seq7;
  string rep4ri_code7;
  string rep4ri_desc7;
  string rep4ri_seq8;
  string rep4ri_code8;
  string rep4ri_desc8;
  string rep4ri_seq9;
  string rep4ri_code9;
  string rep4ri_desc9;
  string rep4ri_seq10;
  string rep4ri_code10;
  string rep4ri_desc10;
  string rep5uniqueid;
  string rep5cvi;
  string rep5nap;
  string rep5nas;
  string rep5ri_seq1;
  string rep5ri_code1;
  string rep5ri_desc1;
  string rep5ri_seq2;
  string rep5ri_code2;
  string rep5ri_desc2;
  string rep5ri_seq3;
  string rep5ri_code3;
  string rep5ri_desc3;
  string rep5ri_seq4;
  string rep5ri_code4;
  string rep5ri_desc4;
  string rep5ri_seq5;
  string rep5ri_code5;
  string rep5ri_desc5;
  string rep5ri_seq6;
  string rep5ri_code6;
  string rep5ri_desc6;
  string rep5ri_seq7;
  string rep5ri_code7;
  string rep5ri_desc7;
  string rep5ri_seq8;
  string rep5ri_code8;
  string rep5ri_desc8;
  string rep5ri_seq9;
  string rep5ri_code9;
  string rep5ri_desc9;
  string rep5ri_seq10;
  string rep5ri_code10;
  string rep5ri_desc10;
 END;
 
 ds_biid2 := dataset(infile5, SAOT_BIID2_Layout, thor);
 
  pj_biid2_s := project(ds_biid2, transform(SAMPLER_LAYOUT, 
  self.company_name := std.str.ToUpperCase(left.incompanyname);
  self.fname 				:= left.inrep1firstname;
  self.lname 				:=left.inrep1lastname;
  self.contact_ssn 	:= left.inrep1ssn;;
  addr1 						:= TRIM(left.incompanystreetaddress);
  addr2 						:= LEFT.incompanycity + ', ' + LEFT.incompanystate + ' ' + left.incompanyzip5;
  sAddress					:=Address.CleanAddress182(addr1, addr2);
	SELF.prim_range		:= TRIM(sAddress[..10]);
  SELF.prim_name		:= TRIM(sAddress[13..40]);
  SELF.sec_range		:=TRIM(sAddress[57..64]);
  SELF.p_city_name	:= TRIM(sAddress[65..89]);
  SELF.st						:= TRIM(sAddress[115..116]);
  SELF.zip					:= TRIM(sAddress[117..121]);                                   
	self.source 			:= 'T5';
  self.company_fein := left.incompanyfein;
  self.company_phone:= left.incompanyphone;
  self := [];));

// SAOT_data :=  ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)
					  // + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)
						// + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)
						// + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000) + ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)+ ENTH(pj_bcr_s,10000)
						// + ENTH(pj_bcr_s,10000) + ENTH(pj_sba_s,50000) + ENTH(pj_sbbc_s,50000) + ENTH(pj_sbr_s,50000) + ENTH(pj_biid2_s,50000);
 SAOT_data := project(pj_bcr_s + pj_sba_s + pj_sbbc_s + pj_sbr_s +pj_biid2_s,
                      transform(modLayouts.lSrcLayout,
											          self.src_category := left.source;
																self.city := left.p_city_name;
																self.phone10 := left.company_phone;
																self.rid := left.rcid;
																self.state := left.st;
																self.zip5 := left.zip;
																self.fein := left.company_fein;
																self.url  := left.company_url;
																self.email := left.contact_email;
																self.contact_fname := left.fname;
																self.contact_mname := left.mname;
																self.contact_lname := left.lname;
																self.sic_code := left.company_sic_code1;
											          self := left));

RETURN SEQUENTIAL(PARALLEL(  
											smallBusinessRisk(),
											smallBusinessAnalytics(), 
											smallBizBIPCombinedRpt(), 
											businessCreditReport(), 
											businessInstantID2()
													),
										OUTPUT(SAOT_data,, '~thor::bipheader::qa::saotDataSample', THOR, OVERWRITE, COMPRESSED)
									);

END;

END;
