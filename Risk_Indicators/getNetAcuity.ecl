import netacuity, riskwise, ut, gateway, dx_gateway, STD;

//Feature4 option is for Netacuity version 4, defaulting to false until the permanent move to version 4
export getNetAcuity(dataset(riskwise.Layout_IPAI) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 dppa, unsigned1 glb, boolean Feature4=True, boolean applyOptOut = False) := function

gateway_cfg	:= gateways(Gateway.Configuration.IsNetAcuity(servicename))[1];

sort_indata := SORT(indata, did, ipaddr, seq);

deduped_indata := DEDUP(sort_indata, did, ipaddr, seq);

gw_mod_access := Gateway.IParam.GetGatewayModAccess(glb, dppa);

pre_netacuity_in := IF(applyOptOut = TRUE, dx_gateway.parser_netacuity.NetAcuityOptOuts(deduped_indata, gw_mod_access, TRUE), deduped_indata);

// added a skip to remove records that don't have an input IP present so that it doesn't call netacuity unless it's there
netacuity.Layout_NA_In prep(pre_netacuity_in le) := transform
	ip := trim(le.ipaddr);
	self.NetAddress := if(STD.Str.FilterOut(ip[1],'0123456789')<>'' or ip='', SKIP, ip);
	self.user.GLBPurpose := (String)glb;
	self.user.DLPurpose := (String)dppa;
	self.user.QueryID := (String)le.seq;
	self.Options.Feature4 := Feature4;
	self := [];
end;

netacuity_in := project(pre_netacuity_in, prep(left));

// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie 
// ever decides to execute both sides of the IF statement.
makeGatewayCall := gateway_cfg.url!='' and count(netacuity_in)>0;

na_results := if(makeGatewayCall, Gateway.SoapCall_NetAcuity(netacuity_in, gateway_cfg, makeGatewayCall, Feature4), dataset([], netacuity.layout_NA_Out_v4));

riskwise.Layout_IP2O format_netacuity(na_results le) := transform
	
	//This maps the fields depending on whether feature4 is requested or not, if it is use the new edge fields.
	Country_temp := if(Feature4, le.response.edge.Country, le.response.Country);
	Region_temp := if(Feature4, le.response.edge.Region, le.response.Region);
	City_temp := if(Feature4, le.response.edge.City, le.response.City);
	Connectionspeed_temp := if(Feature4, le.response.edge.ConnectionSpeed, le.response.ConnectionSpeed);
	MetroCode_temp := if(Feature4, le.response.edge.MetroCode, le.response.MetroCode);
	Latitude_temp := if(Feature4, le.response.edge.Latitude, le.response.Latitude);
	Longitude_temp := if(Feature4, le.response.edge.Longitude, le.response.Longitude);
	ZipCode_temp := if(Feature4, le.response.edge.PostalCode, le.response.ZipCodeText);
	RegionDescription_temp := if(Feature4, le.response.edge.RegionDescription, le.response.RegionDescription);
	ContinentCode_temp := if(Feature4, le.response.edge.ContinentCode, le.response.ContinentCode);
	AreaCode_temp := if(Feature4, le.response.edge.AreaCodes, (string)le.response.AreaCode);
	CountryConfid_temp := if(Feature4, le.response.edge.CountryConfid, le.response.CountryConfid);
	RegionConfid_temp := if(Feature4, le.response.edge.RegionConfid, le.response.RegionConfid);
	CityConfid_temp := if(Feature4, le.response.edge.CityConfid, le.response.CityConfid);
	TimeOffsett_temp := if(Feature4, le.response.edge.GmtOffset, le.response.TimeOffset);

	//Fields not currently used
	// CountryCode_temp := if(Feature4, le.response.edge.CountryCode, le.response.CountryCode);
	// RegionCode_temp := if(Feature4, le.response.edge.RegionCode, le.response.RegionCode); 
	// CityCode_temp := if(Feature4, le.response.edge.CityCode, le.response.CityCode);
	// TwoLetterCountry_temp := if(Feature4, le.response.edge.TwoLetterCountry, le.response.TwoLetterCountry);
	// PostalConfid_temp := if(Feature4, le.response.edge.PostalConfid, le.response.PostalConfid);
	// InDst_temp := if(Feature4, le.response.edge.InDst, le.response.InDst);
	
	res := Country_temp='***' and Region_temp='***' and City_temp='private';
	hit := le.response.header.errmsg='' and ~res and trim(le.response.netaddress)<>'';
	
	self.seq := (unsigned)le.response.header.QueryID;
	self.ipaddr := le.response.netaddress;
	self.ipresponse := if(le.response.header.errmsg='', '', le.response.header.errmsg);  
	self.continent := map(ContinentCode_temp=1 => '1',
												ContinentCode_temp=2 => '8',
												ContinentCode_temp=3 => '3',
												ContinentCode_temp=4 => '2',
												ContinentCode_temp=5 => '4',
												ContinentCode_temp=6 => '5',
												ContinentCode_temp=7 => '7',
												'');					
	
	//self.continentcf := if(hit, le.response. , '');
	self.countrycode := if(hit, ut.Country_ISO3_To_ISO2(trim(STD.Str.ToUpperCase(Country_temp))), '');
	self.countrycodecf := if(hit, (string)CountryConfid_temp , '');
	self.state := if(hit, Region_temp, '');
	self.statecf := if(hit, (string)RegionConfid_temp, '');
	self.zip := if(hit, ZipCode_temp, '');
	self.domain := if(hit, le.response.domain, '');
	dot := STD.Str.Find(le.response.domain, '.', 1);
	domainlen := length(trim(le.response.domain));
	self.topleveldomain := if(hit, le.response.domain[dot+1..domainlen], '');
	self.secondleveldomain := if(hit, le.response.domain[1..dot-1] , '');
	
     proxy_type := if(hit,  STD.Str.tolowercase(le.response.proxy) , '');
	connection_type := if(hit, STD.Str.tolowercase(connectionspeed_temp), '');
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
	
	self.areacode := if(hit, AreaCode_temp, '');
	self.iptype := if(res, 'Reserved', '');
	self.ipregion := if(hit, Region_temp, '');
	self.ipregion_description := if(hit, RegionDescription_temp, ''); 
	self.ipregioncf := if(hit, (string)RegionConfid_temp, '');
	self.iptimezone := if(hit, (string)TimeOffsett_temp, '');
	self.ipcity := if(hit, City_temp, '');
	self.ipcitycf := if(hit, (string)CityConfid_temp, '');
	self.latitude := if(hit, (string)Latitude_temp, '');
	self.longitude := if(hit, (string)Longitude_temp, '');
	self.ipdma := if(hit, (string)MetroCode_temp, '');
	//self.ipdmacf := if(hit, le.response. , '');
	//self.ipmsa := if(hit, le.response. , '');
	//self.ipmsacf := if(hit, le.response. , '');
	//self.ippmsa := if(hit, le.response. , '');
	//self.ippmsacf := if(hit, le.response. , '');
	self.ipconnection := if(hit, Connectionspeed_temp, '');
	//self.iplinespeed := if(hit, le.response. , '');  medium, low, high, or blank
	//self.ipaol := if(hit, le.response. , '');
	//self.ipasn := if(hit, le.response. , '');
	self.ipcarrier := if(hit, le.response.isp , '');
	self.homebusiness := if(hit,le.response.HomeBiz, '');
	self := [];
end;

ret := project(na_results, format_netacuity(left));

riskwise.Layout_IP2O add_na(indata le, ret rt) := transform
	self.seq := le.seq;
	self.ipaddr := rt.ipaddr;
	ip := trim(le.ipaddr);
	ip_valid := if(STD.Str.FilterOut(ip[1],'0123456789')<>'' or ip='',false,true);
	self.ipresponse := if(le.seq!=rt.seq and ip_valid, 'Gateway Error', rt.ipresponse);
	self := rt;
end;

final := join(indata, ret, left.seq=right.seq, add_na(left,right), left outer);

// OUTPUT(na_results, NAMED('na_results'), OVERWRITE);

return final;

end;