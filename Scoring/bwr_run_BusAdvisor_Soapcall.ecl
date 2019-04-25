import scoring, models;
layout := record
STRING	ACCOUNT	;
STRING	COMPANY	;
STRING	BUSADDRESS	;
STRING	BUSCITY	;
STRING	BUSSTATE	;
STRING	BUSZIP	;
STRING	TIN	;
STRING	BUSPHONE	;
STRING	FIRST	;
STRING	LAST	;
STRING	ADDRESS	;
STRING	CITY	;
STRING	STATE	;
STRING	ZIP	;
STRING	SOCIAL	;
STRING	DOB	;
STRING	DRLC	;
STRING	DRLCST	;
STRING	HOMEPHONE	;
STRING	EMAIL	;
end;

f:= dataset('~thor_data50::in::jpmc-166',layout,csv(heading(1), quote('"')));
output(f);

Scoring.Layout_BusAdvisor_Soapcall into_BusAdvisor_input(f le) := transform

self.AccountNumber:=le.account;
self.CompanyName:=le.company;
self.Addr := le.busaddress;
self.City:=le.buscity;
self.State:=le.busstate;
self.Zip:=le.buszip;
self.BusinessPhone:=le.busphone;
self.TaxIDNumber:=le.tin;
self.RepresentativeFirstName:=le.first;
self.RepresentativeLastName:=le.last;
self.RepresentativeAddr:=le.address;
self.RepresentativeCity:=le.city;
self.RepresentativeState:=le.state;
self.RepresentativeZip:=le.zip;
self.RepresentativeSSN:=le.social;
self.RepresentativeDOB:=le.dob;
self.RepresentativeDLNumber:=le.drlc;
self.RepresentativeDLState:=le.drlcst;
self.RepresentativeHomePhone:=le.homephone;
self.RepresentativeEmailAddress:=le.email;
self.HistoryDateYYYYMM := 999999;
	self.dppapurpose := 1;
	self.glbpurpose := 1;
//	self.gateways := dataset([{'FCRA', 'http://roxieqavip.br.seisint.com:9876'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_BusAdvisor_input(LEFT));
output(soap_in, named('soap_in'));

//roxieIP :='http://certfcraroxievip.sc.seisint.com:9876' ; // fcra roxie
roxieIP:='http://roxiestaging.br.seisint.com:9876';  //Regular Roxie

Scoring.MAC_PROD_Soapcall(soap_in, models.Layout_Model, roxieIP, 'Models.BusinessAdvisor_Service',s_f);

//try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_NP2O_Soapcall,SELF := LEFT));
//Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_NP2O, roxieIP, 'RiskWiseFCRA.RiskWiseMainNP2O',s_f2);

s := s_f(errorcode=''); //+ s_f2;

output(s, named('results'));
output(s(errorcode!=''), named('errors'));
//output(s,,'~thor_data50::FA:embarq', csv(quote('"')),overwrite);
ox:= record
string accountnumber;
string score_0_999;
string reason;
string reason2;
string score_0_90;
string reason_2;
string reason_22;
end;

ox normit(s L) := transform
	self.score_0_999 := l.scores[1].i;
	self.reason := l.scores[1].reason_codes[1].reason_code;
	self.reason2 := l.scores[1].reason_codes[2].reason_code;

	self.score_0_90 := l.scores[3].i;
	self.reason_2 := l.scores[3].reason_codes[1].reason_code;
	self.reason_22 := l.scores[3].reason_codes[2].reason_code;
	self:=l;
end;
out:= project(s, normit(left));
output(out);