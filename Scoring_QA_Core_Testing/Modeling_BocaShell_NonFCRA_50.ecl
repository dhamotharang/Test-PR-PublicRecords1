EXPORT Modeling_BocaShell_NonFCRA_50(NeutralRoxie, Threads, RecordsToRun, Name) := functionMacro;


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

IMPORT Risk_Indicators, RiskWise, ut, Scoring_Project_PIP;

unsigned record_limit :=   RecordsToRun;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := Threads;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
unsigned1 glba := 1;
unsigned1 dppa := 3;

//===================  input-output files  ======================
//infile_name :=  ut.foreign_prod+'tfuerstenberg::in::fico_4332_fullsample_in_pt25';
// infile_name :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'ndobmeier::fp30dev::fp3_modelval_pii'; 
infile_name :=  '~Scoring_Project::in::ndobmeier::fp30dev::fp3_modelval_pii';    //Same as the above file, except on Dataland to speed up collection
outfile_name := '~mamtemp::out::nonfcrashell50_' + thorlib.wuid() + '_' + Name;

//==================  input file layout  ========================
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
// Regular BocaShell service
bs_service := 'risk_indicators.Boca_Shell';
// roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 
// roxieIP := riskwise.shortcuts.core_97_roxieIP; 
roxieIP := NeutralRoxie; 


//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, layout_input, flat);

//=================
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
// Out1 := OUTPUT (choosen(ds_input,eyeball), NAMED ('NonFCRA_input'));

l := RECORD
   STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.AccountNumber;
  SELF.AccountNumber := (STRING)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
		
  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

	//	self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

  // self.historydateyyyymm := map(
			// regexfind('^\\d{8} \\d{8}$', (string) le.historydate) => (unsigned)le.historydate[..6],
			// regexfind('^\\d{8}$',  (string) le.historydate) => (unsigned)le.historydate[..6],
			                                                // (unsigned)le.historydate
	// );
	
  // self.historyDateTimeStamp := map(
     // (string) le.historydate in ['', '999999']  => '',  // leave timestamp blank, query will populate it with the current date   	
			// regexfind('^\\d{8} \\d{8}$', (string) le.historydate) => (string) le.historydate,
			// regexfind('^\\d{8}$',      (string)  le.historydate) => (string) le.historydate +   ' 00000100',
			// regexfind('^\\d{6}$',     (string)   le.historydate) => (string) le.historydate + '01 00000100',		                                                
			                                              // (string)  le.historydate
	// );

	
 
  SELF.IncludeScore := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.RemoveFares := RemoveFares;
	self.bsversion := 50;				
  SELF := le;
  SELF := [];
END;

p_f1 := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
p_f4 := project(p_f1, transform(l, self.accountnumber := (string)(300000 + (unsigned)left.accountnumber), self.historydateyyyymm := 999999; self.historyDateTimeStamp := ''; self := left));
p_f := p_f1 + p_f4;
// Out2 := output(choosen(p_f, eyeball), named('NonFCRA_BSInput'));

										
s :=Scoring_Project_PIP.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell_noDatasets getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

// Out3:= OUTPUT (choosen(res, eyeball), NAMED ('NonFCRA_result'));
// Out4:= OUTPUT (choosen(res_err, eyeball), NAMED ('NonFCRA_res_err'));
// Out5:= output(count(res_err), named('NonFCRA_error_count'));

Out6:= OUTPUT (res, , outfile_name, CSV(QUOTE('"')));

// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell_noDatasets, csv(quote('"'), maxlength(20000)));
// Out7:= output(choosen(f, eyeball), named('NonFCRA_infile'));
isFCRA := false;
edina := risk_indicators.ToEdina_v50(f, isFCRA, DataRestrictionMask);
// Out8 := output(choosen(edina,eyeball), named('NonFCRA_edina'));
Out9 := output(edina,, outfile_name+'_edina_v50',CSV(QUOTE('"')));



// return sequential(Out1, Out2, Out3, Out4, Out5, Out6, Out7, Out8, Out9);
return sequential(Out6, Out9);

EndMacro;
