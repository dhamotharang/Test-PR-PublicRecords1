import _Control;
export EnvironmentVariables := module

	export username := 'svc_pr_orbit_hpcc@mbs';
	export password := '0r61t79!';
	export serviceurl := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServicePR.svc',
			'https://orbitpr-qa.risk.regn.net/Orbit4Services/OrbitServicePR.svc'
		);
	export serviceurlprod := 'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServicePR.svc';
	export soapactionprefix := 'http://lexisnexis.com/Orbit/IOrbitServiceBase/';
	export soapactionprefixPR := 'http://lexisnexis.com/Orbit/IOrbitServicePR/';
	export namespace := 'http://lexisnexis.com/Orbit/';
	export statLogicalFilePrefix := '~ProfileStat::';
	export statLandingZoneFilePrefix := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'C:\\Orbit\\ProfileStats\\ProfileStat-', 
			'C:\\Orbit\\ProfileStats\\ProfileStat-'
		);
	export statLandingZoneServer := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'BCTWPIORBIT101.risk.regn.net',// - Alpha //'10.237.6.40', - Boca
			'10.176.142.45'
		);

end;