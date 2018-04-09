#workunit('name','nonfcrashell 5.2');

IMPORT Risk_Indicators, RiskWise, data_services, _control, gateway;

unsigned record_limit :=   10;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 2;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 25;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
string DataPermissionMask := '0000000001101';	//position 10 is SSA, position 11 is FDN test fraud/contributory fraud, position 13 is Insurance DL
string IntendedPurpose := '';  // leave blank in nonfcra

unsigned1 glba := 1;
// unsigned1 dppa := 3;
unsigned1 dppa := 1;  // run with full purpose for this testing to get full visibility to all DPPA data

//===================  input-output files  ======================
infile_name :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +'ndobmeier::fp30dev::fp3_modelval_pii';
outfile_name := '~dvstemp::out::fp30dev::nonfcrashell_52_' + thorlib.wuid();

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

// test_accounts := [
// '0566446',
// '0953198',
// '0445263',
// '0115294',
// '0308339',
// '0274151'
// ];
// ds_in := dataset(infile_name, layout_input, csv(quote('"'), heading(single)) );
ds_in := dataset(infile_name, layout_input, flat );
// ds_in := dataset(infile_name, layout_input, flat )(accountnumber in test_accounts);
output(choosen(ds_in, eyeball), named('nicole_input_file_sample'));

	

//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service

bs_service := 'risk_indicators.boca_shell';  
// roxieIP := RiskWise.Shortcuts.dev194; 
roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 

//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

l := RECORD
	string old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
	self.old_account_number := le.accountnumber;
  SELF.AccountNumber := (string)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
		
  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

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
	
 
  SELF.IncludeScore := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.datapermissionmask := datapermissionmask;
  SELF.RemoveFares := RemoveFares;
	self.bsversion := 52;		
	self.gateways := project(riskwise.shortcuts.gw_delta_dev, transform(Gateway.Layouts.Config, self := left, self := []) );  // turn on deltabase searching
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
edina := Risk_Indicators.ToEdina_52(f, isFCRA, DataRestrictionMask, IntendedPurpose);

OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));
OUTPUT(edina,, outfile_name+'_edina',CSV(QUOTE('"'))); // Write to disk.

