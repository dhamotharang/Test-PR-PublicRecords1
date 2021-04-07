bwr_phone_shell(RoxieIP, gateway_ip, RecordsToRun, filetag) := function

		IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT;

		// RecordsToRun := 10000; // Number of records to run through the service - set to 0 to run all

		eyeball := 25; // Number of sample records to view

		// RoxieIP := RiskWise.Shortcuts.Prod_Batch_Neutral; // Production Roxie
		// RoxieIP := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie
		// RoxieIP := RiskWise.Shortcuts.Dev194; // Development Roxie
		// RoxieIP := RiskWise.Shortcuts.Dev196; // Development Roxie

		// filetag := 'nuestar_baseline';
		// filetag := 'nuestar_second';

		Threads := 3; // Number of Parallel threads to SOAPCALL with

		/* *****************************************
		 * Input/Output File Names                 *
		 *******************************************/
		// InputFile := ut.foreign_prod + 'thor_200::out::inquiry_acclogs::inquiry_test::collections::internal_w20140331-160616';
		InputFile := ut.foreign_prod + 'thor_200::out::inquiry_acclogs::inquiry_test::collections::internal_w20140218-105428';

		OutputFile := '~scoringqa::out::phone_shell_' + filetag + '_' + ut.getdate;
		// OutputFile := '~scoringqa::out::phone_shell_address_cleaner_second_'  + ut.getdate;

		//OutputFile := '~bpahl::out::phone_shell__2014_Fernando_1P_to_Accutrac_WithExperian632';
		// OutputFile := '~bpahl::out::phone_shell__2014_Fernando_1P_to_Accutrac_WithExperian1';

		/* *****************************************
		 * Phone Shell Input Options               *
		 *******************************************/
		DataRestrictionMask := '000000000000000000';
		EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes

		/* *****************************************
		 * Gateway Information                     *
		 *******************************************/
		EnableQSentV2_TransUnion_Gateway := FALSE; // Set to TRUE to run the QSentV2 TransUnion Gateway (Source_List == 'TU')
		QSentV2_TransUnion_Gateway_URL := '';

		EnableTargus_Gateway := FALSE; // Set to TRUE to run the Targus Gateway (Source_List == 'PDE')
		Targus_Gateway_URL := '';

		EnableMetronet_Experian_Gateway := FALSE; // Set to TRUE to run the Metronet Experian Gateway (Source_List == 'EXP')
		Metronet_Experian_Gateway_URL := '';
		// EnableMetronet_Experian_Gateway := TRUE; // Set to TRUE to run the Metronet Experian Gateway (Source_List == 'EXP')
		// Metronet_Experian_Gateway_URL := riskwise.shortcuts.Metronet_Experian_Gateway_URL;

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

		Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile, prii_layout, csv(separator('\t'))),
							// TOPN(DATASET(InputFile, prii_layout, csv(separator('\t'))), RecordsToRun, acct_no)), SKEW(0.1));
							choosen(DATASET(InputFile, prii_layout, csv(separator('\t'))), RecordsToRun)), SKEW(0.1));

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
			STRING Prim_Range := '';
			STRING Predir := '';
			STRING Prim_Name := '';
			STRING Addr_Suffix := '';
			STRING Postdir := '';
			STRING Unit_Desig := '';
			STRING Sec_Range := '';
			STRING Zip5 := '';
			STRING Zip4 := '';
			STRING SSN_In := '';
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
			SELF.Phone_Score_Model := 'PHONESCORE_V2'; // Set to blank to disable the phone score model and just run a Phone Shell
			
			SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
			
			SELF.EnableExperianGateway := EnableMetronet_Experian_Gateway;
			SELF.EnableTransUnionGateway := EnableQSentV2_TransUnion_Gateway;
			SELF.EnableTargusGateway := EnableTargus_Gateway;
			
			SELF.Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
			
			SELF.Gateways := DATASET([{'qsentv2', QSentV2_TransUnion_Gateway_URL}, // TransUnion Gateway
										{'targus', Targus_Gateway_URL}, // Targus Gateway
										{'metronet', Metronet_Experian_Gateway_URL}], Risk_Indicators.Layout_Gateways_In);

			SELF.ExperianScoreThreshold := 632; // Default Score
			// SELF.ExperianScoreThreshold := 1;
			
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

		// OUTPUT(CHOOSEN(soap, eyeball), NAMED('Sample_SOAP_Input'));

		soapResults := SOAPCALL(
								soap, 
								RoxieIP, 
								'Phone_Shell.Phone_Shell_Service',
								{soap},  
								DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),
								ONFAIL(errX(LEFT)), TIMEOUT(500), RETRY(3)
							);

		errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

		// OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
		// OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

		goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -Phone_Shell.Phone_Model_Score, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

		modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -((INTEGER)Phone_Model_Score), -LENGTH(TRIM(Source_List)), Gathered_Ph);

		// OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
		// OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));

		// OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));

		outa := OUTPUT(goodResults,, OutputFile + '_6.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
		outb := OUTPUT(modelingShell,, OutputFile + '_ModelLayout_6.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
		
		return sequential(outa, outb);
end;