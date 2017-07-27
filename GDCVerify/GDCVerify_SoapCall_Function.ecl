export GDCVerify_SoapCall_Function(dataset(Layout_GDCVerify_In) Inf, string gateway_URL, integer timeout=10, integer retries=0) := FUNCTION

Layout_GDCVerify_Out errX(Layout_GDCVerify_In le) := transform
	self.Response.Header.ErrorMessage := FAILMESSAGE;
	self.Response.Header.ErrorCode := FAILCODE;
	self.Response.header.queryid := le.user.queryid;
	self := [];
end;

// trim all input strings
Layout_GDCVerify_In into_in(inf L) := transform
	self.user.ReferenceCode := trim(L.user.ReferenceCode);
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.QueryId := trim(L.user.QueryId);
	self.user.GLBPurpose := trim(L.user.GLBPurpose);
	self.user.DLPurpose := trim(L.user.DLPurpose);
	
	self.searchoptions.SubAccount := trim(L.searchoptions.SubAccount);
	self.searchoptions.CreditFlag := trim(L.searchoptions.CreditFlag);

	self.searchby.Person.FirstName := trim(L.searchby.Person.FirstName);
	self.searchby.Person.MiddleName := trim(L.searchby.Person.MiddleName);
	self.searchby.Person.LastName := trim(L.searchby.Person.LastName);

	self.searchby.Address.FullStreet := trim(L.searchby.Address.FullStreet);
	self.searchby.Address.StreetName := trim(L.searchby.Address.StreetName);
	self.searchby.Address.StreetType := trim(L.searchby.Address.StreetType);
	self.searchby.Address.BuildingNumber := trim(L.searchby.Address.BuildingNumber);
	self.searchby.Address.SubBuildingNumber := trim(L.searchby.Address.SubBuildingNumber);
	self.searchby.Address.CityTown := trim(L.searchby.Address.CityTown);
	self.searchby.Address.StateDistrict := trim(L.searchby.Address.StateDistrict);
	self.searchby.Address.PostalCode := trim(L.searchby.Address.PostalCode);
	self.searchby.Address.Country := trim(L.searchby.Address.Country);
	self.searchby.Address.CountryCode := trim(L.searchby.Address.CountryCode);
	self.searchby.Address.County := trim(L.searchby.Address.County);

	self.searchby.PhoneNumber := trim(L.searchby.PhoneNumber);
	self.searchby.IdNumber := trim(L.searchby.IdNumber);

	self := L;
	self := [];
end;
outf := if (gateway_URL != '', soapcall(inf, gateway_URL, 'GDCVerifyCheck',
																				Layout_GDCVerify_In, into_in(LEFT),  
																				dataset(Layout_GDCVerify_Out),
																				XPATH('GDCVerifyCheckResponseEx'),
																				ONFAIL(errX(left)), timeout(timeout), retry(retries)));	// what timeout should be used
																				

return outf;

end;