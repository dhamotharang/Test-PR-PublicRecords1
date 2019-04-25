#workunit('name','NonFCRA-it51 and it61-processes');
#option ('hthorMemoryLimit', 1000)

IMPORT scoring, risk_indicators;

// Settings
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; // nonfcra roxiebatch

UNSIGNED1 parallel_threads := 30;  // max number of parallel threads = 30
UNSIGNED1 DPPAPurpose := 3;
UNSIGNED1 GLBPurpose := 1;
STRING DataRestrictionMask := '00000000000001';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								// byte 14 restricts EN FCRA (will always be restricted in non-fcra)
STRING tribcode1 := 'it51';
STRING tribcode2 := 'it61';


// Input File Layout
layout_prii := RECORD
	STRING Account;
	STRING First;
	STRING MiddleIni;
	STRING Last;
	STRING Addr;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Hphone;
	STRING Socs;
	STRING DOB;
	STRING Wphone;
	STRING Income;
	STRING DRLC;
	STRING DRLCState;
	STRING Balance;
	STRING ChargeOffDate;
	STRING FomerLast;
	STRING Email;
	STRING Cmpy;
	INTEGER HistoryDateYYYYMM;
END;
// f := DATASET('~jpyon::in::bofa_807_file2_ciid_v2_in',layout_prii,CSV(QUOTE('"')));
f := CHOOSEN(DATASET('~jpyon::in::bofa_807_file2_ciid_v2_in',layout_prii, CSV(QUOTE('"'))),5);
OUTPUT(f);

// Layout for call to IT Service
layout_IT_soap := RECORD	
	STRING4 tribcode := '';
	STRING30 account := '';
	STRING15 first := '';
	STRING20 last := '';
	STRING50 addr := '';
	STRING30 city := '';
	STRING2 state := '';
	STRING5 zip := '';
	STRING9 socs := '';
	STRING8 dob := '';
	STRING10 hphone := '';
	STRING10 wphone := '';
	STRING20 drlc := '';
	STRING2 drlcstate := '';
	STRING2 debttype := '';
	STRING8 chargeoffdate := '';
	STRING8 opendate := '';
	STRING8 lastpymt := '';
	STRING6 chargeoffamt := '';
	STRING6 balance := '';
	STRING4 internaluse := '';
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	STRING DataRestrictionMask;
	INTEGER HistoryDateYYYYMM;
	DATASET(risk_indicators.Layout_Gateways_In) gateways;
	BOOLEAN OutcomeTrackingOptOut;
END;


// mapping to IT input
layout_IT_soap into_IT_input(f le, UNSIGNED version) := TRANSFORM
	SELF.tribcode := IF(version=1, tribcode1, tribcode2);
	// SELF.HistoryDateYYYYMM := 999999;	// uncomment this if you want realtime
	SELF.dppapurpose := dppapurpose;
	SELF.glbpurpose := glbpurpose;
	SELF.gateways := DATASET([], risk_indicators.Layout_Gateways_In);
	SELF.datarestrictionmask := DataRestrictionMask;
	self.debttype :='08'; //* medical recover score is 08. bankcard recover score is 02
	self.OutcomeTrackingOptOut := True; //set to True to turn off Scout logging dataset
	SELF := le;
	SELF := [];
END;
it51_in := PROJECT(f,into_IT_input(LEFT, 1));
it61_in := PROJECT(f,into_IT_input(LEFT, 2));
OUTPUT(it51_in, NAMED('it51_in'));
OUTPUT(it61_in, NAMED('it61_in'));


// Soapcall the query, once for it51 and once for it61
Scoring.MAC_PROD_Soapcall(it51_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it51_results, parallel_threads);
Scoring.MAC_PROD_Soapcall(it61_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it61_results, parallel_threads);


OUTPUT(it51_results, NAMED('it51_results'));
OUTPUT(it61_results, NAMED('it61_results'));
OUTPUT(it51_results(errorcode!=''), NAMED('it51_errors'));
OUTPUT(it61_results(errorcode!=''), NAMED('it61_errors'));
OUTPUT(it51_results,,'~tsteil::out::it51_out',CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(it61_results,,'~tsteil::out::it61_out',CSV(HEADING(single), QUOTE('"')), OVERWRITE);
