#workunit('name','NonFCRA BocaShell 5.1');

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

IMPORT Risk_Indicators, RiskWise, ut;

unsigned record_limit      := 10;     //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls   := 30;     //number of parallel soap calls to make [1..30]
unsigned1 eyeball          := 10;
boolean RemoveFares        := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode  := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
unsigned1 glba := 1;
unsigned1 dppa := 3;

//===================  input-output filenames  ======================

infile_name        := '~tfuerstenberg::in::gmfinancial_5687_gm_f_s_in';
outfile_name       := '~tfuerstenberg::out::gmfinancial_5687_gm_nonfcra_' + thorlib.wuid();

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

// Regular BocaShell service:
bs_service := 'risk_indicators.Boca_Shell';

// Target Roxie:
roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 

//====================================================
//=====================  R U N  ======================
//====================================================

// load sample data
ds_in := DATASET(infile_name, layout_input, csv(quote('"'))); // Validation dataset

//=================

ds_input := IF(record_limit = 0, ds_in, CHOOSEN(ds_in, record_limit));
OUTPUT(CHOOSEN(ds_input,eyeball), NAMED('input'));

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
		// self.historydateyyyymm := 201504;  
		// self.historyDateTimeStamp := '20150401 00000100';  

		// self.historydateyyyymm := 999999;  
		// self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
			regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
			                                                (unsigned)le.historydate
	);
	
  self.historyDateTimeStamp := map(
      le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
			regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
			regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		                                                
			                                                le.historydate
	);
	
  SELF.IncludeScore        := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.RemoveFares         := RemoveFares;
	self.bsversion           := 51;				
  SELF := le;
  SELF := [];
END;

p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));

output(CHOOSEN(p_f,eyeball), NAMED('BSInput'));

										
s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN( s, p_f, LEFT.seq = (unsigned)RIGHT.accountnumber, getold(LEFT,RIGHT) );
res_err := res(errorcode<>'');

OUTPUT(CHOOSEN(res, eyeball), NAMED('result'));
OUTPUT(CHOOSEN(res_err, eyeball), NAMED('res_err'));
OUTPUT(COUNT(res_err), NAMED('error_count'));

OUTPUT(res, , outfile_name, CSV(QUOTE('"')));  // Write to disk.

// the conversion portion-----------------------------------------------------------------------

f := DATASET(outfile_name, riskprocessing.layouts.layout_internal_shell, csv(quote('"'), maxlength(20000)));
OUTPUT(CHOOSEN(f, eyeball), NAMED('infile'));

// NOTE....: Even though we called the Boca Shell using version 5.1, for the time being 
// we are still converting the results ToEdina_v50( ). 
isFCRA := false;
edina := risk_indicators.ToEdina_v50(f, isFCRA, DataRestrictionMask);

// Now tack the FDN attributes--test_fraud and contributory_fraud--to the end of the v50 layout.
layout_with_FDN_attributes :=	RECORD
	risk_indicators.Layout_Boca_Shell_Edina_v50;
	risk_indicators.layouts.layout_test_fraud  Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  Contributory_Fraud;
END;

edina_with_FDN_attributes := 
	join(
		edina, f, 
		left.seq = right.seq,
		transform( layout_with_FDN_attributes, 
			self.Test_Fraud         := right.Test_Fraud,  
			self.Contributory_Fraud := right.Contributory_Fraud,  
			self                    := left
		),
		left outer
	);

OUTPUT(CHOOSEN(edina_with_FDN_attributes,eyeball), NAMED('edina'));
OUTPUT(edina_with_FDN_attributes,, outfile_name+'_edina_v50',CSV(QUOTE('"'))); // Write to disk.

