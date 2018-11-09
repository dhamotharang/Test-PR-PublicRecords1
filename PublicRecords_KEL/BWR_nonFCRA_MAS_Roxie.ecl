/* PublicRecords_KEL.BWR_nonFCRA_MAS_Roxie */
IMPORT RiskWise, STD;
IMPORT KEL011 AS KEL;
threads := 1;

RoxieIP := RiskWise.shortcuts.Dev156;

//InputFile := '~temp::kel::consumer_nonfcra_1mm.csv'; //1 million
InputFile := '~temp::kel::consumer_nonfcra_100k.csv';
// InputFile := '~ak::in::specialcases.csv';

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
DataPermission := '0000000001101';  
DataRestrictionMask := '0000000000000000000000000000000000000000000000000'; 

Score_threshold := 80;
// Score_threshold := 90;
RecordsToRun := 100; // 100;
eyeball := 120;

OutputFile := '~ak::out::PublicRecs::nonFCRA::Sprint6_3'+ ThorLib.wuid() ;

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
SELF := LEFT;
// SELF := [];
));

soapLayout := RECORD
  // STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
  DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) input;
  INTEGER ScoreThreshold;
end;

	// Options := MODULE(PublicRecords_KEL.Interface_Options)
		// EXPORT INTEGER ScoreThreshold := 80;
		// EXPORT BOOLEAN isFCRA := FALSE;
	// END;

  // ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(PP, Options);
  
  // output( Choosen(PP, eyeball), named('raw_input'));
   
  // OUTPUT( ResultSet, NAMED('Results') );

layout_MAS_Test_Service_output := RECORD
	PublicRecords_KEL.ECL_Functions.Attr_Layout;
	STRING ErrorCode := '';
END;

soapLayout trans (pp le):= TRANSFORM 
  // SELF.CustomerId := le.CustomerId;
  SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout,
    SELF := LEFT;
    SELF := []));
	SELF.ScoreThreshold := Score_threshold;
END;

soap_in := PROJECT(pp, trans(LEFT));

layout_MAS_Test_Service_output myFail(soap_in le) := TRANSFORM
	SELF.ErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	// SELF.Account := le.Account;
	SELF := [];
END;

bwr_results := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_nonFCRA_Service', 
				// 'publicrecords_kel.MAS_nonFCRA_Service.4', 
				{soap_in}, 
				DATASET(layout_MAS_Test_Service_output),
        RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
        onFail(myFail(LEFT)));

Passed := bwr_results(TRIM(ErrorCode) = ''); // Use as input to KEL query.
Failed := bwr_results(TRIM(ErrorCode) <> '');

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

output(Passed,,OutputFile, CSV(heading(single), quote('"')));
