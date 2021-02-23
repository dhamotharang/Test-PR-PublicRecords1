IMPORT targus, riskwise, Gateway, Phones, std, Risk_Indicators;

EXPORT TargusFunctions := MODULE

EXPORT TargusMAS(STRING InputFirstName, STRING InputLastName, STRING InputPhone10, UNSIGNED1 DPPA, UNSIGNED1 GLB,
									BOOLEAN isFCRA = FALSE, dataset(Gateway.Layouts.Config) Gateways = dataset([], Gateway.Layouts.Config)) := FUNCTION

indata := DATASET([TRANSFORM(Risk_Indicators.Layout_Input,
SELF.fname := InputFirstName;
SELF.lname := InputLastName;
SELF.phone10 := InputPhone10;
SELF.seq := 99999; // 1 is returned by the gateway in event of a timeout so we need to set it to something different
SELF := [];)]);

applyOptOut := ~isFCRA; // Temporary variable to enable Targus opt out
// targus and targuse3220 should have the same url
targus_gateway_cfg := gateways(servicename='targus')[1];
makeGatewayCall := targus_gateway_cfg.url!='';


targus.layout_targus_in prep_for_Targus(indata le) := transform
	SELF.user.GLBPurpose := glb;
	SELF.user.DLPurpose := dppa;
	SELF.user.QueryID := (string)le.seq;
	SELF.searchby.ConsumerName.Fname := le.fname;
	SELF.searchby.ConsumerName.Lname := le.lname;
	SELF.searchby.PhoneNumber := le.phone10;
	SELF.options.IncludePhoneDataExpressSearch := TRUE;
	SELF.options.IncludeNameVerificationSearch := FALSE;
	SELF := [];
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

	history_mode := le.historydate<>risk_indicators.iid_constants.default_history_date and le.historydate<>0;
	history_date := risk_indicators.iid_constants.MonthRollback((STRING6)le.historydate, 1); // last/first seen is history date minus 1 month so it won't be filtered
	effective_date := if(history_mode, (STRING6)history_date+'01', (STRING8)Std.Date.Today());
	
	SELF.targusgatewayused := if(rt.response.header.queryid!='' AND rt.response.header.queryid!='1' ,true, skip);
	SELF.targustype := if(hitPDE,Phones.Constants.TargusType.PhoneDataExpress, Phones.Constants.TargusType.NameVerification); 
	SELF.phone10 := if(hitPDE, le.phone10, '');
	SELF.area_code := if(hitPDE, le.phone10[1..3], '');
	SELF.phone7 := if(hitPDE, le.phone10[4..10], '');
	SELF.p3 := if(hitPDE, le.phone10[1..3], '');
	SELF.p7 := if(hitPDE, le.phone10[4..10], '');
	SELF.dt_first_seen := if(hitPDE, effective_date, '');
	SELF.dt_last_seen := if(hitPDE, effective_date, '');
	SELF.current_record_flag := if(hitPDE, 'Y', '');
	SELF.current_flag := if(hitPDE, true, false);
	SELF.business_flag := if((hitPDE and rt.response.PhonedataExpressSearchResult.NameType='Business'), true, false);
	SELF.listing_type_res := map(hitPDE => if(rt.response.PhonedataExpressSearchResult.NameType='Business', 'B','R'),'');
	SELF.listed_name := if(hitPDE, if(rt.response.PhonedataExpressSearchResult.NameType='Business', STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.BusinessName),''), '');
	SELF.name_first := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.FirstName), '');
	SELF.name_middle := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.MiddleName), '');
	SELF.name_last := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.LastName), '');
	SELF.prim_range := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.PrimaryAddressNumber), '');
	SELF.predir := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetPreDirection), '');
	SELF.prim_name := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetName), '');
	SELF.suffix := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetNameSuffix), '');
	SELF.postdir := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.StreetnamePostDirection), '');
	SELF.unit_desig := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.SecondaryAddressType), '');
	SELF.sec_range := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.SecondaryAddressNumber), '');
	SELF.p_city_name := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.PostOfficeCityName), '');
	SELF.st := if(hitPDE, STD.Str.touppercase(rt.response.PhonedataExpressSearchResult.State), '');
	SELF.z5 := if(hitPDE, rt.response.PhonedataExpressSearchResult.ZipCode, '');
	SELF.z4 := if(hitPDE, rt.response.PhonedataExpressSearchResult.ZipPlus4, '');
	SELF.src := 'TG';
	SELF := [];
end;

dirs := join(indata, gateway_result, left.phone10!='' and left.phone10=right.searchby.phonenumber, tran(left, right));

return dirs;

end;
							
EXPORT TargusWrapper(STRING GatewayURL,
															  STRING InputFirstName,
															  STRING InputLastName,
															  STRING InputPhone10,
															  UNSIGNED1 DPPA,
															  UNSIGNED1 GLB,
															  BOOLEAN isFCRA) := FUNCTION
		 TargusGateway := DATASET([TRANSFORM(Gateway.Layouts.Config, 
																 SELF.ServiceName := 'targus';
																 SELF.URL := GatewayURL; 
																 SELF := [];)]);
		 GatewayResults := TargusMAS(InputFirstName, InputLastName, InputPhone10, DPPA, GLB, isFCRA, TargusGateway);
		 ResultSet := ['TARGUS GATEWAY',(STRING)GatewayResults[1].targusgatewayused, (STRING)GatewayResults[1].src];
RETURN ResultSet;
END;

EXPORT GrabTargusURL(DummyVariable = '') := FUNCTIONMACRO
  Result := '' : STORED('TargusURL');
  RETURN Result;
ENDMACRO;

END;