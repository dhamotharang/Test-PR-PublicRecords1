//Reads CSV file on thor and makes SOAPcalls to risk_indicators.Boca_Shell and appends ITA data
//                                   RUN on hTHOR
//

#option ('hthorMemoryLimit', 1000)

// Reads sample data from input file, makes a SOAP call to service specified and (optionally),
// saves results in output file. 
// Before running:
//   choose (or define) input file name and, if needed, output file name as well;
//   choose (or define) input layout;
//   check the number of records to read from input;
//   verify the number of parallel SOAP calls (note that 'parallel_calls' params is being ignored now);
//   uncomment file-output, if needed;
//   check that the data restrictions are set appropriately, specifically  EN and EQ
//   eyeball is how many records you want to see on output, similar to record_limit except this is your intermediate result output count

boolean isFCRA := false;

unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 10;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
boolean RemoveFares := true;	// change this to TRUE for FARES filtering
string8 DataRestrictionMask := '00000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax
unsigned1 glba := 5;
unsigned1 dppa := 0;
integer historydateyyyymm := 200912;

// chunk := '_0_1mill';
// chunk := '_1_2mill';
// chunk := '_2_3mill';
// chunk := '_3_4mill';
// chunk := '_4_5mill';
// chunk := '_5_6mill';
// chunk := '_6_7mill';
// chunk := '_7_8mill';
// chunk := '_8_9mill';
// chunk := '_9_10mill';
// chunk := '_10_11mill';
// chunk := '_11_12mill';
// chunk := '_12_13mill';
// chunk := '_13_14mill';
// chunk := '_14_15mill';
// chunk := '_15_16mill';
// chunk := '_16_17mill';
// chunk := '_17_18mill';
// chunk := '_18_19mill';
// chunk := '_19_20mill';
// chunk := '_20_21mill';
chunk := '_21_22mill';


nm := 'AMEX-relatives non fcra shell rerun' + chunk;
#workunit('name', nm);
  //=============  input-output files  ======================
   infile_name   := '~dvstemp::in::AMEX_rel_input_rerun' + chunk;

   outfile_name := '~dvstemp::out::AMEX_job1_process1_relatives_output_rerun' + chunk;

  //====================================================
  //=============  Service settings ====================
  //====================================================
	bs_service := if (isFCRA, 'risk_indicators.Boca_Shell_FCRA','risk_indicators.Boca_Shell');

  roxieIP := if (isFCRA,RiskWise.Shortcuts.prod_batch_fcra ,RiskWise.Shortcuts.prod_batch_neutral);    // Roxiebatch

ds_in := dataset (infile_name, amex.layouts.inputProc1, csv(quote('"')));
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.seq;
  SELF.AccountNumber := (STRING)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
	self.RemoveFares := RemoveFares;
	self.neutral_gateway := if (isFCRA, RiskWise.Shortcuts.prod_batch_neutral, '');			  
  SELF.HistoryDateYYYYMM := historydateyyyymm;
  SELF.IncludeScore := true;
 			
  SELF := le;
  SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
output(choosen(p_f,eyeball), named('BSInput'));

s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);
// get ITA data
clam := project(s, risk_indicators.Layout_Boca_Shell);
clam_grp := group(clam,seq);

ita := Models.get_ITA_Attributes(clam_grp);
output(choosen(ita,eyeball), named('ita'));

amex.layouts.outputProc1   combineIt(models.layouts.layout_ITA_attributes_batch  l, s r) := transform
   self.bs := r;
   self.ita := l;
	 self := r;
	 self := [];
end;

bocaShell_ITA := join(ita, s, (integer)left.seq=right.seq, combineIt(left, right));
output(choosen(bocaShell_ita, eyeball),named('bocaShell_ita'));
	
amex.layouts.outputProc1 getold(amex.layouts.outputProc1 le, l ri) :=	TRANSFORM
  SELF.seq := le.bs.seq;  //need seq for process 3 JOIN operation.
	SELF.Account := ri.old_account_number;
	SELF := le;
END;

res := JOIN (bocaShell_ITA,p_f,LEFT.bs.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

OUTPUT (choosen(res,eyeball), NAMED ('res'));
OUTPUT (choosen(res_err,eyeball), NAMED ('res_err'));
OUTPUT (res, , outfile_name);



/*

// used to concatenate the results of the relatives bocashells, making sure to include the records which needed to be re-run

#option ('hthorMemoryLimit', 1000);

ds_in := 
	dataset ('~dvstemp::in::AMEX_rel_input_0_1mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_1_2mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_2_3mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_3_4mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_4_5mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_5_6mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_6_7mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_7_8mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_8_9mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_9_10mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_10_11mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_11_12mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_12_13mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_13_14mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_14_15mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_15_16mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_16_17mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_17_18mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_18_19mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_20_21mill', amex.layouts.inputProc1, csv(quote('"'))) +
	dataset ('~dvstemp::in::AMEX_rel_input_21_22mill', amex.layouts.inputProc1, csv(quote('"')));
	// choosen(dataset ('~dvstemp::in::AMEX_rel_input_21_22mill', amex.layouts.inputProc1, csv(quote('"'))), 5);
// output(choosen(ds_in, 5));
	
// ds_out := choosen(dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_21_22mill', amex.layouts.outputProc1, thor), 4);
ds_out := 
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_0_1mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_1_2mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_2_3mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_3_4mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_4_5mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_5_6mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_6_7mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_7_8mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_8_9mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_9_10mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_10_11mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_11_12mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_12_13mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_13_14mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_14_15mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_15_16mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_16_17mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_17_18mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_18_19mill', amex.layouts.outputProc1, thor) +
		dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_19_20mill', amex.layouts.outputProc1, thor) +

	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_20_21mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::AMEX_job1_process1_relatives_output_21_22mill', amex.layouts.outputProc1, thor) +
	
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_20_21mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_21_22mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_18_19mill', amex.layouts.outputProc1, thor) + 
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_17_18mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_16_17mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_14_15mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_13_14mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_11_12mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_8_9mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_3_4mill', amex.layouts.outputProc1, thor) +
	dataset('~dvstemp::out::amex_job1_process1_relatives_output_rerun_0_1mill', amex.layouts.outputProc1, thor); 

output(distribute(ds_out, random()),,'~dvstemp::out::amex_job1_process1_relatives_all', __compressed__);

	
output(choosen(ds_out, 5));


// j := join(ds_in, ds_out, left.seq=right.account,
				// transform(amex.layouts.inputProc1, self := left), 
				// left only);
// output(choosen(j, 50));
// output(j,,'~dvstemp::in::AMEX_rel_input_rerun', csv(quote('"')));




*/


