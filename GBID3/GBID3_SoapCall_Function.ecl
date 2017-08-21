export GBID3_SoapCall_Function(dataset(Layout_GBID3_In) Inf, string gateway_URL, integer timeout=10, integer retries=0) := FUNCTION


Layout_GBID3_Out errX(Layout_GBID3_In le) := transform
	self.Response.Header.ErrorMessage := FAILMESSAGE;
	self.Response.Header.ErrorCode := FAILCODE;
	self.Response.header.queryid := le.user.queryid;
	self := [];
end;


// trim all input strings
Layout_GBID3_In into_in(inf L) := transform
	self.user.referenceCode := trim(L.user.referenceCode);
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.queryId := trim(L.user.QueryId);
	self.user.GLBPurpose := trim(L.user.GLBPurpose);
	self.user.DLPurpose := trim(L.user.DLPurpose);
	// self.user.enduser := ??
	// self.user.MaxWaitSeconds := L.user.MaxWaitSeconds;
	
	self.searchby.RequestDetails.Profile := trim(L.searchby.RequestDetails.Profile);
	self.searchby.RequestDetails.SuccessCriteria := trim(L.searchby.RequestDetails.SuccessCriteria);
	
	self.searchby.Person.Title := trim(L.searchby.Person.Title);
	self.searchby.Person.FirstName := trim(L.searchby.Person.FirstName);
	self.searchby.Person.MiddleName := trim(L.searchby.Person.MiddleName);
	self.searchby.Person.LastName := trim(L.searchby.Person.LastName);
	self.searchby.Person.Gender := trim(L.searchby.Person.Gender);
	self.searchby.Person.DOB.Year := L.searchby.Person.DOB.Year;
	self.searchby.Person.DOB.Month := L.searchby.Person.DOB.Month;
	self.searchby.Person.DOB.Day := L.searchby.Person.DOB.Day;
	self.searchby.Person.MothersMaidenName := trim(L.searchby.Person.MothersMaidenName);
	
	self.searchby.Addresses.Address1.AddressLayout := trim(L.searchby.Addresses.Address1.AddressLayout);
	self.searchby.Addresses.Address1.FFAddress1 := trim(L.searchby.Addresses.Address1.FFAddress1);
	self.searchby.Addresses.Address1.FFAddress2 := trim(L.searchby.Addresses.Address1.FFAddress2);
	self.searchby.Addresses.Address1.FFAddress3 := trim(L.searchby.Addresses.Address1.FFAddress3);
	self.searchby.Addresses.Address1.FFAddress4 := trim(L.searchby.Addresses.Address1.FFAddress4);
	self.searchby.Addresses.Address1.POBox := trim(L.searchby.Addresses.Address1.POBox);
	self.searchby.Addresses.Address1.BuildingNumber := trim(L.searchby.Addresses.Address1.BuildingNumber);
	self.searchby.Addresses.Address1.SubBuildingNumber := trim(L.searchby.Addresses.Address1.SubBuildingNumber);
	self.searchby.Addresses.Address1.Company := trim(L.searchby.Addresses.Address1.Company);
	self.searchby.Addresses.Address1.Department := trim(L.searchby.Addresses.Address1.Department);
	self.searchby.Addresses.Address1.Premise := trim(L.searchby.Addresses.Address1.Premise);
	self.searchby.Addresses.Address1.SubStreet := trim(L.searchby.Addresses.Address1.SubStreet);
	self.searchby.Addresses.Address1.Street := trim(L.searchby.Addresses.Address1.Street);
	self.searchby.Addresses.Address1.SubCity := trim(L.searchby.Addresses.Address1.SubCity);
	self.searchby.Addresses.Address1.CityTown := trim(L.searchby.Addresses.Address1.CityTown);
	self.searchby.Addresses.Address1.StateDistrict := trim(L.searchby.Addresses.Address1.StateDistrict);
	self.searchby.Addresses.Address1.Region := trim(L.searchby.Addresses.Address1.Region);
	self.searchby.Addresses.Address1.Principality := trim(L.searchby.Addresses.Address1.Principality);
	self.searchby.Addresses.Address1.Cedex := trim(L.searchby.Addresses.Address1.Cedex);
	self.searchby.Addresses.Address1.Country := trim(L.searchby.Addresses.Address1.Country);
	self.searchby.Addresses.Address1.ZipPCode := trim(L.searchby.Addresses.Address1.ZipPCode);
	self.searchby.Addresses.Address1.StartDate.Year := L.searchby.Addresses.Address1.StartDate.Year;
	self.searchby.Addresses.Address1.StartDate.Month := L.searchby.Addresses.Address1.StartDate.Month;
	self.searchby.Addresses.Address1.StartDate.Day := L.searchby.Addresses.Address1.StartDate.Day;
	self.searchby.Addresses.Address1.EndDate.Year := L.searchby.Addresses.Address1.EndDate.Year;
	self.searchby.Addresses.Address1.EndDate.Month := L.searchby.Addresses.Address1.EndDate.Month;
	self.searchby.Addresses.Address1.EndDate.Day := L.searchby.Addresses.Address1.EndDate.Day;
	
	self.searchby.Addresses.Address2.AddressLayout := trim(L.searchby.Addresses.Address2.AddressLayout);
	self.searchby.Addresses.Address2.FFAddress1 := trim(L.searchby.Addresses.Address2.FFAddress1);
	self.searchby.Addresses.Address2.FFAddress2 := trim(L.searchby.Addresses.Address2.FFAddress2);
	self.searchby.Addresses.Address2.FFAddress3 := trim(L.searchby.Addresses.Address2.FFAddress3);
	self.searchby.Addresses.Address2.FFAddress4 := trim(L.searchby.Addresses.Address2.FFAddress4);
	self.searchby.Addresses.Address2.POBox := trim(L.searchby.Addresses.Address2.POBox);
	self.searchby.Addresses.Address2.BuildingNumber := trim(L.searchby.Addresses.Address2.BuildingNumber);
	self.searchby.Addresses.Address2.SubBuildingNumber := trim(L.searchby.Addresses.Address2.SubBuildingNumber);
	self.searchby.Addresses.Address2.Company := trim(L.searchby.Addresses.Address2.Company);
	self.searchby.Addresses.Address2.Department := trim(L.searchby.Addresses.Address2.Department);
	self.searchby.Addresses.Address2.Premise := trim(L.searchby.Addresses.Address2.Premise);
	self.searchby.Addresses.Address2.SubStreet := trim(L.searchby.Addresses.Address2.SubStreet);
	self.searchby.Addresses.Address2.Street := trim(L.searchby.Addresses.Address2.Street);
	self.searchby.Addresses.Address2.SubCity := trim(L.searchby.Addresses.Address2.SubCity);
	self.searchby.Addresses.Address2.CityTown := trim(L.searchby.Addresses.Address2.CityTown);
	self.searchby.Addresses.Address2.StateDistrict := trim(L.searchby.Addresses.Address2.StateDistrict);
	self.searchby.Addresses.Address2.Region := trim(L.searchby.Addresses.Address2.Region);
	self.searchby.Addresses.Address2.Principality := trim(L.searchby.Addresses.Address2.Principality);
	self.searchby.Addresses.Address2.Cedex := trim(L.searchby.Addresses.Address2.Cedex);
	self.searchby.Addresses.Address2.Country := trim(L.searchby.Addresses.Address2.Country);
	self.searchby.Addresses.Address2.ZipPCode := trim(L.searchby.Addresses.Address2.ZipPCode);
	self.searchby.Addresses.Address2.StartDate.Year := L.searchby.Addresses.Address2.StartDate.Year;
	self.searchby.Addresses.Address2.StartDate.Month := L.searchby.Addresses.Address2.StartDate.Month;
	self.searchby.Addresses.Address2.StartDate.Day := L.searchby.Addresses.Address2.StartDate.Day;
	self.searchby.Addresses.Address2.EndDate.Year := L.searchby.Addresses.Address2.EndDate.Year;
	self.searchby.Addresses.Address2.EndDate.Month := L.searchby.Addresses.Address2.EndDate.Month;
	self.searchby.Addresses.Address2.EndDate.Day := L.searchby.Addresses.Address2.EndDate.Day;
	
	self.searchby.Addresses.Address3.AddressLayout := trim(L.searchby.Addresses.Address3.AddressLayout);
	self.searchby.Addresses.Address3.FFAddress1 := trim(L.searchby.Addresses.Address3.FFAddress1);
	self.searchby.Addresses.Address3.FFAddress2 := trim(L.searchby.Addresses.Address3.FFAddress2);
	self.searchby.Addresses.Address3.FFAddress3 := trim(L.searchby.Addresses.Address3.FFAddress3);
	self.searchby.Addresses.Address3.FFAddress4 := trim(L.searchby.Addresses.Address3.FFAddress4);
	self.searchby.Addresses.Address3.POBox := trim(L.searchby.Addresses.Address3.POBox);
	self.searchby.Addresses.Address3.BuildingNumber := trim(L.searchby.Addresses.Address3.BuildingNumber);
	self.searchby.Addresses.Address3.SubBuildingNumber := trim(L.searchby.Addresses.Address3.SubBuildingNumber);
	self.searchby.Addresses.Address3.Company := trim(L.searchby.Addresses.Address3.Company);
	self.searchby.Addresses.Address3.Department := trim(L.searchby.Addresses.Address3.Department);
	self.searchby.Addresses.Address3.Premise := trim(L.searchby.Addresses.Address3.Premise);
	self.searchby.Addresses.Address3.SubStreet := trim(L.searchby.Addresses.Address3.SubStreet);
	self.searchby.Addresses.Address3.Street := trim(L.searchby.Addresses.Address3.Street);
	self.searchby.Addresses.Address3.SubCity := trim(L.searchby.Addresses.Address3.SubCity);
	self.searchby.Addresses.Address3.CityTown := trim(L.searchby.Addresses.Address3.CityTown);
	self.searchby.Addresses.Address3.StateDistrict := trim(L.searchby.Addresses.Address3.StateDistrict);
	self.searchby.Addresses.Address3.Region := trim(L.searchby.Addresses.Address3.Region);
	self.searchby.Addresses.Address3.Principality := trim(L.searchby.Addresses.Address3.Principality);
	self.searchby.Addresses.Address3.Cedex := trim(L.searchby.Addresses.Address3.Cedex);
	self.searchby.Addresses.Address3.Country := trim(L.searchby.Addresses.Address3.Country);
	self.searchby.Addresses.Address3.ZipPCode := trim(L.searchby.Addresses.Address3.ZipPCode);
	self.searchby.Addresses.Address3.StartDate.Year := L.searchby.Addresses.Address3.StartDate.Year;
	self.searchby.Addresses.Address3.StartDate.Month := L.searchby.Addresses.Address3.StartDate.Month;
	self.searchby.Addresses.Address3.StartDate.Day := L.searchby.Addresses.Address3.StartDate.Day;
	self.searchby.Addresses.Address3.EndDate.Year := L.searchby.Addresses.Address3.EndDate.Year;
	self.searchby.Addresses.Address3.EndDate.Month := L.searchby.Addresses.Address3.EndDate.Month;
	self.searchby.Addresses.Address3.EndDate.Day := L.searchby.Addresses.Address3.EndDate.Day;
	
	self.searchby.Telephones.HomeTelephone.Number := trim(L.searchby.Telephones.HomeTelephone.Number);
	self.searchby.Telephones.HomeTelephone.Published := L.searchby.Telephones.HomeTelephone.Published;
	self.searchby.Telephones.WorkTelephone.Number := trim(L.searchby.Telephones.WorkTelephone.Number);
	self.searchby.Telephones.WorkTelephone.Published := L.searchby.Telephones.WorkTelephone.Published;
	self.searchby.Telephones.MobileTelephone.Number := trim(L.searchby.Telephones.MobileTelephone.Number);
	self.searchby.Telephones.MobileTelephone.Published := L.searchby.Telephones.MobileTelephone.Published;
	
	self.searchby.USDrivingLicense.Number := trim(L.searchby.USDrivingLicense.Number);
	self.searchby.USDrivingLicense.State := trim(L.searchby.USDrivingLicense.State);
	
	self.searchby.Passport.ExpiryDate.Year := L.searchby.Passport.ExpiryDate.Year;
	self.searchby.Passport.ExpiryDate.Month := L.searchby.Passport.ExpiryDate.Month;
	self.searchby.Passport.ExpiryDate.Day := L.searchby.Passport.ExpiryDate.Day;
	self.searchby.Passport.Number := trim(L.searchby.Passport.Number);
	self.searchby.Passport.CountryOfOrigin := trim(L.searchby.Passport.CountryOfOrigin);
	
	self.searchby.Identity.Type := trim(L.searchby.Identity.Type);
	self.searchby.Identity.Number := trim(L.searchby.Identity.Number);
	self.searchby.Identity.Location := trim(L.searchby.Identity.Location);
	self.searchby.Identity.QuovaIP := trim(L.searchby.Identity.QuovaIP);
	self.searchby.Identity.QuovaCountry := trim(L.searchby.Identity.QuovaCountry);
	self.searchby.Identity.QuovaUSState := trim(L.searchby.Identity.QuovaUSState);
	self.searchby.Identity.QuovaCCard := trim(L.searchby.Identity.QuovaCCard);
	self.searchby.Identity.IDCountry := trim(L.searchby.Identity.IDCountry);
	self.searchby.Identity.IDCardNumber := trim(L.searchby.Identity.IDCardNumber);

	self := [];
end;
outf := if (gateway_URL != '', soapcall(inf, gateway_URL, 'GbID3Check',
																				Layout_GBID3_In, into_in(LEFT),  
																				dataset(Layout_GBID3_Out),
																				XPATH('GbID3CheckResponseEx'),
																				ONFAIL(errX(left)), timeout(timeout), retry(retries)));	// what timeout should be used
																				

return outf;

end;