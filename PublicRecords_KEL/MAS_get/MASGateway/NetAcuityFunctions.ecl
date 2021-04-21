IMPORT PublicRecords_KEL, Riskwise, Gateway, NetAcuity, UT, DX_Gateway, STD, Data_Services;

EXPORT NetAcuityFunctions := MODULE

//Feature4 option is for Netacuity version 4, defaulting to false until the permanent move to version 4
EXPORT NetAcuityMAS(STRING IPAddress, INTEGER LexID, dataset(Gateway.Layouts.Config) gateways = dataset([], Gateway.Layouts.Config), unsigned1 dppa = 0, unsigned1 glb = 0) := function

gateway_cfg	:= gateways(Gateway.Configuration.IsNetAcuity(servicename))[1];

NetAcuityInput := IF(gateway_cfg.url!='', DATASET([{1, IPAddress, LexID}], riskwise.Layout_IPAI));

gw_mod_access := Gateway.IParam.GetGatewayModAccess(glb, dppa);

pre_netacuity_in := dx_gateway.parser_netacuity.NetAcuityOptOuts(NetAcuityInput, gw_mod_access, gateway_cfg.url!='');

// added a skip to remove records that don't have an input IP present so that it doesn't call netacuity unless it's there
netacuity.Layout_NA_In prep(pre_netacuity_in le) := transform
	ip := trim(le.ipaddr);
	self.NetAddress := if(STD.Str.FilterOut(ip[1],'0123456789')<>'' or ip='', SKIP, ip);
	self.user.GLBPurpose := (String)glb;
	self.user.DLPurpose := (String)dppa;
	self.user.QueryID := (String)le.seq;
	self := [];
end;

netacuity_in := project(pre_netacuity_in, prep(left));

// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie 
// ever decides to execute both sides of the IF statement.
makeGatewayCall := gateway_cfg.url!='' and count(netacuity_in)>0;

na_results := if(makeGatewayCall, Gateway.SoapCall_NetAcuity(netacuity_in, gateway_cfg, makeGatewayCall), dataset([], netacuity.layout_NA_Out_v4));

riskwise.Layout_IP2O format_netacuity(na_results le) := transform
	res := le.response.edge.Country='***' and le.response.edge.Region='***' and le.response.edge.City='private';
	hit := le.response.header.errmsg='' and ~res and trim(le.response.netaddress)<>'';
	
	self.seq := (unsigned)le.response.header.QueryID;
	self.ipaddr := le.response.netaddress;
	self.ipresponse := if(le.response.header.errmsg='', '', le.response.header.errmsg);  
	self.continent := map(le.response.edge.ContinentCode=1 => '1',
												 le.response.edge.ContinentCode=2 => '8',
												 le.response.edge.ContinentCode=3 => '3',
												 le.response.edge.ContinentCode=4 => '2',
												 le.response.edge.ContinentCode=5 => '4',
												 le.response.edge.ContinentCode=6 => '5',
												 le.response.edge.ContinentCode=7 => '7',
												'');					
	
	//self.continentcf := if(hit, le.response. , '');
	self.countrycode := if(hit, ut.Country_ISO3_To_ISO2(trim(STD.Str.ToUpperCase(le.response.edge.Country))), '');
	self.countrycodecf := if(hit, (string)le.response.edge.CountryConfid, '');
	self.state := if(hit, le.response.edge.Region, '');
	self.statecf := if(hit, (string)le.response.edge.RegionConfid, '');
	self.zip := if(hit, le.response.edge.PostalCode, '');
	self.domain := if(hit, le.response.domain, '');
	dot := STD.Str.Find(le.response.domain, '.', 1);
	domainlen := length(trim(le.response.domain));
	self.topleveldomain := if(hit, le.response.domain[dot+1..domainlen], '');
	self.secondleveldomain := if(hit, le.response.domain[1..dot-1] , '');
	
     proxy_type := if(hit,  STD.Str.tolowercase(le.response.proxy) , '');
	connection_type := if(hit, STD.Str.tolowercase(le.response.edge.ConnectionSpeed), '');
	self.iproutingmethod := map(Proxy_Type in ['anonymous', 'transparent', 'hosting'] => '02',
						   Proxy_Type in ['aol'] => '03',
						   Connection_Type = 'satellite' => '06',
						   Connection_Type = 'wireless' => '10',
						   Connection_Type = 't1' => '12',
						   Connection_Type = 'broadband' => '13',
						   Connection_Type = 'cable' => '14',
						   Connection_Type = 'xdsl' => '15',
						   Connection_Type = 'dialup' => '16',
						   '11');
	
	self.areacode := if(hit, le.response.edge.AreaCodes, '');
	self.iptype := if(res, 'Reserved', '');
	self.ipregion := if(hit, le.response.edge.Region, '');
	self.ipregion_description := if(hit, le.response.edge.RegionDescription, ''); 
	self.ipregioncf := if(hit, (string)le.response.edge.RegionConfid, '');
	self.iptimezone := if(hit, (string)le.response.edge.GmtOffset, '');
	self.ipcity := if(hit, le.response.edge.City, '');
	self.ipcitycf := if(hit, (string)le.response.edge.CityConfid, '');
	self.latitude := if(hit, (string)le.response.edge.Latitude, '');
	self.longitude := if(hit, (string)le.response.edge.Longitude, '');
	self.ipdma := if(hit, (string)le.response.edge.MetroCode, '');
	self.ipconnection := if(hit, le.response.edge.ConnectionSpeed, '');
	self.ipcarrier := if(hit, le.response.isp , '');
	self.homebusiness := if(hit,le.response.HomeBiz, '');
	self := [];
end;

ret := project(na_results, format_netacuity(left));

riskwise.Layout_IP2O add_na(riskwise.Layout_IPAI le, ret rt) := transform
	self.seq := le.seq;
	self.ipaddr := rt.ipaddr;
	ip := trim(le.ipaddr);
	ip_valid := if(STD.Str.FilterOut(ip[1],'0123456789')<>'' or ip='',false,true);
	self.ipresponse := if(le.seq!=rt.seq and ip_valid, 'Gateway Error', rt.ipresponse);
	self := rt;
end;

final := join(NetAcuityInput, ret, left.seq=right.seq, add_na(left,right), left outer);

// OUTPUT(na_results, NAMED('na_results'), OVERWRITE);

return final;

END;

EXPORT NetAcuityWrapper(STRING IPAddress, STRING LexID, STRING GatewayURL, UNSIGNED1 DPPAPurpose, UNSIGNED1 GLBPurpose) := FUNCTION
		 NetacuityGateway := DATASET([TRANSFORM(Gateway.Layouts.Config, 
																 SELF.ServiceName := 'netacuity'; 
																 SELF.URL := GatewayURL; 
																 SELF := [];)]);
		 GatewayResults := NetAcuityMAS(IPAddress, (INTEGER)LexID, NetacuityGateway, DPPAPurpose, GLBPurpose);
		 ResultSet := ['NETACUITY GATEWAY',(STRING)GatewayResults[1].ipaddr, (STRING)GatewayResults[1].ipresponse, (STRING)GatewayResults[1].iptype];
RETURN ResultSet;
END;

EXPORT GrabNetAcuityURL(DummyVariable = '') := FUNCTIONMACRO
  Result := '' : STORED('NetAcuityURL');
  RETURN Result;
ENDMACRO;

END;