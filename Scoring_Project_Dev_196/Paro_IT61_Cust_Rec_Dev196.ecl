#workunit('name','NonFCRA-it51 and it61-processes');
#option ('hthorMemoryLimit', 1000);

IMPORT scoring, risk_indicators, riskwise, ut;

// Settings
roxieIP := riskwise.shortcuts.Dev196; // nonfcra roxiebatch

UNSIGNED1 parallel_threads := 1;  // max number of parallel threads = 30
UNSIGNED1 DPPAPurpose := 3;
UNSIGNED1 GLBPurpose := 1;
STRING DataRestrictionMask := '00000000000001';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								// byte 14 restricts EN FCRA (will always be restricted in non-fcra)
//STRING tribcode1 := 'it60';
STRING tribcode2 := 'it61';

//outfile_name1 := '~sghatti::out::Paro_IT60_' + ut.GetDate;
outfile_name2 := '~nkoubsky::out::Paro_IT61_Dev196_' + thorlib.wuid();


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

// f := DATASET('~cgrinsteiner::in::Paro_IT61',layout_prii, CSV(QUOTE('"')));

f := DATASET('~sghatti::in::Paro_IT61',layout_prii, thor );

// OUTPUT(f);

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
END;


// mapping to IT input
layout_IT_soap into_IT_input(f le, UNSIGNED version) := TRANSFORM
	SELF.tribcode :=  tribcode2;
	// SELF.HistoryDateYYYYMM := 999999;	// uncomment this if you want realtime
	SELF.dppapurpose := dppapurpose;
	SELF.glbpurpose := glbpurpose;
	SELF.gateways := DATASET([], risk_indicators.Layout_Gateways_In);
	SELF.datarestrictionmask := DataRestrictionMask;
	self.debttype :='08'; //* medical recover score is 08. bankcard recover score is 02
	SELF := le;
	SELF := [];
END;
//it60_in := PROJECT(f,into_IT_input(LEFT, 1));
it61_in := PROJECT(f,into_IT_input(LEFT, 2));
// OUTPUT(it60_in, NAMED('it60_in'));
// OUTPUT(it61_in, NAMED('it61_in'));


// Soapcall the query, once for it60 and once for it61
//Scoring.MAC_PROD_Soapcall(it60_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it60_results, parallel_threads);
Scoring.MAC_PROD_Soapcall(it61_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it61_results, parallel_threads);



it61_results_0 := project(it61_results, transform(recordof(it61_results),
                  self.acctno := left.account;
									self := left));
									
// OUTPUT(it60_results, NAMED('it60_results'));
// OUTPUT(it61_results, NAMED('it61_results'));

//op_final1 := output(it60_results,, outfile_name1, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
op_final2 := output(it61_results_0,, outfile_name2, CSV(HEADING(single), QUOTE('"')));


sequential(op_final2);

EXPORT Paro_IT61_Cust_Rec := 'Success';

