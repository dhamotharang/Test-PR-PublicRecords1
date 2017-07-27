import Gateway;

export Attus_Soapcall_Function(dataset(layout_attus_in) inf, dataset(Gateway.Layouts.Config) gateway_cfg) := function

gateway_URL := gateway_cfg(servicename='attus')[1].url;
	
attus.layout_attus_out errX() := transform
	self.ErrorCode := FAILCODE;
	self.ErrorMessage := FailMESSAGE;
	self := [];
end;

Attus.Layout_Query_Items strip_spaces_from_queryitem(Attus.Layout_Query_Items L) := transform
    self.Operator := trim(L.operator);
	self.Country := trim(L.country);
	self.BlockedCountry := trim(L.blockedcountry);
	self.OtherName := trim(L.othername);
	self.AllEntities := trim(L.allentities);
	self.EntityId := trim(L.entityid);
	self.name.Fullname := trim (L.name.fullname);
	self.name.lname := trim (L.name.lname);
	self.name.fname := trim (L.name.fname);
	self.name.mname := trim (L.name.mname);
	self.name.suffix := trim (L.name.suffix);
	self.name.prefix := trim (L.name.prefix);
	self.Address.StreetNumber := trim (L.Address.StreetNumber);
	self.Address.StreetPreDirection := trim (L.Address.StreetPreDirection);
	self.Address.StreetName := trim (L.Address.StreetName);
	self.Address.StreetSuffix := trim (L.Address.StreetSuffix);
	self.Address.StreetPostDirection := trim (L.Address.StreetPostDirection);
	self.Address.UnitDesignation := trim (L.Address.UnitDesignation);
	self.Address.UnitNumber := trim (L.Address.UnitNumber);
	self.Address.City := trim (L.Address.City);
	self.Address.state := trim (L.Address.state);
	self.Address.zip5 := trim (L.Address.zip5);
	self.Address.zip4 := trim (L.Address.zip4);
	self.Address.County := trim (L.Address.County);
	self.Address.StreetAddress1 := trim (L.Address.StreetAddress1);
	self.Address.StreetAddress2 := trim (L.Address.StreetAddress2);
	self.Address.StateCityZip := trim (L.Address.StateCityZip);
	self.Address.PostalCode := trim (L.Address.PostalCode);
	self := L;		
end;

attus.Layout_Attus_In strip_spaces(attus.layout_attus_in L) := transform
	self.user.ReferenceCode := trim(L.user.referenceCode);
	self.user.BillingCode := trim(L.user.billingcode);
	self.user.QueryId := trim(L.user.queryID);
	self.options.CheckLists := trim(L.options.checklists);
	self.options.blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	self.searchby.queryitems := PROJECT(L.searchby.queryitems, strip_spaces_from_queryitem(LEFT));
	self := L;		
end;

stripped_spaces := project(inf, strip_spaces(left));

outf := if (gateway_url != '', soapcall(stripped_spaces,gateway_URL,'Watchdog',
				{stripped_spaces},
				dataset(attus.Layout_Attus_out),onfail(errX()),
				XPATH('WatchdogResponseEx/response'), timeout(4)));

return outf;

end;
