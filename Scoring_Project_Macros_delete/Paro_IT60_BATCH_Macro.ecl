EXPORT Paro_IT60_BATCH_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT scoring, risk_indicators, riskwise, ut;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways_dummy := Gateway_dummy;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


include_internal_extras := true;
Gateway := DATASET([], Gateway.Layouts.Config);
boolean isFCRA := false;
UNSIGNED1 DPPAPurpose := 3;
UNSIGNED1 GLBPurpose := 1;
UNSIGNED1 BSversion := 41;
STRING DataRestrictionMask := '00000000000001';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								// byte 14 restricts EN FCRA (will always be restricted in non-fcra)
//STRING tribcode1 := 'it51';
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

// f1 := choosen(dataset (ut.foreign_prod + infile_name, layout_prii, csv(quote('"'))), no_of_records);
f1 := IF(no_of_records = 0, dataset(ut.foreign_prod + Infile_name, layout_prii, thor), choosen(dataset (ut.foreign_prod + Infile_name, layout_prii, thor), no_of_records));











f := DISTRIBUTE(f1, RANDOM());



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
																										

// Layout for call to IT Service
Layout_IT1O_BatchIn := record
  integer Seq := '';	
	string30 acctno := '';
	string30 account := '';
     string15 name_first := '';
     string20 name_last := '';
	 string65 street_addr := '';
     string10 prim_range := '';
	string2 predir := '';	
	string28 prim_name := '';	
	string4 suffix := '';	
	string2 postdir := '';	
	string10 unit_desig := '';	
	string8 sec_range := '';	
	string25 p_city_name := '';	
	string2 st := '';	
	string5 z5 := '';
	string4 z4 := '';
     string9 ssn := '';
     string8 dob := '';
     string10 home_phone := '';
     string10 work_phone := '';
     string20 dl_number := '';
     string2 dl_state := '';
     string2 debttype := '';
     string8 chargeoffdate := '';
     string8 opendate := '';
     string8 lastpymt := '';
     string6 chargeoffamt := '';
     string6 balance := '';
     string4 internaluse := '';
		 unsigned3 HistoryDateYYYYMM;
end;


layout_soap_input := RECORD
	STRING tribcode := tribcode2;
	DATASET(Layout_IT1O_BatchIn) batch_in;
	UNSIGNED1 DPPAPurpose := DPPAPurpose;
	UNSIGNED1 GLBPurpose := GLBPurpose;
	STRING50 DataRestrictionMask := DataRestrictionMask;
	UNSIGNED3 HistoryDateYYYYMM := 0;
	string2 debttype := '08';
	DATASET(risk_indicators.Layout_Gateways_In) gateways;
END;

Layout_IT1O_BatchIn make_batch_in(f le, integer c) := TRANSFORM
	self.seq :=c ;
	SELF.account := le.account;
	SELF.name_first := le.First;
	SELF.name_last := le.Last;
	SELF.street_addr := le.addr;
	SELF.P_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HPhone;
	SELF.Ssn := le.Socs;
	SELF.DOB := le.dob;
	SELF.Work_Phone := le.WPhone;
	self.historydateyyyymm := le.historydateyyyymm ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	self.gateways := DATASET([{'FCRA', roxieIP}], risk_indicators.layout_gateways_in)
	END;
	
	
it60_in := DISTRIBUTE(PROJECT(F, make_rv_in(LEFT, counter)), RANDOM());
// output(it60_in, named ('Soap_in'));


	Scoring.MAC_PROD_Soapcall(it60_in, RiskWise.Layout_IT4O, roxieIP, 'RiskWise.IT1O_Batch_Service', it60_results, threads);


// OUTPUT(it60_results(errorcode!=''), NAMED('it60_errors'));

it60_results_0 := project(it60_results, transform(recordof(it60_results),
                  self.acctno := left.account;
									self := left));
									
								
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


final_layout xform1(res l, f r) := TRANSFORM
	#if(include_internal_extras)
		self.DID := l.did; 
		self.historydate := (string)r.HistoryDateYYYYMM;
		self.FNamePop := r.First<>'';
		self.LNamePop := r.Last<>'';
		self.AddrPop := r.addr<>'';
		self.SSNLength := (string)(length(trim(r.socs))) ;
		self.DOBPop := r.dob<>'';
		// self.EmailPop := r.email<>'';
		// self.IPAddrPop := r.ipaddress<>'';
		self.HPhnPop := r.Hphone<>'';
	#end;
	self := l;
	self := [];
	
	end;
	
	final_output:=join(res,f,left.acctno=(string)right.account ,xform1(left, right));										
									
op_final2 := output(final_output,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


fin_out := sequential(op_final2);

return fin_out;
endmacro;