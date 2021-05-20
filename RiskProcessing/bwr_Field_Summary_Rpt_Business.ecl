#workunit('name','Business Field Summary Rpt');
#option ('hthorMemoryLimit', 1000);
IMPORT scoring, RiskWise;

prii_layout := RECORD
	string	Account	;
	string	CompanyName	;
	string	AlternateCompanyName	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	BusinessPhone	;
	string	TaxIdNumber	;
	string	BusinessIPAddress ;
	string	RepresentativeFirstName	;
	string	RepresentativeMiddleName ;
	string	RepresentativeLastName	;
	string	RepresentativeNameSuffix  ;
	string	RepresentativeAddr	;
	string	RepresentativeCity	;
	string	RepresentativeState	;
	string	RepresentativeZip	;
	string	RepresentativeSSN	;
	string	RepresentativeDOB	;
	string  RepresentativeAge   ;
	string	RepresentativeDLNumber	;
	string	RepresentativeDLState	;
	string	RepresentativeHomePhone	;
	string	RepresentativeEmailAddress	;
	string  RepresentativeFormerLastName ;
	integer	HistoryDateYYYYMM;

END;

// f := DATASET('~tfuerstenberg::in::amex_6404_gcp_bus_in',prii_layout,csv(quote('"')));
f := choosen(DATASET('~tfuerstenberg::in::midland_7805_bus_in.csv',prii_layout,csv(quote('"'))),20);

// The enth function allows you to sample down the input for the F&S
// f :=Q enth(dataset('~tfuerstenberg::in::amex_6404_jan2014_bus_in', prii_layout, csv(quote('"'))),370028);

output(f);

l :=	RECORD
	STRING old_account_number;
	string RepresentativeEmailAddress;
	string BusinessIPAddress;
	riskwise.Layout_FLG1;
END;

l t_f(f le, INTEGER c) :=	TRANSFORM
  self.tribcode := 'flg1';
	self.old_account_number := le.account;
	self.account := (string)c;
	self.last	  := le.CompanyName;
	self.hphone	  := le.BusinessPhone;
	self.socs	  := le.TaxIdNumber;

	self := le;
	self:=[];
END;

p_f := PROJECT(f,t_f(LEFT,COUNTER));
output(p_f);


roxieIP := 'http://roxiethorvip.hpcc.risk.regn.net:9856'; // Roxiebatch

s := riskwise.RiskwiseMainFLGO_Soapcall(project(p_f, transform(riskwise.Layout_FLG1, self:=left)), roxieIP);

temp_layout := RECORD
scoring.Layout_FLGOFLG1;
string EMAIL;
string IPAddress;
end;

temp_layout joinem(p_f le, s rt) := transform
	self.account := le.old_account_number;
	self.account2 := le.old_account_number;
	self.EMAIL := le.RepresentativeEmailAddress;
	self.IPAddress := le.BusinessIPAddress;
	self := le;
	self := rt;
end;

flg1 := join(p_f, s, left.account=right.account, joinem(left,right));

output(flg1, named('flg1'));
//output(flg1,,'~tfuerstenberg::out::ALL_Records_F-S_out',CSV(heading(single), quote('"')), overwrite);
output(flg1(riskwiseid!=''),named('flgo_errors'));
Scoring.MAC_FS_Soapcall(flg1,f_o);
output(f_o);
output(f_o,,'~evanheel::out::Temp_Bus_FS.csv',CSV(heading(single), quote('"')), overwrite);
