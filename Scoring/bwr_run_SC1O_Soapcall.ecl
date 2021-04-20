import riskwise, Scoring;

pi_layout := record
string	ACCOUNT	;
string	FIRST	;
string	MIDDLEINI	;
string	LAST	;
string	ADDRESS	;
string	CITY	;
string	STATE	;
string	ZIP	;
string	hphone	;
string	SOCIAL	;
string	DOB	;
string	WPHONE	;
string	INCOME	;
string	DRLC	;
string	DRLCSTate	;
string	BALANCE	;
string	CHARGEOFF	;
string	FORMERLAST	;
string	EMAIL	;
string	Cmpy	;
string	LASTSEENDT	;
end;

f :=  dataset('~eschepers::in::ge_con_ciid',pi_layout,CSV(QUOTE('"')));

//f := enth(dataset('~thor_data50::in::propay', pi_layout, csv(heading(1))),5);
//output(f);

//mapping
Scoring.Layout_SC1O_Soapcall into_SC1O_input(f le) := transform
self.tribcode := 'ex90';
self.account  := le.account;
self.socs	  := le.SOCIAL;
self.HistoryDateYYYYMM:=le.LASTSEENDT;
self.runSeed:=false ;
self.dppapurpose := 0;
self.glbpurpose := 5;
self := le;
self := [];
end;

soap_in := project(f,into_SC1O_input(LEFT));
output(soap_in);

roxieIP :='http://certstagingvip.hpcc.risk.regn.net:9876' ; // staging roxie
//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie

s_f := Scoring.SC1O_Soapcall(soap_in, roxieIP);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_SC1O_Soapcall,SELF := LEFT));
s_f2 := Scoring.SC1O_Soapcall(try_2, roxieIP);

s := s_f(errorcode='') + s_f2;

output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::ex90::ge_rsf', overwrite);

/*   To spray the file as a flat file
errx := record
	string4 errorcode;
	RiskWise.Layout_SC1O;
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