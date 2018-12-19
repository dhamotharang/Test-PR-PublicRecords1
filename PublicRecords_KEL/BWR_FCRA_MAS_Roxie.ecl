/* PublicRecords_KEL.BWR_FCRA_MAS_Roxie */
IMPORT RiskWise, STD, Gateway, UT;
IMPORT KEL011 AS KEL;
threads := 1;

RoxieIP := RiskWise.shortcuts.Dev156;

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
GLBA := 0; //not used
DPPA := 0; //not used 
DataPermission := '0000000000000';  
DataRestrictionMask := '1000010000000100000000000000000000000000000000000'; 
NeutralRoxieIP:= RiskWise.Shortcuts.Dev156;   
Score_threshold := 80;
// Score_threshold := 90;
Output_Master_Results := TRUE;
RecordsToRun := 0;
eyeball := 100;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
// histDate := '0';
histDate := '20181218';

OutputFile := '~CDAL::Consumer_Arrest_Bug_100K_RoxieDev_current_12182018_FCRA'+ ThorLib.wuid() ;

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
	BOOLEAN OutputMasterResults;
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
end;


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
	SELF.ScoreThreshold := Score_threshold;
	SELF.OutputMasterResults := Output_Master_Results;
END;

soap_in := PROJECT(pp, trans(LEFT));

OUTPUT(CHOOSEN(P, eyeball), NAMED('Sample_Input'));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

  // ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(PP, Score_threshold);
  
  // output( Choosen(PP, eyeball), named('raw_input'));
    
  // OUTPUT( ResultSet, NAMED('Results') );
	

layout_MAS_Test_Service_output := RECORD
	DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster) MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	DATASET(PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA) Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
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

Passed_with_Extras := SORT(
	JOIN(p, Passed, LEFT.Account = RIGHT.MasterResults[1].InputAccountEcho, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults[1], //fields from passed
			SELF := LEFT, //input performance fields
			SELF.ErrorCode := RIGHT.ErrorCode,
			SELF := []),
		INNER, KEEP(1)),
	InputUIDAppend);
	
Passed_Person := SORT(
	JOIN(p, Passed, LEFT.Account = RIGHT.Results[1].InputAccountEcho, 
		TRANSFORM(Layout_Person,
			SELF := RIGHT.Results[1], //fields from passed
			SELF := LEFT, //input performance fields
			SELF.ErrorCode := RIGHT.ErrorCode,
			SELF := []),
		INNER, KEEP(1)),
	InputUIDAppend);
	
IF(Output_Master_Results, OUTPUT(CHOOSEN(Passed_with_Extras, eyeball), NAMED('Sample_Master_Layout')));
OUTPUT(CHOOSEN(Passed_Person, eyeball), NAMED('Sample_FCRA_Layout'));

IF(Output_Master_Results, OUTPUT(Passed_with_Extras,,OutputFile +'_MasterLayout', CSV(HEADING(single), QUOTE('"'))));
OUTPUT(Passed_Person,,OutputFile, CSV(HEADING(single), QUOTE('"')));