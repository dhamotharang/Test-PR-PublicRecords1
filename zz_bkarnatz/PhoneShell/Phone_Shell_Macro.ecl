EXPORT Phone_Shell_Macro(String ProjectName, String OptionsName, String BaseTest, String Roxie, Unsigned Thread, Unsigned RecstoRun, Unsigned PSVersion, String DRM, Boolean EQGateway) := Function

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, data_services;


eyeball := 10; // Number of sample records to view

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
InputFile := '~scoring_project::in::phoneshell_inquirytest_collectionsinternal_w20190501-121441';     //original phoneshell input
// InputFile := '~scoringqa::in::phoneshell_testsample_jul_sep19_im_3k_1of4.csv';               //Newest Sample From Blake/Ben W  3k
// InputFile := '~scoringqa::in::phoneshell_testsample_jul_sep19_im_9k_half.csv';               //Newest Sample From Blake/Ben W  9k
// InputFile := '~scoringqa::in::phoneshell_testsample_jul_sep19_im_9k_half.csv';               //Newest Sample From Blake/Ben W  9k

// InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_1of4.csv';               //Newest Sample subset From Blake/Ben W  3k
// InputFile := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_2of4.csv';               //Newest Sample subset From Blake/Ben W  3k
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
PremiumSource_A_limit := 0; // if Equifax gateway ON, how many Equifax phones to return (max 3)
PhoneShellVersion := PSVersion;

IncludeFPScores := TRUE; // Default is FALSE (for v1) or TRUE (for v2+). This is to match better when compared to running a Boca Shell directly.
EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
// Score_Threshold_In := 217; //387 phoneshell v21 w/ new combined model //217 phoneshell v1 w/ v3 models
// Score_Threshold_In := 387; //387 phoneshell v21 w/ new combined model //217 phoneshell v1 w/ v3 models
Score_Threshold_In := 0; // get everything
DataPermission := '100000000000000000000';
// DataPermission := '00000000010100000000000000000000000';
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
  unsigned8 acct_no;
  string watchdog_fname;
  string watchdog_mname;
  string watchdog_lname;
  string watchdog_sname;
  string watchdog_address_line1;
  string watchdog_address_line_2;
  string watchdog_address_last_line;
  string watchdog_ssn;
  string watchdog_hashid;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string linkid;
  string ssn;
  string primary_market_code;
  string secondary_market_code;
  string industry_1_code;
  string industry_2_code;
  string sub_market;
  string vertical;
  string use;
  string industry;
  string function_description;
  unsigned6 appended_adl;
  string appended_ssn;
  string hashid;
  unsigned8 count_records;
  string8 date_f;
  unsigned8 date_bucket;
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
	// BOOLEAN EnableExperianGateway := FALSE;
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
	UNSIGNED PhoneShell_Version := 21;        //*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
	BOOLEAN BocaShell_IncludeRelatives := FALSE;
	BOOLEAN BocaShell_IncludeDL := FALSE;
	BOOLEAN BocaShell_IncludeVehicle := FALSE;
	BOOLEAN BocaShell_IncludeDerog := FALSE;
	BOOLEAN BocaShell_Include_OFAC := FALSE;
	BOOLEAN BocaShell_OFAC_Only := FALSE;
	BOOLEAN BocaShell_ExcludeWatchlists := FALSE;
	BOOLEAN BocaShell_Include_AdditionalWatchlists := FALSE;
	BOOLEAN BocaShell_DoScore := IncludeFPScores;
	BOOLEAN BocaShell_SuppressNearDups := FALSE;
	BOOLEAN BocaShell_Require2Elements := FALSE;
	UNSIGNED BocaShell_AppendBest := 0;
	UNSIGNED BocaShell_OFAC_Version := 0;
	INTEGER BocaShell_DOB_Radius := 0;
	STRING BocaShell_Watchlist_Threshold := '';
	STRING Phone_Score_Model := '';
	// STRING ModelVersion := 'V3';
	UNSIGNED2 Score_Threshold := Score_Threshold_In;
	BOOLEAN UsePremiumSource_A := PremiumAFlag;
	INTEGER PremiumSource_A_limit := 3;
	BOOLEAN IncludePhonesFeedback := FALSE;
	UNSIGNED8 DID; //REMOVE this field here and below to get apples to apples with other scripts as NOT all scripts are sending this in.
END;

layoutSOAPIn intoSOAP(Input le) := TRANSFORM
	// Input
/*	
	SELF.AcctNo := le.Account;
	
	SELF.FirstName_In := le.FirstName;
	SELF.MiddleName_In := le.MiddleName;
	SELF.LastName_In := le.LastName;
	SELF.SuffixName_In := le.SuffixName;
	// SELF.StreetAddress1_In := le.StreetAddress1 + ' ' + le.StreetAddress2;  //putting both in here to match bocashell run
	SELF.StreetAddress1_In := le.StreetAddress;  //putting both in here to match bocashell run
	// SELF.StreetAddress2_In := le.StreetAddress2;
	SELF.City_In := le.City;
	SELF.State_In := le.State;
	// SELF.Zip_In := le.zip[1..5] + le.zip[7..10];	   // dropping a space.  PhoneShell layout can only take string9, but input file is 10 char. (11111 1111);
  Self.Zip_In := le.zip[1..5] ;	   // Looks like bocashell only takes zip5, so dropping the last 4 to make things match	SELF.SSN_In := le.SSN;
	SELF.SSN_In := le.SSN;
	// SELF.DateOfBirth_In := le.DateOfBirth;
	// SELF.HomePhone_In := le.HomePhone;			//no phones populated in jul_sep19 input files**********
	// SELF.WorkPhone_In := le.WorkPhone;
	*/
		SELF.AcctNo := (STRING)le.acct_no;
	
	SELF.FirstName_In := le.watchdog_fname;
	SELF.MiddleName_In := le.watchdog_mname;
	SELF.LastName_In := le.watchdog_lname;
	SELF.SuffixName_In := le.watchdog_sname;
	SELF.StreetAddress1_In := le.watchdog_address_line1;
	SELF.StreetAddress2_In := le.watchdog_address_line_2;
	SELF.City_In := le.v_city_name;
	SELF.State_In := le.st;
	SELF.Zip_In := le.zip5;
	SELF.SSN_In := le.watchdog_ssn;	

	// Options
	SELF.Phone_Score_Model := ScoringModelName; // Set to blank to disable the phone score model and just run a Phone Shell
  // SELF.ModelVersion := 'V3'; // this overrides the default of using the new combined model, to go back to the split phoneshell v1 models

	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	// SELF.EnableExperianGateway := EnableMetronet_Experian_Gateway;
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
	SELF.BocaShell_IncludeDL := FALSE;
	// SELF.BocaShell_IncludeDL := TRUE;          //Turning on to match BocaShell
	SELF.BocaShell_IncludeVehicle := FALSE;
	// SELF.BocaShell_IncludeVehicle := TRUE;    //Turning on to match BocaShell
	SELF.BocaShell_IncludeDerog := TRUE;
	SELF.BocaShell_Include_OFAC := FALSE;
	SELF.BocaShell_OFAC_Only := TRUE;
	SELF.BocaShell_ExcludeWatchlists := FALSE;
	SELF.BocaShell_Include_AdditionalWatchlists := FALSE;
	SELF.BocaShell_DoScore := FALSE;
	// SELF.BocaShell_DoScore := TRUE;         //Turning on to match BocaShell
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
	SELF.PremiumSource_A_limit := PremiumSource_A_limit; //  # of EQ phones to return.  Changing to 3 for Modeling
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
output(choosen(soapresults,eyeball),named('soapresults'));

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

// OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);
OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));
OUTPUT(goodResults,, OutputFile, thor, OVERWRITE);
// OUTPUT(goodResults,, OutputFile + '.csv', csv, OVERWRITE);


fieldsOfInterest := RECORD
	STRING50 AcctNo := '';
	// STRING50 AcctNo := goodResults.Phone_Shell.Input_Echo.AcctNo;
	STRING10 Gathered_Phone := '';
	// STRING10 Gathered_Phone := goodResults.Phone_Shell.Gathered_Phone;
	STRING3 Phone_Score := '';
	// STRING3 Phone_Score := goodResults.Phone_Shell.Phone_Model_Score;
	STRING200 Source_List := '';
	// STRING200 Source_List := goodResults.Phone_Shell.Sources.Source_List;
END;

slimmedResults := PROJECT(goodResults, TRANSFORM(fieldsOfInterest,
	SELF.AcctNo := LEFT.Phone_Shell.Input_Echo.AcctNo;
	SELF.Gathered_Phone := LEFT.Phone_Shell.Gathered_Phone;
	SELF.Phone_Score := LEFT.Phone_Shell.Phone_Model_Score;
	SELF.Source_List := LEFT.Phone_Shell.Sources.Source_List;
	SELF := []));
	
sortedSlim := SORT(slimmedResults, AcctNo, -((UNSIGNED)Phone_Score), Gathered_Phone, -Source_List);

// OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid(), THOR, OVERWRITE), named('SlimResults'));
OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE, named('SlimResults'));


// Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout Trans_Modeling(goodResults le) := TRANSFORM
	// self := le;
// END; 

// ds_trans_goodresults := project(goodResults, Trans_Modeling(left));


// Trims back some layout names for Modeling team so they can import file to SAS
// modelingShell := SORT(Phone_Shell.To_Modeling_Shell(ds_trans_goodresults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);
// modelingShellv2 := SORT(Phone_Shell.To_Modeling_Shell_v2(ds_trans_goodresults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);
// modelingShellv21 := SORT(Phone_Shell.To_Modeling_Shell_v21(ds_trans_goodresults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

// OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
// OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));

// OUTPUT(CHOOSEN(modelingShellv2, eyeball), NAMED('Sample_Modeling_Shell'));
// OUTPUT(modelingShellv2,, OutputFile + 'ModelingLayout'+ '_thor_copy', thor, OVERWRITE);

// OUTPUT(soap,, OutputFile + '_PSInputSample', thor, OVERWRITE);


					// IF(PSVersion = 10, OUTPUT(modelingShell,, OutputFile + '_ModelingLayout.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE),
					// IF(PSVersion = 20, OUTPUT(modelingShellv2,, OutputFile + '_ModelingLayoutv2.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE),
					// IF(PSVersion = 21, OUTPUT(modelingShellv21,, OutputFile + '_ModelingLayoutv21.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE),
					// Output('PhoneShell Version ' + (string)PSVersion + ' is not coded for')));

Return 0;

END;