#WORKUNIT('name', 'Phone_Shell Parsed with Relocation');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT;

RecordsToRun := 0; // Number of records to run through the service - set to 0 to run all

eyeball := 250; // Number of sample records to view

RoxieIP := RiskWise.Shortcuts.Prod_Batch_Neutral; // Production Roxie
// RoxieIP := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie

Threads := 30; // Number of Parallel threads to SOAPCALL with

/* *****************************************
 * Input/Output File Names                 *
 *******************************************/
//these WU will have the input data: PROD W20150702-110536 (First Party) and PROD W20150702-110602 (Third Party)
InputFile := '~bweiner::in::jan16_parsed_addr_phoneshell_input.csv';
//InputFile := ut.foreign_prod + 'jpyon::in::sprint_1552_in';
OutputFile := '~akoenen::out::phone_shell';

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
DataRestrictionMask := '000000000000000000000000'; //If bit 24 is 1 that means NO Equifax data can be used
EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
Score_Threshold_In := 245;
//set Premium A flag here
PremiumAFlag := true;
/* *****************************************
 * Gateway Information                     *
 *******************************************/
EnableQSentV2_TransUnion_Gateway := FALSE; // Set to TRUE to run the QSentV2 TransUnion Gateway (Source_List == 'TU')
QSentV2_TransUnion_Gateway_URL := ''; // NOTE: THIS URL IS ONLY FOR TRANSUNION TEST SEEDS - WILL NOT RUN LIVE TRANSACTIONS
// QSentV2_TransUnion_Gateway_URL := 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGateway?ver_=1.67'; // NOTE: THIS URL IS ONLY FOR TRANSUNION TEST SEEDS - WILL NOT RUN LIVE TRANSACTIONS

EnableTargus_Gateway := FALSE; // Set to TRUE to run the Targus Gateway (Source_List == 'PDE')
Targus_Gateway_URL := '';
// Targus_Gateway_URL := 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGateway/?ver_=1.70';

EnableMetronet_Experian_Gateway := FALSE; // Set to TRUE to run the Metronet Experian Gateway (Source_List == 'EXP')
Metronet_Experian_Gateway_URL := '';
// Metronet_Experian_Gateway_URL := 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGateway?ver_=1.043';

ippi_layout := RECORD
			string acctno;
     STRING FirstName;
     STRING MiddleName;
     STRING LastName;
		 STRING SuffixName;
		 STRING PRIM_RANGE;
		 STRING PREDIR;
		 STRING PRIM_NAME;
		 STRING ADDR_SUFFIX;
		 STRING POSTDIR;
		 STRING UNIT_DESIG;
		 STRING SEC_RANGE;
		 STRING CITY;
		 STRING STATE;
		 STRING ZIP5;
		 STRING ZIP4;
		 STRING SSN;
		 STRING DateOfBirth;
		 	string10 phoneno_1;
			string10 phoneno_2;
			string10 phoneno_3;
			string10 phoneno_4;
			string10 phoneno_5;
			string10 phoneno_6;
			string10 phoneno_7;
			string10 phoneno_8;
			string10 phoneno_9;
			string10 phoneno_10;
			STRING subj_first;
			STRING subj_middle;
			STRING subj_last;
			STRING subj_suffix;
			STRING subj_phone10;
			STRING subj_name_dual;
			STRING subj_phone_type;
			STRING subj_date_first;
			STRING subj_date_last;
			STRING subj_phone_type_new;
			STRING switch_type;
			STRING phone_score;
			STRING subj_phone_relationship;
			UNSIGNED8 did;
END;
ii := SORT(DATASET(InputFile, ippi_layout, CSV(QUOTE('"'))), acctno);
//ii := choosen(SORT(DATASET(InputFile, ippi_layout, CSV(QUOTE('"'))), acctno), RecordsToRun);

output(choosen(ii, eyeball), named('ii'));
Input := ii;

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
	BOOLEAN EnableExperianGateway := FALSE;
	BOOLEAN EnableTransUnionGateway := FALSE;
	BOOLEAN EnableInsuranceGateway := FALSE;
	BOOLEAN EnableTargusGateway := FALSE;
	DATASET(Phone_Shell.Layout_Phone_Shell.Input) Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	DATASET(Risk_Indicators.Layout_Gateways_In) Gateways := DATASET([], Risk_Indicators.Layout_Gateways_In);
	UNSIGNED3 ExperianScoreThreshold := 632;
	UNSIGNED1 ExperianMaxMetronetPhones := 3;
	BOOLEAN ExperianAllowBatchUse := FALSE;
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
	BOOLEAN Confirmation_GoToGateway := FALSE;
	BOOLEAN UsePremiumSource_A := PremiumAFlag;
	INTEGER PremiumSource_A_limit := 3;
	boolean BlankOutDuplicatePhones := false;
	BOOLEAN IncludePhonesFeedback := FALSE;
		BOOLEAN DedupAgainstInputPhones := FALSE;
	BOOLEAN runRelocation := FALSE;
END;

layoutSOAPIn intoSOAP(Input le) := TRANSFORM
	// Input
	SELF.AcctNo := le.acctno;
	
	SELF.FirstName_In := le.FirstName;
	SELF.MiddleName_In := le.MiddleName;
	SELF.LastName_In := le.LastName;
	SELF.SuffixName_In := le.SuffixName;
	self.prim_range_In := le.PRIM_RANGE;
	self.predir_In := le.PREDIR;
	self.prim_name_In := le.PRIM_NAME;
	self.Addr_Suffix_In := le.ADDR_SUFFIX;
	self.postdir_In := le.POSTDIR;
	self.unit_desig_In := le.UNIT_DESIG; //not in prog phones
	self.sec_range_In := le.SEC_RANGE;
	SELF.City_In := le.City;
	SELF.State_In := le.State;
	//self.zip_in := le.ZIP5;
	self.zip5_In := le.ZIP5;
	self.zip4_In := le.ZIP4;
	self.SSN_In := le.SSN;
	SELF.DateOfBirth_In := le.DateOfBirth;
	SELF.HomePhone_In := '';
	SELF.WorkPhone_In := '';
	
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
	SELF.Confirmation_GoToGateway := FALSE; //if this is TRUE that means you'll see the fake metronet hits to the real gateway
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
	SELF.PremiumSource_A_limit := 3; //the maximum is 3 ....if you want less change this
	SELF.runRelocation := TRUE;
	SELF.BlankOutDuplicatePhones := FALSE;
	self.DedupAgainstInputPhones := FALSE;
	self.IncludePhonesFeedback := false;
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

modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));

OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));

OUTPUT(goodResults,, OutputFile + '_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(modelingShell,, OutputFile + '_ModelingLayout_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fieldsOfInterest := RECORD
	string AcctNo;
	STRING10 Gathered_Phone := '';
	STRING3 Phone_Score := '';
	STRING200 Source_List := '';
	unsigned6 did;
	string ownerdid;
	STRING40 phone_match_code;
END;
slimmedResults := PROJECT(goodResults, TRANSFORM(fieldsOfInterest,
		self.did := left.Phone_Shell.did,
		self.acctno := (string) left.Phone_Shell.input_echo.acctno;
		self.gathered_Phone := left.Phone_Shell.gathered_phone,
		self.Source_List := left.Phone_Shell.Sources.Source_List,
		self.Phone_Score := left.Phone_Shell.Phone_Model_Score,
		self.ownerdid := left.phone_Shell.sources.source_owner_did;
		SELF.phone_match_code := LEFT.Phone_Shell.Raw_Phone_Characteristics.phone_match_code));
		
OUTPUT(slimmedResults(SOURCE_LIST = 'REL'), NAMED('rel_HITS'));
OUTPUT(COUNT(slimmedResults(SOURCE_LIST = 'REL')), NAMED('REL_HITSCNT'));
output(count(slimmedResults), named('slimmedCnt'));

sortedSlim := SORT(slimmedResults, AcctNo, -((UNSIGNED)Phone_Score), Gathered_Phone, -Source_List);

OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);