#workunit('name','FCRA-ex24');
#option ('hthorMemoryLimit', 1000)


import riskwise, Scoring, risk_indicators;

Layout_SDBO_Soapcall := record
	string  account;
	string  apptype;
	string  first;
	string  last;
	string  cmpy;
	string  addr;
	string  city;
	string  state;
	string  zip;
	string  socs;
	string  dob;
	string  hphone;
	string  wphone;
	string  drlc;
	string  ddrlcstate;
	string  email;
	string  apptype2;
	string  first2;
	string  last2;
	string  cmpy2;
	string  addr2;
	string  city2;
	string  state2;
	string  zip2;
	string  socs2;
	string  dob2;
	string  hphone2;
	string  wphone2;
	string  drlc2;
	string  drlcstate2;
	string  email2;
	string  saleamt;
	string  purchdate;
	string  purchtime;
	string  checkaba;
	string  checkacct;
	string  checknum;
	string  bankname;
	string  pymtmethod;
	string  cctype;
	string  avscode;
	string  inquiries;
	string  trades;
	string  balance;
	string  bankbalance;
	string  highcredit;
	string  delinquent90plus;
	string  revolving;
	string  autotrades;
	string  autotradesopen;
	string  income;
	string  income2;
	string  ipaddr;
	string  ccnum;
	string  ccexpdate;
	string  taxclass;
	integer HistoryDateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('tfuerstenberg::in::echostar_634_ex24_bt_nonpay', Layout_SDBO_Soapcall, csv(QUOTE('"')));
// f := choosen(dataset('~tfuerstenberg::in::echostar_634_ex24_h_nonpay', Layout_SDBO_Soapcall, csv(QUOTE('"'))),5);

output(f);


//mapping
Scoring.Layout_SDBO_Soapcall into_SDBO_input(f le) := transform
	self.tribcode := 'ex24';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_SDBO_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP:='http://roxiethorvip.hpcc.risk.regn.net:9856';  // Roxiebatch

xlayout := RECORD
	STRING errorcode;
	RiskWise.Layout_SDBO;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_f := soapcall(soap_in, roxieIP,
				'RiskWise.RiskWiseMainSDBO', {soap_in}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('RiskWise.RiskWiseMainSDBOResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(parallel_threads), onFail(myFail(LEFT)));

s := s_f(errorcode=''); 

output(s, named('results'));
output(s,,'~tfuerstenberg::out::echostar_634_ex24_bt_nonpay_out', CSV(heading(single), QUOTE('"')), overwrite);
output(s_f(errorcode<>''),,'~tfuerstenberg::out::echostar_634_ex24_bt_nonpay_error',CSV(heading(single), QUOTE('"')), overwrite);
