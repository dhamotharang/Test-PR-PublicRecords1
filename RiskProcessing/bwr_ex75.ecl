#workunit('name','FCRA-ex75-process');

import riskwise, Scoring, risk_indicators;

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
     string DRLCSTATE;
     string BALANCE;
     string CHARGEOFFDATE;
     string FORMERLAST;
     string EMAIL;
     string CMPY;
     integer HistoryDateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('~jpyon::in::charming_1180_f_s_in', layout_prii, csv(QUOTE('"')));
//f := choosen(dataset('~jpyon::in::charming_1180_f_s_in', layout_prii, csv(QUOTE('"'))),100);
output(f);


//mapping
Scoring.Layout_SD1O_Soapcall into_SD1O_input(f le) := transform   ////change****
	self.tribcode := 'ex75';  // !! replace the tribcode here !!    ////change****
	self.first    := le.FName;
	self.last	  := le.LName;
	self.addr	  := le.address;
	self.hphone	  := le.homePhone;
	self.socs	  := le.Social;
	self.wphone	  := le.workPhone;
//	self.HistoryDate:='200607';
	self.dppapurpose := 0;
	self.glbpurpose := 5;
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_SD1O_input(LEFT));   ////change****
output(soap_in, named('soap_in'));


isFCRA := true;	//CHANGE THIS FOR NON-FCRA TO FALSE////////////////////////////////////////////////////


fcraRoxie :='http://fcrabatch.sc.seisint.com:9876' ; // fcra roxie
roxieIP :='http://roxiebatch.br.seisint.com:9856';  //Regular DR Roxie

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

output(s,,'~jpyon::out::charming_1180_ex75_out',CSV(heading(single),QUOTE('"')), overwrite);
output(s(errorcode<>''),,'~jpyon::out::charming_1180_ex75_error',CSV(QUOTE('"')), overwrite);