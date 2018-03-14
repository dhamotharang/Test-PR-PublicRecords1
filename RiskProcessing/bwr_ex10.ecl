#workunit('name','NonFCRA-ex10-process');

import riskwise, Scoring, risk_indicators;

layout_prii := record
     string ACCOUNT;
     string first;
     string MIDDLEINI;
     string last;
     string addr;
     string CITY;
     string STATE;
     string ZIP;
     string hphone;
     string socs;
     string DOB;
     string wphone;
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

f := dataset('~tfuerstenberg::in::equifax_2140_in', layout_prii, csv(QUOTE('"')));
//f := choosen(dataset('~jpyon::in::charming_1180_f_s_in', layout_prii, csv(QUOTE('"'))),100);
output(f);


//mapping
Scoring.Layout_SD1O_Soapcall into_SD1O_input(f le) := transform   ////change****
	self.tribcode := 'ex10';  // !! replace the tribcode here !!    ////change****
//	self.HistoryDate:='200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
  //self.DataRestrictionMask := '000001000100';  // restricts experian and transunion from use	
	self := le;
	self := [];
end;

soap_in := project(f,into_SD1O_input(LEFT));   ////change****
output(soap_in, named('soap_in'));


isFCRA := false;	//CHANGE THIS FOR NON-FCRA TO FALSE////////////////////////////////////////////////////

fcraRoxie :='http://fcrabatch.sc.seisint.com:9876' ; // fcra roxie
roxieIP :='http://roxiebatch.br.seisint.com:9856';   // Roxiebatch

fcralayout := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainSD1O', 'RiskWise.RiskWiseMainSD1O'); ////change****
ip := if(isFCRA, fcraRoxie, roxieIP);

xlayout := RECORD
	STRING errorcode;
	RiskWise.Layout_SD1O;
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

output(s,,'~tfuerstenberg::out::equifax_2140_ex10_out',CSV(heading(single),QUOTE('"')), overwrite);
output(s(errorcode<>''),,'~tfuerstenberg::out::equifax_2140_ex10_error',CSV(QUOTE('"')), overwrite);