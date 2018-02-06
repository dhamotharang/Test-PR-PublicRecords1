EXPORT PhoneShell_Macro(roxie_ip, Gateway_dummy, Thread, Timeout,Retry,Input_file_name,Output_file_name,records_ToRun) := FUNCTIONMACRO   

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT, data_services;

		unsigned8 RecordsToRun := records_ToRun;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

// RecordsToRun := 10000; // Number of records to run through the service - set to 0 to run all


/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
DataRestrictionMask := '000000000000000000000000'; //If bit 24 is 1 that means NO Equifax data can be used
//set Premium A flag here
PremiumAFlag := true;

EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
Score_Threshold_In := 245;

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



Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(Infile_name, prii_layout, CSV(QUOTE('"'))),
																CHOOSEN(DATASET(Infile_name, prii_layout, CSV(QUOTE('"'))), RecordsToRun)), SKEW(0.1));

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
END;

layoutSOAPIn intoSOAP(Input le) := TRANSFORM
	// Input
/*	
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

soapResults := SOAPCALL(
													soap, 
													RoxieIP, 
													'Phone_Shell.Phone_Shell_Service',
													{soap},  
													DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),
													PARALLEL(Threads),
													ONFAIL(errX(LEFT)), TIMEOUT(timeout), RETRY(retry)
												);

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);


outa := OUTPUT(goodResults,, outfile_name  + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
// outb := OUTPUT(modelingShell,, outfile_name + '_ModelingLayout.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

	return outa;
	
ENDMACRO;