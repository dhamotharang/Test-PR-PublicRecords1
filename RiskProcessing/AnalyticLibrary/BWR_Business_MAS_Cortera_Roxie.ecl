﻿/* PublicRecords_KEL.BWR_Business_MAS_Roxie */
IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;
Threads := 1;

// RoxieIP := RiskWise.shortcuts.Dev156;
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

Exclude_Consumer_Shell := FALSE; //if TRUE, bypasses consumer logic and sets all consumer shell fields to blank/0.

RecordsToRun := 0;
eyeball := 120;

AllowedSources := ''; // Stubbing this out for use in settings output for now. To be used to turn on DNBDMI by setting to 'DNBDMI'
OverrideExperianRestriction := FALSE; // Stubbing this out for use in settings output for now. To be used to control whether Experian Business Data (EBR and CRDB) is returned.

// OutputFile := '~lweiner::out::PublicRecs::Business_AnalyticalLibrary_'+ ThorLib.wuid() ;
OutputFile := '~Calbrecht::out::PublicRecs::Business_AnalyticalLibrary_'+ ThorLib.wuid() ;

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
END;
inData := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));
OUTPUT(CHOOSEN(inData, eyeball), NAMED('inData'));
inDataRecs := IF (RecordsToRun = 0, inData, CHOOSEN (inData, RecordsToRun));
inDataReady := PROJECT(inDataRecs(AccountNumber != 'AccountNumber'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout, 
	SELF.ArchiveDate := IF(historyDate = '0', LEFT.ArchiveDate, (STRING)HistoryDate);
	SELF := LEFT, 
	SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;

soapLayout := RECORD
	// STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBA_Purpose;
	UNSIGNED1 DPPA_Purpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN ExcludeConsumerShell;
	BOOLEAN IsMarketing;
	
	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN BIPAppendReAppend;
	BOOLEAN BIPAppendIncludeAuthRep;
	BOOLEAN OverrideExperianRestriction;

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
	STRING ErrorCode := '';
END;

soapLayout trans (inDataReadyDist le):= TRANSFORM 
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
	SELF := LEFT;
	SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBA_Purpose := Settings.GLBAPurpose;
	SELF.DPPA_Purpose := Settings.DPPAPurpose;
	SELF.IsMarketing := FALSE;
	SELF.OutputMasterResults := Output_Master_Results;
	SELF.ExcludeConsumerShell := Exclude_Consumer_Shell;
	SELF.BIPAppendScoreThreshold := Settings.BusinessLexIDThreshold;
	SELF.BIPAppendWeightThreshold := Settings.BusinessLexIDWeightThreshold;
	SELF.BIPAppendPrimForce := Settings.BusinessLexIDPrimForce;
	SELF.BIPAppendReAppend := Settings.BusinessLexIDReAppend;
	SELF.BIPAppendIncludeAuthRep := Settings.BusinessLexIDIncludeAuthRep;
	SELF.OverrideExperianRestriction := Settings.Override_Experian_Restriction;
END;

soap_in := PROJECT(inDataReadyDist, trans(LEFT));

OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

layout_MAS_Business_Service_output myFail(soap_in le) := TRANSFORM
	SELF.ErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
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


Passed := ResultSet(TRIM(Results.BusInputAccountEcho) <> '');
Failed := ResultSet(TRIM(Results.BusInputAccountEcho) = ''); 

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

LayoutMaster_With_Extras := RECORD
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster;
	STRING ErrorCode;
END;

Layout_Business := RECORD
    STRING BusInputAccountEcho;
		STRING10	B2bHistoryBuild;
		INTEGER3	B2bTLCntEv;
		INTEGER3	B2bTLCnt2Y;
		INTEGER3	B2bTLInCarrCnt2Y;
		INTEGER3	B2bTLInFltCnt2Y;
		INTEGER3	B2bTLInMatCnt2Y;
		INTEGER3	B2bTLInOpsCnt2Y;
		INTEGER3	B2bTLInOthCnt2Y;
		DECIMAL7_2	B2bTLInCarrPct2Y;
		DECIMAL7_2	B2bTLInFltPct2Y;
		DECIMAL7_2	B2bTLInMatPct2Y;
		DECIMAL7_2	B2bTLInOpsPct2Y;
		DECIMAL7_2	B2bTLInOthPct2Y;
		STRING10	B2bOldestTLDtEv;
		INTEGER3	B2bOldestTLMsinceEv;
		STRING10	B2bOldestTLDt2Y;
		STRING10	B2bNewestTLDt2Y;
		INTEGER3	B2bOldestTLMsince2Y;
		INTEGER3	B2bNewestTLMsince2Y;
		INTEGER3	B2bActvTLCnt;
		INTEGER3	B2bActvTLInCarrCnt;
		INTEGER3	B2bActvTLInFltCnt;
		INTEGER3	B2bActvTLInMatCnt;
		INTEGER3	B2bActvTLInOpsCnt;
		INTEGER3	B2bActvTLInOthCnt;
		DECIMAL7_2	B2bActvTLInCarrPct;
		DECIMAL7_2	B2bActvTLInFltPct;
		DECIMAL7_2	B2bActvTLInMatPct;
		DECIMAL7_2	B2bActvTLInOpsPct;
		DECIMAL7_2	B2bActvTLInOthPct;	
		INTEGER3	B2bActvTLCntArch1Y;
		INTEGER3	B2bActvTLInCarrCntArch1Y;
		INTEGER3	B2bActvTLInFltCntArch1Y;
		INTEGER3	B2bActvTLInMatCntArch1Y;
		INTEGER3	B2bActvTLInOpsCntArch1Y;
		INTEGER3	B2bActvTLInOthCntArch1Y;
		DECIMAL9_4	B2bActvTLCntGrow1Y;
		DECIMAL9_4	B2bActvTLCntInCarrGrow1Y;
		DECIMAL9_4	B2bActvTLCntInFltGrow1Y;
		DECIMAL9_4	B2bActvTLCntInMatGrow1Y;
		DECIMAL9_4	B2bActvTLCntInOpsGrow1Y;
		DECIMAL9_4	B2bActvTLCntInOthGrow1Y;
		INTEGER4	B2bActvTLBalTot;
		INTEGER4	B2bActvTLBalInCarrTot;
		INTEGER4	B2bActvTLBalInFltTot;
		INTEGER4	B2bActvTLBalInMatTot;
		INTEGER4	B2bActvTLBalInOpsTot;
		INTEGER4	B2bActvTLBalInOthTot;
		DECIMAL7_2	B2bActvTLBalInCarrPct;
		DECIMAL7_2	B2bActvTLBalInFltPct;
		DECIMAL7_2	B2bActvTLBalInMatPct;
		DECIMAL7_2	B2bActvTLBalInOpsPct;
		DECIMAL7_2	B2bActvTLBalInOthPct;	
		STRING6	B2bActvTLBalTotBin;
		STRING6	B2bActvTLBalInCarrTotBin;
		STRING6	B2bActvTLBalInFltTotBin;
		STRING6	B2bActvTLBalInMatTotBin;
		STRING6	B2bActvTLBalInOpsTotBin;
		STRING6	B2bActvTLBalInOthTotBin;
		INTEGER4	B2bActvTLBalAvg;
		INTEGER4	B2bActvTLBalInCarrAvg;
		INTEGER4	B2bActvTLBalInFltAvg;
		INTEGER4	B2bActvTLBalInMatAvg;
		INTEGER4	B2bActvTLBalInOpsAvg;
		INTEGER4	B2bActvTLBalInOthAvg;
		INTEGER4	B2bActvTLBalArch1Y;
		INTEGER4	B2bActvTLBalInCarrArch1Y;
		INTEGER4	B2bActvTLBalInFltArch1Y;
		INTEGER4	B2bActvTLBalInMatArch1Y;
		INTEGER4	B2bActvTLBalInOpsArch1Y;
		INTEGER4	B2bActvTLBalInOthArch1Y;
		DECIMAL9_4	B2bActvTLBalGrow1Y;
		DECIMAL9_4	B2bActvTLBalInCarrGrow1Y;
		DECIMAL9_4	B2bActvTLBalInFltGrow1Y;
		DECIMAL9_4	B2bActvTLBalInMatGrow1Y;
		DECIMAL9_4	B2bActvTLBalInOpsGrow1Y;
		DECIMAL9_4	B2bActvTLBalInOthGrow1Y;
		STRING6	B2bActvTLBalGrowIndex1Y;
		STRING6	B2bActvTLBalInCarrGrowIndex1Y;
		STRING6	B2bActvTLBalInFltGrowIndex1Y;
		STRING6	B2bActvTLBalInMatGrowIndex1Y;
		STRING6	B2bActvTLBalInOpsGrowIndex1Y;
		STRING6	B2bActvTLBalInOthGrowIndex1Y;
		INTEGER4	B2bTLBalMax2Y;
		INTEGER4	B2bTLBalInCarrMax2Y;
		INTEGER4	B2bTLBalInFltMax2Y;
		INTEGER4	B2bTLBalInMatMax2Y;
		INTEGER4	B2bTLBalInOpsMax2Y;
		INTEGER4	B2bTLBalInOthMax2Y;
		STRING10	B2bMaxTLBalDt2Y;
		STRING10	B2bMaxTLBalInCarrDt2Y;
		STRING10	B2bMaxTLBalInFltDt2Y;
		STRING10	B2bMaxTLBalInMatDt2Y;
		STRING10	B2bMaxTLBalInOpsDt2Y;
		STRING10	B2bMaxTLBalInOthDt2Y;
		INTEGER3	B2bMaxTLBalMsince2Y;
		INTEGER3	B2bMaxTLBalInCarrMsince2Y;
		INTEGER3	B2bMaxTLBalInFltMsince2Y;
		INTEGER3	B2bMaxTLBalInMatMsince2Y;
		INTEGER3	B2bMaxTLBalInOpsMsince2Y;
		INTEGER3	B2bMaxTLBalInOthMsince2Y;
		STRING6	B2bTLWMaxBalSeg2Y;
		STRING6	B2bActvTLWorstPerfIndex;
		STRING6	B2bActvTLWorstPerfInCarrIndex;
		STRING6	B2bActvTLWorstPerfInFltIndex;
		STRING6	B2bActvTLWorstPerfInMatIndex;
		STRING6	B2bActvTLWorstPerfInOpsIndex;
		STRING6	B2bActvTLWorstPerfInOthIndex;
		INTEGER3	B2bActvTLW1pDpdCnt;
		INTEGER3	B2bActvTLW31pDpdCnt;
		INTEGER3	B2bActvTLW61pDpdCnt;
		INTEGER3	B2bActvTLW91pDpdCnt;
		DECIMAL7_2	B2bActvTLW1pDpdPct;
		DECIMAL7_2	B2bActvTLW31pDpdPct;
		DECIMAL7_2	B2bActvTLW61pDpdPct;
		DECIMAL7_2	B2bActvTLW91pDpdPct;
		INTEGER4	B2bBalOnActvTL1pDpdTot;
		INTEGER4	B2bBalOnActvTL31pDpdTot;
		INTEGER4	B2bBalOnActvTL61pDpdTot;
		INTEGER4	B2bBalOnActvTL91pDpdTot;
		DECIMAL7_2	B2bBalOnActvTL1pDpdPct;
		DECIMAL7_2	B2bBalOnActvTL31pDpdPct;
		DECIMAL7_2	B2bBalOnActvTL61pDpdPct;
		DECIMAL7_2	B2bBalOnActvTL91pDpdPct;
		INTEGER4	B2bBalOnActvTL1pDpdTotArch1Y;
		INTEGER4	B2bBalOnActvTL31pDpdTotArch1Y;
		INTEGER4	B2bBalOnActvTL61pDpdTotArch1Y;
		INTEGER4	B2bBalOnActvTL91pDpdTotArch1Y;
		DECIMAL9_4	B2bBalOnActvTL1pDpdGrow1Y;
		DECIMAL9_4	B2bBalOnActvTL31pDpdGrow1Y;
		DECIMAL9_4	B2bBalOnActvTL61pDpdGrow1Y;
		DECIMAL9_4	B2bBalOnActvTL91pDpdGrow1Y;
		STRING6	B2bTLWorstPerfIndex2Y;
		STRING6	B2bTLWorstPerfInCarrIndex2Y;
		STRING6	B2bTLWorstPerfInFltIndex2Y;
		STRING6	B2bTLWorstPerfInMatIndex2Y;
		STRING6	B2bTLWorstPerfInOpsIndex2Y;
		STRING6	B2bTLWorstPerfInOthIndex2Y;
		STRING10	B2bTLWorstPerfDt2Y;
		STRING10	B2bTLWorstPerfInCarrDt2Y;
		STRING10	B2bTLWorstPerfInFltDt2Y;
		STRING10	B2bTLWorstPerfInMatDt2Y;
		STRING10	B2bTLWorstPerfInOpsDt2Y;
		STRING10	B2bTLWorstPerfInOthDt2Y;
		INTEGER3	B2bTLWorstPerfMsince2Y;
		INTEGER3	B2bTLWorstPerfInCarrMsince2Y;
		INTEGER3	B2bTLWorstPerfInFltMsince2Y;
		INTEGER3	B2bTLWorstPerfInMatMsince2Y;
		INTEGER3	B2bTLWorstPerfInOpsMsince2Y;
		INTEGER3	B2bTLWorstPerfInOthMsince2Y;
		INTEGER3	B2bTLCnt24Mfull;
		INTEGER3	B2bTLInCarrCnt24Mfull;
		INTEGER3	B2bTLInFltCnt24Mfull;
		INTEGER3	B2bTLInMatCnt24Mfull;
		INTEGER3	B2bTLInOpsCnt24Mfull;
		INTEGER3	B2bTLInOthCnt24Mfull;
		STRING30	B2bIndOfMonWTLStr24Mfull;
		STRING30	B2bIndOfMonWTLInCarrStr24Mfull;
		STRING30	B2bIndOfMonWTLInFltStr24Mfull;
		STRING30	B2bIndOfMonWTLInMatStr24Mfull;
		STRING30	B2bIndOfMonWTLInOpsStr24Mfull;
		STRING30	B2bIndOfMonWTLInOthStr24Mfull;
		INTEGER3	B2bMonWTLCnt24Mfull;
		INTEGER3	B2bMonWTLInCarrCnt24Mfull;
		INTEGER3	B2bMonWTLInFltCnt24Mfull;
		INTEGER3	B2bMonWTLInMatCnt24Mfull;
		INTEGER3	B2bMonWTLInOpsCnt24Mfull;
		INTEGER3	B2bMonWTLInOthCnt24Mfull;
		DECIMAL7_2	B2bTLBalVol24Mfull;
		DECIMAL7_2	B2bTLBalInCarrVol24Mfull;
		DECIMAL7_2	B2bTLBalInFltVol24Mfull;
		DECIMAL7_2	B2bTLBalInMatVol24Mfull;
		DECIMAL7_2	B2bTLBalInOpsVol24Mfull;
		DECIMAL7_2	B2bTLBalInOthVol24Mfull;	
END;

Passed_with_Extras := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.MasterResults.BusInputAccountEcho, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
			SELF := LEFT, //input performance fields
			SELF := []),
		INNER, KEEP(1));
	
Passed_Business := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.Results.BusInputAccountEcho, 
		TRANSFORM(Layout_Business,
			SELF := RIGHT.Results, //fields from passed
			SELF := LEFT, //input performance fields
			SELF := []),
		INNER, KEEP(1));
	
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Business, eyeball), NAMED('Sample_NonFCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout.csv', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Business,,OutputFile + '.csv', CSV(HEADING(single), QUOTE('"')));	

Settings_Dataset := PublicRecords_KEL.ECL_Functions.fn_make_settings_dataset(Settings);
		
OUTPUT(Settings_Dataset, NAMED('Attributes_Settings'));

SALT_AttributeResults := IF(Output_SALT_Profile, SALTRoutines.SALT_Profile_Run_Everything(Passed_Business, 'SALT_Results'), 0);

IF(Output_SALT_Profile, OUTPUT(SALT_AttributeResults, NAMED('Total_Fields_Profiled')));
