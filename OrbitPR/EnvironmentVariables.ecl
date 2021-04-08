import _Control,STD;
export EnvironmentVariables := module

	export username := 'svc_pr_orbit_hpcc@mbs';
	export password := '0r61t79!';

	export switchtonewversion := true : STORED('switchtonewversion');
	export serviceurl := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
		if (switchtonewversion,
			'https://OrbitPR.risk.regn.net/OrbitPR/OrbitPRServices/OrbitServicePR.svc',
			'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServicePR.svc'),
		if (switchtonewversion,
			'https://orbitpr-qa.risk.regn.net/Orbit4Services/OrbitServicePR.svc',
			'https://stg.orbit3.risk.regn.net/orbit3/Orbit3Services/OrbitServicePR.svc')
		);
		;
	export serviceurlprod := 'https://orbitinsurance.noam.lnrm.net/OrbitPR/OrbitPRServices/OrbitServicePR.svc';
	export soapactionprefix := 'http://lexisnexis.com/Orbit/IOrbitService';
	export  namespace :=   IF( STD.System.Util.PlatformVersionCheck('7.8') ,
		                                                   'http://lexisnexis.com/Orbit/',
		                                                  'http://lexisnexis.com/Orbit/" xmlns:orb="http://lexisnexis.com/Orbit/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays"  xmlns:i="http://www.w3.org/2001/XMLSchema-instance'
											);
	export statLogicalFilePrefix := '~ProfileStat::';
	export statLandingZoneFilePrefix := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'C:\\Orbit\\ProfileStats\\ProfileStat-', 
			'D:\\ProfileStats\\ProfileStat-'
		);
	export statLandingZoneServer := 
		if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'10.237.6.40',
			'10.121.145.163'
		);

end;