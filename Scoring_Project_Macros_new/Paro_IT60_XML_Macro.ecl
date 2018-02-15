EXPORT Paro_IT60_XML_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT scoring, risk_indicators, riskwise, ut;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

UNSIGNED1 DPPAPurpose := 3;
UNSIGNED1 GLBPurpose := 1;
STRING DataRestrictionMask := '00000000000001';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								// byte 14 restricts EN FCRA (will always be restricted in non-fcra)
//STRING tribcode1 := 'it60';
STRING tribcode2 := 'it60';




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


f1 := IF(no_of_records = 0, dataset(ut.foreign_prod + Infile_name, layout_prii, thor), choosen(dataset (ut.foreign_prod + Infile_name, layout_prii, thor), no_of_records));

f := Distribute(f1, Random());


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
it60_in := DISTRIBUTE(PROJECT(f,into_IT_input(LEFT, 2)), Random());

Scoring.MAC_PROD_Soapcall(it60_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it60_results, threads);

it60_results_0 := project(it60_results, transform(recordof(it60_results),
                  self.acctno := left.account;
									self := left));
									

op_final2 := output(it60_results_0,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


fin_out := sequential(op_final2);

return fin_out;
endmacro;

