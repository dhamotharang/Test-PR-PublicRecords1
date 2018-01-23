 EXPORT Paro_IT61_XML_Macro (roxie_ip,Gatewaysdummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


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

STRING tribcode2 := 'it61';

include_internal_extras := true;
boolean isFCRA := false;
UNSIGNED1 DPPAPurpose := 3;
UNSIGNED1 GLBPurpose := 1;
UNSIGNED1 BSversion := 41;
STRING DataRestrictionMask := '00000000000001';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
																								// byte 14 restricts EN FCRA (will always be restricted in non-fcra)
Gateway := DATASET([], Gateway.Layouts.Config);
	HistoryDate := 999999;

// Input File Layout

 
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	


f1:= IF(no_of_records <= 0, dataset( infile_name, layout_input,  thor), 
CHOOSEN(DATASET( infile_name, layout_input, thor), no_of_records));


 lay := record
 layout_input- [accountnumber];
 String account;
 end;
 
 f := PROJECT(f1, TRANSFORM(lay, self.account := (string)left.accountnumber;
																 self := left;));




Risk_Indicators.layout_input into_did_input(f le) := TRANSFORM
	SELF.seq := (integer)le.account;
	SELF.fname := le.firstname;
	// SELF.mname := le.MiddleIni;
	SELF.lname := le.lastname;
	SELF.in_streetAddress := le.streetaddress;
	SELF.in_city := le.city;
	SELF.in_state := le.state;
	SELF.in_zipCode := le.zip;
	SELF.phone10 := le.homephone;
	SELF.ssn := le.ssn;
	SELF.dob := le.dateofbirth;
	// SELF.wphone10 := le.Wphone;
	// SELF. := le.Income;
	// SELF.dl_number := le.DRLC;
	// SELF.dl_state := le.DRLCState;
	// SELF. := le.Balance;
	// SELF. := le.ChargeOffDate;
	// SELF. := le.FomerLast;
	// SELF.email_address := le.Email;
	// SELF.employer_name := le.Cmpy;
	// SELF. := le.HistoryDateYYYYMM;
	
	SELF := [];
END;


did_results:=Scoring_Project_Macros.IID_macro(f1,threads,roxieIP,dppapurpose,GLBPurpose,DataRestrictionMask,HistoryDate); 


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
	SELF.HistoryDateYYYYMM := 999999;	// uncomment this if you want realtime
	SELF.dppapurpose := dppapurpose;
	SELF.glbpurpose := glbpurpose;
	SELF.gateways := DATASET([], risk_indicators.Layout_Gateways_In);
	SELF.datarestrictionmask := DataRestrictionMask;
	self.debttype :='08'; //* medical recover score is 08. bankcard recover score is 02
	SELF.first := le.firstname;
	SELF.last := le.lastname;
	SELF.addr := le.streetaddress;
	SELF.city:= le.city;
	SELF.state := le.state;
	SELF.zip := le.zip;
	SELF.hphone := le.homephone;
	SELF.socs := le.ssn;
	SELF.dob := le.dateofbirth;
	SELF := le;
	SELF := [];
END;
//it60_in := PROJECT(f,into_IT_input(LEFT, 1));
it61_in := PROJECT(f,into_IT_input(LEFT, 2));


//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT61_Paro_Global_Layout;			 
END;


Scoring_Project_Macros.MAC_PROD_xml_Soapcall(it61_in, Global_output_lay, roxieIP, 'RiskWise.RiskWiseMainIT1O', it61_results, threads);



it61_results_0 := project(it61_results, transform(recordof(it61_results),
                  self.acctno := left.account;
									self := left));



// fin_layout := record
// recordof(it61_results_0);
// unsigned6 did;
// end;

Global_output_lay xform(did_results l, it61_results_0 r) := TRANSFORM
self.did := l.did;
self := r;
end;

res := JOIN(did_results, it61_results_0, left.acctno = right.acctno, xform(left, right));


// final_layout := record
// recordof(res);
	// #if(include_internal_extras)
		// RiskProcessing.layout_internal_extras;
	// #end	
// end;	


Global_output_lay xform1(res l, it61_in r) := TRANSFORM
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
	
	final_output:=join(res,it61_in,left.acctno=(string)right.account ,xform1(left, right));										

op_final2 := output(final_output,, outfile_name,thor, compressed,OVERWRITE);


return op_final2;

endmacro;