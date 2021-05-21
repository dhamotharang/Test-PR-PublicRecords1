
#workunit('name','MAS FCRA Consumer dev156 1 thread');
IMPORT PublicRecords_KEL, RiskWise, STD, Gateway, UT, SALT38, SALTRoutines;
/* PublicRecords_KEL.BWR_FCRA_MAS_Roxie */
threads := 1;

RoxieIP := RiskWise.shortcuts.Dev156;
NeutralRoxieIP:= RiskWise.Shortcuts.staging_neutral_roxieIP;
// PCG_Dev := riskwise.shortcuts.gw_personContext;

InputFile := '~mas::uatsamples::consumer_fcra_100k_07102019.csv';
//InputFile := '~bbraaten::in::personfcra_lexids_w20200811-114047.csv';//lexids appended from FCRA vault file aug 2020
// InputFile := '~mas::uat::mas_fcra_10k_sample_20200707.csv';
// InputFile := '~mas::uatsamples::consumer_fcra_1m_07092019.csv';
// InputFile := '~mas::uatsamples::consumer_nonfcra_iptest_04232020.csv'; //Samesample as NonFCRA only testing IP validation


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
GLBA := 0  : STORED('GLBPurposeValue'); // FCRA isn't GLBA restricted
DPPA := 0  : STORED('DPPAPurposeValue'); // FCRA isn't DPPA restricted
DataPermissionMask := '0000000000000';  
DataRestrictionMask := '1000010000000100000000000000000000000000000000000'; 
Include_Minors := TRUE;
Include_Inferred_Performance := FALSE;
Retain_Input_Lexid := FALSE;//keep what we have on input
Append_PII := FALSE;//keep what we have on input

Is_Prescreen := false;
// Is_Prescreen := TRUE;

// Inteded Purpose for FCRA. Stubbing this out for now so it can be used in the settings output for now.
Intended_Purpose := ''; 
// Intended_Purpose := 'PRESCREENING'; 

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
// histDate := '0';
// histDate := '20190116'; 
histDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// Score_threshold := 90;

// Output additional file in Master Layout
// Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
// Output_Master_Results := FALSE;
Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
// Output_SALT_Profile := FALSE;
Output_SALT_Profile := TRUE;

// Use default list of allowed sources
AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
// Do not exclude any additional sources from allowed sources dataset.
ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);

IncludeTargusGW := FALSE;

// Parameter needed to turn CCPA on for Targus -- has to use #STORED since IsFCRA isn't a parameter passed to the soapcall
#STORED('IsFCRAValue', TRUE);

NeutralRoxie_GW := DATASET([{'neutralroxie', NeutralRoxieIP}], Gateway.Layouts.Config);
// SELF.Gateways := 	DATASET([{'neutralroxie', NeutralRoxieIP},
									//	{'delta_personcontext', PCG_Dev}], Gateway.Layouts.Config);
									
Empty_GW := DATASET([TRANSFORM(Gateway.Layouts.Config, 
							SELF.ServiceName := ''; 
							SELF.URL := ''; 
							SELF := [])]);

Targus_GW := IF(IncludeTargusGW, project(riskwise.shortcuts.gw_targus_sco, TRANSFORM(Gateway.Layouts.Config, self := left, self := [])),
							Empty_GW);  
							
Input_Gateways := (NeutralRoxie_GW + Targus_GW)(URL <> '');

RecordsToRun := 0;
eyeball := 100;

OutputFile := '~USERNAME::out::PersonFCRA_Roxie_100k_Current_TICKETNUMBER_'+ ThorLib.wuid();

prii_layout := RECORD
    STRING Account             ;
    STRING FirstName           ;
    STRING MiddleName          ;
    STRING LastName            ;
    STRING StreetAddressLine1  ;
    STRING StreetAddressLine2  ;
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
p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"'), HEADING(SINGLE)));
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
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN IsMarketing;
	BOOLEAN IncludeMinors;
	BOOLEAN RetainInputLexid;
	BOOLEAN appendpii;
	BOOLEAN isprescreen;
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) AllowedSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) ExcludeSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	BOOLEAN AllowInferredPerformance;
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := TRUE;
	EXPORT STRING ArchiveDate := histDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING IntendedPurpose := Intended_Purpose; // FCRA only
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
	EXPORT BOOLEAN IncludeMinors := Include_Minors;
	EXPORT BOOLEAN RetainInputLexid := Retain_Input_Lexid;
	EXPORT BOOLEAN BestPIIAppend := Append_PII; //do not append best pii for running
	EXPORT BOOLEAN IncludeInferredPerformance := Include_Inferred_Performance; 
END;


soapLayout trans (pp le):= TRANSFORM 
// SELF.CustomerId := le.CustomerId;
    SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout,
        SELF := LEFT;
        SELF := []));   
    SELF.Gateways := Input_Gateways;
    SELF.ScoreThreshold := Settings.LexIDThreshold;
    SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
    SELF.DataPermissionMask := Settings.Data_Permission_Mask;
    SELF.GLBPurpose := Settings.GLBAPurpose;
    SELF.DPPAPurpose := Settings.DPPAPurpose;
    SELF.IncludeMinors := Settings.IncludeMinors;
		SELF.isprescreen := is_prescreen;
    SELF.IsMarketing := FALSE;
    SELF.OutputMasterResults := Output_Master_Results;
	SELF.AllowedSourcesDataset := AllowedSourcesDataset;
	SELF.ExcludeSourcesDataset := ExcludeSourcesDataset;
	SELF.RetainInputLexid := Settings.RetainInputLexid;
	SELF.appendpii := Settings.BestPIIAppend; //do not append best pii for running
	SELF.AllowInferredPerformance := Include_Inferred_Performance; //do not append best pii for running
END;

soap_in := PROJECT(pp, trans(LEFT));

OUTPUT(CHOOSEN(P, eyeball), NAMED('Sample_Input'));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

  // ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(PP, Score_threshold);
  
  // output( Choosen(PP, eyeball), named('raw_input'));
    
  // OUTPUT( ResultSet, NAMED('Results') );
	

layout_MAS_Test_Service_output := RECORD
    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

layout_MAS_Test_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
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

Passed := bwr_results(TRIM(G_ProcErrorCode) = '');
Failed := bwr_results(TRIM(G_ProcErrorCode) <> '');

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

LayoutMaster_With_Extras := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster;
	STRING G_ProcErrorCode;
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
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA;
	STRING G_ProcErrorCode;
END;

Passed_with_Extras := 
	JOIN(p, Passed, LEFT.Account = RIGHT.MasterResults.P_InpAcct, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Person := 
	JOIN(p, Passed, LEFT.Account = RIGHT.Results.P_InpAcct, 
		TRANSFORM(Layout_Person,
			SELF := RIGHT.Results, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
      
Error_Inputs := JOIN(DISTRIBUTE(p, HASH64(Account)), DISTRIBUTE(Passed_Person, HASH64(P_InpAcct)), LEFT.Account = RIGHT.P_InpAcct, TRANSFORM(prii_layout, SELF := LEFT), LEFT ONLY, LOCAL); 
OUTPUT(Error_Inputs,,OutputFile+'_Error_Inputs', CSV (QUOTE('"')), OVERWRITE, expire(45));

  
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Person, eyeball), NAMED('Sample_FCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"')), expire(45)));
OUTPUT(Passed_Person,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')), expire(45));
	
Output(ave(Passed, time_ms), named('average_time_ms')); 

	
Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Person, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));