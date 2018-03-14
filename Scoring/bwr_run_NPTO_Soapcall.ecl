import riskwise, Scoring;

prii_layout := RECORD
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING HomePhone;
	STRING SSN;
	STRING DateOfBirth;
END;

//f := DATASET('~eschepers::in::hsbcautonpt1',prii_layout,csv(quote('"')));
f := enth(dataset('~eschepers::in::hsbcautonpt1',prii_layout, csv(quote('"'))),5);

//mapping
Scoring.Layout_NPTO_Soapcall into_NPTO_input(f le) := transform
self.tribcode := 'npt1';
self.account  := le.AccountNumber;
self.first    := le.FirstName;
self.middleini:= le.MiddleName;
self.last	  := le.LastName;
self.addr	  := le.streetaddress;
self.hphone	  := le.homePhone;
self.socs	  := le.SSN;
self.wphone	  := '';
self.dob := le.DateOfBirth;
self.HistoryDateYYYYMM:='200607';
self.runSeed:=false ;
self.dppapurpose := 1;
self.glbpurpose := 1;
self := le;
self := [];
end;

soap_in := project(f,into_NPTO_input(LEFT));
output(soap_in);

roxieIP :='http://roxiestaging.br.seisint.com:9876' ; // staging roxie
//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie

s_f := Scoring.NPTO_Soapcall(soap_in, roxieIP);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_NPTO_Soapcall,SELF := LEFT));
s_f2 := Scoring.NPTO_Soapcall(try_2, roxieIP);

s := s_f(errorcode='') + s_f2;

output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::npto::hsbc', overwrite);

/*   To spray the file as a flat file
errx := record
	string4 errorcode;
	RiskWise.Layout_NPTO;
end;

f:=dataset('~thor_data50::npto::hsbc', errx,flat);
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
output(f1,,'~thor_data50::npto::hsbc_flat',overwrite);
*/