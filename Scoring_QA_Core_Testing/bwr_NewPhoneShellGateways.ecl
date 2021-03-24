 //New script with gateways
 //W20180109-071212
#WORKUNIT('name', 'Phone_Shell');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT, Data_Services;

RecordsToRun := 0; // Number of records to run through the service - set to 0 to run all

eyeball := 250; // Number of sample records to view

RoxieIP := RiskWise.Shortcuts.dev156; 
// RoxieIP := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie

Threads := 1; // Number of Parallel threads to SOAPCALL with

/* *****************************************
 * Input/Output File Names                 *
 *******************************************/
//these WU will have the input data: PROD W20150702-110536 (First Party) and PROD W20150702-110602 (Third Party)
//InputFile := '~dbraun::in::phone_shell_input_testcases';
InputFile1 := Data_Services.foreign_prod + 'bweiner::in::jul17_1p_pii.csv';
InputFile3 := Data_Services.foreign_prod + 'bweiner::in::jul17_3p_pii.csv';

//InputFile := ut.foreign_prod + 'jpyon::in::sprint_1552_in';
OutputFile := '~akoenen::out::phone_shell::NewGateways';

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
DataRestrictionMask := '0000000000000000000000000'; //If bit 24 is 1 that means NO Equifax data can be used
//set Premium A flag here
PremiumAFlag := true;

EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
Score_Threshold_In := 0;

/* *****************************************
 * Gateway Information                     *
 *******************************************/
EnableQSentV2_TransUnion_Gateway := FALSE; // Set to TRUE to run the QSentV2 TransUnion Gateway (Source_List == 'TU')
QSentV2_TransUnion_Gateway_URL := ''; // NOTE: THIS URL IS ONLY FOR TRANSUNION TEST SEEDS - WILL NOT RUN LIVE TRANSACTIONS
// QSentV2_TransUnion_Gateway_URL := riswise.shortcuts.QSentV2_TransUnion_Gateway_URL;

EnableTargus_Gateway := FALSE; // Set to TRUE to run the Targus Gateway (Source_List == 'PDE')
Targus_Gateway_URL := '';
// Targus_Gateway_URL := riskwise.shortcuts.gw_targus_sco[1].url;

prii_layout := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING placeholder_suffix;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    string historydate;
    string LexID; 
 END;



Input1 := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile1, prii_layout, CSV(QUOTE('"'))),
																CHOOSEN(DATASET(InputFile1, prii_layout, CSV(QUOTE('"'))), RecordsToRun)), SKEW(0.1));
Input3 := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile3, prii_layout, CSV(QUOTE('"'))),
																CHOOSEN(DATASET(InputFile3, prii_layout, CSV(QUOTE('"'))), RecordsToRun)), SKEW(0.1));
Input := project(Input1, transform(prii_layout, self.Account := (string)((integer)left.Account + 1000000), self := left)) +
	 project(Input3, transform(prii_layout, self.Account := (string)((integer)left.Account + 2000000), self := left)) ;

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
	STRING Zip_In := '';
	STRING Prim_Range_In := '';
	STRING Predir_In := '';
	STRING Prim_Name_In := '';
	STRING Addr_Suffix_In := '';
	STRING Postdir_In := '';
	STRING Unit_Desig_In := '';
	STRING Sec_Range_In := '';
	STRING Zip5_In := '';
	STRING Zip4_In := '';
	STRING SSN_In := '';
	STRING DateOfBirth_In := '';
	STRING Age_In := '';
	STRING HomePhone_In := '';
	STRING WorkPhone_In := '';
	BOOLEAN EnableTransUnionGateway := FALSE;
	BOOLEAN EnableInsuranceGateway := FALSE;
	BOOLEAN EnableTargusGateway := FALSE;
	DATASET(Phone_Shell.Layout_Phone_Shell.Input) Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	DATASET(Risk_Indicators.Layout_Gateways_In) Gateways := DATASET([], Risk_Indicators.Layout_Gateways_In);
	UNSIGNED GLBPurpose := 0;
	UNSIGNED DPPAPurpose := 0;
	STRING DataRestrictionMask := '';
	STRING DataPermissionMask := '';
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
	BOOLEAN UsePremiumSource_A := PremiumAFlag;
	INTEGER PremiumSource_A_limit := 3;
	boolean BlankOutDuplicatePhones := false;
	BOOLEAN IncludePhonesFeedback := FALSE;
	BOOLEAN DedupAgainstInputPhones := FALSE;
	UNSIGNED8 DID; //REMOVE this field here and below to get apples to apples with other scripts as NOT all scripts are sending this in.
END;

layoutSOAPIn intoSOAP(Input le) := TRANSFORM
	// Input
	SELF.AcctNo := le.Account;
	
	SELF.FirstName_In := le.FirstName;
	SELF.MiddleName_In := le.MiddleName;
	SELF.LastName_In := le.LastName;
	SELF.SuffixName_In := le.placeholder_suffix;
	SELF.StreetAddress1_In := le.StreetAddress;
	SELF.City_In := le.City;
	SELF.State_In := le.State;
	SELF.Zip_In := le.Zip;
	SELF.SSN_In := le.SSN;
	SELF.DateOfBirth_In := le.DateOfBirth;
	SELF.HomePhone_In := le.HomePhone;
	SELF.WorkPhone_In := le.WorkPhone;
	
	// Options
	SELF.Phone_Score_Model := ScoringModelName; // Set to blank to disable the phone score model and just run a Phone Shell
	
	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	
	SELF.EnableTransUnionGateway := EnableQSentV2_TransUnion_Gateway;
	SELF.EnableTargusGateway := EnableTargus_Gateway;
	
	SELF.Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	
	SELF.Gateways := DATASET([{'qsentv2', IF(EnableQSentV2_TransUnion_Gateway, QSentV2_TransUnion_Gateway_URL, '')}, // TransUnion Gateway
														{'targus', IF(EnableTargus_Gateway, Targus_Gateway_URL, '')} // Targus Gateway
														], Risk_Indicators.Layout_Gateways_In);

	SELF.GLBPurpose := 1;
	SELF.DPPAPurpose := 1;
	SELF.DataRestrictionMask := DataRestrictionMask;
	SELF.DataPermissionMask := Phone_Shell.Constants.Default_DataPermission;
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
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
	SELF.PremiumSource_A_limit := 3; //the maximum is 3 ....if you want less change this
	SELF.BlankOutDuplicatePhones := FALSE;
	self.DedupAgainstInputPhones := FALSE;
	self.IncludePhonesFeedback := false;
	SELF.DID := (integer) le.LexID;
	//SELF := le; //sets other input variables that cause batch to be different
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

soapResults := SOAPCALL(
													soap, 
													RoxieIP, 
													'Phone_Shell.Phone_Shell_Service.10', //new code
													{soap},  
													DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),
													PARALLEL(Threads),
													XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),	
													ONFAIL(errX(LEFT)), TIMEOUT(500), RETRY(3)
												);

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);
modelingShell_v11 := SORT(Phone_Shell.To_Modeling_Shell_v11(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));

OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));
OUTPUT(CHOOSEN(modelingShell_v11, eyeball), NAMED('Sample_modelingShell_v11'));

OUTPUT(goodResults,, OutputFile + '_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(modelingShell,, OutputFile + '_ModelingLayout_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(modelingShell_v11,, OutputFile + '_Modeling_v11_Layout_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

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

OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);