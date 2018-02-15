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
	HistoryDate := 999999;


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

layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	


f1 := IF(no_of_records <= 0, dataset( infile_name, layout_input,  thor), 
CHOOSEN(DATASET(infile_name, layout_input,  thor), no_of_records));

f := DISTRIBUTE(f1, RANDOM());



Risk_Indicators.layout_input into_did_input(f le) := TRANSFORM
	SELF.seq := (integer)le.accountnumber;
	SELF.fname := le.firstname;
	SELF.mname := le.middlename;
	SELF.lname := le.lastname;
	SELF.in_streetAddress := le.streetaddress;
	SELF.in_city := le.city;
	SELF.in_state := le.state;
	SELF.in_zipCode := le.zip;
	SELF.phone10 := le.homephone;
	SELF.ssn := le.ssn;
	SELF.dob := le.dateofbirth;
	SELF.wphone10 := le.workphone;
	// SELF. := le.Income;
	SELF.dl_number := le.dlnumber;
	SELF.dl_state := le.dlstate;
	// SELF. := le.Balance;
	// SELF. := le.ChargeOffDate;
	// SELF. := le.FomerLast;
	SELF.email_address := le.email;
	SELF.employer_name := le.company;
	// SELF. := le.HistoryDateYYYYMM;
	
	SELF := [];
END;


did_results:=Scoring_Project_Macros.IID_macro(f,threads,roxieIP,dppapurpose,GLBPurpose,DataRestrictionMask,HistoryDate); 
																										

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
	SELF.account := (string)le.accountnumber;
	SELF.name_first := le.firstname;
	SELF.name_last := le.lastname;
	SELF.street_addr := le.streetaddress;
	SELF.P_City_name := le.city;
	SELF.St := le.state;
	SELF.z5 := le.zip;
	SELF.Home_Phone := le.homephone;
	SELF.Ssn := le.ssn;
	SELF.DOB := le.dateofbirth;
	SELF.Work_Phone := le.workphone;
	self.historydateyyyymm := 999999 ;
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


//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT60_Paro_Global_Layout;			 
END;
Scoring_Project_Macros.MAC_PROD_BATCH_Soapcall(it60_in,Global_output_lay, roxieIP, 'RiskWise.IT1O_Batch_Service', it60_results, threads);


// OUTPUT(it60_results(errorcode!=''), NAMED('it60_errors'));

it60_results_0 := project(it60_results, transform(recordof(it60_results),
                  self.acctno := left.account;
									self := left));
									
								
// fin_layout := record
// recordof(it60_results);
// unsigned6 did;
// end;

Global_output_lay xform(did_results l, it60_results_0 r) := TRANSFORM
self.did := l.did;
self := r;
end;

res := JOIN(did_results, it60_results_0, left.acctno = right.acctno, xform(left, right));


// final_layout := record
// recordof(res);
	// #if(include_internal_extras)
		// RiskProcessing.layout_internal_extras;
	// #end	
// end;	


Global_output_lay xform1(res l, f r) := TRANSFORM
	#if(include_internal_extras)
		self.DID := l.did; 
		self.historydate := (string)r.HistoryDateYYYYMM;
		self.FNamePop := r.firstname<>'';
		self.LNamePop := r.lastname<>'';
		self.AddrPop := r.streetaddress<>'';
		self.SSNLength := (string)(length(trim(r.ssn))) ;
		self.DOBPop := r.dateofbirth<>'';
		// self.EmailPop := r.email<>'';
		// self.IPAddrPop := r.ipaddress<>'';
		self.HPhnPop := r.homephone<>'';
	#end;
	self := l;
	self := [];
	
	end;
	
	final_output:=join(res,f,left.acctno=(string)right.accountnumber ,xform1(left, right));										
									
op_final2 := output(final_output,, outfile_name, thor,compressed, OVERWRITE);

return op_final2;
endmacro;
