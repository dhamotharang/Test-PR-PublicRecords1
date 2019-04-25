// EXPORT NonFCRA_Pull_Logs_input_files := 'todo';

#workunit('name', 'NonFCRA_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Refresh_Samples, doxie;
//Creates input samples for:
//FP v201 XML
//LIV4 
//BNK4
//PI02
//BIID XML
//IID 

//This nonfcra script will not create samples for 
//CBBL									use Scoring_Project_Refresh_Samples.CBBL_New_Samples_Logs.
//IID Batch Generic  		use Scoring_Project_Refresh_Samples.IID_Batch_New_Samples_Logs.
//BIID Batch Generic 		is pulled from BIID XML for now. 
//BIID Batch Chase 			comming soon.
//ITA v3 Batch 					use Scoring_Project_Refresh_Samples.ITA_v3_Capone_New_Samples_Logs.



Boolean RunAll 						:= false;

Boolean isFraudPointv201 		:= false;
fileoldFPv2_2 := '~scoring_project::in:fraudpoint_xml_American_Express_fp1109_0_20161206';
FileoutFPv2_2 := '~bb::in::fraudpoint_xml_American_Express_test';

Boolean isFraudPoint31505   := false;
fileoldFPv3 := '~Scoring_Project::in::FraudPoint_XML_FP31505_0_20161220';
FileoutFPv3 := '~bbraaten::in::FraudPoint_XML_FP31505_0_test';

Boolean isLeadIntegrityv4 := false;
fileoldLI_v4 := '~scoring_project::in::leadintegrity_xml_generic_msn1210_1_20161206';
FileoutLI_v4 := '~bb::in::leadintegrity_xml_generic_msn1210_test';

Boolean isBNK4 						:= false;
fileoldBNK4 := '~scoring_project::in::bc1o_xml_chase_bnk4_20160525';
NewFileBNK4 := '~bb::in::bc1o_xml_chase_bnk4_test';

Boolean isCBBL        := false;
fileoldCBBL := '~scoring_project::in::cbbl_xml_chase_20160525';
NewFileCBBL := '~bb::in::cbbl_xml_chase_test';

Boolean isPI02 						:= false;
fileoldPI02 := '~scoring_project::in::prio_xml_chase_pi02_20161206';
FileoutPI02 := '~bbn::in::prio_xml_chase_pi02_test';

boolean isBIID						:= false;
fileoldBIID	:= '~scoring_project::in::biid_xml_general_generic_20160602';
fileoutBIID	:= '~bb::in::BIID_Batch_test';

boolean isIID							:= true;
fileoldIID  := '~scoring_project::in::instantid_xml_generic_version0_20161215';
fileoutIID	 := '~bb::in::IID_xml_test2';

BeginDate := '20180301';
// EndDate := ut.getdate;
EndDate := '20180401';

AccountIDs := ['']; // leave this alone
eyeball := 300;

//should be able to run without changing anything below
//***************************************************************************************************************

File := Score_Logs.Files_index.File_TransactionID; 
File_nonFCRA := File(StringLib.StringToUpperCase(product) NOT IN Score_Logs.FCRA_Transaction_Constants.product);
// LogFile := INDEX(File_nonFCRA, {transaction_id}, {File_nonFCRA}, '~foreign::' + '10.173.44.105' + '::'+'thor_data400::key::acclogs_scoring::'+doxie.Version_SuperKey+'::xml_transactionid');
LogFile := INDEX(File_nonFCRA, {transaction_id}, {File_nonFCRA}, '~foreign::' + '10.173.44.105' + '::' +'thor_data400::key::acclogs_scoring::20180506::xml_transactionid');

//**********************************************************************************************************************************
																			// 
#if(isFraudPointv201 or RunAll)
LogsRawFPv2 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutFPv2 := record
	RECORDOF(LogsRawFPv2);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;
	

LogsFPv2 := PROJECT(LogsRawFPv2, TRANSFORM(logs_raw_layoutFPv2, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FraudPoint>', '<FraudPoint><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<FraudPoint>' + LEFT.outputxml + '</FraudPoint>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));																					
																											
																											
OUTPUT(CHOOSEN(LogsFPv2, eyeball), NAMED('Sample_Raw_Logs'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout parse_inputxmlFPv2 () := TRANSFORM
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
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	self.FP_Model				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/FraudPointModel')));
	self.FP_Attributes	:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/FraudAttributesRequests/name')));
	self.FP_Attributes2	:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest')));
	SELF := [];
END;

Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout parseInputFPv2 (LogsFPv2 l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_tempFPv2 := project(ut.ds_oneRecord, transform(logs_raw_layoutFPv2,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_FPv2 := parse(logs_tempFPv2, inputxml, parse_inputxmlFPv2(), XML('FraudPointRequest'));
	
	self := temp_FPv2[1];
	
	SELF := [];
END;

cleanLogsFPv2 := project(LogsFPv2, parseInputFPv2(left));
OUTPUT(CHOOSEN(cleanLogsFPv2, eyeball), NAMED('cleanLogs'));



logsaccountFPv2 := cleanLogsFPv2;



// FPv2_2

// FPv2_2 := logsaccountFPv2(FP_Attributes = 'FRAUDPOINTATTRV2' and FP_Model = 'FP1109_0');
// OUTPUT(CHOOSEN(FPv2_2, eyeball), NAMED('FRAUDPOINTATTRV2'));

//FPv201
FPv2_AmericanExpress := logsaccountFPv2(FP_Attributes2 = 'FRAUDPOINTATTRV201');
OUTPUT(CHOOSEN(FPv2_AmericanExpress, eyeball), NAMED('FraudPointAttrv201'));
OUTPUT(count(FPv2_AmericanExpress));

FPv2_AmericanExpress_model := FPv2_AmericanExpress(fp_model = 'FP1109_0');
OUTPUT(CHOOSEN(FPv2_AmericanExpress_model, eyeball), NAMED('FPv2_AmericanExpress_model'));
OUTPUT(count(FPv2_AmericanExpress_model));

OriginalDataFPv2_2 := DATASET(fileoldFPv2_2, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);

Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_FPv2_2(FPv2_AmericanExpress_model, OriginalDataFPv2_2, FileoutFPv2_2);

#end




//**********************************************************************************************************************************
#if (isFraudPoint31505 or RunAll)
LogsRawFraud := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['FRAUDPOINT'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutFraud := record
	RECORDOF(LogsRawFraud);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;

LogsFraud := PROJECT(LogsRawFraud, TRANSFORM(logs_raw_layoutFraud, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<FraudPoint>', '<FraudPoint><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<FraudPoint>' + LEFT.outputxml + '</FraudPoint>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));																					
																											
																											
OUTPUT(CHOOSEN(LogsFraud, eyeball), NAMED('Sample_Raw_LogsFraud'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout parse_inputxmlFraud () := TRANSFORM
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
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/Phone10'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WPhone10'));
	self.FP_Model				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/FraudPointModel')));
	self.FP_Model2				:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/OptionValue/ModelOption/ModelOptions')));
	self.FP_Attributes	:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/FraudAttributesRequests/name')));
	self.FP_Attributes2	:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest')));

	SELF := [];
END;

Scoring_Project_Refresh_Samples.New_Samples_layouts.FraudAdvisor_Layout parseInputFraud (LogsFraud l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_temp := project(ut.ds_oneRecord, transform(logs_raw_layoutFraud,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_Fraud := parse(logs_temp, inputxml, parse_inputxmlFraud(), XML('FraudPointRequest'));
	
	self := temp_Fraud[1];
	
	SELF := [];
END;

cleanLogsFraud := project(LogsFraud, parseInputFraud(left));
OUTPUT(CHOOSEN(cleanLogsFraud, eyeball), NAMED('cleanLogsFraud'));


logsaccountFraud := cleanLogsFraud;




FPv3 := logsaccountFraud( FP_Model = 'FP31505_0');
OUTPUT(CHOOSEN(FPv3, eyeball), NAMED('FPv3'));

OriginalDataFPv3 := DATASET(fileoldFPv3, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);


Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_FPv3(FPv3, OriginalDataFPv3, FileoutFPv3);


#end
//**********************************************************************************************************************************


#if(isLeadIntegrityv4 or RunAll)
LogsRawLIv4 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['LEADINTEGRITY'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['LEADINTEGRITY'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

	
logs_raw_layoutLIv4 := record
	RECORDOF(LogsRawLIv4);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;
	

LogsLIv4 := PROJECT(LogsRawLIv4, TRANSFORM(logs_raw_layoutLIv4, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<LeadIntegrity>', '<LeadIntegrity><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<LeadIntegrity>' + LEFT.outputxml + '</LeadIntegrity>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));				
	
OUTPUT(CHOOSEN(LogsLIv4, eyeball), NAMED('Sample_LogsLI'));


Scoring_Project_Refresh_Samples.New_Samples_layouts.LeadIntegrity_Layout parse_inputxmlLIv4 () := TRANSFORM
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
	SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	self.LI_AttributeVersion		:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/AttributesVersionRequest')));
	self.LI_Model								:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/Integrity')));
	SELF := [];
END;

Scoring_Project_Refresh_Samples.New_Samples_layouts.LeadIntegrity_Layout parseInputLIv4 (LogsLIv4 l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_tempLIv4 := project(ut.ds_oneRecord, transform(logs_raw_layoutLIv4,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_LIv4 := parse(logs_tempLIv4, inputxml, parse_inputxmlLIv4(), XML('LeadIntegrityRequest'));
	
	self := temp_LIv4[1];
	
	SELF := [];
END;

cleanLogsLIv4 := project(LogsLIv4, parseInputLIv4(left));
OUTPUT(CHOOSEN(cleanLogsLIv4, eyeball), NAMED('cleanLogsLI'));

logsaccountLIv4 := cleanLogsLIv4;

LI_v4 := logsaccountLIv4(LI_AttributeVersion = 'LEADINTEGRITYATTRV4' or LI_Model = 'MSN1106_0' or (LI_AttributeVersion = 'LEADINTEGRITYATTRV4' and LI_Model = 'MSN1106_0'));
OUTPUT(CHOOSEN(LI_v4, eyeball), NAMED('LEADINTEGRITYATTRV4_model'));

OriginalDataLI_v4 := DATASET(fileoldLI_v4, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);


Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_LI_v4(LI_v4, OriginalDataLI_v4, FileoutLI_v4);

#end

//**********************************************************************************************************************************

#if(isBNK4 or RunAll)
LogsRawBC10 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINBC1O'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINBC1O'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutBC10 := record
	RECORDOF(LogsRawBC10);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;

LogsBC10 := PROJECT(LogsRawBC10, TRANSFORM(logs_raw_layoutBC10, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainBC1O>', '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainBC1O>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(LogsBC10, eyeball), NAMED('LogsBC10'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout parse_inputxmlBC10 () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF._LoginId            := StringLib.StringToUpperCase(TRIM(XMLTEXT('_LoginId')));
	SELF.TribCode            := StringLib.StringToUpperCase(TRIM(XMLTEXT('tribcode')));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.LastName            := TRIM(XMLTEXT('last'));
	SELF.Address             := TRIM(XMLTEXT('addr'));
	SELF.City                := TRIM(XMLTEXT('city'));
	SELF.State               := TRIM(XMLTEXT('state'));
	SELF.Zip                 := Risk_Reporting.Common.ParseZIP(TRIM(XMLTEXT('zip')));
	SELF.SSN                 := Risk_Reporting.Common.ParseSSN(TRIM(XMLTEXT('socs')));
	SELF.DateOfBirth         := TRIM(XMLTEXT('dob'));
	SELF.HomePhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('hphone'));
	SELF.WorkPhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('wphone'));
	SELF.Income              := TRIM(XMLTEXT('income'));
	SELF.CompanyName			   := TRIM(XMLTEXT('cmpy'));
	SELF.CompanyAddress	     := TRIM(XMLTEXT('cmpyaddr'));
	SELF.CompanyCity			   := TRIM(XMLTEXT('cmpycity'));
	SELF.CompanyState		     := TRIM(XMLTEXT('cmpystate'));
	SELF.CompanyZIP			     := TRIM(XMLTEXT('cmpyzip'));
	SELF.FEIN						     := TRIM(XMLTEXT('fin'));
	SELF := [];
END;


Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout parseInputBC10 (LogsBC10 l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_tempBC10 := project(ut.ds_oneRecord, transform(logs_raw_layoutBC10,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_BC10 := parse(logs_tempBC10, inputxml, parse_inputxmlBC10(), XML('RiskWise.RiskWiseMainBC1O'));
	
	self := temp_BC10[1];
	
	SELF := [];
END;

cleanLogsBC10:= project(LogsBC10, parseInputBC10(left));
OUTPUT(CHOOSEN(cleanLogsBC10, eyeball), NAMED('cleanLogsBC10'));


logsaccountBC10:= cleanLogsBC10;

BNK4_2 := logsaccountBC10(TribCode = 'BNK4');
BNK4 := BNK4_2(accountid = '101130');
OUTPUT(CHOOSEN(BNK4, eyeball), NAMED('BNK4'));


OriginalDataBNK4 := DATASET(fileoldBNK4, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4, thor);


Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_BNk4(BNk4, OriginalDataBNK4, NewFileBNK4);

#end

//**********************************************************************************************************************************

#if(isCBBL or RunAll)
LogsRawBC10_CBBL := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINBC1O'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINBC1O'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutBC10_CBBL := record
	RECORDOF(LogsRawBC10_CBBL);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;

LogsBC10_CBBL := PROJECT(LogsRawBC10_CBBL, TRANSFORM(logs_raw_layoutBC10_CBBL, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainBC1O>', '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainBC1O>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(LogsBC10_CBBL, eyeball), NAMED('LogsBC10_CBBL'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout parse_inputxmlBC10_cbbl () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF._LoginId            := StringLib.StringToUpperCase(TRIM(XMLTEXT('_LoginId')));
	SELF.TribCode            := StringLib.StringToUpperCase(TRIM(XMLTEXT('tribcode')));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.LastName            := TRIM(XMLTEXT('last'));
	SELF.Address             := TRIM(XMLTEXT('addr'));
	SELF.City                := TRIM(XMLTEXT('city'));
	SELF.State               := TRIM(XMLTEXT('state'));
	SELF.Zip                 := Risk_Reporting.Common.ParseZIP(TRIM(XMLTEXT('zip')));
	SELF.SSN                 := Risk_Reporting.Common.ParseSSN(TRIM(XMLTEXT('socs')));
	SELF.DateOfBirth         := TRIM(XMLTEXT('dob'));
	SELF.HomePhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('hphone'));
	SELF.WorkPhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('wphone'));
	SELF.Income              := TRIM(XMLTEXT('income'));
	SELF.CompanyName			   := TRIM(XMLTEXT('cmpy'));
	SELF.CompanyAddress	     := TRIM(XMLTEXT('cmpyaddr'));
	SELF.CompanyCity			   := TRIM(XMLTEXT('cmpycity'));
	SELF.CompanyState		     := TRIM(XMLTEXT('cmpystate'));
	SELF.CompanyZIP			     := TRIM(XMLTEXT('cmpyzip'));
	SELF.FEIN						     := TRIM(XMLTEXT('fin'));
	SELF := [];
END;


Scoring_Project_Refresh_Samples.New_Samples_layouts.BNK4_CBBL_Layout parse_inputxmlBC10cbbl (LogsBC10_CBBL l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_tempBC10_CBBL := project(ut.ds_oneRecord, transform(logs_raw_layoutBC10_CBBL,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_BC10_CBBL := parse(logs_tempBC10_CBBL, inputxml, parse_inputxmlBC10_CBBL(), XML('RiskWise.RiskWiseMainBC1O'));
	
	self := temp_BC10_CBBL[1];
	
	SELF := [];
END;

cleanLogsBC10_CBBL:= project(LogsBC10_CBBL, parse_inputxmlBC10cbbl(left));
OUTPUT(CHOOSEN(cleanLogsBC10_CBBL, eyeball), NAMED('cleanLogsBC10_CBBL'));


logsaccountBC10_CBBL:= cleanLogsBC10_CBBL;

CBBL_2 := logsaccountBC10_CBBL(TribCode = 'CBBL');
CBBL := CBBL_2(accountid = '104706');
OUTPUT(CHOOSEN(CBBL_2, eyeball), NAMED('CBBL'));


OriginalDataCBBL := DATASET(fileoldCBBL, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4, thor);


Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_CBBL(CBBL_2, OriginalDataCBBL, NewFileCBBL);

#end

//**********************************************************************************************************************************


#if(isPI02 or RunAll)

LogsRawPI02 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINPRIO'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINPRIO'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutPI02 := record
	RECORDOF(LogsRawPI02);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;

LogsPI02 := PROJECT(LogsRawPI02, TRANSFORM(logs_raw_layoutPI02, 																		
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainPRIO>', '<RiskWise.RiskWiseMainPRIO><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainPRIO><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainPRIO>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(LogsPI02, eyeball), NAMED('LogsPI02'));

Scoring_Project_Refresh_Samples.New_Samples_layouts.PI02_layout parse_inputxmlPI02 () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF._LoginId            := StringLib.StringToUpperCase(TRIM(XMLTEXT('_LoginId')));
	SELF.TribCode            := StringLib.StringToUpperCase(TRIM(XMLTEXT('tribcode')));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.MiddleName					 := TRIM(XMLTEXT('middleini'));
	SELF.LastName            := TRIM(XMLTEXT('last'));
	SELF.Address             := TRIM(XMLTEXT('addr'));
	SELF.City                := TRIM(XMLTEXT('city'));
	SELF.State               := TRIM(XMLTEXT('state'));
	SELF.Zip                 := Risk_Reporting.Common.ParseZIP(TRIM(XMLTEXT('zip')));
	SELF.SSN                 := Risk_Reporting.Common.ParseSSN(TRIM(XMLTEXT('socs')));
	SELF.DateOfBirth         := TRIM(XMLTEXT('dob'));
	SELF.HomePhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('hphone'));
	SELF.WorkPhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('wphone'));
	SELF.Income              := TRIM(XMLTEXT('income'));
	SELF.CompanyName			   := TRIM(XMLTEXT('cmpy'));
	
	SELF := [];
END;
Scoring_Project_Refresh_Samples.New_Samples_layouts.PI02_layout parseInputPI02 (LogsPI02 l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_tempPI02 := project(ut.ds_oneRecord, transform(logs_raw_layoutPI02,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_PI02 := parse(logs_tempPI02, inputxml, parse_inputxmlPI02(), XML('RiskWise.RiskWiseMainPRIO'));
	
	self := temp_PI02[1];
	
	SELF := [];
END;

cleanLogsPI02:= project(LogsPI02, parseInputPI02(left));
OUTPUT(CHOOSEN(cleanLogsPI02, eyeball), NAMED('cleanLogsPI02'));


logsaccountPI02:= cleanLogsPI02;

OriginalDataPI02 := DATASET(fileoldPI02, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);

PI02_2 := logsaccountPI02(TribCode = 'PI02');
PI02 := PI02_2(accountid = '101130');

OUTPUT(CHOOSEN(PI02, eyeball), NAMED('PI02'));


Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_PI02(PI02, OriginalDataPI02, FileoutPI02);

#end

//**********************************************************************************************************************************


#if(isBIID or RunAll)

LogsRawBIID := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSINSTANTID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSINSTANTID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutBIID := record
	RECORDOF(LogsRawBIID);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;
	

LogsBIID := PROJECT(LogsRawBIID, TRANSFORM(logs_raw_layoutBIID, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<BusinessInstantID>', '<BusinessInstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<BusinessInstantID>' + LEFT.outputxml + '</BusinessInstantID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(LogsBIID, eyeball), NAMED('LogsBIID'));


Scoring_Project_Refresh_Samples.New_Samples_layouts.BusinessIID_Layout parse_inputxmlBIID () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.CompanyName					:= TRIM(XMLTEXT('SearchBy/CompanyName'));
	SELF.CompanyAddress				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/CompanyAddress/StreetAddress1'), XMLTEXT('SearchBy/CompanyAddress/StreetAddress2'));
	SELF.CompanyCity					:= TRIM(XMLTEXT('SearchBy/CompanyAddress/City'));
	SELF.CompanyState					:= TRIM(XMLTEXT('SearchBy/CompanyAddress/State'));
	SELF.CompanyZIP						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/CompanyAddress/Zip5'));
	SELF.FEIN									:= TRIM(XMLTEXT('SearchBy/FEIN'));
	SELF.CompanyPhone10				:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/CompanyPhone'));
	SELF.RepFirstName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/First'));
	SELF.RepLastName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/Last'));
	SELF.RepSSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/AuthorizedRepresentative/SSN'));
	SELF.RepDOB								:= Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Year'), XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Month'), XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Day'));
	SELF.RepAddress						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/StreetAddress1'), XMLTEXT('SearchBy/AuthorizedRepresentative/Address/StreetAddress2'));
	SELF.RepCity							:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/City'));
	SELF.RepState							:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/State'));
	SELF.RepZip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/Zip5'));
	SELF.RepDL								:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/DriverLicenseNumber'));
	SELF.RepDLState						:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/DriverLicenseState'));
	SELF.RepPhone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/AuthorizedRepresentative/Phone10'));
	
	SELF := [];
END;

Scoring_Project_Refresh_Samples.New_Samples_layouts.BusinessIID_Layout parseInputBIID (LogsBIID l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_tempBIID := project(ut.ds_oneRecord, transform(logs_raw_layoutBIID,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_BIID := parse(logs_tempBIID, inputxml, parse_inputxmlBIID(), XML('BusinessInstantIDRequest'));
	
	self := temp_BIID[1];
	
	SELF := [];
END;

cleanLogsBIID := project(LogsBIID, parseInputBIID(left));
OUTPUT(CHOOSEN(cleanLogsBIID, eyeball), NAMED('cleanLogsBIID'));

BIID := cleanLogsBIID;

OriginalDataBIID := DATASET(fileoldBIID, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structureBNK4, thor);

Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_BIID(BIID, OriginalDataBIID, fileoutBIID);

#end












//**********************************************************************************************************************************
#if(isIID or RunAll)

LogsRawIID := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['INSTANTID', 'INSTANTIDMODEL'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['INSTANTID', 'INSTANTIDMODEL'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

logs_raw_layoutIID := record
	RECORDOF(LogsRawIID);
	STRING30 TransactionID; 
	STRING10 AccountID;
	STRING8 TransactionDate;
end;
	

LogsIID := PROJECT(LogsRawIID, TRANSFORM(logs_raw_layoutIID, 
																		inputXMLTemp1 := StringLib.StringFindReplace(LEFT.inputxml, '<InstantID>', '<InstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		inputXMLTemp2 := StringLib.StringFindReplace(inputXMLTemp1, '<InstantIDModel>', '<InstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.inputxml := StringLib.StringFindReplace(inputXMLTemp2, '</InstantIDModel>', '</InstantID>'); 
																		SELF.outputxml := '<InstantID>' + LEFT.outputxml + '</InstantID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(LogsIID, eyeball), NAMED('LogsIID'));



Scoring_Project_Refresh_Samples.New_Samples_layouts.InstantID_Layout parse_inputxmlIID () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.ReferenceCode  := TRIM(XMLTEXT('User/ReferenceCode'));
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
															
	self.FP_model 			:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/FraudPointModel')));							
	self.CVI 			:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/CVIModel/IncludeCVI')));							
	self.NAP 			:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/CVIModel/IncludeNAP')));							
	self.NAS		:= StringLib.StringToUpperCase(TRIM(XMLTEXT('Options/IncludeModels/CVIModel/IncludeNAS')));							
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.FullName				:= TRIM(XMLTEXT('SearchBy/Name/Full'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.DLState				:= TRIM(XMLTEXT('SearchBy/DriverLicenseState'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	SELF := [];
END;


Scoring_Project_Refresh_Samples.New_Samples_layouts.InstantID_Layout parseInputIID (LogsIID l) := TRANSFORM
	self.AccountID 			:= l.AccountID;
	
	logs_temp := project(ut.ds_oneRecord, transform(logs_raw_layoutIID,
		self.accountid := l.accountid;
		self.inputxml := l.inputxml;
		self := [];)
		);
		
	temp_IID := parse(logs_temp, inputxml, parse_inputxmlIID(), XML('InstantIDRequest'));
	
	self := temp_IID[1];
	
	SELF := [];
END;

cleanLogsIID := project(LogsIID, parseInputIID(left));
OUTPUT(CHOOSEN(cleanLogsIID, eyeball), NAMED('cleanLogsIID'));


logsaccountIID := cleanLogsIID;

IID := logsaccountIID(FP_Model = '' );

OriginalDataIID := DATASET(fileoldIID, Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure, thor);

Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_IID(IID, OriginalDataIID, fileoutIID);
#end

// FPv2_AmericanExpress := logsaccount(FP_Attributes2 = 'FRAUDPOINTATTRV201');
// OUTPUT(CHOOSEN(FPv2_AmericanExpress, eyeball), NAMED('FraudPointAttrv201'));





//***************************************************************************************************************
// FPv3


// FPv3 := LogsAccount(FP_Model = 'FP31505_0');
// OUTPUT(CHOOSEN(FPv3, eyeball), NAMED('FPv3'));

	// FPv3_dob := FPv3(dob <> ''); 
// output(FPv3_dob);
	
// Scoring_Project_Refresh_Samples.NonFCRA_New_Samples_Logs.NonFCRA_New_Samples_Logs_FPv3(FPv3);

