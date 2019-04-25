/*****************************************
1. Change the input file and add the layout
2. Replace "SD1O" with the prod code needed
3. Change the output file name
4. Select Gateway, choose roxie IP. 
5. Do syntax checking
*/////////////////////////////////////////

import riskwise, Scoring, Seed_Files,risk_indicators;

f := dataset('~thor_data50::in::charmingex75', layout, csv(QUOTE('"')));

//mapping
Scoring.Layout_SD1O_Soapcall into_SD1O_input(f le) := transform
	self.tribcode := 'ex75';  // !! replace the tribcode here !!
	self.first    := le.FName;
	self.last	  := le.LName;
	self.addr	  := le.address;
	self.hphone	  := le.homePhone;
	self.socs	  := le.Social;
	self.wphone	  := le.workPhone;
	self.HistoryDateYYYYMM:=(integer)'200607';
	self.runSeed:=false ;
//	self.dppapurpose := 0; 	self.glbpurpose := 5;
	self.dppapurpose := 3; 	self.glbpurpose := 1;
	self.gateways := dataset([
{'FCRA', 'http://roxieqavip.br.seisint.com:9876'},
{'attus','http://rw_score_dev: Password01@rwgatewaycert.br.seisint.com:8090/wsGateway'},
{'netacuity','http://rw_score_dev: Password01@rwgatewaycert.br.seisint.com:8090/wsGateway'},
{'veris','http://rw_score_dev:Password01@rwgatewaycert.br.seisint.com: 8090/ws_ssn'},
{'targus','http://rw_score_dev:Password01@rwgatewaycert.br.seisint.com: 8090/wsGateway'},
{'neutralroxie','http://roxieqavip.br.seisint.com:9876'}],risk_indicators.Layout_Gateways_In);

	self := le;
	self := [];
end;

soap_in := project(f,into_SD1O_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP :='http://certfcraroxievip.sc.seisint.com:9876' ; // fcra roxie
//roxieIP:='http://roxiestaging.br.seisint.com:9876';  //Regular Roxie

Scoring.MAC_PROD_Soapcall(soap_in, RiskWise.Layout_SD1O, roxieIP, 'RiskWiseFCRA.RiskWiseMainSD1O',s_f);

//try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_SD1O_Soapcall,SELF := LEFT));
//Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_SD1O, roxieIP, 'RiskWiseFCRA.RiskWiseMainSD1O',s_f2);

s := s_f(errorcode=''); //+ s_f2;

output(s, named('results'));
output(s_f(errorcode<>''), named('errors'));
output(s,,'~thor_data50::ex75::charming', csv,overwrite);


/*   
/To spray the file as a flat file
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
