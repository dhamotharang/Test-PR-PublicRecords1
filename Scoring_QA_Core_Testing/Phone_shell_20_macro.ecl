EXPORT Phone_shell_20_macro(roxie_ip, model, Gateway_dummy, Thread, Timeout,Retry,Input_file_name,Output_file_name,records_ToRun, version) := FUNCTIONMACRO   

//REMOVE DID field in layout and getting populated in soap input if wanting apples to apples with other scripts as NOT all scripts are sending this in.
#WORKUNIT('name', 'Phone_Shell');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, data_services;
eyeball := 25;

		unsigned8 RecordsToRun := records_ToRun;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

psversion := version;
/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
 
// DataRestrictionMask := '0000000000000000000000000'; //orig Phone shell setting
DataRestrictionMask := '101000000000000000000000000'; //If bit 24 is 1 that means NO Equifax data can be used
//DataPermission := Phone_Shell.Constants.Default_DataPermission; //orig Phone shell setting
DataPermission := '100000000000000000000'; 

//set Premium A flag here
//PremiumAFlag := TRUE; // Equifax gateway model
PremiumAFlag := FALSE; // no Equifax gateway

EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
// Score_Threshold_In := 306; //orig script had 245
Score_Threshold_In := 0; // get everything

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

EnableMetronet_Experian_Gateway := FALSE; // Set to TRUE to run the Metronet Experian Gateway (Source_List == 'EXP')
Metronet_Experian_Gateway_URL := '';
// Metronet_Experian_Gateway_URL := 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGateway?ver_=1.043';

	prii_layout := RECORD
		unsigned acct_no;
		string watchdog_fname;
		string watchdog_mname;
		string watchdog_lname;
		string watchdog_sname;
		string watchdog_address_line1;
		string watchdog_address_line_2;
		string watchdog_address_last_line;
		string watchdog_ssn;
		string watchdog_hashID;
		STRING5  title; 
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;	
		string10 prim_range ;
		string2  predir ;
		string28 prim_name ;
		string4  addr_suffix ;
		string2  postdir ;
		string10 unit_desig ;
		string8  sec_range ;
		string25 v_city_name ;
		string2  st ;
		string5  zip5 ;
		string4  zip4 ;
		string LinkID;
		string ssn;
		string	Primary_Market_Code;
		string	Secondary_Market_Code;
		string	Industry_1_Code;
		string	Industry_2_Code;
		string	Sub_market;
		string	Vertical;
		string	Use; 
		string	Industry; 
		string	Function_Description;
		unsigned6 Appended_ADL;
		string Appended_SSN;
		string hashid;
		unsigned count_records;
		string8 date_f;
		unsigned date_bucket;
	END;


Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(Infile_name, prii_layout, thor),
																CHOOSEN(DATASET(Infile_name, prii_layout, thor), RecordsToRun)), SKEW(0.1));

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
	
	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	
	SELF.EnableExperianGateway := EnableMetronet_Experian_Gateway;
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
	SELF.PhoneShell_Version := psversion; // PhoneShell V2.0
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
	// SELF.BocaShell_AppendBest := 0; //orig phone shell settings
	SELF.BocaShell_AppendBest := 1;
	SELF.BocaShell_OFAC_Version := 1;
	SELF.BocaShell_DOB_Radius := -1;
 // SELF.BocaShell_Watchlist_Threshold := '0.84'; //orig phone shell settings
	SELF.BocaShell_Watchlist_Threshold := BocaShell_Watchlist_Threshold;
	SELF.Score_Threshold := Score_Threshold_In;
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
 // SELF.PremiumSource_A_limit := 3; //orig phone settings
	SELF.PremiumSource_A_limit := 1; //the maximum is 3 ....if you want less change this
	self.IncludePhonesFeedback := false;

	//SELF := le; //sets other input variables that cause batch to be different
	SELF := [];
END;

soap := PROJECT(Input, intoSOAP(LEFT));



phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout errx(soap le) := TRANSFORM
	SELF.Phone_Shell.Sources.Source_List_First_Seen :=  FAILCODE + FAILMESSAGE;; // Use this field because it is long enough
	SELF.Phone_Shell.Sources.Source_List_Last_Seen := '';
	SELF.Phone_Shell.Gathered_Phone := '';
	// self.errmsg := le.
	SELF := [];
END;

soapResults := SOAPCALL(
													soap, 
													RoxieIP, 
													// 'Phone_Shell.Phone_Shell_service.5',       //to select .5 query on the dev156
													'Phone_Shell.Phone_Shell_service',
													{soap},  
													DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),
													PARALLEL(Threads),
													ONFAIL(errX(LEFT)), TIMEOUT(timeout), RETRY(retry)
												);

// errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

// modelingShell := SORT(Phone_Shell.To_Modeling_Shell2(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph); //should live in roxiedev, not needed for ScoringQA only for modeling

new_lay := record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements - bk_chapters Boca_Shell;
	// RiskProcessing.Layouts Boca_Shell;
end;

clean_ds_baseline_full := project(goodResults, transform(new_lay,self := left, self := []));

// output(CHOOSEN(input, eyeball));
// OUTPUT(CHOOSEN(soap, eyeball));

// OUTPUT(clean_ds_baseline_full,, outfile_name  + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
return OUTPUT(clean_ds_baseline_full,, outfile_name  , thor, OVERWRITE);

	
ENDMACRO;