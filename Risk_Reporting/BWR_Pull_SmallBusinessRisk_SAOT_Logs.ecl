#workunit('name', 'Small_Business_Risk_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20140310';
EndDate := '20140312';

AccountIDs := ['1581945']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 100;

outputFile := '~bpahl::out::Small_Business_Risk_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSRISK'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['SMALLBUSINESSRISK'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

linerec := {STRING line};

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<SmallBusinessRisk>', '<SmallBusinessRisk><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<SmallBusinessRisk>' + LEFT.outputxml + '</SmallBusinessRisk>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Yesterday_Logs'));

Risk_Reporting.Layouts.Parsed_SmallBusinessRisk_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.CompanyName					:= TRIM(XMLTEXT('SearchBy/Business/Name'));
	SELF.CompanyAddress				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Business/Address/StreetAddress1'), XMLTEXT('SearchBy/Business/Address/StreetAddress2'));
	SELF.CompanyCity					:= TRIM(XMLTEXT('SearchBy/Business/Address/City'));
	SELF.CompanyState					:= TRIM(XMLTEXT('SearchBy/Business/Address/State'));
	SELF.CompanyZIP						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Business/Address/Zip5'));
	SELF.FEIN									:= TRIM(XMLTEXT('SearchBy/Business/FEIN'));
	SELF.CompanyPhone10				:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Business/Phone10'));
	SELF.RepFirstName					:= TRIM(XMLTEXT('SearchBy/OwnerAgent/Name/First'));
	SELF.RepLastName					:= TRIM(XMLTEXT('SearchBy/OwnerAgent/Name/Last'));
	SELF.RepSSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/OwnerAgent/SSN'));
	SELF.RepDOB								:= Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/OwnerAgent/DOB/Year'), XMLTEXT('SearchBy/OwnerAgent/DOB/Month'), XMLTEXT('SearchBy/OwnerAgent/DOB/Day'));
	SELF.RepAddress						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/OwnerAgent/Address/StreetAddress1'), XMLTEXT('SearchBy/OwnerAgent/Address/StreetAddress2'));
	SELF.RepCity							:= TRIM(XMLTEXT('SearchBy/OwnerAgent/Address/City'));
	SELF.RepState							:= TRIM(XMLTEXT('SearchBy/OwnerAgent/Address/State'));
	SELF.RepZip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/OwnerAgent/Address/Zip5'));
	SELF.RepDL								:= TRIM(XMLTEXT('SearchBy/OwnerAgent/DriverLicenseNumber'));
	SELF.RepDLState						:= TRIM(XMLTEXT('SearchBy/OwnerAgent/DriverLicenseState'));
	SELF.RepPhone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/OwnerAgent/Phone10'));
	
	SELF := [];
END;
parsedInput := PARSE(Logs, inputxml, parseInput(), XML('SmallBusinessRisk'));

OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));

Risk_Reporting.Layouts.Parsed_SmallBusinessRisk_Layout parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together

	SELF.ModelName		:= TRIM(XMLTEXT('Result/Models/Model[1]/Name'));
	SELF.ModelScore		:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/Value'));
	SELF.ModelType		:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/Type'));
	SELF.BusinessRC1	:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[1]/RiskCode'));
	SELF.BusinessRC2	:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[2]/RiskCode'));
	SELF.BusinessRC3	:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[3]/RiskCode'));
	SELF.BusinessRC4	:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[4]/RiskCode'));
	SELF.BusinessRC5	:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[5]/RiskCode'));
	SELF.BusinessRC6	:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/BusinessHighRiskIndicators/HighRiskIndicator[6]/RiskCode'));
	SELF.RepRC1				:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/OwnerAgentHighRiskIndicators/HighRiskIndicator[1]/RiskCode'));
	SELF.RepRC2				:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/OwnerAgentHighRiskIndicators/HighRiskIndicator[2]/RiskCode'));
	SELF.RepRC3				:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/OwnerAgentHighRiskIndicators/HighRiskIndicator[3]/RiskCode'));
	SELF.RepRC4				:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/OwnerAgentHighRiskIndicators/HighRiskIndicator[4]/RiskCode'));
	SELF.RepRC5				:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/OwnerAgentHighRiskIndicators/HighRiskIndicator[5]/RiskCode'));
	SELF.RepRC6				:= TRIM(XMLTEXT('Result/Models/Model[1]/Scores/Score[1]/OwnerAgentHighRiskIndicators/HighRiskIndicator[6]/RiskCode'));

	SELF := [];
END;
parsedOutput := PARSE(Logs, outputxml, parseOutput(), XML('SmallBusinessRisk'));

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_SmallBusinessRisk_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_SmallBusinessRisk_Layout le, Risk_Reporting.Layouts.Parsed_SmallBusinessRisk_Layout ri) := TRANSFORM
	SELF.ModelName		:= ri.ModelName	  ;
	SELF.ModelScore		:= ri.ModelScore	;
	SELF.ModelType		:= ri.ModelType	  ;
	SELF.BusinessRC1	:= ri.BusinessRC1 ;
	SELF.BusinessRC2	:= ri.BusinessRC2 ;
	SELF.BusinessRC3	:= ri.BusinessRC3 ;
	SELF.BusinessRC4	:= ri.BusinessRC4 ;
	SELF.BusinessRC5	:= ri.BusinessRC5 ;
	SELF.BusinessRC6	:= ri.BusinessRC6 ;
	SELF.RepRC1				:= ri.RepRC1			;
	SELF.RepRC2				:= ri.RepRC2			;
	SELF.RepRC3				:= ri.RepRC3			;
	SELF.RepRC4				:= ri.RepRC4			;
	SELF.RepRC5				:= ri.RepRC5			;
	SELF.RepRC6				:= ri.RepRC6			;
	
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
