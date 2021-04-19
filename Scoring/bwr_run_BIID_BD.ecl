#workunit('name','Business IID-BD Process');

layout:= record
	string	AccountNumber	;
	string	CompanyName	;
	string	AlternateCompanyName	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	Businesstype   ;
	string	TaxIdNumber	;
	string	BusinessPhone	;
	string	BusinessPhone2	;
	string	BusinessPhone3	;
	string	website ;
	string	RepresentativeFirstName	;
	string	RepresentativeLastName	;
	string	RepresentativeNameSuffix  ;
	string	RepresentativeAddr	;
	string	RepresentativeCity	;
	string	RepresentativeState	;
	string	RepresentativeZip	;
	string	RepresentativeSSN	;
	string	RepresentativeDOB	;
	string	RepresentativeHomePhone	;
	string	RepresentativeWorkPhone	;
	string	RepresentativeDLNumber	;
	string	RepresentativeDLState	;
	string	RepresentativeEmailAddress	;
	integer	HistoryDateYYYYMM;
end;


f := dataset('~tfuerstenberg::in::jpmc-biid-bf-082707', Layout, csv(QUOTE('"')));
//f := choosen(dataset('~tfuerstenberg::in::jpmc-biid-bf-082707', Layout, csv(QUOTE('"'))),5);
output(f);


roxieIP :='http://prdrroxiethorvip.hpcc.risk.regn.net:9876';  // DR roxie

Layout_BIID_Soapcall := record
	string	AccountNumber;
	string	BDID;
	string	CompanyName;
	string	AlternateCompanyName;
	string	Addr;
	string	City;
	string	State;
	string	Zip;
	string	BusinessPhone;
	string	TaxIdNumber;
	string	BusinessIPAddress;
	string	RepresentativeFirstName;
	string	RepresentativeMiddleName;
	string	RepresentativeLastName;
	string	RepresentativeNameSuffix;
	string	RepresentativeAddr;
	string	RepresentativeCity;
	string	RepresentativeState;
	string	RepresentativeZip;
	string	RepresentativeSSN;
	string	RepresentativeDOB;
	string	RepresentativeAge;
	string	RepresentativeDLNumber;
	string	RepresentativeDLState;
	string	RepresentativeHomePhone;
	string	RepresentativeEmailAddress;
	string 	RepresentativeFormerLastName;
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	dataset(Models.Layout_Score_Chooser) scores;
end;

Layout_BIID_Soapcall into_bus_input(f le) := transform
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.scores := dataset([{'Models.BusinessAdvisor_Service',roxieIP,[]}],models.Layout_Score_Chooser);
	self := le;
	self := [];
end;

indata := project(f,into_bus_input(LEFT));
output(indata, named('biid_in'));

errx := record
	string errorcode := '';
	business_risk.Layout_Final_Denorm;
	DATASET(Models.Layout_Model) models;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.company_name := L.companyname;
	self.addr1 := L.addr;
	self.p_city_name := L.city;
	self.st := L.state;
	self.z5 := L.zip;
	self.phone10 := L.businessphone;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'Business_Risk.InstantID_Service', {indata},
				dataset(errx), 
				PARALLEL(30), onfail(err_out(LEFT)));


output(results, named('biid_results'));
output(results(errorcode!=''), named('biid_errors'));

business_risk.layout_final_Batch final_tf(results L) := transform
	SELF.Acctno := L.account;
	self.fd_score1:=(string)(integer)L.Models[1].scores[1].i;
	self.fd_score2:=(string)(integer)L.Models[1].scores[2].i;
	self.fd_score3:=(string)(integer)L.Models[1].scores[3].i;
	self.fd_Reason1:=L.Models[1].scores[1].reason_codes[1].reason_code;
	self.fd_Desc1 := L.Models[1].scores[1].reason_codes[1].Reason_Description;
	self.fd_Reason2:=L.Models[1].scores[1].reason_codes[2].reason_code;
	self.fd_Desc2  :=L.Models[1].scores[1].reason_codes[2].Reason_Description;
	self.fd_Reason3:=L.Models[1].scores[1].reason_codes[3].reason_code;
	self.fd_Desc3  :=L.Models[1].scores[1].reason_codes[3].Reason_Description;
	self.fd_Reason4:=L.Models[1].scores[1].reason_codes[4].reason_code;
	self.fd_Desc4  :=L.Models[1].scores[1].reason_codes[4].Reason_Description;
	self:=L;
    self:=[];
end;

j_f := project(results,final_tf(LEFT));
output(j_f,named('output'));
output(j_f,,'~tfuerstenberg::out::jpmc-biid-bd-082707_out',csv(quote('"')), overwrite);
