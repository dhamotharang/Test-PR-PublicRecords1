#workunit('name','ex90 Non-FCRA Process');

import riskwise, Scoring, Seed_Files,risk_indicators;

layout_prii := record
     string ACCOUNT;
     string FIRST;
     string MIDDLEINI;
     string LAST;
     string ADDR;
     string CITY;
     string STATE;
     string ZIP;
     string HPHONE;
     string SOCS;
     string DOB;
     string WPHONE;
     string INCOME;
     string DRLC;
     string DRLCST;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERLAST;
     string EMAIL;
     string COMPANY;
     integer HistoryDateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

// f := dataset('~tfuerstenberg::in::drivetime_992_2x59_in', layout_prii, csv(QUOTE('"')));
f := choosen(dataset('~tfuerstenberg::in::drivetime_992_2x59_in', layout_prii, csv(QUOTE('"'))),5);

output(f);


//mapping
Scoring.Layout_SC1O_Soapcall into_SC1O_input(f le) := transform
	self.tribcode := 'ex90';  // !! replace the tribcode here !!
//	self.HistoryDate:='200607';
//	self.run_Seed:=false ;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_SC1O_input(LEFT));
output(soap_in, named('soap_in'));

isFCRA := FALSE;	//CHANGE THIS FOR NON-FCRA TO FALSE////////////////////////////////////////////////////

fcraRoxie :='http://fcrabatch.sc.seisint.com:9876' ; // fcrabatch
roxieIP := 'http://roxiebatch.br.seisint.com:9856';  // roxiebatch

fcralayout := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainSC1O', 'RiskWise.RiskWiseMainSC1O');
ip := if(isFCRA, fcraRoxie, roxieIP);


xlayout := RECORD
	STRING errorcode;
	RiskWise.Layout_SC1O;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_f := soapcall(soap_in, ip,
				fcralayout, {soap_in}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH(fcralayout + 'Response/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(parallel_threads), onFail(myFail(LEFT)));

s := s_f(errorcode=''); 

output(s, named('results'));

output(s,,'~tfuerstenberg::out::test_out',CSV(heading(single), quote('"')), overwrite);
output(s_f(errorcode<>''),,'~tfuerstenberg::out::test_error',CSV(QUOTE('"')), overwrite);

