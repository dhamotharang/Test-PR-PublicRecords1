//reads thor file of DIDs and makes SOAPcall to AMEX.AdditionalDataService()

// this script took 77 hours to run on the 200 way hitting the dev64 roxie

//                    
#option ('hthorMemoryLimit', 1000);


unsigned record_limit :=   10000;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 1;   //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string8 DataRestrictionMask := '00000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax
unsigned1 glba := 5;
unsigned1 dppa := 0;
boolean isFCRA := false;
unsigned1 bsVersion := 2;
integer historydateyyyymm := 200912;
//====================================================
//=============  input-output file names  ============
//====================================================

nm := 'AMEX-relatives additional data - dev64 roxie';
#workunit('name', nm);
  //=============  input-output files  ======================
   infile_name   := '~dvstemp::out::amex_unique_reldids_with_best_pii';

   outfile_name := '~dvstemp::out::AMEX_job1_process5_relatives_output_test10k';

ds_in := dataset (infile_name, amex.layouts.inputProc1, csv(quote('"')));


//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service
bs_service := 'AMEX.AdditionalDataService';
//roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
roxieIP := RiskWise.Shortcuts.Dev64RoxieIP;
// roxieIP := RiskWise.Shortcuts.Dev32RoxieIP ;

//====================================================
//=====================  R U N  ======================
//====================================================
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
output(choosen(ds_in, eyeball), named('input_dids'));

l := RECORD
  STRING old_account_number;
  AMEX.layouts.Layout_amex_addtional_SoapCall;
END;
	
l assignAccount (ds_input le) := TRANSFORM
  SELF.old_account_number := (string)le.did;
  SELF.Account := (STRING)le.did;
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
  SELF.LnBranded := false;
	SELF.ProbationOverride := false;
	SELF.SuppressNearDups := true;	
  SELF := le;
  SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT));

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
output (choosen(outRecs1, eyeball), named('additional_data_sample'));
OUTPUT(outRecs1, , outfile_name);  //thor file of results used by Process3
IF (EXISTS (res_err1), OUTPUT (res_err1, , outfile_name1 + '_err', CSV(QUOTE('"'))));
