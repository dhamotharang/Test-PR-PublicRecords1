import _Control;
export EnvironmentVariables := module

	export username := 'svc_pr_orbit_hpcc@mbs';
	export password := '0r61t79!';
	export serviceurl := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitService.svc',
			'https://10.121.145.163/Orbit3/Orbit3Services/OrbitService.svc'
		);
	export serviceurlprod := 'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitService.svc';
	export soapactionprefix := 'http://lexisnexis.com/IOrbitService/';
	export namespace := 'http://lexisnexis.com/';
	export statLogicalFilePrefix := '~ProfileStat::';
	export statLandingZoneFilePrefix := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'C:\\Orbit\\ProfileStats\\ProfileStat-', 
			'D:\\ProfileStats\\ProfileStat-'
		);
	export statLandingZoneServer := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'prod_dali.br.seisint.com',// - Alpha //'10.237.6.40', - Boca
			'10.121.145.163'
		);

end;