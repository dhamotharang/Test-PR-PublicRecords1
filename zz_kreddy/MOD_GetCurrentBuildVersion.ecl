EXPORT MOD_GetCurrentBuildVersion := module
	 

import STD;

SHARED InputRecForProd := record
	string envment{xpath('envment')} := 'P';
	string cluster{xpath('cluster')} := '';
	string location{xpath('location')} := '';
	string dsname{xpath('dsname')} := '';
end;

SHARED InputRecForCert := record
	string envment{xpath('envment')} := 'Q';
	string cluster{xpath('cluster')} := '';
	string location{xpath('location')} := '';
	string dsname{xpath('dsname')} := '';
end;

SHARED ddt_layout := record
	string datasetname {xpath('datasetname')};
	string envment {xpath('envment')};
	string location {xpath('location')};
	string cluster {xpath('cluster')};
	string buildversion {xpath('buildversion')};
	string keycount {xpath('keycount')};
	string releasedate {xpath('releasedate')};
end;

SHARED outrec := record
	ddt_layout;
end;

SHARED prodResults := SOAPCALL(
	'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx',
	'GetDeployedDatasets',
	InputRecForProd,
	dataset(outrec),
	xpath('GetDeployedDatasetsResponse/GetDeployedDatasetsResult/versionlist'),
	//dataset(outrec),
	NAMESPACE('http://lexisnexis.com/'),
	LITERAL,
	SOAPACTION('http://lexisnexis.com/GetDeployedDatasets')
);
			
SHARED certResults := SOAPCALL(
	'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx',
	'GetDeployedDatasets',
	InputRecForCert,
	dataset(outrec),
	xpath('GetDeployedDatasetsResponse/GetDeployedDatasetsResult/versionlist'),
	//dataset(outrec),
	NAMESPACE('http://lexisnexis.com/'),
	LITERAL,
	SOAPACTION('http://lexisnexis.com/GetDeployedDatasets')
);
	
	EXPORT File := prodResults + certResults;

	EXPORT consumerStmtKeys := 'ConsumerStatementKeys'+File(datasetname='ConsumerStatementKeys' and envment='Q')[1].buildversion;	

end;