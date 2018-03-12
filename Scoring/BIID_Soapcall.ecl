import business_risk, models;

export BIID_Soapcall(dataset(layout_biid_soapcall) indata, string roxieIP='http://roxiestaging.br.seisint.com:9876') := function
	
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
				'business_risk.instantId_service', {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;
