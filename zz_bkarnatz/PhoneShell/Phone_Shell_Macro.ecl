EXPORT Phone_Shell_Macro(String ProjectName, String OptionsName, String BaseTest, String Roxie, Unsigned Thread, Unsigned RecstoRun, Unsigned PSVersion, String DRM, Boolean EQGateway) := Function

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, data_services;


eyeball := 20; // Number of sample records to view

RecordsToRun := RecsToRun; // Number of records to run through the service - set to 0 to run all
RoxieIP := Roxie;
Threads := Thread; // Number of Parallel threads to SOAPCALL with

/* *****************************************
 * Input/Output File Names                 *
 *******************************************/

// InputFile := '~scoringqa::in::shell_2_0_testfile_may_july_2018_input.csv';             //12k
// InputFile := '~scoringqa::phoneshell::nuestar_only_records_5k.csv';                    //Neustar only sample 5k
// InputFile := '~scoringqa::phoneshell::nuestar_only_records_5k_PhoneBlanked.csv';       //Neustar only sample blanked phone for test 5k
// InputFile := '~ScoringQA::PhoneShell::Nuestar_exclusive_records_5k.csv';               //Neustar exclusive 5k
// InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input.csv';               //Newest Sample From Blake/Ben W  12k

// InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_1of4.csv';               //Newest Sample subset From Blake/Ben W  3k
InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_2of4.csv';               //Newest Sample subset From Blake/Ben W  3k
// InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_3of4.csv';               //Newest Sample subset From Blake/Ben W  3k
// InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_4of4.csv';               //Newest Sample subset From Blake/Ben W  3k


// OutputFile := '~ScoringQA::out::phone_shell_version_10_May_July_gateways_NoRestrictions' + '_PhonesPlusv2_Gong_Base_' + thorlib.wuid();						//Run with No Restrictions
// OutputFile := '~ScoringQA::out::phone_shell_version_10_May_July_' + '_' + ProjectName + '_' + OptionsName + '_' + BaseTest;         //Run with Restrictions
// OutputFile := '~ScoringQA::out::phone_shell_version_10' + '_' + ProjectName + '_' + OptionsName + '_' + BaseTest;         //Run with Restrictions
OutputFile := '~ScoringQA::out::phone_shell_version_'+ (string)PSVersion + '_' + ProjectName + '_' + OptionsName + '_' + BaseTest + '_' + ThorLib.wuid();         //Run with Restrictions

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
 
DataRestrictionMask := DRM;
PremiumAFlag := EQGateway;
PhoneShellVersion := PSVersion;

EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
// Score_Threshold_In := 306; //orig script had 245
Score_Threshold_In := 0; // get everything
DataPermission := '100000000000000000000';
// BocaShell_Watchlist_Threshold := '0.8399999737739563';   //set based off some products, but it seems the BS code only allows .84 regardless.
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
// Targus_Gateway_URL := 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGateway/?ver_=1.70';

prii_layout := RECORD
     STRING FirstName;
     STRING MiddleName;
     STRING LastName;
		 STRING SuffixName;
     STRING StreetAddress1;
     STRING StreetAddress2;
     STRING City;
     STRING State;
     STRING ZIP;
     STRING SSN;     
		 STRING HomePhone;
     STRING Account;
END;

Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile, prii_layout, CSV(HEADING(single), QUOTE('"'))),
																CHOOSEN(DATASET(InputFile, prii_layout, CSV(HEADING(single), QUOTE('"'))), RecordsToRun)), SKEW(0.1));
																
																
// output(choosen(input, eyeball), named('input'));

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
	UNSIGNED PhoneShell_Version := 1;
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
	SELF.StreetAddress1_In := le.StreetAddress1 + ' ' + le.StreetAddress2;  //putting both in here to match bocashell run
	// SELF.StreetAddress2_In := le.StreetAddress2;
	SELF.City_In := le.City;
	SELF.State_In := le.State;
	// SELF.Zip_In := le.zip[1..5] + le.zip[7..10];	   // dropping a space.  PhoneShell layout can only take string9, but input file is 10 char. (11111 1111);
  Self.Zip_In := le.zip[1..5] ;	   // Looks like bocashell only takes zip5, so dropping the last 4 to make things match	SELF.SSN_In := le.SSN;
	SELF.SSN_In := le.SSN;
	// SELF.DateOfBirth_In := le.DateOfBirth;
	SELF.HomePhone_In := le.HomePhone;
	// SELF.WorkPhone_In := le.WorkPhone;
	
	// Options
	SELF.Phone_Score_Model := ScoringModelName; // Set to blank to disable the phone score model and just run a Phone Shell
	
	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	
	SELF.EnableTransUnionGateway := EnableQSentV2_TransUnion_Gateway;
	SELF.EnableTargusGateway := EnableTargus_Gateway;
	
	SELF.Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	
	SELF.Gateways := DATASET([
  {'qsentv2', IF(EnableQSentV2_TransUnion_Gateway, QSentV2_TransUnion_Gateway_URL, '')}, // TransUnion Gateway
		{'targus', IF(EnableTargus_Gateway, Targus_Gateway_URL, '')} // Targus Gateway
                          ], Risk_Indicators.Layout_Gateways_In);
	
	SELF.GLBPurpose := GLBPurpose;
  // SELF.DPPAPurpose := 1;	// original setting
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
	// SELF.IncludeLastResort := FALSE; // orig
  SELF.IncludeLastResort := IncludeLastResort;
	SELF.PhoneShell_Version := PhoneShellVersion;
	SELF.BocaShell_IncludeRelatives := TRUE;
	// SELF.BocaShell_IncludeDL := FALSE;
	SELF.BocaShell_IncludeDL := TRUE;          //Turning on to match BocaShell
	// SELF.BocaShell_IncludeVehicle := FALSE;
	SELF.BocaShell_IncludeVehicle := TRUE;    //Turning on to match BocaShell
	SELF.BocaShell_IncludeDerog := TRUE;
	SELF.BocaShell_Include_OFAC := FALSE;
	SELF.BocaShell_OFAC_Only := TRUE;
	SELF.BocaShell_ExcludeWatchlists := FALSE;
	SELF.BocaShell_Include_AdditionalWatchlists := FALSE;
	// SELF.BocaShell_DoScore := FALSE;
	SELF.BocaShell_DoScore := TRUE;         //Turning on to match BocaShell
	SELF.BocaShell_SuppressNearDups := FALSE;
	SELF.BocaShell_Require2Elements := FALSE;
	// SELF.BocaShell_AppendBest := 0; //orig phone shell settings
	SELF.BocaShell_AppendBest := 1;
	SELF.BocaShell_OFAC_Version := 1;
	SELF.BocaShell_DOB_Radius := -1;
 // SELF.BocaShell_Watchlist_Threshold := '0.84'; //orig phone shell settings
	SELF.BocaShell_Watchlist_Threshold := BocaShell_Watchlist_Threshold;
	SELF.Score_Threshold := Score_Threshold_In;
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
	// SELF.PremiumSource_A_limit := 1;  // Run in Production
	SELF.PremiumSource_A_limit := 3; //  # of EQ phones to return.  Changing to 3 for Modeling
	self.IncludePhonesFeedback := false;
	// SELF.DID := le.did;
	//SELF := le; //sets other input variables that cause batch to be different
	SELF := [];
END;

soap := PROJECT(Input, intoSOAP(LEFT));

xlayout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout;
	string200 errorcode;
end;

xlayout errx(soap le) := TRANSFORM
	SELF.Phone_Shell.Sources.Source_List_First_Seen := FAILMESSAGE; // Use this field because it is long enough
	SELF.Phone_Shell.Sources.Source_List_Last_Seen := '';
	SELF.Phone_Shell.Gathered_Phone := '';
	SELF := [];
END;

// OUTPUT(CHOOSEN(soap, eyeball), NAMED('Sample_SOAP_Input'));
// OUTPUT(soap,, OutputFile + '_PSInputSample', thor, OVERWRITE);

soapResults := SOAPCALL(
													soap, 
													RoxieIP, 
													// 'Phone_Shell.Phone_Shell_service.33', // change to whichever version you want to run
													'Phone_Shell.Phone_Shell_service', // change to whichever version you want to run
													{soap},  
													DATASET(xlayout),
													PARALLEL(Threads),
													ONFAIL(errX(LEFT)), TIMEOUT(500), RETRY(3)
												);
// output(choosen(soapresults,eyeball),named('soapresults'));

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

// OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
// OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);
// OUTPUT(goodResults,, OutputFile, thor, OVERWRITE);
// OUTPUT(goodResults,, OutputFile + '.csv', csv, OVERWRITE);


Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout Trans_Modeling(goodResults le) := TRANSFORM
	self := le;
END; 

ds_trans_goodresults := project(goodResults, Trans_Modeling(left));


// Trims back some layout names for Modeling team so they can import file to SAS
modelingShell := SORT(Phone_Shell.To_Modeling_Shell(ds_trans_goodresults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);
modelingShellv2 := SORT(Phone_Shell.To_Modeling_Shell_v2(ds_trans_goodresults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

// OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
// OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));

// OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));
// OUTPUT(modelingShell,, OutputFile + 'ModelingLayout'+ '_thor_copy', thor, OVERWRITE);

// OUTPUT(soap,, OutputFile + '_PSInputSample', thor, OVERWRITE);
OUTPUT(goodResults,, OutputFile, thor, OVERWRITE);
// OUTPUT(goodResults,, OutputFile + '.csv', csv, OVERWRITE);


 // IF(PSVersion = 10, OUTPUT(modelingShell,, OutputFile + '_ModelingLayout.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE),
					// IF(PSVersion = 20, OUTPUT(modelingShellv2,, OutputFile + '_ModelingLayoutv2.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE),
					// Output('PhoneShell Version ' + (string)PSVersion + ' is not coded for')));
Return 0;

END;