import iesp, gateway, riskwise, gateway;

export getInsurancePhoneGW(DATASET(Layout_Input) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned lastSeenThreshold, string20 companyID,
														string10 ExactMatchLevel, boolean isFCRA) := function

insurance_gateway_cfg := gateways(Gateway.Configuration.IsInsurancePhoneHeader(servicename))[1];

glb_ok := iid_constants.glb_ok(glb, isFCRA);


ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;


iesp.phoneheaderscore.t_PhoneHeaderScoreRequest prepInsurancePhone(indata le) := transform
	self.seq := (STRING)le.seq;
	self.user.GLBPurpose := (string)glb;
	self.user.CompanyID := companyID;
	self.user.QueryID := (STRING)le.seq;
	
	self.searchby.Name.First := le.fname;
	self.searchby.Name.Last := le.lname;
	self.searchby.address.streetaddress1 := le.in_streetAddress;	// pass the original input rather than the clean input??
	self.searchby.address.city := le.in_city;
	self.searchby.address.state := le.in_state;
	self.searchby.address.zip5 := le.in_zipcode;
	// self.searchby.address.streetnumber := le.prim_range;
	// self.searchby.address.streetpredirection := le.predir;
	// self.searchby.address.streetname := le.prim_name;
	// self.searchby.address.streetsuffix := le.addr_suffix;
	// self.searchby.address.streetpostdirection := le.postdir;
	// self.searchby.address.unitdesignation := le.unit_desig;
	// self.searchby.address.unitnumber := le.sec_range;
	// self.searchby.address.city := le.p_city_name;
	// self.searchby.address.state := le.st;
	// self.searchby.address.zip5 := le.z5;
	self.searchby.HomePhone := le.phone10;
	
	self.options.HistoryDateYYYYMM := (string)le.historydate;
	self.options.LastSeenThreshold := (string)lastSeenThreshold;
	self.options.RequireExactMatch.lastname := ExactLastNameRequired;
	self.options.RequireExactMatch.firstname := ExactFirstNameRequired;
	self.options.RequireExactMatch.firstnameallownickname := ExactFirstNameRequiredAllowNickname;
	self := [];
end;
insurancePhoneIn := project(indata, prepInsurancePhone(left));

timeout := 2;	// 2 seconds
retries := 0;	// don't retry because of SLA's

// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie 
// ever decides to execute both sides of the IF statement.
makeGatewayCall := glb_ok; // only call the gateway if glb is ok.
gateway_result := if(makeGatewayCall, 	
													Gateway.SoapCall_InsuranceNAP(insurancePhoneIn, insurance_gateway_cfg, timeout, retries, makeGatewayCall), 
													dataset([],iesp.phoneheaderscore.t_PhoneHeaderScoreResponseEx));

riskwise.Layout_Dirs_Phone tran(indata le, gateway_result rt) := transform
	verifiedFirst := rt.response.responseData.NameAddressPhone.summary in ['2','3','4','8','9','10','12'];
	verifiedLast := rt.response.responseData.NameAddressPhone.summary in ['2','5','7','8','9','11','12'];
	verifiedAddr := rt.response.responseData.NameAddressPhone.summary in ['3','5','6','8','10','11','12'];
	verifiedPhone := rt.response.responseData.NameAddressPhone.summary in ['1','4','6','7','9','10','11','12'];

	self.targusgatewayused := false;
	self.phone10 := if(verifiedPhone, le.phone10, '');
	self.area_code := if(verifiedPhone, le.phone10[1..3], '');
	self.phone7 := if(verifiedPhone, le.phone10[4..10], '');
	self.p3 := if(verifiedPhone, le.phone10[1..3], '');
	self.p7 := if(verifiedPhone, le.phone10[4..10], '');
	self.dt_first_seen := '';	// don't think we need these, our join checks to see if the current_flag is set
	self.dt_last_seen := '';
	self.current_record_flag := if(verifiedFirst or verifiedLast or verifiedAddr or verifiedPhone, 'Y', '');
	self.current_flag := if(verifiedFirst or verifiedLast or verifiedAddr or verifiedPhone, true, false);
	self.business_flag := false;
	self.listing_type_res := 'R';
	self.listed_name := '';
	self.name_first := if(verifiedFirst, le.fname, '');
	self.name_last := if(verifiedLast, le.lname, '');
	self.prim_range := if(verifiedAddr, le.prim_range, '');
	self.predir := if(verifiedAddr, le.predir, '');
	self.prim_name := if(verifiedAddr, le.prim_name, '');
	self.suffix := if(verifiedAddr, le.addr_suffix, '');
	self.postdir := if(verifiedAddr, le.postdir, '');
	self.unit_desig := if(verifiedAddr, le.unit_desig, '');
	self.sec_range := if(verifiedAddr, le.sec_range, '');
	self.p_city_name := if(verifiedAddr, le.p_city_name, '');
	self.st := if(verifiedAddr, le.st, '');
	self.z5 := if(verifiedAddr, le.z5, '');
	self.z4 := if(verifiedAddr, le.zip4, '');
	self.src := 'IP';
	self := [];
end;
dirs := join(indata, gateway_result, left.phone10!='' and left.seq=(unsigned)right.response._header.queryid, tran(left, right));

return dirs;

end;