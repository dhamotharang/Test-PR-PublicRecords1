#workunit('name','FCRA ADL Bocashell 5.0 Process');

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

unsigned record_limit := 0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output files  ======================
infile_name :=   ut.foreign_prod+'tfuerstenberg::in::fico_4332_fullsample_in_pt25';
outfile_name := '~mlwalklin::out::fcra50_ADL_' + thorlib.wuid();	// this will output your work unit number in your filename;

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
// Neutral service ip
roxie_IP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
// roxie_IP := RiskWise.Shortcuts.staging_neutral_roxieIP;  

// FCRA service settings
bs_service := 'risk_indicators.Boca_Shell_FCRA';
roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie
// roxieIP := RiskWise.Shortcuts.staging_fcra_roxieIP;  

//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := dataset (infile_name, layout_input, csv(quote('"')));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

// l := RECORD
  // STRING old_account_number;
  // Risk_Indicators.Layout_InstID_SoapCall;
// END;

l := RECORD
	STRING original_account_number;
	STRING AccountNumber;
	STRING FirstName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING SSN;
	STRING DateOfBirth;
	STRING HomePhone;
	integer HistoryDateYYYYMM;
	string20 HistoryDateTimeStamp := '';
	boolean IncludeScore;
	boolean ADL_Based_Shell;
	boolean PreScreen;
	string neutral_gateway;
	string DataRestrictionMask;
	integer bsversion;
	unsigned3 LastSeenThreshold;
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	SELF.original_account_number := le.account;
	SELF.AccountNumber := (STRING)c;	
	self.IncludeScore := true;
	self.ADL_Based_Shell := true;
	self.PreScreen := false;
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
 	self.neutral_gateway := roxie_IP;
	SELF.datarestrictionmask := datarestrictionmask;
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 50;		
	self := le;
END;

p_f := PROJECT(ds_input,t_f(LEFT,COUNTER));
dist_dataset := distribute(p_f, random());
output(choosen(dist_dataset, eyeball), named('bocashell_input'));

xlayout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	risk_indicators.Layout_Boca_Shell -LnJ_datasets;	
	string200 errorcode;
end;
								
xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (unsigned)le.accountnumber;
	SELF := [];
END;


roxie_results := soapcall(	dist_dataset, roxieIP,
							bs_service, 
							{dist_dataset}, 
							DATASET(xlayout),
							parallel(parallel_calls),
							onFail(myFail(LEFT)));

													
	
edina_plus_bob_v50 := record
	risk_indicators.iid_constants.adl_based_modeling_flags ADL_Shell_Flags;
	risk_indicators.Layout_Boca_Shell_Edina_v50;
end;	
	
riskprocessing.layouts.layout_internal_shell_noDatasets getold(roxie_results le, p_f ri) :=	TRANSFORM
  SELF.AccountNumber := ri.original_account_number;
  SELF := le;
END;
	
res := JOIN (roxie_results,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');



OUTPUT (choosen(res, eyeball), NAMED ('result'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
output(count(res_err), named('error_count'));

OUTPUT (res, , outfile_name, CSV(QUOTE('"')));

// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell_noDatasets, csv(quote('"'), maxlength(20000)));
output(choosen(f, eyeball), named('infile'));
isFCRA := true;

edina := risk_indicators.ToEdina_v50_ADL(f, isFCRA, DataRestrictionMask);


output(choosen(edina,eyeball), named('edina'));
output(edina,, outfile_name+'_edina_v50',CSV(QUOTE('"')));
