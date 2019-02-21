/* PublicRecords_KEL.BWR_FCRA_MAS_Roxie */
IMPORT PublicRecords_KEL, RiskWise, STD, Gateway, UT, SALT38, SALTRoutines;
threads := 1;

RoxieIP := RiskWise.shortcuts.Dev156;
NeutralRoxieIP:= RiskWise.Shortcuts.Dev156;

//InputFile := '~temp::kel::consumer_fcra_1mm.csv'; //1 million
InputFile := '~temp::kel::consumer_fcra_100k.csv';

/* Data Setting 	FCRA 	
DRMFares = 1 //FARES - bit 1
DRMExperian =	1 - //FARES bit 6
DRMTransUnion =	0 //TCH - bit 10
DRMADVO =	0 //ADVO bit 12
DRMExperianFCRA =	1 //ECHF bit 14
DPMSSN =	0 //use_DeathMasterSSAUpdates - bit 10
DPMFDN =	0 //use_FDNContributoryData - bit 11
DPMDL =	0 //use_InsuranceDLData - bit 13
GLBA 	= 0 
DPPA 	= 0 
*/
GLBA := 0; // FCRA isn't GLBA restricted
DPPA := 0; // FCRA isn't DPPA restricted
DataPermissionMask := '0000000000000';  
DataRestrictionMask := '1000010000000100000000000000000000000000000000000'; 

// Inteded Purpose for FCRA. Stubbing this out for now so it can be used in the settings output for now.
Intended_Purpose := ''; 
// Intended_Purpose := 'PRESCREENING'; 

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
histDate := '0';
// histDate := '20190116';
// histDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// Score_threshold := 90;

// Output additional file in Master Layout
// Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
Output_Master_Results := FALSE;
// Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
// Output_SALT_Profile := FALSE;
Output_SALT_Profile := TRUE;

RecordsToRun := 0;
eyeball := 100;

OutputFile := '~AFA::Consumer_KAS1832_100K_RoxieDev_current_12312018_FCRA'+ ThorLib.wuid() ;
prii_layout := RECORD
    STRING Account             ;
    STRING FirstName           ;
    STRING MiddleName          ;
    STRING LastName            ;
    STRING StreetAddress       ;
    STRING City                ;
    STRING State               ;
    STRING Zip                 ;
    STRING HomePhone           ;
    STRING SSN                 ;
    STRING DateOfBirth         ;
    STRING WorkPhone           ;
    STRING Income              ;
    STRING DLNumber            ;
    STRING DLState             ;
    STRING Balance             ;
    STRING ChargeOffD          ;
    STRING FormerName          ;
    STRING Email               ;
    STRING EmployerName        ;
    STRING historydate;
    STRING LexID;
    STRING IPAddress;
    STRING Perf;
    STRING Proj;
END;
p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));
// P_IN1 := p_in( ACCOUNT IN ['AAAA7833-122054', 'TMOBJUN7088-84991']);
p := IF (RecordsToRun = 0, P_IN, CHOOSEN (P_IN, RecordsToRun));
//p2 := p_in;
//p := p2(Account in ['TMOBSEP7088-158349', 'TMOBSEP7088-87504','TARG4547-221442', 'TMOBJUN7088-196571','AAAA7833-104166']); 
PP := PROJECT(P(Account != 'Account'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout, 
SELF.historydate := if(histDate = '0', LEFT.historydate, histDate);
SELF := LEFT));

soapLayout := RECORD
//  STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBA_Purpose;
	UNSIGNED1 DPPA_Purpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN IsMarketing;
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := TRUE;
	EXPORT STRING ArchiveDate := histDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING PermissiblePurpose := Intended_Purpose; // FCRA only
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
END;


soapLayout trans (pp le):= TRANSFORM 
  // SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.Gateways := PROJECT(ut.ds_oneRecord, 
			TRANSFORM(Gateway.Layouts.Config, 
				SELF.ServiceName := 'neutralroxie'; 
				SELF.URL := NeutralRoxieIP; 
				SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBA_Purpose := Settings.GLBAPurpose;
	SELF.DPPA_Purpose := Settings.DPPAPurpose;
	SELF.IsMarketing := FALSE;
	SELF.OutputMasterResults := Output_Master_Results;
END;

soap_in := PROJECT(pp, trans(LEFT));

OUTPUT(CHOOSEN(P, eyeball), NAMED('Sample_Input'));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

  // ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(PP, Score_threshold);
  
  // output( Choosen(PP, eyeball), named('raw_input'));
    
  // OUTPUT( ResultSet, NAMED('Results') );
	

layout_MAS_Test_Service_output := RECORD
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING ErrorCode := '';
END;

layout_MAS_Test_Service_output myFail(soap_in le) := TRANSFORM
	SELF.ErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	//SELF.Account := le.Account;
	SELF := [];
END;

bwr_results := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_FCRA_Service', 
				{soap_in}, 
				DATASET(layout_MAS_Test_Service_output),
				XPATH('*'),
        RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
        onFail(myFail(LEFT)));

Passed := bwr_results(TRIM(ErrorCode) = '');
Failed := bwr_results(TRIM(ErrorCode) <> '');

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

LayoutMaster_With_Extras := RECORD
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster;
	STRING ErrorCode;
	STRING ln_project_id;
	STRING pf_fraud;
	STRING pf_bad;
	STRING pf_funded;
	STRING pf_declined;
	STRING pf_approved_not_funded; 
	STRING Perf;
	STRING Proj;
END;

Layout_Person := RECORD
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA;
	STRING ErrorCode;
END;

Passed_with_Extras := 
	JOIN(p, Passed, LEFT.Account = RIGHT.MasterResults.InputAccountEcho, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
			SELF := LEFT, //input performance fields
			SELF.ErrorCode := RIGHT.ErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Person := 
	JOIN(p, Passed, LEFT.Account = RIGHT.Results.InputAccountEcho, 
		TRANSFORM(Layout_Person,
			SELF := RIGHT.Results, //fields from passed
			SELF := LEFT, //input performance fields
			SELF.ErrorCode := RIGHT.ErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Person, eyeball), NAMED('Sample_FCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Person,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')));
	
Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Person, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));