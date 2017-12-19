#workunit('name','ADL based FCRA Bocashell 5.2 Process');

isFCRA := true;

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

unsigned record_limit :=  10;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 20;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID
string IntendedPurpose := 'APPLICATION';  //Change to "PRESCREENING" for prescreen mode
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output files  ======================
infile_name :=  ut.foreign_prod+'tfuerstenberg::in::DMServices_7460_in.csv';
outfile_name := '~dvstemp::out::DMServices_7460_adlfcra52_prescreen2' + thorlib.wuid();	// this will output your work unit number in your filename;

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
		string LexID; 
  END;
 
 
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
roxie_IP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
 

// FCRA service settings
bs_service := 'risk_indicators.Boca_Shell_FCRA';
roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie
 

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

self.ExcludeIbehavior := true;  // set this back to false if they would like to include this data for their test


  SELF.old_account_number := le.Account;
  SELF.AccountNumber := (STRING)c;
		
  self.neutral_gateway := roxie_ip;
	self.retainInputDID := RetainInputDID;
	self.did := le.LexID;
  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;	
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 52;	
	self.IncludeLnJ := true;
	self.Include_nonFCRA_Collections_Inquiries := false;
	
	self.ADL_Based_Shell := true;
	self.PreScreen := true;
	
	
	//**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	
	//	self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

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
	
	self := le;
	SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
output(choosen(p_f, eyeball), named('BSInput'));

s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

OUTPUT (choosen(res, eyeball), NAMED ('result'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
output(count(res_err), named('err_count'));

OUTPUT (res, , outfile_name, __compressed__);


// the conversion portion-----------------------------------------------------------------------

f := DATASET(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
OUTPUT(CHOOSEN(f, eyeball), NAMED('infile'));

edina := Risk_Indicators.ToEdina_52_ADL(f, isFCRA, DataRestrictionMask, IntendedPurpose);

OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));
OUTPUT(edina,, outfile_name+'_edina',CSV(QUOTE('"'))); // Write to disk.

