#workunit('name','nonfcra-fd23');
#option ('hthorMemoryLimit', 1000)


import riskwise, Scoring, risk_indicators;

Layout_PR2O_soapcall := record
	string	account;  
	string	apptypeflag;  
	string	first;  
	string	last;  
	string	cmpy;  
	string	addr;  
	string	city;  
	string	state;  
	string	zip;  
	string	socs;  
	string	dob;  
	string	hphone;  
	string	wphone;  
	string	drlc;  
	string	drlcstate;  
	string	email;  
	string	apptypeflag2;  
	string	first2;  
	string	last2;  
	string	cmpy2;  
	string	addr2;  
	string	city2;  
	string	state2;  
	string	zip2;  
	string	socs2;  
	string	dob2;  
	string	hphone2;  
	string	wphone2;  
	string	drlc2;  
	string	drlcstate2;  
	string	email2;  
	string	saleamt;  
	string	purchdate;  
	string	purchtime;  
	string	checkaba;  
	string	checkacct;  
	string	checknum;  
	string	bankname;  
	string	pymtmethod;  
	string	cctype;  
	string	avscode;  
	integer	HistoryDateYYYYMM;

end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('jpyon::in::cap_1631_f_s_in', Layout_PR2O_soapcall, csv(QUOTE('"')));
// f := choosen(dataset('~jpyon::in::cap_1631_f_s_in', Layout_PR2O_Soapcall, csv(QUOTE('"'))),5);

output(f);


//mapping
Scoring.Layout_PR2O_soapcall into_PR2O_input(f le) := transform
	self.tribcode := 'fd23';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self := le;
	self := [];
end;

soap_in := project(f,into_PR2O_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP:='http://roxiethorvip.hpcc.risk.regn.net:9856';  // Roxiebatch


xlayout := RECORD
	STRING errorcode;
	RiskWise.Layout_PR2O;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_f := soapcall(soap_in, roxieIP,
				'RiskWise.RiskWiseMainPR2O', {soap_in}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('RiskWise.RiskWiseMainPR2OResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(parallel_threads), onFail(myFail(LEFT)));

s := s_f(errorcode=''); 

output(s, named('results'));
output(s,,'~jpyon::out::cap_1631_fd23_out', CSV(heading(single), QUOTE('"')), overwrite);
//output(s_f(errorcode<>''),,'~jpyon::out::chase_1275_bnk4_error',CSV(heading(single), QUOTE('"')), overwrite);
