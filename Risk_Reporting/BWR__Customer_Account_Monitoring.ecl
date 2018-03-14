#workunit('name', 'Scoring_Account_Monitoring');

// #option('allowedClusters', 'thor400_20,thor400_44,thor400_60'); // This workunit can run on these clusters
// #option('AllowAutoQueueSwitch', TRUE); // If the current queue is full, use an available cluster from above

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

// Set of Account ID #'s (STRING) that we don't want to flag Name population issues for - these are verified to be OK
FANameOK := [];
IIDNameOK := [];
RVNameOK := [];
// Set of Account ID #'s (STRING) that we don't want to flag SSN population issues for - these are verified to be OK
FASSNOK := [];
IIDSSNOK := [];
RVSSNOK := [];
// Set of Account ID #'s (STRING) that we don't want to flag DateOfBirth DOB population issues for - these are verified to be OK
FADOBOK := [];
IIDDOBOK := [];
RVDOBOK := [];
// Set of Account ID #'s (STRING) that we don't want to flag Address population issues for - these are verified to be OK
FAAddressOK := [];
IIDAddressOK := [];
RVAddressOK := [];
// Set of Account ID #'s (STRING) that we don't want to flag Phone population issues for - these are verified to be OK
FAPhoneOK := [];
IIDPhoneOK := [];
RVPhoneOK := [];

// Pull logs for the past year to do our rolling Average on
EndDate := ut.GetDate;
BeginDateTemp := ut.date_math(EndDate, -5); // Look back up to 5 days for records, keep the most recent date
BeginDate := IF(BeginDateTemp >= '20130512', BeginDateTemp, '20130512'); // Tracking didn't fully start until this date, eliminate the "test" days before this date.

eyeball := 100;

/* ***********************************************************************************************
 *************************************************************************************************
 *             GATHER AND PARSE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                        *
 *************************************************************************************************
 *********************************************************************************************** */
LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;
LogFileFCRA := Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID;

Parsed_Layout := RECORD
	STRING30	Product				      := ''; // Such as INSTANTID, RISKVIEW, FRAUDPOINT
	STRING30	TransactionID	      := ''; // Forced into the record so I can join it all together
	STRING30	AccountID			      := '';
	STRING30	LoginID				      := '';
	STRING8		TransactionDate     := '';
	STRING150	EndUserCompanyName  := '';
	STRING30	FirstName		      	:= '';
	STRING30	LastName		      	:= '';
	STRING90	FullName		      	:= '';
	STRING9		SSN					      	:= '';
	STRING8		DOB				      		:= '';
	STRING120	Address		      		:= '';
	STRING25	City				      	:= '';
	STRING2		State				      	:= '';
	STRING9		Zip				      		:= '';
	STRING20	DL				      		:= '';
	STRING10	HomePhone	      		:= '';
	STRING10	WorkPhone	      		:= '';
END;

RVLogsRaw := DISTRIBUTE(PULL(LogFileFCRA (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW', 'RISKVIEWATTRIBUTES'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins)));

RVLogs := PROJECT(RVLogsRaw, TRANSFORM({RECORDOF(RVLogsRaw) - outputxml, STRING30 TransactionID, STRING10 AccountID, STRING30 LoginID, STRING8 TransactionDate}, 
				// Need to mold the input XML into something that can be passed through the same PARSE function - this means making sure the first tag is <RiskView>
				inputXMLTemp1 := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView>', '<RiskView><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
				inputXMLTemp2 := StringLib.StringFindReplace(inputXMLTemp1, '<RiskViewAttributes>', '<RiskView><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
				SELF.inputxml := StringLib.StringFindReplace(inputXMLTemp2, '</RiskViewAttributes>', '</RiskView>'); 
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.LoginID := LEFT.login_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
// OUTPUT(CHOOSEN(RVLogs, eyeball), NAMED('Sample_Raw_RV_Logs'));

Parsed_Layout parseRVInput () := TRANSFORM
	SELF.TransactionID	    := TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName := TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName	    		:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName			    	:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.SSN			    			:= TRIM(XMLTEXT('SearchBy/SSN'));
	DOBMonthTemp            := TRIM(XMLTEXT('SearchBy/DOB/Month'));
	DOBMonth                := INTFORMAT((INTEGER)DOBMonthTemp, 2, 1);
	DOBDayTemp              := TRIM(XMLTEXT('SearchBy/DOB/Day'));
	DOBDay                  := INTFORMAT((INTEGER)DOBDayTemp, 2, 1);
	DOBYear                 := TRIM(XMLTEXT('SearchBy/DOB/Year'));
	DOB                     := TRIM(XMLTEXT('SearchBy/DOB'));
	DOBCombined             := DOB + IF((INTEGER)DOBYear = 0 OR (INTEGER)DOBMonth = 0 OR (INTEGER)DOBDay = 0, '', DOBYear + DOBMonth + DOBDay); // Make sure YYYYMMDD are populated, if not, blank it out
	SELF.DOB						    :=  DOBCombined;
	SELF.Address				    := TRIM(XMLTEXT('SearchBy/Address/StreetNumber')) + TRIM(XMLTEXT('SearchBy/Address/StreetAddress1')); // Catch if it is full or parsed
	SELF.City						    := TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State				  	  := TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						    := TRIM(XMLTEXT('SearchBy/Address/Zip5')) + TRIM(XMLTEXT('SearchBy/Address/Zip4'));
	SELF.DL							    := TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.HomePhone			    := TRIM(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			    := TRIM(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedRVInput := PARSE(RVLogs, inputxml, parseRVInput(), XML('RiskView'));

// OUTPUT(CHOOSEN(parsedRVInput, eyeball), NAMED('Sample_Parsed_RV_Input'));

IIDLogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['INSTANTID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins)));

IIDLogs := PROJECT(IIDLogsRaw, TRANSFORM({RECORDOF(IIDLogsRaw) - outputxml, STRING30 TransactionID, STRING10 AccountID, STRING30 LoginID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<InstantID>', '<InstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.LoginID := LEFT.login_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
// OUTPUT(CHOOSEN(IIDLogs, eyeball), NAMED('Sample_Raw_IID_Logs'));

Parsed_Layout parseIIDInput () := TRANSFORM
	SELF.TransactionID      := TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName	:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName			    := TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName			  	  := TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.FullName				    := TRIM(XMLTEXT('SearchBy/Name/Full'));
	SELF.SSN						    := TRIM(XMLTEXT('SearchBy/SSN'));
	DOBMonthTemp            := TRIM(XMLTEXT('SearchBy/DOB/Month'));
	DOBMonth                := INTFORMAT((INTEGER)DOBMonthTemp, 2, 1);
	DOBDayTemp              := TRIM(XMLTEXT('SearchBy/DOB/Day'));
	DOBDay                  := INTFORMAT((INTEGER)DOBDayTemp, 2, 1);
	DOBYear                 := TRIM(XMLTEXT('SearchBy/DOB/Year'));
	DOB                     := TRIM(XMLTEXT('SearchBy/DOB'));
	DOBCombined             := DOB + IF((INTEGER)DOBYear = 0 OR (INTEGER)DOBMonth = 0 OR (INTEGER)DOBDay = 0, '', DOBYear + DOBMonth + DOBDay); // Make sure YYYYMMDD are populated, if not, blank it out
	SELF.DOB						    :=  DOBCombined;
	SELF.Address				    := TRIM(XMLTEXT('SearchBy/Address/StreetNumber')) + TRIM(XMLTEXT('SearchBy/Address/StreetAddress1')); // Catch if it is full or parsed
	SELF.City						    := TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					    := TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						    := TRIM(XMLTEXT('SearchBy/Address/Zip5')) + TRIM(XMLTEXT('SearchBy/Address/Zip4'));
	SELF.DL							    := TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.HomePhone		    	:= TRIM(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone		    	:= TRIM(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedIIDInput := PARSE(IIDLogs, inputxml, parseIIDInput(), XML('InstantID'));

// OUTPUT(CHOOSEN(parsedIIDInput, eyeball), NAMED('Sample_Parsed_IID_Input'));

FPLogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins)));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
FPLogs := PROJECT(FPLogsRaw, TRANSFORM({RECORDOF(FPLogsRaw) - outputxml, STRING30 TransactionID, STRING10 AccountID, STRING30 LoginID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FraudPoint>', '<FraudPoint><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.LoginID := LEFT.login_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
// OUTPUT(CHOOSEN(FPLogs, eyeball), NAMED('Sample_Raw_FP_Logs'));

Parsed_Layout parseFPInput () := TRANSFORM
	SELF.TransactionID	    := TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName	:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName			    := TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				    := TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.SSN						    := TRIM(XMLTEXT('SearchBy/SSN'));
	DOBMonthTemp            := TRIM(XMLTEXT('SearchBy/DOB/Month'));
	DOBMonth                := INTFORMAT((INTEGER)DOBMonthTemp, 2, 1);
	DOBDayTemp              := TRIM(XMLTEXT('SearchBy/DOB/Day'));
	DOBDay                  := INTFORMAT((INTEGER)DOBDayTemp, 2, 1);
	DOBYear                 := TRIM(XMLTEXT('SearchBy/DOB/Year'));
	DOB                     := TRIM(XMLTEXT('SearchBy/DOB'));
	DOBCombined             := DOB + IF((INTEGER)DOBYear = 0 OR (INTEGER)DOBMonth = 0 OR (INTEGER)DOBDay = 0, '', DOBYear + DOBMonth + DOBDay); // Make sure YYYYMMDD are populated, if not, blank it out
	SELF.DOB						    :=  DOBCombined;
	SELF.Address				    := TRIM(XMLTEXT('SearchBy/Address/StreetNumber')) + TRIM(XMLTEXT('SearchBy/Address/StreetAddress1')); // Catch if it is full or parsed
	SELF.City						    := TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					    := TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						    := TRIM(XMLTEXT('SearchBy/Address/Zip5')) + TRIM(XMLTEXT('SearchBy/Address/Zip4'));
	SELF.DL						    	:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.HomePhone		    	:= TRIM(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone		    	:= TRIM(XMLTEXT('SearchBy/WPhone10'));
	
	SELF := [];
END;
parsedFPInput := PARSE(FPLogs, inputxml, parseFPInput(), XML('FraudPoint'));

// OUTPUT(CHOOSEN(parsedFPInput, eyeball), NAMED('Sample_Parsed_FP_Input'));

finalRecordsFraudPoint := JOIN(FPLogs, parsedFPInput, LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(Parsed_Layout, SELF.Product := 'FRAUDPOINT'; SELF.AccountID := StringLib.StringToUpperCase(LEFT.AccountID); SELF.LoginID := StringLib.StringToUpperCase(LEFT.LoginID); SELF.TransactionDate := LEFT.TransactionDate; SELF := RIGHT));

finalRecordsInstantID := JOIN(IIDLogs, parsedIIDInput, LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(Parsed_Layout, SELF.Product := 'INSTANTID'; SELF.AccountID := StringLib.StringToUpperCase(LEFT.AccountID); SELF.LoginID := StringLib.StringToUpperCase(LEFT.LoginID); SELF.TransactionDate := LEFT.TransactionDate; SELF := RIGHT));

finalRecordsRiskView := JOIN(RVLogs, parsedRVInput, LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(Parsed_Layout, SELF.Product := 'RISKVIEW'; SELF.AccountID := StringLib.StringToUpperCase(LEFT.AccountID); SELF.LoginID := StringLib.StringToUpperCase(LEFT.LoginID); SELF.TransactionDate := LEFT.TransactionDate; SELF := RIGHT));

finalRecordsTemp := SORT(finalRecordsFraudPoint + finalRecordsInstantID + finalRecordsRiskView, -TransactionDate, Product, AccountID, LoginID);

mostRecentDate := finalRecordsTemp[1].TransactionDate; // The very first record should be the most recent date on the key

finalRecords := finalRecordsTemp (TransactionDate = mostRecentDate); // Only look at the records from the most recent date built into the key

/* ***********************************************************************************************
 *************************************************************************************************
 *              DETERMINE WHICH ACCOUNTS DIDN'T MEET THE INPUT THRESHOLDS                        *
 *************************************************************************************************
 *********************************************************************************************** */
NameThreshold := 25.000; // Flag any accounts which have more than 25% of their transactions with blank first and last name
SSNThreshold := 25.000;
DOBThreshold := 25.000;
AddressThreshold := 25.000;
PhoneThreshold := 25.000;
recordThreshold := 75; // Number of records that we have to have seen that day to trigger the above thresholds
totalThreshold := 95.000;
recordTotalThreshold := 10; // Number of records that we have to have seen that day to trigger the 100% threshold amount

populationRec := RECORD
	STRING30	AccountID										:= finalRecords.AccountID;
	STRING30	LoginID											:= finalRecords.LoginID;
	STRING8		TransactionDate							:= finalRecords.TransactionDate;
	STRING30	Product											:= finalRecords.Product;
	UNSIGNED8 TotalTransactions 					:= COUNT(GROUP);
	UNSIGNED8	TransactionsFirstNameBlank	:= COUNT(GROUP, TRIM(finalRecords.FirstName) = '');
	DECIMAL6_3 PercentFirstNameBlank			:= (COUNT(GROUP, TRIM(finalRecords.FirstName) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsLastNameBlank		:= COUNT(GROUP, TRIM(finalRecords.LastName) = '');
	DECIMAL6_3 PercentLastNameBlank				:= (COUNT(GROUP, TRIM(finalRecords.LastName) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8 TransactionsFullNameBlank		:= COUNT(GROUP, TRIM(finalRecords.FullName) = '' AND TRIM(finalRecords.Product) = 'INSTANTID');
	DECIMAL6_3 PercentFullNameBlank				:= (COUNT(GROUP, TRIM(finalRecords.FullName) = '' AND TRIM(finalRecords.Product) = 'INSTANTID') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsNameBlank				:= COUNT(GROUP, TRIM(finalRecords.FirstName) = '' AND TRIM(finalRecords.LastName) = '');
	DECIMAL6_3 PercentNameBlank						:= (COUNT(GROUP, TRIM(finalRecords.FirstName) = '' AND TRIM(finalRecords.LastName) = '' AND (TRIM(finalRecords.FullName) = '' OR TRIM(finalRecords.Product) <> 'INSTANTID')) / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsSSNBlank				:= COUNT(GROUP, TRIM(finalRecords.SSN) = '');
	DECIMAL6_3 PercentSSNBlank						:= (COUNT(GROUP, TRIM(finalRecords.SSN) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsDOBBlank				:= COUNT(GROUP, TRIM(finalRecords.DOB) = '');
	DECIMAL6_3 PercentDOBBlank						:= (COUNT(GROUP, TRIM(finalRecords.DOB) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsStreetAddressBlank := COUNT(GROUP, TRIM(finalRecords.Address) = '');
	DECIMAL6_3 PercentStreetAddressBlank	:= (COUNT(GROUP, TRIM(finalRecords.Address) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsCityBlank				:= COUNT(GROUP, TRIM(finalRecords.City) = '');
	DECIMAL6_3 PercentCityBlank						:= (COUNT(GROUP, TRIM(finalRecords.City) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsStateBlank			:= COUNT(GROUP, TRIM(finalRecords.State) = '');
	DECIMAL6_3 PercentStateBlank					:= (COUNT(GROUP, TRIM(finalRecords.State) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsZipBlank				:= COUNT(GROUP, TRIM(finalRecords.Zip) = '');
	DECIMAL6_3 PercentZipBlank						:= (COUNT(GROUP, TRIM(finalRecords.Zip) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsAddressBlank		:= COUNT(GROUP, TRIM(finalRecords.Address) = '' AND TRIM(finalRecords.City) = '' AND TRIM(finalRecords.State) = '' AND TRIM(finalRecords.Zip) = '');
	DECIMAL6_3 PercentAddressBlank				:= (COUNT(GROUP, TRIM(finalRecords.Address) = '' AND TRIM(finalRecords.City) = '' AND TRIM(finalRecords.State) = '' AND TRIM(finalRecords.Zip) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsDLBlank					:= COUNT(GROUP, TRIM(finalRecords.DL) = '');
	DECIMAL6_3 PercentDLBlank							:= (COUNT(GROUP, TRIM(finalRecords.DL) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsHomePhoneBlank	:= COUNT(GROUP, TRIM(finalRecords.HomePhone) = '');
	DECIMAL6_3 PercentHomePhoneBlank			:= (COUNT(GROUP, TRIM(finalRecords.HomePhone) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsWorkPhoneBlank	:= COUNT(GROUP, TRIM(finalRecords.WorkPhone) = '');
	DECIMAL6_3 PercentWorkPhoneBlank			:= (COUNT(GROUP, TRIM(finalRecords.WorkPhone) = '') / COUNT(GROUP)) * 100;
	UNSIGNED8	TransactionsBothPhonesBlank	:= COUNT(GROUP, TRIM(finalRecords.HomePhone) = '' AND TRIM(finalRecords.WorkPhone) = '');
	DECIMAL6_3 PercentBothPhonesBlank			:= (COUNT(GROUP, TRIM(finalRecords.HomePhone) = '' AND TRIM(finalRecords.WorkPhone) = '') / COUNT(GROUP)) * 100;
END;
populationTable := TABLE(finalRecords, populationRec, AccountID, LoginID, TransactionDate, Product);

sortedPopulation := SORT(populationTable, Product, -TotalTransactions, AccountID, LoginID, TransactionDate);

// OUTPUT(CHOOSEN(sortedPopulation, eyeball), NAMED('Sorted_Population_Table'));

problemNames := sortedPopulation ((PercentNameBlank >= NameThreshold AND TotalTransactions >= recordThreshold) OR (PercentNameBlank >= totalThreshold AND TotalTransactions >= recordTotalThreshold));

problemSSN := sortedPopulation ((PercentSSNBlank >= SSNThreshold AND TotalTransactions >= recordThreshold) OR (PercentSSNBlank >= totalThreshold AND TotalTransactions >= recordTotalThreshold));

problemDOB := sortedPopulation ((PercentDOBBlank >= DOBThreshold AND TotalTransactions >= recordThreshold) OR (PercentDOBBlank >= totalThreshold AND TotalTransactions >= recordTotalThreshold));

problemAddress := sortedPopulation ((PercentAddressBlank >= AddressThreshold AND TotalTransactions >= recordThreshold) OR (PercentAddressBlank >= totalThreshold AND TotalTransactions >= recordTotalThreshold));

problemPhone := sortedPopulation ((PercentBothPhonesBlank >= PhoneThreshold AND TotalTransactions >= recordThreshold) OR (PercentBothPhonesBlank >= totalThreshold AND TotalTransactions >= recordTotalThreshold));

// OUTPUT(CHOOSEN(problemNames, eyeball), NAMED('Potential_Name_Population_Issues'));
// OUTPUT(CHOOSEN(problemSSN, eyeball), NAMED('Potential_SSN_Population_Issues'));
// OUTPUT(CHOOSEN(problemDOB, eyeball), NAMED('Potential_DOB_Population_Issues'));
// OUTPUT(CHOOSEN(problemAddress, eyeball), NAMED('Potential_Address_Population_Issues'));
// OUTPUT(CHOOSEN(problemPhone, eyeball), NAMED('Potential_Phone_Population_Issues'));

sampleNameProblem := SORT(JOIN(finalRecords, problemNames, LEFT.AccountID = RIGHT.AccountID AND LEFT.Product = RIGHT.Product AND TRIM(LEFT.FirstName) = '' AND TRIM(LEFT.LastName) = '', TRANSFORM(LEFT), KEEP(10)), Product, AccountID, TransactionDate);
sampleSSNProblem := SORT(JOIN(finalRecords, problemSSN, LEFT.AccountID = RIGHT.AccountID AND LEFT.Product = RIGHT.Product AND TRIM(LEFT.SSN) = '', TRANSFORM(LEFT), KEEP(10)), Product, AccountID, TransactionDate);
sampleDOBProblem := SORT(JOIN(finalRecords, problemDOB, LEFT.AccountID = RIGHT.AccountID AND LEFT.Product = RIGHT.Product AND TRIM(LEFT.DOB) = '', TRANSFORM(LEFT), KEEP(10)), Product, AccountID, TransactionDate);
sampleAddressProblem := SORT(JOIN(finalRecords, problemAddress, LEFT.AccountID = RIGHT.AccountID AND LEFT.Product = RIGHT.Product AND TRIM(LEFT.Address) = '' AND TRIM(LEFT.City) = '' AND TRIM(LEFT.State) = '' AND TRIM(LEFT.Zip) = '', TRANSFORM(LEFT), KEEP(10)), Product, AccountID, TransactionDate);
samplePhoneProblem := SORT(JOIN(finalRecords, problemPhone, LEFT.AccountID = RIGHT.AccountID AND LEFT.Product = RIGHT.Product AND TRIM(LEFT.HomePhone) = '' AND TRIM(LEFT.WorkPhone) = '', TRANSFORM(LEFT), KEEP(10)), Product, AccountID, TransactionDate);

OUTPUT(CHOOSEN(sampleNameProblem (Product = 'FRAUDADVISOR' AND AccountID NOT IN FANameOK), eyeball * 10), NAMED('Name_Population_Issues_FraudPoint'));
OUTPUT(CHOOSEN(sampleNameProblem (Product = 'INSTANTID' AND AccountID NOT IN IIDNameOK), eyeball * 10), NAMED('Name_Population_Issues_InstantID'));
OUTPUT(CHOOSEN(sampleNameProblem(Product = 'RISKVIEW' AND AccountID NOT IN RVNameOK), eyeball * 10), NAMED('Name_Population_Issues_RiskView'));

OUTPUT(CHOOSEN(sampleSSNProblem (Product = 'FRAUDADVISOR' AND AccountID NOT IN FASSNOK), eyeball * 10), NAMED('SSN_Population_Issues_FraudPoint'));
OUTPUT(CHOOSEN(sampleSSNProblem (Product = 'INSTANTID' AND AccountID NOT IN IIDSSNOK), eyeball * 10), NAMED('SSN_Population_Issues_InstantID'));
OUTPUT(CHOOSEN(sampleSSNProblem(Product = 'RISKVIEW' AND AccountID NOT IN RVSSNOK), eyeball * 10), NAMED('SSN_Population_Issues_RiskView'));

OUTPUT(CHOOSEN(sampleDOBProblem (Product = 'FRAUDADVISOR' AND AccountID NOT IN FADOBOK), eyeball * 10), NAMED('DOB_Population_Issues_FraudPoint'));
OUTPUT(CHOOSEN(sampleDOBProblem (Product = 'INSTANTID' AND AccountID NOT IN IIDDOBOK), eyeball * 10), NAMED('DOB_Population_Issues_InstantID'));
OUTPUT(CHOOSEN(sampleDOBProblem(Product = 'RISKVIEW' AND AccountID NOT IN RVDOBOK), eyeball * 10), NAMED('DOB_Population_Issues_RiskView'));

OUTPUT(CHOOSEN(sampleAddressProblem (Product = 'FRAUDADVISOR' AND AccountID NOT IN FAAddressOK), eyeball * 10), NAMED('Address_Population_Issues_FraudPoint'));
OUTPUT(CHOOSEN(sampleAddressProblem (Product = 'INSTANTID' AND AccountID NOT IN IIDAddressOK), eyeball * 10), NAMED('Address_Population_Issues_InstantID'));
OUTPUT(CHOOSEN(sampleAddressProblem(Product = 'RISKVIEW' AND AccountID NOT IN RVAddressOK), eyeball * 10), NAMED('Address_Population_Issues_RiskView'));

OUTPUT(CHOOSEN(samplePhoneProblem (Product = 'FRAUDADVISOR' AND AccountID NOT IN FAPhoneOK), eyeball * 10), NAMED('Phone_Population_Issues_FraudPoint'));
OUTPUT(CHOOSEN(samplePhoneProblem (Product = 'INSTANTID' AND AccountID NOT IN IIDPhoneOK), eyeball * 10), NAMED('Phone_Population_Issues_InstantID'));
OUTPUT(CHOOSEN(samplePhoneProblem(Product = 'RISKVIEW' AND AccountID NOT IN RVPhoneOK), eyeball * 10), NAMED('Phone_Population_Issues_RiskView'));

emailRec := RECORD
	populationRec;
	STRING email := '';
END;

pNames := PROJECT(problemNames, TRANSFORM(emailRec, SELF := LEFT));
pSSN := PROJECT(problemSSN, TRANSFORM(emailRec, SELF := LEFT));
pDOB := PROJECT(problemDOB, TRANSFORM(emailRec, SELF := LEFT));
pAddress := PROJECT(problemAddress, TRANSFORM(emailRec, SELF := LEFT));
pPhone := PROJECT(problemPhone, TRANSFORM(emailRec, SELF := LEFT));

STRING padNumber (STRING number) := MAP(
				LENGTH(TRIM(number)) >= 0 AND LENGTH(TRIM(number)) <= 5 	=> ' ' + number + '\t\t|',
				LENGTH(TRIM(number)) >= 6 AND LENGTH(TRIM(number)) <= 12 	=> ' ' + number + '\t|',
				LENGTH(TRIM(number)) >= 13 AND LENGTH(TRIM(number)) <= 13 => ' ' + number + '|',
					number + '|');

emailRec getName(emailRec le, emailRec ri) := TRANSFORM
	SELF.email := le.email + 'Account: ' + ri.AccountID + ' | Login:' + padNumber(ri.LoginID) + ' Trans:' + padNumber((STRING)ri.TotalTransactions) + ' Trans Blank Name:' + padNumber((STRING)ri.TransactionsNameBlank) + ' % Blank Name: ' + ri.PercentNameBlank + '\n';
	SELF := ri;
END;

FANames := SORT(ITERATE(pNames (Product = 'FRAUDADVISOR' AND AccountID NOT IN FANameOK), getName(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
IIDNames := SORT(ITERATE(pNames (Product = 'INSTANTID' AND AccountID NOT IN IIDNameOK), getName(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
RVNames := SORT(ITERATE(pNames (Product = 'RISKVIEW' AND AccountID NOT IN RVNameOK), getName(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];

emailRec getSSN(emailRec le, emailRec ri) := TRANSFORM
	SELF.email := le.email + 'Account: ' + ri.AccountID + ' | Login:' + padNumber(ri.LoginID) + ' Trans:' + padNumber((STRING)ri.TotalTransactions) + ' Trans Blank SSN:' + padNumber((STRING)ri.TransactionsSSNBlank) + ' % Blank SSN: ' + ri.PercentSSNBlank + '\n';
	SELF := ri;
END;

FASSN := SORT(ITERATE(pSSN (Product = 'FRAUDADVISOR' AND AccountID NOT IN FASSNOK), getSSN(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
IIDSSN := SORT(ITERATE(pSSN (Product = 'INSTANTID' AND AccountID NOT IN IIDSSNOK), getSSN(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
RVSSN := SORT(ITERATE(pSSN (Product = 'RISKVIEW' AND AccountID NOT IN RVSSNOK), getSSN(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];

emailRec getDOB(emailRec le, emailRec ri) := TRANSFORM
	SELF.email := le.email + 'Account: ' + ri.AccountID + ' | Login:' + padNumber(ri.LoginID) + ' Trans:' + padNumber((STRING)ri.TotalTransactions) + ' Trans Blank DOB:' + padNumber((STRING)ri.TransactionsDOBBlank) + ' % Blank DOB: ' + ri.PercentDOBBlank + '\n';
	SELF := ri;
END;

FADOB := SORT(ITERATE(pDOB (Product = 'FRAUDADVISOR' AND AccountID NOT IN FADOBOK), getDOB(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
IIDDOB := SORT(ITERATE(pDOB (Product = 'INSTANTID' AND AccountID NOT IN IIDDOBOK), getDOB(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
RVDOB := SORT(ITERATE(pDOB (Product = 'RISKVIEW' AND AccountID NOT IN RVDOBOK), getDOB(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];

emailRec getAddress(emailRec le, emailRec ri) := TRANSFORM
	SELF.email := le.email + 'Account: ' + ri.AccountID + ' | Login:' + padNumber(ri.LoginID) + ' Trans:' + padNumber((STRING)ri.TotalTransactions) + ' Trans Blank Addr:' + padNumber((STRING)ri.TransactionsAddressBlank) + ' % Blank Addr: ' + ri.PercentAddressBlank + '\n';
	SELF := ri;
END;

FAAddress := SORT(ITERATE(pAddress (Product = 'FRAUDADVISOR' AND AccountID NOT IN FAAddressOK), getAddress(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
IIDAddress := SORT(ITERATE(pAddress (Product = 'INSTANTID' AND AccountID NOT IN IIDAddressOK), getAddress(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
RVAddress := SORT(ITERATE(pAddress (Product = 'RISKVIEW' AND AccountID NOT IN RVAddressOK), getAddress(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];

emailRec getPhone(emailRec le, emailRec ri) := TRANSFORM
	SELF.email := le.email + 'Account: ' + ri.AccountID + ' | Login:' + padNumber(ri.LoginID) + ' Trans:' + padNumber((STRING)ri.TotalTransactions) + ' Trans Blank Phone:' + padNumber((STRING)ri.TransactionsBothPhonesBlank) + ' % Blank Phone: ' + ri.PercentBothPhonesBlank + '\n';
	SELF := ri;
END;

FAPhone := SORT(ITERATE(pPhone (Product = 'FRAUDADVISOR' AND AccountID NOT IN FAPhoneOK), getPhone(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
IIDPhone := SORT(ITERATE(pPhone (Product = 'INSTANTID' AND AccountID NOT IN FAPhoneOK), getPhone(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];
RVPhone := SORT(ITERATE(pPhone (Product = 'RISKVIEW' AND AccountID NOT IN FAPhoneOK), getPhone(LEFT, RIGHT)), -LENGTH(TRIM(email)))[1];

emailBody :=
'Scoring Account Monitoring' + '\n' +
'Report Run Date: ' + EndDate + '\n' +
'Key Build Date: ' + mostRecentDate + '\n' +
'\n\nPotential RiskView Account Issues\n' +
'==========================\n' +
IF(TRIM(RVNames.email) <> '', 'Missing First and Last Name:\n' + RVNames.email + '\n', '') +
IF(TRIM(RVSSN.email) <> '', 'Missing SSN:\n' + RVSSN.email + '\n', '') + 
IF(TRIM(RVDOB.email) <> '', 'Missing Date of Birth:\n' + RVDOB.email + '\n', '') +
IF(TRIM(RVAddress.email) <> '', 'Missing Full Address:\n' + RVAddress.email + '\n', '') +
IF(TRIM(RVPhone.email) <> '', 'Missing Home Phone and Work Phone:\n' + RVPhone.email + '\n', '') + '\n' +
'\n\nPotential FraudPoint Account Issues\n' +
'===========================\n' +
IF(TRIM(FANames.email) <> '', 'Missing First and Last Name:\n' + FANames.email + '\n', '') +
IF(TRIM(FASSN.email) <> '', 'Missing SSN:\n' + FASSN.email + '\n', '') + 
IF(TRIM(FADOB.email) <> '', 'Missing Date of Birth:\n' + FADOB.email + '\n', '') +
IF(TRIM(FAAddress.email) <> '', 'Missing Full Address:\n' + FAAddress.email + '\n', '') +
IF(TRIM(FAPhone.email) <> '', 'Missing Home Phone and Work Phone:\n' + FAPhone.email + '\n', '') + '\n' +
'\n\nPotential InstantID Account Issues\n' +
'==========================\n' +
IF(TRIM(IIDNames.email) <> '', 'Missing First and Last Name:\n' + IIDNames.email + '\n', '') +
IF(TRIM(IIDSSN.email) <> '', 'Missing SSN:\n' + IIDSSN.email + '\n', '') + 
IF(TRIM(IIDDOB.email) <> '', 'Missing Date of Birth:\n' + IIDDOB.email + '\n', '') +
IF(TRIM(IIDAddress.email) <> '', 'Missing Full Address:\n' + IIDAddress.email + '\n', '') +
IF(TRIM(IIDPhone.email) <> '', 'Missing Home Phone and Work Phone:\n' + IIDPhone.email + '\n', '') + '\n' +
'\n\n' +
'To view samples of these potential problems, Open Workunit ' + StringLib.StringToUpperCase(ThorLib.wuid()) + '\n  http://10.173.84.202:8010/?inner=../WsWorkunits/WUInfo?Wuid=' + StringLib.StringToUpperCase(ThorLib.wuid());

// OUTPUT(emailBody, NAMED('E_Mail_Body'));
// End of body generation

subject := 'Scoring Account Monitoring';

FileServices.SendEmail(Risk_Reporting.Constants.emailAccountMonitoringReportsTo, subject,
																		emailBody,
																		GETENV('SMTPserver'),
																		(UNSIGNED4)GETENV('SMTPport', '25'),
																		'ThorReport@lexisnexis.com');		