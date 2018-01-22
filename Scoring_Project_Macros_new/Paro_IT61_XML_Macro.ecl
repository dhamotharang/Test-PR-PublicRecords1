EXPORT Paro_IT61_XML_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


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

STRING tribcode2 := 'it61';


// Input File Layout
rec_input := RECORD
  string account_number;
  string date_added;
  string source_info;
  string loginid;
  string datarestrictionmask;
  string first;
  string last;
  string addr;
  string city;
  string state;
  string zip;
  string hphone;
  string socs;
  string dob;
 END;

 
 f1 := DISTRIBUTE(IF(no_of_records = 0, dataset( Infile_name, rec_input, CSV(HEADING(single), QUOTE('"'))),
                choosen(dataset ( Infile_name, rec_input,CSV(HEADING(single), QUOTE('"'))), no_of_records)), RANDOM());



 lay := record
 rec_input- [account_number];
 String account;
 end;
 
 f := PROJECT(f1, TRANSFORM(lay, self.account := left.account_number;
																 self := left;));



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

Scoring.MAC_PROD_Soapcall(it61_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it61_results, threads);



it61_results_0 := project(it61_results, transform(recordof(it61_results),
                  self.acctno := left.account;
									self := left));
									

op_final2 := output(it61_results_0,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


fin_out := sequential(op_final2);

return fin_out;

endmacro;
