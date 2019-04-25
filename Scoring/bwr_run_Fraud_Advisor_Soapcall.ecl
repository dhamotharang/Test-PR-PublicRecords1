prii_layout := record

string	firstname	;
string	lastname	;
string	ssn	;
string	dateofbirth	;
string	account	;
string	applicatio	;
string	score_a	;
string	bad_indiac	;
string	streetaddress	;
string	city	;
string	state	;
string	zip	;
end;
f := DATASET('~thor_data50::in::embarq',prii_layout,csv(heading(1),quote('"')));
output(f);

Scoring.Layout_Fraud_Advisor into_Fraud_Advisor_input(f le) := transform
self.SSN :=le.Ssn[1..3]+le.Ssn[5..6]+le.Ssn[8..11];  
self.HistoryDateYYYYMM := 200601;
	self.dppapurpose := 1;
	self.glbpurpose := 1;
	self.gateways := dataset([{'FCRA', 'http://roxieqavip.br.seisint.com:9876'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_Fraud_Advisor_input(LEFT));
output(soap_in, named('soap_in'));

//roxieIP :='http://certfcraroxievip.sc.seisint.com:9876' ; // fcra roxie
roxieIP:='http://roxiestaging.br.seisint.com:9876';  //Regular Roxie

Scoring.MAC_PROD_Soapcall(soap_in, models.Layout_Model, roxieIP, 'models.fraudAdvisor_Service',s_f);

//try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_NP2O_Soapcall,SELF := LEFT));
//Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_NP2O, roxieIP, 'RiskWiseFCRA.RiskWiseMainNP2O',s_f2);

s := s_f(errorcode=''); //+ s_f2;

output(s, named('results'));
output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::FA:embarq', csv(quote('"')),overwrite);
