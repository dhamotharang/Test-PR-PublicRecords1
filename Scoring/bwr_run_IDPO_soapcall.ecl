/*****************************************
1. Change the input file and layout
2. Replace "IDPO" with the prod code needed
3. Change the output file name
4. Do syntax checking
*/////////////////////////////////////////

import riskwise, Scoring, Seed_Files,risk_indicators;

f := dataset('~eschepers::in::charmingex75', Seed_Files.layout_prii, csv(QUOTE('"')));


//mapping
Scoring.Layout_IDPO_Soapcall into_IDPO_input(f le) := transform
	self.tribcode := 'idp1';  // !! replace the tribcode here !!
	self.first    := le.FName;
	self.last	  := le.LName;
	self.addr	  := le.address;
	self.hphone	  := le.homePhone;
	self.socs	  := le.Social;
	self.wphone	  := le.workPhone;
	self.HistoryDateYYYYMM:=(integer)'200607';
	self.runSeed:=false ;
	self.dppapurpose := 0;
	self.glbpurpose := 5;
	self.gateways := dataset([{'Neutral', 'http://prdrroxiethorvip.hpcc.risk.regn.net:9876'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_IDPO_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP:='http://prdrroxiethorvip.hpcc.risk.regn.net:9876'; //DR Roxie

Scoring.MAC_PROD_Soapcall(soap_in, RiskWise.Layout_IDPO, roxieIP, 'RiskWise.RiskWiseMainIDPO',s_f);

//try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_IDPO_Soapcall,SELF := LEFT));
//Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_IDPO, roxieIP, 'RiskWiseFCRA.RiskWiseMainIDPO',s_f2);

s := s_f(errorcode=''); //+ s_f2;

output(s, named('results'));
output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::ex75::charming', overwrite);


/*   To spray the file as a flat file
errx := record
	string4 errorcode;
	RiskWise.Layout_IDPO;
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
