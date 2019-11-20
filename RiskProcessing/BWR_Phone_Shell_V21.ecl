//REMOVE DID field in layout and getting populated in soap input if wanting apples to apples with other scripts as NOT all scripts are sending this in.
#WORKUNIT('name', 'Phone_Shell V2.1');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, data_services, Models;

RecordsToRun := 0; // Number of records to run through the service - set to 0 to run all

eyeball := 250; // Number of sample records to view

// RoxieIP := RiskWise.Shortcuts.Dev156; // Dev156 Fusion Roxie
RoxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; // Production Roxie
// RoxieIP := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie

Threads := 30; // Number of Parallel threads to SOAPCALL with

/* *****************************************
 * Input/Output File Names                 *
 *******************************************/
//these WU will have the input data: PROD W20150702-110536 (First Party) and PROD W20150702-110602 (Third Party)
//InputFile := '~bweiner::in::jan16_3p_pii';
//OutputFile := '~akoenen::out::phone_shell';

//InputFile := data_services.foreign_prod +'bweiner::in::mar18_1p_pii.csv';
InputFile := '~bweiner::in::sep19_1p_pii.csv';

// OutputFile := '~bweiner::out::phone_shell_sample_mar18_1p-equifax_OFF';
OutputFile := '~bweiner::out::phone_shell_sample_sep19_1p-equifax_ON';

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
// DataRestrictionMask := '0000000000000000000000000'; //orig Phone shell setting, no restrictions
// DataRestrictionMask := '101000000000000000000000000'; //If bit 24 is 1 that means NO Equifax data can be used, if bit 16 is 1 that means NO inquiries
// ^^ Above 101000000000000000000000000 amounts to NO Fares and NO Experian Business Reports
 DataRestrictionMask := '0000000000000101000000000000000000000000'; // DRM from Ben W's script (based on product settings) - amounts to Experian FCRA Header OFF and Inquiries OFF

// DataPermission := Phone_Shell.Constants.Default_DataPermission; //orig Phone shell setting
// DataPermission := '100000000000000000000'; 
// ^^ Above 100000000000000000000 amounts to use_qsent = use in-house(not gateway) qsent data, per AutoStandardI.DataPermissionI
 DataPermission := '00000000010100000000000000000000000'; // DPM from Ben W's script (based on product settings) - amounts to use_DeathMasterSSAUpdates and use_SBFEData

//set Premium A flag here
// PremiumAFlag := TRUE;
// PremiumAFlag := FALSE; //no Equifax gateway
PremiumAFlag := FALSE;
PremiumSource_A_limit := 0; // if Equifax gateway ON, how many Equifax phones to return (max 3)
PhoneShell_version := 21; // 21 for 2.1; A different script should be used for 1.0.

IncludeFPScores := TRUE; // Default is FALSE (for v1) or TRUE (for v2+). This is to match better when compared to running a Boca Shell directly.
EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes

ScoringModelName := 'COLLECTIONSCORE_V3'; // This value means "run the model". Set to BLANK ('') to turn off the scoring model.

// Score_Threshold_In := 387; //387 phoneshell v21 w/ new combined model //217 phoneshell v1 w/ v3 models //306 older v2 models //orig script had 245
Score_Threshold_In := 0; // get all phones regardless of score

BocaShell_Watchlist_Threshold := '0.84';
GLBPurpose := 1;
DPPAPurpose := 3;
IncludeLastResort := TRUE;

/* *****************************************
 * Gateway Information                     *
 *******************************************/
EnableQSentV2_TransUnion_Gateway := FALSE; // Set to TRUE to run the QSentV2 TransUnion Gateway (Source_List == 'TU')
QSentV2_TransUnion_Gateway_URL := ''; // NOTE: THIS URL IS ONLY FOR TRANSUNION TEST SEEDS - WILL NOT RUN LIVE TRANSACTIONS
// QSentV2_TransUnion_Gateway_URL := 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGateway?ver_=1.67'; // NOTE: THIS URL IS ONLY FOR TRANSUNION TEST SEEDS - WILL NOT RUN LIVE TRANSACTIONS

EnableTargus_Gateway := FALSE; // Set to TRUE to run the Targus Gateway (Source_List == 'PDE')
Targus_Gateway_URL := '';
// Targus_Gateway_URL := Riskwise.Shortcuts.gw_targus.url;

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

Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile, prii_layout, CSV(QUOTE('"'))),
																CHOOSEN(DATASET(InputFile, prii_layout, CSV(QUOTE('"'))), RecordsToRun)), SKEW(0.1));

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
	UNSIGNED PhoneShell_Version := 21;
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
	UNSIGNED2 Score_Threshold := Score_Threshold_In;
	BOOLEAN UsePremiumSource_A := PremiumAFlag;
	INTEGER PremiumSource_A_limit := 3;
	BOOLEAN IncludePhonesFeedback := FALSE;
	UNSIGNED8 DID; //REMOVE this field here and below to get apples to apples with other scripts as NOT all scripts are sending this in.
END;

layoutSOAPIn intoSOAP(Input le) := TRANSFORM
	// Input
	SELF.AcctNo := le.Account;
	
	SELF.FirstName_In := le.FirstName;
	SELF.MiddleName_In := le.MiddleName;
	SELF.LastName_In := le.LastName;
	SELF.SuffixName_In := le.SuffixName;
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
	
	SELF.Gateways := DATASET([
  {'qsentv2',IF(EnableQSentV2_TransUnion_Gateway, QSentV2_TransUnion_Gateway_URL, '')}, // TransUnion Gateway
		{'targus', IF(EnableTargus_Gateway, Targus_Gateway_URL, '')} // Targus Gateway
		], Risk_Indicators.Layout_Gateways_In);
	
	SELF.GLBPurpose := GLBPurpose;
	// SELF.DPPAPurpose := 1; //orig phone shell setting
 SELF.DPPAPurpose := DPPAPurpose;
	SELF.DataRestrictionMask := DataRestrictionMask;
	SELF.DataPermissionMask := DataPermission;
	SELF.Phone_Restriction_Mask := Phone_Shell.Constants.PRM.AllPhones;
	SELF.MaxNumberOfPhones := 99;
	SELF.InsuranceVerificationAgeLimit := Phone_Shell.Constants.Default_InsuranceVerificationAgeLimit;
	SELF.SPIIAccessLevel := Phone_Shell.Constants.Default_SPIIAccessLevel;
	SELF.RelocationsMaxDaysBefore := Relocations.wdtg.default_daysBefore;
	SELF.RelocationsMaxDaysAfter := Relocations.wdtg.default_daysAfter;
	SELF.RelocationsTargetRadius := Relocations.wdtg.default_radius;
	SELF.VerticalMarket := '';
	SELF.IncludeLastResort := IncludeLastResort;
	SELF.PhoneShell_Version := PhoneShell_version;
	SELF.BocaShell_IncludeRelatives := TRUE;
	SELF.BocaShell_IncludeDL := FALSE;
	SELF.BocaShell_IncludeVehicle := FALSE;
	SELF.BocaShell_IncludeDerog := TRUE;
	SELF.BocaShell_Include_OFAC := FALSE;
	SELF.BocaShell_OFAC_Only := TRUE;
	SELF.BocaShell_ExcludeWatchlists := FALSE;
	SELF.BocaShell_Include_AdditionalWatchlists := FALSE;
	SELF.BocaShell_DoScore := IncludeFPScores;
	SELF.BocaShell_SuppressNearDups := FALSE;
	SELF.BocaShell_Require2Elements := FALSE;
	//SELF.BocaShell_AppendBest := 0;//orig phone shell settings
	SELF.BocaShell_AppendBest := 1; 
	SELF.BocaShell_OFAC_Version := 1;
	SELF.BocaShell_DOB_Radius := -1;
	// SELF.BocaShell_Watchlist_Threshold := '0.84'; //orig phone shell settings
	SELF.BocaShell_Watchlist_Threshold := BocaShell_Watchlist_Threshold;
	SELF.Score_Threshold := Score_Threshold_In;
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
	// SELF.PremiumSource_A_limit := 3; //orig phone settings
	SELF.PremiumSource_A_limit := PremiumSource_A_limit; //the maximum is 3 ....if you want less change this
	self.IncludePhonesFeedback := false;
	SELF.DID := le.did;
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
													'Phone_Shell.Phone_Shell_Service',
													{soap},  
													DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),
													PARALLEL(Threads),
													ONFAIL(errX(LEFT)), TIMEOUT(500), RETRY(3)
												);

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

modelingShell := SORT(Phone_Shell.To_Modeling_Shell_v21(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));


OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));

alt_layout := record
  Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout.Phone_Shell phone_shell;
  Risk_Indicators.Layout_Boca_Shell - LnJ_Datasets - ConsumerStatements - bk_chapters boca_shell;
end;
alt_layout get_alt(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout le) := transform
  self := le;
end;
goodout := project(goodresults,get_alt(left));
models.flatten(goodout, goodresults_flat);
output(goodresults_flat,, OutputFile + '_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), named('GoodResults_flattened')); // flattens output for csv

OUTPUT(goodResults,, OutputFile + '_' + ThorLib.wuid(), named('GoodResults_fullTHOR')); // saves it as a THOR/FLAT file for later use in a script

OUTPUT(modelingShell,, OutputFile + '_ModelingLayout_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), named('ModelingResults_csv'));

//for model validation on ECL side
//tmpGoodResults := PROJECT(goodResults, TRANSFORM(
//  phone_Shell.Layout_Phone_Shell_Temp.Phone_Shell_Layout, SELF := LEFT, SELF :=[]));
//OUTPUT(choosen(tmpGoodResults,eyeball), NAMED('Total_Number_Of_TmpSuccess'));
//OUTPUT(tmpGoodResults,, OutputFile + '_tmpPS' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);


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

OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', CSV(HEADING(single), QUOTE('"')), named('SlimResults'));
