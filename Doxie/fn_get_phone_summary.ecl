import risk_indicators,business_risk,doxie_crs,iesp,address;
export fn_get_phone_summary(dataset(business_risk.Layout_Output) biidrec) := function
	// Transform to output layout
	iesp.phonesummary.t_PhoneSummaryRecord tra(business_risk.Layout_Output l) := transform

		self.CompanyName := l.phoneMatchCompany;
		clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(l.phoneMatchAddr,l.phoneMatchCity,l.phoneMatchState,l.phoneMatchZip);
		self.Address.StreetName := Address.CleanFields(clean_bus_addr).prim_name;
		self.Address.StreetNumber := Address.CleanFields(clean_bus_addr).prim_range;
		self.Address.StreetPreDirection := Address.CleanFields(clean_bus_addr).predir;
		self.Address.StreetPostDirection := Address.CleanFields(clean_bus_addr).postdir;
		self.Address.StreetSuffix := Address.CleanFields(clean_bus_addr).addr_suffix;
		self.Address.UnitDesignation := Address.CleanFields(clean_bus_addr).unit_desig;
		self.Address.UnitNumber := Address.CleanFields(clean_bus_addr).sec_range;
		self.Address.City := Address.CleanFields(clean_bus_addr).v_city_name;
		self.Address.State := Address.CleanFields(clean_bus_addr).st;
		self.Address.Zip5 := Address.CleanFields(clean_bus_addr).zip;
		self.Address.Zip4 := Address.CleanFields(clean_bus_addr).zip4;
		self.Address.County := '';
		self.Address.PostalCode := '';
		self.Address.StateCityZip := '';
		self.Address.StreetAddress1 := '';
		self.Address.StreetAddress2 := '';
	end;
	verr := project(biidrec, tra(left));
	return verr;
end;
