SD2I := record
     string30 accountnumber := '';
     string1 apptype := '';
     string15 firstname := '';
     string20 lastname := '';
     string30 employername := '';
     string50 streetaddress := '';
     string30 city := '';
     string2 state := '';
     string9 zip := '';
     string9 ssn := '';
     string8 dateofbirth := '';
     string10 homephone := '';
     string10 workphone := '';
     string20 dlnumber := '';
     string2 dlstate := '';
     string50 email := '';
     string1 apptype2 := '';
     string15 firstname2 := '';
     string20 lastname2 := '';
     string30 employername2 := '';
     string50 streetaddress2 := '';
     string30 city2 := '';
     string2 state2 := '';
     string9 zip2 := '';
     string9 ssn2 := '';
     string8 dateofbirth2 := '';
     string10 homephone2 := '';
     string10 workphone2 := '';
     string20 dlnumber2 := '';
     string2 dlstate2 := '';
     string50 email2 := '';
     string6 saleamt := '';
     string8 purchdate := '';
     string6 purchtime := '';
     string11 checkaba := '';
     string9 checkacct := '';
     string7 checknum := '';
     string40 bankname := '';
     string2 pymtmethod := '';
     string1 cctype := '';
     string2 avscode := '';
     string2 inquiries := '';
     string3 trades := '';
     string6 balance := '';
     string6 bankbalance := '';
     string6 highcredit := '';
     string3 delinquent90plus := '';
     string2 revolving := '';
     string2 autotrades := '';
     string2 autotradesopen := '';
     string6 income := '';
     string6 income2 := '';
     string45 ipaddress := '';
     string16 ccnum := '';
     string8 ccexpdate := '';
     string2 taxclass := '';
	string6 historydateyyyymm := '';
end;
 

//f := dataset('~tfuerstenberg::in::dfs_btst_bocashell', SD2I,csv(QUOTE('"')));
f := enth(dataset('~tfuerstenberg::in::dfs_btst_bocashell', SD2I, csv(QUOTE('"'))),2);
output(f);


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
	dataset(risk_indicators.Layout_Gateways_In) gateways;
END;

l t_f(f le, INTEGER c) := TRANSFORM
	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;
	self.historydateyyyymm := (unsigned)le.historydateyyyymm;
	SELF := le;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'netacuity', 'http://rw_score_dev:Password01@wsgatewaycert.sc.seisint.com:8090/WsGateway'}], risk_indicators.Layout_Gateways_In);
	SELF := [];
END;

indata := PROJECT(f,t_f(LEFT,COUNTER));
output(indata, named('indata'));

roxieIP := 'http://roxiestaging.br.seisint.com:9876'; // staging vip
//roxieIP := 'http://10.173.202.6:8222';
//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie

temp_layout := record
	STRING AccountNumber;
	risk_indicators.layout_bocashell_btst_out;
	STRING errorcode;	
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
			  PARALLEL(1), onFail(myFail(LEFT)));

//output(resu, named('BTST_Bocashell_Results'));

final_layout := record
	string accountnumber;
	risk_indicators.Layout_Boca_Shell_Edina Bill_To_Out;
	risk_indicators.Layout_Boca_Shell_Edina Ship_To_Out;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	string errorcode;
end;

fin := project(resu, transform(final_layout, self:=left));
final := join(indata,fin, ((unsigned)left.accountnumber)*2 = right.bill_to_out.seq, 
			transform(final_layout, self.accountnumber := left.old_accountnumber, self := right));

output(final, named('final'));
//output(final,, '~thor_data50::btst_bocashell::out', csv(quote('"')), overwrite);
//output(final(errorcode<>''), named('errors'));
//output(final(errorcode<>''),,'~thor_data50::btst_bocashell::out_error',CSV(QUOTE('"')), overwrite);
