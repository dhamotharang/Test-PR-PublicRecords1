//REMOVE DID field in layout and getting populated in soap input if wanting apples to apples with other scripts as NOT all scripts are sending this in.
//#WORKUNIT('name', 'WaterfallPhone settings (NoGateway) for Phone Shell');
#WORKUNIT('name', 'Phone Shell Batch input (WF - NoGateway)');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, data_services;

RecordsToRun := 0; // Number of records to run through the service - set to 0 to run all

eyeball := 250; // Number of sample records to view

RoxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie;

Threads := 30; // Number of Parallel threads to SOAPCALL with

/* *****************************************
 * Input/Output File Names                 *
 *******************************************/

InputFile := data_services.foreign_prod +'bweiner::in::mar18_1p_pii.csv';
// InputFile := '~bweiner::in::mar18_1p_pii.csv';

// OutputFile := '~bweiner::out::phone_shell_sample_mar18_1p-equifax_OFF';
OutputFile := '~bweiner::out::waterfall::phone_shell_sample_mar18_1p-equifax_ON';

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
// DataRestrictionMask := '0000000000000000000000000'; //orig PHone shell setting
DataRestrictionMask := '101000000000000000000000000'; //If bit 24 is 1 that means NO Equifax data can be used
//DataPermission := Phone_Shell.Constants.Default_DataPermission; //orig PHone shell setting
DataPermission := '100000000000000000000'; 

//set Premium A flag here
// PremiumAFlag := TRUE;
PremiumAFlag := FALSE; //no Equifax gateway

EnableInsuranceAttributes := TRUE; // Should probably always be TRUE - turns on the Insurance Verification Attributes
ScoringModelName := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
//Score_Threshold_In := 217; this is for new models on 7/31
Score_Threshold_In := 306; 

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
		 //UNSIGNED8 DID;
END;

Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile, prii_layout, CSV(QUOTE('"'))),
																CHOOSEN(DATASET(InputFile, prii_layout, CSV(QUOTE('"'))), RecordsToRun)), SKEW(0.1));

layoutSOAPIn := RECORD
	/*STRING AcctNo := '';
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
	STRING WorkPhone_In := '';*/
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
	UNSIGNED2 Score_Threshold := Score_Threshold_In;
	BOOLEAN UsePremiumSource_A := PremiumAFlag;
	INTEGER PremiumSource_A_limit := 3;
	BOOLEAN IncludePhonesFeedback := FALSE;
	//UNSIGNED8 DID; //REMOVE this field here and below to get apples to apples with other scripts as NOT all scripts are sending this in.
 // STRING30 IndustryClass_In := 'OTHER'; //NOT in original phone shell settings
END;

batch_in := record
	Phone_Shell.Layout_Phone_Shell.Input;
end;



batch_in make_batch_in(Input le, integer c) := transform
	self.AcctNo := (string) le.Account;//(string)c;
	self.seq := c;
	cleaned_address := Risk_Indicators.MOD_AddressClean.clean_addr(le.StreetAddress, le.city, le.state, le.zip, '');
	self.prim_range := cleaned_address[1..10];
	self.predir := cleaned_address[11..12];
	self.prim_name := cleaned_address[13..40];
	self.Addr_Suffix := cleaned_address[41..44];
	self.postdir := cleaned_address[45..46];
	self.unit_desig := cleaned_address[47..56];
	self.sec_range := cleaned_address[57..65];
	self.city := cleaned_address[90..114];
	self.state := cleaned_address[115..116];
	// self.zip5 := cleaned_address[117..121];
	// self.zip4 := cleaned_address[122..125];
  self.zip := cleaned_address[117..121];// + cleaned_address[122..125];
	self.SSN := le.SSN;
	self.DateOfBirth := le.DateOfBirth;
	SELF.FirstName:= le.FirstName;
	SELF.MiddleName := le.MiddleName;
	SELF.LastName := le.LastName;
	SELF.SuffixName := le.SuffixName;
	self := le ;
  self := [];
end;




layoutSOAPIn intoSOAP(Input le, integer c) := TRANSFORM
	// Input
  //dataset(batch_in) Batch_Input;	
    self.Batch_Input := project(le, make_batch_in(left, c));
/*  SELF.AcctNo := le.Account;
	
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
	// Options
	SELF.Phone_Score_Model := ScoringModelName; // Set to blank to disable the phone score model and just run a Phone Shell
	
	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	
	SELF.EnableTransUnionGateway := EnableQSentV2_TransUnion_Gateway;
	SELF.EnableTargusGateway := EnableTargus_Gateway;
	
	// SELF.Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	
	SELF.Gateways := DATASET([
  {'qsentv2',IF(EnableQSentV2_TransUnion_Gateway, QSentV2_TransUnion_Gateway_URL, '')}, // TransUnion Gateway
		{'targus', IF(EnableTargus_Gateway, Targus_Gateway_URL, '')} // Targus Gateway
		], Risk_Indicators.Layout_Gateways_In);
	
	SELF.GLBPurpose := 1;
	// SELF.DPPAPurpose := 1; //orig phone shell setting
	 SELF.DPPAPurpose := 3;
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
	// SELF.IncludeLastResort := FALSE;//orig phone shell setting
	SELF.IncludeLastResort := TRUE;
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
	// SELF.BocaShell_AppendBest := 0; //orig phone shell settings
	SELF.BocaShell_AppendBest := 1; 
	SELF.BocaShell_OFAC_Version := 1;
	SELF.BocaShell_DOB_Radius := -1;
	// SELF.BocaShell_Watchlist_Threshold := '0.84'; //orig phone shell settings
	SELF.BocaShell_Watchlist_Threshold := '0.8399999737739563';
	SELF.Score_Threshold := Score_Threshold_In;
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
	// SELF.PremiumSource_A_limit := 3; //orig phone settings
	SELF.PremiumSource_A_limit := 1; //the maximum is 3 ....if you want less change this
	self.IncludePhonesFeedback := false;
//	SELF.DID := le.did;
 // SELF.IndustryClass_In := 'OTHER'; //not in original phone shell settings
	//SELF := le; //sets other input variables that cause batch to be different
	SELF := [];
END;

soap := PROJECT(Input, intoSOAP(LEFT, counter));

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
             // XPATH('Phone_Shell.Phone_Shell_Service.Response/Results/Result/Dataset[@name=\'Service_SCORING_RESULTS\']/Row'),
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

OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
