import _Control;
export EnvironmentVariables := module
	export domainname := 'LexisNexis';
	// Testing service url
	export serviceurl := if (_control.ThisEnvironment.Name = 'Prod_Thor',
												'http://aiorbit01.lexisnexis.com/OrbitServiceInsurance/OrbitService.svc',
												'http://lnrbctcesd001.br.seisint.com/OrbitServiceQA/OrbitService.svc');
	// Prod service url
	// export serviceurl := 'prod';
	export namespace := 'http://lexisnexis.com/';
	// soap action prefix
	export soapactionprefix := 'http://lexisnexis.com/IOrbitService/';

	export xmlns_  := '"http://schemas.datacontract.org/2004/07/OrbitDataContracts"';
	export xmlns_i := '"http://www.w3.org/2001/XMLSchema-instance"';
	export xmlns   := xmlns_ + ' xmlns:i=' + xmlns_i;		//to allow compound
	export getlz := if (_Control.ThisEnvironment.Name = 'Prod','prodlz01','unixland');
	export orbitpathprefix := if (_Control.ThisEnvironment.Name = 'Prod',
													'\\\\'+getlz+'\\data\\orbitprod\\',
													'\\\\'+getlz+'\\data\\orbittesting\\');
	export orbitcomponentpathprefix := if (_Control.ThisEnvironment.Name = 'Prod',
																'\\\\\\\\'+getlz+'\\\\data\\\\orbitprod\\\\',
																'\\\\\\\\'+getlz+'\\\\data\\\\orbittesting\\\\');

end;