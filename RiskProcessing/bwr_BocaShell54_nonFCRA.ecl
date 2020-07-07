#workunit('name','nonfcrashell 5.4');

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

IMPORT Risk_Indicators, RiskWise, data_services, _control, gateway;

unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
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
infile_name  := '~tfuerstenberg::in::gmfinancial_5687_gm_f_s_in';
// infile_name :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'ndobmeier::fpdev::out::eq_fraud_flags_uat_pii';

outfile_name := '~tfuerstenberg::out::gmfinancial_5687_' + thorlib.wuid();

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
// Regular BocaShell service
bs_service := 'risk_indicators.boca_shell';  
// roxieIP := RiskWise.Shortcuts.dev194; 
// roxieIP := RiskWise.Shortcuts.QA_neutral_roxieIP; 
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; 


//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := DATASET(infile_name, layout_input, csv(quote('"'))); // use this for a CSV file
 
// load sample data
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

l := RECORD
	string old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
	self.old_account_number := le.Account;
  SELF.AccountNumber := (string)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
		
	self.retainInputDID := RetainInputDID;
	self.did := le.LexID; 

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	
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
	
	self.UseIngestDate := false;//  change this to true if they want to use Ingest date for retro test instead of dt_first_seen filtering
  SELF.IncludeScore := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.datapermissionmask := datapermissionmask;
  SELF.RemoveFares := RemoveFares;
  SELF.LeadIntegrityMode := LeadIntegrityMode;
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 54;	
	// if you are running realtime mode with today's date and you need realtime inquiries turn on deltabase searching
	// self.gateways := project(riskwise.shortcuts.gw_delta_dev, transform(Gateway.Layouts.Config, self := left, self := []) );   //dev deltabase
	// self.gateways := project(riskwise.shortcuts.gw_delta_prod, transform(Gateway.Layouts.Config, self := left, self := []) );   // production deltabase
	SELF := le;
  SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
output(choosen(p_f,eyeball), named('BSInput'));
								
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
output(count(res_err), named('error_count'));

OUTPUT (res, , outfile_name, __compressed__);

// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
OUTPUT(CHOOSEN(f, eyeball), NAMED('infile'));

isFCRA := false;
edina := Risk_Indicators.ToEdina_54(f, isFCRA, DataRestrictionMask, IntendedPurpose);

OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));
OUTPUT(edina,, outfile_name+'_edina_v54',CSV(QUOTE('"'))); // Write to disk.
