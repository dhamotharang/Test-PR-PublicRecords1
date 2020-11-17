IMPORT _Control,STD;
EXPORT EnvironmentVariables := MODULE

	EXPORT US_PR_QA_SERVICE_URL := 'https://qa.orbit3.risk.regn.net/orbit3/Orbit3Services/OrbitServicePR.svc';

	EXPORT username := 'svc_pr_orbit_hpcc@mbs';
	EXPORT password := '0r61t79!';
	EXPORT serviceurl := 
		IF (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServicePR.svc',
			'https://stg.orbit3.risk.regn.net/orbit3/Orbit3Services/OrbitServicePR.svc'
		);

//*************************************************************************************************************												
//** ECL copied from Insurance for Orbit Profile setup in PR  
//*************************************************************************************************************		
	EXPORT PRServiceURL := 
	if (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'https://orbitinsurance.noam.lnrm.net/Orbit3/Orbit3Services/OrbitServicePR.svc',
			'https://stg.orbit3.risk.regn.net/orbit3/Orbit3Services/OrbitServicePR.svc'
		);
		
	EXPORT serviceurlprod := 'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitService.svc';
	EXPORT soapactionprefix := 'http://lexisnexis.com/Orbit/IOrbitService';
  EXPORT soapactionprofile 	:= 'http://lexisnexis.com/Orbit/IOrbitServiceBase/';
	
	EXPORT  namespace := IF( STD.System.Util.PlatformVersionCheck('7.8') ,
		                           'http://lexisnexis.com/Orbit/',
		                           'http://lexisnexis.com/Orbit/" xmlns:orb="http://lexisnexis.com/Orbit/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays"  xmlns:i="http://www.w3.org/2001/XMLSchema-instance'
												 );

	EXPORT statLogicalFilePrefix := '~ProfileStat::';

	EXPORT statLandingZoneFilePrefix := 
		IF (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'C:\\Orbit\\ProfileStats\\ProfileStat-', 
			'D:\\ProfileStats\\ProfileStat-');
			
	EXPORT statLandingZoneServer := 
		IF (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'10.237.6.40',
			'10.121.145.163');
		
	EXPORT orbitServerInfo := 
			IF (_control.ThisEnvironment.Name = 'Prod_Thor', 
			'THOR-PROD',
			'Test-Env');
//*************************************************************************************************************												
//** ECL copied from Insurance for Orbit Profile setup in PR  
//*************************************************************************************************************			
	EXPORT updateme :=  'yes' : stored('update_Orbit3'); // skip orbit update
	
END;