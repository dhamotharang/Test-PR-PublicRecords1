// EXPORT FCRA_Pull_Logs_input_files := 'todo';

#workunit('name', 'RiskView_refresh_input_samples');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Refresh_Samples, doxie;
//This fcra script will not create samples for 
//RV v3/v2 Capone  Scoring_Project_Refresh_Samples.RV_Capone_New_Samples_Logs


boolean RunAll							:= False;
boolean isexperianv3				:= False;
fileoldExperian := '~scoring_project::in::riskview_v3_xml_experian_attributes_20161017';
FileoutExperian := '~bb::in::test_RVv3Experian_new_test';

//Also used for BS 41 and 50 samples 
boolean isfullinputRVGeneric	:= true;
fileoldRVGeneric := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20161110';
FileoutRVGeneric := '~bb::in::test_RVGeneric_new_test2'; 

BeginDate := '20180101'; // somehow set for 3 months from today.... 
// EndDate := ut.getdate';  // current date
EndDate := '20180415';  // current date

eyeball := 100;
AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

//should be able to run without changing anything below
//***************************************************************************************************************


File := Score_Logs.Files_index.File_TransactionID; 

File_FCRA := File(StringLib.StringToUpperCase(product) IN Score_Logs.FCRA_Transaction_Constants.product
and transaction_id not in set(Score_Logs.File_TransactionID_Removals,transaction_id));
LogFile := INDEX(File_FCRA, {transaction_id}, {File_FCRA}, '~foreign::' + '10.173.44.105' + '::' + 'thor_data400::key::acclogs_scoring::FCRA::'+doxie.Version_SuperKey+'::xml_transactionid');
	

LogsRaw := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW', 'RISKVIEWATTRIBUTES'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW', 'RISKVIEWATTRIBUTES'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));




logs_raw_layout := record
	RECORDOF(LogsRaw);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;
	
Logs := PROJECT(LogsRaw, TRANSFORM(logs_raw_layout, 
																												inputXMLTemp1 := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView>', '<RiskView><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																												inputXMLTemp2 := StringLib.StringFindReplace(inputXMLTemp1, '<RiskViewAttributes>', '<RiskView><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																												SELF.inputxml := StringLib.StringFindReplace(inputXMLTemp2, '</RiskViewAttributes>', '</RiskView>'); 
																												SELF.outputxml := '<RiskView>' + LEFT.outputxml + '</RiskView>';
																												SELF.TransactionID := LEFT.Transaction_ID;
																												SELF.AccountID := LEFT.customer_id;
																												SELF.TransactionDate := LEFT.DateTime[1..8];
																												SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Logs'));


	
Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout parse_inputxml() := transform
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	self.attributeVersion := 	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest')));
	self.Auto						:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Auto')));
	self.Bank						:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/BankCard')));
	self.Money					:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/MoneyService')));
	self.Prescreen			:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Prescreen')));
	self.Telecom				:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Telecom')));
	self.Retail					:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Retail')));
	self.Custom					:= 	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[1]/OptionValue')));
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
	self := [];
end;	

Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout parseInput (Logs l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_temp := project(ut.ds_oneRecord, transform(logs_raw_layout,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_riskview := parse(logs_temp, inputxml, parse_inputxml(), xml('RiskViewAttributesRequest'));
	
	self := temp_riskview[1];
	
	SELF := [];
END;

cleanLogs := project(Logs, parseInput(left));
OUTPUT(CHOOSEN(cleanLogs, eyeball), NAMED('cleanLogs'));

logsaccount := cleanLogs;

//***************************************************************************************************************
LogsRaw_RVv5 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW2'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW2'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layout_v5 := record
	RECORDOF(LogsRaw_RVv5);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;

// Logs_2 := PROJECT(LogsRaw_RVv5, TRANSFORM(logs_raw_layout_v5, STRING30 TransactionID, STRING10 AccountID, STRING25 LoginID, STRING8 TransactionDate}, 
				// SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView2Request>', '<RiskView2Request><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				// SELF.outputxml := '<RiskView2>' + LEFT.outputxml + '</RiskView2>';
				// SELF.TransactionID := LEFT.Transaction_ID;
				// SELF.AccountID := LEFT.customer_id;
				// SELF.LoginID := LEFT.Login_ID;
				// SELF.TransactionDate := LEFT.DateTime[1..8];
				// SELF := LEFT));

Logs_2 := PROJECT(LogsRaw_RVv5, TRANSFORM(logs_raw_layout_v5, 
																												inputXMLTemp1 := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView2>', '<RiskView2><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																												inputXMLTemp2 := StringLib.StringFindReplace(inputXMLTemp1, '<RiskViewAttributes>', '<RiskView2><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																												SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView2Request>', '<RiskView2Request><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
																												SELF.outputxml := '<RiskView2>' + LEFT.outputxml + '</RiskView2>';
																												SELF.TransactionID := LEFT.Transaction_ID;
																												SELF.AccountID := LEFT.customer_id;
																												SELF.TransactionDate := LEFT.DateTime[1..8];
																												SELF := LEFT));

OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Raw_Logs_2'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout parse_inputxml_v5 () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	// SELF.EndUserCompanyName := TRIM(XMLTEXT('User/EndUser/CompanyName'));
		SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
self.attributeVersion := 	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest')));
	self.Auto						:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Names/Name[1]')));
	self.Bank						:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Names/Name[2]')));
	self.Money					:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Names/Name[3]')));
	self.Prescreen			:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Names/Name[4]')));
	self.Telecom				:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Names/Name[5]')));
	self.Retail					:=	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Names/Name[6]')));
	self.Custom					:= 	StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/ModelRequests/ModelRequest[1]/ModelOptions/ModelOption[1]/OptionValue')));
	
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


Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout parseInput_v5 (Logs l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_temp_v5 := project(ut.ds_oneRecord, transform(logs_raw_layout_v5,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_riskview_v5 := parse(logs_temp_v5, inputxml, parse_inputxml_v5(), xml('RiskView2Request'));
	
	self := temp_riskview_v5[1];
	
	SELF := [];
END;

cleanLogs_v5 := project(Logs_2, parseInput_v5(left));
// OUTPUT(CHOOSEN(cleanLogs_v5, eyeball), NAMED('cleanLogs_v5'));

logsaccount_v5 := cleanLogs_v5;

// models := ['RVA1503_0','RVB1503_0','RVG1502_0','RVT1503_0','RVS1706_0'];

// v5_sample := logsaccount_v5(attributeVersion = 'RISKVIEWATTRV5');
// v5_sample_models1 := v5_sample((auto in models) or (bank in models) or (money in models) or (prescreen in models) or (telecom in models) or (retail in models) or (custom in models));
// OUTPUT(CHOOSEN(v5_sample_models1, eyeball), NAMED('v5_sample_models1'));

//***************************************************************************************************************

//experian xml only v3
#if(isexperianv3 or RunAll)

experianv3 := LogsAccount(attributeVersion = 'VERSION3' and AccountID = '108006');
OUTPUT(CHOOSEN(experianv3, eyeball), NAMED('experianv3'));
// output(experianv3(dob <> ''));
// output(count(experianv3(dob <> '')));

OriginalDataExperian := DATASET(fileoldExperian, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);


Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_experian(experianv3, OriginalDataExperian, FileoutExperian);
#end
//***************************************************************************************************************
//RVGeneric
//also used for BS FCRA and NonFCRA sample, 41 and 50
#if(isfullinputRVGeneric or RunAll)

Rvv4 := LogsAccount((Auto = 'RVA1104_0' or  Bank = 'RVB1104_0' or Money = 'RVG1103_0' or Prescreen = 'RVP1104_0' or Retail = 'RVR1103_0' or Telecom = 'RVT1104_0') and attributeVersion = 'VERSION4');
Rvv3 := LogsAccount((Auto = 'RVA1003_0' or  Bank = 'RVB1003_0' or Money = 'RVG1003_0' or Prescreen = 'RVP1003_0' or Retail = 'RVR1003_0' or Telecom = 'RVT1003_0') and attributeVERSION = 'VERSION3');
models := ['RVA1503_0','RVB1503_0','RVG1502_0','RVT1503_0','RVS1706_0'];

v5_sample := logsaccount_v5(attributeVersion = 'RISKVIEWATTRV5');
Rvv5 := v5_sample((auto in models) or (bank in models) or (money in models) or (prescreen in models) or (telecom in models) or (retail in models) or (custom in models));

fullinputRVGeneric := Rvv5 + Rvv4 + Rvv3;
// OUTPUT(CHOOSEN(Rvv5, eyeball), NAMED('Rvv5'));

OUTPUT(CHOOSEN(Rvv3, eyeball), NAMED('Rvv3'));
OUTPUT(CHOOSEN(Rvv4, eyeball), NAMED('Rvv4'));
OUTPUT(CHOOSEN(Rvv5, eyeball), NAMED('Rvv5'));


OriginalDataRVGeneric := DATASET(fileoldRVGeneric, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);

Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_RVGeneric(fullinputRVGeneric, OriginalDataRVGeneric, FileoutRVGeneric);
// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_RVGeneric(Rvv3,Rvv4,Rvv5, OriginalDataRVGeneric, FileoutRVGeneric);
#end


//***************************************************************************************************************
//credit acceptance v2, attributeVersion = 'VERSION2'

// creditacceptancev2 := LogsAccount(AccountID = '104191');
// OUTPUT(CHOOSEN(creditacceptancev2, eyeball), NAMED('creditacceptancev2'));

// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_creditacceptance(creditacceptancev2);
//***************************************************************************************************************

//Santander RVA1304_1

// Santander1 := LogsAccount(Custom = 'RVA1304_1');
// OUTPUT(CHOOSEN(Santander1, eyeball), NAMED('Santander1'));

// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_Santander1(Santander1);


//***************************************************************************************************************

//Santander RVA1304_2

// Santander2 := LogsAccount(Custom = 'RVA1304_2');
// OUTPUT(CHOOSEN(Santander2, eyeball), NAMED('Santander2'));

// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_Santander2(Santander1);


//***************************************************************************************************************

//RVv4 Enova RVG1103_0

// Enova := LogsAccount(accountid = '112605' and Money = 'RVG1103_0' and attributeVersion = 'VERSION4');
// OUTPUT(CHOOSEN(Enova, eyeball), NAMED('Enova'));

// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_Enova(Enova);

//***************************************************************************************************************

//Regional Acceptance rva1008_1

// RegionalAcceptance := LogsAccount(Custom = 'RVA1008_1');
// OUTPUT(CHOOSEN(RegionalAcceptance, eyeball), NAMED('RegionalAcceptance'));

// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_RegionalAcceptance(RegionalAcceptance);
//***************************************************************************************************************

//Tmobile RVT1210_1

// Tmobile1210 := LogsAccount(accountid = '103981' and Custom = 'RVT1210_1' );
// OUTPUT(CHOOSEN(Tmobile1210, eyeball), NAMED('Tmobile1210'));

// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_Tmobile1210(Tmobile1210);
//***************************************************************************************************************

// Tmobile RVT1212_1

// Tmobile1212 := LogsAccount(accountid = '103981' and Custom = 'RVT1212_1' );
// OUTPUT(CHOOSEN(Tmobile1212, eyeball), NAMED('Tmobile1212'));


// Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_Tmobile1212(Tmobile1212);
// //***************************************************************************************************************

// WHEN(CRON('05 0 1 0-12/3 *')), // would like to set for once every 4 months.... not sure how to do this.
// FAILURE(FileServices.SendEmail( 'bridgett.braaten@lexisnexis.com','input sample collection failed','The failed workunit is:' + workunit + FailMessage));