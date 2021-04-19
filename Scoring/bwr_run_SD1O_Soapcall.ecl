import riskwise, Scoring, Seed_Files;

f := dataset('~eschepers::in::charmingex75', Seed_Files.layout_prii, csv(QUOTE('"')));
output(f);

//mapping
Scoring.Layout_SD1O_Soapcall into_SD1O_input(f le) := transform
	self.tribcode := 'ex75';
	self.first    := le.FName;
	self.last	  := le.LName;
	self.addr	  := le.address;
	self.hphone	  := le.homePhone;
	self.socs	  := le.Social;
	self.wphone	  := le.workPhone;
	self.HistoryDateYYYYMM:='200607';
	self.runSeed:=false ;
	self.dppapurpose := 0;
	self.glbpurpose := 5;
	self.gateways := dataset([{'FCRA', 'http://certstagingvip.hpcc.risk.regn.net:9876'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_SD1O_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP :='http://certfcraroxievip.hpcc.risk.regn.net:9876' ; // cert fcra roxie
isFCRA := true;

s_f := Scoring.SD1O_Soapcall(soap_in, roxieIP, isFCRA);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_SD1O_Soapcall,SELF := LEFT));
s_f2 := Scoring.SD1O_Soapcall(try_2, roxieIP, isFCRA);

s := s_f(errorcode='') + s_f2;

output(s, named('results'));
output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::ex75::charming', overwrite);


/*   To spray the file as a flat file
errx := record
	string4 errorcode;
	RiskWise.Layout_SD1O;
end;

f:=dataset('~thor_data50::out::propay', errx,flat);
output(f);


errx1 := record
errx;
	string1  lf;
end;

errx1 t(f l):= transform
self.lf:='\n';
self:=l;
end;

f1:= project(f,t(left));
output(f1,,'~thor_data50::out::propay_flat',overwrite);
*/
