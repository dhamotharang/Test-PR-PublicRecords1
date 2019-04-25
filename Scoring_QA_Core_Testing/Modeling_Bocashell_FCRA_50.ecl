EXPORT Modeling_Bocashell_FCRA_50(NeutralRoxie, FCRARoxie, Threads, RecordsToRun, Name) := FunctionMacro;

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

IMPORT Risk_Indicators, RiskWise, riskprocessing, ut, Scoring_Project_PIP;

unsigned record_limit :=   RecordsToRun;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := Threads;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 

//===================  input-output files  ======================
//infile_name :=  ut.foreign_prod+'tfuerstenberg::in::fico_4332_fullsample_in_pt25';
infile_name := '~dvstemp::in::rv5t_dev_val_inputs_100k';                      //Sample for Prof Lic
// infile_name := '~aktemp::in::rv_jan::rv_feb::client::inputw20170207-112411';     //Sample for Liens
outfile_name := '~mamtemp::out::fcra50_' + thorlib.wuid() + '_' + Name;	// this will output your work unit number in your filename;

//==================  input file layout  ========================
  // Layout for the ProfLic Sample
layout_input := RECORD     
  string account;
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
  string historydate;
 END;



//**************
/*//Layout for the Liens sample
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
 END;
  */
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
// roxie_IP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
// roxie_IP := RiskWise.Shortcuts.staging_neutral_roxieIP;  
// roxie_IP := riskwise.shortcuts.core_97_roxieIP;  
roxie_IP := NeutralRoxie;  

// FCRA service settings
bs_service := 'risk_indicators.Boca_Shell_FCRA';
// roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie
// roxieIP := RiskWise.Shortcuts.staging_fcra_roxieIP;  
// roxieIP := riskwise.shortcuts.core_roxieIP;  
roxieIP := FCRARoxie;  

//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := dataset (infile_name, layout_input, csv(quote('"'),heading(single)));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
// Out1 := OUTPUT (choosen(ds_input, eyeball), NAMED ('FCRA_input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
	// string historydate;                                 //adding in historydate as the Liens input sample does not contain
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.Account;                     //ProfLic Sample
  // SELF.old_account_number := le.accountnumber;									//Liens Sample
  SELF.AccountNumber := (STRING)c;

  self.neutral_gateway := roxie_ip;

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	// self.historydate := '999999';                                                         //running in current mode
		// self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  


  self.historydateyyyymm := map(                                                               //Commented out as Liens sample does not have historydate
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

  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;
	self.bsversion := 50;		
	self.IncludeLnJ := false;
	SELF := le;
	SELF := [];
END;
p_f1 := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
p_f4 := project(p_f1, transform(l, self.accountnumber := (string)(300000 + (unsigned)left.accountnumber), self.historydateyyyymm := 999999; self.historyDateTimeStamp := ''; self := left));
p_f := p_f1 + p_f4;
// p_f := p_f4;     // this runs only in current mode
// Out2 := output(choosen(p_f, eyeball), named('FCRA_BSInput'));

s :=Scoring_Project_PIP.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);
		
riskprocessing.layouts.layout_internal_shell_noDatasets getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

// Out3 := OUTPUT (choosen(res, eyeball), NAMED ('FCRA_result'));
// Out4 := OUTPUT (choosen(res_err, eyeball), NAMED ('FCRA_res_err'));
// Out5 := output(count(res_err), named('FCRA_error_count'));

Out6 := OUTPUT (res, , outfile_name, CSV(QUOTE('"')));

// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell_noDatasets, csv(quote('"'), maxlength(20000)));
// Out7 := output(choosen(f, eyeball), named('FCRA_infile'));
isFCRA := true;

edina := risk_indicators.ToEdina_v50(f, isFCRA, DataRestrictionMask);

// Out8 := output(choosen(edina,eyeball), named('FCRA_edina'));
Out9 := output(edina,, outfile_name+'_edina_v50',CSV(QUOTE('"')));


// return sequential(Out1, Out2, Out3, Out4, Out5, Out6, Out7, Out8, Out9);
return sequential(Out6, Out9);

EndMacro;
