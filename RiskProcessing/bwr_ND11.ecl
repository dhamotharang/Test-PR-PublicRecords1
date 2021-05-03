#workunit('name','NonFCRA-nd11 process');
#option ('hthorMemoryLimit', 1000)

/* *** Note that Neticuity is turned ON *** needs to use Cert gateway  */
 
import riskwise, Scoring, risk_indicators;

Layout_CDXO_Soapcall := record
	string	account	;
	string	ordertype	;
	string	cmpy	;
	string	cmpytype	;
	string	first	;
	string	last	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	hphone	;
	string	wphone	;
	string	socs	;
	string	formerlast	;
	string	email	;
	string	drlc	;
	string	drlcstate	;
	string	ipaddr	;
	string	avscode	;
	string	channel	;
	string	first2	;
	string	last2	;
	string	cmpy2	;
	string	addr2	;
	string	city2	;
	string	state2	;
	string	zip2	;
	string	hphone2	;
	string	channel2	;
	string	orderamt	;
	string	numitems	;
	string	orderdate	;
	string	cidcode	;
	string	shipmode	;
	string	pymtmethod	;
	string	productcode	;
	string	score	;
	string	score2	;
	integer	HistoryDateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('~tfuerstenberg::in::dell_1338_nd11_in', Layout_CDXO_Soapcall, csv(QUOTE('"')));
// f := choosen(dataset('~tfuerstenberg::in::dell_1338_nd11_in', Layout_CDXO_Soapcall, csv(QUOTE('"'))),10);
output(f);

//mapping
Scoring.Layout_CDXO_Soapcall into_CDXO_input(f le) := transform
	self.tribcode := 'nd11';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'},
						{'netacuity', 'http://rw_data_prod:Password01@rwgatewaycert.sc.seisint.com:7726/WsGateway'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_CDXO_input(LEFT));
output(soap_in, named('soap_in'));


roxieIP:='http://roxiethorvip.hpcc.risk.regn.net:9856';  //Regular Roxie

Scoring.MAC_PROD_Soapcall(soap_in, RiskWise.Layout_CDXO, roxieIP, 'RiskWise.RiskWiseMainCDXO',s_f,parallel_threads);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_CDXO_Soapcall,SELF := LEFT));
Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_CDXO, roxieIP, 'RiskWise.RiskWiseMainCDXO',s_f2,parallel_threads);

s := s_f(errorcode=''); //+ s_f2;

output(s, named('results'));
output(s,,'~tfuerstenberg::out::dell_1338_nd11_out',csv(heading(single), quote('"')),overwrite );
output(s(errorcode<>''),,'~tfuerstenberg::out::dell_1338_nd11_error',CSV(QUOTE('"')), overwrite);
