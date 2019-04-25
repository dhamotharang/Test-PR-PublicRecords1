EXPORT Modeling_Bocashell_nonFCRA_52(RecordsToRun) := functionMacro;

IMPORT Risk_Indicators, RiskWise, riskprocessing, ut, Scoring_Project_PIP;

IMPORT Risk_Indicators, RiskWise, ut;

unsigned record_limit :=  RecordsToRun;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 3;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
		boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID
string IntendedPurpose := '';  // leave blank in nonfcra
string DataPermissionMask  := '0000000001101';	//position 10 is SSA, position 11 is FDN test fraud/contributory fraud, position 13 is Insurance DL
																						// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
unsigned1 glba := 1;
unsigned1 dppa := 3;

//===================  input-output files  ======================
//infile_name :=  ut.foreign_prod+'tfuerstenberg::in::fico_4332_fullsample_in_pt25';
// infile_name :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'ndobmeier::fp30dev::fp3_modelval_pii'; 
infile_name :=  '~Scoring_Project::in::ndobmeier::fp30dev::fp3_modelval_pii';    //Same as the above file, except on Dataland to speed up collection
outfile_name := '~mamtemp::out::nonfcrashell52_' + thorlib.wuid();



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
bs_service := 'risk_indicators.boca_shell';  
// roxieIP := RiskWise.Shortcuts.dev194; 
// roxieIP := RiskWise.Shortcuts.QA_neutral_roxieIP; 
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 
roxieIP :=riskwise.shortcuts.core_97_roxieIP; 


//====================================================
//=====================  R U N  ======================
//====================================================
// ds_in := DATASET(infile_name, layout_input,  csv(quote('"'),heading(single)));
ds_in := DATASET(infile_name, layout_input,  thor);
// load sample data
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
// OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

l := RECORD
	string old_account_number;
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
	
	 // self.historydateyyyymm := 999999;  
  // self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

 
  SELF.IncludeScore := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.RemoveFares := RemoveFares;
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

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
 // OUTPUT(CHOOSEN(f, eyeball));

isFCRA := false;
edina := Risk_Indicators.ToEdina_52(f, isFCRA, DataRestrictionMask, IntendedPurpose);

// Out5 := OUTPUT(CHOOSEN(edina,eyeball));
Out6 := OUTPUT(edina,, outfile_name+'_edina52nonFCRA',CSV(QUOTE('"'))); // Write to disk.

// return sequential(out2, Out1, Out2, Out3, Out4, Out6);
return sequential(Out4, Out6);

EndMacro;
