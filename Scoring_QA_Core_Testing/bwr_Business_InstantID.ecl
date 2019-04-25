// #workunit('name','Business IID Process');
#option ('hthorMemoryLimit', 1000);

import models, riskwise, Business_Risk;

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

f := dataset('~scoringqa::in::amex_8051_bus_nov21_exphone::amex_8051_bus_nov21_in.csv', Layout, csv(QUOTE('"')));
// f := choosen(dataset('~scoringqa::in::amex_8051_bus_nov21_exphone::amex_8051_bus_nov21_in.csv', Layout, csv(QUOTE('"'))),5);
output(f);


// roxieIP :='http://roxiebatch.br.seisint.com:9856';  // roxiebatch
roxieIP :=riskwise.shortcuts.core_97_roxieIP; // CoreRoxie


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
	integer	HistoryDateYYYYMM;
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	dataset(Models.Layout_Score_Chooser) scores;
end;

Layout_BIID_Soapcall into_bus_input(f le) := transform
	self.dppapurpose := 3;
	self.glbpurpose := 1;
//	self.scores := dataset([{'Models.BusinessAdvisor_Service',roxieIP,[]}],models.Layout_Score_Chooser);
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
				PARALLEL(2), onfail(err_out(LEFT)));


output(results, named('biid_results'));
output(results,,'~scoringqa::out::biid_exphone_after',csv(heading(single), quote('"')), overwrite);
output(results(errorcode!=''), named('biid_errors'));