// #workunit('name','nonfcra-bnk4-Batch');
// #option ('hthorMemoryLimit', 1000);

EXPORT Chase_BNK4_BATCH_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, Risk_Indicators, RiskWise, UT, scoring;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;



/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;

f := IF(no_of_records = 0, dataset(ut.foreign_prod + Infile_name, layout_input,  CSV(HEADING(single), QUOTE('"'))), ChooseN(dataset(ut.foreign_prod + infile_name, layout_input,  CSV(HEADING(single), QUOTE('"'))), no_of_records));
                          

layout_soap_input := RECORD
	string tribcode := '' ;	
	DATASET(Riskwise.Layout_BC1O_BatchIn) batch_in;
	unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	STRING DataRestrictionMask := '';
	integer	HistoryDateyyyymm := 0;
END;

Riskwise.Layout_BC1O_BatchIn make_batch_in(f le, integer c) := transform
	SELF.acctno :=(string) le.accountnumber;
	SELF.name_first := le.firstname;
	SELF.name_last := le.lastname;
	SELF.street_addr := le.streetaddress;
	SELF.p_city_name:= le.CITY;
	SELF.st := le.st_2;
	SELF.z5 := le.ZIP;
	SELF.home_phone := le.homephone;
	SELF.ssn := le.ssn;
	SELF.DOB := le.dateofbirth;
	self.historydateyyyymm := le.historydateyyyymm ;
		
	self.name_company := le.name_company;
	self.street_addr2 := le.street_addr2;
	self.p_city_name_2 := le.p_city_name_2;
	// self.st_2 := le.cmpystate;
	self.z5_2 := le.z5_2;
	self.phoneno := le.phoneno;
	self.fein := le.fein;
	// self.internetcommflag := le.internetcommflag;
	// self.email  := le.emailaddr ;
	// self.emailheadr := le.emailheadr ;
	// self.ip_addr := le.ipaddr;
	// self.apptime := le.apptime;
	
	self := le;
	self := [];
end;

layout_soap_input make_Chase_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(left, c));
	SELF.batch_in := batch;
	SELF.tribcode := 'bnk4';
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	SELF.DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
	SELF.HistoryDateYYYYMM := le.historydateyyyymm;
END;

soap_in := Distribute(project(f, make_Chase_in(LEFT, counter)));
// output(CHOOSEN(soap_in, eyeball), named('sample_soap_in'));

xlayout := RECORD
  RiskWise.Layout_BC1O;
	STRING errorcode;
END;

xlayout myFail(soap_in l) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.account := l.batch_in[1].account;
	SELF := [];
END;


s_f := SOAPCALL(soap_in, roxieIP,
				'RiskWise.BC1O_Batch_Service', {soap_in}, 
				DATASET(xlayout),
        RETRY(retry), TIMEOUT(timeout),
        PARALLEL(threads), onFail(myFail(LEFT)));



op_final := output(s_f,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_out := sequential(op_final);

return fin_out;

endmacro;