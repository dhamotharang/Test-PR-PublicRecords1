﻿import _Control,STD;
export EnvironmentVariables := module

	export username := 'svc_pr_orbit_hpcc@mbs';
	export password := '0r61t79!';
	export serviceurl := 
		//if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			//'https://Orbit4.risk.regn.net/Orbit4/Orbit4Services/OrbitServicePR.svc',
			'https://bctwtorbit201.risk.regn.net:8082/Orbit4Services/OrbitServicePR.svc'
		;
	export serviceurlprod := 'https://orbitinsurance.noam.lnrm.net/Orbit4/Orbit4Services/OrbitServicePR.svc';
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