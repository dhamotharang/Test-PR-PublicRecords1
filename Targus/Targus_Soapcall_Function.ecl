export Targus_Soapcall_Function(dataset(targus.Layout_Targus_In) df, string gateway_URL, integer timeout=1, integer retries=1) := function

targus.layout_targus_out errX(targus.Layout_Targus_In le) := transform
	self.response.Header.ErrorMessage := FAILMESSAGE;
	self.response.Header.ErrorCode := FAILCODE;
	self.response.header.queryid := le.user.queryid;
	self.searchby.phonenumber := le.searchby.phonenumber;
	self.searchby.consumername.frst := le.searchby.consumername.Fname;
	self.searchby.consumername.lst := le.searchby.consumername.Lname;
	self := [];
end;

//'http://web_bps_roxie:[PASSWORD_REDACTED]@172.16.18.165:7996/WsGateway'

targus.layout_targus_in into_in(df L) := transform
	self.user.referenceCode := trim(L.user.referenceCode);
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.queryId := trim(L.user.QueryId);
	self.options.verifyexpressoptions.screenoptions := trim(L.options.verifyExpressOptions.screenOptions);
	self.searchby.consumername.FullName := trim(L.searchby.consumername.FullName);
	self.searchby.consumername.Fname := trim(L.searchby.consumername.Fname);
	self.searchby.consumername.Middle := trim(L.searchby.consumername.Middle);
	self.searchby.consumername.Lname := trim(L.searchby.consumername.Lname);
	self.searchby.consumername.Suffix := trim(L.searchby.consumername.Suffix);
	self.searchby.consumername.Prefix := trim(L.searchby.consumername.prefix);
	self.searchby.companyname := trim(L.searchby.companyname);
	self.searchby.UnknownName := trim(L.searchby.UnknownName);
	self.searchby.phonenumber := trim(L.searchby.phonenumber);
	self.searchby.address.streetName := trim(L.searchby.address.streetName);
	self.searchby.address.streetNumber := trim(L.searchby.address.streetNumber);
	self.searchby.address.streetPreDirection := trim(L.searchby.address.streetPreDirection);
	self.searchby.address.streetPostDirection := trim(L.searchby.address.streetPostDirection);
	self.searchby.address.StreetSuffix := trim(L.searchby.address.StreetSuffix);
	self.searchby.address.UnitDesignation := trim(L.searchby.address.UnitDesignation);
	self.searchby.address.UnitNumber := trim(L.searchby.address.UnitNumber);
	self.searchby.address.StreetAddress1 := trim(l.searchby.address.StreetAddress1);
	self.searchby.address.StreetAddress2 := trim(L.searchby.address.StreetAddress2);
	self.searchby.address.State := trim(L.searchby.address.State);
	self.searchby.address.City := trim(L.searchby.address.City);
	self.searchby.address.zip5 := trim(L.searchby.address.zip5);
	self.searchby.address.zip4 := trim(L.searchby.address.zip4);
	self.searchby.address.County := trim(L.searchby.address.County);
	self.searchby.address.PostalCode := trim(L.searchby.address.PostalCode);
	self.searchby.address.StateCityZip := trim(L.searchby.address.StateCityZip);
	self := L;
end;

outf := if (gateway_URL != '', soapcall(df,gateway_URL,'TargusComprehensive',
				targus.Layout_Targus_In, into_in(LEFT),  
				dataset(targus.Layout_Targus_Out),
				XPATH('TargusComprehensiveResponseEx'),
				ONFAIL(errX(left)), timeout(timeout), retry(retries)));


return outf;

end;
