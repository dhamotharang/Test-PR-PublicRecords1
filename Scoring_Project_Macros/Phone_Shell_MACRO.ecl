// EXPORT Phone_Shell_MACRO( nonfcraroxie_IP, Thread, Input_file_name, Output_file_name, records_ToRun):= functionmacro

#WORKUNIT('name', 'Phone_Shell');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT, Scoring_Project_Macros.Regression, Scoring_Project_PIP.Input_Sample_Names;

Roxie_Query := 'Phone_Shell.Phone_Shell_Service';
eyeball := 250; // Number of sample records to view
RoxieIP := RiskWise.Shortcuts.Prod_Batch_Neutral; // Production Roxie
// RoxieIP := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie
Threads := 2; // Number of Parallel threads to SOAPCALL with
RecordsToRun := 10; // Number of records to run through the service - set to 0 to run all

/* *****************************************
 * Input/Output File Names                 *
 *******************************************/
InputFile :=  Scoring_Project_PIP.Input_Sample_Names.bocashell_infile_name;																						
// OutputFile := '~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate;
OutputFile := '~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_test_'  + ut.GetDate;

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
DataRestrictionMask := '000000000000000000';
EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'PHONESCORE_V2'; // Set to BLANK to turn off the scoring model
Score_Threshold_In := 245;

/* *****************************************
 * Gateway Information                     *
 *******************************************/
EnableQSentV2_TransUnion_Gateway := FALSE; // Set to TRUE to run the QSentV2 TransUnion Gateway (Source_List == 'TU')
QSentV2_TransUnion_Gateway_URL := ''; // NOTE: THIS URL IS ONLY FOR TRANSUNION TEST SEEDS - WILL NOT RUN LIVE TRANSACTIONS

EnableTargus_Gateway := FALSE; // Set to TRUE to run the Targus Gateway (Source_List == 'PDE')
Targus_Gateway_URL := '';
// Targus_Gateway_URL := riskwise.shortcuts.gw_targus_sco[1].url;

EnableMetronet_Experian_Gateway := FALSE; // Set to TRUE to run the Metronet Experian Gateway (Source_List == 'EXP')
Metronet_Experian_Gateway_URL := '';
// Metronet_Experian_Gateway_URL := riskwise.shortcuts.Metronet_Experian_Gateway_URL;

/*
prii_layout := RECORD
     STRING Account;
     STRING FirstName;
     STRING MiddleName;
     STRING LastName;
		 STRING SuffixName;
     STRING StreetAddress;
     STRING City;
     STRING State;
     STRING ZIP;
     STRING HomePhone;
     STRING SSN;
     STRING DateOfBirth;
     STRING WorkPhone;
     STRING Income;
     STRING DLNumber;
     STRING DLState;
     STRING Balanca;
     STRING ChargeOffD;
     STRING FormerName;
     STRING Email;
     STRING EmployerName;
     INTEGER HistoryDateYYYYMM;
		 UNSIGNED8 DID;
END;
*/

layout_input := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;

Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile, layout_input, CSV(HEADING(SINGLE), QUOTE('"'))),
																CHOOSEN(DATASET(InputFile, layout_input, CSV(HEADING(SINGLE), QUOTE('"'))), RecordsToRun)), SKEW(0.1));
																
// output(input);

layoutSOAPIn := RECORD
	STRING AcctNo := '';
	STRING FullName_In := '';
	STRING TitleName_In := '';
	STRING FirstName_In := '';
	STRING MiddleName_In := '';
	STRING LastName_In := '';
	STRING SuffixName_In := '';
	STRING StreetAddress1_In := '';
	STRING StreetAddress2_In := '';
	STRING City_In := '';
	STRING State_In := '';
	UNSIGNED Zip_In := 0;
	STRING Prim_Range := '';
	STRING Predir := '';
	STRING Prim_Name := '';
	STRING Addr_Suffix := '';
	STRING Postdir := '';
	STRING Unit_Desig := '';
	STRING Sec_Range := '';
	STRING Zip5 := '';
	STRING Zip4 := '';
	UNSIGNED SSN_In := 0;
	UNSIGNED DateOfBirth_In := 0;
	UNSIGNED Age_In := 0;
	UNSIGNED HomePhone_In := 0;
	UNSIGNED WorkPhone_In := 0;
	BOOLEAN EnableExperianGateway := FALSE;
	BOOLEAN EnableTransUnionGateway := FALSE;
	BOOLEAN EnableInsuranceGateway := FALSE;
	BOOLEAN EnableTargusGateway := FALSE;
	DATASET(Phone_Shell.Layout_Phone_Shell.Input) Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	DATASET(Risk_Indicators.Layout_Gateways_In) Gateways := DATASET([], Risk_Indicators.Layout_Gateways_In);
	UNSIGNED3 ExperianScoreThreshold := 632;
	UNSIGNED1 ExperianMaxMetronetPhones := 3;
	BOOLEAN ExperianAllowBatchUse := FALSE;
	UNSIGNED GLB_Purpose := 0;
	UNSIGNED DPPA_Purpose := 0;
	STRING Data_Restriction_Mask := '';
	INTEGER Phone_Restriction_Mask := 0;
	UNSIGNED MaxNumberOfPhones := 0;
	UNSIGNED InsuranceVerificationAgeLimit := 0;
	STRING SPIIAccessLevel := '';
	UNSIGNED RelocationsMaxDaysBefore := 0;
	UNSIGNED RelocationsMaxDaysAfter := 0;
	UNSIGNED RelocationsTargetRadius := 0;
	STRING VerticalMarket := '';
	BOOLEAN IncludeLastResort := FALSE;
	UNSIGNED BocaShell_Version := 0;
	BOOLEAN BocaShell_IncludeRelatives := FALSE;
	BOOLEAN BocaShell_IncludeDL := FALSE;
	BOOLEAN BocaShell_IncludeVehicle := FALSE;
	BOOLEAN BocaShell_IncludeDerog := FALSE;
	BOOLEAN BocaShell_Include_OFAC := FALSE;
	BOOLEAN BocaShell_OFAC_Only := FALSE;
	BOOLEAN BocaShell_ExcludeWatchlists := FALSE;
	BOOLEAN BocaShell_Include_AdditionalWatchlists := FALSE;
	BOOLEAN BocaShell_DoScore := FALSE;
	BOOLEAN BocaShell_SuppressNearDups := FALSE;
	BOOLEAN BocaShell_Require2Elements := FALSE;
	UNSIGNED BocaShell_AppendBest := 0;
	UNSIGNED BocaShell_OFAC_Version := 0;
	INTEGER BocaShell_DOB_Radius := 0;
	STRING BocaShell_Watchlist_Threshold := '';
	STRING Phone_Score_Model := '';
	UNSIGNED2 Score_Threshold := 245;
END;

layoutSOAPIn intoSOAP(Input le) := TRANSFORM
	// Input
	SELF.AcctNo := (STRING)le.accountnumber;
	
	SELF.FirstName_In := le.firstname;
	SELF.MiddleName_In := le.middlename;
	SELF.LastName_In := le.lastname;
	SELF.SuffixName_In := '';
	SELF.StreetAddress1_In := le.streetaddress;
	SELF.City_In := le.city;
	SELF.State_In := le.state;
	SELF.Zip_In := (UNSIGNED)le.zip;
	SELF.SSN_In := (UNSIGNED)le.ssn;
	SELF.DateOfBirth_In := (UNSIGNED)le.dateofbirth;
	SELF.HomePhone_In := (UNSIGNED)le.homephone;
	SELF.WorkPhone_In := (UNSIGNED)le.workphone;
	
	// Options
	SELF.Phone_Score_Model := ScoringModelName; // Set to blank to disable the phone score model and just run a Phone Shell
	
	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	
	SELF.EnableExperianGateway := EnableMetronet_Experian_Gateway;
	SELF.EnableTransUnionGateway := EnableQSentV2_TransUnion_Gateway;
	SELF.EnableTargusGateway := EnableTargus_Gateway;
	
	SELF.Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	
	SELF.Gateways := DATASET([{'qsentv2', IF(EnableQSentV2_TransUnion_Gateway, QSentV2_TransUnion_Gateway_URL, '')}, // TransUnion Gateway
														{'targus', IF(EnableTargus_Gateway, Targus_Gateway_URL, '')}, // Targus Gateway
														{'metronet', IF(EnableMetronet_Experian_Gateway, Metronet_Experian_Gateway_URL, '')}], Risk_Indicators.Layout_Gateways_In);

	SELF.ExperianScoreThreshold := 632;
	SELF.ExperianMaxMetronetPhones := 3;
	SELF.ExperianAllowBatchUse := TRUE;
	
	SELF.GLB_Purpose := 1;
	SELF.DPPA_Purpose := 1;
	SELF.Data_Restriction_Mask := DataRestrictionMask;
	SELF.Phone_Restriction_Mask := Phone_Shell.Constants.PRM.AllPhones;
	SELF.MaxNumberOfPhones := 99;
	SELF.InsuranceVerificationAgeLimit := Phone_Shell.Constants.Default_InsuranceVerificationAgeLimit;
	SELF.SPIIAccessLevel := Phone_Shell.Constants.Default_SPIIAccessLevel;
	SELF.RelocationsMaxDaysBefore := Relocations.wdtg.default_daysBefore;
	SELF.RelocationsMaxDaysAfter := Relocations.wdtg.default_daysAfter;
	SELF.RelocationsTargetRadius := Relocations.wdtg.default_radius;
	SELF.VerticalMarket := '';
	SELF.IncludeLastResort := FALSE;
	SELF.BocaShell_Version := 41;
	SELF.BocaShell_IncludeRelatives := TRUE;
	SELF.BocaShell_IncludeDL := FALSE;
	SELF.BocaShell_IncludeVehicle := FALSE;
	SELF.BocaShell_IncludeDerog := TRUE;
	SELF.BocaShell_Include_OFAC := FALSE;
	SELF.BocaShell_OFAC_Only := TRUE;
	SELF.BocaShell_ExcludeWatchlists := FALSE;
	SELF.BocaShell_Include_AdditionalWatchlists := FALSE;
	SELF.BocaShell_DoScore := FALSE;
	SELF.BocaShell_SuppressNearDups := FALSE;
	SELF.BocaShell_Require2Elements := FALSE;
	SELF.BocaShell_AppendBest := 0;
	SELF.BocaShell_OFAC_Version := 1;
	SELF.BocaShell_DOB_Radius := -1;
	SELF.BocaShell_Watchlist_Threshold := '0.84';
	SELF.Score_Threshold := Score_Threshold_In;
	
	SELF := le;
	SELF := [];
END;

soap := PROJECT(Input, intoSOAP(LEFT));

Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout errx(soap le) := TRANSFORM
	SELF.Phone_Shell.Sources.Source_List_First_Seen := FAILMESSAGE; // Use this field because it is long enough
	SELF.Phone_Shell.Sources.Source_List_Last_Seen := '';
	SELF.Phone_Shell.Gathered_Phone := '';
	SELF := [];
END;

OUTPUT(CHOOSEN(soap, eyeball), NAMED('Sample_SOAP_Input'));

// /*
soapResults := SOAPCALL(
													soap, 
													RoxieIP, 
													Roxie_Query,
													{soap},  
													DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),
													PARALLEL(Threads),
													ONFAIL(errX(LEFT)), TIMEOUT(500), RETRY(3)
												);

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));

OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));

OUTPUT(goodResults,, OutputFile + '_' + ThorLib.wuid() + '.csv', thor, OVERWRITE);
OUTPUT(modelingShell,, OutputFile + '_ModelingLayout_' + ThorLib.wuid() + '.csv', thor, OVERWRITE);

fieldsOfInterest := RECORD
	STRING50 AcctNo := '';
	STRING10 Gathered_Phone := '';
	STRING3 Phone_Score := '';
	STRING200 Source_List := '';
END;

slimmedResults := PROJECT(goodResults, TRANSFORM(fieldsOfInterest,
	SELF.AcctNo := LEFT.Phone_Shell.Input_Echo.AcctNo;
	SELF.Gathered_Phone := LEFT.Phone_Shell.Gathered_Phone;
	SELF.Phone_Score := LEFT.Phone_Shell.Phone_Model_Score;
	SELF.Source_List := LEFT.Phone_Shell.Sources.Source_List;
	SELF := []));
	
sortedSlim := SORT(slimmedResults, AcctNo, -((UNSIGNED)Phone_Score), Gathered_Phone, -Source_List);

OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', thor, OVERWRITE);

// RETURN '';

// ENDMACRO;
// */