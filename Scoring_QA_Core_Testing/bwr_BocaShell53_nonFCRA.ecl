﻿ //#workunit('name','nonfcrashell 5.3');

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

IMPORT Risk_Indicators, RiskWise, data_services, _control, gateway, ut,riskprocessing, Scoring_Project_PIP;

unsigned record_limit :=  0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 2;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
string DataPermissionMask  := '0000000001101';	//position 10 is SSA, position 11 is FDN test fraud/contributory fraud, position 13 is Insurance DL
string IntendedPurpose := '';  // leave blank in nonfcra
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 
unsigned1 glba := 1;
unsigned1 dppa := 3;
boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID

//===================  input-output files  ======================
infile_name        := '~scoring_project::in::ndobmeier::fp30dev::fp3_modelval_pii';
outfile_name := '~scoringqa::out::bs_53_nonfcra_20180202_ExPhone_After' + thorlib.wuid();

//==================  input file layout  ========================
layout_input := 
RECORD
  string accountnumber;
  string firstname;
  string middlename;
  string lastname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string homephone;
  string ssn;
  string dateofbirth;
  string workphone;
  string income;
  string dlnumber;
  string dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string company;
  integer8 historydateyyyymm;
 END;

//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service
bs_service := 'risk_indicators.boca_shell';  
// roxieIP := RiskWise.Shortcuts.dev194; 
// roxieIP := RiskWise.Shortcuts.QA_neutral_roxieIP; 
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 
// roxieIP := RiskWise.Shortcuts.prod_batch_neutral; 
roxieIP :=riskwise.shortcuts.core_97_roxieIP; // CoreRoxie



//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := DATASET(infile_name, layout_input, thor); // use this for a CSV file
 
// load sample data
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input,eyeball), NAMED ('input2'));

l := RECORD
	string old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
	self.old_account_number := le.AccountNumber;
  SELF.AccountNumber := (string)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
		
	// self.retainInputDID := RetainInputDID;
	// self.did := le.LexID; 

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	
	 // self.historydateyyyymm := 999999;  
  // self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

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
  SELF.datapermissionmask := datapermissionmask;
  SELF.RemoveFares := RemoveFares;
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 53;	
	// if you are running realtime mode with today's date and you need realtime inquiries turn on deltabase searching
	// self.gateways := project(riskwise.shortcuts.gw_delta_dev, transform(Gateway.Layouts.Config, self := left, self := []) );   //dev deltabase
	// self.gateways := project(riskwise.shortcuts.gw_delta_prod, transform(Gateway.Layouts.Config, self := left, self := []) );   // production deltabase
	SELF := le;
  SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
output(choosen(p_f,eyeball), named('BSInput2'));
								
s :=Scoring_Project_PIP.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

OUTPUT (choosen(res, eyeball), NAMED ('result2'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err2'));
output(count(res_err), named('error_count2'));

OUTPUT (res, , outfile_name, __compressed__);

// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
OUTPUT(CHOOSEN(f, eyeball), NAMED('infile2'));

isFCRA := false;
edina := Risk_Indicators.ToEdina_53(f, isFCRA, DataRestrictionMask, IntendedPurpose);

OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina2'));
OUTPUT(edina,, outfile_name+'_edina_v53',CSV(QUOTE('"'))); // Write to disk.

