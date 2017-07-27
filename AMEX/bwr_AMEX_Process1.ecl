

//Reads CSV file on thor and makes SOAPcalls to risk_indicators.Boca_Shell and appends ITA data
//                                   RUN on hTHOR
//
#workunit('name','AMEX Process 1');
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
#stored('DataRestrictionMask','1    0');
//#stored('DataRestrictionMask','1    1'); //use this when isFCRA=TRUE to restrict Experian Data.

IMPORT Risk_Indicators, RiskWise, Models;
boolean isFCRA := false;
unsigned record_limit :=   5;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 10;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
string8 DataRestrictionMask := '00000000' : stored('DataRestrictionMask');	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax
unsigned1 glba := 0;
unsigned1 dppa := 5;
integer historydateyyyymm := 200912;

  //=============  input-output files  ======================
   infile_name   := '~gwhitaker::in::AMEX_job1_process1';
// infile_name   := '~gwhitaker::in::AMEX_job2_process1';
// infile_name   := '~gwhitaker::in::AMEX_job3_process1';
  //  *** use the below input when processing relatives ***
//infile_name   := '~gwhitaker::in::AMEX_job1_process1_relDIDs';
//infile_name   := '~gwhitaker::in::AMEX_job2_process1_relDIDs';
//infile_name   := '~gwhitaker::in::AMEX_job3_process1_relDIDs';

   outfile_name1 := '~gwhitaker::out::AMEX_job1_process1_output';	// used by process 3
// outfile_name1 := '~gwhitaker::out::AMEX_job2_process1_output';	// used by process 3
// outfile_name1 := '~gwhitaker::out::AMEX_job3_process1_output';	// used by process 3
   outfile_name2 := '~gwhitaker::in::AMEX_job1_process2';       // used by process 2
// outfile_name2 := '~gwhitaker::in::AMEX_job2_process2';       // used by process 2
// outfile_name2 := '~gwhitaker::in::AMEX_job3_process2';       // used by process 2
  //====================================================
  //=============  Service settings ====================
  //====================================================
	bs_service := if (isFCRA, 'risk_indicators.Boca_Shell_FCRA','risk_indicators.Boca_Shell');

  roxieIP := if (isFCRA,RiskWise.Shortcuts.prod_batch_fcra ,RiskWise.Shortcuts.prod_batch_neutral);    // Roxiebatch

// use below roxie for testing	
//roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP ;//staging Roxie
  //====================================================
  //=============== RUN  PROCESS 1 ======================
  //====================================================

  
  //++++++++ T E S T     D  A T A ++++++++
// STRING seq := 'TEST ACCOUNT 1';
// STRING DID := '';
// STRING FirstName := 'GREG';
// STRING MiddleName := '' ;
// STRING LastName := 'WHITAKER';
// STRING StreetAddress := '529 NE 21 AVE 4';
// STRING City := 'DEERFIELD BEACH';
// STRING State := 'FL';
// STRING Zip := '33441';
// STRING DateOfBirth := '19651111';
// STRING SSN := '262378564';
// STRING PHONE := '';

// ds_in := dataset([{seq, DID ,FirstName ,MiddleName ,LastName , StreetAddress, 
                   // City , State , Zip , DateOfBirth, SSN , PHONE, historydateyyyymm}],amex.layouts.inputProc1);
  //++++++++  E N D    O F   T E S T   D A T A  +++++++++
	
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
  //************************************************
	//  only recent 3 addresses for ita logic does this matter.
	//************************************************
ita := Models.get_LeadIntegrity_Attributes(clam_grp);
output(ita, named('ita'));

amex.layouts.outputProc1   combineIt(models.layouts.layout_LeadIntegrity_attributes_batch  l, s r) := transform
   self.bs := r;
   self.ita := l;
	 self := r;
	 self := [];
end;

bocaShell_ITA := join(ita, s, (integer)left.seq=right.seq, combineIt(left, right));

output(bocaShell_ita,named('bocaShell_ita'));
	
amex.layouts.outputProc1 getold(amex.layouts.outputProc1 le, l ri) :=	TRANSFORM
  SELF.seq := le.bs.seq;  //need seq for process 3 JOIN operation.
	SELF.Account := ri.old_account_number;
	SELF := le;
END;

res := JOIN (bocaShell_ITA,p_f,LEFT.bs.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

//pull account and did out for process 2 to use as input.
res2 := project(res,transform(amex.layouts.inputProc2, self.did := left.bs.did; self := left));

OUTPUT (choosen(res,eyeball), NAMED ('result'));
IF (EXISTS (res_err), OUTPUT (choosen(res_err,eyeball), NAMED ('res_err')));

OUTPUT (res, , outfile_name1,  overwrite);
IF (EXISTS (res_err), OUTPUT (res_err, , outfile_name1 + '_err', CSV(QUOTE('"')), overwrite));
OUTPUT(res2, , outfile_name2,  overwrite);
