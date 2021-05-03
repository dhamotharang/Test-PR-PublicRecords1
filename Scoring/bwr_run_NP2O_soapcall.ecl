import riskwise, Scoring;

prii_layout := RECORD
	STRING AccountNumber;
	string seq;
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

f := DATASET('~thor_data50::in::national_city_bank',prii_layout,csv(quote('"')));
//f := enth(dataset('~thor_data50::in::propay', pi_layout, csv(heading(1))),5);
//output(f);

//mapping
Scoring.Layout_NP2O_Soapcall into_NP2O_input(f le) := transform
self.tribcode := 'np27';
self.account  := le.AccountNumber;
self.first    := le.FirstName;
self.middleini:= le.MiddleName;
self.last	  := le.LastName;
self.addr	  := le.streetaddress;
self.hphone	  := le.homePhone;
self.socs	  := le.SSN;
self.wphone	  := '';
self.dob := le.DateOfBirth;
self.HistoryDateYYYYMM:='200605';
self.runSeed:=false ;
self.dppapurpose := 1;
self.glbpurpose := 1;
self := le;
self := [];
end;

soap_in := project(f,into_NP2O_input(LEFT));
output(soap_in);

roxieIP :='http://prdrroxiethorvip.hpcc.risk.regn.net:9876' ; // DR roxie

s_f := Scoring.NP2O_Soapcall(soap_in, roxieIP);
try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_NP2O_Soapcall,SELF := LEFT));
s_f2 := Scoring.NP2O_Soapcall(try_2, roxieIP);

s := s_f(errorcode='') + s_f2;

output(s(errorcode!=''), named('errors'));
output(s,,'~thor_data50::out::national_city_bank', overwrite);

/*   To spray the file as a flat file
errx := record
	string4 errorcode;
	RiskWise.Layout_NP2O;
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