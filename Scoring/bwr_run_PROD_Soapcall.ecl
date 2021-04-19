/*****************************************
1. Change the input file and add the layout
2. Replace "SD1O" with the prod code needed
3. Change the output file name
4. Select Gateway, choose roxie IP. 
5. Do syntax checking
*/////////////////////////////////////////

import riskwise, Scoring, Seed_Files,risk_indicators;

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

f := dataset('~thor_data50::in::charmingex75', layout_prii, csv(QUOTE('"')));

//mapping
Scoring.Layout_SD1O_Soapcall into_SD1O_input(f le) := transform
	self.tribcode := 'ex75';  // !! replace the tribcode here !!
	self.HistoryDateYYYYMM:=(integer)'200607';
	self.runSeed:=false ;
//	self.dppapurpose := 0; 	self.glbpurpose := 5;
	self.dppapurpose := 3; 	self.glbpurpose := 1;
	self.gateways := dataset([
{'FCRA', 'http://prdrfcrathorvip.hpcc.risk.regn.net:9876'},
{'neutralroxie','http://oroxievip.sc.seisint.com:9876'}],risk_indicators.Layout_Gateways_In);

	self := le;
	self := [];
end;

unsigned1 Parallel_threads := 30;

soap_in := project(f,into_SD1O_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP :='http://prdrfcrathorvip.hpcc.risk.regn.net:9876' ; // fcra roxie
//roxieIP:='http://oroxievip.sc.seisint.com:9876';  //Regular Roxie

Scoring.MAC_PROD_Soapcall(soap_in, RiskWise.Layout_SD1O, roxieIP, 'RiskWiseFCRA.RiskWiseMainSD1O',s_f, Parallel_threads);

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
