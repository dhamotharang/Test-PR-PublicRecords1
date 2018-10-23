#workunit('name','NonFCRA BT-ST Bocashell 5.0 Process');

/* *** Note that Netacuity is turned ON *** needs to use Cert gateway  */

import risk_indicators, riskwise, ut;

unsigned record_limit :=   5;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 12 restricts ADVO
unsigned1 glba := 1;
unsigned1 dppa := 3;

//===================  input-output files  ======================
infile_name  := ut.foreign_prod+'tfuerstenberg::in::axcess_4284_f_s_in';
outfile_name := '~dvstemp::out::test_btst_out_'+ thorlib.wuid();	// this will output your work unit number in your filename

// roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;   

//==============  Program uses Consumer Data Only  ====================
//==================  bt-st input file layout  ========================
BTST_in := record
	string30            accountnumber := '';
	string30            firstname := '';
	string30            middlename := '';
	string30            lastname := '';
	string120          streetaddress := '';
	string25            city := '';
	string2              state := '';
	string5              zip := '';
	string10            homephone := '';                             
	string9              ssn := '';
	string8              dateofbirth := '';
	string10            workphone := '';
	string15            income := '';
	string20            dlnumber := '';
	string2              dlstate := '';
	string15            balance := '';
	string15            CHARGEOFFD := '';  
	string30            FormerName := '';
	string100          email := '';                            
	string100          employername := '';
	string6              historydateyyyymm := '';
	string120          ipaddress := '';
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
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;

	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 12010100';  
	self.historydateyyyymm := (unsigned)le.historydateyyyymm;
	self.historyDateTimeStamp := '';  // can populate this with full timestamp if the customer has it
		
	self.dppapurpose := dppa;
	self.glbpurpose := glba;
	self.gateways := riskwise.shortcuts.gw_netacuityv4;
	SELF.datarestrictionmask := datarestrictionmask;
	self.bsversion := 50;		
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
	risk_indicators.Layout_Boca_Shell Bill_To_Out;
	risk_indicators.Layout_Boca_Shell Ship_To_Out;
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

OUTPUT (final, , outfile_name, CSV(QUOTE('"')) );  // write the shell result to disk


// --------------- the conversion portion -----------------------------------------

f := dataset(outfile_name, final_layout, csv(quote('"'), maxlength(40000)));
output(choosen(f, eyeball), named('infile'));

billtoshell5 := project(f, transform(riskprocessing.layouts.layout_internal_shell, self.time_ms := left.time_ms, self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.bill_to_out));
shiptoshell5 := project(f, transform(riskprocessing.layouts.layout_internal_shell, self.time_ms := left.time_ms, self.accountnumber := left.accountnumber, self.errorcode := left.errorcode, self := left.ship_to_out));
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

output(btst_edina50, named('btst_edina50'));
output(btst_edina50,, outfile_name+'_edina_v50',CSV(QUOTE('"'),maxlength(8192)));
