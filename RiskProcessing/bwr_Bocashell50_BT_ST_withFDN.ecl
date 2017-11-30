#workunit('name','NonFCRA BT-ST Bocashell 5.0');

/* *** Note that Netacuity is turned ON *** needs to use Cert gateway  */

import risk_indicators, riskwise, ut;

unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 12 restricts ADVO
unsigned1 glba := 1;
unsigned1 dppa := 3;
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output files  ======================
infile_name  := ut.foreign_prod+'jpyon::in::go_6063_btst_input_in';
outfile_name := '~dvstemp::out::btst_fdn_nonfcra50_'+ thorlib.wuid();	// this will output your work unit number in your filename

roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;   

//==============  Program uses Consumer Data Only  ====================
//==================  bt-st input file layout  ========================
BTST_in := record
      string30 	accountnumber := '';
      string30 	firstname := '';
	    string30 	middlename := '';
      string30 	lastname := '';
	    string5	  suffix := '';
      string120	streetaddress := '';
      string25 	city := '';
      string2 	state := '';
      string5 	zip := '';
	    string25	country := '';
      string9 	ssn := '';
      string8 	dateofbirth := '';
	    unsigned1	age := 0;       // not used
      string20 	dlnumber := '';
      string2 	dlstate := '';
	    string100	email := '';
	    string120	ipaddress := '';
	    string10 	homephone := '';
      string10 	workphone := '';
	    string100	employername := '';
      string30	formername := '';
      string30 	firstname2 := '';
	    string30 	middlename2 := '';
      string30 	lastname2 := '';
	    string5  	suffix2 := '';
      string120	streetaddress2 := '';
      string25 	city2 := '';
      string2 	state2 := '';
      string5 	zip2 := '';
	    string25	country2 := '';
      string9 	ssn2 := '';
      string8 	dateofbirth2 := '';
	    unsigned1	age2 := 0;       // not used
      string20 	dlnumber2 := '';
      string2 	dlstate2 := '';
	    string100	email2 := '';
	    string120	ipaddress2 := '';
	    string10 	homephone2 := '';
      string10 	workphone2 := '';
	    string100	employername2 := '';
      string30	formername2 := '';
      string 	  historydate := '';
end;

//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, BTST_in, csv(quote('"'), maxlength(8192)));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

l :=	RECORD
	string old_accountnumber := '';
	string AccountNumber := '';
	string FirstName := '';
	string MiddleName := '';
	string LastName := '';
	string NameSuffix := '';
	string StreetAddress := '';
	string City := '';
	string State := '';
	string Zip := '';
	string Country := '';
	string SSN := '';
	string DateOfBirth := '';
	unsigned Age := 0;
	string DLNumber := '';
	string DLState := '';
	string Email := '';
	string IPAddress := '';
	string HomePhone := '';
	string WorkPhone := '';
	string EmployerName := '';
	string FormerName := '';
	string FirstName2 := '';
	string MiddleName2 := '';
	string LastName2 := '';
	string NameSuffix2 := '';
	string StreetAddress2 := '';
	string City2 := '';
	string State2 := '';
	string Zip2 := '';
	string Country2 := '';
	string SSN2 := '';
	string DateOfBirth2 := '';
	unsigned Age2 := 0;
	string DLNumber2 := '';
	string DLState2 := '';
	string Email2 := '';
	string IPAddress2 := '';
	string HomePhone2 := '';
	string WorkPhone2 := '';
	string EmployerName2 := '';
	string FormerName2 := '';
	unsigned DPPAPurpose := 3;
	unsigned GLBPurpose := 1;
	string IndustryClass := '';
	unsigned HistoryDateYYYYMM := 999999;
	string20 historyDateTimeStamp := '';
	string DataRestrictionMask;
	dataset(risk_indicators.Layout_Gateways_In) gateways;
	integer bsversion;
	unsigned3 LastSeenThreshold;
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

// testcase with some FDN fields populated to prove the script worked
		// self.historydateyyyymm := 999999;  
		// self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  
// self.firstname := 'EILEEN';
// SELF.LASTNAME := 'MCCARTY';
// self.firstname2 := 'EILEEN';
// SELF.LASTNAME2 := 'MCCARTY';
// self.ssn := '397803406';
// self.ssn2 := '397803406';


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
	
 	
	self.dppapurpose := dppa;
	self.glbpurpose := glba;
	self.gateways := riskwise.shortcuts.gw_netacuity;
	SELF.datarestrictionmask := datarestrictionmask;
  SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 51;		
	SELF := le;
END;

indata := PROJECT(ds_input, t_f(LEFT,COUNTER));
output(choosen(indata, eyeball), named('indata'));

temp_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	STRING30 AccountNumber;
	risk_indicators.layout_bocashell_btst_out;
	STRING200 errorcode;	
END;

temp_layout myFail(indata le) :=	TRANSFORM
	self.Bill_To_Out.seq := ((unsigned)le.accountnumber) * 2;
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.accountnumber := le.old_AccountNumber;
	SELF := [];
END;
	
resu := soapcall(indata, roxieIP,
				'Risk_Indicators.Boca_Shell_BtSt_Service', {indata},
				DATASET(temp_layout),
				PARALLEL(parallel_calls), onFail(myFail(LEFT)));

final_layout := record
	unsigned8 time_ms := 0;
	string30 accountnumber;
	risk_indicators.Layout_Boca_Shell -LNJ_Datasets Bill_To_Out;
	risk_indicators.Layout_Boca_Shell -LNJ_Datasets Ship_To_Out;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	string50 errorcode;
end;

fin := project(resu, transform(final_layout, self:=left));
final := join(indata,fin, ((unsigned)left.accountnumber)*2 = right.bill_to_out.seq, 
			transform(final_layout, self.accountnumber := left.old_accountnumber, self := right));
res_err := final(errorcode<>'');

OUTPUT (choosen(final, eyeball), NAMED ('final'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
OUTPUT (count(res_err), NAMED ('error_count'));


// OUTPUT (final, , outfile_name, CSV(QUOTE('"')) );  // write the shell result to disk


// --------------- the conversion portion -----------------------------------------

// f := dataset(outfile_name, final_layout, csv(quote('"'), maxlength(40000)));
// output(choosen(f, eyeball), named('infile'));
f := final;

billtoshell5 := project(f, transform(riskprocessing.layouts.layout_internal_shell_noDatasets, self.time_ms := left.time_ms, self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.bill_to_out));
shiptoshell5 := project(f, transform(riskprocessing.layouts.layout_internal_shell_noDatasets, self.time_ms := left.time_ms, self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.ship_to_out));
isFCRA := false;

billto_edina5 := risk_indicators.ToEdina_v50(billtoshell5, isFCRA, DataRestrictionMask);
shipto_edina5 := risk_indicators.ToEdina_v50(shiptoshell5, isFCRA, DataRestrictionMask);

ox := record
	risk_indicators.Layout_Boca_Shell_Edina_v50 bto;
	risk_indicators.Layout_Boca_Shell_Edina_v50 sto;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
end;

j1 := join(f, billto_edina5, left.bill_to_out.seq=right.seq,
	transform(ox, self.bto := right, self.eddo := left.eddo, self.ip2o := left.ip2o, self.sto.seq := left.ship_to_out.seq, self := []));

btst_edina50 := join(j1, shipto_edina5, left.sto.seq=right.seq,
	transform(ox, self.sto := right, self := left));

output(choosen(btst_edina50, eyeball), named('btst_edina50'));
// output(btst_edina50,, outfile_name+'_edina_v50',CSV(QUOTE('"'),maxlength(8192)));


// Now tack the FDN attributes--test_fraud and contributory_fraud--to the end of the v50 layout.
layout_with_FDN_attributes :=	RECORD
	ox;
	risk_indicators.layouts.layout_test_fraud  BillTo_Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  BillTo_Contributory_Fraud;
	
	risk_indicators.layouts.layout_test_fraud  shipTo_Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  shipTo_Contributory_Fraud;
END;

edina_with_FDN_attributes := 
	join(
		btst_edina50, f, 
		left.bto.seq = right.bill_to_out.seq,
		transform( layout_with_FDN_attributes, 
			self.BillTo_Test_Fraud         := right.bill_to_out.Test_Fraud,  
			self.BillTo_Contributory_Fraud := right.bill_to_out.Contributory_Fraud,  			
			
			self.shipTo_Test_Fraud         := right.ship_to_out.Test_Fraud,  
			self.shipTo_Contributory_Fraud := right.ship_to_out.Contributory_Fraud,  
			self                    := left
		),
		left outer
	);

OUTPUT(CHOOSEN(edina_with_FDN_attributes,eyeball), NAMED('edina_with_FDN_attributes'));
OUTPUT(edina_with_FDN_attributes,, outfile_name+'_edina_v51temp',CSV(QUOTE('"'))); // Write to disk.
