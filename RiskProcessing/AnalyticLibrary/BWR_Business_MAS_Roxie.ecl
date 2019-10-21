﻿/* PublicRecords_KEL.BWR_Business_MAS_Roxie */
IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;
Threads := 1;

roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie;

InputFile := '~temp::kel::ally_01_business_uat_sample_100k_20181015.csv'; //100k file
// InputFile := '~temp::kel::ally_01_business_uat_sample_1m_20181015.csv'; //1m file

/* Data Setting 	NonFCRA 	
DRMFares = 0 //FARES - bit 1
DRMExperian =	0 - //FARES bit 6
DRMTransUnion =	0 //TCH - bit 10
DRMADVO =	0 //ADVO bit 12
DRMExperianFCRA =	0 //ECHF bit 14
DRMCortera = 0 // Cortera Header and Tradelines Bit 42
DRMExperianEBR/Bus = 1 // Experian EBR Bit 3
DPMSSN =	0 //use_DeathMasterSSAUpdates - bit 10
DPMFDN =	0 //use_FDNContributoryData - bit 11
DPMDL =	0 //use_InsuranceDLData - bit 13
DPMDNBDMI = 0
DPMSBFE = 0 // SBFE - Bit 12 in Data Permission Mask
GLBA 	= 1 
DPPA 	= 3 
*/
GLBA := 1;
DPPA := 3;
// Bit counter:         12345678901234567890123456789012345678901234567890
DataPermissionMask  := '00000000000000000000000000000000000000000000000000'; 
DataRestrictionMask := '00100000000000000000000000000000000000000000000000'; 

// CCPA Options;
LexIdSourceOptout := 1;
TransactionId := '';
BatchUID := '';
GCID := 0;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
historyDate := '0';
// historyDate := '20190118';
// historyDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// Score_threshold := 90;

// BIP Append options
BIPAppend_Score_Threshold := 75; // Default score threshold for BIP Append. Valid values are 51-100.
BIPAppend_Weight_Threshold := 0;
BIPAppend_PrimForce := FALSE; // Set to TRUE to require an exact match on prim range in the BIP Append.
BIPAppend_ReAppend := TRUE; // Set to FALSE to avoid re-appending BIP IDs if BIP IDs are populated on the input file.
BIPAppend_Include_AuthRep := FALSE; // Determines whether Auth Rep data is used in BIP Append

// Output additional file in Master Layout
// Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
Output_Master_Results := FALSE;
// Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
Output_SALT_Profile := FALSE;
// Output_SALT_Profile := TRUE;

Exclude_Consumer_Attributes := FALSE; //if TRUE, bypasses consumer logic and sets all consumer shell fields to blank/0.

RecordsToRun := 10;
eyeball := 120;

AllowedSources := ''; // Stubbing this out for use in settings output for now. To be used to turn on DNBDMI by setting to 'DNBDMI'
OverrideExperianRestriction := FALSE; // Stubbing this out for use in settings output for now. To be used to control whether Experian Business Data (EBR and CRDB) is returned.

OutputFile := '~lweiner::out::PublicRecs::Business_AnalyticalLibrary_'+ ThorLib.wuid() ;

prii_layout := RECORD
	STRING AccountNumber         ;  
	STRING CompanyName           ;
	STRING AlternateCompanyName  ;
	STRING Addr1                 ;
	STRING City1                 ;
	STRING State1                ;
	STRING Zip1                  ;
	STRING BusinessPhone         ;
	STRING BusinessTin           ;
	STRING BusinessIPAddress     ;
	STRING BusinessURL           ;
	STRING BusinessEmailAddress  ;
	STRING Rep1firstname         ;
	STRING Rep1MiddleName        ;
	STRING Rep1lastname          ;
	STRING Rep1NameSuffix        ;
	STRING Rep1Addr              ;
	STRING Rep1City              ;
	STRING Rep1State             ;
	STRING Rep1Zip               ;
	STRING Rep1SSN               ;
	STRING Rep1DOB               ;
	STRING Rep1Age               ;
	STRING Rep1DLNumber          ;
	STRING Rep1DLState           ;
	STRING Rep1HomePhone         ;
	STRING Rep1EmailAddress      ;
	STRING Rep1FormerLastName    ;
	STRING Rep1LexID             ;
	STRING ArchiveDate           ;
	STRING PowID                 ;
	STRING ProxID                ;
	STRING SeleID                ;
	STRING OrgID                 ;
	STRING UltID                 ;
	STRING SIC_Code              ;
	STRING NAIC_Code             ;
	STRING Rep2firstname         ;
	STRING Rep2MiddleName        ;
	STRING Rep2lastname          ;
	STRING Rep2NameSuffix        ;
	STRING Rep2Addr              ;
	STRING Rep2City              ;
	STRING Rep2State             ;
	STRING Rep2Zip               ;
	STRING Rep2SSN               ;
	STRING Rep2DOB               ;
	STRING Rep2Age               ;
	STRING Rep2DLNumber          ;
	STRING Rep2DLState           ;
	STRING Rep2HomePhone         ;
	STRING Rep2EmailAddress      ;
	STRING Rep2FormerLastName    ;
	STRING Rep2LexID             ;
	STRING Rep3firstname         ;
	STRING Rep3MiddleName        ;
	STRING Rep3lastname          ;
	STRING Rep3NameSuffix        ;
	STRING Rep3Addr              ;
	STRING Rep3City              ;
	STRING Rep3State             ;
	STRING Rep3Zip               ;
	STRING Rep3SSN               ;
	STRING Rep3DOB               ;
	STRING Rep3Age               ;
	STRING Rep3DLNumber          ;
	STRING Rep3DLState           ;
	STRING Rep3HomePhone         ;
	STRING Rep3EmailAddress      ;
	STRING Rep3FormerLastName    ;
	STRING Rep3LexID             ;
	STRING Rep4firstname         ;
	STRING Rep4MiddleName        ;
	STRING Rep4lastname          ;
	STRING Rep4NameSuffix        ;
	STRING Rep4Addr              ;
	STRING Rep4City              ;
	STRING Rep4State             ;
	STRING Rep4Zip               ;
	STRING Rep4SSN               ;
	STRING Rep4DOB               ;
	STRING Rep4Age               ;
	STRING Rep4DLNumber          ;
	STRING Rep4DLState           ;
	STRING Rep4HomePhone         ;
	STRING Rep4EmailAddress      ;
	STRING Rep4FormerLastName    ;
	STRING Rep4LexID             ;
	STRING Rep5firstname         ;
	STRING Rep5MiddleName        ;
	STRING Rep5lastname          ;
	STRING Rep5NameSuffix        ;
	STRING Rep5Addr              ;
	STRING Rep5City              ;
	STRING Rep5State             ;
	STRING Rep5Zip               ;
	STRING Rep5SSN               ;
	STRING Rep5DOB               ;
	STRING Rep5Age               ;
	STRING Rep5DLNumber          ;
	STRING Rep5DLState           ;
	STRING Rep5HomePhone         ;
	STRING Rep5EmailAddress      ;
	STRING Rep5FormerLastName    ;
	STRING Rep5LexID             ;
	STRING ln_project_id         ;
	STRING pf_fraud              ;
	STRING pf_bad                ;
	STRING pf_funded             ;
	STRING pf_declined           ;
	STRING pf_approved_not_funded; 
END;
inData := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));
OUTPUT(CHOOSEN(inData, eyeball), NAMED('inData'));
inDataRecs := IF (RecordsToRun = 0, inData, CHOOSEN (inData, RecordsToRun));
inDataReady := PROJECT(inDataRecs(AccountNumber != 'AccountNumber'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout, 
	SELF.ArchiveDate := IF(historyDate = '0', LEFT.ArchiveDate, (STRING)HistoryDate);
	SELF := LEFT, 
	// SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;

soapLayout := RECORD
	// STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN ExcludeConsumerAttributes;
	BOOLEAN IsMarketing;
	
	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN BIPAppendReAppend;
	BOOLEAN BIPAppendIncludeAuthRep;
  BOOLEAN OverrideExperianRestriction;
	
	UNSIGNED1 LexIdSourceOptout;
  STRING _TransactionId;
  STRING _BatchUID;
  UNSIGNED6 _GCID;
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := historyDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
	EXPORT STRING Allowed_Sources := AllowedSources; // Controls inclusion of DNBDMI data
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
	EXPORT UNSIGNED BusinessLexIDThreshold := BIPAppend_Score_Threshold;
	EXPORT UNSIGNED BusinessLexIDWeightThreshold := BIPAppend_Weight_Threshold;
	EXPORT BOOLEAN BusinessLexIDPrimForce := BIPAppend_PrimForce;
	EXPORT BOOLEAN BusinessLexIDReAppend := BIPAppend_ReAppend;
	EXPORT BOOLEAN BusinessLexIDIncludeAuthRep := BIPAppend_Include_AuthRep;
END;
// Uncomment this code to run as test harness on Thor instead of SOAPCALL to Roxie
// Options := MODULE(PublicRecords_KEL.Interface_Options)
	// EXPORT INTEGER ScoreThreshold := Score_threshold;
// END;
	
// ResultSet:= PublicRecords_KEL.FnRoxie_GetBusAttrs(inDataReadyDist, Options);

layout_MAS_Business_Service_output := RECORD
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

soapLayout trans (inDataReadyDist le):= TRANSFORM 
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBPurpose := Settings.GLBAPurpose;
	SELF.DPPAPurpose := Settings.DPPAPurpose;
	SELF.OverrideExperianRestriction := Settings.Override_Experian_Restriction;
	SELF.IsMarketing := FALSE;
	SELF.OutputMasterResults := Output_Master_Results;
	SELF.ExcludeConsumerAttributes := Exclude_Consumer_Attributes;
	SELF.BIPAppendScoreThreshold := Settings.BusinessLexIDThreshold;
	SELF.BIPAppendWeightThreshold := Settings.BusinessLexIDWeightThreshold;
	SELF.BIPAppendPrimForce := Settings.BusinessLexIDPrimForce;
	SELF.BIPAppendReAppend := Settings.BusinessLexIDReAppend;
	SELF.BIPAppendIncludeAuthRep := Settings.BusinessLexIDIncludeAuthRep;
	SELF.LexIdSourceOptout := LexIdSourceOptout;
	SELF._TransactionId := TransactionId;
	SELF._BatchUID := BatchUID;
	SELF._GCID := GCID;	
END;

soap_in := PROJECT(inDataReadyDist, trans(LEFT));

OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

layout_MAS_Business_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	// SELF.Account := le.Account;
	SELF := [];
END;

ResultSet := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_Business_nonFCRA_Service',
				{soap_in}, 
				DATASET(layout_MAS_Business_Service_output),
				XPATH('*'),
				RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));


OUTPUT(CHOOSEN(inDataReady, eyeball), NAMED('Raw_input'));
OUTPUT( ResultSet, NAMED('Results') );


Passed := ResultSet(TRIM(Results.B_InpAcct) <> '');
Failed := ResultSet(TRIM(Results.B_InpAcct) = ''); 

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

Layout_Business := RECORD
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA;
	STRING G_ProcErrorCode;
END;

Passed_with_Extras := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.MasterResults.B_InpAcct, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Business := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.Results.B_InpAcct, 
		TRANSFORM(Layout_Business,
			SELF := RIGHT.Results, //fields from passed
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
       
Error_Inputs := JOIN(DISTRIBUTE(inDataRecs, HASH64(AccountNumber)), DISTRIBUTE(Passed_Business, HASH64(B_InpAcct)), LEFT.AccountNumber = RIGHT.B_InpAcct, TRANSFORM(prii_layout, SELF := LEFT), LEFT ONLY);  
OUTPUT(Error_Inputs,,OutputFile+'_Error_Inputs', CSV(QUOTE('"')), OVERWRITE);
  
  
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Business, eyeball), NAMED('Sample_NonFCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Business,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')));	

Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Business, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));
