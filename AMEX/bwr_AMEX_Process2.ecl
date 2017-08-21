

//reads thor file of DIDs and makes SOAPcall to AMEX.AdditionalDataService()
//                    RUN on THOR_200
#workunit('name','AMEX Process 2');
#option ('hthorMemoryLimit', 1000);
#stored('DataRestrictionMask','1    0');
//#stored('DataRestrictionMask','1    1'); //use this when isFCRA=TRUE to restrict Experian Data.

import amex, riskwise;
unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 10;   //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string8 DataRestrictionMask := '00000000' : stored('DataRestrictionMask');	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax
unsigned1 glba := 0;
unsigned1 dppa := 5;
boolean isFCRA := false;
unsigned1 bsVersion := 1;
integer historydateyyyymm := 200912;
//====================================================
//=============  input-output file names  ============
//====================================================
   infile_name   := '~gwhitaker::in::AMEX_job1_process2';
// infile_name   := '~gwhitaker::in::AMEX_job2_process2';
// infile_name   := '~gwhitaker::in::AMEX_job3process2';
   outfile_name1 := '~gwhitaker::out::AMEX_job1_process2_output'; //+ thorlib.wuid();	// this will output your work unit number in your filename
// outfile_name1 := '~gwhitaker::out::AMEX_job2_process2_output'; //+ thorlib.wuid();	// this will output your work unit number in your filename
// outfile_name1 := '~gwhitaker::out::AMEX_job3_process2_output'; //+ thorlib.wuid();	// this will output your work unit number in your filename
//====================================================
//=================== file layouts ===================
//====================================================
layout_input := AMEX.layouts.inputProc2;        //subject DIDs from Process1

//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service
bs_service := 'AMEX.AdditionalDataService';
//roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
//roxieIP := RiskWise.Shortcuts.Dev64RoxieIP;
roxieIP := RiskWise.Shortcuts.Dev32RoxieIP ;

//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := dataset (infile_name, layout_input, thor);
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));

l := RECORD
  STRING old_account_number;
  AMEX.layouts.Layout_amex_addtional_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := (string)le.Account;
  SELF.Account := (STRING)c;
  SELF.DID := (string)le.did;	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
  SELF.HistoryDateYYYYMM := historydateyyyymm;
  SELF.datarestrictionmask := datarestrictionmask;
	SELF.BSVersion := bsVersion;
	SELF.IsFCRA := isFCRA;
	SELF.SSNMask := '';
  SELF.CountRelsAtAddrs := true;
  SELF.MaxRelatives := 0;
  SELF.RelativeDepth := 2;
  SELF.LnBranded := true;
	SELF.ProbationOverride := false;
	SELF.SuppressNearDups := false;	
  SELF := le;
  SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));

s := AMEX.AMEX_SoapCall (PROJECT (p_f, TRANSFORM (AMEX.layouts.Layout_amex_addtional_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

AMEX.layouts.outputProc2 getold(s le, l ri) :=	TRANSFORM
  SELF.seq := (integer)ri.account;  //need seq for process 3 JOIN operation.
  SELF.Account := ri.old_account_number;
  SELF := le;
END;

outRecs1 := JOIN (s,p_f,LEFT.account=RIGHT.account,getold(LEFT,RIGHT));
res_err1 := outRecs1 (errorcode<>'');

OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));
OUTPUT (choosen(p_f,eyeball), named('AMEXInput'));
OUTPUT(outRecs1, , outfile_name1, overwrite);  //thor file of results used by Process3
IF (EXISTS (res_err1), OUTPUT (res_err1, , outfile_name1 + '_err', CSV(QUOTE('"')), overwrite));
