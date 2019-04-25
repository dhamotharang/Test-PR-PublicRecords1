#WORKUNIT('name', 'WaterfallPhone (NoGateway) ProgressivePhones');

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT, progressive_phone;

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
OutputFile := '~bweiner::out::waterfallphones_sample_mar18_1p-equifax_ON';

/* *****************************************
 * Phone Shell Input Options               *
 *******************************************/
DataRestrictionMask := '101000000000000000000000000';//'000000000000010100000000000000'; //If bit 24 is 1 that means NO Equifax data can be used
DataPermission := '100000000000000000000'; 

PremiumAFlag := FALSE; 

EnableInsuranceAttributes := FALSE; //Progressive phones uses this but sets in code ************// Should probably always be TRUE - turns on the Insurance Verification Attributes
Phone_Score_Model := 'COLLECTIONSCORE_V3';//'PHONESCORE_V2' = OLD phone model; // Set to BLANK to turn off the scoring model
//Score_Threshold_In := 217;
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
		// UNSIGNED8 DID;
END;

Input := DISTRIBUTE(IF(RecordsToRun <= 0, DATASET(InputFile, prii_layout, CSV(QUOTE('"'))),
																CHOOSEN(DATASET(InputFile, prii_layout, CSV(QUOTE('"'))), RecordsToRun)), SKEW(0.1));
batch_in := record
	progressive_phone.layout_progressive_batch_in;
end;

batch_in make_batch_in(Input le, integer c) := transform
	self.AcctNo := (string) le.Account;//(string)c;
	//self.seq := c;
	cleaned_address := Risk_Indicators.MOD_AddressClean.clean_addr(le.StreetAddress, le.city, le.state, le.zip, '');
	self.prim_range := cleaned_address[1..10];
	self.predir := cleaned_address[11..12];
	self.prim_name := cleaned_address[13..40];
	self.suffix := cleaned_address[41..44];
	self.postdir := cleaned_address[45..46];
	self.unit_desig := cleaned_address[47..56];
	self.sec_range := cleaned_address[57..65];
	self.p_city_name := cleaned_address[90..114];
	self.st := cleaned_address[115..116];
	self.z5 := cleaned_address[117..121];
	self.z4 := cleaned_address[122..125];
	self.SSN := le.SSN;
	self.dob := le.DateOfBirth;
	SELF.name_first:= le.FirstName;
	SELF.name_middle := le.MiddleName;
	SELF.name_last := le.LastName;
	SELF.name_suffix := le.SuffixName;
	self := le ;
  self := [];
end;

layoutSOAPIn := RECORD
  dataset(batch_in) batch_in;
	BOOLEAN EnableTransUnionGateway := FALSE;
	BOOLEAN EnableInsuranceGateway := FALSE;
	BOOLEAN EnableTargusGateway := FALSE;
	//DATASET(Phone_Shell.Layout_Phone_Shell.Input) Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
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
	STRING Phone_Score_Model := '';
	UNSIGNED2 Score_Threshold := 217;
	BOOLEAN Confirmation_GoToGateway := FALSE;
	BOOLEAN UsePremiumSource_A := FALSE;
	INTEGER PremiumSource_A_limit := 1;
	UNSIGNED2 MaxNumAssociate := 50;
	UNSIGNED2 MaxNumAssociateOther := 0;
	UNSIGNED2 MaxNumFamilyOther := 0;
	UNSIGNED2 MaxNumFamilyClose := 50;
	UNSIGNED2 MaxNumParent := 0;
	UNSIGNED2 MaxNumSpouse := 0;
	UNSIGNED2 MaxNumSubject := 0;
	UNSIGNED2 MaxNumNeighbor := 0;
	UNSIGNED2 MaxPhoneCount := 0;
	boolean ReturnScore := TRUE;
	boolean BlankOutDuplicatePhones := FALSE;
	BOOLEAN DedupAgainstInputPhones := FALSE;
 // STRING30 IndustryClass := 'OTHER';
END;

layoutSOAPIn intoSOAP(Input le, integer c) := TRANSFORM
	// Input
  self.batch_in := project(le, make_batch_in(left, c));
	
	// Options
	SELF.Phone_Score_Model := Phone_Score_Model; // Set to blank to disable the phone score model and just run a Phone Shell
	
	SELF.EnableInsuranceGateway := EnableInsuranceAttributes;
	
	SELF.EnableTransUnionGateway := EnableQSentV2_TransUnion_Gateway;
	SELF.EnableTargusGateway := EnableTargus_Gateway;
	
	//SELF.Batch_Input := DATASET([], Phone_Shell.Layout_Phone_Shell.Input);
	
	SELF.Gateways := DATASET([{'', IF(EnableQSentV2_TransUnion_Gateway, QSentV2_TransUnion_Gateway_URL, '')}, // TransUnion Gateway
														{'', IF(EnableTargus_Gateway, Targus_Gateway_URL, '')} // Targus Gateway
												], Risk_Indicators.Layout_Gateways_In);

	SELF.GLBPurpose := 1;
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
	SELF.IncludeLastResort := TRUE;
/* THRESHOLD HARD CODED IN progressive_phone.functions*/	
	SELF.Score_Threshold := Score_Threshold_In;
	SELF.UsePremiumSource_A := PremiumAFlag; //set to true if you want to use Equifax data
	SELF.PremiumSource_A_limit := 1; //the maximum is 3 ....if you want less change this
	SELF.maxnumassociate := 50;
    SELF.maxnumassociateother := 50;
    SELF.maxnumfamilyother := 50;
    SELF.maxnumfamilyclose := 50;
    SELF.maxnumparent := 50;
    SELF.maxnumspouse := 50;
    SELF.maxnumsubject := 50;
    SELF.maxnumneighbor := 0;
    //if want to match phone shell results then can't filter off any output
    // SELF.maxnumassociate := 99;
    // SELF.maxnumassociateother := 99;
    // SELF.maxnumfamilyother := 99;
    // SELF.maxnumfamilyclose := 99;
    // SELF.maxnumparent := 99;
    // SELF.maxnumspouse := 99;
    // SELF.maxnumsubject := 99;
    // SELF.maxnumneighbor := 99;
    SELF.Maxphonecount := 99;
    SELF.ReturnScore := TRUE;
    SELF.BlankOutDuplicatePhones := FALSE;
    SELF.DedupAgainstInputPhones := FALSE;
   // SELF.IndustryClass := 'OTHER';
	//SELF := le;
	SELF := [];
END;

// soap := PROJECT(sort(Input(firstname !='incoming_firstname'), firstname, lastname), intoSOAP(LEFT, counter));
 soap := PROJECT(Input, intoSOAP(LEFT, counter));

Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout errx(soap le) := TRANSFORM
	SELF.Phone_Shell.Sources.Source_List_First_Seen := FAILMESSAGE; // Use this field because it is long enough
	SELF.Phone_Shell.Sources.Source_List_Last_Seen := '';
	SELF.Phone_Shell.Gathered_Phone := '';
	SELF := [];
END;

OUTPUT(CHOOSEN(soap, eyeball), NAMED('Sample_SOAP_Input'));

fieldsOfInterest := RECORD
	STRING50 AcctNo := '';
	STRING10 Gathered_Phone := '';
	STRING3 Phone_Score := '';
	STRING200 Source_List := '';
  string200 Source_Date := '';
END;

/*
// This is used when an output of the model_results is in progressive_phone.functions. As we do this output to ensure that this model output matches the 
// output from the model_results in phone_shell.phone_shell_service...well when it's added. (ALL this outputting is done on a dev box.)
soapResults := SOAPCALL(
													soap, 
													RoxieIP, 
													'progressive_phone.progressive_phone_batch_service',
													{soap},  
													DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout),RETRY(1), TIMEOUT(500), LITERAL,
													XPATH('progressive_phone.progressive_phone_batch_serviceResponse/Results/Result/Dataset[@name=\'Function_SCORING_RESULTS\']/Row'),
													PARALLEL(Threads),
													ONFAIL(errX(LEFT)), TIMEOUT(500), RETRY(1)
												);
	output(	soapResults, named('soapResults'));	

slimmedResults := PROJECT(soapResults, TRANSFORM(fieldsOfInterest,
	SELF.AcctNo := LEFT.Phone_Shell.Input_Echo.AcctNo;
	SELF.Gathered_Phone := LEFT.Phone_Shell.Gathered_Phone;
	SELF.Phone_Score := LEFT.Phone_Shell.Phone_Model_Score;
	SELF.Source_List := LEFT.Phone_Shell.Sources.Source_List;
  SELF.Source_Date := left.phone_shell.sources.Source_List_Last_Seen;
	SELF := []));
	
sortedSlim := SORT(slimmedResults, AcctNo, -((UNSIGNED)Phone_Score), Gathered_Phone, -Source_List);

// output(slimmedResults, named('slimmedResults'));
output(sortedSlim, named('slimmedResults'));

errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');

OUTPUT(CHOOSEN(errors, eyeball), NAMED('Sample_Errors'));
OUTPUT(COUNT(errors), NAMED('Total_Number_Of_Errors'));

goodResults := SORT(soapResults (TRIM(Phone_Shell.Gathered_Phone) <> '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) <> ''), Phone_Shell.Input_Echo.AcctNo, -LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);
OUTPUT(CHOOSEN(modelingShell, eyeball), NAMED('Sample_Modeling_Shell'));

OUTPUT(goodResults,, OutputFile + '_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(modelingShell,, OutputFile + '_ModelingLayout_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

OUTPUT(CHOOSEN(goodResults, eyeball), NAMED('Sample_Success'));
OUTPUT(COUNT(goodResults), NAMED('Total_Number_Of_Success'));
*/
rec_out := record(progressive_phone.layout_progressive_batch_out)
	string8 search_date;
	string8 subj_phone_date_last;
	unsigned6 did;
	integer1 sort_order_position;
end;

rec_out errx2(soap le) := TRANSFORM
	SELF.service_version := FAILMESSAGE; // Use this field because it is long enough
	// SELF.Phone_Shell.Sources.Source_List_Last_Seen := '';
	// SELF.Phone_Shell.Gathered_Phone := '';
	SELF := [];
END;
soapResults2 := SOAPCALL(
													soap, 
													RoxieIP, 
													'progressive_phone.progressive_phone_batch_service',
													{soap},  
													DATASET(rec_out),RETRY(1), TIMEOUT(500), LITERAL,
													XPATH('progressive_phone.progressive_phone_batch_serviceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
													PARALLEL(Threads),
													ONFAIL(errx2(LEFT)), TIMEOUT(500), RETRY(1)
												);


output(	soapResults2, named('soapResults2'));	
OUTPUT(soapResults2,, OutputFile + '_ProductOutput_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

//for model validation on ECL side
//tmpGoodResults := PROJECT(goodResults, TRANSFORM(
//  phone_Shell.Layout_Phone_Shell_Temp.Phone_Shell_Layout, SELF := LEFT, SELF :=[]));
//OUTPUT(choosen(tmpGoodResults,eyeball), NAMED('Total_Number_Of_TmpSuccess'));
//OUTPUT(tmpGoodResults,, OutputFile + '_tmpPS' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

// fieldsOfInterest := RECORD
	// STRING50 AcctNo := '';
	// STRING10 Gathered_Phone := '';
	// STRING3 Phone_Score := '';
	// STRING200 Source_List := '';
// END;
slimmedResults2 := PROJECT(soapResults2, TRANSFORM(fieldsOfInterest,
	SELF.AcctNo := LEFT.AcctNo;
	SELF.Gathered_Phone := LEFT.Subj_PHone10;
	SELF.Phone_Score := (string) LEFT.sort_order_position;//LEFT.Phone_Model_Score;
	// SELF.Source_List := LEFT.Sources.Source_List;
	SELF := []));
	
// sortedSlim := SORT(slimmedResults, AcctNo, -((UNSIGNED)Phone_Score), Gathered_Phone, -Source_List);

output(slimmedResults2, named('slimmedResults2'));
// OUTPUT(sortedSlim,, OutputFile + '_' + ThorLib.wuid() + '_Slimmed_Results.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

/*
output(soapResults,,OutputFile,CSV(heading(single), quote('"')));// modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);

//for progressive output
// errors := soapResults (TRIM(Phone_Shell.Gathered_Phone) = '' AND TRIM(Phone_Shell.Sources.Source_List_Last_Seen) = '');
slimmed := soapResults(acctno != '__BATCH__' and subj_phone10 != '');
output(slimmed(subj_phone10 = ''), named('errors'));
//errors := soapResults;
output(choosen(soap,eyeball), named('soap'));
output(count(slimmed), named('soapResultsCnt'));
output(choosen(slimmed, eyeball), named('slimmed'));
//output(slimmed,,OutputFile,CSV(heading(single), quote('"')));// modelingShell := SORT(Phone_Shell.To_Modeling_Shell(goodResults, DataRestrictionMask), AcctNo, -LENGTH(TRIM(Source_List)), Gathered_Ph);
output(count(Input), named('input'));
output(Input, named('input2'));
output(Input,, 'PhoneInput_' + ThorLib.wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), OVERWRITE);

OUTPUT(SLIMMED(ROYALTY_TYPE != 'EFX_DATA_MART'));
OUTPUT(COUNT(SLIMMED(ROYALTY_TYPE != 'EFX_DATA_MART')), NAMED('EQPCNT'));
OUTPUT(SLIMMED(ROYALTY_TYPE = 'EFX_DATA_MART'), NAMED('EQP_HITS'));
OUTPUT(COUNT(SLIMMED(ROYALTY_TYPE = 'EFX_DATA_MART')), NAMED('EQPHITSCNT'));
output(slimmed(subj_phone_type_new  = 'RL'), named('REL'));
output(COUNT(slimmed(subj_phone_type_new  = 'RL')), named('REL_COUNT'));

//output(soap, named('soap'));

*/
	