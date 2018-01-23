EXPORT Paro_IT60_BATCH_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

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


OUTPUT(it60_results(errorcode!=''), NAMED('it60_errors'));

it60_results_0 := project(it60_results, transform(recordof(it60_results),
                  self.acctno := left.account;
									self := left));
									
op_final2 := output(it60_results_0,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


fin_out := sequential(op_final2);

return fin_out;
endmacro;