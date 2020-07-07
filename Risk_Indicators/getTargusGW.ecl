import targus, riskwise, gateway,Phones, std, Risk_Indicators;

export getTargusGW(DATASET(Risk_Indicators.Layout_Input) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 dppa, unsigned1 glb,
									boolean isFCRA = false) := function

applyOptOut := ~isFCRA; // Temporary variable to enable Targus opt out
// targus and targuse3220 should have the same url
targus_gateway_cfg := gateways(servicename='targus' or servicename='targuse3220')[1];
makeGatewayCall := targus_gateway_cfg.url!='';


targus.layout_targus_in prep_for_Targus(indata le) := transform
	self.user.GLBPurpose := glb;
	self.user.DLPurpose := dppa;
	self.user.QueryID := (string)le.seq;
	self.searchby.ConsumerName.Fname := le.fname;
	self.searchby.ConsumerName.Lname := le.lname;
	self.searchby.PhoneNumber := le.phone10;
	// decide which search we want to perform (PDE or E3220)
	self.options.IncludePhoneDataExpressSearch := ~trim(le.lname_prev)='E3220';	// this field is set in Risk_Indicators.iid_getPhoneInfo
	self.options.IncludeNameVerificationSearch := trim(le.lname_prev)='E3220' and trim(le.fname)<>'' and trim(le.lname)<>'';	// this field is set in Risk_Indicators.iid_getPhoneInfo
	self := [];
end;

targus_in := project(indata, prep_for_Targus(left));

timeout := 2;	// 2 seconds
retries := 0;	// don't retry because of SLA's
gw_mod_access := Gateway.IParam.GetGatewayModAccess(glb, dppa);

// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie 
// ever decides to execute both sides of the IF statement.
gateway_result := if(makeGatewayCall, 
													Gateway.SoapCall_Targus(targus_in, targus_gateway_cfg, timeout, retries, makeGatewayCall, gw_mod_access, applyOptOut),
													dataset([],targus.layout_targus_out));

riskwise.Layout_Dirs_Phone tran(indata le, gateway_result rt) := transform
	hitPDE := trim(rt.response.PhoneDataExpressSearchResult.StatusCode)='Success' and
								(	trim(rt.response.PhonedataExpressSearchResult.StreetName)<>'' or
									trim(rt.response.PhonedataExpressSearchResult.LastName)<>'' or
									trim(rt.response.PhonedataExpressSearchResult.BusinessName)<>''  );
	hitE3220Both := rt.response.NameVerificationSearchResult.ErrorCode=0 and
									trim(rt.response.NameVerificationSearchResult.MatchedName)='C';	// phone and last name match
	hitE3220Phone := rt.response.NameVerificationSearchResult.ErrorCode=0 and
									 trim(rt.response.NameVerificationSearchResult.NameType) in ['B','C'];	// phone matches at least

	history_mode := le.historydate<>risk_indicators.iid_constants.default_history_date and le.historydate<>0;
	history_date := risk_indicators.iid_constants.MonthRollback((STRING6)le.historydate, 1); // last/first seen is history date minus 1 month so it won't be filtered
	effective_date := if(history_mode, (STRING6)history_date+'01', (STRING8)Std.Date.Today());
	
	self.targusgatewayused := if(rt.response.header.queryid!='',true, skip);
	self.targustype := if(hitPDE,Phones.Constants.TargusType.PhoneDataExpress, Phones.Constants.TargusType.NameVerification); 
	self.phone10 := if(hitPDE or hitE3220Phone, le.phone10, '');
	self.area_code := if(hitPDE or hitE3220Phone, le.phone10[1..3], '');
	self.phone7 := if(hitPDE or hitE3220Phone, le.phone10[4..10], '');
	self.p3 := if(hitPDE or hitE3220Phone, le.phone10[1..3], '');
	self.p7 := if(hitPDE or hitE3220Phone, le.phone10[4..10], '');
	self.dt_first_seen := if(hitPDE or hitE3220Phone, effective_date, '');
	self.dt_last_seen := if(hitPDE or hitE3220Phone, effective_date, '');
	self.current_record_flag := if(hitPDE or hitE3220Phone, 'Y', '');
	self.current_flag := if(hitPDE or hitE3220Phone, true, false);
	self.business_flag := if((hitPDE and rt.response.PhonedataExpressSearchResult.NameType='Business') OR
													 (hitE3220Phone and rt.response.NameVerificationSearchResult.NameType='B'), true, false);
	self.listing_type_res := map(hitPDE => if(rt.response.PhonedataExpressSearchResult.NameType='Business', 'B','R'),
															 hitE3220Phone => if(trim(rt.response.NameVerificationSearchResult.NameType)='B', 'B', if(trim(rt.response.NameVerificationSearchResult.NameType)='C', 'R', '')),
															 '');
	self.listed_name := if(hitPDE, if(rt.response.PhonedataExpressSearchResult.NameType='Business', STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.BusinessName),''), '');
	self.name_first := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.FirstName), '');
	self.name_middle := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.MiddleName), '');
	self.name_last := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.LastName), if(hitE3220Both, le.lname, ''));
	self.prim_range := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.PrimaryAddressNumber), '');
	self.predir := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetPreDirection), '');
	self.prim_name := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetName), '');
	self.suffix := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetNameSuffix), '');
	self.postdir := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetnamePostDirection), '');
	self.unit_desig := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.SecondaryAddressType), '');
	self.sec_range := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.SecondaryAddressNumber), '');
	self.p_city_name := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.PostOfficeCityName), '');
	self.st := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.State), '');
	self.z5 := if(hitPDE, rt.response.PhonedataExpressSearchResult.ZipCode, '');
	self.z4 := if(hitPDE, rt.response.PhonedataExpressSearchResult.ZipPlus4, '');
	self.src := 'TG';
	self := [];
end;

dirs := join(indata, gateway_result, left.phone10!='' and left.phone10=right.searchby.phonenumber, tran(left, right));

return dirs;

end;