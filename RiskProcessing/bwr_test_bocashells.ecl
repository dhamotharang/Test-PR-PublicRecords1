#workunit('name','nonfcrashell');
import ut, riskwise, risk_indicators, Data_Services;

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

// IMPORT Risk_Indicators, RiskWise, ut;

unsigned record_limit :=   75000;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 2;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 25;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
unsigned1 glba := 1;
unsigned1 dppa := 3;

//===================  input-output files  ======================
infile_name :=  Data_Services.foreign_prod+'dvstemp::in::audit_input_file_w20140701-122932';

outfile_name := '~dvstemp::out::audit::nonfcrashell_test_' + thorlib.wuid();

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
    string historydate;
  END;
	

//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service

bs_service := 'risk_indicators.boca_shell.61';
// bs_service := 'risk_indicators.boca_shell.12';
// bs_service := 'risk_indicators.boca_shell_11_4bugs';
// bs_service := 'risk_indicators.boca_shell_11_18bugs';
roxieIP := RiskWise.Shortcuts.dev156;    // Roxiebatch
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 


//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, layout_input, csv(quote('"')));

//=================
// ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

l := RECORD
   STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.Account;
  SELF.AccountNumber := (STRING)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
		
  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

		self.historydateyyyymm := 999999;  
		// self.historydateyyyymm := 201407;  
		self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

  // self.historydateyyyymm := map(
			// regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
			// regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
			                                                // (unsigned)le.historydate
	// );
	
  // self.historyDateTimeStamp := map(
      // le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			// regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
			// regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
			// regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		                                                
			                                                // le.historydate
	// );
	
 
  SELF.IncludeScore := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.RemoveFares := RemoveFares;
	self.bsversion := 54;				
  SELF := le;
  SELF := [];
END;
p_f1 := PROJECT (ds_input, assignAccount (LEFT,COUNTER));

// duplicate the same inputs, but change the history dates
p_f2 := project(p_f1, transform(l, self.accountnumber := (string)(100000 + (unsigned)left.accountnumber), self.historydateyyyymm := 201905; self := left));
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
// p_f := p_f1 ;  // just run 5.0 for this test
p_f := p_f1 + p_f2 + p_f3;
//+ p_f4 + p_f5 + p_f6 + p_f7 + p_f8 + p_f9 ;  // run the gamut
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

