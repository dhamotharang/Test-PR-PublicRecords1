EXPORT Paro_IT60_XML_Macro (roxie_ip,Gatewaysdummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT scoring, risk_indicators, riskwise, ut;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways_dummy := Gatewaysdummy;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

include_internal_extras := true;
boolean isFCRA := false;
UNSIGNED1 DPPAPurpose := 3;
UNSIGNED1 GLBPurpose := 1;
UNSIGNED1 BSversion := 41;
STRING DataRestrictionMask := '00000000000001';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								// byte 14 restricts EN FCRA (will always be restricted in non-fcra)
Gateway := DATASET([], Gateway.Layouts.Config);

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

f := IF(no_of_records > 0, CHOOSEN(DATASET(ut.foreign_prod_boca + Infile_name,layout_prii, thor ), no_of_records),
													DATASET(ut.foreign_prod_boca + Infile_name, layout_prii, THOR));




													
// Output(CHOOSEN(f, 25), NAMED('prii_prep_input'));

Risk_Indicators.layout_input into_did_input(f le) := TRANSFORM
	SELF.seq := (integer)le.Account;
	SELF.fname := le.First;
	SELF.mname := le.MiddleIni;
	SELF.lname := le.Last;
	SELF.in_streetAddress := le.Addr;
	SELF.in_city := le.City;
	SELF.in_state := le.State;
	SELF.in_zipCode := le.Zip;
	SELF.phone10 := le.Hphone;
	SELF.ssn := le.Socs;
	SELF.dob := le.DOB;
	SELF.wphone10 := le.Wphone;
	// SELF. := le.Income;
	SELF.dl_number := le.DRLC;
	SELF.dl_state := le.DRLCState;
	// SELF. := le.Balance;
	// SELF. := le.ChargeOffDate;
	// SELF. := le.FomerLast;
	SELF.email_address := le.Email;
	SELF.employer_name := le.Cmpy;
	// SELF. := le.HistoryDateYYYYMM;
	
	SELF := [];
END;


Didappend_in := PROJECT(f, into_did_input(LEFT));

							
did_results := risk_indicators.iid_getDID_prepOutput(Didappend_in,
																										DPPAPurpose, 
																										GLBPurpose,
																										isFCRA,
																										BSversion,
																										DataRestrictionMask,
																										append_best := 0,
																										gateways := Gateway,
																										BSOptions := 0);
																										

// Output(CHOOSEN(did_results, 50), NAMED('did_append_results'));


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
it60_in := PROJECT(f,into_IT_input(LEFT, 2));

Scoring.MAC_PROD_Soapcall(it60_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.RiskWiseMainIT1O', it60_results, threads);

it60_results_0 := project(it60_results, transform(recordof(it60_results),
                  self.acctno := left.account;
									self := left));
									
// Output(CHOOSEN(it60_results_0, 25), NAMED('IT60_SOAPCALL_results'));	

								
fin_layout := record
recordof(it60_results);
unsigned6 did;
end;

fin_layout xform(did_results l, it60_results_0 r) := TRANSFORM
self.did := l.did;
self := r;
end;

final_result := JOIN(did_results, it60_results_0, left.seq = (integer)right.acctno, xform(left, right));

rd := record
did_results.seq;
did := MIN(group, did_results.did);
end;

min_did := table(did_results, rd, seq);

res:=join(final_result,min_did,left.acctno=(string)right.seq and left.did=right.did,transform(recordof(fin_layout),self:=left));	

final_layout := record
recordof(res);
	#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	#end	
end;	


final_layout xform1(res l, it60_in r) := TRANSFORM
	#if(include_internal_extras)
		self.DID := l.did; 
		self.historydate := (string)r.HistoryDateYYYYMM;
		self.FNamePop := r.first<>'';
		self.LNamePop := r.last<>'';
		self.AddrPop := r.addr<>'';
		self.SSNLength := (string)(length(trim(r.socs))) ;
		self.DOBPop := r.dob<>'';
		// self.EmailPop := r.email<>'';
		// self.IPAddrPop := r.ipaddress<>'';
		self.HPhnPop := r.hphone<>'';
	#end;
	self := l;
	self := [];
	
	end;
	
	final_output:=join(res,it60_in,left.acctno=(string)right.account ,xform1(left, right));	
								

op_final2 := output(final_output,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


fin_out := sequential(op_final2);

return fin_out;
endmacro;