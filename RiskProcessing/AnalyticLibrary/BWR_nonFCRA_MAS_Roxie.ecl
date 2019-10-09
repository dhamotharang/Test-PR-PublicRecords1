﻿/* PublicRecords_KEL.BWR_nonFCRA_MAS_Roxie */
IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;

threads := 1;

roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;

InputFile := '~temp::kel::consumer_nonfcra_100k.csv';
// InputFile := '~temp::kel::consumer_nonfcra_1mm.csv'; //1 million

/*
Data Setting 		NonFCRA
DRMFares = 0 //FARES - bit 1
DRMExperian =	0 - //FARES bit 15
DRMTransUnion =	0 //TCH - bit 10
DRMADVO =	0 //ADVO bit 12
DRMExperianFCRA =	0 //ECHF bit 14
DPMSSN =	1 //use_DeathMasterSSAUpdates - bit 10
DPMFDN =	1 //use_FDNContributoryData - bit 11
DPMDL =	1 //use_InsuranceDLData - bit 13
GLBA 	= 1 
DPPA 	= 1 
*/ 
GLBA := 1;
DPPA := 1;
DataPermissionMask := '0000000001101';  
DataRestrictionMask := '0000000000000000000000000000000000000000000000000'; 

// CCPA Options;
LexIdSourceOptout := 1;
TransactionId := '';
BatchUID := '';
GCID := 0;

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
Output_SALT_Profile := FALSE;
// Output_SALT_Profile := TRUE;

RecordsToRun := 10;
eyeball := 120;

OutputFile := '~ak::out::PublicRecs::nonFCRA_AnalyticalLibrary_'+ ThorLib.wuid() ;

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
p := IF (RecordsToRun = 0, p_in, CHOOSEN (p_in, RecordsToRun));
PP := PROJECT(P(Account != 'Account'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout, 
SELF.historydate := if(histDate = '0', LEFT.historydate, histDate); 
SELF := LEFT;
// SELF := [];
));

soapLayout := RECORD
  // STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN IsMarketing;
  UNSIGNED1 LexIdSourceOptout;
  STRING _TransactionId;
  STRING _BatchUID;
  UNSIGNED6 _GCID;
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := histDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
END;

	// Options := MODULE(PublicRecords_KEL.Interface_Options)
		// EXPORT INTEGER ScoreThreshold := 80;
		// EXPORT BOOLEAN isFCRA := FALSE;
		// EXPORT BOOLEAN OutputMasterResults := TRUE;
	// END;

  // ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(PP, Options);
  
  // output( Choosen(PP, eyeball), named('raw_input'));
   
  // OUTPUT( ResultSet, NAMED('Results') );

layout_MAS_Test_Service_output := RECORD
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Person_NonFCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

soapLayout trans (pp le):= TRANSFORM 
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBPurpose := Settings.GLBAPurpose;
	SELF.DPPAPurpose := Settings.DPPAPurpose;
	SELF.IsMarketing := FALSE;
	SELF.OutputMasterResults := Output_Master_Results;
	SELF.LexIdSourceOptout := LexIdSourceOptout;
	SELF._TransactionId := TransactionId;
	SELF._BatchUID := BatchUID;
	SELF._GCID := GCID;
END;

soap_in := PROJECT(pp, trans(LEFT));

OUTPUT(CHOOSEN(P, eyeball), NAMED('Sample_Input'));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

layout_MAS_Test_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	// SELF.Account := le.Account;
	SELF := [];
END;

bwr_results := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_nonFCRA_Service', 
				{soap_in}, 
				DATASET(layout_MAS_Test_Service_output),
				XPATH('*'),
        RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
        onFail(myFail(LEFT)));

Passed := bwr_results(TRIM(G_ProcErrorCode) = ''); // Use as input to KEL query.
Failed := bwr_results(TRIM(G_ProcErrorCode) <> '');

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

LayoutMaster_With_Extras := RECORD
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
	PublicRecords_KEL.ECL_Functions.Layout_Person_NonFCRA;
	STRING G_ProcErrorCode;
END;

Passed_with_Extras := 
	JOIN(p, Passed, LEFT.Account = RIGHT.MasterResults.P_InpAcct, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Person := 
	JOIN(p, Passed, LEFT.Account = RIGHT.Results.P_InpAcct, 
		TRANSFORM(Layout_Person,
			SELF := RIGHT.Results, //fields from passed
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
    
Error_Inputs := JOIN(DISTRIBUTE(p, HASH64(Account)), DISTRIBUTE(Passed_Person, HASH64(P_InpAcct)), LEFT.Account = RIGHT.P_InpAcct, TRANSFORM(prii_layout, SELF := LEFT), LEFT ONLY); 
OUTPUT(Error_Inputs,,OutputFile+'_Error_Inputs', CSV(QUOTE('"')), OVERWRITE);

	
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Person, eyeball), NAMED('Sample_NonFCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Person,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')));

Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Person, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));