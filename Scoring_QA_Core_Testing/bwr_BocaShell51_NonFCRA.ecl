﻿/*2015-09-25T19:35:58Z (Kevin Huls_prod)
Changed to call 'ToEdina_v51' to format the FDN and FP3 model output fields.

*/
//#WORKUNIT('name','CoreTesting_NonFCRA BocaShell 5.1');
#WORKUNIT('priority','high');


// Reads sample data from input file, makes a SOAP call to service specified and (optionally),
// saves results in output file. 
// Before running:
//   o  choose (or define) input file name and, if needed, output file name as well;
//   o  choose (or define) input layout;
//   o  check the number of records to read from input;
//   o  verify the number of parallel SOAP calls (note that 'parallel_calls' params is being ignored now);
//   o  uncomment file-output, if needed;
//   o  check that the data restrictions are set appropriately, specifically  EN and EQ
//   o  eyeball is how many records you want to see on output, similar to record_limit except this is your intermediate result output count

IMPORT Risk_Indicators, RiskWise,riskprocessing, ut, Scoring_Project_PIP;

unsigned record_limit      := 0;     //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls   := 2;     //number of parallel soap calls to make [1..30]
unsigned1 eyeball          := 10;
boolean RemoveFares        := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode  := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data,
string DataPermissionMask  := '0000000000100';	// byte 11, if 0, restricts FDN test fraud and contributory fraud  
																								// byte 13, if 0, restricts Insurance DL data  
unsigned1 glba := 1;
unsigned1 dppa := 3;
boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID
boolean isPrescreen := FALSE; 
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output filenames  ======================

infile_name        := '~scoring_project::in::ndobmeier::fp30dev::fp3_modelval_pii';
outfile_name       := '~scoringqa::out::bs_51_nonfcra_20180202_ExPhone_After' + thorlib.wuid();

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

// Regular BocaShell service:
bs_service := 'risk_indicators.Boca_Shell';

// Target Roxie:
// roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
roxieIP :=riskwise.shortcuts.core_97_roxieIP;	// CoreRoxie
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 

//====================================================
//=====================  R U N  ======================
//====================================================

// load sample data
ds_in := DATASET(infile_name, layout_input, thor); // Validation dataset

//=================

ds_input := IF(record_limit = 0, ds_in, CHOOSEN(ds_in, record_limit));
OUTPUT(CHOOSEN(ds_input,eyeball), NAMED('input1'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.AccountNumber;
  SELF.AccountNumber := (STRING)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
		
	// self.retainInputDID := RetainInputDID;
	// self.did := le.LexID; 
	
  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
		// self.historydateyyyymm := 201504;  
		// self.historyDateTimeStamp := '20150401 00000100';  

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
	
  SELF.IncludeScore        := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.datapermissionmask  := datapermissionmask;
  SELF.RemoveFares         := RemoveFares;
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion           := 51;				
  SELF := le;
  SELF := [];
END;

p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));

output(CHOOSEN(p_f,eyeball), NAMED('BSInput1'));

										
s :=Scoring_Project_PIP.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell_noDatasets getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN( s, p_f, LEFT.seq = (unsigned)RIGHT.accountnumber, getold(LEFT,RIGHT) );
res_err := res(errorcode<>'');

OUTPUT(CHOOSEN(res, eyeball), NAMED('result1'));
OUTPUT(CHOOSEN(res_err, eyeball), NAMED('res_err1'));
OUTPUT(COUNT(res_err), NAMED('error_count1'));

OUTPUT(res, , outfile_name, CSV(QUOTE('"')));  // Write to disk.

// the conversion portion-----------------------------------------------------------------------

f := DATASET(outfile_name, riskprocessing.layouts.layout_internal_shell_noDatasets, csv(quote('"'), maxlength(20000)));
OUTPUT(CHOOSEN(f, eyeball), NAMED('infile1'));

// ToEdina_v51 converts to a temporary 5.1 layout where the FDN and FP3 data are placed at the end of the layout.  When the
// real BS 5.1 layout comes out than ToEdina_v51 will change to produce the permanent layout. 

isFCRA := false;
edina := risk_indicators.ToEdina_v51(f, isFCRA, DataRestrictionMask);

OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina1'));
OUTPUT(edina,, outfile_name+'_edina_v501',CSV(QUOTE('"'))); // Write to disk.

