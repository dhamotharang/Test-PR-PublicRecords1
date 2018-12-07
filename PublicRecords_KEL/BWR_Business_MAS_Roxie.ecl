/* PublicRecords_KEL.BWR_Business_MAS_Roxie */
IMPORT RiskWise, STD;


Threads := 1;
RecordsToRun := 0; // 100;
eyeball := 120;

historyDate := 0; // Set to 0 to use ArchiveDate on input file. 
// historyDate := 20181128; // Set to 0 to use ArchiveDate on input file. 
Score_threshold := 80;
Output_Master_Results := TRUE;
RoxieIP := RiskWise.shortcuts.Dev156;

InputFile := '~temp::kel::ally_01_business_uat_sample_100k_20181015.csv'; //100k file
// InputFile := '~temp::kel::ally_01_business_uat_sample_1m_20181015.csv'; //1m file

OutputFile := '~cdal::BusinessPop_PublicRecs_11262018'+ ThorLib.wuid() ;

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
	SELF.ArchiveDate := IF(historyDate = 0, LEFT.ArchiveDate, (STRING)HistoryDate);
	SELF := LEFT, 
	// SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;

soapLayout := RECORD
	// STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
	INTEGER ScoreThreshold;
	BOOLEAN OutputMasterResults;
end;

// Uncomment this code to run as test harness on Thor instead of SOAPCALL to Roxie
// Options := MODULE(PublicRecords_KEL.Interface_Options)
	// EXPORT INTEGER ScoreThreshold := Score_threshold;
// END;
	
// ResultSet:= PublicRecords_KEL.FnRoxie_GetBusAttrs(inDataReadyDist, Options);

layout_MAS_Business_Service_output := RECORD
	DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster) MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	DATASET(PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA) Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING ErrorCode := '';
END;

soapLayout trans (inDataReadyDist le):= TRANSFORM 
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.ScoreThreshold := Score_threshold;
	SELF.OutputMasterResults := Output_Master_Results;
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


Passed := ResultSet(TRIM(Results[1].BusInputAccountEcho) <> '');
Failed := ResultSet(TRIM(Results[1].BusInputAccountEcho) = ''); 

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

Layout_Business := RECORD
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA;
	STRING ErrorCode;
END;

Passed_with_Extras := SORT(
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.MasterResults[1].BusInputAccountEcho, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults[1], //fields from passed
			SELF := LEFT, //input performance fields
			SELF.ErrorCode := RIGHT.ErrorCode,
			SELF := []),
		INNER, KEEP(1)),
	BusInputUIDAppend);
	
Passed_Business := SORT(
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.Results[1].BusInputAccountEcho, 
		TRANSFORM(Layout_Business,
			SELF := RIGHT.Results[1], //fields from passed
			SELF := LEFT, //input performance fields
			SELF.Errorcode := RIGHT.ErrorCode,
			SELF := []),
		INNER, KEEP(1)),
	BusInputUIDAppend);
	
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Business, eyeball), NAMED('Sample_NonFCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Business,,OutputFile, CSV(HEADING(single), QUOTE('"')));