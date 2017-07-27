import risk_indicators,business_risk,doxie_crs,iesp,address;
export fn_get_verification(dataset(business_risk.Layout_Output) biidrec, string30 fname, string50 lname) := function
	// Transform to output layout
	iesp.verification.t_IndividualVerificationRecord tra(business_risk.Layout_Output l) := transform
		self.VerifiedIndicators.Name := if(l.RepNameVerFlag='Y', true, false);
		RepFNameVerFlag	:= risk_indicators.iid_constants.g(risk_indicators.iid_constants.tscore(risk_indicators.fnamescore(l.RepFNameVerify, fname))) and fname != '';
		self.VerifiedIndicators.FirstName := RepFNameVerFlag;
		RepLNameVerFlag	:= risk_indicators.iid_constants.g(risk_indicators.iid_constants.tscore(risk_indicators.lnamescore(l.RepLNameVerify,  lname))) and lname != '';
		self.VerifiedIndicators.LastName := RepLNameVerFlag;
		self.VerifiedIndicators.SSN := if(l.RepSSNVerFlag='Y', true, false);
		self.VerifiedIndicators.Dob := if(l.RepDobVerFlag='Y', true, false);

		self.VerifiedIndicators.CompanyName := if(l.CnameMatchflag='Y', true, false);
		self.VerifiedIndicators.Address := if(l.AddrMatchFlag='Y', true, false);
		self.VerifiedIndicators.City := if(l.CityMatchFlag='Y', true, false);
		self.VerifiedIndicators.State := if(l.StateMatchFlag='Y', true, false);
		self.VerifiedIndicators.Zip := if(l.ZipMatchFlag='Y', true, false);
		self.VerifiedIndicators.Phone10 := if(l.PhoneMatchFlag='Y', true, false);

		self.VerifiedInputs.SSN := l.RepSSNVerify;
		self.VerifiedInputs.FirstName := l.RepFNameVerify;
		self.VerifiedInputs.LastName := l.RepLNameVerify;
		self.VerifiedInputs.Dob := iesp.ECL2ESP.toDatestring8(l.RepDOBVerify);
		self.VerifiedInputs.Name := iesp.ECL2ESP.SetName (L.RepFNameVerify, '', l.RepLNameVerify, '', '');

		self.VerifiedInputs.CompanyName := l.vercmpy;

		clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(l.veraddr,l.vercity,l.verstate,l.verzip);
    addr := Address.CleanFields(clean_bus_addr);
		self.VerifiedInputs.Address := iesp.ECL2ESP.SetAddress (
			addr.prim_name, addr.prim_range, addr.predir, addr.postdir, addr.addr_suffix, addr.unit_desig, addr.sec_range,
			addr.v_city_name, addr.st, addr.zip, addr.zip4, '');

		self.VerifiedInputs.Phone10 := l.verphone;
	end;
	verr := project(biidrec, tra(left));
	return verr;
end;
