// Tests regular or FCRA BocaShell functionality

// Reads sample data from input file, makes a SOAP call to service specified and (optionally),
// saves results in output file. 
// Before running:
//   set IsFCRA flag (false for regular BocaShell)
//   choose (or define) input file name and, if needed, output file name as well;
//   choose (or define) input layout;
//   check the number of records to read from input;
//   verify the number of parallel SOAP calls (note that 'parallel_calls' params is being ignored now);
//   uncomment file-output, if needed;

IMPORT Risk_Indicators, VM_Misc;

boolean IsFCRA := true;
unsigned record_limit :=  5;     //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 1;  //number of parallel soap calls to make [1..10]

//===================  input-output files  ======================
infile_name  := '~eschepers::in::alltel_bocashell_fcra';
out_name := '~thor_data50::out::alltel_bocashell_fcra_out';


//==================  input file layout  ========================
layout_input := RiskProcessing.test_layouts.prii_layout;
//layout_input := RiskProcessing.test_layouts.layout_slimInput;


//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service
service_name := 'risk_indicators.Boca_Shell';
roxie_ip     := 'http://roxieqavip.br.seisint.com:9876';           //qa-roxie

// Use smth. like this, if there's no vip-roxie, and job is running on 50-way, for instance
// roxie_ip := 'http://10.173.190.' + (STRING)(thorlib.node() % 80 + 1) + ':9876'; //new dev-roxie


// FCRA service settings
service_name_fcra := 'risk_indicators.Boca_Shell_FCRA';
roxie_ip_fcra     := 'http://certfcraroxievip.sc.seisint.com:9876';    //cert fcra-roxie

// Choosing settings depending on whether it is an FCRA run
outfile_name := IF (IsFCRA, out_name + '_fcra', out_name);
bs_service   := TRIM (IF (IsFCRA, service_name_fcra, service_name)); //trimming is required, see #19359
roxieIP      := TRIM (IF (IsFCRA, roxie_ip_fcra, roxie_ip));



//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, layout_input, csv(quote('"')));
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (ds_input, NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.Account;
  SELF.AccountNumber := (STRING)c;
	
  SELF.GLBPurpose  := 1;
  SELF.DPPAPurpose := 1;
  self.neutral_gateway := roxie_ip;
  // this is left for convenience: history date from the input file may be overwritten here
  //  SELF.HistoryDateYYYYMM := le.historydateyyyymm;
	SELF := le;
	SELF := [];
END;
	
layout_soap := record
	Risk_Indicators.Layout_InstID_SoapCall;
end;
	
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
output(p_f);

s_f := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (layout_soap, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);
		
try_2 := JOIN(p_f, s_f(errorcode<>''), (unsigned)LEFT.accountnumber=RIGHT.seq, TRANSFORM(l,SELF := LEFT));
	
s_f2 := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (try_2, TRANSFORM (layout_soap, SELF := LEFT)),
                                                 bs_service, roxieIP, parallel_calls);
	
s := s_f(errorcode='') + s_f2;
	
RiskProcessing.test_layouts.layout_ox getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

OUTPUT (res, NAMED ('result'));
IF (EXISTS (res_err), OUTPUT (res_err, NAMED ('res_err')));

OUTPUT (res, , outfile_name, CSV(QUOTE('"')), overwrite);
IF (EXISTS (res_err), OUTPUT (res_err, , outfile_name + '_err', CSV(QUOTE('"')), overwrite));

/*
//this code is for reading newly created files:
ds := DATASET (out_name, VM_Misc.ri_TestLayouts.layout_ox, CSV(QUOTE('"')));
OUTPUT (ds);
*/