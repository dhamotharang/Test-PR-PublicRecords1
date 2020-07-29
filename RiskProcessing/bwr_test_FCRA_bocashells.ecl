#workunit('name','fcrashell_baselines');

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

IMPORT Risk_Indicators, RiskWise, riskprocessing, ut;

unsigned record_limit :=   10;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 2;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 25;
string DataRestrictionMask := '10000100010001'; // to restrict fares, experian, transunion and experian FCRA 

//===================  input-output files  ======================
infile_name :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::dvstemp::in::audit_input_file_w20140701-122932';

outfile_name := '~dvstemp::out::audit::fcrashell_baselines_' + thorlib.wuid();

//==================  input file layout  ========================
layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
  END;
  
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
// roxie_IP := RiskWise.Shortcuts.prod_batch_analytics_roxie;    // Roxiebatch
roxie_IP := RiskWise.Shortcuts.staging_neutral_roxieIP;  

// FCRA service settings
bs_service := 'risk_indicators.boca_shell_fcra';
// roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie
roxieIP := RiskWise.Shortcuts.staging_fcra_roxieIP;  
// roxieIP := RiskWise.Shortcuts.dev156;  

//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := dataset (infile_name, layout_input, csv(quote('"')));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.Account;
  SELF.AccountNumber := (STRING)c;

  self.neutral_gateway := roxie_ip;
 
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 12010100';  
	self.historydateyyyymm := 999999;
	self.historyDateTimeStamp := '';  // can populate this with full timestamp if the customer has it
	self.IncludeLnJ := true; // for FCRA juli attributes, include them in the regression testing 
  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;
	self.bsversion := 52;		
	SELF := le;
	SELF := [];
END;
p_f1 := PROJECT (ds_input, assignAccount (LEFT,COUNTER));

// duplicate the same inputs, but change the history dates
p_f2 := project(p_f1, transform(l, self.accountnumber := (string)(100000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201703; self := left));
p_f3 := project(p_f1, transform(l, self.accountnumber := (string)(200000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201010; self := left));

// duplicate the same inputs, but change the bsversion and the history dates
p_f4 := project(p_f1, transform(l, self.accountnumber := (string)(300000 + (unsigned)left.accountnumber), self.historydateyyyymm := 999999; self.bsversion := 50; self := left));
p_f5 := project(p_f1, transform(l, self.accountnumber := (string)(400000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201703; self.bsversion := 50; self := left));
p_f6 := project(p_f1, transform(l, self.accountnumber := (string)(500000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201010; self.bsversion := 50; self := left));

// duplicate the same inputs, but change the bsversion and the history dates
p_f7 := project(p_f1, transform(l, self.accountnumber := (string)(600000 + (unsigned)left.accountnumber), self.historydateyyyymm := 999999; self.bsversion := 41; self := left));
p_f8 := project(p_f1, transform(l, self.accountnumber := (string)(700000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201703; self.bsversion := 41; self := left));
p_f9 := project(p_f1, transform(l, self.accountnumber := (string)(800000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201010; self.bsversion := 41; self := left));

// run all 3 versions at once
// p_f := p_f1 + p_f2 + p_f3 + p_f4 + p_f5 + p_f6;
// p_f := p_f1 + p_f3 + p_f4 + p_f6;  // heather doesn't need history mode with current date unless it's the beginning of the month
p_f := p_f1 ;  // just run 5.0 for this test
// p_f := p_f1 + p_f2 + p_f3 + p_f4 + p_f5 + p_f6 + p_f7 + p_f8 + p_f9 ;  // run the gamut
output(choosen(p_f,eyeball), named('BSInput'));

s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);
		
riskprocessing.layouts.layout_internal_shell_noDatasets getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

OUTPUT (choosen(res, eyeball), NAMED ('result'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
output(count(res_err), named('error_count'));

OUTPUT (res, , outfile_name, csv(quote('"')) );