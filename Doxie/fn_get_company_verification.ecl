import business_risk,doxie_crs,Risk_Indicators,iesp,address;
export fn_get_company_verification(dataset(business_risk.Layout_Output) biidrec) := function
	// Transform to output layout
	iesp.share.t_CompanyVerification tra(business_risk.Layout_Output l) := transform
		self.VerifiedIndicators.CompanyName := if(l.CnameMatchflag='Y', true, false);
		self.VerifiedIndicators.Address := if(l.AddrMatchFlag='Y', true, false);
		self.VerifiedIndicators.City := if(l.CityMatchFlag='Y', true, false);
		self.VerifiedIndicators.State := if(l.StateMatchFlag='Y', true, false);
		self.VerifiedIndicators.Zip := if(l.ZipMatchFlag='Y', true, false);
		self.VerifiedIndicators.Phone10 := if(l.PhoneMatchFlag='Y', true, false);
		self.VerifiedIndicators._Fein := if(l.FeinMatchFlag='Y', true, false);

		self.VerifiedInputs.CompanyName := l.vercmpy;
		clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(l.veraddr,l.vercity,l.verstate,l.verzip);
		self.VerifiedInputs.Address.StreetName := Address.CleanFields(clean_bus_addr).prim_name;
		self.VerifiedInputs.Address.StreetNumber := Address.CleanFields(clean_bus_addr).prim_range;
		self.VerifiedInputs.Address.StreetPreDirection := Address.CleanFields(clean_bus_addr).predir;
		self.VerifiedInputs.Address.StreetPostDirection := Address.CleanFields(clean_bus_addr).postdir;
		self.VerifiedInputs.Address.StreetSuffix := Address.CleanFields(clean_bus_addr).addr_suffix;
		self.VerifiedInputs.Address.UnitDesignation := Address.CleanFields(clean_bus_addr).unit_desig;
		self.VerifiedInputs.Address.UnitNumber := Address.CleanFields(clean_bus_addr).sec_range;
		self.VerifiedInputs.Address.City := Address.CleanFields(clean_bus_addr).v_city_name;
		self.VerifiedInputs.Address.State := Address.CleanFields(clean_bus_addr).st;
		self.VerifiedInputs.Address.Zip5 := Address.CleanFields(clean_bus_addr).zip;
		self.VerifiedInputs.Address.Zip4 := Address.CleanFields(clean_bus_addr).zip4;
		self.VerifiedInputs.Address.County := '';
		self.VerifiedInputs.Address.PostalCode := '';
		self.VerifiedInputs.Address.StateCityZip := '';
		self.VerifiedInputs.Address.StreetAddress1 := '';
		self.VerifiedInputs.Address.StreetAddress2 := '';
		self.VerifiedInputs.Phone10 := l.verphone;
		self.VerifiedInputs._Fein := l.verfein;
	end;
	verr := project(biidrec, tra(left));
	return verr;
end;
