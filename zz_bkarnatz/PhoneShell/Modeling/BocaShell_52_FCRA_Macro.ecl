EXPORT BocaShell_52_FCRA_Macro(string IP, unsigned1 Threads, unsigned records, string filename) := Function

// #workunit('name','FCRA Bocashell 5.2 Process');

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

IMPORT Risk_Indicators, RiskWise, riskprocessing, ut, data_services;

record_limit := records;    //number of records to read from input file; 0 means ALL
parallel_calls := Threads;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 20;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID
string IntendedPurpose := 'APPLICATION';
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output files  ======================
// infile_name :=  ut.foreign_prod+'jpyon::in::adp_7555_new_file4_f_s_in';
// infile_name :=  ut.foreign_prod+'hmccarl::in::rv5t_dev_val_inputs';                       //deprecated
// infile_name :=  data_services.foreign_prod + 'hmccarl::in::rv5t_dev_val_inputs';          //Does not work, correct code commented out, only gives '~'
infile_name :=  '~foreign::prod_dali.br.seisint.com::' + 'hmccarl::in::rv5t_dev_val_inputs'; //doing manually so it pulls from production thor.
// outfile_name := '~jpyon::out::adp_7555_new_file4_fcra52_qc2' + thorlib.wuid();	// this will output your work unit number in your filename;
outfile_name := '~ScoringQA::out::BocaShell_52_FCRA_' + filename + '_' + thorlib.wuid();

//==================  input file layout  ========================
// layout_input := RECORD
    // STRING Account;
    // STRING FirstName;
    // STRING MiddleName;
    // STRING LastName;
    // STRING StreetAddress;
    // STRING City;
    // STRING State;
    // STRING Zip;
    // STRING HomePhone;
    // STRING SSN;
    // STRING DateOfBirth;
    // STRING WorkPhone;
    // STRING income;  
    // string DLNumber;
    // string DLState;													
    // string BALANCE; 
    // string CHARGEOFFD;  
    // string FormerName;
    // string EMAIL;  
    // string employername;
    // string historydate;
		// string LexID; 
  // END;
 
 
 layout_input := RECORD
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
// Neutral service ip
// roxie_IP := RiskWise.Shortcuts.prod_batch_analytics_roxie;    // Roxiebatch
// roxie_IP := riskwise.shortcuts.core_97_roxieIP;    // Core Roxie
roxie_IP := IP;    // 


// FCRA service settings
bs_service := 'risk_indicators.Boca_Shell_FCRA';
// roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie
// roxieIP := riskwise.shortcuts.core_97_roxieIP; // CoreRoxie 
roxieIP := IP; //  

//====================================================
//=====================  R U N  ======================
//====================================================

ds_in := dataset (infile_name, layout_input, csv(quote('"')));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
// OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
	self.ExcludeIbehavior := true;  // set this back to false if they would like to include this data for their test.  this is temporary until end of July 2017
	
  SELF.old_account_number := le.accountnumber;
  SELF.AccountNumber := (STRING)c;
		
  self.neutral_gateway := roxie_ip;
	self.retainInputDID := RetainInputDID;
	// self.did := le.LexID;
  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;	
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 52;	
	self.IncludeLnJ := true;
	self.Include_nonFCRA_Collections_Inquiries := false;
	
	//**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	
		// self.historydateyyyymm := 999999;  
		// self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

		self.historydateyyyymm := le.historydateyyyymm;
		self.historyDateTimeStamp := (string20)le.historydateyyyymm;

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
	
	self := le;
	SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
// output(choosen(p_f, eyeball), named('BSInput'));

s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

// OUTPUT (choosen(res, eyeball), NAMED ('result'));
// OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
// output(count(res_err), named('err_count'));

OUTPUT (res, , outfile_name, thor, overwrite);


// the conversion portion-----------------------------------------------------------------------

f := DATASET(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
// OUTPUT(CHOOSEN(f, eyeball), NAMED('infile'));

edina := Risk_Indicators.ToEdina_52(f, isFCRA, DataRestrictionMask, IntendedPurpose);

// OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));


Return OUTPUT(edina,, outfile_name + '_edina',CSV(heading(single), quote('"'))); // Write to disk.

END;