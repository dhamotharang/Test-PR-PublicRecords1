#workunit('name','FCRA-2x68 Process');
#option ('hthorMemoryLimit', 1000)


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

// f := dataset('~tfuerstenberg::in::att_1060_2x68', layout_prii, csv(QUOTE('"')));
f := choosen(dataset('~tfuerstenberg::in::att_1060_2x68', layout_prii, csv(QUOTE('"'))),10);

output(f);
output(count(f));


//mapping
Scoring.Layout_SC1O_Soapcall into_SC1O_input(f le) := transform
	self.tribcode := '2x68';  // !! replace the tribcode here !!
//	self.HistoryDate:='200607';
	self.dppapurpose := 0;
	self.glbpurpose := 5;
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_SC1O_input(LEFT));
output(soap_in, named('soap_in'));


isFCRA := True;	//CHANGE THIS FOR NON-FCRA TO FALSE////////////////////////////////////////////////////

fcraRoxie :='http://fcrabatch.sc.seisint.com:9876' ; // fcrabatch production roxie
roxieIP :='http://roxiebatch.br.seisint.com:9856';   // roxiebatch

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

output(s,,'~tfuerstenberg::out::att_1060_2x68_out',CSV(heading(single), QUOTE('"')), overwrite);
output(s(errorcode<>''),,'~tfuerstenberg::out::att_1060_2x68_error',CSV(QUOTE('"')), overwrite);
