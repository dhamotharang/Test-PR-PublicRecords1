import _Control;
export EnvironmentVariables := module 
	export domainname := 'LexisNexis';
	// Testing service url  -  All Data builds are to use the OrbitServicePR. Do use not OrbitServiceInsurance.
	export serviceurl := if (_control.ThisEnvironment.Name = 'Prod_Thor',
												'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServicePR.svc',			//Prod URL
												'https://qa.orbit3.risk.regn.net/orbit3/Orbit3Services/OrbitServicePR.svc');	//Dev URL

	export namespace := 'http://lexisnexis.com/Orbit/" xmlns:orb="http://lexisnexis.com/Orbit/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays"  xmlns:i="http://www.w3.org/2001/XMLSchema-instance';
	export updateme :=  'yes' : stored('update_Orbit3'); // skip orbit update
	// soap action prefix
	export soapactionprefix 	:= 'http://lexisnexis.com/Orbit/IOrbitServicePR/';
	export soapactionprofile 	:= 'http://lexisnexis.com/Orbit/IOrbitServiceBase/';

	export 	SOAPActionLogin 	:=	'http://lexisnexis.com/Orbit/IOrbitServiceBase/Login';
	export	ServiceUserName		:=	'svc_ccc_orbit_hpcc@mbs';
	export	ServicePassword		:=	'7lSo57vdy83H';
	export	ApplicationName		:=	'InsuranceUS';

	// export xmlns_  := 'http://schemas.datacontract.org/2004/07/OrbitDataContracts';
	// export xmlns_i := 'http://www.w3.org/2001/XMLSchema-instance';
	// export xmlns   := '"' + xmlns_ + '" xmlns:i="' + xmlns_i + '"';		//to allow compound	export
	export getlz := if (_Control.ThisEnvironment.Name = 'Prod','prodlz01','unixland');
	export orbitpathprefix := if (_Control.ThisEnvironment.Name = 'Prod',
													'\\\\'+getlz+'\\data\\orbitprod\\',
													'\\\\'+getlz+'\\data\\orbittesting\\');
	export orbitcomponentpathprefix := if (_Control.ThisEnvironment.Name = 'Prod',
																'\\\\\\\\'+getlz+'\\\\data\\\\orbitprod\\\\',
																'\\\\\\\\'+getlz+'\\\\data\\\\orbittesting\\\\');
	export string				statLogicalFilePrefix := '~ProfileStat::';
	export string				statLandingZoneFilePrefix 
																				:=	 if (_Control.ThisEnvironment.Name = 'Prod',
																								 '\\\\risk.regn.net\\BUS\\Orbit\\ProfileStats\\ProfileStat-',
																								 'D:\\ProfileStats\\ProfileStat-'); 
	export string				statLandingZoneServer 
																				:=	 if (_Control.ThisEnvironment.Name = 'Prod',
																								 '10.195.88.85',
																								 '10.121.145.163');
end;