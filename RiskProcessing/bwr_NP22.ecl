#workunit('name','NonFCRA-np22-process');
#option ('hthorMemoryLimit', 1000)


import scoring, risk_indicators;

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

f := DATASET('~jpyon::in::fifth_1728_f_s_in',layout_prii,csv(quote('"')));
 //f := choosen(dataset('~jpyon::in::fifth_1728_f_s_in',layout_prii, csv(quote('"'))),15);
output(f);

//mapping
Scoring.Layout_NP2O_Soapcall into_NP2O_input(f le) := transform
	self.tribcode := 'np22';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:='200607';
//	self.runSeed:=false ;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'Neutral', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_NP2O_input(LEFT));
output(soap_in,named('soapin'));

roxieIP :='http://roxiethorvip.hpcc.risk.regn.net:9856' ; // nonfcra roxiebatch

//import risk_indicators;

NP2O_Layout := RECORD
	STRING30 acctno := '';
	STRING30 account := '';
	STRING32 riskwiseid := '';
	STRING2 socsverlevel := '';
	STRING2 phoneverlevel := '';
	STRING3 score := '';
	STRING3 score2 := '';
	STRING3 score3 := '';
	STRING2 reason1 := '';
	STRING2 reason2 := '';
	STRING2 reason3 := '';
	STRING2 reason4 := '';
	STRING2 reason5 := '';
	STRING2 reason6 := '';
	STRING2 action1 := '';
	STRING2 action2 := '';
	STRING2 action3 := '';
	STRING2 action4 := '';
	STRING8 correctdob := '';
	STRING10 correcthphone := '';
	STRING9 correctsocs := '';
	STRING50 correctaddr := '';
	STRING3 altareacode := '';
	STRING8 splitdate := '';
	STRING15 dirsfirst := '';
	STRING20 dirslast := '';
	STRING50 dirsaddr := '';
	STRING30 dirscity := '';
	STRING2 dirsstate := '';
	STRING9 dirszip := '';
	STRING10 nameaddrphone := '';
	STRING8 socllowissue := '';
	STRING8 soclhighissue := '';
	STRING2 soclstate := '';
	STRING15 eqfsfirst := '';
	STRING20 eqfslast := '';
	STRING50 eqfsaddr := '';
	STRING30 eqfscity := '';
	STRING2 eqfsstate := '';
	STRING9 eqfszip := '';
	STRING10 eqfsphone := '';
	STRING50 eqfsaddr2 := '';
	STRING30 eqfscity2 := '';
	STRING2 eqfsstate2 := '';
	STRING9 eqfszip2 := '';
	STRING10 eqfsphone2 := '';
	STRING50 eqfsaddr3 := '';
	STRING30 eqfscity3 := '';
	STRING2 eqfsstate3 := '';
	STRING9 eqfszip3 := '';
	STRING10 eqfsphone3 := '';
	STRING20 altlast := '';
	STRING20 altlast2 := '';
	STRING20 altlast3 := '';
	STRING3 hriskalerttable := '';
	STRING10 hriskalertnum := '';
	STRING15 alertfirst := '';
	STRING20 alertlast := '';
	STRING50 alertaddr := '';
	STRING30 alertcity := '';
	STRING2 alertstate := '';
	STRING9 alertzip := '';
	STRING50 alertentity := '';
END;

xlayout := RECORD
	STRING errorcode;
	NP2O_Layout;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_f := soapcall(soap_in, roxieIP,
				'RiskWise.RiskWiseMainNP2O', {soap_in}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('RiskWise.RiskWiseMainNP2OResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(parallel_threads), onFail(myFail(LEFT)));

s := s_f(errorcode='');

output(s, named('results'));
output(s(errorcode!=''), named('errors'));
output(s,,'~jpyon::out::fifth_1728_np22_out',csv(heading(single), quote('"')), overwrite);
