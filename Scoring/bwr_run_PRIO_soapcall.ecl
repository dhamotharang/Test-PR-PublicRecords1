import riskwise, Scoring;

pi_layout := record
string	ProPay_ID	;
string	First_Name	;
string	Initial	;
string	Last_Name	;
string	DOB	;
string	SSN	;
string	Address	;
string	Apt 	;
string	City	;
string	State	;
string	Zip	;
string	Daytime_Phone	;
string	Evening_Phone	;
string	application_date	;
string	Current_status	;
end;

f := dataset('~thor_data50::in::propay', pi_layout, csv);
//f := enth(dataset('~thor_data50::in::propay', pi_layout, csv(heading(1))),5);
//output(f);

//mapping
Scoring.Layout_PRIO_Soapcall into_PRIO_input(f le) := transform
self.tribcode := 'pi05';
self.account  := le.ProPay_ID;
self.first    := le.First_Name;
self.middleini:= le.Initial;
self.last	  := le.Last_Name;
self.addr	  := le.address+' '+ le.apt;
self.hphone	  := le.Evening_Phone;
self.socs	  := le.SSN;
self.wphone	  := le.Daytime_Phone;
self.HistoryDateYYYYMM:=le.application_date[1..6];
self.runSeed:=false ;
self.dppapurpose := 1;
self.glbpurpose := 1;
self.gateways := dataset([{'FCRA', 'http://roxieqavip.br.seisint.com:9876'}], risk_indicators.Layout_Gateways_In);
self := le;
self := [];
end;

soap_in := project(f,into_PRIO_input(LEFT));
output(soap_in);

roxieIP :='http://roxiestaging.br.seisint.com:9876' ; // staging roxie
//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie

s_f := Scoring.PRIO_Soapcall(soap_in, roxieIP);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_PRIO_Soapcall,SELF := LEFT));
s_f2 := Scoring.PRIO_Soapcall(try_2, roxieIP);

s := s_f(errorcode='') + s_f2;

output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::out::propay', overwrite);

/*   To spray the file as a flat file
errx := record
	string4 errorcode;
	RiskWise.Layout_PRIO;
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