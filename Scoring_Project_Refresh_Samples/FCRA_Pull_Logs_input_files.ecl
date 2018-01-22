// EXPORT FCRA_Pull_Logs_input_files := 'todo';

#workunit('name', 'RiskView_refresh_input_samples');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Refresh_Samples, doxie;
//This fcra script will not create samples for 
//RV v3/v2 Capone  Scoring_Project_Refresh_Samples.RV_Capone_New_Samples_Logs


boolean RunAll							:= False;
boolean isexperianv3				:= True;
fileoldExperian := '~scoring_project::in::riskview_v3_xml_experian_attributes_20160419';
FileoutExperian := '~bb::in::test_RVv3Experian_new_test2';

//Also used for BS 41 and 50 samples 
boolean isfullinputRVGeneric	:= true;
fileoldRVGeneric := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20160419';
FileoutRVGeneric := '~bb::in::test_RVGeneric_new_test2'; 

BeginDate := '20160101'; // somehow set for 3 months from today.... 
EndDate := ut.getdate;  // current date

eyeball := 100;
AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

//should be able to run without changing anything below
//***************************************************************************************************************


File := Score_Logs.Files_index.File_TransactionID; 

File_FCRA := File(StringLib.StringToUpperCase(product) IN Score_Logs.FCRA_Transaction_Constants.product
and transaction_id not in set(Score_Logs.File_TransactionID_Removals,transaction_id));
LogFile := INDEX(File_FCRA, {transaction_id}, {File_FCRA}, ut.foreign_prod + 'thor_data400::key::acclogs_scoring::FCRA::'+doxie.Version_SuperKey+'::xml_transactionid');
	

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
		
	temp_riskview := parse(logs_temp, inputxml, parse_inputxml(), xml('RiskView'));
	
	self := temp_riskview[1];
	
	SELF := [];
END;

cleanLogs := project(Logs, parseInput(left));
OUTPUT(CHOOSEN(cleanLogs, eyeball), NAMED('cleanLogs'));

logsaccount := cleanLogs;

//***************************************************************************************************************
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

fullinputRVGeneric := Rvv4 + Rvv3;
OUTPUT(CHOOSEN(fullinputRVGeneric, eyeball), NAMED('fullinputRVGeneric'));


OriginalDataRVGeneric := DATASET(fileoldRVGeneric, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);

Scoring_Project_Refresh_Samples.FCRA_New_Samples_Logs.FCRA_New_Samples_Logs_RVGeneric(fullinputRVGeneric, OriginalDataRVGeneric, FileoutRVGeneric);
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