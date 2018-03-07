#workunit('name','FCRA-SC63 Process');
#option ('hthorMemoryLimit', 1000)


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

f := dataset('~tfuerstenberg::in::fairisaac_767_sc63', layout_prii, csv(QUOTE('"')));
// f := choosen(dataset('~tfuerstenberg::in::fairisaac_767_sc63', layout_prii, csv(QUOTE('"'))),5);

output(f);

//mapping
Scoring.Layout_SC1O_Soapcall into_SC1O_input(f le) := transform
	self.tribcode := 'sc63';  // !! replace the tribcode here !!
//	self.HistoryDate:='200607';
	self.dppapurpose := 0;
	self.glbpurpose := 5;
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_SC1O_input(LEFT));
output(soap_in, named('soap_in'));


isFCRA := true;	//CHANGE THIS FOR NON-FCRA TO FALSE////////////////////////////////////////////////////

fcraRoxie :='http://fcrabatch.sc.seisint.com:9876' ; // fcrabatch roxie
roxieIP :='http://roxiebatch.br.seisint.com:9856';   // Roxiebatch


fcralayout := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainSC1O', 'RiskWise.RiskWiseMainSC1O');
ip := if(isFCRA, fcraRoxie, roxieIP);

sc1o_layout := RECORD
	STRING30 account := '';
	STRING30 acctno := '';
	STRING32 riskwiseid := '';
	STRING3  score := '';
	STRING2  reason11 := '';
	STRING2  reason21 := '';
	STRING2  reason31 := '';
	STRING2  reason41 := '';
	STRING3  score2 := '';
	STRING2  reason12 := '';
	STRING2  reason22 := '';
	STRING2  reason32 := '';
	STRING2  reason42 := '';
	STRING3  score3 := '';
	STRING2  reason13 := '';
	STRING2  reason23 := '';
	STRING2  reason33 := '';
	STRING2  reason43 := '';
	STRING3  score4 := '';
	STRING2  reason14 := '';
	STRING2  reason24 := '';
	STRING2  reason34 := '';
	STRING2  reason44 := '';
	STRING89 reserved := '';
END;


xlayout := RECORD
	STRING errorcode;
	sc1o_layout;
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

output(s,,'~tfuerstenberg::out::FairIsaac_HAI_767_sc63_out',CSV(heading(single), QUOTE('"')), overwrite);
output(s(errorcode<>''),,'~tfuerstenberg::out::FairIsaac_HAI_767_sc63_errors',CSV(heading(single), QUOTE('"')), overwrite);
