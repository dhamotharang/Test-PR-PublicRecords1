EXPORT Modeling_Bocashell_FCRA_52(RecordsToRun) := FunctionMacro;
IMPORT Risk_Indicators, RiskWise, riskprocessing, ut, Scoring_Project_PIP;

unsigned record_limit :=   RecordsToRun;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 3;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '1000010001000100000000000'; // to restrict fares, experian, transunion and experian FCRA 

//===================  input-output files  ======================
//infile_name :=  ut.foreign_prod+'tfuerstenberg::in::fico_4332_fullsample_in_pt25';
infile_name := '~dvstemp::in::rv5t_dev_val_inputs_100k';
// infile_name :=  '~Scoring_Project::in::ndobmeier::fp30dev::fp3_modelval_pii';   //NonFCRA Sample
outfile_name := '~mamtemp::out::fcra52_' + thorlib.wuid();	// this will output your work unit number in your filename;

//===
//==================  input file layout  ========================
layout_input := RECORD
  // string account;    //for FCRA Sample
  string accountnumber;    //for NonFCRA Sample
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
  // string historydateyyyymm;    //For FCRA Sample
  integer8 historydateyyyymm;    //For NonFCRA sample
  END;
 
 
 
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
roxie_IP :=riskwise.shortcuts.core_97_roxieIP;    // Roxiebatch
 

// FCRA service settings
bs_service := 'risk_indicators.Boca_Shell_FCRA';
roxieIP :=riskwise.shortcuts.core_97_roxieIP; 		// FCRAbatch Roxie
 

//====================================================
//=====================  R U N  ======================
//====================================================

ds_in := dataset (infile_name, layout_input, csv(quote('"'),heading(single)));  //For FCRA Sample
// ds_in := DATASET(infile_name, layout_input,  thor);      //For NonFCRA Sample

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
// OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
 // SELF.old_account_number := le.Account;      //for FCRA Sample
 SELF.old_account_number := le.Accountnumber;      //For NonFCRA Sample
  SELF.AccountNumber := (STRING)c;

  self.neutral_gateway := roxie_ip;
	
	//**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  
	
	//	self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  




/*      ************This is for the FCRA SAMPLE*************
  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			regexfind('^\\d{8}$',        le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			                                                (unsigned)le.historydateyyyymm
	);
	
  self.historyDateTimeStamp := map(
      le.historydateyyyymm in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', le.historydateyyyymm) => le.historydateyyyymm,
			regexfind('^\\d{8}$',        le.historydateyyyymm) => le.historydateyyyymm +   ' 00000100',
			regexfind('^\\d{6}$',        le.historydateyyyymm) => le.historydateyyyymm + '01 00000100',		                                                
			                                                le.historydateyyyymm
	);
*/



  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;
	self.bsversion := 52;		
	SELF := le;
	SELF := [];
END;
p_f1 := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
p_f4 := project(p_f1, transform(l, self.accountnumber := (string)(300000 + (unsigned)left.accountnumber), self.historydateyyyymm := 999999; self.historyDateTimeStamp := ''; self := left));
p_f := p_f1 + p_f4;
Out2 := output(choosen(p_f, eyeball));

s :=Scoring_Project_PIP.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

Out1 := OUTPUT (choosen(res, eyeball));
Out2_2 := OUTPUT (choosen(res_err, eyeball));
Out3 := output(count(res_err));

Out4 := OUTPUT (res, , outfile_name, __compressed__);


// the conversion portion-----------------------------------------------------------------------

f := DATASET(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
// Out5 := OUTPUT(CHOOSEN(f, eyeball));
isFCRA := true;
string IntendedPurpose := 'APPLICATION';
edina := Risk_Indicators.ToEdina_52(f, isFCRA, DataRestrictionMask, IntendedPurpose);

// Out5 := OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));
Out6 := OUTPUT(edina,, outfile_name+'_edina52FCRA',CSV(QUOTE('"'))); // Write to disk.

// return sequential(Out2, Out1, Out2_2, Out3, Out4, Out6);
return sequential(Out4, Out6);

EndMacro;
