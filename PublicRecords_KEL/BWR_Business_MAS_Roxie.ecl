/* PublicRecords_KEL.BWR_Business_MAS_Roxie */
Threads := 1;
RecordsToRun := 100; // 100;
eyeball := 120;

InputFile := '~temp::kel::ally_01_business_uat_sample_100k_20181015.csv'; //100k file
// InputFile := '~temp::kel::ally_01_business_uat_sample_1m_20181015.csv'; //1m file

OutputFile := '~ak::out::PublicRecs::Business::Sprint6'+ ThorLib.wuid() ;

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
	SELF := LEFT, 
 	// SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;

soapLayout := RECORD
  STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
  DATASET(PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout) input;
  INTEGER ScoreThreshold;
end;

	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80;
	END;
	
ResultSet:= PublicRecords_KEL.FnRoxie_GetBusAttrs(inDataReadyDist, Options);

OUTPUT(CHOOSEN(inDataReady, eyeball), NAMED('Raw_input'));
OUTPUT( ResultSet, NAMED('Results') );

Passed := ResultSet(TRIM(BusInputAccountEcho) <> '');
Failed := ResultSet(TRIM(BusInputAccountEcho) = ''); 

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

output(Passed,,OutputFile, CSV(heading(single), quote('"')));